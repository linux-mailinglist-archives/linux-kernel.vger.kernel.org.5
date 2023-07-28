Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8C766951
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjG1Ju3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjG1JuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:50:16 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 847CE3A8D;
        Fri, 28 Jul 2023 02:50:06 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qPK6l-0004gc-00; Fri, 28 Jul 2023 11:50:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A9BD1C01C1; Fri, 28 Jul 2023 11:48:26 +0200 (CEST)
Date:   Fri, 28 Jul 2023 11:48:26 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fixup explicit DT include clean-up
Message-ID: <ZMOO6hsbRAQCOORg@alpha.franken.de>
References: <20230727012028.3933785-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727012028.3933785-1-robh@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:20:28PM -0600, Rob Herring wrote:
> Commit 657c45b303f87d77 ("MIPS: Explicitly include correct DT includes")
> removed a necessary include by mistake and missed adding an explicit
> include of spinlock.h (from of.h -> kobject.h -> spinlock.h).
> 
> Fixes: 657c45b303f87d77 ("MIPS: Explicitly include correct DT includes")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/mips/lantiq/xway/gptu.c       | 1 +
>  arch/mips/pic32/pic32mzda/config.c | 1 +
>  2 files changed, 2 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
