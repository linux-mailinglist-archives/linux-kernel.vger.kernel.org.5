Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59C78453E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjHVPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:17:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059B1B9;
        Tue, 22 Aug 2023 08:17:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d7481bc4d6fso2901203276.2;
        Tue, 22 Aug 2023 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692717471; x=1693322271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59M6Girki320TCTK1GyWKJa3E9zY7uihbSu4q2aKwv8=;
        b=M0HbFKy4O6XJnnvgcsiUr3WQWaCGK0jJgxxyBqUljbHy5gRkZXo1jnol1t6qdS5eza
         SMU1Rz68eXeScCdmKEiheiKJqFaAR1zrdwVdns9mXHxOSmrAHr2lGduMgetHV9RIf9nq
         /qAEegcROwua3gko5uFO7kxSrLLt1TknV9QRkTOKVueyI/byPPJ4jSxXTN1f2ogQCdjh
         1h+yhf+qXUuJ+Rc1HADdUK2U7ttaN9U2TVG9FzcYNEGtxCge5vDuqRsvI4DXNgEOXOeK
         xaOLv392kS6rjGJQ1MjvZahrNsDpnj6CFHrh9ZSnSoS2DpR2QV5ap7ndX+OFYj+GCA7B
         9Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692717471; x=1693322271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59M6Girki320TCTK1GyWKJa3E9zY7uihbSu4q2aKwv8=;
        b=SMfjIB3S1HK/hn6wahaSaxq3gPCY2ftLsEQEKKRhmxhB3fgYXxsH6+k4xug+7dIJF8
         VsqiSWJnrBSoDScNSKroYRZLmhjGXvWXW6ULg16J/+b3E6GzsgzjLaHD7CHWAlOWnOji
         fsfU/99XjRLTGQeuqoB9ZXUFwj5vpuM+Mz0tMJ6spIUCZkfIHDTxB+OTJSbLWv4suApY
         t6pjmfBwGJrXbuNfdlAdGaAgJzrB+9M4tAg3Bs4VY2/KA8JLMxtSVquKRVR4gRTCQhv4
         1X0pZPe3Q7FowZFTokTe+9UwZKyGYS7FwfWnlsWnWLGpSclOKa92SBmRl7wX5vTVCf81
         56MA==
X-Gm-Message-State: AOJu0YxJPcvqbbakdlcmCih1yK7/Edu/ae6SA+1yqfbBlnpsTmCZ2zUK
        J6pSNcGnZc6PSeKWNJPRVkmobMMAaZXHx5iPmzs=
X-Google-Smtp-Source: AGHT+IFqyQFOTQqanc1s2m4ocPbNu/JNaNBM8De7h2JFN7RA/p17xsGxfq78ecB2cFVwOd0FvKDTsunJ1fFEUTrfOW8=
X-Received: by 2002:a25:d10a:0:b0:d62:b91b:10e3 with SMTP id
 i10-20020a25d10a000000b00d62b91b10e3mr10507545ybg.48.1692717471336; Tue, 22
 Aug 2023 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230822162333.752217fa@canb.auug.org.au> <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
 <20230822222036.3462aa57@canb.auug.org.au>
In-Reply-To: <20230822222036.3462aa57@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Aug 2023 17:17:40 +0200
Message-ID: <CANiq72nvbkYQ0bPb0aRs0jNZGgFwg8TMek4b0n3jrgxd2X4h3A@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 2:20=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Thanks for the explanation.  I have updated my resolution for tomorrow.

My pleasure & thanks!

Cheers,
Miguel
