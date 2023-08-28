Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A578A4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjH1Clt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjH1Cls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:41:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D490F9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:41:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F9D02F4;
        Sun, 27 Aug 2023 19:42:26 -0700 (PDT)
Received: from [10.163.57.227] (unknown [10.163.57.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82573F740;
        Sun, 27 Aug 2023 19:41:40 -0700 (PDT)
Message-ID: <e94ae586-0362-7cc1-60a8-af9ec8059e3e@arm.com>
Date:   Mon, 28 Aug 2023 08:11:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 23:34, Will Deacon wrote:
> On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
>> This series enables detection of ACPI based TRBE devices via a stand alone
>> purpose built representative platform device. But as a pre-requisite this
>> changes coresight_platform_data structure assignment for the TRBE device.
>>
>> This series is based on v6.5-rc5 kernel, is also dependent on the following
>> EDK2 changes posted earlier by Sami.
>>
>> [...]
> 
> Applied to will (for-next/perf), thanks!
> 
> [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
>       https://git.kernel.org/will/c/81e5ee471609
> [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
>       https://git.kernel.org/will/c/1aa3d0274a4a

It seems like the above two changes are still going in for 6.6-rc1 ? I could
see these in arm64/for-next/core and latest linux-next next-20230825.


> [3/4] coresight: trbe: Add a representative coresight_platform_data for TRBE
>       https://git.kernel.org/will/c/e926b8e9eb40
> [4/4] coresight: trbe: Enable ACPI based TRBE devices
>       https://git.kernel.org/will/c/0fb93c5ede13
> 
> Cheers,
