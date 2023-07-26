Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818587630A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjGZI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGZI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:59:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A213E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690361585; x=1721897585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxDicZJ47k7fLyihuTdsIFJca8l83vYwixZmuwu3kYk=;
  b=XHelxzyJiHUJzh3OiPv8XJyiT5pauUCOJzu3OQ8t9d6SUCydYh6iwd6J
   bblZpnVOajBnUNt9eOdXmFoBCa+5lMEuT1Ef9r520ygPhygqTmORbAqtQ
   SjPTz7Z2RJk8y0FKbA1mIP+rnV0zGeNWgmC0x5QoEYRL7I9MBEVAp+57w
   Tj7E+q8AyN6I7SJ5Zl9YCOSaGTWPyyGzpANCbq8HUjdEhoQ5qY04LJ8U+
   +7iZFnq3EqyADpOtBKMMdJveUxN59/P7wojkLs2elqDjwKgBL6JszItSC
   5N9REGfHM1cZdFjIj6L4GcpN/gv99faGlB8XF+LV5y93wyKc2rjfP6U9R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352858668"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352858668"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="816584916"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="816584916"
Received: from kgerlich-mobl.ger.corp.intel.com (HELO [10.252.35.173]) ([10.252.35.173])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:52:57 -0700
Message-ID: <9e8892cd-4c31-61a2-94e0-379e576cb7d6@linux.intel.com>
Date:   Wed, 26 Jul 2023 10:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230726140848.2267568-1-brent.lu@intel.com>
 <20230726140848.2267568-2-brent.lu@intel.com>
 <7349d6f4-4866-6fb3-57c9-9ce2d6989576@linux.intel.com>
 <CY5PR11MB625741E8CCBA25EAA82739579700A@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB625741E8CCBA25EAA82739579700A@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 10:33 AM, Lu, Brent wrote:
> 
>>>    const struct snd_soc_dapm_route max_98373_dapm_routes[] = { @@
>>> -168,17 +181,6 @@ static struct snd_soc_codec_conf max_98390_codec_conf[]
>> = {
>>>    		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
>>>    		.name_prefix = "Left",
>>>    	},
>>> -};
>>> -
>>> -static struct snd_soc_codec_conf max_98390_4spk_codec_conf[] = {
>>> -	{
>>> -		.dlc = COMP_CODEC_CONF(MAX_98390_DEV0_NAME),
>>> -		.name_prefix = "Right",
>>> -	},
>>> -	{
>>> -		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
>>> -		.name_prefix = "Left",
>>> -	},
>>
>> if you remove the codec conf, doesn't this impact the Kcontrols names?
>> Does this break existing UCM files?
>>
>> It's rather hard to review with just the diff.
>>
> 
> I just merge two arrays, max_98373_dapm_routes and max_98390_4spk_codec_conf,
> since the first two entries are the same.

Routes and codec conf are different things, not following how you can 
merge them?

Wondering if you are referring to a different array, i.e.

static struct snd_soc_codec_conf max_98390_codec_conf[]
	
static struct snd_soc_codec_conf max_98390_4spk_codec_conf[]

> 
> Later in max_98390_set_codec_conf() function we will set the num_configs with
> number of amplifiers.
> 
> void max_98390_set_codec_conf(struct snd_soc_card *card)
> {
> 	unsigned int num_codecs = get_num_codecs(MAX_98390_ACPI_HID);
> 
> 	card->codec_conf = max_98390_codec_conf;
> 
> 	switch (num_codecs) {
> 	case 2:
> 	case 4:
> 		card->num_configs = num_codecs;
> 
> Regards,
> Brent
> 

