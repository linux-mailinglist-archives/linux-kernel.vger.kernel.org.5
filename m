Return-Path: <linux-kernel+bounces-98768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CA877F10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9015B1C210F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6403B78E;
	Mon, 11 Mar 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="bna+2uRU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8D3BBC6;
	Mon, 11 Mar 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156879; cv=fail; b=AkQN9Uuwn7VpCPtywx/t8/XPzzV95X5AihARpPPwMHwmNOosjrmJIi/TPu2pPlac5IsGRKLURtJKN6icn/r6dAmUFlUx/RbtG3d12XfITYPXxLA69+LyLTrmUvHKmEc/+E82Abqkg3xKav+VYcsuPZvRBQzRmrSwB8pTq93Cldw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156879; c=relaxed/simple;
	bh=Ne6oZ7hGc2NmPn+rsKiHxTxs52dxOyZUOgbX0BwHz8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYxC29BLCfiMSS6AooR4XNVdt8VvDoCABviPujZ/nwymcT64gBWblfK722DkoIqwUDSwjAVM/Bt736SYkdB5tGjz10Zy/7n0Sw1uHFPXIsI7/mCYzEewHuL5wlVaOpEq/afE7MW4IJ4/FX8elZZ9+GnoXCmJplCSAKpiehPeXK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=bna+2uRU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B7FfEC019599;
	Mon, 11 Mar 2024 04:34:17 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdcrnhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 04:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5+WujREcr5YtD718yQ1nFgqtlkm2GBmXEZ1QxiYyj4CIoTLx15qamD5ZjjUgif92ozjuVQymg54T7l9Oogsx/Q7tBB2gG7pLrKynDUqhV5JSlsEkp39tVdOcFSwD9oserBMhA04kiUzFVW0/+CPwNcMd50xAP5DXmj0IiKR9Gg9tc9YNrsJHJmV1jmhcF/babqqes/BJ2pdrEoSxhpLJQP3qWQ/QAyb+k5E7fPzJuzrTppqY9b/tqmXH3XyMNuWRB2Yksq4IbKh9wCt1iCGOT/zBVffl8CcacMdoM+P3/lW95FvK1C1GuucB2GlXDK2OSR9nrIB+Q1w4nhGhz/Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne6oZ7hGc2NmPn+rsKiHxTxs52dxOyZUOgbX0BwHz8Y=;
 b=c1ebt3VBOloCZCLGq35xsaYVzEweAwjChJe/Oglwet6PBZbkQi66byH35Btf9v0Up59pFGSdTATewJC9N2e6F57bY4BMl1DjWMdHsal2HAPdJiHiwKO7TTs11OsEOApfybYOGCnxFZMK+v2dQ0Jkv/DUuEpZwzpweA22eL0TKpJbBf1todJT1ov4AUFA/LJEc54ffBDUhMJN033lBXNsPE8VwPpzzczRiDz1L7GkX/dXVlK4LH9mwuxmfy5Yd2Y74ZIIsmu5SkKs/q9pqOc4S2IZrC/OkEaiVIFHMaUpTsh0sp5TgEKDdlzi6cspuf5o4q/bmNRVNZpT0zMb27gZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne6oZ7hGc2NmPn+rsKiHxTxs52dxOyZUOgbX0BwHz8Y=;
 b=bna+2uRUkKef4zjy0tgSyZcyPqpOSQaHpTgP8zbIBzJUhXTpQbJxODWToMqxuYCS4qCS0ZFKIqd7bgqeA/hQWhbugR99XANP/1VZB06P2O2vWDm+U2T81VTRCBzkL1ZRwqYW0Qd9iGD9PaBYRf0V6GIm55xDVaG5brOHKfagDMI=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by MN0PR18MB5944.namprd18.prod.outlook.com (2603:10b6:208:4be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:34:15 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:34:15 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>,
        Ido Schimmel
	<idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Amit Cohen
	<amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        Jiri Benc
	<jbenc@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
        Gavin Li
	<gavinl@nvidia.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next 1/2] vxlan: Do not alloc tstats
 manually
Thread-Topic: [EXTERNAL] [PATCH net-next 1/2] vxlan: Do not alloc tstats
 manually
Thread-Index: AQHac6bNog3RCIA29U+/uKYpWGz3vLEyaF9Q
Date: Mon, 11 Mar 2024 11:34:15 +0000
Message-ID: 
 <CO1PR18MB46665FCB882E8E293EEDE521A1242@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240311112437.3813987-1-leitao@debian.org>
In-Reply-To: <20240311112437.3813987-1-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|MN0PR18MB5944:EE_
x-ms-office365-filtering-correlation-id: 2bf9b7df-5121-4e8f-85c3-08dc41bf2e8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RjWlmj3ZfEAeGjpVq1GftUu++5IEmB6L0dVNCsgHxHodUf6r084c+1K4q6rR6UwnTgGFUhy3LNMoGYY/6fD/RGtp0FnA5big3uOuUAPet7Nev4lPGu6HHwl2gUJygIVYeZilLecy3XvOWexzjSIpuIEN5ybjt6l8eTWIaPpV5OTO6Jnhj4VoPGf8T86jU4KxkVibf+sebFybr3qwxaNTZE5N5kakCMLTSEnkV7y2fzgzlTXKk3GuyIVDiWaFcYDvJPIf1kL/kajgTWUlYh1w8ol+CV7UiZ7WctSAj4PPEgn8vMmKw2ApT74w8DlDucmQxLzXt3pZt2J33ixfasvosV+hoWnP6oIDTDkcDvlbwukgb2OoYuq/P4MN0laJdJatCmyaSFbhJ4AKgr0KzdspMVTTc8QQNQhv6GoWTX5XB184HoEWUu49g+AbL5TKaoYH70QfTQUZFx0f6jr/T3LddZLFg4k0/eKNCsCUswyaXm7iFJgCS9fKD1WZnSVDXQfP3es3DkrT83THYsLBLZJ2OgFKVinXK4Aej/DpJ7A6UGcNQnvCGNsAWSlei3dr2BWqa41BRmFkW4WkRQd2zvKWzOfkMix4tGHYscdlHBmmZovYC2nyVnu6ya0DxwpopdpgLd2P3fmykITy4MAmYhf0edg+SUE25NcjhUa6NBwgDCWg8h98ZD3JXmTZHM0q6chyc3dyo/I6oxQS+h8T3CnU48evNHZiAgM4ut9GZ1nzAWI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Q9P5Su15wtiUm2aQMWSm2RR+YsIi2/MUFvn1UX/qFEsDMCwhJkXVmDZCkCwj?=
 =?us-ascii?Q?gy/NOiIRBTZdUfxR/yHlfR2mONxILTIGE544dY9c7X6kIYyfqf45AvhcTHDe?=
 =?us-ascii?Q?AM+yYn2FU1sZDPJstz3MBPQUbuboYAA3iR4k+L3HVmf+6kMXQ+ICY6mPeipy?=
 =?us-ascii?Q?15JtXRdFfmO/an84J+EujHVv3+dpgjqGcXc4fa+jrBCtwys9YXQr4Zc38wHU?=
 =?us-ascii?Q?1Zw/fYNdw2PEqPxL4Ao26bLstnlgV5Sz9+3FkxWg5SdWRwtXQXDDUoWo2cP4?=
 =?us-ascii?Q?/rF+gUlLSMqX0xzFp7NeAuiWzHHK40ZESHFhy1se531sUsO+XqWnUs5LsM9I?=
 =?us-ascii?Q?Zrov9o6MjwxWJTv812zgGA+BKU5y4EaV45gAsxj0399ZQ9EHdYKTXd+z+z76?=
 =?us-ascii?Q?QQXFAGT/OMZKUQDCc/hFcFjbR7gVguoEAqGw+bXCjwx60EV4fPBIujXUgcJe?=
 =?us-ascii?Q?pu8RP5Po3Vo0vXncxAYcYlpvWargGtUW6ODtKwvdjNpm1kDtyrRXiGRXsjUN?=
 =?us-ascii?Q?oE/QnpyyYE8xNi4iWbDaPx2DtGmjREKVhO4zy1xIJ4f1CWqsnE57CAMba77Z?=
 =?us-ascii?Q?CKJa+3Tr94S51W+ZkNvbzsaQsnsLA+wujZ+NyiGXxrIriqRHlCy2BGbix/6s?=
 =?us-ascii?Q?Bc9gRYFZuvwjYhm7tIMWj2+T7PPEb52hUhVMWB6/emSD0kwX/oxxmFUug0K5?=
 =?us-ascii?Q?yEeru0n3o0NUp2Rymc34eiJU6fKiYElend3nlziUcdI8FjJodS28QCg1rHJv?=
 =?us-ascii?Q?1baVK9LpQqT8fgcGe8cHfRkA+OiPKHSomf6cs4NHhnTTEi1ke16zGgcq6qX4?=
 =?us-ascii?Q?ojZZB8e00X5ixSMxStr0EJIRIT9wAIv96iRQUflv32MYQg++yau075FUE6P1?=
 =?us-ascii?Q?qKXxu3AMoXpzL9xE6YR9nFvsHaQbEp6MCRoUGYiPmsAuX1mLGx7K/41fxUCI?=
 =?us-ascii?Q?highTVoAnkg5dvy7sa1A28DLSB/HapUeeAdvsJpy02X+L8G4KnNqILFMP1iF?=
 =?us-ascii?Q?VkyC1f+mbimXofRQ5aWWkGfy00tWCppY3mQ4SJnndA0ew8zVA5B13usD4WH3?=
 =?us-ascii?Q?01zyFf7X0A3hAeHxb6IIstyXIAL2TM7iB29oJNzyrKaltfJI+x+iRlasb3J5?=
 =?us-ascii?Q?pRzXuCeQlnEAyS8T2e1SkoHTJwYQbhy20gdL5mFiAZ5QEkWB93lx0qmJn0CD?=
 =?us-ascii?Q?sBC0WqhXSLUFQhWTiqWRnDCwQXrT2oyAdFqlXeqlzMYiX30qODSQHaRYLX/9?=
 =?us-ascii?Q?OXqPCz3HFxqGaqSAGvbGhnuMBXUGxQt/L9T10mLq9UVudiLmuOjxiOYqkJGs?=
 =?us-ascii?Q?uR5ySAw0HZHpi4gI9oWR/B0Xzj84PL8R8ixQ9HNE7lU8aTWmD6WJODfmtu9x?=
 =?us-ascii?Q?H9EcLVh6u3E+8hxL+daLC4VUdu1KiKLY979EM1cVsiFeguAl3lE+PQ059XVj?=
 =?us-ascii?Q?fJps8HfgaYzd5ND5tuh/C6EtLRxVFWOyXbj0RPK4rIEQMneRZi9fNJet3fVd?=
 =?us-ascii?Q?ZlU+1/o57okKAwql6m/kS06w8oYL+KzE+L3yxyjb543dDvsN2hLO8LnvX3vI?=
 =?us-ascii?Q?TNGZfPi/+tMeY5rqlA4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf9b7df-5121-4e8f-85c3-08dc41bf2e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 11:34:15.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnbCSkkaymIFIhKG+W+TTajQL4wwyEWHjEq5KsRId5NsVUaU3CABkvS73qytQoLANgdNehW07hzvVuMAcNxOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5944
X-Proofpoint-ORIG-GUID: GlHP1GkT6xWLWYBIUrFEuCksDHKNDysT
X-Proofpoint-GUID: GlHP1GkT6xWLWYBIUrFEuCksDHKNDysT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02



>-----Original Message-----
>From: Breno Leitao <leitao@debian.org>
>Sent: Monday, March 11, 2024 4:55 PM
>To: David S. Miller <davem@davemloft.net>; Eric Dumazet
><edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
><pabeni@redhat.com>
>Cc: keescook@chromium.org; Ido Schimmel <idosch@nvidia.com>; Nikolay
>Aleksandrov <razor@blackwall.org>; Amit Cohen <amcohen@nvidia.com>; Petr
>Machata <petrm@nvidia.com>; Jiri Benc <jbenc@redhat.com>; Beniamino
>Galvani <b.galvani@gmail.com>; Gavin Li <gavinl@nvidia.com>; open
>list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list <linux-
>kernel@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH net-next 1/2] vxlan: Do not alloc tstats manual=
ly
>
>With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
>convert veth & vrf"), stats allocation could be done on net core
>instead of in this driver.
>
>With this new approach, the driver doesn't have to bother with error
>handling (allocation failure checking, making sure free happens in the
>right spot, etc). This is core responsibility now.
>
>Remove the allocation in the vxlan driver and leverage the network
>core allocation instead.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

>---


