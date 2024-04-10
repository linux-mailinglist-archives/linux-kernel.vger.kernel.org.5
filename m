Return-Path: <linux-kernel+bounces-139411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55398A02FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156371F233C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ED5184124;
	Wed, 10 Apr 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="dnO4TBOX"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406541836E1;
	Wed, 10 Apr 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787173; cv=fail; b=q6HelltYBXWJTqOgI9UWluvhoOzGjxLhXKSUti6rOAd6F7KJVQYaYsXzh7xo6V8rn5ivwHjbmCf8kA4xl1tG+OUtBqmCp5vcXHir7+Pv15jG5cV6kZSFSjVMDaGVF+Bjhp3qJ/+IM4IMawtkqcv+jg3ZRNSQs1w2UHFo7bFByio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787173; c=relaxed/simple;
	bh=GNklBXMB2915mdKj9oWv0O0D83za3xsMfxAOpBl92h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WoUJts4v/eeq8fo7itnDbkY8cllgfJNLCjz8rtRDVEXAreysLfuwG17KKWxYfpEg3dV/OjSeEbKgiPtKTX6DDbAa/2sNKkLH1WwG3kMMkCnx48urRQpiqhbHpYXXs2KtFOK8TPLMKVeIXG7e+UsLnIwPy9mJ5XdOMGPrLL4SNak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=dnO4TBOX; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AI5nhW025166;
	Wed, 10 Apr 2024 22:12:41 GMT
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02lp2233.outbound.protection.outlook.com [104.47.11.233])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xdyre0e3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 22:12:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9sn2vTVU2p6Oh5b2dsDjoXV84c8CoOjO4yk9x1Amfi0VPgHUvuv8R6kTw9EK6KA0BO7jdda6HX0ZR0D+QGFraUs++noH3piqaNnAM1oKeQyz1XFcmBXI4uWlCbRSsOSryZ6mYNpbBY9SyDfzSPvdibrviihTKRNEpOZxQpcrp3nCQhOv4mBNu2hW5EdzpHKG0kPlwtG7A+7/4fYEEWXRFPq6iPBj68DCvVnLNG705gwm2kdkP8eOWO0+2TfBw/1elvBQG/6l8f01VYrlRNePuIRk5x7/zFC/765kDkxCbz0aJAun3AZRqTGHNRt0f0FnzgvFz7JnBT0QhXZ3Wed4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNklBXMB2915mdKj9oWv0O0D83za3xsMfxAOpBl92h0=;
 b=Q4lSJ0RImjfpscoqj1fm3vVd+pB12ioNieBYcDk91NwafxQLri6iTEhk43GyD55BPQqA7llg9dSt1RoH8YvIxwarQIDr8Bf/RFVPhirSq6HOmFVMo7/jbcx3WkH/LEjBl74nzdSq43Th/FgqrqGCDUu493eGKCKDv1KeCmJBDLDJR4ZaBECOtBO7QXuhuQIJHFVPEt18EJ1O6COMPGAYwOJnPTi7ZomxOFNu/fz7UvspxOl0vf3HD4br8KmdICvP/e2iElR+CFJWEYMxhG+WoK9QD4zBB42R8+eke8rvhV0U4+QLCRHyxD0AeG7kd43bO7iv2o8WEPTu6X3JBRso9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNklBXMB2915mdKj9oWv0O0D83za3xsMfxAOpBl92h0=;
 b=dnO4TBOX1J0ppUKYL/Ujuq7wfOuuIA37O8U4vvqnDemr1PXrE8DT/rAuS9aBS0s/mJymRF6oaQ7g3LThr43Jc+gfvQmwo6HqVQnTasOcu2/y87RKX7Lzm0w8HuGwRIy+u420P2EHwPKc2Jj3Lj5qfBBiSwxak4r95SreCxend1C9Kjv0DYjzqRIRaxReFcRDYP+jxYZB9RTTitVphyrhmkpyeWsJp8kaXSid9F1EcLImA0I/s8Aifa6edDybTOZQOeWmfHGW0LuWIu42QGVSitus2Xjus883uPXupeei/zAAWWGAkWH5xJom6VsDx7I7pMkZ3hSXhX8yWJ2Ly/P40A==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAWPR03MB10069.eurprd03.prod.outlook.com
 (2603:10a6:102:34e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 22:12:38 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 22:12:37 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Stephan Gerhold <stephan@gerhold.net>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas
 Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Stephen
 Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Topic: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Index: 
 AQHagIKviCrPH112HEOpsjr5BCtYWLFMDkOAgAAEYgCAAAGHAIAAJ/GAgACv9QCAFTomAA==
Date: Wed, 10 Apr 2024 22:12:37 +0000
Message-ID: <875xwo6f57.fsf@epam.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
 <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net>
In-Reply-To: <ZgU_YDUhBeyS5wuh@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.3
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAWPR03MB10069:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pT0vlb/qUmp07EkiEnuAuRT5M3VfmMoi7dzxICTImHGmWmVelwmv5wjDjHuXCUJP7zOnHgH/4gjx5Dk9EkQLiHxEa85iqAVRF1F/EFZnvTQ1c1QXpGaNiT52obwj0Huyh1OJEuKU6X5BiwUeunonLn3Kr2/ZiYi61Fhx3rQ4LcpEXLLhqjzhkVHGThZrazeUVh7Lfg8vPWVvguHehf3kEYKk/nMgISJmzjfs4h+IwzZa0KZJch3+KaGLv7j/VR5Sa+eVX/BfZcKto6m20rNISfVf/Xf4M1tfQ2UAyRqwV6vJZ/GWuDeoPB3aknD0mqimlyBWr9twG0iibhWizHzQRQp4Pqo7j5sRunmeJKZTm1KNhoRzSq0dBjNCmCgv3i9fPvuI2l2Brx6D0t+8Dt6ver3Cr2Is5AA2Z/NcgyiLFpm4/bm9gjzMbAeek650hWowIdLuJwrI+9TwUXJW6O+sHNkOEsCTd3uL+l9aILtzE8PRTCIq+1DPR0LGTfULWSxoAwVfFDKwjpvsQMVhEtmOaOgnKwdmG+tQNjB4hjB3tO+i+LxDwkZKmYcc5dc2i0fYoDe8jG0DWYj7Zc9xD7NDouAg+w7tVgAFHb14LPT1N14z6rO8WpgZsYEO1NMXlZRdrzU3cV9WeqQFG4kSLR5h3/u3Ht68LMMFGfRCMJbyVcM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?3WAioogCKAqY8S0oIwbY9SU5opLtkra++9h17XyoXkSTHAuopUUHzjp8Fs?=
 =?iso-8859-1?Q?rlygshsmhKm+084REJM5RYXopw+4rco7AcmQCXtr4sJ0VnNT+DtZ80MW/p?=
 =?iso-8859-1?Q?ypuIbAoxOpZ1n1nOZXhP95lhmYbMnkM+uDDoagfoVPNUtplReY/YvZqRaj?=
 =?iso-8859-1?Q?GtbLmttITd+2A7n3rWnAYffTIPTPVTGLV+5ya4jzMTGEXm/TfdZFvX705N?=
 =?iso-8859-1?Q?40eXN5lAbS8hGZeIksWaFgoGtZalKwEQkH2XaFJ/7y4zDqVKcCw3onE9EU?=
 =?iso-8859-1?Q?KK12mtQcnaRsjbST/SE6OOhXNiYjnN0FS3gb72up1SHQe5UBL9MHBDV5fL?=
 =?iso-8859-1?Q?76/2ObFHRz+DHWHCoQKTXJNJRMXnZl7LEPP5PFhlZExF8Q7O6/yUUIY3Aa?=
 =?iso-8859-1?Q?IAgQaFpTcLAKTI3kSg8ALsQgVdJKZR7KQxsZtk4cH2QumWnVuBLxSKIvzZ?=
 =?iso-8859-1?Q?+zINX1Nm4mhbheFAVF0xB9ruszggHCjsMcLCgHuWxdcyCeols2MFKZb8gB?=
 =?iso-8859-1?Q?ZeBOH7wWQkSGIDxsq0CX/2GHmVBOOsKq1PoDSfZBJ1lst8eftQUzPI4s0B?=
 =?iso-8859-1?Q?aVDE8W8UMNJoNaZx2I40NuxMf5uA3+ttAKMvebJ81sQicUHeGJ6zcb3+Su?=
 =?iso-8859-1?Q?gstUu+RvAArcZRqtRlE69TLRjg0JSmc3gweDcDmx9gFVAwJE40558GIn2k?=
 =?iso-8859-1?Q?l6TFUB7igkZVF9AXYJtX5RHtMMX7MxwsVizqJnGLJD6ZTgji6xkYck9Jun?=
 =?iso-8859-1?Q?4uq01XLkrQOv3hwxrI0J3/VGdmka06swXnct69OqWfQv/QwJFp+tyIls8+?=
 =?iso-8859-1?Q?y1I/WPAucTs/nAkKiTO0xrtdSRCG9h1nNAUo4PqRodIFbM+BPdvLzF2y1s?=
 =?iso-8859-1?Q?tZDUH3LhkJ9byYn+suAMs218k9HYU+L2IsOKE8WfouGNnwfo+pndvLQUy1?=
 =?iso-8859-1?Q?4tFtB7pWQw9mU1ItiemWO2ItTXAhWbLVt1Y7rmQj+TMvSDH79Q8w82oG41?=
 =?iso-8859-1?Q?U7ts0NbzZ7ENZP5PgIRJJ4fETz/DpntuEpzNY6dfop3Pn8vl2LzBOGU3eh?=
 =?iso-8859-1?Q?DnPuRaW1wWmcEvAByabw/2U8aa99dUL3JvfltfTOiRai8LiM4jWODHkqC+?=
 =?iso-8859-1?Q?m+jo65hp5CaQQjtyuecZgAbEonyiEPJWkgbL5xsYyDe6RWgIgEJEXYymj3?=
 =?iso-8859-1?Q?JTQ8QnKMvTJrz9ubHXGGJ6i0tMRqzd+53Eyu1LNZhCCpmZMiL48jKzG8Tu?=
 =?iso-8859-1?Q?59WQ7DRc5NB/5HPocvQiBxnUdk+DUcPe/wKOC11T9199jKAiz259xz8X5R?=
 =?iso-8859-1?Q?G2j4qwh8xm7/iasNH3swCfiyMZTb84ASfwFpDKmpdlpaMMg+oIBs4v9tmP?=
 =?iso-8859-1?Q?yZa3UuPEFai0M+VN1fuk+4qcfr7Ht09G1To747O1tGtApgH2nKj8Uz84MW?=
 =?iso-8859-1?Q?2iwHjYNdEAOxcBnagK6RWt5Nv2n8vrcd7vuDTkMyHTG6+Ls3qNTL/4uZjE?=
 =?iso-8859-1?Q?bRfXEt5X6a+Ce9If5MO8Bo1q9/enFVGB08OE3WBNZtLia4goPdEGhtOzco?=
 =?iso-8859-1?Q?qoVjYIYytDPxc6K4Z9YddVSLn2I9ROgal6H+7V4LytuGK3wGIHpUHkdfEx?=
 =?iso-8859-1?Q?kPA4oQ21dGlXzsEKswLm6mV7BfUZyrx1dDwDZP2uWWB6Wt+Pdq3FGW+Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e2239f-abd3-4a26-1cac-08dc59ab54cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 22:12:37.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g79lc0xF3CT1l6VOWABPbzI88tdecouvFJsdfzLXV7sREqMeWvxBQrXIG8v70CT/ZNhcOw2plnBqjQsX1qufsFfalAnKruo9ad698VEAG/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10069
X-Proofpoint-ORIG-GUID: kv43q2z3bxBWsSn7IojoA3hSg0Cebx5m
X-Proofpoint-GUID: kv43q2z3bxBWsSn7IojoA3hSg0Cebx5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100163


Hi Stephan,

Stephan Gerhold <stephan@gerhold.net> writes:

> On Wed, Mar 27, 2024 at 11:29:09PM +0000, Caleb Connolly wrote:
>> On 27/03/2024 21:06, Konrad Dybcio wrote:
>> > On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
>> >> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
>> >>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
>> >>>> It appears that hardware does not like cacheable accesses to this
>> >>>> region. Trying to access this shared memory region as Normal Memory
>> >>>> leads to secure interrupt which causes an endless loop somewhere in
>> >>>> Trust Zone.
>> >>>>
>> >>>> The only reason it is working right now is because Qualcomm Hypervi=
sor
>> >>>> maps the same region as Non-Cacheable memory in Stage 2 translation
>> >>>> tables. The issue manifests if we want to use another hypervisor (l=
ike
>> >>>> Xen or KVM), which does not know anything about those specific
>> >>>> mappings. This patch fixes the issue by mapping the shared memory a=
s
>> >>>> Write-Through. This removes dependency on correct mappings in Stage=
 2
>> >>>> tables.
>> >>>>
>> >>>> I tested this on SA8155P with Xen.
>> >>>>
>> >>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> >>>> ---
>> >>>
>> >>> Interesting..
>> >>>
>> >>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chrom=
ebooks
>> >>> ship with no qcom hypervisor)
>> >>
>> >> Well, maybe I was wrong when called this thing "hypervisor". All I kn=
ow
>> >> that it sits in hyp.mbn partition and all what it does is setup EL2
>> >> before switching to EL1 and running UEFI.
>> >>
>> >> In my experiments I replaced contents of hyp.mbn with U-Boot, which g=
ave
>> >> me access to EL2 and I was able to boot Xen and then Linux as Dom0.
>> >=20
>> > Yeah we're talking about the same thing. I was just curious whether
>> > the Chrome folks have heard of it, or whether they have any changes/
>> > workarounds for it.
>>=20
>> Does Linux ever write to this region? Given that the Chromebooks don't
>> seem to have issues with this (we have a bunch of them in pmOS and I'd
>> be very very surprised if this was an issue there which nobody had tried
>> upstreaming before) I'd guess the significant difference here is between
>> booting Linux in EL2 (as Chromebooks do?) vs with Xen.
>>=20
>
> FWIW: This old patch series from Stephen Boyd is closely related:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-msm/2019091=
0160903.65694-1-swboyd@chromium.org/__;!!GF_29dbcQIUBPA!yGecMHGezwkDU9t7XAT=
VTI80PNGjZdQV2xsYFTl6EhpMMsRf_7xryKx8mEVpmTwTcKMGaaWomtyvr05zFcmsf2Kk$
> [lore[.]kernel[.]org]
>
>> The main use case I have is to map the command-db memory region on
>> Qualcomm devices with a read-only mapping. It's already a const marked
>> pointer and the API returns const pointers as well, so this series
>> makes sure that even stray writes can't modify the memory.
>
> Stephen, what was the end result of that patch series? Mapping the
> cmd-db read-only sounds cleaner than trying to be lucky with the right
> set of cache flags.
>

I checked the series, but I am afraid that I have no capacity to finish
this. Will it be okay to move forward with my patch? I understand that
this is not the best solution, but it is simple and it works. If this is
fine, I'll send v2 with all comments addressed.

--=20
WBR, Volodymyr=

