Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8760475EC01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGXGxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGXGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:52:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6115107;
        Sun, 23 Jul 2023 23:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLufI0dyDU7bFng5fObDIF4r5XjsbkZP2Pt+mWNnAAnY8ge0rYexn2KXPP9M1lfjjXaHZU9qhXoEI4wWnIKfoWSiNjPmFRGKMOkFdXKY1e9rLP1idxRCcmBYPGwInt3hAjIadZAsCwlIQxQfpfPvuOzHYit+55/RYTQu4tzjiFlYm1FqNR9Fbu9byjwERvepIKa+HIhvAP7ULavxtroGGtk4dlOnb3GNGgVta+SeJHIRP2x+z8VUY8NtlsmEKNzozxHFGb6CjR8qZJEp8mcoQYyeSuLbzMGTes+vVjkZDman8z+bgIMS2QWXUysWrcDbsSqb1tf+/PTEiPjB7lOz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOTasnQbWEcjZPZVRW2KamCX1gLP1ofQtZuQDGdg3xE=;
 b=M29Gm6idN60h3AfjGgAekDdpmIN3vWjZd7Uo4wKeXwCMY0/gKLkLhMjn/cGGKtEstufG6Ao5HgXFg6bIVj2leETcIIsNaNO220GVx/qPSVPY5Pub1pfrEdiD25CVCK4RB1R0/qKWVqRpZqToqR/UpTgDikNpgzhms5xKcxbqu17nerLO+J7IHdIOAWYSnlj7KotuDb7TARE11noy1QO7l/2qA4vidxc55M4u4UG+TsKR4VJePfU5AIf8oVFyqkDgVPsMNIgCVI+syLinzhaUpiKMkcGUsmh18J+2kqKRVe/OWa/+Umf2Oc5CnwIJnxUBShNQkZFS7Es2NWZc8/xccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOTasnQbWEcjZPZVRW2KamCX1gLP1ofQtZuQDGdg3xE=;
 b=kjTcruqgZBFowNs18u6LWvjVbP9PUchtruP+NzkoTvAw4ELU6kdFrhGdd8tqnUmar0dl6XIHyzfpQee56fW5SHMnnl9BJQg1Q5GEnifNW1zuY2mIMua7NCXrHbitJIJPGCWmMTkR4fR2N1f+muwWy+zLgVD+cJytADpD32fZPeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:52:49 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:52:49 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Franck LENORMAND <franck.lenormand@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 1/2] crypto: caam - Change structure type representing DECO MID
Date:   Mon, 24 Jul 2023 08:52:29 +0200
Message-Id: <20230724065230.83017-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
 <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb861fa-8124-48c2-e7f1-08db8c12982f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDDrNuxEm/6Jak96drUhMhN8tOrrHUYV6jKaDL2Jo/Cdunf9kn2MZGk7RCNbszfXTvfZQ/mL1idTVSAFQSDM6PIarGwUeG0opkSWQw+TBSdVqu7UBDMeH8qhluAd23Lg5VpdUDWMisAl3/+rGCFRqXRm9Ps6Yd3vHx5o/4BNL+LWWX21p3OIpP4qg/tK94kiEFp3AdJUVc3+xg6sLzQirUf+hOVMCyDnIpd/wXqNhfu3b2lH0d7K2kAbQZJfM7xBSU9aZlZVV3yey17mmII1BSBcbWUe9X5yBN/Ijg0p3MKbAlkYwiyj0J8gNgr+x4biS/PMZiKl2koW/lytHWnlikUxmDNuum0TFIKbhaKp6eZHb55ppw/8wEbl/bTbZOdbmVmgSYWI/KTMmdSgBgXLabnG+aaPv8N8zzUXV19i4uum09eKbuLfwQYiwx/PxqG5O/zwel1Jxf8dMP8smuTkE7l/0BpxC5USXDrsuCDD6h3jCFymmy5aWymnRmDxgdmsg7Z30Wp6t8o2s/72r9SQGzHA3hOfdwW/dmIcQspCNSRA1wQVJ/O99I8Zs+3MNVrIzEFUAE+Z9oK8MQQL5f3HcXPx91mcGoyKZMpDTaSqveMwK/zzH9eVu6wP7VzyWgu8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(36756003)(5660300002)(26005)(6506007)(186003)(1076003)(66476007)(4326008)(316002)(66946007)(66556008)(41300700001)(52116002)(6486002)(2616005)(9686003)(2906002)(6512007)(6666004)(8676002)(54906003)(478600001)(8936002)(83380400001)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNwYzM3Ump3U2JFTXJRcGlRbDROTTZLMG5kV1B3OFNMVkFmUWZwSjl2UjA0?=
 =?utf-8?B?T0t5aDNxTU90NXl4SVMycFVmZE1WK3RtVmwrdEhHbXp4WlFxaStpd1QyNFhT?=
 =?utf-8?B?Vm5MZ21ySm9PWG5oQSt4bnVUTytHMlFXb3ZHMGYwNjZnRWt0NUFLK2xxUkVG?=
 =?utf-8?B?ZzBQSlAxcjFLVHg5clFqdGZnVjJGVXZMTnJPQjRGUmNaeDdxQjNzdHhOcUNl?=
 =?utf-8?B?OXFYTXQ4NkJnbDhEZlRualBTS0VoT1BTK2cyMjFJd1dTbFlPbFlwQU5qRUl3?=
 =?utf-8?B?OUxGQ1liUkJZUFZXY01wSXBuMTN2UGx0cXplei9jVDEwbmZzTExhTDRlMks5?=
 =?utf-8?B?eVZGbDRxWEtZQ2lvK3c2ZGVzVk9WckxEdHY3V1Via3lobEN3T1ZUVmxDaUZX?=
 =?utf-8?B?eXBSS0ZQbi81cHRSaHR2b0J2VCs0d3ZXS3hKUFplTUFOa3NmVWVSYVMxZ1Fs?=
 =?utf-8?B?VjRWVHcybnFlM05SNXc5SHlQNmthTndyRkduOHdwWEJFZmxnUmVxaWtWb0FW?=
 =?utf-8?B?WFU5a3dva1JhZ2JNazIxaUlyeW5GVFhPMWpWMlZhWmg5Vno5M1FvT0R3dExH?=
 =?utf-8?B?RzhIYTJFbWVkdnIyelFEV0NadGZSRUc2MHQzZ3luZUx4ZFQwNTVFNjllNExM?=
 =?utf-8?B?R1FRNFBlcTREOWdRSklFVE50ZUYyTzlyZ3duOFhlWllzNENhTVNBeFRKeWND?=
 =?utf-8?B?QW0xaUVoZTZscCtpenJwZ0hsczE4ZmFGSVVORnUvcUF1R01McUd6ZFdUa05i?=
 =?utf-8?B?bklRaDA1ZHNKaGloRVJTaDN0WkVVUjJwM3VlZFRaYmE4WGVUc3dSQVFOb0Nu?=
 =?utf-8?B?eStLamlrTHg0a0JFdTF0Tm9NMUNuMDYwSFRwaXVkaE5NUVBvcTg3TzlXZklk?=
 =?utf-8?B?NEVSWWplTWE5TUx2c1JncUk3WncxcUxDWWF2RFR5MTI4OGJNZmc3ZmltMXVv?=
 =?utf-8?B?aHV5TUpYOEZDcFBxM3ovWjd2YksrOHMwVWRhMlFOMzJhWm1TdmFySm4vbmZw?=
 =?utf-8?B?S29DZi9KUXlqZDJDMUNnZHpNZm5JMzRoWmFNbStQZWpJRUc2ZjNFelBiM0Jy?=
 =?utf-8?B?bkx2NFdZNk04dlJyVHZXcHlTUXJYanFrZHNZYWwxNVlrSHpsTjFEdDFhQjBo?=
 =?utf-8?B?cFZwanU4MzFaS2xsekxORVlIeGV3MmdMTS9zYytBU0d1ckZhL3ZzVVR3ckxk?=
 =?utf-8?B?dDltU0V2cHZYZitPYzFONnA3VUFnM2xMUzZpV0NXWk0vZ2YvM25Ua0RicG44?=
 =?utf-8?B?SDlrTmo4UnlJV3Awa3l3eWx0MXlXdHJydUkxM0c5OHVrM04ya21SaFVBZXpN?=
 =?utf-8?B?OGIzbWpJZ3YxSUNaNFJSeVV0ejVxd0o1VnVmTllGMlI0a0RGakUzdDdyWTFF?=
 =?utf-8?B?eGVCY2UrL3ltS3JUaDJQUzRtWUhXRno5UERjT1BFNWt3ZGhjSHZKSmdSNXlt?=
 =?utf-8?B?Z0VLOWdvcmQxNlMvOWJCencwNmNBOXd5S1lUWkNhQTViUnBzMGZvZkZnR0cw?=
 =?utf-8?B?eVd5N0prZ3FOenVmS3VGbDFkTXh1bUYxMW95dVFVMDhFNlVyU01IcjRRR3NO?=
 =?utf-8?B?T1pqd1RaNHZueVJUTnFQUkdsdmlNWm5xTFRWdUNidHV3bmcwNHh1TklEZUVh?=
 =?utf-8?B?QVNpMDdvWHVLZU9WS0NXcVBSRFNHVUpVa2VQdmJOdis1c0xkd2VpcGxCSTR0?=
 =?utf-8?B?bGk5N2FUeko4ZW1tNFdxWmQ2cUFWdGU1a0JoUFljZUhUeXV3Z29CRnlkbWxx?=
 =?utf-8?B?VXBUbmtJaU96T29yc1QxaUovS2xvTW9KSGdxRlpobnJyVFMzS3NhbVZHWVE4?=
 =?utf-8?B?aXl6VHcvRVRKQ3h6UnlKUnBsbllMdHlQc1dDQjJOY2RWQzN4Ty9XMVNidThS?=
 =?utf-8?B?NXI4eWUvRU9WR2IwOSt1QkdRbFIxRnhGMDVYV2MwdkhML005dmY0VnlGWm5F?=
 =?utf-8?B?anZmM0pqcVQxbk9vSUttK0NIZGxYRzBBeFZJd2JIRjFSc0RNY212QVdNaTNY?=
 =?utf-8?B?akdJbmh1ekRwQi81WDZxSHNUOFRncDdLdlVRbzhMdTRJdUpiYmhaWnBKQ2Nl?=
 =?utf-8?B?VGpPdW1yNTZRWkxKdGdJa0N6M0l1MTFralRqTzdkZTh6WmpaY1B3c0dDUlNL?=
 =?utf-8?B?RWlkdDMrME9HU25neDNWUnE3SG55YTBXWUY2YWxtQi9SMUhOWXJEd1hGM1Uw?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb861fa-8124-48c2-e7f1-08db8c12982f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:52:49.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qHhIlk9Y7wQ4Ixb1DsZ2ALeYGxll+dLqAswRRq7aJk3ABOpItf/O7IxVCmxuk+vjonTijCPb1Vzykh0Kzq2Mw6wgUQhNQKJB3vX2IDHdsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

The structure partid is not suitable to represent the DECO MID register.

This patch replace partid by masterid which is more appropriate.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/regs.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 189e74c21f0c..0f87bd365582 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -459,12 +459,6 @@ struct masterid {
 	u32 liodn_ls;	/* LIODN for non-sequence and seq access */
 };
 
-/* Partition ID for DMA configuration */
-struct partid {
-	u32 rsvd1;
-	u32 pidr;	/* partition ID, DECO */
-};
-
 /* RNGB test mode (replicated twice in some configurations) */
 /* Padded out to 0x100 */
 struct rngtst {
@@ -590,7 +584,7 @@ struct caam_ctrl {
 	u32 deco_rsr;			/* DECORSR - Deco Request Source */
 	u32 rsvd11;
 	u32 deco_rq;			/* DECORR - DECO Request */
-	struct partid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
+	struct masterid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
 	u32 rsvd5[22];
 
 	/* DECO Availability/Reset Section			120-3ff */
-- 
2.25.1

