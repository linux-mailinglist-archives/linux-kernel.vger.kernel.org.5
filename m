Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE477285B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHGO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHGO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC010F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420205; x=1722956205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SUHQAeoPZgXBUwMl+B0ovX2ZyA2nHmqJqeRcETZsoR0=;
  b=mSDJx8vB41sP0glGZxvIJtSsWjGrSQWvySvdoz2kBWDsbDtPvS2XEv6U
   ibKuSiHcpnoEn8jobPV0GTef5MCuYoIaoupnyqwVw8YISkPQiUUFBymVo
   ymHpKmvQeUuqAlvQ4CDG43tN2ptVfdPkzIV99lfLt6cUUVPFo3yWXKcHJ
   eZ7wQT2NvXSDbOlg0VyXd/CVJNhUfwshjgXIOzQemtDQFeI3yJOsIlm39
   nuQwsL09V1i86BesN85SM2nZRnk2pCEdCiYXJBRtzj7QhFYG5pwOvvKxX
   VJ1ci3MQc7vqfbBGAilwnpenJ5/ZcEW1RKVQ7MabpAHc/TdcU8mdFe/dl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410643"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623896"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623896"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:44 -0700
Message-ID: <401de8fb-8d33-d699-ba09-a7b90356d915@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:28:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 9/9] ALSA: hda/i915: Remove extra argument from
 snd_hdac_i915_init
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
 <20230807090045.198993-10-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-10-maarten.lankhorst@linux.intel.com>
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




> @@ -172,18 +172,10 @@ int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
>  	acomp = bus->audio_component;
>  	if (!acomp)
>  		return -ENODEV;
> -	if (allow_modprobe && !acomp->ops) {
> -		if (!IS_ENABLED(CONFIG_MODULES) ||
> -		    !request_module("i915")) {
> -			/* 60s timeout */
> -			wait_for_completion_killable_timeout(&acomp->master_bind_complete,
> -							     msecs_to_jiffies(60 * 1000));

heads-up that I have a conflicting patch to make the 60s delay
configurable, see https://github.com/thesofproject/linux/pull/4505

> -		}
> -	}
>  	if (!acomp->ops) {
> -		int err = allow_modprobe ? -ENODEV : -EPROBE_DEFER;
>  		snd_hdac_acomp_exit(bus);
> -		return dev_err_probe(bus->dev, err, "couldn't bind with audio component\n");
> +		return dev_err_probe(bus->dev, -EPROBE_DEFER,
> +				     "couldn't bind with audio component\n");
>  	}
>  	return 0;
>  }
