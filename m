Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C177D57BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjJXQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjJXQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:14:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B73A1;
        Tue, 24 Oct 2023 09:14:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE17C433CC;
        Tue, 24 Oct 2023 16:14:26 +0000 (UTC)
Date:   Tue, 24 Oct 2023 17:14:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm64 tree
Message-ID: <ZTftYOqyCOxhjoxi@arm.com>
References: <20231024172409.7b519868@canb.auug.org.au>
 <ZTeUhsf1xWmkJcRh@arm.com>
 <CAMj1kXGSG0KLa0NNnMM-_zh+wEJm94b2zpHtkSeUi1hdxMYa_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGSG0KLa0NNnMM-_zh+wEJm94b2zpHtkSeUi1hdxMYa_Q@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:42:20PM +0200, Ard Biesheuvel wrote:
> On Tue, 24 Oct 2023 at 11:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > + Ard
> >
> > On Tue, Oct 24, 2023 at 05:24:09PM +1100, Stephen Rothwell wrote:
> > > After merging the arm64 tree, today's linux-next build (arm64 defconfig)
> > > produced this warning:
> > >
> > > WARNING: modpost: vmlinux: section mismatch in reference: __pi_$x+0x38 (section: .text) -> __pi_map_range (section: .init.text)
> > >
> > > I don't know what caused this.
> >
> > For some reason, building linux-next doesn't inline all the functions in
> > the map_range.c file and we end up with some of them in different
> > sections. I didn't get this when building the arm64 for-next/core
> > separately.
> >
> 
> Strange, I never ran into this before.
> 
> I guess commit 24cc769d70d8bda055a028aa6a is implicated in this, if we
> run into more trouble like this i'll look whether we can bring that
> logic back in some way.
> 
> The fix looks fine to me.

Thanks. I applied this fix locally (will push it out in a bit). I added
a fixes tag for a latter commit introducing map_segment() etc.

-- 
Catalin
