Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C67ADC53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjIYPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjIYPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:50:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09B193
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:49:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so52961865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695656968; x=1696261768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+2yILMg5RefpLAOUcXf0dyQqPNPRMS1MIKyTbaudkU=;
        b=t/aQMdCAV+9kj1lZg6osRNTx16J0KKQcD76dLr9Z2Omp1N2QItejbo7VHO4xEDzkqt
         C4wwfUOam/1SXXWEf87IcA0JWkVWvRAoDFOFMeLrKMGMSwNCKAMztFTF6rKSkXr8wPXZ
         Lo4Ikf+wAfPtlsuzBQea1uokzV3whxc34t3DacgDHP/UbClvL5JqjsumjAWLmNUvP1c3
         DW0Pbjwmyn/Y6B+lYzMjbgrL1vWD3kW2a0JKNzzDG2C3op2Fh/UfSFlJluifnUWxnrDr
         +0Yl1hKZ45oOOICXOTpEYHYo+0qTOdAxM6kWRNooX1zHFWwRGFJTK+03Mbpcng+1tZFg
         AJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656968; x=1696261768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+2yILMg5RefpLAOUcXf0dyQqPNPRMS1MIKyTbaudkU=;
        b=jKKCtG/6zNb6oE9NbnSLL8R4sZ5g5sN/4XCg9F6CLxWxNZU8f9wVCUmmD641G52svV
         mSX4rJy0uo9VUK3mAcQhaZHA/vFOt5Qokp7GuIIAPkgI93ZgkI3TQLCAexsp0Og6UAh5
         Yc8DIH4GhtusFcvs/Rab7d94MIsJ3Wc7DhTqCLWbE8KtxfEj+fMXDc7b3+HlUi7NC2zd
         JjMRs2+zeZtQ/5uml9HXmGSU7hQ/E9eFdYEcsXwz4GZveQEVV9JNGqLJd8WO8w+m1G/d
         mVbb+waGa8+kBzvt6l10bhlAqTkwIdoxk3YnK+vWaE84MUId5LjW2H5f9kgS+//1OdZH
         4MRw==
X-Gm-Message-State: AOJu0Yw1jnWZnvIqX2IppSNan9O0DsGUSuAlXLBB6jv8u5dG/Rm7i/Kh
        aJBUNRSP1wnLK8RExfXGLSjTh8udOpycmHizsChvbw==
X-Google-Smtp-Source: AGHT+IFYkqdHGdR2kidRG0+OQJ3JZy4ns04TrE9mQfEctcI2HKnQVBN8IKTqK3yiB+rsC3sTovi9TNXTeTFItzaJioE=
X-Received: by 2002:adf:fe09:0:b0:323:30d0:5c4d with SMTP id
 n9-20020adffe09000000b0032330d05c4dmr15309wrr.19.1695656968282; Mon, 25 Sep
 2023 08:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-2-irogers@google.com>
In-Reply-To: <20230923053515.535607-2-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Sep 2023 08:49:17 -0700
Message-ID: <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
To:     Ian Rogers <irogers@google.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Builds in tools still use the cmd_ prefix in .cmd files, so don't
> require the saved part. Name the groups in the line pattern match so

Is that something that can be changed in the tools/ Makefiles?

I'm fine with this change, just curious where the difference comes
from precisely.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> that changing the regular expression is more robust and works with the
> addition of a new match group.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index a84cc5737c2c..b43f9149893c 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -19,7 +19,7 @@ _DEFAULT_OUTPUT =3D 'compile_commands.json'
>  _DEFAULT_LOG_LEVEL =3D 'WARNING'
>
>  _FILENAME_PATTERN =3D r'^\..*\.cmd$'
> -_LINE_PATTERN =3D r'^savedcmd_[^ ]*\.o :=3D (.* )([^ ]*\.[cS]) *(;|$)'
> +_LINE_PATTERN =3D r'^(saved)?cmd_[^ ]*\.o :=3D (?P<command_prefix>.* )(?=
P<file_path>[^ ]*\.[cS]) *(;|$)'
>  _VALID_LOG_LEVELS =3D ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
>  # The tools/ directory adopts a different build system, and produces .cm=
d
>  # files in a different format. Do not support it.
> @@ -213,8 +213,8 @@ def main():
>                  result =3D line_matcher.match(f.readline())
>                  if result:
>                      try:
> -                        entry =3D process_line(directory, result.group(1=
),
> -                                             result.group(2))
> +                        entry =3D process_line(directory, result.group('=
command_prefix'),
> +                                             result.group('file_path'))
>                          compile_commands.append(entry)
>                      except ValueError as err:
>                          logging.info('Could not add line from %s: %s',
> --
> 2.42.0.515.g380fc7ccd1-goog
>


--=20
Thanks,
~Nick Desaulniers
