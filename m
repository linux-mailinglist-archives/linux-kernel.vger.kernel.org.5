Return-Path: <linux-kernel+bounces-92360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123E871F17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48881C22C58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2565B04F;
	Tue,  5 Mar 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDfEPTTg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bx9Yqq89"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B85A119;
	Tue,  5 Mar 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641528; cv=fail; b=Eiz8sI3b+AqLWYVof+Fb+yuBj6dtG+A2QmJYDlMjWG3dDsSfbb7lEMxH+XxJvtrzHlZI5sl9YfJmPa2jCylxirosT4T0YsgWi2tqgtzxAijAHCH7I6WRr23ye/wCF0z01IOmyhnA3k6iqJxWtP3PvaJIUXVFFm9K7Oqg8me+xU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641528; c=relaxed/simple;
	bh=i4IWsbFiyR3SO3MkEnMvTGQliezMuPdJi6x8SHhUuAE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K/tMj+Gkg0ApyTLDVgbtzh9GcU2prom6O+SxDUXTOfgn4ynVtERryfLGnadQJgNBye3OQP6puKdanz4UgNy9kXNSAAk7a3ao0gG2zEH0yQqnpe2nnAO1nMDhJ/61Kx8DUzm6GmShj8V5T9LeHH7UW593pTjhcwScjbe0ySVtJ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDfEPTTg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bx9Yqq89; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hnNT031298;
	Tue, 5 Mar 2024 12:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Tksm6zW+z7EpX7B4Z1jhTUYH88CF4cCMqX7CLJxr/v0=;
 b=YDfEPTTgebVrJIwW6dgA1uRV4+eF+23mlvPoTClifXAFo6+e2+5gLVLLYLkw1CW+Y/u+
 Lln+AGIrLZKwKBArL4u3TO4+NDhj3arVBoYa07Nie56F9ny0AwG43h/3+9Gv5HiJQbV1
 kETowMhHagi1QvIu0sTG4fhebZvToNOBreypHDegjBKxy+o2l406MpYdSFIIgsDHJ8rv
 mR7Te9s8fXWPMmrXARsi+Ya/mpD95lLRlhWuDUK5EQB3ESDRvAR8eqWnqEU60MF+0PSf
 n3VA/ucIYFORqc+Ud7HIKlGX7x6wlBfw6igk4w9qtkk9nfzWiPb8sFmxF/0nWAOiq+xv VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthee5f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BWOFZ040811;
	Tue, 5 Mar 2024 12:25:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjdgbes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc5D8Ho4nM6tcoObgS31sE5ChDiTeEx2m75wFBRQsslQaTv0T3fOGCLGTRwM1FHpQTquRbV98VOF7BnJK+M2qFbDx7gqbW4CPSQRBB9H5xIAeoVYZpdqzsGFUSBYYJkDx8yeEOnfE6ZmKE91g0fYQDXL9op8YbvBIcVksgpqYD47zzzMHLvOgx1DDyZMubUoqDZyUiOOT2If2q1pwK06cJqibn7lyl45T5w6AHDEvT1Lg8B1kYaVOMq92cSHWW5dBh7i1+Xi0kcPb8/N4PG4/8bAXjk712RfQpld6m/yS9tO2o2A8CMyZcg+zZIb86+45Zs81FfMoGWn5mz8ncGwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tksm6zW+z7EpX7B4Z1jhTUYH88CF4cCMqX7CLJxr/v0=;
 b=SYPaUkSfsOMg9oFgdhyYenmYAUh/VBUtMVfXSQo7BlaNceCJmCA79sZR+nT8XXDcYqwnnF9U2nldHMRqPOFrv7fp9M8XZt989Qwp6FLjQF9/tYuX2YIS3jF+b2DL/yiJi118tJ2wIqwbORvMzvobgTyZz5xqCJ7WkPqIjUbQv/wraBpccx8Xaqo8BQEEGul/mNNw6RUisP15WBAPozXB0fJyk5sPh1I0KeBTN9hLZNallphAZfi9BoHSF/8yejcYgEog7MK5WtqooOlIg5IN5NuSRt0B7bSceXlIBv90Yxr7wObgxrH8p+H04Ld2ohn5RwbCZfz9ySXRJYJsHLB90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tksm6zW+z7EpX7B4Z1jhTUYH88CF4cCMqX7CLJxr/v0=;
 b=bx9Yqq89n0v3TKLGq/TZPGSvbVgBnkAx+MYH7XYrcdJFM00j7FlFFBOzvdtv6k0/SEIl/zpyJZaxpD/00dU9Hfco4NmtiP/LKd1ry2suMEdDpjW7LhRXUPSYg4C+uapvYLEOxRfJJq0aaJyi8kH5LI3ZkmYIVJMyrck48BBTEak=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 12:25:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/6] Add LIBSAS_SHT_BASE for libsas
Date: Tue,  5 Mar 2024 12:24:46 +0000
Message-Id: <20240305122452.340471-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc9af66-63b3-4517-d172-08dc3d0f4990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P+37CVYPdxYw/UB9Z5vjGLAXycU+5c2QxoEdekTWLGc7VFEALKnE5CSM6ba0O0YPnN24vuP7nWRwLi2cIZoRcD8PGuEprq22GQDA7LfV2oRMxkYeBbJL2uASCWOZZ092xI1LALkhgxk5ucOsA18WbTtjHPXS6WhLLp0R5UCVO4jB3JU4uFhp9Kss4Oa0BlH2/VEnfC/7/SNEFgGmZVI7g4YGc5ftrN+9kT2h6+ZMv+ZUJP0Oj2AxwsbG22mmXino/uyCWE+vRWshqfqkKSCNjqIHIfy2rirMh++Z6P+EMWkD/iThJo7s2fQ8q+96yx+Xd4vEnRR4G5Ep5xqQZI5nl0LsP5Gb/Ex9JsxsmYfrXam12BEDSLnhzOBF+AH62G3aC0rcvdjNI5ZFL25yuZbqqm9ufAgsi8jWNnLEggsqIuJxmt8WXapzgf14vRYVZw9Pm4iNt798W+6UtezJvdg/nraeMQfqeZfIy6kyZmVGVct98THNrYMtwDyG2mWOwAfoG3r80A/stJLWjAupXY1VqwcL0IaaD7NpX5GJ0/FYz+qzUaK/+xyxc8dP7H/8+qTEtIDSn2Wm3cSyJxmdhUPk2CQxVPuScmRjRS6j0G4RRI8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lgPdaKNz6Iy4yoHFQr4xb9Fcv8MNRFtM16JBKOL6T71uWi5RdStGfOx/WYZi?=
 =?us-ascii?Q?BLUzPVSkTpMqzxwun7qm7u7tSj83KmMQ+yA359iSjD5e8du2DWJJLDXsBjWs?=
 =?us-ascii?Q?5efUhizSQaRmeekz5uOxG5hjMVkqyOg6ndgfG2hO8X/1wQwRJDzBPqcMXd4o?=
 =?us-ascii?Q?VxwG0x6U6+jO2R/V0hqXeEh4LWFr26XqWuk5C4t6xG+hkxExSC91FJIZPSFh?=
 =?us-ascii?Q?962zsgWL8sq9sqYT5lt6e+DYfYVsoNJFZqRltAMNYaeB+ZQhFhKaKVgn7caR?=
 =?us-ascii?Q?U9vy0V82DRBVYQfMvJ5QhKAk+FdTsS2yKKbZ2EM0paZ2SrQhkBYC/sftXhGw?=
 =?us-ascii?Q?tmQVkMJYmkIAzJl1sVf9Pb2j2eTdZQ4NMZEQtsiRjEYcrxAGpYGZjYVuZAeh?=
 =?us-ascii?Q?zjhpG6fGq2yfpIvwyUTfuPrlW6sdxk1wzNXMmEEaS2QyKr8R2JISREOmtxId?=
 =?us-ascii?Q?AptywNXTEi/FhICq1A3q66+zOVviBF38MaYM9S6fjxfdu9zhCMxWsedrIJ3X?=
 =?us-ascii?Q?kqe8+Pi77c6X4A9c6+EBdHgrmUdYOWb2EPvrRNn7dBVtYgspO0pSfU2dytvj?=
 =?us-ascii?Q?oO+By6IeCtzKPBPPNNiIZkLq+ZlwRc1ngkSjvZ1zcm+aUJKy/8eb3ldJ2EPq?=
 =?us-ascii?Q?5IYwNmIEmYred7fseP4UcJiZrkWzylaxVolDDJ7ccK4uu6NxsztuGNbHBgbh?=
 =?us-ascii?Q?jOyBD72odUhjhBo4AwiYOSMS7Z5WrkOPPDMWrPLCWjETWCykBHTZcpM6Qcvn?=
 =?us-ascii?Q?cPcLagQDzudQTRey1cPU2WpTIMjloFJ1GN5/nhsPcuNCUs5UGChtvxHXVo0k?=
 =?us-ascii?Q?3gg6qgh5zaIZbeGN4PaLJpVoyc8wMvlNbF3Ri948iwpnvi72t2enowxE340C?=
 =?us-ascii?Q?UOMVENnYtVH1wEvEfEkenA2K0ibSAiba1GUA3UuxIjQL1xgGkacaUds+/zQr?=
 =?us-ascii?Q?pWdGgWW7v9Xja68Sr+s/5DQa9Tgi/Q6kjv+7szRfixwRoZeH6bWwamG/xf6Y?=
 =?us-ascii?Q?MiqW+tRf/ZmpAM8sOXkr6XHYhIw4/FwKK+ly/2MW/dK4wBS07K9ZY1FerT4/?=
 =?us-ascii?Q?ZwpvnOA+PZKXYJ9DrSST8plwxBFHRcFdXMshf4q6aBZPv+EjqjTlI7377m6m?=
 =?us-ascii?Q?U2KUS5v6Jqvmu6hQBhvL7XhibCRQnbOimwuN2EKpEuGwhgkmyODvGHB8dUK3?=
 =?us-ascii?Q?sFK8jBUPT0gQmxIhdv6Gfkja4mlLBsI89zB91kFujQTWHUKV54qKCHZAzWE8?=
 =?us-ascii?Q?7RvwnI1r0Lkd58jQ+fkX/7GEJHNWtxQ6BbbHNNz7ILWWICx5Uf1HgSsgvlG1?=
 =?us-ascii?Q?czlRqNfBBfAgQPfj+5hkF03ESRlUcHOrnG9dQl3M00hUQQwJEJ9PCSxk1OLG?=
 =?us-ascii?Q?+pXuGv4XzRqynZvrAUoG4ZKeJIEZ6LnAdcoZXKHrvRTyZO/KRp+P9zjbZKy0?=
 =?us-ascii?Q?g/IzCKhTnQnME3ghxGEZvo24PKpZG2voUT5MQiD9OC4oIhOphx1dsTx4bt5O?=
 =?us-ascii?Q?sqnhNY7nmiD8O0eLmqqCY+0KlFEYCch4rCcjMnurZQjSj6rQSkv8cZHAkySR?=
 =?us-ascii?Q?9zpc5y5/w2A6JpIaO7LTfoB5k6gt3AOQgCk4wIWmAfFtIxoWkSeUf1krQUeT?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YoP8g4qXeHJy6kdYwzV5gQLVHGRPNSFnajecc1E1poRYg7buYC/Y9VGvuZoI0TAea5y8uNFn6LRSAgTG827eiTUTeD4C/qMyTjPK8e6gaJ28zMDsHXOt4Ta1rnTMYuyjWI8MV81fLq3nkNtxOl4RsRX/JXNVkppojBbM7xIt6hpqXf55YDh4h0yrIXcOlHhhPz8OZYV1mWrdWxgU9dP87kfQicWnFbsgVIPucos9xy8hLE6ZuYVh1mi6ckKXNm+njRb82lceJhHvM+t2WfN6MusAq1FRgsL4rS583EpKVjFc4B47PJmVr//ck7GhxzkrZqJcKFcCqc9GoyyRN9XsRBXRzdf94GEOpN594nJKPa9n+BZD262xX7h4Ijvz2HinpMnTq/5tXmpoVjYCQNl678LJvN1zbWhijW5+23P3kcSx+Ns8KIION4tcY+x0h9c59ZpvRGjpCsmc+2uNcTOl74tSIkUKfJlN1GsYD41ryzkK+ygwiNF//HBK7y4H6r/3FeqxkQ9CZjbRmKrYRKJVYdJ+Oi3ud9bOG99dUimm1qAs6Bg7CJcWjLf4HAZiZHntzPaVcFJXuEo7ApruKj4Nq8E2omH+0Y2YJAkqFfTGSJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc9af66-63b3-4517-d172-08dc3d0f4990
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:04.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg9pe6G4qT9kTVRmjtlRMKqRE9eZ0uIZPkWh1ABd/Jc/d28EUub7F1dqrC8DVvi89iGhrmkLh9Y9BWtlGE9okQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=970
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: xKIJ1QSRIo6y8CV7ETjHLd20UgqvMfng
X-Proofpoint-GUID: xKIJ1QSRIo6y8CV7ETjHLd20UgqvMfng

There is much duplication in the scsi_host_template structure for the
drivers which use libsas.

Similar to how a standard template is used in libata with __ATA_BASE_SHT,
create a standard template in LIBSAS_SHT_BASE.

Based on following:
9f3dbcb5632d (origin/queue, origin/6.9/scsi-queue, libsas-6.8) scsi:
csiostor: Avoid function pointer casts

plus this:
https://lore.kernel.org/linux-scsi/20240305005103.1849325-1-ipylypiv@google.com/T/#t

John Garry (6):
  scsi: libsas: Add LIBSAS_SHT_BASE
  scsi: pm8001: Use LIBSAS_SHT_BASE
  scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
  scsi: aic94xx: Use LIBSAS_SHT_BASE
  scsi: mvsas: Use LIBSAS_SHT_BASE
  scsi: isci: Use LIBSAS_SHT_BASE

 drivers/scsi/aic94xx/aic94xx_init.c    | 21 ++----------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +---------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +---------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +---------------
 drivers/scsi/isci/init.c               | 22 +------------------
 drivers/scsi/mvsas/mv_init.c           | 19 +---------------
 drivers/scsi/pm8001/pm8001_init.c      | 20 +----------------
 include/scsi/libsas.h                  | 30 ++++++++++++++++++++++++++
 8 files changed, 38 insertions(+), 128 deletions(-)

-- 
2.31.1


