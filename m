Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FE791A13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjIDOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIDOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:53:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E4CCB;
        Mon,  4 Sep 2023 07:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 866ABCE0D92;
        Mon,  4 Sep 2023 14:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79494C433C7;
        Mon,  4 Sep 2023 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693839229;
        bh=N1ZO/sEN5PRV9mYOstLjuIKb7nLtDIy62skz/gcItHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAW5XNSIpXzT9q9alS57cEzZheZE0o7BsFlOQyenYWQz0b2xlZc87Kjz29aoxYzaR
         GxmTb7LVg/dmGFCAZHWriFApJW6HvuGRT9VQod7D3nBzd4JaeJ3aF+uO5cJsxn/Biy
         Ve0HV4HaXJ/x+B873+n37eZoMwm6kLfXzQFTxYJ4=
Date:   Mon, 4 Sep 2023 15:53:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Message-ID: <2023090404-ravine-armhole-740d@gregkh>
References: <20230904125912.102225-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904125912.102225-1-git@andred.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:59:12PM +0100, André Draszik wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> 
> This patch breaks all existing userspace by requiring updates as
> mentioned in the commit message, which is not allowed.
> 
> Revert to restore compatibility with existing userspace
> implementations.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  fs/fuse/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

You forgot to cc: the original author of this change :(

With that, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
