Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6086F7650BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjG0KR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0KRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:17:54 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74683136
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690453072; x=1721989072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i40kkbTsdb38qiGVDasibks/QH/gJb3cMVszKUDLJ+Q=;
  b=apWROy/oteOzgwGMq3Hz85OzIoeG9cLMDIHSPaNjqL95z+Z/4YxRBM3L
   XnvbwlZKOCQP+95cWeL7vqNVICwhDMMU4jCtsfSplZkfvZ2PI0QQP77UA
   oKnEKP8+XFRe1JeDT2+KxyzYyfj/i9BT/HTD8ogD7NIA5viucpq+SM8DW
   oCwAgyq+uhXksJHrKzjdHpwt4Ojta1hqTbNHsQdnwBrFtyaCbtwl4bkAN
   XMPmuE/Bu5TmdVhmESAdVe3s7VwlH0k32/EzVAow5tB7xbHycqeFVx3SZ
   JLritYXVY2OnXGWrw2demoNGoveyRtzqHUDZmyMjhIUqR3BGVKuTRqtBQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371879750"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="371879750"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 03:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="677102021"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="677102021"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2023 03:17:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOy40-00Gse5-1y;
        Thu, 27 Jul 2023 13:17:44 +0300
Date:   Thu, 27 Jul 2023 13:17:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH v3 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Message-ID: <ZMJESOsmm/0ta+Nc@smile.fi.intel.com>
References: <20230727104354.2344418-1-brent.lu@intel.com>
 <20230727104354.2344418-2-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727104354.2344418-2-brent.lu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:43:53PM +0800, Brent Lu wrote:
> Implement a helper function to get number of codecs from ACPI
> subsystem to remove the need of quirk flag in machine driver.

...

>  static int max_98390_hw_params(struct snd_pcm_substream *substream,
>  			       struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>  	struct snd_soc_dai *codec_dai;
> +	int i, ret = 0;

Redundant assignment.

>  	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +		if (i >= ARRAY_SIZE(max_98390_tdm_mask)) {
>  			dev_err(codec_dai->dev, "invalid codec index %d\n", i);
>  			return -ENODEV;
>  		}
>  
> +		ret = snd_soc_dai_set_tdm_slot(codec_dai, max_98390_tdm_mask[i].tx,
> +					       max_98390_tdm_mask[i].rx, 4,
> +					       params_width(params));
> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "fail to set tdm slot, ret %d\n",
> +				ret);
> +			return ret;
>  		}
>  	}
>  	return 0;
>  }

...

> +	case 2:
> +		/* add regular speakers dapm route */
> +		ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
> +					      ARRAY_SIZE(max_98390_dapm_routes));
> +		if (ret) {
> +			dev_err(rtd->dev, "unable to add dapm routes, ret %d\n",
> +				ret);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		dev_err(rtd->dev, "invalid codec number %d\n", num_codecs);

> +		ret = -EINVAL;
> +		break;

You can

		return -EINVAL;

>  	}
> +
>  	return ret;

...

> +#define MAX_98390_ACPI_HID	"MX98390"

> +#define MAX_98390_DEV0_NAME	"i2c-MX98390:00"
> +#define MAX_98390_DEV1_NAME	"i2c-MX98390:01"
> +#define MAX_98390_DEV2_NAME	"i2c-MX98390:02"
> +#define MAX_98390_DEV3_NAME	"i2c-MX98390:03"

Maybe (maybe, don't know subsystem preferences)

#define MAX_98390_DEV0_NAME	"i2c-" MAX_98390_ACPI_HID ":00"
#define MAX_98390_DEV1_NAME	"i2c-" MAX_98390_ACPI_HID ":01"
#define MAX_98390_DEV2_NAME	"i2c-" MAX_98390_ACPI_HID ":02"
#define MAX_98390_DEV3_NAME	"i2c-" MAX_98390_ACPI_HID ":03"

-- 
With Best Regards,
Andy Shevchenko


