Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E11802F34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjLDJsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjLDJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:48:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBFFB189;
        Mon,  4 Dec 2023 01:48:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4B65FEC;
        Mon,  4 Dec 2023 01:49:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF633F6C4;
        Mon,  4 Dec 2023 01:48:12 -0800 (PST)
Date:   Mon, 4 Dec 2023 09:48:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from
 'struct pmu_hw_events'
Message-ID: <ZW2gWTfIKgHAYwSd@FVFF77S0Q05N>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
 <a8362015-c6e6-4d59-ba2b-67dc12bd89c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8362015-c6e6-4d59-ba2b-67dc12bd89c8@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:59:49AM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/15/23 14:58, Anshuman Khandual wrote:
> > This series drops 'pmu_lock' usage from all arm platforms which had already
> > been dropped from arm64 platforms earlier via the following commit.
> > 
> > commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking"). 
> > 
> > Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
> > series applies on 6.7-rc1 and has been tested on arm64. Although just build
> > tested for arm platform.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > 
> > Changes in V1:
> > 
> > - Added some build warning fixes
> 
> Hello Will/Mark,
> 
> Any updates or concerns on this series ?

The changes themselves look good to me. I'd like to tweak the commit message
for the first patch (and I've given specific wording that we can use).

Will, are you happy to fold that in when applying, or would you prefer that
Anshuman sends a v2?

Mark.
