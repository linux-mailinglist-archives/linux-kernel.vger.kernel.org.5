Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792879E3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjIMJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjIMJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10DB2196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694597800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJ+QIh3H2QPLinO4CDP/6iKCpBl9xv64ep1natwynMA=;
        b=CRGTInFr6zASshKW8fUSPJt94EphRYGpdcRCipi/xirr9cKpiNeUzZBwUwCUJBwzyVKioE
        oFDrO0cE3gF3xE57KP5qOnjwltylER1FJP+pGsRJuVDJz9y9KyzA2gKlRYtjwi0XQHbPQp
        xt4s/6tzbEiCCoFYWi14mfJY4Lxqw9A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-v7DkTYH5MDyuyTdxJfNwiA-1; Wed, 13 Sep 2023 05:36:37 -0400
X-MC-Unique: v7DkTYH5MDyuyTdxJfNwiA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ac97b9577cso1494954b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597797; x=1695202597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ+QIh3H2QPLinO4CDP/6iKCpBl9xv64ep1natwynMA=;
        b=v/xSW4lwiKp/26T6d1tkStMQVa9sNvzb1Pc6ATvABkuRAzrXCSjWfcyKg5v1Wtl33o
         uVSqryrN0w5ugGlr7NiOcglyzcq7Akka/zLrEYeU1/Z3ZDKXraNJbXzJ7QB8aZgGSZji
         6OZLs4+REdkqaaQAfIfSiivphG5/v/BggGBXqcM1wzFfn4P07L+xJkA8ESQGQ/gfpNOn
         z2ykVZ9Lfd6MRuPMZItIj4ef48Jt3+ZaZr5d15CVqsnDhzjYfl/jw+Rmz3Sm+b/Ojp7h
         Gg42vPksoMAXsWJjTollv/4jhjUCZAXf2KK2cm0EdeTYEJHeqC3ADZ82SZGI5mBLbnlu
         aXBw==
X-Gm-Message-State: AOJu0Yz5V6zU56OjSzv4oU/JrTfMRMs5U0JFAjq7ZRM4XGmgzDyK+OXj
        rjSCnp4juMXGfJ5ch4K6ncO0p6gnX0w4Vc0bSV6t3kAqgZpZUqPl3vnYEK/JjQ1K2HIEkgV1jT8
        BFimp6h0+jx/AtM6YimS81Qow5w2d/Wjx
X-Received: by 2002:a05:6808:3ce:b0:3a7:4914:23ce with SMTP id o14-20020a05680803ce00b003a7491423cemr2063425oie.18.1694597796841;
        Wed, 13 Sep 2023 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvjKOmMhtyjJ532/geuZfUf3OFFZTDFonEaSQPBLq+sck2pHXEaLfPfI857g5j08bJ8heIFQ==
X-Received: by 2002:a05:6808:3ce:b0:3a7:4914:23ce with SMTP id o14-20020a05680803ce00b003a7491423cemr2063411oie.18.1694597796633;
        Wed, 13 Sep 2023 02:36:36 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id a11-20020a05680802cb00b003a1d29f0549sm4978523oid.15.2023.09.13.02.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:36:36 -0700 (PDT)
Date:   Wed, 13 Sep 2023 06:36:31 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] scripts: Introduce a default git.orderFile
Message-ID: <ZQGCnwDMTQ6cH2ZJ@redhat.com>
References: <20230913075550.90934-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913075550.90934-2-leobras@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: linux-kbuild@vger.kernel.org
(typo on the original Cc: line)


On Wed, Sep 13, 2023 at 04:55:50AM -0300, Leonardo Bras wrote:
> When reviewing patches, it looks much nicer to have some changes shown
> before others, which allow better understanding of the patch before the
> the .c files reviewing.
> 
> Introduce a default git.orderFile, in order to help developers getting the
> best ordering easier.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> 
> Please provide feedback on what else to add / remove / reorder here!
> 
> Changes since RFCv3:
> - Added "*types.h" matching so type headers appear before reguler headers
> - Removed line ends ($) in patterns: they previously provided a 
>   false-positive
> - Fixed build patterns to allow matching Kconfig, Kbuild & Makefile
>   in any subdirectory
> 
> Changes since RFCv2:
> - Fixed licence comment to from /**/ to #
> - Fixed filename in how-to comment
> - Fix build order: Kconfig -> Kbuild -> Makefile
> - Add *.mk extension 
> - Add line-ends ($) to make sure and get the correct extensions
> - Thanks Masahiro Yamada for above suggestions!
> - 1 Ack, thanks Randy!
> 
> Changes since RFCv1:
> - Added Kconfig* (thanks Randy Dunlap!)
> - Changed Kbuild to Kbuild* (improve matching)
> 
> 
>  scripts/git.orderFile | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 scripts/git.orderFile
> 
> diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> new file mode 100644
> index 000000000000..7cef02cbba3c
> --- /dev/null
> +++ b/scripts/git.orderFile
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# order file for git, to produce patches which are easier to review
> +# by diffing the important stuff like header changes first.
> +#
> +# one-off usage:
> +#   git diff -O scripts/git.orderFile ...
> +#
> +# add to git config:
> +#   git config diff.orderFile scripts/git.orderFile
> +#
> +
> +MAINTAINERS
> +
> +# Documentation
> +Documentation/*
> +*.rst
> +
> +# build system
> +*Kconfig*
> +*Kbuild*
> +*Makefile*
> +*.mak
> +*.mk
> +
> +# semantic patches
> +*.cocci
> +
> +# headers
> +*types.h
> +*.h
> +
> +# code
> +*.c
> -- 
> 2.42.0
> 

