Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD91A76B7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjHAOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjHAOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:37:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E2E9;
        Tue,  1 Aug 2023 07:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOZn3/exlIf9Z8APF7iUkbN9H3uzCZBM9Obc0v1U7gZu2J+FX/gX9DphKUSoJ8M+UksD3WGx8Mcer0bBDPEisgjYq4oZa5StKU9fzmLHcZCD6x28P40+7aL4wEKmPKk44F0At9wjL6HUxRIysGIEr04hQWeq6FOuWeQ0Ip5RzkpH3vrrtJMRQmnBPp4M4AMzsqJKib8yJvUccJbvtjIwXG9O1y0df0TuT0qOwAHlVQl5MHhynD4WQNGafLJ2swhFmwt3njdGl1Ev2XXjvD7NjQtCsTHgac/2vLCmeGyKHxsKB/bhYvHsduyYGH9s+tTzU7BxZlaZ2XaMrb25gUMpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18gjVD0U6mrTYvnwB4+OQJLjYRzllAO6Eb9S24DI5zU=;
 b=VvlCOv9+M3lgkDuIzTSV+rfPoE7ODZVjZQ7QHLjNN/HgJsMeN85V+6QKsl5jQAzKlvbcWp72VdVHfS0Skfx9SKMaufoxD6KmMD+6tIVTsLqe3K+eXfYvy6QSvMZK+ZMOUVWlTiNThlgYqpx9jkAqDI3xbvrH9J5vRdgDqF/nT923Fq0AIQVlpIi88meRBA+oX8uPWm3H7J6zd7ipRE620qkk/zLchdk1zB4gnglk8DzP6mnMLLSG4aPmwEJiRGdlFyau67Wn1P9I+T+ACv4IaC6/2s4S5CC7Zoan4n/t+zJbQKkiBdq+BUmmju8EaBhREThDtQmtegWqXAr0IIXPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18gjVD0U6mrTYvnwB4+OQJLjYRzllAO6Eb9S24DI5zU=;
 b=l4QxMDgox7LkL8VPdxoOGa3t0ZNCt0oBH48HO9+ZygxW2/vCM3hdCZHPGgLoTmnBzUa8hz5aaRQtF04mZHuibdeSDLMIfT9lOiIWdkzkyyYOk386A+/+3SX1mX21VsYtjlTNpOikgFDPJROfCZkcMrFUsdJOyDKqgFIjQEkegnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 14:36:34 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:36:33 +0000
Message-ID: <ed5b4588-b4a1-6180-01bb-c35ebf1e3ee6@amd.com>
Date:   Tue, 1 Aug 2023 09:20:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>
References: <20230711141257.232312-1-carlos.bilbao@amd.com>
 <2023071151-sprinkler-aids-a07a@gregkh>
 <DM8PR11MB575068AC229C410A9FA5F3AAE736A@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <DM8PR11MB575068AC229C410A9FA5F3AAE736A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 629cf0f7-16d1-4151-eb1a-08db929cb3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1FQR+YU2U0RpCD6uYlFIAlEEaPUSXgp5vSyS5G/ty8zvBsWErWiPUVRgFAZXULjX9Guz42SOBT0SUyPJVYJg/AkixF25wEN9Lv4T8h/dNMC/R5iRMs8HTdzRkccbWEImim+WT+PeQfwEK/8qVyWlnUSR+23kVrYPJy/pSbjTquBmyJXSLxmE8E2vIbyaTWTr+h3cpg7el0pkCocREbKJaWYwsX8XI9el8UvlMGGNBLRLo7dJROrUaQzty38gGz1t+F7oV0iSQsnrDvk+KE9c7xZRL9JFcl2OYp+QIP8E8I2xw+d0Vwrj8aqqf+7bSWNKHbNLlC5LT1SgB9DVRL3zLkgWQdMPl1FWkYhd0mFHqGYs2RZ6mATSKMAYXNU7kolbOdR3mYusSz3A+/xnLEH6YiTzIO8upx5G00ENXs8QHQRxDwyLi6WtdASXPFH/Bn4Gphj36d3mwMEKRKbaj+qnNpnCf5Zx024x/YFELIqIOFLGAkSU3TndqxCORx2qhyUxTfGFoqmprOorR7Wa8QLSt/8fSOnjFBrvOQIh2L7TgQEbmJeWamap/6NPPMOcZys70zhEXO/ErHIpxvgrBbUfmtowNLnqq0pLyIJzsA2vxJOrlwyC/JyHjLst3oTtKMGeQq83ZOfySWDffhyYRflKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(66476007)(31696002)(86362001)(8676002)(8936002)(31686004)(316002)(5660300002)(4326008)(54906003)(7416002)(110136005)(66946007)(66556008)(7406005)(41300700001)(478600001)(2906002)(36756003)(44832011)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnAyaEladEV5bWJEMnBhUnJ3NTlxQThwRDJ1c1pJS3loMElsUEl2S0RxZDc3?=
 =?utf-8?B?U3dtTVQ0L2FKOHdnMFZ4d29TZjFsN0hwRjVjT3Q2bXpzU1NGc0JPeTBSTGcx?=
 =?utf-8?B?NW5BTEtUbFVCNHBkRThHT0Y0WCtEd3VWMkdDTDBwNXJMVTNRUThtendOSXpq?=
 =?utf-8?B?cENoYm9uWTBxcStkdFd5YThiTU10bkNoK2JIYS95SWw3RDNlTFpwNzF2cHBF?=
 =?utf-8?B?bkpvajNRWHFtYS9BRENBYXQ1V1ZxdG1aYXNRaDZuaWV6T0ZiQzJxZ01MVmdX?=
 =?utf-8?B?Z2sycVkyVXVzQ0gvTFc1T2VRQTRPbDdmTnhaL05JMWVpeFU1bEZma2puWGg5?=
 =?utf-8?B?TkxiczIrSE5SVlF5aEhUT2R2K3NaNUlZckZBSmo5TE9QV0V6WGVUN3JpSGI1?=
 =?utf-8?B?QUJ5aEg5RnBuYUJUOXBwQWJBVFA0NXRkam9jRW5NQ0VYRDRnTGt6MmlWRWJ1?=
 =?utf-8?B?WXpjbmxENVM4b054MzdLYW82VGo3bEhOd0Q5WFkyaWVQZ3VkYjg1UXlnZktN?=
 =?utf-8?B?bXF6T3kxQTQ4eUFUdm55ZnhiRGE1NE5GbkJJdEwvcU5aQmRUVUtJTjZwZGt4?=
 =?utf-8?B?b1hsam1HNVdVcERPY3FpMDFRK0ptaVp2SVEyY2tqaWNaK3QzMW5tcGY5Z1Fk?=
 =?utf-8?B?czZIV3VaUWVQMWZnaTVEbWIyMDdlN2JYYVlxSmJkWFc4RzJoWmxocC9NMWdp?=
 =?utf-8?B?bE5ER3c3UmowRVhGMWVOczhkb2NpaTZudTFkbGxVb2pnWUJZR29vMCsvOERj?=
 =?utf-8?B?NFVDcEY3UHo2SXFCbUYxaHU2ZGxIcUZDemJLYVRVSE53NUthZ04xbUFNa0dx?=
 =?utf-8?B?WEdFZkszMzlhSGtjMmgzOGJuV1BSSVRYRFZuUmlHMEtrUC92M1ozelJPWVBK?=
 =?utf-8?B?UWRRNlZzcEN6M0k2MlVYRVhWQklBcERrSUE2UkZBaTYxN0RYMkRIaVZvaERu?=
 =?utf-8?B?L1pHOUdNaVhnR0Y4ZUhubEkxZlFsVmZIWTlIWjlFY1NUTDBoMXRFUjRnWWFp?=
 =?utf-8?B?QWJKSlU5V01ScDJFTE9aUmN6Z2JCY0RTSjRVRlFGdHRUUWM5OHVubTBhUnc5?=
 =?utf-8?B?MHdxY1BvSU1nQnVHQ0M5WWpaVXk1K0U2a1lqWGdraUxZT3h5NEQ0bDRrNExK?=
 =?utf-8?B?a3lXUWpTOVdhaFFGeEhMT2djK0g4dmxYMG1jaEk1eUtQbXlBNkZuckRCMk9o?=
 =?utf-8?B?a1E2Z0wxdGNEcUg5aTZmOEM4TUQvajZjaUtham9Ma0JiMFBhdTZ3T3NzenBZ?=
 =?utf-8?B?dE0vZ21MWnNENVdzYkVZTlZJM2Q2dFJ6V2ZtWmMvdUZUU0RuTkNiajVycEVX?=
 =?utf-8?B?VUdvczhWVklMeVl0KzNxNnFobHAxV2Z2alVBVHVpRVUvQi9SWXBaTkIzdFdX?=
 =?utf-8?B?dnBEbEVhckV6YnNQdno5b0NpTk1oSmhISVBVb1BKWVdsZk55R3I3cHY5OW9l?=
 =?utf-8?B?cjArN2JteEJaTm9ZRGJCZ1FTbjFqa1RYSktudllhN29NTDBRWGYyUHViZFJO?=
 =?utf-8?B?V1M5K3g3REJNVTBhTUg5ajdHWEM3cVE3V0h4Ungvcnh3U2RXMjNPYnpPSHZ5?=
 =?utf-8?B?VkdkWCtTdFljVElaZVN2M3hMUFkwR3o5T1o1V1lhWTA5eFpuWGhTa0l6bmNE?=
 =?utf-8?B?clRMZ3ozMVp3WUhtOTFJNFpnZ1NFdlF6UWtQMGswOHU1bG1wU2I4dS95VHRz?=
 =?utf-8?B?cUVLM1d3L01Vd0JBbU0wL1VEeS9TMHRreUwrV1IxSXNnaXlad2xoYzhLdVVK?=
 =?utf-8?B?V0tmQW1wQ1Zmekp6WGZudDZzWUJMV3hjMEVacWdGT2J2T0FUTE5PK0pnN2Jp?=
 =?utf-8?B?Q0F1YzgraFBUajYxZWs3SnV4dGRucVBUemZTbGMyUW9rSXRGdithNEo1MVRR?=
 =?utf-8?B?bG5ZWFowS0JhTUxMakpndmdxUlNvK1FQWVY4bnBDMHhmQy9DWmJwYjk3NEti?=
 =?utf-8?B?QUNqY2NqQkNFbGlqNi92RnN2NXJxOEF6cTlHSEw4QnNuZ3hyZnFHdk8wbnVr?=
 =?utf-8?B?QTRQa3JtamFDcjEwZ3Q0NEdvN002WmwrcXJrR1d2VHFHNGdtRHFyWVkzNHh1?=
 =?utf-8?B?VThJR2NUUWNNV01ONkw2emdDdkFOZ2M2WEhZa2ZuVUx0UEtMVXdGY1J3UWtx?=
 =?utf-8?Q?jEeATb3PbUZ/x8RUam5nBpoXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629cf0f7-16d1-4151-eb1a-08db929cb3f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:36:33.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUe37CbElsLj1W0rYZSaWx5idNcLCPMqEOapfKXaqTd/LQEqKk4md4qC6L6As/Synf7LodL9YhGQchx5dXTlcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

Hello everyone,

On 7/12/23 1:14 AM, Reshetova, Elena wrote:
>> On Tue, Jul 11, 2023 at 09:12:57AM -0500, Carlos Bilbao wrote:
>>> Kernel developers working on confidential computing for virtualized
>>> environments in x86 operate under a set of assumptions regarding the Linux
>>> kernel threat model that differs from the traditional view. Historically,
>>> the Linux threat model acknowledges attackers residing in userspace, as
>>> well as a limited set of external attackers that are able to interact with
>>> the kernel through networking or limited HW-specific exposed interfaces
>>> (e.g. USB, thunderbolt). The goal of this document is to explain additional
>>> attack vectors that arise in the virtualized confidential computing space
>>> and discuss the proposed protection mechanisms for the Linux kernel.
>>
>> When you have a "and" in a changelog text, that's a huge hint that it
>> needs to be split up into multiple patches.
>>
>> And that's the case here, you want to do two things, describe your crazy
>> model of different attack vectors AND propose new ways to protect from
>> them.
> 
> Actually if you read the full doc we are not proposing *yet* any *concrete* new
> mechanisms of protecting against these attack vectors that would require
> kernel patches. These are indeed going to come later with the code changes
> as you highlight below. What we *do* discuss below is high-level mitigation
> strategies that wont make sense to include in the actual patches, because
> some of these mitigations wont need *any* new patches to linux. For example,
> the first attack we have is " Guest malicious configuration", where the
> misbehaving host modifies one of the guest's configuration (kernel binary, 
> command line, etc). The general mitigation for this attack vector is a way 
> to authenticate/attest this configuration and it is mostly transparent for the
> kernel. So, we either need to drop this attack description fully form the doc
> (and this would result in questions from people not familiar with CoCo: why
> do you try to harden the kernel apis when you don’t describe how kernel
> binary integrity is protected), or we leave it in for an overall picture to provide
> context and justify the overall reasoning. 
> 
> That said we can rewrite the sentence that you commented upon not to create
> confusion (I do agree it can be misinterpreted the way you pointed out):
> 
> "The goal of this document is to explain additional
> attack vectors that arise in the virtualized confidential computing space,
> as well as highlight the overall mitigation strategies that can used
> to address them.
> The concrete mechanisms, if determined needed for Linux,
> will be described in the future extensions of this document, together with the
> code that implements them".
> 
> Does this address your concern? 

I'm writing to re-ping the email thread and kindly request any additional
comments or feedback from the list.

The issue that Greg raises is whether we should discuss and cover
high-level mitigation strategies _before_ we start pushing code.

In addition to Elena's response, I would like to point out that a
document that explains our agreements on the high-level mitigation
strategies would serve as reference when the time comes to discuss concrete
code mitigation strategies. Saidd foundation would avoid explanations and
repetitive discussions whenever the code arrives. More importantly, it
would relieve the individual confidential computing contributors from the
burden of discussing the rationale behind their solution all the way down
to the very basic ideas of confidential computing within our context.

Greg, I would like to know if Elena's reasoning has addressed your concerns.
If you still have concerns/doubts with this approach, please do let
us know.

> 
> Best Regards,
> Elena


Thanks,
Carlos
