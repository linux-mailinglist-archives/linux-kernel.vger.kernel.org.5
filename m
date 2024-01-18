Return-Path: <linux-kernel+bounces-30444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32344831ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF22BB22B09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327C2D60C;
	Thu, 18 Jan 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VfdC3H5F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VkxcOT7y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384572D601
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600465; cv=fail; b=stLft8iBF0fKptj4roYz0zwBpsBVYqutnf0fuQ9morkFtpyzsfA7DeHz4fY4vlnANEMKe8Sf3tTR+u6mynZM9mKzB3cxv9g7jbASLBEi+hOUO6bngymckYpXkewcsYg9ubkPysV7z0q4uNLmljk7rhNwT34DPRpsGy7HcNT6ZE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600465; c=relaxed/simple;
	bh=sjRuF4KQt3Axq4US0fnrF7RTAQY98EG6Ph0/A/Mnbow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/LfkHz1wM+hogReadkFBuljENdzlPfe3t4mohukL2luphOmPX9FuvuVP+XDODd0i06L3h5acbavGG5+Ef01JPRC+es3QSfzxRRbjFSN96g4W5IAts7YpwLcihX/8V50rf2L7mVeCj3NYZBJnjGeEvCpsuyVwdsmjwjrKZxLUfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VfdC3H5F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VkxcOT7y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IFSvdB012913;
	Thu, 18 Jan 2024 17:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=QkaDR4+a8ZuL+/Lc1ro0pmZfEHVWCT4VxxzfkVFIBDE=;
 b=VfdC3H5FPoQLp+/zXM2PpZnu4lMj4uQ4pjIvM9e2F4o1YMVelvpuBAm0fy2yQMxaWgez
 6o2wC+EVCzhSwzoRxiFoUAZsk2RiOqx5Yd2Fofx86LpaIeWVx1vJxQfoJ3lhP/Bk0v4f
 T5/N3yfYwrEtXEcunIgdOHZCKe+Vr18D6DDg0MPFMwfpRZprTmz5+mMBnv4aXWx7d4mh
 WYZiGBHdhSBUY71Am038Bqfv48ekU0+IKI2ngQ+KbBWYO5OzoYdBFy7wLWSJsNNbUeDA
 V/tC2UWHSZYk+R+5bSYs9CDu0NEUePzoeOR8kcAdrfRVYLgKzH0kf2OZtsLyTSOaSnC9 oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3h3980-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:53:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IHbQ9s024949;
	Thu, 18 Jan 2024 17:53:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgydhvcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwLLCh93RmLtlA2exBMSB9fqkOC+0dKgakkHAMtDlIJLEshDVwxRcRtB2CLRai4Ur7cQZ3jzZAzJZc4RxpS9s936KZdKVmZWsU8npVfjshHlmGFuccyqlvHsNtBehsnikB1bl74J6RlMyt+vkV5fgOczEwXUOOBQhmh+L5raLA+N9riM/z24ZWqv+X/bAWo0Pwh0eOlU6i9qk/+HDEOEy4OZQ/Bus7UTY4AzG9yAdpsv0vBFSJB+YV/MNvsaP3C32s9bozO6D16L5k15D1Yv2bTxl+2zrtnTCuRrplFXp2zy5hQPgo3NsxA67VEC6suj3sTcb+cwHRBPDSPxky2GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkaDR4+a8ZuL+/Lc1ro0pmZfEHVWCT4VxxzfkVFIBDE=;
 b=fUR1uj7QxoqObC3uf8YmEgFHSb81yLWO39UZxGN5Fys4wEK0DUAz16GBDMBn0ZZfBXmi3ER84f9JpnXIHUpym6oIU7socFUbCAZcIEJISpGQQigSjozpXNJmQ/Do+GkLv0BGgu1TRCSzLnZJvHLpBwNLWJNFQKcIRRRFJMvnP+/Iq4NHwYr0GG9drOgN8H1103XDP8AMfHqjWbd789JOkb/25eDs6Q560LjJXpI12q0WqKrOdBJ3LbIHgmSeZMkMlG6xSqzCZsZkKHM8y1TNwY3Ld3dmTPFwxntnDZE7LmmKLsz20YEjagdZB4lraaRYcTuQNlQGODRSG47Uucv/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkaDR4+a8ZuL+/Lc1ro0pmZfEHVWCT4VxxzfkVFIBDE=;
 b=VkxcOT7yvvvpgpPvPt4DLd8P42JEjwVFqPXtz4xg4S9C2nnmuLWsGOhEg9wtDY5Bsb9Jipz3QzfFqdCrNM7ZcLC/2HOCZaz5RafsuaECQqsM4U6lXd02iZsF9hVKiKuEcjIBgYXprxJJ1Hzz4/mz11PPRBFN6fhCnVn2kgDF6F8=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 17:53:54 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 17:53:53 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: cl@linux.com
Cc: Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
        Valentin.Schneider@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        dave.kleikamp@oracle.com, eric.mackay@oracle.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
Date: Thu, 18 Jan 2024 09:53:50 -0800
Message-Id: <20240118175350.23344-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <affb2c00-695a-47af-77f6-ea1c3f298fb7@linux.com>
References: <affb2c00-695a-47af-77f6-ea1c3f298fb7@linux.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1a1249-1934-4363-8ee7-08dc184e6f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VOcbRuie+KvuoBsAEs19keoeQsFQ5sYguZp7mCGjH4tWd6Xp3WUh2Dk9BwwVgt/rXZMMKPZ5QizVOB2EcBv6EtMrapp1FSG1U6pV66yG0dW0XfGBzgWstn4qUJXUGXNFO8iBrIFF/4OkkZZYhaY8QukRr14Nb01Cz9AGEhdsYtlqI+9dh9/dKOZ0TcwSkwxXnBKqcIRQsOdD0yG+78tVVisWt6nuLG2XHX6lHDEdKrvK8cj/MVARn9UFuKmS3Q5aSsCFwxPuuHb0fuKmpsAePtZdeG6gIFyYNEOCuqJzrpgePc+Njo3j6Z0yNox7osv2jLWXzT/YGahwEQG/C4GM8LtosyjI3rCRiLYisB8j4XkvuyECaJwHfPaSH2H9096sFObDnv6GokloMRTrjjs7KlfYSf0P9dkHhkWlPx3UZExM4fsOrlwvj8XhKtdMS3StWh09L30Cg+qHg1Yh7uS38nzR3ZlXe1bFkdXsdKPfAhnPidKVM/g0OHjU2/Fb/xasccrJRE6zTtg7Q6iLozB91r+mcPbbtKdlktobHJfn8KtbgeHaZXu3p5IYuGhQdg+n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(6486002)(26005)(478600001)(86362001)(6512007)(2616005)(316002)(2906002)(41300700001)(1076003)(6506007)(66476007)(5660300002)(66946007)(66556008)(558084003)(6916009)(38100700002)(4326008)(8676002)(8936002)(7416002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5uRuq3WyQawZyGFmOmK0p2MlhSEVnFbEIrHqxaYAu9iQiUSREA4JQlK+GNXo?=
 =?us-ascii?Q?b52r93c7YzvYzwRHFo5e32uExXVEZX5bah3b6hNJWTUPuuLkvuUTqpP3Ds8z?=
 =?us-ascii?Q?zIO5vJi3m8o3o568BUjTyABB7Gbd6PQsXxuMDCdNo0c+tx6p72D/+f4xRXrx?=
 =?us-ascii?Q?A2TnWSzNYHDsgcBy5v7WS9TUfJ182LlAEZ83C8eCmeHR7V1DxZjUOEJOiQCF?=
 =?us-ascii?Q?mWdLi1eshPQPUQStgsC1U12ONoHepILh/FrOGBvOSM5PdXGcu2cXvvBMSkwC?=
 =?us-ascii?Q?CO5dFFzhqikWfu0wNjf+5UJjuX646TGxrq0UqKEPNKlcsN0B/LON/1OzIYTh?=
 =?us-ascii?Q?gOQkuXmp+odv6v7UPU5ftMpeO2oieyamONgaBZMHDaisTfmLknuDCbtRyOl7?=
 =?us-ascii?Q?1EZ34FW2sTiYEGPPJA8QM7nuMmbGRUClC9F89B0C0p2Xgph8X6l/lACQvvvu?=
 =?us-ascii?Q?wG3k+HYNge6WE4n9agnsZlPwoGX9/UcL01GJunWGcy4T6OAQxr/CgTZKCHf+?=
 =?us-ascii?Q?BKDRybZKZOE4opZ39JmXT731F17WNAi9Q+4E0MpWcTyV/QK0xf7/7u4qIomS?=
 =?us-ascii?Q?/LefxK9Vt6mKbwVq5limqDb7V53cSbTx+XCP5XxhZKTGCJXBVSed7lbfrFlS?=
 =?us-ascii?Q?askrbQ3nn+7at4C7GGKztDaCyxSjEWJ62qgcYEpdusTL0BWLft4qj8kpqvqX?=
 =?us-ascii?Q?MUp3Iz3Liovojr+h9L54qbQIKzVEcWkd12Y/MmJ5sCtM7Y8OVon5ZrQQkVOP?=
 =?us-ascii?Q?qmi7InOA+q5k1eJUPvYQQhV3gQ6T77FXA3yN0j68bULfHPkNqOcxye8pEb1A?=
 =?us-ascii?Q?INdx6E8l9JLOsambYj/XKEZ7JY74dfjtU/QMpgPdvP0ROwyLDK1wCjWVlNk/?=
 =?us-ascii?Q?9Ts2oVRKwnEkdhpwf9Y5oafz7i+/XavTWHXjHimuMO+V4UwndTS5FOmDJkQH?=
 =?us-ascii?Q?4gfK+LO9ahmMZhH57NsBmfXTmt0F6QIle0Qz/OTNlNUsbw+Q1R03hrTtmxzO?=
 =?us-ascii?Q?IvlBDPSk/g0Jb+ocUH8RGqByS6zpD/04My0HgKsrWg16069JRCE4YKrnjFAJ?=
 =?us-ascii?Q?4Ybtl2SzQ1KkXrBPyCSvq/d6aGpRHRzeqI9bHx0+wfYdUB5p9vcEcsRjIcaZ?=
 =?us-ascii?Q?DGr6efb60gQkDK7NnTapsQbVh/NQsacT4Do9hMRWmZJroGFmPIV5eiaEfmga?=
 =?us-ascii?Q?uBG64HQQK/edTSR2SIW0Qv+whhOu2rDsjNcKSTaeohSR2DnSKotmRLXPJiol?=
 =?us-ascii?Q?xEUzvIqgtbv2p3Zsnh/pZROCR1tuKPBAYGz/SMynSRTPfkWuo93SQiN+taGY?=
 =?us-ascii?Q?+SUn+rpLOIKVar1cQWMcWjWcxfpGkLeItllxTZQIYR7JlSDXHVlrnayTg8pZ?=
 =?us-ascii?Q?XP2svuj5JA2+LEho6jNizjEtIGX6LPFpHXZRjxXsJO1fzkB3otfP0oAlcNXp?=
 =?us-ascii?Q?73tMzrWuM141RjdCcv+J2P45LZ9hdaDRc+KkWWm92vP3XOiToy8tggGZnP4+?=
 =?us-ascii?Q?jSN6DOvuIJdao7IB79CJ+l9ohlnQJfdlx2tm1mnI52UWtFuBHrmm6knfMdYs?=
 =?us-ascii?Q?ozdbKEZkD1SLxeVGEVgUL3y0cgrf6Wkedkdzshi5u03s9hQ/2sD6swRn1sF8?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DV8hz+HMgvclV8ZBYzg7n/hJQGEBbtw8qieCh1SslDJ4LAKsRIIxQrZd7oCxIWeCFUdYPo9N22ohnzusFcC+EJRD7OImMDvQwN/2xbj8fgReo6t517j0vnqWFg+BXiJIYeT4h6e82SfSv4G+bOcbY2DhNjlEdpHU3Exmx8q1kpEF8+QV44m6L8hOsZ/w8cE+9wH4PgjIg/DJhQW1RCk+O+qS3TjCs6+LzMhiB2KGaqUHP30y7OBILtqGKXociv1cf6uJY4TDqbLVqDADF21imtMhNZrt+xjaXE8lIHMg4oYmVzwnHLghRUjw0UfPMY7zwPEi+hccJKa5EQ2ZSjxdvlQTcRJFahM/ndqYWTwb/UDCp3LXiOVp+Euv8WiGs/naEBokmnH3r77gBk+aiv5typ9wf2pqyw79sHZtkUqXWet18GpIfZHB+SUT2asx8Waere+yEohAhyrkKnaRbh9a+lL9GWUy09EYSgigVsPStk756PwI57j1j7dhXnw6Gg38aC6ROVX5QGKa3uIhL/rKMWvWZSbXdrp0zj1CicZaMnZBD4YaFAMwF2JWeKHOhW4RSchb3/znj2DP2J5IHX1RmV5LlvBfNjMzdTolhwivi5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1a1249-1934-4363-8ee7-08dc184e6f8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 17:53:53.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIK9Mm0xBvY2U6noZD+81FREaCVGwb3q3n3lSzVfLFpkdklHTdkuliDAchDIL3Qs41kDIfLnxW+IWR91hixKfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=887 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180129
X-Proofpoint-GUID: KStC2U_0kpomHszuXNkudY5d-7u87E-G
X-Proofpoint-ORIG-GUID: KStC2U_0kpomHszuXNkudY5d-7u87E-G

On Wed, Jan 17, 2024 12:01:13PM -0800, Christoph Lameter (Ampere) wrote:
> On Tue, 16 Jan 2024, Eric Mackay wrote:
> 
> > Ack. I withdraw my nit.
> 
> Alright. Are we done and should I post V2?

Yes, please go ahead

