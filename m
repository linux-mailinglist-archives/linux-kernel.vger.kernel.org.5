Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275C7792DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjIESsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjIESsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:48:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BAE1AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:48:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-412137ae07aso16879481cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693939634; x=1694544434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z5P61rHX3TJCqeK0dVJotGAV1FyleJ9U0LtLbQPTDk=;
        b=Ls3bbLfI/JDL+GsNgVoT7A4fZ8jFvpBUDbiP9Wtni3yeQLsgGOsarQ9MU3Oj314A7w
         b6JFJ8Iz+5cSb+8ulB7jqw6W0RgqfR5+uW3cagfNuVWtLOeiNJ/PaeS0NppZJU9Vm6Ku
         gLYKlA4V2t/fKEUv/D+0/dUGt7WbP6/wkPphX3K66sZZwErBL+ZkLA8h4A6oZvH9Mp5k
         1ivCoTCnepspHuOZLR0GIxTeW4gcH4k+wuMXXZutXbHqM5aTSA5NW6uWaHS4aZLqKWjt
         jUvaJudrn13e9ygNh9my7LydPVlsPrYC4ZGJlln7cmWdoBzrHMKji7KbO/BzcKSBjsDk
         h3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939634; x=1694544434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z5P61rHX3TJCqeK0dVJotGAV1FyleJ9U0LtLbQPTDk=;
        b=D813d/ox8UdOsOa19leHooAx54lADPi3xv3Xg36PzroWkIa9a3ITaHqYnHSOEHfmVJ
         gLaLLDcqTHeOwTkVX3I8eg8KG3+LoMn60zcOC9849uvCz7xGRqWDWwizHaIr9hMz9W5U
         gSbTnwo6cBWlh3bAleBqdh8Xfs0BX4ck4/mRM+q2+YvohP3tRizRlj6pdv94IGnkQTk5
         6Em9bzLJyaUTSpou3ZagegXBb5/+rEfSDAFkv84QKc0tvjZjaRJ5PtcewrL9nzxAb9cy
         NI7HCFKSnUdb22QTrUQMfQpCyf720jnqrBUpd8X504kXbROPs2tK2DstrKANoUJM6yoe
         f2Ew==
X-Gm-Message-State: AOJu0Yw1nQta44eNNMxPmEzM02JjMZM13X+61k6Y7VcaaxRrz4p/JeRL
        BTFk27xBE+MZPlBYfZL/VbQSdXEk0m12Ye1xfPRDbPl8
X-Google-Smtp-Source: AGHT+IHPib75naSjYJTJfVF7LppbLLE6k6pU+0i1iZmAN1p38X6cF2pRWpirWqMujp6N2mdrF24R5dwzOOJvBpK6oQE=
X-Received: by 2002:a05:6870:b027:b0:1c8:b82b:cbdb with SMTP id
 y39-20020a056870b02700b001c8b82bcbdbmr16663096oae.33.1693935517234; Tue, 05
 Sep 2023 10:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230901012924.120196-1-yang.lee@linux.alibaba.com> <20230901012924.120196-5-yang.lee@linux.alibaba.com>
In-Reply-To: <20230901012924.120196-5-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:38:26 -0400
Message-ID: <CADnq5_MO1+vf=SBJ4jpGab-fXMOfuJ7j=JgHBNJhaqYZsSNwow@mail.gmail.com>
Subject: Re: [PATCH -next 5/5] drm/amd/display: clean up one inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Thu, Aug 31, 2023 at 9:29=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn35/dcn35_fpu.c:260 dcn35_=
update_bw_bounding_box_fpu() warn: inconsistent indenting
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> index 525ca0ed9ea9..46eb2d0592f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> @@ -348,8 +348,8 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
>                         dc->debug.dram_clock_change_latency_ns / 1000.0;
>         }
>         /*temp till dml2 fully work without dml1*/
> -               dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
> -                                 DML_PROJECT_DCN31);
> +       dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
> +                               DML_PROJECT_DCN31);
>  }
>
>  static bool is_dual_plane(enum surface_pixel_format format)
> --
> 2.20.1.7.g153144c
>
