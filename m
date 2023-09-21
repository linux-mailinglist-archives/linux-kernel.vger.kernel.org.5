Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519287AA131
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjIUU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjIUU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59825A4A91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:13:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI5A6g026386;
        Thu, 21 Sep 2023 18:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ubzRy/J3CaNQKXWbZ+x7hIiS+95zrwHNV/oKW0YUlk8=;
 b=gyGWKrA2/vyM5fgvdoEqjiNvhg+DetHN2N7nB5ArF3lzxWvZ8hnZrVBfJIvMA2r2d5A6
 8wRU2PoJvDwCBpzVPhW4hneyTheEzTtI+6RVoWK8JovbQeVmcxQPNa7kQqspxLIuh/IK
 KRA8DI1gW4qGl4vCvVexEZYqd1Q47Tjg1cpJ8SuJb4r+xCieNpQhq2NvmgdGINLkRH3w
 q1gxYOiz7btwhqt99i15FvIh418hBVJUFvJ1yWcBkrwQryG9u7qXEXGJgOSq186/YGmw
 fYoyfhHSjQpw4jNhcSoAiNDf0RzCJVqLetVRXTVF7bUedcTVDxULoJIa/Xv9uqLdxM2S yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvr0fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:13:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LHPC14030875;
        Thu, 21 Sep 2023 18:13:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t8yn2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su8Gq2j5kPaJeq4p9/d4YLyKlCAIpSKvlDxlWR/ZO9TCVdSZjWmjlYV2VIJVXXv/2O8vbM5hRO89DlOhL6ygIcKqN+mOqCxO/ny31aIMWJamndieoznzgnprjOaLxN/PCiNsCiZVRKg4xJzg5FU9BPzfENgP4ZTjFrCoatCj/bihd5LVQSLnEpTS7HY9+WVFp4V++R6uKuGYIJRWNADQBDKZAqEA2x1f5cCSVpd94k/fyiJJg52ybaEcCc4Nul/Neqp+g1lQ+12xd39LHS3XbSS6gsOHkuNmSKyTFHccsz5hIyUjQjCbmpvLd1EwxpDzg463KepaMd4xHrae/fsIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubzRy/J3CaNQKXWbZ+x7hIiS+95zrwHNV/oKW0YUlk8=;
 b=I8MsdwSZTFlyTGGTnUBcGTXeEuMrFLoka9CNQrWXuZS/wf5bPbU6a6lO5Yf8G0Pc9l3Fd74G04TWja2cJKMPnrO9dc66vTou+FRQt21gEonIPu88QXywho99ZU901bawpJUBhjuxwdQhqUWgqXVtiOw5AD18GsHR/Cks0ImYrG9RhopTzVB2/nTBFlX+rHXsalvV+YykrV4SBktXu6h30Xc3XbbaCZpQA0fA3rUZKOMk/B2KcViIKWZiBT0oIdLF9CQzRE4q599xI0gKZ98GxHWs2LXvKto2JbVKtwq9FLjA9rkMkHGYuMchhdSb0+cZRcXNCxzp58MgYjvcs14svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubzRy/J3CaNQKXWbZ+x7hIiS+95zrwHNV/oKW0YUlk8=;
 b=KL24VmrvIFDjsld/3zYPta7nUghNqwzp3G4CK/HvFX9d+yAkirQ6r43uM7gmauUuUEDC0qyLuD5yDznL7duMRDqi1g2YZj5Dnwit6kyLBqUTg7o6LPuFB1pJwF4PgcRgrvtA3gYaNJ3++74aMuERMc8mkVxBoc5qUI0qnJ2ztHU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5158.namprd10.prod.outlook.com (2603:10b6:408:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 18:12:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 18:12:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/2] maple_tree: Add mas_active() to detect in-tree walks
Date:   Thu, 21 Sep 2023 14:12:35 -0400
Message-Id: <20230921181236.509072-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921181236.509072-1-Liam.Howlett@oracle.com>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0470.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9a95ce-acab-435d-aaa0-08dbbace60fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGJukz2vzpqgfI4Z3P9kKMEoSipUZQ3fx+EGgl15rmYaY1beRaPpS/wtojDquNturz7P34kF3ksLDQKOwYJ0W1NAvcGOVoJ7I3U4Nitkca8391QsxFizu8fNa6Ro9Dx3FiaIbQMBGQgXhfjCcx6BRcjoHwjHcqSyc6abp0p2dsGeL7T1vx30kpNc/N2gCr9hU2eIL7PWGo/InlrZH3SBvdfT74GEU3NQQTcDqmt9320aSwQ9F0Bzm+0lTLK204Y+uM5jUOUpTqS7VeYx4ROGdGkOkUMJK5GnoIDHrbEVXulDweGA/3ZwryrcqSWNkVLRyWYHfC1feclfzpU+6frKVSJ32d2qH37qzyrY9DLDwQzRoHAqZTlRrQEjfdgb3I4bSvBdx/08d1jglNhtqXf1NoHwBtGhKD02P9YHzpe19QxhIvtGiCI3lQHe8y6Wvuwm5lnQY+q+EyknI6N2EQY7TswhGfk55h/Jf8T7Is0IoU7RZJmn6VKp9UdYMGxewiMppmBWzBwit4lYjy3cUwGBzGo+GpkEshSK7ux56Apq9OWXU0HEUa7YLfXDaX63ROT2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(5660300002)(4744005)(2906002)(4326008)(41300700001)(38100700002)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(6916009)(54906003)(86362001)(36756003)(26005)(6512007)(2616005)(1076003)(107886003)(6486002)(6506007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZkQZuRBJfnQxTDunhrskpmGyKTa5r8epY51W+Fk2Q+BXVO/35XbCdJ9s6cU?=
 =?us-ascii?Q?cnar3PsvXb/C1ms6OuaYVfXfD/ss00bq95cC7mFGTiXudCdrZilb0z2aH/Bv?=
 =?us-ascii?Q?YY82Ao5Soy77s5BdFELDvGxIcWrjNlEU3VCCrqz1xzazAW4nDgav4DK1ZFoT?=
 =?us-ascii?Q?SXokfo8qqoVjQnrkps/flL1oGgqPO9V72L4UlKvq1Xi7iUrAAsSc0w65czGj?=
 =?us-ascii?Q?hFsGVnly2r5Nm3Ai2cpggJqVpvJD4KNrmd9KvXFy4DO/rtPB+bLRcqg7uyws?=
 =?us-ascii?Q?zov0nDiiUe1DT3xI+8EyvO561xuBOOzY2/EZq/rHxMnehqx5wQA3AEq3HVrJ?=
 =?us-ascii?Q?TMbvkvnuM31wJUeXlDVLxXBxaM+tphaG95+QQOkHEiKQK4SESsZFB/J7Kixb?=
 =?us-ascii?Q?83osk9xH16QL3ECZmrG1+QEGiN3n6Io6Lh/+678vSXW4cpIvlQb5/5dgI3Je?=
 =?us-ascii?Q?iwJzUqaY9ARM9XQ7jxhndc1m2pd6ymGhqFVjvXo32iU58lQf+enjqPynwJu2?=
 =?us-ascii?Q?Q8hJZeSO4xh5SsBn3fKrg0tZ6YBfVw6Fl09ogfWgDDdtGEq9V93TO1bhBQBR?=
 =?us-ascii?Q?hsMk/rWKBUEWbf5+xgGrymq+UTj84bfbFmHXE3Rdr1u996nJBQk8qN+58hUK?=
 =?us-ascii?Q?wyIERz+eOYoexmxICv2EwQW5XGKqly86DbK9NSNX1MJdl5rULPIOe/Ujdxnm?=
 =?us-ascii?Q?yIu6Zu3C7l4/W+dcACbYEPW6XFqVUwH738SkRcdhuyGpeEFPxzQ9kBPY7/6c?=
 =?us-ascii?Q?Z/HNPZrsaxXVXvWQanQvdBHTtgpO+YIBPavlRERBk7dd909sniBYDjdPf9z5?=
 =?us-ascii?Q?VX5YNjBddikX7gMHfVhTitibgNIhViMeAjNNgRejBwEHu8gSXtAQAKZqvbgO?=
 =?us-ascii?Q?1uFPN9m2Fnuvs750xRrlkOI3KGRFG/o2yKfyfwxG6pAtxTI88qsJ7ZYb5psh?=
 =?us-ascii?Q?M4k/+UnTm1QFKrSjxJZozbUsB1mM84NCTctmEM+iRoLvpTTGOZm3w+vfZogY?=
 =?us-ascii?Q?837tioGm+BeQk5xiX4uZYoGZYdClu1xj9d9I88dxq9x4G/2NBy93pOcHc9/l?=
 =?us-ascii?Q?paTZRUh8rZ7Xxei2IVVaFH+sa3nvgtKymkQbIzE0fsR4uZK/sR7foE1UgL4L?=
 =?us-ascii?Q?B4Eb6dLRO9K0eEKlTxvDVPSSrR8k2rVB91gjOmfxg5lQupOvGXMJ3d7RzsW6?=
 =?us-ascii?Q?ylaPWQq845fSCh7uS8G3JxvdRUz1UOAFrlefjKCD12OkHMFWb3aZR3c2drO6?=
 =?us-ascii?Q?ll3tloPxJjLqBrIwUqDaSyFa6eWDA8ZBWkvqVx5OCSppzrcYGONEPpWGQCfz?=
 =?us-ascii?Q?VNMEgwGan6IMspk6KfhFNboNWI5b8ZY+nzy7WWGBUEl/6HXGunRYGP4DcML/?=
 =?us-ascii?Q?K2ENWLteHMtwm2JWoZfFmXgPWxSP++//3alK7ELfZbz7I3f7MQ7ZIZpKWXvV?=
 =?us-ascii?Q?O5bW1AIQP+wyMycRer9XAT4num+rOCCNFUJjnqtgxt1QQnPGK0oqe+i9Pkf7?=
 =?us-ascii?Q?iR+T6Z2vUyz2SbCu87kOoVjwG4eHvFlTa5AK66k+YjffkTdyJiE4yLiYkGQM?=
 =?us-ascii?Q?Ca3M9L1RLOh8tWCOI0KokrnPXgZwJ0g315o094sY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fRvotbjRxKbF/IqdIY+oAvnCMcvogOD29eYAEY43QPCGv96s/cpH2I7OIIDy?=
 =?us-ascii?Q?wMwZhIDR0IYAON2ti3KiO80iTwDBr8svuf3xcQkhudI96DhLYU9Jg3gRBvhJ?=
 =?us-ascii?Q?Ba/m6vx6SstL6Jy55NMJq2eP6vXkYNh4YTfhss/1O0PK6meB4tJMhuSQpVfw?=
 =?us-ascii?Q?ChERIU2fQBtXsuQ4yrtIxEXcwjMhPDY9kCQ7CAwAJF+Qn0bZWN2aZLEVl6Sk?=
 =?us-ascii?Q?0vNNKsE11PQ0x0gw+xuojOKGRp6pAlcjOUQFn+0SN6XiVSWjEbHJxCcj5/g8?=
 =?us-ascii?Q?xwzq+MJXC+kEZRjlAy33+ZJVgs0aGUfB8LAQ8ZT0J4PHLcEBu3G/KbMaic2+?=
 =?us-ascii?Q?3/8BAH4TI88rU4qd8vhQ9U3yaj5tXY+0VULyNsSK4NyGWuTnXiIRaaeoxPtF?=
 =?us-ascii?Q?sx06yWozo6dUex80h1d/XpeyD+hHJwkatje4/1lrFdZt2Hu+wOC0WdbcUIP8?=
 =?us-ascii?Q?XORjQ095q8IBGxLnYze2nFLoQxcFmiB0SGH5zHgi2gKSOS2xgs1RPfGL/RkD?=
 =?us-ascii?Q?/795x2ID1joTc+x06/Mf//FHuag2HEx4cdvv0b/+Zp+8nu0yWEafitUEZZq7?=
 =?us-ascii?Q?p87IQsqeUuVlgIq9rcqYxaiTnj33lHIo4sqoBR9cNUAgnKtALfO97AOhHtQ4?=
 =?us-ascii?Q?i8tMpTpCbNSRAclJTP5VAzuXwVHp6pj44y7JdNesrKlLjvT5sQEh1nGES99k?=
 =?us-ascii?Q?me7EZ0jnywbbHJ55T/XpsmnsMIBtcKinesuWPuAG4+e44f9FWlbabHN9ChHq?=
 =?us-ascii?Q?vzTigpIUYr8L2L6UgfIMLXe0OIfbfTjjUt/DocYW4Vv254Pf54teI1EJDXJm?=
 =?us-ascii?Q?1Wz/nnCitdGbxkGlCsW3+RiigBLqAYUYbiHcNIy1diG7vMrZrUp/jEMPWit8?=
 =?us-ascii?Q?JVuqKy1ZI3qxzZmY6bzDcxW/Vg1XncvEjTww5qjj8oX6LlNGeZa9q6w2per8?=
 =?us-ascii?Q?RozQsKV2unUG3PethN0DmA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9a95ce-acab-435d-aaa0-08dbbace60fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 18:12:55.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0mEROA9BaJTiq/VPsXpT7xUXyYOUVgS24LQWHhAnIVLsk/dyXhU6BafemN/N0HJtpvBs5U+2eK2G9gYJeJIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210159
X-Proofpoint-GUID: dsaAO_h3ftXn_8rN_OxIy7MNzk5YF3h7
X-Proofpoint-ORIG-GUID: dsaAO_h3ftXn_8rN_OxIy7MNzk5YF3h7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of constantly checking each possibility of the maple state,
create a fast path that will skip over checking unlikely states.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e41c70ac7744..f66f5f78f8cf 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -511,6 +511,15 @@ static inline bool mas_is_paused(const struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
+/* Check if the mas is pointing to a node or not */
+static inline bool mas_is_active(struct ma_state *mas)
+{
+	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
+		return true;
+
+	return false;
+}
+
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.
-- 
2.39.2

