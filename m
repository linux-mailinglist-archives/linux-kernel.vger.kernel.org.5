Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB277766952
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjG1Juc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjG1JuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:50:17 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F42042736;
        Fri, 28 Jul 2023 02:50:06 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qPK6l-0004gi-00; Fri, 28 Jul 2023 11:50:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8FBA5C01E6; Fri, 28 Jul 2023 11:49:50 +0200 (CEST)
Date:   Fri, 28 Jul 2023 11:49:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, philmd@linaro.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] MIPS: Loongson64: Fix more __iomem attributes
Message-ID: <ZMOPPjLkQ4Bu4lpd@alpha.franken.de>
References: <20230725060144.1501195-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725060144.1501195-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:01:44PM +0800, Jiaxun Yang wrote:
> There are some __iomem type casting being missed in previous patch.
> Fix them here.
> 
> Fixes: 5bd3990723bd ("MIPS: Loongson64: Prefix ipi register address pointers with __iomem")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-lkp@intel.com/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop invalid attribute for play_dead pointers
> ---
>  arch/mips/loongson64/smp.c | 160 ++++++++++++++++++-------------------
>  1 file changed, 80 insertions(+), 80 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
