Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023C7931DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbjIEWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:17:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3FF4;
        Tue,  5 Sep 2023 15:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7C7Fd2GoFF+xGTxSTy7gsB+QNrRIMIlNPN1UIQMIC+zZgt/O2SCygIb7CPLHz2RtfN6WIiU9Ebw/lBxm20sxt+W9XmsyGjEOuLkC3ontrFIxTJNMfyt/NTO0Ybd5hKR4UUoVHpjet284tX6NDMPYKWOUhQJxMJnVfYy5wWBINghU6xHcNNUP1FehF52heCz9RWAr2vn6BakZucVqW3uoNnw0Pn9eoT19rezDkifNRwGB3AK2wh1jXI/6UuLFJXfzLMlLaKGJ7M87Zvj+dSg+NtVBX76J1w4epV8CzZSUTFuXOGtDk7KOHAGuaO/EH+bYx+dGxeUHloVf5JLJzJ//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJqHB1nPafyow1JtpRYICSSznP4c93U10K3TwNtxgzM=;
 b=WMtLg72ot251egxUbnfPCNkBorAfNLIPBWeJo3QIx6RLLK8wyI1de3aO0xSBwp6MUKVPQT2SiozMPsGg4GTfEzGjefGegXC1lsrEgyiSuUEq4rKjorSwUmRrw0H60UkDT7d7J176IhVYSxq5WGMOfJf7qI3X3QRqHL+phTdISc+7pX+3HwBWx1b7GJHcSA080OkcMBFbpSYC2s3uJJFu5FES8H8XCqZcPBWrX7+PiqlwIjoxHpBnfkPOYkgaXFcDLwFc30NCUZW2kRsu/MC+GPv8sT/ywhLruIlR7/iFAj0AdHvhBJgGR9Az+GDu+9XvDXEsh+KwXVBTHtdxR3pjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJqHB1nPafyow1JtpRYICSSznP4c93U10K3TwNtxgzM=;
 b=rH4B4XMWvnVpdNun4vBywdZDTbG1VAF9WESlVuchJxLhnILjsu0QHDYr4bEfqeFjmK/PAXQEwrQSS+EDUk3Ku65kt8RT+obLs0fgh8uXCZge1pXHGT+k0whkQ2/ejy3eS33bzJ/kZsBvqRrP7yinBLfTVq8ZKc/VihPC9dToyG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Tue, 5 Sep
 2023 22:16:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:16:50 +0000
Message-ID: <4a973fe7-e801-49cc-88b8-77d3d0ba3673@amd.com>
Date:   Tue, 5 Sep 2023 17:16:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     hdegoede@redhat.com, bhelgaas@google.com, rafael@kernel.org,
        Shyam-sundar.S-k@amd.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230905205105.GA191110@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230905205105.GA191110@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 8312807c-fc11-4e03-a9d2-08dbae5dcd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns3EEGI4DD+yQEiVhzM7DNRrJgwqEyHqsDKDhmE3Mrz/s5l9P10tvCggrbYevKhsYoHLm7u2UiUTFjjZ1khCGQzb+CiS+1pVGTEWQb2zAhId80PfPtoh1sCKDWMg//6vONDSDO9WRwmE1ASwkm9AgsAy7vNia2aKEYeg0CMPXeBnAP94TtMg8SdZcwVAz84Mg6VPbFLDRVrqu815ONUQp16XWsZ+Q20TPhcLQCCIeNbgzO+RB3YejSD30NvcvPz9kgAHNQmfCeutbapYF7bTDGM80Nb4rNPUo28jM8hMH8QY/lzpRczCrQHpx8C5LphYY4PmioTxm0yELtFCNqmfV0OC8i1UCdzck6buHqdtbaRfMBeFeTGP+87BZNZK9nuQp7gZHQenm3EjkYAckwss3WeZJmLCRuGudZMQmNwLvVYJDr6+cnXEe51uOjkBP+8HjpLKSvb+pBmVqU8gBbDuobdBjnfEyfMqhV0/pDGvcH3cFOpsvbVo/kPiJ0lcsujZ4DhRkETLmlZeUo7BUfYUdzXNYhVdI0d0uyvEveArEUpVzryq0xHhLGO+9FQzzOnM9JREaiEjOOnc1feI/3jnh47IrS0cQh/G/sC1KEaIRuVlxB0pch51i/RlX4HZekkn0CBeVZ/AUdggf9/OLEVsLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199024)(186009)(1800799009)(966005)(41300700001)(8936002)(83380400001)(44832011)(478600001)(6666004)(6916009)(2906002)(31686004)(5660300002)(8676002)(66556008)(316002)(66476007)(66946007)(4326008)(6512007)(53546011)(6506007)(26005)(6486002)(2616005)(66899024)(31696002)(38100700002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlp0NGdIQ2FuVWx0cEhlNDdoTEcwQTJQaDVPa1hDVkhRS2ZVTnpzN1hnTFVx?=
 =?utf-8?B?WEw3SjNjQUVWR1A3ckJ2OFJiMmxROWxLLzgvMm5jMzZ5N05FTEtNdzlqcWF0?=
 =?utf-8?B?bDVzWG9UcS9pRGpWcGQyelpUbmNZTlh2Q21iTGs4dzk1Zm5Sc29zcE9sL0Fv?=
 =?utf-8?B?TjRQWEh6SGRLY2pLUU9uSlFjUVhiK3Jyd0YrSEdURFpwQXB4RXp5dytTRGxu?=
 =?utf-8?B?blVobk1kbEtSZUtuaEg0MUdMdWVoTFdHN2haSkErajB5RWoyeEh6aE5PTmhj?=
 =?utf-8?B?N21KTkF2TDh2dGx1UHBGWnVHNzM2c25iWjdXUG1pS1IyNW9nWndXS3BTRC9J?=
 =?utf-8?B?RHhZQTlVdUlLNUorcHdmMTNjbjdVMElqZnhNSFhVM28vVWY3MFhNTWVtREg3?=
 =?utf-8?B?aE5XRG12RTFaa1k4TkhDVDFPdWlncGE0UTFTTVJyUnBCdU5wM3ZleEJ5WmI2?=
 =?utf-8?B?TDlDOEhRa1BMMjRHeTgyL3I3MEpOMFJuc1U2Sy9ialRpRno2U0dlQUEvSVZF?=
 =?utf-8?B?WUdGeCt2enMycGFhem1oT0hzVFlaK2J6S3pDWEtJWC9DajBzR2pTWmQ2SXBo?=
 =?utf-8?B?NXllQ0VSTE8zWHlpMlREV1NrZFVVTGRiZUQ5VXFVT21HZXNIQmo0bmcvSmZi?=
 =?utf-8?B?VFZqRWhRNW9BYlV0NzdyQ01IMXJqbTlCME9oRUN5OU5vb2Vpa2EwUlpQb3VD?=
 =?utf-8?B?OFltcVJBak9vekYxa1VIQjJ4bW5Fem9URXBnM0VrVDg1d3Y2MnFkZnNhZzJP?=
 =?utf-8?B?YUZMSG9VSE9iaW55dzNadHFtNFM2RVhhckljSnA4NnJZN1kxZkZaUUVDUm1Y?=
 =?utf-8?B?S0o4bHFhR0ZtN05rZkFscEJiUWJMUzZtS3hoQ2xrdTJoM1NrSkZnZGQzdE5o?=
 =?utf-8?B?OEZDRlJNM05jTmhkamUvUXFxcW1qMHprY2NyeW9WY1ZxVHVwdUJtWnhsd3Rj?=
 =?utf-8?B?S2l1NjJGWXpDMERqUEcyTEc1c1JqZkJJSnFSVGc1aVRveDF2d0ZzVy9vMjBp?=
 =?utf-8?B?blBud2NCd1MzWExKQ0xaYldJV1o0L2pidUwzMnZ1OC9OcGMxOUdQUEtXZmlG?=
 =?utf-8?B?MUozU25MZ25JaDZZWHNRZVpZOUNBMm1MZ3pOWUNyK0NWdUZsWlhQOVFLcVg2?=
 =?utf-8?B?ekNZdlBqYmpDd2RUTDFNMURXRm80VmQxbzJSTmtkbTh6Vk9MQlN4ZkFUaWxh?=
 =?utf-8?B?ZGRrMjQ2QlB1aHhnNWJlOTNKZVFmNmpUY1AxZFU4SGhab2o1bHBIYXl1MXBh?=
 =?utf-8?B?QVZaaG14dndvMUp0cWhla2NMYWJKbzNmOXJ1U09QMTh4SXB3d2w1K3JQbG5W?=
 =?utf-8?B?VnJRTFp5cmJaaGVmUkgyNXl3NEdBOUtBdnUwWFFPdGpwL1ZNaUlwN3Bvb2Ey?=
 =?utf-8?B?bVFLcERIY3B6a3gzOVJ1c0dCdmlXVXdLdUlIRytUejlveGdZYWw5akpMREdv?=
 =?utf-8?B?TXpHc1J0YXNYSVROTkYwNnBVVlcxM3laRnE5UEkzOVg5aGxCZzl0TGtCTUVH?=
 =?utf-8?B?b1JGdERkVEE5dTIrVldzRUk0VkhHWkwxYkllUi9vdEc3bTFLRDNEZmRtSWtk?=
 =?utf-8?B?amJzaW44b1NJeHpYVWpwKzJMcUc1UXVTK3BJa0dvZ3JxQUhycDA3c1FPbmY4?=
 =?utf-8?B?ZVprbHVIN3FFbkxzSzY2YlJISEE3TnN3QXJWb0lJUnFXQUw5d256MXlzdk5L?=
 =?utf-8?B?K3BEaHZOT01yWEpaSzl6Qk1ua1N1RDZkWnBJUHljVWdpb3dDRzVwdVNrNWI4?=
 =?utf-8?B?ejU3Z21McHdrV3BNWFRGSmpnQ2thc2ptR1RXUW1qQWI3UzJZZ0VaS2tBQjZ6?=
 =?utf-8?B?cHIvOXNTNEltWXUwLzRKMjJoeTN6TjV3TmhEcDRzQ3JPWitYZDN3TWNvaGds?=
 =?utf-8?B?NlV0QTQra09KSk9LLytLMHBaSXVpMitYYjk4WjhWbDRPamZST25DTzgwZDRl?=
 =?utf-8?B?VGRXSElpc3NNbzlRVW9Fb1d2QWQ0ZHZrK1VNVXpVcDVkamZ2alF6ZmJ6UC9E?=
 =?utf-8?B?aFdYMmdCRUhmamJ3c3ZscGZ6TE1ycy9jbmVNSE50d1VtbFd4dGRiK0lKLzVV?=
 =?utf-8?B?OC9hdnBBWWxEYXB2ZUExWGFkeEJGenVLdk5HTVRnSzJTcFBSNGxWbFNtZHNw?=
 =?utf-8?Q?HRrR10in/lK9k8ujmToz3yXk+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8312807c-fc11-4e03-a9d2-08dbae5dcd17
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:16:50.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K84BI/crfSqxMoUvW9j8aZlBxSoW7jZKz4/sxh978x8uP5nJxPTfoO8LTHn64t65Ipp2LIJqChpFVDBwqbLi3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 15:51, Bjorn Helgaas wrote:
> [+cc Hans]
> 
> On Tue, Aug 29, 2023 at 12:12:12PM -0500, Mario Limonciello wrote:
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>> from modern machines (>=2015) are allowed to be put into D3.
>>
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This is because the PCIe root port has been put
>> into D3 and AMD's platform can't handle USB devices waking from
>> a hardware sleep state in this case.
> 
> Can you be specific in the subject and commit log about whether "D3"
> refers to "D3hot", "D3cold", or both?  It's probably obvious to PM
> folks, but it's always a stumbling block for me.
> 
> I assume "can't handle USB devices waking" does not refer to a problem
> with the USB adapter and whatever mechanism it uses to send a wakeup
> event to request that power be turned on, but rather it means that the
> wakeup event doesn't get propagated through the Root Port?
> 
> Is this actually specific to USB devices?  Or could a NIC below the
> Root Port suffer the same problem when a wake-on-lan packet causes it
> to send a wakeup event?  It seems like we've had this conversation
> before; sorry to ask the same questions again.
> 
> If it's not specific to USB, I would say something like "when the Root
> Port is in D3cold, wakeup events from devices below it are lost" (or
> whatever the actual problem is).

The problem is specific to the root port in D3hot over s2idle after the 
hardware has entered the deepest state.

It's fine any other time.

This particular root port only connects to the XHCI controllers and USB4 
controllers, so I can't confirm whether anything else is affected.

> 
>> This problem only occurs on Linux, and only when the AMD PMC driver
>> is utilized to put the device into a hardware sleep state.
> 
> Is the AMD PMC driver doing something magic that can't be done via
> other power management paths?  That's what "only when the AMD PMC
> driver is utilized" suggests.  But if the problem occurs when the Root
> Port is put into D3cold via *any* means, just say that.
> 
> And if you can say a specific PCI power state instead of "hardware
> sleep state", that would be good, too.

Yes; the AMD PMC driver does a notification to the platform that the OS 
is ready for it to go into a hardware sleep state [1].

If the AMD PMC driver isn't used, the platform is not notified that the 
OS is ready for it to go into hardware sleep state, and this issue will 
not occur.

So the PCI root port being in D3 while the hardware is in a sleep state 
is very accurate.

[1] 
https://github.com/torvalds/linux/blob/v6.5/drivers/platform/x86/amd/pmc.c#L816

> 
>> Comparing
>> the behavior on Windows and Linux, Windows doesn't put the root ports
>> into D3.
>>
>> A variety of approaches were discussed to change PCI core to handle this
>> case generically but no consensus was reached. To limit the scope of
>> effect only to the affected machines introduce a workaround into the
>> amd-pmc driver to only apply to the PCI root ports in affected machines
>> when going into hardware sleep.
> 
>> +/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
>> +static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
>> +{
>> +	struct pci_dev *pci_dev = NULL;
>> +
>> +	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
> 
> I hate to add more uses of pci_get_device() because it doesn't account
> for hot-added devices.  Maybe there's no need to support hot-add of
> AMD Root Ports, but that's not obvious to readers here.

This function is only called during suspend, so it should cover hot 
added / hot removed devices.

If this ends up staying for v17 as is I'll add more verbose comments.

> 
> One mechanism to avoid pci_get_device() is to use quirks, although it
> might be hard to deal with PCI/ACPI ordering issues

I did quirks in an earlier version of this series, but you had feedback 
that the solution isn't scalable.  That's why it's morphed into this 
approach, which I'd like to think is more scalable as it looks at the 
constraints advertised by the platform in an AMD specific driver.

> 
>> +		struct acpi_device *adev;
>> +		int constraint;
>> +
>> +		if (!pci_is_pcie(pci_dev) ||
>> +		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
>> +			continue;
>> +
>> +		if (pci_dev->current_state == PCI_D3hot ||
>> +		    pci_dev->current_state == PCI_D3cold)
>> +			continue;
> 
> If we're trying to determine a property of the device, why does the
> current power state make a difference?

Hans left feedback in v15 that if the device was already in D3 at the 
time of this function it wouldn't work properly.  So I excluded those 
devices.

> 
> It looks like this loop runs every time we suspend (from
> amd_pmc_suspend_handler()), even though this is something we should
> know at boot-time, so we only need it once.

It's was because pci_bridge_d3_update() can be called and change it 
again in other places.

I think if we want to optimize it to only run a single time we need a 
new variable or bit in the pci_dev structure that can be used to mark 
such an exclusion which pci_bridge_d3_update() could take into account.

This could fit in well with Hans' idea of drivers could register a 
callback to "veto" D3 support.  It could be something like 
pci_bridge_d3_update() is called whenever a new driver 
registers/unregisters the callback.  It might also fit in well with your 
previous comments about how you want to separate "spec compliant" things 
and "quirk" things in pci_bridge_d3_possible().

Could you comment on that?  He suggested it in the cover letter responses.

> 
>> +		adev = ACPI_COMPANION(&pci_dev->dev);
>> +		if (!adev)
>> +			continue;
>> +
>> +		constraint = acpi_get_lps0_constraint(adev);
>> +		if (constraint != ACPI_STATE_UNKNOWN &&
>> +		    constraint >= ACPI_STATE_S3)
>> +			continue;
>> +
>> +		if (pci_dev->bridge_d3 == 0)
>> +			continue;
>> +		pci_dev->bridge_d3 = 0;
>> +		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");
> 
> D3hot?  D3cold?  Both?  "lack of constraint"?

It's disabling both, which is why I left it as D3 to cover both.  The 
lack of constraint can't be explained in a single line message.  If this 
is too noisy for a user and you think would cause more questions than 
help I'm fine to downgrade it to debug.

> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>>   {
>>   	struct rtc_device *rtc_device;
>> @@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
>>   	case AMD_CPU_ID_CZN:
>>   		rc = amd_pmc_czn_wa_irq1(pdev);
>>   		break;
>> +	case AMD_CPU_ID_YC:
>> +	case AMD_CPU_ID_PS:
>> +		rc = amd_pmc_rp_wa(pdev);
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> -- 
>> 2.34.1
>>

