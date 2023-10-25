Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493CC7D6C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjJYMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJYMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:50:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6AC90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:50:24 -0700 (PDT)
Received: from [192.168.1.110] (unknown [103.251.226.9])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43D8F669;
        Wed, 25 Oct 2023 14:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698238208;
        bh=oYH78xkq3rGNll3M+52mpCZCqakXLm41mfL1RQ7j0So=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iC5fz81zlp9L+pLFAUdNzs5GFrC8xQoLwHWFLKiEOkoU6qwk/wm8lXydDhNdCm0lZ
         KUHdjuLi46L2jyZTwFwBerKMZSgrq+oB7U3PWWQ8Wq0tC9Hv5aRwgbqUoDqkjrcGmB
         vcn3J2nACWElO97WmwkDyhOQfk9GjzKArdDp1EG0=
Message-ID: <92b54548-6276-29c3-01af-80136c28da0c@ideasonboard.com>
Date:   Wed, 25 Oct 2023 18:20:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] staging: vc04_services: use snprintf instead of sprintf
Content-Language: en-US
To:     "Ricardo B. Marliere" <ricardo@marliere.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20231025122632.307385-4-ricardo@marliere.net>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20231025122632.307385-4-ricardo@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch

On 10/25/23 5:56 PM, Ricardo B. Marliere wrote:
> All the occurrences of sprintf usage under vc04_services can be safely
> replaced by snprintf, so as to avoid any possible overflow.
>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Umang Jain <umang.jain@ideasonboard.com>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

LGTM,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   .../bcm2835-camera/bcm2835-camera.c              |  2 +-
>   .../interface/vchiq_arm/vchiq_arm.c              | 16 ++++++++--------
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index e860fb89d42e..e6e89784d84b 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -855,7 +855,7 @@ static int vidioc_enum_input(struct file *file, void *priv,
>   		return -EINVAL;
>   
>   	inp->type = V4L2_INPUT_TYPE_CAMERA;
> -	sprintf((char *)inp->name, "Camera %u", inp->index);
> +	snprintf((char *)inp->name, sizeof(inp->name), "Camera %u", inp->index);
>   	return 0;
>   }
>   
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index de6a24304a4d..9fb8f657cc78 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1451,12 +1451,12 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>   	}
>   
>   	if (use_type == USE_TYPE_VCHIQ) {
> -		sprintf(entity, "VCHIQ:   ");
> +		snprintf(entity, sizeof(entity), "VCHIQ:   ");
>   		entity_uc = &arm_state->peer_use_count;
>   	} else if (service) {
> -		sprintf(entity, "%p4cc:%03d",
> -			&service->base.fourcc,
> -			service->client_id);
> +		snprintf(entity, sizeof(entity), "%p4cc:%03d",
> +			 &service->base.fourcc,
> +			 service->client_id);
>   		entity_uc = &service->service_use_count;
>   	} else {
>   		vchiq_log_error(state->dev, VCHIQ_SUSPEND, "%s null service ptr", __func__);
> @@ -1506,12 +1506,12 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
>   	}
>   
>   	if (service) {
> -		sprintf(entity, "%p4cc:%03d",
> -			&service->base.fourcc,
> -			service->client_id);
> +		snprintf(entity, sizeof(entity), "%p4cc:%03d",
> +			 &service->base.fourcc,
> +			 service->client_id);
>   		entity_uc = &service->service_use_count;
>   	} else {
> -		sprintf(entity, "PEER:   ");
> +		snprintf(entity, sizeof(entity), "PEER:   ");
>   		entity_uc = &arm_state->peer_use_count;
>   	}
>   

