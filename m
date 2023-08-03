Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854D76F0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjHCRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjHCRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:49:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613343A98
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:49:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgIYM022586;
        Thu, 3 Aug 2023 17:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XHBnjN0/NFoLDvAb7L9snVwlHr38urQskAM1IrfM7z4=;
 b=tuq55XjrHMDGziiEHDhSrdzBZjSHJP4XfemjtpNJbwFan/fyfwKgqDTwPp66PxQ55Zas
 tIMt0cxKlgmv2o2VBGV+JE5VMyYw2Dyucu64yLm4WT1qMAP3GrAW45LfUB9BZMPFaf3I
 W2HSWTvhK6u0TCwh5bLYaAJC+bfFwN+LV2X+j28mxyZiMZpejpmJAYZWbILvcebDc7rM
 qTZ3SqcF0siUnJ800IH7IrIlz48eQ9DODr/AkXfH0r8M5dA6ymFaZaYPCc6XQI+FxeCU
 pI1OtOhTkrqZWE9qPO5UWDB6PHi/w/xebvkMUhIHTtUMcZx6w0cqggRQsRtf1OxLGkWO Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2j84k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:48:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373GRQBp006711;
        Thu, 3 Aug 2023 17:48:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7g9tkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTwlBqaRX0h5LZWuzVwd1SLPtUbVUXC5BdgBN24veJQx7Be2HAE/3FN77g7/sJR59x8Ep9ZMvcQVbdmxJnJEHbQ+zPO72/gMWJUO5w3GccxVqgcrTn3dxrk2CNtfnytUiU1zOD1d0CbdVTrsuxglPfkjmopCIWOMMwLHquUxf5FGz0ySwDBUHu8EdKPhGrsXKNqTxElHzXSQ5SHw4CY3S8YwsP9cJJ6P3k54StXFs9We3OU1FoEyA0K2jRUvDCpPKwdi+miXScEIXUxET4Q6e3myawznhUjOgN4F3OS+ZrM8qfKUoEKn4gq4uQ6Gk7e8UYhnUcko+3IvLxPQFvxG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHBnjN0/NFoLDvAb7L9snVwlHr38urQskAM1IrfM7z4=;
 b=ZePaYAxlDL5KZ8BNLNtYTHtYq8cY2uX4Bd47VjSZ7bDa3g91vOf7C2IWdYsm5W9GjffSAcx9/varKbAiDXAQRHgI25ZuBEVNpao0ITwclfJd7Isl9BGdJWmd15X7CDL/SRccEuBVJTPLioG2FAQvZ5zlrUxBZ+qUHAT4TWFP3aASeZsjWIx8VWD9ztrmcgXb8FK+0ifiGK42/XgFoicPC3RzPhcg/JNh9bHvwyFNcxzMh7G2de+L6SKux3ioZMFUwbUocpFnDBlgcStlFal9FJFFnQSUrDbQ8gLBPUF8za7Tcuoz+CHGzxkNVkBxuyx2i5+hmEeJuGPMAcG/buIkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHBnjN0/NFoLDvAb7L9snVwlHr38urQskAM1IrfM7z4=;
 b=vBgSzCSyJsnGlozjUmpzSviX6WTmDqaAtCcMYHeuC4yga3RPqxNMQ5g/QRpI6MbjOHbBhFHE9Jt/vLY7NstpwnTS9KocYKvSJw12PWQ0XhE3ACj5zVOh3f2nNnFS492JR8m/zg4dnETyUgTIeUHMWs4m6ixmwu2soYSnfMqIirk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 17:48:30 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 17:48:30 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3] mm/filemap: change ->index to PAGE_SIZE for hugetlb pages
Date:   Thu,  3 Aug 2023 12:48:17 -0500
Message-ID: <20230803174817.320816-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:610:119::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdb3268-fd1e-4d63-a8eb-08db9449d987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xrc97e0foPEU8HJoGZaFUOi2ioItlZEDSFtwxtchMGBTHJrPU+wzz/5DGmhLaz35w2VtLtDru+5zZu9Sr4Q6BIrpodWKK+qUD9wSqNEEfLlB3epgocd2+UAVrnKjC3usjuvF0mniO8bkEHCK1+HvSVETDMJRfI1/xpwlo3tJgrEQDiOLOO3cfAW0zWnfYSKU2Hpj90wnfF2Daj2wvOdgX8ujaEVnVEJ3FnE5jD8Oolw9CKvDCBByL0V3UAKYlWKvtmpv4g4G2rdQvBErq5ibPTmdJ8edCxGKg+zSQxuhq16uIarHD8D3HbdgKstIFqiD98EmvjkE+fNjl6e8q21jJpj/Nt02FBmVwVj1qiPhhddUwOakYzgfq6gbqPxQAKdt8J/BaJ+hYMsm6UhcsIEypHz5YasOPNFU2LnnVvH2W8wO4MWyrE7MIL5tb/yP2dR7wiZh2tCp+oDX8EeTf0JmJyHCv08iX2vqXikc2pHsLyCYHV3pTJUTJ268aQrekYJ+7hwWygHHEDG06Hp0wvsew3i/d+GQ9L60kFW4Rf1S0E1k/SGvecUgAWeL1iMfOw3YblUXWEmtvKv4Xg9Ye1A7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(1076003)(2616005)(107886003)(83380400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(66556008)(30864003)(2906002)(4326008)(66946007)(5660300002)(316002)(66476007)(44832011)(6666004)(6486002)(966005)(6512007)(478600001)(38100700002)(86362001)(36756003)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6UOmdyNPwJGz4XfBKQ0WtJaS7YCXNRD2TJpbpPT7Tp0dI3cMYonFqKlLamaL?=
 =?us-ascii?Q?W8gpwxzYzl2StTyM120VxSIHFZnrrXcy9YtEgyW9LaklFii5rKWDh2ePeOF3?=
 =?us-ascii?Q?ob61BT4k51FeGVHCb3CfI3Or+5P9/4mIDTSkZKMSeiTkfAlz8CTi3ijPUplL?=
 =?us-ascii?Q?UA8MPQ109NZEZJv8HpX4/J2NiNKZnhTaQjZn/Qrk4xSF5VrBTvX2A1/cJtLz?=
 =?us-ascii?Q?3PL7YXxIFq0l+Q64HaDwlLS3/NgMO2pArjwbwOivIU05exVurFK+78iDsXEb?=
 =?us-ascii?Q?YIq3JJKque8eLlur5rcbZfaoImMsHyB4oliSRYKo0lQeHeS+yvan49vlXBtn?=
 =?us-ascii?Q?OGJrBc7VXwWMBO9FFpvOs/YBKRjDX8+pkO5cGPMthLDbjeBBJu5fo7lZtODz?=
 =?us-ascii?Q?acfNKrZuoAxPKz5NqDss49lZaK99FaovyNLFU3PhN6Z05xtDYJqwgTAhdAjY?=
 =?us-ascii?Q?EPeVdr+04Xw+lr467CqkynMljacZC+2ymZsf7IUc3rGuPW2hJh5Xasj06tTz?=
 =?us-ascii?Q?fjo4Q2oICZPi7LfWzK6SvZAk1me5kqOmlN1giJWGoaHY1E9pJzQBYHb9j5mX?=
 =?us-ascii?Q?bd/qOyOLjw1adNj+ITIizVZKX10Uyj8M+LVDSS8hR6kcseEQeqDl9WqcqqzO?=
 =?us-ascii?Q?pQjEDqLTK/YCDkHIw8ojLBDEsE3fiOPlL/mZBaP5OBQaUZJL4ToufiMkNm2O?=
 =?us-ascii?Q?T47ul/mmLSQJ/b8ynktxnC5jU4e0p4zt6UGRD1qP36YbgyiwJmRv0YhMleDZ?=
 =?us-ascii?Q?7rt/ETttG0AEKnJ5kvXc9wgMQ+XWG5IG2APNbEJJY7Dc3rGdE0cjUhmDPOHw?=
 =?us-ascii?Q?x5PeziSZTsVpZ1/vDFZ5TfaL+NRJ6ThZ5cC99rvwxBfYYKc+ObIWKDRC2AY7?=
 =?us-ascii?Q?Q8b7PCgbMViqZf3sD49yHrG/4CFHeI9QPw3wHFXJtfFOGTVLByw9bs+4h8DT?=
 =?us-ascii?Q?f+wtkCCDR9gPASy4ux+QmzBF04V77fG0I0+Lr6vXiD8hBDBEVTnGc9M8OVwt?=
 =?us-ascii?Q?koWcquX/TSsANK7QhXx7Xo9kyeJaFJ1fbxLo7HYlp31EecQtGZ5qp+nzrlg1?=
 =?us-ascii?Q?quaiFTY2aY2cdh/Th/CfkhF9jqZyraD6ZwyEfHpYfl45rKyRSi1sNesAuVjY?=
 =?us-ascii?Q?z0TtudsP2yrMHfomhEW21vi7/57KnzmD/22DvxaAOIaaxzU79PSRIE9Y/CVj?=
 =?us-ascii?Q?ajyllJWa4h7JhzYVBgi5J1Wa0Biy1m3vm7qhYlZD4noKutW2wObBw79SSUMh?=
 =?us-ascii?Q?xzPs5FlsmvSuY5WbuHp8ajqpIsecxqNC2J9+cMRV+78SzSzdeqGTM7TqaTQx?=
 =?us-ascii?Q?XY+CWqBXRmYtNAThSb2EQODGrOpdCWfUpz9/M9W4MKW5E22jjQAu2Hi+PG+D?=
 =?us-ascii?Q?6ZFjVmZqm8WHOkxMI8u2GmuUGkKe3fGwp9nH0NcAhxqGzxC70OnuqS52KHIK?=
 =?us-ascii?Q?RTQXCaHxe5TT+xM/jLiMbT/R8IgCyrqysKPmro/1Dx5VV9Rw+cAvBfLGwLc5?=
 =?us-ascii?Q?G73CEhHlUL8+sUL9c4f3sLRLcdoKeRwYuS/Uq5wcV3oJXV0UgBN2alWhobCD?=
 =?us-ascii?Q?DQMDTeYrcb5dDQqjruEPi2WYiQUBdcQtnoCTAEsnfRqCDZm8sTCxvGQsejlD?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LgktpazLo/4Z/lA4FGYtW5/XE8UBSom14tQXImwPOV7+iNZ9v17TxNwV/6s6bBWhfU7Fjf6B309966c1b4K5c0H7fsSefyhZg2lf+VrhlSB8fQudZ2jf0rhi3ElbSgE5MMlmlXivkH3C3Rq6FYupBvNPsIIO2GWKqQzqWCq/6fF99mIns4iQk2+C8M09nK+4YC/lSOQyja2teP8Ig346NWguevOeDXgGJDn3veQThpOsG0NuV7CCFQ8aPS2eVJfVmJldcIyuwkdOw/OEIimCNohkryOdd1HEq5Bm2jDO62++K0Zaea3zUis3xPlipuebsB0YWEayl+WRAmcy5XfhTnJuXnOJasPsCx9XHLf8hVeXpkGLIXEQMt3IosC74XhJ2dL8G3seE3EqlBZZktgnSH71/mSNEVGbrHuEbF9Ve/wU4YadUYpU3hgfzcTE2XTv3kJVKX4TDDTnwPzb/yiwNfAUtN49GWSh8BbFPJrTr03rUo8YBkrIK8xYKWCFwRbVdggTf0EBsfMk3mo0xY56OsnT4wId087rVOLJOVtVexFvF+GUPw5W+b2ZLkBTuWDAoo2c8mQMzhrbr73M0TgPw0eZvtijxm7TAcHz0KBT05cr/sVn9TOgb9xGKmhloobxC/Le5nlg8xUV2qbhkiMTlk4TrAbbVMV5eg7wqShADiwTftWmTcv7Ry3L8NFg8GLX9mXRYFTBYHtuZujjTNSunkkPKaCkXX2MadDFilsYLpx7fXwOpOFzggiPEAT9S4B6sk/Njt0r43I9miMzRP+LidVo46+fazeSMlPq9ENBy+ddDdMUDb+7SjtVzEjSc2zwHA2zKeUvKPAsAEkQPUM22y1wK0+UL+V9SRrWMdW7IvQc+bTA+6XHSE0JHklTIhXzvUdkULa/miWo9A5Bv3esIsJBCmBQdUF0B9KkMff2nNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdb3268-fd1e-4d63-a8eb-08db9449d987
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:48:30.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Np1TjkwHTVwkNUUdZ6M5msexlvZ+9wC5akbM2cufKXI/gK2iOe36IYiTwWIpWh0p0N/MwW8r9dOvOvGGMiOKxuMCkEfk/cNPdqaqwug6Wzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030160
X-Proofpoint-ORIG-GUID: iEwHLAIA0IxWDepKfrMIhxbd-h7BvQ3w
X-Proofpoint-GUID: iEwHLAIA0IxWDepKfrMIhxbd-h7BvQ3w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
New wrappers for hugetlb code are used to interact with the page cache
using a linear index.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---


RFC v2[1] -> v1[2]
	-change direction of series to maintain both huge and base page size index
	 rather than try to get rid of all references to a huge page sized index.

v1 -> v2[3]
	- squash seperate filemap and hugetlb changes into one patch to allow
	  for bisection per Matthew
	- get rid of page_to_index()
	- fix errors in hugetlb_fallocate() and remove_inode_hugepages()

v2 -> v3
	- gather performance data per Mike Kravetz
	- remove start variable in remove_inode_hugepages() per Mike Kravetz
	- remove hugetlb special case within folio_file_page()


========================= PERFORMANCE ======================================

Perf was used to check the performance differences after the patch. Overall
the performance is similar to mainline with a very small larger overhead that
occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
of the larger overhead that occurs in xa_load() and xa_store() as the
xarray is now using more entriese to store hugetlb folios in the page cache.

aarch64:
	workload - fallocate a 700GB file backed by huge pages 
	
	6.5-rc3 + this patch:
		2MB Page Size:
			--100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--95.04%--__pi_clear_page
                          |          
                          |--3.57%--clear_huge_page
                          |          |          
                          |          |--2.63%--rcu_all_qs
                          |          |          
                          |           --0.91%--__cond_resched
                          |          
                           --0.67%--__cond_resched
			0.17%     0.00%             0  fallocate  [kernel.vmlinux]       [k] hugetlb_add_to_page_cache
     			0.14%     0.10%            11  fallocate  [kernel.vmlinux]       [k] __filemap_add_folio
		
		1GB Page Size:
		        --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.79%--__pi_clear_page
                          |          
                          |--4.34%--clear_huge_page
                          |          |          
                          |          |--3.27%--rcu_all_qs
                          |          |          
                          |           --1.05%--__cond_resched
                          |          
                           --0.86%--__cond_resched
			 0.01%     0.01%             1  fallocate  [kernel.vmlinux]  [k] __filemap_add_folio
    			 0.01%     0.00%             0  fallocate  [kernel.vmlinux]  [k] hugetlb_add_to_page_cache

	6.5-rc3
		2MB Page Size:
		        --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.91%--__pi_clear_page
                          |          
                          |--4.11%--clear_huge_page
                          |          |          
                          |          |--3.00%--rcu_all_qs
                          |          |          
                          |           --1.10%--__cond_resched
                          |          
                           --0.59%--__cond_resched
			0.08%     0.01%             1  fallocate  [kernel.kallsyms]  [k] hugetlb_add_to_page_cache
     			0.05%     0.03%             3  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

		1GB Page Size:
		        --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.01%--__pi_clear_page
                          |          
                          |--5.11%--clear_huge_page
                          |          |          
                          |          |--3.89%--rcu_all_qs
                          |          |          
                          |           --1.20%--__cond_resched
                          |          
                           --0.88%--__cond_resched


x86
	workload - fallocate a 100GB file backed by huge pages 
	
	6.5-rc3 + this patch:
		2MB Page Size:
			hugetlbfs_fallocate
			|          
			--99.57%--clear_huge_page
				|          
				--98.47%--clear_page_erms
					|          
					--0.53%--asm_sysvec_apic_timer_interrupt
				
			0.04%     0.04%             1  fallocate  [kernel.kallsyms]     [k] xa_load
			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] hugetlb_add_to_page_cache
			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] __filemap_add_folio
			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] xas_store
		
		1GB Page Size:
		        --99.95%--__x64_sys_fallocate
                        vfs_fallocate
                          hugetlbfs_fallocate
                          clear_huge_page
                          	|          
                           	--98.84%--clear_page_erms

	6.5-rc3
		2MB Page Size:
		        --99.93%--__x64_sys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                           --99.38%--clear_huge_page
                                     |          
                                     |--98.40%--clear_page_erms
                                     |          
                                      --0.59%--__cond_resched
			0.03%     0.03%             1  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

		1GB Page Size:
		        --99.95%--__x64_sys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                           --99.90%--clear_huge_page
                                     |          
                                      --99.38%--clear_page_erms


========================= TESTING ======================================

This patch passes libhugetlbfs tests and LTP hugetlb tests

********** TEST SUMMARY                                                                                                                                                                                                                    
*                      2M                                                                                                                                                                                                                  
*                      32-bit 64-bit                                                                                                                                                                                                       
*     Total testcases:   110    113                                                                                                                                                                                                        
*             Skipped:     0      0                                                                                                                                                                                                        
*                PASS:   107    113                                                                                                                                                                                                        
*                FAIL:     0      0                                                                                                                                                                                                        
*    Killed by signal:     3      0                                                                                                                                                                                                        
*   Bad configuration:     0      0                                                                                                                                                                                                        
*       Expected FAIL:     0      0                                                                                                                                                                                                        
*     Unexpected PASS:     0      0                                                                                                                                                                                                        
*    Test not present:     0      0                                                                                                                                                                                                        
* Strange test result:     0      0                                                                                                                                                                                                        
**********

###############################################################                                                                                                                                                                                                                                                                                                                                                                                                           
    Done executing testcases.                                                                                                                                                                                                      
    LTP Version:  20220527-178-g2761a81c4                                                                                                                                                                                          
###############################################################


rebased on mm-unstable 08/02/23


[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/

 fs/hugetlbfs/inode.c    | 15 ++++++++-------
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 29 ++---------------------------
 mm/filemap.c            | 36 +++++++++++-------------------------
 mm/hugetlb.c            | 11 ++++++-----
 5 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e7611ae1e6120..ec0f856a1228c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -661,21 +661,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
-	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
+	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,7 +692,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(inode,
+				lstart >> huge_page_shift(h),
+				LONG_MAX, freed);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
@@ -741,7 +742,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
 		return;
 
@@ -886,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		folio = filemap_get_folio(mapping, index);
+		folio = filemap_get_folio(mapping, index << huge_page_order(h));
 		if (!IS_ERR(folio)) {
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0a393bc02f25b..1bb3fcacdcddf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -811,6 +811,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+}
+
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1005,6 +1011,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 69b99b61ed72c..319cbf5a87767 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,9 +721,6 @@ static inline pgoff_t folio_next_index(struct folio *folio)
  */
 static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return &folio->page;
 	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
 }
 
@@ -739,9 +736,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -799,10 +793,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
 }
 
 /*
- * Get index of the page within radix-tree (but not for hugetlb pages).
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
-static inline pgoff_t page_to_index(struct page *page)
+static inline pgoff_t page_to_pgoff(struct page *page)
 {
 	struct page *head;
 
@@ -817,19 +810,6 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
-/*
- * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
- */
-static inline pgoff_t page_to_pgoff(struct page *page)
-{
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
-	return page_to_index(page);
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
@@ -866,12 +846,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
@@ -882,8 +859,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 8040545954bc4..12f51e1b0f4d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2038,7 +2036,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2102,7 +2100,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2143,9 +2141,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2171,7 +2166,7 @@ EXPORT_SYMBOL(filemap_get_folios);
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+	if (!folio_test_large(folio))
 		return false;
 	if (index >= max)
 		return false;
@@ -2221,9 +2216,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2240,10 +2232,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio_next_index(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2281,9 +2270,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e327a5a7602cb..3b4d17a19a025 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -952,7 +952,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -5750,7 +5750,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5767,6 +5767,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5874,7 +5875,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6183,7 +6184,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6315,7 +6316,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.41.0

