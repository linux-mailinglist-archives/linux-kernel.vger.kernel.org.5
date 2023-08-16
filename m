Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC177E4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjHPPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbjHPPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:21:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EEF7;
        Wed, 16 Aug 2023 08:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQQec8PjMsPJ3c0PA1uUYf1BTd1v6iU1GKCCyb8uQEgQ4ns+Wm1JTjyAnx6PnpVlanCXnQpPBlcRWY9186OYTx9/LpIAxXkljWoWwWdjQDqno9oMGiD0lrMZVkNte/ryOZDt8clqM1o2MLN4GfVkTWqFjXr42QtLyGtPoKE4zpN9G4IppI0pCMd+pDO1h6dKGC9dIBCF7HEhcROaixa0zqrGO4QL/oy+CtvC40ehxVZDSG2q0Eb1b1FqN4DmgYkM859QYjfDP53jqfpqWC2ZC/PqnqK+Aq1mM5NEEGVctp4izLOxNxQOvm90kb3HLWre+KA0c+952msaNPQtn8bIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGp1xg9dIqaMQGED4AiSH92I7MaN36ncHG5qhvb2KRc=;
 b=f/wae73Nzox9pwPl+Ia23fwS33181+PPQKXuB66W6oisZQ/opjNA17rGD9nAPw+f2KQBi5QPDqbfQR4p7A91MFTqjFNh+AcBAutGqbHcGio5ocnBaIb82oHbwfH99eQ4W2qUtESH9BPCeVa9D71ReN/szTRjBr7G8avn03gnlPXoInwkM2KLpZnoDsLv9x0yF01CwrzhgQU31n4QS4QQmvSg7J9OC3r6WirEJIibHAGa857JzURSzOARrgfZyAnZvoBsXWyhdoeMfDPi1aIU2DjSrz2GOag/TKrc9zhl8/S/YfQ4oM1XjDPOmfjjBkIU40Sa0IPwxZdw7RVgu3eoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGp1xg9dIqaMQGED4AiSH92I7MaN36ncHG5qhvb2KRc=;
 b=iUDZXBvP6feFnOxfSPmeCRKgFyd6ZVCjcGPFk7KxA8888QVOD7BvWNR57y7rXqR3bbgOipt1kWdCSN+vMqxuJLl+VMKv2AwBV8VYh4fgNr3peJpASMPMuxzYnbUuWvgAopK1waU0d17eBIjb1DgaF7nMB4RneZAfUN4eW0mA5rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 15:21:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 15:21:09 +0000
Message-ID: <16011802-fb29-da56-a1b9-8cc1182dd449@amd.com>
Date:   Wed, 16 Aug 2023 10:21:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org> <87bkf79row.fsf@intel.com>
 <f7d0e554-b6ac-49ee-4caf-640967bc1053@amd.com>
 <ZNzoEVYE1dTOnni4@casper.infradead.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZNzoEVYE1dTOnni4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdbbb29-215b-41f6-e923-08db9e6c6b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcIsoPpiIb9cA+8AAmkElxOX0XKn/qP3cpUAge+VPix3ObdPBuWnFISPsdMS3HrVJE7suvJBYg8kFcaZCHbOIQ0UffhxhrsbEcDP39K8FjnSYCZJkh2A74diaHPV3faBlX4qNwmbl3IZ2RZt56aXWIrqfQVA96pv45ZOB6DroMihG+cVUa8PAn9iD57qT5xWzA22JKzpTALzYuq1JRyGLDfxGWMx/5G4Z1GbezksNJX4mj3SLShz0EHygkE+qhVT8+x0t/qNEQhmdO4+Ty0mpB9sKIMREN80PGKnCgM3RfERDuoLw0sRxVQfmZpCv53QKQnhzXOztP/AjwPxTBmNSs8Zq1olK+eGqV3F4K3Ek8I3l/1nsxg3iTksyZiPQIpu5UPe+vugycV1zbVXoz6tNDiGlrAavcIhzzV+l3skzGCFaylZ85kQ82/moK3kXSa/Yawgq1IY7mMLs6XGsJMn/86icOTKS/WC1yVbKfvos1AR3pL+NmZIDOi/+bwYI6q/xaSt+mqtHX+PsWQ6s+fzK2FEtYx+YFgxGDvsEdH4mg06p0PuF9hg6/QjSNL//23wz0rAqxzE22JrD2oXxSwVC5Zc9O9vbzblQDU3WUQH5C3M8K6rTQBzRsThhs6ISllSoN53moO0+n3tzZyfIuwhSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZDb3dQYktFNzd4aiszeTR4SVVRRmRlcERRL3l2K3p2WVM5ejVoVnVLa1Bt?=
 =?utf-8?B?dEUvWXhMUmdubjgvZmNYNS8yUHBjdmxCbmdoQXl0MXh2OU9mWjdNR0N6b0x2?=
 =?utf-8?B?YTJGK3BsbHJtcHpJSkFETnRkTVBqdkExN1dCbUwxS1lxRGRBeEVUS2VJZ3Rw?=
 =?utf-8?B?UGtkOFljNTdSd2pxcmFHcXJKMHZtV3Yyem5DZkJiMURjcGYyMEEyU2ltSFRP?=
 =?utf-8?B?aEVuaDBMTGk5OGRsMFNmalpjSXVNZ1BZZmFPZUs1a0lGQXhhZVJmaTJpdTl1?=
 =?utf-8?B?c1N5QzdSNDhHcStsMEkrb250dVRuVk9ma0U0QWVlMkpFYWNqRFRpNURkWC9j?=
 =?utf-8?B?NVpidm9RTHlDdG4rYlZUT1lHTkt6WEdyUW1GVUFnNTBaWmFKUlMzYnhzVEFm?=
 =?utf-8?B?dmtTY01PVDFtUElvWUNCMi9uaEFDVzVja1EvaHVQT1ZhcVBmSFFuc0JkWTQv?=
 =?utf-8?B?UHNZTTdWZUxTb2tiL1ZLSUg4ZzNRYnFtWGhhNTJFRGJGem1ma2MzN3ZIQzJS?=
 =?utf-8?B?SlV4anZCOTN6OHhNM3NwdUVSZS84aXk5UU80Nk1ObFdTSmd1SU5hRnhJMCsw?=
 =?utf-8?B?Vk1xM2Zqb3VXeVhHQlFjUmJ0bkppdVJKa2dNRWJxLzNMMWxTOE43aFkyeGg4?=
 =?utf-8?B?R3dhU1FaZGUyNWVKTU5TS05LQUQ0bmV3b2RDQUxVWFdVT1RNdmhpQ0M1ajdY?=
 =?utf-8?B?V3RVUGNWZmEyZ0hRUjNKUUk1dXpLOHpuY2RSR2QwdU1IMlQ1UUpvMzl1NDc4?=
 =?utf-8?B?RTJzWDlab1QwUkRMeTY2RHV1K3RRN0Z5MFFFNkVKM0JEVVJpNS9oNW54aHEw?=
 =?utf-8?B?MEdDR0ZTYlowcG9YOUhRbGdVbWFLajNRcWpLY1BNVjhaNWVqTjZZZGV0cUwz?=
 =?utf-8?B?R0IvZEFhNGxrUG9ySU5TNFp5dGlja1g5d3I5V2VBOTVKWnlHSUdxUXBPWVQw?=
 =?utf-8?B?S2VtWkdEd3NsY0hZdEtKRFhZV2t0TEhwanZJbEN5czk2bTJTd3NzdFdQZ29M?=
 =?utf-8?B?SzU0K3lyWDljZHU5ZUt4bVhNWC9GcTBQWURlYmJRTjdGdWVOQ0VwbTU4Wkxn?=
 =?utf-8?B?RTRQUzRLdTA2L3orRkloaExLY0FsNzVrKzl3QUsrY2VoR01iZUd6TGlCUmdk?=
 =?utf-8?B?Z3QxRE5EUkt0K0xONnMrd0ZaN3RxZUIwTmlRMC9MdFFvT2hUUXVvVm1yaXkr?=
 =?utf-8?B?VHo4aURtM0ZlTVZiSUptS3NNcWNCazJUNlpVZHh5dkhaV3ZuSjJTL1ppMW1D?=
 =?utf-8?B?a2hQWmNiNmhadC8rMmpxSEdtWkdxR0RrcllKeFNtNWliTnBMeWlLQm15SkxP?=
 =?utf-8?B?SE1LbXpQNjdBc3djUDdZOW1DdkE5MVVNRXBoMzVEOXMyRDhoMnFsdUFiQnJH?=
 =?utf-8?B?U1QwcnFCcm1RdS8yc28yYnFkZDNuRFVJaEoxTVJZWWhPUEQ1aDdUbW9iNHkw?=
 =?utf-8?B?djNvaVhJRlB0UzFNK1VzR0hjbVNWVkFyT21NMnRhM25hUU9wUXRyYjhhZThq?=
 =?utf-8?B?NkpyeXZTY2k1K25RWVEwOGJjaFZaZGxTMHhFd0RsQkRFWkhOd2pLaWU2emlj?=
 =?utf-8?B?K2hGYlZoSk1rWkdaTWt6NG5mMGFDczlCRUQ2NDJ6elhvNDMyU20ydDZSeVpQ?=
 =?utf-8?B?MVExLzJqdUJ5cmhNTUJWOHcyM05CUjlLSGRzT1I1QTYybDNDVGdEYURGMG83?=
 =?utf-8?B?M0MyY08rTCtiNlVBemtQVWJPV2FxcURPQ25sU0tZdzZhcG9nM2pNRE5uUlhX?=
 =?utf-8?B?dHVKeVFqV0RQb0hnMTVBVlFUczB3WUtQcWNMem9LVllKOVVGY0FGa2EzaXBo?=
 =?utf-8?B?YUVIR1J1RjNab0ZwRnN4OU1GaEZ4aldPbmxDZHpUTG1ua1lvMWF3RzJzSDFu?=
 =?utf-8?B?OTQ5YlZHYjBmb3A2TlJER3VBNFVVM1I2cXMwSngzeTZJWDR2bzEweU5qYVJr?=
 =?utf-8?B?cDJSQld0eEcrSG52eTBIclQvMlRvRXZ2RnhUdUVURlB2S1JYU2tHR0hXbjM5?=
 =?utf-8?B?TkRRUEZMY0hwaDBnanFpaDlNYjlEOEZHTkoxSDR3R3JTWC81aDdKVWE2TjhJ?=
 =?utf-8?B?MEpWc1VWZEZwMElFdzU4eElzbG04SVgvZVR4TU5YcGtaZ1RSWXl3QXd5U2Nl?=
 =?utf-8?Q?BW9PDGoaMy46BIgbCP/M1yaaI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdbbb29-215b-41f6-e923-08db9e6c6b06
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:21:09.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX7x2sqWaIRBEshDoyRHm2BkZDPbEItFMpAJ7Vkab6L1ouw5hunPqXnjXa1pdj3G2PzE8Zki5PhnSRljl7sNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 10:15, Matthew Wilcox wrote:
> On Wed, Aug 16, 2023 at 10:12:56AM -0500, Carlos Bilbao wrote:
>> On 8/16/23 06:01, Jani Nikula wrote:
>>> What I'd hope for is build system support to enable W=1
>>> compiler/kernel-doc warnings for a subdir with a few lines at most,
>>> instead of duplicating and copy-pasting tens of lines from
>>> scripts/Makefile.extrawarn like we have to do now.
>>
>> That sounds feasible but, well, I actually proposed the opposite approach.
>> I wanted to "relax" the warnings (see RFC Subject) rather than making them
>> more strict by default.
>>
>> My concern is that W=1 (by default) may theoretically result in a clean
>> `make htmldocs` but it won't in practice. Not all developers prioritize
>> good documentation like the folks from i915, and that may lead to
>> unaddressed warnings or worst, less interest in documenting the code. Isn't
>> it the case that some of these higher-control warnings don't really have
>> much effect in real life? And shoukd W=1 become the default, are we going
>> to be able to enforce that level of control?
> 
> I wasn't proposing making W=1 builds the default; I was proposing
> running kernel-doc -none at all levels.

More strict warning level, right? My concern is the same.

Thanks,
Carlos
