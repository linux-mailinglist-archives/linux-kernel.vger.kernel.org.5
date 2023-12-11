Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529A880C452
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjLKJU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjLKJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:20:24 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07544EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:20:31 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f48aef0a5so105292985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286430; x=1702891230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkQyC8qFnyrcySWzH4BIJrjlesqwo2s878+l8TczGJI=;
        b=YPHpmF2PKTtqfCENjd92kOwCDrNUn1FBQC6P6NHDzQ8zcMBj3EM/Btj6XnXgQOOWEZ
         IBtFNTfEM/Qlh+CkK5aOdgc0a6g9WiQCGjAHKRH4froar7OlQcfcdJLaGHAFBD3sxnS9
         0B1DwTj7MJBhZs0r3Bga9khGyET2GAMLQU1ri2gd6aFIUtLK0lQjP4b5h4pAPEUDaCBs
         jPmN17UU/KD0l2QInl2Q3S6NxqhgqiVrp3W3hadjk851Tlw+pX2u4avyLPztydqj0lg4
         eY+QdiUZCaleSMd1pS8t2ZDdQ3u0eRKq195MpOvv1ZoAvULznus3L9ymC+RjRDyiYH93
         tD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286430; x=1702891230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkQyC8qFnyrcySWzH4BIJrjlesqwo2s878+l8TczGJI=;
        b=ZBmdGHZ6vb/yZRlsawaJ6ZdZoaEMO/oZx1x0ZZZv1XwVumP7Zc40Ue7m2XYRN5QJ2z
         QI2NPa9gpe3Af+qE+gloOaaRlqc5QQVX9/5FMsnaHdQ0whjGcvl5qHqBCWT09qAK/cbQ
         VCCIfuhKOUBQ7Noc2e+Lmpm9MRRQ1Mvhq2r4e1SvENZCtzYx2sqKGipPOLyRnZJ7GLtt
         hMyR+kLHUFrLiXjTYwY+0o9KoqBNNUB18kZck6wnWzVxN3w3eCxZ6Zr1pWfY1DyIcxDU
         633x6cqpncBWH4yYjWnCxKHDRm6f8Ge481nxReEKvfD0kkPMjN47mkmG7F1+H15LcKhJ
         otmw==
X-Gm-Message-State: AOJu0Yxlbmwg/U1x3YaFZfmBHRKxDWLWtbZ569kE31uDtld5mdEnW5WM
        WrVgmZRMRq78tDpQTGDHyoRQC51Xr5LheicbYNBqbg==
X-Google-Smtp-Source: AGHT+IEMLIIdkzsoAIO9xJXzDXYz/jLCMVkJhwb8VEqBs3xjA2Hz7GGV50RgaEP0JeLipY2cu3trQ6vcJ29NW/wcCY0=
X-Received: by 2002:a05:6214:528f:b0:67a:a721:ec1a with SMTP id
 kj15-20020a056214528f00b0067aa721ec1amr2544549qvb.94.1702286430060; Mon, 11
 Dec 2023 01:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-10-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-10-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:19:53 +0000
Message-ID: <CA+EHjTzJNvH5gF7U-An+Tq6ySMnUUABuUFTz0qxTe-hqu6xZhw@mail.gmail.com>
Subject: Re: [PATCH 10/13] arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
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
> DDI0601 2023-09 defines some new fields in SCTLR_EL1 controlling new MTE
> and floating point features. Update our sysreg definition to reflect thes=
e.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/arm64/tools/sysreg | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 839f7cca53e0..4137179e7570 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1791,7 +1791,8 @@ Field     63      TIDCP
>  Field  62      SPINTMASK
>  Field  61      NMI
>  Field  60      EnTP2
> -Res0   59:58
> +Field  59      TCSO
> +Field  58      TCSO0
>  Field  57      EPAN
>  Field  56      EnALS
>  Field  55      EnAS0
> @@ -1820,7 +1821,7 @@ EndEnum
>  Field  37      ITFSB
>  Field  36      BT1
>  Field  35      BT0
> -Res0   34
> +Field  34      EnFPM
>  Field  33      MSCEn
>  Field  32      CMOW
>  Field  31      EnIA
>
> --
> 2.39.2
>
