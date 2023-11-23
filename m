Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCBE7F5EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjKWMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345252AbjKWMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:15:17 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3BFD56;
        Thu, 23 Nov 2023 04:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+2jiqE8R9ZGKAgRsjUUTHKYQJFAsSgLD5M4qpFGVN4AFWs54gRykB8hS5j5gG8ocm0iNWk/THC2WUowiZEIr9A5jIfB1EeKPIT9mF/OROnqKkvEP0BCFapEw9GvkYgygQhfsmFTdn0fsepudcw3ASqOY19PiKvdLgnavLiPsR2nS3tPUkqBolY41fag3WkOLVh3CJMyqgEtmhjiMTnPtYQ4qGu7lC8of3xwMbR83HuNYvtmciyV7L/jZElcbHryuczhIaCU2ZZiDxbeDZ3z+ZvXyjvrX19rJN7hRnaRQPN0b0EtgCSo9jlFat9ASX5YPgYL9EpZO5o7ahc9OT+Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT1UHAK8mf2BxFRMKPA7B37sIWgCMnP/9/n44FUcXBk=;
 b=IM6FVpC7/Oo3KQo85jvEcDsRbs/nry7WtoUpYg7RmnqSFwE/WD39e80AILzjknzFJCDvgh6GVENl/IDrZZscq4lyrrAJggaSbfF6wioGAt3xljJUYfEultYbM5xLOAxBsmTGYAhKESILaAePNYh5cYuaX+5H0yRR7pYeFhp53vRDbw68xktUmbqxgEa2i8L0IaBx65+j7U8P5z+mF9dJFNjE3JPJ3Bc4ZpjCEOTSzkTdzO+r6D1hiPq+pPfOJHtPW3MG8+tNgQckyC1YHQTYA84hNX+QDp41RLAT1RLvBIjd8WtzUxAbi0SXK0ii6RkWqZPcf/0OKSAd825Oy9GRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT1UHAK8mf2BxFRMKPA7B37sIWgCMnP/9/n44FUcXBk=;
 b=HiXFXGOlVIR7w/G7VTO1+rYfIQfMsQKltI8H3C6J8h+EWgAYkU8UgMW16nK6nHjsxgEIT3HSrP0TW3BKN1EBK1ab+0hnbbTnMwX+CQylwxlSIo6KVypF4rjbP9FwW1QrucvbfXqVsGZt1hLir3+cQSJBFPL9wmNt2yqVM3pToHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8423.eurprd08.prod.outlook.com (2603:10a6:10:405::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 12:15:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:15:16 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 23 Nov 2023 13:14:13 +0100
Subject: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
In-Reply-To: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700741701; l=1046;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=5nCO7JT4rELhAOOidUsUPsNZ2GKEnGwXx3JdX0dzDQQ=;
 b=UeEC7LCJswlJVl64pR16sDF8op2YugDv1KeanMbaonXr+v5Pq1wNbIKTv5zk8Q9qoUJ2G3Szt
 s2Q2MpIVOLtCRpLd2dATlMYGcb+SigDPkFkFJNm7VW9piKpMjEcszBg
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b22efc-0458-4139-1fcb-08dbec1dd2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0BUUNwvy1j/IDnejKD9cl8+cKbzQKEgxe17dS5Hn5jU/5QKGtO8qwvirM+1rExlV8vgE8pwwLkeDlhZP00ThrlnuSypn3OckMZPE05a/9Et8r2mWPGz9/Y4Tv2NPmoeGt8eALL7E7TSS4Ef/haEELBFk3UfaN+EM/YcP6BaXwa1FEZboHmNaG/Zpk0drbwr3AOaAVLo8GUX5FPdF84Gj5CbDA2UIw3bJS2i/2BNP4bZ1mPn0WsuB4K6yGs59c1f8G/4TapFgarPwnjbQ8ZVM8MwlKT0lFPiN/1Af0F/tmADCyd82ZLLj+v4OjT2cawE7VjN9BPg9qs1C3oEFvtUEw9ZEWUPq/CTFzS0B/VmdOt7jQHqcM7RWSXTnWxMyUFgi+ssbiD0eVKjSL9aDAHpLvxkr89hWWx2HBMD99JgqNtAHKZUVg7BotW8zJaG5hpmFSebQGlhLKskOUhF9+2a0SaYg3k117sqZumbAmjX0X8wtpOG5hv4utdjtN/1tOcCULYTqIBopmCLI3e5YLMHyiJ027B07YdwNPwHW0nU6YgLCNhUPNPO0mXTpR79QY/b1Z8wdyQd3RZw/S0soJrnoIrJuS+HFo7Aw0srSsX35safGo/SYGQOUoZP0Zt8dCUb88bYwm3AH0MkxcfyXSntCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39850400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(921008)(26005)(2906002)(7416002)(4744005)(38100700002)(66556008)(66946007)(2616005)(107886003)(44832011)(5660300002)(41300700001)(8936002)(4326008)(8676002)(6486002)(86362001)(38350700005)(478600001)(66476007)(36756003)(110136005)(316002)(6512007)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2tJV0k5WDdYV3lxRy9mSlI2KzFIdDJ3V2E1N3lEQkQyd1pPUHFHUCs5T2dm?=
 =?utf-8?B?dDZNeDdienZQaHh3eERHWnlWR05LOStyMnNKL3ltOWpmUUpIVWIzZFBjODR0?=
 =?utf-8?B?R3pWU3NqU1lERENJZ2I4UDc2cFhBamY3Qm9OOG1jcm1icHVsZ0thQjN3QkFI?=
 =?utf-8?B?bW15QUNHQms3cHlEVVZLREMyNG9aM0NJL1hHa0RCSFFuNnFyOTl0Q0ZnT0lt?=
 =?utf-8?B?NS9xd1RjMWNMK3poaHB4a1hFNzhKY0oyUHFQVzNLOW16dWROUlh0dmVGUHdu?=
 =?utf-8?B?Q0JwS0pNQVRIenB0clplQmE3dElPMGRoY2tad1lpWlNlSFZKS01mcDh4TUF5?=
 =?utf-8?B?QlZNdXpHT3BxaTVxeDlHNCt4ekdPZHdDVFRwYW1FcitvcHJhVFk5cFlVQWto?=
 =?utf-8?B?K1JGS0UxaC9ndEhNZTZOOE5EZ0pqckRCWFJsc0JNN2FZbm5yYTlibUVsaVVO?=
 =?utf-8?B?cWVxbitxa3kzREo5M01qOVdFN3Ryckptd01wY1pZK2tlNUxublNveHhtKzVl?=
 =?utf-8?B?Wk9wZTNmZUJISlE0c2VSckRubkVMbm44TnpnZDRoSlJnYzVFT09ZUG1ZalNM?=
 =?utf-8?B?dW9QRk03eE43WnVXK3pFY04xbGtFd29sOHJKdWQrSE5HS2Y2Q0pCSTRFMyt6?=
 =?utf-8?B?cndoQ1MrWVhLZXIxVGxTK2k2WURLbDFPRWVyNk5pY1g3dEtOTURMa2hXdFNu?=
 =?utf-8?B?MnRpT09TcTVCSGVaU1JKTU8zR0tDZDFCQ1BQckxzYytsaEZDY3ZCRWhReGVi?=
 =?utf-8?B?NTdCNTUwSVVtc2w1WiswdG43c1dxNUJ6akJuSHR5YnlHYW5IRmhpMkVzckpL?=
 =?utf-8?B?M25uc1ZTSEF1UUdiZUJaeXNHQTlUdjhaY2hqTm1Ka0tNVXh3Z0ZpUXk2WnAy?=
 =?utf-8?B?SzEzTDM4VWNHcWtEczlBSHRTZnEvc2J4SXlNc2FrcGtJT0dzZ21aVzhDMEZ1?=
 =?utf-8?B?cXZEd010V1lFbFhtdzVNKzVQbmpDMTBDS21QRks3cTdDaHV6dy9sY3pweldi?=
 =?utf-8?B?cnVzMm55cmQ0bVJxYzNPeFoxNlkrZ3hqVlNtUnhLaE00UUF1MWZxeFZPcXVH?=
 =?utf-8?B?eldMejFBUjJDUEtCY2w5OHhZUTNmckNnakk4V0hab0FVVDZIcklXQ2NrK3dq?=
 =?utf-8?B?aVdBcVRUSmtxcFhPWm1Uekk0MVgwZVZtRmprKzRxbStUcVRkdUV6SFE0WFpR?=
 =?utf-8?B?MFNFVmhvWElsY05uK2QyYUpVRWt1NnRpOXdlbEtPOEttYzZtRGVGSkllclR2?=
 =?utf-8?B?WHV3UkRZMi94V05od1JzZVRVbDB1QmJVaXJzQzBWbUtMRnVWM3lDVVhTakJU?=
 =?utf-8?B?WEFFQnVPWnI4SkpCdkl4bmw1RzBMd2tJYWFVQy9rb2hXbnIxRFRnL1FFSFFH?=
 =?utf-8?B?dmtIWTN3b1R3SWY5ZUJkSkpHeC8rWUM0dFJLZzRzbmtacTdSVldlS2R4aGRZ?=
 =?utf-8?B?RnZnK21VR0dSUy9GeWx0UHpGUll5UXBETVFuTGIwaFk0ZHhCbmMvbzJhZjJr?=
 =?utf-8?B?elBuVklSTm1NaWVUTnZ1TW9nWkdVVDRkSUVvdFpqV1p5WnJmT1ZGWUptcmpY?=
 =?utf-8?B?QnFkRTA5NDhCV0JaWEZpV3hLMkdHNEtOS3lDRHlMMXlIM1ZUTHJWV0RVbklq?=
 =?utf-8?B?Wmg0V2xFaHUzUlQ5ZVVHUGpBZVFxdHdNVU9jTTlkWjhzNzdhK0Z4b2pWMmcz?=
 =?utf-8?B?b0hqNjIvdmpvZGVvZHRZRGQxc29ON0ZoUzVNVmgwaEFHQXJTbDV4ZFFJdzc0?=
 =?utf-8?B?NGl0bXNXeGRUNk41WWRBdC9QV1NUWXJNc2h1NW9GVUFBRlR4VEZzdlZQUm9O?=
 =?utf-8?B?bDgvOGlNSytGN0M2ZGhERTBmc2JtZ2huWTZ3M0JxOGlvOEJ5WUtFMlc2RG5k?=
 =?utf-8?B?aTFBelh3Q0xGWFprYmFDNGJhR1VIaDJtSkdmdWhnR0xBcnhpbVdRR0VOQU9k?=
 =?utf-8?B?RjBoNkE5a294a3FqenJ5QXUzY0xYSEFvZ2Q3NlBWbDlEM29nbHZkN0NsaXhT?=
 =?utf-8?B?SmZWeFNlbnhmNUtHdTdIRWR0UFcyZTU1d1d5Qk9PdU8xRzB0ZCtHMjh5Y2Zm?=
 =?utf-8?B?WEJUY1Z5K0U3UjE1d2ZEUkFYak9la2YrL3Q4NDcvVkhNejVRSUgzc2dROEpu?=
 =?utf-8?B?ekdUeXhoS2lYOGQxU1pxQnNqMnhhUkhIOUs1YlRPRnpyV0Y4N2xNMmVmWDV4?=
 =?utf-8?Q?83fHJtZ/f8+mljdiyjdqyCQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b22efc-0458-4139-1fcb-08dbec1dd2e0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:15:04.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ueja0yb86HgygVWt4v+g3oDWA36hJFf81zeQcEDqnTwvR2MwIc25sIVAtwYW7+iomSF/ilT0MISDiOAq9KZjAtAHoSRWNseU96paf2EMlmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property defines if PHY WOL is preferred. If it is not defined, MAC
WOL will be preferred instead.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 70bbc4220e2a..fc4b02a5a375 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -91,6 +91,12 @@ properties:
       The phandle of the syscon node for the peripheral general register file.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  rockchip,phy-wol:
+    type: boolean
+    description:
+      If present, indicates that PHY WOL is preferred. MAC WOL is preferred
+      otherwise.
+
   tx_delay:
     description: Delay value for TXD timing.
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.39.2

