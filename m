Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1077B925
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjHNM6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjHNM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:58:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD6E5E;
        Mon, 14 Aug 2023 05:58:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31969580797so1820113f8f.3;
        Mon, 14 Aug 2023 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692017889; x=1692622689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbbXebAZtMUNmV90AHXW1KJF/2O/Z1eCDRHkfVuGCqM=;
        b=mggHO9wNUGKdIxBSmttxtRds8Dwl8l4xN4yIYrY3KaNmB+lXA9PFYqb78bByujgEqA
         IgmCNj3Gjo9vo95YR0soFOTou0LPUPEUsjYGoAc53Ci/KAq2139xhcLaGojN6MrlcyWW
         kBBooIsX6t15OVEsEm/QdekD4223L1dYKAYGXDHpRSZ0822hcVSoEvwGd+jKSQ/ovmfz
         kMm2wqV9LszspinukUvWQKsmy7qPswRELdf3TbqvFhMUvx3tLNXvaHORGVhPjyfKGyGM
         iATasOoSh12g24h8TxGFkpCb6W3N6wliNAO7VhjYtxa8J6sxg3jrJ70/uXh+AFM5W1Hm
         xf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017889; x=1692622689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbbXebAZtMUNmV90AHXW1KJF/2O/Z1eCDRHkfVuGCqM=;
        b=ks8bz8+4pIIsbV9m0EN/A+wRMqydk9bqqeEcvx2vAMAq0VSorNxATdsx2zjif6rU+A
         PeJltZtTwC8WeQypL2H5p1vFcKUMZt2JRSgx92oTCp1pdp7B55cJ8RHcsB5gz3f4OxdI
         yw0Ng8AbEF5ra6uSrhbkg0U8ViMcOZ2AW1SklyhtdP00AV2L1gULjEey7T1qZM3ebuFi
         n1JOQETVm05d8NePj4bslA6/R21wV3NAHlLHy8skqR7BPS1kv0O7D6m696V1MWuZMMx6
         TME4O7JGvIT/dlbWSGZ2Fruyw2jsdQSaX4p4mbHpTObCVDi/77voFAeFBzjT5fBM9rHw
         7pKg==
X-Gm-Message-State: AOJu0YxKb/LDvHU6SiYEa5VbBeKcDCdFaS/HMo4kMrNhbuJ6ve68q5ng
        03QA39+7vDzWoniU5T72lb0=
X-Google-Smtp-Source: AGHT+IEHu7hDudKix0NRngmUvdiDtNDlw331dBhjaFF2AOWL16biR9IWjd1H0TIp+KGO6pW1ngDShA==
X-Received: by 2002:a5d:4d0a:0:b0:317:70da:abdd with SMTP id z10-20020a5d4d0a000000b0031770daabddmr6212001wrt.59.1692017888983;
        Mon, 14 Aug 2023 05:58:08 -0700 (PDT)
Received: from [192.168.69.226] ([37.63.23.38])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b0031759e6b43fsm14404279wrw.39.2023.08.14.05.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:58:08 -0700 (PDT)
Message-ID: <d80b5338-2eca-0223-d2a7-d6f7d39a28ba@gmail.com>
Date:   Mon, 14 Aug 2023 15:58:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
Content-Language: en-US, bg-BG
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <e18b951e-7f15-2c67-9099-c45ea7f67daa@linaro.org>
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <e18b951e-7f15-2c67-9099-c45ea7f67daa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 28.07.23 г. 17:01 ч., Dmitry Baryshkov wrote:
> On 28/07/2023 16:23, Vikash Garodia wrote:
>> This patch series introduces support for Qualcomm new video acceleration
>> hardware architecture, used for video stream decoding/encoding. This 
>> driver
>> is based on new communication protocol between video hardware and 
>> application
>> processor.
>>
>> This driver comes with below capabilities:
>> - V4L2 complaint video driver with M2M and STREAMING capability.
>> - Supports H264, H265, VP9 decoders.
>> - Supports H264, H265 encoders.
> 
> Please describe, why is it impossible to support this hardware in the 
> venus driver. We do not usually add new drivers for the new generations 
> of the hardware, unless it is fully incompatible with the previous 
> generations. Let me point you to camss or drm/msm drivers. They have 
> successfully solved the issue of supporting multiple generations of the 
> hardware in the same driver.
> 
> Unless the "iris3" is completely different from all the previous 
> generations, I strongly suggest spending time on restructuring existing 
> venus driver and then adding support for the new hardware there instead 
> of dumping out something completely new.

AFAIK the major differences are HW IP and firmware interface (by 
firmware interface I mean a protocol, API and API behavior). The 
firmware and its interface has been re-written to align closely with the 
current v4l2 specs for encoders/decoders state machines [1][2]. On the 
other side current mainline Venus driver firmware is following interface 
similar to OpenMAX.

There are incompatibilities between both firmware interfaces which 
cannot easily combined in a common driver. Even if there is a 
possibility to do that it will lead us to a unreadable driver source 
code and maintenance burden.

Vikash, could elaborate more on firmware interface differences.

[1] 
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-decoder.html

[2] 
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-encoder.html

-- 
regards,
Stan
