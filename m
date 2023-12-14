Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CEF812FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572992AbjLNMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572999AbjLNMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:23:07 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB511D;
        Thu, 14 Dec 2023 04:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702556592;
        bh=UqRmqpx+L/h6JxrFWmQqgif5spnY/NSTCUX559UgFhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e+0gVLmalAyHuyZtnP0qlxXRf/NQhDOPFN/UwXwWPN0Fqti/gfhfB7dDIYTMDjvmE
         KLaAXHgoVSxF7xPxYSXKPHnJWKlzsjvlY/kPL+8pMriafEK4h7fh8BTcSiy5ZeXOhS
         LhF9x7BHnjj9b6WQ+O1GRXkrn5SX4h3IglgGAG4MVAyGanlkgewW7o1qN4P2l6gcgc
         iAxhRwfRP7bZXWQh7Q9TcoGtvEnlm15r0ietUg/q9r9A/kZrUn/zny/ZPeANzzT+di
         gMf9k9Wn+iX+MNO1cmyvVY54NJRPfIc40w4Lr43HlIemROULINW9YRViISn3Vu0i9Y
         xpIRCbCW4wNkw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1CD6837814A8;
        Thu, 14 Dec 2023 12:23:11 +0000 (UTC)
Message-ID: <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
Date:   Thu, 14 Dec 2023 14:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
 <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
 <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
 <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
 <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 07:58, Venkata Prasad Potturu wrote:
> 
> On 12/10/23 21:20, Cristian Ciocaltea wrote:
>> On 12/10/23 16:01, Mark Brown wrote:
>>> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>>>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>>>> This should send to SOF git repo for rewiew, once SOF reviewers
>>>>> approved
>>>>> this, again need to send to broonie git.
>>>>> All the changes in sound/soc/sof/ path should go to SOF git.
>>>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>>>> enough to have this patch cc-ed to
>>>> sound-open-firmware@alsa-project.org?
>>> The SOF people basically do their own thing in github at
>>>
>>>     https://github.com/thesofproject/linux
>>>
>>> with a github workflow and submit their patches upstream in batches a
>>> few times a release, however my understanding is that their workflow can
>>> cope with things going in directly upstream as well.
>> Thanks for clarifying, Mark!  That would greatly simplify and speedup
>> the whole process, at least for trivial patches like this one.
> 
> Hi Cristian,
> 
> We have created a Pull request in SOF git hub for I2S BT support.
> please hold v2 version SOF patches till below PR get's merged.
> PR:- https://github.com/thesofproject/linux/pull/4742

Hi Venkata,

If this is going to be handled via the github workflow, this patch
should be removed from the series.  Since there is no dependency on it,
I cannot see a reason to put v2 on hold.

Do I miss something?

Thanks,
Cristian
