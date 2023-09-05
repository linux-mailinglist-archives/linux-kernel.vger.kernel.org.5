Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06450792B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjIEQz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353524AbjIEGci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:32:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817F197
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:32:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso2825563a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693895552; x=1694500352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2zvcX9pHacLNf0ykPfp3m/i4l5HADAdXshgrpjJZEQ=;
        b=XaeiSU5By5pwwz5I4KYOuaxqY2NsCj8+zqaqhjJpXo7n8Qw12PABE0ko14lzAcnjdQ
         L8rSSov3hGi3C4emDtqSXbjybFrslYnIy5QbenrJYCpzRgTZKqnr97GNhsPgsXCOKr9y
         EQ2eB+9Zh9/aseyXjYPPIjZoCN8MmCwUafh3qlRcsqju8IykobYECs4UlNB0ia2IuaV3
         ECQDdyaKON2Vj9UqOsK+D8aFKkY7XJsP7Ht76kQPtC/u8OBbWnUWjpsPk4J2B7Ex5ScB
         SVd6UnXgo4b2wTLQca/B7W0JiaijQZxwAcOZyYrXABC9FiFqpWBV5+INjTKeQ58RiDhw
         jAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693895552; x=1694500352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2zvcX9pHacLNf0ykPfp3m/i4l5HADAdXshgrpjJZEQ=;
        b=i6Ni/t7L9zMPBB/ycjORPAoTcU5eRszZ63KeK5VcAQmB2ZEQEFpRHJ+LfE0v3kqFs0
         c+Z7jfn25b5hVnp5UFiLBTvmPNrERO6J5aPuyOZLAgio0TPSpE4Fn1PhHSygZnf1CS3u
         SqTVnHlU8vljVNlBuK/ZaWpuEF2dpnOB8B05sRM0Kx6XufDTGTPWeYzTNtiFLL5jj1tt
         kK3jr/9zbDrVVe+Wd9cDUudXofWv2puEY7J8yTIDOLW1HYNSExbRm3tuhRlRpfr/CoRj
         3s1nYJ170ZSkSxlZlRj4sh0cmngsT9ae09b2HViPFYBrP0H1qFWTsWaSQiB6XhQ7Xivb
         IocQ==
X-Gm-Message-State: AOJu0YxVRTgwDpMfSq28Kz59m3U5ZrFCSjNNdGSM9zCV+UQNs48bybBu
        LC8f5vk7iKAEvQrsRRN6W0U9yw==
X-Google-Smtp-Source: AGHT+IHO45N6+V7Ag6AL53zjf/NBrs1e+jux62HnuWPxGdyF6+qb4L+PhPB7YuMqE2GhKQWyxhm3xQ==
X-Received: by 2002:a17:906:73c7:b0:9a5:deef:886 with SMTP id n7-20020a17090673c700b009a5deef0886mr8787456ejl.43.1693895552487;
        Mon, 04 Sep 2023 23:32:32 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0099297c99314sm7148980ejp.113.2023.09.04.23.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 23:32:32 -0700 (PDT)
Message-ID: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
Date:   Tue, 5 Sep 2023 08:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused
 sound-channel property
Content-Language: en-US
To:     wangweidong.a@awinic.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, yijiangtao@awinic.com
References: <20230904125309.43350-3-krzysztof.kozlowski@linaro.org>
 <20230905024659.15071-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905024659.15071-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 04:46, wangweidong.a@awinic.com wrote:
> Thank you very much for the proposed patch, but I have some 
> questions that I would like to discuss with you
> 
> On Mon, Sep 04, 2023 at 12:53 PM +0200, Krzysztof Kozlowski wrote:
>> The Devicetree sound-channel property was never accepted and is not
>> allowed by bindings.  It is not used by any upstream user, thus
>> considering that it was never documented, should be dropped.
> 
> This node property is intended for use with multiple PA, to
> load different configurations for different PA.
> Can I add this sound-channel in the "awinic,aw88395.yaml" file?

Maybe?

> 
>> Even though it does not look like from the diff, the property is not
>> actually used by the driver, because once set, it is read only in loops
>> depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The
>> variable ddt_num is never set and is always 0, so the loops do not have
>> any iteration.  Dropping sound-channel and ddt_num-related loops allows
>> to drop empty functions which in turn drop quite a lot of code.  This
>> entire code was not possible to execute. 
> 
> The ddt_num variable is not always 0, this variable is defined
> in the configuration file. The "prof_hdr" variable is assigned by 
> the "cfg_hdr" variable. The "cfg_hdr" variable is assigned by "aw_cfg"
> aw_cfg is the data obtained through request_firmware.The specific 
> process is as follows:
> 
> request_firmware ---> cont->data ---> aw_cfg->data --> cfg_hdr --> prof_hdr

Hm. So you load user-space provided file and assign it directly, without
any validation (aw88395_dev_load_acf_check() checks only for magic), to
a kernel structure. Sounds bullet-proof. Why using known kernel
interfaces, better to implement some conf-file-parsing.


Best regards,
Krzysztof

