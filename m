Return-Path: <linux-kernel+bounces-125640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477928929F1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F469282EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E6BE6E;
	Sat, 30 Mar 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlfM16zE"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC5BE5B;
	Sat, 30 Mar 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790023; cv=none; b=sSfZ0vMZkUpB9Fv6YwZpcx3oiI7ZvPdoA5+QMFynKMH+NTESPqEzMlapB0K9iMXsHCAw65EImJLVxRdV7P6dxiMSoKs2ik9r1xg0f1NUrglI7KgjyX9RoQyE+DLn1h76hnxn60YgCsDdj1RAcz80lF9sNKWLBsEglUprk23I6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790023; c=relaxed/simple;
	bh=hIGkWcRgPIXfZX1MS8KL8rPU2YJQXR4pomTjCTD1Y+o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULbm08ZR/8XH7g9S5flMRxS2mRRJo5AX5FvBPXZx0N2LwC5TaxPCv9m9EXGAnKN6R4Cc+XCmATJT3agzgQ8mu3lq4esKuVoYEGHVX2Wjy46axjMdyhd7jMsBpi9TZDaCkyKFd/3COd4N9ewm1xsuJUd4zq96fFKrmvtJPK09IQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlfM16zE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41553b105b8so5924485e9.3;
        Sat, 30 Mar 2024 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711790020; x=1712394820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWGcxGDGq3xifasgBFf2SllwrhRtj5a20lnw94qc54Q=;
        b=JlfM16zE1RQ8l+xG/AtH6DCCf/mWKgQAddFtV2noKP1nIvD0sERZ8l/bZxKJkDoEaT
         K3715GVW7px79pD6pMzYLmVpE4xb1z1skFpXTv5sC5YkIZ89im/2UJTggAYvrNBozcn2
         rJlKbbgVXr7bqjlpWlVRerfckE6R4aG3LSb5+mIOAB6EJA42E695WDQiC/Hudr4xlg2K
         CR7mxHr3Esw+BcZ7j1e1B/8jpBBWx8/bUgmYJhR9UXd3rWnZiSJJUpklrRQfSz1r59eN
         aZ0HOh8+Vp+2Ijb0KXsfk2JPjsOavWqdPutodKE1JoffK++PmIuJJUr6diLwhuuWgdYR
         Ustw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711790020; x=1712394820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWGcxGDGq3xifasgBFf2SllwrhRtj5a20lnw94qc54Q=;
        b=A8iK4SI88fWdvSs5++s/PzUdDsW6ofximrEExT9fw8CgekItAboLeMcnXUcL31UlKf
         NRQcFOkOCsw5qTG44BOGHPNfuWhX3wUwpKUCrlDhM082ZIygQBP6Gj9Yp9RgjKD3W4Jb
         cmS/KZNcZs5SEHvoK8UwpOiZEBqhAidVnh4NYrRulHSIpAL+uy8MeFu0VYMQH6NYgYDi
         e0zXV3CdOsOuQlVsvLzOLdIqkRBhwJ5Oun0WDPpIRfzrCEFS9KjFCSlEZWGuSqB3eTnx
         pAs+FsmVDzU531Ja2TZU8QsC4jVFn2Exo4L/xvpjiaOr+GUHAdtqpP2hSwBxEsNlPPwS
         CE4g==
X-Forwarded-Encrypted: i=1; AJvYcCW6BtvXPKZPSx+ZtJWumaokTsoExxCDRlQEySDt5D8C8fkTdkqwRfBReR+PSfcqL/KU+gaitzxzmQyUgBst1sIBO5deI3XMNXu/bVPGg6PfFK4wfhhAxd7ggIsZLea4JORRR/7f
X-Gm-Message-State: AOJu0YwyfE0JJsYzA20xBoaXoCE2omXRIXNusnJWZsdn/gfm0ExGX03o
	B00Ddsf/8moF7PPYadsXse70GRckdwHGAHUtX73oWaOKg/WcXCOr
X-Google-Smtp-Source: AGHT+IEFg1PCtfc0ais3QcJd/zwznPWHY+i4QrwBtyXVy6XGZcTwh0pDVlKiHAYbNtSIUepg0CfukQ==
X-Received: by 2002:adf:f091:0:b0:343:34af:2954 with SMTP id n17-20020adff091000000b0034334af2954mr2009357wro.28.1711790019576;
        Sat, 30 Mar 2024 02:13:39 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-165-123.retail.telecomitalia.it. [87.1.165.123])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0034174566ec4sm6010243wri.16.2024.03.30.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 02:13:39 -0700 (PDT)
Message-ID: <6607d7c3.df0a0220.498b4.86f3@mx.google.com>
X-Google-Original-Message-ID: <ZgfXv53uqXH-gnUI@Ansuel-XPS.>
Date: Sat, 30 Mar 2024 10:13:35 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
 <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>
 <66057c71.050a0220.e4ba.97dc@mx.google.com>
 <a4632f1ba701f6b333c50a5366723cf4@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4632f1ba701f6b333c50a5366723cf4@milecki.pl>

On Thu, Mar 28, 2024 at 03:44:15PM +0100, Rafał Miłecki wrote:
> On 2024-03-28 15:19, Christian Marangi wrote:
> > On Wed, Mar 27, 2024 at 11:15:02PM +0100, Rafał Miłecki wrote:
> > > On 22.03.2024 05:09, Christian Marangi wrote:
> > > > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > > > index 5887feb347a4..0de87bc63840 100644
> > > > --- a/drivers/mtd/mtdcore.c
> > > > +++ b/drivers/mtd/mtdcore.c
> > > > @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
> > > >   	config.name = compatible;
> > > >   	config.id = NVMEM_DEVID_AUTO;
> > > >   	config.owner = THIS_MODULE;
> > > > -	config.add_legacy_fixed_of_cells = true;
> > > > +	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
> > > >   	config.type = NVMEM_TYPE_OTP;
> > > >   	config.root_only = true;
> > > >   	config.ignore_wp = true;
> > > 
> > > I think there may be even more unwanted behaviour here. If
> > > mtd_otp_nvmem_register() fails to find node with "user-otp" /
> > > "factory-otp" compatible then it sets "config.of_node" to NULL but
> > > that
> > > means NVMEM core still looks for NVMEM cells in device's "of_node".
> > > 
> > > I believe we should not look for OTP NVMEM cells out of the
> > > "user-otp" /
> > > "factory-otp" compatible nodes.
> > > 
> > > So maybe what we need in the first place is just:
> > > config.add_legacy_fixed_of_cells = !!np;
> > > ?
> > > 
> > > Any extra limitation of .add_legacy_fixed_of_cells should probably be
> > > used only if we want to prevent new users of the legacy syntax. The
> > > problem is that mtd.yaml binding allowed "user-otp" and "factory-otp"
> > > with old syntax cells. It means every MTD device was allowed to have
> > > them.
> > > 
> > > No in-kernel DTS even used "user-otp" or "factory-otp" with NVMEM
> > > legacy
> > > cells but I'm not sure about downstream DTS files. Ideally we would do
> > > config.add_legacy_fixed_of_cells = false;
> > > but that could break compatibility with some downstream DTS files.
> > 
> > Yes the main problem is prevent regression in downstream. I feel for the
> > nand usage, this is 100% of the times broken. For SPI and other corner
> > case MTD devices it's not?
> > 
> > Anyway did you by chance have a suggestion for a better fixes tag?
> 
> My personal idea for that would be to put two Fixes with two commits and
> describe in commit body that one just exposed existing bug.
> 
> You may check my OpenWrt quick patch for an idea how I'd handle that:
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-6.6/440-mtd-don-t-look-for-OTP-legacy-NVMEM-cells-if-proper-.patch;h=d9d15a4048c144d8565c8ea38e15a79f7f4a5fe1;hb=dd78a59cd7b029560b33cb3ac0e1aa8b747bd807
>

My concern is that using !!np might pose some regression problem. Also I
feel adding the macronix commit in fixes tag might be confusing?

Think I will just use the nand check just to be extra safe and add a
kernel dependency for when the add_legacy_fixed_of_cells was introduced
since before that a different patch is needed. What do you think?

-- 
	Ansuel

