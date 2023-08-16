Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7BF77DDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbjHPJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbjHPJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:44:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E780E74
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:44:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so835602266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692179090; x=1692783890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8zand1bf++dDgXm+FjYcnuIBuhLXkX3zFM+5SMeXGc=;
        b=HRYFoxGjBZzXBdTkpHd73l2h3v/JuuD2i1kNBqAwYjOdIpHBBSZoy5H9X8PTFnyZNa
         qBvUGytxHcEACJtKntItMDimW+GC0SsKZvM97Q5F0ucWIMEyKbI4KcI9ctspDyBVDDrY
         RapzgyftLuS63fDgcmoBmvBXAYmliy4rGchDoK15Pluse8JQDskGGz7oWHbu+x5VshoD
         B9wii+pAmee+v+Q0pFAUVCKvhBg6m4AuTzt3nZkbnPMc3zrRFbW4HzvORRg9MQtcFD1/
         CG3oLBDo1J8nwI/0byiDkt7NTABA1yLSDt+AN5+YpPSI5EVr/uJ9uTniZc6PxMLb7VIk
         W23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692179090; x=1692783890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8zand1bf++dDgXm+FjYcnuIBuhLXkX3zFM+5SMeXGc=;
        b=BoaIqGxVGAzhD+vk/VG2llycyv8w926pDbaxeJH/qPTWCGO0UP5EH4qpUG+fMUlBcc
         E6IjOadFMwVNxwM37Gnx0v2Uj+lxXSwGDEwBir1d/64uvkiWXbXS+yy+rmteOSYllbne
         DMQFtZ/gCIx45PzE00agnFkCC7PU4eaSr9C94rTaZbacYjH8JmbFwgCqIPULIyOmtqIj
         cLqeUXJ9Z1lCuAK2mzBwZU1Su634j4ddz6YVyE7rU+HKiA86t4zEucR5a+zcFP0NmFu1
         uc4qEK8sIqjjj+8tERpYvMC+Ww71U1AQbIWcQK9yhcuwIT8pi/TKRZaIHyY7BD54Va3n
         TIoQ==
X-Gm-Message-State: AOJu0YwwJQDvARapqTU8qTTyTUMeVR4xKZegloQvt9VwleWqcVLrRoVA
        9ythvab01E+6OyfXfuflbsY=
X-Google-Smtp-Source: AGHT+IEHjvlHvnzDZrz7U+x+ynkgWAIb4qZcKYYFRjnG3NOZ2EpwdYWyFkZxj65jMbqaDEqTu/83Uw==
X-Received: by 2002:a17:906:4999:b0:999:26d3:b815 with SMTP id p25-20020a170906499900b0099926d3b815mr1234651eju.64.1692179090211;
        Wed, 16 Aug 2023 02:44:50 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15f4:7600:6260:d6f0:1ba4:569e? ([2a00:e180:15f4:7600:6260:d6f0:1ba4:569e])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090668d600b0099bcdfff7cbsm8200410ejr.160.2023.08.16.02.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:44:49 -0700 (PDT)
Message-ID: <fd477ce4-1726-b5a1-1826-8cc5245fcf89@gmail.com>
Date:   Wed, 16 Aug 2023 11:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu/gmc6: fix in case the PCI BAR is larger than
 the actual amount of vram
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>, hongao <hongao@uniontech.com>
Cc:     Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        lijo.lazar@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mario.limonciello@amd.com,
        daniel@ffwll.ch, alexander.deucher@amd.com, airlied@gmail.com
References: <20230815065445.25576-1-hongao@uniontech.com>
 <CADnq5_N8nHV5ub0qf6ihU=+QKXOFfM4AnWbYmWf=EG8SbJXa8A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_N8nHV5ub0qf6ihU=+QKXOFfM4AnWbYmWf=EG8SbJXa8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait a second.

This is unnecessary because we have this check in 
amdgpu_gmc_vram_location():

         if (mc->real_vram_size < mc->visible_vram_size)
                 mc->visible_vram_size = mc->real_vram_size;


Which makes sure that the visible VRAM size is never larger than the 
actual size for all HW generations.

Regards,
Christian.

Am 15.08.23 um 17:50 schrieb Alex Deucher:
> Applied.  Thanks!
>
> On Tue, Aug 15, 2023 at 3:13 AM hongao <hongao@uniontech.com> wrote:
>> [why]
>> limit visible_vram_size to real_vram_size in case
>> the PCI BAR is larger than the actual amount of vram.
>>
>> Signed-off-by: hongao <hongao@uniontech.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index b7dad4e67813..c0de7496bfd1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -320,6 +320,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>>          adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
>>          adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
>>          adev->gmc.visible_vram_size = adev->gmc.aper_size;
>> +       if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>> +               adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>>
>>          /* set the gart size */
>>          if (amdgpu_gart_size == -1) {
>> --
>> 2.20.1
>>

