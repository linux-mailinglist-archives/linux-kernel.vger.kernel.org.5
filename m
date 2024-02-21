Return-Path: <linux-kernel+bounces-74060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AD85CF71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A926C284AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49939AF6;
	Wed, 21 Feb 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EaSPdcaW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R+er65N+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698A39879;
	Wed, 21 Feb 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492305; cv=fail; b=rqfNPM5PvbRSlmO8GBBr4+TGtYDDTq7Y9J9EN6SN/89t+k1AqYZc0t2nyyMYwBDVn3RC9g+vOLmhVqsBUe3RNSuhRmlpMODM7JhyCAuLDV2cCxRAq5K+EziKnmI8rgnGBGqfUVW4RbXcbjdt/DYPAb8er1toizVtc1Fl3QcUqU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492305; c=relaxed/simple;
	bh=VKDlR9llZfCE0numFzJGPGTfMIhf6iWEQyc+hhJ8W0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5qdwLIbSurSNjvvfiWu8Lar31RHhTr8P1kG4fg36b6RX75Y1aUbvsuTNQuQaXGEhVuwmMxqOODdeCoVBwCkuXlkV3aO/+1rfDpCetRZGNpnIjzfmOPBqMVovTdHp8otqeoJ0WxSuHPhiZCmh6gNEajGTcHoY2euj4iPbexGoEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EaSPdcaW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R+er65N+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L1SMJO016084;
	Wed, 21 Feb 2024 05:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nSqAJszWGPhKKtoP5liMkzobxdWmH2SQspwO9nqiMf4=;
 b=EaSPdcaW8BQiE8OzO1wQ6xVxDZCFIV9zRDTRpycpR/iV73HHbuaPMl7HhAwzl/YOdrr1
 XSfI5fDskLIUSKMimc6GMrYKmhecyWc/r4zaaOHE+VWK5VG546GFJHaeK7ROfrd09FN2
 k3ammLrKHebWSnkCypOM6mwKH9U0EI4nMX8wH1qsc+y1Q50meQIQ2T3p48Emmv3qCaRG
 qvh1a7MkpERn0NUaKz+cjwblmOV0pssj8XJ0sGq0VlwifE+IT+64+x0qTIHHlab7s9ff
 vziPA9IM3SbWDLxfp+NJMSy9E+HRR3N1yiGhwhuxVc7CpOz4OIWDzMaPvChI+gLqjzLh GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc8rqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 05:11:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L4PdAk013043;
	Wed, 21 Feb 2024 05:11:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88d4s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 05:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd+em7VDjdppOS5IcWaay7Y1fqWNrXLYVXKDsvUUmYFyBZzqxh75UE/mmOkdDZsVkMRQJByC93AX15Ek/0+4Nhc1kZc8iwxkHZFvtzLfkM3GGHFKgPESLF9EQjNRG+HiPcyEH82ao57SyXaLWUzJoar8ywXNwUf+WvvHRKgqw7sTEIk7nxTqEaHC34n5GXk0bF5xppRD4HK4CdxOQpe1GMv9QC0zUYmMNJbC5O440o5OZBEvbAPQEaFDB1WCH8xu7NTpDFxRN3q+Q5xcJLPRIfwGRgFYGs7/v2aM+TC3YFou912oQQcDc6+D2XQddVyh3cf9dubdK1F/myF27nup4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSqAJszWGPhKKtoP5liMkzobxdWmH2SQspwO9nqiMf4=;
 b=NeEGQCwUuFD837U6CNttSNw2dlHXvu7QuwNSNe3AjvTAqyOV5rQ+DNL0GeKLNSxy4ShlrIPb3BY1NZYvTcttMwb2xovvOls5bbl7o1OqXTUPECwj8w0uaabuScAJM+3pSIlBjpdorHhx4Zz/QjQsmcnxRjvkyTwyN+IAQabSGw97cltQ0ErXWMOxli1VFC5XlL2OnHUTR6/fpEN0bW1NzbI2ZbXk1MbjiWHlPRvfqOk9itJko7/zJ/cEGTnIR/xQyw0aIzE+x/LRn/V5/YSXKsHFMY1iQ0dXT3MxhGmwzBd8E37bwMy0GeHRMyClPNDnYufuXvu3YsjhrdMSWXQW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSqAJszWGPhKKtoP5liMkzobxdWmH2SQspwO9nqiMf4=;
 b=R+er65N++qPc9QGzHyxngmb+0JvQfVIaDM8BIMDi+fQSQt6mW3RLXTJ3G4ZzwNCCNDRzR/vEdK9JR7fIsDQVgz7I3QQ67Pbw8WF3XGCbSL/lagqFt/hoJsJ05U7VZfm/NcRkoSS38UUZMwM2FF3hZ0njBRx1hLWTX002layPhJ8=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 05:11:32 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Wed, 21 Feb 2024
 05:11:31 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Simon Horman <horms@kernel.org>
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
Subject: RE: [PATCH net-next v4] bonding: rate-limit bonding driver inspect
 messages
Thread-Topic: [PATCH net-next v4] bonding: rate-limit bonding driver inspect
 messages
Thread-Index: AQHaY7pT1u4CXCMlvk+k7R7DJ0sbGLETNBaAgAEMn1A=
Date: Wed, 21 Feb 2024 05:11:31 +0000
Message-ID: 
 <SA1PR10MB6445000872253BE2227052F38C572@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240220050437.5623-1-praveen.kannoju@oracle.com>
 <20240220130735.GI40273@kernel.org>
In-Reply-To: <20240220130735.GI40273@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|CH0PR10MB7533:EE_
x-ms-office365-filtering-correlation-id: c9ec6ed8-8dc6-498a-a62b-08dc329b9151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /Hu6crxYyn5jhX+pxt6Tvsit5HfpIGhBa1LK3G4MGQ/+DJT7lYTKYn7YBjKiOMbx50FD1o1BRXmLh9EIR7BcX00F3IlUEQO1SquAe46Wo6uVNLkmcnfQawhNolfWH5T+YxoWtVndxGBfE4PmZ8fJRe1FrTuEZkq/ivBzU1YNP0KvazIaFjF7eYm9G2UlatCWAAvh0SzQMrb3a4mZDSE44bX9sq0yLkaCVi6kxbJwAhJ6t0FPWzgYqr1VeBKvaQObsxCmVHIpLkKL6RcnD4pcyoC0zOUHc/BN38c0TPlwV0u12ABDCxpejvcAiVmItH9XKDN3Va5q3MG1ujARPYzDS3h+OckV6l2bXQLa+6Grgi4ich4GAOrKdw8xOOWD6JTkV/olqyeRtt02daZ79JOsufbx7nUNmw/ZXxDtTb2eljl9WgxLimK4ccJGiTQCd2o6ekQ6OR6bJURytfEmpo2wc0kaOPlwC5DsIaYKNF2Rc3eDQ1+2IUO7w+T84/4CoozFA3ar+6VJD8iOgXVCSMaOpKnfA4vOqqK6Ifq+mHTKeVtRahWEcL8qSaKNScozkVPfRbNsC9MGBycTzDPwNARBXmH3G6rmjqnpGSAXkoOsjBU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yEyeCax9ax7YfeQt2puJtRX99kw/VusIejNYSnvu/WOR3crMyjXxceb0DYtr?=
 =?us-ascii?Q?Wj0lwrVlHbxMPuCdJk2DZ8qodaAgbwNVc7qBY7TY+u/Rmx6i19rdSGf84ul4?=
 =?us-ascii?Q?Y+0bm+7ANTGH070sZks0rl9+uezkS/O8TmXsyt4623OIgJYKU6BoMPbxtg8+?=
 =?us-ascii?Q?5KPcQVTr4Eai0T7pwS/QmoHpWBvx4srh/oxCpGeA5443o81HEJuHu8WmgLEB?=
 =?us-ascii?Q?oFPjWd1ZFWxBjAS4fRmokoZeEbkqs+pG8v0jTkVBsvlJYUk0Bz8O1cJ33DBK?=
 =?us-ascii?Q?rro1qBzmhKVAq6a1I4gpCZ0IFUDU7D9snOhgkARuIcbocU7C7tKSoCFkf8ue?=
 =?us-ascii?Q?eHzzKHz6T1EZ+VG6NBogKTthaBl/hDG83/NMdn42ESvTm/cpkeH4ichuG8j+?=
 =?us-ascii?Q?zZg23+6TTco4om1o4QcmbWu+Y3qICQVvQP3vQiqut6zKFsiAMiXPfcYHssmC?=
 =?us-ascii?Q?8hGQqV3y64xjDbNly36o/atO8lpRC+5ersGqlt6M8dsYKm9sdjdP54lQCRkw?=
 =?us-ascii?Q?RTc97rZ04cdwPzJtkoq7GZGigYttmPRA84HCGJ9cfn8yZO7eS2U9761PN8Ux?=
 =?us-ascii?Q?TN0tbHeOsCNtPqOVx2hfknZx9fcIunRriDtFr4Tss0UxoFP97QiyVWlBwwTC?=
 =?us-ascii?Q?1GUuR5Tis9M+pzb+rHGYi1JlDyiYEEkbrpUjM3rCVPEHVmEwyr8hj0VbzkWc?=
 =?us-ascii?Q?TSwVLRqgRi9dx0QZnQMbpBluWEqH5cf0qqqWf+ofTJDpw1+2PD2gHkkancTn?=
 =?us-ascii?Q?GOh1o5JFZfqtkfC0U8oWDvbsiLrs0zzl/LNrdWlh7QrNVx8oxNlt/tuNQHE0?=
 =?us-ascii?Q?y7pDvHqhlt22LUjogjSEHjOoLdh3DGN0wSmfaDdVUTOQrJQYJKS5jiOSEFbR?=
 =?us-ascii?Q?6YEjWA8rSwc8+Z34gmU4Jo74gReMK5Fh6tthHAJlp2PGJG+WQC66BjmSAkKn?=
 =?us-ascii?Q?gFT7H+ZbL0qT1o+XP3Rpt/KX0uPPRhltEFgH54L1TeK67V+0w5KBlMC+sLPa?=
 =?us-ascii?Q?abwfEz+q5sL/v5Zaw1nl3CABaEJtuc8P+wcbzoKYIjox5IlacAFdpLz57G6H?=
 =?us-ascii?Q?ZK76xbCKgFj9AvnXi+kSGd5YXesD+s/ks2pmnp7prF3vuDE4yFk3WFLO7sRj?=
 =?us-ascii?Q?941IqWOHS99VOGi+x7DKcDzRJ0Xtptj7yojzGIVmC6dBo2LjFm0fZmgnoqOK?=
 =?us-ascii?Q?E8VysC9ayaVug2if6bYKeTdZ11tFoZmtAKbaxUA0EwCebdQv9bgakPK4sC5c?=
 =?us-ascii?Q?jkHXfchSW4LgVr4dr27i9RuoPGngnH5TV7wZcUL7OBhAHFw0uaWg3mAvFCjQ?=
 =?us-ascii?Q?lR7KNRmF+/sSw+SxxwTFwSJI+cxJI43Lg/Q0rt7E814L2tm+D3TWs4SIR6rl?=
 =?us-ascii?Q?JiPVZSA4JTIfEMFf/neZRYzOyIEpDo4wgWtxMbTliTO/G//UAVVaWFapzGUX?=
 =?us-ascii?Q?FTw+1trkweIX84r5RdqQ9XRlHLO6MAZNjAkCsnQjebUNzmmxC6hKLeBfCmW1?=
 =?us-ascii?Q?PP4y3q7QQHIZIzZO4hBEymg0YlIgNjdyz4zDHakoBryN3xaecuLI6bVth0Jp?=
 =?us-ascii?Q?t4w8olcpsTdQJuDY55a3rGSrcGqvRSYWwyuGZi5OGXQ77TEOL/5ugy2iSlOp?=
 =?us-ascii?Q?bg=3D=3D?=
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
	vREvTfmsmgZOUT8jb79gFBZT9L3ZgpNnZXohL+fGOgeie7d575j44A4+LtCXTkfWzg2+zlNs7/wm6weF4R+RI/pLYcgctYNpVgWIKG1LD1EtVKlUgkNscgS0Xgbiv0dNu7UO3nstN84S82t7I0D+tlDGnRJ2cIDvAxwu8ecdqZJyly2ZXIQeB0MvI6IWz1ox9Khjs5CoPFCuR2YtdxArkwJWyT2kyNut50DBNPpyap/6x5zOwqWuUyAlB2aRPxrHast0kjUQSrJHCA9TJPpgRdqlfeE1bH1K+2lydbaGmpcSlQSqpgBOjxaqbEkp1gZrzOSmMqg4eIUW8AJ70tnUmwyxh8flPF9epPBVG+oV2pkEFIoOmpTs9KiiTbidJdi+cG1+IXhwEY5hT8hRDRwqvgqhtE4w/MDc4u6LORxXBOqRuQ6MOphQU7tf6qkP2zXeRZnmOPMZlxOX9QPiwPdet4S4mGBKH5uWPcy1VsYMkJN7ixLNmN+iTHc84+21s0UG88EllLOf8qT9ZvzdmDdsJDSgbqJvpA6xZ28Lg11aGencuFHu745prS2PFnCcnrVRZbagQwkf2vqizK9vAtVl0whAeqTn+jPiAEONputfmOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec6ed8-8dc6-498a-a62b-08dc329b9151
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:11:31.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKgPO7S7yUOcgeo0mV4LeipZjl9AZ9ABNSvNoc2IUEyHehZGyDZUP8SmH0iCgYWlTlLrMUJ7ztoDMRLIxMt8LRVvlvgmLKxVwT8U29Z72MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210036
X-Proofpoint-GUID: -FhIKKKEG-qEqzP1jcc8-oCbiSaCD5va
X-Proofpoint-ORIG-GUID: -FhIKKKEG-qEqzP1jcc8-oCbiSaCD5va

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: 20 February 2024 06:38 PM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
Rajesh Sivaramasubramaniom
> <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanam=
atlu@oracle.com>; Manjunath Patil
> <manjunath.b.patil@oracle.com>
> Subject: Re: [PATCH net-next v4] bonding: rate-limit bonding driver inspe=
ct messages
>=20
> On Tue, Feb 20, 2024 at 10:34:37AM +0530, Praveen Kumar Kannoju wrote:
> > Through the routine bond_mii_monitor(), bonding driver inspects and
> > commits the slave state changes. During the times when slave state
> > change and failure in aqcuiring rtnl lock happen at the same time, the
> > routine
> > bond_mii_monitor() reschedules itself to come around after 1 msec to
> > commit the new state.
> >
> > During this, it executes the routine bond_miimon_inspect() to
> > re-inspect the state chane and prints the corresponding slave state on =
to the console.
> > Hence we do see a message at every 1 msec till the rtnl lock is
> > acquired and state chage is committed.
> >
> > This patch doesn't change how bond functions. It only simply limits
> > this kind of log flood.
> >
> > Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > ---
> > v4:
> >   - Rectification in the patch subject and versioning details.
> > v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@=
oracle.com/
> >   - Commit message is modified to provide summary of the issue, because=
 of
> >     which rate-limiting the bonding driver messages is needed.
> > v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@=
oracle.com/
> >   - Use exising net_ratelimit() instead of introducing new rate-limit
> >     parameter.
> > v1:
> > https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@or
> > acle.com/
> > ---
> >  drivers/net/bonding/bond_main.c | 36
> > ++++++++++++++++++++----------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c
> > b/drivers/net/bonding/bond_main.c index 4e0600c..e92eba1 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *=
bond)
> >  			commit++;
> >  			slave->delay =3D bond->params.downdelay;
> >  			if (slave->delay) {
> > -				slave_info(bond->dev, slave->dev, "link status down for %sinterfac=
e, disabling it in %d ms\n",
> > -					   (BOND_MODE(bond) =3D=3D
> > -					    BOND_MODE_ACTIVEBACKUP) ?
> > -					    (bond_is_active_slave(slave) ?
> > -					     "active " : "backup ") : "",
> > -					   bond->params.downdelay * bond->params.miimon);
> > +				if (net_ratelimit())
> > +					slave_info(bond->dev, slave->dev, "link status down for %sinterfa=
ce, disabling it in %d ms\n",
> > +						   (BOND_MODE(bond) =3D=3D
> > +						   BOND_MODE_ACTIVEBACKUP) ?
> > +						   (bond_is_active_slave(slave) ?
> > +						   "active " : "backup ") : "",
> > +						   bond->params.downdelay * bond->params.miimon);
> >  			}
>=20
> Hi Praveen,
>=20
> As this is used several times I think that it would be worth introducing =
a slave_info_ratelimit() helper. That is  assuming slave_info() is
> still used without a rate limit. If not, you could just add net_ratelimit=
 directly to slave_info().
>=20
> If none of this is desirable for some reason, then could you consider red=
ucing indentation somehow. f.e.:
>=20
> 		if (slave->delayi && net_ratelimit())
> 			slave_info(...

Thank you, Simon.=20
Jay insisted upon using the existing net_ratelimit() instead of introducing=
 a new helper. I've modified the patch to reduce the indentation as suggest=
ed by you. Please review.

-
Praveen.

