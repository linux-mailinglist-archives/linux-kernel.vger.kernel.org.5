Return-Path: <linux-kernel+bounces-20750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B77828494
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88E31C23DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57A33CDF;
	Tue,  9 Jan 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdagC62X"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0136B10
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336897b6bd6so2909180f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704798679; x=1705403479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPuw2f0lok/do/yRJgAKbKvhvOM5AdGi80autS0Z2tA=;
        b=kdagC62XBFTA0vPpBnauvPWuZJD4VKeDsfA4StCwIb6bezjmzDr5e6/ViF7ov76aXC
         julcXhroZL0eNLw56lArnGPBmISJDJISByV3v39VgtgggAGysTewbPtR1FarBcsxLIax
         q/euYamcM4anwjLkuiT1q06/bm766BpRiEEbCe6RLKq8RwRiKCX+ueXBXIUmWyVjXbCY
         zhH8fL1pJX98aFmuRU4JUqZ1f5X+mn4QdTwi2PNsk+mUPL9yXxDjks1BwB68Ax7Vsm8h
         PkAKoKYMJ++rDoT5w6A0/rhaMzA6ykSzvmn9mc3o5M3t8Xv1fP3j6W0R4RVUAJxGQjfL
         XVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704798679; x=1705403479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPuw2f0lok/do/yRJgAKbKvhvOM5AdGi80autS0Z2tA=;
        b=sZmitlcf90XJwY2yVND3sE+1FgPYULsU2WigFnKTnvW6m6OMMOvMv4wuJzgQvIPnUk
         vuPki8kwZb5KMnAgbF8aDmmthzo05fAKYPGfPp8D87Fy5an787uvXysLGKQ92JwIHJHg
         uusDD9Xw3Rnhin+OWq+1r1AlROpQEJ7HDkvYM48LlfUu8O6O94wzP03ZEc989YevQZvi
         TZ7Cu8xNFpCoB+QlfFe/iZOTKAoxoBAuIB+lyA1xMmQjZeBk/hSShvAsiMcJGqTtnXzX
         o0ovXJSemssqZshiGsTJmI6PrfhH1JyHxlZi3MN5/Rhz9B19hOM4UmVujEpp6R1Ayxj8
         xruw==
X-Gm-Message-State: AOJu0YxMycjy2OAZmwH0CZohfLd5oJcdJRbKdCYw018GN0Xo9rnq41Rh
	hyc+UuPFLOjqIUPu/bDdGA36B33//oqVxQ==
X-Google-Smtp-Source: AGHT+IGW7Nw3UNMKqnspKJNA/b+OgjNwSMdO+rvq58lLOjMwdj3me+m0eUrVYRh7/74aLRoWO0Z0hA==
X-Received: by 2002:a5d:4a05:0:b0:336:787b:5a85 with SMTP id m5-20020a5d4a05000000b00336787b5a85mr474366wrq.1.1704798678818;
        Tue, 09 Jan 2024 03:11:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g4-20020adfa484000000b00336344c3c3fsm2119554wrb.90.2024.01.09.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:11:18 -0800 (PST)
Message-ID: <1b6c832c-3516-4116-8c44-f85990fb8346@linaro.org>
Date: Tue, 9 Jan 2024 12:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] thermal: netlink: Pass pointers to
 thermal_notify_tz_trip_change()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <2938222.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2938222.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 20:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of requiring the caller of thermal_notify_tz_trip_change() to
> provide specific values needed to populate struct param in it, make it
> extract those values from objects passed to it by the caller via const
> pointers.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


