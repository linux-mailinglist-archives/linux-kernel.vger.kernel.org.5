Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A67619AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGYNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGYNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:20:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0E2106;
        Tue, 25 Jul 2023 06:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPjb80+rWUi0JCi0d1aCaQs8rWxqNGAvHCk2VQ2lFq7Ezgo8WJi1xBOhHQNjFgJY1fYIXPvEvdaj5fwzQUgkLa+ZbQ06GuuV9v/tl1ItUBFPNb30/xARXFOgkAiJThMQEyLOEIMncnzy/GpWNGV0tgfstpAh4qdP2o9CNUvvpVoTJWzixbrMaUU6Hr04mxyqf+ezQpgCnUvmxq88w9RWvIkUDAJTkX2ug9r0DeYD8spQXpgF4R5aK53Nvtmb1q19V4mN33YSlnRZLLFUNA7WBMNT9FUj1QtOo54qZ4aq64hSwB969fiJ+0r926z86qUP/vlmP8e93D5TIDpR+CAWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBqRqqpzzRb4OtHef5ySx8EyIPo9cxNQBBKcZwQICD8=;
 b=Ql3EVzlJgOvJSYRLUywP8TpPG+NmRvxtURQdxcMPsn+ParS6RjXGzcZ5hBgDtyOIivtpR7ayqmwfQbLovLw52B/c5SBvfaVkRqXaih+xSfA9WegWNtk1rjfvna24/288nf47Yyqg+UV3zjcMHRG2oigOj4xl4yaET7rv82DJqwserkg6AbTAtUXSeAYFY8C1mMRqdYy6wJdI2wh3ZKNyedXFIus0eQOF5kb0JYLqabNVelgI1KbrmGk60m6ienPBKzMDouinSrKW1qu9A+Fyy5lFmW9ejinDyloBSUQHcwKsm5FczRr7Rfzaa9FlYOluhcDZzvmzxnlTEZJuxd8DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBqRqqpzzRb4OtHef5ySx8EyIPo9cxNQBBKcZwQICD8=;
 b=BdGrGGBhA7xKnxMcoEzF9ZGUNYo0PRF5PiroIoEobIbLtx+eaQtX3BxKj9I2zIqijiLYdumxetuVLEoIWmnjSeCZfC7O++uhPr0hcQpgDNArJg3Gga3VWYT1jmiaTvvLPjRqI6YZkhAyadR84FRO1senr153x3+9F+xF+sMFtkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Tue, 25 Jul
 2023 13:19:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 13:19:40 +0000
Message-ID: <d2f7d5dd-cada-a3a2-2962-9c93d847f491@amd.com>
Date:   Tue, 25 Jul 2023 08:19:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joe Perches <joe@perches.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        workflows@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
 <20230721185557.199fb5b8@kernel.org>
 <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
 <20230724180428.783866cc@kernel.org>
 <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
 <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:610:57::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: b568cfea-9756-4d73-8d88-08db8d11cd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8LDMliXU5+A830fxR5hUm+to3x85Ts8nvTYpMHZYecBV6CoKHFhNZioqW7LLRb/98N+RM0N9ohpA6Kc8JXr8fpouF/ObgykBNNWjoSAHLIDGLjmQ7kAMrl6/9+Ti++gM7ZgJC0kxQ5zhV3VFbDtXtVXpQeZArPN1SIQit5HpMq9pl5Yo6vT9lqXvUEVKF7aDz06JiezOz43re9Co1wEVUL28Gk5X1ARqKqs4lr9Vz8wiyN4k6F5iF6NR+dY7VwEeLE6sAW3qMxN55qICUihhGOsFaXHLgRpG4sTOWcx9lAj0qLhbIFXRDgNM3Ot/Uz04BrPRawCYc9Fjyay2QjLsI+yuSmQmD9gU0t1K+Xa4Owf393No/ysViHjvDy1w4uVJ2asnQI7yUhoZ+L+pt3ho57D+rxZ5p4DMDbKAzQ17zK3HlNEsfx8EmtTG8fWNJ8d5e7Gc3oYBnOBHE0CJzB7Oh1ioKXIp5OIP5SQAhLE8Afn5J03HR16a0uIVid8Pyd2PYuGIggW2j5oEyt912HI+BQh8gVLyP/gkq88e3A+DXxo5j3vgtmuCDgYdTV5xQFo13mhe+hK0wijXSCCoVi5yaM/oG5Pa5lR0oAM4pSnW9OsgoIwNUDdIGFuh6cW0N8kgNLA1vcVxFzELkLQkezxAS6f51FmxNzscXTOAwYAJMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(54906003)(6666004)(966005)(6512007)(478600001)(6486002)(110136005)(2616005)(186003)(53546011)(2906002)(6506007)(41300700001)(4326008)(66946007)(5660300002)(8676002)(316002)(66476007)(66556008)(8936002)(38100700002)(44832011)(31696002)(86362001)(83380400001)(36756003)(31686004)(168613001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdPUHhtU3d5Zi9pSzlPcDlleDNaR0ZwNng4ZjJJZ29NbWtiK0hPVFFGRHcr?=
 =?utf-8?B?ZnB0MFJIdXhBd3lGZVcyV3lCczFqaEpNdnZ6L2RudCtHS2tqRTUyRXBIS2F6?=
 =?utf-8?B?Tnd2WjJDa08rck5EL21GcjArQUpXM3NIQUI2cjBzMm9NZHFoK1hNRXF2ck4w?=
 =?utf-8?B?R2tWbEJ5ZkVDTVR0RzBsSFd5YWJFK3ZnRGpwOXBPMTFyYzNzd3ZjamF5UGs1?=
 =?utf-8?B?azdjMWVmV2V6OXNXR3lpWmlMQ05MRk5rM1Q1ZzQ2U1JzTUxLWHN1QWxMVmsy?=
 =?utf-8?B?WGRJajhtRUdKWGV6NnoySWduU0QrWjJRak4yMWV5ZEJrbGJrdjd3cm1tTlZN?=
 =?utf-8?B?cUJvcExEYU52MFBZa2lqYlp1bTN3dUxDbE8rR2E3dzFTOTNLbVI2MmRDVldI?=
 =?utf-8?B?allzUlo3N2xyRjg4R1VoalgrSEZOVnhsRGlDV0RlSHgwVkIwOFRlYWVMRzdo?=
 =?utf-8?B?eVVvRG5veXhqcjV5YnpIeG4xMGVNTmRteU54aE1oV3U4R21UeEhMa2wzaDky?=
 =?utf-8?B?TVMybkttSnhGTjI1b09KSzdOemRFMEt3MFdyWGNGVmpMbEtsamM4TUdCc0Fx?=
 =?utf-8?B?aVN2QUhoRE5rcEdneWY3M1RBYUpPbVQrME9NOEcrZXZsSkprTmM5UDRzcDJj?=
 =?utf-8?B?eGFKamhKUWxxSjkwVVdMeVM5WDZ0bVlEai9TM1o1azRwZDRUc1ZiTmhnZ0RS?=
 =?utf-8?B?MHNsaWxLcEh0Wlc3bXJmYWZYeTVjWDJlS3AwSUtxRlg3dHRzaVZGVkNqSHR2?=
 =?utf-8?B?ZjA1dGV3cmVoSzByckpzcGIrVXFNMnE0MnFvYU1sLzFDbW00dUJETCtrWG4v?=
 =?utf-8?B?bVNMcTVpckJVZmh5NDRYWUtlMkxHQ2FlRTZGek5rMTR5WXBxNUJKejhQSzFR?=
 =?utf-8?B?b1BLcmNPL2I1WjQxR1c5K2x3c2JnVWJicnhqSWVVMGEvWFFzRWMxRUdndVBz?=
 =?utf-8?B?dkc5bHNNWDE1UXZpNnA0TXJ3a3lnd0lSalJ4YWEvNkovaTQ4REZVOG53Y2JS?=
 =?utf-8?B?dUh3YU55enhyVHNDLys5OVlMOTJsRjduK2llNzhqbHIyS3hiREJ1WFNZb1pn?=
 =?utf-8?B?TG9yY1V6V0NCMG1qRElKOTgwb25lYk8xTUtDMkZUREdHakYwVXlYOUFrYjlW?=
 =?utf-8?B?UmxTWGxWNWhOckNpelRSR2JsTm1hc2pxb1RoWldvMDRIRnZuazZRWHd4MWdM?=
 =?utf-8?B?cVRnOWRYSnRxMEN1dVQyZ3lRRnJHdGNpVTRjdTBDSFA4T293QlRxWm5hemZG?=
 =?utf-8?B?U2Y1eVRNZjRtbzFMODBHOVIxam9yM3loUE9vclFoYjZ3RTZKWVBnM1ZtamQ2?=
 =?utf-8?B?M2M2QW1zaVcwL0w5MklqYXE5eVEreVRrUGVXMFREYk9XdkNkUDBLOFY2ZzFu?=
 =?utf-8?B?R0dLR1g3MnBpUHVvejZhNFJ6VnFWaml2VXc1alJCWGlaclROdW9OMG4wekk3?=
 =?utf-8?B?QjV2WTNBKzZBaGkrLy9MTk8yT1ZCYjF4Z2p2T3FuT01ibVh1U09CN1dqNXFB?=
 =?utf-8?B?SFBuME5sbE1MVnlVYWFBbGhEQ2thRm1xYzU2TTBycnpaQlFORE1PRWx6dFJX?=
 =?utf-8?B?VDJNV1hST0p6dEc5WXB5aEQ5NnJ2czRTdXBVOVlmcGFQb1JORUVuWS9OREFE?=
 =?utf-8?B?L28zKy9HQTNqSDlUcWVkSnk1NDBkWUFabHFzUUcyWkNOdXhBL3hxekUyZmdP?=
 =?utf-8?B?Wlhxc3dsOEcyTjVmNHNVYkx4VVF1V3JraW1OQUwyVHE5bUhUKzJzVFJ0YXJv?=
 =?utf-8?B?TFkwM0xyeVFZVFhHNXN5cGtLK1JKTWlpcVorZ0RTb0JIcDdaR1VvT0RlZDFK?=
 =?utf-8?B?ZUhUSUdTZHZ5RXE1ZkRnVisyaHJDSTM0YWk5T3FUMVhHZlRpQWROekNFcFpK?=
 =?utf-8?B?c2pqZjBrZk9uMU1sS1FYSlZNWloxTFIreXdyeEtPcTh1a2dCYWJ0WkNDMEt0?=
 =?utf-8?B?ZU05WFRCU050K2NOQ1p1eFh1RDVobVhxWVh2MExUMXJ5eGNMb2planlvQ1Bp?=
 =?utf-8?B?azh2c2pFdHFGRFF3MkEwTXlocm5NN3psamRFNy9DLzcwTy9SL3FFdWU1WXlI?=
 =?utf-8?B?aUxOeC9DdVU2UUhzQW1KNndzRlZWcnd2Ym1DN0hWOENVZ2FuTE9wNGJzMC96?=
 =?utf-8?B?NGMyUkcvTWkxbE40MjVrNjRhc2dORTA2eXVqWkNnSFVNRWlLUjRWQ1VFTGNT?=
 =?utf-8?Q?IWpQVJ8bqqWhnPF1DXDs4DIrTwEyDgVXdf9J8q+JxTEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b568cfea-9756-4d73-8d88-08db8d11cd4b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:19:40.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0T3wfRDg3C45V60ZdksJ8Ngtgo5lc1WK8cu+bXYXNqqMZL9SaKFk0ZeIZEvttTG/KjkIu3b61GsG1XHo72mUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 02:33, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Jul 25, 2023 at 6:22 AM Joe Perches <joe@perches.com> wrote:
>> I do suggest you instead write wrapper scripts to get
>> the output you want rather than updating the defaults
>> for the script and update the process documentation
>> to let other people know what do to as well.
>>
>> Something akin to Mario Limonciello's suggestion back in 2022:
>>
>> https://lore.kernel.org/lkml/20220617183215.25917-1-mario.limonciello@amd.com/
> 
> FTR, this is more or less what I am using to generate a script
> to send out patches:
> 
>      OUT=...
>      echo git send-email \\ > $OUT
>      # Add -cc
>      # Wrap comment inside $(: ...)
>      # Replace (...) in comment by [...]
>      # Replace ] at EOL by ) again
>      # Add continuation to EOL
>      scripts/get_maintainer.pl $* | \
>      tr -d \" | \
>      sed -e 's/^/--cc "/' \
>          -e 's/ (/" $(: /' \
>          -e 's/ (/ [/' -e 's/)/]/' \
>          -e 's/]$/)/' \
>          -e 's/$/ \\/' | \
>      tee -a $OUT
>      echo "*[0-9][0-9][0-9][0-9]-*.*" >> $OUT
> 
> After generation, I edit the script to
>    - Replace some --cc by --to,
>    - Add/remove some people,
> and run "source $OUT" to send the patches...
> 
> Gr{oetje,eeting}s,

My script is great for single subsystem patches as it gets all the right 
people but I've found problems whenever it crosses multiple subsystems.

Many subsystem owners want to see the whole series of patches to 
understand how they interact.  So the group of patches needs to be 
treated together which would need the wrapper to look at all patches 
instead.


