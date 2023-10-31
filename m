Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D797B7DCF06
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbjJaOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjJaOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:25:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D35C9;
        Tue, 31 Oct 2023 07:25:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEE2C433C7;
        Tue, 31 Oct 2023 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698762324;
        bh=/FLcelGYtrBTfNx8PPBJWZONRxhJzfKi+twgk4nPIuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp/6dHcKYZ0n4QK0FTojm8V3SKXg3gFeNCljO9N1QZp2T8KhnwCK1cN4peHMb2rr3
         35Ct/m33agA1w1x/PsHl7axzpcSFFaybnublaZXdZ617P4J+f/FP2sA+JEqewHtTCM
         Hu2iBSvzK6PaYdwB5EWd3hRFviKejao8ltjEayqCpvLLxYjvfIxm/O137m7dQJaG6T
         QL3/wmMxAIdvqzHCQ0EOYSFUOBwAIVnZSYXEerXPz3x1I2ubMWis2DGFm+YfJzLdN4
         3KTX00ewoBpkSgp6zibPVzCTW9n2N0HdYpyEgGz8aOj14ttigO0VmyDfViL4EbE2e1
         DJUqbu7N7B47g==
Date:   Tue, 31 Oct 2023 15:25:19 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031-trauben-jobben-40074a43e5a0@brauner>
References: <20231030103415.401ce804@canb.auug.org.au>
 <20231030173228.691620ca@xps-13>
 <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
 <20231031085158.o4ilb5d47sxcqm3o@quack3>
 <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
 <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
 <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
 <20231031134522.27e78274@xps-13>
 <440004449.28174.1698758033696.JavaMail.zimbra@nod.at>
 <20231031145006.3df11822@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031145006.3df11822@xps-13>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:50:06PM +0100, Miquel Raynal wrote:
> 
> richard@nod.at wrote on Tue, 31 Oct 2023 14:13:53 +0100 (CET):
> 
> > ----- Ursprüngliche Mail -----
> > > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>  
> > >> Miquel, we could also keep ff6abbe85634 in the mtd tree and explain Linus the
> > >> conflict, what do you think? That would help with back porting to stable.  
> > > 
> > > It's not relevant if the patch in Brauner's tree is already fixing this
> > > up. Just send the smaller patch to stable@vger.kernel.org asking them to
> > > backport this patch instead of the other one, they are used to this
> > > kind of constraint, no?  
> > 
> > I'm just in fear of stable rule #1.
> > "It or an equivalent fix must already exist in Linus' tree (upstream)."
> 
> It should be very soon, the merge window is open ;)

vfs-6.7.super was merged yesterday, if that's what this is about.
