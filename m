Return-Path: <linux-kernel+bounces-16921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1E82461E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7861F213CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F424B43;
	Thu,  4 Jan 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="BJfcUp6x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6624B3A;
	Thu,  4 Jan 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji7i0Cb86eiV/F6Kxu5ogbJQCnN9qSLnDiVHPn8qn1pWrxZ+KF8gDJxjOScFqwLAqZX4MfD9zAgHQzuln5zluY05cnHbivRWUWAzUej/X7KqC+my8JaTUD1pzg5nJoNUtBWFlsS7ci6eYFPD9zvn/S9C/ZbwPtU4U8yfxlIlW+cbRT36s4Ju4+3eGwB6xvHleuWekMSaRrH5bU66E3rLBb6tlwrz3qjcZQxT0/7JaDxC8dB6PLbELoxPHhUMfPDk/FZm26vR41fB1GCMLcaqTZrpr9hUKS2vwIBT3ai6VZ4grPlRLORd417IiXUgfbA/SsRGJZj/k3p89z324VKFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBqya0D4xP3jjLsuNrVrVKHekGegI3fOk2kz7ms29Kk=;
 b=ObuOqzvj4pdqltNN8PhbdrT5RTk2uRX/+ZhwQgTbjMTmXggLuaNXZ6m988IGtY0/0VsiqV1Oqdc3eu0vJlOxTMQehHHTwpXoVvJrvOvcc2Y2swoymXSZ3tP++QBtJfEkSXU0iumhf0Jcz4f7P0KGDN8foPkVFcV5iyb3OOJKBcSDP33aCu399tL4s6mVuK+pXff7dfvG6ttw7SkiQqKlETewGii+9N9Dz3rjSHaQdDZn473LnyYBhfSL07UDyOVleoBiReie8hJKNk4Efp5fJxLa8f3OaF/Jl7M7Ai498vrWTf2xUeIwEV+zx7A/3Y77yXcepUdfohbAEOxZ8zbvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBqya0D4xP3jjLsuNrVrVKHekGegI3fOk2kz7ms29Kk=;
 b=BJfcUp6xNhlG2LXIm19++qeARlUAL2fIhdWNy5FCuAhGIiHt7peU+1u4ezrhK0in0ujkgT2uK5G0/fJyJZXEdSa1H58NTMr5IUaVAdbQANPNAEH+Q9evTmmZdDEJO1Boqq6DllVEGouI2DMLMOFHHRXqh1ElkbqdWQaoNOTadFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB8282.eurprd08.prod.outlook.com (2603:10a6:150:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:25:31 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:25:30 +0000
Message-ID: <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
Date: Thu, 4 Jan 2024 17:25:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com, rogerq@kernel.org
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc357cd-004f-47e2-c085-08dc0d41c4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cP+zNrHu9ix/N3LXWnV7XiOKliRwPawGboZEsdpOF6Zr7k5dmeCRQX53u8vHYS0Sbk+hLfe/1NGI8Y9o9cbQuEGSUWMxj6IUx0IfLnR0DTgnH6rNbAIiIDv0T3af92lytBCYE7AHo+hqnejj/LvbR6HKhoJEcWscksXoBrQ9MtjH0mcEfs8hcLwPw/KcxH4LGqFDXCcoRbMbwHWPbaxIO7luAtP+sgeyDYLqStB7gg/zuO8mAIjcLyes0E/65Q8fXoPoDlSjGRuJe/3BaKpd9r0K03uwI7rUIcFTq4RrrLV1+wPNLBcObBNxlJehNia3cofxVQtD3VoRe0uXtMhWxutLjsrd0Ta1aWvlziH2Q8ijxuBlfc+xQS723VSK6oYMr61yOj/QNc1cdhkF+6aT6HIEAzozdJM3kJOYBLeinzfvqR4eYtOGmek4/iMHBxhleJOtgj54e8iTVQ8CFyHI1ctOTYlhMRjIqWzK5R/ZPd2kvIIVLJ802d2tKkF7sudTtKSNq7z+MH9zJAv0zmtzwTOskrovr+f2GH75+Wl2aKpnrp9bL5xZ9l34ltBJVbRo6GCdLiNPSoPVDg+sWhM4J01R9kBUQ7+Knb8FMoaHR61e4JOKeRyrYdmv2qe8105aRW6AxevF3+vzlZNk1uS34Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6666004)(6486002)(478600001)(6506007)(6512007)(83380400001)(2906002)(15650500001)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(110136005)(8936002)(44832011)(8676002)(4326008)(38100700002)(2616005)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STh5bFErbTF4NGxLdUxEOU1ESVBCQkRCcDIwSGYyUC9mU0VLMVJnd1Nwd3FB?=
 =?utf-8?B?MUQ4SXh6TTg1d2kvMjNRd1VXUjFvZGRiR1c0d29XdUJWVkhtbTgvaHhBRzZw?=
 =?utf-8?B?djhPQzdpclVUWVc1R1JKQWJwYnM5aHZxWllXLzRyVzJOcVk1NlhXejlhdXNx?=
 =?utf-8?B?cXpPQ2I3NlByVHp2ekV3UE1obFhKa3NYRXIxUmxablpNMkFJajNhSkJVRWVM?=
 =?utf-8?B?MTZIbmFPZXkvZXBodXRiSFNzOG5mRm9Kd0JaSE85M3ZwL3dIZ3h1NVpOV0Q0?=
 =?utf-8?B?Mm1rQzIxN29uUGhzNEdFVElIcnd5NUoyVCtWZ1BnczgwbjZSdTVVY29ySGRj?=
 =?utf-8?B?QmEyYTNiYW1teHJzQW9mZ2RqQmo1eEZaT01vdC9Ld2ZUWHJaanloaFQwUTRP?=
 =?utf-8?B?cHFkOEU1RFAwSVlYU0MyRFgwTVpKbVFiUVNDZFNIZXVmYzhMWFVPakpCZDVn?=
 =?utf-8?B?MHBDV2VHUFBoN2dJNmpQNmdYZGVRdWUrWFpQTVFHa1FrM0V2S0c5TVVtSWFQ?=
 =?utf-8?B?RzBjYllrNTU1dFlsNS9VVHkzdklUVmg0b2NlaGdXWDF3eDhZVFdqNmhQVnRZ?=
 =?utf-8?B?eGJUajRuR2V5aVQ0aDEya1NJWlBSNFF3NVlsK1pSU1VhYXhwK283TEhmN2Zl?=
 =?utf-8?B?cHVZdklDRUwxS3U3RHRwamZWamg3U25HNTkwYUpLeFdXWG1pNnplcjRhY3Vk?=
 =?utf-8?B?VW03VlpzUUhlWHk0RGlIcXB2SDFlWnluY0YyN0lxQmpyNFE5Mnc2NmdqOVZW?=
 =?utf-8?B?U3g3R01GOHZjTGlzUVQ2b3NHN2RBaGRnaTF4eWJkYUpzaC9LaHR5b2RGOTRy?=
 =?utf-8?B?amRJZTJOVW9Ccmk0YWdUbEdQMngyVzlRWmE3UTltbEFVWWE2N0pDaVB2YURX?=
 =?utf-8?B?MzFWa1ErODdLZHRLTUZSV29mKzBEbkFxcXc3amhQc3VSTmVERHdHaSt6WDN1?=
 =?utf-8?B?VlpZYXB5dUVPMzVtRlFUd3dqTkRJSFl1cm1HYW1XamV3SUp5eURYSjduZEto?=
 =?utf-8?B?Z0JvK3lvcGNuLzVtK2lzL0ZmSVprbmE1Mk84VlEwTnppanNHYm1kUUJETk1F?=
 =?utf-8?B?VlZNZGF4VDlueGl0RmNBWTVDdjNCaCs1RjQwR1lOQm1nNHVQMG5LU0Jlenpv?=
 =?utf-8?B?TFhsZGpTM1A0aFExUXpQbTBDTHp6UThyM0ErRkRmeFJhUTZldlgxcVNpSkRV?=
 =?utf-8?B?aytOU0hPRzE3OFRsdlg2T3pYc09wb09EOFZWZkVwY3Q1UGdBelpsQTZFY1Nm?=
 =?utf-8?B?ckZHcnNmajVLQUIyTGtVZGhTVGRhR2dXbXprajkrenNNMTUxTzB2d012NGZW?=
 =?utf-8?B?Q1VqZk5nd21aWHdWZVo3anp0UzFlK3djaTFVZ0ZKVDR6Q1pWQVRmVm4xUFA1?=
 =?utf-8?B?SWIrSUkySVBzOHRQTUxQSzRsWFA1akVKS29HK0t3bDY0cVgzWmd3MGcvRFJW?=
 =?utf-8?B?YTRpeDluZ2ZWeWt2elVLYnpXYkYwa3ZRa1ZqRktWQ1BCWFZPYXVYYnRIbSt2?=
 =?utf-8?B?Q3dDT3h1aFF4SHpvZ0UyL0hCdkM1OG11YWwxZUx2K3dpS3JBaVcyd0lRbTRu?=
 =?utf-8?B?bWs0M0k4ektaLzBmNy8yMzlqaVNRSjN2QTBIVlkxeWxkNjFwNkE0R21tZEFX?=
 =?utf-8?B?dGVaeTJOYkd2RXhXdE95Sk52SG5qTW8rT1VBci9WazVsOUlTUGsxczJCWGYr?=
 =?utf-8?B?OE1CUnJ1cmFQLzlBS3phY3c2QlRONXh4ZWcvZHRiaHBycFdyQVljUjFiSUtT?=
 =?utf-8?B?bDQ0eTI5dS9WTGlDTEluWlF6N2RKQkh1ZTkyMnBQZzVUZ3VkWWhiUGRxR0h5?=
 =?utf-8?B?SmhZTzczY2VwMHliVlNaWS9McmlQbjBLQnhJWHBLa3RaQU16eEhPNWhrN1p0?=
 =?utf-8?B?dWV1QThtcmlabnVwVnl3YVhhYk5xaXBGMmd6Wk43WkExaWk0ZUV5WVZvb0ZL?=
 =?utf-8?B?MzU4RUxlUDlNdmlveFZUcTVPTUcvRkg2YjZyMGVkRnNnd210Z0lWeFc5K2NQ?=
 =?utf-8?B?WnVaUUNtR0dMTFBQOVQyNDJWNlJDeFRXNUFlQm9PT1JabkRqVnc5azYxMkNs?=
 =?utf-8?B?VkxVTDZhNkpIMXMxOE1FRVh1TjhmN0NvR3FSQ3JuakJ5MlJmTzkzWjNXTmhJ?=
 =?utf-8?B?RGxuMjNJVWUvSkNsOUwrZmJiZWJMN283a3VaRkIzODFjdm41Nmg3K1FQaXB3?=
 =?utf-8?B?eTBMQjRhSDF6dGYyUGdYTFRubWJUY2lHKzlucWpGZXJtalFpZVNtY2JUQ2do?=
 =?utf-8?Q?+XrEYhqV+57LxZJJ3ERMA9pEaEiTij26ha+lSg7n9A=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc357cd-004f-47e2-c085-08dc0d41c4ca
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:25:30.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZ9GvPsaPlmJnhNpOkLqvsKyM929Lw18vUFKqHacdKRCl/NTDFZDztfjtUYFUAdWSaB8c0n9kCQR8ntcbQfDq1S/vfKsKnJAllSghTtkThw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8282

Hi Jai Luthra,
On 04.01.24 16:47, Jai Luthra wrote>> FYI, this series breaks boot for
TI SK-AM62A and SK-AM62 which use
>> TPS6598x as the USB-C PD chip.
>>
>> The platforms stopped booting since next-20240103 [1], and reverting 
>> this series [4] seems to fix the issue [2]
>>
>> Is there any change needed in the board device-tree [3] and bindings?
>>
>> We don't specify any firmware in the device-tree node, but seems like 
>> that is an assumption in this series. I tried reverting it (below 
>> change) but that did *not* help with the stuck boot.
>>Thanks a lot for your high-quality feedback. I am glad to see that you
even found a solution to the issue.

The firmware update only happens if the device is in patch mode ('PTCH'
in the Mode register - 0x03), which is the expected behavior because the
device waits in that mode until a patch arrives. That is probably the
reason why your first attempt did not work (no update was triggered).

The problem seems to be related to the reset function, as you already
noticed. That function is only called in suspend/resume, if the probe
fails and in the remove function.

Did the probe function fail and if so, could you see why? The reset
function is identical for the tps25750 and tps6598x ('GAID' with no
parameters), so I wonder why that should be the source of the problem.
> The following change seems to fix boot on SK-AM62A without reverting 
> this whole series:
> 
> ------------------
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a956eb976906a5..8ba2aa05db519b 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
>  	return 0;
>  }
>  
> -static int tps6598x_reset(struct tps6598x *tps)
> +static int tps25750_reset(struct tps6598x *tps)
>  {
>  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>  }
>  
> +static int tps6598x_reset(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
>  static int
>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  {
> @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
>  	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
>  	.init = tps25750_init,
> -	.reset = tps6598x_reset,
> +	.reset = tps25750_reset,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> 
> ------------------
> 
> I am not an expert on this, will let you/others decide on what should be 
> the correct way to reset TPS6598x for patching without breaking this SK.
> 
> 

The driver did not support cold resets before, but that does not mean
that they should not happen like it does for the tps25750. Your fix just
removes the reset function for the tps6598x, and I would like to know
why the reset happened in the fist place.

Thanks and best regards,
Javier Carrasco

