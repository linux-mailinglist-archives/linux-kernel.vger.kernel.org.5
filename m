Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F887EA06F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKMPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:46:37 -0500
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 07:46:33 PST
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232B4D5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:46:33 -0800 (PST)
Message-ID: <0d13ccb6-ca5e-4bfd-bfd8-60afcf10be16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699889961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YclMo1QyIhuAO5K4+R6Re4o3SZn8+z6+mcibJmkzoqc=;
        b=NLz4uHR7nkTYAI3tD146i6IteaPZ1lk5AmdikA5ZGtoru4Qx5om61q4qT8ZiKcwtyzdxzM
        pyCZyQUft+yRIsakYZwfRjAHw8bxI9Eo8DIy9ZE6Tvx+hMRDJwiu69r9ongRXjurV71rqM
        14luW5Y7FZ3ZCwAcgilEL5ZLD2s0kso=
Date:   Mon, 13 Nov 2023 23:39:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/loongson: Add platform dependency
To:     Jean Delvare <jdelvare@suse.de>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231113125508.4dc755e8@endymion.delvare>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20231113125508.4dc755e8@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for the patch.


On 2023/11/13 19:55, Jean Delvare wrote:
> Only offer the Loongson DRM driver as an option on platforms where
> it makes sense.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>


> Cc: Sui Jingfeng <sui.jingfeng@linux.dev>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
> Changes since v1:
> * Use the architecture dependencies suggested by Sui Jingfeng.
>
>   drivers/gpu/drm/loongson/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> --- linux-6.6.orig/drivers/gpu/drm/loongson/Kconfig
> +++ linux-6.6/drivers/gpu/drm/loongson/Kconfig
> @@ -3,6 +3,7 @@
>   config DRM_LOONGSON
>   	tristate "DRM support for Loongson Graphics"
>   	depends on DRM && PCI && MMU
> +	depends on LOONGARCH || MIPS || COMPILE_TEST
>   	select DRM_KMS_HELPER
>   	select DRM_TTM
>   	select I2C
>
>
