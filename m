Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5157B5059
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjJBKcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjJBKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:32:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C289190
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:32:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4066692ad35so16652025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696242758; x=1696847558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQIRgkgfRHRtGmLCdkMMekjRicrmnPMi/Ke3bZ9XeOU=;
        b=PJM3shdAQmjXcD0ktBV2lQc1W3Y6/efC2c24sTrXlAo4aomLUEFj9KgPpFUXkFYWHA
         4OUDd63sUHcdolYk4kaTIooyX8Mp+qyPMpBqymxDlxYMULQZYpyD501/BYF01PCfh0Vw
         ZF7r/rPcGoKLlLoeojj4YanLYhe6a1/Ft/W5SgwHxw3NwgcYmRfcwyM++c79234YdkuQ
         o6PB+opIrej69ehILvBoTe83DrnSM217TeaT7ukJf53dg+R3sAqmJGp59PHcGAOE5uf7
         WRQjZTQxAs60evnHEwPNztrf1RSdfd/NDF8Vq/N75alm2LS8hgj5O4g/lgdguALwI8Rf
         NGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242758; x=1696847558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQIRgkgfRHRtGmLCdkMMekjRicrmnPMi/Ke3bZ9XeOU=;
        b=sURpHZ242/iKmkJZs1RjmxI/vKCsW2x0uJUc4JaOFZEdlpqRk4DZcegLG5yOJWjLEx
         xvbA090OuEM/g+A0CILVs80YpNvXYUXw1IWIfsZseu7dlQ25VEiSQ0O7AScArKJNbrQi
         D1XWT4QahNwfpSQYUXE2cNkkoz/wnUSAWZ110VI7URwStmCWfoIRYTUk/ZeGfmOCx0K7
         Z4+u1S2GD8+y9/vKGtlfes6Tv6hZV5jFisVpEB/nOb2S95G1yAqeNG1ohpCX5MaoGZ3U
         nWbhxo+dr8jygldjCroDFv1KX+OD3ywYbxKYEbw10iPxHiF+Gg2VYB58vFoupDqIUOH/
         PaHQ==
X-Gm-Message-State: AOJu0Yx0YDtprFzGU7lRlNyDrvBp11wCjlEKIvSoBJby2f0tWpZARhdI
        PuvI830944xKqVbB7hiAmVc=
X-Google-Smtp-Source: AGHT+IE4EP/SgYbssQOp04XB9MWphdpn0RKcXVJDxVfxVQr0FgtLJRsNf0HeYNSjhKEy7QPkP0YYsg==
X-Received: by 2002:a1c:720c:0:b0:3fe:5501:d293 with SMTP id n12-20020a1c720c000000b003fe5501d293mr9136918wmc.30.1696242758164;
        Mon, 02 Oct 2023 03:32:38 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm6921759wma.16.2023.10.02.03.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:32:37 -0700 (PDT)
Message-ID: <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
Date:   Mon, 2 Oct 2023 12:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20231002010835.14798-1-rdunlap@infradead.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231002010835.14798-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.10.23 um 03:08 schrieb Randy Dunlap:
> Correct typos of "occurred".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
>   /* unknown cause */
>   #define AMDGPU_CTX_UNKNOWN_RESET	3
>   
> -/* indicate gpu reset occured after ctx created */
> +/* indicate gpu reset occurred after ctx created */
>   #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
> -/* indicate vram lost occured after ctx created */
> +/* indicate vram lost occurred after ctx created */
>   #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
>   /* indicate some job from this context once cause gpu hang */
>   #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)

