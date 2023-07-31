Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7B769C11
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGaQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGaQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:15:28 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F2A7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:15:25 -0700 (PDT)
Received: from 104.47.7.176_.trendmicro.com (unknown [172.21.196.113])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id E55CF1000191E;
        Mon, 31 Jul 2023 16:15:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1690820113.469000
X-TM-MAIL-UUID: 980048b1-c619-4b4c-91bf-2b8e57300043
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 72B4D100003DA;
        Mon, 31 Jul 2023 16:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1L84tyEzZuOIsB1QStsboIiLaaFcVQstRfYU61aikAq9Iphr5OePiJK3Qcs1s4Rw3K0lE0Jmatm+pQkFrH/P69NmTCpr5IYu8y48EuOXzMKjNhDcshhUcmo8qzPtZSW8MBuTPTGz/NWpC9Q5fTIoyNi+EQMmSaNwE4BYrxZ3NUZiBbyPaiPW7TuupkfQT4wGvqgm+gHIajA5gVZEM1y5wKoD3NcU7V5n4NR4yj1+rk6Tz4Y21wAHX1YxfEuXaEy5zTJTf7dZDtCxfeFmEE6RYvrT3ezliVEzduRjojO98eBvDCDYllu5XOBZIyaa4e7iPi7juso88Pmq7kp6cT1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Z4jKN3+/2lrQ+io1uOtT5eOLzSf0W27a/P7l53TqQ=;
 b=lTGhpKad70MeE/hoCdCBDbr4MWjKh9WAiQnq/ARDPXn9KR7kTN8gXpmOe4df5Wu5IxZNMnmC/Fnaqk+ZUoB9oFsrlc5JQ+vY/9fC825/rywmeyPHGEN8qDcPyH0hVdYKFjHzRXuIFym7gDicr5dgBEJUbNmPScYQ4Yq/GKQP0OTvg1a9egkGht9S1R9Wb2MEttCAFu8LOlX1OR0guu3NWn84xHTJhXywdB/wHzj5RHPEgmT0BWNMcuOK+qwCR07eX517yfNemC/kMZJa5S3Q1ne0D8ZyB6ml9SjguLNUZIQsofYjLrS0S5ur50AoDykqcACQlFXJ8ZVHzg7S0+VvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <151befb2-8fbc-b796-47bb-39960a979065@opensynergy.com>
Date:   Mon, 31 Jul 2023 18:15:10 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
 <20230630171052.985577-5-peter.hilber@opensynergy.com>
 <874jmlza3v.wl-maz@kernel.org>
 <0290012c-a419-40ac-ed8c-7708fc5a5dd0@opensynergy.com>
 <87ila4qwuw.wl-maz@kernel.org>
Content-Language: en-US
Subject: Re: [RFC PATCH 4/7] clocksource: arm_arch_timer: Export counter type,
 clocksource
In-Reply-To: <87ila4qwuw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::8) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BE1P281MB1844:EE_
X-MS-Office365-Filtering-Correlation-Id: f36e0809-36a0-4d00-3f09-08db91e1513f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+qfwrC/HTOTSsslvI878koB/18XNlmVHP/4Hcgugeck3OxwWxvl9t+au6TPob39G0N7G2hlDo8Qjb0mftAxwXRlw+IG0Qu6qaKxpc9LK/gzo5X/ui4hlSNE1b4Xk5H5tkkeZ7em/yVJnx2a9VSVjHGl5nkIOfh7pXW3sLwlQFKLeWVAO7vD/cpIaPcNHGrbyB+eIndwJs2vqgTuvMykp+MbQ7w8m+0yj9gvADBsHS88iuqnMwlbp0dK8RaSSOjPLKuHA6JBeKBZ63BMFj+99m5Z+lETwbtmuv/iyk/NsNTQSXk1uyF7sJzNYcSA6Q1+e5ij/89IgIxlsR4j1jLIKKGJ/5NY81bH1evWP1tJD/D3r1EU0L9Cyyzym6gvPbVgvqZSd4QGeSJWpruRRcA/uSiuZs4iBaPbT/tBVumi8oPeumrHl51ZzbCsVFUJ8aepTNBBFmSeIaslK/eH1aq/19jTVCEfcJ63rdXPmFfUUekbiklwSNA/K5RQvVuwT0FNppo5i2Vs/N/BdTEiibfi+XZUD4lc0jWB9MVM0iEXG2SkWr80WeqsuV3lPLTZDzPP3vMIbYbdDDS7omnGxeBN+lez61rKxrxF4a0GpIBQ7fPaptOqTJVeowwj0969qIe9OnP3XC16JIUTZhfl62g2CZq11Wim6J5T9sAfAcui2ZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(396003)(346002)(376002)(136003)(451199021)(186003)(36756003)(83380400001)(2616005)(31696002)(86362001)(38100700002)(53546011)(66476007)(66556008)(66946007)(4326008)(6916009)(2906002)(42186006)(316002)(5660300002)(44832011)(41300700001)(8676002)(8936002)(31686004)(478600001)(66899021)(54906003)(60764002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExsVjBQZ3UzcVd0cm4yKzQveTlvZE9zdGh6SStvWFlVNWpTeUxlQXg4RXpx?=
 =?utf-8?B?RFlLS1ZOL1ROY1Z1UXBRVmJnWm5LbHp3M0hINGU3KzBhOVlGa0o3SVRrUE1V?=
 =?utf-8?B?c2NQcVVwS0tGVzBFV2pqazBDdUFTUjBkbGVQc0wvSWRCMTdUclVvUHE5L2t3?=
 =?utf-8?B?VTkwWjlaTkU2VjJrUEhiczI4R3JMb0docVIxVnBxUTFkRm1GRWhOaTVNcUpp?=
 =?utf-8?B?SkIyMWpJVHNpMElnS291S2ZSTUhobGRNQ2QrTWN1NXljVE0yR0lIODJMRXd2?=
 =?utf-8?B?M0ZYdStQTTl6ZXVORTQ5QmVpcnpFMDY5Q1ZTdU9WTEdkbk1SU0ZqRjE1Yjlz?=
 =?utf-8?B?emgrOW01enJwc1A4NnVVWUI2aTIzU0ZxUHdFVk9KSWlNM1VLeC9QbFdhN3Jr?=
 =?utf-8?B?b3I4bTdMYzNTQ28yN1FVSXlpNUNVMmtEeGxUMktWNEdwZlFrdllFM3I2WE1x?=
 =?utf-8?B?RnE5bGFhTm83amRQb0Y5aDFMN2ZFTThxMnB1N1hETmhlMG9WK00yczVWTExy?=
 =?utf-8?B?UC9KcS90MjJVaEVDSVBKYUU0NVdEYWQzLy9FZ1pDTjc0YzBjU2MxVXZSVEM4?=
 =?utf-8?B?Qk5TM1REQkkvcWZCb0JtUzZDV3oyWUVLaWpNQ3NLQjJMTTNvYjdQRVFKRENv?=
 =?utf-8?B?V21rKzFFQU9zc1dJb3NxV29vYWlDb3V0dUdWamFSTVU1RnB6UkxVdFdVblho?=
 =?utf-8?B?YmtjM1BWMjR5aVphQVU2Z3BVVEVsSlJEd0ZjMFdOaU82dzN5dzhLcnlLTTB2?=
 =?utf-8?B?cFoyNTRDb2IxeWtULy9PaGJhVE1rMkkvMDRKNFIyQWdRTk1RUzQ3N3FpdzJr?=
 =?utf-8?B?WG9rR0NOZXRBWXJFcDA5cWZXZU5lbGNXUmVWRmlUMzR0SVBHTlBGOXovRnAx?=
 =?utf-8?B?N0dVS2x1VllzeUpaZ3VKRGhjdTlydm1nY3RKVUpMTkNWRy9ITHdZV0ZYWGtt?=
 =?utf-8?B?dzJ3Tm43U2diRHNkYnE5enpZRFBSbm9DYUt3THhTZEhRcm80M01UVTA4aTA2?=
 =?utf-8?B?YjJmcXMrbE9McytHbW9lZng4cXF2VFAwUm1wVWFnS1dPdzIxOHFPMUl0RXZx?=
 =?utf-8?B?WERoVFdGQnNtbmIvczltVGE0UHpERVgzRzVTZ3ByazArRWxycWlMOS9VYzMr?=
 =?utf-8?B?aEZmdkxHWjl4YWk5ZnMyUnlRREMzcEJaVnFwYlBDTzkxam9GSk1vNVBrQ3Zh?=
 =?utf-8?B?TjJSTllVMTJ6SGJuUU1IRktIK3VkR21pTUE3eDh5VlNzbFVSdGFlQnpCMVdK?=
 =?utf-8?B?YlpaK3RLTys4VmYvMmZoS3ppaWUwTkxWL0tKWnB1TTFuTEQ5MTF0b1dFQ1dh?=
 =?utf-8?B?MWdvdW5lak04Sm1UaER4aUU3ZWJvMUduNGl5OXdkNG53QUFSbi9oeHE2dFFG?=
 =?utf-8?B?Zmd2VWQrWk52SkhUL2ZwSDFjUmtjUC9yOFRmYWtLQjJNY0RTMnJ6Uy8rYXcr?=
 =?utf-8?B?dU83eXI2OHBGWVY2akluSGFGMGkwQ0JrWFZhZmdoek9uV21Gck1MWnN3aU5o?=
 =?utf-8?B?bDlVS1pxRjM3TnZIc2FuUU40dkoyS1Y4Y0lYeitoVlF4Z2xWYmFGMlQ4YjRV?=
 =?utf-8?B?MWwzMXR1VHpSc0J6UXBOZTNCbG5raFk3QkdiNWhldXdLSWIvazlGNFFuTkVi?=
 =?utf-8?B?UkRqc2FxZ2xWUlNLVTVkbmwwWkZxd00zVzVpMWdIemxPdFpXTnZSb2pUQnpD?=
 =?utf-8?B?Q2h0UWVRUG9Cc2tPdlBHOW1qaklRdlczNE9La004VGMyRHhxL3E4Nno1V2Fl?=
 =?utf-8?B?MGhCR2R6bjFDZTJZMDRSbm9hMmNJNWJNdnA3RG8vaEFIZlVDcU9keGd0NEJw?=
 =?utf-8?B?THRJZXZ0ejVJUmlvbTAvbTZFZk53MlRvcXdKOFlReGx3WXFhblZFbldMZ0pK?=
 =?utf-8?B?UVkyR05zcFpBOVpxVU9UcWFxTzl5aEV2QVJTdTlLVkUyWWNpWVpnMlFKY1NU?=
 =?utf-8?B?bkd2YjNsTnZoY0VjWnJVREtuZTVkMnkvMTlGanF0cUZ5MkhqMnBhcDZKTnNa?=
 =?utf-8?B?YWMrNURrOGVuVmYxVWFiTjFmY1h3dDJUMFFTcnFRT0JhbmdNUTlaWm9GQ2dE?=
 =?utf-8?B?Y1Vpa1l5LzNQUmRsMmpSektoWGFpQldzblRMUEMveDM0a3BzdnBPbi9pejZD?=
 =?utf-8?B?bHVBYUpPZUhSWGpPV1RjcWx3TnJPZ0YzNUpTQzhjK3U0UzVHbDFWcjhjem02?=
 =?utf-8?Q?eogSm7HcjVop4Q2lU7ZbKzdfC9vthM3NNDeQiFeNTTPK?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36e0809-36a0-4d00-3f09-08db91e1513f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:15:12.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJIq9h0itwz/gPum+qnCDcdg+8cVZgBEMn/3Uh7ouQ/0cpHTLM05M3S1hrwhsTHPrwc0vJJN7NsVZII+DKeaAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1844
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27786.000
X-TMASE-Result: 10--22.551300-4.000000
X-TMASE-MatchedRID: cxtZ8fwm3r8qXRK86+Icjgw4DIWv1jSVpolXqDXvwwomE24Kzp/H+XYe
        CV6lBhH9ChrJ0BEo1vuIX09SCo5rQ2NwxFoIDUCJSr+cp4/vPz1raLL6Gp9UPIRNexATNUui6E0
        v+Eh37RXxSHUgp8OZQ/cEGLvWq8DLM8VWyP3FqfPgR8l2Qhmx6l6UsWSgw8xYzw0R57pZjQCuB1
        4ADbID6rflJxTe9lcwyc+F3ObIphNy+8QaK7b6DhzOosswztFLGqiseS8e4GcuprjTXOv/oLk52
        hTCkuphLRDGvQ9uvyJnwvLu46KA9Wev59AGO8T0rf03Gvoif/cXWTat7jYiDc1i9Kjkv9F10yGb
        ENWCzIiNc24iHkyxuGPnsjckK339kbUS30TZPDs2pBJAba9d+gB/sYRaexNE3/mKKn37akvjWP7
        ajRTxQUVHfCNfzyE4DiMFVkNq2ubCUBLsrZpD1Txp6GTLsQ5HoJ9fUBwJTsz86zIHHwOO81skng
        2xqL7mGj1EiGKD/HXhRi5/KP4FX+LAO5jL5TwGcx5gbbFQmwRyfGzN/EfYKSbHySXVad36r54JI
        x46I6SuVcUZFgzFcBAOLNGeu33dM/fFuVUUdhuiWLhmiI4dP+k/y0w7JiZo
X-TMASE-XGENCLOUD: d258adec-3765-4858-b445-7e54ccee71b1-0-0-200-0
X-TM-Deliver-Signature: 83029F6824A1D1E9E569C815D86A1A9E
X-TM-Addin-Auth: HzNj2UD3YNP/c5y2ZDQbmXHRxbOq9ItAcGORJ0YuVIA5n/0KT96GH+ttJSm
        KY58EtyqAE2qmvLVrCeiCeZIuN+dlPnrQr+ZV4ftMxaHpzT0agTdjQMSYxGsJQycRlkTee8CQX3
        o12y2dp1Q0JoWSXwB2s3JLFtcwWi7IzN+aANz5hWRvYi/Y+Ytip3qJJLJ4vUG3Om2lxHNl4+Ra/
        bNEqQpZKejxNzcy2Hf9/STRQ5tEVrzAkEClqopc13AhAgcJbR3uiHizlnw6AyICuiXNa2fH0jZh
        W3ZxuljLT4zHWZ0=.YoJrI4y0LDX22/fzC+UHrVD3NZUBWCe4WxSSiimNJMyt1SRGi389Nc0Kzb
        +TWL0q3oIDxicFa03FxiuPXGMmrFRf2VMMdWtT8NcNbGB/f/M1V6NhF+OxGpq2qWWwVKtvECf0j
        Vh5BDpEZ+qwnvTsGTLxL+tT/ouOMw8FZgk8odNS3+TCjTnOUmN+dxShKOfWwLoU669njZGaNjNF
        S21l5wQ4/YbHjiCGbZRLJUIeWei181pKAsxZpZEBFWNqOpn5LwJZU1sNS7n9N9j1Dv7FgLzV6iY
        cu4mmMcN7CRxspeL4N2Af+iMpV7hwiDPGjr2Xw6YDShBLrxptp9BBUsZ6PQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1690820113;
        bh=h/7EbUgLcC+YV2IlNhUivqK3/93dcxgH4EXXE0n/nlQ=; l=5609;
        h=Date:From:To;
        b=Uusdy44s18UDR/sLrnvuni7nU/qqbRZlDe/42AvRn8ThCsYHtKPJVcTscxXN6UEBQ
         KiTRj9UpArTAPI3LYYkmDWaF0Ph+2etICvkLArNW+IRt3xa1aqbyKN4SiSE0nNqBLr
         6FcJfvhQeIsDzUHw9gcKDBvWENvSvksiEbtKGtXLqHT6XmvlH21obEzveo2pPBuovp
         W0LBZTAejASoZfU6V2/GuYjPknTzdUvmpk8kTjdvAkUw6bSKSC5fIF1nRPPWPSi4hR
         pVT533PVHrQ898iNdzBGN3I1RKoGpR7BAQkZPO5aIfFRdfchOQlNV1WcxRWlKYXnyx
         FgpfOrhKcAmMQ==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 10:11, Marc Zyngier wrote:
> On Thu, 27 Jul 2023 11:22:11 +0100,
> Peter Hilber <peter.hilber@opensynergy.com> wrote:
>>
>> On 03.07.23 10:13, Marc Zyngier wrote:
>>> On Fri, 30 Jun 2023 18:10:47 +0100,
>>> Peter Hilber <peter.hilber@opensynergy.com> wrote:
>>>>
>>>> Export helper functions to allow other code to
>>>>
>>>> - determine the counter type in use (virtual or physical, CP15 or memory),
>>>>
>>>> - get a pointer to the arm_arch_timer clocksource, which can be compared
>>>>   with the current clocksource.
>>>>
>>>> The virtio_rtc driver will require the clocksource pointer when using
>>>> get_device_system_crosststamp(), and should communicate the actual Arm
>>>> counter type to the Virtio RTC device (cf. spec draft [1]).
>>>
>>> I really don't see why you should poke at the clocksource backend:
>>>
>>> - the MMIO clocksource is only used in PM situations, which a virtio
>>>   driver has no business being involved with
>>>
>>> - only the virtual counter is relevant -- it is always at a 0-offset
>>>   from the physical one when userspace has an opportunity to run
>>>
>>> So it really looks that out of the four combinations, only one is
>>> relevant.
>>
>> Thanks for the explanation. Dropping arch_timer_counter_get_type() and
>> assuming that the CP15 virtual counter is in use should also work for
>> now. With the physical/virtual counter distinction, I tried to be
>> future-proof, as per the following considerations:
>>
>> The intended consumer of arch_timer_counter_get_type() is the Virtio RTC
>> device (draft spec [2], patch series [1]). If the Virtio device has
>> optional cross-timestamp support, it must know the current Linux kernel
>> view of the current clocksource counter. The Virtio driver tells the
>> Virtio device the current counter type (in the Arm case, CNTVCT_EL0 or
>> CNTPCT_EL0). It is intentionally left unspecified how the Virtio device
>> would know the counter value. AFAIU, if the Linux kernel were a
>> virtualization host itself, it would be better for the Virtio device to
>> look at the physical counter, since the virtual counter could be set for
>> a guest. And in other cases, the guest OSes use a virtual counter with
>> an offset.
> 
> The physical counter can equally be offset (and KVM does offset it),
> just like the virtual counter. With NV, the offsets themselves are
> partially under control of the guest itself.
> 
> So either counters *as seen from the guest* are absolutely pointless
> to an observer on the host. That observer sees a virtual counter that
> is strictly equal to the physical counter.
> 
>> This was the rationale to come up with the physical/virtual counter
>> distinction for the Virtio RTC device. Looking at extensions such as
>> FEAT_ECV, where the CNTPCT_EL0 value can depend on the EL, or FEAT_NV*,
>> it might be a bit simplistic.
> 
> Not just simplistic. It doesn't make sense. For this to work, you'd
> need to know the global offset that KVM applies to the global counter,
> plus the *virtualised* CNTPOFF/CNTVOFF values that the guest can
> change at any time on a *per-CPU* basis. None of that is available
> outside of KVM, nor would it make any sense anyway.
> 
>> Does this physical/virtual counter distinction sound like a good idea?
>> Otherwise I would drop the arch_timer_counter_get_type() in the next
>> iteration.
> 
> My take on this is that only the global counter value makes any sense.
> That value is already available from the host as the virtual counter,
> because we guarantee that CNTVOFF is 0 when outside of the guest
> (well, technically, outside of the vcpu_load/vcpu_put section).
> 

OK, I agree that a virtual/physical counter distinction doesn't make
sense on Linux (unless one wants to abuse it to distinguish very special
use cases with and without Linux).

Probably I'll also remove the distinction from the spec draft.

>>
>>>
>>> I'm not Cc'd on the rest of the series, so I can't even see in which
>>> context this is used. But as it is, the approach looks wrong.
>>>
>>
>> Sorry, I will Cc you on all relevant patches in the next iteration,
>> which I will send out soon.
>>
>> The first patch series can be found at [1]. I think the second helper
>> function in this patch, arch_timer_get_cs(), would still be needed, in
>> order to supply the clocksource to get_device_system_crosststamp().
> 
> We already have to deal with the kvm_arch_ptp_get_crosststamp()
> monstrosity (which I will forever regret having merged). Surely you
> can reuse some of that?
> 

I'm not sure what this is hinting at.

From the virtio_rtc perspective, the only behavior shared with
kvm_arch_ptp_get_crosststamp() would be exposing &clocksource_counter
(and distinguishing virtual/physical counter, but virtio_rtc should stop
doing this). Exposing &clocksource_counter is also the only thing
arch_timer_get_cs() does.

If &clocksource_counter should not be exposed, then I can see two
alternatives:

Alternative 1: Put a function of type

	int (*get_time_fn) (ktime_t *device_time, 
	                    struct system_counterval_t *sys_counterval,
			    void *ctx)

into arm_arch_timer.c, as required by get_device_system_crosststamp()
(and include a virtio_rtc header).

Alternative 2: Change get_device_system_crosststamp(), resp. struct
system_counterval_t, to use enum clocksource_ids to identify a
clocksource, instead of using struct clocksource *. Then there would be
no need to change arm_arch_timer.

Thanks for the feedback,

Peter
