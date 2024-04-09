Return-Path: <linux-kernel+bounces-137191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E4089DE8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F2A1C2186B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811831339BA;
	Tue,  9 Apr 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chw1H8nw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c5rhrnZx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAE12D210;
	Tue,  9 Apr 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675546; cv=fail; b=cVkmYlEJH75jKxRxCCw1XkODPhARK29QweIOSwuU8728yBQgsEjixTcUUI+yEw8Nq2r4VUlHFr1sMj4lHa126elYnIrPOa3sshQXYdZNm/kiakyTLgynj3C/HPyEMXFY4PzSLEF3TIpgzyK//mmvwSNhrhgf5iZe5hcE5rMng2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675546; c=relaxed/simple;
	bh=IaL9LVArVF8Ccyyf/JLwRIZsc8nekmIFW1Xd8T6iR4w=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=lXgbCvm4GJC8YvWXAaYm5gY2sSWENssaa/Q0Y02iLERyybCkkBCZU0Kmf1FJg9F8KMMO0kYos9+mLsAWzpDaNvv/b9Lj7jvLDAfiGYERAjShkcDCd1m7votMSN57qE6oXYYEYNwNEzY3cfiYmsP47yeNl9/q5a/+R1ofdSIStnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chw1H8nw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c5rhrnZx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYsFP004461;
	Tue, 9 Apr 2024 15:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=HgGPOMHNGysPXKS5s4T+4Nx0CgRhP4NXdwni67kByxY=;
 b=chw1H8nwu5wFVcy0q3mH9NmDcG1Kz2t6g5x8gWNZVfQE6/bE6fmUEohae4J1YSi43cC1
 DuEa5Nkw6GSpo4RHAfeq7NWyqPMjT3IHwuAHo4/OoxutMLFma8iHkA2kpR+bdf4ErFFe
 lDEP9GrosfzMfJJrCmHg9W7rRlllahXYton5MJdMCfxpaKpRVGgqHReNDTKFGgDPfG+G
 4AWqJO/czXs+7a/Lwf7mAtmWLcNGp/gZnrnsmxzPIsYSiDpWp4L/KQpP2Pbwa5NCCWj0
 iddLjPRdNNOdF8GFzG9/af5p7g2yDiXwYLGekekDhtGN3Udt3rpP/PwVGKXk/3MC/Dqa Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvd77d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:11:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439F98oN039976;
	Tue, 9 Apr 2024 15:11:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud4eyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJsySVe8oEjOzdobAhv5OO5mUjSkWxJ5nOt5wTeU2dbrotNcywOvqbP7+V4zaj2mDTLOi57ePyMMH8xkbrhrkGZABW7NZc3t/8EnFRAwNUDW7uBCJuhEtOOqkRaQeIh1ja4Z5ApMkrd3sNhpiwHeCu/ysK5IxAPITFNOvM610CwEux46otsW7g36sEPUOl3e+Ef38FplzHL+RemhCoclKnVT7Vxb+tt9w2TV4rdMvGoPy9Cuhytj4TBx0YH1yk60ouDnqvvqeaFsrxtn3glxKWeoESulxO6n7fRODuRtFFvff2OCyYP0fh1Ekf3cpLqiFYXvTH9PiZtcvpihYOTyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgGPOMHNGysPXKS5s4T+4Nx0CgRhP4NXdwni67kByxY=;
 b=g8x7/xIHbXc8LXFNfm27jbBAlIRaGJ/KjMbpSgK8e0GbCT6HfYh5IBFt4/6x7765MnQsTyt4IT9qe0grQDCcIlchBDbe9Du3xd+uFYmZiFlLHHFmLl8NIJLMtEBsZ7lJ5tAbJEemqyKPaR9U+CEA4v2oILJnXGi8CUq3afupaBuObmyC6Zh6qXP4D157zczodyK2HQV/flHKEWvtTpDDP8takPWxYBVOB8FUKaBG4St/JvTadY203egrE5tKh5UVTCrFXYjHygFr9ktHzNhs+5I/XV4Jjw28yEvAwAQfX+k39UShcBgUQSCkxmea6uC0UDC7UyOmdWWIu59jfVn0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgGPOMHNGysPXKS5s4T+4Nx0CgRhP4NXdwni67kByxY=;
 b=c5rhrnZxPxcfVx9cn7Q8EtXgVgfBdgyyT+n8D3Rr/0ADZBLzK1xsEOfv68cGE7ef0BtPTY8Atp6COyhwxFKwhy6+mQ0elCuK8qpK7BcYACfofDrqLGcY9hM4AW8nZ9FmuUzSobC8UbtPoZ6MpNO7hBN568m+EMBtt0Khzi+o1nA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB6747.namprd10.prod.outlook.com (2603:10b6:208:43d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 15:11:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 15:11:43 +0000
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        bvanassche@acm.org, Alexander@wetzel-home.de
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>
	(Anders Roxell's message of "Tue, 9 Apr 2024 15:07:24 +0200")
Organization: Oracle Corporation
Message-ID: <yq1cyqyo9o3.fsf@ca-mkp.ca.oracle.com>
References: <20240408125309.280181634@linuxfoundation.org>
	<CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>
Date: Tue, 09 Apr 2024 11:11:41 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB6747:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oigkfdSs4lX6RuybLaeyl6P1FxFN0KO+GXefXFp3r6RSFWkxlQdJotqaa2sqPjqvfUchgDbAEGnqn8YlBYVAi0JVgBRXSYBabCIzhJg+oxeZZJc0k0NY27J7LmwB9JhctyelMrEbl28u3rqhN+I9q3V/3urb63XJJwKUTM/wYGMy95tdtS0l4QPDga2fyQG9xumnS65Xh5ScnPZkF4DMArtC+7zd1Zr8e+XwAKlnaVyaWgOMby1eNy8LxDmk1rLlhhvRNPhipy3lfjcK1ir4/liQxbEiEQAfzCEU3bfZojojMCkhav/9SyglviDIW/lvcC0LPQN/JBPuwZCmv2SaIRmY4dgaKPBVm9aY+Fg1FlQ6AuLJj4TIJF+y+cG4lF/Gw+4F5oVXa86PWEBts+K8uyl72CLkxZ/Pwoe7EF1r/S9+qhTzZqx750jNten+bRaBrggJnMGF8LzpTnjlZqNZiqz41SUcdMZlbIDm26XLvrI/SAvqnzAFiy1FrllBI2aQhnv261ZJ9NP4Wtej0tY0x188P4WkR8byv9tE2dAyd6GaGKET/aAe3769BGRHtrpcXkfEe9+cXMSsrZpHrPESneKJf/IBaMxLx4QGMUSkbUmLPCWxxC/xM2EoLLBnvAQZUfjka49q8lptXhbwoUw4xOd9XAo2Zp8antmS2qBh8Yw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?euRU7B1tnvL5bqw5ROun10vyebAoW7sHUcfEaNPxauUCJu4UmA0fUMKiWNAA?=
 =?us-ascii?Q?YBZz7v6/Q5XZlz9nrqWdLjKb29O99CziW7dbIcjawxFoBa0sa+fgwM5Jiuaf?=
 =?us-ascii?Q?qjCmiNY4kSgJXF2R16l8dkSzmh488d8WCa6MV0TayI418B5JQQ5Vqioz+GIe?=
 =?us-ascii?Q?V+GeuNKy+RBvZZ/8TVowra49aOYLAoYBPqzS86jL3A7ha8kNhAWTX1WtinGk?=
 =?us-ascii?Q?JM46nWCsL2yV6t6TwZlcWluQ7NtXygGRbveX8uhI+XqpqeTSDs8Def8W/T1Z?=
 =?us-ascii?Q?4pBsQfy+hgCdxwxTOl6LuEn/ZBaBosmvamO+pJseW0kcG1vBlYTqN+uiW/Fz?=
 =?us-ascii?Q?JR6VOV4Jw6z1OBS72N7SduTyvLwdya56LGcQ1Ok7vD2YEilLkjuq+c/RxFIy?=
 =?us-ascii?Q?AE0GjDgZ0v4nQqyOHPryymr/5f9fmbzXTJLGFUc+sYvymdXGeP5RXW9uzrV7?=
 =?us-ascii?Q?8Qfi5CjXptIsi3OICHbKBBnQJENnys7VaBssfbsUq5pD2f2tMy3XUcNuCWyh?=
 =?us-ascii?Q?VfIgLJ1rWm7GPrLx3HJnJ6qS6+XgudLBo1AS0DPIwC+2d2y/2+5wTplPuGpV?=
 =?us-ascii?Q?0aOq8vcROGGVF9vwe7HmAY4wmmR55lKbf9eAoptFA3c6P939Y8tZh7SZXggx?=
 =?us-ascii?Q?TrvLzvvuK1NZ803I7y5mBCLFI8p5WEu9ZNFLp361rNyaIWqt/m5YOl8F0f7e?=
 =?us-ascii?Q?xr3To9wcHLPLzq42w/XBL6pVjOiDtOEVaJKCxS61XDJ9jjFDORkqY0dosQRY?=
 =?us-ascii?Q?tXYCzPYQwLLaQc621Uit6pbTbIVr9PvspDGB31S5CWaBaiNuUp11NwsAC72q?=
 =?us-ascii?Q?iPYCGgyBj9GxSbaceIi7OodS/B0Hx9bwwzB0Pgi9eA2ZC9Ae4MYRNWqdAHTM?=
 =?us-ascii?Q?9GYvm1E5vv/udCEF1A2AJXvwokJxbuI/Gli0SGUGnq4x3glqIYU0eC86/WG/?=
 =?us-ascii?Q?0Uu/trs7x/aSpk+Ck9LCU1+ro/lZl3GFRV3hySWapUFVJ70Gxmg0DQgT7P81?=
 =?us-ascii?Q?F6X+4XBgpSStBdzZXUisjdE8mS/HMADjYkeksj4krSdZdm7rd+MEeTdS4XN4?=
 =?us-ascii?Q?BnfgWqCHhkYBzbXwOsfYAht09846Vm40HRr5880unyjIXVgZ7atsHt/EH9l3?=
 =?us-ascii?Q?ahVeFMfUxkIkbA+I+N6Jq+Hwhd9XhKztC1uX/EYCskM1i5F4goNz3r5jx4g3?=
 =?us-ascii?Q?qYDKxaL9J9fRWoCIZOr50KS1Efv4yAdc2SH1v9CxtfpEyNo8l+GedIh2hP+B?=
 =?us-ascii?Q?ijC130ba3w0yiCeGNG5SyN4ljmftstVqk/HU19PRf5WCMsmA1L4ofP/nb6+9?=
 =?us-ascii?Q?GZz6oAUjyE8dZTQBQOC7o1+/+wwU+cxgBcaUbifQbJQfK4MGyN1BloR1GEfM?=
 =?us-ascii?Q?ca4RFx1YA6Bim5bWVoMCpm1tjaHGUz5rif1LDePOXRqLg10ckcASEjUw4TK/?=
 =?us-ascii?Q?aQcbPSPQQ1Uate+4KvJXhlsCuztCSHYW4Met5LfFHs63vtUl9sPE663YrNat?=
 =?us-ascii?Q?JVtC80vx/uE0594YLNdOOsAKW/gyFoUXXptIKX63gMkMV54j5XiZV7XRFb3K?=
 =?us-ascii?Q?8qXiVOCGQp52UBLw8TUNC/Pdmtz0YRCrzTDfO6MO5G+4Zb8GJ8IBZO20unZU?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vFMZgqxv+sNUfUgD1bLQ0TNBKjeHIRvhlWEhtXcg9BTPjj/iXu12h8LKNg9OZMZohLwYl4cciJ10ETplnasAZzkDg0oG7DKOgj9Z0tTCCW2VYiqGindch0yQ96dBsHMIGCZZFFND8PW065i+tSBOncL6/kAZAXzr1+WsfieieS3WnWwS+uaGhy5UNkCUvffqeVTvdFH5y6BQXqz2Y1y9JfQWlhI4sZ+XdyZRyQGpdQua1jP6SmpWMGldsk3QcTqfkNzWKcwfOv8RI08nDWL10RjVymmbde2N0GAZmerzRJ/JtXmIaA34NMKt5AZMIWBA7+DeIpvVXIb6B0ZFrF+9EFILuEK6VRMgtO8Vq07wIumcoZQeGkc0VN68zS4TQGsq+gD+aOapOaQZs4cJBtpVUh0OOdMT0WIIlwgTC0EW8ukNUtZ0bqjjbVNyF6kHVTL0gheWN347QoTMxghozjzMwBcLOWMQV61JJO9MzU9ZOXt3aMzJYrSNKaJ7Ft+p1VXnNxDnQqicEnkwfbXaVp/eoNiDDfDWRBz00PTwOmw3PTVir0FJlFkUQJv852Giiu6shc8KpCoN8pNxR7q9xo/gmj8lyUvrlIbTStTby2KFlpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8883515a-5447-43f1-eb54-08dc58a75dce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:11:43.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlvLTb4RJJ9lpkw/8bq/W3wj3VTjBSU0InB3+qLNM87uvaW7G5kgpdI9Dc3xyEv9lUq7Jncjc/qP87hmQugraKMY4uDG3Nibuyj5FNxIxO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=771
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090099
X-Proofpoint-ORIG-GUID: LHKKIe8x_3sjHPpH1rS_7CD2FKSLVlnx
X-Proofpoint-GUID: LHKKIe8x_3sjHPpH1rS_7CD2FKSLVlnx


Anders,

> Reverted this patch and I couldn't see the repoted warning.
> scsi: sg: Avoid sg device teardown race
> [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]

Fix is here:

  https://git.kernel.org/mkp/scsi/c/d4e655c49f47

-- 
Martin K. Petersen	Oracle Linux Engineering

