Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839977D2335
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJVNfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 09:35:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93CDC;
        Sun, 22 Oct 2023 06:35:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1quYbq-00057E-Ui; Sun, 22 Oct 2023 15:35:15 +0200
Message-ID: <fd1edea6-5512-48fb-a5d1-e25ebdc56904@leemhuis.info>
Date:   Sun, 22 Oct 2023 15:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230904133321.104584-1-git@andred.net>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230904133321.104584-1-git@andred.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697981717;d68ef9f0;
X-HE-SMSGID: 1quYbq-00057E-Ui
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.09.23 15:33, André Draszik wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> 
> This patch breaks all existing userspace by requiring updates as
> mentioned in the commit message, which is not allowed.
> 
> Revert to restore compatibility with existing userspace
> implementations.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 3066ff93476c35679cb07a97cce37d9bb07632
#regzbot title fuse: creating new files, or reading existing files in i
Android, now returns -EFAULT
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

