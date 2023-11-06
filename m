Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB997E2EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjKFVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:20:12 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3EB0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:20:08 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-587af6285c0so259110eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699305607; x=1699910407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fyk105fO9nPx1K8RQh7z3r5ykWh5/CrtqeSXyVa34c=;
        b=JvFrQIucl4wwnjjUBHxPi136YHvcmK1vXo/iEFHP7XkJwvsLxU3O7bHNyxd0/pGMoe
         DTgYlVV30RcrPfxwogT52lgJjYq9L9g0Af/0RqtlflfTlBi4igUd10VwGrC4aJrlw53S
         mAqaDJvGDJ1z3SYthJgBJj6aUxgb+asmR30yHvvGL2nsLcG3d0yUKqp2kqvqYMY54pub
         pvuUv5alO3HcL+4KcgzJVzsUeU1nNq/RCZoFMCP0P0YnQ429T7n3n3b/NC/AVBqCHuP+
         Y1i8daTZshS3O4yppLPPd9rwzFQfVK1lsuoNvLqSuIICCSbm5ObX1EIRmzULpS24TflS
         /HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305607; x=1699910407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fyk105fO9nPx1K8RQh7z3r5ykWh5/CrtqeSXyVa34c=;
        b=s8HPGo+FovdQJ4DgW5NugumK2H2alD7JZFjFvfcpSbMUGMQKCDBQi2mgwrZDlZbSE1
         cv5EOpgNWKu6PTVD9XR2BELwBHIaIwXPg6vsXXgf/eoEgMothqY4uckJ8mo8qMoBpsSt
         UFIeobHjGRoY9kGxdGh9Hl4oV1TxeS0IBd0Zi+SOHKWp7fYx7zp5UZiESXveDPFrgwA2
         7IrHWhScp6MDUsit7gAuUeHf8egrHctIdDjY3GlCgUOPvEQ6N3Mj7742liIYdy9IGprb
         JZLKZHZ9J0dqcUxsrwgHcYmSrVuS8M2h6K0Vl/cF97O/SJ6fYLkBhK9FtCYpvZcLoO9f
         s4FQ==
X-Gm-Message-State: AOJu0Yy3JnnYbpHESyBcAkYB8Gvc3JBwaMr1y7Ho9PQqjXM2v76fUJwS
        8K6wWrla2yhupiYqyfedgSs=
X-Google-Smtp-Source: AGHT+IH4VDf8xNiyaOS4OHF/NY+0agil1P2kuT4qJkDyOIVe9taGaS0U+sjLOgwU7KXVIGo4aSi+fQ==
X-Received: by 2002:a05:6358:f201:b0:169:4a72:2b84 with SMTP id jj1-20020a056358f20100b001694a722b84mr41339730rwb.1.1699305607292;
        Mon, 06 Nov 2023 13:20:07 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b005b92ba3938dsm190941pgb.77.2023.11.06.13.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:20:06 -0800 (PST)
Message-ID: <3b92b89b-ca72-4012-b4f2-0b19e4ba9153@gmail.com>
Date:   Tue, 7 Nov 2023 02:49:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
 <CADnq5_OkWD3YmCKgXbtk=Gnba3AgAiAWp2z_nzHQvRfEOsdXVg@mail.gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <CADnq5_OkWD3YmCKgXbtk=Gnba3AgAiAWp2z_nzHQvRfEOsdXVg@mail.gmail.com>
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

On 11/7/23 00:25, Alex Deucher wrote:
> Applied.  This matches what we already do in the other clear state headers.
> 
> Alex
> 
> On Fri, Nov 3, 2023 at 12:00 PM Abhinav Singh
> <singhabhinav9051571833@gmail.com> wrote:
>>
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
Hi Alex, thanks for looking into this. By applied you mean this patch is 
accepted and it has been merged?
