Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5109877E8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbjHPSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjHPSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:36:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9DE7F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:36:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so42941cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692211010; x=1692815810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4wm+KpE7eNa/tlHVtHxXV1/09kgKr7KwT0DZo5eN5c=;
        b=tQfHJ/L32F6Jr3+MdbqSNqp9r/c29AmJm0EZbdmgWcmyb2DCIR8sBLcmL6dqnnAGgr
         SZ/mZPdTdtGVFQm6Pv1mSBI3eDHzRuobDWlYjiUWSdByIqH+ONbmu84TRsc8H03hHAvQ
         FMTKe9MLgom6xNDBgk/r++bem0/J76W4UpxLNNrbu75GsqxceGNBulXhX/2gjWsMfNuY
         Pq3iihUFeKflvpotcDkDT4CriI5KknDRRxTnZXwdAN3+9R1nioNfKS9wd3xycc0rBaNP
         V/j2wu1dI2kIu50gPN7/hdsAMyzuo7L0tLZaglz5PYjv1KKjljwJBs4LRm7tZ31RyQAv
         jkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211010; x=1692815810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4wm+KpE7eNa/tlHVtHxXV1/09kgKr7KwT0DZo5eN5c=;
        b=H7UjJ4lBfEf8nFWktKM5b43oGKOGxldhiG8UAmIXiUbo1rPFTjHchQiZmf+rZNVYBc
         U96LmtbVIiD5QNuhgIxeMAduiE41Hl4TitFQpLfLhZbq3Esza6sqIpDfSePWf3RcP7b6
         yXRxUyBlfdKqqenONHgt/T5bIB71KmdUeHq506hIsbtww6sxyuf9vMQLkA+wyXDBYFPC
         grJDEEdH4w2c6uQjg+kOqHZnEk6xEFSlsArJTyi9aSBpaDiur4Qio+2jWNPUmOVFvjqt
         aS91QFzzOdVDmbrbNAhmmrSQoI/kQ+Lx72RGs1GD5v/TmFDJ5NH6Yzh3Joj6cE2zxnN6
         cS0w==
X-Gm-Message-State: AOJu0YxufWB0K7HvWcm5dLy6p87tIWeJ6J3wKWTFARDU4RBJJ6w2/U/j
        ZlxgMYtBzJeoP77L4dSuLcRVI7dSFohgop1//m2zvw==
X-Google-Smtp-Source: AGHT+IGGl+mvJgrMFGu/vHQy9ub+bO649kNj/MyMwugE5GMjyM7i6xYVwCd73ytOqsFOVU7DRDQNRATYM5+OHsbemyM=
X-Received: by 2002:a05:622a:6:b0:410:4135:4e0 with SMTP id
 x6-20020a05622a000600b00410413504e0mr29986qtw.27.1692211010510; Wed, 16 Aug
 2023 11:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZNvUxbmMpa4IR/pc@kernel.org>
In-Reply-To: <ZNvUxbmMpa4IR/pc@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Aug 2023 11:36:39 -0700
Message-ID: <CAP-5=fWQ62VBhbNL96DdTEERU7fQy_sbx8xTBKXpdDNp15jAhg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests trace+probe_vfs_getname.sh: Accept quotes
 surrounding the filename
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Aug 15, 2023 at 12:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> With augmented_raw_syscalls transformed into a BPF skel made the output h=
ave a "
> around the filenames, which is not what the old perf probe vfs_getname
> method of obtaining filenames did, so accept the augmented way, with the
> quotes.
>
> At this point probably removing all the logic for the vfs_getname method
> is in order, will do it at some point.
>
> For now lets accept with/without quotes and make that test pass.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/pe=
rf/tests/shell/trace+probe_vfs_getname.sh
> index 3697f054ce1903ac..4014487cf4d933da 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
>  trace_open_vfs_getname() {
>         evts=3D"$(echo "$(perf list syscalls:sys_enter_open* 2>/dev/null =
| grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed=
 ':a;N;s:\n:,:g')"
>         perf trace -e $evts touch $file 2>&1 | \
> -       grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+=
 open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBL=
OCK\|WRONLY, +mode: +IRUGO\|IWUGO\) +=3D +[0-9]+$"
> +       grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+=
 open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\=
|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) +=3D +[0-9]+$"
>  }
>
>
> --
> 2.41.0
>
