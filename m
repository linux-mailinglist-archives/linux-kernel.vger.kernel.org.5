Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786A805DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjLESBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjLESBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:01:39 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122D81BE;
        Tue,  5 Dec 2023 10:01:45 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1rAZjs-0003nS-00; Tue, 05 Dec 2023 19:01:44 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6B96BC0A7C; Tue,  5 Dec 2023 18:54:15 +0100 (CET)
Date:   Tue, 5 Dec 2023 18:54:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        stable@vger.kernel.org
Subject: Re: [PATCH fixes v2 0/3] MIPS: Loongson64: Fix some long-term issues
Message-ID: <ZW9jxxoJF0IHcYyl@alpha.franken.de>
References: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 11:15:17AM +0000, Jiaxun Yang wrote:
> Hi all,
> 
> This series fixes some long-term issues in kernel that preventing
> some machine from work properly.
> 
> Hopefully that will rescue some system in wild :-)
> 
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Typo and style fixes
> - Link to v1: https://lore.kernel.org/r/20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com
> 
> ---
> Jiaxun Yang (3):
>       MIPS: Loongson64: Reserve vgabios memory on boot
>       MIPS: Loongson64: Enable DMA noncoherent support
>       MIPS: Loongson64: Handle more memory types passed from firmware
> 
>  arch/mips/Kconfig                                  |  2 +
>  arch/mips/include/asm/mach-loongson64/boot_param.h |  9 ++++-
>  arch/mips/loongson64/env.c                         | 10 ++++-
>  arch/mips/loongson64/init.c                        | 47 ++++++++++++++--------
>  4 files changed, 49 insertions(+), 19 deletions(-)

series applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
