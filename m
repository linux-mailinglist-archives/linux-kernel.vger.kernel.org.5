Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CB77A08E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHLOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHLOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:48:35 -0400
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Aug 2023 07:48:37 PDT
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989E1B5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:48:37 -0700 (PDT)
Message-ID: <b50a04c9-23d2-83d5-37fa-642c85e3d32d@lankhorst.se>
Date:   Sat, 12 Aug 2023 16:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/9] ALSA: hda/i915: Add an allow_modprobe argument to
 snd_hdac_i915_init
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
 <20230807090045.198993-4-maarten.lankhorst@linux.intel.com>
 <451ab8a3-7c75-4aab-0b8b-554d9c44c34c@linux.intel.com>
 <877cq0r7qz.wl-tiwai@suse.de>
Content-Language: en-US
From:   Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <877cq0r7qz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-08-12 10:21, Takashi Iwai wrote:
> On Mon, 07 Aug 2023 16:08:32 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 8/7/23 04:00, Maarten Lankhorst wrote:
>>> Xe is a new GPU driver that re-uses the display (and sound) code from
>>> i915. It's no longer possible to load i915, as the GPU can be driven
>>> by the xe driver instead.
>>>
>>> The new behavior will return -EPROBE_DEFER, and wait for a compatible
>>> driver to be loaded instead of modprobing i915.
>>>
>>> Converting all drivers at the same time is a lot of work, instead we
>>> will convert each user one by one.
>>>
>>> Changes since v1:
>>> - Use dev_err_probe to set a probe reason for debugfs' deferred_devices.
>>
>> You want the changes below the --- line ...
> 
> Note that there are subsystems preferring keeping the version change
> logs in the commit log (typically found in drm trees), although
> majority of subsystems (including sound) want rather cleaner logs,
> AFAIK.
Yeah, I usually maintain stuff in drm. :)

Cheers,
~Maarten
