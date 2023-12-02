Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD2801B85
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjLBIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:32:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7919F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:33:03 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r9LQo-0005Sa-VN; Sat, 02 Dec 2023 09:32:59 +0100
Message-ID: <b228d624-41b3-417c-b25d-aa9c3818b500@leemhuis.info>
Date:   Sat, 2 Dec 2023 09:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [GIT PULL] firewire fixes for v6.7-rc4
Content-Language: en-US, de-DE
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231202080648.GA34377@workstation.local>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <20231202080648.GA34377@workstation.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701505983;f1bd96c3;
X-HE-SMSGID: 1r9LQo-0005Sa-VN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.23 09:06, Takashi Sakamoto wrote:
> 
> As I noted in pull request for v6.7[1], Linux FireWire subsystem still
> has an issue of unexpected system reboot in AMD Ryzen machine with a
> kind of PCI card. Recently I got a help of AMD developer[2] and got some
> advices to investigate the mechanism of system reboot, but never catch
> its tail yet... I wish to fix it within the development period for v6.8
> kernel.
>
> 
> [1] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
> [2] https://lore.kernel.org/lkml/20231128052429.GA25379@workstation.local/

Thx for your efforts on this, much appreciated. It seems more than just
one or two users are hitting this crash and a fix despite all your
tremendous efforts it not yet in sight. Hence please allow me to ask:
would it cause a significant regression for users of 6.5 and later, if
we'd temporarily revert the culprit and anything depending on it until
this is solved? Because if not I wonder if we should go down that route,
even if it's a drastic measure; but then Greg could fix this in soon in
6.6.y as well.

Ciao, Thorsten
