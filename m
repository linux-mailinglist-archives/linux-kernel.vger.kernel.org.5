Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00EF77DA52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbjHPGOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbjHPGNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:13:52 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC221BCC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:13:48 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230816061346epoutp01d7cba40a27944559b4c8b437adabd687~7yGZdRwi52032720327epoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:13:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230816061346epoutp01d7cba40a27944559b4c8b437adabd687~7yGZdRwi52032720327epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692166427;
        bh=9zrCgCY0X6xgcTTwYJPyVNxvIDHhohasPCd8QLjMEig=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vOLbRXZmmYzJz0LfR9o/mLspzXRB5P37qds/vzyq56i1Z4XLPg4oYUbYbH/KMo3Rx
         AQDNQotMSyYYF0cKiKhx8jZP1Cmg9Gkv1bPegaUiJDMScbWMUZndpLfhpWrvbWkewr
         MbiAhgXoIBsNfh8eICWbOW3gBzxZnU4N6Q9H8EC8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230816061346epcas5p491603f65d07c5bcc6062de601bbe1065~7yGYxqIh91397813978epcas5p4o;
        Wed, 16 Aug 2023 06:13:46 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RQdB02HVWz4x9QF; Wed, 16 Aug
        2023 06:13:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.35.57354.8196CD46; Wed, 16 Aug 2023 15:13:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230816055809epcas5p23971f3d0cfbf037554cfe950f4bc0d88~7x4wYK1cR0071000710epcas5p20;
        Wed, 16 Aug 2023 05:58:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816055809epsmtrp29724a9f57646fffaf89cb09d68d86ab7~7x4wXH0rR3024530245epsmtrp2G;
        Wed, 16 Aug 2023 05:58:09 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-89-64dc6918f357
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.30.34491.1756CD46; Wed, 16 Aug 2023 14:58:09 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230816055806epsmtip12e8076f9aa7fa80bd23c0161aa9dc4f3~7x4tY_Zkl1117711177epsmtip1m;
        Wed, 16 Aug 2023 05:58:06 +0000 (GMT)
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
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <16eab776-07d4-3c31-7e82-444863303102@linaro.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date:   Wed, 16 Aug 2023 11:28:05 +0530
Message-ID: <000d01d9d006$a211d880$e6358980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKGcKNgAXd78/0Bp/St37AJuAwg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpll+LIzCtJLcpLzFFi42LZdlhTS1ci806KwY7HvBY/X05jtHgwbxub
        xZq955gs5pxvYbGYf+Qcq8XTY4/YLe4tesdq0ffiIbPF3tdb2S0ubOtjtdj0+BqrxcNX4RaX
        d81hs5hxfh+Txby/a1ktji0Qs/h2+g2jxaKtX9gtHn7Yw25x5MwLZovWvUfYLb5svMnuIOax
        ZeVNJo+n/VvZPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uP9vqtsHn1bVjF6bNn/mdHjX9Nc
        do/Pm+QCeKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAHlZSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGec+DqNtWCuacXl2+uYGxiva3YxcnBICJhIPGyP72Lk4hAS2M0o0TfjJwuE84lR
        ou3+IyYI5xujxOuPR4EynGAdjT33oar2MkrMPL6cFcJ5zihx8f9qNpAqNgF9idcr5oPZIgLP
        mCXmzSsHKWIWWM0oseXnYSaQBKeAnUT/1kusILawQKDEvGczwBpYBFQl3rSeYgM5kFfAUuL3
        hhqQMK+AoMTJmU/ArmAW0JZYtvA1M8RFChI/ny5jhdjlJvFn/gtGiBpxiaM/e5hB9koIbOaU
        +HxzC1SDi8SBs8+h3hGWeHV8CzuELSXx+d1eNgg7XWLzkc2sEHaOREdTM1SvvcSBK3NYQG5j
        FtCUWL9LHyIsKzH11DomiL18Er2/nzBBxHkldsyDsdUkFj/qhLJlJNY++sQ6gVFpFpLXZiF5
        bRaSF2YhbFvAyLKKUTK1oDg3PTXZtMAwL7UcHuHJ+bmbGMH5QctlB+ON+f/0DjEycTAeYpTg
        YFYS4e3hvZUixJuSWFmVWpQfX1Sak1p8iNEUGNwTmaVEk/OBGSqvJN7QxNLAxMzMzMTS2MxQ
        SZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamPtMfv168Mj9vbbB7WrO4ltW7ZeZeCkFdN9oW
        zy1TZGQVujhzitG54Lvv6za+CSuLvCcS/DDxleqt84HcTlnnSuKSbbNNjp1inZo2wendflXH
        ig6361JuQbIqu2VnHTuUZ3vx8uG0yUvOS65cuZVZ9cD5vqUnEjdUb1KLWxnkFLp1cbyjTbRF
        dWbFycUtPvn2Kvz6SzdumjpFYOH7eU0Wk26LS2ldUip7a9ylo+cur3/7O8ONDTXRojOexj46
        oc14Jv/0r1+LomJLpDvKlni1CvHlebtvPBB2WWLdyeerEqZW70qcnlPENavT908DW8Tfb/Wu
        Fv65xmL7L6ZxKG463b0o/vWfw+otJV/lQpuUWIozEg21mIuKEwG72kN/mAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCSnG5h6p0Ug20fxSx+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xW9xb9I7Vou/FQ2aLva+3sltc2NbHarHp8TVWi4evwi0u
        75rDZjHj/D4mi3l/17JaHFsgZvHt9BtGi0Vbv7BbPPywh93iyJkXzBate4+wW3zZeJPdQcxj
        y8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPO5c28PmsXlJvcf7fVfZPPq2rGL02LL/M6PHv6a5
        7B6fN8kF8ERx2aSk5mSWpRbp2yVwZZy8dYS1YJZJxcHXHcwNjJc0uhg5OSQETCQae+6zdDFy
        cQgJ7GaUuDD7LDNEQkbi5IMlULawxMp/z9khip4ySizcvpwJJMEmoC/xesV8NpCEiMA3ZolH
        r3ewgSSYBdYzSlzv84Ho+MwocXAnRAengJ1E/9ZLrCC2sIC/xLodU8EaWARUJd60ngKyOTh4
        BSwlfm+oAQnzCghKnJz5hAViprbE05tP4exlC19DXacg8fPpMrCRIgJuEn/mv2CEqBGXOPqz
        h3kCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECE4S
        Wpo7GLev+qB3iJGJg/EQowQHs5IIbw/vrRQh3pTEyqrUovz4otKc1OJDjNIcLErivOIvelOE
        BNITS1KzU1MLUotgskwcnFINTMsv6juUFYtMYPsbcfy2plza67lavHzdCn8/HV+fV7GgsdLP
        YumxhDNrf02SPqZ8/2TCuekzF4Zahb6LcnDUvbR9lnVyyi8xj4md4QoVEm8u6je+2aT3rHjS
        vDta4v0bqucLn6h7diLR9Ps1Lp6JK5iz1Sf2fj42ofwDv+r3u+4i2+/9Z1z7dmLVvH5Zl0sv
        Li/iMQ14qSe0/3uCyzPlR8KBf9Xc5uWd+X/a3/LQpw1/f125arKOV7FvWmbbFAVTM6NVSQub
        kl8G1y2dUai6RKDRdS3Hw/576+8nVsepSDW+vrJZ0StkWcqnxUJsB3g/ZLPNXLNj6qGssAts
        na5TCnSuPqieJ3T7WeUq6dLnfH1KLMUZiYZazEXFiQAgFY5cgQMAAA==
X-CMS-MailID: 20230816055809epcas5p23971f3d0cfbf037554cfe950f4bc0d88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
        <20230814112539.70453-2-sriranjani.p@samsung.com>
        <16eab776-07d4-3c31-7e82-444863303102@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 15 August 2023 01:10
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
> kernel=40lists.infradead.org
> Subject: Re: =5BPATCH v3 1/4=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On 14/08/2023 13:25, Sriranjani P wrote:
> > Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> > Ethernet YAML schema to enable the DT validation.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Ravi Patel <ravi.patel=40samsung.com>
> > Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   =7C   5 +-
> >  .../devicetree/bindings/net/tesla,ethqos.yaml =7C 114
> > ++++++++++++++++++
> >  2 files changed, 117 insertions(+), 2 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..0ced7901e644 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > =40=40 -96,6 +96,7 =40=40 properties:
> >          - snps,dwxgmac
> >          - snps,dwxgmac-2.10
> >          - starfive,jh7110-dwmac
> > +        - tesla,fsd-ethqos-4.21
>=20
> I don't think one given SoC - and I was told FSD is strictly defined one =
specific
> SoC - can have different versions of the same block, so drop the block
> versioning.
>=20

Ok, will remove versioning.

> >
> >    reg:
> >      minItems: 1
> > =40=40 -117,7 +118,7 =40=40 properties:
> >
> >    clocks:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 10
> >      additionalItems: true
> >      items:
> >        - description: GMAC main clock
> > =40=40 -129,7 +130,7 =40=40 properties:
> >
> >    clock-names:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 10
> >      additionalItems: true
> >      contains:
> >        enum:
> > diff --git a/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> > b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> > new file mode 100644
> > index 000000000000..b78829246364
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> > =40=40 -0,0 +1,114 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3D0d5f9085-6cd485b3-0d5e1bca-
> 74fe
> > +485cbff1-9835d59b137d73e5&q=3D1&e=3D93f28da2-6d86-4cc2-a07a-
> 9be1380616cc&
> >
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fnet%2Ftesla%2Cethqos.
> yaml%2
> > +3
> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3D67d3522a-0658471c-67d2d965-
> 74fe
> > +485cbff1-b9570dbbedf33f81&q=3D1&e=3D93f28da2-6d86-4cc2-a07a-
> 9be1380616cc&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: FSD Ethernet Quality of Service
> > +
> > +maintainers:
> > +  - Sriranjani P <sriranjani.p=40samsung.com>
> > +  - Swathi K S <swathi.ks=40samsung.com>
> > +
> > +description:
> > +  dwmmac based tesla ethernet devices which support Gigabit
> > +  ethernet.
> > +
> > +allOf:
> > +  - =24ref: snps,dwmac.yaml=23
> > +
> > +properties:
> > +  compatible:
> > +    const: tesla,fsd-ethqos-4.21.yaml
>=20
> ?

Will fix this to tesla,fsd-ethqos.yaml=20

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 5
>=20
> Why? I expect it to be specific.

Sorry, I could not understood this comment. In FSD we have two instances of=
 EQoS IP, one in PERIC block, which requires total 10 clocks  to be configu=
red and another instance exist in FSYS0 block which needs 5 clocks to be co=
nfigured, so we kept minItems as 5 and maxItems as 10, but looks like lates=
t items schema do not need maxItems entry so we will drop maxItems entry. I=
n my understanding minItems still required so it should be kept with minimu=
m number of clock requirements.

>=20
> > +    maxItems: 10
> > +
> > +  clock-names:
> > +    minItems: 5
> > +    maxItems: 10
> > +    items:
> > +      - const: ptp_ref
> > +      - const: master_bus
> > +      - const: slave_bus
> > +      - const: tx
> > +      - const: rx
> > +      - const: master2_bus
> > +      - const: slave2_bus
> > +      - const: eqos_rxclk_mux
> > +      - const: eqos_phyrxclk
> > +      - const: dout_peric_rgmii_clk
> > +
> > +  fsd-rx-clock-skew:
> > +    =24ref: /schemas/types.yaml=23/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to the syscon node
> > +          - description: offset of the control register
> > +    description:
> > +      Should be phandle/offset pair. The phandle to the syscon node.
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  phy-mode:
> > +    =24ref: ethernet-controller.yaml=23/properties/phy-connection-type
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - rx-clock-skew
>=20
> Eee? Isn't it fsd-rx-clock-skew which anyway is not correct?

Sorry, I missed to change this in DT schema before posting, I will make thi=
s to fsd-rx-clock-skew.=20

>=20
> > +  - iommus
> > +  - phy-mode
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/fsd-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    ethernet_1: ethernet=4014300000 =7B
> > +              compatible =3D =22tesla,dwc-qos-ethernet-4.21=22;
>=20
> Three different compatibles for the same.
>=20
> No, please test your patches before sending.
>=20
> I am not even checking if previous feedback was applied... Did you really=
 go
> through it?
>=20

Sorry, I missed this will take care.=20

> Best regards,
> Krzysztof


