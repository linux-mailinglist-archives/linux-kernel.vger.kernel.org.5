Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCE978BEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjH2HEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjH2HEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:04:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F8DF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:04:27 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 51E66809C;
        Tue, 29 Aug 2023 15:04:24 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 15:04:24 +0800
Received: from [192.168.125.128] (113.72.145.245) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 15:04:23 +0800
Message-ID: <599bfee8-1928-0d4f-6d88-5d1996b2a450@starfivetech.com>
Date:   Tue, 29 Aug 2023 14:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] ASoC: dwc: Fix the warnnings about JH7110 ops
To:     Takashi Iwai <tiwai@suse.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20230829033658.225713-1-xingyu.wu@starfivetech.com>
 <877cpewdvh.wl-tiwai@suse.de>
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <877cpewdvh.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.245]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/29 14:40, Takashi Iwai wrote:
> On Tue, 29 Aug 2023 05:36:58 +0200,
> Xingyu Wu wrote:
>> 
>> Add a check of CONFIG_OF before the JH7110 ops to fix the warnings
>> that the JH7110 ops are defined but not used when CONFIG_OF is disabled.
>> 
>> Fixes: 1a512d13837a ("Add I2S support for the StarFive JH7110 SoC")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202308250433.nhzrhYEo-lkp@intel.com/
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>> Hi Mark,
>> 
>> This patch fixes the issue about the warning of JH7110 ops when CONFIG_OF
>> is disabled. So add a check of CONFIG_OF before defining JH7110 ops.
>> 
>> Thanks,
>> Xingyu Wu
> 
> The very same fix went already in my sound.git tree, commit
> 8d2a0cdf5229.
> 
> 
> thanks,
> 
> Takashi

Great, please ignore this patch.

Thanks,
Xingyu Wu
