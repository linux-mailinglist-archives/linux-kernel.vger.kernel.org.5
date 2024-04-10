Return-Path: <linux-kernel+bounces-138840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9D89FAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288EC1F231C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80016E86E;
	Wed, 10 Apr 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K31y8OJr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63332AF16;
	Wed, 10 Apr 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761415; cv=none; b=i8MYKQMCH1RtRzB+SrA5I8wY8EPUwfDTEccd+iYa+Ubb7sOd+BgGqECpkzMHg8ELWMxJCWD2TUdUeLdcrArgaPAp6wyvvl+UhDdjMDPJcydNt+1j07MlwPV/vVwF9BDYaa+LaAUFBtHz8gXE+sxGuoCG0ZPe6bfDBgFi3Xe32Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761415; c=relaxed/simple;
	bh=iawgCrylgKQ0k8TPg1yh8V+I8IYyrXYjDnLKunNPd0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXuDffIPea4fS7VUau6t9+Rl4jrESoVSmVAPZ+G73KGUrpJ1rJsjlDOkGC8Jozbj+KjHMBzPglvU3ARW3OtbNFaf+Evdh0NdqIB+sli/VknelBDmka0jWTGdYaFQAChJ8OEPilbl9iC7hsB+MPMhXMtGlndRSufTLkq7bwgttSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K31y8OJr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3485386b3a.2;
        Wed, 10 Apr 2024 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761413; x=1713366213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q84pyOmktSDtbHVv7AvfbbqPfRUwNQXxhjLV3bogMfI=;
        b=K31y8OJrqqVSa8/WfHW52RUbg7Y81jov5bppGs81xdYu8K65m1d4yP13sQMWnYX5nT
         7hfeC8RZOPKxtpWdYYUTrAnwnXvM9/u6ZJWGffbi3MwxGqOHhiCtJxI8Q84BOeyadScO
         cH4xxk1ycYK57qudf8vP14ZROZXfD71p7bFdUQooCeb3WfEMWNl/wFTNG+zaP0jWQPS3
         JEihHR54zPhGwacGidCPqzV1+/FdX0IXEHFtfy7c/NDFf6X4NxR2PdRkRLKeydwEmGnM
         dSMjxareLwmlHwRGOyEAG83pzQHA9HJV5bUlqr3g34sHLdms2hpZfQ8zyHS9EQJqcsdG
         p++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761413; x=1713366213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q84pyOmktSDtbHVv7AvfbbqPfRUwNQXxhjLV3bogMfI=;
        b=UlnM17fswjMtBgGorguhLh74FsQ3cva1PhOw6+hwkS4Bd37MKKTxHFf3eLiKYw34n6
         GNyomRYmOtOZoGtUZmok8f9wYBu+cyKDXyid3wfOeQ2JAvTMJiA2WJGOJn4wqVoM5Bb0
         f+sSpCtS+f6pv5iPpNpYUAMB4yrG3Wuz4hxnlPHEwWJQuPR/K+Ipu2f6Y/kP39qgm6ne
         sm7ziXafzlQF4k3vSc+t/qpeZRc8Xy/8DTJLwJrAJi9jSiSbHiuc30ID8h+x6j+LndOD
         ijniOFX88T9rER//0Ogu2s47/3LN4xijQQm0fnqMeOHrFVjcx3EV+dSqY6ZwKTKqOvXr
         Orzg==
X-Forwarded-Encrypted: i=1; AJvYcCUy8TEiKp7rMKmNsFIizOvYvv08HIeqKLoIIKftK7QisAxiobfNaU0IKg0Y5elzqTEBnqXpjeii+xP7dvj8Y6Xc0abBU9As9ch83Pmm
X-Gm-Message-State: AOJu0YytvAYc85iRROA6m5O0Swwaoq61kOCLSCTUYrf3auwpFBB0Izvv
	96Y4fm5XTHhXbr4Am8kS7rh6EP6yISa6WcodNQ7Gp0RZ/2/G31/T
X-Google-Smtp-Source: AGHT+IHL9+G/8yIJZc9Qz+E6DGgZQnuTdVymlz/OcV5N3Ur6iRkLoTQ9WlEwNldhRnitKrbXwjuPAQ==
X-Received: by 2002:a05:6a20:da9f:b0:1a7:3b7c:3126 with SMTP id iy31-20020a056a20da9f00b001a73b7c3126mr3013153pzb.5.1712761412971;
        Wed, 10 Apr 2024 08:03:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b006ed64f4767asm4105877pfu.112.2024.04.10.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:03:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 08:03:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] hwmon: (pwm-fan) Make use of device properties
Message-ID: <4d64436c-993d-4f41-821f-faa31d521da7@roeck-us.net>
References: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
 <20240404191323.3547465-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404191323.3547465-3-andriy.shevchenko@linux.intel.com>

On Thu, Apr 04, 2024 at 10:11:39PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied.

Thanks,
Guenter

