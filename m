Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4757E2104
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjKFMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjKFMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:11:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AA1738;
        Mon,  6 Nov 2023 04:10:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so4721643e87.0;
        Mon, 06 Nov 2023 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699272651; x=1699877451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMxegShV/D6NDyDRrRXdx2NxWkZkXKbvNLRDr7qvSs4=;
        b=kV4p4gsqymTKaD6AUPjx2GVku+CpIOGRGNyQjp6jKsmnqTvGGspuUyEAh05ZhCoj5s
         oVOlFAxXDx9aipY+40arstYT6aFbfjmpZe6FjhUaacYmIqX3nx68WLpAh+FjVUj4LtLR
         JTC7V2c457EMUBDfb1eDO0qmp5rORWt7l5zrD+ks1I1v3tB9Ah2KBPtecMjD6GymUGpF
         LFCLeeyjubA4XX4RAoZiJnC2QM98kls3rSrph0ZNcwxGRHTC2FsY471AUCKrwwcDLGCv
         mM7iD41VtjWWS1PSEtLTaSetRHBH19uhrrtjZT01KcDJJCYKXtRtvZE6C3tsrF8aIJRO
         M1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272651; x=1699877451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMxegShV/D6NDyDRrRXdx2NxWkZkXKbvNLRDr7qvSs4=;
        b=Qt74JdD7QWtmavdWhLxfOHs+DhbuxSynqbxDdM7Ci5Q5zXHWTVE32zK0PGlwTlPUE7
         lV6mz/ffEtuyLB9bud2xx8PvvYMEUoTxbqnB+ihigv+7JpDOYEEgfCVUvpPmcvas5sJU
         LdU5eEW29afIcQH7zYYlIdMFGslIkX7WBTvx8Nxeo8nomVcwqv4BBHb8X+GIqhRQA5rU
         x4oggtKBxzgsrLNnyXXqJNL97uSSC2jG7mjf3McGyzky2SYcyVKL5fS8UaNWUdXLHQrH
         5Yaz/yRe32evFB435hYCpi2jRkpeD1b0RtKZ9RqoJPgMhylbISc19JjTSkGVHBEfNgxA
         fkTg==
X-Gm-Message-State: AOJu0YyCZosvCySKJdpSHPKaIIvDLrGERfyqZ9hJNZdEvCVpZlwajpvQ
        CFjBHahn1ZU+Tp3iaAKQWfGvQB7Drm+rvg==
X-Google-Smtp-Source: AGHT+IGNanNmPB4DrHOGumNqmVz/FngXrrvprQBfKmGteF6jUdxivzS47dDhcdO9kE9MW4pY0/HctA==
X-Received: by 2002:a19:ca07:0:b0:4ff:839b:5355 with SMTP id a7-20020a19ca07000000b004ff839b5355mr3729383lfg.18.1699272650459;
        Mon, 06 Nov 2023 04:10:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id x1-20020a056512130100b00507a7f55a92sm1129131lfu.61.2023.11.06.04.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 04:10:49 -0800 (PST)
Message-ID: <e995ee76-7dc3-4a4a-80a3-fca1ac7c5a9f@gmail.com>
Date:   Mon, 6 Nov 2023 14:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <2974aa13-796c-49ef-bef7-fd7f3f9b7f49@tweaklogic.com>
 <20231106111355.2f8dfaa1@jic23-huawei>
 <307f93f9-2a41-4704-ac4f-8d1e427e5060@tweaklogic.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <307f93f9-2a41-4704-ac4f-8d1e427e5060@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 14:04, Subhajit Ghosh wrote:
> On 6/11/23 21:43, Jonathan Cameron wrote:
>> On Tue, 31 Oct 2023 19:08:08 +1030
>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>
>>>> Scale on the intensity channel is interesting...  What are the units?
>>>> There tend not to be any well defined units for intensity (as opposed
>>>> to illuminance).  There may be gain on the signal, but it won't be 
>>>> in untils
>>>> that map directly to a scale userspace should apply.  This is one of 
>>>> the
>>>> rare reasons for using the HARDWARE_GAIN element of the ABI.
>>>>
>>>> A tricky corner however as relationship between raw value and 
>>>> hardwaregain
>>>> is not tightly defined (as it can be really weird!)
>>> Hi Jonathan,
>>>
>>> Thank you for taking time for reviewing and clearing all my tiny 
>>> doubts and
>>> queries especially for the dt and versioning part. Much appreciated.
>>>
>>> In the above case, should I not expose scale for the "clear" channel? 
>>> Rather,
>>> how should I expose the "clear" channel to userspace?
>> What is the scale?  What units to you get after applying it?
> The scale is in Lux. The output after applying is Lux.

Hi Subhajit,

I am by no means an expert here but maybe you could check if the channel 
should be of type 'illuminance'? (To me 'Lux' sounds like an unit of 
illuminance rather than intensity).

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

