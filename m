Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD98781DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjHTNXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHTNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:23:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D018E;
        Sun, 20 Aug 2023 06:22:48 -0700 (PDT)
Received: from p200300cf17418700333267be2b9ea1d1.dip0.t-ipconnect.de ([2003:cf:1741:8700:3332:67be:2b9e:a1d1]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qXiOD-0008Pc-U1; Sun, 20 Aug 2023 15:22:45 +0200
Message-ID: <48b80ab9-560d-3a8c-bfa8-b2983ca591fa@leemhuis.info>
Date:   Sun, 20 Aug 2023 15:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: System becomes hot when put to sleep
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shubhra Prakash Nandi <email2shubhra@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux GPIO <linux-gpio@vger.kernel.org>
References: <430ca35e-70a1-e2b0-34e4-2586bebccd44@gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <430ca35e-70a1-e2b0-34e4-2586bebccd44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1692537768;ac97949c;
X-HE-SMSGID: 1qXiOD-0008Pc-U1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 16:13, Bagas Sanjaya wrote:

> I notice a regression report on Bugzilla [1]. Quoting from it:
>> I have a Dell Inspiron 14 5425 laptop with hardware specified below. Up till kernel version 6.1.39 the system can sleep and resume correctly but with kernel version 6.1.40 it heats up when put to sleep and drains battery very quickly. It seems CPU cannot suspend though the system can resume correctly and functions correctly after that. I believe many GPIO and pinctrl patches/fixes for the AMD platform beginning 6.1.40 and 6.4.5 has caused this issue. There is no error in logs and sleep/resume log messages in both 6.1.39 and 6.1.40 are the same. Only s2idle sleep mode is available on my system.
> [...] 

TWIMC, Mario is working on it and proposed a fix:

#regzbot introduced: 65f6c7c91cb2
#regzbot monitor:
https://lore.kernel.org/all/20230818144850.1439-1-mario.limonciello@amd.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
