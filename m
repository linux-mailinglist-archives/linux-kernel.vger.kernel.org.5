Return-Path: <linux-kernel+bounces-147605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919098A7678
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE9281337
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD641386D6;
	Tue, 16 Apr 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCDssa58"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EC84FB0;
	Tue, 16 Apr 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302526; cv=none; b=oRAzZxiSdPDM4zAnC6DnmGzg5KAqHD27XMYdx6AWX62fzVO74wm6wgd46RUvQV3AHbYfpC4QQAaNXNU3bNWIRDcVvcQeCxV9//jRy/DXAe5aSHqiueJNDtwXxjbUqEDwjtl7Dj+D9SabIJwdWf114uYdEGHGUGnPu9Abi5rbi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302526; c=relaxed/simple;
	bh=3viy2RvxVscrJaKjTMnRS76dUx/hTzvJ4XU6gR37kFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcadP+omA4UKP1rXCA2f2zaNLcWbFF/wV+ksEyEnx2o8ZA0QTtreEKUhPrztKzeT+ahx49yrLtwp0IX1eHke/rSkQKciYJhtXP8D0+tyqbehv9+4c5robalE4Q5ne3HFVoR5l+e2rz8nfhdP0rJMBB4vgVSK+cjUKdLI1R40K9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCDssa58; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed32341906so4368747b3a.1;
        Tue, 16 Apr 2024 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713302524; x=1713907324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5+cT67cTo02CntoKNagjaOFlNuq4qrkhX6F7XjSc7A=;
        b=eCDssa58omdGDgdymTfE+9FVpgnrVAVVzx7l/xISkHKNEXzKAo2gk7D5RQ4nTKzWu9
         PwrKqImo2eu3mQvfXzODvJiAP4Reh3I5nsGz3P+DloFVMGy8vdOzPnQl22/5qtIA8LDu
         aHLCA0iVHra2VgGZcDz2DmeSAdF5upsf3waRnjjurAJGGIGtlD9iEhP1ZGbN0tbTUXTp
         q9PK4ZNt5A4rqS/2o5pP6j4D5PNzaxqrYVIP9byorDVfTC9Vdz6j/x++u6wljaF0IQ/A
         s9bdajlnq6d5T6rLlV5z85rZrVv5AISd5+OnLqo7dHJwAu57ONYynya2YHnh7zWVQziF
         XKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302524; x=1713907324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+cT67cTo02CntoKNagjaOFlNuq4qrkhX6F7XjSc7A=;
        b=QdFnjGEiXGVKqM/nMMImaISz/VfpKPfZV+RP/Smi0KRFveTbt0IOOol+S6L1imJAI7
         9uzb4UwQ6r59jenlKZuMmHDuYPWmlmoa7C2QRdHbf/7LOlGXgppuLrsodfTKUD3harc/
         tjaMLyhc4NztV+E4WJ9/4XE4ReGJp1UgiAEZLhxleMHRtAugzl79QSNVmJmxy0gH+8KQ
         aUAJjpmeOtYbjq/wXc9xtBMwuE6F4I9VopkpKv69EoRyOqAsFEdIEBfgXaK6aOsoJv7L
         YOZ1VfHrbVQFz7Iq5JPVPq1n7BELmQ/1xzZ+l2UnrY0nbRtD1KxNOrJLKCewlJufO1ek
         lysw==
X-Forwarded-Encrypted: i=1; AJvYcCXvsnMbqnOw53B9t3AVGCJV3jwTW1ads1s0CPs1waNWJfaptkf5oBUhFO/jovGx86wqEd8PEUfYlAa2nrltDFE4vtRh2fgg3yjRkXnAQrA7Une71v1+z6kW6jAh13Tf4NJ5qpahJzV62t/HeHeuTX6eU1HIzNlIrnZLMLx2nuH6Gffz67w=
X-Gm-Message-State: AOJu0YyVhWiOzjINP2AhK9M77kRBogtfQHo+EvJUL3ZYO/n4LO2vN2Sj
	VHUefGRRujDxGhzxu5yj6eaer6g11UpaeBJxGgucI7RPH0wKn9CHYugYAQ==
X-Google-Smtp-Source: AGHT+IGtmhADIn7ffFIr2aJ/CC7G2eca3Dy2sm/BOCN1hE7qQKGMKwHpRYxAp8Rfdp/z4Jp2coDvwQ==
X-Received: by 2002:a05:6a00:928e:b0:6e6:b4e0:c3db with SMTP id jw14-20020a056a00928e00b006e6b4e0c3dbmr15191117pfb.24.1713302524254;
        Tue, 16 Apr 2024 14:22:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ll10-20020a056a00728a00b006efd89effd4sm4556024pfb.102.2024.04.16.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:22:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 14:22:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
Message-ID: <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416171720.2875916-2-naresh.solanki@9elements.com>

On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> Utilise pwm subsystem for fan pwm handling
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

That adds a lot of complexity to the driver. I am missing the benefits.
You are supposed to explain why you are making changes, not just that
you are making them.

Why are you making those changes ?

Guenter

