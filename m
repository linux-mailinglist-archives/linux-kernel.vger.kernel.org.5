Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8880C41E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjLKJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjLKJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:15:07 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C223EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:15:14 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67adac40221so31742146d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286113; x=1702890913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIGW/4rOn59YZ2hBdfdz0zvlK99nMcUiyFtEBHlEDE0=;
        b=2DbIKctKwkERBQoGB9yjAdYSLCjAgY3WAKtafruHAwG1vkQu/SsWedJR5GOChvVaom
         cajGdtPn0BzyeY4mAHMMdgef8GEmI25bRXk7eWtltqd82/LtX2FJxqKgtCkRUFqpj7Mm
         yKKThYTjT8lpnzPL7tc9J53J5H+yIS/IpEZ29k5NXfi8Y/BfLS9o9cQmCBd+EIxJ/O+x
         YzQQDUQNeDJQYmEcms/3CMqcILlP9Q9gfWnAA3DcYm0xG4Fqr35Xl9dH+2mZdYwn9Tgu
         tkLLIxXH0Rfuy+jju986J2VUMW73xVSdaFEIIPh0wLPlzwLfzU5eM69PPftSX7ypfZwB
         xkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286113; x=1702890913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIGW/4rOn59YZ2hBdfdz0zvlK99nMcUiyFtEBHlEDE0=;
        b=KodHZh7rzjLo9MOUUSYvfd6m59CCU/2gp4LI+Viy+4iBRfnN07hkj3JM1wRAkUmi95
         w4Xa1Z1xOkpfhpKi1n3a3BCm8ZJeuiBOmxdO+LWqxNeWOJ5ic3mJf4EMSyEz7a2k7SYi
         hmvp8uGCezHREloVNdMJ5zGbHq/mwpr4IaKX/ggXOn7zEyIVrWVj6aaOEv72p+iBdN1g
         lBP649O32jbepLr65jbfEZBI0Mc+Tsl2xO5Nu89ccnTsTDvimOu5EAFJbabe3WA9QxFQ
         KTQ8yys2zuyj/wCRxu9dFStCxZX0ImDGFaVYMylSHZnQUKhhIqFV5k0D0stKJjk30V8J
         kAKg==
X-Gm-Message-State: AOJu0Yz5Lm6Ui+CRLerYrjefhARX+MIWefeX2G9cbVVo9X0rgNC+JUiB
        pWcvVMSD9xXD2TR9FRwMdNbP5WH0PLHojJ1wXESMzIng55vqVMuQw1jX+g==
X-Google-Smtp-Source: AGHT+IE7TdyExh4McOsrMqUV+RQEr4b4ImOgDUj+sRLL90F5oOpSMZrCBEAI0Cri896p3ljOxr1OiDTRzXeoHKqePN0=
X-Received: by 2002:a05:6214:f04:b0:67a:c0f0:c0eb with SMTP id
 gw4-20020a0562140f0400b0067ac0f0c0ebmr6902560qvb.35.1702286113047; Mon, 11
 Dec 2023 01:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-7-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-7-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:14:36 +0000
Message-ID: <CA+EHjTw8wkdCG69=b4s328RdWPdujOpRt1VCW7TTyUys6dDffg@mail.gmail.com>
Subject: Re: [PATCH 07/13] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
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
> DDI0601 2023-09 adds a new system register ID_AA64ISAR3_EL1 enumerating
> new floating point and TLB invalidation features. Add a defintion for it.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/tools/sysreg | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 3f382f8d0f4a..d1bb6ebcd959 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1433,6 +1433,23 @@ UnsignedEnum     3:0     WFxT
>  EndEnum
>  EndSysreg
>
> +Sysreg ID_AA64ISAR3_EL1        3       0       0       6       3
> +Res0   63:12
> +UnsignedEnum   11:8    TLBIW
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   7:4     FAMINMAX
> +       0b0000  NI
> +       0b0001  IMP
> +EndEnum
> +UnsignedEnum   3:0     CPA
> +       0b0000  NI
> +       0b0001  IMP
> +       0b0010  CPA2
> +EndEnum
> +EndSysreg
> +


>  Sysreg ID_AA64MMFR0_EL1        3       0       0       7       0
>  UnsignedEnum   63:60   ECV
>         0b0000  NI
>
> --
> 2.39.2
>
