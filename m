Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AA7B0E57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjI0Vvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Vvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:51:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99048AF;
        Wed, 27 Sep 2023 14:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg08pomBq2SPZkQncWAGm5QgE1CCR7yB9ji2e2BX4CnOAKfFcu7ojBdT/x8QxGndhcgALLxCvkypxZrxDv53yG/xUKO2CWd4adbzlYk31m0HYQm/T4TFBeh1iJzG5mxeKLDTnEpbo4MH8+j+kbgycucvLUjzbc1mFEia9JJWKsiZ2k9l15TpVZi+WZce6HqF49w/Q8eHMrqPYMEuSMeLFpGj/ylrSqUeaPO5ZfcZOo3KxctqvzFb+Sxxjl0eOSVz5oOFTyfuP/xYIXekOxM3vUK/jhI32rdw67+BLseh9Q3StTaJyw3ksO32USeNM/XyRMNO7k9q2KiWEWLM9dEXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OJG7tBOyY8v+kP+5XN1sqrEL88eywCCWuJGUo71NK4=;
 b=iu+sLDk0jX9vYXF/hjvJktOfL5rrhsirLtQbQHEpzRPiihNpAoT1+ErwL9ci8LDMeYjtbwN48uDvU6GXGM+t7y9BEF7wc2PCgjXrGjimEUMLH+VzfIxsHtQOIEXaiMqxW5cQ7zCWp2uvLdhcepslMnXxIO6Fu6W2puvMVl+auAZB96rkUY+MyCUx2Vetr9N+BlLh5vhv5Jo5/1ZN37CEOmhJaspyL4nWsbrUcRw0tAa4QpomDrtYk4zJ9z/+Wj/N/+Y3PhBw3iGuyoaLNlTrmhLbvelpmC8d0G+R2p6wFxNP4OaxWs3TUcjDGtGgtHfaYVkaCu0LJGYCqpJJmuz20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OJG7tBOyY8v+kP+5XN1sqrEL88eywCCWuJGUo71NK4=;
 b=qrxpTwUNtKI7vac50ighC0WpHxiGvDJapFDrHf+QlO52eDMbXHjTv9LrJy4Yik5OKP400elOqKIJbONDc9ZV/0ip+hEOzuydBUFiHH0OfIs453V3l31JCyINdTJv8544zXHmYHeXUETKCUsI4R2RrJth47zPQ/PwGw4zxZze/mU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 21:51:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 21:51:38 +0000
Message-ID: <90091a63-df01-c5d1-1b7a-42d852cde276@amd.com>
Date:   Wed, 27 Sep 2023 16:51:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 03/10] x86/resctrl: Rename rftype flags for
 consistency
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-4-babu.moger@amd.com>
 <49c10592-5e95-30cf-7bfa-7105a16bc315@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <49c10592-5e95-30cf-7bfa-7105a16bc315@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: d429afac-16d1-4440-3754-08dbbfa3ed1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ro50b4w/oi8XGpaP7VzbfmLR93gf6LvCxv3+I1Qcwj9eU9wZD46lr378HDaDBQAjINB9+BxfQxpC8JdYHV1aMPl1i5rKyuX4WAg+33iXoUB22uz3aZshPb1x7sgLpOb5Bp/EbCb+SVd3oJ7RPI5kXSddbHLG3ts3gpCXxG12IA/64bmVWkqM7DjDdlXo7TVTN6m7y5lycaegpjRjBwMf3Pts8y4BvZHIZ4cvSuX1DqbB57/UwmQqQWqeixRa7Ff1HXhlIsIyO/bslT1wnVHP/yl6dauHUoidTMGuJuAod6mnb190If+DsNYHOp3VK3V1pFS/RvmuCi0s4P8h2vfPRb2enZdiWXeZ1dMnMfOXDNEtk5HZDiG5Lj59FK75fd2ZMeDK0X7dfui73AxmDUJ/5m29BsPJXRU4wd4UpWrOnztoLiCGANoSWs1h/TxluL13dJW1xaAzymbBpbEeY6jKNlQAZOesZnsVl4Ko0EbtFHkhHMyYCrsWoX7KmHHW7ADAC3cYEipPRTDEO+Qp0oLmWr+utaaDH1xacoMce+u0BJVDM1vaDRMSl9vMO6fn7kfKdl9q6i8bZzTr11oct7rVULKFTJPFeGLkfeGnUyQ3k6bF8IOKC/8YsUBblygs7ycwxblOdIHRXARrvoffTo1bIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6486002)(26005)(2616005)(6666004)(478600001)(6512007)(6506007)(53546011)(31686004)(36756003)(31696002)(38100700002)(316002)(5660300002)(110136005)(66556008)(66946007)(66476007)(41300700001)(7406005)(2906002)(7416002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdmcnJ3WWxJSitpTm9uenpTekZxUm16M1lJSnIySFYvSWN3dWNnYWljWm1U?=
 =?utf-8?B?VXRnQlI2Sk5NRkQyQlZ6cUFTNUlJOHdOSlU1MVBIMnJSc3B1cWdEMlNtU2Qx?=
 =?utf-8?B?OHhqL0dyR3d3UzF1aWErVXB2dFZoRm9CeFZmdXFnNWMralNnK3R2UytDUFhz?=
 =?utf-8?B?UHpxSXZZb0tCc016S3cwcHFTeW5Gbjl0SzU1bFczVWpiWjhycTFZU0NHam1C?=
 =?utf-8?B?dEtFbHBnaTFidllVYWx6TWRNYjFvUkEyUlpFc1ZDWFRWZTk2dkdZNzg3ZFdq?=
 =?utf-8?B?NEt3Zm1yTWs3M28rWERTRlptRTQwSGxNNXlLMUNnMTY3WkZ0RzNxekR2bXZB?=
 =?utf-8?B?eTZOUlFxdHBQd05Zb1hsZTdBYUpoK01MQTdXa1NZVHBLeENiU3d5MFY3a2Mw?=
 =?utf-8?B?Mk84bUpFSkdkVWJVQkdCRk9VTkN4Z3VGY0gwWGhWbjRYR0xOYzdDM3ZnRnlh?=
 =?utf-8?B?aFRFVFUrazVvVkRGQlJ1eFhvWWFPSzl1L2M4NlVCMElKWFBuajVqS2tKOWZX?=
 =?utf-8?B?SG43MGl0T1ZHOWRNcVhNQnJRWWVJblR1Z2xibmNDTmtFckxHYm5PajhPTjN4?=
 =?utf-8?B?QUJJbDdFNWM1bng1b1RrOEVROThPTmlrQnFVU3NjYlYyNklrSUROWFR5N1pZ?=
 =?utf-8?B?REVraG5LcjNCWEVjMnJwTkZYcTNjMnlkMkROLzdxdnBBdWZXUGdoVy9LT1NG?=
 =?utf-8?B?dDlNaHdvQ1pZa3pPR3MrelFDVjRKM2dDdyswM2llOVJzR0x2MWw2ZHNwclFq?=
 =?utf-8?B?MTFFSjgxRUwxdHBmMFVPLzdLRWEwU1JmWkpWaTNGYWYrckJ3eXg0K1QxNmZ2?=
 =?utf-8?B?SjNZWTRud0pyRDFNV21KYnBLdkJDWWgrVzYxSUthc1NjODZ2SmRUNGdTQW9J?=
 =?utf-8?B?aFhKNU42YTBwWlRDdTZUaURJbnE2Vm9SYUYrcmRTWXRsa1hGVVBURXpyQjRO?=
 =?utf-8?B?UUNOR3R2ZSt6Wk9CaDNlUlYrcXRzREk4SVFXSHordE43bUE1Q2xDbmd4NGhR?=
 =?utf-8?B?c2U3TG0vc0RGOHd2cW9hdCtRcG5kYzB6dmxNdzZ1WFh5Z3Nnc0tuOGY1UUJh?=
 =?utf-8?B?TnBwdXpMcS9MWUFJR0UzeEhUQVBqWnQ3c05ZZ3c5OUVCWXltOWpCeDdGMXZX?=
 =?utf-8?B?d25XNzZSc0J3NWNzZVdSbC81eHA4WXliZnRpYVJjWDhOdmlWRm8xbTJKZDB4?=
 =?utf-8?B?R2pVME1BT29NWXNLNDdHK1RqdmxsWFVKRXR6K0JDWk1ubXdRb1RYUDVqeW1Z?=
 =?utf-8?B?aldjbDFHTUZ6d0ZQLzhVUTJyeUNMaDJZNmJubzlrdlpXTEVra05zZjNNeVc4?=
 =?utf-8?B?SnlpZmhpMTVDeUhnSi9Bd2JIS1dtVCsyVHhhbHdSQ0tHYStDVEVlMjFpTHJC?=
 =?utf-8?B?ejZXUi9rZTlrN2YvOW0yb1hiNFRka0ZvK2FoVWpHRkM0UlRueGtqTm5aczB4?=
 =?utf-8?B?b0xBQTJvcmhCTjBVNFZ3MUhHbFdTRmJUMW43M05qempBUDZTQXczZXhZVm40?=
 =?utf-8?B?ZWlNekdoQ2kxTFZ1SFphRlBVcGN6Sm1FNHd3RXRlR1hPdDBLdkgrWmRHZWJP?=
 =?utf-8?B?VkFCdjZubFZCaDZIS2xVdVo2ZytUKzVGQzBYalhmZnZjOE5XemdvRHRmNktN?=
 =?utf-8?B?ZHRkYzN1UTY5TXFaV1JiVi94N0RGeXJGeVptQkM1TEJWLzVvc0hPRHNjeXZ6?=
 =?utf-8?B?clREVzdIcVgwTkJYRzFlSEdhNmUwNmtXTk0xL1I0VElOek1pZjhtQk9TUmhY?=
 =?utf-8?B?VXlvVDMyV3p5ckhkVC9qUDRkdFhhdzdJN0ducFo1ZUw3OUdJbitNa0FjWTRq?=
 =?utf-8?B?UVQxN0Z1QWdrTVUyMGt4aEhTRmVJM0VuSmMrTlJGc3ZJUENuZDMrTGhwZDdk?=
 =?utf-8?B?T01JejlITXYyT29GcXAwNTBsYmxMQ3V0S0xXVVhjM2x1bTVrNHZIQ1hEZlZX?=
 =?utf-8?B?TDdTT3RyUE1vZ1B3YjVDak1uSTRiK3ZLOVJVeUNhQmxmK3VKaGg3NXhDSjgz?=
 =?utf-8?B?MVMwOUcyQlBoRzN3bUhOT0J5T3NjYTNob3FsdTRKOFUwUzMzek1aajdJSXhN?=
 =?utf-8?B?bk1FUm96bzQxY0w1dUdEaHI5TTBKalVMSzY4VG5UcDRIQkFuNjRnaGxEL3F2?=
 =?utf-8?Q?fMJA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d429afac-16d1-4440-3754-08dbbfa3ed1d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 21:51:38.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z809PA5mPaNZoI4LLvbaobeGojTdXjsn/ESC2v9ak0JJQpSfBRm6Zz75+WClTYKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/27/2023 1:31 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/15/2023 3:42 PM, Babu Moger wrote:
>> resctrl associates rftype flags with its files so that files can be chosen
>> based on the resource, whether it is info or base, and if it is control
>> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
>>
>> Change the prefix to RFTYPE_ for all these flags to be consistent.
>>
>> Also add the flag RFTYPE_MON_BASE, which contains the files required for
>> MON group only.
> This appears to be appending an unexpected (because it introduces an unused flag)
> change without motivation as an afterthought.
>
> How about:
> 	Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
> 	complements existing RFTYPE_CTRL_BASE and represents files
> 	belonging to monitoring groups.

Looks good.


>
> Feel free to improve.
>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> The patch looks good. With the changelog cleared up:
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks

Babu

