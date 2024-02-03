Return-Path: <linux-kernel+bounces-50936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747D3848404
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991B01C229CF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6D11723;
	Sat,  3 Feb 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JB8F0nvY"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9611197;
	Sat,  3 Feb 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706938545; cv=fail; b=b4Tqd2tFh5tGRkdo+ac3CTaLOjFKsuEPx7pjDCsaB8HK5HC/qKsHBdWQP9HojqZYLc4+Dj4rntD79hgiqYbf2JcjFgticw11YszoMryMIyavUuvIRXiEXphRngUCa75v0UzgIg3VkoBw88QmazKp6o5qUf3jB4CVRvQea9cksfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706938545; c=relaxed/simple;
	bh=hkFHAKuiindJCNhoMFei6qH+qlGrcWrOtfP3lW6mu68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tfS9U66M0tJe79JoM4agY+dG61s9wgPyPvpm4Vh3PtznqX0m+StynxGYrdvHMQTkAWmXq8fDFTBaj9CUZYnhV3+Su3/32V4ltXMXX2ybYdWEEUgXlTj1Db3nytlsNT/ewdBqnBwEPzTVFh4WQM85ptrvfJpKcpYjVjHaKAnnVlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=JB8F0nvY; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4134s4eR015360;
	Fri, 2 Feb 2024 21:35:25 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w1eutr272-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 21:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMgck+GaXLN5Q+9JfIAxyZhDjS4YBDFMgoa76LTSzB+Ir0532r3VyWEUXZKX7mgNNfGCMijsteIsE29xaxDGxzq3+kAtL+jfLGr3U9g4oX4KPwjFE9voxhp//oqjOpsur0zAeyHNt/R2UIy3EQqOEgyoqaNl09MwNfIbM6kpEW3iJSR42LFp2loTZSqWI00CWotjEFudCzlMESiXyfiaS7XH9QFT6E5tK2bDuTS+8P/20HN1zLEEgQWRUsMxX60UluQNwLDPZY6pvh0eXDPBfLP6K7PdrSeC9vtDjKBbnV9vrlviwF3FJEkBKmykVIp2K3pAAYtkTmOa4CRR0+9jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD5X9H+RXc0CXEIiNNfa4x53Q7WI4v9XwEXMPHo9vbA=;
 b=PlwziC7YXvibv02b7GFZtPywzY/nCVMQvqnrPGoGx2QRnf7msiJWscg8psn21k+P+sO84/2W8fwVS+qeqaKdCQsJRcg9wmtZTD5TwF5GhCgxAE5p1ERCCwQpf+mTdtptr9u1AGb4cjjNYegyVV1cAt4KPEfleSa1LqV6tvfuhlWMH7+41IcxtyjYj8Elwt0c0y60LBmFgeGOYyuCilhwk2e8wdIMoEIymaRlb40lQ5xkDFyHqoDOTV7JItGSNh7f6u/f9nIgK0v3r7bmQflLI5J0KLWKNYPZUZ9aiDxlQLJ3znYC+k3P2Y7J/RRMjP1Jn4TkMduAe/k0qqTwg1LFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD5X9H+RXc0CXEIiNNfa4x53Q7WI4v9XwEXMPHo9vbA=;
 b=JB8F0nvYn11mKxGiCVkybQ4UJfHIyQVY9QbTEdxuEvDmNmvRMZcYWIVUJxnKq+c23X9HBmXjUtHbBy00QPKorBEz2dRH4Bvc5Cl2HBaKdBn/6d4JwoxOBJYblNdirjN8kecbofiGYcRGh41pM6TzYZ0dK1jCW1v17tJd7T8oirQ=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by LV8PR18MB5782.namprd18.prod.outlook.com (2603:10b6:408:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Sat, 3 Feb
 2024 05:35:21 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524%3]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 05:35:21 +0000
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
Thread-Index: AQHaUnB8V/UVqVyNZ0ObKemnEj9BQrD0okIAgAHlTwA=
Date: Sat, 3 Feb 2024 05:35:21 +0000
Message-ID: 
 <PH0PR18MB47345E3ADCC35D0ECA763DBBC7412@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
	<20240129050254.3047778-2-srasheed@marvell.com>
 <20240131161406.22a9e330@kernel.org>
In-Reply-To: <20240131161406.22a9e330@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|LV8PR18MB5782:EE_
x-ms-office365-filtering-correlation-id: 33766d3c-30f6-4cd2-3ec3-08dc2479e9bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k6TY3nW+j7ASz7CgnpVSdlwsQUqMHEK0S5jFcSi5x09yCGLvgC2AJSGZfCk+uHXo7oOmvGDx7oxpSdxbCH8Kq9HCbjORKCXCgajOY6Ochvp1GIDP+1/sZHQOUbSFsTvdpOltUL96CvtOgGKo4RTvyq7HSJmwFjF+gFG+bAbPZ6FeiB1hi7Z4HncwMNmDj1cODX5jVLt1KM15A9YU1Wx8HBPt338DxCTtaIRCX4PbBOJ/ep//DujnHAn2SctQUbDtiPhwJPqrGWoMXS5M4oq3huR3VDPwqs0BZeb0IYNNl8R2iCVyUNdbOxu9eElWtJCWORm+98wR6T+c+lPho1e/aYrhTK2SPBg5xEPpPivpAwqCcRexNECJB3A2Ylv68YsDBuo1jjvybQ94dGXWuqLEXnSecwOiwqgAPolmjWuhXOI2zLr94WuWKiwcXc8WbFRFGIQpANbX+RyGLgZaSXwRvqDvjLf4fhcWhAu1emub9g9H+kE/9/B7AjRCTTDw7jzZzr3syNIMkal5qLVaift446D2zd5oIrM6Vh9rIOG6CfFBJ2JV5yrmawzABwYw6qCf3YRdYHBt7V4BDgUbpadqiK3U6KkVLhgzpFn+0uoQaHYRHASI9wJWObv4NYe077vg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(66946007)(66556008)(76116006)(6916009)(64756008)(54906003)(5660300002)(7416002)(52536014)(66446008)(2906002)(66476007)(8676002)(8936002)(4326008)(83380400001)(33656002)(316002)(53546011)(6506007)(9686003)(38070700009)(71200400001)(86362001)(478600001)(38100700002)(122000001)(41300700001)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6weUevXOVZCvBabXGMqTdH+0HqYX3yDKVBKnpXiulzXqGtsd1pn97bUFDAFe?=
 =?us-ascii?Q?og24Vh5qgns4P1NZ01LtKlJ+5f8rrIWaEH5hCnxvAQLFkG7LcT0OBf61z+1y?=
 =?us-ascii?Q?WPHp/QYY1cSoMby49am3cts58p9IqZ76Bix3izcvYi3jxbkaOSzr+z+x0Za5?=
 =?us-ascii?Q?xFOyY1Jh2ELjhYlwYzFdSszYit3jE7mK4rLMeKKDtlMgHBu7amjZkSk0hqJi?=
 =?us-ascii?Q?qpik89POh6dTNdScwsysJk54F3IEgqi/9a/6cc5CDHvsTGYVoBEzCu0lHu//?=
 =?us-ascii?Q?4NUg1mQnhpdVKpoqyig5DfVkNhJ/5NbD92Ggh4oFh6/Q3cA18+6prp/FGBwk?=
 =?us-ascii?Q?SAVl4gBMw9Rf41m/BEiJrSUmCa38zMUpDo7EFzeh/a6OcuhlxdXnPccTLYoY?=
 =?us-ascii?Q?4P4NV0uv9KXurkCNmQmTt3FkM77q37V3eW+iI2W84KJe1lv/6kdSH32X/EU8?=
 =?us-ascii?Q?5GNDsyUtteQ+PdmrE5hV/XPy92zk3ROOkluiGepxSJxblGUY1hopwMUqWPAq?=
 =?us-ascii?Q?uNfoOKhw9jf3m+GcanUvQH0FiUn/iq0f/zhJBHxJl+crOwMXe6O+kK48EzAN?=
 =?us-ascii?Q?ln8o+tI1rFISuYcDkoE6q8TdqyWQ+uOJT3Q6yXmv9x25reWGw35vd0JHRX3p?=
 =?us-ascii?Q?u9NoffQJm0Vaiyg/izLNOe4ad220PZTwbcLyni1uzn2rHKifS3K6IeOskOaS?=
 =?us-ascii?Q?g0bAcQAyYZraRmbVqo1atSxoL8s2QUvlY1D0n8i9FrLFyRQJq/c+9ydalL4I?=
 =?us-ascii?Q?/GodVG3eKN0i6ucmA2bj1uA98Lm5hsgZ9naAawrCAs+cBrGOOnp/KRBmj1zg?=
 =?us-ascii?Q?YjXzIo1bs77vQigZQobKoh27+zN8i5yWjs98D5dWzhkqTLSBSiXONd0hzlcA?=
 =?us-ascii?Q?QsLpX+u6q7dcBftmh12Kjec0PpLk7flfR7z/BFvWoYZ0XhixB3DFlvd7fLbt?=
 =?us-ascii?Q?B93KQl9+QJgLor1jr/BWxlQFI7awBC45PkYWgIAt/7iNzPbXX8lRbFbvxjgk?=
 =?us-ascii?Q?BpxDcughKvliblYoSp9WAdlAPrxrf8flXP5hInk3LskeqXoZvgZ7GEmMdZDc?=
 =?us-ascii?Q?Q2gAq8AYg8uNP7ifBZQRy1cV3eJ67aci8OtP0/8E4v/lQdzfsXtMDgOCp3sq?=
 =?us-ascii?Q?lN/Q/1P6Cl3M16xxetv8TLp8v24kIAcdKfjZmmGs4R5Zg91nQj1EhrPpUH86?=
 =?us-ascii?Q?A1MMLxFFrDGVM656ptK3Kq7Egn0+IZ88V7xdKOfVv6+LVm9D0knLvszMigUh?=
 =?us-ascii?Q?sMnb/73Yj8j92xBVvL8v2120lJCYxaGDJ6Fl5O7s/Kg674Ntfx8sw1/8FtKU?=
 =?us-ascii?Q?RLeTwAUBNiGAlGJXzVLS97zQTjz9hP1RCH19fqlKnRxrkVEeAe13wXadc7cc?=
 =?us-ascii?Q?Tn/wnyqM9EuC4f/aG5JR4Y9nhmY05U65MMVRKQrDQnWiKghPddm5mNaiEOcO?=
 =?us-ascii?Q?MCsOFwIZ5Hi3tCQo3+MFH/yPFQrbjQkOCFzf2Q3m+hzTMwioMsoL1U/CMJHK?=
 =?us-ascii?Q?gdUCKXPznyPwAuZPwW6pWntcNTZDnaIpZJu6rH0IyUZsN0I11f/vCZyYZ+Qy?=
 =?us-ascii?Q?02dxqjNl7XPqXg0yA9snozuu+U86WUxy9MfLK8p4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33766d3c-30f6-4cd2-3ec3-08dc2479e9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 05:35:21.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBylKEFzQNl46SCIJKbWSmW9Fux4IYXAdq/6q7mk9kd62FuvoWCywHsST//McBENrb9klNyl4zdgjQqrkhl9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5782
X-Proofpoint-ORIG-GUID: Uth1FYTaW4TkmS7h-cLbNE-OG46KRluG
X-Proofpoint-GUID: Uth1FYTaW4TkmS7h-cLbNE-OG46KRluG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, February 1, 2024 5:44 AM
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
> <rrameshbabu@nvidia.com>; Brett Creeley <brett.creeley@amd.com>; Andrew
> Lunn <andrew@lunn.ch>; Jacob Keller <jacob.e.keller@intel.com>
> Subject: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver frame=
work
> and device initialization
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Sun, 28 Jan 2024 21:02:47 -0800 Shinas Rasheed wrote:
>=20
> > +	netif_carrier_off(netdev);
> > +	netif_tx_disable(netdev);
>=20
> You haven't masked any IRQ or disabled NAPI. What prevents the queues
> from getting restarted right after this call?

The napi functionality (along with disabling it when stopping), is introduc=
ed (and used) in the patch after this one [2/8]. Also we disable interrupts=
 in the=20
disable_interrupt hook which is also called in the next patch [2/8].=20

> > +static void octep_vf_tx_timeout(struct net_device *netdev, unsigned in=
t
> txqueue)
> > +{
> > +	struct octep_vf_device *oct =3D netdev_priv(netdev);
> > +
> > +	queue_work(octep_vf_wq, &oct->tx_timeout_task);
> > +}
>=20
> I don't see you canceling this work. What if someone unregistered
> the device before it runs? You gotta netdev_hold() a reference.

We do cancel_work_sync in octep_vf_remove function.

> > +static int __init octep_vf_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	pr_info("%s: Loading %s ...\n", OCTEP_VF_DRV_NAME,
> OCTEP_VF_DRV_STRING);
> > +
> > +	/* work queue for all deferred tasks */
> > +	octep_vf_wq =3D
> create_singlethread_workqueue(OCTEP_VF_DRV_NAME);
>=20
> Is there a reason this wq has to be single threaded and different than
> system queue? All you schedule on it in this series is the reset task.

We also schedule the control mailbox task on this workqueue. The workqueue =
was created with the intention
that there could be other driver specific tasks to add in the future. It ha=
s been single threaded
for now, but we might optimize implementation in the future, although for n=
ow as far as to service our control plane this has been enough.

Let me know if there are other changes to be made (I ack the other ones you=
 have made), so I can gather up everything and submit another patch. Thanks=
 for your review!



