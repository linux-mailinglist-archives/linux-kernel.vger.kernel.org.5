Return-Path: <linux-kernel+bounces-118867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DAB88C072
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C2BB24FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7A482EB;
	Tue, 26 Mar 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="U/UfK66i"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4D548F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451960; cv=fail; b=BCSDHC9OIDY3xHq9upL4ZfAvE/9eSdaBxpCA1DcM7bHV0EpWUqy1MMVoHKh0AgNdMEfGsAwoiDOQk+nT4f25zZIuHAzuMbVPXIpA2r3m4LRcyhJqHnwdmXEhfcp6oTiIjVKuWs9sn8oJLCJDZ+LIUTLYDVOPRwHI/u1JI/dlvk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451960; c=relaxed/simple;
	bh=unvlpPNbGLpXmsCJNtgGIa9l1RRZQsC1875UeDDl4+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cp4yGGyWoX1RN5RVKTS/dhyHRqNmU9phHcqFqBRPJQ+CRFa60dX8PvW/4gj+yXIG07TJ1zWmnMR9L6jv/3EYluDSHSzWlTY/kczI7Nr7IGm9Vg5RjEmhhBnNpZBymVF2B3E51rDiI0bCZPo+eO6VOiOhN4XN7MH2cwdkqwfWRhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=U/UfK66i; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.192.213])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 0810F10000D19;
	Tue, 26 Mar 2024 11:19:11 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1711451950.558000
X-TM-MAIL-UUID: 2f32bc48-c390-4c4f-81e5-2e1800d465c8
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 8880D10047577;
	Tue, 26 Mar 2024 11:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nni/HSp3ycnYGcfwiK+bAehRSWob0H56rkPmn3YoGjstjJAzQmD8PA1SppHF1M65GROWnTbZLngan2imND5xI7B31E1Nu3HtI+kQKCk7xq6oftNusDR8Y1O0LkdplqbXU8i930c8ixlweHby0McIUN+IZ0qOV02tGG54dP85zBZ2yRilLVqYiIzc/IXhvWJOyNlAFwBYUP64b4f53m95+qKElCBZOrDt7Ix23ZFggI1VJ3/4G20xANhhsXauvpQl6ptBx+zL8vGDhaDuyzCv5Y6xgniq3wLFFlss3rkbYaYT/SaWxdnYx2dQ6D/B96/tsxx0tG30Eov/sTxqGDezQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1MOSNsqL8zR4zn/SiUqQk/kz6H16d1Do312RId8rsM=;
 b=P5mQ6AXN61QQxzH0D4IN0pG6PbyvB3TyyPsqvRUjP9YQCZKIt/1Lc9GmEQGTRhI4ZctyydjxmGcFC18tqqzgr8KPEbBqx9+3/CZnXz7bFj9CK71borPWtP4aWoICrOUsvX06E0HVzEYr/P+XLNlcUCI+9Hvz0u0S3A+VaLTu0gv3HTKUY4YvaBv2C5zSh0rKhBc/RaONP3CMCsSYFew4kJxBAhApNlYVwTN3hoYUR3tjIQ8O5pxsy3P3cn8fUjqcS4GutSw2WoMMWAZupo2WKABOcBUXmEoGZFaXYLins22zqqUc48loddc14zXCtOLK08asHJ+4NIWNC2FU9hjdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Message-ID: <c0647197-5c87-4154-8a50-92e7dd2297ec@opensynergy.com>
Date: Tue, 26 Mar 2024 12:19:06 +0100
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
To: Haixu Cui <quic_haixcui@quicinc.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
 Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
 <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
 <20240320031253.eutoon7l7nkjehft@vireshk-i7>
 <8fbb904c-8d24-4d00-bff8-65f1e4bad5bb@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <8fbb904c-8d24-4d00-bff8-65f1e4bad5bb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|FR6P281MB4063:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gOMB6/5bU5RAt+jf7USOl6FgJtvoqdRVZT7vDPrf59ljt4c+Wwyxg76hc+44LATdPBf7wfyP4dBaI5VRrQTXcainvp1ZGe6MBjhUw8bl5Virbrl2LXtINcrcn+oOX6XOWSni/d0u4xm+9WMC9LL8JL53xjgpVJBdJX2zXyLsTxkALIJyML26KqXmnFAcTGVGcehq6QvVs+V5Z7KSXWNzKkwFtzMoQVWFCb1hp60Swm9jW2mauJTfrHbrirV5AsZSrQ/2u27gTkkvBNm33ovQQ+lyau+LezdC/q554xW1BKeAtSOXznW1OqXSK7TeuuogXL/64u5nyVvPOs4Cbhq+kHjdtKqAJlcNSRRSS9qsQ/DkQoq+vaRZXEAuI7GK3vuMVzUKJnIpv8EDlB7AEVohID2ij7e4nUB6cJkny0TwbgpTjhQWCwff1+oOhIIExHgpIfKW93gRmghbgHLDeAqjJNrAIq9QEkaXZYH1Kin+tov9y24EiBtJmMUKlCLGKMOoivSobcSL35vVVFwctUUj9EmZxB7xyjVO+KigbaAgZVv5VYbMcLDjSBSy9q/dIfi3BhZFB2jTAaOs718PG6t/J9sVQ/toau4WxohdZIKJtTnpMizOBwMooC/Iqk5t8xNuoiQlrxr/0fjCmxQIjoZUoAMFPwhEg4X0evNoRV8MoUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1d2WnFWVXVYeTdoMHRFQlJlTFZqL3czbVkxaWxKZDVEaFlDc0NiakRBMFQ1?=
 =?utf-8?B?eHBOUHJxSEFaK2VsM1VMTUNzK2tGci9ZSlFkc2hFSkpzMW5qdXhldzFTV2pW?=
 =?utf-8?B?WEg5QU5yQzhtZUQ4MTkvVXV1a3JnRWdlbE5aSlErVzh1VW81SHRnYmhrOXlk?=
 =?utf-8?B?MU9YR2wzZG9zYXhmaEZWZG4rSi9RWHcrTmZXbjBVVWhBN2xHZW1nclVrZkZr?=
 =?utf-8?B?VmRNNUkxc0ljRjh6aDlEUlk3dWU3eTZuSGkzcTZBTDI3dVpwY01WYjQ5SXB3?=
 =?utf-8?B?L2ZXN0plTFdGVkpTQzNOQXVPUzBQQ3dzRmZ0elFWVk9YdGZTS1dzMnRYb2NH?=
 =?utf-8?B?MTFoWjA4dm5RbU5JRnROOUExTWsvTE9QSzRMZjM0S2RBMVNiMUpCaUpLV1FG?=
 =?utf-8?B?VXlWQmJzVGYrcnRwTzU4VVlxaFc5UExiZEdtanA4TlNCWENxeVFLbnVTODdv?=
 =?utf-8?B?V1U0d0drN1Q2RFM3bGZMWlg1ZFVlTFoxR0xLS3plV1NGMVJXbWt4OFNqcGRP?=
 =?utf-8?B?MEJaNWpJd3BvViswV0ErMTI4NUFuZTlCeFJSYjJjaXo2bTNiWndlQmZjS0VD?=
 =?utf-8?B?YnNKN2J2aVZvWkIyTHFmQy9TL1lIY1R6MHVCeUYxODNGd3d4RGFlbmdKS2ZZ?=
 =?utf-8?B?Wnora2FoeG5KQitINExJRlVTWlAyeWVUaE5hRmRGNDliTkF6N084MmJXYmx1?=
 =?utf-8?B?OUVGeGZEZFpBRWtFUHcrbTRhZkxKTDQxTkZNdlRNWHFIMnorMkFOdklpdTFo?=
 =?utf-8?B?aVdrUEJqaC84NGYxdFRLeVNqK0Zjd0RtZ0pBdmMvcENRelozZWtuaVk1bHU4?=
 =?utf-8?B?b1k3WWZSeFZ5WHlnYmFNcUtORTZiM2FIOVFVRGRsWEV6cXB6WUMwU1lRc3ZN?=
 =?utf-8?B?QnlBZFBIakxWanJaZzFOcFhSQ1ZtSktuOXp2c0E2MWFOQjBYUXNmSm4yYTd1?=
 =?utf-8?B?cENEay9DSnlDZ1h6aW9JOENBVTBXdm9rcjVDK3pEQ3VWY2dOaXFoWEI4L1FQ?=
 =?utf-8?B?bkc0UStBeHBLQkw0cVUxM2hJdG1Sb0tMTG5OSjBGaDNjVkowcHlhczhFeGV4?=
 =?utf-8?B?anhFbEZOeUhMc3RncUsvaFB4SFdQZHN3WFFwdmlZYkNIcW0vOXM2aytlbXFT?=
 =?utf-8?B?OTRhdGNyUS9ZazlMYlBRUHhXcXFSblRld2ZIcmwyWGhDNWNnSFIzamNzVXNx?=
 =?utf-8?B?ZUhRZC9PMXFyekZFc3htdGRrSFZBOHBQTC9pVmVSelhNN0ZqSEFBbTVMcjJh?=
 =?utf-8?B?SFVZMUVBa2JNUTNlMi9Da3dHNk4zbU9ON3ViM1Bqckhla1NOcDQycWVYVDdk?=
 =?utf-8?B?QWdlSUNZb0VuRENOOWxRL0p3RUh4NzBsWUFWemJWWC9kSFpuVkNieUJqdlgy?=
 =?utf-8?B?cE42aDZBTFYwUWR1N3dlWFBmaWpJSUNmQ0F3QkQzYnBtck1vUHFtY29rTjl4?=
 =?utf-8?B?N3BlbjBaWHVoRVQzYy9OVGtxamJuM01lM2EwU0tPVGZIdDNqemxwUEJNMTB4?=
 =?utf-8?B?VmtPejVwek5vbmJ4Ukl1TnU5MzdMb2VIUmY2cE1CNnlrVk9rNlZZOC9yYkRn?=
 =?utf-8?B?bFRSN0huTythQldoY0gzdC9GbWxWSWE1cXBiZVpUVllzQnQ5N2FHU3gvQnU3?=
 =?utf-8?B?bElzcnhsUWhoMm9ldklTSEFIQ0V0dmVvWDBlZjBuVHNwWUxUeDNrSkIxSE1l?=
 =?utf-8?B?dGZFSDJucGZEK0VFNU9EYmthdlJDbGV5VmRtYXBaQWpYUWhMUmdYWlBveXJP?=
 =?utf-8?B?ckVMMXJHdUhSdGx0Y09rU2VDTGxxZlFEYzQwWjJuRk5SVHB5TGowa3JybXdE?=
 =?utf-8?B?S1M5TUVJZlU1WmVxbi9YM1htR0l0Nm5oSC9kSmh1ZlV6MUx1eU5lSTVWZUxn?=
 =?utf-8?B?Z293Yk5CVFZ4QkxYdWJ3VksvQXVTQ0RWRkU2SU14ampsVk04c0pPbngyTW5z?=
 =?utf-8?B?ZnMxQllJNlZSeU0xN0JBbEJhRHlDYUV4ajVONlNrT1lTVCtlZ1lqV0NyaW1s?=
 =?utf-8?B?Rm8zWTJxSk40S3FTRHVEOC9DQjMwTjg0NGJ3YjBtVVRKcnZOdlBQUTllUEJT?=
 =?utf-8?B?KzRYSGh4V1Y2L2dwZVRqSitsdHJ2bkJyQkxYQ3BGVTcyVVc3VmhTM2IrMjRG?=
 =?utf-8?Q?sL8lAxyV2JUHiz3AyeA9M7EyV?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71c7be9-8f95-4cc6-28d0-08dc4d868db6
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:19:07.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pnsJ0GjeUV2go/oaNt7HJkyfYpNln3puW95rSO33XZLI4N/PVgwTACMc2DJYTW0HVigNO1he5EB4sBmlcvJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4063
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28274.007
X-TMASE-Result: 10--14.223200-4.000000
X-TMASE-MatchedRID: fE0JoqABJp35ETspAEX/ngw4DIWv1jSVbU+XbFYs1xLnjJ+nnTOINl1H
	PAVML+u5FMKWPMuVgO3X0jf+J2tD8HZPiJta99mXbAQSvnY/AMVJnvfeG6RJLBD2yE25b9QtO80
	PnvMDYjDf69IM6MToGRTgrdLYcNhD3GKpf8GMgGRIhbHCNJtZqDsagavr4+KJBKO0biDL/NBoVZ
	galxlsblwBC+ObXMKeq/Jl1DTp3XzbBiuX+mNviHhmp8N0bz0uN0X64jGy2dZryOt9YYJsiAia1
	smLyWvDWNP1tVsAO7cX+nZswyazH+aCQmqvrVWusZIjJc0QK/bVLrJfyVWkTZAzrN62v5yEaGsP
	Gx9OkcRNnzYACfvJEAIX3FyA1B7Ja8QS26OstHdCPQBD3xA/3aryV/2jRq/XEgg3cwDHl/1O85J
	coT0w/W9dYCMo3/8Lv9rSd36EgUIj80Za3RRg8DSTRzEor+hcsV9ZIhTtxnAXkvxd87HT8a8qV5
	p41vn6dPa+kOXl+GY=
X-TMASE-XGENCLOUD: 2ebaf597-46dd-4b2b-9b92-d3d752227300-0-0-200-0
X-TM-Deliver-Signature: A4D90A08B5A0029B8968E70B5B65C827
X-TM-Addin-Auth: XY90kivpwnFA4KqlNN41cBzp6yjPiHIOdS5wRWf4GGkodMm63S6YDLKBIks
	sz41vp6kZNBx8mvcdbA+icHff/G2oEcypdEMD9lYjwrHSkFxYSRfAWldQOQ6WZU4iEQ/dDO8+yu
	f4BDCBKYz0xzXya8FUxDhuWaFGFXnZ52u8JQJVWN1yqlWEhZs7ZYRl/Gnqo5roDdRgIK9uai4o2
	W9qNWXuk3B74c5DNPHNj3zRPkrxHMA6tVsqPGO86BOoeZ8CpZrmVvG2Z/wIGWC/qBMPRMq0wmSX
	Cp/l4pihf3752i4=.sX7zeYq/gmG2DthBSwb4VeUETcDqJDNCOidFT+4mKPnB/ur/8PjqXFLG6h
	A+pcMBD/w16hWa7iBND1pIarL+7YzHcnMSX1jZmzedKsGBGRSvjZL5A1XyuFSgR8eHJhugvTM+Z
	EKozJVuMD82VGrd/udw3lI8w5NV6IqPhtH1fSJslSJHfLWX3SdbYMD+VsiJsckLsj0p2X5fQigy
	uCgEYM0ybH74UN07eTWFoI+ZDOn7SGKqoVnPgZjDWdpQITJGTevVmVHBzP4Qz4Xpf+8c/sckl9P
	Jo2RIy0tlbCdpLKZL4uTYVzILz82xueXJXifYN535FB/UtyHbNG5214YYJQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1711451950;
	bh=unvlpPNbGLpXmsCJNtgGIa9l1RRZQsC1875UeDDl4+s=; l=3400;
	h=Date:To:From;
	b=U/UfK66iPcqeoCSL0D07926LsBs89P4OwqtGxvb8ziVtUC2bgxK0fjXGJXKHGZJue
	 /hqrOw8OxF9NmOpKBwZ9xNcAYmSZeNpOjcCT1nhBOeMKA61xa88vkvBRelAR2jYHPb
	 VT4OZHnSPmRQGXm/3xcoMTMx6mV8yLu+xcqG/wfNxou6rDLSjQzlDXOjWK3aQ5TYug
	 nWv6v5FBzzzmNFeIVoQ6A1y7GBM1gX8ElgjddLrqrS1W5hwqOM4KQPEyrzMn4+wM5y
	 q8bg5E40mN6Z8MelaEuh4ozvEgYj29TqC23Dq4Epo6sXArQsWxag+lVKNm6ONvfj/F
	 CyTAfG4ztZ1mw==

Hello,

On 26.03.24 10:26, Haixu Cui wrote:
>
>> Looking at how i2c-virtio does it, it should be tied to the device 
>> itself
>> instead of its parent:
>
> Yes, it is
>         ctrl->dev.of_node = vdev->dev.of_node;


got it when looking into Viresh's code changes.


>>
>> Right, some work was done in the past to standardize these compatibles:
>>
>> $ git log -p --stat --reverse 0d8c9e7d4b40..694a1116b405
>>
>     Here I would like the inner layer "spidev", to match then probe 
> the spidev driver, the "reg" is the chip select index. 
> "spi-max-frequency" is not necessary, while It doesn't matter.
>
>     You can also customize the inner layer to match your own driver.
>
>     In my test, I set the cs max number as 1, and in device tree node 
> inner layer, reg as 0. So certainly spidev driver probed and spidev0.0 
> is added successfully.
>
>     But then the driver proceed to the following code, chip select 
> index 0 device is created again, the driver fail with log: "chipselect 
> 0 already in use".


The following lines

     board_info.max_speed_hz = priv->max_freq_hz;
     board_info.bus_num = (u16)ctrl->bus_num;

     if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
         board_info.mode = SPI_MODE_0;
     else
         board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;

are moved before the sequence

     err = spi_register_controller(ctrl);
     if (err) {
         dev_err(&vdev->dev, "Cannot register controller\n");
         goto err_return;
     }

     if (vdev->dev.of_node) { // <=== This block is new
         dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
         return 0;
     }

>
>         for (csi = 0; csi < ctrl->num_chipselect; csi++) {
>             dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
>             board_info.chip_select = csi;
>
>             if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH)) // 
> <=== This if else is moved up. It is csi invariant anyway.
>                 board_info.mode = SPI_MODE_0;
>             else
>                 board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
>
>             if (!spi_new_device(ctrl, &board_info)) {
>                 dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>                 spi_unregister_controller(ctrl);
>                 err = -ENODEV;
>                 goto err_return;
>             }
>         }
>
>

This means when there is no device tree entry everything behaves as 
before (for loop executed) and if there is a device tree entry the chip 
select will be setup already by spi_register_controller() and the for 
loop need not and will not be executed not annoying anyone with 
"chipselect 0 already in use".

I was undecided whether to keep Viresh Kumar's "reviewed by" in the 
commit message because I'm unsure whether this is to be considered as a 
substantial change. Changes are small but program logic is changed (vs. 
change of comment, removal of trace, change of trace wording) so I think 
it may be considered as a substantial change and therefore I'll remove 
the "reviewed-by" now.



