Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF667E2BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjKFSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:19:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201C94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:19:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so460046a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294765; x=1699899565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tl8ZlpdAg7GwtfMnMLLp2fEwluCCUsAiPSPuqFG5Xz0=;
        b=lS4qWfYnftIwcCu5okOacHpov3w9lTefN3xMOQI7K5OY63V10dTi70ROA4E/9LEZgr
         Wq44mR1CLWVrnbedpKdxS9LqGciZ0k/c2Nyea8eHspfeU6o9D0gky+A4C4zwEkI/R1hq
         pg7q6P/WOSwd9Gxc/MEkdnvY96wBdy7FAj/0L16lV7KVFl3ULpG2I9BQ+Uy7FldETBLx
         jk6itLDV/buG85NKlFcKwDIPz9yEdn8i1yUQbmSjDvWCWCsJQOjjW5DuzLIt4NeaWdDD
         UyPkzhU6ecv0wYuQ/gALShvgU/WtNBvnYWVufnJzIeaE/+qLIzTzr4BsSfG753BIa3Qg
         NSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294765; x=1699899565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl8ZlpdAg7GwtfMnMLLp2fEwluCCUsAiPSPuqFG5Xz0=;
        b=fBHJG3VxBv6yHq67HUGnLxZXwiEo+U9v0qRVCjSDQkWogRJwSUBP40ufZloUIj/T/D
         6CWIP4N+YuFCXfr5PGvAfvdLxb8vxUP9b8AfMbHz+klRwgtl1s8kPl/uIzT0TGTDjb+S
         URNHJod3PxzdMwA0Ijj4yKzN3duZ4x3uvbaC3RLDPr+QcJnHekgoe3QHJN6zePBtiY1l
         Nj+wvL6j6tUA7FMIS0QX+aqG5k+rbUhmYKZB4uJnTon0BkPDPyPpjR79k3gVfROhuG63
         zYzJ/+HtPMIJU1P0faCSvQ2wBiTCT0OK2pKJCnm8mTwki5vr1bT+8DrBuX04LwRUrRZf
         KTMA==
X-Gm-Message-State: AOJu0YxDKJMasT/Bcnnwh+zFRMah7pX6HABoQfN12+EplclsN+29EmEx
        wZh/ndRQv0OpkO3LJYcojHlCe5nVAVmkYj2m
X-Google-Smtp-Source: AGHT+IGZuMNhI2zZQoFqXXq3E+/brKmtT53P7YA09Nfn+zaDB3yG15dLm3XBrAxgDZ/f+n0Zz0X0rQ==
X-Received: by 2002:a17:902:f213:b0:1c4:1cd3:8062 with SMTP id m19-20020a170902f21300b001c41cd38062mr31371603plc.2.1699294765189;
        Mon, 06 Nov 2023 10:19:25 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001c9b35287aesm6204407plf.88.2023.11.06.10.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:19:24 -0800 (PST)
Message-ID: <ba31f441-80cd-4745-b425-23e5b9e0f9c0@gmail.com>
Date:   Mon, 6 Nov 2023 23:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
 <87sf5jyvkt.fsf@intel.com> <a2310260-ba15-428e-9fd1-08abb9565b18@gmail.com>
 <87h6lyzvg8.fsf@intel.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <87h6lyzvg8.fsf@intel.com>
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

On 11/6/23 22:10, Jani Nikula wrote:
> On Mon, 06 Nov 2023, Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
>> On 11/6/23 16:53, Jani Nikula wrote:
>>> On Fri, 03 Nov 2023, Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
>>>> sparse static analysis tools generate a warning with this message
>>>> "Using plain integer as NULL pointer". In this case this warning is
>>>> being shown because we are trying to intialize a pointer to NULL using
>>>> integer value 0.
>>>>
>>>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>>> index 63a1ffbb3ced..3b645558f133 100644
>>>> --- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>>> +++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>>> @@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_defs[] =
>>>>        {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
>>>>        {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
>>>>        {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
>>>> -    { 0, 0, 0 }
>>>> +    { NULL, 0, 0 }
>>>
>>> Random drive-by comment:
>>>
>>> I'd just use {} as the sentinel.
>>>
>>> BR,
>>> Jani.
>>>
>>>>    };
>>>>    static const u32 SECT_CLEAR_def_1[] =
>>>>    {
>>>> @@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =
>>>>    static const struct cs_extent_def SECT_CLEAR_defs[] =
>>>>    {
>>>>        {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
>>>> -    { 0, 0, 0 }
>>>> +    { NULL, 0, 0 }
>>>>    };
>>>>    static const u32 SECT_CTRLCONST_def_1[] =
>>>>    {
>>>> @@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =
>>>>    static const struct cs_extent_def SECT_CTRLCONST_defs[] =
>>>>    {
>>>>        {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
>>>> -    { 0, 0, 0 }
>>>> +    { NULL, 0, 0 }
>>>>    };
>>>>    static const struct cs_section_def evergreen_cs_data[] = {
>>>>        { SECT_CONTEXT_defs, SECT_CONTEXT },
>>>>        { SECT_CLEAR_defs, SECT_CLEAR },
>>>>        { SECT_CTRLCONST_defs, SECT_CTRLCONST },
>>>> -    { 0, SECT_NONE }
>>>> +    { NULL, SECT_NONE }
>>>>    };
>>>> --
>>>> 2.39.2
>>>>
>>>
>> Hi, Thanks for dropping by and the suggestion. I thought of using NULL
>> instead of {} is because, first the warning itself says that 0 is used
>> to intialize pointers with NULL, and second due this link
>> https://www.spinics.net/lists/linux-sparse/msg10066.html where linus is
>> talking about not using 0 NULL intialization of pointer variable and he
>> thinks this is a legitimate issue and not some false positive
> 
> But... {} is neither of those things. It's empty initialization instead
> of 0. It's valid in GCC and C23, and used all over the place in the
> kernel.
> 
> BR,
> Jani.
> 
> 
> 
If I understand correctly you want to me change from this "{ NULL, 
SECT_NONE }" to "{}" right? If yes, then according to what I read from 
some online, it is better to intialize variables especially pointer 
because in some cases a non initialized pointer doesnt always point to 
NULL. Not sure if this applies in kernel space as well. But yeah my 
knowledge is pretty limited in C in user space and in kernel space it is 
even more limited :)

