Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7076E07F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjHCGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjHCGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:45:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64678E4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:45:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so1045142e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691045107; x=1691649907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPS7PxNSM73cITz5+xQx4Opdzddvfq8C1OqqZ8evqeY=;
        b=EXtiR71mhwuwdPo4BRDwdGMRk2ayLQ7ZmpNp/U1DN15R8NrYVOozcw7R4s0dCB7tOz
         X5g8Y7dWWCLjUXoNoAWbCP4uBzCIkCX4acrKgsVn95MJqde+cyqdjERXodH6rrRwrNWG
         euY1O5Xt814vnE4RudD3Vh71RplhJXGcqBbkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691045107; x=1691649907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPS7PxNSM73cITz5+xQx4Opdzddvfq8C1OqqZ8evqeY=;
        b=R1VFdfKq2zLp+/MiSGzLULkw6OG+PHR6Jz3lqKUb9gj+tss48GfZQ1LZDku2MygGq6
         /h/srNB/7pauH+I4w/XorR9UYtTXn5yGaFKbs4nyxxj9B2ef//bozGZwi/KisoUJWhai
         uE9ZEAGY5n69cT0OKwf2XtTTIxw9nCERHoAg2cF0KlytqnWkxVz45B44SzHK1AXvKwp+
         vyezrg6g7LVxJ/A+4/lU45T0vX/BW4F5JNOFHfxQiDOL3PDPW9hNs26YZuSHGToIcF6g
         IJFSy4DTbxq4RhP8Civk1l2HKTukgd8zSn2EEPLbljDxMs30m9+yN9KYi40/wEMMFyDW
         yDjw==
X-Gm-Message-State: ABy/qLYr5TnB8IXsx2XsAVUTJ6au1pIMSEFB+fv2SapH5PWRot6JfIlK
        TPYKJJKSUqmJESWtzh7zApm6tw==
X-Google-Smtp-Source: APBJJlGV5jtxqAShsHGEOWeKVwx96kPM2l3qJ0Uxld2juEk/rIqFYlumMqTKAYY/MNm/HJayEnzRlg==
X-Received: by 2002:a19:6908:0:b0:4f8:4512:c846 with SMTP id e8-20020a196908000000b004f84512c846mr5619988lfc.49.1691045107488;
        Wed, 02 Aug 2023 23:45:07 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7d6c4000000b0051e2cde9e3esm9733504edr.75.2023.08.02.23.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 23:45:06 -0700 (PDT)
Message-ID: <739f81db-4ec2-fe07-a6df-5c1f42588653@rasmusvillemoes.dk>
Date:   Thu, 3 Aug 2023 08:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/8] rtc: isl12022: battery backup voltage and clock
 support
Content-Language: en-US, da
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
 <55c19de0-2465-cc4a-6ec7-fd524816fd2b@prevas.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <55c19de0-2465-cc4a-6ec7-fd524816fd2b@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 16.31, Rasmus Villemoes wrote:
> On 15/06/2023 12.58, Rasmus Villemoes wrote:
>> The current handling of the low-battery bits in the status register is
>> wrong. The first six patches fix that and implement proper support for
>> RTC_VL_READ.
>>
>> The last two patches allow describing the isl12022 as a clock
>> provider, for now just as a fixed 32kHz clock. They are also
>> tangentially related to the backup battery, in that when the isl12022
>> is not used as a clock source, one can save some power consumption in
>> battery mode by setting the FOx bits to 0.
> 
> Ping. Any chance these could be picked up so they make it for v6.6?

Ping^2.

Rasmus

