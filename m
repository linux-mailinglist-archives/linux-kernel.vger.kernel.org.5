Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B277B875
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHNMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjHNMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:14:10 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D037E7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:14:08 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230814121406epoutp02dfd19fa68f645306ed799b63ff9e4912~7PubsODCs2098420984epoutp02f
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230814121406epoutp02dfd19fa68f645306ed799b63ff9e4912~7PubsODCs2098420984epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015246;
        bh=j5rdSmBKRnRxfErWJPzk0HAdBSyDZUwrIdeWXOSLw1I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Vx+D6FswOFzL18LhVDS7F09OHLdOYXMnoTv4Pq32JtkyYsdCkS+UAKrP4fIcXBayY
         5ZvLtrOzmps9to5eftYQsqa3UZqCgbMfsxgEzv1/DI0cg1YC026iDsdw3ktAYMrNsu
         JU+5e7XkGN6P877j8WwuTRy1IgHCWb3dzx7Ag7ds=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230814121405epcas5p3abb616d4017400cf74f769afd624df82~7PuatRSRX2391223912epcas5p3v;
        Mon, 14 Aug 2023 12:14:05 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RPYGg3bfxz4x9Pt; Mon, 14 Aug
        2023 12:14:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.FF.44250.B8A1AD46; Mon, 14 Aug 2023 21:14:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230814102741epcas5p45717e437f88011c36f634329eca7879b~7ORg8iE2a1433014330epcas5p4f;
        Mon, 14 Aug 2023 10:27:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814102741epsmtrp17c50cb704ccdc51fdf1df385e66f82e4~7ORg7iF8q1830318303epsmtrp1n;
        Mon, 14 Aug 2023 10:27:41 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-29-64da1a8bddf4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.43.64355.D910AD46; Mon, 14 Aug 2023 19:27:41 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814102738epsmtip2b22133fe25b9fe7fdf040c9f012bc0e3~7OReWL5br0935709357epsmtip2s;
        Mon, 14 Aug 2023 10:27:38 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>
Cc:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <ravi.patel@samsung.com>,
        "'Jayati Sahu'" <jayati.sahu@samsung.com>, <swathi.ks@samsung.com>
In-Reply-To: <7d74a96e-e3a5-118c-04a9-e8ed95fffa54@linaro.org>
Subject: RE: [PATCH v2 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date:   Mon, 14 Aug 2023 15:57:29 +0530
Message-ID: <000101d9ce99$f454da20$dcfe8e60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQGL0eLTHe4L9QyPOdGPE73PwLZVZAHe9r7UAmSEgRUC2omxnrBMnmnw
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTdxjH/d21dwVSdwOFnx1u5BhGQF6KwA4ijmTEXDYlLGbLwhLhQs8W
        Kdeu127OTYIDGRTHi5mLNAUKTDbZFK2AooKElWrrNhkKzhfkJTAFFmW8qB1RV3rg+O/ze37P
        93me7+9FgvrOYTJJNqdndRyjJjFvUdsvoaERpbLbiugH7ZByTXwHqOGaNowyXysUUbW238XU
        uH0Up2zO7xHqXv1DMVX2YASlOqZacaq3rUxMXT9vxqiaZyfElN3iTz2++jeg6lvncOrFVCug
        RqYv4tTBDhtOzZ2+hSf70S3HbyH0eHkrTrebBnHaYjXQ1qYSjL47cBGjH3X2Y3RZSxOgx592
        oHTLpVlAz1pfT/NJz9miYhkFqwtiuSyNIptTJpHv7cx4JyMuPloeIU+g3iKDOCaXTSJTtqdF
        bMtWu+2RQZ8yaoM7lMbwPBm1dYtOY9CzQSoNr08iWa1CrY3VRvJMLm/glJEcq0+UR0fHxLkT
        M3NUVaZ+XFsRsdf83CrOB/1vGoGXBBKx0HzJiRiBt8SXuACgy9UPhMUMgFfMhfjLxeSpNmxZ
        MtFiAovsS7QD2GzbKCTdB/DPEod4cQMjouDUj7UewRrCjsD7ro8Xk1BiHsCOYQu+uOFFbIU9
        h0c97EfsgnVGp6eqiAiB7QsHPIWkRAKsbOjCBH4VOqrGRIuMEuGwsW4KFSYKgq7xRrEQD4A9
        rkOo0HgbrDS+8FiARLkX/LnRKBIEKXDsr8klsR+cvNyCCyyDE+VFS6yEZ2xnxAKrYfFXBUv5
        b8OuG2Z3HYm7WShsPh8lhNfDI86TiDDDavjNwhgixKXwXM0yb4ANoyVLHAhPjM6IKwBpWmHN
        tMKaaYUd0//dLEDUBNaxWj5XyfJx2hiO/ezljWdpcq3A8/zD3j0HRoanI7sBIgHdAEpQco30
        kPS2wleqYD7fx+o0GTqDmuW7QZz7vCtR2dosjfv/cPoMeWxCdGx8fHxswuZ4ORkgnTpYrfAl
        lIyezWFZLatb1iESL1k+0onsuXY2j9jUKy/dV5JvvFcwfbPoYSrJVfVlFnJ7i6WrChK6+44+
        +yIs0eLfv5DqRO6uL1r1AetwpiiC/UdyOpDXhoZXFwdaHU523eDzn3SvPI3ctfuy99BuWXGS
        LCXrcVu74fiOtWlvqHp2ZHfWhXPBjrFjkk+SzyaGHEtrmjugAradlY7G7embb9rsUr/KR9SX
        H/7ThTU0mZNSi4L7ivR5p2uP+lQ/iSu9UqFIHvph8FeaqR4o9Am8/m9mwNf8kT3GvG/H5k0f
        bbLPvu/YP4D2lm2U1Nw5ud8VoiyJUUWMRD2RoaMXmPGZP3qb7V03LPPh6afubLhar5onwlYN
        /dbHkyJexcjDUB3P/AeZHZL0hwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSvO5cxlspBktvs1n8fDmN0eLBvG1s
        FnPOt7BYzD9yjtXi6bFH7BZHTi1hsri36B2rRd+Lh8wWe19vZbe4sK2P1eLyrjlsFvP+rmW1
        OLZAzOLb6TeMFou2fmG3+P96K6PFww972C1a9x5ht/iy8Sa7g7DHlpU3mTye9m9l99g56y67
        x4JNpR6bVnWyedy5tofN4/2+q2wefVtWMXo8/bGX2WPL/s+MHp83yQVwR3HZpKTmZJalFunb
        JXBltB7ezlSwWrviR8c15gbGT0pdjJwcEgImEi+3zGLsYuTiEBLYzihxfe5vVoiEjMTJB0uY
        IWxhiZX/nrNDFD1llLjZ8oQFJMEmoC/xesV8NhBbROACk8Sij9YgRcwCfxklpu1bzQLR8ZVR
        YkL3HrAOTgE7iaOTHrGD2MICMRJbLz4Ds1kEVCV2/m4EW80rYCkxcfEBNghbUOLkTIhtzALa
        Er0PWxlh7GULX0OdpyDx8+kyVoi4uMTRnz3MEBe5SUzs+s8+gVF4FpJRs5CMmoVk1Cwk7QsY
        WVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBMe+VtAOxmXr/+odYmTiYDzEKMHBrCTCe8v9
        WooQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk+iGRI9H
        H2bVlWzyWx28X+xaf4R4ldKxRdJVxe9/ayja3y48w3njfNj+Q8uyMstW8STJnQ7iln/06p6U
        pqPHXWuOFo+p9wy0FAq3MX0yqZBWuSgUGz7vXPmluvnqOkIT5ztNWXPu51/71D/H+Pkv3eZ9
        zhu+8ET08kPfdPiMF771mria6fISxZ7Qz9ezWNYvalGNvvZg+QEPvx8/Q3Z4OxgZ9y9urZCf
        veqD0EmPGzYnf8wQ0e297R9xp21K8J2eujtHS60X9wQKTbvoc+rvO8lImZA27R2rjMKsl/Jc
        +M/UXWnewLc/3cVbqXtXQ0Zk5imtowvcbBNvW/+sYBYOtn9x7NevJHW1fIG3zCWcSizFGYmG
        WsxFxYkAeUnmlGwDAAA=
X-CMS-MailID: 20230814102741epcas5p45717e437f88011c36f634329eca7879b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230111075455epcas5p1951d1981f15d252e09281621ef5fbf15
References: <20230111075422.107173-1-sriranjani.p@samsung.com>
        <CGME20230111075455epcas5p1951d1981f15d252e09281621ef5fbf15@epcas5p1.samsung.com>
        <20230111075422.107173-5-sriranjani.p@samsung.com>
        <7d74a96e-e3a5-118c-04a9-e8ed95fffa54@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 12 January 2023 15:07
> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> alexandre.torgue=40foss.st.com; peppe.cavallaro=40st.com;
> joabreu=40synopsys.com; mcoquelin.stm32=40gmail.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; pankaj.dubey=40samsung.com;
> alim.akhtar=40samsung.com; ravi.patel=40samsung.com; Jayati Sahu
> <jayati.sahu=40samsung.com>
> Subject: Re: =5BPATCH v2 4/4=5D arm64: dts: fsd: Add Ethernet support for=
 PERIC
> Block of FSD SoC
>=20
> On 11/01/2023 08:54, Sriranjani P wrote:
> > The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
> > one in
> > FSYS0 block and other in PERIC block.
> >
> > Adds device tree node for Ethernet in PERIC Block and enables the same
> > for FSD platform.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Jayati Sahu <jayati.sahu=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts      =7C  9 ++++
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 56
> ++++++++++++++++++++++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C 29 +++++++++++
> >  3 files changed, 94 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index ca0c1a28d562..2c0cbe775e04 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > =40=40 -39,6 +39,15 =40=40
> >  	=7D;
> >  =7D;
> >
> > +&ethernet_1 =7B
> > +	status =3D =22okay=22;
> > +
> > +	fixed-link =7B
> > +		speed =3D <1000>;
> > +		full-duplex;
> > +	=7D;
> > +=7D;
> > +
> >  &fin_pll =7B
> >  	clock-frequency =3D <24000000>;
> >  =7D;
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > index 7ccc0738a149..c955bf159786 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > =40=40 -395,6 +395,62 =40=40
> >  		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> >  		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
> >  	=7D;
> > +
> > +	eth1_tx_clk: eth1-tx-clk-pins =7B
> > +		samsung,pins =3D =22gpf2-0=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_DOWN>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_tx_data: eth1-tx-data-pins =7B
> > +		samsung,pins =3D =22gpf2-1=22, =22gpf2-2=22, =22gpf2-3=22, =22gpf2-4=
=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_tx_ctrl: eth1-tx-ctrl-pins =7B
> > +		samsung,pins =3D =22gpf2-5=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_phy_intr: eth1-phy-intr-pins =7B
> > +		samsung,pins =3D =22gpf2-6=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> > +	=7D;
> > +
> > +	eth1_rx_clk: eth1-rx-clk-pins =7B
> > +		samsung,pins =3D =22gpf3-0=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_rx_data: eth1-rx-data-pins =7B
> > +		samsung,pins =3D =22gpf3-1=22, =22gpf3-2=22, =22gpf3-3=22, =22gpf3-4=
=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_rx_ctrl: eth1-rx-ctrl-pins =7B
> > +		samsung,pins =3D =22gpf3-5=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth1_mdio: eth1-mdio-pins =7B
> > +		samsung,pins =3D =22gpf3-6=22, =22gpf3-7=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> > +	=7D;
> >  =7D;
> >
> >  &pinctrl_pmu =7B
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index ade707cc646b..8807055807dd 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > =40=40 -33,6 +33,7 =40=40
> >  		spi1 =3D &spi_1;
> >  		spi2 =3D &spi_2;
> >  		eth0 =3D &ethernet_0;
> > +		eth1 =3D &ethernet_1;
>=20
> Nope for the reasons I explained last time.
Sorry somehow I'm not able to find my previous mail chain.
I had replied to your comment in the previous version of the mail.
In this case alias id is used to differentiate between Ethernet instance 0 =
and 1 in the driver code.
>=20
> >  	=7D;
> >
> >  	cpus =7B
> > =40=40 -882,6 +883,34 =40=40
> >  			phy-mode =3D =22rgmii=22;
> >  			status =3D =22disabled=22;
> >  		=7D;
> > +
> > +		ethernet_1: ethernet=4014300000 =7B
>=20
> Do not add nodes to the end.
If you mean to say that the nodes are supposed to be in the increasing orde=
r of physical address,
I can see that the existing file is not arranged in that format. If that is=
 required I can first fix the
existing file and post the revised patch for the same.=20
>=20
> Best regards,
> Krzysztof


