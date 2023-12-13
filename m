Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E9811BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378943AbjLMSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjLMSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:03:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37D5EE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:04:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9A0AC15;
        Wed, 13 Dec 2023 10:04:46 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78D313F762;
        Wed, 13 Dec 2023 10:03:58 -0800 (PST)
Message-ID: <79cdd108-d522-b1e0-6623-9c0e43534afc@arm.com>
Date:   Wed, 13 Dec 2023 18:03:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 05/24] x86/resctrl: Track the closid with the rmid
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-6-james.morse@arm.com>
 <c4e18e30-1898-471e-8065-ebb85d654084@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <c4e18e30-1898-471e-8065-ebb85d654084@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:41, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> @@ -732,10 +752,10 @@ static int dom_data_init(struct rdt_resource *r)
>>  	}
>>  
>>  	/*
>> -	 * RMID 0 is special and is always allocated. It's used for all
>> -	 * tasks that are not monitored.
>> -	 */
>> -	entry = __rmid_entry(0);
>> +	* These are used for rdtgroup_default control group, which will be
>> +	* setup later in rdtgroup_init().
> 
> This sentence I provided was intended to just replace two sentences, not the
> entire paragraph you had. Note that I explicitly stated "change last two
> sentences". Without the original text the above "These" is not clear.
> If you just want to copy&paste here is the entire intended comment:
> 
> 	RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> 	are always allocated. These are used for the rdtgroup_default
> 	control group, which will be setup later in rdtgroup_init().

Thanks! I probably got muddled with whether this was against the existing code or not.

James
