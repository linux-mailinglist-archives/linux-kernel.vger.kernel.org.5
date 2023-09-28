Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809F27B21BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjI1PuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI1PuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:50:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15FC0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:50:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4bf619b57so6484857a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695916204; x=1696521004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+oaP8TaORSoGDFnn0D8hLzy1EvVNodSU/WczEXtpZ8=;
        b=kq/j9I201k/xmnT96T4y4UuathD4ajGoMzsG430neR8uYgPItoZzOxoRKYCUFeTdfP
         GtHvFMLLVMiboTcCM1R0oUdaD091r4hL+58YFxc1JSB1Oe/eej5vYgcmXKsi7qP3ASLn
         GCFNnx49QEslJbuMuxXbM8/Ivh3Cgg3ecHQ0/jWMYH0Qw0xIjq7gdcRSuAkHI3yWZi4g
         H7fsvSfddd011/m3cXYEQXxtC5XwSg3VebSrjnUdd8I6P7ofb1Hq4QpwWUf7a7C7mJ8K
         8QzYBXgWWT5v58X1w5oXydGDKrndlS5dqcscMpcwlpZgfP4rdeUSJZjFlrJZ7uMDPNnD
         mEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695916204; x=1696521004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+oaP8TaORSoGDFnn0D8hLzy1EvVNodSU/WczEXtpZ8=;
        b=bny9UoxvXpR6VFUIykeOsFPYijr23+x/REvjy8POMvhjIB/GdTWWYrlRF96+602Act
         MORZ1j+beA3JH+3DJrJGvFHCoN+k5z1v7dttOOaAjczuT/8TJ9Wh0m4gBizsXJWlqqLA
         g/Zcx4U/rn37i8RnFHw3cVS5eCn5fRyOoB7s1jj9uGXsMeZ4PK56kzrB+JWzNwnA64MW
         uQ0iLzgMWXiN0MoyoiwyUK5JwSxP4DaQVAJHOzaopR4mjA3kxZXNWnqa/9q6QJdpD5jt
         5rizWpm68QwUuBR1QW6CMa3HQUnEfrDrLss07eZrtX6+6VwWEA3SDOpZmfhnkbgS/xfv
         eDcQ==
X-Gm-Message-State: AOJu0YyOJXp/tj7SQ2HodOLB9aLRmMbmyF/zjkoO/cYfrRccrlzNgJYx
        zBwdpjv8kuvEGtTXmBiQch6L9oVV7oJsZAfTItMwv554
X-Google-Smtp-Source: AGHT+IGeeO+LcOhSuz08bKSo/PewfWqhVFf6DwTscdRmWW1cU90Hw5dD4NipqycysMadRmYWLbIIjW5nT6YKnfh/05U=
X-Received: by 2002:a05:6870:468c:b0:1d6:3b5f:3211 with SMTP id
 a12-20020a056870468c00b001d63b5f3211mr1638616oap.31.1695916204052; Thu, 28
 Sep 2023 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230928094540.37437-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230928094540.37437-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 28 Sep 2023 11:49:52 -0400
Message-ID: <CADnq5_Pusu-BPRxZnn7YkykbEskL1EUmyJvJbad4AmU+SJjG0w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/kms/atom: Remove redundant code
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, Sep 28, 2023 at 5:46=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> drivers/gpu/drm/radeon/atom.c:396 atom_skip_src_int() warn: ignoring unre=
achable code.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6713
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/radeon/atom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.=
c
> index ceb6d772ef94..3082d08a06c2 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -393,7 +393,6 @@ static void atom_skip_src_int(atom_exec_context *ctx,=
 uint8_t attr, int *ptr)
>                         (*ptr)++;
>                         return;
>                 }
> -               return;

I think this should be a break.

Alex

>         }
>  }
>
> --
> 2.20.1.7.g153144c
>
