Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1800770A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjHDVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHDVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B914526F;
        Fri,  4 Aug 2023 14:05:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCk0i025344;
        Fri, 4 Aug 2023 21:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=OGCTBNs0NpHD8YXJrpE1qal+dvlW5hYUnbhpN3bSiz1x8rZgxYccvqiQMN0dINQzmfMg
 JkM1RpSxFCPhK5grFzn4HkWtRaZFTzrUk9Q1VBUsI4P3+6ctepTraJkZGDC6XdHHpVHi
 pRoo4EkMCr8jNpaK1+yuFY9q2Xy7BTy0bNAr6bMXl6sR8b7x+3Pkdj7xmaNvTQIBKcLO
 vaB3J+xl7W88ODtZDTwJDNm3VVDqyqW85Rf7DzPYyb688CC5Pm7hHknkwxtC3fafF2+/
 uJII42kdtZZH9DjbnGFP1QmOOgPICbZMvwkW14e40k5i66hxaPfMWrS7LxLG28jt4o74 Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu4kw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374L0f7s035025;
        Fri, 4 Aug 2023 21:04:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m09x0uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBvFcsWiQZwqU2puYvnR639j9Pw4njP55un9tGOWY0JuckWxJEDUmg1+ZBfHswennfYV2bTRbnCNSsrarlO/gQEebTUS8T8sWa1NuQAfmZ/TPSad5dJTKT7e+lnY8ifB5TMXabEn7lsCXHHGAwxWJukvyOzo7EOPvg1zjoXSEBLXUK5OAbQH7mc95xDEUxk+W7u/8RvZ22y45a+MyQ+BAFoXxQzjZsAR5gw0aDWq9kQ9PmkwIeM5ml52SWf8cgeiU23zJ3XArT0VIAbnpSp3U1ziD4E7eMEAvMXMEnDQ+4f7p4ZItgCxPnm0DBBB5WndOp4u/scLfEZb++DBhsm9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=oRf5m+OxNkOczk4Z4qeGZ9zK4Y/XqvGLPJxA5zvk57JI1f/WUcxUdCx4k4uzhWLAebZD7NUi6uDcwkoAlqGWPnspZG9XxhxABoX2nfK9uo0YaC1rj98yghZrjsAVZIPH6aDluxSeO9klMFwgVaGfLQeVWaZ1dUu3STgfdn8NlCLpXnULhXzge9JbREriJq5bMrljvhRzUcdFsV0Be84UlRJ1ULtiMfOc7fn71CHhF6GF5iInjKhyOBUcbsu83axUtcSPgXsVGK1gEYN4eYnrEH40p+dAyWvxk0zvEG+6aaCZ5SJjXXtmKcgK1zSa0Xb4gQw7PyQW8TEvC8FFmeX7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=hKB3b2HKOq+kTtK+tC2qqXKMjwJR8wKSVIFgdkTv/Z85Uc0lcrjb6CxOP1FgBHh7GLwRUSvC/n4zgbRUt53R86YFdJqOLN1B+Z7D5bWraDRIfvZquDn2OBa6UT1IhlOmid4l2WZ1AXE5mkiUcxJuglwMBsFzsLedCNWYl9nEMZk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5330.namprd10.prod.outlook.com (2603:10b6:208:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Fri, 4 Aug
 2023 21:04:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:24 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v26 6/8] crash: hotplug support for kexec_load()
Date:   Fri,  4 Aug 2023 17:03:57 -0400
Message-Id: <20230804210359.8321-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0155.namprd02.prod.outlook.com
 (2603:10b6:5:332::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 57220b1b-35e0-426c-2296-08db952e6190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjZkLjUXBOCdKqNcwvXt9vV6DX8iLvZZQM2qx/rB6Xe0zqG5l3dZL6CTn7MgmXLVJSGNbKvxbk18TU1bJU4U1ug66UGAORLyIVSFtzEDkoNSBbUg5uaK8o/18q1NFlMiAfSSQQrv+t3aPwRyngct9hcQ8C+qkxEpKTO3Zp/2660pQlMueQuPf1mcmoZP2nxKMF+DROL9KZ3V1m4Pwes7J9r/D0y4/zf+ZhYU4B61E+s9f/Kg9gn6jr4vwAhPhWo7KfM0PIhoPsTsOu1rw8Syny9WxRWySnrWfB+Lggf00IDY3VTcsvbuYSOeuKcISMMcgh4NjCenQ8dPnjShddT3Z2epgEWSTE+zu6Wsvb4RMp/tRTBIKYp7pKs8uPnPpmXDQ/ljbCCnuKSrUIIfHY6rPW7EMoLn64LvqhycGOHez26P6RdD5MQQYrr/u0o/CjorZK63xB1uedRWhVVE2VgkLbcOdOXIyTDygwRvfksyTj3XNBzcIGkUVnzMoy9lP0t6P1HSxqGohlwOn+X0fIVBoA1yY2XDW07HerCCLcVMX6OwADiGUD9aj2MnZ0ftTVZeRWdzbhifNMQQcvRHoPVqHKhjH/QDBZBu/VM+sn0atSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(186006)(1800799003)(6486002)(6666004)(6512007)(86362001)(921005)(26005)(1076003)(6506007)(107886003)(2616005)(36756003)(83380400001)(38100700002)(66556008)(66476007)(66946007)(4326008)(2906002)(316002)(30864003)(5660300002)(7406005)(7416002)(8936002)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCkCNMhscrKOKD9EByVCUS1KkTjjh4iTMK8A/FclFCQfKFitd8icKVZZHcyE?=
 =?us-ascii?Q?eJVqE7aSpQ0Er/HsI/OnbC+7pPpEHkEx5EVaS7LgKghMtFxkROg82VDCgEuz?=
 =?us-ascii?Q?mnUQEdf0YTFGFwJlUZOAxawmybbRH9w98zn+3AxDpdRsJ0lozLk34XH5mUl7?=
 =?us-ascii?Q?7R6lunpa6PyRDEWK40zLNLWfWz8l47EzGTf/wjujqNO5T+3tUtCcYyEGwd0L?=
 =?us-ascii?Q?xoFaWRKb7Y8dI6a+FLzDpf0agrnm8ZN0YBllriMYhiMouefIg9cjndDTWWwp?=
 =?us-ascii?Q?d1mTod8+vx7pktbZv7r3V+bH5L70tSCAaRNe9UdztX5s8h5nU59CJwXdp/Q0?=
 =?us-ascii?Q?9YJmnnty/864xqTawXmezHR1agltkz8nDSpb12nxuSQXzIRz+t2c3JcQgY6D?=
 =?us-ascii?Q?/NuBtCh0jDw7M2WgYneHo2QGGragzjhMQ04Y+CFSVvyC0QC1DdvSK5QIPvkx?=
 =?us-ascii?Q?AyDxQRcQt3HtLR/tJBM+KHFVTNHlMKp01++4BmINg2rUUdVEx9WcyY3Eqi6v?=
 =?us-ascii?Q?l4AlsqGnY7oAB9IBWoD/b2Ls1MtZNNBWWCpNxNwoNv4RDVge1x5alQdSDkAC?=
 =?us-ascii?Q?4aTAjtIbDuiXtpCuDHSCTxo1IxXncA+5/ufgYfOmEH/ktsUXXsghLVmNgGVn?=
 =?us-ascii?Q?T36Hn7bfSre3+vjaGU+tiJB1kQqEpQqspCwLoUVVYhwHi8Ht+I0hzE8FUr3K?=
 =?us-ascii?Q?qrhkdTSqXBaN3CekLCi1UIIIUH5/4yPp4gIKH8egidC+nfZSwpZAM4Sj/QNs?=
 =?us-ascii?Q?V1qJPBcMt+ud6r4sfjyK1PYZRRCukguygOzwrz8L60+QrZIIr8wJ1HoiFVb8?=
 =?us-ascii?Q?/lJO6ECihYC4UCGEhdaHazBZcl+A5zfbIMYwJlRR6LV3RDhA8CdozSXxtDJV?=
 =?us-ascii?Q?E1l18EkyeSgg1uVQFE6RBvxj3e/yCOKmTIyOU/qHPpZPsbm4lrmHCq7UHvuU?=
 =?us-ascii?Q?XrLbUW0PG16Exh98Fm39sT5SqNDJdOEo6A8YHtxs13joxx8G9BiC/5BG5UGt?=
 =?us-ascii?Q?4U9n4bS8IGN5lM69eBInRr4vfx/Ag8eQ6TSjpKK+kRQFiOh1t5oXsck/T25t?=
 =?us-ascii?Q?rTnr0GbTRwLqxBIJeLw4f9St822RoWILjOhO/1hMQAAdaEM+ehtzKRkv/KiL?=
 =?us-ascii?Q?kp1qHifvK/6dC9j/Url57AK7DOs901j8nyIRiuETHQnnomHg3YZxFPLLnAV5?=
 =?us-ascii?Q?aEw+k5WM96Anb5Dd1uWC1X1CSvNnF8ajuB1xAlsezkz1KnSJwt9nybl8BOjC?=
 =?us-ascii?Q?aCadZFQ5srSChTEd5zIfoUQLPvkH6X+jdGeoKLnZujk9H6EN7sLjvsZ7ezge?=
 =?us-ascii?Q?qx/b5OVT1POkDIGrehwb2eE+nzAxMtfkm1MzmZ7XEXo+nIyjARVO1fXdLCOr?=
 =?us-ascii?Q?hVDLJf5xmVgAReKi86RTPiKWIMiRoIpx5sX+81jz2DCh4BwymZNAUJssFPzh?=
 =?us-ascii?Q?A7+Q4pmYGnMMn0gEKg2t7iF5q9u4tjxifc6LaON+8A3eBYDkFn7Ig2DK8OeQ?=
 =?us-ascii?Q?7seldoUTSgKsTM5BPhfY172Uu0XIKmZ2kt9uX5gSeQUT/0nw4J3H8i8YlemO?=
 =?us-ascii?Q?h3j8Z544UojhNX/VKTR5bd7KTo73DG1pRNt9iaiFVdKew8aa8m4l+Ze3FGO1?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nQxS0UplrtvFDaf3FZPjQo3K/2cUnGOrioqyJ0nQEPX3i/NLvooNVpD+4mNm?=
 =?us-ascii?Q?EFgU20HSyP59kzH/eCmqx8mfEJIIb0bLnpRQcftJ2V3AeuC7qKQmq9FmAO+b?=
 =?us-ascii?Q?t2EO4miWApuoJv9iTS3AkNYZVpNzARMVaYliLi/j+hfPrNex6GXfqXxgp2xP?=
 =?us-ascii?Q?Nlg8WCfeRl2+mqqn23xCsFKz7/46hvWeOf3FiFPcpz2W1HItUBjsU9Vng1oi?=
 =?us-ascii?Q?/5oLKJhL22yEskSS8cVK2iCfdRhjvnxalwgfRM2GcpjVlV/RX8nA8WTyLYUB?=
 =?us-ascii?Q?gYGfokPq728YX3gOTOcU1xfIaivGAhwCo/KbFEvFOPDAnV+PZFwFkxOIER9b?=
 =?us-ascii?Q?Epo1x45HEYpV7RLJyyn7Nk1WrL+7d+5zlp1FWrnPEIaVbxl0nuydieN26dka?=
 =?us-ascii?Q?cnJfPsZylXFXbPQnB+LQCSudBmlLnMlw0UUAfhGogCMNfdMGtgSPKAus2G+5?=
 =?us-ascii?Q?DWPI16iAf1efGX0sYvVoZ6JT9uSb4hEU4rWSrGAUM3TRmz2X1lBZP6xry7w7?=
 =?us-ascii?Q?4t1lVViWbe4yna7EVNM33kGxUSNR6dfvhF23sIzupwaIHIHrJnm/AHuyRuQz?=
 =?us-ascii?Q?bScc3d+yTNN841eepE/nxSlzXOzFstDUpezYhnkklIwtUUK4EW4HC6Ybum+E?=
 =?us-ascii?Q?SP6QhPYTigZuJaHFoAA5t+0XWBv/2mR8nZ2dGj0KPooFn2mBw7wtzsGtuUO2?=
 =?us-ascii?Q?OM7Gkm49jQWMpPqqS4N5mncC60eHcg0ShAZjHdPUdb98tGpKGbSm7eb3KuT4?=
 =?us-ascii?Q?cbHpa4L4lwJnxma7SMk/1ZHAiETdj9HN66yUkdn51C4yH0+QztXGD7cn2jMA?=
 =?us-ascii?Q?bZpWr3Rn4kmypyy2pT2Noc0cQC6y7EAi1u8CPyCflBObHUAvrn+Uct0sNnfG?=
 =?us-ascii?Q?7IDQ+MRwyUZi5sy0YIrM9v5ieJ9fgaKBjrm80/sV7kAOThQjT/ro8NbrRwga?=
 =?us-ascii?Q?B1UTYavaoDhVx0rUhUO/ONc48mxlaW3CKF2hBGcUrJjgss9Vd2NpN1o5WGqj?=
 =?us-ascii?Q?ywIp3wUrnY7WO8jl23OXwDw2LYbWJcgVosXf1xtmUcRrNyyLkYB/rkjE9mWQ?=
 =?us-ascii?Q?DqshrWWwrVrceSK5Y6+PGop68rPEf6HfOHS+hHYQ7sV18xdpBSJbUDKmavAC?=
 =?us-ascii?Q?hroV7W6bAn43vmpQaFa5dDHO+oVG63Qe2OS8dmfrfIMcVgfqaxtDEp2s465M?=
 =?us-ascii?Q?Ibx5eXXbMDa6VycI7eRRD/u9+/FylJ6MG/ZEA23JD2bXyTh8nKDb39gVHWzb?=
 =?us-ascii?Q?sBiaFMBRX9Ugaj0dw0ENwV20eWW1nU1xSI3PW6+yrGaVcVUbIQtzOweP2sNs?=
 =?us-ascii?Q?7V41BYG9TrMESAywncfnuoLErDU928rEUdAbXWnXVsmrqR9CjDOY1DFNjbqt?=
 =?us-ascii?Q?GrYgltJUou8VQ5OeTETlocAiEfnt6SLgWqi8CLyxBgJ2VSjEkiyih/VwLtmu?=
 =?us-ascii?Q?bJ88lhKTSV4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57220b1b-35e0-426c-2296-08db952e6190
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:24.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yNQcRrQGiA4opl8RYhGq7Riel8szwSDGeUmsp2HnmeUJJMCEGhzWsxQD11NjK4P7a33VHNZxEYp3oiZWpOX0OVr88faOECj9lbrvNM9ato=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-GUID: iQVAOJ8-A52nHZRv4rmeimp6mWtiQrOO
X-Proofpoint-ORIG-GUID: iQVAOJ8-A52nHZRv4rmeimp6mWtiQrOO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires changes to the
userspace kexec-tools and a little extra help from the kernel.

Given a kdump capture kernel loaded via kexec_load(), and a
subsequent hotplug event, the crash hotplug handler finds the
elfcorehdr and rewrites it to reflect the hotplug change.
That is the desired outcome, however, at kernel panic time,
the purgatory integrity check fails (because the elfcorehdr
changed), and the capture kernel does not boot and no vmcore
is generated.

Therefore, the userspace kexec-tools/kexec must indicate to the
kernel that the elfcorehdr can be modified (because the kexec
excluded the elfcorehdr from the digest, and sized the elfcorehdr
memory buffer appropriately).

To facilitate hotplug support with kexec_load():
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR indicates that it is
   safe for the kernel to modify the kexec_load()'d elfcorehdr
 - the /sys/kernel/crash_elfcorehdr_size node communicates the
   preferred size of the elfcorehdr memory buffer
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) dynamically
   take into account kexec_file_load() vs kexec_load() and
   KEXEC_UPDATE_ELFCOREHDR.
   This is critical so that the udev rule processing of crash_hotplug
   is all that is needed to determine if the userspace unload-then-load
   of the kdump image is to be skipped, or not. The proposed udev
   rule change looks like:
   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The table below indicates the behavior of kexec_load()'d kdump image
updates (with the new udev crash_hotplug rule in place):

 Kernel |Kexec
 -------+-----+----
 Old    |Old  |New
        |  a  | a
 -------+-----+----
 New    |  a  | b
 -------+-----+----

where kexec 'old' and 'new' delineate kexec-tools has the needed
modifications for the crash hotplug feature, and kernel 'old' and
'new' delineate the kernel supports this crash hotplug feature.

Behavior 'a' indicates the unload-then-reload of the entire kdump
image. For the kexec 'old' column, the unload-then-reload occurs
due to the missing flag KEXEC_UPDATE_ELFCOREHDR. An 'old' kernel
(with 'new' kexec) does not present the crash_hotplug sysfs node,
which leads to the unload-then-reload of the kdump image.

Behavior 'b' indicates the desired optimized behavior of the kernel
directly modifying the elfcorehdr and avoiding the unload-then-reload
of the kdump image.

If the udev rule is not updated with crash_hotplug node check, then
no matter any combination of kernel or kexec is new or old, the
kdump image continues to be unload-then-reload on hotplug changes.

To fully support crash hotplug feature, there needs to be a rollout
of kernel, kexec-tools and udev rule changes. However, the order of
the rollout of these pieces does not matter; kexec_load()'d kdump
images still function for hotplug as-is.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/Kconfig.kexec         |  4 ++++
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  5 +++++
 kernel/ksysfs.c              | 15 +++++++++++++++
 8 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c70a111c44fa..caf22bcb61af 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -427,6 +427,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	/* kernel_map, VMCOREINFO and maximum CPUs */
+	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6a8a724ac638..bb0e614f2a05 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index d0a9a5392035..6e5350d2d7a6 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -144,4 +144,8 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory buffer/segment size under 1MiB. This represents a sane choice
 	  to accommodate both baremetal and virtual machine configurations.
 
+	  For the kexec_load() syscall path, CRASH_MAX_MEMORY_RANGES is part of
+	  the computation behind the value provided through the
+	  /sys/kernel/crash_elfcorehdr_size attribute.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 53d211c690a1..fa918176d46d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..107f355eac10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

