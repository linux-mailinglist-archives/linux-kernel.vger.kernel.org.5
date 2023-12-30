Return-Path: <linux-kernel+bounces-13310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E533820354
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C3BB22232
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7B17E9;
	Sat, 30 Dec 2023 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLNIe9Yw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E92598;
	Sat, 30 Dec 2023 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnKXIvTmOPo3uWRFNYmZ7Erv717nwONph447JQnCBUgNKliHxZTh4OhIFB3vT9XIpRJTaxUXnZFz/nurc55mAuXIrm6Wf0yNHEf793im8wJQsB+kXKcm3o2CrttYxVOpZ8e7QbFrZ8wTO+6/pUIrhY3oCWkA/51a9wOWNcgRTQwo67X7w+sY3SqmJfco+Ab0Q5s1e7Cst/rUJWJrU+3KQs+4MifYtPSF8G1dbLHAVU+e3K3WWAWb3jjgbX8UZth1L89E01L9s+AdFiqEJ5rMWrNjIYNAYIFrU7wc0VZ77fvK0H7orXDYJvscd/iH1fhN+crn+xyJaouJxXcp2wb+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7GMhfYHcTr5RGqIPmIp40EkKLkt1NzpPpHir6Lsw4c=;
 b=Qa6Hqc6YWK31n0l8+Kitr3aXgO6y5T63osFE3ZdFDJiMDGJHtBCAKPelb++g41941Srmql3gdOUNUzeho8Jr9q6SvTEVy20epzDUfTCJLMDPVbfBqTR44SnyaooN9d3jVfzzUt+httd9N20r1NjTViYtPsGmYaP8sA5zmj2ZP+83etHdpTFWbzo0Mq4iOb5lfZB6RagGtYTOsWgY7llPMFRf8zIihCdZN7ZHGytKXmGXr7TxwinFChpgA0qGvaMomubEH5KoKlR1s+OjrmOoOeZOv34f6kjRb9Z1COlaE8y7I8Nz9pq7SbdvgwzD2n48LCgs2/5NCY8W6AED6WzUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7GMhfYHcTr5RGqIPmIp40EkKLkt1NzpPpHir6Lsw4c=;
 b=lLNIe9Yw68lwD+DQ+xEx7+KJD/8fNL5OZRjXIMiRZoFrL2FgMImRjDMqnt70HgAp9otkbpRTMDfaBY4WShkQGqpV8tVadZQFkepvebTAMClnwRBh+EvbzEaB23++4RzLciJN39P4SixyeLZBUfyQcMkvZ8nGE1mVS5P8/yxx8lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sat, 30 Dec
 2023 02:30:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7135.019; Sat, 30 Dec 2023
 02:30:03 +0000
Message-ID: <af04e964-28b9-4c31-a2e2-93d8410b5e8b@amd.com>
Date: Fri, 29 Dec 2023 20:30:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firewire: ohci: suppress unexpected system reboot in AMD
 Ryzen machines and ASM108x/VT630x PCIe cards
Content-Language: en-US
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: adamg@pobox.com, stable@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Tobias Gruetzmacher <tobias-lists@23.gs>
References: <20231229035735.11127-1-o-takashi@sakamocchi.jp>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231229035735.11127-1-o-takashi@sakamocchi.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5effc4-b774-4c24-d372-08dc08df3a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PImiX9Mg6smIehSgzoLiLMmtA83hPl9OEyrtu63lQeu4NcHbz9YryU/NLToegAjVE0o4OwFsLzoxo10EHIoxlSBKQKDqZZhUyd9YYOBds8ZXhknIRGWeu8VQy3+w3amshOfOndrjkk98sOD47otodRp9Q7OLgeAM/rPl+xkSaTO7sqbI5bNkNM1NeFPuMfLQ15C2hJif2uJy5t4cY5eaO1P5FZP5cgkGeozToUHZazwnIHLfdMzxEXq1UOl1ou7gmU3NQz931XZ32Jm6B/l/EQ4k/FSl9w0fUlywNHGIkgVIa7g51TMsGDVTnM61oXwTghjQKJtIv+x2/fsTmphMysLMX/bscG/gkCTFFjjUd/TbYST2IzK+r6e+MdC5G17ctfq+EioBJt9cW10J8QHQ11e+UGUSVve4Wjj0y4rrqxXc3X3QwKLfgLUKc0/GhxaUf34WsPUSq49gPCHPkTKqIFW2T1pEZhmzMV+kBnKihDGruUe3UNxzU+rptfAHn6147CcQPFsZdXzzc3LbVvi2VieHRkNkJ4k3bXfZ62uYj2mOG9kYiuY/YchZzWOCD8hnTwBqN+FiZFSe6BCJXkCKNfp6lLqNyNWVPKo6n8z5uMrtWA5eQOJv/lDlzeB4iYcTvjNNbVIWKgbKZBbeyQwpzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(316002)(31686004)(4326008)(54906003)(966005)(38100700002)(41300700001)(8936002)(6512007)(6506007)(8676002)(478600001)(66556008)(5660300002)(66476007)(66946007)(44832011)(86362001)(36756003)(6486002)(31696002)(53546011)(2616005)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JIYktCLzFhOG9rZGZXS201U1lNNzdtNXF0RFNoOXQyVm4vK3pLdFRRZE9Y?=
 =?utf-8?B?T1lrYnV0bUxkVHM4ZVBOMWx2QnFGdTRXUlZXd0cxbCtKcDRCNE5sRmd3VDl1?=
 =?utf-8?B?cFZ1QXVmcHV5dUROM0dvTm1TT1ErSGEyb2kybll2NU9veHJ1VXM5eUFHOEhw?=
 =?utf-8?B?QmZoS3FScGFXOFpnYTVlVVNNMm9VK1UyUURjc1BlWEhaVjdBK0lUUkFHQ0xy?=
 =?utf-8?B?WThDNGxrVEZBeExuaGt5UWFsZFdIVVBXRHNjZ1pUT3lVajhONTR5RW9sSDlI?=
 =?utf-8?B?ZWNkSWJqOFdlNkV6VkxFSGxwdy9RdFdObElXL096bTJSMCtIbUtXb0Y2YzNG?=
 =?utf-8?B?NjdLWkVJT0txQ2c0RElhc21oVWxocCtPWmx5WnQ3bi9aVVphTzN3anJzQyti?=
 =?utf-8?B?dHloMi94R0xac2xZdlNOeVlRdXNSUHd3RWdlb3RYZzByY1JycVI4RkVMc2J0?=
 =?utf-8?B?eGxSdWtYVVd0a1U3a2UwaE9LbzJ0Z2RkWFh5VWhLWjF5dkloTnVVRHp2NkMr?=
 =?utf-8?B?alR1bG12UldoK1c5QUtQamtwbHZDT0JLeFlDZ05pVjBRT21aVTd5VHd4ME5M?=
 =?utf-8?B?U3crQWV1RW1OcXo0aENqdWZFWTJDdnROcDdhbmtoajdwZjMyQU83MnFublVE?=
 =?utf-8?B?RXQxdWZDeThRQkw4Y2s2QXZjb3JGbTgycnFmZVNyeEtsc0laZHFhU3ZBaE5x?=
 =?utf-8?B?SWJtVm5FMFhiaUxld3FkU3dPaGthcmRzanNVa0R4dVRsaTBMMTlUYTcrWFp3?=
 =?utf-8?B?R3F4MnN6a2FtSFJ6bVdhZEJVRUdMNXE0aVU4NThrUmRETVRFZGRyTW1TYXB6?=
 =?utf-8?B?bE9KcW1VUkhKY3FCWjFxZzF3OGl4dTlqS3JXaUJuTlRWNFJVRVEvMHNtc3Bu?=
 =?utf-8?B?Mm83Zi9BR1hBalk2eW91dnNWUlFWdG0vQUVVTm1weDYyaGM2eEZvd0Erbk1m?=
 =?utf-8?B?Qk15bGhoQmFPTS82c3NGTDNoZXhwbzFRRjNPcm1VdjVxY0NFdW9PVGRxUVV4?=
 =?utf-8?B?MTdMV2ZTaWx3R1JUdnhJYjlVR2hzdnhxOHFkMGNuZjBlMVNEZlVrdkRRYmhP?=
 =?utf-8?B?aUZHUnpZWDRlUWRzQ2MyK3dQcHlKdXZaNzk0U3NTTkZKdWpWenZZSkNOai9y?=
 =?utf-8?B?VGJPWERqRWV5SWVQQ3B4bjBScVBZRjQwbU9xZlN3dDk0cDRGRFNidHJTcVE1?=
 =?utf-8?B?RHRvd3lHUzY0cjVqNElVODN3WWNRWVVlRHF6WWhodUJpZGYwRFpTQk9xaE11?=
 =?utf-8?B?QUtkQlFwcHFLRWV5OXFJNVljMEhwMXpvYkpXcTVWMys4dUVMR2c3N0ZZRStU?=
 =?utf-8?B?WnpoUEdTd1lGRkJ6SlZOTUNSU2t4UXcxVXI1SHJNaitmUUg2Y1c0bVZ6VUJS?=
 =?utf-8?B?S1o1Q1pYTkFmWmhsR04zM2dsZVVjalRLWFRVdVFvYStvZTArTHFqNjVvVDZX?=
 =?utf-8?B?SmRiK21XSnFjczl6TzhjNTI4dFArdnVOb2NkT2luaThqUW5CVTBJZHU5Ui9R?=
 =?utf-8?B?cEt6WGFlVERvbTg0ekg4Y3BYN25BU0FTTmNzZTB2WitpNjdyenlvb2VBR1dH?=
 =?utf-8?B?OThrc1I1aXBxYzdUak90c3YxUEJEbUNtdEttMm83K21XTFp5TVEyVVRWRFhU?=
 =?utf-8?B?MWxSa1NLQm9MWnpXQTgybzJGdXdtd1pvZER2SmRMVy9IRXVnYUU0djNHaDFt?=
 =?utf-8?B?SXREcFl5SzBTblBQakh1VTFOSEF2eVYzcDVHOFBBNWNKdjIxbTg0d2lwSWU4?=
 =?utf-8?B?Tm1wQXhZQitRZy82cmErM1N1OUcveXBYb2lESDRBRVdvRUdWQld0QWlLcnp6?=
 =?utf-8?B?dFhZWkFmSWRiN2ticEMvZStBQndLRGFwMFNPRTg2cno5WXo4K0JqRUtFZFgw?=
 =?utf-8?B?ZW13cys2Z2gwRThma2huYmZGZm5GOTNRTVVqM2dYU3BrN0pwTHR1bDczbEd5?=
 =?utf-8?B?Rk5sRDJ2azZJYy9mMmJhVWV4T0FJRXpDYmxmT2k2RUJiR3BtY01WNk16cEd5?=
 =?utf-8?B?Uys2aVRLTnM1Qkt2Z0t5dGh1TDUxOFV2U1lFUlVuWkZUTVZTTmEwQnhCMksr?=
 =?utf-8?B?NnQzVUZ1emxaT1VuaFRHK1lFTFkrNWZ0V0F2aU5MS3RqVDc3YzI5Q1luVU1K?=
 =?utf-8?Q?Fu81CZy8Ldn5bi9or28cDGdHR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5effc4-b774-4c24-d372-08dc08df3a69
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 02:30:03.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWSI9fnKwvmtBkVbAk5il6r+uWplYj1/sajctZTzt9yEflJ7PngOunKiTotp9tIGXieEKOOvUato/zSexut/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439

On 12/28/2023 21:57, Takashi Sakamoto wrote:
> VIA VT6306/6307/6308 provides PCI interface compliant to 1394 OHCI. When
> the hardware is combined with Asmedia ASM1083/1085 PCIe-to-PCI bus bridge,
> it appears that accesses to its 'Isochronous Cycle Timer' register (offset
> 0xf0 on PCI I/O space) often causes unexpected system reboot in any type
> of AMD Ryzen machine (both 0x17 and 0x19 families). It does not appears in
> the other type of machine (AMD pre-Ryzen machine, Intel machine, at least),
> or in the other OHCI 1394 hardware (e.g. Texas Instruments).
> 
> The issue explicitly appears at a commit dcadfd7f7c74 ("firewire: core:
> use union for callback of transaction completion") added to v6.5 kernel.
> It changed 1394 OHCI driver to access to the register every time to
> dispatch local asynchronous transaction. However, the issue exists in
> older version of kernel as long as it runs in AMD Ryzen machine, since
> the access to the register is required to maintain bus time. It is not
> hard to imagine that users experience the unexpected system reboot when
> generating bus reset by plugging any devices in, or reading the register
> by time-aware application programs; e.g. audio sample processing.
> 
> Well, this commit suppresses the system reboot in the combination of
> hardware. It avoids the access itself. As a result, the software stack can
> not provide the hardware time anymore to unit drivers, userspace
> applications, and nodes in the same IEEE 1394 bus. It brings apparent
> disadvantage since time-aware application programs require it, while
> time-unaware applications are available again; e.g. sbp2.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1215436
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217994
> Reported-by: Tobias Gruetzmacher <tobias-lists@23.gs>
> Closes: https://sourceforge.net/p/linux1394/mailman/message/58711901/
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2240973
> Closes: https://bugs.launchpad.net/linux/+bug/2043905
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   drivers/firewire/ohci.c | 49 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index 7e88fd489741..62af3fa39a70 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -279,6 +279,8 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
>   #define QUIRK_TI_SLLZ059		0x20
>   #define QUIRK_IR_WAKE			0x40
>   
> +#define QUIRK_REBOOT_BY_CYCLE_TIMER_READ	0x80000000
> +
>   /* In case of multiple matches in ohci_quirks[], only the first one is used. */
>   static const struct {
>   	unsigned short vendor, device, revision, flags;
> @@ -1724,6 +1726,11 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
>   	s32 diff01, diff12;
>   	int i;
>   
> +#if IS_ENABLED(CONFIG_X86)
> +	if (ohci->quirks & QUIRK_REBOOT_BY_CYCLE_TIMER_READ)
> +		return 0;
> +#endif
> +
>   	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
>   
>   	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
> @@ -3527,6 +3534,45 @@ static const struct fw_card_driver ohci_driver = {
>   	.stop_iso		= ohci_stop_iso,
>   };
>   
> +// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
> +// ASM1083/1085 brings an inconvenience that read accesses to 'Isochronous Cycle Timer' register
> +// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
> +// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
> +// while it is probable due to detection of any type of PCIe error.
> +#if IS_ENABLED(CONFIG_X86)
> +
> +#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
> +
> +static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev,
> +							    struct fw_ohci *ohci)
> +{
> +	const struct pci_dev *pcie_to_pci_bridge;
> +	const struct cpuinfo_x86 *cinfo = &cpu_data(0);
> +
> +	// Detect any type of AMD Ryzen machine.
> +	if (cinfo->x86_vendor != X86_VENDOR_AMD || cinfo->x86 < 0x17)
> +		return false;

Maybe it's better to use X86_FEATURE_ZEN?

> +
> +	// Detect VIA VT6306/6307/6308.
> +	if (pdev->vendor != PCI_VENDOR_ID_VIA)
> +		return false;
> +	if (pdev->device != PCI_DEVICE_ID_VIA_VT630X)
> +		return false;
> +
> +	// Detect Asmedia ASM1083/1085.
> +	pcie_to_pci_bridge = pdev->bus->self;
> +	if (pcie_to_pci_bridge->vendor != PCI_VENDOR_ID_ASMEDIA)
> +		return false;
> +	if (pcie_to_pci_bridge->device != PCI_DEVICE_ID_ASMEDIA_ASM108X)
> +		return false;
> +
> +	return true;
> +}
> +
> +#else
> +#define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)	false
> +#endif
> +
>   #ifdef CONFIG_PPC_PMAC
>   static void pmac_ohci_on(struct pci_dev *dev)
>   {
> @@ -3630,6 +3676,9 @@ static int pci_probe(struct pci_dev *dev,
>   	if (param_quirks)
>   		ohci->quirks = param_quirks;
>   
> +	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev, ohci))
> +		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
> +
>   	/*
>   	 * Because dma_alloc_coherent() allocates at least one page,
>   	 * we save space by using a common buffer for the AR request/


