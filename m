Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33A7764BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHIQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21A19E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D90163FDD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3E0C433CB;
        Wed,  9 Aug 2023 16:11:41 +0000 (UTC)
Date:   Wed, 9 Aug 2023 17:11:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature
 for xCR registers
Message-ID: <ZNO6uh02/XxzhPAX@arm.com>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
 <ZMvYSmpCfFQ2+m7q@arm.com>
 <3ccab5cb-9d19-40a2-ae9c-99d37996da9c@sirena.org.uk>
 <ZM0lRWTAE/b88V6U@arm.com>
 <02b86e5c-221a-4e03-bdca-c7f7798e2e01@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b86e5c-221a-4e03-bdca-c7f7798e2e01@sirena.org.uk>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:37:25PM +0100, Mark Brown wrote:
> On Fri, Aug 04, 2023 at 05:20:21PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 03, 2023 at 06:44:24PM +0100, Mark Brown wrote:
> > > On Thu, Aug 03, 2023 at 05:39:38PM +0100, Catalin Marinas wrote:
> > > > Maybe that's the simplest fix, especially if you want it in stable, but
> > > 
> > > Yeah, it's definitely the sort of change we want as a fix - anything
> > > more invasive would be inappropriate.
> > 
> > I'd say it's still ok if we can just rip come code out safely (the fake
> > ID reg).
> 
> It's the safely bit that concerns me here - it feels like a great way to
> discover why the code was there, possibly including a use that was there
> in the past but has subsequently been removed so bites a stable version.

As discussed earlier, let's queue this patch as is (for 6.6 I'd say)
with cc stable and post a new patch on top that removes the fake CPUID
register going forward, in case we missed anything.

For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
