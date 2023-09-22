Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334D7AB9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjIVTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:11:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82BAC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:11:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5dfadb492so24465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695409890; x=1696014690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVDXja1jsplK6jUys/BTiLtA/EDT5Ln12hkq4wDDv8c=;
        b=n5aNpi7YI5gvj5MOq+b/UBgGxSpBKEoy/oOKX0mn3mhVaLQOKIwBmSZCdx4vuuhzyT
         deGg75XPr6sUy1mEU8/TTk8GAe6F93jybNqWvuM7n5538UXrH5qpj7FPNGK3uM5Orn66
         NIjSp5vsr77feGC8l1nHI3xR5MD7oae2847eCSXdfagi5JE4hFheP3m1jmpuHYtj7i0t
         YcCs0J1pS1XsP6QLbZVS3NbnpNY1Dr/kprUv+xNBDgKamb8wEOdgR2sTE3giVjuPyM51
         EO7WYH4jtP2aPmncbX9sptLSuyIDEfE8FDN0hkDngJGBWcigglgEdCUyCTMhoLoZmbL1
         Cphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409890; x=1696014690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVDXja1jsplK6jUys/BTiLtA/EDT5Ln12hkq4wDDv8c=;
        b=GPXJq5osWU2YwBqCPXNwO5wWzR/52IKnLGqeRVmQ51E2trwn0LmGG5Rq5fXAHAsz3x
         LCrDIuQzmCJeYX8fl+H80f38N3zuPNI+fGJ3JdxBzkaflHxXGMpwSSM0N0i0lAJv+mxl
         IwT7RY0vhiuLx6T1WyqbXCMsbztt8D4TJE2AE2xuaGCf4ZW/ZKMWGRvDeW90lE6kIj21
         AZR+4sg6u3Jq046O98lYir50VZ0hWmySLlv4xunaX+DoR+AcryP/KxOKgj/oxSj9pMyd
         j2gq4RmWw12rpf24KXgeC1lzx0Q0xOhv2HXhfCRg10rs451hr6ikJYnYJFL2k+ElHgiA
         titA==
X-Gm-Message-State: AOJu0YxsdIKtQZXkB8P8OWEJl46f9kZE10HjNXQDKeq5+bbAX3PNG2Kn
        3ko4MLHKTxFIe9jKJuci+s1KLQJQF/oKskHp+ebGGQ==
X-Google-Smtp-Source: AGHT+IF9iaH8QBslvwQ35is4Zdr9k2lMH60K6y1NH/ejSP8CV0JqaMrHHy2+XgRGGHFp5u4qThTi3b7f1K1xQ2ZPvak=
X-Received: by 2002:a17:902:cec4:b0:1c1:efe5:cce5 with SMTP id
 d4-20020a170902cec400b001c1efe5cce5mr33521plg.3.1695409890053; Fri, 22 Sep
 2023 12:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175327.work.985-kees@kernel.org>
In-Reply-To: <20230922175327.work.985-kees@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Sep 2023 12:11:18 -0700
Message-ID: <CALvZod7gc7bzp3HVv6v23rRfZe0ZrLT=qow_W7nF0CnsXFxuwQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
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

Acked-by: Shakeel Butt <shakeelb@google.com>
