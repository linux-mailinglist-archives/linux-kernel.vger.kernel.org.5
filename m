Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6033D780BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376899AbjHRM2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376908AbjHRM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:28:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4ED103
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692361690; x=1723897690;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GctVCNTw8ESzuUERp0VBFkWHXTLT3XaK5llUVzorn9k=;
  b=m9jxsHy/Wu2LPLSXEZLXcm063eQBf/3Mj8vm4dJxMwMjRM4GnMaXrzTZ
   OMMt+H0JiSF3L/Xkq9DbSbpaFsbAU6/+5SXGGQbmSLANUtGlYRl4Qba9H
   PRoHLJlIpasgTYtoxb8TwewqvGyalDpmde79oI7MIz86JDn2kvzwwhX6G
   ejntpSqfg1rswNkyF51LhsjNU6xtaRhvYHBYo4qbQ8kC+Vy26nw0tfm2c
   0qjESbp7x4fGcb9zh6EcIpgK28Qw731aFHVC7H4ZAnYB20bNzaQ1mFGSP
   bzxbVZpwjosD2+P8EyTsLA4dMOQy1biRXHWye5yieX655wCv56TsfVFL+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="371992654"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="371992654"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 05:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="711981389"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="711981389"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 05:28:05 -0700
Date:   Fri, 18 Aug 2023 15:24:14 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Takashi Iwai <tiwai@suse.de>
cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Maarten Lankhorst <dev@lankhorst.se>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
In-Reply-To: <87il9ck52l.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2308181522050.3532114@eliteleevi.tm.intel.com>
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com> <20230807090045.198993-9-maarten.lankhorst@linux.intel.com> <4acc7318-69b3-3eb5-1fe8-f7deea8adfad@linux.intel.com> <87a5uwr7ya.wl-tiwai@suse.de> <e88d139f-e62b-1654-0d35-a46c698298c6@lankhorst.se>
 <87il9ck52l.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 Aug 2023, Takashi Iwai wrote:

> On Mon, 14 Aug 2023 16:26:01 +0200,
> Maarten Lankhorst wrote:
> > 
> > Ping on this?
> 
> Pierre?  Does one of your recent patch sets achieves the suggested
> thing?  Or do we need another rewrite/respin of this series?
> Currently it's blocking the merge for 6.6.

this is likely to require another spin. Pierre did a draft of
the new ops at https://github.com/thesofproject/linux/pull/4527
and Maarten is looking to adapt the series to this.

Br, Kai
