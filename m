Return-Path: <linux-kernel+bounces-158254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5D8B1D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AFD28684C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37882D82;
	Thu, 25 Apr 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="BSZ+p6f3"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61918839E5;
	Thu, 25 Apr 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036556; cv=fail; b=T+t/GpWAnuF1FsEE9WzLyaZltr5Pz5qTsYJN5zsw2x50IJlkXSvrAkH/7CzwiOE14VGCOjp215XM+ipIlbKJEJZDyEQY0cs8ZczXQ/Izu+u861OquH06KoxSuKKUohE9dSpVKkqcFcBvDZkDo9qcnCIgvcPb9l2IJemDwgDH8jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036556; c=relaxed/simple;
	bh=B/zADlbqzAH+NIvoh/ZRP3Ehfkp5fuyWqXJlXTmRJqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+F48bUxFDMkLjYag6V27ILAMoimGAUL7w2II8ae1OCLgEE5uE0P4YSqa0YND4JKu5mlst7s1jITN54QpEzNMfsIInqKGNAOhuyyJzU/clePkGtJ8dt6rhUh/gtKdZHGeEfVFrK582xsNxYNwZnC/Wj3RXcmwzozN+tfR+ah7eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=BSZ+p6f3; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FFaQ011736;
	Thu, 25 Apr 2024 10:15:18 +0100
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010000.outbound.protection.outlook.com [40.93.131.0])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:18 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbeVcHzzGJbJMu5Vq63Jn0AHn6aaJIY0j60I+hpJkXXkUCW0IiZj+oyrJlJucXTGfTFCe82VtwQHdAN95+8w1uA5yvaP4DJOr91FQxnBEqornbK/snrh/GO/oQQljfF8bjY3ZAzJj09Xf2SsLGgi9xb1Uo5rZVd5sBz+qwcD6unc2kyEZCK6BTF2mtSJ04IEXAL1ssoU2HutwwNj9RrrdWZD91+fxgju92W6eBls6e/24BqK0+OjUGn1w0FN7baxl9T6QrnT/OCc28NRmdrOIW1cH8k0btD5oXuJfjvBpjajm+chLMlkGOTOS/hCscovVM9NCQDcXlQmeVHc2nDj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lvL1TUn5Yvj9GLuw4qtYmS97NZ51w3SpKX6nyCrdOg=;
 b=ShEc7QOX6ghe/zzMHsllCCjLLfe/eUH9fdCnGMpO5RX12M41xO52ZuPcsumbKeJrZAGhvpwz5hRjgJJoKpiAwscXeC9FUbvqbMO5uF1M6ND0Njr7UrxeYgq78XANqqF1gv7AJGgKwAsr0WhT4NtLhjp/8Rg8p6vOWHeL3s/JgUiwJIiK67W3KkI2PZVNmoyTq9rSt5FeP00bDtJ3mIp/3yNyxWyJfkDjXvcn/Y8+MtVUE5ZFSzI+AXAslrroedk46O56jy4fl3NQZHNmnwoOQvlT0pS4cWMXHPSP/+lqzXWDWyaQ+Wn7L2CG+DFAAQ7T/tqHIkDAJ8oQryddzHl+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lvL1TUn5Yvj9GLuw4qtYmS97NZ51w3SpKX6nyCrdOg=;
 b=BSZ+p6f30ytcdyipFwg3w8sUoJdDl5oP9Bs+Kh5lAtKyXDRuoO2f08kLN6zG+XZfBN6ZjL5QqO8bKKHKqhAU+nL1kVyLssxSsNlQrVEqLDcALHov4IG4OMmolnKVUo2057F/R5kv0JxbVsX4tImMXVYE8nqgFsL6k3XqPSNWrYU=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:03 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:03 +0000
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
Subject: [PATCH v3 1/5] dt-bindings: Add Blaize vendor prefix
Thread-Topic: [PATCH v3 1/5] dt-bindings: Add Blaize vendor prefix
Thread-Index: AQHalvEOV588QeieAEiOPEbJljZFTQ==
Date: Thu, 25 Apr 2024 09:15:03 +0000
Message-ID: <20240425091403.17483-2-nikolaos.pasaloukos@blaize.com>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: 8c54136a-f5e9-46f3-e917-08dc650830e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?k/A+Q2uGDjGi+tbRZ9GjHxJHpYWJF/NumnmdTulHT+f+v7YAO8cVkHU3QR?=
 =?iso-8859-1?Q?Ejyq5RMjwYGs57y+jJcJBPgde/pEniTjc0i91ssQT8HIYwiqGhQx+oHrRJ?=
 =?iso-8859-1?Q?0GKwnBiPPx7MVcYN1ox2YqtjphL8JaH5t/ibsMICYQ2ad5iGS/VXIbtOfQ?=
 =?iso-8859-1?Q?LkTmpFKdvZ84WxXg4TNgA9BbGaUiccXFGxR1La3GBhTLm6kVr0eQDed6o2?=
 =?iso-8859-1?Q?H/OtPdRo4z/M2+I34RTPHIX1T82afbixBjhS0lK9XXN9xWYgoW1sZuVRZn?=
 =?iso-8859-1?Q?V4RMzzcDtj+diQ4ltBVsr24GvHPfLl9TfY57XaUM+7ROn6YCB1RPDlwDiY?=
 =?iso-8859-1?Q?B4W9Sk3LQdDuQe+6z2sBxr9DlEs4jrP2kVdTb0MV9CpX/dMI2WDY1AxYO4?=
 =?iso-8859-1?Q?R9+XOjKJkQPLokm79/s8lgOOB3XJ6bzQ06cQtiN3yatfWk4NQ/GCMbZYiz?=
 =?iso-8859-1?Q?CaV9fPF2Ndy9MNtuwO6uYz2LzXtb7wqRSYoJYAiYpWV+pPwLqjIQq4tPYP?=
 =?iso-8859-1?Q?5r4fSFwG5AHtFqMj8KN6RmM7z8R+itNi69K+j0q+TlAOqJevNRH2w6mX+0?=
 =?iso-8859-1?Q?SRybABaxpJ75NmG5eeLxRnnjBsSk/4xSMFEAYTmd4J+8v99OWpUVfXRszb?=
 =?iso-8859-1?Q?gj0QBFYFgjpVABRu6I9StUhUGtCveR7J+e1Xm0mHjtCRVjNT+xxq2CQ5rp?=
 =?iso-8859-1?Q?3GNOT5eEhc2AwAUou3Dk238szU5jAdhyiwf9WccR6rzSpnqYg3C0QsQjkk?=
 =?iso-8859-1?Q?U/nfFXokFZpfidAVrugEUdz9XA8gj9ZqPGltVeAks64Q5Mx9g5y7jJUgga?=
 =?iso-8859-1?Q?NXDSXBGwlj0AVQTyb6/8BgY8tV5ycGk6eY24fkPNNuY7waDVzzPipJvkCJ?=
 =?iso-8859-1?Q?kLJbq/MkOjQM84HMstkdPfS6hy2IOpdzcC6guiDWjFXl5mQoSm1PgmoNx5?=
 =?iso-8859-1?Q?8daAzB8mNWlFcSwYbHiLxiewlCtlYbXLItWuDTRdN8nQuXiC1KvX6QYK9B?=
 =?iso-8859-1?Q?LPQF6XKQF7m9KA8vfCmxllIRB4fRH6VwffS2B2LtteXEedPpNqfh06O1vh?=
 =?iso-8859-1?Q?oC5HEpTeSQJegLv5jWDt4yxcjOaw5gOg3fDatiGYCcXkaG5vpd1rpSiWxl?=
 =?iso-8859-1?Q?41VfYs/1CGnRumJfVAzNd2LVdSgDXEOhx0WP+8SI7lkDpGaOVrlTUdY+27?=
 =?iso-8859-1?Q?7xivUPrQpEXyR3vJj8F7Mx0zM7zVg1X69LHzmurzOKJGRdO2hhOZ6RL6vs?=
 =?iso-8859-1?Q?UdnbvJPVwDmME6J7vAkWcLK/nidrKP4jD/27r0rmdjppVaAyW9u7aiRhKC?=
 =?iso-8859-1?Q?S/OH7McaNM+pU85O1mqP6drRxirT0pxzYqkzcGXQG088Reg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2dmdMLl/OJ8KBNp9R/u1s8k75SnhEwqPBNtE2NSHHgEpsPdramciFn0LDy?=
 =?iso-8859-1?Q?HgT+7K5NXbKh+FBuFbL8028aEP/AEtuNVbYfrUOY6EzfiYhST4rcQ8ehKK?=
 =?iso-8859-1?Q?vCoS4o1uXbV2lrJnSjNhgol9ZhKkA3Wwt2nCrjt3Rm8BZ+RgM8rQdp6egB?=
 =?iso-8859-1?Q?FqTWuQusIJlY3XZJCiRZMwB9HZMxDWrWbODAVI8elMQ8VszNYmh17jzVqZ?=
 =?iso-8859-1?Q?4+jiJuFzsF1baT+99H9jOGQ6rNW+r5KkyJGGx4Qvwj1II/gKowjVbF+kt/?=
 =?iso-8859-1?Q?B0UAdDSWI5j3CXL5u3uroYY/yJVS2Z1UJyAaB4roIePMYX96PtHMyO8dDU?=
 =?iso-8859-1?Q?Hrj0/Emkf0W1cn/cwEgU49KOKL2bQPrLpD2JsEXfFqY77V1ogNsxzto7VX?=
 =?iso-8859-1?Q?gc4GDZNq59GqO5fyqtH7RowCRH913Ytk/aXHBzxpBmbnP9uyixnnKRakYo?=
 =?iso-8859-1?Q?wn0H7NYpf0ps6FQ9qBaJu0u/iS5WVE8/X2uDGKCa7re9ACbrk6qdm1R0qx?=
 =?iso-8859-1?Q?l4i0BFJHfWKydG3KmBRK2ZfhsVF5bsIyjJMkMPUHlReCAl0UITnnVT0kb+?=
 =?iso-8859-1?Q?YOs2Y3c/c1BcOKeD708vy4dQ7Okv1T+CRmM/wdf9/7gH5gJ3NlfGSEvJxv?=
 =?iso-8859-1?Q?w5uPLUWI6CBaUqkH3vda28pyVUECEK5vsrV3hKAYwjJRfTRflM+cQ2l9cS?=
 =?iso-8859-1?Q?zwoqFg7pEq/I+fBvrEFVagdiNDUz/5Htwc1wqerP7d8zh3YUkrD47JfBQq?=
 =?iso-8859-1?Q?Sj/8I3ePeJAf9vw8iCWw9r37lSHb1AE3UBeQKl1fdduB2vTC8VRS4PG2aX?=
 =?iso-8859-1?Q?l3vGXYPpVhUsXBUEnQp6Jst/k7MqC2MonIE+DSJwNF6Y2IBdbhlL9Kdqwr?=
 =?iso-8859-1?Q?u5IfXiDxc/PaZB298GmV/r5JmJH6T6YKrfHmrSGPHSdPc/04z5tdsRzwA/?=
 =?iso-8859-1?Q?jN4ao1kX4rYFBlBSM+4Xs/A+rnTMmt5rTs/Us8or4Dkzkp6LbVcWZf9Jsb?=
 =?iso-8859-1?Q?v+phmeLJhF5rdBnQ/sL50qM1laSkv8chSPDAziglZW+nUQTg1zdJwR1J0U?=
 =?iso-8859-1?Q?pNEwDYxKmtqoadI00DOqJva7PQ1IaKTsY8SHT+vGsGzaRkCRP6MmCapisA?=
 =?iso-8859-1?Q?J8UkialLN7Q/fVx5rI9T/p8ea5S3L1IlPfNoAfSpbf/gqLyzoZn/EKnuOd?=
 =?iso-8859-1?Q?ZNysfxg1IbpdXzmYQI2s5iRfisrPFH/B+SdfsQrc/BC5vpdeigakKRmGYo?=
 =?iso-8859-1?Q?YoCMCMmuFUwQ3kG6FJdg4qJKnBbeYbjhvoXFrxbn7MfsTR5DvDQbd0A6vQ?=
 =?iso-8859-1?Q?TytvnOcn+J8tG2ZSyALXDj1CLwdWmah0h7Fw/B5EiDJEojRE0xfVx2A0ns?=
 =?iso-8859-1?Q?0vjm4MG8Tv7juU+q4UobMgOH6P30TrNueVzvvjnpSdMAVRUpJ91nRYfylC?=
 =?iso-8859-1?Q?B0iCcmWMG3zljBgeasktegEl2SLjWlWvvDRL9cvzko62cnC8d5/1R5tL1A?=
 =?iso-8859-1?Q?Qazy1Ko2Ta3AGrWVoXUjl2mF1e5FDnu12HeKxpUAckOBBJmawqfDFa512y?=
 =?iso-8859-1?Q?k782EcLpF3G73PQ7LHVsoBsoL0OQ+tZ1AF7a5bJYVZbxnfKjKM9s3TnTyD?=
 =?iso-8859-1?Q?cdMs37pEEoAF6panhLk579k2gt8DG+pfGOZYJ+HDjFke/L5OVk2TWMBQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c54136a-f5e9-46f3-e917-08dc650830e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:03.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNrR3HJ9zAz2tCx7atEFakmZ4UJkI+SQmtQuXQpCAdyPOltLaMAA+PNKIwQ9aTUyZ113ok1xm1nbm01499x7aR07FTa5olS1j3DovZ2ZGvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: _akrSW6LW2kWxSi9e7IuVYWdG2UlaVeQ
X-Proofpoint-ORIG-GUID: _akrSW6LW2kWxSi9e7IuVYWdG2UlaVeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=954 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
programmable Graph-Streaming-Processors for AI and ML.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..746ff14028d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -214,6 +214,8 @@ patternProperties:
     description: Shenzhen BigTree Tech Co., LTD
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blaize,.*":
+    description: Blaize, Inc.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
--=20
2.34.1


