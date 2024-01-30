Return-Path: <linux-kernel+bounces-44755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A68426FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D4F1C254FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE36F073;
	Tue, 30 Jan 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="jRYhblbY"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96066EB4E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625173; cv=fail; b=h/W6dYWLHqIciWYC04D0J9eH7tv6fOzjEBhOAH73sRqCVDYoOKXs0czW6rS+45Pi/jaCt3GiZoaqrpBaJaUiW8+FRy3MmQnaXQJM3y+TfZciPfG9P4lgq4YLlD/MHTOgCFeljJYJnZ+V+hdZbXxkWt3Vv8nTqiewTVvMRlEtiRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625173; c=relaxed/simple;
	bh=yyocJPbTVJZO37d3VV9a4L61daiLnXEgIDNEgjCTO7s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFwvPwZeW4oxPIjNNtNOanMpPVlvGRtV9agIlDAU6zEY9Yjr/fQVVMGCRrJu9gqNlAc7TgSaZi4GHnqkg/Oje86j++HtXCTLl2V0AZxdN7dWTeQq4g1WmKGD7xnhejh1iopN+YGv7F1I2zs9RFoSs6g2UQty4T8WDGU23jNzH4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=jRYhblbY; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.19.51])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5A8E510DC1B0E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:25:06 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.193.99])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 14E1510000C5A;
	Tue, 30 Jan 2024 14:24:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1706624698.598000
X-TM-MAIL-UUID: 358e91fc-eadc-43d1-9053-a89230cfa6eb
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 921FC10000E20;
	Tue, 30 Jan 2024 14:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOhVMDHGdYkg94sK6RF6NGB29VTivCzEt5E1DS+ZMEBqZZ0S9dVTuMBiPGR2RmcYrrlg9YGrH/z75r+aIMK3IK2z6JL4Mg+HTgLeN5u7UaT97ElfOR2EluZsc7oh6Redn3zm2zB5QXymIp/TzltS9BlDWTzF0cH7lyUZFPUp0Gh/lzLGaurBVzrtNll03JmhlVw4V+MhLpQA3TsltnpMVJKhC6TozPtu1/DInZyi2/9vlXG4mlHDoU0XLAEEKz5ZMUwC2J4AANjfjkkpgl4oGEjCXj0TvR3RLZ2Bc9evF3SD5+bCQjYin82XJOXMGJLJ3EZUWMalm7ldxakBLwzD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//dCOJa6mRptmSUbWungXtm1VzpHt1IBJ1+w9qKIAAU=;
 b=czdyhNmLxYwjwqVQL+aUSa7V+1iwuLtqjgqaMsplSXJ+KI9VkoehDweDsvzZnkxaDFhpfDYZNzrmIHt6p4EP/6F6ch+nuXnz16oVEMwETO+MGk/hO9FxgQWNhglTMDhtUuM2pxxKEOAXZcFVLSPjUo2X62mssB0usokHsz+DCKL5On1t1jM9K+L0EOw+3/Dzu9Tv5pjq6y3qI6LkLpk3FJ+ytfWDPdTteUF8QzexjL+4DSowupTueiTX98ju3CZ1p3f6+1HJ+pVSMIcLyRUDaQtVpmEsXOdXlQglskSJkBpeOkCs9D76FGT4Twp/tkpKopO8IZacyAjsdr1cYKc5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <87c90c60-fdde-4db3-be84-6c8e78395e48@opensynergy.com>
Date: Tue, 30 Jan 2024 15:24:54 +0100
From: Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [RFC PATCH v2 3/3] SPI: Add virtio SPI driver (V10 draft
 specification).
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
 Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
 <20240129070652.6ikngp5qft2w5ybh@vireshk-i7>
Content-Language: en-US
In-Reply-To: <20240129070652.6ikngp5qft2w5ybh@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::20) To BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:56::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2279:EE_|BEZP281MB3208:EE_
X-MS-Office365-Filtering-Correlation-Id: 81acba9a-5fce-4e8e-f14b-08dc219f3b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XvIyW2uA1qxmt3KhB5LKv7+3DwFAEoZagVydwAGMYTYMLLZc9kjTVh50oQv17zD9svTFUkrM/Txv3iOt6s0JNeCwYr6nBJ05ubOszxZ/Nm/N3a7xSLdOSdiCrXBFkIlsQ5XK/K4PtoIDPK+Jo1p+lTr6hpb4MmqXcRcevgeZtbrwfYzGGNwS+YYs4Te2ImWEJ3Mn9zpYMe36q1rpgb17lYMudRDTh/oE0mnWbsh4uYBX4oJSEg8dVYLiQf6DsQOMOdJM2gIisMB8Zepi5UY9Xybq55dhqVBOX67xiEQod3rpLz91ChmS9y8cf4FQlRalTJDDvrx8tt9csl5QaLgIHe+a2MpdTvAyytZgdnRp37R/DVilUAawkOuV4BtlS+nzs4GCsbuCaB2nBf70NiJk6VmLTnfDwiRhTy3cuvQopOFpJIu9BVeMXl0SAx2I280wObpujM/cgad8k/y2nl/FwHLfwpm59fkF9cAOhGtecQS4S1yUponTrgNcIPEyfpze1ks0w704Ku0C8Od8nJPVy6OvAcelm3/zglp8ZuhVHLTXDI5J5JtFD4ztJ9wAMHEH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39840400004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(2616005)(41300700001)(31686004)(6916009)(36756003)(42186006)(478600001)(53546011)(316002)(83380400001)(38100700002)(54906003)(31696002)(86362001)(5660300002)(2906002)(66476007)(66556008)(66946007)(30864003)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdZN0VyMTF4dG12Q2I3amtNdXF0bThlclRFQ1lsR2JrakgwSHhSc0doclpi?=
 =?utf-8?B?cnAvanVQYllZeXA3YUNjdE9NazhFaTF0VHgxdG9hTW9TaHhqQy9TMlB3bnRU?=
 =?utf-8?B?SkhGRlZyWmUzUWRHS2hTYjdRWXYvZlVSWlMrWHM0b29KMEdES1lwZHdncEMr?=
 =?utf-8?B?MjJTQTZDWDdyMElYSUV4d0c4bDI0blJzQXJBeGM4WFlPdDRIOWhCQ2drMEt2?=
 =?utf-8?B?R0ZjWTlTTk9uYXNNT25YWlhRTVJRQTNRYXlHMThvTUY4TU80amI1TFhuR2Zq?=
 =?utf-8?B?UVFIQ1E4RTJWZXhNWVFrSWRBZXhQR1N3YjFOVFZPL1UvY2JzZit3aEVoMjZl?=
 =?utf-8?B?VEQ5YXZQOW1hemdRWGZWK1FsTkxWZEY5bVJDY1lOODRpZDhzWGxHcE9RaHND?=
 =?utf-8?B?b1lCVXJSYmc1Z3dlSW9uN01GRTc2U0hsMFh2RXNQNzZrU2VldnA3Z0NRb0k0?=
 =?utf-8?B?NERQbFhwellBK3N0QWl5OExnN3hVQUFabEpBTTRyMmpjanM4QmRXMi9CQnRD?=
 =?utf-8?B?bHp1a0FqVzdpTTY5dWEzUE9jT3dKV1Z6aFFIRUV2TjdvaXU4Zkl5QUU1eWtZ?=
 =?utf-8?B?UXp4THFpY0RkN3VuNzJvcS9IWGdZKy9PSTc4clNQRmtoS3ljNnA2N3U4WjRq?=
 =?utf-8?B?aGJRM0R4YjVJOWl6SHo0alNWOWo4NmZGL0xXY1J6R1RlS2pZSGlKQURZZ1Qz?=
 =?utf-8?B?RC91anNaWlhGMTE4M2k3UjJ1bk8vUlIvc2I3SlJsN1VWbklkeEpFT3dZa1RD?=
 =?utf-8?B?cjlJZFJWV2wyNStYakhXalVSNUxHdjl5Zi9RSmhEa2loZFVpbkhiRlA1TnJG?=
 =?utf-8?B?VlNqeWcvRXEydCtpRkljam93bU50b3ZJM1NkblgxWlgzUkR4c2dySjFRY3Y2?=
 =?utf-8?B?SGY4SWk3eU5jOGdHMTNyUzhxTC9FbDQvbzN6VEJILzF6dWduUTBObkN5c3Yr?=
 =?utf-8?B?TU50WnJoNWg3YlpkLy9aMlY2Z0lUaW1tUUNGK3ptMVpqUWtEMHhWODFNUWxz?=
 =?utf-8?B?ajBiZzF4amkxR1ZaQ2ZsaGdNZE82NEhjRHIzNDloRjlMV3ZVOHFQWEpqNmdE?=
 =?utf-8?B?UG5Zd2REUXNJRXhySlVRTTBwUDdkZ0V5ZnZBYTFzOFhoVTZqWWMwZlljK0xD?=
 =?utf-8?B?QklCY0gzazNMWUp2Y2c3M2U2VzZIdnhjeEVFVG9xTzhDa04rRjEzU1ZxVzdM?=
 =?utf-8?B?QW4xU01MRHdWR3c2SzBIa3I0OEtCbCt3NDh1VE9iYkRJVXJoTXkrcCtsT2dE?=
 =?utf-8?B?UFFrUjN0SW80VHozSnM5d0JpNVBPVmZzVzFSZUlKRlI0alFjemFMSFJUN3p2?=
 =?utf-8?B?NnhVeUtzM081bExSalJRak5FV3lYOTB0REYwRE5ydnRuNmcvcGtDd3JZaVR1?=
 =?utf-8?B?V1BLMEdkbUVVNndod1VMOXBMbjR4b2svYTJvLzNpZVNsWlVHSk16UmI3VlQ5?=
 =?utf-8?B?Vi9CRmxSMnQvbHFIRXFIeVF5MWphekl0YS90YjBWdUJ5NFYydWxMU2ZUaUNl?=
 =?utf-8?B?M1VCa1NXVkxvWkpsbzI5VE9aRmxRYU05ckpKcmMrbHM1K2YweWpvOXZTYVFG?=
 =?utf-8?B?L1hFeG9TK3BuMjN0OTF4S2RxbjVrMlluNjNxVVBwR1MrN0dDQmlsck9QNU0r?=
 =?utf-8?B?UXRKR0JSb1ZObmdaSnJMaWNMa29Za2NYZE94M3c2ZjJXbkpCVVpVbFhPclFX?=
 =?utf-8?B?K1I1QWhkaUxmRmNzRjlnYnRlVmN3ejZuMWFaTGtrMzh3b0ZpNzJmNmtxTTZu?=
 =?utf-8?B?ZU9oOThEQVhqVHRzQ0FnSmpBS21BeEtEeDRMdUswMGFSVkFqSzZXaGlZMzVU?=
 =?utf-8?B?WEZhUlliamprc2E3c1pSWXZLbVdHZ2ZmYnJZaHlIQkt5YTY1eDQ3RGNqNEdL?=
 =?utf-8?B?elFmVERvNUp4eVhSaVdFK0ptditPQit3VjhLK1RLcE9Ic3NnQTBPN2pBdFRG?=
 =?utf-8?B?SnJJRUFnN2lDSTBYK0hvaUM3MzI2QnhzMkFLTWxjM3lYbWhwYU83VkhQOFBJ?=
 =?utf-8?B?SWdKeU9xUS91UWZ1d3pNb2s1eG5YT2VhTFJrb2FuQWhLWG1yd3VTQU9DZDlF?=
 =?utf-8?B?QVBFUUsxZVJ6bDB2SC82Y0RoVG51Y0syOTJ6T3krTEtqNmk3VDMyb1pvYy8r?=
 =?utf-8?Q?UvLmWrnsE8COu0+hpjVzvsqrO?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81acba9a-5fce-4e8e-f14b-08dc219f3b4e
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:24:55.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBgCoJY8swesRenPvqBpNn07ADudXhRkcZDLV3/tC8E5bHrabm+Ff+MRHueJrTknu5VqQ4MJymJ6V7+8gKxh5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3208
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28150.006
X-TMASE-Result: 10--31.785700-4.000000
X-TMASE-MatchedRID: CxmI61mtwh/5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xLlNADTSrHglTuZ
	WVpyOB1LVzHse9CYvzo7W/khy4vNhf727BwjV4sgT2N9f7QZ4R0RPnpJog/Uz3miaGC762CciHh
	ODD/HIXz8uK7tI6WQN7Hp+ukkV/8w09nYz+wyqA5SU7TOghylToHV87ajhAZw0hs/U79L1DD0UU
	/ZFaEzICRF+Q8qR9T8NlPiyT8hATAkxabL55z03lY9XYa1m8xAGfP6Q7XnYodheY1N9xOffrxaM
	a1kAGYhJ2Nk77IIWV+YwjbC/U0+cLAJXCNoz8gyTrdOFVVqainWRI6+saz/4VVdLTpjOjLlSNzO
	YgASIP5HA/7cS3KeMSr2hxXhS3LSUDUnbg68kh870BtMXRaQwtUusl/JVaRNiU3JMy6tCJITl3/
	mhBEIUtZAHrKQNoq5xc264QiGYjlfFvtSiUAGS1ssdJQrqxMaw5bnOAWH72uJ3Smid9WN/ahbct
	RzB61eLf5MGGJoSOZpQdt9muwTS2r8kU5yFrmDBA/ZR5qnp8OVmuhG06IIbebiR+ph1AkZcQlrV
	/lZI43VVW3SFJFaxlWpx+nc5pfG/cRTkguDiskLOnhkOkWpfZFx8VBGp0H2yBFcP7Tck4RkNMeI
	pC0w4wQg0CprpXujLYBGSVB3O+VgZw7RGrHRIIi/ka5VrHsK7IrgV0SwVkJZXDFIyx+E3reRXHt
	yxdEo1bRq8PVqhTWXoSkQ5SrGCmi35z3YjiKbOc/clmqx05qdB9ulhzDIqQqy8n1THKP4jf5DCg
	gX0H3YSGScrn2pY152iG36UfaeBzU/Sx9ISx3FTQGAKRxj5No+48giqZwnEgg3cwDHl/1O85Jco
	T0w/UBsgczR0d5Pv9rSd36EgUI+Mqg+CyrtwA==
X-TMASE-XGENCLOUD: 82b90ce4-7e85-4189-8fd3-56917dd6015c-0-0-200-0
X-TM-Deliver-Signature: 5DD67A967767F8114A8F965D545ED091
X-TM-Addin-Auth: hJEdWqAwg4C/6xtfqoODA6M/ZaU+GnVibVmM1JMZW9Fw8/afdrlfSMIhD0o
	J5yAJZ3nVbg/rfg8OfrSScUNlSmo4SgqxMCGSFKgLUN+R+tHe5OFil6quARonMgoTgXqNEwv2TJ
	5SU8L/RtbsPKKQUF5bBUWY0esoCnAp5xLWTEGdY7P7ic4+x9EpC+FC0i8MgDGQ4kgcprHxYV1J7
	pdvY5f23j8Nb+3UmNpb5LYWM0m5yJ8DfCQueNAwvOOgViDH8hNZ6PVxEHXxmDY9vBdAY/+YIYDq
	gPiZSdf/Ov7I1Lg=.IRRIDObMM9cHkwVMFI5c0/x/gn9SBrAzNi98XdXrORmH4+x3zfRRGx6JtE
	9Ki256RnEI+aLRzKGQy2lGDW59g5nDTOFYj7MGfEgA10d2w+/PJgOgyWnfXnd7SX2CPzdFvAznA
	AEox9R6jF06/AQqmEXO5K4HOxxlhjifnyHTcUuiVexSP1rtOgLmIWpAtSW9mBcm7e3Ecll+mWqI
	zvhSMx6L47+0BlgD9XLQyt3k4S6Gkpw3ksEkOSADNCFCC6PhQINMVZ2yCFsN0tOvMWuILvWFZeQ
	TQmtP4lJxhCUSRrrrYW8fIbCS/nYRnib64lP6n/UCI9DJdMHYbCfQneDdUA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1706624699;
	bh=yyocJPbTVJZO37d3VV9a4L61daiLnXEgIDNEgjCTO7s=; l=17327;
	h=Date:From:To;
	b=jRYhblbYJjxpza7Mk7l1X7GM9f6OnQICQDIZg3Uddki0POnIncL4zjIVt5jMey404
	 YBQ+faBjnr0qlgAxT7noYktRKEg8vmyivu8UDagPut75c7JrS2xAO9Jy2NMw8LOjJa
	 rZhuj87/Z18awz0BkEiVvnqHf38BzJT8H0M/jG5xWHdWE5qOq4ETd84qehF50m89Im
	 P9hp8iegNgNWv4F83+9m8gRe3MCgv/nJ/0DZroeYHQkrd3pUZ0U2Z3humQJ40XQpEf
	 jipJMDSTboPGT0rjjJAduTA9u+e7XkK0cVxWu5Sp0wIyzVmzc2Ov5ecf6XYEfGs1OV
	 otDU74h92EPJg==

Hello,

On 29.01.24 08:06, Viresh Kumar wrote:
> Hi Harald,
>
> On 04-01-24, 14:01, Harald Mommer wrote:
>> From: Harald Mommer<harald.mommer@opensynergy.com>
>>
>> This is the virtio SPI Linux kernel driver compliant to the "PATCH v10"
>> draft virtio SPI specification.
> Its okay with the RFC, but later on, please remove the versioning part
> from the commit log. All such information can be added to the cover
> letter.


For the future. This driver needs to remain RFC at least until the SPI 
specification is accepted anyway.

>> Signed-off-by: Harald Mommer<Harald.Mommer@opensynergy.com>
>> ---
>>   drivers/spi/Kconfig      |  11 +
>>   drivers/spi/Makefile     |   1 +
>>   drivers/spi/spi-virtio.c | 430 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 442 insertions(+)
>>   create mode 100644 drivers/spi/spi-virtio.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index ddae0fde798e..f4f617c79ad7 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
>>   
>>   	  If your SoC supports SCSSI, say Y here.
>>   
>> +config SPI_VIRTIO
>> +	tristate "Virtio SPI SPI Controller"
> s/SPI SPI/SPI/ ?


Will fix.


>> +	depends on VIRTIO
> Maybe a "depends on SPI_MASTER" as well ? Or "select" ?


This depends clearly on SPI_MASTER so something has to happen here.

>> +	help
>> +	  This enables the Virtio SPI driver.
>> +
>> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
>> +
>> +	  If your Linux is a virtual machine using Virtio, say Y here.
>> +	  If unsure, say N.
>> +
>>   config SPI_XCOMM
>>   	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>>   	depends on I2C
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ff8d725ba5e..ff2243e44e00 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>>   obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>>   obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>>   obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
>> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>>   obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>>   obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>>   obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
>> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
>> new file mode 100644
>> index 000000000000..39eb38184793
>> --- /dev/null
>> +++ b/drivers/spi/spi-virtio.c
>> @@ -0,0 +1,430 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * SPI bus driver for the Virtio SPI controller
>> + * Copyright (C) 2023 OpenSynergy GmbH
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/stddef.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_ring.h>
>> +#include <linux/version.h>
>> +#include <linux/of.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/virtio_spi.h>
> Alphabetical order is preferred normally for headers.


Did not know, can do. As long as the compiler does not overrule me, of 
course.

>> +
>> +/* virtio_spi private data structure */
>> +struct virtio_spi_priv {
>> +	/* The virtio device we're associated with */
>> +	struct virtio_device *vdev;
>> +	/* Pointer to the virtqueue */
>> +	struct virtqueue *vq;
>> +	/* Copy of config space mode_func_supported */
>> +	u32 mode_func_supported;
>> +	/* Copy of config space max_freq_hz */
>> +	u32 max_freq_hz;
>> +};
>> +
>> +struct virtio_spi_req {
>> +	struct completion completion;
>> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
>> +	const uint8_t *tx_buf			____cacheline_aligned;
>> +	uint8_t *rx_buf				____cacheline_aligned;
>> +	struct spi_transfer_result result	____cacheline_aligned;
>> +};
>> +
>> +static struct spi_board_info board_info = {
>> +	.modalias = "spi-virtio",
>> +};
>> +
>> +static void virtio_spi_msg_done(struct virtqueue *vq)
>> +{
>> +	struct virtio_spi_req *req;
>> +	unsigned int len;
>> +
>> +	while ((req = virtqueue_get_buf(vq, &len)))
> Do we really need a while loop here ? Since for now we are
> transferring the messages one by one.


Not strictly needed here yet as there is still this restriction 
transmitting messages. But we all know that this will not remain that 
way for too long, there is also no bug here so I prefer to keep it as it 
was done in virtio_i2c_msg_done().


>> +		complete(&req->completion);
>> +}
>> +
>> +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
>> +				   struct spi_controller *ctrl,
>> +				   struct spi_message *msg,
>> +				   struct spi_transfer *xfer)
>> +{
>> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
>> +	struct device *dev = &priv->vdev->dev;
>> +	struct spi_device *spi = msg->spi;
>> +	struct spi_transfer_head *th;
>> +	struct scatterlist sg_out_head, sg_out_payload;
>> +	struct scatterlist sg_in_result, sg_in_payload;
>> +	struct scatterlist *sgs[4];
>> +	unsigned int outcnt = 0u;
>> +	unsigned int incnt = 0u;
>> +	int ret;
>> +
>> +	th = &spi_req->transfer_head;
>> +
>> +	/* Fill struct spi_transfer_head */
>> +	th->chip_select_id = spi_get_chipselect(spi, 0);
>> +	th->bits_per_word = spi->bits_per_word;
>> +	/*
>> +	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
>> +	 * cs_change field does, this will not do the right thing."
>> +	 * TODO: Understand/discuss this, still unclear what may be wrong here
>> +	 */
>> +	th->cs_change = xfer->cs_change;
>> +	th->tx_nbits = xfer->tx_nbits;
>> +	th->rx_nbits = xfer->rx_nbits;
>> +	th->reserved[0] = 0;
>> +	th->reserved[1] = 0;
>> +	th->reserved[2] = 0;
>> +
>> +	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
>> +	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
>> +	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
>> +	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);
>> +
>> +	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
>> +					    SPI_CPOL | SPI_CPHA));
>> +	if ((spi->mode & SPI_LOOP) != 0)
>> +		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
>> +
>> +	th->freq = cpu_to_le32(xfer->speed_hz);
>> +
>> +	ret = spi_delay_to_ns(&xfer->word_delay, xfer);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "Cannot convert word_delay\n");
>> +		goto msg_done;
>> +	}
>> +	th->word_delay_ns = cpu_to_le32((u32)ret);
>> +
>> +	ret = spi_delay_to_ns(&xfer->delay, xfer);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "Cannot convert delay\n");
>> +		goto msg_done;
>> +	}
>> +	th->cs_setup_ns = cpu_to_le32((u32)ret);
>> +	th->cs_delay_hold_ns = cpu_to_le32((u32)ret);
>> +
>> +	/* This is the "off" time when CS has to be deasserted for a moment */
>> +	ret = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "Cannot convert cs_change_delay\n");
>> +		goto msg_done;
>> +	}
>> +	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)ret);
>> +
>> +	/* Set buffers */
>> +	spi_req->tx_buf = xfer->tx_buf;
>> +	spi_req->rx_buf = xfer->rx_buf;
>> +
>> +	/* Prepare sending of virtio message */
>> +	init_completion(&spi_req->completion);
>> +
>> +	sg_init_one(&sg_out_head, &spi_req->transfer_head,
>> +		    sizeof(struct spi_transfer_head));
> sizeof(*th) ?


Yes. But then in the form sg_init_one(&sg_out_head, th, sizeof(*th));


>> +	sgs[outcnt] = &sg_out_head;
>> +	outcnt++;
>> +
>> +	if (spi_req->tx_buf) {
>> +		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
>> +		sgs[outcnt] = &sg_out_payload;
>> +		outcnt++;
>> +	}
>> +
>> +	if (spi_req->rx_buf) {
>> +		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
>> +		sgs[outcnt + incnt] = &sg_in_payload;
>> +		incnt++;
>> +	}
>> +
>> +	sg_init_one(&sg_in_result, &spi_req->result,
>> +		    sizeof(struct spi_transfer_result));
>> +	sgs[outcnt + incnt] = &sg_in_result;
>> +	incnt++;
>> +
>> +	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
>> +				GFP_KERNEL);
>> +
>> +msg_done:
>> +	if (ret)
>> +		msg->status = ret;
>> +
>> +	return ret;
>> +}
>> +
>> +static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
>> +					   struct spi_message *msg)
>> +{
>> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
>> +	struct virtio_spi_req *spi_req;
>> +	struct spi_transfer *xfer;
>> +	int ret = 0;
>> +
>> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
>> +	if (!spi_req) {
>> +		ret = -ENOMEM;
>> +		goto no_mem;
>> +	}
>> +
>> +	/*
>> +	 * Simple implementation: Process message by message and wait for each
>> +	 * message to be completed by the device side.
>> +	 */
>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
>> +		if (ret)
>> +			goto msg_done;
>> +
>> +		virtqueue_kick(priv->vq);
>> +
>> +		wait_for_completion(&spi_req->completion);
>> +
>> +		/* Read result from message */
>> +		ret = (int)spi_req->result.result;
>> +		if (ret)
>> +			goto msg_done;
>> +	}
>> +
>> +msg_done:
>> +	kfree(spi_req);
>> +no_mem:
>> +	msg->status = ret;
>> +	spi_finalize_current_message(ctrl);
>> +
>> +	return ret;
>> +}
>> +
>> +static void virtio_spi_read_config(struct virtio_device *vdev)
>> +{
>> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
>> +	struct virtio_spi_priv *priv = vdev->priv;
>> +	u8 cs_max_number;
>> +	u8 tx_nbits_supported;
>> +	u8 rx_nbits_supported;
>> +
>> +	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
>> +						     cs_max_number));
>> +	ctrl->num_chipselect = cs_max_number;
>> +
>> +	/* Set the mode bits which are understood by this driver */
>> +	priv->mode_func_supported =
>> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
>> +					      mode_func_supported));
>> +	ctrl->mode_bits = priv->mode_func_supported &
>> +			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
>> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
>> +		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
>> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
>> +		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
>> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
>> +		ctrl->mode_bits |= SPI_LSB_FIRST;
>> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
>> +		ctrl->mode_bits |= SPI_LOOP;
>> +	tx_nbits_supported =
>> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
>> +					     tx_nbits_supported));
>> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
>> +		ctrl->mode_bits |= SPI_TX_DUAL;
>> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
>> +		ctrl->mode_bits |= SPI_TX_QUAD;
>> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
>> +		ctrl->mode_bits |= SPI_TX_OCTAL;
>> +	rx_nbits_supported =
>> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
>> +					     rx_nbits_supported));
>> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
>> +		ctrl->mode_bits |= SPI_RX_DUAL;
>> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
>> +		ctrl->mode_bits |= SPI_RX_QUAD;
>> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
>> +		ctrl->mode_bits |= SPI_RX_OCTAL;
>> +
>> +	ctrl->bits_per_word_mask =
>> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
>> +					      bits_per_word_mask));
>> +
>> +	priv->max_freq_hz =
>> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
>> +					      max_freq_hz));
>> +}
>> +
>> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
>> +{
>> +	struct virtqueue *vq;
>> +
>> +	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
>> +	if (IS_ERR(vq))
>> +		return (int)PTR_ERR(vq);
>> +	priv->vq = vq;
>> +	return 0;
>> +}
>> +
>> +/* Function must not be called before virtio_spi_find_vqs() has been run */
>> +static void virtio_spi_del_vq(struct virtio_device *vdev)
>> +{
>> +	virtio_reset_device(vdev);
>> +	vdev->config->del_vqs(vdev);
>> +}
>> +
>> +static int virtio_spi_validate(struct virtio_device *vdev)
>> +{
>> +	/*
>> +	 * SPI needs always access to the config space.
>> +	 * Check that the driver can access the config space
>> +	 */
>> +	if (!vdev->config->get) {
>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>> +			__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> +		dev_err(&vdev->dev,
>> +			"device does not comply with spec version 1.x\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
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
> I thought you agreed to drop it earlier ?


Tried to do this. But I've to maintain a driver version which is not 
based on latest, our internal master from which the public version is 
derived. So there is code which still has to free resources, you just 
don't see it. Was not happy when I realized that I have not yet 
devm_spi_alloc_host() everywhere where I need it.

In this code there is

#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 2, 0)
     ctrl = spi_alloc_master(&vdev->dev, sizeof(*priv));
#else
     ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
#endif

...

err_return:
#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 2, 0)
     spi_controller_put(ctrl);
#endif
     return err;

Either using goto minimizing the number of #if in the code or getting an 
unreadable #if mess in my "master" implementation which needs to be 
compliant also to 6.1 and even 4.14.


>> +		err = -ENOMEM;
>> +		goto err_return;
>> +	}
>> +
>> +	priv = spi_controller_get_devdata(ctrl);
>> +	priv->vdev = vdev;
>> +	vdev->priv = priv;
>> +	dev_set_drvdata(&vdev->dev, ctrl);
>> +
>> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
>> +	if (!err && bus_num <= S16_MAX)
>> +		ctrl->bus_num = (s16)bus_num;
>> +
>> +	virtio_spi_read_config(vdev);
>> +
>> +	/* Method to transfer a single SPI message */
>> +	ctrl->transfer_one_message = virtio_spi_transfer_one_message;
>> +
>> +	/* Initialize virtqueues */
>> +	err = virtio_spi_find_vqs(priv);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
>> +		goto err_return;
>> +	}
>> +
>> +	err = spi_register_controller(ctrl);
>> +	if (err) {
> Remove virtqueues here ?


Indeed missing. I guess

   vdev->config->del_vqs(vdev);

is still my friend here.And not only here but also below, so new label 
"err_return_del_vq:" to do it centrally at the end of the function.

And what is also to be improved here is the spi_register_controller() as 
I should better use devm_spi_register_controller() to get the resource 
de-allocation managed. Another #if in my "master" implementation but 
I've to live with it.

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
>> +		/* TODO: Discuss setting of board_info.mode */
>> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
>> +			board_info.mode = SPI_MODE_0;
>> +		else
>> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
>> +		if (!spi_new_device(ctrl, &board_info)) {
>> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>> +			err = -ENODEV;
> Remove controller and virtqueues here ?


"vdev->config->del_vqs(vdev);" is missing => goto err_return_del_vq;

Not sure about controller. In my internal code also for older kernels 
I've a

#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 2, 0)
             spi_unregister_controller(ctrl);
#endif

and at the end of the function a

   spi_controller_put(ctrl);

but nothing of this here as reading the comments

devm_spi_alloc_host() => __devm_spi_alloc_controller()

" * Allocate an SPI controller and automatically release a reference on it
  * when @dev is unbound from its driver.  Drivers are thus relieved from
  * having to call spi_controller_put()."

no spi_controller_put() with devm.

Using devm_spi_register_controller() instead of the bare 
spi_register_controller() above it should not be necessary to do 
anything with the controller.

>> +			goto err_return;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_return:
>> +	return err;
>> +}


