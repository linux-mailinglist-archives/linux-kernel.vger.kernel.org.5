Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0D7534FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjGNIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjGNIX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65909B;
        Fri, 14 Jul 2023 01:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655DF61C61;
        Fri, 14 Jul 2023 08:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BBAC433C8;
        Fri, 14 Jul 2023 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689323034;
        bh=vzHIGLT92Won/B+RdarvMWgfIJZa19KQoX8ChdEHMg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AskWsqQaO75T/DiVs/BB5UDGtJvAKhKPuM097sDiW6fUZOYHFrFKYQ5y9pu0Dlgj3
         go1lNSQtftxWnc8pIgT9bexrb5IrtorOqcnQfX5n5CkbdVZ9lSZmvUrHhJNlttGx3s
         phXYBswGDYE+qruo00bdQ83nCIhwMJYcCX4PTvi4HtR21J6j/kCA3KSUsRjtZuT/cr
         0kQa1AHRxdpKKDIMOmgUjO4VcMl2PxG3vtMEDR41p/UTZ05l9/O8cNuPxzzopWK+or
         F0osdwWgs8io0eK2jKPRFJisr565qCNZ9cPI7OSiuKMPlUTADqqtImqDCJUDk/rEO2
         +zuUDEzTXaQWg==
Date:   Fri, 14 Jul 2023 09:23:48 +0100
From:   Will Deacon <will@kernel.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, corbet@lwn.net,
        catalin.marinas@arm.com, maz@kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_satyap@quicinc.com,
        quic_shashim@quicinc.com, quic_songxue@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <20230714082348.GA5240@willie-the-truck>
References: <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
 <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
 <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
 <604ac52d-4336-744f-2ab8-44d1c93fbaa8@quicinc.com>
 <ZK_d86ApI1FCHhTL@FVFF77S0Q05N.cambridge.arm.com>
 <e02b9969-a3ca-a80d-1d32-25d2bf4c72b6@quicinc.com>
 <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
 <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:56:27AM +0800, Aiqun(Maria) Yu wrote:
> On 7/14/2023 3:08 AM, Mark Rutland wrote:
> > On Thu, Jul 13, 2023 at 10:08:34PM +0800, Aiqun(Maria) Yu wrote:
> > > On 7/13/2023 7:20 PM, Mark Rutland wrote:
> > > > Are you saying that LSE atomics to *cacheable* mappings do not work on your
> > > > system?
> > > > 
> > > > Specifically, when using a Normal Inner-Shareable Inner-Writeback
> > > > Outer-Writeback mapping, do the LSE atomics work or not work?
> > > *cacheable* mapping have the LSE atomic is not working if far atomic is
> > > performed.
> > 
> > Thanks for confirming; the fact that this doesn't work on *cacheable* memory is
> > definitely a major issue. I think everyone is confused here because of the
> > earlier mention of non-cachable accesses (which don't matter).
> > 
> Maybe I can have the information collected in a summary to see if that
> helps.
> > I know that some CPU implementations have EL3 control bits to force LSE atomics
> > to be performed near (e.g. in Cortex-A55, the CPUECTLR.ATOM control bits),
> > which would avoid the issue while still allowing the LSE atomics to be used.
> > 
> > If those can be configured in EL3 firmware, that would be a preferable
> > workaround.
> > 
> > Can you say which CPUs are integrated in this system? and/or can you check if
> > such control bits exist?
> 
> We have CPUECTLR_EL1.ATOM bit can force LSE atomics to be perform near.
> CPUECTLR_EL1 is also an option to EL1 kernel drivers to be configuarable.
> 
> Try to a detailed summarise of the whole discussions, anyone can ignore some
> part if you are already know.
> 
> * Part 1: Solution for this issue.
> While we still want to have options to let third party and end users can
> have options:
>   1.Disable lse atomic cap.
>   2.*Disallow* far atomic by "CPUECTLR_EL1.atom force near atomic" and
> non-cachable mappling for lse atomic only.

Sorry, but this still isn't making sense to me. Which CPUs do you have on
this SoC?

My understanding of the CPUs from ARM is that LSE atomics are not supposed
to be sent to blocks that don't support them. That doesn't mean you have to
do everything near, however -- you can still execute them at e.g. L2.

For example, the Cortex-X1 TRM states:

  | Atomic instructions to cacheable memory can be performed as either
  | near atomics or far atomics, depending on where the cache line
  | containing the data resides.
  |
  | When an instruction hits in the L1 data cache in a unique state, then
  | it is performed as a near atomic in the L1 memory system. If the atomic
  | operation misses in the L1 cache, or the line is shared with another
  | core, then the atomic is sent as a far atomic on the core CHI interface.
  |
  | If the operation misses everywhere within the cluster, and the
  | interconnect supports far atomics, then the atomic is passed on to the
  | interconnect to perform the operation.
  | 
  | When the operation hits anywhere inside the cluster, or when an
  | interconnect does not support atomics, the L3 memory system performs
  | the atomic operation. If the line is not already there, it allocates
  | the line into the L3 cache. This depends on whether the DSU is configured
  | with an L3 cache.

So something doesn't add up.

> * Part 2: Why we need the solution
> 1. There is also some case far atomic is better performance than near
> atomic. end user may still can still try to do allow far atomic.
> while this driver is also use kerenl LSE ATOMIC macro, so it can be running
> on cpu don't support lse atomic and cpu support lse atomic already.
> while current system, cpu have feature register said lse atomic is
> supported, but memory controller is not supported is currently not yet
> supported.

I think you're forgetting the fact that these instructions can be executed
by userspace, so the kernel option is completely bogus. If you're saying
that cacheable atomics can cause external aborts, then I can write an app
which will crash your device even if you've set this command line option.

Will
