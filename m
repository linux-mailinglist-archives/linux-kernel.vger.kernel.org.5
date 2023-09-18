Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD57A479B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjIRKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjIRKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:52:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52301A1;
        Mon, 18 Sep 2023 03:52:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EFCD1FB;
        Mon, 18 Sep 2023 03:53:02 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01713F67D;
        Mon, 18 Sep 2023 03:52:23 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:52:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230918105221.msuwbo2deya6rdim@bogus>
References: <20230915202511.1452091-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915202511.1452091-1-quic_poza@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:25:11PM -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provide an architectural context loss flags field that can
> be used to describe the context that might be lost when an LPI
> state is entered.
> 
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> Qualcomm's custom CPUs preserves the architectural state,
> including keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to
> wake the core up without needing broadcast timer.
> 
> The patch fixes the evaluation of cpuidle arch_flags, and moves only to
> broadcast timer if core context lost is defined in ACPI LPI.
> 
> Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> ---
> 
> Notes:
>     Will/Catalin: Rafael has acked and he prefers to take it via arm64 tree

You need to add the tags received. You have added my review tag but not
the Rafael's Acked-by tag.

-- 
Regards,
Sudeep
