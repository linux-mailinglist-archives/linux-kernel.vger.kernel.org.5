Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DE79B56B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjIKVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIKJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:21:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17724CD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:21:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38A6D75;
        Mon, 11 Sep 2023 02:21:56 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31243F5A1;
        Mon, 11 Sep 2023 02:21:18 -0700 (PDT)
Message-ID: <3c326e7c-4f82-2f40-d92d-8928d8cf773b@arm.com>
Date:   Mon, 11 Sep 2023 10:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] coresight: etm4x: Add ACPI id for THEAD YiTian SOC
Content-Language: en-US
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        Jay Chen <jkchen@linux.alibaba.com>
References: <20230911072509.126063-1-tianruidong@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230911072509.126063-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 08:25, Ruidong Tian wrote:
> From: Jay Chen <jkchen@linux.alibaba.com>
> 
> Add support for detcting ETE device of THEAD YiTian SOC.
> 
> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 77b0271ce6eb..329bb554b168 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2351,6 +2351,7 @@ static const struct of_device_id etm4_sysreg_match[] = {
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id etm4x_acpi_ids[] = {
>   	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
> +	{"BABA6000", 0 }, /* THEAD CoreSight ETE */

Why don't we use ARMHC500 for the ETE ? See :

https://developer.arm.com/documentation/den0067/latest/

Suzuki


>   	{}
>   };
>   MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);

