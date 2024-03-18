Return-Path: <linux-kernel+bounces-105821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB187E50A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83361F2100D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067625779;
	Mon, 18 Mar 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytOQsKTK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B811D529
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751005; cv=none; b=Pdhj5zwgboWr/gvHhSlaXCMzaSFgbmGFW927HjYgDumc4W8tXDLKWPSv5YaCwhRrSwktWBRVtekhaXGoKu5yzLVHnj8sK1/tXJ5BZF1nsnsScWF4I3EEVqHR8Qm8RCBUu2m1fmZgzHvDjIqswBYX1bV4qjIiBKaSZFTa/tU9wuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751005; c=relaxed/simple;
	bh=cz/DtwHvn09OXWUpfUWUnrrtZhNvPgiFNccb8ys4a18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksi8b5/o+B1JovuCsdkZGyBU8Pw//pWBeNuCqSfwj7ighro+f54wUTeypd99oOSwVrV8B8jqLVi6ynzllV2++AUvDgKJWd7Zt5LwN0RsPoqAAX1cAlq4kce/sNDCPMfmEZ1r7JS2FQx9SUY2vzE5X5GgOGApxju8DTCAV6zU9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytOQsKTK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4145d4923a9so151755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710751002; x=1711355802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buYITy3eroi379u2ZSqvLDe/+/4jInspWMroz3JIBuY=;
        b=ytOQsKTKWRD0iXKda+NrrruZ3htH6yw3yuNl/s3scRKjkDgd9cgOERJhvYhSK6WpIv
         B1Hsb/RxSmqXApIJbOVRdB4bg1NPI60BMdcyfp9iSk89RRa6bobg0jEcnfk2LwAfHjWx
         wSDR09YSm/omke+x8is+K6Txet/D2qKaAMEUv3Ll9oosNE5QCYGZk3R9L+bsmGV0N3IK
         4eKj4PRwtXZmKz4hR8Yrz+3PDfdRhRaWfCkGZvIpqnVmEvyrA+gwVNJZMwXIODskKxc2
         PpMuWz9Brlh5LRF4Fov9FNSoaTy/1nQwAkvzG3jXOD1kcl3fAQsxM3Wzp9GSqb8gG/CZ
         MRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751002; x=1711355802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buYITy3eroi379u2ZSqvLDe/+/4jInspWMroz3JIBuY=;
        b=qFQIg2bVP0zmbLajd67sC91xuyoQSBzaq7CU8Az0KWxW2ZW0WPOxMxMihUIUpLWy3+
         0q7atFD+E9rcC6ZaizRgkZAKDk4vn123MlkOhffvfiaazmXSawywZZXkx6rWve/Ml2A4
         Q4WKkbIp3C5SYOkhUTGqZHka9dSdxXa2qI3I8zTtOvgry4DSWhH79wtUZM7+2CB/Pa3W
         BunSmhRCrLJxVsVauGEkvnEuSD1Mj+i09qGsCkciJz3oLalT6bOEXqTN2lYMjG0LIPel
         0Hao2yaHMZql2ISHClVkFVSYRNVnRWyaV6Alr1kSqJIy/4KCgcxSth1T9cxK1F8unQjd
         T7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXQtOiMuar6ajSKJniRuCZ+PaBcPFqvW7YzmguBPCLM6gx0MAKHKfV1e8aW2KSnNoBTAFxhWpc+P7RfV5hLNT1xTVJNOqKbjfByE5BV
X-Gm-Message-State: AOJu0Yyezj0RfxPfL6srYNuUHbmiQn6zbXJdcCzjlk7HanEhHPvZ9wI2
	woRGfSYa6Yepqj1r+QpJmRO9DS+okOODS1UCOFtLHNEBL91cvTpNZhf2JMluWPmhtvC31DbDq8u
	D
X-Google-Smtp-Source: AGHT+IEJnsFb6G/RTYZzruTUanim7Z/F7ymU8r7U0DzPA54vFKLVfi9DKZkdli6YQzp7jci/ecb2ig==
X-Received: by 2002:a05:600c:4ec6:b0:414:85f:1f72 with SMTP id g6-20020a05600c4ec600b00414085f1f72mr3851936wmq.6.1710751001586;
        Mon, 18 Mar 2024 01:36:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u10-20020a05600c00ca00b0041404efa323sm2913051wmm.0.2024.03.18.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:36:41 -0700 (PDT)
Message-ID: <314ee33f-074e-4919-be13-cc748c779800@linaro.org>
Date: Mon, 18 Mar 2024 09:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] timer drivers for v6.9-rc1
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Mubin Sayyed <mubin.sayyed@amd.com>, Ley Foon Tan <lftan@altera.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
 <87a5mzjbdf.ffs@tglx>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87a5mzjbdf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,


On 16/03/2024 00:58, Thomas Gleixner wrote:
> On Wed, Mar 13 2024 at 16:37, Daniel Lezcano wrote:
>> The following changes since commit 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09:
>>
>>     tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug
>> (2024-01-19 16:40:38 +0100)
>>
>> are available in the Git repository at:
>>
>>     https://git.linaro.org/people/daniel.lezcano/linux.git
>> tags/timers-v6.9-rc1
> 
> First of all why are you sending this pull request in the middle of the
> merge window instead of having it in my tree at least a week ago?

sorry for that, I've been buried up with some tasks. I'll send the PR 
sooner next time.


> That aside:
> 
> git pull https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v6.9-rc1
> fatal: protocol error: bad pack header
> 
> Three times in a row with a 5 minutes gap between each attempts. I try
> it again tomorrow morning.
> 
> Thanks,
> 
>          tglx

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


