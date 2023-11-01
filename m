Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209F67DE530
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKARRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344695AbjKARQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:16:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3597AFD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYiEF004982;
        Wed, 1 Nov 2023 17:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ktpTDecE9FlsB63AOPLwZ5bzAUL9RNQcS2o96pSyoYQ=;
 b=NwSo2f6AxF6YGSIDMM7DRZfh+nE3ekwdBrK878F6QrJNtS6Z7MfAA1LTl9KuEgGpVa5F
 aPmnkuFJHYbPZaf4K0u6AwlkbWQtCIOx7qgkPYwrHTSVFHos0133lR2rCXapcS2DW0B3
 d2qj42i47mNQoY+ZD4V+IcMTOSmp/ifvT/K3nGL5zcqKwVthX/KXkJS/9nQIHV6OOVw2
 DX/dCF/+dAuV03IjuMCYQJ+ZwtbBtBctEcDV7s2MRpfUhfb7c8CkhGmkf+7PlUILbujV
 Y6J0ie8wB86i1D73usf1irPsgB1bMp6YRrFsvtPANo74uix6lSV/DbVe6TjdYvve+SK/ AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuufuec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Fkqbi020283;
        Wed, 1 Nov 2023 17:16:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7d2he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTSmxZ1wezIDuQMC4YJOmia8ibsmjoVhf1flU/C4WKEYnGn6M2NJhYr9sb3XzgbsSJ0UarKjT36xpE4AT6FI93ktgYjXFA7O1NQqKVafwq5/oZlNydR31LKKFeRycl0U5cx6HCPUDAYHZ2vermAEKfFVWREeoOIwWHdV2YRCAc/EqnqbPaDdSZfy/M6RLbxFnpPvchdAb4mlKCw+nMptUvtwK+db0603+vbwQljls9Jul2BzPdCZ/TXoPuUIoaR6AiLe3c/MVkWbCWcfOOINCPVJblJ2QvRSnLqazTvRvtU4jP6/aYWciTy6oGeYrHZSmwf8TZqdG6VAysC4BUCL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktpTDecE9FlsB63AOPLwZ5bzAUL9RNQcS2o96pSyoYQ=;
 b=cbS4bvU/CvQfpM41uH0d/mrWf/KCVxDsGyMIvpklDj5UXlAs7le7txJxY8Smme0alt+gPwhuWqRURceDjKAwfuWxdCHG+s403+QFZer/6FJCw3KWhhkriZBUMgijjQNjSg673rUet8TFZXI4AOgmMGRXXGeBWxizSzSUu6yVY9lLkntzWdX2qW8FluHbCIeUo8DQevyekKox/F5jeyJ1l67rrHzURrbzxP5KeXq3epg+S7eX+lgDpD2sGNx7VBCxSg6hLVDQG1QK4ABe8YIaR/Rcy3zTAhnutUfr7IToDLFY4x3Z3a/gRfNs0AXXk0GLGn7tZkWxnFH26mXW5V4ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpTDecE9FlsB63AOPLwZ5bzAUL9RNQcS2o96pSyoYQ=;
 b=tWgUJ8USGKikxg5C0v4OjzwGdraTwbD0WRBSKoydV5IILcwfzDnZuJwdgfAY3G7LafHPAJaRkXc/qb76CzF5hVB/MRu9NqVcF7HqkC4NTfkHKIR/Q7IfOQGvBpTqgpsVkru8nf6tOK/wpWBGTAnUhv3+kLGAPAvGeut4wfmpT6s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:41 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 03/12] maple_tree: Move debug check to __mas_set_range()
Date:   Wed,  1 Nov 2023 13:16:20 -0400
Message-Id: <20231101171629.3612299-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:408:94::39) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cc36ce-a02b-474d-14f1-08dbdafe5102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXEZamgLMUhvIjV8YO5Qf/U4Kq4f78SXE/gmA767sdPskoyOyRmGWrgsDyCdPw75YAh+EO2yA6tUiUc9HM3BRxzzfuyXK5RHk0kliXgq8B2hwd6/P69R5MdlDzdU3MnaITlg2yfFYb/P+z0ioLG+LiGcZAqq/riIa3BOJosT4R7S46defUNKVsFsvpzPIrvg1e0FrIvqrj5GI6F8AWRx3NaeEGKU0QCS5oJ7mc48Abm/dgNIj3kxmZos5c9sez1amaUQIIERdcLzE4c09aRjiCDY1nObFUiY9Dowisfet5bCV5Z1svUDCu/CjNP+cbWlaRV1ken0gT7Jw/YBhHTsTsmkW81D1qxKuH+L1tUdpoJrSOorSm7qs+e2DMO9wDud2LW+y3e0DFmlIfwUgrNfEQ53SJsk+2OTeJPlRfHnPEkwSNQ2oGQVKZCxhLa7F4mXO27vlPzOWP1DBYVox2PL0AtiyZxEM8kI5PtU66UMYTHIUoGlm/W5hO0aeW05g6eaZ1Uz5UdY6PT8puwIXMbVSQzQ2lMhXWVsOWciX58JjO3HZgJ25ZVtW788AN3Tq623
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(30864003)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quMaYY/SpaQ6kUGMCKOc++jKHJoM64r3opYjjFHP3wmPj95yejkuMbJMNPlD?=
 =?us-ascii?Q?KVKHurGEI9pS9EXlkYsQSoGJTER96f3yEEHXl6Mp6+czNMZNjyvTLz+RshHC?=
 =?us-ascii?Q?hCgmdhtq0kqmHE4TSAlbn7vG17DUsG+eleQhE00MtZHQA3Wj64Ddu2VmCZ19?=
 =?us-ascii?Q?S2dPmadXtpjCPnEfLLUJOpb0dShIEw8qg5XuYaW15Y4nfsqFk/0CZIgpekMk?=
 =?us-ascii?Q?3TdDbjF6wJl/ljustRhOiLNnkaZw/eS6nsA5/9KnegT0TtMm7HW931Ev6pLU?=
 =?us-ascii?Q?tWtOQFl9U5qqqqOeOqyVmQyQf659btY84SqVymY9f1gV0l+zREwxz1fDD7Zm?=
 =?us-ascii?Q?OFVxvdZ2zwr0LKU+SXu0yfFjAZoaCygjH9Oz1xhZTTkP1yWThjogbZtxsn62?=
 =?us-ascii?Q?k5+1BJbnqzJoijE6rJnjSeMC77vF3q3ktAmxOeyOlZdsnyodMvLjaLkwJDnw?=
 =?us-ascii?Q?ngpFVbGAOaEM9K9ninWK9aU9IUTiXXhi8ZgqG2O883x+EvKFjlQzsyGg4+z3?=
 =?us-ascii?Q?XWVu9t/gP4FBeA6WAB87k4BQ5l/huoXCMqDF2mSlDaq44RoDzVjOVGg+2KUt?=
 =?us-ascii?Q?wxDhel+5NvmMW2kOD1v6hPdaHpuE4ekdzLAyEKw0AJQ5oSYu9ZC3vOcov+O/?=
 =?us-ascii?Q?TToaIjRZzykLU97uLXVlFho01vVVYpUQ7TQbSceJkDKtsIq+2reY9PUBbUM4?=
 =?us-ascii?Q?pk+ssEDsjVjYl/ZCxLDOAP9eCscfyf9gskVn/ROJmF0SpUYWycspq62Xm4VS?=
 =?us-ascii?Q?JGWRhTkVCI99d9mFVp2ANNYUHGPQPIrw4SaN052iIi+FxMoxx71GMt0ljH6p?=
 =?us-ascii?Q?8JtrXrGyHNB+DBGYvHj+XAWGuMT4hiKPxzHfELS164GEPD2qMZhvopoSDupY?=
 =?us-ascii?Q?nNrA8NQ+FN7mv+aYgfKsdf6+093yOsjzG7EXScnZ7L+Wf1jdUhG0b36Mplc5?=
 =?us-ascii?Q?XZxf2ln+qP8lZY09pmtv3uMgHj9nXdDb4RuiIQxcfZz3DloDQcZJ3+Box9K8?=
 =?us-ascii?Q?O+NfhLVh5qlL96QodhJ7PXL10GZiHiufEaca4xGz0dvdZ4nyKQBuCNzuZSBu?=
 =?us-ascii?Q?/8uQEJgIksJ/mzKuYfF+7rRtnNlmPalG1/HEEXQQY7i4TKFhB5NaR46xWhex?=
 =?us-ascii?Q?Quonpa8A69Z+EAsqj6q2GZptihynEn/7A6GEK9HYFEmysP2y8cTWPSmEdxPC?=
 =?us-ascii?Q?eu6CT91bfs4DTo6fuq/Blbb7kwBM7HHHyFMF32cyJHX8s/Ml1DG1yjpYsdFX?=
 =?us-ascii?Q?2pJnxxng/sPDPYc8nV1dMV2sukjyMzNn6VeZSEEWcxdRDQ6YxWDLdRhO5Qm5?=
 =?us-ascii?Q?/gxWiVXglHxmkg3vypMMIdjkZLMTNsxwCMQ/PYh2TNknsjhDv9Em+RfEE4co?=
 =?us-ascii?Q?v39+6siTvXNQ2IUMByX7rGxAIZGLNIDyHfd8b+1AxmKui4RBLGQOlmGKfoDA?=
 =?us-ascii?Q?E0EbxGOgle8DSWpwrYftj6F4eDgug8DtInY/6RTPuYjPuQI5zt5dEbm0/snX?=
 =?us-ascii?Q?ObQy2Im840tTR4ZGNuKTc+NQeF5TXMyCVU7jOB9ZFfJhwlKFAA604uhyzkLW?=
 =?us-ascii?Q?fQQ3szE3Dsv2glnQR66o/rUBitSCw3Dgw4ojbh5L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HSxT9SXtsWteXFqsbZOmuL7Mwjg1EWxbwXxDpum84BEe//piVq5k9rEQeNr38FjFdcTckZInBWYw2/GzoDtpmbIcQNC3fxrglaCmpRd5lZdaUEJBo5UjRQTCPulFDvNSI7Qn+u75e1fwoyp8MlUD304tR403kXtKX3LWct/CvyA8SocMii49itGGqZdg8J2hEeZGKt4i1YXoa3Kv6mgJI4GHhd+v7eYxqzZE1zaQd6dy33zjMeAW6+Mim+c88XqtmNVsgEP0f6TshXeQO2MSHsdOqYuSFOp3hT1d/GHZwF3DnuErK25nUZ+os4MAfBWnd9WXVmK+y9Q6DC18HD8UZYGWqlx/gTKZN7+rzFYDCuGpNWbPnL6zzN8g3UDl9G0+auQ1YVr2CaJE4FmVA/1hLXNBScCM1Soor56ez1YJ6FAf8LR4TswzGaxZ8oh9Ajyxc3daSgR/+CmwcUHHD3kNyOeImm/eYolSorcdNT5TScMmo3df8dciSl0jPVeiQ9nliw7F7zu1zFdOgy6zs9i6d92Qo25hXHNP/oIMzISthFiu/mHrsoLQYqaiQNUzorbZbuSycx6/lhWCe4uRXbDVSUH+VSIe7aEUaoDwPO5b+NHk5W6fJ1k/4IbWsJmVh+Q87O8j9ICcJ5qSzpCYCvQWQJWfsjWfi6JZlh+GEv+NI3mJvLLE/VBMifkR0wRfntRMmERRYJA8biHTrZ5+sd+ZHiJq7qtuky/3F/Si8y05WqqP39tLPbC9RfXzyOOiVPAr/hY9f+IzPnsnyO4bdWvJI5zZ6xmc8RKSqqDnEqaAhMMoi6/QcOKT8I9ptOPt1+KxhxvoqHZkCT/oPEcQ3Zwiskw3jbYRRMquP9yvvf0gWy08CgC124BsV6v7i2CjhRsqaGm6HOc43AIoGgSfSaQR3Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cc36ce-a02b-474d-14f1-08dbdafe5102
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:41.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiHvr5U6cHN3f3Iu+13P5lDFA2v+EDTpqCwWXQfAyydPxFzmEyuZlp8sDd+/Ut5WZsvJAuehzYIUHwhddL8Gwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: 0pb6tihkiWLkoY-370fgnTK9Do1fCDoh
X-Proofpoint-ORIG-GUID: 0pb6tihkiWLkoY-370fgnTK9Do1fCDoh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__mas_set_range() was created to shortcut resetting the maple state and
a debug check was added to the caller (the vma iterator) to ensure the
internal maple state remains safe to use.  Move the debug check from the
vma iterator into the maple tree itself so other users do not
incorrectly use the advanced maple state modification.

Fallout from this change include a large amount of debug setup needed to
be moved to earlier in the header, and the maple_tree.h radix-tree test
code needed to move the inclusion of the header to after the atomic
define.  None of those changes have functional changes.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h                  | 255 ++++++++++----------
 mm/internal.h                               |   2 -
 tools/testing/radix-tree/linux/maple_tree.h |   2 +-
 3 files changed, 130 insertions(+), 129 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index d01e850b570f..82a6bf5fa969 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -550,6 +550,131 @@ static inline void mas_reset(struct ma_state *mas)
  */
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+enum mt_dump_format {
+	mt_dump_dec,
+	mt_dump_hex,
+};
+
+extern atomic_t maple_tree_tests_run;
+extern atomic_t maple_tree_tests_passed;
+
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
+void mas_dump(const struct ma_state *mas);
+void mas_wr_dump(const struct ma_wr_state *wr_mas);
+void mt_validate(struct maple_tree *mt);
+void mt_cache_shrink(void);
+#define MT_BUG_ON(__tree, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_BUG_ON(__mas, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MT_WARN_ON(__tree, __x)  ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WARN_ON(__mas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+#else
+#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
+#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
+#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
+#endif /* CONFIG_DEBUG_MAPLE_TREE */
+
 /**
  * __mas_set_range() - Set up Maple Tree operation state to a sub-range of the
  * current location.
@@ -563,6 +688,9 @@ static inline void mas_reset(struct ma_state *mas)
 static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
 		unsigned long last)
 {
+	/* Ensure the range starts within the current slot */
+	MAS_WARN_ON(mas, mas_is_active(mas) &&
+		   (mas->index > start || mas->last < start));
 	mas->index = start;
 	mas->last = last;
 }
@@ -580,8 +708,8 @@ static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	__mas_set_range(mas, start, last);
 	mas->node = MAS_START;
+	__mas_set_range(mas, start, last);
 }
 
 /**
@@ -706,129 +834,4 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max);
 	for (__entry = mt_find(__tree, &(__index), __max); \
 		__entry; __entry = mt_find_after(__tree, &(__index), __max))
 
-
-#ifdef CONFIG_DEBUG_MAPLE_TREE
-enum mt_dump_format {
-	mt_dump_dec,
-	mt_dump_hex,
-};
-
-extern atomic_t maple_tree_tests_run;
-extern atomic_t maple_tree_tests_passed;
-
-void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
-void mas_dump(const struct ma_state *mas);
-void mas_wr_dump(const struct ma_wr_state *wr_mas);
-void mt_validate(struct maple_tree *mt);
-void mt_cache_shrink(void);
-#define MT_BUG_ON(__tree, __x) do {					\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (__x) {							\
-		pr_info("BUG at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mt_dump(__tree, mt_dump_hex);				\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-} while (0)
-
-#define MAS_BUG_ON(__mas, __x) do {					\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (__x) {							\
-		pr_info("BUG at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mas_dump(__mas);					\
-		mt_dump((__mas)->tree, mt_dump_hex);			\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-} while (0)
-
-#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (__x) {							\
-		pr_info("BUG at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mas_wr_dump(__wrmas);					\
-		mas_dump((__wrmas)->mas);				\
-		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-} while (0)
-
-#define MT_WARN_ON(__tree, __x)  ({					\
-	int ret = !!(__x);						\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mt_dump(__tree, mt_dump_hex);				\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-	unlikely(ret);							\
-})
-
-#define MAS_WARN_ON(__mas, __x) ({					\
-	int ret = !!(__x);						\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mas_dump(__mas);					\
-		mt_dump((__mas)->tree, mt_dump_hex);			\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-	unlikely(ret);							\
-})
-
-#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
-	int ret = !!(__x);						\
-	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mas_wr_dump(__wrmas);					\
-		mas_dump((__wrmas)->mas);				\
-		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
-		pr_info("Pass: %u Run:%u\n",				\
-			atomic_read(&maple_tree_tests_passed),		\
-			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
-	}								\
-	unlikely(ret);							\
-})
-#else
-#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
-#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
-#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
-#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
-#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
-#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
-#endif /* CONFIG_DEBUG_MAPLE_TREE */
-
 #endif /*_LINUX_MAPLE_TREE_H */
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..812ba03224f8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1063,8 +1063,6 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {
-	MAS_BUG_ON(&vmi->mas, vmi->mas.node != MAS_START &&
-		   (vmi->mas.index > index || vmi->mas.last < index));
 	__mas_set_range(&vmi->mas, index, last - 1);
 }
 
diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/radix-tree/linux/maple_tree.h
index 7d8d1f445b89..06c89bdcc515 100644
--- a/tools/testing/radix-tree/linux/maple_tree.h
+++ b/tools/testing/radix-tree/linux/maple_tree.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 #define atomic_t int32_t
-#include "../../../../include/linux/maple_tree.h"
 #define atomic_inc(x) uatomic_inc(x)
 #define atomic_read(x) uatomic_read(x)
 #define atomic_set(x, y) do {} while (0)
 #define U8_MAX UCHAR_MAX
+#include "../../../../include/linux/maple_tree.h"
-- 
2.40.1

