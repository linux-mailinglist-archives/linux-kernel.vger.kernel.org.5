Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F556761D37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjGYPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjGYPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:22:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399E199D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:22:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a36b309524so4203131b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690298551; x=1690903351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBTTS5RF7AIv64GVj2b4Qc7prXLaZW3IGjOwlTzQwuo=;
        b=lC8/Fq/kL5m6P1170AK5xtk0Zo8tWN7L+16SdgkjbX0m1p1bFbPzSfDQ85nvq4uhow
         bmVViJgCbKdtExT7yseMBW5Dgkk95aSwnm+v2p0z68A6adWIBwMIDRsV9k1hZ/dh59qT
         BF0ghVJj4PZvV7khI+sdW0LuDoXyU4wk1BiVMCuXHVgKil0C1UT/DgkM0xfscM8tTeDG
         80FxLV7yGk2PEZb14frViyEbbRlulFObqFm58sHDOU0q2PD9nB6fUMSVGXUhzQtywVTL
         0xmYZEwS/yVFNlB6tK0+h/hsOBWO8msdpDrRTVeAf/dnWPHREivrqCvqAsSqYpmyma+f
         geOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298551; x=1690903351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBTTS5RF7AIv64GVj2b4Qc7prXLaZW3IGjOwlTzQwuo=;
        b=N1ThWuM6vMZBJZQ5gNOkILlsM95mxM6C0wuLmr2P/9jA+y2iBQ8/5bBlOgygqP7JUf
         oaWkv4Y4+/soBTCThXO6JlqIfx7iWba+gJ11vpD9A5oqqrSy8CXeHghAHFa+0El2T1iD
         zuRCQe/Xm4gLDgkhmgp+2TmtTOFF23lkWv+ECTBLr1qIfAYN87myVMEZBHu3zQxKhSsD
         NFpQcSL1IFX3NGVKheFTxxtCPW8s9S5eiMjEEynRKXibMuCJ1dtJOSUViNq3LrgZm9cH
         XnXxLkQTf8/5fTB7tPZxy2Hw7d6NQO/VgxgV/bjkDH9aYp17o3Sx2rYatyYoGb5ABu22
         Ya2w==
X-Gm-Message-State: ABy/qLai49XbzkFPYlCLtX3P8T+NUhBg3i49sTg9ssusmBK/KGhEsGXh
        jFLrQDdhFms8yGS7pG/2D/FXMZkaCOORsmDEeROnZHH6
X-Google-Smtp-Source: APBJJlFcdxcbcpR8u6vg6ikZOSDY7y4ippoWDRSFzG6NIvfv+Vvez0j9T9fTaD+gzpr4jjBxct3l5nG4o9AQ9xFFzp0=
X-Received: by 2002:a05:6808:182a:b0:3a5:a78b:f773 with SMTP id
 bh42-20020a056808182a00b003a5a78bf773mr12122118oib.6.1690298551704; Tue, 25
 Jul 2023 08:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230725080906.2028-1-zhanglibing@cdjrlc.com> <b5933d7391b8e526894316b7e17b9637@208suo.com>
In-Reply-To: <b5933d7391b8e526894316b7e17b9637@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Jul 2023 11:22:20 -0400
Message-ID: <CADnq5_NtPtoGDhdx8CwwPUdqrk-goJU4V-FOTPn5_pNv-hbjDg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
To:     wuyonggang001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

I applied the same patch from Ran yesterday.

Thanks!

Alex

On Tue, Jul 25, 2023 at 9:23=E2=80=AFAM <wuyonggang001@208suo.com> wrote:
>
> Fix the error(s):
> ERROR: "foo * bar" should be "foo *bar"
>
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/atom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.c
> b/drivers/gpu/drm/radeon/atom.c
> index 11a1940bb26d..93acb0e42bd6 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -68,8 +68,8 @@ typedef struct {
>   } atom_exec_context;
>
>   int atom_debug =3D 0;
> -static int atom_execute_table_locked(struct atom_context *ctx, int
> index, uint32_t * params);
> -int atom_execute_table(struct atom_context *ctx, int index, uint32_t *
> params);
> +static int atom_execute_table_locked(struct atom_context *ctx, int
> index, uint32_t *params);
> +int atom_execute_table(struct atom_context *ctx, int index, uint32_t
> *params);
>
>   static uint32_t atom_arg_mask[8] =3D {
>         0xFFFFFFFF, 0x0000FFFF, 0x00FFFF00, 0xFFFF0000,
