Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC54F75C5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGULbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGULbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:31:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C130E8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689939101; x=1721475101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dXgGdDZe21q+A6YjKZPUfJZVifU9r1MKAmEsUXEnEPo=;
  b=e/CAQ24zZzwocAyme0sc2mNkKGD1PM6D1yM5B6bK0sUAbtywJnRwmK9T
   UxWNUYTVn2SXIz0akb9PQhSL06qfQIIayhEFLyRFOJ3PKfKRzh8RPJcAd
   r/KiT4JYzcMbIi+UIozUfJm+YYFA6hFlRb0r8YXD7uaNodbDrglB+opp4
   EMU7+a76LEDDPWUDJ+SksFdPUKxt84XGevfWkSc24jt4gzsTQrk8P0Nt7
   XrkkAiy9rqjLGuW+NqlizhcGhH2LGXJXbG8cVJbWNiZXrIUsNwiRA2++6
   FHoqBeV4i+q7ymK4YlCgRIvfF2kGNsZR5nGNV4Vb2lGO2ugdTR4v2iaDA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433230779"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433230779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868217214"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:31:36 -0700
Message-ID: <a01b804f-345b-153f-1112-b7057400e8c8@linux.intel.com>
Date:   Fri, 21 Jul 2023 14:32:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/9] ALSA: hda/i915: Add an allow_modprobe argument to
 snd_hdac_i915_init
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
 <20230719164141.228073-4-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-4-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2023 19:41, Maarten Lankhorst wrote:
> Xe is a new GPU driver that re-uses the display (and sound) code from
> i915. It's no longer possible to load i915, as the GPU can be driven
> by the xe driver instead.
> 
> The new behavior will return -EPROBE_DEFER, and wait for a compatible
> driver to be loaded instead of modprobing i915.
> 
> Converting all drivers at the same time is a lot of work, instead we
> will convert each user one by one.
> 
> Changes since v1:
> - Use dev_err_probe to set a probe reason for debugfs' deferred_devices.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  include/sound/hda_i915.h        | 4 ++--
>  sound/hda/hdac_i915.c           | 8 ++++----
>  sound/pci/hda/hda_intel.c       | 2 +-
>  sound/soc/intel/avs/core.c      | 2 +-
>  sound/soc/intel/skylake/skl.c   | 2 +-
>  sound/soc/sof/intel/hda-codec.c | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index c32709fa4115f..961fcd3397f40 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -155,7 +155,7 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
>   *
>   * Returns zero for success or a negative error code.
>   */
> -int snd_hdac_i915_init(struct hdac_bus *bus)
> +int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
>  {
>  	struct drm_audio_component *acomp;
>  	int err;
> @@ -171,7 +171,7 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
>  	acomp = bus->audio_component;
>  	if (!acomp)
>  		return -ENODEV;
> -	if (!acomp->ops) {
> +	if (allow_modprobe && !acomp->ops) {
>  		if (!IS_ENABLED(CONFIG_MODULES) ||
>  		    !request_module("i915")) {
>  			/* 60s timeout */
> @@ -180,9 +180,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
>  		}
>  	}
>  	if (!acomp->ops) {
> -		dev_info(bus->dev, "couldn't bind with audio component\n");
> +		int err = allow_modprobe ? -ENODEV : -EPROBE_DEFER;

Add one blank line here.

>  		snd_hdac_acomp_exit(bus);
> -		return -ENODEV;
> +		return dev_err_probe(bus->dev, err, "couldn't bind with audio component\n");
>  	}
>  	return 0;
>  }

-- 
Péter
