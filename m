Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFD7FA4C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjK0Pco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjK0Pcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:32:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F09B;
        Mon, 27 Nov 2023 07:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsCsQwY4akAMg/AktgWExIrre1ysXKCKpZn6fhTWLWvDEG1FqFgBZKkslM1fnsCT2Vv8us3fEhSO7528S92fnGR+XYyf0vZl6wJvrPANqw3OO76Jh61BZvnPTnK5igSzqeYBsCtPo+LEraYtJ+0Vjl0It1ocsfs2zMtMD/QN4vp+gsysrUgvvFyiSkVzbB17qx3jFRnegw2XbHhqNmaiJJJjtL3iGHKNdRcZYZcBbYXMl5IkohyCvmlxuv/tIN9cRmfiTGnWc3mLgZgrVtqE9C3XWwbiznOpho0WMDAeca7Q7oj7Q3Rma5urrHFR2+ZEFHJF9/PttYvuzWu/BxktlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmtmsfpAu3Q19HT58qzh2GOSyoryLbFV6SBY5phTCaA=;
 b=Z2IT85lXq4iGJcYdiMAmrG6i0L68UqinZGHyhns4Hdc8EzORzaX6sNuq4kaMwz9XSmNHfduIrNirykl5xNVPEwg/eQpUjeCEghNkQA/mVTQ48WwdHmUX2ByRJ34uW0R3vSVJKiwQcVpHN8qvLXpW+EV688RJjeOueI+6omuac7Tdl4kWFYr7yM7Md4L1m3TywbRkqBcNpaAuO06gmzjyT5qvfuw70uhp8IOh7TpzmV4N+k6jw9ce4kGh2q5PA4oXq8kJ9aZAZpkpMB5NtQG5xEIDOpspN8Up3nOT4jLwiVBgE9FuQ0wpxsYCjsLTNrJvqV0cwpD4IaxP27iVY/mySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmtmsfpAu3Q19HT58qzh2GOSyoryLbFV6SBY5phTCaA=;
 b=pE5g1gaiYfGRHtRmkxSxDxIfnILw0u3b1bF3wVCX3HEeWCplaf7pxEyoqQzXrFta7XOgLE7ijFRkp2g5TkXr/83OmN78tHo+/r0zqbrDiT4DpSxnrMezlUu+MjHTXxd1SO4gWkTPoyzs7MWAagKv2GJCVX4wOUp0iEMVbroNsfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 15:32:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:32:45 +0000
Message-ID: <08590a87-e10c-4d05-9c4f-39d170a17832@amd.com>
Date:   Mon, 27 Nov 2023 09:32:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Content-Language: en-US
To:     Malcolm Hart <malcolm@5harts.com>, Mark Brown <broonie@kernel.org>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
 <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk> <87leajgqz1.fsf@5harts.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87leajgqz1.fsf@5harts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e141aaa-5ca8-4499-773e-08dbef5e1aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjPJkVofyZvsh33RExE/T9v16gBmUPxKwrtMg804IPOP1eDw0DnhUwRFmUxIoX1FSVV7brYIiaaSBM30LkjMulCMHgQEFCue9WWaQCnttnYfD2wQK9oEfTHkrdWRSBpBuXcLL/M+i51DX1UND57Rx1fHQEs5JwjLHgqHNX4P04g7gGcQ8Waxxni/C9FXTYjWCPL+gtaIl2MG4vX3fPaTAeiaOGu2nzNcTG4RYMMZIz30nOOPtWXxbeQLCQ8sv6X4q3az7mMBoxObfNVrG4pRSjn6+BZn4PoxFBKZ0z9kfpf4dRmCfIitIPYMtkvuAJ7nDIJn6W+xbOPkFuOWvwuCc5d+/pTFMpStQwhfmW8Vuz2zte6RjM2rgnX18/tirP8LCeKFyBNUFk7qJ/qNrP1eoZQQikDUudoWObl2aBSXSZx+XWve3BTHySGmltPFGVy81kR48r8Z27n/96SnbU5QjpOLMTEB+0cItFuAezPovylcHW7OP7LKNXIeR3SBoPO7+1VlyGhqUPoXnLBanC7csnySofXrrAupmgwFkAmsN9+ZobgLFtEP/MNhpKLrFUbkWsiv+JUiq3PNTnDURnhgJug6zAyxMGRmCSvhp+mM9NMARCK+grUyc8J9YKeSIy9Zh+OGYVLB/e2Rq3nFpw7U3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(2616005)(26005)(478600001)(6506007)(6512007)(83380400001)(2906002)(4326008)(5660300002)(41300700001)(66476007)(66556008)(66946007)(966005)(6486002)(8676002)(8936002)(44832011)(316002)(110136005)(38100700002)(86362001)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxTcm9PN2l3SnhEaGx4M2hjVGdVd1BITmV5NTR5N1Byb1lKaGQ3L0J3SThW?=
 =?utf-8?B?NUhWOUg2V1VVMXY3NnBVWVdpNkp0ajd4dDBPZmtrcVhuM2lkUXhXYmw1N3Mz?=
 =?utf-8?B?VjF2WlVocW5LWE9NWW0xb1FZNWJlaGtKcHBiKysyaVhXVUgwaDQyN3VrNWtK?=
 =?utf-8?B?TUxqT1NKajlNeTJ2ZW5XUHF5b0Rjd20wYTlqVnpBVnU1NVZ2ZTlIMlhlN29j?=
 =?utf-8?B?TXgxS3lPcG1ZRTBXdzFMbFovNW4xdjlhTFNXelMvekp3cmpVNXcrWWhpQjVC?=
 =?utf-8?B?WGZWS2hzcGZIUHFnd0xRcUVxZ0Rtd1BpbSt3d0k0emFIb3BaQ2diZkRSOThr?=
 =?utf-8?B?U0d2Tk1haTh4SGZZcU1WU2ZiSlRqaEtCRmY2NnVzeWg1TXhxNitLZlVvcWhm?=
 =?utf-8?B?VVZRamdJK1Q3TG4vQkZjcDc0TVJtVmwydEtIck1yM1pVWkl0SWdrTFhmVXY4?=
 =?utf-8?B?MUJHM2lYdG0vREgzamZ1TFEybUtZTDlrVkFJQzJNa2ROb2ZyNTluZnU1ZGJB?=
 =?utf-8?B?dUNmYTluRENEZVZUSFp5b01NRmgzT1pBVUZKRW5qQWdlc05rdVR3dWNqemVr?=
 =?utf-8?B?NVZjbE55WjJLWVh4c3N5Rzd3ZW9VTlpYeHdadGdCaG1TVHpxQStmbi9HdnhJ?=
 =?utf-8?B?bU1zTGl0czlUVjJ1MjJMOWc3bm1QTVIyQnU2b2ZYOXBqV3VkYkZiYk1rZ2tN?=
 =?utf-8?B?YnBFV25VVHB0WDZTVnJiVjJ4YmtNcVpqK05mNlIzNU45K0pHUlFaRm1IWEV2?=
 =?utf-8?B?cklybVpFNkJsbGV0dC94eHk4OU1kcnQzWVg2TkVXVzk3WHRjb1FEM3pELzEx?=
 =?utf-8?B?a2l0Q3hDY3RsQk9zR05GZ2pzbkhHdlFoeFE5RjltaENxellwUUYrYWx6RWNv?=
 =?utf-8?B?V3E3WW5uSUk4bldvRyt4K0ZGWnFETW9Db3BVMjdCZlRaM0RSZDZnZFpoVVll?=
 =?utf-8?B?QmwraHV6ZlQvRE5KUndJRlllL2o5cThRVWY5Rk95Q0NtQUZmakd4bWxmNEh5?=
 =?utf-8?B?Njl4OE9qSWd4aUFsZWk4U004Skp6OG41TDhwQ1k3UU5FcFEySEhNQmtlOXBl?=
 =?utf-8?B?OXhKR1dwZjRSYk9Ed2tLUno1MjF5dTdYYkN0L1U3SlpVVm5STVI2aDNhS21L?=
 =?utf-8?B?TmtYbGgvQmlOWEhzWlo2SFF1SGtqWmhVOWcyemdMLzhEVUFtcVRHUHJHdklj?=
 =?utf-8?B?SkxUVHpkakp1c0FNT3lYak1pdnA2NDZwN1gzUUd5NEpzUWxkUmk0TXhMcm5I?=
 =?utf-8?B?RWVtWVVuVXpxUHVPQWgxd2l2b0drcVBxUW1ZWE1KMlBXeDBwdFNObHdMTSti?=
 =?utf-8?B?Y3ZtckdLb0JXVEQ4WGU0WUlCZFFVTm9UYzBYcVZhcHJrWTExVHc4KzZudSth?=
 =?utf-8?B?aGtZVCtiNTFzL1FWUDd0U1pYYUNGY0RQWGhLRkl6RlorKys3bWdObWRLemJu?=
 =?utf-8?B?UDNwMmU0TDRWOWtuZjF3Y0o2bCtTQ24xRTRWRE1CQjBQWUpoUE9ibEFiMnBO?=
 =?utf-8?B?N0RGUk9kUjY0UzJDM05aODdlWUhmSncvQjVXNy8vVWtNbXcyWmRvc2tEUnUy?=
 =?utf-8?B?TGl6enRRamZaSkxFZERoK1NQU1h0UkxNY0xlRWF5R3BvcHF4cTZjV09qeHJZ?=
 =?utf-8?B?dkNvTldKWWxGVWtSNG9TM0tUVlFTUjMyZzdUVERQZG1kUjQ1TEdJRm5qTW1l?=
 =?utf-8?B?ak1yUnN0dk5jTnovMFJHbUwvcEhmTmhYZ1FPOFYvb1lra1NQaDY2S3QrYkIw?=
 =?utf-8?B?NW5PYnhWOVRXV29KRnZKaXV6T1ZEVHJRRThGWk53RXNkVEV2SnBVakN4UXhn?=
 =?utf-8?B?c2l4dng3RVJINjZPdng1alVvcUcxSFFPb3ZzN0RmWVdJTWkvNi93K2p4YXZs?=
 =?utf-8?B?SFJJalNqMk1oRGM0SUFRa0VkbVp4eE9aNVluYVdLcGZGRG9QajlmUGpTTlNy?=
 =?utf-8?B?akpETnVJWUhqOU45QXFzdEpSNGRpcWk2dnM3OEcvVy9SOVpPMy9SSGR6dnpt?=
 =?utf-8?B?ZWhIUkJMbnVoMi9FUXorNXlBcGNFNzhwZXhmc3BlM05pRkNlMWREbnNHdUhN?=
 =?utf-8?B?VGNaTmtnODY2eC8vSUNQUWxwWkY4MitQaUY5RjJiektEMWl3SXV3bU1QZTN3?=
 =?utf-8?Q?+MkJ1NcjCwM3tzdKsJNjOlGJq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e141aaa-5ca8-4499-773e-08dbef5e1aa7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:32:45.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRJhmxz4fiyLN1rg5syIt8uOhIbH2fFcAt0DjTCrdvFF3v1nmu1d6/lmWuCk//ftZQeX6gGddGDTF9lglgVpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 09:23, Malcolm Hart wrote:
> 
>  From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00 2001
> From: foolishhart <62256078+foolishhart@users.noreply.github.com>
> Date: Mon, 27 Nov 2023 11:51:04 +0000
> Subject: [PATCH] Update acp6x-mach.c
> 
> Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to enable microphone array on ASUS Vivobook GO 15.

You're missing a Signed-off-by: tag.
Also as this should be going to stable you should have a tag for:

Cc: stable@vger.kernel.org

> ---
>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 15a864dcd7bd3a..3babb17a56bb55 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
>   		}
>   	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
> +		}
> +	},
>   	{
>   		.driver_data = &acp6x_card,
>   		.matches = {
> 
> 
> 
> 
> 
> Mark Brown <broonie@kernel.org> writes:
> 
>> [[PGP Signed Part:Undecided]]
>> On Mon, Nov 27, 2023 at 12:24:59PM +0000, Malcolm Hart wrote:
>>> Like other ASUS models the Asus Vivobook E1504FA requires an entry in
>>> the quirk list to enable the internal microphone.
>>>
>>> Showing
>>> with 7 additions and 0 deletions.
>>> 7 changes: 7 additions & 0 deletions 7
>>> sound/soc/amd/yc/acp6x-mach.c
>>> @@ -283,6 +283,13 @@ static const struct dmi_system_id
>>> yc_acp_quirk_table[] = {
>>
>> The patch appears to have been unusably corrupted by your e-mail
>> software and is also missing a Signed-off-by.  See email-cleints.rst for
>> some suggestions on configuring things, or it might be worth looking
>> into b4 and it's web submission endpoint:
>>
>>     https://b4.docs.kernel.org/en/latest/
>>
>> [[End of PGP Signed Part]]
> 

