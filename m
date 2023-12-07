Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3680870D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjLGLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379007AbjLGLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:51:15 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C019A;
        Thu,  7 Dec 2023 03:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izb0lvQ/x/16ob626iW1DDuFCJ6gC3jjY20/ziRuXC9JsHszDTbwk8b98SojWFr8yw0DbaoHqC675MeZmGuQ0jc8HZ7IKH0q/iSaGkV9TwW/98twxcFeoSwCdEtJAPdIF1w6Nnha2RcpsbSKrNTUGfjUsXVCw0FszfyMInK4nfYuULz/65FOl0gqe2CmZY6fgTPJK/LK6X5u92PDsuYVcSOHKQG1/gHq+N/79yNdefigaZf2MkZQIB0B8ZcGHUjuewEAB8hQHw9WhBz/i9d9HT3zQxH5C0RQppbJM3SGxIFjgQTAXWUJLYv8I9EOQjcmLuZEMTTXz5Oj3q6/xR7e4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmn+xRnKSGtQIicZhyD/lr/8Jjsxgyoot2OSa2cnruQ=;
 b=gG5riPDyroX9S90X+3MhxuNb64ukEfx8q8GOdFAt2qSGExzFzpDFeHNpnWzrNmouoWXvNxWW2Y2KwVwYF68IUZZRaU1NkbFNeFJkmli9q6Na/pnQ408ZSszN7l7xoKMG6V2o4jQEtq/WgDK2OKGMfnOXZM4B61gpBZKYI7Je0VziDJ1lmtcSL3Zt/pjFMk7bKYZ1lu9VruHTwKCv9ERe+qVE4VGC1OoBd8oWuviyxEynDA41MLAAes+C8dHNaRD68Kausjs4LFAqvvVZh/+vFUvJLGoKPvVFMTvzknbUsXmNYcquyYHVfub5FC0N20OtPpox6HEvMDj8Ws0z4sKq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmn+xRnKSGtQIicZhyD/lr/8Jjsxgyoot2OSa2cnruQ=;
 b=SWqaKI4APJMe2JmHdK8jhA1IVlljxYbK1HHPQu21RkCTr97ltyd9MWqBin1ooZTRUEvfUqlNgvPBF0/jd0vLRe19iK9tHbexBPJ+vVThN0wSx0JGYGm66OtB+IebLEIv8a/BRwqMFuNuy+ZWEJb0rbVVQNGOo9KxGMPULRhirA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8054.eurprd08.prod.outlook.com (2603:10a6:10:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 11:51:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:51:17 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 07 Dec 2023 12:51:08 +0100
Subject: [PATCH 3/4] usb: typec: tipd: declare in_data in as const in
 exec_cmd functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v1-3-dc21b5301d91@wolfvision.net>
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701949872; l=1739;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=EYKG2QkBt3Q9Z4VdE6eA++VrFA30t1cRvwGmQo1q76g=;
 b=5JVDfkXVegF6CIN4hukYujw0bL4v5DcLfO+MTuIQgMQM8NdRzJgWnpIyTFqr7w2OKq1yhPWNf
 yCM6XD8543ZB1Z30xxCSKbWvelha1z50OHjHLVftXVxsSobrC2mmpFo
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f2c7ea-5d21-4527-75fc-08dbf71ad075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fPf7PXstu/u5jGuW1bUcprz7uXc11inOwCt6yXMcDsdYqfiP3ERMxJ6fy7LGm9RrcSlhbb9ByWFW8mDLUYElwA2Yo95nNv92kVqB9yfhofQ/sM8wIuhbY/wPcNTdqTyU/EnA+uJsG/d4FPqh1563vVPlHqixfDpZx6jMm96JGPS8u/S7QWMCj47t6BTQ1SuNRALs6tk/NApE6slidZmw84PrM0ye9n7Baz18Qv/YjxzOU78Wyd1no+EHTx0ZVi6tVAmJYGi/JwgNYiCm7YPDgNavjSA5vVMVpx+TQ6CSoGXTChoK5sbC+lG5SLiAolwunxXUdA1afa7Tybf+z9ml3UgneRLzebh8zh6Q4ecMWw5z9ZK7Sm50ICRN+VlcHi9T1822CbTIsleS5e1MBbV9sAFYsByQ7TJK2w/pjlvtvVneQZMfA76V4ZxMLSVWL0IQuHYvYDM3eXOXxXnABL+iXOy3nOOPeuah0QQGlOF4QQCO/ZXkvnGX/V1wmSyPrxHVACw9jHKX+Aue0mJHG5kBvvffFU9SH8neblWsMZn3waMckzQmUMveD/wLUHQPWAu9eYo5QinUg+5u65RUNh7k+6vG4BYGb7AuKfIwEvRpMHpcVptN04eRtO/eAj0+uGb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(38100700002)(5660300002)(38350700005)(2906002)(2616005)(6512007)(83380400001)(6666004)(6506007)(107886003)(26005)(110136005)(36756003)(6486002)(478600001)(41300700001)(44832011)(66946007)(66556008)(66476007)(86362001)(8936002)(4326008)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzV4UDZXMTQvaC9pY3laakRZUFRRVDk4QTJLMnpZQ09uMS9NYWhoejUxVk5C?=
 =?utf-8?B?UGhDbnRQUmU5RlordDhDTjlWcTR2T2RMc0lRS3c0WXpiVlhibTR1STl1elBP?=
 =?utf-8?B?ayszN1hOclFjWWFPY2JZRWRRQTlQZm9NcGw2b0o4M3N0U2ROOFhzVEp4YjM3?=
 =?utf-8?B?QUVUdWhCaXhpZVZnYjRiMEVyeFluWlhiQTA3UXkrQmRHYzhVOGpwN0hPdzBW?=
 =?utf-8?B?QU5qQnloOFhtRkV2Y25mV2VvYmt0M0pkNzNhRFR2V0xiM3BQT1N5TWxIczJi?=
 =?utf-8?B?ZHdXNVRQZi9qS3Z4OG9UWGN6ZGoyeDRBYngrcmxLbzQ4T2pzMlJNSEVnc2dN?=
 =?utf-8?B?Mk1OcjBQQkh2Rzd2M2F3SkdZaUREemRwdjFQc3Q3WWwwM2g2TmJhRldIc3Vz?=
 =?utf-8?B?NWhUV0ZnUmw2cCs5c2VORUc5QU1YTURvbXlqSXRreWZkbkY1ajd4Y0pFRFdl?=
 =?utf-8?B?L0JGcUR6UlJsSmZZZS82VDZXWEFCaUZPMXpOb1lLc0lDTXk3L09JQ1JhVVBE?=
 =?utf-8?B?dVR2bFNMSERZaXdJTnVzMjNPeVEwd3ZQRkpMNEN5RytmZks2YnlCWlNsdnFJ?=
 =?utf-8?B?NDVjbUx4Y1NaNVdTTkRmWEV5Z0ZZUXB5SW8rMzZXWFlEejFuWXNKemVlaTdo?=
 =?utf-8?B?RE8wM2FpcG1pSDRJOUFMTTMrb0dGSEJldXN4eWcwbWo0WHlxSEpVVEJ6dGMz?=
 =?utf-8?B?N0xlUVoxaFdBYnF5K0ZxUFNFSyt4bWdYMi9GRFFLNFprdVl4OXQ3cVorMnZq?=
 =?utf-8?B?TUU3RUlkYXBDd1NreVpFWXVvL1NIejIyMnhuUkoreXZqb1dYSXUxWThlR0dl?=
 =?utf-8?B?OGl0dlF6eVpyR2hFQ1Q2K0VMcVlkbnhNWVI3WHA1QzVmTnpvYWhpZUpBenlX?=
 =?utf-8?B?Ykl4ZTdFc21Ja2M5RDhFQ1RqaFc2T1UxMzgwcmZXMGRoMkhwY1pyUnE3ajF0?=
 =?utf-8?B?L2ZneGxyRm5FSGVjZWF6RHdMZ2c3SUl3dHJoOHNOYVY2NGwzS1kxb3ZtWTJk?=
 =?utf-8?B?RVcyY1hwbmdQaG9sNDI3MGtob3JOak1EQXFualVTc2JmRHBjS3VBY0p4L0ow?=
 =?utf-8?B?dXhuZ3JKU2pieGRya2pUN095UE5zSnZLQTNoYy9GK1JBWUU5K2tkdmlWQjFM?=
 =?utf-8?B?U2hZWTVQdkhPblpHYUdNYWlCWW1oMEppSGdmN3NYZnNFNXZWYjNVSy80Mi9n?=
 =?utf-8?B?c0piNnpyaWhJUk9iaHNORUcrbUphekhWNUx2NzlXcmlYMWNWNUpmbERDaExw?=
 =?utf-8?B?QlVxZ05FQ0F4Z3ZObFJLRFBhVktpc0NzQlhOWVExWUtpeXVtb0V4MlhLeUhz?=
 =?utf-8?B?eEpSNjJKRmZTVmVObklOVUxjRVVHQ2IzM2NpTDhvQlgvci9rOXdSbUU2RU9N?=
 =?utf-8?B?NExsaEcxeVZFZW9UNStSMEQrNkpNamZGVlZBcEw5dmxadlRBTkNTemczZ3FN?=
 =?utf-8?B?TkhjTzM4UlBHWlpXMXZ1UFQvdkJEdk1kSFdxSno2QnJ2bURHc0VrMFo2S2V3?=
 =?utf-8?B?cVVHRE1NdE1OT3ZEbWRvMi9BVGdTbGFVYkJoS1pERU1KaWtvQnljZWpvYnFK?=
 =?utf-8?B?ZEpmV09qS1lMU3FNZWNTVVhDRURGN2hIdGpKNTQ5d28yeml3cEc5N2h5OFVV?=
 =?utf-8?B?c29PYzJuN2huNk9KMG5IV3B4d0Q4cnlDelZhbEZ2KzdCQjBjdDRFTDV5N1dT?=
 =?utf-8?B?eTdhM1FML1crSDBtcjIrRFhJelRkSFdFYlk2dE1WSFlESXo2dFF1ZXA0SXpn?=
 =?utf-8?B?YnRtdEYzUXF6bUFsbEhiRjEwZUZRUkE5ZWJDMnpVWDhSaDNLQW94S2pBYk1Z?=
 =?utf-8?B?aXhaRGJGQmxZR2tCK1ZGbDJFZzBDU24xRlowMk82Ym9Wakk1NHhueE9HZWJ6?=
 =?utf-8?B?RzVZelk3Zys1Mm5zVUlZazVmQXkrcVlPTkViRXBuM2Q5NzZjakJ6WFNpU0Nu?=
 =?utf-8?B?YndLc2VHaUxFbE02UnZoc0pLUGFjVjlHUkNGWXgweTBjYXd2UHdkcXJkazh5?=
 =?utf-8?B?Q1hqTEs1Qk1nM1BFbGNiZHAvVHlzVDFTZjNxSUJQWlZJTTJKeFFOREgxUUls?=
 =?utf-8?B?M3lydEdGb3JMbGd0UXVXcEVLVUtPVGl3Mkl4clMzY2psQlNOVjJPVXVRQkdh?=
 =?utf-8?B?aWhyL0o1bnIyeUtkWEN6T0N2ZXBQR09tVjZZMkZkKzl3c3lGNHJGTGpsQUhO?=
 =?utf-8?Q?SGr01Nvfdu/8ceWMh2l8WQo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f2c7ea-5d21-4527-75fc-08dbf71ad075
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:51:14.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpetL/K0PjQMRcgRwfRIqXkiRY7NvVzsiee9iNsmikvlenkpzmW/ggJxFVfgMAujR71M+gsomYXMMj19slePBiJpAYNrFR9RYO/ng/5Faug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input data passed to execute commands with tps6598x_exec_cmd()
is not supposed to be modified by the function. Moreover, this data is
passed to tps6598x_exec_cmd_tmo() and finally to tps6598x_block_write(),
which expects a const pointer.

The current implementation does not produce any bugs, but it discards
const qualifiers from the pointers passed as arguments. This leads to
compile issues if 'discarded-qualifiers' is active and a const pointer
is passed to the function, which is the case if data from a firmware
structure is passed to execute update commands. Adding the const
modifier to in_data prevents such issues and provides code consistency.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 165a1391dc72..cd5214c9799e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -330,7 +330,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 }
 
 static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
-			     size_t in_len, u8 *in_data,
+			     size_t in_len, const u8 *in_data,
 			     size_t out_len, u8 *out_data,
 			     u32 cmd_timeout_ms, u32 res_delay_ms)
 {
@@ -396,7 +396,7 @@ static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
 }
 
 static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
-			     size_t in_len, u8 *in_data,
+			     size_t in_len, const u8 *in_data,
 			     size_t out_len, u8 *out_data)
 {
 	return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data,

-- 
2.39.2

