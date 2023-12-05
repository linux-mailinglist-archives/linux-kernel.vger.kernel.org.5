Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C7980616C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbjLEWGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbjLEWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:05:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1A1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:05:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3334d9b57adso107439f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701813957; x=1702418757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9JeQfipl8UW5TVzZ70ugB2PN1r+4JCceO2n9SgysLY=;
        b=qD16Vi4KejSqGDYOx23NXTJYKywjUWnbXqM/gpZX2JzNkLY4Nhqi47lLXJJ8ajcE8f
         8zpQFv/D7fPNGmZLiF4MuzWDMjjOJJTv8HyPv9iTmv1imIcAFhFNV5l/ApRasLIYKLXa
         LROQmDPpkIKB8Zw0LxudzqiCjqQLgHdXJIpu3B0i6aUlTr6YvuqjuDxejqEsYlyVgBrm
         2PzDqp6Lr9x4D6dYldS2GmgBA3DZ7DpKZgs0E2vTFnJshWOlAjfRSeZlSuuRG3Qx8Ji+
         Pqn6Q4QCI7CASKeG74cHdWt79CLSReU/yeg0uI5826UtQb2QML0qc0WfLiP07mRbMED7
         6cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813957; x=1702418757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9JeQfipl8UW5TVzZ70ugB2PN1r+4JCceO2n9SgysLY=;
        b=sLgs4Kqe4PH9W+X4YNfJFRc0qIes/gvfbt81apBA7U7L9jhnAAEIKnvi8Nn623rGzt
         Q3bfJEKTx4HVPX8mww8NBWuO8Ise520/H0gbB1l6uYnIUsM6LcpxghnDKGlF5tjGPS+K
         2EX4YsBaE7pjNdPmv/m5DYnBxb57jPiO1mbu2HoP1/7QQKym4e6i/aRXFKkGzJD+CE/r
         1sTyl37bTnYE9W32LH28iN6AkALIXdrfH+y9R9t0/eg4/5D24/vv2MglbPrRiNUBQ05D
         DER0mwNC9jV2vU5fulmYzp/TJ+InUn3wO+HLSYoli6DVjBhxN/949Vv5XS+5YrHDgkC2
         Qsdw==
X-Gm-Message-State: AOJu0Yxz8jkPzRiwyRDHqlw86aaadNtlSDnb8Ra1iG6+OwHUN9+IHAVD
        5E9IbIYQrBIRUJU43aviJLB7h7t80xb8okua1zghLg==
X-Google-Smtp-Source: AGHT+IHkAJabxfpBjjJ7hbUgdJBd2Fen0CGawNzwxwjbFMg7jrNg9K9f8rvFT5xK3F8ap3VfXxDmTj52qvUE57KRoM4=
X-Received: by 2002:a5d:66ca:0:b0:333:2fd2:8153 with SMTP id
 k10-20020a5d66ca000000b003332fd28153mr4348200wrw.112.1701813957199; Tue, 05
 Dec 2023 14:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com> <ZW-b4l1llqPXW-el@smile.fi.intel.com>
In-Reply-To: <ZW-b4l1llqPXW-el@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 14:05:43 -0800
Message-ID: <CAKwvOdk+JpEC-=27EkB7inOUfB+6tLe_NREz7tryHu3vmXq7DQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:53=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> Have you checked Ingo Molnar's gigantic series (2k+ patches) for the head=
er
> hell clean up? Perhaps we need to apply that first.
>

We missed you at plumbers.  Tanzir gave a talk on this, with the
raison d'etre of this work was to see if we could help automate Ingo's
work.
https://www.youtube.com/watch?v=3DeFq_oqLiXPM
--=20
Thanks,
~Nick Desaulniers
