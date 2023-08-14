Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2777BCF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHNP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjHNPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310E10C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FDDF61696
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E6C433C7;
        Mon, 14 Aug 2023 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692026751;
        bh=FO5zCQ9Aaqj1NS7OYkS2u8nCHSNUw8PdooF5SOw4v+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4tkYcxc+OPe6SWSa8P9ZhQtHCLm7sboRNJ7foxlBmZ2WcwsyPwVLCnH3nqGkLkDW
         B9c7nzOJBnW7q6t/ZV+WHiKHW3n6VC2hAXBHlPbuYkqrR0fEakVFpAzDBjLHeD9NTJ
         AiXUSkUOjkEuD6zI/fhLPaQg37APlAaOqcbvux4I=
Date:   Mon, 14 Aug 2023 17:25:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michele Dalle Rive <dallerivemichele@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <2023081411-apache-tubeless-7bb3@gregkh>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814092302.1903203-1-dallerivemichele@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:22:55AM +0200, Michele Dalle Rive wrote:
> This patch series is intended to create Rust abstractions for Sockets
> and other fundamental network entities. 
> 
> Specifically, it was added:
> - Ip address and Socket address wrappers (for `in_addr`, `in6_addr`,
>   `sockaddr_in`, `sockaddr_in6`, `sockaddr_storage`).
> - Socket wrapper.
> - Socket flags and options enums.
> - TCP and UDP specific abstractions over the Rust Socket structure.
> 
> This series is a RFC because I would appreciate some feedback about:
> - The structure of the module: is the division of the files and modules
>   appropriate or should it be more or less fine-grained?
>   Also, should the `net` module export all the structures of its
>   submodules? I noticed that it is done in the standard library.
> - Whether the documentation is comprehensive enough.
> - A few other specific questions, written in the individual patches.
> 
> I would greatly appreciate any kind of feedback or opinion. 
> I am pretty new to the patch/mailing list world, so please point out any
> mistake I might make.

The best feedback is "who will use these new interfaces?"  Without that,
it's really hard to review a patchset as it's difficult to see how the
bindings will be used, right?

thanks,

greg k-h
