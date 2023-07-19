Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D65759292
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGSKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGSKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:18:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893F1BFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:17:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so62357075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689761877; x=1690366677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/12YzBMxFEuL9z1yWxB+UUCkYX6+8C24FFiPRnVOeYs=;
        b=h7/WTUUWaoUzOcX86SFAvjDqKxEWUmwu+YhE3cNW33MrssWBI/fbZ8ND6zHNcXjHgw
         3j8kn05JCeCAbnsife3MAC/9la+wF4PRffF+SRhL+G12LmogFN6K3TioSMpzkLm7KG93
         gVjWA+5C6tI7mcjQ3QVMply/DRiEnOsagoTEPNoAP+HjDSt0XGtXBYMyYc8kkS5SjFn2
         nB2tbt0lWG/K5JQ9lgxdCI1H3FEjIOWMaVhNMTK30fySlZYJmq8/VRj0ettvrI9n1cVJ
         cvsl4W62ZpzX+maxk5mts/VOjiWpHDL2RYFu0v2EkuRPhihuIY+rMNXsS+esJsloML/q
         a83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761877; x=1690366677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/12YzBMxFEuL9z1yWxB+UUCkYX6+8C24FFiPRnVOeYs=;
        b=SLKM+h5TiRa9uf0iDpJxGf+w9NtedRqcrVEkgO1BApnnDa3dKaTfNbeHfXE2Do1NZI
         D7mSZ4E2+lyn3CPRjEglOBOft+FyJN/2EVGxieIdmAG6XAywgKN5732vdXR7fRPOU0z9
         RldytZugGX4CnOqWop5v+VXdc7B6T2Dwjv42vln8L8VaQSc3a11yn2WWfnGjC/L25WxK
         eTRG8dF8cgHjhIOwTuHEzIHGrC3hd0RG8nZ/hBQNvc0x0n1oRsGLgo6AMc392RFOWHPr
         QPvjCfILdkpxY/5A61i+bIae6P+68eG2jkEd5JtZInUkexevfRWlbfTHTI63YRjvzs75
         vWRw==
X-Gm-Message-State: ABy/qLbSOE5vqo6vFwFXS38MIEBYL/CalONQcbCOootRtWdsllJJau8N
        eJq6t66uCBl2weeVa+JU5/MPDg==
X-Google-Smtp-Source: APBJJlH/wReuFNESBCfYGmjiyYJIozOQLKMrl6ckmaNf19lwjXmfAOVCoYhJvsQXenBPnI/4zc4muQ==
X-Received: by 2002:adf:ecd0:0:b0:30f:ca58:a00d with SMTP id s16-20020adfecd0000000b0030fca58a00dmr1786141wro.45.1689761877016;
        Wed, 19 Jul 2023 03:17:57 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d4488000000b0031417b0d338sm4924130wrq.87.2023.07.19.03.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:17:56 -0700 (PDT)
Message-ID: <55c336a4-b268-d2d3-47f3-213300e4e623@baylibre.com>
Date:   Wed, 19 Jul 2023 12:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230707092414.866760-1-zyytlz.wz@163.com>
 <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
 <CAJedcCzR6DzX_aG1KBgrMHDJ1xh=RTA-FrZ+TJ_4KawWpHyYuA@mail.gmail.com>
 <CAJedcCyKv-hdDhWcogDZrC-kY6qtO-H1fDYqjTXMJvCR19MxYg@mail.gmail.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <CAJedcCyKv-hdDhWcogDZrC-kY6qtO-H1fDYqjTXMJvCR19MxYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/07/2023 05:07, Zheng Hacker wrote:
> Friendly ping
> 
> Zheng Hacker <hackerzheng666@gmail.com> 于2023年7月16日周日 00:08写道：
>>
>> Hi,
>>
>> This issue has not been resolved for a long time. Is there anyone who can help?
>>
>> Best regards,
>> Zheng
>>
>> Alexandre Mergnat <amergnat@baylibre.com> 于2023年7月7日周五 22:11写道：
>>>
>>>
>>>
>>> On 07/07/2023 11:24, Zheng Wang wrote:
>>>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
>>>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
>>>> and mtk_jpeg_enc_device_run may be called to start the
>>>> work.
>>>> If we remove the module which will call mtk_jpeg_remove
>>>> to make cleanup, there may be a unfinished work. The
>>>> possible sequence is as follows, which will cause a
>>>> typical UAF bug.
>>>>
>>>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>>>>
>>>> CPU0                  CPU1
>>>>
>>>>                       |mtk_jpeg_job_timeout_work
>>>> mtk_jpeg_remove     |
>>>>     v4l2_m2m_release  |
>>>>       kfree(m2m_dev); |
>>>>                       |
>>>>                       | v4l2_m2m_get_curr_priv
>>>>                       |   m2m_dev->curr_ctx //use
>>>
>>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>>>
>>> --
>>> Regards,
>>> Alexandre

Hi Zheng,

If you asking me to merge patch, sorry but I can't, I'm just a reviewer. 
I invite you to ping the maintainers directly:

Bin Liu <bin.liu@mediatek.com> (supporter:MEDIATEK JPEG DRIVER)
Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT 
INFRASTRUCTURE (V4L/DVB))
Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC 
support)

Otherwise, I misunderstood what you asking me. If so, can you rephrase 
your question please?

-- 
Regards,
Alexandre
