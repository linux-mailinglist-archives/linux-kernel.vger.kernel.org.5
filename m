Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001480C3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjLKJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:07:56 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6CDD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:08:02 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a91751ba8so26856636d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702285682; x=1702890482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPgrKj4Z9ou1mA9NtOpBlbUseGjpdflGwXtUiJPXPv0=;
        b=h1lA7ACyQW4ljDAjzD3iMQtVf90Iy9nFm3Rslj5X05VmuQ6n1S2jY25JUF/GTKQJL9
         nIP3wIniJRLpKbL7SeuG9I6L8Mu/8jFf+wMujDB+iULeU1rLferI1L4/8N/ZWNK4w51U
         McOb3dP25NTNcyxtV/N5OjNYyona5yhQ2+LwS/PBgVNYKIEPpwpi6ysAZCYEvsXWlokK
         BjpP3lHDESu2MXGcrhkmGnk3CDxD2mkLJKOz2wRR3p0V6DcCPDAdo0RAq2dCcCtfMd32
         cearezdPfZSkPIPQp0cr7Lknwj8MH4q23rwUReKxt36JsbhCYQd/shwKEpAnlkb59yLP
         oSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285682; x=1702890482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPgrKj4Z9ou1mA9NtOpBlbUseGjpdflGwXtUiJPXPv0=;
        b=v1bWON89ZvR6k4xSLA10xdDQ/FWL6JJKgxfICA1GAIiORpacUn6+OfGBmZZFkHwQE6
         fG4bMWW3YUFhXBzFfEZ2wj/yUpRhCUiNwRx1sp/WEHs7HipyZvEL7zNWhUtjKgIKgB7x
         raA+nTfIHwGi0WdwMHSoiQqlDFeqV+xmLBAP+YWgFRanKqW6xjM8KPiA30xBq5X9dzdg
         eB8OUDSwR8AnIJ67luqfG/SwdSJA4+k2Ez+X00C7QJ1DRcqrgpel+KFWbhyfHOHV7neb
         tuDa9prLHLSD2F6/1ri24E7MoVfLxS7akv9pq71sOXzju5zBdlk9Pbtr9dN+5ZGNO6RE
         zwEg==
X-Gm-Message-State: AOJu0YypAYBOIVonmlAVVcZOsUrwUDplxFpLhKkePk5u0ahh8jk/jz6c
        MejeikJl8sbG2SqMYqne9VaqUbt8yaP4K7CMLnGtrQ==
X-Google-Smtp-Source: AGHT+IH8JqxClqGR5zMaHhex+AmruZE2eqwAzQ1yAoeILXFrdAOdAAicjg71Ei46LU8evR5UO1mXz2atL9aOhAum5VY=
X-Received: by 2002:a05:6214:8c9:b0:67a:e5b3:c484 with SMTP id
 da9-20020a05621408c900b0067ae5b3c484mr4085093qvb.91.1702285681765; Mon, 11
 Dec 2023 01:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:07:25 +0000
Message-ID: <CA+EHjTzdKS+ardXUofO+U1vnsOC3QjiJUBuKCHWw6z6zKdVGSA@mail.gmail.com>
Subject: Re: [PATCH 06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for
 DDI0601 2023-09
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sat, Dec 9, 2023 at 1:03=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> DDI0601 2023-09 defines some new fields in previously RES0 space in
> ID_AA64ISAR2_EL1, together with one new enum value. Update the system
> register definition to reflect this.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

> ---
>  arch/arm64/tools/sysreg | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index c48a3b8d00ad..3f382f8d0f4a 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1365,7 +1365,14 @@ EndEnum
>  EndSysreg
>
>  Sysreg ID_AA64ISAR2_EL1        3       0       0       6       2
> -Res0   63:56
> +UnsignedEnum   63:60   ATS1A
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   59:56   LUT
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
>  UnsignedEnum   55:52   CSSC
>         0b0000  NI
>         0b0001  IMP
> @@ -1374,7 +1381,19 @@ UnsignedEnum     51:48   RPRFM
>         0b0000  NI
>         0b0001  IMP
>  EndEnum
> -Res0   47:32
> +Res0   47:44
> +UnsignedEnum   43:40   PRFMSLC
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   39:36   SYSINSTR_128
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   35:32   SYSREG_128
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
>  UnsignedEnum   31:28   CLRBHB
>         0b0000  NI
>         0b0001  IMP
> @@ -1398,6 +1417,7 @@ UnsignedEnum      15:12   APA3
>         0b0011  PAuth2
>         0b0100  FPAC
>         0b0101  FPACCOMBINE
> +       0b0110  PAUTH_LR

Nit: PAuth and PAuth2 only have the PA as uppercase in this file,
which matches the spec. Should PAuth_LR be the same?

Otherwise,
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  EndEnum
>  UnsignedEnum   11:8    GPA3
>         0b0000  NI
>
> --
> 2.39.2
>
