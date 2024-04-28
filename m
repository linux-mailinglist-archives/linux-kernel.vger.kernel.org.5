Return-Path: <linux-kernel+bounces-161508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A308B4CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F7728172B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F407316D;
	Sun, 28 Apr 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5C8GRXI"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A3138C;
	Sun, 28 Apr 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323695; cv=none; b=KbauptuJRTb+kUoNBY+puv/1MZcxmjFIDBAVQ47OwA44uD61djt5St+Txn7I7De5+YmWddaVXLoK2EbZUfhKWJ3hC/mgez81wcZCGuz2qoxNSfZl6aGTEaelwMKyMKgd5JR8Btt/+qY2ruGY8imC8XngJnQbrKlgaYbOOEQvd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323695; c=relaxed/simple;
	bh=ZxixgPrLZnvDJH9QdjxkzUf9JL4vSpsdKc6KwfmMhrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEz4zSAa0Q2I3lU/m9teRS4Q+MIwIaU5SIIcAknugEjDBp5WZ++bhJp1oDdblf/7zSDT5cmukMThBb+Nrg8+XeZuiHvlqDzztlDdztGlRPTaG5upf0iixZ2eqW4Jm0tT8Xo1k+0quy2zzUVCe5amDPL5TsebLjXoiq/akgZcz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5C8GRXI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so3052084a91.3;
        Sun, 28 Apr 2024 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714323693; x=1714928493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDENpsFmdeEfO/qVTeBKBW2vXkBazChMcI6ZwrxhS2w=;
        b=m5C8GRXIlyOlu4V6/WH3b1f+20t6xeK1IOykH03F/zEMMj0cmj2i/l5GrePL3IOhv+
         DgSIuJufpqfz4QaLRvCIs7Ae1/MCVpTeWE/aVRs5fWLGa/d8ipwLUI9SUtdG/CrxWUem
         KUH56FLWN34G81IQrUkbcWLyNVTn2YCtQy8hI4bQrEkWmocfVaWAaHUFW+kDjlz0ryR6
         EaQfkYXUcZ70GSk97X1sl2oe7vfUfkC2hTRldwab1+XgdEHLEIkZJj19OQtQJ2T6gTWT
         pcJxgMW9cNVUKYJYiC3+2rzlKB/3nROgnmvMuPcOrfdvpob0BODR7dolGoNukFckXewC
         aCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714323693; x=1714928493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDENpsFmdeEfO/qVTeBKBW2vXkBazChMcI6ZwrxhS2w=;
        b=Pv6sNxrr8vf9uWp+Db5qCogVmA1nHwkqF8EW4b1kzF6dqQ2LRHwQolp9y5pg3LMUFm
         1D4afDc1Pg6rV7D3Fy64beaQaomIjSr96mjmCn/Pm8hAoxpn+EQU73Zq5W760y10YnpW
         rqjXw8lZfD3xy/KZ4ZbQHRzUs8txXnb5G/xeQj9c4VQ/XqcG7jCdn6iRTS7OcK5Och8C
         ja01itT8hFmRNjEipWMm5nWK/O7ke3BqiL6YdU8yk4nKD7bced/6PjQAjG7QUXAGGsN4
         u4D1GQxBsY1PbjS4rGVOW6GA0iHJTQPm6Qvk7DC2S6YJZIT4JuG6FSjlz4jIlycCGA66
         XXZg==
X-Forwarded-Encrypted: i=1; AJvYcCW9YprIDLKH9oouXHnO8jxaLhlK5S3oeHZ/DRDNYFcuVslkj3DJn199Uml8KdQ1dNm1heziwWUxGq5Jpf6XCzQxPUVGZlhYeXc/67uGaYi5jxvs5f2+v8BDJH2Cb4VFs04bGSdpOJMcJX3QyPEW04WxIbtn8kDIsOk5xHKJrgqqs6jt3g==
X-Gm-Message-State: AOJu0YxYUb6nOxlE9SiS+Dl5MQ7FpDleyBCV9hn+DE4565QxUupt+KW4
	o/4TugI/Y+yUy2w8PMJszBpUbeM3M4zO0d+S++l8p/b1zs+3xHOk
X-Google-Smtp-Source: AGHT+IGiNGmaG/QByc2uD0fvrWsQmU/2d61xSO4IEMUfGqDYmANEqc95aCKWvOM+k/CcPp5+AiVqFQ==
X-Received: by 2002:a17:90a:d397:b0:2a2:34d8:ddeb with SMTP id q23-20020a17090ad39700b002a234d8ddebmr7037167pju.22.1714323692991;
        Sun, 28 Apr 2024 10:01:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090ab38e00b002a03456ccabsm19304471pjr.30.2024.04.28.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:01:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 10:01:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 3/3] hwmon: (coretemp) Extend the bitmask to read
 temperature to 0xff
Message-ID: <82999e73-145b-44f0-a5a3-d43eed229ca3@roeck-us.net>
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
 <20240425171311.19519-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425171311.19519-4-ricardo.neri-calderon@linux.intel.com>

On Thu, Apr 25, 2024 at 10:13:11AM -0700, Ricardo Neri wrote:
> The Intel Software Development manual defines the temperature digital
> readout as the bits [22:16] of the IA32_[PACKAGE]_THERM_STATUS registers.
> Bit 23 is specified as reserved.
> 
> In recent processors, however, the temperature digital readout uses bits
> [23:16]. In those processors, using the bitmask 0x7f would lead to
> incorrect readings if the temperature deviates from TjMax by more than
> 127 degrees Celsius.
> 
> Although not guaranteed, bit 23 is likely to be 0 in processors from a few
> generations ago. The temperature reading would still be correct in those
> processors when using a 0xff bitmask.
> 
> Model-specific provisions can be made for older processors in which bit 23
> is not 0 should the need arise.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Applied.

Thanks,
Guenter

