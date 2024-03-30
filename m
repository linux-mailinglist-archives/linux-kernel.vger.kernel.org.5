Return-Path: <linux-kernel+bounces-125645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B2892A03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9D1F22251
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCBF9D8;
	Sat, 30 Mar 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUpkQDOW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D912CA5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790830; cv=none; b=aQE7a2u68v9gGRqmU6ebnmjIsBXz8iHZkDyJe47fOE/C7r4lsnhqOq8W7j+BUSwWYsrCh+2sACm1xXLMAEkM4mlI16fwG9TonMukHKkjKVPw6caTZj2CcPtmjzV5gGySOATp6C4P1huHLqIf+WjmJ/m6TfOtni7dxNl+pAB3D9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790830; c=relaxed/simple;
	bh=timTxilapKsONbEjau72+Ou1q/7xtxFnJ1b7itFduSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0xTgYWAvngQ6LFX7CUgmSmIGyeS3IAKhCjODTyZt1imVrQfSJpPU6HvKU6IW5jQTtXsQVkdNB5uTrqsX8vBbLPzEevPEJJN+h1iZbrLmeXc5qnjFUVT42EKDZN6eoZJD0jQxv5+5jHolvGHdHNfP7KzUlgyOp4LNXQyIJsGVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUpkQDOW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1745994f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711790827; x=1712395627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=timTxilapKsONbEjau72+Ou1q/7xtxFnJ1b7itFduSs=;
        b=DUpkQDOW9H3lEOMGI4TvKUvEj9q/Tsu4KLAZPL78Wvz+u5s9vrDOFXapzOX/uNamBz
         kN5Jsa1IvJg0gfHYa5UQqymVQEOK2m54etqZytPTz2zsfdB/F9BQqhL17jXYYtNnvMQA
         xjoiO8eH5ySycLvSpLh6C9qKm7IVysEJxtncXZARzIrwijYoG5yCwSdPcx/RCUNMfZ6d
         +M110GjCRar5faHZqxBgFSNutAyYIXgifz8lyCX6+8Hcwr4/1Ko2G56bIuZzxZQ2jzsp
         j1oMaR9p9Efs0WZxd38evZpUxIEiKiMyNCoGtvI2+t5eyvoUjP1O/V3BfRp7+qt+iov2
         yzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711790827; x=1712395627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=timTxilapKsONbEjau72+Ou1q/7xtxFnJ1b7itFduSs=;
        b=DaMCeKtaLdUCNIlP8OAGq1E/Mm7Ct13x40mEoAyOT9nhYANBvIH91wmlFMOPoTmp5v
         SE9IiB1aCz81uqOZ5NZi0vuLj92Gv+zuz2HPMeC43GBg736wy1P8tCpPmJfc8zjqMwA+
         EJUN0X9lNL3J1Iem9lV7P/fc9xecWM+f+S8z9XPzmp1L25z0vlm7l83XtWymx1PEZQQV
         T7W28o1Z2+T9SbeNZ3fnbwonsFG3YHGoa9E+JIgI79zre44Rv/5hFYtylgtH0yWcqoI4
         ZDM+ryLvvtOX21geTvvx+Ldoeo4vQOenZy7NoWFgV6dyH3aqu68ft2ibLO/QvniRhmIm
         53BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0bjsHb3b1TsIT+qSoR+Nb73Y+n4FYG+iAwEYjOpN6jvYGe0g9J7bNMwGBlaXvP3NjWXGw3u9KK4+T7iyyao8MKkGT2nl/bRIY3YkL
X-Gm-Message-State: AOJu0Yxci6Njyv3vl2OQ281ZsNUlqYIi74p78mGvMbw5L729ZdpgUO2h
	HS27u6L1QybRhIP2hTveFWP5zjngQTBVY+gB9X8iSqFB9wswkWuxk0LFYr0iIhk=
X-Google-Smtp-Source: AGHT+IFHJcCwawyg2Si7LdksytC4gyLn+R/HZviukLaXttZxJvajzvyd8WuNDqYG6brpIYxX1Mpqeg==
X-Received: by 2002:a5d:4491:0:b0:341:8388:31b1 with SMTP id j17-20020a5d4491000000b00341838831b1mr3662835wrq.67.1711790826705;
        Sat, 30 Mar 2024 02:27:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bt30-20020a056000081e00b00341b9e11b11sm6141674wrb.24.2024.03.30.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 02:27:05 -0700 (PDT)
Message-ID: <57f29a15-1076-44de-8b85-83983f5e20f3@linaro.org>
Date: Sat, 30 Mar 2024 10:27:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] dt-bindings: xlnx: Add VTC and TPG bindings
To: "Klymenko, Anatoliy" <Anatoliy.Klymenko@amd.com>,
 Conor Dooley <conor@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Simek, Michal" <michal.simek@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
 <20240321-dp-live-fmt-v3-8-d5090d796b7e@amd.com>
 <a82d525c-737a-4ac4-9d71-e88f4ba69ea1@linaro.org>
 <MW4PR12MB7165889CE7F27A3F0B29DC7EE6312@MW4PR12MB7165.namprd12.prod.outlook.com>
 <c0d70ba9-34ef-4121-834d-4d107f03d7f0@linaro.org>
 <MW4PR12MB716570A3676218F0C6375E37E63A2@MW4PR12MB7165.namprd12.prod.outlook.com>
 <20240329-overture-tank-d20888f2cb6e@spud>
 <MW4PR12MB7165E47719C72CD5CEB68218E6392@MW4PR12MB7165.namprd12.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MW4PR12MB7165E47719C72CD5CEB68218E6392@MW4PR12MB7165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2024 03:02, Klymenko, Anatoliy wrote:
>>>>
>>>
>>> Sorry, I didn't explain properly what I'm trying to achieve. I need to
>>> create a DT node property that represents video signal format, one of
>>> MEDIA_BUS_FMT_* from include/uapi/linux/media-bus-format.h. It would
>> be
>>> nice to reuse the same symbolic values in the device tree. What is the
>>> best approach here? Should I create a separate header in

There is no user of this new header, so I don't agree. Please send
either full work or link your other upstreamed patchset. Anything sent
as "DO NOT MERGE" does not count because it is not an user.

Without the DTS user I claim that you do not bind here anything...

>>> include/dt-bindings with the same or similar (to avoid multiple
>>> definition errors) defines, or is it better to create a symlink to
>>> media-bus-format.h like include/dt-bindings/linux-event-codes.h?

Copying or symlinking entire header into bindings does not help us to
understand what is exactly a binding here.

For example, maybe you encode runtime information into DT (don't do
this) and that's why you need these defines... Or maybe your block has
some capabilities. Dunno, patch was not tested, is defined as do not
merge and is not explaining any of these.

Therefore, please provide complete set of users ready to be merged, test
your patches, provide rationale why this is supposed to be a binding and
why do you think it represents hardware configuration, not OS policy or
runtime configuration.

Best regards,
Krzysztof


