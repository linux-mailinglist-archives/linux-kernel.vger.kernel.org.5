Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727C17C00F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjJJP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjJJP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:59:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E9DE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB2MhJTx/sJ9vjodkd8CcxHx29grGak+lstSwCdiZLyitg/BGfISueOvAksE5nx4vs98eBGDhsmXNJK2gI/84oP6jtORbO0lkcduq5fmgN7C1P+T1Hbr85BeI8FnEzc8Wd/Guf/nbhvWQi5iNM7Wa9uMkxq1TJuq7H9xn9t7juW4E0l2Okiuu+0pJe2F+u2xAzDkhmVXRJfxczlyCyuEorjT84g7qUwky+KteRkCWnJbYKmUEWX98+rXoWHeDqivyKc7MipuyFbOYn2pS7BmTvNeM3B7WAmacBeG6UTKe59CVPBU7VOYRO05thFvvZAfbYxnX4n4ij+0KqhwEpJYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc77ksfFaK1feRPbUxPxul/ob2OaEWjXWEBn10A+q2k=;
 b=nGXr/IEJYDWT7I/mjiCithcXdqBz0V9/tKwPilJyH+DNyDtE3VGYxHnx1iBjqaVaUnzjS4ukQcHOEuEB0m0AO3jfWsCHcALPrQONLRjCvgTTcpcC87g1nb7Ftt4qEvQEcNjogk2PcvQRS9FGde0m0IcEVpI18B/Y7c0I5U8dFH8+w6mzv6Ri+4IqYFAaIi1mW3+X013GxOtgHkKj1V1I+UZBapXjt6k4Ul/aj8ZCOTHeQEizOMIefWc3nAJRp24Mc21SwCUrKfB469YJuWEp+jmyvhI/JMi8b40pHbWzbVXJYvF0C10r+PwPsMpNOT1F2HTOEdOl/mrDDUyV0IwcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc77ksfFaK1feRPbUxPxul/ob2OaEWjXWEBn10A+q2k=;
 b=Qt5j3o2WddG7Alfrbd1lTUEC0usa0nTlzuD3v3YDFrCCenkzW29cU2bKkoLB1WDNvI7nD6cxLKhO5goSyytlRi+0xA7oHAxzaeMaM7iBuBu4P5YvZSXqWPNHh3y1kmA1XmxcbPLp7C2cEegY8ieFzSJK9v1k4W4CD4Yji3wz5y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB10338.eurprd02.prod.outlook.com (2603:10a6:10:317::22)
 by PAXPR02MB7248.eurprd02.prod.outlook.com (2603:10a6:102:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 15:59:41 +0000
Received: from DU0PR02MB10338.eurprd02.prod.outlook.com
 ([fe80::fdb5:ecdf:a6fc:64b7]) by DU0PR02MB10338.eurprd02.prod.outlook.com
 ([fe80::fdb5:ecdf:a6fc:64b7%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:59:40 +0000
Message-ID: <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
Date:   Tue, 10 Oct 2023 17:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Content-Language: en-GB
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DU0PR02MB10338.eurprd02.prod.outlook.com
 (2603:10a6:10:317::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB10338:EE_|PAXPR02MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: e5007308-7631-4a07-3a4f-08dbc9a9e98d
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6rIqNUsBerGVWxz5angfMMMZbMU3c7UquLeijWQqj57nnnuQhuzj/dsyfho91jt1W7fqpfzG6P05XzaT/iRbFKUd4FYu61ZcJ1TQib8HRnrITFYRYaopbWuM99EUoqPb0CozBSvGOfP9toIPktNALqFcIaAB16eILLbzG2RVyRsR8Z9fy3d7cWZ4gL/9DgsbBNq1u6bHuGvXl2cEUw50q1UrDR6dJV4o4d3+wJuzritc3F0MQS2KWZjcWBtFTJPQZgB1VP2ahKPjhD4PIXwurh7b9q4svgSHBNbExIR0kqHHIXpIXAcOrWBEGMX30iwVTkgXVBJEnSqy7FmulrA0rJX/xNL7M1zQ5BsceZmZMu0CHuK6G/a5sc/Es9v5DiPGl3KHNwoB3RekfoWkmYFnZBoxL3YZOVVvXToWTnL3L7RqxfMx72twQJMXC/+iAzKOvDn6bXuJZyZv4xM0L0+ZEA3c2WRzX+GWwJOhZK0UduC86hu7j56Ivrp57AdhCI0uGa2X/FhRHkuI9DRKb3Gq2PuO+KDjoGQOO6U3dVIP3ySKhlOCkcCs8Pf9l1aw4xq9XbUL1SAPkzj787ho8kKujO/pf0obZTle73OvijVTYm/TbyHdJxkbKqgbkAEXA1m+Fqgl7bmunOqJqdziIMYkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB10338.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(66899024)(107886003)(6512007)(36756003)(86362001)(31696002)(38100700002)(26005)(44832011)(2906002)(83380400001)(6486002)(2616005)(6506007)(478600001)(8676002)(4326008)(6916009)(8936002)(41300700001)(66476007)(5660300002)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdFdDl4RHMxbWxZZHRic1RXTFRtUTRrVDE2UEsxRW1BWnNld21WQUg5cXND?=
 =?utf-8?B?c2xrQU4xb0RYZXM0azNvMVc5K3B5NGZncExzM3k0WDBxbVdoMzBIQ0JteitO?=
 =?utf-8?B?V1N5eS84b3J3dmdaT1pzc0VIbHprZzNUVUhkYi95WmhvRW1oY0lvalU4QVBG?=
 =?utf-8?B?NDJHdG12UmRkeHlydENBQkNEb2hpekFyM05xajQrVkhIY0FFbnRBNmtRMDUy?=
 =?utf-8?B?U2NyRU54Mk0wd3BSUzl5YjdwNnNPUFZhczdBc29tdldRU2ZkNUwwY2NSRFZi?=
 =?utf-8?B?WFpXQnNDOURCamVla2RDRVdIQWFFL3IrQTZtYTVkd0dsVU54c2plNWhvWkFL?=
 =?utf-8?B?am5aNG80YVNVKzFROElXWGtRNmZLWGhTQUc4cnpoL3IzbWwrczRoWHY4YU1T?=
 =?utf-8?B?Ym54QzNmUEVtcVFWZzh3SHVhTkNVSUhKUFBVWnVVRFk5dDNTYWJBdllncEJR?=
 =?utf-8?B?bXQxZ01WZGYyVkh2N0xSbFU1VU5paUsvbXFwTlUvbW1oemZsTzdDeEVnbnhv?=
 =?utf-8?B?S0JKSW13MDFqUkxMY3lSSmlTa2ZXMi9nK3cvYnVsN3BTQVVuaDB5ZjhuS1k0?=
 =?utf-8?B?aitDZXV3R0pLUE5CNFNaZmNpbWQ1dVB2ZXAxVjFNNGFPWS9oT25CeGd2d2la?=
 =?utf-8?B?a3ROc28yMEwrd0xnK3BFbkxZOFdQZzlURExvVklMMFFLZ2dSbG94aXk0K2Rl?=
 =?utf-8?B?Y25YMXZrV2FjMUJhQ1VRT2hob2ovdjdmOG5VMmhVQzZkZzZHVldZTFFhR05X?=
 =?utf-8?B?R0dVYnlrRFcrWkFTRHp4YWc5ZEc1VWtTZ25PRHBtQk4xWE1lcG1RTEtjell6?=
 =?utf-8?B?NEp2Q3dmNC9tVDloSkZWSCt4YnF5N04rMEV1dENSQmhrMnJieS9NWlFPZk9i?=
 =?utf-8?B?KzRTR3BEdmc2M2JQUVp1MWp0cE9RWmRaOStnNjZqSENzMzBKclFiN3EwTHRU?=
 =?utf-8?B?NFYvVlhkT2p4a0NnVFU5dXBnYzdnMmZUL29XemZBejJMS2xEVm1HeVRvVmh1?=
 =?utf-8?B?NEpjc3NrMkU4Qlh2dDI1MWlTYTNTaWEyeHdUSElyWG5QRVFVM0pXZTdLbXY0?=
 =?utf-8?B?OElKWlVvOVRvRDBUbmxtOTZMSytLYXFFdFU5dS9EbmlWYXhWSFY3b3N2eEYw?=
 =?utf-8?B?TEZkQjdULzFDV0ZHS0FzMmpCcmRuY096Z3oyblVDenhLd2dKSDMrcGorV2pr?=
 =?utf-8?B?RkF0WExnckRKOWlreDZlYVRlejF1NHVWNUFhQU9SaEZiellpd25tejJWOUN2?=
 =?utf-8?B?ay91RTRyVm53TXd5eWdtM3RCT1FFK2VCRUo3UnZna0hKSlZkZ3FFWUVyaGxZ?=
 =?utf-8?B?SnI5RkJSMm5tSlY4R0NHK21SYVNGZm1ubG81ZXl6ODA0NW1jNGNYS1pVbUpz?=
 =?utf-8?B?VThpRTliamdoVTViZGpFOFI0Vnd4ajBNbmFYcUJhRlpsUWczVXVXRWNZcldt?=
 =?utf-8?B?SHFZSzBQWGZWclVweDVUS1owVmpoWW4zQnZVWHNocjl6N0NLeWc5QW1OdHVk?=
 =?utf-8?B?RW40Nm9wTkZwajVjVUtJLzZtblFvUTliWmxPY2ZuZFpqckQxNEFZNFpnc0RX?=
 =?utf-8?B?alNuUll0eDZMNnM3K1I2eFArQ21wRnZFWnJ3RVZUTkFVQUl0MVBZVmsrcnda?=
 =?utf-8?B?ZHRDSWtCanUwWGs3SGk1aGNyY3h0RDYwc05aTnVpZTl1L052OTRQMjNZcjB2?=
 =?utf-8?B?MUNYL0hNN3c1a05YVGJuZ29yQUkyU0hqSVNSamlaRm5oRnJscm41K0NYSUdq?=
 =?utf-8?B?UCtmRVNURnFOSTIvcFJRUFNXNGhpRTNCc1U0em5aMGdkWlNUbDA4dUVITGxV?=
 =?utf-8?B?Y0N6Vjc5ODRxQkxVSlNvTzQyRXhDcGJ5eTlXd2d1MlFMTFcyNjVCc1d1eXEz?=
 =?utf-8?B?QkNrL1JtT2NvTGdNNGNQYXhyZjRnRmlXWmIxNmcrWU9lbXIvTEI4RW1KYXhF?=
 =?utf-8?B?bkFIK1VXM1BadXQ2MjcyekZzRnlERWp5TXdmalYzelpqY0hnSEtOT2JJQzVn?=
 =?utf-8?B?RlJWekMvSFBGUjM1djROVjFuLzdzSlQ5eWE2YWYyeGVYRkVNaU1xU3dNdHB6?=
 =?utf-8?B?RUlWZzFsZWtEbGttYWJyNURLdExlWnh5d3NHa1dsU0g2SU5nMHk2YWo3WDQ2?=
 =?utf-8?Q?Bqzg=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5007308-7631-4a07-3a4f-08dbc9a9e98d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB10338.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:59:40.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnFlCfVExXkhVfnrFJTsMe3qRTMQSgz6VoNQ6ONWWi2HtKHpLQM7duqw3Yq7KFNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7248
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 21.41, Julia Lawall wrote:
>
> On Tue, 3 Oct 2023, Anton Eliasson wrote:
>
>> This helps automating coccicheck runs by discarding stderr and only
>> looking at the output of stdout. In report mode the only remaining
>> output on stdout is the initial "Please check for false positives"
>> message followed by each spatch warning found.
> What is getting dropped is the spatch command lines indicating the
> semantic patch.  Is this desirable?
>
> julia
It's not ideal but it's the best compromise that I have found. The 
problem I'm trying to solve is to be able to diff the output of two 
coccicheck runs and notify the developer if any new warnings were 
introduced. That requires the output to be stable. spatch is always 
invoked for each cocci file in the same order. However, the output from 
each spatch invocation is not stable as it examines each source file in 
an arbitrary order.

My workaround is to sort the output before diffing. The line-by-line 
sorted output only makes sense if the input is one line per warning 
found and that is why I try to discard all output except the single line 
per spatch warning. While the terse output doesn't tell which semantic 
patch file generated the warning, it does usually contain the offending 
file, line number and a summary of the issue.


Anton
>
>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>> ---
>>   scripts/coccicheck | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 95a312730e98..7e7c44125f47 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>>                   echo $@>>$DEBUG_FILE
>>                   $@ 2>>$DEBUG_FILE
>>           else
>> -                echo $@
>> -                $@ 2>&1
>> +                echo $@ >&2
>> +                $@
>>   	fi
>>
>>   	err=$?
>>
>> --
>> 2.30.2
>>
>>

