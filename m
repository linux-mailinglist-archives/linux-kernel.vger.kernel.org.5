Return-Path: <linux-kernel+bounces-46258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B06843D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE5BB2E61C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAF69E03;
	Wed, 31 Jan 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DyAzQS0j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j75hi8Tv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B669DFE;
	Wed, 31 Jan 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698179; cv=fail; b=HWGHjqPVwXS8038PRAaarLy6CNlrIq5tJ3u0eqiP2bMo0NQxD0XtXw9VYI9/T28E6I6gmpk0CuOO30Pclw96q9bCDz+QAmNq31GsVJYmO1RvEzSxiNDBU2VSW+Pp/bSCERrFtyUUa/sJXrkLnu+tM/h4WLSbVpNgyGLSSniRmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698179; c=relaxed/simple;
	bh=PkcyuPhtwKIjEZqb9rtGQDrce3quImYLbFTJ07iftA4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TYAdRxTgEtf7D4BVk2NoAUax96hVSPxJb2SMUxZslLIPObI+hgTj26AkBXs1Uw+wLdMJR2rtqWsk75ad5WyRkjdrY2PjM7Obp4Ev493u/qrEIjkirgmGMZ4nUL7AvtXU6GmhalbHCh/HRh0hQ42IA/pNDCdHnTVKQhWrQpgCRSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DyAzQS0j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j75hi8Tv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iBQS027718;
	Wed, 31 Jan 2024 10:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=jdIhkEIxgWNGWCbpjFBsr3Gbsq2jSg0YKpGZYTar2H8=;
 b=DyAzQS0jQwEMCCMDeOhq9texA/R66YcBBmvZeZ1tizQ//kT2yUgDkJDNDVM8XB+AY08Z
 VqhsHeZ8WjifwOssKvLnvY1fkEYw3081Wr62lK6GrdavszDiuFq1NxbcF4jmQ7sHMZQi
 XqNyFeqEO2D1YFgFCnJPUG6Bk5B/D9KkJvN7D+NzWQFnzn2RGLZBfvTTiHsS2h5w1NLL
 uCvhwu0CMlw+VqeF34czU7FUJAMWKVtXmgBwSVMEHFO7P1/c/vbR6LNJn6jbqVRKa6Cu
 sSZ7cKJ21ZJtCAkvpJf7fhGrM5hSXuIqburPAwlPHJv3XzjfXk+SaCrG0q1FmZRi4mf/ SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv1jkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VA65BR040336;
	Wed, 31 Jan 2024 10:49:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr98vuje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geemaxyVSa9pWQRAihla+0ATPZqhF2cJplC+x/ePZKe+dI9amk0+CedDA6h1IabuqDRIzEbmnSWM9O/Cl6TeUpyDYHAUuX6ykgEXlnFLCSlqEUUADAxB4M2TdSJkosVKOca4+jvCFDq3XPaR9TP+ZHcXiH8rk/0vVsEaI1VPofAdGXAeQo9bdYVAbSlWxfmL6yDmQK5wZt6Yk323n8HsQ+0LcBBjZBe3eipbNOQNghyHiVIoOBTYzxIbFWOODj43MT/2eZxFFGE5M4aBI16jV1v/9H5VP0/3lGm0ignWIWiVfl6PUDt/nnvY7Id8zbfsSIfVP/5b/fAkEheR5fpDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdIhkEIxgWNGWCbpjFBsr3Gbsq2jSg0YKpGZYTar2H8=;
 b=VlML0SQzbh8O2IuquCNWmLYffDqMJjPqTGwbB0+ZG1gdW3Yk8in39LgRWklcMd0HDa/DtWFP5b4Z88Oqh3Lj4Sxljnxy1Rlrc3oFQODsPwu+eQJ+mg1pDReSRraX2ow96xh4hPk8tLPPZs3wC9kJ3oSxissgBW+uFxEqEWnO4bRDn2moF2S2FO/LEiTVcrqnW/v+SOv6ShIlIbL8EYMD7GRwkj+18X0U1G2kgkiDCR54UOCy0wp5F9lv2bIrdvmqmLuc7aY89vstvFgqnTQAZbtuLPE+kE7gYy/qW9W4QgMjKbQ1vYoyhYLFkl8lOnP6uguG7KM3+fUiu3TKuxxpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdIhkEIxgWNGWCbpjFBsr3Gbsq2jSg0YKpGZYTar2H8=;
 b=j75hi8TvU3+TJtrYsgNkEFHkhv7dqQRKLoqkg2CrzkysjTF/1CImhDv24OFDxK5bTp2mBY4VvklHh9Q1BmmzAqnXEwQu361z+ipPqXHiPgjG6ULCd7l1AKg2Kl2bATSiWrveRd8yk9W/aXeTsTV9IKq/ofvFWKTqdDIfW34SkCo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 10:49:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:49:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
        nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 0/4] Introduce uts_release
Date: Wed, 31 Jan 2024 10:48:47 +0000
Message-Id: <20240131104851.2311358-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: dd352e69-b884-43f8-9912-08dc224a3f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rNlTaj1/C+bpmPcdQIb8dFcai1izlobPvKSfQE+SmTCtsiQToAZGiulLYw/vvmtS6mRhEK7tNgWryFJ+CIM/lzuJAdp4MsLyWXv6M5PCDXIQrQT/537nk4kNgEQZzbfN3g+MqNQUb6p8n3SCw4H0bZvKPcTGUR8Vs9JiN6slOBnhcERcN5VSsGerR0LsG+9/bBP546ow9f5TPYKANEbGIHy1mal5dwq8/sWGRbf0jPUGRLoiM/yJiUyNl4o0iqrGR5bicNSSa016srSBC20XvOCQffIIbxP+hl+VqJniU+aaq7EgKw0E8CnCyzwaXzyifjBU8+UZFyNz3aIO1Ze6hS2XyyTrG07tCa525MhzGwgfpF2ue/H1RtgsZtUIIV8DMl9iZn24G/xX896clL0rHfzEWaKhGbx1vfFRFgP8yK/umJkWObEDROKSstOFgRk23JlK6PR0EETr6wpZG/g9q8QP9IBajMDf0sBnloLvpqRYysDD5+dhVs3bK/PIBLAAxw1DowvyG+zfgcFnnv/qCYITHWTo4VHM8JPPuLP8zwg/cuBfY3hph93z+cQ7+k9SfSlRWtF8Xcnx5iC2fCDx6pvplE+XhkFFabjFikcz17k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921011)(26005)(2616005)(1076003)(107886003)(83380400001)(6486002)(41300700001)(478600001)(6506007)(6666004)(8676002)(6512007)(36756003)(8936002)(4326008)(316002)(66556008)(66476007)(66946007)(2906002)(7416002)(5660300002)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zUf8akHy1Ou5WBRNOLJLgfGoEFK5DGBd8N/Ijm4R9NyrVo67BtTheEt4f0yT?=
 =?us-ascii?Q?nFCmaxK8ScOA38Q2hFYrzHGpZeggiFDYQULrc4AKODhA7j05C6FNOcwEornD?=
 =?us-ascii?Q?GJTZVlv44gFDpwSzVk8GKHmjh6LVkPYYn1EqR4+9PPsB276UAWRZXS+HOFTY?=
 =?us-ascii?Q?Y/GE3SmKlxy0uyHT6nx1NABAfLIHflO7uwZpNqILDzPbRQ74LzQKy/ljyhlM?=
 =?us-ascii?Q?iVZYxNFID7btHiLXz5Q569w0PqDvnSbDcxQNGXjnvRDfTRfmW6RQlwNdWkmg?=
 =?us-ascii?Q?dWp+IuLydvOI2q3VlQyY7roauB8gzxBCoWrHr6xDMa2BrUpk8wBpZ38NLRVw?=
 =?us-ascii?Q?2u3YkirZdKUh52NXVlliORdgTix7df6yEx+9E4TS5F7AAuZ4Fr6IGrOF2Ttf?=
 =?us-ascii?Q?ZWKgRYwyHTAIqrs4IhQezkI2MJYo/eTUeZkG6LJEpTtDY2V38qQGu7xpDQpM?=
 =?us-ascii?Q?8GH0EFW2g/yB/QcX4vgJJZ9nJmC2NsdMrWtYOpB5ok3+3utdr04NXGMBVhul?=
 =?us-ascii?Q?dxPps/oPGJ87oxNLs4gk0kfxsu1+WjRKU5AXULOO3x8vObPUtALomwyWMgcW?=
 =?us-ascii?Q?+8jtNtbgvPAAJe28xvslwxbJRaNC4PSLO5KFA5T/XLat0qN2w+7ZqfnoVKqW?=
 =?us-ascii?Q?4ww6moLao/OkkVzl5uFkdHDgOzCGaXnz0wo6VunCs+xzJCOtDwOF5bsWZdAl?=
 =?us-ascii?Q?Zc6jyoTYtezM3N3k8MKwBdGzAkbaBzgooSeAyJf/tuwgJst8J9qkYiUM42Zp?=
 =?us-ascii?Q?Iy9mCL1PtgYpiT3a12SkH6BPxYdSWRFO83EKFdhYmwU2c056gG/p5+X2A2Ka?=
 =?us-ascii?Q?jKhf4mpFsuNQXsyfo7x7veQ51pWd7CWjng1gxr9tyLA2EJJ3D7l5zG7WyxQl?=
 =?us-ascii?Q?yuv+nJYezi9PmBocHcWrI1ZGIH19W9yisz3Qho4J/c7HqgYhD+3on3sz+q5O?=
 =?us-ascii?Q?bbkL6wGCW+n3Gyr/hilW/oV1z9H9wjd4B9MJq1snf0Zx5yQPNWXL+LA5+Ic4?=
 =?us-ascii?Q?M5ysQWUwuSqYpvFGb37xfdNhr9sM1UvLSeFTA7qq5+WWrRZZV8Nf9ydiw4Ca?=
 =?us-ascii?Q?oIwW8J950XI6uiRC3NA4X3+VCyEfTNW7A2tJRDYXxMOxSXIolt46M2Z2bc9C?=
 =?us-ascii?Q?BSe42zoM2bRqL94IVUR9/IkfN+9On7Csc6LFnDgG6Thzna22f/luKYCOtUHv?=
 =?us-ascii?Q?PWo8TJc0Nb+gP8auR7QbJ3vnZfKUxpuPG+ElLAMO+bA0nl99rnCti15brF7G?=
 =?us-ascii?Q?5E6BcP7n/OKs9QXf6Egi3dIbzK/RrBm4BuSC85AFgEYNb2pSzmfWajwJgqIe?=
 =?us-ascii?Q?r362cpNJOFYSQHNzkMPKmJR7SrwdLh7GDN8mtR+y9nW+YqEZJq1bjfHq35Zs?=
 =?us-ascii?Q?b9jaWs8IW+LQLushpDIKQvg1YXpw87FVsbiW/MqLLUrIV5RVCAsvoGJjDcI1?=
 =?us-ascii?Q?Ct82WFSqRSdw9o2E+KNitU4fETaq3YWWzOEPK3GmFm+390p+HLQhmZj+Tj3Y?=
 =?us-ascii?Q?JU9dLnzYQvruDmozbMGrI0Y2NUk07l0jm5hQHFAjQCiUrBZcNIOZ/LKIYxKR?=
 =?us-ascii?Q?/3RNbpCucwc7D1ltyDvk1TcjBcovYpjkDPo6ndL5QfK++XWPectE+VOQutOg?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ndKb9oM+2wZKC0bbKwxp2t6dqLORqUmkbVnveobBz1JKfRxXzbzLiEOdw23C90rpKHhE4jviRoYUtHdrKr28dSYZwKJLGpKXxhK9oU52QvmeyYsgnv/bNh/8kdUQkJaEMMTcyAJIWd0AhGjciie3bc3Oqf7OviXrG3NtgPs2EGwZVFSYvrQIaU/7hWL3CEm/6Vm7c+bhq+UeOWadsEaAWHZOIuvT3oLPqmubVzSnuuRBo2NfI21Bq7ub6iTeja3QOZidsGUeiri7Xr5HR/QPOGbx14dzLxJCv+NjDhmNww6V4dP6hrQSWs5Kkk80kg5aJ9gG2BpzDjzNTDglizJKP0x4MfLXU9uWJSMuwYwlvUbY9IkCHGPUIiYnoYObQhW9tmCnmeJ6kGtNn8UxWyXybNLxRUwzftFnXBfy+PwzuFKnAnhZZlk2lY2E/ZjztdYJPxcozTt/+dFWBX8dLWFKuCBPYe9qYcNsXgOQ1HvJE87JRIAE0SSPl6kPJ+JYs2mnni7dKE64ZHG0TEIiMnQkVipV6qD48eInTQUWoazB4QBejuSRq4xp6BLPRo0HO58wmquzV/rtBIMPWeVlBKzkVeU4ok41eS71oX1TuTEumeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd352e69-b884-43f8-9912-08dc224a3f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:49:06.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdUa3/VUjSOU9ZQ84pdeWt9RVE6+m4Icx2taDbBueUFG9I8og1z1IzFYd+0HTRJD13UAzBRHtyCweVrC1BDYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310082
X-Proofpoint-ORIG-GUID: ZuGzUWOfUHkwjb3KuKx7e6sTVM1vEY5j
X-Proofpoint-GUID: ZuGzUWOfUHkwjb3KuKx7e6sTVM1vEY5j

When hacking it is a waste of time and compute energy that we need to
rebuild much kernel code just for changing the head git commit, like this:

> touch include/generated/utsrelease.h 
> time make  -j3
mkdir -p /home/john/mnt_sda4/john/kernel-dev2/tools/objtool && make O=/home/john/mnt_sda4/john/kernel-dev2 subdir=tools/objtool --no-print-directory -C objtool 
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  CC      init/version.o
  AR      init/built-in.a
  CC      kernel/sys.o
  CC      kernel/module/main.o
  AR      kernel/module/built-in.a
  CC      drivers/base/firmware_loader/main.o
  CC      kernel/trace/trace.o
  AR      drivers/base/firmware_loader/built-in.a
  AR      drivers/base/built-in.a
  CC      net/ethtool/ioctl.o
  AR      kernel/trace/built-in.a
  AR      kernel/built-in.a
  AR      net/ethtool/built-in.a
  AR      net/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  ...

Files like drivers/base/firmware_loader/main.c needs to be recompiled as
it includes generated/utsrelease.h for UTS_RELEASE macro, and utsrelease.h
is regenerated when the head commit changes.

Introduce global char uts_release[] in init/version.c, which this
mentioned code can use instead of UTS_RELEASE, meaning that we don't need
to rebuild for changing the head commit - only init/version.c needs to be
rebuilt. Whether all the references to UTS_RELEASE in the codebase are
proper is a different matter.

For an x86_64 defconfig build for this series on my old laptop, here is
before and after rebuild time:

before:
real    0m53.591s
user    1m1.842s
sys     0m9.161s

after:
real    0m37.481s
user    0m46.461s
sys     0m7.199s

Sending as an RFC as I need to test more of the conversions and I would
like to also convert more UTS_RELEASE users to prove this is proper
approach.

John Garry (4):
  init: Add uts_release
  tracing: Use uts_release
  net: ethtool: Use uts_release
  firmware_loader: Use uts_release

 drivers/base/firmware_loader/main.c | 39 +++++++++++++++++++++++------
 include/linux/utsname.h             |  1 +
 init/version.c                      |  3 +++
 kernel/trace/trace.c                |  4 +--
 net/ethtool/ioctl.c                 |  4 +--
 5 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.35.3


