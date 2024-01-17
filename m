Return-Path: <linux-kernel+bounces-28479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F482FF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A451C24317
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07807522D;
	Wed, 17 Jan 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzEfkFHX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0A1C05;
	Wed, 17 Jan 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460412; cv=fail; b=Bwk5PGjZb30aG2UtxGBoA2DnS2IyAoG4IsgcbdU4sl2xXnXvaBF0fEKMgJWcMHI9TENmLkkAJIWluhdMaVll+ZiEYEtUHlJ3rXnSufhMqCIhTFjCBHvTdHVp42oN3CvDCQqcs0Zt7UVHSivYluOOph+l8FEbFAibW+9nAITjH8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460412; c=relaxed/simple;
	bh=0CNzVPz01PhhBSei8Da/4bv5mPqNdRbF1+6nO3He5Dw=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ChuwjZlKuoJSNx1qCoZYHEiMTSmJvoCKB1XMBtT4UwgEXFXPGkApyAo9Sr39iwTZwWI9VE6qi20Ko2E3To8p1u+DALnUdnRF2HNVKco0pzgcHX0pc7T0qE7pEP1Y0b3zZAVysQ4mPpLcWJOm8jJoGVZ1zi+GYM0vhlrh3MVwm8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzEfkFHX; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKHAzU6wTbY/JLxXBpNXmDwMvh4qextH/0XpH/EqRHn05OlVCuK8Gsh2Jhwm1c5+K3Ajciomq2EdoXXUj72ipKe94JEhmkzDbNCTG3DrKa644z9AcEhpoJqdbyMmqmL4vfeWK0sWg/euVDewRbQWVoxhhS9MUnUHe1UuQ55N4rlafp/QWD4YYkGF+WDxnOgpeEfWF88mKJjqlClvDDOnuSYjJ8BEFKPH1er6SEGAA71GaVWvhYm7+bg6dDRXDpcb47sStl86Llvd7nhb+a71qzC9tSDCr5nmcQwIC3Unhr4MWL602xhs5sQduYXeNbgBaaGQUHK1/Jr6iIQujd9fbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3y3qXWgPYnqz/zscAt1fh6UpfP0+u4lf1spBRXQGog=;
 b=OD4PEc+gKeHmLLbTNsvnAfiH073SKd+JQaiUYb7nBqq7bZIp1Go3vrQrWP++UhciC1u+8XgUdbTLQMI6YzJb+e+1tyJvDLPSitKLM70yCj2vIwb9GHUhn+HWde/TigehCRjqyOTkLKsYU2XrBisNtsTR21Ckf6Pf02opkduIwAuj7HZ6XZ1XAZB/8VgjUVgYBHR/D/rcUbA8O1aCNtdebSJsDvma5tsE5pxSB3Fh4HKhGGTJTo1Ju8Iew2glx4enAdRt7RxwFIPs3nx2aoJEtIoEFj14OazDi69nYpQPfetfasWrmMhpXhzv3k55S98A8Mj/g4ahSqbg/E/F5nN6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3y3qXWgPYnqz/zscAt1fh6UpfP0+u4lf1spBRXQGog=;
 b=zzEfkFHX8qGsvXhjoLJ/BuBeO/Ibj3ynioC0b9ujTnTtrOkSNgeFKq9yzrLlvx1dkbz84qgNdTSwAfEjp55Goe3BOGFtvA7KXCXXhEi4M7WmmFamlTr3iT9k0Vfvlc5Faop95OcL3pYZO6GStW4AHQyFXVnROTt5Eaj/LAtK1wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 17 Jan
 2024 03:00:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 03:00:06 +0000
Message-ID: <34101c32-65cd-4433-974f-23a16f9981fa@amd.com>
Date: Tue, 16 Jan 2024 21:00:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Fix stuck UCSI controller on DELL
To: "Christian A. Ehrhardt" <lk@c--e.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Saranya Gopal
 <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
References: <20240103100635.57099-1-lk@c--e.de>
 <ZZadhlh3q9ZInxvU@kuha.fi.intel.com> <ZaV/kwuh2MBNY5d2@cae.in-ulm.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZaV/kwuh2MBNY5d2@cae.in-ulm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: a319a779-0ab5-4950-870d-08dc1708685a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pkIj5Yxy+MSPSHzd1xI5iNxjW8QUFiHeb+q4zJOaaYpnQO9urB5VeiOEupeZkNHIWuLAzAAeADv65lx2UMyPQoP3yqQlQgW9XPfJdtMztW2xzxkA7ZgepeWZPVae3qikwQYOZdr52VmKz5bxQj35AlOTB1U47S9Xf2ZqVI7jy/Aoy0Dmk1FksInKlHUEb66gGtwWmdA+H+azEfeyBzNoWJfXZN4UJreggM5lgstBjMtYiXBmfnbbgxfSxqB74kjmo3GAiizzZjGi2XwTc4GRZ+LPhiymW5d2dHfFwyyBmuWaUpeyU6WJFwz0SjY1B9NzFehvOMKE48fVE/5b2ZGccKptLQ6ILhIZlfOYdtndOeI8ZPeF9BxRgdrwyTrZNNePNqglqYG0wtNJnWYAe5vIUB3t0TSQ3LxppB9f0P3v+btWS3FAJU37bQ9CJgrIxAJkhWBdrqWBNd9m+tcljPkeMW0VshMEmK3RVc1S7bpov6M2biHRNuzp6U95jM52hWp3N3m5IGYoLZy/vW8rvSYw3fIPRNA8EqzjNpldVaaadDeq+ZdKEf7Kc62SHSLt+2iyFR1LnzeaEKlyP1GeHvH7HZ4eVCkor5x29/V4WO8htnCbuZ6aJ+gkT3MyMeJCARhqTLBBOnrE7UkI6tDzsx5cdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(478600001)(6512007)(5660300002)(6506007)(8676002)(41300700001)(86362001)(26005)(2616005)(8936002)(66476007)(110136005)(6486002)(66556008)(316002)(54906003)(38100700002)(36756003)(83380400001)(66946007)(31696002)(4326008)(44832011)(53546011)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFEU0FNZXdtR2pPSmhaUWI1dldBMzZudnd2YnZpdGp4eEdNMVp4amFLMVNz?=
 =?utf-8?B?NFVhYnJnRGhkaFBXMURiYVY2YjFncEE4MkdnSUxJK0pld3BWWS9nWUFrdHU0?=
 =?utf-8?B?U25NWmI1U1F2NXQrRDRRNHA1YVdRSnBMKzFybzg5V0h4dHRWWlpHTEdIZ2JV?=
 =?utf-8?B?eUxnV2luVjl0ZmNsMlpMTWRZOGF1UWdCYjRoQXZTMVdQUnhlY0NlMGtvcTNi?=
 =?utf-8?B?NW0vWkhocjBTVGpUUE9IczYrcng2WUdKbnRXcU92eTkwanRKanl0NmxRWUZh?=
 =?utf-8?B?OHZCNDMyZzB1cTRNWEFrNVJTVXVIaVNEcUZFS3JnOXhJWllubmhodlI2dTlX?=
 =?utf-8?B?ZmhNb0xJaVFvblJaemFtOG5CRVV6ZG4xZTlYRFZvUWdMbjVjZ05NTGpXSEEv?=
 =?utf-8?B?UkRiNkxXVlM1Vk84SStCcEV3Q2llWkFXU0I2S0ZhZVAyYlJtQ0tlMVNCamZN?=
 =?utf-8?B?NDhlUmU4a3RZRVVoaDNjaSt5bVlGTlFPbUY4VlNVR0c3a05Dbm5Mby9DRncx?=
 =?utf-8?B?bGoyWjhYZ0cwdlZsaDNIeHdJSTZFYWRZMFJqd0VkR0l0L2tma1ZtVW1IenZQ?=
 =?utf-8?B?ZnpWbXIxTDAxZHlGbnY3aW9kcEFiT21VLzAvazNPcUY0emI2bWk3SHJva2J4?=
 =?utf-8?B?QzRxVTJaOEpxY3NadmJLWWdabkhhcTRyUkRDYzFNYlVMUlpDYlBEN0czN3pN?=
 =?utf-8?B?TmM0L0pHYXp5a1UwZWR1V0JHU2RZcTBvaDMxdTBPZVN3M0ZpNmZQYUtaRk1T?=
 =?utf-8?B?SzNzV1BQRzQwK0VTMUJBN1hIdjlwS1JQMkt5R2ZnL2tTdmZzaThPZ01IZW1m?=
 =?utf-8?B?UlZWTUQrMHdVcDZyUUgwQ2VrYWo0MTNpd1pxR2Q4UXNmZmc3Z3BoK21vUlYv?=
 =?utf-8?B?R25tSHdpN3UxYklpNlR3dE1yYkJiR3ZrUm5QdnNMU0dNSEt2MjFBMlBoaFV4?=
 =?utf-8?B?MVdQTm1rM05taG9zUnJLODI3MUduMUcrbEZlRVFqdmIyd0FrNFdiMExOdVRq?=
 =?utf-8?B?UkVTdGlIQTZqZ2dLajFadDNBOG5kYjRIdU82NGNpbHB3OS9HRVZEWS9aMG1w?=
 =?utf-8?B?NGFGOXRuN1c3MG9XZ3g5cEFIVm9GZkQyTzQycWNkbGFSc1FFVWpKeEhHeHQw?=
 =?utf-8?B?bjBRNXZuQXZqSzlHOHV4Q3FFN2E3WXZTMVljZmcyNldQc0xVUy80aCtVSmVi?=
 =?utf-8?B?MXUzQVFZRHEwVC93UEJaY2VtbmlYR01XUnZPQ2ovUXRnOERVRTRtWHovamhs?=
 =?utf-8?B?ZGJORFlmZ3krOHI0di9iMG81Q09mLzVreHNuaTIzdC9kRW1XbmQ3Nk1URTRl?=
 =?utf-8?B?RWdPei9BL0E3Yis5aWtRMFlzaUUxdDBuSUNSZjNTd0szeUJ1NytNcW9DZDlj?=
 =?utf-8?B?UmRnUWNGd2NzdVRPUTExTXFTMXdOL2tudk80ZjZYU1QyRTR3Z3NjcndsUDlH?=
 =?utf-8?B?TUNTa0FLcVNxS1ZOR2pzUytxMmFZRTVJNG5Zb3E0TnBIa0xhck9jR00vbXZt?=
 =?utf-8?B?dDdlZmpxREhKMWJ5Tjd3SVNqdnE3c2s2c09ic0YxcnVHcXNxR3J3THZyeEJM?=
 =?utf-8?B?cWpQbzVTRThjYnN5a2I4cmRpUnZtUmkydjdZeUg2eEI3UnJPY2FuWmZ5TzBR?=
 =?utf-8?B?MHpGdENrRUZUMXRLVFFrYTNWNkhzZ0FTcVkydVpCSitrNHJ3RVIxYVZiQkhH?=
 =?utf-8?B?TGs0WHhoODhLVHRndFRJOFdFSmhlejJGRnM0WnZTbk9lYm1UVW5RWEliQ3Vv?=
 =?utf-8?B?UXViakttUmMycWpWSlJHR2orQ3NhMGxGa1Vzamx6WmhrNFVnaFFzKzRyYWVK?=
 =?utf-8?B?cGdyVjgxVlE4K0Z5UllML05aMGlQalRZbGhkOHpjM0xTQ3pWL1J6UGZlQ0k3?=
 =?utf-8?B?djN3UG9tYW9Ea0hTcGhkZVhrMC9TcFgraW83a2xtSEY5Mlg0c3RpRTI0VkxY?=
 =?utf-8?B?dEJYVXdFcWtpOGowTWpVRFBjYXRBMGRKK3pueVcxdnBiQTR4ZVNuT0pxaU5v?=
 =?utf-8?B?UTFQYXcrY3BUUUFxd0daUjVBVkdkK3A5U2NWbi9oOXpQRnJ6NGJucERaTmkw?=
 =?utf-8?B?cHZ6ZU9ST2FTYzhlZ1pWUG9OYnNnV25xWkJxeHNRZXBsUkszWmFxREFnbnE2?=
 =?utf-8?Q?4maTcSfliBOBilgDf59oz4wju?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a319a779-0ab5-4950-870d-08dc1708685a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:00:05.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhA96jgl73kS1BD1m/NEsRGoxAmT14KnF1BpKYziPOPZJU7V8V6Vk4x1OQHIHwlFX1niVH8/edy77tjLaJYDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

On 1/15/2024 12:55, Christian A. Ehrhardt wrote:
> 
> Hi Heikki,
> 
> sorry to bother you again with this but I'm afraid there's
> a misunderstanding wrt. the nature of the quirk. See below:
> 
> On Thu, Jan 04, 2024 at 01:59:02PM +0200, Heikki Krogerus wrote:
>> Hi Christian,
>>
>> On Wed, Jan 03, 2024 at 11:06:35AM +0100, Christian A. Ehrhardt wrote:
>>> I have a DELL Latitude 5431 where typec only works somewhat.
>>> After the first plug/unplug event the PPM seems to be stuck and
>>> commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).
>>>
>>> This patch fixes it for me but according to my reading it is in
>>> violation of the UCSI spec. On the other hand searching through
>>> the net it appears that many DELL models seem to have timeout problems
>>> with UCSI.
>>>
>>> Do we want some kind of quirk here? There does not seem to be a quirk
>>> framework for this part of the code, yet. Or is it ok to just send the
>>> additional ACK in all cases and hope that the PPM will do the right
>>> thing?
>>
>> We can use DMI quirks. Something like the attached diff (not tested).
>>
>> thanks,
>>
>> -- 
>> heikki
> 
>> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> index 6bbf490ac401..7e8b1fcfa024 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> @@ -113,18 +113,44 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
>>   	return 0;
>>   }
>>   
>> -static const struct ucsi_operations ucsi_zenbook_ops = {
>> -	.read = ucsi_zenbook_read,
>> -	.sync_write = ucsi_acpi_sync_write,
>> -	.async_write = ucsi_acpi_async_write
>> -};
>> +static int ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
>> +				const void *val, size_t val_len)
>> +{
>> +	u64 ctrl = *(u64 *)val;
>> +	int ret;
>> +
>> +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
>> +	if (ret && (ctrl & (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE))) {
>> +		ctrl= UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
>> +
>> +		dev_dbg(ucsi->dev->parent, "%s: ACK failed\n", __func__);
>> +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
>> +	}
> 
> Unfortunately, this has the logic reversed. The quirk (i.e. the
> additional UCSI_ACK_COMMAND_COMPLETE) is required after a _successful_
> UCSI_ACK_CONNECTOR_CHANGE. Otherwise, _subsequent_ commands will timeout
> (usually the next GET_CONNECTOR_CHANGE).
> 
> This means the quirk must be applied _before_ we detect any failure.
> Consequently, the quirk has the potential to break working systems.
> 
> Sorry, if that wasn't clear from my original mail. Please let me know
> if this changes how you want the quirks handled.
> 
>       Thanks    Christian
> 

For the problematic scenario have you tried to play with it a bit to see 
if it's too short of a timeout (raise timeout) or to output the response 
bits to see if anything else surprising is sent?

Does it always fail on the same command, or does it happen to a bunch of 
them?

