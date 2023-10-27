Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D897D9597
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjJ0KvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjJ0KvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA41C18F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:51:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F8FC433C7;
        Fri, 27 Oct 2023 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698403867;
        bh=JrM3Szuj+NfQM6WkAlL4tN0ivyNbl22j2w9isdZSxhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UASXaaCkSALRhcaqTuX2fJ7aL7JzbpPABnkMNnbp+4mw94VKuxjvjRT67crsv2Plv
         p2mAakjxAuvcdOx4xgEcmBz6eYoLULfRiyjwBWxzsQRLTVfW+2Lnj317yyYELOyIYe
         DkI58Ii+1BK20IFLRrVH3TQuCSE9Zd9H9NUr7Nlo=
Date:   Fri, 27 Oct 2023 12:51:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: set the dma max_seg_size
Message-ID: <2023102753-spirits-aerobics-c2c6@gregkh>
References: <20231026-dwc3-v1-1-643c74771599@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-dwc3-v1-1-643c74771599@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:28:36PM +0000, Ricardo Ribalda wrote:
> Allow devices to have dma operations beyond 4K, and avoid warnings such
> as:
> 
> DMA-API: dwc3 a600000.usb: mapping sg segment longer than device claims to support [len=86016] [max=65536]
> 
> Reported-by: Zubin Mithra <zsm@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Found while running 
> yavta -f YUYV -s 1280x720 -c  /dev/video0
> 
> with:
> 
> CONFIG_DMA_API_DEBUG=y
> ---
>  drivers/usb/dwc3/core.c | 2 ++
>  1 file changed, 2 insertions(+)

What commit id does this fix?

thanks,

greg k-h
