Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355AA788B59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjHYOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbjHYOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:14:05 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B8E2733;
        Fri, 25 Aug 2023 07:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSNnQtx41oE6tRWIbaEdU7MGJyvAwGfzvrc4c74QG2ZVgmw6WS4kPKtag2CLxVZKgXg1YVpIoDwcQWjPVzIGaVmCPiMHpOzQPSZlPTAktgHLl7T815lS+mgAgcGyftmsmZ/XjG3G8NHlGrEcoQskkrNl4LyNb5cfIiFFywQFtBjUMyUaRgHgPVwW19Rt+b39XskVSe+eofrj0bFX7GNvz2ykabG+GJ35sTA8g1LyEKbNuJmHmHUCIeLE6Q3powzmy1arOEIko/CdKpMZ0Fvhp43LQgiL7w7tm0wdtB2uPpjpOR3iLEHm7bMlcV/Ham58L+6ucR9a1x7fgsMUONR+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA4DI3WWfNMu62uzXbwCxeclLjESFF0tXBjCgB85TsY=;
 b=B9WjW7jqhoNcCumm/ROpCC/4jPpGbhb1e1aaBZSDxvqqL435l9Ib+aXE9owrco+ujwJF6fJTusogIHmHgnL0+SgzxQQr1vXeBPz5csALTzB3HWoWWDlXUaD0aDQClscLrDrOe1F2DHxpf7zQ1vbethCiXazV/nishFp0JacXya0GKaf3cWBeUTTx7lNSPMd951y5JquDuSX/bJK/l5tIuZx/PsBuAhiU0Qbe97NjQ2aP5HQoPVPntc8iY9+a2ZFrpNjw2uXitAlfS/S+f/Mwe7AlGviD4IZk5vLfqglszfr/FmgFUEVY2Ge7gePC1ggXN8Yl7DCvcbdh4r6PW6Boxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA4DI3WWfNMu62uzXbwCxeclLjESFF0tXBjCgB85TsY=;
 b=JjrV2oZu5OpOFGkJyWep5xDonPSPpkPK4RohjAQWGCex4+FfEY5RxhgLM+O2QosdwRQWsdz8snBhrWhlqBggEuqiDNMQbOINOa6wTrXuzEWB46f4j31g0+HqKbqxcIKxXNT7Q/BFyzKITce5/LeELEORN994y/bsuPDmcaFQwyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Fri, 25 Aug
 2023 14:12:16 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 14:12:16 +0000
Message-ID: <d770a31a-dafe-e833-3a18-36e32e63a62e@oss.nxp.com>
Date:   Fri, 25 Aug 2023 17:12:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sabrina Dubroca <sd@queasysnail.net>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog> <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
 <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
 <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: e14038af-164c-4238-11d3-08dba5754966
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1BGqSIHs5QbmaOFkWlTb/a4MRcDAhUb+7KAp/C9lTgmumMoRPYp/OV3pBJswCDPau+d9kwhrAHol+Qq7jwzPVys6vQ8uriXvEZ3xVlYy28UUJ2htJJBXjjD2c+B74bf3zNnZi1xMNwxdvxAF8yOhrvrFZ22ll2FaV22OtEYlsypjr2b+qixLPi5EQBcK0A23dB+izH4n9qJEswWR78lVRGCVnVSdJo0+yYMOWV1N0wX0aYLqJkAphzRu955ik0sOrbTRWQ/9MirW75RpwcgoyvldNT/+BGfS3ElrTP7kmAD6WgwKkBOZan/pXlclSkuI53scsj3685lih8NEW2/raPjP9b8FnR13C/NwrL2St6P/JqqG19VxPZP4UodXr46BBBMtawViTBasjVsKI07xM7+MzRaYa80SOJkX0j9opTQh4PaynUDW5nduvabYPdFE2l5goYsieNEGqB9UGVKpiHv4dpGSiV6v7mExNQbA4Dx2zq3qah6vN5UZ76AY4TnPdgqTQ8cJqF5OFEEeKBSsDtWeZHQ6SBisMuWoEY5GDwjJTKjYuhfC2iroC+4M/t6BndWmcM9uYa8hFqGNj5v4ChPxpct18iYrE3SZzo794scRKLd2s0ZrfStmQpq8DPqbN538bHMDZ16hQtjrJ9IXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(1800799009)(186009)(451199024)(7416002)(83380400001)(2906002)(6506007)(66476007)(6916009)(316002)(66556008)(53546011)(6486002)(66946007)(478600001)(31696002)(86362001)(31686004)(2616005)(5660300002)(26005)(41300700001)(6512007)(38100700002)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkx4ZlgwKzNPS0NKUHkwdjJlQkVhcUlJUG1iUkg3UkVuejhEUHQ2QWltNTd2?=
 =?utf-8?B?QnFaOGdXZXViMWdRaEJ0a0hPNlVndnhOOUdmM1JsU3o4QnNKMExWN1ZvQUtX?=
 =?utf-8?B?VExQa0tkR3FQU0Y2OFByVkgyS3FlMWlUN1g0eGNINTNJTFVFZlZGRXk2S2tz?=
 =?utf-8?B?UmVDVE8zUEVrd01yMFhBWkZBb1QycTN3OWxubjdDODlXSnBwdFF3RnVMb0Zv?=
 =?utf-8?B?TC9XeTNqeVVra0Yza0ZML3gwQURGSm1KOEFzczNnTmR3RlBRRGVqUnVxRzB1?=
 =?utf-8?B?S1IvUWJnNEpBU3lhQU1hS3BRa25kcHFSL092Y0tBSDM3anEvM2ZPaTNNWVhG?=
 =?utf-8?B?ZUdOWFRJVHdadUZrNFloZjYwdlo1aTlUY0QvYllEZU5JdTkwMEdGNWhMV2Fn?=
 =?utf-8?B?TVNPdmtDc0l5Um9nbEMrT1hGZkl4dVJPeFlmSTh2YnRJL1NveUdpQmZUcjh4?=
 =?utf-8?B?N0FrREgwRE1KV3RNVjh1ZEhuV1JZelFYQlpiR2RaTjRqVnQ1OWVkemFwL3JV?=
 =?utf-8?B?c2dzanFiNjA5NzdWUndDamZlSVpBREtrMDRhcHJrWk5FL1JPOTh1K005REI3?=
 =?utf-8?B?dHRsUDNKYmVrR2h5K1c5VlNYMzJQWnhHeWJIdXJqWG5oUDRKQ2lFQTlVNFAr?=
 =?utf-8?B?UTBlbU5QR2xrZXhMY0xzR3pRSmJOeGw0WlVzZytZc0FGcGladGlGVmtycmsz?=
 =?utf-8?B?TU5IeWhNemR2Q1dxU3RBcFhQKzhnaGErQnFHMTVRd2lLcCtXN01waW1kcHpX?=
 =?utf-8?B?R0pueFlBRVd2d3RIdDdrSDB0aXYzYkVLaEdIdGJNZ1JxRXA2cWJhNlc4Umtr?=
 =?utf-8?B?WHFtbWJic1dKcGx6NmZkeTl4OXEyLzNucUp6aUZBRy8yQTBtWlFsYjlQNUMw?=
 =?utf-8?B?czYwOG9yOWlOcGRSRlpJaGVTa2NVM29UN3B0a3lMaVRNNUQ5VWJyUi9UNWE4?=
 =?utf-8?B?aW1tcVhsZXoxU3ZuN1NnekF0b05VUk1pV0N5a0dxakxNYUltZElCR2NQQ3Zi?=
 =?utf-8?B?aGo2N0lDbmlrS1U3cFBzcXJmOEZSZEJ4US9LcnhTbEc5SkhidEVWblVUaTVR?=
 =?utf-8?B?NlNIVmpzeUtNTlh1aGVNOStzZFlZbXFxNlRQNldQOVpHY2pCSG9ZY3BJVXpu?=
 =?utf-8?B?SUxucytjWlNNVExMLy9CT0xjSHBSbFBsNGY0dXBrWHRTcFhqRHhDUVhpdmJ2?=
 =?utf-8?B?UUFzL2J4YVZZSmQ4cktzQTBvTkVvV3hwWU5DNzN1ZE9hMDZURlVwOUkvd24x?=
 =?utf-8?B?cC9Ha0EwOFlFbW04ekFkMklldDJmRVdqSUgwWmJoZ25aWXZlUk1FRHVkWjVw?=
 =?utf-8?B?U1Z3MXo4SFoyOUJ4Znp5UVhUWCtmY0IxaG84VDFseWxvVGQzRUZmaVZnb1VB?=
 =?utf-8?B?WGFraDF6VzVPVWIwOEJFNE9lL1BTK1Btc3MxMjFCVFRjYUlXeG85UFY3UjB2?=
 =?utf-8?B?eGplTFU1aHU2RFV4L1I0V2t5emxiUVRqSGVUTTU2VEE3VlRmb1NnQmsxQi81?=
 =?utf-8?B?Rm90cERDcXhtYkdZQUFlRXFJaGFaZ0R3ZzhLOWE2MWtFZ2ZjZmM3clJ6aGQ2?=
 =?utf-8?B?c2JzUUQrendCZ0Nac2JQTSsxekdiejR6aksyYzAwV3p4MnEzS2pVaWFxd1Vr?=
 =?utf-8?B?U0ViNWs3WTNGaHh5SnBKeFQxb1pxMHRneXpkbi9vWHRnQnhIa0pYN1RxRWxQ?=
 =?utf-8?B?UEJkcVN5dTJ0eTArUlp6dVAzU3ZIaFhMVDhncEVXVE9rcFR4TWMyS1lraUNq?=
 =?utf-8?B?RzZjWnNnOENYR29uY1lCaVI2UlNkV0Uza1JKeHFXdngxdFBrQ2w2V1d0ZHVl?=
 =?utf-8?B?ZVBGaEQwdVVRQ2FSSzdqU0Fvb3lhZ1g5cGxlRkRNT2c2S2lDalZLc0R2a3Ny?=
 =?utf-8?B?bkhTbHVrbnRlM2tkOWRJb3I3eTNjY1NjSGliZWM3MkljVTBIa1pYeWFta3Br?=
 =?utf-8?B?cVNTVnpWMGYwaXIxTkFicXhjQzNwdHpJaGRwY2dmZi9mNG1uUTlMaE9Xb1ZF?=
 =?utf-8?B?b1liMTRJZkplbTNHV1BOVWJWbTJIT2VXMUR1ZzFLOVJUWGljZkd3RE1aZFVq?=
 =?utf-8?B?OXZZWFJBbVJhSjdONmY3YmQwcktoVGtzYXNFUnI0QlJEeFRCR0FLeDhINnk1?=
 =?utf-8?B?elBGb2t0K1VOL2FHRS9yaHNZVldxV05BRVU2QXdKdWkxa0NESmk3NjN2cnNQ?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14038af-164c-4238-11d3-08dba5754966
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:12:16.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk7iHnmpRTZlYu+qda1goz/5a4zYlE0E4ERmzekMEnR5ptDX+qdii9dpMK8vHQ5cQaEBdh+dxZrnVxY9X7+zVp7o85VMcXy535ccO59eSAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2023 16:50, Andrew Lunn wrote:
>>>>> +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
>>>>> +				struct macsec_rx_sc *rx_sc)
>>>>> +{
>>>>> +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
>>>>
>>>> u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
>>>
>>> why is the __force needed? What happens with a normal cast?
>>>
>>
>> Sparse will print warnings if __force is missing.
> 
> What is the warning? I just want to make sure __force is the correct
> solution, not that something has the wrong type and we should be
> fixing a design issue.

Let's consider the following example:
Function declaration:
static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg,
				u32 val)
Call without __force:
nxp_c45_macsec_write(ctx->phydev, sa_regs->txsa_ssci,
		     (u32)cpu_to_be32(ssci));

Warning:
drivers/net/phy/nxp-c45-tja11xx-macsec.c:803:39: warning: cast from 
restricted __be32

Even if I will write another function that takes an __be32 as parameter, 
I will need to silent sparse for phy_write_mmd calls.

And in the following example will cry because of sci_t to __be64 conversion:
u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);


>         Andrew
>   

-- 
Radu P.
