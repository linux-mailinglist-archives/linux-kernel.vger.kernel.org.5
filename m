Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DD7DC64F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjJaGMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjJaGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197B125
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:12:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40E1C433CB;
        Tue, 31 Oct 2023 05:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698731678;
        bh=XbuXcOofB+YYRpzkpEc0cY0O+v3jQnt9AfKHu8wLDNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2pk7oQ8OQJofOOofISvUW+jJEHoj29SYT6GffWr7gbgZL7jLiBZv1AHj26RAL7hL
         z/83Twn6THDhyRXHZIh3dqf7jtr4Y8zB46kvfl+11DWxDCx//U9GYnXhzrAuIBLVf2
         BKn9oYExNzO4Lrcjc5eKmdb7sLnQ6NZsNZz6y7mE=
Date:   Tue, 31 Oct 2023 06:54:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naveen Kumar <mnkumar@google.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, royluo@google.com
Subject: Re: [PATCH 2/2] dt-bindings: usb: add no-64-bit-support property
Message-ID: <2023103104-stamp-amniotic-369d@gregkh>
References: <20231031044021.1162403-1-mnkumar@google.com>
 <20231031044021.1162403-3-mnkumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031044021.1162403-3-mnkumar@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:40:21AM +0000, Naveen Kumar wrote:
> From: Naveen Kumar M <mnkumar@google.com>
> 
> Add a new DT option to specify whether a host controller is able to
> support 64-bit DMA memory pointers
> 
> Signed-off-by: Naveen Kumar M <mnkumar@google.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> index 180a261c3e8f..20dc134004f3 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> @@ -25,6 +25,10 @@ properties:
>      description: Set if the controller has broken port disable mechanism
>      type: boolean
>  
> +  quirk-no-64-bit-support:
> +    description: Set if the xHC doesn't support 64-bit DMA memory pointers
> +    type: boolean
> +
>    imod-interval-ns:
>      description: Interrupt moderation interval
>      default: 5000
> -- 
> 2.42.0.820.g83a721a137-goog
> 
> 

You did not send this patch to all of the relevant
maintainers/reviewers, why not?

please always use scripts/get_maintainer.pl on your patches.

thanks,

greg k-h
