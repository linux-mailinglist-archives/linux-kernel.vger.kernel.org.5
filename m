Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5177A16C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHLR3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A82F5;
        Sat, 12 Aug 2023 10:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC1C619AC;
        Sat, 12 Aug 2023 17:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBFDC433C8;
        Sat, 12 Aug 2023 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691861390;
        bh=z95VPTDid2AXWp2tq5qBzlo2lL9TXka8VTEUoHvNLu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnIlxXZx6UIdo+QoboZYxV4aiG0PGQUepr9S9hG3fo5UujjhJKdBShg6XNzIYEtt4
         WvKVjs2YtwzS9F54f3GW3z95fqtWXkjmI33aCXubesEvadCLYjYnQNuDfTzE4FeLvB
         8ISC9ZAtu2KhIX/Yvhti4dt7VMQbFkMsZneD27I0=
Date:   Sat, 12 Aug 2023 19:29:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     pablo@netfilter.org, stable-commits@vger.kernel.org
Subject: Re: Patch "netfilter: nf_tables: adapt set backend to use GC
 transaction API" has been added to the 6.1-stable tree
Message-ID: <2023081229-entree-stark-7fa1@gregkh>
References: <2023081203-shining-arbitrary-323a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081203-shining-arbitrary-323a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 06:58:04PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: nf_tables: adapt set backend to use GC transaction API
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-nf_tables-adapt-set-backend-to-use-gc-transaction-api.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Oops, nope, this backport failed for 6.1 and 5.15, so I'll drop them
from there.

thanks,

greg k-h
