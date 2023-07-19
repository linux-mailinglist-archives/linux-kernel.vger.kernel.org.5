Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDB759711
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGSNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGSNfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:35:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C0D113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773752; x=1721309752;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wfPSbk3KPqoC/jBdA7CzlHdvMnbUfG0A2+TB1XSaqrw=;
  b=ebcNPHwM3guXcW9Ttxw8qH0Ny8ucoyZHrZSCalWp0733BXYZMOblpkDq
   BozoGMUEg++UbS0kexO8ltYzns/lQtQ5HAwLd7bzuFTGqoKWo/t/bHW+6
   CZ4DXAOG9+157D3OktbI/XMoMozmRQmq4WwB6cQ2/VybO14FqbqZWTYum
   CPz8IS1ABeH1SbBZkq7q2tqik4ddb580VQmT4doRrSUoB3EFIXk0swpco
   XXO/vOuaAnxYZI14iuaGkIN5fqXdkHzglQTfth8VEOBSSq0J0untTJezH
   m+MRWpA59tQFdIntj6j+Q9L+RVEmuQjybuSAu4GeqgWNcJsyq0Up0bEtN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397324606"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397324606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674297037"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674297037"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:35:48 -0700
Date:   Wed, 19 Jul 2023 16:32:28 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH 6/7] ASoC: SOF: Intel: Remove deferred probe for SOF
In-Reply-To: <66d22637-069f-5262-2249-6041ef9d4614@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2307191613460.3532114@eliteleevi.tm.intel.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com> <20230718084522.116952-7-maarten.lankhorst@linux.intel.com> <alpine.DEB.2.22.394.2307181922160.3532114@eliteleevi.tm.intel.com> <874jm0modf.wl-tiwai@suse.de>
 <66d22637-069f-5262-2249-6041ef9d4614@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-318106570-2122726055-1689773555=:3532114"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---318106570-2122726055-1689773555=:3532114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 19 Jul 2023, Maarten Lankhorst wrote:

> On Tue, 18 Jul 2023 19:04:41 +0200, Kai Vehmanen wrote:
>> My only bigger concern is corner cases where the display PCI device is 
on 
>> the bus and visible to kernel, but for some reason there is no working 
>> driver in the system or it is disabled.
> 
> Yeah, I have no answer for this. My guess is that in an ideal world, the optional features
> related to HDMI outputs would be put in a separate sub-driver, which could -EPROBE_DEFER.
> Only when this driver loads, features related to display will work, but the main audio driver
> could still load.

in longer term, we have ongoing work in SOF to allow exposing multiple 
cards (e.g. to have a separate card for HDMI/DP PCM devices), and we
are continuously working at improving the data we get from ACPI to 
have less guesswork in the driver. But this really doesn't help in the 
shortterm and/or cover all scenarios.

So for now, this is legacy we just need to deal with. OTOH, I do agree
that...

> A module option to snd_hdac_i915_init would probably be the least of all evils here.
> 
> I see the removal of the 60 second timeout as a good thing regardless. :-) Usually when nomodeset is used, it's just for safe
> mode.
> 
> With the addition of  the xe driver, blindly modprobing i915 will fall apart regardless.

The modprobing of i915 from the audio driver, has always felt a bit 
out-of-place, and with the xe driver, this simply won't scale anymore.

The test results so far look good and this patchset works ok even if some 
of the more complex multi-GPU configurations we have, so I think with a 
module option to snd_hdac_i915, I'd be ready to go with this.

Br, Kai
---318106570-2122726055-1689773555=:3532114--
