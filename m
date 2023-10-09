Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB097BE3DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376381AbjJIPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbjJIPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:05:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8283AAC;
        Mon,  9 Oct 2023 08:05:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B52C433CA;
        Mon,  9 Oct 2023 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696863930;
        bh=v8H8KtMbRpy4gPQgyenbPvjH4WB7JHMF7vacQWWv7JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXLplTQVk/NWiWxqYYAUJGEv8qQJKeAk+HlFHjMoBKMWOrZD+eG2JsO4XKaMtLjg8
         qDcq89qZdW1LHNxWuSxiNMTDuYGLqdfB1iSxHun444yd6XEY7vDkz3XkkMSTlRjlu4
         yUCKhsXd7ccSob4n37VT24EDr3j1oVOJLs96Uu8o=
Date:   Mon, 9 Oct 2023 17:05:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 1/2] Documentation: usb: Update NCM configfs parameters
Message-ID: <2023100942-drop-down-abide-f8fe@gregkh>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009142005.21338-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:50:04PM +0530, Krishna Kurapati wrote:
> Updateed NCM configfs parameters by adding max_segment_size
> property and describing its effect on MTU configuration of
> NCM interface.

"Updated"?

> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  Documentation/usb/gadget-testing.rst | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 29072c166d23..6e5d96668e8e 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -448,15 +448,17 @@ Function-specific configfs interface
>  The function name to use when creating the function directory is "ncm".
>  The NCM function provides these attributes in its function directory:
>  
> -	=============== ==================================================
> -	ifname		network device interface name associated with this
> -			function instance
> -	qmult		queue length multiplier for high and super speed
> -	host_addr	MAC address of host's end of this
> -			Ethernet over USB link
> -	dev_addr	MAC address of device's end of this
> -			Ethernet over USB link
> -	=============== ==================================================
> +	================= ====================================================
> +	ifname		  network device interface name associated with this
> +			  function instance
> +	qmult		  queue length multiplier for high and super speed
> +	host_addr	  MAC address of host's end of this
> +			  Ethernet over USB link
> +	dev_addr	  MAC address of device's end of this
> +			  Ethernet over USB link
> +	max_segment_size  Segment size required for P2P connections. This
> +			  will inturn set MTU to (max_segment_size - 14 bytes)

"inturn"???

> +	================= ====================================================
>  

What commit id does this fix?

thanks,

greg k-h
