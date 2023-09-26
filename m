Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EB7AE9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjIZJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjIZJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:55:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDDA97
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:55:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D3DC43397;
        Tue, 26 Sep 2023 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695722122;
        bh=UA2HDifKUdwsi/zkGFkYbsAGo4+HXJrEWsaFTV+5WE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8xKE2gmLaanjpmhW/SVshk+Ue8b6pBpio74a+fqFRKwfco9d92TAYa5sWUNc51uO
         YnUpK7vKYuN6Wsa0zOu161rGFxJJ0jDwglfUzsieW8PfuWdCu5c3vtZUurnQ9iP5dp
         ly+EMMkcKkGYv6if1g/vdXmVgWyFrzIkz9NE56/M=
Date:   Tue, 26 Sep 2023 11:55:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Message-ID: <2023092602-zen-legal-4910@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <6127727d-cb4e-7729-5216-83c93fbb22ee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6127727d-cb4e-7729-5216-83c93fbb22ee@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 03:18:58PM +0530, Gupta, Nipun wrote:
> Hi Greg,
> 
> On 9/11/2023 7:22 PM, Nipun Gupta wrote:
> > Add CDX-MSI domain per CDX controller with gic-its domain as
> > a parent, to support MSI for CDX devices. CDX devices allocate
> > MSIs from the CDX domain. Also, introduce APIs to alloc and free
> > IRQs for CDX domain.
> > 
> > In CDX subsystem firmware is a controller for all devices and
> > their configuration. CDX bus controller sends all the write_msi_msg
> > commands to firmware running on RPU and the firmware interfaces with
> > actual devices to pass this information to devices
> > 
> > Since, CDX controller is the only way to communicate with the Firmware
> > for MSI write info, CDX domain per controller required in contrast to
> > having a CDX domain per device.
> > 
> > Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> 
> Please help in making progress on this patch. Is there anything that needs
> to be updated in this patch for CDX bus?

$ mdfrm -c ~/mail/todo/
2031 messages in /home/gregkh/mail/todo/

So perhaps help in reviewing other pending patches for other subsystems?
It's in my queue, but have been traveling for 2 weeks for conferences,
will be catching up next week when I get a chance.

Also, you need to get the msi/interrupt developers to agree with this,
why not get their review and acceptance first?

thanks,

greg k-h
