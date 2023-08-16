Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383F677DA78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbjHPG2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbjHPG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:28:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039042121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:28:25 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230816062822epoutp038e7d8a2c7b33e610ccfa4642e0a3f468~7yTI-vzaD2489324893epoutp03t
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:28:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230816062822epoutp038e7d8a2c7b33e610ccfa4642e0a3f468~7yTI-vzaD2489324893epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692167302;
        bh=BWy4rMor+4CDFlOcFQoDWcev12bJ4AQFAwvzWnwIiF8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=P1kA4nC4z+yr2ruuB4WFx4y0mxDfPaCuL62GzCfRmgfSkeAcL0bFmfKrREp17y/J9
         8wRjKMd5dL3brK+qqpz/MdoRtyGFzblj3xVElf8j0LXurzMfMaJB0LZBS/X4zvQEvY
         sIj7aNwcwcbAuJ3lF0aonXpQT/Ka95X08ZiwSmqU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230816062822epcas5p20c4ff9b9ca55c20a83aba305be05e859~7yTIlHi0h0105901059epcas5p2d;
        Wed, 16 Aug 2023 06:28:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RQdVp6V79z4x9QC; Wed, 16 Aug
        2023 06:28:18 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.20.06099.28C6CD46; Wed, 16 Aug 2023 15:28:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230816062702epcas5p18b7888ff2ea9c0131b06e4cc1bacb745~7yR98rbZj0308503085epcas5p1o;
        Wed, 16 Aug 2023 06:27:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816062702epsmtrp2d052376e8234548fcebabf10afe6a745~7yR9559Zw1456014560epsmtrp2Q;
        Wed, 16 Aug 2023 06:27:02 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-22-64dc6c82e1c9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.A8.30535.53C6CD46; Wed, 16 Aug 2023 15:27:01 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230816062658epsmtip2bc55b404df6201f92458b09bdb81e8f7~7yR6vvfdw0282002820epsmtip2H;
        Wed, 16 Aug 2023 06:26:58 +0000 (GMT)
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
        "'Jayati Sahu'" <jayati.sahu@samsung.com>
In-Reply-To: <ae1107f7-d48e-d89f-4de9-f8d01abcc3e2@linaro.org>
Subject: RE: [PATCH v3 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date:   Wed, 16 Aug 2023 11:56:57 +0530
Message-ID: <001101d9d00a$aab8d2f0$002a78d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAIauC4WAflUgXwDCBMlgQHspauEr+6uPpA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPbftbZkrKw/lWAey+ohsUqiD7oCDLYhwHRNJ9geJGtkNvRak
        L3tbx5wLhI5MyIYgYYMKBRlhiOsY5f0oI4h1II+ZKRmTOahjVNiQAZLBhNlyQfnv8/ud7+/x
        PSeHx/LM4Qp5qSodpVWRChG+jd38fUBAYJZiTBZ8+WsxWv7zHEDjpmYcXbIOYah0+BQblfcO
        cdCkzc5Fvf1VGPq9cpaD8hwTLGSdaeKi6815HGT5Y4SDJqYT0Y32UhwVD3dhyLRq5iBbxbNo
        6af7AFU2LXLRxFyns8eAg4Wyrb1ctFg/yj3oQzR+O4oRk182cYk2420uUWHRE5baHJwYG+nE
        iYaqDOKvrl9xIq+xFhCNVxcAsZZVxiUWLH4J299L259CkTJK60+pktWyVJU8QhR3JOnNpFBp
        sCRQEob2ifxVpJKKEEUfTgiMSVU4XYv8PyUVemcqgaRpUVDkfq1ar6P8U9S0LkJEaWQKTYhG
        TJNKWq+Si1WULlwSHPx6qFN4NC3FYujiah4K0rtaB/BMUOGeC9x4UBACHcXTHBd7CjoAnMj3
        yAXbnDwP4PTKI4wJlgDsav2Nu1lharoFmAMrgN8N2DaCKQANjavrKlwQBGdqynEXewvusaDJ
        dMzFLMFNAO9URbnYTRAJbU8mgYu9BB/Cx/UGtovZgpfh3xez12v5gjB4rboJY9gD9pXcZTN9
        9sDqb2ZYzEb+cHmymsPMiodts5k4o/GBPyyf2dC0uMG64RiGo+HK7Dhg2AtO/9i44UwIF2at
        OMNy2NDbwGFYAb/IMmz0OQC7fyl17sBz9g+Ade1BTNoXFvVfxpix7vDs47sYk+fDVtMmvwIv
        2HM2eCc02+c5+UBk3OLMuMWZcYsD4//TKgC7FjxHaWilnKJDNXtV1LH/3jtZrbSA9T+xO64V
        2MfnxD0A44EeAHkskTf/DP+WzJMvI49/RmnVSVq9gqJ7QKjzugtYwmeS1c5PpdIlSULCgkOk
        UmlI2F6pROTDn8kuk3kK5KSOSqMoDaXdrMN4bsJMLPLSFCcu8LWRe6c9Dr1a6l3TUHJy8lH6
        51NDV3pCL7QMhn9g7DjyT4/ZN9PXw/36i2+tPOXRFvTAN3fsxE38YGVGbMaNPWdT+k/GgsG+
        OGFR4rWaGaVfJBooDXd0xpjf7Wgx7aqd+0hcGLUznoq9fXQ8Z/pjL7xV7172IPAhqo4A6cq6
        gsJ3uu2H5RLL6ZHctXLxC4Pu2e8nqnovbn+66cli8vnlHRkO2mHOrC+cKCLTv/I6sSOxe+GQ
        3icq//wp8hNjWwcWVvCSzW++pdpgF0j7rpZEW8/J1iRg/HklS2xbugPut7+xz3I80jZVvGvM
        nKVePWBMoH8eLBoeLXr7SrzQIGLTKaRkN0tLk/8C6V68npwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7bCSvK5pzp0Ugx2LLS1+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xWxw5tYTJ4t6id6wWfS8eMlvsfb2V3eLCtj5Wi02Pr7Fa
        PHwVbnF51xw2ixnn9zFZzPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc9QDPOvGC2aN17hN3iy8ab
        7A7iHltW3mTyeNq/ld1j56y77B4LNpV6bFrVyeZx59oeNo/NS+o93u+7yubRt2UVo8eW/Z8Z
        Pf41zWX3+LxJLoAnissmJTUnsyy1SN8ugStj+q1W9oLVAhXvTreyNzDe4u1i5OSQEDCRmLf1
        FiOILSSwm1Fi8UYriLiMxMkHS5ghbGGJlf+es3cxcgHVPGWUWPCxFyzBJqAv8XrFfDaQhIjA
        N2aJR693gDnMAncYJa7OXcIKMXYpk8T2/zIgNqeAncSx/0/B1gkLxEi8vfafHcRmEVCV+Lq8
        lQ3E5hWwlDixbCsThC0ocXLmExYQm1lAW+Lpzadw9rKFr6HOU5D4+XQZ2C4RAT+Jne8a2CBq
        xCWO/uxhnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNz
        NzGC04WW1g7GPas+6B1iZOJgPMQowcGsJMLbw3srRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        t9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmdiXx0wrZF8vWqzh6VFVcuJabdyPBjuFV5invzer/
        +LKO9R+Y6WDQGfU76XYrZ0bCz7NNMV8f8X8MWLtp17zEzZ+51hfETq7OZY1OVOdZpcN2sO5s
        3PXr5xy3tVXH13AWrPjEcrilmO/c/R31E5x0jnI9FPhd1nH2l+bfUBGexM+z6vw22B/5b3T7
        AeebbgkTjv28ekn24e+UOgSOPD3LxzJF59uCdwmhd58Esc8zXzLz2OvAjdzS29Y7ic+JXmif
        tK7i+JFLZ0Q8dm5xv+bhcmhZqfrHr0zav/ZMSe4NDLI/f7TzdIGivKaQ8/zso9e+Kh31nGKr
        5ZGjcynOUDTU7+zaCSLpSa/3SnYEcH5WYinOSDTUYi4qTgQAwX+ZxoYDAAA=
X-CMS-MailID: 20230816062702epcas5p18b7888ff2ea9c0131b06e4cc1bacb745
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037@epcas5p1.samsung.com>
        <20230814112539.70453-5-sriranjani.p@samsung.com>
        <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
        <ae1107f7-d48e-d89f-4de9-f8d01abcc3e2@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 15 August 2023 01:12
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
> kernel=40lists.infradead.org; Jayati Sahu <jayati.sahu=40samsung.com>
> Subject: Re: =5BPATCH v3 4/4=5D arm64: dts: fsd: Add Ethernet support for=
 PERIC
> Block of FSD SoC
>=20
> On 14/08/2023 21:41, Krzysztof Kozlowski wrote:
> > On 14/08/2023 13:25, Sriranjani P wrote:
> >> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
> >> one in
> >> FSYS0 block and other in PERIC block.
> >>
> >> Adds device tree node for Ethernet in PERIC Block and enables the
> >> same for FSD platform.
> >>
> >> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >> Signed-off-by: Jayati Sahu <jayati.sahu=40samsung.com>
> >> Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> >> Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> >> ---
> >>  arch/arm64/boot/dts/tesla/fsd-evb.dts      =7C  9 ++++
> >>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 56
> ++++++++++++++++++++++
> >>  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C 29 +++++++++++
> >>  3 files changed, 94 insertions(+)
> >
> > Looks duplicated.
>=20
> Ah, not, it's another block.
>=20
> My question whether this was tested remains...

I understand your concern. It was tested but just before posting I addresse=
d one of earlier review comment of compatible and I missed to reflect it in=
 all the patches. I will take care.=20

>=20
> Best regards,
> Krzysztof


