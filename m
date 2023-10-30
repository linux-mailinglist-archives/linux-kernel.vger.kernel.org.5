Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343C47DBF38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjJ3RlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjJ3RlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:41:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EAC9F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698687661; x=1730223661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HQPbEJwDYJoTRJSOJp2zhcD6tw8Fd/fvwRJqyc7v2D0=;
  b=EEgzAcN+TOu32hw1muJudDFgQDtSmGh8USKat75h+DfRXv7IPbzLlR20
   WzbFbrFGqsDiJCyFYJb+gpt1gm0hDRUbas21EgEqMR5JT/stgLMFZoHrb
   max3Q5z2UjEP6DwswnKWwGc5p6CTE7zO9Y8Yb0KXujN4mROhmb4m+VwW5
   NdayBO8Cu4Z7dcTvMPHw5F1/JjrCPHs6jqikGaQ1EnQtNNfsb56laY7Gu
   rhP9ufVuYmuNeu+SfTeRlrku83aVWkc8THf2tJ0+G5WiQ1PIZfxn1AyoR
   C7ci4G1lvs7GYYzDM/rBYrzKpjrzd0oueqRWn0rYlSeGsYetskPu3zUY0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9652520"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="9652520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 10:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710163443"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710163443"
Received: from wezedi-mobl1.amr.corp.intel.com (HELO [10.212.223.192]) ([10.212.223.192])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 10:40:59 -0700
Message-ID: <9b94488e-206d-419b-92ed-e70aab11907b@linux.intel.com>
Date:   Mon, 30 Oct 2023 12:40:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kevin-lu@ti.com, shenghao-ding@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
References: <20231028092409.96813-1-baojun.xu@ti.com>
 <7f4465c1-5e8e-4c5f-bbff-d2c930326986@linux.intel.com>
 <9d922584-288a-4b73-83ef-477d1bc58521@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9d922584-288a-4b73-83ef-477d1bc58521@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 12:20, Mark Brown wrote:
> On Mon, Oct 30, 2023 at 11:05:39AM -0500, Pierre-Louis Bossart wrote:
> 
>>> +static bool tas2783_readable_register(struct device *dev, unsigned int reg)
>>> +{
>>> +	switch (reg) {
>>> +	case 0x000 ... 0x080:	/* Data port 0. */
> 
>> No, this is wrong. All the data port 'standard' registers are "owned" by
>> the SoundWire core and handled during the port prepare/configure/bank
>> switch routines. Do not use them for regmap.
> 
>> In other words, you *shall* only define vendor-specific registers in
>> this codec driver.
> 
> This seems to come up a moderate amount and is an understandable thing
> to do - could you (or someone else who knows SoundWire) perhaps send a
> patch for the regmap SoundWire integration which does some validation
> here during registration and at least prints a warning?

Good suggestion, we could indeed check that the registers are NOT in the
range [0,0xBF] for all ports - only the range [0xC0..FF] is allowed for
implementation-defined values. I'll try to cook something up.

> Also worth noting that the default is going to be that the registers are
> readable if the driver doesn't configure anything at all so perhaps at
> least for just readability this might be worth revisiting.

Having the interrupt registers as readable could be problematic, there's
a known race condition where the drivers need to do a read after a
write, and I am a bit worried if we have two agents reading the same
thing. It's the only case I am aware of where a read establishes a state.

>>> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
>>> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
>>> +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
>>> +		0, 0),
>>> +	SND_SOC_DAPM_SPK("SPK", NULL),
>>> +	SND_SOC_DAPM_OUTPUT("OUT"),
>>> +	SND_SOC_DAPM_INPUT("DMIC")
>>> +};
> 
>> Can you clarify what "ASI" is?
> 
> ASI seems to be a fairly commonly used name in TI devices...  In general
> naming that corresponds to the datasheet should be fine, especially for
> internal only things like this sort of DAPM widget.  I'd guess it's
> something like Audio Serial Interface but not actually gone and looked.

I was only asking was the acronym stood for to make it easier to
look-up. Not asking for any technical details.
