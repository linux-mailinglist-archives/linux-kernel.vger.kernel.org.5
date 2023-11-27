Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0CA7F9D92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjK0Kcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjK0Kca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:32:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8410F;
        Mon, 27 Nov 2023 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701081156; x=1732617156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZsD2/0d829tjp3/J12DPotTKkJoMGcOkrsxN0arhzI=;
  b=DtSStpWPcQc2nvraXNduvteZFFKUApl/MANmyYmtai3eiMOT0sPpFz+7
   sUTuVA1UE0wjxjZFLqOE6+wxDJV8Pxn/K1vfP38e+fQKYxIWJKtAl+Tw1
   YmqQEVWsZCFd9ASk60TqrDUT5iqKNZS9k6TDriIsUPmQZA4YF0aZK6Lms
   zWMwP45VX2fgizThtLiYYhw8ZbLLWvlid2hh3qlcysNvFX276N0IED8DV
   VgfeipUf0ILzY5Mx10OW/W/J3rWRUzPaasy9tPdFSC/cHVyijmt73wtJo
   wRfSiPgCUmbkrF56f8PkywyzJUvsH+MuaiiWcUQz7aiMXE8mhmBYKszv/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="377710262"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="377710262"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 02:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="891693461"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="891693461"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 02:32:31 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id C8A9711FCD0;
        Mon, 27 Nov 2023 12:32:28 +0200 (EET)
Date:   Mon, 27 Nov 2023 10:32:28 +0000
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
Subject: Re: [PATCH v8 3/5] media: stm32-dcmipp: STM32 DCMIPP camera
 interface driver
Message-ID: <ZWRwPJQA_wNEVD8Y@kekkonen.localdomain>
References: <20231122073927.788810-1-alain.volmat@foss.st.com>
 <20231122073927.788810-4-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122073927.788810-4-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Wed, Nov 22, 2023 at 08:39:17AM +0100, Alain Volmat wrote:
> From: Hugues Fruchet <hugues.fruchet@foss.st.com>
> 
> This V4L2 subdev driver enables Digital Camera Memory Interface
> Pixel Processor(DCMIPP) of STMicroelectronics STM32 SoC series.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

One more thing. I think you're missing all the link_validate ops, meaning
it's possible to start the hardware with invalid configuration.

Could you add them? It can be a separate patch. I'll postpone these until
that.

-- 
Regards,

Sakari Ailus
