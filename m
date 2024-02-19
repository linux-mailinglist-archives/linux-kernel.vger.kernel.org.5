Return-Path: <linux-kernel+bounces-70799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3074859C88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF06A28138E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93B20B12;
	Mon, 19 Feb 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="IlC9/KR8"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B320B11
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326243; cv=fail; b=j4jo7eWheu6e/qWEe5su1WDdsv02ud4cSeyFRhFyipMcWrsJqvgMBlT9d7nllZggJT1yXSbn7Jhp3ppkuSEW2jtK/D8uUtdaLDtNEncEQdSMlUk7Ys1du+MLYMP+sZLtpBaWtVTg8woR9DJAqNam3l9KqjKr7FND5MjrKiMS0EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326243; c=relaxed/simple;
	bh=QeqEVAzq49wGkMdMOM1sQncTBELfGg+iePNjkaw9478=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmyhtMu4fyEk6L/nSTRQLqhuR5Lf6xN9awkXe+rBpR6ZvHERfpvTR/YQKTPQtRAOS5rs3/5YHobS1U0Eaf5ps+mtOV47QEGOBqQGAi8g8UiVTP4VmMXL7PHfVxg3i6z/bYfy+iRQYbJqO2bMbMoOHUSSBB6dNL16ZSq8b2jaEs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=IlC9/KR8; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41INFLST020210;
	Sun, 18 Feb 2024 23:03:55 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3waw6jueb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 23:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm3NunI1mGWZwoHGP2C5MlDApJNA8xzqhXPXiUgxIdQCoVtvz42A2J9zOEbtepZhLBYuKx6HepmF35fWowcDDmhuB1zKgB437EtYTGL8IUvv4Ox+4wXYKwTapbNiA06noPEGJkVGNqtZVWCaw1D6vZZi4PGKcUCDLGlxmr/P7c2E2dQKkTzeFWoRuC/WGYCO7QrGAklJycaLfPAotEgJINAyej8bjE0dG+aBGoky4ZivUq4m/jNMLJjcWWlunNzgBNvbLTlu7j/oV18wp0q8nxFOOrhfw8O2Xzn9QlkOmWI4SJJC4bVB2U3/n8Ohjc39DNGt3o0xX/zKpGtikP6DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFJQH/ws8NscT1Yg4w0Ly19I+QM78K7Oyhm7aaNU/pw=;
 b=fFNJUb8YIKCmapg1rX325RBU8hycMLnogFpHLCVmFs/Nuzua1IVxup6Om+8rIQNssN13dv1+lqzR/cge27Wv0/ICzWGqlOnp0sGNVLSu0Jkdh9Ar0Ed9UcnrxfXFwqx9YRiD1fJp0NfTI95IDCCbbQX5FPZMT67XHBQS82Xorl5uB8KIiYDewwR9rZdn5mRNw0sJrpPt+PXhLcWyNtQcbyrpKZ8L/u/hAYYPMnpt/434TOx+sKM0TJFI/xyKp95PEkNN59MwCAs1TYUQvy97ilTOiJrY5eaTzDSBz9G/w4mzLs19uSbiLnCABCugaYTp+HtdxSWtlto2y+9wtfRnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFJQH/ws8NscT1Yg4w0Ly19I+QM78K7Oyhm7aaNU/pw=;
 b=IlC9/KR84c0WoMcGWYc265Lk+PPoH2nX7njJkmdC7Y3q7ViDr+ielY/PVGr3CQFsR7RVKET2Nbr9KLOOQqlDkSWcF9Art7oIcyUAxkXPbOQhJ3RuGWN7mspFYrk3PadqENFG1VKiI8quLU5W87p7TtpnkhhYQ7sfGzoEjKmNAjo=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SJ2PR18MB5561.namprd18.prod.outlook.com (2603:10b6:a03:560::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 07:03:51 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 07:03:51 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
 dpi driver
Thread-Topic: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
 dpi driver
Thread-Index: AQHaYMOArP5lpoMc+EmpN3Y/GmE2K7EOMPIAgALrHhCAABlcAIAADF/w
Date: Mon, 19 Feb 2024 07:03:51 +0000
Message-ID: 
 <MW4PR18MB52449D4CCC0994747D8A316EA6512@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244844411A57790287068E5A64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240216103225.1255684-1-vattunuru@marvell.com>
 <2024021713-corrode-landline-e186@gregkh>
 <MW4PR18MB52448A9E37DCDB04F84C2013A6512@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024021913-aftermost-footnote-cd6e@gregkh>
In-Reply-To: <2024021913-aftermost-footnote-cd6e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SJ2PR18MB5561:EE_
x-ms-office365-filtering-correlation-id: 3b68d1d6-a535-493e-326e-08dc3118ed81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fJL1GA/s5xkQagPaumXtnjP5rSo3RNGKwmvsHl91gI6TYLC62YlhUqeKnw2b+hrG0GBJx9jCD2EJZkRQyRoHKi3ngcOKLhEaV4Fk0uJpaJ/4T0vMXAADsFPWPeNMY7mwpRPTJXWeLF4fd41Ctos2Q2+xMWFoAKZhptwfra9mM5zebPd6tjJNerEaDXXl+5lE5rg2jFo6BGWQVQ8UXT2dKrf5AgAckDq5rLDJmzWhUGbR6mlkZ+DHLl4pFQc8Kc6mocSc8lH/wPQ3AvfHG4IVOUdhkREvz8Fo2w8BMjIqpAu6YEeh1JACGS+0bJB1uQJ2DM3Y4qRYMd/HceAkE9iVVMpLaGnr7V9ec4+g+lQzatpnZMtkR19I0zuNY9za2clsvDS21MbkO+TmMDKKgFZUg03BZV38clYo73X0BmZ3vwCvDfdc7E2/nJUR/AynxcwjX557IgVC7ROVJIy7ZXwJN6sYZF1qqV1wNWXsZY/JR26L0ELvX2JKOfUZxtjF24j71c2RFrTtj7AC206iX4xKxOecrC+z/B5zZrBQvlIdVFH6Ia+egDG9guhdAiYdIBvf5mnUNSSqtJ8kh6tJxIv/GkQEZSe3tzbJDAlbbfOkAzvr9TsIPcpyrgTGl+gNdDqQ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(55016003)(5660300002)(8676002)(8936002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(52536014)(2906002)(6916009)(4326008)(86362001)(33656002)(122000001)(38070700009)(71200400001)(54906003)(83380400001)(41300700001)(6506007)(7696005)(9686003)(38100700002)(53546011)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?baj+hVAF9fU/5itpfD9LRLPiZPr6bJHQ2LwexOdpfz7yY+/r6sg1wXtZ+2k1?=
 =?us-ascii?Q?r2yHBmABXs51WyoAPgWPI+SzAU1niyUbF3w5rX8gSF7Fsg/sPTM2NEMOKtN4?=
 =?us-ascii?Q?JBLG5ojV8NgiofV6MnRarjCmvcrFfP+BolC0scIGccCdT0Mxrj52uilD1/X9?=
 =?us-ascii?Q?YS1TFvS80Whzt/tPWrnbZU8RuxE5XHs5pzMLxRZCtuCJ3vtWk54U+hL/44uh?=
 =?us-ascii?Q?03bRgBSlN52N2sWopWqGjGgGYspZiWOvuJ7Ia6J9YhsGW7ET6CVyt+isXJCj?=
 =?us-ascii?Q?OKT8UawNv0FA+8GE2YpwUlm/1Sob5wnJFPYXsxIYZv6JHWwVgwpy7mbNFzyO?=
 =?us-ascii?Q?aex6rl+KCJfISgGsWn7z6g6gZJ6Vvzcrd/Vk+QlkMPgDmeQBwjhji9eCulDf?=
 =?us-ascii?Q?WEq60h7+LakYcTKjjyrxW3Xw+Z+NPiViOl750/sG2pfXtgT0zZOAHHCgdwSP?=
 =?us-ascii?Q?Sh6JxmcpnU6rSmXbRwiOAgqXIpdPv1B98HblUivVflOrdV9SxSv1rb7S91dc?=
 =?us-ascii?Q?gr0Mswhgs79UjBh114MUCSEHDzETFrMQ0UIL4ppEiA0r1kdK3ONSKK+8vX/p?=
 =?us-ascii?Q?BC5FBav2RZRc3mNyfSc8srQtuS7Wz+JETAAdJRhjCy9eDvFSP5ER2ilHYSmH?=
 =?us-ascii?Q?DiVzDEEtf18ub/HtTKglmVZX9qrX5IWprh8c/k5Vqh5siXMccZ7BDhpSJkC9?=
 =?us-ascii?Q?lqf80ygSRc/WGT5IN3jrNrNz+W+5KnvVK2RsOEBcSQ+D3gRDR7wBRTClSN3/?=
 =?us-ascii?Q?aU7QLcFWI9eMvyAOg0wzOnunYGm2x26kZrtZk2DrivV1LWv7cAITHaXtqV0A?=
 =?us-ascii?Q?Zur/aQfUSqOYj+fyZn6zH+B2tvSaP8z37j+SannclTzOUK0gBGhb5UQO8Use?=
 =?us-ascii?Q?r1630cKE7XEWlx7f3dgMjDA/a3QyARrWuljTI0bVVUHHhr29OTzpwCpnr9S+?=
 =?us-ascii?Q?RxvduFU1Mlmwr8fi+aC+J6z6F9e3wVXIjY7O/EAEidZN0ZOuGy7aTrb8AEOA?=
 =?us-ascii?Q?WI7xganqWGTmGv+q+GwGNipD2NBF/N+U7lExPfR8ovCSEamtQICJkv0UC3w1?=
 =?us-ascii?Q?cKl8yRvj4kG2WSNwpGmstmlHF2OGQ+z0oRqRQBNJld+BQ9shp18f3A7xPR8f?=
 =?us-ascii?Q?CHl6nF08Lu01gtjcYmKs9rlnNnaXX1yFVw/LWrOH+DVnM8kMdEzLw3qzh8sm?=
 =?us-ascii?Q?IOKv+bkQsHJXqyRI0DEMi5/ufZh4iUG8XHqRMzp50lghOuga5tOOq7Kl/cat?=
 =?us-ascii?Q?6/6NEXJIgUBx+YgpXr84KxOywJ/TIe9CGYI86FFkjie7g/eM9Si7Ve7kYbtU?=
 =?us-ascii?Q?C5UIgXdvCiqG4J91+vJZiKymU5caiVQMbILmInSIobIhjCwAoJ5o3YxGU9p+?=
 =?us-ascii?Q?Y2RwcPbzJBAgTHMQ3G0O55KLWrRKUSD1pS6FmV11ICzNM4QMt1Jywp7Gp8be?=
 =?us-ascii?Q?eQ7y3DRsNSjYGiPd/ksu292/b6OrZxVf9A1S0GkyNKXov+Uvd1AOeaPqtcz1?=
 =?us-ascii?Q?f1hN51gST5Y0HvBXBZTGxP83SzrQnFNVd8bzga8yafEeGcSj6+aQMrVkFWaH?=
 =?us-ascii?Q?c+It4Feys5GrybjjrKZaLeQOl58xm7iTA1aKrX9irAKd7ECRNxOVHe6POTe8?=
 =?us-ascii?Q?Y5WLNGoAXNwBmp7wsK++sfcsQkZTvOXVaDaxZPhh9tIk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b68d1d6-a535-493e-326e-08dc3118ed81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 07:03:51.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCn4tIvGCts0BhG2W1NaMZgGmaISgNDERg5K368dGilmeeahyIHXrDVKzRkBrtW+PO/LDI4hzTIDtkOnKlrv7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5561
X-Proofpoint-GUID: AwMnCRv-VD59uIhtil-8M6V869XEhvs-
X-Proofpoint-ORIG-GUID: AwMnCRv-VD59uIhtil-8M6V869XEhvs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_04,2024-02-16_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, February 19, 2024 11:49 AM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K dpi driver
>=20
> On Mon, Feb 19, 2024 at 05:03:38AM +0000, Vamsi Krishna Attunuru wrote:
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Saturday, February 17, 2024 1:44 PM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > Subject: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon
> > > CN10K dpi driver
>=20
> Why is this here?
>=20
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- On Fri, Feb 16, 2024 at 02:32:25AM -0800, Vamsi Attunuru wrote:
> > > > Adds a driver for Marvell CN10K DPI(DMA Engine) device's physical
> > > > function which initializes DPI DMA hardware's global configuration
> > > > and enables hardware mailbox channels between physical function
> > > > (PF) and it's virtual functions (VF). VF device drivers (User
> > > > space drivers) use this hw mailbox to communicate any required
> > > > device configuration on it's respective VF device. Accordingly,
> > > > this DPI PF driver provision the VF
> > > device resources.
> > > >
> > > > At the hardware level, the DPI physical function (PF) acts as a
> > > > management interface to setup the VF device resources, VF devices
> > > > are only provisioned to handle or control the actual DMA Engine's
> > > > data transfer
> > > capabilities.
> > > >
> > > > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > > > ---
> > > >
> > > > Changes V1 -> V2:
> > > > - Fixed return values and busy-wait loops
> > > > - Merged .h file into .c file
> > > > - Fixed directory structure
> > > > - Removed module params
> > > > - Registered the device as misc device
> > >
> > > Why register as a misc device if you don't actually use it at all?
> > > That feels pointless and extra code and confusion for everyone as
> > > you have created a device node in the system that will just fail all
> operations made on it.
> > >
> > > confused,
> > >
> >
> > Module params are removed in V2, planning to use device node to pass th=
e
> device configuration tuning parameters and other ops, can you please also
> share other v2 review comments, I will plan to address it in V3.
>=20
> How is a reviewer supposed to know that you are going to use unused code
> sometime in the future when you do not say that here?
>=20
> What would you do if you had to review such code?  You would stop there
> and wait for it all to make sense.
>=20
> Please try to get some internal review next time before you send out your
> next version so that you don't waste other's time reviewing dead code lik=
e
> this.

Sure, sorry for the inconvenience.=20
>=20
> thanks,
>=20
> greg k-h

