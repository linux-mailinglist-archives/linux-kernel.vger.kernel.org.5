Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7D77FF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355111AbjHQVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355190AbjHQVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:00:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA13589
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:00:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68876bbecb6so203812b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306023; x=1692910823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhLwc7xQLPESRCxP9cY2dRoWyo/uIWL5/zNyN8Kqxec=;
        b=EnAKlgW8FYD5e6HhBU+4lBzbTLRh96q9G/sfwmuHxDIy/fPFXW6cK3VzECXmuWV83M
         Ry2Ca5T0UeXdBnJ4PQk6OAEqPwCNt7a4Czs7zFaEarG0jIUwI+0eQf7qooIlMktdsMao
         2dA62Aryoy/83VDJ7XVp6jPTap/jRA04DmAmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306023; x=1692910823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhLwc7xQLPESRCxP9cY2dRoWyo/uIWL5/zNyN8Kqxec=;
        b=HLRR6oON9E5KqaF35lz0x1lJO1AAYiByCtezfmcFH6bPwYxbOIK6qAUm8b68qX0WKc
         +dxEc8rxwwRSYCQGknWO7P0E3gebe1yifojoNOfOsVOQ7lSbb+MoX4LQ8bngGEnApd/g
         QPTegU8NhE5278lg18Kgwwc6wypV0brLmvOZTAXg9jNcDOry3MzlcxfJnBnqqjKa7qJl
         ahPYAjnTsRm5Q0aLIXX4vtf81NiLkriI4QHoGy7pIpoKs5NubVuxX5XderOvgh9hi/fy
         y5OhVbAqN1C1SZ3NaZQKHOG1KKKd0t0g6nBIBxHNt8ekj2pPAgHyk9zA4A3ePkARjIw6
         TCZQ==
X-Gm-Message-State: AOJu0Yx61KNGOCKMFB29725ww2WvRMmEIJlPmaVI8wxirKT85HDotKFv
        YrsuQcsZHBK5j6nzvk3ijtas/Q==
X-Google-Smtp-Source: AGHT+IEBApN15WOV5S+yy1lPD2G37EeX+VsF/wDV48HSCd3SmjrIkyLYMIXgOcLc9eFnr2LOrEbroA==
X-Received: by 2002:a05:6a00:846:b0:686:290b:91f7 with SMTP id q6-20020a056a00084600b00686290b91f7mr751465pfk.22.1692306023451;
        Thu, 17 Aug 2023 14:00:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78d19000000b0063b96574b8bsm180644pfe.220.2023.08.17.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:00:23 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:00:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and
 identifier expansion
Message-ID: <202308171400.4A37659A2D@keescook>
References: <20230817200558.never.077-kees@kernel.org>
 <20230817201304.GA2714089@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817201304.GA2714089@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:13:04PM -0700, Nathan Chancellor wrote:
> On Thu, Aug 17, 2023 at 01:06:03PM -0700, Kees Cook wrote:
> > GCC and Clang's current RFCs name this attribute "counted_by", and have
> > moved away from using a string for the member name. Update the kernel's
> > macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> > that will gain annotations.
> > 
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> One comment below.
> 
> > ---
> >  include/linux/compiler_attributes.h | 26 +++++++++++++-------------
> >  include/uapi/linux/stddef.h         |  4 ++++
> >  2 files changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> > index 00efa35c350f..74716a407aac 100644
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -94,6 +94,19 @@
> >  # define __copy(symbol)
> >  #endif
> >  
> > +/*
> > + * Optional: only supported since gcc >= 14
> > + * Optional: only supported since clang >= 17
> 
> Since you are in the area, should the supported clang version be
> optimistically updated to '18'? 17.x has already branched and I suspect
> it would be too late in the release cycle to cherry-pick that change
> from main if it were landed today (which seems pretty unlikely, given
> there do not appear to be many reviews from high profile clang folks
> yet).

Oops, yes. Excellent point. I'll bump this to 18.

-Kees

> 
> > + *
> > + *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> > + * clang: https://reviews.llvm.org/D148381
> > + */
> > +#if __has_attribute(__counted_by__)
> > +# define __counted_by(member)		__attribute__((__counted_by__(member)))
> > +#else
> > +# define __counted_by(member)
> > +#endif
> > +
> >  /*
> >   * Optional: not supported by gcc
> >   * Optional: only supported since clang >= 14.0
> > @@ -129,19 +142,6 @@
> >  # define __designated_init
> >  #endif
> >  
> > -/*
> > - * Optional: only supported since gcc >= 14
> > - * Optional: only supported since clang >= 17
> > - *
> > - *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> > - * clang: https://reviews.llvm.org/D148381
> > - */
> > -#if __has_attribute(__element_count__)
> > -# define __counted_by(member)		__attribute__((__element_count__(#member)))
> > -#else
> > -# define __counted_by(member)
> > -#endif
> > -
> >  /*
> >   * Optional: only supported since clang >= 14.0
> >   *
> > diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> > index 7837ba4fe728..7c3fc3980881 100644
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -45,3 +45,7 @@
> >  		TYPE NAME[]; \
> >  	}
> >  #endif
> > +
> > +#ifndef __counted_by
> > +#define __counted_by(m)
> > +#endif
> > -- 
> > 2.34.1
> > 

-- 
Kees Cook
