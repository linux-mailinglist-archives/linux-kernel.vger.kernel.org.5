Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF07DC18B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJ3VFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:05:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91AE1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698699912; x=1730235912;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LKLP6UEl/pkjGe0QKZIWac46a5g0E8T9ZC0+kHW1Z4g=;
  b=N9QSXF/t2GWYZ5g14ApqZ4oHKy2mPUpUD0FH+9/TdRnGcwcqh3lbFvIB
   8aylIYepCIxEL2OEQ4Gjgqd2z2B7OHutsaByewvhl/01LDQLp40WPnMVD
   NDjQ6vy5oxrq8QPQCIvCsGrfJIduodngQDdU3XfYIe7McyEG1PK0fpqj8
   KqrpUJpjQF5oLHkYIsWjFA65Thpf6x1zfYmGyQwiKEZpSqbAaEcd2OhyI
   hu05GO3NYy0dhdwBeMqBxjKfblqt+A9p5+rY7a50mknZc2ks4vQ1zAmDF
   ecFdBFvT/g4d9e7NdRRndm9WDcNw7Ezi8fEH3Cs4jGS8Uu9HMG0zRaX3F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9691829"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="9691829"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795365560"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="795365560"
Received: from wezedi-mobl1.amr.corp.intel.com (HELO [10.212.223.192]) ([10.212.223.192])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:05:10 -0700
Message-ID: <85890ed8-0ab3-4b14-879b-be9f0c760db8@linux.intel.com>
Date:   Mon, 30 Oct 2023 16:05:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kevin-lu@ti.com, shenghao-ding@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
References: <20231028092409.96813-1-baojun.xu@ti.com>
 <7f4465c1-5e8e-4c5f-bbff-d2c930326986@linux.intel.com>
 <9d922584-288a-4b73-83ef-477d1bc58521@sirena.org.uk>
 <9b94488e-206d-419b-92ed-e70aab11907b@linux.intel.com>
In-Reply-To: <9b94488e-206d-419b-92ed-e70aab11907b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 12:40, Pierre-Louis Bossart wrote:
> 
> 
> On 10/30/23 12:20, Mark Brown wrote:
>> On Mon, Oct 30, 2023 at 11:05:39AM -0500, Pierre-Louis Bossart wrote:
>>
>>>> +static bool tas2783_readable_register(struct device *dev, unsigned int reg)
>>>> +{
>>>> +	switch (reg) {
>>>> +	case 0x000 ... 0x080:	/* Data port 0. */
>>
>>> No, this is wrong. All the data port 'standard' registers are "owned" by
>>> the SoundWire core and handled during the port prepare/configure/bank
>>> switch routines. Do not use them for regmap.
>>
>>> In other words, you *shall* only define vendor-specific registers in
>>> this codec driver.
>>
>> This seems to come up a moderate amount and is an understandable thing
>> to do - could you (or someone else who knows SoundWire) perhaps send a
>> patch for the regmap SoundWire integration which does some validation
>> here during registration and at least prints a warning?
> 
> Good suggestion, we could indeed check that the registers are NOT in the
> range [0,0xBF] for all ports - only the range [0xC0..FF] is allowed for
> implementation-defined values. I'll try to cook something up.

After checking, the following ranges are invalid for codec drivers:

for address < 0x1000
LSB = 0x00 - 0xBF standard or reserved

0x1800 – 0x1FFF reserved
0x48000000 - 0xFFFFFFFF reserved

is the recommendation to check the regmap_config and its 'yes_ranges'?

Presumably if the range_min or range_max is within the invalid values
above then the configuration can be tagged as problematic in the dmesg
log or rejected with an error code?
