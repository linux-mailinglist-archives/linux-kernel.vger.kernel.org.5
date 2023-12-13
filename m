Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5E811BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378838AbjLMSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjLMSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:03:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36C9BDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:03:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDAE7C15;
        Wed, 13 Dec 2023 10:04:10 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974B93F762;
        Wed, 13 Dec 2023 10:03:21 -0800 (PST)
Message-ID: <539bf63b-6d10-96cf-8a4b-7569474b2ae7@arm.com>
Date:   Wed, 13 Dec 2023 18:03:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
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
 <20231025180345.28061-3-james.morse@arm.com>
 <5fe8fc52-c1fd-4977-be92-901752ce8ec2@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <5fe8fc52-c1fd-4977-be92-901752ce8ec2@amd.com>
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

Hi Babu,

On 09/11/2023 20:28, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
>>
>> While the exit text ends up in the linker script's DISCARD section,
>> the direction of travel is for resctrl to be/have loadable modules.
>>
>> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
>> by rdt_get_mon_l3_config().
>>
>> There is no reason to backport this to a stable kernel.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!

James
