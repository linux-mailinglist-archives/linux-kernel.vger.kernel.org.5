Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711877DA96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbjHPGlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbjHPGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:41:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F41FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:41:29 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230816064128epoutp021f5d6c361d86c627bf95c80ad48cb82e~7yekZ_DAs0361403614epoutp024
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:41:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230816064128epoutp021f5d6c361d86c627bf95c80ad48cb82e~7yekZ_DAs0361403614epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692168088;
        bh=tSpqpe+NndsJSml25Ty/Pcsmgxf7yAd7q8+F1xs5ilU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hMWHhKDnRyDGMDmwNYCYG1w1Ak5+tysQZo4wnQmlmWiezz1qBlpt2ssSWszojmNeB
         kfmHtisdzDbEwjQHf5Trr1Md6DPGDeIprl2DO5lpmVmyg4BtGnu+s7pzQEKTdRbwR4
         ax2kR8dfUcZcmcjiei4mbL6MQBaRgpMzkXdrfCgQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230816064127epcas5p3023082194b91c42fc2daa1c4573d9716~7yejkDUCz0319403194epcas5p3R;
        Wed, 16 Aug 2023 06:41:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RQdnx2SQkz4x9Q2; Wed, 16 Aug
        2023 06:41:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.1D.44250.59F6CD46; Wed, 16 Aug 2023 15:41:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230816063855epcas5p4a25f63933d3d884ca296d4631b6e0fd7~7ycWgWOl02624426244epcas5p4Q;
        Wed, 16 Aug 2023 06:38:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816063855epsmtrp262ad6ce781b2da1e71bd2acf7bab0c90~7ycWfCaJj2180521805epsmtrp29;
        Wed, 16 Aug 2023 06:38:55 +0000 (GMT)
X-AuditID: b6c32a4a-4c3bea800000acda-03-64dc6f95df33
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.A9.14748.FFE6CD46; Wed, 16 Aug 2023 15:38:55 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230816063852epsmtip2c14ae8c83b7d7d8eac3411ff4f054295~7ycTQZLdS1003010030epsmtip2w;
        Wed, 16 Aug 2023 06:38:52 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
        <pankaj.dubey@samsung.com>, <swathi.ks@samsung.com>,
        <ravi.patel@samsung.com>
Cc:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Chandrasekar R'" <rcsekar@samsung.com>,
        "'Suresh Siddha'" <ssiddha@tesla.com>
In-Reply-To: <b224ccaf-d70f-8f65-4b2f-6f4798841558@linaro.org>
Subject: RE: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date:   Wed, 16 Aug 2023 12:08:50 +0530
Message-ID: <001201d9d00c$5413a9a0$fc3afce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAI1Xm+tAnXeS/UBtEgXlbAD+MpQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTH8/r6+oqh7FEQLrAt5CWgsACtlO6WiFuUkWaYDJxDZRrs6BMY
        /bX+ULeM6EQmMEA3ApMCFVFkIsy0UMKP1iFl4ESBKJAx0VEGGwgTBEPCxLKWBxv/fc6553y/
        59yby0a5Rbg/O0OhpdQKiYxkbWE220K2hZUoR6U8i8MDLk+XInDM0MyC9dY+BqzoP8uEl7r6
        MDjZPY7DJ9XPMFg0ZUehdcaMw4HmIgya/hjGoP3pAfiwrYIFL/bfYkDDqwYMdlf5wKXeWQRW
        m1/g0D5vwaF+oAWDXfemUJhj7cJh9VgVBl8YR/B3gbjp+ghDPHnejItb9Y9xcZVJJzbV5bHE
        o8MWlrjx6inx3K0hlrioqQ4RN/20iIgdZypx8aLpzQT35Myd6ZRESqkDKUWqUpqhSIsh4z9M
        2ZMSJeTxw/gi+DYZqJDIqRgydm9CWFyGzLk6GXhcItM5UwkSjYaM2LVTrdRpqcB0pUYbQ1Iq
        qUwlUIVrJHKNTpEWrqC00Xweb0eUs/BoZvp92wpDZeOdNDTWYKeR58H5iBsbEAKw2lvPyEe2
        sLlEOwLONemZdLCAgOkVE0IHSwhoqMlFNlpMBasofWBFwPhI5XrwFwKKa+8yXFUsIgLM/HCJ
        5WJv4k8UGAwnXIwSDgTUPjjiYjdiF9D35DJd7EXEgaqB0jVmEkHg65xepyibzSFEoHPskCvN
        ITzBL2UTTFrmLXDt8gxKDxQIlievYbRVHDDbynC6xhf8vFywNhsgbG7gH8sQ5tIERCxobkik
        e73A054mnGZ/sPjMyqI5DTR2NWI0y0Dumex1r3dAx2AF0yWDEiHgZlsEnX4DlNz9kUHbeoDC
        lxMMOs8BLYYNDgZXxvPW+XXQML6AXUBI/abN9Js202/aQP+/WxXCrEP8KJVGnkZpolQ7FNSJ
        /947VSk3IWsfI/T9FsQ+Nh/eiTDYSCcC2CjpzSng/CblcqSSz7+g1MoUtU5GaTqRKOdtf4v6
        b01VOn+WQpvCF4h4AqFQKBBFCvmkL2cmp1LKJdIkWiqTolSUeqOPwXbzP83ITg1xGGdjV26X
        aJPPBbz0371vdZKXpSEGia2DPh9M+V2dchzvZgkPcrULQTZ2/lyYKG/i0ZO9vp7by1OGvl86
        cENYdP9wYad7uTfHcrjPGHX5ypzDFmkNFiR/nBR06Pp23afz6oWk8yMz4dmvAkRHWvdN7z8r
        xyZKix+Z71DabDLeLLkXH2n0ArOxueWRN3b3PAgIZ/bG2cGAEk0o60i0YONtv/sdNb+2Urdo
        fSg91lobWL3U6+6I2b+t36N49Ltvbnpm+YQOR7fvyTrZ0a4qbH/PV28+KHB8cuzXjxJFF+U1
        ChP1ZbQxo5Z9+/FnAV8t/220t0QmrfTfUXNP1WcpnpNMTbqEH4qqNZJ/AQ/YVXKhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCSvO7/vDspBud/ylr8fDmN0eLBvG1s
        Fmv2nmOymHO+hcVi/pFzrBZPjz1it7i36B2rRd+Lh8wWe19vZbe4sK2P1WLT42usFg9fhVtc
        3jWHzWLG+X1MFvP+rmW1OLZAzOLb6TeMFou2fmG3ePhhD7vFrAs7WC2OnHnBbNG69wi7xaIH
        C1gtvmy8ye4g4bFl5U0mj6f9W9k9ds66y+6xYFOpx6ZVnWwed67tYfPYvKTe4/2+q2wefVtW
        MXps2f+Z0eNf01x2j8+b5AJ4orhsUlJzMstSi/TtErgydl26zV6wRL9ix85lzA2MF1S7GDk5
        JARMJDb1/GfuYuTiEBLYzSixafYmNoiEjMTJB0uYIWxhiZX/nrNDFD1llJg2+RE7SIJNQF/i
        9Yr5bCAJEYFvzBKPXu8Ac5gFWpgkGg4cA2sXEvjMKPHmShqIzSlgJzHreAcLiC0s4Cax4MI0
        MJtFQFWirfU0UD0HB6+ApcShB5EgYV4BQYmTM5+AlTALaEs8vfkUzl628DXUdQoSP58uYwWx
        RYBGbj08kx2iRlzi6M8e5gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz032bDAMC+1XK84
        Mbe4NC9dLzk/dxMjOHFoaexgvDf/n94hRiYOxkOMEhzMSiK8Pby3UoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgMjmz4+w2/7oMEb3czrnnZ77ac9rv
        zxyvSVtv3589M0BlxzeRpbu33cvyWutxo6FBK/BUghjX777UePlZG2aL/E/SD3zkZnv1Cfv9
        pfPOrzK/ybJtjemjUx9zNO+c2ub5I8FrnuwdG657T4/q7L3yfWHHQ96pnr4ztunN/zg3zKLc
        SmlCsJfZ58TZLFMF9oX3PAlvM1E01lmYnH3XyVRWZHncC4u1/34rF/hm/Dktdu/dEnXZJKsf
        Xq7SfZve5onc9I9bHnB7hsgWO6GM897KB87uFTjtH7k1p//QB7E7/jkXvVSyC5yzXh1e/yNo
        96susauigaycNevVlnh1TeNj7n/9SXCFe5Pt2TR7/uLf75VYijMSDbWYi4oTAeyV0luLAwAA
X-CMS-MailID: 20230816063855epcas5p4a25f63933d3d884ca296d4631b6e0fd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
        <20230814112539.70453-3-sriranjani.p@samsung.com>
        <b224ccaf-d70f-8f65-4b2f-6f4798841558@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 15 August 2023 01:21
> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> alexandre.torgue=40foss.st.com; joabreu=40synopsys.com;
> mcoquelin.stm32=40gmail.com; alim.akhtar=40samsung.com; linux-
> fsd=40tesla.com; pankaj.dubey=40samsung.com; swathi.ks=40samsung.com;
> ravi.patel=40samsung.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; Chandrasekar R <rcsekar=40samsung.com>;
> Suresh Siddha <ssiddha=40tesla.com>
> Subject: Re: =5BPATCH v3 2/4=5D net: stmmac: dwc-qos: Add FSD EQoS suppor=
t
>=20
> On 14/08/2023 13:25, Sriranjani P wrote:
> > The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP
> core.
> > The binding that it uses is slightly different from existing ones
> > because of the integration (clocks, resets).
> >
> > For FSD SoC, a mux switch is needed between internal and external clock=
s.
> > By default after reset internal clock is used but for receiving
> > packets properly, external clock is needed. Mux switch to external
> > clock happens only when the external clock is present.
> >
> > Signed-off-by: Chandrasekar R <rcsekar=40samsung.com>
> > Signed-off-by: Suresh Siddha <ssiddha=40tesla.com>
> > Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> > ---
>=20
>=20
> > +static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int
> > +ins_num) =7B
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct regmap *syscon;
> > +	unsigned int reg;
> > +
> > +	if (np && of_property_read_bool(np, =22fsd-rx-clock-skew=22)) =7B
> > +		syscon =3D syscon_regmap_lookup_by_phandle_args(np,
> > +							      =22fsd-rx-clock-
> skew=22,
> > +							      1, &reg);
> > +		if (IS_ERR(syscon)) =7B
> > +			dev_err(&pdev->dev,
> > +				=22couldn't get the rx-clock-skew syscon=21=5Cn=22);
> > +			return PTR_ERR(syscon);
> > +		=7D
> > +
> > +		regmap_write(syscon, reg, rx_clock_skew_val=5Bins_num=5D);
> > +	=7D
> > +
> > +	return 0;
> > +=7D
> > +
> > +static int fsd_eqos_clk_init(struct fsd_eqos_plat_data *plat,
> > +			     struct plat_stmmacenet_data *data) =7B
> > +	int ret =3D 0, i;
> > +
> > +	const struct fsd_eqos_variant *fsd_eqos_v_data =3D
> > +						plat->fsd_eqos_inst_var;
> > +
> > +	plat->clks =3D devm_kcalloc(plat->dev, fsd_eqos_v_data->num_clks,
> > +				  sizeof(*plat->clks), GFP_KERNEL);
> > +	if (=21plat->clks)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < fsd_eqos_v_data->num_clks; i++)
> > +		plat->clks=5Bi=5D.id =3D fsd_eqos_v_data->clk_list=5Bi=5D;
> > +
> > +	ret =3D devm_clk_bulk_get(plat->dev, fsd_eqos_v_data->num_clks,
> > +				plat->clks);
>=20
> Instead of duplicating entire clock management with existing code, you
> should extend/rework existing one.
>=20
> This code is unfortunately great example how not to stuff vendor code int=
o
> upstream project. :(

I will check again if I can extend existing one to support FSD platform spe=
cific requirement.

>=20
> > +
> > +	return ret;
> > +=7D
> > +
> > +static int fsd_clks_endisable(void *priv, bool enabled) =7B
> > +	int ret, num_clks;
> > +	struct fsd_eqos_plat_data *plat =3D priv;
> > +
> > +	num_clks =3D plat->fsd_eqos_inst_var->num_clks;
> > +
> > +	if (enabled) =7B
> > +		ret =3D clk_bulk_prepare_enable(num_clks, plat->clks);
> > +		if (ret) =7B
> > +			dev_err(plat->dev, =22Clock enable failed, err =3D %d=5Cn=22,
> ret);
> > +			return ret;
> > +		=7D
> > +	=7D else =7B
> > +		clk_bulk_disable_unprepare(num_clks, plat->clks);
> > +	=7D
> > +
> > +	return 0;
> > +=7D
> > +
> > +static int fsd_eqos_probe(struct platform_device *pdev,
> > +			  struct plat_stmmacenet_data *data,
> > +			  struct stmmac_resources *res)
> > +=7B
> > +	struct fsd_eqos_plat_data *priv_plat;
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	int ret =3D 0;
> > +
> > +	priv_plat =3D devm_kzalloc(&pdev->dev, sizeof(*priv_plat),
> GFP_KERNEL);
> > +	if (=21priv_plat) =7B
> > +		ret =3D -ENOMEM;
>=20
> return -ENOMEM

Will fix this in v4.

>=20
> > +		goto error;
> > +	=7D
> > +
> > +	priv_plat->dev =3D &pdev->dev;
> > +	data->bus_id =3D of_alias_get_id(np, =22eth=22);
>=20
> No, you cannot do like this. Aliases are board specific and are based on
> labeling on the board.

So if I understood this correctly, I need to move alias in the board specif=
ic DTS file and I can use this, because we have to handle rx-clock-skew dif=
ferently for the two instances in the FSD platform. Another approach we too=
k in v1, by specifying the value to be programmed in rx-clock-skew property=
 itself, but it seems it is not a preferred approach.=20
I can see that in drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c +43=
6 common code is already using this API and getting alias id, so I can prob=
ably use the same rather getting same again here, but I have to specify ali=
as in DTS file.

>=20
> > +
> > +	priv_plat->fsd_eqos_inst_var =3D &fsd_eqos_clk_info=5Bdata->bus_id=5D=
;
> > +
> > +	ret =3D fsd_eqos_clk_init(priv_plat, data);
> > +
> > +	data->bsp_priv =3D priv_plat;
> > +	data->clks_config =3D fsd_clks_endisable;
> > +	data->rxmux_setup =3D dwc_eqos_rxmux_setup;
> > +
> > +	ret =3D fsd_clks_endisable(priv_plat, true);
> > +	if (ret)
> > +		goto error;
> > +
> > +	ret =3D dwc_eqos_setup_rxclock(pdev, data->bus_id);
> > +	if (ret) =7B
> > +		fsd_clks_endisable(priv_plat, false);
> > +		dev_err_probe(&pdev->dev, ret, =22Unable to setup
> rxclock=5Cn=22);
>=20
> The syntax is: return dev_err_probe().

Will fix it in v4.

>=20
> > +	=7D
> > +
> > +error:
> > +	return ret;
> > +=7D
>=20
> ....
>=20
>=20
> Best regards,
> Krzysztof


