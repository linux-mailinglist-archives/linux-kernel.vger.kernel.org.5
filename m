Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E812EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444169AbjLNLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444083AbjLNLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:38:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4CA1181
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:38:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 228F211FB;
        Thu, 14 Dec 2023 03:39:18 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19F123F738;
        Thu, 14 Dec 2023 03:38:29 -0800 (PST)
Message-ID: <08b75c00-0451-e395-4bc7-11eacaf6a5dd@arm.com>
Date:   Thu, 14 Dec 2023 11:38:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-22-james.morse@arm.com>
 <6f90a9c6-d474-4173-9f74-a51675b10e6f@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <6f90a9c6-d474-4173-9f74-a51675b10e6f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 09/11/2023 20:51, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> When a CPU is taken offline resctrl may need to move the overflow or
>> limbo handlers to run on a different CPU.
>>
>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>> will be called while the CPU that is going offline is still present
>> in the cpu_mask.
>>
>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>> mbm_setup_overflow_handler(). These functions can use a variant of
>> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
>> need excluding.
>>
>> A subsequent patch moves these calls to be before CPUs have been removed,
>> so this exclude_cpus behaviour is temporary.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James
