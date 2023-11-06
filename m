Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FFA7E2C77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjKFSzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:55:50 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DCA2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:55:48 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b5714439b3so2243813b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296947; x=1699901747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlsdHfJoSxj4C6+EWFlQXpykD0ggHxFHCNPoza6FO40=;
        b=JEGcXYXyC4CScc6ZVrFZfPw3v2Ua+dUG1k89AoVlg9pCjHT9Eu1SYR8vDvl5K5skV4
         5OfBi8W2OWMoTR0K3iZexKjr/jTviaGAnQn7QaaKKkl/HNn1Ne2A373UYXxhqfbMPAnL
         CX3m2yAOaJP5AqvWKZ9325igVybv8MMni7edKw4Z5AoGUY3KLVGgRyoXAjmNsOAv18Qk
         2apf4OjyTMz3tPgeZPborCJDuMLa/78nfHQYutcwIq1O8OIkLmwfT0G7T7akqPPnbVVB
         Lv9kGcqez+dlD5leu12QzoE8VfcjMCbMIf2ywtmtPFkZIMg9K6/A6SOYxsEf7s1b987C
         guow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296947; x=1699901747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlsdHfJoSxj4C6+EWFlQXpykD0ggHxFHCNPoza6FO40=;
        b=tpPjS/CuvNWzqANzPQJGuRJF+o1u1cpsIg85pWY9t8U+Cb3EGyyNMw14FwOlTN5ZO+
         /cnfoVaDsKv3fEvajd2N1lcOA6oEoq1o4g2Dkv0QDwneSTklw8vmPUSTmhY08BAScM+o
         BveqnXHd00xVlMCmXjk/Q12RPV57DYnI75LwZneRonb4uJNIHI2AHEud3PGkpPxh5ndY
         PpOMjXVZ7lPsKI0L9LwOjqpbxKU7gsb3S/X8NQ8oKc4gYmABvgisQmkiIjG/X0emyokK
         CHnRDk6BEh/AmnzIfA2O3C4/pqBUqznnAeWxQm37d5j/yZ9Ud39kdHvnVC1Rxn8ZvjEp
         mFcw==
X-Gm-Message-State: AOJu0YyQxskubzuHDTPDU0l54mpzx8YBjfVZO4r3qJvXqvUgZuY1Uxbm
        a8pK3LwXeipaSmwBPvFbvSdF8+j9d0Fy1IaYYoM=
X-Google-Smtp-Source: AGHT+IEkR6x1Zh0ykYQTzXTD4aBkfgt5NssWzvOEVxyh8znMkwhiQwaf9MnzYBKcCskVrhA5ssog/3XBzYOv9A5C9pw=
X-Received: by 2002:a05:6871:a002:b0:1e9:8885:b537 with SMTP id
 vp2-20020a056871a00200b001e98885b537mr555442oab.41.1699296947029; Mon, 06 Nov
 2023 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
In-Reply-To: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Nov 2023 13:55:36 -0500
Message-ID: <CADnq5_OkWD3YmCKgXbtk=Gnba3AgAiAWp2z_nzHQvRfEOsdXVg@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  This matches what we already do in the other clear state headers.

Alex

On Fri, Nov 3, 2023 at 12:00=E2=80=AFPM Abhinav Singh
<singhabhinav9051571833@gmail.com> wrote:
>
> sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to intialize a pointer to NULL using
> integer value 0.
>
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>  drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/gpu/=
drm/radeon/clearstate_evergreen.h
> index 63a1ffbb3ced..3b645558f133 100644
> --- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
> +++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
> @@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_defs=
[] =3D
>      {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
>      {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
>      {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
> -    { 0, 0, 0 }
> +    { NULL, 0, 0 }
>  };
>  static const u32 SECT_CLEAR_def_1[] =3D
>  {
> @@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =3D
>  static const struct cs_extent_def SECT_CLEAR_defs[] =3D
>  {
>      {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
> -    { 0, 0, 0 }
> +    { NULL, 0, 0 }
>  };
>  static const u32 SECT_CTRLCONST_def_1[] =3D
>  {
> @@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =3D
>  static const struct cs_extent_def SECT_CTRLCONST_defs[] =3D
>  {
>      {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
> -    { 0, 0, 0 }
> +    { NULL, 0, 0 }
>  };
>  static const struct cs_section_def evergreen_cs_data[] =3D {
>      { SECT_CONTEXT_defs, SECT_CONTEXT },
>      { SECT_CLEAR_defs, SECT_CLEAR },
>      { SECT_CTRLCONST_defs, SECT_CTRLCONST },
> -    { 0, SECT_NONE }
> +    { NULL, SECT_NONE }
>  };
> --
> 2.39.2
>
