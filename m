Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C0812E83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443862AbjLNL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:26:55 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABAA7;
        Thu, 14 Dec 2023 03:27:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VyUHCGA_1702553216;
Received: from 30.240.112.122(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VyUHCGA_1702553216)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 19:26:58 +0800
Message-ID: <e047da91-4a15-4864-bcda-9717170dab7e@linux.alibaba.com>
Date:   Thu, 14 Dec 2023 19:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, yangyicong@huawei.com,
        Jonathan.Cameron@huawei.com, ilkka@os.amperecomputing.com,
        robin.murphy@arm.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, baolin.wang@linux.alibaba.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        mark.rutland@arm.com, rdunlap@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
 <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/14 01:25, Will Deacon wrote:
> On Fri, 8 Dec 2023 10:56:47 +0800, Shuai Xue wrote:
>> Change Log
>> ==========
>> change sinces v11:
>> - Fix uninitialized symbol 'now' (Per Dan and Will)
>> - Pick up Reviewed-and-tested-by tag from Ilkka for Patch 4/5
>>
>> change sinces v10:
>> - Rename to pci_clear_and_set_config_dword() to retain the "config"
>>   information and match the other accessors. (Per Bjorn)
>> - Align pci_clear_and_set_config_dword() and its call site (Per Bjorn)
>> - Polish commit log (Per Bjorn)
>> - Simplify dwc_pcie_pmu_time_based_event_enable() with bool value (Per Ilkka)
>> - Fix dwc_pcie_register_dev() return value (Per Ilkka)
>> - Fix vesc capability discovery by pdev->vendor (Per Ilkka)
>> - pick up Acked-by tag from Bjorn for Patch 3/5
>> - pick up Tested-by tag from Ilkka for all patch set
>>
>> [...]
> 
> Applied to will (for-next/perf), thanks!
> 
> [1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/cae40614cdd6
> [2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
>       https://git.kernel.org/will/c/ad6534c626fe
> [3/5] PCI: Move pci_clear_and_set_dword() helper to PCI header
>       https://git.kernel.org/will/c/ac16087134b8
> [4/5] drivers/perf: add DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/af9597adc2f1
> [5/5] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/f56bb3de66bc
> 
> Cheers,

Really a good news for me. Thank you very much:)

And thanks to all patient and nice reviewers.

Cheers,
Shuai
