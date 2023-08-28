Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7D78B705
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjH1SHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjH1SGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E518B;
        Mon, 28 Aug 2023 11:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F7E615CE;
        Mon, 28 Aug 2023 18:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF60C433C7;
        Mon, 28 Aug 2023 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693246009;
        bh=R0UDLHNI3eUF5VP5rxi5y9A4Pvv+GL6PJbAP/rcnOCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tt579XNA8QaIc+dHhtQH+z2mU9v3SJg+1dyCuLnF+KSZ/NL1tOnOACUooz2OPqnjl
         d5s90H/gg35YjoQ93UREfzviOzSgu5afuCc/6NiDWYjp0dTRQggpk4UHHxtwzeLbYt
         XGL/3V4zWMEkbbt+oNvmlIf1+hzuNCRi67UDCAI5r25/cqmQ9vOb7vi5lff9ZuG+mW
         jKcxC0UEl1IRGLsyE8rydE6zWddGG4ev8aKXaYzpxQMLBUJ68Lbjj0lH6Rrhnkc6cL
         HiL9ZN1G/m3ghQKZDvPtUSWibjmgXr21DhoQPsa4wmh09TVXSt1dTPamAXILYS1rJ8
         f8GlQJjn4wHRQ==
Date:   Mon, 28 Aug 2023 19:07:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: admv1013: add mixer_vgate corner cases
Message-ID: <20230828190709.32228a9e@jic23-huawei>
In-Reply-To: <2df639c71d3a6e876efddd5ba18c56ca68a4ccaa.camel@gmail.com>
References: <20230807143806.6954-1-antoniu.miclaus@analog.com>
        <2df639c71d3a6e876efddd5ba18c56ca68a4ccaa.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 08:32:51 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-08-07 at 17:38 +0300, Antoniu Miclaus wrote:
> > Include the corner cases in the computation of the MIXER_VGATE register
> > value.
> >=20
> > According to the datasheet: The MIXER_VGATE values follows the VCM such
> > as, that for a 0V to 1.8V VCM, MIXER_VGATE =3D 23.89 VCM + 81, and for =
a >
> > 1.8V to 2.6V VCM, MIXER_VGATE =3D 23.75 VCM + 1.25.
> >=20
> > Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV101=
3")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Was a but of fuzz due to other fixes but I would be surprised if that was
a problem.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/frequency/admv1013.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/frequency/admv1013.c
> > b/drivers/iio/frequency/admv1013.c
> > index 9bf8337806fc..df29f1216b9a 100644
> > --- a/drivers/iio/frequency/admv1013.c
> > +++ b/drivers/iio/frequency/admv1013.c
> > @@ -348,9 +348,9 @@ static int admv1013_update_mixer_vgate(struct
> > admv1013_state *st)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vcm =3D regulator_get_v=
oltage(st->reg);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vcm < 1800000)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vcm <=3D 1800000)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mixer_vgate =3D (2389 * vcm / 1000000 + 8100) / =
100;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (vcm > 1800000 && vc=
m < 2600000)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (vcm > 1800000 && vc=
m <=3D 2600000)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mixer_vgate =3D (2375 * vcm / 1000000 + 125) / 1=
00;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL; =20
>=20

