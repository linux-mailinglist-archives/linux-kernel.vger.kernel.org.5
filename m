Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A767AD555
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjIYKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIYKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:07:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A5A3;
        Mon, 25 Sep 2023 03:07:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so88768671fa.0;
        Mon, 25 Sep 2023 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636420; x=1696241220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z5EPQJfduzTV0uZ8cbVkAvVHIT8W8XjB1RDxXsG0uQ=;
        b=UOydjEQ3xZwMoQdJM/ASIbWX/7F6JNAunu11acMj00hcPGpLGISbEJN6HRicrC1PTw
         Em8X9set5u5tRc0dHsXSDMMa48B0g56Jg8iQG1nH1oqC6CtzSKHcnIPtNst8zSjehnph
         c+wNDL1PHC41fqrFIsjWCbyJxR+jsfOaOtpViaBDlDV4KhNVVTyWCA4tw8Sic0Nw67pB
         6zfo9U1mm/M93tyq1p4FF3zao42TWb6vaZyffm4r/IK/OogjItXaMUbQNhG9T9L3PD+b
         DWsw2ONjsVJpAkbg7AQNtcotUVZ7lIq1msVm1S6IPedpAEazcK4SIwgcYssPFh2vT+y+
         DmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636420; x=1696241220;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z5EPQJfduzTV0uZ8cbVkAvVHIT8W8XjB1RDxXsG0uQ=;
        b=PhnpkDcgAA3NzEwFsD/r55e4Bo66Ue6WPsE2z8+T5j+q/vOT6MPPOamn1UwgcdugNC
         16ZO+LMioHvX7E1+8sj6zfuNjcRY7MsMF0IbjNesc4XHzssq3JVLtc/9Xvo8zY1ENW/H
         9FsB2gQW/gvQbE0VYwk5GTTgRoOh0ToSRsG7iESCtX0guxb9clISP4bpZ7EvdsFIAK1U
         w7thJJJs6FAW0bummcn709NQGR8V19/5hs+xJR83MAq6n533AupWkT0CoKt0WTrFy+Vy
         ZW7hTCQ8eyIXymAj6yb3J8EMBVcjSWjnX3kjFuFBth+yzKAjif9+jQusBCQlEyFlECcR
         OLHw==
X-Gm-Message-State: AOJu0YzBqEBm03Sa5Ap35OfOmk84xRU083VD6sIDi7Pymm2fMvngc7cW
        /RyMgJLZH4Wrw+JPWlvXRzzYD6vLz0A=
X-Google-Smtp-Source: AGHT+IHoCaKYeXsipyEPM+3KdHv/PHB5LHOP2AJmKe1d4oZE0Tn/f9yhENYhWS/7GYu3jYwmQJ8iVQ==
X-Received: by 2002:a05:6512:488e:b0:502:ffff:feff with SMTP id eq14-20020a056512488e00b00502fffffeffmr4502918lfb.58.1695636419977;
        Mon, 25 Sep 2023 03:06:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id ep30-20020a056512485e00b00500cede2786sm1767687lfb.65.2023.09.25.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:06:59 -0700 (PDT)
Message-ID: <db0e1bf8-8218-5e96-216c-aa3886e88001@gmail.com>
Date:   Mon, 25 Sep 2023 13:06:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1695380366.git.mazziesaccount@gmail.com>
 <24a577e6e157e1199817ab36631cec51675ef3ca.1695380366.git.mazziesaccount@gmail.com>
 <20230924170726.41443502@jic23-huawei> <20230924171007.2012a879@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: try searching for exact scan_mask
In-Reply-To: <20230924171007.2012a879@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 19:10, Jonathan Cameron wrote:
> On Sun, 24 Sep 2023 17:07:26 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Fri, 22 Sep 2023 14:17:49 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> When IIO goes through the available scan masks in order to select the
>>> best suiting one, it will just accept the first listed subset of channels
>>> which meets the user's requirements. This works great for most of the
>>> drivers as they can sort the list of channels in the order where
>>> the 'least costy' channel selections come first.
>>>
>>> It may be that in some cases the ordering of the list of available scan
>>> masks is not thoroughly considered. We can't really try outsmarting the
>>> drivers by selecting the smallest supported subset - as this might not
>>> be the 'least costy one' - but we can at least try searching through the
>>> list to see if we have an exactly matching mask. It should be sane
>>> assumption that if the device can support reading only the exact
>>> channels user is interested in, then this should be also the least costy
>>> selection - and if it is not and optimization is important, then the
>>> driver could consider omitting setting the 'available_scan_mask' and
>>> doing demuxing - or just omitting the 'costy exact match' and providing
>>> only the more efficient broader selection of channels.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> Whilst I fully agree with the reasoning behind this, I'd rather we
>> did an audit of drivers to find any that have a non logical order
>> (one came up today in review) and fix them up.
>>
>> A quick and dirty grep didn't find it to be a common problem, at least
>> partly as most users of this feature only provide one valid mask.
>> The few complex corners I found appear to be fine with the expected
>> shortest sequences first.
>>
>> Defending against driver bugs is losing game if it makes the core
>> code more complex to follow by changing stuff in non debug paths.
>> One option might be to add a trivial check at iio_device_register()
>> that we don't have scan modes that are subsets of modes earlier in the list.
>> These lists are fairly short so should be cheap to run.
>>
>> That would incorporate ensuring exact matches come earlier by default.
> 
> BTW I'd have sent these as a separate series as there is potential that
> this will distract from or slow down the driver + not all the CC list
> will care about this core cleanup.

I was not so worried about the driver being postponed. I was prepared to 
suggest to merging a subset of the patches if need be - while I can 
continue work with the rest of the series ;)

What comes to people being interested in the core-changes Vs. people 
being interested in the driver changes - I'd expect the core changes to 
concern much wider audience than the driver changes. But yes, knowing 
the amount of mails people go through, limiting the recipient to most 
relevant ones never hurts. Besides, I think there is no 
conflicts/dependencies as driver changes don't change core/tools, and 
core/tool changes don't touch the driver so splitting this to two series 
should be trivial. Will do that for next version.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

