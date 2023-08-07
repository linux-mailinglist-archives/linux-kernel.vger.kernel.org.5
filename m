Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA527731BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHGV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHGV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:58:29 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79D738F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:58:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 208879200C1; Mon,  7 Aug 2023 23:58:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 197439200BF;
        Mon,  7 Aug 2023 22:58:27 +0100 (BST)
Date:   Mon, 7 Aug 2023 22:58:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Borislav Petkov <bp@alien8.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function
 definition
In-Reply-To: <20230807211659.GKZNFfS+7PK71yYt0p@fat_crate.local>
Message-ID: <alpine.DEB.2.21.2308072249100.38537@angie.orcam.me.uk>
References: <20230725134837.1534228-1-arnd@kernel.org> <20230725134837.1534228-3-arnd@kernel.org> <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local> <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com> <20230802172030.GEZMqQXmeb98Tm+Qhg@fat_crate.local>
 <alpine.DEB.2.21.2308072124320.38537@angie.orcam.me.uk> <20230807211659.GKZNFfS+7PK71yYt0p@fat_crate.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023, Borislav Petkov wrote:

> On Mon, Aug 07, 2023 at 09:37:00PM +0100, Maciej W. Rozycki wrote:
> >  Otherwise you risk `__div64_32(n, base)' getting expanded to `(n, base)', 
> 
> You mean in the very obscure case of a 32-bit kernel where they don't call
> do_div() but call this low level function?
> 
> I'd say if they can't be bothered to even grep the tree for the right usage,
> they deserve both pieces... :)

 Well, people do make mistakes and life is tough enough already, so why 
make it tougher when we can have a free sanity check?  I mean there's 
hardly any cost from the extra characters added and it can save someone 
hassle with debugging, which is always tough by definition.

 I've suffered from silly mistakes myself on many occasions, possibly from
being distracted in the middle of doing something, and while I figured 
things out eventually, it often cost me a day of effort or so wasted in 
chasing them.

  Maciej
