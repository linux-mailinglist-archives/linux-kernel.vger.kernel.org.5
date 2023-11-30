Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7C7FF067
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjK3Nmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjK3Nme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:42:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7171310FF;
        Thu, 30 Nov 2023 05:42:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C7F1042;
        Thu, 30 Nov 2023 05:43:26 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9424A3F5A1;
        Thu, 30 Nov 2023 05:42:37 -0800 (PST)
Message-ID: <242c8dfd-9030-43a5-abae-ae6e348dec5c@arm.com>
Date:   Thu, 30 Nov 2023 14:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, corbet@lwn.net, alexs@kernel.org,
        siyanteng@loongson.cn, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231127143238.1216582-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 15:32, Vincent Guittot wrote:
> sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
> in order to check for possibly related regressions. After 3 years, it has
> never been used and no regression has been reported. Let remove it
> and make fast increase a permanent behavior.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> I haven't updated the chinese documentation which also refers to
> UTIL_EST_FASTUP. IIUC, this will be updated afterward by the 
> Translations' maintainers.
> 
>  Documentation/scheduler/schedutil.rst | 7 +++----
>  kernel/sched/fair.c                   | 8 +++-----
>  kernel/sched/features.h               | 1 -
>  3 files changed, 6 insertions(+), 10 deletions(-)

LGTM.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

