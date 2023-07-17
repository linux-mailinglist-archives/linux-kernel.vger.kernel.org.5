Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C6755C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGQHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGQHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:20:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99ED1AE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdEoTVeWaH6dwmw+AerFa39G4p7qJonOa8Uqg0cJcqlqPfrEhl84q0LzsEw0B5126Uj5KtLbgy40/ak5cxaZT3i37hBAoVFDxh87QxAywXCwakfev8ftWMmR7daSQhXTx/G7Mn2d3IZhq/UIxBtzg0mT8CMUeRpoXhM8w9eb7MFAcewN87WyDTZz9xChitRQrrqszOyNuFC7mD/3Ohdkbtq9sLn+kcSIPeTR11VchU8xWchTFTFsjXYPcFHJK8VAWxkK63Vc6YGOFZAlaE23m3CbtRu2b5gTy1ADOLaspa4J0E6fyNVE7QDQzfWJ62eMTe0zPNNVwAMkBIPmDRy7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jx6lFVmKwDxKRTKyth8l44j9L0Zb/QMFJdsJW9zm80=;
 b=b3UB3pXkd6nKXRaR4J/THpgQ2peWm1W5Zn5p6T85kcMNHDkaR0yGLcnrZuxxFrCdiUE9AtqaQufT5BNdGi7OXfFR/sp6PBEZF+WZqLrNPgy/3x54GTDkgZj3el2eS/eNymarD8bv+T2D1RVPOhoUqK1cVanJGXlDYwnVOkUK31xDVfezobcm5z08P3tb/f5ZwKrRNsCgJ1O8Vp4FTF3WIf183br+gFLQce/Jga2UOrOApJmXQOCGxNjlV5IbKn3qJfLsKSo6qpOaceAWQcP7Bc755JLB4LCIKRd2SVCFvJ/IFDKxkdGXdaFdouleFAd8m7n2NFkLnjAifyP8lHLUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jx6lFVmKwDxKRTKyth8l44j9L0Zb/QMFJdsJW9zm80=;
 b=VPt31VMjoYbhixYBFcKd18EbSz6KnBno9s6MvSTG++n7TxPbZuF0/Pe+YfB5aJRFmAGOEg7jH4thRr3iFSPZvs7kMA5M8DaB6f5np3HTBsTxMvW0SvoVsjA3V2yPBJjqKhMip+TwEge+9aNb4sKWIckW/ToNOr2ZqWLX4UXzxRuSYw/z4Ly6MdHJvQK0MIQfE92115ZUx7xW3LyIm2WSBtKkNdoRbDv8JmiR390psEa+iaNZwYXl0IGrlKOE34o8LrUpCuGzPfrgOccWjioDa/HGDfbH49WoGdnBU168m6IUSPfenYTzCiJZRjSSyRI3OVgUdN7eFCQvCCE9QEOvGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB3993.apcprd06.prod.outlook.com (2603:1096:4:e9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 07:19:58 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 07:19:58 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com (open list:GFS2 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] gfs2: increase usage of folio_next_index() helper
Date:   Mon, 17 Jul 2023 15:19:37 +0800
Message-Id: <20230717071938.6204-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: dc89f440-6756-4d58-e63a-08db86963a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LHiSsD66HVwzXT++M9h2VhtnGtyE1gUq2xMIlaiPLRLVYLFBF79mjxME3BbJBC0+ZM9hSrO9VYElY5t0hJmaTfc81tEf2Oige3M3kQLdfa8uzM6Yg9FmGNz0YGpvoRE0obkiQZh+0p6iHQ6DGUWRp2p0LsPYX3t28YaILiyXVQm/uzEXCyZyrp4YdpQxAJFrreZnHNHKtbV/7r7hDkP1zVICN5V9vzpVMmrfe3+Odh1sg0VHwF0+y1Ei2dDYOjxos45nK08bZYfbaPA/SMeO/Wo5d55WObAQjeDg70DEZrYlJt/7sJBHYWsO41GqIglXwNTlgqrvu+qff2ikijXgiWvxORT5fRL1qeKULoBF7WdQw8/QNXwlYVTB633etAc11O/dyoFQYO+NakvKWKjDne6emAOCgSPhZC+srgLysY0kKUXgyTRRFVB34ijnSelioIObYmyVukXaOplhnDUYxsxwQhVAvWAZyDWHaaj2ZOrX/JYx9+Vgvi6d9wmVedZ0qMIBK6+IS42E4D5tsJQkXr/9F875s5i4aWjuggMiJfvOhQ1OE9roQElpTNzVnoig9kS6lRz0UDj15KpYQV9ihRLxyGmOyc20utudvuKVQnLTQyTWM2yLV8PptCcs1Fu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(478600001)(66556008)(66476007)(66946007)(5660300002)(4326008)(316002)(8676002)(8936002)(2906002)(41300700001)(4744005)(6666004)(110136005)(6512007)(26005)(1076003)(6506007)(6486002)(52116002)(107886003)(38100700002)(186003)(2616005)(83380400001)(36756003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PoocIdjb2Oy3Byr81MxWnszKd2rjHxYh/ZSWiN9MN4gF8kO4zHWXhWfv+BTE?=
 =?us-ascii?Q?OOaaJZaJeAJEjDlp2WvGYLITEmWdcPIGgOv3J+L9OleTtLAQofmJ7zz6kMZJ?=
 =?us-ascii?Q?qHluAbmjt9A88YYMi/Gxi9hF2LvPi+r2mMRijGIeIiQFipjexyVHK+9Y9v76?=
 =?us-ascii?Q?G/75FKtaPVkInC0dVQSPD7+OofZ27QQH3uIgHj8u5QZl0W2p0Ir7rlexZPlQ?=
 =?us-ascii?Q?Z3W9tnLflablnXiX/Kz/YlLdq3N1oB9GaMD6Cf30rtQlfJ5Ha/mX9Tkqefz9?=
 =?us-ascii?Q?1uz3WeeLKwJsTw9PzyRlOSngEM2dBSq7TgB4eyFKwQLdycZzG69Sk8b4/1CJ?=
 =?us-ascii?Q?gxVf4TKE3TizfhwV1lMBJH5wjYnucpJ+9tRsQfWbT5U4p+mo9cncvp4SD7pE?=
 =?us-ascii?Q?uIt6YDc/G9dxY7Kmgm3Ip3A8Q2Armwzs+JJHkgcC7NOjYxGAV9iuZ+6GY71d?=
 =?us-ascii?Q?diUS/K1oWE0vYvrAC55EWJxLiLtkXWRNmm5Lme8ynIXtT5o0e9RGRLlwBOqj?=
 =?us-ascii?Q?ikJtzBEr+uN8hBa6Om+8RfVAAfWe0ZwVEttok07BpMIWdNaHY9nvj7PPqJBG?=
 =?us-ascii?Q?strYxx44eqlWqcgLYnbtbxHCELG53u/X9AidR+dlqqyNqCLSTfYPnUuJI7WS?=
 =?us-ascii?Q?R7WocxTEUur6yhN7dV8kWuJ1QaBgbRo/0pN7dpUCFsH0FhjdXy1nyeg4AHRH?=
 =?us-ascii?Q?OB+Va+l58KTu6WsJBfaldTfbg3Gfr7HxP/ywl97YwM+bJPfp+LT4BU6bIEB4?=
 =?us-ascii?Q?S410BU1ahUVsoaKGFqV4RYoOG3/atqdRHvbk8CwKUgPw2Z9B1ugBEs3EGl+I?=
 =?us-ascii?Q?cRt0TObhzf6KShXxYiTnb2WTgySsd7oak4U+DDwP2qoM9G8l9zDwvG8agbvV?=
 =?us-ascii?Q?m2/CMqwilNmB1brOXNMfJZZOmnxduwAfNDyFib2zjvRhhJtOprD3a5tTkt9d?=
 =?us-ascii?Q?lFC9dgm9ERnxbY1Kl1yuLEST5x8d7tXiwSnTJ2tmZ2Rw4XogKGkR/pHkkFZV?=
 =?us-ascii?Q?49Xn1DuDhZ0VTY62pHCY6CTVKgLkUsicz1zNnfwrsNWGw8hIskBHDyi6yQga?=
 =?us-ascii?Q?lp/dQKne+P1KY9J7ndNGXDx1IaO3v9ODDseaU/utQ7fcFAc+L1mZekSpEipB?=
 =?us-ascii?Q?BZHdx0i+hwJ4vKDfJ1evGHT0s5rj2SVQko/EoBxrjwqv2raFe3EP3RIgFIek?=
 =?us-ascii?Q?MXsLcX/0YU0y/Vll9WnKKDKR95eBvxRZtO0sJYTNnCARtW3veG7PZww9Tifv?=
 =?us-ascii?Q?qkVRioh4ULEWq1yiOuhDihjt1HKME6AMoYDyIr3sHg9GLPfpE3v3x2bBsvJd?=
 =?us-ascii?Q?/dQHSqnVKo/7S6HyTJqfL5UfT89RoCFhpDFO/8HfIwnSAE64/KmjBhzxlT/9?=
 =?us-ascii?Q?uE4COHzvh8HFyS5b48Dvq1+IoCQB+49Rgxc3llfpt7VWy2ckkFUF/2Sw81nh?=
 =?us-ascii?Q?9V62/zey+yLjbr85aGhgG5deoorkq2PAxU4e9fg5ZxRwZJJpchBakQXgqZWS?=
 =?us-ascii?Q?JOiYFF7b6wTNShxFZghgiOGe/FtQmvJRCij1HkBO0Iw6oJcJHvXvu/NTn1St?=
 =?us-ascii?Q?E6cbh5h2KwkIQrkJwyYvZx06OhlBUJhq8WzDH7nh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc89f440-6756-4d58-e63a-08db86963a2f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:19:58.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfl3IIT2RnUVaDZL/gfIZvW1XHLJPB0B6IjUADWQI6ZMloIC1Hcx/33/0UIVKd2ai34lx9JNCvTiODEHXipN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 fs/gfs2/aops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ae49256b7..5f0254237 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -272,8 +272,7 @@ static int gfs2_write_jdata_batch(struct address_space *mapping,
 				 * not be suitable for data integrity
 				 * writeout).
 				 */
-				*done_index = folio->index +
-					folio_nr_pages(folio);
+				*done_index = folio_next_index(folio);
 				ret = 1;
 				break;
 			}
-- 
2.39.0

