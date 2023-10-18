Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A07CD79F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJRJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:15:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 405F0F9;
        Wed, 18 Oct 2023 02:15:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC89F2F4;
        Wed, 18 Oct 2023 02:16:17 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6462B3F64C;
        Wed, 18 Oct 2023 02:15:32 -0700 (PDT)
Message-ID: <d2ac3963-9c91-4256-a1e3-ea5990848c1e@arm.com>
Date:   Wed, 18 Oct 2023 10:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] energy_model: use a fixed reference frequency
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     dietmar.eggemann@arm.com, bristot@redhat.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com,
        rostedt@goodmis.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, suagrfillet@gmail.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        vschneid@redhat.com, ajones@ventanamicro.com,
        catalin.marinas@arm.com, linux@armlinux.org.uk,
        linux-riscv@lists.infradead.org, pierre.gondois@arm.com,
        lftan@kernel.org, linux-kernel@vger.kernel.org, bsegall@google.com,
        mingo@redhat.com, rafael@kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, mgorman@suse.de, will@kernel.org,
        sudeep.holla@arm.com
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-6-vincent.guittot@linaro.org>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231009103621.374412-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,


On 10/9/23 11:36, Vincent Guittot wrote:
> The last item of a performance domain is not always the performance point
> that has been used to compute CPU's capacity. This can lead to different
> target frequency compared with other part of the system like schedutil and
> would result in wrong energy estimation.
> 
> A new arch_scale_freq_ref() is available to return a fixed and coherent
> frequency reference that can be used when computing the CPU's frequency
> for an level of utilization. Use this function to get this reference
> frequency.
> 
> Energy model is never used without defining arch_scale_freq_ref() but
> can be compiled. Define a default arch_scale_freq_ref() returning 0
> in such case.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/energy_model.h | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 

LGTM, taking into account the patch 2/6 that we don't include any
boost freq (so no changes w.r.t. current EAS situation)

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
