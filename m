Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5667A24F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjIORgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjIORgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:36:10 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6675273A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:35:20 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6543d62e9a4so16095366d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799320; x=1695404120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owNQ13PHd9ClWZJbvI5Hodz6Lzm8HqwmexoIjdWr1bU=;
        b=2cxw2psUbQ76cNQvcNHIoHBPu7P7Osx46XYh51MQloiHW4pEJ71ZVnZqv+16L+mKGH
         mX+2nUFo7CpSuGLxmlrVu7BAfoI/DAq6VbBZiCTk98WYv49KJ1UAqLwvCDvdz2LAO0iv
         dkLWJF5Vlbqg61Qu+ZR6FRSZR4TnX55fMWJpv4w42m0+7SWn+mQIOzRso83ggL/smrZp
         A5CJE461acstU0/h8MDywoP2fYCaNCa1NhQ/mHT2AfTLIUgCEz2meLkD5/s/tKM0XM6x
         MhNfUrA8vfJP6AoFHs/+CgHmDs8m5zEj4N4Y5qhiEsmol9CaZ4i2niZmpcphS9E3duYA
         H/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799320; x=1695404120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owNQ13PHd9ClWZJbvI5Hodz6Lzm8HqwmexoIjdWr1bU=;
        b=YM28lp8UUvyzQz0bvU5ZVqsjAY2iOgabUJX1JDveZyhLFprwxdYJM92TULXHEEyOGz
         RMQ6NQ0bLZFpmoWeA04bRwBTocF1snv+NGVsKe5Z7rJ9cQfzBz3ToaENaHa+XmAcNBTH
         SMJMJuDkR6xK6ZQYNdFeYW2ls5a7glvo0h/Pj63QA0g1rm+nX4mVNTn+3KWGxtjPeb8F
         thTWTZYV7VgtqGbQiej7xwARr3KcsKU1GpbaaBdwl9PcmdUrsvbp9CwPVkDX+6X2ASKm
         NAqgSFhW0WOQgkE3USSl5QmVoCwnGswsSpcovdnGFjIjE+FZxDyKK3wrr1bab1AddbS+
         XzOA==
X-Gm-Message-State: AOJu0YyKqBQeyliylQHE7pQ9SuwziATBGBTrr22pycUzO70N24isOqNG
        kqYCTDIAhcxhkH4qtxwfPUANbk/spQ2LBVrMw80iNQ==
X-Google-Smtp-Source: AGHT+IHdGqPa14fW1RYWtKsSg3nKw+WZmvBbn9ell9GzXkK5NaK5II6nkrUV2Di/ifEhZ+uqQNXs4h3FFiBXu1c9pec=
X-Received: by 2002:a0c:f20a:0:b0:656:1dfa:d845 with SMTP id
 h10-20020a0cf20a000000b006561dfad845mr2919472qvk.3.1694799319895; Fri, 15 Sep
 2023 10:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
 <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com>
 <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com> <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
In-Reply-To: <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Sep 2023 10:35:07 -0700
Message-ID: <CAKwvOdmq2YTrgOztdVy8MEeKU1m8hScu42iyij6fj5nndRCN3A@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Fri, Sep 15, 2023 at 10:33=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 10:28=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > And please use [PATCH bpf v3] in subject, so that BPF CI can test it pr=
operly.
>
> Testing `b4 prep --set-prefixes "PATCH bpf "`

Ah, should just be "bpf" for --set-prefixes (fixed before sending v3).


--=20
Thanks,
~Nick Desaulniers
