Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF777CA11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjHOJKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjHOJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:10:15 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B075E61;
        Tue, 15 Aug 2023 02:10:01 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qVq3p-0002fe-00; Tue, 15 Aug 2023 11:09:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A0B4AC0276; Tue, 15 Aug 2023 10:29:27 +0200 (CEST)
Date:   Tue, 15 Aug 2023 10:29:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mips: loongson3_defconfig: Enable ast drm driver by
 default
Message-ID: <ZNs3ZwYH5N/uumJP@alpha.franken.de>
References: <20230803091637.971924-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803091637.971924-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 05:16:37PM +0800, Sui Jingfeng wrote:
> ASpeed GPU is typically found on the Loongson server platform, as a
> peripheral device driver, it generally should be compiled as a module.
> 
> Tested on loongson 3B4000 server[1].
> 
> [1] https://github.com/loongson-gfx/loongson_boards/tree/main/ls3b4000x2_server
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  arch/mips/configs/loongson3_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
> index 3087e64e6ebe..a9fadea72da5 100644
> --- a/arch/mips/configs/loongson3_defconfig
> +++ b/arch/mips/configs/loongson3_defconfig
> @@ -283,6 +283,7 @@ CONFIG_DRM_AMDGPU_USERPTR=y
>  CONFIG_DRM_AMD_ACP=y
>  CONFIG_DRM_AMD_DC=y
>  CONFIG_DRM_AMD_DC_SI=y
> +CONFIG_DRM_AST=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_QXL=y
>  CONFIG_DRM_VIRTIO_GPU=y
> -- 
> 2.34.1
> 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
