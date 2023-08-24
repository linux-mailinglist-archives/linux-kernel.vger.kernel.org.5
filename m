Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF2787643
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbjHXQ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbjHXQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:59:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E3BE199D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:58:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47ADF1042;
        Thu, 24 Aug 2023 09:59:34 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4A93F64C;
        Thu, 24 Aug 2023 09:58:51 -0700 (PDT)
Message-ID: <2a98184e-7a21-6201-6027-d58d7c82fa81@arm.com>
Date:   Thu, 24 Aug 2023 17:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
References: <20230728164254.27562-1-james.morse@arm.com>
 <CALPaoCgyOKS4mURO2RGTnDoocoAf65xqNYLipAXHkNJXdPJV_Q@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgyOKS4mURO2RGTnDoocoAf65xqNYLipAXHkNJXdPJV_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 22/08/2023 09:42, Peter Newman wrote:
> I ran this series successfully against our internal test suites on the
> following processors:
> 
> - Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz
> - AMD EPYC 7B12 64-Core Processor
> 
> Tested-By: Peter Newman <peternewman@google.com>

Great, Thanks!

James

