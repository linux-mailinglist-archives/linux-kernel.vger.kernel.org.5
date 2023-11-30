Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E97FF8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbjK3R5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3R5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:57:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED9131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:57:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso3415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701367055; x=1701971855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iibl1Xbm3GB8W/wJpqz8MDirHOnwc3sWdRrSTTEFiCY=;
        b=IEqQUT45g2vV8C4ZcEI5BQ0dHUqzhfWW6LcbWdGmcLiA3WgOtSKUfwmCI5nwZpZAIs
         82QQs3MaG4O8hI40EO6zXmSegLKF1QdiVO2jhx8Yeaxr2TcL9kdEIk/JDlgeetvVvgT6
         hDLd6gD42lq040PYpYyiingWCnzTFGy8C94BTaqOQ35V3Br7SvIjvt3FAIIOEzyagEYE
         GJOksbEbHWlO5vPb/qcfLC2vaPlHQMv4dagbR5cOAy+ivxcHz0ht4zs3aaPP5TT2IZsX
         ZfAGtCs4QvYeXzMR49VuQIkNwb1iq+wyG2r3ckmgIbhpaI3cf3Mx27U2kdssrxUHwYuJ
         ry9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367055; x=1701971855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iibl1Xbm3GB8W/wJpqz8MDirHOnwc3sWdRrSTTEFiCY=;
        b=hexze31t2nE8oMOc22bJbHRy4MwkVU9WcjqSOlzongEFzObvXZD3NHK1eSXqJqEd7D
         H1HjZwhrJ2ZUZl5dR3XgpZyLWHnw/oaLDIZcgSNLzwjS2boEW/2M132Vw67mTNLOvZdH
         hIs1az2RcbA6+zZay0pxV54k++72wYI+L0H4HQc3d7jnkzydeZ/X3FCrZYZh3iwEGp4v
         E9bQx4vOOTQFOmNF54ctzfJf5WNyVNxapQnZXceplNjp2eoG2d2W7+fMRuHQ9v1OoWtl
         ViFh5yvqN1EbN0WTuHbBsF54wXqb5LdluS4teSqBBPqXjJIgWHjVNAtbHXGumDzi7LWA
         17Ow==
X-Gm-Message-State: AOJu0YzqhxBDCc6V5NadvVTfLNE8Qpw1sGJzMbOOyHqU/63B6lCJlJnw
        e1X1M/uwslzsdubQ722MmOv8MjqeLkh+Gvk1lHdTVA==
X-Google-Smtp-Source: AGHT+IEpGD0t7I0UEuDM+s1ijAIH0PtY0u4nBUtoBBjhJ+joazqMED3bm0OchkfEGpizhKskl6P3GzHGSmXuKcad5eM=
X-Received: by 2002:a05:600c:1d10:b0:40b:2979:9cc2 with SMTP id
 l16-20020a05600c1d1000b0040b29799cc2mr159073wms.1.1701367054801; Thu, 30 Nov
 2023 09:57:34 -0800 (PST)
MIME-Version: 1.0
References: <ZWjDPL+IzPPsuC3X@kernel.org>
In-Reply-To: <ZWjDPL+IzPPsuC3X@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 09:57:23 -0800
Message-ID: <CAP-5=fUkUnaGkdPoUWCQBWkTKdWX5KXs7drR34x1bUW6JRJY-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] libapi: Add missing linux/types.h header to get the
 __u64 type on io.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:15=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> There are functions using __u64, so we need to have the linux/types.h
> header otherwise we'll break when its not included before api/io.h.
>
> Fixes: e95770af4c4a280f ("tools api: Add a lightweight buffered reading a=
pi")
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/api/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index a77b74c5fb655a8c..2a7fe9758813172d 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <linux/types.h>
>
>  struct io {
>         /* File descriptor being read/ */
> --
> 2.41.0
>
