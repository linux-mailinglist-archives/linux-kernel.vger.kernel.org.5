Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADD788E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjHYRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbjHYRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:50:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4F213B;
        Fri, 25 Aug 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692985837; x=1724521837;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MNxhxZVgxztKuNKuvsL0AzLilS4KbqaTek8IWrU+J20=;
  b=E77krGQSbCbr6L9+8RDdyr5hbI0fVJfEor2UzXYhnkw4eOvWYot6u66p
   x40+b3GNWG2Njli5USefOwrTQBEm6nV1Y1yFKsVKW9oPEewOZRuto0M8C
   S54fpfGHoqziUdRmFr1riZVrmWP7eJ03vum+yY/m6Khg5aIDbJlpkIrvx
   E4eVNc/715YW+cwaidbM0PFhoek00C7DgwFSh4v/4yPFoU9dWHnVkikMR
   +TG6UnalSWKJDJ3kr2LPhkC4TiW16vZxw/SeAR3cdgQgTCEP3Z34cMqdS
   8UWPjUjetc/cW/W75XteTNw8sNS9o5Ls4shd3vVPSuKjZsYsLq3DGMFzM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378547667"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="378547667"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807617356"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="807617356"
Received: from semenova-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.46.222])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:50:30 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        robdclark@google.com, corbet@lwn.net, khilman@baylibre.com,
        sergi.blanch.torne@collabora.com, gustavo.padovan@collabora.com,
        linux-rockchip@lists.infradead.org, daniels@collabora.com,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        mripard@kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: Re: [PATCH 2/6] drm: ci: Force  db410c to host mode
In-Reply-To: <29c7-64e8b600-1-6afffd8@162524228>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <29c7-64e8b600-1-6afffd8@162524228>
Date:   Fri, 25 Aug 2023 20:50:26 +0300
Message-ID: <87msyf2eql.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023, "Helen Mae Koike Fornazier" <helen.koike@collabora.com> wrote:
> I'm not sure I get what do you call out-of-tree builds.

Using 'make O=dir' (see make help) to separate source and and output
directories.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
