Return-Path: <linux-kernel+bounces-138837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1A89FAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B028C0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1B816D9CC;
	Wed, 10 Apr 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsMw12Ds"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8415B137;
	Wed, 10 Apr 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761316; cv=none; b=bLw66skDiffYEXJqwZ6C0M9zlEMSPNFMOzyh+1iFClIXLBMa4lJzTWfH0FcL85gdNdLSR4XRK03RCVs0KprzY7sEWZ/s1P+yov8YhCt86l8Tw8hsdp3USK5pxHtEvTnciCmZNEP8UtZd4jLzGr0vKiXYD2aA5+GMmyaDJGv9lfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761316; c=relaxed/simple;
	bh=7w1sOh8w7whxrIMaHTohkdaCnG1Of1qpAEmhNDI12xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWOy1RneHF11P3iAiPlTNxYul2acjt2Lmaqu0Tg7c8I2iTriudzjJ4JvOAa45f2ykYScekpWzY3MHHLVFbeQduDOIXDNOqcv7q6zKocpniFvOW4Itgtz+aw1oCSsRPbkmWeivtd+8VX/3KaXrkdxqAcDwE9TgN7/JkGlcqFfLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsMw12Ds; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed32341906so2812378b3a.1;
        Wed, 10 Apr 2024 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761314; x=1713366114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=licXdV5P/fELeeE/psDOSUVS914YPutAbHyY/jQtmas=;
        b=VsMw12DsuhXCCR+n6muHLv/Izhp08b5JAAu+p/8sudAUv8uv3N5DDtHMCvVC1Eon2W
         xTZG0z3xihHOOEeXy5ITL4hILHcwjwegNJS/1VFa1gTE+t+pYEjHDokkUJW+H0Eg1Vik
         ssdvfupwhnlQeFfo4mEAGcg+adZJOPQyA2CKEGTvzagRPIMWEbnJS6ubrmyRBaOwj5L9
         uLgH3qTwK4SlM0ZqOs1xuoAzmGaZQXYCKKWjjsYbgKNU9VznrwapAb1IYT8JsLNNEupp
         a8xYayIvhv4LVE6fUG9uJPILrDzt2XWe/hFZs5r6V0vKI1gZje1pBzcetkFzMkWIM6PR
         OYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761314; x=1713366114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=licXdV5P/fELeeE/psDOSUVS914YPutAbHyY/jQtmas=;
        b=LB4KAawzgyxWqK7YeEUJe8kdH5zAPx6tcDCGJQywvfxEIUy1DhmsJ3QSpD9JM5vjF5
         wncOljrs1wtZPjWdRUEGwnfUHFM/5FXuC8JlIW8XSvlt1hW0kFHQysl3B11ghHAtEuy0
         aog3KO1PmkoCSP+3tusOpQ493gfQnmy3Zm5UQG4fSrIIWhY+8b6g58Lv1H2kGZ9lfKlC
         /1UXrLpfo2ovsaN7QVSPW69/g+pBw1n9GWPINcjDnm0sugyCnseRAf2REX90yZZrOBld
         F4x1Ajkl7Wu4u6BA/2su9kT9fzTDu+UpJddzBG63KBKM6zeDk8Us0E8KfNfJPfIKbTV3
         THoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSmO60xvCoYZ5K5rXrPF4cKRHrJH48puyUnbfrE8LIePoYpD5EoeD8pWroUob+0bcScS9wWfbIvX87wghPY51Pc2wPyUMAxmY9mGZ9
X-Gm-Message-State: AOJu0Yzl4BAzfJ+g6ZS92srPibP3+mloqKnYUDk2NBDqLRvLbnn4fugA
	2lIJYLBhRAmNLwaRJdMjzyiYwIFHacLVjpu27uPUE9GcLzK/SD8GwiUlF0W6
X-Google-Smtp-Source: AGHT+IGxLtIDpZ3y9/Wrw9SLlRqrLrJa7EwX5cNB9XmJc7RT87/7qzShdDjXKeXhWiOA4hBy+psP7w==
X-Received: by 2002:a05:6a21:3396:b0:1a7:85df:ed44 with SMTP id yy22-20020a056a21339600b001a785dfed44mr3213992pzb.39.1712761314517;
        Wed, 10 Apr 2024 08:01:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a056a00216f00b006e685994cdesm10192450pff.63.2024.04.10.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:01:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 08:01:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) Convert to use
 of_property_read_u32_array()
Message-ID: <81e80790-2e44-409f-a417-9cedeb2a7245@roeck-us.net>
References: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
 <20240404191323.3547465-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404191323.3547465-2-andriy.shevchenko@linux.intel.com>

On Thu, Apr 04, 2024 at 10:11:38PM +0300, Andy Shevchenko wrote:
> This is a preparatory change to fulfill further conversion
> the driver to be OF-independent. The independent code has
> no analogue API that can read the value by index in the device
> property array.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

