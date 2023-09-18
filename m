Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E67A4926
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbjIRMEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbjIRMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:04:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B62E4E;
        Mon, 18 Sep 2023 05:03:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B528DC433C8;
        Mon, 18 Sep 2023 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695038582;
        bh=G7wrJcmasa1xqHwbXNx/mfdxiNTOazh1lhnQ86fwHbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xCLzvzBwyOSVD7TaxgC0wOU+90j+bJrtiqNuTHLIk+V5u0fxiVyrKQD3u0NaONxoJ
         ASiHHjisAHmP0Mkmb85BsvZ8U91f/g6jwVW6khu7dshilLGCsrWdyy8Rk3YH5bDqfi
         Du1Z6Gp7EyFqIM7pUA/Je8pnQOGHD3uS2O8YM/yk=
Date:   Mon, 18 Sep 2023 14:02:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <eadavis@sina.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091846-expand-underfeed-1794@gregkh>
References: <2023091850-fever-nintendo-a2b6@gregkh>
 <20230918104836.2933871-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918104836.2933871-1-eadavis@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:48:36PM +0800, Edward AD wrote:
> When the call to gsm_register_devices() fails, we need to reclaim the memory
> requested in gsm_dlci_alloc().
> 
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <eadavis@sina.com>
> ---
>  drivers/tty/n_gsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Still failing to show up on lore.kernel.org, are you sure that your
email infrastructure is correct?

I see this header on this email message:

Authentication-Results: sina.com;
        spf=none smtp.mailfrom=eadavis@sina.com;
        dkim=none header.i=none;
        dmarc=none action=none header.from=eadavis@sina.com

So something really doesn't like your domain's emails :(

greg k-h
