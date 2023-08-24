Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073FC786B10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjHXJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjHXJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:03:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B51708;
        Thu, 24 Aug 2023 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692867813; x=1724403813;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1ZAkSY/wD+Wa94fJkUCZoVioGpTkV1ceBb5QI3d2I6E=;
  b=lMsJWXqzqJuFvqOZhQBdv7/wx8+MUA9Ias5vNAwIUH5rGFGoixmqGZk9
   eBISrl50Kolk1bN9mHcWgIGa9U0/T/c5IEQtlAsmjgODNGVlXwATrjUku
   FtBhZ5ycM0PtH1g2J9JAXUuCusXUOuFAQLBIJHBZ7h60BuyM3c89oykHG
   lAJLInCaPmUy5apyEOWR24dPePiJpX0xilGzf/R9ou0pakv0/7KchYJXM
   aAemZmCg/7WYSBhSitm7lm6O9UgAvKzqmSK4Y943eF0dDFW2tHw+QYVCH
   afCkSa734lKW23ho6PkSeMuSWGiWQEAOPvqDKfIdZu7QExoGqRGRherCf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364561584"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364561584"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 02:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736973743"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736973743"
Received: from andrzejk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 02:03:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee@kernel.org>, lee@kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        amd-gfx@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-media@vger.kernel.org,
        Stanley Yang <Stanley.Yang@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Jerome Glisse <glisse@freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230824073710.2677348-1-lee@kernel.org>
Date:   Thu, 24 Aug 2023 12:03:20 +0300
Message-ID: <87wmxk4xt3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023, Lee Jones <lee@kernel.org> wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

The next question is, how do we keep it W=1 clean going forward?

Most people don't use W=1 because it's too noisy, so it's a bit of a
catch-22.

In i915, we enable a lot of W=1 warnings using subdir-ccflags-y in our
Makefile. For CI/developer use we also enable kernel-doc warnings by
default.

Should we start enabling some of those warning flags in drm/Makefile to
to keep the entire subsystem warning free?


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
