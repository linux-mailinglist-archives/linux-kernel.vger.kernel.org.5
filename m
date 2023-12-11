Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B580C48D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjLKJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLKJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:28:45 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18E2F3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:28:51 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a9febb2bfso32236456d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286931; x=1702891731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBMWe9fjEzMYGTVNkN3TVKk2bWYSlJtyyay5GvzImeU=;
        b=nXy25PSnz3lhZI2wCgdalz9C71sWzNIDbyp09WyKCtUhoW9HN1tgzpGFlZTa7b2sWs
         EQcR8jqdJ47ckuSWgptjAB9VISiOF31Rg+O9tq6+kH+BX2Dt2O1t0JcyrqE6E3MlKGmI
         v64CHuJAmbrZoe9lvai7bpYmWrdvMu4M7KTH1CTMi3HO49DL1Ze6WJ/WItcEzLxDOWIk
         Oc1KZaDg9hyIInp78bEmAn8jdQGg07f7JMOPbmANeePYZ6BNJFsacV+aI3bbn+9UOuVS
         M8JhvkAJV/6kiwwrm9xS8svgPhL2GXtA86KEO5xORUaranZjA+0vekdWu0MywNgQwRg9
         V0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286931; x=1702891731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBMWe9fjEzMYGTVNkN3TVKk2bWYSlJtyyay5GvzImeU=;
        b=iBAMCct8FGzIvYRaEeZZL7tbIiLzGzitNG4rCv8MHcP5x5ioqZXBCos9IIJ4EFBbIe
         JFJ4DFSyIlWJjlF4XQvpmNMQiRwLuFykA+TsXgU/r7FapLUMyU67d1SiX1DZ3kjckaiF
         LZvtpqkaMyIefEk5J7HyBx2Z6PWUxmc6VH5hvuPpNiE47r6rzPCWzr6fVCleYi7MIogw
         wY44mE8ahtnIxD0a4Mr6nY2uJDf8vEcMwWGWpKVMRb5ca12L+Odtz0KyxloyGM84+iq1
         LXteXRBWl596bF+ywEm9S/5aw2uaZLmW8r1BBhIgv30vHSWJrdEW4dp9mfrVkgxelA0j
         XURg==
X-Gm-Message-State: AOJu0YyBh63lev/2eJB3q79fZaLY6G/uEwdIxf8qjWwyh1wGm2rPccnf
        3nl+kqc9PEl2YsDzBOx1AS3IQrOdJlkMRSRIEUTeNQ==
X-Google-Smtp-Source: AGHT+IGjvKd2niTfmfBjuzNcniW3V5Y/PxsZgGq2OwoKwKwF5abK6keybO2cmeizjiRJtAlZNeODiR9mqdAeK2sKHzQ=
X-Received: by 2002:a05:6214:808:b0:67a:c636:179c with SMTP id
 df8-20020a056214080800b0067ac636179cmr5674448qvb.37.1702286931005; Mon, 11
 Dec 2023 01:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-12-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-12-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:28:15 +0000
Message-ID: <CA+EHjTxcY8wT-ztms2+SwJ-zywk08TjuKXLJiyk_9mO9y_y8Pg@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64/sysreg: Add definition for FPMR
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
> DDI0601 2023-09 defines a new sysrem register FPMR (Floating Point Mode
> Register) which configures the new FP8 features. Add a definition of this
> register.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/arm64/tools/sysreg | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 1acec8f5c37d..1c6d1c904750 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -2139,6 +2139,29 @@ Field    1       ZA
>  Field  0       SM
>  EndSysreg
>
> +Sysreg FPMR    3       3       4       4       2
> +Res0   63:38
> +Field  37:32   LSCALE2
> +Field  31:24   NSCALE
> +Res0   23
> +Field  22:16   LSCALE
> +Field  15      OSC
> +Field  14      OSM
> +Res0   13:9
> +UnsignedEnum   8:6     F8D
> +       0b000   E5M2
> +       0b001   E4M3
> +EndEnum
> +UnsignedEnum   5:3     F8S2
> +       0b000   E5M2
> +       0b001   E4M3
> +EndEnum
> +UnsignedEnum   2:0     F8S1
> +       0b000   E5M2
> +       0b001   E4M3
> +EndEnum
> +EndSysreg
> +
>  SysregFields   HFGxTR_EL2
>  Field  63      nAMAIR2_EL1
>  Field  62      nMAIR2_EL1
>
> --
> 2.39.2
>
