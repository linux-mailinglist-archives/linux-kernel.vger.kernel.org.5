Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1E7519D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjGMHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjGMHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:23:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A5271D;
        Thu, 13 Jul 2023 00:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjJJW2aqBBbmok5gbYfqhXOwlfI5txr5H2PKHNUwLtCl1C8Ld1R5u+4gii81i5vsNZhIAW/iLpv0acJgHfNUdf80eAP6YNi2DOGNwn4UJr7jBrZafGQQz5467MqtPKoyP7LJ+wYYHtaQBz2wUnbYnDFZEIxOpiFWVa7Zjgof4CzoPWBvg69Ae3BIlmsHLu6Ok8dTIRLRFFcYf6r+D6lH/eO0zjbmPCqPZVGyHSA54E29GhRnxznur1XvFTvDQVsQkAs1FNs4uB3z1QFvZKrixqxT955z/YPwU4ug3ZeSfPFUUrm2IhZ5F77v3ujc3fswkYDtMbSMX7RaPC9YSOQtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RomN9jOvbc9peRu8eOjuyoopCNiUvCn7T+UUcVQ1s0=;
 b=GjRmcU+1Fc0uSeIaymzgyveQGuXSF1I3Exjidb4dRKt3vLUl+NHbjjst6ocxYMnZk3TywCB+Rkr62BY1zDGKvqF1vzAuBrLG/9ycn8HJWdMTPj37tE6HLQuVNbvYuJg21o+lEhqSROLX9WTaHv9Z/IlzE8+t+SRraUpl4eNNpm2fhg5EsMZFCca5jvKJhHIB06D8mBMZgBb8wf/Hp70rx3uv/6Q5oDqmPn2ueaOv3cxyG1GX/zr+qiJSVAoB0iLZe6hQFEfEjUAQaBukcyxct/v9nVqPNK3NWFgXt5wYibWozR+GcRjNs8R02ISvGrNjnCmabBctF6++lz2zHhfBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RomN9jOvbc9peRu8eOjuyoopCNiUvCn7T+UUcVQ1s0=;
 b=H1DNFLCK/49QNFguqj6SUmWe6S+/mIMDG4eBqI7KWoe/hgznVaFhwoUKlPs69fvwUZ2NAmx+vX4GzA10gbqaf+KTAPPJhs8Rnmep3YRIYXMLaXZMLidhAofIFl/KPlHrDrTNP3tzW25zobJIms3VR2LSylXYH8/3562/HtvxVeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:23:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 07:23:14 +0000
Message-ID: <a4aa4bda-a1ab-ba32-e77c-28401ca1b8a9@oss.nxp.com>
Date:   Thu, 13 Jul 2023 15:23:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] arm64: dts: imx8qm-mek: delete A72 thermal zone
To:     Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
 <20230712211755.1538847-3-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230712211755.1538847-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f362318-8880-40d2-eac3-08db83720542
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXrKTKiyAluO+JmwCE/3LCWS83a0sjIIIzNxzdKMZB+PvmCAanOlN6hBExmpk0SSXoC9H46895fJP8jRblePur03Me8N8fjtX3aO4SRac+++8UppXyCE7VoqDBKdj89eYhwA+KpYaZdo1uIPCR9Z3hu73yzZEzz/2OTKMxD2zlmtGpprGFD0p+fpBt1zYNqI8yiRbH0YQglH16NCv0rzjjdLdlg8yxajIU5qacCWv/lp0aFisDYymS2S46cv8arOcZsia+0kb3NbZJh9eixtVb+MYG4VLWc0YdFdMrP+C7AtUnVyA7ffQaXmkZ2sCH6Y1kwpJDf/P47cGxuIeA/7g4Rbcri6huWugya5TL0zF7hXDqvlfI9cXETXwmSQEBXRnRw+QxElj+ILh4LlCFBcJGmcS+j6si0YdL55CRYrf77UL3RqN/BKmBZkvF5jmjpUaaAUEDcwPB6rWI/kxoTQ5rK5EBdo9hceCp8YHOj6fLky555fM8r94f1PmtlHsXMLbr1n7N1Rr8VKd3lZyRvabL9EHS1+UekNnuAbddJayneJl8ixN6FHAralh0AqZJssMfrSYmkPavcemxBjr1SRwj22x9s69QbXGjyZyc2mQzFcJcc9g74ic85UBWMUbAJOL8EwgrhHNlV+pOTnZ1OrHoLQW02e4rj3GcfTyVUmBWFFVV5b1S8cENytrzHwLRqv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(6512007)(38100700002)(921005)(83380400001)(2616005)(53546011)(26005)(186003)(31696002)(6506007)(86362001)(5660300002)(558084003)(8676002)(44832011)(7416002)(8936002)(110136005)(478600001)(6666004)(66556008)(66946007)(41300700001)(4326008)(316002)(66476007)(6486002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdVeWFJLzBEOEQxSE53b0xpODNkaGZiUWlmV0IxN3V2SS9YNEo5SGxMR2NM?=
 =?utf-8?B?S1lON2dsTXo0bFhCTXpuaFBlZk9HS1JkQmg5aGkzREVqT0VIaVVsMS9FcURm?=
 =?utf-8?B?QzJKSTJTVXd1VXk3RXlXcWlzQkg4UDNGcldGTjh6M3Y3QU4vR0hTMVY4S2Rs?=
 =?utf-8?B?QUlBMjZYa2tjTm5seVkwcUFVa2NlZ0hRQ1NXQmNmMC85TFJ6M2Q1SlZ4Szlk?=
 =?utf-8?B?VSs0V2VISGlWc2Vjb2QwYUZsT3YzdkJBQWFmNmZCcVNFSU9WWGNMR1lMcERn?=
 =?utf-8?B?bGRQdk5ZQU0rTTM5bW5nK1piYmFTV0tVelU1akpKZSt1clRFMUxpUzBGakdW?=
 =?utf-8?B?RTNkMjZCNllDcjQvYmFRQ0tGdThtaENKaTRTTW1aSzNkczR1YWVsNXRTeWRR?=
 =?utf-8?B?SFV0cm43Y1ZaWnppcGI3YkgwRHF1dkxHbTNuS3ovcEJIazlGZllvUXV0ak9G?=
 =?utf-8?B?Q0NVczVWTE1XYytuN3ZseHVLWi83VUpXOFBrNHZBUEY5TlhOZjZrMFBOSys0?=
 =?utf-8?B?OW43QU5ZQXd4Ynd1Z1pXcTQrdDhMRFpSeFlCWnhKdFRNbTVmVkNFdUtOWTdD?=
 =?utf-8?B?NW5sQmFVeUkwc0J6cmdKVDJJZWFrVlFxckVoWVNRdjZ5ayt6VlJKSUlOcjNH?=
 =?utf-8?B?UFFxVm1jUnlJWTZ2SzVNa3VndWxXUG51VmlHd0MrWGxjNW9pTENkeTJ6QVh5?=
 =?utf-8?B?cGRSSUFyVVVxaFNrVUhMZ1dUdjQwY2d4dHF6bCtuV2ozTDNpbnR1MTM4Skxn?=
 =?utf-8?B?STE3UDl5UUJxQ2QrdjBaUCtaMWwzQlA2SEhzblphRGxsTDFyTUQxTFdMOEph?=
 =?utf-8?B?cGVwWE8vcy9VekhZZXBzeG5telg4RHpBVHYzYmlRQTZWemFNSHBMN3d6WWNX?=
 =?utf-8?B?VlJXQXBPRWp4eHlpTkhPNUVDZDhyZnAwby9BMmV3blYyRzdVZHFJelRzK09G?=
 =?utf-8?B?ZElYMm5ERzd4bVY0UkszRlFEQnFad3NvMUVuVHJtL0FuUGkvMC9GcFFUTy9J?=
 =?utf-8?B?UXZZbGNqWWZjVG1VdG9MZ3dNMnA0a3ltU1Q0WU1lSHh6M0xUbDlJVU1OTVpD?=
 =?utf-8?B?L1lLMWNZbzNGckQ5OWt5NlJwRFhwejlnYWJVQTNtUmN5RWdkaWxZQlRpT1RL?=
 =?utf-8?B?Vzk5enFMVEw1MWNnMlF2cEpQci90dTBzKzVWMWRlUjE2bHA0YWtDOG95WTRF?=
 =?utf-8?B?RVZub2cwMEc3VkF4M1ZoMEFNMDc5R1ZmL2F5QmplNUVmVlRKMlB1UWFSRE5W?=
 =?utf-8?B?YmF3SE1uTEk0WXh3Qk42TWs4blVJbkVDUVZxMDJyUXA2dkxxRHU3dzdacFlK?=
 =?utf-8?B?bjFUeEtlcURpNEpLZ0pKRXZLRE1EYXdUYVh3Sk9FbWNJdjV4R3N2UUd6NmF3?=
 =?utf-8?B?UFBxN1ZVKzBvSWxYWmhFdE1jaFJEZXJEQXRrVElTZnpXNHV6YzhZbTBiR09j?=
 =?utf-8?B?WXpMdThaSy8rbDl2eVVRVHlXOFZlWjl2SzV5MGtIazlQTTliSkh0Tk80eDE0?=
 =?utf-8?B?Nlo2ZnE1SUlZUjdZK1JKVTZYdHErSnQrNXREbGV3dFh1OXRtMi9RQ1RTVXA2?=
 =?utf-8?B?YlRqcDFBM0JXVjhaWDc4RmhSVGFOYSs4b3cwMzVjd2YxdXQvWGJGVENDcWth?=
 =?utf-8?B?MmtuK0hGUDUrVHVLajZENjlITjRDZUZUTFI0R3hxZlZ6bXN3QmZjc1p3VnhH?=
 =?utf-8?B?RTd4dGNHQU9VVy9Xb1dFMU92U0p1dlc3M2lmRlo1dmQyVlJpVTE5bG5TZ21n?=
 =?utf-8?B?Q3V5Y0ZiNnc3azk3RXBhRkk0SHc4VEU1aDdnZkFTYWJVMFkycGtSOFVhM1Rw?=
 =?utf-8?B?cUw5ZG81ZzlsMkRmeitydTBnSzVRaHllR3BpdGdXcUR0MHZpMmNPN1NrRWZx?=
 =?utf-8?B?SkMrM21JV1lTVjFjUmRiSUpwQThCaHBxdmdzSEs2UldjSTNLV28yTWY4cVUx?=
 =?utf-8?B?dWxBc1ZZakVET1dmVE42cTQxeTlnN0lPRXkyd1NOYk1PY3hKU3FXcURLbkxU?=
 =?utf-8?B?dmhiN1ZXQmgrakM4eTBHcUtoMDk3U0l6STdCZ0tONVNDaXMyaVRjQkdRaHJq?=
 =?utf-8?B?TC9YNjZlcjcxTW5JV1kxcWFHT1FqZjZnMmI1ZkhzVVRyZ01GdEthT3ZyRmx6?=
 =?utf-8?Q?gwtFi3Z0uAYpHFP7A4RFLEM9W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f362318-8880-40d2-eac3-08db83720542
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:23:14.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5cGDanM9Z7rxRsx6SwA9uDbddoNp+NEVUqGP5ZM6tqgqx+2YBAS43fV0eGqytvAuj3ez89efMzYH2x3BM9EIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 5:17 AM, Frank Li wrote:
> The A72 nodes have been deleted in this DTB. Removes the corresponding
> thermal zone to ensure a successful build.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
