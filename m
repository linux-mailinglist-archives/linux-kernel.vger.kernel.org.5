Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5B784132
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjHVMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHVMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A4CEE;
        Tue, 22 Aug 2023 05:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7EE65608;
        Tue, 22 Aug 2023 12:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537BEC433C8;
        Tue, 22 Aug 2023 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692708584;
        bh=X754NjOjwJ6q0gfxyNpUjUOmffDCnV4RMctSkcH/LI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo1KBLfIo9oE8J2oSbhyvwYaPD2VxdW+PPA4rXvbc3hMcH/SOVG/lrh7WZvNzj9/j
         VAJvhrXSgRoEqMx3a6xqJh9k0hWmzGRH6L9rXl/TXm+r+j4ytlOzRnMxBMyan4KmF9
         wqJnT3MRDXGNFHIPXy6Frxh3b+7S/6brt4fKiI3k=
Date:   Tue, 22 Aug 2023 14:49:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Minas Harutyunyan <hminas@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH RESEND v2] usb: dwc2: add pci_device_id driver_data parse
 support
Message-ID: <2023082221-blimp-bogged-7265@gregkh>
References: <20230815065833.3375-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815065833.3375-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:58:33PM +0800, Yinbo Zhu wrote:
> The dwc2 driver has everything we need to run in PCI mode except
> for pci_device_id driver_data parse.  With that to set Loongson
> dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
> and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
> dwc2 controller will work.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v2:
> 		1. Move the dwc2 pci ID from pci_ids.h to params.c.
> 		2. Add some code logic to ensure that the current device is
> 		   a PCI device.
> 		3. Fix the compile issue when dwc2 pci driver as module.
> 
>  drivers/usb/dwc2/core.h   |  1 +
>  drivers/usb/dwc2/params.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/usb/dwc2/pci.c    | 14 +-------------
>  3 files changed, 40 insertions(+), 14 deletions(-)

Ok, in looking at this again, I guess it's the best that can be done for
now, so I'll take it.  Thanks for resending.

greg k-h
