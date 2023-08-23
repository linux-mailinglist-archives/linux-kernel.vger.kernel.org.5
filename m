Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED44785150
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjHWHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHWHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6720ED1;
        Wed, 23 Aug 2023 00:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 023DA61240;
        Wed, 23 Aug 2023 07:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B93EC433C9;
        Wed, 23 Aug 2023 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692774987;
        bh=TCfvKRl++7D+X/cRB1Rlpxvqm8QIrHIz4bBhA4n0cXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hi+1hcUSnOP9AQyeGi79j9JpwkomskPbu3P6qLke6Bwi8mTyiqAyPwwMtfV43FwjL
         RRpfifot6vicnHovw+CqQg5lSZdNVNTxpnB3NsKas57Ag6OQvPIAmckZDntoXUeczs
         jBGfAAIixfJSj+WQWZW/Rqwkyo8K7FSax54AbW3ywR98duI9pZ0hul+TqDRG6H5R2a
         5h8UE71ZUS2aRsKpNNU68+CSE15dJTlTAjwYu2lY5af7ZrEeOfGUNb6EdQOQHBkDWK
         Ti4qlzvuHiqJBAJA/1OoZiSekrio2GOLlSo9g+nyhpTYwrGlCxdKIkjjUffDpPdnDU
         +3mJs5k99dnSw==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qYi6J-0007U2-35;
        Wed, 23 Aug 2023 09:16:23 +0200
Date:   Wed, 23 Aug 2023 09:16:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add FOXCONN vendor and
 T99W368/T99W373  product
Message-ID: <ZOWyR6T9DP0qj8hG@hovoldconsulting.com>
References: <20230816093755.7059-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816093755.7059-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:37:55PM +0800, Slark Xiao wrote:
> With the increase of the number of Foxconn devices, we add
> a vendor name for Foxconn.

No, please drop the defines. I'm trying to move away from using such
defines as they tend just add more lines to the driver without any
value (and in any case that is a separate change which should have gone
in its own patch).

> The difference of T99W368 and
> T99W373 is the chip solution. T99W368 is designed based
> on Qualcomm SDX65 and T99W373 is SDX62.
> 
> Test evidence as below:

> Both of them share the same port configuration:
> 0&1: MBIM, 2: Modem, 3:GNSS, 4:NMEA, 5:Diag
> GNSS port don't use serial driver.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Patch looks good otherwise, but please resend without the define change.

Johan
