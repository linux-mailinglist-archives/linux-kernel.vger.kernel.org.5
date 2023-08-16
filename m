Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4808777D9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjHPFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbjHPFil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:38:41 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0083
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:38:39 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230816053836epoutp043ceb8147752322782d1b186f0b5ecfb1~7xnrxqMO92888028880epoutp04Q
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:38:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230816053836epoutp043ceb8147752322782d1b186f0b5ecfb1~7xnrxqMO92888028880epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692164316;
        bh=iC6z9KTXhMJJKJAifkpiD2z5zC2PU00ngNvG/1pLNSw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pdRZ5MH0EHqmC5hl/CwwfXoh1ZuOmeuP7KjqlWltQlpObqe/P70IYNuyw/Apvp3wH
         HTooaRUEHu+OozaXddruLvN/IPW5EXkqrW0MkVMDCknMI5M67SGp6do5Ei+iXdBdFL
         2QZJ7yCbyO1DsJCPSuxXpSVMoeMGSwVAiMdKCB2A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230816053835epcas5p1324b989bf7fcb196862235201026e106~7xnq1lHHq1702017020epcas5p1t;
        Wed, 16 Aug 2023 05:38:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RQcPP3XCBz4x9Q9; Wed, 16 Aug
        2023 05:38:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.54.06099.9D06CD46; Wed, 16 Aug 2023 14:38:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230816053710epcas5p498d626cac93ea679af6003942f1504f3~7xmb1vekg3098830988epcas5p4B;
        Wed, 16 Aug 2023 05:37:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816053710epsmtrp2776b05489f5d58352912df9d1c091dad~7xmb0k_RR1948119481epsmtrp2K;
        Wed, 16 Aug 2023 05:37:10 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-bd-64dc60d96338
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.1F.34491.6806CD46; Wed, 16 Aug 2023 14:37:10 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230816053707epsmtip23fb655503682b58fb08b19fd8c01e993~7xmY46zVo3213332133epsmtip2j;
        Wed, 16 Aug 2023 05:37:07 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
        <alexandre.torgue@foss.st.com>, <ravi.patel@samsung.com>,
        <alim.akhtar@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <linux-fsd@tesla.com>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <pankaj.dubey@samsung.com>, <richardcochran@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <joabreu@synopsys.com>,
        <devicetree@vger.kernel.org>, <davem@davemloft.net>,
        <swathi.ks@samsung.com>
In-Reply-To: <169201998303.2086680.8457687937999615543.robh@kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date:   Wed, 16 Aug 2023 11:06:51 +0530
Message-ID: <000001d9d003$b3a9a8a0$1afcf9e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKGcKNgAXd78/0BAMIwYrAO8GWg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpll+LIzCtJLcpLzFFi42LZdlhTQ/dmwp0Ug2s3RSx+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xW9xb9I7Vou/FQ2aLC9v6WC02Pb7GavHwVbjF5V1z2Cxm
        nN/HZDHv71pWi2MLxCy+nX7DaLFo6xd2i4cf9rBbHDnzgtmide8Rdov/e3awW3zZeJPdQcxj
        y8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPO5c28PmsXlJvcf7fVfZPPq2rGL02LL/M6PHv6a5
        7B6fN8kF8ERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAPaykUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM442LeYqeCBXMWf878ZGxgvSHUxcnJICJhIvFw/lamLkYtDSGA3o8TsXW9ZIJxP
        jBJT722GynxjlPi8eh0LTMubHavZIBJ7GSX2XtzDCuE8Z5S4N3cHM0gVm4C+xOsV89lAbBEB
        VYmmWQ/A5jILXGaR+Hh1FStIglPAXWLJ7AdMILawQKDEvGczgBo4OFiAGnrOe4KEeQUsJVau
        7WGFsAUlTs58AnYFs4C2xLKFr5khLlKQ+Pl0GSvELjeJLXseMUPUiEsc/dnDDLJXQmA1p8SJ
        M5PB5ksIuEjMOCEN0Sss8er4FnYIW0ri87u9bBB2usTmI5tZIewciY6mZqhd9hIHrsxhARnD
        LKApsX6XPkRYVmLqqXVMEGv5JHp/P2GCiPNK7JgHY6tJLH7UCWXLSKx99Il1AqPSLCSfzULy
        2SwkH8xC2LaAkWUVo2RqQXFuemqxaYFxXmo5PMKT83M3MYLzg5b3DsZHDz7oHWJk4mA8xCjB
        wawkwtvDeytFiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJJucDM1ReSbyhiaWBiZmZmYmlsZmh
        kjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1M3NyF3TLF5i4Fl6epv2vYFxX/bcnqJA2FW/+O
        BwdyauvM81j3VfpnrXXMqynCn5qMNk/awqIdFpxjN/upgr+p6tdtxgLmZXHcZ9541kalTVWR
        K3Iv2ORy4MAf/acOkWyHlVwP7de91OXfkeSaFby6P/0j/6726SorTDTTq4tbdZ+erJYpqJtW
        tswzub6n584zK7/lVn5KAvXyuWxbtXz/eT9xWrtpx3p21WTxv/eLj1RMOboq+UBid7BvoOGV
        mz7rE0TORfA1rz3M06Mv9s6gPOP37aAE2S5Fjr98Uspf6lKbtNY/sZfwfSRdezSgfadNiY3b
        Fa07c3ad5T0cuvj+WrkbS18nb//zoV5ziRJLcUaioRZzUXEiABX7bpyYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVDLcRzHffd7XGd3v1anb6Uw4uQqw/EtDueOfpwJ6XSOmPa7ldrMZhjn
        uMIpk86zyUq6HkaOn5ZowprOc3na3VxYaSmRPNuRhxqu/973eb9f78/njw+NibvxEDpdvZ7T
        quWZEtIPr66XDIvatapZMb72VxDydh4GyG2uJtGZK/cFqKBxB44KHfcJ5GlopdDz4m4C5XW0
        YKipOo9A/EsngVpeL0WPLheQ6GhjnQCZeysJ1FA0BH258wagYusnCrX02CjkuNuBoZ1XHBT6
        Zauh0KfzLmrmELaqwiVgPfusFHvJ9Ixii3g9y1tySLbZaSPZCyXb2Hd1T0g2r8oC2KqrHwH7
        M+sExX7kwxcOXuY3TcFlpm/gtDHTV/mlmUt5XNMctmmvzY5tBzeDc4GQhswk+KbmNJkL/Ggx
        Uwugqb6d9BlD4S13CebTAbDi5yvKF/IAaDR24X0GycTArvLCfiCQiYBZJjfeF8KYThx+/V6G
        +YgfADblfBD0pYRMPCw57u7XAUwCPFtz6A9N0/gf2tg4t28sYmJhRaWR8Gl/eOtYW/8yjBkH
        PS7Pf116suvvdcOh11NK+I6YA6tsrZgvEwRveI1YPggwDagyDagyDagyDUCKAG4BwZxGp1Kq
        dFKNVM1tjNbJVTq9WhmdulbFg/6XiBxbAy5aeqLtQEADO4A0JgkUGUVPFWKRQm7YzGnXrtTq
        MzmdHYTSuCRIFNSxVyFmlPL1XAbHaTjtP1dAC0O2Cwwz4zVT8bz4yTvEPeuchjY61Dpyxf4F
        sq2z69cUh6QaCJXee+pFU9ysjms62Zyt7yWybJx/bo1yIIehPGx5z5gL7S6Dxf+wc5b+1fvQ
        PdfLzlq0EURyLRocVRC7+MykO11q6cYvMfqGea/JcdhSq7rSLLyYmr2o6cPDGRntaxJRivPE
        qOZdcbvx7Jedox8G9p5LWrKaPkYFhnn3TeFDvt3rLdeQD2Ilabmr42KPJt9u/zye25w0IaWu
        m0cZxBRSFp7U6z9Zw7Tac1Kmm/KFyrbd7HFplCwhoyLRNULz4F7iBqWhbv6RdSD/yCAq/PHp
        qa6JB3LMo9x41sG3UtsWCa5Lk0sjMa1O/hsJNrQTgQMAAA==
X-CMS-MailID: 20230816053710epcas5p498d626cac93ea679af6003942f1504f3
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
        <169201998303.2086680.8457687937999615543.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring =5Bmailto:robh=40kernel.org=5D
> Sent: 14 August 2023 19:03
> To: Sriranjani P <sriranjani.p=40samsung.com>
> Cc: edumazet=40google.com; linux-kernel=40vger.kernel.org;
> alexandre.torgue=40foss.st.com; ravi.patel=40samsung.com;
> alim.akhtar=40samsung.com; linux-samsung-soc=40vger.kernel.org; linux-
> fsd=40tesla.com; conor+dt=40kernel.org; mcoquelin.stm32=40gmail.com;
> kuba=40kernel.org; netdev=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; pabeni=40redhat.com; robh+dt=40kernel.org;
> pankaj.dubey=40samsung.com; richardcochran=40gmail.com;
> krzysztof.kozlowski+dt=40linaro.org; joabreu=40synopsys.com;
> devicetree=40vger.kernel.org; davem=40davemloft.net;
> swathi.ks=40samsung.com
> Subject: Re: =5BPATCH v3 1/4=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
>=20
> On Mon, 14 Aug 2023 16:55:36 +0530, Sriranjani P wrote:
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
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/net/tesla,ethqos.yaml:
> properties:clock-names: =7B'minItems': 5, 'maxItems': 10, 'items': =5B=7B=
'const':
> 'ptp_ref'=7D, =7B'const': 'master_bus'=7D, =7B'const': 'slave_bus'=7D, =
=7B'const': 'tx'=7D, =7B'const':
> 'rx'=7D, =7B'const': 'master2_bus'=7D, =7B'const': 'slave2_bus'=7D, =7B'c=
onst':
> 'eqos_rxclk_mux'=7D, =7B'const': 'eqos_phyrxclk'=7D, =7B'const':
> 'dout_peric_rgmii_clk'=7D=5D=7D should not be valid under =7B'required': =
=5B'maxItems'=5D=7D
> 	hint: =22maxItems=22 is not needed with an =22items=22 list
> 	from schema =24id: https://protect2.fireeye.com/v1/url?k=3Df50e335d-
> aa950a44-f50fb812-000babff3793-de26ea17ef025418&q=3D1&e=3D897786e4-
> 5f9b-40d8-8a7f-399cb69c7ee8&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-
> schemas%2Fitems.yaml%23
> Documentation/devicetree/bindings/net/tesla,ethqos.example.dtb:
> /example-0/ethernet=4014300000: failed to match any schema with
> compatible: =5B'tesla,dwc-qos-ethernet-4.21'=5D
>=20

Thanks for review. Will fix this in v4.

> doc reference errors (make refcheckdocs):
>=20
> See https://protect2.fireeye.com/v1/url?k=3Dccb7f6d0-932ccfc9-ccb67d9f-
> 000babff3793-2137ac63fe6ddef8&q=3D1&e=3D897786e4-5f9b-40d8-8a7f-
> 399cb69c7ee8&u=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fdev
> icetree-bindings%2Fpatch%2F20230814112539.70453-2-
> sriranjani.p%40samsung.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20

Sorry, I could not get this comment, can you elaborate this.=20

> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
Sure will cross check.

> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.


