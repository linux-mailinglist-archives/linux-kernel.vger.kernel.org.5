Return-Path: <linux-kernel+bounces-143347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B58A3774
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD37285774
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E214B062;
	Fri, 12 Apr 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPTzbRBx"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4727442;
	Fri, 12 Apr 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955694; cv=none; b=mzQf4pa+jdaXUs5s/9t4kiwqyK0WEqO+mxt1zvP4ngPnIUwe4Z5WulDEJciD+FDhs3GoAi8c217svomoMDRqda5KO1nbfOu8H4i9d4ErZCU4WjTin+FhDbw4SeIsemI8Bfevf07eH2HjYGKrpS9WdVABPXhev2UPyoe3EJHrEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955694; c=relaxed/simple;
	bh=IP42T3tgWRWDrNGKkDY+DzLNrsB0u7rO5P6dU7fjoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx33/9l+9vsTBuCBciBO1OwTXbuMq4VxFazKGfE9u/8eylNlcwArzJ69WdigAmfaitwvTBlWm5/Nh9hAmeac1Z0UfLCsbowt6q8qsHqk7tOCTGLamZ2XByoZ86PbH/+0e0ecPcXpRQiGTNKI3JYsF36CoJGQ4wA6492uZnZKBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPTzbRBx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so1025146a91.3;
        Fri, 12 Apr 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955692; x=1713560492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vY6UgSQMubYudbrT8iIFDxh72nPeRohY0ZfJbpBEIZA=;
        b=CPTzbRBx2ZzgxV6ICRDyBRdzT32zQEDirzSv/U5zyuzI9UXxLME0hb55teae2hWjSZ
         2dMgPoPICW4Fk7m8nwk3KoyhVhAzO07sLakz/ZjTZVMxlk1+lvZQQovuUV88hZlrDiO6
         Otm37cySLuB5PXWQ3lloSisAmFXQ7JhJNySTNAFXvHpIpnP2lzXU6hkujR4YHmXv7uab
         wQCHNT8h8PWxDpfVl5PcO5JoUezjDrLt6c1TmvLmb9KCvCmkvuQoLCMff4g1IxD5aih/
         5YsJItunI2ElDPkzsuDlxYNTe1WP5PrkhDzWOJo6Pp7Wjbez+rdalKp4SrcLuTRxQM21
         dwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955692; x=1713560492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY6UgSQMubYudbrT8iIFDxh72nPeRohY0ZfJbpBEIZA=;
        b=doDWkyisGLcz76tcHAyKS0GjcbTH+fouTB6gQOKYUqh04BHNutJBZwAMfHtLKpn5DJ
         EQoq2WWZq0z+rxFomg2TaqPV+flx1BNr32A1HwLCPkx20pJdfMOGqsuXWtgYsLJVZ2Kr
         vrmfnML6BOd1gniTveqEJdSH7/im0I+V/xGQh1MmKV3bM2kqweS7CLpal/AsCak0tVKz
         vtFpe9wJ9fwHpfjPnNDxLppmzlhQoy92KGqvgxpTmZ46nwgJ9x3BzesqIIE9o2oEklN1
         4eUJtKFxjLtp4guzxy1/sQ+/9pMgkSGwi89y3rUoTtCtecoZ48GVTTmk7xu4yDDQBaUt
         a0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXWLoaDYsPkJXrAb1p64V9wPiixqfAW43W5y5ZC32GsjDoV1vcXdVppoWeG1coAb524djypIRS/1OXlhRae88btV7QOSULvIwcR0CqXfjckSdDg9ItbA+bQE4Rul/bxb2JA4VaDUBD1z0kZXW8mUXyKsLmFR9epcDnZzzkc5Get6eaNHQBObwDJlEvQoMAePR7swNQSLs9B9DBqXL/XoQdAXHc2bpS01knsnA==
X-Gm-Message-State: AOJu0YwHObihfqwQ+ZX8m1DOADWaghIZgKbV/NWrHSBV7SGMSmhjFiix
	f0u/NXE58yHe0olrBedOR8NfFthbgROobLTJ7EkUYK36XdI36kH1
X-Google-Smtp-Source: AGHT+IGtD/J8v512Ay+txxDTiC2uPF6OAxjKYpHqFIs9sDlymxLvIrF1sheBs77hAv/15pkTPSKE9g==
X-Received: by 2002:a17:90a:de92:b0:2a5:52c3:4ca9 with SMTP id n18-20020a17090ade9200b002a552c34ca9mr3964426pjv.29.1712955692480;
        Fri, 12 Apr 2024 14:01:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b002a2b06ce909sm5347803pjy.17.2024.04.12.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:01:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 12 Apr 2024 14:01:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	jdelvare@suse.com, linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ACPI: fan: Add hwmon support
Message-ID: <cff6f5f3-d883-4509-819d-9d2307bdcd56@roeck-us.net>
References: <20240412160857.79858-1-W_Armin@gmx.de>
 <20240412160857.79858-2-W_Armin@gmx.de>
 <4a07f4d1-bbee-445c-a7cc-377506de850d@roeck-us.net>
 <aace96e3-8645-469b-9056-0199af9d220c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aace96e3-8645-469b-9056-0199af9d220c@gmx.de>

On Fri, Apr 12, 2024 at 10:27:56PM +0200, Armin Wolf wrote:
> > > +		case hwmon_fan_fault:
> > > +			*val = (fst.speed == FAN_SPEED_UNAVAILABLE);
> > Is it documented that this is indeed a fault (broken fan) ?
> > 
> Hi,
> 
> it actually means that the fan does not support speed reporting.
> 
> > > +			return 0;
> > > +		default:
> > > +			break;
> > > +		}
> > > +		break;
> > > +	case hwmon_power:
> > > +		fps = acpi_fan_get_current_fps(fan, fst.control);
> > > +		if (!fps)
> > > +			return -ENODATA;
> > > +
> > > +		switch (attr) {
> > > +		case hwmon_power_input:
> > > +			if (fps->power == FAN_POWER_UNAVAILABLE)
> > > +				return -ENODATA;
> > > +
> > > +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
> > > +				return -EOVERFLOW;
> > > +
> > > +			*val = fps->power * MICROWATT_PER_MILLIWATT;
> > > +			return 0;
> > > +		case hwmon_power_fault:
> > > +			*val = (fps->power == FAN_POWER_UNAVAILABLE);
> > Is it documented that this is indeed a power supply failure ?
> > What if the value is simply not reported ? "UNAVAILABLE" is not
> > commonly associated with a "fault".
> > 
> > Guenter
> > 
> FAN_POWER_UNAVAILABLE signals that the power value is not supported.
> Would it be more suitable to drop the fault attributes and just return -ENODATA in such a case?
> 

There should be no fault attributes unless a real fault
is reported, and if power reporting is not supported the
hwmon_power_input attribute should not even be created.

The same really applies to the fan speed atribute: If reading
the fan speed is not supported, the attribute should not even
exist.

Guenter

