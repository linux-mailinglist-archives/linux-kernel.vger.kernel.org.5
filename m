Return-Path: <linux-kernel+bounces-99416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E684E87880F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFB61C2198C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408866340C;
	Mon, 11 Mar 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="h3n1Bum3"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408662A09
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182375; cv=fail; b=Nhm/SpXPsXUAtiJEgq1yghCliVFYrkQz0l/VejPzLfBHh95qEmc6fAysq6XPxtNw52ksz6T6ODp/GHAh9wsYBCfpItV9gaCVpyx2eiF0qfjES0UBmHKfGhZ1NTK7UowpeeneuWeBRXgizj4PQiJtm4+gT+ymLgtgZkevXnGxFC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182375; c=relaxed/simple;
	bh=Ex6kQSh+BJ6TaKBdRR2u1rlDDSt1BtZZYgQiTlB5OPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PlR6T7YiDoeoqzJVhBsE8NROOyKq2183mWPZNWhXtnTeHXoKK0u4zFXXfs2H3ZSGCrjiMzVK8p1cZP9ftvFl3DUslwG1A4FCgfxpPWERIgQctjUs5p0VsIH9YPLEM1nAkByBOXy8NrMRxjO6n0bv38FXQNgvK1MeZVwtGqGTgbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=h3n1Bum3; arc=fail smtp.client-ip=18.185.115.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.202])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id B7D9F1011AC4B;
	Mon, 11 Mar 2024 18:24:48 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id BE03210000625;
	Mon, 11 Mar 2024 18:24:40 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710181478.839000
X-TM-MAIL-UUID: f4f61e02-d1be-4e7c-9b9f-a16c46525819
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id CD032100010D9;
	Mon, 11 Mar 2024 18:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avZ5uSc0/FOjNMlD1KShEY+3rxMOk4kf/gK/vex7Y/sVURKRD9p0w8t5+F/iSY0YD9+44l1o86rVps9j46eRcAdbmoi3A2Sl/Lkz8Eimn8JD4YFV8C1+yg2CkBVHV7YVhZsX9bZpEkU0ycLabkCxal9+aCdjWVAs1yh4kn0NNethZ4X+lklNQ4+o+RA4kw6NBWTy1X+TH9GX0sJSmznnvqob3AhabU5lmDV7hl4GODQsguO/3UFYYOeZgorpQZi26Io3xS+T7ZCQxGwjQ0nWoiA/gRcnNYTOEahGD1loxSkrQcvuYAz/BV/V0dCXC8m3Ywf84fWfoeee0TXMHsr3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex6kQSh+BJ6TaKBdRR2u1rlDDSt1BtZZYgQiTlB5OPA=;
 b=R37yv3Tv+ENOilYKet5BGvkhBcmvp//LC1N/KD2VytKicZld0hmCpp/7/PN4h+bo2aY7qHHEp8iTePEuJaG9aJicGhlQWIejO8gGkJaSTD8nm5KZOEbLuwBFdzRMLc37S3d/my3vuplDl20mdpsVZF4d9wlqa2IFfT0aK3sASawo08HuXlA0X9IqIl5fH7Xq9CVHP2HkeaYKyChQVE85L9i4KgXGU4mcVJdlypmENZmYV3sAeJjkM7/7pJOhzOGn9wjqUvkwuVpaPQ+jiMsSnbxgZ9DPMBtr0Iwqy3g9253P0O+nBWZGMsjsrdD/9qFLNGfBaFezEtf9v5yP4BT4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
Date: Mon, 11 Mar 2024 19:24:33 +0100
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::7) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEZP281MB2947:EE_
X-MS-Office365-Filtering-Correlation-Id: 3881e1f2-b116-480d-d1bf-08dc41f88140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FGnJQTWjTg+pXgU5V5cMmGvX8PCueAlKNiA87u2y5H1jCk0lNNgXUcwKQ7yHiX6HRN05wniA8wnPo8ltb9T/omYeUN5hLSoxlZWxtexeNYRJsFe4R+BaEVbcDN5gJzmROoLBfDLqGkxuzaxmKMmk5sJ663OC9bQpjjY3F7yWH7emRDPzcTuyVariFmJObNWqOOwRAV+kA6jLSJfx9R16YL916498mja7uS8LVA6gzhMGljtIEqJ8WXTB3u0ifdnN4Aj4v6MHOMAod0HOskabQBTL7rkqxogYKsTQctgHCZF1TONCcmpblMj43r8LEcINjv712DdQXOi9F4TZDyoFb+yOr7Bt9Q0UgVi6o3yEOzn4appHzJYPZ9aPPB6eAWlJC8F2ExQeuBMyaABbavC3Mi71zhDyp21L5BqLLTF92LHhRn5HhSNPCE1WFujW9zpT43OvvtUcsyGu+3Abhunv9deE9WIqXxwp/QaozFMLAixflkxMgoHCuSMhavkJ2sf4mYiEKrUg9AXdatbgpUpa2pEbcwxT0LzOZ81gWq4mk0lU+9CQ+G14B3v0L8NFw4749s32Wc6pzD4gCfHjjc7wG6eE+5xQo1BeDSPzXWIYajw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThlblhZMGRxMDY1MTFkMExBOWU5ditMbXVsS2NFbm8rRjVtdkUxRWI2TjVS?=
 =?utf-8?B?MGRjS3c1MWpjNHhndVRyZXNFVkRoQjJwMWdLQUR3SzNiOGNRSG4zTU1ZNEt6?=
 =?utf-8?B?NkdPZ3ZsekROZmt4anhvWjhBZ0RneURKWUlIK2lBRS9nM01CZkFVckN3RTZO?=
 =?utf-8?B?eHpHSjZ3MEMvODRqMUthZU5zZWt1cW8rZjNaWWRRWkhwRjY3T1RVVS9NOXlZ?=
 =?utf-8?B?bk1NOEttMTU5dnpEVFhRamV1bUlMTkNtQzl0VWhyRGJIZkRpelROWWszT29V?=
 =?utf-8?B?dCtZNi9EbW80TGFuVExhZ2pTQ3E0VERQbzk0MjZZMm05SDVNRjkyM3dCMEpn?=
 =?utf-8?B?ZUlMR3J1QWdvODVkQTh3aGVZVkpQWnFjOEdvOWJtQWpIeFd4c1U1a0FZLy9C?=
 =?utf-8?B?MGNldE80VWs5ZllkdE92cFBtUktiL0RtYTVhcU1WMVZBQWlmZWJBc2oyekxS?=
 =?utf-8?B?eElFWnhCU25hSWlidkZMczRJb2dhMGFMRTAyaENvTGxsWEwzeUxPREVqY2Vy?=
 =?utf-8?B?SnhuelBYcndzNksvMVpMWlFvNGRMZWJ6aWZsYlY2QWxRcm1mUjhjT1dUU3li?=
 =?utf-8?B?RWFqSFM2Ykw1ejlGWWE3TFFnRmQ5ZWUySm5kQ3JxdExaNTJFS1Nac29SOGl0?=
 =?utf-8?B?SHZHb0N2RVIyLzhHK3ZvWWhrbC9EWnZhVW5ualZ4Y3h3MFNjZURTZjc0MklV?=
 =?utf-8?B?Sys3S0xOVTQrY3hrQjlFaXA1R2F3eXliYUVYZlFPK0lkZjc4TXUzc3ZTUGpB?=
 =?utf-8?B?Q2dmbnZNUWZidG00cGNVT21icUM1dEJmR0hLVUltNUE1YVBtMjJNWGY0QWRN?=
 =?utf-8?B?R240WVpMbGkzVlkvdlAvenh2VzN1OTZ2WGROR1RrS0Q3M2crTGRrUEFPUTY3?=
 =?utf-8?B?QVFUanRnK2VnSjdRNCtFUk4rWHVCUXJGTWNockUvNU82bFZ0SVE2MWNwNHBv?=
 =?utf-8?B?dG5sSHBtU0FXclR4K3VhNmRwcXN1NFZmNVJPOEtZenJrYkhsZUYyRXJNeFVl?=
 =?utf-8?B?Zk9DOENiWlgvZ2lYTDgrV3QzMkUwcTJpWlRFZnYzMENSSDRUdnkzdmVvSE5H?=
 =?utf-8?B?S0tQU3I0ckI4RGluOGpaaFdPTUZvN1NoM3k3WFU0SVFLOE1IbFBocHY2cmQx?=
 =?utf-8?B?cDVMb0NCZGFtWTRRQ1UxcFdnNGJSRkt1K21vUVBGeFN4M090Wi9DWU1FamNo?=
 =?utf-8?B?ODQ0YzJDMkVZbFM3ZEdEeDRES0xaRWlycWZBWkcvVjlVQ0duY0tRd0RrNnlw?=
 =?utf-8?B?Wm9uUmxDZUU3bG9CZmRrU3J4dGpMeW9wMGZWWGFLRSszODdEdGVLTzZzWU9B?=
 =?utf-8?B?V1VRNU5qVjFHc3RmamFNRTFUOTkxM0xlTUppZ1RoQ0ZTL2ZRdlgwQWFoMm5M?=
 =?utf-8?B?UmtPVDRNVDllbGtDK2NacnVxd2xvTWpUQ1NCWWJLcUpDUVowbUZhNmtnS3My?=
 =?utf-8?B?RDZOS0hvcFlHUnc2a0ZVekZ1enJqcUxadm1iSlZqZ002WnRMenFXdVF2SUJE?=
 =?utf-8?B?Vzczdm15bGE3Z29qTnBxWkc3UnR1czdkR1krZlpteXkyaWhRZVRQcVRObW5r?=
 =?utf-8?B?RTBLOU9SQlIxQnFjdFVoYmsrOXBZM1NnQXBybkVaVGdzWXZ1WElnSFhqMXdD?=
 =?utf-8?B?RHhwc3h2eFVUU1VxZnVBVHVpODNtZkVzd1ZrYTVtNHFwcmdiZ0l6R3Y0enNp?=
 =?utf-8?B?OHA5UVJ6WWZOSWFyUS95ajZWVEFVTjZVQWZjNmF6aGQ2WmRVR0pmSkFxdGN6?=
 =?utf-8?B?b2h4bTJjcEQvaDRXV0pTYk1SdmRMUEowMHN2RExZallCZ2dJdGU4cDM1ZHdM?=
 =?utf-8?B?M3Z2OE1XakF2T1FEdjAzTVJOVHlQZ2hNa0p0bVNXSFZvdXdZOFo1T016SG5Z?=
 =?utf-8?B?cXUwQ1RlNXU3dWxIalo5T3FyOWRnMXJCOFBsWlZwVU5jV3daLzFxcFZlUHg1?=
 =?utf-8?B?c0FpMkRibThNanE1S3A1WlcwUFI4dEZXL1NsRWpDTEp5T3RWTm5hWDlvVGli?=
 =?utf-8?B?VStUYXF6YmhyVCtZYWZDcWVMd0NMTEpnS2xBUW1oZ2FObjJqVTNEUmtxRlQ3?=
 =?utf-8?B?WlROa05WeUdSWHR2Sk1RT25SV2hpSnZhQ3FNVmI1YTA4WUhKeENWaXA0Qngw?=
 =?utf-8?B?NFZJVjVyMldQaFNCbFdnTWpwU2JCN1B5Rys2cjFhRk1DeXcxMzNIeFYzTmdt?=
 =?utf-8?Q?ZSC7rUEQSmDzBD9QMmVW562L3QAKT6BQc0I2f3ScdcfE?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3881e1f2-b116-480d-d1bf-08dc41f88140
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:24:35.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W08giiVrbwAk0co7r+wEADa8SnGpqHeD9G/hSVYOaVfZMmjG1pmxXeEufGuBnKcNk+YnElNhunNNrZCdLngLdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2947
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28246.001
X-TMASE-Result: 10--26.983900-4.000000
X-TMASE-MatchedRID: iKTMlETJ4pvEeENaa6f3ikrGcidkX4jxGG92L3YEEC5S1vM/0iAx5V1M
	xC0QiRRduJCIQB6CcSCKIRdh6isgq2I+gkCLWlUfQpItReB73a+Py64lcz7n+UeBlUNiDTPPEVN
	ldKVKxLoiUo9Ped35EVqUubEdSJrZm33Op+lSBVuztRfzg5OZ2p1hE3UvZVrYm8lEjXZMqs7Uxx
	aDlU1Cj0uQGiU2JHeTE6lhXBQcyrXKeq/WFUOWj8aEQ9gLcB6RbImvEGrHk0LcHWFKCmADczOBF
	H8ycPGeqh53G06xlXMkVMBG8+936xEScWb8rW5xXbJxOaDPVmF30OoatKKbkqShSnDUR7KDMAnZ
	fG3yI691zoCkuKv3zasiUpUJTGC8zosRFwFNleEwZSTP8c3RQgINeImKjrIZ3jDoEywIWbNrJ2a
	YUZsUt9baJGR5hZp8IQ/W2xt0OWSI01ikZq7Q6lpwh/JdR4ULNeXdnhDHWRFNMNY2L2K/D/tElL
	Nv9ka6oOcN6pqWAKtGxkRNnAqNIRrbtgMizVcHqfCRRGd/z+dbLHSUK6sTGk9Xke28M87NhyxRF
	qxgsXWej+zCcPqh8d0e5ULp3htMVigPU+iAgvAe1ctGtD1nVAvpq/ti8dx85o80t5u6voNR8jV1
	6J37NviZZN0os1WwgnaKsEJf9fGRRDMCama/3JCns0JewFL6yw8IwVE96j7XT+yjPvIHsU0R2PV
	jOgnpbFw7vqSqGw9H7ZApsQ6TPybIkqsaYWDfI6FLyA9WHv9Fg2HO5lmNEPB0Elm/TLuFTSZ/cB
	kh2RDHMkDvTEt1wi7V4HcHHgDR2S/Qf9ZCwzrOOyksIfrfLaqJbIe5fXLQn8cUfSHIwCASCDdzA
	MeX/U7zklyhPTD9b11gIyjf/wsz98W5VRR2G6JYuGaIjh0/IOKWWMbJYW0ONKiUWfcjWwP90fJP
	9eHt
X-TMASE-XGENCLOUD: 9a7d3620-82e3-4dd2-8ecc-9c4e0214c3f2-0-0-200-0
X-TM-Deliver-Signature: 19A70B52745240733C5099E2495E766E
X-TM-Addin-Auth: zNNV0nENlFEQGSFmxVsdr5PVso2cN9SkgakV1+zqWB/QmN8OESamnuniJIF
	l/OCzsoMk+T3FjQE1G7LUbNbnugMMdnrE1pCTllTQxgAb5L4rk69gAiak8XHMxjyCne9Fqcf6Nw
	++/XLjvPa1pfi++xrbsC1Ai/Wy7QLWvGJzLkDBatwQ/sK49k5EgmWDpRJcFTMO7hIMnymN+ZFL/
	apzqFj0sn86OEvBEuk4S9pN3WkHv92xV/h34fP8QWbIFyc8NLLsTs5Me383Ertkdqvz6D7o+q30
	tUG+T+0UDGmTY2U=.zq5t6O1Kx2KKKaeJvswOiO0qpLH9Fraj+Vyuto9clWSXym5Hs2Ih2obwAC
	zP6kd3dwO250QLAXDMHyebw6kCB01X1nHDn/uxHIYFoG521TQk+MBeyNqG6U1v6rKu7btFsotuw
	I4dDWDkJryOEFZ8atD6qYzdCIoIXdKjyeGAzWAkCj58rkck3Y19UCTZ+dnV/oIqzGJxTT4bdRMb
	70JaVHINj1LOK+TQmanw4Dh47Db25vRrnoeg77WZs6AbcgSJrFtSaELMFQ6uFi7mVN9LhZGXqQ+
	C+pXod3F0tjWXV2q5Sro10AKCSQRwYlcXpckPC1oQmS6uPlmbTgLWfMj6Bg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710181480;
	bh=Ex6kQSh+BJ6TaKBdRR2u1rlDDSt1BtZZYgQiTlB5OPA=; l=10480;
	h=Date:To:From;
	b=h3n1Bum3nCQASeW97VesvHimI08fHNANFXhqxMdvdImjFYhIAnZ/2vsTzxcUiiOwT
	 OoAFdcAVFRsmasLBmIiLlV2gGNmUQxn7Nx2ZII5Ir732HQV/eAPjAYLcxiz9qk82yq
	 55B6uucHzwiGf7wQW2pYMiytn35aZaY/ZLctysIqyYQMCEZoYFDDgvvQLT/SR9HW2b
	 sIWNOUPawkpaJTGLHiVTgfygON7aVqr/52+DgQWRZOg9GioSimG11fnizAUJXel0rJ
	 PuvsXVwLv4/8PZ7FK1Ru9Xzpa6yoaqGcchJVx+n7U2jjDGD4OZ+1mg6LT1VM512W0a
	 U15urJZjX1GIw==

On 08.03.24 13:33, David Woodhouse wrote:
> On Fri, 2024-03-08 at 11:32 +0100, Peter Hilber wrote:
>> On 07.03.24 15:02, David Woodhouse wrote:
>>> On Mon, 2023-12-18 at 08:38 +0100, Peter Hilber wrote:
>>>> RFC v3 updates
>>>> --------------
>>>>
>>>> This series implements a driver for a virtio-rtc device conforming to
>>>> spec
>>>> RFC v3 [1]. It now includes an RTC class driver with alarm, in
>>>> addition to
>>>> the PTP clock driver already present before.
>>>>
>>>> This patch series depends on the patch series "treewide: Use
>>>> clocksource id
>>>> for get_device_system_crosststamp()" [3]. Pull [4] to get the combined
>>>> series on top of mainline.
>>>>
>>>> Overview
>>>> --------
>>>>
>>>> This patch series adds the virtio_rtc module, and related bugfixes.
>>>> The
>>>> virtio_rtc module implements a driver compatible with the proposed
>>>> Virtio
>>>> RTC device specification [1]. The Virtio RTC (Real Time Clock) device
>>>> provides information about current time. The device can provide
>>>> different
>>>> clocks, e.g. for the UTC or TAI time standards, or for physical time
>>>> elapsed since some past epoch.
>>>
>>> Hm, should we allow UTC? If you tell me the time in UTC, then
>>> (sometimes) I still don't actually know what the time is, because some
>>> UTC seconds occur twice. UTC only makes sense if you provide the TAI
>>> offset, surely? Should the virtio_rtc specification make it mandatory
>>> to provide such?
>>>
>>> Otherwise you're just designing it to allow crappy hypervisors to
>>> expose incomplete information.
>>>
>>
>> Hi David,
>>
>> (adding virtio-comment@lists.oasis-open.org for spec discussion),
>>
>> thank you for your insightful comments. I think I take a broadly similar
>> view. The reason why the current spec and driver is like this is that I
>> took a pragmatic approach at first and only included features which work
>> out-of-the-box for the current Linux ecosystem.
>>
>> The current virtio_rtc features work similar to ptp_kvm, and therefore
>> can
>> work out-of-the-box with time sync daemons such as chrony.
>>
>> As of RFC spec v3, UTC clock only is allowed. If mandating a TAI clock
>> as
>> well, I am afraid that
>>
>> - in some (embedded) scenarios, the TAI clock may not be available
>>
>> - crappy hypervisors will pass off the UTC clock as the TAI clock.
>>
>> For the same reasons, I am also not sure about adding a *mandatory* TAI
>> offset to each readout. I don't know user-space software which would
>> leverage this already (at least not through the PTP clock interface).
>> And
>> why would such software not go straight for the TAI clock instead?
>>
>> How about adding a requirement to the spec that the virtio-rtc device
>> SHOULD expose the TAI clock whenever it is available - would this
>> address
>> your concerns?
>
> I think that would be too easy for implementors to miss, or decide not
> to obey. Or to get *wrong*, by exposing a TAI clock but actually
> putting UTC in it.
>
> I think I prefer to mandate the tai_offset field with the UTC clock.
> Crappy implementations will just set it to zero, but at least that
> gives a clear signal to the guests that it's *their* problem to
> resolve.

To me there are some open questions regarding how this would work. Is there
a use case for this with the v3 clock reading methods, or would it be
enough to address this with the Virtio timekeeper?

Looking at clock_adjtime(2), the tai_offset could be exposed, but probably
best alongside some additional information about leap seconds. I am not
aware about any user-space user. In addition, leap second smearing should
also be addressed.

>
>
>
>
>>>> PTP clock interface
>>>> -------------------
>>>>
>>>> virtio_rtc exposes clocks as PTP clocks to userspace, similar to
>>>> ptp_kvm.
>>>> If both the Virtio RTC device and this driver have special support for
>>>> the
>>>> current clocksource, time synchronization programs can use
>>>> cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
>>>> PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time
>>>> synchronization
>>>> with single-digit ns precision is possible with a quiescent reference
>>>> clock
>>>> (from the Virtio RTC device). This works even when the Virtio device
>>>> response is slow compared to ptp_kvm hypercalls.
>>>
>>> Is PTP the right mechanism for this? As I understand it, PTP is a way
>>> to precisely synchronize one clock with another. But in the case of
>>> virt guests synchronizing against the host, it isn't really *another*
>>> clock. It really is the *same* underlying clock. As the host clock
>>> varies with temperature, for example, so does the guest clock. The only
>>> difference is an offset and (on x86 perhaps) a mathematical scaling of
>>> the frequency.
>>>
>>> I was looking at this another way, when I came across this virtio-rtc
>>> work.
>>>
>>> My idea was just for the hypervisor to expose its own timekeeping
>>> information — the counter/TSC value and TAI time at a given moment,
>>> frequency of the counter, and the precision of both that frequency
>>> (±PPM) and the TAI timestamp (±µs).
>>>
>>> By putting that in a host/guest shared data structure with a seqcount
>>> for lockless updates, we can update it as time synchronization on the
>>> host is refined, and we can even cleanly handle live migration where
>>> the guest ends up on a completely different host. It allows for use
>>> cases which *really* care (e.g. timestamping financial transactions) to
>>> ensure that there is never even a moment of getting *wrong* timestamps
>>> if they haven't yet resynced after a migration.
>>
>> I considered a similar approach as well, but integrating that with the
>> kernel timekeeping seemed too much effort for the first step. However,
>> reading the clock from user space would be much simpler.
>
> Right. In fact my *first* use case was userspace, specifically in the
> context of https://github.com/aws/clock-bound — but anything we design
> for this absolutely has to be usable for kernel timekeeping too.
>
> It's also critical to solve the Live Migration problem.
>
> But is it so hard to integrate into the kernel timekeeping? My plan
> would have given us effectively an infinite number of cross-reads of
> the realtime clock vs. TSC. You don't have to actually read from a
> virtio device; you just read the TSC and do the maths, using the values
> in the shared memory region. Couldn't that be used to present a PTP
> device to the guest kernel just the same as you do at the moment?

Yes, and it would also decrease the clock reading overhead (saving at least
the Virtio response interrupt and associated scheduling). Would make sense
to me.

To be clear, with "kernel timekeeping integration" I meant to have
timekeeping.c derive the time directly from the Virtio timekeeper.

>
> You could probably even simulate PPS with it. Typically with PPS we
> have to catch the hardware interrupt and then read the TSC as soon as
> possible thereafter. With this, you'd be able to *calculate* the TSC
> value at the start of the next second, and wouldn't have to suffer the
> real hardware latency :)
>
>>>
>>> Now I'm trying to work out if I should attempt to reconcile with your
>>> existing virtio-rtc work, or just decide that virtio-rtc isn't trying
>>> to solve the actual problem that we have, and go ahead with something
>>> different... ?
>>>
>>
>> We are certainly interested into the discussed, say, "virtual
>> timekeeper"
>> mechanism, which would also solve a lot of problems for us (especially
>> if
>> it would be integrated with kernel timekeeping). Even without Linux
>> kernel
>> timekeeping, the virtual timekeeper would be useful to us for guests
>> with
>> simpler timekeeping, and potentially for user space applications.
>>
>> Our current intent is to at first try to upstream the current (RFC spec
>> v3)
>> feature set. I think the virtual timekeeper would be suitable as an
>> optional feature of virtio_rtc (with Virtio, this could easily be added
>> after initial upstreaming). It is also possible to have a virtio-rtc
>> device
>> only implement the virtual timekeeper, but not the other clock reading
>> methods, if these are of no interest.
>
> Yeah, that might make sense. I was thinking of a simple ACPI/DT device
> exposing a page of memory and *maybe* an interrupt for when an update
> happens. (With the caveat that the interrupt would always occur too
> late by definition, so it's no substitute for using the seqlock
> correctly in applications that *really* care and are going to get fined
> millions of dollars for mis-timestamping their transactions.)
>
> But using the virtio-rtc device as the vehicle for that shared memory
> page is reasonable too. It's not even mutually exclusive; we could
> expose the *same* data structure in memory via whatever mechanisms we
> wanted.
>
> One other thing to note is I think we're being very naïve about the TSC
> on x86 hosts. Theoretically, the TSC for every vCPU might run at a
> different frequency, and even if they run at the same frequency they
> might be offset from each other. I'm happy to be naïve but I think we
> should be *explicitly* so, and just say for example that it's defined
> against vCPU0 so if other vCPUs are different then all bets are off.

ATM Virtio has no notion of vCPUs, or vCPU topology. So I wonder if you
have an opinion on how to represent this in a platform-independent way.

Thank you for the comments,

Peter

>
> We *can* cope with TSC frequencies changing. Fundamentally, that's the
> whole *point*; NTP calibrates itself as the underlying frequency does
> change due to temperature changes, etc. — so a deliberate frequency
> scaling, or even a live migration, are just a slightly special case of
> the same thing.
>
> One thing I have added to the memory region is a migration counter. In
> the ideal case, guests will be happy just to use the hypervisor's
> synchronization. But in some cases the guests may want to do NTP (or
> PPS, PTP or something else) for themselves, to have more precise
> timekeeping than the host. Even if the host is advertising itself as
> stratum 16, the guest still needs to know of *migration*, because it
> has to consider itself unsynchronized when that happens

