Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC78A7EA1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:18:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD3D7A;
        Mon, 13 Nov 2023 09:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5/jUPLVhgz4fqnDkRTMZBIICiLjWIjC0LKaurn62Akjvx4SgSGhZKhavyXoaPCLlTlXKm0dXivNeXzSKmnLnRW15doigvBQ5uY4nh0WTKuKlD955du21/T74nYNcFcosp7NuHgmTXRCLp2PRbi0LpeP8lpxCXTAZAzPbeWLiI3WWbCZIB+u9UxzrGDi7CDq7TF5AT4BTd9k0pm5HX2IRrgaKLqyvgIvRkluP5Gbwzw7BFGaQfjweCIzZUJr4SE2X/f8obrpq8Kb5wCz6IwySdJ3i0Wh//ACOwUmAALBYD69aF9jqFt5fTQqCvft4ro5lJrGP/JZp1QlLZwEQQdGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LrSpq1+//g3GIw5boPff5U1G+0iP+uQu9S19BqEWt0=;
 b=LbGg2oyorxaH1/qZuXD7NdCxhyjELDWXNSwIce2lpR2WhNasLojRhersqqzVQ3hGzHQFoYRcouyvJpqF/i3FHLfQSnpuf018IkDqUzytCha81jKM9WHWOGAUZjWGYari21gsQVCsGCewhDsN4jsKCOwBN8FwM82TFfgoHpQV2W0xqL23VXw03diJCiagUPcXY5EEpxdYucNydZg2N/UIK5SSo4otm4BVkVf74l2p0uvxXRKC8jfVOX5Smx4pYVh7w4lmeXQPXdI6pkUztQwHj59Xi+pNiIaND3NiBXcp3Ue64ke6oxM0FVhsRRSdIxqQBGyAr8TJPuirQ/aFRW2hYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LrSpq1+//g3GIw5boPff5U1G+0iP+uQu9S19BqEWt0=;
 b=I7sM4WD8xtc2PBuoHMEZzldp3cQoWaL1AYJ2DirtmrS5zYXdYo2YqutYQELwesXTGg9rWPw/WZvim81vFI6UvDrsPnOkuKVTXJoU9WeAJj3+1VnuYRYkeBYqL1Vqf+o7JEAu3ZgtVTyonT1QWzUvH14NanjX1zPkSkrt8u3fywU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 17:18:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:18:51 +0000
Message-ID: <9e587eec-6301-4e54-8a4a-333012ca9c94@amd.com>
Date:   Mon, 13 Nov 2023 11:18:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: Add support for improved performance
 mode
Content-Language: en-US
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
References: <mpearson-lenovo@squebb.ca>
 <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
 <c8a025e-2da2-693f-aa94-679aba79827b@linux.intel.com>
 <36bb8aaf-643c-4736-abe5-e5a911f24aa1@app.fastmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <36bb8aaf-643c-4736-abe5-e5a911f24aa1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3e3af1-e59b-4039-2aa5-08dbe46c9ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGAshDa8HxeNohg9pVItVQvOP/14yoKOOII9XqQ3aM0nPHHW3kgMs+aBzI/wZikiFOoakWzwIjiOfnPhst6abOpE7IA/t56U0KyfvV1+k9ndUnARQzyem0Y8DxNfffWGrSScFkuczVowNM/vTLP1Dg2fG0MABe+lR7Lg2PP2dSWOQbDGMnlmLycIHlCYvKTYWfoNS1chVd6at1Dv47WdmRCqL3s/vMg30oyZhRUGeRyR0HJ8bsE2ZXb2Alw9cyIrKFT1VhJtC33xL97Y1yTg/jQrEB0hc3oiqxVmyYfKCDrE/WMEveCK/DlLbO0ODaWyuIpartcHiErGO7aP3muGO9nlbhhdZYafGejZYPvRvr1eEILq/gPqGYrsAF0NXvZ6tU4tUIpteyxVvIrfCFG25SG5Zta6yQWRM9V4QrETWMEtk8YfYSmajiwO1AzNA8AYr41yq13pp5SfdlUyvjOwhHNEvkacTrnM8xCEjn7Zvec5nMuii6LJ1sAIohktDMW5RzS2AQ0wd5cKDnA/HkRt6eWuz59EOTGOTQ6E6w4p+NktPrn3j9nsID/tFnOpnmfd1jz9/s+o0zoS3XpBtTE0hlvH5lrsdcMczUVbT7mt4a49holjLyAOsz3eHzftoCCRp/ajUDLOnPAwd21Lkfm2/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(66574015)(26005)(110136005)(54906003)(6512007)(66946007)(66476007)(316002)(66556008)(83380400001)(38100700002)(31686004)(36756003)(478600001)(6486002)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRKSEhIQWljQnJvZ09TV1dwRDByd0pGakdCNzVMZUxoK2RtWno4bW9DWlFk?=
 =?utf-8?B?RHhUMTlabmtublJlOUFTaWx6aUZIdERXeXBDVEhnUjh6bElkRVkzT0lhd2Fy?=
 =?utf-8?B?RVNFcm9SWHpxTzhwczFwUFVrd0Z0cGUyU3BDT1dvYjg1QXNtSHNRS0VSUDcr?=
 =?utf-8?B?MEVGTVZPZ3I2WFk4QTVML2kvTkluNXdsdE0ySGZBYzFvRnZCQXBtSWp3anBz?=
 =?utf-8?B?dmJ3TkxHcjRPdGJtUWRTeGRUV2VubTFMN3IxbXBvU256alY5eE80Q244VXRF?=
 =?utf-8?B?OWwvWjZPUXZ0RzFCdmc5aFllU28yNlJuMjRmMmdBUFg3ZDFmRlRteWQwVEFO?=
 =?utf-8?B?SUYxeUlYci9rRE9ydFNIR0JhaG5ESVZNb0lka1hpRVJFZXJlSEw0RW5hSnNq?=
 =?utf-8?B?dmt3cjdIQkZHOTd1L3NncWo1N1lhcy9pN0ZIVDdJcFNBamhKMEpWWTUwaDlV?=
 =?utf-8?B?WDZ4MWpDanBoUkpuejJja2QvMW1LRzQ3SlBJbXRuVDdzNmVVMHZYY2FlMWhR?=
 =?utf-8?B?NTZRWUZsc2c3WUYrSW0zc1pwMGt5SDlUVmZLdkJGK3MvR3g1Tmxkek56TmRD?=
 =?utf-8?B?UWdLMHhtYkRNRWVEZHhyUjNXZ1dzekFkUkVXZ3BVUUhvQmFpbTI5dTdNbGhn?=
 =?utf-8?B?Ny9pY3lwS2czaU1UY05BOWN5R051OStZd0FxU3I3K3VURXJnanRsRGtZVUJC?=
 =?utf-8?B?TTV3RDgyV0xZL2k2dlljS3JhSGR3WGhTODNMdFNNdVlFTDhoZ2ZndVlYcXRK?=
 =?utf-8?B?NGFBazVtNHhnWkFyTjh0Wk9OVzhNWTZXU1hNZzlwaGdyTGJobnM4NU1PUlVp?=
 =?utf-8?B?NTYyS3k1TnIzL1FXZlhaR1dVYTJraFNSWnphd2EyT1BDcEFROG5OYks0Sklm?=
 =?utf-8?B?NTk0dlJ5cVBNNXNYbC9DcFhrRXMrb081c0pwWStuTkZYa2VnL3pGWG1mMGt2?=
 =?utf-8?B?c0oxK1EvVWdjNTJqQ1NNYkZyUCtzTWRFN2theEFmb0xKY0U3bVRoMHdVenN6?=
 =?utf-8?B?VGtPOTdINFlnT0JRWWFJMmRIczIra2NDOUhPQ00zTmpIeEZQa1dqdEpLMXc4?=
 =?utf-8?B?dXlpY1BEcmdNams3RXhZbWwrVUxQYUVmNFdwWDhXRlpUM1A5UmVveVBnUmpW?=
 =?utf-8?B?Wk9WOTJKTXd0SlhESnV1U3Q2djZ5SzdXNnloZ2V4L1pzRjVGMG13d0IyOWdy?=
 =?utf-8?B?SEZ6dnowcVdDWTMyNWJFcmgvZ2puNU8xQkdxRVVtMnZxbDhpR1pacEdyUjNB?=
 =?utf-8?B?V1lhL0Zzb3F4aFFyZmNmNnhCdmNOZGo1Qit5bkd3R0pFZktMNjJPaDNPdENH?=
 =?utf-8?B?c2JkdnB2R0gxdzFtZGhBMGMwK3VUdlNsZkJ5cXBMY0RmUENLcnhEbzBVVVN6?=
 =?utf-8?B?OE9pNFRJbDR0QU9WTFY5N256Y1NOak55bFlxZ0lWZE9kQjdUOUF1bTlwVity?=
 =?utf-8?B?NkJvS2swb0Z5T3ljYjRLa29WbnZhaFZJQk93amdDTllkK2NVK0syOGlwenRj?=
 =?utf-8?B?Q1FjdmtuT0ZVeVM5N0Y1T3BxMnlNZk5ORFB5eTNoclNwRkFoODIzd0lBRjhl?=
 =?utf-8?B?bEpLTitFMlhrSXFCdzBrWlVFUFloRDZxenZFUDRUSnNWYjJwWGlucFZNQjF0?=
 =?utf-8?B?S0RPTDF0azRLVHZvMEtiOTVGWit5cGMyak9GQVlSRlU0M0lwNnpubHpVNVQx?=
 =?utf-8?B?a0wzVnYwTmFkRG5RUUNUbTFUcjYwellodWFOSHozRG8velc4MmF3UkJ4Q1FR?=
 =?utf-8?B?ZkpGeVpRM1lkbngvUWJDZi9QUlo3RFZKc2I0YTVaZHZCRlVVMFI4Z1lORjlM?=
 =?utf-8?B?TnFaZEp6ek5pdWhRcTFYbGdTTEMxSE5MZXV0ZkdRU29iNnJWOE5HMlRjYk8x?=
 =?utf-8?B?RnhSM1FVVmN5Qks2YXhBcTRWaVc0RVNaWXRMTVBlYUNGTk11bnQwejRlbTNX?=
 =?utf-8?B?VUEzb0U4NUp1eUxYMnV5SGlPSGNXK1hBb3MvNGtKM2IrY2lvYWpmY0xUdGgz?=
 =?utf-8?B?OG5MNHlWQ25pa3hPTzhQaGFxeXJHN3NZRHJpdU15RHVzVW5vUURTeEl5Q3lq?=
 =?utf-8?B?UVVOQVhQR3dmZ2UvVnlFNEErVWEyOGVhNFhoWXQ4dHR6T0JvWkU4eCtmRkJz?=
 =?utf-8?Q?KE2n+JqY9dtFNkxU5T3ccoPkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3e3af1-e59b-4039-2aa5-08dbe46c9ae9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:18:51.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJeyXdGLlScESDokXr1lhwLj5j/23l857zh6OEMEF6XoA3zrlmjkK2t24DxQoT8uRfdg0D20cSwhBJgQqw8a0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2023 11:15, Mark Pearson wrote:
> Thanks Ilpo,
> 
> On Mon, Nov 13, 2023, at 11:59 AM, Ilpo Järvinen wrote:
>> On Mon, 13 Nov 2023, Mark Pearson wrote:
>>
>>> Some new Thinkpads have a new improved performance mode available.
>>> Add support to make this mode usable.
>>>
>>> To avoid having to create a new profile, just use the improved performance
>>> mode in place of the existing performance mode, when available.
>>>
>>> Tested on P14s AMD G4 AMD.
>>>
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> Changes in v2: updated implementation for DYTC_UP_SUPPORT define
>>> Changes in v3:
>>>   - Add in missing BIT for define, somehow lost in previous commit
>>>   - Cosmetic clean-ups
>>>
>>>   drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>> index ad460417f901..3a9d2cc71b6a 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -10136,6 +10136,7 @@ static struct ibm_struct proxsensor_driver_data = {
>>>   
>>>   #define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
>>>   #define DYTC_CMD_MMC_GET      8 /* To get current MMC function and mode */
>>> +#define DYTC_CMD_UP_CAP     0xA /* To get Ultra-performance capability */
>>>   #define DYTC_CMD_RESET    0x1ff /* To reset back to default */
>>>   
>>>   #define DYTC_CMD_FUNC_CAP     3 /* To get DYTC capabilities */
>>> @@ -10152,6 +10153,7 @@ static struct ibm_struct proxsensor_driver_data = {
>>>   
>>>   #define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
>>>   #define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
>>> +#define DYTC_FUNCTION_TMS     9  /* Function = 9, TMS mode */
>>>   #define DYTC_FUNCTION_MMC     11 /* Function = 11, MMC mode */
>>>   #define DYTC_FUNCTION_PSC     13 /* Function = 13, PSC mode */
>>>   #define DYTC_FUNCTION_AMT     15 /* Function = 15, AMT mode */
>>> @@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver_data = {
>>>   #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
>>>   #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
>>>   #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka balanced */
>>> +#define DYTC_NOMODE            0xF  /* When Function does not have a mode */
>>>   
>>>   #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
>>>   #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
>>>   #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
>>>   
>>> +#define DYTC_UP_SUPPORT    BIT(8)  /* Ultra-performance (TMS) mode support */
>>> +
>>>   #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
>>>   #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
>>>   
>>> @@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_current_profile;
>>>   static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
>>>   static DEFINE_MUTEX(dytc_mutex);
>>>   static int dytc_capabilities;
>>> +static bool dytc_ultraperf_cap;
>>>   static bool dytc_mmc_get_available;
>>>   static int profile_force;
>>>   
>>> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>>>   	if (err)
>>>   		goto unlock;
>>>   
>>> +	/* Set TMS mode appropriately (enable for performance), if available */
>>> +	if (dytc_ultraperf_cap) {
>>> +		int cmd;
>>> +
>>> +		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
>>> +				       profile == PLATFORM_PROFILE_PERFORMANCE);
>>> +		err = dytc_command(cmd, &output);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>>   	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
>>>   		if (profile == PLATFORM_PROFILE_BALANCED) {
>>>   			/*
>>> @@ -10429,6 +10446,7 @@ static struct platform_profile_handler dytc_profile = {
>>>   static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>>   {
>>>   	int err, output;
>>> +	int cmd;
>>>   
>>>   	/* Setup supported modes */
>>>   	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
>>> @@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>>   		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
>>>   		return -ENODEV;
>>>   	}
>>> +	err = dytc_command(DYTC_CMD_UP_CAP, &output);
>>
>> Hmm, are you missing error handling here?
>>
> Doh....yes, it should check that. My bad.
> 
> I'll hold off a day or two on the next patch so I'm not spamming the list in case there is other feedback, and do a fix for that.
> I don't want the driver to error out on this - but it shouldn't check (and potentially enable) the feature if that register read fails. I will go and double check on some older platforms too as a sanity check.
> 
> Thanks for the review.
> Mark

Probably best to "catch" the error and just spit it out to dynamic 
debugging then.  If problems come up on anything from calling this that 
could give people a nice path to turn up the debug logs and share them 
to you.


