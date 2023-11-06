Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39967E2052
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjKFLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:47:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095890;
        Mon,  6 Nov 2023 03:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd6Dz5r+9Lr7wSDYYs/FPbLVXj8EuFd3bnxPuDGsDGqJOzP2e2ZYQamwSpOmiz5J5UwpkC4zvPjpxQgS4Hi31vqWuPEurUcuupYoXwM4oj1etGnTuo2zQ7C9gYiyY6c8RZVSiQ9uU2EsOr11Dfk+F6cWqNjbeLW2hFTADvihPp4FqCqr7ufg8rPS7j5uUc8R3CN9yDEaEBZhVdPdzH9rNbHAQ9mBX4sZoJkms+Fi5Kz+tkaAwy88045WnrW6CdiAdFaXQCnhpKu23fx0z6xv/Q6f3ZUbc2JuLapvW2VlzXjXpvqktbYqkxFsdBXLidNZ0wbBCbm5jjdzKtDkvUyL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjHgu1gdsPjhOn8fV/3G0MCZGpSFSmjRG78+I0Cftws=;
 b=ZKUDkjrLvrhIZAY4v+PkYLl9/mwpzH9dBmKlZr3Xhgz2SqQC10tjEiUf9qvfBGau/Y/bNwoZH3tSEX9nQtZD4stYwt/TPcSgU/HqnQfg7Hzxu0AV1VL66jxPpbarQn+EY7foCdrKIf9Uj2e4nTbNiZeVOKoxLd6yOio4esP/UEI0oXowvouMgr4Euoeb9ss/thtTe+JUef+tggJmHpXcJyVhZhbZsd38IBfOsF2i1W7HSfwFCtVEonyQSpLE+AMiKpmbwE09AT4bSWMVOpm+60hOmXCm2nIK5pi7ByZFSUGdpFGmRwD2YXBdS/4WdgO+NN2AxAESF/STV9zv62AVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjHgu1gdsPjhOn8fV/3G0MCZGpSFSmjRG78+I0Cftws=;
 b=GyWZcnczCKbO1x6ZbN9HA5zvE4YtyH6OY3+DhmhL96YXZT6GVhkxI9fFPC/LuyWMXxFuX3KE3XGJqqnGUh+oyduc3psRZn+ZeLX98xxKD/x4lBabGkDZhcmUtzBFqAOLXK7VkAsZD0j4NKKf5ueTuNo8hQTbaHtUfanuW/xNYVHPpdhcB1OzdOK2L2gu6bgZ2KsAZYQdonNML/CUPDMJPRWRLM9lDpQL5Uqbj3IyE4MW4qrHDGf+eJk1EYiqNFxJ+SBQB1G35o+8EgeFOZVsd+JuAeu/oEuGgMwotaEqGoQ7e9OSOxa4EfRsIeQ46OqO+K5T3x87VXsLYIzWqaywxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 11:47:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:47:44 +0000
Message-ID: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
Date:   Mon, 6 Nov 2023 12:47:42 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 416ee883-df29-47cf-00bc-08dbdebe30ab
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27ZSPTV2flgKiQEer0eOsIz3jaAgySZ5gnHDhmmIn6FuvMjxeycF94DWosFoexBtxta0ZhewOf7k+kGtsSBrUf2ncWsLL2WVvv4rDAtLiGRkvtSJ/ooh1vri7c5J9PfVTg5odUBCi77LqutDZibd5vyCrlizA2uQXDg6LGY0iE3iYBUocuV4NKplj/6DxFTJzLGIyuQk3M3x4yHcy8WXKD7WdhNmrxIAanBP7UIpAJ59hivG8fl3Md8Y18AodxcsyXmLuUOz5jXG+HDE1p4UmtWMmXZesrZtksGpT4giSxtWx1xgQSWMmtchjMlzjXens1zkcGHYSwloGOtDrjg22v8ICdWdBI6heyEY3xX1ugxqp5ICwuz1lgPQcT81r4U/CSXvr2KI9IfRMgVLqsMFT3dsgpkBTfqtOt+Ge7Ne1L8TkkGGiNM3N9MhuxmNvxxxGHXJwNnKZ5Ox5bErpnT9dLi/KI4101HyDp11rHg6vuyVxBG3gkPDBfqPm34T9eTUkBMxx+Be7fdj/A49Q5JA0MgaROYdDgKmhUxB566A9MO2zJ4Vsg6/hkzZ5zgbbAdja5rGJTDbvp96k84BMk6g3GH/H7PxER0Drb5yHRoRPIYbqC8o64dpw8x6FI/+0S4EzBNQfiDqb8QkASrEOGuv6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6486002)(478600001)(6506007)(2616005)(2906002)(41300700001)(38100700002)(36756003)(82960400001)(86362001)(31696002)(66946007)(54906003)(5660300002)(66556008)(83380400001)(26005)(66476007)(44832011)(8936002)(110136005)(316002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tIanFOQU9oRytxR2JNYkkxRjNhMC9Ccldsa09CTFFoZTdDNkRnWHRhYytu?=
 =?utf-8?B?SUgxSTlkcmEwVjhzZGpndms5alpHWk1Bd1VKRGlqdWVZWWJJVkdDMFRaVUVS?=
 =?utf-8?B?SEVoYVBydnpibHorM09HZXcrR3llUDE5cHFrL0dPSGVHZXZNUkNxZmNQbTRw?=
 =?utf-8?B?OUw1TUZRS21KNTFyRWhDTkg1QWFNQSs2VG13Zi80czM0bDhmdDFoUXV5VUxu?=
 =?utf-8?B?UzhEeDBXdWZKOWl1Wms2alRCTkcwRTRYbnA5c2dKd2pqaTQ5R2IxdmNMZTU0?=
 =?utf-8?B?SUVwWDFuRUpEUFp0Wk9QV1FmT2wrR2ZUR2hxbHpkUzNZZE44TEVGaW9OMjFD?=
 =?utf-8?B?cDhrNlo2TFhBbk9raFJPNGhJeUhLNVhtN1ZpbjJHaFhWY0V6Y3NZSmlseFZP?=
 =?utf-8?B?aVFEN1U0TDRQS0NUUEtJNXB4MzI3TXVyQzVnSEp4Y3F5bHlGMlVQemg1ejRh?=
 =?utf-8?B?WTZiY2tBY0tod2srazRmMy9Rem5wdG5vZnprVHphZm9OTzRFdEFVZ2lVcytZ?=
 =?utf-8?B?cmlzbGFtai8rRVRXT1U4bkpTa245ZUhnSjU4NS9DN0p1TjVqMkx3SGxUMFhk?=
 =?utf-8?B?dlVJRW1JVDVocVJqUFhFbERQaGJQNkZzclFKS2pTSWdYUHZMdUhnUHFLa3NL?=
 =?utf-8?B?bW1hTU1zc3krUndzOTArMUFNKy8vSGJsWmluQkRaMXFCZjMwQUxKSjkzUlJU?=
 =?utf-8?B?VG9uL1FxdHJUb1NsdHR4NTNCdzBEQ0d4dncvSFdJaUxFTlV0UFlhczdmRytv?=
 =?utf-8?B?cXFyaEVtbGZ1eFJQc3IzWUVNQm55THNXYXQzOEhOR0NsVTlYT0crWFNyUjV0?=
 =?utf-8?B?SXBnR3JmZEtPYlhFMFM2dHRrZGk4NWUzdm9qTmdZUm9jbkRBZkUxcVZzZWxZ?=
 =?utf-8?B?VEY0cmdLS2pxeC9PdE9OdWc4UTlTUUcycmIvSWxHWldTcnYwNFZTK1o2dGFu?=
 =?utf-8?B?cGJ3TXE3eXdJVmFJUEdPc1RzNlhuMkxpdVpCVGJrMkw2Zi9qdFhvbkpTYXFJ?=
 =?utf-8?B?cUpYQThvN21FdDFxbjl6N241elU3RnB5amduQzh5MXYzV3pRU1dFVllCTmV1?=
 =?utf-8?B?RlV4TzV1SXlqdEdQNXV4T3F2MVAwSXA5Q2NPQm1CS3MxaUorMS9oMFVrMWJy?=
 =?utf-8?B?NHlSRFJaWU04a0dPU21DY2IxYkFyZEJFVi9RZ2VyandsWDQ2K0ZTWEtHbG01?=
 =?utf-8?B?amRyL3kxd29UWEN1dzFrWXNReHdFUTIzb280K2F5VUV3RU82bXQ5dzRkVlNV?=
 =?utf-8?B?THMyZzhJU09GdjdhNlFqazBKSkY4SDNMaTJsaHJycXkvU0VCK2o1dEc3bjRh?=
 =?utf-8?B?czZ5MUMwMTErQm91cktGOEUxbTY3RTNGY1NwTDVkS0p5VHlwWFc4ZjVhNm9E?=
 =?utf-8?B?RFlIWmpDS28vYUlkK3pyd2FvOFFweXRVaFEwM3BhYVdTZC81RXN6Sy85Kzlo?=
 =?utf-8?B?emN2aUNzVyt6cUsyUGk1ZHJkUkpYWWZCelgyQWdwZXVhRE43WjdyL1JIeDE0?=
 =?utf-8?B?V2lQQ3VCYnhEdGozaURKSTQrZUoxbkhkOWpwNnhnL2VxdldHdGhQaEhHeHI5?=
 =?utf-8?B?RWxjTDBvdHVFakc2ZWZ4YURabHF6cG90WkxxYmtadWx1VlJ5NEk1NHBEdENw?=
 =?utf-8?B?QXJXZ2VRYncrdXhmZWFOWThERG9ISlBJdkMrQ01zUEtPdWk5SmJoVklSWndT?=
 =?utf-8?B?dG83L3o1Q0YxZVh3RkovMXg1Sm43K2I2b2l5RXBnTHkrSklRUmhaQ0FhUXJh?=
 =?utf-8?B?NXBBa2tLa2lzS1VnaEY3bTN3bDNOMXZScVRUSGZzOUlVeG9CMXV0Y1BBc1NT?=
 =?utf-8?B?ZStkamZ2YnFFMjN0S3FKcURqZTJ3WlAwSmtYa003WkNyWlZFNmpJWVFLWENq?=
 =?utf-8?B?KzJyamx2SUxHNEwyY1NYektuKytRcng5NjJQaHQza1JZbDRPMzd4dExzbWx1?=
 =?utf-8?B?eFZMWHlaMytrTWpxbVh2RUh3Q1hTVVR2YURjQnVZVmY4YU5lR0NlM3U2ODh2?=
 =?utf-8?B?UG9DOVR4bnFPNXEwalpaUVZDL3k3cjV4ZDltWUFoWXFQcW9JbC93ZDdRb05K?=
 =?utf-8?B?aFhpSnIwYVA1UVV6eEE5bTFWeGlYT3MxbjhBQU8rc2taTWUxVUtTZkNGaTRJ?=
 =?utf-8?Q?BnaSEiLcKdCRR85/tz2IPna2T?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416ee883-df29-47cf-00bc-08dbdebe30ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:47:44.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtAUmg4Ny/h0J5KBETjfqAO9hCdc51gPjX9Cee2bhWqXPRR2VaOZ6+Pbr2gH8nd7cliYa6REIgB4TL5qq+5z4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to prueth_remove, just also taking care for NULL'ing the
iep pointers.

Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - consolidate cleanup logic further [Wojciech]
 - make sure to NULL iep pointers

Changes in v2:
 - add proper tags

This was lost from the TI SDK version while ripping out SR1.0 support - which we are currently restoring for upstream.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6c4b64227ac8..3abbeba26f1b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2105,10 +2105,7 @@ static int prueth_probe(struct platform_device *pdev)
 	prueth->iep1 = icss_iep_get_idx(np, 1);
 	if (IS_ERR(prueth->iep1)) {
 		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
-		icss_iep_put(prueth->iep0);
-		prueth->iep0 = NULL;
-		prueth->iep1 = NULL;
-		goto free_pool;
+		goto put_iep0;
 	}
 
 	if (prueth->pdata.quirk_10m_link_issue) {
@@ -2205,6 +2202,12 @@ static int prueth_probe(struct platform_device *pdev)
 exit_iep:
 	if (prueth->pdata.quirk_10m_link_issue)
 		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_put(prueth->iep1);
+
+put_iep0:
+	icss_iep_put(prueth->iep0);
+	prueth->iep0 = NULL;
+	prueth->iep1 = NULL;
 
 free_pool:
 	gen_pool_free(prueth->sram_pool,
-- 
2.35.3
