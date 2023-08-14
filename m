Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6D77B874
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjHNMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjHNMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:14:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09090D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:14:03 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230814121401epoutp0414600936fb423b5f7d66860398ffcd48~7PuXBVgAd1473114731epoutp04Y
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:14:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230814121401epoutp0414600936fb423b5f7d66860398ffcd48~7PuXBVgAd1473114731epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015241;
        bh=xyVnog2jLedt14D6/THImFoemM70QCVX01i5t6rzCMg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oFSgT4+q5yp8TbP4QmFCpPhnX8C0I4GtNfuiaZC0Um+o60gElZbW83+raZsd389TU
         5EEZTUwNvqY6bTf3YVaTU/rwhXycmcJM1tIt7+q7HTcSLzWxHqHnqefJwDao1oxZgp
         se6gmGTNh81+GX2VsV1TJvJZAeB+/7EiIy4JoyWQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230814121400epcas5p167b713d95d692ca9a85155c00fd29796~7PuWbYfMJ0558505585epcas5p1d;
        Mon, 14 Aug 2023 12:14:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RPYGb1R7Qz4x9Pp; Mon, 14 Aug
        2023 12:13:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.FF.44250.78A1AD46; Mon, 14 Aug 2023 21:13:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230814101856epcas5p258bdde8064b8796f512d694dd84479e2~7OJ4dlEYZ2119221192epcas5p2T;
        Mon, 14 Aug 2023 10:18:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230814101856epsmtrp27552a66ecbc4b8b2bab0664475c73582~7OJ4cb1HG0861708617epsmtrp23;
        Mon, 14 Aug 2023 10:18:56 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-23-64da1a8761c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.E1.30535.09FF9D46; Mon, 14 Aug 2023 19:18:56 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814101853epsmtip1485ac2ebfee8abec66117b25d30e6253~7OJ1rJAdB2787827878epsmtip1D;
        Mon, 14 Aug 2023 10:18:53 +0000 (GMT)
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
In-Reply-To: <2590a514-81f7-1876-c43b-80c8abe40cf9@linaro.org>
Subject: RE: [PATCH v2 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date:   Mon, 14 Aug 2023 15:48:44 +0530
Message-ID: <000001d9ce98$bbaedb90$330c92b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQGL0eLTHe4L9QyPOdGPE73PwLZVZAJJY+tAAlLq9WAA4UOvEbBZlhdw
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGc3r7BaTjCmwccCN4yYgDgZYBO0xAwhhcmC4kZsk2dVDptQVK
        2/SDsRnNAiwbuLItyHTlq6IQRCtfLSLQuUHBCcai21AQFciaMcqXhU2Zkll6i/Lf733zvPd5
        n3PO5WI+q+xAbp5MTSllQinB9mR2D+4Li7gQOCnit17noPWH1wCaru9mo1prGRM1WL5nIdvw
        LAdZRj5hoN8al1iocm4GQ2a7iYPGuitZ6E5vLRvVbxhYaFi/Cz0eXQCo0bTGQU/tJoBmVvo5
        6LzZwkFrHROcZF/S+OkEg7RdNnHIr3S/ckh9p4bsbC1nk1Pj/Wxy+cY9NllpbAWk7S8zRhq/
        XgXkamdQltfJggQJJRRRymBKlisX5cnEicSRV7MPZcfG8QURgnh0gAiWCQupRCL15ayItDyp
        Mx4RXCSUapytLKFKRUQlJSjlGjUVLJGr1IkEpRBJFTGKSJWwUKWRiSNllPqggM+PjnUKcwok
        U5OJiifhxVbje9g5sB5SATy4EI+B+rl2UAE8uT54H4DV5h9YdOEA8I5Zz6SLxwCWVC9wtkYu
        fuZwj5gB1E5UuosHAM4ZbrA3VWw8CtpbGlzshw8z4IP11zZFGP4IQPO03vUpDzwJOq4OMjfZ
        Fz8FP9SvupiJ74WTlQ7XMA+Ph83To0yan4HfXr/vYgwPh80f2TF6pWC4bmtm0X1/OLR+CaON
        0+DPXVUMWvOBB6wYO0NzKizTaVk0+8L5b4zuaIFwdcnMplkMuyxdbo0UXiwpdXu9BG/erXXu
        wHV67YNtvVF0ew+sHvmCQa+wA2r/vu+25cGe+i0OhR/Plrt5NzTMOlhXAKHblky3LZluWxrd
        /256wGwFAZRCVSimVLGKaBl1+r8Lz5UXdgLX6w/L7AEz0yuRA4DBBQMAcjHCj3eJNyny4YmE
        Z85SSnm2UiOlVAMg1nncV7HAnbly5+8jU2cLYuL5MXFxcTHx++MEhD/Pfr5O5IOLhWqqgKIU
        lHJrjsH1CDzH0Bb/mPL57XB2bMvaIy2WntJS1HG7h69Rpj7/5I8lwdF7ddRb8cnCXQHf7QjY
        c/PKhndIWRI3g2TMHyFeeLvq1vzRtmO93CGv38dGj9cv2BjWp1H1VaaZy7ujtdUZr//5jyVj
        uVyS1hbU35dR8+bQ4tShzJwc3FG3WJPULM5PKTl2+NnxmsURq5YzHpSQ3iHOVqKBmbL8AF7y
        Q+bK3hMXiqZ2vmjB2kv3hxy4Jfd+Tk4uvFIMD/o25XtKj28sO9YEpakGw7WuU1NKv9GaOfX4
        lyYUmmk1zHojUvrG4t2GJqukyYj65s+Gtne9+86JhWZ/r0H72PtRv5xMP/3U1qipzPiJYKok
        QkEYplQJ/wXAlgUfhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nued5rhyPu4uvH2sc2oRLxnxJLW14yPwczW9X9+wuuuRO
        hGx+NQlX2EwnXU4uXUinbugqznVWbmRNq1yUdavbRSQmi6w7tv577fP+sfcfHxoXuohJdGLy
        QU6dLEuSkAGE5bkkeG7OUIt8Xv+D6WjAcxWg9nwLifJenyGQ3v6Kh9yOjxSy1xdi6L3hMw9p
        uztwVOWtoFCDRctDjU/ySJT/+x4POQrGox8vewAyVPRTaMhbAVDHFyuFMqrsFOova6GiRWx5
        cQvGurMrKPaxro1iC8yprNl0jmRdTVaS7a1+S7LachNg3T+rcLa85htgv5mD1wduC1gq55IS
        D3HqsKg9AcrTn9JSzKFpg3fbwQlQJskCfBoyC2BmSR/IAgG0kKkE0NR8g/QLU2BdeyHuZxEs
        /tNF+U1uALuLisCwQDJh0HtH7wuImQYMGr5GDJtw5jeAV6tLCH/iO4CDrhps2MVnomDfpefE
        MIuYHdB155KPCWYmbNX2+ZoEzGJobH9J+HkcrMvt9DHOzIYXOzLAfzbe9P6bNxUOuI08/30C
        rB24gPsXrYDND69gOUCkG1GlG1GlG1GlGxEvAIQJTORSNCqFShOeMj+ZOyzVyFSa1GSFNGG/
        ygx8DxAa+ghYTV+kNoDRwAYgjUvEgtaVTXKhQC47cpRT79+tTk3iNDYwmSYkEwQ/vBflQkYh
        O8jt47gUTv1fxWj+pBOYoGaNNC1+Tlix3vniepl+yrHIiW19acqoXM84o3WZ6xa/vsjQk/1k
        bProDUHRxy29cU/jKPK9I9jDD96siLjNxOi144uiAy878AjxHltH96l3rmshSm9sXWzutRjD
        T0Vp+s4Zub/GxkXbuxtOakSmFQ2vntFOz+qhWWu33MpfVG/sKqFbYtak5yy7Z195vzHyV1Dt
        Ktex8tbqBX8s2887Rw/GsWffuBM8QWMCFZmjBgwhPU21kQ4xOPuhUuoEb3eVbmhOaFuyrtTW
        tDF+6xxxRqc+flpe5nJD5HUhb6cYazWq7h6hrSHrG+ceyIKF3k2xlQt7Obtyr77y/jMvt8Up
        ITRKWXgortbI/gL0QwPkbwMAAA==
X-CMS-MailID: 20230814101856epcas5p258bdde8064b8796f512d694dd84479e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230111075450epcas5p3f13b94bfeaa66d386aa51f87ca4ec5bf
References: <20230111075422.107173-1-sriranjani.p@samsung.com>
        <CGME20230111075450epcas5p3f13b94bfeaa66d386aa51f87ca4ec5bf@epcas5p3.samsung.com>
        <20230111075422.107173-4-sriranjani.p@samsung.com>
        <2590a514-81f7-1876-c43b-80c8abe40cf9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 12 January 2023 15:05
> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> alexandre.torgue=40foss.st.com; peppe.cavallaro=40st.com;
> joabreu=40synopsys.com; mcoquelin.stm32=40gmail.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; pankaj.dubey=40samsung.com;
> alim.akhtar=40samsung.com; ravi.patel=40samsung.com; Jayati Sahu
> <jayati.sahu=40samsung.com>
> Subject: Re: =5BPATCH v2 3/4=5D arm64: dts: fsd: Add Ethernet support for=
 FSYS0
> Block of FSD SoC
>=20
> On 11/01/2023 08:54, Sriranjani P wrote:
> > The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
> > one in FSYS0 block and other in PERIC block.
> >
> > Adds device tree node for Ethernet in FSYS0 Block and enables the same
> > for FSD platform.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Jayati Sahu <jayati.sahu=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts      =7C  9 ++++
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 56
> ++++++++++++++++++++++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C 22 +++++++++
> >  3 files changed, 87 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index 1db6ddf03f01..ca0c1a28d562 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > =40=40 -30,6 +30,15 =40=40
> >  	=7D;
> >  =7D;
> >
> > +&ethernet_0 =7B
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
> > index d0abb9aa0e9e..7ccc0738a149 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > =40=40 -64,6 +64,62 =40=40
> >  		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
> >  		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
> >  	=7D;
> > +
> > +		eth0_tx_clk: eth0-tx-clk-pins =7B
>=20
> Wrong indentation.
Will fix in the next version.
>=20
> > +		samsung,pins =3D =22gpf0-0=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_DOWN>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_tx_data: eth0-tx-data-pins =7B
> > +		samsung,pins =3D =22gpf0-1=22, =22gpf0-2=22, =22gpf0-3=22, =22gpf0-4=
=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_tx_ctrl: eth0-tx-ctrl-pins =7B
> > +		samsung,pins =3D =22gpf0-5=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_phy_intr: eth0-phy-intr-pins =7B
> > +		samsung,pins =3D =22gpf0-6=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> > +	=7D;
> > +
> > +	eth0_rx_clk: eth0-rx-clk-pins =7B
> > +		samsung,pins =3D =22gpf1-0=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_rx_data: eth0-rx-data-pins =7B
> > +		samsung,pins =3D =22gpf1-1=22, =22gpf1-2=22, =22gpf1-3=22, =22gpf1-4=
=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_rx_ctrl: eth0-rx-ctrl-pins =7B
> > +		samsung,pins =3D =22gpf1-5=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV6>;
> > +	=7D;
> > +
> > +	eth0_mdio: eth0-mdio-pins =7B
> > +		samsung,pins =3D =22gpf1-6=22, =22gpf1-7=22;
> > +		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> > +		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> > +	=7D;
> >  =7D;
> >
> >  &pinctrl_peric =7B
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index f35bc5a288c2..ade707cc646b 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > =40=40 -32,6 +32,7 =40=40
> >  		spi0 =3D &spi_0;
> >  		spi1 =3D &spi_1;
> >  		spi2 =3D &spi_2;
> > +		eth0 =3D &ethernet_0;
>=20
> This is a friendly reminder during the review process.
>=20
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all reques=
ted
> changes or keep discussing them.
Sorry somehow I'm not able to find my previous mail chain.
I had replied to your comment in the previous version of the mail.
In this case alias id is used to differentiate between Ethernet instance 0 =
and 1 in the driver code.
>=20
> Thank you.
>=20
>=20
> Best regards,
> Krzysztof


