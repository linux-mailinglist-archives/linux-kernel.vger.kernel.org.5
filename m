Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2245C80335A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjLDMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjLDMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:49:29 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAA9C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:49:33 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231204124931epoutp0112e19e8cef47809d6f84defb3736101b~dodU_arYi2955429554epoutp01I
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:49:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231204124931epoutp0112e19e8cef47809d6f84defb3736101b~dodU_arYi2955429554epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701694171;
        bh=VNCGx9Dl6MbdG/gjE2tknXBaXkzBoUBtvrgH9+9Pj4c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=btD4rzb6T31jq2jejx/HzcRJyUZO38/g3VmtetlMR5qAcSuDFpqrQdM+3kdos8akK
         FmIALffr58sq5IEhZwaO8Rxy+BXlL96dopcMSkWapW397d5PGVV2LGxbNAyEE4wzPP
         aX6GS2ofYHL2kQsbKrQwslYB+gemgfH/62DMLPS0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231204124931epcas1p1258b14dd988d4e06b9058eb47b4b0872~dodUtz_WP1149311493epcas1p1D;
        Mon,  4 Dec 2023 12:49:31 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.144]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SkNlt2WQBz4x9Pr; Mon,  4 Dec
        2023 12:49:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.77.10211.ADACD656; Mon,  4 Dec 2023 21:49:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231204124930epcas1p41e9244b89fc3d74c74d89173dcef792a~dodToYRov2681826818epcas1p4r;
        Mon,  4 Dec 2023 12:49:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231204124930epsmtrp15dc5f01dd1c718ca7896692aed64fdd6~dodTnqf192720727207epsmtrp1J;
        Mon,  4 Dec 2023 12:49:30 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-fd-656dcada76e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.02.08817.9DACD656; Mon,  4 Dec 2023 21:49:29 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231204124929epsmtip14352414354501438a15357e7d9c7dcff~dodTXuaPO0534705347epsmtip1f;
        Mon,  4 Dec 2023 12:49:29 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Lukas Funke'" <lukas.funke-oss@weidmueller.com>, <lkp@intel.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
Cc:     <Lukas.Funke@weidmueller.com>, <linux-kernel@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>,
        "'Lukas Funke'" <lukas.funke@weidmueller.com>
In-Reply-To: 
Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
 on device-tree
Date:   Mon, 4 Dec 2023 21:49:29 +0900
Message-ID: <002e01da26b0$52582960$f7087c20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIM5zhv5YhESJxix+B2YaYbT/bXQwBbQ2wPAnvXN6ewHM4PUIAABmJQgAACYWA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmnu6tU7mpBtfahCwu75rDZvGq+RGb
        xfZPt1ktpk9ZyGxxu3EFm8WhlVeYHNg8Fu95yeTxYvNMRo++LasYPT5vkvPYsmoRWwBrVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjCPT
        bjAXfDKoWHHSp4HxoXoXIyeHhICJxI6FZxi7GLk4hAR2MErc2XASyvnEKLGpdw8LhPONUeLK
        1jcsMC3HdhxlBLGFBPYyStx7bA5R9JJR4uy7LuYuRg4ONgEdiQU/QkFqRARKJc6tncQKUsMs
        MJVR4tCFFawgNZwCvBIT/lmD1AgLREt8fvKNGcRmEVCRaHlwDmw+r4ClRNfTRWwQtqDEyZlP
        wG5gFpCX2P52DjPEPQoSP58uAxspIuAncabbBqJERGJ2ZxszyFoJgV4OiXVXJ0Hd7yLRuOg2
        E4QtLPHq+BZ2CFtK4mV/GztEw2RGiYuvX0N1r2eU2LiyBWqbscT+pZOZQLYxC2hKrN+lDxFW
        lNj5ey4jxGY+iXdfe8AOkgD6saNNCKJEWeLyg7tQeyUlFrd3sk1gVJqF5LVZSF6bheSHWQjL
        FjCyrGIUSy0ozk1PLTYsMIHHdXJ+7iZGcNrUstjBOPftB71DjEwcjIcYJTiYlUR4593KThXi
        TUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cDEnVcSb2hiaWBiZmRsYmFoZqgkznvsVW+KkEB6
        YklqdmpqQWoRTB8TB6dUA5PMkYthFn/+JcW3+QiwZns+mR5dZlUbeSn6TkitzsMpS/dVdgSe
        lNCQ/2CaMMdSpX5lhskU3kUGsjfzRU4nXDIWebLhkydXrMt9yV+JXcd8LeJyym0LtgUXztap
        MXQSm+xwo1/ybEt8QF+z6Qd9+UnzN0/yf7DP55kZA4t7VPjsxT+jDZ6nHTJ9EsiX5bR3jeDy
        tF3zqw5pSTd7J6Smt/OIKvZNbLJqfeJ3/e6ES3++PJ1yUM/nrnevhtGyvp/bFRN+XrNtCjwd
        yKS/WtKpzfDZtAU3FyzdFbzpd+TXkhMHzLmSz+gsCSo94Xv1nPkSr7A0T6XtV5x+PJ6u322X
        3vNj41yxNp0ko/OXl4qvVWIpzkg01GIuKk4EAHvFcqYkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO7NU7mpBsv7TS0u75rDZvGq+RGb
        xfZPt1ktpk9ZyGxxu3EFm8WhlVeYHNg8Fu95yeTxYvNMRo++LasYPT5vkvPYsmoRWwBrFJdN
        SmpOZllqkb5dAlfGkWk3mAs+GVSsOOnTwPhQvYuRk0NCwETi2I6jjF2MXBxCArsZJe5vPMkM
        kZCUmHbxKJDNAWQLSxw+XAxR85xRYtmKpewgcTYBHYkFP0JBykUEyiXe93eygdQwC0xnlLh1
        /R7U0P2MEi+3v2YDaeAU4JWY8M8apEFYIFJi7+MbjCA2i4CKRMuDc2A2r4ClRNfTRWwQtqDE
        yZlPWEBamQX0JNo2gpUwC8hLbH87B+pMBYmfT5exgpSICPhJnOm2gSgRkZjd2cY8gVF4FpJB
        sxAGzUIyaBaSjgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjR0trB+OeVR/0
        DjEycTAeYpTgYFYS4Z13KztViDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2amp
        BalFMFkmDk6pBibJ+V+UxHTfRxkFPHrNpdAY0H+B3fJ/xM0/SfLLNDbek7u1dqZXW2BFWkxB
        iWaZ4Y+3jRMeLVGeML+kUqn1NNPaxV+vB85zZT+9ckHJndppimcO6E/kLs54lu2pJxcYU7l7
        3q9iyaV6N9+G/7wZZ7v//tK9IWnmu2Qib2YfP7I4s7VhmftJxqn9M/euZDiqzBokLyO32FBx
        ad2KO3rPdbPllhztn8R793jzjfAF5vGpjbfCcsxNk3OFJ2ZnPWE/HdFqcN9chPNeyvr8omV8
        2nkPlrD5bDQWzWzhODdPd8HZqGmWeUvD5974PmFdl+Hq1XY7dCOrfGUEXTfdl0kQ5xcs0Pie
        e7wxW7au5u4LIyWW4oxEQy3mouJEAL5/4mgMAwAA
X-CMS-MailID: 20231204124930epcas1p41e9244b89fc3d74c74d89173dcef792a
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
> Sent: Monday, December 4, 2023 9:33 PM
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
> > From: Chanwoo Choi <cw00.choi@samsung.com>
> > Sent: Monday, December 4, 2023 9:09 PM
> > To: 'Lukas Funke' <lukas.funke-oss@weidmueller.com>; 'lkp@intel.com'
> > <lkp@intel.com>; 'MyungJoo Ham' <myungjoo.ham@samsung.com>
> > Cc: 'Lukas.Funke@weidmueller.com' <Lukas.Funke@weidmueller.com>;
> > 'linux- kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> > 'oe-kbuild- all@lists.linux.dev' <oe-kbuild-all@lists.linux.dev>; 'Lukas
> Funke'
> > <lukas.funke@weidmueller.com>
> > Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity
> > based on device-tree
> >
> >
> >
> > > -----Original Message-----
> > > From: Lukas Funke <lukas.funke-oss@weidmueller.com>
> > > Sent: Wednesday, November 22, 2023 5:08 PM
> > > To: lkp@intel.com; MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo
> > > Choi <cw00.choi@samsung.com>
> > > Cc: Lukas.Funke@weidmueller.com; linux-kernel@vger.kernel.org;
> > > lukas.funke- oss@weidmueller.com; oe-kbuild-all@lists.linux.dev;
> > > Lukas Funke <lukas.funke@weidmueller.com>
> > > Subject: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity
> > > based on device-tree
> > >
> > > From: Lukas Funke <Lukas.Funke@weidmueller.com>
> > >
> > > Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on every
> > > interrupt controller (i.e. arm64 GIC). Replace flag by a request
> > > that depends on the actual device-tree setting.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-
> > > lkp@intel.com/
> > > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > > ---
> > >  drivers/extcon/extcon-usbc-tusb320.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/extcon/extcon-usbc-tusb320.c
> > > b/drivers/extcon/extcon- usbc-tusb320.c index
> > > 4d08c2123e59..140ab28dbd36 100644
> > > --- a/drivers/extcon/extcon-usbc-tusb320.c
> > > +++ b/drivers/extcon/extcon-usbc-tusb320.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/usb/typec.h>
> > >  #include <linux/usb/typec_altmode.h>  #include <linux/usb/role.h>
> > > +#include <linux/irq.h>
> > >
> > >  #define TUSB320_REG8				0x8
> > >  #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> > > @@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client
*client)
> > >  	const void *match_data;
> > >  	unsigned int revision;
> > >  	int ret;
> > > +	int irq_pol;
> > > +	struct irq_data *irq_d;
> > >
> > >  	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> > >  	if (!priv)
> > > @@ -568,9 +571,17 @@ static int tusb320_probe(struct i2c_client
*client)
> > >  		 */
> > >  		tusb320_state_update_handler(priv, true);
> > >
> > > +	irq_d = irq_get_irq_data(client->irq);
> > > +	if (!irq_d) {
> > > +		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	irq_pol = irqd_get_trigger_type(irq_d);
> > > +
> > >  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
> > >  					tusb320_irq_handler,
> > > -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > +					IRQF_ONESHOT | irq_pol,
> > >  					client->name, priv);
> > >  	if (ret)
> > >  		tusb320_typec_remove(priv);
> > > --
> > > 2.30.2
> >
> >
> > Applied it. Thanks.
> >
> >
> > Best Regards,
> > Chanwoo Choi
> 
> 
> In order to remove the build warning, I changed the variable type
> of 'irq_pol' as following:
> 
> 
> index 140ab28dbd36..cec1889549a6 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -516,7 +516,7 @@ static int tusb320_probe(struct i2c_client *client)
>         const void *match_data;
>         unsigned int revision;
>         int ret;
> -       int irq_pol;
> +       u32 irq_pol;
>         struct irq_data *irq_d;
> 
>         priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> 
> Best Regards,
> Chanwoo Choi


How about changing this patch as following?
When irq_getg_irq_data returns NULL, just use the IRQF_TRIGGER_FALLING flag
to support previous version. Because I didn't' check the all use-case
of this driver on DT. I think that better to keep the IRQF_TRIGGER_FALLING
flag
when irq_d is NULL.


diff --git a/drivers/extcon/extcon-usbc-tusb320.c
b/drivers/extcon/extcon-usbc-tusb320.c
index 4d08c2123e59..bd5ed8dd8fdd 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
+#include <linux/irq.h>
 
 #define TUSB320_REG8				0x8
 #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
@@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
 	const void *match_data;
 	unsigned int revision;
 	int ret;
+	u32 irq_trigger_type;
+	struct irq_data *irq_d;
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -568,9 +571,15 @@ static int tusb320_probe(struct i2c_client *client)
 		 */
 		tusb320_state_update_handler(priv, true);
 
+	irq_d = irq_get_irq_data(client->irq);
+	if (irq_d)
+		irq_trigger_type = irqd_get_trigger_type(irq_d);
+	else
+		irq_trigger_type = IRQF_TRIGGER_FALLING;
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					IRQF_ONESHOT | irq_trigger_type,
 					client->name, priv);
 	if (ret)
 		tusb320_typec_remove(priv);
-- 
2.25.1

