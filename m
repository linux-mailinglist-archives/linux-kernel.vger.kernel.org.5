Return-Path: <linux-kernel+bounces-124306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6489155D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0491C2154B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DC3A1D8;
	Fri, 29 Mar 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JsuX6hQX"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2239AF9;
	Fri, 29 Mar 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703222; cv=fail; b=tUoQWR7y+DYuvBod7aPPWIs6Iadj6OTndPpat4C6uEtiBTSCTTgpEmcyXUsz1H8COhGm8KD9q4KzXiqs7Shmk5vj46Bzni5xD8/ivMYYNIe6Ul7PyjP9UbPKkR4DQsrXweaebjDiUgrk+nkdDaa5kiiPUtIsPl9aJQIcMxQ1hgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703222; c=relaxed/simple;
	bh=Q7QQdvYpHn/3o8kv+iDSjH30wJ982bn1bTjKES7W8co=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JC8SE/JnZkpzXGQ17DeQdKZw9MNxGsu+63yF8LmQzRZicW7mlx3grfOxNx/SpD+ZeU66USbNBqO6RZ98hv0/Cx5EQQ8uVUfXuTH4WvrxVNBw4IRDljPyQLkyQmTv+qm0iGWRtl2mNT5Zxtj0APaR4nCIqJIuxGrBlXKawAzBTzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JsuX6hQX; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SMAWWS014422;
	Fri, 29 Mar 2024 02:06:38 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x5gm3htdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 02:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUjkey159NdldklZeggzeYO9Sk8geCd7iZHZGesvrqzq60+XkXo194rjMIbwDCerUydKnc4GHVTjkX9rHu4nYGQRsDvW+i90nLW+31ioF1VEK2bQaLoDuz/3ES740iMDScxnr0ievUgfGbl0CBo09E3M4YhN3UuxVR5GFpJHCOe25tE1PVl6dKGEsKDNT2xyl/Jvt9p2YsjXU6WsahWxWGzM9cH+IbdwABc0nAFf3lpzpc8U5fDE2418xsvgAQrceVxNGzd16xZblBCIHpT3YJQ2z6TBdvkldxudSevAhOJbH0qKsyaChPjQMMnPSaAA64Dut+gSGq2UX9WXhBw8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAWviKysbaWZozn6DB9mLmJ3KPoxFYB9TwhLtBO1Cuk=;
 b=R+5VUptI4iL6OLUj0bAzuhQHZRDzbdDwjo1ukLgfi0vBtPjeISGhn23ofTuafHU939TuAI0rU9ZdJ1UgreD15NgMYK2DAF17zq/bLUWJSAwQIxpL/hziSU8WI7WAizcjfArkWNcJcfSTLbMlLRVujhyZyGYr1nQfiryr9CLqvC16/6WPoVuOCAI6G99XeQMKmC0i6xiKboNBnIkaLWVLqaB5KB9Fzgc2nZPZTSmhGy6rJHPVjbuu8TsO57Z+uiTkZnlNCUnay0TzczVr8BgexGtCqkrbaSNhhz22qG+Ni0MS3OuHE3B0Wu2Q7ZSq3P13veiNT4oxo5OhWZycUHotjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAWviKysbaWZozn6DB9mLmJ3KPoxFYB9TwhLtBO1Cuk=;
 b=JsuX6hQXauL8XeRsoFCxcBFXGzpf/ub84RFR/1IiyWtbp1C8JhPQaIycy48TbD68pFg9tcmah//pN8/sO5Fy4kxRRSv/698WfQm/kayXkzQpW62PkQZqFv9A6kcCxbL6q9Q+U3UQ0NAhRc67CowO5rugpjVtpfuTkc7fuVTexKw=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SJ2PR18MB5740.namprd18.prod.outlook.com (2603:10b6:a03:572::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 09:06:35 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 09:06:33 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Subject: RE: Re: [net-next PATCH v3] octeontx2-pf: Reset MAC stats during
 probe
Thread-Topic: Re: [net-next PATCH v3] octeontx2-pf: Reset MAC stats during
 probe
Thread-Index: AQHagbhl9GqynKqVakaQgX+DB96yOg==
Date: Fri, 29 Mar 2024 09:06:33 +0000
Message-ID: 
 <BY3PR18MB4707F7B23CFD2E7014163F7EA03A2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240308181544.806928-1-saikrishnag@marvell.com>
 <20240311151412.18639483@kernel.org>
 <SJ2PR18MB56355935E211C00939AE81A0A23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
In-Reply-To: 
 <SJ2PR18MB56355935E211C00939AE81A0A23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SJ2PR18MB5740:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 afotSG4fpZIb8HZCIfkyOfYLAz08tK/x1fSo8/Kw7mVp/BZrqTq4fUI8oGr0scLe0a6FrD4L7NWgD90RdxDFFpJD2hn1voPBxO15aqDUtq4zZrlG/682AbV5nHCYWD33sexP2qhG9pu3FqRhslggSvnnvU4eC5RCb7aG0myLDMqIlrTPLOnATGC/uP+AQJclixWUTr2/uUkx9k05i/0Yf2CqyGvQSGwO0ZTV97Fv5aOQvnaTwAHsOgQs9ehsRg8OBiJCktbPJRLKV5o/5AVtTk1ioISWgshxqTfCwQvQYNfZ/66vWQdArMA0Y7CUP13IxdpYh8R68iFrkIUXMpO6JIuJEvuRZSk6B+3lz5d8Gf0lNZ9U541YBgHizP6Nc/2rzTibZzzMDOZHbOEiGNmRwY4CuhMgx1XbTkGuzY5e7fOiovozbOL45G8Q356d9fcIvVSHlIy1jLcQIle04yWyFy/PDOKYFOlnPbPCpJukMH9jw6U04a3OOa14CopsDB3DxA+dypTby3YAsWJgyrxYoNPrEVZAQOAkpk3DzxBORDFakw3xVSM09YrLFlE9Qlsw8fBWR4xwKp5/ROJ/rRvoElG+2CLTaVeks+bD0Q5lVoL3NaViHAb8e3hSR+/DdxcTxune1sftbMHnzRwh3OeZg9k8lC1Et868B91NH9Cw/dY9x8xiN3jYLpQUSdajB0DuYLAxIfp997zxbbz6KdSA9Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JcNTX1JHNZXmk3sjozixoEp/cHxQ2CO9AGoxJb52HkdB7UIstw4834NXAfQn?=
 =?us-ascii?Q?nDM7cVdPyX8Buc9oPkIuhy2SM6Ah+1jJYOlu/9hWklWfq0I39z6y8IM/sJuk?=
 =?us-ascii?Q?mdF9RXGC0rx97bGPxu1NJO0nS+UOSQsuPYdva2/5EcuMTgt71asWlCttyOpl?=
 =?us-ascii?Q?cE5nwHxffI050vW+XgrfhkJG8S+0cCxA2RkeejcCJp5qjCHEiT/fDd35wePG?=
 =?us-ascii?Q?xRTSsRlw1AUHIgSpjFDdSArcywbo7ugakTZTNqRJrWfGQzPMgrQMXwYem9N4?=
 =?us-ascii?Q?AjzObZujoAYgRFJJe24MLOyh0/U6dLh/UgBt4aRdUKAXBXmmULSZ+NM0SE1t?=
 =?us-ascii?Q?XSsiZ28T3p7uRs2CjAhdNyYM6KfnI6Qq/ac17GSxfaZC9s/63a1yi4GTZ4dE?=
 =?us-ascii?Q?j8pCZVo9b0bOFIXUNi8v+dVmlk3C4ahw8Oi7S4LkJ3YT43WYxkHrSVqby0oZ?=
 =?us-ascii?Q?JD+LY5oayuD5n5YxwZlyjtvKM9GQnkQAWZkSkBdIIu26qjrgHbM22M01OK1c?=
 =?us-ascii?Q?ls7BVeMcDbw27cnWdRQK99ss8BWVYxd1IHgjIQVmJsFXOyV9u0D2ALO+cTzg?=
 =?us-ascii?Q?0yAXQZuancP4PrIcnqW/TrF34eEoRBvdG7bqgu2zlAbRMkY2QZ2n8tayjs2I?=
 =?us-ascii?Q?mb+KOmKjYnAi21RSr+6B3+CqNeX1SLU6oD6UIE57ntSqse1+eNxoe6U3IKly?=
 =?us-ascii?Q?dEGwEExvbiq2vM5YXoB65ZteJF7jMqBR7TCFQT2MDT+C5QrbK99L8xLaOLFx?=
 =?us-ascii?Q?C+WGGrOMxG61nzWqBsD0GSx6gGQlBDbSAC1EdxJz6i8WjBHWt0uQCQG/cggD?=
 =?us-ascii?Q?yUai4FrNPbAnshKUk5ZjW8tRm7VsZmlC97t4Y/Sp11y8YpdPCEYhizGhNAKO?=
 =?us-ascii?Q?A1bdwGX0KgZHlm9Pa3/W65mWaAalPVeU7Uqkqx437YjcjvcDBx5m3tzOSTJS?=
 =?us-ascii?Q?m9RjCDN7h94im2DhiVku29rlpjszJ3Vyt7xBZ5W9gcKL7ClzYb1vyfRywqp6?=
 =?us-ascii?Q?RQRn8QfyFgheMS3Nx0bnGnm8WgKthMCHwbbHrqMZInXruOml52IyDaEgH6OK?=
 =?us-ascii?Q?TkapLGJIuJPyCOObOnd80MePmcvCoA2SG6x5ZhHFQ+1o3wFRMM65hPHRMB9f?=
 =?us-ascii?Q?24vOeQGy/I/Pv+WpgMhbnmSa4c76yaMR7zgS05SQL98R+/8YRo4Q9wlomr/u?=
 =?us-ascii?Q?Jk3vSA5DjQ2HfdaGTpn3nnf66m+CgAzD5+d8oJdpT5OZUmCiY6yscaMwIDC5?=
 =?us-ascii?Q?7D7GjQ29JqrosgHSetLV/nrnprtAuUnRhNK5cBrR6GQ+pwd6dJB9XY6G/fZ6?=
 =?us-ascii?Q?8tULPZIjUEGeeM4UYqsnVCQvvL6XYAdvTAjcNdbx9/6BF4cKk9TeL6nS6n/f?=
 =?us-ascii?Q?DmXMLScWrDoOyHxPgocZnruhw5r5UdLK9cEJRHUDd8IUOJ1nrGAAW+t/Cgnp?=
 =?us-ascii?Q?RNy6uSXKItp6P12y/NNshEdjaLjpdrDb3MLN160DNI9PHrgiFqnb9ZP46hFb?=
 =?us-ascii?Q?hvmXSZnGmZWOrAfR+a+JCxRlYCqkVf93ZJoRmaJOMZxCBq90O/e83GYiZub/?=
 =?us-ascii?Q?zIxOvR5Q8AtIYVX6HGOQvayvEVzO1OpkiFPhSM2t?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1331d6e6-aea4-4560-789b-08dc4fcf8795
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 09:06:33.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6BIbxoF5knPd4JxDaz1u/PFgCCp07Ngk/m61/hUWsk2NnO4FIaHvn90mGFuYSIRst2XFr8HS+ap/nYpbcy18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5740
X-Proofpoint-GUID: 3d0D72Ab5nlFVGFuDw0KCF0SRP8KW_56
X-Proofpoint-ORIG-GUID: 3d0D72Ab5nlFVGFuDw0KCF0SRP8KW_56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_08,2024-03-28_01,2023-05-22_02

=20
 > -----Original Message-----
 > From: Jakub Kicinski <kuba@kernel.org>
 > Sent: Tuesday, March 12, 2024 3:44 AM
 > To: Sai Krishna Gajula <saikrishnag@marvell.com>
 > Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
 > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
 > Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
 > <gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
 Subbaraya
 > Sundeep Bhatta <sbhatta@marvell.com>
 > Subject: Re: [net-next PATCH v3] octeontx2-pf: Reset MAC
 > stats during probe
 >
  > On Fri, 8 Mar 2024 23:45:44 +0530 Sai Krishna wrote:
 > > @@ -3048,6 +3065,9 @@ static int otx2_probe(struct pci_dev *pdev,
 > > const struct pci_device_id *id)
 > >
 > >  	otx2_qos_init(pf, qos_txqs);
 > >
 > > +	/* reset CGX/RPM MAC stats */
 > > +	otx2_reset_mac_stats(pf);
 > > +
 > >  	return 0;
 >
 > Looks suspicious, all sort of resets should be usually done before the
 > netdev / devlink instances are registered. As soon as you register
 > those they may get brought up and used (including synchronously by an in=
-
 kernel user).

Agreed to your point, will send V4 patch with the suggested change. Apologi=
es for delayed acknowledgement, as I overlooked the review mail.

 > --
 > pw-bot: cr


