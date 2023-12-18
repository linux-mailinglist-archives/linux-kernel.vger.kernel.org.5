Return-Path: <linux-kernel+bounces-2901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB618163FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B172819C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A763AC;
	Mon, 18 Dec 2023 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adcsuf.onmicrosoft.com header.i=@adcsuf.onmicrosoft.com header.b="Vn/dlH7d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486E6118
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csu.fullerton.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csu.fullerton.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0tJVDA7hGdWkkKz1fmxOCZpDB4lfkCoFGGgnPIJ5uZKUiXVOyg6XbUbTA4osgS6hwpn6U28tKio3BCC96YSWVsO7m+/tIQKubVwgOPJV+tKMw5cfaz7yQwMHkUMhiOAxAG6bDIJXo+nbvYMQmx2PUFqPwD+4OSzieobh+57ZfYW3qLl57/4smZQKKK/C8zNVqG9J3LkWQV3J9d+uFAnNDeHbgXempTI2fhEQ7wrxgauLQarbKoGW+hVupfvxJ6U5WKfxN9PJuLyBMj+q9qu1+SIFY0bbXGNGrwlwhdMHKOtgO2Zlw7gCKP+rxdUFCdpQ/UptEZR/CaojZuW2ZmE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyznG9ZrDDJNFl56LEraLJJ5IWEVHA2sNulgBB3vOTo=;
 b=Fa4QP/RiTPErqPdypd4YFoXkqJIdNOuA70Fa8AYMMkFwFhxGSljMY2pkNwJ9EZhiV1kSeCXBusMrBzlQqmTlDiztkqE1eUsbVX9dEe1dUCnZsfWBYMUf+WixTKoOLmgiUMbNHXNNw/o4v1XrbV5ROgZJgvDZprSkTVCoxdAj18A9f8BWsRINWV6wIpqUVxQ/TS0xI9r7Ofpi1ImVnEjL+A0OuOBTL9GXOVNAd1Xz1ISx1WzW1J9EFyXT7oqhoxYZ6nKu0FyTDMwSVivaLPgxD/U7a0zpF3+hZ1XYclRrd6FvjJw8cJ4XgU/GszYOYaWTEe5FqPMWMH131EqvQvgK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csu.fullerton.edu; dmarc=pass action=none
 header.from=csu.fullerton.edu; dkim=pass header.d=csu.fullerton.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adcsuf.onmicrosoft.com; s=selector2-adcsuf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyznG9ZrDDJNFl56LEraLJJ5IWEVHA2sNulgBB3vOTo=;
 b=Vn/dlH7dkVb1HhQ/zy3RgyRSPPH55uP5vdAM+UtgSEHP2q6UZG7dwbkLJQHfDC1q2/8h/So6yITR+9TpyK5x78zAcKKMc/YWSy6tC6viS0RG8XeeJ0hIRcbWeZnrKHp9tA430CPu0QHaeHBE3MTCOsJgTc67IYLg9LKeqLGjZ18=
Received: from SA2PR08MB6716.namprd08.prod.outlook.com (2603:10b6:806:11c::14)
 by PH7PR08MB8179.namprd08.prod.outlook.com (2603:10b6:510:12f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15; Mon, 18 Dec
 2023 01:16:23 +0000
Received: from SA2PR08MB6716.namprd08.prod.outlook.com
 ([fe80::3eea:fbce:f372:6cda]) by SA2PR08MB6716.namprd08.prod.outlook.com
 ([fe80::3eea:fbce:f372:6cda%5]) with mapi id 15.20.7113.016; Mon, 18 Dec 2023
 01:16:23 +0000
From: "Parker, Amy" <amyipdev@csu.fullerton.edu>
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>, "cl@linux.com"
	<cl@linux.com>, "penberg@kernel.org" <penberg@kernel.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab: fix include indentation
Thread-Topic: [PATCH] slab: fix include indentation
Thread-Index: AQHaMLlk1MmNKn6Zb0KQLeT23KdZcrCuOdaggAADCeA=
Date: Mon, 18 Dec 2023 01:16:23 +0000
Message-ID:
 <SA2PR08MB6716074214A45BFC2B75D1128190A@SA2PR08MB6716.namprd08.prod.outlook.com>
References:
 <SA2PR08MB6716A0570D4EDAAD4221A7788191A@SA2PR08MB6716.namprd08.prod.outlook.com>
 <PH0PR11MB5192B04F9FECDC6F7460EF2EEC90A@PH0PR11MB5192.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB5192B04F9FECDC6F7460EF2EEC90A@PH0PR11MB5192.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csu.fullerton.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR08MB6716:EE_|PH7PR08MB8179:EE_
x-ms-office365-filtering-correlation-id: 265cd1ef-c99a-4dec-02ac-08dbff66f321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MyyDmmS+pSROoJ2wlpEbJax5WSf0tdzNR23aH0GxCAy8fwv2bv8PAA4OQBFoFSplAxoR6tw74TLGZKFxXb0gaTvT3CavjDRlMp+9w94Fb+SvoirNMJU+N7XTDERDs61mANPCepkNmQ23QXnNdk+t2kDv8e5Uz/OEzrcxpwy9jiRr0MrXIo0NaA6XkO8dmJT8/BTpen1XdPhX8r9tl5VPplw6Qex0ugJEJHOQtvdGeHoqzqSy5SvmGsZDxx0hlNjgdj+V6Qp7LoXVGI7mfVDRo4RWIwUDcfdDN1mHNEsmwQUgnKRSMIKCzPHM6ZZLAfpIkNNQw83WpBJmnga0Xo2r0c3n9wxzIkpyVAuA16iwXxh6pL9JBYuShWpNNx4A3/GE+6Awjo2/s/BPbEbqMRZ9cdYmBqHY+iIUtLrpSUeQfV1IG/+X/NnCafcz0jyIaKrdxuvhj602GeJhZYHLCPuWBwrZ3kMA2oWR/YWCC72qUg0D9XknUEoUkdd+9teEPVobEyg+A6a3AoiX5eRO0WsbPGOMu4Rx2DBKTR/Zvc3YOp9pY1ozbLKool9kD+Mv7QAEUUnw1cxNRsKgErAYLHKhA/U4Vq1V7xB4AUEZmxz2ae4pFNZkOgTcaW9eDH7FsKOf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR08MB6716.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(66446008)(316002)(52536014)(4326008)(786003)(8676002)(55016003)(8936002)(91956017)(66946007)(76116006)(54906003)(110136005)(64756008)(66556008)(75432002)(41300700001)(83380400001)(38100700002)(5660300002)(4744005)(122000001)(86362001)(33656002)(9686003)(7696005)(53546011)(6506007)(71200400001)(2906002)(478600001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iHEGq7zA+vk3P+cYKGK3gKddN+CdMYKO4tFkNh+M2/oq2eQrs0qCobJLzE?=
 =?iso-8859-1?Q?KhdIHyW7o9uAFNFyuPa52fQIvEYLukXWAavHvsD7K7SxJz1I5V6oG7X6PO?=
 =?iso-8859-1?Q?6SfqMLm8Z2lSifIdvAT5pwdLQXCpzMn+4j8bzR9izu4JontWZ0Fv0HSKOb?=
 =?iso-8859-1?Q?n2y7ltEuderY+ty4If4iPxFriREvYF4YNaQQIAHQbSd8oBj2iiWFCiNkGt?=
 =?iso-8859-1?Q?CkeFij+KezXsKFqC17z2P5EjGC4dYp9frSo/awdglwbeZKrqdSpXMtQJge?=
 =?iso-8859-1?Q?igqKZ2kCJ9VCHHzo/iixQyOW0gJkIW/dopBm1Sl+JoDnaPo81wCK29J7qI?=
 =?iso-8859-1?Q?MiEGMLwoKm8+soJolauGPiFO/Lnh84MBhe0fVIPqNjs4Zf9mMarrj94OlA?=
 =?iso-8859-1?Q?taFXZwUFFVxsrtuq9b+Y89VKFIRVSf6iwWBoDaXSQOZGTklURJ+9oseB6C?=
 =?iso-8859-1?Q?CluuX2RsOpeiln6Ld8rTQxWkKX5M+nCCGdiSj5JXH2KcbS6PvfIKGHx/9p?=
 =?iso-8859-1?Q?2KGnH3mFTlV2qdovxV6UZvx+MAqCYAB5pItEHib7EEuI/p1IxjWiWWpted?=
 =?iso-8859-1?Q?Oah4heB0mLhrww+7qbu6yMzl2gnK/W852RITbQ/4h/yhl1CovODtt2QQgv?=
 =?iso-8859-1?Q?fgQZASalYd3++dHTP7oRCPbtqeQK5jbrhvTSn7ObWsuUc/R7gKETbEUjDr?=
 =?iso-8859-1?Q?N79qu1tVZLNlzaHOkb7LbMXJws20Skn9EbeP7yXJr50HjowGhV9Mx2PiS6?=
 =?iso-8859-1?Q?RjJGzQZk8YmUbfWbjC13SzS9NVArLGOLurD7XvXdHDNxe7wpOdgqyZ0Xuz?=
 =?iso-8859-1?Q?oSdDS4pv4X5JnAev7qm/DrYRJavYazBvD6UM+kon/8b08E5lH0CVYxcGQp?=
 =?iso-8859-1?Q?j3Mlda+4m+ysE5e9itStE4ORE5+bPD8308mr8YXlNrXNheeGRfbzBtt6sY?=
 =?iso-8859-1?Q?qWgCsToWvoK3CprcvsXHGYrzYYDN/I2oV0eWfzjUxC1pUyvuw6sTnpnxjf?=
 =?iso-8859-1?Q?b+bFs6361XncnxProlp7yXEY+TYzX6CagI6p2hD45iI/Ff8CWcQ91KXCKC?=
 =?iso-8859-1?Q?hLNkkoUXMFwUH+hN1XE/fpQxHHSWa/GCkmWNYOD91JGQItRWTyJw8aiP2/?=
 =?iso-8859-1?Q?APN7B9FcFtIi38W/srELEpKrF1eEvPPKNGLmFaiYqb99r9v/nqShLKcokU?=
 =?iso-8859-1?Q?OKm0Y1ySI8CQ+vQN4RbJoFfZBmg+KC1EUCwzVGfQYfxgHMDyShxaXaQdEQ?=
 =?iso-8859-1?Q?W6JHG50pzyIb/1AF+I1w1R5268yyRHQqxq+KHNeq+Wux+k6GSlKVVlsdLC?=
 =?iso-8859-1?Q?qOrwoODmFGtZQHRIJ6yKkMWJROg2OmIDUzrk1ihV0vF4wAy26MMk/OBEHr?=
 =?iso-8859-1?Q?Nuc9UfBkuES3RNE0863HmKSfRg13jW22TcAEux8jSNyGQJmSoasv7Y5nnu?=
 =?iso-8859-1?Q?9Nl5Q/4JCqep5DQHAJYHtkjqUs/L29RZZxu+crJ4Ms7+fV+QlVyCcgxH+n?=
 =?iso-8859-1?Q?TkmSWFTy03yhX81+DEmDeORHlFIld/WFhVRa7yptNDA/Y2E9COJRZPbDKc?=
 =?iso-8859-1?Q?a50WL3qOS5xVxNOF57Weun12BfyyaB+AAYhiw0KUoirNahAdmRQLNf+j1A?=
 =?iso-8859-1?Q?0/ud1pVmMywPU9jes6HSWuoymqbeijDGf7WwyyuYO5vP/7MTkEWaoiyfIG?=
 =?iso-8859-1?Q?ldCE8XQLCOst9/7qrtE9ykTqYilmHNJPhqGNp35RBCLlt7KfHXjoGsHmRd?=
 =?iso-8859-1?Q?eqHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csu.fullerton.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR08MB6716.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265cd1ef-c99a-4dec-02ac-08dbff66f321
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 01:16:23.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82c0b871-335f-4b5c-9ed0-a4a23565a79b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yz0z5SL9u5Eg4IJF8H10On6xYtJg6WfYnyeniyxFoBeBBYy7022UODbT/xurlixym8qNv8VLpUrTaAoGtUH6IMEWjRs97u3ubF1YSNFblV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8179

> -----Original Message-----=0A=
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf=0A=
> Of Parker, Amy=0A=
> Sent: Sunday, December 17, 2023 3:23 PM=0A=
> To: cl@linux.com; penberg@kernel.org=0A=
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org=0A=
> Subject: [PATCH] slab: fix include indentation=0A=
> =0A=
> Include directives in slab are indented by tabs, except for=0A=
> trace/events/kmem.h, which is indented with a single space.=0A=
> This aligns in some editors depending on tab width setting,=0A=
> but on others causes the directives to be misaligned.=0A=
> This patch fixes that alignment.=0A=
> =0A=
> Signed-off-by: Amy Parker <amyipdev@csu.fullerton.edu>=0A=
> =0A=
> ---=0A=
>=A0 mm/slab.c | 2 +-=0A=
=0A=
> The current slab allocator=A0 is going to be removed.=0A=
=0A=
Hadn't gotten that news. Thanks for the update.=0A=
=0A=
  - amyip=

