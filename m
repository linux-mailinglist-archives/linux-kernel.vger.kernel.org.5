Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15D76B9A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHAQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjHAQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:32:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F601BF9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690907569; x=1722443569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hGXSIomR/hYXqDdN43YsvF3tHJldhPsq0ZPOr50DyDE=;
  b=FXvmcswBkEu4aDlu70idFe61zRK9A+4bx8pnVqXL2Ql3hDxjjRcbdf0l
   pqjI1FYJCrLz1BkJeLNRjtwuk0nZZhCs6GXooFbtT/u8MHInVSYasz64J
   XuueFzQeE4FYlbz3VNIkmTJ/ilRPjcfs+F1bNe8kKYSsAwwIJyVUySncV
   iYIEjmeevndx3hvSM2emVL+hj6cTg+BGO9x/MAWLinRrkbuXwEzzDwXYa
   ps9a68zU8ss2SYiNLTvVDpXk5IH4F6aDZI61slUr3g4i6bhRAEirkJ5Vk
   NZVlp3288bxWDswxNShBeuUaLMu0jr9BXUoGNoV6KqdCaEgi5To+fm/wG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368247288"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="368247288"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 09:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852533249"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="852533249"
Received: from gviswana-mobl1.amr.corp.intel.com (HELO [10.212.93.160]) ([10.212.93.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 09:32:46 -0700
Message-ID: <f6efb6f9-11ae-e901-f2a5-a4ef94590290@linux.intel.com>
Date:   Tue, 1 Aug 2023 11:32:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/9] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <87r0oohyea.wl-tiwai@suse.de>
 <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I've been working on a small change to keep the workqueue in SOF and
> only move the binding to the probe function to match what snd-hda-intel
> is doing, but I don't know if that is needed?
> 
> It was a bit unclear to me based on feedback if I should try to kill the
> workqueue on all drivers (but with no way to test), or keep it around.

My understanding is that we only want to move the binding to the probe
function and leave the workqueue removal for another day - possibly never.
