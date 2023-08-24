Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E2786E53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjHXLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbjHXLrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0B1736;
        Thu, 24 Aug 2023 04:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D957641B6;
        Thu, 24 Aug 2023 11:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23DC433CD;
        Thu, 24 Aug 2023 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692877622;
        bh=ujlrD4Sp8quQd5NmAy54IKaq5mtGExATpmzJqrhMpfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZASipakVIkRDiJc9gemQoyx1PJon9fy172p5VL6liXqmP2xTcHuiMEaVLnpZM222
         QPHoiHVcCWNmAuEPE1k6EBija3gacj7Jaf1+PBHgLUTcS0nZhbe7UG9fNdMreflVz8
         QKdJF5+dZSEbxZMA1xZ0bnnrMPD7OEgS614eN7hM=
Date:   Thu, 24 Aug 2023 13:46:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     coolrrsh@gmail.com
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] media: gspca: UBSAN: shift-out-of-bounds in
 set_flicker
Message-ID: <2023082406-vascular-unroasted-077a@gregkh>
References: <20230824085731.9930-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824085731.9930-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:27:31PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> Syzkaller reported the following issue:
> 							
> UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27 
> shift exponent 245 is too large for 32-bit type 'int'
> 						
> When the value of the variable "sd->params.exposure.gain" exceeds the 
> number of bits in an int, a shift-out-of-bounds error occurs. The error is 
> generated when the variable "currentexp" is left-shifted by more than 31 
> bits. In order to confirm the range is valid, the conditional expression 
> was added.
> 				
> Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
> Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>							

You have loads of trailing whitespace, please fix your editor to not do
that.

> ---
> v1->v2			
> Changed the patch

In what way?  Be specific.

> v2->v3				
> Changed the commit message	

Again, be specific please.  Otherwise all changes could be listed with
these two sentances and that helps none of us out :(

> ---
>  drivers/media/usb/gspca/cpia1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
> index 46ed95483e22..dafc522d5e7b 100644
> --- a/drivers/media/usb/gspca/cpia1.c
> +++ b/drivers/media/usb/gspca/cpia1.c
> @@ -1028,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
>  			sd->params.exposure.expMode = 2;
>  			sd->exposure_status = EXPOSURE_NORMAL;
>  		}
> +		if (sd->params.exposure.gain > 31)
> +			return -1;

Why is this still -1?

greg k-h
