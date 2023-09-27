Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E67AFEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjI0IpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjI0Io4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:44:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D4EFCFD;
        Wed, 27 Sep 2023 01:37:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8E41FB;
        Wed, 27 Sep 2023 01:37:46 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 082A83F59C;
        Wed, 27 Sep 2023 01:37:03 -0700 (PDT)
Message-ID: <240f888a-1394-8624-7315-8d4a198d20dd@arm.com>
Date:   Wed, 27 Sep 2023 14:07:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V13 - RESEND 00/10] arm64/perf: Enable branch stack
 sampling
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230711082455.215983-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/23 13:54, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.5-rc1.
> 
> Changes in V13:
> 
> https://lore.kernel.org/all/20230622065351.1092893-1-anshuman.khandual@arm.com/
> 
> - Added branch callback stubs for aarch32 pmuv3 based platforms
> - Updated the comments for capture_brbe_regset()
> - Deleted the comments in __read_brbe_regset()
> - Reversed the arguments order in capture_brbe_regset() and brbe_branch_save()
> - Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in armv8pmu_branch_read()
> - Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in capture_brbe_regset()

Hello All,

Upcoming V14 series is still being worked out, and might take some more time. But
meanwhile please find its corresponding development branch for experimentation
purpose, if required. Thank you.

https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v14_rc3)

- Anshuman
