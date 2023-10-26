Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6B7D7F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjJZI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJZI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:57:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49C18D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:57:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so448670f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698310659; x=1698915459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ/824BJO1d/EHWcRhN/veSLWctMw07x5UCm1ELLYiY=;
        b=HdccXSfH/MWHbnxpKL5oTzMlotRMzfZA4b03h63u/YUh5I2HJj/kO4wocbs8a6fEBj
         LjovLz/bgPrnFsUyNsSUqlWLkKr0jEXCcTry2gUONp7Z7Cwlro3IFHyqHE0CqAkTS/p+
         XngdxQzNi0Uu0nVwpMPsenklLp1/KQZE7o6wTLv67OZ5JSXCACtReiG9Nuq8apRTRPh2
         1GLKbY578tXeawtUqknE3Nqprka8zL3vKg3+sMQ7TD8IJQn283wruCXigvStGBcZ/yiN
         NzkB3p0yzcfIXtaRkSgpT0YLVAsh55L+Oi48HkR5Cx5vC578erAWiNZ15CRWLbBM7M56
         oEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310659; x=1698915459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ/824BJO1d/EHWcRhN/veSLWctMw07x5UCm1ELLYiY=;
        b=T+EQzjDxVVvTgpHaLkf3Dg8UL4zVmRlCymeMNdVN6pWzbNFvE62eJXlgwPwE7lcura
         S4dLdWHmvThsvH/KalVNdOyPF586CeZSLNOuVzLHuxZRBX7W2JfQRYIwS4omBaXZwa+d
         lk5DXGeVjyWzILLWNoNNIjcoaHRnSojPS5QoXNq5z3qgYaPknbT3aqgft6nhau4ddLj2
         V1XQ/A3PYqsc3WeW/i+hvwLw7LsBLC6lUHBqTkN9oG46IhnJ6hX1qFjQ5VTEWReVHc9h
         H8Td3+JnaJhwX0zqB1xsTvtd6OXVT9vdrq90J1hAlPRR5M+FgT5TpwCIWvujK3uMwCGe
         SMuA==
X-Gm-Message-State: AOJu0YyeYsRY5wDx4qpu664y30Rt9P8OJt6DgD5pTDGNOOWl9PHT+edG
        MDB5voJ9cmBqKj3rMG98DRZKZklM4zzYhuxqub65pQ==
X-Google-Smtp-Source: AGHT+IH3muhS4J2stt28w/fF1mg4E8iD8ocY1a/XGGeNGDZ1PbgBpfdORtGH6uJ3k03W0uvTXNi6DVixxCLk5iXWVGY=
X-Received: by 2002:a5d:464a:0:b0:31f:98b4:4b62 with SMTP id
 j10-20020a5d464a000000b0031f98b44b62mr13281281wrs.37.1698310658773; Thu, 26
 Oct 2023 01:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230928151846.8229-1-alexghiti@rivosinc.com> <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
 <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
In-Reply-To: <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 26 Oct 2023 10:57:27 +0200
Message-ID: <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Oct 3, 2023 at 6:04=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> > +cc Andrew: Would  you mind taking this patchset in your tree for the
> > next rc? This patchset depends on a previous fix for arm64 that you
> > merged in rc4 which is not in the riscv -fixes branch yet.
> >
> > I saw with Palmer and he should ack this shortly.
>
> Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
> being well I'll move them into mm-hotfixes-stable within a week then
> into Linus shortly after.

Those fixes finally did not make it to 6.6, I was hoping for them to
land in -rc6 or -rc7: for the future, what should have I done to avoid
that?

Thanks,

Alex

>
> Unless something changes.  It's odd that the riscv tree(s) aren't set
> up to merge fixes against -rc4?
