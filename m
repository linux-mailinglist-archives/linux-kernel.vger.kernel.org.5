Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8517E3504
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKGGD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:03:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43520DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:03:53 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so497040a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 22:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699337033; x=1699941833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKFEEOwu+JwvBa63rAI+zxMPRAeyFot/drhB3OU5pF8=;
        b=OA04UC1/OCaLprOgNkJHfIlJg4/bjHSANxwX0HprwWoo6c97yupaUsqBXR/m2nEAVP
         Lkg0j09GdiiuH6YAHTyeZPOjUGHEcRPuJUHEVd2ok+BnxFoCUJPz9sglBwllUkSyHQ0U
         ksDjCiIYLb2jeDoEL2VUbHRjHgZOxuw6lpssSxuGM6ZsyOyPwWlRgSjBK2KPSODhxOhU
         talR1V+XLxUeCH8zz9EftYG6FPq8hwzR0pgp+osPTxRsN2Cw8BXVYctBAZjBSionOmBq
         6hydVlAYah5wwCvAeAfVhk+vMG9D4fpFNDWKe9IxNdFDLYn9IxBorTJM60lL77nRmIBh
         9f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337033; x=1699941833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKFEEOwu+JwvBa63rAI+zxMPRAeyFot/drhB3OU5pF8=;
        b=Ned12QwGkz9CwUztvPKULkgqIIRsvalgFunD3ycxHTEELw1O8b4rSMu2njbIA5isD+
         sERdAY+3pdmhYJofO/0eOQcbsS/xvx0WXRvp39vzRZMAcoAOC7cQwmL8iICu6IbpGZ+i
         N/MNq3JT3dHdHpy0tbVKaKXd+JLv2ajjR03f7nS0nYMkoi7lp6i8YNeVV1AV4SJdeGmx
         nIq3Fpzokfjmw3uLEgmSjLdn6n54nikCUDTqJbz2j8bfvRDk+RADDVIPfiWBvZazPq/4
         XbwJLuhj5EytaTVRWa2ZfQGef5fWMc+yigCH82xTY+2A+4sWL570co2xnECuCsWJqsYh
         lfpA==
X-Gm-Message-State: AOJu0YxagL7XABvaYx6/sXfSyFZdor2m9twZ+xCumzMSZmm77cZMsieH
        Rk8QESj844akK170NJ7W0ks=
X-Google-Smtp-Source: AGHT+IEYjDnHlZaeLjHfEXLGnwRtpD+SbIvNxQUtdUAz9T0ERhq0lqVvZiRjtyeTQBeHaCk0XeNZnw==
X-Received: by 2002:a17:903:32d2:b0:1cc:32c6:e5fa with SMTP id i18-20020a17090332d200b001cc32c6e5famr28596508plr.6.1699337032527;
        Mon, 06 Nov 2023 22:03:52 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.209])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001c726147a45sm6840474plg.190.2023.11.06.22.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 22:03:52 -0800 (PST)
Message-ID: <d252d281-96a5-404c-a6a2-fbaa65bea28a@gmail.com>
Date:   Tue, 7 Nov 2023 11:33:41 +0530
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
 <3b92b89b-ca72-4012-b4f2-0b19e4ba9153@gmail.com>
 <CADnq5_PXRN+PL4wp+sWOXs2L5nQiRmfrw4065R1TE4YKw-ZeUA@mail.gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <CADnq5_PXRN+PL4wp+sWOXs2L5nQiRmfrw4065R1TE4YKw-ZeUA@mail.gmail.com>
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

On 11/7/23 03:07, Alex Deucher wrote:
> On Mon, Nov 6, 2023 at 4:20 PM Abhinav Singh
> <singhabhinav9051571833@gmail.com> wrote:
>>
>> On 11/7/23 00:25, Alex Deucher wrote:
>>> Applied.  This matches what we already do in the other clear state headers.
>>>
>>> Alex
>>>
>>> On Fri, Nov 3, 2023 at 12:00 PM Abhinav Singh
>>> <singhabhinav9051571833@gmail.com> wrote:
>>>>
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
>> Hi Alex, thanks for looking into this. By applied you mean this patch is
>> accepted and it has been merged?
> 
> Yes.  Once it makes it through our CI system, it will show up in my
> drm-next tree.
> 
> Alex
Okay, this is my first patch to get into kernel :)
Thank you once again for your time with this patch and accepting it.
