Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3278F236
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbjHaRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjHaRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:53:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4E12D;
        Thu, 31 Aug 2023 10:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTldJP5SkG1nm/bDYm3bGfyFD0gsfRyP9gQN1+Cr8IH7IWVMQaA1wygO9mWh/DYyLlcTmeWdNgxWGZTFtsRHLNsNseG3zLUIFgSc42MQC7i2zEFjEYpkO4hGW/0QsHBE6iKwo6R+vsesz9htiyfJXlJGpyFPdOVlhDOuChPx7az1Ttd3idMPLj7xqoTvIWNjmcyhuEcruLydu3UKViM3rTwAFTh6yvWSa19sslswEpTnItKBKMuBhuCQXJpFhvVs8GRRUwTLQlIaopxvrfTuYQ62Svk4ZxiZ4plubdZGobvbFHuHUhi4sPuY8b73lndyurco75Zc6T5b4uodHVm3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLMNFVv885sKpynxgAy1Ime6ocnDU2/uF2PfSl+8new=;
 b=foJgP2sZqli300bj70cbEuf3zgUjA8Yai9uKaGN1fjiDGD3lpmTzJp6xnVBlRl9OmbgClURnV0ErI5R1uREbHfEJN54D+60uue9n0hFful6vEXT58IJGnShSA/n8Bmo4g+y63z097LcAaLmCqOeMlNF3MLL+d+HRkSASNoxVwZSIlN7g74elAOGA94emr/kY1/+oy5AxVjxeh8F2yRNMXYnDK0bF2ZF3FnzOMJwHgRDEPy36/qnh9EGBddL8DQPsD/FXiIrWNJ2Nwro7bFG+qbLOqEuD8IKfiU2dKaKSzkbMuf6q2C6IU+BhbybiOC9oum3pCvkkpTVjXR9dd+0zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLMNFVv885sKpynxgAy1Ime6ocnDU2/uF2PfSl+8new=;
 b=W2ftDzWkbR+KTXvYOkFW8LhCaySInF3my2JojgGWgjS9I06Ug9TCRcB9nw1d/6m7MbQOiDi9Qc+u+cn8Z5NLU9KkFXv+rNk8S4UcGZJbpY6G4eGQzN2JV+9EgNJvGyGzQuTivu9wRV10ehrpMjf+2iwduzjpDRl4LUw6KNvBIWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 17:53:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 17:53:47 +0000
Message-ID: <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
Date:   Thu, 31 Aug 2023 12:53:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
To:     Hans de Goede <hdegoede@redhat.com>, linus.walleij@linaro.org
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:130::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ed6848-4972-4714-cc5b-08dbaa4b39a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuyhZ13NgdYRc3JQhj2Ag4+X+q0oH5cPCX2w0yIqkX/l14LC5x342BNwSDdbLpVeDzJHWWKu+dGlsBgR2v7LtE4DAcFWPGwReYYLvZ13thWuy8A86VooEf8duNaCBRkHBSZBbvu+qizOgFyvwKTwUbg5RLyjPasaT4iSmQvy5HNylv3ZiuRHvrbWj+igjE28U+2RCSSTm3tVtZTY1CHjmi3NUXRWzDSx9pJku9na7BFqJCYpJEMvBlSaWV8KBxp1fQAC4BIiMkGPkHOz5/dZuggpQhySXvl0pKM92R6PIKfFkQizbPpc6gUAIPy/EvTSEcL2S7yx2LDsySkCdMd1331jTvpm7KEqweiEPt3GMcO6mkcj8y0WKm3FQOjCeWvcUHf8+e+cOlpUR+TW7+cV4J0IiVE7y5vKeEwNf7szwxPDgrlbBNiWdTL5jX4/lWpz39WrdPJJ2RuHxoSjHx0uhkn+wem5Wzu0Dby2yH9stfvJuDZ+PWRa1FrhC5Q058sHtOYaaMpJiLqzN6yFMFszMx4VpvjywVzRAwhiaJ6J+l26NqaYAwOei2zZz7jaqiCgd6Pi7ssD2Zh7acoxCsCRqixsElD6kvQC1aflrbCXNZgYZZNc5yaiHTvxwdzph0ZGx+Q3iCghRyXviJVkaEtTOsluzcab+JMiBE2QQytkZy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(31686004)(6666004)(6506007)(6486002)(6512007)(36756003)(38100700002)(86362001)(31696002)(2616005)(2906002)(26005)(966005)(53546011)(83380400001)(478600001)(8936002)(4326008)(66946007)(8676002)(5660300002)(316002)(41300700001)(66476007)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtqTzBVbytzOUFreWVVQ0RidVJ3dWhDbTMrTDNGVnJ6Q1ZZa3NkVUZHQ3o0?=
 =?utf-8?B?MjJqT2txZXl3RG5QM25jUXZ4bTVnbDcxUGl4UHdJcTZ0dEJyRGEzelN4eHkz?=
 =?utf-8?B?TGs4RXJBS2l6N1IrVjB1UXpUNVRPTklkWUFWbFRTdDBKeGpyNXVPaGFsenNs?=
 =?utf-8?B?UTk0TUxMM3Z2SjVSTVVZV0FCR3J1T1ZLOU9maDNLMy9FS3p6NkcrK29EUzVq?=
 =?utf-8?B?YkF4SmlBdHRjMXFkQjRhN2dKbmtGZXdSS1FkOCtPeTN5VDlCUU03dE95dEh6?=
 =?utf-8?B?NXN5dm1LcG1PSFU0Z1V1WnpNZmdROWJZSCsrQyt3dHdHTDhja1U5S1U5UEhX?=
 =?utf-8?B?cFdhWHFYY1BzVW9Ma1VCK1FyclVNa1FlSENpYjNPbUFVcHd6ZjBTdHdyVnBN?=
 =?utf-8?B?TjJ3Syt2ZVpHdEVsY3lnYi9VQkJiWUxKVWg3U0pyd0dXNTVKdlErWVVCVjU5?=
 =?utf-8?B?RkdId1lnVEtsS2hhYmxhVWN1bTkyelNiVVVNV2NuZ1F6Ui8xS2g5UGdIWVFD?=
 =?utf-8?B?eTRMVnFIVEcxSzBzNlVjVDZuLzI4QjNlVUdHdzdmeHRlS0VPeWlMNlcrM2JJ?=
 =?utf-8?B?VnU4b0tVN1lYODZXUmw5c0lnVXBTUytqV2ZHQlFqKzFVN01JNXJwaG1FMm9W?=
 =?utf-8?B?dCtZNzU4OGphRG5HM3JuWklBdGp1SERMdm1sT2IrOGdmWlBoNldLYjZEbk9G?=
 =?utf-8?B?cklGUDBodlkyVGEzTGNaZCtkbGZYTE5RTnNTQzRzOUk4WUpXeWw1UFRlN0pJ?=
 =?utf-8?B?VGNZNVVIeG9uRlhWclRTQnpYZFI5cGFEbzhtUFdUenkvQm5qK1FkL2J6a0Zx?=
 =?utf-8?B?TjBEQ1hqak5DVEp1MGR4QmErdEw5QjFYL250YVRTSXQ2Sk1RcHFNcmhDTDRH?=
 =?utf-8?B?R2VlTmxFT2V0djdkalJOSTJIWnl0cHBWMmhxd1dhRXk2MGNDV2hGd3RXcHZK?=
 =?utf-8?B?RHY5Mzc1QkZNWXFUUC9iUndGVzFSemZPNmZUcjNkekc4UHFPWkQ5NXJFVFRF?=
 =?utf-8?B?OVF2QTBabjU1V1BEaGFwa1o1S1hnOWIzeGVuVUhtb1dCWWJYK3VFWnhpaVRD?=
 =?utf-8?B?M0pKOFhGTzlRWkNQL2lVYkdYdlNiMmNuRk5TUEVmOGd3N0sxNVRwUE1FM3dv?=
 =?utf-8?B?U1RmQnpzLzRKMWIyZktwM0xtRHY3SmdEeEtEVEZyQUMvVU1vMzBRSys3N2VY?=
 =?utf-8?B?NDJQS0E3T0hFOGJ1MkhpVkhpTlFvUHBwdENQTFFlTlcyUFRNSlhRWnlxOXp5?=
 =?utf-8?B?Q05USWRaeTNISHlDdE04cSs0UlBsY1VyK3ovOVluc29ZNjd4aWQxVVdUV05Q?=
 =?utf-8?B?bVU3b01DUTdLWVFRVGloZG1nS3dQVkFQYUYyQXpWc3JUcnNjOG81ZnY1K29r?=
 =?utf-8?B?emt2Z0ZNSTkvemNoV2dZTmo3NzIyR3RTQ3VaSUpPTlFSVUJTMUczQUN5YUV2?=
 =?utf-8?B?eGdmS0tzTHRpRW1WdU8xbk4wd29EYkl2WkNGY05WdHU1SWFnS2swSER3N3Qr?=
 =?utf-8?B?YWFab1M3V2RnNVZrRXIrMEV4dnlCWUhaZ0t4emJ6WW41bVdTczZEei93L2ZD?=
 =?utf-8?B?VWIra3R5V3FqS0xGMGtlNkVvWHJLWTBNRnI4Ulo4Ylc2cHhQcUpwMEViSVE0?=
 =?utf-8?B?K09sM25ZQ3VqVEVFUnRueENsbUU1WFRKSVE2cDBWalZEcFJRWlBiekwyeDVW?=
 =?utf-8?B?cjRlVWQ2ZUI2YUlNY1NlTExDZG13TmlEOW9BMGFOYnJKcFJmbnVCaTFqVkxF?=
 =?utf-8?B?cjBFTy9XSXRQT2tveENhZkdKaDBvcFczYlN3Y1VZK1JaMjVzMDhNTVl1aTNE?=
 =?utf-8?B?TUZHZzl6VDhvUmFCTFNZOE1aZkh6Y1g1UWhMSTJqcldEeDQ0VDlKWnVQdm1i?=
 =?utf-8?B?SnRWbUd2Kzg3SkVPbFl4TWhVc2tuMjB1bGlPSTJBZHhoQlQ4a25xdHl6WWIz?=
 =?utf-8?B?MzdJdW53Z2daZzVrckdkVndib1NRa1J3dFhDb3RvVVZTeERnQkxPamsxZFJY?=
 =?utf-8?B?V05sU3VMWVM3SzBZczZPSlZJMHY0WCt6RlkrdnZDZk12b0Nia3VQcVRrTHNs?=
 =?utf-8?B?U2ZIbmZCRmswVzhWMDdBaG0xbzEwZVpIMEVNaHNtMmtzSGszczRDbmhha3c1?=
 =?utf-8?Q?97Uv3KjJNRcqqHxTWDvt/jyAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ed6848-4972-4714-cc5b-08dbaa4b39a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:53:47.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWi5l25F8dB8fBNbqR5xkU1NqIZtQqOuptjLhnTfgwnpq7rtyfY7o3BT7VGFuH7Rp3P4QQXeyCvZOIuN3o/WNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 11:18, Hans de Goede wrote:
> Hi,
> 
> On 8/30/23 17:47, Mario Limonciello wrote:
>> On 8/30/2023 10:37, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/29/23 23:37, Mario Limonciello wrote:
>>>> On 8/29/2023 14:54, Hans de Goede wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On 8/29/23 18:56, Mario Limonciello wrote:
>>>>>> Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
>>>>>> debouncing with WinBlue debounce behavior means that the GPIO doesn't
>>>>>> clear until a separate GPIO is used (such as touchpad).
>>>>>>
>>>>>> Prefer to use legacy debouncing to avoid problems.
>>>>>>
>>>>>> Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> I'm not happy to see yet another DMI quirk solution here.
>>>>>
>>>>> and I guess you're not happy with this either...
>>>>
>>>> Yeah I was really hoping the first patch was enough for the issue.
>>>>
>>>> If we can't come up with anything else we can potentially drop patches 2 and 3. Even patch 1 alone will "significantly" improve the situation.
>>>>
>>>> The other option I considered is to hardcode WinBlue debounce behavior "off" in Linux.
>>>>
>>>> I don't think this is a good idea though though because we will likely trade bugs because the debounce values in the AML for systems using _AEI aren't actually used in Windows and might not have good values.
>>>
>>> What if we turn off the WinBlue debounce behavior for GPIO0 and then just hardcode some sane debounce values for it, overriding whatever the DSDT _AEI entries contain ?
>>>
>>
>> I don't think this is a good idea.
>>
>> Some vendors GPIO0 doesn't connect to the power button but instead to the EC.  If it's connected to the EC, the EC might instead trigger GPIO0 for lid or power button or whatever they decided for a design specific way.
>>
>> I'd worry that we're going to end up with inconsistent results if they have their own debouncing put in place in the EC *because* they were relying upon the Winblue debounce behavior.
>>
>> After all - this was fixed because of https://bugzilla.kernel.org/show_bug.cgi?id=217315
> 
> Ok, that is fair.
> 
> 
>>>>> Are we sure there is no other way? Did you check an acpidump
>>>>> for the laptop and specifically for its ACPI powerbutton handling?
>>>>
>>>> I'm not sure there is another way or not, but yes there is an acpidump attached to the bug in case you or anyone else has some ideas.
>>>>
>>>>>
>>>>> I would expect the ACPI powerbutton handler to somehow clear
>>>>> the bit, like how patch 1/3 clears it from the GPIO chip's
>>>>> own IRQ handler.
>>>>>
>>>>> I see that drivers/acpi/button.c does:
>>>>>
>>>>> static u32 acpi_button_event(void *data)
>>>>> {
>>>>>            acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
>>>>>            return ACPI_INTERRUPT_HANDLED;
>>>>> }
>>>>>
>>>>> So unless I'm misreading something here, there is some AML being
>>>>> executed on power-button events. So maybe there is something wrong
>>>>> with how Linux interprets that AML ?
>>>>>
>>>> The relevant ACPI spec section is here:
>>>>
>>>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html#control-method-power-button
>>>>
>>>> I did look at the acpidump.  GPE 08 notifies \_SB.PWRB (a PNP0C0C device) with 0x2.  According to the spec this is specifically for letting the system know the power button is waking up the system from G1.
>>>
>>> Sorry, the acpi_os_execute() function name gave me the impression that this would actually call some ACPI defined function, since normally in acpi speak execute refers to an ACPI table defined method.
>>>
>>> But that is not the case here it is just a wrapper to deferred-exec the passed in function pointer.
>>>
>>> To be clear I was hoping that there was an ACPI defined (AML code) function which would maybe clear the GPIO for us and that that was maybe not working due to e.g. some opregion not being implemented by Linux. But no AML code is being executed at all, so this is all a red herring.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>
>> Something we could do is add an extra callback for ACPI button driver to call the GPIO controller IRQ handler.  Worst case the IRQ handler does nothing, best case it fixes this issue.
>> I'm not sure how we'd tie it to something spec compliant.
> 
> I was actually thinking the same thing. I think we should discuss going this route
> (ACPI button driver to call the GPIO controller IRQ handler) with Rafael.
> 
> We can use the existing acpi_notifier_call_chain() mechanism and:
> 
> 1. Have the button code call acpi_notifier_call_chain() on the PNP0C0C
> event on button presses.
> 
> 2. Have the AMD pinctrl driver register a notifier_block with
> register_acpi_notifier() and then check if the source is a PNP0C0C
> device based on the device_class of the acpi_bus_event struct
> passed to the notifier and if it is check if GPIO0 needs
> clearing.
> 
> I think this is preferable over the DMI quirk route, because this should
> fix the same issue also on other affected models which we don't know
> about.
> 

Linus - please disregard version 1.

I provided Luca a new series that implements this approach that Hans and 
I discussed and they confirmed it works.

I have some minor modifications to it to narrow where it's applied so we 
don't have needless notifications and will send it for review after the 
new modifications are tested as well.


