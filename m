Return-Path: <linux-kernel+bounces-20892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95582870B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531DC1C243F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988A38FA0;
	Tue,  9 Jan 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec/36Vsj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEC381DB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so3747225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704806908; x=1705411708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTy/JLEmZT761d7ftGu9VfFMuGDSn9cmU7eaQ87PoQY=;
        b=ec/36VsjL81dblge0j0qkMRjZ8lnXGZ4sRsQU3jTBbuNUF9ipHB0AI1GmZMFnh6rdq
         T8FYcAwdVI2YuzXGDv9vuEFouoxkr4z4lMC14J2EI6Y94r808wxuGULfpV2gt2mr5Qn9
         qTALFBzG9yL61ZFTRYfK/JysmlHRphi2j9jGlkxVActZHztEbk9gG5e9KDoreCLA2ogv
         IZpM21vlbPtSwn6mFrApwqT6irA2am8/B84nJ9aXhaIsDqLzJFeINuQCKxkN8fgJpzlE
         pOUvYUzxDYNgP/9X8arFu7XC5FE0rZVIeGK2lT+e74KlCw3NS0kUolUFshpdynx/YDIp
         up3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806908; x=1705411708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTy/JLEmZT761d7ftGu9VfFMuGDSn9cmU7eaQ87PoQY=;
        b=QLb5mzrMiG7veX+Hcs/SefbaSGp/r/fbspjCtxETHcLGhEUZSAG/i+ESNv/M/Zao9d
         YV5l40MNxp6IXc9FmJLch8aFJjbxdhGBAtxyCj9mp/L71nzwpXexchiiVsMCAPZPWb/W
         pn9NZMf2KxX3eKCpj1eBfkubzJfspBIJwFdJI3WCJjj4kR8zEjWi7ekK66d3Vz8y4BBG
         dKSvkgepkwugh7bmwyIN19uf/q5vxUt4fUuBJbKzcl6Mgjl7GHFAfZuuXdyUag+lZSI1
         hGb8N4JysasT7u5WqpxOvQOhMSYmyWynBgoq/ylx6SXu+3UuuL8xGn1RfmWwbnk9vqpR
         g6yw==
X-Gm-Message-State: AOJu0YzGWeSiNsoIqH4XSoF1RgeoAlYXNDWJtigFnwCbUOq0JueU0F23
	FVaVT2wuLRTyyG25Q3JU3lmHPAi5YwNkhQ==
X-Google-Smtp-Source: AGHT+IG9h6l8YotuzKxZJRb0Ovsjvgt9tUe2AXW7QPyK9pXVD450NjAGp5w3cFVOmXwmN2jPfyeS/g==
X-Received: by 2002:a05:600c:5186:b0:40e:4a5d:59f8 with SMTP id fa6-20020a05600c518600b0040e4a5d59f8mr390656wmb.42.1704806908359;
        Tue, 09 Jan 2024 05:28:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z11-20020a05600c0a0b00b0040d772030c2sm3618745wmp.44.2024.01.09.05.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 05:28:28 -0800 (PST)
Message-ID: <5fe353e5-5273-4aeb-9b0d-84c29005bb9a@linaro.org>
Date: Tue, 9 Jan 2024 14:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240109094112.2871346-1-daniel.lezcano@linaro.org>
 <20240109094112.2871346-2-daniel.lezcano@linaro.org>
 <CAJZ5v0iL9PhG5e8f9rAL05FHT6TnhSYx6=XOFdgnBtbC--ZZ9w@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iL9PhG5e8f9rAL05FHT6TnhSYx6=XOFdgnBtbC--ZZ9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2024 14:02, Rafael J. Wysocki wrote:
> On Tue, Jan 9, 2024 at 10:41 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The mitigation episodes are recorded. A mitigation episode happens
>> when the first trip point is crossed the way up and then the way
>> down. During this episode other trip points can be crossed also and
>> are accounted for this mitigation episode. The interesting information
>> is the average temperature at the trip point, the undershot and the
>> overshot. The standard deviation of the mitigated temperature will be
>> added later.
>>
>> The thermal debugfs directory structure tries to stay consistent with
>> the sysfs one but in a very simplified way:
>>
>> thermal/
>>   `-- thermal_zones
>>       |-- 0
>>       |   `-- mitigations
>>       `-- 1
>>           `-- mitigations
>>
>> The content of the mitigations file has the following format:
>>
>> ,-Mitigation at 349988258us, duration=130136ms
>> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
>> |    0 |  passive |     65000 |      2000 |     130136 |     68227 |     62500 |     75625 |
>> |    1 |  passive |     75000 |      2000 |     104209 |     74857 |     71666 |     77500 |
>> ,-Mitigation at 272451637us, duration=75000ms
>> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
>> |    0 |  passive |     65000 |      2000 |      75000 |     68561 |     62500 |     75000 |
>> |    1 |  passive |     75000 |      2000 |      60714 |     74820 |     70555 |     77500 |
>> ,-Mitigation at 238184119us, duration=27316ms
>> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
>> |    0 |  passive |     65000 |      2000 |      27316 |     73377 |     62500 |     75000 |
>> |    1 |  passive |     75000 |      2000 |      19468 |     75284 |     69444 |     77500 |
>> ,-Mitigation at 39863713us, duration=136196ms
>> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
>> |    0 |  passive |     65000 |      2000 |     136196 |     73922 |     62500 |     75000 |
>> |    1 |  passive |     75000 |      2000 |      91721 |     74386 |     69444 |     78125 |
>>
>> More information for a better understanding of the thermal behavior
>> will be added after. The idea is to give detailed statistics
>> information about the undershots and overshots, the temperature speed,
>> etc... As all the information in a single file is too much, the idea
>> would be to create a directory named with the mitigation timestamp
>> where all data could be added.
>>
>> Please note this code is immune against trip ordering but not against
>> a trip temperature change while a mitigation is happening. However,
>> this situation should be extremely rare, perhaps not happening and we
>> might question ourselves if something should be done in the core
>> framework for other components first.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Both patches in the series look good to me now, so I'll queue them up
> for 6.8-rc1.

Great, thanks !

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


