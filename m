Return-Path: <linux-kernel+bounces-77685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A68608FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FCA285210
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DCC2E9;
	Fri, 23 Feb 2024 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="TJFzQKz5"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06CBE68;
	Fri, 23 Feb 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656427; cv=fail; b=VT2X/gxy28TaKaS0xOisqKKnInrSkm84+2vbW1Zk6VwpmSzThw0hQxxD4+EJ4gaABsKnukfBO6L1lFgeTfkHQG+aHu9N418lE9cEEmJZjNUJMyqpfvNbP1e44H7z6AFtTNmdir+mYEaey1eYGwz9GHWs3CMIbJr7wOavEMU9NzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656427; c=relaxed/simple;
	bh=SDdARfKfdQBbZ0HmYOGuix/S82PBCkBo0Czh+oVlTHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYMk89XZf/KjruiJKO9bbPL+f532bMXMTjnA93SnqRjue//soO0IobAk7GfoOlW5UxiLpb3MZOfeF9yGdp4wLCIBGJSKLuUQ+h0MgBam8FEc7nLgPJwh9EkHouJaZ6+w+vFGb8lPmz3Zza91Fr+q25KsOI8ZJNaYYDO4lJVrdXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=TJFzQKz5; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ML8vSI003174;
	Thu, 22 Feb 2024 18:46:49 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wedwxh0bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUvIP1/gU0P9z+hYe7CbYHt1whvi1V1+t/jvAfzoS0lSnA52KSkBIKstRwmr3cafEFLJXnpwNgcxyH0bqBtX30uyffyOy92zr4yHkCICOVttsYima56y3xa5j5y9ar39y86HumsHZZ1dMINI1xw4XxoFmk6h6dUnuYl+pJ222pmpULtPGDgFabPKu0iHq9RubnigVXxjnQ9vhsE+22nD2miVg8EAdVGgo8Oih4jj/MWOdCIGuy9Tmg1QuGlICRxqVJC5lTsK1chOZCN+TGSGI0Ysmqk/EYx44wnyzpDeEfu3y7WB3FbS7EWVE9a0S+EfVAsT/NzpVgB3c5r4h1gwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j1lhO5GUCjgUXqV09PwkknPhmJ+A+MSHPXraiqWZlA=;
 b=eYkq3pytHQQggBY9G+XRq+Ow57WaVK/7tKJ3HAz3uKF/y1Hs+s0Pl32CgXfXcF/FbRbQ7TWPnUzduzrXA0xz1NPmbLY6Ytq4XoZb6h9GqSukhztUecqnppJwtkOpR1uRepmpVou7R7yrvEB9q20hZ5J/2lOSputjkcLJzv+njyoM1y9VrgnClZZt+X01NWYqLs8xx2hFK7hbT1BCVhRHPf5vkA7g79WOh/A1qbvwLSwGwAyx6w4J35pPOne4MFzqN/BJBGkaNCH/G4jb94JMqOMT0M5EHZqdRVfZBzdgyM3938P/+AY568ULlCVghCFpugRy6L5YcYHlKgQizvrTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j1lhO5GUCjgUXqV09PwkknPhmJ+A+MSHPXraiqWZlA=;
 b=TJFzQKz51V23KQz3bTCqfSh8yzRhC7XuJ6Vlll5zh/Jp8DekFR07Hs2QG7FpPHyAcaGyZ7usoFqk+1WDNtvtsFFMKaJXlPWPj7N1YD1vSU1NLW9D75XFCKbVlVSVkNz+RFDqrEjAai85mkatNbhczwnsu4rf1Xia2kvmYBBNjtE=
Received: from CO1PR18MB4747.namprd18.prod.outlook.com (2603:10b6:303:ea::11)
 by DM4PR18MB4317.namprd18.prod.outlook.com (2603:10b6:5:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 02:46:30 +0000
Received: from CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::fd48:332b:9883:975c]) by CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::fd48:332b:9883:975c%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 02:46:29 +0000
From: Sathesh B Edara <sedara@marvell.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
Thread-Topic: [EXT] [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
Thread-Index: AQHaZLQc2PHJI8aldE62LCazUw3497EXOvPg
Date: Fri, 23 Feb 2024 02:46:29 +0000
Message-ID: 
 <CO1PR18MB4747A59CE68A1A1A80953484D8552@CO1PR18MB4747.namprd18.prod.outlook.com>
References: 
 <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
In-Reply-To: 
 <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4747:EE_|DM4PR18MB4317:EE_
x-ms-office365-filtering-correlation-id: aec0e491-4313-4731-f173-08dc3419a338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RwubK/7jAC85Yl+1rHztutd39SMCZ9jFt15D0IIeyDOKuZSI/uNXzpyH5ODdyZPSZyNhPCkMZgpXAUIgjkHeR6pYsQe0q8SOUOqa2E4hObdj0rdyoz9ETCJGmMfEr0grfcckYuX1xAZENm6isq6iqSlg4QUKtxtDh7dX6h94ds4iO5fCd0jRzNteHTr+vc1TIcgCmcrmajml0wB4nmmhlhnWOQ1Eu0VEuzhoAc2SCsr3X6skizSn8YDVKnZg5DljrlHTLuE3r2OH0/dFW8XOBxp1I1NNRykchDTruyKDTaHxmo1by19xhQokMiFazQjJjO9b1phY/CZjwIo0Nx4cX5kOEV3z2PpX3+Y6jj64kZJoJVc/okO6A2tJNuhDH0Cb97ZuwK9sEv/4FGjmj9AIyKf7WPtpT1g7b8Vbm1l9L/TAOMbdjZOzegMACPmeoNElfgD29hJEQi9mYdjsd67PwjhItzlDdqn/q3juMshmz7zqrMS+8GgJxzadX5tGVV/2ChRrAe8TyOTpecIfk7NQitU2vq/S/6QE6xqWUYshpdRUVCyjfKRjKx9FUXjgLpUf0GhG38b3ot2g4s7L1oP2FMi6TdFrGv5hYgS3DYCJyLI0ydaiAXeNL+hIN1T98zLW
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4747.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KKLOIJ+dGvqaz+dfHA7V/I61nT5XIWGWfh6+tHstLLiHvza1jBD5EIjNl4B6?=
 =?us-ascii?Q?raW4au+lCoROsjqLAcA1jEEPpxWy32wmab12GJrQMvQd+jCHntf8Petn75hS?=
 =?us-ascii?Q?DPsrh/jfABmCwPG+19LVj2twzTMrlZvHNbH2J7+EfZspYzTyQPsYyU2ploqp?=
 =?us-ascii?Q?6+xLtgkkgzth2U8eO68C5Udhzs3TlWZrt2PfXctEsV7Vhx3nJw2RdQF/cnvw?=
 =?us-ascii?Q?FeKT6WBhgsROZuMhsyHLeEk6Ky20CV8BAHf/r5QI7TyAvUHPtRIt3LGjV+bD?=
 =?us-ascii?Q?FkjkW9XhVW/HqVW0wiOcCajAeV6OgqQmgYzvriT/X4G1IMyLFA7VkUquJChc?=
 =?us-ascii?Q?d2/TCR4PUqe+bUU7BCxgkJyEhi6dTaZzsq0WvNaG55WnhVOx7+53J9ynJdLU?=
 =?us-ascii?Q?/mjw7h0mVPS/eTgPYaDYiuITTW807tFPNQoYuAUuAoNBiTM1NJbzXCUDv5ib?=
 =?us-ascii?Q?ZX/0K5kO5Zt83L3LbGJ5jxH5RDBpWtvb57dLbJz6dsQteg0r5kmJU3JX43vf?=
 =?us-ascii?Q?BhBhhHaqoPnGmPKnXsWOu4/9+ymy6t7lJzGfw1Xzq9LO4FB58mwuRFT4ny89?=
 =?us-ascii?Q?Y7G7u7J5rGaJ8OpirdGzMl/9yMk7F5iLeUQfNxZeY7M70Tg3jMk+f8IfGDlR?=
 =?us-ascii?Q?x6c1o4O296NM/P3EKqYSR5hLiD7gJ/fahMJ/tqH9YZjXhM/euMMGmgAdc2A1?=
 =?us-ascii?Q?ErCFI5hwxatGJ0ZVJeINzVQqP8uz+WvNzm5ZnXPgRdItYSjPmydbDMOsK2Gz?=
 =?us-ascii?Q?6V3abz1siy4j6aBKKbQ1KSCCAHyckvdHxB3LOyMDEISjPH2Mptp/MAoZ2F4c?=
 =?us-ascii?Q?HLiHgYLHCM2FDFdSaIUV9GeQby8Wh4AdrdsG5eSOpmdy2pPf9nZ907w1981M?=
 =?us-ascii?Q?rnXy2I3s4kLtkRLU1UTS6jBK1QeQafYAnngg9dIiDX3F0JHxHUkp7sK/EU5M?=
 =?us-ascii?Q?UPLmut2oosr6ptZ35D4YfceMjjmjPbmoaH+5+gXKjmqgsOzKvoA2pLJ4grFX?=
 =?us-ascii?Q?IE1QQwliyQ5U61SVvXMae6vXLS8h70hOWJoDbfeifG+51iTAoStJRrfs6J4I?=
 =?us-ascii?Q?tR4ifQxptJFJQzAof8qtQ9jbbL4V8dsuJ53KgKqHLYTg342d6wWcv/O3TMm/?=
 =?us-ascii?Q?q07W5u1eh7GZwxIwAGQXACuhVB8iR37tieA3U/gULdDkFkavckBMZAPuuhl0?=
 =?us-ascii?Q?yOCBC0ApP8fiTOESkD/efuR46gn+u9wjbvR/jXvxNgDeauag94f3YR6mEPMb?=
 =?us-ascii?Q?hR4bJI7fmT/op52AHUdQfECDSFMeJNtJPBarcv8CFhyNUB52IvuRNMFSV4q0?=
 =?us-ascii?Q?xFmWoOoSC4wS9o/PhzR2k3MxZP/9DWb1LJpg997er1TYvVKG7AvhM1eT6IQa?=
 =?us-ascii?Q?W94E2DHlM52Tpx8LctozzI/n4HVcUB3/+sFaDHB7vpreKH18TGxdW1S+NvlA?=
 =?us-ascii?Q?VPZKsHdmUP3/4uM+s+S7qIZJ+j5Ftat1OwnGIJuAyHLyvFzlErcklQ9L9sJQ?=
 =?us-ascii?Q?ucdwf7Cl3rPt/HW8fDX2cFnPGdfVfFAlE0fxu1kjGieYUffp2dEb+Xncvrv1?=
 =?us-ascii?Q?aAzGC3J3KB5+aKBeO34=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4747.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec0e491-4313-4731-f173-08dc3419a338
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 02:46:29.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRa0b9UDX6OWF8A+TUVCYrVozpfur+lBlo973Rv0BxDO5117ZDz/r6Q99vaqE4zFXdeG2IU0ffLrtel4ScmPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4317
X-Proofpoint-GUID: Qy4FOaG5DTEDtUv3swHiUchXb6YVumDW
X-Proofpoint-ORIG-GUID: Qy4FOaG5DTEDtUv3swHiUchXb6YVumDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02



-----Original Message-----
From: Geert Uytterhoeven <geert+renesas@glider.be>=20
Sent: Wednesday, February 21, 2024 4:23 PM
To: Veerasenareddy Burru <vburru@marvell.com>; Sathesh B Edara <sedara@marv=
ell.com>; Shinas Rasheed <srasheed@marvell.com>; Satananda Burla <sburla@ma=
rvell.com>; David S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@=
google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.c=
om>
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Geert Uytterhoeve=
n <geert+renesas@glider.be>
Subject: [EXT] [PATCH] [net-next] octeon_ep_vf: Improve help text grammar

External Email

----------------------------------------------------------------------
Add missing articles.
Fix plural vs. singular.
Fix present vs. future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig b/drivers/ne=
t/ethernet/marvell/octeon_ep_vf/Kconfig
index dbd1267bda0c00e3..e371a3ef0c49a1d7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
@@ -8,12 +8,12 @@ config OCTEON_EP_VF
 	depends on 64BIT
 	depends on PCI
 	help
-	  This driver supports networking functionality of Marvell's
+	  This driver supports the networking functionality of Marvell's
 	  Octeon PCI Endpoint NIC VF.
=20
-	  To know the list of devices supported by this driver, refer
+	  To know the list of devices supported by this driver, refer to the
 	  documentation in
 	  <file:Documentation/networking/device_drivers/ethernet/marvell/octeon_e=
p_vf.rst>.
=20
-	  To compile this drivers as a module, choose M here. Name of the
-	  module is octeon_ep_vf.
+	  To compile this driver as a module, choose M here.
+	  The name of the module will be octeon_ep_vf.
--=20
2.34.1
Reviewed-by: Sathesh B Edara <sedara@marvell.com>


