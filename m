Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BC7A249E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjIORYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjIORYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:24:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBB1BD2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:24:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76f08e302a1so154128585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798653; x=1695403453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHSI7NrOZgvx0uzvA9KNtopi40O1OvJSkD1oOvtykg=;
        b=akl055b2yJA6KXRK4fYvi5V5+idBqAZL3RwcI70DuhN7nOrfBkFDh66D3+nGmDDcxD
         rVo9p/kMhh2iHlL9DI3A4ttqR9Tpy2AOuiYfWz5ncpy3mMXKCkgOMzCjJUm2S0MrtMjW
         fnHjJp7SMXrsWg+xmBH/deTnRRGb5yGwPufGk7CfiCadwjrzMJEglC5iNeYtUPHnZKGb
         zMJYxDO7ESDqyZa8RMcOolixcgVXoLFm/Uqh2XD8LWe03kW2Wjy/fCxVIzeOZmap4Mzy
         edLeJpaLlYNb2cWeZ5MHmCuMMBtJMIBHnqy+dL8iuhikbkgtlwrWQesYabmP5whlzjNu
         GziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798653; x=1695403453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHSI7NrOZgvx0uzvA9KNtopi40O1OvJSkD1oOvtykg=;
        b=IWcWmzaU6t4yLC1YSYK/nQtgJvh7l7fLMGbuhPZzdSCnM7NqXFzgKmgdfLYkzP48L9
         kgyyU83/qCeKiK6IwR0CAFK6Db7feTlpPmMMjRdMRIWpuEXT128Z7CTTtTCUPr2UH2gd
         3rOOrjiC+FWQTwhTlQcEwmPvS8o3LvaVWmOAz5GZ4NfV+exYrMvOka7w4InJITNqjHK3
         c8lUcKJnCnaVjcm+F88TR2qNlRl358IwnV8sFHNz3TKD88tDJ1D9NsGlUutI5cTUNYa4
         nD17d2SQgXtMW0xs8j6xkmeDDfSG0K8unMPcmsEUVppmCNjAd0dOsx0lMwrsYougL2UC
         nWog==
X-Gm-Message-State: AOJu0Yyt9WGPL5Uqts0rKQ+RGKoHCtzm+Pw6O6MSaGJmiCEXGNmb5tjR
        7npwe6OR4EXNnPI6p6aWeIYrKVpChvTaw6FWZfNcIA==
X-Google-Smtp-Source: AGHT+IF2Sqc2tmS+8WGl+/J1WlqNUpcQABVxRc1oTvG4gXsw6rD8FwkkIRylabiACJxG6xJxc0STnldicD344sEoExI=
X-Received: by 2002:a0c:d990:0:b0:64a:6858:f9fb with SMTP id
 y16-20020a0cd990000000b0064a6858f9fbmr2309178qvj.49.1694798652855; Fri, 15
 Sep 2023 10:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
In-Reply-To: <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Sep 2023 10:24:00 -0700
Message-ID: <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 10:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Nathan Chancellor <nathan@kernel=
.org> wrote:
> >
> > On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> > > Marcus and Satya reported an issue where BTF_ID macro generates same
> > > symbol in separate objects and that breaks final vmlinux link.
> > >
> > >   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > >   '__BTF_ID__struct__cgroup__624' is already defined
> > >
> > > This can be triggered under specific configs when __COUNTER__ happens=
 to
> > > be the same for the same symbol in two different translation units,
> > > which is already quite unlikely to happen.
> > >
> > > Add __LINE__ number suffix to make BTF_ID symbol more unique, which i=
s
> > > not a complete fix, but it would help for now and meanwhile we can wo=
rk
> > > on better solution as suggested by Andrii.
> > >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> > > Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> > > Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > > Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUa=
sQOfQKaOd0nQ51tw@mail.gmail.com/
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  tools/include/linux/btf_ids.h | 2 +-
> >
> > Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwise, I
> > don't think it will be used by the kernel build.

D'oh!

>
> argh.
> Let's do this patch as-is and another patch to update everything
> in tools/../btf_ids.h, since it got out of sync quite a bit.

I think I can do both in a v3? I don't see the issue (in mainline, are
they out of sync in -next?)

--=20
Thanks,
~Nick Desaulniers
