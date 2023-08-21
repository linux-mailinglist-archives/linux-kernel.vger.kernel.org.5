Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA6782E91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjHUQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:40:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C01CC;
        Mon, 21 Aug 2023 09:40:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2723C2F4;
        Mon, 21 Aug 2023 09:40:59 -0700 (PDT)
Received: from [192.168.178.99] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E839B3F64C;
        Mon, 21 Aug 2023 09:40:16 -0700 (PDT)
Message-ID: <a7699065-6c56-62f3-50a6-a939ff192420@arm.com>
Date:   Mon, 21 Aug 2023 18:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] sched: cpufreq: Move apply_dvfs_headroom() to sched.h
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-4-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230820210640.585311-4-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 23:06, Qais Yousef wrote:
> This function relies on updating util signal appropriately to give
> a headroom to grow. This is more of a scheduler functionality than
> cpufreq. Move it to sched.h where all the other util handling code
> belongs.

To me map_util_freq() is the power counterpart to fits_capacity()
[fair.c] which is used in schedutil (cpufreq) and EM to do the same*
thing as EAS in the task scheduler (fair.c).

* With the already (PATCH 1/4) mentioned difference that EAS deals with
`util_cfs` vs `capacity` whereas power deals with `util` vs `capacity_orig`.

[...]
