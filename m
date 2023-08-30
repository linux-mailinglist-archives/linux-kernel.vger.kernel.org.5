Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418378D8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjH3SbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbjH3JCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:02:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE393CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:02:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18E72F4;
        Wed, 30 Aug 2023 02:02:43 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1C763F64C;
        Wed, 30 Aug 2023 02:02:02 -0700 (PDT)
Message-ID: <76135689-79c3-9845-15ad-847cdac8ac59@arm.com>
Date:   Wed, 30 Aug 2023 10:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V6 0/2] coresight: trbe: Enable ACPI based devices
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230829135405.1159449-1-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230829135405.1159449-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

On 29/08/2023 14:54, Anshuman Khandual wrote:
> These are remaining coresight patches after fixing the merge conflict which
> applies on coresight/next coresight-next-v6.6.
> 
> Changes in V6:
> 
> - Fixed te merge conflict
> 


Please could you confirm if the commits [0] in your for-next/perf branch
are stable ? Accordingly I could merge these patches on top of your
commits and send them to Greg.

[0] https://git.kernel.org/will/c/1aa3d0274a4a

Suzuki


> Changes in V5:
> 
> https://lore.kernel.org/all/20230817055405.249630-1-anshuman.khandual@arm.com/
> 
> - Detected zeroed parsed GSI as a mismatch but handled all zero scenario
> - Changed condition check from 'if (ret < 0)' into a 'if (ret)'
> - Dropped pr_warn() message after platform_device_register()
> 
> Changes in V4:
> 
> https://lore.kernel.org/all/20230808082247.383405-1-anshuman.khandual@arm.com/
> 
> - Added in-code comment for arm_trbe_device_probe()
> - Reverted back using IS_ENABLED() for SPE PMU platform device
> - Replaced #ifdef with IS_ENABLED() for TRBE platform device
> - Protected arm_trbe_acpi_match with ACPI_PTR() - preventing a build failure
>    when CONFIG_ACPI is not enabled
> - Added __maybe_unused for arm_acpi_register_pmu_device() and dropped config
>    checks with IS_ENABLED()
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/20230803055652.1322801-1-anshuman.khandual@arm.com/
> 
> - Changed ARMV8_TRBE_PDEV_NAME from "arm-trbe-acpi" into "arm,trbe"
> - Dropped local variable 'matched'
> - Replaced 'matched' with 'valid gsi' as being already matched once
> - Moved find_acpi_cpu_topology_hetero_id() outside conditional check
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20230801094052.750416-1-anshuman.khandual@arm.com/
> 
> - Refactored arm_spe_acpi_register_device() in a separate patch
> - Renamed trbe_acpi_resources as trbe_resources
> - Renamed trbe_acpi_dev as trbe_dev
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20230728112733.359620-1-anshuman.khandual@arm.com/
> 
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (2):
>    coresight: trbe: Add a representative coresight_platform_data for TRBE
>    coresight: trbe: Enable ACPI based TRBE devices
> 
>   drivers/hwtracing/coresight/coresight-trbe.c | 23 ++++++++++++++++++--
>   drivers/hwtracing/coresight/coresight-trbe.h |  2 ++
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 

