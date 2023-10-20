Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE727D13D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjJTQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJTQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:16:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67081170D;
        Fri, 20 Oct 2023 09:16:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBBDD143D;
        Fri, 20 Oct 2023 09:16:57 -0700 (PDT)
Received: from [10.57.82.142] (unknown [10.57.82.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBC823F5A1;
        Fri, 20 Oct 2023 09:16:15 -0700 (PDT)
Message-ID: <da85e126-b909-4652-9961-ed6867dc0817@arm.com>
Date:   Fri, 20 Oct 2023 17:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] thermal: gov_step_wise: Fold
 update_passive_instance() into its caller
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <13365827.uLZWGnKmhe@kreacher> <9177552.CDJkKcVGEf@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9177552.CDJkKcVGEf@kreacher>
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



On 10/6/23 18:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold update_passive_instance() into thermal_zone_trip_update() that is
> its only caller so as to make the code in question easeir to follow.

s/easeir/easier/

> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
> 

other than that LGTM:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
