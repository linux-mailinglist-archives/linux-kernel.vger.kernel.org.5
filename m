Return-Path: <linux-kernel+bounces-101262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3687A4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7FC282EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834611C2AE;
	Wed, 13 Mar 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="oUqt4xiz"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B291B273
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321246; cv=fail; b=TnD+OOfnKAbcEJoA9dpg3f41H/ceC7fDEaL8rCmm65cpz1VxUtZS0b7/R1lLwPdssW2kilkEm4VyeyeaoZSp7tpo6Fh0FRwr96TVk+e/epqJEPvfc9k9QaJh+/0GOM+riO0wKmo+Y442cSZsdwAaubvXVTTQVDA67OtREiherpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321246; c=relaxed/simple;
	bh=TmzGlgn023LyMgMhGN8GD30DP1X5xA1I7Pi+DLsuXeM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWpBkpURvKWVzScwZlzCPEZXYR3vDSwsjcgsybsCb+ditXJddXTeW3c6tmudUvjr4AHpuFtDxIqRPRea5QV9rh+FbbOY0jLyaVxvZFiREjBMFR3IbRIADj7xT4bAvbHcaJlaozfunI8ySi6raZqSaseBZARiLfPC9h8RQwoHjJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=oUqt4xiz; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.34])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 72E4310119405;
	Wed, 13 Mar 2024 09:13:56 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 5670D10000C3B;
	Wed, 13 Mar 2024 09:13:48 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710321227.691000
X-TM-MAIL-UUID: b681ef9c-e35e-40d6-a0bb-b26be69d3efd
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A8CC9100012B6;
	Wed, 13 Mar 2024 09:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsAo9PJTaNwG7LUMQmhZm7XLiMmm3BW9eqo/XbDQyboD1JbIgg2/9GkFkFLVrvfBxPxZ/YYEzqo84Maz4OrMVbB1/c1nC8BjrRTWDCeJaPRutTELIDOmhNriKmXhISwXlZaPM+2Z/S9zRTCbDTVM4bp2qTJLNRUi+yLByGTgVAsMu7IltpKmZVigS/9VoxpCKq96UZxiir8BFi7aVwPa6iMZW/TKcGnnzgSV1XD8PegsoyXtt7m1ixSRfB54lRQdnx8afnlkyK2puz+m1OrS3uckrCV5SWBtXCHoP2n86ktvj6fcWbys/mb2bz09/CZG0zEw2O6n7fewiEJ7e4LfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px6akjVtbAq6MNgQw5tUXANxstDJYgiiX2440Z5dF+U=;
 b=LFT3pp3i/kJJt6jTe29xXv/RoWieX8i6BIMl3O0lubKxwBEJpOCx30EsUDzrOWXQGdSPWV7fVum9sFhU6fp97tO/kxvKpXgpxDJiXJQ8lwJ3jQnTDzEXBsPQJ1Zl+QUyknbfG8h4eRKv4slP7dbyItJbprsm4ye/BjuMdyyjEhPtT6aPdq3K8Wcslnn2m/9loy8oFVLUfU1mNhVocW3cKm7CVIiIkO4oigvCjgZ+8ilOzFwtWCb9M2yUA1W/V/ZfsPRgjpQ3UsykVQMhR31uFQaB3Dggm5vCSUA3YG20nH3tfXgGlOvFTgssqCNraMilzQbBidLHCM+Bk4yHDAW6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <976430eb-55fc-4811-bf29-a37eaea30885@opensynergy.com>
Date: Wed, 13 Mar 2024 10:13:44 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 7/7] virtio_rtc: Add RTC class driver
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 virtio-dev@lists.oasis-open.org, linux-rtc@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Alessandro Zummo <a.zummo@towertech.it>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-8-peter.hilber@opensynergy.com>
 <2024030817030063a909f0@mail.local>
 <a4babfc9-f4da-4dfe-8431-eb819f5801eb@opensynergy.com>
 <202403111946106887ed4c@mail.local>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <202403111946106887ed4c@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::22)
 To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEVP281MB3557:EE_
X-MS-Office365-Filtering-Correlation-Id: 880ac835-a211-4fb7-e33b-08dc433de2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ndFvcep2HgE4ErJRu7cn6FmliZdAWJ5fIRrJh1dbr8sHJajNpSGrRLR6GJjvHj4YCfD5qHunVVZZPFaXNAUHe60rzV70OvKLvKzYS1TKietQECV3/oH668JzuRIcT+v2l1HuTznrLPA+xK8ndz3Wg+OOGj7DWHBKuoo0CDP2yndjxOqo95BRg8EZtFvfb9/bhrAIQEscI94kk1KzpTvlRojaF9B9Zk5ytAwr9P6MktZ5M8dkCCpWLN6vc45DcXG7ZlUasCGZtdQxnaAuP2IAJpRa6UkNpx0y1FFG8tkd7z7wKwuHP6A2tzK5FWBAf/NktN+ytXYgUaksvnHUJy9Y3aQlrYhQeCOp9b94W2qngn2et48W6nWLKygh/W6DiqASPXoY/5AFbwEI3ciyko4xrXqE7qLQKhSQk78FqinoyI8GPoM/fw7NRb1exVVDFv4wRAhJmXzg0TR00a9CdpPcoQFkLyP2ka//230OVIN+nHOaJWHJOeNqEvOUwTb7uMwqSdmVwaF3W0oN6VVaIpaENOwcC552YhPVx2cWppMkAxozuDpZrFeXp1xQ7xHR51uy/pEG2/QCco1EApwxPaMgtXFOFyW0cypnzEMNJNf9IpyXmH5gK3KBs2WRnXJTmuGYd5zjkaGHfxG160fkvfi6eKAzjES3JHd9JL6oiHMJS1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERSQmcrVE0zcUhkdUVlZlFCNWs5UWdaSE80YmluM0lUNDR4bU1ydTNzQjQ0?=
 =?utf-8?B?SWNIVjd4MHNYMjJtZ0RncnpIVUtyNlNaenpodkFURE5YRmE0QVNuNzFUK0RZ?=
 =?utf-8?B?bk52enh2bHRMdmVlL0R0QmhnYWlEcDliS3BKYU9ZSkVOaWxvWjRhWGcxWHor?=
 =?utf-8?B?YnB4UU9VSHNFYkVsYlJZc01PRURvWU9aQkdSU2xtVThLck1ZRCtlWUFkZVJE?=
 =?utf-8?B?UnA4eXpVQU1GVnV1akU0eFNPN2luUVBMSmh5dFBNQ3ZUeVV3RGdZdmtYLzBH?=
 =?utf-8?B?RWJqS2M2TEVGL1RqdkxJMUM2cmdxbTJDUUV3L1ZGd2drb0xKSU9haTE0M08r?=
 =?utf-8?B?VFVyWUFhc09IdjU0citWNzBmc1FrSWZqbTJzS29UbUdMampGaE1wSk5qSHpz?=
 =?utf-8?B?SVRCRWFHK3ZOZmZhMEVadFBPcFpJb1JoV3pocmhaSnZ2U0p3SmMwVERTelBX?=
 =?utf-8?B?dElxN0kxeHBBNXBsSk5lQ2F0OGFMSjhDbi9jWWp1S05tTm93d3hzVEJPZ1Ro?=
 =?utf-8?B?MW1ac1Fxb3FLS2Y5WEVxVWJBeHI4eWZkT05TQ1I0MVhtSVZUTjFXSEtwTWta?=
 =?utf-8?B?Tk9vakIrNDVwb2hKMjh0MGhmcWxmTlFiQkdIcFo0RCt3K0pvenUxNGN5aDdS?=
 =?utf-8?B?RHVGc0xURkF1dHRHOUFGWmlJNEErcDVSeFVOTGlYSEgyNWk0dVF1aG1Mc0dD?=
 =?utf-8?B?R0UrYmFpVnVHSEZHWmVRclBXSkEvQkxwd2RpZ2F3eDU3OHhSUnZaY0NkdGFW?=
 =?utf-8?B?QXp3dGVJazNMeW9LbDRXQ3JTOVlRUlVIQWhHdUZmdTJuODRSRnhWNmVsVlRt?=
 =?utf-8?B?VGd5a05PTHpqcnI5elNBcXNKMGtqbFEyaHBoc0s0NlU2R2RIdlNzM0o5WXZV?=
 =?utf-8?B?Q0JqQzh5RytlRUdRQ0RPT3FHK0VXK3pBTFNrYkdrM2w1L1dnZERpY3VOZC9C?=
 =?utf-8?B?RFlXRFBjVEFvc1JtenFVVTJhQ0tndWpHSWZWT3c4eldOUXY0VUpKNkZ6dXdR?=
 =?utf-8?B?SlhJTktHc2tOTldqd3prV0kreUYvTSsrQ2h4WmRxaUd2cmY2bU96U1JvS0c2?=
 =?utf-8?B?NzVQRVRnTk13Zy80d3BsWTZZVjJnVUhVL0ZUTk1MQ3h1SEZ2MVA0aGVTVzRG?=
 =?utf-8?B?WjhudDhMdHVUL2EzbXNZaExvU2wrM2c1VUdQQ21Ha3lMZ0VXaEVUUUZEM2Zl?=
 =?utf-8?B?T3pBZ0RldFBVdXYvRHRqbGNNVjNiaEttZnJpWFo1S2grYnJrQUUzY1FvSnJx?=
 =?utf-8?B?VEw0TEtuUEY5WTN0Zi9uQ3lsRTVnNkRHMWozaGtqZ1JRbUZxSUFnV0J5dHV3?=
 =?utf-8?B?a2x5NjA3SVFUYVhPUWFRRGpKL2NEQUVMdDhxRjBZK3BabWlZSkhjTElsbUJH?=
 =?utf-8?B?QkR0UHEzczRIbjBKaU1IeWRndXlhc2RUSEY4RXp1VytlUlZjcjhTVitwRHhs?=
 =?utf-8?B?L3JudG5QblJQZVkrSjcwaXI5Rm4rbjdTc25RSlF4c2R3UlVnL2RDai9qY053?=
 =?utf-8?B?REM4ZWhHWkUzR1BEdTBMZ2VMalBZWk83WmZ3SWY1elYyYi85S0tBVnhpU1RE?=
 =?utf-8?B?ZENmTzVrV21Sa2xUSTBrSkh0Z0ZybjEvSDlIbjR6SFZialpqZ0F5VUNIWWh6?=
 =?utf-8?B?SEEvYkxxNTZYVEFOWVRLVmpSbGcrNGZVREdlcU5lSGM0bjlLWXlZZk96ZEov?=
 =?utf-8?B?NWE5TWs1OFhhSENsOUxDYWpuKzljUitBdWJsenA0SGdIY0RDUXRNNmNuRWJD?=
 =?utf-8?B?WE1sWmxvMjNPdHlEMnhVdmpQcVhRMG9jR1lCeFNvUnFjT0VGRUdvbW5Kbkti?=
 =?utf-8?B?NDZ3MFN2cjB0SFJOZXkyak1LSjJZQ1I1OUNnOHErbHgzMzJKM3czZjlVV1h3?=
 =?utf-8?B?T2pPVTlOZ1ZPOTNWNi92aGVJOHBwQXNVVVc5STVjcGVmaXQ0RXRueTNsd0pR?=
 =?utf-8?B?QTUvTEVKTnFzM2Y4eVNXUWxiZWxWWFJPd0pONzdJdHdpZVZ3N3o2MVV3Qkt5?=
 =?utf-8?B?SjBuZjlSblJ2ZEpsZ29yeVpNTXJOVm5mdlRIMmw5RTJmSllTdE50K1V3S0lN?=
 =?utf-8?B?MlNzUHBqVTJ2ZVU4VFpTTXBzOWV2bElmZUFNUGkramJVZDdaTnRHa0IvNU54?=
 =?utf-8?B?QmovWG8zVk5sTEdIN1ZuRlVveisvcHl3azA0cFhxajNxeDJ1QUF5cTQzaFNy?=
 =?utf-8?Q?eTfZSrqdSkpP9/l6SVvhBT42PvgdbWXX9RiU8qplp1yf?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ac835-a211-4fb7-e33b-08dc433de2ca
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:13:45.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkQiJRVqwJciOkNtUUnzTJt+6rSS7+ZvLB5q0iwmek2Vsp4XoPMbKUhA7zkuMMTW/wbeLn8b1A2OL+BBA8NWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3557
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28248.005
X-TMASE-Result: 10--15.341300-4.000000
X-TMASE-MatchedRID: WMT2WRIkHPP5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xIMYmJSQF2rGpQq
	DKmcPOuIEBKrPUGITJYiwyLYfbaiPsGPIQd/o4GsJUMe+s5cvaObyUSNdkyqzgPq7HoNfLbZCyf
	tqHhMbfjYdmTU/HmzciPJ2hEK0g1YwQEav6jgEJfl6eSHsmvOfk9Xke28M87Nrd1iQ8sNyzNmcW
	3Pj5e9cmmg6F/eUa7ca2rxJPDajlCgInswSeyHD7o2KXQsvVZS1kSOvrGs/+FIRrNdwYuL6r8bu
	2KvjRzVvvakOGgKzvIUJ37kv+LvYhWf7tPDmqmrITytpp/jrEw5NrjESsdl95AdidniNKlo7dGX
	EX4OpkPvAc7pr44hQuD4kuuWRVEhfj/V9mKaoCaRj0jujuSQmlpl2yyW/Q0be8ED0L/V6IVIlql
	dglC+k9h5c4TN8zbZ0Sg7mn465/keB3YB+y0pVvPZV7/0FatlIlQ2Q2u3mv3f7qT3sazIOFQNfh
	bb4gCIK1Liiz4CmdvmynalYfFKgTmU5Vopcju99LhbsitqJwA=
X-TMASE-XGENCLOUD: dd486d61-0d6d-4597-86b1-2277c46db9af-0-0-200-0
X-TM-Deliver-Signature: CCA5C6C9CD5003FB25F414580E611012
X-TM-Addin-Auth: zNQyVFLlGz7XnCBOcjyfkRhO1BxMYnuJ0o/ZUB6Q9mgQi62xbvtogoWXABx
	TtzVVYm3bpbmNkeSagFa0dFzAybn2fgYz2O0d5+905UBJs1vk518HFFwYckA+MFRxRth1Wb942y
	2rDqwslihv2i0Mw17MT/mz5g3lnXYYge4LdC945XxVbIjctmAOoh+yo2RFlgOdbsAf5ENq4DmCL
	7S88wcycFs4o7Nq4OChc1XRD3wEXXkjHHEJXrASulLPfQGIJZxlVf98L3Ok2VT9HaTe884Jbk/7
	u6Z8rt7vOzRVs1A=.wVHK1j88+udXqp+uvhdBufrRf0MYa66OgDlKZFkXDx0KX6xC2KIHxFwCST
	otVYzY35T7w9fJJI22tpo3ds0NYWitJu2eBPI1hu9opg+OOQPgaEuOuB0GHc1bj3Z8IPq8qrH9X
	d+fnsArTjyh+XWAy7Ksw1RXiX8WiJvXMXZGFrfaE0/xvhpGRFis2t7PqtJxZCdmgok2R+Kj7iro
	hITWvA8X4fkM+MOi5eTopPDBlMw/sQCm0HaB52RhWVpjSw4SbBnSFEZTKIafbRrAnl0wDWeVTea
	6/XBTzzusrr4QxiS4WRuQkNh3gx0FjhxY2vXx+NDYoNNU8LquWvJ4MEWJ0A==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710321228;
	bh=TmzGlgn023LyMgMhGN8GD30DP1X5xA1I7Pi+DLsuXeM=; l=2108;
	h=Date:From:To;
	b=oUqt4xizh/hUpDA/eltcAw2tVdS9XfCNbNoINnsuBklaurG5lxg/wC6JGkbzznUIn
	 whaRVc1eyYhrEJGuv5+fqXyj+leITFm9i3yG9VouSd/NbpspeygaKXB4RjAYbQSn3x
	 aOhxmOc3/EuMMGUaaBtjE0R2fU+YpojsDN+1+fVwe3N8WJUwmEqP45Yda4CxncUP1V
	 pzG4KcsmoU3JdIJOWYZv/IxHtyWoaSkI0uOs5kDEgex7R6vBYMNz6B3Yp9E09PMJCG
	 LhUBIaMC28SoJaRUfMbEWOA85I00qDTYv77/9iFWfY7TzebCywNLtuPNex4+jGmWNc
	 DyIdrBYNN92gA==

On 11.03.24 20:46, Alexandre Belloni wrote:
> On 11/03/2024 19:28:50+0100, Peter Hilber wrote:
>>>> Perhaps this might be handled by the driver also setting a virtio-rtc
>>>> monotonic alarm (which uses a clock similar to CLOCK_BOOTTIME_ALARM).
>>>> The
>>>> virtio-rtc monotonic alarm would just be used to wake up in case it was
>>>> a
>>>> CLOCK_BOOTTIME_ALARM alarm.
>>>>
>>>> Otherwise, the behavior should not differ from other RTC class drivers.
>>>>
>>>
>>> What I don't quite get is how this is actually related to RTCs. This
>>> would be a super imprecise mechanism to get the current time and date
>>> from the host to the guest which is what I think your are trying to do,
>>> especially since this is not supporting UIE.
>>> The host system clock may come from reading the RTC at some point in
>>> time but more likely from another source so is it really the best
>>> synchronization mechanism?
>>
>> Hello,
>>
>> thank you for your comments.
>>
>> The main motivation to have the RTC class driver is the RTC alarm
>> (discussed below).
>>
>> As for synchronization, virtio_rtc also offers a PTP clock [1] which will
>> be more precise, but which needs a user space daemon. As for RTC-based
>> initial synchronization, my idea was to propose, in a second step, an
>> optional op for rtc_class_ops, which would read the clock with nanosecond
>> precision. This optional op could then be used in rtc_hctosys(), so there
>> would be no need for UIE waiting.
> 
> This would be a clear NAK, rtc_hctosys should use UIE to have proper
> synchronisation. It currently does a very bad job reading the RTC and it
> is a pity it has been mandated by systemd as useerspace is definitively
> better placed to set the system time. I'm still very tempted delaying
> everyone's boot by one second and make rtc_hctosys precise for all the
> supported HW and not just a single driver.
> 

OK. I plan to add a PPS feature to virtio_rtc so that it can support UIE.
AFAIU this is not required for the initial driver version.

Thanks for the comments,

Peter

[...]

