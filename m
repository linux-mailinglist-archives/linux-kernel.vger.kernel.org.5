Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207DC792CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjIERvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbjIERu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:50:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9810804
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:34:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a88ff732aeso46284b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693935194; x=1694539994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuXglKdu7wBMuQLUcGT0g8zly354Keok7+si1kDoTlQ=;
        b=P3UgaoM4KXel89DY/qmBTgALKdsJsm6r8Zej1msjAAc7U7vF2MdEplen8I0RvLsn3b
         u/4Re5/sny6dsEFCXQ4sZ1CR4q2LnbfiS/YxNN1KKpqcZ7RI5KE2S+WjvFrqxGkuCqb/
         MAnUODgxW0nnVkwDsY1hbiZL4lunJAHO1Mn8jik/F417d8RSApO73RiTCBJyeNaZl7rU
         OUNIZrlz54SB6MimgHoJVPpcFp8Zpq0Zux3xtj528gUzf4g5A2MPMt19nejFfUx9OA+y
         NY7RG203zcr3JUftQ9mKddwKieY4jcVFoha07L3sSjubpL90e5XOTkXV7ERohKFhp+oq
         wWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935194; x=1694539994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuXglKdu7wBMuQLUcGT0g8zly354Keok7+si1kDoTlQ=;
        b=bkNyHAKBMBZ4mdLRKDNqA0GkivuEVcBYfLb/NXCF7iMSosn4fgeyfNIie/ivzR5da4
         53sqXaOVjP5cV1xnRIMpKX6AT2x2dSD7M7TInschh4T4B4slJcmr7MzslzWmAy9XH89b
         9JN1EcbYzXnhtiOa3KGOf+P9p2PTTl6E8tPakxZbmI6zB7Rya7PRJOX9misWe/Z6dkuZ
         BVwUoszx7NGtnCKEj+f9nNLJmF+GfsrUfmIG59dPedqkbM7W/Uu8OzecSSuhDpcnnzqx
         QCs5hnOBnalA/xATBt09pLrMeBhwEKYz4C109dS9HFJ7pYxUGvoHSecK4EYVm7dS6s2E
         RYJQ==
X-Gm-Message-State: AOJu0Yzk5os0htknq4hZehcHY10D0P2QQGxTXYglF1WMcZHG6/ymOC68
        QI2YaLZbr3g0LRWjc0pu5B+s0nak7PcOhJO8873xX7nF
X-Google-Smtp-Source: AGHT+IE8mJ8YaZ6KXqCsBWWGTxxwhRNQchkpzsOzcqR5Z7DYGx6GABgbBlbFBKQSaRYouW9mV6YBeOuxEQn0TKgcML0=
X-Received: by 2002:a05:6808:128e:b0:3a4:316f:7d06 with SMTP id
 a14-20020a056808128e00b003a4316f7d06mr8158062oiw.27.1693935193870; Tue, 05
 Sep 2023 10:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230901005226.42307-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230901005226.42307-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:33:02 -0400
Message-ID: <CADnq5_Pb_NvK9mqak5n31ud0GhkH09ohrdPBOGD=uOjhGj+9-g@mail.gmail.com>
Subject: Re: [PATCH -next 1/4] drm/amd/display: Remove duplicated include in dcn35_resource.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
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

Applied.  Thanks!

On Thu, Aug 31, 2023 at 8:52=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c: dcn31/dcn31_dio_=
link_encoder.h is included more than once.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> index 0386b8fb270d..7f059fc2fc75 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> @@ -61,7 +61,6 @@
>  #include "dcn32/dcn32_hpo_dp_link_encoder.h"
>  #include "link.h"
>  #include "dcn31/dcn31_apg.h"
> -#include "dcn31/dcn31_dio_link_encoder.h"
>  #include "dcn32/dcn32_dio_link_encoder.h"
>  #include "dcn31/dcn31_vpg.h"
>  #include "dcn31/dcn31_afmt.h"
> --
> 2.20.1.7.g153144c
>
