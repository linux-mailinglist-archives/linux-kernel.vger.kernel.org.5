Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18413791DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjIDTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjIDTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:33:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F5CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:33:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31aeef88a55so1552238f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693855985; x=1694460785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Tsex1OAzDJu3wzpU9KrV/kOwc+tIPQRBk9I0xPeeh8=;
        b=HwtEzPyc4I6Gz2TzOhPQnaWlyXRWOXCyDJj7BPnlRk5KgL0GJeYJs2/466E+IB5jJZ
         ihzkjwhERToO9EhK7zJSiVnrVPEWX+7NOzB0O02Xb23HuuctDcgJ3661h4PTtk8/Kt/S
         qPbnzLy6LRk3OM/TwW9efSNn9yIYdXxV1jX68QtWQQATe+h/aGGcf1tLpof9/FHJ2T84
         VLAunj8VnBRcRH94c6ZtVLRKxZRSKG1nFiSdZ2LJ6xqdrTfoUIiYTQfyfyAdkj97cnEh
         pBZ2CslrCZmVMqPiga+vGKddhlbZ9ByquuI5SbWLsabv5VYVJQxx3M3F2uhUxuBXjFHh
         V/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855985; x=1694460785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tsex1OAzDJu3wzpU9KrV/kOwc+tIPQRBk9I0xPeeh8=;
        b=jDHB3yLWpeFVdasOC8JB0yOKnmb9Az5rsfvJYowjnphhd8TqQJ6fvm6cfyqxRU8iHm
         ++hsu+DrfAV4Pdjr3uNfZmTpmmMcaXNq8G81p3GKsd8hAZTeupYxA1X2kwEkEcAiS7/C
         akHnk3Rb6l0W06tNul99XkY3Eo16CBtSWwextDzenDaKSHmigps4XIWUtJ5TvhI/5TkT
         dgVv5bOkCgm6T2fSFZVrGMjC2/8JkLfvsZlC6pgVOQoA2CV8ulx4IMVfieeUhxucARyx
         NQ8Mv4ytWSAt7nPXx1O/tEIfDfw0pl95fz01gS9Q2CleYlJVeVahq3k6aWfMEZbe91xo
         ipoA==
X-Gm-Message-State: AOJu0YxOtaK/xP+9XY2vivgiZD+Y3Urpgca54VF5t64Yns+e+zyUyVRF
        csKdkhO3xeTiG50xnoSGfmn/BQ==
X-Google-Smtp-Source: AGHT+IF7eBiTFxhF9MVS43ySzAQ8NS77q64PkmHzcAz3O/rxnICNOTLBQbzBMMnCJH6BHkayQmSG+A==
X-Received: by 2002:a05:6000:10c3:b0:317:5af3:caa4 with SMTP id b3-20020a05600010c300b003175af3caa4mr8005750wrx.38.1693855985402;
        Mon, 04 Sep 2023 12:33:05 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r5-20020adfe685000000b003143867d2ebsm15354341wrm.63.2023.09.04.12.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:33:04 -0700 (PDT)
Message-ID: <e5ae7178-108f-39d3-673f-f19fa0db1d6e@linaro.org>
Date:   Mon, 4 Sep 2023 20:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 12/15] media: qcom: camss: Fix support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
 <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
 <5714055d-84b9-f60b-ed58-77d86722d71e@linaro.org>
 <e51e0d29-f455-463f-9324-6ee0459df067@linaro.org>
 <3b3682be-5dbd-5e2d-a6c1-7bdf6d3ff8cd@linaro.org>
 <49d5c223-c2c7-4e5c-a0a3-dba86408c272@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <49d5c223-c2c7-4e5c-a0a3-dba86408c272@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 20:32, Konrad Dybcio wrote:
> On 4.09.2023 21:11, Bryan O'Donoghue wrote:
>> On 26/08/2023 13:12, Konrad Dybcio wrote:
>>>> I really don't understand your point. Could you please restate it ?
>>> If we categorized the clocks at probe time (these ones go to csiphy, these
>>> ones go to vfe or whatever), name matching like this could be avoided
>>>
>>> Konrad
>>
>> Yes, I like this idea.
>>
>> I'd like to make that into a separate series. So I'd like to address your concern on the size of the string in the lookup and then punt the clock story over to another series since it will involved churning though a fair chunk of code, yaml and dtsi.
> I can only think of code changes, but fine, this series is large as-is.
> 
> Konrad

Agreed.

I pinky-swear to do this series..

---
bod
