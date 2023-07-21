Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2775C6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGUMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGUMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:19:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D82D4A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941949; x=1721477949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BQWRCfCl6FTfjz+irNQ/lRPGRLwnMG5jzHyXBfU3ozU=;
  b=LuhlyfH2bY0sxVplaNFE+C+HWPkNSOV2IolCCNbVqKiw7vdXF3zkkg/W
   oL76on6AbTGX2hPk6j3KYf0CiHsriqtCvd9mfEcRPl6FC73L825+WSlt4
   r3DQM+GiNyi1eVM/wNx7UDi4ma1jD3QLYil8ombIK8/2FIEw2R3Z2MD6x
   Tga3vqnuQqCk9ANQ/I1D7pBfrLnvcBTCzep7HwQAXf4vIL1Kl1fUx/TQo
   fAMGubrXhxl9eE7qIblE5d6khTqo54mzsL1431v9pvdfbkpVr1UAtGtUU
   P+Tfk/8U5B4gdQDxedt1YR9aCqQTC+avmkbpOJdlIkN6BofS5KOdjCevg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356999042"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356999042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="675028854"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="675028854"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:19:03 -0700
Message-ID: <8309a1a1-a99e-f099-099e-b4c051987950@linux.intel.com>
Date:   Fri, 21 Jul 2023 15:20:21 +0300
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
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2023 19:41, Maarten Lankhorst wrote:
> xe is a new driver for intel GPU's that shares the sound related code
> with i915.
> 
> Don't allow it to be modprobed though; the module is not upstream yet
> and we should exclusively use the EPROBE_DEFER mechanism.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

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

-- 
Péter
