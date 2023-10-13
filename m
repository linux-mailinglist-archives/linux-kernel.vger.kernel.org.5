Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C347C876B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjJMOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:04:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CDBF;
        Fri, 13 Oct 2023 07:04:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrIlq-0008V6-Ec; Fri, 13 Oct 2023 16:04:06 +0200
Message-ID: <26447379-118c-451a-8ba4-6a9bc3a45ad2@leemhuis.info>
Date:   Fri, 13 Oct 2023 16:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Resume broken on T14s Gen1 (AMD) due to "Input:
 psmouse - add delay when deactivating for SMBus mode"
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697205848;8cb43c98;
X-HE-SMSGID: 1qrIlq-0008V6-Ec
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 27.09.23 10:54, Thorsten Leemhuis wrote:
> Hi Jeffery! Your change 92e24e0e57f72e ("Input: psmouse - add delay when
> deactivating for SMBus mode") [merged for v6.6-rc1] broke resume on my
> T14s Gen1 (AMD): the system didn't really resume again at all (the
> display almost always didn't re-initialize) and there was nothing in the
> logs. I found your commit to be the culprit using a bisection and
> confirmed that reverting it on top of Linux 6.6-rc3 makes thing work
> again for me.
> 
> #regzbot introduced 92e24e0e57f72e
> #regzbot title Input: psmouse - Resume broken on T14s Gen1 (AMD) due to
> a new delay when deactivating for SMBus mode

#regzbot monitor:
https://lore.kernel.org/all/20231004005729.3943515-1-jefferymiller@google.com/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
