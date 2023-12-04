Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2A8032C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjLDMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjLDMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:32:53 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03911A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:32:58 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231204123256epoutp0184a411b3e4c7058c6bc1d3a06f1f44ff~doO2kuao82277922779epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:32:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231204123256epoutp0184a411b3e4c7058c6bc1d3a06f1f44ff~doO2kuao82277922779epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701693176;
        bh=bseaOLh5M1gkK+Vza8g9UZAiK3FIiHwRkXsburlf5bQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sYSXwl4I9ed3Bonb7If7JOmrUjCBY4Hnt7d6SXjNWcYfpBeZPxFoDTfZPtt5tHMih
         t9dm2yl1N/Bk6w4WcVEvNEm7Zyv984ni08rNYzS71j222c7RdrvaH6H4owfYU440pI
         pOseeVQsiF4KZOkwktCPZDaU+WoSZF480S8GtUmc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231204123255epcas1p37eba982b52a952040033ff316df0a217~doO1bO6az0069100691epcas1p30;
        Mon,  4 Dec 2023 12:32:55 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.231]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SkNNk4Gb0z4x9Pp; Mon,  4 Dec
        2023 12:32:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.C1.09739.6F6CD656; Mon,  4 Dec 2023 21:32:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231204123254epcas1p3d8a707048621f2356c79ab064e69cf20~doO0Nli2r0069100691epcas1p3x;
        Mon,  4 Dec 2023 12:32:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231204123254epsmtrp11a0a44101f9aada5ac8de3abbaaf13e0~doO0M56wS1839318393epsmtrp1G;
        Mon,  4 Dec 2023 12:32:54 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-0b-656dc6f6f389
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.54.07368.6F6CD656; Mon,  4 Dec 2023 21:32:54 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231204123254epsmtip28af1f3edaa4838a53c02113965286813~doO0BUYDd0388603886epsmtip2W;
        Mon,  4 Dec 2023 12:32:53 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Lukas Funke'" <lukas.funke-oss@weidmueller.com>, <lkp@intel.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
Cc:     <Lukas.Funke@weidmueller.com>, <linux-kernel@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>,
        "'Lukas Funke'" <lukas.funke@weidmueller.com>
In-Reply-To: 
Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
 on device-tree
Date:   Mon, 4 Dec 2023 21:32:53 +0900
Message-ID: <000f01da26ae$00d699c0$0283cd40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIM5zhv5YhESJxix+B2YaYbT/bXQwBbQ2wPAnvXN6ewHM4PUIAABmJQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvu63Y7mpBhc/yFlc3jWHzeJV8yM2
        i+2fbrNaTJ+ykNniduMKNotDK68wObB5LN7zksnjxeaZjB59W1YxenzeJOexZdUitgDWqGyb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGZ23
        XrIVtMlVTNv/mL2BcadEFyMnh4SAicTpS/PYuxi5OIQEdjBKzN93hBXC+cQoMfXaNTYI5xuj
        xOsTcxlhWi6tns0CkdjLKLHnyFlGCOclo8Tsn6uBHA4ONgEdiQU/QkEaRARKJc6tnQQ2lllg
        KqPEoQsrWEFqOAV4JSb8swapERaIlvj85BsziM0ioCKx4eNsNhCbV8BSYsGXKcwQtqDEyZlP
        WEBsZgF5ie1v5zBDHKQg8fPpMlaIXW4S5xqOs0HUiEjM7mxjBtkrITCVQ+LD39NsEA0uEseP
        3WGBsIUlXh3fwg5hS0m87G9jh2iYzChx8fVrqO71jBIbV7ZArTOW2L90MhPIB8wCmhLrd+lD
        hBUldv6GBBGzAJ/Eu689YE9KAD3Z0SYEUaIscfnBXSYIW1JicXsn2wRGpVlIfpuF5LdZSH6Y
        hbBsASPLKkax1ILi3PTUYsMCY3h0J+fnbmIEJ08t8x2M095+0DvEyMTBeIhRgoNZSYR33q3s
        VCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD0zfeSXxhiaWBiZmRsYmFoZmhkrivLee9aYI
        CaQnlqRmp6YWpBbB9DFxcEo1MBU98dZ5ondP582sTd575GxvfD+7mfmjQL1R7vmUD7wzz3o1
        Rn6VWPkoq/Esv9zkw/O32JdtDVkrdFJvWu5E7TX3YlO6PjTwv82+0+6x6sSqLtfq2Wrm5z/N
        mvn7D++r7+fYFW7JaylNm6n/+NGCBgf/RPYVJgXS1z7yrZt2bPGvh18/rxTfOCHuRbSJhUDI
        qaA9xSZiBveF73RcSL8b07zkdM11gYj7c+Y7LqnZ6dp+Wv70tv6f0/4tOZdWaar1WGPDk3nn
        XVOPHrafv1T81hkX5ae2ard5tzRru7tL8P+0e3Ht4KRzu3xFlVY/tV5zTCHccbnAyWkxFrvu
        i97fXv7oKPOnVV2sDdYOk1aeOtjhp8RSnJFoqMVcVJwIAJvIW9wnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO63Y7mpBhc7OCwu75rDZvGq+RGb
        xfZPt1ktpk9ZyGxxu3EFm8WhlVeYHNg8Fu95yeTxYvNMRo++LasYPT5vkvPYsmoRWwBrFJdN
        SmpOZllqkb5dAldG562XbAVtchXT9j9mb2DcKdHFyMkhIWAicWn1bJYuRi4OIYHdjBI9q++w
        QiQkJaZdPMrcxcgBZAtLHD5cDBIWEnjOKHFgTRJImE1AR2LBj1CQsIhAucT7/k42kDHMAtMZ
        JW5dv8cIMXMfo8Say9tYQBo4BXglJvyzBmkQFoiU2Pv4BiOIzSKgIrHh42w2EJtXwFJiwZcp
        zBC2oMTJmU/AWpkF9CTaNoKVMwvIS2x/O4cZ4koFiZ9Pl7FC3OAmca7hOBtEjYjE7M425gmM
        wrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm56bbFhgmJdarlecmFtcmpeul5yfu4kRHD1aGjsY
        783/p3eIkYmD8RCjBAezkgjvvFvZqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8s
        Sc1OTS1ILYLJMnFwSjUwbRKQ830zU+Zd1Z7urYohBr9qiw24/+Y0uj6UurKr+sCrs9OceM33
        bGhul5+lYrDsja3rN6One7+Vlj7Zl7bnbdr1a+vd365dKZ3z2Ijl6MIlRWoXevs0uYx2HkjK
        O6zVrx7JkzYtj2/am78l99p67vsfq5jtfP6sb8x57WvrpVp6eyJjdl1o/fTrWXxm4GHtV9uX
        R6T6XmIyCq/aNnF74NKcsOApFhsW8/AfqbrnruNxw/Lu3T6+rUYXC2r49R6eClJ+HOl7zkMx
        nbl+XaD2YlW5o6+61z+4cprfvo5jwb+Zy95nT5i3+msU0/npRU6HlqwJmRG9XbyTz86luf6/
        AndWo/++zwIXVLcmTNCuUGIpzkg01GIuKk4EAHtFxmUNAwAA
X-CMS-MailID: 20231204123254epcas1p3d8a707048621f2356c79ab064e69cf20
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
> Sent: Monday, December 4, 2023 9:09 PM
> To: 'Lukas Funke' <lukas.funke-oss@weidmueller.com>; 'lkp@intel.com'
> <lkp@intel.com>; 'MyungJoo Ham' <myungjoo.ham@samsung.com>
> Cc: 'Lukas.Funke@weidmueller.com' <Lukas.Funke@weidmueller.com>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'oe-kbuild-
> all@lists.linux.dev' <oe-kbuild-all@lists.linux.dev>; 'Lukas Funke'
> <lukas.funke@weidmueller.com>
> Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
> on device-tree
> 
> 
> 
> > -----Original Message-----
> > From: Lukas Funke <lukas.funke-oss@weidmueller.com>
> > Sent: Wednesday, November 22, 2023 5:08 PM
> > To: lkp@intel.com; MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo
> > Choi <cw00.choi@samsung.com>
> > Cc: Lukas.Funke@weidmueller.com; linux-kernel@vger.kernel.org;
> > lukas.funke- oss@weidmueller.com; oe-kbuild-all@lists.linux.dev; Lukas
> > Funke <lukas.funke@weidmueller.com>
> > Subject: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
> > on device-tree
> >
> > From: Lukas Funke <Lukas.Funke@weidmueller.com>
> >
> > Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on every
> > interrupt controller (i.e. arm64 GIC). Replace flag by a request that
> > depends on the actual device-tree setting.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-
> > lkp@intel.com/
> > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > ---
> >  drivers/extcon/extcon-usbc-tusb320.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/extcon/extcon-usbc-tusb320.c
> > b/drivers/extcon/extcon- usbc-tusb320.c index
> > 4d08c2123e59..140ab28dbd36 100644
> > --- a/drivers/extcon/extcon-usbc-tusb320.c
> > +++ b/drivers/extcon/extcon-usbc-tusb320.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/usb/typec.h>
> >  #include <linux/usb/typec_altmode.h>
> >  #include <linux/usb/role.h>
> > +#include <linux/irq.h>
> >
> >  #define TUSB320_REG8				0x8
> >  #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> > @@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
> >  	const void *match_data;
> >  	unsigned int revision;
> >  	int ret;
> > +	int irq_pol;
> > +	struct irq_data *irq_d;
> >
> >  	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> >  	if (!priv)
> > @@ -568,9 +571,17 @@ static int tusb320_probe(struct i2c_client *client)
> >  		 */
> >  		tusb320_state_update_handler(priv, true);
> >
> > +	irq_d = irq_get_irq_data(client->irq);
> > +	if (!irq_d) {
> > +		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
> > +		return -ENODEV;
> > +	}
> > +
> > +	irq_pol = irqd_get_trigger_type(irq_d);
> > +
> >  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
> >  					tusb320_irq_handler,
> > -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +					IRQF_ONESHOT | irq_pol,
> >  					client->name, priv);
> >  	if (ret)
> >  		tusb320_typec_remove(priv);
> > --
> > 2.30.2
> 
> 
> Applied it. Thanks.
> 
> 
> Best Regards,
> Chanwoo Choi


In order to remove the build warning, I changed the variable type
of 'irq_pol' as following:


index 140ab28dbd36..cec1889549a6 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -516,7 +516,7 @@ static int tusb320_probe(struct i2c_client *client)
        const void *match_data;
        unsigned int revision;
        int ret;
-       int irq_pol;
+       u32 irq_pol;
        struct irq_data *irq_d;
 
        priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);

Best Regards,
Chanwoo Choi

