Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34317782D22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjHUPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbjHUPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:22:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0064A109;
        Mon, 21 Aug 2023 08:22:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B6B12F4;
        Mon, 21 Aug 2023 08:23:23 -0700 (PDT)
Received: from [10.57.91.118] (unknown [10.57.91.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 345373F740;
        Mon, 21 Aug 2023 08:22:40 -0700 (PDT)
Message-ID: <7d220ae2-7758-5399-ac93-649e2062d6ed@arm.com>
Date:   Mon, 21 Aug 2023 16:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/12] PM: EM: Add update_power() callback for runtime
 modifications
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-8-lukasz.luba@arm.com>
 <47b0ee2a-c747-4b13-1729-fbbd7c7ef65d@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <47b0ee2a-c747-4b13-1729-fbbd7c7ef65d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 14:04, Dietmar Eggemann wrote:
> On 21/07/2023 17:50, Lukasz Luba wrote:
>> The Energy Model (EM) is going to support runtime modifications. This
>> new callback would be used in the upcoming EM changes. The drivers
>> or frameworks which want to modify the EM have to implement the
>> update_power() callback and provide it via EM API
>> em_dev_update_perf_domain(). The callback is then used by the EM
> 
> Looks like em_dev_update_perf_domain() hasn't been introduced yet.
> 
> [...]
> 

True, I'll remove those bits from the header.
