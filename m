Return-Path: <linux-kernel+bounces-46259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B42843D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6671C2278C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E776E2A1;
	Wed, 31 Jan 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWQfqcQf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="haRUIuMm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4A28E11;
	Wed, 31 Jan 2024 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698181; cv=fail; b=R64lae+RrpZfoXBNhWY3szvsCjktszHV9TEoHT4QO28k2tHYTKPNrMlNgXcyhkqo4o4Zw6wl6fGNYeZArNc+FSEEhob1ThHMaBZWMjyqszc4MMehVECJ0RtP2/lh2nn0/OgRfxHx+NfximlOyh1yQcdT0acZQfzHnj78fEdL8ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698181; c=relaxed/simple;
	bh=LSdIHh/+jFkN+/XKnfhGJGJX4N3bTPtaU9GDeHA782k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiu2UHb7vFZN4H03J0K9dKOLl851MKkGOmcfRF/hS/Ozjwmq2RMJVtDSzBv25JrDsnHpAixaze4FppcgoVixcf4qS333lvqsbQtXl3CxkcO6R5yDxqCjkJBXtzHr5aNywA3ep5s4vO1O0vKu/gtRcBhMMINKHcCTKmIjpGKoovk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWQfqcQf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=haRUIuMm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iPiW004890;
	Wed, 31 Jan 2024 10:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=riQrs+AeWWiuAzjtKGHW5NGkcv6fUQ+SitUhVI8ckxk=;
 b=SWQfqcQf/+wwyF7ECHh5RCvmVKJdhu4bHFFsnpYiDSQmREURFNX31ChHOWvA1xf7u3Jm
 sNCICXVHS899QVRVH0py4pA54ugPTRxJHb1UZ4/8JLUBDL5/IViqWmi+eipy7yJehfMP
 KoyCaBUQMaIX43g90fQyXW8o5s0z/msI/JUBYjvnnlcEE3TCiZ6qnjurD01n2EE8Mgdl
 zRkRUR4uMd40SzUc/x3YEo3dElAZ6jf9dPDXGrEkFd3CodSqym9z84lHhdnTwvrv1wpo
 ExsdIE/WuYCP2aHKzAlgj6Ie9qCJBXHj14pBy+jUWpaiFLbBVDBb/iddVpDIV3+i/EA8 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2hp4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9BwCG040140;
	Wed, 31 Jan 2024 10:49:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr98vunw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNpVMsEOZcbHhFEtjCwwzrZ9cGjDQGTkfN3SNG5M7HSoV7hnqqynNOuHcjHjTRcMXGxtO7h/JKOpzzO5qhVUwkWOpq2B0HYW5se2vIRNNdjh6qTacCxp6TKKmAF7/iKVAKmsUR1ImdCybraVpatAyYlBmNmvjBIgJZ/f0Xn5rdGBAwEn8zavBpfZ3TCf0U7rdlIXN0oroQf2mXtuNLSdTGOL0Ck2Guyt70voKLjpolXWjG5jcLgFhOnnaKLB60Xt8QmyFnKX0gZy9fexw8ZsAEjYVNp7rvm85mIPFasQhBlhQ8s8P2IIJMZW2rNtUaBCPTmokW11D7L1em/pAUyMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riQrs+AeWWiuAzjtKGHW5NGkcv6fUQ+SitUhVI8ckxk=;
 b=kHyega3WSMe6Ewa0QQHFRoPPLtR1VRxOZlkX1I4RRRi/o66GIiVHP+akjOiclAnC2OZItA+lIEYEpYY/9FSg46q8wSpDge9mmbKW0szCLWQ5RC3nD2jiel1a9IHT+4waSMkVMNVKRiqwmFvli3GVqqGAs+BF5zU+exp5pHO16g2bGtbNMozOklIT/leOKdeDIwdEuZWWgaLFmqG7xL16Z4Lyc93LK3qOYNHm/yNwMdOmtL0p764mu+OpOL4qWqyjNqEW4H673x7NfQxXXNZBnH+HUV2aXqOoYjSaPadEytPvouSPKkGEDWPWVFA6epuOHVLl9T0EiSb+uynz6N2gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riQrs+AeWWiuAzjtKGHW5NGkcv6fUQ+SitUhVI8ckxk=;
 b=haRUIuMma7YVoMU4pjz7Ze2wk1OyrYR5LsNVyvx80Hxe7T4Q1SCSBr6KxEWBGgo8HrlotXYO6/IcdDUoq/sxac0bn8JIkYKzO3Gu6Gb/zzfDhSEEMa2aj1r+tbXGdk+gDWOuJ9mTTzcKtdEGnrw9A8q9EHEz+M+vhQxjsjtGqFw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 10:49:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:49:12 +0000
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
Subject: [PATCH RFC 2/4] tracing: Use uts_release
Date: Wed, 31 Jan 2024 10:48:49 +0000
Message-Id: <20240131104851.2311358-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 185c2e6e-9e4a-40dc-8fdb-08dc224a430b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DJvB7gNXgS0rfTUeM8BXPztZekKKp+7z1OWDY0Q2eCvoR4uwP5lsPgPD0auMGu7czIyTr0MXG9/DHLrRxnfN3qbglhBNv7QP1+O70ZifuB/+FlSLdtII8V5jQN9G0qOOEMcdUK+BPaPn+9I7APQ7Baym2gdcHkMhoKt5YrvHC0YpaVBBoHrSQHDydgS3kmd5/ot4FqpjxJHutuBqmSLVfkebftxSiLVuUgvwRQh3NeukggNPt3LpewHvR1SjEd63atGLjY5pay0LBjkype4q2m5PAonqV8FihbcaoP1wCJhmKaoTVWik23pdKIv77ZE2a5LqwWzl6KKqr1rDmbRfGFv7gWdW0yrQBuykH6LYKtA4RkPqUdoQiNAMmP1QuaRkCBoFd2XkF3UB3nG42XINcOOh7vQcBPiKcmPgw9pDOOMP5BMs3s25GZY96KdBAp3qdCiwkUvJEDc8FbRY+yoEcAHa5hKlqeAzkrOt+s+xzcxfdsRIKodoLH2HuV3JnpPd7VVCBA58JSTsu3ZrQkrQr0RvchBIrh5eUNVeK8cNoSuUvtA9xaTDZbzLquVIBX2RQ7fpWEl3l5E7dnpojX827MJjKHy82vdRfyy5zFljLt0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921011)(26005)(2616005)(1076003)(107886003)(83380400001)(6486002)(41300700001)(478600001)(6506007)(6666004)(8676002)(6512007)(36756003)(8936002)(4326008)(316002)(66556008)(66476007)(66946007)(2906002)(7416002)(5660300002)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eGv73Lr9leCLY1S2aSLyX82fjpai5mA1sEDcLGvHKGu/kmFxUzlzgVL6wYl3?=
 =?us-ascii?Q?2FiqnSbrXA4pJx5/H8Y16oOxtYqI2/Vcq55hpAsED4CqpoaPdnQ9OpEqaxWV?=
 =?us-ascii?Q?JQ7MIgLP03g9DYH32vvZa4eDzgEK4B8wttTLg6u3y5/+o7S2zcN1dbcvJzgU?=
 =?us-ascii?Q?UmQmt7h3LOLXYrCDeJAd7/MZyfFU5ybqJ4QjZbSZb8s7CiLjCfyyKjQws9N6?=
 =?us-ascii?Q?MrX/bGiuDNVCfklO6nvFlxUEidEyG/6R5gJ6SgHBMk/6/V7KWLbBNTVV3EZU?=
 =?us-ascii?Q?eMhmEJHhXd+lU3rf5ea9n/EyDLRfcxpDB0LCMf5HMKo/agFIOuLLU/M9G/B0?=
 =?us-ascii?Q?Tra3kS5cQqgQyRcIJY5nCTYr/Pm8gpkP4DBlWUrZZGdSaBJNp3kKqV0Mxj/M?=
 =?us-ascii?Q?aCV8c9T662Si2ih/+qFdVSr4CdOsUIr9wjM7dHN+J8xXuf38hO43T4elSGhL?=
 =?us-ascii?Q?9zZytPjltPJFFN+CT8z2shJ3ATMFgARB0nF9Q/8bpQufrn5EwoG+S9zDwDuw?=
 =?us-ascii?Q?e2L7ahQ7ZBApIJSOoxbRNyXgTiSp5OV2505ejD/gEh+rEO/4diqpLFS4Pg4h?=
 =?us-ascii?Q?GHVwOmyrbhbyF3pZbLf7k2hloBHzB9a43B5IK9ljLvyNDwiJMh9NdoSiY60l?=
 =?us-ascii?Q?KptmaMWNRBFKyaVGJrm8Yy8wiq5Tcz4cRtK0EfXvH8JKS2pTQkbesOfM6gCS?=
 =?us-ascii?Q?Sx8TGd2HenZx3+G+Bbqnl2wTnPR5e7jOyGL3JBWgdDJKhJgkhytER5wKktp4?=
 =?us-ascii?Q?TaPpdNx+vQjI7v15diaNJysuOel+wYDQKymdc/pSHCtEASKg6l5v9q8oeqkL?=
 =?us-ascii?Q?XQkxyrDqN9WF2h0k4cCYYjEvXF7M+joYkulw6S7PZBYQSyHpsv+s+bAy8DXS?=
 =?us-ascii?Q?m2eR/2KSeFzGXsuapRRPHg4mb/6jrZbaS9ez8Pfspp5u76od5te2OU3P1Cik?=
 =?us-ascii?Q?297t2GTvpvnBzt7HKiz8RtQeMuCb6xAk3VOXrEQxhfMv5HSwffe/wBNKBDX9?=
 =?us-ascii?Q?mtGOyWtbXn9A1Nm1t/Rwhoqa6EFP6Izef53RyUtJv/kSfjHDf0zgzEIuyz3y?=
 =?us-ascii?Q?908l2HrluD+DwAjkw7Zt+TTGATIaYHhdR9Pdiy4MiLDaABjv2h639lIEawwb?=
 =?us-ascii?Q?oWcsyyhLs4vB3bEN15C6+zyzD3XOLiOz+BgUPRaJxwotVmHz/V8WM7NpGHg+?=
 =?us-ascii?Q?BTIojscpsDa22X1bWoB6rGKoQ1dLW1gvG4uuO0iYEarOvhwuR5IYAYykxOYF?=
 =?us-ascii?Q?KlecahJpeD+BRykU6tQE7xOfVEJqnm3YZicFDWOUuQyHoBwNDeW5Y+qAZicF?=
 =?us-ascii?Q?w8lpN2tvmq3Osx9FnwJg5RjOuevi5DjhlIIAgbfTwh2Mo3xa2QBcxdmzWTIQ?=
 =?us-ascii?Q?7nZa3RBdEd4Ldi9Te3UB2EaUXTH3RRZvxvTJP4ONYIrnxvqmeI9lmtikeaM+?=
 =?us-ascii?Q?UILZwYVObM6f4a9sjy7A93EqqU/wRELrPTyXxMHBw3ujpPORhn3XVD3ThUyX?=
 =?us-ascii?Q?wB1IKOwdPFNAaimVvq74UgDfVY/EYlyHm1WsEylOJmUmOJq/uhNq13X2Cf2H?=
 =?us-ascii?Q?IA3swo8u8EG8rlr9oFXIlaubgpugPoRe4CUSQlW9xoZj5i2TPdkgjo9lpAHQ?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+/8DZ4AsvsWo4THif2O5UBeWbzmH19fUUM/n0F65Hq+tSqRNA0n5JCOf3vFNm94xGjJKUmk+xR8WW1kBq899wL0uGgGWm1PXNVFa2o54ucg2Vba5DRYSx9lnf2J2FpnqbaHruVuUxuTNwqkMSUW5JiL8nrQ7B/jJ6Il5KadXSZffsubEhEdMr+DmO+NK/NflVi5XxxR1MXb/Q06t56Voj4mkKFYRriYAajNR3lkeG+6LtJuXPc46OFqAvOLFgcSBNwtxQdAkLjGNJL75qUHdgsGZJIt+hsmLSTM3LcRUBfwFzJxbFFedQMgoJYiHdJSaDze/tosq4aB1nbchBuBDEecYwpdphCPX9R/ut7f/vkIdNKLQcIJCZGABBCYGxtteLG+qIeSWKyj/ODG4k27i0b4qF2fv2bKcM8gVi61xz/V8PPitCXwhIjAAg5Ft+XiGXbR27sMx2YdGjwulTGNSn1n9mXMR+EDA438kX59Czw+k89WHZ5NN/C1zAlxpe+Id0rFdF2eetiUja4SsScdOCw/qULpJM3k8StypThj/huKQaCym7FMz9O3OYi0pDFIysTvUeUdOkctsfHujLO6ahu1bqAl+NAn5n8U37JXYLNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185c2e6e-9e4a-40dc-8fdb-08dc224a430b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:49:12.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXvjnRkkfyFDVWS7PlIgx5pvu8MvDJnpYySs6EH3C+LnKUcnnEX4YFsYB5M0zPLl5ja0R38UBf98P2XlvCXACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310082
X-Proofpoint-GUID: fG4_O7z_NgJOY3bCFdhiHrtxY6Arv3ox
X-Proofpoint-ORIG-GUID: fG4_O7z_NgJOY3bCFdhiHrtxY6Arv3ox

Instead of using UTS_RELEASE, use uts_release, which means that we don't
need to rebuild the code just for the git head commit changing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..68513924beb4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -13,7 +13,7 @@
  *  Copyright (C) 2004 Nadia Yvette Chambers
  */
 #include <linux/ring_buffer.h>
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 #include <linux/stacktrace.h>
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
@@ -4354,7 +4354,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	get_total_entries(buf, &total, &entries);
 
 	seq_printf(m, "# %s latency trace v1.1.5 on %s\n",
-		   name, UTS_RELEASE);
+		   name, uts_release);
 	seq_puts(m, "# -----------------------------------"
 		 "---------------------------------\n");
 	seq_printf(m, "# latency: %lu us, #%lu/%lu, CPU#%d |"
-- 
2.35.3


