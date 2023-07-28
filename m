Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217D1766AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjG1KqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjG1KqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B1A0;
        Fri, 28 Jul 2023 03:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3F6620D9;
        Fri, 28 Jul 2023 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91ADC433C7;
        Fri, 28 Jul 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690541162;
        bh=Aw9zQDUwmF8mcqYjQGFVNqVy+2g4jvxNOf80m5uLU30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TafXzI+Aat/LZKgWiGZ9YJDetnYPd/hpYKMBSWEpGQln02GXg+GYn0rFEpP1r4tBF
         cRhbWEeytqWEQAKmXzdQ9PduXxkEUPg8JDIGSIXMuERr26N76IEZqZ1qF6vufkM6LI
         /mJ0vjJQCF6Mu1cHKvWHLxzWMuyWtMX7mUPabP4I=
Date:   Fri, 28 Jul 2023 12:45:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Surong Pang <surong.pang@unisoc.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson.Zhai@unisoc.com,
        Zhiyong.liu@unisoc.com, Surong.Pang@gmail.com
Subject: Re: [PATCH] usb: dwc3: gadget: let pm runtime get/put paired
Message-ID: <2023072844-ceremony-lushness-c229@gregkh>
References: <20230728073919.6473-1-surong.pang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728073919.6473-1-surong.pang@unisoc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 03:39:19PM +0800, Surong Pang wrote:
> Pm_runtime_get is called when setting pending_events to true.
> Pm_runtime_put is needed for pairing with pm_runtime_get.
> 
> Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> ---
>  drivers/usb/dwc3/gadget.c | 1 +
>  1 file changed, 1 insertion(+)

What commit id does this fix?

thanks,

greg k-h
