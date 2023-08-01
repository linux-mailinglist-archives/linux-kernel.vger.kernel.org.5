Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDC76B804
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjHAOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHAOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7996F12B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18447615D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B544C433C9;
        Tue,  1 Aug 2023 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901477;
        bh=7uGQKwVmgrp2Epfn507StufnLwuxNRzOT2TUGmio1nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOdkNYBYAU9AX/fY99FY4zIPHOKZFc4/+CgrxENCucJE8LqcYvXCMXO+ZBikeSLUC
         zWthPY4bx+35gdRgEZyninDGgW6FTJ3//b04kr1P3mXVz+2IiRQWoSB8JNu+wShaQf
         k+8m/r7SlZCXi4QbMxc1RImacnVChJMDPEodjTQOJJQ/wmuo0Si3qS86wtG25AYvDL
         V+KAan+bAR5N/iTCgNT7UwI0bsFxYwqpKN7XiN5/G+kUhc/C7Uv/v9Vd4n10iK9T3m
         Rrhj6NDxWgUbgupJXQT0zyuBTmm/dq9AgXnLoqcqNJ1JwLj/HxgAGm2k+VbMdw0DTr
         qZfgKSkM9obRg==
Date:   Tue, 1 Aug 2023 15:51:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] arm_pmu: acpi: Add a representative platform
 device for TRBE
Message-ID: <20230801145111.GF26253@willie-the-truck>
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801094052.750416-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801094052.750416-3-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:10:50PM +0530, Anshuman Khandual wrote:
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index a0801f68762b..7ec26d21303d 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
>  #endif /* CONFIG_ARM_PMU */
>  
>  #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
> +#define ARMV8_TRBE_PDEV_NAME "arm-trbe-acpi"

Why is the TRBE name formatted differently to the SPE one?

Will
