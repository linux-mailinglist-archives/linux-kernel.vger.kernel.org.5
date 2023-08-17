Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D277FE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354618AbjHQTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354453AbjHQTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:15:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D0F2135
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:15:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI4Nsx025027;
        Thu, 17 Aug 2023 19:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=agHxt1//mk/WEL6ZEyAzmotjn0YM2yUwnbobfigifgyiTdt1PE2J7jLGnvsZGa/6rQD2
 IVbJlow459w4zTm9ccfFzv8TB91T9VR0xw1rB6nuKe7GsxrjCMN/YkyzCfO1DDKc9D/3
 FrLM+eZDgbgwyYH6zzDekBorcKXNNwqhnfLC9dbWHREVmSp6EVDhTMhOOgfyoKmjAuV3
 wVpleaFXPU7OfIppbfFSoc/QiKkJcpSpH8iFWg3S4L10c3umPMNzw681dIzOfEqbZCgq
 hyUwGMutsX8vwdWvLqyhL365RDwRqu3AF9Al4h2ZjRghQYVm0wJPUhn2q6D0A6i86DDI yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yft72m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 19:15:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HIfIlv040055;
        Thu, 17 Aug 2023 19:15:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0u0fgt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 19:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/tw4Asw3Qs75r5M0M+wJNfh2xRmEP/OLoN5B/aWyKSrrvAIjuCx8ZP06peAHc5EhUBvYwAX/chIVakKvOm5O0xlD7efF5EVFR+gnx19O8TnOdxw+9IG4F+8BG8eDLueuNyNUI5I+eFfKV1loNirpCw6qaVjL/1nYDSZJgek7ZMjb3UEY86TaFBic1CjHpYASb07q2NWRGaDxH/sPVqBNQyYngkxsGItuwxtpPfKIM2hXCQpdhzgcSdjVyLiryAIg0fbwPEtRtyYlpwr34P/aHW5IH2rW/mfKw9uGOBABbrbWLTzIKpEe3BBXyJA5Zq2jXqDtTkIKuIICibDfO80oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=kh4fuGcC4o50V39H27t/Tk1sy/ttJKhnDS+HH7CO4+VCjKnurdk4RzlGSd0ThMt73W7ZLBZdlokcavOLeLZpEq7YyBlCXuCLNiHa+j5I0jYbgHlBmB1pSSBBUABk4RdPYLvZ8EXGqzJS625k8LdFE2PK0/I44NHbyZuNYtNoCV1lCY4j5E62q5ydQkSKDO4+tHLV2emLr+gFu+Himkt5vNM6OCcMfiDiA57GZYVzdfe21R4giHAW3DPOTVGdBOdbgOwfjrxy6HEtSvDRRogfmF6vk+wnVdSveWiUsj2fxVuh3E7QAFSWNC+WOjqB+13keD9JTM/PeEfOaDGNbLT0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=nNqBYX+3gr2dofF/t8hF+SMZNX7iGUsivZb8gm8fiZE+kjGMPhx7fDtkbQ/vC9J01mmhMGy+nbEnqqwqn7zbUVIflK0ZLhS4H88sYNhGd922gLpcn+Lf+ssbYAvBHgOsx6iqkbxoR9pB1tFKTmrO6Qy6Y1dfFwQe+uQwD5r5+94=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 19:15:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:15:16 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/2] maple_tree: Clean up mas_wr_append()
Date:   Thu, 17 Aug 2023 15:15:05 -0400
Message-Id: <20230817191505.1170876-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817191505.1170876-1-Liam.Howlett@oracle.com>
References: <20230817191505.1170876-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cca7151-6f63-4505-a3b1-08db9f5649fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFbssNz7+HSfO7PA/QBhsvKZKDoeAelFuGpjuI9LO4u9L3b5cmPxBB7gRCXkZDfVtoXjOHFjNUC9TkwdFBkNDdYj7mSPfTvgh6yNV6WJK8so5qi5XaEEFxdVH3DWi0Y9GqiwIBFyQgJbTudmgJNn98sXGvqbz8zfK7U0cj+STnZ0jJsHOhGdvzT/Yfiw1K8j8QicMQnVOwWM1cXz3mn4HNVt0pifZo6/XTdSM/oW6Rj7Ogq65FiP+ZPfhe0kD6Gon9hj0o3u3DzfKnT7ygu536aFILWF8W1ZjjrehygPg7qhQIrRpPGJjC0OJHEUg3SmjAiW05b73tADOKfeubiaxrZhhJ2IrA4gFO7powMzNQvYK6nDOOEJAkNduBiWZojZ892xYJMXn/Q+soPyVewj+m1bz30zhtIWClfMOhsvshQ4wNJSq2G6zp9xCWgWBeDzdSdsZvF/NR504eDtUUrvRc5uxAq30nWNvasMQBmCu52P8AFejx38We1lae8w4KZldDKSUleDagh4RHVoeQ29pWp6Pb3mKtLz4vN1XKunarRHBg/dNRToG3PBLC7Wf6zE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(186009)(451199024)(1800799009)(36756003)(86362001)(83380400001)(4326008)(8676002)(2906002)(5660300002)(8936002)(41300700001)(1076003)(6506007)(26005)(6486002)(6666004)(2616005)(107886003)(6512007)(478600001)(316002)(66946007)(6916009)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tO+qFI8PWx255XqpA6pWuSEOGwp0OIrZucBUNvfStolKu3pjWsL81zqZGHR?=
 =?us-ascii?Q?y4gC1yQTWZ2m0dcIb9As1T0S43EutOQ3Cs6+Yrk3I0GMqipzfneyYibhbt4E?=
 =?us-ascii?Q?AqgXuGLbSB1OQjHzSCeHbei41eH7F5BoETBoiDqSdG+85RxJJeyw0hDhWbre?=
 =?us-ascii?Q?UHKPeSwgNKrN3cd/RprbCkOUNjtr0I95wD+wIzHBonFkZNCzFmKhBIYwq9vB?=
 =?us-ascii?Q?B8i7erpwfIVtHmU1v0tH6KQkUZwZadgaTCmWT04WQgoChbPnBNElRrskrBOY?=
 =?us-ascii?Q?K+HFOGsWv4dZUf5BzL4b2DOEruzuw8Om89tBZk5/sHEG9osDdPYRP59akXah?=
 =?us-ascii?Q?iDMbd3SY90ASYPLEZRziDC4rCHtcZ2//OHET4XXGbiV4GB4WDZMuGL7ILUnQ?=
 =?us-ascii?Q?cdDopbkouKUf/2xu0Pn1Tfjs9ounmh6kEfxIPv39HIpGiWidWr4ufZLc6cUE?=
 =?us-ascii?Q?NtfqxZrv26bC31nn1WUVH9I2EhW5QwmTVhvLXBudR+3StjlnxW0BWE2RLc0p?=
 =?us-ascii?Q?bNk5UeQU7CF6B4PbIJaAULwaC6o7rp7F05qMJHA6kuZ/He/+RWLtbVZJdc7H?=
 =?us-ascii?Q?CQBbmC7KNGyr2WXhnqWOeTJy5fZD9YEDSHUg+i5ajWOizB6UOSiu4NFu16PH?=
 =?us-ascii?Q?+K4Yw/LFJOas+TohLbKotrkAiZ2hPx/boPLYyEQh9vAnPwTVKZocz3M9DhlR?=
 =?us-ascii?Q?yVAiPcnbH2DP6MupzjRGd8hi7RKZJcWaaJutM30dmoInTFi9SAHQ0LOpLpCe?=
 =?us-ascii?Q?HdZKcdN6bj0rSfWhnad9GrBab1wSdhx9UseOl7Q9MvkuqeHJxcJdimfHEjFr?=
 =?us-ascii?Q?NnZeuqlVB0vFgHxfPcLQeU04BhEnxUJllz9tju3W6rEqzLbgrITzg9CoEP2i?=
 =?us-ascii?Q?Dzv0vrr61EZ8YycPVeIpisX4wEmtcDpgyyK8+M+sZ+lK6trLL1vJJATK6GR/?=
 =?us-ascii?Q?5Afes15zaV/HHkGtiKWjHso+KcN3iCSk/WzQ6U8JwX8t/08mHAj2guFa46DT?=
 =?us-ascii?Q?fpD08cjlYbrN16Yh2RJlv5065kcqirIBUgGII34SxsTEDlrbMKYk9V6uQ9VH?=
 =?us-ascii?Q?S8938tuMp3SzbOKhcaD3dCxF2pDuQmvHb10mbNFZoniQ2+HmlUeC1gCZ0OFq?=
 =?us-ascii?Q?jERxQ0Qrj50i/UNE9D4WOJYsA6B7zCq2ZgFSpoXUAsZt8rnyJhFfPaNRJVJ+?=
 =?us-ascii?Q?kl5+vJ10aejTAOqz/zBPRGvqa3H4cqgCEgTzlNm4xS7C1sursJrjFezcucW1?=
 =?us-ascii?Q?Pe5ivorwx+/9NW0Y8Bz9VNal2xNHNcPsuIIAgvQ4UloXB967G9JsydOBxe79?=
 =?us-ascii?Q?e6VlTMVcq4JEEdQ2aN5J4UV6nppo3k8604h6CMh0UGAZQ7yZeb0LHnYrEvd1?=
 =?us-ascii?Q?nHFVb3k84du+i8O0/3mVEswxi3pqOhTTxPL1DCJgREHhyEUUrGCAAR4V20rg?=
 =?us-ascii?Q?271wNmc82BIT4j7b3oPTD9hep0IkOnwXHxah4aus8PaQu0tP38RQi6VNdgFG?=
 =?us-ascii?Q?Gk+4s2r+DqlYgkk310BQoX6iSHgKDyVY+aZIS6sJZSUQwAibD9cFO+eR5BfB?=
 =?us-ascii?Q?h4D+Dgw4AaIqGG0WgH3AqEpFdrqFAaaFNh/7we96?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KwwyQ7Gsaoqs4iSw9+fylb01w9F9Mi1PrbJ20Oc3noL4SngRHCI53gKMdvbMVYSFbe6RllemBAc/iTpYegpKRo7x4gEbJg5vpukogbcYvdlAHYI3cxHFk+Worhz+s1gseDgb1kcfjkNm6rT05s76NcdmzLrnzIxX1AnWUqpfGxIAFSttmNiE1bcdKrzr2JhG5zDWGkkfyHSClVY8phg39jUfFyuJ7W7g0wNfhdWZLvhXWkohTuxxPuvMo13Rs4hWhFQc7CzoM09kWQHZGQNVdSVrBKSBEy6ZPWswMK5XyxSo9dmnMQWrRFZzjqCHCcZEjyB53td3Xbs5aKv5FZF7yqcer64F+3/2BnXfSrAnDnGbaB6tFSt1V2PNUzBa/wm3iH4WQStf6nstG7488HR32xn1k8b2H/k9EQoSlnImLVL174B3uIqpOW48Z/yjNT6U+cZCZggUpgQG9Yu+shw90dUJoebE6Nb1YhnpdWkpfm8SYK73+YVNCNhG2mLykN6Lvtv/JTaJQin4YQ3gvQdzkHp1IOqtJwOb/TMlOzAqMSHYembvy8lUb0PR8Mj8aOvw5U5F1BtECTe2LTZ9Os2NAG+KlBiMUT58zRrTU2cVOoQgOiVAjFPKm1/86k6qylHYJsgeB2mRZIo4EbKfetquFo4TVcunV5VsTQ1v1AENYoUVXeUqZ42aNXCZSFJ+k/nbmv/EakV6Cscr+OpHIWSQ60bfY5cfSCx4CbcL1txUKJEgy+ZuNAJOKv5oYhutrvKQIOUcILEAMPRgqVBbTuLJCF4qPSrnXezrMnogchTcEr2BZ0hexhLdgOuWUs49qzQWJpEP/6hO3gw+NVs+oq7wxzZ9TY6ftIwS/BbtHbfDagiOGstxnC9v6TusYmNsbtwW1+NjHRnmK5RJY0eGuL6s3A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cca7151-6f63-4505-a3b1-08db9f5649fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:15:16.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2LnZgrzmw2yhE03+lL+i+wFj5LLWBvysXXpkmwMwWMRr4ge0YfjBAN+ikOD8fhMgMnmN0hvoaW3XaNMUsbCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_15,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170173
X-Proofpoint-ORIG-GUID: g9Ta6fDTOoxHq7n9ytPV3VUuxfyKh9AJ
X-Proofpoint-GUID: g9Ta6fDTOoxHq7n9ytPV3VUuxfyKh9AJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid setting the variables until necessary, and actually use the
variables where applicable.  Introducing a variable for the slots array
avoids spanning multiple lines.

Add the missing argument to the documentation.

Use the node type when setting the metadata instead of blindly assuming
the type.

Finally, add a trace point to the function for successful store.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 05d5db255c39..ee1ff0c59fd7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4106,6 +4106,7 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 /*
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
+ * @new_end: The end of the node after the modification
  *
  * This is currently unsafe in rcu mode since the end of the node may be cached
  * by readers while the node contents may be updated which could result in
@@ -4114,42 +4115,46 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  * Return: True if appended, false otherwise
  */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
-				 unsigned char new_end)
+		unsigned char new_end)
 {
-	unsigned char end = wr_mas->node_end;
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char node_pivots = mt_pivots[wr_mas->type];
+	struct ma_state *mas;
+	void __rcu **slots;
+	unsigned char end;
 
+	mas = wr_mas->mas;
 	if (mt_in_rcu(mas->tree))
 		return false;
 
 	if (mas->offset != wr_mas->node_end)
 		return false;
 
-	if (new_end < node_pivots) {
+	end = wr_mas->node_end;
+	if (mas->offset != end)
+		return false;
+
+	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
+		ma_set_meta(wr_mas->node, wr_mas->type, 0, new_end);
 	}
 
-	if (new_end == wr_mas->node_end + 1) {
+	slots = wr_mas->slots;
+	if (new_end == end + 1) {
 		if (mas->last == wr_mas->r_max) {
 			/* Append to end of range */
-			rcu_assign_pointer(wr_mas->slots[new_end],
-					   wr_mas->entry);
+			rcu_assign_pointer(slots[new_end], wr_mas->entry);
 			wr_mas->pivots[end] = mas->index - 1;
 			mas->offset = new_end;
 		} else {
 			/* Append to start of range */
-			rcu_assign_pointer(wr_mas->slots[new_end],
-					   wr_mas->content);
+			rcu_assign_pointer(slots[new_end], wr_mas->content);
 			wr_mas->pivots[end] = mas->last;
-			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+			rcu_assign_pointer(slots[end], wr_mas->entry);
 		}
 	} else {
 		/* Append to the range without touching any boundaries. */
-		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
+		rcu_assign_pointer(slots[new_end], wr_mas->content);
 		wr_mas->pivots[end + 1] = mas->last;
-		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
+		rcu_assign_pointer(slots[end + 1], wr_mas->entry);
 		wr_mas->pivots[end] = mas->index - 1;
 		mas->offset = end + 1;
 	}
@@ -4157,6 +4162,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (!wr_mas->content || !wr_mas->entry)
 		mas_update_gap(mas);
 
+	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
 	return  true;
 }
 
-- 
2.39.2

