Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4704759A59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGSQAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGSP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:59:58 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217210E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:59:56 -0700 (PDT)
Message-ID: <5cd0d41b-8307-9db3-fb4f-037b181a390d@linux.intel.com>
Date:   Wed, 19 Jul 2023 17:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: SOF: Intel: Remove deferred probe for SOF
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2307181922160.3532114@eliteleevi.tm.intel.com>
 <874jm0modf.wl-tiwai@suse.de>
 <66d22637-069f-5262-2249-6041ef9d4614@linux.intel.com>
 <875y6g5feo.wl-tiwai@suse.de>
 <2ed288d0-c8fe-1856-dbe9-74f4f7c075ba@linux.intel.com>
 <04ed7ed8-8a8d-427a-84e1-a326feee5547@sirena.org.uk>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <04ed7ed8-8a8d-427a-84e1-a326feee5547@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-19 14:39, Mark Brown wrote:
> On Wed, Jul 19, 2023 at 02:13:59PM +0200, Maarten Lankhorst wrote:
>>
>> On 2023-07-19 13:06, Takashi Iwai wrote:
>>> On Wed, 19 Jul 2023 11:48:06 +0200,
>>> Maarten Lankhorst wrote:
>>>>
>>>>       The 60 seconds timeout is a thing "better than complete disablement",
>>>>       so it's not ideal, either.  Maybe we can add something like the
>>>>       following:
>>>>       - Check when the deferred probe takes too long, and warn it
>>>>       - Provide some runtime option to disable the component binding, so
>>>>         that user can work around it if needed
>>>> A module option to snd_hdac_i915_init would probably be the least of all evils
>>>> here.
>>>
>>> Yes, probably it's the easiest option and sufficient.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>> Hey,
>>
>> Patch below, can be applied immediately iresspective of the other patches.
>>
>> ---->8----------
>>
>> Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
>> video_firmware_drivers_only(). This can be used as a first approximation
>> on whether i915 will be available. It's safe to use as this is only built
> 
> Please don't bury new patches in the middle of mails, it just makes it
> hard to apply the patch since tooling doesn't understand what's going
> on.
> 
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.
I will send a new version in a bit, with all comments addressed.

I need to finish testing first.

~Maarten
