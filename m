Return-Path: <linux-kernel+bounces-40651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A983E3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2121C23EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F262421E;
	Fri, 26 Jan 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFS+eycP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D66249EA;
	Fri, 26 Jan 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303228; cv=none; b=WIQyj4VFuRGQgOIwKxc1fiTRUG4jYi4CitIMRxAFrkoDwurYud7/e+FLo5Tax3wNpsjOIpnIM94jd09tn/iMF/ov9K/MgEUcP+i0LE70muzXO045cem8rh5Cx5/Eg3A4cU8dknMUD0KLxoJpBvE4+YDCpxNni5VI64nl0iNgdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303228; c=relaxed/simple;
	bh=dbw4vvArXGU39B7YbeEZOM5qPS2AP0rPNYsZM5P8/DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unGSAoMe7GSqv416lVk4vzkVzw6XiLyIGcM9qod208tbsT615JOsoQExiRZJh28/LBvTzzn8JRWP8tvZ1/w5vZ35nryWLTt9YaybLCBUGsCGRHiLTwXfUBFC2eNJ3yFfKTDHnffxPi/SdUjJAWWZZNkeb+UFcJoiNUprGMF/kGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFS+eycP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71207524dso4840695ad.1;
        Fri, 26 Jan 2024 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706303226; x=1706908026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTdpuD2crIU6eganfNTvdxMFibWZIegvqQ+jXo5sH/4=;
        b=KFS+eycPG/07JKMFZ/QWq5YXaeDFe2vIbYUlvQlA9zBqwkUatgYmZR+l+xYa2JeZk9
         Ia05RN4LBeeGDy9dTPPq2uWsQkaSPKhHSYeceFm2Tjks2kjVfdfpWrSFL1kP4aX0Et3C
         yNijDkyIjjFa/owL8Zl1o7xomwa6OhiZ4XUg4SLswUrsf4qzGmkf8DciTT2VQY6JEjUf
         tmktmUQKZIaPovLVP/tFAyQ15GZKZo3mRXgoFkmslvR9oZsnTDqiJF7j8Jz/ysX3bO8L
         S53aNXp6lgnlPIeGo/73gAzlfV0OofxooSpR9kcL25iGt5iIltsBHdNfcrFtk2hjaLhe
         9GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706303226; x=1706908026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTdpuD2crIU6eganfNTvdxMFibWZIegvqQ+jXo5sH/4=;
        b=DcIryBjxFW4MHRYKngowHKNEFtZuUqgaoG1ojpZJ9QrrDYlcVhJoSjpvQhSrxGVaJf
         3R7Q5U+te+6M/B5BNseQhgiCdDqpZhHKLz8VcTwRkNbe/l51/HUIztwJ14ffTDL7x+RA
         a3Ujwm/xwqpc8domWhHw3YsVcwV6qzlINdX9TS35IZzRyHPN6u2O/EWaFE1xH4p8VG3T
         ibY+rxa8KMzit/vxtfSozfNT2VLsT02b3z4/fj+py5aSG6JNuddnlSieB9Wt8PB0BgcV
         w5sz0pJedeXa/gs8uAJcjntHiVX51XW47Q5J76Q0ASwZYgbAVWQfhyeD6NkpsjuEf72G
         37ZA==
X-Gm-Message-State: AOJu0Yx6wJPM/SqrbimTIzPL9YJSwLY24g45Qg0fEbxsm5GyHtaObC1l
	xuO5iuTJ1ZIKlCN5TWx2JhMHl/LstbWNRF46FIgfDrKB2uzzo6rCrcl6Vv1r
X-Google-Smtp-Source: AGHT+IG8ow72mXXmqMAXAwHP4w7ura8bLjcOOCnNVo8Pz/dog4rC5YNHv3LEiJuJ4q/JIGr6R6KrRw==
X-Received: by 2002:a17:902:6a84:b0:1d6:ea06:9432 with SMTP id n4-20020a1709026a8400b001d6ea069432mr563627plk.87.1706303225639;
        Fri, 26 Jan 2024 13:07:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00195400b006dbe42b8f75sm1510780pfk.220.2024.01.26.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:07:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Jan 2024 13:07:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (pmbus/mp2975) Fix driver initialization for
 MP2975 device
Message-ID: <f54a1599-13d5-4fcb-8f76-16f78d0f86a8@roeck-us.net>
References: <20240126205714.2363-1-aladyshev22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126205714.2363-1-aladyshev22@gmail.com>

On Fri, Jan 26, 2024 at 11:57:14PM +0300, Konstantin Aladyshev wrote:
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

Applied.

Thanks,
Guenter

