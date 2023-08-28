Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54A78A8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjH1JTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjH1JS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:18:56 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB8EA109;
        Mon, 28 Aug 2023 02:18:53 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qaYOY-0004JR-00; Mon, 28 Aug 2023 11:18:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B0F28C0234; Mon, 28 Aug 2023 11:11:19 +0200 (CEST)
Date:   Mon, 28 Aug 2023 11:11:19 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
Message-ID: <ZOxkt/6EkQIy+Jkt@alpha.franken.de>
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 04:36:19PM +0800, Tiezhu Yang wrote:
> v4:
>   -- Add BUG() at the end of nmi_exception_handler()
>   -- Return earlier in die() if notify_die() returns NOTIFY_STOP
>   -- Update the patch titles and commit messages
> 
> v3:
>   -- Make each patch can be built without errors and warnings.
> 
> v2: 
>   -- Update the commit message to give more detailed info, split into
>      three individual patches, suggested by Maciej, thank you.
> 
> Tiezhu Yang (4):
>   MIPS: Add BUG() at the end of nmi_exception_handler()
>   MIPS: Do not kill the task in die() if notify_die() returns
>     NOTIFY_STOP
>   MIPS: Return earlier in die() if notify_die() returns NOTIFY_STOP
>   MIPS: Add identifier names to arguments of die() declaration
> 
>  arch/mips/include/asm/ptrace.h |  2 +-
>  arch/mips/kernel/traps.c       | 15 +++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
