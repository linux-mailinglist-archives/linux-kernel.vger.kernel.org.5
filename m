Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E45762A09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGZEJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGZEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84B4EF6;
        Tue, 25 Jul 2023 21:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFczwi2hXSXjs+rMzgVVPcrTnyWzZx4LX/rX7K0BC7sgEGmnyzpjAXa4G/DxLo8H3jrzci8GKt3x0tyfEsuZPjM9GiBNHsWdGQtSJ8bUgLDAdnzIL2lkM7gJ6Lvhdn8PplqEZXd0v8Xoznkem4mHu3dYFwsw9b4PEx+D7T+knxzeHzOBEzb79stIv9krZ4X7cpgOAMTHurvnq+s8ZKAdhb/Q9TRHTq+nPEa4mY5xJliUiuzYVNrgdZtVz3DDrFCNIoRMBSe2IKZ39wpYONENP3VfjH8o3knjKHPUX0XILfhbq2UCQKaf/7Iay5zVnPMjUBdKX1NpcXaPihRJZb/mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=lATzebIU8ItjI+ErwlKOEoaT0RhJdGIyyZN12hXevqmvSd9+Iu3yFaTFc3IRFB/LOX6eOzAjP4vt6G38zLwqufsIunpORisGDWbcL+X9RmwiYgDtupADzFRtOyxoZrpzgIPO+oAdz59Ay7KEui5MgO0ivW+VSv5wa8ems4NlVbxvawI82CCGUCvchgShD6qEaab3RPs+9XUdWyYYmQsHWuZ0Nw5V/H/5lJ1VchKUEONGpK2JkKE3rxDWgEJhBRi4l5vkkKt5KucIQa3/N/RpjzfjFbqA/+X+kB77qkLey1aODfI1V6mr9PGs3Y5Rn79+5cWKBNWQ4vycnjTiF5rkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=ddaY1C6UIn498SOzE5CllYImmyx8vRMeXj/uJa3qdxlsc+pIKEl6+w1cjI75yw84OGj0Djxuxq8VYUEDg59jLJ+tyQm6VjE9olef+LEAV3NgOriwl4u0dALEfSm7jjOZWwmufzdAfMJ9QL8R3w/maApbV/KZfphMLUmAe4MH08dVimPoS+75qSAwiY751bAUz7Wwo1NWM1QjZ693p/tfZLjE4hRWOX5pafB7aFBNktGGyLWyYACGQL/m+1mwl32t2NMK6bRtBz/zE8lKuP2UUnEZGUdC9Nhm0cFWLeLr5EXbKZbCaQQUaSnp96RJSyYcXmfxumLlI8OiwRerARy9+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 48/61] mmc: wmt-sdmmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:28 +0800
Message-Id: <20230726040041.26267-48-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a69c92f-754c-4bdd-98f0-08db8d8d1d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXHKmj/OkYoyXka9ehtZHrKrXvH4yi940OABB8SjRPatnHFPCglL5I1cFMpNlwhg6Ds9865QlbozMz2O6CfWbmW6C6pWpYnd2V3MYL7Fm2IJ4NzWGSUoRx6Pkb+x6jvOBprDVXRZFRisM7AWWJqcrv8YOfG/7svqs7+EvUVNiCtr6BOs9rF1ptBNbAxPWzvo/J9z3eyBTiTqVREkaY1r3Xpt6+Q5aCuwsx1ZH2OyO/HRetyK+zTVad+dgoil4hGCnfp7BaHmW99PDByJjYB7iuqeKIs8GlJDXCa3zY3eFAhqGIqeYPoOllxhdSqaP5bmFiHme5x+CuxqXonJneuHuXSByvav+gqt1+fooekiqi+V3oN7CJxQdRrfFrEuGruvMiYnHhE1ArlyQLz1jdzlgoa966SbgtYTo2SVhtXJdwmzTQ7OU8shvzhEFu5zZXz2akMcZSS6WoI0YtgrV3gCRVsdWaHFN2mxI8u62C9mjCv00F79DvU4hUUItd3zVDboWiNRdPy7H6X5xnLl+XBfAVgWhTASK/jVnD52FHyO6KljrQ+ho3t6yBGlJc4DAfS0856UUIX1aNsNM8gVZRj2JcyNzLfFCX2lobxt4kDN9vKgofkyXMyimBLPIE37evuN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFA0dDNTY1VKQTI3NFhlb3J6YVA3YWpkZnU5RkEwS0dNdElBQjhUVi9jRThp?=
 =?utf-8?B?MHhmbWtDdXVDdXdBTmM4dkpzaWxRaUpsbXpnZjVPZ2YvOHBrUmM4SGNOUHRm?=
 =?utf-8?B?Mk4ybE12RDdndkswYklKRmYzZ0dRdHpkRTlESm1OV25aci9zczZ6WDVZbFB1?=
 =?utf-8?B?MmthZFhrQzFSc25Wc0p3TjhZemZRd2NlS3dkempINmRhTWZlTTNYelpBZllB?=
 =?utf-8?B?cHNtV2oyT0JiTFgzWlRyWXI2VCtrRXU0RmFZT0xNSG1TK0NlSmdieCszelAy?=
 =?utf-8?B?ckZMckpDbmxLUjVvQTFIZm1xTlJsbXFZWFFUclR1WTd3VFZPSkFiTlc4Y202?=
 =?utf-8?B?ZzVjZDJpdmJPdGVaNmtsYlJqUkJ5WW5RVzcvNHpYNFBodkprS0JrUkZqVzNZ?=
 =?utf-8?B?ekhCUk4rbS8wUy82ckNGbU9TZVpVRnV6bzlIWlNUclNOQ2lBbFZsWndqNGN0?=
 =?utf-8?B?SVJudEtZNE5sM01OZDhSTG5sVzFOZXlPVEFzZTZTZjNGdzFpNmxRZXdnazVt?=
 =?utf-8?B?UTZrT2FudUpuZ1MwRnpOZ3VVUDY4ekJrakV5OWhTN05ZTGh3UGJtSkxacEZr?=
 =?utf-8?B?a04zVmRvdVVpdHJ1UFdpSlZLMUJNY29TZGJlQmtLZ3dRaUlxRnNxMk1HVm1K?=
 =?utf-8?B?V0Z4VCtBY3dqU1JueFhuUEptL1ZieExxL2U0eVFXMjJoTGJYRTN3LzFudkpv?=
 =?utf-8?B?SVdHdzZwbFVNMnVXOXVEZFRBQmc0aDFsTFA1MGU2TW5EUUhLbU5Kem15Z3ho?=
 =?utf-8?B?SGxoR1BxZTcyYytoekZFYlprTjVydzU1UVRJY01iVXZCTWdXQ3pWRzhKMTRa?=
 =?utf-8?B?enJmUm5vYkxNa1VYeXFkeCt5bDVTemlFWDF2VWVtME5ZUXNLTDRBc0JZYU03?=
 =?utf-8?B?RlAxZnJhSnkyU294TnI3NWczOTlWMUlwb0dLd2M5WVJZN1Q3cGFmNFN0ZGRk?=
 =?utf-8?B?NmkxdmpFRTJtNVBxaUF0alVrQXhjZ0ZlQWNVSzBGNkI0Zkp4QXVodGo5V2V3?=
 =?utf-8?B?VVpCU29Zc0hrMEFtNCs3N2EvTlZZMlhmK2hJQ3Q3blN6OHVPU1RDNkVnY1F4?=
 =?utf-8?B?WFdqY1NEVWxBNzlVZXpreG5uUVFwWWZVTWdoMElxbWJqRXBDczBYRVVOZk1I?=
 =?utf-8?B?eWVZVG5GVzI5WWhDTjZaZVgrRVVGR0RNUHdTcVJ3RDgxU1hyWVlVRE8xZmJG?=
 =?utf-8?B?dUJHazdGSmVJOE9aVnFtVU5rbWhWVTVqekRZcVcrMlZIbllxazhkM2tZbGR1?=
 =?utf-8?B?bmQxU3ZxWjBmMUJNN2hpRUZud2xVQU90Y2JmQSt3UmU3aVNKbVdSNjNxSER2?=
 =?utf-8?B?QlV0czljOGNwQUg3MUI3aU56K3ZINVVjQ25JWVlPMDBReVF3V1dFci9TK3BU?=
 =?utf-8?B?U2JhQnhtVjdsa0FuaVFsMFJwU1dUWVRGU3pqN1VoWDloZUtZQWUvMjc4K3Ix?=
 =?utf-8?B?ODB4M1dISjdIdWZFSlp4R1IrT2tpeXVmY0p0VjRBTzJzUWRQYUxISVVLL3RR?=
 =?utf-8?B?ckJDRTljUHZXSUhjN29TQm4vRzVtY3gxTVA0RFV6UTFJSkorQ0VxOEhDN2x0?=
 =?utf-8?B?dVJLd2U2YU1RZUxaRWE3bHB4TEUzWHhMT25pQ3loQ2NOMkxmVGZoTDJHcUlz?=
 =?utf-8?B?bXpSN3ZxVVp4eWlWL1VtdHNhbFVWSkFTSlRDc0VuZkZPZHJiZ0Ira2trOVBH?=
 =?utf-8?B?KzFpYXhRWGhjb2JwekorNzZoSUJldmtEY3B6d0hYN0hCS0tUOUhXT1l5Wlkv?=
 =?utf-8?B?OHZmTkM0a01rdGQwRzdza2lyalJjZnJjM2M3S1Y0V05xSzRUNWJ3cjBUMlZ4?=
 =?utf-8?B?ZDZXTkVMSHFZSURDWGQyNEJaWXVPQ09pUFlyOExpY0tJNmh2eFJwK0dubXBn?=
 =?utf-8?B?OEpJV2JFRC90cTdwQzdkOHd6UEJ2ZEZYMko5TGE2VmQ4SkFGOFY0NEVoZWtj?=
 =?utf-8?B?WXNNdk9FYXdCaUZ1NmRGL0Vpa0x1alNMajZqcXBTRnRkMk9Bdk4rcCtURlh1?=
 =?utf-8?B?MkFWdlhIME9nZnBXczZjOWNvcHlTNEtFdWdxdThXTXVSUklYcTkyMDJoRDNo?=
 =?utf-8?B?M1NQUERPNm9mOWFsQlRaYkVCUDN3M0FINFZCZUNubHBFSEJhZkhmY1puQVdk?=
 =?utf-8?Q?iqtn/bEY/H+8smdmzcbeRtSwh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a69c92f-754c-4bdd-98f0-08db8d8d1d77
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:22.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtSrqdFUbkdTYblJzN/k/BU0MrYutxZZSUNxbb3IS7lpnwFYJZOzjzsI3fY5pTEH358LAKjrW2rYQMfgK9glwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 68525d900046..74c475d071b7 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -880,7 +880,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wmt_mci_remove(struct platform_device *pdev)
+static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
@@ -918,8 +918,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -989,7 +987,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
-	.remove = wmt_mci_remove,
+	.remove_new = wmt_mci_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

