Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755E7AC3CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjIWQyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjIWQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:54:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB183
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:53:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so481579766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695488035; x=1696092835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9idSD5kuTZEOLquvpMoF3lumweU5BKvHfzaz/Vt4ZY=;
        b=LLlxHN8WDm0EnNl/A1FambzQIKGwXDsaiDd3Fv9YVhRbP+2ro379fjuL+OZxdwze8C
         WqsVM6+CuxLaIE7ujB7VCC/3gxthTGiVM2feWD4RVNPm2UWvZAXxcOrCoSqq45KwPvZz
         hylyR2frh1v/scEnVtYVDKLTaOSSwJashFCaOPWPXbMeVHYQcnyeqJ60zqhFpr7YUfXI
         bFt9jH/HsP9KE0SMUIJRKIdSd9C7qqHAZNB4RDJw92lycYEsLlR8s43ym609Zb888eFM
         N4TP8bOLrSR/QVgvWpM/8LkAm2XcwsnomkloT0KY+rAgeN2mlVMczXUVBVxT+LCW9NIv
         jSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695488035; x=1696092835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9idSD5kuTZEOLquvpMoF3lumweU5BKvHfzaz/Vt4ZY=;
        b=LBHkXXpI3L2JXevU2XBufKNpPdYjR62YVgAOu/uw58ulMy8WcLvrAVoS4BXeLbzJyZ
         PxDC9XXspQTG+NvLprV5njhiA1zc2+ciqkipzg5u8nytdrKAJfEao9/SkXsFsz4nMxQn
         s1Bij/xmfv7Iv03bUpoHOA5ljJRi6bbGGPTsUv0kuHo3QQOBO6jiWOrNw7IoaBf0AsZx
         JonOQ8Kz3r6Ox4j8EMafQukzJifVWu8bnEc/nYGAb4brODFQ3RRDgzhjPC137teueEVr
         P0vdWKPTipjf0BPSfxzHGUtn2QNqsVuGcsqR1svmtAHbzu3Dt/GJuH1TvTaSoMFZrjR7
         yhcA==
X-Gm-Message-State: AOJu0YyKs263ase0UcwAaaIXEjT5RxVDoHLQhoM14JMwHn4EFzq+om3s
        8Pzg0tSM9x4RKW/83CBBzg==
X-Google-Smtp-Source: AGHT+IHwkdNGU9RNoJ5NGKCmj3qRYQBmxi88QR7COlA9o9SGbr0LlLNQZiedpNG+RHWL0QkwX6Phbg==
X-Received: by 2002:a17:906:3111:b0:9ae:4f13:e581 with SMTP id 17-20020a170906311100b009ae4f13e581mr2118591ejx.59.1695488034560;
        Sat, 23 Sep 2023 09:53:54 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id lg15-20020a170906f88f00b0099d0a8ccb5fsm4056886ejb.152.2023.09.23.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 09:53:54 -0700 (PDT)
Date:   Sat, 23 Sep 2023 19:53:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
Message-ID: <2983cda7-f084-4eb2-811d-158f43e99e47@p183>
References: <202309220957.927ADC0586@keescook>
 <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

This doesn't work with g++ :-(

#undef __DECLARE_FLEX_ARRAY
#define __DECLARE_FLEX_ARRAY(TYPE, NAME)        \
	struct { \
		char __empty_ ## NAME[0]; \
		TYPE NAME[]; \
	}

struct S1 {
	__DECLARE_FLEX_ARRAY(int, x);
};

main.cc:79:35: error: flexible array member ‘S1::<unnamed struct>::x’ in an otherwise empty ‘struct S1’
   79 |         __DECLARE_FLEX_ARRAY(int, x);
