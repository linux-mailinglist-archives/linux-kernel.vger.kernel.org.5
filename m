Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F232D7647E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjG0HIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjG0HHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC230D3;
        Thu, 27 Jul 2023 00:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJEPaObnPj4dUfnTti7hg3zYkuBsuSRjQl3K9r1T1cfLxTZ+ObTdnrKLBIrw0nRVuCrUN84jrm0VKGKk10bBbGXaw/vguLCwaooxRDrX5VWJqivGBOCvj0STSNK7CyeAp4RAbHEWYX1sCbM6cSIaIdzmKobcNtSbL/pIBK2ikhXnS+somy5O9sD0Zljv+GyLyhjOfNnp02VpUQmTnD0mzL/ApjGzxEU5C1AKTLzSVYXX3W67Fuwfn1tNnIOMLdUyObMg5/XdG1Ob5rP3P8LynjmyEdJtxxVBIVsY0kC5shiXrY968zB+PyX+kIbcSgxJEwbYSDFf0FDKDLTdspcYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=GyDegS8k9jCpoX9bjfV2gl6CV0fu/Dny3qTf0GRR76K5oScUERcZK48u6pxVFgDI4ncjLP/kHaF+ZMZs0VVYJFa9OOxdKm7PLyTxTav+tV/HZCJZc0a5qBHTplVjZCnS61cd/cxUD0J4xdO28ql1UkbgGtZ8S1mw45nXaVk1t6zraEvVi3QG24OR0fOs6VTgq0++lKLxFpF2USc9aGcBVT8uALUsiY8qNl07d4ZoDsz0LXDLZ98mWYFTc8frh/aBdbfK0fw2spMnq0/bUXX8276l3kxAxIYpf4gnftfPAOzkpxgCpffE1ZUUiEBnPMRocXDzDN3cQA31Tp9E4yibIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=DsK6lYUhYdErJ/jH2AjAKGnJhFqpasNL5QAbBhGjbyz9bjXZBlH0l7eRKsyPlL1q+nFGQUmZi/RjkrpRBjyX3IvIiqkJ+wthEX3T1z1j7RO3pNLqxLaryX3U6TFVO6HVrbQGq/sKpzH2rr17mz8gg8skdugr+hGKHPWNKH2jDxZNg6okYJnE+pxTR7u5jvk3GBU2G0vXOR1+TdgHjvSOqXx6/V7Eh68ns40SMXWjhMCH+2OQpoDPIaqP72SeUZS6cEfEwk311y7fL9NeWIfMo98yC5RT+K2NRmTgeBozXsiNqOUjh6LwmQKn3GMNQfYtY9WqSmMYrnhuF3ecy3YkxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 55/62] mmc: pwrseq: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:44 +0800
Message-Id: <20230727070051.17778-55-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f7b106-0f34-4f27-6dbc-08db8e6f73f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tbw0nkQN63OYFRB2ByhL42oIC521u8zv3qM971wfHDkMPirHlxJWhBAp9S5Odn0wNc2uWqvraU6TtdDrqOg112KGkpjwkc3ocAsqarR9Ffa2Tfr7u4OLv7v8r1Uj9x/6uDFQ0Qad1gx+wRPrWyI1OjpPciyyFaXZCBgCR45TTjq1UZCFM0gBcbaSFkdaapdcvLZimKGfmZbeb6fYUiqCc0QykPvC6uKd/I3+DnX0UoAo9y5pIjE0aMpvl5Hy10hQvlnZD2UOn85W6acDAU51AHeRzH/KfvMNEYiedhKacG1vwov5JiQjFoJXRgUYagXm9ZXlwJy+fEsK2VpF6GEWlU4GRhqxBZdmCB/hZ2OXkdJwEfY1HuvMLw/Wf0bKVOSgdb5lJ1wHUVHOtF4dIJJi0sQK0RZRL6E1oIybugvWlqmXS+a0wBa1a7Sb6FR18lfzuoDux6Jqa2ej3alRFVf8aywOVYVT879OyMXlSB+fvDlaDr83niv5ZNlorVtQVWJv2rEuRzt0aTMdeZKowoTKKfBoHulIHYI20+zGEQ5JvXvS+hnTFlMm0L8pJ9VCB6R5RWcKcpwJu8a3nY31k8xh03wDzL+ycVWT3/QRN98mQJJHlVUx6zOx3HS3QlSNiZSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(6916009)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEk2bEh1c1Y4ZHpQNEVvQlhUVmZVNEd1SXQ4Y0NYaFRPZzlMeUx6ay8wK1gx?=
 =?utf-8?B?S0I0akFaS3RlbkpFNy9tUlVrYThTZUlqUy9obm1jeXk0Y21mOE9veDJNNnhn?=
 =?utf-8?B?Ym9vMXcwWlQ4U2NjUU1KRDA2T2N1RWhSTUFBcTlKMXk2SzdKVXgrZVl4TFNE?=
 =?utf-8?B?Z1ZINGhtMTdsanU2VG1WdFIzd0xvd3hIandqODRjcThNNGFlT0hTMU9PS0tS?=
 =?utf-8?B?LzJQcC9LN3RtZjhCdm9GR05nSHE5TzFiZUlhYzM3T2wxMnJ3azZCVXpBazdl?=
 =?utf-8?B?R1RXK0Zya2U1VXpwenFKSTR6L0d5dEpwZTUwZ0JFM1c4bVluR01aSHVKNlVw?=
 =?utf-8?B?THZCZExJVVgwUTQvNzJPYVRLSXROS3ZGWDY5Rmh4L0F2VlJlNXhGMWhHN0w4?=
 =?utf-8?B?Rm9udi9ESWQ5empndkN2RFJ1a3RrZXZyWllrSllDYTUyV0RCMjVMRWtCQktQ?=
 =?utf-8?B?ZitHRityRkhKUisxV1pBOUF3eTZRMElWTG1IeURxdEZqTWdCNUNDMWR3a3N4?=
 =?utf-8?B?dzFudS81OXlHYnlqZ2NRMUVsaG1la3J2M3N0ZEZxbExkUmNaeVkxRnROT2dB?=
 =?utf-8?B?NG9IbkxVZGN1UlNoRkljWTYydE1aUjk5bG1CTmxXZDB4KzZQSzJiZ2t6U3Ju?=
 =?utf-8?B?elByclFUaGtveXFiaU5sUzhleXJ3VzdseE1BMzFBaXVFdlk3THhHeGdOWmtl?=
 =?utf-8?B?TFdIYkd2UG01Q1pqb1FWMlEzSWZkUkZGVU9HRjYrcmFlU0U5MThTOGY0TVlJ?=
 =?utf-8?B?bHRWd0pRSUJJRjhpVmVCNEhlaURjSzgrMHBpNk9ScDFPVmNBODNkY0tORFZj?=
 =?utf-8?B?aXlEMTdIdjc3dnRPK0drMk8wZG5wakNMdGp3Z0ViSXFVcTZ1akJzeXR4SVk3?=
 =?utf-8?B?ZHJSUlBqVE9yL2RKSHo4YW5rSUVrbGxLVzcyNUZXb2pkMEM2V3QyK2ZaeXhw?=
 =?utf-8?B?cWZXRGNzUVNnTnNqQy9vbGZvUmVmU09jVlNlY255cU9Ia0hxZElwdFMvMEpO?=
 =?utf-8?B?TmJkN3Npb3VOV2d5WTE0OVRpSHpqNFZjTGxXcVd2YjREUmRqV0dhS3NlSURB?=
 =?utf-8?B?dldBSjZINFJPRXoxSThNYy9SZ2JxZVNSb2c0dExVQndUWnh3QVQ5NldvMk5V?=
 =?utf-8?B?TEdyQnZXWVM0NTNiQ0JjazJuK1BodW9xdWpkZDEzeERVYWZ3Z3g2SXFKYW04?=
 =?utf-8?B?SXNaUEhOQlhjQzVTWXV6SkJpcFVzWHpURUtPMStpZ3gwUVB6WC91KzZJaFJl?=
 =?utf-8?B?cnZaM3VzVWRDTDJsTVFGeXJlQ3N6UGdlbFJRcFRFSlJmalBKTWJ1MktXV3B5?=
 =?utf-8?B?S2s2N2lGYnhqWjBlOCtRMk93eTJtODlST0NPNCtqUzRHTUlhN1p3emtPK0Zh?=
 =?utf-8?B?ZW9ZTXY2S2tNZkZPbEE4SjVSUlp6VVZRdjNURGdVYjVaZXBJQ3BTVmFUVDBT?=
 =?utf-8?B?L01JbXMyRHpuWDRleE9NVkJCb0JNb1c3aEJ3NWhYbWNEd1p0NTZvUjFxV2xP?=
 =?utf-8?B?cXI0b3VpMUM2K2hEMTdkcHd0eW8yZ1lhb1k0b2JRdG5YbXR0YzJOVzdxdXVh?=
 =?utf-8?B?TUhGWGl3UFg4T0dEZTVBZytsaHVka0tNejY1eklrODBVbjVUUkp0RDNyVTNm?=
 =?utf-8?B?QlhOQ0owaU5ILzI0S3hDTkxkS2Y4YWdnWlV1VzZnUTJMYyt0TWxHNWFmekY3?=
 =?utf-8?B?OVMxdVdBVy9FK0hLVldXMGozZ1JlYk1KdTJhV1Z4ZVpiUVZhNkxTbDNEZGNF?=
 =?utf-8?B?SEI5Mjk0VUUwckxlVHlnVE92UW1ncy9pMGNkRzlsZ29LdUFwWERHN2tmb29K?=
 =?utf-8?B?N2pDSmtFSnNNOG9MbTh6Vk44K01SV05GcFdYQit2ZExiZUgxWm1IbG0wMm5N?=
 =?utf-8?B?NVBua3BpaDNzaGdtbVkybHZDTjdCSit5NlVHTVQ1eE5RQ1F1V0gvL2MrWUpL?=
 =?utf-8?B?OUtReVplZm1YNUxNRkRZL0l4MERLalowM0hkMHpyOE1aVXBBcDNuVFpzU29K?=
 =?utf-8?B?d3RSR3ZOUWxaRFk2U2RmTldTbnhzMnYyZzY1UUhKOVZTVUF6RHFlcFRleGs4?=
 =?utf-8?B?ZUlkcXNiTEs3QnRzR05HWEMwR3FNTzFVQlU4dy9jUVNJSnJDMzVFcXlvaDNl?=
 =?utf-8?Q?fMH6w37zdREm+nLCZVOtbn7mq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f7b106-0f34-4f27-6dbc-08db8e6f73f9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:34.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mq7O/EEHX8F4mf7C6dypowY0WDP9ooKCYv91/agnRphOzHzRujblEZJ+vghVhdfYMLSKT7R3s7uwd0S2jiPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/core/pwrseq_emmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index f6dde9edd7a3..3b6d69cefb4e 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -90,14 +90,12 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
+static void mmc_pwrseq_emmc_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_emmc *pwrseq = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static const struct of_device_id mmc_pwrseq_emmc_of_match[] = {
@@ -109,7 +107,7 @@ MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
 
 static struct platform_driver mmc_pwrseq_emmc_driver = {
 	.probe = mmc_pwrseq_emmc_probe,
-	.remove = mmc_pwrseq_emmc_remove,
+	.remove_new = mmc_pwrseq_emmc_remove,
 	.driver = {
 		.name = "pwrseq_emmc",
 		.of_match_table = mmc_pwrseq_emmc_of_match,
-- 
2.39.0

