Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED278415F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjHVM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjHVM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5333ACC6;
        Tue, 22 Aug 2023 05:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D830E6562A;
        Tue, 22 Aug 2023 12:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ED0C433C7;
        Tue, 22 Aug 2023 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709115;
        bh=J+zAD2cb5RM0CTTV8jJjql+PDmHDI1/1EyjfkxinMgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCGm6BTKnf+Gxi1gPnxFgY3Cl37bQ4E3ABMBr94SVuqnVmBoLdAIczkWiJ3JDHCk7
         Rg0DxefbThSUpf+Lyj0AdW0bYzjCQt2coX0qV5LyXKJVN5Tptdi7hOzt8cxHd6nKZz
         Kvu21r1j3nQw+lvw1KkWWv9SwSyp34vNO8v2p5WQ=
Date:   Tue, 22 Aug 2023 14:58:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] tty: tty_buffer: cleanup
Message-ID: <2023082223-alongside-snuff-b0eb@gregkh>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:55:20PM +0200, Jiri Slaby (SUSE) wrote:
> This is another part (say part II.) of the previous type unification
> across the tty layer[1]. This time, in tty_buffer. Apart from type
> changes, this series contains a larger set of refactoring of the code.
> Namely, unification of byte stuffing into the tty buffers into a single
> function.
> 
> [1] https://lore.kernel.org/all/20230810091510.13006-1-jirislaby@kernel.org/
> 
> Jiri Slaby (SUSE) (10):
>   tty: tty_buffer: switch data type to u8
>   tty: tty_buffer: use struct_size() in tty_buffer_alloc()
>   tty: tty_buffer: unify tty_insert_flip_string_{fixed_flag,flags}()
>   tty: tty_buffer: warn if losing flags in
>     __tty_insert_flip_string_flags()
>   tty: tty_buffer: switch insert functions to size_t
>   tty: tty_buffer: let tty_prepare_flip_string() return size_t
>   tty: tty_buffer: use __tty_insert_flip_string_flags() in
>     tty_insert_flip_char()
>   tty: tty_buffer: better types in __tty_buffer_request_room()
>   tty: tty_buffer: initialize variables in initializers already
>   tty: tty_buffer: invert conditions in __tty_buffer_request_room()
> 
>  Documentation/driver-api/tty/tty_buffer.rst |   7 +-
>  drivers/tty/tty_buffer.c                    | 169 ++++++--------------
>  include/linux/tty_buffer.h                  |   4 +-
>  include/linux/tty_flip.h                    |  64 ++++++--
>  4 files changed, 111 insertions(+), 133 deletions(-)
> 
> -- 
> 2.41.0
> 

Nice work, thanks, all now queued up.

greg k-h
