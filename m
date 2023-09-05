Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB01792BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjIEQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354186AbjIEKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AB90;
        Tue,  5 Sep 2023 03:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCKdA90DJCn3foSxAvGOEMYEdE6Nizr83hfNo9CrpthIwRJdU35Bz0l5AkBhZ8Sh+3/DLOYP9MxquZVUTdKlcnL3yqhbHu8eD5A7hN6OnANF44ZG2gnw9q8Lj3t5aKIV6Rwf527RAUg38FHuxH12oDHX7mHbaeS7WltceCP9Jl1Lje2nw+TJTO8C5xaVC04PX7SGfiziYo43XrdNY8XJhI+niR/rILElSgx4Etd2hUkZmq8e1cBLwaxmEduAOgIT14SievDY1CRI5pzrIs0HZtn5+jOcqjwSB4fiLYYQ3RtwbnKPRRQ6Or/F11YoVTYWQ8nDyzDTa0ZvjvyTtvk7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxyfHejIV285ryU6pas1mBSrFU8Jcnwl6AKn/g2F/+w=;
 b=LdAPzrNYCcXNYc52mDm40TPA+/6mWdi5mz7YEkOTpeufHt9oI6c1WGF/JlCQrWUkORs4Du9ffjJ6W+pMHf6PFmsJGwIKR4QbGL09jiczxnOEUzKjHeY5TxgyrDlvsFqv2AabhE2V0qcwUUXJ2EPwUiiEE0z2waSLh4Ti5KVmGz5yNvuSU1xvkSUCEhkvxcvjtnCwwPRI9LeHQjmBUfOZFBqODSHAox6wJaucf4ZzgQMu5pw3qOM0fOc9/QO4cdj22QUgl8oey2Pb89l9VI0jQX1JpColxptGpaBWprJJrxcFK5oRXbS0PY2n00SRm+AcjpoQpJ+eFMGjYTiC3nasZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxyfHejIV285ryU6pas1mBSrFU8Jcnwl6AKn/g2F/+w=;
 b=PDt490WzzyHQPKELFTx1qTM6f++4T3XMM42Ccm1RgJCjjcbS2WZWPVloeUeWL6Q/mhCforgGtB/FB3sQPmwzkTaImdieM/HBbIE146gMzzoUDMG7JXxxak789CTAPJl182VA9jT6Zum3qfaz0MC9BjHWgQi/1MtXJVInZ0zvbxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 10:08:56 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::5564:8c7:6c3a:867d]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::5564:8c7:6c3a:867d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 10:08:56 +0000
Message-ID: <ceda84a0-e5cd-f6dc-3e3c-52e85fda8318@amd.com>
Date:   Tue, 5 Sep 2023 15:38:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
To:     Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com,
        bhelgaas@google.com, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <20230829171212.156688-4-mario.limonciello@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20230829171212.156688-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 719af9b6-53a2-491b-a98a-08dbadf81d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP1DR9lNpe1mlbXFIvVnyKxVdUnxyCytjQa5w89BkJx3ZqI6l4ZKOZI1rANuUvG0S8bAF5H8FKhgx3UUEkGLQn+kUnWpYA7Z4qR9CLU18SK9MuBhfC97fg0svJnxDYY71QPg+VMOgB1f6d0baCjDd49h+GA/Xs1fj+GD1+DTD7AEhzuYdmbDLpgWQ1OLKED6qS/v/Mwh4jl5fWDG0pgWeDczKnNR1l7qycaLsoIc5Wp/vLpCt159nzB1sBTJv0GaumzLv66ClqFyreQBcd2hP7/JoAhJ0GQct7ItKfKEUyIovUfwoBueRD2PEzLI4i40hGBYCz3Rm4bdQaK6+Or1FLDJOBftne9SskL0OqDKSSB9XmbIgSOHstqyxwqIAbq6VOFHrlukeapZCpHNQafUriH+EjEfhbUc4zcUWwQ2le4X3vXYIf2y5fNe2KuYFglL4QWJCNJNB+fqcc9OGeoaP4+I9tRzStMB+S63gA5+0HJke4wK0oA6Xe6fSSYe8o13qxDgRLPDSm4MRjdhSUkC/iA91web28hNcSK5YS/L6FivmuOLCrsYV67OyWCZyzBzPPtL3GJ/Ad8Ir4mLzlEa9K/Zn7Uo9TWiqHpuzYdQLzkvlxjc2rJeZ9mAvpw1WWrrPeaaQSZGw37Riqv0PG2m/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199024)(186009)(1800799009)(38100700002)(41300700001)(966005)(66476007)(66946007)(66556008)(478600001)(2616005)(26005)(6512007)(6506007)(6486002)(6666004)(53546011)(4326008)(8676002)(5660300002)(8936002)(316002)(31696002)(86362001)(31686004)(83380400001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2F3L2RhQTJodnlRc1pUKyt2UmV3cEJFSXRiWDBYTUUyVVNVajBKOHlucUlH?=
 =?utf-8?B?b2xUTzdwd3RSL09BTlZGNTlNV0FOMnJCNThOOVpRMk5yTjNuemZlN2IvQWVM?=
 =?utf-8?B?L1RodEhvYy83ZEZiTCs4OGNBdnlrajdwRDhCWUp3ZHlUVlFxcTRqTkl2aTJO?=
 =?utf-8?B?ZzVJYmFJRzNyMXgzR1NOaG5YdHVFbEUyYUExenBRdUo3WEhzNHNzQTlnd1BQ?=
 =?utf-8?B?UUlGTW1Fb3dVNklhZ2liUjN3Q0Fwa0JHa3FqYXNleWRpTHkrb3lVSFg0bjh6?=
 =?utf-8?B?VEc5ckxJSmI5cmV1NnAxVG4yUzAxMStDT1lSWDFmb044dUpuaUdwQ3J5NGZH?=
 =?utf-8?B?TDNxVm1rUm5mMmxJbUhQWjEvSldCb2ZqTHh6Vjdrck0xa1hNM2Y4NXpnMXVK?=
 =?utf-8?B?K1VuQ2lwVjZrR3k5R1U1VGhqcWViME4xREJzdzREd3BnZCt2YVg0Zm56KzBL?=
 =?utf-8?B?c0VqNEhic0loaDU3dG00NkdZQUt4RFJxZU1wRjYyRDRZUHRpRHRGbmtqd1Ba?=
 =?utf-8?B?OWpWVHJ1eldNYWZHRFVxQTV6NU1qc1ZhNHk4UGNQY0p1OXJtUVlUSTVEaU1M?=
 =?utf-8?B?cGVLVlNjbmRRMURwaHQ3WmFRUnlZdGtpVkJLUlg4cFVzWktxenhZSVl3RWly?=
 =?utf-8?B?aVJ3YVFHN3FzMmdEUHlPM3dPQkxERDVWY28wWmh1dGNTRE8zYW9aV3NGZHV6?=
 =?utf-8?B?YW50RXpFbzZocjVYY1lMU2FqeFVRTXo3RHltZHBoT0hiWG1YQXhteWlPeUdk?=
 =?utf-8?B?c0x3U3NuZFR4SUlVdGdpUkVwTERBQ2hyTnZZbjdpZEtrQWtMdGJaMU83VXNM?=
 =?utf-8?B?Z2ZqWEhwU3FvWUZoalEwaUc1RGJzMHVCZ3ptSTB3Wkl3VGpndVN4UUIwODhy?=
 =?utf-8?B?bFQ3OTRHY2tNb0N4YnZMelpoVFp4bm9jSTBobXF5dHh0YzZodGo0KzVzdGRp?=
 =?utf-8?B?TzJWSndTQkdORlNMWVUreDZNUnBOcW9RN3NGRHoyNXhtMk1ubFkycEpEMG8r?=
 =?utf-8?B?QnR3ZDJvd2VacXZzejE4Tkp6cVdwOEtMNVk3dWovNWVkU2FGeFF0aGwrbTAw?=
 =?utf-8?B?RjVubGRLcVRhMGlIUjMwRUtTUUdLZ1JCTFdiUWpUdDQrNnpmZVBPanlaMVhH?=
 =?utf-8?B?bCtkR2Zvb0JTaDhMdEEyckVGNHNya2ZNT24wVGtwNnJnMjFuSFhzb3B1ZmJ4?=
 =?utf-8?B?VkNUVC8vNVRUV1FQYVBucnE2S0tvYVdTRWZ0UzNNQUx0ekZrWFZtRXNKSDQx?=
 =?utf-8?B?WmpWcEIxQzVweGMySnZjc1ZKb2ovUzZwbEpXYi9IanZsM0NVTForYXRlMVQx?=
 =?utf-8?B?MENkSHgyZmpFUENiSjdyZkR5dHJNQ3UwcysxQnlseGZNcGhTZzRKYTZ0YkU5?=
 =?utf-8?B?aHhwRUpjOENENkNWNUYwZTdwU3g0aml5UGd4TnMrYVEwbDVPczhqa2tqaFlq?=
 =?utf-8?B?OHNNV1kyWUpSUW92TnUzM21NK1pjYkZlb3RkNUNKMkp4cThBbUlWWlcxRHNp?=
 =?utf-8?B?M3lNcExlQ3dKbm5HTkZXcmpTR1FtbGIrbFVMSU1oYUMyWWRDMHpoMkwvUGMx?=
 =?utf-8?B?cW9qc2k0ZUt0TnhIMURocXJGOXBxdncrMEVxSUZBTm5tWjJ3bElPeXJLS0Q4?=
 =?utf-8?B?SkFHQVowYmVuVFdqaEw2RWlDb2VCdjVqK1ZjeWFxYWYyNzNsOGppd3NGdXhm?=
 =?utf-8?B?akhFeFlGWDJQOVpsY3gxSk1LaE1BdTkvNC9XbURZU0d4RDFHNEhKaTRBdVVH?=
 =?utf-8?B?TGFFR1lmTkVwYnNyYUhjU1RUMHZSQWhBaHBoblRzcVFoVEtmaW9HQ2JOME5Z?=
 =?utf-8?B?QWRNSGx6eTJTWC9wQWJsNVRVVUdTb0FSUHlYd3I3NEh2b0xkbWZKWXRSL25v?=
 =?utf-8?B?Q09uaitTaCtnQ1gwK2JvMVE3dHMzMW0xOURGZVpVaUpXanZmWkIwNHBHWFp3?=
 =?utf-8?B?TGhNRWNBU01QSjZtdjMxWW1DMDVUa2Ryeitwek9oQW1RaFF2VHNmV0E1a0V3?=
 =?utf-8?B?TGk3SVowUm5LdUl2SkJhMVVJRUJla2tnTnliSkRDamdOV3V3TnAxTE4yVnZP?=
 =?utf-8?B?WTl0WFIyczhzd0dUZUJjc1RaS0JkMmRDNG5qaENoVG9ETGZwUlgwemhnUm14?=
 =?utf-8?Q?qHdTJ7T8QpzM7O7USszGdf4uw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719af9b6-53a2-491b-a98a-08dbadf81d57
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 10:08:56.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAon2LDG/sfrQSijGIe+8FEN5j2o+JqCcN0hE776tH+u1XMeaEB2uOsOD8JBBrC/UPwub5GpEcbeV6R4qitYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 10:42 PM, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
> 
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3 and AMD's platform can't handle USB devices waking from
> a hardware sleep state in this case.
> 
> This problem only occurs on Linux, and only when the AMD PMC driver
> is utilized to put the device into a hardware sleep state. Comparing
> the behavior on Windows and Linux, Windows doesn't put the root ports
> into D3.
> 
> A variety of approaches were discussed to change PCI core to handle this
> case generically but no consensus was reached. To limit the scope of
> effect only to the affected machines introduce a workaround into the
> amd-pmc driver to only apply to the PCI root ports in affected machines
> when going into hardware sleep.
> 
> Link: https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

See if this change can be moved to pmc-quirks.c, besides that change
looks good to me. Thank you.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> ---
> v15->v16:
>  * Only match PCIe root ports with ACPI companions
>  * Use constraints when workaround activated
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index eb2a4263814c..6a037447ec5a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -741,6 +741,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>  	return 0;
>  }
>  
> +/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
> +static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
> +{
> +	struct pci_dev *pci_dev = NULL;
> +
> +	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
> +		struct acpi_device *adev;
> +		int constraint;
> +
> +		if (!pci_is_pcie(pci_dev) ||
> +		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
> +			continue;
> +
> +		if (pci_dev->current_state == PCI_D3hot ||
> +		    pci_dev->current_state == PCI_D3cold)
> +			continue;
> +
> +		adev = ACPI_COMPANION(&pci_dev->dev);
> +		if (!adev)
> +			continue;
> +
> +		constraint = acpi_get_lps0_constraint(adev);
> +		if (constraint != ACPI_STATE_UNKNOWN &&
> +		    constraint >= ACPI_STATE_S3)
> +			continue;
> +
> +		if (pci_dev->bridge_d3 == 0)
> +			continue;
> +		pci_dev->bridge_d3 = 0;
> +		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  {
>  	struct rtc_device *rtc_device;
> @@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
>  	case AMD_CPU_ID_CZN:
>  		rc = amd_pmc_czn_wa_irq1(pdev);
>  		break;
> +	case AMD_CPU_ID_YC:
> +	case AMD_CPU_ID_PS:
> +		rc = amd_pmc_rp_wa(pdev);
> +		break;
>  	default:
>  		break;
>  	}
> 
