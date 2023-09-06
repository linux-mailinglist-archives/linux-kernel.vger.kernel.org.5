Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A1793A08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjIFKhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjIFKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B71CF4;
        Wed,  6 Sep 2023 03:37:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B302FC433C8;
        Wed,  6 Sep 2023 10:37:38 +0000 (UTC)
Message-ID: <5e18a8ae-0657-edc8-b15d-decd81fa82d4@xs4all.nl>
Date:   Wed, 6 Sep 2023 12:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/3] media: Add 10, 12, and 16 bit RGB formats
Content-Language: en-US, nl
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-2-pan@semihalf.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230630144006.1513270-2-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 16:40, Paweł Anikiel wrote:
> Add the RGB30U, RGB30L, RGB36U, RGB36L, and RGB48 pixel formats.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 5 +++++
>  include/uapi/linux/videodev2.h       | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index a858acea6547..5ee616704225 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1300,6 +1300,11 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
>  	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
>  	case V4L2_PIX_FMT_ABGR64_12:	descr = "12-bit Depth BGRA"; break;
> +	case V4L2_PIX_FMT_RGB30U:	descr = "30-bit RXGXBX-10-10-10"; break;
> +	case V4L2_PIX_FMT_RGB30L:	descr = "30-bit XRXGXB-10-10-10"; break;
> +	case V4L2_PIX_FMT_RGB36U:	descr = "36-bit RXGXBX-12-12-12"; break;
> +	case V4L2_PIX_FMT_RGB36L:	descr = "36-bit XRXGXB-12-12-12"; break;
> +	case V4L2_PIX_FMT_RGB48:	descr = "48-bit RGB-16-16-16"; break;
>  	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index aee75eb9e686..3568819eabeb 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -583,6 +583,11 @@ struct v4l2_pix_format {
>  /* RGB formats (6 or 8 bytes per pixel) */
>  #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
>  #define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
> +#define V4L2_PIX_FMT_RGB30U  v4l2_fourcc('R', '3', '0', 'U') /* 30  RXGXBX-10-10-10 */
> +#define V4L2_PIX_FMT_RGB30L  v4l2_fourcc('R', '3', '0', 'L') /* 30  XRXGXB-10-10-10 */
> +#define V4L2_PIX_FMT_RGB36U  v4l2_fourcc('R', '3', '6', 'U') /* 36  RXGXBX-12-12-12 */
> +#define V4L2_PIX_FMT_RGB36L  v4l2_fourcc('R', '3', '6', 'L') /* 36  XRXGXB-12-12-12 */
> +#define V4L2_PIX_FMT_RGB48   v4l2_fourcc('R', 'G', 'B', '6') /* 48  RGB-16-16-16    */
>  
>  /* Grey formats */
>  #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */

These new formats also need to be documented in (probably) pixfmt-rgb.rst.

Regards,

	Hans
