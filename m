Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3277BC976
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjJGRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjJGRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:54:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E29C;
        Sat,  7 Oct 2023 10:54:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32320381a07so3114559f8f.0;
        Sat, 07 Oct 2023 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696701296; x=1697306096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+9rLW5BACfYvqsc27+EIw2Rx9BgqFMDN6VrwKpFRSw=;
        b=fWorabLRpFRMTCDC4TUGZ/lQNiEJmi18fBCpXVvUOMSA+9bCtw75foEEdE2Z+QgD/0
         CLyH8jzvdlof65VeqXRgi+jvR55nbTy1usGVb9j+BddP1h3Vm1rpjmf6qhWoqsTOAhD6
         k/2bQL6k+a++hk+wlPyXDPPXclH47NuTeqgfuvrbdjlk9JVcDtLq+mlYsVqENsTC11dZ
         RpluGPFYlCCIMmmR9jB/8lp6Kymffh8jIHRbH/O+9WdoVWBf8JerE+vx3A6xJosVDVg/
         ybC3nedNDptvDWxcWHz+yeXjj8ifLaBKBrTqPuQ2RRvTUIHDCDSjbQdferE9Bjgz9XuY
         roRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696701296; x=1697306096;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+9rLW5BACfYvqsc27+EIw2Rx9BgqFMDN6VrwKpFRSw=;
        b=Ga4kf/hsgUcXwbTTWZbfUdqdnOoQWyZvLp9nsIV5trG7LEh6dzBKOyZeyGth3dYVBQ
         wJwYELzEOqR/1JN3Y1FafYgvdAafiaO6bVVUuNG8HrTi12p72K0sz64cji4mk9o+55cx
         9eefVU+FhbP3t+Cb8cjOmF1a+Nj3jl9H0Wzs3lD29nLUQuBc4D1Ggv6r6fKzY/NDUIuO
         yszQ431qKvp+20D5bPJbpqAp4JPpMh3mAb7aU5mnVKk3cmxTGRRNgslD7eEYye5KmJPb
         /KxUQQboqFeL4Ymzz14ooXsCwbogL7sWpkwJxtGkYQfJQagASe/G7Q5viehx5u/t0WsE
         DdzQ==
X-Gm-Message-State: AOJu0YzCI/To6a7VhQulny8VMjj96AMRYPS8n4h/aENxtuC28VCvChNX
        TpYBWXtmqFw+7DXLrEYm4qE=
X-Google-Smtp-Source: AGHT+IHg8ifpO6aipIRsyFUCeYg7f3pAPFnIZjwO1VcW0j8Ktm89N8koBu7sssE1+ZUFYkmD3rtDvA==
X-Received: by 2002:a5d:4383:0:b0:31f:8999:c409 with SMTP id i3-20020a5d4383000000b0031f8999c409mr9571781wrq.66.1696701295645;
        Sat, 07 Oct 2023 10:54:55 -0700 (PDT)
Received: from [127.0.0.1] ([195.226.184.10])
        by smtp.gmail.com with ESMTPSA id ev5-20020a056402540500b0053b67aba57bsm1358511edb.17.2023.10.07.10.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 10:54:55 -0700 (PDT)
Date:   Sat, 07 Oct 2023 19:54:53 +0200
From:   Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>
CC:     Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_clk=3A_si5351=3A_all?= =?US-ASCII?Q?ow_PLLs_to_be_adjusted_without_reset?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231004063712.3348978-5-alvin@pqrs.dk>
References: <20231004063712.3348978-1-alvin@pqrs.dk> <20231004063712.3348978-5-alvin@pqrs.dk>
Message-ID: <C2AD7957-E361-4B27-BCA3-B807314752C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

thanks for the patch=2E In general, I am fine with the change as default b=
ehavior is to do what it did before=2E

So,
Acked-by: <sebastian=2Ehesselbarth@gmail=2Ecom>
for the functional changes=2E

For the DT changes you'll need Rob, Stephen, Michael's approval more than =
mine=2E

However, as Jacob and Sergej already noticed on their patches, I cannot sp=
end enough time for maintaining the driver anymore=2E

Is there anyone volunteering to pick maintainership up?

Regards,
  Sebastian

(Hopefully plain/text now)


Am 4=2E Oktober 2023 08:35:30 MESZ schrieb "Alvin =C5=A0ipraga" <alvin@pqr=
s=2Edk>:
>From: Alvin =C5=A0ipraga <alsi@bang-olufsen=2Edk>
>
>Introduce a new PLL reset mode flag which controls whether or not to
>reset a PLL after adjusting its rate=2E The mode can be configured throug=
h
>platform data or device tree=2E
>
>Since commit 6dc669a22c77 ("clk: si5351: Add PLL soft reset"), the
>driver unconditionally resets a PLL whenever its rate is adjusted=2E
>The rationale was that a PLL reset was required to get three outputs
>working at the same time=2E Before this change, the driver never reset th=
e
>PLLs=2E
>
>Commit b26ff127c52c ("clk: si5351: Apply PLL soft reset before enabling
>the outputs") subsequently introduced an option to reset the PLL when
>enabling a clock output that sourced it=2E Here, the rationale was that
>this is required to get a deterministic phase relationship between
>multiple output clocks=2E
>
>This clearly shows that it is useful to reset the PLLs in applications
>where multiple clock outputs are used=2E However, the Si5351 also allows
>for glitch-free rate adjustment of its PLLs if one avoids resetting the
>PLL=2E In our audio application where a single Si5351 clock output is use=
d
>to supply a runtime adjustable bit clock, this unconditional PLL reset
>behaviour introduces unwanted glitches in the clock output=2E
>
>It would appear that the problem being solved in the former commit
>may be solved by using the optional device tree property introduced in
>the latter commit, obviating the need for an unconditional PLL reset
>after rate adjustment=2E But it's not OK to break the default behaviour o=
f
>the driver, and it cannot be assumed that all device trees are using the
>property introduced in the latter commit=2E Hence, the new behaviour is
>made opt-in=2E
>
>Cc: Sebastian Hesselbarth <sebastian=2Ehesselbarth@gmail=2Ecom>
>Cc: Rabeeh Khoury <rabeeh@solid-run=2Ecom>
>Cc: Jacob Siverskog <jacob@teenage=2Eengineering>
>Cc: Sergej Sawazki <sergej@taudac=2Ecom>
>Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen=2Edk>
>---
> drivers/clk/clk-si5351=2Ec             | 47 ++++++++++++++++++++++++++--
> include/linux/platform_data/si5351=2Eh |  2 ++
> 2 files changed, 46 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/clk/clk-si5351=2Ec b/drivers/clk/clk-si5351=2Ec
>index 00fb9b09e030=2E=2E95d7afb8cfc6 100644
>--- a/drivers/clk/clk-si5351=2Ec
>+++ b/drivers/clk/clk-si5351=2Ec
>@@ -506,6 +506,8 @@ static int si5351_pll_set_rate(struct clk_hw *hw, uns=
igned long rate,
> {
> 	struct si5351_hw_data *hwdata =3D
> 		container_of(hw, struct si5351_hw_data, hw);
>+	struct si5351_platform_data *pdata =3D
>+		hwdata->drvdata->client->dev=2Eplatform_data;
> 	u8 reg =3D (hwdata->num =3D=3D 0) ? SI5351_PLLA_PARAMETERS :
> 		SI5351_PLLB_PARAMETERS;
>=20
>@@ -518,9 +520,10 @@ static int si5351_pll_set_rate(struct clk_hw *hw, un=
signed long rate,
> 		(hwdata->params=2Ep2 =3D=3D 0) ? SI5351_CLK_INTEGER_MODE : 0);
>=20
> 	/* Do a pll soft reset on the affected pll */
>-	si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
>-			 hwdata->num =3D=3D 0 ? SI5351_PLL_RESET_A :
>-					    SI5351_PLL_RESET_B);
>+	if (pdata->pll_reset[hwdata->num])
>+		si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
>+				 hwdata->num =3D=3D 0 ? SI5351_PLL_RESET_A :
>+						    SI5351_PLL_RESET_B);
>=20
> 	dev_dbg(&hwdata->drvdata->client->dev,
> 		"%s - %s: p1 =3D %lu, p2 =3D %lu, p3 =3D %lu, parent_rate =3D %lu, rat=
e =3D %lu\n",
>@@ -1222,6 +1225,44 @@ static int si5351_dt_parse(struct i2c_client *clie=
nt,
> 		}
> 	}
>=20
>+	/*
>+	 * Parse PLL reset mode=2E For compatibility with older device trees, t=
he
>+	 * default is to always reset a PLL after setting its rate=2E
>+	 */
>+	pdata->pll_reset[0] =3D true;
>+	pdata->pll_reset[1] =3D true;
>+
>+	of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, num) {
>+		if (num >=3D 2) {
>+			dev_err(&client->dev,
>+				"invalid pll %d on pll-reset-mode prop\n", num);
>+			return -EINVAL;
>+		}
>+
>+		p =3D of_prop_next_u32(prop, p, &val);
>+		if (!p) {
>+			dev_err(&client->dev,
>+				"missing pll-reset-mode for pll %d\n", num);
>+			return -EINVAL;
>+		}
>+
>+		switch (val) {
>+		case 0:
>+			/* Reset PLL whenever its rate is adjusted */
>+			pdata->pll_reset[num] =3D true;
>+			break;
>+		case 1:
>+			/* Don't reset PLL whenever its rate is adjusted */
>+			pdata->pll_reset[num] =3D false;
>+			break;
>+		default:
>+			dev_err(&client->dev,
>+				"invalid pll-reset-mode %d for pll %d\n", val,
>+				num);
>+			return -EINVAL;
>+		}
>+	}
>+
> 	/* per clkout properties */
> 	for_each_child_of_node(np, child) {
> 		if (of_property_read_u32(child, "reg", &num)) {
>diff --git a/include/linux/platform_data/si5351=2Eh b/include/linux/platf=
orm_data/si5351=2Eh
>index c71a2dd66143=2E=2E5f412a615532 100644
>--- a/include/linux/platform_data/si5351=2Eh
>+++ b/include/linux/platform_data/si5351=2Eh
>@@ -105,10 +105,12 @@ struct si5351_clkout_config {
>  * @clk_xtal: xtal input clock
>  * @clk_clkin: clkin input clock
>  * @pll_src: array of pll source clock setting
>+ * @pll_reset: array indicating if plls should be reset after setting th=
e rate
>  * @clkout: array of clkout configuration
>  */
> struct si5351_platform_data {
> 	enum si5351_pll_src pll_src[2];
>+	bool pll_reset[2];
> 	struct si5351_clkout_config clkout[8];
> };
>=20
