Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340E7DF753
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377065AbjKBQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjKBQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:03:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2668E;
        Thu,  2 Nov 2023 09:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu9h0oThXc1mtB4oVaAWTVDEwiZX0xR2wD1sH+VmCv8EOFLKRlZ1NdIM7PUsQnOUBqD7v6xgD5Ni2jszsOxYlAY4ATiMwxz4mJl921RJ05P79/S3jxbqzS5vzkSGYTRPKxd2ZCAJSWUBrzJAR/lq2hj8yYUJ58UpQ4VlD7Ob5kLHj2/Yj4/Cfi90GU7U/ZsUBE3+Wv82rMmSXYjufIHjWXJ24ZZleIv812HphXqHiGGdt70zeRlA6B8nW/oENOjTejHLHkulhv1BUVi8zpyBsbv/hlm2oVvCC4gZkob6lRmdu4857y2KnKJcD6UprBUf2ooEaPuhBC+P7SQ4/82YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+4VQRknpttP0AycKsosOfeASDoNhaMJvH5V0cmo7Jo=;
 b=PIoBCcJG/6A6otoULdo/LoAnLzi8ZZTOiHLLDE14FMWyB/dZAPxY7mWJ6Sy2Fds48f9mY9466xn+9MnRna4h9lxNvprQmmBoet7FbXpq1YX2dniJu9mbuSZsWUZufpEgkX4U9EXiQyK0xNqL+GJNnh7yvKmhCTIpEf9YSvwY1hutbu66P53JlwqeXOC1ByNst3K1xLHYXcETrNlfkrGu+c3J0ie7/tNR/T6tsJ+Q7gP6Ou/ixaplDXrtjd2eQStMEvy9hj9UFkvJRISDI8qXsLZbzO3b4+WlOiwibUNf9Tvh2Zz2+LxWGsyzoxck5H+pWSFEMUHKjJJnwyKj7MfpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+4VQRknpttP0AycKsosOfeASDoNhaMJvH5V0cmo7Jo=;
 b=aUOdniCWB+fqJBfcQFnxQBKIEXH4guMM+hAzaWkma14L+yAbF0NFj357OGJ9U4KWjdWP5TICUtWPNEonxgf8ru/ke8/7f31novTWM4uaizOwHmue1cs1VutWv9UeRKXGiWCwp1K3E1cNnrH9qZPfxSJZJIBDasQRt0YZ3zZED38+1cW9E6RGbOiNKTlKpk+oydXjbhhmJYRu83y71lTp1LvNczSuKcmMEuwIXUdlUn27DUgmwztn5302TBDqUSpBSo9a3gHBtxx8bCrrLyqyVHG64en62SWLcqhYlAQU78Tjv0+g/PfrXTc4qfI+5ViJ87+bQXgpXhZz5TA8tG16UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 16:03:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 16:03:32 +0000
Message-ID: <0b21ba4e-5c47-4625-a9ec-e45e54ba9229@siemens.com>
Date:   Thu, 2 Nov 2023 17:03:30 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] net: ti: icssg-prueth: Add missing icss_iep_put to error path
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: e07bc7ee-3b1c-430d-4c60-08dbdbbd4309
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWsU2iVLaIx1JkFh1U3gc0l5Nk33EMxAdQf7F+4TRH+gj9vYlZzrOrWlFUrSHJFEGpJJIrIS5um4ApHHIEIlsE/+0B2usgUwk56bnHA0lHMZxDxY2Js6EMEV4R9YYsDyLMzmiPCSeh8s2zKQXjcBk1yy3OQQYccByUFFmURx/kGmaWe3CcZGr/LvoIKBqZI6ZMFqKjv/5IA1ApNNN3+ihCUcrMrsoNIKClgd2P7ryLPsbslKa6fCRyRmJPbXmbFST6dRvkrk2oNuQ4inx3zIKf7q8AGP8ar2ImxpUXV6/xw82FMU/mcmAyn+P82eZIGqmCCOftI6jD6lQpGa/xAYY4ysDOElL6Qe1lCJjg0cHUJ4Trq4BugxVMVkw/MmK75TQduTrxo/YYhbckhUmgapnMzAyrFheKBI/dK6tvPKcVp2SWa7X/QxRq+/RTMIaDt8ofsVt3AL4C84Legiz7+r2jyY3EygyYVMdHKBJg+SdP9NUksBU7z3JC2LakDS2phWHUEmbWys7l0ZU3K6UCML7zMtOieufOGa9DvO+roJ1LviZ/wOAl92IPp6uIxMMxm2tsoe4adJXFYkPk8rt4ztX74wKWm9bY5LhxcnEXKV/5E8W8B8B8FHSjKFSdFCyNYFlWU23eOea7Qh8bTXtlVeHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(2616005)(6512007)(6506007)(5660300002)(4744005)(2906002)(4326008)(107886003)(110136005)(41300700001)(44832011)(54906003)(8936002)(66476007)(8676002)(478600001)(6486002)(66946007)(316002)(66556008)(38100700002)(82960400001)(86362001)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZHTG42TS9jNHZNZHhrOU12YVgvczA3aVZzZFI2Z25TZFBlby9QeklxVTVp?=
 =?utf-8?B?REwwbjdGaFg5NHd6VWc0Q3JWdHVDVHBjZFdFaWFEMjNTM1p1NklraTVyR2lI?=
 =?utf-8?B?V1plS1pjUG5hb1pobjB4VmFCTVlSNGxHN0JvWWQ1ckEwZlBudHA5UlVnWjlN?=
 =?utf-8?B?ekF6KzM2Vm9tK2Rkb1dxUWwzb1JURjlHYVhHUnc4dTQ4eGpZTVljOVpjK2ZM?=
 =?utf-8?B?bTZSQ3FXNmhSRGlSS1V0OXNHK1AyVXFER2creE9VdFc3SEFzWVhTR1VWNWF1?=
 =?utf-8?B?bXBiYU9JSjdacktwVmt2WkF1Q1l6RkVjUHFDY3IrK29uTzlINU5xQlNxTUQv?=
 =?utf-8?B?S0pmVGhDWGZUL21lTHdWMHZtVm10bVo0WG1XNUozWGRYMjcxK2FPTEpJeHQ1?=
 =?utf-8?B?bDRuRklWNWU1aDViYlo2MnJIVHd2TGVXVWhlektKTTA4dGN6S2VvY0MzTWRx?=
 =?utf-8?B?NklwbkJNMG9mU1BBc3RwekRnSlFvWmcvUGo3Wmp3SHJva29YaVlvMFRYeWUv?=
 =?utf-8?B?MzJ0bzMyaVY2UGZENmxyRjVzTHZlVnhrS1lEcGRZTGJ0ZWwvYVhiUUpOR2F2?=
 =?utf-8?B?ckhoTmwxaW1TVVNlQmNIL2liUW1TaC9ZejdhUzlzRjRmclgvTi9kcUtEcVNU?=
 =?utf-8?B?bjZLUXRYMEt3NkFmbjZoUkl4VUxORFpkZms1UWh0L1BwSGhRTytvTmhacjFV?=
 =?utf-8?B?TGdlcDBxS1J6RmpubEFYOVBBZjFMeVVKMnNMS3crQkNYcFVpTlFpNmprbng3?=
 =?utf-8?B?QzhmQTEyVzM0QVhLQ01aS1daSm1FaHlJUkh0VTg5a3pKQlYyN2pyWG9TRnNE?=
 =?utf-8?B?eFBMK0xBM1NXTnp0WlhWcklHRkU5WUx0UEpEZzNxREZpQWs4VG9PTVI4UWhJ?=
 =?utf-8?B?K2dTYlJjb0JUeEpFWDhRK2NSZUZ1aUEzV0dnMlFWbVJmR1g0Zit1Z2xuOFNo?=
 =?utf-8?B?VklLMFdWOHNFYVlCWksra0ozb0VHdXRKYWprQitsalRJbWdJeHZCZHIweEVp?=
 =?utf-8?B?QXRNSDdPekIvdGJkVFIvakVqeUVleEZ5a1FURkordzBqVXpDTlZ2VzZ2Mkp5?=
 =?utf-8?B?Z1lMUWVqYzhKelVSTUljRDR4MHU4aUJJQStkREo5Q1g4b3l6Y3dSaDVGQWdj?=
 =?utf-8?B?V0NxWS9aZDhoclYvUWJsbzZTcWhrRkw0TTBjTzEreVVxOEZkNnVwU1FuRzlX?=
 =?utf-8?B?aVJtTXBobDVGSXcxRHZqZFpSVVZPOXFhaVZveDhjZHdFcGlMRWNUU3RrWnpI?=
 =?utf-8?B?L0ZUdld3azdDY2dkejJFWnFndXJHTE9pR2pvMFpPVmhjTzd3VllKYzJ1UWg0?=
 =?utf-8?B?VFFKaW5QbzdDWlplS1djbW1tZW1yRXBEcldWb0hjdURBeUdCNlJOZExtUFdy?=
 =?utf-8?B?TlpEL3plcVVJalJtOHJyV0hHMFBWMmx1Qld3dGxrNmMwczVCaFRhU0c5SHZM?=
 =?utf-8?B?cHBpbTZkQjJpVUVYQlI4TFE0d0NLQ2dkcldBRVBUWTl2S2UramM3d003bVp4?=
 =?utf-8?B?ZGoyYnZkZUswd1BiRWV4ZklhQmxNRWhpdXVFWENCRjd5emNYaEtRdkliQmY3?=
 =?utf-8?B?UGJtUGZFUHg2ZEFmSFhWWTloNGVEaXNrUjFSTysvUGs1NWJGRnRvOFgwem0v?=
 =?utf-8?B?OFdhYk1IRURoRCtPaEM2d3lsOGFWZXV4UkRlbVJHL1NTMEZkc1ZSMWkwb3Vz?=
 =?utf-8?B?MXNjS2hvQVlkRHA3dncrMXJoMW03dnlJbnpRUDhwL1d1cFpjakRQUTExQ3R0?=
 =?utf-8?B?WlAyRzZwZE9YUlY3bDdRYUtzWjRZUEdLbThLMlVhK2hQWVVqYitWNDR4WEhr?=
 =?utf-8?B?MktSM1dkbit3d05uMTE4Q0JEVlZHU21LUEYvTVZia3F2eGNlTkFyckUyZFBx?=
 =?utf-8?B?VXJLODBMUnBPRmxvOHhuM3lud2ZUSUppUlFLbEZwNlcrU05iMTlvOU5hV1Na?=
 =?utf-8?B?L0cyZUtBQVQvcWtPNThDbHZhZnFGZTZ0dWp6SExvYUZjd2g4RU56eHNSUm55?=
 =?utf-8?B?S3lsTVR4azBNSy9CbUhnWm00Z1U0eWR2UFRncmNUVGJvM293R3VPd2UxcFRr?=
 =?utf-8?B?YTRXNXZFL3l5MEpaUFZkZ3VmRDFTMmZDWWozclhRQTFwdWYydHhYYTJnV0Fm?=
 =?utf-8?B?N3dta09Eb28zdEFDZUpuZDVXZ2R3UWNvdkwrclpJMDdEYVB4dkVuY1llV1VI?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07bc7ee-3b1c-430d-4c60-08dbdbbd4309
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 16:03:32.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLz3qO/JvWoodMSF3gQQ/euHGitA35hWylNyySa59nzW1XzTNfdIE+6UafHEOt9EdMCEMmRgD+q0MBVNSoAXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to prueth_remove.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This was lost from the TI SDK version while ripping out SR1.0 support - 
which we are currently restoring for upstream.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ffae89a6ccc5..0242e123fc05 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2200,6 +2200,9 @@ static int prueth_probe(struct platform_device *pdev)
 	if (prueth->pdata.quirk_10m_link_issue)
 		icss_iep_exit_fw(prueth->iep1);
 
+	icss_iep_put(prueth->iep1);
+	icss_iep_put(prueth->iep0);
+
 free_pool:
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
-- 
2.35.3
