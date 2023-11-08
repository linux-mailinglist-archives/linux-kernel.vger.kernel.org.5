Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B787E54AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKHLEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:04:10 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DAD101
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:04:08 -0800 (PST)
Message-ID: <cfabc096-105d-438c-8dbc-cfaad5d18a35@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699441446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joh5s1qOPVQ3XYcvzwXMxjT9V3/OngtYecVlKL0lXmE=;
        b=JoRxj7cTTDLgtD4vAx1lnNR4DqOewp3D08ExgQ0jDVnS4xWotpC70l2qHdusXebjP934k4
        TvQBsGz1ISWdzBCDSFp9SiersCwR35p5Jfg0X37825A8pS4YhNlpcpE+nXcWWDeou/bh9x
        SwZ1p+3J01WOiwjdlEkR3BeYj7FdPQY=
Date:   Wed, 8 Nov 2023 19:04:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/3] sched/rt: Move sched_rt_entity::back to
 CONFIG_RT_GROUP_SCHED
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20231009122244.2394336-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231009122244.2394336-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kindly ping...

Thanks.


On 2023/10/9 20:22, Yajun Deng wrote:
> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED.
> It will save a few bytes.
>
> The 1st patch is introduce for_each_sched_rt_entity_back() & use it,
> it no functional changes.
>
> The 2nd patch is init 'back' in init_tg_rt_entry, it remove the call to
> back when CONFIG_RT_GROUP_SCHED is disabled.
>
> The 3rd patch is move sched_rt_entity::back to under the
> CONFIG_RT_GROUP_SCHED block, it will save a few bytes.
>
> Yajun Deng (3):
>    sched/rt: Introduce for_each_sched_rt_entity_back() & use it
>    sched/rt: Init 'back' in init_tg_rt_entry
>    sched/headers: Move sched_rt_entity::back to under the
>      CONFIG_RT_GROUP_SCHED block
>
>   include/linux/sched.h |  2 +-
>   kernel/sched/rt.c     | 17 ++++++++++++-----
>   2 files changed, 13 insertions(+), 6 deletions(-)
>
