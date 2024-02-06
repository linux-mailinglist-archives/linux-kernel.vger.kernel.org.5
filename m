Return-Path: <linux-kernel+bounces-54431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543584AF25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817B51F2318C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F61292E2;
	Tue,  6 Feb 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="d+O9aWUz"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE47319C;
	Tue,  6 Feb 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205368; cv=fail; b=FND4isB4Utm08mwUUyJeXHcZ7KmQtKvGU5QQ2ezYwK8bMPVZF1zb1B6yhjFzRniM+5AbLsmPC7Ho3bbL16gyZUI9t1hZCc4/4deMmKbcCLgefo3rHBReKC661QkhGmbaFVnwD60OKZYDeZTylJ4BltpPz2vA9BZGBnas173Etaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205368; c=relaxed/simple;
	bh=bf2+gSmKRIs6lpi0Gf8drZn6p743uzud3MnX5GE3oBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FCo1r95G8i+wJXdAHD1ftTodFg86k3g5II9FBSVMEnhE/HRUeGkqRNrCq8nl1LOpz69ti1irxvm0+MqJnEgDuEPD8/MvZR8aK5cZDupzUXYHPBmfc/YcXzyojWSNNHWSdvwpOJb8T792yIrjYPU5zAvdiNLRPiaZygP9ndf7C04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=d+O9aWUz; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415MqHFj027190;
	Mon, 5 Feb 2024 23:42:19 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u81a2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 23:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yta+oTVjO3r8SvNGcR9puz1RefDc7QqVWuvxp0csTCwiartN/94DJiP+g8Xq1yRB4tR0lgezFkjYXAlJ5ul7NGLjohy1F7bU86X44EXyNjO2QN+KLd7yLedHNAa+3Z4t2t3owt3cKOHLgRlhmC1qIfwIRMriCpjHkmwadGgEvpPz90L8xu0JLyo5ONcRrFsRmVEk45JIxFtrvjExbxRpJdL1bX4Mn4FHDxTZfKLXiqfJPgI/dva2j/css7fFPuuOq/hAp44jEVDAxa9UQdbhjU+yTkb99Cw7pSKid4TC/RmpmGUfFIUtA4nD4/YB6wSGb+hZD5tnIvkUXAMDYFT/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSzVsPVfh3tUp4hJhRbZv1r0rdA6P6PsKtkSyyDJ+h4=;
 b=RxTfKShVLev5CzkNZ5tZ1rR6h6YWla5iEe9PmaFmgQXcTO5OxXyJEsH/VTWmms2jI+QyP6BDVguKnP2/eWpg35ZiYwPHuBFTCYwec0x5qWkEnnV/RcdKt6bMf9AqjMv3THL8FiNS1yhCl8Ojjf1tyTjBGVXD/J4QOI8AOKrF2wCUm/Ki5mUN34JRMf7WVzLimgmJdWVQfmY0176b1Zu4HXxTc4klLY4aviCO9kALaG/XzIoM4I/GA+gZbrjEBbAK4nwi7oplC44Pz6bIm38CjAZaByYlF15e/ovIBZlyyl5o1uqnI4CgQ3tx1AUnTG+3nLP5ltKyVkdhLmS9KIgGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSzVsPVfh3tUp4hJhRbZv1r0rdA6P6PsKtkSyyDJ+h4=;
 b=d+O9aWUzUPjjUYDGUteLtw/eig892OJK5hMi38qg52NMsuC5kp8Ah2tV/fTbSOPCo5ZGASqLCmWGEvIbg8XW8a1L5sj5tNZjozhOKTJbgNM/nhtHYJjqCbwCxj24GDL0WKhiDNioJRLvqSBLxrwwPAD7EbcpGnNTC11KHB82JVI=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by CO6PR18MB4018.namprd18.prod.outlook.com (2603:10b6:5:341::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 07:42:13 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 07:42:12 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
        Sathesh B Edara
	<sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jonathan
 Corbet <corbet@lwn.net>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Tony
 Nguyen <anthony.l.nguyen@intel.com>,
        Joshua Hay <joshua.a.hay@intel.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Brett Creeley
	<brett.creeley@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        Jacob Keller
	<jacob.e.keller@intel.com>
Subject: RE: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver
 framework and device initialization
Thread-Topic: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver
 framework and device initialization
Thread-Index: AQHaUnB8V/UVqVyNZ0ObKemnEj9BQrD0okIAgAHlTwCABe4pAIAAWMHg
Date: Tue, 6 Feb 2024 07:42:12 +0000
Message-ID: 
 <PH0PR18MB473460118D0FC68BE4B3BC45C7462@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
	<20240129050254.3047778-2-srasheed@marvell.com>
	<20240131161406.22a9e330@kernel.org>
	<PH0PR18MB47345E3ADCC35D0ECA763DBBC7412@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20240205154448.1c5a5ad8@kernel.org>
In-Reply-To: <20240205154448.1c5a5ad8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|CO6PR18MB4018:EE_
x-ms-office365-filtering-correlation-id: 1c364ca1-e45d-46fe-e9cf-08dc26e721b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YiwBuvdLjFeYQXFFhdz+uXVoGi7dx6BqmHDA1rDJcJz6nUyNtEGoPw8QWw3oZcogxBUSitazpfzi6eylXuwebmERF8mg5CtXRowr6aoG1Y37DROG7ISLdBQSoFf397dqMRPPvQQun9H7MWS9i+IzEC1BxJkLc7jjDCo4CiPQw7uPsB7ez7KwNdcFf6yT80m0mmRqkftyiRyI/pNdvLA+aw6nMCF+0MgDYlTIKcrZFKKnEsV7mnWlG2F6veRDPG5l/tecBxlDF1Wc4uuLixB3B01DP59xKvuczL68IVTEA9xnueSsJOxi4XgfIibsTaZ9yZ/3MMRtlrBIxfjRQYwbj47ARWgrugWyV7U0lq9Sly/4sVnDcQ0U5hiE1argvLTIkRhzoTrLCwlIPn2cdHECpzvQIQOgQE1XemLz0/DdPDa82LcapfW9NVA13yht2wlgg2BDZ2fmU7uG2MPRfXBsaBYs0KA9GK/yMW8vizLZzXXnR1JXzabBLjZyHj1k/o6coiDBRURI1eSP7CAW11gy+EOEbBdY8U/Q18VyXAuiFJjU/eVQyurFBMhiBk7bEiIlqphjJWj1qaWoq0NsaKI5PT5V4JLDHgrXB4TDbUg3ZUMmQ4uYy9dmuwRH9FKVn0qm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(33656002)(53546011)(55016003)(122000001)(6506007)(38100700002)(83380400001)(86362001)(26005)(41300700001)(9686003)(8936002)(52536014)(4326008)(8676002)(7696005)(71200400001)(478600001)(7416002)(2906002)(5660300002)(6916009)(66476007)(54906003)(38070700009)(66556008)(64756008)(66446008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?rZvHMH5gy90d4GIwUwiKXZ+KSGdraCv1ynscad40XjuFl5o2uOFQIP8BW4cc?=
 =?us-ascii?Q?8b4YFd5m0spqJ1Zyz7Nrg8v/JhJojfMcvzWdE1KX8e1wdCBENF4JGWS9PG33?=
 =?us-ascii?Q?zUg0XbXfBuJ2wxC7ghp71N7xsbxcyWB5ctP1OV+sGW+LnuxiyuE1qGjrAXQD?=
 =?us-ascii?Q?IKKY5Tk5bomYYl/tcsK+MCf+SKepEH3XsA/oUqOeQ0lE+pqz1qmSVHvF5bPB?=
 =?us-ascii?Q?h+eszXBB39NZIlGXsP91yTqWymXUuxyS8dB/ULhuuHt+iX/mgrBgKiJjn9N+?=
 =?us-ascii?Q?L9Up0hWHHqKQMJFIyuwp8iZGrHl+1iZR80kaw8YSToIsghRzuUCcbjVS88CW?=
 =?us-ascii?Q?QoTKAtF0UTBgTahQSqRy8/1AqazHgAW/+btpg/gQJlSlZRyzOOuhks4+5baE?=
 =?us-ascii?Q?NTsS59jk/W9oKZ7e/O5hptjJZEVG61pLH+BHd1HTkanhGjk6zRKBMCq9YyJH?=
 =?us-ascii?Q?n23xHnCgX4bcYxjUOG1TZWTlC1bl5GjaTb0EAdO+anQ9LFsaV/DFZbGF8vpx?=
 =?us-ascii?Q?bu7dLIsEIHpxtQHcVeoNY6E96D90iIS6Q4PzLhEm6vBH5znZx9pFaA8DNv3/?=
 =?us-ascii?Q?KG+qr2MIsjFXHUION0vsS0qTjRFZlx190zi7ndUC1KXkvgMZLmnl1ddqDRYW?=
 =?us-ascii?Q?MHiuu/k+Plj6btRxDCh00pf7TktmTvGEuP0+QfyLROAzoJqEfxW+O2Vwv6DA?=
 =?us-ascii?Q?2EZ5qiCwp+B8wvS7PgQ25iJS60bOCtX36lSK42eoPYBcTeNUtY6pNr2C4OQp?=
 =?us-ascii?Q?YmuhZN5AiljlDQPJ8OAVWkxO2v3uhQTlnxMXj9hg5h5xzqIAwepkHEZQmacV?=
 =?us-ascii?Q?gNn/2kZ71yJ7G81VCy4Yn9F88KhJW3lYW0gl6iWtq4I9N35A7xITCcxYZ4fS?=
 =?us-ascii?Q?+oLPPaiW6dlDYJxqCPedyNOadYTrpqKdeNtTnr1eAPh4lc2s+vd+nCoQR2BI?=
 =?us-ascii?Q?2ITT21GcytygheyaB+5oAaV6adCUf/aX1H8/thjH1Fn8adnPjZqoO7SSa/tT?=
 =?us-ascii?Q?sxigkQPijtaWy3uHszkEWx7hsk3Nle9Zybt7pRIeOVyAe2g9gmdBZQLDeEQQ?=
 =?us-ascii?Q?VxUzOC2YZri1p9vp65n8Q/hRbncW4FYEvM9LFS/Lr5Tvf9JW4y1sC4qNXym+?=
 =?us-ascii?Q?GDw7+rtwEBoX+jwKSQeRIFcNtmpil+EDXb9p68iHbfqWJ1g6qPQjSQlg2Q8Z?=
 =?us-ascii?Q?iPyc1uT7rUdShAG/lPCcz6PZeQqrKQ6NIh+E3lLWJD/5M26EagmHGjkZpnFG?=
 =?us-ascii?Q?VQCO3Oqx/kGjKTlbR25Wg/l+zNu3VklBsUerxIgvJXpM7zGZmk3yBnG2SmyH?=
 =?us-ascii?Q?IDreNg7+z11dWMUkUN3JmUh7mDbmrUa6hrnvhtgM4Wr3grrh//y+3AEzJcf/?=
 =?us-ascii?Q?isDT32wWHPDq+EwqEQISwlEFmtHhooPdF0K8VGBeb/skaaG7MjTmHTKI+x06?=
 =?us-ascii?Q?TLNSl2je0cSZmMPhfIWNq8QAbo/4BHut3ehRJCqjodjzibwbqz1rrPjaYbEL?=
 =?us-ascii?Q?Pj6BFVTYNBzRIOyGxx1g+l91AUEV7bUO18uaEbwmJHyVCLeOQBdCGL7kXTGH?=
 =?us-ascii?Q?pvsD8smXniZIH2p026zYg7+Srx4juAxK2yyBZtBc?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c364ca1-e45d-46fe-e9cf-08dc26e721b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 07:42:12.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWkgvlDr0bL8Vtaolnc3CyAU0IDz1wM5LAAxinDqXyP4CcnrqpxdwFb2PeizZx3mNqX2HFaE1vejx4Qe9UmQtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4018
X-Proofpoint-ORIG-GUID: 9-15Dx6LyKbBCVZ93uKukLfvY0v6Tb0i
X-Proofpoint-GUID: 9-15Dx6LyKbBCVZ93uKukLfvY0v6Tb0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02

Hi,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, February 6, 2024 5:15 AM
> To: Shinas Rasheed <srasheed@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Haseeb Gani
> <hgani@marvell.com>; Vimlesh Kumar <vimleshk@marvell.com>; Sathesh B
> Edara <sedara@marvell.com>; egallen@redhat.com; mschmidt@redhat.com;
> pabeni@redhat.com; horms@kernel.org; wizhao@redhat.com;
> kheib@redhat.com; konguyen@redhat.com; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jonathan
> Corbet <corbet@lwn.net>; Veerasenareddy Burru <vburru@marvell.com>;
> Satananda Burla <sburla@marvell.com>; Shannon Nelson
> <shannon.nelson@amd.com>; Tony Nguyen <anthony.l.nguyen@intel.com>;
> Joshua Hay <joshua.a.hay@intel.com>; Rahul Rameshbabu
> <rrameshbabu@nvidia.com>; Brett Creeley <brett.creeley@amd.com>;
> Andrew Lunn <andrew@lunn.ch>; Jacob Keller <jacob.e.keller@intel.com>
> Subject: Re: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver
> framework and device initialization
>=20
> > > > +static void octep_vf_tx_timeout(struct net_device *netdev, unsigne=
d int
> > > txqueue)
> > > > +{
> > > > +	struct octep_vf_device *oct =3D netdev_priv(netdev);
> > > > +
> > > > +	queue_work(octep_vf_wq, &oct->tx_timeout_task);
> > > > +}
> > >
> > > I don't see you canceling this work. What if someone unregistered
> > > the device before it runs? You gotta netdev_hold() a reference.
> >
> > We do cancel_work_sync in octep_vf_remove function.
>=20
> But the device is still registered, so the timeout can happen after you
> cancel but before you unregister.

There is rtnl_lock inside octep_vf_tx_timeout_task (the work task function)=
, which can protect
from unregister_netdev, for such cases (code snippet for quick reference be=
low):

static void octep_vf_tx_timeout_task(struct work_struct *work)
{
        struct octep_vf_device *oct =3D container_of(work, struct octep_vf_=
device,
                                                tx_timeout_task);
        struct net_device *netdev =3D oct->netdev;

        rtnl_lock();
        if (netif_running(netdev)) {
                octep_vf_stop(netdev);
                octep_vf_open(netdev);
        }
        rtnl_unlock();
}

I hope this takes care of it? Please let me know if my thought process feel=
s wrong. Thanks!

> > > > +static int __init octep_vf_init_module(void)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	pr_info("%s: Loading %s ...\n", OCTEP_VF_DRV_NAME
> OCTEP_VF_DRV_STRING);
> > > > +
> > > > +	/* work queue for all deferred tasks */
> > > > +	octep_vf_wq =3D
> > > create_singlethread_workqueue(OCTEP_VF_DRV_NAME);
> > >
> > > Is there a reason this wq has to be single threaded and different tha=
n
> > > system queue? All you schedule on it in this series is the reset task=
.
> >
> > We also schedule the control mailbox task on this workqueue. The
> > workqueue was created with the intention that there could be other
> > driver specific tasks to add in the future. It has been single
> > threaded for now, but we might optimize implementation in the future,
> > although for now as far as to service our control plane this has been
> > enough.
>=20
> I haven't spotted the mailbox task in this series, if it's not here,
> let's switch to system wq, and only add your own when needed.

Sorry, my bad. The only task in this workqueue for VF driver is the tx time=
out currently as I understand.
So, yes we can switch to system workqueue for now, and maybe change if furt=
her on such a requirement emerges.=20
If the previous comment is okay by you, I'll put in this change
as well in the next patch and submit.

Thanks for the review!

