Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40E797DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbjIGV2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:28:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47CCB4;
        Thu,  7 Sep 2023 14:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaBMIvi0gZmKDVUf0cUaUTjOH7+ApBBSaw7YfgkouYfAEScy6TLKE4s/uu7/vfT8lK3jvFLseEByobeIn58L/n5CG5tY/NhzXF6/pUY4lVY35mRd6sbIQAvEFy6Bx3EYH+NAwvXzajSygbW7DHfpmoKugs0b7gvnL3CkCmaWMNNJ7nGzWqZDOmlAUeen0OgbRAn0uqMPf9cFTJ1S9TymlHI641s9t2+wm4OIHawPrJQ44fmOImi4F7lnfZzpG9bQiqFAAT5Ni+afgr4nWIyfQZ0cZp7T1fOr1zsrKA3ugwswQpWCXVwiDQ/gL7z8QN+TnIZ4HrnBPQGzMpLiOPJ/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk4TqHirJ82BYmIrxnO6gw93IA4OvP7bF5MzRDYQfwo=;
 b=Wy3HWDBTPOCNxdwLBO1Q1JXAqa1PIpELbYFXepWiAFI15aNVcYhpOlpKoDGEcLdj6xobJIRGEQVTAUTrJE8ksO0HFhuOvsxgaeMMuUNZsQUiULrRjYXBuwKse6UE2maPV/7KO27BwCkh5iZpwX1p0k/3A8J2HiNDfNKXMFrCNDCIzcM7MHmyd/GTXlhT3aDWcdN6PaXPoekQR08jOeu5j0hcc3Xmdnjf1BpfL4K5SU9tSmWwO0eFiEDGCq66IS/zn0Oo5VtI3SKCldR4G6H0yMmFHNpn/n6c87NEBCTcWDImRpvHmpugkCaX0FTTWUeJ7TkiC6xxkIQBB35ZHvbm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk4TqHirJ82BYmIrxnO6gw93IA4OvP7bF5MzRDYQfwo=;
 b=1TlFlB78G2cMBwVKGNedqZg7CIAGLDg0/YczPQtpxnOLO1mMWXuDKw0ycOo48DjIgQadZNA364KiUcDGMWmeV2CLwOnllk1we/NjVxBHCHx2XkR3Wvh+KGUt3Ggjszsxzg/RzyBv9Bm0VV/1ajydVWIpavwMtHRdm8aDT1Zse+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Thu, 7 Sep
 2023 21:28:15 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 21:28:14 +0000
Message-ID: <5d9af84b-59e8-385e-5dff-0f12651fab52@amd.com>
Date:   Thu, 7 Sep 2023 16:28:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5] Add new platform support for DBC
To:     Mario Limonciello <mario.limonciello@amd.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     john.allen@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rijo-john.Thomas@amd.com
References: <20230907184846.47598-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230907184846.47598-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:5:14c::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8d2628-90b8-45e3-a747-08dbafe9584d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChTNPMvG2svwrEb+CVecm3LNGZfW3Yx0bLVslQS2IwptORyI9vhYwV5nt0hW5aBonnl4jmH8dlyTnpBdLQ24NGiz1htlzvwiD7+rFevQuuJp6+F6wM5J+2DpMPPk05O1R2de3nmd9Woso6gusye/ivPrRdVFWtez+/0aY6aC4NOhimMoO5T+bHCzemI4qA/WQcRQE7Mz64baSpDlcSXuOt/thxkebzA9GOfhg/7gy3icv0EeQ6xWpdrhjUpvYZfNtcxy9fpPFktUyStVU2ik0Rx+/26v4DyzUXe2PFIo/PBKoq7rdp1SmzDRkSlpXvP9aiZ6q1naZwqmywokPa+75Y0JgTCTul9MD3O16xsLoED7+FsY6iaN7rrYEMqB1fnjiWHU0p+KuBv4TLsU7mTG/N+GbTzs+9a0A83fX/ehYTwvaCbx2nyYAla6xKGTkf7oCw3TP/yAPddyCsw8dxmarXB6EdC0RrcLaZvs55JG5c1LQjqv/cukrGWCgCEUNLIXDcJY7QY9nZK44AskXV9wqL0UhgV02J/wVBxk8l8zTiR7Dr6GrTeVwpzKz1XG95SYyMxNmlhbdJwTZciOrf9WHAWw9qtgxPajiMs0vjhuTo937Vs9HypJI98ojQiWvAbE0PoNvX1TchhzkO8kv0kQdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(186009)(451199024)(1800799009)(6486002)(478600001)(83380400001)(966005)(86362001)(31696002)(6506007)(53546011)(2616005)(6512007)(36756003)(26005)(8676002)(2906002)(41300700001)(8936002)(66946007)(31686004)(38100700002)(5660300002)(316002)(66476007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVEyTXcrcEE2Y05SaGFwNWZzZENSYVZJWjRkQnFpV2trUGFXZElsSmZDY29X?=
 =?utf-8?B?aS9ITWxQbitmMzhDU2F2NFlVcDJmM1V5cWtKakgxc3BCU0ZXMzFIVUNXMWV3?=
 =?utf-8?B?bXVGeTdOcVRFUFB2V0p4OG9OVWRINldwa0NvKzg5amEvQ3IvU2paMkJIakts?=
 =?utf-8?B?UTlwUE1BbEJtZ25WV3dGQWFFTFdkNXhLUWt4K1RzTzU3eGp4eTFwMGpVNHRT?=
 =?utf-8?B?cHl1UkVEWVYyVFZDQVZwbjdIVG1tMGFORlU4aTJXZVhQUkpEbEp5TnE5TWoz?=
 =?utf-8?B?eVdnMzZvb3l2cnpiUk5SU2pSdzI5QVpwSnI3S1ZWTGNXakI0TGNNVnhnMkpI?=
 =?utf-8?B?b2ljZ0NLdmZvRjJJNStUZFB2dGdTVHVaUTBrMG1LU3Ezbm9LSjh6RWRzNEdr?=
 =?utf-8?B?TWdHdjRIdk1IL1ZiMWEyQmllYm9ObE5vN1QrK0h2eUlYRlJKVm1sdVR5Q0VO?=
 =?utf-8?B?M3paTlZZMFhyNDl6QkV1c1J0cW9obVd3OE5DWGd5UzVnRXAwODZZNWRqL0F0?=
 =?utf-8?B?TFo3ZjI5SkJRWGhpQnJsMzFWM3FDemF0NGJybW5QNTBXbU5vckxqd2xTa0dp?=
 =?utf-8?B?RytkOFR4VVlKbHU5bFJtU3JmdDFiMHV3MlZwOEp2L214N20xNEJ3RVFjM3hn?=
 =?utf-8?B?aWo4ODUyQWkzOEx6Yzl6UjZBbU5ibXZoNW5pTFF5NUpqeWY0eGpDeXpjT3hL?=
 =?utf-8?B?ZXdWQmpBY3FiRlNWT1RRUW5HMDQvQ0dGcmJQc3NWU1NaMTBFYTN6SGVSdW1R?=
 =?utf-8?B?ZnR3Mm5OelQ2Vm9IN0wyVFVScWE4S0p3U1lTVFJnM2I1c05KSGEwaU1pUVQ0?=
 =?utf-8?B?Z0RFQXhLTFZiTHc1c1BjTWYxSlJVV1JkMDlkdFRVNVhpWmF3dTNhMEdHVlNN?=
 =?utf-8?B?U1l2eWdXaUtPVmlqWlZ4WFloYnlGVnJnL0QrSXQ4NGtNQk94SkhDbzFBZ2do?=
 =?utf-8?B?UithclN2YUxEUkNQb3p0WG5XcTlsMlhKTlRjVVFBL0dnZnA4T0VGbUV2bnJ4?=
 =?utf-8?B?MkJOZVcxRks0bGZkQTZiNUFocHBKcyt2VUV3U0ZyeVo5c2VYcHc1bzRvSUEy?=
 =?utf-8?B?U1JQb0lQWnJ4Wk9lWTVaUk1HY0dYUjBHbWRGcDgwNjZVS2VSN0VpWnVGTkFk?=
 =?utf-8?B?OWlSbWU2UWZXZ2VYOTVNaERpT3kxSEdFc21FMTdjUWVGWjRXRlFkVk9uU0hl?=
 =?utf-8?B?VGwvc3FlZWxQMmtvZUg5bkZHWXVadHRMSkVtZXFBWFF1NmVnQVZMdW14N0Ju?=
 =?utf-8?B?Y0ZJaEdsZGRWUzZKcTlBVjQ2R3ZPT3BOdWh0OXVEWjkyeS9FRUs2dmdhTjR6?=
 =?utf-8?B?RjV4QjNHSTdjQmpLRWZxeGQ5NDNic0RrWG5MY1JEd3NGU1ZWcGpjT2sxRDNN?=
 =?utf-8?B?YkFHY0NKb3h3MFBvSkc5YVIybEpKSXl5U0xTeE9sdzBobHRVWmFxVW9iUHND?=
 =?utf-8?B?N3B6UDNyVVBjc2sxc3NJZVdycS9qU1R3MkliUU9peU1XcUhZeUVyK0YwR1FC?=
 =?utf-8?B?VFVaV3kzMTZPck1MRVlUd2JNa2svWmxsUTFUSHZDUk94N3ZuSXVObDVpMnN3?=
 =?utf-8?B?dHhOTmFaRGVJVkVaa3k2TkxleWRZL3h6V3k5SXR3SStvRjB6Lys5d2w3aGN2?=
 =?utf-8?B?WW1uTVBBSDNDYkl4NUxzL1RaMGtnaWdweEtKbVFGZEM5ajhobDNTRlJKSjVX?=
 =?utf-8?B?ejNrMDdDTnEweS9MczF3TVhHeURZdWpYYWRLUHZ0RUZVMjBZZEFPUlZHcytG?=
 =?utf-8?B?NVNWK3RuRXVSSXJ2cXdoZlU4bGtaTTJiejl3STI1QVk4Yi84c3lTSjNSajc3?=
 =?utf-8?B?SVFtd3F3enN2T0lxT3pxRExJQUNSYXowcEY4MzBCN3dRVS8zQzBXTzBzRG4y?=
 =?utf-8?B?OFZyU3RtM2ZRaG51MmJnSFIwM3dJbmpsTUdMMjdQTnhrRldBRWVrd0xWekVX?=
 =?utf-8?B?cklyMUxWQkNpem50STgvN2x5UHR4NVlrZUowSWhaMXVYTkZlZERnMHE2eXR3?=
 =?utf-8?B?YVBCTm0yUEh0K2N1OHdLcmV4UThySlU2S2x3eDJQMm10SjI4MGdHTHZpaVJk?=
 =?utf-8?B?MW9DVjVaQTdYOEpqaWdpNkV6dnViRHJadXJpREpkWjNiejNVanNYV1pCaE5s?=
 =?utf-8?Q?RYbX/yY1csTNNt45vpjo2Fuaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8d2628-90b8-45e3-a747-08dbafe9584d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 21:28:14.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSmFMz5WWxLi3wztKSwcxpF4FC/wE1/UZRmrPTeBBr5PTq8PBwE3f0Y5SHWpRyYmn9kj5od7oq/Uhvli9lzvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 13:48, Mario Limonciello wrote:
> Some platforms that support dynamic boost control (DBC) support it via
> a different mailbox than the platform access mailbox.
> 
> This series adds support for those platforms.
> 
> It is tested on top of the fixes series. The prerequisite patches refer
> to that series.
> Link: https://lore.kernel.org/linux-crypto/20230829150759.156126-1-mario.limonciello@amd.com/T/#m47782729377f6fe5d62130cc701dae7f15306726
> 
> Mario Limonciello (4):
>    crypto: ccp: Add support for extended PSP mailbox commands
>    crypto: ccp: Add a communication path abstraction for DBC
>    crypto: ccp: Add a macro to check capabilities register
>    crypto: ccp: Add support for DBC over PSP mailbox
> 
> Tom Lendacky (1):
>    crypto: ccp: Move direct access to some PSP registers out of TEE
> 
>   drivers/crypto/ccp/dbc.c     |  72 ++++++++++++++-------
>   drivers/crypto/ccp/dbc.h     |  29 +++------
>   drivers/crypto/ccp/psp-dev.c | 122 ++++++++++++++++++++++++++++-------
>   drivers/crypto/ccp/psp-dev.h |  55 ++++++++++++++++
>   drivers/crypto/ccp/sp-dev.h  |   4 ++
>   drivers/crypto/ccp/sp-pci.c  |  22 ++++---
>   drivers/crypto/ccp/tee-dev.c |  48 +++-----------
>   drivers/crypto/ccp/tee-dev.h |  15 +----
>   8 files changed, 241 insertions(+), 126 deletions(-)
> 

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

But I would like to see a Reviewed-by: or Tested-by: from Rijo-john for 
the TEE changes.

Thanks,
Tom

> 
> base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
> prerequisite-patch-id: 4bcf7f3ea21472e4e28c2457cc9827f6023ec6ca
> prerequisite-patch-id: 903be53a20306f0188e52015dbfe5196738bb2eb
> prerequisite-patch-id: af396bafb6acaa9c203c1a2c5f4665171cb45e4f
> prerequisite-patch-id: abe450d4bf1de4a5664a41dbf84e72b1d4bfdae7
> prerequisite-patch-id: b0b9cf55fcb73a11de6f3da73412fb090562857a
