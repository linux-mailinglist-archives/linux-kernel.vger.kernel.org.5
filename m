Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A187B3CC6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjI2WxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:53:01 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0FE8F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:52:59 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4510182fe69so5892402137.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696027979; x=1696632779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVD0NwiVgmmQvibC1xInA0otG2T0uniQ4SKhb3BsNQI=;
        b=kreCBmuHwoM0nmrl8pqn/+pwIP7Wdy8EYXkChnGvV6aS684fNe00D8pVSiI1ADK9Ky
         jivRVT19/fSZXnVMLB7FbJcBfBOnE3cYSsmjP3eR6H3DQnCqPWi1RsnBHoB3QVO5Bu9S
         jk9iepApaGL36AlOg4zSsnWV+9uFXpdvJwahC9QqAn8dpiNEMG2k+dl83QT3AdgKV/DL
         DrSW0nGZY7vH06cnwWGDAUcQtqbeuHHSiao7tATIXqBAKucZhzyvkkq+CUbCLrkm02zo
         V+4mLBJM1pVKOlj0pt9zaAZ+HqNUpf7BSew5IxPuWzGjKy4leliKT2vaIjyUmTbnAS7i
         J51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696027979; x=1696632779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVD0NwiVgmmQvibC1xInA0otG2T0uniQ4SKhb3BsNQI=;
        b=Kdgfy4YLuY/0RKnnRjlEU4HJmRm6JePor1pH62XvsJs664tD1YHpKEi9NnHUKIH/9B
         wrfZC3WH58YjE8tQgFw7HdK6NLWtLy8WXigOztAXr9JlY6Y3Rx8iteDcVhlYkmhbyZcz
         ES0ap5VpUWldIvE41rKYTaTfI46CitpHvR790uvZesdXpiP2MSSRgr3JJzYnae2sBl8J
         jiA2DvJQ++YKauvZddIMhahNGY6yVLWCiHUqWdEtwp/ZCVd5BfuxSY2BzDJWwRUb5MZn
         kozjMjhO6h+VnpJdVTVqBENrGQqpxJ7OHDQN9S3bpBF8e8pln1XqykCy6KUZKSKxi2Dw
         daKQ==
X-Gm-Message-State: AOJu0Yy1JeZ6b+ozptLDLFuXy4FJFyUnp4xAD2mcpijVwRvpjiKbIXgu
        PC7UHI56ekdZI/TMH4DsDv+7OeOeTpmvaz2ISVUprg==
X-Google-Smtp-Source: AGHT+IFIzioa8M+FkbhUdK48/e055YeWZrhKv/naxGAzU7YglwP+Nfq9WJ8bCC7WBhwhOz65LtF9FwPuJudNt5dBpwY=
X-Received: by 2002:a05:6102:134b:b0:452:77f1:f1e8 with SMTP id
 j11-20020a056102134b00b0045277f1f1e8mr4849186vsl.33.1696027978754; Fri, 29
 Sep 2023 15:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com> <202309291452.66ED9B4D83@keescook>
In-Reply-To: <202309291452.66ED9B4D83@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 29 Sep 2023 15:52:22 -0700
Message-ID: <CABCJKufxUVoO+yJ+513W5FOFu6u45N=6wZe6a69u+8LU6A_N2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 2:54=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
> > ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
> > potential bits of mmap randomness on the table if we end up enabling
> > 4/5-level paging. Update mmap_rnd_bits_max to take the final address
> > space size into account. This increases mmap_rnd_bits_max from 24 to
> > 33 with Sv48/57.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> I like this. Is RISCV the only arch where the paging level can be chosen
> at boot time?

I haven't seen this elsewhere, but I also haven't looked at all the
other architectures that closely. arm64 does something interesting
with ARM64_VA_BITS_52, but I think we can still handle that in
Kconfig.

Sami
