Return-Path: <linux-kernel+bounces-138377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D989F050
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC73428345F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1672159593;
	Wed, 10 Apr 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPVcsxuJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27D15956F;
	Wed, 10 Apr 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746905; cv=none; b=rsZluHJbupMd0uDl6JQwr9K8XiP2kaEecCxO7rBDDEypnCmliaQE95k1hMlsGpcTzZITXy2qvNI/LFtLnSkI4I081Qnq5G9AmEn/V8nx+AEgbDTQ97fKR5mDNaAmtZCSSgOolwiqg3FUJB1jFwUL2tpWrvlTHFbhbAqdWCcMres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746905; c=relaxed/simple;
	bh=0GIExPDDJmkcKoTRQsN7KJdje7gDkY/f7sV07NtyAj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kG+8wmUg9sZ6WTqMgov9NC1bm1S6qkZLfwD1zh5FWFNNzzc5HM+Vzv9GB/9aBvwSn8SQZ70p+LJyfPyTHloxfqYemEL2l3zROTEiZvOVPkdUEqa2PGcyO6YVNtKT36oMAEbmrGLRZ4k/YAFBxbSAN1WTI/bZ969P2cP7si0Pr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPVcsxuJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so16149465e9.0;
        Wed, 10 Apr 2024 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712746902; x=1713351702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0GIExPDDJmkcKoTRQsN7KJdje7gDkY/f7sV07NtyAj8=;
        b=QPVcsxuJL+1+AhCn2gC7lJaC4QAYnu7VfGsVMZTy/QPA/cWuSTymF0hhpEJYdp1mK4
         X4ZgAEFnFHtLDJnMaz27R4Xwyi8yE9himgi/HftpXqxoK+wtd2QBm+YOOiQrqPS+zkdX
         ulWc/86AzP4vdMwXQjgIqAdd7tsCA9Xt+upomAL1ykPXtA1P6R1rt57X01xp/L+Kv4jz
         Hg15mW5SCNJTOQAYL+KJ+Z4925A14nXNin6/2VKUpnkithD+7FdfOjMBYAr+VV5NCnCv
         fxfgHxFrg3kiirKjtzERjjSzt4tkVCBk/P3bHsetFMnp3m1sBY86GUCZ/guUBQfVnA14
         wkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746902; x=1713351702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GIExPDDJmkcKoTRQsN7KJdje7gDkY/f7sV07NtyAj8=;
        b=DpJjDpV+LpWzh+/beaGBfU0ZnuLYD8CA5HIw8cF7Itfacn3y1yJMJRChavqr5BJll4
         htz51qAv5n1tbD701wOB1s07MKiR7zQcd3t+826cReNRaqRx7qtm/7cWBuDPxRsvKWf7
         7c/e5NmgNxjVHc4MqS1Dc6SWWwm9XDPcnUstqbuAmhc0Q9ZVDTNXXT/ZFYl9O1MLfHHh
         i6wzyieMO3aor/nYJqwnM6j0BlPSwT4uaj4O8OmVtO5uvkSwQoBwpCam/eZCznD48Pn+
         MU9dogzilIwI3PJf05HKgEWMGXScxAvV3CeSSzY1OwL05EMElYNsjv8ypVopqPqx/6vx
         c7uw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8XqRTbi1Z9HVNUyIxe3mRaAfTPVSMsfEFMbZCeEI9PRPR6AGskowCPSngORWPU601QCHgKzp55pGmRQAuLkoHmIiD17HH9pe1Y6DyBoPgGNWVERyQEHUkF5tIDwCBSgKzzNE/zPHV47Ly68AEDQnNIlnTY/oaI0pIfM0qLmNpA==
X-Gm-Message-State: AOJu0Yy9cSRY08KZYdMCepW4QnHfIbXXT7YhIgDTjt1er/VoAJ5XuaTm
	JQvoUiV1fbrKsPe/nnBicSeyjo4xEmqOg+7a3R7oK0BbSjeHupPs
X-Google-Smtp-Source: AGHT+IHKoa80tndzG5LjQajNgoSTiqx34Q91ukfSPKmqksag+EAzMft0lIfxggHx5b0NmLu7IA3Azw==
X-Received: by 2002:a05:600c:4ed0:b0:416:2bb6:cbea with SMTP id g16-20020a05600c4ed000b004162bb6cbeamr4583319wmq.19.1712746901595;
        Wed, 10 Apr 2024 04:01:41 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:5844:d7c8:2851:cad9? ([2001:8a0:e622:f700:5844:d7c8:2851:cad9])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b00416b64fa212sm1895234wmo.34.2024.04.10.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 04:01:41 -0700 (PDT)
Message-ID: <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Vitor Soares <ivitro@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 10 Apr 2024 12:01:39 +0100
In-Reply-To: <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
	 <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
	 <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lucas,

On Tue, 2024-04-09 at 17:44 +0100, Vitor Soares wrote:
> On Tue, 2024-04-09 at 16:36 +0200, Lucas Stach wrote:
> > Am Dienstag, dem 09.04.2024 um 14:22 +0100 schrieb Vitor Soares:
> > > Hi Lucas,
> > >=20
> > > Thanks for your feedback.
> > >=20
> > > On Tue, 2024-04-09 at 11:13 +0200, Lucas Stach wrote:
> > > > Hi Vitor,
> > > >=20
> > > > Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor
> > > > Soares:
> > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > >=20
> > > > > The pgc_vpu_* nodes miss the reference to the power domain
> > > > > parent,
> > > > > leading the system to hang during the resume.
> > > > >=20
> > > > This change is not correct. The vpumix domain is controlled
> > > > through
> > > > the
> > > > imx8mm-vpu-blk-ctrl and must not be directly triggered by the
> > > > child
> > > > domains in order to guarantee proper power sequencing.
> > > >=20
> > > > If the sequencing is incorrect for resume, it needs to be fixed
> > > > in
> > > > the
> > > > blk-ctrl driver. I'll happily assist if you have any questions
> > > > about
> > > > this intricate mix between GPC and blk-ctrl hardware/drivers.
> > > =C2=A0
> > > I'm new into the topic, so I tried to follow same approach as in
> > > imx8mp
> > > DT.
> > >=20
> > That's a good hint, the 8MP VPU GPC node additions missed my radar.
> > The
> > direct dependency there between the GPC domains is equally wrong.
> >=20
> > > I also checked the imx8mq DT and it only have one domain for the
> > > VPU in the GPC. It seem blk-ctrl also dependes on pgc_vpu_* to
> > > work
> > > properly.
> > >=20
> > > The blk-ctrl driver hangs on imx8m_blk_ctrl_power_on() when
> > > access
> > > the
> > > ip registers for the soft reset. I tried to power-up the before
> > > the
> > > soft reset, but it didn't work.
> > >=20
> > The runtime_pm_get_sync() at the start of that function should
> > ensure
> > that bus GPC domain aka vpumix is powered up. Can you check if that
> > is
> > happening?
>=20
> I checked bc->bus_power_dev->power.runtime_status and it is
> RPM_ACTIVE.
>=20
> Am I looking to on the right thing? It is RPM_ACTIVE event before
> runtime_pm_get_sync().

During the probe I can see that
bus_power_dev->power.runtime_status =3D RPM_SUSPENDED and then vpumix is
powered up on GPC driver.

On resume routine I can't see this flow. bus_power_dev-
>power.runtime_status =3D RPM_ACTIVE and vpumix end up not being powered-
up.

I checked the suspend flow and the GPC tries to poweroff vpumix.


Best regards,
Vitor Soares

>=20
>=20
> >=20
> > Regards,
> > Lucas
> >=20
> > > Do you have an idea how we can address this within blk-ctrl?
> > >=20
> > > Best regards,
> > > Vitor
>=20


