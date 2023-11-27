Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBE7FA540
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjK0Pwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjK0PwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:52:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9792
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:52:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E98C433C7;
        Mon, 27 Nov 2023 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701100337;
        bh=5u1FD6v6ixPZgDy+Cll9ZwyPBlwrxX8SjGva753EFHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIPkkKv9CLGKKc3kD0b1mtlSxoZoSf4b2NDd2Jpm0qDbNQpwxZlKToKjicFGQbk6f
         HNSHhf4ZTSq7IVQKS27sD8z6/3ZjJcoqy9T0LXFcz8O9j152SXOmvUEKO8s770kPIx
         ARtPWL+xbpx6SuEr+VunYzxIIrCLdMtUjsyWgYB0=
Date:   Mon, 27 Nov 2023 15:52:13 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Peter Chen <peter.chen@kernel.org>, imx@lists.linux.dev,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: cdns3: skip set TRB_IOC when usb_request:
 no_interrupt is true
Message-ID: <2023112748-coveted-enunciate-cf13@gregkh>
References: <20231027183919.664271-1-Frank.Li@nxp.com>
 <20231031084521.GA1948529@nchen-desktop>
 <ZWS1ucR7dXs153R1@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS1ucR7dXs153R1@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:28:57AM -0500, Frank Li wrote:
> On Tue, Oct 31, 2023 at 04:45:21PM +0800, Peter Chen wrote:
> > On 23-10-27 14:39:19, Frank Li wrote:
> > > No completion irq is needed if no_interrupt is true. Needn't set TRB_IOC
> > > at this case.
> > > 
> > > Check usb_request: no_interrupt and set/skip TRB_IOC in
> > > cdns3_ep_run_transfer().
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Acked-by: Peter Chen <peter.chen@kernel.org>
> 
> @Greg:
> 	ping

What are you needing from me here?  Blind pings do not provide any
context :(

thanks,

greg k-h
