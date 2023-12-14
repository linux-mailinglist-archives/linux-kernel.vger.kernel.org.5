Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53AD812ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444149AbjLNLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444085AbjLNLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:39:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FEB71FFD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:39:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B630C11FB;
        Thu, 14 Dec 2023 03:39:55 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3CD3F738;
        Thu, 14 Dec 2023 03:39:07 -0800 (PST)
Message-ID: <425c0051-e63f-6810-ee60-6ae3203da543@arm.com>
Date:   Thu, 14 Dec 2023 11:39:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 22/24] x86/resctrl: Add CPU offline callback for
 resctrl work
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
 <20231025180345.28061-23-james.morse@arm.com>
 <0d70d735-a4ba-4bc0-8f3d-24e31c870566@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <0d70d735-a4ba-4bc0-8f3d-24e31c870566@amd.com>
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

On 09/11/2023 20:52, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> The resctrl architecture specific code may need to free a domain when
>> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
>> Amongst other things, the resctrl filesystem code needs to clear this
>> CPU from the cpu_mask of any control and monitor groups.
>>
>> Currently this is all done in core.c and called from
>> resctrl_offline_cpu(), making the split between architecture and
>> filesystem code unclear.
>>
>> Move the filesystem work to remove the CPU from the control and monitor
>> groups into a filesystem helper called resctrl_offline_cpu(), and rename
>> the one in core.c resctrl_arch_offline_cpu().

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James

