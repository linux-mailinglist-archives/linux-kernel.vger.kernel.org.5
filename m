Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31F79060D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 10:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbjIBIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjIBIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 04:14:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0078010F6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693642493; x=1725178493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0j1VkS4CMOs9wlRLInadKgPZrsA0NV4dlxpjSSZbcsA=;
  b=dgbPLQQJLZ5zVNfdqi9FJrZTWEpIIM+c2ccDZc2wNTO73tKbnyGhY+xI
   waONd0goIFqvel6GJjTxGLMFEDWk/bHV7z6cnjX4pNAo8E1Ia+FdbR/dj
   voUee75Q7Ui0gFtyJnaq0/L20haTt5gwTpQ/T9EmBEXDWZZcBDKJ4ME3B
   yGAOAW1bqlQld15BF1P1TyOip3f8z0ZDbFInpzpfLFYFcy4yxRm12N+pV
   rJpK6G+sK4eL+JH5HWzsMrw++b+JYEsbjc12KBu83MoOEJqxAq1y/1W7O
   MacMvc75zDY2Q1m7vvwZP8vUayLKZ1PugQL+kHY1ZEjQyhfxRJZGJ7Izm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366587241"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366587241"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 01:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="810314863"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="810314863"
Received: from adurango-mobl1.ger.corp.intel.com (HELO intel.com) ([10.249.43.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 01:14:48 -0700
Date:   Sat, 2 Sep 2023 10:14:45 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arthur Grillo <arthurgrillo@riseup.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/debugfs: Add inline to drm_debugfs_dev_init() to
 suppres -Wunused-function
Message-ID: <ZPLu9b4aL4+a5Scy@ashyti-mobl2.lan>
References: <20230901-debugfs-fix-unused-function-warning-v1-1-161dd0902975@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901-debugfs-fix-unused-function-warning-v1-1-161dd0902975@riseup.net>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

On Fri, Sep 01, 2023 at 03:05:50PM -0300, Arthur Grillo wrote:
> When CONFIG_DEBUG_FS is not set -Wunused-function warnings appear,
> make the static function inline to suppress that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012114.T8Vlfaf8-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012131.FeakBzEj-lkp@intel.com/
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
