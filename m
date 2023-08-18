Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5A78158A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbjHRWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbjHRWtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:49:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4D2D67;
        Fri, 18 Aug 2023 15:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMPqmmSxq3CpCPD+AraIY52hTeDGX2zSCy77zX9narXPi16/HUDhKCVSrVdRtReWjCMuGapjihu+BwiUq/g85s7eXmncgNhSs0DQeQhFXfcta5zR804vQZQfQg04GLPYUW/CF2hU/1tA+UJUX9RlBDy/qVsGYMp+rQJ3Fd/yor7v+gKajxqV2ORWngci9eqr5HsP7paLergoWR6jdFLqv6hQUOTwW684kXqk3Ih1f3RVb4iXRCWJPhnG8dh4RdbLfCZuU9KVN1ZqXn16tgWwoJLVnywo3IAiVAqQYK3dFKiuH7HvmOxL+F3ZUwGxbVOGX3S1K0EdSHbv9tnYZKY/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uEoU7Rt++0aX8iGdzZVYcii023rcslcrvGr2gWHXw8=;
 b=PEArovOprgSEtLpKcZKHyl2IVnaMZg+PtPD+t/ck3hA6Ylop6XccPsgQTgTqD+6mvCAneDCAGDdg/XIYA1u/1DsLCKQxSgKBVgJDZqG2mT11fb5plqg+yRSj39X/nhlAFkpvoj6SCAxYKTJhsIw8wd8KNKD9zVdffX0vIeUvPmARCgaGcfC2R2UFeNdosYTsjosxEo1Jm3bCkwvX6oTqv0kVYgjhpuVAzTr2D5Xa6yeYAsHrDccd4URp14DHw/p4BuufEKm1AP87Cs2mHbN0qV9JnHfJzlx1ptcWeF8PHcrM34LdEIkd+k7wXSw3NSCvnNFb9rRV1Xftq/wY0AhxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uEoU7Rt++0aX8iGdzZVYcii023rcslcrvGr2gWHXw8=;
 b=rpGA9ZqoCQwpWe1GuEskzABuGYLAt/TLCxp2v6FDmuFgeQZOcK9QsTSg1uq64aprDLWDdEJ1wAi9NXwDmb6mO5jM4FDQB4QKAL5WSmQZ22DSz3xtgzqqDL7nZOOrkJ1zfwZ6W7cHEXCblKmHD3vWXxBFoBsUEbI/yTZDkHkAqE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 22:49:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 22:49:19 +0000
Message-ID: <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
Date:   Fri, 18 Aug 2023 17:49:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2023081806-rounding-distract-b695@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b951f8-2d06-4ed8-a569-08dba03d5b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvKXIA8/jyjb3w23DtuPFLGb5E6R9GfFdZRMP676NFgLTElhDK8cZaAqosdW3SvSwZjKLxPIf0z1FOj3F9y5WSjEaC5nRhznynAcAbQP2pW7E98Mn0oPsMuUmBD/HuoU/hvkDbBy2NY9M7twqqA7tAEvFA/30ukJPyXERiEnkc6QXlrUKQq5n0FJo2gM5iDugZ0so5bdmB8OTHKLOc1Rg/5Y9+oABfUvD3nxN/8VouyJiKC+V89MDLBvEUhkmQ0oMFvEDwg+xeHqkoMFXb41RLoo4xAsbgK2d1Zm51fFdjArAwNLYCQ3klzCahx05oGRyt06/lTLpdsSGw6LZ7TFrcpz44tGTkswts9WiqK2LFjTTZJikh4ItYvbiDPC1dgWTZM1x7PyXrJ15s/ywPM8WySy2BopB8isMud1qap8bXv5Io1iDnO9Otc7FmwUyqm07zoebAxDx7RldIZEAKgXqqRwij4yKNxlJZ2JJ2mUuIP3fXjgnadjI1pfB6e5xOwHhuVxOgVHZn6wh9vPqeDO9W6x6LSp+vRwy3aOXBGAVRDfICDRBVXset3DYvlZyKIGJa6+9VVTJ+QPOCVG06D8UsUOZ+baOsQ2gcVBoOZwRamD6FgQnt+tL9fvjgg0eG5InV2uE0UqyjehmqvNoflZcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(31696002)(26005)(36756003)(2616005)(66556008)(2906002)(316002)(66476007)(66946007)(41300700001)(110136005)(86362001)(5660300002)(7416002)(8676002)(8936002)(4326008)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW01QkdkdGtDeVRkUFpOS3BQUE5tc1dqYTYzNUs3QU84MkVRMEdSeTg5cDg1?=
 =?utf-8?B?THlWZWI0bGZaMlNJRUxVcGpVTnBjOHFxRzUzNUpkTUF4ZmwvZ0tqTEZkbytD?=
 =?utf-8?B?a005M1p4cG1NQ1Vic2w0czhjZXRtd0xxV1IyMU9QTDc0SjZaRzBFODVyWW9n?=
 =?utf-8?B?OWhSeGRkSHQ1YmVWSjN4dGdDcWJrVnFuVFY0T21Hajk3SnFzMVRDRTR0eTFv?=
 =?utf-8?B?NWRPdWhCNnZ2VlB3MkZDbjVLb2RNcGp1aE9iSEhmVEd0R015YmswOXMvZkhI?=
 =?utf-8?B?MmREc3hUTG1oTUVObHVoMlZvVW1qRzR5MGJzZFBhbDdCTVNmdVJQamZ2RzI2?=
 =?utf-8?B?ZHNKbi95ZnFpY3pqZUhaTEtQcTBWd3BBUm5iSDczUHVlL0JBbXpJQmk4cStY?=
 =?utf-8?B?TXJaT1ZpQ004TnVnVVlyekl1L1hCSmZVS3cvbnF1dzVqK2w0d0l2bHZwZjAw?=
 =?utf-8?B?Mzh2YWdsR3crNWZQbHBpNlA1ZGRTVW1KeDg0TWgzc0dQKzlzNkJRL0ViM0Jv?=
 =?utf-8?B?azVtZWdBUVN0UmpBeUdZeStWdEdxdzZ5VHpCTjgxaHV6WkoxN0xRVmlVS2Fr?=
 =?utf-8?B?SndSV1lwaVkxNFA0VnVCRDJMaU1oTlBrM0lwZ3ozUEdiV2p1cXFydDJOKzZH?=
 =?utf-8?B?YUVlWHBkZ3lmNVp6dGJTNDJrQVEzNnZEdkNGUFhHbkt6dGk4S1pxZVc2WEhX?=
 =?utf-8?B?cGlKcVIzaDQ4MmE4RGlLaDUyaERnRmJjR2JCOGl0alc1dU5jc0xFM2F3R0cy?=
 =?utf-8?B?YWRzSjlXa2dYUXFia1c1Uy9vS1AvaExTcS9aZ3pBeWRNYVlKRWIrUm1waVda?=
 =?utf-8?B?alJrUWhsazFaSXNtZ20xM2o2YXRiOHcrSXBnT002SU94ZXphZkhib0JRN0FB?=
 =?utf-8?B?cWVFMVBnakFqbmxuaE4xb0V5cEZYOXFVRSsvZFZiZDlkZWZNWTc3eHZHdHA3?=
 =?utf-8?B?aGFvNnE1aTBMYzF0aUlTOXM4VTkwL1p0b2tpanlXU3VIb25ubHVoMFI5TVUw?=
 =?utf-8?B?aHdrbGlYNmdaWFlsQUNCMkUxbFhHQU9rdFJubVgrU0pvK09UeVUzTjE1SFRK?=
 =?utf-8?B?VmFQcVhMQWs2MlVkSFUyVjQ1ZjZaMkpoTzhrblFnTjI0SjdzQkxuUVYyZGM4?=
 =?utf-8?B?T01nbHNaWHFDVGpYRXRpNDBLSGRrZWMvN2dDVlA4dDF5NU9qY3JqejRiQ3lx?=
 =?utf-8?B?ZFhmbG1EdjJ2NElBaEU1eXA2N1Q5cXJyQmZxclVDSnorRk5UUklPN0s5czZR?=
 =?utf-8?B?VDdidXZhMFVmUHczQzJQN3hGRy9lYU9GbXM1V2RicXg0dVd4M3FUSHZSeGEz?=
 =?utf-8?B?VGdrTWJ2TTA4bC9UblZwZFlyaDBVOXR1Z0MyNTQ5eFovOVdyWGpSZmxiS2FD?=
 =?utf-8?B?R1JlZlM1Ym5aeVh1WGQreGgrNCt4TEF3NmJJaDZvRlFBRldkbDJVSjlnVlVy?=
 =?utf-8?B?YkxIa09xcU5RdUUyN24wL1JuNjd2K0ZzNE1IbnlkL29JTytjeGpsempnQ2tW?=
 =?utf-8?B?NW5odFZNVmJaQVcrbFlINmpnUlJCaVd1Z0ZQc3JmTFJCdDFpZ2FWMHdwU2Uw?=
 =?utf-8?B?VnNnQUNRMzVDdWIyQWYrUHRRKzY0M0o0Q01TQmpSb1VnQTNJNEE3bFY5Rjlk?=
 =?utf-8?B?aXVSNjhndHB5emE0WHUyV1dTOUpHT3ZxelE4aTFDcnZ4QTlpbE1GMzhYS09F?=
 =?utf-8?B?Wk0wZ2MrK1FOWWtnOWtxZE5DdVpheEdjNU5wTkY0aU5xa1VmeWJGNVc2UGJE?=
 =?utf-8?B?U3VpUUxBZm1DdGNBWDc5bVlTTWEzSlphU1gwTktLZm9tdy9HQk5UQUFVUDBr?=
 =?utf-8?B?dUM3czNCZVh3MFQ5YkdQOEI4Y0IwKzBMVjdLK1dFVWMxNlRRWGM0RlEyL2pW?=
 =?utf-8?B?dnRIZUYxSnNkUi9WQlFqZlNaNk9HYk0waUNIM1BjWU56K2hONHBiL1JpaU1Y?=
 =?utf-8?B?SFRzMXkrSGs5dUZPb3ZzME15aUREcU1kYkRROGhOTWo2MkVtdkhDdW9iYkFO?=
 =?utf-8?B?bkZSZFQ4RHM2YUhLemdJOWFLNFFzbWV1ZWVXTkRhM08zUmlURk5FUitraERK?=
 =?utf-8?B?VHhWU2lCa0dBWkdRVHBaOEdTcU1zS0tBUWdMNkZXUi9VY0lzTUpJQ3dLODls?=
 =?utf-8?Q?ifoBtUQ2il4jnH0bq3xFJ5D4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b951f8-2d06-4ed8-a569-08dba03d5b2d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 22:49:19.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHDMiK8kvp+pDJXAF+Y40yFYTq5qsNBVS+FQnGcZKsmPWZ5KLroIXgfV7nyahzS0a7QHtUI+XL3CnlBqstuZ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 4:24 PM, Greg KH wrote:
> On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
>>   drivers/base/Makefile                         |   1 +
>>   drivers/base/wbrf.c                           | 280 ++++++++++++++++++
> 
> Why is a wifi-specific thing going into drivers/base/?
> 
> confused,
> 
> greg k-h

The original problem statement was at a high level 'there can be 
interference between different devices operating at high frequencies'. 
The original patches introduced some ACPI library code that enabled a 
mitigated for this interference between mac80211 devices and amdgpu devices.

Andrew Lunn wanted to see something more generic, so the series has 
morphed into base code for things to advertise frequencies in use and 
other things to listen to frequencies in use and react.

The idea is supposed to be that if the platform knows that these 
mitigations are needed then the producers send the frequencies in use, 
consumers react to them.  The AMD implementation of getting this info 
from the platform plugs into the base code (patch 2).

If users don't want this behavior they can turn it off on kernel command 
line.

If the platform doesn't know mitigations are needed but user wants to 
turn them on anyway they can turn it on kernel command line.
