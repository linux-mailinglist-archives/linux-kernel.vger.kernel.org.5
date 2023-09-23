Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964707ABC93
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjIWAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIWAMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:12:37 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761141A8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695427892; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UcdZxtPJfhkeou047fGiepo/2N0CjThLq8vDmbyuPWsdsE6kBjmTYYPJWun41xQvYQfHIZSc/1iuWiPJ13tbNUYM7o9caI17DQzpWMLP3B6/sUSw7wDHSSx2FqKkXaTarxIttxtbSxKmfDfRVLZXj5oXc3jlcRot4nzbqLOh9ok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695427892; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=JdL16BofRxhbL+GeSwRejWgJZOcxAvs0UhcFJGqQXNo=; 
        b=hQYr8uDHxlbxpLSmrEsJDwJMsSh1iUeTewyeiVnNScddbeM0787Un2ODokq7vP7aOFyYHRRCKkpI8mToocxHOQ6SVLZ/EC7gzOQhbm8sa0ojcqwipp4gXFSpsVGBWz0O3U4xE2gx6TRGvDS+D0+dHdkmYoqGNicqiElZd6JGIvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695427892;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=JdL16BofRxhbL+GeSwRejWgJZOcxAvs0UhcFJGqQXNo=;
        b=FESkBIPBxc8X3/wjHdWYuR24KYAsFJ4mTjp/A5A7PpLEu+otXE1AnILIa8Wcieow
        6iMnK1vknGuFZ1KHaE5yDsRcsPGTrt2EN33aoU3Zb6aUFcc0WtDWaG0Rutpb26zRN9+
        R3qErXlY/rngtf6Du0VhG+N22FYMMX4VFx1Id5tpAvcGbgP8m6TayTnjpDfIpBF61K0
        FhV4tkuTpMgUpbRQRcQcZJmp/D8x4utWaupc9U2/Rrvusr26xucOjMHIJNzKmbaLySH
        kbQkvU2K9AEognK9zjeWZZyKQ9IbsGwuzh1+n6wBtSvPOUPfmrFOFmtU5E8yHM1HHj8
        JwE0cUScNQ==
Received: from edelgard.fodlan.icenowy.me (120.85.96.110 [120.85.96.110]) by mx.zohomail.com
        with SMTPS id 1695427889763166.9901112942979; Fri, 22 Sep 2023 17:11:29 -0700 (PDT)
Message-ID: <cc167bc439910534a03f7a69615a1d5a054c294b.camel@icenowy.me>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Xi Ruoyao <xry111@xry111.site>,
        Drew Fustini <dfustini@baylibre.com>,
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
        Han Gao <gaohan@iscas.ac.cn>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Sat, 23 Sep 2023 08:11:22 +0800
In-Reply-To: <c1a4a7ab5c68c00dd8b3bb249c0371dbb8bcb929.camel@xry111.site>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
         <c1a4a7ab5c68c00dd8b3bb249c0371dbb8bcb929.camel@xry111.site>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-09-22=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 19:41 +0800=EF=BC=
=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2023-09-21 at 18:49 -0700, Drew Fustini wrote:
> > This series adds support for the eMMC on the BeagleV Ahead and the
> > Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs
> > on
> > eMMC.
> >=20
> > I tested on top of v6.6-rc2 with this config [1]. I was able to
> > boot
> > both the Ahead [2] and LPi4a [3] from eMMC. The following
> > prerequisites
> > are required:
> >=20
> > =C2=A0 [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]
> >=20
> > I pushed a branch [5] with this patch series and the above patch
> > for
> > those that find a git branch easier to test.
> >=20
> > Please note that only the MMC controller connected to the eMMC
> > device
> > is enabled in the device trees for these two boards. I did not yet
> > attempt to configure and use the microSD card slot. My preference
> > is to
> > address that in a future patch series.
> >=20
> > References:
> > [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> > [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> > [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> > [4]
> > https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kerne=
l.org/
> > [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc
>=20
> I've tested this branch and successfully booted a rootfs on Lichee Pi
> 4A
> eMMC with rootdelay=3D10.
>=20
> Curiously is there some way to make it work without rootdelay?

The answer is nearly no (although using an initrd will mitigate the
need of rootdelay).

MMC devices are known to be slow to probe, even on x86 devices.

>=20
> For everything except "Enable BeagleV Ahead eMMC controller":
>=20
> Tested-by: Xi Ruoyao <xry111@xry111.site>
>=20

