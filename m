Return-Path: <linux-kernel+bounces-40500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78483E1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F4283684
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8975C20B38;
	Fri, 26 Jan 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL4E65fY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CB1E882;
	Fri, 26 Jan 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294321; cv=none; b=f9soi6UOujmLCr4SCgDx1ZaFCpcZs9LgdHskQIk7it3fuHJ5sabp1TvKQ9NG5kFFahCUEjs3RLlKIOGQ+Rr2kLKYA/KhzU3NKQhSpM8DajnvYweGB0mBgBc3bPEEmYjil9/8yWY8/4OKZB94VCWfxqpe+op8f3hYkHw097YAnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294321; c=relaxed/simple;
	bh=KDy6nDmSAwMR6qc8wGAfnRJIe6MFO1EMTk7WKAj1vno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF1q1nCYgI8F9EgMtvXmvelEqLfmQEz7nxTwjKW8F5n2Gx96feU87OVduEiITwQw9wXmSVuDCreDqwH02yRKnYouBV2ickcUI0Nb6GYdfr7AeLhlMNZ7+idNniS268TuAqxkUuFC/1/PUEcjPsqXeFCFq+dWmEPlOoRug0i2RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL4E65fY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d711d7a940so6383165ad.1;
        Fri, 26 Jan 2024 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706294320; x=1706899120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSBeRZT80aBlUG4hS0oGOfOvMdx8XI7KPQSszGJlIsM=;
        b=PL4E65fYcmzA2YmRaRPg/fvj6/2ZyyjIpqde3MEtM0FcFF9pN25qx9hZv2BIr67LrU
         kh3qBurbBZIElLAmAFxueKQIkmqyEoP9qH4TZoLFn4+Hoox62tAtuBt3Tk/w0AlR00ug
         UNbdOHH2CpU7Pgfp0rVhbZixjJU5L1rSPP25kW5JSGvHwqLJGnabq+m0r6qhkV6tWN13
         svTjBKjxgo3FK4VoF9xWAdqVvha5E6GRxOBtUwHpkPtfNLGTpsLJs9AkRXqkphqVlXx3
         yW9N2WivUm6+v/xGQfF1sKcNPgDQ4Z3BepIhhPcep9mE0kYe6AvFM8cVKE10Ec6oC4HU
         ySuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294320; x=1706899120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSBeRZT80aBlUG4hS0oGOfOvMdx8XI7KPQSszGJlIsM=;
        b=MUDDRJY1usexkbjfV1OrH6KNxK3C8AQHNedaRXX9Otk7kmWj42ASb6nW4e1q3ymFlH
         0rHVhgKEn6NLCkE18tRxzjQWaXlN0FWb3iOL5yuayJ9CEjD7pIZK1OcoGSn5EyBCDtxV
         S4NccbzCEsYagGSY4+qvHQ5yJRsJ/qeHutchevyLaPBswTiwURGoaGhe0ZWxb+ZtPrw4
         M69WrIQfNuE+lFeBkNqyzS4l9pV0Bj80pxqUC3j5LXRjfgY643mnPZuvg33YqdJxmxFl
         iZOmAnsJeRK04U0NsPoOweONpOV44tQnjA1/svMBdV/HliYqphaHHtEDVVbxAM9oBQgJ
         FfBQ==
X-Gm-Message-State: AOJu0Yz0FZap3UKJNU91mBGFZJYhtvRWaMs2LwC98RUZfevHv1ISEjZN
	asZ/C8uNKjSUD64OMvJQn1wkUCIPgSB17YATdHVJtzL8LUtEs1Yq
X-Google-Smtp-Source: AGHT+IFgF5MEQC3+uV3A837umeS7tOOPFQnLW2EAQMHXAAB05a2rZf2bcGXDbO1TzZfSQbtIDRq0Lg==
X-Received: by 2002:a17:902:b78b:b0:1d7:5ecb:b018 with SMTP id e11-20020a170902b78b00b001d75ecbb018mr231454pls.57.1706294319674;
        Fri, 26 Jan 2024 10:38:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c38-20020a630d26000000b005cfb6b8e471sm1384496pgl.14.2024.01.26.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:38:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Jan 2024 10:38:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix driver initialization for
 MP2975 device
Message-ID: <dea2217d-3d15-4b74-a6e2-ec64c3ff1ac0@roeck-us.net>
References: <20240126151920.288-1-aladyshev22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126151920.288-1-aladyshev22@gmail.com>

On Fri, Jan 26, 2024 at 06:19:19PM +0300, Konstantin Aladyshev wrote:
> The commit 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
> has introduced a bug that makes it impossible to initialize MP2975
> device:
> """
> mp2975 5-0020: Failed to identify chip capabilities
> i2c i2c-5: new_device: Instantiated device mp2975 at 0x20
> i2c i2c-5: delete_device: Deleting device mp2975 at 0x20
> """
> Since the 'read_byte_data' function was removed from the
> 'pmbus_driver_info ' structure the driver no longer reports correctly
> that VOUT mode is direct. Therefore 'pmbus_identify_common' fails
> with error, making it impossible to initialize the device.
> 
> Restore 'read_byte_data' function to fix the issue.
> 
> Tested:
> - before: it is not possible to initialize MP2975 device with the
> 'mp2975' driver,
> - after: 'mp2975' correctly initializes MP2975 device and all sensor
> data is correct.
> 
> Fixes: 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---

When running checkpatch on your patch, I get:

total: 8 errors, 5 warnings, 0 checks, 29 lines checked

It looks like you used spaces instead of tabs for indentation.
Please run checkpatch on your patches before submitting.

Thanks,
Guenter

