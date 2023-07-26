Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13E762A44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjGZE0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGZE0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:26:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E452D4E;
        Tue, 25 Jul 2023 21:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1UejV3v2AEQiJ09rNS9gYc1sOsD+Vu7fvDS8RG6PpK5Uxi4WBNscWRC8WvG2ruIBivz7b84+FIQ6mKLUqfrHG4FsMy1r24LklM3K7jtO1Yf3+DWcNmhJRT1U8t1Ju69bk7DbbrJaCG6n+kB9AqJNYVPyIeiaF8XH8Xgrw/WWB4oOvPYQCtgelWqfhlYAgf5h8ODFSefdnpNEZ2qBFP7jZdJgUn4iISAORucq4d8JGw2T9wRnNyinCSuG5IEMNIucLe3TbQP6nbHQ+081GVNtHxlmxK4L7uJbhSiCcOVNKPUw6RWDvSKK6QeB7jn4jOYg0hHsexbRed3QqVB0fgJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=ntrm9Mte0w+lcs4kNSj4JzpgLGr/NPUqLZNc7235JSvCLM02e7YZAWA3Lq+VSJRlKxY0CqBPkHcLgQH+KQnhso+kMocXMnpflrEhKjpESg+fKgiB5VToUBbzHu+IwKERZCLUzZaVnR5N15E4xL9j+njv2I+hx61HGNe8FO0pfNVpmrWdz+dmaTkU3yRrbtz8yyUoH0hZUhP84cU/37TVxbKNV77uRgi/nujIDa5dEC8svQPw+xJeKVYcBmCcNLqFUJIfROlj3E7LvxK4vd/gHOjlQLWIGKxcE35YGxRib9i07I1ycJMs2YyM2sP3CgauLnSleYrHDOI9E06KY1Nahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=KSlpnL80Ds1qQgsKgYNYxpQw6TBbEhNLTaOabXhckUrk96fUC1n0R3nHjZFMbqDNPNPX9EFAFm+LJByDlX8RbxKQEi4QO1n6sUnQa2E9NKqhoQAFYCTtuq3AXnhUbLjoLHIAG/TXO142Q80stlcr45Qfzve93rerM5Xmt1+wRuStMEisHznUXKp5IzV4pkjVA2bBdMas4SN6Fi/R4X8KMzuJOoswGCcDO7m/0DH3n+gjHYX6S3x7NHhhL3yf9svEOwuM/KhaOJqqmR2U989ET7VKEjsNFCiXmJhUrcZ1nQbEP99sqS9yM6xO31dJrNaxlQWObHc1X1xHvlquvIW14g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 55/61] mmc: pwrseq: sd8787: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:35 +0800
Message-Id: <20230726040041.26267-55-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be28dd1-428b-4749-2c76-08db8d8d23ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1mo5EVCdFo236QSMPodFhKA8rsfSoTg6p30RlExIh+NDV7Wqi67qxaxlimvkmqwoWjS1mBFmUR/HFIk3EM+CZvsBCdUtlvMLPwE0BPvFUuDy328DBO3UGot22q2FaDReN/bjayJJgFo7lJ7ONJkC2f1V2VD1t+zGdHsP3S/DnygE3jmxHn6g9SvTw/yN6tS16OU+tw0zkGjbERec3Tz8OXNReJDSqi6q18xFodApzVThzkkX3OCrZZXiaTsfO5pVwO6VQRlP4U5kihaHd6xYbVbWXb0tZt5qeCocLZJDrw0NMgn3brD9h4CB7p5x6y6xAkevcSV41dC9D+0LC59jZxRrM2vUZ5b1Jmx+s5DnL4LJ5fz9xSKY5tyg7kNA0mqjiXPH7x34M/T6NYOfk+dOiou9fZJiaoGRZ/s7Zk9IFdNj9QL1xH65xEved3hAgrSxDfy+Sj3km1vQRfcboZuKjOGGH8E9vTV7wSbR5LOEhPmztERbOjfGxuX7gTdqHvFwokusJSVT/19uUB+wRxKWVeuQimaztzhDClXeCiHE8VBvmGSG0G+RGvn8PG8Qt0iuSXzf8hId8JkFJO38rrwBaKrJX0erLcFJna28apSkeKdePed+fkJHR2NG/aXeL3y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUorZGFnUFdXZlZDUDcrL1NzcDdHNSsvL2hrSkxvRUw0a3N6RnZEWWhqOTJU?=
 =?utf-8?B?K3pkS0pWOUVyVnFsMk53d25YN0xkQ2RLdUxOWmVLZDFLbklOVVFXbkYxbXIy?=
 =?utf-8?B?U3Uza0RvVDFldTJPTDRZQzlRN3pHeEUzS1JMRndUbFcrcjIxKytiTDIwdTBu?=
 =?utf-8?B?M3RJWjFBamRRbVRQSlkzZVV2MW05bDZiemdwTjlTR0RaZkFDOURsLzFvMUdD?=
 =?utf-8?B?T3NtTUk4NWZWQmJHamh5YXN4UWFmTzNXc0VCQmdxamFDT2d2Um1pOGtvQWJC?=
 =?utf-8?B?SXV0VFhrOUxFNmt4NmhuKzQxTklaciszMjNVc3F6OE5vQ1hyVVlUYVFBaXVX?=
 =?utf-8?B?Um0yd1g0UkhUMjFycGpnUHJPT2wzRXlrbDI3clZvNmF6alpvTVdWcVRFditX?=
 =?utf-8?B?ek4xcHRKU09CdUczTUhkRk5YWEFWVE5ZVG41K0VLOThYZi9XdGkwekxTN0tI?=
 =?utf-8?B?Y3NaMStFbCsvZUphVXdTU0p1aDJFOFJzdFQzaEJzTGhNZk42VDAvYmJJN0hJ?=
 =?utf-8?B?ODNUNGNQdEtWUlEyVnFkNEd6cjR6TnVieFVlTWF2VmRrQS9ueHR0L28xd1po?=
 =?utf-8?B?ZkxnVFFWcWorcncrWURrSEJ3Mk5MZ3lQOXZQeGJUUCs3UUZNQzgwZ3lUcVJY?=
 =?utf-8?B?ZWZnTDQyVE9SV1lBWVlOaFNzaDR3RDVDQ0dUWFR1azAvcnpDQTkxaHBaUFlD?=
 =?utf-8?B?Lzh3aVpxUS9kNlIxMUFack42OXAzbkJVY3hMQmlOaTdITStiOVpjTUZSeHZQ?=
 =?utf-8?B?REN0QmN4TlJ3dHUrS1RtekcrdldFWFdYdXFkdVBxYTY4WnZ2NUd0QlMwU0JL?=
 =?utf-8?B?UWpERlpmY3dkZ1RUSDMyQmp4Rjd4Y2lJZHFJZ3BZR2w2TFgwbEhhTzBRcDRx?=
 =?utf-8?B?eVZ4dk9nd2t6d0E4WnNqaG1yUWZDVURqS3p5Q0xuU1FkdEhKY3hIR1h6RTN1?=
 =?utf-8?B?d3NIM0ZIOTBwbGhNOVRxdjhBdkc4ZnFFMy9abFROcDk0QThxTnJUem1TK2hQ?=
 =?utf-8?B?YWI1eTYwVURvcXdqa3pXWnlIMTdZMU5nZFRDOEZ2YXBhMmx0QWUxYXk5U3NY?=
 =?utf-8?B?MmFxZWpjR3Z1SDdtODhxUGpjblpZRnBmc2pSSXlYcm1OUzlQMHJUMG02R2k0?=
 =?utf-8?B?QjB3RGNsWVFwcFdqSHVadHhwaFpiYUwzcG12cXhERERxSVRZT2d2N3pHdFZO?=
 =?utf-8?B?VFpqdFNLSWJ2RXVmaFJSY0JKMFcwaHB5VVQvVFZVWXczMFBKN3NiN0NmMzlL?=
 =?utf-8?B?OFVPZVF2TGZGOGpBd0Mvb3FtOVlZU21NM0x4dzFjbTRsWmEyN0JkaVlpR0U0?=
 =?utf-8?B?cGtBOHpQWFpNOUc2N016VFM5SmFMOUNieFFKV0NPVmV6Vm1GQktibGhNRzJR?=
 =?utf-8?B?WmozZmFtcldpS2I0Yk1VY2UwSTFoYU00TEtBQ0ltSWgvck95YlUwRXN2dWJK?=
 =?utf-8?B?RXpPY1VhaGRrQmMxMW5pQ0pkcERGbnBxUjVXcUg4ZldobWxHSzFkdnV6anZp?=
 =?utf-8?B?TXZSdzlxQzJnSktJOUY3MjlsZEVxcCtFNHNJVnp6WW5PSGx5Yi9KeTVtbUVI?=
 =?utf-8?B?QndZTGJIRVQza1J6eEZGRldEVVZqZ3pRNU5Kck9pSDNsM2tRV3NuM081c1hC?=
 =?utf-8?B?V3VhL1FKME5VMHBjQS85M1Qvdk9VWEUwOVRLVkRKclA4VUxaNWhnbUJQNGlC?=
 =?utf-8?B?R2RJSTY1WW5Pcm4vV2VYRERIdDk5czVxQmxadmVjdzl0azNYT3VGamFCRVIz?=
 =?utf-8?B?RE1FZW9YY3hjckYzNUxqTFd0RWxvUE1MeDJSaG9EdHFFeC9wTU1jWDNvTjFV?=
 =?utf-8?B?bCtFaTlnWFI1NWlvV1h0cExtbkNzWTJDRWtIVFJxaEQxcG9VRHgzWVJBWGJV?=
 =?utf-8?B?REVRNWNieldBaTcvdUtieFVtQTd2ZG5KdW5KS1EvZFdFVFQ3aHNiM0RlZGNZ?=
 =?utf-8?B?MGN4RE1vQUJFKy9kTXNER2RJZHU3M1I3VEI3OVZETjRLNmdMTS9aMVJuUlp0?=
 =?utf-8?B?a3NzZENDTk1iSDFRT1dPQXdRQ3ljZ21PMnJ4SDA1NDUwTzZVaUVKWW1KNEQ1?=
 =?utf-8?B?L2hxUXZRbDVUNWFRdEVqN0o0cE0zbWQ4UFV1WlUxcHAxYkhqMEdWdHJncjcy?=
 =?utf-8?Q?Czxb/u0tWXiiHKN3f0yYUS7QM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be28dd1-428b-4749-2c76-08db8d8d23ab
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:33.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecqiw/2vD4/pnogHtkukd14GhnH65hU7rP1wJ8OSNsQfenOKA9z6L9/IJHvQwKfoRC/gi1DR2+84+FZDDmcilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
 drivers/mmc/core/pwrseq_sd8787.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 0c5f5e371e1f..0c5808fc3206 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -113,18 +113,16 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
+static void mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_sd8787 *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_sd8787_driver = {
 	.probe = mmc_pwrseq_sd8787_probe,
-	.remove = mmc_pwrseq_sd8787_remove,
+	.remove_new = mmc_pwrseq_sd8787_remove,
 	.driver = {
 		.name = "pwrseq_sd8787",
 		.of_match_table = mmc_pwrseq_sd8787_of_match,
-- 
2.39.0

