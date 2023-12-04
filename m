Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46DB803B45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjLDRUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLDRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:20:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A79383
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:20:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FF4013D5;
        Mon,  4 Dec 2023 09:20:54 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539833F6C4;
        Mon,  4 Dec 2023 09:20:06 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:20:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <ZW4KQEXk9P5fte-4@FVFF77S0Q05N>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130120831.GB20153@noisy.programming.kicks-ass.net>
 <20231130124909.GEZWiExTP4J1pjNxPq@fat_crate.local>
 <ZW2tBy_8U5cfEkmk@FVFF77S0Q05N>
 <20231204154954.GDZW31IjgG6A0HSULH@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204154954.GDZW31IjgG6A0HSULH@fat_crate.local>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 04:49:54PM +0100, Borislav Petkov wrote:
> On Mon, Dec 04, 2023 at 10:42:15AM +0000, Mark Rutland wrote:
> > Later, in December 2016 we made KCOV adjust the address to remove the KASLR
> > offset in commit:
> > 
> >   4983f0ab7ffaad1e ("kcov: make kcov work properly with KASLR enabled")
> 
> Neat trick, I should remember that. Might come in handy.
> 
> > ... so I think that's been stale for ~7 years, and we just forgot to clean up
> > the Kconfig.debug text.
> 
> Ok, I guess you'll clean it up then.

Sure; done:

  https://lore.kernel.org/lkml/20231204171807.3313022-1-mark.rutland@arm.com/

Mark.
