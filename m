Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71BC786790
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbjHXGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbjHXGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:34:36 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3F6FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:34:32 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692858465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6IxgWmKRKi+I5lqpm5Wgd0S2sdauV2HZZ0NQlY4DP4=;
        b=dfhY3alx1/XKkgAfnlq82B8EZDL1jL9RntK0zdUXmkn83OszAv5QKemGoodf/iCuojCiwN
        a8HtZWrVsq377brYfWITHfS2t/IEFOkz6vWPlYLutMoYu3slrPeYSdKeN4QuP5p65ZAwWI
        DtIo3mDR00VnADl5HMeppCF5Tjg7WtI=
Date:   Thu, 24 Aug 2023 06:27:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   cixi.geng@linux.dev
Message-ID: <2aeec29689a56fcfa60aa499f73f9a10f783c4ec@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] arm64: dts: sprd: fix the cpu node for UMS512
To:     "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "SoC Team" <soc@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
In-Reply-To: <CAAfSe-sorWk5zhzevAoxwbiyk2YoDU9d47FLXcT43q1ZwHdvdg@mail.gmail.com>
References: <CAAfSe-sorWk5zhzevAoxwbiyk2YoDU9d47FLXcT43q1ZwHdvdg@mail.gmail.com>
 <20230711162346.5978-1-cixi.geng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

August 17, 2023 at 4:26 PM, "Chunyan Zhang" <zhang.lyra@gmail.com> wrote:


>=20
>=20On Wed, 12 Jul 2023 at 00:24, Cixi Geng <cixi.geng@linux.dev> wrote:
>=20
>=20>=20
>=20> From: Cixi Geng <cixi.geng1@unisoc.com>
> >=20
>=20>  The UMS512 Socs have 8 cores contains 6 a55 and 2 a75.
> >  modify the cpu nodes to correct information.
> >=20
>=20>  Fixes: 2b4881839a39 ("arm64: dts: sprd: Add support for Unisoc's U=
MS512")
> >  Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >=20
>=20
> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>=20
>=20Thanks,
> Chunyan
>=20
Hi=20All=EF=BC=8C
please help to review this patch=EF=BC=8C If there are no issues, I hope =
to apply as soon as possible=EF=BC=8Cthanks=EF=BC=81
> >=20
>=20> ---
> >  arch/arm64/boot/dts/sprd/ums512.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20>  diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boo=
t/dts/sprd/ums512.dtsi
> >  index 024be594c47d..97ac550af2f1 100644
> >  --- a/arch/arm64/boot/dts/sprd/ums512.dtsi
> >  +++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
> >  @@ -96,7 +96,7 @@ CPU5: cpu@500 {
> >=20
>=20>  CPU6: cpu@600 {
> >  device_type =3D "cpu";
> >  - compatible =3D "arm,cortex-a55";
> >  + compatible =3D "arm,cortex-a75";
> >  reg =3D <0x0 0x600>;
> >  enable-method =3D "psci";
> >  cpu-idle-states =3D <&CORE_PD>;
> >  @@ -104,7 +104,7 @@ CPU6: cpu@600 {
> >=20
>=20>  CPU7: cpu@700 {
> >  device_type =3D "cpu";
> >  - compatible =3D "arm,cortex-a55";
> >  + compatible =3D "arm,cortex-a75";
> >  reg =3D <0x0 0x700>;
> >  enable-method =3D "psci";
> >  cpu-idle-states =3D <&CORE_PD>;
> >  --
> >  2.34.1
> >
>
