Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F17F3287
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjKUPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjKUPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:41:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0C99;
        Tue, 21 Nov 2023 07:41:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5SsI-0003vD-Qs; Tue, 21 Nov 2023 16:41:18 +0100
Message-ID: <0a594a11-d345-48c3-a651-08ea80ab76a1@leemhuis.info>
Date:   Tue, 21 Nov 2023 16:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: inet6_sock_destruct->inet_sock_destruct trigger Call Trace
Content-Language: en-US, de-DE
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Linux Networking <netdev@vger.kernel.org>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <8bfaee54-3117-65d3-d723-6408edf93961@gmail.com>
 <c3a5d08e-9c7c-4888-916a-ba4bd22a3319@collabora.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c3a5d08e-9c7c-4888-916a-ba4bd22a3319@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700581283;bc6798bc;
X-HE-SMSGID: 1r5SsI-0003vD-Qs
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 15:07, Muhammad Usama Anjum wrote:
> On 6/16/23 5:43 PM, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> [...]
>>> When the IPv6 address or NIC configuration changes, the following kernel warnings may be triggered:
> [...]
>>> Thu Jun 15 09:02:31 2023 daemon.info : 09[KNL] interface utun deleted
> [...]
>> #regzbot introduced: v6.1.27..v6.1.32 https://bugzilla.kernel.org/show_bug.cgi?id=217555
>> #regzbot title: kernel warning (oops) at inet_sock_destruct
> The same warning has been seen on 4.14, 5.15, 6.1 and latest mainline.
>
> This WARN_ON is present from 2008.

Hmmm, the commit that according to syzkaller's bisection caused this is
not in those series. So I assume the bisection went sideways.

And the reporter of the bugzilla ticket never bisected this either.
Wondering if it started to show up there due to small unrelated timing
changes.

Not totally sure, but it seems like this in the end is not a real
regression or one we can't do anything about. Thus removing this from
the tracking; if anyone disagrees, please holler.

#regzbot inconclusive: likely an older problem
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

