Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331667A6D75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjISVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjISVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:54:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FBC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f5/fMBSIznIr+vGvXU4rmAhmq+8j0wlA0K01HLKQFAk=; b=vLQ7y4GRj4HN8CPHKXs7DDUYk7
        Sd7EIIkAz3j/advHMGwNIZ/P8P5y7lt/s7IAHQK5W9SLtqj984StvmdcIoAqi+S1k/8Lnr6kpcyXo
        Y00GBqfbkvVQ/aBLQx1y1/dKzBrjU1A60/TSsH2cDIw6V2VVliTksjLwM2lSEGpnDZEhko9SjUn/T
        ggKhpRhTEzyLWqK8RagH9DQ8589VzHUXlc7+2IEFvmXrU3FG3bhJu/J3yxnWQe1A3AuVgWhyF7giM
        Ep28IzN6HTN6pnmLwRgkzTi4pSTuiI9XyW8VUQEnFUMSdfub5Yg5ceWb9kdFTXD5cDPZdk5zSlmsN
        mDjYu8cg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiifx-001K5G-10;
        Tue, 19 Sep 2023 21:54:33 +0000
Message-ID: <e1294905-b867-4141-87ff-2b7202476e59@infradead.org>
Date:   Tue, 19 Sep 2023 14:54:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: drm: amd: display: fix kernel-doc warnings
Content-Language: en-US
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20230919093318.16407-1-swarupkotikalapudi@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230919093318.16407-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/19/23 02:33, Swarup Laxman Kotiaklapudi wrote:
> Fix kernel-doc warnings discovered in AMD gpu display driver.
> Fixes these warnings:
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> Function parameter or member 'overlap_only'
> not described in 'mpcc_blnd_cfg'.
> 
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> Function parameter or member 'bottom_gain_mode'
> not described in 'mpcc_blnd_cfg'.
> 
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> Function parameter or member 'background_color_bpc'
> not described in 'mpcc_blnd_cfg'.
> 
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> warning: Function parameter or member 'top_gain'
> not described in 'mpcc_blnd_cfg'.
> 
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> warning: Function parameter or member 'bottom_inside_gain'
> not described in 'mpcc_blnd_cfg'.
> 
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> warning: Function parameter or member 'bottom_outside_gain'
> not described in 'mpcc_blnd_cfg'.
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>

Thanks for fixing these kernel-doc warnings.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> index 8d86159d9de0..61a2406dcc53 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> @@ -91,6 +91,12 @@ enum mpcc_alpha_blend_mode {
>   * @global_gain: used when blend mode considers both pixel alpha and plane
>   * alpha value and assumes the global alpha value.
>   * @global_alpha: plane alpha value
> + * @overlap_only: whether overlapping of different planes is allowed
> + * @bottom_gain_mode: blend mode for bottom gain setting
> + * @background_color_bpc: background color for bpc
> + * @top_gain: top gain setting
> + * @bottom_inside_gain: blend mode for bottom inside
> + * @bottom_outside_gain:  blend mode for bottom outside
>   */
>  struct mpcc_blnd_cfg {
>  	struct tg_color black_color;	/* background color */

-- 
~Randy
