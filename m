Return-Path: <linux-kernel+bounces-153640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B558AD0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A031C28CF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014A1534F4;
	Mon, 22 Apr 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYJmCzPc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56F152523
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800069; cv=none; b=AtCXk90OjVQgVxR5Z4tGlB3IphL6OJFoIXixpSxUYSjPFAZC7G5gyGxA0CtezOzwxCtk34ZGdSqRFGYb+XpcZWEFu8M6rh8vF3QBtfX2iUZekv5fHd7mfoKeTCdQwYedYxBWdAuK9BLM4Dqtg+645oJdR4Ly+MpgVMtXl2AjqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800069; c=relaxed/simple;
	bh=rFLnY69caO6DCxXEt1GspAQ7lGhSrz3Q5rZCzd4arF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTZE5pdMvdlUgnYZIrl64kYPic82gHP600Orb5SQ7GL8M1WMAFLNMco1Uk5pTqXeiSaUfxS31GTZt7uCRmOYSg/mAJuoWVKMYB5CLppczcDrM+NEho3iQKZPljRWtxF8LsUMntwBfnLWKduUUIHgKe0PRRhEEGDrDrsA2WEvDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYJmCzPc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a7820620dso5885005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713800066; x=1714404866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lz4BLGLppaJS4RUqiGyn4/E8WuIMdCWJat0A3CWxGLU=;
        b=mYJmCzPcf6rf5bwAx4Zgc+8pn22SZbgC4TQaH7WsmXqgCmyx4BJAJ72m2dCbvLuoh1
         8eOsL0xOxLEzQwHQruKutD0JR8AQHUfvozd/PL0XWqeq+YKlR9FNODyNXNNbYg10XyjI
         ys52rVnGkVQ7CZezvVzi0Wm5jL0vR0Cdf/hDoTtOdQisKilrwM3Zw2ARMoit2t+HyKnU
         SMOlwipg/ybpKPO8CApTVJxCX34eVtcKfdbscLNyIGIhQcIM1Xm61sW8NQecygE0MjaV
         EMuLORbtZK3GVUX4iQXOhYfJtQGk5kPKrFbjLmHlzS0xjFWun5GwCM+2uFpySRazQhrd
         dagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800066; x=1714404866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz4BLGLppaJS4RUqiGyn4/E8WuIMdCWJat0A3CWxGLU=;
        b=IscrnI+we3R3wHpHRTEC4zo8GefnJSKa5pO3uTmyldxXkaVVt4BBHVVZns191gHrr9
         c3ibvXS2S6PYscq5M49WZJcA0VrLuW+SqkVyIw4b20NIq3co1tNZ5/Glmo6tQ/JCNCE6
         415Zg1fQG7AR7o8Qiy8aiawjoH9G0cwhMy7ehoQFOWoMVeIgdJjiMMSs0vsKkMpELjfL
         6yTUd93iJBtu3F4qbMk0wW83JAflOQYmbQMVlrQgSLa7dbqsjorpuYNQGk+1l2USoS2b
         34Rtb8kN/XgXHzVUNdZ7WXGXqvDrTPN2EI8n7GE0ZX0bSrxgGHoJNGgKmmTOnqMzqbeY
         qWXQ==
X-Gm-Message-State: AOJu0YyXqSjR9B1QJso2GkoNjme6yo83AEcrIQxgjMAABatEBpfxAxRO
	IKGrOY5emn7xmE7tsbVFt5W4dy2dL88dQ0MF6s1H2UMdgAANMjkXwII6aQ0p/WE=
X-Google-Smtp-Source: AGHT+IH5rX73xaS6keYkyu8tgA9v9NkmtE5lmRGsiDlfEoHkzUAXtqPcF25Q3kCt+0u5ccN57FtUfw==
X-Received: by 2002:a05:600c:470b:b0:418:e0cf:dbfe with SMTP id v11-20020a05600c470b00b00418e0cfdbfemr7951667wmo.15.1713800066519;
        Mon, 22 Apr 2024 08:34:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm4198955wrs.108.2024.04.22.08.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:34:26 -0700 (PDT)
Message-ID: <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
Date: Mon, 22 Apr 2024 17:34:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4918025.31r3eYUQgx@kreacher>
 <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2024 13:37, Lukasz Luba wrote:
> Hi Rafael,
> 
> On 4/17/24 14:07, Rafael J. Wysocki wrote:
>> Hi Everyone,
>>
>> The first patch in this series addresses the problem of updating trip
>> point statistics prematurely for trip points that have just been
>> crossed on the way down (please see the patch changelog for details).
>>
>> The way it does that renders the following cleanup patch inapplicable:
>>
>> https://lore.kernel.org/linux-pm/2321994.ElGaqSPkdT@kreacher/
>>
>> The remaining two patches in the series are cleanups on top of the
>> first one.
>>
>> This series is based on an older patch series posted last week:
>>
>> https://lore.kernel.org/linux-pm/13515747.uLZWGnKmhe@kreacher/
>>
>> but it can be trivially rebased on top of the current linux-next.
>>
>> Thanks!
>>
>>
>>
> 
> I've checked this patch patch set on top of your bleeding-edge
> which has thermal re-work as well. The patch set looks good
> and works properly.
> 
> Although, I have found some issue in this debug info files and
> I'm not sure if this is expected or not. If not I can address this
> and send some small fix for it.
> 
> When I read the cooling device residency statistics, I don't
> get updates for the first time the state is used. It can only
> be counted when that state was known and finished it's usage.
> 
> IMO it is not the right behavior, isn't it?

Do you mean the right behavior is a regression or we should expect at 
least the residency to be showed even if the mitigation state is not 
closed ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


