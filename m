Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5F7BA5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbjJEQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbjJEQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF21DA39D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:45:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502f29ed596so5849e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696520721; x=1697125521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX8UjF5DOaU9Dh2iocwbm0C+QFn3F6aBNSMI29Aiai8=;
        b=VQOscCFBpXf1ZzW3MV55ZIjlNuW+7yhPaMpVP9lj0FC44j27F/2Pjfmg1vqINrYfQC
         fscsyUlsVo5u93HZ01rFgKVne5TT8C/qqNNn8xmyTxPytOrxolNmLXctFhgExw+4WtwO
         Sp4PE+CMYPwT9bxeWL8Fy5X7VESSDVRAbvfsGHxK2izsEFfpDOMlKRh59Ox31ezNUsp5
         9xSE4H9fYQ68ShjOoVKTYqFzjBkYwi2RUO7nuXDBbevMVDk7UMOAqIIxXTElLe1eJ+L6
         yYwgW1yJxfM6fJJKhQUGd/RrxZ/HixUIhs5sR0IeP0zOR9rlSRi9qC0sLOIRlqXEkHyn
         F3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520721; x=1697125521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX8UjF5DOaU9Dh2iocwbm0C+QFn3F6aBNSMI29Aiai8=;
        b=E3AtCtq9msXcFjXRK04n1vptx5Qs2OTt1NzFDZWUWIXRRnfhJvqYyVG01sDx+qLewS
         sFNT0YPnHzr7oj9V3Ttnhp8p6TLTOUWTN5DzoKLDY5NkXlXjUa2+MTUstgJUNo3HtHyh
         A/o4wXeu7xkuJEfT/oN3CMfT/3se3cOh3NcdxwnbVflcyHGfg13AD7Ec20ImB+fFh+T/
         50oCv/aS2FfKOV/Nop6EEEIXt/WCPjlfHwDcFwuDe5oi1I6WvA2+Vdo8l2SSiJmyHpR0
         1uwpaISkndK25kUYJ+F6cB/mTCO+LXEMU0JYxHdhzcryf0aW4ebAx7rdH/dYF8nziUGl
         Jc4w==
X-Gm-Message-State: AOJu0YzvD+Cp/r2mZsmtD8VOBbwg23e8LS0Pv3P/liQacwZmT2PjF4vQ
        6upHmlFbz+3iOkoLPvarARa/7kwd1wvRRwHvaFFKKQ==
X-Google-Smtp-Source: AGHT+IGqWYrP0bU6eH51+KA9yozaWEkGtoya3hyr8M5/z64fkCqqmxjqLX8ue9OPpGidRiBJF9uVILyMf4ypss3Co70=
X-Received: by 2002:a05:6512:484:b0:4fe:ffbc:ac98 with SMTP id
 v4-20020a056512048400b004feffbcac98mr43473lfq.4.1696520720865; Thu, 05 Oct
 2023 08:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZR6+MhXtLnv6ow6E@kernel.org>
In-Reply-To: <ZR6+MhXtLnv6ow6E@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 08:45:09 -0700
Message-ID: <CAP-5=fWtX3_bmBHbeEskmM4rzX-r1LAhE8_kaYy8WueUpKCdUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Add missing comment about NO_LIBTRACEEVENT=1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Oct 5, 2023 at 6:46=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> By default perf will fail the build if the development files for
> libtraceevent are not available.
>
> To build perf without libtraceevent support, disabling several features
> such as 'perf trace', one needs to add NO_LIBTRACEVENT=3D1 to the make
> command line.
>
> Add the missing comments about that to the tools/perf/Makefile.perf
> file, just like all the other such command line toggles.
>
> Fixes: 378ef0f5d9d7f465 ("perf build: Use libtraceevent from the system")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 98604e396ac33643..456872ac410df4c0 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -69,6 +69,10 @@ include ../scripts/utilities.mak
>  # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
>  # for dwarf backtrace post unwind.
>  #
> +# Define NO_LIBTRACEEVENT=3D1 if you don't want libtraceevent to be link=
ed,
> +# this will remove multiple features and tools, such as 'perf trace',
> +# that need it to read tracefs event format files, etc.
> +#
>  # Define NO_PERF_READ_VDSO32 if you do not want to build perf-read-vdso3=
2
>  # for reading the 32-bit compatibility VDSO in 64-bit mode
>  #
> --
> 2.41.0
>
> --
