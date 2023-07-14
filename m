Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11EA7540F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjGNRpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjGNRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:45:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DB3A87;
        Fri, 14 Jul 2023 10:45:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2319908f8f.0;
        Fri, 14 Jul 2023 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689356703; x=1691948703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ8IZ8lNs4pM9mPhnJiJ66il3qOi6HFdQct21c/MdmM=;
        b=BIT/8Qw4WSsENwEntqu8li1JhIeyfnGuk4INah5C2gJZRATQi/5hWatMBpoCH//TLx
         NrsCIiuUzg/ENxdptrTeyvRYCGrNtSO68fTFtp6mLxUOkqZ2vB/1mxps+QwY58xvR7g5
         kDzSAmOl2/epOon9ZqgBinIOHNqeXEiEtQxbkWqahFtkXlSuGXY1Bok3Ix0NL6uFbtnr
         7LHwprgle081B5el7N0aYu4jrnNCgLYcNO3sSifjOeQlBqj1MdymdRRdjXL4aHrKDUSL
         KDcMJmL4Arp9nanj9FbxJwGHWqRmesIngi2bRnyrqLa/42wSxLB+w3rnkys9C0Y9sgxU
         bYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356703; x=1691948703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ8IZ8lNs4pM9mPhnJiJ66il3qOi6HFdQct21c/MdmM=;
        b=beqP2QnwuBlvmyfqJm7xqDHaDUBse8krZjfV2DmN+Ml7GtTV/77pVZhcUy55DB13K5
         bDgcRlq1gHnxLU9sarYFeYQDksLYAauYGtJoBq6DTpxKPZPUxvSn6DarF7y94+4eUwfe
         0IROGWDIioY4ISAUHrW3pqbLCiw3SnRcTBgVxt1WbMun+uObOZSzCaFfMInSXAkdegMw
         tZGLSs1FVS50oTu36e7PgxMyCJLbK8VgDZr097h1FQwHSveMRQg54vjQh/ZQkfGYdsao
         2OhOviC8jgwEm3GEP6s1479TQDPCOSRH3uIULsvlJ8IglVQqtdwdAXaWEmqtWv2tl4rw
         Jpzg==
X-Gm-Message-State: ABy/qLbJIzDzce3fwbVL2+HY4dnXuOHs3I7O5MuZaHlGt24UNlwDhrog
        sCUz5rz/IPJRHIgU5cwgf9OZlx1Vdw==
X-Google-Smtp-Source: APBJJlHPR0EHXofkrCZdaso3z451jhgkwG0CPlBxQBlyX/lq+JyTD9+Pro49H67ErbelTVw4A5KdUg==
X-Received: by 2002:adf:de12:0:b0:315:8a13:ef16 with SMTP id b18-20020adfde12000000b003158a13ef16mr5056464wrm.69.1689356703273;
        Fri, 14 Jul 2023 10:45:03 -0700 (PDT)
Received: from p183 ([46.53.248.195])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm11423415wrr.94.2023.07.14.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:45:02 -0700 (PDT)
Date:   Fri, 14 Jul 2023 20:45:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     akpm@linux-foundation.org, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: flatten KBUILD_CFLAGS
Message-ID: <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183>
References: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183>
 <ZLEmgxm73zzmffWD@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLEmgxm73zzmffWD@fjasle.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:42:11PM +0200, Nicolas Schier wrote:
> On Thu, Jul 13, 2023 at 09:52:28PM +0300, Alexey Dobriyan wrote:
> > Make it slightly easier to see which compiler options are added and
> > removed (and not worry about column limit too!).
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  Makefile |   22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -555,11 +555,23 @@ LINUXINCLUDE    := \
> >  		$(USERINCLUDE)
> >  
> >  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
> > -KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> > -		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
> > -		   -Werror=implicit-function-declaration -Werror=implicit-int \
> > -		   -Werror=return-type -Wno-format-security -funsigned-char \
> > -		   -std=gnu11
> > +
> > +KBUILD_CFLAGS :=
> > +KBUILD_CFLAGS += -std=gnu11
> 
> If you want to put -std at top, on contrast to the sorted options below,
> you could also merge the two lines above.

I don't know. Standard choice is arguably the most important option
so I put it first.

> > +KBUILD_CFLAGS += -fshort-wchar
> > +KBUILD_CFLAGS += -funsigned-char
> > +KBUILD_CFLAGS += -fno-common
> > +KBUILD_CFLAGS += -fno-PIE
> > +KBUILD_CFLAGS += -fno-strict-aliasing
> > +KBUILD_CFLAGS += -Wall
> > +KBUILD_CFLAGS += -Wundef
> > +KBUILD_CFLAGS += -Werror=implicit-function-declaration
> > +KBUILD_CFLAGS += -Werror=implicit-int
> > +KBUILD_CFLAGS += -Werror=return-type
> > +KBUILD_CFLAGS += -Werror=strict-prototypes
> > +KBUILD_CFLAGS += -Wno-format-security
> > +KBUILD_CFLAGS += -Wno-trigraphs
