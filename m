Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D929C79B328
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355153AbjIKV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjIKIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:38:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E113FB;
        Mon, 11 Sep 2023 01:38:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403012f27e3so20586915e9.3;
        Mon, 11 Sep 2023 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694421512; x=1695026312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzAAzxJ2/qwV8UAbsiMaPaxKMg9rNmfMbdZJFqC9hfc=;
        b=LkGMuu/zSlDBIt+rA29tCfPdQ1nLg+vDlGmJO3APL2Y3WBb3tfuekQvlnw6gNI1zti
         QLQDGg6E7RS30DnB/5Sd9t1vownDvLcvbNThXRZEkH1dmRlPyvoYAXLOxoiqBv24+nAz
         4O1I9mPBfJPr6szYDlGpG134p9AZhuYs6b7PUoJUU9xYyXmnOlYErkBLca27VUo37Ku/
         xd/pa80iS317gFdMy5fFdN66QTKPgTNBnlLq9TmLkjOOCVhviC8g9k8EYnEuQXcUXW0F
         MguOquE+gK78A579ABqH2ZuEbJno5lv1JeS515k2XsnAAa1poN+RQEO+2FwpxdXlN/iP
         nYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421512; x=1695026312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzAAzxJ2/qwV8UAbsiMaPaxKMg9rNmfMbdZJFqC9hfc=;
        b=tpHLS2OAWVCS9AMajMQ2dEtOF8sycrDsq+QTl9E66rvvzde1GpFnA+oVgMCu4hr950
         EeKuYhYN5zmgYsWmTgqP++BTCKt9BEpEQTCrBkBq8UeYRx2ksK6E7nKlC8R6nHiJUCFV
         Uwo9buT+utEkT86TRbCHYIL5ZEPEeXQiR8WGHxccAHwuK0IGrNB3Ko5fpyoHspt7nHu4
         60A4gYtVIViX4n68DjD34Vlbc6TYUo++EcU2pp/TP8Aje6bxuB43BCzMRM1ATbft8B6P
         Qf6fOH4Vooospn8LAPUY4wY45Tsu8++PwoHTnJxj6OmztwuCcTXv6GZt/Pm2C9rC9PVb
         sy8Q==
X-Gm-Message-State: AOJu0YwFqwQ/DA1YU5JzyjYp7AlLKbH0HdF2Mh5z6rvfbjiHz2+Fw6Jc
        e6noQZBOPehYxoSstmz62e4zeL8YDnU=
X-Google-Smtp-Source: AGHT+IHFH7KA+JlC4Lt7zEKfI4KHK/qBztjiFLfdMwJ7X3YiIAf096t+NBCxHj5pLdAgpIpI7wO/gQ==
X-Received: by 2002:a7b:cc95:0:b0:3f8:fc2a:c7eb with SMTP id p21-20020a7bcc95000000b003f8fc2ac7ebmr7501080wma.5.1694421512045;
        Mon, 11 Sep 2023 01:38:32 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id p13-20020adff20d000000b003176eab8868sm9459783wro.82.2023.09.11.01.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:38:31 -0700 (PDT)
Message-ID: <2c097494-0854-3769-fb46-0f3fa59e06cb@gmail.com>
Date:   Mon, 11 Sep 2023 10:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] drm/amd/display: fix the white screen issue when
 >= 64GB DRAM
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Alan Liu <haoping.liu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Le Ma <le.ma@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Candice Li <candice.li@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
References: <20230908145521.39044-1-hamza.mahfooz@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230908145521.39044-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.09.23 um 16:55 schrieb Hamza Mahfooz:
> From: Yifan Zhang <yifan1.zhang@amd.com>
>
> Dropping bit 31:4 of page table base is wrong, it makes page table
> base points to wrong address if phys addr is beyond 64GB; dropping
> page_table_start/end bit 31:4 is unnecessary since dcn20_vmid_setup
> will do that. Also, while we are at it, cleanup the assignments using
> upper_32_bits()/lower_32_bits() and AMDGPU_GPU_PAGE_SHIFT.
>
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series 
as well.

> ---
> v2: use upper_32_bits()/lower_32_bits() and AMDGPU_GPU_PAGE_SHIFT
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1bb1a394f55f..5f14cd9391ca 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1283,11 +1283,15 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   
>   	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>   
> -	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
> -	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
> -	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
> -	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
> -	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
> +	page_table_start.high_part = upper_32_bits(adev->gmc.gart_start >>
> +						   AMDGPU_GPU_PAGE_SHIFT);
> +	page_table_start.low_part = lower_32_bits(adev->gmc.gart_start >>
> +						  AMDGPU_GPU_PAGE_SHIFT);
> +	page_table_end.high_part = upper_32_bits(adev->gmc.gart_end >>
> +						 AMDGPU_GPU_PAGE_SHIFT);
> +	page_table_end.low_part = lower_32_bits(adev->gmc.gart_end >>
> +						AMDGPU_GPU_PAGE_SHIFT);
> +	page_table_base.high_part = upper_32_bits(pt_base);
>   	page_table_base.low_part = lower_32_bits(pt_base);
>   
>   	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;

