Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E666781DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHTNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHTNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:49:05 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14A2F120
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:44:47 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 30D4592009C; Sun, 20 Aug 2023 15:44:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 232A792009B;
        Sun, 20 Aug 2023 14:44:45 +0100 (BST)
Date:   Sun, 20 Aug 2023 14:44:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.5-rc7
In-Reply-To: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2308201427460.49340@angie.orcam.me.uk>
References: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> So I think this will be the last rc unless something nasty comes up.

 Can we please make sure this goes in before the final release so that we 
don't have a broken ABI out there in a released version (the signal frame 
may have to adjusted too, as the vector state struct seems messy to me as 
a part of UAPI, so there may be more to revert; I haven't looked through 
this stuff in detail as I only found the issues here in a GDB review): 
<https://lore.kernel.org/r/20230810214810.21905-1-palmer@rivosinc.com/>?

  Maciej
