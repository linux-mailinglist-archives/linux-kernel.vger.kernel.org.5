Return-Path: <linux-kernel+bounces-164193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF08B7A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E3288092
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C71EB46;
	Tue, 30 Apr 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="DRVl+YGz"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DC143725
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488375; cv=fail; b=Uu+gVT9LdJXi49IGhpej17u8IAKth4NbfSKLv4nEAm1pXuQgQnVZIbs1OAZqadgGxzZsvmpIzs8u1Vdf0tT760oJO1NZpjBG4y37M1ctTFITGxhwpLBAg8IffjhdCHxcHHx7OvSOUAoWuA3fVHhX8vh59ke1/j9CEthXtLFzbJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488375; c=relaxed/simple;
	bh=rllGFwWZrs3mEoxDiptTG//X9xRfzyDt8iz7cLIeBUw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLGyMj+qUs4mNS46GW/JGvYqGJS5eMLsDIM2+wf3O7MBrn8YDWe4jIlsK5vjfLRT5/tIDxo41DWRg1lZG/UTzftEJGvXfUKCaVfBfyi1KvFrbc1yw2+lOuL2XaQhixgdFsu7D5l0Fea/tFKyGixPXeETklxYuq7OjgGRrUG7Lv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=DRVl+YGz; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.58])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 61D3E100598B6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:28:48 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2D264100017A0;
	Tue, 30 Apr 2024 14:28:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1714487320.079000
X-TM-MAIL-UUID: 73c911c7-bd73-42df-81a0-ca7e591f60cb
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 1384E1000040D;
	Tue, 30 Apr 2024 14:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIe44ictO4ejYwJxotxPkWUNGG/nU1+JS4wQqEbexkRimvHVHOTbkv14Rn+2mcJ9XmCTSOdF4FJV4RwDPv4p6GsljqLw+WRdMrYLvwc356aRTTes5+rFPCXtd9XPWnYkVHw85SiB99BroM9BUNJ/5XRDSQrSjdKGLxk5YgSuFJu+1IQn+mvq2mFmnPCEdLdLqoM/bCh386paS9XYYieGlOLClb/9idPDPaO/HsTuwzd/rPJp86zzHJbNsaVvCxzBmq2oIrI8JmUbmYPb+tUlJIh6PE+u8yFjVppIwLK3jCBLrJnJir8dvY3ImZ44hyE+/4WWONPLN6vhQCMLKeSXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ahI5hAeMHMVzdohDODR/KKQ2YC66pCKEqiCwYCFB8w=;
 b=HZdzIQmyxM+MlP8hkhiUiP7pqjJpWRsC1mvsBEPFuspnvlqm5LU/zUUfslELIZUifnUtV7xHY4WKRpT+D/M8DRHw9xggdaJhvftVMKhUFloJCBJkHjfKh+npdhRbgMFSy9HmMWJFfz0pDwCry5Y2zVvWdFGpO+UHHZ1gHT3pODY/wbDWKK1tHp5LxP6S6V5vNxO1vGtfJLfYsMzLi3QmFrSJ3H6USpxht0sUC3r0KjPj5Zxz5/7B8slB7j7IQ2N7Y4sMVWn2JBKsiFESv4t2KmeI/g8ehQ2Un3rGYysECgsLvXOv4Z69jGEbE0BZpduuzZF2dGz9Ssy+kZQrNrIB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <ace1be8b-d66d-4326-b5de-0f4164df88e6@opensynergy.com>
Date: Tue, 30 Apr 2024 16:28:11 +0200
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v7 01/12] timekeeping: Add base clock properties in
 clocksource structure
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, pandith.n@intel.com,
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
 <20240430085225.18086-2-lakshmi.sowjanya.d@intel.com>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <20240430085225.18086-2-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::18) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEZP281MB1959:EE_
X-MS-Office365-Filtering-Correlation-Id: 644ce4ab-9e36-452d-f6a6-08dc6921d392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmM5RVNTMGZXbWYxMWVycW9yd0dlZlI1M1RWNXpzOWRidUlOQzhwdmlobzRR?=
 =?utf-8?B?ZWI5NEdUc0w5ZjFTTFBFWU5WOTJaTHZjREFLQ1M3K1NNYVlLMnpnYjFnRnlE?=
 =?utf-8?B?NVBwQlpSVGlHc1A0cVpzQkg0V0xjaUQ5SlVDWkprMmw1VDVRTjdYbm9tWjNV?=
 =?utf-8?B?RmtmUG9ITHhUNTJwYkN1eDNuY3UxUVRCMmtNaDRDdnpJdmZhdVZKRnR0YTJE?=
 =?utf-8?B?bmlFcXZBWHJncFk0T2Z6emxGajVwWEtnQkFkS0NBTUpUZzRXYTVsNnRHcjVp?=
 =?utf-8?B?Qmc4SzFCckhVSURCRG55ZHM0dHl1WUpPVkRFeExUMFhQUjhZZjZjU1NKaUFD?=
 =?utf-8?B?OVdJNFpwYlRwUzVLVDRTMXoxZk42UTlybU1zTHlnbUlKL1l2N3FSSU51d3I1?=
 =?utf-8?B?SFhtV3Z6UUkrKzQwVjhnY0k0dGZPZHA2ekU0c29MMWxPeDltL3JScHpjZE00?=
 =?utf-8?B?aG5KQjlUNHZqbkdxV2VRZ2RJOTdhZCtvY2kzQUdOUFpCNzlPQ0RpN3Vwcm5O?=
 =?utf-8?B?cllZVHAxKzZJcngwK0FEUzYzUGJUc2ZsWHNwNE9IN0UzcE1OTm9XdEpWeW9l?=
 =?utf-8?B?aGZucU11anFObzFQSEIwQ2ZRdmtoSFpUdjVmOXg1RU1Pb2pnNnlGYU8vajQx?=
 =?utf-8?B?VSs0b0prWU5NS1FZN3NqcE1MSHJmUmRnbDBKQW9WaFUwN3ZaclM0MEkwZEVG?=
 =?utf-8?B?ekh2S0hnZ3dEYVdvdzI3NVc4SHo0RFIyME5YSkw0d0dta2laN2NRRlo1dEtR?=
 =?utf-8?B?QkE0MEtGb1JKT0FJeDduK2lObkprTFEyTUxkNksyU0tzVTF3S2JoSXIwTkd2?=
 =?utf-8?B?bTRoN2hYNGNKN0YxVThKUkZLMGRxQVAvVVFBeE43bXVUSVhRWnhDSGc2Znc1?=
 =?utf-8?B?Tk5oQnZyMnQ4eWUzTTZrcDE3aFdtNnkyQzh6ZTlUVWxnL3Y1NmZsTjROY2Ra?=
 =?utf-8?B?bkJVVUdGTi9rTytwOUZLUHF0NjFwdmVlL2JZVVRCUWNrOHZURHZXK0l6cnQ2?=
 =?utf-8?B?cVVLUUNPam1UY09PQUZPNE1qbUJJcUpVWHFFbHA2aXJXYXNma3FBaUVyZUFt?=
 =?utf-8?B?U2VldFU2QTFqQjRCTlJXdlBXTFBiUTA0V0dyVUhqbjUyNnkvUXl6UlFkYzAz?=
 =?utf-8?B?STVySlJSa095RWFMMk0xNnlCci9veURGb0JzQ3RiR1dLZ2Z1cC90TXg1VFdQ?=
 =?utf-8?B?ZmhQS0ZMT2dmSXNDM2dnNmpZcVZFYU1qQ3pHYW9ERXFEbmhpVnI3MzFicnE2?=
 =?utf-8?B?eS9Ud3ZzRklaUlVnWVFuNm5LNytuMDZ0b0tiN3NHQU9INWUvbUxmbWJEM01V?=
 =?utf-8?B?WWYwdUFRRnpxVVByVGFUVDg0YkpqUjRIdTVadFVRZk5SbzUyaG0vMWVGWmVn?=
 =?utf-8?B?TE1XcE1SS1pLdHhkWTR2eTBkenp3QWdZT3VMMlNOL3FIS1pMYWphdHJiOGxI?=
 =?utf-8?B?Q3ZxenZMZXF5WTgrL3dzRGtQVGMxR2JFMWFmNGpRTVRmVHovZkVaSFp5SVl0?=
 =?utf-8?B?UUNrQ1k1WVlYVk12bnAvQkY3Tko3c2ZiZWJZVHdiQXV2UTJPMTdyUnl6UVRo?=
 =?utf-8?B?VE8zTVZuZDRzUzQ5M0RCZXFnODRnc3h6L0NxZkNxOGRrT2R2TlNLUlFpR1Nx?=
 =?utf-8?B?MmVhVGp5S1k0c3NlTUR0c1BEd0ExWDVlWklsU3cwNGk3UmU0WTJubWZSSUFM?=
 =?utf-8?B?YWVhQXhhQmd0QmI5ZkRPalBFalNtZFVYUHR3K1RGRzlDZGZock5BdW1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpTSnFjVnJrbUpRblgwaCt4NEJIM2d4OVBzRUtBZjBqMmhGSHlrcVVkUFli?=
 =?utf-8?B?L3ZiQ2E3T2ZzcDliM3lES0tGOTRORzJqOG10cVMyODN6WUtSbEgrNFJXbUVE?=
 =?utf-8?B?YytKeEpWV1crMk96TkVESlU3Z0J5dTNnemR1ZnArRTU4UW14cVgrd0lBNm80?=
 =?utf-8?B?T3UwamFXamxXRUhXL0p5UUJWb2NXcllJZk1qU2hITUk1TWREbUVHSlU2N2RX?=
 =?utf-8?B?TmNuYVVqcmpPN0VFdXRZMi9aNGcwVC9yc0tpK0JIVjFxaHJiUTdKeGdVOHho?=
 =?utf-8?B?Q2RvVWZEUzJZZGw0OEtaVDdDUFFZamJkOXYvYlFWaWhmejdKYUg2UlgrOWlh?=
 =?utf-8?B?VUVlTWw5c3k1VW5FaWNKLzRDSWM4QnY4S1lEdnFIbVJxckZDeWpoYW9UREdY?=
 =?utf-8?B?RHJyTWlJTXBZTU1yVEE1VzRLQVN0bHJYSXJ0U241djBnQzc3Qkk5b0VLaWxP?=
 =?utf-8?B?T0MxUWNlWTFpSml3N3BVYVp4cURoOTgwWXU2aVBJTExFdmtYWEYzTTZsOExF?=
 =?utf-8?B?ME9rRHQweEttZSs2UWdxWW1PazUzenBpQlQwVDJrMUZGdk40RXR6amVvZFJP?=
 =?utf-8?B?a3pkTlJaZ2ROVWdxa2puQjVscXpHTWk3aGUya3BncmpLL2pha0ZQUjJiWmM0?=
 =?utf-8?B?Rk9oUFpFNW5zM0xiY1dnRTNJUFFybHJiZ0djZkFkWDY3R01ZRDVVTzN6ZERI?=
 =?utf-8?B?RE1lM3pDN1BwZFR0Q2wyREl4dUlMVW9BMU5INElockJLVW0rOVk3eUd0MjNk?=
 =?utf-8?B?bmV1VzJQVGs1R0NOYUx5K0tYazlZc255eVFlNWh0R0UyWW43emQzZ2E2cjB4?=
 =?utf-8?B?UktnTlpoY3VoZk1Ubm9EUDNyRElWVzYyV240MkFOL0J3eVJ5amJDNjhmc1du?=
 =?utf-8?B?RW9HUEk0bzF2MWVqMS8zNTFIblRnTkhxUzBhQTVaVmRLWDZOUlkwSEVQYW9S?=
 =?utf-8?B?MEN0d29IVkdxd3ZrMXI5NTVuVW5PVUxFUE1hT2NxaHQvK1BESWRCT3NTcTln?=
 =?utf-8?B?aWp4Q1ZhUi9YWnNGODQ5cG05R1h2NlZzT1JteTY0WTR4Z1ZtMFNoZVR1cm02?=
 =?utf-8?B?QlM4TEJyazcybmM0UFZ6YkVBbFJLS0Y3NUdVUVYwRDFNMG5UcHY3ejVvTU9m?=
 =?utf-8?B?SFhrZy9TaEFBWFVhMFZUUFFTRFBNTTBaNXgxUHlyS1diSUgxSHl4cEp2dXRF?=
 =?utf-8?B?ZGd4NDE5ZkZ1ZDdoeTdwdFluZDl4ZDZ3ZEE3ZHN3MHcwaHlvS2pMcW1CM1NY?=
 =?utf-8?B?QTUxeDZqUk1ENWRzQ05FaUovZ3cvN0NXd3RxeVdqTUs3Q2s5YUcrTEFFL2lU?=
 =?utf-8?B?bXBwaVpuWHBTVVZJWFZxN3U1NU9SREw4QkRIdzQrQWpEd2NPSnQ3NnJsVUND?=
 =?utf-8?B?RXBDOXJaeTRrYlYzOUlDK2srWnZOcDkzdENBOHR4aFNpWFlwOFQyY1J1eTdQ?=
 =?utf-8?B?OXdmRGltK0lFQ0IrRXpONVIrazBlMnR6K3VGZHBrRFhKSGk3VkxQRzVGSEdo?=
 =?utf-8?B?OWp3dzh5WXg2ZTdyNGF5SC9XbndQYzhsTGg0dzR0MVFVVGNyMHZUZmxvNVhN?=
 =?utf-8?B?VERLNVlrYXR2cmVQZ3NFamRLRmFES2I0U0JPQkw4UjV4S2tLSnMwZzBYNXBp?=
 =?utf-8?B?aFZkSHhqQXo0aDhQSGxhRXRheFE2N2RoVDk4OWVyTDNJVjRtU3hFMndpMDRY?=
 =?utf-8?B?RzFHK01wQWJVNDhWK0ZsMERST09QcmFraVFEOVFIOUgvTzFDWUI1L0ZaWTNo?=
 =?utf-8?B?cmk2dkFObWtJREdDRlEzR3hFR3ZuM1FzeHBLbFdsSEsvUUxzb210TGxUWVpn?=
 =?utf-8?B?RkgyQVhJYWRSb0ZsTVFZTW5BZFRjTzZPSktXQXZReXFzeUpZK3JTdFdreXU3?=
 =?utf-8?B?ZWpxVC9nYnI5b0V5YkhaY3pEcGxUbkQ3ZExOcWlvRk5xZ1pvNzNRa0ZjZStw?=
 =?utf-8?B?cktIV2R2YUx3aXR5a09LODJSVjBtZ2x0ckt2RkRkNnhhckJXekY3MHMwam9p?=
 =?utf-8?B?eXBHdkVMem1rY0ttR2U2SG53bkE0V1dsYXBMbkpOMFM1bFl5N2xnTVdidWxp?=
 =?utf-8?B?THNJV3JKM3NlOXczK2xpSWg0VE1kdVpNTVlHZkdjcm8wbHRTRlc3Wk82Mkln?=
 =?utf-8?Q?0a2bmL6Q6Azgcyfem8vgkAlTp?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644ce4ab-9e36-452d-f6a6-08dc6921d392
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:28:38.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xs+6wjuG+oDXxrvDUlkezD2vI0EyiuxB8xHYJV2knM1BCmJ6CVZ0nSEA9QHa64oGOp2HhIjlqmNOBDCyYifkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1959
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28354.000
X-TMASE-Result: 10--13.102000-4.000000
X-TMASE-MatchedRID: QW5G6BKkLTr5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xK9i+/f9tLGGyPj
	9n/DKfQIR2SJBIMoqANMBtAOhKz7spvGzjmeO/QLP7JT059tUTvn0oaU6WM+++U0ANNKseCVvWs
	BZfxfbYlxQ+QoUzBMF+UTedInjF4zM8VWyP3FqfO83kKlGsoOiFaMDW2nugceh9DDCOZ7gK0z2U
	hhZjlNJafX4ijYpdRYYE2JmjftAnvmmI2C8I2JgW/QdGuFxf9P2j7jyCKpnCf6eDrkstFBca+eC
	SMeOiOkrlXFGRYMxXAQDizRnrt93ag7Zo5UOBRpoli4ZoiOHT9+ICquNi0WJA8eUGm91JFlJzbj
	nWwC/bKcmUHovysLpGbFYssB56k0ftwZ3X11IV0=
X-TMASE-XGENCLOUD: bbe51b80-dfdb-449c-ad03-d4479bc5baf4-0-0-200-0
X-TM-Deliver-Signature: 1A6FEF005D4A8057F4BC70613AA029AA
X-TM-Addin-Auth: G5Yvx+HgrVi5KCEMnhzyBqCWpEaSkOv8v98lLQVCSe1X/xXa6U28tdUOx4A
	xspT3CsWxhJKvzQn4Whlqu78snorkuYji0NfwOTYIluwIiI8/X94sjUMynCwslGMahCn+NWic/R
	dTwqjecwUFw2c17aZFox+wprda4AvcsGieY0E6KZ8HGNREa1M7bd9d9+ZqFlnEC5W7mxVWjiIgB
	dt0H13agMKpAumZwYj1aS1dnl0/DBr/DUYmFqHpF28hhM5npH4G20vu6WVs/nTbskobiDG4QjsC
	OmZ0DqYZF9utbPk=.CxREsutr80ggfHtCsUM3MLNcO0KaN8mkgtc+Cym1UXGr2PHXsaKILwQijC
	Xunkr65xLRUMMH/1WdDAWoCuw9qAzRtmKnbY2PiLSYDFr6khOtgOwU+xbxn7stcbToLcX98xPtq
	LbdwYIxbJjdhopmvVCiie72gwuac2hi81bvie7ufJEtvHFCYFQbo1G+OqkD73k6Uv3yCT53QRf4
	DSnpSwFCZ5/V8IcCgH4vGE4VGTDdzcs3BJlHhxnKShzPqsZ/culOAb8onO71mzqxjWsEibpxdz9
	8aSWx12ZYVxcZbglF27c7JV5bm7sIMitVEbk9CqKfaV862FU2AXgyLwns1Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1714487321;
	bh=rllGFwWZrs3mEoxDiptTG//X9xRfzyDt8iz7cLIeBUw=; l=3325;
	h=Date:From:To;
	b=DRVl+YGznT6SWLFBbUj5HU51BMUtRLsziHYq7rxCN1RRMyk9H8bRXWq3TiVp764fS
	 JKNNhJ44o1q4pSytyCQYJa5KoLVNkwC1NkexI7YZEGN0eek343zSBwcgMUIFFOUsmy
	 b+sK/iEcrRDozrYsRb/ejC9zoaZJpUZZAZZSzV+SXMCOhFHanDx4COKDbU0bX1+ktT
	 qa11IHN3PKVYsfWmJvjpAB5DHXj1/BmFwom0UxFyBmhwxfmJp3A6f9YU5yHzeEcKKY
	 WQ8WR64rf+0OYhrKQwIfU/OyhSFdl8UbS0tJ9VrXs+70tInZrngtY5FNw8ajDvo3AZ
	 hIXS28iOHPw2A==

On 30.04.24 10:52, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add base clock hardware abstraction in clocksource structure.
> 
> Provide generic functionality in convert_base_to_cs() to convert base
> clock timestamps to system clocksource without requiring architecture
> specific parameters.
> 
> This is intended to replace convert_art_to_tsc() and
> convert_art_ns_to_tsc() functions which are specific to convert ART
> (Always Running Timer) time to the corresponding TSC value.
> 
> Add the infrastructure in get_device_system_crosststamp().
> 
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  include/linux/clocksource.h | 27 +++++++++++++++++++++++++
>  include/linux/timekeeping.h |  2 ++
>  kernel/time/timekeeping.c   | 39 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
[...]
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index b58dffc58a8f..4e5e931e766a 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1193,6 +1193,42 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
>  	return false;
>  }
>  
> +static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
> +{
> +	u64 rem, res;
> +
> +	if (!numerator || !denominator)
> +		return false;
> +
> +	res = div64_u64_rem(*val, denominator, &rem) * numerator;
> +	*val = res + div_u64(rem * numerator, denominator);
> +	return true;
> +}
> +
> +static bool convert_base_to_cs(struct system_counterval_t *scv)
> +{
> +	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
> +	struct clocksource_base *base = cs->base;
> +	u32 num, den;
> +
> +	/* The timestamp was taken from the time keeper clock source */
> +	if (cs->id == scv->cs_id)
> +		return true;
> +
> +	/* Check whether cs_id matches the base clock */
> +	if (!base || base->id != scv->cs_id)
> +		return false;
> +
> +	num = scv->use_nsecs ? cs->freq_khz : base->numerator;
> +	den = scv->use_nsecs ? USEC_PER_SEC : base->denominator;
> +
> +	if (!convert_clock(&scv->cycles, num, den))
> +		return false;
> +
> +	scv->cycles += base->offset;
> +	return true;
> +}
> +
>  /**
>   * get_device_system_crosststamp - Synchronously capture system/device timestamp
>   * @get_time_fn:	Callback to get simultaneous device time and
> @@ -1238,8 +1274,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
>  		 * system counter value is the same as for the currently
>  		 * installed timekeeper clocksource
>  		 */
> -		if (system_counterval.cs_id == CSID_GENERIC ||
> -		    tk->tkr_mono.clock->id != system_counterval.cs_id)
> +		if (!convert_base_to_cs(&system_counterval))
>  			return -ENODEV;

AFAIU the error condition

	system_counterval.cs_id == CSID_GENERIC

is silently dropped by this patch, but shouldn't be. 

get_device_system_crosststamp() can only check the identity of a
clocksource (base) for non-generic ids.

Regards,

Peter

