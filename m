Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD578B42D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjH1PP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjH1PPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:15:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D31E0;
        Mon, 28 Aug 2023 08:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8cfjTEt/sMeHp7u7vAyKPP50jF6aIkAHzuVmM5sylzrqEEY3h4hstoIZXZl5bpqoE76HMqEXJ/4ynhJ0nt1IrHnILhCexNfJUnw8hEQ/H2CRMQWv9NoCTEIAiiTH2NFg93F+FdF6IVNmQmXjPzWZ7K6bMkmTVUpPEmWlk5DxvtnAtEmG+ogNxbAjIX5S6xRVUCwsodQ0C+9gqCFNL7pLXLymleDvvWnvt5wEQ0cifzYUZIhhlCsVlEBNqfw60UlKPYpcH89ZCu8O/VhcWLDEX/k/WDTIm8FRvORmU7F5yq7h3BGAv9QkUQ0i++nijl2VAcBb0KmDZK6zJEy9wxpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBgFLdaKaNyrGr+dqoKfk2k3vwzWf7Gv5t7XYDzqO+w=;
 b=bVPY8SD/tPL5OGAZwHNpdLd1oZN0XPA4k6gTimRR80G9GQssLRHOdKG+j1JO6YQWfTQSSYlUZBLvZg6DbQ+ud1wh4XbNMhAIDFEZhIUKSpJnFKRiF8XDYMONE890XrwYnsGoIdrIoa+hjx6Sh43jETwTVoQ1z9UGQgM1T9018SFxdJ/l2jEAr5dvR4QQ93qg2sc5Y8uLlHwu3LwyZRDoMg5jvjmM/NzWVB1SCfEb0JCA1g3C62fR37B/rBNAWGiFVUGYYV/oV9iRGNx72LtDRF05f/mAC3hAiukHEM0EdTITgx1gzQj7YmKtdyDwERFK69RFRABFst5eBNNFTpaE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBgFLdaKaNyrGr+dqoKfk2k3vwzWf7Gv5t7XYDzqO+w=;
 b=O26deq2erMNNq6FXDndXCoxxCBsexFARZWa3Ieu04oOmy5bAY0IHbhH7zVTFy8hpoOIYyZRvz/Ei5TbG1L2M6ff+EMb475P4cesmw6Uzzmh9sSd2BKaHLuQ8tJyDSrbb7P57TXn4+y4uxIMKwqCCX9xYiFZCo8nag0qZ3BIkTbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:15:10 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:15:10 +0000
Message-ID: <0ebd3eb9-7629-4897-b1c4-01574145d02d@amd.com>
Date:   Mon, 28 Aug 2023 10:15:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/2] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Shyam-sundar.S-k@amd.com,
        bhelgaas@google.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        iain@orangesquash.org.uk
References: <20230828042819.47013-1-mario.limonciello@amd.com>
 <20230828042819.47013-2-mario.limonciello@amd.com>
 <53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:806:6f::31) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: c79e26ef-6d42-4440-1a88-08dba7d99162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2b2tzgqf/XUVagtiLNLlACujbD2+TnUGHqVIh8VOyQPOysgmqVfeA37B30SdCvw+Fr/ovqk1UZgZG6TpTBKhwW+A9V6VZ0UggVtL+u8bm2s61MAe5r93EU2gChaDttHVBHbAw/O1jqL3lLeAd6RPNyrUuayGc7LSZq/6VlYnP9t6wL50igrRdI+lGWB6Ts11SAZnIX8hint8M2Ek4S6aRXlYQjWiT1MTdimC+a9tcl/7Uwc48YmCz8L2kn8HFmlfbTvr+/wapvBMkZ8yZw/D0tAH82SOoSV0nvRBC+vwm3x78XyjyOwH12pR0zAc99wHbjEU0gURseJksIFzfi6ZuKAMunMy6NeGVGSq2vYRa9XGk2cYif6ihSeToMLHI8hNRa/68YWic+/h3xGRnunPzXxl75n79Gfgz5fGb83XYFHYPLUD/TkEPzfB9STkYMqjrxsrqz+W2LoLSW8I+fKtYqzLwq26TsHVBrdO4q/xd4PgnQ3CpDSy3Pxx21c9IogkWjT5KWn8frkBKWhTB+S+MLlsV9c+9NhLkY5VUba7Pd3qTjhvIs0K0s0hSZVgjMs0a1p2hOuZnEnQoDsquRsA+Qrw2/xvkguOFvmXKIIG7ScVvdUP6kGnI/T1800dkd9Brr2nQr8G1Qy1E0rebWz6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(31696002)(86362001)(478600001)(83380400001)(26005)(2616005)(6512007)(6506007)(6486002)(53546011)(36756003)(316002)(2906002)(66946007)(66476007)(66556008)(5660300002)(8676002)(8936002)(4326008)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEtBT2N3ckkrVCs1T2toeG9qN0pZZHhpTnk5YzFYdkxaeHJVVUxlanNjR2hB?=
 =?utf-8?B?VHpzbjB0YUFpRGdBY1FsbmpIcHBrd01jWmpza1ZTWVJ3VHpXaC9QTXhNRVVR?=
 =?utf-8?B?YkNDMURQRmw5Mm9ncmJhTHB5Yk5SYmlFRnVyK3huZGtJTlMrQUR0YnJ5TTNr?=
 =?utf-8?B?ek4vSk5EcktNUitMQVJMdmlSRnJJMjJWNFdmYjFoL1FlYzRwc1E4aVg4ckg2?=
 =?utf-8?B?T0MveHMzRVpsRGJKQ25kZ2QzTXVqSW9ja1dvakdsVXBDakp5M0l0YVZvczlo?=
 =?utf-8?B?Q0NRNEozU3AxS2NrVW5acERhb0pXbmN1NXE3SERyVkduTkZ3TFZyQVR5bm9v?=
 =?utf-8?B?Q0NwK2EvbnhxKzRiTkE4NjlvTTZnQk9jUGtpcUwxYUFCUHZvZGJ1NnpxRGlP?=
 =?utf-8?B?Z3hqTExaam9Xd04rbXU3RnVMa1duNTM0N0xRNG1RenFCbXJOS3o3NHdOT2Rw?=
 =?utf-8?B?UzVpMFdiemNiWmdmNG5sTDhKbmtmTGZPM2ZKUlNWQVJERlI5Q2NQNk0yWmdl?=
 =?utf-8?B?bXZhYzBndHBMUWkvaWNyREtSMzU0MFg2RnVCYTNIZXZ1WHQwRzdDdGNTNGE5?=
 =?utf-8?B?RVdMRWI2Ty9KMHg3b3E5d0pBNEkxSEs0N28rUS9Ma0c0cmExaEszNnRuTjIy?=
 =?utf-8?B?RXFpSnZFRlgvRE9SeWJqbFBlaFMvRWpWZTg3WVBIWEhFSzZuTDc4TVlROEQz?=
 =?utf-8?B?cjZXbEQvOEtsWFlSRDM2QWdkQnpKdi9XVXRKR053UHA0azBuS0dSUlUxTFgr?=
 =?utf-8?B?NzBBOGFwZnIwL2l0SVpPdEdFS1phQ2hMNGdoV3dWOHdEalBNa1RvTWFBREYr?=
 =?utf-8?B?clpKMEtaeWVkcHJHRHZyUkpiM0lZeFdPOG1tRHVST01pVGh4MWpKYnZ2Tklv?=
 =?utf-8?B?SUlwQTUzWnJHN1ZQMU8vSDMwYXVMYUlhNjNsOVVRR0ZBZUNSSm5rME90bGx4?=
 =?utf-8?B?ZU9IbVphblY1TEQ5L0FNYUluWGltYUhnK0c3d2lNYzFoMytvc0o4QnJIajBp?=
 =?utf-8?B?S3BDckpHUjlJTUlJeThCek8zbks5b2g3cThyMGdtVkM2WStab2NraWdEWFdy?=
 =?utf-8?B?cTc0TUFDZlk1ZjJVRzZKSUxQamFPazM5RGpNUGRkWkpOcEx0NGY2UEFaN3da?=
 =?utf-8?B?VWhSbnZwN3IweXAyOXk4TElpYThPRU9pUHBEb2NwQ2ExUzEvNzZrUUVUMm1H?=
 =?utf-8?B?Q1RZWklEQnFKZStVdDloT3RwTHdZaVNTZGNPT0wwN1poWTE5YUE0WC9VeE5w?=
 =?utf-8?B?Q3dxc29XVHJvM29uRmFOa3hXVDlSNjRtUmthMUpvVUd4NHBBUzFoeEpZQnRj?=
 =?utf-8?B?U2dySDVwTkVJTmZrYzI0R0VpUjhZRk1vc3ljUTVZcmIybmpnd2xjN0t3VVRU?=
 =?utf-8?B?ZHZQbXdrbytQUWwweXhTdGswTlNaYkd4Z0lVTjRzcGo5ckdvbXRTMW02WU9r?=
 =?utf-8?B?MnpJNnNPcmdaZ3daK3pZOEo4d3UrcXAvVjVsZTJuTEw3Wk5xWEJpNjlNeVhE?=
 =?utf-8?B?Zk42aDBqSkZDVGZjNmFtZEVDR3QxbzEvV0JZUzNFVmxrUUY0VmxqUUVIUFly?=
 =?utf-8?B?clZ2bkF4RnBFQzU1UnJoWUpXUkExSUYyQnkrTTRVOFZ1TTVsRkU1S1NxbXA5?=
 =?utf-8?B?S1NtTCtjdWhYdUx2SnQ4Z0NBUGl0T3p4SXR3WHg3NTFSa1ExYzI2Rm1sYlov?=
 =?utf-8?B?ajYvT3pZMmo0Mml4VVc0N3gvOVUwYi93NzhVVVpJYVdLUHpmdVZVakY5cUxS?=
 =?utf-8?B?YWQrVW40VThscUFNclNrYXhhV1NpM3dTRHVqWVQxTW5MbG9iN2MwanJyZXhO?=
 =?utf-8?B?MkJGRXJPYkh3MElQRU4xZkljZUtHbEMzc01IamtRSVFydVBGcVp6ZU5QYk9G?=
 =?utf-8?B?Tm5ZRDBwb2VuWklSOTA5N05EdTVGeUpQc0NHQU1ldW9uZ044OEdwYk1STVRJ?=
 =?utf-8?B?bFpwNXBFTlhoZGlYNmRFNVU3b3lzL3duL3F1c1Y0NmNDTk44anp5NHJZVlNu?=
 =?utf-8?B?WTA2UUdJRDI2VkxyUnh5TllUVDAvVVVPQWthcGE1aXJUUEtQK093Qk1CelUx?=
 =?utf-8?B?eUZDMldlc3REOGl1UFpOK1dWRHRGSUkvZVpyTnF5cTdiSk83dTYyeDYwNGZU?=
 =?utf-8?Q?SaI+DxIz1E01lmcdZFiLh4j+k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79e26ef-6d42-4440-1a88-08dba7d99162
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:15:10.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXmRaJPsAMtNmMoX9FpRmUuGOcqgKdXUAStZnKiJix/6M8rRtzBd/1zLY7ikDal/GtdrTY8GiiPw7LDYQsxGdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 04:19, Hans de Goede wrote:
> 
> 
> I'm fine with moving this into the amd-pmc code, but I have some questions about the current approach:
> 
> 1. The current approach sets pci_dev->bridge_d3 = 0 for all root ports, I assume this WA is indeed necessary for all root ports and not just for one specific root port ?

For the issue reported, yes it's only needed for two specific root ports 
that the USB4 controllers are connected to.

The reason that I applied it to all root ports is that this is what 
Windows does over Modern Standby on the same hardware.

For stuff like this I generally prefer to be "bug compatible" with 
Windows if we can.

I have another idea here in using the new 'acpi_get_lps0_constraint' 
symbol in the context of the workaround to figure out which root ports 
to apply it to.

This is something that I toyed with in earlier versions of the series 
generally but there was concerns for regressions in other hardware.  It 
might work well in this really narrow context.

Windows uses the constraints to decide which devices *to put into D3*. 
We might be able to use them in reverse for the PCIe root ports.

> 
> 2. The current approach runs from the suspend pm-op for the PCI-device for the PMC. So when it runs we know that the root-port for the PMC will not have been suspended yet. But what is stopping other root ports, which already have had all their children run-time suspended before the system-suspend, from already being in suspended state and thus possibly in D3 state ?
> 

That's a good point.

> And we also cannot just set pci_dev->bridge_d3 = 0 once on probe time since pci_bridge_d3_possible() is called every time pci devices are added/removed so then it may get reset to 1 again.
> 

Yeah; that was my finding too when I was putting this approach together.

> What I think is necessary here and what I hope will be acceptable to Bjorn, is for platform code to be able to register a callback to be called from pci_bridge_d3_possible() which can veto the decision to use d3. This way we don't pollute the PCI core with this, while still allowing platform specific tweaks.
> 
> If we make this a sorted list of callbacks (allowing to specify a priority at register time)
> instead of just 1 callback the the 2015 BIOS date check could be move to arch/x86 and the DMI blacklist can probably also be moved there.

Based on the conversations that have transpired so far on various 
versions of this in PCI core I don't think Bjorn will want to move the 
2015 BIOS date check to somewhere X86 specific in fear of regressions 
for non-X86.

> 
> And the platform_pci_bridge_d3() check can then also be a callback registered by the ACPI code.
> 

Sure, let's see what Bjorn thinks of this idea of yours.

> Regards,
> 
> Hans
> 
>
