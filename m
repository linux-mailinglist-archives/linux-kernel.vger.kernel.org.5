Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2277574EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGRHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGRHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:06:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5A1A2;
        Tue, 18 Jul 2023 00:06:06 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 432A7968;
        Tue, 18 Jul 2023 09:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689663911;
        bh=yXz2o5tHhvulQoPaP0wC4crrhLPOzgCuB8foIsgwnLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YUPIUgXnVsTPOytm4fG+mmTnBfMcvcUq0QjyJnb85v+DanNxp7vcZ9PwWYPLManoD
         zQ/I49zcEupV7X5nUnWz+XAxjcHzfja2MVm8Q9xRie5/WSja5y5iKJpBlK82tFtxBz
         ZSzyHEvxbFj72xDEtw8G4sLMRF6UWRIB7EidwFFQ=
Message-ID: <843b7912-4e99-652a-ef3f-9fbb231c4c65@ideasonboard.com>
Date:   Tue, 18 Jul 2023 10:06:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] media: i2c: No need to set device_driver owner
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230718010154.36550-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230718010154.36550-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 04:01, Yang Li wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> to silence the warning:
> ./drivers/media/i2c/ds90ub953.c:1390:3-8: No need to set .owner here.  The core will do it.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5902
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/media/i2c/ds90ub953.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index 1e3827a60029..ce1c6f8b656e 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -1387,7 +1387,6 @@ static struct i2c_driver ds90ub953_driver = {
>   	.id_table	= ub953_id,
>   	.driver = {
>   		.name	= "ds90ub953",
> -		.owner = THIS_MODULE,
>   		.of_match_table = ub953_dt_ids,
>   	},
>   };

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

