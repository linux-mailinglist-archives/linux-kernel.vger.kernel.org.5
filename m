Return-Path: <linux-kernel+bounces-98343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B478778A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A0228147B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51B3A8CB;
	Sun, 10 Mar 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGQVc6i2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E354200A6;
	Sun, 10 Mar 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710107341; cv=none; b=oDnGNrpkdnEHiv1mRDfKCojnRq/gzf7QkyFo4EyGeEuMPIoE6Twc+AZH42n/fOF2qPhshSlkGrbodMXiGA1U3481lcSYFpzwveL1+8GbLp4DlMFq0mlr4BLgCyd8r4MPCkiwirJ2kE4x4BrIs1REDkl9LDzcw3npB4G8BJHSmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710107341; c=relaxed/simple;
	bh=uiNUIQwX6BYiGbEKIo6u+t0/etIbRR33V5TSPTk94m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYKIs5ydFn0rpQMuIsp6Ux3M+sHgfeQwo1asr74tpf4NaM+jsUdFmcG7Jsb/WVkayvpBQM8HVlGdU3IIYeXzA5aO/xS7/Efa5e1JJNiGXBzHG4+G4OvyFbTDTO2YKGhdUCROTRMrw4O80A53TIT0q9z6gO/SP1DnUZmX2vOOpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGQVc6i2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd68d4cff1so16395875ad.2;
        Sun, 10 Mar 2024 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710107338; x=1710712138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peiS13bUuIETlTVlJrUnJS9cAypcX9YXgZEjm2ZHlXk=;
        b=EGQVc6i2U7tItUa2Prnhd0di4K5hx19ZKfAM4A95LRb5bllQziS8Yv5sA6SaDJ+cZB
         fJCc3O5K4GO1Qc3/SeP79oKt96JKvrqkaNOHUBkADrQYFtcCrVS/E9JKp6npfTcc55Y0
         m/WuhA6asZpOO2Mc05Uf/5ARtNdH5Oy1rew/JukU98Eaz35W+GA9Zsab8W1aAu+THtJ5
         DP+/GxSHb9a5vquYivEvwU2iM/oq57sdWSPpi0GteTPPHe2ob0ovffxsKEd5QsYYfSUO
         zwMJk4Qx5n9sLbF/1qz6avXyIIN+VvBJ0Cv7j/53ya7tpUIq3CRdAVcT+kr3jTzfpyZe
         6u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710107338; x=1710712138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peiS13bUuIETlTVlJrUnJS9cAypcX9YXgZEjm2ZHlXk=;
        b=hMJqZYJ+rokbgt02arEW39IiC17ArDzGno2UNWUeqdwl1uss8aQSVr95Wy3o51lhER
         VETRrkyhBa/6dux+zXIHBW/NkHww7WK/Z8DFerB0stzpD/tcdCnoE5E+J8/q9Vd0ysXd
         AfZCPiFt4EMo6gNP+jt7Qkwhnc9kZALTET+SEZVQM1Ap4JiZsGybDxKl7ZMCdNlk8tnc
         RZnYVcGeeIpe4kLaEeUkSvZnw7ZLfVCZRi0GSBmCpAwKc2STZWzEoP4jLZjYg+muGpMl
         vvC50EWqiCrdh4lHIyPEgvxkiDzxrhuNirdHAwf0Q3MNTZ9LzU0i/AG27sFsBUwyhQry
         hGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy1e/no/CCS/nnyCa3GSliKamgxdZN4oaNnHXqVpgqMBGhkj+T6XCB3AqzSyky4smZIs4/ymjArE3E1phNjbLGFuPUqPwR2ulLvDgIk4VIUdoN441fahY6w57qKTLCEVhwqtiFeTJ57z46ndviH4A2nHGzabjvvXm/enezBkotq1KCugUAMpYRMlxExZ/rYVRFP9WIEvLBDDKijL8WVzQq9x8=
X-Gm-Message-State: AOJu0Ywoj0EvC7WuJ4d6x8+/jVPbyAns8T6ZdUyN3+w9OTGkAdFUYdf2
	yCc7MApmopr377EhrSD3AqNQ+f9M3T0lRSVBn49p2++Kq2MM67enkkghRCeI
X-Google-Smtp-Source: AGHT+IEWxxer7+GvZpSyC+KpPXhxra7vrWGJ3a2rsApHjdYvzkJ+rmWD+x1uxlAnk84alJSOjVn32w==
X-Received: by 2002:a17:902:e5ca:b0:1dd:a36e:3204 with SMTP id u10-20020a170902e5ca00b001dda36e3204mr47580plf.67.1710107338535;
        Sun, 10 Mar 2024 14:48:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fa9b:d52c:840:abd4])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d949393c50sm3120067plf.187.2024.03.10.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 14:48:58 -0700 (PDT)
Date: Sun, 10 Mar 2024 14:48:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Karel Balej <karelb@gimli.ms.mff.cuni.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Message-ID: <Ze4qx9KQEPU9U8JN@google.com>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
 <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
 <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>

On Sun, Mar 10, 2024 at 09:35:36PM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2024 12:35, Karel Balej wrote:
> > Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
> >> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> >>> Dmitry,
> >>>
> >>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> >>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> >>>>> From: Karel Balej <balejk@matfyz.cz>
> >>>>>
> >>>>> Marvell 88PM886 PMIC provides onkey among other things. Add client
> >>>>> driver to handle it. The driver currently only provides a basic support
> >>>>> omitting additional functions found in the vendor version, such as long
> >>>>> onkey and GPIO integration.
> >>>>>
> >>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>     RFC v3:
> >>>>>     - Drop wakeup-source.
> >>>>>     RFC v2:
> >>>>>     - Address Dmitry's feedback:
> >>>>>       - Sort includes alphabetically.
> >>>>>       - Drop onkey->irq.
> >>>>>       - ret -> err in irq_handler and no initialization.
> >>>>>       - Break long lines and other formatting.
> >>>>>       - Do not clobber platform_get_irq error.
> >>>>>       - Do not set device parent manually.
> >>>>>       - Use input_set_capability.
> >>>>>       - Use the wakeup-source DT property.
> >>>>>       - Drop of_match_table.
> >>>>
> >>>> I only said that you should not be using of_match_ptr(), but you still
> >>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
> >>>> proper module loading support.
> >>>
> >>> I removed of_match_table because I no longer need compatible for this --
> >>> there are no device tree properties and the driver is being instantiated
> >>> by the MFD driver.
> >>>
> >>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
> >>> compiled as module? If that is the case, given what I write above, am I
> >>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
> >>> to use here?
> >>
> >> Yes, if uevent generated for the device is "platform:<name>" then
> >> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
> >> sets it up (OF modalias or platform), but you should be able to check
> >> the format looking at the "uevent" attribute for your device in sysfs
> >> (/sys/devices/bus/platform/...). 
> > 
> > The uevent is indeed platform.
> > 
> > But since there is only one device, perhaps having a device table is
> > superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
> > fitting?
> 
> Adding aliases for standard IDs and standard cases is almost never
> correct. If you need module alias, it means your ID table is wrong (or
> missing, which is usually wrong).
> 
> > 
> > Although I don't understand why this is even necessary when the driver
> > name is such and the module is registered using
> > `module_platform_driver`...
> 
> ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.
> Just run `modinfo`.

MODULE_DEVICE_TABLE() and MODULE_ALIAS() reduce to the same thing, but I
agree that we should not try to be too clever and simply use the ID
table.

Thanks.

-- 
Dmitry

