Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B805B800AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378836AbjLAM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbjLAM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:28:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA493
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:29:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD1C433C9;
        Fri,  1 Dec 2023 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701433742;
        bh=2msErawXU1FtCRCS5sg1Q8l3QB+7X8g5Q4ahABRE7v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ8jDacFlSnfz6vHti2Hqo/yYnjTmAowPHXSHHs/ZVAyHKK3vqYmj15fWpmlFSwyK
         oDGOQXI0cD4TOPugWR4XLWNsKEWov5ibPPHMGBZmtzjTJjHNBvU0cN9CgmbjjZoerF
         FiLiZFU4qf9MaXbefoLTcFW9iipaY39QNIHlh/Ag=
Date:   Fri, 1 Dec 2023 12:28:59 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/21] Initial cleanups for vCPU hotplug
Message-ID: <2023120131-leotard-deprecate-4e27@gregkh>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <87plzqxiyl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzqxiyl.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:25:54PM +0100, Thomas Gleixner wrote:
> Russell!
> 
> On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> > This series aims to switch most architectures over to using generic CPU
> > devices rather than arch specific implementations, which I think is
> > worthwhile doing even if the vCPU hotplug series needs further work.
> 
> I went through the whole series and I can't find anything
> objectionable.
> 
> Vs. merging: It does not make sense to split this up and route
> individual patches.
> 
> So I can pick the whole pile up and route it through tip smp/core unless
> Rafael or Greg prefer to take it through one of their trees. For the
> latter case:
> 
>        Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Greg, Rafael?

I can take them, will do so this weekend when I catch up on patches on a
14+ hour flight...

greg k-h
