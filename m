Return-Path: <linux-kernel+bounces-45972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABA843888
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B451C25842
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E75C61C;
	Wed, 31 Jan 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bG0fXmC4"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F757884
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688520; cv=none; b=nXRWC0bSqX0rkn/L/GDPc68Di2Q4QHUFFUt0u24kKThq8dck15vcLls3ISV0m5So4MIRdd40SO8Z9WMk7Hhzhl8T4BJHiV+O3U9lwk/yw59iR1p5UnWg4SNhDDHE7ImKUTHVEWeIDVgvpVZCdQ5Mgfz+Nm3bTKkoBlbZVoLajas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688520; c=relaxed/simple;
	bh=lx4FD9Ff2keMEQ0jbaHwSc5jk9qWZ2oAmEPHSTeAEL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdWBdpMS9Eb695Yl/Fu3u0RuN/SEnCgmGrn0x5TtL0C8pbMXLuJRRQ0FajwcbiQlD31JhDozaqkgAklYhTaetOedR7IqPuwGYQQDknDj7U2CSZD8xDHGF7icoV1w65Ai/O75MdBHJua+07OLQ1WY7tH3Y7dz+RFl57NnKw+hOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bG0fXmC4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33af3c7ef60so1696440f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688515; x=1707293315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoLOhMfUIiPj96gmfLJQxWR6opE2jRYSksRV3iTYsaI=;
        b=bG0fXmC46TBAqQzPVQzUNYJLvpERNm7xkVKyNrf3FPK1oYbd9AhpxO/i4TJm8fLYXh
         yJktbycb3OJqWLXkOjH9tEAEBTB3g6MUpFo2ehXW05mbhw6tUWreGEertp1S4+85L08V
         1OcOPbng11aD8vA3A+zzKy7vsH2y7oi9SY0VioIYofwNhI+xD9fEVZlfd9jGIh/k6GFs
         RqpZL0vh8Qy704G1Qz1JVdmaGU1IvbOkHiXoZijoF3HzpwWWE0KvUbtn2Ey6Q6wHkwCF
         oMz3RfoT5DZgHhjYRbyFrkInYGbu2XnHdxl7FB+If6NfUzjc0zMRLrc+6qEReXRQwgGd
         tpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688515; x=1707293315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoLOhMfUIiPj96gmfLJQxWR6opE2jRYSksRV3iTYsaI=;
        b=kDrod2Nyk57jS1GLEwcfQ0bNoUmcgop5k+NDUnjPgHoqZq7nD2VNCLgaWYdpSBH6sr
         vi5XFLwLYgn4Y+vC2lyfhhObrGB4qIgGQWovKrFvKEaUs9ivPeTADjptEBsyYfG1E2RA
         E1jkBKwLCumtg4+uZdMR2u/2hU+3HqJCVDI556YrefK56rp8QTKMtI3ll6KM70cFTEq0
         QRLT0R/qNHrGry1zFYqgqqFFpn7TCiwxmIO3djsl90d+DWUY+mPCbdRW2ilxncQ4HtOR
         SN/8zOHFhrJsQHpn1r9NxcbWzOxnagmJv5HtiFB0H9HRKTozzcUbVfQ0xBbeLvyXz/IE
         A7DA==
X-Gm-Message-State: AOJu0Yz/1O0QrboUM453w+dpdfoszAfcuoUOf/JtUqwRkOsZTrdunqIZ
	FuaUrdbeLSSJILFASWdfMqxOJwy0z+ofiVVU77MnjoovzHluaS9w5j7HO3T9r+s=
X-Google-Smtp-Source: AGHT+IEQSijfWrnfE1x/IhmGOIujlR21eS/1lucETA1cYhPCNsT1emGpr4CSNSjix7aPPjNS9CpWsA==
X-Received: by 2002:a05:6000:1143:b0:33a:fe54:4367 with SMTP id d3-20020a056000114300b0033afe544367mr541995wrx.33.1706688515023;
        Wed, 31 Jan 2024 00:08:35 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bv11-20020a0560001f0b00b0033b0558c5f0sm660263wrb.95.2024.01.31.00.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:08:34 -0800 (PST)
Message-ID: <73bb55f6-4753-4bfb-99f4-75d06d1f772c@linaro.org>
Date: Wed, 31 Jan 2024 09:08:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix control buffer enablement
 on MT7896
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <linux@fw-web.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Amit Kucheria <amitk@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20230907112018.52811-1-linux@fw-web.de>
 <20230913083529.3bgjl6rvfmixgjnd@blmsp> <ZbnX2vfcalNL3yRV@makrotopia.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZbnX2vfcalNL3yRV@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 06:17, Daniel Golle wrote:
> Hi everyone!
> 
> On Wed, Sep 13, 2023 at 10:35:29AM +0200, Markus Schneider-Pargmann wrote:
>> On Thu, Sep 07, 2023 at 01:20:18PM +0200, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Reading thermal sensor on mt7986 devices returns invalid temperature:
>>>
>>> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
>>>   -274000
>>>
>>> Fix this by adding missing members in mtk_thermal_data struct which were
>>> used in mtk_thermal_turn_on_buffer after commit 33140e668b10.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> 
> Kind ping to thermal and mediatek maintainers, please merge this patch.

Applied with master pong

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


