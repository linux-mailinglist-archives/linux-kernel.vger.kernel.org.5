Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49097BC0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJFUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJFUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:49:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0430BF;
        Fri,  6 Oct 2023 13:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itvek8JLvmr7Ni0mRXThGalKCIBfQs2vz5z0uKTseLSu3GBD4fqFQIrbC7AmH4fURulF7deCxuweM2QY7Gu0h5vx6B1fRaTqfMMOdH/Cy2Qn0v3J+T8hvr5AJNIJGos8Uk63JTjOUxEinDIr6TBfwVhGJ5gN0Sp2es4TyU8jIsn0kLcFFmhr6x8uDIpfV31fTwuhTuzYEvtaEv+j7wMOFls+Hlasty7xbneauLm/JoIehutCPRR0Pm88RvMFm/5NysA4NvJkuvPSLHVNKHdyjsutXn3geacM1K03vFAYdnS59sx+g83rKwdBloPLk4p2xSkyjEF4H9RvjOkUgTn8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/1mIbmfRNDsSVkPA7SUT9y+KQKADFVVYZNLApOs+I4=;
 b=c9Qfen2Rn8TZLe0uEKUyk3S3JPieaMQN+6txMLi1GEp7zlMEYe74EYezRzyNZW4qFgeibghLCA5qggnp01zoQmYQv9QVKbX4ceCDs3y5jTCojZvJrXQAFb7K8SwuthNQKQQVATGXH6Qs19IRgRD6EXKXpk7KbvN98/DGmv7uO2n0sCugOtyccSng2q8bZ5Hz09PUyUOIkwgpFYkh4cvu8WYNKfAo+MbhKXVRHEjbVEBycNNBiVa/cp2kWQzK4gClsttLyiVQUeBdQmsVbtD5dYSi/Z6A8XCfZP2szS+ZBWekQydAaH3gqwA2Zh+Z8mM2fnDKsmfJqUOWPZuED0Wu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/1mIbmfRNDsSVkPA7SUT9y+KQKADFVVYZNLApOs+I4=;
 b=Mw1bU10/vvy2sqeU1dBU6KAVxHKYranD0g4VTE7neFXMq09Fz5NIp7AT+LlF8DR9K96l2+DCPa32Y0I46ixPj+cqBO2C7qjc3OHO9BZJdmEWxrV/XjdaEXGqfRUmmKILZE+c2ZHGLIS5P/UI4WU4oIpvJzdR0v8+gSEgpqW6MWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 20:49:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 20:49:22 +0000
Message-ID: <76eb259e-f2ae-b41b-9501-40c9a99e2433@amd.com>
Date:   Fri, 6 Oct 2023 15:49:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON
 groups only
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-10-babu.moger@amd.com>
 <b08ebaf3-6fe1-4677-a4d7-2c0e530153fa@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b08ebaf3-6fe1-4677-a4d7-2c0e530153fa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: adad4387-4d0c-403b-9428-08dbc6adb81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aNBS777W9sUmKzWpCgskwE7IlT/65+fAbhLqbDuj80Seu0PQCD0I9tqc7y5lPwDuavnwHGRMR/H4R+mgF21yOrLyW3eCFkX+TDhpx3dYCa8zjifH7f6bVYkaBbjLoBevemg8t+q7EFPgLLELRp5ByxmkU6k+f4L98ULk6AlhNzUK/vNwDq9pnXvNl287twqbvtv8gvToh8/oy57NX40lRhWdSJJcm8l7QnXjfOavupVKc2t+di5TdEOxO/1vMsK+aTAeIHUfvAYu9LtPqqNAwvPOCTjLqTbKX+UYugb3D65FftY40d+nEV/zLfgJRNgKvEgHQQIdr8LPZcyMSN+8vmPwfxqQ5D9l6p/QtMnNsAA0enW1IlRHsrER1BaCQMSOCxJ6bqNRQ1d7BUYjS8XkQqUPWoHiedytcJp6sMMTOtk6JW3HXoJI0v589zJIXvn5+udEVo6pEomwrxvA6fIaNdQbxn7qBMgbgVQMgpsU7j4GaQXrBYpQ+ggCTcl7flNNkHdouC7B6d4wC6JDXuzTZr2SB8t5iMP0s4j/UkTn+kTQ0T3c2gBgcpgfmZN7URMvOZpeyEowFrFqJOUo1ss0gABlgTfNh9hMSHchAbOzncw/Ke/B6RTDDwtozGkuiBb0eJR/M5ua5uJcRhxbrRypY5uKll4f5Vo09BcilrjWDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(7416002)(7406005)(5660300002)(8936002)(8676002)(2906002)(4326008)(41300700001)(53546011)(2616005)(66946007)(316002)(66556008)(66476007)(110136005)(66574015)(26005)(36756003)(6506007)(38100700002)(6512007)(6486002)(6666004)(966005)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZSb3Y3U0xFR2ZhSFpZVU1Zb2YyY000enBRaEJoRWswemVYMDRsekhtVkpt?=
 =?utf-8?B?WG8wUy9GdTJ3L2tkOC8rclN3aklzNEs3QjJBT2dXb3FzemRTVEIvNmp4RURV?=
 =?utf-8?B?VUk4emRvK3AzZ0hNVWxWZ3dMZWdlOXpHaHVUSWJvaFFhUkMwQm02WGN2L0xD?=
 =?utf-8?B?ZHBxR2ZmM1pGVWRueUVCU2cwSTZyOEF3c2QyQTQwaldJQnZYYjVxTEgzSUN0?=
 =?utf-8?B?OVMzbFI5VDRoV2dTYWdsTXBIanBNaEZrdU1JeW9hQkVzZkpnNUFDVDZWWXQv?=
 =?utf-8?B?a2FKZ2lqR2J4bjlKSVYzU3djWUhLaENGdU9uRUN4eUZMYkhhWVI2TXE2cFc3?=
 =?utf-8?B?NmpSbTEzVmlQVDBqZ2tIUmRweVBVcGxIVmRiOGNvK3JYSWFRajhnUDAvbGc4?=
 =?utf-8?B?VS96VFV6aWdjWG1ZWkVrTm5qcTFsdVRyQzYvM2hOUlFHTWk5UTk1NmIrUWtr?=
 =?utf-8?B?dWF1cnRucFBQOUN1RVhVQ1hrQUNVSHNFa0U4UXQrWW5PT2hTRnpxeHdYZmU0?=
 =?utf-8?B?b0JVQWU4dWlHYzNFNmRXa0FZSXVNN3RtVzVTakJMN2RsMmhFcElUbEl6ci8w?=
 =?utf-8?B?eU8zZTh6YVBLZnFFNXNxa3BsWWE1eXJZZDRhWE9EMzNxNjkyeERDSkpSbzVy?=
 =?utf-8?B?ZDFzUW0rMlpiZ2ZaMHhqc3pzTTg0cHMrWHJhOW5US3grMkFPMThoenNGbVcz?=
 =?utf-8?B?Mi8ybjBEOXFCMWpLZTNHQyt5Z2p0anFiU1ZXYkxoZnZaazlEUmpNNkJpcnNm?=
 =?utf-8?B?S2Y2TVlDNnJqZFd2UERoOHArNnFLYXRQM1h6RUx4QnJwZGJmN2U1SDlKVnRl?=
 =?utf-8?B?VEtGSXNrVllwVEFMWEJHaXVWWERCc25qNGtVZlo0TFdWRVYzOTRqNHdocEs5?=
 =?utf-8?B?Snh4S0JSVWFmZ1prbzRBSGQwT21iL3NQSDFlWFdhUlNMQU5uYmtLd25hWHVK?=
 =?utf-8?B?RGN3RVFIQ3pXbnhPK2VaclExaitOVm8zQUROVXY0TzlndEtjTWxqZkVPQzVk?=
 =?utf-8?B?TTlVS2xtajB1dmk5ajV3SHF0dFEzSDNHOWtBb0JhWjl5Q3dKSFU2eVlEZ1hC?=
 =?utf-8?B?Nm5HY0lWUkpJaWtWNm9YeDkwVVFYejV5eEdHOEh1ZVNsb0MvUTFFcTJ3U01k?=
 =?utf-8?B?UU9ITmltK1BqZktoZno1cU1OV2FoeUZDNUZtbWNYRmQ3SnEvZlJidk15cGxO?=
 =?utf-8?B?QUFKWVV4dUZhVzRITUFDbHB5QXJzUFdwSjhuWkk0cW9SbG9XNUY2S3hMTXZ5?=
 =?utf-8?B?cDVqUVFhc0U2UVU4VlpkTkNjVDM1a1FmMVVhZEQ5ZkxST1BrekQvV3hPVTFn?=
 =?utf-8?B?NG5WS296Ung2TFVEenhiOWVNdWZMbWdQT3lTdGNJMnprdGxrZmpYNlhEV21U?=
 =?utf-8?B?M25tTEtsNFlDaWFtTklqZjBJR2w2NlBDcm1jVE5lb2s5TWtjWmh2enZuQkZv?=
 =?utf-8?B?cTJRUFpJaEJLYk1mbitNdkR4SnhibFpHMi9paHdISFFpRldjWUpSZGdFYjNP?=
 =?utf-8?B?Zkt5aDNhKzhmdHJIUE44alc3WmJEU2U4MzFqbStWYjZFeitFbmY1ditkclhh?=
 =?utf-8?B?NVNKNGpTaTZGRWc5b0VYLzh3QVdWbTVINEROd0ZDak1XT2ozM08zWWc1V2RD?=
 =?utf-8?B?bDdWdGZIRkZpdFFMUmFnZTk4N3RUQVpKV1F0R1Y0aStNaGNJK1pGL3o1N3ZD?=
 =?utf-8?B?dWRiVHhheGJLV2hLbnZDMGxuSHpQOEZCMUNqclN0RTJWNlFkUHJmdkRSdmFD?=
 =?utf-8?B?ZHVIazVmdXNCMkV2YituWXRvbUN3aUZHSXpwdmdWR2E2dGJXZkJIQW1DWktB?=
 =?utf-8?B?Znp5SjIxa2YrU3g5VHhBak5PYVBtK2JLZTJUOVRRQi93OGpZa2RBSERJbVNa?=
 =?utf-8?B?SzkrUU1tZUhpK1VNUXF0ODdZcDZCQi9YMTk5TzF2LzZ4TDRLeFJTT1FhbnlC?=
 =?utf-8?B?WW1nNmtBNTdPVzBIRExLbGxQQ2t6WGluTUtNRlVwT2dwTlUwcnFTcGdSZTdz?=
 =?utf-8?B?NXY2N1JZMkFSbDZ6UTQ5SVdYaytTUTYyV2hKeGxZdDdWamt1QlM2b3NDVmtH?=
 =?utf-8?B?NzZTMDgvdmJScm5BL1FzRVJCZk1Ka1gzVXJMQ0lTL2tHZ0RpNjBGdFc2VU1D?=
 =?utf-8?Q?DpLyqv9VaWgfVt4jYbbj7j/88?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adad4387-4d0c-403b-9428-08dbc6adb81c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 20:49:22.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vazdeSco/TTUoaX8a+6TtlpN3BdiWTW2C+nTuNu03PL+MQq79oOrdPgOI9xmWTu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/6/2023 12:53 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/3/2023 4:54 PM, Babu Moger wrote:
>> Files unique to monitoring groups have the RFTYPE_MON flag. When a new
>> monitoring group is created the resctrl files with flags RFTYPE_BASE
>> (files common to all resource groups) and RFTYPE_MON (files unique to
>> monitoring groups) are created to support interacting with the new
>> monitoring group.
>>
>> A resource group can support both monitoring and control, also termed
>> a CTRL_MON resource group. CTRL_MON groups should get both monitoring
>> and control resctrl files but that is not the case. Only the
>> RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
>> This is not a problem because there are no monitoring specific files
>> with the RFTYPE_MON flag associated with resource groups.
>>
>> A later patch introduces the first monitoring specific (RFTYPE_MON)
>> file for resource groups. Ensure that files with the RFTYPE_MON
>> flag are created for CTRL_MON groups.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Peter Newman <peternewman@google.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
> Thank you.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
> I believe this series is ready for inclusion. There is a conflict between
> this series and Maciej's non-contiguous work [1] that is also ready for
> inclusion. We could wait for outcome of next level review to determine
> who will need to rebase. It may help to provide a snippet of the conflict
> resolution in anticipation of Maciej's series being merged first (I will
> propose the same to Maciej for the scenario of this work merged first).

I had a minor comment on Maciej's patch.

https://lore.kernel.org/lkml/fd2309d5-ea56-abed-5c3e-a8a038b07d9e@amd.com/

I will respond to his patch 3 with the conflict resolution.

Thanks

Babu

>
> Reinette
>
> [1] https://lore.kernel.org/lkml/cover.1696493034.git.maciej.wieczor-retman@intel.com/
