Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FE811A58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjLMREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:04:03 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AAD0;
        Wed, 13 Dec 2023 09:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS2EOKN8WikPT+bGY27GFQxYJC7LvVFJWZ/pYQk31fGRJSJFHfBKRGICeHNi6QHZZgKjWaHTXQGxuk0OEMAvZRpWHJFZFaWH01RrGF07LJajsOoSyw23ExsBNUAn+h0gTGsuF/Fl89/R91qVFG8/hzh5d4DAH3JpJ0Qjbr0p//iKi9xIaWUAyfREB0xaa0exE3xDvYWX8iE2lKepndu5ItRTukR4uYwyP0fr9NUit8/mQWChphfdCcYnEayoS7wJa9JnFvGbl9M/9w7GAxiFao6n7yK0b/v5lK1hpwM/OB2YJnNptbvYklHwzUQ5mKp3iwYk63ltsDicebexWA9lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ua9LuNPD9k9r8qzyMwyeXu48+JAi0TQRzOtwevYCQk=;
 b=Db5pNKR4sWc1Q+YwcyOU2jJJ+yWb5ZBU80BHQdjxr6vMBGfdNEF0aYJBZRS32xO2G9U3xU2sw2ICQMTVszdCilxAf6kQQVbLn6ifBsgtY2Ftt28MfWGXX3kbIh9duoHVW1KufSUMT+MV2RMDk9clCSml6AYL1pwVNcAf1aMLkGJ8cX7h4jLxh3RJRBZHoyzednJaBXCjNniKBWnqnqvJHezWim9HTtk8g4Nx/wxMsqzV9fMX0qNca54m7KR3QMC9S3PR3qs8N0RHuwmHyK3QvDXhMvxxt7xjD7K99L+qEm1TwAKetZ6rkq9+oW3PvkA9NQPIgoVDBYtXBO5aG4Fzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ua9LuNPD9k9r8qzyMwyeXu48+JAi0TQRzOtwevYCQk=;
 b=AcE6u0+ayqs5d4lWy4D3nyUXeTH/nwcfwEjjJVvdOGlEVzjhrE3DG0YLY7Xi5KfFeBb8ZNYXC5NLxwTm0a9NUSBxwUHW0aN4bnRhg+GeiX+0G+65j2loTlj2CC27Hhnj1jTp9iM42NBGUrScrjrQKyq+NpKKjE3wdEiTTogR5Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:04:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 17:04:07 +0000
Message-ID: <58d1f6a6-458d-44d1-8bcb-adb90aab50a5@amd.com>
Date:   Wed, 13 Dec 2023 12:04:04 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
 <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
 <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
 <b9beb435-30e4-44a3-b27d-0567a8e873bd@amd.com>
 <20231213164837.GHZXngZW3TYvBN41Ma@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231213164837.GHZXngZW3TYvBN41Ma@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 77826518-ce2b-4e6a-f621-08dbfbfd845b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIIPjJWai1XSbV3XrX879iUn8f69EQ2lHGXg+qgxIdq3t9E5xH7LVzBIJ2lZNPBe0JYHQ1h9W9iqDtydPHA4VBbVMz3cWJi7wWzcMpQlHG3WKWZZ+GnOg+vXn/h6cqmZduVGytkMQ+sruX2F3peDudBNl6dBd6dhwD7nsypnpTZupmyAs0YmXzzfA8Sv+v1rDHILBtsjFE/5p2uH8JMfH4jRtdJbRwRoPkwrHfzSmxPKaLWeUnOk1rO2AhIov2xrZb5AIQ0M9bvvf1Pb3VSO1VrMqf1TvoaH1e5DAYC9ty1MDvXYSY7rf0Iovex8Q8CRF9m26yRZxADdrdiKD/kQAFFY5cDfnJWOJyR6FHUuX08jcDZXI8DWxSh+m1TB+YwkdncRrFHHOdSnhyCk+XJjciCXCgaAezhEQyaSHH7ADMkgka4tBiO2BccLFZJ3iErtxBcyyk5Wj/5FpxP1d+vqL18ZaunSoKX6V4wNbEqPdiWIH+NW75+KukqNkBtSm5sV8W/hH6aJF+P2XZAPB7ngtXC1oQwKS1WHDmPDUWg3KZCZ41J/xIE7SalMjCXjjyEHzFjTq+4DlaiIZovgG3jTN2NZJk8odmgHW3R7L7beGYg+eOuLATqxEefxr3N4wR63Mev5DCwfJZocNaOL9uCJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(26005)(38100700002)(2616005)(44832011)(8936002)(316002)(6916009)(8676002)(2906002)(4326008)(5660300002)(66556008)(478600001)(53546011)(6666004)(6506007)(66476007)(66946007)(6512007)(6486002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RDYzREUy9ySXRUcU9uTlBxSUpwMHFnSVZJd2ZtcWZOR0Z1dko5QnZJZktk?=
 =?utf-8?B?WXVGV1B6bk5sUnZYSVpHLzFyUFpvZmlFcEhkZmJVdGRBVFlGdjY1OUhNN3lV?=
 =?utf-8?B?ekMreFEvakJXUWgyM2lZYWorN2JLSm9NQ3duUDNPZndKSFU3amppcUJDQnhL?=
 =?utf-8?B?UFlOODF2Y1JWU0gra3o3bXorVm0yWmN6eFZkVFd6UXpQV2JoSDJnRlRESjhu?=
 =?utf-8?B?UjlsVWsxdEdhdHUrWW9kMkJBdFpkQVZaVlFiOUhaOHMwRDIvUjNxT1ZHUkNW?=
 =?utf-8?B?M0o5SFNrdWV4eW1mMnA3bUVvUksxdU9IL2RuK2dIK2xjOWZGaVNPeFVVOWdU?=
 =?utf-8?B?czE3enZsdmR6K3NBamIrV2ZibHVkNFRTNW4yMlduZTZhcHRReS9STUNlMVlG?=
 =?utf-8?B?WnpGZkRFd2NrQ05heW5pTHQ4bExkQWx6WUsxSlJycVVLcTY0YSt0OGpaOUMx?=
 =?utf-8?B?YkVjbS81OHRDYU8zZVA1dEtDQUdoNDhPSFlES2xRaWN4cHgvdEVYVTVHclBq?=
 =?utf-8?B?QWJtN2JrTU1OYTBmbTVQYzBKa1NNdjlmN1YyQnREVVlWZDJqcUZuK1ZIcjdH?=
 =?utf-8?B?SG9yTjJjM3UwdlJ6YURDc2NCUEhXKzE1b3gwRGpQZjZxOC8yZllvcGlyNEJO?=
 =?utf-8?B?MnlqaktEUndlWHRSa1EyWlZSMm1KODkvWi9PM3hMei9Idk1WZnR2dy9GSDNO?=
 =?utf-8?B?ZSszNDR6eGl2WnJjWnAxZjZsWEQvMzNramhVTWF6OWN3ZUZWSXNrQXg4ak5F?=
 =?utf-8?B?MlBkY2dVTWx5RU4xTmkyZzc1SXBKZ2NnNVVrQ0JMWm1GZGNJMUJXN3JyYWFq?=
 =?utf-8?B?NGttMW15VDk2VitVOFlkR1o1VWY2VUFYTW5IeFl2NEVDanBjbTNuUVhOZVFp?=
 =?utf-8?B?WWdmbzZub0tLNmxMVFJCY1V6RGVBNGtDK1VZV3FJMTlZZCt3UEpUMjUxNkFi?=
 =?utf-8?B?N2JIQ3pIRk9yS1hQbkNZdHFyL1lIWXVGVmxpdWozb2J0NkE2cDFxSTdvcmR4?=
 =?utf-8?B?WDk0NFhNT2FiVDVHTFd3SnRsQnI5V1JscW0xNXMvZGVGQXVyKyttdTFNdHBZ?=
 =?utf-8?B?L1IzdlJ6YkxJOERBVWFCblVFZEJXZDJpakh2RS9UVFNwSEU2cXdjNWpwbGtF?=
 =?utf-8?B?OE4zL0I0NUZqTVBqemJhNnlRb2ZrakpSaU1EZHlBUFA4Z0FXT1RrRUpPK2Jr?=
 =?utf-8?B?OTVqNi9HTklqSmxDeEc3SXg0Vm9Wb3dUSG1jWS9SaittY0owdlpGT3hwOFQw?=
 =?utf-8?B?eDFraWhuNitadDFFT3JZT2V1SlFYZy84M00vUHFNcjdSMWw5dFcrb0s3QXgv?=
 =?utf-8?B?UEZWUktPUUUzdEE4UzRGV2E5eWVUMTFVZEtLNS9PTURvNnVUMU53MURhNGcr?=
 =?utf-8?B?TUxoc2lWSVdWSGFGSllWUUtDS1hCTGFYYSthZzIyQlBPK2s0WENQZU52QXJt?=
 =?utf-8?B?NEdtUFluMU5UVk9kVW1VbFpYc3RML1g5anRFZXUzcFY0c2pzbkhVb2xwWmdy?=
 =?utf-8?B?NG1CN0V5eDBhU3czUjNGOW1aa3BXV0JLZ29JQzYzQmZ4RlI0SnRNZWJBVU9F?=
 =?utf-8?B?WHpYZXlaeEg3ODhha1ZMc0RzYWhtYlAzQll1bVp2QWdxUDFEOHBBRXppTEpH?=
 =?utf-8?B?UWJQcVNLc1RPT1l1Z3pjWUljdk1hOWx4anlkYmZjcmZJWTBLcGpLU1VHU2NE?=
 =?utf-8?B?ZTN5RHhtQ1l3MEI0dnk0c0l4c2NUTnJPZ0JUd0IzTnBFTWM1ZzVhdUQ3cXpY?=
 =?utf-8?B?RkFtYWg0MjUzRzk1SEhBNFhRanJsUHdrK1owU0JGUHFEUUpvdERHcXU4QTJt?=
 =?utf-8?B?eUFvOTNSWnYwZHZ5NEdqd3orUnJBRW93OU1mcHBGQUkxNWxROFZyS0ZlU2hs?=
 =?utf-8?B?a05nT3hrRVBsS0VWSUgzSXVzd3hvSG5ZZzhXUysrTXRuTWNWbUNBdVh4VU0v?=
 =?utf-8?B?bXFycXZaN0FhdGQvTzk0UExPR04rR250L0M1NG9sLzhpajEyNVBRVEhsbWRw?=
 =?utf-8?B?bDZrQTY4QlRTdkJmRllJTW5KckJhWUFRTEtWNkRzQnhBL1IyQVdZUnFYRkFT?=
 =?utf-8?B?NGlQWlhUVWN1a0ZJbW5MREVwdTlLdyt5bkRxTmtOVVdHanF0VldGYitjME91?=
 =?utf-8?Q?LfBAHyIkm8cEeXhXPGq9rdrHz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77826518-ce2b-4e6a-f621-08dbfbfd845b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:04:07.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR+5sMFow+UDKhVOaMGYNp01DpvDVs8PPry5iJa7yKiCqyuogusnQ3pyfNs7y3RhW6rUjmL+Ciip5w5FrJGs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2023 11:48 AM, Borislav Petkov wrote:
> On Wed, Dec 13, 2023 at 10:35:55AM -0500, Yazen Ghannam wrote:
>> I agree in principle. But I don't think it hurts to include an additional
>> line to avoid the confusion when the module doesn't load.
> 
> It does hurt because this turns into constant family updating the moment
> a new family appears. This is one of the major reasons why we do CPUID
> bits.
> 
>> Also, the SMCA feature is used here as a short-cut to match on systems with
>> a Data Fabric. We could use the Zen feature in the same way.
> 
> We could.
> 
> What is the main description of the environment an ATL library belongs
> into: a SMCA system or a Zen-based system?
> 

Systems with an AMD Data Fabric.

I wrote up this comment for the amd_atl_cpuids[].

/*
This library provides functionality for AMD-based systems with a Data 
Fabric. The set of systems with a Data Fabric is equivalent to the set 
of Zen-based systems and the set of systems with the Scalable MCA 
feature at this time. However, these are technically independent things.

It's possible to match on the PCI IDs of the Data Fabric devices, but 
this will be an ever-expanding list. Instead match on the SMCA and Zen 
features to cover all relevant systems.
  */

We could also introduce another software feature bit for Data Fabrics 
"DF". And this could be set when we discover them, like in the AMD_NB code.

Thoughts?

The library init has three checks for system support. Comments added here.

	// Load on systems with Data Fabrics (ZEN || SMCA).
	// Filters out legacy systems.
         if (!x86_match_cpu(amd_atl_cpuids))
                 return -ENODEV;

	// Make sure the kernel recognizes this system's Data Fabric.
	// Filters out new hardware.
         if (!amd_nb_num())
                 return -ENODEV;

...

	// Make sure the library supports this Data Fabric revision.
	// Filters out totally new logic that requires library updates.
         if (get_df_system_info())
                 return -ENODEV;

Thanks,
Yazen
