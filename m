Return-Path: <linux-kernel+bounces-28892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BFA830447
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F561C23F18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73E14009;
	Wed, 17 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UII0HGrt"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8388154A6;
	Wed, 17 Jan 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489909; cv=fail; b=YCHPDcQ5cYJeFPXxIRfZ+dNzeX5Qp2ewbjJKdYKsWoqrYwHnE7cY0KQYNpvxxKuV1umhQdJ4cXbfwyJBDUNOFhovjynH1IIC9QvibmeMGguVKqlN436beQBS7Ig54GZb5dk3mAQhSB517VtTqNbH2vPks8zK8CUeiFgW0DJEkjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489909; c=relaxed/simple;
	bh=9SOfxtFun1NfYeGmD00Jb4HAd3E0GQwiB/e06DZ6AZU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ANFojBRpGK1eRdSt6PTlSBy/tKGnODGRdxVUTNP/6DENIw71Xixp0FzjzChaCWKeUgpmKVkv8BMyc2EMZZaz0Kg1kTHq5SrO54TIhe22G8sMSFwD5C9aapv4dqzoRQsjGEAmmFhb7SFWhiRRgeK5K/ZtB1RfbwbLZmpICjDzj3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UII0HGrt; arc=fail smtp.client-ip=40.107.13.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYV+No8POAgFarmLebA/IruiSIwtluljLL3A+9MVNI061IKkseW5B1H09fyxQHJl2NJRfA8XFfu/m747j0y7H6XPDTBL3HncRkOVcKP8H+CTmtXzp2kemu14N7Fghx+hLmX/WEzMgcq2NnjN9bB6n1QyIdcVDmt2hxnfMNtkpvq/B/tqWdXeycpcAaMUJxTpKoc2Nh8G+CTn6oFj6KztGXcG6Bv+pzey6k7Cs/1rpJ1asG3mH84+tMa201FfTk0DTMdntd/+fQ89zKXWB0IiiBjl7q/ICFWbzHIucL7f9X0Gj+UsaBevaqI2eIr5A79v6yFn4DORPMRFzsCXvZLU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lumP2mqJ42TcAIbia+CoPU+HCwKtn8L4jgu0UwXyuzE=;
 b=L1skqaVVEo6XXeHYDxlYxiMf/RFHftqa6IhYaQMrv4VDfg6P9w+pMRgFla0rfyxlJA8G41NSp/xcBj9Nf9tDb1a2kQ7L8b384qqJRsOW2URKWYz8N0XOoscmPKuLXIK8ZROJrNDshGNqC8LzadighLUXYUZsZiVNH8ztMtOeFfj0M55qpyEmq0ad+fvVKYwcpo8JlCcXUxQb2QyuHTaKFNHzXNxzth5bhd5HIrD9acQgBxsndChuQRMlTvtF4BTRHALZMqqRx2OXPA6+OpNnGxgEWzdK7RT63u51kRb3kAm4lc6i+40DjbcO1QVyO9pXI3thwyktwserb1MDND+jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lumP2mqJ42TcAIbia+CoPU+HCwKtn8L4jgu0UwXyuzE=;
 b=UII0HGrttxw4nVbxsDlSiZbkAC++sWUUGqOZLlRdli+CeNgMsowQBbTVgr1Twd2ZeOywuTjaHPNEJuP24ud8+7U6j0DtirMRdzml1Jywx1LARsEQu6U8DFT8DAQPZCqS26HLkhW81Ql++AfkX7qvTwvH7kWE3PY85aBzvjM/VRo=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 11:11:44 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 11:11:44 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sherry Sun <sherry.sun@nxp.com>, Rohit Fule
	<rohit.fule@nxp.com>
Subject: Re: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Thread-Topic: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Thread-Index: AQHaSTX0VCxQE2mpnEWoNbGuyoXvZg==
Date: Wed, 17 Jan 2024 11:11:44 +0000
Message-ID:
 <AS4PR04MB969292D8951C3C93FD23099AE7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
 <20240117090932.GA3787@francesco-nb>
 <AS4PR04MB9692991FC87A8FF21E455BC8E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20240117104917.GA6138@francesco-nb>
In-Reply-To: <20240117104917.GA6138@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB8397:EE_
x-ms-office365-filtering-correlation-id: 5e21e4fb-12e7-4f35-a0cc-08dc174d16cf
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HgKOP7ISDFjDGygh7twnghN/DFe9DH7ftkd/TW5Ww/olxSV6J/xN63XhHJIglxThd3W/vkuelwk0f2U9ffeUWFqcxKfDElR1nEK4826wBZ296Kh76YMjx4jgFN4T9jwLJp9zO9/Zk3K+pkBzBK6ZNGo0fc1apYh+sWu9YmeEnYVrEEUzw1sG8rBvqxWbdApZZJCBisBFdrx9kSMwWunUM1m+gLDyb6ex+2fKR7YqBkEiq2WkHhSDr6wBOoqkjvy6d6SkEUlfXNa1NkX+YEyb5eZKKq8psh3muc4Lr/ND9MJhVpCiyrfMB584lDZl/lx3Sd2GXzwPXjqx2V82/+CJh/u0hDwYC2hNLsuBOJNhdtAMf89YyjJ5WgZoobZWS9WbKT6eYenbW4LQMRSWYXAxAgso6ieb9gvDh8rSydBckL5o+C3EgSuuN3qAogWL4bQdBuI3oEaTMfT2A5Hj2ZR+8i0hSZL3hZZHrs6xtl/9fGWJYYXsK8Bwu4zSD7EVREkwrAL1Ls5Yt/0KCDzxtpGMDSZi6slXtqX2dAMb6c0Fc+fHqwctI2dyXnzXd2TEIveo9kBVuTkAF3WX87AHYgUFLtxKCanBPa/sg+EdNcEB1oC9YPrxftV2VOJRXGFQ/5kS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(122000001)(38100700002)(83380400001)(38070700009)(33656002)(86362001)(52536014)(316002)(64756008)(66556008)(66476007)(66946007)(54906003)(76116006)(6916009)(66446008)(2906002)(8676002)(4326008)(8936002)(5660300002)(26005)(71200400001)(478600001)(9686003)(6506007)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LLkwSzDqpvXTxdH30j+zxz8/0FmM9HTQAkNtTe2Z5vLlpQBZpQ9y1NgB/bu6?=
 =?us-ascii?Q?sGgybg0oZf5+CFyac0dPTLRk22GoUDa3x84Aqmp4VcWqhEGMGU5piL0A3rag?=
 =?us-ascii?Q?1lzIgWrYin8MSmUYJZarLRY9yZMXBRCqzXspG3KkZYcLREnTInzhTMwfBkxL?=
 =?us-ascii?Q?E66ysijczixqN9K6aQ4sDRqUa49UnKvC4CMZBdbSUUDW5RH28v4tez/SeDPq?=
 =?us-ascii?Q?cz3cQz9BW7gt+VF6IpAg+L4VMW+sqMXI020a+0ue5TIp2GkR2CWcKnylF8DF?=
 =?us-ascii?Q?ZKnq8KrBCbjo5CjrIdy2m3Gstpc9OrRirtJkDvQxWyQ8la6neBFhkxjUSBSE?=
 =?us-ascii?Q?BhLRs4gl91BtAC2kZhKu5kGEnuhaQq5iydvYFRoTBN8+yb1wDRMnnUYZb781?=
 =?us-ascii?Q?LlJNbOmScmHDuigu0kccvbhoHfOVSt+jgKSt4TkO6zPvnued2qS7x9GNEO7U?=
 =?us-ascii?Q?s7BjcHp8cRAb9AesM0uqc8kHbGgzqi3SaU3le2If/CEes7HVhcyR4DjTDUqw?=
 =?us-ascii?Q?jW4tx+p/isuvqPJGpqUZapuj7RcXVqE2AYbHSwE9mRyU1uWdDizkImkfrwKC?=
 =?us-ascii?Q?B4eFIHz/vnuh/Pb9rn5XS+EgF6F2Jecnj6KNRxM28R9kjTSilFbmEJERn6Lq?=
 =?us-ascii?Q?s6DDuxEW1aUEw4gMgIMRYOXY1bziZheXotKu3HgWqLBw1cje47Brav2aMPLe?=
 =?us-ascii?Q?JBaqZm2oIr3w0GHb3x2dyzmEQgRwg9rNm7oQGkh80o5F9Lj7X4+J0QTeCpRd?=
 =?us-ascii?Q?moQrKdX9mMRUmTnfTU8rGP5vCmcseDfog6fErVgvt3DgkUukF4CCejIUp7fQ?=
 =?us-ascii?Q?LBstVsKRwix93jpgE57ZXPjXIFpwznwa12Yf/D4KrVPjqiEuAiWa7JdukTsH?=
 =?us-ascii?Q?ZAsCUwp5YfGM2/zp7PtzsQvVIab/7JZLZJIkjxRrE8yEnW+KsVhUd5OrsSdv?=
 =?us-ascii?Q?BP47HjOBf3xmjyTaZ2ujwzbmJnh5NFRclpr2RMg7KACQOh2NxnzZax1afIK/?=
 =?us-ascii?Q?dHfFSzv3nk1nQHDtLoRDXHWg/v+QUh5xsSTX75gOWD+/gY8cepcFyKMZmwwm?=
 =?us-ascii?Q?3C3cGIuvf3NkeDz7GAMpz/kBTsS54+MQ6TmHEx02jb7BCJvcggCg0ov3cUqY?=
 =?us-ascii?Q?2pDo+RIVSHKrg7cEFUOIyxSpgqo3+JWn2q6hPStCk+FSExGyRdWDCIINKJv5?=
 =?us-ascii?Q?bWRo1QF28ARRSl2m6KlejWlf4sT0GLlqxX5CvnSEUQpk2AuGwjE8dic2Yia6?=
 =?us-ascii?Q?8tcX8/9XvqpMjI5oTMjbduXesbemp/2MKZRkK6UUFvKtjlCAeKoFVOf3NeBq?=
 =?us-ascii?Q?VlOjIMt6VwE//6mPY1Bs7mx9RP82yzRk6D1lOgMkBgULsGXU+TIZSMMWVyog?=
 =?us-ascii?Q?Ejo8EmuGHrX980d1JGpH0AehobOJdF0S6j4v+vH5ddeGxkJcNi4/xHp5b9Ki?=
 =?us-ascii?Q?lvmMstDim4cJW6SZytKu0F2ClBh24CAG7a5Cpdlr6rLmWlU9ZUFRL0dhgfB4?=
 =?us-ascii?Q?ByXUEs7rKCFcuiTGmOTBLFZeTg3Cxqb8TCarT1tzaANHYDb3q+1e3WVp5uEy?=
 =?us-ascii?Q?n0PCrm4Wke6inubVWJrT/M+KFfu/QDP6nJAiJYRW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e21e4fb-12e7-4f35-a0cc-08dc174d16cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 11:11:44.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuiIeb5em/sy69wlbbAmBTJ4JkKSl4YQNWdmYFErdR9B4qzB6TPcdML61o6cAZ4eAhyqgO4R8/9Zhf2Itcz8LAMNU/xZHDJSzzLh9MlIuEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8397

Hi Francesco,

> > > > diff --git a/drivers/bluetooth/btnxpuart.c
> > > > b/drivers/bluetooth/btnxpuart.c index 7f88b6f52f26..20a3a5bd5529
> > > > 100644
> > > > --- a/drivers/bluetooth/btnxpuart.c
> > > > +++ b/drivers/bluetooth/btnxpuart.c
> > > > @@ -1036,6 +1048,13 @@ static int nxp_setup(struct hci_dev *hdev)
> > > >               err =3D nxp_download_firmware(hdev);
> > > >               if (err < 0)
> > > >                       return err;
> > > > +     } else if (!serdev_device_get_cts(nxpdev->serdev)) {
> > > > +             /* CTS is high and no bootloader signatures detected =
*/
> > > > +             bt_dev_dbg(hdev, "Controller not detected. Will
> > > > + check again in %d
> > > msec",
> > > > +                        NXP_SETUP_RETRY_TIME_MS);
> > > > +             schedule_delayed_work(&nxpdev->setup_retry_work,
> > > > +                                   msecs_to_jiffies(NXP_SETUP_RETR=
Y_TIME_MS));
> > > > +             return -ENODEV;
> > > why not just
> > >
> > > return -EPROBE_DEFER;
> > >
> > > and remove everything else, no need for any kind of retry or delayed
> > > work if the driver core takes care of it.
> > >
> > Wouldn't returning -EPROBE_DEFER make more sense in driver probe
> context?
>=20
> Yes, you are right. I was rushing to this suggestion without thinking at =
this
> properly.
>=20
> > Here, the driver probe registers an hci interface
> > (hci_register_dev()), and returns success to kernel.
> >
> > The hci_register_dev() queues hdev->power_on work at the end, which
> > opens the hci dev, and ultimately calls this setup function.
> >
> > In this patch, we are queueing the same work from the delayed
> > setup_retry_work().
> >
> > Returning -ENODEV (or -EPROBE_DEFER) would only affect hci_dev_open(),
> > which is in power_on work context, and not driver probe context.
> >
> > Perhaps, we should call it hci_retry_power_on() work or something
> > similar?
> >
> > Please let me know your thoughts on this.
>=20
> Do you see any way to get rid of this complexity? Maybe having this check
> done during probe, deferring there till we know the device is in a suitab=
le
> state (e.g. either you received the bootloader signature, you know the de=
vice
> is powered or that the firmware is loaded and ready?).
>=20
> In other words returning EPROBE_DEFER before calling hci_register_dev()?
>=20
Unfortunately no. To read any bootloader signatures, or read CTS line, we n=
eed serdev device opened, which is done only after hci_register_dev() -> po=
wer_on work -> hci_dev_open()->serdev_open().

Re-scheduling power_on work would open the serdev, check for bootloader sig=
natures and CTS line, and if no chip detected, it will return error, closin=
g serdev device.
=20
> With that said I still see an issue if the firmware is loaded by the wifi=
 driver
> and the BT driver start sending commands before the firware load procedur=
e
> is concluded and the firmware is ready. Not sure if you have a way to wai=
t for
> this "firmware ready" state.
After FW is downloaded, no matter if it is BT-only FW or Combo FW downloade=
d by WiFi driver, the FW has a bunch of it's own initializations. Only when=
 FW is ready to accept commands, it pulls the CTS line low.
So driver would still be re-scheduling power_on work at the moment FW is do=
wnloaded, but not ready to accept commands.

We could simplify this by only returning -ENODEV, without the delayed_work =
handling, but then user would have to remove and re-insert the btnxpuart dr=
iver after mwifiex driver is loaded successfully. This may not seam like a =
user-friendly approach.
Please let me know your thoughts on this.

Thanks,
Neeraj


