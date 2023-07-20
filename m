Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE15475A51D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGTEdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:33:11 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA219A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:33:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so128681cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689827589; x=1692419589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Wv2sXy6dPs6y1IoEF3FQ9f1Jy0jfZNRNNhi4fWntI=;
        b=JMMTrSfiyjx7CON1Qej5uXP27SMvtJ0VVcu7XUROw4D3rwADg2hKHrftk0wLx082Vu
         1TXTFGZoTaBb5lW09UjKdU+FRddJ2qboVf1kv3D959FKiUHIQ4ia4mIDaym+bNclOiVt
         TVIEx6UUJNvJ3sG8tBxev2Cgsi79ym0GxYCB3CYYWoKVIrrp9jHDIdc7OUFZu/qk/WKp
         3qlp8+x7EEkjmPdNpd4gPjO18z8OBeUc2O3xdmS2Me6/0a/gu9VYX0Dy689Cz3g0baLw
         pBxsHZZA9BFpRwIg12BJRCJe15vmKmmde0xgDNCPtE1G/Ju47OzBDPDoioJHWzxzYA/i
         duYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689827589; x=1692419589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2Wv2sXy6dPs6y1IoEF3FQ9f1Jy0jfZNRNNhi4fWntI=;
        b=XUIxRudksO7dGvyP7x0OPXGMydeZgMgcY1X1YgHX3DshLXfnKAIlNrzAcz/2rA9KF6
         KnzRvEzbzlQX8D+yWKraN0dWdB5bsg4ChMm2RsLI63qyMTW5nAxFVAa633ipBPm6Ka5L
         Arf7spOg/FHLwpdpLTZ09rbOJEPi87vgx4l/R/jlR/bdp61jbRJrgyFr3QW5UBHe/hQT
         t3HMSQQNAgmczLzybW/GQq3M62beOyqXk3f0xkAWfxT46FostVl0BimzuF3Trzvnswxk
         i/yznWOWjyrtR+97GxHwsb0D9d0KVhvXqbbmoWr2dpjw+eS3r2vXHmPrHJURODolQydf
         GM/g==
X-Gm-Message-State: ABy/qLaLf69+14EC9U8vri2IcvRYJWdIi7ZfT/SttfaP/dSdMPkmFMT8
        Hh1kwQZyDRXV4FLHWgdmIERgqVkdUV6B+mYiHkJUGA==
X-Google-Smtp-Source: APBJJlEhNIa45NPT4/vzKTu/RdxY3ac7TLMhTaAs3LseOWlIwAIyrb+96NnNlFgFJplZMkHXZ4JNWCz25Rdd8N2Jh10=
X-Received: by 2002:a05:622a:120c:b0:3f8:5b2:aef0 with SMTP id
 y12-20020a05622a120c00b003f805b2aef0mr162550qtx.24.1689827588632; Wed, 19 Jul
 2023 21:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230720034022.31937-1-rongqianfeng@vivo.com>
In-Reply-To: <20230720034022.31937-1-rongqianfeng@vivo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 21:32:57 -0700
Message-ID: <CAP-5=fXQY1T2VQxs2ZBX_9ksuVfYvvzA6xSeOUpSQ8Sz1eJv_Q@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: Two typos have been corrected
To:     Rong Qianfeng <rongqianfeng@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 8:40=E2=80=AFPM Rong Qianfeng <rongqianfeng@vivo.co=
m> wrote:
>
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>

Snap: https://lore.kernel.org/lkml/20230706094635.1553-1-luhongfei@vivo.com=
/

Thanks,
Ian

> ---
>  tools/perf/builtin-diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index e8a1b16aa5f8..57d300d8e570
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
>                 struct perf_data *data =3D &d->data;
>
>                 data->path  =3D use_default ? defaults[i] : argv[i];
> -               data->mode  =3D PERF_DATA_MODE_READ,
> -               data->force =3D force,
> +               data->mode  =3D PERF_DATA_MODE_READ;
> +               data->force =3D force;
>
>                 d->idx  =3D i;
>         }
> --
> 2.39.0
>
