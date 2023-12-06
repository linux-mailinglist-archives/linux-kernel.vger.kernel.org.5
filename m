Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4338806F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377858AbjLFLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjLFLyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:54:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB81986;
        Wed,  6 Dec 2023 03:54:17 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAqTn-0000PU-8z; Wed, 06 Dec 2023 12:54:15 +0100
Message-ID: <cb450c07-2df2-45a7-a77a-25ce2a0a18bc@leemhuis.info>
Date:   Wed, 6 Dec 2023 12:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Content-Language: en-US, de-DE
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-3-helgaas@kernel.org>
 <20231012153347.GA26695@polanet.pl>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20231012153347.GA26695@polanet.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701863657;e3b9cb1e;
X-HE-SMSGID: 1rAqTn-0000PU-8z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 12.10.23 17:33, Tomasz Pala wrote:
> Hello,
> 
> On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:
> 
>> Normally we reject ECAM space unless it is reported as reserved in the E820
>> table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
>> means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> 
> I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.

#regzbot fix: x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02
_CRS
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
