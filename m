Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694778C0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjH2Ipj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjH2IpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:45:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C5219F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:45:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAAC2F4;
        Tue, 29 Aug 2023 01:45:44 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4DF43F64C;
        Tue, 29 Aug 2023 01:45:03 -0700 (PDT)
Message-ID: <b5766b5e-34d8-cd29-db16-6d4af3b0635e@arm.com>
Date:   Tue, 29 Aug 2023 09:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
To:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
 <e94ae586-0362-7cc1-60a8-af9ec8059e3e@arm.com>
 <20230828163045.GA27321@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230828163045.GA27321@willie-the-truck>
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

On 28/08/2023 17:30, Will Deacon wrote:
> On Mon, Aug 28, 2023 at 08:11:41AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 8/18/23 23:34, Will Deacon wrote:
>>> On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
>>>> This series enables detection of ACPI based TRBE devices via a stand alone
>>>> purpose built representative platform device. But as a pre-requisite this
>>>> changes coresight_platform_data structure assignment for the TRBE device.
>>>>
>>>> This series is based on v6.5-rc5 kernel, is also dependent on the following
>>>> EDK2 changes posted earlier by Sami.
>>>>
>>>> [...]
>>>
>>> Applied to will (for-next/perf), thanks!
>>>
>>> [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
>>>        https://git.kernel.org/will/c/81e5ee471609
>>> [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
>>>        https://git.kernel.org/will/c/1aa3d0274a4a
>>
>> It seems like the above two changes are still going in for 6.6-rc1 ? I could
>> see these in arm64/for-next/core and latest linux-next next-20230825.
> 
> Yes, as I said, I only dropped the coresight bits.

Ok, then I can pick up coresight changes via my tree and push it to Greg.

Suzuki


> 
> Will

