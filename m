Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96C7CA17E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjJPIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D668EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:23:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D5C433C8;
        Mon, 16 Oct 2023 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697444635;
        bh=fWQiGBvgRpsRaTQ5ejv5AbcJbuEEhftS4vCnBsTePG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU6sygjzBYRaRhHy+epfx0NhmHaN01XdPLN2P2lrscOsZ0oihxRoOLbuVS/nU3OP1
         +zZkdBfPzpqpSuOW0D5HCST3NNfWGtgOsvhKOHkCIKDxio/8jRtN4v6BOfxvtNtSMa
         24wn1D3fMR5liJmBrg0RkZhZvm67+82jasW0wiR9v+j4R8jKPLkrSqBxlcdsLkwDIF
         xS+l43x66Xidgz1SJCZycMsN8IqEAHmgasLUJEYFnvCAnXRUtpDxASqSmsJfWgoHus
         sQgbXqIqFVYFdiKuJW0Wcf0c2QNwv5Fj1KcSF/lfw9Vy5se/00NJA/BrWBaaFznR2e
         Ic4gjUGBr4K3Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsItC-0001rU-03;
        Mon, 16 Oct 2023 10:23:50 +0200
Date:   Mon, 16 Oct 2023 10:23:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?TC3psoHnkp7kuq4=?= <puliang.lu@fibocom.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZSzzFvmATauo_6aH@hovoldconsulting.com>
References: <20231016073616.519051-1-puliang.lu@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016073616.519051-1-puliang.lu@fibocom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:36:16PM +0800, L-鲁璞亮 wrote:
> From: Puliang Lu <puliang.lu@fibocom.com>
> 
> Update the USB serial option driver support for the Fibocom
> FM101R-GL

> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=413c ProdID=8213 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=a3b7cbf0
> C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Thanks for resending with the author address fixed.

You did however not answer my question whether there could ever be more
vendor class interfaces (e.g. for adb) so that you should be using a
more specific match for the entries (i.e. USB_DEVICE_AND_INTERFACE_INFO())?

> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },

Johan
