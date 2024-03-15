Return-Path: <linux-kernel+bounces-104255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9F87CB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BF8281AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905E1863C;
	Fri, 15 Mar 2024 10:24:52 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2105.outbound.protection.partner.outlook.cn [139.219.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4218059
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498292; cv=fail; b=LUDb/1+JFaaU81BJEYXWr3shfQcvbDP+G6tQ7h3XkiMxozvkKxYmHIUtQ1TEX6GlrjDFhp3IDNAgAUdnj/bzE+s1cVIreReXA6RFohuhIDo50HmRvwsR4L5fJEHGSFagcotpal6i3wuH2b1rsBA+e+zJhsKum/eCMFSZGGBu6F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498292; c=relaxed/simple;
	bh=8GLUygUeTYeGzFDVDz5tdZRuhYiic50+nAkYCLkEO0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDIhqmBGbkL5C2lN4lcY9LNuoVSqW+vG8LvMOWOsTY4HFFs8gK+XLutmmIEpwJfrqP6gt4wQsmKmYBxbgom5jPUYGKNH/baRCJOmNeIhX9UPN//hgxGlsL9mI1BYUGczN0O8BQxOCLgZXRin+Y8hj7bOBd4vEX1H/OuRukGTQGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAbStCcFrFMZyP+SrMWW23JGbc3yWTJOQ0DVAVfPJi2SVEqzESqvubODuddKAX+wGEdg6uph39hL/rUKhjY6wviwYxwWSn63TMjXJQ55gVSnkTRErCIMrysi75QIT9rOFpnuVkInWcGyGCzZRUiif1k1MryBlD2p1bdu++nZVBugtIL0xVdzHg+8seFdoqzKtHL3RSxViA4+KHmADuW8a6alZajzY4JqSi2fH0pRPGoUjlv8i9RfqfEzNnT+FwW9J4oc0dgMcc67it8CJwPreQittE59ELWJaWFliYQSILROaTkNLwoHGWER8SAgKFRqJMlp5mcRacq7pRUkvzjseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muRXkRjsYyKJcNcIW7cgyLFD22BgLYqO3kQFrknL8/E=;
 b=jqOzUmo4d8SMArDyvHauPrguATG0gF2omsg0Xw61r92OBJBu3cu35E7PyMPZtvi8g8hek3YdPrgG82+BrPW7qxIc9C49twtBt0zh3YdZLSLckM+Cr5+UiP8XxFY7zyexMK8/V55AfL82mgpi6jM3tzVO1ZKZReQRtuXAvsDYo46mYZQx4XmZvjsh/3ND98Jn8PVSd96wowGwZY3CocXBMt7rpwfka7kysDk5vqDQ2MOZ6yxV5dgCxJAUbEPwUawz8xFuqTU8kdku7Mus+fAy7I65ntY9KxpK8Ksws3XALWmSieO3tBXXH9cspphlhApSw/n2TF8lVGzJZ9XQ2mOBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0459.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 08:05:55 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 08:05:55 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andersson@kernel.org" <andersson@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH v1] i3c: master: Enable runtime PM for master controller
Thread-Topic: [PATCH v1] i3c: master: Enable runtime PM for master controller
Thread-Index: AQHabmvVHa0TJLr8CkqxZnQVcFD1ubExREqAgAc9zsA=
Date: Fri, 15 Mar 2024 08:05:55 +0000
Message-ID:
 <SH0PR01MB08419B8683E8F2DD05A791BBF928A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
 <b61f5f4a-7931-411d-9519-bbff1b7fd6f9@quicinc.com>
In-Reply-To: <b61f5f4a-7931-411d-9519-bbff1b7fd6f9@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0459:EE_
x-ms-office365-filtering-correlation-id: ad174501-93bd-4792-6f17-08dc44c6bd6d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 10aSS26U5MYPSe8mJqc9zxYY+zOTiYgjUzs0eOdNyBhQ73gj+/2HKs5GJcSBPAwAo9yejRpZZsPRNXegXn/ipMgjWdOf7seQteEVknpfQxC1KUm/oSVgtNv8YAUpPRd8x+f9tdC/aN1NQGPG4U54md4oPmZfMhEapXanB8ZVQszc7Dfr2yyVrPeDXmSgE9kk2IRl7svCYMuYEspGx9+26VJzl8cp2g56QtUAEz4FKmG9U66BDP6oSitU9h613puhqyHvrWyvs0r5FLLFhLAzsCA/+D9JDJUPXrHS6Hrt351AzIzAZ8qdy4gnSnK2NSt/9Q2xr1DJjutYu0GkwurBIYEAwWlZ6dHPKPo2em5sfklhdrcrL45hY9dz09uzWJHGcszwymSM8cUM/bX8yIswIo85XFS3M6pnWE93PLi5VA7DRSbCAWi9BVzSceHdiKJWFuTGZcvEl/X3GVVpq2QRFWDIaWaMmVdHjYu4UW5v9gTltlfQkcEBRw1aDQCsl1LkqBlOhQmIubusTxO28mzgm70QpLTlLijgl0pUE7NKP5yjOwkqy9jHq5/61KhDJSzVdnWHTvVHVnQNWwjj5LwZPZYOmotPWtk9AJpSuyP7kT3YgmbUTKDEDJFoi522obvt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?APJZdD4FUyd6kzdLBfQYqN4yuUhy9sUJMKBeLnAXRIUvFot+IrG/OWlPCNuS?=
 =?us-ascii?Q?0qmanwFP2gk4i/SS0Oaf1rej1DUOLZpcpwPcswr2Iapinzh0QvqOAHuiblxq?=
 =?us-ascii?Q?9g0EKtAXCnPOlpD6TbrLRubo8YsziCmqZ1aVjhyvDHv3kupvVQQqJ72Zp/0w?=
 =?us-ascii?Q?Hm6TXnFVQMLhEtW/H7aT2Tr3BNMZp9ZI7wSBFn2cGfuxYJFTZPGEpoTGgKA9?=
 =?us-ascii?Q?0sYNlBaK0FW4gUGhO1rC3f8DRcoFVyqlrzGmNidbxmA3c4ECkodRfi7eKyk1?=
 =?us-ascii?Q?i54OznWNMQuzpTuzg7T4TpR04Qw8GNNBSzu0ZNzaY4rOC694pxEZ0rHhHZEQ?=
 =?us-ascii?Q?Q4mh/wFpVPrOk3lGMFMMi6Ws3cVugF8Zc+U84t37nk5a/FmI2TJEyhMGeiem?=
 =?us-ascii?Q?9F42qZ151TPRktEnQj/z9DaiTPyq+/KOiS3PGSTtvIdxEutJD7wLqe8emEQW?=
 =?us-ascii?Q?bTbPY9VokD+aGZo6gkq8ehmTVmeO70BbdnvwptXK0M2kxuSLZOTJ56U4B8x+?=
 =?us-ascii?Q?TgH3tg6T5H1xmYt8l2SNIQbQEIM8HaPY8ZmgVjqKLEmpqQGtrWjfC1B9ulQ0?=
 =?us-ascii?Q?OCnoLvzx3MJvjjNaUn63OEV1vD/BVS6WcnpwUg0HXiWNXJsMQ6trNa8IHlhk?=
 =?us-ascii?Q?nVmzP5OqghDwbYgK2tNdoX+vQGZq+Obs81Vgca2gSP2FxkLCz0BtM8LsAXZ4?=
 =?us-ascii?Q?/jEvVS5uC0DVnjfJB2t+draKE1VZ3hU1wtkTCuVbsZ4OF+D9uNRbX3UAjiJx?=
 =?us-ascii?Q?H9NIpIX8DvB8XL2ccbgSwP8zEPWnaC2aShw5iaOfQxOMiunlZ+frT1yBYUW5?=
 =?us-ascii?Q?3i9aYgRSke8hHCaK78oWpKMPgXmsTq532q/LRhQ7PC4N7mXnC6eY3NoI7InH?=
 =?us-ascii?Q?acBj1qYu893ujBHID5bGkVhzx6RsAGiNzUA0lB7UgCuKNveQu4i8qxpVQhOI?=
 =?us-ascii?Q?hC7o6Ps8MXsrKwsTlIpTuY5bleNSsTh5gBBYacirxtskVw8AlMMeVsDioZxh?=
 =?us-ascii?Q?ekGJBIvfNhlLH4dibcw8O0x1hLr5D2DbIa9ZRCxmhS87VG6lZL+r/MFVZXsk?=
 =?us-ascii?Q?5NIWe5oVmaT/x/yOOu4ZFXQ4ADdgtfTYxnXDl84CusDzY20+aMOOSxWPaYoK?=
 =?us-ascii?Q?yXtYcbDYCnL7gy2dPfKbkAP4XE3Q1R94q7RdcOK/PeEAUjpHQvA+9pZGrPDo?=
 =?us-ascii?Q?t2BsFNo0cEW3JTOgbgKxFcJJyJpPvKshNIF6Ir63UtFDJisch1h+TExfVt5D?=
 =?us-ascii?Q?WknUczdkqiD23/rXUDnC+36CJ6y5GccMruuouvJwReFWz/tVjBXjSyG9Tzbw?=
 =?us-ascii?Q?uuYZ2mS9nKW48qrSfDhtb+xyi3GVTslwe8w4tEKgczCs0dtgIyFQcpl2I17K?=
 =?us-ascii?Q?QqpiZTiDCAyDZGUZKE8CvRLB65shmgVCB/p1KN2L7wUpIMwnq+j96tbhycin?=
 =?us-ascii?Q?EXjJOIZfz3tOV/aDfzqZCDQZDDEUa1aJH1J4XEo4W5kPwFt4W5iv1hhFr0Mn?=
 =?us-ascii?Q?LK86pHnFIs6qfFO3G7bSz9PgCowGnazKtpy4AtBxvVyPgSS9l9+xgp1TstkI?=
 =?us-ascii?Q?RTWUf23k8dnkKLNN7nGhAjhMO7d4r1/dDLqL5E3ie/QOxYiuZxVQUMEDTWt5?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ad174501-93bd-4792-6f17-08dc44c6bd6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 08:05:55.1465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLTBTpcoCahpKjc1ztLO4PbQqnV4w+XthMla5v8RHU1qjzw9JuRnza/t4h/gLeIFQj9wXbGvhWxbCYjsNstsYSyYdzFGe4igPtzZtwDBPLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0459
X-OriginatorOrg: starfivetech.com



> -----Original Message-----
> From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of Muke=
sh
> Kumar Savaliya
> Sent: Monday, March 11, 2024 1:30 AM
> To: alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: andersson@kernel.org; vkoul@kernel.org;
> manivannan.sadhasivam@linaro.org
> Subject: Re: [PATCH v1] i3c: master: Enable runtime PM for master control=
ler
>=20
> A Gentle reminder ! As i was not part of the linux-i3c group before raisi=
ng this
> gerrit, might not went into right folder.
>=20
> On 2/28/2024 3:04 PM, Mukesh Kumar Savaliya wrote:
> > Enable runtime PM for i3c master node during master registration time.
> >
> > Sometimes i3c client device driver may want to control the PM of the
> > parent (master) to perform the transactions and save the power in an
> > efficient way by controlling the session. Hence device can call PM
> > APIs by passing the parent node.
> >
> > Here, I3C target device when calls pm_runtime_get_sync(dev->parent)
> > couldn't invoke master drivers runtime PM callback registered by the
> > master driver because parent's PM status was disabled in the Master
> > node.
> >
> > Also call pm_runtime_no_callbacks() and pm_suspend_ignore_children()
> > for the master node to not have any callback addition and ignore the
> > children to have runtime PM work just locally in the driver. This
> > should be generic and common change for all i3c devices and should not
> > have any other impact.
> >
> > With these changes, I3C client device works and able to invoke master
> > driver registered runtime PM callbacks.
> >
> > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > ---
> >   drivers/i3c/master.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c index
> > 3afa530c5e32..a3dc88974f92 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/list.h>
> >   #include <linux/of.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/workqueue.h>
> > @@ -2812,6 +2813,10 @@ int i3c_master_register(struct
> > i3c_master_controller *master,
> >
> >   	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
> >
> > +	pm_runtime_no_callbacks(&master->dev);
> > +	pm_suspend_ignore_children(&master->dev, true);
> > +	pm_runtime_enable(&master->dev);
> > +

Will runtime pm impact on ibi request from target?

> >   	/*
> >   	 * We're done initializing the bus and the controller, we can now
> >   	 * register I3C devices discovered during the initial DAA.
> > @@ -2849,6 +2854,7 @@ void i3c_master_unregister(struct
> i3c_master_controller *master)
> >   	i3c_master_i2c_adapter_cleanup(master);
> >   	i3c_master_unregister_i3c_devs(master);
> >   	i3c_master_bus_cleanup(master);
> > +	pm_runtime_disable(&master->dev);
> >   	device_unregister(&master->dev);
> >   }
> >   EXPORT_SYMBOL_GPL(i3c_master_unregister);
>=20
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

