Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442E78C9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjH2Qr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbjH2Qrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:47:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12D4B8;
        Tue, 29 Aug 2023 09:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV2wFNzjiLqhOnE7NwCzomw0fx+7X8bPNzhvR9bthL5rozsUR6+Xmewo9YDvknFEN5y3vh8+gCvoULTumjFs337zUum723K7eJVBF3TPnmm43kjlLYt89Cl+m5f1pId0ZkHKbkF6jcgRZIqRA6jLVw5D6jFZNmiM8Y9iKfKI2XSJoq8w4cN6w5kt/+45iXzjBgRs7dDzTkFcDQr9U/faraOLi9bqwyTY9j8kgv2460imgylStlkMtcIP7W61isN/usdD1+h2aMHeWFDsmNX3msI7qpSkHdXHFg5yoSnyTHXFDZQ1YFjKCbxaGIYmuxdNksPpUDugyb8bcejX9KydUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIzoPCxltYc5ZoZ2XYb+k0u61gHqgHgmP0QmnEPvrtI=;
 b=Www0pXvk22vA+QpclxHIunWcpRMALoVLd9cC7q3sHKhwAsDwetTc3B7Wx9Nyx0T8Vc5RqHrcHKL3nQ/Kgo1CnkNLILLNarMaCgYF+IItJrJGDmxejrsJlW7eX/ll1BAmb5daGrjnT9tQibemkuLZe6PlrnYInn9A5ZvjQKtyghcc6c9hDsII6/+zUOoX8FRTBUJizYw0LoW+Lh4/zufcOztcOecXBmzJ4PUq5Iu1ZA0+Kqv4b2JthE3m7JZYnQGagyUp1Ep0FUODKQ2ysd1633eeDSoc6wyV9o47q0Jber2SY5Fwzjd9GYVjP8c3ZBoBIpfhPb4fvhazFdtXSJZrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIzoPCxltYc5ZoZ2XYb+k0u61gHqgHgmP0QmnEPvrtI=;
 b=um/29hRWsxW8iyTgPX6/bCFQU99TTFep1au1nLtv0UqwLz+NdGCp/hsVqh+woyfb1vzRl3u9iYzqM6PylAtr7FeS5fT256jGqtSUsE+vXzMIeaQPtYAVXGjUa76BPnDFECGHrGC9g2Y5nt3cOs7Yd9oe5EwO+gkhThilkn8iVDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:47:48 +0000
Received: from DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f]) by DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:47:47 +0000
Message-ID: <92ed14f5-d999-4d54-915b-0a3449da44f8@amd.com>
Date:   Tue, 29 Aug 2023 22:17:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
 <0f16dd5a-bce7-0e36-3827-f713e90fb843@infradead.org>
From:   Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Organization: AMD
In-Reply-To: <0f16dd5a-bce7-0e36-3827-f713e90fb843@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::10) To DM6PR12MB3818.namprd12.prod.outlook.com
 (2603:10b6:5:1cf::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: d83f4d8a-0c45-4f32-b4e2-08dba8afacca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IabL8ah/UMvPLkyC2HVMuKH3AmWNZotXjBSd9T+Vt9+diGikA7EP1FnErdaSOynrL1sa8NrpeJrIvxhvzbj7sk8RRysYkB0NOcmkrqDO25WH7m9/KXr5mVhsb2cY+6uMEljXGWHXmhdGCfzETN+rJ/4YEEOslHSXPBRdD10yTmCKiP53P3sRN5Rtb7J315S8NhHhH/GuTs0h0e9Tj5BtWBBs6NpU+34ti6WmiCWP6bf4VxqNm/xh4Ncyqxjgx+Z4E3KqK9NFZ1F+hn+dttCM7TIM/oxJc+nbswCEDAlZv1os3Yxe8FHy2FhnVGJhHNqb4x0adizZfgRRKY+ilLraZqp7wI5ZPLxDoVrZ9CnAAK+CEWRiNCNWG1/cG5kNAy9fzr5BUWQ0Vr6mlE54AAUkve46u/tgleGzqoSB0lpTq93gFDCC8l+lfAYlOUBqu5CHdsfBN9Wc257ABxjpsOd520/o2mup47ijpZpk6y048jdoA2QUsHMds2Xt+blHYFMR+R4Axe8tyMzNO64A3U4UPPIei7A8t40wedDpFabQAETIfa6/hrP6HbkucruE8Jva7dVzo1xU77tbwFO9j611ZU6GioMyxyEW7nPXe29V/0x+YCm+reVhLlQtar3VOiHAAA0sJZS9Lh5HWGXTfDndcZvXWdmDvyziQcanKZc0QAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3818.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(31686004)(6666004)(6512007)(6506007)(36916002)(6486002)(86362001)(36756003)(31696002)(38100700002)(921005)(2616005)(478600001)(2906002)(26005)(83380400001)(53546011)(110136005)(8936002)(54906003)(41300700001)(66556008)(66476007)(66946007)(5660300002)(8676002)(4326008)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJkQkhuZTdHVTVLMHRJVDJGcG8rRnhTK2JjWGl2ZFZjNmRLQklGclU5akRG?=
 =?utf-8?B?N05La0FrNjdQSFNTNXdTakVrU0JZUkFYY1lxRUMyYUMwWUIyM3MwNktURnl4?=
 =?utf-8?B?b05JcmIySjdtSjhZZTcwU09nTmpiOUhKTmdpQnBmQ2t5YlZJWFpaTHdLWmM4?=
 =?utf-8?B?UjFLZ3FnQmJhSXZMRkhKTG5XNks5M0RWN3o0ODdYbS8yYy8vdCt3ZXYwQ1VG?=
 =?utf-8?B?UUdobDZSTy84c3pKeEYrb1NxbzJJTW1DSlM0cnVoRkZGWXk4eUdNZ1BsZkNM?=
 =?utf-8?B?c3htNUFIaXBuTGJ2QUlyS0lOMk1VYy9yQnU5Zi9XeHYzcFZsM0RpaXovVlUy?=
 =?utf-8?B?ZWpLSXlHbGRxb3FzRVprT282M1hZblNHdE16UENvRmlZSEp5Vm9iM0loRENv?=
 =?utf-8?B?RVhWRjh3ckJKZ2U0cGxMT0Q5UXRlRnY2VFB0TmE5S2pZdkU2T2pMazBFZ0dh?=
 =?utf-8?B?SVdJVnJ6MkppYlVwaCtueWtkVE0ydFR1Z1haYmVwbUlvcUdpNmlha1E2Z0hp?=
 =?utf-8?B?a2xEYXZ6UUMwTmxjS3g0K0daSGh0MXhzbW1DTTVaelVuNnpYazVsMEszdDN1?=
 =?utf-8?B?RjlNVTdFM1VUVk0xYTBsQ3lSbCtvYk40ZXFtUE4rN0tSSi9Hd1g1Q2d2L1B3?=
 =?utf-8?B?VjYxVkVqSTM3Tk5MV0p3YVdIbkRiZ2tWRnQ4VGZzY0FZZnFEcXN4b1pjRU9E?=
 =?utf-8?B?MEFhRUNlS0Q0R2g5RVFUZTdGR2dtaFR2NmNTNnB6VnhkWHRXbUtTVC8wSWV2?=
 =?utf-8?B?VGt6ZnovcEZGVnVNeks2dVVwK3NDc1ZwZ1RsSUFuNjdXRC9qcVM5aDZUdE5h?=
 =?utf-8?B?Z2svVS9QVDMvTXFhZkFCVTNmNzUzRGRLUzQvYnhJK1YvdVI2Uk9udkhtUmU2?=
 =?utf-8?B?RHp5S2k5YnNEbWlhQnJIY0tERE8xV1VWaTVFRXJDSjFhYWpjUzZkMWh1cVlF?=
 =?utf-8?B?Z0VEaHJyL1FUNHFnTWRudUwyUEcrM080bSt2Y05ObHVlT0lrVG5GMGhBTGYy?=
 =?utf-8?B?a2g4U21JV2JrMDQrOUFldHQybFpkbjl0RXJXUXRQQ05WeTducXd6YzI3L0Q3?=
 =?utf-8?B?OWRSMklISlI0MkQwNDVNdktmbnpGaXJpTUpvZlpxTnBuRDk1Um9xQjFnOXl3?=
 =?utf-8?B?a2VwZkIzOUc0U1A5UWZIdi9aS1o3dWVqMTZ3OWxvbEtCZnc3bXhJakpiY0FD?=
 =?utf-8?B?TnFLWUxkZmFjU3ovWkFncjRocUVNeVBPaTVDdGJYWU1PSWhGeC96NXl1K21M?=
 =?utf-8?B?L2wyeGx5ZkxpS1dWeU5NNTRia0Z0NkZ3SStQNVppdDVldzFnSy9GVFBQQjV0?=
 =?utf-8?B?eWozQW9aNERzVkFxZXNnOHVBQUxiZ0g4ZHpUcmhHRUp3SDFxTUZkejNHempi?=
 =?utf-8?B?bk5uaW9kYUVHOEw4M01kYUpXLzhzVjl3VUV1ZVpXNDlScFBwU2FrMVl3TFFQ?=
 =?utf-8?B?TFp6aEVwcjRUWjFuV3hhZUxmNFUvSTRhN0VUVmI4bnJGRDlKTlNuWEJDMXVw?=
 =?utf-8?B?Y3ErU05KTmppaG81dUc0am5GREF0MnlnZGYzTDJnVVZTenR6ZFZzSVYvcW5k?=
 =?utf-8?B?RDZGOFBWK29lbmFrNTFmQWFGakw3UnhESHpJSWwzWUpmeFhsT2I1eWljMlNY?=
 =?utf-8?B?YXlHODczWUZ0VmV1SDBCWFUwTkdXOXVDck43bWNOVHZsUUcrSlFqdGRsempO?=
 =?utf-8?B?ckF1RlBCdVo0NkR6MHJ1TTBCRkZDVkJFOFVJbEplajJ4UzFMNTJTSnFuMmx2?=
 =?utf-8?B?STRXSG5JQVMzRGVvcGhMb2tQa01ocnBic2pZNWh5aUh4NVBuMk9saFBXYVpP?=
 =?utf-8?B?bmZGL2VBRXQ0MHp5MUl5TDRBL242TFVVTm9CbDZDUmwzeGY3enZRbXp2WlFG?=
 =?utf-8?B?cnU5YzY3S2JERUdncHcxZkVlY2NOei9aT2JWMTltaFFKdkJERUl4SjJwejZx?=
 =?utf-8?B?MjRwTXhvbkVYMGJqcEg0ZDY2V01UQ0RKM29hNW9ra0NCS3U1N0VTZDRyazBa?=
 =?utf-8?B?UTR1My9hczNjdVhyUHlkeTBWbmZoQjNiekhsWFBwV05lVXJOQmYvWHpzZWNh?=
 =?utf-8?B?aEswZ0ZvNFV4NDJ5OWY2YVRncHdhSHlzN3p4enpicnhLdGZvaWhTVW1vaWFR?=
 =?utf-8?Q?zzWpXe3T4RERMygX5zYkdLnrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83f4d8a-0c45-4f32-b4e2-08dba8afacca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3818.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:47:47.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVWEWwlrTfkyIhOrSnC4jZusQmvlwdavc3S3I3kQfHuE3jm1xVEPv93vPtsRzC5aN7M7G3XCiTYDR76eo9FbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/19/2023 4:34 AM, Randy Dunlap wrote:
> Hi--
>
> On 8/18/23 07:42, Devaraj Rangasamy wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 722b6eca2e93..5e38423f3d53 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -363,6 +363,13 @@
>>   			  selects a performance level in this range and appropriate
>>   			  to the current workload.
>>   
>> +	amdtee_cma=nn	[HW,TEE]
>> +			Sets the memory size reserved for contiguous memory
>> +			allocations, to be used by amdtee device driver.
>> +			Value is in MB and can range from 4 to 128 (MBs)
> 			                                       128 (MBs).
Ack.
In updated patch, we dont use new custom kernel command line parameter, 
and resorted to generic cma zone.
>
>> +			CMA will be active only when CMA is enabled, and amdtee is
> 	That could use some improvement. How about:
>
> 			AMD-TEE CMA will be active only when CONFIG_CMA is enabled,
> 			and amdtee is
Ack, as above.
>
>> +			built as inbuilt driver, and not loaded as module.
>> +
>>   	amijoy.map=	[HW,JOY] Amiga joystick support
>>   			Map of devices attached to JOY0DAT and JOY1DAT
>>   			Format: <a>,<b>
>> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
>> index 191f9715fa9a..5843c739a7b8 100644
>> --- a/drivers/tee/amdtee/Kconfig
>> +++ b/drivers/tee/amdtee/Kconfig
>> @@ -6,3 +6,12 @@ config AMDTEE
>>   	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>>   	help
>>   	  This implements AMD's Trusted Execution Environment (TEE) driver.
>> +
>> +config AMDTEE_CMA_SIZE
>> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
>> +	default "0"
> Why won't this default value cause an allocation error message?
> Maybe I'm just not following the call paths correctly.
>
> It looks to me like this causes a call to
> cma_declare_contiguous_nid() with @size = 0, and that function says:
>
> 	if (!size)
> 		return -EINVAL;
Ack.
It did resulted in error message. We have revoked new exclusive cma zone 
now.
>> +	depends on CMA && (AMDTEE=y)
>> +	help
>> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE driver
> 	                                                                          driver.
Ack.
>> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory from the CMA
> 	                                                                                 CMA.
Ack.
>> +	  The default can be overridden with the kernel commandline parameter "amdtee_cma".
>> \ No newline at end of file
> Please fix that ^^^ warning.
Ack, as above. Thanks for the review.
>
> Thanks.
