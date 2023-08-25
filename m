Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2146788F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHYTGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjHYTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0902127
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:06:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIERgZ031110;
        Fri, 25 Aug 2023 19:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xPMxkRieDfK6Y92JL1GY6hu7Bt94+EbF/fBFQYFUe/8=;
 b=Ta2/LmhI3sn4f9S6TyPqeAD5fEekhWKQKEl6FmJs/iYJoPJBVK7j1OtsjOKIDU4KSpiw
 bOLVEc7TzNTOd3p3cUmyq9m5Ct5hHLWwQuB1cUJuqMcePCqIAasKmXYQiZ1jmPcPJFzE
 iSsWNXWZ0rMIOxZpOTjmItnlb6qx9AU9xH4kUZ668wGeRLUViC3KCHho+AN9fHp+RyYi
 mM+O9E1CJocPtJJWntxNSCHrXLUDOOCjtpyblcHFhBpYKRypcJgW4tgWDe46x3WcczWl
 Y5Yzs/35QGGoFn3r/4gEP09JudIxo36CEBd/7pLbj13vMN/81MWfGf6ecjhw5GNtMzuI oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHPJ4x036043;
        Fri, 25 Aug 2023 19:05:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxqsqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpWvEvbLYHXqObCK+tL2P6G+Ts4HUTvWOv0XGyahYl3/w78al/+YazILl3vn5pBCg3ZYDor88Dr0qlaeSXIVAMM+T9OvUdcc3J+Z8Y+q9MAOxvjGjFjeFOZisOQP+MLIGA/GIcFUiDj6dZLuY56tShtwXw5DyPiVc9+D8VWaR/xcX25Ca+PJMOtPHDhP6sMwKxs+j6rPDdm6EozrarrIWDn2qBOOz5Z8oIYGXWS16/lwVgP9ZRalkDvpxpzMhKiX3g34jy5bWUhsnW7LzZ9Yb4ppS8Yr/bdIOlZDa5Ggk7BaIcMLyg41enACt8W1CCVXHGA7ev4xkg88000ZWnZepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPMxkRieDfK6Y92JL1GY6hu7Bt94+EbF/fBFQYFUe/8=;
 b=Xk+UzjkhgGWBGV6lkx1DniVwrpBAw/wZ/rqYVsNs9EzhhI155Z5t00Oma1M+hWm3tOY2fsZIbN9g/DTJVPdJsrAMwywCKSdyb5zy8VO5Pj72cREqzZS7ezE9/7+CiJ1gkswFNvscBzM3ovO6jTsksWOZVyr7gQMiPDIfzi3Dt2aUgSBCQKGMCjrlv0fyNd/5lNGsLZ4jrX9uQUX7uDXR3uwO4HhK4H05dH8Cgh4Ho/MoZh1gLE5n0O7E7P2C0+HsH8yfkNj4xCmXBKVdjU2Dq+cYCYY/LPNU+83pkHJfS1OGWoiknzEDRQTAoQz//SV5Jb8A4m8GSkOAzPYtSk3F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPMxkRieDfK6Y92JL1GY6hu7Bt94+EbF/fBFQYFUe/8=;
 b=RUgChCt7lPSGEwF3bSt2CCms9fWEcMVOynloujqyct8TdngGhvXZ+GCfZaQGCLT9MK73qdEGNGVZd1boPkwyDYSfptkhS2eOFg6aMcrz20wqsdln7hBglSUZXUdMdJPv0DWyLcxDoUKxGUAOXICLG3OTgMDRnYiWGVuGFKB93dA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:22 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 11/12] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Fri, 25 Aug 2023 12:04:31 -0700
Message-ID: <20230825190436.55045-12-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:303:87::7) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: ece5d3c1-753a-4f34-2ddb-08dba59e3b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmUYLsQACR4xEZw2u+vRfLmnQobbCY9MVl4cusmasSibJ3YqlToRBBzNpvY8aVLmdvwTXyxfUOu0yufC0ASC0xCXwgOed6AFGjWgPWWDlv3hvLcB2orS8361MUMyn9d2+y0gEuLmJHb7Dt6rz/21nH5CanQguWJDIsHn9sVae99cwUt+viP3nr746rG3dtrzdVi5d+rM6akEMHKtgANI5003ZXq9+bqXmubQrsIgeFW0hBlNthyQBuOkN2OvHT+u11TZTIhI4Zk5olD9OBHqNgld98/GP9lQIAMzTUS2OQ9+aKBjjtdaqY6QoD8q9Hekv2W3JKcXknjCj2Wxo1B2jZ3AM4fd6w+QV8K1BL78bShBqcGo4UaWXuGao556J8VK2uQVGvLuc0FX5xlOQ+5BVnEQp5QgcjPTfHiiCVrROjUNZb8eWqs7t1WWHZWLPvfdBIKX5lIvFIaPubM3e1OGjmWt1hTOpU/mZvNVxLByISwXKB0W7XdoeVVh2nbCVcILVEV/361ANfHuwfkCZZ7gbp4NhN3OBKhYDRziz17AAwMwJLw5ZjaN+1w7aLEuyfZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(66556008)(66476007)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(86362001)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(7416002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?niBV8kWv0/DMoVpb6An6P+LVzGdCMb33+emMW1PmjKQZtEEj1wtaI1LfTN/E?=
 =?us-ascii?Q?dleBnJhICX746oHocnmcyCXTWULUJk9sspItLG///47soMpOwD8G1wlaAoaj?=
 =?us-ascii?Q?kyzWsetB9aE5/3mDXtY4bp73OdAfnNHksKx9n8yXep6x59AgjZo0Dbu7MTOV?=
 =?us-ascii?Q?CalylJybIeMzJrJ3QANKUxv7gRByf+EQ2bwn0USxCbcxqQfmVaGChFiyGrjE?=
 =?us-ascii?Q?gcfTW/l8v5cDxHhCBb4VAHBjA9YsyijfVmXWyMtbKVrRebo07g+UjRX0YgZA?=
 =?us-ascii?Q?+fCxoPIm01Lhuo79McQADfqi0+oxCmRqnvE5yVGnxMaTseH6RawNz4liWxX6?=
 =?us-ascii?Q?qailXROvwc2PI6MhPeHu6eKiB3FZWSFdxU0QI0tCawDAYD7wViCDi78fbCcY?=
 =?us-ascii?Q?7G5r4AaP0ijPVlvqM4CskOXWbGVjPPEPkK0s0IncnI/CCH3ScEuh7/XEU7xw?=
 =?us-ascii?Q?CDRE8XhQLfvpMuZAh+fzwpoObb+2aRY/Linoc/D460omhsQXxhqj7VyYENeY?=
 =?us-ascii?Q?QNhhoygc1lqwCZ7Du7ERoDL/aR/bA3N8MB0mpLOV6IZZJTj1Ztq40k8RtkAZ?=
 =?us-ascii?Q?sXb+lCtJEHciZ8Ra7L33lWTSv0Qt+RRk3CDgrrh2E7zqprnvftcB5PoeGGHC?=
 =?us-ascii?Q?YDmJhzO9MZ+hMtOSzRFszUqIBDp5J1dZ/RUFfdYYqPIjg67b4U+Qb+eETSv6?=
 =?us-ascii?Q?h5byKRJBBJiZPLjLD0/mABDhm6ANVNJCSxur1FtQnbBhNECb6oveAVkFGLJO?=
 =?us-ascii?Q?B5/iKLOsWRfkzIYgtMz7HPP99Wa5wDi06EaRiMsZop3nNSlVNXqwaZyqz8GW?=
 =?us-ascii?Q?pHIWX94tOfcfkwDyWPLnxpSWK0gFficb/bzrzeVTkmhwOP489uqhf/PZMWrA?=
 =?us-ascii?Q?P8fyXdgGJqfHOfA70MGTFEcAjjiJSySUAFNe9AkwdJVNlVRzysIVXzkVz2IO?=
 =?us-ascii?Q?9lUAUqF2BqsrA995GG7NufIqkfkjGBzsk/IA2q2yZQ9IZJJGtiLrNrMSaiBZ?=
 =?us-ascii?Q?2YqacBZXRZtnH85nxIKwttGV4RxIHTQutFa5r/IyA+mcXj6LA2FfYaSHZIs1?=
 =?us-ascii?Q?4U6xZy/G4VH+ueMaqA3S0kDlQjM0wHYrDAvTDDAIDWO3vqH/8UErXSKKcUP/?=
 =?us-ascii?Q?G6zBFEr6v2xW6GkJF4wppHBh0ziQNige05re5RlULdzwTX8Hh8RAM/gqyG0r?=
 =?us-ascii?Q?0fdjDY1ZZ7s8ilQ/83l7mfDC6Igw4fUFi9NwXs4UChe3WJ4muszUvmfs+c1e?=
 =?us-ascii?Q?jn6zLZ4WpJ7qGPPQ2vD8IaV5EdyMwiu8cl+BTrgpSYRAbcFKGi7SatYGaqCN?=
 =?us-ascii?Q?1wXFOL1iTkuMNViSTjRKHCLAqAP8isjwJEprkab+xgY6QMBzu1YWBgDe7cmf?=
 =?us-ascii?Q?kdBFxCp8ENi1NftzTObGPg6K5kDs9ABbUSiPQW0YqB8KFQseQnYxEijRG7sJ?=
 =?us-ascii?Q?N6mDiaJ82UlTixJQtGvVyl68HnuDy0K3SZbFUdAMte4nnvGwBCZi63BYjeNN?=
 =?us-ascii?Q?cgo3zUjyZyVvcdrpzPCVclqq4gA9PBs3aHk2SB9GWkDmIwzFiRxGz7gQSgfq?=
 =?us-ascii?Q?abAHZurf311NdGJnjht5Vtd7yudsltzUXqvTFEhIFX/Dllbu0cOWhT+UAM9p?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?U3uketIAvmWiYK2sHUD32dH+JcqP5a8nkG40h4BKlpF3LHoiq1EHMIEcrvFm?=
 =?us-ascii?Q?i0EEoS47XljvK0H69Xy0s7+yamxZnv4LNGhto1It1HBcefNV1AhNXMhAa+79?=
 =?us-ascii?Q?43JvOrs3s5NMcgWZRdGUkSso7iYdDlHR77i4cqPEx72wDUh6WTpbmOe3KPdf?=
 =?us-ascii?Q?NHWvr7U+D6FzmKlM4bodBkyJbvtp/VsCUCyTH6gzJmPPArUSqtHU8Cxr3Y5x?=
 =?us-ascii?Q?twKR6Pp9kN/C33C9hkYWP9wMs9ecio8q59J9fcbi+GgLEm3bv3IL3IE+OKxI?=
 =?us-ascii?Q?ydBzokdHCbzYinXFr+XBYMMEg8oGCN7biJNo5TtHuIMPeGBsvyoCbKT08FWS?=
 =?us-ascii?Q?JzpEZV4ra6pcUNeUk3ihM0GMoKLTN5oW5+zFgi5ZTpOAkD1saswvE4Go2cJI?=
 =?us-ascii?Q?idkmCzeCNwt3S1k0vB9cToON091h9MJvj1PMG4V74Qac3gWWasHSsvqd9yml?=
 =?us-ascii?Q?2RMkbNVgiV8K+zcCakuO8XWIAmcb/c6l9dUjCSan8pYyByNbHytt3d4xlRfM?=
 =?us-ascii?Q?BoGcBh1q1j0i/HxIdMoCRNToh9ROFE9idDFmwO89ukedTxRJ/5OfbgSYsKBQ?=
 =?us-ascii?Q?iVDiqEEmFw+FzpmdZnA4p+oAdQmiuaMDB8b1eulAyy2VbWtcaj/nNDQYQn52?=
 =?us-ascii?Q?kiwinJ+FFtJu2B4l7PAeLCI+Vct8ilLuA7ootm5iIXyr3wJeIlZidXc9xZ2e?=
 =?us-ascii?Q?VsQuNEuM2UPEZ3l2xb6hYAnuuLcyNL8lEKTqU96V6T3kmxAeUxegRoDaMIuJ?=
 =?us-ascii?Q?dsrRSalYIDyvc/TE7HCDQ7QC43FZiiaQwLPZH5jD2cMM25Rzvk83p/ggA2qC?=
 =?us-ascii?Q?bFnrKnqIZTjZ2fw7x6Lb4IG1ozM4iQJrIJd0KufL2mTOlqBV18jHaenBawRp?=
 =?us-ascii?Q?yUbM5BQuInDxpCbUHJGBc5v0jRQcoz5z2MPWQyY4uJ/k9PeCTnP4HpONN4DG?=
 =?us-ascii?Q?MxgYdjmaB+XL6+hh75oOvvZ/7GSf+woZ6aTQm3nmmJOAT6ty7y7K17nK7d/U?=
 =?us-ascii?Q?xo0kCcRZwbgm2LRK+0qxc5//4rrxFbdoK8uAgHBwy5tPqvIpNYSC+k2RD41S?=
 =?us-ascii?Q?NoQYwQ6ib9kx6M1DjHigu/buAfNoAuAFhn97gLG7HCTzfk860AJpDuH9kp/P?=
 =?us-ascii?Q?yzk1lT6ChMTI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece5d3c1-753a-4f34-2ddb-08dba59e3b7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:22.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVKqhjj+Bfedxr1RlOSpOMV1U+XzrmeQXG8xQ8jiDMfcelCeaBIu0Zn4Ug3ByBw+FD0sgDjPJSwnL3SxqI1Sxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: DUWcYynt5oije6WGFCohS6jt-asJt9Pu
X-Proofpoint-GUID: DUWcYynt5oije6WGFCohS6jt-asJt9Pu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Add a flags field and pass whether it's a bulk allocation or
just a single page to decide to remap.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 904a64fe5669..a2fc7b03ac6b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -36,6 +36,7 @@ struct vmemmap_remap_walk {
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
 #define VMEMMAP_REMAP_ONLY_SPLIT	BIT(0)
+#define	VMEMMAP_REMAP_BULK_PAGES	BIT(1)
 	unsigned long		flags;
 };
 
@@ -211,7 +212,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
+	if (!(walk->flags &
+	      (VMEMMAP_REMAP_ONLY_SPLIT | VMEMMAP_REMAP_BULK_PAGES)))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -377,7 +379,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= !bulk_pages ? 0 : VMEMMAP_REMAP_BULK_PAGES,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
@@ -427,6 +429,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= &vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -700,6 +703,8 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	list_for_each_entry(folio, folio_list, lru)
 		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
 
+	flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
+
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

