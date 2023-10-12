Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1FC7C7938
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442960AbjJLWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJLWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:06:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7892DB8;
        Thu, 12 Oct 2023 15:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH6PVeUVKjBXe1Lt9x7zLL/vCyu7VGVALgdznmiEwiLf6Gr2Hm+rtgqR5sui0HNdTMo2SnzGlvnptX3RV9C/m812Wa2p/OgLC7NAUWRxWu53WU+it70D2xZZBxCG/F8PMDx2pWKmIkR94u4kszrWspDfDKD9BPFXAX2v8H+EhZ9ZsIiJDBZLWsQMEWAnsDWwllk3zr8TUvE9o/3oNKoSA/uuicSY6HDI12tpRTBIX2uR+u5abawYL7dLJ2sagrt5pxt75labDhEINJuDnRwh40gTjkLaDm1FFuCfjHtDDjye/9REySyovKOFBqfU5Ah+fvVG+ob4Sf3MFNKKOYMzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNhVtiop9+BtablW1oW8j7FG92gvA/iZiZWNFYJzGIc=;
 b=XQM69FMn4OTdrm96JOzncWazQhJ7LRY089n6ve0YxPa7Ibl1SF8OlPPUvAw6GX5dPoJSWyOb0jLdLc5PXJvzwmDQBTCxLleLVPLHu/5m2SCjMkeQc6jo0U1SWf2wU+1B1LxAP4Iykl6GqBddAKXWNIS31J4zJjH4Btr3jd6gYBm1l0V82eAUDiejmh6F6SOeI3UqwXrfgAgwhp/CVeOtyOzIuQZdNmz7ek3BeEx6RoTW2xUJi2+zzhFupvWlgVrtlYVyMFDkWsO4SHgdk7ueF+/EH1PJwUT5p1mJiejRx7tdvg5/fXgLLHWjChjLx7wHiYcrqQO6EownVwhowJCINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNhVtiop9+BtablW1oW8j7FG92gvA/iZiZWNFYJzGIc=;
 b=U7KXoidxf5CF1L3XAGRK6da9sCvszDI2D0wTfc+mYw3frVJz8NnGR76oCJTnPAYV4RKIWuLmlivbwCnHu3mK+Q6V4g6Yfuqj4/hIr/0Oe78GFygAF9b2HnY0W07cZNdJEqoKg0nXxZje8mqZi/ugn5j0rQr3JADiSzGjN4TFo/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 22:06:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 22:06:33 +0000
Message-ID: <5eade0a5-89d6-e93a-f5f0-e404fb37e2c4@amd.com>
Date:   Thu, 12 Oct 2023 17:06:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231010233335.998475-1-babu.moger@amd.com>
 <20231010233335.998475-11-babu.moger@amd.com>
 <c030c50a-201b-4a73-b3d6-b9b298f1b251@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c030c50a-201b-4a73-b3d6-b9b298f1b251@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:806:27::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 567cf853-7e7f-45f7-dadc-08dbcb6f7eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNm2JMInNR6ZOr/p5s/zQVFjE0cItt5uXSE1GBZMsSKFkEp58eKnQ5asHHfKBADtTOPO7VEPnEoEMjAub5TTDl4GTxI0oQeMN3foD30asjTmBhOF2UT/ent8Rxz0uTNTESnvblW/LgiQBfX800EEEUufqytPEqVzkIMf0BHScmvwwor8vDqc7RDK4+xZBhg4ButDkgR4ATqTA51SiQILGu2hOkgLYW2ljN53UQdxqgNppzS4YJBP5mM8RKvlhm+kTWuSdJEJg0bhH8hDnZU0fXCuAfa1IEVA0XdJ03mZeajFtXcZ1K+uDGB2OG+BN4x2IqFFhqufRQ7pZl/S4c5ymQRD7Iidz8SBbLIrLuBh7YOgXel1uX8bOBlKLRr8DfgeWp5hwYYIOrlLkRVCosTX6kc9CD+rbpXQnBhDnoc9DOMgkClwkriOXy5IUhlD6BZAsZBV2nWWhI9ejsUioAQe9cBzTsd5TubK33aqR/k9We1sO9dFqbQKUj35h7Rm2zzrn12k2FrmcmLXZZ5srTe2VIwO+Cil29LWQv2+2ZUbtHj13/yQap74dnD4ZMUr7NhoJ53SHo7Nxj1WMrbOytgw2gMON4zSxN2Pd+JIpJxOrq9zhlgA6PzBtKeqaJ/ARC78PsN/ho4HMOHLc6XYg8roLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6506007)(5660300002)(6666004)(26005)(4744005)(2616005)(36756003)(2906002)(38100700002)(31696002)(6512007)(7416002)(7406005)(6486002)(66556008)(66946007)(66476007)(41300700001)(316002)(110136005)(478600001)(8676002)(4326008)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dzTjYzNDZqMUEveERnT0t0ZTQ5STZ1UDBRQmJoaVhiK3hKRnFnOFNSVFQ0?=
 =?utf-8?B?TjBKVWhoY0pxYzVEZk1YVStpOURIYS93NGRESFhNR3F5QzlBUmkyZnptaUox?=
 =?utf-8?B?elBOY2g4OTFVd1YxWk5aMHZuMkNjVkpVTlBjSW9YYXFsZVpCT1lBV3FrZU9q?=
 =?utf-8?B?U3dWT2lzaWU4b3Jua2ZFQkZmNWhRbW4vaVNqUG4yaHM1a2t0dHVKRU9kWGhx?=
 =?utf-8?B?S0FzWXYvNVQ5c0hQT2RPd2JUVmZIVVowVHUzUms4bkpXT3U3YTgxVVhjbVkr?=
 =?utf-8?B?R2xHcEVaeTV2NGJlZzdwNnZjaVNRYk5WY3lNd0hRMkhDWWFNWjA3YldsazJk?=
 =?utf-8?B?ckZqL2I2UlBrZjNnS2hiMmJvbE5zb3NTZGhoZVZaclBoT0tiQ1NzWXFmMllR?=
 =?utf-8?B?Z0pTZjlYUTMrMDBqWGZYeVFZMFNDNjN5SE1TbHJWNFluTlV6L3lUKzc1K1FY?=
 =?utf-8?B?d05uOFFrRFFIblFVM3FXbXhDYTY4d2xWSmVRM2I3S1dZVHRjV0ViemRnUlRo?=
 =?utf-8?B?cGNRMmpFK3l5ZVVjNDA0M1Exb2syZ3p5UTVUb2IzNXJINFBLTmtHQkErUzFa?=
 =?utf-8?B?a0EySnpGVnkyaTFQRDV0T0wyTnhOOVB4Ri9LSHovNVRkMEl1TExiL1NIajUy?=
 =?utf-8?B?SHhZajI5UDJpeVo1alVhUXVRN3FqTU1iK21tdzZCeWo1SEo2VU95ejgyWmsx?=
 =?utf-8?B?SFVnUUVhNXhDT3RXL2VEWVR6bE5XMVdTNURZYUZVSDMzR1laSWVma3pOSkIv?=
 =?utf-8?B?T0NqMUlzY3IxVktSZTNlS0paWGgvV01UYi8xUjBVeEwwSEI0VXJLV3NHZUdj?=
 =?utf-8?B?cmJ1aXR5OGttOHltUXhRY3FyYUJHRDZhZG1Yb21Qd2twSjVmdTd6NmRIQzBi?=
 =?utf-8?B?c0RFT2NDdDNDeW15elRLQkh6VEVsaXJSajU0UWxCUHRmZEdkeExQSEJXZytY?=
 =?utf-8?B?Tk9SUzd2eGRFNHBiMTdFeWdoN0JEblBjQXl4dVgweE1WMUFBNWxRNWF1R25U?=
 =?utf-8?B?OXBNelJ1UFhvbkZjYVovbWpFdjRiZm1OTUVmeUMxZzFsMDUxSUgvK1ZiWVRK?=
 =?utf-8?B?Z2ZiUnJTYjlGQXN3SEx3WFVZeW02Z0RBTzhmTmhISUU1bkJ3NzFzcHFNRzI4?=
 =?utf-8?B?S0hEZ0tJSlkzRVA5ay9CeE92YUtXbDFZMFE3UjhRS1RSMkRyRThKRFp1YnhR?=
 =?utf-8?B?U1NkdjJ2VnNjZDFCMlNNckpEUEN4YTd2QmZsZURTVVBtSTIrU2xtbzY3MHhM?=
 =?utf-8?B?cXFpbkdkVEY2YWcxUzBVbVJuSGZKNFhiUHJxMXcvbkY4VEtkaW5ySEoxbmJ4?=
 =?utf-8?B?WHRlSUZMZUtXamMvNExVNC9XeUllRzhCWENKSWI0RmdYZUxDTGVXZWQ1VVhF?=
 =?utf-8?B?eEU2S1pJc3R5dmtVZkc4Y2Nia0FMWEF4TnMrWmQ1Z3MyLzlUall1WlJyMGYr?=
 =?utf-8?B?blE1VGJ6QWM1cFZxV3d4TEQrTlNQWnF5TUhUOW5tMGpFMWQ3L1NtMi83eFpu?=
 =?utf-8?B?bXFqNUY2Q3VOeVhNdG9Xc0Mrb2ptR2Nta0ltVzc2dnBKQXM1Yk9sckpEb0ZY?=
 =?utf-8?B?SnZwRHdDb2RhaDJweWhoS3FoODNpejNJUWo4NDVzR2c3b0F1blZUcnpsd3J0?=
 =?utf-8?B?TVNCVDdPK1BQV3VKZzdZMm5DUWJ1d20zVklFc3hpck9aOFljdVBRbmFvZERG?=
 =?utf-8?B?bGQrYUZyRFhaOHgvcnNpdE1DdzZ2QXdZWXJvNVIyYVJ0WGc2NGJacmdkYzJm?=
 =?utf-8?B?OGtiR3dERTlFSTczaCt6aGxCUWJiVXkwbEg0N0pVcnFmZlF1SFoyUzlOcjhs?=
 =?utf-8?B?eldyMEZ2N2pjNDJuaFZ6eEpPWmZuMFB0YzliM1U1OTMrVWVTWjlUTUp0NDNZ?=
 =?utf-8?B?bGtGNnRkZ3l3MGlsMEwxRW04THhoMHhpV1Ywc1IydGJRUktHWHp2S3REajhH?=
 =?utf-8?B?Qk5JYlB0OStBbGg2UUI2NFNDdVNpYnlJT0pkSmdaUEFYVzIvWTVJM2lMZW0w?=
 =?utf-8?B?eUVWYXpjV1JGT0o4OTVESGUxdFVnT0EyaTNBMENyL1lUTkwwL0hXbENWSk56?=
 =?utf-8?B?RzBFQnJGT0VLS3c1WllDREM5UUxpUWJQS1Aybkl0T3FRR1RHSVNOZWxQY2xC?=
 =?utf-8?Q?HWhI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567cf853-7e7f-45f7-dadc-08dbcb6f7eb7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 22:06:33.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDW8kdYMCilu4scCDj8fAAVY8ksM9aiCKdqiDQlJxSVDelyXnFQ0CiOREcCAgjj2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/12/2023 11:02 AM, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/10/2023 4:33 PM, Babu Moger wrote:
>> In x86, hardware uses RMID to identify a monitoring group. When a user
>> creates a monitor group these details are not visible. These details
>> can help resctrl debugging.
>>
>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>> Users can see these details when resctrl is mounted with "-o debug" option.
>>
>> Add RFTYPE_MON_BASE complements existing RFTYPE_CTRL_BASE and represents
>> files belonging to monitoring groups.
> "Add RFTYPE_MON_BASE complements ... " -> "Add RFTYPE_MON_BASE that complements ..."?

Sure. Thanks

Babu

