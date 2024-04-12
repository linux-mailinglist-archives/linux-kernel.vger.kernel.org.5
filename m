Return-Path: <linux-kernel+bounces-143285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27488A36C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DC61C20917
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C91514C4;
	Fri, 12 Apr 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="Lv+cgkxR"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FA14F9C6;
	Fri, 12 Apr 2024 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952604; cv=fail; b=p2245WgCLGd7NfcMhkuid379MTT0Gtj63d4txAzFkM2tqiDIHJmtu5i/2o+5sMGqz9ilHfk8RM5/IvCDrQmzpw1i08mIIFPnUqEpdZo3zoWBssucAKYjB1R7JPQdee2sXwUyX4H+WAyPqFDE4dTBJEFx4kf6bb5PIdvJ1sXnftM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952604; c=relaxed/simple;
	bh=nYAOz/3dAAT3cG2dG3NSw8UXKNCX1sx4RfBp++CiscA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6Ja4aUiQ4mMcCcGDQB6hwqGNOdzfqmyXpZ74h3cDish1a0K5hGG9wIN70NXcNWdHpPqehVaOMaOMjvdNp0OzfrBPIre/IQjfWOs+hL7Z1QwG+c/7+3mgvlYXvmXCF+qOVyhYXte1TcVCQECwuUff9YpEI7Pt6Is5C08VZvLtqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=Lv+cgkxR; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CF72ss000638;
	Fri, 12 Apr 2024 20:09:56 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xf7akrqpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:09:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSpT75rjFYR7sd4sx0qxG16jCML+zvJCx3AFpgZKTsKqkirT+fsChm+UvYxA5FnkuPoCWRnjFrnctQyznS4YzbVA0WxnLFzx0oRuKjeACRJgOaC5+XXbrypg7VTwJ73espetiU959Ow0nXIpU0DXJFFSd3+k5icMm+IwUX3Qh35p1eCivxbA0Zin0mNIR+xTc2B5zis3q25cnQStZXKILWbpS2Kc1Eg4/IePkBW76ZRARPSGI9GKRoAIv4Ts6pbeHi3+NNQHHimho5wdhxIUbar7MxE4cI0mvtBXVBQWRs3qk/estelWddFHIe7aKo8NCo3PH6c4w8rTCJr6J1NMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i3go217MqoJEEUtyON4663MtszgYxGVfLz4+ZcmhyE=;
 b=NHvZPwiXPYHGJ53fdzUbeA2LZ1dP1Kf6+g0DGEq39Gv3U12iUkQurW2DPcO1gdov9SVHkMr+RqDjFkk5YMCqSo4KGjo/S8qtJ+LDfwr2FzF1gV3u6f5W3Tb0Sqe/w02nA3d6VLgCXh6J5KS+46RcIYOXUtZo2yeQ146roUXnjPwTkGzbjxo2WgV5jmp1EyFG/cgZL05zfW24f2NmCqWJD+Re3q/O91OzAHXto2je6k8xIOYwEN+1sikS3/RA//5YEIDbWUwmlYtfuz4zA3zzi+p3dL31kFU1+QfEvd7ZxYeZXmb9RFqQGAHlqBLJA3DpPTaZvzVZGhNOVJN8RTtJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i3go217MqoJEEUtyON4663MtszgYxGVfLz4+ZcmhyE=;
 b=Lv+cgkxRYwlSLWxUDxaEfyXxf1NlO9MRNA2fH1IlIYEH//iCsS6qNV89kENXV6mbMWd4yxnzcTuu0OH/69i26q8iG+3cq1Zecmbw8MwkE2oOVHlhQSKI/zd2DWdfj69+Rvad0EJ4FhNL6q98E7Hw1+KhDeaEUZ8+qlLowCB81kWIIhtKPPQ3ggc3R5l49bFIXlfs44JSwroDqBDX9yl0b9W+h9xCM0SmifW8Mz5c0ZdjcdGrffQmhDgd3brO+Ua7IxhDl4TCxs/SJuZGumxY/NLgdGJGHtzrS4qAkCPz2e8YRbWp2SOp5M4g8v7MWp6yA1vdFFUNC6xCv+eMKFuj2g==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by AM9PR03MB7346.eurprd03.prod.outlook.com
 (2603:10a6:20b:26e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:09:53 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:09:53 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Stephan Gerhold <stephan@gerhold.net>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for
 L13C regulator
Thread-Topic: [PATCH v3 2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for
 L13C regulator
Thread-Index: AQHajQwZoNf3a+cEJ06mugQP75YLSLFlDAYAgAACL4A=
Date: Fri, 12 Apr 2024 20:09:52 +0000
Message-ID: <87o7ae4a28.fsf@epam.com>
References: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
 <20240412190310.1647893-2-volodymyr_babchuk@epam.com>
 <ZhmRJPAZUSlc1CSH@gerhold.net>
In-Reply-To: <ZhmRJPAZUSlc1CSH@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.3
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|AM9PR03MB7346:EE_
x-ms-office365-filtering-correlation-id: f5a1ad5b-ae62-42a2-2284-08dc5b2c83f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uluxOA0Avj+4v+lYn0fsfsFOe+RXhqCCqhZhp+kEIHhmSjmmz32OFepLUSFl12dsQvgNyNPNlmnccq+bMSnXUOF1krQ4F1ean6zVwZH85fUYIRy2e3sBb6NOEHNJ3iApBqm9rL+auYwVfRaAXiK1oE9uk1TAVV/HZOctoXsHadZlGscG/mhBPAmdThjC10Dr35L3Nnxb1ORJdC2FZJvxbqvvgbJpDijZvywNzgEG/rSg5FjmkptazPqAnUq/uFJQsS+RCZQb14ZyOlQVExnwZbfwjJhBq8RdL3Zf+Jr/x4bo3IPh/8Gc06jwURQVlQijN+hFZ1wYjOtDPOPa9dGpMXeLIDXCh54dlqfr3DF7mftVd+zJI2de8ro7LEGb3Zpd8OuiA98G1SCCzeh9tDKKnVQjlOX8E9njCgTKM98V9qHAEKLIMCFgmBTv9Rbe6ov+UXR5bdLgZbVUZ5gV+8+aiZe2MLDu2pmIWvMXSS/4+lhCxRja8lOShvxEAIgynjcHD8P3joAoaeJFrzfSd6Ooe6yRRB98xv4UypWYot58slnJcsmjoTTdVf4hiGe9wr0I1WaU9QJQGJJHlFxsBlMuq5hX153yd/FYONJsriXJyQz9lWl+vJXuS9WGsAwqUi/jl5FZ3twuECjBjftiACQSmZKbhj4ayyqObmhHlwV7iyXcGt6EUEw1nsqBIWEian/ynlS5SumNzrvhl4gNUDPQPilyopY2bwwu0bG8NI7Uub0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?MuQHwq8tYv3Me2LP7c2r1RKFNMlmvlin0DnIOxWtSi7DKvqpqHUcfZxwH8?=
 =?iso-8859-1?Q?2bkENgxE1/C30psNQCrLVas7WHsoApLSH7tHrh/lTTLYTLyccaAKR6GE+e?=
 =?iso-8859-1?Q?zGpwhPowZ90YGDBNa1ICLHYOH4SBzeY3sPhXhtPIHTU7PeoVRWduCwQjsA?=
 =?iso-8859-1?Q?sGHzzk98TLopYqDYvlIr5OUGgWok3HNx+kJDrvUApU4kOjhvNvc03qRf0H?=
 =?iso-8859-1?Q?+v9uxlGvN+t4eX27RzXSTtjFSUuc8C+oHfB+mICRWA6a5D7OPFIZs1LACU?=
 =?iso-8859-1?Q?Tb/n/1aNv9+JkfJpoxSmuZIEqya0QEQFy4+i4IFnHshJCoNhqtYBHygdZA?=
 =?iso-8859-1?Q?ZMjthsgE6azfrmmSu9VOyxl9ySDK5LvqfAp6yYXTUoeWVt64Ygj6o764zl?=
 =?iso-8859-1?Q?jyrkpTJkTQ/dOPQLzNbG9VVrpITQEAmaPIgsRmMiMz1x2mqXS3UQX9ha4q?=
 =?iso-8859-1?Q?mCTiImI1zG+9liiReZNAJ38ZQdH2SPrpBn35Y6xkqdWMwreF5CUxMO88IG?=
 =?iso-8859-1?Q?hdZ8E3NnXBtASYXP7izqLr76rQdIc7FhfsqUiLLQIjHbsAb0EEMiSzNRBq?=
 =?iso-8859-1?Q?2tK5Tg1Co+x8uBipmK5pJNOYnze7R6/F0d3MW1L7am3wxZ6lTDVe/6Pk6a?=
 =?iso-8859-1?Q?APL5TUwTG72/so46nD6ugFYqSvVO3ZppeNpeVObAGTSfJpwkIqDppo5hDy?=
 =?iso-8859-1?Q?MAwjIhiMPJsfLuyJyaKMYUNuZD0XOeSA/WISXRfglznWD/XE2K9I3WEKCS?=
 =?iso-8859-1?Q?t4aRPIoxMpP9/OUQcvcGqBRfUQ5TJYh4Cbgl6qYsp/TRI3YAMAo4G/kRO9?=
 =?iso-8859-1?Q?1hsoCndjLclI/4x/DbgZYkGtOIyErYIZKrTNSA666iB/AhIXPjUJyYicRd?=
 =?iso-8859-1?Q?0YpThUy2npHshCqJliUtFbE0V8vzdLIGmX8kRKXoMAlpJp6kGDFXgNj8Fr?=
 =?iso-8859-1?Q?9aCErELiBnzFRFD9IuMEPmO4kYIhNf+gigizKBHjD4aYg/W+F93o2FgLyS?=
 =?iso-8859-1?Q?o5Bk4DNAODIDdHR+TPnDraghif2Jtq0HUBRZLbOftCmWiyw1yD+fTTcrd2?=
 =?iso-8859-1?Q?hTLvBWBwbw1HLW1n7go+dBA3ANiFi5Q3YiqrX87IiDCJ/F0LVEpWV2Geo7?=
 =?iso-8859-1?Q?+iPosWlUcsPW0CXPNgRbhaqXUB8/OvNWRebGB5L/4UtQDXaNi2wNM8y0MO?=
 =?iso-8859-1?Q?/W4BH8LBdloLC5mNKM7FDW6hDudF00Vv66M5B0uegfSLSekLUQ/YFlVAKv?=
 =?iso-8859-1?Q?CflgeDcajICQXHoA4fT9wb4lu+qpDnf96xWPOI/bQt/cYR/XDZPwUSkA5b?=
 =?iso-8859-1?Q?CIyTiZMWZjrGeoLufaXsE1A4gYcxbep8PjeTZPt63lcwE9TY17sfJh2zte?=
 =?iso-8859-1?Q?7pPhmrcSpfkZpa+EfyvB44w6S5AmDrRfXj5DRnwp4K3MFpmn3LvUQRYM7W?=
 =?iso-8859-1?Q?ZBpIyVPdFfc/HNvV9kVng2csMIhuPcOar2ol7B7v6r9w9d7rHPkhBmu267?=
 =?iso-8859-1?Q?XfbttVPjA76JK82IUS/tHpiM+kzyvs3djv4gST/zBnuuGTfWeg2iVZXLdY?=
 =?iso-8859-1?Q?LgbPL55LCQX+CbXHNSrORBek25daDwIuKndZnHQ0soIMYv7GvKdLmrLnEU?=
 =?iso-8859-1?Q?wRYwT9AndoxphqDoE2LrWRivEGuwmtZrSEGWJv0+9TPIszTKaMpCGqfw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a1ad5b-ae62-42a2-2284-08dc5b2c83f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:09:52.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4m2nmIUMMl4QcapwMJI8jXTGuMOHgSbuZTz5CNCWb1AmrpS1PkdNjyum24HS3Y0KO6KTUVj35vJLUrmC5RA7pjvG0gzYsmegIX5xuRULeDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7346
X-Proofpoint-ORIG-GUID: LakDU9FHbWQqbOo2g-bgZrb2CwAqYKmw
X-Proofpoint-GUID: LakDU9FHbWQqbOo2g-bgZrb2CwAqYKmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_16,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=697 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120147


Hi Stephan,

Stephan Gerhold <stephan@gerhold.net> writes:

> On Fri, Apr 12, 2024 at 07:03:26PM +0000, Volodymyr Babchuk wrote:
>> Voltage regulator L13C is used by SD card IO interface. In order to
>> support UHS modes, IO interface voltage needs to be set to 1.8V. This
>> patch extends minimum voltage range of L13C regulator to allow this.
>>=20
>
> I think this one also deserves a Fixes and stable tag. One could argue
> that enabling UHS modes is a new "feature"

Yes, this was my reasoning, actually. I reasoned that the initial commit
("arm64: dts: qcom: sa8155p-adp: Add base dts file") was not obliged to
set voltage ranges correctly as it didn't enabled SDHC2 support. But you
are right,  0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support
for uSD card") should have this change.

> but I would say the original
> commit just missed setting the correct voltages with the intended use
> case. I doubt limiting to high speed was intended.
>
> Maybe also add a Suggested-by tag from myself:

Yes, sorry. I should have asked about adding your Suggested-by tag before
posting this change.

> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD =
card")
> Cc: stable@vger.kernel.org
> Suggested-by: Stephan Gerhold <stephan@gerhold.net>
>
> I believe you do not need to resend just to add these tags, the b4 tool
> should pick them up while applying. It looks like this might not work
> for the Cc: stable tag though...

Well, we can send separate email to stable@vger.kernel.org after this
patch will be applied... I believe it is better than posting v4.


--=20
WBR, Volodymyr=

