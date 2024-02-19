Return-Path: <linux-kernel+bounces-71215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148B85A20E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55521C22A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467912C690;
	Mon, 19 Feb 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NWBg9NQ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W7DZjDMo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146828E39;
	Mon, 19 Feb 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342561; cv=fail; b=EHgTuhLYU86rBWQ7Mvow9TLziTIvXdsUNaNbIq+TewcotZ8jSbGK6h6YeHZLooxsXoFRNugqrQjYYz/GL4KtMMxCAZz1DegRRIMuAYjJbZ5/aSO+Mr+2guxjZndyBLLINt5nEd9ehO5SvhEcFKS8JpcWAPpl1lbfoy23/7PKd7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342561; c=relaxed/simple;
	bh=ns3hcr7r4xhYAa+yUobXqDYR/aXwXFRllOeqnPpb4R8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O4YaYimZ3sTiELA07VI1kMJjYMVGVWxJ5Kf+6seHGBmOOOLL8Y+dkuzfGaT+NucR0A86A/aKG147yZMiXOmZsLmFvOkggKh5NGHmv82y3WgPTtODza9Dbt2D2VeIDHjEarjmPpDK34fduFBObIKyHZV9nG6mTtfpUWos+VPPLT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NWBg9NQ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W7DZjDMo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OMeD005908;
	Mon, 19 Feb 2024 11:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6r0m+JeSRpgP4GCH3+G+BrBikSmVXEqZXD3jgId2H0s=;
 b=NWBg9NQ3dtwHz8d+NDi2GJh66DWg+HwqFhCaF4T1fCIC5EloF01VwoJMtpqCkZKboiAU
 36pjPWCrpyR/3ZEVsKCqCKBhmvV7JcrmJtPIIIIC68/yhZVsg+0PTzmFFzALq+kniS8h
 sWnCOy2yWQHAxWWF7krpBGo5DmHQ5k0naOGJU4TZyy2K+qgPCWkmbC3h3Jrv7DfNhdlA
 igp37BQzcSl2CPiKHxnETUJPTbn7UKmQfD6yNRXpfmlMW8jVpc5+qor2B6UbhqiA0B8x
 RT5ca8QU+SjUKbEA1U6qgB9AeUtYHLWUeVHDwYlXQrkgQYnaaGpSULahrTLSkSKOnRW9 Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc3y6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 11:35:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JBZXSD036349;
	Mon, 19 Feb 2024 11:35:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85sryu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 11:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/0GpyGofo4X0TK08P7OwE/gZacvYVYZgOnI1xgG4FwFt69fJNKm69HU0/vzOFao93+ag5zva4RK9kLJC+djA6utBpLW8j+wtSG67f5CRCvNlkzS2SOOx0JC75uNh8E5sLhLdrt36bUTG1zJHlMe9KQPDG6NpxzF7xbo6fjGjnNaJqtW2d7OZzdSDYntF7FoJXv7kgCZYntPYBu95Nnty6LMk+yf0U8jT/J2NAlg1BN2fZwezRxSzIri6wmZtIcnUEiyBl9G9E+Y3eXivdmLEE4/z9c1/NEiu5kK/VyezzFjh8xRquCIF5MfkaAJf4sNLY7EQeyVZozpxyHmWTfgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r0m+JeSRpgP4GCH3+G+BrBikSmVXEqZXD3jgId2H0s=;
 b=Z76JgUVW+bQtGqZE6vSe4b1S5Sfq8AIp7zjsyCSO5QUV08MFW4zcVv48bUfDAD2b7gTSUCHKqFqnsq1mPZTXLaHPwTVpS4YxBNez5mMeKIl+pVk48fPEi1vKIgDqKhJ/tPAbYor5du2Cpl4uqaQuhRQl7Jx/CpwPLZB3DIyd3u4qzRlPMwgIL6qTjnRK0/O8AdMjE5WzA2A7pehQucCK6bwccEHDTcHc1nT3EliRoDE6kakdnZdyw8W42Gj4XLmVRPsuZvZL9r4Ub7SNsnKpr1lZVGvlaOIQ75AAJrre84gWl45m9b6SGOsc7vdTuz8+7byltQyr3uErCUknNruYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r0m+JeSRpgP4GCH3+G+BrBikSmVXEqZXD3jgId2H0s=;
 b=W7DZjDMo+WgbjYlQWeUFgPTJ79EpQ5a3B4t1xVPIPD/c0dXEQquYAE2VKko6nK/lWoOsry/ZJICWcy1gI+Np66r9sh80eOyZ9N4an71HM/NY2RdL8JZE8tU6YwVtOv7zYAfJ2ig2trmtuKMzZ5XrV+Ce10R88IXeYAE0Az3MYv0=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by CY5PR10MB6191.namprd10.prod.outlook.com (2603:10b6:930:31::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 11:35:33 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Mon, 19 Feb 2024
 11:35:33 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
        "andy@greyhouse.net"
	<andy@greyhouse.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Topic: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Index: AQHaYDQQSI4J0p3dLk+q/3SGugGtKrEMrZSAgAHMEYCAAPWtAIACHt5Q
Date: Mon, 19 Feb 2024 11:35:32 +0000
Message-ID: 
 <SA1PR10MB6445ACE99D2BE41051BD18238C512@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240215172554.4211-1-praveen.kannoju@oracle.com>
 <Zc8k2wYZRvtfrtmW@Laptop-X1>
 <SA1PR10MB6445D15BA6BF3CD57CC690328C532@SA1PR10MB6445.namprd10.prod.outlook.com>
 <ZdF04GYACphhBCwl@Laptop-X1>
In-Reply-To: <ZdF04GYACphhBCwl@Laptop-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|CY5PR10MB6191:EE_
x-ms-office365-filtering-correlation-id: bb8b9807-1f47-41db-1c23-08dc313ee20a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kXWjiR7R2AqUFVIHKxhR1ApGyEgQP9V2sRTqOKWcoQSR+7fAKh9GC7nqGq+7GBPMESrKWKRk9vBH93Cj2yBQSjyLyAWv4UPm/wVhRqnrSDDQwpM94ZFLiXNOztXDSVzuTaehxa+lGTuN8LtgiW1ZrwZ7V4ceKaugj/R2+YQJutt5I3hG5I9yvmHWOuUOxEfWB/9fgpNpbI/vE4ThsMwDDBTY0aoI56aXFC5wwaToX1nUqkThCMfWwBE/Ht3+P3biHmbWS0sUKZ4c+M+c5jf6Oaeu0WeU+AlmrAg1uD35WjI8BPq4/Ihsa7zNRjkh68bOSF87KUA4wXHTarQ5o6ouYZCycyhtF4U6Z3Kdp2TOlIvMQYwehQAvrE3nGxWRg7HPAWVcje391IpHh3tG9plH0Tm99WR73gqPJTDmmvIcDwaj14TdTsNFSAuyuFbvJXxC18XtR9+Qxn1zZpOl/vfz4DO6VY5pGExlg+mLB02TFwKA0AWyZp5cFE+p+hlwDysLoIbtgCHaFdGKn4aFER8v5KARqoZfUS0B/UsNAGQn63yoOxKdCH+LvM3X9FeOdCLKoIY8o3fYiP3N9HiFeKVjg4ENB8i+Tfri7big+B9+yf5O+2nTdyhoS/jngH6Hdqc5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+9AkdgYKyz9aDIa2Du3v/SRYs0ALoLZT2mbY7rqnFblCJPvtJubR3Z5FxVzj?=
 =?us-ascii?Q?7nkiv29F1tTltomUg120Cdx6AK85/ZEC0s4NxQpMg0Ug+zGbfBU+BP7HpDvw?=
 =?us-ascii?Q?itZei5s2MMxz2bnUbMemOKleeDaoGiXJiR/NwMSxaUZ5RGDENRUvJgv4mftj?=
 =?us-ascii?Q?KAKiWKQ0IHUAc8AxvR4uQTZtjvWIwNrhOLomhYEe6x4aNGci51q0PcsWpKP+?=
 =?us-ascii?Q?56pYhnemvVhtaLr+7juTErKVJBMJnVNuLhYAbyE2R8LRQ/bCdRbtXTxG72Cu?=
 =?us-ascii?Q?HXfZqDsUH/2dvBXtb90BHp+RojIPtK1bFu8OVHVo5tYnpyRei2UC9Q3WOJUP?=
 =?us-ascii?Q?GVNjQ4B/1Ls4OG29/gDCqE9DHGbXlWSMEUAOx6v7v17reXJMqoSus6MHdkB/?=
 =?us-ascii?Q?ujAvkWJYg6Np/Hr4q5wOh64gn7IaamUnVbAVowgky2lDr1woYocR7bDe6IpO?=
 =?us-ascii?Q?SvCGHww/lVXCbRsRN+wAPOAFqFNEG4Dlp5s5WABHFR5iv0ZFWuwHG8qNJZAS?=
 =?us-ascii?Q?R7ZAc/oJH0yYR5PCekOy57RpE7pSkAoo6Aq7wmIz0Q+x/BLTt1u9BxsU4v2l?=
 =?us-ascii?Q?F+UL3PZNwMjaDr1hpLI5IQjZEVzIZZ4T1B8/93du18huo1BMzOaUOcsxtFa/?=
 =?us-ascii?Q?ip1BnthRIWmTX1mlYJLJBAGjM0oQ0FdsccaQgBPuSfMVC6v1032s+aJMts+4?=
 =?us-ascii?Q?tIBBqTd4c/5gWEHaahICyXk6TAmuy1PfyUlhJAz0me/yXRCvHK/eDnsFQmyI?=
 =?us-ascii?Q?vNyyrV6AiarseCjoTIXiEiJPFyfxTrQJhdShwpHrNrudxUycEE9gU3ELVljl?=
 =?us-ascii?Q?lFsNaO0i0jarerIsRZLPR3S0q9twuyziV4XSTbntL+neKPwy+kLKqkQn4SFx?=
 =?us-ascii?Q?B7DvERJX8ozkaZJbVacVEyYqRmmEIL57+KVZDRlCCNBCBWCak7n6UrHdN/qa?=
 =?us-ascii?Q?XewubwbkQbtfGY3qQzu5+X/OCMHK+9SjlvRbU39h1grLOWVejUGlCIe4YLNi?=
 =?us-ascii?Q?UbZ8QNy8FuSLHH+2kBosRhtRmXT8G1q9FAg8XnLwNyotRpw0yOFCsrabvAYV?=
 =?us-ascii?Q?D45V7qYfEekP1pgP2CsPUxgKzokh8P95hsZ6uyPlfWUFzB8xKjOzkfgPNBO9?=
 =?us-ascii?Q?hWxLGA4EdBvNLzZocpGIa+NJFX8E8MxmrigfjPbxXvHM80zowmFo/M4eXDJN?=
 =?us-ascii?Q?KnETicvjMGlF+AlSwA9HSHZfQPGsNMAdWUi6BfQqyg/neX64Ji6rg1b0v9iB?=
 =?us-ascii?Q?b9Hs0i3+TJpLfU0n7QBWSbQM7lDMBD9UHkAXnz/mG5iPOgy76E2RW9J3YHx5?=
 =?us-ascii?Q?2j7D0yaruHYrf8PbR0Gd/oWosuXZ3K1LAuiPbNzOShQ0mCzA48dMXhjL0m0C?=
 =?us-ascii?Q?FLAlPAT6QEg6nek87AXtAARalqEBzPJiVCEjpwWk21dwYJOYTjpjfYSLUYIP?=
 =?us-ascii?Q?csj8uwTUohTBJpwAHwXpx1E9XCsPioyOnOk6nYjNkap/4Swu1d9MVjbwmjqk?=
 =?us-ascii?Q?Cgtq/QviBzKAZoOmtcrh2lZtmxFMginWFLTnN0FW79zDrZOICKJvHP+TwOUw?=
 =?us-ascii?Q?GgboaNAklz8xnnhcb7SKMkszhz3rxP2i1aSj46v8cqUxRMSYuL8IowiZ4EEC?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pa+AD3JFRNLYcHkfoPgZ7Nzk9jAzQW+7t2l4pbBc2CrcJm5kcOmmQ76l+buvnmIH3UoFv5+uUdjws8u5bFQrxxIBCE8n5HNGKDS4GyVLPkvYqdKWx1mFLKIEbuSBbeOlnuSkNmYYc32kuVamqmnZ2JF0vNHfD8jwAhA6XAdWdPmC5Vz+mHTrUrySbEO54+dUtS6UDJf01pJZAldv/BNSO7cVheyj1neTZ5wxcZcOhUMoq42ZSUJ3uSwHf8Mimaz1rlaG8FkYWVdVAbudDArQM/uauFHP2rGR+ZWyM54pRGTxp+xxnDZplgTxg54yaITPtGnDCdZ4AeJVM9kFOYfPRCOlEOW7aPSg/5GJm582jyS4W3msTAkQB/bYFSgCDaPUWmIJqhvOHxx8uAH/H9582kxw61hlL5f0gGX0AANWoGSst5kP9TM0xMfRTqlZREXThOAQibpo4xgVQRoO6vIs+AcwQJlY2JvLlIdFPLE89TpPihGgK+JfpOea70QgKWYXodwsXzE/OdgxCFOf7nqBWDC4BCXTdR2w9vn/jK5vCQeCtBshkhcmxocJ0lX4ReRUgyRxnLbRAOjX4V1QFWMISHyPVi3+HiEWbrgQWtdaCmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b9807-1f47-41db-1c23-08dc313ee20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 11:35:32.9728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1a4TiNr3RjSXe5UvgWnFudG+Jp9i9mEKt0Dxcaa/7QiQC2KvwDUyZMtjK/7p28q1yiSfzAEPNjk80B1s/wjmnO8p51g5DqdvtbB8hOsTuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190087
X-Proofpoint-GUID: vX1BEjPIPsYK3_L3yv6BgVEiQKOXfj17
X-Proofpoint-ORIG-GUID: vX1BEjPIPsYK3_L3yv6BgVEiQKOXfj17



> -----Original Message-----
> From: Hangbin Liu <liuhangbin@gmail.com>
> Sent: 18 February 2024 08:39 AM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
Rajesh Sivaramasubramaniom
> <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanam=
atlu@oracle.com>; Manjunath Patil
> <manjunath.b.patil@oracle.com>
> Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messa=
ges
>=20
> On Sat, Feb 17, 2024 at 12:39:44PM +0000, Praveen Kannoju wrote:
> > > -----Original Message-----
> > > From: Hangbin Liu <liuhangbin@gmail.com>
> > > Sent: 16 February 2024 02:33 PM
> > > To: Praveen Kannoju <praveen.kannoju@oracle.com>
> > > Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net;
> > > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Rajesh
> > > Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>; Rama
> > > Nichanamatlu <rama.nichanamatlu@oracle.com>; Manjunath Patil
> > > <manjunath.b.patil@oracle.com>
> > > Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect
> > > messages
> > >
> > > On Thu, Feb 15, 2024 at 10:55:54PM +0530, Praveen Kumar Kannoju wrote=
:
> > > > Rate limit bond driver log messages, to prevent a log flood in a
> > > > run-away situation, e.g couldn't get rtnl lock. Message flood
> > > > leads to instability of system and loss of other crucial messages.
> > >
> > > Hi Praveen,
> > >
> > > The patch looks good to me. But would you please help explain why
> > > these
> > > slave_info() are chosen under net_ratelimit?
> > >
> > > Thanks
> > > Hangbin
> >
> > Thank you, Hangbin.
> >
> > The routine bond_mii_monitor() periodically inspects the slave carrier =
state in order to detect for state changes, on a state change
> internally records it and does the state change action.
> >
> > Parked-to-Parked state changes goes through transient state. As an exam=
ple for Up to Down, BOND_LINK_UP to
> BOND_LINK_DOWN, is thru BOND_LINK_FAIL.  In order to attain next parked s=
tate or transient state bond needs rtnl mutex. If in a
> situation it cannot get it, a state change wouldn't happen.  In order to =
achieve a state change as quickly as possible
> bond_mii_monitor() reschedules itself to come around after 1 msec.
>=20
> I think a large miimon downdelay/updelay setting could reduce this.
>=20
> > And every single come around reinspects the link and sees a state chang=
e compared to its internally recorded, which in reality
> internal state could be not changed earlier as failed to get rtnl lock, a=
nd throws again log indicating it sees a state change. If attaining
> rtnl mutex take long say hypothetical 5 secs, then bond logs 5000 state c=
hange message. 1 message at every 1 msec.
>=20
> Anyway, setting the rate limit do reduce the message flood. Would you ple=
ase summarise the paragraph and add it in commit
> description when post the formal patch?
>=20
> thanks
> Hangbin

Thank you very much, Hangbin.

I've added the summary on why we intend to rate-limit the messages in the c=
ommit, and re-sent the formal patch.

-
Praveen.

