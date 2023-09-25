Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA937ADCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjIYQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjIYQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:06:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBFB8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:06:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-418157e979eso865721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695657983; x=1696262783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz326N6OBdHyE4AWsKl7zmfrXxh5t/tD9DFw2q4SSSM=;
        b=FseI31irQq9JF1uHo2PZcthT/MY3CM/WGvVxf06oEVmusqRCtb7JvC0UYqqbcWMJGO
         KUvegVPtmzM6JKG7BiRUfASBVNez0o+xYAgNICgv7T2Ay8MTl5liu9SaU4UY7tv0jtDF
         HhvHwBrUTlQ+JVaJmpGSyUb56qRj1Yv6ybHdoAj81SUECkbTqJwVutIv8znub3lqupyk
         NK4hZTsBXo5mVS61Jzl17u8V0esqmA0UzPLmDT2rBM0xnpSFKoYLkTjAj6QGhWCAVOA9
         BPEGYtgW+hPA0Hk4Pc2CJgRErmV5XTSM+6T+r9arbyx5t9DZ73tzBFGJMxfEeTLrHM8d
         +sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657983; x=1696262783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz326N6OBdHyE4AWsKl7zmfrXxh5t/tD9DFw2q4SSSM=;
        b=P3k/riaLOS2pcGgPaL+0Qy68+L7YgNA53tbIeXCdoWYhb1k78RrdqvlCd1NPC7jIQj
         ckkhRMGl/704RNmF5moAE7LWwPYZ3yhPuI8mvQ58A787fxSoo+9ugsmBmZPoKqeSm1nU
         ECBkoIVSPbNTnhjPhVHyHgthY29+DRcZXmbedufJyO6Le0x5TpjUcTeaeSRjgZsSnMz7
         kZBQFXuNFUuJ1PAEtE7EDvj9gL1SAMBN4Q/RYVK1flVhCJrm2RsM6s2vs3xHLraydS/I
         aPrasdvIM7h88IaRAJSu9K9SlYBTQOThpr0rG7iXayvX1k5mQ7bdxdEeB8hNFzo5bhlt
         ZMwQ==
X-Gm-Message-State: AOJu0YxxU0vc1rse+6ZhxA/BisEA9F8HxUYVeLNjKm+L7NRO6wU9k5Ls
        IMoldpaZPCUINzqOo5SJJEuuaGzowFx6azYXaMEnPg==
X-Google-Smtp-Source: AGHT+IEV1Y/S2WpYl/9OIl3jT55DN3TXd8/qzR+sWbjS06Z0lcw8hV/1qy78WDMnfjxDHbG52+fBPZ5xzQJMHGZzdhQ=
X-Received: by 2002:a05:622a:1905:b0:417:cd31:a2f6 with SMTP id
 w5-20020a05622a190500b00417cd31a2f6mr459497qtc.1.1695657982784; Mon, 25 Sep
 2023 09:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-2-irogers@google.com>
 <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
In-Reply-To: <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 25 Sep 2023 09:06:11 -0700
Message-ID: <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 8:49=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Builds in tools still use the cmd_ prefix in .cmd files, so don't
> > require the saved part. Name the groups in the line pattern match so
>
> Is that something that can be changed in the tools/ Makefiles?
>
> I'm fine with this change, just curious where the difference comes
> from precisely.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I agree. The savedcmd_ change came from Masahiro in:
https://lore.kernel.org/lkml/20221229091501.916296-1-masahiroy@kernel.org/
I was reluctant to change the build logic in tools/ because of the
potential to break things. Maybe Masahiro/Nicolas know of issues?

Thanks,
Ian

>
> > that changing the regular expression is more robust and works with the
> > addition of a new match group.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  scripts/clang-tools/gen_compile_commands.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clan=
g-tools/gen_compile_commands.py
> > index a84cc5737c2c..b43f9149893c 100755
> > --- a/scripts/clang-tools/gen_compile_commands.py
> > +++ b/scripts/clang-tools/gen_compile_commands.py
> > @@ -19,7 +19,7 @@ _DEFAULT_OUTPUT =3D 'compile_commands.json'
> >  _DEFAULT_LOG_LEVEL =3D 'WARNING'
> >
> >  _FILENAME_PATTERN =3D r'^\..*\.cmd$'
> > -_LINE_PATTERN =3D r'^savedcmd_[^ ]*\.o :=3D (.* )([^ ]*\.[cS]) *(;|$)'
> > +_LINE_PATTERN =3D r'^(saved)?cmd_[^ ]*\.o :=3D (?P<command_prefix>.* )=
(?P<file_path>[^ ]*\.[cS]) *(;|$)'
> >  _VALID_LOG_LEVELS =3D ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'=
]
> >  # The tools/ directory adopts a different build system, and produces .=
cmd
> >  # files in a different format. Do not support it.
> > @@ -213,8 +213,8 @@ def main():
> >                  result =3D line_matcher.match(f.readline())
> >                  if result:
> >                      try:
> > -                        entry =3D process_line(directory, result.group=
(1),
> > -                                             result.group(2))
> > +                        entry =3D process_line(directory, result.group=
('command_prefix'),
> > +                                             result.group('file_path')=
)
> >                          compile_commands.append(entry)
> >                      except ValueError as err:
> >                          logging.info('Could not add line from %s: %s',
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
