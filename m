Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC917E0F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjKDNCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjKDNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:02:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B71B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:02:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso3076059b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699102952; x=1699707752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFVAhVDAedSPFBRNn04JrHWzW4kv30ibC/cuBpR5pcg=;
        b=e4Y3PWHXnxbtDgvOZQsFeq05zcz0zcyN/Uh78h+cPQRW85MLshaVXteuY+5FCeikcc
         NrtPUkLmmKcZCf08pOM0+yLWP/2kiSMHmOi/2YsLkbmtEn1hkjwpRxzxOjspRJ1tXCPy
         jSsS9nc51jXRB4DGAKTN4z6IAMcJh4bM+K9UfNkIsz4qfKKzuElkrVph8MoTQoBbGGto
         rgK0kC5G14t94CRNrTXd5Msz5eVGVzRGTwVQcXMZooW4CQpWwHEYiM/C4TpX4UuNYYaV
         y0yJ4RXgFfMPKs8p1/m9SuJIPqWE5HP61SxL7IMG7zTGQbWY2GAJ4/ppb3QWGh25zuHg
         l0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102952; x=1699707752;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVAhVDAedSPFBRNn04JrHWzW4kv30ibC/cuBpR5pcg=;
        b=YmPrUG4Z/owUBqyMKRRjy06CZvE16QOZGuW+QaxpxmuznOfXXrCObm1hw7qwnv3SE8
         oMLuC9GhiGnXa/Sr0MBwIBjdqacoMVb/IIZchMUkwwGOtGEPqP5Mny9e30j0Y8oaRVvY
         s+jWfwbzlSeM7tbxqWynG/3x42hKW+Y0nlXIohWSAMj4B4fvONBbkgnDe0NECN5kTrUS
         reyTKPnd7JWU6+BLY1n5VEWOHL8VnOzARxg0eJjx2lgyGruEzuB8P46HcAqeV2+VvZ14
         skmzGjE0GEQQCaPeVsi61k+pZSKfGFWaUu/gqcuHe+++CUX3/xvS2E8n5KZDuyPfKyvH
         HX+g==
X-Gm-Message-State: AOJu0YwlyLUItWdaHaY8vo0yq3VO6BmvuX+3HTD3cwSS50JEtnVuUOQ2
        MfaGthp61XhKlHO2lgqqEVc=
X-Google-Smtp-Source: AGHT+IGb2vdo0cD4NjwXX5OmI6gWBS7QEBhZ6vsJMldsGy5t93N5hQHbF6HT7pFJFA7qYJp4Mni0UA==
X-Received: by 2002:a05:6a20:7348:b0:17a:eddb:ac6a with SMTP id v8-20020a056a20734800b0017aeddbac6amr31496489pzc.6.1699102952530;
        Sat, 04 Nov 2023 06:02:32 -0700 (PDT)
Received: from [192.168.1.11] ([27.5.100.249])
        by smtp.gmail.com with ESMTPSA id f20-20020a635554000000b0059d6f5196fasm2844708pgm.78.2023.11.04.06.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 06:02:32 -0700 (PDT)
Message-ID: <2bb714be-9511-4f79-a633-9f4467a6dcba@gmail.com>
Date:   Sat, 4 Nov 2023 18:32:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: avoid variable reinitialization
Content-Language: en-US
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
        airlied@gmail.com, Qingqing.Zhuo@amd.com, alvin.lee2@amd.com,
        wenjing.liu@amd.com, jun.lei@amd.com, Samson.Tam@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231024181134.48066-1-bragathemanick0908@gmail.com>
 <744beb05-1327-401e-a961-edfe63bd8927@gmail.com>
In-Reply-To: <744beb05-1327-401e-a961-edfe63bd8927@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/10/23 20:17, Bragatheswaran Manickavel wrote:
>
> On 24/10/23 23:41, Bragatheswaran Manickavel wrote:
>> The member variable enable_hpo_pg_support is already initialized
>> and hence the reinitialization instruction can be removed. Issue
>> identified using the doubleinit.cocci Coccinelle semantic patch script.
>>
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
>> index 99d55b958977..1fd9df8da09c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
>> @@ -739,7 +739,6 @@ static const struct dc_debug_options 
>> debug_defaults_drv = {
>>       .disable_boot_optimizations = false,
>>       .disable_unbounded_requesting = false,
>>       .disable_mem_low_power = false,
>> -    .enable_hpo_pg_support = false,
>>       //must match enable_single_display_2to1_odm_policy to support 
>> dynamic ODM transitions
>>       .enable_double_buffered_dsc_pg_support = true,
>>       .enable_dp_dig_pixel_rate_div_policy = 1,
>
>
> just a friendly ping
>
> Thanks,
> Bragathe
>
Could someone help me in reviewing this changes ?

Thanks,
Bragathe

