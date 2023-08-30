Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A214278E19B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbjH3Vsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbjH3Vsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:48:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9546B5;
        Wed, 30 Aug 2023 14:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5bz0AJlx2VHxY7HWgUI14VoRKDdfWvxTkAG9nqZgXSlL4PtVmS03PpxXENc8XSTU6lxJRRjCz2FNRFA8m17LFA1OZU6Ayj6KWq4nrWejPqeSYHam9vatXku+WGx+PRF3w7eTP4vAAlyK7sPuQJyUBfo+d3M9tYYuE4a8EUss2TireP69RnLuc3gvyZRTAXYdK4dA2peuY+1xKMugu9Da/rWddAJohCOLeZHU8hWNr96/CCxh3RlK2qdiqGgceMpmfyIlgKzv/oVOJ6HcPH4R1/alamt+/w171zxd+Tq/ZLdfCuemCWhPKiUQ7Z3dAJsm+vnJHTHG1LXBT1gGondFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIZKtoC1HHuivrTA0s3YhO1TPjnEVUAIvHC+kUuZcRg=;
 b=DUqhbCpa3A5wSp89WVvGzuw+nlz9irU1uKFLm9H5KLokAqj/86gtuIYxD7zMFnTrAH/XcxKnkxX3ctzU81PI20KaqW5t5QaYCOeqXIYadAjIA8vIQ9xhH+acmRwqo4RpiWsKK/96y1RnYXMy6Xauibp+EBCPQHRhnJTBE4yOIPLhd9BU6/THZ/zQSYnr7lSjKnIzGUnySnI9tng2BTItX5dkdqhK0fnY//fKfH59pkWX/1kY1mJE28fco1vKpzsHS+DzTzRJbYGK+GYAMkmXtZGuyW+4AFtbaZUCDTWsCl4tFOolV/TB7uWCimHCFPfEAM4r5l/VILPhMQuA9InIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIZKtoC1HHuivrTA0s3YhO1TPjnEVUAIvHC+kUuZcRg=;
 b=4EztkW2fufLgNUAYvOOoqnWBUjZxY9PEVM0ygUsNjj4zsY01yz2cceGcdCg2f53BjRfQMbKulFVYvV86++XmIwSK3X901XdhA4P6kM2xHPzlvWfaScolW+KYpTOWxv3IAO7kT94+xHOiTGv1KEe7mPjbTlSTpChYoZZHFzrg89E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Wed, 30 Aug
 2023 21:45:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 21:45:23 +0000
Message-ID: <65c65040-f4aa-a036-c2ec-f39772526c7b@amd.com>
Date:   Wed, 30 Aug 2023 16:45:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-8-babu.moger@amd.com>
 <c2372a14-0de5-f1fe-bf2b-66272b960e2b@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c2372a14-0de5-f1fe-bf2b-66272b960e2b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: c82f56c0-346a-463f-d414-08dba9a269f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cx0xUC4Xg8LWMhhJIzxNU8Dnj+c71F1U8VUcrt6Oqx6wYphnELGV7vS9EK1nkD69WAmHTUwd/4ca6DxPvxH47JoP8CeHJsR0mj4X94zVReaa2p3+biVOOTDOoIWqkxhOtez0RhCSwz05CWB3hn3/j8FdQPEKEokOH+FZRmwWb1ifrfjMrzex6nrssl+kmF81HuFQVdWwHRay7EJqJwSzVwmhlhoPlhRmarXoREiMO4xj9RQH1SNq/RMCfIzdmSJDzo5dxaSAs99DV+aujusdZZV2ANyXl3gTK9xpPOc8iUAzIn/xpv/h2vqJpyXEiFhU0GBI6xXG+YvmQ47nX/tZuCdnblq9beErijx0QhId+AyZDdPjT5bnnV/ax62k71pEjvAM+e8zFjOKAmqnjRloBiDgK+d9q4/3EoKg+mED6khqWM+yTgZqiNUR0zvjKa1frChnoYLQ5EbEvVGaHl0wv9J1+7JHlClwtt0eOC8q/KcGw+qkJCEFMcG0pbe8t4hZRMWmEop8wjbk459m84yVdwwbakHopQtwmtBiNmegxjaEg0p0rUx2VZzH+dmadvL9LAw4nyN93KNnsashiC0IIxnc6ULqBv5yvwlMLuPkoPaM5k4uf0a0zf6EnqBM2uwqxJ3MWdA5Hr7Whov4T/ZFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(2616005)(5660300002)(8936002)(4326008)(8676002)(4744005)(36756003)(3450700001)(7416002)(7406005)(53546011)(26005)(6666004)(38100700002)(66556008)(66476007)(66946007)(6506007)(316002)(478600001)(6512007)(31686004)(41300700001)(2906002)(86362001)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZ0NnpWTzBoV0tZVldHQkVCejlhUWV3c3ZRd051TmNGRW5zUEl6TVJ3UDhh?=
 =?utf-8?B?NDNrOCs0ZC9PcW1RWWp6SnRVN3EvdFhZS3djZ2pPVVpsL0JhU3l1Y21aNWh3?=
 =?utf-8?B?MFFYTy93OEN2Qmw0MkkwM1RSSnVJbFl0SEN6NzlxckNLRzQvVjNVVnhBeFRI?=
 =?utf-8?B?WnZmM1B1dWhEL0JjeXVGUGUwbGdidmNVb1UxV3NuNE0va1NzSFFrYkdLWUEv?=
 =?utf-8?B?M1ZJbGwxQTZlQmlzZHpsVkpyVUpnTWpLZWFmNFhWNnNPZ1I1LzhxUzlFVnVV?=
 =?utf-8?B?RnFZVUs1NUdvVGdna1FoR3ROYjFwYkF3WnpVU1RhdTR5S1JtRkZMZE1qTmQ4?=
 =?utf-8?B?QzBqSWxXbm41bFJhWEtTN05xODVRM2lJaG1YVmtnRGpXdjcxd0czVVd6OTB1?=
 =?utf-8?B?V1ZQOHYyTmN2dGlNMGd1ZVBDeWlEWDZwVGpob0pBUTRGQ01qeENRVCsxM2Jy?=
 =?utf-8?B?WENnSDdyc1l0YmdkZ2JJbkdnNmlOV3NGYytBemtaUDhtcnZwemxQY2hIcWt3?=
 =?utf-8?B?QnE0VW93YmlzeFNKUnFoSk8rOE5CRWZaak5VMnNmM3VweDgwWVJ1ZldkVmx4?=
 =?utf-8?B?UWc1Y21RUTBwOG1SOU42K2JSNkZMSnpKN2FKY0xMQS81OW50a0ZuNGR5TmtO?=
 =?utf-8?B?Qlk2ZGE2UklCTTJZdnlLQkJBcExuZThyYmNublZuWjZFWG5HZnB0VCtGRHhl?=
 =?utf-8?B?QlBLeHZiZ1dRQkFSSER0Q0E4N3E0cVVGZ0lsZ1pQdk9TaXFXQkN4SE1CZlJ0?=
 =?utf-8?B?ekVTaUpEOTBRdlVpV3ZXSzM1MXFhbGtaU1lIWjRqMUFnZTZNQkRwZXp1dC9p?=
 =?utf-8?B?RitXYUNRaGJqQXBWNlpPSmNiVlBxbTZRZzFqLys5Y0JZc3RNSE5nK2U4RXk5?=
 =?utf-8?B?M1FRNkF3RjExV3FQR1hsRmVMK2RrOW9HdldERHJib2ZwZFEzWGhzTTByL1Zp?=
 =?utf-8?B?QVNJeVpxWFd2OHhDWFc0dFFTTCswVWZ3UGoyWk8yTlNGZ25YVUEzaWV1QXdS?=
 =?utf-8?B?NENFNlBrVDFrdDd4SDc4YWYrNzNBMVlNOGJYV0NhNWdUTFJqZjFsWndZRW9y?=
 =?utf-8?B?UmdDNm9pV3pPMHgrQlRjd005RzdwaWl6bUZIWmZ4SHh0ZTJFZDYzYmR3WFcr?=
 =?utf-8?B?S3ZkYUZHTmhMQi9VZjBwa2VmeDBORklVeEo3L1cxTVY0MjFDS3FNcWZWZWI1?=
 =?utf-8?B?TEJIajRyWkpzbGRFaVN3R3RTTXk0b2ttOWwvdFUxb3lxeUV2U2NIREEyMUF1?=
 =?utf-8?B?cDlEbWl1MVNPb1FhZWRNbWpQYkxnMlFWUTY4Z3hOMFNtamNTVC9Od1pmSSs4?=
 =?utf-8?B?T0lFanJ5b2taTXgzNUVYRis0M08wSHlxcEFRb2lRNllVc1pGd2lzeG5SYTEy?=
 =?utf-8?B?UlM1RHZBeXZKTndGRWpuMVJLeUtJT1AvTzRFdTVQRW5Tc2J5Q0pOVXM0SWJT?=
 =?utf-8?B?U2g1YTZBY0d6WU9sSml5V29YN0J3NjV5UE5tR0dCdXV2Ujkzd01hTG1INFkv?=
 =?utf-8?B?bkEvZmFjTUs5RXVLUmpKUkdsUERINTNiSGtxRk5JRStGTHl6eHQzYk9HUWto?=
 =?utf-8?B?ZHlvOVBqQWRpRjFiZ3gybGRSUXB1YkZjZTVMVVJNeG45d3ZTRVdJUHVuVE14?=
 =?utf-8?B?R1BrK21uYWhCQk13aFdUNU53eTZyVEFpOE53U2dsK0tBc2h6RFNDK0t1M1BY?=
 =?utf-8?B?M290TS9XQnBjR2ZnTW9NeCtPWnllaGh2M25nemZ2a3l6akE1aXIwcWpJcXNx?=
 =?utf-8?B?YU9ycXlMRFBTSjYyc1lVTk1xNUhrZXBHY1VmNFk0YlMvTjF3anJ0QUwwalB5?=
 =?utf-8?B?MEhKY1lRQXY2VHFwd1IwUkV4VThGZHQ1eEdhWXdzcE8vaHM3b1FmemVFNGxk?=
 =?utf-8?B?T1F1MGJ5NFdFL0ZXSnpzR0VsekZMeWpzSWo0MjdXK2VLb0lsMzQ5SEVTYWEw?=
 =?utf-8?B?VVJQSkhvYy9zRGx6VTc3OTNVa2xOQStLblNqVHY4V2dkMnJmZUQ3UXFJL1B0?=
 =?utf-8?B?WHBBcURPWUNyRXJRUmtqcWt4K2xrN2JFRjAvZzlnaHRkRDkxaHRHeUU1Qm1I?=
 =?utf-8?B?QTdPeXR6cFI5Q05QRkk2V0JpN2Jad2ZabmtvMmo3N3Avazd3Tm5Fa1U4MEVJ?=
 =?utf-8?Q?6Bkk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f56c0-346a-463f-d414-08dba9a269f7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 21:45:23.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6CUjZ2zPG3zZJ0rAyjOUbaC0yzXlq/THkA18tSR6+MJ3Mnl4zeObBuXeKc+rvMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/29/23 15:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/2023 4:30 PM, Babu Moger wrote:
>> Add "-o debug" option to mount resctrl filesystem in debug mode. This
>> option is used for adding extra files to help resctrl debugging.
>>
> 
> I think it would help to highlight the new RFTYPE_DEBUG flag.
> 
> 	Add "-o debug" option to mount resctrl filesystem in debug mode.
> 	When in debug mode resctrl displays files that have the new
> 	RFTYPE_DEBUG flag to help resctrl debugging.

Sure.

> 
> Feel free to improve.
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>-- 
Thanks
Babu Moger
