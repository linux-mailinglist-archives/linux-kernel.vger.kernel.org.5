Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D875A3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGTB07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTB06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:26:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E792102
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jQLdsxFbnAMC4nR/W72mTiYv9HLed0M1Guz4BtHqyEM=; b=SLI38fmp1U2UeQ3ks37hefukSB
        gg7QHAbenf8pqm3Pq2w3zIFRYAlu9DtkcGr9HKuex2rnRwX7Wj2Eettz0nm2rOBfJpVJn/Bm4Q+X1
        znLnBEck3msM/4PTxXGUHD5K7yMSzeLgM3vlFiR3x5xCjPBhUPzX0c/5PGPLBOClUk6nKdZ9+nQz8
        tGtFW85TVvsR70mQR0jvLlYJ5jUX6zVUrvmUQzeKKZTM7k2mKPMCGYoDyPLxaKx8Z2NthqN7+pMWx
        hwxlYczEpmveEE0eBub+er7N71Yac7R5UizmXtIJyeQN3kkJCt8UDh9tC8vvuqZ7c7S4KneGao7m1
        woukI0Mg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMIRP-009S7c-2b;
        Thu, 20 Jul 2023 01:26:51 +0000
Message-ID: <9d8254b2-2e68-2e4a-055a-5afdb04bd115@infradead.org>
Date:   Wed, 19 Jul 2023 18:26:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] drm/amdgpu: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, alexander.deucher@amd.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230720010514.54342-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230720010514.54342-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 18:05, Yang Li wrote:
> Use colon to separate parameter name from their specific meaning.
> silence the warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:793: warning: Function parameter or member 'adev' not described in 'amdgpu_vm_pte_update_noretry_flags'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 83e1923f6775..96d601e209b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -783,7 +783,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>  /**
>   * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
>   *
> - * @adev - amdgpu_device pointer
> + * @adev: amdgpu_device pointer
>   * @flags: pointer to PTE flags
>   *
>   * Update PTE no-retry flags when TF is enabled.

-- 
~Randy
