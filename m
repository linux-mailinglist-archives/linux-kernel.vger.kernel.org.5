Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8247519E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjGMH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjGMH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:26:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B052709;
        Thu, 13 Jul 2023 00:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhwsXO58K9DMFknT6Gnwvpud3/zeQaY+MLiXJXOjjoTRXhlZh2wCQC509HMoh4dCxkQ5fW/9mDcYtkC07T7L3MPmDWQK+r5AEvebiUXeTSaBjTpelbBhGLKB6BUlzG0GfNk1zS0vqrvQClJD5fUxyEShwxwgQ7zMyzuyaeAcCmVOCq492Uyo1iGjM9zARHHCRc3JhgJ0uAPnD8quzGqLxlk85Es62u/f4ty/dTWRJt4WdFk1UewjkM8tZ4JffGib9r1O/ZqrDaI8BP1To1FJXIH1rJbQd08YOLU1MISpGfiHOlHOAOCOZqD7V4VWzid+ak+JPRQwR4/1V+8wlVbLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Giu/Bzem15AO1cgiU9G6BxYKbGRophpzFPgxCFXm6E=;
 b=j2M2tSG9uBaAMF02pKGSl38oAMAWO1j4wGpQuzayz+aSt0xix0AIhzzMBpdDsbrjr2a/+W3r4M40vkqxcSdeXxhhEcG7aVKOE/iUd2AXUq4bkDybnSTea+YjZIF5WYzyn7eKCL+Z+JcLiDXDX8CnNDzs5FFaByG+35/wy+7dTquq4MPE+bBKPDHucwF17k5rJZ1EOmHLccmJCW2PoUuxy88uwfwRoSF7Mlvu1tNMPPEcJkQ5/rzYHTwAHAXtBEvgQZjV37ZNE+p6T8Xo8+XeNRQVEPLYWH6qmolQc0anB1P+3cqydJM6YqKQLlhViACM8I+LkE4YH7l/ovSKQlEdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Giu/Bzem15AO1cgiU9G6BxYKbGRophpzFPgxCFXm6E=;
 b=ff/dN+GkhpghMtAeF0fZd1CkqLC2GU2Bi/hgPeH5Cdr8u0zvhIvRMcUCuFIttdjngKA6BiQTk3AuL/4TQrsYG2k/LzcTOx1bnvpqjqQvwDkEPYoKXBoWIZAXvKHzqyNSVW0iiGDclooz5jkWQVOvojsDTA5ztk56y0kaF9pnvHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:26:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 07:26:09 +0000
Message-ID: <55cda9a7-e839-c413-e96e-764e551c2ff2@oss.nxp.com>
Date:   Thu, 13 Jul 2023 15:25:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: add cpu-supply node for
 cpufreq
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606153238.1448463-1-tharvey@gateworks.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230606153238.1448463-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: cf711610-438c-4dad-9465-08db83726d4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tnvG4IgaNQ6uLJ6i+jCGML4Aftt/62UBqFPPdNqu90+lMnto/x8y9BQs/DhRyPKivtZ3qU3c+DoqBKRhPoJnFUVfPeW71mOgz8Vs/T5cTZLOxXbYqJZd8Q8osMU3DdHtaKxgIIYg9wombnFSx9y2kGH7fi59cOlQVF7D5Qxe3zGC587uFzcRsUazQP8T2dB7iXaR+c8twC4fTj80BZ7KFqdPWN9NhAtIG8U3es6epDvXZPNzkWJ4dmrkRm04FUIyepg4j7h1n1aHPFmQydHCcmxWh4qvzLXW3uwfAunOuUQkrKV9jmuEIx65bZmSH3vir8aSR2HHxFODbWjSH40ymLIx5754Ej/Bd6pMoBjrtzPiJXVQjBTZRvCQf9UDnyKyK9G+HxRg1wuNlBsWaaFpMpw7m9U4nyBj53XuTYnfh4BAnbWhe+XXoSWbTyAbhQnzp8NiEPJ2qCbwPOrBSp3Hz1+evqXh8VDWVhqTXsq+kj90FWhGUgQnfIddp+kHIJ7jq5a0OilGvEAbCADPwrA+e0M4LH6GZQOLwV+0MXt8HDufy8pqpb7tzq3Zr2hm1/2sdLBYLMlBR6pyuxJBOpc54sxf4agy7nRrGjU4eR+iLeqMiAfz7ZAdvM5mQHyePGRYuE/MERG6+DkEPkRa1N/WA0Jr1wWd01s5eddpK6ovIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(6512007)(38100700002)(83380400001)(2616005)(53546011)(26005)(186003)(31696002)(6506007)(86362001)(5660300002)(558084003)(8676002)(44832011)(7416002)(8936002)(478600001)(54906003)(6666004)(66556008)(66946007)(41300700001)(4326008)(316002)(66476007)(6486002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JDLzZKSEU2UU1UUG1SdVBZZUtJbGdBdUFGR3crOE5QR1RZWHRTdExJVnpW?=
 =?utf-8?B?cWlZOUt6NEtDRFZDVDlQK2Nsa3lvMHFuZ3BrMXFXU1hXZWRSaXNtOFBxWUZB?=
 =?utf-8?B?Y3dxVEt5Q3N5bHhtc0VpL3hpWE5TMEFaUW1CMXFCUmtTZ1pacUhOVXFRdVBz?=
 =?utf-8?B?K2hobnQrMXhsWHc4Yjd4aWUvS2ZVZEdFVG5pOHoyK2YwNWRjT3kwZkMrdk44?=
 =?utf-8?B?a1A1cTBWbVR0VmNaWHE2N1VmUTNlUy91U0s5WDdISXJtZ2swYVd4bzFzTWtC?=
 =?utf-8?B?Wk1sL2wrRjJNT0NYcEtQWms0U1QwM1JzT3MrWVFJMk00RUVqcC95d2h2ZmlN?=
 =?utf-8?B?MndaYVN1YS9rckxRN1lKdSsvU0pta1pzcWFXVTJkUjcrUkFtbkoyN2xidXZp?=
 =?utf-8?B?em01ZGpMU1R2bk10UUNXUzJJNTVXZ2Y0eEZVMUZsNHNKZEhKSys2K2VYd1ZW?=
 =?utf-8?B?WWRBUlpVU0tONERoL3BnaEdUaktoOWtZcXIwMi9vS0RtNjFNb2c0UkExQ3B5?=
 =?utf-8?B?UkQ0NEx4ZGdvRlBWZTFkL2VTS0NjQk5qMDVFWTJvaGxkVW51RmRqaTQxNDIy?=
 =?utf-8?B?dEVPR3ExSnR1Y2N1d0V5SUNyU1NyZU43aCt4bTVCYkJBUkgzRGFDem9TMDVa?=
 =?utf-8?B?NGhDMlIwUFJZSUZ4N3hPWDJ0cXhmcXNIZmd6UXA0a0lsZlFtVXkyR2p1NDRP?=
 =?utf-8?B?aVdoeCsrc2tjYmEyZ3lMbkdkeUlTb0VTTTJDaVkvblBwUlJqUFJGdGJPU05z?=
 =?utf-8?B?M0RpV3V0MTZTMnZXUW9kNlpXaWwwenNQOS9nZC9WNHZGcStwSmhHYVZSY2xG?=
 =?utf-8?B?bU9MdnRJcE1GaGtvSm1LbENoZ0Nyaks3Zkxxd2dHZUhJT2xKY0FYZWZQNkdr?=
 =?utf-8?B?WldBMTV2WWpPZW9TR052cFVkeDFRc1RiSnhjSkNuK3VsVnIzcTEvT3k0ZEZj?=
 =?utf-8?B?RExpYWhUdUtXSldXV3k4TWRaVERzcWNjZUU4dlpld2pHcXBZNlJxUndsK1Zr?=
 =?utf-8?B?ZERuV0liVUo2a0tka3VTUjM3UndrMDV5UTZHa0VLODZET2xsTVJmekhjcEsz?=
 =?utf-8?B?YWdlOWExMzRiR2JVRmNtRU5taUFYY3ZCaSt6OUNNMlVCT3lPcFVhb05oSFN6?=
 =?utf-8?B?MWtwUElhRVVueDJYNWZ4MXdTeFVRZzFFUzh0eDJIRkRnd25nNHFqcmNNUkd1?=
 =?utf-8?B?aE1YZ3NqVWsxT090bzVuYUFiT0FpcjdwSVlSNk85bmFDMXpRWW91MGd4V2ln?=
 =?utf-8?B?Y3dWMkVvSlM2Rm5ob0ZSSnBtajdKTkxXekRwVFdCck1raFBEQTZiZUgrZmhL?=
 =?utf-8?B?d0FNendiQkQwSWVuQ3cycnZnVnRkOFVaY0RHT3hlQ2hoMFRvb1RPT2JGaFlm?=
 =?utf-8?B?S3EyQ0FsOGl0ZU5hbTc0WTdUeGlQeXluckhlWm9jclRXL2lkaDVkY1VNcVRL?=
 =?utf-8?B?OGZHZzN4cElhamRFMWRUczE0NGFnSEMrVkxIMzEvSEM1ektmbmZGTUx6Zi9h?=
 =?utf-8?B?aXhBcmxNSVpWSmRxSkprcjlEZzBkZkFlQ3NucDhFTEJLcC9qMmpxbGhBZWRD?=
 =?utf-8?B?aGdTTDN2RENwemRZT2ovMDQzeDdkM2hlTVNNZ3EyUnZTZktvbDY0ejNXd0lF?=
 =?utf-8?B?ZjVjSnRWTmx0cm9KTWdrMGZzeW5udG5Ncm54WE42MUQ2Zm5HQ1ZRamxmQi9n?=
 =?utf-8?B?ZDd5YmNscEtRUjRncmJPNnRrbWZ3enY4VEFoUUdWSUsvL1Z2dFlSZDh0YUMz?=
 =?utf-8?B?OEJZQVpZMURsMWxFUFFWdDVwempLRlk3SHRLemFMcHgreHN1V1RlTVYyUnFr?=
 =?utf-8?B?eDI0NmVSY0dLV242ZGNkVEJCYnROaStuWUVzRitJMHBESTREdFVjWlNGRWs1?=
 =?utf-8?B?T2dLOFNnVEMwelBuS3ZacjlTZ0xBV04rcXE2bmNnZ0E3cmdjVWc0dExvZnJR?=
 =?utf-8?B?UTQwQmJHdUdobFcrVW1jVWV2cmw0ZGtsdFd6WDdERXFVUVdJbnBYamR5dXJH?=
 =?utf-8?B?elJqdjJIUFF2ODMzUUUySitXTUlWK3ZHUWN6QlF1ZkdVb1lvbWdrWFlaSGZr?=
 =?utf-8?B?K216RjRUSitkNjAraWVNRDJPQnBpZFFVbytJNGhEMVlGc0FnbVJXVkN4SW1h?=
 =?utf-8?Q?Zn90gWnbLo9ops3S9tc9XlPOp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf711610-438c-4dad-9465-08db83726d4c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:26:09.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMo0K583DSbACbJsRODwa+ayDGwdD0OJsuR7kCQ7frJqavpaB3W1oLlLUP9g2HDfTA+JwEFV5H6kKkB3bo/tmw==
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



On 6/6/2023 11:32 PM, Tim Harvey wrote:
> Add regulator config for cpu-supply in order to support cpufreq.
> 
> Signed-off-by: Tim Harvey<tharvey@gateworks.com>

LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>
