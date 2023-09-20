Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1C7A798F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjITKpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjITKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:45:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E82EA1B9;
        Wed, 20 Sep 2023 03:45:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B98951FB;
        Wed, 20 Sep 2023 03:45:39 -0700 (PDT)
Received: from [10.163.63.253] (unknown [10.163.63.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84ACA3F5A1;
        Wed, 20 Sep 2023 03:44:59 -0700 (PDT)
Message-ID: <21bc7889-e456-e95b-7155-2563f1b6c3e4@arm.com>
Date:   Wed, 20 Sep 2023 16:14:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V5 - RESEND 2/3] coresight: etm: Make cycle count
 threshold user configurable
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230915093649.435163-1-anshuman.khandual@arm.com>
 <20230915093649.435163-3-anshuman.khandual@arm.com>
 <e29f83cc-6a00-0e5a-20ca-55d39dc2e3a3@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <e29f83cc-6a00-0e5a-20ca-55d39dc2e3a3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 14:52, Suzuki K Poulose wrote:
> On 15/09/2023 10:36, Anshuman Khandual wrote:
>> Cycle counting is enabled, when requested and supported but with a default
>> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
>> representing the minimum interval between cycle count trace packets.
> 
> minor nit:
> 
> When Cycle counting is enabled, we use a default threshold value (0x100) for the instruction trace cycle counting.
>>
>> This makes cycle threshold user configurable, from the user space via perf
>> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
>> in case no explicit request.
> 
> Minor nit:
> 
> This patch makes the cycle threshold user configurable via perf event
> attributes( 'cc_threshold' => event->attr.config3[11:0] ), falling back
> to the the current default if unspecified.
> 
> 
> 
>> As expected it creates a sysfs file as well.
> 
> 
>>
>> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
>>
>> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
>> in 'event->attr.config1' or 'event->attr.config2'.
> 
> Trim the above part.
> 
> 
> Rest looks fine to me.

Will change the commit message as follows.


    coresight: etm: Make cycle count threshold user configurable
    
    When cycle counting is enabled, we use a default threshold value i.e 0x100
    for the instruction trace cycle counting.
    
    This patch makes the cycle threshold user configurable via perf event
    attributes( 'cc_threshold' => event->attr.config3[11:0] ), falling back
    to the current default if unspecified.
