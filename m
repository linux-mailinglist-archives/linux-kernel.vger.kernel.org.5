Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C37F2D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjKUMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKUMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:24:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31464192;
        Tue, 21 Nov 2023 04:24:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5PnQ-0002fg-83; Tue, 21 Nov 2023 13:24:04 +0100
Message-ID: <a3ddbd03-7a94-4b6a-9be1-b268ce883551@leemhuis.info>
Date:   Tue, 21 Nov 2023 13:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Content-Language: en-US, de-DE
To:     John Garry <john.g.garry@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700569448;81e4f0a3;
X-HE-SMSGID: 1r5PnQ-0002fg-83
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.23 12:30, John Garry wrote:
> On 21/11/2023 09:50, Thorsten Leemhuis wrote:
>> Quite a few machines with Adaptec controllers seems to hang for a few
>> tens of seconds to a few minutes before things start to work normally
>> again for a while:
>> https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=217599__;!!ACWV5N9M2RV99hQ!L26RD0hu99l3f709EFnXU_V7OaB1jG4Hi7BjKvxRuhDWKFmjrgfksLuXA6eBrBCRtOT8JcRRUvzRsHbyEm41r7tL_pbDfw$ 
>> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
>> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
>> commit despite a warning of mine to Sasha recently made it into 6.1.53
>> -- and that way apparently recently reached more users recently, as
>> quite a few joined that ticket.
> 
> Is there a full kernel log for this hanging system?
> 
> I can only see snippets in the ticket.
> 
> And what does /sys/class/scsi_host/host*/nr_hw_queues show?

Sorry, I'm just the man-in-the-middle: you need to ask in the ticket, as
 the privacy policy for bugzilla.kernel.org does not allow to CC the
reporters from the ticket here without their consent.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.



