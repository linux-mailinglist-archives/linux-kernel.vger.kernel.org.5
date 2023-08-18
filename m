Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE5780A76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjHRKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376432AbjHRKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:48:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8111273C;
        Fri, 18 Aug 2023 03:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4w1EqHjSZ9g+yh0c7o0ufgIp3tgfCjAe5JcQI+sa6BhXA8SZWRdiLLUQKkmBdaMZKYYH2/ZUVYHfY5nYSZQ8y5wNhbndJKZUOZtA2p6Z6D99TeM/DgA0rB/q180I0wTUkiN5xWY6HX9lQtMfLLG46Vo9kaYveTg/GV0ypgqkNflLDvGuJydCED3EdmixKtGWAY/bcwfKA1SB+0zLT3u5VG/BHjf/330HWxQh2L+VdaGk8Tu4395GLw5zwU+CTemC5xguWgg4w6S4iSSC/4tX1ebRoHjo1t30BdV5fgrFJpOJg3G1B3lJQZ4JuloPyx1W+p+L5ijh+PHNPvt5+Ex7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0oAo3kdZXUHF9aQTHUM2fgmHoogJ+qmk++YrwKeFuE=;
 b=e5L21oyvIQA423CRGRQufRA7v9NQXLzdt++UmTFDfxJTR/2CNbNiVPddB8q0+yq6kkcA3qcOBSQv3UF23S0qbM7o1VTsvtdYFgebY+U0ZyCDRJsNz6NfbQbzInmLoc2GzOZa7DE7XakHD+35+fb0bmSPng1KY17yIEls8Z/1ONl7PW1EyUNnLNzj0SpFfbYtMxVwVXwAUSOy0HhS7eOHJC4LRp4PTjsZld3ivuNovwr88dOP9HU2UMJwxFxog0BfEjPTKLjO3kto4O8DFtkkDHXzcIsLTYi75vbZ0jflg2WOI7tWSjDUh0Lz4oY8fjdDuvL6uv9RPkop+8Zrliz1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0oAo3kdZXUHF9aQTHUM2fgmHoogJ+qmk++YrwKeFuE=;
 b=JxC2+I4HOwEdGdYqNeekIRsQZ45gOOJIDna2Jn7j2KSGrcyapXXZBrYiz6Q6MRav6Evj8+WNn0Iv8NkYa1disVG9cGfgD2aFaC51v9vzbbNFn0TrjHQFw6n7LZ3Cph6bJD/7j/0TWMdwXJGrZJu0uBxUHhviQ4VnbWalbXUxsNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 10:48:02 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 10:48:01 +0000
Message-ID: <6daa226c-4dc8-4c40-8e98-196695839b50@solid-run.com>
Date:   Fri, 18 Aug 2023 12:47:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230814141739.25552-1-josua@solid-run.com>
 <20230817093047.28a2b11d@kernel.org>
Content-Language: en-US
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <20230817093047.28a2b11d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0008.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::14) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a699615-bc98-4cb7-5f49-08db9fd897fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exHpH5cDux2iWtMYmZJh30BnYLhNBTg4AKc/Z4S3zkwt5Kf9eJU72id6Asm9+G5+C25/8TRCqypuXtuYayBTCzOr178gn8nugYtyI3NCn9Zf+1CakiULTARBrhLnu5SSferJewN08VJxxaWZn8bARCP2lM2d2dKep7oxVkrxs1fUEcfZwh6QDmNyk+hixBp2al2CBFqSzTs0SNtV78toEvABuJCLTO4xFxsw1JDmQUlI1Tqr/FFPuDhlKWkLcnytE8Dq1aaDAJLcLF8FBlmJUWNKm2YhvEEqHQVpb1KwsehMzAudKOOg+wFLr1DeBr1wyGhBpLdKtGaK7B3vCBGZOAUwmDQqFAwOR1vFAUntYKgcexstyYe42wK4KNBnMCpbmPVDs0dlrYIeML56H1eontPtMMJIWlfRhQomwu/Z4GlW9KEdCLMl6Mcy/V3IZVI7xuZvZpLyOrpawjUA5YkZJsGa5jwNQ4bFyJCgkYEcQhB4a/J44rlKvt8c3ty3QKsA8Ze5jvkq4lOg0v/WdZ2lSa8sLyEzpCjxgcirCJdcl3QTvDGUPY8cI/T0cOq86hvde0sBJSegYOrureOyMUK3q7BkWeigy1HoIXUV3dkvfwB6s4AsNhOSWv2PqdExREtM0MeC73lqssKofCy4onR20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39840400004)(136003)(1800799009)(186009)(451199024)(6666004)(6506007)(6486002)(6512007)(83380400001)(38100700002)(31696002)(86362001)(36756003)(2906002)(6916009)(316002)(41300700001)(4744005)(66946007)(54906003)(66476007)(66556008)(5660300002)(2616005)(8936002)(4326008)(8676002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmg4ZUhhaXpLRXFmZElFRFlOYWtuQ0FJSkJ6V2E5OUV1NTd0SjRvdVg1V1RG?=
 =?utf-8?B?emtockpCZEFLTHhNODJPR0l1RXBBNFd2VTRDMFVEU0J1aWJDZ1dyNmduQ3NQ?=
 =?utf-8?B?c1VtdVRXS0E0QU1NNkd2ejVlWmtXY0V5TUEzUjd2YSttNXVJN1RaR1JONXBn?=
 =?utf-8?B?RmF0VVVpN2xxMXlHWmNuU2t5QzNDNGppYTJRM3FVYzJQckwyYWlZYjhsZUlE?=
 =?utf-8?B?dTk5NHFKQzVNbzlsKzlYV2U0RWx6ZGN5L09mNzB4ekREMjlkblVDQmJkZnI3?=
 =?utf-8?B?a3pXL1N0K1NITkJMTVE0bWI2c2RsVFNlemVBaVRyWGhwOXpZaGJUTExtZEFU?=
 =?utf-8?B?REd3K1h2WDkvUE5XZ1YrRXBXYUt6U3ZFbUdZNk9jMzlxVU40Y2pzaGJ2SGN0?=
 =?utf-8?B?ZWRsbXFSYkJGcVBjSTZUSWJjcHhjQVRPWk93Q1NOVlVGTm1xeCtyV3ZuVkRt?=
 =?utf-8?B?ZkptU1hrbU9Xc1AzWVQ3OFhqT0dSQkdEWUo3UmJpUTMwRDVqZXM1U1F6S1hG?=
 =?utf-8?B?S1RXcDdRWmkyVjFucm1rY3FGdS9aU0k0N3FjbHVoQlRrSGVEUkhzWXh0d3hB?=
 =?utf-8?B?amU2cWhpRnVTWExSREROQXFyT3RKYVBFaVhLWDhUR3ZBVUkyemxxSU1jWG9O?=
 =?utf-8?B?UE9QcnJtaUNBdzBJb3VIbEtOUkV0ZmJDdmVwUXJUdE5URVRwWkZqQkM5RCtw?=
 =?utf-8?B?L1dtcWFtemYzS2VZVFREekdxK3NwdVlxdDhYM21tMTBsQUhwZ0MydzFzTDJG?=
 =?utf-8?B?QUVxVWxjeVdtWUhaR2JidmV1STUrZ0ZOalQvdjV4L09rWjluTEQ3QVRuL2dU?=
 =?utf-8?B?K08ybHZwcWx4QWxqZkhHT0x5MXpBQUd0bXNma1JOUzc0OFZqSVFiRVE3aFNa?=
 =?utf-8?B?UnBFTHBMNUc3d0hEb1lxZTYveGZqU0NaVnBNc0EyMnIwVFNLTW1zTTdxWE5t?=
 =?utf-8?B?SWdaUkZkWS9HL3ZYdng1OG5uOGhoM1dvYk1kSWg2MEpLNGIwczlVcDBWYm5v?=
 =?utf-8?B?YXhjTS9JMlFNLzlrRVQ3aUF2OWs5WC80eEJSWEM3VGNnYTlGcTJuNTcyblda?=
 =?utf-8?B?aW9pSkhMUmVXTUFhaUo2RFBsMmZzc0pZOFk0NDV0ZGwzNm1Ca0RScktxMTdk?=
 =?utf-8?B?eHlUOENHK1NkTFA2ODNKL2hmUXlTSWpReEh4Q2xxM3JUOHYwZFcyMWlmZ2JT?=
 =?utf-8?B?eVBVdFpuTnF1eUhEVnV0YjFRSmJCV1JLWTVQaWF2K3YrbkVZdm5DRytxcFRB?=
 =?utf-8?B?NW1Za2xBVUdTMU1jL3loaUhXODg1cGdrSURMNXhEMmsvT29oTTUvOU1aUlUx?=
 =?utf-8?B?VG1xeUYrTnZ3NGRteTVyTGxYUDhRa2VkcjBNUkVKYkJ4YXFiQnV5NHp3N1VK?=
 =?utf-8?B?UUdObWNNank3RnBWTmFxVkZEbm14TU5rQ1dvTDBza3l4bFpqblJtRnJtSjYz?=
 =?utf-8?B?UFZBMjVaVS83YmF2TXJSY01KN0JscmpDSDNZTE1FL29SR1lLb1YremJBOTM2?=
 =?utf-8?B?RDVsbnJnTCtiRUVuSEJlUlA1amswZitVcVVwWU5md2ovZlBIUlMvaWFrUXRp?=
 =?utf-8?B?bTJZQThXVFlzSmJxTndpUTlDSnB3djVPa3FYTk5sTnNwMVhXd3lVeGRmR3hl?=
 =?utf-8?B?SWI2RzZlL0tZOWthNmhYdkhLL08zeVRmekw2bXZUUUJHay9CNzdHUEFnVW5F?=
 =?utf-8?B?Tkc5ZFRHVmJWTzRLbnZ6bUUyMWpNUElINHRSWkJHZDZDejJ3Ui8yc3BVYVo4?=
 =?utf-8?B?RnIvOENjSlBTZ3FjZjFHZjF0bU1lV2gxRm9rQnlhTEkzZ3VZLzZRMEtzbjJ0?=
 =?utf-8?B?NERPL0hsT25JRkR6Z2xaQVp3MXlHWnJiZmI1cXYvTnRvNHBJM1dpRmNKclJI?=
 =?utf-8?B?bXk2SUhVRjVTenczeCtUYTVPK2c1MGtaclc5NitBTXgyekhVQjJTcXBON0NH?=
 =?utf-8?B?bzU5UHFJVGtvTWZUdG84K0NiYnRQZlFlZkhTMzR1S3FPemxManRsZkF2NEtW?=
 =?utf-8?B?NEQ2ZGFTWE92a1hlS1FpZnJUQnQ5Z3oxRVIyelhEV0U0bzMwTktsaHEyWWxq?=
 =?utf-8?B?WGlpbnh0UUpWbFM2c09ZREFvUG9lSmlHMHRWSkUxbXJhV2xsZ3lESksxd283?=
 =?utf-8?B?TjhiUll2RkdiL2ZVeU1wRXM1UWxud3F4K0RKTXc1SmtiSEplNkJsS3NueTRX?=
 =?utf-8?Q?DUyVhgL0SKPUD19sA/pCZmA=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a699615-bc98-4cb7-5f49-08db9fd897fe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 10:48:01.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96D/A8Q8s6qOSiSkGrlouzDH164GX/L0pTiry9CmtfTikR6Lum4Eempk6FLUjSOIXppMg/avm+3so6VOFEDVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Am 17.08.23 um 18:30 schrieb Jakub Kicinski:
> On Mon, 14 Aug 2023 16:17:39 +0200 Josua Mayer wrote:
>> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
>> for active optical cables supporting 25G and 100G speeds.
>>
>> Since the specification makes no statement about transmitter range, and
>> as the specific sfp module that had been tested features only 2m fiber -
>> short-range (SR) modes are selected.
> FWIW this got marked as "changes requested" in patchwork by DaveM.
> Since we didn't get an Ack from Russell, would you mind fixing
> the comment style and reposting?
I will post a v3 soon!
