Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7979106E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351040AbjIDDgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjIDDgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:36:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADCC6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 20:36:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414ba610766so135791cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693798606; x=1694403406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9nH/6/TTQDAG7adjT3U+XyBZqgj5QsLIPK6YrJMS58=;
        b=eZqGekTZ1wIkHhJwNVnu6XBuZHTErox9yw2UUIbLgI9pYyhR8/0erjwemt4A0xdtxh
         xrCd4GdNyZDRfYbEtXad2muj6Vxg44s2YQ5APas8bPtgD4QWdn3Zs5bxP99rXQ7qFtlU
         09z6FELbkEDpGMGl9IRPK5rFkzfqffusfM4BFYiNXb4/IddXM9XrvDs9A5CMMsuJnLIV
         mXiA6HYgezQe6EEbumRqoFLClsS2Xoq4Fvw8E7SJyZfXFU1tC33LI8tB/7XeLS2mhda9
         GWEgZAaFIy9g1NeNXKJ4HBcUQBXY1pnGvXAecsNiaTSHHfZZguePHOjwxR3eB7TrrQR0
         POJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693798606; x=1694403406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9nH/6/TTQDAG7adjT3U+XyBZqgj5QsLIPK6YrJMS58=;
        b=GGRk1zFVV3+FxZeC9nT5vo32EXzzAuw9uJzP7QAzW1cpX7k9cDBGw8Z6yw7GynqzhW
         LK73lX4qf6SxfWpzygDSIdl3InAR9NWFXD560z7HDJNOzwarUofUb2LQP/uw9rx0qacL
         mO515mUtbt6nMAqLISZB66YjeOqBLwO1mWi+k1A7I3/1aAbeEVWcCi9rb19NEgfDAbxa
         M3UDKAwSvRYT743F/oTtV8e1MAptxaVDXl6DPYoaibJiJeF4sitzwoT6DqzIhA9MI/DR
         2rfdZbXXrd2Xf9ki56dgFX2+KJbDaVNkhSVyJGlgqP6bidsFdH+Z3Qx2WShf9Tc2W4Pi
         vv4Q==
X-Gm-Message-State: AOJu0YzzT/I58XEFIjqrcRHOEvzXB2qjlc7bO7EyKpV+mrhiW6mc4zwx
        uDfRBgdQnol3rJMlA+vmnz5mW4Wd+U5UPo3gCeNmqg==
X-Google-Smtp-Source: AGHT+IGjcPytkF6/gVWXpaY+XEbXMXdofr5GrFxRTqVaB/j7HTAZGRZPwCmNM6RMt6lkZDrNnux642mhwRCZiN8eCXw=
X-Received: by 2002:ac8:5bc5:0:b0:3ef:5f97:258f with SMTP id
 b5-20020ac85bc5000000b003ef5f97258fmr233379qtb.16.1693798606484; Sun, 03 Sep
 2023 20:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230901133716.677499-1-james.clark@arm.com>
In-Reply-To: <20230901133716.677499-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 3 Sep 2023 20:36:35 -0700
Message-ID: <CAP-5=fUE2jVDXCMszLDTmrhJ67mXi68yt1581i9R42G80p=QsA@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Bump minimum OpenCSD version to ensure a
 bugfix is present
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 1, 2023 at 6:37=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
> check"), the exception that was added to Perf will be triggered unless
> the following bugfix from OpenCSD is present:
>
>  - _Version 1.2.1_:
>   - __Bugfix__:
>     ETM4x / ETE - output of context elements to client can in some
>     circumstances be delayed until after subsequent atoms have been
>     processed leading to incorrect memory decode access via the client
>     callbacks. Fixed to flush context elements immediately they are
>     committed.
>
> Rather than remove the assert and silently fail, just increase the
> minimum version requirement to avoid hard to debug issues and
> regressions.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/feature/test-libopencsd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/=
test-libopencsd.c
> index eb6303ff446e..4cfcef9da3e4 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required featu=
res
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
> +#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >=3D 1.1.1 is required"
> +#error "OpenCSD >=3D 1.2.1 is required"
>  #endif
>
>  int main(void)
> --
> 2.34.1
>
