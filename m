Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C487A7978
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjITKlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjITKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:41:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA8AB6;
        Wed, 20 Sep 2023 03:41:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD8441FB;
        Wed, 20 Sep 2023 03:41:50 -0700 (PDT)
Received: from [10.163.63.253] (unknown [10.163.63.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0713F5A1;
        Wed, 20 Sep 2023 03:41:05 -0700 (PDT)
Message-ID: <1caff361-3680-3e65-f66e-f61938242de5@arm.com>
Date:   Wed, 20 Sep 2023 16:11:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V5 - RESEND 3/3] Documentation: coresight: Add
 cc_threshold tunable
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230915093649.435163-1-anshuman.khandual@arm.com>
 <20230915093649.435163-4-anshuman.khandual@arm.com>
 <cd4e78fb-7385-6db4-b558-4599b0cdcbff@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <cd4e78fb-7385-6db4-b558-4599b0cdcbff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 14:55, Suzuki K Poulose wrote:
> On 15/09/2023 10:36, Anshuman Khandual wrote:
>> This updates config option to include 'cc_threshold' tunable value.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed by: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/trace/coresight/coresight.rst | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
>> index 4a71ea6cb390..ce55adb80b82 100644
>> --- a/Documentation/trace/coresight/coresight.rst
>> +++ b/Documentation/trace/coresight/coresight.rst
>> @@ -624,6 +624,10 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
>>      * - timestamp
>>        - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
>>          <coresight-timestamp>`
>> +   * - cc_threshold
>> +     - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
>> +       default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold
>> +       value, as indicated via TRCIDR3.CCITMIN, then the minimum value will be used instead.
>>     How to use the STM module
>>   -------------------------
> 
> The patch as such looks good to me. If possible, could you fold this into the previous patch ?

Being a documentation update, may be it's better to have this in a separate patch.
