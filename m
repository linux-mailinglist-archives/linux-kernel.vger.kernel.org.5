Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8D80E055
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbjLLAem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjLLAel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:34:41 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7039C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:34:45 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231212003442epoutp0276e5a400cbc783a120c9abbbc2f67ea0~f7mBpjDtD2055820558epoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:34:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231212003442epoutp0276e5a400cbc783a120c9abbbc2f67ea0~f7mBpjDtD2055820558epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702341282;
        bh=9zxP8ERkx0O1FQTRwny1PlaBfE23gY0xpVfbo9NJRD0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FmZuQ+IJ2OxDN0o2W+sMT3KQ5+KCMQe/UQi8vtz4lgqdq3l0gJ6MDe5W+n7pnk6OM
         LxXZuQfk00muBOXab53baZOoxrD2jibIB78U50op73aPJqytjjXhNDfg7mqtPpgZXh
         TGSLjEL/EH9nEENw7MFMumntxp9vSzjuiSNY1Hqw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231212003441epcas1p2c0549226bf1dd8dc088eb8c404fad22d~f7mBU3sjl2155521555epcas1p2r;
        Tue, 12 Dec 2023 00:34:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.234]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Sq04J5j3mz4x9QD; Tue, 12 Dec
        2023 00:34:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.F7.10211.0AAA7756; Tue, 12 Dec 2023 09:34:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231212003440epcas1p43933b2785a4ec3aa6ef2f3249cff0e1f~f7mAAhbWo2575325753epcas1p4G;
        Tue, 12 Dec 2023 00:34:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231212003440epsmtrp259c0e6acd2a063f2a2ee75832b579593~f7l--8ddq1797517975epsmtrp2C;
        Tue, 12 Dec 2023 00:34:40 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-b6-6577aaa0b164
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.DA.18939.0AAA7756; Tue, 12 Dec 2023 09:34:40 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231212003440epsmtip1908789335d5c1bb2b7a431dd4a9aeda5~f7l-0qyhb0401804018epsmtip1z;
        Tue, 12 Dec 2023 00:34:40 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Randy Dunlap'" <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
In-Reply-To: <20231205231204.1130-1-rdunlap@infradead.org>
Subject: RE: [PATCH] extcon: qcom-spmi-misc: don't use kernel-doc marker for
 comment
Date:   Tue, 12 Dec 2023 09:34:39 +0900
Message-ID: <0ef101da2c92$fe2ab4f0$fa801ed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDtwc4iLxtLyNcYHxIyb84wEDzFbgDTg6MLsncGMfA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmvu6CVeWpBpe7NC3OPf7NYrGtw8ai
        Y/J2FovLu+awWdxuXMFm8fbOdBYHNo/NK7Q8Nq3qZPO4c20Pm0ffllWMHp83yQWwRmXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8y+coCp
        YCZPxd0vF1kaGOdxdTFyckgImEh8+7KFrYuRi0NIYAejxNSuCywQzidGidk/ljHCOdvv/GKF
        aTk18xJUYiejxIc7TawQzktGia8rVwE5HBxsAjoSC36EgjSICPhIvD59DKyBWWAjo8SzvUfY
        QRKcAlYSK1YvYAKxhQXCJLqW72IBsVkEVCU6dnWB1fAKWErsbb7IAmELSpyc+QTMZhaQl9j+
        dg4zxEUKEj+fLmOFiItIzO5sY4ZYbCXx78IEsOMkBHo5JE6f72QBOU5CwEWibasGRK+wxKvj
        W9ghbCmJz+/2skHUT2aUuPj6NTOEs55RYuPKFqhtxhL7l05mAhnELKApsX6XPkRYUWLn77mM
        EEfwSbz72sMKsYtXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkLw2C8lrs5C8Mwth2QJGllWM
        YqkFxbnpqcWGBSbw6E7Oz93ECE6cWhY7GOe+/aB3iJGJg/EQowQHs5IIr8yR4lQh3pTEyqrU
        ovz4otKc1OJDjKbAwJ7ILCWanA9M3Xkl8YYmlgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqem
        FqQWwfQxcXBKNTDx27b9ZDtyROXNkVlvNFRzF10qZKtaHLt/91enxOw/8nxcMeLHjyYavlfc
        NG/P6dxT21//OzNtZZrZlRmlTdv3zXj7Yaty/2Ql5ro333bf9TI4esYr7Yobb2L++hurZ/C6
        +cyVNK7fbnX4n/+iFAPLoLMZBtMU905V6FnDNfny/G33N2o4MDzctlCx2c5z2gehK6btJfKe
        S9kSl03vWFt99p512eMlquEafZy3F3yTFdN406AnXGq0puNJxLYL8ooXxKTe9YqlSty0nuW6
        vOXWjCfhRww2GxrXvfblm9HxvttRQWMKi0zrM6l55kriZ+9/S0iN2XWp5vnE1eKK96v9s+f5
        nahfsnrW/9uXvE/yKLEUZyQaajEXFScCAFc8taElBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO6CVeWpBicWcFuce/ybxWJbh41F
        x+TtLBaXd81hs7jduILN4u2d6SwObB6bV2h5bFrVyeZx59oeNo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKmH3lAFPBTJ6Ku18usjQwzuPqYuTkkBAwkTg18xJjFyMXh5DAdkaJq5O2M0Ek
        JCWmXTzK3MXIAWQLSxw+XAxR85xR4tTtc2BxNgEdiQU/QkHKRQT8JHafO8IGUsMssJlR4t6m
        w6wQDd2MEpsaO1hBqjgFrCRWrF4AtkBYIETiyPnbLCA2i4CqRMeuLnYQm1fAUmJv80UWCFtQ
        4uTMJywgy5gF9CTaNjKChJkF5CW2v53DDHGngsTPp8tYIeIiErM725ghDrKS+HdhAusERuFZ
        SCbNQpg0C8mkWUi6FzCyrGIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIjhqtoB2My9b/1TvE
        yMTBeIhRgoNZSYRX5khxqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILU
        IpgsEwenVAOTierWXa/sjzYemyHMf0ky9sCbFa2H0lz+b1f/2isu1PD144+veV93/NfWjF+w
        e7r/fKcXEnI7T/WdbOALUv7RuSHWR6V42Y/XwTVrLp9daDrvPa9b9VKn0752P8S7Ozgq2w/d
        m2x50KBuVcqsuH8HQ+/OurHD4luuyfKGNeINy1kc1mR8ruz93FbRmzbZ5mCCNtsx1x9fGQJj
        Hr6U3Sdek8x5SdzF4/q/qj9iPk/X9d1YZKJaJC+7aleV9ONe0R5NHsfIlGXMUfEfJ6vuYRa1
        ObzRYoYe04ecmccWXzNqF5njeylqb882zssSknKvGdli9Kz/a5/k90nuyNz6TnLFf+vH0l+j
        VRb8mnX5p7GiEktxRqKhFnNRcSIAA3NndgkDAAA=
X-CMS-MailID: 20231212003440epcas1p43933b2785a4ec3aa6ef2f3249cff0e1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231205231212epcas1p3e1fd5a1a34013c9a735947dea09ebbeb
References: <CGME20231205231212epcas1p3e1fd5a1a34013c9a735947dea09ebbeb@epcas1p3.samsung.com>
        <20231205231204.1130-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Wednesday, December 6, 2023 8:12 AM
> To: linux-kernel@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>; Andy Gross <agross@kernel.org>;
> Bjorn Andersson <andersson@kernel.org>; Konrad Dybcio
> <konrad.dybcio@linaro.org>; MyungJoo Ham <myungjoo.ham@samsung.com>;
Chanwoo
> Choi <cw00.choi@samsung.com>
> Subject: [PATCH] extcon: qcom-spmi-misc: don't use kernel-doc marker for
> comment
> 
> Do not use "/**" for non-kernel-doc comments. This prevents a warning from
> scripts/kernel-doc:
> 
> warning: expecting prototype for extcon(). Prototype was for
> USB_ID_DEBOUNCE_MS() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-qcom-spmi-misc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-
> qcom-spmi-misc.c
> --- a/drivers/extcon/extcon-qcom-spmi-misc.c
> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * extcon-qcom-spmi-misc.c - Qualcomm USB extcon driver to support USB ID
>   *			and VBUS detection based on extcon-usb-gpio.c.
>   *

Applied it. Thanks.

Best Regards,
Chanwoo Choi

