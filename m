Return-Path: <linux-kernel+bounces-90584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE048701B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0362867A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D83D0DD;
	Mon,  4 Mar 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frSrwHqN"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368C24B26;
	Mon,  4 Mar 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555923; cv=none; b=IgFM9Dj5T8zdLT9/KE4fMYS0t7R3+zJTigBDD9DPAyIiRJpGh5vEkkqQD+UfyIHburXjScxJ4FnvE8YqPDPF4Y5wi5+Z9CPUJYErGzvzmGo64K24BwhgHRkq/28WxENqwHTzIAr+b4KH60+vZcFl4hAHFCXeikfux6e2enrrn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555923; c=relaxed/simple;
	bh=OfcgTuK8wjlhzTFHyDLwrNZexW73nuPYROheqJqaYhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwdJ80rds01zaz7GyWxSQNWPXtH3woOzM1NsR1po0S9odTtkh/Tqnq8dNC16bKu6c8HcuQWa5Bu9UTafqyLc3JH0xoG3Vdc44EqJbXrnFBtxzxUCFXmJAzVmiACEyyORyb3EmDormPQVH9JrjER2XpWY9EaFaU8l8jR603FM4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frSrwHqN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d208be133bso58530241fa.2;
        Mon, 04 Mar 2024 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709555920; x=1710160720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHZ28VB1pnjr1brdf6bxrBLD1jC1sXFuZOWsuCT2EIQ=;
        b=frSrwHqNemiMstn6cNi7OTQf/I0FYbgITyjMLdkm/Smd8Cjak5nQ5W07uxmWBx7Ew7
         fVT4flPPFF2rqpO6Xutk4mBTqXSJWwDnaMrxa7b70SsU6YPHiTyFGpe0M+uXwSdP0y/v
         UpTnzR1tCtD+sAH1GZaJZgPjaJh8sxK1OjbEILq5zr+G5Vfg4tVUrAuSL9GCJ0/ZlQow
         IUgUgYwSGPe0ZaOIX452YdkrHcrkTAn1VzjVT3Y3lGN9JuCCxKGpxMge5AylUqAmzwh8
         eUnePfb2MthNKUv20+AIG2zr8A8YnOC0cfi8gg8QKrs/SlHt7RFnuawjqci/XhPyVH6U
         GPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555920; x=1710160720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHZ28VB1pnjr1brdf6bxrBLD1jC1sXFuZOWsuCT2EIQ=;
        b=aVVJfDBwNQLF/QuAjnXp1VJZbV26dKohZE08cAnubUZE1XGnu9FZOj/2oBWYrZMD7j
         aRueRpkbQul0jkRVFOVAx1PU8UCEX6ZreIvF0E4Rgj/wEWJpqJT9RmEgoAbFIaUZoxF7
         QNyt2KHLwgcVsFdHG9okc+yEhLKPCBAska9zbY63AIVLvD79uoR0xhzkDmveGaoqtE3q
         HJsDd5xQUNWCBy0+30l2A1B5Dzb6Ky8KQy+EfG2aqsga0Y4zXqM/HNoF1QNWVTWq4YZa
         T6c4Ag50/k2MVezujb08oUPoemv+cwTUUePVZRMurek0TxgX3Vj5XHqB9/piU7/Yjock
         L3sw==
X-Forwarded-Encrypted: i=1; AJvYcCXPGpKj7gtc0C84gbBWk0pFmwkEeQwzkmVyki5yz6Ug5rTSLBdx28zAV6oHK936TzaiHSGqyGZLxu3lkoNK4pmaCT3lLxYBvFAe8b9niDG9RbZ6UhcjCRFhV2XqHm7bLBJxRG8R3Ak5gw==
X-Gm-Message-State: AOJu0Yxr/bm7ZFTpH83RsNecttqMIsfRfRp6zpkcVABEcuIlFioLuAn7
	CrDuY5n93kgrAja3Gej6vggF24wpPpOvStcM228aN1iyIpwHUxyLoYc95Vvx
X-Google-Smtp-Source: AGHT+IFLvZrjl3Z3hS4Ijzcg0R1qz44gn4YmTel54s1D1roYPGabTdjG2C0SqnbDtLDh8zqbfCafTg==
X-Received: by 2002:a2e:9d03:0:b0:2d2:50bc:99d6 with SMTP id t3-20020a2e9d03000000b002d250bc99d6mr5872383lji.35.1709555919681;
        Mon, 04 Mar 2024 04:38:39 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::5? (drtxq0yyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:7426:df00::5])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e8055000000b002d2b28a77f3sm1021060ljg.108.2024.03.04.04.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:38:39 -0800 (PST)
Message-ID: <ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com>
Date: Mon, 4 Mar 2024 14:38:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Support ROHM BU27034 ALS sensor
Content-Language: en-US, en-GB
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: linux-iio@vger.kernel.org, Shreeya Patel <shreeya.patel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Paul Gazzillo <paul@pgazz.com>,
 Rob Herring <robh+dt@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1680263956.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho peeps!

On 3/31/23 15:40, Matti Vaittinen wrote:
> Support ROHM BU27034 ALS sensor
> 
> This series adds support for ROHM BU27034 Ambient Light Sensor.

I have one word for all of you who worked to get the ROHM BU27034NUC 
driver working in upstream.

Meh.

I just found out that the BU27034 sensor which was developed when I 
wrote this driver had some "manufacturing issues"... The full model 
number was BU27034NUC. The has been cancelled, and, as far as I know, no 
significant number of those were manufactured.

The issues of BU27034NUC were solved, and new model BU27034ANUC was 
developed and is available in the ROHM catalog.

I did also learn that this new model BU27034ANUC is _not_ functionally 
equivalent to the BU27034NUC. I am currently clarifying all the 
differences, and I have requested the HQ to send me a sample for driver 
development and verification work.

This far I've come to know at least following differences:

- The DATA2 (IR) channel is removed. So is the gain setting for it. This
   should very much simplify the gain logic.
- Some of the gains were removed.
- The 5ms integration time was removed. (The support of 5ms was severely
   limited on original BU27034NUC too so driver did not support that
   anyways).
- The light sensitivity curves had changed so the lux calculation will
   be changed.

One thing that has _not_ changed though is the part-id :rolleyes:

My preferred approach would be to convert the in-tree bu27034 driver to 
support this new variant. I think it makes sense because:
- (I expect) the amount of code to review will be much smaller this way
   than it would be if current driver was completely removed, and new one
   submitted.
- This change will not break existing users as there should not be such
   (judging the statement that the original BU27034NUC was cancelled
   before it was sold "en masse").

It sure is possible to drop the existing driver and submit a new one 
too, but I think it will be quite a bit more work with no strong benefits.

I expect the rest of the information to be shared to me during the next 
couple of days, and I hope I can start testing the driver immediately 
when I get the HW.

My question is, do you prefer the changes to be sent as one "support 
BU27034ANUC patch, of would you rather see changes splitted to pieces 
like: "adapt lux calculation to support BU27034ANUC", "remove obsolete 
DATA2 channel", "remove unsupported gains"...? Furthermore, the DT 
compatible was just rohm,bu27034 and did not include the ending "nuc". 
Should that compatible be removed and a new one with "anuc"-suffix be 
added to denote the new sensor?

I am truly sorry for all the unnecessary reviewing and maintenance work 
you guys did. I can assure you I didn't go through it for fun either - 
even if the coding was fun :) I guess even the "upstream early" process 
has it's weaknesses...

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductor
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


