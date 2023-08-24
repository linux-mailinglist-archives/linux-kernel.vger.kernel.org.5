Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BC7867A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbjHXGmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbjHXGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:41:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523B10FE;
        Wed, 23 Aug 2023 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1692859279; bh=rBFnYvwYPzqGHUFZqCCWa+dQfdSazS2dGEHIvTtHaDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtfWA+ItmlrDPOrkPnAXYlba9Jfrgm1JGh2nF5RmHuG4d/kzR9MsATZ7Qx8rC19dn
         1+zfVVEU/Rz6ncUewS3Po1kx+roEEt3N0kiE3UyKgooI19M7t5IZdzpc8Vs+01EMkq
         Z42CfTGJTc7hP9Pna2+pkVbbjHccT3qr8KPhPioI=
Date:   Thu, 24 Aug 2023 08:41:18 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: linux-next: manual merge of the nolibc tree with the mm-stable
 tree
Message-ID: <28aeee7b-2de5-4f39-8eb5-3e3486eeed1b@t-8ch.de>
References: <20230817133053.76d9f850@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817133053.76d9f850@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

On 2023-08-17 13:30:53+1000, Stephen Rothwell wrote:
> Today's linux-next merge of the nolibc tree got a conflict in:
> 
>   tools/include/nolibc/stdio.h
> 
> between commit:
> 
>   08d959738a95 ("selftests: line buffer test program's stdout")
> 
> from the mm-stable tree and commits:
> 
>   65ff4d19f792 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
>   2e00a8fc4f47 ("tools/nolibc: setvbuf: avoid unused parameter warnings")
> 
> from the nolibc tree.
>
> I fixed it up (I just used the latter version of this file) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

how do we want to handle this one?

A small note to Linus in the PRs to him on how to resolve it seem
reasonable to me.
But I'm fairly new to the process.

Thomas
