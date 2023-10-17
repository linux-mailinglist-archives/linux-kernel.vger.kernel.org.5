Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C37CC020
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJQKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJQKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:06:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC4D8A2;
        Tue, 17 Oct 2023 03:06:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A82C2F4;
        Tue, 17 Oct 2023 03:07:01 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825A03F762;
        Tue, 17 Oct 2023 03:06:19 -0700 (PDT)
Message-ID: <44b9a917-c8e1-4166-b31a-b094eb762d2d@arm.com>
Date:   Tue, 17 Oct 2023 11:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ABI: coresight-tpdm: Fix Bit[3]
 description indentation
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CoreSight <coresight@lists.linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20231017095608.136277-1-bagasdotme@gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231017095608.136277-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 10:56, Bagas Sanjaya wrote:
> Stephen Rothwell reported htmldocs warnings when merging coresight tree:
> 
> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: ERROR: Unexpected indentation.
> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix indentation alignment for Bit[3] list entry in dsb_mode description to
> silence above warnings.
> 
> Fixes: 535d80d3c10fff ("coresight-tpdm: Add node to set dsb programming mode")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20231017143324.75387a21@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index f07218e788439d..4dd49b159543b6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -54,8 +54,8 @@ Description:
>   		Accepts the value needs to be greater than 0. What data
>   		bits do is listed below.
>   		Bit[0:1] : Test mode control bit for choosing the inputs.
> -		Bit[3] : Set to 0 for low performance mode.
> -				 Set to 1 for high performance mode.
> +		Bit[3] : Set to 0 for low performance mode. Set to 1 for high
> +		performance mode.
>   		Bit[4:8] : Select byte lane for high performance mode.
>   
>   What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_idx
> 
> base-commit: 90a7371cb08d7e542fa4f283c881973bba09f23b


Thanks, confirmed the patch to fix the issue. I have queued this to next.

   https://git.kernel.org/coresight/c/845333e5f0f3

Thanks
Suzuki
