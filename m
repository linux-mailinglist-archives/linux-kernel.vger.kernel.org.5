Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194D772A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjHGQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHGQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:07:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF04E78
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:07:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a741f46fadso3477217b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691424420; x=1692029220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o9SBVPzxyZdcldhRu9dD8c45lGIBGn38eeuuL6Ze0U=;
        b=PH+n3uy8x2QtON55O5Vtf1QADgE32iiYBwxE80aaHxP04ejgQ+5CIAZAM910nQ5LyU
         yBRPXpTb6b3/S56w6eD0uTlN8ss5uMFuZ2sgThPBO19HD0BMpePH6BsSH6nL7p1cYLxk
         05GDy8lb/9z9nShBWmuJlgTzHI7xTJGwyoqkcWg99Xp+4tBCvHs9LOBsEQO7EOlexak2
         ZAA8928oO8LCjC4YhdG2EES5NkC1RzOqO0O/uW1X3OFyDIk0bQ8OcADzAdCeHPewc0Nd
         7Sb1UorKxGb4oHO3tZS3jZbhUdnoOBgYMfQ9RnjTUtv83cYQQer/2RQ2fJPZK0XH0v+Z
         Lc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424420; x=1692029220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o9SBVPzxyZdcldhRu9dD8c45lGIBGn38eeuuL6Ze0U=;
        b=jWnKnhnX0FQ3+z/wBvNCK+z00ZymDdc1sKEAozFsN7CKx0wje4/JYqA0Zhi63jdGqZ
         TS55B4ZgF/VzW4e/umyQz0weo1Mzbg5vuMxJTXp1VwPeFtEMElnDIWrHdK1ZrPujlIDs
         yBtopsUnY6Ff0oLFjvHPrMnNvsQDOMnxwfxv97n1+BhiuO8z8NVRLuX0eDYUyJYZ2Sil
         xHgPSJzEfNsRTqfyV5JTPyBaumqAMwJV3fJC4KVTib2U+J/BzdxjwA6cF+9487CdmkP7
         evbZt1LvuLVH5gZm018cqvcJmj8LuChHLb6EwmDpx0igNVg5ysKl0xeTIfDr6ti0gUpc
         iQIw==
X-Gm-Message-State: AOJu0YxhZcIN8i2aipvEgmHSZldzlDZhyRjiD/yMdvibcXBK23m2fjro
        pCnBbM1LntxTXwkS4HNnQW7Nm5nBGxBXXSjnvrM=
X-Google-Smtp-Source: AGHT+IFWQmuBYiX4eO8MVzB+m38ZmimznirBldbEBm1Ubp6pLNvrWg5ea1IcokTSNu21NQG/DUFs/U9zAhIymcQO700=
X-Received: by 2002:a05:6808:152c:b0:3a7:8725:f37c with SMTP id
 u44-20020a056808152c00b003a78725f37cmr7468703oiw.10.1691424420477; Mon, 07
 Aug 2023 09:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230803141116.58883-1-arefev@swemel.ru>
In-Reply-To: <20230803141116.58883-1-arefev@swemel.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:06:49 -0400
Message-ID: <CADnq5_MSXxaAnF+4t1X_v0enooY5Xb8BSpo8f7pPe8g7mPT6AQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Return value of function
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Harry Wentland <harry.wentland@amd.com>, trufanov@swemel.ru,
        lvc-project@linuxtesting.org, Leo Li <sunpeng.li@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        vfh@swemel.ru, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Aug 3, 2023 at 10:18=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
> Added return value check hpd_enable
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index fa314493ffc5..bf2f620aeb66 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -1645,7 +1645,7 @@ void dce110_link_encoder_enable_hpd(struct link_enc=
oder *enc)
>         uint32_t hpd_enable =3D 0;
>         uint32_t value =3D dm_read_reg(ctx, addr);
>
> -       get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC_HPD_EN);
> +       hpd_enable =3D get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC=
_HPD_EN);
>
>         if (hpd_enable =3D=3D 0)
>                 set_reg_field_value(value, 1, DC_HPD_CONTROL, DC_HPD_EN);
> --
> 2.25.1
>
