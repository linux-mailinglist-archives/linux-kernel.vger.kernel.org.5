Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC87761032
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjGYKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjGYKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:04:59 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8F1FC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:04:25 -0700 (PDT)
Message-ID: <bf495f63-0dcb-e680-4b74-0c4d1ff3463e@linux.intel.com>
Date:   Tue, 25 Jul 2023 12:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/9] ALSA: hda/i915: Allow xe as match for
 i915_component_master_match
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
 <518bb7a9-3a85-2c13-68bf-63baaff176ef@linux.intel.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <518bb7a9-3a85-2c13-68bf-63baaff176ef@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-24 12:28, Pierre-Louis Bossart wrote:
> 
> 
> On 7/19/23 18:41, Maarten Lankhorst wrote:
>> xe is a new driver for intel GPU's that shares the sound related code
>> with i915.
>>
>> Don't allow it to be modprobed though; the module is not upstream yet
>> and we should exclusively use the EPROBE_DEFER mechanism.
> 
> I can't figure out what this comment means.
> 
> how would the -EPROBE_DEFER mechanism help if the driver that will
> trigger a new probe is not upstream?
> 
> Not following at all what you intended to explain.

What I mean is that there is code inside the current code that does 
request_module("i915"), the comment meant I didn't try to add any logic 
for request_module("xe"), as the driver is not merged yet.

Additionally I am removing the request_module logic, but this comment 
was written when I first tried the simple solution of request_module("xe").

Turns out telepathy is hard, and using -EPROBE_DEFER is much simpler. :-)

Cheers,
~Maarten
