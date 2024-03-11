Return-Path: <linux-kernel+bounces-99465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F78788D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1432C1C20CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB354FA5;
	Mon, 11 Mar 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eW18epXT"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40A5467F;
	Mon, 11 Mar 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184999; cv=fail; b=Q7gib9KBXJia4l4t0Fs4jOynwBMVXBCb9m7txnmAjIH2uG+2eLYgv1h57kgOwNghDosh66YrU4ndf/b1nVhOGugArLGpb6CL5NozHvZOu9a5WW+vy2KjwSaFeZ8G65mDi5AueG0etkTptT1sK6lUhDuA63FMMN72dhm2nJIclCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184999; c=relaxed/simple;
	bh=pnbQEOIKKon6rCo5ZArMhm/xxD6mYSMSD1to6JiYBDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APZOq6g68Uek+eEkFhELOL0BWyFrY78sZp6OsJ6BZXaKiFHr4TSH0qJmEBCwyQCuWYLRFA0JOrhE5XXYtrA35OwjWtzVAQooxCG7KISbUNdVwdUPmHcD98GMGVm6voF5gJnpvbVhwquW+D+L7Gj24wkjfwcKYJup3oDunzuTdLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eW18epXT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BEm6si028613;
	Mon, 11 Mar 2024 12:23:10 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdctf4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5W82g6wZtKhJYYRY84zb5rai5HZcNHoLcE9uJNvT+VgZ2S1lxW/r1+Ooo2FXZHF1BJfcUtqvHHNKYn1wW+NOnqonz9hpG2kMhwilVLAqXzg5/zmKWLR5dhZQK+7Vb5IQx1V2BOf6hal2p5NDrbAMzPH55SEHSgEln4zQSBr9XTDU5DuD+i59d/E2n/XOgsuNW/vfxJHnbzPeo7RUF7UHPxl4TY5oAhNJ9O4QdQbpvZOpUkh68Sp9+rHIwHO3yyJgNipw7y0EB4tpg3IhVOGnGjHg+kSMowMBiIkdOVfnMveh4BVC8zMRj80oF7+sVanCAA7TYVBJ9RGHTkGznTVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8wg7LceQBl8aGOWk0rn4DhqryD5EkfsATK5n4QUwT8=;
 b=mCh7+dUx54DsfbnsQelDmUSjhBU7y8CX03l3qW+22SNvt8RKiSp10/s4v1AU6j5Yz5xfXVF78zfP7A8hoekPi6QrUCy/KPP6ZWRDqtdd8vVCvx17eNu013aw8lgdOLsPenwXEJiCUbRNKDHFCWfAmV8oe94RzrmRONckPTqtXTZ9Yao9ggWsYx/m/YAdT+rHImyuH3wEx4rYZpBSQlzFSItRziebPhXx7c7Qj9zGaYBbj5hskSXMuh3JrJMYGzfqhzzrNd1RUvCIj5yziCpvKTFdZhIHUQM/NeGv4ZGeAWH3nCwjZdFwJEyN6hEjuMuHu5uf2qTVK6pdFExUohfU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8wg7LceQBl8aGOWk0rn4DhqryD5EkfsATK5n4QUwT8=;
 b=eW18epXTsaAYd/Uvm1U7xgeWQEnmtE4HTu/4XAAzmMaKlXkzlQc81EAaC6a60omwuspHLIOJGctYSJsl4EROEsywd25EYC3jAzWEXFwZh+zTvdYXcBUbdSBF8KTg91zcWG2YIvRzhGz/T7dWU7ppDyUXJWRn5ba2LvJ6iT2Wcyk=
Received: from CO1PR18MB4732.namprd18.prod.outlook.com (2603:10b6:303:eb::13)
 by PH7PR18MB5077.namprd18.prod.outlook.com (2603:10b6:510:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 19:23:07 +0000
Received: from CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::e359:d465:d089:4a17]) by CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::e359:d465:d089:4a17%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:23:07 +0000
From: Radha Chintakuntla <radhac@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Jerin Jacob
	<jerinj@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH] octeontx2-af: Increase maximum BPID
 channels
Thread-Topic: [EXTERNAL] Re: [PATCH] octeontx2-af: Increase maximum BPID
 channels
Thread-Index: AQHacA6fu8tIXN9KB02ERLGkSamCvLEsXdYAgAH0bHA=
Date: Mon, 11 Mar 2024 19:23:07 +0000
Message-ID: 
 <CO1PR18MB47326DC227E1CA9135519FC1C5242@CO1PR18MB4732.namprd18.prod.outlook.com>
References: <20240306213806.431830-1-radhac@marvell.com>
 <20240307145146.GB576211@kernel.org>
In-Reply-To: <20240307145146.GB576211@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4732:EE_|PH7PR18MB5077:EE_
x-ms-office365-filtering-correlation-id: 8fb09f23-39ee-4ef8-bbaf-08dc4200ae90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hD+3At0YnXQp0XYwip61S0+ZH6aAGv9Rv5TjgHBKoqQ28bL8jXFWFKP6IjHMZ6qy9Zcw0AquEAsRlnlYVqPse6dQYrZEHFwXxrulGiFwyd2FuuxrVWsrFOW9TAKt0yKZfKewJNAzw6iYpJz0S4jinDcJSIXSvcG3ZL0hqjeVpo1LbsmF0HIT/Gou8fhnij14oLJ1XmLVlQh4J6056PyDcR3gjaUv6t1Bk/0FtWXH79eWjEzDCu8nQkmKwOE8SWW/ojGBri8bYmzRzFs2TWFJGhpNGz9NFhPlFLT8RZ+85NjSRgqBEI5aCyGi0FKpp2ubzxHz3r4AtdtOscTzDTrvHeQa/haDG4zMkBn7eFz6lGHsFmaluctfRW/DYFo9OGDoBGJdmJTZK7fayF/sG6K9NnmobdlOzXGsNhqEgo+KZymp3Mgg/BqGK3hYNB+iCJ0MAHoCx+vp3iaZalnnCS2bIu6MYOIOcCPd+D090cdD0TPd3Qfd1bahCJIyC5xQzL/xKvkpvf/DXq6lInxZs1mKoECg8ozdbjpgJw9BVb8k7TSp0Ijz8GOmqAIYpnx/MCUjGQ7JIXBIQlwOmAd3I0kQzrWbGeqJpvNCjLnzzq+dLLLlpRAolNAQ1Ljbz1i3uHVhuMHbo56dF9FmR5D9dNe+t3r6KFs4IntknpudkkvMGS2ZnZ7L3WB/rZ08R1FjccUDrU46oUBHzfiU466DOv8qQg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4732.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2CdcKAQ0M4WDKulbbkOGmnfWXXZH3NsepSkmqZnzx62R0jY4zuxe0gYtk/0I?=
 =?us-ascii?Q?mUjDCV3yLK9vrGQOQDXCEkZB+QONm0y280RrqAB7NMo/sImmStXcDMpw2LLh?=
 =?us-ascii?Q?quczi5wdxRIu/2yN4Hlghq4XH+oj/fX7WO9IOqjBpGoK4DPlD4GRivOG7aPI?=
 =?us-ascii?Q?P8sbZjtAJYSnqBOQdvc/Uzw4cGfJuZ4UsNucYxHurIrLLuUoDBpeOghbF9r/?=
 =?us-ascii?Q?BeCSFrpeYr0PrJzf5GhP53aZAmfxMsDEZ3O1aVe6dtUDrRu16GVHPv+mYMIm?=
 =?us-ascii?Q?KAeYPnuHMthUT08y1R3FKznqY7aDLRyh0IhNcCnnD1MCqXNiI20n0jlsYs0h?=
 =?us-ascii?Q?YxR5R/uCqH0hm+qncI0od8pOernpM4n0yk1rpuEyleLMxjvJh17z2zSuQBJR?=
 =?us-ascii?Q?0BBgoweM7ugsTyPaKKyoO5aLvj/QPV+oPyBolCswkT7qiUgxtVuUTX/ayTAX?=
 =?us-ascii?Q?yqc9wBNSodfotnHYykkW7YGhFpb4luWHto8KcB0xSddcUv7QRUHj5hEhP66z?=
 =?us-ascii?Q?J17k163VCDy5fZu6bPRZxFKIaF3XYiw9hUQvGwoM9u7wfNdsoJNaI9eOirUW?=
 =?us-ascii?Q?tynkIzMQpMx9Ic2QUkLzslHYsKRFS9yrqzvb7QP4IVZrsxRzUvvq5LnlJuYd?=
 =?us-ascii?Q?9s+9JYCPKMDZuw9IUg/6UOkDYKKBoXkvaEtuozJkOSG8HrRbWt3+Ij7VVr+8?=
 =?us-ascii?Q?/RYi3dAMGFyYD1DhJTf/42qOjvhWv4WTYy+JafP7zza9cTe2rLjycCYtv86E?=
 =?us-ascii?Q?9b+vV34jvlhysr+Vf30dX4NVCjqm5xV9oSeSQ702CZkVxXLoEjcbW0gOw1ai?=
 =?us-ascii?Q?UkHnJraij84JcqPJJpjU26GlIZBiZE5fPRtPRSaYwLfAqYUeAFpsGgt2Vhar?=
 =?us-ascii?Q?7mNh5c60E8WCUKo8VGvQp7KcQg8UqUvojXad7iLEGqUR1F+myFfuliiH+aGe?=
 =?us-ascii?Q?WBwKeyhv5b4siA1S50R9wt1RgpZxQ98Qnt9Glocn+cwqZOoOUi66TFLBMk8M?=
 =?us-ascii?Q?Mf8olYjfJxsBhuaGCrPB84/bcFyIGfkuvR+Xn0o8lCwoOqjGOdXWV0l1Zd3k?=
 =?us-ascii?Q?SvAfoiH5IRY4Z/FRGd4umxyMMOpnyEo2NyMfZPVvy15eC8cacdPZWh3bwJZ2?=
 =?us-ascii?Q?qBbgHH0USD7tm9egqd1CuYVrF1a25GjfoBZXIxT36Br+Gvuo4EQvGzvlSktN?=
 =?us-ascii?Q?CVwa8Ni4bvD7r46KbpnEjzQPXF5eF4S0OllzioRYTCFhzQAgVGt9xesDkuV0?=
 =?us-ascii?Q?aXo+te27VAY9mi4JtdiE3JIidD8mYvY+5braTPbhkkg/F8zbTJ+Tt1114dyr?=
 =?us-ascii?Q?dg5QouvCh9ljHtjM5FWHhgfv/dgD5mv+UUfxz1onw5UuITRSTSLrD/KgbPt3?=
 =?us-ascii?Q?PO3+yyqsT9u4PxFasEb0ALxo+iJHj5xrryUBTBFRKd0bZWcRTObmxJAACklk?=
 =?us-ascii?Q?1MabUmvYytZqEhB6GcXfN9t7f27Zoeoa+7tU3Ay9KMVrkewux/clqq0qdxn8?=
 =?us-ascii?Q?2WO3eGRqI2m5OFYgJaYRbNxNAkljclASRArHWkKMdy+tQSsE+hESoulvca6N?=
 =?us-ascii?Q?iKmGzsa+X3ReuyLkmC4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4732.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb09f23-39ee-4ef8-bbaf-08dc4200ae90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 19:23:07.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CE8uTs6kGrd6XsXnKvz9SLY1akrGf4s1B7KEWX4QGJ1g+Ek6Tu1S7tVOCQK7/Uq/fmPgUre9h4fEHynm60gR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5077
X-Proofpoint-ORIG-GUID: _kcSVNRKeXBzd8absitYS1fNKIuU0aYY
X-Proofpoint-GUID: _kcSVNRKeXBzd8absitYS1fNKIuU0aYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, March 7, 2024 6:52 AM
> To: Radha Chintakuntla <radhac@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> Sunil Kovvuri Goutham <sgoutham@marvell.com>; Linu Cherian
> <lcherian@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH] octeontx2-af: Increase maximum BPID
> channels
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 06, 2024 at 01:38:06PM -0800, Radha Mohan Chintakuntla
> wrote:
> > Any NIX interface type can have maximum 256 channels. So increased the
> > backpressure ID count to 256 so that it can cover cn9k and cn10k SoCs
> > that have different NIX interface types with varied maximum channels.
> >
> > Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > index d5c4f810da61..223a2e39172c 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > @@ -1207,10 +1207,8 @@ struct nix_bp_cfg_req {
> >  	/* bpid_per_chan =3D 1 assigns separate bp id for each channel */  };
> >
> > -/* PF can be mapped to either CGX or LBK interface,
> > - * so maximum 64 channels are possible.
> > - */
> > -#define NIX_MAX_BPID_CHAN	64
> > +/* Maximum channels any single NIX interface can have */
> > +#define NIX_MAX_BPID_CHAN	256
> >  struct nix_bp_cfg_rsp {
> >  	struct mbox_msghdr hdr;
> >  	u16	chan_bpid[NIX_MAX_BPID_CHAN]; /* Channel and bpid
> mapping */
>=20
> Hi Radha,
>=20
> looking over this, I am curious to know how out-of bounds access to
> chan_bpid is prevented. The bounds seems to be the the number of PF or VF
> rings. Which I assume is derived from the HW. But if so, what if the HW r=
eports
> more than NIX_MAX_BPID_CHAN rings?
>
> On a different note, struct includes the following field:
>=20
> 	u16 bpid[NIX_MAX_BPID_CHAN];
>=20
> But here the index used seems to be
>=20
> 1. VLAN priority (which has maximum value of 8) if DCB is used 2. 0 other=
wise
>=20
> So perhaps fewer elements are needed?
>=20
> Apologies in advance if I'm on the wrong track here.
Hi Simon,

Any interface(or MAC) of NIX doesn't have more than 256 on any of current o=
r upcoming chips by design.
Each of the channels can be mapped to a different BPID.
As you mentioned, if for a given interface there are 8 VLAN priorities then=
 we need only 8 BPIDs to configure proper backpressure settings.
This entry 'chan_bpid' gives information on which BPID should be configured=
 for each of the 256 channels.
Hope this clarifies.

Regards,
Radha




