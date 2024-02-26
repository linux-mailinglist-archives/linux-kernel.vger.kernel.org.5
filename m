Return-Path: <linux-kernel+bounces-81738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953586798C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0B1C29165
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7812CD97;
	Mon, 26 Feb 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qld60ZqT"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2034.outbound.protection.outlook.com [40.92.98.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B172604DA;
	Mon, 26 Feb 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959107; cv=fail; b=lf78QQeDBR+y21WOpt2dvrR9fG819whclOc9Y/7W+Ba3lUsK1jWhIHxQIQdzMI8/44Uo5b9TbuVWZd4XSus2C52mqeDdNtRPGc0gPa7mbv2nlqSUhbAY9J/86Kjlg6TzDfLWmIO4HLLt+zkzrUMsHnICjDNpAtMuWUK+/SWNWpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959107; c=relaxed/simple;
	bh=/VH1Axdaomc9qYXNYE9ISHTQh17C3KycDj1UeZ0CtOw=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEqqWsp4jXUyG36WgDIGMTg2qyAA4OtIS+zjlTZcJaTGZFYrynE5xCwou+4RvoOSkVPQrbESWj5XGqg+MkdwwzZU+sSFrT2eVwPWMOEoZYnbXL7a1SRTmJ/4ylUoBnjZYFxcmK9bPMZ7Uy7HiP8B+DQ0ftBWlgn4yFWPW8bpTzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qld60ZqT; arc=fail smtp.client-ip=40.92.98.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Psa5DUHkJcXNSIWPICNnM2HRn0QHiCRs9DGjEpjCCoIjnDhL9qzEF150ngqA8upNEZgPqIY/5zZy1ipsh/C7iYj5mqi+J+92+egwP4zNIfwFjc0L+/EqZ25AmYPys9SsYD7nwZsecGjiB1dAZpVg8iC9oNyJOneJ+Vgy9iZx4t2bLdByPU+Z4RNhMhjYmC/uyEeOZgzINFTlK0pnWSxjL88Rg5kknybO/UQ74vU8k04TOvgPZBVs97ZePCnJ5LL8759L6HR70eDrHy2Jod04YFM1cMbaAB1/z5lfbmneSVB2Pv7PTbkl8dCzIAW2Dg1F4BO8FVMB8ruHxhNwlp6V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VH1Axdaomc9qYXNYE9ISHTQh17C3KycDj1UeZ0CtOw=;
 b=hyXKTkTnABoYyXH8OqghCNHZg28b9mK3THUpw8QTfjkzacKWfP+j05Ssxfs1sHSvqnZEdvcFSJvktKZm81ov2fVjBN+nnSMxcezMX90FIszT1Qt1MzyDAlMvI7AD/tlWIYzGEgDvs+O9zqCbw7Rq3PzeCxFS5Wd/I27jA3KWSKzDv9hTo1RJsBBRqKy6msW16LmUSlP8kv8OuavvcXQzYWGScBIQjQFRDpyc1uMjs28iFS1kpGn4l2sbqGJDHIyqsqE+IT+eZL0izVxNC3MU+HhNVy+CeLXZNq4gOMKPITE+LRGjkpEt5NccavyItCHowTJRq/pc8FDlDBQy/zsAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VH1Axdaomc9qYXNYE9ISHTQh17C3KycDj1UeZ0CtOw=;
 b=Qld60ZqThRkApn+l1n3K4BVl8Ht/YuoulPj3z7rwqFoBpM5CUuw5FGpZoofwXiiWAP4mjCQ/anSqHAW6XjtL7ek0HIMWL4c9aa0/Dot/1oe5ZsVk5z8Hf9XqHS70ZvhY9CwJ3S2wTYpNWdHSBh/n78dZDVYEO7Q473iDL5FyaAMoRUK9lqKK2DXqOIy+RZgJ6VW2bXMC9dCfVQ2FbXQhuxa1BuzSrir5qPJ0AAvQ6AD93CMytU+O2YXL8wlWm5+BiSrm1AZ6FC6lDX4aIJkg3vCuhyldtqnCzkZkLuj63fTgodJYRvP7CeRsdpAa5b4DvBe1sJ5PUmysv3syvHmfgA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB2473.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 14:51:41 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 14:51:41 +0000
Message-ID:
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 26 Feb 2024 22:51:36 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DsaZTc0LVEMNs5qNMtOhGV92"
X-TMN: [BV8HcgC9O207m/0VI4CwZ8+DhBZp4UDN/16Er5UO++77vchmvg0jxfrJ59hlWxOK]
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <c69eaa41-14fd-482d-8ec9-08cf831e24b4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2473:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf0fd46-200e-4e13-e0db-08dc36da713e
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVe5bVfS5Sv6/tIPJJ4eIVu1ieJHbuNyolYyzklGbbr/dXAShw4U8DRsgvpm6P3Bqk0hhjSjpxitT0Ayy9TrgABKYcI7q0EGySMG8DNxw6+X6mbJmOMoWlop8IdQ6NTqpDauhPckSUnCzAdXbEGM2mGU+FWAV1u738odFdBvdIDbgfUCyCqGwqJCXyQTJ6QlKqK3gmW6ASerpWqUkqbkDhwBgq8brXcZZOrGWxXwG7QAR91CIsgpUI12NY1KztLyFkwiZgEHQlc9OzcspcZ5zZz9+8t5+M1cIjpQbDW5WD8zpZsK5sgUpnSgsDJ9NbxubtojIzeFKOdGfZI/Sx++9Hg3lI5kCxvAoW3U0/2vuOPUjpt4jO6pmUsh2t4jRC7dnKFxRN+GA773HVNatv6Hi8SMl5X8ZSK6fUn4LvyHc3HCZUlL83LSFfClvpS21YSzOk8rjtw5upvWSWnMQRQ9k7ycTTr3zK6TtyB7CyvKOjqqxHzaCNzsoctPkzBzxLMSPRPmuVFWiNwYTe/KXTDJVGD3TXeUj+EXUp5h11qFkj90VhzIwv6Rmu6NlNt7QbwFv2AwPe0gjU9FGSd9KG5nEZwUPhSPCEkU/hudRw0t5OvsABBoca52yvsfOaT/2kF66TBp1m+pCtTOezvFPTcIlRDqntYJvub/ehgIzjpzy/sOiS+g0RCEGwb+07WiEBC0LTPqrxQclAJZ2kcZFMGUd7BrMxlHrlxlgQbDqlEZ1Kr7bB60WUlI1f9otdXz1eMnLHWCheaprndxA9Rqjm0W6JVnL6nO2D4iVY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FaGKdn33C23Tj2qhVD2BV9h7eOwNhSfVGNPU77yWAj7sSLHbO02K16zU48NnK+5w5NrjIQwfwuIttm/0y4k+zmHZFg19cBFHHPipWDCF4YJZGYST/RW2WX9XhZzQtPryiz7ivDg9vfc2dJOaMTmoKKHXmIP7jfLIvXT2iW42OQ5lynQHGiL9mQZh8MTLhjTx1fhZ8F4LETmG82OFzopA41MIKqqBm1EG+AJxVmY7LOcAMIyhgemCIPSDWK/4O6+zhs0xCmBcrurf/gU5BprwCQmnVTDZEjVYF2HKjkk4fhQm7FFpakL4ponJpBfHpzXjXkz5z+6YuVL9wyQX/+JCc18VcONfkJcHvwPACzpztb2JFgbc+j0zNrkHTWtQZK8et3To6/yUc18ysqC5sfx0wEQi6TGv2U7VkDNwkb+gO+O3cAchL2PuVMi3Xay4/CLUDEOSGxGL90nub8vjMB15ypIE3nL1iYRDZ/Tvh/oKTtnn38yYnH96mhw6UHiBREa5oQvxe9QlnOdD6mnE2Ot1zNAmQ7IYwdLglyaJRzYDr5p76V/BilCBtal+5LIcfxn5z2AZNz0ln0LLt37EVdngNkMgctedmy1e5jtzlF+M7bLc1B8pC8tn8IEWR+NsPX3NTvFo99ipqvKwtFkTTTCtJA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVdjZmJFSVBzWkpJckxxL3RPM29oNlZOZlAveUNDd0VBUVJteUV4eUpWdnhs?=
 =?utf-8?B?R2JaZERjQnBvZk9IckJyY1doekJUZ2FzYWRndjZOaS8va2Z3eEVFb3VtRTJy?=
 =?utf-8?B?bUMyUTlFVTYwc2JqTW02OFR5UW42UFFpbkNvc2NPU3RpMnE4dkdlN0grT1FZ?=
 =?utf-8?B?TXdZNHd2WEtpaENkSTFhUzJFenZUTEJRRmxaK3g1Qi9sdFRGTUtvYm40cjZW?=
 =?utf-8?B?aUZLeTlGTDgwbW1Qbm1TM0xvc25TYWZCeHZYWmdYWDg2LzV5TldqcnhTZ2h5?=
 =?utf-8?B?R1M2R00zalZuR1I3UjZZd25ybXlZYldhYUszWXAvRGFTdU5IeEw3dkRveVg4?=
 =?utf-8?B?SlZ4eUtJV2lVNmpQS2VzdWxFRHBHeHZTMktSSFllYWxBRGRLRHJEcFhYeVVh?=
 =?utf-8?B?M1lXQUxhSWNVcWRDaWFJRHVYSGRtRkU1c0JENUh5a28yc2pIUXVlMHZEYmZK?=
 =?utf-8?B?ZlB6ZkZJMWFXdVpKSlZUbURTa043bm9SdjNQYTc2YmhJM1FqNEhqd1BqZTFG?=
 =?utf-8?B?RGtxSGJrTlYrc0dsTVpUeWE3b0pxMlpiMEIwQnZnT3pVR2M1cWVMMWVjamd2?=
 =?utf-8?B?K3QvRXVid3Y2cDZHN2lDYyswWDQyd1FyZER0WHpxd2kwWEZFSGhKbWkzQ3hn?=
 =?utf-8?B?b3gwWDRYdnRVKzZTRktGN3ltaUhUOFZUeHZBK2JnOEJ2dFhOM21RR3d5NDNB?=
 =?utf-8?B?YVdTWTk5aXN0N2pXUDRMckV3VXdZd01sMjJ0WWx5YkdqRTR3UVNZc1Q5VFZw?=
 =?utf-8?B?VjNCb2x3RE5ncWhSZ3pHVkxBSm1HYWJ4eGlRQTdpT0lYNWNuNFZ5Y2NzamZQ?=
 =?utf-8?B?T3dFU0R5R2RvNDRya0p6Q3BvSk9HaEU2cnF4REMxNHFoU1Jsa211eVJ2WFJW?=
 =?utf-8?B?ek9YdkFXdkV3b3ptUE02VTQ1R0pLVjN0R05ydks5U1oxSEZDdUZVL3ExMG0y?=
 =?utf-8?B?cWxjQ2pLbzBEVzUxMWhnd1pHbHNwK2VIaTVkMU4xRDZ2a05LNlQ3UWQzTTFV?=
 =?utf-8?B?VDJ3bUZFYVEyak12M3hDZE1yVTlyUEh0M28wMnBoaVNLVXN3NmJlNzVpd0ZE?=
 =?utf-8?B?dlFVb3lFZWtOS2w3bmhSd2REUVExN3AxY2pLRjlvd0FTdXlaS0d4ajA0TTJM?=
 =?utf-8?B?eGQ3MmJJUHpzb3IvU2VtMHE5UlJScktzellmNmNseW40cnRxaEVBekpnTE1N?=
 =?utf-8?B?ckEzK2I1ekF4UTRNQjFSNVF0TWFMN3YxWDA1VE52UkVweExiaHI1U3VPQk5i?=
 =?utf-8?B?cnZCZjBUWmNReDlGOXhmaXhwQkxCemIzOVlFcGc2aXVtUmJqeThVZ0ZzVTU4?=
 =?utf-8?B?WmRlVXg1T0UwS2h4NlRZckxpakFZYUhQeVBWUU5mQVhSNldVd1VEY1QrTita?=
 =?utf-8?B?WFc5TUVSM3FEOEZNWWRQUlFXK3dvanU0OEFSSHdRaVpVVitVcmZobzAza01P?=
 =?utf-8?B?RVpaSE85cUdOdVpyRFdzQW96WjlMU1pjcnB6eDVqQ0w2K0xGTW9OcGF5NTVq?=
 =?utf-8?B?MGgvUFhkanF1VnJBTzFQbTR3a3lFU1BoejY1M005TVN6NS9XN1FwTVhKUC82?=
 =?utf-8?B?dDRMZzJaQi96Q2VpWW1hSU1Xem1hNkVDY2VMVldnSUxzdUFOUUVPSVVmdkZk?=
 =?utf-8?B?NCtrM3dxajVJWXh6L1ZneWMydVNxZmhFSXdYajRvQTA3VStSSHpBWGdpRTNK?=
 =?utf-8?B?Witwd1NnU2g2MXpJajBPMGcrWnQ2ckorOHV1emY1VzFDSlVLcXRIRjc2WHI3?=
 =?utf-8?Q?YCwYTqgvpfY19afAGk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf0fd46-200e-4e13-e0db-08dc36da713e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:51:41.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2473

--------------DsaZTc0LVEMNs5qNMtOhGV92
Content-Type: multipart/mixed; boundary="------------mqoC6rWPLEEwEcN2J2G4sHf8";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <c69eaa41-14fd-482d-8ec9-08cf831e24b4@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
In-Reply-To: <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>

--------------mqoC6rWPLEEwEcN2J2G4sHf8
Content-Type: multipart/mixed; boundary="------------SmRcGDLOJ8EXC8Qwod4B51Eo"

--------------SmRcGDLOJ8EXC8Qwod4B51Eo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUnVzc2VsbCwNCg0K5ZyoIDIwMjQvMi8yNiAyMjozOSwgUnVzc2VsbCBLaW5nIChPcmFj
bGUpIOWGmemBkzoNCj4gT24gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMTA6MTY6NDZQTSArMDgw
MCwgU2hlbmd5dSBRdSB3cm90ZToNCj4+IEhpIFJ1c3NlbGwsDQo+Pg0KPj4+IE9uIE1vbiwg
RmViIDI2LCAyMDI0IGF0IDA5OjIzOjQ2UE0gKzA4MDAsIFNoZW5neXUgUXUgd3JvdGU6DQo+
Pj4+IE9ESSBERlAtMzRYLTJDMiBpcyBjYXBhYmxlIG9mIDI1MDBiYXNlLVgsIGJ1dCBpbmNv
cnJlY3RseSByZXBvcnQgaXRzDQo+Pj4+IGNhcGFiaWxpdGllcyBpbiB0aGUgRUVQUk9NLg0K
Pj4+PiBTbyB1c2Ugc2ZwX3F1aXJrXzI1MDBiYXNleCBmb3IgdGhpcyBtb2R1bGUgdG8gYWxs
b3cgMjUwMEJhc2UtWCBtb2RlLg0KPj4+IFRoaXMgd2FzIHByZXZpb3VzbHkgc3VibWl0dGVk
IGJ5IFNlcmdpbyBQYWx1bWJvLCBhbmQgY29tZXMgaW4gdHdvDQo+Pj4gZGlmZmVyZW50IGZv
cm1zIC0gYW4gT0VNIHZlcnNpb24gYW5kIG5vbi1PRU0uIFRoZXJlIHdhcyBleHRlbnNpdmUN
Cj4+PiBkaXNjdXNzaW9uIGFib3V0IHRoaXMsIGFuZCB0aGUgcmVzdWx0IGlzIHRoYXQgSSdt
IG5vdCBhY2NlcHRpbmcgdGhpcw0KPj4+IHF1aXJrIGZvciB0aGlzIG1vZHVsZS4NCj4+Pg0K
Pj4+IFRoZSByZWFzb24gaXMgdGhhdCB0aGUgbW9kdWxlIF9kZWZhdWx0c18gdG8gMTAwMGJh
c2UtWCBhbmQgcmVxdWlyZXMNCj4+PiBtYW51YWwgcmVjb25maWd1cmF0aW9uIGJ5IHRoZSB1
c2VyIHRvIG9wZXJhdGUgYXQgMjUwMGJhc2UtWC4NCj4+PiBVbmZvcnR1bmF0ZWx5LCB0aGVy
ZSBpcyBubyB3YXkgZm9yIHRoZSBrZXJuZWwgdG8ga25vdyB3aGV0aGVyIHRoYXQNCj4+PiBy
ZWNvbmZpZ3VyYXRpb24gaGFzIG9jY3VycmVkLg0KPj4gTm8sIEluIHRoZSBmaXJtd2FyZSBv
ZiB0aGlzIHN0aWNrLCB0aGUgc3BlZWQgcmF0ZSBpcyBjb25maWd1cmVkIHRvIGF1dG8NCj4+
IG5lZ290aWF0aW9uIHJhdGhlciB0aGFuIGZpeGVkIDEwMDBiYXNlLVguDQo+IA0KPiBIb3cg
ZG9lcyB0aGlzICJhdXRvIG5lZ290aWF0aW9uIiB3b3JrPw0KPiANCj4gSSBtZWFuICpleGFj
dGx5KiBob3cgZG9lcyBpdCB3b3JrPyBIb3cgZG9lcyBpdCBrbm93IHdoZXRoZXIgdGhlIGhv
c3QgaXMNCj4gb3BlcmF0aW5nIGF0IDEwMDBiYXNlLVggb3IgMjUwMGJhc2UtWD8NCj4gDQo+
IFRoZXJlIGlzICpubyogaW5iYW5kIHByb3RvY29sIHRvIGFsbG93IHRoaXMgdG8gYmUgbmVn
b3RpYXRlZC4NCj4gDQpXZWxsLCB0aGF0IHNlZW1zIHNvbWUga2luZCB3ZWlyZCB0cmljayBp
bXBsZW1lbnRlZCBpbiB0aGF0IGNoaXAncyBTREsgDQoobWF5YmUgaGFyZHdhcmU/KS4gSXQg
d291bGQgYXV0b21hdGljYWxseSBkZXRlY3QgdGhlIHNwZWVkIHJhdGUgdGhhdCANCmhvc3Qg
dXNlcyBhbmQgc3dpdGNoIHRvIHRoYXQgcmF0ZS4gVGhlIHN5c3RlbSBsb2cgb2YgdGhlIHN0
aWNrIHNob3dzIHRoYXQuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg==
--------------SmRcGDLOJ8EXC8Qwod4B51Eo
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------SmRcGDLOJ8EXC8Qwod4B51Eo--

--------------mqoC6rWPLEEwEcN2J2G4sHf8--

--------------DsaZTc0LVEMNs5qNMtOhGV92
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXcpXgFAwAAAAAACgkQX75KBAfJsRn+
Vg/+LzNbsoviRMiU3GKEnqouw1sc+/wYZ0v4V1n4uFQFvlFc+xRtySj22DPJvb27skZcAkRDaJV6
j197j/78xb3j37c5zSOGPcajJQmF4yA5d5IrGKNSnIdh0Nquw2bM80n5edb6zZPr+mDA8m5Id8X6
TAzZPMPrj+OAXuQSi4bOZZjyHsslLE4Wzkxtr7xhzZjCgvOsIjNKt7tO8dBioTMKdaqfZmzs612f
aYmaCkKrPsclvUS4QXQpoJR8Ecu2a2btcAyII9tnRgPLabPC7vgKWrDgpocgSIDYAOfNvMJoEtB6
skFytWaui4jQ4IgKgfy6Icpo16T9Z0CLZ/dSzSHyUb45igCsfgAPTUT97BTb3BnODxqjGXG7P3Hn
0BaoTEWmaRcSkNGgoWNpvtQ5w1IdTb7y2lppSDBhPSwyZ8BNjaqZeGqEz9WLT9usDCjNBXmokZe7
CouAuOCIYzmsC16ebuU8uPcvX8LzHICaz2vIrTg/oXP/r4PwcfndR29wWcjhqdqypmRLfxIxDLzp
aAE1p/0Pe1yYtwbJbg9a9GPSiNbfaR0nWDG+6XmLzk91xsmenmJ5Og8kb0PG9yS0vAawmEyS+mbX
FwE8i+xI02K9iuWS2/CZs963cq6tVg9gZjQPUZTBhqGKqfUb0FXWt78uK+6ZDpW8MlMnwUl6lYao
8U0=
=AcaE
-----END PGP SIGNATURE-----

--------------DsaZTc0LVEMNs5qNMtOhGV92--

