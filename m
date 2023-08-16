Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0077DC00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbjHPITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbjHPISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:18:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A626BF;
        Wed, 16 Aug 2023 01:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiGt3TGnx0EhYbp6hHuiKFDYmD/PjFgSkfMw8ajE0yuehk4yHOJrOj61EsdvNYLl4w9VGQ8GTqE2vemj9h8pNwmlI5Q9Nx2yXsq2Z46PQPmgj50dcrz/wLTsd4WiUGDhCdBpuN0TRt5rMhxUEZ9zc1FFnf+BgChvNulDiKjU+GmdkiGgWPX4H66z6d8RmQHrVErwjuNSjbVeKLsAl6GgfDIBJ31Zll+KoPbvlHJnVZxael1nE+JgtCmaqNHpo4O+mR8slnTV0YffBRv3EDdjBMJ3ZpQYrQJVr0Vq1p1zmiC4xaOnCyprtNkDKwyTroIP+gXwcPfdY+v3BBro47vJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOwMutUxWKI+VSHCuuRhczNUP8GurrjsMUQeACgj29A=;
 b=JhOcavgyt/B7zMJlV8w5TQ2fr1tOnCWAyxYyNFycIQfK6l5Lgv53yPM3pCz7sxsJ6tp1Pxd0mHeIezcoH76icRRwDSfzswuA32jHx5gMRTbpoQJtVZPNVXAkLhA2NgmEnWsLvnQ0WR9Ti5Gb7qnEPkxDJIk43bCa981eo5vjGNGO/VJrvuPyKdSo9bJE2KWfZqay0ibjxRMVc6VKnuRHeztXrL7GOt50mrpvllzUre5MNtEgnYiqVszyOOQ0U+wi/VI1W26+eSES/yZgVtdgxqWFY/G64uYrNkSfQvlCVHC8F3ehuFV+VFt1eathB113AfI82uuAkm09ehQmC2Mztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOwMutUxWKI+VSHCuuRhczNUP8GurrjsMUQeACgj29A=;
 b=NQffuEEowghHxPEID3qxnsAB2qJUBnhqAhuqkXQFJ7pe6S/fMlA33FTNF1CfAi3LqdN3R6YuVHDHjjYzaMRnpTcVqyj0tLfDFZiW2MV0/9L1LlXzS3pW5BznRQrK/AeEPOSOdgnfoPd4CAzQNue7hY5ebrtMwJcBI+inupWFOLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9340.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 08:18:41 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 08:18:41 +0000
Message-ID: <a72d3396-7f7b-c9a5-e4b9-e9335e0feba3@oss.nxp.com>
Date:   Wed, 16 Aug 2023 11:18:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v1 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
 <61f88d08-b741-48d0-90cb-9554907a9dec@lunn.ch>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <61f88d08-b741-48d0-90cb-9554907a9dec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5cc339-883c-422e-3273-08db9e316655
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4qEadMLjUzyE3GMPgzXiPlRh9tKCFJD/R5eGvOBwnAAiyL8YuB89g/MppSTMKy9igCdR2aPtDtlMcbtwX7HXYh/hRJFn3E+ZL1YnILx9hkcT3jY3VPtO/RvBkdoeVzFz8njF2OstSfw5hS37djEoMkzUZUNGXf2ROZxebXAu6fQTUXZOBzV25BFq5UKeVFxwFe7pVhoUkXVjddR7GF5IX6OwJ762lrHfAL1q/nZyEWmdJZpFKIY4yIsWGb3SbUVYG1aLI3iQy3T+p1mxL+/D7xObgoLTudloqK6Xos0069p21pGIuSYhE9P91i3qRH1IXOEUZp8lBOcBzNYbJWHDEf/vXQkxLh7cp7tdYICTqi39VC+LDWu4N9Gv9rFPBWVmqEWQ5kJiyW4gfsFPNHUVXCdkdmLbtRJFzxuxhJLsosnnOa5Qll/vtMmksAGNKnPPewvvWeEpXeAi/5WugXt8ElbupGJS64bVTokwrpuJtTw/p4nK9UaV2xAN7zwG6vu3U/JONKylpD3EqRjSWz7ERebGtpYOZw/pOg5Ssk0N+cxt73fyOclLfNLu96DYSay8Wvpt8Qg5zX0RFDOnPRcQ+gFmTsjM9g/pBo6KxOiRfQ13mgYy8NUleDSV+d7pXUFMoZ9FyZtJ/ztAKAvj/CtUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(26005)(6916009)(7416002)(5660300002)(2616005)(83380400001)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhpZG03bzJWNEUrU0V4bktvdkNZck1UaFVpT2NWdk1wM3JHSkREc3kvaFlL?=
 =?utf-8?B?ZWZDTGZMTVlaUDJITW1rckVNemM5WGhWWERQa1FQRUVQZjkzUFBuVndyeDdP?=
 =?utf-8?B?cElLRzQ0N2FjaHNtRTR3UXlpbStneW9uY05ieEc4eVorc0lnVFhXRjIwbkR6?=
 =?utf-8?B?WnlNa0k1UU9UL0VJdkU1NVNPd043bmZSZ2pTZFo3bnc5VlJQQzRPcnBLdzRj?=
 =?utf-8?B?NDFYazNJWjk1eHN3UVNyMHJYYk1RblNrNGFLbWNpQ3dDN3poUUkyVmpMRGZi?=
 =?utf-8?B?VWVHUHBUc2xsQms0UzJJK1ZOeEdZRFBkRkhBYjg0STZEYWt1TmJNdUprMndK?=
 =?utf-8?B?S1dYMkJBbGUvM25ZWCtSM01uQ3NoWCtBZ0lDVzl5TUdxRUJYNjY5UXhLWlVa?=
 =?utf-8?B?K2FIL1Z6bVJIV3FGSWFrUVBtZGFWUDZHUkZZSHcvU21xVGdobC9RNHoxSWJt?=
 =?utf-8?B?eE5UOUtZQUZUdEF0ZDY0b05nK2MzNTErVEZZWkM4dWorZ2ZQSE1INDd2MDBV?=
 =?utf-8?B?eUN6NC9hZEYwQWJuRE9KdWJPbWNDSnJrMGFJamFBMXhvOURoUkhSRGJWWG5L?=
 =?utf-8?B?RDgxQ2loVVVVWUVNMUErU20xQWd1WCtsY2ZoeFdtQTBGQ1laTkttN0ZGSjMy?=
 =?utf-8?B?dVZ4Y1V0ZFNmUU1MRWxRT2V0N2kvblJqSGIwQmJvZm1hOTMzdjVlVTFITVNa?=
 =?utf-8?B?cU83MlBXbVRMc2xnQTNjQW9FSVB1TTBMTmJJU0FEQlpMcjQ4R1ZVQWNoNlEr?=
 =?utf-8?B?YlhIY1lWUlNXV0l4cWR5SjBGRGxLaXVoTG1TSjY5SllKSnVuYUJla1B4ditD?=
 =?utf-8?B?dmZpT2NpQlZ1b05LVUJmTmdPWFlpdGFHcERFeTNDVCtJREYveWR3ZXRKVHRF?=
 =?utf-8?B?YXVTc1BVWi9Ea2VrMlBvWmphZGhEZFh4NWRYWEh1UE9hQ21TbUtEZkFqSGdX?=
 =?utf-8?B?QytJYUxSTDlyd0NXbFNZQ1pSQVZTbkJlbTNIS1NwMUtDLzZqVXd3V3Rqem8x?=
 =?utf-8?B?RVJMSnljVElQdVFmb2JLSTZSMWF0ZjRkTFRTbVd6SU1vYTU5a0dQVks5cUpq?=
 =?utf-8?B?ZVhqRG84Ym9USUxFNUVOTWdoOWsrTmF2RVZOWXdLei9FL0piZDZyVXBhYUhW?=
 =?utf-8?B?SWRVbkdVMGozN1hIVUFtTXZwM0MycVorNktZdjdLWmhlMmVQelJWZHF3M1Jn?=
 =?utf-8?B?d3hHK0hGaXhyOTRqT1JtQzdLNTYxRnM2c2Z0TUx5aGw1L1NGN01MOHR6VGQx?=
 =?utf-8?B?WUIxYnR2eVVIaVhGenFjd0dJN3ZUQjAyaGwrWGM3ZEJaa0FjVVRmRzNCN0pF?=
 =?utf-8?B?dUNvU3YraFY0ZkJodlp0ai9zU2ZLanZGeGNKWGZDVHNadlUvcWF4NW1ZNzJh?=
 =?utf-8?B?dVY1anpKOHVRWUs0SDRqZUVQVWYyUTRJN05HRHFYVUdBYXF6QUNtaTYwT3Z3?=
 =?utf-8?B?ZDNuZyt1SXQzb254eVJrdFZ0YytlNVlId201RndFVXR1c3p0Rk4wT2JVRHlN?=
 =?utf-8?B?djhubUhDSXNZcFZwd3pQVmxTeC9uTUhiKy9ZMFdmRnplMXU1U2J6V2FGOU96?=
 =?utf-8?B?OEN0VjZsZ1lvVkR0RE5obFE0MDE1ekJ3Z3p0aGJpdEVFcTdud2JKdmNhM3g0?=
 =?utf-8?B?clJ0c3FxMEhhOW9KOEF2cXNMdmFiejJ2UVVCV21XT2tEQWp5THYreWJLTWZ2?=
 =?utf-8?B?Rm1zdDlHLzZPc1Y0Yit5eWRZNWpxdWRxdFExNTVrc0lVTkd6Y21PdWsyK3dy?=
 =?utf-8?B?TEZ4bkVnV3BuV3ZZZ3FrSHk4VW5ZQWl4bERLN3RCOVhXNHNZMDNwVUlDQk45?=
 =?utf-8?B?S2wvREZvd0pTaXlGTEw5WFovWE4yQWNOblZSaGN4WUtmSC9nSmpuUVN0SVVj?=
 =?utf-8?B?Wktuc0drbCthdEUwUldmd1FaVEhWYlhlWHhJdXlCRHQxUDZBWnU4bTNHTUhY?=
 =?utf-8?B?Lys1TWwwbmx0bW9temc5WEIvSFVRSTR6bmhOV3FscHE2MlJTcStpaFRMWGV6?=
 =?utf-8?B?UDltcDJQSld6dGo3bW14bTRZTVRYSnNnU0NKLzJoMWxtdzZmbmRFOWVWb1VB?=
 =?utf-8?B?VkJVMi8vajdTV1ZuVlp4Y1hpNHRFdVk3blJsalRCMHdDVzBqM0JkcEdKbFpC?=
 =?utf-8?B?cG1IUWpUM2RvWHFlR3RvMHVGbjVFK0tEUWF6cWdLL3VCSEYvTEpqWDYzZnM5?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5cc339-883c-422e-3273-08db9e316655
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 08:18:41.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9rj7r2TFqcW6sudGjn+lb4OiXq4XlWQA5a+PekeawEXIy5WOfkDLyqK/Q6IQHC9A9YkLIZdccdpYr6M9UlNpjyOGwVrOxnKjnOh2f6jOfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9340
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.08.2023 20:10, Andrew Lunn wrote:
>> +#define VEND1_MACSEC_BASE		0x9000
>> +
>> +#define MACSEC_CFG			0x0000
>> +#define MACSEC_CFG_BYPASS		BIT(1)
>> +#define MACSEC_CFG_S0I			BIT(0)
>> +
>> +#define MACSEC_TPNET			0x0044
> 
>> +static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
>> +{
>> +	reg = reg / 2;
> 
> That is a bit odd. How does the data sheet describe these
> registers. e.g. MACSEC_TPNET. Does it say 0x9022 and 0x9023?  It seems
> it would be easy to mix this up and end up accessing 0x9011 and
> 0x9012.
> 
> 	   Andrew

According to the MACsec IP user manual, the registers are 32 bits wide 
and the addresses are 4 byte aligned. The PHY translates two writes in 
two consecutive registers in one write in the MACsec IP.

I agree. It's too easy to write the wrong address here. I should check 
the address alignment.

-- 
Radu P.
