Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9880E761CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGYPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGYPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1154319A0;
        Tue, 25 Jul 2023 08:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A24E56178B;
        Tue, 25 Jul 2023 15:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B6BC433C8;
        Tue, 25 Jul 2023 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690297773;
        bh=JDCgR/BeSEnb2VScJG/5yHkdchlxGvrGrSVr2j8ub+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWHmvUfbaxBT7CwEmYGW6NUuxaT7yLHFszueNfe4+0KF6PnRGeCR0VVGKhAolfwRT
         tLLT6up7Kngs5+taXQ6GE280uk8+LFb63SQxr+l01Twafdan2/Za0NBu3nXr8hgBvd
         q3sY5PTLkD7wyEgAJ2+RxHqLeV2BPqx8ru8wryh8=
Date:   Tue, 25 Jul 2023 17:09:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Thinh.Nguyen@synopsys.com, andriy.shevchenko@linux.intel.com,
        imx@lists.linux.dev, jgilab@gmail.com, jun.li@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@kernel.org, quic_eserrao@quicinc.com,
        quic_prashk@quicinc.com, r-gunasekaran@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: call usb_gadget_check_config() to
 verify UDC capability
Message-ID: <2023072501-primp-grandson-7f79@gregkh>
References: <20230707230015.494999-1-Frank.Li@nxp.com>
 <ZL/eF0fZe4k63sXX@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL/eF0fZe4k63sXX@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:37:11AM -0400, Frank Li wrote:
> On Fri, Jul 07, 2023 at 07:00:14PM -0400, Frank Li wrote:
> > The legacy gadget driver omitted calling usb_gadget_check_config()
> > to ensure that the USB device controller (UDC) has adequate resources,
> > including sufficient endpoint numbers and types, to support the given
> > configuration.
> > 
> > Previously, usb_add_config() was solely invoked by the legacy gadget
> > driver. Adds the necessary usb_gadget_check_config() after the bind()
> > operation to fix the issue.
> > 
> > Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
> > Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> @greg
>         ping

It's in my review queue, please give me a chance to catch up.

While you wait, doing review of other USB patches would be most
appreciated.

thanks,

greg k-h
