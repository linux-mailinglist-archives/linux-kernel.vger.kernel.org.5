Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E17F5974
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbjKWHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:39:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453D1AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:39:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACE2C433CA;
        Thu, 23 Nov 2023 07:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700725154;
        bh=dnmMd/Gc51YGnbhok9mTHLUrlL/9RJjKE3NYV+vKfVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQQ3yDjiaKQqXGl+F6WcMG1ruJBisZBke27GVjPRyHrQlhGpCyvtEUrGUWSpj4hCk
         8ZqRP+sP3sSSqHK2zhMDkB0WGWRRPV3y+hFZogyl8aOCzDOoClk0xEMFgiBGc/oFmz
         0IRp62rFN9A1VDadsEyDaD0ETrwL9TdooE7LzY4naj9tMp6UnzsBzgS7ajz/1Ghwr9
         9mgK6xbwT+xtfo/UMTJ2bpznMC9sUmUxU6WY43I0Uurps2e/P9mxE/ba2a3GIAwAlA
         LOLhilZLVDO2sd7yLrNdgdKY/pXI3UkhyjUUqKD3hWhpFmlOPXke2dKDX1bh2/HbHv
         UdIzPBThbuZHA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1eb39505ba4so436592fac.0;
        Wed, 22 Nov 2023 23:39:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzU2M5Z7lhvk9uyvpKe2Jm6PtQNs1UrtebJbYt1q7jMzKFIloxS
        MKJkt2HQ6KzlTnkOymQVSF0C5xK2KMqdHOeGWb0=
X-Google-Smtp-Source: AGHT+IE/aHZ2CqZK023YoKIf3yCJ3PHVdOqmqOE42F0qp4WJHAcnHX3ZkplDwoELnnYLxCAA2La8Da6akCN0EmpAj1w=
X-Received: by 2002:a05:6870:6c0a:b0:1f0:d96:8d9c with SMTP id
 na10-20020a0568706c0a00b001f00d968d9cmr6123126oab.9.1700725154090; Wed, 22
 Nov 2023 23:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
In-Reply-To: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Nov 2023 16:38:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
Message-ID: <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
To:     Rob Herring <robh@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 7:12=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> This series adds support to set the dtc extra warning level on a per
> arch or per platform (directory really) basis.
>
> The first version of this was just a simple per directory override for
> Samsung platforms, but Conor asked to be able to do this for all of
> riscv.
>
> For merging, either I can take the whole thing or the riscv and samsung
> patches can go via their normal trees. The added variable will have no
> effect until merged with patch 2.
>
> v1:
>  - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kernel.org/
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


There were some attempts in the past to enable W=3D1 in particular subsyste=
ms,
so here is a similar comment.

Adding a new warning flag to W=3D1 is always safe without doing any compile=
 test.

With this series, it would not be true any more because a new warning in W=
=3D1
would potentially break riscv/samsung platforms.

Linus requires a clean build (i.e. zero warning) when W=3D option is not gi=
ven.






> Rob Herring (4):
>       kbuild: Move dtc graph_child_address warning to W=3D2
>       kbuild: Allow arch/platform override of dtc warning level
>       riscv: dts: Always enable extra W=3D1 warnings
>       arm/arm64: dts: samsung: Always enable extra W=3D1 warnings
>
>  arch/arm/boot/dts/samsung/Makefile  |  3 +++
>  arch/arm64/boot/dts/exynos/Makefile |  3 +++
>  arch/riscv/boot/dts/Makefile        |  3 +++
>  scripts/Makefile.lib                | 16 +++++++++-------
>  4 files changed, 18 insertions(+), 7 deletions(-)
> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231122-dtc-warnings-968ff83a86ed
>
> Best regards,
> --
> Rob Herring <robh@kernel.org>
>


--=20
Best Regards
Masahiro Yamada
