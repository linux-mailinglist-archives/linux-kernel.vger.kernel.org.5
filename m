Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A304978A4AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjH1Cpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1Cpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:45:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B96B610A;
        Sun, 27 Aug 2023 19:45:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF11C2F4;
        Sun, 27 Aug 2023 19:46:08 -0700 (PDT)
Received: from [10.163.57.227] (unknown [10.163.57.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7AC93F740;
        Sun, 27 Aug 2023 19:45:24 -0700 (PDT)
Message-ID: <529b4d7e-f4ea-e591-25eb-be3009dbea5e@arm.com>
Date:   Mon, 28 Aug 2023 08:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V5 0/3] coresight: etm: Make cycle count threshold user
 configurable
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230821045216.641499-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230821045216.641499-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 10:22, Anshuman Khandual wrote:
> This series makes ETM TRCCCCTRL based 'cc_threshold' user configurable via
> the perf event attribute. But first, this implements an errata work around
> affecting ETM TRCIDR3.CCITMIN value on certain cpus, overriding the field.
> 
> This series applies on v6.5-rc7.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in V5:
> 
> - Replaced 'where as' with single word 'whereas'
> - Reworked 'cc_threshold' fallback to ETM_CYC_THRESHOLD_DEFAULT

Any updates on this series ? Does this look okay ?
