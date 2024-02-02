Return-Path: <linux-kernel+bounces-50465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DDB847955
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CE6289DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E198595A;
	Fri,  2 Feb 2024 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD+9YKOs"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950185949;
	Fri,  2 Feb 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900925; cv=none; b=tLCYNbCrFKNMm0EukoIKg7dWdOVxSRD6cuEIrkrOl65273WNnIkHOZlDbGPnNsnwIJNHWxIw+Ol5xPCBxQ3APD1B9M2ef71ebvMTeR0/x3gLyb2shXfkcmGKpsy4LdQa5UwuIX6EbIE3Ys190nzLIoO4fcqJcflT3K+aq7tj2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900925; c=relaxed/simple;
	bh=32B//JDxJiRZBsf53iQ3isYk7MyrOdW/YuQLIRZa11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4DV5UWc5NhvZf/YjiYSTbjTNWLTzy6JKgDndXvDH5CQETfGtIVGFPN8GKJO1YfxWEDCAjkvFy9J07WXDcbzCoidXS+oJ92KTOZGhL4A/ozGGRPWrofE4shfkB7YEfSYKDVyNADZnCCqLNAY40cOpZh+K+CpjNvQh824vigI00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD+9YKOs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de2735151cso1768661b3a.1;
        Fri, 02 Feb 2024 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900923; x=1707505723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2Hvb4/kWmn4mJzDVdWKR0899OF3sPbKQ4xVeSo/y6s=;
        b=OD+9YKOsoVGroJdk8crb/770vtT+fHBt8A/k/EJpMFwKRZMH7OCa4jh7eIt2sMyUWA
         fAbGCqskzfR07Fl0NYI/95XOHaydqe+k72hQxOjhnjy/Lb4pYqO7ArCMq8q1grsOkQaJ
         bm05vAmqqhSaqQY9JgLspkywKvjzzinDZsJO1MTAI0ymRJ2OoJG4KJtourhJS7t7w0dp
         XMYwAl1sYr1AqLDvR/0T4IfEMSIgWoMZXSAj2jr12G1BEIXb4ZmeE+Je0QdO1VWf0bHO
         ngcWVZZLzwwn7TUdGYToYc7JG9KxQ+CrIa661TOLaeIR14IilyrJRn5PZhcGW7v3kVmP
         aqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900923; x=1707505723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2Hvb4/kWmn4mJzDVdWKR0899OF3sPbKQ4xVeSo/y6s=;
        b=whZIEoRDOdovp7vpO+isfcOfAunlw1bXVw4CyjJpBenDY1gDR5E2Eh8XxJM7+ZB4qi
         78EzZKhKZ0+fE3aMJBayUYq/868GvLHExFSRM4tfitYi+swFr1+Bp2UJ2q/qfcTBWHUF
         MY233jKAryT/Q8i5fvvmljG/1+4PeH369nOE4AuZK3DlfvO/zNsTUnWS5UKKrhEIMq33
         Jbauu2boH9+yt/Hyd+kzLgSHWO+c3LgYvEJH5Da4vx5lg6oKh8okvVMwFAfduej3342a
         8MV2BYvAxD9xX1hDVTPAJidHPpDDNStsV7CQOfcgHCX8ZI4RrdF5WPnaJiwbW6EsidDW
         fEQQ==
X-Gm-Message-State: AOJu0YzLwcpOfIcesLhYP44nBgrwyn1yrDsL1gBmy+ausk7DsO0IWLwD
	q/2sxy3G+KaJ2zuoI7+k0wOHpz1nwsm8dFUEO4U8W4UzMo1pDWAa
X-Google-Smtp-Source: AGHT+IFCp1izFJ0G/yBcNiE8pRu44wDS+LmUg2K6xxIfEty5450/IQnZPOEPpKIS8PXNw5FC0AXbxQ==
X-Received: by 2002:a05:6a00:1c88:b0:6dd:8992:6b26 with SMTP id y8-20020a056a001c8800b006dd89926b26mr7399021pfw.9.1706900922944;
        Fri, 02 Feb 2024 11:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWk1wsoWixPcNdQ/G2Jg3R+qqKLyMsrEY3xM5Boc7fMQxJknbzlOwQAVF4I8YnEOQB+rqFzgT5Qn+S/aSjplw+zhuxglpVcmOsA/Y1Oyt2wUbbghTpTaTcqhevkv5nkA9bIYakvYFHuaOXmHUXl0HlVQPPiMqK2FYT79joOvhIYg1Y7qbOX4ejP9+w4hKCauac7wp8AXEyQY5Y4zZjSTooAZTie+4J1XSeIHTXqp5Ig2OKI
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b28-20020aa78edc000000b006de09d94723sm2022017pfr.17.2024.02.02.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 11:08:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>,
	Yury Zhuravlev <stalkerg@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add driver for NZXT Kraken X and Z series AIO CPU
 coolers
Message-ID: <c4ecb715-ec25-416e-a893-6e9eecb37409@roeck-us.net>
References: <20240129111932.368232-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129111932.368232-1-savicaleksa83@gmail.com>

On Mon, Jan 29, 2024 at 12:19:28PM +0100, Aleksa Savic wrote:
> This driver enables hardware monitoring support for NZXT Kraken
> X53/X63/X73 and Z53/Z63/Z73 all-in-one CPU liquid coolers.
> 
> All models expose liquid temperature and pump speed (in RPM), as well as
> PWM control (natively only through a temp-PWM curve, but the driver also
> emulates fixed PWM control on top of that). The Z-series models
> additionally expose the speed and duty of an optionally connected fan,
> with the same PWM control capabilities.
> 
> Pump and fan duty control mode can be set through pwm[1-2]_enable,
> where 1 is for the manual control mode and 2 is for the liquid temp
> to PWM curve mode. Writing a 0 disables control of the channel through
> the driver after setting its duty to 100%. As it is not possible to query
> the device for the active mode, the driver keeps track of it.
> 
> The temperature of the curves relates to the fixed [20-59] C range, per
> device limitations, and correlating to the detected liquid temperature.
> Only PWM values (ranging from 0-255) can be set.
> 
> The addressable RGB LEDs and LCD screen, included only on Z-series models,
> are not supported in this driver.
> 
> Co-developed-by: Jonas Malaco <jonas@protocubo.io>
> Signed-off-by: Jonas Malaco <jonas@protocubo.io>
> Co-developed-by: Yury Zhuravlev <stalkerg@gmail.com>
> Signed-off-by: Yury Zhuravlev <stalkerg@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

