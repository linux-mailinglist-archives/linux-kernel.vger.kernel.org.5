Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D2D75E3EC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGWQq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGWQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:46:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CC191;
        Sun, 23 Jul 2023 09:46:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b962c226ceso50316121fa.3;
        Sun, 23 Jul 2023 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690130812; x=1690735612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDMDgAIp9Hy8mjss6jK4giThQapzOntB6CEZnZ0araw=;
        b=mxv4jX/h67VXj5zNgLevyLjfSza+WMldwjt7HRLnEDfmppXF224s2b4H4Dv7Wv181/
         1eRv9tC4rRbYk0Q6dbPnfhAVg6BO3IQr1mPnOpMt4p/pvUSMo8P6bAwFmhjWnOD1xFK5
         4MhBFRguPRC1l9u6CyxG171PsTJj3teQJKFqlKqucl7BDRqye0a5GwzloqGg9yf0CBqT
         67M4Pq35vCRbBJ8mqATOPNfDacXfJzNVuXZVTQOhQdF+liEarUNhs9bk0rWQESk0wdmW
         2kuku5cmNhcHA/ThQRaosNLQtmr74jcy36njjNsHVMJpnzTxkux/4+VqQUEWYLq6qgda
         3pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690130812; x=1690735612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDMDgAIp9Hy8mjss6jK4giThQapzOntB6CEZnZ0araw=;
        b=OAsRRJxjSI/9LSyD1Fn8M5wz0vhYwYCd/SE2LYK0GqbCfdfxVRzrUqvqv/nhryVqbf
         vrlzEJU1cwIPGcmRDC8pYsWxllE7WPUhhCslKO1LRWhoR9MwE6CoQLIXBWZk16lLPUK6
         rPCsZ8Pp9WgjiWsD7oqjt0A1iuAaMpiZt9A894SQPDd/h2BbSWm5eG0E4ErT/p+iHgBm
         t6m6NpDulb6G6KO8GnW7vZPXFnJ7Ai5kH22runG655nEFF+MYch55WVdpHHUSyJPqy1d
         ZuMiFeDtOSSGYseJcFayoVJMoQQ8m3yMXHhQ+EHjLi2OhxtAVcuyckz3zzkqLa7MdzTT
         6znQ==
X-Gm-Message-State: ABy/qLbnWJqMRF1Nzb0WlXv8jM2ZFCpliYkrWJLZCzy75mZUIvxZjhAn
        fmXiQ4Fb7RiCyJO/G4KsNRwVbdKbREI18otuu1Y=
X-Google-Smtp-Source: APBJJlHCkGJA/41HdSXXRX5Ujn1jSZ+oogOof6Qq65nE/jYX+rQigm7DyrBPcZJWgraVZdBeZhySlj7wqtG5E+I9JIU=
X-Received: by 2002:a2e:b70e:0:b0:2b4:45bc:7bd with SMTP id
 j14-20020a2eb70e000000b002b445bc07bdmr4341122ljo.4.1690130812336; Sun, 23 Jul
 2023 09:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230722074753.568696-1-arnd@kernel.org> <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
In-Reply-To: <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 23 Jul 2023 09:46:41 -0700
Message-ID: <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 7:25=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Jul 22, 2023 at 3:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Splitting these out into separate helper functions means that we
> > actually pass an uninitialized variable into another function call
> > if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
> > is disabled:
>
> Do you mean that the compiler can remove the flags automatically when
> dec_active() is inlined, but can't remove it automatically when
> dec_active() is not inlined ?
> If so, why can't we improve the compiler ?

Agree.
Sounds like a compiler bug.

> If we have to change the kernel, what about the change below?

To workaround the compiler bug we can simply init flag=3D0 to silence
the warn, but even that is silly. Passing flag=3D0 into irqrestore is buggy=
.
