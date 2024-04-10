Return-Path: <linux-kernel+bounces-139551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8CB8A044A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A59288F98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74733FBAA;
	Wed, 10 Apr 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="J+mah+lG"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BD3F9D8;
	Wed, 10 Apr 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793479; cv=fail; b=fn/bC8/igqlfx3GdIHTWDh/VBxsBBfxu1ALIG5qTAz/bjXHwkDTEiZ6kZCunXzPdVIVXshMPEy95lTZ03lehiWmccXqKQwjZZMt/fdiSloahW+grfWrZWOFxTAlVF63FlhiaCC6nJSkTH0+8QqrdM4aEVrkza5VotArihydGdPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793479; c=relaxed/simple;
	bh=5dFFCYXui8l7J9ylG70OnL/JNGrGSY30KSwi/TuMUHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtdM6CXiOpQN+bPyjc72Yq3z/qePe48eldBQRXTfx11vovgyGeN7YHYbUiQZmuXq4zDITU0dTMUa1qhhVIQQw/wvuQdaSslfxhW+Xa1QArPkPkfs2Z0P63qEe6zlRzNqf6948s3jcBXT5ppQQXh+51Jflek9bewzrg3/eIY35mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=J+mah+lG; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AESZeh009881;
	Wed, 10 Apr 2024 21:57:06 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xdtpu9jbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 21:57:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw6AhVKM6/6E4q60Ng2eHSmLmdgXOkh+pfpXaDTgr5Z/D+WjdyQtXp5fA7zQ8AA+lOZLlRCex8HWYIxzserBGsd2rb9q05sYWstmUdU7qy4XuzvHsPvezWpoQUk35dGXXHEu4H/9gohj1pAYWttOIzuZmIWjrKPjHC1cG0OzLcCm79eqZripQzp5jUiAuS2TF5HwXtv+A4Elmc7qcMNdBGjBA0wIkwjp+0+NX1jar4ZqdfYY3r2L0Pxv5MCr2JR+UDo9HHiphUy9D57Zzg+Rxi6og4l0YWxcfTLbPR4frr4oVDRI8omWklhSwWDUGY2BPEm5koXwxx2e8XkMjMIL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pURTru28IxydbfOo1jyVMKuczgUp4OIKkmr/zc0KUhc=;
 b=kNjVnezeuGAsVNMWJ+6g0nd7nnrNUAjvMoohtEUK+62F8jrzsP01foNrY9TMDVozTk0lBZhw7E+T33NCnTyUC+6nkkWtudjPcx9Kl4RYgBuUuqcWnYCJbkOQBuFI9kLU9rk+GheY//uKDYFXDiI3Y0/Opwp+x5ePnUO766R2RW75yovbvI8fPpTXRo2MMh1WUzQ1Bot5ByotUX/ujE0zf1t6VgBl6FeHw5LuNwicrltjnGbdMnz5th6F46L0Sz9qn3ibyMYCzq4e8zYdRMGbaPpQQ7zUQALX0VmcMS8qrNup1eD0kLvIWUy9wf3kCcVVi1cvhWJsHQz9WeZB0P1QSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pURTru28IxydbfOo1jyVMKuczgUp4OIKkmr/zc0KUhc=;
 b=J+mah+lGJ9xvWdTp5KIr0n26WG3AX7uszbnq17yn3keZWT2CXeDo+ibTDnTNC5RIYcaG412NIVlLjNpjhLqA7NrSWq7NX64Z+Zvfv3/VRVh+7bP5do4QWBcMje+DgGqENcgtnj7cM+Y/uWGugx+5dDjpW3O8dAEuCd/ezMy7XQy8T/9/zW/KVLx/GapjvdvnE5LOJnB7M3W1kJWvrnrgpahkKL1MjLSNHsUe9eyjL5MhuB631rFfO5pwLW+AgpzJrYWoNu+RRFHLZc+TqjdQBY1njGDxyBQrcSz+x0OQ9erTlf99HgKtGI0sUDSGLzvlZpOhEzljbGOG/JUZup//tg==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by AM7PR03MB6133.eurprd03.prod.outlook.com
 (2603:10a6:20b:142::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Wed, 10 Apr
 2024 21:57:02 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 21:57:02 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Stephan Gerhold <stephan@gerhold.net>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for SDHC2
 CD
Thread-Topic: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for
 SDHC2 CD
Thread-Index: AQHai0zLM9/mnLFG7UOC+X9g3MAg9rFh+MwAgAAK5IA=
Date: Wed, 10 Apr 2024 21:57:02 +0000
Message-ID: <87cyqw6fvh.fsf@epam.com>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <Zhb53i8-pJhDMVZM@gerhold.net>
In-Reply-To: <Zhb53i8-pJhDMVZM@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.3
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|AM7PR03MB6133:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wrWaOKbyKZ5zGGQFanDdCS3UqALe4EtEod5GhyafoSOZfwu5tiNibGthNaxjf+ObXJZtk/0ke9xpINKeevVhQWqIrT9l1QOU9N196Fne4rNM8jiw2ZY7kmr63Sei9nBAHnfE+DzFQruaDMGEGkRgVjLEl22AXNtdq2YpKxbSrS1bNHVsc9YXUBl4gU+k0GyAOux80mTNYYp2uzZpXDSvQLGYObX+ewi69O5ygcjmFXeN/yhlRt9bUZeOFkW4Z0nAthQolpFslnR9eTz6RDWzIlpFi//hu5TlCZvzMu8PgoWqTJlC4qaqQQV0pcP4nBDzUNkJPvui3wOnUkrkhUBj2ZOCbl0gQCu51yxrLSxdR1qgGpiUF2czAuwcIBrA1sTaCspTo+J6Pv/+B7CughpQF8gaeFMMYZxW5srX4tZhVF3aEBUgDaem5jm2SKmG+92tXQiEbCbGoU9Opgm78ONXW5Y7B4+89fWDzCtCogyFl69mymfCs0hgvuYGQ2Hb7srPTcbZxvboZEQhRbY6uT2u45dgcZ89XqQ+eRHThX/3hb2nx6Bm2l3lnc5WcHyvr8vX/k1fCucKjDfsY4egmyv0kwcJZtcHHWOqEJR6iaLav7HyqmTuywCA7uImWO/4J1VzJSTRfxLqcpxvPL+txH4zNG/LWsvII3hypHjHl+5Gq8Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?I1ukcloWMCWLQBXJVGNS/DhMwGSkgvfo0D8r/kSKhV+IGXF4JZ2Xzm9iTy?=
 =?iso-8859-1?Q?1Luu2w9pcc0zCi1buV/SGWeTlcn79BKxXLynfxxqKotZGUecUyjTqQqLXe?=
 =?iso-8859-1?Q?P+eiDkmGiTrkngLBxtsOodws1L/vBQAcOncE23wMXSgcJMy8pM4PRjJVqk?=
 =?iso-8859-1?Q?d3CsQscrRUDy/+6zrk+0w64C652EBMw/vlHw6XBp90XfmTuP9MTdPEovvO?=
 =?iso-8859-1?Q?+zT8BOlf2J52rrIN8fmTfJ+Zez7bOqgMaR43aFSSW1ZD1x5eOUNW2HCBCR?=
 =?iso-8859-1?Q?4HbFNtTzstPNwMN1aRzVtMR3kgDh+Zv0mD3o0tLZw2bkz50P1SuLrEUFVJ?=
 =?iso-8859-1?Q?rqP8VaInYBc3/BpzhE+fU+Ovy7KCN7yVyAm5y44QaCFvSDVQQ7xeaomCtd?=
 =?iso-8859-1?Q?nf5VnsX/RSBlXinz7ZRyeZVKm1fP/Jv5tIrz0YxZZsDEhgYDU9vdorRxKp?=
 =?iso-8859-1?Q?zs7U2fTOmVGYfNriA4EE3/pDvn4gJgjVmz3lqArtIdH3hJOmnWY6lO4Pge?=
 =?iso-8859-1?Q?jAa1UAKl2RcK8hXuxcdNd8cdyRZAjLvnvUOEU9NUTD6OB5Muzqe2/d0Qdl?=
 =?iso-8859-1?Q?LfMxM9lGs3lm+l08d+UtWjog7xgV23MgGWKXaenRHFXDVaKkEzxJLIprwS?=
 =?iso-8859-1?Q?WbrwXTm6s4BM6BqI/mPFBVWvt2XqPAkJQWUyDIr5OC1Woi0Rw9KuyaD/xT?=
 =?iso-8859-1?Q?AkWc1kzctrQkMO9ox4rPdIp6xqZmtpWqTPpisSHR7CjTuNNqurY2nxaPN5?=
 =?iso-8859-1?Q?OigF7GmztdW/BGnhL/9UmPyZqGN52vGzRgZoinMOX3sJF+3WSi/WQFwiP6?=
 =?iso-8859-1?Q?WuVp9acwDKcC7gCiHtq5Pkgm4UoLXQWdlPnK0k01a0BVdQh61Xylh8vHh/?=
 =?iso-8859-1?Q?L9CgfJxwJqqscnzmEqTsRguPGz0Z21Anlu1yCW0Uv9/malV3Pm0osZ2UP8?=
 =?iso-8859-1?Q?LD5OhfiWzeiEpDXnB9bNtDTrBzrW8TvFpxKrEeEq2/DwtPesFGJ630djaB?=
 =?iso-8859-1?Q?V5uK5o1RI76+gGTLzUPHI9HZmWc4nfCLbnnQ5bRPN2Cizvl7imbcJ824TZ?=
 =?iso-8859-1?Q?s2RuDRnUKjzX1XOFb+Z1+VAEPoBjc5xkHOJr80Oigmj6I0TpoToDpTCqCs?=
 =?iso-8859-1?Q?l5NLeOa7aNWqUF5ApZqE/C205KMb96noB4gZAdGY2vEZfZL8LuMhVdhroH?=
 =?iso-8859-1?Q?Dv8NqFYKZ1F2dwryDU9MpXllw/VIlgd7gG9feAe2Qlr3DHNm+GzcZIxIAx?=
 =?iso-8859-1?Q?hPASuQJgQwOPJLtLSTgy1E6vH4oDtG5yrNydWaDC4F5lzivor21Blc/blG?=
 =?iso-8859-1?Q?vAmGS+5JkVmJt/3ozF2KLsgOgmvZHHrOKV368COHyd0DbJTfj+tRKjsC+2?=
 =?iso-8859-1?Q?Mhtr3/MkQMcWmfhTpX4AgTlpqxCSp+sLgKmmkHuKme+nQvzQbZZYvl3OaU?=
 =?iso-8859-1?Q?CJNJpc4wu9a2AjlF/Tc0qDfgMiDBIvqycqXgaikS+QM0bjbNTZVbGuzM9p?=
 =?iso-8859-1?Q?pzC7K/sz89bingjFl2a4e24lwbKf3eG9he9VXytS9CdKMCBOI1I+2BZOtY?=
 =?iso-8859-1?Q?KVliHw7B8bSFpXH8aJ8DKNxeUTj8PbqaZcp5WEap/p05rgrFVpslsVcInz?=
 =?iso-8859-1?Q?WW/HWtpIQCoZ5vQrlbEMAlJiJxDJMmIt28ed6oj6ma6ehkWkhmsn3UcA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b39c72-77d2-4cc4-0364-08dc59a92742
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 21:57:02.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw+g23g8Cpb7T5gorBbRzLbhWfomT4JX6KIJoMLB8LhtBjBJ1kBeZmXUQOEJ7Ra+FT3E+eEfYh8Zkej2FMwkvKsM8XoALGy19HqI615eF/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6133
X-Proofpoint-GUID: 7FJrc-4gpmXggYIcIKk-X3iN1UugC4p_
X-Proofpoint-ORIG-GUID: 7FJrc-4gpmXggYIcIKk-X3iN1UugC4p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100160


Hi Stephan,

Stephan Gerhold <stephan@gerhold.net> writes:

> On Wed, Apr 10, 2024 at 01:41:30PM +0000, Volodymyr Babchuk wrote:
>> Card Detect pin for SHDC2 on SA8155P-ADP is connected to GPIO4 of
>> PMM8155AU_1, not to internal TLMM. This change fixes two issues at
>> once: not working ethernet (because GPIO4 is used for MAC TX) and SD
>> detection.
>>=20
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/=
dts/qcom/sa8155p-adp.dts
>> index 5e4287f8c8cd1..6b08ce246b78c 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> @@ -384,7 +384,7 @@ &remoteproc_cdsp {
>>  &sdhc_2 {
>>  	status =3D "okay";
>> =20
>> -	cd-gpios =3D <&tlmm 4 GPIO_ACTIVE_LOW>;
>> +	cd-gpios =3D <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>
> Good catch!

Yeah... It took time to understand why ethernet is not working
sometimes. It appeared that there were race between SDHC and MAC
initialization.

>
>>  	pinctrl-names =3D "default", "sleep";
>>  	pinctrl-0 =3D <&sdc2_on>;
>>  	pinctrl-1 =3D <&sdc2_off>;
>
> These two pinctrl configure "gpio96" for "sd-cd-pins". Yet another wrong
> GPIO? Should probably drop that and add proper pinctrl for the actual
> GPIO in the PMIC. Seems like Qualcomm configured the PMIC GPIO with
> pull-up downstream [1] (not sure if this is the right file). It might be
> redundant if there is an external pull-up on the board, but only the
> schematic could tell that for sure.

If I only had schematic for this board... gpio96 puzzles me as well. I
can understand where wrong GPIO4 come from. But gpio96 origin is
completely unclear. I have user manual for the board, it mention
functions of some GPIOs, but there is nothing about gpio96. Anyways, I
removed it from the DTS (see diff below) and I see no issues with SD card.

> FWIW: Looking closer at the broken commit, the regulator voltage setup
> of &sdhc_2 looks suspicious too. Typically one would want a 1.8V capable
> regulator for the vqmmc-supply to properly use ultra high-speed modes,
> but &vreg_l13c_2p96 seems to be configured with 2.504V-2.960V at the
> moment. On downstream it seems to be 1.8V-2.96V [2] (again, not sure if
> this is the right file). I would recommend re-checking this too and
> testing if UHS cards are detected correctly (if you have the board).

This is actually a good catch. I changed the voltage range to 1.8V-2.96V an=
d
now my card detects in UHS/SDR104 mode. Prior to this change it worked only
in HS mode.

> &vreg_l17a_2p96 has the same 2.504V-2.960V, but has 2.704V-2.960V
> downstream [3]. This is close at least, might be fine as-is (but I'm not
> convinced there is a good reason to differ there).
>

Well, I believe that downstream configuration is more correct, but I
can't prove it, so I'll leave it as is.

Diff for additional changes looks like this:

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts=
/qcom/sa8155p-adp.dts
index 6b08ce246b78c..b2a3496ff68ad 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
=20
                vreg_l13c_2p96: ldo13 {
                        regulator-name =3D "vreg_l13c_2p96";
-                       regulator-min-microvolt =3D <2504000>;
+                       regulator-min-microvolt =3D <1800000>;
                        regulator-max-microvolt =3D <2960000>;
                        regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM=
>;
                };
@@ -386,8 +386,8 @@ &sdhc_2 {
=20
        cd-gpios =3D <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
        pinctrl-names =3D "default", "sleep";
-       pinctrl-0 =3D <&sdc2_on>;
-       pinctrl-1 =3D <&sdc2_off>;
+       pinctrl-0 =3D <&sdc2_on &pmm8155au_1_sdc2_on>;
+       pinctrl-1 =3D <&sdc2_off &pmm8155au_1_sdc2_off>;
        vqmmc-supply =3D <&vreg_l13c_2p96>; /* IO line power */
        vmmc-supply =3D <&vreg_l17a_2p96>;  /* Card power line */
        bus-width =3D <4>;
@@ -505,13 +505,6 @@ data-pins {
                        bias-pull-up;           /* pull up */
                        drive-strength =3D <16>;  /* 16 MA */
                };
-
-               sd-cd-pins {
-                       pins =3D "gpio96";
-                       function =3D "gpio";
-                       bias-pull-up;           /* pull up */
-                       drive-strength =3D <2>;   /* 2 MA */
-               };
        };
=20
        sdc2_off: sdc2-off-state {
        @@ -532,13 +525,6 @@ data-pins {
                        bias-pull-up;           /* pull up */
                        drive-strength =3D <2>;   /* 2 MA */
                };
-
-               sd-cd-pins {
-                       pins =3D "gpio96";
-                       function =3D "gpio";
-                       bias-pull-up;           /* pull up */
-                       drive-strength =3D <2>;   /* 2 MA */
-               };
        };
=20
        usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
@@ -604,3 +590,25 @@ phy-reset-pins {
                };
        };
 };
+
+&pmm8155au_1_gpios {
+       pmm8155au_1_sdc2_on: pmm8155au_1-sdc2-on-state {
+               sd-cd-pin {
+                       pins =3D "gpio4";
+                       function =3D "normal";
+                       input-enable;
+                       bias-pull-up;
+                       power-source =3D <0>;
+               };
+       };
+
+       pmm8155au_1_sdc2_off: pmm8155au_1-sdc2-off-state {
+               sd-cd-pin {
+                       pins =3D "gpio4";
+                       function =3D "normal";
+                       input-enable;
+                       bias-pull-up;
+                       power-source =3D <0>;
+               };
+       };
+};


I am planning to send v2 tomorrow.

--=20
WBR, Volodymyr=

