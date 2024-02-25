Return-Path: <linux-kernel+bounces-80063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BC862A57
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9511F2150C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D56E560;
	Sun, 25 Feb 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEZFy1ZH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E319469E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864642; cv=none; b=ZY63PZE4IyrydZE8h+XvXtIkd+CT+7p6I5MumiQv45Win/mSsvZDHr3hKMAKlP0Vw7m2GDNQwgNB372mq1r/UMdVw6gdiKns5gBKAxpwbKHw5q3TvhUqxEuiRk5eHn0UhxwKO2Yzi/wQzmAoFh8wqDZbIGbyWyO42a3BJE8WHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864642; c=relaxed/simple;
	bh=JCUmCCCBdsObKnPRgnexNT5YKa+rHnpUtMGms2YqrBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iX5N8SPvDq+LKHdAZawJQYbDHACjD4FPAHK65Qt5NdeZWZk5T/bH6oGPQB3JwuZ6d/pdJWiqszDjH/rhJRf4AeZPIetANvRICihxauHeC0ApxP2bVq4SgvxKU1AGfirxc/Kq6DP9m9KHlX7CJirrZ7/yz2UoFcnm8fl+3VRnQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEZFy1ZH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d01faf711so2299146f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708864639; x=1709469439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMkJkQ5XQf70vJZkBI4YKSSGA1PbYpIYNkwgTn3Iuxo=;
        b=UEZFy1ZHolo2LCIvQg08oyyV4OhBXfemftKc4ZLASEoKMmfrZoHk6vAVwnl2AyjAGd
         7XT+VWlPrustIy9dEfDfgN4nNeJvqvlBsmb/4pmnTGQeQZpqVXKvnm917f89qHo2Wox9
         kF+m6AxnGIlQ9HLwe0DGiEOXhBsDbhg5C031xQw7M7cZ2I1Z+J6T1R8KO9qSwb9lri4e
         dQoJ03qzZdGODCsKGD31byC9wCFH3tzMA6xExwBApmRi68o15rapKUlDhreQSHXbVVfe
         8T5KLkPB7A/w6ZqOzuAPrV7u1eJ31LiUpTFvoSq/n82S5dJGi26xMU3xrTfYZTPCddUD
         dIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708864639; x=1709469439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMkJkQ5XQf70vJZkBI4YKSSGA1PbYpIYNkwgTn3Iuxo=;
        b=RbEh8kWZFFcdLn+2gZpua3uqXYPyO0L0m2UqAXNT7w97OiBruRPnKpMXKfUL3IC9Ka
         P0Bz5AwsJx8I8Y1TF8KlyHGrDDp9pNw6lPO9V/2HzayOyUYsUtciWFDU1HvSSLoR3h0b
         npVHfT/o8GfaYHtiWgPZ1Ns5NTyI12PkDVXpPhzX4kys2PwIp0jE7N2H+t83Kw7zhGAO
         cvKazPvN/EgegKdZzesqOCEmNuc0oK1mLFG4LrjclA5l3AFq00bdWJBFc66q8yL4kPAx
         s7eKOSHTaFpCm+Q/5GoGZbFwSdA4nhT8MCwTkUpCgN3CBSO6UjCoonQLw7k95MQxot5i
         UUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO538ON5jbGO/RTSfKxjrmszBxoi/6B1FO6vOSKKZCMuivk4870UVerG0gfZhTJSvPHWIEz2IijlczKUfwU5bYEEH3FNVzgt7T0ZWE
X-Gm-Message-State: AOJu0YwT5BkL35aOO4xMuvzAGodZWEq7J5rn3U2h9RhhWMk1eTXktciN
	tXkR9q0oyXhkhoLPe7XEOSCIxtl8iFVsgI3/vEwSy4v7HXYidLyBvnJSerlCbDE=
X-Google-Smtp-Source: AGHT+IHboAkTzMjgQLhBVPMl+xC+cHcyTjxdpJZFHan7vMWChtZG034ZBffs2Jng5zYpporvG4Uf0Q==
X-Received: by 2002:a5d:410e:0:b0:33d:bfb1:4c51 with SMTP id l14-20020a5d410e000000b0033dbfb14c51mr2167610wrp.10.1708864639416;
        Sun, 25 Feb 2024 04:37:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ba21-20020a0560001c1500b0033dc3fe1046sm4090407wrb.77.2024.02.25.04.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 04:37:19 -0800 (PST)
Message-ID: <5d3b6c7c-b526-45e0-95fd-deedad2411f6@linaro.org>
Date: Sun, 25 Feb 2024 13:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, patrice.chotard@foss.st.com,
 linux-amlogic@lists.infradead.org
References: <20240224213529.2601333-1-martin.blumenstingl@googlemail.com>
 <eb54b791-05d7-4eee-825d-373cc78df689@linaro.org>
 <CAFBinCB6+=PThAUz+BdfeD+DqCpscw3pSwrK2pue+J07vhPh_A@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFBinCB6+=PThAUz+BdfeD+DqCpscw3pSwrK2pue+J07vhPh_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/02/2024 23:13, Martin Blumenstingl wrote:
> On Sat, Feb 24, 2024 at 10:55 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [...]
>>> @@ -301,7 +298,7 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
>>>                psv--;
>>>
>>>                /* prescaler within legal range? */
>>> -             if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
>>> +             if (psv < 0 || !FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
>>>                        return NOTIFY_BAD;
>>
>> Won't FIELD_FIT cover psv < 0 also ?
> Hmm, I wanted to reply that it doesn't because internally FIELD_FIT()
> uses a cast:
> ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)
> My original thought was that the cast would clear the sign bit when in
> fact (I think) it will not - it will result in the signed number and
> BIT(31) set.
> So I think you're right, FIELD_FIT() does cover it.
> 
> However, there's something else odd with this code:
> We're dividing two frequencies (using DIV_ROUND_CLOSEST) which are two
> unsigned values. So the result of the division can never be negative:
>    psv = DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
> However, we're additionally decrementing psv by one:
>    psv--;
> So in reality it can only ever be negative if the result of the
> division was zero (for example if new_rate is smaller than
> gt_target_rate).
> However, in that case we would have crashed - with a division by zero
> - in the statement right in the middle of the two mentioned above:
>    if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
> 
> So I think we need another patch (it's best to order that before this
> one): make psv an unsigned int and error out before trying to divide
> by zero.
> If you have any objections: let me know, otherwise I'll prepare a
> patch tomorrow.

I think it makes perfectly sense, thanks for making the code nicer

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


