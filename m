Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D77B2FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjI2KJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjI2KJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:09:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8506F1AE;
        Fri, 29 Sep 2023 03:09:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A9291FB;
        Fri, 29 Sep 2023 03:10:09 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10B213F59C;
        Fri, 29 Sep 2023 03:09:28 -0700 (PDT)
Message-ID: <610b6c7d-59f5-447b-c477-d532b1d00e3c@arm.com>
Date:   Fri, 29 Sep 2023 11:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 12/18] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-13-lukasz.luba@arm.com>
 <CAJZ5v0igw77JdpoSbOkbdWxw3pwX2ejr+sv077OuQJWLLD5GxA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0igw77JdpoSbOkbdWxw3pwX2ejr+sv077OuQJWLLD5GxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 20:54, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The new Energy Model (EM) supports runtime modification of the performance
>> state table to better model the power used by the SoC. Use this new
>> feature to improve energy estimation and therefore task placement in
>> Energy Aware Scheduler (EAS).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 8f055ab356ed..41290ee2cdd0 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -261,15 +261,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>                                  unsigned long max_util, unsigned long sum_util,
>>                                  unsigned long allowed_cpu_cap)
>>   {
>> +       struct em_perf_table *runtime_table;
> 
> You may as well call it just "table".  The "runtime_" prefix doesn't
> add much value here IMO.

Yes, I'll do that

Thank you Rafael for the review of the patch set!

Regards,
Lukasz
