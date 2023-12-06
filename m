Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD7B807629
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjLFRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjLFRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:12:43 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9590
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:12:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b454089e55so94463539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882769; x=1702487569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+9ip8yZMAtxAFLF3RDeFuB04O8uGSJc2S5II7y6frs=;
        b=nOEjsI9wPICTOEpSEKIab7YisHSI6wyTj//vzR/CfZCoOhR3krBoIaXhWSwHgkLpZp
         AR75FHZfvw47xhcvsQvpJpY1PW6frZ2uCb2bD9eSSiFrrfdBII8gTbxJPxQE7dIMeaKL
         SpkZQ27zMQYwMw+V+WWvrFG2BNbBGrGaiRH6f8eI4X2gafNZ+STr82RFXW41qGw2ASRh
         RLb4o8NP9GqQgt4gVeYpq9KrtlTBLw/Y4K3nImBMVCvhomBavtvm5hXN17/YTgH+ngaV
         QSGsUnvFq6+Ya5twf0cO2zfMusqhrFbojhPTrw5Z6BbKx6iHeUAWNeh3+mDVFIp1fXvf
         G0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882769; x=1702487569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9ip8yZMAtxAFLF3RDeFuB04O8uGSJc2S5II7y6frs=;
        b=TgjTyu9S+Fi93mHX7vsaH5uPtPJ0mWGpC7umI2gXSYvbeUvHnQTt3KbRaQ1W24j0wc
         RzINqoe0gNjjaiQXxUY1aNnq9ADavoqSthOAYHXE5xlW/SzChFN6oKQagYH5ml3W/5W1
         SqGSe2mB1wSsFnFeRyNd1GvRJm4dsILYdDY6X1JnYn6tvfjHQNh3muunKqQGMIT2+2eZ
         Y2iJX+dsa+bRaDamoeQC/49+zeQ8srNOoUCb3rbUOLZYFpuHhZiK0hKaDckzVtGXk6fe
         jwk1gGKupIdRfV8rX9yugmHQpGZhcXNwBOkebDNOf9/Y6VqSMSJIxIQd7qEGLngsk6N/
         ab9A==
X-Gm-Message-State: AOJu0YymuH9Z/oa8KkJoBAt5AlKlZiOlSCnEMJ6I41cWzx0P6WeBuwze
        SFS4Kluvy2uS7bidDSXxo4o4lfPGiJKIIA6HGWs=
X-Google-Smtp-Source: AGHT+IEZjGDx20iCLpsr8jzabySaPZgdP0pvoCTZrK9a4/+/3o58b5uvXyEwWBSs0l4XYmUjw6c3cWJSMnwb1I+x6Po=
X-Received: by 2002:a05:6602:4817:b0:7b4:28f8:2670 with SMTP id
 ed23-20020a056602481700b007b428f82670mr1761277iob.43.1701882769239; Wed, 06
 Dec 2023 09:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com> <20231206-zswap-lock-optimize-v1-4-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-4-e25b059f9c3a@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 6 Dec 2023 09:12:38 -0800
Message-ID: <CAKEwX=M3iYV--kn+TEhLytijAOPH0_077KzvuGBE3+2r7AcW7Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/zswap: change dstmem size to one page
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Maybe I missed something, but the dstmem size of 2 * PAGE_SIZE is
> very confusing, since we only need at most one page when compress,
> and the "dlen" is also PAGE_SIZE in acomp_request_set_params().
>
> So change it to one page, and fix the comments.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d93a7b58b5af..999671dcb469 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -699,7 +699,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
>         struct mutex *mutex;
>         u8 *dst;
>
> -       dst =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu))=
;
> +       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
>         if (!dst)
>                 return -ENOMEM;
>
> @@ -1649,8 +1649,7 @@ bool zswap_store(struct folio *folio)
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_li=
st */
> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
> +       sg_init_one(&output, dst, PAGE_SIZE);

Hmm. This is very weird. It looks very intentional though, so perhaps
we should consult the maintainer or the original author of this logic
to double check this?
My best guess is for cases where the compression algorithm fails - i.e
the output (header + payload) is somehow bigger than the original
data. But not sure if this happens at all, and if the size > PAGE_SIZE
we don't wanna store the output in zswap anyway.

>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
>         /*
>          * it maybe looks a little bit silly that we send an asynchronous=
 request,
>
> --
> b4 0.10.1
