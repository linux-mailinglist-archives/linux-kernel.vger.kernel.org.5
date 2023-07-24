Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18775FF23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGXSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGXSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33F172B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOGRE028670;
        Mon, 24 Jul 2023 18:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XTH/dSWqwNjH4V3zbDCxHYHLl7PeV/roFStvPqIuINA=;
 b=mGRP/rp997NFO8nlavv1oYKmssAGpqQlNmcS+ezZoN0DqTb999lPAJQLKsrqPaeKEyGc
 mrhfBYgj8sJh3w+T804K3zRbWu+PffIgOxk5uEHNyfZNEWjqfYMwRSOHNir9GZUImKNE
 +ZarHahl8hm2mdA/oVa6lQjJeHcUjDhmpNEXUFT6dcKBUICLEVS5Cvi6+mQJVfVr04sN
 X43Q3eMuM3kMRjoJpwz1ICYDW0sgjdE7WDUKFm4VK43lZXLXVFegigelNwonQUzbgWra
 q+mvEa7u5+CUqtJL5JDqWjLETP8ArJyAVya3O00PMVK4oNOKDqXRkoUM8dMHP3rShWXm YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1ufbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OHEhX8040858;
        Mon, 24 Jul 2023 18:32:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4a08j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SboFzxV+epUWIEt/Ho47QObjn22pA5iDwOPeMcFYwkQZ3Rq8gfz9bOljfzBr3ys1E9UZGYzWMOU1YAJqI35mkvJ/9cZx4UY7RdwFC9RoV76wpVglSkZ+wdajeYr6Jonnx4ZLw5MQeygTFkrJTLsp0JYKXtsqqIux5FrG/vogv7Hmii+IOc/FoukFHxUA1l7XlCPWUCXjxiZgwTcOSoGtHcXwOazAyzTXI29h1F9wOEtihFB/1cON8DYOkV+GqtvxXliigiBLQiesA60kLjwEcFcppTswvRKP4z3uG6y2Q3W+qiS335Mrt7eV8O0/DYgbx1gVQ6nhnwA14OVRIIdn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTH/dSWqwNjH4V3zbDCxHYHLl7PeV/roFStvPqIuINA=;
 b=j/8bkZhFuOlmTbpX+3q+GmkoiZ1JXgG3Y+QyoAw3+U+S6aZnDfhzIMIntx1HckfLvvDnL1AUif2Avfc3Vkve0H4J/4Ar8XNpTaWo25ldqHT7e4DHc96S7IE+KhjW8u0am0yOzf+2ndXSEdYAKzPeYQ+TtpA/dNtAHmYiC0KNGSBUEaUAVLBB2v2sztzEc+eL8TNci/ZLK2n7BbnMrJXaC4KX5otROcAx5ihARNcunBzbxSpwJf48d5OFWidsgrmEwkMPHKFADtFjAIcELcQo28Xwi+Tf1OjHs0TpYO1TGHw7J1QQ+bctOQPaGcGi8WqP1ra6qn0gYukc5LUnzAZbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTH/dSWqwNjH4V3zbDCxHYHLl7PeV/roFStvPqIuINA=;
 b=qoaK64/aqannxSA84jucbfOuQISl13d5O6dDXDzMKrV9IOEGN6mh2CVW/ycJpFYBNc+uqb8YOJJExWLlHxNF+Ew0KkU9T+NiBLAQF4IHTHo4qDy+tfUkAaFK4tqb0MhRivd+tvUk00S60Cx3BISWSZY0a+geF9mvCO+wQsORWdQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 11/15] maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
Date:   Mon, 24 Jul 2023 14:31:53 -0400
Message-Id: <20230724183157.3939892-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: afa2eff4-bc7c-44ce-88a2-08db8c745ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uo0McTK7Hzt9UlF8gcG6FJZsckT4cZg6/OVjkwq5jcWfmxHAluOPk8llk1pnY/pSspRBrQ3odNk11h9GqNbksx4QP9DH8RPcchRH2ztT4edkIaKE4wP5UEPiwcmFUdocfqvQeL+A4Dg6kxxWU8XZMcl/K03rBbCbPvdQn69fXJdZvrvOzgaoe+Snu4s0NW+jH9Sg4bCpfhaJGQObW2pNHaJgozuFIVKXyrv2DOrI3Qu7LCcYp6HR1JIuN/QyJsjz7MEFs+nnAA3XPxoHV0fEDLrq4u+mB+XsSLjvD4RNZSbYNbn0/6+Q18qQ/TieSCKDVcxYk1qA7lc1qIBY4HuJQrwpNmojRy7Y9bmtfou0pCrUcdF8LnJJrCvjpzw3qB5DZXiWafuNy+9ySR5Zo5r/0IuBOzxw2PruvGDIYjep1V97PPCfq7Ud1iBRxVM+Klda3pq0V+WbA4/TyqPoOo2fWKvULYtKbqfW9sXaWwTqOXHSh4u0jjdYBn9ZIVqkFHakxo/TENZHeG13NXm/TMcDP0Q9ei7I+ISjNFIuRxJcmWobXkc6IkEDVVN4mG/nNTmv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ggfVmLqor91hHu/w8VQWz/zQX8lvn552rBaH5tl0TxudDapN2uWgHhVLioxY?=
 =?us-ascii?Q?kBRDbWSdEgT+ysC53aYTbfA7FVsXBJQGXt1ghBzfL2xmVZJmx4Y77F1/Ck0e?=
 =?us-ascii?Q?hgPUtjW+kPQO5jhXzLQAE8zvfDDqQoNXSt7EihvwCGRpaQ8uSmiN5F36h9jX?=
 =?us-ascii?Q?6U/mvMkW8wl1oM/jrFiaXGsH1qt3hKm/RQN3DpceC9mRN6LpqJAiiQ+Sq1gz?=
 =?us-ascii?Q?OKSkn4nZGXjNQRAXvQnrNLdZQ9Fz01x+dcawYX4AGTUCsIKrO3LFVzabP+Q6?=
 =?us-ascii?Q?IiXV4Hg2j+/tfaP+MD94EiBIfo9BV7EQhGM8f7BvOukb8iAI6e1Ff0pzjvfj?=
 =?us-ascii?Q?1+5JzgHFgZDQH/levF7ZSHJZSi/5bFa/ScBfyJ6sKzktSssS0/+fspMXMzQv?=
 =?us-ascii?Q?tyCDhDa/LIcAn9eN368ty+kHXPhYXOOX2lsRMk6Q60TXuDYW0AupjR/Nd74F?=
 =?us-ascii?Q?FjWw0tgCM7VkUL1qCfO8eSPP+4c181KgR1Pq3Z2nyQjhKRtMMnWpxwXb3KYe?=
 =?us-ascii?Q?y1SfBXpFMfa7L/eS6kt2FKC0eXZyTEWq/l8mjppJb6wdTdggn8rPtRzwGjfG?=
 =?us-ascii?Q?Q2A2K7FkppYyOOx05k0sok5Qg5hRmRHq7mB/So8crDIpfAkAoQcKeWnZl4om?=
 =?us-ascii?Q?9lyQ50WM2odaHqS61DihFkXXRDP6Q+rGUIghZdSimnIbb6i8WFHgKr95j8hy?=
 =?us-ascii?Q?mGBl3RgHIr7oR+hHKisT3+MN+jWvYqB2K5puemarKgJsrx52mjqrv1sfnfve?=
 =?us-ascii?Q?OaKtNkYYSTbu5N2ZHhJLJsQZzVuCUsXuIV/FLOkD8yDFrapyGPfqHT7f4SsT?=
 =?us-ascii?Q?g4LNjNId0+vUF7V/WMkV264uS+PDMGTVSQKYG9Ascp8v2Xzn4Pr1OnxXvIyd?=
 =?us-ascii?Q?dmykVdGqaAyoVur79HDW/XZr7qxh13uaU9++ciaDoDmCbRz7msZct+yD+odk?=
 =?us-ascii?Q?gcZQvhXIBEcAGXhDk+7UlxVW2Scr0+LOw7wqWvBVU0kmnx70vIUYyFb00yog?=
 =?us-ascii?Q?KWfI16KstDtMVndSF3+P8pPirtKaF+qAdAoWNt/VNvtJRfl88rT0VpFEXoVe?=
 =?us-ascii?Q?mj4XFa9joLl//sdPX5BZ5ajPmOvxaiYxq0VzbSSZLVoyvbQwgr7aY386Ugds?=
 =?us-ascii?Q?LBdDbdkjakiX4U5svkTsaSfXknO/V/pTrWUVv8PfMy1qVRH7XqOdfD85HEfi?=
 =?us-ascii?Q?C2m3vWwOc7VOwawlsxU92tO7KQEEfLxTH1YPXrxoIfWklGspOGGUf+kj1H1n?=
 =?us-ascii?Q?RCllFs8N4W9V+Nr/6PHPdPhOHlhsP0fuEdsinQOt99/3vPqdJjXWPg2uiBH6?=
 =?us-ascii?Q?Qxkb3Ag/SJu9Mv/DcmnWVeC/A3q9nQA3wcO09L/xnTzceSoTdKqeoBkQKB2k?=
 =?us-ascii?Q?seqZK22jG4JdsirhiSq6Iish0vMjXGXyJOxgeShph2hFtzr9NaICzrh1Smlg?=
 =?us-ascii?Q?H69SGJ334Q5o09nuKQsk7Fzj8lRDpBg/0GrP0xlPZFSJpUR64a5SRFYAkkPC?=
 =?us-ascii?Q?ZEHJBQn7b5UNBYeuezoK6Ymdzrik593A4WlxnicR+Ly7uR+FWUemdzqIb6Gb?=
 =?us-ascii?Q?EObvYWiERFXEJSZYFAy+llXlAgKVREd/AZ+Dwx4A0wBfipDge+IY4Bsf2TKL?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hzt5vhd8Vzl6/Iw3qrxazerz2hamjLyn2bKEaDnoBnDcjr/9hNSfEYt8vVu7ooAjqN0YItsn8edNq52uyFBkqcbhroXgfrWVpMD4SAsLunbx6SMoKQ+Dr18B9p6ACRQ/6uWP1jfRWZ51lnW6h40Qv5yDWfAGZku8Rii2TFuJ0NAVfaE09ZGOQQQ8QPFK7q6aWRrAywzyau1ci6WodUnlLRBqNo16cuzbkypzyIb21EfYtyMrmV+dGPvH7KFRlUJeal7Aw8WNhnZ7Zen0yYkSZrsMk1jTd0xaveqICdJnYRoT9ORErU1ZWF3/sjll0m+x9RPH8hbqz5pK9alQbD+xvuQctHuh48kCOmPP/Lb+fIlEnxwaHOaw6WA/DPV0vtF0fyHReTZDX04513y1/YpppQS3M6kVhWmrkTmFsR0BpQewqmKJLBScxNXshcPA/IS+o0er7Q27wrPdxoUX0h5/xwTeYMgU4HT878bJseNbzuadKKhL7YVuG8t8PyvXgDsVyckyATsEgtDaKdkP1OT77dE1wURO8hbnxfl7kJRJ6QnfGgxkJRFF7tZfCiqH3cx6wlWBWPUexU8+E8O/d0Y1yTIhE00sqQOz9T7m/VPNHTje54ZWhmhXeuacIZsEfemOiBic1FIB2GcBjl9p/hLGEvtMfjSXmLsAkX+QWpL5yq7znYbPblF7H//gEV+Xy74zcRpTqoSbvGXINo2x/j3N/9TyEem0qVMb1ufrE4YalO7rX+lfvjQKDsBYPdj5HPHrXigIhhWBrSVjcfttLLD+p8cz6F2q05oxA5IyLHbc2j5bhbs0bUdbEdB8pQHtSPiqJOH8ApkkDgww9wl6Po/1X9GK60UPtNBhbmJnnwQG+YBK+7WxwyQlpeMdfxCDZ5zwUtGe0037B09PdOV5B3ryftGUW+Xs4YlIIkvPd3mv9do=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa2eff4-bc7c-44ce-88a2-08db8c745ee1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:44.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSICYdm+guhhgK0UG8t6ftfPbETKD/RLqeIREr0ugY0uvuOWihvv2klfKBrPywjZ+/iS3ViuWe9wftLwMRuQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240164
X-Proofpoint-GUID: IRmmvWP2BJYYg-4JJ7DoWtnmA7uqr1Z7
X-Proofpoint-ORIG-GUID: IRmmvWP2BJYYg-4JJ7DoWtnmA7uqr1Z7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate it and call mas_wr_extend_null() from within mas_wr_end_piv().
Extending the NULL may affect the end pivot value so call
mas_wr_endtend_null() from within mas_wr_end_piv() to keep it all
together.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 494f884ef17f..db61cdd8a649 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4180,18 +4180,6 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
-{
-	while ((wr_mas->offset_end < wr_mas->node_end) &&
-	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
-		wr_mas->offset_end++;
-
-	if (wr_mas->offset_end < wr_mas->node_end)
-		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
-	else
-		wr_mas->end_piv = wr_mas->mas->max;
-}
-
 static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4228,6 +4216,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	}
 }
 
+static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
+{
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
+
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
+		wr_mas->end_piv = wr_mas->mas->max;
+
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+}
+
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4371,10 +4374,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
-
 	/* New root for a single pointer */
 	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
 		mas_new_root(mas, wr_mas->entry);
-- 
2.39.2

