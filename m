Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3487A7725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjITJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjITJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:22:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65BCC83;
        Wed, 20 Sep 2023 02:22:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756B91FB;
        Wed, 20 Sep 2023 02:23:13 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDD123F5A1;
        Wed, 20 Sep 2023 02:22:34 -0700 (PDT)
Message-ID: <e29f83cc-6a00-0e5a-20ca-55d39dc2e3a3@arm.com>
Date:   Wed, 20 Sep 2023 10:22:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V5 - RESEND 2/3] coresight: etm: Make cycle count
 threshold user configurable
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230915093649.435163-1-anshuman.khandual@arm.com>
 <20230915093649.435163-3-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230915093649.435163-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:36, Anshuman Khandual wrote:
> Cycle counting is enabled, when requested and supported but with a default
> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
> representing the minimum interval between cycle count trace packets.

minor nit:

When Cycle counting is enabled, we use a default threshold value (0x100) 
for the instruction trace cycle counting.
> 
> This makes cycle threshold user configurable, from the user space via perf
> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
> in case no explicit request.

Minor nit:

This patch makes the cycle threshold user configurable via perf event
attributes( 'cc_threshold' => event->attr.config3[11:0] ), falling back
to the the current default if unspecified.



> As expected it creates a sysfs file as well.


> 
> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
> 
> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
> in 'event->attr.config1' or 'event->attr.config2'.

Trim the above part.


Rest looks fine to me.

Suzuki


