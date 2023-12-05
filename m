Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49165805B92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjLEQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjLEQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:12:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3E109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792745; x=1733328745;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=wDtj9DdSJ7Y93+n4xPNycXhG5HoyUMQZ1DvGBkUKDxM=;
  b=QoAB0n3Tf/F6oP9TiDJSHof1WLkOoFWhY1Dh8BXGBZc7WFvpAXdT+WPn
   JXZbhB/vapwXS4xkQ3O3snJ8DDRz2XzlHW9/f2cpuY+Lnqh62c9HzKv8u
   H5/Z2RzFwlQCpQwaeOGQolsjmwuRRYTjPJwZWsBZ8Y2AfMVYzmcnG+19U
   aFIvNw4LrBGIAiCSseNlPXOpKKt01nps95FytKHjCFl590AG0bmveCDZ7
   DUb408sqXCNaJSOXK2MUPjNNyauZmb5CDN3IF1HJFDPmXRAFo/GJnHrpT
   GJ6WR5NCFH1aDGA9+UlIITYaXxJHBldQ2622iUlir7qF2F7Uio+QKNIek
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392781044"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392781044"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747290491"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="747290491"
Received: from mbapna-mobl1.amr.corp.intel.com (HELO [10.212.151.198]) ([10.212.151.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:12:24 -0800
Message-ID: <fc19ccbe-2e06-42f5-b968-446f8c08ec22@linux.intel.com>
Date:   Tue, 5 Dec 2023 10:12:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
In-Reply-To: <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +static const struct dev_pm_ops tas2563_hda_pm_ops = {
>>>> +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
>>>
>>> where's the pm_runtime stuff?
>>>
>>
>> The amp stores its state in software shutdown mode.
>> The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
>> pm_runtime.
> 
> My point was that you have all these pm_runtime_ calls in the code, but
> nothing that provides pm_runtime suspend-resume functions so not sure
> what exactly the result is?

if the inspiration was the tas2781, then see below it does have a
RUNTIME_PM_OPS line as well as runtime_suspend/resume routines.

static const struct dev_pm_ops tas2781_hda_pm_ops = {
	RUNTIME_PM_OPS(tas2781_runtime_suspend, tas2781_runtime_resume, NULL)
	SYSTEM_SLEEP_PM_OPS(tas2781_system_suspend, tas2781_system_resume)
};

