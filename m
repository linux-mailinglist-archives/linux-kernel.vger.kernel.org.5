Return-Path: <linux-kernel+bounces-86793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A986CAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB58B238BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0912E1FD;
	Thu, 29 Feb 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="ZFDcqI9v"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680218627D;
	Thu, 29 Feb 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215237; cv=fail; b=KoEkbXsCS6SRLPaBELWM9hvm6uveIKGmT1ImggH90EOWVvHVOR07OnBxCTRAi+McPRlLZHxfCfQ4lfNS+nB4dWTKB/h1dDg8JA+YQA8K9W3duxgQ6LfoatgX3Kfdzd4gbf703URxH/jgFdeWsR9Qo+uMVLmMUCTFFQYwf1QXGog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215237; c=relaxed/simple;
	bh=kW9X6XDV0nH9r+vO0PYEtWiMJDRi2UEjnDVGlr44IjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QXE8+ZJQbKtWYJyq+yTWTmVwqKPb6UnQJclyvnisjymMzN6HyqbMPyx3TEnQg7qqigYorqqAaDB+cm0xOdY1XeQaKLPianBV4BFhv/1HVCgy/c2VtGik9zyob5UtHHP0AqADqloZKIt8PH+guxkMtuFiVb9PwT9P7PdPdHT7aZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=ZFDcqI9v; arc=fail smtp.client-ip=18.185.115.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7A04D1000204D;
	Thu, 29 Feb 2024 14:00:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709215227.051000
X-TM-MAIL-UUID: 28417ad8-535a-42f7-aaff-9d82211e6286
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0CBAF10000E25;
	Thu, 29 Feb 2024 14:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEVdImVceopAYGmNn37XBW+kXMs8x3yfTmEB++IsBrJQiiw6XQZLs+A/gUYIf9iKaC8NO3EQOo3XD6UYSuH+Bc+KVGHpYT3hifTZp0RTEwQIBtOhBHJnCj8rdTraHYoxZjrKhFtERSnY9WaICg3SwfmEIMXmTqHh5Qve47kg5Qve4hA4IB66d/SxFL7VAyqkfWHawxz4/RkoBs3EHsaf2mM6dtUkgXRuJIlEirUmxud+ARLjfsctcSzbPjajy2iuok7JxWFHDyU56HHnTN0v2+VASmaiusF/CHKvgvfq5vK2geukAcvhjKMFqLGZkyzsAvzR6Je7N9jkBdDgRHfF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5fha9EKPb4DRR82LP2GhVEInRkV71QwQj+kaJO15i0=;
 b=T6AhCzOtiMO4nDiDI8QALyNh3L/M2nD622ylzEC99LfGKJ9rgsWOy/3qHS/94qzfnFqmdYvnEqWTSLe/5C2lmXs8lwhI8NdvGB2P6/VzUtZdlybnBWCSjbirNPMccLMjKg7InayqwDL/o4zXOa9uuk2uFCQ8luIViOlPym99SkwBXJE2av1JBGboKsEju19+s4DqKGGVxCIIQy0alIN+e0tIHd7wpbQIlzt7IRROGjEDa5PTLu1WflCj4eF8zRCV4cAkkJ7v/qwWjWeVUoWgvwJgAcZmYAabWams+80SPoXHhX6e3bqS8RRn4jTp+9gUXZFkulZs8mlZaS+pPMxCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <992c3573-f87c-447c-b8d7-d3bb29b0c5f0@opensynergy.com>
Date: Thu, 29 Feb 2024 15:00:21 +0100
Subject: Re: [PATCH v1 3/3] virtio-spi: Add virtio SPI driver.
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
 Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
 <20240228142755.4061-4-Harald.Mommer@opensynergy.com>
 <20240229082224.2kh2scyjpielwx7v@vireshk-i7>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20240229082224.2kh2scyjpielwx7v@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BE1P281MB2514:EE_
X-MS-Office365-Filtering-Correlation-Id: 003f028f-fd49-40a1-fa77-08dc392ec62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	syIGBwMXUedCpGUPfjITci3ZztoOwg3zI8lNMk0gQ7BBMiTX1C/ipzs4gXAaf6GpyIFfothk/FVO4RmQ1O+TesjQRkZor0Ke5wG+HVGLgot2pRPaS7wzWztVBAnLJfwNMpLTc1sq09CLeaxOySB3+5ioaj9TlJd6LQ2AJIoVIZBPCAjS4Y/MQIFEch5MuppksLkl9hfkr8ZWuTOQANlV90SkgskxrPS4iz5VnJbitpYrXfRbjlsfpGngelZmH0pXSrc9PoO8Zem5umg2x9j3UTiH6RYtdeKmBrmgg7j3fy0gnUQxZumXBU/sg4czMnDffUYidGdtPOw8tcfxMkUq751HB2m+jtgwWRImwgtk6QO6ZhuYuyJmXZm4pF4TFFLrema2BClaxIcJAh90xVwpUI87a8DLlj5kauuQ25RtGHGAVSxAVuU6kUFIo7YA5rhBhsV+fzMu15/WCdhB+39qnLjQphhZGHP5UwjNfuAtGwGlbI6VSp5B0YB689PTtbgvdKFm5aVprPUQYBE5/fwn9CBxdmL8J99O3R9FyRBVhetWq/obMQiNza2kodzzHVgXurE3/rjKfHLaNzMci5L32+DV0dPIiiYD0xVvqVrJqHpYXGyubWWHcFfWhILli3eO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFV4bzZFZ3dXdTBnNGRXWWdPUDc4ZmI4YVo0cTBHK3FVR3k2MU5jNEZoTnBy?=
 =?utf-8?B?UHVOMDBxbldrT2ViWVVJcDBUc2dVRzQwQlF2Rkl4RkRXcUlKVTI1N2RVcXFX?=
 =?utf-8?B?MHdIdGtncDg3Vm5iMFYzd3AxZTdHc2RGUVdKRGIwNGNSbUFUQkVCSmpWSUxS?=
 =?utf-8?B?YkNvckdyeFJDVDBQZkVubXI3ZlkyRFAydnBZdytQZ2g1SktSZkdad3BWdWMz?=
 =?utf-8?B?UFNNQ24yakEvQzg1WVUwbGNKQ1ZsTUdOekZDbEZKaGN6L3VGTk9ZL0pUVTVq?=
 =?utf-8?B?emw5a1BJazBsQ1N5enFZeXh2Nm93UHIzaWFBOTJNK3dZWEVMVzJsazE0Mk5B?=
 =?utf-8?B?YjFwYlEycy9tVHlLMlhkSTdlRG1mSXNGc3hyM2VNSVVMbVdpZFRZOEh3QllW?=
 =?utf-8?B?NHVrS1oyeWwvSEpLaGs1QVJ0dlFYaXUrZ0pEUzN3TnBaNTdzUHQ4aGx1ZzRC?=
 =?utf-8?B?bjA1dGhDaEMwRVNTMjBlVzdHa3hpYjBWY014VXNkdm1CQVdzS0lralZ5OHI0?=
 =?utf-8?B?SldvUWxpSG44Z0k1NkRhTDRVKzNwQy9FRW8xbUpqK1hGbWNoLytKbmZ2WGJj?=
 =?utf-8?B?WXRoRmZVdkVDd1NOd2czc01Eazllb2o0UHBpQ0daM29DNkg2dFlyNGNiWUpJ?=
 =?utf-8?B?ejdjRWZoeHpWK245aHh4R3dEaGxrVjF2bVd4YkMydmlNNTU3c0huYWZKdTRq?=
 =?utf-8?B?WVZMOG9Kd3kyNGQ3TGtKbGs0enZEOXBWNGhHVmV3WWo3S1dlT3BYazFSa0dt?=
 =?utf-8?B?ZmJtT1oyK3BuTUxUaEIvLzZWSkRxdTRVVGtiVEM1TUk1K2VTOG83YUhucFB1?=
 =?utf-8?B?eHkrdUFPem1HUWFMMUs3OHlIVzJuYXhlc1NIU2JVYU5sR0xjWTlVdHBLV3M3?=
 =?utf-8?B?ZVNtR2hPZHpUSVQyTDliSDMvYkZCQ3diblExMG1DTG1SM25ROTAwU0s5ODVF?=
 =?utf-8?B?QUl4VFg3Z25HWUI4V3daWVNoT1RlNjBvZVUxb0hrbWRNOUF0OVplK0k3Uktl?=
 =?utf-8?B?d3hoWW9rQ1dOZ1ZNSVQ1MEZGWjB6U0JUVFNxcmR5aEQrck94RTI1ZFRMbUxh?=
 =?utf-8?B?cng4WHkvd3YyVW1UQy9paUNXR0doU2lwMkY4WXBvVnkwbWFGckRmUGdvNktY?=
 =?utf-8?B?VHF4OFJzUm1CWFNKWXc1K1VHK3EzemU1SSs2REw3cXdMMVlqZkN1UDA2N0VH?=
 =?utf-8?B?b2pHYUNpQUlaL2tjZWpuVTN3WWhGei9JTzVKQ1BsVjlBTXBHdWpHZ0FOMGcw?=
 =?utf-8?B?Q253bFZGbFZvVDlSVzVoTEJjZ0Vwb2FORXgvRWVPaVpoWFZYTTVvamhReDlr?=
 =?utf-8?B?aDJuZEVHUy9PK3BYdHgzOW9OYVFwMDVpL1UwZHNKUzVicFRhaFN5Rjc4dFBZ?=
 =?utf-8?B?eE1Mc3JwNmtQV3NWRnRwMFNyb0RUZmpBK3FOV1BiOHlHVHN6VU56ZzhwQ0J5?=
 =?utf-8?B?NzkwYm5ZdWZzbElRdFNMV1ZwUzlUNnZlbnd6WkhqRStsMCtwTVIvMWZhOS9y?=
 =?utf-8?B?QUoyV1dKbnJ6TThPTnNxZE1qSEtWbEwra3NXMmdrTUdNVWlQTWVEK1g2Tno0?=
 =?utf-8?B?MjdRTG5LT1U1TFZCQ3BLOFdKK1FDSTdjZ0ZGNldESzFFaVNxZDdLektIbmVK?=
 =?utf-8?B?bWM3RmpqbUJjaXBId2czZmo0Uy9GanFOMjlocUlVcFdkNnoxRmJXS2YyYTBs?=
 =?utf-8?B?blNRelJkcEQ5eVZYOG9GcGhyYndPRmdtZWFGSE5oUThydTZGdDJtYklLSG8z?=
 =?utf-8?B?RVZGUWNCdWhiV25EWUdpYmRkWEpuNUphQldXdjF2SlpJTndWQjE4NWhScUJx?=
 =?utf-8?B?Vmx2L1NTMDd6ZDB6b0d1RU1xbXQ5aFk4Vmt3aHR6UDNIUExYbkxGd3BCUXkw?=
 =?utf-8?B?YjhmWkVZaU1acW5leXNpQ08xYzRia0gyOHJFZjl0MnZaRnBBa0Q0c0pXMlI3?=
 =?utf-8?B?SWlSb1diWUNxbDV6RU9rek9nM01RemVIeG82c0xQRVpOWWRyRWpnQmlUS1lK?=
 =?utf-8?B?U2xZNFlQTjNmbHJWTVNrZkNsZzl0dUF6ZWNSVVoyQVJNTzBSUHE1U28xRGo0?=
 =?utf-8?B?bXFBSEYyL3h2RklnbVo4eEF4VWtNNGVpR3FPSTN1a1BQWm9VVHNiOHU1bTBu?=
 =?utf-8?Q?ZcCpkTkB+d/BEBOi9QHUmElsj?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003f028f-fd49-40a1-fa77-08dc392ec62b
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:00:24.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bTPQnyu5KHbYLqnxwN0ALBWAhSLG77zzriqwZQcRbTgfHiaBS2+hBGZAQgTSqaDF094ww0obCXiQ5ioNCWELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2514
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28222.001
X-TMASE-Result: 10--12.253100-4.000000
X-TMASE-MatchedRID: gzVbiXtWD9v5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xLqebRiaUxsfoXV
	eAzWzPHrLfgCWmpP5eM0D7ajn/07DLMYfD3MHldbsX4aFYAMIYMUj2a787oL4M5XQRbjRW4CUk2
	exuG3+KhNi6yVot11xAkMI4NypaQrOcofGC8sr9470BtMXRaQwhWhK9n3L3nu4r1+OqI5EVylQY
	EJ026DTyFGe20yyE/YIJV4xGzpWxVnoo1oYxaDbjakEkBtr136cl04K9ffdkmZtwBUcPZK1u1xQ
	wyw61Rv290JqglW7rRmXN8BhN6Pgbbf6Wd0MJvo+DE5zr5ahdy+UXZnp3CKAIuVG0d8rk2ToBsr
	bVwe9zqCMzVIrqrlxmTrXJp3VogEqCSeJKqSmf5zoxCmHXb7+kTrh3TFw9fFl2KBmLXt0epdepT
	/WVsxv79vAEPEGgb3bcGwqh63LX/socQd7WY5yEI9AEPfED/dqvJX/aNGr9cSCDdzAMeX/Wp2VX
	UuZsR8A/lH/MvdoiZkzeNs4Fp1DTnxJqun3snzbkV4e2xSge5LTPoT993fI8i5XlcsPyP5SLsj7
	MsUOLSy7SXwkuF1vV8I4oUq5Vga
X-TMASE-XGENCLOUD: 27ec76b1-01fd-4a1e-8a95-73feae22c57b-0-0-200-0
X-TM-Deliver-Signature: CB0B4F017EE904CDAEB2C672EBB637D4
X-TM-Addin-Auth: ooVCJAJjQ32ijFXLrZejrs0OoUx1zVx7hx4ck7JRC69BsIr7cJyuuMIyU1A
	0QS9cel8q5m+4wwMERK/f6aS+VEO4ddTVsepWRFCrTJNa3KT5k3zRy06Wrcn6z7MYssOq10T+Mj
	K8nbT1i4IBuGdAT46VqVgVz+T8coMazlNDq//F7Y6ReoIpVDRt3ytBa+liCTkxVFRMWSdy+VKVm
	C8MyawJTVrGIzXdl0825WWDQFcCPz8hqDP03SiTtYwflmScSoPoTXESknK8Zn5AMoKxn0sYSprH
	zDo/R/XzMv4YD0I=.npJFFUNg+scJye08jXY/+Jt5OfyESvHmFDwBI4nnBLkRW1nhlgbGLWOmkq
	1RswjxXLoUC0ZR1ut1CWvagDTUuk/5FYegSi5BoTOmGfdgYMS133bCrXLag8h4oKgHbM9QdLRWl
	VAc+Vdf/WqLGg5LzaryeQ7eYsEaSqtcm1dVPIOM+v6sJw4jcir4mDZR0FBlSjfzBT2LaXAifoCp
	Ev2RpgsXWe5QbAOTAQ6d0O0Tbbxsz5DdxfxNH017al5YyIpG4R+ZJXXpp6L5hNFh/Ba8oF6skVz
	Xna5sBn7hdpz13yxNv8Ts2efQGKrhCvkkaBytpk6i5g2Ucdcxk267TKDRBA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709215227;
	bh=kW9X6XDV0nH9r+vO0PYEtWiMJDRi2UEjnDVGlr44IjQ=; l=5550;
	h=Date:To:From;
	b=ZFDcqI9vu4EuXSDUiFC9qqzLpt4NYquxxyR0Z3XWmSMbcRtd6pieiXLIlU8fRAXpC
	 IjygGUnr2cIkt9KuFRMsC9DDHtkm3oeSACrVaetUXxviJoeLUayWZ9N/zwJz3DUCbT
	 9NPeda3qosHuWcGPDnvYhDrZZ+erlMhKLdHxV5ppEgZApThN/RoDK7SYsXkHS3vyWK
	 29dE/JURgdXepKTOu7wcPOQ0+2inMrhjOKfpVkbpuGaf0AyAzdjFDalhcl2xkhrus/
	 2ANfvQuL+SqGIlRBQsKMJlLmv5i7LJxhJQYfn4oK+RyuDpvWvUGa7Pu70FibZJrfnS
	 Cz0qqn2oOgFmg==

On 29.02.24 09:22, Viresh Kumar wrote:
> On 28-02-24, 15:27, Harald Mommer wrote:
>> +static int virtio_spi_probe(struct virtio_device *vdev)
>> +{
>> +	struct device_node *np = vdev->dev.parent->of_node;
>> +	struct virtio_spi_priv *priv;
>> +	struct spi_controller *ctrl;
>> +	int err;
>> +	u32 bus_num;
>> +	u16 csi;
>> +
>> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
>> +	if (!ctrl) {
>> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
>> +			__func__);
> The print can be dropped I guess.


Looked around: It is habit not to do here dev_err() here so the 
dev_err() is to be removed.

For curiosity I searched through the kernel whether the kernel already 
leaves a trace the way down the memory allocation but somehow I landed 
in the forest. Not important.


>> +		return -ENOMEM;
>> +	}
>> +
>> +	priv = spi_controller_get_devdata(ctrl);
>> +	priv->vdev = vdev;
>> +	vdev->priv = priv;
>> +	dev_set_drvdata(&vdev->dev, ctrl);
>> +
>> +	init_completion(&priv->spi_req.completion);
>> +
>> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
>> +	if (!err && bus_num <= S16_MAX)
>> +		ctrl->bus_num = (s16)bus_num;
>> +
>> +	virtio_spi_read_config(vdev);
>> +
>> +	/* Method to do a single SPI transfer */
> The comments for obvious statements are normally not required. There
> are a couple of them here.


Removing now a few really obvious comments. This "code speaks for 
itself" sitting in front of a mostly uncommented code desert is not mine 
so I'm careful with this.


>
>> +	ctrl->transfer_one = virtio_spi_transfer_one;
>> +
>> +	/* Initialize virtqueues */
>> +	err = virtio_spi_find_vqs(priv);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> Maybe "Failed to" instead of "Cannot" ?


I grepped through the kernel for '"Cannot ' which brings all the 
messages in the kernel which start with "Cannot ": 4123 matches (case 
insensitive).

Did the same with `"Failed to ' which brings all the messages in the 
kernel which start with "Failed to ": 34746 matches (case insensitive).

Majority uses "Failed to " but "Cannot " is also used. Both wordings 
seem to be acceptable.

So this is no finding and I keep the code as it is. Otherwise we must 
look again not only here but also in all other messages especially in 
virtio_spi_set_delays() reworking more (for no good reason).

My wording in virtio_spi_restore() is more unusual, "problem ". Only 111 
matches.

It's not wrong, it's not broken, nobody complained now, we will see.

>> +		return err;
>> +	}
>> +
>> +	err = spi_register_controller(ctrl);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot register controller\n");
>> +		goto err_return;
>> +	}
>> +
>> +	board_info.max_speed_hz = priv->max_freq_hz;
>> +	/* spi_new_device() currently does not use bus_num but better set it */
>> +	board_info.bus_num = (u16)ctrl->bus_num;
>> +
>> +	/* Add chip selects to controller */
>> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
>> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
>> +		board_info.chip_select = csi;
> Maybe a blank line here.
>
>> +		/* TODO: Discuss setting of board_info.mode */
>> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
>> +			board_info.mode = SPI_MODE_0;
>> +		else
>> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
> and here to improve readability.


Yes, code desert without blank lines here.

And while we are here and nobody wanted to discuss: The TODO comment is 
to be removed now. In the meantime I'm convinced the code below is what 
really should be done here.

>> +		if (!spi_new_device(ctrl, &board_info)) {
>> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>> +			spi_unregister_controller(ctrl);
>> +			err = -ENODEV;
>> +			goto err_return;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_return:
>> +	vdev->config->del_vqs(vdev);
>> +	return err;
>> +}
>> +
>> +static void virtio_spi_remove(struct virtio_device *vdev)
>> +{
>> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
>> +
>> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */
> Not sure if this comment is required or not, since we don't add
> similar ones while registering.


I got once from you a review comment about the de-initialization order. 
Now the order is as it should be. This comment is needed to remind me 
(and others) of the desired de-initialization order in case someone has 
the idea to replace spi_register_controller() by 
devm_spi_register_controller() in virtio_spi_probe(). By such a change 
also the spi_unregister_controller() here would be removed and this 
would change the de-initialization back to the undesired order.

Now there is the comment above the line being removed asking "Have you 
thought about this?".

I was already reworking to devm_spi_register_controller() when I 
realized late the undesired side effect and rolled back. Better we keep 
this comment.


>> +	spi_unregister_controller(ctrl);
>> +	virtio_spi_del_vq(vdev);
>> +}
> Other than that.
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>
No real code changes. Some comments to be removed, some blank lines to 
be added, nothing urgent even in case the driver is integrated now 
locally by someone for some need. No re-test will be needed. Let's see 
what comes in addition. This is for next week, by than also the 
maintenance of the virtio mailing lists will have been done.


