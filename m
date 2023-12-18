Return-Path: <linux-kernel+bounces-3569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E1816DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC4F1F221C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D437D610;
	Mon, 18 Dec 2023 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtJJAiOT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868F41C66;
	Mon, 18 Dec 2023 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c6a71e88cso36139595e9.0;
        Mon, 18 Dec 2023 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702902778; x=1703507578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkzSpzeAL9RmFlL2/hJm5M0aNeQpUfSRQFTTR6+vjCo=;
        b=QtJJAiOTkuXt8fKLYOyC8OKoZdwQ6iNCtoVXxFvbM2d4U03smKZdF8LEP6P+O+TS7m
         s6PhezlVW3pKVrRS8VHOeBde+lUUWaXl8vAxjtxpasUE+SFFdR9LnG0pCS5sziMppS38
         5uBSF4mpABUTeeiE7qPZXaYAzUSW95SLO2C2l8bc/yzE+SByd2/nvzDCnsbU/T8NGeNv
         g3HHTUHgu6ZlURahNKT5AtSN09w/pStfqUAOxDK7zY8dVdTWd9bDF4bJ4jhaAgbGIgYc
         SUrkDKOwCvMpP6Af5NeZBj7PK9T6LMRD86K8ee2g+AKVI1fNb9pGHnK7lm2rqQ9j+wjC
         niAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902778; x=1703507578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkzSpzeAL9RmFlL2/hJm5M0aNeQpUfSRQFTTR6+vjCo=;
        b=Nl3YC5MVEjrhF+R6gH1IVbkrTkiQcXkznC8/sC1B15zUpwzHjNnzRsdBsNmuv81pbr
         rNxeSLB/5UV0wSHlG+gtY0qdOzJJ+07kHZvqMXY6EruhTeLVIx56+awbCO/p6Mu/daK1
         rhIXh0RUSlgrLdzpCVman/dj/9LIntlNbcLOePkcAa1gOoCVQbqUYeqNaefZLbVgBVam
         e+pnh1xjxaPTV6oI+em1gWQAoJi2M+j95X5S+Sc1wwXrD2rI9p5UCi+He6TENO0owyPl
         WgSPLZtGILEj2xZzrCsViYThP7v/DwehI3Fnb4OF+Jkclf8TK6ktDqQlqchiD+uJS5QI
         IHBg==
X-Gm-Message-State: AOJu0Yx2cv58X9ymKrKquCabbPGY4GRG8O1C6lVMhBJXkvmdmnlFmims
	I5e/fF5Z6fqG28Y7egpM7w==
X-Google-Smtp-Source: AGHT+IHGy9/HNB1mQw8r6qIKH02yibbK9xlzNiJqGPLWfNBD7SdKCS8gkZ8DhddvOj23GmbysRaO8w==
X-Received: by 2002:a05:600c:4e87:b0:40d:129f:d5ab with SMTP id f7-20020a05600c4e8700b0040d129fd5abmr1778597wmq.73.1702902777907;
        Mon, 18 Dec 2023 04:32:57 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:4847:f8df:b40e:3aa8? ([2a02:810b:f40:4300:4847:f8df:b40e:3aa8])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a1e4cae6b22sm14026777ejc.41.2023.12.18.04.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:32:57 -0800 (PST)
Message-ID: <2de65f47-6512-400d-82c9-ae2ba9fdaa12@gmail.com>
Date: Mon, 18 Dec 2023 13:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/27] drm/rockchip: inno_hdmi: Subclass connector
 state
Content-Language: en-US, de-DE
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-19-knaerzche@gmail.com>
 <rvovzl6rqkaa2hvml75if5bjasqnyh2r354jdjpa5gckfpcxv4@wlknpt7lhncq>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <rvovzl6rqkaa2hvml75if5bjasqnyh2r354jdjpa5gckfpcxv4@wlknpt7lhncq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 18.12.23 um 10:02 schrieb Maxime Ripard:
> Hi,
>
> Thanks for working on that, it's much better now.
>
> On Sat, Dec 16, 2023 at 05:26:29PM +0100, Alex Bee wrote:
>> +static struct drm_connector_state *
>> +inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
>> +{
>> +	struct inno_hdmi_connector_state *inno_conn_state;
>> +
>> +	if (WARN_ON(!connector->state))
>> +		return NULL;
>> +
>> +	inno_conn_state = kmemdup(to_inno_hdmi_conn_state(connector->state),
>> +				  sizeof(*inno_conn_state), GFP_KERNEL);
>> +
>> +	if (!inno_conn_state)
>> +		return NULL;
>> +
>> +	__drm_atomic_helper_connector_duplicate_state(connector,
>> +						      &inno_conn_state->base);
>> +
>> +	return &inno_conn_state->base;
>> +}
>> +
>>   static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
>>   	.fill_modes = inno_hdmi_probe_single_connector_modes,
>>   	.detect = inno_hdmi_connector_detect,
>>   	.destroy = inno_hdmi_connector_destroy,
>>   	.reset = drm_atomic_helper_connector_reset,
>> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +	.atomic_duplicate_state = inno_hdmi_connector_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>   };
> You also need a custom reset and atomic_destroy_state implementations
Yea sure - thanks for the heads up.
I had this in multiple commits locally and thought I squashed them into
this one. Well, I obviously didn't :)

Alex
> Maxime

