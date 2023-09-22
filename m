Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410207AB111
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjIVLlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjIVLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:41:49 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46061FB;
        Fri, 22 Sep 2023 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1695382902;
        bh=9tS+t+9ne/achIv7oKXeD3phZJ7C1Jx1QC/gCOCkAJw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gF2j4UiOogzBDjYD8oxN34bmy2Sftbo+qN3LnAvHjAnvzN1+MgDs7xMhw8UaUvPfY
         1ajoom+NH/l6RGptV5B8xBFQdGoGY1ApU8cN08XLoxhIECZ8jUPlZ4NMP6Eh7fqKOh
         YIeRIyWmUAmLXdcNR82qk8nIsDbgmjGY3F088qbs=
Received: from [127.0.0.1] (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 271226599B;
        Fri, 22 Sep 2023 07:41:38 -0400 (EDT)
Message-ID: <c1a4a7ab5c68c00dd8b3bb249c0371dbb8bcb929.camel@xry111.site>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
From:   Xi Ruoyao <xry111@xry111.site>
To:     Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Han Gao <gaohan@iscas.ac.cn>, Icenowy Zheng <uwu@icenowy.me>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Fri, 22 Sep 2023 19:41:37 +0800
In-Reply-To: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 18:49 -0700, Drew Fustini wrote:
> This series adds support for the eMMC on the BeagleV Ahead and the
> Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
> eMMC.
>=20
> I tested on top of v6.6-rc2 with this config [1]. I was able to boot
> both the Ahead [2] and LPi4a [3] from eMMC. The following prerequisites
> are required:
>=20
> =C2=A0 [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]
>=20
> I pushed a branch [5] with this patch series and the above patch for
> those that find a git branch easier to test.
>=20
> Please note that only the MMC controller connected to the eMMC device
> is enabled in the device trees for these two boards. I did not yet
> attempt to configure and use the microSD card slot. My preference is to
> address that in a future patch series.
>=20
> References:
> [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> [4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@ker=
nel.org/
> [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc

I've tested this branch and successfully booted a rootfs on Lichee Pi 4A
eMMC with rootdelay=3D10.

Curiously is there some way to make it work without rootdelay?

For everything except "Enable BeagleV Ahead eMMC controller":

Tested-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
