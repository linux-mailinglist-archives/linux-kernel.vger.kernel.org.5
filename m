Return-Path: <linux-kernel+bounces-12767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BA81F9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2B51F243FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C8F51A;
	Thu, 28 Dec 2023 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppv5Kc72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91CF4E1;
	Thu, 28 Dec 2023 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5d05ff42db0so53085917b3.2;
        Thu, 28 Dec 2023 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703779173; x=1704383973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVlq7DVtkYMFVcKQ9OTWr3F0Se96zgvlu8hOUc93pE0=;
        b=Ppv5Kc72raExgjl4dWjiAMXrTKbo05mwvorlbWy3EUvWf71Rbh7uR/Xb/f+bDSLPz4
         6DntvnFPmTXjbqPWC3ASphZv+rYyO/KAUoqL7yiy8dcbk4innNbx/jHt0xSfijgbn0gG
         lhxxBiTQM/B/KyAy06+/WK5H8ywbB2cm/UsPX6+7jbKiNgLbmjxiz7vfaQuruEJn467k
         G9Tq0X7UZK05P0GIMPYBQ/5ywpQhrG785vHYkcxdWfPOwKHpzTq5pSoM/pR111o+1K7X
         vwrQkr46aqQchFSGwCkgSEEIKEO1A51y7it4DKPiZSzxai98U1+pzVrbXGp9AtT0VdAu
         SJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703779173; x=1704383973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVlq7DVtkYMFVcKQ9OTWr3F0Se96zgvlu8hOUc93pE0=;
        b=CaoFbpe0qW8Idn9DNfiu4xHXoosKJMTICU+a0emDlwMPoTbEGTGwS1RZqRkXq9mZbd
         4yPoh9Bm6poJmXFxbsaejzz6qi45Bma7yIj6CRRhKw1C2F4IKM6jUAUkKvKw18bQs6Pr
         BHm+NcVb/9PSjsa3EdDiqiik5RHmLxYpRrQFya6DPox61j0InbEkUa4HWRGaaHzsLZGf
         Ta8nZvoHAcS0xAzA/W2CgZECAPe35ffxIHXWx5NndeQVvT/BxPLC+NdjvA5fi4t8AsTU
         9aq7GZerZ6PHDVUDrwpnL/GylZ95bTZTa1RMqfrm58OTEHWeSHxuiEmoHsk6ahd43YeD
         /Sdw==
X-Gm-Message-State: AOJu0YxWodtQQwQsjmDeFyXVnJYX304i5sWhYyNJ9Ue+EJ2DEes0pXMY
	Zq/ANbQEQeMl98s+/i18OcKoIZxrcJds92JHfLg=
X-Google-Smtp-Source: AGHT+IE8n3oYZ5R2LDPhAOxhummRKsaEwA2M8Gn8AOHI0pVTdFih5TII33+bSs8PWE58xsJQY/7+ZN1T3Juaxa/x/sE=
X-Received: by 2002:a0d:c983:0:b0:5d7:1941:2c33 with SMTP id
 l125-20020a0dc983000000b005d719412c33mr6505582ywd.96.1703779172672; Thu, 28
 Dec 2023 07:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223211306.GA215659@kernel.org> <20231224024725.80516-1-brad@faucet.nz>
In-Reply-To: <20231224024725.80516-1-brad@faucet.nz>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 28 Dec 2023 10:59:21 -0500
Message-ID: <CADvbK_dpD+rTPr4acbvmHu91OHtgynzJ4Ru3+d+rw7njmOPeww@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nf_nat: fix action not being set for all
 ct states
To: Brad Cowie <brad@faucet.nz>
Cc: horms@kernel.org, aconole@redhat.com, coreteam@netfilter.org, 
	davem@davemloft.net, dev@openvswitch.org, edumazet@google.com, fw@strlen.de, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 9:48=E2=80=AFPM Brad Cowie <brad@faucet.nz> wrote:
>
> On Sun, 24 Dec 2023 at 10:13, Simon Horman <horms@kernel.org> wrote:
> > Thanks Brad,
> >
> > I agree with your analysis and that the problem appears to
> > have been introduced by the cited commit.
>
> Thanks for the review Simon.
>
> > I am curious to know what use case triggers this /
> > why it when unnoticed for a year.
>
> We encountered this issue while upgrading some routers from
> linux 5.15 to 6.2. The dataplane on these routers is provided
> by an openvswitch bridge which is controlled via openflow by
> faucet. These routers are also performing SNAT on all traffic
> to/from the wan interface via openvswitch conntrack openflow
> rules.
>
> We noticed that after upgrading the linux kernel, traceroute/mtr
> no longer worked when run from clients behind the router.
> We eventually discovered the reason for this is that the
> ICMP time exceeded messages elicited by traceroute were
> matching openflow rules with the incorrect destination ip,
> despite there being an openflow rule to undo the nat.
> Other packets in the established or new state matched the
> expected openflow rules.
>
> A git bisect between 5.15 and 6.2 showed that this change in
> behaviour was introduced by commit ebddb1404900. After the
> above patch is applied our routers perform nat correctly
> again for traceroute/mtr.

Acked-by: Xin Long <lucien.xin@gmail.com>

