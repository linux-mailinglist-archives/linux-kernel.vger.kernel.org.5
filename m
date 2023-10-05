Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77C67B9F87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjJEOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjJEOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23466E98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:40:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3226b8de467so636718f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696488029; x=1697092829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tROpxLYGMDkyFdqUPXWOJc3MtyUdL4H9fegc8WkclBw=;
        b=q6zOiG9xaqUySoXzIkqxRT8ulWdyisWkoPmPI9HKvSI67t5i4+dw9C+o6v6Db+TOVy
         1BYeTbfcrU3ShqpwnPnSlMo84dni4QOcFl4KVZTXB+dLFGKs2QTDSGbqGoRqAHcFwA4V
         R/bRwlQWH5K82MA1SgRWKva+SS5SspVdWQmuQ+z7jdaSDKuBoGJbYHME3WCvumUGE3rX
         3FyiMh9tHIvGq6al/VyJOxRS7wYedtNtc9CPw56M8DOfzvhnzm09YbVRje+eR3IkScBi
         FTwHuUihH/fNW8Bv5bAcrIXbBYlARZ/FB/x6Zz1TbrLnzAT1n+tfUYFKdoxVQ7aTsD/j
         y2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696488029; x=1697092829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tROpxLYGMDkyFdqUPXWOJc3MtyUdL4H9fegc8WkclBw=;
        b=TuqSaxbW7EV0ItJX+DmV1KNDmtvxLxsaY/Ee/lDh4BImH1nBZBbz8FnO7tQ4HtOJFI
         GYgy5eNvcoOCJsXZ69qzMbAhWIX1DSmpi/e3glr62yK8itfoNgu0CY72EIXk/eoM7wKn
         73DJe9DgiwlMrsFGB/xBeWgzfcHH8ulZmGqX7WN+aeD1Jigwq7a0TLnywE6kjJzlMDBv
         uInN9+/YVgbs6kj9eu3pYgWONHgDhIu5G57Q2PY0jVUdkm84ZtIizxRnb9eDHu43G9D/
         mK70P4jjxoDRzY/7Z3GB5fc6phkKd2GnImqEyPSUb+ddHCo4WNjFs0nCqLlZu36ORTK3
         6uvA==
X-Gm-Message-State: AOJu0YyzXZ/phCVEMZ0m1b0ylJAH1/WjqWSkrf8d1r1bbGwGcdVmZPfw
        zLCgi3KQhxHLeQsqN6KB55OQ8g==
X-Google-Smtp-Source: AGHT+IEVJWkytNJYJ735DpbRDrNt+oBa4NgUTSipOTb3lsNog5C0x0m1w6O5C7sBwclpPNVEDHKQGg==
X-Received: by 2002:a5d:458f:0:b0:321:6ff5:9256 with SMTP id p15-20020a5d458f000000b003216ff59256mr3531020wrq.58.1696488029316;
        Wed, 04 Oct 2023 23:40:29 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600000c800b00324ae863ac1sm970129wrx.35.2023.10.04.23.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 23:40:28 -0700 (PDT)
Message-ID: <4e0c9028-832f-24cb-3bf0-1ee98d6ecdf8@linaro.org>
Date:   Thu, 5 Oct 2023 08:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/11] MIPS: compressed: Use correct instruction for 64
 bit code
Content-Language: en-US
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-2-gregory.clement@bootlin.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004161038.2818327-2-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 18:10, Gregory CLEMENT wrote:
> The code clearing BSS already use macro or use correct instruction
> depending id the CPU is 32 bits or 64 bits. However, a few
> instructions remained 32 bits only.
> 
> By using the accurate MACRO, it is now possible to deal with memory
> address beyond 32 bits. As a side effect, when using 64bits processor,
> it also divides the loop number needed to clear the BSS by 2.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>   arch/mips/boot/compressed/head.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

