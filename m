Return-Path: <linux-kernel+bounces-158259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD48B1D98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883A3285E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625A86259;
	Thu, 25 Apr 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="OXg2IbUu"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4784A31;
	Thu, 25 Apr 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036558; cv=fail; b=gmUfdcSq5yd4WEE2PVm/8DCABbTGeSxq5LII4gp8e+g8QmzmP0lkv0s3gfQeebUZo8xV+VndHOdc6f04rcIK208aTpKTHdcHWoOKCzrDxE9VATZAIut/Xj8kGTAQYKq693CQej7AdWcYkHHwurexzBXgddLsGct36vX6PrgLHM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036558; c=relaxed/simple;
	bh=RqsFeOiXLeF4gFS8bws0IZBEC3mWYvbIgz0Pn66VMA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WUZrVh0eg8cY82LQmA2qTMGpHjU5e0xTEcfWB2n7R30RqNA6qvbn/Ckav+GYQH2KZgq7hmQhh0t/rUypq89mWO6kxTO38tliCPY0EOTfSpwGWvKKQaeMqOzEa5UCYuN5bWJxviocBTrLLQuzt2EaYA0GY+1gO5iAibFWS8s9ozs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=OXg2IbUu; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FHIS011746;
	Thu, 25 Apr 2024 10:15:20 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:19 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azTe/W/iiqJmV+Bd5xGSse1xEqcyfUKWZnCz2rJSpuPWAPG+CbcXiT9UMi0cHyzvymFifiHkBfBkAbAbpZnnGotjJVOvxNMI/1WRdLfaxmQzf6vDAEc7AIdMmEsuvj7slkjqBoVV6KG0RrfItuT0Rq0/R8LhOxCpq4rZuAqWoDtV0P/YuJuxu//NM7Gb+fVcpJOn62FkZ8jeTt76KuI9AlTQY500emPjhAUNHNLmqSFtMKsj+rImLY0LBmZnN+7AoylUTWTzXBvn5BjbKPbBJGJkNpXo0Jc22ttHt0/EF+PFjwgOmwbequahv0zzMDMWkTJdEcAcx/Z/te1rHoKNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dbvrpRapWS/gwc4nPvset5eBdMeXGke1mC1KMHSxkk=;
 b=QzRoB7H+QPUZwXDsP0Qhs21J6B/PPkiF1bLa8j/aH9EvTogYzCX+OU5DIiykZWZ2n1++QF4gveSZ5GWInjfbA3OkuSTQU0yKqRjHjlYITGLDQIkUpDRujh88+z4EbupS7hj8W+f1xXTvxEX4NfPy+dIE6uO/YajmUGlkpb5rt0Colukmy6rqRlRkHsmBfoOxuBb3vqkM+EJXnNlWiGFH8NnlWe+QosUnKA7+0WK0hBK5xMHINSxeLOd/by8auxdPVFk91P/OodF8Ws5k6XaX0Gz7Kv5p8vc7qDokH0E9IFU5e91ApY1cB0HD9tMAVGS7b+dZNL/T5vP5gGs1lxJpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dbvrpRapWS/gwc4nPvset5eBdMeXGke1mC1KMHSxkk=;
 b=OXg2IbUuNOLOvMnoMX0IQ/OwDgpR13ttDqnGE7FPDXn/jxF3Il9qocwviSzNX8tJApr35wk0aaxz/h+bTjXzSmrz4Vi9ncgmLWxvX+u+kV20oN6mYxZ7gIzl+OGYdptBhYf/fKsGPjvKGuCsUPIZCKmRkJ8ALzX4X3Qx2pM0zQY=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:06 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:05 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        Niko Pasaloukos
	<nikolaos.pasaloukos@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Matt
 Redfearn <matthew.redfearn@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        "heiko.stuebner@cherry.de"
	<heiko.stuebner@cherry.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "sre@kernel.org"
	<sre@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "geert+renesas@glider.be"
	<geert+renesas@glider.be>,
        "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>,
        "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>,
        "nfraprado@collabora.com"
	<nfraprado@collabora.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/5] arm64: Add initial support for Blaize BLZP1600 CB2
Thread-Topic: [PATCH v3 4/5] arm64: Add initial support for Blaize BLZP1600
 CB2
Thread-Index: AQHalvEPQKrAV9M0NkyhD59YDgTJ5Q==
Date: Thu, 25 Apr 2024 09:15:05 +0000
Message-ID: <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: 5730f823-d898-4668-7325-08dc65083255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?C7dz35txnz7r6Cl9nAMTHzaPtK7gAYbSPqm7PVWay5/QTtJzM3kTMGPI4I?=
 =?iso-8859-1?Q?VFfU9lGhHyDhq0dfBRoGNNBeV6HJApXUS+26IU7lINpPL6K5EHM2mhpofT?=
 =?iso-8859-1?Q?LmDC3gYDFkn4mGfIkIQsGCn79/RHbmM576s3uaY3ev104Ycq5jlrVXbj7s?=
 =?iso-8859-1?Q?qSL3AlPNc/2VjTjqWCH6ZaCETeEPbMvmqLCBHmEd8r8fZQFgZ8NPesi6Yl?=
 =?iso-8859-1?Q?p0OxYLzQysgYBa/3TB61HCzuXC7mEQ1I1z2mOSVSyYp+1BSpwc/WCrNpIw?=
 =?iso-8859-1?Q?Chh2QGUwTA08SwYJqeQosWqL0r4bqU4bMBuBoD7Pd3jRh0x3af+lYclNX5?=
 =?iso-8859-1?Q?E4kShsRtLC22XmzzdmBIlf0v8H+sF1rtqcr2Mg4WXU/Z4fDPy4K9e4W2Uf?=
 =?iso-8859-1?Q?Vo6i/OzZ2eC2d2jdiCJugQ4WDfu1B0QpSuzBoOktGLv2JqMgx+TE499xYi?=
 =?iso-8859-1?Q?rxQPH0ZFUpj3EQWoIZfAw3dz0MmLWNvZqcT6FeJLsuyEkrTnsDAVoqPlzn?=
 =?iso-8859-1?Q?/v5wpHN2eTUe7YlfW1uDkuE2XMtc+U7ETR7eXvhbTK1VTg1gMtyMX3JBEL?=
 =?iso-8859-1?Q?4GkEkw9baHzp1oKXXYK1kyvkDFaf6IDTwl5cGiRckHwHnfFNV8grijY7NF?=
 =?iso-8859-1?Q?5H83DTI3JC+Qhj/wycQS++W5MV4T6EXfY0INu6kq1C71c7ZKyicOEjgDhr?=
 =?iso-8859-1?Q?EmkbPwM00gwmeE+owHMM0XxU0MskhDNwqAyx454AOTXMYB2J/EO9jW9nca?=
 =?iso-8859-1?Q?7R3N9LSP74kPD/zu9gk5ePEkBRdEG1bJc1iaBNcKvLiDemrADCRzA3nQDQ?=
 =?iso-8859-1?Q?najTpkH/cYh7buQ/T/33WLIEyxQLxluphbK2NfXfJLjxozB2q04KHrRKor?=
 =?iso-8859-1?Q?GNKVYv3w25m2qkJniA1ZM4O8/Z2oUmqSgWBwId2DqSLMDpYSGYf0d/sIgB?=
 =?iso-8859-1?Q?rEEs86kIHSFvc1F2aZs7w/ekwhJmLtwNyjqcJJyTgsXesms9/7zWX7f/fz?=
 =?iso-8859-1?Q?rxIcNdPkO0imcR47k7UsRXLoZBaIe1haOMGfjXSloBVYBrF3eztigVAQeR?=
 =?iso-8859-1?Q?nEdovOxqMIXR54np4kaBCM9qN0QCk51Sd7rnzLie5QIhG3dphXVKDzJVM7?=
 =?iso-8859-1?Q?nhv5rl+groee3rqtWxCFV5sZshxHfQcSH4irfG0JOybXeEpVnFm2EHoGmV?=
 =?iso-8859-1?Q?kgc4QQAgP1uW2nZ23CuP8Z5v2dEuHO7k3Hu/slhinfNPrv8fBLV8nr7fCu?=
 =?iso-8859-1?Q?k3jpuIXr7JfMY92ccQi/LqPElQ7s9Wcbjp9wON89sgreFgPpJpMVTBlfn3?=
 =?iso-8859-1?Q?JRkO/2n8koY7yWxqQ6iIoE3FifsPBbjUi2UHHUfjLoc+hD/5+KiY3XOLok?=
 =?iso-8859-1?Q?ujGTtFzGU3i2foOu6DkWGhu+sMzV8uBw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?y3RFgoKKCUBUv0In4FvTrEodkpf6oGvc2jKpMIlCZB+QP9nW7Bo9UmtRaA?=
 =?iso-8859-1?Q?wby+xzZR5dLOgXqynFyHKK5iv80feFx80vFamEuE8GUyZhYEx0IdG5ydHe?=
 =?iso-8859-1?Q?0ZwCopjFtE65MnogW6EtKDF4OIXqnUrkE/cIPKfqlJDERXFH1IjvCySCpf?=
 =?iso-8859-1?Q?BdxmhvyAW3e6FY1xU6VUOQvglU+k9mmEtIFlXTYhPn9t8u2aV/f3ZB5ohk?=
 =?iso-8859-1?Q?JiSWZGhjyhBUNNlLuA3YOjgGUdJiWm3W3ifCbknaGhVB4b7nYHV908sYzs?=
 =?iso-8859-1?Q?bFaVu2+rJ/Q6UyI8BW039rSP0GzZv8CLY4m8LMMYQ4+b6n0H4YaxybkA3l?=
 =?iso-8859-1?Q?qgw7+Pi8aP0M5F7PyeaxsOnbieS5LcACAi9z2Dbf0FD8mBG+lb+xOWpkPx?=
 =?iso-8859-1?Q?FbBXtyNHKjZ4tJzQTybkfFcliKO48kWQ8IWeYtr3nQAgTLY/klEtQMvehG?=
 =?iso-8859-1?Q?NvbJ8RmK2U7eo96Her3ph2xsTU7FbfBF8AheZSEy0wbZ4CEv1L77KER355?=
 =?iso-8859-1?Q?6CQPtt3QHDTq9LdLzg2QW0iS96zlxrYDEb2GFk3rApxdC9E6kt4IrsH61f?=
 =?iso-8859-1?Q?XYTHHhJhOQbmm7NVEcTENLZ8gknFH8hhIOt35RZHXhO7d4HrvhNW1cEhAC?=
 =?iso-8859-1?Q?1lDxgI4O8lsSmXPkelDgUmdbcdanq/njAfZKiTQOruc3wibd7RTYxTHG/3?=
 =?iso-8859-1?Q?NVdeYTSPX2Fsmuz2cXglg5kwlFFbw2Fj3asDOutRmP4ij0jcZqnWNUCKvO?=
 =?iso-8859-1?Q?v3sBvJxE/izlrbTrGAl/NXBl5EaS/m0eATLYk0tOQETht8yLF0D19FdBDc?=
 =?iso-8859-1?Q?TvEo1HQNYjag2IqyArksy5oMglMpoSwYXy3qW3uuFft0qNbVfPS/XuCyc2?=
 =?iso-8859-1?Q?WUbCDx0Gp8fe4nqpuqvIDDU6r0GampRvJzEA4wYCZFQQZwoPf446iVF5xG?=
 =?iso-8859-1?Q?qUDmdl6k/pA69yJsLjIJqixIMCSUerGMXRyU+LQcneqJPAyqEWcfCOhf/S?=
 =?iso-8859-1?Q?Sb3gqpYmmgApRSA7LG969WN54OIFrwJV+FTo30q87SvgJ/sydZiAYaOnFp?=
 =?iso-8859-1?Q?GI305rTI/mApCNWig/FbYa5hVXqmdg8aeFWc8adOVGU9txqo1XUS/tITYp?=
 =?iso-8859-1?Q?294dzTzd4h/HoyOlVGQuOGCUk506hErLDNmrfuRtU35uKVCMWxo4ZkvmbK?=
 =?iso-8859-1?Q?+qHvREQa5eS55c4rzEHF31YNYT+Te5AfJNO0eQxOyqcnBrhcFHTVpEtfWW?=
 =?iso-8859-1?Q?lYXXdzWil89yvDY2SSi5LfnLN7/PIQr+sBHzhRcznOhWZKNgttpfIhYYPO?=
 =?iso-8859-1?Q?KFZY9jiu1XN64mmzYZlNnPHtSvAdTS6NF/5X7ygH1A2cD90AB6bv0KIsC9?=
 =?iso-8859-1?Q?sUrj7gWJXvVR79B3hQnM+byVkXnqwmHN7KglidnZYv0RIAUiighE7ooNv0?=
 =?iso-8859-1?Q?z3BO+uc1rjLCLOOW2C31Kd+HGyq0Xyhx1cXaHeM25cvFzqTyp3PTEbA7oW?=
 =?iso-8859-1?Q?vJUrqB9XmYDVDE1GRsuynchC7cL/IhiS0/7L/kvSWCuQw7O799Wgwmer6y?=
 =?iso-8859-1?Q?E/gs+DxPLHJFvC4IkmSqtg8EemaTYtw1mII6XwtVAE6Gz6P4wzxqRi6TYn?=
 =?iso-8859-1?Q?klqKkpw6JOoSPuEvVzjrNtPFQqB9Ld8gbECDuqwnPA3pMtEzE9/lu+cw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5730f823-d898-4668-7325-08dc65083255
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:05.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ1ipruErn7pbbx8+nwJBMgqkRTUdBBNlqMmx49M0O0AP7wRaQkauCeQuLPY19qdWA2pGu9COof2GZIYcSex1oA1QCvkwJXNsYvJO1qecSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: YWL5Vk_P67hGpgPfSRVeMnSuW0SAGrLY
X-Proofpoint-ORIG-GUID: YWL5Vk_P67hGpgPfSRVeMnSuW0SAGrLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Adds support for the Blaize CB2 development board based on
BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.

The blaize-blzp1600.dtsi is the common part for the SoC,
blaize-blzp1600-som.dtsi is the common part for the SoM and
blaize-blzp1600-cb2.dts is the board specific file.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 209 ++++++++++++++++++
 5 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 30dd6347a929..601b6381ea0c 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y +=3D apm
 subdir-y +=3D apple
 subdir-y +=3D arm
 subdir-y +=3D bitmain
+subdir-y +=3D blaize
 subdir-y +=3D broadcom
 subdir-y +=3D cavium
 subdir-y +=3D exynos
diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blai=
ze/Makefile
new file mode 100644
index 000000000000..595e7a350300
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-cb2.dtb
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/arm6=
4/boot/dts/blaize/blaize-blzp1600-cb2.dts
new file mode 100644
index 000000000000..0bdec7e81380
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "blaize-blzp1600-som.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
+
+	compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200";
+	};
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c1 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c3 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	gpio_expander: gpio@74 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x74>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "RSP_PIN_7",	/* GPIO_0 */
+				  "RSP_PIN_11",	/* GPIO_1 */
+				  "RSP_PIN_13",	/* GPIO_2 */
+				  "RSP_PIN_15",	/* GPIO_3 */
+				  "RSP_PIN_27",	/* GPIO_4 */
+				  "RSP_PIN_29",	/* GPIO_5 */
+				  "RSP_PIN_31",	/* GPIO_6 */
+				  "RSP_PIN_33",	/* GPIO_7 */
+				  "RSP_PIN_37",	/* GPIO_8 */
+				  "RSP_PIN_16",	/* GPIO_9 */
+				  "RSP_PIN_18",	/* GPIO_10 */
+				  "RSP_PIN_22",	/* GPIO_11 */
+				  "RSP_PIN_28",	/* GPIO_12 */
+				  "RSP_PIN_32",	/* GPIO_13 */
+				  "RSP_PIN_36",	/* GPIO_14 */
+				  "TP31";	/* GPIO_15 */
+	};
+
+	gpio_expander_m2: gpio@75 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x75>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "M2_W_DIS1_N",	/* GPIO_0 */
+				  "M2_W_DIS2_N",	/* GPIO_1 */
+				  "M2_UART_WAKE_N",	/* GPIO_2 */
+				  "M2_COEX3",		/* GPIO_3 */
+				  "M2_COEX_RXD",	/* GPIO_4 */
+				  "M2_COEX_TXD",	/* GPIO_5 */
+				  "M2_VENDOR_PIN40",	/* GPIO_6 */
+				  "M2_VENDOR_PIN42",	/* GPIO_7 */
+				  "M2_VENDOR_PIN38",	/* GPIO_8 */
+				  "M2_SDIO_RST_N",	/* GPIO_9 */
+				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
+				  "M2_PETN1",		/* GPIO_11 */
+				  "M2_PERP1",		/* GPIO_12 */
+				  "M2_PERN1",		/* GPIO_13 */
+				  "UIM_SWP",		/* GPIO_14 */
+				  "UART1_TO_RSP";	/* GPIO_15 */
+	};
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm=
64/boot/dts/blaize/blaize-blzp1600-som.dtsi
new file mode 100644
index 000000000000..efac0d6b3d60
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include "blaize-blzp1600.dtsi"
+
+/ {
+	memory@1000 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x00001000 0xfffff000>;
+	};
+};
+
+/* i2c4 bus is available only on the SoM, not on the board */
+&i2c4 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/b=
oot/dts/blaize/blaize-blzp1600.dtsi
new file mode 100644
index 000000000000..26d8943d60ab
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x0>;
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x1>;
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D /* Physical Secure PPI */
+			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Physical Non-Secure PPI */
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Hypervisor PPI */
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Virtual PPI */
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a53-pmu";
+		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity =3D <&cpu0>, <&cpu1>;
+	};
+
+	sram@0 {
+		/*
+		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
+		 * A small DDR memory space has been reserved for general use.
+		 */
+		compatible =3D "mmio-sram";
+		reg =3D <0x0 0x00000000 0x00001000>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges =3D <0 0x0 0x00000000 0x1000>;
+
+		/* SCMI reserved buffer space on DDR space */
+		scmi0_shm: scmi-sram@800 {
+			compatible =3D "arm,scmi-shmem";
+			reg =3D <0x800 0x80>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible =3D "arm,scmi-smc";
+			arm,smc-id =3D <0x82002000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			shmem =3D <&scmi0_shm>;
+
+			scmi_clk: protocol@14 {
+				reg =3D <0x14>;
+				#clock-cells =3D <1>;
+			};
+
+			scmi_rst: protocol@16 {
+				reg =3D <0x16>;
+				#reset-cells =3D <1>;
+			};
+		};
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+
+		gic: interrupt-controller@200410000 {
+			compatible =3D "arm,gic-400";
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			reg =3D <0x2 0x00410000 0x20000>,
+			      <0x2 0x00420000 0x20000>,
+			      <0x2 0x00440000 0x20000>,
+			      <0x2 0x00460000 0x20000>;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
+						 IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		uart0: serial@2004d0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x2 0x004d0000 0x1000>;
+			clocks =3D <&scmi_clk 59>;
+			resets =3D <&scmi_rst 59>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@2004e0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x2 0x004e0000 0x1000>;
+			clocks =3D <&scmi_clk 60>;
+			resets =3D <&scmi_rst 60>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c0: i2c@2004f0000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x004f0000 0x1000>;
+			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 54>;
+			resets =3D <&scmi_rst 54>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@200500000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00500000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 55>;
+			resets =3D <&scmi_rst 55>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@200510000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00510000 0x1000>;
+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 56>;
+			resets =3D <&scmi_rst 56>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@200520000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00520000 0x1000>;
+			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 57>;
+			resets =3D <&scmi_rst 57>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@200530000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00530000 0x1000>;
+			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 58>;
+			resets =3D <&scmi_rst 58>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		arm_cc712: crypto@200550000 {
+			compatible =3D "arm,cryptocell-712-ree";
+			reg =3D <0x2 0x00550000 0x1000>;
+			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 7>;
+		};
+	};
+};
--=20
2.34.1


