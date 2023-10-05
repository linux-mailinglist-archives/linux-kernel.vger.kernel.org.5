Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA43A7BA0A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbjJEOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjJEOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9527C3F025
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:01:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36419C116B6;
        Thu,  5 Oct 2023 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696514369;
        bh=yjYdr6NMBB3N4qwB1LomEzfwhBRh5oJTamUwrfSI7OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv/AR6JkSGeFIqnlvX/drtjCXMOJLu7iGRRabEsczdjGjHPumeaL14UkUNumGcccb
         IZfT7lvUQiSii+Qj50KUaQeE1RHc0J/khpg/N1wnp1QN6m70mZxWtWP6ye+vG4aXM9
         kd3IHzcf78Vb+ZTlUNm0tg3hWRCbruWm8prlVHPU=
Date:   Thu, 5 Oct 2023 15:59:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     Thinh.Nguyen@synopsys.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix possible object reference leak
Message-ID: <2023100512-crayon-prowess-0f27@gregkh>
References: <tencent_6BA8EA125537CBB5D65B05605E1E960AA708@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6BA8EA125537CBB5D65B05605E1E960AA708@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:49:46PM +0800, Zhang Shurong wrote:
> The of_find_device_by_node takes a reference to the struct device
> when find the match device,we should release it when fail.
> 
> Fix it by calling by calling platform_device_put when error returns.
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---

What commit id does this fix?

And how did you find this?  How was it tested?

thanks,

greg k-h
