Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4A7DF756
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377086AbjKBQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKBQFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:05:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973419D;
        Thu,  2 Nov 2023 09:05:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c3aec5f326so441602966b.1;
        Thu, 02 Nov 2023 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698941127; x=1699545927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwjuKF0m6b95GH5kA/PrMCqg/Fnygmr6UMeQTw8Px6w=;
        b=MjVl3B6MJ+HVt12Up3Vj9+PG1PyZRgb55V3SgAbj18vJsrIhwTX7aTYLSI3zq4L93k
         OBOmajFglC/jlr+Cmf4FGDPg7555Qwl9gdHldWcPCyI0a9xicEGgDYR/F/ic/gv5CRPP
         Z9TtMuOOZ1O5jHpV6Qs+7XGvR5KV4ActAqYQUX2p1z8Daz7rZSun/Wa4mgM2IhAtMle9
         1LfbBf+cBCH+tOos7TkhpV9zaumH8ppCsTXmgAJehbEX9HP2K26W+TX2Q9IqUR+8qW/A
         J1K7GVG7TTvaV2irOnrlIb3WLPd4WTx+BTGXwv4W75MLDVd+3sKAuisKsgqzZiq52+2J
         ALTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941127; x=1699545927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwjuKF0m6b95GH5kA/PrMCqg/Fnygmr6UMeQTw8Px6w=;
        b=nlj2K+ek5Ldu2v1lOKD8v54VYSJltJmaOZTO/UwEYjUXW8kIY4Froi4k81aWDLDSBg
         3p6GKncEkrSI963aKKcAitg1Ui3/BrXc8GLbjMq17UnUpfSDlZ3cXaZAxsfn3JFXPfvL
         2YbFWyfVrKG9x2edrn2B6YVVjuAx4PaZevUviot0wH4OqmBEjZ6hpLF2mawrN1HJmkgV
         o1nXbfb16iO1r/AOO+AUa/PeW3e/zrZHthAmSeFpQ4qYO+otWAG8ZURbp/U7Ak7DLp+5
         1u3X+/mUckfKcIdcfDagRGr1HWuNvBTTbvc0YND58/6Fyan5EhAPiu+2nb3fRJjIto72
         OqhA==
X-Gm-Message-State: AOJu0YwB6cS2siTd1yJ2lNRld1z5mojCwJxGiDTGA/ca9xUdQz4z3Txm
        5WBkYcilk1K0npo9g1UrQrG9glmH4iIhz/GtEEro7evCZKQdfA==
X-Google-Smtp-Source: AGHT+IEDjRFCQrTuZjKfZnvcTt3wSNXzpypFp3lHL7z9Tib5HnwFSzeTK6Iz8cd6cbDPJ8/qc8dsTUhsAZrRrKaZJyo=
X-Received: by 2002:a17:906:aac1:b0:9ad:cbc0:9f47 with SMTP id
 kt1-20020a170906aac100b009adcbc09f47mr231181ejb.12.1698941127037; Thu, 02 Nov
 2023 09:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZUNiwMLBsL52X9wa@debian> <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
 <7ade1b4d-71ad-4f32-9b19-9d8eac8e595b@leemhuis.info>
In-Reply-To: <7ade1b4d-71ad-4f32-9b19-9d8eac8e595b@leemhuis.info>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 2 Nov 2023 16:04:50 +0000
Message-ID: <CADVatmNkXXH5xwEe25cZeESRT5FscKQuGEoSZ=1tiGTtLO-+pg@mail.gmail.com>
Subject: Re: mainline build failure due to 9c66dc94b62a ("bpf: Introduce
 css_task open-coded iterator kfuncs")
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
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

Hi Thorsten,

On Thu, 2 Nov 2023 at 09:13, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 02.11.23 09:53, Chuyi Zhou wrote:
> > =E5=9C=A8 2023/11/2 16:50, Sudip Mukherjee (Codethink) =E5=86=99=E9=81=
=93:
>
> >> The latest mainline kernel branch fails to build mips
> >> decstation_64_defconfig,
> >> decstation_defconfig and decstation_r4k_defconfig with the error:
> >>
> >> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> >> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared
> >> (first use in this function)
> >>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >>        |              ^~~~~~~~~~~~~~~~~~~
> > [...]
> >> git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task
> >> open-coded iterator kfuncs")
> >
> > Thanks for the report! This issue has been solved by Jiri.[1]
> >
> > [1]:https://lore.kernel.org/all/169890482505.9002.10852784674164703819.=
git-patchwork-notify@kernel.org/
>
> Thx, I was just about to reply something similar. :-D
>
> Sudip, maybe you know about this already, but in case you don't, here is
> a quick tip that might be useful for you: in cases like this it's often
> wise to search for earlier reports on lore using an even more
> abbreviated commit-id followed by a wildcard (e.g. "9c66dc94*"). That at
> least was how I found the fix quickly.

Yes, but the failure is still in the mainline. And it has happened in
the past that the fix has been submitted and taken by the maintainer
but was not sent to Linus.
In the last release cycle I had to send a reminder around the time of
-rc3 and in that case also the fix was submitted when I sent the build
failure mail.

But  like you said I will search and will not add Cc to rezbot in
cases where a fix has been submitted. Also if Linus wants then I will
not even send mails in these cases.

--=20
Regards
Sudip
