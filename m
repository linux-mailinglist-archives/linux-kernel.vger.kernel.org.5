Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831676C1A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHBAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHBAwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:52:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 754FD19AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:52:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC5CD75;
        Tue,  1 Aug 2023 17:52:44 -0700 (PDT)
Received: from [10.163.53.180] (unknown [10.163.53.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED4BA3F5A1;
        Tue,  1 Aug 2023 17:51:56 -0700 (PDT)
Message-ID: <17190a14-919b-62f0-cd55-3e819be41e7e@arm.com>
Date:   Wed, 2 Aug 2023 06:21:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 0/4] coresight: trbe: Enable ACPI based devices
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801145249.GG26253@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230801145249.GG26253@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 20:22, Will Deacon wrote:
> On Tue, Aug 01, 2023 at 03:10:48PM +0530, Anshuman Khandual wrote:
>> This series enables detection of ACPI based TRBE devices via a stand alone
>> purpose built representative platform device. But as a pre-requisite this
>> changes coresight_platform_data structure assignment for the TRBE device.
>>
>> This series is based on v6.5-rc4 kernel, is also dependent on the following
>> EDK2 changes posted earlier by Sami.
>>
>> https://edk2.groups.io/g/devel/message/107239
>> https://edk2.groups.io/g/devel/message/107241
>>
>> Changes in V2:
>>
>> - Refactored arm_spe_acpi_register_device() in a separate patch
>> - Renamed trbe_acpi_resources as trbe_resources
>> - Renamed trbe_acpi_dev as trbe_dev
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20230728112733.359620-1-anshuman.khandual@arm.com/
>>
>> Cc: Sami Mujawar <sami.mujawar@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
> 
> FYI: if you pass '--cc-cover' to git send-email, it will CC all these
> folks on the series, which I think is better when you're reviewing stuff
> (I didn't receive patches 3 and 4).

My bad, forgot --cc-cover on the command line.
