Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBB78A391
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjH0X6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjH0X5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:57:37 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A50DD;
        Sun, 27 Aug 2023 16:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acZSZpeUVa0MCDWEVk91SN8b/5mq96CsuM2vHWGqq+HEfy2DEp95KpgceMXHhdbZl5P6sujS1v3e9A3S/3Fk4ZEqRPQQV4g6shMPl/ivLzWPglIF3Cq6BS8MHk/hfXckKDvNnCV9LWLPvd1j0FNRZnV54OnBecJBZi7VbuJcpZj6P9PQhX8ebyrtH7SWaiXk1+Uzhhewjxk+GyyHtgqGyCGp+Mo5wzEete+OupDCVcs+GHnUs00qjbE7H88cb7I++dmKVnrHXAFkfDKapl2Uw1dJdU5hMvSPejwY1LxbqqrPbht5+TtCf80ZIPL6e2tZ+3Qot9onJ55RzbQEPTMtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OevlTJ4ODJuNv4RJ6AoYIZdUCo1nkknIBB5bLLwZQu8=;
 b=YGYLJ/eGV6N3rHRJdBgBfv6HgWUmA7U8PpN4gWqJXPGrBGQOTT7xopJCk5KrcBwTwzrSw1opSsHz1Vynbj9kUOTdHdfEluy5kdUfDzQVGTOLzmI75Pg37rtiIL0XlEJlaiNpGPgs5KjCarH7d3BchCyKp9vVSj8e9G901mFqJQQQ0rEkU5B0DI/l9Jf69NPUwjpldj5gAbGkOBsj5hYsuuWZF2tLPgGF0jNYKai3tGn0N6pIz3weNbMVjSov6hRKQeTpyZlJKsnSdCBRXMxcXG9hIjUFOW6jyaNbJXz/1Y5ndDhBmvf6FpHeztcI1PGO6I3pa5xK42fFQmHbtlfGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OevlTJ4ODJuNv4RJ6AoYIZdUCo1nkknIBB5bLLwZQu8=;
 b=iKOk/IAiWPp6B0wf+UK06DQ2nD9zLuq3tUeEkE+WJJPOSISWgAOEaC4/KCHZKYgaJyQl+/OhoOHnCmVefnp/GM8LpQGhh9TlIq1usiU9gWDvw3hg9y7yF4Z7q2/VQh6HrtsQRkJeKMWK+jQQx7QmnA9YH8I/4QLmevGSK3Ci0h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19)
 by AM9PR04MB7523.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:57:32 +0000
Received: from DU2PR04MB8967.eurprd04.prod.outlook.com
 ([fe80::2251:6de6:12cc:9a73]) by DU2PR04MB8967.eurprd04.prod.outlook.com
 ([fe80::2251:6de6:12cc:9a73%6]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:57:32 +0000
From:   Anle Pan <anle.pan@nxp.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        anle.pan@nxp.com, hui.fang@nxp.com
Subject: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Date:   Mon, 28 Aug 2023 07:54:20 +0000
Message-Id: <20230828075420.2009568-1-anle.pan@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DU2PR04MB8967.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8967:EE_|AM9PR04MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c336e-dc40-4937-e168-08dba75960a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgq6gLev2HkDznr0oBSWl8Gq9+1Q7qVAtDoopq8PXXP6hGPGmCAuqFoR2esZUzYboq32upZfc40c/fM8ch3WiedSQPjSOazKRXmqSbhCHkWV2J5Z/3XankHkqx4bqnVw43659NvacVUpAqjaQQT3i3OetcI9H4t2wegvR1D/k43p3T6SwMjkwZvawKmsjSIkll18FQrm9K5p7M9hhbOj5iJP506pk8frfbqj4Y+Uo4vCU/InrhCUHdYxJ7zGlXUXtOUm3o/FF1imoiU3az/1tehh5ElC2UV3QrDSataAzsZT3/eGmfD91+orlPB9Ga0cyLUIc821u1UMpSpjWCtkZ+COvPkut2awP42TQM5ZrKLTdxEWL8p627R/bG0DLkYyJOtfavzhK8E8nO5Py+ni0SiPLdzOoF4VQMoUBL/bDyNnbryIA8nBY2Fyz8NGvdOHXv2BPxzJIaGCZPTaZHGjPAZz9Q0uzCkzy4sVn0rRDH1IK7HKK9XsSzylc7ExVrb6f12w26dZ8GqIdXak4TPxOckuk5i4Z3yKAGS9QbTm42IPLljLJHMF7t9RYOJ2fvLQ8dYKhIX42jCO6ovI/zAzu5svEaKWhH3cbptiZ67oqXh/y3qcrOEHtizVlmXj1wWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8967.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(1800799009)(451199024)(186009)(6506007)(6486002)(6666004)(6512007)(44832011)(86362001)(36756003)(38100700002)(38350700002)(2616005)(83380400001)(1076003)(2906002)(26005)(478600001)(52116002)(66946007)(66556008)(66476007)(5660300002)(8676002)(4326008)(8936002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRoQnJaK3ZFL0t1elhsbWhpbUpDbGtTNWlDRGtNRm56SXdCSittUjFpVlFj?=
 =?utf-8?B?UThkTWkyWlBRbTk1SmR4RGJDQjhnUUpuaUNiN1BlQm9ZNFROYXl1LzZzdUlq?=
 =?utf-8?B?RzQyUjJ3SWtGZjJFRmJ4T0V4WWxhZmxYWWVmYTl5YVg5V1pnOUNQYVdPdlJn?=
 =?utf-8?B?YjBkckY2VlBUSkU5QUcrbkJJWFovWEgzVm9PRm1SaHpZVUU1RktCWm5MWk5i?=
 =?utf-8?B?MnpFYjZHWFpNZkVkK2U5c3NqcjZLYlB3WHRuOVBpaytqandOVSsrUHZqczFx?=
 =?utf-8?B?T3dUcUMzMmNvckQveHlIM2JtZTlXQm9BWjljMUdMc0RNK0pmL0pYd2JnMEsz?=
 =?utf-8?B?VERxTmpBb2VlcE9UbDdFbEZUaENWNGhadXBPTmNHNlk4RXl6Qzh2bDh6cXgr?=
 =?utf-8?B?b2huY3crTVhLc3VNZDRHaGdxTERDZy8rNGYzVDZuWW9iOHo3eFI5elFDeWZB?=
 =?utf-8?B?clZoZVQ0Qklnc2Y4Y2hLUlR6aHRtS0RuQUZZTHovdnBDaUhTOEE1OE9HOWVH?=
 =?utf-8?B?anYvOERhaHF6RUhheG8zaVRLQnlHTUVtQ3VVK3BiNjRPMEFYdjZ5Vkl1VHJR?=
 =?utf-8?B?MnBZckdwSWpWU3U1bXQyWThEeWNTZXRqaEN3Nlk5OUJlcTNCRTEwaXVCdXhq?=
 =?utf-8?B?YWRBcEtNcmFoeEpHclR0SmwyRTNhcS92a0hYZWhBWTFRSjh5VTFtS3VSdDE3?=
 =?utf-8?B?S1JoNDRWRkV3Sms0U3B4YTA3L0JZSzQvVzRuVjVLRVVxWFhkaCtzcVdqRjd5?=
 =?utf-8?B?cHlrTWVlQlJQbzNBNFVLUzRTMVBVQXdkY2FaQytrMGxBNmlBT3B4M003TC9X?=
 =?utf-8?B?NjArZFBMNmlSME9JaTdMc2NEa1NVbjZwNks3MXZia2UwUzlxSU51b2xIcUl6?=
 =?utf-8?B?NmhEb2RVS3l1bDU1VXBiVENSdTh5SGYyVHFvT1BXS0RhTGMzNCtkS0tqWFdB?=
 =?utf-8?B?ODZvY1kwYzZ6Q3ZBR25MUVZWYXFZcjFVQVM4VUxydHBBc2RvL2tGSGdjdjUr?=
 =?utf-8?B?UklZWllYdG51bnM3dm9nVzFNSlRMUENndmhKRWE5a3c1d0JCejBIc0Zidm9I?=
 =?utf-8?B?ditMNGhLMGcvVmpIckNYYVlCQ3ZTMDA1Tyt4QVdJYlVCR1ZsVjladGs3ek5q?=
 =?utf-8?B?Q1IwdDFVMmp1RzhjY0wxWHlPdHNGMUJOei84aDVjaHF2dE1yeTFQNU1HSFFt?=
 =?utf-8?B?L0sxcWtzUTBRYVdnYVVuNHFoVU0vVTdQM3pBMklnWkg1QjFrTGZjVmJ2UXVQ?=
 =?utf-8?B?TU1zOGJweXk2aUM1b1BpclNKUGxJQ3RqWm1DWEVmTzZobmFac1M4S3hVM2Ey?=
 =?utf-8?B?MXhGdnJOV2c5d01nVGRYYWJ3Z2NlN3hNZU1uN0tuU1VGUjI5Wmd0aXJJK1lI?=
 =?utf-8?B?SzNuemhyTHh4dS94cXBSdFdyVXdlUklZY21nVk5NMk5uZ0EzYzF2Vlg5R2xZ?=
 =?utf-8?B?QnIvemlUcnFEWW03VGcyeWlxSVhCa3hkNTFvQ3oxc0wyRjRNd2tqQTg4a0tG?=
 =?utf-8?B?N1BTZWZYdUU1VFFyWjJEUVhmYzRmRW44VitvaW1JNzA4U3YvTE90RHUrMk1O?=
 =?utf-8?B?Y1B6cXVua1BhWjdDWFg4c3dBVGJSbzVVa1ZIcXlWREZQY3RnNzBIb1p5dU1q?=
 =?utf-8?B?ZklaRnRXNnFnek5WcVRzenBwKzQzcmVBZExVaTE0dzBBaUVUeW02Q2FtanpS?=
 =?utf-8?B?YWpPSS9QcUt6QUVXc1g4cWpIdEhpcmxTcXorNVpuWmZCTy9LbSt6VlR6Ym5X?=
 =?utf-8?B?NkxGNXhLSjhHQ05IMWMxemdRMFVyNHRHODhHTnJjU2t0TEVMMGZ5dExxc09x?=
 =?utf-8?B?a3lDakxrRTVKSEQ5VWNjVGJlbGFzRkVqb2VkdHVzZHFJVk9nYzE5RGtBYlVL?=
 =?utf-8?B?TllOdHdpNC83Umk1b20wczZEclZQcElaa3l4Z0M2eWs0a1RPNGFjem9PQlRu?=
 =?utf-8?B?Z2xiVjRrRHJjUUk4NE1TY3AzZ3FRZFJkQzJ4TnlmYXZYNnpDejdUcEx6cUVp?=
 =?utf-8?B?azNSZzcvWlJsSGprcXlCbVczQWx5UE5xdFFFdVF6RDVZVFEvMElRcW1qa0JJ?=
 =?utf-8?B?ekRtMjgvNlpxNVRaZnRIYTdLRU1VQUYzT05ZcHNHa0t0Z0NXYzVuMVo3akVR?=
 =?utf-8?Q?RUPdQTOOCKSPjXx8kLtDbl2O1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c336e-dc40-4937-e168-08dba75960a7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8967.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:57:32.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3XWeu2+06G8Gie1IkLVhMLomAmqRYj2rlVkC58JZv20Blx3qfFpijataNX30neKMUtbnIc1zecwF9pXi+WcxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7523
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating from pages, the size of the sg segment is unlimited and
the default is UINT_MAX. This will cause the DMA stream mapping failed
later with a "swiotlb buffer full" error. The default maximum mapping
size is 128 slots x 2K = 256K, determined by "IO_TLB_SEGSIZE".
To fix the issue, limit the sg segment size according to
"dma_max_mapping_size" to match the mapping limit.

Signed-off-by: Anle Pan <anle.pan@nxp.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index fa69158a65b1..b608a7c5f240 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
 	struct sg_table *sgt;
 	int ret;
 	int num_pages;
+	size_t max_segment = 0;
 
 	if (WARN_ON(!dev) || WARN_ON(!size))
 		return ERR_PTR(-EINVAL);
@@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
 	if (ret)
 		goto fail_pages_alloc;
 
-	ret = sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
-			buf->num_pages, 0, size, GFP_KERNEL);
+	if (dev)
+		max_segment = dma_max_mapping_size(dev);
+	if (max_segment == 0)
+		max_segment = UINT_MAX;
+	ret = sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->pages,
+		buf->num_pages, 0, size, max_segment, GFP_KERNEL);
 	if (ret)
 		goto fail_table_alloc;
 
-- 
2.25.1

