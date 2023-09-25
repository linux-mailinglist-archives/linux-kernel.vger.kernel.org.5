Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFE7AD8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjIYNJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIYNJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:09:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFB10B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:09:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65b0e623189so10638416d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695647385; x=1696252185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCu5+asNexQ67uaFbh89wtL0Zj7WqdyYVbK3CcfZ09I=;
        b=Xa0RStXR8vi+XkAoUqC6wXXa150IhTKnKkGfKNbtugYyjOR/2+SNuXQx/BJ1cU7CNm
         h0o+kdKe403+umyj15wCMyZhalh5FVwP6C2sq4wMEULPE+Xi6daTKohboyuxZCOVqGIP
         3qCzsE1zs5ALVBwlEu0uQ3P6M7ypTv256rVW9gKRKhobKSPWrfZdzKfCCAvxmS/ccR4V
         vareRF7zXuDrXee1iWLutEurEtowFooBUdpeNZSY2tQKxel1ku2R70dPsMqSMu/aI8Mh
         0hdwL9FYrFTmOv1eGFGCV4qXdmmFDmn3/K+33oaO23xDLRzEuQb8nVYWWTV7GWCi5RJK
         0H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647385; x=1696252185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCu5+asNexQ67uaFbh89wtL0Zj7WqdyYVbK3CcfZ09I=;
        b=vgVRKzYN61zA3SO++ihSxp8Nh/ajTaMS9F/G4YorXFdbO1ohHsVI6gFiHQybOfrVPK
         LSc6eptnfLjtV1bJo1tlaNKFsJ+/i3QTfd/NTJce79enqhkhjKwL1NaKRKXsy8j0Nk2Y
         4ToknRc7bUKT9ygtG6JMlNZkhYp6eluq1GtClElOkwjlPxIX2EFVEhMjgd8hlXqUOeAL
         LW46Cb0dcMgSZk/U6p6CeJYNPducFE2tF9NCvmJRE+vZEdJGhOfe4qmpeoHCulGa7QDc
         VYYwYKI/mwBrEQ4tNP3f/CAeinab7fIV0hQgu/0k70WfQnCh4OU9OAN3ZR3D6m+WUE16
         AxXQ==
X-Gm-Message-State: AOJu0Yxv8MRYpaO7nq/18A3gUp9pfkKkUMpc7LJZlp5gAvs5TbY7tn09
        dQTo9XhrCt8brROekT0BHnpotYqvBbiuMpK5Z94zhuvqjddeeU0FLJXbpw==
X-Google-Smtp-Source: AGHT+IE4+3ZHgQcpLX5y4DgLnE98DpHD+tB/BdCCpqTOsBgZ3nlOgaXOjToHQAaf9+8azsQZHwsW/WIkIVeZxh5jMmw=
X-Received: by 2002:ad4:5ce7:0:b0:656:3a95:5d99 with SMTP id
 iv7-20020ad45ce7000000b006563a955d99mr7966668qvb.18.1695647384842; Mon, 25
 Sep 2023 06:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com> <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
In-Reply-To: <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 25 Sep 2023 15:09:04 +0200
Message-ID: <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 2:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 25, 2023 at 02:16:37PM +0200, Alexander Potapenko wrote:
>
> ...
>
> > > +/*
> > > + * Test bitmap should be big enough to include the cases when start =
is not in
> > > + * the first word, and start+nbits lands in the following word.
> > > + */
> > > +#define TEST_BIT_LEN (1000)
> >
> > Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=3Dy
> > kernel reports mismatches here, presumably because the last quad word
> > ends up partially initialized.
>
> Hmm... But if designed and used correctly it shouldn't be the issue,
> and 1000, I believe, is carefully chosen to be specifically not dividable
> by pow-of-2 value.
>

The problem manifests already right after initialization:

static void __init test_bit_len_1000(void)
{
        DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
        DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
        memset(bitmap, 0x00, TEST_BYTE_LEN);
        memset(exp_bitmap, 0x00, TEST_BYTE_LEN);
        expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
}

...
[   29.601614][    T1] test_bitmap: [lib/test_bitmap.c:1250] bitmaps
contents differ: expected
"960-963,966-967,969,971-973,976,978-979,981", got "963"
...

So it's probably expect_eq_bitmap() that is incorrectly rounding up
the bitmap length somewhere (or maybe it is not supposed to be used
for non-aligned bitmaps?)
Looking further...
