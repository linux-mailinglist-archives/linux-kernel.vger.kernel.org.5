Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32697E9473
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjKMCX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:23:28 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2099.outbound.protection.outlook.com [40.92.21.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD311C;
        Sun, 12 Nov 2023 18:23:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0iCFeWoVsRtDGJt5DdHjwtvwS885tnWJnCPUC1jeOx/z9Ld32E9MY+Gs008TLibf/9p/msITmTnPyWpP5KkQixijKypY//wocrmgg8E9lPv53sV/ZUzyqsD99hAMSIRjxiIxU9QaEChCXlYP8iPjcy8dSrY7WwgHsF/nOrYVt+zCtiHGzsMrhEDsdYgG9Df0pKkg+N1P9CYVc/TDlNemAFMYZd7EDTY2WWHLL+qyh96SWA97drEIBdOQjXJZEldkbVu/jZTStkfTHcCOY3f/UwiLq1knCpgIpHAObMj6N8s9MEg3oyjfm51hHClibW1RkX7IDIoDwetTJURGjlwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpU5gCj9Do/cH/wu/rkfmj9yggEU+9OjpG/hwnYqUoM=;
 b=cFtjKMH/5DzxT58XcEjryBhKlZL4whZbO6f37OcbOsrC1AgMsiAO4jl6bWt4Oig+EEJwkpTEbdJGfZceU44WLiaKucPCDC801QrcAGxTLFFGs+4qXF2fevasZAbh3kNV/BEef1Sh4MOtHXRbsb0tiJVbfmpKP7tpaAetfM1M5abMYkOMxSY6r6nFG2NPJK7OLlsfdo34ZvYZwy4g6jaLU0bF/e4GTiuLyP5YL9muUNGr08Sx31koCPvE1n0j5kJ4K5MI42BG2O3gy9DTO48KJEPjgC4iWt4kAPBDG0v8H+F18uQCPEq4FOdhmZfMNA91P11zTBrOCWDmAofm8zXTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpU5gCj9Do/cH/wu/rkfmj9yggEU+9OjpG/hwnYqUoM=;
 b=FLjOPkYbHuLqVTMvUqO7jX9oQFG0ba1fgeGCHXciyLa90biZktK65yMgF/KKuPU2E/D2ugbfZ5/RtqlQ6Ix6wOKxbVeAEqUhUYKCcR/Ttks/g6gx8cOgwGdmiXga9AJkw2IU2leQd8xYpaHjSnXhfbn2BhW/YREw+NZKutLiEeuXvaRleNYEUITeNDUzqviRnmiR5lfmeXVDlaZBg85Rxf4QLwDwf9hjiKUesv7m35ERN7Sq/EKvRWWVed9B0oFTctWy/NUr21Bs7W7LBid4fd6y4BbGW4lg4TrMUiu7WRUOyK7RdBNUK5XDm32zrloisUO9cSH+JUCmhvJlYLQq7g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4404.namprd20.prod.outlook.com (2603:10b6:303:199::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Mon, 13 Nov
 2023 02:23:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6933.029; Mon, 13 Nov 2023
 02:23:21 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Mon, 13 Nov 2023 10:23:59 +0800
Message-ID: <IA1PR20MB49538E6F9B462DD40E98C998BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB49538304E99DABF0208C00A0BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538304E99DABF0208C00A0BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NdSFdl8D1J/KNdb1Jw2n+dBp1hKcMzyIK4ShqDiJjW8=]
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231113022400.36203-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb3733d-91a3-41f5-91e5-08dbe3ef8125
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGTDLKvdumGcnYWbLifUJ6CT7wHFGfj18s3C7bXy5K1+ZUvNDeKUVdxXzYO4pBxyrd9ERjtUkSJqzAefd4VUCQjhvQgreidfgDk5W9XJUnlFvPdStkXPlxnMpK2qLc6NBRd78WUEy2FBjACVd45zpkPb9jFPUIfBGJYVNhg3pNy75vGmgYyTqySWjxNcf37JgDWvRMbeNRHRx1AkWltt2AaEt6KoaDPt3uzqEg1r1K6EbROlbnkcwHXqV77Zqkkj0MUdgW7Vx+d7FnUWinTvPVAYnpCwNpeR9b+4BomyTtdey4fv6yG0lZ4SX22S68vcbQuPaG0RpWkNQWvBHgk3OtRyyF8h0NVdjGHYXEJI8z75pVmhslhAmWfHP1G7WSNG2IktQT+vseij+XMpxRxrrQ/uNt6DFBi8eL3WDv7jrDCT6YjAav+CvfRzAQkqAXw2bgyp4AsayZPo43mY46R+sWLVe5uEQ583uOQHDvd3Shv+0K4oKUas7daKhTkSf1LgQ/ARsxUZ+VI6lKbTvKaw4+jfOAv0NgJWYMeUOtlzAC3YqQFPAzmJOv0l+jCwDcpfmlhAzAzeOBbdJEP3Jb9tJZC7SpxkmVKH+07rHDNV3DI+G+JbYRMcAyycjKQcQL+0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nUHZ/ow1OlEvByHMSJMkXpxOjs5FP4FAhEjmF4CR7DJOX65CfEW2RA1Agch0?=
 =?us-ascii?Q?qOeGwZWClHg7U1T+sMamhq4+QL8JxN6WxGOe25cF28rKNdqGBWUPkpQA4iX7?=
 =?us-ascii?Q?9Eo3O6bblbjcon8HujoOnKZHHuN7anFweI5snFi5dBRVT/DccAJB59WaDi8S?=
 =?us-ascii?Q?ZWmPx+ShVaxfny2jcKLDOeGTG+/aN7AYHNUjyL+RFS5PPZw6xTsIyZibbxi4?=
 =?us-ascii?Q?sTMZa17ZzoASkEju9VhbafaZ6rlqBsYHLODksPTvoaCwtZhwgkHzvCyZUacJ?=
 =?us-ascii?Q?ULfaLMtGId/oQbdQkmMT1QkYYS0COb1RZa5KFUdfkMZSy5T8XGdWFcRW0l4b?=
 =?us-ascii?Q?WFYU0y2ZLfpksSHaKCztYIWMzRi7MEF4bK5G9A/2YqaS1x/yyEXkD8Y3umrU?=
 =?us-ascii?Q?E/NOlutrcGNySJDnjWRqgyDBHbP9HlVOEO+Phn+bFmc7A8UU6QapbDi3L9Kr?=
 =?us-ascii?Q?xaHB9Q9VJTghEWtIX3GrdFOtvfMX2DSvjrj0UUtNTX5Y/ym2kddk2Db83S20?=
 =?us-ascii?Q?JRjV2vmqdGKdLWkiUWWjvXK5WMTItOi1Ls4y2lnVUTNV7Dxnr3oeWW25Gi67?=
 =?us-ascii?Q?INGsSWnz5Nj9gzykQsPl41Clu0C2DDGBit9jk0j1Ry8vynZpqkpczsxG3lfn?=
 =?us-ascii?Q?ZwCCSg8NUcBihWEJmEm6IyEU2c540DrkBYeAbQ27aS25SJRlmMUQS/iovR7A?=
 =?us-ascii?Q?nWRzSutmrnNAUS8skzkfTGJqTglaY9HDhjxyIflFQeP6JQKCExV6bbitwARi?=
 =?us-ascii?Q?/K+KcSwAW6LeOv2BbfSHNYNYoSDcLxSVkGos+/ZS5HsOVgXsgh+6pMLjzeoJ?=
 =?us-ascii?Q?uvFnd9x3doMaWvHTvKZSmmYoOfjnOnbX6rHV4FwFxTolXGRiKnlJsD6z6dDP?=
 =?us-ascii?Q?4MZwQkiglS3WMWUUF/iRho83MfWXWC97PlyJhHpVNTjGaB0LNHqZuy595x7/?=
 =?us-ascii?Q?4wGgS22wY9WZKnTUTg+UbDkpxHR/8W+BcI5lUJX0WtVk/vMCz71b5PXT9RC0?=
 =?us-ascii?Q?kfh1I1re9ERrHZhlKAxi9AadXe2oXrWR/px7+H78Dhhx8XniBRbxudK9W60w?=
 =?us-ascii?Q?cn6fB+R4l1K6hEJMlUlktNncJdw1Cl58+yzzvOQHlZA/R1T3AuxeZlcd6yMO?=
 =?us-ascii?Q?K+3kAr0E4qsLoxEP1noIzzUL6MzLUdme9wwB7if4W5Azz6gT3yG9JtKwJHn+?=
 =?us-ascii?Q?NkktjEQ/Hb/mFD3/a5+KZpj5YXSzbWpePVnW6eVjGFmA5cn2+itPr3fmCjg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb3733d-91a3-41f5-91e5-08dbe3ef8125
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:23:20.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make thead aclint timer more closer to the aclint spec, use two regs
to represent the mtime and mtimecmp.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005738.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
---
 .../devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index fbd235650e52..c3080962d902 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -17,7 +17,7 @@ properties:
       - const: thead,c900-aclint-mtimer

   reg:
-    maxItems: 1
+    maxItems: 2

   interrupts-extended:
     minItems: 1
@@ -38,6 +38,7 @@ examples:
                             <&cpu2intc 7>,
                             <&cpu3intc 7>,
                             <&cpu4intc 7>;
-      reg = <0xac000000 0x00010000>;
+      reg = <0xac000000 0x00000000>,
+            <0xac000000 0x0000c000>;
     };
 ...
--
2.42.1

