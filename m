Return-Path: <linux-kernel+bounces-155636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179F8AF512
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD62878B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD21422D6;
	Tue, 23 Apr 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iyd4pnPp"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7B13FD78
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891992; cv=none; b=u4Duz10qgc/ddzVnLi8xuR/7aTlkAs9bP8kn9I9vxv4U+iSiq0moO+Jn/c1iUeJeAOzcMVqURLnnOeOYm3YtnhPqp5qe/RaiUaQn/ZWVqrzAAfkHjj6IgVN9UHNAWUOLeDEix36PcPcw0KeWsxysqIAD/qmzNKgqEKZj//YkYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891992; c=relaxed/simple;
	bh=cadbqdxoCrgr/fQKYDJtFPwBcyrMsC1h7o4VyUXwexM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+U+pAaFzecgsjauXBvjTExxo28OchWFGtmHmV4AibNDYzHaAIpdoymNlpfyvKZJHtYArHdyYUs8jH3mnGHgLpqNZ5rraLUZHtNbfO7VljghL6KDIShJ8/oRqZ5OAt8qGYKLfvZahmd4knieu16zawz9QjcXJQGbPG67IIJBypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iyd4pnPp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso32232151fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891989; x=1714496789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVFoqKLEKB9pSmavX8lDsgDx8aHMUSa6gn/0P7/pI=;
        b=Iyd4pnPpCcrGVnUpPTE+A0k+RCxP9a3G8g75xGZ7EiWVxHpvfrqzZPG+qhkxDnH32a
         nXGr3LAddKT/ziLyST0QTwTg89eYBr9L7COb+8t02izwF69TlXzigVUvLaWKor598P+D
         FVvI0/A9acG8+u9yxKaFGB290ufE4SwjNkO3pSaFvwILl2nIgkJwxU8t1y2vOMInXUq1
         DIUBLo4OTIReE7BG1x8jn0poynF8on1hwJT9MVlge1+nOzinvTkinSY6KZWrYYOHwyxF
         PiqtW+U4teHjzh4xhpZp+C/ngqy59ionBMK0qLRxph9sZeeI7A1F5tt8vd1ji4en0NYm
         IbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891989; x=1714496789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVFoqKLEKB9pSmavX8lDsgDx8aHMUSa6gn/0P7/pI=;
        b=Mx0x2DzIeGpUzVVpSBPG3p/YNHjKnlQQhAo8zmyHquZ6xmjFtb5NdHnsI2odNranCc
         4UmR9pRHPDbS7duxlaUL9HXnRZwTw9OMFz0jEuoRhFMLgIB65PSxEbOOuZ9GYDrUmsOB
         BuHL8CzYEi7KU+pdGVKb9Gj2JFOpLShwf26P9wTOrNTn+0Uzy4rFZBIae6BG5g9TbE01
         uIBg53chvgzx63p95Cg383yTrW8g0TPkdkEyx3dzYqmMRJdM9ZqtDYV6sPmIy611YMGj
         IoXWl+Aeqcpcwnjc1Ab+2l4SKBfu6X8DSYOdDtrOoUEO+Dzq1eF7M+hHUOO1RxzO4JLc
         CXhw==
X-Gm-Message-State: AOJu0YyijiYka3QMuaBI72X56DG7Oh47QPb4TYZMLZ3PW9m/DiEvcPww
	difACRII/J2Qa39y53kXgoDfriw9P6h/U+ZI8GTpmb79MIZRE1MQffhBJfoECyY=
X-Google-Smtp-Source: AGHT+IFTLIFryToNiC7tozTvrbaJa5+9JPxbtu+C8ul5pe0yWHBv4YXKdKe+JFKAm0GKlNfIX8eAOA==
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr11163313lji.30.1713891989157;
        Tue, 23 Apr 2024 10:06:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm3735054wmo.38.2024.04.23.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:06:28 -0700 (PDT)
Message-ID: <91fb56d5-3366-4fb3-ac44-71c29654318f@linaro.org>
Date: Tue, 23 Apr 2024 19:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/16] thermal: gov_bang_bang: Fold
 thermal_zone_trip_update() into its caller
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3827124.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3827124.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold thermal_zone_trip_update() into bang_bang_control() which is the
> only caller of it to reduce code size and make it easier to follow.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


