Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD161788769
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbjHYMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbjHYM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:29:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A52686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:29:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso12924551fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966550; x=1693571350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uy781ba5WUdHcJRv6Ly7gsaEnTcJ4eIu5zU8uCwMuBs=;
        b=h0/zqyB1eSAOfmCTlwBcxXF+l3e2vvACaMzCjecWVq+A/DcL9JHEHJpSleZiO5vlaP
         l79TmVcyDoH14tt4Av0D/EB4yA59TS0CAmaQVlG9rhZ1F8AQiXXPd7DTo6yFN8hHFjOZ
         wPta3FNEg2/KbSjXp8aFwIYPNrXX3cO7eQoesITZxIvF9GhKK821g7vymVKiR3niWykN
         6gFrE9WLT9akKWwAdkn1wJomxxFzhucXcE6BpD0AsvX+Ti5Bfmu4u3dBm6FJjkqb+qA9
         +NsyK1X0Oeu8mgrj5PW0nfSpzYl73CrOvXudBLqip9vVRbw7vB3u0DdTHzxEG2PP8qQm
         ePHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966550; x=1693571350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uy781ba5WUdHcJRv6Ly7gsaEnTcJ4eIu5zU8uCwMuBs=;
        b=b0yhBIH/YO0+mnZPa2CEvecIxM8cGtMrzqNN1bxsbHPdOvUpIJklZeTGRd7NznY0rs
         L99JmojLpJiUTE79nbhfVbd2qSB+B9RpFPxp6amHo8fb9POZmdjLIh/DS+rdegMHEtsJ
         Nt5EFizPeNdhu4pZUOGjLszzFrKAXnos0WQ3N4hnDPbIqCbkV3qNg0BVDu7qnCC5udEM
         g1i8jMWJtCXhElEEzb7onm/MRe+SR21ENYWkRuUxmZd53R1DfODr1zXzNo0HNkU7H6Tj
         vQBdMhjCJkx0C3VvwThPO5YBCyJ1qoUEG/94F1yplkCi6b/aD0ud9mmNdyP/ekLpLNxE
         xThw==
X-Gm-Message-State: AOJu0YyiZd4fGhqXDaDqozAFYQD5mGdBV64T0jIymucPz9LBFco7wxJ2
        DZfxVE3BrdNXUIV7KQlNs+k=
X-Google-Smtp-Source: AGHT+IHkLutWOKxIsArHPT5LyxQb6VcXp4ralJ6DzPBELP3QiU66+j7wyL74JNrF5W9rtn5v10Z5CA==
X-Received: by 2002:a2e:81ca:0:b0:2bb:a28b:58e1 with SMTP id s10-20020a2e81ca000000b002bba28b58e1mr15396737ljg.41.1692966549636;
        Fri, 25 Aug 2023 05:29:09 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.63.103])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0099b5a71b0bfsm912941ejb.94.2023.08.25.05.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 05:29:09 -0700 (PDT)
Message-ID: <3fed67c9-7a4a-a6ae-5d73-5d391da53a57@gmail.com>
Date:   Fri, 25 Aug 2023 14:29:08 +0200
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5780676f-7f6b-4f82-a729-b011a493a861@igalia.com>
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

Am 25.08.23 um 14:24 schrieb André Almeida:
> Em 25/08/2023 03:56, Christian König escreveu:
> > Am 24.08.23 um 18:25 schrieb André Almeida:
> >> Merge all developer debug options available as separated module
> >> parameters in one, making it obvious that are for developers.
> >>
> >> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 
> ++++++++++++++++++++++++
> >>   drivers/gpu/drm/amd/include/amd_shared.h |  9 +++++++++
> >>   2 files changed, 33 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index f5856b82605e..d53e4097acc0 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -194,6 +194,7 @@ int amdgpu_use_xgmi_p2p = 1;
> >>   int amdgpu_vcnfw_log;
> >>   int amdgpu_sg_display = -1; /* auto */
> >>   int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
> >> +uint amdgpu_debug_mask;
> >>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
> >> *work);
> >> @@ -938,6 +939,9 @@ module_param_named(user_partt_mode,
> >> amdgpu_user_partt_mode, uint, 0444);
> >>   module_param(enforce_isolation, bool, 0444);
> >>   MODULE_PARM_DESC(enforce_isolation, "enforce process isolation
> >> between graphics and compute . enforce_isolation = on");
> >> +MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by
> >> default");
> >> +module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
> >> +
> >>   /* These devices are not supported by amdgpu.
> >>    * They are supported by the mach64, r128, radeon drivers
> >>    */
> >> @@ -2871,6 +2875,24 @@ static struct pci_driver 
> amdgpu_kms_pci_driver = {
> >>       .dev_groups = amdgpu_sysfs_groups,
> >>   };
> >> +static void amdgpu_init_debug_options(void)
> >> +{
> >> +    if (amdgpu_debug_mask & DEBUG_VERBOSE_EVICTIONS) {
> >> +        pr_info("debug: eviction debug messages enabled\n");
> >> +        debug_evictions = true;
> >> +    }
> >> +
> >> +    if (amdgpu_debug_mask & DEBUG_VM) {
> >> +        pr_info("debug: VM handling debug enabled\n");
> >> +        amdgpu_vm_debug = true;
> >> +    }
> >> +
> >> +    if (amdgpu_debug_mask & DEBUG_LARGEBAR) {
> >> +        pr_info("debug: enabled simulating large-bar capability on
> >> non-large bar system\n");
> >> +        debug_largebar = true;
> >
> > How should that work???
>
> Ops, I thought it was a boolean. It should be
>
> +        debug_largebar = 1;


That's not the problem, the question is since when do we have a 
debug_largebar option and what should that one do?

Regards,
Christian.

>
> >
> >> +    }
> >> +}
> >> +
> >>   static int __init amdgpu_init(void)
> >>   {
> >>       int r;
> >> @@ -2893,6 +2915,8 @@ static int __init amdgpu_init(void)
> >>       /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not
> >> set. */
> >>       amdgpu_amdkfd_init();
> >> +    amdgpu_init_debug_options();
> >> +
> >>       /* let modprobe override vga console setting */
> >>       return pci_register_driver(&amdgpu_kms_pci_driver);
> >> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> >> b/drivers/gpu/drm/amd/include/amd_shared.h
> >> index 67d7b7ee8a2a..6fa644c249a5 100644
> >> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> >> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> >> @@ -257,6 +257,15 @@ enum DC_DEBUG_MASK {
> >>   enum amd_dpm_forced_level;
> >> +/*
> >> + * amdgpu.debug module options. Are all disabled by default
> >> + */
> >> +enum AMDGPU_DEBUG_MASK {
> >> +    DEBUG_VERBOSE_EVICTIONS = (1 << 0),        // 0x1
> >> +    DEBUG_VM = (1 << 1),                // 0x2
> >> +    DEBUG_LARGEBAR = (1 << 2),            // 0x4
> >
> > Good start, but please give the symbol names an AMDGPU_ prefix. Stuff
> > like DEBUG_VM is just way to general and could clash.
> >
> > Apart from that comments on the same line and using // style comments
> > are frowned upon. You should probably rather use the BIT() macro here.
> >
>
> Ack, I'll change that for next version
>
> > Regards,
> > Christian.
> >
> >> +
> >>   /**
> >>    * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
> >>    * @name: Name of IP block
> >
> >

