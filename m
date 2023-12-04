Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842380322E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjLDMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:09:20 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B983D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:09:25 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231204120922epoutp0230a9d76921d7e26077103f64154bc7e9~dn6RujO2n2440624406epoutp02T
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:09:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231204120922epoutp0230a9d76921d7e26077103f64154bc7e9~dn6RujO2n2440624406epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701691762;
        bh=00PJUcYSy+OuTquxiKbFXm9KhASA+HwxNX6eOOUHg+w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kMIwmYDBID7u2B8mX7amfyUR9EUDxm0BpVV2w0E9wd+KoDD2i1MkklJvkvzmELJfx
         IIGzjallZmTni1pgomNPPq+DJ5MtuRgTVN8aVgq2lamkb21RZCmSOUmpuhbQtaUVrA
         Becqxb7g5Jv6V5rlICprEdtTSAeR4dRE93DfowrI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231204120922epcas1p2bd42c9de2273d38ac58aed227630c72f~dn6RPHXL21767017670epcas1p2T;
        Mon,  4 Dec 2023 12:09:22 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.237]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SkMsY1mVvz4x9Pt; Mon,  4 Dec
        2023 12:09:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.D9.19104.171CD656; Mon,  4 Dec 2023 21:09:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231204120920epcas1p48420de72a4fb5268462a73338c8b8da9~dn6PwLDge1856218562epcas1p4B;
        Mon,  4 Dec 2023 12:09:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231204120920epsmtrp2e911ed2f78c31f64ba69d9c54d75dd1d~dn6Puzvas0291002910epsmtrp2I;
        Mon,  4 Dec 2023 12:09:20 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-6d-656dc1713979
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.D9.08755.071CD656; Mon,  4 Dec 2023 21:09:20 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231204120920epsmtip2215db312838bd4c31d6adb4c244fe9db~dn6PiKTaU2315523155epsmtip2I;
        Mon,  4 Dec 2023 12:09:20 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Lukas Funke'" <lukas.funke-oss@weidmueller.com>, <lkp@intel.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
Cc:     <Lukas.Funke@weidmueller.com>, <linux-kernel@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>,
        "'Lukas Funke'" <lukas.funke@weidmueller.com>
In-Reply-To: <20231122080749.947682-1-lukas.funke-oss@weidmueller.com>
Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
 on device-tree
Date:   Mon, 4 Dec 2023 21:09:20 +0900
Message-ID: <000d01da26aa$b648a180$22d9e480$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIM5zhv5YhESJxix+B2YaYbT/bXQwBbQ2wPAnvXN6ewHM4PUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmgW7hwdxUg43POCwu75rDZvGq+RGb
        xfZPt1ktpk9ZyGxxu3EFm8WhlVeYHNg8Fu95yeTxYvNMRo++LasYPT5vkvPYsmoRWwBrVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjPUL
        5zIW3BWu2LGok7mBcYVAFyMnh4SAicTVqQeZuhi5OIQE9jBKTG7/AeV8YpQ4+L+dFcL5xijx
        /d5fFpiWDYcuMEIk9jJKPO7eAeW8ZJQ4/vM2WxcjBwebgI7Egh+hIA0iAqUS59ZOApvELDCV
        UeLQhRWsIAlOATeJIxPmMIPYwgLREp+ffAOzWQRUJP4secQKModXwFJixnkZkDCvgKDEyZlP
        wI5gFpCX2P4WolVCQEHi59NlrBC7nCSmbP3ECFEjIjG7s40ZZK+EwFQOiZ6z66E+cJFYvLKB
        EcIWlnh1fAs7hC0l8fndXjaIhsmMEhdfv4bqXs8osXFlC9Q6Y4n9SyczgVzHLKApsX6XPkRY
        UWLn77lQm/kk3n3tAXtAQoBXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkPw2C8lvs5D8MAth
        2QJGllWMUqkFxbnpqcmGBYa6eanl8ChPzs/dxAhOolo+Oxi/r/+rd4iRiYPxEKMEB7OSCO+8
        W9mpQrwpiZVVqUX58UWlOanFhxhNgQE+kVlKNDkfmMbzSuINTSwNTMyMjE0sDM0MlcR5Yz61
        pwgJpCeWpGanphakFsH0MXFwSjUw8d0UzfnU+n9f6P0dm37cFbz0Zv5LKd9/ShVpHodmfTr+
        9Ln0o2t/g1cFdT+dqpJ758XjwGaBbcnX9l4t7GRQ6Iv4MH9BtJ9zzrIL/tN3tC0rfvaO5WKG
        96QflrKrt68LXsydNn+dYu3fdl+jyVrMGy7ktjxa4O3PEGYnEfl33raZhTHR7Qt+fAo/7frz
        fM/GuEPTHOz99i3ca9vB0M57fPnBk78nGm/v2fHqzM46llteBicdDM+Y/HDNebIsIvf5AaUM
        HvH3TlJh0oY+4Z5/jObPW3BqxjH7E8UMpxO+LxN4/WLzwynbE+KtZj7/vb4yw2K/Xa/6gjS5
        s1UWNh4PEwLuGLo2emhxs7W9+VW567QSS3FGoqEWc1FxIgBR7/CoKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvG7BwdxUg85OJYvLu+awWbxqfsRm
        sf3TbVaL6VMWMlvcblzBZnFo5RUmBzaPxXteMnm82DyT0aNvyypGj8+b5Dy2rFrEFsAaxWWT
        kpqTWZZapG+XwJWxfuFcxoK7whU7FnUyNzCuEOhi5OSQEDCR2HDoAmMXIxeHkMBuRokZ17tZ
        IRKSEtMuHmXuYuQAsoUlDh8uhqh5zigxseEIC0icTUBHYsGPUJByEYFyiff9nWwgNcwC0xkl
        bl2/BzV0L6PEyUeXGUGqOAXcJI5MmMMMYgsLRErsfXwDLM4ioCLxZ8kjVpChvAKWEjPOy4CE
        eQUEJU7OfAK2i1lAT6JtI1g1s4C8xPa3EFMkBBQkfj5dxgpxg5PElK2foGpEJGZ3tjFPYBSe
        hWTSLIRJs5BMmoWkYwEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOD40dLcwbh9
        1Qe9Q4xMHIyHGCU4mJVEeOfdyk4V4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1
        OzW1ILUIJsvEwSnVwMQS0fnp16Xldosl44pWfp2x7EuVbpqnS8aEeNucuQfdtleVPnpTGh3T
        3/bt/XudA2vep53crLM+3TdF5eZvzYf7LT2W9ybdCIuYefLKopKJqj9L3U+Usv/+ZJz1apfS
        xlkTGFJLzv24w9SQcV7v1qZDS1/889re8Kj067a9H2w6tyzW6np176/2g+6t5YJlq5cFKe5U
        0LLiWDPh6TTBNUkz+f0nJD29y1TyXmzFAfYHkWpWt1ZYl1ZM1Be/8F2kynXqCb+Fqduf+U2+
        b3BV4D7T+xlJL+TzU1WUSzNX6frcP6Ihwx8wf29jSchJgcvHXs/eMYlnq861iH+3VWeGM/Hr
        TvuVp1G1rMqdK04v+6iYEktxRqKhFnNRcSIA/NFEfg4DAAA=
X-CMS-MailID: 20231204120920epcas1p48420de72a4fb5268462a73338c8b8da9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231122080822epcas1p23e2e80d3db305229f9d611d79b667a2f
References: <202311221355.yxYpTIw3-lkp@intel.com>
        <CGME20231122080822epcas1p23e2e80d3db305229f9d611d79b667a2f@epcas1p2.samsung.com>
        <20231122080749.947682-1-lukas.funke-oss@weidmueller.com>
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
> From: Lukas Funke <lukas.funke-oss@weidmueller.com>
> Sent: Wednesday, November 22, 2023 5:08 PM
> To: lkp@intel.com; MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Cc: Lukas.Funke@weidmueller.com; linux-kernel@vger.kernel.org;
lukas.funke-
> oss@weidmueller.com; oe-kbuild-all@lists.linux.dev; Lukas Funke
> <lukas.funke@weidmueller.com>
> Subject: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based on
> device-tree
> 
> From: Lukas Funke <Lukas.Funke@weidmueller.com>
> 
> Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on every
> interrupt controller (i.e. arm64 GIC). Replace flag by a request that
> depends on the actual device-tree setting.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-
> lkp@intel.com/
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-
> usbc-tusb320.c
> index 4d08c2123e59..140ab28dbd36 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -17,6 +17,7 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/role.h>
> +#include <linux/irq.h>
> 
>  #define TUSB320_REG8				0x8
>  #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> @@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
>  	const void *match_data;
>  	unsigned int revision;
>  	int ret;
> +	int irq_pol;
> +	struct irq_data *irq_d;
> 
>  	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -568,9 +571,17 @@ static int tusb320_probe(struct i2c_client *client)
>  		 */
>  		tusb320_state_update_handler(priv, true);
> 
> +	irq_d = irq_get_irq_data(client->irq);
> +	if (!irq_d) {
> +		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
> +		return -ENODEV;
> +	}
> +
> +	irq_pol = irqd_get_trigger_type(irq_d);
> +
>  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>  					tusb320_irq_handler,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					IRQF_ONESHOT | irq_pol,
>  					client->name, priv);
>  	if (ret)
>  		tusb320_typec_remove(priv);
> --
> 2.30.2


Applied it. Thanks.


Best Regards,
Chanwoo Choi


