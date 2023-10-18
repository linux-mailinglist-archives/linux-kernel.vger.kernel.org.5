Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8D7CDA16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJRLPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:15:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE30F10F;
        Wed, 18 Oct 2023 04:15:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D11E2F4;
        Wed, 18 Oct 2023 04:15:58 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE113F762;
        Wed, 18 Oct 2023 04:15:12 -0700 (PDT)
Message-ID: <efa322b1-136a-4755-9abe-f808d6e8f4b1@arm.com>
Date:   Wed, 18 Oct 2023 12:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] cpufreq: use the fixed and coherent frequency for
 scaling capacity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        juri.lelli@redhat.com, aou@eecs.berkeley.edu,
        ajones@ventanamicro.com, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, rostedt@goodmis.org,
        will@kernel.org, ionela.voinescu@arm.com, pierre.gondois@arm.com,
        viresh.kumar@linaro.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, bristot@redhat.com,
        dietmar.eggemann@arm.com, lftan@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        linux-riscv@lists.infradead.org, mgorman@suse.de,
        bsegall@google.com, vschneid@redhat.com, linux@armlinux.org.uk,
        sudeep.holla@arm.com, rafael@kernel.org
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-4-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231009103621.374412-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 11:36, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different from the frequency that has been
> used to compute the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> that can be used to compute the capacity for a given frequency.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++--
>   include/linux/cpufreq.h   | 9 +++++++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
