Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679517D90B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjJ0IIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjJ0IIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:08:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C31AA;
        Fri, 27 Oct 2023 01:08:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qwHt8-0004YH-EQ; Fri, 27 Oct 2023 10:08:14 +0200
Message-ID: <01c00d16-1441-4ef7-bf28-795b84d9de24@leemhuis.info>
Date:   Fri, 27 Oct 2023 10:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: bbbf096ea227607cbb348155eeda7af71af1a35b results in "dirty"
 shutdown
Content-Language: en-US, de-DE
To:     Damien Le Moal <dlemoal@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Totallyreal Name <kotversuchung@gmail.com>,
        loqs <kernel_bugzilla@entropy-collector.net>
References: <cd397c88-bf53-4768-9ab8-9d107df9e613@gmail.com>
 <a704bb1e-4be0-46f8-8118-a18b0547375f@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <a704bb1e-4be0-46f8-8118-a18b0547375f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698394097;e78bf8e2;
X-HE-SMSGID: 1qwHt8-0004YH-EQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.23 09:41, Damien Le Moal wrote:
> On 10/25/23 09:40, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla that seems to have been
>> handled already there [1]. Quoting from it:
> [...]
>>> [1]: https://bugs.archlinux.org/task/80064
>>> [2]: https://bugs.archlinux.org/task/80064#comment223100
>>> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bbbf096ea227607cbb348155eeda7af71af1a35b
>>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa3998dbeb3abce63653b7f6d4542e7dcd022590
>>
>> See Bugzilla for the full thread.
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot introduced: aa3998dbeb3abc https://bugzilla.kernel.org/show_bug.cgi?id=218038
>> #regzbot title: dirty shutdown due to disabling manage_system_start_stop on SCSI devices
>> #regzbot link: https://bugs.archlinux.org/task/80064

Damien, many thx for handling this regression so quickly.

FWIW, a quick remark, as it might save you (and others seeing this) some
work in the future:

> #regzbot fixed-by: 24eca2dce0f8d19db808c972b0281298d0bafe99

Telling regzbot about this is nice, but not really needed[1], as your
fix afaics contains links to the reports that are tracked by regzbot.
Hence regzbot would have noticed the fix automatically once it lands in
next or mainline[2], just like it noticed and tracked the patches you
posted for review earlier.

Ciao, Thorsten

[1] it just makes it a little more obvious that a fix is now incoming

[2] there is a bug there somewhere that make it fail sometimes, but I'll
sooner or later catch it
