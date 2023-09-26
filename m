Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7967AF4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjIZUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:16:14 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ACE11D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:16:04 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 0F026182831;
        Tue, 26 Sep 2023 22:16:02 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695759362; bh=qg4uJRGlDM//cSpe/BH2eb2fQtlSCaa1XtxBmbpGvj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=3B52f4ZxT8ZrNkYu5yc9Wnx9Kafo/SmGYDYpKoeTn3ZgJ3m/+x4LAowuOmtHaHdQ7
         HWAPzmmsU3GLtW1F+DcHVPj3HAZRImtDwhx/49lAdbvTJlrsLZvtYFXbHSK62zFmUS
         9bGowutIkENi/EeiBAvHNZ4m+UeFH+phn3WAJCYi2rxP0W7GgQYPSy+unVyUGW5JWu
         uTfriO50AZMkOW/SAtsObXnIRMAGM1DR8zVCyf3A89ZOi/JXMpmhEdvCMK5bLCrzRt
         T2wqGdgQ8SO1w+IZnbsPj1dBat7R7Kc+j5Yz1ZUXhDM+WipZyZWkOC24cUVIK+OsT4
         Zmrv2S82HpXSw==
Date:   Tue, 26 Sep 2023 22:16:00 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] checkpatch: warn about multi-line comments without
 an empty /* line
Message-ID: <20230926221521.08f4a64d@meshulam.tesarici.cz>
In-Reply-To: <1adcfeaa4bd01d59a349daa697cc007e81bc81b1.camel@perches.com>
References: <20230926192400.19366-1-petr@tesarici.cz>
        <1adcfeaa4bd01d59a349daa697cc007e81bc81b1.camel@perches.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 12:56:33 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2023-09-26 at 21:24 +0200, Petr Tesarik wrote:
> > According to Documentation/process/coding-style.rst, the preferred style
> > for multi-line comments outside net/ and drivers/net/ is:
> > 
> > .. code-block:: c
> > 
> >         /*
> >          * This is the preferred style for multi-line
> >          * comments in the Linux kernel source code.
> >          * Please use it consistently.
> >          *
> >          * Description:  A column of asterisks on the left side,
> >          * with beginning and ending almost-blank lines.
> >          */
> > 
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl  
> []
> > @@ -4006,6 +4006,14 @@ sub process {
> >  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> >  		}
> >  
> > +# Non-networking without an initial /*
> > +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> > +		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> > +		    $rawline =~ /^\+[ \t]*\*/) {
> > +			WARN("BLOCK_COMMENT_STYLE",
> > +			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
> > +		}
> > +
> >  # Block comments use * on subsequent lines
> >  		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
> >  		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*  
> 
> Still nack.  Too many existing instances.
> 
> $ git grep '/\*.*' -- '*.[ch]' | \
>   grep -v '/\*.*\*/' | \
>   grep -v -P "/\*\s*$" | \
>   grep -v '/\*\*' | \
>   grep -v "SPDX-License" | \
>   grep -v -P '^drivers/net|^net/' | \
>   wc -l
> 51834

Um. Not everything that is currently found in the source tree would be
accepted as new code by today's standards...

As it stands, the script checks the special case for net/ and
drivers/net/ but does not help prevent unnecessary respins, like this
one:

https://lore.kernel.org/linux-iommu/ZRMgObTMkfq8Bjbe@arm.com/

OTOH if we don't want to warn about multi-line comments, maybe we don't
want to call it the preferred style, and the corresponding paragraph
should be removed from coding-style.rst. Do you suggest I try that
instead?

Petr T
