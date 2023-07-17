Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CF756542
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGQNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGQNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:40:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7498F;
        Mon, 17 Jul 2023 06:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4p7r3XKP04A7BVNkNANDzq6nHq6q7wSkASLq84NLk+Srs1+YOd60jH/trrTtiR5nb5foKbZ2czXNRQArQYEuekne26od7ImVpnrgoNMawzv5DgFlTkYLR0FQFlbn5pRpbQCrCcUADFX5j664+WeDcR2bGxwfNE/sr1UDxDU8y68Xpi0vsJ8uasZEyhujwOOByetjg7iJcGtvkINacftXDW6s7RX6AlhBECOSV709j+xKFlsuYWzdlEHkcK12SDpbkDf2wFE9tGHNYrLrI4iMwHGtI3KN3R1bwhlx0P+oUg+kigxJ39gw4cn85hu9B2BU5yzC6Pcrec8/fac1sIWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KshGcYijw6AvWsj7AOqPB/Ps2ukCQ4v3NzEjmca2vhg=;
 b=WAtWS3EHDKHKa379dULCyXLliFjXHE1PLfvoVgixRQfuiGWXyopZp1jp5pvRMQLkVwMg5AXsosLZ0/B1Fq18VsOIkXSnr9WHP2TR0TU+8uIkgA8Ie5H547p3ay+XGOYzMYteRC5XoXBkQdoIAixKS9Hv6r2OBqgn3ySNPYAEFMG1QmoZADTcJRpzWlmck6CMGKXq10mg6RPgj9JB18HTzIQ9ooa89SbYh/DfjfuWDjyRQnXy1uHw8kVR0OgKWJpjkwC4T96N6jHpNxf32pdHXGhzPiCik9EoKN7JBm8uiOjQDg0CwP93A0cJghxUzR9K3dqBkj9ulW6QSdCIppmong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KshGcYijw6AvWsj7AOqPB/Ps2ukCQ4v3NzEjmca2vhg=;
 b=hELtXv/yX/BfzYt1Ylaz4eQprmyjb+62D4zCDeu+HhNj5i4rGKndY9AunUvTYryhWykPd6GxRXuNYBOm5l7efrULUZYa/be1H692xzN4OHOq4w2h2l0IJV9fzk70MqdQAbwEGNjYr6+OrDl3NHsL8DNH/+nWVM7IrmEi1AZEnrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 13:40:49 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:40:49 +0000
Message-ID: <820345f4-a8d1-ed16-fd40-d38a98033621@amd.com>
Date:   Mon, 17 Jul 2023 08:40:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] docs/sp_SP: Add translation of
 process/researcher-guidelines
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Avadhut Naik <avadhut.naik@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
References: <20230621171457.443362-1-avadhut.naik@amd.com>
 <20230621171457.443362-2-avadhut.naik@amd.com> <87v8emxosw.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87v8emxosw.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::6) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: b69a3fd3-2d14-436e-dfe6-08db86cb6e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqH6C4gzpHRkI/mcMj1bVFkTbo0gNqjbqfq87diAMAOYiQEjn9Etw7blvCqLCukfipjqYDucbY3Ttk4mOwTlHpA0gN/gyrc+ymMW1dAjSaDij4UaTIhyjlCDLWmb24wUDyapUucA6uodRJ9ki3n78NuKPQZbC8Ac43h+UEG+lDdRZQQFgBC6Jv64xW+iT7Ga1xYiY9o+dA04Xy/XhzbiYIzU4guzmjLsS0RnlALhCwkEyuVKTwu1Tjp3sEBs5OWxkayBJK1AbmDaH2qZZd7biIsCatno9j/1cjaYPsm9WSuciSUOtxAhQWluGnrNP4y8wkOrrEvhUxI0SoaNAAohSlM5kRw0h9GmgPmip3DiCIvXEwt4i4H4uJxjt7jSK5AD5VJ87h4L0q53fCSndCCZwcVDfpj8iw5Froi+leum94jjohRLzXoHrzvNpzftanCOiLu2IqY8cFbRRnx0Txo0tL2XpW13Iy4Yh6iRkPQtOjWZcBYRBO+hct10eBeXLKFEjcDK8X0V3VDPCEmxm4uB6ebO6NcwAhnSfLkIsfJmbsi96fGmbWFjeuzjgXs35sZ9UYqCv0LzfO0PaHp8lOZ7K+sF/4/794vEKbEOV4uh5Q/oLVjxuIk6M3K/WoebWBo75sb+ga96qbIcefk7JBI3nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(44832011)(41300700001)(316002)(36756003)(8676002)(8936002)(5660300002)(31696002)(86362001)(2906002)(6486002)(6666004)(6512007)(4326008)(478600001)(2616005)(83380400001)(66556008)(6506007)(66476007)(26005)(31686004)(66946007)(6636002)(53546011)(110136005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitVbkRqejhrcFpXZFZ0aTFLbFZXOTJlNEhaYUR6c3hsbjgybzJZYmtmYk5B?=
 =?utf-8?B?aW53UzhQMXgza0xBMU5UakRZc2gyWWFqWmVYUVBwQ2I0bUhYT3g4aHFGR2FU?=
 =?utf-8?B?bVhlSStOZjlvdFR3OUhFUCtuYUNNc0xTWjhwL1QycGl3QkdjL3gzMnlZdVlk?=
 =?utf-8?B?VlhkRGRqOEI1L1F6TFg1VXQyd0orci9CYnJTQ0NGYTEvOGNZdkxoUzQ0dS93?=
 =?utf-8?B?MUFZclJ2YlBONXFjL29BQkd0OTFLbXRURXhGa3FiUnRUb093aHdJd2llOUxH?=
 =?utf-8?B?UnJ4WnlzRTZ6YlI0a0RSNjNxWExicVVHY09JQ2hlQ2liVml4YWI2TkMweFdE?=
 =?utf-8?B?UWhTSXNkMTFnSmIvdzNHSy9Pd3ptVm9wVWs4SlBOYmp2UnBZd1VmMzBKVVNt?=
 =?utf-8?B?dlVReXVBaFZZTlk4Yy80Nys1QTdubXpWVDFDY3FNaTZyaXhVQ1dWRHQvQ2N0?=
 =?utf-8?B?UXpUeWh6NEgybWQvd3U1M0VsbHRtcVA1dm9BdEIrSENGRmdMS1BmckxOT1p2?=
 =?utf-8?B?LzZmS0RWVjBZcWtva08ybW56WTZudnNkdmRmL0J4bU1hRDlrNlcreWd1STJH?=
 =?utf-8?B?NzY1WVdoZEwxKzZZUTBwSnhnZ1dPbGJHSWhtKzY1OHVmTUNYY0VGcXdmSDR6?=
 =?utf-8?B?OHN1NHRuclpzcmFqL253dldIa3RSTDdMSnhlWitYSS9nckdSSW1uT2ZoSENS?=
 =?utf-8?B?YXBkbW1CdEpOZjJRVzNtWTBPRDk2TUxHRVBxYWFxVEd3eFBZMEIrRG50VVV3?=
 =?utf-8?B?ME1UOGdlTEErUDZRZkp2L1pTLy92a1FHazltLzZmaGtJZ0ltU1EzM1hxdUFO?=
 =?utf-8?B?SWJsN0FNMG5oZ3NqaERkL1QvRUR4RVhwSmhwRk16MU5LeTRXcHFtbzB3b1My?=
 =?utf-8?B?dGRzQ3VmamZ2NDV5TTk5Qk03OGpqeFF1bHkzRE9qQWFGcjVVNmpwekNvTnhx?=
 =?utf-8?B?UnpGemRENlhPZ1R2UDZpNEsyd1Z3bklxL1puYW1Sc1drS0Z4REtFem56bkoy?=
 =?utf-8?B?Wi84Q3ZNcnJ3aFdycURxamU2clAyMm9aNlhtZGt3bGk4cHpDMXBBQkJYYkRS?=
 =?utf-8?B?K0NGYUlHaFFHUFg4Tmp3RUd3WExyTndXaXpJNFJtajBqL0UrN0k3TW93Vm5y?=
 =?utf-8?B?SXhSNUJmTkRHN1NmN0RpeGI3bHpUd2p3VVJoZ0EwbSt0djZjRll0UXhvTGxC?=
 =?utf-8?B?NFNOWEUyWldMZVcvSFd5SGlvdWNqYit3b0ZmcWNUNi9GSnY4aitqcjBKRGRP?=
 =?utf-8?B?dVBlaHArNjJBbGpFb2Z5dVhGN0Nrb3Q1bm52QlUrbHU5WS9aYXlkN0trald5?=
 =?utf-8?B?WUpjeGVuczZjRnU4Mk51VGpVZkRkc0FwdmZSVzcwaStmR09nb3ZyMjUxdTFQ?=
 =?utf-8?B?Y2xVdTZtdzhiZk53akE3NWtFdHdYdnZjQmVYRGNabUtnSkJxZWNqVzlUc3o5?=
 =?utf-8?B?OURWdTAxUVFZNFMreVZDK3Mxa3Z6dlkvRUkrSlZoTk11Nml2YmRYaVhGYk9L?=
 =?utf-8?B?YmNVVFF6SkdsdFBDckVSRWF5cXg3V1hwMGM1TGJQRU9PbVQxTGx3Y2lFWHJD?=
 =?utf-8?B?UDIzUXJTUlROSVA5V1paRS9kalFGWFhhbmFrWHFRUTRqcWo4ZFYzQ0U1MnNN?=
 =?utf-8?B?a1lhOFdPK2ZDRjU1QzU3TnNlSEFYK1A4L2tWV3BmcWhPTW5HN0YwL3VaRlVV?=
 =?utf-8?B?eGdCdXBVMG1sdTNweWQ3WjI3aDdNeXZockFKL2lVQ1BJTm84T0pJRTNpKzdS?=
 =?utf-8?B?MFlaYXkycXUyWmduTWxkRnYrSHNzcE5iNDZ0RDMwU1M2c1VKWGJGcjU1dWp2?=
 =?utf-8?B?NnhtRU1Pb0YyOTEvcmM1dnlOUWFmZVNBbjNzb052SmRya3FJdlJVYngwTUlk?=
 =?utf-8?B?cXZJdUdnVGU1NHI0SzBCVkZTM21tbG1xWEJLMlBHOXVmNDBEQVlKZzJBeThH?=
 =?utf-8?B?dTYvRC81a2FPNURFd0VaOVNZNk1CYk13VENSc3FnbTZxdWlhQ3QrV3RaZnVC?=
 =?utf-8?B?SmtsclFYOUlYS1J5dnFMT2Mwd3Y0L1JjSGo4ZFdIT3c2ZTFjYXk5ZlpjYmRL?=
 =?utf-8?B?Yy9yTmQrdTV0M0NDdUt6Y2p5MG1VZlhEZWdHSlg2SEY0cEFRVnFSWHJhb2ts?=
 =?utf-8?Q?f4bilV7z+juEdYJcL1WXaCid/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69a3fd3-2d14-436e-dfe6-08db86cb6e06
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:40:48.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGDPv0PZwvwfZHJK41uBPVV+U4wiKed+7PwWz9owoAYRi1YY4WGEA6bzuG9Qve4Z/q4+U+O98+1k8ga2BJ1gUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 14:42, Jonathan Corbet wrote:
> Avadhut Naik <avadhut.naik@amd.com> writes:
> 
>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>
>> Translate Documentation/process/researcher-guidelines.rst into Spanish
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   .../translations/sp_SP/process/index.rst      |   1 +
>>   .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
>>   2 files changed, 153 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst
> 
> I've  applied this, with one tweak:
> 
>> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
>> index 0bdeb1eb4403..ed6851892661 100644
>> --- a/Documentation/translations/sp_SP/process/index.rst
>> +++ b/Documentation/translations/sp_SP/process/index.rst
>> @@ -20,3 +20,4 @@
>>      programming-language
>>      deprecated
>>      adding-syscalls
>> +   researcher-guidelines
>> diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>> new file mode 100644
>> index 000000000000..9d374c70348c
>> --- /dev/null
>> +++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>> @@ -0,0 +1,152 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +:Original: :ref:`Documentation/process/researcher-guidelines.rst`
>> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
>> +
>> +.. _sp_researcher_guidelines:
> 
> I really don't know how this business of adding useless labels at the
> top of documents got started, but I'd like it to stop...this label isn't
> used anywhere and won't be, so I took it out.
> 
> (Yes, the original has such a label, it shouldn't be there either).

That's interesting, I always assumed the labels had a use I was not aware
of. Ack on dropping them.

Congrats Avadhut on your first translation of the Spanish documentation!

> 
> Thanks,
> 
> jon


Thanks,
Carlos
