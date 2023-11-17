Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D67EF3CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjKQNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1BD5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:46:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B91C433C8;
        Fri, 17 Nov 2023 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700228766;
        bh=ktdPd545ypOk5AeKiYVdmHQBmIBcRw2iJERqnxbHOrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/QSuwEYdpWhRgd55gSgIJwk+s+xGg5wK+559QU6cG2qcWsRUsSdXWtA3prAgf66s
         w8Bl4Ll9q6ywDINxz/yoeZ/JfXSMVt+DbND6liWl4s5z5HKOSNJrq+zWilLr/Tm/6d
         nBwwXYYJ3Gc6DvWt95Coy101B9tyERUV2OSHEkcw=
Date:   Fri, 17 Nov 2023 08:45:59 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
Message-ID: <2023111720-slicer-exes-7d9f@gregkh>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:27:53AM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> This patch was initially submitted as part of a net patch series.
> Conor expressed interest in using it in a different subsystem.
> Consequently, I extracted it from the series and submitted it separately
> to the main tree, driver-core.
> https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/

So you want me to take it through my tree?  Sure, but if you are relying
on this for any other code, it will be a while before it gets into
Linus's tree, not until 6.8-rc1, is that ok?

thanks,

greg k-h
