Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FCC772C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHGRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHGRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:16:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16F2135
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:16:40 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca3311b4fso3768750a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428590; x=1692033390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5CtEHiWVLExiLVk/Ne/a8yYfKyE9Ijl7i0zdyKzVeI=;
        b=bFnA5CRZh30H13fPfTiRB9CyHKmj6VXYz6mZb10lO47T83aui8WKz54b7HBYXQKRmX
         tHqydMMWzQ3Rp8IG9fZpFhjbSaPZ8o2AtkuwIUCGjEqeHOO74XtyufkznPjDBnYnxmyP
         6Uze5+AAEDoiUhSoVnqIoIwMpFthPtd+2+3Vhhm0gdhrrfNYNa8TwfmuUDWy2loprJSh
         WVowGlJflo9UVI8RcUSlkm7aKDAqjRZgFzNzT+Q+EcdFZzeCdSZvirtgct2MgUSJcVgm
         AQgJi7EfDVYO918UNryeBExbQfITp8iMXZ2zCPlof+0Vaj8kcewBr6pjrk7jE27EZTuA
         R1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428590; x=1692033390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5CtEHiWVLExiLVk/Ne/a8yYfKyE9Ijl7i0zdyKzVeI=;
        b=go0ZaDEdgkOY2IMQsvPdXG+8MeegwxJiFrCKk7BN4vjqRqXFmu50dq26CpFpAB8Ax6
         Ui3xFoj8IgXBElzUPlVhevEjXaxVyYIZGuP0tY+a8MxPbdJHETRBAN4pzHQSj3t8TEGO
         mhV7dVBO8L6yZUPb75qDEuS5abHPZpKP7hzM/8vr9ybp+vOF3z53LV1+rJKdMnODblUv
         s8BGfq6gOIDKMhAt72MzPU5RF1kLXWU15XQrYUU1T91Cj9SVfz0AyxCI8BIqq4Dr8AfJ
         bpAKVp89xZtwBQmbVZVKyWtPuwLUkq4xG6YUiv8VJqKzbCKngXTr6Y82ksK+0pufT/oQ
         QRYg==
X-Gm-Message-State: AOJu0Yw4z2aGI4qwvvwBxSDtsA+TKkr/os4ua8xwy2jRUTk5EuggPYYc
        5qPWIgF5F0johI3l+P5LDyHchTt7/ozDvZwjyag=
X-Google-Smtp-Source: AGHT+IEgTjnK9hGLkMHPf4Qxenexm4p/7TOxnImfbCWdfyqCojlj2U0TGwweco9fJe4H8S2um4LGUggd+ojUPFqpTKM=
X-Received: by 2002:a05:6870:350f:b0:1b4:685d:55e4 with SMTP id
 k15-20020a056870350f00b001b4685d55e4mr11894587oah.39.1691428589952; Mon, 07
 Aug 2023 10:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230802063529.11608-1-sunran001@208suo.com>
In-Reply-To: <20230802063529.11608-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:16:19 -0400
Message-ID: <CADnq5_Pf4A=ABS+QJp9DkNxV1PGdSSpQtRQFZLuDpJqDAZ+0HQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in cik_ih.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 2, 2023 at 2:35=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/am=
dgpu/cik_ih.c
> index df385ffc9768..6f7c031dd197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -442,8 +442,7 @@ static void cik_ih_set_interrupt_funcs(struct amdgpu_=
device *adev)
>         adev->irq.ih_funcs =3D &cik_ih_funcs;
>  }
>
> -const struct amdgpu_ip_block_version cik_ih_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version cik_ih_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_IH,
>         .major =3D 2,
>         .minor =3D 0,
> --
> 2.17.1
>
