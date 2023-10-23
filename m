Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FD7D3E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjJWR7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:59:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71451A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwSiS6W1zXWM8Dweheyg34VN88Kk6MRSQ5Addk9MFc8yJ1jcqYmj5FbZtCHw+ZCKrcvj+dAQ89r9R4mllKi7gYra0PwkQw+Ny1ZY5K1d2vEwKcLE804qZBQlWHKh3csGNqZT9KriLzj0Uv19DOvEkNH95SYzvaJtgv9f+SRgPwPhcNNOuSOWza6RVu8fOKucIHKQVmbfkqSZqnZTwWGeBOD7ir9VhnCSHWiACLQY+fc4rXi8Xgke4Cy40H7BxbNiA68D2Qf2gkzTbSIuFf+anH/6c+01OaNgygOvC2qdeykHf/nmVDxiZPUsFIxbhEsqMx+UF0IsO1MZ4PfSFgDlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbWw84r4M55rxoAuSIYpR+ncy8p/fXe4TWUyb5vwO78=;
 b=bxJrRP5ZshiquI17p4kNEB4M56jB7sribmeEBpXUwfpiRjzoDPnB1JQjq+okb8qPw3E9Tr/8qNoB+xCIJvEg0VRpEcim3IXUIwaqZtya/GFXUBp99AtbrR2mtBTfqEjrWV81Jqe6ZSIRoE5TEg0vDj1nWcnTvYpkWeFvtW66Jmth48YKHy363dm9tE/EM8WfKvz/7VTp2gZrpzfsBuWMvCdn1W0XSgtJokdXUMfsTBi1LxG0WdnwtnUrMzU2tVF9jHL0touPTEgLfD/xvLgmR5fLY1y9B4aADiJJEKQXQcMJ3RI33iRXgyiBCZFuh7vadbsuhp3zcqzhzwmiLY7ceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbWw84r4M55rxoAuSIYpR+ncy8p/fXe4TWUyb5vwO78=;
 b=Ihd+F7873fO1/Y7etU44S/iIZEZ2URsJ30wxo4mjGtcs4LO59Fx1VBsN8clwvb3EMFDuckp9DqZvA2ngEQqOSAiYvMibQ+9xPo3vti4umDh46Mr5ioQvVslGUxrvnsixmmAkzXiVgskfu8baHrwoRFeT6R+C5XqqLoJRKSKsDp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 17:59:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 17:59:14 +0000
Message-ID: <847b9fa0-2785-4174-a4b8-82f1ffe8323d@amd.com>
Date:   Mon, 23 Oct 2023 12:59:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <08889426-e8e7-491b-bcc6-fd001bad3269@amd.com>
 <87lebtcjnr.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87lebtcjnr.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:806:6e::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e187bd2-2b88-40f1-635a-08dbd3f1c47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KIxiLjHa2lizvbNJKj55pv+gNEAOGJ1n+++tUfAIIRO4pkCM9WMAa3X6pr0KLuW6woKe2IqdfIj2MEiOW/SSJpAm9g12UIQOYJN6v/WsCJ3GJ7+MikdIaQyiEF2/OW+dQ/LiWIKgmSI0r9QcNu3FjbGjAgFoRlfsjbeS9sYxsul2SULl5hnxJ1Ntm13GUGw8034WABYHXeEmPUqyZ8clGSNoKnGiCPrseDDcwC14kTkeMvGBDjmf2KnjOKaaWg8NEEwWNiGCV3Dm2gFKSRHDPHtA2OAR4RkP1LFr9Kv1JBK6xO23nFZKzOLtBFDmEwTPaV1kReQlRcPwG8hIFw/T3UzMRNQ9+toOTtxLfVBk8r4ahRyemBsYEWfrPbouhpwRRFv7msvOVbVhEnUGpZwmsgoQ9sIDPnxecY9EWT7BWB8s4qRf4PkHKYJvfdY+G8DTM7TGLzrijBueF8hlA/KlJbYabrpyWz/fW6tE8sQyuiHx/QMjqYVOiinshSSqhSXBvp+304dxDthyTODDL2uxgQs6IcqisoRkVycBpVKXnLqP9gcTJor5IaKAaY9EGX/de509s/ytOsIDIjlsOjnW7KB6HQHpKa4tTNtSakIbSBFfOCe41XTzwBzE1Va48w+mgjx7BimAy1cixQdlXeaJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(44832011)(2906002)(38100700002)(316002)(110136005)(54906003)(2616005)(66476007)(66556008)(66946007)(6506007)(6666004)(478600001)(6486002)(53546011)(6512007)(83380400001)(36756003)(5660300002)(31696002)(86362001)(8936002)(4326008)(8676002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEV4ajFnSzlWN3gxWEtmalkvZk9taVFFL0pxcjVyZTBVYkhGM2JoM1c3WVlr?=
 =?utf-8?B?bnBPQ2U4Y25vbDJ1bmtmbEtydGY4T1loaXJvZWk4dTBvbUk1VUhCaDJSVGJG?=
 =?utf-8?B?eVVmTSs0a01iM1VPRllkS2x6YzBiQjJXWVIzK0dyZUVaOXFSTXBub2FYZlhr?=
 =?utf-8?B?OFBjMDZ3QjhnM1BjY2RlN2pyQnlOY2pHYi8ySXV2Wlg0YVVqOWtHTjJTV3hD?=
 =?utf-8?B?Z2hmdlJjV3ovU09XYjNvNjZySFozR1cvWXJDSEFHTDROdHVrd2Y0Und0aHJh?=
 =?utf-8?B?c285U3kvdjZCUmI2Wlh6Vllrc0tNNjYySXRiTGYwaVgvT2NBc01EeW1NZk1J?=
 =?utf-8?B?d2pxUElkeHIyeTlnMHNjRldtLzBLMytzOFd6OWpnaHIwOUhiLzhzL2M3Y1hL?=
 =?utf-8?B?enlOdHA3cFRQekJCclhSWDc4OUwxd1dQbW5MUEpFdFNObjVqeGxUV3Z1Y1J6?=
 =?utf-8?B?WFA5c2IvSFo4N2RGNEZKc0N4VW1wbWtDNEtsUEtqK3RPK2RaWHkweDBqb1VW?=
 =?utf-8?B?eFJtK2hSS0RnOEdJVWIwdzROK3NpY3llSUpQM3pNdXNSN3RHdGtSRVFDZGJp?=
 =?utf-8?B?T3Fwblk2SmlmRUVkYzNObHBJb3lRcjRTWHlXd3VHUnljM01KOXg5VmREbjE5?=
 =?utf-8?B?ODlINEdaSFJTbzJ3dWFudmttZHBGY0VQeTAzUmhQajNaUG1PTmdUWUMrMENH?=
 =?utf-8?B?YzVscE44RElIdFpQY1ZjTTNxYmZRVlZkWUpEWDhQUUVNK0JLdzFIK1htZDlu?=
 =?utf-8?B?QU1KQjk1WW5VTldxQkM4T1k3RGY2TlpZUHpzWXVZQlFaOEp4VlBpZkNhd1dT?=
 =?utf-8?B?S1Jjc0RuQ05hMUQ1M2ZLUk1mb0tqT2xXY1o2TFVLeXluOWc5NWhHVmt2Vmo2?=
 =?utf-8?B?c2J5dHRwem9uNkc5S1RLVXk1OTZmYWlWck1ESWN2ai9NWGpmc2R4TnRreXZT?=
 =?utf-8?B?ZmpQOEt2NEE0blNXRy9wY3llckUrN0NpdlVhODZVM1QzaFp6dkgza3RjYlRq?=
 =?utf-8?B?S01PTElnWDhqMk8vTDBXL0JtSU5QNTdHdjh1R2ZCNW8rYlYvSUowVG44Nzd4?=
 =?utf-8?B?UVB5aVR4VllTWEtERW4vTm1ZblgvSzJlQ2RGSmdwSktJQ1liei90SENZUEs3?=
 =?utf-8?B?Rk5rOG50V213eE4ySTJhdjgva1l0ekp3K3R2V0U4NUdGYU9KWUFLcXZWQ1pD?=
 =?utf-8?B?WVFLNG5HQ1Q5d1VpUFJVNkw0QlRFMGpBbE1kMlRhelVJeXFYUHlZNVRuQXA5?=
 =?utf-8?B?RmVmYWhCK0tmS3A1THR3VGVzYS8vWW9zaCtZOE5teC8yL2h3Wkp3WmhUd2xV?=
 =?utf-8?B?QnRJellvaEt6ZmdpYSsybFRySjBGLy9PNk1BaTlLQTNoTnp6eUgvVlZENzh5?=
 =?utf-8?B?SkFzUXdSUTJVZUF2bTlKWG5oWGpIRHhDTkhoM2xaanFzcTB2alpwa010aEdF?=
 =?utf-8?B?bVh3aWdWbzFGR21hUlR1Tit1MittR0NvdWx3cFA5ZWN2Q1EzUFordG5kZTNN?=
 =?utf-8?B?VnhlOEJLZHBWSU0walBBQTFGNlBHM01SWEhOMFR1RkJ5eHQwTVZRbzFMMFNr?=
 =?utf-8?B?Rk0xT3NMZHFMR1doMmk5bkk0YkYwVnUvcXhUL3FuSExRdXdUbWtDdEtMd0lO?=
 =?utf-8?B?MytBSHhxd05YcjJTSG9XRUdydkJ2T0JmVDZGL05pVlI5dmFxaGtvN1JxTnZW?=
 =?utf-8?B?eXg3OVZ4dDhDRVpqbnVBWW1CODZ0aXk3MHZzdk1tRm5id0ZVV1pmbnIwN1dU?=
 =?utf-8?B?aWtLS204VG9yZ2JqdkdKTmVtcEU4YzhyMldzOGd4ak9ScDR3ZVBIUFVIMiti?=
 =?utf-8?B?VWEvRXlSbU5TOTRyVUNVVG1ZcnZBMFZpRlpwdFFNV3lZakZyTlQwOVlGMFAr?=
 =?utf-8?B?NURienRwREF1MC80aXVXUXVXUHF0SmVFc0c0WGdNS3crM1BJYVZRdlZzVDZH?=
 =?utf-8?B?VERtVUtiRkRoRE5FdnRUeGtDZlc3VFM1bzNWZ2FtQ1hhUWp6MlowY0MxSnFy?=
 =?utf-8?B?VVAvU0lMRk03MTZnNUxpTTF6bGp4LzdpZEZuUEdYc3QyMFFLNWVlQlRsN28r?=
 =?utf-8?B?VlEzQ0R6RitBSkltOUhBOHJ1VjhsSnUzY1cxVVZDT3FzYithR3hVQnd1TEtx?=
 =?utf-8?Q?XQFs2RiOQlUOIeRzy8mLJ+Q0w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e187bd2-2b88-40f1-635a-08dbd3f1c47f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 17:59:14.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmWljXnI1FWDI1h0yO530ca80uwYgi5sBBlV897KM9lD8gQ8yS+U/8RxDUWjp4TunAtuwy3NNKZNMJwgsdu2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2023 12:50, Thomas Gleixner wrote:
> On Mon, Oct 23 2023 at 11:17, Mario Limonciello wrote:
>> On 10/23/2023 10:59, Thomas Gleixner wrote:
>>>> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
>>>
>>> So the real question is WHY are the DISABLED/UNSET flags not set in the
>>> PIC case?
> 
> Do you have an answer for this?

Here's the problematic call path:

acpi_dev_get_irqresource()
->acpi_register_gsi()
->->__acpi_register_gsi() [ Which is acpi_register_gsi_ioapic() ]
->->->mp_map_gsi_to_irq()
->->->->mp_map_pin_to_irq()
->->->->->mp_check_pin_attr()

In the legacy PIC programmed case this function can overwrite level and 
active when acpi_register_gsi() is called.

Without the change I made in the NULL PIC case it can't.
So the resources get disabled by acpi_dev_get_irqresource().

>   
>>>> NULL case:
>>>> handler:  handle_edge_irq
>>>> dstate:   0x3740c208
>>>>                IRQ_TYPE_LEVEL_LOW
>>>>
>>>> PIC case:
>>>> handler:  handle_fasteoi_irq
>>>> dstate:   0x3740e208
>>>>                IRQ_TYPE_LEVEL_LOW
>>>>                IRQD_LEVEL
>>>>
>>>> I guess something related to the callpath for mp_register_handler().
>>>
>>> Guessing is not helpful.
>>>
>>> There is a difference in how the allocation info is set up when legacy
>>> PIC is enabled, but that does not explain the above resource flag
>>> difference.
>>
>> I did a pile of printks and that's how I realized it's because of the
>> missing call to mp_register_handler() which is dependent upon what
>> appeared to me to be a superfluous number of legacy IRQs check (patch 1
>> in my solution).
> 
> What exactly is superfluous about these legacy checks?
> 
> Thanks,
> 
>          tglx

acpi_dev_get_irqresource() tries to set up to match what's in _CRS.
If acpi_register_gsi() fails, the resource can't get setup.
