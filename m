Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0607977DA97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjHPGlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbjHPGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:41:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EA1FD0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:41:36 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230816064134epoutp0310a198f0d8a651efc25da2be3c92d8fd~7yeqrjWUW0385403854epoutp03h
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:41:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230816064134epoutp0310a198f0d8a651efc25da2be3c92d8fd~7yeqrjWUW0385403854epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692168094;
        bh=SOhYZsDP2Lg0eVQL9xjGQnNiIfQ6hpZwMVNw/iZqBg4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tT1MYiMGsTuGJMJQM2t6fvNSS/0iyL4NjrwBdva+NDQ6eHQa3sE2t+NDdSjerXwlr
         SZU62AqmscRqDNz3IUzMWD/4jUc0bIC2/yc6Y9bilIv8sJh38StM4iWz4YSghEhhou
         9v1tHWfOBryF3uFa49ucLWh361CBemAfnSckm9Pg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230816064134epcas5p17ea935f22f2ccd47bdc8ab425a6504aa~7yeqFaN641088310883epcas5p18;
        Wed, 16 Aug 2023 06:41:34 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RQdp40wSZz4x9Q1; Wed, 16 Aug
        2023 06:41:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.0E.55522.B9F6CD46; Wed, 16 Aug 2023 15:41:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230816064031epcas5p161bf015960cb5d4031eaf9bac1d3541c~7ydv2ILrz0916809168epcas5p1W;
        Wed, 16 Aug 2023 06:40:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816064031epsmtrp220fa0fa8607e054aafdcaabfe278805e~7ydv07QNT2285722857epsmtrp2z;
        Wed, 16 Aug 2023 06:40:31 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-0d-64dc6f9b5a8c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.FB.64355.F5F6CD46; Wed, 16 Aug 2023 15:40:31 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230816064028epsmtip2fc43110ce47b75a5a6a0622e8087e4b7~7ydso76CJ0449704497epsmtip2T;
        Wed, 16 Aug 2023 06:40:27 +0000 (GMT)
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
In-Reply-To: <b3cd8115-b2bd-63dd-01d3-3cd27127d534@linaro.org>
Subject: RE: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date:   Wed, 16 Aug 2023 12:10:26 +0530
Message-ID: <001301d9d00c$8d427cb0$a7c77610$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKuNFnTAVxbNBUDmCxvSq/54n2w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupil+LIzCtJLcpLzFFi42LZdlhTQ3d2/p0UgwvTrSx+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xWxw5tYTJ4t6id6wWfS8eMlvsfb2V3eLCtj5Wi02Pr7Fa
        PHwVbnF51xw2ixnn9zFZzPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc9QDPOvGC2aN17hN3iy8ab
        7A7iHltW3mTyeNq/ld1j56y77B4LNpV6bFrVyeZx59oeNo/NS+o93u+7yubRt2UVo8eW/Z8Z
        Pf41zWX3+LxJLoAnKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+hrJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
        aomVoYGBkSlQYUJ2xqojb5kKPvJVnN75k72BcSlPFyMnh4SAicT0uTeZuhi5OIQEdjNKXJ86
        gx3C+cQo8XzxOzY45+CHXewwLeev/2eBSOxklFg+eSaU85xR4u7qHlaQKjYBfYnXK+azgdgi
        As+YJebNKwexmQVuMErcX+IEYnMK2EmsfzgNqJ6DQ1ggTmLZPB+QMIuAqkRHwxOwMbwClhJP
        lixng7AFJU7OfMICMUZeYvvbOcwQBylI/Hy6jBVilZvE655PzBA14hJHf/Ywg9wmIbCdU2L5
        +vVQH7hInHixA8oWlnh1fAuULSXx+d1eNgg7XWLzkc2sEHaOREdTM9Qye4kDV+awgNzMLKAp
        sX6XPkRYVmLqqXVMEHv5JHp/P2GCiPNK7JgHY6tJLH7UCWXLSKx99Il1AqPSLCSvzULy2iwk
        L8xC2LaAkWUVo2RqQXFuemqxaYFhXmo5PMKT83M3MYIzhZbnDsa7Dz7oHWJk4mA8xCjBwawk
        wtvDeytFiDclsbIqtSg/vqg0J7X4EKMpMLwnMkuJJucDc1VeSbyhiaWBiZmZmYmlsZmhkjjv
        69a5KUIC6YklqdmpqQWpRTB9TBycUg1MNpMnPFePjJypfW7xgdknW2cGTw8NeOMp0L3oZ7+r
        kvKFLYmbNxQse7bPTydT7uD1xbIqib+dq7deLdcPmxYb0SU/W1O2Rvvibt0bPt8D6j+Wdbse
        3R7Fx2s9w+Tb6anLgq573yyeeOdAuuem+g8atjuPq744OIXZTf3yi489BxTPqmQEvGQPrrl5
        c2te1Valzy/PmOtNNkp1ijf9UOO9QHN1aFdS2495yffzGParsWxxEO00tzH6crRevfLnd68/
        BoI/XK+5ddvPfLj/0+0D35J756qcKw/3cK43uamRI2/pdCrUT0v42PMpGyRvf42wUpTvD3x9
        f9P+k70m5rvkLj+Lebkl4ZL6E6W5t5WNlFiKMxINtZiLihMBf1N+8J0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSvG58/p0Ug0dfJCx+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xWxw5tYTJ4t6id6wWfS8eMlvsfb2V3eLCtj5Wi02Pr7Fa
        PHwVbnF51xw2ixnn9zFZzPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc9QDPOvGC2aN17hN3iy8ab
        7A7iHltW3mTyeNq/ld1j56y77B4LNpV6bFrVyeZx59oeNo/NS+o93u+7yubRt2UVo8eW/Z8Z
        Pf41zWX3+LxJLoAnissmJTUnsyy1SN8ugStj1ZG3TAUf+SpO7/zJ3sC4lKeLkZNDQsBE4vz1
        /yxdjFwcQgLbGSVutc5lhkjISJx8sATKFpZY+e85O0TRU0aJPS8vs4Mk2AT0JV6vmM8GkhAR
        +MYs8ej1DjCHWeAOo8TVuUtYIVo+M0rsOv6LBaSFU8BOYv3DaawgtrBAjETP/yZGEJtFQFWi
        o+EJWJxXwFLiyZLlbBC2oMTJmU/AepkFtCWe3nwKZctLbH87B+o+BYmfT5eB9YoIuEm87vnE
        DFEjLnH0Zw/zBEbhWUhGzUIyahaSUbOQtCxgZFnFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJ
        EZwqtIJ2MC5b/1fvECMTB+MhRgkOZiUR3h7eWylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVz
        OlOEBNITS1KzU1MLUotgskwcnFINTLMYstbnL685Pn9Wt96bzyxPFntJPvyol3g+rUiJW3DJ
        xw4uM878TU464U/D7mo+/b/l9ZnrbF1zAvP2p55U3duaWH2v0U/65uUl/JmH6w6XMR6Ua2xm
        Kq8pnej9tlJvX+ff9N2TnJQW8+2yVP0zv+nK409T2N/9eTWTd4byxcZVFV3KDKFfeLhdjNxn
        fDyWHry3/ZPHi6MaZ/cWX1HYkMAmHndspULZtaPLlz467cZe91VDZLLMb+3FhV//B+lEL7i+
        YLrq5sMXZxXFz1TZZ/35mWCmlVsi/1Lxo1J7OP88DqndttGxPF7+oEXHufnKuz/ZvxJZX/dN
        12Suud6H93LCFyrk7HcnHXQObPuxykiJpTgj0VCLuag4EQCW3Mm2hAMAAA==
X-CMS-MailID: 20230816064031epcas5p161bf015960cb5d4031eaf9bac1d3541c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
        <20230814112539.70453-4-sriranjani.p@samsung.com>
        <b3cd8115-b2bd-63dd-01d3-3cd27127d534@linaro.org>
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
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 15 August 2023 01:27
> To: Sriranjani P <sriranjani.p@samsung.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; richardcochran@gmail.com;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
> fsd@tesla.com; pankaj.dubey@samsung.com; swathi.ks@samsung.com;
> ravi.patel@samsung.com
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Jayati Sahu <jayati.sahu@samsung.com>
> Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
> Block of FSD SoC
> 
> On 14/08/2023 13:25, Sriranjani P wrote:
> > The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
> > one in FSYS0 block and other in PERIC block.
> >
> > Adds device tree node for Ethernet in FSYS0 Block and enables the same
> > for FSD platform.
> >
> 
> ...
> 
> >  &pinctrl_peric {
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index 1c53c68efd53..9a991f021711 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > @@ -32,6 +32,7 @@
> >  		spi0 = &spi_0;
> >  		spi1 = &spi_1;
> >  		spi2 = &spi_2;
> > +		eth0 = &ethernet_0;
> 
> One more thing - I said it two times already. Patch v1 and then in v2.
> You responded now without waiting for my further feedback and
> immediately sent the same stuff.
> 
> Let's be clear:
> 
> NAK for the reasons I said multiple times.

Got it, will move this alias in board specific dts file.

> 
> Best regards,
> Krzysztof


