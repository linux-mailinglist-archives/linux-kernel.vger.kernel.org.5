Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772DB7B23F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjI1Ra1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjI1RaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:30:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBACC0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=8sxeQBsEAeAqlCpzYUzPR1mLiBdt9dWaAHA9ucN4CSo=; b=mErgLmShn3yXCfA/g/By3a2WyM
        Fhw5qvBw/YMdZ69E8AL3+t5CBpMofy2j0S3QQt6uKOciRUyr+mKPY5WsRp0ZJrAhPyWj8A4TI4sPn
        KliGStBzFAnCN8sFMJhYny81mmDxYN0eKuuH1h2qb0XmVAajJIc5wc80O3wgDING7NMRjS1IZFGQJ
        ICSS1UWy1sqAJVoLL2pQtcLiuZqblmj2I54v/Sx+OOQx3UxFgmgFb8OfLhKm2kggcKx6QomyF6GSx
        RudatMyn+YpG9DzpHOtin4jWOK7VgKA0WlDQQZ0i+CEFyXd/kxDnSJJN5QHs8qfAbqFCh3MNzWBGo
        wNp63JOg==;
Received: from [2603:3004:644:9100::a64a]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qluqA-003lve-Nr; Thu, 28 Sep 2023 17:30:18 +0000
Message-ID: <215ed02d-1dab-480f-84fb-a828b294f716@infradead.org>
Date:   Thu, 28 Sep 2023 10:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add kernel-doc for dc_dmub_caps
To:     Sagar Vashnav <sagarvashnav72427@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230928163452.15084-1-sagarvashnav72427@gmail.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230928163452.15084-1-sagarvashnav72427@gmail.com>
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

Hi--

On 9/28/23 09:34, Sagar Vashnav wrote:
> From: sagar-7227 <sagarvashnav72427@gmail.com>
> 
> Add kernel documentation for the dc_dmub_caps structure.
> 
> Signed-off-by: sagar-7227 <sagarvashnav72427@gmail.com>

Use full name, please.

> ---
>  dc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

What file is being patched?
The patch should include the file's full path, like:

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h


> diff --git a/dc.h b/dc.h
> index 8125839..cd4dab3 100644
> --- a/dc.h
> +++ b/dc.h
> @@ -208,6 +208,16 @@ struct dc_color_caps {
>  	struct mpc_color_caps mpc;
>  };
>  
> +/**
> + * struct dc_dmub_caps - DMUB (Display Microcontroller Unit) capabilities
> + * @psr: support for PSR (Power Saving State Residency)
> + * @mclk_sw: support for MCLK_SW (Memory Clock Switch)
> + * @subvp_psr: supprt for SUBVP PSR (Sub-Viewport Power Saving State Residency)

                  support

> + * @gecc_enable: GECC (Global Error Correcting Code) enablement.
> + *
> + * This structure describes the capabilities of the Display Microcontroller Unit (DMUB).
> + * It specifies whether certain features like PSR and MCLK_SW are supported.
> + */
>  struct dc_dmub_caps {
>  	bool psr;
>  	bool mclk_sw;

For the patch to be considered, reviewed, and accepted, it should be sent
to the AMD DRM display maintainers & mailing list. See the MAINTAINERS file:

AMD DISPLAY CORE
M:	Harry Wentland <harry.wentland@amd.com>
M:	Leo Li <sunpeng.li@amd.com>
M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
L:	amd-gfx@lists.freedesktop.org


Thanks.
~Randy



