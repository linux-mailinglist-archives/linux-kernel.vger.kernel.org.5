Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA97763559
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGZLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjGZLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F82D68;
        Wed, 26 Jul 2023 04:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7WkFC/0FlHRHerLqzYjQmDKhhN4DkKG0J8LENhgmTVp/el2vs3nv1N1YRbIV8ecJKG6OjTtSgRF3Esov7URjtm9wYpQ8azk/TyA8N5itfDnND2rlJ4W0KbzlGjGwVQonGpuojaY/BXXvPq2ST6tTJcJ3L7UMyguMcgocj7hySmsNzwhNHL4DVZXfgDck1dIFjKGqS6ui/Lk9Xr2XbMa2e4rDN5JHIUZM12Nip/da8fClYK6kRcbt/05NqKLgY7difJagRh2mDgvq0Ecbtfu29Ui9J7H90U+C4p5/I/fMLZPTTW+LVCwEg49FWkYeH71NRKaTb+QXicjONQFR7PRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLa+BGyda8V9euB7oiXve+U5NKobynlZzi02pY3wUuo=;
 b=N3kbcLH0iFeY6fFvYlS2jMpON4twDlRe2/8OdRujCTgbo24t+0I27+F4wMOSV9LChuE3Vd/WWVYWGLEtray9vqzxflDjdhkSi9zpNQoT0xE0kPb99h/ueYu5xyEi1nsHwU3IIOIsWe1b4dYKYK53n8emApFQP3g0e03tBvPJUnOh5Jlg7ELpiExhjWTZWA9pBzgRQV4bDZ1WmoU5Jxx62pwthiUbpRjNMwk53/mNIR9uZDEcRWUyN6aivTx5orfduA7zrY2JD+gbRc0fg94Yzg0a5put/DEAHfXsyx4m3Ja1t3Y53VVzC/B8tXC59Dqg56EnC/9AOibDi0liXOz84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLa+BGyda8V9euB7oiXve+U5NKobynlZzi02pY3wUuo=;
 b=JGKoPrhwsUp/CcgI80Ppip1SqOOjMaH2JJf6KuAPlR/juMiw8yUUcASQPCI645dlq2dGmL+/ag3smzK8V7yEdWwJy+Vd6zifosbrpZ2j9IE2qM+ksqws3ySOrFgPzqYJnfaHxQ7k7b/FQz8XMfaw3sK/RaTttGkfonNH7dkv0V/3guP0xSlBhcel0PSofcxWJUXseL6jXfkMA1cMyoLSFPrqUFx3MH+7SiTF15uYeKFhogLJ7HnUOsYgVQVTTpEumM4USfzqclzWPBFDVzuZSjjqVJZmWtjAXmx3ki/hZj7z+fy0CgmC3lspIaJEh04cACkOmKDdcdbl4FNXKmEUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] usb: ehci-orion: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:06 +0800
Message-Id: <20230726113816.888-20-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4a91ce-dba4-4eaa-e905-08db8dcce5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsEgyPCVRf/vQ018vw2dNf4xEwraORzVah57eRxBz3zDbIg0SA0xR8SqeRtfXkr1d+YTuCLV5grA9EZs4sIfkVztsWuzMo0ucvkutUH356um14P6DfzTILbddBqsGHpE4rZ2Ipw08v5Pv7tBAIk9ObKob9wKuAU7HmphAu3B6QlHXU3VsWcko35OTF9E83BUG4V0Bd/h+tQC5akgB7NdtMsgpkgZ4+tf2GTaFE31/EPcIRPuerZhvKdM9fTtMVzsvAU5mySKfljQe0HlULpVZUDCVyofz9M7+THkzffUkW7th4zfaa6cb9ULWrO3X1foeQgKSXX7H9ikwjpaP0fJ/f2NAev6vskd9hCFPAC27BaD/aauEA1MYJakcB69KB8lvSIcjODpOcinlSwsNUjpBympRHLycje6nkaWmthgbEzoSy8OExWxE0j+ftCpIHEqEdcJZRieKAquutLjbvYsbfKzR/aJSODirhNi9zvVOxD8YEKvP1rvrSEjq3IiuERN46ywx3p3JreObCGdLuGlYYlplR7zglQxcgcdcsYGP5EPBoWsZ6fKn2hdSYUTa5TnkXg9IDeRKf2crJXX9V47saurbBIgEZgetkWJ229duNkE2WRVIDpFMy2tda8MSK3G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2r0XdiGWT5Vp/KpPXyyvC9sf7GS2BMQBv9aC4eIkUppDYMs56fTuI9Y0SFyZ?=
 =?us-ascii?Q?xb482NoTUG9m47cDXKkSwhnyAFx9ebwr7w4y7kAHap3ZqcPjNgK0AlyrGqFv?=
 =?us-ascii?Q?Z6MIaB8YlebYtMOghe5YA2IBB6mFxFkHc1Vr5UfSaCE8uja9zWSjuD0RykZa?=
 =?us-ascii?Q?Be+ifPJiJ8nWNg5SDlO5KozG7lziei41zIM8r5VJ6vHG0lmoz9y8EhVrbtXJ?=
 =?us-ascii?Q?6h7slXnXDPyfBC+iDG4/yTDr2cO4RXBAIRFz6aFv1TDc8BuxY1cz+0rEHwHM?=
 =?us-ascii?Q?BolRvDj3doYit4aPspj6z30iD4Bnzl4EFCfSxI7EkNCQkGIaZf9N0D7GZWQH?=
 =?us-ascii?Q?bsxA07Hmjzbd1v6dU6PPqsIrvmcfQ/TXnhtcP4SlAWGQ+jr8YIawCewRwZh4?=
 =?us-ascii?Q?NO+q8FsDYPS/pkSuAO0BWcfiHG34/TR3nRIS5s0g8P1SAWQ9n8TTDG+W3xRO?=
 =?us-ascii?Q?Miq4F/Ij/fCDBzTBo8knK3h4kXbigt74NRBmUEvpYpSWJXU7V6VfQCn2kAyL?=
 =?us-ascii?Q?6hCO8I8w40VX3mXX7qdBd57EL5hexQVcvogNY6T4BNh9B5q+bFgFLIObhGrB?=
 =?us-ascii?Q?YO9vOdW21uz5ae72nY/xxluVKLV8K6fQ2RaFKz6VuYo01TvCDVGJxf0nFx1h?=
 =?us-ascii?Q?XLktyBArOehDKR7lzozXems/sMy9ICiULCFiBJw1fZNKc6QG0C7Vej2e5gbM?=
 =?us-ascii?Q?bKDOJTZJ4d3u+cfHPPU6KxqJNgBVwnPw7vPdharf5yZYY+OsNAA+LnSizs4k?=
 =?us-ascii?Q?ihzsC0pIcBRG3lEq7Ciik77dNnJSBQO6/97mvLKWQCONd0J5bG/v9mYbgWIt?=
 =?us-ascii?Q?Tdb7xhHomP6bp6plwpv5Mdktw6nNmJykdZiAm6hqIeQa4YMkaLZw13RQeuvk?=
 =?us-ascii?Q?M/cFEI7R79f1HBeVvQizQAYD1lJ3uWCIx+9eGKhZUbCm5ugIpFT5rGRYAu0G?=
 =?us-ascii?Q?GE+1mailJhCiIPgUa6t/rYSUqVZ+ZldtYQCaETRrLKOCG2B3JuT4xhQnf5xs?=
 =?us-ascii?Q?DFAI6h8FYUsaih6oFJR3rheqQRqGiKd6r5KsghdONvYjtMmfnt/hnAfiX4Q5?=
 =?us-ascii?Q?D3eFsRcmO2H4hBKYhfnemlwDgiFLVkCwts5ktSqnXiNyNTQY+b5X1dc53zo7?=
 =?us-ascii?Q?gWMHxKA/asApfmAKpEi6Pd5gs2SL9p9BwaSyr3mlS+TTRXkopG7HTVqh41IH?=
 =?us-ascii?Q?EIMdySU3vNGrTqgmwA+3oShwvoz8XUZV7NiCcK7iCnyVG9Md4naUzzg0eGg6?=
 =?us-ascii?Q?VQE4J7vR0qbaQQQZPbCELQOPKyt/JmBGAeV7MP0U1xcvdUCWW5oXAsniSDGZ?=
 =?us-ascii?Q?FKN8Zz3feyLmwUtLFynF7d+ZOciDvfzmtzKlak3DX5DHT8qhMnisgvQk+seY?=
 =?us-ascii?Q?HwWqTyKbPMG7VsJJgeqT0gMFE+5Y61GI/V/SFpLUI5+MCm7LVGXJX5gHG0ks?=
 =?us-ascii?Q?bHNfZ2v6tGKmiI3iuCtpinbX0nMivwpXAZqXaqo7e+8aApnUdPM2yMxFCNxu?=
 =?us-ascii?Q?j8gmGLyKCDsADTTzvSfAqXCUQv0lkbx7hiJeXZ4LYGRXotFqtXOK3KCQEOcY?=
 =?us-ascii?Q?fLWr1DMAn6huOQ1BaCbqADO2nf4fPnQH0gWS9hGB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4a91ce-dba4-4eaa-e905-08db8dcce5fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:57.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0461gaBoAGDOBcWYPk2sIQX6IiwW+xWyn8/OE26phCubgz+8rv/gXu9Mx9NFBXbs7R59OIVi87aabpKLzUWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-orion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 2cfb27dc943a..e0cf90aa3ad1 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -234,8 +234,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	if (err)
 		goto err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs)) {
 		err = PTR_ERR(regs);
 		goto err;
-- 
2.39.0

