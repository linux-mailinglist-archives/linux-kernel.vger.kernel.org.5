Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25077F06F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbjHQGTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbjHQGTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:19:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7838012B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:19:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1261FD75;
        Wed, 16 Aug 2023 23:19:46 -0700 (PDT)
Received: from [10.163.56.113] (unknown [10.163.56.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2E8D3F762;
        Wed, 16 Aug 2023 23:19:01 -0700 (PDT)
Message-ID: <fa0436f5-dac8-250b-6ab9-1f01c88735b8@arm.com>
Date:   Thu, 17 Aug 2023 11:48:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Fix some issues with TRBE building as a module
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230814093813.19152-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/23 15:08, Junhao He wrote:
> The TRBE driver support is build as a module, we found some driver issues
> based on the patchset [1] and set CONFIG_CORESIGHT_TRBE=m.
> 1. TRBE driver potential sleep in atomic context when unregister device
> 2. Multiple free the platform data resource when rmmod coresight TRBE
> driver
> 
> [1] "coresight: trbe: Enable ACPI based devices"
> https://lore.kernel.org/all/20230808082247.383405-1-anshuman.khandual@arm.com/

I am glad that ACPI based device enablement is already helping in getting more
test coverage for the TRBE driver itself. I have just posted a new version for
the above series.

https://lore.kernel.org/all/20230817055405.249630-1-anshuman.khandual@arm.com/
