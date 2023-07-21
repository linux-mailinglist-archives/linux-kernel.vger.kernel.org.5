Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD875C50B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGUKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:53:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 969FB1719;
        Fri, 21 Jul 2023 03:53:36 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4800892009C; Fri, 21 Jul 2023 12:53:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 418B292009B;
        Fri, 21 Jul 2023 11:53:34 +0100 (BST)
Date:   Fri, 21 Jul 2023 11:53:34 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huacai Chen <chenhuacai@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Fix build issues from the introduction of
 `need-compiler'
In-Reply-To: <CAAhV-H7K2qM35GuGV+B2p=N_f30i98KazvwVNCuvvG9fYfrghw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2307211149070.17594@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk> <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com> <alpine.DEB.2.21.2307191621450.58367@angie.orcam.me.uk>
 <CAAhV-H7K2qM35GuGV+B2p=N_f30i98KazvwVNCuvvG9fYfrghw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

> >  Secondly:
> >
> > cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
> > cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
> >
> > document compiler peculiarities.  Does Clang support, or intend to,
> > `-march=loongson3a'?  If so, what version can we expect this stuff in?
> > GCC has had it since 4.6 or Y2010, which is pretty long ago.
> GCC support loongson3a/mips64r2, Clang only support mips64r2. If we use
> $(call cc-option,-march=loongson3a,-march=mips64r2)
> both GCC and Clang can work and we don't need to care about the compiler.

 This may well be a change we desire, but it has to be made and reviewed 
on its own rather than being buried within a set of unrelated changes.  
Then the rationale has to be given in the change description and a comment 
put in code explaining that it's not the usual case of old/new compiler, 
so that we can catch it later and remove should Clang developers decide to 
include `-march=loongson3a' support and our version requirements catch up.

  Maciej
