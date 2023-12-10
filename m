Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9B80BC10
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjLJPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:50:02 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09FB4;
        Sun, 10 Dec 2023 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702223406;
        bh=VGe9TdQ/vud/OfN67E3dqBDKZmGPAhkf1qflgqRvIos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UNpdqagg0CxJdPA7a1TACKFRVtJ0lMgkrjkyEPXRoSMH0rZxNCxWE7OW4AswJGp36
         aU3FmVAMORs3cY+OGG/KrivzAZ8+8TOb+CD5JeaydY17nG9LIBfGBZBUYMri3R/fxm
         /ML5Glcelo5SsqXw23LVFOwy37lB9utJJOVGdGNOjpT8BFppWwJxUkLuJZeZobyraA
         unn8EBL+9CpZcXHvQet6VmbecGAH3z2cZpl1IwEdKUZ6VdUVaInnQDL83rkCe7oA+y
         Cx9xc+C4A8CGImdDkTtqJkxcqEn2x6k8+HROy53STcfp+pz65pU8mB7RC5TCoedj49
         sHfhRL7KWvwWg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3281337813EF;
        Sun, 10 Dec 2023 15:50:05 +0000 (UTC)
Message-ID: <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
Date:   Sun, 10 Dec 2023 17:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 16:01, Mark Brown wrote:
> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
> 
>>> This should send to SOF git repo for rewiew, once SOF reviewers approved
>>> this, again need to send to broonie git.
>>> All the changes in sound/soc/sof/ path should go to SOF git.
> 
>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>> enough to have this patch cc-ed to sound-open-firmware@alsa-project.org?
> 
> The SOF people basically do their own thing in github at
> 
>    https://github.com/thesofproject/linux
> 
> with a github workflow and submit their patches upstream in batches a
> few times a release, however my understanding is that their workflow can
> cope with things going in directly upstream as well.

Thanks for clarifying, Mark!  That would greatly simplify and speedup
the whole process, at least for trivial patches like this one.
