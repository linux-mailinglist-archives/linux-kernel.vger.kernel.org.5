Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C080327D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjLDMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjLDMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:22:18 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB8D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:22:23 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231204122221epoutp012e907fc97fccfd0274031be2d54554e1~doFmkE6Uv1045610456epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231204122221epoutp012e907fc97fccfd0274031be2d54554e1~doFmkE6Uv1045610456epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701692541;
        bh=twgNFA4iDKQa4pdvQAkEYtsxfBwRyIBtkdkqfaeZcPs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JxZ+NAktZlMzWkAH5sSUsRSO6lLvElQ0pJnZt3jazB8AWdsUUdzbL4XWC2I36pNSJ
         ePGxXMolxzD3r+eF9psAZRlO0jqifPFRWENhwnJTcgIfzVCiH07wvS8IUKL5b54LHT
         hiwF2XbE2KFwBb53O9PnGXGyQGApKJEbTJlH3X6A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231204122220epcas1p41fd30a89ce948ddb6c3b4e74f911465c~doFmG_WFo1474214742epcas1p4w;
        Mon,  4 Dec 2023 12:22:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.134]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SkN8X0Qs7z4x9Pv; Mon,  4 Dec
        2023 12:22:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.C6.10025.B74CD656; Mon,  4 Dec 2023 21:22:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231204122219epcas1p21f414dfe4a02d9807fb154a41089c306~doFlSJ9Ul2649126491epcas1p2e;
        Mon,  4 Dec 2023 12:22:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231204122219epsmtrp181303614a120052d0711c5f24c0b0faa~doFlRlZ4m1093710937epsmtrp1-;
        Mon,  4 Dec 2023 12:22:19 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-16-656dc47b7a55
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.61.08817.B74CD656; Mon,  4 Dec 2023 21:22:19 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231204122219epsmtip2b63d764548be868f719b6513b08cd817~doFlG7XH52215922159epsmtip2r;
        Mon,  4 Dec 2023 12:22:19 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Yaxiong Tian'" <iambestgod@outlook.com>,
        <myungjoo.ham@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <tianyaxiong@kylinos.cn>
In-Reply-To: <TYZPR01MB4784ADCD3E951E0863F3DB72D5B8A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
Subject: RE: [PATCH] extcon: fix possible name leak in extcon_dev_register()
Date:   Mon, 4 Dec 2023 21:22:19 +0900
Message-ID: <000e01da26ac$86a5e3a0$93f1aae0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWVBsunLntA6hL6XjhN+VB/008TgLGsp9QsAp7LhA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTX7fmSG6qwZkFjBYPJz5gtbi8aw6b
        xe3GFWwWP25tZHJg8djS+o/ZY/PrF8wefVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ3RevIna8Ee7op1d24yNTDu5uxi
        5OSQEDCRmNOwgQnEFhLYwShx6aljFyMXkP2JUWLDxmY2COcbo8Tykw9ZYTo2L+xihkjsZZTo
        en+CCcJ5ySjRcmEHUAsHB5uAjsSCH6EgDSICnhJ/pnSCrWAWsJFo+jOdBcTmFEiSmH7tKpgt
        LOAjsX7WZrAaFgEViYYpC8HivAKWEtc3zYKyBSVOznzCAjFHXmL72znMEAcpSPx8uowVYpeV
        xM5FT1ghakQkZne2gR0qIfCTXeL2h6lQH7hIHDzcxA5hC0u8Or4FypaSeNnfxg7RMJlR4uLr
        11Dd6xklNq5sgVpnLLF/6WQmkC+ZBTQl1u/ShwgrSuz8PZcRYjOfxLuvPawgJRICvBIdbUIQ
        JcoSlx/cZYKwJSUWt3eyTWBUmoXkt1lIfpuF5IdZCMsWMLKsYhRLLSjOTU8tNiwwhcd2cn7u
        JkZwctSy3ME4/e0HvUOMTByMhxglOJiVRHjn3cpOFeJNSaysSi3Kjy8qzUktPsRoCgzticxS
        osn5wPScVxJvaGJpYGJmZGxiYWhmqCTOe+5tb4qQQHpiSWp2ampBahFMHxMHp1QDkwK3xykh
        O8cZ294o3t0kYvc75f+fjzHyy/q2/m9/vXF9J4Niw5ktJvWTXNuVlk8RML+vlLV2Z/WeSfef
        z4toPSNZ2L5x65YWkVbxG3P9wpcsMny3eFfWjUM39EKzJVk/rumpP1zrlcj42e51xEZJu8/z
        rgbq7ZgUH3n9tJ5Gl+XyLwrv15XdK8hQP1g5w0M7ZteL+Qf1bv5n37FZ2f9n4FIF1lumJ1uW
        1Cpq/+2f8Tj3B8+JWX+ef5t78dyxw8af81fcrHXWPHCuiXl5SfMLx3V/9uvyVKtLO0d/Z2O+
        IHnEe82Z7fnJuQrdNoEL960M1CvbmXmp9m5j4vGlhz9Gsxw/zuYZ8dVeaeKbm4UPNqkpsRRn
        JBpqMRcVJwIAaDXoMRcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvG71kdxUgzmH1CweTnzAanF51xw2
        i9uNK9gsftzayOTA4rGl9R+zx+bXL5g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK6P15E/W
        gj3cFevu3GRqYNzN2cXIySEhYCKxeWEXcxcjF4eQwG5GiSfTpzFDJCQlpl08CmRzANnCEocP
        F0PUPGeUmDjvBRNInE1AR2LBj1CQchEBb4kj9+axgdjMAnYSc/e0MELUb2aUeLPhCStIglMg
        SWL6tassILawgI/E+lmbmUBsFgEViYYpC8HivAKWEtc3zYKyBSVOznzCArKLWUBPom0jI8R8
        eYntb+dAnakg8fPpMlaIG6wkdi6CWMUsICIxu7ONeQKj8Cwkk2YhTJqFZNIsJB0LGFlWMUqm
        FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4iW1g7GPas+6B1iZOJgPMQowcGsJMI771Z2
        qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MDq8jeh/G
        Mx5Zc3jmN/VMXbmgf5s9LeQ2PlYuELz/e1vAZJ36zErLD97lUnqrwnU0tnjvcLoV9+nxrmOP
        hdfnX54pLxQl5cv2xmAbc+/qEO0me9YMX9aoaTuSfqxX3lL4yfXVmaL5vMZv+9aukV8r/sdg
        j/TSLzUvJ/zduff7TP3NGzfufMmfPGVW9CEjlSf5VSuvL/59S4D5fGNSV9tjixiNA4/029gb
        u76x7bCwZvLN6T/lcrbnUc/OHaa7Jvcvy2s8HcP6tfp27I3MK5P8ExfH6f7Vm987m90/6bBF
        24qCQofJulFHZ0yJikxKv3TLLHPBiiunnA5O8w3iWyXqvO/gsbqXjtudFLsW+MdPUGIpzkg0
        1GIuKk4EABDkRND/AgAA
X-CMS-MailID: 20231204122219epcas1p21f414dfe4a02d9807fb154a41089c306
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231124014941epcas1p2f6a6751a6a0aac64ffee54ddc74da0bb
References: <CGME20231124014941epcas1p2f6a6751a6a0aac64ffee54ddc74da0bb@epcas1p2.samsung.com>
        <TYZPR01MB4784ADCD3E951E0863F3DB72D5B8A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yaxiong Tian <iambestgod@outlook.com>
> Sent: Friday, November 24, 2023 10:49 AM
> To: myungjoo.ham@samsung.com; cw00.choi@samsung.com
> Cc: linux-kernel@vger.kernel.org; tianyaxiong@kylinos.cn
> Subject: [PATCH] extcon: fix possible name leak in extcon_dev_register()
> 
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> In the error path after calling dev_set_name(), the device name is leaked.
> To fix this,Moving dev_set_name() after the error path and before
> device_register.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/extcon/extcon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index
> 6f7a60d2ed91..e7f55c021e56 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1280,8 +1280,6 @@ int extcon_dev_register(struct extcon_dev *edev)
> 
>  	edev->id = ret;
> 
> -	dev_set_name(&edev->dev, "extcon%d", edev->id);
> -
>  	ret = extcon_alloc_cables(edev);
>  	if (ret < 0)
>  		goto err_alloc_cables;
> @@ -1310,6 +1308,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	RAW_INIT_NOTIFIER_HEAD(&edev->nh_all);
> 
>  	dev_set_drvdata(&edev->dev, edev);
> +	dev_set_name(&edev->dev, "extcon%d", edev->id);
>  	edev->state = 0;
> 
>  	ret = device_register(&edev->dev);
> --
> 2.25.1


Applied it. Thanks.

Best Regards,
Chanwoo Choi

