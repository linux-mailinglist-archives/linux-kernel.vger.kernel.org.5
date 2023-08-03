Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B376E577
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjHCKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjHCKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FB272E;
        Thu,  3 Aug 2023 03:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D65B61D2B;
        Thu,  3 Aug 2023 10:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7932EC433C8;
        Thu,  3 Aug 2023 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691057953;
        bh=fk288gRc1SQZmQ4UNdYdVEWyx6SEt1/IBnzF1eLVfv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKuiqHH0SaPukuizU7zrBiXFfJNkKfPiEWUdYta41dLkxHAwjps/TKBfe+DSyB6MU
         I0dX2deqQSnGQhzajqGvCKUeQRRexwh/R2GsJzIMsefTeY9qNXSIvVHUxVQbtMqhiu
         jkkrGoS2mJhjzbXT+YJS5ffVldA4sqHR42K8ftFk=
Date:   Thu, 3 Aug 2023 12:19:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: changes.rst: add entry for git
Message-ID: <2023080302-theology-custody-670b@gregkh>
References: <20230803090711.2261876-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803090711.2261876-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:07:10AM +0200, Rasmus Villemoes wrote:
> git is obviously used for development, directly and also
> indirectly (via checkpatch, get_maintainer and other helper
> scripts). But it is also invoked during the build to produce the
> `uname -r` string.
> 
> It's useful to have some minimal git version one can expect people to
> use. For now, set a somewhat conservative minimum of 1.8.0, which is
> already more then ten years old.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/process/changes.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 5561dae94f85..a82c619f4bb2 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build --version
>  cpio                   any              cpio --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
> +git                    1.8.0            git --version
>  ====================== ===============  ========================================
>  
>  .. [#f1] Sphinx is needed only to build the Kernel documentation
> @@ -189,6 +190,13 @@ The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
>  tag files through ``make gtags``.  This is due to its use of the gtags
>  ``-C (--directory)`` flag.
>  
> +git
> +---
> +
> +When building with CONFIG_LOCALVERSION_AUTO=y, the build system uses
> +git to produce a version string of the form
> +6.4.6-00128-gd78b7f406397, which will be shown e.g. by running `uname -r`.

Isn't this optional?  If git is not installed it just will not use git
to determine the local version.

So you should put "(optional)" above on the list of tools.

And also, don't pick a specific version like this unless it is that way
for a reason.  Why not pick a newer one?  Or the last one that the local
version script can handle properly?

thanks,

greg k-h
