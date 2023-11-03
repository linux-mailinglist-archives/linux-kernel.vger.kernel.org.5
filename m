Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0027E0588
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKCP0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC689112
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:26:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305CDC433C8;
        Fri,  3 Nov 2023 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699025203;
        bh=XJ7Bs/+V7BeLxlzjtBTK45mi2154iurCY5DvcmsIQPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNn9k/ze+T4kYowcJM08Y+Pe5wNT1xDEiVm/6xMgv7d6s140j95A2jv5vgO+LVerr
         hCJYyxPNv+dqin9hSHFCQDcWzL0HPIWQJ47YC6vKWymA2HMQhw7mvrVG4ebJYT7SOw
         wu6okgxZ9s/kvQaPe+0YYvseaZxJjwps3V5K2Qmg=
Date:   Fri, 3 Nov 2023 16:26:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        stern@rowland.harvard.edu, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, s.shtylyov@omp.ru
Subject: Re: [PATCH v7 1/2] usb: xhci: Add timeout argument in address_device
 USB HCD callback
Message-ID: <2023110341-decode-atonable-64b4@gregkh>
References: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
 <aa328f6d-be12-45ef-42dd-2b4dc0821771@linux.intel.com>
 <20231103151822.GA101660@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103151822.GA101660@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:18:22PM +0100, Hardik Gajjar wrote:
> On Mon, Oct 30, 2023 at 12:45:54PM +0200, Mathias Nyman wrote:
> > On 27.10.2023 18.20, Hardik Gajjar wrote:
> > > - The HCD address_device callback now accepts a user-defined timeout value
> > >    in milliseconds, providing better control over command execution times.
> > > - The default timeout value for the address_device command has been set
> > >    to 5000 ms, aligning with the USB 3.2 specification. However, this
> > >    timeout can be adjusted as needed.
> > > - The xhci_setup_device function has been updated to accept the timeout
> > >    value, allowing it to specify the maximum wait time for the command
> > >    operation to complete.
> > > - The hub driver has also been updated to accommodate the newly added
> > >    timeout parameter during the SET_ADDRESS request.
> > > 
> > > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > 
> > For the xhci parts
> > 
> > Reviewed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > 
> >
> 
> @Greg KH, Friendly reminder.

It is the m iddle of the merge window, my branches are closed for
obvious reasons until after -rc1 is out.  Please relax and wait for a
week or so _after_ -rc1 is out before worrying about anything.

thanks,

greg k-h
