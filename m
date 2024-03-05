Return-Path: <linux-kernel+bounces-91485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD687123B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81471C2251E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075E12B6C;
	Tue,  5 Mar 2024 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqC2PXPG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B711079D;
	Tue,  5 Mar 2024 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601065; cv=none; b=CvVNHJ9A1xEz6QWixoB3RfHpKP6qhD+Y/MSZ3f17odpdKeJBRUsHuhNz7agG+7MsL+PxtmnMxIwzLHViZDlFSWhfquIg7dWtk8Ca5LjNClDCRrihzmLBSytYJq2hSAZtV/MAU9NdFHU0Em+zt1TgDK4ESKUz4S9LXF2AuoG4bkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601065; c=relaxed/simple;
	bh=FEcIi2xYDZXUNMRQ1GvxIkFxcWe+g0CO75L1ZmozJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRZxf1AbzIcJDmfXoOn4/ycNPOyuUDoFO3OTWFPH1lUzX5brjbIG3m2MUyGi1UhoECkULEpazvRR/1b9mBX0C2g7JCXGQPuRdqcWDxSpYGY99HG1aeLcxSd7babR5wolHAv55LknDUASPd2WPB7dvYy4l0qK/ZN3WXRRio72ma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqC2PXPG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5e4b1d1f1so1714000b3a.1;
        Mon, 04 Mar 2024 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709601063; x=1710205863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3d6hB/xqjMYs6mjEHpZjRZ8ODLJGqpSdhUzLMOW1gCw=;
        b=GqC2PXPGVq9wG2hGp/aIdZJ8Te4ppGQxRRBDJb15xL5syRGWQyiCvuK5Wn8BvJM9wc
         rHQ+gJUT5Xju8giRw1kIwNlT2B5bqPKPoceqROZwHH2l8R7pq2V6vjWSzDVJEWWemcdy
         bwGbFlWLKEaxf6yWVpfsSGjy3B9LBW7AaxX3JuS4YOQjn7lgtcAWcIBnmnaZOuEB81fl
         qu19/vRpmRhMIHp5xcXIqhEdWfzkl6yzwFpoUuVVI70REPCoLpCGOrF4cAZ43p2YV2Y3
         PQFqAPO78mEr/ZwFD0/LnoQvgUzMigaxWyrGurOLJQaff1fJRpcBvDcn9jGbW78wCobj
         EvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601063; x=1710205863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d6hB/xqjMYs6mjEHpZjRZ8ODLJGqpSdhUzLMOW1gCw=;
        b=HWo275CIrV0RSD8zyu+URnCRKwVp73Xp4i4DSN7FxX6C29cXvs1Nz9Kjl0gYidmVh9
         cPsCQahY87azbIRP08SwKWu5ZiiOH1g33bqo469ANjQ9qy50dzz2ZqG7TzglXVTAcO9F
         OmLs/Re2nkGLHplc3o1A59orZk/BnGUzkDKfcyT7xE2/VmH4Ec0x0tP1Uqzt8KevkWUX
         HcnUKjYYW93zezV76djJxByQcC4pmYYITBkuW3HWUQ8KFAnue3w2M9MoqYQPQeE0tH5w
         p0tETrFPuLnOLTonGA4+bjXFBm3Z0hzkHOhea2GnGUO1FHd7In9eoZXzO6QqlTvUBLGB
         TNgg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3vaxBPregRZhJDMJ8LVYjo5c8v9GwILZgOzWVJMjKiZtNy6r46uNp+l7f0CCwkd5c0Ne2fe3yoi9fPvhIxR6plNbNa+hXaDOQeOzhX1H/T83fiG0/7jEofW7kiCWj6KBM2qnygv16gB5RU29TVxKDXRGSAKYNl+l2rft/187QM24efBq4/m3vMpm+9aFAhzFekHANaSjanB3PfZ9edoFnkU=
X-Gm-Message-State: AOJu0YwTvQroyntI9fOEPsC7epvISDaODPn0zT6U7LIzptpmUeLwnxy2
	3ae1W3zz3ChhGXw1s6iUAkz0BNaWeEb3TYJqk9eIZSfsZpp5yjjQ
X-Google-Smtp-Source: AGHT+IG8RINAEJMM9Zg0cQKhagN5KeHDtb6lCZITY/+MC/IdR5M3HzrCJ2InJv+yoqqZGOgIIGQQDA==
X-Received: by 2002:a17:902:e5c3:b0:1dc:b64:13cd with SMTP id u3-20020a170902e5c300b001dc0b6413cdmr519536plf.27.1709601062708;
        Mon, 04 Mar 2024 17:11:02 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902654f00b001db717ed294sm9334984pln.120.2024.03.04.17.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 17:11:02 -0800 (PST)
Date: Mon, 4 Mar 2024 17:10:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Message-ID: <ZeZxI_spu4vwxrs7@google.com>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>

On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> Dmitry,
> 
> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> > On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> > > From: Karel Balej <balejk@matfyz.cz>
> > > 
> > > Marvell 88PM886 PMIC provides onkey among other things. Add client
> > > driver to handle it. The driver currently only provides a basic support
> > > omitting additional functions found in the vendor version, such as long
> > > onkey and GPIO integration.
> > > 
> > > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > > ---
> > > 
> > > Notes:
> > >     RFC v3:
> > >     - Drop wakeup-source.
> > >     RFC v2:
> > >     - Address Dmitry's feedback:
> > >       - Sort includes alphabetically.
> > >       - Drop onkey->irq.
> > >       - ret -> err in irq_handler and no initialization.
> > >       - Break long lines and other formatting.
> > >       - Do not clobber platform_get_irq error.
> > >       - Do not set device parent manually.
> > >       - Use input_set_capability.
> > >       - Use the wakeup-source DT property.
> > >       - Drop of_match_table.
> >
> > I only said that you should not be using of_match_ptr(), but you still
> > need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
> > proper module loading support.
> 
> I removed of_match_table because I no longer need compatible for this --
> there are no device tree properties and the driver is being instantiated
> by the MFD driver.
> 
> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
> compiled as module? If that is the case, given what I write above, am I
> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
> to use here?

Yes, if uevent generated for the device is "platform:<name>" then
MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
sets it up (OF modalias or platform), but you should be able to check
the format looking at the "uevent" attribute for your device in sysfs
(/sys/devices/bus/platform/...). 

Thanks.

-- 
Dmitry

