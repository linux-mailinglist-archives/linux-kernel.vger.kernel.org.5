Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6980AA2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574115AbjLHRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjLHRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:10:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039A1BC5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:10:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00cbb83c80so264666666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702055411; x=1702660211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT2ERtTh7TDwFF0uUcvQZyrq9v2hGvyHlT8iTFDcKgw=;
        b=BjINJGv8Se2ZNM5dgM04aI3zaRiJt1oHH5Yo85O2Hy+QxkE3k0TcuACeNyqLHTNDv+
         rqOjn0pRhxpXCKfupNTgxM9hylKbdnZY4buXBnRjPK6m89G2WVyjAO7qA+HErV5SGDI+
         WT/A2YSF2DYnKhs4Qc1TbJ+XGIiWh8N3fIzrla0u/NiFZxAsgNs4KlRBfTCTx1B9Pp8u
         uUYyjud9MJmLolgDYRHjDqIUrdZi6LnlcsZfNqa+od+fYEQlFSBXqG+vuLOhgF+3BOoQ
         CeFCKexE7G+yD2Y5Z6vTjqHayxOgEv58NozqeThwyTzE+X/G/7WzuZOLTcxDdBpGC2Hl
         0Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055411; x=1702660211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT2ERtTh7TDwFF0uUcvQZyrq9v2hGvyHlT8iTFDcKgw=;
        b=e46gE0WPmBpuqBOZme6PNJgPPCrmGLmsougnEy6X95Or03wJxDN/2YMd/2SEhx6Uxp
         xOKOV2swh/iQ3fXGL7xPM9q1tWWM8OJPzajL+JetvbbLXM4GWAV3KTyv9cwPWYcuZ90g
         7k6V31Vz2QRkY77NV5wADK1+rTXTjIgwOEwprPLz8GtepsMHjmb3VKi25WHpcawNnOd1
         yZ+j9+hEiF5dp+eYZ0g4lFa2NMUr7tvlZpqoMuiz1pSmO8PkUzkQuyo59UmyAu7eeEcc
         rFPBrXPQTZZQmFCEKmAGLJaT2teOVUD9p5pff+Exv4ht54mT9O6QvrLqwO8omk24uAJN
         kdzQ==
X-Gm-Message-State: AOJu0Yw9s4HNcasveHGGBM+zqDHY0gGvZMyZyNUByxfW4P93SO11rWda
        +jIgMHh8OHdQAjhPI4tEosJzfmsvgFopjIS+2SzkjA==
X-Google-Smtp-Source: AGHT+IHGvuTbhBrs1OTyitMrjad5wyb6Xlbd0k3C4Ub46dJTi1an7MU4lzJ7bUx8DWzxrGPZfWz9yBhELKwMZoI01To=
X-Received: by 2002:a17:907:741:b0:a1c:fba4:b9ab with SMTP id
 xc1-20020a170907074100b00a1cfba4b9abmr210269ejb.95.1702055411477; Fri, 08 Dec
 2023 09:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
 <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
 <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com> <CANpmjNMehFp7dM7QhR7AQgp33i-a0s0R-J9ZPweyroY45eCizQ@mail.gmail.com>
In-Reply-To: <CANpmjNMehFp7dM7QhR7AQgp33i-a0s0R-J9ZPweyroY45eCizQ@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 8 Dec 2023 09:09:59 -0800
Message-ID: <CAP045AoFHiMjCkopXo8HQZTpNWz8fE2LBt+vPUgnvUpdR9STfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To:     Marco Elver <elver@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 12:07=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
> I think that's easy to fix by just defining TRAP_PERF yourself

Yeah that would work here.

- Kyle
