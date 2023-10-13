Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE67C81E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjJMJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjJMJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:22:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59005CE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:22:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F61C433C7;
        Fri, 13 Oct 2023 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188955;
        bh=0IICjsHru85+qPhGyOECjDC4TXr3Pa9V1kZA3t24K0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPKh6o7h9bPCYKzcZEVBTkwm1pPVFAj78NtQz8euMqTcj+9ce2ohdi08Dhx4F+f32
         9kCFOfBR6LaC8zXKvII1frOxnrLAVsg1xpSEn+n3q8Y+DH80IWPE9M+E+PDQuyqjh1
         EunHQe2eB82+nPv7OIn7vEPzd9Ya7kFeuMudWZmQh7ReOgzP4Ff5/nDhlRrzJVGgTx
         01jR/IKZNj112s8N8JDCijM6iDj7AosXoK4YRIIsFtAe7KMaOC0fILJrPUdvcmjeRA
         AJK20TT/wgtj3qToDtLFWZFwaCT3gYnpkWMMe1kSGiHfi8gOy9fzLFqeXFpX1+6Hsk
         lFCTcJXqL7AcQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qrENu-0003RJ-1v;
        Fri, 13 Oct 2023 11:23:07 +0200
Date:   Fri, 13 Oct 2023 11:23:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Puliang Lu <530194200.fh@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puliang Lu <puliang.lu@fibocom.com>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZSkMenm5jC9H_sxo@hovoldconsulting.com>
References: <20230901093610.67438-1-puliang.lu@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901093610.67438-1-puliang.lu@fibocom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:36:10PM +0800, Puliang Lu wrote:
> Update the USB serial option driver support for the Fibocom
> FM101R-GL
> LTE modules as there are actually several different variants.
> - VID:PID 413C:8213, FM101R-GL are laptop M.2 cards (with
> MBIM interfaces for Linux)
> - VID:PID 413C:8215, FM101R-GL ESIM are laptop M.2 cards(with
> MBIM interface for Linux)
> 
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

Could there ever be further vendor class interfaces (e.g. adb) so that
you should be using a more specific match entry?

> Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>

The SoB email does not match the sender address (e.g. as checkpatch
complains about). Could you resend this one from you fibocom account so
that it matches?

> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },

Johan
