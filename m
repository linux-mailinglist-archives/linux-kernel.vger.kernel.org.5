Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141577DBC13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjJ3OsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJ3OsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:48:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05AF3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:48:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso3019834a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698677285; x=1699282085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enkdXsDQsvrVFAm4mm0Ogf+SLJzxgJmU8p9Qwbl4+Wo=;
        b=bqYvnQbzDvdZPndDC2xoEv2vrdrEqHrbajFgI/dwdoZUBSDhv98jFGZghwrsW17Pmr
         1uSAyk/fXqXYZlkWVuO7eiXD4HDOh6anQErmj8UGKBgX4Bt2K683IjZwcckKmQlPxcLM
         ur3dpUvwLAWRqg2hpKWt1cvRLdpTrehsJ5QUVSehU3tYhAdPc/ITEekXpNuQey9GHyca
         gukhhTE8vVs4GCJnVPvQKVj3MWyMoeDfdK744y0VUzRQ3vyQmNdR+XqXfSH+/iwRJNQS
         DOs5h/7o8TQib4NS85iC6kZ/pCJygqS43VD9CWRhh3GYGbTtA6v+GoXhwOA+HZ+z+jqL
         l5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677285; x=1699282085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enkdXsDQsvrVFAm4mm0Ogf+SLJzxgJmU8p9Qwbl4+Wo=;
        b=cS8LbntKiYJzvQ23ztqCZORpcGi2a7XDKotOUun1QvhRIaIjktyaA4Gf3dZztI2zRV
         y0G1yqe/l9k/qmQS1f3eQeB2BHUt53LZbos7Z4aeFaVzljTDDNUXkxpmEViNc/UCwexX
         qsU/v+gfQHYrM4BAnxZVUKsiVcyPlujnCPqVJKeUD7z18PaMXQUOl/wsKdI7pVKtiMF7
         8Yz+yk3GkVLKj1t83KdfFhlv35b/azaxZrolxBDo8RdXkzJSHggPyQg4VECp9Bv9lHH/
         KqLKvxHhFpTdDIN2nlBo0LbEjBLRiA/qqOD+omoejve12QpnlJIzAgcQDi01KgrQj5JJ
         CVQw==
X-Gm-Message-State: AOJu0YzYLkwv6xm6MP+9R5yiC+8qjp0FECx9it7OHz8u4T0FYZzujcRS
        DXyXvTEDsexQe+tgvqWnrcI=
X-Google-Smtp-Source: AGHT+IG/MG/rrpdah/ML1HpJD57fgfKQ2HsIE4+LAp8dqAnywAERkk7eyN6VzRliHe2mFTLEGz7gDw==
X-Received: by 2002:a17:90a:bf07:b0:27d:1df4:26f3 with SMTP id c7-20020a17090abf0700b0027d1df426f3mr6625998pjs.15.1698677284839;
        Mon, 30 Oct 2023 07:48:04 -0700 (PDT)
Received: from [192.168.1.11] ([27.4.124.129])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a035b00b00268b439a0cbsm6065971pjf.23.2023.10.30.07.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:48:04 -0700 (PDT)
Message-ID: <744beb05-1327-401e-a961-edfe63bd8927@gmail.com>
Date:   Mon, 30 Oct 2023 20:17:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: avoid variable reinitialization
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
        airlied@gmail.com, Qingqing.Zhuo@amd.com, alvin.lee2@amd.com,
        wenjing.liu@amd.com, jun.lei@amd.com, Samson.Tam@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231024181134.48066-1-bragathemanick0908@gmail.com>
Content-Language: en-US
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20231024181134.48066-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/23 23:41, Bragatheswaran Manickavel wrote:
> The member variable enable_hpo_pg_support is already initialized
> and hence the reinitialization instruction can be removed. Issue
> identified using the doubleinit.cocci Coccinelle semantic patch script.
>
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> index 99d55b958977..1fd9df8da09c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> @@ -739,7 +739,6 @@ static const struct dc_debug_options debug_defaults_drv = {
>   	.disable_boot_optimizations = false,
>   	.disable_unbounded_requesting = false,
>   	.disable_mem_low_power = false,
> -	.enable_hpo_pg_support = false,
>   	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
>   	.enable_double_buffered_dsc_pg_support = true,
>   	.enable_dp_dig_pixel_rate_div_policy = 1,


just a friendly ping

Thanks,
Bragathe

