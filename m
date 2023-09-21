Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1D7A9D93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIUTlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIUTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:41:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04819E;
        Thu, 21 Sep 2023 12:41:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qjFlH-0004qZ-T2; Thu, 21 Sep 2023 11:14:15 +0200
Message-ID: <e583d026-9401-482d-8f3d-025a952c32c4@leemhuis.info>
Date:   Thu, 21 Sep 2023 11:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hwmon: (nct6775) Regression Bisected
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Doug Smythies <dsmythies@telus.net>,
        'Ahmad Khalifa' <ahmad@khalifa.ws>,
        'Guenter Roeck' <linux@roeck-us.net>
Cc:     'Jean Delvare' <jdelvare@suse.com>,
        Linux Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <002101d9e7e0$f67c4490$e374cdb0$@telus.net>
 <ZQVzdlHgWdFhOVyQ@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZQVzdlHgWdFhOVyQ@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695325276;4635f031;
X-HE-SMSGID: 1qjFlH-0004qZ-T2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 16.09.23 11:20, Bagas Sanjaya wrote:
> On Fri, Sep 15, 2023 at 07:28:57AM -0700, Doug Smythies wrote:
>> Kernel 6.6-rc1 has an error during boot. The guilty commit is:
>> b7f1f7b2523a6a4382f12fe953380b847b80e09d
>> hwmon: (nct6775) Additional TEMP registers for nct6799
> [...]
> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: b7f1f7b2523a6a
> #regzbot title: shift out-of-bounds in nct6799's additional TEMP registers

Fix doesn't use a link regzbot is able to handle, thus point to it manually:

#regzbot fix: hwmon: (nct6775) Fix non-existent ALARM warning
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


