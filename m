Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91C783860
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjHVDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjHVDN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:13:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7161AB;
        Mon, 21 Aug 2023 20:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbjk8zUPSk2RIkKFkOoeSPHHON1ZxeMQ5D19dNjYm0lT7HvchRi27liKwk3vxh6X3hbaLXlFkjY8uc47FTRiC5gSHJoP2iow0o8WVXTmYcmMblwPW55emiKVwITkKf0QLBy5swYfx2Uvla2EtinRMZ7+JRCSX1+xAPPcdrG8dmUldB3YKqpe9FRBvcCXEgWjKNt9HxCli+lA31v2UcIhDPenk9XkSIpt36m+ZpM4yIxFPsUqHMoSZuytQDzyTJeXU9WTWSvP+qQwoKBWdBf0z5EuIgMhNNVQr5xkff2mDnsfpn07GVWCDLQFI7IGvEcS8Pu96awhxAqS57rHB8R6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/hfizMRDuGrke8WxXboVBj3if2jXqBgw6LBE6ifjOo=;
 b=QQpHk3w1E8DW8eW/nuNdXuRiIbrOK4kwbESsZYJeuaYEntlKnFEhXLHrJ0WdW6R8xbxLkL6bENFeInGniPESGTjzhJcbeTTz/ivMKKMxZBl+wPJChlFfbsXgL7CcWwthBImR3w4nwvNk0b955beOqTA5Ci9ww4Y1LIjaXEusYFbD3+8zAxxcTz0RLyhJobmX6dvKXhCsg0BTnCwcpUtypZ+jOJv1SfijrgHuwnlQOAE4NfAqpu5zr28jHTZdG+9hFTdjrv5X4V3ui7XqTteeBrKoXiMTSpBg8eWz3D6DhQXamUtdBoSDyIyAIViNsaQw1aPt2puP97BP4rHL3nDoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/hfizMRDuGrke8WxXboVBj3if2jXqBgw6LBE6ifjOo=;
 b=KpVWAMNEXRbRc183CrarvIS578x/klvNeOH2xxMfHMiFawRAlmrbUTuQs7loWOd58StTzYb5ZNrazLizwyzZ5YJoH+ccs6yNlWLI9fPmHQNJNe051p7DN7aH0HLA+qMj0/GAm1PUxSh3aH3c8MJj02QlFyZkSfPRf6dhOkbaqFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 03:13:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 03:13:50 +0000
Message-ID: <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
Date:   Mon, 21 Aug 2023 22:13:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2023081919-mockup-bootleg-bdb9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 22df8e94-6dfa-46b7-1b36-08dba2bdce9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bxdwy68Vy4FI1AqdrC4YGD2jEydETuQGEQJNqlgud2WEJmY/PC9kWpGGwt4WCyZ02yylnghUo9TBupjUS2s2qPcL7wH/TgMg/L1egbWKzJiJV3DP3hCqnO9upunQlVolo2dRmm2VXhmWISm7BqqmfQgim/r2ua4j95AeiBJbqP3xR+BXaxikUl4Dlwi2Fh5jve5vZ8DC+XxZNSAizzphj7YPCSNolCLP8o5eS/B5sDpaqWosaGZTp8ykbu7QrVfXHlurw7dGcOX6bpEv7VVJ3689JAu9ORn6nxtiik5amndNmYRTTdsLhZykBtQPsEu5HUsLvjDenybfP/Mm6NBYzxImmsgNG+32Y712+h8mMa39+i0BJjK3lARDRvyXknReKIiLJDAxBs94JyV85+e7Kc1lQLD+igyWB1T0zjnYGikmDaV96M+sxxwezSFEPdT7iHnwUawJLIj+aDXM57vE5EnmqpT8qY9rU3XDcGwCF3a5AAns+ZiaUyIMUxEhT+L6rnMczYfYMF2z9nXXApu3piqm0dyJIKOWzfGOYAEvG/GOoAZ8rNw9zIayCeAG1BBkBl43orHxFQD/H3C++Zyrw0aePLwdXzLbwr8b1/r1j8JsHTc4wacYfDZrjdNRhdAMpZa8XRMEpYf+WZ1k6UaZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(2906002)(7416002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtaL0dGMFhQSWFzWUZKaEQ4dUpLYlYzaWR4QnhtMlFEbjlDaW5qU1V2UE9m?=
 =?utf-8?B?Y25IKytVR1BrL3l3NitkeEhlOVFqUGs4V2cxN1dLN0lqa2hWNi9iYmJmbmpX?=
 =?utf-8?B?NlpISzdnQUlIQjVhQitiV3VESmhHRzNCVjJ1Zk8zRllZbHlZYWdveGZ2VDR4?=
 =?utf-8?B?a1FYZVJvZ0dvcHg3dlg5cFczdXR2cGNwbllUU0ZZUkxSTkZQS2J2NjhLak14?=
 =?utf-8?B?enJvbjFFMjIxTHpNS0ZhZ3NNZVZ2cEpHK2VFdEdlT3ZVL3pIeUUzb0tYbUlQ?=
 =?utf-8?B?NHVnMkx2cnJncHVkSWpuQWhweUVWUWZ6bks0KzNSVTFyUjYzMkxrS05DNHNL?=
 =?utf-8?B?WnVKV0ljcUYraGFGd29zdmZjOTZGVmJSUHZ5TUh0S2RzRGdNWm5XNE9WNTg0?=
 =?utf-8?B?RWRPaExoRUZYOGJGOHI4d3R0K1djeE1KNlU5d2J4WTFSMjBiZC9RNW5RQVV1?=
 =?utf-8?B?SC81aHNuY0VqNGkrVXlydEZuRXRuY0JoVVpqSDg4eFdobVNFL21QVWlwSzFL?=
 =?utf-8?B?eXNic2EvRTJVMGpzZHlqWnh1a1FuSFdBOHZhU1NDZXRDeHltM2cwZnU4cTd0?=
 =?utf-8?B?RE5rWkwwMW1ySjBlMVVzUkkzSnRtVCtoSzljbmgva05STVJoK1ZLS1JxZDJq?=
 =?utf-8?B?K3h2bnhXeSt4eVlXcGUyakdEeFFJL25scWFyaENqYjNtSER3eFFZbGlPZEVC?=
 =?utf-8?B?Wm5pc1Iwa0pudWpkcHpoajZqb0JIeGExcmtrZEozdUM1Mk1oRmlwVUtCK1BB?=
 =?utf-8?B?bGhwTFBzazljMkdJR1d5QkNZcDQ5MWhUMUk3QlBGbW02eUloaTluS1FNOGFs?=
 =?utf-8?B?KzdHR1lkZ1hCb2NIbitRZkdBZ1VvUXVMQXZBNUxNMFYrQnJYaExrZ0JaTW9X?=
 =?utf-8?B?S3JXYllWcEtLVG42MEd3VG9qSEE4SGt3amlIZk80ckFrdzI2QkxycVdFSTZt?=
 =?utf-8?B?blhYTkNkYWFYSVhmRHNZUGlCTzZNT2dFb0wxbmpDUEtPT3gxWWZ2V2lvQVRj?=
 =?utf-8?B?U3dWMm40TUxyOUJMNU42dWl5RnIwemtIZTRVbkF1QWVBU0tIVnFEYWJ2NUd3?=
 =?utf-8?B?UnJoUWJqV3lJZ2hIK0ZIS2ROVXBsdG52eXdJOGtUaGo2NjhIQW53ck9iOE5F?=
 =?utf-8?B?VEQ4djF2NWlaZG5Pb2N5OVhJbGZBSDJPVW5jdE1VZmgvTDBPL004ajgwUWpS?=
 =?utf-8?B?cnpENFpodnAxMHBTWHhuZ1RxUDVzNW04WENpcCtnNkgxZ1dhNWhkZHNPUDNo?=
 =?utf-8?B?WXowWUFVV1ZxUFBHTHdocnZOYXVJVHlnN3l6dXBjcFNhVHJSN0dvS0FFUThy?=
 =?utf-8?B?V0NRTkcwMFo1SzdmT1oxTzdRS0Y1czlOQWs0Z1BmWjlSRUpjZnp2dTgwb0w3?=
 =?utf-8?B?WkhpVFhkWjBzZXY1dHpjR3E1L044TkIwMmtiVWxpMjR4ODBOQkdqU0NzNCtH?=
 =?utf-8?B?bTFmWEc0bityaGR5c3dYRXExMzZGTFNtUW9iNVZzZTBjYlllZ1VoR3RVQlZC?=
 =?utf-8?B?a1VwQ0w3d0ZOMUh1a0pNeHFPY1lSdjZCU3FlK1BIbit1YWU0OXVDUG95NFBh?=
 =?utf-8?B?T0RJRXhMV0UwSFMrOTFNSjFEUVhBZklUK052NzRYb0E0a2kyanlMWWR1UXNI?=
 =?utf-8?B?MjYvV1VvZmRXVG9WZkEzQ1hObUNVbWdtMHllTmRFcUlXVXlZdzlSaml6eXJW?=
 =?utf-8?B?S2JzUEcvMFZINnMwQWoyU2lEU3RVK05yMFN0TW15dkRydUhnRHMxVDVnSlJX?=
 =?utf-8?B?K1ZUa2dpVXcwVXA4a0JKSVVYVUNPWHYwT01NMTdIOTF1WExDYklyVEw0bFhO?=
 =?utf-8?B?cFBoWUVWWXVLQlV6M3M0eW5UTDdDd2ZjZEVoKzhGN3ZQNE1kMnhDNjdRdWU4?=
 =?utf-8?B?aEJKZHhpYVpKUUp4ZXlBclpoSjZoQkhEUFA3SENzWW1wOHFlOUdoTGc4dXZ4?=
 =?utf-8?B?UzZvSWlKcHhkWENOWXNPU05VK1VzVHVzQk5wNURCTDNVT3NBT2kwUnFQaWoz?=
 =?utf-8?B?aldabFdTUWtzamppbC9jZXIwQ1dDVUo3NUdkRDB2MzQ0VkUvSXlhSStzSmpt?=
 =?utf-8?B?OXF0OWxBY1YyRE1zVHhobUZva2R5QnVKcGhIMjQvTXRuT3ZoTVU2Y1pHc01X?=
 =?utf-8?Q?VjcUifRvVEAirfIIeoMRcuK6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22df8e94-6dfa-46b7-1b36-08dba2bdce9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 03:13:50.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnzONaMIQho7cCZSzFREaA7UEm4OBRFpjPKljmKqgubEIdwdQLgnwtp34RuvKbEmaSJuacNcHVucMPjMrXpkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2023 5:50 AM, Greg KH wrote:
> On Fri, Aug 18, 2023 at 05:49:14PM -0500, Limonciello, Mario wrote:
>>
>>
>> On 8/18/2023 4:24 PM, Greg KH wrote:
>>> On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
>>>>    drivers/base/Makefile                         |   1 +
>>>>    drivers/base/wbrf.c                           | 280 ++++++++++++++++++
>>>
>>> Why is a wifi-specific thing going into drivers/base/?
>>>
>>> confused,
>>>
>>> greg k-h
>>
>> The original problem statement was at a high level 'there can be
>> interference between different devices operating at high frequencies'. The
>> original patches introduced some ACPI library code that enabled a mitigated
>> for this interference between mac80211 devices and amdgpu devices.
>>
>> Andrew Lunn wanted to see something more generic, so the series has morphed
>> into base code for things to advertise frequencies in use and other things
>> to listen to frequencies in use and react.
>>
>> The idea is supposed to be that if the platform knows that these mitigations
>> are needed then the producers send the frequencies in use, consumers react
>> to them.  The AMD implementation of getting this info from the platform
>> plugs into the base code (patch 2).
>>
>> If users don't want this behavior they can turn it off on kernel command
>> line.
>>
>> If the platform doesn't know mitigations are needed but user wants to turn
>> them on anyway they can turn it on kernel command line.
> 
> That's all fine, I don't object to that at all.  But bus/device-specific
> stuff should NOT be in drivers/base/ if at all possible (yes, we do have
> some exceptions with hypervisor.c and memory and cpu stuff) but for a
> frequency thing like this, why can't it live with the other
> wifi/frequency code in drivers/net/wireless/?
> 
> In other words, what's the benefit to having me be the maintainer of
> this, someone who knows nothing about this subsystem, other than you
> passing off that work to me?  :)
> 
> thanks,
> 
> greg k-h

The reason drivers/base was proposed was because although the initial 
implementation is for producers from mac80211, Andrew pointed out that 
many other things can technically be producers and cause interference
if not properly shielded.

So by making it part of base that sets up the policy that if something 
"can" produce certain problematic harmonics that it can participate.

Whether or not other devices /will/ use this is another question though.
You need deep platform knowledge and proper equipment to diagnose a 
problem and conclude it can be helped with this kind of mitigation.

So I wonder if the right answer is to put it in drivers/net/wireless 
initially and if we come up with a need later for non wifi producers we 
can discuss moving it at that time.
