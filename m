Return-Path: <linux-kernel+bounces-50261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F3847684
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A9C1F2A5F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B2A150989;
	Fri,  2 Feb 2024 17:44:39 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2077.outbound.protection.outlook.com [40.92.59.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6114C597;
	Fri,  2 Feb 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895878; cv=fail; b=L4Q1yK8xDfuZ6f1MwKqagjnhjgedlhRPpbldrLyavSTV64fCjxOqFO8aL82BVIoQPABuCXl9kxUjJwx9IsANTfc9kBUfeT5FSNeF/sVqyZTF0J7dCr3thp+9HDlowcUF0rTliAntn4zjPszNCyRemr5En616V8GNix/LpUBC/Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895878; c=relaxed/simple;
	bh=ixO0lXTMeNq9WTz5v3bNcLRDvxoeRpA6R1rrYbeed0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2yqRNEFRsAL7JO0R3lZE1YQQSUacYEch03PQc9yZM7FITr5LxIUIhBtdLjr51a0APfNW5MDmIzYXr/HZbhXImIYmXnFBSM5H/AJAIqGVNXlndDxqTBxgAeBUkeRtqYaQkgPqvyxLBajjnRy6Z1Nxf6Y74R4qRPk/SB8XyWchl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.59.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIhpEyES0vDLKJ8Dc0vdC/4lyOMv1u5NFTLikjewOa6PBK/21mNTk30v8h47FHnGku8Sm5eeEy34hbSJt9556V1/+m61mj+lhB3gvmygAHt3EMj1n/bPWgl+lbXyD3siB/FHNZkP/PJvGzy5AROz+rfr25UaGEZpqTZCnr7zMstWKtahmKwBtAi5H2PFhS57joNff3zC1sMxi57AzqHaWrC4ssM/vPzqolNsxffFT1MQBPQTGg4Rs7hqrNiSgsbnvqqSh2ewAturk6cPwZiHVZI7kR8cUSb0EQ6MzdMVGITOhCfV1YJa2HkQ/bauJzleARa7B/InO9Ke1mokRCCVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNSFEQa1H+YfdQEuqBo95HXizm3wV1tG069CdPsQkdQ=;
 b=KIzxfg4CjKfa6uGwKwY3n8w0J92nWjX4gWhrEgZo3z018F6iRkVKmEuwvb+USpWPHxq/OzTMs6HC1fLB4mW4Sue6113dU7fow4FBeSryQ6/kJA8NCM17a8ctCizuIoV+o0fj+06cXoPM8jttGVmpA29/VXIzFCmaeSexZC5iqCsOW0gCH61LTaIGCdi1JkKmzCy3Hov/G+EihQaNNM3RHiX7O2EYux069touhlwFLSFvO0fW2ea30FHIrixLcsKu8Ek79zWwFaNRdszJF8/ajpv9MkxPqEocXNO0GPHflYUMFLPUnUQN0s0XAlIJlB/PCbvwxHAF8bujzRdAO/RXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AM9PR03MB7979.eurprd03.prod.outlook.com (2603:10a6:20b:43c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 17:44:34 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Fri, 2 Feb 2024
 17:44:34 +0000
Message-ID:
 <AS1PR03MB818918BC313CC8A59E288FF082422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Fri, 2 Feb 2024 18:44:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for ODI DFP-34X-2C2 GPON ONU
 SFP
Content-Language: it
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB81893D69344708C98EE2B470827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZoDIPR3O/iei5z@shell.armlinux.org.uk>
From: Sergio Palumbo <palumbo.ser@outlook.it>
In-Reply-To: <ZbZoDIPR3O/iei5z@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [z+bFD4lJNIJux6EJR3FM1WLx2UQwwZ7aP+WFBD4AlBbUAPwEXVU4FMe5NIlOF/WT]
X-ClientProxiedBy: MR1P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::9) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <7ce1a7df-9685-4f89-b439-3399d8068788@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AM9PR03MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 564eb9d8-4984-4eb7-1427-08dc24169e26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmfYJLqkCXG8F00uOmPfdi8DlUVLW0MVQ2k8wZ0W+VBEbtiGqHWTdXxPKELtcUUxn8RG17vz3LIvQjOk2cIwlAi0V5FsM+rFCuMYLLBdZrb1UyBOptRrY/0ZFTo9AOXmc0IbYtjN0dnNVZjLRzH/NflXnBS89GXDtaGoHRNarLRdtDt+Ev8cKSjxfF+KPvQ2IVys42q4U/NqYG+uKvxZBFVp0xTBa/96fHgytjAVXJRpS1B+1eAivwpRC4bi12gLDUs9W1aQ9X2AYu7zL4DN6Cyg5yaKfrZctdoi8V9Iy5qrhUmOIU1MZT8+m9IYFwSEA7j4VjM4Lm/Eee/ISegqZEKR50j/RGfhYz3oDQOGOZVcuh2SuWsO6z+1f42ZMkvG59EmCbIxB7vCrCod42PB0EeJcxyVBieT4PqUedrQaJogaP1CUVolomwOxIatncCleD3ZHtQpnoL3YJo0oks9y7Bvpo/TZXErRsoChvSanijtLQ/0n0h15hUbKIAVcJLCiJeXDOj3+C/HCHXFL/pavtYS/p1HeOu/G3dE3gLO14wci3CXJcq4Ek68gZOAv8yUEZHNrnZVVNLznRba23iLjjXX5FaWBosgsnd4SGS27Ko=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkNtZ1M3d1FudFpZYnBqL290UTdDR3ZCYUFHbnlvNk5nSDFSSEpTaWdUT2sw?=
 =?utf-8?B?bmdRZDFBWmcxMlV6ekFuOEo5MElPR0xlOVdmRURzUE9OdDQwbDZ0eVRyODhL?=
 =?utf-8?B?aHBFU09CekZHZUMyQ3ZKVndMTW1QeGdLeDlCQVBuUW9qbXZJVDdKcnJsSDV6?=
 =?utf-8?B?RmF4R052a2ZVODFHUS9MUWNnN2xHVm9TNDZPM1A1Uk1MQVBBcUg0U3dPUUhI?=
 =?utf-8?B?S29EajJSOFgycmd4MnBXc2RDMVNTOUNDRHZVcVE4ZjQ4QkI3ekNwS3RPb1gx?=
 =?utf-8?B?amJXRlVsTlhYSXdRTUovMnFyQVc1Umg4RFFMVkVqSldVNGJxMFRoNGtTR1RE?=
 =?utf-8?B?VkVUSmZpaFphRWhkSVdieHRGUjlnTDRqcytMWmpxRzIzbEw4dTlOQTRYb0xu?=
 =?utf-8?B?dTVvNWJubVp4Nk9JU2Y0bHhmVlNGTEQ5NGxRMzdxNU5XcXkrWTJFWVc3ZmVN?=
 =?utf-8?B?d1o3SW4wL1FjSk1KWHZ4LzB2b3BVeSsrQTFLNVp5QnZTdGQ2WUhrK0EvY1RT?=
 =?utf-8?B?OUlpK2h3eDloY1h3TEV5T080MWJLa1BWTWVKVUJnb2ZQWFlXWHpGWjhBRWda?=
 =?utf-8?B?RGpaak9ualJhcGY5WG94S1UxTW5iTS9jNW9ETHBwZFVBaktzV2lLbnV1bXVx?=
 =?utf-8?B?UWhOYmk2bnJrYndWM1ozV2NzYmtla2xwNXRrRmord21oRUxmMWNYcVk0eDVq?=
 =?utf-8?B?T28wRWpwNUZKaEsvLzc2Ym1vc0Vzb0hnckhYTlFqakR3Mjlib0I3N1U2bENN?=
 =?utf-8?B?RzF1RlN6Y3NZemlpd2RKRlFPQWowVlFTaVMxbXp4a1dGL0ZmMUxNdFU2eXhp?=
 =?utf-8?B?MzE5YWlvaEx0bi9MTk1yanhmQjRaaktyREdlaXp6UDRHanc4N3BobFZPMmN0?=
 =?utf-8?B?RFVjNTFmTy96U0xzbE5uWmJZSWFzMEdRaVFUcGtzR2REMzVSN0lSVUxJZy9H?=
 =?utf-8?B?TC9aK2dDaEVFcUtPMWxlVW5DNXhvLzQvYmEzMGJaZGRVMnF5SzhqbXBUQjJZ?=
 =?utf-8?B?Y095R3I2eUxsMklFd3lobDVuelYyMW9FWjBTQ2pGc3VsR2ZHUXBCbk1ZNVFR?=
 =?utf-8?B?RDFFeis2cFA4SCs4UGlaUHkzNE1lSDB6VHo2SlpXNEFSNEo5UUIvOXlzdWRv?=
 =?utf-8?B?U2VzSHVab2U1c2k4dHBpM3RHYlE3dExGTFZCZ3JaUmxCejZ1Tk1QNzd6WWk1?=
 =?utf-8?B?WVdCeU9YdlJvK3FpVlRITTZWcmxZSnpWQjVrNXoyZHpiM0FPZy9DemVoQnV1?=
 =?utf-8?B?Nm4zcVVPYWtjbHAva1BGZWFBTnhiTzRxdHN1ek4wQXdqOFVjQnMrbzZieFpN?=
 =?utf-8?B?blpkb25oellxNUIvczhSQlZUbVptUkdWTHltRnljQnRYSURlcTM3VTBlaVl3?=
 =?utf-8?B?VDgvancyVzg2VkJPdU54MlBQSFRMbmZBa0pIYVdQcENNTWppYWppb1NpVWY0?=
 =?utf-8?B?UlZnL1hVamN2V0xFQjlHa0x0dVFqRytmcHMzUldkVE9WaGlnUXFrZVlHeHZy?=
 =?utf-8?B?T0JOMVhXWUEwczA1bWhnTy9pNmRLbWVHSW5mZmR2K1lFclJiK3pPMEtwNFZY?=
 =?utf-8?B?REl1Q3pQVGovdmNMQktRN1VkZDVUeVhQZzAyMjQ3QStCWk5paHVxVmdwNWtU?=
 =?utf-8?B?dFR2RzhHaG5XRVhzTjI5ZnhnemVHQlI3RVVuT1JBbWppZ0FtWlNHZXp1MkFS?=
 =?utf-8?B?N3lmOFMyVnlXOVFLUFNnWmxFK3pUTDgvNCtQM1lxRGw0R1FOQ200ZTUwcEZJ?=
 =?utf-8?Q?FK91VAph2h/6s0550I=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-10f0b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 564eb9d8-4984-4eb7-1427-08dc24169e26
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:44:34.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7979

Hello Russell,
this is the pach for the vendor "ODI".
Same hardware but different vendor.
I explained it in the description.
Hope this clarifies.

Thanks and regards

Sergio Palumbo

Il 28/01/2024 15:43, Russell King (Oracle) ha scritto:
> Oh, a second repost. What's different from the first repost?
>
> On Sun, Jan 28, 2024 at 03:23:06PM +0100, Sergio Palumbo wrote:
>>       DFP-34X-2C2 is a GPON spf module working at both 1000baseX
>>       and 2500baseX.
>>       Setting the module to LAN_SDS_MODE=6 the module is working
>>       at 2500baseX with auto negotiation see at
>>       https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
>>       Unfortunatly the module's PHY is accessible at 1000baseX only.
>>       ethtool returning:
>>       Supported ports: [ Fibre ]
>>       Supported link modes: 1000baseX/Full
>>
>>       After applying the quirk:
>>       Supported ports: [ Fibre ]
>>       Supported link modes: 1000baseX/Full
>>                             2500baseX/Full
>>       Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
>>       Tested on sfp to ethernet Media Converter.
>>       Autonegotiating 1000baseX or 2500baseX according to the
>>       connected host speed.
>>
>>       This module is existing in 2 versions:
>>       Vendor = "ODI"
>>       Vendor = "OEM"
>>       This is the patch for vendor "ODI"
>>
>>       Patch has been inserted keeping the list in alphabetical order
>>       first by vendor first and then by part string.
>>
>> Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
>> ---
>>   drivers/net/phy/sfp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
>> index 3c0028a4af92..410375bc6b94 100644
>> --- a/drivers/net/phy/sfp.c
>> +++ b/drivers/net/phy/sfp.c
>> @@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
>>   	// 2500MBd NRZ in their EEPROM
>>   	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
>>   
>> +	// ODI DFP-34X-2C2 GPON ONU support 2500base-X
>> +	SFP_QUIRK_M("ODI", "DFP-34X-2C2", sfp_quirk_2500basex),
>> +
>>   	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
>>   
>>   	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
>> -- 
>> 2.34.1
>>
>>


