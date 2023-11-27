Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7207FA81E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjK0RfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjK0RfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:35:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1510EC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:35:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50ba8177c9fso6231e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701106503; x=1701711303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qraohhsDJyV+XLYjquw/kxd3mqLCTJ1OQXeXtBtQ0=;
        b=WlV1PSJfIoXjvV7PBB0M4WA/2Cole0AGBQqsNcqTq0KRgYZYtHjKxK/zEsGrU9yQIW
         La5Zc7tH+ZXjNmJ38/JB8nfabHO/bCYwWaKZ4u2hO+YKsePus58lx2jmNGLVdoMQaBS5
         MtnUPIHp5jPFGlZloBc6DaJGSTGR44lWpl/4hGtl01DFyrucEDgOsAg4f4iXNBsHNpsg
         sAYfkTskwuT1QAkzsnWBybCBb46Y83+l8alkYRyley5EEM7ycD5OJe4dBryZceq2GFUz
         ClGD6AsKlZDAd5bMONtyTW16rlkcjfiuzt6jD/GQTGkMnKDp6Afrk+ASR2N//y88EHbY
         Z+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106503; x=1701711303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0qraohhsDJyV+XLYjquw/kxd3mqLCTJ1OQXeXtBtQ0=;
        b=XzEOlEn+USXazHP9CsitApET1Yfy9cTKkLXFE8hLDIhujKnz+2uqaPuZzXXkyZbqNQ
         8dloFnnS3RRNI5GsS9TVVYA8WLm/ofYfN/7603Y1/FLkMliI88ozf6l7p0pXZOP/AfTJ
         5R9UK8dPudSFRh4OnqyoWsSIqle6mMCfAkuz2LHwz0X5efNjFwtfVQaAKc4tv0lz0Oo0
         Q10H1p7+1ALvectGTjaKO1rqxgozfO71092JbZ4SJ58ac7EOEFLIuVJa6wy9LzQISVzt
         qcvGEMoKySl/UH8Dh5sJKMAM8R37q9oRRSZ88Owabr4xioGgm0w3TvDfExKTrszcgaf2
         or4g==
X-Gm-Message-State: AOJu0YwlvgMuUVsW4TlUV3KMFQtAlepQ/6BA2lEbn9tuchZuTt4CM/Nw
        21DDT38Ny0Qk1DRzXzG6eb54/z25u67bI4Sffx4t360SHavdrSo3D/Et/Q==
X-Google-Smtp-Source: AGHT+IHd5BxJVNTF8NcRPo4AZx8UX60AbY/mQ4TL0i06Q0/uZoT+ZXYYVz8M9737OLOSpV3v5Ha3SgJzZrr0AEXRSIQ=
X-Received: by 2002:a05:6512:239e:b0:501:a2b9:6046 with SMTP id
 c30-20020a056512239e00b00501a2b96046mr544129lfv.7.1701106503002; Mon, 27 Nov
 2023 09:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20231123075848.9652-1-adrian.hunter@intel.com>
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 09:34:51 -0800
Message-ID: <CAP-5=fWnZ9bWCN49v0NhWsAVVYOVOhpyV8x7pMOvHUjeQBtang@mail.gmail.com>
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are some small changes to help reduce inexplicable perf test failure=
s.
>
> Regards
> Adrian

Thanks for doing this!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
