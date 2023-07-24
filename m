Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B375FF20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGXSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGXSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDA10E5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFO8RE011881;
        Mon, 24 Jul 2023 18:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tZPY3DQGdPjFGxPNCaqQGGq8h+diFa5oiI6IQbHQjj0=;
 b=JIpmgvsvcYfsXn/5+ZSxD84L5ec+/LdsaEhMduwk6k7hAGaGxFcbuALg0n4clc1UkqAw
 /yc9+PdEMp7g9Kh8vxpTsIneMfHBaaSfeK5dRjoa6kTJ5pqsuJ33YtMGIKOmRKiWOF8J
 9BNzCxl1lOMuqDelUGHSu0DjDFWBupriT1J25D3O7DiwuXen8xg7awWbDU81E9Y2rqZX
 /ju8YRmPlrM2aLtRf2Dpa5W1VjG0hGCJM58Zilekvrlv0AdbnqS3OSYWThDzAv39kVD2
 9zlZrU9JZIspTXC3LLW0NrygnRyjV/UltKo7AWu3pYPwuNarhHQj+AcRqS1ZhZHH2O4R QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nukcsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH08Gu027537;
        Mon, 24 Jul 2023 18:32:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja25gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG86+WmvgNpW5pxzkXk/wz8otDGHG0znC/5HudhqsYBmadNoUhs08ezMdegDzb7ASWlkjEekHDZJTYsgBhg+xKdzDQgzYQ8AMUjvW7FunOGQgUyiVTMXQkhAmV5uWzYW3B2VrCsjmnz2yfQJnxs1GWdJ02bye1ZTjXDgfHFs3jYLF0hznRYkOY2zaMjdOX393i0BWL7sxhvMQCGBEqJu3kYUMv43BNO7i4u/lPLZrSQimlFvb2nEWdT/kmE9aCTy/A39FNpIZOZf+o4gWvq0Z9ZkOtxzPAiQLgoCkWWVoGPIO3B95sqJtFqP+Ah9J7HNQOfaACQg+nbFWZJw0X2/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZPY3DQGdPjFGxPNCaqQGGq8h+diFa5oiI6IQbHQjj0=;
 b=hmre9BivzLnzT4GEyzk42E9zcZdFwgKYLC0kCF0xN5V9lsi3oXavdwZKKMrnw4T4g21gnz1i65I95KvOrodlnoV/Pi7Y/BPKua4GXJDQVVMuY52ZNKKLWMSRDnJDyIpAcfhEGMkRk+Sq3jsj1/pvZcbsZl1EYvsqFBxQEiMeEIdefFnJEFBFpRRjKXidHUH4CpuQoyIArYYPN8/zMS9a3MDScWDJwepy2fnavoDV2tBjOVPmTjaiHIP5cRWr8Rc4JIUU+P9CQrIJdYYcXQfONkNMRG/AMYV56i/kAmytlVSuiO8zk/cBAujP599XccOs518uhUkBYR53XdGzbUSpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZPY3DQGdPjFGxPNCaqQGGq8h+diFa5oiI6IQbHQjj0=;
 b=LlKpi7y8Xjrv4TCqNjK5IU5aL5M9EsQQm2Qq2DHIQrced1RiNlBVNFzUjiisjupbEzXcZXcNL6bQf9NLTYNJUmLpFcigUh4+IrxXEmAFY71rz+yRWGmNerZDp4Eke7YvOijNJ/i9APkYv/bwdqsSTAu0pGC35j6ezsQst0Ndaio=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:37 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 08/15] maple_tree: Adjust node allocation on mas_rebalance()
Date:   Mon, 24 Jul 2023 14:31:50 -0400
Message-Id: <20230724183157.3939892-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: ec318f7e-0731-4d0f-ff06-08db8c745b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teWsAAxjQUS6ztw7jCSCETzqRmebu1KELsLI5P20Njp3qqS54TKzQdhk+2lnzrRQIfLtBn3aBG//01xjpS0m1Gp2SHJdfXNIm2pUUmGHrirof2E9iYtyobB384gfXBFaPoHMWZmDdNAnDhGuKER0iEgSKPXwCbV8VzAfj1AeZRLPV+wfulPpUxdvcryIpcf5LaHtICLUczowx4M3LJ6Y7E5L6RnhkRwHOuXxl1LUK2hTZObUmmpcIYDcS5WdXy54NPmkc5lV6BVXpV0dtI7C2uuMhMNk7/AiJsLOwtihJUY4LdkN1CHQeaaXIUTKciS3o6dFjB7/Vtwe6Yus98w80L1EhhuuK6rpcqZOneB0Nb9g7IN6wWKv0QuuzWomBxsMFcTkGWLs+Y9BxhUGebRFLH0j/ZNm1GLwlySvDSgemueU0U32QrLYlNRDgMA8V0nCmjjje6d0cVCuAipDHoaMuQghvduhD2LO0bQNeoZ5iR3obOd3GpnFW+Qhtw9IWck2QbInnaq1fd2lT8DDJKHb7wg97JpSGkV/tDoTDEvgE7GMxBT3IEgx+xtvQBsa0Gz3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(4744005)(6486002)(66476007)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Us6TmIE45rD3BJsFYuZT2gs6zHL+Phy8Jc2Js8cIa+HWUAFmoyRkGggpkTS7?=
 =?us-ascii?Q?rAfxHkTZjf1XjapqLQkgLXHlDh63zRqJ0gQLeMR6UrJRjyr8I8EHfSVRuFlC?=
 =?us-ascii?Q?NXrn07a1gdj5PsjYWoeKRk4c6Nzu4DP666iU3/8SKCjVgA5g810eduxy5SIu?=
 =?us-ascii?Q?v5YI2TasHE6vmpgAL9at3ioHbKwTlrXrmYqu50NQZbzCPoKxIWnolLSjslqb?=
 =?us-ascii?Q?+Um79BdCNFlV2V2qsJpww8ob6kk2mnK7a1O5OoYaP7qJvGhmPNY5hqoZAmWu?=
 =?us-ascii?Q?bIjQPTIlZ3/7a+pBF61LJ1kjNu8JgNrFmkm2is/9lqu23KA+xcpyI7u6LaGE?=
 =?us-ascii?Q?Ecc52Ge/NEZ1u8FJ8PJRwbEE6srXOrnX14JZpU8NGypuo5rnpFJS56T95KE7?=
 =?us-ascii?Q?dsG08YduHwBFSzAyQU+XyKGcFG08h1Xp80d7W0dpHvHaTShL9KI1Ocw3MpPn?=
 =?us-ascii?Q?2rt1cdxmkPsDezTrkellDFhL3zrgQVWmodgdA2y/HdGtHpCPDqFQaKwLVll3?=
 =?us-ascii?Q?XS3oz+8nT2PhojIQPuuxhgCk/pHo+zYFF6QzTKtiaaElip+vsU6hs6P41Gc5?=
 =?us-ascii?Q?HyZgKBwSqS3n3twLq1EEgD0fdehYPNCDsQhh8E+C5LSHR5D7gjGE7PhN9MsL?=
 =?us-ascii?Q?X87cs9iDoGxmcRXRBFPwqX/wqWa+eNMjDbuWMDhqmgJdJ2GOpsDOJMcqWTyM?=
 =?us-ascii?Q?BLKRRkgANcLqjnj4R8tLJ4i25DkJOpAnw84ePheKI224DB4dl7FmLUGYC+ud?=
 =?us-ascii?Q?kohfvs2CP9XCZCXymBFH/k5Epu9UbOOWCjt7RyWX7jHbttcjHMW2q+ApnJ+F?=
 =?us-ascii?Q?NWMZBkehGIMz3348C5mnETvml0ayts8fYlCXDa1yOv4HFe3FmZ268beUEzas?=
 =?us-ascii?Q?45P18BoXAZSjFRI9Q8Lqs2QD808JqDL2dq9IuJolLY30Gswk2I+W9wZwO1bY?=
 =?us-ascii?Q?gEcE5LxCMdMm242SvYJgG7bqjt3zDdrHMwolumApX+YV5XXXaSzKzlWakbdm?=
 =?us-ascii?Q?jfbu4hIT+XjySO1/zw4ZMwdY0st8kOd1hJyUDWi/pUCKcCdTTfQhZ+Q9SCsU?=
 =?us-ascii?Q?qc0lqe25bvg1accJZ0R963d+epfEaBVrzzdnW4UdYiz62BiVWOnJZBYMQcRS?=
 =?us-ascii?Q?N5pewoMyoQeGS88sC7X0geTahQcEkPqVZHYsTPqHg+Q+ETO2d/ePh4k7q73r?=
 =?us-ascii?Q?RC/kQCw1zlFpyxIXhY1nFms9TlRTfUhf//dcD+q8WA4ttOEfKg1FR08X3bDf?=
 =?us-ascii?Q?IrWIspoc6D61uglEdDTAoocRVQL460+EN+zeHicv5VIxn4kMM37d0li87oZE?=
 =?us-ascii?Q?qf8rDLU++FzkWV0K9E4HQEhg+5XM8wYy8U34LyxNeAPIAsWHpTTA7ytlmczR?=
 =?us-ascii?Q?NHxuQ6lyLc3NpiLiexN+rEQVP922tdYkXRV+/3n3dorTFtxpth+LeRZRfdVn?=
 =?us-ascii?Q?GQ8kSIHXdYxvlLHJ2q1QK0tCevgio4L1HkiDtuq8OvbvK765tmgJhjfA0xT0?=
 =?us-ascii?Q?rrAEeJQh5Vii2ffcGmELGJKNeLmol1BFQ2c01xjAn1zhCmQLC7cHd1ULDYyj?=
 =?us-ascii?Q?LEw1BtJSHCxoEhQWvU7P+WiF+J/6qDvpSADjVLCtfIQAhHSKpM0PtoMoYOsS?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AyMUcEoAHz2PlLzgIvLuFSZX1VYmmOZ9EqDQ65Avq+YkQQRL13c9d++TAnOpB8TJJEJci62tw6wd6mf2TcH1wDmg9lr0hEJ8AN80sivQ41QD8Xzfp2xuiEn054cXn4m1NVvnUt9aa+mHP59RNPHMVKh8+1S7s9CzuflDQBy/8bh8LjGDpekP6bSA5j+yLhAGdica78USg7TSYTpN5K31q4D/Pu2EVuYC0W6OJoucfC+Lj6iZKA7Nw0QAoaygrl40FWQFJVOfC8SbHQz6q3GlHqbbiQEpWfleQKvLgPb244ReOYYsqx9D8EmryDvyNfSepf+0Y7jkEE/2rCDH31+bg1SYBgyhMAibHLrA+zOeWQHPUGP9ERl26y4b6J6N1k2bKhP8mzNBlbK7yThixj0/IN6Ca7PtiCrAt3+TXnAZml6vJl1uNi2QZehHBIE5TvaCZmo4PYj6bINPJQIMtUPN/NWy00OOhkkewynMrD5CcwEIRniHxcetSc3T431IJ9PU7ZFvNa4VYYsh50Lz8qdDBQrHDI5RZnn0T/prHlUE7+YjU+1IoqRg3FCPlpY0+shVKvt8W9DB3J3tlBoqTanKIcKhvqytby+zQDcieTyLdvxMKuKxHVssBftEDtV4lNkjoMYVCP4c5PWXEaXq6agL0ROU3vbsU28hNMfYcrxIxNd1SF2zF7dPKGQwd7ZSngnAsgQqION7YcLz+GBf3w3ligfBqu26A0b4L3ak38FSMgcfjxfQIkemQjoyWSGL8rvFdmP9ihokVpEQ3lPPu5KQ9pdHmqsTRDsBj5QC6787a4rMZcj/9P8anqbA5CXuig/jdfQ1KOY0f1fN3nMQvIYTC4h22Jnvx3f2VTCTjolBF543zhF+thl7AN+91ILPHG6dgDziEKxFjsH1F5pyWyptD0x3sqj/SY5lHkghhUQAN5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec318f7e-0731-4d0f-ff06-08db8c745b3a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:37.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1F38hVfbaFzQL1GtM/QmsW0VVlnhfEK6gaKmx4BDg0KpU7qoh8dENoIKCeMmH5QzR+T71oKTtNb7/Ipqb26aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: ipSFBzDmJuraftStDvliH6UAQ2D1VDKz
X-Proofpoint-GUID: ipSFBzDmJuraftStDvliH6UAQ2D1VDKz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_rebalance() is called to rebalance an insufficient node into a
single node or two sufficient nodes.  The preallocation estimate is
always too many in this case as the height of the tree will never grow
and there is no possibility to have a three way split in this case, so
revise the node allocation count.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0d7e30c7d999..494f884ef17f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3136,7 +3136,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, 1 + empty_count * 3);
+	mas_node_count(mas, empty_count * 2 - 1);
 	if (mas_is_err(mas))
 		return 0;
 
-- 
2.39.2

