Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC337DE00B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjKALDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKALDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:03:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649A28F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:03:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qy90N-00073n-Qa; Wed, 01 Nov 2023 12:03:23 +0100
Message-ID: <7a9a1b2f-a3df-4806-a7b3-992f974c2d06@leemhuis.info>
Date:   Wed, 1 Nov 2023 12:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression with 33140e668b10 thermal/drivers/mediatek: Control
 buffer enablement tweaks
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
 <ZPBjGWPjSfl-HmDJ@debian.me>
 <e264149e-c053-4346-a645-e694ed791569@leemhuis.info>
In-Reply-To: <e264149e-c053-4346-a645-e694ed791569@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698836605;f59ee8f4;
X-HE-SMSGID: 1qy90N-00073n-Qa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 12.09.23 14:23, Linux regression tracking #update (Thorsten Leemhuis)
wrote:
> 
> On 31.08.23 11:53, Bagas Sanjaya wrote:
>> On Thu, Aug 31, 2023 at 11:25:11AM +0200, Frank Wunderlich wrote:
>>>
>>> The commit 33140e668b10 "thermal/drivers/mediatek: Control buffer enablement tweaks" is merged between 6.3 and 6.4 and causes a regression where temperature cannot be read correctly at least for mt7986/Bpi-R3.
>>>
>>> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
>>> -274000
>>>
>>> after reverting the commit and fixing some build-errors in 6.5-rc7 because new members used in mt8365_thermal_data too, we can read temperature on mt7986 again.
>>>
>>
>> Thanks for the regression report. I'm adding it to regzbot:
>>
>> #regzbot ^introduced: 33140e668b1020
>> #regzbot title: incorrect temperature on MT7986 due to tweaking buffer
> 
> 
> #regzbot monitor:
> https://lore.kernel.org/all/20230907112018.52811-1-linux@fw-web.de/
> #regzbot fix: thermal/drivers/mediatek: Fix control buffer enablement on
> MT7896
> #regzbot ignore-activity

patch title changed, hence:

#regzbot fix: 5055fadfa7e16f242
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
