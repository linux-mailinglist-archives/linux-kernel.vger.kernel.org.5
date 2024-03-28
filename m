Return-Path: <linux-kernel+bounces-123677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1A890C84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7BDB23564
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1313AD2E;
	Thu, 28 Mar 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="m4GVqbP8"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF213A244;
	Thu, 28 Mar 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661417; cv=fail; b=UiboTsBkS/RObI+QBCWn+/JHHh+5gEd9GWZpRT9xzgprsKfgMnODKK066nYa9xNrbwwr03aImqqxGxRpBdKbtCvOFiYrtVCjJoT0nJABrtsgw1P4O0dPM8+2vI918sPniZu180pw/O/EyqvOmX7X9oLXzSM2+q+zU998N16HqJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661417; c=relaxed/simple;
	bh=JFOqYtoRoC/qpd6wZqPe2GARO2f71sc+HGoxXXI7LWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ls0RUyPd8W+cyooKjA7Rq2beNPDhnuCRFDJxVCWkMZZjU6b5tyzc2i0JSwNcShManMJJJZIlCyiiHuvqxQ11ivih8xHtwDYFb+MhqLJCGFX9ZTxsglJ1Ve9WNPDkzmcxZ1XmwPhMf+61HHonaV0YH0AtdiUGWK57KmaZtgxMIEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=m4GVqbP8; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SFFik1021850;
	Thu, 28 Mar 2024 21:29:59 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3x5b1qh3d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:29:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYUZ+o8a+GAgIlGn9Jmmj7XvOGmCBkTDmqemboI6xjRC9wKZxiLz3TXDR93/CssQ4Xy+NGWKedlGpDFcg3+1r/VwSdmCwbsV/w6/qER7BVd+PJ08DDrWtNeFea3df8ReqcaqSpnHonzoWYNLoEDLaKyMKnVQ8TmBbE92ucFRDPvdVIlx6a5KUUggcte8Rx+5OKfJALaAj7ewQiLopMzfuVX1tF0H05+qVxAqY8v8u21+vHGE3i4QoQQ1NpGsr9bB1Y0CzTRj+NYub1Yw/rCRKMZ3Hn/CF4rWsp7tbXxwf5u9th2A4nB+778YhvRTNlT02nlJQU+3gsQIZEZXX1NFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFOqYtoRoC/qpd6wZqPe2GARO2f71sc+HGoxXXI7LWY=;
 b=And1uP/gENMiQehcWLClXkGe6pTKngk7VQQA/OFQQ7qmHPH3Vu4sxJiJZWsVioyy38gxxscFv8zQwrKz5rBurrwJcrJWY/r9NuUOAxky/8auq2fvF0TXtBzshHM1uh0WeKWzJI54ku8ebMLeOOMD8Pyk8mz/jNITjhJLQaD2sqyOggCIKSYvzk5RKI34wjz1+ZvYigZRF4DNdynlylqrAcGA0RBSk6qvPBFiDUB1CrxRNAGCO2gqjn8lEw0z4DSXO53JhYmDM+FYGWgsO0Hbx/3KfDauoNRPZpJP4ndlIFlh9kRaal/kpEAQ/KRFJg4XDFZ9v6TsOlDccPUjwvJLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFOqYtoRoC/qpd6wZqPe2GARO2f71sc+HGoxXXI7LWY=;
 b=m4GVqbP87oiiUFpmxpAzSezKz3X2cxfqH2GietX+XEZu9XrjGS/KlzSggYgY4kF0p4l1G8DypXdTgHoqUJPZA+XXVAo1pwbzGc6ENrhIskIMejlrQ1t7AXrJ+/x0wAqvhlWTZITFmILHV9ifiDRtsmF9bew/ot++TAQIMnacX+Mr21pyZ/fMDlHY8x8abeKEuEFg45LsHMu/cpBX0xytLpb84//Cyql3t+yspR8MIWgg1eJRwbpcg+oUOzq7FRemBULaA3XsEU2hRDzA63Yx7ICsTXh3/b8w51zbOjLh2gKDRw2U6mdpAsSuhCyECjacH2Z0ryv3g2JjZoQ4Cf5oVQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by AM0PR03MB6292.eurprd03.prod.outlook.com
 (2603:10a6:20b:15e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 21:29:55 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 21:29:53 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob
 Clark <robdclark@gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Topic: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Index: AQHagIKviCrPH112HEOpsjr5BCtYWLFMDkOAgAAEYgCAAAGHAIAAJ/GAgAFvKoA=
Date: Thu, 28 Mar 2024 21:29:52 +0000
Message-ID: <8734sayrhs.fsf@epam.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
 <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
In-Reply-To: <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|AM0PR03MB6292:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pOS1N4O3P7rQ4nm8cP3RakkVIsTsk9lZXEjFRAzBTn+qd9rkl34fRCnV69KVEr8VjCK1Jtcv0IHrLjkVcR+cBjRCwI/ue+ufXzrTyQUDvTH//YaewEHwhtqLzSu8N9GnkUXL6z+9MjKhhkJR0QXLHaeXqFpQHVcVu/m8JmcElGEfUYalk3nbN5nh1IxW8NAKsI3VeCcVX+WsAewxUnaU66kXbjcLJSpsvD3tS9Gs13S67zNUtBxKwf5zjNUE/d8yLGgUG0YZvbi24zp9hiV+Wf3RmdRb8CPU5gKwJF1J16m8ke3drnaiEeMYL28conEFPyjh/NMdvrZTxHwHlEcAj3Tk6PlKQlSCh6jlD0nyYFOijV1G5khbVVlEOZf93112cx7NDU+5N5aVawDVGvxtqNC1CjYaQ3q64X220Cc0cN9myooh36aTZSWJfHfKys6VErJ1LF9s2bBJh4u1y1jh2Okf5faaLAEdngXOKMigIRv8F4p3wcQeBdTAiGpAJjv5MQPiKuufYpQheaMpAVlOThpI2IDABTcuQRRjaylB+Qpu/89ydTUiiMl4tM54mifQTBIAymqy9SmDlC2PHicPprMuylm6uzFq7J0GxtnK2YfW/BY8+fT+MyctavjFOvwOzQ11GU271GjA53KMqKSUDednqX79xriaYmj+/I8D0dE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?9YkavmRa74ZHCRFuFE4SEyQ+ctavZcRYb7bbU2r2AJFiNtqnZOQdn2sN3r?=
 =?iso-8859-1?Q?q+SZIY0QjdWz1vWKqAbozn19AwDFZPG/9UeovLx364MxlEheJ+yG8DTBau?=
 =?iso-8859-1?Q?JNWBOk0SW1ZvH7nWMDdVmPhv2mLa0Mr/0Ivxjj7cB5pUMQfMkAT3U44/CP?=
 =?iso-8859-1?Q?r0m5chpjzkViu2C5PpPdWwEOZGCeDDG15cI7q6KKsB6BVu+IGxvARIlww9?=
 =?iso-8859-1?Q?H8WmSTAocZjjCl1awH0S+jyy57RnQ9BcT/E7NvYPD4+R52sorQMBzVa8tP?=
 =?iso-8859-1?Q?6qreJi0d9IXDXojIW448ccvcE+NdMn/XhuMhV+xAT95Njg1d1DZEktH4Ff?=
 =?iso-8859-1?Q?EMwxvOxiHihId3SzS6R/VBRNr7KVxJeRBe50PgH0WP9CdgtZqA4bsCBuoW?=
 =?iso-8859-1?Q?SzntUEzbmMqOF2/Z240jSu/FUPEXIi1V3/fiYaKzUBjoR5ATstk/XkXRDs?=
 =?iso-8859-1?Q?vxLagia0yimRpsmNWzVN1skXI/BkwDbFLzSqJaRnii5armjhFL6bQpKyDB?=
 =?iso-8859-1?Q?YhtKhA635RxOYARrjIKE5VXd0buV4YSn2f+bIYmyyTY5qP0S+JgUVZF/Xf?=
 =?iso-8859-1?Q?MlutLBdp7vR10C+bqDwCPJtSGmf2JRgYq/pRhlxD/xn1Z0Od5zo6ByxcTI?=
 =?iso-8859-1?Q?UFmN56GJ52K1XXNESUj2DikV+OJS6B4jlYEIA/GzwWtLzGqt3blx8WYxN+?=
 =?iso-8859-1?Q?+1L0pXTWLddafon9PLadTrzwFH1IUlcolfmvxTepE5niAzs77YlczSGx3k?=
 =?iso-8859-1?Q?uEjyvuny30TrTdwP8aEdpL3kWBdINJkqVtoJMhfE1FuwZAv9ElN7guBUEN?=
 =?iso-8859-1?Q?67z3oqHt3iaMmhqtWJP3hCDaxvhQcEDJX9qqZUVHWTU1ZdwAP+To4dxKlt?=
 =?iso-8859-1?Q?Ulo3ktUk/oySTblfGIDSc8uH4FK+CI8v0NiZpEKNzmsoBSX9UTwyfJDXOj?=
 =?iso-8859-1?Q?1EA3Mu/TizslCVouvYQcZMa7RL80EkIrFda+DltnQMgIp7pRTvgwEf44vX?=
 =?iso-8859-1?Q?+kgm6YokNVn9DueHQlhOD9Fh8JibJeKWczDwknfWu9PL0UFDuJdNppuPdK?=
 =?iso-8859-1?Q?Oq1V4ZO6wPqVEKoiLaIRs8mb/n9hUJNf7J++vmA1obANKYAERwgU38l107?=
 =?iso-8859-1?Q?CE3NdzT70QAY9Pli6IE0/NeY8ZJ5Uc6ZPk56iXvsRyR084/88ykTV4jZwI?=
 =?iso-8859-1?Q?3nvG66MlQs2pPGiBZYMMcOfW7y7DkO9h3juMivt8EdDoB7YcZHx7zXl8EP?=
 =?iso-8859-1?Q?tI+Ex6gKt57C+u+RcMHswnyAWo/Mq4vw5UAJ690qj5wJdf0sE5GNQIkwJI?=
 =?iso-8859-1?Q?RyTsSPD1AceogEL0WJUxN8v8Q+kQ2jIfQy0YV4eugEjf7H2YDj16b+9ZgI?=
 =?iso-8859-1?Q?y+jFNY5fkglnlUdg4Nz5+xhaALsLMlvq5LDu+elax2EktSBKIY23xO++vS?=
 =?iso-8859-1?Q?yDgh2wo7GkVGKiGETwtjc8MZSkH4nv1OQfQ75U/49Z+2UN7hjoUKRc8FdO?=
 =?iso-8859-1?Q?ab/0GQQGA5VymiKHj+2SX0n13SO1uQ/djfmE8/1uT1WPQmO2FcPFFXGVaU?=
 =?iso-8859-1?Q?2Pu+sAjOTX5P6RKvVBSgpd6lEWtXYtxYLEw1++uJpont7Lhetgh3CRfZui?=
 =?iso-8859-1?Q?hViUKmh3bQD89iFA6wFsyvaR9d7AlcGuM7UzULEgg1twcb8moAzW0h2Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c80102-5587-47a5-e3bc-08dc4f6e34b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 21:29:52.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuEyPjaSh7ANvMOhRZrezKs9QrRMT493UypmMCYi7JpE77IX/MERQO9ip/d2vFAVhQVTAAl4cM0xCo1r5s9aik9gh8JGNDRmU+lTth6p/is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6292
X-Proofpoint-GUID: 7HwnPVXuXLenJqOEP-_ZulGiwT-9F3tD
X-Proofpoint-ORIG-GUID: 7HwnPVXuXLenJqOEP-_ZulGiwT-9F3tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=890 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280154


Hi Caleb,

Caleb Connolly <caleb.connolly@linaro.org> writes:

> On 27/03/2024 21:06, Konrad Dybcio wrote:
>> On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
>>>
>>> Hi Konrad,
>>>
>>> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
>>>
>>>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
>>>>> It appears that hardware does not like cacheable accesses to this
>>>>> region. Trying to access this shared memory region as Normal Memory
>>>>> leads to secure interrupt which causes an endless loop somewhere in
>>>>> Trust Zone.
>>>>>
>>>>> The only reason it is working right now is because Qualcomm Hyperviso=
r
>>>>> maps the same region as Non-Cacheable memory in Stage 2 translation
>>>>> tables. The issue manifests if we want to use another hypervisor (lik=
e
>>>>> Xen or KVM), which does not know anything about those specific
>>>>> mappings. This patch fixes the issue by mapping the shared memory as
>>>>> Write-Through. This removes dependency on correct mappings in Stage 2
>>>>> tables.
>>>>>
>>>>> I tested this on SA8155P with Xen.
>>>>>
>>>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>>> ---
>>>>
>>>> Interesting..
>>>>
>>>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromeb=
ooks
>>>> ship with no qcom hypervisor)
>>>
>>> Well, maybe I was wrong when called this thing "hypervisor". All I know
>>> that it sits in hyp.mbn partition and all what it does is setup EL2
>>> before switching to EL1 and running UEFI.
>>>
>>> In my experiments I replaced contents of hyp.mbn with U-Boot, which gav=
e
>>> me access to EL2 and I was able to boot Xen and then Linux as Dom0.
>>=20
>> Yeah we're talking about the same thing. I was just curious whether
>> the Chrome folks have heard of it, or whether they have any changes/
>> workarounds for it.
>
> Does Linux ever write to this region? Given that the Chromebooks don't
> seem to have issues with this (we have a bunch of them in pmOS and I'd
> be very very surprised if this was an issue there which nobody had tried
> upstreaming before) I'd guess the significant difference here is between
> booting Linux in EL2 (as Chromebooks do?) vs with Xen.

It does not write, but I assume that direction is irrelevant in this
case. AFAIK, CPU signals memory type to the bus for both reads and
writes, just with different signals: ARCACHE[3:0] and AWCACHE[3:0].

>
> Volodymyr: have you tried booting the kernel directly from U-Boot in
> EL2? Can you confirm if this issues also happens then?

Yes, behavior is exactly the same. It does not work with WB, but work
with WC or WT.

--=20
WBR, Volodymyr=

