Return-Path: <linux-kernel+bounces-47489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AF844E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0883C1F2C94D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E66118;
	Thu,  1 Feb 2024 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="vYSOB8Ga"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CC2C1B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750043; cv=fail; b=Tjvlsvckb8TdgPrNBb9+jpZti5UIwD3EwIdvC18U3ntTZbDVQKTgZh8Jn567KShimCNMWhUPNlutS/visrLeUcc9j6hu15qIpcowKchFI65IMD/wRwtuJRnkCEySdJ9+rK2XkwzaY+qeR7jf0TsZiT9CXBnzelf45i+v3DStmHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750043; c=relaxed/simple;
	bh=fKCN+BDKITtwm/psaitU9VlErAhqFXnWmhCBJe0ZyOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNQIcQCoNA8X+Lh2VDh2FaNRlgsVO5P84cALyRxNi0EMfcM5b4UH8E6552PrBAUq0Yy9jHif2pzuC6rpUjoUqTnINiXN5uMa399ED4cP2LSblAEWzSkIIF+yJOlqvuAwSu86oE9HF1MLjERjBmP91b5xGjVDkBQE8Le0X+7C1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=vYSOB8Ga; arc=fail smtp.client-ip=18.185.115.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 6A7D810000E1C;
	Thu,  1 Feb 2024 01:13:58 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1706750037.850000
X-TM-MAIL-UUID: b0af7930-2b92-4f3e-9e38-ee9280f68d67
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id CFA35100003AD;
	Thu,  1 Feb 2024 01:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nItwvIJotQAix5qX17CXYoIu+Il0+KGAZy//gwBJJjWkZ0mWJ+mnfRsMxe0U2ag2VPtOwpLWXkhxTdSpd81hx5NAV2ndmmHgI1VEvrUFo9UDiDrsbsZqiCusP37F6njczPCldpJfFhp85o1buYwuf9ueuoMNLnqsgPCMSVLHRHRi2tGHjLCaJL2PVLPKTKCbiQmerbgJVVLtxMF4q8qRqHT1nIjijsKd9wrReh/LCAx92iapZ1X3XGvB8kPb4d5XIw+5+43XLYrr+aJdcADvBrP9zoHXRnV1GCwZYOoPZzZ7N0CfCFLiitMU75zI3lVwejSYIxaJerwA7nE6RSDj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVaqywLmVXEHYzkO8kCw1PDsI5Y+t7IoAppUgdZw3q4=;
 b=TuEoBoRgaHjiMluyIQPEi2JQmRyVgLULmFrH5RfF75oGCPZ1Mncso9k8OeAVV5sAx/OmL/pjvahFeWxm5ydTT2l8gx4kpT4l2TCgKm4vK7bsdTrJzPG7Rgl5dWN56SObO3WW+bUHP4EBHZwcYsctKfon92RkfQG7k1PIN1VNPKCbNeOXYGfr1E7Q/pV0baBODo7VjYal8Oit78B14IRx9DYnuwQ7x0JRPk62YjIrlxjAgh9iUCx3z5mS1uwpM4upyNoVowZQtao7KZt62zwrK2wzBTOCjYxr5Dq0JuZ5mvGexoTqKP5uz1I5FCk1fdoBW9jqov1NxK/XHT4IilnHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e5ad0131-75d8-4b62-9ebc-b1284d05ef35@opensynergy.com>
Date: Thu, 1 Feb 2024 02:13:53 +0100
Subject: Re: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
 <20240130170556.GA1125757@dev-arch.thelio-3990X>
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <20240130170556.GA1125757@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::16) To BE1P281MB3272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:48::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3272:EE_|BE1P281MB1652:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aad924-9731-4114-6c0b-08dc22c30f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BaHrikMaBRJnkwK1elcXsM2UdzuHvvUad8IFUObvM3Tj35kahTxpMqlZEjH5GVsScBVolcUswaCUlvi9yK//mnvZgeKZOX+Nk7JDUYo8p+0Kcq9YEAIvNYTD/nvwwXQa+n1m6P8k6W+VxF8HMRQvsHBu0+qc60XRXiKsCduPOacFCMa9FwEzwB/dAm9yXRflzRlAxI6HYxhGp878ZCxUhSFlIxTVVsbQbFoockTBPOiokysRMERoolazsApXjfWZzfKnrSt2fuqYXOT+KZZeKFL0bd0Qq8geCBkuUDwTUy0rJV4NF3JYZWZ84ZY3Brv8s54EKOwFsY31vsYMRSDZLck4ADVRuE7xoWqBHfGu+vRDXoLzhZlLxytQr47dLd5WP1vch1P3e1L+ggmKsZJ4Ks7gT16tPOzbYwZL79tXAWnnEg6DDhvVwc3omFBPqu1OBD84fntvK3ecURJNmDHtcQG30V/r92FC4PwTlXKaFk9MFlnfllsc8T0HKFcG4jA/HPICZuBpjBhOhNRPXCB43u2vdvDB/RNaqYhl8UZwot6Xe7HI+k0Qs0ZTlKHjHt1Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3272.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(8936002)(4326008)(86362001)(44832011)(45080400002)(8676002)(66556008)(31696002)(5660300002)(2906002)(66946007)(42186006)(30864003)(66476007)(316002)(110136005)(54906003)(478600001)(36756003)(38100700002)(53546011)(83380400001)(31686004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJJMmFzNHQyTVpYOTZVVDR0OVN1QXdIRUJKNnl4UDNhVjJ4VTNsc2g4eGtE?=
 =?utf-8?B?RE9vR1lZSCt3WWczUlFaMFBiSzdleWk2cTYwTktoWDVENWg4am54OEE4QmRR?=
 =?utf-8?B?TlUzN1pXR3ZvbFRRRFJSenY0aHRxNFZORVgrZG1DNUp4VlVIY0c1ckt0enZO?=
 =?utf-8?B?c0s5bUZ0dW04RkRKMkZRWlVnVUdldWs0OWRxRGJoVGZKT2FSVVNGdk9lQjNM?=
 =?utf-8?B?QU1qaUZRSysvVU43bGs2d1N1aGJ4RE1LK3dGa2ptazJUZTBhN1E3UTNFb2tP?=
 =?utf-8?B?ZmIzdEZWMEEydVNoOGZES0lrYUxDcWpyUWRkekl2UW1kcElzT1FKYnRlSnMw?=
 =?utf-8?B?K0JNL25wbjJpWnZINERiTlB3MUpvK3NOZTk2c1hjZ0dpOTMzem5zSWxkdWxX?=
 =?utf-8?B?V09WNmE3YjBUNE9UeStLb2ZPWjJ3VGpqYzliZW5mOG9XSDN5VnhUcVIvcHBK?=
 =?utf-8?B?R0EwSWlBWXVhdTBLVnFhSllMK05ab3FFSVc4M3ZkUm04VEsxTlFPWTRibFBN?=
 =?utf-8?B?dkYyb29GQWJvQnVXbU5VaWdSZ1VuMkhqWVJhQmpKTkFEQTJCdHBMUHRvcE1i?=
 =?utf-8?B?Skd0N2VQQ2p3dFVWVkRIcWdtSUlxWmFrU3Q3ZVpuRzNsTjRMTk9kaTIxSUt3?=
 =?utf-8?B?dk16Z0RJY2NOTU9NUU9RUUhkN1EvN3A1Q3NtZURsMjIvWWlENGUvN05pdFZy?=
 =?utf-8?B?SUdQV2FxNlFXSkZNNXJjYzVtbExpUGpVN1FiY2lOTExocENBeTVMTlBBTTl3?=
 =?utf-8?B?anJUeTNPRVBLWGhHWFJESVJkTkdCUlNXNTY5Y3djZy9pVGxnb1hwSldidzUw?=
 =?utf-8?B?UitubnZBMmEyME9IOVZuem0zQ1ZrUUp6MC9vVmxyVW9wcWlpb0xJOGJjck9U?=
 =?utf-8?B?MDkxbVVYUFIwdURyYWF6UG1DWldqZk5oeStsb2JBbENMQzd1SWtFaFZuRi9Q?=
 =?utf-8?B?cXRNWjhJSGdYaHkzTWRyTVJsLzVzZzN3cVh0YzU1UFlNRzc2Q3g0WFVLcWlK?=
 =?utf-8?B?SzlGN2RNenFPYU9pWEQ1L2lRamlhWkdOR2VSOEpWVGNGMjM2c3NMNUtzUXBo?=
 =?utf-8?B?dHVvZGJabERwY0dqeFZKZmNORXl1UzV6aVlmTUtOd0pmdGh4MWRIbE5RRzJt?=
 =?utf-8?B?QSszSnRCY2RTd25QQXVmVlE0S0x4NWh5TUJsd3F2RVltaStrOEZEZlJOUVNP?=
 =?utf-8?B?WHdHMGdhQ0RYc2xoUlBVL0xyKy9lZ3BNN3hoS0hPQU9aZnJ5R3g1SDhFWlR5?=
 =?utf-8?B?OXVBRlNMTFVEVmhkL21xSGc0QXNQSnk3SUdsMnV1UDFIaktkNjU3c1lGQVhX?=
 =?utf-8?B?ZmFGZksrUlJTY0o4RG53SzI3M1U5RXlaelJEMmJMLzVSWnB2Q1hqM20yeUoy?=
 =?utf-8?B?UjFQQnU3UWZoTVJCQmlhRzJOQTVDWEpQaVZhZWNUckI3eHowY0d6bld0YWZJ?=
 =?utf-8?B?cWJNRkszeHJpYWZkR2VMSFlYVVdicDQ1UDhPcnZXaHZWYnpucHdHNDZqbWVV?=
 =?utf-8?B?emVobktlVHRNOFQ4VGtLcElZK2dCK0crR1N5Q3JUdmhlR3RVQXR5c3FGVHVY?=
 =?utf-8?B?MmVXRTFra2oxSGVIbmlCV3c3R0pDZUR5WEIzRlBvaUNUeWZzN2FSTzVyRTlv?=
 =?utf-8?B?aFVPT3l2VWU3aXB0N1NXVk41d2FRM3VIcnJUUjFoeExXYmZiZG02Nys2Mzkw?=
 =?utf-8?B?SkZyZ3V0am5wMGlHQXpRVGZ5OVNiV0lhWFpKZVgyQmg5UGNkMThlc1dXRzFC?=
 =?utf-8?B?OTRNd3hDc0FkUjI3SXJ2dU50VkFralJoclRlS3kySWFUK3JmTENFNXRidzha?=
 =?utf-8?B?L3hwQmE0NmZFTmhhdXVTT3RhL2U0TnNFbXc4WmpZWUcyQk1keENRazNVOG1I?=
 =?utf-8?B?MWEwaUZaTURvMU4xbFhHQW5PcDJmTWZadUdlMHBwT00wcDBYQytYNGZCYjVi?=
 =?utf-8?B?d24xT1hFbUlUeEx6enQrc3FCanQ1Q1hzY1JlUlNjRUlVSXMwa1pGeFB6aUdH?=
 =?utf-8?B?T0VtRklRNnlhRDBsQ3FwMmpMTHZORld0V0t1V0Fzc3RVTWFtb3l6cXFRNTVl?=
 =?utf-8?B?TWFXUXRZa0hqeTJvajVuaVBDRU05SjhPSzd5c0dnYmpWOEdXMitoUXByQnZu?=
 =?utf-8?B?NnN0bzVSZEdvM3A4SlhVU204Z21DRWhPUmxkUzFYL3VnSW9jdlI4aDVZNjlC?=
 =?utf-8?Q?SwypFy0ExASRPKtz0+v2KeOqkzsE4MB11n8w5HYZb4GC?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aad924-9731-4114-6c0b-08dc22c30f38
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3272.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 01:13:55.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F73OowbwY3Zcy+UVftbkXarbSbMK1JC4XLt1ogEN/X4/a6AY2K9k3RLsoKqFuPZYj9CNZQzZA0fBREYgy17VhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1652
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28152.007
X-TMASE-Result: 10--20.559100-4.000000
X-TMASE-MatchedRID: CxmI61mtwh+w1Nns265XUfEewkwt69wilR7tN56aWVVjIOKZDN+g+6dA
	lh+QMb10EUqFV2kIYMVwLr58jbPX7nZPiJta99mXKV8kgVerGpydVbkPpTjx98aGZ3GOeK8WpVT
	UdXBnkbrm9Tc/GgfFJwFtWueZlMH0b1PLs/xrNO90CtK0DggAXi0Z+AVgN1swKBPfwZB/0HIga1
	/l7A7rOpsL6aVu/P4zzuWs6DcKzrnkPM8jzlyhvEgfObGUdKnYdXI+BffqLuR5omhgu+tgnF5O0
	ZcKtJ+34WYDq+FKZm+LNexMpFbsSU+QIg0GiB1c5g/5EwtKNU7n0oaU6WM++z7Qn1lMCQHYrgde
	AA2yA+qGD6RKC2wEBtmRNMsBPcOVoaNNZSx9lPDFBwzJyVLv9xdg35AjTNkxSKMXcHZJynMa9kp
	QOg7I7G80hXLx0Dv1WmClCGuQ30DW6Z1LAX8jAQoqoYyXWsds2NmsCA5Q5rrlNADTSrHglbdJeg
	Xnn9ry1z6tWL+r3LZhwVdjpi43za9Ts9TwOodzVy6E8/6Gs2v1vm7LMwlVZG3R27olQa9ZWaWi6
	FrUKfseiDdgzR6CiwpWhIBzvUbzoR0T2IxW1QPdnKzUfJok1GPsaE89ndKTk4DaBlwOBW/YtERM
	5IRLIi9I9DPbLMxJFE5Ouydvey+IMERLnCjddiRn6tKktsD09hn59g/qNX/IRhEhdkLWErv1g8F
	IiLRXWJpOrSjVdnpDWas7zLaH+JF4FjpZWcBC39nur6FlBV67rMwJml51JqxXig7G0YhRpnPwYR
	aT4TCen0OOElWQ3esQNAL2u95wD5teccobfJXE70Mejctgq/rDHrB5YKTLhCTYMgUiZbKEUilED
	0gjsiVNJxt7aXvgmwjor1Nh6wtJFQD69E10vA==
X-TMASE-XGENCLOUD: c61a4226-b46c-4299-b697-d7215aa7f4b1-0-0-200-0
X-TM-Deliver-Signature: 638A2F4318F5D70FFE04E8892D6CAE9F
X-TM-Addin-Auth: M4CY3ogrQDgAbm0DYOQwq5OXa4zGGYf/4lpFdbrywI2U2ToTeQH3CnuomZr
	66Esq5H2m+fhWbuID60CjTso2sM0Bc4Tf0IttvvvZfHoPhXjYsqekryzWF6qrZJuKaXGONTe2DN
	FLX869J99M7a9Qw1ZBZP/+LP6+mH+XgQ7VVADUJfYEQkdN9O/p3oVanLj2D30OjCNdbOTUXb4g/
	/kC9FVuFbcZOT/vEAtVMqrGuiKTRrbAfni4Q3ziA4y7p584Lj+NplD+6sYKMhSWQFmsyrEcfJLU
	uhdKcgWSRxSdMmA=.Ht7eaut19wsB6deX6zmVDLQr699jKPj7aFmmvAcNT8sByqgIpUzk9Dt59r
	BxnpH1jdX6VcOkBMH/UOxIkx4PlAyLoisRsoyffPtLel+9zKwKx4lEnr9QmX9Z0E9aujXEMJwOS
	vG0BvmKZcjMb+/sLG2lD14LWKDAAIMAugG70oNBuqX9ER1SFL4/gPWWZLy+qhdZeHg8eG0IpDM4
	sMsKCZ0MYmRLml7YiNXwIAM2oskxa0Ldn3IpBGvyo6a8qnjIDENiVWEnnEEZZU+FZf9Mp2eWkJD
	5QMvvsYx9+LPClArXDwNcXuB7PkAy6lKsp4GuiHwiZ95CUFOM4KdK8Jzb3w==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1706750038;
	bh=fKCN+BDKITtwm/psaitU9VlErAhqFXnWmhCBJe0ZyOk=; l=12901;
	h=Date:To:From;
	b=vYSOB8Gajhy1NjEsBOjQe//ijwG1fUo0srT7OoeHQ4oBTiMosYdAmpU6cs8tjelGQ
	 wTxWr4GUJRhsTYgt2Q8t2BBRo/yNJt76b1BL6s8iTvp1FShaLWNtAKsmH7d1FPUnwp
	 2HF3LQKcyX9uozLzycsS15JIa8IqSV3fSUvRqcMdzRMBNKQTkv+ydtlrJnBAXalUB4
	 nZXDelKU7nvs6gZZswqArnnKl6kk3oWguRzL9BLBeBa6ozWNZdsGWhaMAJcEjTAcfP
	 B1wIWS2aLE5KAt6XoTvIhlRC0Dj6+7Yob6Ttwc/ubhjUgaCnXAlIvKJHANiL4B+7lE
	 GNCaW+8XBh19g==

On 30.01.24 18:05, Nathan Chancellor wrote:
> Hi Konrad,
> 
> On Mon, Jan 22, 2024 at 03:27:20PM +0100, Konrad Dybcio wrote:
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the workarounds, as they are long obsolete.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Compile-tested only
>> ---
>>  drivers/tty/serial/amba-pl011.c | 82 -----------------------------------------
>>  1 file changed, 82 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index fccec1698a54..c4df9cbc264b 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -152,23 +152,6 @@ static const struct vendor_data vendor_sbsa = {
>>  	.fixed_options		= true,
>>  };
>>  
>> -#ifdef CONFIG_ACPI_SPCR_TABLE
>> -static const struct vendor_data vendor_qdt_qdf2400_e44 = {
>> -	.reg_offset		= pl011_std_offsets,
>> -	.fr_busy		= UART011_FR_TXFE,
>> -	.fr_dsr			= UART01x_FR_DSR,
>> -	.fr_cts			= UART01x_FR_CTS,
>> -	.fr_ri			= UART011_FR_RI,
>> -	.inv_fr			= UART011_FR_TXFE,
>> -	.access_32b		= true,
>> -	.oversampling		= false,
>> -	.dma_threshold		= false,
>> -	.cts_event_workaround	= false,
>> -	.always_enabled		= true,
>> -	.fixed_options		= true,
>> -};
>> -#endif
>> -
>>  static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
>>  	[REG_DR] = UART01x_DR,
>>  	[REG_ST_DMAWM] = ST_UART011_DMAWM,
>> @@ -2468,15 +2451,6 @@ static int pl011_console_match(struct console *co, char *name, int idx,
>>  	resource_size_t addr;
>>  	int i;
>>  
>> -	/*
>> -	 * Systems affected by the Qualcomm Technologies QDF2400 E44 erratum
>> -	 * have a distinct console name, so make sure we check for that.
>> -	 * The actual implementation of the erratum occurs in the probe
>> -	 * function.
>> -	 */
>> -	if ((strcmp(name, "qdf2400_e44") != 0) && (strcmp(name, "pl011") != 0))

AFAIU the -ENODEV return for the "pl011" comparison needs to stay, since it
is not actually workaround related, cf. 10879ae5f12e ("serial: pl011: add
console matching function").

I suspect this is what might cause problems with QEMU.

Best regards,

Peter

>> -		return -ENODEV;
>> -
>>  	if (uart_parse_earlycon(options, &iotype, &addr, &options))
>>  		return -ENODEV;
>>  
>> @@ -2517,22 +2491,6 @@ static struct console amba_console = {
>>  
>>  #define AMBA_CONSOLE	(&amba_console)
>>  
>> -static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
>> -{
>> -	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>> -		cpu_relax();
>> -	writel(c, port->membase + UART01x_DR);
>> -	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
>> -		cpu_relax();
>> -}
>> -
>> -static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
>> -{
>> -	struct earlycon_device *dev = con->data;
>> -
>> -	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
>> -}
>> -
>>  static void pl011_putc(struct uart_port *port, unsigned char c)
>>  {
>>  	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>> @@ -2611,29 +2569,6 @@ OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>>  
>>  OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
>>  
>> -/*
>> - * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
>> - * Erratum 44, traditional earlycon can be enabled by specifying
>> - * "earlycon=qdf2400_e44,<address>".  Any options are ignored.
>> - *
>> - * Alternatively, you can just specify "earlycon", and the early console
>> - * will be enabled with the information from the SPCR table.  In this
>> - * case, the SPCR code will detect the need for the E44 work-around,
>> - * and set the console name to "qdf2400_e44".
>> - */
>> -static int __init
>> -qdf2400_e44_early_console_setup(struct earlycon_device *device,
>> -				const char *opt)
>> -{
>> -	if (!device->port.membase)
>> -		return -ENODEV;
>> -
>> -	device->con->write = qdf2400_e44_early_write;
>> -	return 0;
>> -}
>> -
>> -EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
>> -
>>  #else
>>  #define AMBA_CONSOLE	NULL
>>  #endif
>> @@ -2869,22 +2804,6 @@ static int pl011_resume(struct device *dev)
>>  
>>  static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
>>  
>> -#ifdef CONFIG_ACPI_SPCR_TABLE
>> -static void qpdf2400_erratum44_workaround(struct device *dev,
>> -					  struct uart_amba_port *uap)
>> -{
>> -	if (!qdf2400_e44_present)
>> -		return;
>> -
>> -	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
>> -	uap->vendor = &vendor_qdt_qdf2400_e44;
>> -}
>> -#else
>> -static void qpdf2400_erratum44_workaround(struct device *dev,
>> -					  struct uart_amba_port *uap)
>> -{ /* empty */ }
>> -#endif
>> -
>>  static int sbsa_uart_probe(struct platform_device *pdev)
>>  {
>>  	struct uart_amba_port *uap;
>> @@ -2921,7 +2840,6 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>>  	uap->port.irq	= ret;
>>  
>>  	uap->vendor = &vendor_sbsa;
>> -	qpdf2400_erratum44_workaround(&pdev->dev, uap);
>>  
>>  	uap->reg_offset	= uap->vendor->reg_offset;
>>  	uap->fifosize	= 32;
>>
> 
> I just bisected a crash that I see in -next to this change as commit
> 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx workarounds"). I
> see it when booting both ARCH=arm multi_v7_defconfig and ARCH=arm64
> virtconfig.
> 
> $ qemu-system-aarch64 \
>     -display none \
>     -nodefaults \
>     -cpu max,pauth-impdef=true \
>     -machine virt,gic-version=max,virtualization=true \
>     -append 'console=ttyAMA0 earlycon' \
>     -kernel arch/arm64/boot/Image.gz \
>     -initrd rootfs.cpio \
>     -m 512m \
>     -serial mon:stdio
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 6.8.0-rc1-00096-g196f34af2bf4 (nathan@dev-arch.thelio-3990X) (aarch64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT Tue Jan 30 09:42:53 MST 2024
> ..
> [    0.210400] Serial: AMBA PL011 UART driver
> [    0.245810] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 14, base_baud = 0) is a PL011 rev1
> [    0.246789] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.247015] Mem abort info:
> [    0.247090]   ESR = 0x0000000096000004
> [    0.247204]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.247338]   SET = 0, FnV = 0
> [    0.247423]   EA = 0, S1PTW = 0
> [    0.247512]   FSC = 0x04: level 0 translation fault
> [    0.247637] Data abort info:
> [    0.247717]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    0.247849]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.247975]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.248135] [0000000000000000] user address but active_mm is swapper
> [    0.248391] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    0.248651] Modules linked in:
> [    0.249219] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1-00096-g196f34af2bf4 #1
> [    0.249514] Hardware name: linux,dummy-virt (DT)
> [    0.249757] pstate: 41400009 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    0.249985] pc : __pi_strncmp+0x20/0x1b4
> [    0.250611] lr : uart_parse_earlycon+0x34/0x174
> [    0.250765] sp : ffff80008000b780
> [    0.250869] x29: ffff80008000b780 x28: ffff000001c07b10 x27: ffffd8d528b2bfb0
> [    0.251188] x26: ffff000001d57850 x25: 0000000000000000 x24: ffff000001ea8100
> [    0.251410] x23: ffff000001ed5800 x22: ffff80008000b7ef x21: ffff80008000b7f0
> [    0.251636] x20: ffff80008000b7d8 x19: 0000000000000000 x18: 0000000000000006
> [    0.251855] x17: 203d20647561625f x16: 65736162202c3431 x15: 203d207172692820
> [    0.252074] x14: 3030303030303978 x13: 0000000000000000 x12: 00000000000001b9
> [    0.252293] x11: 0101010101010101 x10: ffffd8d528f48770 x9 : ffffd8d528ef0770
> [    0.252531] x8 : ffffd8d528ac3c80 x7 : ffffd8d528f48770 x6 : 0000000000000000
> [    0.252750] x5 : ffff000001ed5480 x4 : ffffd8d5280f4184 x3 : ffff80008000b7d8
> [    0.252968] x2 : 0000000000000005 x1 : ffffd8d528ac3c80 x0 : 0000000000000000
> [    0.253257] Call trace:
> [    0.253439]  __pi_strncmp+0x20/0x1b4
> [    0.253642]  pl011_console_match+0x44/0xd4
> [    0.253792]  try_enable_preferred_console+0x5c/0x10c
> [    0.253940]  register_console+0x124/0x438
> [    0.254062]  serial_core_register_port+0x618/0x654
> [    0.254200]  serial_ctrl_register_port+0x10/0x1c
> [    0.254334]  uart_add_one_port+0x10/0x1c
> [    0.254452]  pl011_register_port+0x68/0x11c
> [    0.254574]  pl011_probe+0x1a8/0x1dc
> [    0.254682]  amba_probe+0x110/0x1c4
> [    0.254791]  really_probe+0x148/0x2b0
> [    0.254909]  __driver_probe_device+0x78/0x12c
> [    0.255037]  driver_probe_device+0x3c/0x15c
> [    0.255160]  __device_attach_driver+0xb8/0x134
> [    0.255289]  bus_for_each_drv+0x84/0xe0
> [    0.255404]  __device_attach+0x9c/0x188
> [    0.255519]  device_initial_probe+0x14/0x20
> [    0.255644]  bus_probe_device+0xac/0xb0
> [    0.255762]  device_add+0x600/0x7b8
> [    0.255868]  amba_device_add+0x4c/0xb8
> [    0.255981]  of_platform_bus_create+0x2bc/0x37c
> [    0.256116]  of_platform_populate+0x50/0xfc
> [    0.256240]  of_platform_default_populate_init+0xe0/0x100
> [    0.256395]  do_one_initcall+0x7c/0x1c0
> [    0.256511]  kernel_init_freeable+0x1c0/0x288
> [    0.256642]  kernel_init+0x24/0x1dc
> [    0.256754]  ret_from_fork+0x10/0x20
> [    0.257091] Code: f240091f 9240080d 540004c1 b500030d (f8408403)
> [    0.257519] ---[ end trace 0000000000000000 ]---
> [    0.258252] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.258698] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> If there is any more information I can provide or patches I can test,
> please let me know.
> 
> Cheers,
> Nathan
> 
> # bad: [41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52] Add linux-next specific files for 20240130
> # good: [41bccc98fb7931d63d03f326a746ac4d429c1dd3] Linux 6.8-rc2
> git bisect start '41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52' '41bccc98fb7931d63d03f326a746ac4d429c1dd3'
> # good: [f3f89885646036e16b325aea597fc9f375f1a56a] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good f3f89885646036e16b325aea597fc9f375f1a56a
> # good: [8042d32dd6c3730b0b4c8c9c811e204ed9f5f829] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect good 8042d32dd6c3730b0b4c8c9c811e204ed9f5f829
> # bad: [f0edba72fe5ae932877f49796aaef8adf1a2eb8c] Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> git bisect bad f0edba72fe5ae932877f49796aaef8adf1a2eb8c
> # good: [549632942a27cc3987473f8a8629200bc2ab0734] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
> git bisect good 549632942a27cc3987473f8a8629200bc2ab0734
> # good: [92e32ed303a6c4dc5a5ad9ec54785a6245bcd8fa] tty: serial: samsung: change return type for s3c24xx_serial_rx_fifocnt()
> git bisect good 92e32ed303a6c4dc5a5ad9ec54785a6245bcd8fa
> # good: [41b5684e58b1286ae0fa180bc50b661a27efee33] dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 family
> git bisect good 41b5684e58b1286ae0fa180bc50b661a27efee33
> # bad: [098396f23ede72c3140a5ba33db38b130385a5fd] Merge branch 'habanalabs-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
> git bisect bad 098396f23ede72c3140a5ba33db38b130385a5fd
> # bad: [fccc9d9233f918ee50cf2955ae7134a7f3418351] tty: serial: uartps: Add rs485 support to uartps driver
> git bisect bad fccc9d9233f918ee50cf2955ae7134a7f3418351
> # bad: [59fdea965eee9908d904b94828c69f641f1e92fa] serial: txx9: Add missing #include <asm/txx9/generic.h>
> git bisect bad 59fdea965eee9908d904b94828c69f641f1e92fa
> # good: [79821c8a45807655c25d6bae2b13a3f98a5c01cd] tty: serial: samsung: shrink memory footprint of ``struct s3c24xx_uart_info``
> git bisect good 79821c8a45807655c25d6bae2b13a3f98a5c01cd
> # bad: [196f34af2bf4c87ac4299a9775503d81b446980c] tty: serial: amba-pl011: Remove QDF2xxx workarounds
> git bisect bad 196f34af2bf4c87ac4299a9775503d81b446980c
> # good: [09aec324b60f4309eeba8d2d5c897e882cce23bc] dt-bindings: serial: fsl-lpuart: support i.MX95
> git bisect good 09aec324b60f4309eeba8d2d5c897e882cce23bc
> # first bad commit: [196f34af2bf4c87ac4299a9775503d81b446980c] tty: serial: amba-pl011: Remove QDF2xxx workarounds
> 

