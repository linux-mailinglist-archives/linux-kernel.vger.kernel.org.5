Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A37E5302
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjKHKF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:05:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD91723
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:05:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F5BC433C7;
        Wed,  8 Nov 2023 10:05:53 +0000 (UTC)
Date:   Wed, 8 Nov 2023 10:05:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Message-ID: <ZUtdfkISdtWtJsV8@arm.com>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
 <169936667591.2397489.8626905802471861575.b4-ty@arm.com>
 <f3661af2-7fdf-d828-ef88-5732a370c0c@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3661af2-7fdf-d828-ef88-5732a370c0c@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:12:58PM -0800, Ilkka Koskinen wrote:
> On Tue, 7 Nov 2023, Catalin Marinas wrote:
> > On Thu, 02 Nov 2023 17:16:54 -0700, Ilkka Koskinen wrote:
> > > Coresight PMU driver didn't reject events meant for other PMUs.
> > > This caused some of the Core PMU events disappearing from
> > > the output of "perf list". In addition, trying to run e.g.
> > > 
> > >      $ perf stat -e r2 sleep 1
> > > 
> > > made Coresight PMU driver to handle the event instead of letting
> > > Core PMU driver to deal with it.
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/core), thanks!
> 
> Just wanted to ask if you are planning to submit this patch for 6.7-rcX as a
> fix? We have found out that one can even crash AmpereOne by running
> "perf stat -C 1 sleep 1" without the patch.

Yes, I'll send it for 6.7-rc1 (probably tomorrow).

-- 
Catalin
