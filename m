Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B37E2889
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKFPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:21:18 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059EB3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:21:15 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd20c30831so817105b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284075; x=1699888875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P92lxDHD1C4zCfjkheHzuT5lqonsPzQbwvZLdTTLERo=;
        b=lC8n6Gk/9IK2XkD5aQvP3ZAZsMZsX+9tHQ/AgGyiOSR9mv/RsyHL0cLdP7i7m4yKzt
         4pNqJdq296OO+fl/IIo8xv1qYoGa8x25CF84AdTsSjrx6/XbB8gu4qilzkIa6IlYSEVK
         kHy45kJRnYIymVpHTuUOvkJDEAZ/w3DiuuvYVmYxmzZZ7RrIIG97rCHhGjOmGq6fhtWj
         huH9W2duRgpLM0arH0SSGpr/zCEEuVC1P+/CgbJ93lDriHb6tGJUJTBOkGZd0EpNqypD
         KEf5NFU7PL51peZtyQwR5qFKmsTapXHVeso8K3a4ZtVc/zHsu7Fjp/V5qYsTmrjhFvhc
         49Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284075; x=1699888875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P92lxDHD1C4zCfjkheHzuT5lqonsPzQbwvZLdTTLERo=;
        b=B8HbZDTZ6qjd1jDfUZbGVlKY60KlHU9JIXzL2yyAFCuaLWU/rCPZR/HkjPAOfcGMMX
         /1ZzY/1SfLl6X4Pjb6hkLGrTeUCS2n6+GjLMgissWfzVAvnhWT9j2zkvSlJ7e0XO8OfG
         5JNuNon98+Glgu5+hLgQp6qxMm86RxKW/ksM4qVcAhpxyTfUPo1PNuq6Pmk6IBz7CgOk
         Mtu4N6WNJA90qXy0Qcj6iQJYRfEvIirZJnsPnHBAtvKotmgyhhDC05FcJvQFCt6OSX7T
         i/3GGg74Rif6BjalbzH3cc3fPAX5C9xRVlUQnGjqCRMzw+YAhjm+NUqhVfkImfoYJOlY
         j83g==
X-Gm-Message-State: AOJu0YxqwBgAC0TYSBRWMvOLoayTbcoOd4urBKCXFXIkTPYkR73AQeH/
        V86u1xyKTRS3qC1yhCtK+3/BgCz9Vx1J+cVO
X-Google-Smtp-Source: AGHT+IE24GvzdFIzXU6AfcREyApaAuOpmL/V9kBcAm3FDckkeCxrMFOO4qFiX+Sawmz7v5gl44NziA==
X-Received: by 2002:a05:6a00:470a:b0:68f:c8b3:3077 with SMTP id df10-20020a056a00470a00b0068fc8b33077mr28116172pfb.1.1699284074970;
        Mon, 06 Nov 2023 07:21:14 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id n35-20020a056a000d6300b006b90f1706f1sm5777285pfv.134.2023.11.06.07.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 07:21:14 -0800 (PST)
Message-ID: <a2310260-ba15-428e-9fd1-08abb9565b18@gmail.com>
Date:   Mon, 6 Nov 2023 20:51:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
 <87sf5jyvkt.fsf@intel.com>
Content-Language: en-US
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <87sf5jyvkt.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 16:53, Jani Nikula wrote:
> On Fri, 03 Nov 2023, Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
>> sparse static analysis tools generate a warning with this message
>> "Using plain integer as NULL pointer". In this case this warning is
>> being shown because we are trying to intialize a pointer to NULL using
>> integer value 0.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>>   drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>> index 63a1ffbb3ced..3b645558f133 100644
>> --- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
>> +++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>> @@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_defs[] =
>>       {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
>>       {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
>>       {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
>> -    { 0, 0, 0 }
>> +    { NULL, 0, 0 }
> 
> Random drive-by comment:
> 
> I'd just use {} as the sentinel.
> 
> BR,
> Jani.
> 
>>   };
>>   static const u32 SECT_CLEAR_def_1[] =
>>   {
>> @@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =
>>   static const struct cs_extent_def SECT_CLEAR_defs[] =
>>   {
>>       {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
>> -    { 0, 0, 0 }
>> +    { NULL, 0, 0 }
>>   };
>>   static const u32 SECT_CTRLCONST_def_1[] =
>>   {
>> @@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =
>>   static const struct cs_extent_def SECT_CTRLCONST_defs[] =
>>   {
>>       {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
>> -    { 0, 0, 0 }
>> +    { NULL, 0, 0 }
>>   };
>>   static const struct cs_section_def evergreen_cs_data[] = {
>>       { SECT_CONTEXT_defs, SECT_CONTEXT },
>>       { SECT_CLEAR_defs, SECT_CLEAR },
>>       { SECT_CTRLCONST_defs, SECT_CTRLCONST },
>> -    { 0, SECT_NONE }
>> +    { NULL, SECT_NONE }
>>   };
>> --
>> 2.39.2
>>
> 
Hi, Thanks for dropping by and the suggestion. I thought of using NULL 
instead of {} is because, first the warning itself says that 0 is used 
to intialize pointers with NULL, and second due this link 
https://www.spinics.net/lists/linux-sparse/msg10066.html where linus is 
talking about not using 0 NULL intialization of pointer variable and he 
thinks this is a legitimate issue and not some false positive

