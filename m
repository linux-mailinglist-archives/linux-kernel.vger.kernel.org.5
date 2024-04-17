Return-Path: <linux-kernel+bounces-149239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8C8A8D86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F3D1C21628
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E20487BF;
	Wed, 17 Apr 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxqgJI9+"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAF8F4A;
	Wed, 17 Apr 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388234; cv=none; b=Nsy9AzjfJSttIwwX0+oXG9NFOUG9cNvhj7sxhEEQZM5RJMt54GFnC8fXctM8Rf1wXvnaI5lKKZpvNjZggWtGKLOdvi3kJr1rC3jeTZOllvncOVU4NDHbjaEcqE/0+LJFWTcbA8J3Wsaj669P1inf3S3DTrrteNhuYuszm4Vi+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388234; c=relaxed/simple;
	bh=5m9dXzqFF14/T0VNrdqPf1m2OX3PG06UzIjj7KeORXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoRR58qqM760WRZOrHOON78g2uivR0wYwgzck/9gP03miPVkPaiT3bKhkbbXIrQMjrsQeVQ3nTjGfHnxbNNsHb0l9kLbercuRyVbQnsLD6rzaRp0EfgsRhM6ewbDOVX0yFzuFNBlkWQRbNKI7X3IaXWMRSVN4ekhqusEK0k/PdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxqgJI9+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so75527a12.3;
        Wed, 17 Apr 2024 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713388232; x=1713993032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k08bk0vsukuircHIqELwgJc5pJdNP2UpODKXFvn+jbU=;
        b=jxqgJI9+w0+tZArMsxH5BP6yxXn35kMvjzJ0wFhpSH8gsmGCvttsU8/BiR10x9SiGA
         yxZe87qVFe+1nzSbPq+/c998Znvbj7pDYa/AQjrL5S9n7oJHlO89C8TdslfKFYwCK+Jw
         3Wu8Kyd5eKykPIwiiaL3r4bMjE17S7kp8z+kBNRoW+oSt6nIEHG7zv2X06TJ9oc20e4M
         aI0+WWRp2qtbUddLERHvWcdBaoGKjqWCCTj4ppr8Q3sRRnTC7eMYqKjReAdDicXAaDDi
         JMa2IBvOAyVookcYzcRms5i3F17yZbTQIk4CwV56XdIBitIYRCaJdLGYX/GBAldrxMaV
         L5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388232; x=1713993032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k08bk0vsukuircHIqELwgJc5pJdNP2UpODKXFvn+jbU=;
        b=q7OBOXX3onG8G7TYM6vamnNKgcHTKqf7Mc6sV2ml+o1MmXLkv23NhGFqQzA9INq4Aq
         1fOcil+9/56GonYz+if/2fu+n66vxFhga8BS7y+dtnHmv72NUpKF28ehFu91a8hWbW2U
         6Eqain/hIr+NphWWJcC5XpkhOlSTZLVxrk9TIWy+147bFyX02wh3Qn6V4qQmMkQMNrch
         5ZT/hFyRqIor1vigRnABB0hXfQzO5JBTUlpkIpnX17B6bwWPBM0XSXxSLEJbJelMCl7a
         m+hNTJzrXlfdM+bQflZGSw1wpUIvRvGwf6GR9fTp2eSv9/Q3r3FS58s42zw6f/+WlHoL
         NcTg==
X-Forwarded-Encrypted: i=1; AJvYcCVKrhuSNONDMvB3kJuCsbZF8VVggV2ePeH3c5smQ0NGaJe8yFBHHmXXkTa9rnJouWtEEuGuO4UWifoyMlvJoTVozsiT5npZZnm4Ar/ENWFpxSccZu6JMwTNeNNHSEmesERKAd+Hxa4ARnLLMeg=
X-Gm-Message-State: AOJu0YwEjpFsJ1F0zHkZrXJFTbL6YlCF2YsSCs2yokB+YR6Z31VLV0lM
	Elyncgc5MXBcFTDO6EtjnRSz7FSOKgsV5HjdcLcYARZu6wPvJnm58lkaNw==
X-Google-Smtp-Source: AGHT+IGn3emlFMD9pKAHR0kluTYorObtLK09R/qd/tX0W/tbZ+Ql/ttnq4O69mvAT1dF5vUjc2Dzhg==
X-Received: by 2002:a17:90a:5504:b0:2a4:c109:4463 with SMTP id b4-20020a17090a550400b002a4c1094463mr697762pji.6.1713388231978;
        Wed, 17 Apr 2024 14:10:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001e826e4d087sm78204plc.142.2024.04.17.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:10:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Apr 2024 14:10:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Judith Mendez <jm@ti.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rafael Beims <rafael.beims@toradex.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nick Saulnier <nsaulnier@ti.com>
Subject: Re: [PATCH v3] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate a safety margin
Message-ID: <4fc37065-a43b-4295-951d-4fbcc72bfc63@roeck-us.net>
References: <20240417205700.3947408-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417205700.3947408-1-jm@ti.com>

On Wed, Apr 17, 2024 at 03:57:00PM -0500, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window is open. Fix
> min_hw_heartbeat and accommodate a 2% + static offset safety margin.
> The static offset accounts for max hardware error.
> 
> Remove the hack in the driver which shifts the open window boundary,
> since it is no longer necessary due to the fix mentioned above.
> 
> cc: stable@vger.kernel.org
> Fixes: 5527483f8f7c ("watchdog: rti-wdt: attach to running watchdog during probe")
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

