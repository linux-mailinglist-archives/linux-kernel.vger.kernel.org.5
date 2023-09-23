Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371117ABDA0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjIWDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIWDt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:49:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21991A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:49:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c46b30a1ceso28845235ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695440962; x=1696045762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avM5LlsDA73WnR3UrffkZ0OMPeQzuORhxY0IwjP+1Cs=;
        b=DUc4JHBSkMF1iURo1YUoZRxsf8a+znZWIIcxLn+WMjxOrRLATDgWr/pxAXfpApV9nz
         aXuwqPz2qBYSzUjgNAxLE4Bk5gXMzkbjRq6kLPJWWv8Y6op5/ReL19HdTf8p5xwW4Xk7
         lFtO153lsHRqKEAvXXd66gexHleqkOUM30xmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695440962; x=1696045762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avM5LlsDA73WnR3UrffkZ0OMPeQzuORhxY0IwjP+1Cs=;
        b=s2UcO1rlMtt5ir9WlmL4slAgMIdPkLLSWo5mYbBxxL65avZih1W1SYT+knJT/SR82l
         J5VoMvIUJIsZUsT8lyKob9/snCdlJZVtTEDF84G54YYVfl6MQyatu5bJOFjb5lju9iKd
         qmHD2YdA8M8ayHVDzM0S3ajW7yG32TPv7wHnAKFGvtvmUcl9F3ca8dlJ/kHzrViwBTpT
         lMXjgvOgfNFSzPiQcm011nChnXlIrra9bIa2dPOKOlWFq+XA1z8M86x34yKEzN77Jn3/
         3lMBxaLXp9L+OJQksJVsOcbxKYGfVUrgDMseuDLMsiEltEb46FF3DbNdjUGd860YJ0JU
         WXcw==
X-Gm-Message-State: AOJu0Yzs0cSTZABEr31uD6scusvSTdj5Mh0R+relJtekfGHr1Xd4kPiy
        1RGVZcdHQ9bixXJr23NdRjH+Ag==
X-Google-Smtp-Source: AGHT+IHE9L/Ls29q6YetpIw6y6dSYetPlIprop/PC5rY4Yxt4+q0LWG5/cvVYSfmPVV36KNZQ+jQmg==
X-Received: by 2002:a17:903:41c2:b0:1c5:cd1c:4705 with SMTP id u2-20020a17090341c200b001c5cd1c4705mr1632517ple.10.1695440962307;
        Fri, 22 Sep 2023 20:49:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b001ab39cd875csm547209plb.133.2023.09.22.20.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 20:49:21 -0700 (PDT)
Date:   Fri, 22 Sep 2023 20:49:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
Message-ID: <202309222034.F2B777F55@keescook>
References: <202309220957.927ADC0586@keescook>
 <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 04:55:45PM -0700, Linus Torvalds wrote:
> On Fri, 22 Sept 2023 at 09:59, Kees Cook <keescook@chromium.org> wrote:
> >
> > - Fix UAPI stddef.h to avoid C++-ism (Alexey Dobriyan)
> 
> Ugh. Did we really have to make two different versions of that define?
> 
> Ok, so C++ did something stupid wrt an empty struct. Fine.
> 
> But I think we could have still shared the same definition by just
> using the same 'zero-sized array' trick, regardless of any 'empty
> struct has a size in C++'.
> 
> IOW, wouldn't this just work universally, without any "two completely
> different versions" hack?
> 
> #define __DECLARE_FLEX_ARRAY(TYPE, NAME)        \
>         struct { \
>                 char __empty_ ## NAME[0]; \
>                 TYPE NAME[]; \
>         }
> 
> I didn't test. I'm just hating on that '#ifdef __cplusplus'.

Yeah, I had same thought[1], but in the end I left it the way Alexey
suggested for one decent reason, and one weak reason:

1) As discovered[2] while porting this helper to ACPICA, using a flexible
   array in a struct like this does not fly with MSVC, so for MSVC
   ingesting UAPI, having the separate struct is likely more robust.

2) __cplusplus is relatively common in UAPI headers already:
   $ git grep __cplusplus -- include/uapi | wc -l
   58

-Kees

[1] https://lore.kernel.org/all/202309151208.C99747375@keescook/
[2] https://github.com/acpica/acpica/pull/837

-- 
Kees Cook
