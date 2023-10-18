Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D427CE4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjJRRd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjJRRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:33:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A630F8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5056059e0so84314231fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650169; x=1698254969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GJ2P2CnTobBA/8z5Cm8CPIZTuVTwbVlOW0vmiISWx0=;
        b=QgMh309bM5dL46kFYzNOXZcVB/NcbdixgEujiUSsWvsYURS9Suu+wkBglY/aBzRf/3
         gZCpofmyzb3D6XQdcKQFVZYzpGFbClLm8yD+Se18KbDQQt8Q6ra0C57GF0nzs6cDMFMK
         bVhLk9Z8dTW1g5zyx22Q9s7/r+mYGFXpERe97ntLCcjPfWwH2ZgMGqqw5qz5I4ec5n6B
         eh7x8zjs3dVKiIi0lAuCh5dbc0SeAjvJSUMjgSe+IvR2Asnjfqz5sdYvjwLO1seSg9pW
         irg02gOuiM1+Xgje2i3XNmPBMKYCfA6gNpx3D0neOXYZcciJPj0v/fE5TjPe7/Z9NzNq
         /9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650169; x=1698254969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GJ2P2CnTobBA/8z5Cm8CPIZTuVTwbVlOW0vmiISWx0=;
        b=aqTcODBiZSEDTR2/cTPcvPx9mePoPgkjBLOehJarp3NqgwdJa6FvK3dgD8ryqd8I8D
         Tp6aQG9BeXFiVfhjPk2y2H4t/ZooUOUyIZW9IAP/Ez+Y42xYPM2ieCbc2gVhAKKnV3qG
         v4/BBRM7P7hYvYuEjmxJ5fq3eI8Egzb/BAQEzYuS892G1ghc1qjkOyispu2qYnsS9778
         C6v1xbMbHPZJqfKcCBQupvT7ayDY2USNkxLt3yHMEAuqR+W3PE4Ho+YAshJ59H10R2LU
         tbMQNXgBwZ7QrA6d/VhStdLwCK4KPLPYRmeYpjziycn+awLVZbgFzA04zOac0D8eiVJT
         mKhQ==
X-Gm-Message-State: AOJu0Ywea/ag2v0dPqoXbT6Kk7IByJuKhNipoNHC+SgX9nd2T4kpuBqP
        h/hGfxHK0dJvbHMK/o2ALtJ2J9WfpNiOcAWUDAZSAQ==
X-Google-Smtp-Source: AGHT+IHCEnrOGaYL2aZ2Uu1BYAivaKmsbw0/Dl8ITo9PK6BbJM+TMe6i41oEoFMoHhyP2EZwsctqXbqrc2W0+6s62wo=
X-Received: by 2002:a2e:164e:0:b0:2bd:d34:d98a with SMTP id
 14-20020a2e164e000000b002bd0d34d98amr4364757ljw.44.1697650168802; Wed, 18 Oct
 2023 10:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-18-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-18-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:52 -0700
Message-ID: <CALs-HstTzsbtfcRdm0W+qeoN+GO1mFxOLXK_fPevO2oCUqhxnQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] riscv: add ISA extension parsing for Zfa
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add parsing for Zfa ISA extension [1] which were ratified in commit
> 056b6ff467c7 ("Zfa is ratified") of riscv-isa-manual[2].
>
> Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/v=
iew [1]
> Link: https://github.com/riscv/riscv-isa-manual/commits/056b6ff467c7 [2]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
