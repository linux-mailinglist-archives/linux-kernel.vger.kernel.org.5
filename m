Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2769F793097
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjIEVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjIEVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:03:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70D113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:03:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcf2de59cso442679566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947829; x=1694552629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjPqknuo2mDjaP9SoVz4Eb5JjRDICHPaFcHA+B9Da20=;
        b=AqPvcBUNqrG2PrcQMOJ4PIuJoz29gzqrBvuArL00xyUwr4CWI4+VkYBqAYeBNFqxDY
         vp60GfEbceMg6pn4FGivmbIfQdWDmdaT8kgd6kiA9CmvkMkoMtr9+b5chqsIFp/5iuZz
         S3TlSLK6Yuu5Fr4WFzBgceDbiWQkiWq1iRM/oifZM9r6d/JL0lMAkbv8S9/GKDbQpQ4j
         MmokPVPX7sFJ7drxxz6pjqOp5QvIC4lsLfso4ct7Jtnlrm8O5HN7+U4cPW04pEjlhU7X
         lJPhtYQXbCIps5pKCAZgNoJBPPJHcCSIOQPNTzlnp4ShKjgX5UEUh1h0bvzRXMlBkThw
         7NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947829; x=1694552629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjPqknuo2mDjaP9SoVz4Eb5JjRDICHPaFcHA+B9Da20=;
        b=HkFTRPrb7ayOR/EUqdLLOVtYT2n1RcXyAWoENMXDmCmjVufV2h0InxQBIciuAMU3Ua
         AUrA1nzBM+WejuhmmWDaYUNW9ohqb8VtHxF4Zy/IVZrHTrPSVSa8YH1I0FhhJUJpRBBk
         JPbjmzp5OjKRcZmvvOmOIG8xJI7HEVtCVKDNQqS9nHMRTrIOICffgnMtT4rkyOohTlwV
         pnM8BEcPMmtJ9fbOCgQBUPv3+7KTTmAm0VKbpu1s1NuV6Fb7BTpzSL3idrdyjIaASf9z
         /hV//iQpZzFLFYY3VDHK56A2bx81GZh/GI6OR+fsz6wxf1cxBvUie86ShJE0p5ZBMbUH
         /qYg==
X-Gm-Message-State: AOJu0YxJqS1rWztLj05hYXN4sLXEbAZIiPvOZKJYpg7vH12CZiqEfhHB
        26VhkU14QJlp3DECMEYn+P8=
X-Google-Smtp-Source: AGHT+IHjvkCsZh/NZDzPnZtp4wbSToFrGbRkF/InP3eFnOUeV3UQDHrnno74F7Sf0f19rUCjp0oqIg==
X-Received: by 2002:a17:906:8a4e:b0:9a1:fab3:ee34 with SMTP id gx14-20020a1709068a4e00b009a1fab3ee34mr799547ejc.0.1693947828579;
        Tue, 05 Sep 2023 14:03:48 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id ss22-20020a170907c01600b00992e14af9c3sm8074503ejc.143.2023.09.05.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:03:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Matthew Croughan <matthew.croughan@nix.how>
Subject: Re: [PATCH v2] mfd: axp20x: Generalise handling without interrupt
Date:   Tue, 05 Sep 2023 23:03:46 +0200
Message-ID: <12280907.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20230905214642.1127f7cf@slackpad.lan>
References: <20230828213229.20332-1-andre.przywara@arm.com>
 <22003475.EfDdHjke4D@archlinux> <20230905214642.1127f7cf@slackpad.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 05. september 2023 ob 22:46:42 CEST je Andre Przywara napisal(a):
> On Tue, 05 Sep 2023 22:28:10 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > On Monday, August 28, 2023 11:32:29 PM CEST Andre Przywara wrote:
> > > At the moment we allow the AXP15060 and the AXP806 PMICs to omit the
> > > interrupt line to the SoC, and we skip registering the PEK (power key)
> > > driver in this case, since that crashes when no IRQ is described in t=
he
> > > DT node.
> > > The IRQ pin potentially not being connected to anything does affect m=
ore
> > > PMICs, though, and the PEK driver is not the only one requiring an
> > > interrupt: at least the AC power supply driver crashes in a similar
> > > fashion.
> > >=20
> > > Generalise the handling of AXP MFD devices when the platform tables
> > > describe no interrupt, by allowing each device to specify an alternat=
ive
> > > MFD list for this case. If no specific alternative is specified, we go
> > > with the safe default of "just the regulators", which matches the
> > > current
> > > situation.
> > >=20
> > > This enables new devices using the AXP313a PMIC, but not connecting t=
he
> > > IRQ pin.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > > Changelog v2 .. v1:
> > > - drop reordering approach, use separate cell lists
> > >=20
> > >  drivers/mfd/axp20x.c | 44 ++++++++++++++++++++++++------------------=
=2D-
> > >  1 file changed, 24 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > > index c03bc5cda080a..239e7f18956ae 100644
> > > --- a/drivers/mfd/axp20x.c
> > > +++ b/drivers/mfd/axp20x.c
> > > @@ -1133,6 +1133,8 @@ int axp20x_match_device(struct axp20x_dev *axp2=
0x)
> > >=20
> > >  	struct device *dev =3D axp20x->dev;
> > >  	const struct acpi_device_id *acpi_id;
> > >  	const struct of_device_id *of_id;
> > >=20
> > > +	const struct mfd_cell *cells_no_irq =3D NULL;
> > > +	int nr_cells_no_irq =3D 0;
> > >=20
> > >  	if (dev->of_node) {
> > >  =09
> > >  		of_id =3D of_match_device(dev->driver->of_match_table,
> >=20
> > dev);
> >=20
> > > @@ -1207,14 +1209,15 @@ int axp20x_match_device(struct axp20x_dev
> > > *axp20x)
> > >=20
> > >  		 * if there is no interrupt line.
> > >  		 */
> > >  	=09
> > >  		if (of_property_read_bool(axp20x->dev->of_node,
> > >=20
> > > -					  "x-powers,self-
> >=20
> > working-mode") &&
> >=20
> > > -		    axp20x->irq > 0) {
> > > +					  "x-powers,self-
> >=20
> > working-mode")) {
> >=20
> > >  			axp20x->nr_cells =3D
> >=20
> > ARRAY_SIZE(axp806_self_working_cells);
> >=20
> > >  			axp20x->cells =3D axp806_self_working_cells;
> > >  	=09
> > >  		} else {
> > >  	=09
> > >  			axp20x->nr_cells =3D=20
ARRAY_SIZE(axp806_cells);
> > >  			axp20x->cells =3D axp806_cells;
> > >  	=09
> > >  		}
> > >=20
> > > +		nr_cells_no_irq =3D ARRAY_SIZE(axp806_cells);
> > > +		cells_no_irq =3D axp806_cells;
> > >=20
> > >  		axp20x->regmap_cfg =3D &axp806_regmap_config;
> > >  		axp20x->regmap_irq_chip =3D &axp806_regmap_irq_chip;
> > >  		break;
> > >=20
> > > @@ -1238,24 +1241,8 @@ int axp20x_match_device(struct axp20x_dev
> > > *axp20x)
> > >=20
> > >  		axp20x->regmap_irq_chip =3D &axp803_regmap_irq_chip;
> > >  		break;
> > >  =09
> > >  	case AXP15060_ID:
> > > -		/*
> > > -		 * Don't register the power key part if there is no
> >=20
> > interrupt
> >=20
> > > -		 * line.
> > > -		 *
> > > -		 * Since most use cases of AXP PMICs are Allwinner
> >=20
> > SOCs, board
> >=20
> > > -		 * designers follow Allwinner's reference design and
> >=20
> > connects
> >=20
> > > -		 * IRQ line to SOC, there's no need for those variants
> >=20
> > to deal
> >=20
> > > -		 * with cases that IRQ isn't connected. However,
> >=20
> > AXP15660 is
> >=20
> > > -		 * used by some other vendors' SOCs that didn't=20
connect
> >=20
> > IRQ
> >=20
> > > -		 * line, we need to deal with this case.
> > > -		 */
> > > -		if (axp20x->irq > 0) {
> > > -			axp20x->nr_cells =3D
> >=20
> > ARRAY_SIZE(axp15060_cells);
> >=20
> > > -			axp20x->cells =3D axp15060_cells;
> > > -		} else {
> > > -			axp20x->nr_cells =3D
> >=20
> > ARRAY_SIZE(axp_regulator_only_cells);
> >=20
> > > -			axp20x->cells =3D axp_regulator_only_cells;
> > > -		}
> > > +		axp20x->nr_cells =3D ARRAY_SIZE(axp15060_cells);
> > > +		axp20x->cells =3D axp15060_cells;
> > >=20
> > >  		axp20x->regmap_cfg =3D &axp15060_regmap_config;
> > >  		axp20x->regmap_irq_chip =3D &axp15060_regmap_irq_chip;
> > >  		break;
> > >=20
> > > @@ -1263,6 +1250,23 @@ int axp20x_match_device(struct axp20x_dev
> > > *axp20x)
> > >=20
> > >  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x-
> > >
> > >variant);
> > >
> > >  		return -EINVAL;
> > >  =09
> > >  	}
> > >=20
> > > +
> > > +	/*
> > > +	 * Use an alternative cell array when no interrupt line is
> >=20
> > connected,
> >=20
> > > +	 * since IRQs are required by some drivers.
> > > +	 * The default is the safe "regulator-only", as this works fine
> >=20
> > without
> >=20
> > > +	 * an interrupt specified.
> > > +	 */
> > > +	if (axp20x->irq <=3D 0) {
> > > +		if (cells_no_irq) {
> > > +			axp20x->nr_cells =3D nr_cells_no_irq;
> > > +			axp20x->cells =3D cells_no_irq;
> > > +		} else {
> > > +			axp20x->nr_cells =3D
> >=20
> > ARRAY_SIZE(axp_regulator_only_cells);
> >=20
> > > +			axp20x->cells =3D axp_regulator_only_cells;
> >=20
> > axp806_cells (old value for AXP806_ID without irq) and
> > axp_regulator_only_cells differs in id field. Is that an issue?
>=20
> Yes, an annoying one, which led me to introduce the ability to let each
> PMIC override this default. So the case AXP806_ID: above sets the local
> variable cells_no_irq to axp806_cells, and the check above sees that it
> has been changed from the NULL initialisation and uses that instead of
> the default. At least that was my plan, let me know if I messed that
> up somehow, or if it deserves more comments.

Ah, yes. It looks ok, but it's not obvious. It's fine.
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
> > Best regards,
> > Jernej
> >=20
> > > +		}
> > > +	}
> > > +
> > >=20
> > >  	dev_info(dev, "AXP20x variant %s found\n",
> > >  =09
> > >  		 axp20x_model_names[axp20x->variant]);




