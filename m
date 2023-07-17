Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97967565F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGQOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGQOMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:12:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E2F7;
        Mon, 17 Jul 2023 07:12:37 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-54-150.net.vodafone.it [5.90.54.150])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 182F32F5E;
        Mon, 17 Jul 2023 16:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689603103;
        bh=u6odHX0nTVyZUtqhWM4gMwha5SYTPCaQgQvA/jKjeCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wvb5hnEzYRJW4AjSyp7cwTL/t/StTxHMLbGH6JTsuNe4zl3ZiqEmonthk1hos7Ygs
         PRS32OCUfR6TmiGn84br+lOkS9H61Oe4hgXbctgwRM9pNSDwMsYH738oye+MUN2gTJ
         OkZjNYQpQX2oY3Sf5QpX1V28hQvQDwSYVU2WHlJ8=
Date:   Mon, 17 Jul 2023 16:12:31 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Subject: Re: [PATCH 2/3] media: subdev: Constify
 v4l2_subdev_set_routing_with_fmt() param
Message-ID: <kcantpfvjrinnzanv42woj2wlfqvedvzehzuabdmcuq2uvvwkn@3rcl2w2vvvrp>
References: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
 <20230619112707.239565-2-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619112707.239565-2-tomi.valkeinen@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi

On Mon, Jun 19, 2023 at 02:27:06PM +0300, Tomi Valkeinen wrote:
> The routing parameter of v4l2_subdev_set_routing_with_fmt() is missing
> 'const'. Add it.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 2 +-
>  include/media/v4l2-subdev.h           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index c1ac6d7a63d2..73f716a42569 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1590,7 +1590,7 @@ EXPORT_SYMBOL_GPL(__v4l2_subdev_next_active_route);
>
>  int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
>  				     struct v4l2_subdev_state *state,
> -				     struct v4l2_subdev_krouting *routing,
> +				     const struct v4l2_subdev_krouting *routing,
>  				     const struct v4l2_mbus_framefmt *fmt)
>  {
>  	struct v4l2_subdev_stream_configs *stream_configs;
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index b325df0d54d6..ca0bacb88537 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1532,7 +1532,7 @@ __v4l2_subdev_next_active_route(const struct v4l2_subdev_krouting *routing,
>   */
>  int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
>  				     struct v4l2_subdev_state *state,
> -				     struct v4l2_subdev_krouting *routing,
> +				     const struct v4l2_subdev_krouting *routing,
>  				     const struct v4l2_mbus_framefmt *fmt);
>
>  /**
> --
> 2.34.1
>
