Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8416E753A66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjGNMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjGNMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:09:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2952358E;
        Fri, 14 Jul 2023 05:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632FF61D03;
        Fri, 14 Jul 2023 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A65AC433C8;
        Fri, 14 Jul 2023 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336592;
        bh=GqntrC5nJzIPRXSONxz2G9J4TDNYa4iq/zHDKdXGLro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMuNDWn3UjL4P0QKGpk+hpHq5gijkQBc3pv9mk1yb8Y9tRwDHvVi/aY3Bxey/st8d
         XKMuD79se12hhzzpq7q4Lm32XQve8/0J2L8I+dQoaRL7qkbQ65ve90XALWNbAS4gxA
         J1vjwpgEQr9Bx532eXdoDmDIZ3EqKKQ5tzMMdVUjzRtHXh8Rl0S07wbP7bveZogoAF
         PbEbRHrPwmc9g1XeaWwWMZTa/OJJNZrfUUeqm06adzX7t5jR8XeHuvTzW66ZeDCsII
         Sak4InAitreezr4A92xfabmJUcyH2ZTPHo3Ynz0vU39sFjaF6Jy74Ol1TScQ1dCg6D
         YP8ZSuzzo1DaQ==
Date:   Fri, 14 Jul 2023 13:09:46 +0100
From:   Will Deacon <will@kernel.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, corbet@lwn.net,
        catalin.marinas@arm.com, maz@kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_satyap@quicinc.com,
        quic_shashim@quicinc.com, quic_songxue@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <20230714120946.GA5597@willie-the-truck>
References: <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
 <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
 <604ac52d-4336-744f-2ab8-44d1c93fbaa8@quicinc.com>
 <ZK_d86ApI1FCHhTL@FVFF77S0Q05N.cambridge.arm.com>
 <e02b9969-a3ca-a80d-1d32-25d2bf4c72b6@quicinc.com>
 <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
 <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
 <20230714082348.GA5240@willie-the-truck>
 <b76c7a9b-8ed6-97da-bdfa-47cc7db51ff5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76c7a9b-8ed6-97da-bdfa-47cc7db51ff5@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 06:12:02PM +0800, Aiqun(Maria) Yu wrote:
> On 7/14/2023 4:23 PM, Will Deacon wrote:
> > On Fri, Jul 14, 2023 at 09:56:27AM +0800, Aiqun(Maria) Yu wrote:
> > > Try to a detailed summarise of the whole discussions, anyone can ignore some
> > > part if you are already know.
> > > 
> > > * Part 1: Solution for this issue.
> > > While we still want to have options to let third party and end users can
> > > have options:
> > >    1.Disable lse atomic cap.
> > >    2.*Disallow* far atomic by "CPUECTLR_EL1.atom force near atomic" and
> > > non-cachable mappling for lse atomic only.
> > 
> > Sorry, but this still isn't making sense to me. Which CPUs do you have on
> > this SoC?
> cpu is cortex A78/A55.
> > 
> > My understanding of the CPUs from ARM is that LSE atomics are not supposed
> > to be sent to blocks that don't support them. That doesn't mean you have to
> > do everything near, however -- you can still execute them at e.g. L2.
> > 
> > For example, the Cortex-X1 TRM states:
> > 
> >    | Atomic instructions to cacheable memory can be performed as either
> >    | near atomics or far atomics, depending on where the cache line
> >    | containing the data resides.
> >    |
> >    | When an instruction hits in the L1 data cache in a unique state, then
> >    | it is performed as a near atomic in the L1 memory system. If the atomic
> >    | operation misses in the L1 cache, or the line is shared with another
> >    | core, then the atomic is sent as a far atomic on the core CHI interface.
> lse atomic is optional to CHI-B for example, some system may have cpu
> feature register have lse atomic feature, but the far atomic is not accpeted
> by CHI side. It will be simiar issue that we do.

Again, that should not be a problem. Looking at the A55 TRM, it explicitly
says that atomics will be done in the L3 if the interconnect does not
support them. The A78 TRM doesn't talk about this at all, so I defer to
Mark (or anybody else from Arm) on how that works, but one might assume
that it does something similar to the other Arm cores.

> > > * Part 2: Why we need the solution
> > > 1. There is also some case far atomic is better performance than near
> > > atomic. end user may still can still try to do allow far atomic.
> > > while this driver is also use kerenl LSE ATOMIC macro, so it can be running
> > > on cpu don't support lse atomic and cpu support lse atomic already.
> > > while current system, cpu have feature register said lse atomic is
> > > supported, but memory controller is not supported is currently not yet
> > > supported.
> > 
> > I think you're forgetting the fact that these instructions can be executed
> > by userspace, so the kernel option is completely bogus. If you're saying
> > that cacheable atomics can cause external aborts, then I can write an app
> > which will crash your device even if you've set this command line option.
> > 
> For apps like userspace also needed to check the system capbility as far as

That's not something you can enforce, so a malicious application can easily
crash your system.

Will
