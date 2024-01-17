Return-Path: <linux-kernel+bounces-29275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB5830BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858E328D29F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408C2263C;
	Wed, 17 Jan 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMqTOBpK"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40522EE0;
	Wed, 17 Jan 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512885; cv=fail; b=p6c6K+UmatjN2fcV5RFRbUoHA5QbVc6DZbn49hSdAanVoXNwWAZO6bhf/qvyjvkUr2oVh6UwFYySm5i/RHftZGWzifnrNLJ2t+8uy9CioNGhsAbjx9pKxQfg4rzsqC1cDtAEbHfcqADR9Q39dC838DWwVh0Kw1IxCkUKXHcK3Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512885; c=relaxed/simple;
	bh=qUgoo7mnvAnxD8ZdSelSwUU6MLkQSfipDji93D485Ns=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=LF/dE5zVERqBea0LbtqMGGuh7mDje11qqzI/hC5c9V4co4tYrDjC6ZMB3PkGJZdwW5PUn/fIgvr6dSPueLkFqMfQTqAp9c+0xHMYwnn3dJm/Y7wcyxuyf69yy/lc6sUocNwFinJdeCh/lBWRi5cJDjRZu8OtsMBlat2GdlNqL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMqTOBpK; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1xcQpDgA+qtSD6OBdUbo7HhXFBOrFUtLWkqCSL+xReYMb7nmYzi2pQhMZf1iQBS2LaQ/D5tW6dbwTwzPG14IYIiKcHlL4NaPwFhTUWVuungO6ofjfpNwFFSK5Z1MbGuho2HQP1CpY8b+hwIer/uOZ3DCYUW+tH06quH6VJ1VabhL347AtLXr3J3MTo69X2lY5+q1TLQg3PokbhkjC9IsKqEpfYzqkIjIHSgtO1LRosVukerd+zdl9/b0oiLPupY36l1Dqui/+4Fg9ABEQXyko61vbXSv2/fdzIPeyCU0hkkDHLWJUguCue9rD99KzWmtuskdXor/iVzAuah8XX9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9BkAB7AZcAMVvWqqpCFZpNt2wLA1+y9r8hcBwDw57o=;
 b=lFDf5g4GZybeegdCa4oBxFHymEkasylvnk4PqHVlhIdVOd+VubEZR1UnZ337etA2coGJ9jP+HZnjfPtstYepiHthv8QA3V8bp2ngwUNeTg+vztz9W9HVxPfnA//xxSYTeCFtoy5a/9XDSJ9ialnTvfhdvY94YV7C9jb7wmFjR5NItzpftmVbN7rWpEYrA+QqdF8lhisb+dYKXJw2obqW3WIXlfa80Kz9vIN/PTT20YOqw0vl6Y2+KZGSHKSnX5fwoaSWD7At+FWNt7toG6sVABNVFa3xFUm5pYIdb76uL45J/PHuIUVydkSTG5YdsKlHA9J8Muf7+aTf6RhgaV7v2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9BkAB7AZcAMVvWqqpCFZpNt2wLA1+y9r8hcBwDw57o=;
 b=dMqTOBpKUCiluSq9dnO2sQjJ4jcdPqic1oHXa/beDn92cmCrhdhJF44qb8n6m1esmF2z2qcH/3SNHkybbUjzgKPQ1gdb3ucr56U1yonGJqz0tsR26zgSUz021PwU+jMMmtMGE/IOIZlP45P2dcCPPqdRSOn3ZHRmUnrSi6aRbQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Wed, 17 Jan
 2024 17:34:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 17:34:40 +0000
Message-ID: <cc247521-5507-44a2-8ff4-519c7a7b1c79@amd.com>
Date: Wed, 17 Jan 2024 11:34:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Fix stuck UCSI controller on DELL
To: "Christian A. Ehrhardt" <lk@c--e.de>, Dell.Client.Kernel@dell.com,
 "Wang, Crag" <Crag.Wang@dell.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Saranya Gopal
 <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
References: <20240103100635.57099-1-lk@c--e.de>
 <ZZadhlh3q9ZInxvU@kuha.fi.intel.com> <ZaV/kwuh2MBNY5d2@cae.in-ulm.de>
 <34101c32-65cd-4433-974f-23a16f9981fa@amd.com>
 <Zad1K5V8mhNiiMWl@cae.in-ulm.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zad1K5V8mhNiiMWl@cae.in-ulm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:805:f2::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d3e442-badf-42d5-8829-08dc1782957f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Iurv9bLIyCLvHTOPFVUU+2V7OdEEssVVc59QdF5qjCzqn283S7rjV0jjToyivR6Wp4TNMBQQ0pVV6NvtdLyCCvRO7PdHgDbS91nnfBcRbLuUNS+QxJhkvlAL1ZbPkwmRgUsHHnKwhOs3Am1QtW3ozF5Ui7zCdINsSuQYtvY4+4fumZs75JhE5l3i62ZBaFuQ7fA6+v3+2dy+dDDI1Kt7eeJ0iVCUQLrEI2fDnOHjX1IsBX/XQ3ZNhrE8Ay46HS+Xk9FgOkR5alrImIJjJ7AjovNjH4QqkQtHmSDOTZWz7biC1ys2+ayh8PbxWz4fsrmBImLrZCHSbbmQa6DchZoX6H9pOekqPGvvhU/bhvZuxpYMR1+ACM94tfgJ5HLiP/PrcnGHqhrNe1VUswya7+B9l+UicbmomJSXAEVY0TxIFrg+GFLvfOxgZ4jKRUvC/MgI3aChNzTnof8gcENmDH0q1RoD22Oz7ZUI9J08nGOtAXy1l277lqq6a5aiWoSYbz2cJKjeIkyYfzLWfUDtnZmDwk/kcvLTK9Sr29TJVnUmrvElEAilFxuOK0E74i9PVngY+H2TFhw5d9utayd5OE91ZGmBPS68G2/2NWYfDVLyb6C8L2g+kDYbjPmnZGogWmJG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31696002)(2616005)(26005)(6666004)(6506007)(478600001)(53546011)(6512007)(83380400001)(966005)(6486002)(5660300002)(7416002)(2906002)(4326008)(41300700001)(36756003)(8676002)(66556008)(66946007)(54906003)(110136005)(44832011)(316002)(66476007)(8936002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2U4Uk1mcHNCVTZyQmtVTkFEVDdKK2UvSTlxSTlUdms3QXdZUmxBSWdGM21x?=
 =?utf-8?B?d3lKTG5yNGlmNWhJZlFEWUE5YW1MT24rWnFHRGcxMlkrNnYrbGlSbDRIYlRP?=
 =?utf-8?B?bXF3MEtPcG9wYnJiWGdOMEY0THR1VGVjZEIzcHRaUFJMTVcwTVVubHY0Q01o?=
 =?utf-8?B?NExQZXpBemdjbUJYcmQwVW9MZE9OYy9raS94c1I0S2lwU3piSDZFZWZIUkxi?=
 =?utf-8?B?K1dZRGRCSDc5cFRtS3hKTCsxdW1ZYm13dEpFeXJYdjFnV3p3THV4NVFWN0Zt?=
 =?utf-8?B?VkRjV0JtQU1sSitlbk9ndm40K3RsUGZUdUhac2h6WEpUQjFBbHlEWklxK012?=
 =?utf-8?B?MWMxUWwvMWIvZHVNTEQrKzBzVUEwMldtTjZ4SEVGYnc4SXEycWdOV0tvREFV?=
 =?utf-8?B?b0JheFo3REo3Z3FiUHEzcE1JNmNVUU5PSStZOEFQS0RDRDFXMGpsRXlueXhH?=
 =?utf-8?B?M09vZDRsWUdMMnh0anhNdWpxZEY0MDdERjMxSXJvM25VeG9hRHV6ajZuZ2sy?=
 =?utf-8?B?SUIwekNaRnhmbGdORldSc1k5RGNRM3NkZnNTMVN6Qy9NKzdCMEllcUlBN0FG?=
 =?utf-8?B?WklLb29qSm44SGZQTkFQU0d3dCs4Y1d1dFh4Lzk4Y3Njb2J1N05qMHd5YU1U?=
 =?utf-8?B?djQrR21EUURWZERBcFNkYjhPYnJ3dElPdHcxRjNKVXBTb1dMYU1ZZlgwZ21H?=
 =?utf-8?B?dGI1TVgvZGlPSDd6UkJiZGsrM1orTWV4emNybkJ4bEM1WFdSSW05a3RQamhS?=
 =?utf-8?B?dVgzR0YvaWF2ZlN1bjZYaExWSXcyNU02OTdLNVNGMmhwTDhaMGQweklZcXV5?=
 =?utf-8?B?a1R6VTUzMnhySjNWZW9xYVBrWWpHc0lBdGQrb3JoNXVreHpPSmg0QU45aVpM?=
 =?utf-8?B?c0VlbUJxM0JzakZIUm9nN21uc1VTTTFNbG9VckVWVFhFaWRtak5zOVJUaVNB?=
 =?utf-8?B?Zy9RUHE0dnljeUxvYjVFeUFBbVVRcm9BZXVVVlNEajVpNFV0bFVqUlA2eGRt?=
 =?utf-8?B?RlNER2ZFTmVZQ2JDRXlmZ25rVFEzS2plS09KUHJoOThDWnRpRXh4VlMyL1dy?=
 =?utf-8?B?RWNISU9OMExNM2NYWVc3Wlp1VWFscmFTZnJSMzJlWTNnUk5LT2M5bkt2eml1?=
 =?utf-8?B?cTRIR0F5UFAxbko2aDZkUUlOZFBBMXRxbkNhdk9BNXljQ0FXZ2tLTzN2bmxS?=
 =?utf-8?B?NlJ1RlRYRGoyREwrLzNvdW9BSHlJR3ptMEVhcE0zRHIvbE9jeU9QbnJ2ait4?=
 =?utf-8?B?SWVMbWxnQ1REQnVWS2VrbkpTOTlyZXpVOXFJYjh3cFNtanpYRzRhRkFyNU9i?=
 =?utf-8?B?NWxtOFg4V2dyZUVXYVBlUkF3ekdVNlU3cWxIWGxhZ3g0Rkd1VzVQNDNJQm8w?=
 =?utf-8?B?VUxlQlBVSlJkQ3IxdWl4YW5NdzhlejJmU29sQzVNY3d2U2xSTTBpVGxQdC9W?=
 =?utf-8?B?elZlMmJSQTQ3WlZHL0Z2Q1owY1FySlFGMC8rSnNSWkNrOHRWYzJqVFJmb04v?=
 =?utf-8?B?amc3dytMek9sclZKMnV4bTkyYnAya0N6S25PQ1hyR0tKR01LdUVKSUk3SWFm?=
 =?utf-8?B?Z0o5R2hMV3NEVGhyQm1FVUV0RUVJRnU4YVIxQmdiejU1V0p0cWdrOGtCeXlC?=
 =?utf-8?B?YW5Gdi9TZGNFV1YxMm9IODBPQVRocHFTd3huTit3dmJJdlNZZW9SakxHb2Fm?=
 =?utf-8?B?RTE1Rms4L0ZHQzRpVUx6UDU3SjA0WEp0Z1dNUVF1UDRTU2RYSWFwQVNWTTB5?=
 =?utf-8?B?UDI5dGNMazN1UHVHOGdsTThXZ0E1TVRrTXo4VWRmRFlnQkYxd0RJQkg5UFo0?=
 =?utf-8?B?YlhLTVVHUmtkVWNwcC9EaytXekNweDRINkJIUWdiaCttaVc2cjNTQ3BQeGg5?=
 =?utf-8?B?WXV3VHloQ1NkeXZhUG52V1FuTTIvaUNmUzJsQmN6NVQ5SzJYM05XNEVHb1hs?=
 =?utf-8?B?ZnhSQVFWNDJ0aS9WWjBHeThvK3JWa09mNE1welBhTWNuVWFhUnNQR0Y0azlv?=
 =?utf-8?B?WDIxWXRvdXBtcHY1RklabHppeGc2NFY0R0M4K1JyemZ0SWFQTGVOT3dwOE95?=
 =?utf-8?B?ZnVFL0NsMlo5aDJVMTFrKzhoZDhTWlBKWURoM0hPM1p2U2NsU0xIZTZTMFk1?=
 =?utf-8?Q?gzrRRZJur0c9iw3KOh9N1zNQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d3e442-badf-42d5-8829-08dc1782957f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:34:40.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe+dSxxmowlDpP+VCvdjaty5uILwVEyfB447rRRSPw0jbjpzPqXg86ehs/RIfhtDajTCFACvB8URPvL64H4HaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

On 1/17/2024 00:35, Christian A. Ehrhardt wrote:
> 
> Hi Mario,
> 
> On Tue, Jan 16, 2024 at 09:00:03PM -0600, Mario Limonciello wrote:
>> On 1/15/2024 12:55, Christian A. Ehrhardt wrote:
>>>
>>> Hi Heikki,
>>>
>>> sorry to bother you again with this but I'm afraid there's
>>> a misunderstanding wrt. the nature of the quirk. See below:
>>>
>>> On Thu, Jan 04, 2024 at 01:59:02PM +0200, Heikki Krogerus wrote:
>>>> Hi Christian,
>>>>
>>>> On Wed, Jan 03, 2024 at 11:06:35AM +0100, Christian A. Ehrhardt wrote:
>>>>> I have a DELL Latitude 5431 where typec only works somewhat.
>>>>> After the first plug/unplug event the PPM seems to be stuck and
>>>>> commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).
>>>>>
>>>>> This patch fixes it for me but according to my reading it is in
>>>>> violation of the UCSI spec. On the other hand searching through
>>>>> the net it appears that many DELL models seem to have timeout problems
>>>>> with UCSI.
>>>>>
>>>>> Do we want some kind of quirk here? There does not seem to be a quirk
>>>>> framework for this part of the code, yet. Or is it ok to just send the
>>>>> additional ACK in all cases and hope that the PPM will do the right
>>>>> thing?
>>>>
>>>> We can use DMI quirks. Something like the attached diff (not tested).
>>>>
>>>> thanks,
>>>>
>>>> -- 
>>>> heikki
>>>
>>>> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
>>>> index 6bbf490ac401..7e8b1fcfa024 100644
>>>> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
>>>> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
>>>> @@ -113,18 +113,44 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
>>>>    	return 0;
>>>>    }
>>>> -static const struct ucsi_operations ucsi_zenbook_ops = {
>>>> -	.read = ucsi_zenbook_read,
>>>> -	.sync_write = ucsi_acpi_sync_write,
>>>> -	.async_write = ucsi_acpi_async_write
>>>> -};
>>>> +static int ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
>>>> +				const void *val, size_t val_len)
>>>> +{
>>>> +	u64 ctrl = *(u64 *)val;
>>>> +	int ret;
>>>> +
>>>> +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
>>>> +	if (ret && (ctrl & (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE))) {
>>>> +		ctrl= UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
>>>> +
>>>> +		dev_dbg(ucsi->dev->parent, "%s: ACK failed\n", __func__);
>>>> +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
>>>> +	}
>>>
>>> Unfortunately, this has the logic reversed. The quirk (i.e. the
>>> additional UCSI_ACK_COMMAND_COMPLETE) is required after a _successful_
>>> UCSI_ACK_CONNECTOR_CHANGE. Otherwise, _subsequent_ commands will timeout
>>> (usually the next GET_CONNECTOR_CHANGE).
>>>
>>> This means the quirk must be applied _before_ we detect any failure.
>>> Consequently, the quirk has the potential to break working systems.
>>>
>>> Sorry, if that wasn't clear from my original mail. Please let me know
>>> if this changes how you want the quirks handled.
>>>
>>>        Thanks    Christian
>>>
>>
>> For the problematic scenario have you tried to play with it a bit to see if
>> it's too short of a timeout (raise timeout) or to output the response bits
>> to see if anything else surprising is sent?
> 
> It is not a problem with the timeout. Waiting forever in this case
> doesn't help. IMHO this is actually a bug in the PPM, i.e. in Dell's
> bios.

"Usually" the PD controller F/W is distributed with the EC, but yes Dell 
nominally puts everything in a monolithic BIOS package.

> 
> Sending an ack after the timeout fixes things, though.
> 
>> Does it always fail on the same command, or does it happen to a bunch of
>> them?
> 
> It always fails on the first command after UCSI_ACK_CC_CI for a
> connector change. However, there might be no such command if the
> next event is a notification.
> 
> I did play around with it a bit more and came up with a way to
> probe for the issue:
> 
>      https://lore.kernel.orgorg/all/20240116224041.220740-1-lk@c--e.de/

If some variation of your prob-able workaround is picked up I think it's 
worth making noise when probed (dev_warn or dev_notice) about this 
situation that it is being used to workaround a PPM bug.

> 
> regards    Christian
> 
> 

+ Dell Client Kernel mailbox

Dell team,

Can you look into this?  It sounds like it should be investigated more 
closely to see where the impedance mismatch against the spec and real 
behavior actually lies.



