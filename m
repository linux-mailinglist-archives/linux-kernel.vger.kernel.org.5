Return-Path: <linux-kernel+bounces-142944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617998A325E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F962859BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9D1482E2;
	Fri, 12 Apr 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="MC58lINQ"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86386148FE0;
	Fri, 12 Apr 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935469; cv=fail; b=DZdCcd1eXipcKdde9YnRIbEKwBfroGecsLuSXattAfZVlN6ya1LsEfq4H2gaUDuDRly+jS18JCON8A29oQ2YQ50vwN0lgsXiiCile/e59Edd4NCMdKniQZW572CgZCOm+jG6Cf8CL4NNV8e+QjgjB6ZMv5vfQ2A9GKRSwG88PV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935469; c=relaxed/simple;
	bh=Stx7cu6/MmkrdWKcFJUKr32GDlNbOd1Mb5vxEdBiHAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNrXQ892LuR6EjXJK4L4QaFlLMjMAeZ/AbIFLuIQABOiFE9yDC3C+Hj/Bx7MCrco7gMJSfPVZ0tMw72LznCkWZBbcLxi0QVq8f6DYvb0XKMdk6pwwHmkL8VrYBgubvIwE7Xo5VZ41QaIBkesv47Qf57PgvxtLcv+kr9JxRuX3kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=MC58lINQ; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CEtK01028245;
	Fri, 12 Apr 2024 15:24:11 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xf0h61xtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 15:24:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwZCfDQigtBys1gd+2ZeYb1Ue4QV7g3btCRI4FKBBv450XbvMHpktBDw4QFMlBnq/4c27NW+ZB5dYGmQ71mYbPEQivD2gsEDpYgeb34WX2s60eKjfF9qrfLhq6TD27mt+pGhgGN6HJ0rrf+dEyGXcVyXaCUe/vFTtBkpGsPK3I54A5nlcKh9rvA2ylFBQip6nhSohiVRr4Q9sh8pmz/XIRnFfsQCuIw232ydvxm/EiQNxCAsnsJ4VCVcoOYwYzR+kpct51iB9a9Th2nuOkaXbCxEzBlxDyFfVsM5XVoqXwUZJAkKLO27ggbfKewa2t+Q6S5i9TcwZcFDSRmUWq0NXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUa9uzl1R24nA5HrUaQh95mnVqvZX1bKlMi2tF1g6fY=;
 b=gaDwMfPrUV+YRw5lOe+XAHdcoYhQclY55lo7uiHHlwPdVXmjw4fR7A9C8UcGTUdEtVfGqrNLsk7ay5T0a76cWcdsHwzGd+vyzRVIuhQO6RP0VrDuwYaa8eRRVSyXMa7cUOMWWh/173VPt9l5+e7o/rMBcxV/oABTuQMSQwWnJdk1fpOl3nTxQmncZuMyp4fDsMeQ86vCboISS8tLUlNKU28xPuDiR/x8qwxyOyRetg2cpEt3DYRFLOBAYiHzZJTzdsYc1OJB5SaRJa9qXhH8r1SiTRa8nB2/LaF5xCGqEzWFHBRECybkKrPKbiHi1Aq7nC6g6sp+w7C/0kwLBEIRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUa9uzl1R24nA5HrUaQh95mnVqvZX1bKlMi2tF1g6fY=;
 b=MC58lINQfw6OYqF2GuXB50NxK/OsjmszN9dwHudmUphz9XXpISj6/yaldY7u4QbivXq9aL7GCOiY46Wcwmt/Vqf1L57LPZ7lXWgwTtKFNdFyp+0Gn7olMzorpXrbtiRvrMTpRj2k+6+xM0049V61K2utDbxjAGYZ0EUo21Nq1Hpy1cDKDaqrPh3DDwBpwP5zjE1R2cF1ckpQxVCIVumZH1cAO/QEyl8bP707mm2Pho7oAIni/uayluSNsdGO7E3pNDBx1f2pRFfj6vwNTXL3hCv+kIZ3Msu1qC8m6ZK5j38cEX6QweOIMiPsFlM6v/lnA4T2YV9F7MUNqhFOzYJESQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB8392.eurprd03.prod.outlook.com
 (2603:10a6:10:3b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 15:24:07 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 15:24:06 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Stephan Gerhold <stephan@gerhold.net>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 configuration
Thread-Topic: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2
 configuration
Thread-Index: AQHajAc1RfBxI3QF4U667KfqA0a9CLFi93IAgAHIhYA=
Date: Fri, 12 Apr 2024 15:24:06 +0000
Message-ID: <87v84m4nah.fsf@epam.com>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
 <769a6a2a-2f38-42de-b3ce-8585b8b0a758@linaro.org>
In-Reply-To: <769a6a2a-2f38-42de-b3ce-8585b8b0a758@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.3
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB8392:EE_
x-ms-office365-filtering-correlation-id: 1a5d358d-e6c4-4572-669a-08dc5b049813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8MTi66L2QZNWE9RxTRrAPxl7bA0HFGfGg69TlDA7Uo+PeRrSNUGQYGBZwPaw8Ad9MHAkQpXKSyki9N0lDIFhQoymJkWMsYwR8iB5eRM3ajZxxcogMSbGCcAYMzgrv3zDGLKy6+4RP27UDKj/RZ3dQPiAEoWfrIVeO0NHb0Zkiq3R8WGQVJkLU0lC9xnC/hhfWPZCJ5jd80MvSS0UNyXEkzXpyMay78aNW8fCGPdab8JUrF59TaFEsHKooc6hjUcZu5pZZq+tclL7el/x2DQiZEPTPSif2UUk313bcz9AZu8bLxrOAf6qbsPchwp8UPMWSSwBm3Y3AueYQhBT9IjbIjIbTuka0E3JqTqyA0tvKmQbiteDz7unWYUa9GdkLBYqAQ/iRTpArBlZgpqd4RMsMCEYeNeH3UTLelgxNHrnImoKoqRucJqAzwpGHc4eOoNuEMSBKJuRKSWTxJLxPHZThTPyfdlei6ItLySnXJ/dwz9RaQHzVz3HcA3aZcfkhbPlXh1ZIegeC7FSZVQjZlHECEzmsw8bSUKMvMygutoG+Trh051CmRAQgsQA7oVtn7lXSiNgU02U6awZQGssI43qpkqgd1GNPMRWd+cIGA0vzRXyCNos3/pY+Le+oOCoBeauGKGxnyzXHMOHPil71PSqAIK/G5SiT/oaI1Ekw+Wm2LUa1VwZiPbOOHI7IP2sV+sFG1m0CcJrFou3el7Jo0FuFw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?52j2z567CxGb22u3dTlaQcA3WfB1OIor8pEw1NN6Z1rdu8GTy88kYAWydE?=
 =?iso-8859-1?Q?9ZeMRVcwwpgezXvR+2Ew5Itf12PwNGivrXKF1rjW+q74WtE/6DdYtUxAZy?=
 =?iso-8859-1?Q?GfmqtGoOvcN+cAu816csu8zFTtoBdK8SRdNc5QdGm7xXwWvfKj5EX3WU1o?=
 =?iso-8859-1?Q?g8BragwY9tAJx4agNDW0As8vS+Ijclq5Pqt61RzSykEUoshwRpgv1uQ0WA?=
 =?iso-8859-1?Q?2isyizPnUNINu+FkjOzG1DqyuvY8IzDl+WGur0vZdnZbM8YZExrruG5y0B?=
 =?iso-8859-1?Q?EimqZcVnYtJyP+5DShOETvkWiWs4U0k8U6i78u888hKt8CDupEBjxXcsJr?=
 =?iso-8859-1?Q?UhtNtFSvAKIdv9992iL59r1HrzrnDGMDYyyrIDv/xVdDhdyA6dE6TtMN4q?=
 =?iso-8859-1?Q?gDBnkbCs+3L4u7I1+J7KvMQsnMNB7lOnzAEa3NHeFRDNArCxdv+SYYEeSx?=
 =?iso-8859-1?Q?zEBA22MBqfJuQhjvvrn3j8Pl0wDwJLqugIohX1xdV+AclM/xlPwIaHul0Z?=
 =?iso-8859-1?Q?mWcGAt5YH5CML5sJjcpcc4DdRxdl95uLzZHflbCP+YhLgkPA8kqEGz+EQC?=
 =?iso-8859-1?Q?s5eHXnXrpF5EwfVi8Xy5maLVvP67nmiB3Xi5MV+ggb2yVw8GbTaBge9i9F?=
 =?iso-8859-1?Q?72YX0LtBEfxAgF7izgrRCZC3P9mm3XiJvlKstpUaOuEUbc9eicUqlO/oXJ?=
 =?iso-8859-1?Q?b5qcK8t83AvGpLsSffdKmxmae9OKu3/qgRp//nknjXhyh7YIO4iR3K8RT9?=
 =?iso-8859-1?Q?XlQ5F/NADxR0xNb17eKrkYk5howpTAkN58LRDWtYmmSLYvcUiBP1RhHeLS?=
 =?iso-8859-1?Q?4VemYdDlI/NeFWgQdGIcFyzb4Qm0rIHTCVqyO/rewirxSm+WoiOHv1Q2QZ?=
 =?iso-8859-1?Q?nPz9UQ8QyUv/hcrKtnBoEamEdjAowXJlnOVjURlVWxRm3wqRqvOz5PbzIW?=
 =?iso-8859-1?Q?vJ33vDe+PUNcZivWbWmTxba9QpK7eVUoQhN1Iafp7ndkHKP22Fo2PyEwVK?=
 =?iso-8859-1?Q?nIHyEr0J1rFG/NIehfB9Ju+RZ3moEM6aU/2linJ4MZE6yBT9xk0rESfOqT?=
 =?iso-8859-1?Q?apwyYTUxcif1C0QZkTgNMP6YwKGeQOcITEoYVOC/paBKZiH2Lymmn8bgAX?=
 =?iso-8859-1?Q?ocx0MGxc4aTUARKPeiPnaDywzAj+ajT1zh7Ep2z8BKpmhPVFqh9Lrka4h4?=
 =?iso-8859-1?Q?dB7oggvuKtD/MXxdW/OLkQlN+AUNTUau9PVMhloEZ9TXZTKA5+zXVdDUPT?=
 =?iso-8859-1?Q?UYMfB84irGFzEMnqCxJRJIQINwNQ7hpcxSibpWvCLCjb98Pga28Nj1aO0V?=
 =?iso-8859-1?Q?GA8mm1ywyi6WZwW7dnRC9Vy8P1bCg4QaGE2K07Kx8niKfcCjNkv8oGMuAO?=
 =?iso-8859-1?Q?A8LXxxzUkEbFYpE/O0HGHfzORdoIReEfwRoj7QVUvwSREu+LM36t7USgTA?=
 =?iso-8859-1?Q?u2BYUIOemiN2UYeZ06QqneKtNZ+XI1z+qWUePUbibhmn+kmxnm0CitfvME?=
 =?iso-8859-1?Q?25oXQmvQDEgsKkDtqotNly60nePgmFFL4rJWGgzDPsTs0E+YEujx8hE/HM?=
 =?iso-8859-1?Q?QDYEWL6z7cdU01n7lY5/I66S2WLjXSJrO1qc0ssdiQon6QUjBj2Hr1N48T?=
 =?iso-8859-1?Q?RJTzNRqQHzy9KXk7VI12vl5FGii/RN+XAHdZMM+Nlj8sKogam7EzIUrQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5d358d-e6c4-4572-669a-08dc5b049813
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 15:24:06.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gM1xO7N/i8ShhWLrCTaZoRrNcfMW7tezolzy90dLHVtjlSZDFh9FAMllIAeTwb0DS+A9//Z6146dns39tze9DY3g0DCpXunTSP1wsRNS4yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8392
X-Proofpoint-ORIG-GUID: R3vKfpgVjFqxYQpYclXxFUhEaR_SEmb_
X-Proofpoint-GUID: R3vKfpgVjFqxYQpYclXxFUhEaR_SEmb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120110


Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 11/04/2024 13:55, Volodymyr Babchuk wrote:
>> There are multiple issues with SDHC2 configuration for SA8155P-ADP,
>> which prevent use of SDHC2 and causes issues with ethernet:
>>=20
>> - Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
>>   PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
>>   TX. If sdhc driver probes after dwmac driver, it reconfigures
>>   gpio4 and this breaks Ethernet MAC.
>>=20
>> - pinctrl configuration mentions gpio96 as CD pin. It seems it was
>>   copied from some SM8150 example, because as mentioned above,
>>   correct CD pin is gpio4 on PMM8155AU_1.
>>=20
>> - L13C voltage regulator limits minimal voltage to 2.504V, which
>>   prevents use 1.8V to power SD card, which in turns does not allow
>>   card to work in UHS mode.
>
> That's not really related. One issue, one commit.
>
>>=20
>> This patch fixes all the mentioned issues.
>>=20
>> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD=
 card")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>=20
>> ---
>>=20
>> In v2:
>>  - Added "Fixes:" tag
>>  - CCed stable ML
>>  - Fixed pinctrl configuration
>>  - Extended voltage range for L13C voltage regulator
>> ---
>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 32 +++++++++++-------------
>>  1 file changed, 14 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/=
dts/qcom/sa8155p-adp.dts
>> index 5e4287f8c8cd1..b9d56bda96759 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>> =20
>>  		vreg_l13c_2p96: ldo13 {
>>  			regulator-name =3D "vreg_l13c_2p96";
>> -			regulator-min-microvolt =3D <2504000>;
>> +			regulator-min-microvolt =3D <1800000>;
>>  			regulator-max-microvolt =3D <2960000>;
>>  			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>>  		};
>> @@ -384,10 +384,10 @@ &remoteproc_cdsp {
>>  &sdhc_2 {
>>  	status =3D "okay";
>> =20
>> -	cd-gpios =3D <&tlmm 4 GPIO_ACTIVE_LOW>;
>> +	cd-gpios =3D <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>>  	pinctrl-names =3D "default", "sleep";
>> -	pinctrl-0 =3D <&sdc2_on>;
>> -	pinctrl-1 =3D <&sdc2_off>;
>> +	pinctrl-0 =3D <&sdc2_on &pmm8155au_1_sdc2_cd>;
>> +	pinctrl-1 =3D <&sdc2_off &pmm8155au_1_sdc2_cd>;
>>  	vqmmc-supply =3D <&vreg_l13c_2p96>; /* IO line power */
>>  	vmmc-supply =3D <&vreg_l17a_2p96>;  /* Card power line */
>>  	bus-width =3D <4>;
>> @@ -505,13 +505,6 @@ data-pins {
>>  			bias-pull-up;		/* pull up */
>>  			drive-strength =3D <16>;	/* 16 MA */
>>  		};
>> -
>> -		sd-cd-pins {
>> -			pins =3D "gpio96";
>> -			function =3D "gpio";
>> -			bias-pull-up;		/* pull up */
>> -			drive-strength =3D <2>;	/* 2 MA */
>> -		};
>>  	};
>> =20
>>  	sdc2_off: sdc2-off-state {
>> @@ -532,13 +525,6 @@ data-pins {
>>  			bias-pull-up;		/* pull up */
>>  			drive-strength =3D <2>;	/* 2 MA */
>>  		};
>> -
>> -		sd-cd-pins {
>> -			pins =3D "gpio96";
>> -			function =3D "gpio";
>> -			bias-pull-up;		/* pull up */
>> -			drive-strength =3D <2>;	/* 2 MA */
>> -		};
>>  	};
>> =20
>>  	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
>> @@ -604,3 +590,13 @@ phy-reset-pins {
>>  		};
>>  	};
>>  };
>> +
>> +&pmm8155au_1_gpios {
>> +	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd {
>
> No underscores in node names.

Fill fix.

> Please also follow tlmm style of naming nodes.

Just to be on the same page, will "pmm8155au_1_sdc2_cd: sdc2-cd-pins" be fi=
ne?

> Also does not look like node is placed in alphabetical place. Where did
> you put it?

I can't say that the file is sorted in the first place:

# grep "^&" arch/arm64/boot/dts/qcom/sa8155p-adp.dts
&apps_rsc {
&ethernet {
&qupv3_id_1 {
&remoteproc_adsp {
&remoteproc_cdsp {
&sdhc_2 {
&uart2 {
&uart9 {
&ufs_mem_hc {
&ufs_mem_phy {
&usb_1 {
&usb_1_dwc3 {
&usb_1_hsphy {
&usb_1_qmpphy {
&usb_2 {
&usb_2_dwc3 {
&usb_2_hsphy {
&usb_2_qmpphy {
&pcie0 {
&pcie0_phy {
&pcie1_phy {
&tlmm {
&pmm8155au_1_gpios {


So, I can put after &pci1 to have it grouped with other entries that
start with p*, or I can put right after &ethernet to make it appear in
alphabetical order. It is your call.

--=20
WBR, Volodymyr=

