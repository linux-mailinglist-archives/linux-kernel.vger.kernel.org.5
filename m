Return-Path: <linux-kernel+bounces-156442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CAF8B02D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580BC1F23A64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEDA157489;
	Wed, 24 Apr 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="don4JdYK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CF157478
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942242; cv=none; b=K86x4hr5UngYUU2HEX3APwXz+lNlSaAkcef6j23c48jgdI2ibYg0V28UsXEmT1q8aetAFi6NdxdC5K6AehVLFla8NgKutiWmTFz+3uyVqnP8qf/m+3k3R2my5NckCbPNL8vTZbA/byIIXbE3wwdDO0kHkTqhAVmmPAGcUXd5d34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942242; c=relaxed/simple;
	bh=o5jcMAoIDMNK7GfvCWxVvCxihxd3VCuD7FnUm6B2H+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv4kA6zAwSyYzMYZgER5F2Wb8zieb5C0eUooh76lJdKsTQTBpUklpNViv7N190oMpx9kAW+8AMOpF47RnD4Y2TJc9sRLg7Xvm+ntbpkaPwsr6BVObxsvSuckQdLj7TfPqR/uV7Zf5Nx72Aa0IBHLC+XSbp5nTchQifP4Yo5SD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=don4JdYK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso23237875e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713942239; x=1714547039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOI5h8lbYo046MdXyWvwZM6Al+RR9BSMFKRZs9RVGww=;
        b=don4JdYKTkzVV+O6EmcRZS7J29JEmF+DUrJ2nl2hrNeMHjNERzi3sDjNsTv2LCwpKk
         14LI+ZT6wSUF7BMueQ6TZfGD+Toz/nvEx22+i6NeTvsB7WfQeVC5brPHS9tKiHHO4yrt
         I9EwbnYJEwmYVXdi4JZ+iRZnTiHMoTMC5v9MFFvpLAEq1LD2xj1X4aoqdrIWSycTj5Z1
         8YCKJdV1G+1qDT4cd3Pl380wMa9uP9Bw0k6Wz1scrWIQulfZF/hCLBS+CJj6XHaMbiUn
         3Yw5TOD7pdW75QeqSpIH5Go0rLQQe8GYQ5xv6U3/9yn5Wr+NK97XVlPVDD9Xp/JE3Dtx
         dyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713942239; x=1714547039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOI5h8lbYo046MdXyWvwZM6Al+RR9BSMFKRZs9RVGww=;
        b=o181G28TXT2yTi/oyP4Xh3MyN3AXKWHprqN6MFZcperCnw3oEInxn5ae56/TAl1avM
         GXtbCALCXOeqnhS0l+0oZuarH++oREFkK8GDBmXkjx0N/XnmGZPqrAKG6NzwMQ7kUKqg
         BUkMzt8Sc3PBt2ykz4kVJEVrsd6zWWzO79QBqDAmtSPWpT7OZSoPQcQTcV/r6uhZ7Ibx
         zVGPYUy/O2uJ8TQLKWiKGLn09POgCp6sa1ssh72COJAiZz1S7bxF095D7A+A7dNXBmY4
         Y9/iwp1O3Bc6wpJBh4kYCdsm1nIysuBpipHn+i2j0qfqOPVl+rlj6v/S5rK/MZtLNQcd
         loBg==
X-Gm-Message-State: AOJu0YyTya6mlyM2eI6A+YvNjKLVxLfE6FgLGzYLpZdX+MHcOTC3ld+E
	kzsS3DfIf7FkuX8tNvzOw7yINTB2EGPN41EKBNbbOEFd6VzKt8w5C1RDwPnZ9nD1o9DR/ZUeR1X
	r
X-Google-Smtp-Source: AGHT+IEjfhUliB0ROA8SKjhBk1g0czsRVu0UcRbAW3otfksb7AnqbmAdQyGcaBd/8Pvcv9jHo73X3g==
X-Received: by 2002:a05:600c:c10:b0:41b:935:248d with SMTP id fm16-20020a05600c0c1000b0041b0935248dmr387282wmb.22.1713942239568;
        Wed, 24 Apr 2024 00:03:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm6079518wmo.20.2024.04.24.00.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:03:59 -0700 (PDT)
Message-ID: <6067e8e1-d4e9-4226-9767-62cb930f400e@linaro.org>
Date: Wed, 24 Apr 2024 09:03:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/16] thermal: gov_step_wise: Use trip thresholds
 instead of trip temperatures
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3769085.MHq7AAxBmi@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3769085.MHq7AAxBmi@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In principle, the Step-Wise governor should take trip hystereses into
> account.  After all, once a trip has been crossed on the way up,
> mitigation is still needed until it is crossed on the way down.
> 
> For this reason, make it use trip thresholds that are computed by
> the core when trips are crossed, so as to apply mitigations in the
> hysteresis rages of trips that were crossed on the way up, but have
> not been crossed on the way down yet.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


