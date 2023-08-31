Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF178F0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjHaPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjHaPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:54:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCFC6E4C;
        Thu, 31 Aug 2023 08:54:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD42C15;
        Thu, 31 Aug 2023 08:54:47 -0700 (PDT)
Received: from [10.1.26.48] (e122027.cambridge.arm.com [10.1.26.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A14353F64C;
        Thu, 31 Aug 2023 08:54:04 -0700 (PDT)
Message-ID: <1588defa-d196-5c3e-5d5b-4d6aaa0a60d5@arm.com>
Date:   Thu, 31 Aug 2023 16:54:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] drm/panfrost: Add cycle count GPU register
 definitions
Content-Language: en-GB
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
 <20230824013604.466224-2-adrian.larumbe@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230824013604.466224-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 02:34, Adrián Larumbe wrote:
> These GPU registers will be used when programming the cycle counter, which
> we need for providing accurate fdinfo drm-cycles values to user space.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index 919f44ac853d..55ec807550b3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -46,6 +46,8 @@
>  #define   GPU_CMD_SOFT_RESET		0x01
>  #define   GPU_CMD_PERFCNT_CLEAR		0x03
>  #define   GPU_CMD_PERFCNT_SAMPLE	0x04
> +#define   GPU_CMD_CYCLE_COUNT_START	0x05
> +#define   GPU_CMD_CYCLE_COUNT_STOP	0x06
>  #define   GPU_CMD_CLEAN_CACHES		0x07
>  #define   GPU_CMD_CLEAN_INV_CACHES	0x08
>  #define GPU_STATUS			0x34
> @@ -73,6 +75,9 @@
>  #define GPU_PRFCNT_TILER_EN		0x74
>  #define GPU_PRFCNT_MMU_L2_EN		0x7c
>  
> +#define GPU_CYCLE_COUNT_LO		0x90
> +#define GPU_CYCLE_COUNT_HI		0x94
> +
>  #define GPU_THREAD_MAX_THREADS		0x0A0	/* (RO) Maximum number of threads per core */
>  #define GPU_THREAD_MAX_WORKGROUP_SIZE	0x0A4	/* (RO) Maximum workgroup size */
>  #define GPU_THREAD_MAX_BARRIER_SIZE	0x0A8	/* (RO) Maximum threads waiting at a barrier */

