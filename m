Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA875C39C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGUJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjGUJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:49:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415D3C16;
        Fri, 21 Jul 2023 02:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPFvUYegnG5ozoxKyBEMTaD9W/enVEZu5/0zXSHGktpLCTch4I/tCcYbhnPSdvEkKKZYsfcnwn/NfY3LQ91AkNnTsveje9Ljff9RtWmY//J/yMe/yTVtu9gYx80tWBnekuTw+rpefJE2ZeTBw79HJgrP9a30r5Lrg8vqMRLcs0/rKYbPJed2mntGI8dDPNLjfvLozTMpomjaAdI93laepATwKcpghbfMhMykC46Ep9OskhnPScRGLzuyCQhn884R+0jao/oasrH4a6P2cx5wQamj0EoCBxWyVcj6z/RX37VaT0aw+g9VZBw0LZpac3ups/npq5ItoDegC+ygdkOgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvlUx4SI67RgVseXdZyvUk2DPAtSbRfR6U4Mi2B03kI=;
 b=MuZwVfKqCT4z/Dg2qluTfZQxB+P7Kw2gd4Krq0MYRgEc3sa3HQmFfKl7XrO4OVA+/zfPl4X2qG4vnL/4c6IalBko6SniPLH6djqEupUUHCc7bk2ppBYdu2q+UWxBpt1ZZgOA1jknGFqQ4JdyDm0pJ530hogXNsRkq0oea2Dy81HDr792e8elN8+Ovy8whLsd2dg2TAT2QRBEHsTyJYpU03oUFPDuNIxldNJPd8Vslg3SPqdq2GCDRUqpTq3FS4lIQMhwox1e18flwfM1m0SjcmQK1tr/TdoaPm7s2Op80nPZMG0pZV6sjRM0aAWlhB8ThxGKBRPbxMlexnrEb6wW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvlUx4SI67RgVseXdZyvUk2DPAtSbRfR6U4Mi2B03kI=;
 b=UO3AkBA8A7TeezaYOAAsCt4TPkTigpciotg0Fq9ZWryUvjHvVqYiN712Cs6FWCLpEujeFXlIpUyZYbwa0TAZJ62mf/UEjuyTRZG3Iho0uxH718K/oF5nVoP+Wl5PfUkgnDJa/C5WTkg4RrFF7bc0c6ztUZZlP3PlLSOQXAa8z6bpAV9gItLS/qijLjQfCDHMeambaf+IGwDTYydSZ/Z2HEY/PFnfzzxkSWzen3Rd+5+/SHg2tspJh9eLORljVwpMmV+hqEjdQqV5eLGCccBEbBtJtGny8OQTomnF53pOQjwCP9rCTNSRKeP7dTxYuJYjh2EjEfMN30vs2YIQH0PlgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/22] drivers/thermal/rcar_gen3_thermal: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:33 +0800
Message-Id: <20230721094641.77189-14-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: ef273c35-cf6d-42e4-ec06-08db89cf7fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbklQOWFMHFTb+hMH0tsGtZSvFKEPRSkYo5sonnhbJw9ZuiWUuR2TPTwwRycjNR9gUOj29SyOfz42yMpCtTSavosMfpRu67Ctc+YrCBCMOESsPsiOY6A6ujKM6PafSiXtwYC0vEoC0x34NWFq2N1lM6FKJouFE4WsV6JMaaHHbpKkMoHNRKw107AlbpPKFq/3dGL2CTu+XWiOYquJuP6VB4RFrQaKCH6gA2y+KzDs9PyLbNPvNnkdR5akFv9VwlNSjgHuzSvefE615cIH+ZsA++86TueqAc4et0JX756MnR7v+EwbW7CgIx8yZXneHD3kIuapUHAyUrcSRgV6+p5g3AQROObceXBnT63WJwyoOSnaISK7D29sw1xeWmmCqPmVyEFWWE6i1Cel0umBPE0Qzq+G06r0XHgWdYwgm/zCXCWjEg0QFxnpmV+NOMAO2gK4BHonm9ujjX32K+IehIE9E+t763WEERYFjVhNWU7Z4xHNO/RJAWzzyyy0X+c3kydQ0I8CRFo6YRal8Lhk3OPaPE1vXKosKveBpBSX4BUvPfMaJnq5HygkkM24Z8zSveV/g3NhYad/eKW7xM32z+adSyYeu2N+Cxmneif8L4jq+PNon/+HVYZz0aBhPNEt2ax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3RwUk9ORTFudUhnZ2ZCNWIzUXZuQkM4S3o4elNQM05sMHoraWhEMmJ4dk9T?=
 =?utf-8?B?OXQ4eGxZZ2xpazEyWXg3S1hoaEpkbWpQV3FtcCt2R3JwMDFFcjdJQUlHdVcy?=
 =?utf-8?B?RWFOcHV1ck5ETzhCbkhwM3E1ZUxQM2gwVlcxTXFZdThBU0lXK3c2TDBYR3N5?=
 =?utf-8?B?U2Jma0NwMkdLUVpocndIWjlvQVRLdm04UDZXcXVZbHp1WHM1OGc3TTYxQnI1?=
 =?utf-8?B?RTJwbnpXM1M0R2tVUnBhN1JqeHJTckhJbzNDZnUya29YL3pqeXlMcjdGZ1lF?=
 =?utf-8?B?S0JlY1lxSElSanZpOHpKMGFRSGlmdjNJcEJNMUYrRVpZUnVQSWxSZ3pCSDZs?=
 =?utf-8?B?cFphYkpLcjFvZ25SOEpxVWpjaUN0QW9aUXVYNmRPSitGUWJPTkVsc1BOREYv?=
 =?utf-8?B?bm9Pc09nQkpkUVRhN2xQSWNhVmZwT2NaSzdVU3R0VFhKQzBVaG15NTRmVHlh?=
 =?utf-8?B?QklWUXJtM1I4bmJoVktlSGNRYUUyMjV5SnpWWTNMdUJLK1ZFWW9ib0xhVjZn?=
 =?utf-8?B?RXpTRUpjMUlHWjNUMGczRU9zZVNmTWQ2bUcrQTgweWpObDdmWXJSZm9NSkdE?=
 =?utf-8?B?UVJ3b1kyK2xEU3lzY3d5SGVKMWxRYW5BQ1VBWGc1SXBoamEvZ3h0YWhrMzN1?=
 =?utf-8?B?emxXRWhFTEdsc1ZwZmtteXRVd2FWbUw2MW1xa210ZVJLLy9tN1VLRmdTMG43?=
 =?utf-8?B?RGF1TUY4cXlwemlySVFRVU5tblQzckdudjU2bTNYblhZOTZXendReHB1dEJm?=
 =?utf-8?B?M0cyZDlFNTZBdjFOTFJVT3RobVVBZWxxOEJrVStja01OaG4yNnk4VjY5cllh?=
 =?utf-8?B?b1NFQnZacWhPYWZHY2dzTFF3WWxnVUlLMERWU0QvaDVkL0ZMa0l5WktONmIv?=
 =?utf-8?B?enlxVGpiY0FrWmUweHZMcUtocThFeWZBWlVWUmM5R0lmWCswcm1iVkY2Q2Ra?=
 =?utf-8?B?NXFZMG55c0psOFFTeXNmSUs5QWNVRGk4UW1Ha3ZiTVBqcVhsTkZKWUFqWDJG?=
 =?utf-8?B?ZjhyM0pNUzRmcXRYNmtnZXRYRU9KdWU1d1BiVlk0U0lSaUQ0cHJHRitCWlky?=
 =?utf-8?B?dWV2TzgrR1B5VlVHYzl6WTdrY0VDRlQ5SFc0dkdGb2t5RlVYUW9zejJaS2p0?=
 =?utf-8?B?dnF6Ni9CUkpMK0tVUGpRekZpZTFDQ29BamM2RVA0alJpR3pLVEYzTWEwbU9G?=
 =?utf-8?B?Njl1djNkQ0hTeWI3VVQxMWI3bTNyakxMQ1hzaDdWKzNOclFieUNMeTNrZjY1?=
 =?utf-8?B?NjB0NDlJMll2eEc1d292aktmb2EzdjlDUjkyVUxBcXRjUUJKa3Qxb2lzNGFW?=
 =?utf-8?B?aEovMGZvSWd3Tlk5cXVORXQxNzA3UGUzM2tQaG5GM01BZ055T0dqOU5mTTIw?=
 =?utf-8?B?blU1S0ttL0E0TWtqYXM3ZjhRSmlHQlMxVEpuZkhySFk1QVpnN0s4Q0E0SzBS?=
 =?utf-8?B?VTlDeEZudHAzT1NmRDJPcVIyRWlSTkxabmlJYXdWdXRnZTdwUXR4bUxVUTd5?=
 =?utf-8?B?QndtV1JUemVZRkhQWVQzN1BOd1RnaHdyVy9sYkR3c29ERWk2ZjdnVFl1bk1Z?=
 =?utf-8?B?bzJQaUphSVp6ZWFvaFFIYmdRY0tlY3puSitjcmdqUjVwWnoxSU0zaTF6Vmo1?=
 =?utf-8?B?MkJkc0ZiQUVoWjdIUjBkSnN2UEV3bEt2VjVIUEhiZzRxQVhxeWJLV1M1clBI?=
 =?utf-8?B?bk4zUHFENFBYR3grMjY3M0dydDlobGpzcFc0QVpldjdSa28wMmZlQnBwTVpn?=
 =?utf-8?B?c095RkgzNC9hZTg3VlZSSlZGcmNWWFB3N3FYQUJqeUJSRURiVjVEcTlzL3hN?=
 =?utf-8?B?M2F5VXdHTUNNTVVCRlpSWWZuZWJreWtQTW9BUFpTeGZaQnRLbVdQTmU2OTI0?=
 =?utf-8?B?blNoMU5qaWVmUXZONjZ6Z0dEeXZxRTNuQzZCSjVrSXBUSWdxZkRhM0kxMGhF?=
 =?utf-8?B?b1EzMHhsSEN6bitnS3dWN2s2cHF1Wk9xQWVySU40a0pNZm4zenBvQVMwYjRO?=
 =?utf-8?B?US9YTFN1aktNZUw3TGV6VWtIay9YSWNYdTJBTS9YbXFzWjRCVkg0enpsSkdo?=
 =?utf-8?B?SGNVd21HT3NqdnJiWFA3aFZXZUk4RFVlNy9UdFEzTURQWlFzR283QjlqWVBP?=
 =?utf-8?Q?bygvzD4gcHzaKbrXwgqiMannZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef273c35-cf6d-42e4-ec06-08db89cf7fb8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:29.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGN7Hd2CeDPR3JKR1SDX9PyDx0WOrRiiLZ//Hm4HWjfYNb63aNGFnyF9adEK6lJLNtqb+L4NI10DCXBA0TJ5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9029d01e029b..ff9cd43e1881 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -467,9 +467,10 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 		if (!irqname)
 			return -ENOMEM;
 
-		ret = devm_request_threaded_irq(dev, irq, NULL,
-						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
+		ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+						      rcar_gen3_thermal_irq,
+						      IRQF_ONESHOT, irqname,
+						      priv, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.39.0

