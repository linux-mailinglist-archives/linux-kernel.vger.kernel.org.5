Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341ED757CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjGRNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGRNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:11:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14BEE;
        Tue, 18 Jul 2023 06:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSWDw7m4Dx2yQPmhUw2TplaXUtt7NILii4t2fr6f+3jZohW4uMrHtxegOfsIGm2+fbt4nN5NRk+5kSsJ4PciIpvAOHQBGYGEFQysPEs9ljE7tNITeAy1BXjjn9XgrGdUyUNlFlGPzUjYydUNI4ZCQVjouGzoS2Bg/eSW9v9/uOdecHohuf+eHizPWdToQOUzsZvkQVRz0gVL1+pv/9EdwYzxCmw+kt3heP0/jg7wYyzTQxnk0rx6x4l0r8ppP+yPwql/CBgGu2OCaVCEW+FjNJCHzJfPzf9R8MtAHUwtEvWy4CFjVkDzZ7UJHg7yVBrnRBlgzoT4geVVjuGUsb3Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seJcjzM7h0zn2L96IjJnhDMgSFAxegxaAjYzbW1ut9c=;
 b=dh1aVtG+G5iNiO5fI6OSAsPCw2nDw3DLg7Ureml2ViB0mLZ7yGxycthaAO3HFxb8mG1jNwzNGg1qcAE2sZWpM8vPYaAZ343NPbQHVVW5fRR/iHEMso552ItK7PhAiqSLojUPXIzwhx3dWaC5xygbvLLti53aI+DEpZ3jstS0MpISmFEUtlDAx666N0G5NmbuVt/O5Rp9g5ZBnCKn2m90NanQCWwJVPL8D/z/+J14ZDvScyn7mnPhDyPyTESMClliqg2+HA3b8SP2vDU5zpuqS+VUaL/oEXUt7UH6dFYR3zh86ll4xrsz/TK3Qv4NYsrxNDLhBFqXhtDkQf9cTA90wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seJcjzM7h0zn2L96IjJnhDMgSFAxegxaAjYzbW1ut9c=;
 b=rRkNpwwuS1L6TmoNhYblBHbK3U2GU0smhI0SXmZwzNIRluYg+rJ6X2Q9kR8WPUUy5tO6K35FGd+le/WOk/k5Ab0XaCL/JKYFpHmSUQ0Ir0/kyDQc5Tt7zg4GMmwgucl/ar3NFDX13n0CB1gpP1FeXXly16l/J8CzQtthiGMMK9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 13:11:14 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:11:14 +0000
Message-ID: <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
Date:   Tue, 18 Jul 2023 15:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
In-Reply-To: <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 9059bd37-9d02-4614-c383-08db879076e2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxKy2axj+DM4A1kQNsNB1Mbbq8A6CjRLapCxJftI7PozBOpIht4NjPBHHjxzWNJ6CNrWV2m5Hb7tG/adEHbaHWmDwIgLI9lGXAgdVbwW2M/J5e2RGuD7MA/o9VkKIZxyLY50ugXDrmmT4PJjUgtmzu4PWI7SNWE4vz+up3/OjkpaxJorKUTC1vF7+Ti6XDd9+bRaezTFC/DMxzmhpnAWSxujI6pX2zyqmaIGBjl7gGUWh3La58YXhTq1Z9qjfGbxrqe3dGq5zlvyqM71grm9ldaiRjkZWZ5yagnZa2bA9IuomgaU7Ehc+eSf8KGtZcJkr9TyLOgMX1N3zgUtX6wzKB2wWTPTKbQ/hK7ipKPVJTgcDDVVH06bQACWXncmdiZOtZUciyw9B4jd9+dNO2rbWPq5gqyeyyQm6+p9sq/kxpR9/C9ZUKLkCyUDQs7ekCFgGLU0HPra0nEUny58ok47YtwW6WLBbQVT9qENYA5kF3gyg10wrMTM9Lwu7/2hVWTd5HQO27s7c19484ZXjE+uEa6Zjr2C1runx6vQ0sWk3w35vgpZLTTpgsDjCJIV/LEolNTI36btJfVunONHlWQcTqybDoh1kB2/iGSCVzX3WUEPlHJlgEJaH7RSWhhfZc7xMCBcgyIaLgPW5z5Ub1Hg0DgDMVN0BtaIVHzbXQM8qQev1uNvVUKg4CpoZg2eVS7U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(6486002)(38100700002)(6666004)(110136005)(41300700001)(8676002)(8936002)(478600001)(316002)(66946007)(66476007)(5660300002)(66556008)(6636002)(4326008)(186003)(83380400001)(6512007)(966005)(2616005)(6506007)(26005)(53546011)(86362001)(31696002)(36756003)(44832011)(15650500001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE8rdmxzbmZYb0xlNkFaUnhwdDF2cWZkSXRieVVrOXdjbmpXYTNiWURmNC8r?=
 =?utf-8?B?QjdCTk0xVE5NT0cvY1ZSS0t4eis0SXFockE2aDdBcWI1UUNDdFhpeS9qSEc3?=
 =?utf-8?B?aTNlblNGMTlCNm9XNFppMkJxZ3dUOVVtbjZzQlQyZEFDVnZLZU1vRCswNXY5?=
 =?utf-8?B?cXp2RGlBU2hNL3cza1ErSXkxTGc0L2lnbVo0YzVEOE00eDhNMHBibENpUURx?=
 =?utf-8?B?dDdWdkdTbmxzNGtlaDcrdmdvOUtYTVJwTWhYd0p4S0ZuSHB2WlBFa21ZN3U5?=
 =?utf-8?B?OWxzd1IyR1I3NXJueWdqMHFKamp6anYrZTZESnZGdGxqdmR5TUVDNWNZTjV1?=
 =?utf-8?B?OUNkdm4veE9EQmNNOVgvVk1Pb05XODhMRlVHa3Y3UExab1RmS01wMWlpa2RE?=
 =?utf-8?B?OFhocnBUVU4wZ3FjYVNKVjR0RCtDQmlWTXJTVWR4YURIYko5N3lUWG1Yc3ZD?=
 =?utf-8?B?L091czNVRGJCN2pXaGsrM0N4VEpqMHdaOFhlTURiR2R3eGxIdHFhSzF2VTBY?=
 =?utf-8?B?K3JEaHBzVFdNaklCc0hCZjRhYlZuNjVPVmI0M3hVME05NTQ5Vnp5aGpnamcw?=
 =?utf-8?B?SkF5aUtyOG1EckxIek04YUZ6dGZORW9WY2NqWlNQVnJBMTdBR0RTZnZPVGNU?=
 =?utf-8?B?enhPNFY3QWZRYk1HWkZzNmg3aTUwNzdQNVJ2RXY2WENyN3ZMa0hEWVN3K0oz?=
 =?utf-8?B?OXV2cW9wSEg0eStmZ1Jqby9UZ1lLYXMxVGovTVhIcEx4b1NMeHYySmwvYURI?=
 =?utf-8?B?WUNEZkVaajNkcEhZZWlRb3E2bGMvVDRuYUJGNmlLdldPNDBxaHZaL0NoTHpR?=
 =?utf-8?B?QUtidWhnMmF0N0NEVERWNlR4eGthVjZhMEdwN3V6SEhveHltUW02SU40dFE5?=
 =?utf-8?B?cHYzdER1dEtUMDFqL2pjMEIreUcrWUJnSjhLdHBzYjZ6aTJCSjYycTZMUUhv?=
 =?utf-8?B?d3dOSzhibGNBbUtRRThBTy9DbjUrNjJFVTB4NXhBWjBSdzVuQ0s5NzUvRlEv?=
 =?utf-8?B?ck9sNVpKMjBKWXVRS0pHT3pLazRqMFlxODhWd3NQbjVmbFAwRExLZERGSko1?=
 =?utf-8?B?VWVpSXQyNlBqVDFQZFgxNk1MYTZFV055V05McmJWakZPMEw1bk1sbVcwMWFz?=
 =?utf-8?B?ZFlYY0NESHdVcnUzejNKWFZNU0hwS3Ewajg3R1plMnhHRFlPTFR3UmoweU9Y?=
 =?utf-8?B?dFI3NEh3QjQ2Ym1rQm9Qdnp3Z3diNTRpMUg1bmhSZ3NpdjlLOXFaZlh3cHR1?=
 =?utf-8?B?bFFieWwwUFpzVzZXeFZpbis1QmR1b1JpV3VxakRsdmxTY0VTVkNVWE9rMHBu?=
 =?utf-8?B?dE9XYWhxUE9qSW5ybFd6ZlJDaGwrejZFSEg5SUFTYWJiWXlhTFptcUVMeTVr?=
 =?utf-8?B?SG9oMllNcjB6WnlwM0xMSFF3Z2JxakRvOGl6SVpGTHcyM2FsQUcyekhxeUJZ?=
 =?utf-8?B?OTJaY3NpUmpEclBxTXRXYnVSY2UzdUhhTC9vbEVGM0xPNFZLOFNWL3cvOHVo?=
 =?utf-8?B?RFdCUGFtMlJoOFRWbzZnRGxUbVpEQzZ1aHdtcGF5TitkOC9naW5NUmZ6dUpC?=
 =?utf-8?B?bWdXcVpUa3BPVGpZcm5ZWXV1WHp0RkdGbE1qbllhdHMxSUJsVDZIUlIwWjhS?=
 =?utf-8?B?QzQ1dnZnWmU2M093bkdMeVJ5VzlEYmFaUjFZdy9kWHhJZ1dLSnNLK0taazFm?=
 =?utf-8?B?VTYxbnZVS1J1T1lqVzArTmkwSXNGcnppRG1vZlFpYTZWQWdnUmFrOWFNcGgz?=
 =?utf-8?B?VStiSkpXRytKMmRudFVYYzZlU3RDZkJwbWhHbXBhRGdBRE9ZMTNzaDNZVXJj?=
 =?utf-8?B?b3dKMnd2Zng1SHl2Mkd3dHY3VnlnYXFsdm5HcTBKcXMzMldrSmFnTDdnZTdN?=
 =?utf-8?B?dURRMGM4K3h2QjRIcDNaYUNDZ3NWKzk0dGhlQkRIMTZESGp0bVJVUFVGWkZ4?=
 =?utf-8?B?SWx0bWNwOXp3Wmh3ejY4clg2SEZOazB0Q0NUOEFRcmsxUkxYd2hyWWJnQkdD?=
 =?utf-8?B?cWtHVDZ0VGg4QjR5WDAxeXJTT2l0QVRnZExEZCtxbUJ6VDNkNEFtN2hvUzFI?=
 =?utf-8?B?bnpoUXNFNGFsV0RWMjExYjB3UmtTL3hOQ1Nldlg5MGFvZEQyTkdUbE1tSnp3?=
 =?utf-8?Q?1HoO+T6P4yPRdavpuwEwKl6IS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059bd37-9d02-4614-c383-08db879076e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:11:14.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CT+FKWLWziaMUV+7OTV521m/8o7WC/QR4j7MWOPN6Il3D5WhX2UaHHHKrbfyz+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 09:39, Krzysztof Kozlowski wrote:
> On 18/07/2023 09:10, Michal Simek wrote:
>>
>>
>> On 7/17/23 22:47, Krzysztof Kozlowski wrote:
>>> On 17/07/2023 20:40, Conor Dooley wrote:
>>>> On Mon, Jul 17, 2023 at 04:53:47PM +0530, Piyush Mehta wrote:
>>>>> Added documentation and Versal-NET reset indices to describe about
>>>>> Versal-Net reset driver bindings.
>>>>>
>>>>> In Versal-NET all reset indices includes Class, SubClass, Type, Index
>>>>> information whereas class refers to clock, reset, power etc.,
>>>>> Underlying firmware in Versal have such classification and expects
>>>>> the ID to be this way.
>>>>> [13:0] - Index bits
>>>>> [19:14] - Type bits
>>>>> [25:20] - SubClass bits
>>>>> [31:26] - Class bits.
>>>>
>>>> Riight.. I'm not sure that describing these as "indices" is really all
>>>> that valid, given only 13:0 are actually the index.
>>>> I'd be inclined to say that the type/class/subclass stuff should not be
>>>> part of the dt-bindings, and instead looked up inside the driver
>>>> depending on the index.
>>>>
>>>> Hopefully Rob or Krzysztof can comment further.
>>>
>>> This confuses me as well. I don't understand why do you need it in the
>>> bindings. Nothing uses these values, so storing them as bindings seems
>>> pointless.
>>
>> Power Management team wants to use these NodeID with format describe above to
>> identify that elements. And I already told them that ID (0-max) translation to
>> internal NodeID format should be done in firmware but they don't pretty much
>> agree with it.
> 
> Too bad for them. They can join the discussion, though :)
> 
>>
>>   From DT binding perspective I think it doesn't really matter if numbers are
>> from 0 to max or they are from random high number to another random number
>> without step equal to 1.
>> And it is driver implementation detail if driver itself is checking that
>> requested ID is bigger than number of pins passed.
>>
>> In connection to reset driver in Linux.
>>
>> Core has:
>> static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
>>                                    const struct of_phandle_args *reset_spec)
>> {
>>           if (reset_spec->args[0] >= rcdev->nr_resets)
>>                   return -EINVAL;
>>
>>           return reset_spec->args[0];
>> }
>>
>> /**
>>    * reset_controller_register - register a reset controller device
>>    * @rcdev: a pointer to the initialized reset controller device
>>    */
>> int reset_controller_register(struct reset_controller_dev *rcdev)
>> {
>>           if (!rcdev->of_xlate) {
>>                   rcdev->of_reset_n_cells = 1;
>>                   rcdev->of_xlate = of_reset_simple_xlate;
>>           }
>> ...
> 
> If you use both, it means you don't need bindings.
> 
>>
>> And zynqmp reset driver already defines of_xlate function that's why checking
>> against nr_resets is not done as is visible from code below.
>>
>>
>> static int zynqmp_reset_of_xlate(struct reset_controller_dev *rcdev,
>>                                    const struct of_phandle_args *reset_spec)
>> {
>>           return reset_spec->args[0];
>> }
> 
> Exactly, there is no xlate. These IDs are not suitable nor needed for
> bindings.
> 
>>
>>
>> And actually Xilinx Versal platform is using this for a while and you can find
>> IDs description here.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-versal-resets.h?h=v6.5-rc2
> 
> We cannot fix existing bindings, but we can fix future ones.
> 
>>
>> Xilinx ZynqMP is using IDs from 0 to 119
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-zynqmp-resets.h?h=v6.5-rc2
>>
>>
>> but IDs itself are shifted by 1000:
>> include/linux/firmware/xlnx-zynqmp.h:217:  ZYNQMP_PM_RESET_START = 1000,
>> #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
>>
>> static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
>>           .reset_id = ZYNQMP_RESET_ID,
>>           .num_resets = ZYNQMP_NR_RESETS,
>> };
>>
>> static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
>>                                  unsigned long id)
>> {
>>           struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
>>
>>           return zynqmp_pm_reset_assert(priv->data->reset_id + id,
>>                                         PM_RESET_ACTION_ASSERT);
>> }
>>
>>
>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>> values it is up to code to handle them. Checking nr_pins against ID is done in
>> core but it is up to drivers.
> 
> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
> and have representation in Linux driver. You do not need to define
> anything virtual in the bindings.

Not sure how you define ID itself. But HW doesn't know ID. HW knows only 
register which you can use to perform the reset. It is not really 128bit 
register where every bit targets to different IP.

And this is SW-firmware interface like SCMI reset driver.

Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
Their Linux driver is asking for nr_reset via firmware call which can be 
different for different SOC and that's fine and I have no problem with it.
But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different 
SCMI server implementation can map it differently.


>> In our case that IDs are coming from firmware and driver itself is just matching
>> them.
> 
> So they are the same as if coming from hardware - no need for IDs.

It is hard to say what hardware here exactly is. From my perspective and I am 
not advocating not using IDs from 0 to max, it is just a number.

If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to 
reach my goal which is reset QSPI IP.

If you think that we should use IDs from 0 to max NR I am happy to pass this 
message to PM team and we should extend any SW to do translation between.

Thanks,
Michal

