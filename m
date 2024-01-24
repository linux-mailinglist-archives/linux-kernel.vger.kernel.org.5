Return-Path: <linux-kernel+bounces-36864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACC83A7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40162923B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E91B59E;
	Wed, 24 Jan 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzMJyZtJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fzSHA5du"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F1AAD1;
	Wed, 24 Jan 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095739; cv=fail; b=b6R6N5pH5ioB+bGqaHDwEUzI3PoKPTiosdhQbwVfNR8RjhsA4xyM9zjlpt0q+VJ+xWpe/XqdOf58bN/yqdhhH/eMMAySx1Y2KMw0pOIh0ZcWLpev8VlcOFHT1RVjhz3eTw8RcTHcidg+U38SMVxO+6a+ZLaFZu3GQKC8ImfJQuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095739; c=relaxed/simple;
	bh=QM+PFFj1D5GFlFRnTBs9wbBtBSHj5YW+vDYOaj2aefo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HezSjR1omcV3dud1KbE0UcZRUaKiMyzhdJtHoSAsQPMFj2vpji/DPXfKwAvCRClifUFA6LSDFWZgYPyvDw9Ty0qntKHRhFQAF4h36UGo59C4s2oIbznxCN7NgF/zEfEJo41Z1KXitEdj4vLITsf2mjwlHP/L+H3312J4miTR3Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzMJyZtJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fzSHA5du; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwr9W026976;
	Wed, 24 Jan 2024 11:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=SJAewlraDjF6yhOQfJpA4Nbu7HRwyOKfeauASZTTAWE=;
 b=lzMJyZtJYTjg9YoMvKskiXjSLvQxO2jizpuObbf+bwQIDSy7igjeibPlvZzlZcZstWTU
 sSIYcf/3HqAxqEfPVVlPXWetnTMFdezbt17r1c4ok3vLKtJ+gSAoXsqg1GAtO7tRWlbs
 pTGL8QU85l9TKr1xbTm/ia5VdJkCl1cq6ON/0V46oWvIobCu2sJvHJZOJUq4jUcwB5nc
 YVNgBRsiQRXZh9obPn+3uw+1nUZBg5/RS2CMW9XK7n8HvVnhN0382ivM9p+XBsslh6sL
 bfLw/f5KUOoMDR2qgA3Ou+QT+IHh3ZyGXMMB5utLXio7mB32afGw6gao6IMPtQCoiiIz HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwhv15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAbrrl006305;
	Wed, 24 Jan 2024 11:28:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32se9ar-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR5kOX0WH3GLuyuo2FxyCPp541VK7eLN/e9+3UPuOeE2UB4NjgZNTf3cfgkzylUYQ8BoU0B3anYOumPEXS6Mb24dPdPS6rl7FQa0ioswChe2Y0KOh7wADrL04UG5RXnsCQduNQRTK49b7jOKRlTtQx/6O+DYrLB2wLkh80Ri08YmzfAaHLNqw3L8d6ooag4zKj4H1zgkX9FrYbP9K0BTXGaDjRjPwO2ryM0Ijk+mPIu79wL9qbaaroLbZxS/mYzxTTBSX6x3/7H0apXMm6YfM7Y3txrvgCN9cR5JVyL36r54J7cRV8bCG/wz5119Fue+ABYiFWDaDxRuFO4JpGZ2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJAewlraDjF6yhOQfJpA4Nbu7HRwyOKfeauASZTTAWE=;
 b=fUcesmd8GtnC7pO/UDEWb7HnWHBQ98vd3hOUNWYVv7BtpeCOYMJQnibJ0HkGTkEgQUnXZjCUgx/HPZNiG7cZZiGEbwjhGDr571vgSiNctmtNC42wJ45dx/hskV1xCgR0ecXhVPLs4sk7vsRIOo7PhH2d48Rb0ZRLiO5yZ0CCXlyoiLGz/i6twMLgdpxVCTmOLn4pwclRaivUcAga53vOHzjxKBg5Spd0k807ZE8mRvjUcCeIIEuxv7C2F4FSw9b90LsE+8jXczRweGXmkqPOJHUbh/5ESsFe2aH2fwR5oRBROCRL7dF/sPOz4Z/B2xwX4C/NT1+LHTtot24cfnwARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJAewlraDjF6yhOQfJpA4Nbu7HRwyOKfeauASZTTAWE=;
 b=fzSHA5duPuDgipoInt8Uu0s3QmkIXJjpgGQTKVTLttm4JZlljODwyO06mwtbWgVkSV0XLSl8UYwC44XSaR6ly15O3QpU7Nd1N3QGfv/AKZOhYuGQYnbJ0O3jhh1NNF4lf5G5rDh9DGwIggVvNo2CuOTKoRr2zAEQdc2wDpoHPqg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:28:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:28:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 3/3] io_submit.2: Document RWF_ATOMIC
Date: Wed, 24 Jan 2024 11:27:31 +0000
Message-Id: <20240124112731.28579-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124112731.28579-1-john.g.garry@oracle.com>
References: <20240124112731.28579-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:510:324::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 68905dd8-b82b-48b5-d7cf-08dc1ccf9061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2ArKHpD5P3oSBwnafoq2KRZgPwIaVTXlphsNSv5u58mgnlwGaZjAOaRsKyMZtpeLaAhjQEmkOEJhBFzsz+sD74ZECRAuS0hIHwkeNb6Xh4b98NdkseYGuL5NvMOka8HaqkyjWEGfZrzdQOliIrdg/Lx0UN6VeUN7ZGQ5LEPwDzgJ2sx0MmxdsQytF5Mdv8U5sC9W3QkLdXIl2eMwNzGN8ewioXZtD1od/rqEtxts0IWSCBGzCg2jjsydeo7sRrk1p/uc5X41mqPBsUwp9ZdQhaDV3KFEnaJG77zmizKUnlkrzK34a5cm433cw0iqSaD75gAPyUOo5MmLu50p7IK4zEi5W2wW2KG6b3oUIP2tlEbzrCohKTig4L+B3bduaIeO4J3cfzv2rQQ9J7CC2rM47YS7tJsXFuvi5SS8gkMmCcB+ng/V0CN42eZ30l0njXhOuTUirMUrUfmFBRXrSt0FAaQXYxn4xlWFEcL0L4gTfRPBGyn98mbUT6XER0yd9C2UIGRt4Vo0kHy+V0Wrtj3xcQUfDZ48FKxa9dMPQ3dHGV7cnBy3rdY5VzD6SWyWg63d
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(26005)(83380400001)(2616005)(107886003)(1076003)(6512007)(41300700001)(36756003)(8936002)(8676002)(66476007)(4326008)(316002)(103116003)(2906002)(4744005)(5660300002)(66556008)(66946007)(86362001)(6666004)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9IF3YC9mwGDjod9usk/6SE3Fnp3XQqZCsU95MM55vhFdy8TW+snb+U+xbxuf?=
 =?us-ascii?Q?5UD37yCi4oePgbUoFx0s/aWOgF2bnpluviEEMfpKTw4Blcj9CtGtG4z1/OlV?=
 =?us-ascii?Q?UNR7K3/4bOmiJwaHzy4A+N2HyNHnfjFxaiPRnDj0K7B6y/75jlzioViCASR2?=
 =?us-ascii?Q?exNlzoGb0Z0+JLjABnBaDtjo7e2JNds+uFpj41QCSknWfZ7ssXnxt8OiGhcp?=
 =?us-ascii?Q?v8rhXdnn4FvybTY9Z15vRjeyB8TnwuqNt1SN2ABXM0ZUFH52cEaIhh3Rq7Aq?=
 =?us-ascii?Q?2VtjZqNZuPg39i8RgZI/aCRA6gVXH1fX1g5ZBZ05SkENKZ6LavVYdfZ0DFs9?=
 =?us-ascii?Q?LwPtoq2j+7FaIPhmhg3j78d2eM9VT/9sPhQ0r7meMFWarRpRP+m+SSKEAPzi?=
 =?us-ascii?Q?VqbWJsXXLCM+e2Lmy9NVtLHqtnwa3oufFSDFoNJ+/i8gX5Gap+UcgtbV4B/D?=
 =?us-ascii?Q?G02//d7UaqRuLe+0XUUTOhlnWncmaVTdHC7sFpQnGfzxwF6lBhBl+0To+BeE?=
 =?us-ascii?Q?7R1WlbFvC33QvJU5ELt5c2ENr1xbClUeFWqzvZCgoqx1NCRjLgoG6ClTW0OH?=
 =?us-ascii?Q?tbvURg9KGqGtoRwaTvzKCPZ8E9TkXyRma6/yGOkiLDrDjOZxHjRQSYAhMeSd?=
 =?us-ascii?Q?7VUs/UdVlJtQFkky0rX0YYPZWO32DzvgfyCN4rreIbDHwF4J7fZiKviDfZtd?=
 =?us-ascii?Q?KlvyrzKBsWwKRP78u/SC7wp0zXdXKk87/yuU7V1G7DaR45uKQf6J9wq/Yg5k?=
 =?us-ascii?Q?r96veDeZV4O6Z0jsXk+0F0Yuxm3MaPWPXvNiN/SMNMSaLy/L50YJtp4anZIA?=
 =?us-ascii?Q?+Urg2HUGsHRnUXvTIo+JoRWTnSNi1lvk52xLaADGM5UZzYW1JJ7kLd6ELbVs?=
 =?us-ascii?Q?fF2bEh/BIZA1nmJS/WhAyVOvYXa5RQM8VUePwAwr+he28mHIBc8MT9T7vO+u?=
 =?us-ascii?Q?p4a2Fu4uVLLHtjpc7NhcRrnpvE5/kXyfBRsmwcCCXw0YidKXDE+mq6F0Oj7c?=
 =?us-ascii?Q?P7YK2reLHFqHCzObbrkjSYhC44quMAPyAcPFzlfVmH9wqB5weX+ARZnCXiyR?=
 =?us-ascii?Q?XH7FBe9x6ENAqJgLfN2R1Jqew0dFWHZa0jgA0a4J9dMA2rG31VRVb/DEACP/?=
 =?us-ascii?Q?dFBN+lbrfOlST6oNLk40r5m5gdTEX6GnwYE3PCsf7DQeMr2LT47YycwJbb33?=
 =?us-ascii?Q?cc8tdsL7jvH4WsKKzKaHo2ME46xWDN1Bfw21cnFOFuzCEntS0nwYsIpQWfJo?=
 =?us-ascii?Q?MrDj+QszvtUWu0kLjVHETMmO61Bujza9HvStSSl1clU61KzjKXnoHoHwkFf5?=
 =?us-ascii?Q?tq6Ny6jJBRBn2dpJL9LpajGDSFYQk8+Ti8PVPSd4dynlMnwB+ma+xic/LgeQ?=
 =?us-ascii?Q?rwn4LbQ1azzuKoKqkAsBHN1MRu2+daKpdWQeVyZIfXRkEG1kGE61GQnle0QP?=
 =?us-ascii?Q?TVp/hwk0VKxx6/3wavr1QfrxVXTXjOwhBOlxGA3Jexe/VOH+gyMfSEwrW81S?=
 =?us-ascii?Q?bgAK5hrlZ5jGSh3soNzqIpJJCE2gTSFqKvS+ETxoUcJNYIQZtZXCZ9K9o2Uz?=
 =?us-ascii?Q?ttt7fItcwe/PbqnZSzB3ciebOVvqQT8bBFT4L0wttCLQXmkZStYtuYXuHo6k?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PoDyCpZh7ANCgAGN8Yr6VMr/IdzapNVcktaWpY8z3MupJiPNuy3MWlCXnROWILWjv4v59f1fIrOjpwrUOBd/JPnEN1P1HkIuJ5ztTiU0JB0jgbiTQeojMDrQ8v2GW9nlHsCuTgq/nHgRlqhJqHQFMsWgWpTSpgXBnSi05wnzwPLQcaGKQAtuOeXinS0nu3hNRz8aS0eCo717crN1FnkEc/omwZdptmYagaVxnJasQySMunVUe/VckelxLtND4lCjpGrW0FHQnAo8iuIQZ7fd/PxgcLJMiX7NIzBdjcr1yxf1tv6QaHphb+ckFHvsnYU6JDPHVIVTYumPYEmXlzgCPEGEV/2CKZ4d3RsnCu8ApdYvXPGUnssDPPZW+uD6Y8zVoFPCrJrORWKJRmC0JMH2NGT3lXBp1yycBEtGkt/1AY33GRwWLEx/ISzdlvMwB5xbDd/YPfwRIhwna5vtMihPCFnfQoGV/kRevIodsY9jsoaJGaGVPq4hPQfZZgHXJSKHb/tGmjFpYMSeF9yzWu3P0LkZo8wrq6kg1XSfAcSJD6p+ilk1pECOs9sdm/cm6rQuwZkl2YOUD9nZgJSQEhK7f2Cpvd/+VwLV0RatHYRv/Zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68905dd8-b82b-48b5-d7cf-08dc1ccf9061
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:28:18.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBvXXyyRE4mNAyUFaYYvz8kaAfahJFh8xqOI68XEiHMjdPoqYmVPj8wz/qScMD16lu0xutST9+EXkSvAhO5thw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240082
X-Proofpoint-ORIG-GUID: hiaAgQw6vkmxz_B0Eitce-0oPIZFSrVf
X-Proofpoint-GUID: hiaAgQw6vkmxz_B0Eitce-0oPIZFSrVf

Document RWF_ATOMIC for asynchronous I/O.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/io_submit.2 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/man2/io_submit.2 b/man2/io_submit.2
index c53ae9aaf..fb6c4d9bc 100644
--- a/man2/io_submit.2
+++ b/man2/io_submit.2
@@ -140,6 +140,23 @@ as well the description of
 .B O_SYNC
 in
 .BR open (2).
+.TP
+.BR RWF_ATOMIC " (since Linux 6.9)"
+Write a block of data such that a write will never be
+torn from power fail or similar. See the description
+of the flag of the same name in
+.BR pwritev2 (2).
+For usage with
+.BR IOCB_CMD_PWRITEV,
+the upper vector limit is in
+.I stx_atomic_write_segments_max.
+See
+.B STATX_WRITE_ATOMIC
+and
+.I stx_atomic_write_segments_max
+description
+in
+.BR statx (2).
 .RE
 .TP
 .I aio_lio_opcode
-- 
2.31.1


