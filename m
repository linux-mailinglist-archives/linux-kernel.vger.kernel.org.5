Return-Path: <linux-kernel+bounces-99216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC06878503
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323231F26AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E665339A;
	Mon, 11 Mar 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1RFx7E1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACA52F7A;
	Mon, 11 Mar 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173900; cv=none; b=kTcUJcSjhUR6k0u8aTsSGf2uwcMwJ3iznY9uLmwbT1Hy/YI9zeF8zVNltPiJ4xovo62ScrNLl0RllxINmHdwCUGrVw7hHMS+Fix6GpcCmb+7YWzxxP2789t6JYsgfyh2mFeEvq8m2BiOL7XAdxqb9Myw6z5l1yxq7v04M6wbQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173900; c=relaxed/simple;
	bh=Z63M2qtRmsoORDDGsiHituFolPHyUqRANRs99zv7Bj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0noNFOgfcu5uALVKRan+Xm/U2plVyfpZ7Zsd/mR6g11MlGm1ZqaUY+6OLaZNRZC0I66akn9XiNY6TXpdogAW3lc8xUUWCCYi/eB5PYyOguBtGmxOo12gkedy+4pUmgcjOYcCPD1l14Q7N1pCPN/jAvokqkwCRBnU+ofa5wBA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1RFx7E1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc75972f25so31834435ad.1;
        Mon, 11 Mar 2024 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173898; x=1710778698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLrBGhe7wsl5ZpaEorBAyyM3bioG1G+HFT1P3PMx4Ps=;
        b=X1RFx7E1cdDmMvReL936edOnYONjUGAI2afktyXMmMtiaIIYffdrnYf7qXKVlltB78
         kAiTu6hmmqy4sKmOB9wJPs/WYw5iBpcmDLZwFi9x29cr9Zi2uJxtJ8GZ06yX8ZwPiYtm
         V7W9Tnxl3Ne7oXaqtWkhzVpaonhVX0xTfsUYH7FL7xQDE3k6FAXdtKU0bj5Pqi/tJBDP
         2jaQF5sjd8onUPwn8tc1cf6U5uXPxD+v1KX8+5d0h0yb4/jMv3ssN1kcuML/GKMibYX2
         z6DhjTyRVwqZdlMlctdbKhobJXqQLoB/H94eIO8zRcD1JkQBPC865o45lXGKndPpngQI
         xdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173898; x=1710778698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLrBGhe7wsl5ZpaEorBAyyM3bioG1G+HFT1P3PMx4Ps=;
        b=l1y2GBZPefCggRpZG5kd3IW0Qie9mOUG8K4Pv99xxB06LjP1Px/nprMFgi/A1cPjNT
         o0CZxNdan73n74JR9xkClLI/YoUHFZQgFQBgHMBYj4PjmU1azjECeOPvoPemGv7Hvla0
         JYCPvn5VwIQPvLi6PckiQrOK/L4YBRmfAIr3E7l57q1EGKXQ952Lq6Duykx0j0Z+EH++
         eOP7ENK5pX6WN7hj2CE34zIk55Ax/KY7y9WcbNNOzffB1rOSrvVL2gtLTq3bQj1W9ZNT
         5YQk2EFq8cRVujCebwEDxm4BxYzslTmf3tsIIMTcCF2anyhEAsI7B7AjMvhcI31pSf23
         E2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX/AXqircO6cRiQEk3JCBIjRxDS2kIfjxg04yMcVhwTUdY8OWWbS95Q0CNPS3+BiMRUXBRkSBAPtEFT92hDh46XkJN5zSM7O4qfHVcLxsJmzFbvf05vxot2AW8adUvFkphy2Y/2ed8lI/bW1Uyft2AG5PomIgHUVzATC/XCQvdXxru25u/pgKZw5BoBFBVM9ipgDDKW93efC072//RIH9c5ptw=
X-Gm-Message-State: AOJu0Yw9oYA1uBAnMP09EJ6Cu0iHSYhUKjJBDeJTMiHeOc2Y2nwgcnrX
	Jel/ODZWH1vy+yhTOiGBTos8qbiHz7n6yXF95n/rYO2mErjuKbyX
X-Google-Smtp-Source: AGHT+IErPlfMx5poCq+SnT9bISYfhyWkor5ZX2Itne7IbaQhePms5OCJ5PU9oKePxgFanDc4araU4w==
X-Received: by 2002:a17:903:124c:b0:1db:fc02:f96e with SMTP id u12-20020a170903124c00b001dbfc02f96emr1084198plh.24.1710173897743;
        Mon, 11 Mar 2024 09:18:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fa9b:d52c:840:abd4])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001db8f7720e2sm4012491plf.288.2024.03.11.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:18:17 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:18:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Message-ID: <Ze8uxmKoK3baQ5Ah@google.com>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
 <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
 <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>
 <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>

On Mon, Mar 11, 2024 at 11:26:16AM +0100, Karel Balej wrote:
> Krzysztof Kozlowski, 2024-03-10T21:35:36+01:00:
> > On 10/03/2024 12:35, Karel Balej wrote:
> > > Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
> > >> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> > >>> Dmitry,
> > >>>
> > >>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> > >>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> > >>>>> From: Karel Balej <balejk@matfyz.cz>
> > >>>>>
> > >>>>> Marvell 88PM886 PMIC provides onkey among other things. Add client
> > >>>>> driver to handle it. The driver currently only provides a basic support
> > >>>>> omitting additional functions found in the vendor version, such as long
> > >>>>> onkey and GPIO integration.
> > >>>>>
> > >>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > >>>>> ---
> > >>>>>
> > >>>>> Notes:
> > >>>>>     RFC v3:
> > >>>>>     - Drop wakeup-source.
> > >>>>>     RFC v2:
> > >>>>>     - Address Dmitry's feedback:
> > >>>>>       - Sort includes alphabetically.
> > >>>>>       - Drop onkey->irq.
> > >>>>>       - ret -> err in irq_handler and no initialization.
> > >>>>>       - Break long lines and other formatting.
> > >>>>>       - Do not clobber platform_get_irq error.
> > >>>>>       - Do not set device parent manually.
> > >>>>>       - Use input_set_capability.
> > >>>>>       - Use the wakeup-source DT property.
> > >>>>>       - Drop of_match_table.
> > >>>>
> > >>>> I only said that you should not be using of_match_ptr(), but you still
> > >>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
> > >>>> proper module loading support.
> > >>>
> > >>> I removed of_match_table because I no longer need compatible for this --
> > >>> there are no device tree properties and the driver is being instantiated
> > >>> by the MFD driver.
> > >>>
> > >>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
> > >>> compiled as module? If that is the case, given what I write above, am I
> > >>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
> > >>> to use here?
> > >>
> > >> Yes, if uevent generated for the device is "platform:<name>" then
> > >> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
> > >> sets it up (OF modalias or platform), but you should be able to check
> > >> the format looking at the "uevent" attribute for your device in sysfs
> > >> (/sys/devices/bus/platform/...). 
> > > 
> > > The uevent is indeed platform.
> > > 
> > > But since there is only one device, perhaps having a device table is
> > > superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
> > > fitting?
> >
> > Adding aliases for standard IDs and standard cases is almost never
> > correct. If you need module alias, it means your ID table is wrong (or
> > missing, which is usually wrong).
> >
> > > 
> > > Although I don't understand why this is even necessary when the driver
> > > name is such and the module is registered using
> > > `module_platform_driver`...
> >
> > ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.
> 
> I think I understand the practical reasons. My point was that I would
> expect the alias to be added automatically even in the case that the
> device table is absent based solely on the driver name and the
> registration method (*module*_*platform*_driver). Why is that not the
> case? Obviously the driver name matching the mfd_cell name is sufficient
> for the driver to probe when it is built in so the name does seem to
> serve as some identification for the device just as a device table entry
> would.
> 
> Furthermore, drivers/input/serio/ioc3kbd.c does not seem to have an ID
> table either, nor a MODULE_ALIAS -- is that a mistake? If not, what
> mechanism causes the driver to probe when compiled as a module? It seems
> to me to effectively be the same setup as with my driver and that does
> not load automatically (because of the missing alias).

Yes, ioc3kbd is broken as far as module auto-loading goes. It probably
did not get noticed before because the driver is likely to be built-in
on the target architecture.

I'll take patches.

Thanks.

-- 
Dmitry

