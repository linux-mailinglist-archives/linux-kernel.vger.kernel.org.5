Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12B7A0172
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjINKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjINKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:17:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F420C1BE9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:17:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2951FB;
        Thu, 14 Sep 2023 03:17:43 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 569993F738;
        Thu, 14 Sep 2023 03:17:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:16:59 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Add some missing userspace ABI documentation
Message-ID: <20230914101659.GA1170646@e124191.cambridge.arm.com>
References: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:09:28AM +0100, Mark Brown wrote:
> I noticed that we've added HWCAP2_HBC without updating the
> documentation, and in the process also noticed that some user visible
> fields in ID_AA64ISAR2_EL1 are not documented.  Fix these issues.
> 
> Given the lack of any automatic generation or auditing there's almost
> certainly more fields that are broken in cpu-feature-registers.rst, I
> didn't check any other registers.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (2):
>       arm64/hbc: Document HWCAP2_HBC
>       arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1
> 
>  Documentation/arch/arm64/cpu-feature-registers.rst | 10 ++++++++++
>  Documentation/arch/arm64/elf_hwcaps.rst            |  3 +++
>  2 files changed, 13 insertions(+)
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230913-arm64-feat-hbc-doc-08e3d1741fdb
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

I sent out a fix for this yesterday:
	https://lore.kernel.org/linux-arm-kernel/6162249d-dc0f-8755-9439-3ada8a88f424@arm.com/T/#t

Kristina also noticed cpu-feature-registers.rst hadn't been updated either, so I was just about to
send out a v2 that matches your patches. I won't do that since you've just done it!

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey
