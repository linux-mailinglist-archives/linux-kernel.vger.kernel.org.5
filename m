Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B4808E62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443223AbjLGRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjLGRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:13:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E84E10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:13:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C3CC433C8;
        Thu,  7 Dec 2023 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701969227;
        bh=DRPKptBBmLOx5+OFyOUopYmLskN58QcplGFuspiJ3n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRSgnLgpAB2E+67FK4MbwV1WZOHG/yHsV+TYfLKc4iM9XaZRCVQKBdDHjV1Zjl2e7
         8DP/Rbh2ZreW2H2NsjROtKzxNqy7jO8bKS2ZQjn9KjHOidM6Anb4so4FRH5ihwIVWc
         4wgzzvXH/ReD0Avhsbv502RlcQhSWlqCecj7MEp2bohIBM3Lj1fBriDKWO6FiBQDlX
         vv8cYjHkpftvaL6NhK9xcb7Qw+Zre+tFwtRABPZgd/pxOpLwqu1Gf5zMhvt/Px76IE
         Keh83FDvSNNA9ul2ua+N43/vQcGuEMARNSXkX5+3riS/G0lVjgqjNpjUoZl0/dlKnV
         Avyl9oapOmRhQ==
Date:   Thu, 7 Dec 2023 17:13:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 5/6] mfd: twl4030-power: accept standard property for
 power controller
Message-ID: <20231207171341.GH111411@google.com>
References: <20231203222903.343711-1-andreas@kemnade.info>
 <20231203222903.343711-6-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231203222903.343711-6-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2023, Andreas Kemnade wrote:

> Instead of only accepting the ti specific properties accept also
> the standard property. For uniformity, search in the parent node

Search 'in' the parent node or 'from' the parent node?

Where is the property?

> for the tag. The code for powering of is also isolated from the

Should this be "off"?

> rest in this file. So it is a pure Linux design decision to put it
> here.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl4030-power.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index e35b0f788c504..3ef892e63b88f 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -686,6 +686,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
>  	if (of_property_read_bool(node, "ti,use_poweroff"))
>  		return true;
>  
> +	if (of_device_is_system_power_controller(node->parent))
> +		return true;
> +
>  	return false;
>  }
>  
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
