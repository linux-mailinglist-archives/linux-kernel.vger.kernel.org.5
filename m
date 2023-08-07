Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D4772AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjHGQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHGQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:26:29 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FDC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:26:28 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56ce1bd7fc4so3274892eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425588; x=1692030388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+y0EPgsXPYGqDhgU0ly4Js9jdJ8CVWq1QGImohPTzg=;
        b=U26wNKBXF4TXIYytCM7pRJjJtOffhyxeALBgdZu6WaxOb8+SG/25jUDmFTbHxPnyYZ
         lt+MTlSgweJIXIdbjj//oJAVAAywyV+zHEN+wq/ySVgOIhApxP4nYF82RnxmVytwABe2
         U0wFcJ4GJ9mzWAVr3wAMUrXw6qMWXGszMsUXm73xSHZFxB7Ywv+QXEnbZGYoYdJSLDR9
         Xp3jqle9ZgMQ0TG3RdtJCvPSKvQ8+WxhZdhFl3FGhly7/4aQXf5vyHTnXqTfNsQSz2D5
         FytNZmrc2ncRWZ7zshSAzaIh4nDHaEhcX7qwm8NnGVBBrMgUi19I9XVs8lU1kKTKBpwg
         2Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425588; x=1692030388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+y0EPgsXPYGqDhgU0ly4Js9jdJ8CVWq1QGImohPTzg=;
        b=E8LEbpH+H8uhynfp615aoyVfDBAlvokuQTOKexgF3sNcOHGkqCT14rO1gjJxL2pwFL
         wk1o8GU9h+QHLOKxj/beSxiA5aCaLtyilxEv6seBoDtdtC0/NQhJ1AqQyqQ4eRfngKZm
         W5gYd9CUh2fq8EtMTO0iQ5gReEYcaOY3bpB+kBdsFNi5kDmbFEcWix+CvMou7NdwPjM6
         OCaOIctk20De1eTp+Oe3vb2y4RiE8PqiqTP2qZIGbgfO6w5XCX4793rF8PRTg6ZCFKwc
         FpGJXXJdLaXz+vf456XW/P+b+iQew7p2RJfwcvR4z+Qkdn+3F75V8P7kDISsIGWuN76Q
         V+6A==
X-Gm-Message-State: AOJu0YwOUf6DYfAs5LH0bKDl+n/PaoMvTiJH/FLFrf+YYkHCCVz1LUIr
        46aiAeBUjgBPvkJO5KggzuUDP5ljZ4C+/pzecok=
X-Google-Smtp-Source: AGHT+IHtXN34eo/D+WLHPMKn8uFbvoUL7yxU34VnYFA/V9sKmSdzupmYHvysUFwQ9U2POQsuhyD6WyVpyFJMVk+Tctw=
X-Received: by 2002:a05:6870:c087:b0:1bb:8ab6:6642 with SMTP id
 c7-20020a056870c08700b001bb8ab66642mr11612014oad.8.1691425587807; Mon, 07 Aug
 2023 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230801030334.5069-1-sunran001@208suo.com>
In-Reply-To: <20230801030334.5069-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:26:16 -0400
Message-ID: <CADnq5_OVqaYzv6_y20axW+dmx1+_x9M9A29R8dKnM8rVNjh-=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/powerplay/hwmgr/ppevvmath: Clean up errors in ppevvmath.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
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

On Mon, Jul 31, 2023 at 11:03=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: return is not a function, parentheses are not required
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required before the open parenthesis '('
> ERROR: need consistent spacing around '-' (ctx:WxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> index dac29fe6cfc6..6f54c410c2f9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> @@ -166,7 +166,7 @@ static fInt fNaturalLog(fInt value)
>
>         error_term =3D fAdd(fNegativeOne, value);
>
> -       return (fAdd(solution, error_term));
> +       return fAdd(solution, error_term);
>  }
>
>  static fInt fDecodeLinearFuse(uint32_t fuse_value, fInt f_min, fInt f_ra=
nge, uint32_t bitlength)
> @@ -230,7 +230,7 @@ static fInt ConvertToFraction(int X) /*Add all range =
checking here. Is it possib
>  static fInt fNegate(fInt X)
>  {
>         fInt CONSTANT_NEGONE =3D ConvertToFraction(-1);
> -       return (fMultiply(X, CONSTANT_NEGONE));
> +       return fMultiply(X, CONSTANT_NEGONE);
>  }
>
>  static fInt Convert_ULONG_ToFraction(uint32_t X)
> @@ -382,14 +382,14 @@ static int ConvertBackToInteger (fInt A) /*THIS is =
the function that will be use
>
>         scaledDecimal.full =3D uGetScaledDecimal(A);
>
> -       fullNumber =3D fAdd(scaledDecimal,scaledReal);
> +       fullNumber =3D fAdd(scaledDecimal, scaledReal);
>
>         return fullNumber.full;
>  }
>
>  static fInt fGetSquare(fInt A)
>  {
> -       return fMultiply(A,A);
> +       return fMultiply(A, A);
>  }
>
>  /* x_new =3D x_old - (x_old^2 - C) / (2 * x_old) */
> @@ -447,7 +447,7 @@ static fInt fSqrt(fInt num)
>
>         } while (uAbs(error) > 0);
>
> -       return (x_new);
> +       return x_new;
>  }
>
>  static void SolveQuadracticEqn(fInt A, fInt B, fInt C, fInt Roots[])
> @@ -459,7 +459,7 @@ static void SolveQuadracticEqn(fInt A, fInt B, fInt C=
, fInt Roots[])
>         f_CONSTANT100 =3D ConvertToFraction(100);
>         f_CONSTANT10 =3D ConvertToFraction(10);
>
> -       while(GreaterThan(A, f_CONSTANT100) || GreaterThan(B, f_CONSTANT1=
00) || GreaterThan(C, f_CONSTANT100)) {
> +       while (GreaterThan(A, f_CONSTANT100) || GreaterThan(B, f_CONSTANT=
100) || GreaterThan(C, f_CONSTANT100)) {
>                 A =3D fDivide(A, f_CONSTANT10);
>                 B =3D fDivide(B, f_CONSTANT10);
>                 C =3D fDivide(C, f_CONSTANT10);
> @@ -515,7 +515,7 @@ static int uGetScaledDecimal (fInt A) /*Converts the =
fractional portion to whole
>                 dec[i] =3D tmp / (1 << SHIFT_AMOUNT);
>                 tmp =3D tmp - ((1 << SHIFT_AMOUNT)*dec[i]);
>                 tmp *=3D 10;
> -               scaledDecimal =3D scaledDecimal + dec[i]*uPow(10, PRECISI=
ON - 1 -i);
> +               scaledDecimal =3D scaledDecimal + dec[i]*uPow(10, PRECISI=
ON - 1 - i);
>         }
>
>         return scaledDecimal;
> --
> 2.17.1
>
