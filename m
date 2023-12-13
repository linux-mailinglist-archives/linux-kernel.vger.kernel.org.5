Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACE811BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjLMSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjLMSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:03:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B830EE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:03:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 475131576;
        Wed, 13 Dec 2023 10:04:17 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934103F762;
        Wed, 13 Dec 2023 10:03:28 -0800 (PST)
Message-ID: <5368ad70-1863-b19d-5334-0a5929851d4d@arm.com>
Date:   Wed, 13 Dec 2023 18:03:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 03/24] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-4-james.morse@arm.com>
 <2180a2a6-a61a-42ed-8a9c-5f77d10dc1ca@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2180a2a6-a61a-42ed-8a9c-5f77d10dc1ca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 09/11/2023 20:28, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> When monitoring is supported, each monitor and control group is allocated
>> an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
>> allocate the CLOSID.
>>
>> MPAM's equivalent of RMID are not an independent number, so can't be
>> allocated until the CLOSID is known. An RMID allocation for one CLOSID
>> may fail, whereas another may succeed depending on how many monitor
>> groups a control group has.
>>
>> The RMID allocation needs to move to be after the CLOSID has been
>> allocated.
>>
>> Move the RMID allocation and mondata dir creation to a helper, this
>> makes a subsequent change easier to read.
>>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James
