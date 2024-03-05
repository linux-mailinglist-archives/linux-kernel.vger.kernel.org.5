Return-Path: <linux-kernel+bounces-92795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803F872611
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF882821FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA917BC9;
	Tue,  5 Mar 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST/o7nz/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF18179AE;
	Tue,  5 Mar 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661411; cv=none; b=ikS3XjdkkPzmvoddfkbQOxjyPB4wF765zMTrzsNXzJqop8SBWBQ8SMw3sk2IvxR6qYF1JezF9408NdCxFZivTinhXTSgjq9L0IT1bHBvwvfE4Ad/UVdtOsQeSGSjOXLS00LTAIP3oV/IjP2qLlUNnO3eHt3Jgn5fK3/2aVE85/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661411; c=relaxed/simple;
	bh=5h+tD6oRey6KH9ZoKZuUGb7Q7emH+VWm2gbImKJbJas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ0aU8CdMUqGF51vrshb/t4o9LgZ7O5pWwtQF+ItMdFcqFwiMOCaxhLDv4GOeSFYBRfW9ibknho/i8p2Byaq64vMk6u6xmiIGIqoO1HeE1m7q+hUqo7pX9DbczfTDgMikxUj92H2mmc1MXGGvSzOYRmRsBSWsoGs9yeEOAlgpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST/o7nz/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e622b46f45so2038677b3a.1;
        Tue, 05 Mar 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709661409; x=1710266209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhswj4glI7C4XcO24hWMc14o2Qx2MLIXt7FbLPOoosQ=;
        b=ST/o7nz/gHPVZ5sBir4RQcKRDy8KUNVUNGtxPLUGGWJGR2Th0GRma01g19HB3A3w2t
         QRVN6ejizVrp6q/2Iga1yqGCfeNNVG2BbgixBvwIvJYaUdg+48MaX47E5bDQ7gukE2+H
         HWZbNxz1dWD2QIsMqKsM0roOIPqctSWKdK0pNyzgvAPA606FsxbNfqJc/qKxvhxgQFzK
         bHRZpzaZKQvo2ywH+s4FEoL1V1mAOsIbNULG2lkGYpZN3VHmV0yg4l/E3Mqpax88Y3C4
         UhPIR9FkM+/ad/NE9EDzXmXfo9dfTD3Y5/M/NvsQjy4clj49NG7lXhk/H/NOGeNbQ70s
         z/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661409; x=1710266209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhswj4glI7C4XcO24hWMc14o2Qx2MLIXt7FbLPOoosQ=;
        b=XShfqIuQv3i6keyEExo0TEjgAhKsMVRy/QNvV7hN20lDgqEq/lXHQPIZNfq3ZFVUPw
         ku6gbRJAx3sWQClDNrpgG5c413HeY1JehDyQ9z8TVy7tIUA6BJrEIEa8gLzHa8EkesLp
         UIuFHHtWYo5GZSQRi8HRNYxk/PwV4+hqucJrREKnvq5Jcd0W8am8g2fyAZNDo6MdjYXe
         u1cv/EVeTiGNfpYm79womRjDFf38TWErN3enb7zdo/QMjZIT79QSItGlGyjLDpS6dIQk
         uOvZi6DDhwNgSiyecXC1jVXqI/SqalzMOE/z6k5lsNnL/awpbvEodqiFCDY6JUHCCZdy
         F75Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCHXuW0JY2Tk4+Kc22da2bhWxbWfOlmKfo5b7JfoI0mQBrqO+nX5Icj2KH7/iX8nzAlku9+KF42ncVMu7TfpCvb+7YBNsrT58fyF6s
X-Gm-Message-State: AOJu0YyBwOj8EMpDVHmt/NGNgcLMRmWAoRfZ1ZzBWnndHkVOKywmU/dh
	dzAp1ukLPeLlUtSTt4T/D8JO7VKnhFlyflk3IIMd8IbCZcorVbIntVbmpsbn
X-Google-Smtp-Source: AGHT+IHXvqXjZe0fEVPqSJkNclYCJ6wgwGNBbc3vLEd+B0zCWM9fnIVPxlvFFOOefGmcnz1kMBgmsg==
X-Received: by 2002:a05:6a00:1913:b0:6e5:7878:f28b with SMTP id y19-20020a056a00191300b006e57878f28bmr13476463pfi.26.1709661408645;
        Tue, 05 Mar 2024 09:56:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b006e612df4627sm4602520pfb.39.2024.03.05.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:56:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Mar 2024 09:56:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v1 1/3] watchdog: intel-mid_wdt: Remove unused intel-mid.h
Message-ID: <2e0b0f2f-3841-420e-aa17-52e3051af70a@roeck-us.net>
References: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
 <20240305165306.1366823-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305165306.1366823-2-andriy.shevchenko@linux.intel.com>

On Tue, Mar 05, 2024 at 06:52:18PM +0200, Andy Shevchenko wrote:
> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,
> this driver doesn't use it, so simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index fb7fae750181..b41c45582aa4 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -17,7 +17,6 @@
>  #include <linux/platform_data/intel-mid_wdt.h>
>  
>  #include <asm/intel_scu_ipc.h>
> -#include <asm/intel-mid.h>
>  
>  #define IPC_WATCHDOG 0xf8
>  
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

