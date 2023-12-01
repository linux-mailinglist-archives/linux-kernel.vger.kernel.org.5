Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FC800576
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbjLAI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAI1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EA170C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:27:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A530C433C7;
        Fri,  1 Dec 2023 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701419228;
        bh=YLcaKyVFQMf+8rGisK1Ar3iSw1+WcLkQobe+dx+4qNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXTKYoA9sZB6VcNCyEogwDajMNi77AV9hCyku+YfJ7yJM1ss3SnP2QnxqIx6UreZb
         9LH4npGMheRCgB4aoYyFF4ddPK9nfyMGGMBU9nZcIpe7Ps2PoBms6bW2hVRj2svOoK
         1Hw3BAT7dUIuRw/1kvseO9TR5CZZGQjALwcbxKZI=
Date:   Fri, 1 Dec 2023 08:27:05 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Message-ID: <2023120146-pyramid-salsa-d8cd@gregkh>
References: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:40:55PM +0800, Crescent CY Hsieh wrote:
> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to
> RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)

Why is this a RESEND?  What happened to the first attempt, did I miss it
somewhere?

thanks,

greg k-h
