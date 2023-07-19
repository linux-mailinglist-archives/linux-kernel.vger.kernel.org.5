Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC5758E58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGSHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGSHIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:08:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8CE47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:08:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so99674201fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689750479; x=1692342479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GpJDitm1fqitEh3odC6vYNNE6Ga+U7B/JIkb40KK2kQ=;
        b=duYHOVUS+HCDLicJtKM/XnF9tEG5HXWvhwV9RmmCXskY7s5lkgq+eYyYjvkQc8AdrL
         KYKFuSBd9OWJbiIH1pDmY2TcLDoMUkm1Xn3I+oYriCJq5S0znvUFQn29seBDzHqAzV/A
         xgjjZqdLarvgGUamuxfRTPr9DeA6k0Jmd1U7B79tmtigvxIj3+Yo6F7vDkE/P0z7cLCh
         +KhQZlm1qnDjZOCZycnpX7wrOmzEkGv66/pMyl3+a96+uVUpGivUc27uFjKEuMc79sRx
         l/yAv41gUtDSrIERenQbEalLBBzYyNcunfGE9ZYaAWb+hbZR92QqidsLcdtspNxXSUo5
         zujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750479; x=1692342479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpJDitm1fqitEh3odC6vYNNE6Ga+U7B/JIkb40KK2kQ=;
        b=TSbxOAHzUgqrj9MvLwInZurf4Jvi4GYdKU6HHaMEm1PAocc2wGqhEtuV5jLUOF/UlS
         yUgFux8wIKHkjG09HfxWxBT7TINxlZpbQJFhwiQQcmXCTYifh1ASQqOx/yvfq0rARo7w
         ykRjdFXBya5wrM0Z+Zwf0nYerCj0fepi3HGUM8Tn36LifiktTHryqUYVsK1M4VUXlI7N
         6QkxGe+s4rmPmtpk8/c3CwLhohBPs4ArsXeIZOjk9LLs9GC7rK+Q9B3OgJCwoIg/qH/I
         2mc+SQR3hHOmF9H9U7vK8p+ewqIPjRNVMr4RzKVjYHb6W5xIR8cR2zj0lv8nz+y9NCwo
         UJYQ==
X-Gm-Message-State: ABy/qLZxABwLie6jBteYiUq6dB97loYzWmxop+MTJ8y8XYEPW5TqI0jb
        72dExGXxxSdWOFp67JbKhtigow==
X-Google-Smtp-Source: APBJJlFMGFAYeqyhhwbl0XodAkX2k1+xd9RnZFnFxtwUXixmFDxaQ+NHyBBbZpIZ4b7VgghWIWGR3A==
X-Received: by 2002:a2e:8846:0:b0:2b9:4ac9:6071 with SMTP id z6-20020a2e8846000000b002b94ac96071mr3834706ljj.10.1689750479095;
        Wed, 19 Jul 2023 00:07:59 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbd597bccesm901661wmd.41.2023.07.19.00.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:07:58 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:09:07 +0000
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Brian Vazquez <brianvv@google.com>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix setting return values for htab
 batch ops
Message-ID: <ZLeMExVzuG+uggn8@zh-lab-node-5>
References: <20230717114307.46124-1-aspsk@isovalent.com>
 <20230717114307.46124-2-aspsk@isovalent.com>
 <CAADnVQKutS8fYLkNz-rhdmFJ3cTWS6JD9PmwjK7ZZ8N3u7nUYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKutS8fYLkNz-rhdmFJ3cTWS6JD9PmwjK7ZZ8N3u7nUYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:52:38PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 17, 2023 at 4:42 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > The map_lookup{,_and_delete}_batch operations are expected to set the
> > output parameter, counter, to the number of elements successfully copied
> > to the user space. This is also expected to be true if an error is
> > returned and the errno is set to a value other than EFAULT. The current
> > implementation can return -EINVAL without setting the counter to zero, so
> > some userspace programs may confuse this with a [partially] successful
> > operation. Move code which sets the counter to zero to the top of the
> > function so that we always return a correct value.
> >
> > Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  kernel/bpf/hashtab.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index a8c7e1c5abfa..fa8e3f1e1724 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1692,6 +1692,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >         struct bucket *b;
> >         int ret = 0;
> >
> > +       max_count = attr->batch.count;
> > +       if (!max_count)
> > +               return 0;
> > +
> > +       if (put_user(0, &uattr->batch.count))
> > +               return -EFAULT;
> > +
> >         elem_map_flags = attr->batch.elem_flags;
> >         if ((elem_map_flags & ~BPF_F_LOCK) ||
> >             ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
> > @@ -1701,13 +1708,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >         if (map_flags)
> >                 return -EINVAL;
> >
> > -       max_count = attr->batch.count;
> > -       if (!max_count)
> > -               return 0;
> > -
> > -       if (put_user(0, &uattr->batch.count))
> > -               return -EFAULT;
> > -
> 
> I hear your concern, but I don't think it's a good idea
> to return 0 when flags were incorrect.
> That will cause more suprises to user space.
> I think the code is fine as-is.

Yes, thanks, this makes sense. And actually we can do both:

   max_count = attr->batch.count;
   put_user(0, &uattr->batch.count);
   /* check flags */
   if (!max_count)
           return 0;

This way we always set the userspace counter to a correct value
and also check flags in the right place.
