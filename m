Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7027DC65D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjJaGRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjJaGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:17:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3E135;
        Mon, 30 Oct 2023 23:17:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA54C433C8;
        Tue, 31 Oct 2023 06:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698732113;
        bh=Ouks7YL8qEvhhj00F9KoJxz0wclvbYVkN8O0xfJllHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EexCCr+X3vclZHcCt+2OqAjyBLieUxdwOACWR6iEA9pQNCpMt7Hu4z3HDjH4NcXSh
         2rnu6nfBbyl3SpIUUx7EUfl9CKvzDd1bdzQ85W5Zh84P+X/awLKWJnSYgiScMb+r2D
         ipjAs0zGdueeDXpUBMtjMrywn1QSeExxLULS2wPs=
Date:   Tue, 31 Oct 2023 07:01:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Message-ID: <2023103132-handcart-union-fbe1@gregkh>
References: <20231030182044.14056-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030182044.14056-1-rwahl@gmx.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:20:44PM +0100, Ronald Wahl wrote:
> This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
> interrupt after DMA enable") which unfortunately set the
> UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
> cleared it.
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

Can you please add a proper "Fixes:" tag?

thanks,

greg k-h
