Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F578879D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbjHYMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbjHYMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:38:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120B1BE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:38:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so109521766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692967094; x=1693571894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5QI1tizVVN+BUXg6KEgJUokRG2kPqFKq1bl2b9gCTE=;
        b=dNa6RoPhCIGeFMBiJPyu8Oq5GKnsaI3vf1pBAa0pSXfL2+BzaxrlFv3Oz9JXx/iCuo
         OJ53LDdNUAEd0v25h51kI+GmNQUz1m7MsuqesSEtI+R0Q8vdLXuvS9OfvOl5hSvOrXyy
         T5+VYsb8pE8kiPQefJUYbgEFwOlgIgL+fBt4ez/7dxvO8778u4G5jHWxH3JF4H3h8DPf
         BxVXwgeK6Q4IlCImmI51wgpyzsnoUHcRM074CnHb2I2sPswVey72wGtJN/cs+NFSLJOD
         jzRXdbUQfCbNYtv10Xmi6ep6AdbVkLJilS82Io/hwRTfQVxUzUGT72j22x7huKcYyfPg
         iOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692967094; x=1693571894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5QI1tizVVN+BUXg6KEgJUokRG2kPqFKq1bl2b9gCTE=;
        b=b5mfxUE8D4Dv6Smb9PC1eD7HbKDUUW+hAYTSgqag7Mp6qMOUUZcmUck1sYkJSB7cHh
         lc48OLXq+FVB4m/IB/IP5dtUVlM0FDuljw206oUsU7oxLY7QpPTa7T0kE63cyf6xvEjj
         YdcNQbOD/Ki5ISCZf2MockQyokWL+AxBQbOXEhjJIuH0dbW0M/3yX3fuYcXfvKCxZGuK
         Fd2i+MkpE9fhAayKeKbKbKBYnOuHuqb25Kajam1Fiqq1K4ULacTkJUi8u3EDz6BOYTZE
         3Q6973yHl6UYkZYIztkK6UDHnWTF9LUC8wD+tV+9xxg0ywpiUhTKItIP/DR1FXmujshc
         ZcBg==
X-Gm-Message-State: AOJu0Yzbs5ao1q2aIabudWAbKQeaFRD4ZIIZS4LVQSGx2fakEi0tVFZt
        iE+bPyB2gqWTzrW6joGeeas=
X-Google-Smtp-Source: AGHT+IGOAHCz2aaKv4lwjObRK5cLCpuWQjbdaXgXjBVz2/OXG4EersCgmzXO7FzBq63U8VI7KjgVEA==
X-Received: by 2002:a17:906:8a44:b0:9a1:e758:fc73 with SMTP id gx4-20020a1709068a4400b009a1e758fc73mr5325325ejc.67.1692967094330;
        Fri, 25 Aug 2023 05:38:14 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.63.103])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906074f00b00993a37aebc5sm915125ejb.50.2023.08.25.05.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 05:38:13 -0700 (PDT)
Message-ID: <bd20b6cd-74bd-674b-e036-82e86f0ca101@gmail.com>
Date:   Fri, 25 Aug 2023 14:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Merge debug module parameters
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com
References: <20230824162505.173399-1-andrealmeid@igalia.com>
 <20230824162505.173399-2-andrealmeid@igalia.com>
 <32549529-6cc8-e187-9436-8b9d28e88b1d@amd.com>
 <5780676f-7f6b-4f82-a729-b011a493a861@igalia.com>
 <3fed67c9-7a4a-a6ae-5d73-5d391da53a57@gmail.com>
 <44ddad4c-6c69-48f4-bf9f-86b4c04dbfbe@igalia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <44ddad4c-6c69-48f4-bf9f-86b4c04dbfbe@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.08.23 um 14:34 schrieb André Almeida:
> Em 25/08/2023 09:29, Christian König escreveu:
>> Am 25.08.23 um 14:24 schrieb André Almeida:
>>> Em 25/08/2023 03:56, Christian König escreveu:
>>> > Am 24.08.23 um 18:25 schrieb André Almeida:
>>> >> Merge all developer debug options available as separated module
>>> >> parameters in one, making it obvious that are for developers.
>>> >>
>>> >> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> >> ---
>>> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 
>>> ++++++++++++++++++++++++
>>> >>   drivers/gpu/drm/amd/include/amd_shared.h |  9 +++++++++
>>> >>   2 files changed, 33 insertions(+)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> >> index f5856b82605e..d53e4097acc0 100644
>>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> >> @@ -194,6 +194,7 @@ int amdgpu_use_xgmi_p2p = 1;
>>> >>   int amdgpu_vcnfw_log;
>>> >>   int amdgpu_sg_display = -1; /* auto */
>>> >>   int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
>>> >> +uint amdgpu_debug_mask;
>>> >>   static void amdgpu_drv_delayed_reset_work_handler(struct 
>>> work_struct
>>> >> *work);
>>> >> @@ -938,6 +939,9 @@ module_param_named(user_partt_mode,
>>> >> amdgpu_user_partt_mode, uint, 0444);
>>> >>   module_param(enforce_isolation, bool, 0444);
>>> >>   MODULE_PARM_DESC(enforce_isolation, "enforce process isolation
>>> >> between graphics and compute . enforce_isolation = on");
>>> >> +MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by
>>> >> default");
>>> >> +module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
>>> >> +
>>> >>   /* These devices are not supported by amdgpu.
>>> >>    * They are supported by the mach64, r128, radeon drivers
>>> >>    */
>>> >> @@ -2871,6 +2875,24 @@ static struct pci_driver 
>>> amdgpu_kms_pci_driver = {
>>> >>       .dev_groups = amdgpu_sysfs_groups,
>>> >>   };
>>> >> +static void amdgpu_init_debug_options(void)
>>> >> +{
>>> >> +    if (amdgpu_debug_mask & DEBUG_VERBOSE_EVICTIONS) {
>>> >> +        pr_info("debug: eviction debug messages enabled\n");
>>> >> +        debug_evictions = true;
>>> >> +    }
>>> >> +
>>> >> +    if (amdgpu_debug_mask & DEBUG_VM) {
>>> >> +        pr_info("debug: VM handling debug enabled\n");
>>> >> +        amdgpu_vm_debug = true;
>>> >> +    }
>>> >> +
>>> >> +    if (amdgpu_debug_mask & DEBUG_LARGEBAR) {
>>> >> +        pr_info("debug: enabled simulating large-bar capability on
>>> >> non-large bar system\n");
>>> >> +        debug_largebar = true;
>>> >
>>> > How should that work???
>>>
>>> Ops, I thought it was a boolean. It should be
>>>
>>> +        debug_largebar = 1;
>>
>>
>> That's not the problem, the question is since when do we have a 
>> debug_largebar option and what should that one do?
>>
>
> It should work exactly like the other one, but instead of using 
> amdgpu.large_bar=1, one would use amdgpu.debug_mask=0x4 to activate 
> it, as the plan is to merge all current debug options in a single one 
> right?

Ah! That's the KFD debug_largebar option! Now I got what this is.

Probably best to move the booleans into amdgpu_device and deprecate the 
old options.

Not really a good approach to overwrite the globals here.

Regards,
Christian.

>
>> Regards,
>> Christian.
>

