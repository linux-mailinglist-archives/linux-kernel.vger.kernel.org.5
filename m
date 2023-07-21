Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27775CCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGUQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGUQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:01:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DF2D51
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:11 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-558a79941c6so1303318eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955270; x=1690560070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNvscis9SxDbDG2bKAhXYHTWtZu9xJHfBIYgi94BUkY=;
        b=Qe58kZwzM0tdBHRv/Q+o1BuBSOCQmUYof9HbU82NwxLSJUNTNaPLb3Pr9eyRwjk5rG
         Bx+quhJYh/cWBfz05NDS2HdnV9enfadUFBkMUiHcrBhjN+ANcKfbvkA5+Dl8r1e4kqoH
         sjoo0FYcdwPaOwZqB7bzrgoipbh1XDE6CC9xjv4SqEVY1w7X8SD/zpFAoZDllpgDlgxK
         Jq8vhBBaOL52X1DCt8kReFkH5js5+TIB5FPvCNsM8NKP6VbIqRAEIOU09+vbt0CjP0eS
         BQrEtl87EOYvV+atvnHSPlOrB37Reo9+DtrGOuZVM4UWEVdzsoljt85wMZeCsOk00HvT
         ELRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955270; x=1690560070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNvscis9SxDbDG2bKAhXYHTWtZu9xJHfBIYgi94BUkY=;
        b=DEzGbEqAdT9j97UOsZT3mkpXJ3taIu1z4TWANjKp/Xh1nycxgLYgAJeMVu27gmfvKD
         fIW6k5C2m+O1lcmA6bPdnt1Njw/5uSQyoZLNAJ3YyeSBtHFTwbxB7y5iZ2iFEIhlX0id
         xIxu3XAbwNJe7nK8uOTRUZYuFqUjP5XjUUQn1nG9fr8gSAuMSGn8BBzgWjFSpDoDWzyl
         bZGYLr+OVbfX4s5TVlrBer+sxhljwvZPYZLQVE/ptjTSBG1XBHopdi7Q1x7cfp3UOHPS
         t4+AMo7rgpRq3BRkJ1b3qfVXGPSl1/BN9f+bA1Vf1u2D1sdu2RmSB9glyxpi2GOxtv2R
         N9fw==
X-Gm-Message-State: ABy/qLZy42kmL+MUGQsjW52XiV5F5V0c5VY08lTdEAex62WXtIjaPzXa
        X80xIZOLPAGc0RfUKjPM9PqFo7FfFKJU/9+C8uo=
X-Google-Smtp-Source: APBJJlFvkxjf9Ff4oYeV36vdgli7Jy1S21W/GOQptFqDSnAm/PA8vMgnjsi2kgq4p/okkQExoJcA2jBHFsPeiyyZGCw=
X-Received: by 2002:a05:6808:f8e:b0:3a4:4912:9638 with SMTP id
 o14-20020a0568080f8e00b003a449129638mr2865554oiw.49.1689955269984; Fri, 21
 Jul 2023 09:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230721060919.5133-1-xujianghui@cdjrlc.com> <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
In-Reply-To: <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 12:00:58 -0400
Message-ID: <CADnq5_M7SzAFpte34t3yYu+7X7KNxmGRx9Vm9nsLtcoFfhKKFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Jul 21, 2023 at 2:10=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix nine occurrences of the checkpatch.pl error:
> ERROR: "foo * bar" should be "foo *bar"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
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
