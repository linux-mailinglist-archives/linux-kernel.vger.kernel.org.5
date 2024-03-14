Return-Path: <linux-kernel+bounces-103103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA7B87BB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDFA284475
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04F6E5E8;
	Thu, 14 Mar 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="sUFA3jBV"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35F6CDD1;
	Thu, 14 Mar 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411225; cv=fail; b=EKCEovWdhVGm6J/qsw43z2AECLERlI6dGETDEl3wuIGuQTFIqN/pYzFtv4R5IY/JdKEYgRJCnmG1V/g2Hs4NhRzVlsInusado5DGeKnNxjnbhgFODDwss28rJEYCFZuErdv5PFq+rxSnMm9sluXG7Z9P0C5Ycbs2So8f2cKKv8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411225; c=relaxed/simple;
	bh=+LyZ7jITEdQWVqX6Z3UGjXZqHAaKNM58Qva0dXJrw0c=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUtsvm71D68KhXv35/jp29x79WLHrnK2q0lsvFw7efsWYmmA8XOnBkNQEAHD69BFv2WzTAsqOvHjsrWYqpwd3nSRs1yI/sdicvlvpO7gh6SIu3YexLvYBldilMz4kBqppaBr1M1rwKselMqbarVOIR3BM57qKiTD7FZ4h3rS2fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=sUFA3jBV; arc=fail smtp.client-ip=18.185.115.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.168.141])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 61B42100017C3;
	Thu, 14 Mar 2024 10:13:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710411220.588000
X-TM-MAIL-UUID: 947dbc63-7ff0-47fc-8e0d-431cd77a4de8
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 8FA4F10004DAE;
	Thu, 14 Mar 2024 10:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY3wtPxSlUcpntttSXuyJsJoY38FUM80ij/nu0z6xhW66rB4LylNB9dUCQ/J4OPk9YUx2+BSG1iMSFgFBXqvgkocEsDUD6xDu7ZCfDPT24xqBpYqRobRw+hY6inf76pe4NsTtgHdKNPZDvP8LPLwCfmmEl8IJ/QEavdB5iDIK2cc0a38G8x8zumLxGrT7UzNnBe+tDUh4p5eUJBDKSHgPoq7OrzciKvU1VurqjITa3ehiJBTexgJ3MriVy86ZEA8kVzi2nQdMeFY66ysPB/XrXsibjUzv13ebw6h5JdfQ7GhxXepk1VC0UIDm8fPfUrk6s/beQ8u26eXjRNo5blzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI1BKVnFSgyQt7dNHCxAJPK10PL41MjRH0y+k376RlQ=;
 b=SmBrgdGx8RllR+yrX8rJ8pHhvTGnnONOhy2GSzItbL1nq7Wue56MTSVFmMpoJTyaUCCCuCr1UyU6lwjZvZOHc5a2npUHQVz32Kag8iWL1o6K2vl32zCZ2qkIZRqheNlbCo6YiFPPSZKnAiiMr0bySn+W4toYdzePsQUTUWsL9dOB3F/c7bxwYaPATxJE85lXLfgG3AvplkYtDCvZ4uV5pTE2YM5ZjJLe8wVHDT9XpmW4yRnfaOOOGk3NTFYhLbSia6IxUJoMFzkO0CDVN1ivoltYHZCaWtB1T2gckFE9YgJgiS1v/WoHtWciUxQ8tF4J5x+FelXvjfe3WmXaqy2ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2eb5a616-eeb3-446a-85fd-fff376c15f55@opensynergy.com>
Date: Thu, 14 Mar 2024 11:13:37 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
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
 "Ridoux, Julien" <ridouxj@amazon.com>, Cornelia Huck <cohuck@redhat.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org>
 <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com>
 <89268C36-E8FB-4A17-8F81-1DED4BF47400@infradead.org>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <89268C36-E8FB-4A17-8F81-1DED4BF47400@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::11) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEYP281MB3882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b188f0b-9769-48d0-32e4-08dc440f6b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4wNL1VF9DYwI+9bGsSdjZjCWh+IsWWhnNsH41ZDgtlg86pJ3efi2gOSP92F/uElE9PPMniIUDTI5j6XH7dGHxKGok6yTGxavl3BFyJ+jPHFIn5VaBGUZBY1zh77gab2iwRkCyaeCe4go1ScIsXAa48UgQ6Z/3w2E7OrYav8ytFaTwbsE4iRQWMoNe2EZimesjYYInh3XBAowbNpwy/dyaKwKzMbNkFnUIbh9Xyx+HYDNYjd3H8fKYuvy5D+W4BQmdggb2EnXtr/U92E7qBJKjrVoASwdYc/lgDQ0PEylGcqTr6pVsZpRR/j954+S9hFGvRcAOLe88L/ERfr4kclBOHeXR00O+R+lnMCZh8HU1Mn+Srn0sK6tWH/v6PR0x5y2WLu+4oRrlpJk7YW6pHd0LEcZ3vuUIAwxtqtzbji1apUQ4ucsw9uNT7lWg7hFT5tJJU7soRx9bCZ13z3vLAe7d8HOSearmDzHSOVeg9nZ8yVcGNDHBik5dQtgvqlxfNAMNnCgB4qb5Xds25C3+wpgN0Z0bXbiZeMFt3v4ButGMMgJEIFYyyPJoPhRadDhuW1abr2AbYtmcqjb/EwAmYFtzJSm+bHWvNnTOQTXsc7D159Dq5AVRVpbbSNUcvRFa+dB27hcDM5WB82k4ixfVcvBh3gWvKKeZNedz7CRnhBMxoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHVFTE5PSHpnV0todHFhQmx4c3kvYkRoZ2NESnZNNWtxTGppV2I3NlVnUnFv?=
 =?utf-8?B?bmo2TkF2aS9UYkNuRjNQeVE5WEx2d2J5VWQ4WUNSQ2lBSUEzNTRoSHZmUUlw?=
 =?utf-8?B?M1JXT21OSmtLRTNwZ0o2a0FnUVh5N3ZqN3hKeEFUVWc0TFBLdkNGelZXUklI?=
 =?utf-8?B?M0MzT3lQNGJCWDdFYktlWklLc1JaMGd2UVFYTGNwcHE0a3o1OC9ONmtWSnlz?=
 =?utf-8?B?bG9UZ3hRMkxHbkNJeWRMbjRwM2lKRXpLZko4SVp1eERacm1UUWpieGR2enZk?=
 =?utf-8?B?L3lkOFZNRm9YM0d4a2lVV0NnT1k1aTJjQXd1aVdmalVWY1FkM1BGWk55M1g4?=
 =?utf-8?B?b2hEaG5nTDdzOHEzQk02MFA5RWJ1UFd0NDZyZ1JoS1NMbnUrOVlkZm5FMCtL?=
 =?utf-8?B?TjRVV1ZoUE1yYU5jcEc1clVGWXhXbUN0OVJjUkFyRTVKa1ZkNzB0b2syVmRN?=
 =?utf-8?B?VndLK0s5bGtNTExYWXdQTEpEblN2Wjdjb1c4R3BZUElneXpjSWVVTmlYTHll?=
 =?utf-8?B?eGh0R084ckE0c1lpbnVrUUlpY0RybzhEWGdUUWs2cm5kbFU5Ync2ZjZTTFEv?=
 =?utf-8?B?UkRsWVU5TVorNzBxbjI5QjAxT2FoVWxsYzhITiswdVIwSkcrbTIya2RFZXhZ?=
 =?utf-8?B?YlEzNVZ2UkZaUDlxVjdRWTJHdTdKdWlyRjJIY1k4TE1idzZVNis5aHJublhJ?=
 =?utf-8?B?VTBKejZZeXR4TGJ4bit5Nm1vTnd3Y2VseVBCVHJHODBkVXhEdUwxY2F6V1ZL?=
 =?utf-8?B?NGwvMFZHVmdHenc2VVNMUUpEbTN6MTlYSlRkZHdUMHhYM0FPdW9wa2N0TXla?=
 =?utf-8?B?ZVVESW9pOVBNMGUxSmdCRndMUW9VQ0oxR1dBNlh3SlRmT2NHK2RFSElvQ0xo?=
 =?utf-8?B?ZW9wbmtZQXE1NjAwb0MrMEZhUkJiNHhaL1ZBbHNCMHkzWCt6QzdrdFArLzBP?=
 =?utf-8?B?Z3doVDY2UXBabVFEVXljWGhsenlKU0dkM3YrOXhxaEQ1bWlXSnZKdGRqUlFk?=
 =?utf-8?B?dzh2VGpkYWdraml0UkNVNGVkUVFDVnFHTzBCUHR4K1ppZm4xVzBWdjBObk16?=
 =?utf-8?B?azI3Q1hqcmwwbFVCS2FHM1FSbGtIdHFTVEJEajJTeCtha25VczZuYUpVeklk?=
 =?utf-8?B?VGJZdGFvdy9wd0x4TGJzKzBDR3pGYUtTR3lNdEVXb1daQTNuSGFSUk55OUth?=
 =?utf-8?B?OEc0VUQzcGgray81V2RFTWtXd0JCUDhHSkNSZEdFTGI1bGY3TnNhRGRjVGR4?=
 =?utf-8?B?c21kYTRaai9CRDBWSzRROUNVaFpEVVZFR3lvU1ZpZzZrZnVWV0hnaUEvTnBy?=
 =?utf-8?B?ZXRnWHhEekc3L2NubjVTUDVNWUdYMEErUGlyK1pvejZ0NU5sMkFmVEtDOHBi?=
 =?utf-8?B?NXpUZXhvVkdTT1I3WTd6N3JzUHRDbUxnL1o2VGZhZ1dzcjBtQVF1bk1iVmxw?=
 =?utf-8?B?aHo2MXNrLzhhZU1LTDJGMDVRT1Vaa29ZYlNwRUd0NzVoMStZanFrZXFScERz?=
 =?utf-8?B?YWRjK1ZBeld5UHVOY2ozeTRObHZ1OEN3ckVQQ2p4L3QwUGFMSlZ2WWV5aElC?=
 =?utf-8?B?dWlFUnNYaU9MOTQweFowS3N0QUlYUjd5OVo0Vm90S25oWmJYbUdrK0licm5p?=
 =?utf-8?B?dk5VM2FOdlRLd1pRODNFRGQwQVQ2b2psNGUwTjFTU1B1V1hYNEh2dURzYm10?=
 =?utf-8?B?RGJCMFQ0eDEwWjlPcEM0TGNiNG95QkVFTlBWTXN5MTMrUUVwbElVOXh2NEFn?=
 =?utf-8?B?S3ZTM2FvMzZiYWhxZFo4eXNqMGZYUmhQdWY5NDhpeFVQVWNvK0QzK1g2SC9P?=
 =?utf-8?B?YzVCem0vck1qaXFlN0M2OCttQU12Z0VDam5VODQ0Y0k3aHBERnZjRE1sRFJT?=
 =?utf-8?B?SlF3ZUZmWnQ1bmFmdENGZWVlOUY5d2tHMDdTYUpQdHFITzBvMENsVUs5R1pJ?=
 =?utf-8?B?RDNqZjhoeW5QZlYySCtISEZ0dVR2Z0dxT085ZFJ5YTdWZDZzTU40eDVnRlFz?=
 =?utf-8?B?RXlhbDhDNjc1S2VmT2N1TytzNUt1c2JGcmdSa1U5Q0JJWXVNekIwYzlwZWNq?=
 =?utf-8?B?YUxHTnBiTXpPUnVHZk5uL1FtV1VnWllXMTJqZE40YmVMRDFrWmtjRmEzTXl2?=
 =?utf-8?B?TzhzUVhKWjF1bEJKaVRLNGM4VG5jUTVsM05mZGQ1VUlOUWZlMnlvSEJCeGdE?=
 =?utf-8?Q?SFqZ7cNv5InD19BPJULtMP21RCaBZfvXu3t8ZxcQqCg7?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b188f0b-9769-48d0-32e4-08dc440f6b1d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:13:39.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJMeoLFy36DvvZ87kCy+cbyqywu9Knqo4EyjSyob7UqYpG4goRH0CsVlEUuNw1BJVO0BFWSB1q7Z6kUC12zE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3882
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28250.006
X-TMASE-Result: 10--28.069700-4.000000
X-TMASE-MatchedRID: Kx0w2sAofbv5ETspAEX/nhT9ycEC6+LTgdXztqOEBnArwvLze83KAuIa
	26cVKu7AhEOzj8CJ9fp+2yr8TKFtiH9gIn+mT2gpeJchdZcr1K26wG+1uTW14KIcpU3/gcCM7v7
	BMdRZyXOqdXelqF/hxCsLxCkE8a4y8TpHqaSi8X4uvOeBC5O+9PoTszad2cIPiGVApiRLArnKOr
	xVtat4dufDukUCJiBS+ssPyzhkQD3zF8bUba++BDJiFWOuT2TvKqvIQ9QxkSAKFKWuigjcNEjp8
	7gwZNuZW+3NCtScsCWiZuLYGg7bUJ5mTKF4TLatuva7QpapAo0Mqau5sFOtzeVvCN18RUQ0OM7T
	o1x/H5IRd3SZn8yyQ4qg/Tre7H6jpUs3s04F1OG6Nil0LL1WUkchuUkke5jBfN5l7ipRk4gLJ+2
	oeExt+O8BzumvjiFCyLjSn2B78OmJIUGiYrbmwD4zJKoi4/aMT1faJMjZ8j25eAj4rmGko0hklV
	aCZmiJ5B7mY8S0a7SklSfqPcjvx4MlTUKmi1y7kY9I7o7kkJoDbR1DEIZ4unvBA9C/1eiFSJapX
	YJQvpPQ+sS71+DOCBAOLNGeu33dLkPB66I5MXl7+ppwg+NZl3GDuy8y1qkuA/3R8k/14e0=
X-TMASE-XGENCLOUD: ee0562ec-5baa-4b23-a943-07d9a9b41338-0-0-200-0
X-TM-Deliver-Signature: FC35E2AA31532FC6B445318E813D23EE
X-TM-Addin-Auth: pSCueay9oklJ0oMpEGSc/hMez0gQbc+eNgXhrsZgQiJ4tPHMqGvfY7YSygI
	s6P7PKPaAmB+v4O/g+JYID4C68vUFcS+//MnD8vNr5JCpX6tbpnyO/F8vgQZHH7TYZR1VZAMvWT
	5Z7LxDuxha9lgZo8mG3VBzby9TQfSFfvtKu9U/MdyApikLwd0Sa48TEEuCzyxEAFuRZnab8Sl0O
	wigmhbQHwTzDY6589ppZlfuUJIjLrfkCt9O4x5HbX9YoQKRzIywKUEJhiAhqRaoC8qECfibKcys
	pbXTsVe7q+u53N4=.dFHNzZYCOTgUpKf7cGZetS4lRjz2wsv7L0dvRaTcQDcImgbjWpUmXkff6R
	1wi8pWyhcwii7+qRJeXo/jwgu5CS9wjvdMoQJ4qdcy3tb8QItqy47h149AzdVvk84hehsm3AIpm
	g2XqgGfxyIet6WmXMA6td8lZ1lUHLFxC9v5D28hTgMY+rPnMzfy7r/f7CrOH/7I4W/45W3lPn1X
	C4a3OD2BZv1QjXWmoZ/fMJGquwsbHdjPKxDG9IXoLOjf9iwSU2JowY+8SSUXDroYhxTz8wDlLY9
	DBx5rXEh4CE2hcio7FboumofjntH+DX1gCMor/6mX2+5iaFqRGfDXHn4c8g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710411221;
	bh=+LyZ7jITEdQWVqX6Z3UGjXZqHAaKNM58Qva0dXJrw0c=; l=4111;
	h=Date:From:To;
	b=sUFA3jBVUoyCPLfMq5atv3AgL0llxnZm4v3y+tMOhm60RIDHSdB+hBwWAlMYv5XR8
	 gOn3TrLGF1ZUTHq2YRXU81Bax2UXTatPNBdBu6k9Ua6Ngdderr1Zhm0Z+Ni5kK9ufA
	 KmfG9HhjcWfhln4eYXD/e5fAcunNuoPMfF2CChXMeIlnOi9JeLWwmoWv2GG8/DIyUG
	 ayLhGso6zXsGmada4f5GohqlKbUnJVB2squJRInfkZWImTzD1UPIgwXI3Xsyp23+zQ
	 GGCNFJb7I1N7PbWCY9ZryIbdf5mUOxshp1t7SbUjurxI3B9M90tMpfQul7GIW66659
	 8enZBnYjDsJbw==

Now CC'ing the previous commenters to the virtio-rtc spec draft, since
this discussion is mostly about the spec, and the Virtio mailing lists
still seem to be in a migration hiatus...

On 13.03.24 19:18, David Woodhouse wrote:
> On 13 March 2024 17:50:48 GMT, Peter Hilber <peter.hilber@opensynergy.com> wrote:
>> On 13.03.24 13:45, David Woodhouse wrote:
>>> Surely the whole point of this effort is to provide guests with precise
>>> and *unambiguous* knowledge of what the time is? 
>>
>> I would say, a fundamental point of this effort is to enable such
>> implementations, and to detect if a device is promising to support this.
>>
>> Where we might differ is as to whether the Virtio clock *for every
>> implementation* has to be *continuously* accurate w.r.t. a time standard,
>> or whether *for some implementations* it could be enough that all guests in
>> the local system have the same, precise local notion of time, which might
>> be off from the actual time standard.
> 
> That makes sense, but remember I don't just want {X, Y, Z} but *also* the error bounds of ±deltaY and ±deltaZ too.
> 
> So your example just boils down to "I'm calling it UTC, and it's really precise, but we make no promises about its *accuracy*". And that's fine.
> 
>> Also, cf. ptp_kvm, which AFAIU doesn't address leap seconds at all...
> 
> KVM is not an exemplar of good time practices. 
> Not in *any* respect :)
> 
>> With your described use case the UTC_SMEARED clock should of course not be
>> used. The UTC_SMEARED clock would get a distinct name through udev, like
>> /dev/ptp_virtio_utc_smeared, so the incompatibility could at least be
>> detected.
> 
> As long as it's clear to all concerned that this is fundamentally not usable as an accurate time source, and is only for the local-sync case you described, sure.
> 
>>> Using UTC is bad enough, because for a UTC timestamp in the middle of a
>>> leap second the guest can't know know *which* occurrence of that leap
>>> second it is, so it might be wrong by a second. To resolve that
>>> ambiguity needs a leap indicator and/or tai_offset field.
>>
>> I agree that virtio-rtc should communicate this. The question is, what
>> exactly, and for which clock read request?
> 
> Are we now conflating software architecture (and Linux in particular) with "hardware" design?
> 
> To a certain extent, as long as the virtio-rtc device is designed to expose time precisely and unambiguously, it's less important if the Linux kernel *today* can use that. Although of course we should strive for that. Let's be...well, *unambiguous*, I suppose... that we've changed topics to discuss that though.
> 

As Virtio is extensible (unlike hardware), my approach is to mostly specify
only what also has a PoC user and a use case.

>> As for PTP clocks:
>>
>> - It doesn't fit into the ioctl PTP_SYS_OFFSET_PRECISE2.
>>
>> - The clock_adjtime(2) tai_offset and return value could be set (if
>>  upstream will accept this). Would this help? As discussed, user space
>>  would need to interpret this (and currently no dynamic POSIX clock sets
>>  this).
> 
> Hm, maybe?
> 
> 
>>>> I think I can add a SHOULD requirement which vaguely refers to vCPU 0, or
>>>> boot vCPU. But the Virtio device is not necessarily hosted by a hypervisor,
>>>> so the device might not even know which vCPUs there are. E.g. there is even
>>>> interest to make virtio-rtc work as part of the virtio-net device (which
>>>> might be implemented in hardware).
>>>
>>> Sure, but those implementations aren't going to offer the TSC pairing
>>> at all, are they?
>>>
>>
>> They could offer an Intel ART pairing (some physical PTP NICs are already
>> doing this, look for the convert_art_to_tsc() users).
> 
> Right, but isn't that software's problem? The time pairing is defined against the ART in that case.

My point was that such a device would then not necessarily have an idea
what vCPU 0 is. But let's just say that this will be phrased as a SHOULD
best-effort requirement anyway.

Thanks for the comments,

Peter

