Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61A7DD261
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjJaQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjJaQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:42:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412B479E;
        Tue, 31 Oct 2023 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIfwlurT5DsFeNjVDnfWUYInLkbbcR4kU2WvCaXbpcT/UJKG1MrxYXxVm5MABcXfm5WZZhpg4Z4AL1/jriCOYGU7XqK1lKQvVA+Uegt7nmA+VbkUov64J6bb5BT0vI66QuUiUBx9QwCgi6ThP6OoaB7QykndifNcpIp4jhuUhy/FLUqMmvM5OOwUoGOHz698d+6xvjqPEmba7CkYj1aqNQIeMwIXngMXYNyV/f0CZCXely2tnJqDul+ksux0OmdPk1ClkOjJqEh+S71PmtRlF5eRyjmlr5w1t5nfJr/CCySVMObqm4yDJXZU8ocMSy18yUP2J0XrdFduE99NebL2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivg1VHKeMyR8bk8r+z18paoC5/e+vJzK29NRBBUnxxU=;
 b=fT26w6fikG9yfC7wJzI8riE0qTYCzDQDoAl7hGVyJOTpDQgm3kHrob8wfFWLwl3X+2QozZe9K81wUionfLsadCk4w1HtLU+L8LVPs6mPYhEerbstzXzjBbYZqeY4h8xx2slDVo/pg6OAObb+FXv+uLuL0gHohNOjGWo9cRkpsrxiSxt+3j/SL+ez82T/bCAlEB5CzG319ginYRmAo0NzNqfgE6cCDwcGjBQR8m4BSiRo3FYA9363br2r4gk15Y4ESp927ezf0OKqYtJppyd/4ScAnBV7IjIpyUd6P0XqoS+CuvyaR3FDGD4bmGT16p7GROt9JINli6dWF2+Yy9wamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivg1VHKeMyR8bk8r+z18paoC5/e+vJzK29NRBBUnxxU=;
 b=c3ay50aYjWqPXKva/JzT9nw6//V0d1rUN0t09NFszJnpqYhBofU8yUOG1mzI9m7lo2E0vSeApxCBcCzgGtZixMZs4IyQ/dZvqt0lGQ8OFtbekVQoBtZZ9AC0tUjBtG4re3Blfxy8Ja35/MRgx5YrVkmKZW2hmZQoDDXnXlitMrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:41:20 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::33ed:3162:e4ed:3569]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::33ed:3162:e4ed:3569%6]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 16:41:19 +0000
Message-ID: <9f50181b-15da-44b3-9620-4d3e1e1d8557@amd.com>
Date:   Tue, 31 Oct 2023 12:41:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: remove redundant check
Content-Language: en-US
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        dillon.varone@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, samson.tam@amd.com,
        SyedSaaem.Rizvi@amd.com, stable@vger.kernel.org, daniel@ffwll.ch,
        george.shen@amd.com, alexander.deucher@amd.com, Jun.Lei@amd.com,
        airlied@gmail.com, christian.koenig@amd.com
References: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
 <2023103115-obstruct-smudgy-6cc6@gregkh>
 <3ab58c1e48447798d7525e7d2f42f1a2@foxhound.fi>
 <2023103141-clear-scale-897a@gregkh>
 <1175edcbdf0d0a55d39a87f220259528@foxhound.fi>
From:   Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <1175edcbdf0d0a55d39a87f220259528@foxhound.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::6) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: e1791961-e28b-4275-3205-08dbda3035a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x579nBsdSPM/Eaeotooo2ol89tZxtoTNNI6CSBQSOiAVRel6yj2Yh0QhRPi0APU8g6LjSxbsHzX7NB1RRC+mMYJ4XbyD5OvyrbWa8mLEpRt5YdQOpJDfo0wRWGepsDzpNDSH4YKnnCU/GlAqOE7EhCbOsxkGYOfdnwgJ7d6PMM7LSfR+aS6E6Y2CsLwM7I8S5zufj+WErVlfviq5HHic33uDs+FyqSAw/t+t54haB27q9HVEyvltZDdtsz3O+VQfR3vyK4Pu32eQslf9nruZiWMei9CXBCm8To2LyKO/j4WltvYMQ8zFMskko/iHwTiDCh54L6Jwsmb4/w8eAzpu6wbmKP42ku98BUbIWV8UfldU4yxa9qqe1pIG7OI7EGr1M6oBt8L9qYhprEpz4gDg9QwWXQE7aIHeQINDb/Td8mIgXZbqZ7DiQdCb7BqF6riaWXvqqQc7KM/FMd3t4Tgy32bgOkH13XiTKOkBSrw0Gsm7cUKQrTqBfd1oRrzgDwkiLjoR+JjT7XtpKvyk/Huas7B9cUx9Dd0v5ZWn0a71ICl619RVICVkRqCIHVHPzbkcdpuAUAj8HpoGTH6/7L6NTOAmhPywrbqaia7fvT3VuBUJ8FcyAmZx0kYHVY23eqx1Vo2uggMYmUV3Kt3TBHtD9v5hX8rd5mAKMHYWsaB7e8bLkjvflbENcDt9H7+54XSI6oAHuJYuKtuLv29LAqdu5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(8676002)(86362001)(36756003)(6506007)(6666004)(6512007)(31696002)(53546011)(41300700001)(38100700002)(4001150100001)(66476007)(2906002)(66556008)(8936002)(316002)(66946007)(110136005)(44832011)(5660300002)(966005)(6486002)(478600001)(4326008)(2616005)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTk0MFJxM1ZmZk50L2JkVEN2cTBTbGVweGlmVGFVbUd2b3pLazFzU2tXblBZ?=
 =?utf-8?B?ME44SUJLSVI4TEhlRC9EWWgyT1gyWHBjd3h0MS84TGpvY2xkeU1KTFlFcmo2?=
 =?utf-8?B?VE01UjFuOEt6SGh3MkZYc0dwamtwTjk4MlUwS3h5WEE3ZmhIVE5pVU16Tkg0?=
 =?utf-8?B?bkFpTkwyRmdCMlBvUDNoNUIwQi8xZ202WEZ1ZUJBS0hoUWZRMDFaZERqV0p0?=
 =?utf-8?B?QmRiVEppQTBnQVVCcDRNYmNtSWkzNmhVYWFCSWp0WHI4cEJTVXkvcE81amo4?=
 =?utf-8?B?ZGNUSVRSSjdHSFpRaEdDWURua3Z4SEI3ZUIwUm9Oc01rYk5GdXlod2lsRTRY?=
 =?utf-8?B?OEx1dERBT3R2UkdXU2d5UTArdUVId080YTVoKzJGdTVqSHVoaXoweFVUTm1M?=
 =?utf-8?B?aElGZnVNREY1M1RtdHVCWlVKMk94UFI5RTdiL2tUZ1VjVkdXNHd2c2dhUDdN?=
 =?utf-8?B?MnpPRTk5eGFzbkw1aUtFYWFGcFg2UTNTV0tPMHhtMFFLOTZMaXZFdC9ZRmRJ?=
 =?utf-8?B?MTZTb2xMRm0zeHpNL1pRblpuZWFuOGNpK3JhQjlReHFsdGExSjAwOGRVTVhh?=
 =?utf-8?B?emZ4VSs2UThkTWtjeFVpcjYyczkvMEJ4NEpHK3p3eFE1b3RpVHl2eGVqZ2Vu?=
 =?utf-8?B?T1JMYWZzdm42di9VNU8rRUEwQTlYRGRQUUJBWVJXTXBTTTAxc1dBV3ZHWU9I?=
 =?utf-8?B?UEZGcno1bGs3UnVHS01kSlM5OWNaSzRvZHFDMFRVQy9tZmRaTE5yVlVIdkc5?=
 =?utf-8?B?ZGRITUQ3Ty95cWQ5Y3hlK0k2QnVEUnRvdSszdEpQL3FRZkpzcGhraHcrOXpp?=
 =?utf-8?B?bEg1amk2QmYzZ2ZTTWRaQWlPc0FGczluUVUrSHZhNk14d09ZYjhnbkorRFdh?=
 =?utf-8?B?YzRNMkZ0cU5rckUweHY0ZjZXOUF1STdPSlN6OWg1TkxBN2RtRE45VFJHSGRm?=
 =?utf-8?B?RFZYSnRDNnRyN3RvU3FsdU9NbW9BbXp3TVZBT1prTWU3a2ZpRVlWOHo2a0Z3?=
 =?utf-8?B?dTJKM0V2WEc3dzZOZnNHMStidXFDQWExY0t0a2NmYVNYTFlNY1g2enNYT1Fx?=
 =?utf-8?B?NSt2TGFrWU96RVM2SXRIY054T3pUOXlReU9hdlI5YUZmdG5JcSt0ck1Zb2hG?=
 =?utf-8?B?VjFrSWluUTRCVUpIZzlidWhUMlM2TkJzcU5HZTV2aHlKT0t3dVplTGkxY3JY?=
 =?utf-8?B?YWlXcjJGNG1jemVXYXdicFQxbmg2SVR1bDB0bVQvR3Z3K05HcWQ3eXVaVUJK?=
 =?utf-8?B?K0tIYi9FZ3puZE1wNWxpOXdqbXcyREdlbEVTcDBvUWZhLzB0STE3dEl1bjds?=
 =?utf-8?B?bnRXOWJwUzdRVHQ5UVRLeVBWRmVtSERDU0hlb1FoRzZyOEFyVHpOOWV6em91?=
 =?utf-8?B?MVFBZGFwSWFuUlJSVWp4SVpzc2tEYzdoamVlZzlmZzFjT1p1VGd6c09YY0Y2?=
 =?utf-8?B?ZDREZEFxRlNnWHNHSzBKUXRpMVk5WkMyZkJBWmZtVWVjZVZEanFpOWpjTUE1?=
 =?utf-8?B?ZGtRYmQwbUs0U09YcW1lc3lkTzl3RUN6UktmaHJMSFNkckp2OFcrWVUvYlpX?=
 =?utf-8?B?cFpEOFNPdzlweDdWZUlMWFJwbTI0MjhWTWJzbUUxdXRtU0pwUUJUb0N6aFB2?=
 =?utf-8?B?RDVaVXlxVzF3c0N4TWxNMEg4REhwbmFGaGZqZUFET3dWZWpxWEFDTDNSaTM2?=
 =?utf-8?B?M2FIbzJkWk5Xdkh0L1o4TGpDclUyMjlQd2V5TE53R2g1MlFhQm1ycE8yUWVl?=
 =?utf-8?B?WmNScTgxWlFrRjkrbWhHOG9zbXk0Yngyb3g2emVOZ0w5blFBdDY1Skp6bFJp?=
 =?utf-8?B?NjdJVm5hMzZkY1dDQ01EbkFkbDl0ZWlScldPYTQ1OG5HWEk4ZElSNlNmQlBZ?=
 =?utf-8?B?eWxtMVRBL0trYXhhR3RiOWlrMHBrdmgvbjVBbElha0xjZnY2SWdIU053YmpP?=
 =?utf-8?B?VU5XSDJXckp3dUxZMmpiSE9jcVdNY2ZubHQ4NGJwWjlKTVhROElWVlN6Z2pB?=
 =?utf-8?B?dm0wbXdYQjNDcmtaY09Pb1JGOHFPWjlhbkxELy8zWGFtY1ZMNWZFNElMcTZG?=
 =?utf-8?B?NWpzWkVYZkZDd2xGaStJZEEwS2FrSXBvOGJ2UWhHVldscitCd0hmUGcybngz?=
 =?utf-8?Q?5ZI5Cyjr8+U650Jsa3npY6xzx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1791961-e28b-4275-3205-08dbda3035a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:41:19.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy2RXpUWdszPbdiNNPUacJ85uDxcxPdiFIeqz7az7v2TwvcDr7nkSA9xBXJAZQqK+/gsWyrXLgEZK/F4ipuZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-31 08:32, José Pekkarinen wrote:
> On 2023-10-31 14:20, Greg KH wrote:
>> On Tue, Oct 31, 2023 at 01:42:17PM +0200, José Pekkarinen wrote:
>>> On 2023-10-31 07:48, Greg KH wrote:
>>> > On Mon, Oct 30, 2023 at 07:17:48PM +0200, José Pekkarinen wrote:
>>> > > This patch addresses the following warning spotted by
>>> > > using coccinelle where the case checked does the same
>>> > > than the else case.
>>> > >
>>> > > 
>>> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10:
>>> > > WARNING: possible condition with no effect (if == else)
>>> > >
>>> > > Fixes: 974ce181 ("drm/amd/display: Add check for PState change in
>>> > > DCN32")
>>> > >
>>> > > Cc: stable@vger.kernel.org
>>> >
>>> > Why is this relevant for stable?
>>>
>>>     Hi,
>>>
>>>     I was asked to send it for stable because this code
>>> looks different in amd-staging-drm-next, see here.
>>>
>>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c#L4661
>>
>> I don't know what I am looking at, sorry.
>>
>>>     Feel free to let me know if this is wrong, or if I
>>> need to review some other guidelines I may have missed.
>>
>> Please see the list of rules for stable patches:
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>
>> Does "remove code that does nothing" fit here?
> 
>      Yep, it is a trivial fix which compilers should be able
> to optimize, so no real benefit to the user. Sorry Greg!
> 
>      José.

Hi Greg,

Sorry, I asked José to send it to stable because I realized the patch 
listed in the fixes tag wasnt quite needed on stable. Patch from José 
effectively removes it.

I hope that clears the context. But there is no impact whether you apply 
José's patch or not, so we're good either way.
