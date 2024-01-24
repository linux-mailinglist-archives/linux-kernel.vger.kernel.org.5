Return-Path: <linux-kernel+bounces-36316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8A839F47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E30283A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC35244;
	Wed, 24 Jan 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WG6ffMi/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wj/nHRem"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96E1396;
	Wed, 24 Jan 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063927; cv=fail; b=RUbZsy7KtvgVEI4CeAZu+FkFxOVbdEc7TiamETTlDOXLJ/41NZTTqH+HRFzWwHCfq/QBRN58/7LuAKY1F/E+zHteGP+oUBahQJOBjsdIu9AFXxr6vMgH/gmcHVqzg70qkP7QQVGcS0sZw6Um7GGa0/ze1ScgHSkiz1Bbsi5MB/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063927; c=relaxed/simple;
	bh=5Q3by8IjiLP8T2RWeKTViJlmehLK0xi+GFnHSbnOVak=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=gBtjqe/KHpsSo+LNQei7pYdYqzXhdzR7aSa6BnmduV7ehjHhS/O2gzjtdagVC0SLgGgeFmJwFh+oxq9tR1iYqGS5FYamRTocvGdc7uIKDI3miFZ87d0VTZXPruY5PeFcYbPupESmlXd3TZi7pBg73twTiyAUO6gyMDjCaGedxJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WG6ffMi/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wj/nHRem; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NMiqcI025196;
	Wed, 24 Jan 2024 02:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ky91qhV9k37KhAnPjYwtbHdOZPUYHXHq6M7IcRCbY5E=;
 b=WG6ffMi/DJwqXHFouN42/65IBQBuSPRN6LEdcG0ljy8SBDUCWGoAxf4ZzOghMux6BGdM
 sRtSIHeEtOiRGg8VhlZw749gmCq2F9FrBb5dEuPUJ2Ijls8pmlyajN69q33A9dfscoBT
 tnlLOSrCApj3QavZ4iurr5HgvK/TOn8YQBUBTR+xKqFnkjGhixkarwaogboHjSxPMPLe
 j4P+CfVwFpYUeflgg02wiHEvKqGrVA+awCTOhu5BhBiMR2yudj0BvcxMUgnKstoAJbFz
 Cwk7SoIT1Q0sPM6CUxsDnFLDbAM9YcXgJahHzyTuc2vtx8Ly80iyEgFLYgmWPqM4FeLP AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abyyn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:38:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O0jVT4006176;
	Wed, 24 Jan 2024 02:38:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32rrw9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K27xZC5LNR69K+k9OewlhP1SimYZbGjHBH/tlqjH9tHuxSjmXUZy5+Fs6Ir40i+P/MD4QOjD22GQE18p5GWCHxT/6c6970G11GP4MH/21CeDduiy6ims4PdBQfv3A2N5GFiA0wY8rDCG3hFUIJsn9pmxuultStUFh6f6f3JQKMdW4yUBjtqlrdbga1O/lbfwpWi1BYnNJ/WxeCvw1/tbYFKYv95lOhCyYZhdbM0DDsCoDxeGxh04OZkxEp0g5reyOxEKwSxTm+t75fIrbIpqJJupIjfvIdxZ1AEy0fB5RX2aFzdAQDSWzN0BNyfI1YML8DHPcOV+KZ33TYqU1Tlmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky91qhV9k37KhAnPjYwtbHdOZPUYHXHq6M7IcRCbY5E=;
 b=fv+0IbXJlYi/u/4qdG7XvZtFbQ8llQLhIB47ZULxOiLDLfcxtsO01V2uE+8LJOe+GsPay12VnXFiUiu7DXycikVXzq/4whmlVwolfBUy1mpE5VihA7kJoXrj1AbY+EHh5y4CMYlGvMpF/v3wlo91s3zYo45YDy/DoLx8Rc+Py4hpouyerhMMGP83AnazmB9FW2A0M9EeqrwWn64kLJTbgxML2reWsymg9FCIRv/GnRKFSXYR7gqUAn1rs+XGSe/v7byKLs8ldPy956mscT2y8AQdY6kXPDahvWBY0YwF2jqQUvOAoL2JvN40u0OCW2SaapYPPusXGv2DPil7q9aRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky91qhV9k37KhAnPjYwtbHdOZPUYHXHq6M7IcRCbY5E=;
 b=wj/nHRemPZuwEy34YXJXqoIRDc2SXU3rHv+y5I2VENd/0Ofit6SnKXuPPlcVV9J4YrICQNzQPOTl13iEmn8IKvYqs7CTu0YIKoZRqRifUf6Dlr8iu6g5qwMfSnV1EmYd30tWF9RYNB7/MvKbjqKf87qeJ0pu/dxbrWCzdI0KPLA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 02:38:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:38:38 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena
 <sumit.saxena@broadcom.com>,
        Shivasharan S
 <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth patil
 <chandrakanth.patil@broadcom.com>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: megaraid: remove redundant assignment to
 variable retval
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6j3xxp7.fsf@ca-mkp.ca.oracle.com>
References: <20240118121441.2533620-1-colin.i.king@gmail.com>
Date: Tue, 23 Jan 2024 21:38:35 -0500
In-Reply-To: <20240118121441.2533620-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Thu, 18 Jan 2024 12:14:41 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: e32e6ee2-a9f2-45ab-1788-08dc1c859192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FQd71yKRy5w2gHLTTUm/W/gTDUvbfiE4Er0Gzz9/J2Y8nxkeaMakai/3RRMXifoTJYa0acu9VvA+QPCmqjFzT3IFMDx0t5g6TcUpwYgvqlq9om2YJtD4sPuYFdduaVBC5mQL61SumCLUA+aMEZJ42S7fsVll5fCX9QuuItXBcUY3WRANl1D8VxHCzDTm8Bf69pTZoTYTUT3MwQ0Wbj4WkhCZ7Z6zFOHHlCb9j/AISgcclzq3GjXy/so13TuSjL5oXhDvKdUFoeLmITJpAnU02StBEtxgz8ei8uOnkOO6jJI1D/Dmo8gbbRw1EIxK+yU9V11y2hgQNwXwtbw+l73LLexYTvI3bIHkV9W5xHmnRtvEvEXqvZlAVRox/OeMnVYQgaAh1ILB64V/WOiu8S4P6Io/MDRuAtsTGQ8zdkh/b/XtXXWsu9HG9UbYDkRKy34wBfTU+QSQh5alrNZzNekTD43xHsoNffBJRRoM9rZ8tDsZ7VqGn34T/pz02XCJGGvFFmqEpMLHy6L/C4CZ42/2pQiwm+KMqvBnE4bMr/iWkx5Z3WVJnTrIMAM/Osef29WK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(8936002)(2906002)(7416002)(8676002)(5660300002)(54906003)(316002)(6916009)(66476007)(66946007)(66556008)(6486002)(478600001)(26005)(6512007)(6506007)(36916002)(6666004)(4326008)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sFwL+rdWdsYA6N0qEUJnXIYTfyNF99Lfbqdz6NcEWhaPnE/+rfzADe83EryU?=
 =?us-ascii?Q?bBNkmmSuJBcA5TqqljJeel4CtQR2uuAYGl4fKzN6NdipwUa0zsSQpxS4Gr90?=
 =?us-ascii?Q?KwazdbXU6bNYFjTl8OODzSY4GIIM+STDjFabi+hPI2xGT+Q25yMm9EYY5321?=
 =?us-ascii?Q?GKUrwSfgQGoO5OPgiJtVdGDRhfV0wyTJakCMTmuCrDm9TGxthzz3pNoZaZY+?=
 =?us-ascii?Q?48OS/jGxnovjAwN0HqflIm8EYNet0KsaO6mYrHneKDF7RFefyXsXfO9No0dq?=
 =?us-ascii?Q?UyyIH+iaqbk9lc+M+EQAqQ4QLBoy5hYTo9p6QfK7q1t1tBgSkqxDkfES0/lW?=
 =?us-ascii?Q?7yp84UKGWb0nWKf3g+mUeCB/TNAeSTuTuy7gQHSANPImEUZdDeieO48dzvr+?=
 =?us-ascii?Q?Xqo392kTy/WnpmRTdVlchTW7V+qgK89LP6Nkro7WuaruDXZA3ywa1Qx8Oi0v?=
 =?us-ascii?Q?ZGplunTpmyIbL6YK4zl5jxJo+rx54wZAx5XT17k2/soMLmr0CzOIkJ/kDq7q?=
 =?us-ascii?Q?9JsmkQS9WW7PC9CgaPSGZS/VRXKYj5KZclrdsRv+HkqO2kj3QXQSqRXvFeOQ?=
 =?us-ascii?Q?MDEmuRwd7jnSPLyqq1fTDCqqBN2L3eIJVu1JFhUcdLwSQAqGinNcDC+bYDGv?=
 =?us-ascii?Q?7QO8uw+/CMghtr1m3B7GzQf4KjbcZsLLuaB9lsXejZqUAEuf/TYzxRI3JIz3?=
 =?us-ascii?Q?Urrl0/mGvBfZ0BFS/1VzE8oiufasrOa1CW04ryHgTczGI01sWeMXKFhF2EPq?=
 =?us-ascii?Q?1fYF497t0KfisgpTuRgyOnLmenl0sHEtEZMBv7z8FyGDDEPT+/UXOmBTo1OL?=
 =?us-ascii?Q?SesuZfCt7OLiRjEzaMGlkz33yeiM9DrLVs++vamNsqYvL2imROdd1NI9lUYk?=
 =?us-ascii?Q?TxclLO93aMXVCH33LI0FsE+eJVcfvnYy5NSzfX1pvDOJCOE4djtax7pAPrLm?=
 =?us-ascii?Q?afrHA7YMcboGjvCjaWnC36l3v3CJ4Hlum1cgsdnwQ4Al4xxIJMDlNEnySYpl?=
 =?us-ascii?Q?2MEJBe4lCbk8YGvo4g+mpLBchfJnQRGwhnJc68anNFo0YuRN4NYv2FWpq/04?=
 =?us-ascii?Q?9IH47g0PPbdDckvUUzyMd5qvfCaHaxEZpCH2ok7INAmsVz3T0pHdbhX+HjHx?=
 =?us-ascii?Q?WZIifm+V2Wv3269PwYFLZzereUBJCIXPJfJ70IXdGJ/eOS/MCRzYgmZYuH36?=
 =?us-ascii?Q?A0sx94xRIW9fgWFeZWO0K179LNRmTaBg4tSB1OgmVwJq/yOcphfvtwjXJ+sZ?=
 =?us-ascii?Q?EWrVc9EguyRSUb/nOQVzfIVYqIUIHctTSzTeIORxATTxRJTKBphbcRAXkJEW?=
 =?us-ascii?Q?ydC8lNmcQaeS2n8CCEhacEj/f8lgRvG5BcMj6cYXb12QgpAmiWVoRX57LOpO?=
 =?us-ascii?Q?6R3aO2SN+9XGnAZcQveWFYFzqc10DQODgKaeErJc/xE1gYfWiN9UjV+ZEf/9?=
 =?us-ascii?Q?d/P3h+V9yVzC7qDVh6LGy8HAu1kZk1/3SLXYEGNA8lw7xvzzYaYX5rj7vNHC?=
 =?us-ascii?Q?KTizUHjiJaccULiXnyHICpLeYD6X1y0I637Fp5DE86UfjXP/vwx8UcwRv2sa?=
 =?us-ascii?Q?SlkTtKDPdq00zhRXAhdRdRgvCKXtZJUmJhuV67gPdwrE2XEZ8KwT0izGD+l+?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QUyMvIrBS2XzXMI5/5NlXALQ4JomCn1MOIp503fNgxH2rAz7mxghtluvOacqOLTtI6RAZ7LaMVODHmK47Z22eZH/yPybzNC9KraeVVg6yniRCk4qVGAxabJEQYxoqKzGXVgEUoDlBb2BbA9wapguZ5bOPgCaOL+zM2rsQvGpnh52pCnIuHSHQl7TWrAfQNrqirxmveI9islMUfai/xNWNTGq6Gmadj0UD/lhYTCyuTfUyVBpw0sir453foAP+tvSjO67LQb+WyP/MyS/89/E37RfZybiX4Z/Uyo2IIQ9q/cdabXhID7cAJkCpKCHPHL9557Iwerg08CPNssSs60R4WdZt8zEdDvpRLJM5e1plQiGypdNLGwKE7TANxHuCdvHKyWKjBaE6F/2lDQqRYW/8uXO7hvEWc7ABMhDyhsTEUGDFZt/q73bXL6VeFFiWekVg23ezGsbkxinVhZFVjjLHMFyygwTz/UC7YPKF8tVtlEW7Y0Z+g52Ts6AuoVBgWonNaQo3oHUfaSDwL/ixB8QIEEi2A/J0HsIxTRhIkfDeNsw3BYpZLGflz4yf9ulNyODUKTkJi9X0fWylGEMsZSya0rKsD8JjX7lgHZvgKnUk7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32e6ee2-a9f2-45ab-1788-08dc1c859192
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:38:37.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqkOPktcqZWSayLue0FJ3lDCT3krKZGQOVFjsl01AMWmCZVvLoEobjjsWu149iJb8MnVu3qA9QVAqGt/mgY1XpsY8mWEU3YJgruaL377SPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=986
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240018
X-Proofpoint-GUID: 0t8vGW81YFYG95S_gPPCqHdoGNbOEYjS
X-Proofpoint-ORIG-GUID: 0t8vGW81YFYG95S_gPPCqHdoGNbOEYjS


Colin,

> The variable retval is being assigned a value that is not being read
> afterwards. The assignment is redundant and can be removed.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

