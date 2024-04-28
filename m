Return-Path: <linux-kernel+bounces-161246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7F8B4979
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0541C20BE4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661153C24;
	Sun, 28 Apr 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSWWJMrN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF11876;
	Sun, 28 Apr 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714275867; cv=none; b=sQ0IE5FAuidHcn/Rzl0XbxIRIfbIiQk7Ks5xFwoA0UDFc7Te24nNzHpqvl3tfWU0mV+UOMnG4FP1zPB28g10uq8B34ZlcZ8gs9cgaBjTg8Dcg0T1gq//VNcjuCKxiHjk1WNHZPlSqTjOquMrDI3nwaiPGsSS7z0Zd4VdcFKu30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714275867; c=relaxed/simple;
	bh=bUUHaUcc4sQxfKSynGb4PTXC+ah8b1Pt5R/7vxYUUDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQXo7yceX5qoUDruXwL4loWvxJR7byWw53BuIbHRO7QX7PwQlnsfrIQrca0gZD6S/sp5ZKsTTaI+1bRSdFeDbTxl4WghE1dLqYzdywKNKUU6PcfJ0wkIXFuUua5c0dJsSOWJkzipXRUSc45td7/6qnkiLGrZsAFk/iCMvowDysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSWWJMrN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so3227603b3a.2;
        Sat, 27 Apr 2024 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714275866; x=1714880666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBiP6VVtZadZOlLmcPG9euKbSsAbzPKPZpDA/s04QyY=;
        b=iSWWJMrN6JRcl91OhZ9bJVjFR6NPU/lhh2hC7TitZDlbUReGFo9UbLayMLqix+jXF7
         KiKREm4WS7GdJLFZvxTqTOSqY7sndCXEuWDvOJsAWfa40aEg4pb8g0czFg2YDcXkHMQ6
         V4edd8/yeEhTRBAViGi4xY4PgcYLeg2Y1SA+qfqg/8fBO2FVIIFrZeQXWN55Ln1kGAAs
         7ertMwQZVCjmoQHxU8o6IAxQV3oKBHNSMMxWKVOvc/nYoRC/dv4GkikM+S0m5ZqKeJzb
         ViS2k+r8EtRwnfKbC8D5A6LqXWuURVgfue2WN9I63fp9lk6tX/NseMgDaKkYJz7I6YhY
         EH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714275866; x=1714880666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBiP6VVtZadZOlLmcPG9euKbSsAbzPKPZpDA/s04QyY=;
        b=u6s/M/2hhLM7OT3n7YUWR14LPKgU8oY/RdjFRIclY6Zae6Ly8nh+Ush1aeeSNLvr1i
         5V9R7RbGMzR8ZuQ3o9B3xvled17hVCzJm1EFQFX8moTJC/nlNaTPYQqNWvHOkjoYYqt4
         GiAasO4sUfJR5+ybr9vIOqc+DPjl3uulmFg8ddeCRC9WOWkhy+UzROvRk6mlSltGllmd
         oG8alL9HYByDtHdU3S6ynVrd+n4UC5DTNjHazHHKbp/NY9c8FARy9mbYvVFhBCAZ0PVJ
         L6idLxEDINx6vgWijD4tlFikfa7nsW7r7H0D+HUGr6eD+REJvWkm9OssWnvL2xo0iuYh
         afdA==
X-Forwarded-Encrypted: i=1; AJvYcCW2PZaYoWEbWw86HAm5EQV+hwYz9fGOoB276m8HyTW5gLQMs35WoWjGwRk1QG4HpLo/uvFb/4Y3zoyJf7g8yNtbXmPQaXTHcZPqg3hxen1ral3x+mYdpg/KJRor621FgdR2F7sUrzN5J8m+RWZqIVDq6RhRaUBK5vNBXvjir5iwL3DXJ3JvimgWKsMPdyUXbGjx8Tcke/zp9L0w2ijcfTYnEes=
X-Gm-Message-State: AOJu0YxD9AY8QRZblK9G7SJQs2xLcDSt1+dt53XHTsdwzaKe/8WPJw22
	6G/c4aAJe9wYs1SJRUgplOKix1s8ZHYdSiSM4hrmIVsdUfI/I2Uo
X-Google-Smtp-Source: AGHT+IHB9vLCZcmksld3ZxwFbUVxFZhmSy2xPGeAFP1pdPi1V9V6/BYyQmycpFtt0RVlyyZVsnhEfg==
X-Received: by 2002:a05:6a21:3e07:b0:1a9:ffa0:d007 with SMTP id bk7-20020a056a213e0700b001a9ffa0d007mr6319960pzc.58.1714275865710;
        Sat, 27 Apr 2024 20:44:25 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001eb15178370sm3366459plr.130.2024.04.27.20.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:44:24 -0700 (PDT)
Message-ID: <a14fd65e-188a-4f24-90ef-366e405832b7@gmail.com>
Date: Sun, 28 Apr 2024 11:44:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] dt-bindings: vendor-prefixes: Add AYN Technologies
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-8-e0aa05c991fd@gmail.com>
 <20240425161356.GA2729350-robh@kernel.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <20240425161356.GA2729350-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/26 0:13, Rob Herring wrote:
> On Wed, Apr 24, 2024 at 11:29:13PM +0800, Xilin Wu wrote:
>> Add an entry for AYN Technologies (https://www.ayntec.com/)
>>
>> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index e4aeeb5fe4d1..c2365b0f4184 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -194,6 +194,8 @@ patternProperties:
>>       description: Axentia Technologies AB
>>     "^axis,.*":
>>       description: Axis Communications AB
>> +  "^ayn,.*":
> 
> It is somewhat preferred to use the domain name (ayntec).
> 

Ack. Will fix in v2.

>> +    description: AYN Technologies Co., Ltd.
>>     "^azoteq,.*":
>>       description: Azoteq (Pty) Ltd
>>     "^azw,.*":
>>
>> -- 
>> 2.44.0
>>

-- 
Thanks,
Xilin Wu


