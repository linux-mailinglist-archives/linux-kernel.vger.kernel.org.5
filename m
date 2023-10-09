Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2467BE52E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbjJIPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjJIPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE859E;
        Mon,  9 Oct 2023 08:42:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86013C433C7;
        Mon,  9 Oct 2023 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696866127;
        bh=2mtSi2dbcAnR0GFGNL7D62vYmsOpV5Y4fVEsQuUd0SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogSBdGUzby6aA7AasCeZkWmGc60fX7E+M2Tc2BRRnPhQlOFbKfoV8SqHj1yejXNNO
         RwcWl4AlVK/rHHcdzEqk4AXkym2QlRNElhEXYC2N9ARFnrqLrEnJ+xXlrK3TO4krEX
         n/ApupIQUDh4pxhqO4S+yZBGH4YSvcuWi8+H7I9A=
Date:   Mon, 9 Oct 2023 17:42:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 1/2] Documentation: usb: Update NCM configfs parameters
Message-ID: <2023100940-shrill-unmoved-0b4e@gregkh>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <2023100942-drop-down-abide-f8fe@gregkh>
 <e8a1cde2-0df1-4cc2-a6a1-e31a2a99dae3@quicinc.com>
 <2023100954-steadier-discolor-084f@gregkh>
 <7681bac9-5b64-49cc-8e47-8d9f54d4e39f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7681bac9-5b64-49cc-8e47-8d9f54d4e39f@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:03:41PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/9/2023 8:51 PM, Greg Kroah-Hartman wrote:
> 
> > > > > diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> > > > > index 29072c166d23..6e5d96668e8e 100644
> > > > > --- a/Documentation/usb/gadget-testing.rst
> > > > > +++ b/Documentation/usb/gadget-testing.rst
> > > > > @@ -448,15 +448,17 @@ Function-specific configfs interface
> > > > >    The function name to use when creating the function directory is "ncm".
> > > > >    The NCM function provides these attributes in its function directory:
> > > > > -	=============== ==================================================
> > > > > -	ifname		network device interface name associated with this
> > > > > -			function instance
> > > > > -	qmult		queue length multiplier for high and super speed
> > > > > -	host_addr	MAC address of host's end of this
> > > > > -			Ethernet over USB link
> > > > > -	dev_addr	MAC address of device's end of this
> > > > > -			Ethernet over USB link
> > > > > -	=============== ==================================================
> > > > > +	================= ====================================================
> > > > > +	ifname		  network device interface name associated with this
> > > > > +			  function instance
> > > > > +	qmult		  queue length multiplier for high and super speed
> > > > > +	host_addr	  MAC address of host's end of this
> > > > > +			  Ethernet over USB link
> > > > > +	dev_addr	  MAC address of device's end of this
> > > > > +			  Ethernet over USB link
> > > > > +	max_segment_size  Segment size required for P2P connections. This
> > > > > +			  will inturn set MTU to (max_segment_size - 14 bytes)
> > > > 
> > > > "inturn"???
> > > > 
> > > > > +	================= ====================================================
> > > > 
> > > > What commit id does this fix?
> > > > 
> > > This is not a bug fix. It is just an addition of a new property. Does it
> > > need a fixes tag ?
> > 
> > Where is the code for the new property?
> > 
> > Ah, it's in patch 2/2, that wasn't obvious, sorry.  Why is this a
> > separate patch at all, shouldn't be part of the commit that adds the new
> > property to the system?
> > 
> 
> Sorry. I followed the practice of splitting patches like we usually do. Will
> club them up in a single patch in v2. Thanks for pointing this mistake.

Splitting is fine, but don't ask us to review documentation before the
feature is even presented, that's reading backwards :)

