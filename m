Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9079E269
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjIMInL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIMInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:43:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C2FFC3;
        Wed, 13 Sep 2023 01:43:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C65C15;
        Wed, 13 Sep 2023 01:43:43 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853863F67D;
        Wed, 13 Sep 2023 01:43:04 -0700 (PDT)
Date:   Wed, 13 Sep 2023 09:43:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230913083908.dfanwizomj5i536k@bogus>
References: <20230912172933.3561144-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912172933.3561144-1-quic_poza@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:29:33AM -0700, Oza Pawandeep wrote:
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
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

IIRC, Rafael had acked this, perhaps missing the tag ?
Also just add a note to Will/Catalin that Rafael has acked and prefer to
take it via arm64 tree.

-- 
Regards,
Sudeep
