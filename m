Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484A792F64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbjIET5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbjIET5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:57:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A29C;
        Tue,  5 Sep 2023 12:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6qIokl3xnJMAkqd3hp3B1vU1BGTTTfUCNAtwY+aBYOC3NLnDVFKZFHrMccl42p49Ckr3UyjsJEHNFSo9srMvSKJln5d9XPgpMJ7pNvxhRTMmDO7ZHtGhGhf5EzyEq4/34K6rJsWYTTSpGBLhhrpkEj2vEqkNSo2SMwWiSZfQF3Khb++hhntA35kKFztkbwxCBne9Dhgt+vpishLQhSbt7tDfPwywzTBWNS7i/NdnTnAVx+pk3M/MEV5J1bmno7pgkXcSyiHy3L7Hni1tOlTEDNaTxzh3hZu8OMuvTHhzsDWb3m0ZHOF09GGRwXlbNwy9MJn/PcIGeFpK7MIDuK3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7t01YDxJnsRSXrHRCTkQ15c51njwdc8SSSkce8Uotk=;
 b=ZX51Ja8KdUMX1ILDZ1R1zcZq1F5fl6nVMfo+lTy68Bj7SIZD7yadtgKr2GQCK6KxOUkc/bhEYurob9T1DA2cEqWVLY5jkFaEB+Mq2/D5/nQMsoT8Zf0FusmAdzCbf2AxoWMPPxIyinJ5jo/cEq/cII6MeMbbfS6Mt057cwxhA1obr0IM0fmZjrzGdVU6TTGymGDIzzbaV92FBUKvEzXwiStNHii9vfi1OOkwTyIaXxvOkm1QS4GI4GQl/9PGa9NdNQLFD0W4HhDVyIgGYGqscTB7oplQA1djic+viJVWmUlZrjXq4n3TvNZONQGE53ejXfEvWsxsIt2eAc53nUkbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7t01YDxJnsRSXrHRCTkQ15c51njwdc8SSSkce8Uotk=;
 b=OTWo5RtuR4QXWVFfAQroahAnvnLCZjm45Ep8NnnyEyM70iXh+6fCgD6+zGIfG335Pez+EzVgeaC52+sYPW5WmAAKkhqOPE8jtiNTPCSkMSzPzGxS2WCAc+auWTzGh78JmrLdXM6GnmlJeIyjkmjpcpDeyqJQaDyQmINJ1K/jFsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:57:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 19:57:36 +0000
Message-ID: <f1c65b21-88cb-4ba3-8380-0d2d3fb42c8d@amd.com>
Date:   Tue, 5 Sep 2023 14:57:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>, rafael@kernel.org
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <20230829171212.156688-4-mario.limonciello@amd.com>
 <ceda84a0-e5cd-f6dc-3e3c-52e85fda8318@amd.com>
 <ead0bc03-2008-96d8-c313-5dc4a9e63479@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ead0bc03-2008-96d8-c313-5dc4a9e63479@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:5:3af::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cd9302-9b57-41a5-47fe-08dbae4a59a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTaCHwvgdYT5+EFw8Sp2VUWmLvobtuA7FVxgVtdDs6WswFxCJGQAEWEY63HogPiZ1tYHzt4h9Tc5XE9cVmV3HJwPFTZgTBE2vOzmBz9t2yos1yyVoVcsEDmL4r6L8+F9GDcyHDarBHAtv53M3qCa9rNskDXhPtmuAVSgpeh2S+EZGUfykWtad6C+hcYuYzn61udjezma+I1BA1HDbZFm1cxLE8/AIHDrcx6oy9yEz3map9tCBiVT74VNK2Ae/5iBlYIr6ZjkLjA+1IGeefMAuLROPMwLmTtl9vroHWy8oJ88YQqJGC3n2xwwtSS51/kmDDGqY9BNlrDAWVf5sFkbjVOmEA5+YH8DQVTRJJD6z/4Ydd3EXsGaJS496io8RoBKuL26etfI+xyuxrajLwuK/zrDiuDJRlAXzIXvjpBCumOeym4CYLAjALrPVWAaEqenG57+Z9gqFT9NMx+/qiWi8p5zikF9YDXDveuXpUxhwtVZ7k5yQNJtCWUHhvO5r8AYqGwb2CGYSLLHE7RbdXqJ0rf/ha2a7CctPj5wLMP1BMB8fsrnXTIKpEyFgWttntoKV/fd5Q1IHhH9HcN8ndZi9B026pGq6jNZKIh6Wv5KGx9VxmZCayVQDIps7IjM8xeO133ejMKS9eQ069hRGmj3sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(38100700002)(36756003)(83380400001)(2906002)(478600001)(316002)(110136005)(66946007)(66476007)(66556008)(6666004)(53546011)(6506007)(6486002)(41300700001)(6512007)(966005)(31686004)(86362001)(31696002)(8936002)(8676002)(4326008)(44832011)(2616005)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWM4VDFPREVDVVB3ckFaRWJlaC9HT2swUWdKRGFDdVBCaEVoNXl6ZlZ1ZDc1?=
 =?utf-8?B?MWxOOGFPbXc3M3NJU0NuUmxVSmQ2UFRBZ3M3R2c5dUIwazVyNVU2aVhSYlVo?=
 =?utf-8?B?dTdWcXRMSUNGc3c4M3JPZVdscTVNWXNhNWUwQTdXMjVhMWVFWHhETHBtSHcy?=
 =?utf-8?B?elMrZGQybnhkWkkvVk96eGtyTkgyTURja0FEUXhnS0xWQWtPb3B2Z3RzYjZi?=
 =?utf-8?B?RkNwWStFemhreGs4QzllRW9RMVVjQW1JdmdKOG5VaU44djA1M3hGU3VJWFkr?=
 =?utf-8?B?WFljaVNzTldXWjAxb29ET2VmclJ2UlhUM0pHb2t2aWtFSEw5RTIyVmRYdk5m?=
 =?utf-8?B?bzZiTE1tbmRrbTI3Y3E3d25ETEpiVzkrRkV6dytuSXlDRE0wSEc4UHdYcDYx?=
 =?utf-8?B?ZktzQ0x2YVAwQVBlTE5hTzF2c1ZxazJYZGVHYUtPZ2t5VVd3OXBMM3QyMTM1?=
 =?utf-8?B?SDh4aWMvODd0SXZZWkl1MVE3bW5LRXBua0xCamV2TFlXYlI4K3lTQUtIZHFP?=
 =?utf-8?B?a2VVVWlneTZ5US96Y1J2SE5PM25vbjE5aEQxME8zdG5obGFyb1YzSkZoV2Uz?=
 =?utf-8?B?RitwVDgzeDBud1M0OTVNWHZONkZUZEM1Nk9uK1MxRktFWXdFRjlqckVDS1Rx?=
 =?utf-8?B?dFJFQS9mUE5VaEJOb1R3WmF5bUQyVlJXS0N4S0FyRkk0RVNVeGlkSkswc3d1?=
 =?utf-8?B?OEFYSVNVK2VPS1F3SFhyeUM0TURndzBGRGw3bWlreUtMWG5paEJteGlYN3RI?=
 =?utf-8?B?Njl6dVlDT1pRVk9ENkdEbjR5UFhkMll1TlllbXF6MmJrM2E5YnI0amc0UG50?=
 =?utf-8?B?N1h1UWxnY0ZZTlkveThOZWZBNVhGY1p0ejBpNTEyY251YjZ6bEg4Y0NLMFEx?=
 =?utf-8?B?Z2VMODQ2emtOeW85MlkzSk1vMjNwY3BZbGsrYTArUENrLzFGWUdWVFVEYWRU?=
 =?utf-8?B?aTB6NkdiMlJvNXg1ZXREYm85SnRyYmdVL0MwbUhFM1ZsZUZiNjVxTHg0VFpM?=
 =?utf-8?B?QVdVa09zaWxIRzJpYXFWWU56eUZnRG54TGhHUExDN1k4c25Zb200bTdKM1kz?=
 =?utf-8?B?VUMzSFFUWGFEYmg5MGJDVmNPcm5EZEhiQWdOdVpZbityZksyWjNSVDJzSTdF?=
 =?utf-8?B?TlkvVitaelROZXVIakFwVmV5Y1FKeUZURmNNQTk5MlF5ZWFkUG9GNkJYS3R2?=
 =?utf-8?B?YW1vWkd0UktaZEdUTWdwZ1dRMThUYVZwQ0xVK3dxVXE2TTVKUHRTRWk4SE96?=
 =?utf-8?B?L3pmWUNpRzcyZWZCV0RkL1ljQXNCWmNIZlNiMnlGU0d3V0Z4OGRBaUo3RjRM?=
 =?utf-8?B?blR2ZU4wcUpZazBSZXRLWTd0QlZLUW5CSG5nRkcvc2p2cktxM3Z1T0N0VWpL?=
 =?utf-8?B?Q24zRkxyZklQQ3JVYXZwWjVqSnJISmpLdFhrRURoRktnejByMUdiZ3BGUGtV?=
 =?utf-8?B?NXBVbmM3dHlKMVVjdjlXSDFSZVNha2d1ajJJS3Evd1E1RnR1Q2d5Y0VqbURC?=
 =?utf-8?B?RW1mK3pOWWxEOFdRRjg2VGJTeWRjYkJ4dllKZGhkc085K1p1Z0szVjY1bnhU?=
 =?utf-8?B?RDJWZXJUM293cG9zSkVuVTUxL1dyUm5DZjhJYVlXU05rV0tNUmQzVHhSY0Jw?=
 =?utf-8?B?K05Vcmw0U3BzK2xZOUFJdjYydEJycW5Ea1M1dG1LaTY1WWcrWVIycEhWY25p?=
 =?utf-8?B?MHN4SFhiTjVoeFV0NEhlQnAvNDV2NXFDSHRHM2poTG9jUmtjMXJLQzI5UkhT?=
 =?utf-8?B?SXBDSWJmeStYNHh3Zm1zSEQ2K3BJeFFLR2h5bStKK3lYUExEa01ZY3M1bENJ?=
 =?utf-8?B?RHlFMkZieGM0N1lJY3lHK2xLSEgySGxYTk9iUGJaVytHNk9lUUJ3NTAxdmZq?=
 =?utf-8?B?UHQ2RmpMNXJ1alZNYmhWeGY2QmEveXJ5QzY3dVFwS2hvc1FVNllXTGJDKzlV?=
 =?utf-8?B?ZFdFcWx0eUlkZkRJazQ4SlVSbnFPWlhGSk13OWN6dVNIaXZ4T0xlVzJvQnZS?=
 =?utf-8?B?YkpHRTBETnFLb2ZKOTdXL0g0a24ybGIzUURuWU04L2tXaThRUjhReE1FNVNl?=
 =?utf-8?B?TU82VGlpZSsvcnB1M2JmSE9pYTRxdmFxTHVYbVB6bkhINEdVQ2pwUWdqL21k?=
 =?utf-8?Q?+HOonlsqpnFnrg8c6z6uG7ndh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cd9302-9b57-41a5-47fe-08dbae4a59a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:57:36.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiFDmsiCs7p4zpy42gvwdj52DWXKsrdw0H7nN4Oxxpr777wqK0F6tYg7HRMhu8Ki16xGIUvaJyOGYebULw9ChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 05:15, Hans de Goede wrote:
> Hi Shyam,
> 
> On 9/5/23 12:08, Shyam Sundar S K wrote:
>>
>>
>> On 8/29/2023 10:42 PM, Mario Limonciello wrote:
>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>>> from modern machines (>=2015) are allowed to be put into D3.
>>>
>>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>>> from suspend. This is because the PCIe root port has been put
>>> into D3 and AMD's platform can't handle USB devices waking from
>>> a hardware sleep state in this case.
>>>
>>> This problem only occurs on Linux, and only when the AMD PMC driver
>>> is utilized to put the device into a hardware sleep state. Comparing
>>> the behavior on Windows and Linux, Windows doesn't put the root ports
>>> into D3.
>>>
>>> A variety of approaches were discussed to change PCI core to handle this
>>> case generically but no consensus was reached. To limit the scope of
>>> effect only to the affected machines introduce a workaround into the
>>> amd-pmc driver to only apply to the PCI root ports in affected machines
>>> when going into hardware sleep.
>>>
>>> Link: https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> See if this change can be moved to pmc-quirks.c, besides that change
>> looks good to me. Thank you.
>>
>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> Thank you for the review.
> 
> I also just replied to this series (to the cover-letter)
> with an alternative approach based on making the
> XHCI driver call pci_d3cold_disable() on the XHCI
> PCIe-device on affected AMD chipsets.
> 
> That seems like a cleaner approach to me. I wonder
> if you have any remarks about that approach ?
> 

I was thinking more about Hans' comments to the cover letter as well as 
Shyam's comments to move it into pmc-quirks.c.

Perhaps it would better be conveying what's going on by having a 
dedicated step that amd-pmc calls pci_choose_state() for each PCIe 
device and checks the value against the constraints.  If "any" of them 
are mismatched it could emit a message.  This is a little bit of 
duplication though because drivers/acpi/x86/s2idle.c already also emits 
a similar message for some devices when pm_debug_messages is enabled.

Then the special case would be for PCIe root ports that are mismatched 
the driver overrides it.  If this logic change is wouldn't make sense 
for it to be moved into pmc-quirks.c.

I don't think using pci_d3cold_disable() / pci_d3cold_enable() is 
correct though.  If PCI core stays the same it should still be setting 
pdev->bridge_d3 to zero.  The problem isn't with D3cold on the PCIe RP 
at s2didle, it's with D3hot.


> Regards,
> 
> Hans
> 
> 
>>
>>> ---
>>> v15->v16:
>>>   * Only match PCIe root ports with ACPI companions
>>>   * Use constraints when workaround activated
>>> ---
>>>   drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>>> index eb2a4263814c..6a037447ec5a 100644
>>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>>> @@ -741,6 +741,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>   	return 0;
>>>   }
>>>   
>>> +/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
>>> +static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
>>> +{
>>> +	struct pci_dev *pci_dev = NULL;
>>> +
>>> +	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
>>> +		struct acpi_device *adev;
>>> +		int constraint;
>>> +
>>> +		if (!pci_is_pcie(pci_dev) ||
>>> +		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
>>> +			continue;
>>> +
>>> +		if (pci_dev->current_state == PCI_D3hot ||
>>> +		    pci_dev->current_state == PCI_D3cold)
>>> +			continue;
>>> +
>>> +		adev = ACPI_COMPANION(&pci_dev->dev);
>>> +		if (!adev)
>>> +			continue;
>>> +
>>> +		constraint = acpi_get_lps0_constraint(adev);
>>> +		if (constraint != ACPI_STATE_UNKNOWN &&
>>> +		    constraint >= ACPI_STATE_S3)
>>> +			continue;
>>> +
>>> +		if (pci_dev->bridge_d3 == 0)
>>> +			continue;
>>> +		pci_dev->bridge_d3 = 0;
>>> +		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>>>   {
>>>   	struct rtc_device *rtc_device;
>>> @@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
>>>   	case AMD_CPU_ID_CZN:
>>>   		rc = amd_pmc_czn_wa_irq1(pdev);
>>>   		break;
>>> +	case AMD_CPU_ID_YC:
>>> +	case AMD_CPU_ID_PS:
>>> +		rc = amd_pmc_rp_wa(pdev);
>>> +		break;
>>>   	default:
>>>   		break;
>>>   	}
>>>
>>
> 

