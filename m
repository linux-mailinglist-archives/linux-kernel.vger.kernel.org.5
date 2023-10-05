Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5886C7B9E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjJEOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJEOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C228100
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513473; x=1728049473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lpZA39v5SnIRDC7l7LsxZrl19vs2WsIC/6TcqgPdEjk=;
  b=hT6Dg0MCqErYaGVRPsaE5o/FZaSKdjB8sgwpjcuMmSnaX/r/93P0x9u0
   LmVN81Fy89fEBM96cAJvfloqG/nrdk89w+8tKN0GoMb2lPUB38Y6PcfzJ
   NOpHXj72wPE+5BKa1mteI/gRlD6hJZiMoiAR62ZVixCGRsSSqG5GJwG/l
   3MFcCP/5NJ0j02XbnFczl9xiWniE1NbPf24Rz6q3s4sZd/5M57zj4N70f
   AMQxeKfQQ4E/cipBg0msZoo7t1MOvcVK3sZ6jRsDgcXi9bm/v4VoOZ19S
   IN7UBqtp9gJkt54x+82uJJIZ4YjvO/iQ010nDBpzhHcZRCUMs3FKPeo8O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387340122"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="387340122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="751739054"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="751739054"
Received: from szeseong-mobl.gar.corp.intel.com (HELO [10.251.222.152]) ([10.251.222.152])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:58:16 -0700
Message-ID: <b4a010aa-b547-42ad-844f-849f287abd54@linux.intel.com>
Date:   Thu, 5 Oct 2023 13:58:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
 <20231004145540.32321-12-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2310041953090.3390143@eliteleevi.tm.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2310041953090.3390143@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 19:59, Kai Vehmanen wrote:
> Hi,
> 
> I'm good with rest of the series, but one patch requires work.
> 
> On Wed, 4 Oct 2023, Maarten Lankhorst wrote:
> 
>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>> the snd_hdac_i915_init into a workqueue.
>>
>> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
>> probe function.
>>
>> The previously added probe_early can be used for this,
>> and we also use the newly added remove_late for unbinding afterwards.
> [...]
>> --- a/sound/soc/sof/intel/hda-common-ops.c
>> +++ b/sound/soc/sof/intel/hda-common-ops.c
>> @@ -19,6 +19,7 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
>>  	.probe_early	= hda_dsp_probe_early,
>>  	.probe		= hda_dsp_probe,
>>  	.remove		= hda_dsp_remove,
>> +	.remove_late	= hda_dsp_remove_late,
>>  
>>  	/* Register IO uses direct mmio */
>>  
>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>> index 86a2571488bc..4eb7f04b8ae1 100644
>> --- a/sound/soc/sof/intel/hda.c
>> +++ b/sound/soc/sof/intel/hda.c
>> @@ -1160,6 +1160,7 @@ int hda_dsp_probe_early(struct snd_sof_dev *sdev)
>>  		return -ENOMEM;
>>  	sdev->pdata->hw_pdata = hdev;
>>  	hdev->desc = chip;
>> +	ret = hda_init(sdev);
>>  
>>  err:
>>  	return ret;
> 
> I don't think this works. The hda_codec_i915_init() errors are ignored in 
> hda_init() so this never returns -EPROBE_DEFER.
> 
> So something like this is needed on top (tested quickly on one SOF 
> machine and this blocks SOF load until i915 or xe driver is loaded):
> 
> --cut--
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 9025bfaf6a7e..8b17c82dcc89 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -863,13 +863,20 @@ static int hda_init(struct snd_sof_dev *sdev)
>         /* init i915 and HDMI codecs */
>         ret = hda_codec_i915_init(sdev);
>         if (ret < 0)
> -               dev_warn(sdev->dev, "init of i915 and HDMI codec 
> failed\n");
> +               dev_warn(sdev->dev, "init of i915 and HDMI codec failed 
> (%d)\n", ret);

we should not print anything or maximum dev_dbg in case of EPROBE_DEFER.

> +
> +       if (ret < 0 && ret != -ENODEV)
> +               goto out;
>  
>         /* get controller capabilities */
>         ret = hda_dsp_ctrl_get_caps(sdev);
>         if (ret < 0)
>                 dev_err(sdev->dev, "error: get caps error\n");
>  
> +out:
> +       if (ret < 0)
> +               iounmap(sof_to_bus(sdev)->remap_addr);
> +
>         return ret;
>  }
> --cut--
> 
> Br, Kai

-- 
Péter
