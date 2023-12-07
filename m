Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0C8096A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjLGXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:37:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F321712;
        Thu,  7 Dec 2023 15:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4pVDN3SLzLxTzlhqGcffkCOfeZ+Wr38OJdi4iLNhW2omAd0Ij04v6vLod69sv9+BOHp0A/ZMYBUnmCsnWVmMj1G450170TX90umz5f8tPrkCULvpq8l1BC67Z59vCrO68vZhlDKnItgZSgHzibKaqDV/wpPlNLUT36A2XjsTTXG7qhj+U65KYbI0NMA9IpWGs1EtzFj8AE11G8VTHZ0ZCisv1kX60cQmVvVdY6y5MxthEnNZitnCn6iupa1dsxJoVjRuqiNU4k72+a9Kf7HfgD7TuGU9mnH7ZIGjVZNMmc7AMyjMUrsliwfNUiwTbfIY3FUfRUEHIr/3RY046v1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFA0dlLS2yusAOGS328n7AMqcPhsHdS8nG1p0K9CjEA=;
 b=gT2p+oGaWaQxooH4Fdd2PrtFvvRicDVt7BM7yXhN+LyIU1w2uwcsaQ7fY+v8zFRoYbx8zF5wBphBjFK4Qy5z0PhWYRTm6JOB28Nw+0SpIJTGysq3iIRtefQtkbx4JVLbUyyiFepFR7YYGOII8PLObwRYk22zUpwgIsuribh5QEaRDAqNMjLiWAmw2NArd3UgJ2ND9ZWsGf65AQSrDLdmvKdnEiHbKfPimuSqOP0wwa4uQTgOSKMxuYVRy5LjKAcQzQTvQi9F0t7ben0X+DCkqK3WYmCxIyGOuoDpWR3eNv16YCY5O9baW8SNLpOu+hW+2+6zV5brC3bxodLcVxLYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFA0dlLS2yusAOGS328n7AMqcPhsHdS8nG1p0K9CjEA=;
 b=og1txhYBVc4SJhhwtaGbQeKgVRPXLBFjz03VA5hRZHy8yb48RaJME6YjkRACG60Ax/QjXOLj9yuau5eC/FlpEdXgOWvk7iAqVrgRp9qbKaFgjXazhOJP0WPzPx/FCaAsNPR0zgMhz0iEv0T53HFQW/0YoQYaXqkGnrKBjGJKAFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:37:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 23:37:49 +0000
Message-ID: <20f60b82-b2de-0ddb-661c-1ec48cbb44b4@amd.com>
Date:   Thu, 7 Dec 2023 17:37:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "jithu.joseph@intel.com" <jithu.joseph@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "Dadhania, Nikunj" <nikunj.dadhania@amd.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "maciej.wieczor-retman@intel.com" <maciej.wieczor-retman@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eranian@google.com" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Giani, Dhaval" <Dhaval.Giani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
 <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
 <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
 <19e3fd3d-a2ec-4c8e-aa47-44f8f41b569b@intel.com>
 <ca471e43-b7ef-40f6-b0b3-3c79aa3a0d61@amd.com>
 <26385423-6288-4f6c-b238-30c599250cdd@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <26385423-6288-4f6c-b238-30c599250cdd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: f12e49c5-5ca5-4ba2-1672-08dbf77d855a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUkUrRpfCsUwAEu946ycLPYnM00liPqnB3cE64SE/pvpDVSPbFnydIRjMwKb1CiBo6RsHO+MW/4AwA6wxl+1QU7SPLj+Wj4axUX9iYU5VjobxRTidh0qRAlrPq11Oll0Y+kqGaBNhRJjb82gFl1uSU+2abmhvWFGe5lFZj6MUBZSbGrdd/AoD7C51kWmBu7SeK5ZRLBD0BR3EHfePCZ36h1clj/vLUZj6aTgiYXp5HS1OsFdDWACwd1mJPwcyivFIhox8Qmxk3pniJ3SMmzHlCetIB8SN6Hk/yWd1X+cTYtPn5RSGSSVx2LAXIdoLwPLSFTTPkQ9f0nxYZQ+1zZyGahY9UcyNvKAIk5dKkXwK3rG695FaA5hO978eVo8kvRFv5wsD/AUDuVjJzhS12p19XJICkoX6K5AIrquv8sNULpwmjVLbFLFmckHerp0g9S9t6s5TZfRTm6c5mix692x9wUQssLQHmroFpD++bK0rVmDhzE30isNJriVQjfnjcuIYXnp+IaxRiwSegD6FGkr3FI9SWMA4JrdLnbQ06Ir9tNWoXtOnrXrfKKhj90LwqnzP4EIALXuFcwvCHRJz5EHXkRdHKF3DLy3PEzY9ZFq20AW85kYvhP0Vn6Yyz9dNzxcj17qFaKF/zijFwbzkODEmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(53546011)(6512007)(83380400001)(6486002)(41300700001)(31696002)(4326008)(36756003)(8936002)(2906002)(5660300002)(7416002)(8676002)(110136005)(316002)(66556008)(54906003)(66476007)(66946007)(6506007)(6666004)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enA3c2VQZkF5VEx3YUo1T3VuWE42dFVKbWpPRHFEOHZVR0plSXpTVWc5NGNI?=
 =?utf-8?B?M0Zhdll6ZTNESnNWQzdDUnA0am83bHJsbWJKSkliRVU2cDJURnJzcWZPN09M?=
 =?utf-8?B?WVJkdGhZTlkvdXIwVGhIaUczelUyeTBEY0JoMDJWOFVwNGh6aDBia1VYRnBI?=
 =?utf-8?B?UERwc0YyMXB1MnA4NG83MFU5VU9PS3dNejRrbVFicDdhK0ZvcHNjRVQ4bHZw?=
 =?utf-8?B?bUNnZUp1OVNTalhGVCtHNHh1aEJHWFZMOHlRL2RuZmZSTWVmd2p2NEF4NE5p?=
 =?utf-8?B?U1QxQWF1OUszM3FmOWl4YnY4YWJtYVBUWUtKZ2R6MmZBdlpNL1ZGclZCL1BK?=
 =?utf-8?B?dkQ0MTlkTkd6T2RWNnJyZ0xxZmdnTktPWURMTmhCN0xjNk1TQjZwVnZXTjhD?=
 =?utf-8?B?VUZZRUlmMSs4Tkg2c1VDMU5vUUlQZjVrZVdQSWNPTVNMbnkxalI4OTdxOFBI?=
 =?utf-8?B?d1hubVNvOEZiVXFnYW11SCtGdTFpWlVxVzVDVnpPbTBXWmVKaXZObE1PZmNP?=
 =?utf-8?B?c3F4NTIvWVJhaEtTdE5ENnZOcEdBRFN2TVVkdDI0b2FPSkEzTzZTa0xYMkNy?=
 =?utf-8?B?WU9vQ2htYkpSNUlhZzYzNXBGNzRwcEwxNUI1dEkwL0paS0xwaklFeFM3eGtl?=
 =?utf-8?B?SzMxQ3dOQWRlMk93Tm43OGJxVzJLZXVYdW02VzNuTGh1NWFJRkw4V1llZmxD?=
 =?utf-8?B?MlZJVzV3aFFOamtReHFUSGRxa2dzQWxiTEszdUdjOHgwRnBEQ3Z2cHdCT2FF?=
 =?utf-8?B?ODFkRlI5Q3BpYVNPN2lpUDJaek5DUkRUbXdIT1JtYU9aRUZLd21ETko0NUwx?=
 =?utf-8?B?K0wrZkpMWmhEVDhzdzhMdDRHU2UydnFyWGQzdWk1R0dhMWZiVmtuSFJ4OTJm?=
 =?utf-8?B?QWpSdk9GR1ZwaE5raW8vOHdiS0RkMTBrQm93Z3ZHYWNIU29qR1I0QWFKZFlQ?=
 =?utf-8?B?VHRwNWY2V0VKWXFMT2Fvc2VYbXQ3cUZwS202VGQvalkrb3BGWTMvV2VWNjNE?=
 =?utf-8?B?SmFRM2ltSmZ0eGxJRElUeUNjTTZZYVpNU2xXWDV6Q3dzcElaN0xLYmx2K2kw?=
 =?utf-8?B?TFhWU0Yvb3F1VDNBUjRUZ2Z4S2cwK2IxTytMYlB3TklxT3dsYTRHbDBZamQ0?=
 =?utf-8?B?V2NsNHNDdVRtckg5RmNyQXNZZTVjREwzbHllL3lGM0ZBczZEUzdHTGV2NnJX?=
 =?utf-8?B?ZGRQUWh6NmxsTzczZmk0YVpGRjlNc29JeXAzeUoyTFZDWHhoYktGQWNBWUpH?=
 =?utf-8?B?NUN2TTRtOFBjd25zUUQ1dzI4ZTFaaWI1bUg2N0RWS1dhSE5yTVFQY3djN3lH?=
 =?utf-8?B?U013c2JySkVrVjRtQXUzNVFrRUZhRG0wOGljN2hPd3R1ejhkTzlFZFZ1MG41?=
 =?utf-8?B?bmh3a0EyVlhSbUF2WHI5RTNqd0tQdlRmVnNCYURXSkwvME0yUjZabmNHcXAy?=
 =?utf-8?B?V25WL1pRL0NlazdtRlI4KytHRCtzMnlqRmNQRUpFTGowRmxqbFFIWUpoaGxk?=
 =?utf-8?B?eVFWaldOQ2l2OTZiSy85MGdjY2s3VklzV0M1SDJRekJtdmJQLzMzNFNhME4z?=
 =?utf-8?B?ZGtlbjU3dlBCRWd6RTFXUitUL0Q4YUtvUk9CelZ5d3g3anVnZ1BDdUxhM3Nr?=
 =?utf-8?B?YXBmN3hmVFhtT1IyendRK1hCWExKNGhhdWh5dnFKTHQ2Y3d6dk0wdDRRbENX?=
 =?utf-8?B?T1dZR0czZHBMdkMvTHNROGRBV3BhcU1FaDZ3WkhZcml3Vi9Fd21Ob0oxK1h3?=
 =?utf-8?B?aHRlVnplcmVJaWZNNUNWK2Q5cW5qajhWaGlwMHVNZDRuYllkMXU5eUNab2sy?=
 =?utf-8?B?STA3c3JRc0FXUmM3bC9TZnRyenBsQVlOaGRRbFhlOXQyUkVSb01pZnFhYkY2?=
 =?utf-8?B?QVhSaFpvSWVobXVkOU05V0U0UDNlSXJxYkwySXhlQmh4TjNmVTlHaHNIeHg0?=
 =?utf-8?B?UlNrR21PUUVpT3lZV1lucHhZM3Y2aDhBaDhIU052bHFiWmZwdGtyT3drTkJp?=
 =?utf-8?B?STNuNjJQN2prVDQ5K1VrL2IvQmhnS2V3RS9mOE5UcjFMZWRGRHFTSVNrcE9x?=
 =?utf-8?B?WndKcFh6TTZtMnYzUHZmS0lTemFtZVppR1R5ck1LdXJHa0NlYUhFTUVGUXdC?=
 =?utf-8?B?YUcwYWdaT0xWOUhCNy9YNE5zZ3o1RXBNZms1ZXRSeFd2MzdDcDRUeG03Nm9M?=
 =?utf-8?Q?SnARTSOFkcWADGU6UY/6kjpNPUGuYnWndxr9JGWi5MC3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e49c5-5ca5-4ba2-1672-08dbf77d855a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:37:49.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTaazx87d0zPif8fXc0yvK8sqzTUYwsjmYHB0NkLqinqKkGcrB+9KNdVcf4lXsE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, December 7, 2023 1:02 PM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> fenghua.yu@intel.com; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; dave.hansen@linux.intel.com
> Cc: x86@kernel.org; hpa@zytor.com; paulmck@kernel.org;
> rdunlap@infradead.org; tj@kernel.org; peterz@infradead.org;
> seanjc@google.com; Phillips, Kim <kim.phillips@amd.com>;
> jmattson@google.com; ilpo.jarvinen@linux.intel.com;
> jithu.joseph@intel.com; kan.liang@linux.intel.com; Dadhania, Nikunj
> <nikunj.dadhania@amd.com>; daniel.sneddon@linux.intel.com;
> pbonzini@redhat.com; rick.p.edgecombe@intel.com; rppt@kernel.org;
> maciej.wieczor-retman@intel.com; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; eranian@google.com; peternewman@google.com;
> Giani, Dhaval <Dhaval.Giani@amd.com>
> Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory
> bandwidth event configuration
> 
> Hi Babu,
> 
> On 12/6/2023 11:17 AM, Moger, Babu wrote:
> > On 12/6/23 12:32, Reinette Chatre wrote:
> >> On 12/6/2023 9:17 AM, Moger, Babu wrote:
> >>> On 12/5/23 17:21, Reinette Chatre wrote:
> >>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
> 
> ...
> 
> >>>>>  static void mondata_config_read(struct rdt_domain *d, struct
> >>>>> mon_config_info *mon_info) @@ -1621,7 +1621,7 @@ static int
> mbm_config_write_domain(struct rdt_resource *r,
> >>>>>  	int ret = 0;
> >>>>>
> >>>>>  	/* mon_config cannot be more than the supported set of events */
> >>>>> -	if (val > MAX_EVT_CONFIG_BITS) {
> >>>>> +	if (val > resctrl_max_evt_bitmask) {
> >>>>>  		rdt_last_cmd_puts("Invalid event configuration\n");
> >>>>>  		return -EINVAL;
> >>>>>  	}
> >>>>
> >>>> This does not look right. resctrl_max_evt_bitmask contains the
> >>>> supported types. A user may set a value that is less than
> >>>> resctrl_max_evt_bitmask but yet have an unsupported bit set, no?
> >>>
> >>> I think I have to make this clear in the patch. There is no
> >>> difference in the definition. Hardware supports all the events reported by
> the cpuid.
> >>
> >> I'll try to elaborate using an example. Let's say AMD decides to make
> >> hardware with hypothetical support mask of:
> >> 	resctrl_max_evt_bitmask = 0x4F (no support for Slow Mem).
> >>
> >> What if user attempts to set config that enables monitoring of Slow Mem:
> >> 	val = 0x30
> >>
> >> In the above example, val is not larger than resctrl_max_evt_bitmask
> >> but it is an invalid config, no?
> >
> > Yes. It is invalid config in this case.
> >
> > How about changing the check to something like this?
> >
> > if ((val & resctrl_max_evt_bitmask) != val) {
> >                 rdt_last_cmd_puts("Invalid event configuration\n");
> >   		return -EINVAL;
> >    }
> 
> This would address the scenario. I also think that it will be helpful to print the
> valid bitmask as part of the error message. The original implementation
> specified that all bits are valid and in doing so no interface accompanied the
> feature to share with users what the valid bits are. The only way user space
> can learn this is is to read the *_config files after the first resctrl mount after a
> system boot to see with which config values the system was initialized with
> (assuming system was initialized with all supported bits enabled).

Sure. Will add the error message including the valid bitmask.
Thanks
Babu
