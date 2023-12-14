Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81F812EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444030AbjLNLiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444073AbjLNLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:38:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 195AA183
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:38:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ADA2C15;
        Thu, 14 Dec 2023 03:39:12 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AD43F738;
        Thu, 14 Dec 2023 03:38:24 -0800 (PST)
Message-ID: <dbecf6f1-4d51-c61d-a092-a85f9ab464ea@arm.com>
Date:   Thu, 14 Dec 2023 11:38:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 20/24] x86/resctrl: Add CPU online callback for resctrl
 work
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
 <20231025180345.28061-21-james.morse@arm.com>
 <a8725d37-e3f5-4fd4-a426-b03b143a3b26@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <a8725d37-e3f5-4fd4-a426-b03b143a3b26@amd.com>
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
>> The resctrl architecture specific code may need to create a domain when
>> a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
>> The resctrl filesystem code needs to update the rdtgroup_default CPU
>> mask when CPUs are brought online.
>>
>> Currently this is all done in one function, resctrl_online_cpu().
>> This will need to be split into architecture and filesystem parts
>> before resctrl can be moved to /fs/.
>>
>> Pull the rdtgroup_default update work out as a filesystem specific
>> cpu_online helper. resctrl_online_cpu() is the obvious name for this,
>> which means the version in core.c needs renaming.
>>
>> resctrl_online_cpu() is called by the arch code once it has done the
>> work to add the new CPU to any domains.
>>
>> In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
>> itself.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James
