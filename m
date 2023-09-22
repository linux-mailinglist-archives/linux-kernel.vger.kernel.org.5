Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B417AB925
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjIVS0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIVS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:26:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D5A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:26:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c469ab6935so16555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695407167; x=1696011967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gTBcxUPj0X2lw9PxD7x8qtI+1zxhKTtoMwvn6AN1X0=;
        b=LhJ38cCtOgvHG6IH54ubxK1km6+Yn6O+A+aL1sKPhBC8S86PBBwAQ6aTBowa1/riX/
         v5WFdxPINY6GrrFVCHf1jOpIcrBHjUJHUNjHoUfPqbl5C5WTcvAkZETJCfO8cDO17dHV
         YJNleMhbwkWwmNGwGgbdbT7KlCOgErfYQd7WmZygeQTnPhtZ/CWKe0ACpiVoubkNxdCf
         E0QbLY//jfsfJDB1a4OeiG99hQBXJvxfO7S8jlo4+xTk7/CXHnyJhDyDdjDnvMOWDyS9
         YtpSfHJ91ptaYk8TcmTxNMMUi72XAA6j3j1CEln2TUoMigfuJJ95ZvZSvTicJg6J9zA0
         O4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407167; x=1696011967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gTBcxUPj0X2lw9PxD7x8qtI+1zxhKTtoMwvn6AN1X0=;
        b=mKIf7jZGXSAf9wXlcfRZB7BJOpfwUh9pQ1loKH5SM8oFmp/E8GZwR2tiViS1F09m+S
         olcg/Acp0RBGu1g8ZVm25IYGjRXmiAk5l76cbhRwyuOFcJX5rp+v5im3ErJyp/aT6oP5
         EOB4O6x7lPGQSj657Xzjmc//YHl/lBOGbEaQizVI01qY09UGztDdsK6Rjqo9xHAUbzH2
         Cq+h1lHeg4WSugl6VeSXuam24zkohlArNLKhl3PWYFp6y2wsOBtbTKoL6xf4pfTmw/6p
         asob4DRxmHlXoliSOxf7kT2L+jQB2P2guy7wkWAqsqdU4LR6xpDXbLohATRCSyr8YkXq
         FPAA==
X-Gm-Message-State: AOJu0YxkOzCGA8izNVu7QVRGTh14FOeQXUbTVA71hpBbGIFgQPqG+YsB
        LxVpOpyNlmQ5ZFYCODN5pJaxrUPlTifu3LUJHK1a+w==
X-Google-Smtp-Source: AGHT+IGCw9CUYrruZ8DWnXPsm6cBFUWlN4w3pKDLMImz87xku5Rhr1T3gOI8P3au2gBUTcXhqc2mXZkvm1C5hGrfVww=
X-Received: by 2002:a17:902:d2d2:b0:1c4:514c:8717 with SMTP id
 n18-20020a170902d2d200b001c4514c8717mr25128plc.3.1695407167411; Fri, 22 Sep
 2023 11:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175327.work.985-kees@kernel.org>
In-Reply-To: <20230922175327.work.985-kees@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Sep 2023 11:25:56 -0700
Message-ID: <CALvZod5xVhR_Feq7Wp_P9BLjYHJCxqvA6BmHmzwGzw34niDQ2g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
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

On Fri, Sep 22, 2023 at 10:53=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mem_cgroup_thres=
hold_ary.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 45d0c10e86cc..e0cfab58ab71 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
>         /* Size of entries[] */
>         unsigned int size;
>         /* Array of thresholds */
> -       struct mem_cgroup_threshold entries[];
> +       struct mem_cgroup_threshold entries[] __counted_by(size);

Does 'size' here have to be a member of the same struct as entries? We
have nodeinfo[] in struct mem_cgroup whose size is nr_node_ids which
is global. Will __counted_by() work for that?
