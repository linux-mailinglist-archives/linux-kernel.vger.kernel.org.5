Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A27AD64E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjIYKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIYKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:45:04 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D9C3D3;
        Mon, 25 Sep 2023 03:44:56 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qkj5B-0003cX-00; Mon, 25 Sep 2023 12:44:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9FE43C013D; Mon, 25 Sep 2023 12:43:35 +0200 (CEST)
Date:   Mon, 25 Sep 2023 12:43:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     manuel.lauss@gmail.com, arnd@arndb.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: Alchemy: only build mmc support helpers if au1xmmc
 is enabled
Message-ID: <ZRFkVy3kBytSC5y8@alpha.franken.de>
References: <20230905070656.196274-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905070656.196274-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:56AM +0200, Christoph Hellwig wrote:
> While commit d4a5c59a955b ("mmc: au1xmmc: force non-modular build and
> remove symbol_get usage") to be built in, it can still build a kernel
> without MMC support and thuse no mmc_detect_change symbol at all.
> 
> Add ifdefs to build the mmc support code in the alchemy arch code
> conditional on mmc support.
> 
> Fixes: d4a5c59a955b ("mmc: au1xmmc: force non-modular build and remove symbol_get usage")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/alchemy/devboards/db1000.c | 4 ++++
>  arch/mips/alchemy/devboards/db1200.c | 6 ++++++
>  arch/mips/alchemy/devboards/db1300.c | 4 ++++
>  3 files changed, 14 insertions(+)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
