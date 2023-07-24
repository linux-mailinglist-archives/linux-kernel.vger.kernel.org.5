Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77675FF25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGXSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjGXSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5191BF5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:33:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOIV8005716;
        Mon, 24 Jul 2023 18:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WdM8co3kDOxUJgEOeWvcgW/1d6ZlELG+fKQAf/n1M8E=;
 b=UBV0DR8av+8JzHoJzqxLqeSDdo38JZKIT83esAipiJ7Zh6Fzgi1EqwMSHEPCMwfE+tvU
 jJk9a+r59at8QLmcp1IIhp+0l+mXGfPyuYEDHifYrUfR1ixtfCKPwI0I2dhll/zOcwAg
 eTjmyM4j0jO75+SzsNHVDOQ1Chb+6JOvGCGP7LfXs8xDOrMIxeOggm/KxvCYwKS+VsVF
 ei3rKcS+BMG/jYfWS1AGeLiAxI3rV7rbKr7P5pR4cWbvJrejvaRcT4fbAgG0t7N0VWVu
 GxV6xOoL7O7/JgL2foQFGPYKgpjDCycocnhnzdI6/bZzCtCqK0Mem0xNd2USgPjKozR7 ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c3fv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OIIoM6035409;
        Mon, 24 Jul 2023 18:32:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3t3wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCK8waiuRmfzqeTPJSoVOXXE+A81wBqXfqOytqkuMh28Har1kMvILG/1cTFa3EY4CuXGP1P+Y0WF8PnEIs9RF9j8e8JI6bNwfX2+TSUMX4VlWYv1cDXZ3Lf4kk3uLZYQTT6idk+eGFTIBBbgDd6tM/H/T/YCxGrtlPMRNa4SdLVYDV/68tVazCSPa0QbWr8hoXYu+noIYuNCu/yQLHk/0w0VOdaQIjNxQ1ySeOitwqA1OwIkb2Pl3k6uhg2RJrKMkxH5RZ4uc7XzBztSFq5oV/tFnhKqiaV7ap48o6Ji64gDPXjnM+YCpnwzXr0qxD4cyaKa1eD41ZtC6SASFBeaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdM8co3kDOxUJgEOeWvcgW/1d6ZlELG+fKQAf/n1M8E=;
 b=dv5/3JNOP/SYlw/gPf/uNBiJUQsva29AC7J3sI7+sghxZncqjFxbDtO32a6K57oyIDa7ZWalQrojz/eMHlgMsvS9eL9F2CVCnB7FEfHFE7xSTUYYIF/Ka8JpsqpFxldmEr3HitiBc/1kJmzxSQjkcr657J01NnQmsIozezs6agTOYeHx3IuRtGXJqcAHMc0Y9fW+oE35p0OhFJeCQr2SAO18RKz510felJHU/qg4BzU0KVkWj7BCuUFDSyqydSOmfyb94+iU5TNHI1rCmQhRXujUc1su1KlqXSqSCCpL7hBOd5pJaGUO7YAEQRA2L8Hw4DRi7P9ehizgiS7S+pOE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdM8co3kDOxUJgEOeWvcgW/1d6ZlELG+fKQAf/n1M8E=;
 b=ZqLzMq1dfhD2qO1IkWgAiKLN8lIQTyO8rKACEKIzzOQyKSgmQAVUSACFqMUfhxxYGI5D87c0z3ozoI5ZWoyY4eMFgds7ADZF2nRS7tD0BirXkv+Q6/0z14fR3SV17OJYvSkOLXsx7OgyV1E43l3C67CKYZwdVuLZQbb2LQO0dNs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 13/15] maple_tree: Refine mas_preallocate() node calculations
Date:   Mon, 24 Jul 2023 14:31:55 -0400
Message-Id: <20230724183157.3939892-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c48392-5c3f-4534-96ca-08db8c7461a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOZlbmEVVsGlK+qBMaBmgtBbq25UYGuBrb93aAckhlQpaHyxb0PEMG8OaT0eiYBnLx+UMnW3si2r2uNhyp7/IXri7Jpa2vOtlqsrNZ0+SZoEDx74qpK2enCjRn5G5Eooi0u2MZTqxZ5b9Y2xEhde1BQPWNSGHe9XUrsde6aW28bfTBts0NvWbuw0pNZnv6w0JKj0+OepuL+12WQjOfJN9J0/j+TJbP3ML+wQ1gCKy3jPu2orevdDCDfZ/4oAIiEQUhHJ0YmoV7zlY2+OIJOP5M2TuCPyC2VnvWJS/D/dMMOOGAkspkh8TzSW44XmCke3jxX/qE2+W8+OZF3+PsUTMZ7YC9zIaFX9R519STc1DPjK+f43Tx3FY5SINc1dXxnqZD3HzqHNlgI/0HVuV+HT0jmevRFCEDh78grkn8KfrwxrHHJ9kAls/XIAi6Ff/FwdlI/FbzCJUA4UyxLysgV8jwlomRy8375ZspxCRhsEUGc/ykGq733Bu2AugwTqb3Me/N/tz5D2K6+g9d3l0HGJIoJE/jnbnt1+2ACBAvybJALMgMXStMm/ERU2GsifB+8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T90gBg4639CFy8dOg565EdLbt4QJdPYxDmJM6b14IpurJ2VHej9TE1qkgUk7?=
 =?us-ascii?Q?OrDQselZ5SjbTWKekLbU50zSL2qc8soZ3FTdTgGX1W0PxhZjxiFtfqljKC8n?=
 =?us-ascii?Q?gQqwgvbxuPPame3IRLdHRPG2ClWgU7negzSMys9kxZ+77KTFe2EX0Rpd6mNU?=
 =?us-ascii?Q?SGNka8fGEtSx+JZyFwBhqOZcI74SlwKebQoQghUxB7yRIziAPH2LtPBK3fKT?=
 =?us-ascii?Q?dyS6L2ca5Z2YRCcFX4JN+QQHiprOzSnQ2QQ4SpXMMVMtftEpUy8Qdg0BoFl7?=
 =?us-ascii?Q?ZJpLBd4ZKgnICEI2lKoe7thV8tUCB9LgI0J0fhCoHJ4U9/CLYs3ld5JhnKvz?=
 =?us-ascii?Q?clb0SF9Mlqbz5kTahz3diSw6uBAgGiaYITaTuUAEFFXhwujGMg488o4yhf15?=
 =?us-ascii?Q?R7oGe7IB8cTpNA2aYF6/+YJiR7dK2NOnTRmJvoX4VPMmRkiFjL/UwA+32MsX?=
 =?us-ascii?Q?d4XF5NI7XpR9hgmmfRLcRt3/DbRSzgv8M9CPbyg6rFRKsduNrfrClK/Ls6pp?=
 =?us-ascii?Q?SzMpxwsl+SPzu4zHS268EUtYGN4j9f/Gq/6Xtn8vTyLlHtSdw+vXd+ENfQDx?=
 =?us-ascii?Q?NN+U9XshGWaXkeVhYi7PE8DBN/chjogeE8Ke5hB6EhLcu0Ussua6qEWk71cO?=
 =?us-ascii?Q?zGDrNqDuXRet6HkFwfn1Br0OIYSnT9GKtHftWzIP7V57PFUGq0UCzD9mJ8D6?=
 =?us-ascii?Q?7zA756BmLytwb6R+APXrK4FC3BEytmOMkefqvOlijrQk42XJflan6Tu8blm9?=
 =?us-ascii?Q?+QPnAbB7CzVCGe4as8THOHENsn2VXIgmR0zDX9P0lpsyi9Dqs5UJ1RWyK7i7?=
 =?us-ascii?Q?Bi1u7U48doSY5Cfq2Apl3FNhLvnyYqdW/KurBGDIOJ90MJ0GL/g3GFFMSYx2?=
 =?us-ascii?Q?czWIhIvCh0LFVODyK/fMm3WMXNIu47EE8/yFWYKIee0yX5p5rIJwNpD44uPe?=
 =?us-ascii?Q?nHJ4+SPZ4Tkl4oPnt45yOLpldeIdG7XoXKGuqCXgAxzlAuUFHNP6d1YlawMz?=
 =?us-ascii?Q?4P7tFNWtpEKo4zQMVfuPI4Btpr2YqQ9g6ZlkTDKARSsfAT1fLa9d4MV92Jvm?=
 =?us-ascii?Q?ynJvI4GRSR2w15boqQ/0qViqq4lm4KA0a2pHGNDcEabexDFMwyU9S56Ec6Vg?=
 =?us-ascii?Q?HfjnL+ZQ0QwKCk+KMOrblMdoT6EFmKV45bWs0luo4E9+yFRjirZj50etCn/9?=
 =?us-ascii?Q?ST8RmaM1TyOqpd1FxP7hXX0lR0eb6DtzZP4Qkebeybqheqi8zOBddVNMp+Kl?=
 =?us-ascii?Q?8mF+4yZluXegiYSHfEvSsrT05YYM12eEGAGbKMDWjzG0sN3J0mdEYakx4YGw?=
 =?us-ascii?Q?dw9R9ZuSEqeSorOhMgaR+IqVKJQm2Z80VBdyCzCs6//2Vm8LkO2fxEJ/6iI/?=
 =?us-ascii?Q?kkVjUV1FtGzKuKmSUMvyEXTo5K4xmuYJigXuN2wbV2u2Cf6GALIDaDrIuXlj?=
 =?us-ascii?Q?4asXVsNXxS+sUzAcfHvSmzuH+l2GgJNOAHaBAl4tyPZ0yuRlk5dO+SqtDAOX?=
 =?us-ascii?Q?UaxB34II8TKBi4RWuzG/ukxBv3hLXEa6Hi5L1LZbXELoGDoEMZLJXwLtJX5L?=
 =?us-ascii?Q?mcvWgW+FetqpRFBVfnqmccwKwbFBuQCGp/mqc+cKQP887RwH5zuFSYTs+85Q?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBaiUyY7DyuI50smHmVmkd+1njtyvSdkvyU/rbqO0Yv0YYa4aavOboekteKXgRnb+cT7e1Da0v//5vSr+e7Tj2qEXMEWZJmO6BT5ye/DgR/ckD0wnpyWXja8z7uBfapTPLI3wEWOtS7En8Z4EoleUlfpgX7P30NXNXAK2rBvIR70XJmxpelvzmhfXJ/DxwIIJ0j3IPlpMZ2kXI+1WCKYrftDg0asAZW/mdNRm0dUiOTAPjMdjSo+PQ6nzB5+P4XyIkwI9m9LJ0NKvqEexhKYa5n8eSRhQEVsrXxBw/JJERD05ZjTv6MzN+b7es5cLaQqyy6KPPVyaZDqOjH4xROFaO+dOS5kFgsIeKIz4PuEl4idqYZt2KGFWnPP4H6tGhL+xc+yDoZnPfJPCIe5M3lbtVoQYd/P0BXp5PLVh8izJQBIXFMCc/cgU4BewtcpOGkXtfxrF9EwdHcDweY2KhE5U5Mex3CLVNK2lqcPwn7d4D78npK5VVRiRu7VhgxmF9+lNVf5hsipyxhN9elzTUs+D9pV2szkTur8+UgDgH0DF2FrXUyBkVs2Jj/BZxuQmWVYt4QyeZNYZp+tIvJARjNyoj4r1LWI7JveA5VX31zdTeSUey1kC/c3KCAlDcqfilLCHrHLuSOvnFh+2T+60QYJ/jKXxPn8GjwEUoxuA+9b93L/RDR7I3avWYfl7kQDYwR9SDVaEUeSM+vTORhiXpaMvSGZDexoIS7TskM0e36hXr0wNFwtKRKggopSvITNL5HZ5bQu4/Yg4AQBE4YjC/pHZUEdGudgZRgZRklza7KLc6SyFbXAxbLnFeLKISsOT01kRVg9FzIu1TynU0fOblb8k7NdQWzKaLzxtKnOS+Zmm4TlwN+8lyaF+dj26zqVfyUrtXeU5EDAJA+H162X2YSMxOmk0nnH+phJTi+sFVPGkUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c48392-5c3f-4534-96ca-08db8c7461a5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:48.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Odkz+ZAw2fnZIWuEYO1U5ivq1xuW1tSx3oWCtE0pmaCx0V0Cg13H2kIP4ceP8kPKkbkcZ9cTm5lF3W9xB1DgXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: q5ki6t7Cy2K0A7iGgJZ1e6mhapWSMt34
X-Proofpoint-GUID: q5ki6t7Cy2K0A7iGgJZ1e6mhapWSMt34
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the number of nodes based on the pending write action instead
of assuming the worst case.

This addresses a performance regression introduced in platforms that
have longer allocation timing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index db61cdd8a649..4a111785360f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5535,9 +5535,51 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
+	MA_WR_STATE(wr_mas, mas, entry);
+	unsigned char node_size;
+	int request = 1;
 	int ret;
 
-	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
+		goto ask_now;
+
+	mas_wr_store_setup(&wr_mas);
+	wr_mas.content = mas_start(mas);
+	/* Root expand */
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
+		goto ask_now;
+
+	if (unlikely(!mas_wr_walk(&wr_mas))) {
+		/* Spanning store, use worst case for now */
+		request = 1 + mas_mt_height(mas) * 3;
+		goto ask_now;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	/* Exact fit, no nodes needed. */
+	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
+		return 0;
+
+	mas_wr_end_piv(&wr_mas);
+	node_size = mas_wr_new_end(&wr_mas);
+	if (node_size >= mt_slots[wr_mas.type]) {
+		/* Split, worst case for now. */
+		request = 1 + mas_mt_height(mas) * 2;
+		goto ask_now;
+	}
+
+	/* New root needs a singe node */
+	if (unlikely(mte_is_root(mas->node)))
+		goto ask_now;
+
+	/* Potential spanning rebalance collapsing a node, use worst-case */
+	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
+		request = mas_mt_height(mas) * 2 - 1;
+
+	/* node store, slot store needs one node */
+ask_now:
+	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
 		return 0;
-- 
2.39.2

