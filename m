Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB6760149
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGXVhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGXVhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:37:35 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C210D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:37:32 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b05d63080cso3793725fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234652; x=1690839452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkeAJxpiQ/idMwH3oce7flspbZxR7pnAxBD0GoiDwWc=;
        b=qJcNSDACykX0wO7dRF7oZEWaBkrZyE16690N+KDWr4dqJ7KP5eogFOX8iScGU9tRf6
         RalSvKV4aisQRDuU1UVStNC6KicOiblnyLw5fKZaRwmsHDjhyjas7tO+3TbfGaHgQv/D
         bNjkDmp4Mn3Y23O1t9n+OSJNbE6nv39gp6BRcDK7AtkzL02oPnRbsyEBu2ozsUKTJ3lz
         eeowAV4EaUj06x5dyFCynqNNHdcIFmbNNxZzY2V/4OJXyrZs2C6OXjdOzeBkgsi8MoQ5
         Yof3CcpZQulvMICOKHbRGtp1o22d6WjKD+11vnIxgvLYH4/oNfumYLqm9DB37VuOtsNd
         1UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234652; x=1690839452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkeAJxpiQ/idMwH3oce7flspbZxR7pnAxBD0GoiDwWc=;
        b=YxDW1B6da8nwvWxlXQv0PrCz2IvzjlD8khvkdIy7fJ1iNDJfcJH6KFLGR3Wdvv1TvR
         SmvAqbhn7RNPCHvhvPfriDOYXBbgr6u++7ohziRV2TJUt0R/WsLrIR6z7xX55xFH4RK6
         +LhpUSpw2ZUznue0ZR3TIkEkKNC30QtIOsrJgMOlFzAFEjGkCd1JyBky6uLjCSrvfJrg
         uhwWf0nyeSloeowETC+uGWJBL9suk7YmRKcrdR2WernwuPWjWiliKIA7I5qbQzjmLsxF
         /AK/Ku1aKP9HA4Ozbqd5WXUdNI5mj0bQOc5kYbvZMqD8Sovl2mXGGYudEd8lk6a22Be8
         8rcQ==
X-Gm-Message-State: ABy/qLa/qIL4kPIlcUjvLHwb76T49d0Diqxqn0COc4TdDv7DAGWlhkV/
        MNUaSJBGA+kgsYcV9EowMNn27ivKCQcNSQHD6VA=
X-Google-Smtp-Source: APBJJlGfrk7DFyXtuArhwvbQsVqEisNZyrJjTn2guuq84bwAVoiRtL89ugXI7wZM8khf30yUEb9pTY4OQLTWdMWRiQM=
X-Received: by 2002:a05:6871:90:b0:1b0:7078:5889 with SMTP id
 u16-20020a056871009000b001b070785889mr13832510oaa.12.1690234651777; Mon, 24
 Jul 2023 14:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230724031126.7694-1-xujianghui@cdjrlc.com> <3a9a96f2b98642a86bdc33c3149cac97@208suo.com>
In-Reply-To: <3a9a96f2b98642a86bdc33c3149cac97@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:37:20 -0400
Message-ID: <CADnq5_M5ARBP2mV07=5Yv5U5UhEchDCB2L00z-hLDQqDFkNS9A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: that open brace { should be on the previous line
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 11:12=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/ni_dpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c
> b/drivers/gpu/drm/radeon/ni_dpm.c
> index a101ba00ea30..1cf4de4cda23 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -625,7 +625,7 @@ static const u32 cayman_mgcg_disable[] =3D
>   };
>   #define CAYMAN_MGCG_DISABLE_LENGTH   sizeof(cayman_mgcg_disable) / (3 *
> sizeof(u32))
>
> -static const u32 cayman_mgcg_enable[] =3D :621 {
> +static const u32 cayman_mgcg_enable[] =3D : 621 {

Something weird here.

Alex

>         0x0000802c, 0xc0000000, 0xffffffff,
>         0x000008f8, 0x00000000, 0xffffffff,
>         0x000008fc, 0x00000000, 0xffffffff,
