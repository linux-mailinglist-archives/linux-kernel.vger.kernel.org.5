Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C07BBEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJFS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjJFS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F0106;
        Fri,  6 Oct 2023 11:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E30C433C9;
        Fri,  6 Oct 2023 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696616767;
        bh=DMnsAyUwTj54QnEen7gCvken46S4eDiVAXnoNg1seOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oa1pz1OTZt/oOkqajeiEN0hflFW2ehI8EIMVSkZYPhy7fcEOUb7ZSsWTRAp28nrPP
         JklCWOaq6FbD0G7uGVy5K/qzHyDLv4azhg0ideDhw1ptBJefMJRarfnwJV4uKUEBQ5
         jdLgsVuTiSUtCBFb+2Fm6jFEa9seNnqECjW7dwScGcG58l+orK55KZLoaeI/fApeay
         9M+wRqR38/fj5zAFIxD3u/uloiBFTWv5OwSaFtOar4eGzicdGRxsYC1+ebdHEHH6s6
         gkz9uW3a1J/+qlMvqzn+vewd/aBpMoBjAsg+nhpGnrDBMamI4gSFJ8+j8eED6ZG0d5
         F5CkIJ5UbXwPA==
Message-ID: <aa8b7d74-008d-f704-5d63-1cbaac70cf77@kernel.org>
Date:   Sat, 7 Oct 2023 03:26:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 12/26] PM / devfreq: rockchip-dfi: Handle LPDDR4X
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-13-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-13-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 4. 18:32, Sascha Hauer wrote:
> In the DFI driver LPDDR4X can be handled in the same way as LPDDR4. Add
> the missing case.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 1 +
>  include/soc/rockchip/rockchip_grf.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 16cd5365671f7..0a568c5551699 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -89,6 +89,7 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  			       dfi_regs + DDRMON_CTRL);
>  		break;
>  	case ROCKCHIP_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4X:
>  		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
>  			       dfi_regs + DDRMON_CTRL);
>  		break;
> diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/rockchip_grf.h
> index dde1a9796ccb5..e46fd72aea8d1 100644
> --- a/include/soc/rockchip/rockchip_grf.h
> +++ b/include/soc/rockchip/rockchip_grf.h
> @@ -12,6 +12,7 @@ enum {
>  	ROCKCHIP_DDRTYPE_LPDDR2	= 5,
>  	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
>  	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
> +	ROCKCHIP_DDRTYPE_LPDDR4X = 8,
>  };
>  
>  #endif /* __SOC_ROCKCHIP_GRF_H */

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

