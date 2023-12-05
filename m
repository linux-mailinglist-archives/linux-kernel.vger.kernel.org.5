Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F78805BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbjLERWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjLERW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:22:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B18CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796955; x=1733332955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MeDMLrXfTdh4yho03MywBVkvXJzOkrKUTV/2+kLOfuo=;
  b=aImoqk7PuYp8X4tKKJmErcTXGANXVir6USxfq2faP/DDZBfxV+43d+Ln
   63kmhI/IMeeyBz+voYIZwlseHb2gEtcAsgXEE7OZ16TcI9DlE7NeZWg2A
   sXoEJZJB56X5aotaIkRo/UquRlXcWx9rDMo877dvFuelY1beAf9R3HgQS
   yKN4V+JTeQjNgpLA9+QWx74oxtwqrAtU1Snr5rbT20H086OyT1OKy3gGo
   1fzXiqsaJAm6YUGKKQJiHfGZwqG7O8TPXT9VGM4AsWXd2fwSqqvU806nF
   R9UrPnNqUbMk2epwUYJgCmZu5CDRC9Y8ET2fuNw1Pab7u5fpBhf3xLK5R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="458246965"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="458246965"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774702299"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="774702299"
Received: from mbapna-mobl1.amr.corp.intel.com (HELO [10.212.151.198]) ([10.212.151.198])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:22:33 -0800
Message-ID: <830d8e26-dbb9-4b9c-bbab-a5c4c49a7ffd@linux.intel.com>
Date:   Tue, 5 Dec 2023 11:22:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <cover.1701733441.git.soyer@irl.hu>
 <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
 <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
 <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
 <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
 <9c3846ae0da417c0fe5d4fa2d9d4134143184dda.camel@irl.hu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9c3846ae0da417c0fe5d4fa2d9d4134143184dda.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>> +static void tas2563_fixup_i2c(struct hda_codec *cdc,
>>>>> +	const struct hda_fixup *fix, int action)
>>>>> +{
>>>>> +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
>>>>
>>>> Any specific reason to use an Intel ACPI identifier? Why not use
>>>> "TIAS2563" ?
>>>>
>>> INT8866 is in the ACPI.
>>> I don't know why Lenovo uses this name.
>>> I think it's more internal than intel.
>>>
>>>    Scope (_SB.I2CD)
>>>     {
>>>         Device (TAS)
>>>         {
>>>             Name (_HID, "INT8866")  // _HID: Hardware ID
>>
>> Ouch, I hope they checked with Intel that this isn't an HID already in
>> use...
>>
> It looks the INT prefix is not reserved. (yet)
> https://uefi.org/ACPI_ID_List?acpi_search=INT

It's been de-facto reclaimed by Intel over the years, apparently using
INTC or INTL was too hard for some of my colleagues...

There are lots of INT devices in the kernel today, here's a small list
for sound/soc/codecs only

rt274.c:        { "INT34C2", 0 },
rt286.c:        { "INT343A", 0 },
rt298.c:        { "INT343A", 0 },
ssm4567.c:      { "INT343B", 0 },

Those INT values were added by Intel teams though, it's really odd to
see Lenovo use an INT-based HID. Should really use 104C2563 or something.


>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops tas2563_hda_pm_ops = {
>>>>> +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
>>>>
>>>> where's the pm_runtime stuff?
>>>>
>>>
>>> The amp stores its state in software shutdown mode.
>>> The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
>>> pm_runtime.
>>
>> My point was that you have all these pm_runtime_ calls in the code, but
>> nothing that provides pm_runtime suspend-resume functions so not sure
>> what exactly the result is?
>>
>>
> I think nothing. I haven't experienced anything unusual recently.

you can probably see from the /sys directory what the pm_runtime power
state is, most likely the status is 'unknown'.
