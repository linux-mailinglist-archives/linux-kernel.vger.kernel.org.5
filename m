Return-Path: <linux-kernel+bounces-4048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F8D81772E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9665E1F26EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7613D546;
	Mon, 18 Dec 2023 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWGuDOgc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E323D576;
	Mon, 18 Dec 2023 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1fae88e66eso373701366b.3;
        Mon, 18 Dec 2023 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702916114; x=1703520914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuQkvFoOE7DbmbVDS6evAusjIw9xKO/OIgcTSDhOMeo=;
        b=nWGuDOgcCtvNi+SOoTkkdmS+J/lK4NXerT4qi9EGCJiVnZaJttVqDuf7LqIAkC4c3c
         LuzIa/yrxQQNEPWkw5GuJm/Z4HlUP/QkOaGzgxsEVsQZCsF0aQZe+G5PNYQPAc+ZJX3F
         G6r74FMDiuCZR4iIRATvw1Flhxa+e2tuodKTCG0Li8M+hLY5F/vsP1V7P8BdwHIXRFDE
         bnvlZszQlB2bVCpnIobaRnsfsvcAbLR4RJDZls68Y7SRe1idJCmib4HCVhpZcydJjcXY
         gNwagJgknmKjSpxXhn2JrwHnkAJGVuNNncgTfMS7GyZVHeCPjFTdpyvXHyZKIdbiaz+n
         2B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916114; x=1703520914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuQkvFoOE7DbmbVDS6evAusjIw9xKO/OIgcTSDhOMeo=;
        b=RiKJKmo3KWOQaI6NpwpO4XJTXdh84PqILPHDcczu0GhxUD+1q2oY72aGf86h4+G2C6
         LuciRX5/njR7vWiH6NABvYk7HHfAA0UpKKecEnNyAPleHdDZ2uB33FI4FIQLsDSdZrOD
         dZWBgSevNgtr+xub+4DT/FIso4+pf9ijF6DBt3AXZvXsoezWQPhwGuwbDzYHvdU2ORq2
         0g2Gw8QveypG7nNGTa1CL8FsHFRndIU+jY2LqrNX0M/PwoZ8cHRaJa/VpFb2TnBIKQ2y
         jqei4ZT7puKJ305bE5Bo1D+0bBdj7N09PS/rrPFKF6ER47sDQqvYN9R7P6c9re3suJhF
         BGUQ==
X-Gm-Message-State: AOJu0YwDOAVw5ixz7SZOKtEu1XhXv+6l6Jerolx81/x80yRrRujphXxS
	ri+rx9JHwSxoMbJzcIRxuaeP3+8VMz/caQ==
X-Google-Smtp-Source: AGHT+IFwxKikc0VD/aflFLF5hsUj2htfh9cxPznr1qHGY/nVPfC2muHIz36ghByZC6hXFA3e5iP3eQ==
X-Received: by 2002:a17:906:51d8:b0:a23:6eb6:6b29 with SMTP id v24-20020a17090651d800b00a236eb66b29mr58860ejk.101.1702916114457;
        Mon, 18 Dec 2023 08:15:14 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id hg12-20020a1709072ccc00b00a2359f95ad8sm1230202ejc.37.2023.12.18.08.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:15:13 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Conor Dooley <conor@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] cpufreq: sun50i: Add D1 support
Date: Mon, 18 Dec 2023 17:15:12 +0100
Message-ID: <2710663.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20231218155345.476e71ea@donnerap.manchester.arm.com>
References:
 <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218-blabber-slapstick-ab7ae45af019@spud>
 <20231218155345.476e71ea@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 16:53:45 CET je Andre Przywara napisal(a):
> On Mon, 18 Dec 2023 14:55:30 +0000
> Conor Dooley <conor@kernel.org> wrote:
> 
> Hi,
> 
> > On Mon, Dec 18, 2023 at 12:05:41PM +0100, Brandon Cheo Fusi wrote:
> > > Add support for D1 based devices to the Allwinner H6 cpufreq
> > > driver
> > > 
> > > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > ---
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > index 32a9c88f8..ccf83780f 100644
> > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
> > >  
> > >  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> > >  	{ .compatible = "allwinner,sun50i-h6" },
> > > +	{ .compatible = "allwinner,sun20i-d1" },  
> > 
> > I thought the feedback in v2 was to drop this change, since the
> > devicetree has the sun50i-h6 as a fallback compatible?
> 
> Well, this is the *board* (fallback) compatible string, so we cannot assign
> it as we like. The whole (existing) scheme is admittedly somewhat weird,
> because we not only match on a particular device compatible
> (like allwinner,sun20i-d1-operating-points), but also need to blocklist and
> re-match some parts against the *board compatible*, owing to the
> cpufreq-dt driver. The board name is basically used as a placeholder to
> find out the SoC, because there is (or was?) no other good way - the
> CPU DT nodes don't work for this. Back when this was introduced, this was
> the "least worst" solution.
> 
> I don't remember all the details, and didn't find time yet to look into
> this in more detail, but fixing this is non-trivial. If this isn't 6.8
> material, I might have a look at this later this week/month.

I would say it's 6.9 material. -rc6 already passed and it's not yet aligned
with all maintainers.

Best regards,
Jernej



