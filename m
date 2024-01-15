Return-Path: <linux-kernel+bounces-25774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F782D599
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040751C21497
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E8C13E;
	Mon, 15 Jan 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeFc+TNw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C29E541;
	Mon, 15 Jan 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso8490246e87.1;
        Mon, 15 Jan 2024 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705310026; x=1705914826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cy9fwNlwVc+gx5v4xgTuuLAslWCEht9JixYFler0ihI=;
        b=DeFc+TNw55rLVjHJi4e5acW32/YHLUk5yvxkGIhdXuUvjkK2iuhVXT7LzNlVhhuVeL
         8VpYby66oTbzrMghl4xN/Mvkz2EU04H5Y/2X2YAgKaTHrvl6wDuIkLooIMNVpAIoMB1P
         R2VwqAuT70ZFWclJoHjzSDFfQ+xOSad5IpXNpjMFFJsW+Ahi2Fu+yO5kmmYPptqeVTnm
         jsJu2IbdbDopI/oLG3+Ne/u7m+/u2v7lcZfsPr3ZMELCP3GakuiXannGll9lAaCfCKVi
         3bX3KzfxwBRQ3i6e4k+3kwnBUtQE7LfY/aH8vL71C6Q1RZD/RqkbcZwJTJ4qbmuwVsNp
         Vaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310026; x=1705914826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy9fwNlwVc+gx5v4xgTuuLAslWCEht9JixYFler0ihI=;
        b=IPCv8YGOktS8VAS+CaEO4YSW4Piyzl3CxSbT2z0HCrOLIr3u5wdfUwUWgLZI/SKsFe
         Z5UqiSmmtUFnAz+r3CjsA5gCgApgaoUYh8nmOW/qmbGp/XoF4lkpC+sJfuH2HiLUMTDp
         +8Un7hHqfpoJUccCjQzf6chzQJjGwO1kNkerWJVF8/Z73N3OBDotEeL9hXGilFv5Wj0a
         Nf4sV3whBgitSczuosahQv7kZy55K2+K0zo7HF5fnnh8ESCqNvQjJSJndQ7KJdURgm45
         mZlhoEVp8iLsLMvhVb/3ETND7YooPKeZN1hM6+9CKWOegYiStihDoK64mt5+5WwhSXJ5
         ycSA==
X-Gm-Message-State: AOJu0Yxr6nEsl0ouoRkgfPmao8wWHYQxHh12tRpMSMpjY10Ml3D/Z/G2
	MfTGLOQc2OYeGIyrnTmJIhc=
X-Google-Smtp-Source: AGHT+IFVkAtsa7jY4e2HLECu8EaZkrrIuhIak/fnYBbMc0kw2BKoj/V/JALf1m9wVYgJw8E72cjsfA==
X-Received: by 2002:a05:6512:60e:b0:50e:74f3:c320 with SMTP id b14-20020a056512060e00b0050e74f3c320mr3212853lfe.21.1705310026274;
        Mon, 15 Jan 2024 01:13:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id t24-20020ac24c18000000b0050e78aa4b30sm1422245lfq.42.2024.01.15.01.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:13:45 -0800 (PST)
Message-ID: <1d735a95-e5bd-4891-bb44-335958e1f045@gmail.com>
Date: Mon, 15 Jan 2024 11:13:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: test: test gain-time-scale helpers
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <cover.1704881096.git.mazziesaccount@gmail.com>
 <6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
 <20240113161229.48d63b54@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240113161229.48d63b54@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/24 18:12, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 12:12:55 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>> Hence some gain-time-scale helpers were introduced.
>>
>> Add some simple tests to verify the most hairy functions.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> Hi Matti,
> 
> All seems reasonable to me. Some trivial formatting things inline
> + I'm not planning to check the maths as you are the expert in all of
> this so I'll just trust you!

Well, all checking is always welcome. Still, I kind of understand that 
you won't verify everything you see... Oh, and thanks for the trust. :)

> Also if this fails you get to pick up the pieces :)

This sure helps to trust ;)

As for things you commented - Thanks! I'll fix them and respin.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


