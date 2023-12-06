Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0A806BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377625AbjLFKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377538AbjLFKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:16:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6B109
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:16:52 -0800 (PST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C24CA44446
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701857808;
        bh=fPFWRVi4UC1wxgK1BZ+tE5lPscptXMAGgYLtmt3rvb8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=g9vU4SH26SbwgJh42XbYvWGRGF5SUE8+QXLC9lDpJ7RF3f074N4NaQH9iFbtOV2pO
         Pq9ui69L17HBbnUUe0lAqrpGUdNMm/WpuLpSiyezL+CuXSEeO0048UXzFoX0zyXxTF
         72JJb6LjwS0ei5dBIVR7z/21jWRE+eqkGTT1juJNta/abiO3Rft2tryLnTtsKQtjg8
         Y52WPgYCVtEnag5L6pVLEerz90KFqNnB/ZSN2ngOBzShehBbH7wtauIM5iZubfzmf7
         1G822lW3AaDJan60p93gBZxKSa3spQW9opMnhlt3s8UkclUs7N+t/Ct+t9lQOvRm0n
         ga3Ml+BNO08Ng==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ca0cf1b72aso24539111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857794; x=1702462594;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPFWRVi4UC1wxgK1BZ+tE5lPscptXMAGgYLtmt3rvb8=;
        b=dT7b1ZqsHMZGKaMn9MFIeR1Hpu6np++hcs+4kqWU/VODd0Bv4Ozn2vFzymM/lwHXOV
         QQPWMIOcB77e3lxNoj0WfIarU6I/VuyXnwbwv29bmZULr6x2QDuOhRsjeWJOoLIwsU8b
         N2zBGM+mN2ZCi3FV/ARNAoSLstQggMP6gdYIi927nFkxJuAX/sFeiW0wiL4rp/qTnjXE
         JRIOGmHugF8z+RFDIuqXQSiTTAJNsw3SOyjKSB7h6bYoVC64xWCAjYBbSH3g4qOYltLK
         Lye02pik3NaB+KOwcMDZiCG7asfOiDEUEUjcWsFGuuBbslEZcT/z2vSqRonB2WLjYRlx
         iOZQ==
X-Gm-Message-State: AOJu0YxK6WgWHk6PlUrl0w47NsLzxWoCdQZXa4wWnkjkCbubQWdhw087
        bxEQy5VHHVsqwtuXxKLGj//1ojcTks5sYi56dXURW7AOIPMXsMm2BP5xlgyAGJZaxbIQcdiBVQt
        ltujBH/OO7os6aL86lvOUNuUBGr7uo0PQKLEWLAWY+T8GOIZqqOIgWgtq1Q==
X-Received: by 2002:a2e:740e:0:b0:2c9:f925:df0e with SMTP id p14-20020a2e740e000000b002c9f925df0emr211949ljc.34.1701857794550;
        Wed, 06 Dec 2023 02:16:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq781bpnuacD5QiFiBCg1mUOnOOSBbtHNvzHUW70ZtF1hR2gyBittWXfHSvEnQsp0nEdWGwPsBBWgtAAGiL6c=
X-Received: by 2002:a2e:740e:0:b0:2c9:f925:df0e with SMTP id
 p14-20020a2e740e000000b002c9f925df0emr211946ljc.34.1701857794264; Wed, 06 Dec
 2023 02:16:34 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Dec 2023 04:16:33 -0600
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <IA1PR20MB49531468A92E2A7670F1EE0BBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <CAJM55Z9WO+0Yb-at6CAR6=UP9j60iQz=s7MK-3qiT=w-8N6+Zw@mail.gmail.com>
 <IA1PR20MB49531468A92E2A7670F1EE0BBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
Mime-Version: 1.0
Date:   Wed, 6 Dec 2023 04:16:33 -0600
Message-ID: <CAJM55Z-hCzuw+eQ-ABXoBYX7oSScXTKHwUzEe_2k6eSyy5HqKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
To:     Inochi Amaoto <inochiama@outlook.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inochi Amaoto wrote:
> >Inochi Amaoto wrote:
> >> Add clock controller support for the Sophgo CV1800B and CV1812H.
> >>
> >> This patch follow this patch series:
> >> https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/
> >>
> >> Changed from v1:
> >> 1. fix license issues.
> >>
> >> Inochi Amaoto (4):
> >>   dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
> >>   clk: sophgo: Add CV1800 series clock controller driver
> >>   riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
> >>   riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
> >
> >Hi Inochi,
> >
> >This series seems to be missing patch 1 and 2. If you did send them, but just
> >omitted linux-riscv from those patches, please don't do that. Having the whole
> >series makes it a lot easier to review without having to hunt down all the
> >missing parts on lore.kernel.org.
> >
> >scripts/get_maintainer.pl does support muliple patches as input
> >
> >/Emil
> >
>
> Hi Emil,
>
> The get_maintainer.pl does not give me linux-riscv mail list for the first
> and second patch. I have added this to the second one, but the patch is
> held by the mail list since is too big. Anyway, I will add this mail list
> manually if you need. Sorry for this inconvenience.

No worries. Yeah, that's what I meant by get_maintainer.pl supporting multiple
patches.  You can do something like

  git format-patch <starting point>..
  ./scripts/get_maintainer.pl *.patch

..to get a list of recipients for the whole series.

/Emil
