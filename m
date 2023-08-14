Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C377C3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjHNXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHNXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:33:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369EAF;
        Mon, 14 Aug 2023 16:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3vCh4TpPepssEn4y03FEKYlGTXj9bFvdN0kBfXBCe0aPsphab5TfvOSFT4jkUzoSkkVgWxKBfPnE9KnuPiSexn+PYVOepYekbu+4WF7Ot5K+w1U9CPIciMcxYEutKU61xXSlVME98S7s8pPXeHw/VYwTWwTA8M7EJ6Q4FbMBPnyn3OuGHxJSzTnCePjIpkMV9619Ky1N7hB8MZR5Mbb7kqKNgVfV90gPLjr5mQSPkpQe1XHKvsYw3xpJLZKhlFxlULLjENa3b5kf2Na7JTJWVJ65nrhhnCGo7dwahjG0/u+wlnvvBykmagySlIO1BE3/YbYRji0AeYbPSroNM80cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoOtmUNMRrXxNGz5v8fMBSk6FegMQ1BK3zeOCOOhWMw=;
 b=KWQ7MaO26Ncm9IJ0xOi09BiGGS1O+Ps/vikZNro6uoeug0qH7LG3BZC6QYGz2QbXpBUxpQFat8nOLwzp56TaCDJOe86Rk3uXp4ciwQkJuS2CPkHVOQHnBDjVvf+XMbDuvNvkMhK/QxJzzG72sT5+uF43PQXaDAtoZBE/tiPhlHLzJsuoFInHbVDWSYQUL0cD2PkBVr3ytoGPslP7KWTU3+C9v4IQVbQa9WFPDex/xUxmOiaOIDnfIDKHhEVGjViNHZPLmmf42IhtELi5yztcFVRiGmSaq5Aig+kVJvnY8ijEFPs4ObgNZlYnrHXmm/FNrzn+JTSQ79KNTruNHk4VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoOtmUNMRrXxNGz5v8fMBSk6FegMQ1BK3zeOCOOhWMw=;
 b=W6+0ZvmXHC1vYHSPX1IgmFEbdF/+BUL/xCCRjhFkW3hVR+0UGO1GTYjFG9fDGqHZR6moKEpv3w91NLR6HtbZ0E6Bf79U7LjoMb8sUXBwqq4OSKnanf3vqxNfaw6KWtNh4HAb8XjkNQDRc1M7vbJtRD7sQNgQb0/5P9B8KzMB7Zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 23:33:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 23:33:06 +0000
Message-ID: <764c49f6-0dd4-4bc0-8d7a-3054a5d75999@amd.com>
Date:   Mon, 14 Aug 2023 18:33:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
 <ZNmqQkOK7CLa7TNl@amd.com>
 <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
 <696c34d0-3de0-4f56-8003-eac872298605@amd.com>
 <62da8b7c-3a90-cffc-4750-532c2b440764@linuxfoundation.org>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <62da8b7c-3a90-cffc-4750-532c2b440764@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0332bdc3-daba-41b9-c33c-08db9d1ecfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TF7uCVvAUCO6qT9GOL4K6mtYg9fEfBMBAT7hes93msSOoV1SpqZFJDMg84yqUOGKe84DtXm+MnaBXZbWulesxcFTTzOnx8PWHkp5hiUlprpDZqQyyCOJGmSucroKh1iYYA2YH+CH9uEElU6kwk8cmCyw4wed029PE3BX2DsIfkiuWjR4MCbX8Jay2fLZrbvqJ0fqnJKQrZTXm4U49giJQvsMv6divF26je0DGejEik5oPD5jOPMz9nUwXEvRON1VYJRA1P0N7uo/YGfE/mG3egeEwD2/CghLXudvX76CLSSbQF9cFDyq8wlZ4WVfSumKQP7rXz9jZ85AIzCDc23IqVUMJzL616F771dP7NmHFnEct9SmS9Q8NRM3DLa4QGGm4XQ+DiRwkK2rNb89bJwzyt7z3hEEqYrNijSJKxUBTfbjVVGdJMu0AWueDkh6ygCmmoFZkXzhSvj0j5QZdGvH7pJsBkh4Umon5mIEW86IFgpAJdPHO19Llt5WvCJHzyJxzGuBYXl1yQ4r/zngTyb5koha2gVV0sg2CWX9Po6y4DvOJJz6NY8iirBlZV0nysK0DHW/9wBMWPhad4ab+vJxkYtXmV/iV1TRS8VIWbx479SdCWlUHV4YEuokkQ62K/Rq+chu3wno5pwRX1G7axIPewwDE9lZQsb+dneFgPyd1oyA4QJsE+AJeoRV3TY5ZOS1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(186006)(451199021)(1800799006)(4326008)(8936002)(6512007)(86362001)(966005)(478600001)(6506007)(6486002)(53546011)(66946007)(6666004)(110136005)(6636002)(8676002)(54906003)(66476007)(66556008)(316002)(41300700001)(26005)(36756003)(5660300002)(31686004)(31696002)(2616005)(2906002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVA5Z2JiWE8zQzExUHhzQnZEWjBWdyt2cnF4NE1zcG9vR2JERXV4cFVnVlN0?=
 =?utf-8?B?MlZnS21SY2dsVjVoeUc1bm1wNThPWnBxVHpwZ1JaWk04VFdLV1Z5cFByaXFW?=
 =?utf-8?B?TTFZNzEvVjVDa24xOUZKWGRQa1Y3cDNxODFNbHhEZytHVEhJaGtWbjh6OVZm?=
 =?utf-8?B?UGRFbEZ4c0x4bktITFdhYVF2VjVwKzUvKzRNcTN0SDZTMGRQVDRZN2MxS2Rx?=
 =?utf-8?B?UkdjMmhhSUhheS92cytBTEE4Mlk2V3dXT082dXhrRjdoN2xYd25oODQ4MTJX?=
 =?utf-8?B?Y3pVa1Nkak9CQ3UxN3FqTmZORldRREQyMVp4ZWd3UERFU2t2VkxtZFMxZEFz?=
 =?utf-8?B?QWZTaDVsWER2aTJXNzVIV0dUNXVBZWNnWlk0MWpZeEtXcGVpR3dXbHhXNmM0?=
 =?utf-8?B?ZkVubXI3aFgzaXdZaFB0ZkNjbTFCL1FqdmM1TkFWd2o1TDBxRVRTWTB0RU94?=
 =?utf-8?B?cWp0RUZSMTFWeXNTWnBQUVY3Nm9pZXNMRys2eVluVXJ6ZGJjbjJVSkkvdDhP?=
 =?utf-8?B?V2ZNNlU2Q3NqSTloall1bDJlY1R4WWNmbmRNZHdmQ0ZoNkNRS1V0bHYrczM0?=
 =?utf-8?B?RUFmalNHR0Zjb0tLaUJwQzd6cU1TKzAwWFhFRW9oTmlobitTRTlHTFNiQXVm?=
 =?utf-8?B?OXpXbzJUVkVxU1llM1RaU2lSNzBVaFpkWjNQNUw0MVh3Nmd1d250T0VOS25X?=
 =?utf-8?B?bDRuSWZSQXpWWG14YTJRZ25mMlR1K05FZE5SQ3FLNFBDZEZKRHpuaGhCWnJD?=
 =?utf-8?B?RllGbHdOY3JvaXVXTU15WGhNbnh0TVFQQVF1RGY5enpsdE92eng4RC9hTEt3?=
 =?utf-8?B?WklTZWRDZkVsRzRkMDNuSnJtNWFHaHRpRjM0T0JIcUNQVWtrMjZWekQ5Z0xy?=
 =?utf-8?B?MEM5Vkx2a0oyQ0pWclVqMzlEVXljbTM0VUhEOUtFcFJ5dmJYaEYxRnQrbG95?=
 =?utf-8?B?VWdEUkl0bnZIRFlraFAyb0tSMlpyVzZQTmZjQ2ljMTNHNXd4NTNvckNZYnU0?=
 =?utf-8?B?TUt6dDJicDIwQ0hyWFNRNGpUb25YWlVwbjh2MVFoaWhzcUMvd1BTQktiVEFy?=
 =?utf-8?B?eGtjZktJMklhNUVCQWt4d2xMMTRmNlRmeXI1OWNyV2tPeVpyVDd2b3VyK2RW?=
 =?utf-8?B?YzRCc1g5QTVYeG5EQVc5Zm1qR21lYmdJUEZUQVZPZnRzOGFNUEh2ZFU2aVA2?=
 =?utf-8?B?OEVrMk1ucHFGZGZyQ0JDdFFXL3J0b2RSTkRDR3hDYUI2WVQvYzVQaXlnOUhq?=
 =?utf-8?B?dnZKOFUrVGhTK3FEbnB4MmpVRlo1Z2Y3UTVwQWZzK2dJdk9XZDBRa1ZxS05T?=
 =?utf-8?B?SFdCZXo4TVlOZVB4TngrZDM2OWU3Zms1Q0d5SVhaZmZON1pVSlBFdHoyNitz?=
 =?utf-8?B?bHZxWHBkOVVDbXpLZGs4VGdxTkhITTRnZGpHcHczSkJtRXN3VzJYTmFyRWFR?=
 =?utf-8?B?dERYNmFmdGhNZ3dCcnBiS0o0Nk42aUZ2NThyckJlZVo5TlA4VFBJUEdwbDBx?=
 =?utf-8?B?b2pmS21EQnd0Sk9Bck1tYkxIYkxyM2VkRGUxK1Q3N2EvRXJDMkRPdGk3QVRj?=
 =?utf-8?B?ME1uQVpCek0xN3dxcktDWURxU3pZdlczNFJwNklOY2RFSHZCM3c0ckxWcm1Z?=
 =?utf-8?B?aGRyMUl4Uzljelk2VWxRTlc0RjFlRHhCZlV0N0Fra000S1hNdzlFYXJUMUp1?=
 =?utf-8?B?aVFvdkF0a3pXZU1MaDd3MjNGSTlkVVBtdGNqSXk3dlVnUVdldThLWUxsU1pS?=
 =?utf-8?B?ZzAzb21vdXh2bDFwOCtjSDl1Zk5VTDVySEpzcFBkTlNUWUlhTXUrUUYxQ2Nu?=
 =?utf-8?B?b0J2WnVVYXd6dmFVTUFXQzIxWktJV2swb0JkNzhweFN3dUlTbHMzZWZHRnBs?=
 =?utf-8?B?YkFvbXNWMGNSbm1UN3pmUzNXUmxyYitNYXNNeXZGUmF1Y3pENmVTNzE5REZa?=
 =?utf-8?B?Vi9TVDR1dEhWNTFOSTdVZFBMWnlpN2hJZGZQRStlQ3U3dW50OVB2ZVpNWDhI?=
 =?utf-8?B?UG1tNDYyNGVYTW5kbHVJdEttQmUySGdha25uL0pCSlhlbktZYyt2NWF1WGgy?=
 =?utf-8?B?OUg1WTUwc2JpNW5QaC94ZDFvYWtkNGpNVlREOUUxNzlaRnlJMnZPVFZ4Mk5K?=
 =?utf-8?Q?0fHl5GYVGyWMtaW0evlXGfarp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0332bdc3-daba-41b9-c33c-08db9d1ecfa4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 23:33:06.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2X1w/Ty1zEu9GwYYhOL7/H+PPANIitzModRIRO4e17diQZo8ltUoapWycGQO54SiHxRXikmRcIY7AweHc826A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 6:22 PM, Shuah Khan wrote:
> On 8/14/23 15:50, Limonciello, Mario wrote:
>>
>>
>> On 8/14/2023 4:28 PM, Shuah Khan wrote:
>>> On 8/13/23 22:14, Huang Rui wrote:
>>>> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>>>>> When running in active mode the driver for amd-pstate has -epp 
>>>>> appended.
>>>>> This throws off amd-pstate detection.
>>>>>
>>>>> To detect amd-pstate look for the prefix instead.
>>>>>
>>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP 
>>>>> support for the AMD processors")
>>>>> Reported-by: chenhq2005@gmail.com
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>>
>>>
>>> This patch doesn't apply on top of cpupower latest:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git coupower
>>>
>>> Please rebase and send it.
>>>
>>> thanks,
>>> -- Shuah
>>>
>>
>> It looks like a variation of it is already in your tree as:
>>
>> a1cf97c2d43ae ("cpupower: Recognise amd-pstate active mode driver")
>>
>> Considering it was also reported to a kernel bugzilla, perhaps this 
>> should be considered for fixes?
> 
> If it is already fixed, there is no need to revert and apply your fix.
> Please close the bugzilla bug as fixed with the above commit.

Sorry I was unclear. My suggestion was that perhaps a1cf97c2d43ae 
should be considered alone for 6.5-rc7 instead of waiting for 6.6-rc1 as 
it fixes the Bugzilla issue.  Otherwise we should wait until it's in 
Linus' tree for 6.6-rc1 to close the Bugzilla.
