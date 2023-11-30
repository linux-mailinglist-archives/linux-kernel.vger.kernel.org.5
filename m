Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CEC7FEFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjK3NAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjK3NAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:00:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EFAB10C9;
        Thu, 30 Nov 2023 05:00:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C931042;
        Thu, 30 Nov 2023 05:00:52 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56963F5A1;
        Thu, 30 Nov 2023 05:00:04 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:00:02 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
        linux-arm-kernel@lists.infradead.org, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com
Subject: Re: [PATCH 3/3] firmware: arm_scmi: Increase the maximum opp count
Message-ID: <ZWiHUt-N8GvG5z_O@pluto>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
 <20231129065748.19871-4-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129065748.19871-4-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:27:48PM +0530, Sibi Sankar wrote:
> The number of opps on certain variants of the X1E80100 SoC are greater
> than current maximum, so increase the MAX_OPP count to the next log level
> to accommodate that.
> 

Hi,


> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 3344ce3a2026..edf34a3c4d6a 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -24,7 +24,7 @@
>  #include "protocols.h"
>  #include "notify.h"
>  
> -#define MAX_OPPS		16
> +#define MAX_OPPS		24
>

There is an hashtable, opps_by_freq, sized by an ilog2()....

....so, can we stick to a power-of-2 like 32 instead ?
(and be more future proof too...)

Other than this, LGTM

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
