Return-Path: <linux-kernel+bounces-101610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AE487A953
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F629289517
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB7487BC;
	Wed, 13 Mar 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="Z+q8axAe"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E546549;
	Wed, 13 Mar 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339360; cv=fail; b=Br4rUxDhPN62jofel37+PSYblh4bytFs3kFmpTBeuc5xnRkdxd1i87u2omHm6WtF1JjU2FAAt4YMvEhr3dASeOhZGITqKTP3kV1FsSN3KUTvgpMgEDP4ZMN+7karBdDwOUCkGgpWSHfVtHuar2GkT1RF63PzGiKdwFGlOxUi2Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339360; c=relaxed/simple;
	bh=RdU5s+WL59/7N28hROzd0T0USPAg1FP9VxkmUkaftdY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pKZUeLpRDsawAgdsMxSFCsM77Tt8ZbGaF7bcDvKNcPQbIhtkZw/jp6JPWqzJvLwcNGfAvZsrtZpARnFBQB9DlxktKZ+AvVX3DtpqkP5cvQOQfOmXjRpboIJEz81sNJiOdwWkxNeX5bxNZrdQd+EZD8aefP1k+8+YpTXX1bodSXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=Z+q8axAe; arc=fail smtp.client-ip=18.185.115.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.197.65])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id AEC4910000D9D;
	Wed, 13 Mar 2024 14:15:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710339340.235000
X-TM-MAIL-UUID: 3bce099d-175f-4700-913d-06b35ad64c16
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 39AE710000E23;
	Wed, 13 Mar 2024 14:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzO1JEKctXoEguCxluU+Z1qDMpTfuf0HBY39+jeCGZRFWJ4PaWrIu1XxccZT52P+dxVJa4uGvL+0fqQAZmOIcrv80/EncSwV4N96M9KbiukwnlivS0IzB4ytK8KNWNsN7e8PmU/7ER6Q4eOcy3ntnRPWLHrJfvRCdCBd8vGmHRo/syIj3c4cNVeQvIYGInKCVl6IHbVEwk8eCqTmRVzvJ34OLKEsjmhroFrGLK86p/rkfP+Yqu0EwodW+SVhB8G/XQE4/9zAEycVx+dEVPyZXcMMEadrLWIY2KfQ5mJOMjm3RAjvNrIIpR/oaUbz7msTiCF2RTJ8pPqSH8N7ETQeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKFiVer18NCNLPkzEN35EWdACCdu3BwiRZLphUc52QA=;
 b=eMiH6iYK26g24foDMwjSjdltw2jmz9iFT4U+azK3gYDfv3DTsZIgeTOSXTt7gXHBG4rtUXUwoqc9eGzy6smaanwxW8vQsQ7EMUaz0DJZAMDhICCGnQt1k6iGGTe9jrIjnXttfDQAg8wlfwnwPj4QuI10p+ikrbUV36ZCAXIPkMCSWgOqHF14KuzmDH5fhW9qdTmopRepdwiYwxfkQXTp6bx7IK5dyqWs7TlDQvIUcMFTeEwZ5oAZ1ODvPaGYRd7gaqTRm6ELkgyHiUSRXJoT3qo2qS8OwpGUF/kvBeKHoEfzw37rWiQ7cLOGfk3scspmGw08NAnNEx93Hv0YlKImJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <bab09b49-aa1e-42cc-ae93-6e48f218bf9d@opensynergy.com>
Date: Wed, 13 Mar 2024 15:15:36 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>, "Ridoux, Julien"
 <ridouxj@amazon.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <202403131118010e7ed5bf@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::10) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR4P281MB3530:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a31ee1-6085-4825-20e4-08dc43680eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ecH29DigkWmqG6ux+RAZOfIQHZmJyZ9DVisKyPb9J3D96uOma9R6wBhIpgb+yxv7ieJaiEM4n8N+CrQFrTUYuxV9/fpraMg3oUVXCpufUnQUKJRVqeOI06YKP7kyZoJ0rk4IiQPGUVVUddypi38AW8KSsRG4OWc+whmQ77I0DgaHZDijI792953bw499ylm/AumdccwJj3klV/ScFjsydg6JsneW4cXNPCGRUDNE1fekq872UbP//D0x5Ouy+gjt5RCYSjJmzQGS9OkjplE7NeqYgL6+YzrSAcrsIk1YXMru/Bb8RhSPhEFB7kupnUEmF3kzmAzg2E8anHYvAADz4D6sLzJ2KjKkwibXNBKVu3ZAwKctfU2X7SEKbajPNtaHnaRQ44ktP1eQb+DQqrKAoYfuNZeWMOYc9AA+FnnBDAwhlE5rNWPwqx7usTjSMJljOulPK8XzEY6Wy6N+/mrRtdC416IRu8Jo3u87F0MwFwR9AqEKYDqbufNCq7FfWVFwrim9krAKEAZfH0x4wkpt/HgOVHIIq4Q0FkVlZaZhmDL7gAwy4NCf46Hxq0dHsu4ChMsIXRJQph5gtz8nNLLkialLl9PNPzyzpUMAs3+iFC7Jsult0/ry0PZflMWmK8AEsHQcsG88cVmvu06l0EsVv5laNTW8VGSaivoD32YTlmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0QvbHNTV1ltSFFZeVpJRloxaFN5emJWd3ozTHg1OS9aQS9saVh1RE5IeXdw?=
 =?utf-8?B?Snh1ODRSeXJMbE0vUytXenhuUWVGdEZIL3o4MStrc0liZ09pdDFHTWlaSU13?=
 =?utf-8?B?RUZYMHdrcGdWZlkvRDNtamVPYWhaUjlmdE5DU1YzajRPWmxxak5UNkVOUnFF?=
 =?utf-8?B?TjQydTBoRkI0c3B6LzVRWUxZeGF0dE5XNFlDTEhTVUJ6OHMzc3M5dUFHRk1i?=
 =?utf-8?B?Vk9aMlAvZEp6TkVCZWh4R3QycGtJYzZBNUtqKzhmck84eHFGcG50YWc4OHJO?=
 =?utf-8?B?ZU5oVWU5NFRUVkR6RDhjWDFramwxZSt2SlZ6Y0lobW5PbzgwdU10bXZTeGla?=
 =?utf-8?B?eGFRUUk2NUtoU2M0SWxjTDFKM1JEU2U5eW5qWjVjcVFPUmNkMURySkcrb3RQ?=
 =?utf-8?B?dWdoanVvbnRWV1dWVmtwOG1oS3NaMFVwdjNwbDQ3SHB3bFZsbEhxano5dUpr?=
 =?utf-8?B?QVMwSmdtRDk5L0oxemo2am4vMndpd1VYay8vZm5uTUxKZ0d1MXB6V2lnRENU?=
 =?utf-8?B?bTdTc2hmRm5vdW9LL1FYVGo4SjlEMnJLNzlMK0t6UGg5aHBnenBQZHAwanJL?=
 =?utf-8?B?QXlZbkdvLzdiei8wMmhmcmxoeE5abnRyS2Q1QXJYWUhhVU9WRllTcmp2bEc4?=
 =?utf-8?B?cXNXVW1Gb0F5OG0yelV6OFZBU0prRk43bWhmU1hBcDE2djN1QVVPNitvM21i?=
 =?utf-8?B?VG1NY3NwKy9wdEV6NjBNdC9GOC9UaFRGSDFFa1RnYXAxTlZBOU1NbmJQeldT?=
 =?utf-8?B?SE9SY1hheThPZ2pqMXBSS2N6RUNMSUpLU1hWWlJYcXFzelJ5QWNBd2t1ZVFp?=
 =?utf-8?B?cUo4andCaUlEM2hFR0hBMGhPT05jcUFGQ3QvaXNEL1RwQ0dwSG4ydzg0REZR?=
 =?utf-8?B?UWZPd2krbWFuTWMvUXU3dHpuVGJnbXZsL0JyM2loYjZZWWdiVGIybVFMMHpi?=
 =?utf-8?B?cEdmQlVLQzBQSTJCZjJhd2gvU3JlTUtsN2FNUnBsVm83aDVxVE4yUWVEMlVH?=
 =?utf-8?B?eUU1dzNRMVU4ZmVUdjRMVGhsZlpiSkw3aFRWUjlYcGhYSk9JaHlCOFFock0z?=
 =?utf-8?B?SytLOWtNajlhTEhHWkt1Z0N4Q0NralFaYlQ0TXFjZG9qWjJLZWdXNUxyNkVB?=
 =?utf-8?B?ZlhjYWpUSVc2T1cwallpWWRsUEdkVUwwb3lVRTFuR1VJUXJXUHB4bUhXRkpS?=
 =?utf-8?B?L1VEb3lvTmprT3lHVjRTUCtUSnJ1WUxhK3lkSCtpTzFVOVU1dG9kbmU0NGUv?=
 =?utf-8?B?dk1va0s2eHoxVEdNVjJhMmJEYk9IYzlESHhleDczT081VmgzK1BCbHhGYzJV?=
 =?utf-8?B?Z2NINlJXSWlUQThLN01yQ3MzY2NNRk9QWWszUEtkYVV1blVoRUtmYUZjL1hO?=
 =?utf-8?B?SGlZbnNtWnBxNndXZmpyVkVIQzZYMmNvS2JsODBvZlNRdmZKNCtXTjBxZVVl?=
 =?utf-8?B?V0puYkFEU0RmbkladTE1RlJ4cnpuTHFsUnVBTlVtN3I3WFJiWDhra0JVZE0y?=
 =?utf-8?B?NTBSS21pTEZESEdiNE9HS1ZWYjd5S2lmMTVqQzlFbGI5SXo2TlFDWGx6ZkZY?=
 =?utf-8?B?cWdLWkxKN2NNK2hFakFkU3VuTmtiR3hPdVBJNnFEQkNMamZqVlVIUGU1QTdr?=
 =?utf-8?B?cjFkQXBaRnpXeW4xTUM1VXhaSG1kS0pMN2dnUDZaU2xmdnlBWXJ4T3UybzdR?=
 =?utf-8?B?LzlYWFl2cldib3VDZ1p2RGpUMzlJS210TmU1VnV4REl6Mlo5ZHhzZzJaRmlx?=
 =?utf-8?B?OEJhYlF4NkFzVVdHQWFGVjR0aHF5aUUvL2tjZWRVVXlyZTNTY0NvYU5oVmdh?=
 =?utf-8?B?dzdMRDgxSGRxMG5sbi9LdTEwMGRKV0tHMGtCN3UyWkV2N29kY3ByOWxhSFJM?=
 =?utf-8?B?WVZUWFg0UFZGL0xmUllPYXkwRzd0c1Z2cXVEbGRkbmdDam4vSG82dG1CRFRZ?=
 =?utf-8?B?bC9NVlB0YmdwenZDdWw4YWlFZys3Z0xObnRrUDhFRm9EVFRHM2tCdHJtS3Fo?=
 =?utf-8?B?MG1WQW8rUTB3dFlWVUE2MlpDRWdFMWZmWUllMUx2eDJKYWJLQjd5MENxTnQx?=
 =?utf-8?B?d3JOUDFDdEZCSngya0U0REZOblpqSDBGME4vbWVSb1UrVFU5WVdxT2Y3enlw?=
 =?utf-8?B?Mkl2eUdwZ1J0UTdTbkt6TUlDYkxocVhWVU9yeTBLNDQvN0Y2U05hWks4eWtN?=
 =?utf-8?Q?54ey40Wh8B4PMjk/aOADnvq/55Fu03u1ataeC33MeMiL?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a31ee1-6085-4825-20e4-08dc43680eed
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 14:15:38.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms7jzL054YnxrOOpZpmoUJJJ4Il77HS7c7Xut1eeyrQNjtkV9AXqfE51jJtH2FTXPXt5fmm8TS7W4fiw9WHq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3530
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28248.005
X-TMASE-Result: 10--13.495800-4.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGj5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xJ4qfOd233bZcsY
	gh3E4k9IS/lRA4cmmoRum1DB6wJ7BQStxK/hhR/CeJchdZcr1K3121+9OLaII9EOKD7VsunkJh4
	pO5KWT1x9V79xapEHlUFip84z32kj4pGFowBomBXHwJYnpo0L6QoSarYdbAHqkqgSgGhKLfJTIg
	yyUDPAkdmoJDKaV79J5a4tofqkCFt8qSqSSg9XdwYB1AFEvUEXOTa4xErHZfdH7TVMOMpqUjCti
	DyAFcnYnd6/Qx58Kx0+4+hkW53DpnSo0KOAG8rZujYpdCy9VlLWRI6+saz/4SGQvSAIyHoOa0/Q
	l+gcIbW6miiB19Ur4l3jHUhSUqcUaIn7kYcazIMk+VN5SeE/CvPZV7/0FatlVhTsvF6LDoZZrq9
	OQrHCsjsAVzN+Ov/sEdBdfvwmYy0kqc21pKmIVcVfctmMnjH+C8x15rTiAZLzK1G18HdGtw==
X-TMASE-XGENCLOUD: 4fe6b543-535d-4e89-9b39-b6e2387f5b13-0-0-200-0
X-TM-Deliver-Signature: 7E4A0CE241BF67B3BD766C23A016EE8D
X-TM-Addin-Auth: ObZBle4Yd7Z7cvAkiKXNU4cq+JpWJWPZyF6udECpwvnuA/NO5qpnloh1Weq
	0Bj68vVsDtD7XUsRF4/197CaL7nwDcEa9hZ202S9Tm5eRNQH3E0bhfu7uT7ECbZWtxucrygQ/CB
	g3lzEYRQvaG7AZMUAED7344qPdpgMKMEq+AtKBMnbqxFdKHNPW3PArNrer7ZbEgV3Z/57uzDQVU
	fUIbhxhzx6wETAUNjZQ9N14jnJWQoZTRt5ypX50UNNQAUdbhMHsFx6vW9Lx1nOo8H3/YWdI5YWS
	NGsx+DUh+pP0An8=.QolDBG0NL4uHJdTn2fySl+IULS4SUnx1hLjamYZ0fMg8yJ9FpkUXhYSjMo
	2Y/x/BdESR1XWw95iN+/wIWuvKIn/BcQ1kkosBMXhbp9QQU74YPoBEAlbOvG5t+KQoijaFsbLtl
	rWBjn2cnbxtUu4rKSUkR9QvNKOdkVpWBll5b9b6nyTIQyMq8/sLNuZNqWHfR/GSowk0iq9cN2Op
	uQEF3Dp0GxAYdeqYSu/KWqfyQCiMRnQy/ZLn2VKIw2tq08xBUhKaLEs6giJO3L9ywe1Pzln8jvt
	qHFI2iznbDAXsHIoe0A3n4ey+VF2mzV72jzZrJWexpHkwY9XOqQv6o4A7bA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710339349;
	bh=RdU5s+WL59/7N28hROzd0T0USPAg1FP9VxkmUkaftdY=; l=2937;
	h=Date:From:To;
	b=Z+q8axAeLPoIApbT44YOZLpnUgO58TYvjFLvPqrtVK6Ul+kFCPpK0s87IMQQ28pa4
	 Sg1BAiyM2LG8oH7f6QSQbh8WvMmR2O9a6BaBJpYyd/fLUJXObwKKeKIt0FaRPckWDH
	 3eXOfgmHYhld69jZRGa2PKhuR51d0GgdFQVwenE4oyiylgAyzdlKdkvqwFV/zYk/lQ
	 iSKXBMNdk5SKDd6d1xFutsJl+77QfYKSUEzl+LJC5GtdU1Nx6LcjTZnT3IuFwsAv+v
	 iGzM0v40B64QH/U937pgxGy5yqT/KaKBQ6fTuGP2TxRXQudF0pmb9Hw7vGBy7SilqI
	 qNJIKEkAxzbUg==

On 13.03.24 12:18, Alexandre Belloni wrote:
> On 13/03/2024 10:45:54+0100, Peter Hilber wrote:
>>> Exposing UTC as the only clock reference is bad enough; when leap
>>> seconds happen there's a whole second during which you don't *know*
>>> which second it is. It seems odd to me, for a precision clock to be
>>> deliberately ambiguous about what the time is!
>>
>> Just to be clear, the device can perfectly expose only a TAI reference
>> clock (or both UTC and TAI), the spec is just completely open about this,
>> as it tries to work for diverse use cases.
>>
>>>
>>> But if the virtio-rtc clock is defined as UTC and then expose something
>>> *different* in it, that's even worse. You potentially end up providing
>>> inaccurate time for a whole *day* leading up to the leap second.
>>>
>>> I think you're right that leap second smearing should be addressed. At
>>> the very least, by making it clear that the virtio-rtc clock which
>>> advertises UTC shall be used *only* for UTC, never UTC-SLS or any other
>>> yet-to-be-defined variant.
>>>
>>
>> Agreed.
>>
>>> Please make it explicit that any hypervisor which wants to advertise a
>>> smeared clock shall define a new type which specifies the precise
>>> smearing algorithm and cannot be conflated with the one you're defining
>>> here.
>>>
>>
>> I will add a requirement that the UTC clock can never have smeared/smoothed
>> leap seconds.
>>
>> I think that not every vendor would bother to first add a definition of a
>> smearing algorithm. Also, I think in some cases knowing the precise
>> smearing algorithm might not be important (when having the same time as the
>> hypervisor is enough and accuracy w.r.t. actual time is less important).
>>
>> So maybe I should add a VIRTIO_RTC_CLOCK_UTC_SMEARED clock type, which for
>> now could catch every UTC-like clock which smears/smoothes leap seconds,
>> where the vendor cannot be bothered to add the smearing algorithm to spec
>> and implementations.
>>
> 
> I still don't know anything about virtio but under Linux, an RTC is
> always UTC (or localtime when dual booting but let's not care) and never
> accounts for leap seconds. Having an RTC and RTC driver behaving
> differently would be super inconvenient. Why don't you leave this to
> userspace?
> 
> I guess I'm still questioning whether this is the correct interface to
> expose the host system time instead of an actual RTC.
> 

virtio_rtc only registers RTC class devices for virtio_rtc clock type UTC,
so adding an UTC_SMEARED clock type would avoid leap seconds for the RTC
class.

But I understand that there are more concerns and I will re-consider. From
my POV CLOCK_{REALTIME,MONOTONIC}_ALARM support is very important however.

So the only alternative to me seems to be adding an alternative alarmtimer
backend (and time synchronization through user space).

Thanks for the comment,

Peter

