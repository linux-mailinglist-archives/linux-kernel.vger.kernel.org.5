Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E5788734
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbjHYM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbjHYM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:26:42 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E2270E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/lm1tULVHN+KA1gK8nSeCz+lmzIkqDtLUYBqc3+NChE=; b=LswGg3AMrJ5QSF1067I3wuOZq1
        lK8+4nmkovh/3UDgkSOmg79X12fXGuydQreMKew5A2NoEi/aQNnCjtPfjLIBVd0qKFSSOXihrXkCo
        sbVAi0bzJVSE6fPQHAs49vMCY4FqfhyVMOE49iXcgNqBoC2NSdw0ZuuV20Gcrww+D6gOLgsoEq+cW
        AcRV5XRTM/vyI9NmMbNEvlbxgpI1A7rsFozuc80WxokgGMaMyYj4L+umxHa8WQufAOLsLZFv1ksRm
        OP2qQjTVX6DVJmTcYcOuHMBhfKLxVZsvzKyGNm+LV22ebMLb/hevlvzM52o/o8nzqgBHXUdfXjEZE
        LYztVoWA==;
Received: from [187.35.42.59] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qZVri-00FHKq-KV; Fri, 25 Aug 2023 14:24:38 +0200
Message-ID: <5780676f-7f6b-4f82-a729-b011a493a861@igalia.com>
Date:   Fri, 25 Aug 2023 09:24:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Merge debug module parameters
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        pierre-eric.pelloux-prayer@amd.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>
References: <20230824162505.173399-1-andrealmeid@igalia.com>
 <20230824162505.173399-2-andrealmeid@igalia.com>
 <32549529-6cc8-e187-9436-8b9d28e88b1d@amd.com>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <32549529-6cc8-e187-9436-8b9d28e88b1d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em 25/08/2023 03:56, Christian König escreveu:
 > Am 24.08.23 um 18:25 schrieb André Almeida:
 >> Merge all developer debug options available as separated module
 >> parameters in one, making it obvious that are for developers.
 >>
 >> Signed-off-by: André Almeida <andrealmeid@igalia.com>
 >> ---
 >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 ++++++++++++++++++++++++
 >>   drivers/gpu/drm/amd/include/amd_shared.h |  9 +++++++++
 >>   2 files changed, 33 insertions(+)
 >>
 >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
 >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
 >> index f5856b82605e..d53e4097acc0 100644
 >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
 >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
 >> @@ -194,6 +194,7 @@ int amdgpu_use_xgmi_p2p = 1;
 >>   int amdgpu_vcnfw_log;
 >>   int amdgpu_sg_display = -1; /* auto */
 >>   int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
 >> +uint amdgpu_debug_mask;
 >>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
 >> *work);
 >> @@ -938,6 +939,9 @@ module_param_named(user_partt_mode,
 >> amdgpu_user_partt_mode, uint, 0444);
 >>   module_param(enforce_isolation, bool, 0444);
 >>   MODULE_PARM_DESC(enforce_isolation, "enforce process isolation
 >> between graphics and compute . enforce_isolation = on");
 >> +MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by
 >> default");
 >> +module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
 >> +
 >>   /* These devices are not supported by amdgpu.
 >>    * They are supported by the mach64, r128, radeon drivers
 >>    */
 >> @@ -2871,6 +2875,24 @@ static struct pci_driver 
amdgpu_kms_pci_driver = {
 >>       .dev_groups = amdgpu_sysfs_groups,
 >>   };
 >> +static void amdgpu_init_debug_options(void)
 >> +{
 >> +    if (amdgpu_debug_mask & DEBUG_VERBOSE_EVICTIONS) {
 >> +        pr_info("debug: eviction debug messages enabled\n");
 >> +        debug_evictions = true;
 >> +    }
 >> +
 >> +    if (amdgpu_debug_mask & DEBUG_VM) {
 >> +        pr_info("debug: VM handling debug enabled\n");
 >> +        amdgpu_vm_debug = true;
 >> +    }
 >> +
 >> +    if (amdgpu_debug_mask & DEBUG_LARGEBAR) {
 >> +        pr_info("debug: enabled simulating large-bar capability on
 >> non-large bar system\n");
 >> +        debug_largebar = true;
 >
 > How should that work???

Ops, I thought it was a boolean. It should be

+        debug_largebar = 1;

 >
 >> +    }
 >> +}
 >> +
 >>   static int __init amdgpu_init(void)
 >>   {
 >>       int r;
 >> @@ -2893,6 +2915,8 @@ static int __init amdgpu_init(void)
 >>       /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not
 >> set. */
 >>       amdgpu_amdkfd_init();
 >> +    amdgpu_init_debug_options();
 >> +
 >>       /* let modprobe override vga console setting */
 >>       return pci_register_driver(&amdgpu_kms_pci_driver);
 >> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
 >> b/drivers/gpu/drm/amd/include/amd_shared.h
 >> index 67d7b7ee8a2a..6fa644c249a5 100644
 >> --- a/drivers/gpu/drm/amd/include/amd_shared.h
 >> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
 >> @@ -257,6 +257,15 @@ enum DC_DEBUG_MASK {
 >>   enum amd_dpm_forced_level;
 >> +/*
 >> + * amdgpu.debug module options. Are all disabled by default
 >> + */
 >> +enum AMDGPU_DEBUG_MASK {
 >> +    DEBUG_VERBOSE_EVICTIONS = (1 << 0),        // 0x1
 >> +    DEBUG_VM = (1 << 1),                // 0x2
 >> +    DEBUG_LARGEBAR = (1 << 2),            // 0x4
 >
 > Good start, but please give the symbol names an AMDGPU_ prefix. Stuff
 > like DEBUG_VM is just way to general and could clash.
 >
 > Apart from that comments on the same line and using // style comments
 > are frowned upon. You should probably rather use the BIT() macro here.
 >

Ack, I'll change that for next version

 > Regards,
 > Christian.
 >
 >> +
 >>   /**
 >>    * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
 >>    * @name: Name of IP block
 >
 >
