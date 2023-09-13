Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917479F1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjIMTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjIMTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:19:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075D170F;
        Wed, 13 Sep 2023 12:19:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B82C433C7;
        Wed, 13 Sep 2023 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632745;
        bh=STPt0r2LX8P4oMatOWW2VAU1UKNgpuQ1Zb3/5nSIrxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPr+ZS+S7Wz04A/8ZRdxf68wdQxR2LqO/5h0YNHATF+yC43xUr3o2rpXxNuPn0cQV
         5AmxTvVSp8gIrjbF+SRguYy+EXqcaUSYXZRZfy4trnat+Uj2A+Wi2EEhWaPW4H8JpU
         BWzGrTAXUje7B83uAS+0hVOuFIWm0GG2l0rCLR8E=
Date:   Wed, 13 Sep 2023 21:19:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-usb@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: USB: DMA: mapping existing buffer is not supported?
Message-ID: <2023091323-trombone-storeroom-cbd3@gregkh>
References: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:06:58AM +0800, Randy Li wrote:
> Hello
> 
> I was trying to understand why USB webcams (UVC) have to copy video data
> through the CPU (uvc_video_complete() schedules uvc_video_copy_data_work()
> for this purpose). During my investigation, I noticed that functions
> like|usb_sg_*() and |usb_buffer_*() are not available since kernel version
> 2.6.12.

What do you mean by "not available"?  I see them in the tree today, why
do you think they are not present?

> I can comprehend that USB host controllers such as xHCI, commonly found in
> embedded implementations like dwc3, do not support IOMMU. However, this
> should not prevent them from operating on a contiguous buffer.

Are you sure that the protocol for these devices allow this?

> If the USB subsystem can no longer work with existing buffers, I propose
> that we consider removing the remaining documentation in the "Working with
> existing buffers" section of Documentation/driver-api/usb/dma.rst.

I don't understand, what is wrong with the information there exactly?
Have you tried following the suggestions there?

thanks,

greg k-h
