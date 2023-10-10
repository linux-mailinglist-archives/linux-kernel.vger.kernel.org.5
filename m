Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450037BF1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379405AbjJJEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:16:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BE92;
        Mon,  9 Oct 2023 21:16:01 -0700 (PDT)
Received: from [IPV6:2405:201:2033:3002:3848:5d20:59c9:c87c] (unknown [IPv6:2405:201:2033:3002:3848:5d20:59c9:c87c])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B01E43D9;
        Tue, 10 Oct 2023 06:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696911358;
        bh=zz6u7A5E/2PEqJdG/2MAXri/p5u+VkgPCjW7Gd4AjXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wBHfOY2GcV7ROlbPVNFwk7zhf+EvuPURm33g+6sQ3J46qbNa3uENsKVDeRpio8Vti
         HPAj1zxb6ip5nDCYuVyAgOb7wIJNVpfmmVT+0K1AENtdY+zPPG1d5j9Q1CwYrbjCsn
         8KBtZCSMBifFFIUm6WuqDVQfKS9E/1ka0tBjBRDA=
Message-ID: <60a729ac-541a-6e92-34f4-411f78d010ec@ideasonboard.com>
Date:   Tue, 10 Oct 2023 09:45:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] media: i2c: imx335: Fix hblank min/max values
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-5-kieran.bingham@ideasonboard.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20231010005126.3425444-5-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran

On 10/10/23 6:21 AM, Kieran Bingham wrote:
> The V4L2_CID_HBLANK control is marked as readonly and can only be a
> single value.
>
> Set the minimum and maximum value to match the mode value.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/i2c/imx335.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 026777eb362e..1a34b2a43718 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -1043,8 +1043,8 @@ static int imx335_init_controls(struct imx335 *imx335)
>   	imx335->hblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>   						&imx335_ctrl_ops,
>   						V4L2_CID_HBLANK,
> -						IMX335_REG_MIN,
> -						IMX335_REG_MAX,
> +						mode->hblank,
> +						mode->hblank,
>   						1, mode->hblank);
>   	if (imx335->hblank_ctrl)
>   		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;

