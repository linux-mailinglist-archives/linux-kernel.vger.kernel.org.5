Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621097B3AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjI2UGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjI2UGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:06:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C6B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=eC20//QhF98C1kt/J8oEmhBMKIruxNdmNuyRsqobxqI=; b=GIcXsx+P98ZligLGIAGNPJo1HF
        3pCu/SJDukgoLmxrJGwCp8nMjDqbo4MzGF4aSYA/iFAGuWcSB1eAeUTw70DN8OrwARBazFPEMt3ES
        4ktNO5V8FMa+U0zYBaIOw2l9ULCIcncUKuGAhPX8i79MuLA7cgsFd+KqYP52CPMyoxr1ib69K8WjG
        5+rqzvmd8//Si+w3CmJ/NMZnVKmUBgQfuecosdg78IDAZ94ChIs+pR97sdy2hGxvy+YwA620+kR7M
        las0v7tJ7hAOQk9U0PHCMpLrQpnxndwiyI4Kh1kaiYzaISTB8hqwVjFGIMdPCJdslYiB0b/9iz8m8
        NCYxZN8A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmJkk-008WRL-35;
        Fri, 29 Sep 2023 20:06:23 +0000
Message-ID: <9270c1f3-c8f3-4b3c-91ec-ed17d97ecafd@infradead.org>
Date:   Fri, 29 Sep 2023 13:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add kernel docs for dc_dmub_caps
Content-Language: en-US
To:     Sagar Vashnav <sagarvashnav72427@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <215ed02d-1dab-480f-84fb-a828b294f716@infradead.org>
 <20230929100055.17563-1-sagarvashnav72427@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230929100055.17563-1-sagarvashnav72427@gmail.com>
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

The $Subject could be improved, e.g.:

[PATCH] drm/amd/display: add kernel docs for dc_dmub_caps


On 9/29/23 03:00, Sagar Vashnav wrote:
> Add kernel documentation for the dc_dmub_caps structure.
> 
> Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 8125839..14b4c50 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -208,6 +208,16 @@ struct dc_color_caps {
>  	struct mpc_color_caps mpc;
>  };
>  
> +/**
> + * struct dc_dmub_caps - DMUB (Display Microcontroller Unit) capabilities
> + * @psr: support for PSR (Power Saving State Residency)
> + * @mclk_sw: support for MCLK_SW (Memory Clock Switch)
> + * @subvp_psr: support for SUBVP PSR (Sub-Viewport Power Saving State Residency)
> + * @gecc_enable: GECC (Global Error Correcting Code) enablement.
> + *
> + * This structure describes the capabilities of the Display Microcontroller Unit (DMUB).
> + * It specifies whether certain features like PSR and MCLK_SW are supported.
> + */
>  struct dc_dmub_caps {
>  	bool psr;
>  	bool mclk_sw;

-- 
~Randy
