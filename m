Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD2792A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbjIEQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353711AbjIEH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:28:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C77CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:28:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso327000066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693898889; x=1694503689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/G+WsouhuVp8ZLsX8nV6kZmhtaiVnxK3WmX/+yU39RI=;
        b=wSt3EK+3YScVMeVL6F29DLsFC4c4def7i15yt/z4xYb30Wd1B7JBoIxeb3kSCRk6YN
         bx4RgIEK1hIcrrgYmXhLzDmo4dF3tK00Zn95G3QYpg/rUKJStlnk71VU13EVa0Iuja8V
         +d5kC/WpFsU3H5nZYm9bMgoKB+9jcUQYs1/KJsytyGF4YJieRrHj1rd0u9HmksRVhrvU
         1oblaf7WYrSI2+tC/VUxQqQ1nqVntdpcWNT+PVSyKBHmVu5eElULXv+7RwgP1LzBMlk2
         eG/XST9W81bVyy+KlYMbeka5hQkh+4WmK6idhdAmjeMOsgAY35+UhdFc5+YEy15k3QA7
         fPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898889; x=1694503689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/G+WsouhuVp8ZLsX8nV6kZmhtaiVnxK3WmX/+yU39RI=;
        b=T0031VxjzTeIQ6OVAwbr4yZCWwVNXg8y2xKzPs6ddkuWoVUQJsmSordMPaGgN32Lzy
         0Q8Z4MU9YjcyrmvkedZslfIPennPB8vJzgkwIAOASQRUtw4RPNWqD4pJWl+lNGd9HKFj
         n3Jt5K07+L6mF2vbBqF70TyyweUH+08EAJ5KecWdM5UAIFGlZp4Y4rfCnEZ90Xdm1VmG
         Cxeb+zLftHlhL2GLczoh1B8WmKRDMHMhMav4x9Ct7dNrgTuUUgr6ARhuyD6sQINM2yC8
         ePZZNyZLmwjV1zNlCJkXRrnnqdbrJldMVrRRlfITOTJjqjoamqlmdusTXn+A7YEXL3pQ
         5X7Q==
X-Gm-Message-State: AOJu0YzJR1qoys12RxDLTW3iagyEZgDyElVGVch0r3fDbncpeTUSUBxh
        SUbFSPvenOsWSIiLkkJZDfg8cA==
X-Google-Smtp-Source: AGHT+IHeHN6TYjZB5DewP96QFYyGgLgqKs+gYOQUmcZMWK1Sdo86mfxKDCYC7ktZKmebIAyNZZA2Kg==
X-Received: by 2002:a17:907:2cee:b0:9a1:9cc5:ea5f with SMTP id hz14-20020a1709072cee00b009a19cc5ea5fmr9084583ejc.7.1693898889368;
        Tue, 05 Sep 2023 00:28:09 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id lu7-20020a170906fac700b00992e14af9b9sm7090376ejb.134.2023.09.05.00.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 00:28:08 -0700 (PDT)
Message-ID: <537821c6-df3f-6946-b7dc-07ba9db9d416@linaro.org>
Date:   Tue, 5 Sep 2023 09:28:08 +0200
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
References: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
 <20230905071356.18301-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905071356.18301-1-wangweidong.a@awinic.com>
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

On 05/09/2023 09:13, wangweidong.a@awinic.com wrote:
> Thank you very much for your reply.
> 
> On 05/09/2023 15:05, krzysztof.kozlowski@linaro.org wrote:
>> On 05/09/2023 04:46, wangweidong.a@awinic.com wrote:
> 
>>>> Even though it does not look like from the diff, the property is not
>>>> actually used by the driver, because once set, it is read only in loops
>>>> depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The
>>>> variable ddt_num is never set and is always 0, so the loops do not have
>>>> any iteration.  Dropping sound-channel and ddt_num-related loops allows
>>>> to drop empty functions which in turn drop quite a lot of code.  This
>>>> entire code was not possible to execute. 
>>>
>>> The ddt_num variable is not always 0, this variable is defined
>>> in the configuration file. The "prof_hdr" variable is assigned by 
>>> the "cfg_hdr" variable. The "cfg_hdr" variable is assigned by "aw_cfg"
>>> aw_cfg is the data obtained through request_firmware.The specific 
>>> process is as follows:
>>>
>>> request_firmware ---> cont->data ---> aw_cfg->data --> cfg_hdr --> prof_hdr
> 
>> Hm. So you load user-space provided file and assign it directly, without
>> any validation (aw88395_dev_load_acf_check() checks only for magic), to
>> a kernel structure. Sounds bullet-proof. Why using known kernel
>> interfaces, better to implement some conf-file-parsing.
> 
> Could you please tell me what known kernel interfaces 
> can be used to parse files? 

With exception of Audio topology and FDT, I do not think we parse
user-provided files in Linux kernel.

Best regards,
Krzysztof

