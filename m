Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3A7F4F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKVS3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjKVS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:29:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63F1AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:29:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DAC433C8;
        Wed, 22 Nov 2023 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700677742;
        bh=qsGh4PHkc0mg1b/d1tYd78id5VXrFh16WcGzldQw1Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CVd7/2dyvM4ZZaZhMypGSXAXmchB52w3uxIDBo/44hGyQ8Im+Ody44375XiPRro2r
         J0LMiq/WzPnBqBM+9D4McwJyaxL9AILUjVvlrvd3Su9GSFarF38MmnhI84MwZDHc1v
         2oV5dSPY8+X5KKODaMS6k8iqVAJLMdOL5OgXEAOI=
Date:   Wed, 22 Nov 2023 10:29:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] MIPS: mm: Fix some memory-related issues
Message-Id: <20231122102900.68216218f77b61e342f37627@linux-foundation.org>
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 21:23:58 +0300 Serge Semin <fancer.lancer@gmail.com> wrote:

> Just recently I've rebased my MIPS32-related work from kernel 6.5-rc4 onto
> the latest kernel 6.7-rc1 and immediately got into a bootup-time
> mm-related bug (see patches 3-5 in this series). After fixing it I decided
> it was time to submit for review the generic MIPS code fixes which I have
> been collecting in my local repo for the last year. I was going to submit
> them a bit later after I finished working on a patchset with my SoC
> arch-specific changes, but since it was getting bigger and bigger, it
> turned to be reasonable to spill out the generic part of series right away
> especially seeing it might get to be useful in the most recent kernel.

It would have been better to separate out the two tiny unrelated MM
patches from this series.  I'll steal them - if they later turn up via
the MIPS tree then that's OK.
