Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260775F561
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGXLqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGXLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:46:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B8E77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199178; x=1721735178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlKjKbV8eSGYQBIcvbzDIb+yA+7AbO7JUoRDIFhHNxE=;
  b=SzfZ8uNuqgo6bRIG4L3xiS6eCA87+7BP2ke2E0WNNKqXyfY/RDNBL5ox
   +d/Ukq6jr9da3O/A+B/Y38VnkZaiiT6wsM57jeuricWVIabGnk7bD8zpx
   Ef3bk8HiVePrvzKMx+cdZ6B4RbEGfjcx5bqlfr1HJyqDZdm9cUAiVeMg8
   G03lq9fee8mmy/Jbd00Mv8p1I0Fgo77r18wWY7JSv/jD3aKUWxv2WAw1T
   ibDbHjbt/kyKfFa+L7mM6mHP8cXi7050Q0/xVlLV2FkY/9SweOrUDtwA+
   sxe/O6jbKjOreUsSQvSp1Zym6+onsbyVNGCQ2CgBooDJgP598OTmv05Jk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398322207"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398322207"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760761957"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760761957"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:14 -0700
Message-ID: <518bb7a9-3a85-2c13-68bf-63baaff176ef@linux.intel.com>
Date:   Mon, 24 Jul 2023 12:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] ALSA: hda/i915: Allow xe as match for
 i915_component_master_match
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
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
 <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 18:41, Maarten Lankhorst wrote:
> xe is a new driver for intel GPU's that shares the sound related code
> with i915.
> 
> Don't allow it to be modprobed though; the module is not upstream yet
> and we should exclusively use the EPROBE_DEFER mechanism.

I can't figure out what this comment means.

how would the -EPROBE_DEFER mechanism help if the driver that will
trigger a new probe is not upstream?

Not following at all what you intended to explain.

> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/hda/hdac_i915.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 961fcd3397f40..12c1f8d93499f 100644
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
