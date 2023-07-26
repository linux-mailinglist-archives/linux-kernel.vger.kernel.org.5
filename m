Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D4762A24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGZEMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGZEMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:12:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20726.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::726])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3E5B8A;
        Tue, 25 Jul 2023 21:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEsEATXi4vJvSjKOTpFlyhFvLEKuvvHYmpk4IfoNCVeyPQ0nRdWqqgd814Ph9/Gf/7dnx3v0uQGjx9ksDAR+IXbZAMkko8Zr0CMIEmR5D/nwQmIEladfttrTBZVta4NRBMhmcqCx1Omdq/lL2VSWi+A7k/3S5PuzyTNuYNMHz1xPvVDYUjSTt7oIUhFWWC4bYIdRmkjqALCtR1aLSAxd94QUmVMhmSCjqxbGGa2vw3Rqo5nJsR0m5Ptc+RnYSkph86/RzyeQkfarSrv/uge5Edc5SoWJFSPDdee2pbKIePDJhbC8OL3WzuKvldmpvoDKBedXHvVjsEGnA3ewmwQNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2uAnlw9We4maa9XEpusc3P6C5nlTy+13sm4GqQjPDA=;
 b=GxBT+Hhcy4USKvZTP7Xs1bLKSbldIxbTf0WbxfCH/AuJJ0/mIEjwMKdn8UE/7BUqi52fOWkd52Vq4zjFyLlwTZHJ5Vcu2IIoYgMouxuQtmatkU0528N4OpmjfzY3sPcYto+K3AWpu0qM76NrHRL+82M+iLiXHNrOIg1TPi8lkBNpt3uTYzu/1BBng7QrTgrFxgMTF9G89A8WG8rA/s2+qxGeDgaQITQ8rixop3fqaV7HDLylo4sYPKWWoaYDgEwguOzAeiOIV3heIPhIh3Z/1fKskz3Og4GuJUsPXdXo777Sq+mWSSuIZ/FkGqdfojTGNpjS7ThXiYz16c1gbraCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2uAnlw9We4maa9XEpusc3P6C5nlTy+13sm4GqQjPDA=;
 b=CS+WVAICRZ3m4k0Lyt1WPTUfk+Tc/204IPYE+GPOGZdIpITCixBvpEQ5hV6k+qK0YHCDE7Szu7XbGxpJjJouzzbeSwjDgE4eN7H0n6mFxGkhVYQSiQqAy4juOIymbM3rg0wWeaTCy4DeDvYrld8wcPqu3w/51RhPez+UnUFi74j/IX9KWWG610aIST3DmLBMqpikvn8C46pdKVftbify8Rr7k4VylEKBw2ahb2Wz/9TCf99ApPFf025si7TO0X9wyw4/hkCxXtH15mHG/PiKH2s654Xvuo1k+xurFYHYkh/f+w2GMEKIdnm7gGOwPRQKs26M5TEa/RV1PGWwl1qoqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/61] mmc: moxart: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:11 +0800
Message-Id: <20230726040041.26267-31-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e44c484-c5b5-4c1a-4802-08db8d8d0a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1EmfHqAPmtreogvysOGN3BAkOnMsG/cTeCFjlIC2G5saSYjc96p9h7snxRjfXNYkQQyJwPayKGYZLpW+pZfreFJoZAVPGOAPQLMk7hvwfA67uujdm45jGRnyp/6lHUo7QuKEXmOSheq0Kl5xk9oSz3cxnPBx1LNvhEnHCysbBI5Ut3VCB+24WjxlLXsP6OpoTBKVySZDjo4AA+oqyVvyMDpCTdFMyAcdmIPFKKWwkyreCTAUg9kNVRXwxyjE34C04G0HGlAm4HfScp41eZQ3/131ZuwjfnjrlVW7Gly/AI6VVehmUelMnkCfFaxdIynKVVSZ+o1ka4wtczi3DSzmAwUJy15itYgbHUNJ2IEohxikYprsDkBC6TYBv5kv8rteC2+l27x5Vn/Lo9NUoDwQHVnvNYjF8OAX9peR5LKErdMOWAXxhm0yZ9bKpBx/0XwrOftU75eyUZTgU2kES1snYSA9IcBOlbWsaD8q0eTmfHoUiwgUdZPhc6xXx2d5W5SMrgnAh84vEW+nY1Q2CNy2gAdEE+u20GB+9sbrmaEbwA9M53Lx2jNLnPPwE1i0De3Go6IdBL5FnVSu91rTV2DQEn1u6rCU29KBstKYE1SumSMbApB4X3KmiwUzOIaU1Go
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpqNi91RXdZY1Y4RVd1b3l1YitJdzE1NHJWamZrUWtGc1BLVVQzYWZuVG9D?=
 =?utf-8?B?VUV1aHZkOTZEZkZBVk0xTTFFbWhJRG9IQSsxSElRVlBZcUdPaW1vSGFEdDY4?=
 =?utf-8?B?dGg3Y0xCcWIvdlkvakdlYVB0Y053czJyVWhPUWhNR3NvVkN0cllQdDQ5OHBm?=
 =?utf-8?B?aFNxYTVnNytnNy9hb1pCQXFGOTQ2L2NLNDFJM3luTmRQT0REcjQ2Rzc3eTRz?=
 =?utf-8?B?cmptVjg1NHBiUW45S1VCZ3pXUnZBZEl4TVF1dS9SeW1rbE1GeVRSK1FvY2xj?=
 =?utf-8?B?M1R3N09hdGVLWU44dlV2Yi80WmdQWUEzS1d6bTVGWm51Z1d1K1M3VHVQVTE5?=
 =?utf-8?B?eEt4VFZXODhOMHhUdnRRQ2RydndteWtCYjFvWWpYWHFSUm0zQUNwbnFBMjNC?=
 =?utf-8?B?eWZ2bTdBbklqdWNSbHFNZ294UkpCUEtveUErWU9ldS9yZy80NjVMSzFBQzBR?=
 =?utf-8?B?UkhNWHR2YkM2WVlQdTY1Q2ZST2FhTWYzQ2Jlb0xianRsdnMzMCtDNVZnbGVh?=
 =?utf-8?B?cDB3bzBKS242V2V2dnc0RHN6SDgxOUhHMS9EaGFCN2lnek1ISURZeU0weDdP?=
 =?utf-8?B?dkJqNE91Yk11L3dnd2gxcnBVR3BtKzNqZ0ljWFpHdFdJZklIWWxsQ2l0bUtR?=
 =?utf-8?B?bVhURFAzbkRwLzdYOVJGb0IrQmlZNTJkUEZUa2kxQ1orV2hvUTBBQlYxRytq?=
 =?utf-8?B?MUoxcEZrRlJ0bEhsQlRqeE54T2d0UHJjWGcxMll6cmtBOUVvMHVTdGhUWU1v?=
 =?utf-8?B?VUpWRXJ3cHJkWkZMQlhIdGQ0dXdGRnhBblRIQkNXY0xLRkc4Z1FuYkRPd002?=
 =?utf-8?B?Mk5Ga1dPWjFNZ1FtZU1IRUcySWVMMXRqMHRIZFJxYXNyY2hJN0NwMU4xT05L?=
 =?utf-8?B?Y04xOTVEMHpodThidVNvN2FxaHZGaGgxdGs3YmFSMzhTSHg2UStzc3ZTUXRw?=
 =?utf-8?B?ZlJyWmxyemdYcThlVmErR1NUOE9GVm9obnN3ZGRIdWIrUHVFa3ZqQUJhUVhk?=
 =?utf-8?B?ZVdaYzFQZDhzbVJXeGU5aThtV1FvSXdCMEp4Y2V0UENMOWFhUU9oaWFYNWx2?=
 =?utf-8?B?a3JHcU5pd0p2Q2RlYm02THgxNEUzaml3RnEwTkxtY0drV2Jra0ZpSjN5cnIz?=
 =?utf-8?B?WHhZbzZaeC9vSFp3SE0yamloM0JSNTFoelhWd1ZpZndDQ3prR1ZxZ2JqM3V1?=
 =?utf-8?B?RSsyYytkcnBIMW44U2tYU1Nrc3ZrOEozelQ1dHpRaVZoK2Z6T1ZLb0gwN1hQ?=
 =?utf-8?B?bk5DanRqY09aS0lRSjZYUkJJWkVrNzBJNDA4aTdhdnpJcjU0bDBvc3poQ3Ez?=
 =?utf-8?B?M0s1MUxORXhzN2RNcDdpWWFhLzJocHpESmx6ZmdOcW9XNk5EYThNbjN6SUFo?=
 =?utf-8?B?cXYyY3JTLy9RQUNsOXZlY3ZITjVoTVI3US9oZVZwWHI1dWZ1Qm4zSzhCai96?=
 =?utf-8?B?VWNlenpFK1BJZzR2OHMvMXpJYnVRUW5HQVR4QkJMTUk1TnNPZkxBemh5U1Vo?=
 =?utf-8?B?YVVHYm43K2x0SUtnbWUvdm10OEMyb1ZuOFlhV1NLWU1keGpQa2wrVkJUbDhN?=
 =?utf-8?B?VzZ5MWF6WDYvLzBDOTNtTzlmUDJsMkxUNmR4K0s1Z0xFYkZQYlFUY1hHVU9X?=
 =?utf-8?B?ZGVhc1VDNXY4MHI0K1lzRG5RV3dkRm4rR1o3SXBBZ0U0Ty9NOHJXdXkwbXgv?=
 =?utf-8?B?anJ6c1cwWFlXbTJJR0dTazVlNTVzTWxySmlsNks0NlltUVFxY3hYUVZ0Z3BK?=
 =?utf-8?B?NDBzelhmQWtSSUhScDgwSmFaRjVFN0doakNxeE84bGoyRFlLTHlRWUNTVnRU?=
 =?utf-8?B?dkx0QnU0Ni95OHJHaUhYaEswV0pyTmM5TXNyaGg3L1QvbVlVR2pMUXJmYW5z?=
 =?utf-8?B?b0lKblhIWngxY2FUR1hmZW9uUnRaUUl0ODI2Uk8yQzVUY20xclpiS0ZKc0lh?=
 =?utf-8?B?eUJKenhWTUpVVmY0dzJtVGl6UnJZU2U2ZmxIK1hHdGJiNWprM0NYUHVoRTRw?=
 =?utf-8?B?Y09XZWViUVpJM3IzMWl2UktQYnhtWkFOMHJTMkJsMlVPVkNjOTE0YVliWW1r?=
 =?utf-8?B?QWh5ckhiV1EyS0NyQWs3UFN4T3JkVXBMSlhJN3VydHhoSU1wdE10MWJpTlRz?=
 =?utf-8?Q?PWuNKLgbX3Vrk56EiELNbRvbv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e44c484-c5b5-4c1a-4802-08db8d8d0a82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:51.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwkVEtilgjPw4K0guIQxAwA6dI8LmTfnf66jIh7vYdutstuwIaxVpYLfJpan9+9PB7BTK8hoC1QtKFcirAPblg==
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
 drivers/mmc/host/moxart-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d0d6ffcf78d4..6673b95747cd 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -687,7 +687,7 @@ static int moxart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int moxart_remove(struct platform_device *pdev)
+static void moxart_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
 	struct moxart_host *host = mmc_priv(mmc);
@@ -705,8 +705,6 @@ static int moxart_remove(struct platform_device *pdev)
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
@@ -718,7 +716,7 @@ MODULE_DEVICE_TABLE(of, moxart_mmc_match);
 
 static struct platform_driver moxart_mmc_driver = {
 	.probe      = moxart_probe,
-	.remove     = moxart_remove,
+	.remove_new = moxart_remove,
 	.driver     = {
 		.name		= "mmc-moxart",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

