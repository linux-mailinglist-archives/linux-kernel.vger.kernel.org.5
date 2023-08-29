Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146EA78CED3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjH2Vhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjH2Vhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:37:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1FE139;
        Tue, 29 Aug 2023 14:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZAf1i82qCGEi41VkZ5iLEY/gq+AMMg06aUPtN0umaGerATyOhOQrfZc+AS0PO9lHICXE3h98dc/MxySnHs/4NYhRy1BUBp73Fa3FBMYoqzoIP1/DO/O9IGP6UdZ1UQe41/b5eifir9302mUKn2ZWLTWPWPLpsRnsTw4D9FkEpNkc3U6fqDxuY1d5BdRCJ9PF52d6ftX+l+JFMOzaANfe869M22Hx+i/+8EmXQqn4eVtZYeP/YP0VfKDqlGfHuNkMdU92VVMKj+KAntptmQVNR3DPu0XfZ02XpiPkltvwBZ2voLnbXUfShN5gWmQ38ufSVX37vp4oXMErKXwcoo3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQMRk/FYH/TIwhi/Kah0Idus+GW3ncSLlNQR6jizEg0=;
 b=k/fzX/W8DmUOrrLdvdBYx1g6nWPwHEopt+ubrM3bxhiYeUKWNLM0GkSKy8RpJFbTynCDzJbyK5OS90YUu7ijy48s5vb2YqZsw0Y2zF7j57sknfKQCwjjVc9X+klHixg3zJ41pbLQl4NUwgs1ZGmEEWgKxWzowklTnRL/gFAWUKFqxmasZnc6GcAbt5EpOU9Y53AG0MQ5quvQ6W3gjJOQJ6VOthHay/hM4lWvvuYkVbV/AJk6jTp+VnGfgRtx22MkK4K5AemUJXfEDy4Y67k7w7UuNCnt5P+GHZHzW13pu5SeYtHrd+k9CCryVQjrwPFH227iHqPE1iRtpiVTDIx5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQMRk/FYH/TIwhi/Kah0Idus+GW3ncSLlNQR6jizEg0=;
 b=0VKJLlHXjXxPTHsnm58w1wGNyheWnhEv8O3zrShzRhlbLDqjP+1pPZXhLw3+uFf8dJK3ZVCHxgIeawuLsAZMBGwzQY4OgA5El1rbj0BkVLhrP6OYj3nioOlhk1PJPRWSBjzEJPcR07yOuUNEQFQReGmDHhmfkvuFCA5M6R3xenY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 21:37:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 21:37:28 +0000
Message-ID: <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
Date:   Tue, 29 Aug 2023 16:37:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
To:     Hans de Goede <hdegoede@redhat.com>, linus.walleij@linaro.org
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:408:34::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ffb483-a7ca-48cb-a830-08dba8d824be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhmzzOgZHUAB8ee9G8mYYIOnST0rQ+wApyDJMd405I8pRfYiecGv1aYcrbvs6E2cgOA+9iMZU36vVRdPRxUb1BjwFN6wy3c2hLhMslDsbaiCnVYH35jfW/H92ZNEycygvavHZGUCJGvuji8kOR+sySdwoJgy5qXuUqgvCkObxmSm34RbAJM4zt9A+Ni52cAujIxsoyxa9xH+NYM9IHjNBWyXRM4j4c6YDGXKoMTKWyCJpX2xM3OPWA23OVaxRJCXb9JSBa0rZmbyMGv9oBMP1ytEqQKJLdj7DGTNwCoyi2G0wWrnuKCk/xBDfm8STPOnn+Q5TujDUFEWOM/dAVlHrXXOuX4yBn5auFC6FSu+lxgSuUVx0D4+n8LsGvXk2htlaWFzKiHu7YBAGML4vvcaXZr6pQMqzx0jSuUykCh1GFgGHzR5Zq4N91G3eWVmiNT6ZXyZmfn2kBBiAjgMVLBxnRcaQX3lSHYX3/0JijPbBD7zNbmEYLUxEAj71r+7bJbXjaQkJXiFGlQsqJcnuCahzp2caoIdK4aekIr032xBGJvrQThvcX5DoqGS7XL2+hMwT8Iw6jYhCqftx/+h/1u8DQpC5v2YVRo90XxE5UHDj5KLY7s94kUgPeRdsIvh9Q0ali+Pj/P6Yrc50/tXxJS5OJpApM2cktHrLAOGaegL9yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(6486002)(966005)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(8676002)(5660300002)(36756003)(31696002)(2906002)(83380400001)(2616005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJBbFdTZjgzZnZQRGVhaEJteEt3a292QndaT2FjVFl5dlY4eE91UFIwOE14?=
 =?utf-8?B?T3NtekViYkF2UGFWZm1WakJ5NU5jeWNzcjJjbURCdXZ3RDhlOENYSXZGV0tH?=
 =?utf-8?B?L0NaWGM3NXM5MTRwWHBheVhOTEUxNWFiZmZHVi8wTkhWM3ZXSmUvd3dKZkda?=
 =?utf-8?B?RnVmeG1xZ0pjS1ZFdW1EekQ3M09aQ0hBQW8xY1hwRE42SWNpRjZiREdXWFZP?=
 =?utf-8?B?Y1AyeTRlZGdaUndVZFNoUkZxV3VNR2lOSk9lWURmUW14QW9ZSmlwSS9veVpY?=
 =?utf-8?B?Rk82eDU1OHZPR0oxanF3SG5vNC9FdW5jaDdRbEdTQTlIWE0xUEp0bFRzQU1X?=
 =?utf-8?B?MHlSNXJCQWQ0Zm1MUW1SK0U5V1ZPd1MzV0psaWpWVFNSdGlKcDdiOFdkcE94?=
 =?utf-8?B?YTRCT011SXcvRCs0U2d3NWNzRUJ3RGtheTZtREJza054ZG5MdndmL1FwZ0Vk?=
 =?utf-8?B?eTE4K09jMVg3LzFwUHdiZWJ0UGllREhRK1piMkNSMTRMTEV0TEZaUnQ1OWM2?=
 =?utf-8?B?aENiUllSSGtkTkNFTUVpcjFwR2ZFczZaL1ZQdHAzRnNMSFdaaHdMbTVRN1dt?=
 =?utf-8?B?Y2NKWDNvd0pUZTJUcENhRmpxV2hPTHlhTlJIcVlIamgzdlJ1dDVIMVducCtQ?=
 =?utf-8?B?U3ZqY0RycVZZUlh0MGJvUjhXMXBMR21Sd3dwUXZkWm9LUXhtWFNiR09BS1hV?=
 =?utf-8?B?eXdCWHQwWUdWQkFVblRaVkY4WTJHcWs4WWFqQlc4a2JuaHR2S2NNaHQyOTR0?=
 =?utf-8?B?ait1K3pMWFU3cXNGSk92NTA3eGZNbks0VXpZU3JzU3F0OGdqSzlqeTBOMm9T?=
 =?utf-8?B?Y3BXMWlsTWN3NHRqdW9tbkMwbWE0U3pRL2NqclJRWU9Mb3F3NkdHUEREaWJ6?=
 =?utf-8?B?N2tnN0hCMW9CTjlvblFydjloOWt0Z2FlemxMQStPY2YzRlkyUDhLMnZvQmxa?=
 =?utf-8?B?SWlsNWlkRHllaGcvM2JYdHdxQlZoYWlQbm1pQ2V2MW5TdlBPYVg1Tk84b3hT?=
 =?utf-8?B?MmZmSXZjb3VQZHZEbXRReXVhYXpxeHRBaTdBVEc5SCtobFFVeVYxZkNVQjlY?=
 =?utf-8?B?am5ieFV0dE16NG1YWmtncVRTV0NqTDFOOWZZVkZEK0lSRFlaQUhkNlZvS2V4?=
 =?utf-8?B?MnBUZUx2YUx3aVJvNFJyNlJjTGdBM0ljMWpyblB4WFBtZkpZNEwxeXFvbFBG?=
 =?utf-8?B?MkFZWEhzV05mUUhSRXdsc3hYc2hSbVF3MG1uOU9BVzYxeFVTYXFTeXJOS0Jy?=
 =?utf-8?B?bTdmVEkzT3VPS1VraTNXUnFVUlR6UmFQY3kra0JRcXBoSFpwQlZlb3laOXhP?=
 =?utf-8?B?TlRwSngrNFpBRzhYNFNPR25aWnJGZmZubU5GbUt1MEZrNVRZZW9Ja2tGWE5r?=
 =?utf-8?B?em5EeFphcWJSMU1wQTVsUjA5Q3AxVnlCcFJEUlNmMzRJY0tKVHp2VzNyOFFn?=
 =?utf-8?B?Y2ZpVXo3bUxjT0ROZEJCQ3pZWkRWTjgraHFxb3Nob3U3NUwxc1dvakF2UzEr?=
 =?utf-8?B?ajhHYTlNTVI2S0hhL2I2OTdDWkROeEZKVlNlSU9wa0hITTBBT2E1ck4yK0VN?=
 =?utf-8?B?NFlxWFkrK1BPZlR0WUlzbUFNbEprVU55THlTR1Myd044RFo3dEFTZHRNUHJH?=
 =?utf-8?B?aWNHTHUyYVZmaEtlb0N1RGRQcjlqNnlSSndHM0dQT01NVWg5M2NXVCtFZUow?=
 =?utf-8?B?dWdTZzM1emVNdGw5V0krOHM1ek5TeHFrVGZlZ2pzT2REMlZuNjNCSXdKNVRl?=
 =?utf-8?B?Ti9IZTE1a3JVTC9NM3hhdEJ5eWU5ZWp6VlluVXd1aUNWdDRENG1wRFlKNkg4?=
 =?utf-8?B?dzRFb00ybUwzelljU1JySXVwaW4rNXdrQ0VxNm1PYnRTVkVvOXdMWDdlQmhF?=
 =?utf-8?B?R2ZzbGlpSFJyNS81S2VZNWh0aVQ3WER5S1Z0VzBoZmpQZndDWXBKZGpaTTJE?=
 =?utf-8?B?aUVUNkNYcXN0bmQxclRaUm9zbmVBUTNsbFEzT3VuZjNJQjZ0M2h4WE9laUMx?=
 =?utf-8?B?eUxENjBYazREL0FkMTRDNmIxS0lOaHc0YVlURjg1WjdVRWJvUldqK0ZEMlJn?=
 =?utf-8?B?Y1pidjV1NjRXaTBabUFsTTlIMjF1UU5kNmUwUWViMnZpNU5DK2pzUktZODlS?=
 =?utf-8?Q?WPylSpBm+7XKgCCcJvlgjjYO6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ffb483-a7ca-48cb-a830-08dba8d824be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 21:37:28.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4hGr9BViYrkYzq41foUsXKcUggJIgvJykdQbz2/NGoLP6ThkA436wMQsv7iGfCWuNnu5m4rocTZXuejTNuIKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2023 14:54, Hans de Goede wrote:
> Hi Mario,
> 
> On 8/29/23 18:56, Mario Limonciello wrote:
>> Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
>> debouncing with WinBlue debounce behavior means that the GPIO doesn't
>> clear until a separate GPIO is used (such as touchpad).
>>
>> Prefer to use legacy debouncing to avoid problems.
>>
>> Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I'm not happy to see yet another DMI quirk solution here.
> 
> and I guess you're not happy with this either...

Yeah I was really hoping the first patch was enough for the issue.

If we can't come up with anything else we can potentially drop patches 2 
and 3. Even patch 1 alone will "significantly" improve the situation.

The other option I considered is to hardcode WinBlue debounce behavior 
"off" in Linux.

I don't think this is a good idea though though because we will likely 
trade bugs because the debounce values in the AML for systems using _AEI 
aren't actually used in Windows and might not have good values.

> 
> Are we sure there is no other way? Did you check an acpidump
> for the laptop and specifically for its ACPI powerbutton handling?

I'm not sure there is another way or not, but yes there is an acpidump 
attached to the bug in case you or anyone else has some ideas.

> 
> I would expect the ACPI powerbutton handler to somehow clear
> the bit, like how patch 1/3 clears it from the GPIO chip's
> own IRQ handler.
> 
> I see that drivers/acpi/button.c does:
> 
> static u32 acpi_button_event(void *data)
> {
>          acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
>          return ACPI_INTERRUPT_HANDLED;
> }
> 
> So unless I'm misreading something here, there is some AML being
> executed on power-button events. So maybe there is something wrong
> with how Linux interprets that AML ?
> 
The relevant ACPI spec section is here:

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html#control-method-power-button

I did look at the acpidump.  GPE 08 notifies \_SB.PWRB (a PNP0C0C 
device) with 0x2.  According to the spec this is specifically for 
letting the system know the power button is waking up the system from G1.

I don't see any notifications with data 0x80 in the AML.  So I'm 
wondering if the AML designer made an assumption that pressing the power 
button caused the system to suspend or turn off.  That's the Windows 
behavior, isn't it?

The spec even says:

"While the system is in the working state, a power button press is a 
user request to transition the system into either the sleeping (G1) or 
soft-off state (G2)."

I think it would be a really good data point whether this happens with 
Windows if possible too.  Then we can know if we're looking at a Linux 
bug or a platform bug.
