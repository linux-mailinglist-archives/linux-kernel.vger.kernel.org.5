Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C96783B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHVIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjHVIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:15:59 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D112C;
        Tue, 22 Aug 2023 01:15:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d70c441d5so47211917b3.2;
        Tue, 22 Aug 2023 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692692155; x=1693296955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pNwnJY/s7QRWPK/T/LrEvZTxwiXUWa5BGaQPgsWCSc=;
        b=lcIuyYyQNHfbXtj6dwhiTTXXvJwy8llqpaplGcRE5EiT4a48XtRST5vjPgykhgQnNk
         4pQ9g3ff5C/hNLh//3IlA2QUs3NJ4wmGnQt/L8ZQEW2DrSKC5+YZPo/49Z8VI/dLoo/I
         Ut0KHJNgd9PgDUlwJd61Zfd8yndhUfMgITYTA6jUc8RQQkegu7/X6bknWzThICUb/Z/A
         vLFD2tIolXC9+M8bHoPWlCVfROQswC5Cf/uHFMijpycTvYWVG12NlZXok+SzXEXAIzIH
         eEP4DNHvvhzjnq774rVBAu5m5IheNDg9VZ+i0kpgt2fJSxW9pNFj1h0fe65Tfh51NR5k
         DoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692156; x=1693296956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pNwnJY/s7QRWPK/T/LrEvZTxwiXUWa5BGaQPgsWCSc=;
        b=SY92tvwiUr9jZ+InE1sH/WgcGVC3Fb6mua7oE2b2lBF8aMcACxl7q63d3w4GAAL3iR
         /o1X9frWtZGJ6zPO+HJ9XfEwOCsue4apRYywn60vb3xNCDGSSQhoGa5LfNc35rsc8QJv
         2gfMAmDQDwVRLX6qpl+B0r5QuKqhajWbIZYW0pIICcqNgjlY3nYBfqlQMKBGpyVsX/5m
         MdD8UQU20/AfBekmNkNQhjL0VY9PoJ7KW6350cmUSGl1zEwlxrGD3xJhdkE2IT6fXMLv
         7sXxOzaaMsgQyPzvOegQvhf51jlpyHZqNdRX4ShZ3E6Ua4XU3AS2osuwZ9s7TaYJYDCI
         EvBw==
X-Gm-Message-State: AOJu0Yybcjelwt/QmPxHVqfvVLpIYMvHfIwDp9U5Fz82onIUKr2lzNar
        PYeNMydnDv0qTm1qR1va3jmeEtM4UCvmubuT3+E=
X-Google-Smtp-Source: AGHT+IGGNDRQXmWfMrwaU6p8ijvDVDK3Dkt+pLL3D5g3zeq+suu7YJKm9+M1gLTkSar8kgUIy3OaFzYT7O0W0ShyBqw=
X-Received: by 2002:a25:ac82:0:b0:d0f:65db:dc0e with SMTP id
 x2-20020a25ac82000000b00d0f65dbdc0emr8918287ybi.39.1692692155717; Tue, 22 Aug
 2023 01:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822162333.752217fa@canb.auug.org.au>
In-Reply-To: <20230822162333.752217fa@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Aug 2023 10:15:44 +0200
Message-ID: <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kunit-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:23=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:

Yeah, we expected this one when we applied an extra patch series
yesterday. I tested the merged trees to double-check the (now tested)
examples pass (i.e. the KUnit tree has a patch series which enables
the testing of the examples in the documentation of Rust code).

> - /// # use kernel::{macros::pin_data, pin_init};
>  -/// # use kernel::pin_init;
>  -/// # use macros::{Zeroable, pin_data};
> ++/// # use kernel::{macros::Zeroable, pin_data, pin_init};

Almost right :) It should be:

    /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};

In case it helps for future similar conflicts, the reason is that
there are 3 things we are "using" here:

    kernel::macros::Zeroable
    kernel::macros::pin_data
    kernel::pin_init

Instead, the current resolution would mean:

    kernel::macros::Zeroable
    kernel::pin_data
    kernel::pin_init

Thanks Stephen!

Cheers,
Miguel
