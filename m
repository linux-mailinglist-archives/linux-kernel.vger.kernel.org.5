Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB577BB81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHNO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjHNO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:10 -0400
X-Greylist: delayed 171774 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 07:26:07 PDT
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F1B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:26:07 -0700 (PDT)
Message-ID: <e88d139f-e62b-1654-0d35-a46c698298c6@lankhorst.se>
Date:   Mon, 14 Aug 2023 16:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
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
 <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
 <4acc7318-69b3-3eb5-1fe8-f7deea8adfad@linux.intel.com>
 <87a5uwr7ya.wl-tiwai@suse.de>
From:   Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <87a5uwr7ya.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping on this?

On 2023-08-12 10:17, Takashi Iwai wrote:
> On Mon, 07 Aug 2023 16:26:53 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 8/7/23 04:00, Maarten Lankhorst wrote:
>>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>>> the snd_hdac_i915_init into a workqueue.
>>>
>>> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
>>> probe function.
>>
>> I don't think this patch is aligned with the previous discussions. What
>> we agreed on is that snd_hdac_i915_init() would be called from and not
>> from the workqueue.
>>
>> But this patch also moves all codec initialization out of the workqueue.
>>
>> I think we need two callbacks for device-specific initilization, one
>> that is called from the probe function and one from the workqueue,
>> otherwise we'll have a structure that differs from the snd-hda-intel -
>> which would be rather silly in terms of support/debug.
>>
>> I realize there's quite a bit of surgery involved, and most likely the
>> SOF folks should provide this patch for you to build on.
> 
> So this patch looks like the only significant concern in the whole
> patch set.  Can we reach to some agreement for merging to 6.6 in time?
> 
> 
> thanks,
> 
> Takashi
