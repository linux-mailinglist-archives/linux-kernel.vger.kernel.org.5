Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7778B63B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjH1RSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjH1RSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:18:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B609186;
        Mon, 28 Aug 2023 10:18:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B94185AA;
        Mon, 28 Aug 2023 19:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693243026;
        bh=03vxVlD6sr18yUqkGYFb6o+RQFmVzWKaXnL88iNrzuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJjti1KWQObkAcNca/Y4otYZikjUpncibe8f/2cdIMOtpdXHjeV0mVFn3MGasHgOE
         z8QNrRaibiGfoiiEcX3gJ9tZJAa39j1678adspTmiGiiduRkqaUxbeSMsdljbc7gMc
         88uRvBpbH1G+EmIPomvByJqY+1bmhLn0BZ+tJkfo=
Date:   Mon, 28 Aug 2023 20:18:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 6/9] media: qcom: camss: Fix missing vfe_lite clocks
 check
Message-ID: <20230828171837.GA14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-7-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-7-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for the patch.


On Tue, Aug 22, 2023 at 09:06:23PM +0100, Bryan O'Donoghue wrote:
> check_clock doesn't account for vfe_lite which means that vfe_lite will
> never get validated by this routine. Add the clock name to the expected set
> to remediate.
> 
> Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 938f373bcd1fd..b021f81cef123 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -535,7 +535,8 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
>  		struct camss_clock *clock = &vfe->clock[i];
>  
>  		if (!strcmp(clock->name, "vfe0") ||
> -		    !strcmp(clock->name, "vfe1")) {
> +		    !strcmp(clock->name, "vfe1") ||
> +		    !strcmp(clock->name, "vfe_lite")) {
>  			u64 min_rate = 0;
>  			unsigned long rate;
>  

-- 
Regards,

Laurent Pinchart
