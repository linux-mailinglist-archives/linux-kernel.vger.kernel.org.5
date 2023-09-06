Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60F793333
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjIFBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjIFBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:15:14 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 18:15:11 PDT
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E51AB;
        Tue,  5 Sep 2023 18:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693961972; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=PTsiRQmrah1gDkhUYWtB4ZVarVqK4rq+9vvpMqm0u6DUzUGR3DwCViasK1YLOQ+yJgWbV46xFVrOqE5ZbcUd3UBaFtjReUMRypetVcRt6NkygX7axQ4R9Mj8yFwoGYAY8JEuD/PRw2LJIon1SOqRxdi7X2GIpouy6fGBvfE+5p4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1693961972; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=3Bb0HPghGP1Pis7m6aZLpfrMCwk6EyrDCWLxlIPlTSc=; 
        b=M6tc5QYngmVRNXAfzgxDit4mCzmclJLTf/MjVHRQrqVffONw5qLeF1+5JBYi2CYNn2N0I9Qzk5V+249+/99WmZ66MFG+hpImH+COHbWl+7ZPakiZq5icMR3Y3WhsVGIWhnt+rOEW3q5Qb36RUXBrcWI53ZhYZ2xBugqDhAxE83A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1693961972;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=3Bb0HPghGP1Pis7m6aZLpfrMCwk6EyrDCWLxlIPlTSc=;
        b=fjfou6jMO/sh3ooxjTbSyoFPogvE2k05ANatt0ugI6yXQUysjTap69dcdK3dR/Sr
        NCa6ZLQOHsa6cb9rp54ys5FbQzzV9nE+bvoiv0qK4lqRxER7rfozzmUqfbvnkjgjnLG
        LmgzeIC0ubaSN9wYPwm21jGtjcjnWiJs8PS2LqKO2nTzSC99BeXLosm/PUOCq0UXk/c
        dmQA5I8yzA44Nr6rA/i29ULwYRWKWPa1POSpv2wSKqiUgpwokcRFxWrx0uaMOFRwKv4
        3T6M66eBtlKj+8R2XUFq0+PKyQ3EdJX9/CuYAZWbAESUUDEe4QpL85uwq+4fTe+/bm5
        h7X4e7RqZg==
Received: from edelgard.fodlan.icenowy.me (120.85.99.236 [120.85.99.236]) by mx.zohomail.com
        with SMTPS id 1693961971610137.58133627753386; Tue, 5 Sep 2023 17:59:31 -0700 (PDT)
Message-ID: <82d294b75cbb9cfb168ea276b2d587b5fc989572.camel@icenowy.me>
Subject: Re: [PATCH 2/6] cpufreq: dt-platdev: Blocklist allwinner,h616 SoC
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
Date:   Wed, 06 Sep 2023 08:59:24 +0800
In-Reply-To: <20230904214018.0a8f12e2@slackpad.lan>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
         <20230904-cpufreq-h616-v1-2-b8842e525c43@somainline.org>
         <20230904214018.0a8f12e2@slackpad.lan>
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

=E5=9C=A8 2023-09-04=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 21:40 +0100=EF=BC=
=8CAndre Przywara=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 04 Sep 2023 17:57:02 +0200
> Martin Botka <martin.botka@somainline.org> wrote:
>=20
> > The AllWinner H616 uses H6 cpufreq driver.
> > Add it to blocklist so its not created twice
>=20
> That looks alright, but I think needs to be squashed into the patch
> that enables the H616 driver operation, to avoid regressions during
> bisecting.

Well I think if it's before the H616 enablement, it could be just okay.

>=20
> Cheers,
> Andre
>=20
> >=20
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > ---
> > =C2=A0drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index e2b20080de3a..51818cef8979 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -104,6 +104,7 @@ static const struct of_device_id allowlist[]
> > __initconst =3D {
> > =C2=A0 */
> > =C2=A0static const struct of_device_id blocklist[] __initconst =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allw=
inner,sun50i-h6", },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwinner=
,sun50i-h616", },
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "appl=
e,arm-platform", },
> > =C2=A0
> >=20
>=20
>=20

