Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3427BEB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbjJIURY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378583AbjJIURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:17:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A7B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:17:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EY145015043;
        Mon, 9 Oct 2023 20:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=c+C0Up3JY+XTwnKP8pH7ffh6BG1JcU/dITRtObHkDu0=;
 b=gy3PqR8wjIndqAAVNeKvYlIShVC+/TXJZx0MNNWfkCwwBq0s/o8mtZAiNm4IMFa5Z/+n
 S3tolo1FeGNcZYtPol/dD/uykPf/28QcPGieFbXF4woF8z+mXKsCsON6+bWpfXHmaxGA
 qpQ2XmUG+JSZTEayqAHMWBqyMdK5v1NuVKnribzuQTCQGLmhiSjNaTsw9WJbUAANsmBW
 Yk2Sd7bXc9kclwPctP3BtNwBJbwB2WwdswsUkdnMC8doeuqqlNp0K36MrvuVahoAqgwK
 h2JSoCHVOlRs3ow/+GEHu55NSBX4KVc5Z/gt3bKqWul8ZUmA1Co1l1aIrNV26XuO7Hda /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43kmbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399JSjFK032134;
        Mon, 9 Oct 2023 20:16:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhntnct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ20xaangTy70mbcjiTZh1/AQKCsuqmYSI/5u05zPv4cCu4R1oecbqvlJhTzeErcHkuOYASiVgz2GYxRpSYTulheJd0Nmmn6KQbTbSUxB2padLchBE7bkVFIcQHPLkCLQ9QS7YuJWO+UFocS8HEpWDuUgTJS4c5JlhBf51NIHh3HGaoey+mwlCYJEUPYeSNdhy4VTILCz8cvvKZ8+/ORhggpj3wh6orLgUmbsADKlPESFmyhMXVYGv2bTtYIqL6mdKy06ZynfauL8MPLJERQd926XwKh1IjqNxgPczeB/gxZB6NMDO1Cf/vGEB+/1BIglPMc/vgYn098imHtHs4nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+C0Up3JY+XTwnKP8pH7ffh6BG1JcU/dITRtObHkDu0=;
 b=gG0A03gpQkYRdNi5huZUMNnTk5DjpWGvGOcJru+Mz7A4AEU9oU6aIHpth5v33qctja2H9FgztCzPTMMRMfLZhdX9JghwdvdMYYwoFofGP2p1fSVsLVYjWrSN2NTOl3d55NfpYl2Hl0448ybS6+8PJu6lLW5qFwWHQp++zLh9A5jixerJ7i/VU8AJ28C2dCt3NqBRotfDTKCLkIf/kbMhwtEmHuC0NacsB9wg8GxP8+1Hedys/6jnU9haY3SYSDPvmHITPMLARqrZGf9qB/PCjXRbPf01t2CwzLLgjFGbcwp0bRiproLJFp7vxdWxmz8gWS7Fcfnqbo5VLU35jRayew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+C0Up3JY+XTwnKP8pH7ffh6BG1JcU/dITRtObHkDu0=;
 b=AJCvqtSzGnyFHKGo7PH/V3zUFK92Pv0dU0cpYczWZVcjMK23mXoOwM6ZyIewAMT5vifdOrBL8f4Xu6nrjR/t5uOoR6HpJQG718Uy2O2CMZ5MyIjmcY903JGaZ9NSllPYxhI242PGULB602D1IO8Dqxj3aqBjkBhe5Fbi9zvquoE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 20:16:54 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:16:53 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 3/3] maple_tree: use preallocations in mas_erase()
Date:   Mon,  9 Oct 2023 13:16:39 -0700
Message-ID: <20231009201639.920512-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e6d612-5a5c-4264-76b3-08dbc904addc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+RlPVqi1jEuRy3ZepAhh9ppxhvo5PMPd+eSkXnluWEszbinVfQTyEHLk7NILYQRRmKrUrOElEa7ic/JH5zm4u4tzEC4yiet1kJyf7b1oKtIOZ9z/OeKkZVEH3UNfZ9DQ8pSkXAZALi4KJQP+f1DSpNKydrqXMqauw+tUwGXEQ1u3poUjlT93Od2TF+Y23ba1Rs5GIdoASUlm/966A7mp279M/lUr7WD0n21vhfATpiLP9sjmDBO3wmVlaAyeVhNGYr99N5vf3LduGKhUKxr8Tft2FhbIGSiapSigFXwAncdc5j7wUoNvkn/yfcYY79VSKfiAkgZBweKiwkZPaMVOVmHI/eJm1NjGq80n+Rom55yQpxoRgU4/CcpgUjG1feEGFrqByNFT5HLaGydlwEzlPwESQGP9fhD/UztSrFexG4Wxk55UFoKsqqlF3muOGkZ4mblhRiW5sa4czIx+29Rh5i7YhTKVwWyq46P2P0bXIP6xV5mGmp1r0/b94cPY4fiubIDL7KJc6juKNrH2a2rdipAE5Xpe480WAPPT+4KbnoskzbL9KplD18bZlwAGHAx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(36756003)(6486002)(6512007)(2906002)(6666004)(478600001)(8936002)(44832011)(5660300002)(41300700001)(8676002)(6506007)(4326008)(107886003)(83380400001)(2616005)(1076003)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSjvAf+CIWgA8DemDlwA/mFCght6eH2I9oQ7FU8p/xSgEzerehr6cZRXwn/l?=
 =?us-ascii?Q?kQ4RbV1g7DVh0pykVXiPq+n4ZaWJgwllBosc8qVs4m+DNamJhJCW+PwR/4G6?=
 =?us-ascii?Q?v7lW7DUhhq+jpRkhGZO+eENqiyuBpEoGvIh1vUeh5lOSj25A3hJL8bYmLOun?=
 =?us-ascii?Q?UUEwR1xG9oFkgylQePTazT+BlYCQjermlUw8Q8XeptkqgGsVUgHx5JZsQk1u?=
 =?us-ascii?Q?7h74q6hkcJiA0RrExwggoclYFg72Qtsabbpq6058GGgLUFn4SoAED3R1ZoS6?=
 =?us-ascii?Q?MoPiiHCoxYvswuEuxsWkr4mvKseyPHXSO8aLSjKc+b2s8TT9elS1XKBgIt7O?=
 =?us-ascii?Q?awTIXSDHI3mwgp2hw4FlOXF6yXq7pXJiY48qfBhF0O5j3YlyhxMFWQnOasSM?=
 =?us-ascii?Q?jwLdM6257QDpaWJ2907c1wz04B+LggGpAYsTR9nTkQO6O3myZqKPSOmn9xXQ?=
 =?us-ascii?Q?ZOuU5TQjiYOSA11Sm5MPIexuXZnz2T7b/fM1bTbfkBf6DwjyE5M9eFGFUH5W?=
 =?us-ascii?Q?QYJm8VtBv3a1JHu4NXISTOQdWHenixr+7sUrJ9GRNQ4SbU6W89yPit4pq5UW?=
 =?us-ascii?Q?NuCzdq+F8XG1RxrnV8BqkEWaDygZZ3uMbaF2maCm8nOUwAcKh7oOiQUBHmT9?=
 =?us-ascii?Q?54iZw0X6Ch6bIJQyUmQ/wxSNLOz6l2h2MpU/9u4L40F4wodZsgVTt5RF90Ol?=
 =?us-ascii?Q?x9O2auHBA1Y338CWdcSFkuT2lR7l8ASh/PRUfRyllc6GjZvnyADnke0YjXCS?=
 =?us-ascii?Q?hqX6Y/c0HJvpd0Irrz5m0P/zAgZbDe0qnCFmSRb9NS8obu0rYLGzslSSdV6z?=
 =?us-ascii?Q?tg4A2jHDyHfoQ++TUsHT6mmH9ojbp60MidhG08ufNyBFpto0lGyqY1qWoIDB?=
 =?us-ascii?Q?SR0lxXyh8XTbotAVK70JtIeCjDaMX1689RDG72WsqN05oDlYOryLH8a+e99m?=
 =?us-ascii?Q?WvyJk/+IJAfIZHPVvU8oMvKpC1XqZxkEcphyTkDEcTZnGjvqQNieY+c/ZDAx?=
 =?us-ascii?Q?wyHONLXWzceeI/0vtIih7qlZH38kGDcIfyHS0r6bju8du3QUbpiHjivDxmzy?=
 =?us-ascii?Q?9OxIuzPLZUH/lOn9/7fwNlo9c6PgbbsxfS6R9jRe8vzJL//r2M0Z2SDbjzLk?=
 =?us-ascii?Q?x0e9sF6SVVxIL8PlDbTSqaBfec38gRNrFQ7SFnHrvPB+Uci2WVJI2oy2RLtN?=
 =?us-ascii?Q?WPVY0O+AGICrataaPg5LP9MIHuErQMy4Lq/aeo8SrRVw9BSox/bT7nM0x2W8?=
 =?us-ascii?Q?134JxAPC3ktFF3r4voVx7UrqEesTcCrOt9wz/xkjw9cXaMUZuu451IuPnN9J?=
 =?us-ascii?Q?QJobAYmhvuQNpsWl6+dfLM9SkK4C5yF+pclVZ/H5fbUQgu6u3AHkcxJGdkaF?=
 =?us-ascii?Q?+m8PTU01Pk0U0mtfhidaQgOkreP0Wb7qE7Tk/jzNgQg6ICAucEA9RwRc/hfg?=
 =?us-ascii?Q?W6Ls/xtIraUY7NvHMwpwk+aZxyy2yIQc2odcwiYA9le43WCf7QGW2klmEQzq?=
 =?us-ascii?Q?n9E5zhjaotVnL4ZZhJnJsENPETDky8zO0OyoELUNrFBbTIpUgX8NrjDqveRh?=
 =?us-ascii?Q?S7xVWZ8FudcOivX0zZ3CH7W3gFVY1bSLXvSpOfDdRG2Bp+C9d6fQAwerOLDZ?=
 =?us-ascii?Q?5TVY9XCoPLW6KIujT2ltjHk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kfLGb6VfCgJKE8qxLNaEEB20ukqbwo/ReP+ZYktsXpC7L6dh8AKdohm5nxfL?=
 =?us-ascii?Q?fr7E9A7btNPqe2cZeQfM3Ce7o7XCpxfzyM+r90Qwe/fOVNJU1q1HxHiZpmxl?=
 =?us-ascii?Q?iILKPiD/uWTMsE71DuQsRG+dIf0fAVSLpIR8fI79U4JB8WaLD0sknaS6mZIR?=
 =?us-ascii?Q?/rg4ZaZG3C5VXBVlXZKqcbfrsP/2n9oFED7OJDaHrhHd9+BzjWKX6Cl4wStp?=
 =?us-ascii?Q?OkN/naFbvmUuTkLJh+xXLhINp1LlijYQKfQvVUFxOx/q7YbH/6apbntxs+dL?=
 =?us-ascii?Q?pjAaxBEjLv9zwkVof37ejiLXP+Z1tT4aqq+JaCV4nQDpMJK25wTiqf/5Cyhb?=
 =?us-ascii?Q?e2NCyRrUlTuC2izPfZ2iesPKJWUzLLei20jL9d3FurTutZe/+rbNV4c5nDeB?=
 =?us-ascii?Q?nopl4NStyK3HA4gFRh6WXUVhn4uzkLI4GiFZ7KIjsIFCVkJdfZOk8c+ssv3b?=
 =?us-ascii?Q?cMIqSca7SWOmeyFH6QDNq4VS/jEkn/ab0D1XBWbCG0TKkNC6ZOiTe1WAF5VJ?=
 =?us-ascii?Q?M0FF0+Qo8vlgfVzt9BwiAX+13Fu7wcFzVH6Yr79e6E4MH5aEm8CIkmvTjB3R?=
 =?us-ascii?Q?ikPvnBCK7eGpmiu+yEZlB2TyrB5kp9P69u5Ll1GEfAaFLhhFoAe1iqjVSCr9?=
 =?us-ascii?Q?p4ZpAJqIiDLZx3FhCtccMEFFogFkPXD8FaSNZ6oJM2DwryJ3VY1fP2wQEDaK?=
 =?us-ascii?Q?khQ9SElNP+baQ6491riXL2AH5ntVLaGiHnh5CziMBohBGW3MD7WRvvHPjbv1?=
 =?us-ascii?Q?TBSHlAP7GDIn/cAsDAfcioxV1MVZzvhk+a0aWCLFOX+j8UEG9rbYwjFL2Epc?=
 =?us-ascii?Q?KYrY4OWdHPYWVRRYjSWTmKZonR9nT9JNxTYwh3LnvjeAmhwDIasOutvFnf5K?=
 =?us-ascii?Q?d7C16JO68sc8/JW/VwuqSok2Dyb9dng8wr2FxM3dsK4HMu1xx1vpHm8sBxWp?=
 =?us-ascii?Q?acO52FYBH8Qsxaf9XPYu6w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e6d612-5a5c-4264-76b3-08dbc904addc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:16:53.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1JtZZZtG0JFgD4pGvgnZFE/b1YzHok5mDx0hU5wfX+btbwt8XLg6Zi3/dbdQAgOurrsXsFYfZSjFYMsPAIoE/52HuGZFnEohy5CDHB7uOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_18,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090163
X-Proofpoint-ORIG-GUID: eCv_LeMYKs0QFhuROODa5p2IY5Xdj5O2
X-Proofpoint-GUID: eCv_LeMYKs0QFhuROODa5p2IY5Xdj5O2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preallocate the number of needed nodes before mas_wr_store_entry().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 25ae66e585f4..ef8d4b6b4456 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6191,6 +6191,7 @@ void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
 	MA_WR_STATE(wr_mas, mas, NULL);
+	int request;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
@@ -6200,14 +6201,30 @@ void *mas_erase(struct ma_state *mas)
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
 	mas_wr_store_setup(&wr_mas);
+	wr_mas.content = mas_start(mas);
+
+	request = mas_prealloc_calc(&wr_mas);
+	if (!request)
+		goto store_entry;
+
+	mas_node_count_gfp(mas, request, GFP_KERNEL);
+	if (unlikely(mas_is_err(mas))) {
+		mas_set_alloc_req(mas, 0);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return NULL;
+	}
+	mas->mas_flags |= MA_STATE_PREALLOC;
+
+store_entry:
 	mas_wr_store_entry(&wr_mas);
 	if (mas_nomem(mas, GFP_KERNEL))
-		goto write_retry;
+		goto store_entry;
 
+	trace_ma_write(__func__, mas, 0, entry);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
-- 
2.41.0

