Return-Path: <linux-kernel+bounces-100188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0687934C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F8B23538
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0579DB7;
	Tue, 12 Mar 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hFWsbQd5"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507456471;
	Tue, 12 Mar 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244175; cv=fail; b=QBOJuxCYJvw45QiZ4JRNm02nkySHrZ3smjVN23d9Ws8zw50u2OlcmDIaowiOboekrhDry6qOmuYVRach9guQU36sMqQ7H0NtnVzRT24VJuwtEUakVaDu5V8uRlDH/N53Nutnx0YWbDgebazmCtTaJ9a6O9rkMYEV2S98FUvWsn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244175; c=relaxed/simple;
	bh=CIlrwGUNMWq5DNbmJiwpfgxyGATQhaGQpwMYHRoNixc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzQeTMhgd4lLnl3MMiAte4jSHCGb0Gbobwvui1s4RtAcaCzsKK1Gzi5pnhq4FyeJ/zbUb7PYYC1bqq21/XxaKhjSLUKiHj8Z4sD8bvvCoYb5N5q1Q5rgKFVrmdzde/eDI7a6NuJo4uHIuCdPR02tg5IJ1JhpZiPqhRoiiJISaSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hFWsbQd5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C7TbcE004958;
	Tue, 12 Mar 2024 04:49:27 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n31fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 04:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2OXCr8ZA4PDqbta+ysU8JdfylmLy7JCDK2iUn+V2sZgXneyX+RyujcZhNUxfMwhKSfXrhlxOEcGEndQykwT3XBytcY8kG5vRu1kw05daUTSoVKaTzAjgQc/m1lckqhr+6gWH1521bUMl53qzd7FoQZyWdk79R1AOEEP+cOgtJvTo8H2PwT/Zp65pGbduYAGVNxBCFrNH/YcfJMfxWu3A1JqfiL5RwFd8CuoKOHPfkZK+hWmxzjnJ9hbLtB5FKKAVIrbgIMn+Grq3p1NomYzUGIS3yM+9hoWukqMbzlruuzCCOZN6aYQYRCTz5qk8me9n4SynPDfd+bwSd71k/MQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIlrwGUNMWq5DNbmJiwpfgxyGATQhaGQpwMYHRoNixc=;
 b=bmxsAWL2INrTgkAY2rz/GPPJI3vPxcwoO4yGDd0cVYQu0z/tPWYNO/foK1UkQwFyCB0ygoK396+vUmCzaxY25DAIDkaUYVsKDko8/tKdmg91J8/wKZounOk3Kna5DIP7xo6qcQb2nfRMfTe8J7B4B1cvhvJiZ/miOrxDGm1YzmH1D0oH1wpd5n4IZx2J2qi3xBZOiEl0C6sM/9S723IJU6ax+E3iWLVHgW4toF+H6pEIg0jrmwgMgA6B8E0dPs1t8HPDs6qrFjvRyYVbFvDdGhONLxx5qoyj20pM2W8aETB8Fkv6j0GVnhvRmlMkwzbh3AIO4rFdJ/IjP3UfQQiCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIlrwGUNMWq5DNbmJiwpfgxyGATQhaGQpwMYHRoNixc=;
 b=hFWsbQd5Lv/kbXdAAt75fvNYFzr1lZyUmqaEC2PJGUNPZyzHRKY68IvX7mMFH+zFVUO/wBNPfEG1I4uqxoBelNi8r/aRuMzW3k5rszMj2ZtEx2/2fDcrBMnNK1pqXcOJZD1OCYHaV9wMosg6uL9ATcAXeDKnMScjy1YXa71S8SU=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by SN4PR18MB4952.namprd18.prod.outlook.com (2603:10b6:806:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 11:49:24 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 11:49:24 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "horms@kernel.org" <horms@kernel.org>
Subject: RE: [EXTERNAL] Re: [net PATCH 1/5] octeontx2: Detect the mbox up or
 down message via register
Thread-Topic: [EXTERNAL] Re: [net PATCH 1/5] octeontx2: Detect the mbox up or
 down message via register
Thread-Index: AQHac+i61sfAXaBHQU+/O2t0jjKGmLEz906AgAACSHA=
Date: Tue, 12 Mar 2024 11:49:23 +0000
Message-ID: 
 <CO1PR18MB46663A9C65C990D07060AD9DA12B2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
	 <1710184612-29027-2-git-send-email-sbhatta@marvell.com>
 <570d5e37b84d5e2907e4b195d6c6df8c5e6c8830.camel@redhat.com>
In-Reply-To: <570d5e37b84d5e2907e4b195d6c6df8c5e6c8830.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|SN4PR18MB4952:EE_
x-ms-office365-filtering-correlation-id: 665711ab-bbf7-4cbe-9e16-08dc428a7675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hFGhcz0d2Tpel3AG9OySFvPex1jQSmoRLVDw+tER5oXDMUcxnn1c438FBOIOP9da+DZ2VEH8TrG0nBMRtt1qmsDlPJvk/WOV+OG1q2zxwjA/W/uqrfwxNJs9y8NHBpO2yryugKivhSNru+vVdBPYkcLlK5TGbEwNI4x4oD9KAphC+5qXdhfDPtGDrjij8fY6Scf9LANdVVGZJmCVJrmdH0xceqU5ftnmCPBEFG5HRDpMNRHvdKx5GAbt7SlXX1BpVYVIUJEp/OI6cgiTuxAHc1ym4cD4nB1l3lG26WJzeH4iVKg/whX5Ur74vO54dOB7GS0erVoWnSshs+buH9reSxdlltBTIsw3/YFvCHUJxlk+BSPl0n9qYdn/nGUDuC5w8sJJL8+6WAIm4+y8H2kom0gk035O1jbtHxaddmveWr1aCjsNzGK5XisQmlpgoImCOQD8fUXSlSnFHmHHAlu3eQxSNAs2FLvEaah6pNktYnfKkWvLy7whwY0gf96wTqdTackimfeOdqty/1ku5TcEElV+j2E5Cezc54yUkg5wm8CGbvzewpfeFW2O7dK6e7SPY892qyLldP5s5WkkXyDziIcu323eNSncnKcIG2k6YFAKKVva/dBTOnkT9mps3r4nQ9LlhlUB/tgpOlriGXPFy7BxF88rDDT9/l4mSy20Fa1VEZEbqTFKK0aQh0jhE3QhLYLqW/w7WM7PrPP/Igr0eCNrlTzQBQBKdSHmNGucATA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dmhLM05ab0dQMTc0WjFrZE84SWQzcGM2WXE3TzdqNXRoZ0ZwRkEzY09DQ2VB?=
 =?utf-8?B?NlFYVG1yNUx4Qk9rWnV5T2dGMCt5QUtrTm5YZS92QmNVandTcDNBYjNZa2xW?=
 =?utf-8?B?c3Juc0JFTk1JWkZBSlFGMHl6TDdrRk9UcVU2TzloQlBBWWlyZk5aZTljZ0l5?=
 =?utf-8?B?MkVhSVErWmtFZGxOQmJoelhJSDZ5eXlseVlqYVF1T3d3cVFtNmVwbkVuL3d6?=
 =?utf-8?B?VXpCTlFOTTZlYVZXMUJLZnhnRnhPcHFRVTRPaDRXNE1nOVZ3U1J5NzBCdVJN?=
 =?utf-8?B?Z0ZKc1hlYmJoSVp2SE4wNlh4OGh2Z1FsVnNCZW5PYUtWdkJDV0dGOFVaM2dX?=
 =?utf-8?B?aktId3k3NldSY3FvWjluK1hSbFh0bWgrYTZWZzFYdyt4RVFlYXE2MzdCWDRE?=
 =?utf-8?B?a0pOL050VEZsOWdYUW93S1hCVjNGb2FvaHB5bDYxSHE3MEV0R1pYWUpjWXVN?=
 =?utf-8?B?d2VPa2xKd0xtazc2MkxJQ201bDZ6Zkd6VTM4ZjVSVmpZOVFjRWk3cnZ0bkpw?=
 =?utf-8?B?YnkrdGtzSHA2cFExR3M1UmJPdjIwckVlZVNXbWRqZ0FtR3hkMTJjZ0FQbjJV?=
 =?utf-8?B?TVNPeUpmZWpnWDlwdnFpUDB0NHVzcjN5eXB0NTcvMCtxU3RqdGVuQUpaL3pS?=
 =?utf-8?B?b0k3b2t4S2lSSkVIM05NcU03eTFLUVBqVVRFNG1GRnRmaTdpeFRDQUdtVldG?=
 =?utf-8?B?N2FUVXRIcnlQQ1ZHVjd3UVk1aG1qYU04MjdtU2kwY2RycVBON244R0QvK2My?=
 =?utf-8?B?eTRmZUZCa3lFVTdZTloyUCtBKzl3eGtkTXBnalIyazdZbHlYaHNCM003UW9S?=
 =?utf-8?B?Z2ZyRk5MRzhkbU83SjNWRDhFdzlhTlE2UHFtWDFXZVA0U1VoVUJwTVd2TXBo?=
 =?utf-8?B?Yk5uVHl4dHZJL3ZnOC8wdGxYUWVvQWtGUjg4NGNMQVFzaTdteWNRS1VCdHZ1?=
 =?utf-8?B?bkU3TDN4Mk54TmFFcHBMRkJSTHdjY3hFL2JxckJtTERKV1FYY1NaM0ZORFY3?=
 =?utf-8?B?blJjNjlhdWpJajJDU0ltYXN4d1JyUUhnU05zLzd6WVlybFluTHF6NTFVWDhX?=
 =?utf-8?B?dkFlOUw4bUpsVkJQM3E0OFlVVE93eFRBRTF1dy9BamtuaUR6Yi82YURwSHJV?=
 =?utf-8?B?N016cGFiUVEya3NZYTMyRUJBOGpBL0xhTXFSUVBuK2hFdXBrTFh1aVh3VmNh?=
 =?utf-8?B?WkJ0ckprb3N4ekM1aUxCWjdacFNnb0hUZHRlc2dISlRxTE40R3p3blZSbWEw?=
 =?utf-8?B?M3E0VXJJOE5heEswdXljZDUwcXhkNUllNCtITzJaZFg5RkRLTkllR3pZcGhm?=
 =?utf-8?B?a2pHcnZSZy9ySmxiZWdWNmdaQ1ljK1hDbGNldE81eTBVb01qQ0IyWlNmcEEw?=
 =?utf-8?B?N3Y5ck0vbS9VcFFzdUdqL1J6SFVjeWYvaE1UYkFSdHd6bjVkUHNiVGZCdFlT?=
 =?utf-8?B?S2tNbDBJbndPM3lpaHNnZ0NXUlRCVGM0RGZ3M0RXNERFL0cxd0E4cU9aajZT?=
 =?utf-8?B?U0hmV1lmWHVNaVFWdWJ5QzlxK2VwaGdzSDkrRWZuY2I0OW5tVDNYZ0Y1dXkx?=
 =?utf-8?B?OWRSRS9jZFFYWSs0YzJYaVRoN3I3QkhmZTlnQ0svZmNTaXdTNmt4MVpKcTZz?=
 =?utf-8?B?ajhsZlpTWGg2Tzhyc1E1clhxZjhtSGIxQTUxdGpmSUFweVcrOVBiYW5zeXlH?=
 =?utf-8?B?K3JqWTl0YVFnWmpkTkJiaE1kNlRTZXo4VC9vWFdsbjB2azlNVWQyd3Fua3V3?=
 =?utf-8?B?Wm02elFaRS9GdVJLL2hFanNkZ0JjemhFTTAyLzN3aUNvSmFwL2IzRTl2em9B?=
 =?utf-8?B?eVY3VHo4Q1BnNFd6MTJXa2VOVkRiR2lQNnJJN0hsOGtINlE1ODdDSDMxM3ZR?=
 =?utf-8?B?T2k1RC90UkYzOG1wRmlzQ3pxRUIvSkRhQjg0azVPNlUxUHl5QUxCQzZpWHMw?=
 =?utf-8?B?dEt5WWZRZElpOUhjekU1ZkZoRFh1SGdaWGdjU2g1SWxINmNLMXJ3M0ZzTVlq?=
 =?utf-8?B?d3RoYks3YXg0MXBwY1dMRGNNN0ViS1hVU3puZkU4ek5oM1FpZnM1VmNKb096?=
 =?utf-8?B?STZMMks2WE9yQjNlUlduVzF3bnNMbjBxNXA0dmViT0tUU0tRbUZzWWxHcVBY?=
 =?utf-8?Q?76Nl2Rki1tk7IzbVJeV9Cm0yq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665711ab-bbf7-4cbe-9e16-08dc428a7675
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 11:49:23.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqfsW5efrmPaDFrVj1eGip5esEqnu6OxLZuFQea3Mfd11pPjXwWIEBkoiC7P0zrY+O85vo1CzvFJQgQBsFca+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4952
X-Proofpoint-ORIG-GUID: BsdkwwfWovJ2BvT38GBNG1TuEF5EEAqt
X-Proofpoint-GUID: BsdkwwfWovJ2BvT38GBNG1TuEF5EEAqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02

SGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhb2xvIEFiZW5pIDxw
YWJlbmlAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAxMiwgMjAyNCA0OjUyIFBN
DQo+VG86IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47DQo+
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPkNj
OiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7IFN1bmlsDQo+S292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IExpbnUg
Q2hlcmlhbg0KPjxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxn
YWt1bGFAbWFydmVsbC5jb20+Ow0KPkhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNv
bT47IE5hdmVlbiBNYW1pbmRsYXBhbGxpDQo+PG5hdmVlbm1AbWFydmVsbC5jb20+OyBob3Jtc0Br
ZXJuZWwub3JnDQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW25ldCBQQVRDSCAxLzVdIG9jdGVv
bnR4MjogRGV0ZWN0IHRoZSBtYm94IHVwIG9yDQo+ZG93biBtZXNzYWdlIHZpYSByZWdpc3Rlcg0K
Pg0KPk9uIFR1ZSwgMjAyNC0wMy0xMiBhdCAwMDo0NiArMDUzMCwgU3ViYmFyYXlhIFN1bmRlZXAg
d3JvdGU6DQo+PiArYm9vbCBvdHgyX21ib3hfd2FpdF9mb3JfemVybyhzdHJ1Y3Qgb3R4Ml9tYm94
ICptYm94LCBpbnQgZGV2aWQpDQo+PiArew0KPj4gKwl1NjQgZGF0YTsNCj4+ICsNCj4+ICsJZGF0
YSA9IHJlYWRxKCh2b2lkIF9faW9tZW0gKiltYm94LT5yZWdfYmFzZSArDQo+PiArCQkgICAgICht
Ym94LT50cmlnZ2VyIHwgKGRldmlkIDw8IG1ib3gtPnRyX3NoaWZ0KSkpOw0KPj4gKw0KPj4gKwkv
KiBJZiBkYXRhIGlzIG5vbi16ZXJvIHdhaXQgZm9yIH4xbXMgYW5kIHJldHVybiB0byBjYWxsZXIN
Cj4+ICsJICogd2hldGhlciBkYXRhIGhhcyBjaGFuZ2VkIHRvIHplcm8gb3Igbm90IGFmdGVyIHRo
ZSB3YWl0Lg0KPj4gKwkgKi8NCj4+ICsNCj4+ICsJaWYgKGRhdGEpDQo+PiArCQl1c2xlZXBfcmFu
Z2UoOTUwLCAxMDAwKTsNCj4+ICsJZWxzZQ0KPj4gKwkJcmV0dXJuIHRydWU7DQo+DQo+U2luY2Ug
eW91IGhhdmUgdG8gcmVwb3N0LA0KPg0KPglpZiAoIWRhdGEpDQo+CQlyZXR1cm4gdHJ1ZTsNCj4N
Cj4JdXNsZWVwX3JhbmdlKDk1MCwgMTAwMCk7DQo+DQo+DQo+d2lsbCBiZSBtb3JlIHJlYWRhYmxl
DQo+DQo+DQpTdXJlIHdpbGwgY2hhbmdlIGFzIHBlciB5b3VyIHN1Z2dlc3Rpb24uDQoNCj5TaWRl
IG5vdGU6IHRoaXMgcXVpdGUgaHVnZSBmb3IgYSAnbmV0JyBwYXRjaDogaXQgd291bGQgYmUgbmlj
ZSAoYnV0IG5vdA0KPm1hbmRhdG9yeSkgaWYgeW91IGNvdWxkIGJyZWFrIGl0IGluIHNtYWxsZXIg
cGllY2VzIG9yIGNvbnNpZGVyIGEgJ25ldC0NCj5uZXh0JyB0YXJnZXQuIEluIHRoZSBsYXR0ZXIg
Y2FzZSwgcGxlYXNlIG5vdGUgdGhhdCAnbmV0LW5leHQnIGlzDQo+Y3VycmVudGx5IGNsb3NlZCBm
b3IgdGhlIG1lcmdlIHdpbmRvdy4NCj4NCkFjdHVhbGx5IEkgdGhvdWdodCBvZiBicmVha2luZyBp
bnRvIHNtYWxsZXIgcGllY2VzIGJlZm9yZSBidXQgYWxsIHRoaXMgY2hhbmdlcyBhcmUgbmVlZGVk
IGZvciBiYXNpYw0KbWJveCBmdW5jdGlvbmFsaXR5IGhlbmNlIHVzZWQgYSBzaW5nbGUgcGF0Y2gu
IEkgYW0gZml4aW5nIG1ib3ggY29tbXVuaWNhdGlvbiBlcnJvcnMgd2l0aCBhIGRlc2lnbiBjaGFu
Z2Ugc28gYXNzdW1lZA0KaXQgYXMgbmV0IG1hdGVyaWFsLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYg
eW91IHN0aWxsIHdhbnQgdG8gYmUgYSBuZXQtbmV4dCBwYXRjaC4NCg0KVGhhbmtzLA0KU3VuZGVl
cA0KDQo+Q2hlZXJzLA0KPg0KPlBhb2xvDQoNCg==

