Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E147CEBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJRXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJRXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:20:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2069.outbound.protection.outlook.com [40.92.15.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B493C10;
        Wed, 18 Oct 2023 16:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPQy9SlJ3X3/J3EHsstQvxHFfEavZylp0slfWnXyZE5uWTfRPDy4NSQpBe+KSq7ENyP52kPwtWCwwpLymhzk73ZyQOe+Geqla7x+PKSColZBwmfAG7dKFJwM37t4Ga7+ZELNSVjCLKpfB32cnAKU1+bHfq8EKNXENoPvn/jE8tMFaI3rzJcDkQe0AdPYWokCTVEIDSZDPOHiM6i3enmr7oME47j3hPDLCkcQb2EcDSB5xlY5HrfnsysOnwRgMtwFCbcYsWQclnwIWgjMNMXDpIwGh0LHNhhVaiYO1YQTAiifIHgJZBgJbmUOUQ60V0ibVSUVLYTdG4tA81r4MxAdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeYWlTYaJOGIiEWkZu5rFXcX7Q/TSa/S03ztRgroNyI=;
 b=eT9OSrhKRaOHq7YpyQKHgVfs6/bCnby0p67ILPTTnrvgi13LEMQ39kg3EP318WqEMZdzcBNiFtkUCTj2hnlr4yHg3Zunrkg7bCLPOA4VFiZF0U43gYPbzVwR8QMP3fkBpQHEOTcm49JdlYzGK00jL1wqOEHa5PWjrxfUYCiWELjFQ6WZCOYhGxQv0RE2SuZFj55ni4/uNB9qoT7/po6lgsU3jqm4N/XwOSgWW3yeOmBW9Up12PrK4Ap3X2jV5hcH6vLe/TvJpe763EMfnY0w16uaIfwlXL4y96NGzUsByZb5+3j9Bh/PO3y//g5M8ip6L9taHuCs5l/mBFjPGB6FGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeYWlTYaJOGIiEWkZu5rFXcX7Q/TSa/S03ztRgroNyI=;
 b=CW8XLf9MHyPdyCFqyGnAqsbZ44zGbbMNmp1YSnUSpg+8P7jep6ifPRJo71+Omb2DfxCWWE6sC4bxJn0EhGDivf6FDcKQvbcsUc15uP9UPvP3Yqfxu6CWOnbBpZJim1xCtgsTlThBQlIVux1TMTNQJk+C/8Hw5ugyCZzhsSgUr2mQWlhK4WGTv4buyLgMzupaxqKnO8eweNNNq+ZS6W0a+g4uiIX3VkGE9ZUjgJHWphIpIupk8NHY3F8u4bBuYDOgoSHReHksgo8a7u0JFdbq0OwAuYeUXUQTEuchPZkBxlKh209WWaTrFbnHVQMMeXRlZMMjPNCLP03o3uSBi9+e2A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5087.namprd20.prod.outlook.com (2603:10b6:8:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Wed, 18 Oct
 2023 23:18:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 23:18:49 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
Date:   Thu, 19 Oct 2023 07:18:50 +0800
Message-ID: <IA1PR20MB4953F1FCAA05BE0C3563C0A9BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [y9B9I/G15ojI3fGqCG27vtUp9TDoQN9tQpOex+hILlg=]
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018231855.28472-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 72453cc9-70de-4aa7-8631-08dbd03095d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUtjrwI61rr2Z71KgMNUOPKTzK3rROMF0IaaEte00dRogcEdH0wkL5uYk02/2k4P0x8bGnRCWWLVI+5n//6cJRp9hr48kPCw6bO4ugQhI/z6YHxha1tnsD2LMmqK5MtY6wnmg1gvV9fJrNiG/+nurAM1fhT8kWvFr/LNrHW9BKWeghNKz3R1mnLtuRUiCqHSTG+q2WkeyfrYnKS4lHBMorAkUtup7UybeOycJKYeBbtw1t3kda5/wF4BwjftoPzlR8vMB4MvJ1F6Q3whUUC3/zMbsgXBfimLtf6ypNU40qInv5Hqj7Y7s2pTnunlZW5peQkz+zddf2TV0jv6aYdTODfGG+ZU2k7YzVThdv/9GguQfriTKG6RovuxLNqCQaFbdBgw+ZI7+VE1c2eBxOBs3ayD/QKHqbwFLLUQCk13aizciuDyvCgIwT5i6gfYPR/Ih0MRDGlOJbLs2okpxxmu8kYwskOhR+D6nDjVSlPr5oDf/auam7YSr679edy7B1zH54dg8GBuquzTpxeG/3AD0MMLmuO8XDVOL20XQuXgy5Z7aucakRFqmB0lQ+7srY+D3Gynjxp17bmh46Mx+TyQZcKQCLhaSE85Z+8RJeABpXSLF8P/97piyV9NR0MHnhbanBPY5uURKmWdIRWXI0qP8/tkfSnjQgDUx2As0wnFndE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TIsMr6qU5VjSiDa+eShwQ9LLM2WeFn/b5D3UNlrzY+KvqeXSGuS7L/oVorN1?=
 =?us-ascii?Q?4zbF4292s0n3gJomeonhCAJcyzy8z6kU73rZxLiMf1UPsK+1wCzGcgOHXIAe?=
 =?us-ascii?Q?XXUhwafLHsVgUITvEUmtaiqTvR11KvPTndzFq/ws6agwzkGCmSeGlPhAYkkc?=
 =?us-ascii?Q?3lPLu+00YTlPcdr7/+TAkVxfUyveIIbSc2mabhhHq8JXCjcI6+w9RHybUYGT?=
 =?us-ascii?Q?U04Bo7jXItWpgA768N1rHCwsUwf7kXvUj4egvD4V9HpNpU//vwK6rC2OcnFI?=
 =?us-ascii?Q?KL0Cy4Qcg/h415iH3V+WV0VrUJH5EWcBdDuZ3DC1O3gvEvHUHkN0Jr5AawvS?=
 =?us-ascii?Q?MK4P7NsC1DylELBGZv6mOhX0iahlh6iXDdXtwHa87A7rvOS/PQhAWA48oi3+?=
 =?us-ascii?Q?xBS6/t67GBM6YTTmT8eYrYH5ChrHb9pZYw6eTb3ZSbIyMy1ifvLmwT5Vva0f?=
 =?us-ascii?Q?IOxfBQqynG7QM7HjcWRATkMIidI5HHkofnB9CsL8Eho2WmG7qVyOmVY3A1qy?=
 =?us-ascii?Q?FUbsPyLiHqkCzw8Rm+RzrIvJqsdC3uNXkIU2Xv6brGxYkm3bHin4yeXFvqS/?=
 =?us-ascii?Q?xr6bbEq4PaXbqu7fJX+y42wav3S8OWQB5ov0WGU77oYueFysAXSB/KwHIVha?=
 =?us-ascii?Q?whlxEoI5j8n+B7He2XH6Y1Q89ZCtMa+fw6dhE88qt5dV+Z6CvB3HWBXSeyU8?=
 =?us-ascii?Q?4vTimjD3KiBqPSR1EBhz3lLgmuFhtRYZsSTdk91QMk8J6ulFV/n2vtXnjRaI?=
 =?us-ascii?Q?c5+KtiJWY2mWQE+7LIAOKDUUiEUIU6tefALPduaE60+ETvH9PgNVABa1c1up?=
 =?us-ascii?Q?5A9Lpb1yOTNJT+j8Iz9XVkiog2xU5L7enRpeQq1wXYxH8ZSUyztIQnTNwJFq?=
 =?us-ascii?Q?2216+JYGj6U6QrDfDAzRBjnJl9pNlmUWb+YHyyfoJB17lhAzY5lHZZaDrMi6?=
 =?us-ascii?Q?JS/8zLT3N9GK/z6NNfdiVA6iu/38JV7OHfdDS3WIVoEekvaCAUUZQGqiRzaj?=
 =?us-ascii?Q?BCDdCRxI5bnmDYrumIel+gdTtezdiR344cdHVzdg/Zjv7QNick0hyLqmd+Ja?=
 =?us-ascii?Q?n8VOR7ueiBW5rE7yq7Vhkms91gA9zPElYu7M3FEcHsKPzy4Sv5t7UHL3otMb?=
 =?us-ascii?Q?IcgNdjwZK765FHQsx0Px15T4uybR4COBRcIdnq0zrM1z5jDFO9hR1iI62Koi?=
 =?us-ascii?Q?kR8FZdwOnNLp8jyetXOgopDfiTLaa3KTf0Eym0UcFlLGmgCKnnyK60e2Gcc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72453cc9-70de-4aa7-8631-08dbd03095d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:18:49.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the SOPHGO Huashan Pi board which
uses the SOPHGO CV1812H SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://en.sophgo.com/product/introduce/huashan.html
Link: https://en.sophgo.com/product/introduce/cv181xH.html
Acked-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 86748c5390be..9bc813dad098 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -22,6 +22,10 @@ properties:
           - enum:
               - milkv,duo
           - const: sophgo,cv1800b
+      - items:
+          - enum:
+              - sophgo,huashan-pi
+          - const: sophgo,cv1812h
       - items:
           - enum:
               - milkv,pioneer
--
2.42.0

