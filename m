Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8E807488
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442662AbjLFQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442578AbjLFQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:07:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418CA3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701878843; x=1733414843;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=iF42xifAlQE9L9Ww4BClL77KuEmCTAx16tvJqKHki3o=;
  b=O6CNLpLZIzo3xM0G5jbnEeXsvw+mS8obl8RXZMAV4RXGf9yy2iOrI8Mk
   w9p+GcY7cLOWkjWV62xSG+ANd27ihK9OrkTJW362YbWqGK/4jWqEO4SVg
   wJQGrwU2cfz3WrFsrLwh4EShOucnXX3Q4znu3nz6X0davVnSkM6YIwGuT
   /q2LfwHOAcNlu5TkW5NNc54zbqbbg5eXVcRqhPBbS0eu20SdCFp/xne8e
   T3XeY3Sn/ND7zrPs/W7PuTUQaNsJvvzZGfDo7wpaN7yx/gfznuESotKDc
   re3Yx1JRJyN6/0K4r6Qh0q5TMgQT6RZC0iHxO1TW08Fv1mM0ZEZ9z0ZAI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7380573"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="7380573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 08:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889395632"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="889395632"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 08:07:18 -0800
Message-ID: <4cd78962-027c-4bbb-a42a-6ccbca81ac8e@linux.intel.com>
Date:   Wed, 6 Dec 2023 17:07:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Gergo Koteles <soyer@irl.hu>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <cover.1701733441.git.soyer@irl.hu>
 <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
 <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
 <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
 <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
 <9c3846ae0da417c0fe5d4fa2d9d4134143184dda.camel@irl.hu>
 <830d8e26-dbb9-4b9c-bbab-a5c4c49a7ffd@linux.intel.com>
Content-Language: en-US
In-Reply-To: <830d8e26-dbb9-4b9c-bbab-a5c4c49a7ffd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 6:22 PM, Pierre-Louis Bossart wrote:
> 
> 
>>>>>> +static void tas2563_fixup_i2c(struct hda_codec *cdc,
>>>>>> +	const struct hda_fixup *fix, int action)
>>>>>> +{
>>>>>> +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
>>>>>
>>>>> Any specific reason to use an Intel ACPI identifier? Why not use
>>>>> "TIAS2563" ?
>>>>>

Will just note that prefix should probably be TXNW (not TIAS) as 
discussed recently on list.

>>>> INT8866 is in the ACPI.
>>>> I don't know why Lenovo uses this name.
>>>> I think it's more internal than intel.
>>>>
>>>>     Scope (_SB.I2CD)
>>>>      {
>>>>          Device (TAS)
>>>>          {
>>>>              Name (_HID, "INT8866")  // _HID: Hardware ID
>>>
>>> Ouch, I hope they checked with Intel that this isn't an HID already in
>>> use...
>>>
>> It looks the INT prefix is not reserved. (yet)
>> https://uefi.org/ACPI_ID_List?acpi_search=INT
> 
> It's been de-facto reclaimed by Intel over the years, apparently using
> INTC or INTL was too hard for some of my colleagues...
> 

Perhaps it should be reserved then, so it is present on above list?

> There are lots of INT devices in the kernel today, here's a small list
> for sound/soc/codecs only
> 
> rt274.c:        { "INT34C2", 0 },
> rt286.c:        { "INT343A", 0 },
> rt298.c:        { "INT343A", 0 },
> ssm4567.c:      { "INT343B", 0 },
> 
> Those INT values were added by Intel teams though, it's really odd to
> see Lenovo use an INT-based HID. Should really use 104C2563 or something.

I will just note that those RT ones are used on quite old RVPs, and yes 
I would have also preferred if they had used "real" IDs, but it is 
unlikely that anyone fixes it after all this time ;).

Adding Andy to CC, as he commented recently about problematic 
assignments of ACPI IDs on this list, maybe he can shed some light on 
the "INT" prefix.
