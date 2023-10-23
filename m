Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120D7D2D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjJWJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJWJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:06:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99E2DA9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:06:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B532F4;
        Mon, 23 Oct 2023 02:07:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDBD3F64C;
        Mon, 23 Oct 2023 02:06:20 -0700 (PDT)
Date:   Mon, 23 Oct 2023 10:06:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
Message-ID: <ZTY3ieLQaRQ4dHYP@FVFF77S0Q05N>
References: <cover.1697824215.git.robin.murphy@arm.com>
 <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
 <8e179525-bba-c577-85cf-4aa0a7af436@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e179525-bba-c577-85cf-4aa0a7af436@os.amperecomputing.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:50:30PM -0700, Ilkka Koskinen wrote:
> Hi Robin,
> 
> I have one comment, otherwise the patch looks good to me.

> > +/* @i is the DTC number, @idx is the counter index on that DTC */
> > +#define for_each_hw_dtc_idx(hw, i, idx) \
> > +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)
> 
> Isn't that "idx" unnecessary in the initialization?

That creates the 'idx' variable that's assigned to by `idx = hw->dtc_idx[i]`,
so that is necessary.

Mark.
