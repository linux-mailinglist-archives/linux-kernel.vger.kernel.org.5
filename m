Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718BC8043D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjLEBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjLEBOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:14:05 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B6AC9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:14:09 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231205011406epoutp019979921ad120e5707c5e734ec86a5c66~dynb-UZE33129831298epoutp014
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231205011406epoutp019979921ad120e5707c5e734ec86a5c66~dynb-UZE33129831298epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701738846;
        bh=MkGi/2ogU6WxSCf41iPNpXOwbjAlD6/TlSrozff2Drw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BxI+GVd53goM6hd9Ay76hIFfhYx9HAlPh/4MhqgIEf0qhskfhhhA+taIP2eXQCn/K
         E6ytjpJcGnSBsPoSHBEMmwBFRdxgv7qXwABmj0jV+l4FA9Tphf+gCPdSr+1SXWy0LI
         Zxnh+ZZTrd43Kd1AtYTfsdsEUCTfHL1f7s5mobSw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231205011406epcas1p4f1f7466d1447ea2e5a2044a7acf6e27b~dynbx-mDc0041700417epcas1p4o;
        Tue,  5 Dec 2023 01:14:06 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.136]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SkjH13kWSz4x9Q7; Tue,  5 Dec
        2023 01:14:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.48.19104.D597E656; Tue,  5 Dec 2023 10:14:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231205011405epcas1p305aba0a2c2da590eec6553d35619b178~dynaeniBv0826208262epcas1p35;
        Tue,  5 Dec 2023 01:14:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231205011405epsmtrp2767e7ea6ab21ec99cbee5275a34e1743~dynad8rjb2468824688epsmtrp2b;
        Tue,  5 Dec 2023 01:14:05 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-43-656e795da982
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.91.08817.C597E656; Tue,  5 Dec 2023 10:14:04 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231205011404epsmtip2abc8003867aa919bece104c288f31125~dynaREQxu2040220402epsmtip2J;
        Tue,  5 Dec 2023 01:14:04 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     "'Lukas Funke'" <lukas.funke-oss@weidmueller.com>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Reported-by: kernel test robot'" <lkp@intel.com>
In-Reply-To: <02a701da2717$48abf150$da03d3f0$@samsung.com>
Subject: RE: [PATCH v3] extcon: usbc-tusb320: Set interrupt polarity based
 on device-tree
Date:   Tue, 5 Dec 2023 10:14:04 +0900
Message-ID: <02b301da2718$56c488f0$044d9ad0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbId/uY71cZ8A+38Wz8TcnltFmcAHKn+mgsImXwQA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmrm5sZV6qwc9DMhYTb1xhsbi8aw6b
        xavmR2wW2z/dZrW43biCzYHVY/Gel0wem1Z1snn0bVnF6PF5k5zHllWL2AJYo7JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM94+Xcla8Fm4
        Ys9E3gbGIwJdjJwcEgImEhNPTmLsYuTiEBLYwyix4mgzG4TziVHi+tGNrBDON0aJH2evs8O0
        rD60F6plL6PEwnf/oVpeMkqc6G0BquLgYBPQkVjwIxSkQURASeL7tW5GEJtZ4CCjxNFrziA2
        p4CVxOJta5hAbGGBaImbC5rBFrAIqEhsmLEYzOYVsJTYsfYDE4QtKHFy5hMWiDnyEtvfzmGG
        OEhB4ufTZawQu6wkpn38yApRIyIxu7ONGeQ2CYFODomvk86yQjS4SLRtWscIYQtLvDq+Beoz
        KYnP7/ayQTRMZpS4+Po1VPd6RomNK1ug1hlL7F86mQnkS2YBTYn1u/QhwooSO3/PhfqST+Ld
        1x5WkBIJAV6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8tssJL/NQvLDLIRlCxhZVjFKpRYU
        56anJhsWGOrmpZbDYzw5P3cTIzhxavnsYPy+/q/eIUYmDsZDjBIczEoivPNuZacK8aYkVlal
        FuXHF5XmpBYfYjQFhvhEZinR5Hxg6s4riTc0sTQwMTMyNrEwNDNUEueN+dSeIiSQnliSmp2a
        WpBaBNPHxMEp1cCUyrR5X1nTw36FAHvWe8ebLoZdybrOd39FUMkM59lVu1b5vr4dWTzlZtrL
        2/Mc4zJTk7RFA4sepc25EZLkbXDtBuvbSXPcXPV+mP6T1jqjIX+OaYWXz5XUa49lq/b1pU1f
        GXq6aB9bpeYLzkkz9IL4JDzeXEtpyPznYeYs+/XJ75tMzw4zX4jommBn32bbrft+xRZptr6P
        smebhfp4VY5P2eJySPrXyqyVy2t4jhocmcJ49JXK29o8hducma6VX9+s2zXVkmmD4YIph3Pn
        s03bvP2fWlWQ4fsKyWVbH51ZaMhftPvJWrOzv8LNvBZJ5+ZMX7up5aOq//tvrffzTftOMHDq
        8h3Yt+TuodqlejWqSizFGYmGWsxFxYkAGl2XsiUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvG5MZV6qwdo35hYTb1xhsbi8aw6b
        xavmR2wW2z/dZrW43biCzYHVY/Gel0wem1Z1snn0bVnF6PF5k5zHllWL2AJYo7hsUlJzMstS
        i/TtErgy3j5dyVrwWbhiz0TeBsYjAl2MnBwSAiYSqw/tZexi5OIQEtjNKPFz2wtmiISkxLSL
        R4FsDiBbWOLw4WKImueMEkeO/WICibMJ6Egs+BEKUi4ioCTx/Vo32BxmgcOMEit27GAHSQgJ
        dDNK/L1ZCWJzClhJLN62hgnEFhaIlDiz4xkbiM0ioCKxYcZisHpeAUuJHWs/MEHYghInZz5h
        AbGZBbQlnt58CmXLS2x/OwfqTgWJn0+XsUIcYSUx7eNHVogaEYnZnW3MExiFZyEZNQvJqFlI
        Rs1C0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw3Ghp7WDcs+qD3iFGJg7G
        Q4wSHMxKIrzzbmWnCvGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbL
        xMEp1cCUprpKNW9PnO2xg+9DuDYdcjSzbMtq9PK4wn2ke2vcnoK6siVf+8TOHvhf4Xj5v/7c
        baJLuiU2W+xUDvpQ9WWar8r7zstBdxr+8llLHdGcxlM9tzivcorqutuXvn/YfqSa58281xUH
        r0alSXNWfNEVEolr3/VYMc5rx9JJr0/pvr8iNEX8fJeW67ynnbFffl12zQma6bLT/ciMT8+Y
        nX6/eLooszCsv6ZaYt+y8yH3L2634LfVeHlA90Tf7fKD3O9ObPh0NFEp+NCNPW2F5c0dHky3
        c94JbdzDsvmhpUFIVf6O2abdIUebbTVsD/XtKw5WCdjpcS5F4lgvC/OdHdvaXfMMbRiO3piy
        lnHeHkc3JZbijERDLeai4kQA2BcM2QoDAAA=
X-CMS-MailID: 20231205011405epcas1p305aba0a2c2da590eec6553d35619b178
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07
References: <CGME20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07@epcas1p4.samsung.com>
        <02a701da2717$48abf150$da03d3f0$@samsung.com>
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
> From: Chanwoo Choi <cw00.choi@samsung.com>
> Sent: Tuesday, December 5, 2023 10:07 AM
> To: linux-kernel@vger.kernel.org
> Cc: 'Lukas Funke' <lukas.funke-oss@weidmueller.com>; 'Signed-off-by:
> Chanwoo Choi' <cw00.choi@samsung.com>; 'Chanwoo Choi' <chanwoo@kernel.org>;
> 'MyungJoo Ham' <myungjoo.ham@samsung.com>; 'Reported-by: kernel test robot'
> <lkp@intel.com>
> Subject: [PATCH v3] extcon: usbc-tusb320: Set interrupt polarity based on
> device-tree
> 
> Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on every
> interrupt controller (i.e. arm64 GIC). Replace flag by a request that
> depends on the actual device-tree setting.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-lkp@intel.com/
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v2
> - Use IRQF_TRIGGER_FALLING if there are no irq_data on devicetree
> 
>  drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c
> b/drivers/extcon/extcon-usbc-tusb320.c
> index 4d08c2123e59..2eab341de6b7 100644
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
> +	u32 irq_trigger_type = IRQF_TRIGGER_FALLING;
> +	struct irq_data *irq_d;
> 
>  	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -568,9 +571,13 @@ static int tusb320_probe(struct i2c_client *client)
>  		 */
>  		tusb320_state_update_handler(priv, true);
> 
> +	irq_d = irq_get_irq_data(client->irq);
> +	if (irq_d)
> +		irq_trigger_type = irqd_get_trigger_type(irq_d);
> +
>  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>  					tusb320_irq_handler,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					IRQF_ONESHOT | irq_trigger_type,
>  					client->name, priv);
>  	if (ret)
>  		tusb320_typec_remove(priv);
> --
> 2.25.1

Applied it. Thanks.

Best Regards,
Chanwoo Choi


