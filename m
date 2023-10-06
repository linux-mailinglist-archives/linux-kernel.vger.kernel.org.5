Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD327BBC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjJFQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJFQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:04:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB2A6;
        Fri,  6 Oct 2023 09:04:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A72BC433C8;
        Fri,  6 Oct 2023 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696608268;
        bh=JIca2rNF7pnZk1VDUltU0QafLhtvatujIWLbLfgLEJ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FtnsFQACjd5d5AS+BffoAu44TRMwoBbkzz9y/AQuHZO1jWYXeA0rAkSzHQEaz72pk
         oIq5Af/Z4jnFY/vgaOYZbCC+Il1ACSFwgzVvGgkfcl0HIpiWnk7zC/7OdyHUuSxGTD
         vtuz8a6Iv1tyCl6WSPql5PRbFHL4Muq91AXhmCak+eh2MVf0B0vqrcbvZICOxLtPhW
         ZhIPOfsFu976YcxTUG8bEqM0SEOHOaotW3e2bjJFYsOr1Vf7jmHVa/XoKn2FzmiLAJ
         1wbItfg1AqkKrQK6yJi0mSYAFAFAC33mwWPqYDi2SezreOkVbeAG9dRAWqa1iZ6hIA
         cV/DNGulBD9qg==
Message-ID: <0b2741dd-a524-dde1-7aa3-520ce076e3c6@kernel.org>
Date:   Sat, 7 Oct 2023 01:04:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 02/26] PM / devfreq: rockchip-dfi: Embed desc into
 private data struct
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
 <20230704093242.583575-3-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-3-s.hauer@pengutronix.de>
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
> No need for an extra allocation, just embed the struct
> devfreq_event_desc into the private data struct.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 74893c06aa087..467f9f42d38f7 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -49,7 +49,7 @@ struct dmc_usage {
>   */
>  struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
> -	struct devfreq_event_desc *desc;
> +	struct devfreq_event_desc desc;
>  	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
>  	struct device *dev;
>  	void __iomem *regs;
> @@ -204,14 +204,10 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  
>  	data->dev = dev;
>  
> -	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> -	if (!desc)
> -		return -ENOMEM;
> -
> +	desc = &data->desc;
>  	desc->ops = &rockchip_dfi_ops;
>  	desc->driver_data = data;
>  	desc->name = np->name;
> -	data->desc = desc;
>  
>  	data->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
>  	if (IS_ERR(data->edev)) {

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

