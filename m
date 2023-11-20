Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502447F1E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjKTVSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKTVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:18:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB3C4;
        Mon, 20 Nov 2023 13:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700515128; x=1732051128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYtfmY3EVWUKUBltmFEPvtVvDbJhLP5vaAHjt99/IKw=;
  b=HYWHvejAYsV4atKsHgJNalI0chJRRNs4nr51JtduVgoFnUFWl8zq3QtZ
   5aR4hQbQhRbX2Lt/RsZG7PL0Q/9JAsVs1EL8T54ldteSzu+1y6REE6Q8p
   ADmSz1dneJcPPUQzWOEoPLKcxJb1QpoxtMgJjb6j8vBKMZGZrJrdWfvTy
   LNnqXQ/1VdTrhM4A6jmB4/cA/CdAovAO0u18LY0qySFykLrhbTbLf6h72
   2E0R4/92GAEdDJfGoagSWClr0E+W5fUGPCtzcxI8qdcPDTts5484gFHko
   JgrzM6r7GuisLAMXn1++sK5jZ9Ku2LDc24AWNtbHTGYm9yEwbMns0d3iR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388860353"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="388860353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716329079"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="716329079"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:18:42 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 423A911FAC4;
        Mon, 20 Nov 2023 23:18:40 +0200 (EET)
Date:   Mon, 20 Nov 2023 21:18:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add support for DCMIPP camera interface of
 STMicroelectronics STM32 SoC series
Message-ID: <ZVvNMPfW7OhPByZk@kekkonen.localdomain>
References: <20231120170809.728941-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120170809.728941-1-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Mon, Nov 20, 2023 at 06:07:56PM +0100, Alain Volmat wrote:
> This patchset introduces support for Digital Camera Memory Interface
> Pixel Processor (DCMIPP) of STMicroelectronics STM32 SoC series.
> 
> This initial support implements a single capture pipe
> allowing RGB565, YUV, Y, RAW8 and JPEG capture with
> frame skipping, prescaling and cropping.
> 
> DCMIPP is exposed through 3 subdevices:
> - dcmipp_dump_parallel: parallel interface handling
> - dcmipp_dump_postproc: frame skipping, prescaling and cropping control
> - dcmipp_dump_capture: video device capture node
> 
> v7:
>   - correct byteproc set_fmt handling and compose/crop/fmt handling
>   - replace few v4l2_subdev_get_try_* into v4l2_subdev_get_pad_*

Can you rebase this on my my linuxtv.org tree master branch
<URL:https://git.linuxtv.org/sailus/media_tree.git/log/>?

These will be called v4l2_subdev_state_get_* now.

Thanks.

-- 
Regards,

Sakari Ailus
