Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542EC7531A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjGNF7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGNF7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:59:35 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF430C4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:59:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230714055929epoutp0215481b336f0549e93b33b36bafb077d4~xpngPihAM0987209872epoutp02V
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:59:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230714055929epoutp0215481b336f0549e93b33b36bafb077d4~xpngPihAM0987209872epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689314369;
        bh=lhCYFD770y611HxZAW3dxcTojBwG0d3HYPS4qXsf80s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ye5YrvwjqP4QEoXEqL1tqlDCNjKGG9/s0VIy8V0VQqAeWdZU3EKHHUwRX1iJzG4Rx
         36vhkeqCNCDosV0Q6xmu4piEw1j5VkfNJ524w9dUi9xWm8Kge3ZPKtC5Am/jiE74xy
         MR7XJ3imgPphmBQwZWZJikYh3I3yqepdS+Lip6CE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230714055929epcas2p40082116dbe3e35e1e60500c195e7aaa9~xpnfuA0jn2499624996epcas2p4X;
        Fri, 14 Jul 2023 05:59:29 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R2LQm6jsqz4x9Q4; Fri, 14 Jul
        2023 05:59:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.1A.40133.044E0B46; Fri, 14 Jul 2023 14:59:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230714055928epcas2p37d916758a88e8267e73675af77777da5~xpne_3Zgv1446214462epcas2p3u;
        Fri, 14 Jul 2023 05:59:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230714055928epsmtrp1a7ad8253fcf074b5c2b98220e07d9c2d~xpne_MU-L2827328273epsmtrp1t;
        Fri, 14 Jul 2023 05:59:28 +0000 (GMT)
X-AuditID: b6c32a46-d17dea8000009cc5-aa-64b0e440e821
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.1A.64355.044E0B46; Fri, 14 Jul 2023 14:59:28 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230714055928epsmtip1ad580f28db86b45c489347a16701e2e8~xpnexzNi91256212562epsmtip1l;
        Fri, 14 Jul 2023 05:59:28 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3bc9c34a-ba55-61c5-87ea-80b369841873@linaro.org>
Subject: RE: [PATCH] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Date:   Fri, 14 Jul 2023 14:59:28 +0900
Message-ID: <000401d9b618$59a29d80$0ce7d880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI7ggaV//vx+WpMcWVl1rcn69NoogJEzZGLAoWKDhmuzti7QA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmqa7Dkw0pBvPum1g8mLeNzWLN3nNM
        FvOPnGO12NFwhNWi78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7Jo3XuE3YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OL
        S/PS9fJSS6wMDQyMTIEKE7Iz1m5OLdjDXDF/90X2BsbLTF2MnBwSAiYSp+bPArK5OIQEdjBK
        rFwzmR3C+cQosXTGTiY4Z+Gdu3AtRxaeYIZI7GSUODS7jRHCecEo8XrqKXaQKjYBfYmXHdtY
        QRIiAouZJLY0vQerYhboZ5TY8OUFK0gVp4CdxOarT1hAbGEBb4kz8xYwgtgsAqoS/Rf7mUFs
        XgFLibmHz7FC2IISJ2dC1DMLaEssW/iaGeImBYmfT5eB1YgIOEnsXbiOFaJGRGJ2ZxvYrRIC
        Czkk7u7ZDPWEi8SN4xvYIWxhiVfHt0DZUhIv+9uAbA4gu1xix7IkiN4WRonmtj1Qy+wlftyc
        wgpSwyygKbF+lz5EubLEkVtQp/FJdBz+CzWFV6KjTQiiUV3iwPbpLBC2rET3nM+sExiVZiF5
        bBaSx2YheWAWwq4FjCyrGMVSC4pz01OLjQqM4LGdnJ+7iRGcYLXcdjBOeftB7xAjEwfjIUYJ
        DmYlEV6VbetShHhTEiurUovy44tKc1KLDzGaAoN6IrOUaHI+MMXnlcQbmlgamJiZGZobmRqY
        K4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXANONf4WzLoi9ry4rydu6WzPr5Le7GrdMMcz7v
        s1sQ4dkgnsey2Sd5r/E0/Z6GNZ/2RDq/uWAUmq7+ZwlnRrGL6Znf4bdk3u2P/7EluHhr4jae
        mZ0MpT/LfXcp345cxJm5lGvzq7v+RoxdGgZ33ldYrMgu5Zr19Ixpf6Js7z5rVaOO56IFzxc9
        sDjg/IKDzWRJAo+Kzd1NSu08namNj1PKK5adu/rzIKuHt6NoGtPMfe07l0n2rXl1YPHsviTz
        9sXbMj7rLpz/+UNFmqZsLMfM1oX1/bcjpQ3fNxZsqO28JJC1PcdYoHXvzE7NbUrfnSMamvtV
        z0vkdwdm73c9fc7RW/HJT14Jw2m+u1yWzH+txFKckWioxVxUnAgAKUfoGTkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTtfhyYYUg92bxC0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Xe11vZLTY9vsZqcXnXHDaLGef3MVm07j3C7sDlsWlVJ5vHnWt7
        2Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroyHc2ULdjFXLPyg0MB4kamLkZNDQsBE
        4sjCE8xdjFwcQgLbGSVWNs9igUjISjx7t4MdwhaWuN9yhBWi6BmjxIEvP5hBEmwC+hIvO7aB
        JUQEljNJXD70lwnEYRaYzCjx/cBaJoiWg4wSdw4sAJvFKWAnsfnqE7AdwgLeEmfmLWAEsVkE
        VCX6L/aDjeUVsJSYe/gcK4QtKHFyJkQ9s4C2xNObT+HsZQtfM0PcpyDx8+kysHoRASeJvQvX
        sULUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3
        MYKjTCtoB+Oy9X/1DjEycTAeYpTgYFYS4VXZti5FiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9y
        TmeKkEB6YklqdmpqQWoRTJaJg1OqgUlE1EeCf7HQU9nSCTXnDAon6kpNedBzcu/ZhdlOlx+m
        V4k+t19w4LD0hdRSf4WA9JnV01PNWL9wS3rs2tLus0t+n9a6qRX3K27vqKpb3Xx+Tngex6rN
        i/ZY+Yrsnckh6s4ctkP+Z0P46h9HWXf6tFptvrjQ0zg++Zyy9QaP/0J/vR5kXzpWbLHlzLJN
        QufWzk+zvh5Vk7p2k9aCMwwrv83yM0vZKGNRxckozx3vfe7DpXUCB8QMfxvIiF/z6Oi5typN
        /NGxlOqHM+4XLpfevGt6T0D8wdRfzzKCg7OFH+685R7uFZhVpRB+YekuO5YHTbdnMO39zm3B
        93OFsNUko8sCWl8ZsvbtPy8XXVjBUa7EUpyRaKjFXFScCAB8fVhfIQMAAA==
X-CMS-MailID: 20230714055928epcas2p37d916758a88e8267e73675af77777da5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8
References: <CGME20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8@epcas2p4.samsung.com>
        <20230714051521.22720-1-jaewon02.kim@samsung.com>
        <3bc9c34a-ba55-61c5-87ea-80b369841873@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +			reg =3D <0x103f0000 0x100>;
> > +			samsung,pwm-outputs =3D <0>, <1>, <2>, <3>;
> > +			=23pwm-cells =3D <3>;
> > +			clocks =3D <&xtcxo>;
>=20
> This does not look like correct clock. Are you sure XTCXO goes to PWM?

Yes. XTXCO is the source clock of the pwm. Unlike any other exynos SoCs, th=
e clock is directly derived from the external OSC.
Thus, it cannot be controllable such as gating.

Best Regards,
Chanho Park

