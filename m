Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226D7774973
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHHTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjHHTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:55:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AA5D20D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:07:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d43so17864335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691518047; x=1692122847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/neN/3MAwPWtJfwm6LVkhUVNl60rPtJxXyh7+fqe70=;
        b=IZ/T3cdZkfB6jio2Pqcof/6GBabGgxAb2KGUPkX53mJl99kAmO/9ge4yMcH/hPI23T
         +GENVG7EFdJx1xv1Ho/F7jCDauxFzGNYzq7JM+/gdQuDqjaEQPnCBjTyx9MCA4iaZgp7
         VLswuddza7jPR/1yBQ2/05/DPzmKjtdbL++cToHLPlhQpEmT3LoRylt5SeGDoKYQWU/A
         mTCeDuVCAtZOJf3hyDaXbmoFaFbcpyQi7+JKriruHIhVIEOuoLbnES26DK1bFeFYlP4h
         enyP36BjpE7mNA0uXb/ofFhh8B/CKzc1RpCDqzHZcwwgdbpvi7RplM4ApsXVJyslH7rC
         89Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518047; x=1692122847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/neN/3MAwPWtJfwm6LVkhUVNl60rPtJxXyh7+fqe70=;
        b=j8L8zaEU/y7nHrXX5qtIvTzTmFvz8PSamHArsQJb76eQrCHH++l7m8cDozRYNzUxbs
         OCMz8P8w0JDx1dk1/k958dAm7fgp6jPgwAOduUBwZULYxyj2jHVZwhf6Ej2ZI/6iBqJG
         b20seudZcBKqvcIAiSWczupDjlUTkYYf1WYWh8uBeKEjy67bnmtGR/tCffHO5xa7mPRT
         Rh4aqXOkRoxYEDQH1+MUm2xfeKZwBcJx+3crcftKpi6bg5SIyAHKOAH3gDO0V96U53Sk
         zW5lfg9ql11+EotluOmZxxwHZk2izu9uEd0SYQC07toTSdgWjWIuA4rfIljzI1DTyekw
         SVEw==
X-Gm-Message-State: AOJu0YzY9Q64p/g5+U5VA7/Zce8PDwElVlBiqHg30X+0y/ec0b9Lu0GE
        k6Xad1l2gzxm5aTaTmyuIKVmroxjSjvsY+cmvRI=
X-Google-Smtp-Source: AGHT+IEhz/h88VbIK+Uxv8RtvehzJEb4HtJYyKbQA5Ljg8jQq5fhiYybRtK6Z0XyqhDAHfl5BtRxaw==
X-Received: by 2002:a17:906:ca:b0:994:47a5:a377 with SMTP id 10-20020a17090600ca00b0099447a5a377mr10240779eji.24.1691475723704;
        Mon, 07 Aug 2023 23:22:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b00988f168811bsm6194300ejb.135.2023.08.07.23.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:22:03 -0700 (PDT)
Message-ID: <84fbcc37-d226-b637-caa1-b24ebaf03d58@linaro.org>
Date:   Tue, 8 Aug 2023 08:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] media: exynos4-is: fimc-is: replace duplicate pmu
 node with phandle
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
 <20230807131256.254243-3-krzysztof.kozlowski@linaro.org>
 <20230807231320.svssge6uymw3jiho@intel.intel>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230807231320.svssge6uymw3jiho@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 01:13, Andi Shyti wrote:
> Hi Krzysztof,
> 
> [...]
> 
>> +static void __iomem *fimc_is_get_pmu_regs(struct device *dev)
>> +{
>> +	struct device_node *node;
>> +	void __iomem *regs;
>> +
>> +	node = of_parse_phandle(dev->of_node, "samsung,pmu-syscon", 0);
>> +	if (!node) {
>> +		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
>> +		node = of_get_child_by_name(dev->of_node, "pmu");
>> +		if (!node)
>> +			return IOMEM_ERR_PTR(-ENODEV);
> 
> in my opinion this should be:
> 
> 		...
> 		if (!node)
> 			return IOMEM_ERR_PTR(-ENODEV);
> 
> 		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
> 
> Because if you don't have both "samsung,pmu-syscon and "pmu" then
> the warning should not be printed and you need to return -ENODEV.

Why not? Warning is correct - the driver is trying to find, thus
continuous tense "Finding", PMU node via old method.

> 
> ... and... "*please* update your DTB", the user might get upset
> and out of sheer spite, decides not to do it – just because! :)

The message is already long enough, why making it longer? Anyone who
ships DTS outside of Linux kernel is doomed anyway...

Best regards,
Krzysztof

