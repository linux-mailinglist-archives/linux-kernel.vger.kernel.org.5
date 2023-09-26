Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6327AF4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjIZUST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjIZUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:18:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8D193;
        Tue, 26 Sep 2023 13:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAPb4ddjouvb5d7HUqn9bNbFod/DbsWlyz0gYL7R8PWbAI/c4jS88Az9mZ4Ps9SWt9VluVMK5Pqn0hs+bP5vs+QrtGt0osPtIwA2zv3a/DHKJLqoBmbjO+dAW5On1aPoI3TjILG5ZMZPwLtjtKLtXZIupkDLXEAMRVUWg+5sFeST2v2ISghupUPay1cWTqYqgpOfvHnRdnsMqh/zCmZBw2m/CU7qY2otmZWsZMfsAzWwVnq09Q1LnwFLILAEKG2NaLt4/ZAL5c4IYJ2aP3WiimMjw76ATgTLtZnWBhiCBIJlSxkGUMwcJdz8mKfOcZ8tzWOCa2nK53nrixBaCxYZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rURzeWuaPmtLdQQhJUepyN3wKraV/Qi2F3fYGw0kO/s=;
 b=HYL8pVEGaJi+1+SdxiDnB1e2Kx0EeRcZl1F+BFXTud4tJDrCIGNTRjThrWB2VLrNqhvlKSdMVUtzC6qMEDtUZFxn741NIod0xi17yxkmqf5w6xsg9xeS+JlA0RvtvBzWj4RNxX1adz8T0CxgislEbOaBShhium+U4PjFlHkn6ql0w69OUW2VZKro3gbS7x7sK/S7+y9p7X3HVGvO3Q7VelYch8DddREYuULxX4kuOYAe/f7beju5b+wC5J7wc9E+EHDdAzzVez4p19cozXnAwUs4R7lvBFhu1KIvZ4do9WF5/XynrXR2sxeQiRDulAgFpKHIkhyhlmsNys+mczHlZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rURzeWuaPmtLdQQhJUepyN3wKraV/Qi2F3fYGw0kO/s=;
 b=GRC2UReoc4j5EXlXwflzTe2XzHmtcW70P/khU/KcaZtFCU09QIee7B8B0wXPnLIyr9vxaZ5vokYLvOAsLbzPBm04fLqdYJ8r66SUu5CHQEuGy7b2CcgqxSkMjsywOzS+aVQ6NHhABAY7CuuktLmYW+hhoMSGLx12kSW5lrFqKOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 20:18:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 20:18:06 +0000
Message-ID: <4b011314-aa9b-1a92-d15a-5baabc77f1d2@amd.com>
Date:   Tue, 26 Sep 2023 15:18:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
 <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3d0b98e7-9aeb-3a97-9861-707ed7a1db69@amd.com>
 <SJ1PR11MB60836E94B5DC0A2D7B5ED2C3FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60836E94B5DC0A2D7B5ED2C3FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:5:333::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BN9PR12MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: d63493d4-85af-46c4-30a0-08dbbecdb1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sK+xEdyXDfGnxDyXQsry5Rcw9hOErQHCqrl5ZaIwe9q968tIncNEp7r7HFWnFyWHWfQHuPbJetskiO0NNqfaar/lGLFzLp3gvd3FHE0AnqwPf05nC4vuRUMaOjHWt+9LNOc89MQ2SVu0wMlPnI20hqHjnFa4W35QxBVI4o0bJSTU/b5nlnRH/i4l5qrTWPVY4ynA4CYcsVYBCUtXxfCesLYydSeBKL9T2It8pDwG6O8rpoC2giWjMYQ1nh4XU8zTcPrkzecNef8+jzks1cwUi5b9QT5DenBQHm6n3kJ9NfMt0FOw4wTzeO/23Fm+cxmhe7Ktn9N0Vx0RDbADALUUUFNjn56OzyEF715Mwc4QEKUu0vHCK66DjP5V6g9bAa6V2x7s3kgi/KA3BS33vn8r0TlSqE1nvRdaIdBRWbu73qOuD3oW1VGTMuV6jLP8g7TaQEOKJA6sMCUccUhddKqGd+ctkCoiJOCeeRHwnTmCw6yYjUQC1meQ5kCGDQCNGGF8uMyuis+m1Bf2TekDK69GexEbcDrdY98ngXsXVyaUHbr2RgDnEI6n9l6c+Fgu7GvMWWKz7oU4y+TOzBAfnLQ+WIT8og1nUp9itpUkuJnobk8yBUUegMzR/+tbW/7aUjBTQ/xcDnpuFgBFD7HJIepieFFd099+70l1BizJgSAEnUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(6506007)(3450700001)(6512007)(54906003)(2616005)(7416002)(316002)(26005)(53546011)(110136005)(4326008)(8936002)(66556008)(4744005)(6666004)(478600001)(66946007)(66476007)(6486002)(41300700001)(2906002)(8676002)(31696002)(86362001)(38100700002)(36756003)(5660300002)(921005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBUSi9OZVptc3IxNFI1K3pOaERxOXFJVE12dzIyaFFZQ3pNNHpZWkxPYnNj?=
 =?utf-8?B?YXRBT0w0d08ySldWa1Q2U1hqSUhRNE9YZy85a3hCaVovVGNOa2V2UDVQOEto?=
 =?utf-8?B?NS9QaDNqQXY4enZSMEU2bS96azc0K1E0RnhHYlRHdHBMaEF1ZUdmQUREL3hG?=
 =?utf-8?B?NTNOQXk3aVR5OW5JdGRDYngzWnA4c2lXUFBZdlBBK0ZYN1VmSi85S29pY2xZ?=
 =?utf-8?B?b01iTDN2ZWozSG1YT3B5RW9kb0dVZGJmS1VNNmxWejFmbFU0bHdQVFY5VnRC?=
 =?utf-8?B?NGlsYisyU096R0NwVEZ2T25NMHY3cFVXQXN3TUl4OEd3WlFxbGtKYjZEZkpr?=
 =?utf-8?B?dUdtTHZZSzUyL0VmTW0rZlFxL3Y3Qkg2L3pna0lnL0hPK2tYQnpPcXBmYWsw?=
 =?utf-8?B?UzMzMzkwemxtYXMrVnRCc3FZRzQ2RnJkbzFiYkRrUXhnWldVV0hiTUlsUzBM?=
 =?utf-8?B?YktEOXhKb1I5MmQ3K1d6aTlpaXFVZjVienVKTkxhQUpMTjdQNzZ0Y0paZXEz?=
 =?utf-8?B?dFV3a0FNWWVmRTlSNFU2ZDZSK2szcWVZMlI0OU1xV2JVU0ZhTjdPemRFM21s?=
 =?utf-8?B?T0xkcHFUVFZjbzE3ekVhTU50SGJ0bFc1TUw1MVhwckQ2MlZ2SnY4c2hnVkhE?=
 =?utf-8?B?YXZyYnVxVWdXWTltR1JvaWRHS2ZqRmEwM0RDNjF0Q2JZVDhPT2RoR0JhR2R1?=
 =?utf-8?B?VnN6ZUZvVHlYTS9oSHhkOE9IT2k5cUM4cGlvaHZSNEZQK2FTeFJmWldiREds?=
 =?utf-8?B?SnJtMFlpNDdNc3ltRkVHNEhGSDVyUm1sdFVvRHdEd0IyaDR1UG1mSyttVi9M?=
 =?utf-8?B?RWZvUU5Eb281MUk5aTQ3a21meDdnbHV5TmJ6RGZxZ2RKRld0K2pKSmNFcWc3?=
 =?utf-8?B?aFBiWXYwNXZwa2dEL25Sam5VT1FMc0V6TnF3cTV5UkJDazJEL3k5RnJWK1FJ?=
 =?utf-8?B?ZmhSMlVpcVJsYi8zanFRRWxRYUFoRWVpOEg0RkhWdi8rZUhTcVpKRDZiRjdD?=
 =?utf-8?B?c0pOdXk3MVVyT0t4MFd5dSs4VnZOQktWaG1ObHlUMUdvV1lDL2dIZS9WVlV2?=
 =?utf-8?B?VWZaNlVub0xGRUwrdDdqaWpJd003Y3k4S0tpUW9iUlc5TDNqc0dxdXBBRytB?=
 =?utf-8?B?Y3U2cFhYUnFwOWRiT00yTTE2bnVqYnUxZUZacEZXN2x4dkpYNkI1T25rZENI?=
 =?utf-8?B?WXVmcktIN1pibnl4dEI2bDdGcmtNQUFycVVKN3JaNmF3aDJZN1ZTMWphWW40?=
 =?utf-8?B?ajRzSFBOUjd3ZnQ1WmVFRVpiTkxXdFJ3c0pSWmxCSHFnMG15emxDa0hXYVlH?=
 =?utf-8?B?WERxRlVDWDJnR3ppYzYzUHNQVmhHWFF5b2RKbDBmYnhGTHFoWEhxdmo1NmdC?=
 =?utf-8?B?S3BFR2xQUE9URDhvdXZxSG54TWdwdW1QelZRUGVGSnY1b2NHNlVYOERsWG5P?=
 =?utf-8?B?dUR1ZDZqd2VVRnNrTkRHYUxmOUJyKytDbHV2L3g4a3BvLzVZTVlhMzBpWENU?=
 =?utf-8?B?ZEhuTVUxY3lRenVaeW4xengwY1UyZnpIaFBpQXIrODlXS2hUeGthaU9PVzJH?=
 =?utf-8?B?MENvelpJeXdEMnQyM0QvTnowK0F4UGpaZUg2M2pNcjNUbWwvVGwxU1N2Ly96?=
 =?utf-8?B?djdJOFIzR1pzTTlVa2o4S1ZwcmY0Vlc5cWVVQU5DblZGOVpGTklQV2YyNDFo?=
 =?utf-8?B?d2Z0cG94U3pCRFgwWGQyeTBuZjc2SUhtR2tOVElGdVovVE5aNzdWdUE3YkJR?=
 =?utf-8?B?ZlFtckRFZmV1cE5qYkVSUm1UQktiTzNGQUxsdWFVeUxOa3VoRk1qc2gyaUNC?=
 =?utf-8?B?c3MxT2JRZExBcDhieXVmR3Myb0o3SHUxRThKRVNnMHMxRXhudEVXYXhOWHNh?=
 =?utf-8?B?VkdRbjBJck1MN1VicG03eHhNa3cvc2xIUC9sakZYMHR6dXJ1c09XSE9sODlo?=
 =?utf-8?B?WG5yU3B6Z3JISmxkazJueXBTdmtqSndtKy9KUlpZUnRxUG1aVzl2Y2w0ZFZF?=
 =?utf-8?B?ci9rMWYvT0Q1SjRETENGWHplU3RDcE5UZFJ0Q3A5Y0JXRHl6VVh0eHk4UElX?=
 =?utf-8?B?TVB0Nm54M3FHb1VLd0hYVnB2WmMydWs1bWFYSDJkVmd5QisyOGxwSWdidE80?=
 =?utf-8?Q?Q1c+UuNhQBAraxur50Bco2S+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63493d4-85af-46c4-30a0-08dbbecdb1ee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 20:18:06.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqb93Hx1o+kVgc+65XUyqm9im1AerFcudjKrJITqWK6e+gptGI/pD2dYVGuEYdM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 15:02, Luck, Tony wrote:
>>>>> +#include <linux/mod_devicetable.h>
>>>>
>>>> I didn't see the need for this include.
>>>
>>> struct x86_cpu_id is defined in this #include file.
>>
>> Actually, the file <asm/cpu_device_id.h> already includes the above file.
> 
> It does today. Will it include it next week when somebody has to
> re-arrange things to resolve some #include dependency?
> 
> I thought there was a guideline somewhere that says to #include
> the files that define the things you use. Not just rely on chains of
> #includes. But some simple grep's haven't found that written in
> Documentation/*

Yea. correct. There is no guidelines. Lets keep the #include
<linux/mod_devicetable.h>

-- 
Thanks
Babu Moger
