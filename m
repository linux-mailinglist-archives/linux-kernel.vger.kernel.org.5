Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED98753819
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjGNK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjGNK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:27:51 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470030FB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:27:46 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714102744epoutp01d11e10e2cf7bcd4133ccda023a80c5a4~xtRtwJFp31834118341epoutp01_
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:27:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714102744epoutp01d11e10e2cf7bcd4133ccda023a80c5a4~xtRtwJFp31834118341epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689330464;
        bh=pQwE7hGHNpUalJYbZMe/5YAh0YAAucCvwgefNMirZWU=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=q6Gy7aKF8NiOkHmczB/E9RyJy+ajnLr3te8NGFiqLbr343keSGdId4HJsGDKI9H3/
         xZJKpDvqjiaOiVAPL3sHabBXcvQjP6xUtu9Ug5RJd5ltM5Etbo5JW7p7YVwyGtmLWF
         OPJzkJ+6neCCmDflHfEQZuWO0ASzxxYpmWhbphZM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230714102743epcas5p29fb6154964c9050935ee3d4be4591a7f~xtRs1RL2x1464814648epcas5p2E;
        Fri, 14 Jul 2023 10:27:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R2SNF2XNSz4x9Pw; Fri, 14 Jul
        2023 10:27:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.C6.06099.D1321B46; Fri, 14 Jul 2023 19:27:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230714102740epcas5p15e78092443564705be2e704e81c7bd16~xtRqTRVHR2484924849epcas5p1x;
        Fri, 14 Jul 2023 10:27:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714102740epsmtrp27376730554c05f50cef6d74adae0c8ec~xtRqSq4V71016210162epsmtrp2a;
        Fri, 14 Jul 2023 10:27:40 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-6f-64b1231de2dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.7A.64355.C1321B46; Fri, 14 Jul 2023 19:27:40 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230714102739epsmtip14cf56d2651b790f38de2e59f6f6db2db~xtRpBJMgf0144301443epsmtip1c;
        Fri, 14 Jul 2023 10:27:39 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230713152926.82884-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/2] ARM: dts: samsung: s5pv210-smdkv210: correct
 ethernet reg addresses (split)
Date:   Fri, 14 Jul 2023 15:57:38 +0530
Message-ID: <020601d9b63d$d1629760$7427c620$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEZgCtotC3IzK/AHOMlie1EtymBAwFtUnfTAdIFZ7CxH4BiYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmlq6s8sYUg1fT+CzW7D3HZDH/yDlW
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1j06pONo871/aweWxeUu/xeZNcAEtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM69dv
        MRUs5qn4MmECWwPjeq4uRk4OCQETiXvXl7F0MXJxCAnsZpRYdWYCG0hCSOATo8TGmzVwdu+V
        ZJiGlxO+MkM07GSU2P3nODuE85JRYvntH0wgVWwCuhI7FreBTRIRmM0kcelaHojNKeAi0X37
        JliNsECaxNfv69lBbBYBVYk97+aD1fMKWEqsmfmZGcIWlDg58wkLiM0sIC+x/e0cZogrFCR+
        Pl3GCjHfSWL7tUvMEDXiEi+PHgE7SEKglUOif9lORogGF4ktr3uYIGxhiVfHt7BD2FISn9/t
        BVrMAWR7SCz6IwURzpB4u3w9VKu9xIErc1hASpgFNCXW79KHWMUn0fv7CRNEJ69ER5sQRLWq
        RPO7qywQtrTExO5uVgjbQ2Lp4t9skKC6yCix/eFatgmMCrOQfDkLyZezkHwzC2HzAkaWVYyS
        qQXFuempxaYFxnmp5fDoTs7P3cQITp1a3jsYHz34oHeIkYmD8RCjBAezkgivyrZ1KUK8KYmV
        ValF+fFFpTmpxYcYTYFBP5FZSjQ5H5i880riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnN
        Tk0tSC2C6WPi4JRqYNr16d7ZK727FxQG/EtnKeDU63+o0b/ga8bpk0qd6TrXndU3mUzVUiip
        +akc5j1vH/dBHbG1c+VPzw265XykVDPKyuKzxlFO0ctCJtFr+UTLb8w4VFTVLXXSLuYIJ2/4
        85NFkxKUEw7/W66jqqxsXv+8eQb3hA3l/odasn90yUcYbT5fcCV77fmsotItMWvur5p80z7m
        X/gTjY0bTDdud/y1KlzEtVjjpk/NxMbufebSZn/Xuhbzt23s07T5KyL8wY8h37HHw5Ir7iL7
        aquJR0qubu+8uX1DYmPm42bzibesVZNXqbwyT93zxH76N1njS64fmD65bwqrnMzkkTfnZabD
        kpbpVbMKp6Xl3oqqVmIpzkg01GIuKk4EAJQeG08mBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnK6M8sYUg+vLzS3W7D3HZDH/yDlW
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1j06pONo871/aweWxeUu/xeZNcAEsUl01K
        ak5mWWqRvl0CV8b167eYChbzVHyZMIGtgXE9VxcjJ4eEgInEywlfmbsYuTiEBLYzSrxc2sQK
        kZCWuL5xAjuELSyx8t9zMFtI4DmjxJPZ+iA2m4CuxI7FbWwgzSICC5kkXl09yAZRdJZR4mNL
        EIjNKeAi0X37JlMXIweHsECKxPwt8SBhFgFViT3v5oOV8wpYSqyZ+ZkZwhaUODnzCQtIObOA
        nkTbRkaQMLOAvMT2t3OYIc5RkPj5dBnYmSICThLbr11ihqgRl3h59Aj7BEahWUgmzUKYNAvJ
        pFlIOhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4OraAdjMvW/9U7xMjEwXiIUYKD
        WUmEV2XbuhQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkG
        puqrj5unf162Yk+xpsHbmE2un6ZvPVbpfOuhxbxzz2c93rNdoLHotpf0yvvn/nntOby554lR
        Abf4ogkvz6bs+Toprj5U+v7PWlOWth9f2Dep6e1Pqbza8l0n5KD/R74fr3Z1+j4Wn6N9NfvD
        IqNJezbo7j/f5XQvfqbozk9xVgndHa5CFvxCWkGLF71SeePz2Cvx/weX/NScWVV28nMMXonf
        WZFn/lhT+6ptkfzGsub3XLra8kz5zOe+n+1+P/FIJ9Nl5wsfnqy53J/26Uxhw1sN+9mC6xbL
        Vh/vbcrs+B8xT3TT5hW2O3TCL6l9vfjmm8Oclb7d6SuFp1Zfntf09udc1+VLexY0+J4uq3we
        LLBUiaU4I9FQi7moOBEAaG+7s/0CAAA=
X-CMS-MailID: 20230714102740epcas5p15e78092443564705be2e704e81c7bd16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230713152937epcas5p276fc33fef3b23cc02fea8b914a45e725
References: <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
        <CGME20230713152937epcas5p276fc33fef3b23cc02fea8b914a45e725@epcas5p2.samsung.com>
        <20230713152926.82884-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, July 13, 2023 8:59 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; Rob Herring <robh+dt@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 2/2] ARM: dts: samsung: s5pv210-smdkv210: correct ethernet
> reg addresses (split)
> 
> The davicom,dm9000 Ethernet Controller accepts two reg addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Do you need to add fixes: to send to previous stable releases?
In any case:
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>  arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
> b/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
> index 6e26c67e0a26..901e7197b136 100644
> --- a/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
> +++ b/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
> @@ -41,7 +41,7 @@ pmic_ap_clk: clock-0 {
> 
>  	ethernet@a8000000 {
>  		compatible = "davicom,dm9000";
> -		reg = <0xA8000000 0x2 0xA8000002 0x2>;
> +		reg = <0xa8000000 0x2>, <0xa8000002 0x2>;
>  		interrupt-parent = <&gph1>;
>  		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>  		local-mac-address = [00 00 de ad be ef];
> --
> 2.34.1


