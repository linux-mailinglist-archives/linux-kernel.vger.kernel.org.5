Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D17CDA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjJRL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJRL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:27:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07361112;
        Wed, 18 Oct 2023 04:27:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB33D2F4;
        Wed, 18 Oct 2023 04:27:51 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9053F762;
        Wed, 18 Oct 2023 04:27:06 -0700 (PDT)
Message-ID: <688adbc9-6dbc-4c98-971e-630525ff003b@arm.com>
Date:   Wed, 18 Oct 2023 12:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] consolidate and cleanup CPU capacity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        bsegall@google.com, dietmar.eggemann@arm.com, peterz@infradead.org,
        mingo@redhat.com, rafael@kernel.org, sudeep.holla@arm.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pierre.gondois@arm.com,
        ionela.voinescu@arm.com, viresh.kumar@linaro.org,
        bristot@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, ajones@ventanamicro.com, lftan@kernel.org,
        gregkh@linuxfoundation.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, vschneid@redhat.com
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231009103621.374412-1-vincent.guittot@linaro.org>
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
> This is the 1st part of consolidating how the max compute capacity is
> used in the scheduler and how we calculate the frequency for a level of
> utilization.
> 
> Fix some unconsistancy when computing frequency for an utilization. There
> can be a mismatch between energy model and schedutil.
> 
> Next step will be to make a difference between the original
> max compute capacity of a CPU and what is currently available when
> there is a capping applying forever (i.e. seconds or more).
> 
> 

I have tested the patches apart from the last CPPC because the platform
didn't have that. The EAS is working OK, so feel free to add:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

apart from the patch 6/6 - with the cppc changes

Regards,
Lukasz
