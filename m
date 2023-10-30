Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556EC7DBDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjJ3QbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3QbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:31:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C54D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:31:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698683471; x=1699288271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUgGBhAUq575qSM0tgYzZcW8UZXPwajt+t4WCeUOLCQ=;
        b=PYtjKeP3xWMUHCaNKBciZ6y+/Nz/MgPTltDDMjuZRB80QQRN/1WeWbqFypAe5toAsA
         sLels+uJbS0zwEah+8/jaB7O/wgYX2qhQcTdlV/OR/D7pRkRyij04JH38v/7l8V8J0ty
         eHLAhBqgOJTZs7UgXteOKbs7+qHU/jZC472WtdyEv/UZ7fBB4UtI272frD6bqxt2HkS3
         IF6d96cuK8FWBP3nEHKiQ8uil4Ml9EaVZckCs8fIzbYXESWnylj56D7WRdQvjk6w6CpG
         zS71o1RYdPP49GW7UOrA5ls1e1/BdEMt3mXpABN5aFmHHE0Uxkf9wrqOFeHirL2vzf12
         kp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683471; x=1699288271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUgGBhAUq575qSM0tgYzZcW8UZXPwajt+t4WCeUOLCQ=;
        b=SclaHUCS+p9DGjvfFCYo7KJchsu0WHU+saVD1eFv7qH/MY15NE+TXeVhctFLJuBMnT
         nGfAeb718HJdahM2wr1dXWOdZriz1O38xiz/hL/Gixg1XHstHAC2KdMdfbYX0yNNbMTN
         gBf8KslZUxKrAXUkRyNzOM3AzGQv2N7JjQJcKGiZxThaem/bM7T8ohiuZlxYf6ghjS++
         1OhQrIjFspVFvj8km4JkeZxQxgWEeF7RXg6AAwRzR3uU2fc3prTGzr3CKQBZOFam/2E3
         g3jtQLnUAt/jD2n6NYqKL92JwMBjw8ZDab22gkDLq9gVz2p2Uw1Y7JwnaJFxJ3h66gdX
         qaYw==
X-Gm-Message-State: AOJu0Yx6B98khRmmb3ApxOTc/nhUJyC4MsRI01DNx0kcVpgZficaSmBV
        tu915L7rtbyrrkXg7KVT+N6XBK+BSmMvDOsfkb+PaQ==
X-Google-Smtp-Source: AGHT+IHM2pKPoSKXK0V1dT89nWBjcKgKADyzPqg7Dy8ofLAEmOfvrHnweUB3255UvW2FTBui8efpOki/sgyWCoflaoA=
X-Received: by 2002:a05:600c:1c81:b0:3f4:fb7:48d4 with SMTP id
 k1-20020a05600c1c8100b003f40fb748d4mr134778wms.3.1698683470764; Mon, 30 Oct
 2023 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
In-Reply-To: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Oct 2023 09:30:58 -0700
Message-ID: <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
Subject: Re: [PATCH] perf tests:FIx spelling mistake "whic" to "which"
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 30, 2023 at 2:12=E2=80=AFAM zhaimingbing
<zhaimingbing@cmss.chinamobile.com> wrote:
>
> There is a spelling mistake, Please fix it.
>
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index 61186d0d1..97e1bdd6e 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -188,7 +188,7 @@ static int test__attr(struct test_suite *test __maybe=
_unused, int subtest __mayb
>         if (perf_pmus__num_core_pmus() > 1) {
>                 /*
>                  * TODO: Attribute tests hard code the PMU type. If there=
 are >1
> -                * core PMU then each PMU will have a different type whic
> +                * core PMU then each PMU will have a different type whic=
h
>                  * requires additional support.
>                  */
>                 pr_debug("Skip test on hybrid systems");
> --
> 2.33.0
>
>
>
