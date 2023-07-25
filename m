Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15C762015
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGYR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGYR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F71BE1;
        Tue, 25 Jul 2023 10:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22BCF61839;
        Tue, 25 Jul 2023 17:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B55C433C8;
        Tue, 25 Jul 2023 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690306054;
        bh=CcM1IgStycED3EC2PKiW7/oey5fK8XVGM11fqAHnwvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXnFZ73GREwzmyNVPlOFvkbZgDlHBbesKIUKiXMcyp55Md7qsCMXEmF/hlur29jWS
         CDkFah8B31D/Rks/YVgvJ/bYhvbGy2A87YIxg6JTSBRFlr9IUSp/6WlQ9F3E21nWNq
         gB7XseMaLUGC9VB5SaqZS+ORGkAcRHDavz7cPI1M=
Date:   Tue, 25 Jul 2023 19:27:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart
 minor numers
Message-ID: <2023072544-cloning-footsie-65e0@gregkh>
References: <20230724063341.28198-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724063341.28198-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 11:33:41PM -0700, Randy Dunlap wrote:
> Reconcile devices.txt with serial/ucc_uart.c regarding device number
> assignments. ucc_uart.c supports 4 ports and uses minor devnums
> 46-49, so update devices.txt with that info.
> Then update ucc_uart.c's reference to the location of the devices.txt
> list in the kernel source tree.
> 
> Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCEngine UART")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/devices.txt |    2 +-
>  drivers/tty/serial/ucc_uart.c         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Very nice, thanks for catching this, I'll go queue it up.

Actually, how did you notice this?  I don't think the devices.txt file
is up to date at all anymore, and odds are, other things are wrong in it
too.

thanks,

greg k-h
