Return-Path: <linux-kernel+bounces-62904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871818527B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A50F1F23374
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2FB676;
	Tue, 13 Feb 2024 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqFlV27b"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BAB647;
	Tue, 13 Feb 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794290; cv=none; b=ARTnbuQRc6+hKfGI+TCm/yMm/H+V/kQpA2M7NTO+whKj1XcBDS5cNBqID2e6UVkQNhd85idBk+lN59lBHIkmLqAADg/yxDmp+HjDriIU231Spg+9y5OUlxYputzBzeYXg0wsqkoO0GLKKcUEAyKofn+kj9I3Ci0bWJaB5VgwIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794290; c=relaxed/simple;
	bh=fP0PaPIcWn8pLdYBqnWeRtv2zxUoAB49A4nEIgjq7R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWlv6tl3VQ+sdYdJYJMobw+CNy8CyV1llt4Y01w4vXfn4qKumE8ONYg1xPdUNeCX47MTp8mMF1AHNc6nvDlL3p6ZerPpYD64kNq/LWsH2tDCTMbsW17lH3Ovu5vchJjV2aKqXGFnl3r3tyY7OaJOdy6z5U7xtbQWvPH01+/c9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqFlV27b; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddca59e336so2156011a34.0;
        Mon, 12 Feb 2024 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707794287; x=1708399087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buWiuQLtEG0HusXViotHeqASAJmkJh5K8Fj/0Hr7F7E=;
        b=UqFlV27bbwwFLi+6Phu0z0iq8hsuWMAn21ctkl+tuFuUPf6meBDHxwIVjItXPFKIVQ
         4slIH/kgEq9kvIxcdnzm5nwJuJ47X0qcVNDbnCKrFiS1ToNEh0eyAJzjwzpk6QZFKL+f
         ys7WgM5/8dGdKomDb+noOZOap7+F2kvXTlbnwoCgYBq64x08th/5+33XzVILdJfUmvp+
         d/uiszOAFMGPcUpA3AXjs5wUMLtkMPyX0IVwDCu8A47VVAnJaOheHlm/IoJdEHukQBms
         5tUD0ZdwBqdyz6QpmpmwgR6WUfSZalz/UipnA4FpZbm3iljSH7iCnhtZNM7uo+51a2vh
         wqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707794287; x=1708399087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buWiuQLtEG0HusXViotHeqASAJmkJh5K8Fj/0Hr7F7E=;
        b=gjEurq28AoDcPbtpaDe29bJ0L5NCf8qdnQomNnHn+lhWF4bBojU4bLMZVKq6AYCHsO
         YFOYYwOpGw0O0gZW8P79r4mik/MIo0VkxEM8JSmXjnXev11tDuonEuEYsmEVivsafUtL
         GsItjynenWsS85VWh/5UzFVwZDuyskgCPrPQ+/XM9uFTrDW2Ikr7xU2NSzMgMVDnPdAB
         V4xmIRG/go7qTCwqqkue0XxjRq5+fz2ccvIG8bsbkRHRjaWKCM0HYm7Eq5fVX2YX2jqx
         8RxVCjJjoLzYFEws1BGLBvpN0k+meRd+pC1F4FuyUH+Dwrf56PYjmG65PsRLIKvKwOe0
         oQEg==
X-Forwarded-Encrypted: i=1; AJvYcCUmmkALdSdOnTGEst3q2QGlhhe7fPe3uRbRgvQCblcY5yqIRdqjscpR6olNKRZ7Gepl5snanNcrNnFuX+E17+n2fAASUANSTTv9dVuR1ZZMidEoqwBouoQAx7tlpPLKJ1kJ/n67
X-Gm-Message-State: AOJu0YzdE7u4STQ26EAZob+M3cqMGavEEtjyi/EUxC9JyYru2LG+0Bf1
	EtYd+DLOjiuW9EE2FHF8gwjQ2QP0aXyl4ZmKF69hchsoMSA4zzaYdvX/LNVa2FeJBI+Svi0j8WO
	sxfKO6WFxMEWBu2jb7GlPIHD9Yao=
X-Google-Smtp-Source: AGHT+IFsDCKIZ/Mghgl62IGADaTeYUyjJq1JBce3qr399uzR/EZBz9gmmVRMmPf+GgDbZZVP5nRV6vGMfv3k+Qg7pYA=
X-Received: by 2002:a9d:6185:0:b0:6e2:e35b:549a with SMTP id
 g5-20020a9d6185000000b006e2e35b549amr516005otk.8.1707794287613; Mon, 12 Feb
 2024 19:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208221802.131087-1-jmaxwell37@gmail.com> <135d4123-29f5-46dd-b06e-d5a66bd7f598@lunn.ch>
In-Reply-To: <135d4123-29f5-46dd-b06e-d5a66bd7f598@lunn.ch>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Tue, 13 Feb 2024 14:17:31 +1100
Message-ID: <CAGHK07BT5z+iEGMG+vdBAi24B5UwE7nTh1ZfrbM5u092jEPAJg@mail.gmail.com>
Subject: Re: [net-next v2] intel: make module parameters readable in sys filesystem
To: Andrew Lunn <andrew@lunn.ch>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 4:19=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Feb 09, 2024 at 09:18:02AM +1100, Jon Maxwell wrote:
> > v2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
> >     It's not really needed as ethtool msglvl can control that.
>
> It is normal to places comments like the above under the ---. In its
> current place, it will be part of the commit message. Under the --- it
> gets dropped when the patch is applied.
>

Thanks Andrew I will resubmit tomorrow with that change.

>     Andrew
>
> ---
> pw-bot: cr

