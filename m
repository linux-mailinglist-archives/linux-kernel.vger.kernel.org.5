Return-Path: <linux-kernel+bounces-21175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF76828B43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5712848F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FE3BB3E;
	Tue,  9 Jan 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni0O8CQJ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737C3BB35
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso36259735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704821373; x=1705426173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnku5e/u/gHYRgoR0rSRyIOibtasAzsOAPYEKYrhoG8=;
        b=Ni0O8CQJBsmnvdjz3ETvlBnV6E/cncNHjXqUwQqV2y890eigsWjNzQDUgK2VpFaiqB
         oIP6zLw+/jbcthE1GTzon/wxAl56Hn0zVQIEkHTmV3kip8RWCKmSRJo1h1/ljgpOI98W
         eqk2xFK+6SggognUEKA4JXQz89EBRYMLFhSuZ2qu5mer1xpKXITQsTAOm+Hw+crPgtcD
         hb7Pu9iBf2GDqjt+Xc9fNlCS1ewka8XJkaOuuOJeGyLhQCl//dpRr2/3s0uQ5c2XB6P/
         /NvA039Qee6ZlJM1RPw/fZzBfCBaJqmCiFXJEcUivO/wCYFKjj364XfMlVdYqIs7Eysq
         Ykyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821373; x=1705426173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnku5e/u/gHYRgoR0rSRyIOibtasAzsOAPYEKYrhoG8=;
        b=Vx9GINIz7b8Qaqvsk5ZfsWYagdIPF2sLSb0RcrzDr7LjBpO7Et5+V2MTaWWIbIvp4j
         FPwJ2bCQhMChCss0E1i5Kv2qjz/zXz9BLmpgRfdUob645T+QMMdraOKCpPgVd+LXRUw1
         6ulJ9qF+WGp/K8MNniULHxzn3Nu8vxrPcCN1gvJv7RpDy1gddLismTK1ZxEfzfywxNcm
         L2EpGaKRhaAC14d93KDHw10DaKdrC0U1x5BMYj1A1fqJfnPw6iY0nutkKVWyEBiyLreX
         hbhX8HnHhEmrkO73TrF+4S/KAIcc2WH6/jC+6T1x4LvzAgOUe4dQIR7Qf91waaLhBQAI
         lncA==
X-Gm-Message-State: AOJu0YzsJbKW3Kj9OjbpkarzTd92O/XznSaJvp60/2OY/TKZTsCHenIm
	bXvXdybRq6TIgWebHPUH3DLEMGi/708vxQ==
X-Google-Smtp-Source: AGHT+IG/V4UimHzCxAzo6BEJ6VWy/cLJ9CLD4rbjCi/sELyShdt5NHYsGZRCMiDno7rLTgsk+jzu5A==
X-Received: by 2002:a05:600c:3b8d:b0:40e:4704:5698 with SMTP id n13-20020a05600c3b8d00b0040e47045698mr1812380wms.83.1704821372794;
        Tue, 09 Jan 2024 09:29:32 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id df8-20020a5d5b88000000b003376d4248a9sm2908868wrb.71.2024.01.09.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:29:32 -0800 (PST)
Message-ID: <0e90dee3-6247-439f-a70d-becf2531c930@linaro.org>
Date: Tue, 9 Jan 2024 18:29:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] thermal: helpers: Rearrange
 thermal_cdev_set_cur_state()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <2193991.irdbgypaU6@kreacher> <8343955.T7Z3S40VBb@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8343955.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2024 17:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change the code layout in thermal_cdev_set_cur_state() so it returns
> early on errors which is more consistent with what happens elsewhere.
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


