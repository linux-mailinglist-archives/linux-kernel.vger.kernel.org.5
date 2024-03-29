Return-Path: <linux-kernel+bounces-124349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CA89160F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3B42878A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C04AEC0;
	Fri, 29 Mar 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+zttx7G"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D50481C4;
	Fri, 29 Mar 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704684; cv=none; b=bvat0Fnv6WbHDQV6d2I6RADkrnPuznhYqnsBBw/3iyyLvqYUaQl7DlMTb1TaAS0Y1qy2tu094Swkk12vZAkZA+mRTAxxZtUFE6dGlZzurIwbhPaKYEV8FHDjjRNsPrBUC9fsM8OOdnerKeQMjYpj/4qrp4/Df62ak836SYUG/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704684; c=relaxed/simple;
	bh=63iNxtk4lD7pE/u82UB3a+JNBTGIwSkJR95cLKZoqKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa4XgkdRAy0byEPB82oZshtO/DOKAy7ymEl4Y6MwHUlVDmYokWHkWEgu3/JylxLKSuaMRDl844rzmNx9tGqoVS/woBj98MlPMTdx6GsBVEPMuV/g/oCe9g/FYY4ip1XGX5PKCK8yFZ/vkFxtW9nK2cPEn6rHJ1wK3DZGO1ShulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+zttx7G; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e08498aa43so640367241.3;
        Fri, 29 Mar 2024 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704682; x=1712309482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63iNxtk4lD7pE/u82UB3a+JNBTGIwSkJR95cLKZoqKA=;
        b=C+zttx7GGKWILaAHdYmIbqa/ceMikdAAjVIb885yuHlCe951b9T30F3/isfk5AjxC3
         SmXXbw59QrFL5vf8ewP1VHs6mWDxZIpoTIWHBCyXKgNPfBxAs1NorQfYX3tkcih44+GN
         JmJua9ErmJjFT8FiY1lY/E4YKpsmxpTdzEwuvpymii7sWFwlcIt+5z+CYJyZTFmwux1U
         D6yPt8jYMkPxeN2B9sl82BdwKk5VzDIVjKMoaKGchblHWXoC3xaU0gD47msA0lWGnNfW
         N9ZaonyAcrZFN7Q72UQQCX2jy8UfMUAfeWK4/K6r+QUUbYIO8DwzfM3zuTv/tsXwE8Ev
         PAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704682; x=1712309482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63iNxtk4lD7pE/u82UB3a+JNBTGIwSkJR95cLKZoqKA=;
        b=R8FrWI8lzd9FRuOHcOW37O8uX5VkOwUCYwQF5X1Sl0Q5mAxJaWyzUXBBpas1fMwj2N
         kHZwLNYFPM1E29k0OpMoAFzNPVwGnSxDA6ABuYrgV6wT9qNpo9HYpYsOMJazvnyBZnqa
         Cfnw782vMUzj0FJEhqI4dVSjJVKRN+bBerF+V4koivmeCMvAEh00KhlPgrMXJpedyHxQ
         GH4FH76c0lNVYIs6ssM4KeANFwV/nT0lyUWghKaKkFA3zYvSeZLp+XsYIxlnrHiQhVlp
         +253J5yR8Mm02s0z7rUV5GQqVpIBY+zAlc57ltskJtDmYrxW33mo0rDgBwhwz2Wioguk
         LjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIP8oQBdktmDF8u5xizgb/jftPwnnoTqBzT7V8zFUJ6EYj3JTqR5ieohpdaMv48ZZ5/jWI7UFOtXvo48U44Z/MTbMSzEQC8FM+pSGB
X-Gm-Message-State: AOJu0Yzf66Lu7SwV5Wcj1YNhVWwel67kTkph7oX76F8mmH8m9QrzqgM1
	jIRilt0IPzJe8yIxuMGqrTdC+LlEXstSkfWK8Z/rtFm1dxNMhBX4USmzrMGVbf84q8c6Ntk/ja9
	+n/pnfV/Kz8Gr59egCADjJhJkTlFWxj2991iPmQ==
X-Google-Smtp-Source: AGHT+IFTathg4WUm6NVDDd+MhmqDwg9RJgV30I1dr3qu3n/zcMY21rBzkMOyounSmV0BYd585slZwWQ4kpFarAj68oc=
X-Received: by 2002:a67:f85a:0:b0:476:b0b4:32b2 with SMTP id
 b26-20020a67f85a000000b00476b0b432b2mr1452874vsp.8.1711704681723; Fri, 29 Mar
 2024 02:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327162918.2426792-1-paweldembicki@gmail.com>
 <20240327162918.2426792-2-paweldembicki@gmail.com> <20240328190226.7aab8b76@kernel.org>
In-Reply-To: <20240328190226.7aab8b76@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Fri, 29 Mar 2024 10:31:10 +0100
Message-ID: <CAJN1KkxcX9dfhMVvQCFLosTgO5U2tAjvHEO-prViSacOB6DQRg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethtool: Add impedance mismatch
 result code to cable test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Eichenberger <eichest@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Shay Agroskin <shayagr@amazon.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 29 mar 2024 o 03:02 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Wed, 27 Mar 2024 17:29:13 +0100 Pawel Dembicki wrote:
> > This commit introduces a new result code:
> > ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH
> > which represents the results of a cable test indicating abnormal impeda=
nce.
>
> I'm not a cable expert but going purely by the language
> abnormal !=3D mismatch. Mismatch indicates there are two
> values we are comparing.

Impedance mismatch can be detected because some parts of the cable may
have different (abnormal) impedance, causing reflections at those
points. Ethernet cables should have a characteristic impedance of 100
Ohms, so any mismatch from this value is considered abnormal. I can
provide a rephrased version if the commit description was not detailed
enough.

