Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4780C3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjLKI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLKI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:59:41 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795DED9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:59:47 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5dd3affae03so41307967b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702285186; x=1702889986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUXYWrFKYGWP04qknfNgRmd2u837ytBt0tL58kYIbnI=;
        b=BfGnLSngtnTmNxDqHkrwmdrZzEwAAgRzRBdusu0+MVm/OKbHGI8urZIxE75oHe59Oh
         fDFKsZDZ5Io5ylWx5NHrSeelMy/LluhLE/oPO6nlmzTenFxH+RGqf6ik63boqqJ3RNOr
         RmeBBQe5VHrJzIF+aQ4GpfI16oadSCsDHgXVp3MpAY6FKNLJGn/neoarCPgz+hvEfSHl
         IxcsMFVABTqJDuuqJAUV3TNI1+1Bo8KTJ9BOwt4X91t1FlAIhx6z4ydFhzUGG6JRZuem
         Fu23mIhCClQtqKCm1tgjQScKx50kvSw0gEb7cbEVOvLi3aBtidMlSPVJpxyHdaFYSYMK
         xHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285186; x=1702889986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUXYWrFKYGWP04qknfNgRmd2u837ytBt0tL58kYIbnI=;
        b=j/nG+qRPLt3h8jfDANIy+yREV76CIyAHwf74MLahpv7nj+UXpRgC1jSUtEWqEVnAEe
         0AF8MSA5DcUrw9NUezKI0DM0UyAO2Q3EetopTwhM8GJ0Fr91lg9jIRc8bVk5L6ENUS3q
         e8Co5Dbhs5jv7OAqEpTpahEtDdNi7oU7+qMG9ihM4LR/UWfPNeIE9n/dDrCIxkTxW3YR
         DcqFkVJIZIrTAtoLIOY7SoahLrE2RFIRWm9nFiRgMubdeYc67FAZb0GPhesRzJ9hcthM
         9OV3diHilVcPSdMECtuc7UwFyvUwj4GV2qKpPvqvTuiCjdeZ1i8nhpdTUMhiya7A6w4/
         zX8g==
X-Gm-Message-State: AOJu0YyFcQtaXflr5Ks7iJlSY721iLGrVAunwWK6DqBhtKZs6EBRQZ4r
        8MkNXLmsMAAx0CaN7pMoTs58glHbzy1Gh3tRSW0tki3IXCaJmcQBq3KjxQ==
X-Google-Smtp-Source: AGHT+IEYfFKC2E7GT8BiuS7sS2IPTNXVm/8NvBSUDTULqXseHPKAWeWvOug21F4BysG7RPG4R1cxSzjysuq5H0SqBJ4=
X-Received: by 2002:a0d:ea13:0:b0:5de:7c46:8e5 with SMTP id
 t19-20020a0dea13000000b005de7c4608e5mr3287703ywe.36.1702285186526; Mon, 11
 Dec 2023 00:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-5-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-5-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 08:59:09 +0000
Message-ID: <CA+EHjTyLSf6KEs==Bb2htdyydw4Kz0GDhJkgVkLZ_4f62-6+Hg@mail.gmail.com>
Subject: Re: [PATCH 05/13] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
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

Thanks for putting this patch series together.

On Sat, Dec 9, 2023 at 1:03=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> DDI0601 2023-09 defines a new system register ID_AA64PFR2_EL1 which
> enumerates FPMR and some new MTE features. Add a definition of this
> register.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index c2dbbaa22620..c48a3b8d00ad 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1002,6 +1002,27 @@ UnsignedEnum     3:0     BT
>  EndEnum
>  EndSysreg
>
> +Sysreg ID_AA64PFR2_EL1 3       0       0       4       2
> +Res0   63:36
> +UnsignedEnum   35:32   FPMR
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +Res0   31:12
> +UnsignedEnum   11:8    MTEFAR
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   7:4     MTESTOREONLY
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   3:0     MTEPERM
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +EndSysreg
> +
>  Sysreg ID_AA64ZFR0_EL1 3       0       0       4       4
>  Res0   63:60
>  UnsignedEnum   59:56   F64MM
>
> --
> 2.39.2
>
