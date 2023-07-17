Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E14755B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGQGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGQGPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:15:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6C1A6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOYL4a/b7aVtMAkJFxGlEegfO0aDCTD6niPlDL8CnzKccoPe7T9Blo4aC7F0urQOYs8WjI6AXd/GH/cSnEk+zyvZbRuJa5ylMKsqE3UTIciME89nFRKRzau5JK5k2wowd2QRkffsERkfUcSh32Qwpn/ViHKIThcGMrbGODWWFjB+IKQqD1qlZwjFYA4dEYiqhs9Gg181j0mMhztsAHv7+9d1zCA0Olq+Sm03S/api44o0Sv8ooaP2+EcmnN8EVoJWYodecdS958MxToLkLG/OMQIssFgjWUWgWFUUWxkIuEqmxVADzXPujLctZ/RIYx/oHL0tH+4wCsURZUSa+TWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEhlvbwrUsGUofUuqdXlGdgQzHw3nCP55vpDUn+YU+Q=;
 b=QQHThDqCICwAdxP/AdMcCa0yQsGypO0QzgxBoHR6nlwueoyPRm09SGSCspKUJQE8T4KYUzwPLcP1BCWCzVg3kNsAJUNoPuf6OgIg70GegW+tFihdF4CndUM62UwI5Hw5VA/svYls5zWVtii7VCLZVbojenzFkPsiNb/X0T1bVe576cZEAFm1qPvCa9ep4kIgWYuAWUtuAlh08xSEWiBAQhPdFAil1bhsi/0VrfLf28Px+Uj3PXM5bUj9CsRIUResOMER0p4WbjWa0FMaFHFPkm5ohemvOMuh9y7NotslPQ61gVhrrbuZ0yPK56EDmI/pNvACav737TOwlaO+U0dUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEhlvbwrUsGUofUuqdXlGdgQzHw3nCP55vpDUn+YU+Q=;
 b=asKf/ROAGk0/hVkSr97937oNp5JexCo5cKDsvv+b7PfSEYon8euLLlOPl/YhFXZH/Y/Yj53py7rpYPKrN2Nfe0bJfvJhh5SZGEAZhzVlTRT9vgwX3YIeIO6CX1Ut1NYcTsT6SFR4nmnn85i5Fi2bp3wTqAjGVESvNkQoHDy/d/hm2mVtrGqgWisgsNpOjX6RZPhloXuJgW+HCnPY7NwAZNB7rCs2n6pdp8zuEboEPJr3ez6php9nWaUYybnsXRNVHVHExHRuWf2n5agBjAZ1z6rM4Z2Zpdjg1aaAkILbqWDSiSypa8CxZptf3PaZMsmmvUk0CAWF673V+pMf0ozJoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PSAPR06MB4007.apcprd06.prod.outlook.com (2603:1096:301:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 06:15:28 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 06:15:28 +0000
From:   Wang Ming <machel@vivo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Gong <richard.gong@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v3] firmware: Fix an NULL vs IS_ERR() bug in probe
Date:   Mon, 17 Jul 2023 14:15:04 +0800
Message-Id: <20230717061517.17072-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PSAPR06MB4007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c779b5d-cb29-491d-4ea7-08db868d3798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tadCjCQSzsl9T+ImKWe+qbztxJh8XoGT5Isi0yI18RMLuIvuojrkzljAU0U2PMhDWssN6xecRo8EDdW/5cXK0gjSd01aBR/Q0U/xWzON0QH8OUlITO8rJqLtBthxnYaSDJeZ6L5e3erzpEvvoVbHnKMEUWUy3ycVdbvezKDD6vmBw0Vzlg9uBDjwrexCMCU5obv9LLmSPImAd10w+TKaqivRO7gd5PrbaQkhYVQbX+k1KXq6RP7hf/xeIxrvhmE88Hm9AaLkf9p+doU0aY3QaUla0mEG7qlRoEzoFK+bkkLcYmK8MxydfLym9Y0+g9vI19VXoTnIEP6RZihk/3SxWd5Xf0ZRzvQ8TNWLG+th9ze2f59EuJE2CYaXULtqr5z6pdMNISrqnyyUGQwxzIMuuxfEM60yB7ONClZFb1pK1bkwf5j2QE/YutR7nZkZnuvqLP6CS77TKY/qH9lzRyFKRS67i0ogWERAcVmIHuruB3kfp0Ky1hRtmsyaNCXvlSNtLCc2GU+7aLwYCgsUslOd0O9TRs+aAsIr2GnnJJktHXvy7I2OkxV8FoVhYMrQ2fGsGAETFf55dSM0FuKE+1G9W97Y+pxOCoUW8YTbchNwBiUPZDNNhom9kITpa3ueYLBu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39850400004)(451199021)(6666004)(110136005)(38100700002)(38350700002)(6486002)(52116002)(478600001)(41300700001)(5660300002)(8936002)(8676002)(316002)(66946007)(66476007)(4326008)(66556008)(2616005)(186003)(83380400001)(6512007)(1076003)(6506007)(26005)(107886003)(86362001)(36756003)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PpZpcctYGB3pecGU2vCx+itGRuYuC4JWYY7w8gyBlD1SoeY6V3QG+jYzpRX?=
 =?us-ascii?Q?0irH1780vHAlUrUQ3LGpwxmxx7EK8UgQIXhnOddd1RFiPOMQbsCB2DZxVjNU?=
 =?us-ascii?Q?9Xn4z5gSTNIro0PPr2HPoX+ABqSyTLn2ysde+VtBhC1ZHvIRn3KeHOtBAE7W?=
 =?us-ascii?Q?17uzNIwTWJWk0egkjZ8jJB5PjQnEbK8pYD9yEhkp+mgBQYqD2Nll4tQ7QQe2?=
 =?us-ascii?Q?1rYs+y6zXnKDWwA7XjMHDRHgE3cs/zagJ/elZGZPhJUVYtDX2wRsbRNw5VqF?=
 =?us-ascii?Q?M3GyuNFluHW59n8gxNB9JZeVK9+wHGl1W9ZJepXiCCzKIaU4qiifoUmXZrpa?=
 =?us-ascii?Q?JxGrp/Ack6FH9r64adauR6NoRZMD79iDVA4ANLGjjbAJhgtVf9OH71yyjwl2?=
 =?us-ascii?Q?J8Gc6DHHOnBeT4NYsuLuSVNL+mj8QOhLrxA6FKJNWjWM3vXG8KpBZViwdBIC?=
 =?us-ascii?Q?RTlFJc2bSDkWNQ4hrILcWUwLH1yGk1qHgpL3bSfJRxwClzowP2xGxEk2XGA5?=
 =?us-ascii?Q?356Mblg1akW5fIic9OMK05diAJvtH2plzwDArpPYw8hG/6D73/EPpkwj3rYP?=
 =?us-ascii?Q?9hVGkSEMMNJCsvkKEksUOIIXpL+6xis05DPZ4FtMpsjLFIJh1SKRONSfy3U7?=
 =?us-ascii?Q?IKP7CUF8YMvGm0p9r7VhqeCQCO0NxttZN5RD64Lhr07ZcVcmvGD6xWoJRCU2?=
 =?us-ascii?Q?LAlAcpcDNPj6dJm0L3BT7nhBOjIW9xrxL/53n2ySfJmKCLLmLb3UavO0Fu1G?=
 =?us-ascii?Q?MK1eDmfh9UJEeIWEDB0avstBlM90kfhtGezCK3cTEUienL2AvIG1WJWWy5Wj?=
 =?us-ascii?Q?5DcBA+2i/ytqqLLxdl1WBUC/QykLiIjIkuLHn+KBT75QhwL3qcYMGQTyU4jP?=
 =?us-ascii?Q?Br4tlMyct8KwOKvVsmrWcPvOosN2bPwFgiCiIm04JfhNq4nTCwg0fFv/z0PU?=
 =?us-ascii?Q?W8CtCJWh6u0Lnkjo4TePMeiaHHUUj2B24BOxWNrHsw5rel9j7UY6nqdzL3Tw?=
 =?us-ascii?Q?WkiacuZMgL9DrAUN7sT1AhaAghfoQaVbVZRs5bzNd7Dr1kl/jcImQHz8S4XO?=
 =?us-ascii?Q?TU+L2fgPTaDBgY0FMnszAJaNdgYtbCTjT12K5+utDFYuhUwosQHawPwOuDr0?=
 =?us-ascii?Q?zF398gfkC78CNz6kF4oo52413whL061u8jrP+yJbCQ8oRMMui8j7b2IUa14V?=
 =?us-ascii?Q?MWVQFvrjYvwKiwW6uIuJcVe+NmRLTHklpOXVUscvRESnE6UxnDR9q4JrWxYR?=
 =?us-ascii?Q?j+v87tUPUFu1fpgV3SE0KDanvuSoVL6d7edvCeW9bdvNx0bo2fTTKze8sBKr?=
 =?us-ascii?Q?u8gUF5ty1NN0NMtnjp/X87Q+J6x18+8jtwhIg8gEcb4kBAJ9YdTVe5fLztKk?=
 =?us-ascii?Q?0nrsEPnd+xj9XySgNxxdDVWSbIKx+fyvO70dNhnfLvnTNazZQyxuy5dAytL6?=
 =?us-ascii?Q?5sCKtuj+/vX+4kgawGf2bumoeI7jk1woeNM6rs7MdrLsVspeu0pRmUXvF9kG?=
 =?us-ascii?Q?hoG3iJAipUzxZSb8IpcNNg126rl4nJ5I8b512nHz/9dagwZ/nSTIuJTIhp0I?=
 =?us-ascii?Q?V6fgtt1h+Wzh//FG477aqLY6Y+2BAt+dpQOfC3I9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c779b5d-cb29-491d-4ea7-08db868d3798
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:15:28.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Qgngu1SfG1sw3fVPAtlbOW4eXq4x0w0TsWRV4dpxAs3xcBNEmEmIYhfWvTy7LXJNDvZrAo0MxTnLargrqaFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap() function returns error pointers.
It never returns NULL. Fix the check.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2d674126160f..cab11af28c23 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -756,7 +756,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.25.1

