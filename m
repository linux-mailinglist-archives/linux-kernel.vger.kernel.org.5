Return-Path: <linux-kernel+bounces-158258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C68B1D96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B927128639E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519B85942;
	Thu, 25 Apr 2024 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="ZW/mUDN2"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC584E0B;
	Thu, 25 Apr 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036558; cv=fail; b=a/mGt0O3/ik2/bvFKk91KoomaHrdrFOF9ithVZu/TOHStlS4WD2ZtNqAwbJRaUsV3UNFLSYXmqAPKu0zSc4OtQw5rYCW86InzYQmmOioYXTbRijqQw8n0KA4UsRpYA6A1n2NNaWBjzudO8VIamuHUUhoChIvPg5n+4g5cyEPvBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036558; c=relaxed/simple;
	bh=MlfRmIuGRiTyr3pFbKo2pBgzrPelpB5jNhm6CCx4vIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOrskuvQhQP7kpJ6RHJ9K+PYiPgXjyY9joNIdoSaaHRKVHMEsJAAktEFrIq9dsajFFAODR9F7VAProajML+jhYJ/lcnvwALCKo1bfNLFTcfVWkZCpMqkQsxHWb6yZbouRWLzCU4gjygjqnPGBT+UHCiL5re1qiOEGlVhT1TqEQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=ZW/mUDN2; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FHIT011746;
	Thu, 25 Apr 2024 10:15:21 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:20 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+PMHhidIjeOX2Db12KhhfVTQKI/z5ziVtSNe8bxyDyKVIyP8yChL52onNBgzCm6A3F+CAwe2p+hZaZDZOCcJgRNE1xg1n7TRQTsmW+PvRMz0u3zugNKSIEdqEq9m1E0fgHYacUclvHJ7WiA3m97BBO3U/mDbWs0cRUwLoNEAFw9lhSFti7svDVBCAXlPh/uqahM7BcEYhjrn3oiQiL5rnOQ/SXt/WrKNxurx4S8FPXXnnaqaFMdpuuPDwF+SF+3S3CJKlg4eIba//8WYPfb9WMX/mAyYRWSzK7HlDtFuC85w2caW0jhbF2FJnMUOjrMD6o1j/6Pco50c1p3x8GQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlfRmIuGRiTyr3pFbKo2pBgzrPelpB5jNhm6CCx4vIE=;
 b=Jnx/4a+VvfWhpDu+xoBqcy1M5oF1BOn1Y0ZrrbuUFyreMPwWU1MBkAO40vLz5hULajLXv2sKgDH1qpXrgZ1m5EKFukL6ybfL6Gayv8qRUD6Qk0tQ65Uhhq/whSHzyOIN5iRqoGVS4E1Jv67JoIDpwIKqW5g8VckjTW5+rFSF+pLizWHfvzyN4H7T03Yl/uueDiYNwmX5jkluSRmRvCb6gU678MADGj+dfS6Nb80LlAgyITA9V7j/lrnlKZfoTp3VqrQiQ1pU97UIWvyVA1REpzDincCtCz2MFhLLeCwvlFdP78mMp7K7vUAcg375LN4f0jCyygbygbkpKZLR5AcUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlfRmIuGRiTyr3pFbKo2pBgzrPelpB5jNhm6CCx4vIE=;
 b=ZW/mUDN2ZXvJUKgLGeUw6AvsijWwvCnnMfN+eUD6xrou5HnH5VBo1LGGELXYO9QRx5iDbY4bdwThmDM30NFexbJW5EvZjfYMi77Y8Vib6BNSO7c9l9EW8U3Z7SQuonQhNVtTVGvACCb+mcQPlJG/KQ+xthS/SEmjYx8rS4xzfXY=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:06 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:06 +0000
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
Subject: [PATCH v3 5/5] arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
Thread-Topic: [PATCH v3 5/5] arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
Thread-Index: AQHalvEQwh7JmTo580aZc0gDdFDHsA==
Date: Thu, 25 Apr 2024 09:15:06 +0000
Message-ID: <20240425091403.17483-6-nikolaos.pasaloukos@blaize.com>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: 495bc1bb-ff3a-40b0-485e-08dc650832ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?IQMr5h/DeubhYyqXtKGstT1Hc6BpqhEwZTj7LWngASxqRPmWKlPg5Ve06r?=
 =?iso-8859-1?Q?+nDidrO1zgtPbCbNLeErz6GDW74cGvuwBa+hBD2QMhZZaIRS+qsMDYjXWD?=
 =?iso-8859-1?Q?tJOLW7zEX41QiJRS7PtWl6DO0Ux8AI1oAykvn0ep9NL4SPAepSnAcgz5SN?=
 =?iso-8859-1?Q?F2nLtvj7L7NrpfYnAxGZf+z0f7AMa3dIvvbPXzXgTONOl+Btn+5hGzN9uy?=
 =?iso-8859-1?Q?bWSiYZLL9AQKUoHGHwRzSERNKsB6seYysOjHIiDzkSS4Xl/EFpCwUcDGMF?=
 =?iso-8859-1?Q?seGJgu4f1BwxPanAyLa7cwAShKvUmeVgeIRuzhs8x3lHVmnT+6in6xfk4G?=
 =?iso-8859-1?Q?cTLU6wp1fmfvt5IYxFzQd3rDqRrDZfQ6YQDuze9UAvxfbL5q/DIOuv58Cr?=
 =?iso-8859-1?Q?aQEAP7nCRVx9r0l3YuTuZfHG3OvK8Gk43XB1A96Mjt63X3BIUVH4AEWOVB?=
 =?iso-8859-1?Q?mt5FHLweP3g5UmoJuwaRhfaH7Fd0wl9OhbnotUZNJGoz7JM55k3glnjXPP?=
 =?iso-8859-1?Q?xSQko65tIkPFRxVk1vx1hrpkyCFF1v15q1CGyQjdl6WFgzW8/3vXWnIrb9?=
 =?iso-8859-1?Q?HW2wbdtUb1snfMkphk8Zr5r0U7Kx8j1U2mUnVEyMxlnU55q/tjHLrsDijV?=
 =?iso-8859-1?Q?zF3SC9TFa7XVxyYINAFSJbA4vf5pC5F9abJ6/wY++Ad0Of//+adaphG3ZX?=
 =?iso-8859-1?Q?laQSgifRsuHxd2vNHKG1CqTbA+QrfT8mZAv9eJgTB+OBpeGxGNV/oVrggW?=
 =?iso-8859-1?Q?HyMiCLM3pd4nrwbkBh2fUgH93Xy67Ajrq6vEvJ+rOSESRXxGes6rhiUmmT?=
 =?iso-8859-1?Q?KDEVTBYUq/7j8Cy09f7EZIMXb3v1ThUL+2mUTkkLzQM5jJP2A1ePPijRpB?=
 =?iso-8859-1?Q?S4ZbRuYxx5/n2/NLkgceHbqHPYe/oAtTdUli3jYAtoY9uPsDdeO78C1fGj?=
 =?iso-8859-1?Q?J93w0NAt2uRmyvYCWeKkw+J26UDCI5b8weJttcOi1knnGOGBqBrPk3dgF9?=
 =?iso-8859-1?Q?QTzeAFbTuvfLNtSa43YSQMffQyj8xXqq5WA4xiKpzTqN9GHEYk2qS/bMDO?=
 =?iso-8859-1?Q?AlIJpAl1bnun0+zBMjW4IkNftGv0WqArt4ZC8FOA2aREtzH7ltCvyEbsol?=
 =?iso-8859-1?Q?hDmz2PW92RDvQhliAAmErxESqYcoIY3WVCtIdoAp5pZ3V8mdlURpxrFLm/?=
 =?iso-8859-1?Q?efRV0rML1LMrYk9GGbjX5waS3ogQicSjlBZ8+4iK/dvTssbaITHTYfCjqP?=
 =?iso-8859-1?Q?+knxwohbbg83UHgRmSaL7Ekd6y6MSApZ3KGfMn8jul6fSWf2YVUTZQoIRu?=
 =?iso-8859-1?Q?V8zJ7YJhoIEHX1TP9zpdPLlQQaN3skf2mogZNkci6tia38HrhujD1eTUie?=
 =?iso-8859-1?Q?OPRoPr6sSa5J7RcWC0xtKzQwKX9FzKfGw1YDZxBGUh/J+ib2RHwmc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Y+2XvBI7geboykKv6pp2s2VU8bfkZXdq7ix0XPoY8Ca2iem9Z7kXV7Xm5m?=
 =?iso-8859-1?Q?b7jhjDoQD0cijtuVxUfCkdukmw6gaClG6PWs5CC976tKJV4B2XHMpDoY3X?=
 =?iso-8859-1?Q?W5gJ0RWe+G/u2LKQC9K2uA2Cy4vT59bdMYynRixUE2KBWq+0azAuIMoDTn?=
 =?iso-8859-1?Q?cZ5W9cr6hOiaD+r3/MRWdL+2K6Ht8ya3MSyUHyaRzvpjJtiPrQQkAInxds?=
 =?iso-8859-1?Q?t4fXopKtDXDehtJptAoUyvO9RPoTGYzvdyGN/uYtPp087GuJ9GwZ+uhs/+?=
 =?iso-8859-1?Q?nRGhYoxP+ARTtJuZcYMF6S7vZM7KP78gP/ULRgsDFfi5WvVusCQMqs95Bs?=
 =?iso-8859-1?Q?FnNSnz63ujAt8R5g0q50DAA1KFsnmnb7nuZaRrZy6/5KxH7t1L0rL9QJel?=
 =?iso-8859-1?Q?la2Qiol7XSw2tafoa5RIzdE1DmQWqOhJL+0JJ+njG9IXRnUMmLdfsUloM+?=
 =?iso-8859-1?Q?/sdLbo6stxX8h3UDmYIgn+9JRaNWTe6ZKkoaIN7fVl/pGB82y3fr51VsPA?=
 =?iso-8859-1?Q?jnJ/TdHduFp1ea7ray2ijtwbfxLU07VgUetEIDJ6gp40abKWnTtMsRXFWh?=
 =?iso-8859-1?Q?ChOfci/sLWE1RrPPqSeuXcTW44PZ9zHAwIMN1DRdgR6l+vyKUXtIDHK3mz?=
 =?iso-8859-1?Q?tclGjxcQjlhxeAJ01XPRCHWSLoIUgDkEtVO9ZVCSTvKWCK+dKTlekmHMDa?=
 =?iso-8859-1?Q?wWjsumZgO4g64968gOIKe8zK6lAZQUsmIpqzy01mVETz3gN7GXXHpCAhl6?=
 =?iso-8859-1?Q?uPg4nIP12Gvksw1OLfYxuUBhW3z0s+EpnUxPJneCFfz8rFEDoBgm2M+A0q?=
 =?iso-8859-1?Q?rV31Sb7sgvo4ovQWbM33MQEIMaISDE4qLS7LjaPFAVuSDpU4KYa0sYh5py?=
 =?iso-8859-1?Q?UfruGrFUfmZhtpyXMZqKf3zd6k7GZWl2uH68hr5FQkk/bEBEuhjFHhNBjT?=
 =?iso-8859-1?Q?+6kM8ff+MccHB/8kBEHCcc0KL+CYfjyqhjJcHmDeq1G4dn2vBEnW+aTbX6?=
 =?iso-8859-1?Q?2axpi+9g9aKyq9kGEOcf0RYvM4vkTMHud6RZcAoxQpNUlyHYcgd9mETyUa?=
 =?iso-8859-1?Q?V4IR/FVTxwqZkg4tJ7ot+vxFRQSqdGxskYWeAULUJwLU+q2wcIsmMpmtiM?=
 =?iso-8859-1?Q?J+kAPgWQsgSCBTj3JGgi3hiN7wD03bpNkggWLzKDogzAcLONpOn1IWGDWb?=
 =?iso-8859-1?Q?zyPjl7g754bUld9/32Iro0mcJqaFzlxSY0t+GH629IllRta4P4cmsuQ0sp?=
 =?iso-8859-1?Q?e3rQDcHfwH0QwmLe+dCvekFJ4zllaY55kCLXmArqBFGr7JaXW9An+JLJLO?=
 =?iso-8859-1?Q?SYbyWHhc/ibcX8Eq4qE7fFWtYggqvz2ar4PsGHd3MpYGrirEyZjH6AVA/L?=
 =?iso-8859-1?Q?BBc7JOmqywwVtlOdN/zGN8mFDa5j51yZ0tDKlUumCZgMMZWuKl0y9JalyF?=
 =?iso-8859-1?Q?rp9pNsb7RIusW2/ipyNyz7akmrjtJls2ntqZa/pjJ71uwVlDYomyjPCvuE?=
 =?iso-8859-1?Q?ZIOYVJ9kj9uDdXMq+CDN4NV9vFC08QF13o7xPirtXRD4o8xmG09TBQyY+c?=
 =?iso-8859-1?Q?6A1FAnHowOYX7VcOn/pk/IrO3xAHtWN+R49003AP9iApfV+SGVX/0LIX7F?=
 =?iso-8859-1?Q?qPfNZdwFgdh8pgYVWV3HkyjzDS+zNlWYVXi+AQrFj24yqsC01xG31PHQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 495bc1bb-ff3a-40b0-485e-08dc650832ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:06.5488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzGQQn3WK38tQVvWbInCGz0AxcwCMJM5bXZZzlGrk8klASHUySbjuNgZA/dl9jg7q79lf562giKx2Wq67+bwZQJTzZW1AOR11xfLrCdk3wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: s2Pauj-U6oIzFgNRO2qlb3iC2L4Py8AO
X-Proofpoint-ORIG-GUID: s2Pauj-U6oIzFgNRO2qlb3iC2L4Py8AO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=800 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Enable ARCH_BLAIZE_BLZP1600 to get proper build coverage.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..7d368a8911bf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_BCM_IPROC=3Dy
 CONFIG_ARCH_BCMBCA=3Dy
 CONFIG_ARCH_BRCMSTB=3Dy
 CONFIG_ARCH_BERLIN=3Dy
+CONFIG_ARCH_BLAIZE_BLZP1600=3Dy
 CONFIG_ARCH_EXYNOS=3Dy
 CONFIG_ARCH_SPARX5=3Dy
 CONFIG_ARCH_K3=3Dy
--=20
2.34.1


