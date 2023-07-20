Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD275B76F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGTTHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGTTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:07:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09D1995;
        Thu, 20 Jul 2023 12:07:26 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5835388d632so12403497b3.3;
        Thu, 20 Jul 2023 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689880045; x=1690484845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFGZ0mwXTeUqARUMUq3sQSk0x6e1HExlGw80JssPQUw=;
        b=Z7hnhUdsWEFTGhk1OsUf9G8QQkdXeKfIRYnEaf91NwQKZe8jZJ2CfbMY5U66Xouz5y
         EBGbEkS8/tPQGyv+feI64Rb2oHNV5zWis2Bj26Fi+Imsb0eZhn0uKtCCvVE2fgyps9Vi
         pJoabEJxbHPyEKhIOODWd3/FkofjsI4P7pFWl79TJmsFx7cTNKKcgq3NQnD1FA8ZXGba
         dX61CdR5o6CryzTyVKYvWczrOzTdeg9HMP0XCIKYOd8mVVqCHh6QrJEfIAMf053V747Q
         ikzfGEHbBXoLne/VjZDTrFgvPiDq6l0L8+QBuFnp2CgNR7eL31eLcU5wUhAnw4IX9wRj
         UWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880045; x=1690484845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFGZ0mwXTeUqARUMUq3sQSk0x6e1HExlGw80JssPQUw=;
        b=jSQbskUmLLZ/Y/wR+vFjOqI0VXZsmBkc2wdeztHa2PWyXsuPRsJ5KZYfX9QqA8V/AC
         Cq6WrV0vV3Oxhs9mP2HK8m4WtgaZzjXBJRAq8LNkyD3LpA8mo2rNR1kGYpzwsgmlSoJb
         bqILLdKrtxU5G3bdCei7TPUY1m+Q7nu9a+7cgbXG87kf2eXIcrZYwrFHrThaVmXPR6ft
         eeaibeiC15ol5vOgD05gonDnu35oM9h53yFPQXYmvjbIsycC/PZUE0mlyQKV3FL3XG+3
         raApso3m6OqzMkkosMEpVf6dW/rmTsMVO6urvd3P9Lo3KwAA9MER+uQKrNx0d+rutlMg
         5ayQ==
X-Gm-Message-State: ABy/qLZ3TbnJf3SD/AXPDDeLrL6UHwZMTy5AxjGahx1SD1WsOGCZk+Qe
        SEQPX/lIHNGglPlxIdRb4t91fjWM/hPJ6bsJWCV/1e0P+38=
X-Google-Smtp-Source: APBJJlF9ppbPX2AeRPFxmzKndNSuspJ/IuHls/gQr5dwwf+h7v/ZafMhblxWP8TLYBBGq1qBNuMHCmHSrG4v/yGJTNs=
X-Received: by 2002:a25:13c8:0:b0:c84:3aa2:f0e7 with SMTP id
 191-20020a2513c8000000b00c843aa2f0e7mr2646480ybt.27.1689880045703; Thu, 20
 Jul 2023 12:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230718151534.4067460-1-carlos.bilbao@amd.com> <20230718151534.4067460-2-carlos.bilbao@amd.com>
In-Reply-To: <20230718151534.4067460-2-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 21:07:12 +0200
Message-ID: <CANiq72nqTnao=Xm=vA_OWb7sss02WhwTsj37HpKSz2bSF+4pdA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] docs: Move rustdoc output, cross-reference it
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        rust-for-linux@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 5:15=E2=80=AFPM Carlos Bilbao <carlos.bilbao@amd.co=
m> wrote:
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Just in case: does this Reviewed-by still apply? (and the one in the
other commit)

> +.. only:: rustdoc and html
> +
> +       You can also browse `rustdoc documentation <rustdoc/kernel/index.=
html>`_.
> +
> +.. only:: not rustdoc and html
> +
> +       This documentation does not include rustdoc generated information=
.
> +

(I will move here a couple notes from v7 to avoid losing them, since
we were discussing there and then v8 was sent.)

I would move this to its own commit or to where the variable is
defined, but it is not critical since Carlos confirmed it does not
break the build.

> +# Where to place rustdoc generated documentation
> +rustdoc_output :=3D $(objtree)/Documentation/output/rust/rustdoc

(From v7 too) Should this take into account `BUILDDIR`?

Cheers,
Miguel
