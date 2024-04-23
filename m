Return-Path: <linux-kernel+bounces-155627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52B8AF4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A33B1C22059
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0C142659;
	Tue, 23 Apr 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HebvQkmg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAD142634
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891871; cv=none; b=E7sDJya/RvAzKe0FU/HvoxqLp9vxIGuYC8fka+b08gVqHOZnCfdcBqflV2sXRGaBkD5e5ciLb7fyWMJeD8LNvSmpSyLge8Py9TECh0vkAT3JaARgPG/XCN1nkYGHuMw7HelpMArbd+tMzo1XgPcdXBK0GStJbfCdcnYiIRRW8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891871; c=relaxed/simple;
	bh=wYBVJatJNPBvmSLtQoSAnOgDdXz1F9P4E2RBLfCbqRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo5dM1RnYOkUIwK0Zq5Kf/MHWY1pszERd6tzp7kL+68sZYRZhvo7IyQQ64B1gZXSut8Tz1552WB+WbzxVZxLgguftq6nltFjpCa11Kc/QvClklHEkqKBVkY3jgCaLcMdKtAw8d6QuRNkF4Mh/pibVrD0ShZOXtD+/n5KFaNMtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HebvQkmg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a523e2888so18574465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891868; x=1714496668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYlVF7FPON1rS0HsPp+bhBQxXwPY2zwFPgs8IBmULD4=;
        b=HebvQkmg25LDkABgpTfsYj7e/CRZr4cGeKxM6I7L+1VBCUxglgoQU6NXeGHtES7MIP
         SUwspmmFioQegMqyjvlSLLLuy6P3vmvTLZclAoI1jQdaLhmNYvDfrK3A7mzzjVJF4vvR
         gHLpCHWznoxyBUTu7x9Fde2fm2chK7As/bj4QZQhyx0Pj9Ie6XzvWxlfKxBTsX9TSycU
         0PT+CcTEfEXnhXQ8ctACdWrvQ3AAkeAmDS5NktOce9NW16Mbrp+Rd/aQxQ2UgHyU/40e
         l5QWvRKOpaazCQ2cxsKI1x/BhmGxsf3s7z9zTfBaLhOUOKyYzLl/rS25wiJ6Yf4KLLqv
         dcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891868; x=1714496668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYlVF7FPON1rS0HsPp+bhBQxXwPY2zwFPgs8IBmULD4=;
        b=AjgwPXjOeFxn90SoM9pbJDO6H+0P/i0f+IdDloD4zUId8cMYLheMMbNwNrkAtV7kmx
         4z0V/gQegwVnLo7hj8x4ohyYUtq8fWUWT9cN6M6waEysjEK4ZxYE4zp2jaQt2LCqgEGy
         N2AIKcICndX7qGIabCVNDsZg6r0iyhjpkaT2XBuZILVCLqKh/RXH5pF0L94yBvVGefEb
         YFdVex26BVAOaO8EmRq44JmWTHCZDcU8DyN5kmU/cuXwRSFff+ut7QJcj7Wl85Q4uMBq
         I4xBjk3YgpBzttZ/LK04GY1SugJLoXu4VDgacJVXtPR3IwRjZ30dL0555aFCqCiHKYaI
         BH0A==
X-Gm-Message-State: AOJu0Yw3/PrpFZgyP8TupzsbKrtuOhqWEumTB+Qq5hkOzwx/c9btmzJp
	On2ylYxBTHIryFt061ZJE8Ky9ev8O3sOgk+9COAjfKGsKpiju/CsRgTsroKwlog=
X-Google-Smtp-Source: AGHT+IF3YF9qYJZ4FPzzyuZE7xrq+NVuBGiDXmGCvkO6W5vJWOPDXzR6i6Eza+hy1q0VbTtoUtspZA==
X-Received: by 2002:a05:6000:1b90:b0:345:a60b:989 with SMTP id r16-20020a0560001b9000b00345a60b0989mr11074794wru.67.1713891868590;
        Tue, 23 Apr 2024 10:04:28 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm3735054wmo.38.2024.04.23.10.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:04:28 -0700 (PDT)
Message-ID: <da77db11-60dc-4107-ba18-b2463fef202f@linaro.org>
Date: Tue, 23 Apr 2024 19:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/16] thermal: gov_bang_bang: Use .trip_crossed()
 instead of .throttle()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2289003.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2289003.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Bang-Bang governor really is only concerned about trip point
> crossing, so it can use the new .trip_crossed() callback instead of
> .throttle() that is not particularly suitable for it.
> 
> Modify it to do so which also takes trip hysteresis into account, so the
> governor does not need to use it directly any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


