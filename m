Return-Path: <linux-kernel+bounces-15518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E417A822D14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73977B229EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D919460;
	Wed,  3 Jan 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/LTY/sJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA019442
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556e6a6d5b3so62142a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704285155; x=1704889955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HynO04C1LToaxvEzvk3dt7rYnogOYwIwWW2DAkTlJU=;
        b=j/LTY/sJfP86v8MxSTNVM4k1ejAre0cfVaXUAZfEd1PTzHbLcDHznr5rQHO+JLn8Xo
         AKICKUszgVsZT+vZ5Bo2ORY7HOKHyYQ9OBaIUuUhlFlIzOCYr8iVJFRPnckR3dwfEP4s
         UgAazUMlw9BnI3Ffs+rkyG14VWD1O++PrvmV3zCg811jV2vmYz3jRLVwnSmaC0c4j+q/
         L6kqg0fKAIg3xKcVQ25jZVgdro9VdbYmw0Xt2cyf/Rzl01H9NoVa0JFeiagLCvAJairZ
         FQKg+urMyOWjIWYZa9gF4QFDZGfUG2lcLAfI2+uLdIninFy+cT6sEoHACpWWY9xSKkPr
         S6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704285155; x=1704889955;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HynO04C1LToaxvEzvk3dt7rYnogOYwIwWW2DAkTlJU=;
        b=CF4cxkMcGXNmyqNcCkIGMy/2pqYiu08J2dBjXQPuet4DbHYVzUh9g6YNK/VstS9sG4
         p1jM5nuZK4QAgCpXP6t0G9mvF3MqWKYgTnezki98p7xgkBJ0Dq6uPpA2jMuDkzPRUAl5
         +L9DXszIfu/MdEnkDkh8KBU/Y0G6wQ5ROEf1VubzpmHcp4MLisDJVJ0+75YzUMnGD8Gk
         K4vOBW7Br6d8uyq1bpXkKG22FiOfAnjpsV9Kbi+LUzC6QYj9CwrxBVJFR5qmBJLSf0KE
         XjlJmgVz3cK7FBXoJrUWWf8LstF+eK7V+2HKeyYjUvjqfs+J0ynyaHXHAm+U8ZOx5CWl
         UnjA==
X-Gm-Message-State: AOJu0YyuVTkKV3li6w3/Wc46hZJECrTUXm/xoqyQjs20vVjejS0pZHYe
	SNeM71oVIQPgcXNVximZPQOcwDo6FletuzYn8mYUdzyDC/4=
X-Google-Smtp-Source: AGHT+IEYgKRNd3Y1dHGvQnP9euhmAcqI0kXxbJaabdP5BmeIz6vholSoTY3adDDehipL1OQIq0Su7w==
X-Received: by 2002:a50:c00a:0:b0:554:a300:5a72 with SMTP id r10-20020a50c00a000000b00554a3005a72mr10242041edb.11.1704285155684;
        Wed, 03 Jan 2024 04:32:35 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b00555f49e7080sm5926541edb.56.2024.01.03.04.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 04:32:35 -0800 (PST)
Message-ID: <d9cf7d9d-60d9-4637-97bf-c9840452899e@linaro.org>
Date: Wed, 3 Jan 2024 13:32:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: Register the power supplies
 after PDR is up
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
References: <20240103-topic-battmgr2-v1-1-f89ca7234626@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240103-topic-battmgr2-v1-1-f89ca7234626@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.01.2024 13:32, Konrad Dybcio wrote:
> Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
> supplies after PDR is up") moved the devm_power_supply_register() calls
> so that the power supply devices are not registered before we go through
> the entire initialization sequence (power up the ADSP remote processor,
> wait for it to come online, coordinate with userspace..).
> 
> Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
> partly initialized when exiting the bootloader and loading Linux. Check
> if the power supply devices are registered before consuming the battmgr
> notifications.
> 
> Fixes: b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power supplies after PDR is up")
> Reported-by: Xilin Wu <wuxilin123@gmail.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Please ignore, I didn't update the commit title.

Konrad

