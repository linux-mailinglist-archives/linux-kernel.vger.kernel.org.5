Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24362772855
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHGO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHGO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0B10D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420201; x=1722956201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SaHNAycvvF2ElR8nisXlQ70kDCQK0462eRAig4OuDxs=;
  b=HqvMqJrvVbLKNXl5JHA3wR4EDl3CjFDlxkYtkIpi531O+azgFf4cHb7L
   sPiQKNT/lLML9fKmTW8QJPGrrrLZ1ByVHBxMd52TUS/TEPCmqdCtCVRCp
   RIcl25YXcwvZ82pG8EpPzogsUsAV7pz/xJtEc8VMrWnWAOY2ChVehb2wI
   8ZIt0w1VKmWFhDWRc2WfUtTYeuRiUoWCd0t0zMgJ+9hdHx+PaUsp/iUJW
   Yi8RebQt133pdupIUSeyRkrdEcfaSotAROwPkG8SegQW/D4GqbsJSQIuc
   U7w2XpB5jwUTm2o7DjrI4zFIZbQsZnNgDlS2wKgxWepXDzJWQmZDK1w8Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410600"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623874"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623874"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:38 -0700
Message-ID: <92d03e5e-c0b4-98ef-5f02-6088b4a0e5f8@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:11:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/9] ALSA: hda/i915: Allow xe as match for
 i915_component_master_match
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
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
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-5-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-5-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 04:00, Maarten Lankhorst wrote:
> xe is a new driver for intel GPU's that shares the sound related code
> with i915.
> 
> Don't allow it to be modprobed though; the module is not upstream yet
> and we should exclusively use the EPROBE_DEFER mechanism.

The wording hasn't changed and remains confusing, likely to trigger all
paranoia triplines. Consider rewording if there's an update.

> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/hda/hdac_i915.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 961fcd3397f4..12c1f8d93499 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -115,7 +115,8 @@ static int i915_component_master_match(struct device *dev, int subcomponent,
>  	hdac_pci = to_pci_dev(bus->dev);
>  	i915_pci = to_pci_dev(dev);
>  
> -	if (!strcmp(dev->driver->name, "i915") &&
> +	if ((!strcmp(dev->driver->name, "i915") ||
> +		 !strcmp(dev->driver->name, "xe")) &&
>  	    subcomponent == I915_COMPONENT_AUDIO &&
>  	    connectivity_check(i915_pci, hdac_pci))
>  		return 1;
