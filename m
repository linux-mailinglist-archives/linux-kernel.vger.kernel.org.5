Return-Path: <linux-kernel+bounces-140265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFD8A10F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3B41C21A13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05D149DF3;
	Thu, 11 Apr 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bit4uYD1"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D6146D73;
	Thu, 11 Apr 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831932; cv=fail; b=DimWXYdqBJ0H1iXSl6QB9IVsWhxHnAxQmiXTjSbrIaq7MQY8rfRJO8sJ6kN3o9C/scwAeQsHLHLZQ/vpw7OYb9wb5V+GbyWwyDvDcrPOlTNfriMek5wm85z8m/drfIsY+PUhRk2MpiPeeXSLNZgX0ndPBe6z+2dseNe0RYss6lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831932; c=relaxed/simple;
	bh=aH+ofLderdnLC2qPK6GhzcltKLxDyNdRVN2g8qy866g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEhMydXI6VefqLfiKg2ONwJMEPFiDGllqvfkAbWtAnmbWuidcHGX25DwosqkAT5rJU8gOuKgcBH27/J/FteKetFpOklkUR8jCpQi2VwR0mm8TB+DuEa7A/aTKrn+plO5E3WHT+Rh+hjNZ4YMSZ7ZPcHkuGiHhQAmGnp/4ryrlbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bit4uYD1; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B6kVBK027697;
	Thu, 11 Apr 2024 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=NV5z/C8Bnw7OyDyStesOdnhfdve7Hf2J3uCRT3UuSRQ=; b=Bit4uYD1JbYZ
	jIgkINEaKye0r5DZmysleGHM8FDGPMTBeQwWxiST4Tx0HmEWEXBllYttbm888sgg
	nVDIWyIqy3LJ58gMejBmotaaT1QRWdObRt8cemxUwZhIXcB67V2J4PR9DHiqin1m
	YHTYuMI5ijsUDFacxomtIyMywGhLPcln5KvrIDWWP7PE3G/ODAB8g1wG8ROm35ER
	izGLjwKqI0tWY7fmWszFhFe2DLusrWauogx0nKxDncNL2SUOIbgT/g3AL/WXDxRE
	XEM5BNprZcXdJmc+KMf9ZTuHFJfMNei4UF/z25idFNSh6Zrr+vAOwysBB4ZnEOYk
	x5sBbYfMdw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xd6de4txx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:38:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw7+qp1+xZw3ihgdlnaJYjxJeNBaSrY/Co69KhS44hbxmNY2m7S7sQ5ZBw3j8yvDW60m51Rp/JKC2Om58AZs4Ru305ENbwnX1TI6X/70FtOX7CZVCyy/l2nIPol2Me0a5VG6XjuZS//BGv/SOVVAQ4HAtvu1vakiGHINg9cAl53DMVVFc0K4oT0CodHlGBaNCdlsX3YUWs226WU76joG8X8chSTMeY09wdf/GFInouTRCxTqEbeKsKwEQJxeVW5GifXjlieV7epohmKOWhcS1Ve+ucTeV1Ux9V7M52TsjRPXubbFyDGxXzAJ1YsnuOgjQaxkZqqq/RoUpGMX/jbPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV5z/C8Bnw7OyDyStesOdnhfdve7Hf2J3uCRT3UuSRQ=;
 b=hMLIWaWxc5JXiD8mh6bVKhg2OdOSwiTytj1ggMsXZnRbNqYQsZlZlcuopFW/2DfdHgtuYYXDOLrCvQlCD2Box1lBo602raUeGq12mI5tJAlwve26QkB3GQbLTkzsWu4hvIGJ2eV1Aik6KthThQpRB0xIfcYwwc2lWjsZAYiE4kGJXV+JOQZ9Q69FXC4LZFj8SwSW6Zy4ofOZCIzo68FzqFMbglCIxYORqFop7YiPjn21J5b0fx5PEq/goXDzLLh3Fda/btxX3fbm15VWYfXm4UqDAA2JMus1XTMjTlKzxMOjgo+xTW1mkwkcCiEBEh8MSCoSMuR7AQtDQJTeydLl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CO3PR03MB6774.namprd03.prod.outlook.com (2603:10b6:303:178::18)
 by BY1PR03MB7213.namprd03.prod.outlook.com (2603:10b6:a03:52f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 11 Apr
 2024 10:38:28 +0000
Received: from CO3PR03MB6774.namprd03.prod.outlook.com
 ([fe80::45e2:56ea:540e:cd60]) by CO3PR03MB6774.namprd03.prod.outlook.com
 ([fe80::45e2:56ea:540e:cd60%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 10:38:28 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Trevor Gamblin <tgamblin@baylibre.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/2 v4] dt-bindings: pwm: Add AXI PWM generator
Thread-Topic: [PATCH 1/2 v4] dt-bindings: pwm: Add AXI PWM generator
Thread-Index: AQHaa/6i41R8h8tWz0mYC6f6IcDfdLFjHzqAgAABauA=
Date: Thu, 11 Apr 2024 10:38:28 +0000
Message-ID: 
 <CO3PR03MB67746D2CB47F5D9D9F96543D8E052@CO3PR03MB6774.namprd03.prod.outlook.com>
References: <20240301173343.1086332-1-tgamblin@baylibre.com>
 <20240301173343.1086332-2-tgamblin@baylibre.com>
 <mf3riwux5cwr63w6i3n5mh4g2yrn4xeywbhce3izldahrb7lw6@4tvyt6pkfixr>
In-Reply-To: <mf3riwux5cwr63w6i3n5mh4g2yrn4xeywbhce3izldahrb7lw6@4tvyt6pkfixr>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy05ZjVlN2Q4Mi1mN2VmLTExZWUtYjhjNC?=
 =?iso-8859-1?Q?1iY2YxNzFjNDc2MTlcYW1lLXRlc3RcOWY1ZTdkODQtZjdlZi0xMWVlLWI4?=
 =?iso-8859-1?Q?YzQtYmNmMTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI1ODk2IiB0PSIxMzM1Nz?=
 =?iso-8859-1?Q?MwNTUwNjM1MDk0ODUiIGg9ImMydUpjenhscDlXaEVxb3Vwa0M4aEtzaVpK?=
 =?iso-8859-1?Q?VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBRHR5WjlpL0l2YUFRcjFHQlh2V3pLV0N2VVlGZTliTXBZ?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBdnNHSmtRQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO3PR03MB6774:EE_|BY1PR03MB7213:EE_
x-ms-office365-filtering-correlation-id: 2798bdbd-5e12-4a52-2875-08dc5a13866e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IgQZi1e2jCR9G8qnAmoFbuHmWSJ7Rf+i0DEwT8AYC36HikQVtNBUcGVsHv9sbNDJfEm6DovmMykAkXfUZouPFfWSATubvBL05QYbiUJWZwvK/S3eRMFBpwUqmoZdN4VPSi0KU6yu6x4D5PpRS629S9bpDdDblSv2HiZerEcR7IrB4GAJa3VTRYwFLK3pQXgUcgWDpo+bxAyLS2L5MLCvmq/gu7zXLiwSevMMgTMGFyI1MiUDwzrsPv9GlRN649PQclbf+B+YfeJKKKgs7UXKAuTok5Zd1Ea4v/Bq/3T9v4FUTRTldVAiy+8uZZp2YElsSRYnqZV5LdUVXm3ZUXxMJqIG3wQ4OPztwJYZC1gTJPLggwh/U1uFzONGfjgvHV+tFBR/O9hd4pjAr7lybbz6TGpEWYJDwJNcihcqh5QTI8jU+MU9t9rddA3q+7LFT6e31a1TFPqJ3lWpSyzqY1LTmaentEFkoECy1MJtNkh8jSWN8gSNA59fYxPwrR+U2EdopVfg9uNLZdXdx4HCEQyfgncEFtWSVgROpfGJFQqwbM7l4sqMyELudlLhICQ9skGngNBQ3Ve81HMGVAFYgll7Oa9UQhXiGlu2qH3XnCWN+0OFdAeEWCulU0Jgl9ADJ+5JR/aNcZ/61LtTN+7Q/WbMfBaQpyPu8SYkyS1Kn7Xx4AY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR03MB6774.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?1l8J3FXYg4ODMcLx09p/iwBXf0f/2piHzMxjLZicnD4pdjoljiOBqR4r9z?=
 =?iso-8859-1?Q?WwgBLChAtKXc6F7JPiCrLdbaJBOAnOvBXsXnbG3C0aO7rpKQ7hsQbgnZel?=
 =?iso-8859-1?Q?6DsjW1j/KqxDnCEtmZ0nmMkoiwCY2O+FhfFyj3nBFafuYz6IfLv2egkqBa?=
 =?iso-8859-1?Q?7IwwlPOQOosoAvQEFCthqMfMHAZNHEPYFTSvp7g7ELBnHAGUPmv7buQeGR?=
 =?iso-8859-1?Q?Ug3GSFI2NrmvDmrd8CsURFGKFkAQ1CtpiAm64aUPn1uGv8ZhXFlphPXtfL?=
 =?iso-8859-1?Q?pdaZ74LGEpESOInpYrUzjA5ERNrB3sD6ukHLl7o9PaGMqszsuAiVz4z1B7?=
 =?iso-8859-1?Q?bi6Cgyb1hJxBM5s2t8KxpTfrDvIOfDOJsi6rrQP4GexsDYEH4M01KdElcJ?=
 =?iso-8859-1?Q?fUgNAt1bivC+fEqrJzGPkUdAUlMHIomP7trFiL0IZoE1FL36PvCSeu7Nty?=
 =?iso-8859-1?Q?zXiSePc2fLBZxIgJijBJq3Ia7YmAqJPscR9osOidWebUHWDlqmM7iEyq1n?=
 =?iso-8859-1?Q?fyvmkYCLk1GXOke8GsWNrrCAgcTMOLv5FgY+p4ZOSHhC0td3KtaCvhRYSO?=
 =?iso-8859-1?Q?RWQxkollbP831LDsewATZilzYlfzM4shVCx+y4aQiEuvBrSoMoOGvaQCpL?=
 =?iso-8859-1?Q?oAoE7nSYbHUt4rVuVRPxq0otBMao1CbpkTFti9NMY1BtS0Fy8KZ2T4WlFo?=
 =?iso-8859-1?Q?ILKYIe7yXcSpE6nXyZDsjU+fMxICiv/ydbwtimvSro6n5VyanCyDm8xTok?=
 =?iso-8859-1?Q?wk0yHboU8xSXWrl/dzhzAxUaAZSxu3axgwVmq2a3WGNVTpigs3A3KTzcAG?=
 =?iso-8859-1?Q?FCGZflcE5iyv/p6cKsN4GK0iKoZk3LV92jp7e395x1/499B+eZEkxrWcFd?=
 =?iso-8859-1?Q?W0EZEujDr9LoBdqHpGdGLwKMEa64Px0Fx5CYfP8SVKMjduzAd0d9ZtRC65?=
 =?iso-8859-1?Q?W5g6gZbIQinhQ12x+jPDAiOgR+afREhSRzcQdhuBiMTm3fTsmoTy3ugkHK?=
 =?iso-8859-1?Q?hRg4fZCHjnT9LXCfE78VS0Q4oQvATRWIdYpoZJVxfwVs/NQZXG5gM9st72?=
 =?iso-8859-1?Q?V5qEm+ZlVPeoHqyXvnE6gHCxMBKlZYqi82yIhyqdMxhq7o0CAlKbjamSzi?=
 =?iso-8859-1?Q?oGtGNnInMZCa5zRDotcFvHkHrU7D1ecn+POAGHdbwv3myy8r+6HeRwX3hD?=
 =?iso-8859-1?Q?/juhKwzk58NxsKgKUnqwTxmi8iec2C6e7KQlU98T1TZEzKsYsRlA7A0czG?=
 =?iso-8859-1?Q?RJmsBUVMdx3pdn4AzfjKp09hCwp3nxpf2OkS6q6lwejIv+Rt+g4J4atLji?=
 =?iso-8859-1?Q?c6mu4QFoCVMIJsXiKv5yHSWQOPwewqkhcBJMsK9HC7fBi/6g204BXL/xyR?=
 =?iso-8859-1?Q?4jyqyfSYzk2kOrAOJ76UxrAHYng/FTw0Ghp221PJFp75wwk1T0Itwft6V0?=
 =?iso-8859-1?Q?/Ye5dye7NAfSlpAVlRZ0s6wcwyqyISW0Qjd1dJQZkjw+eROnwjINXmd+hS?=
 =?iso-8859-1?Q?5l54xonQ0+rzcLpV/wNX64zsrUzLki+v9NAMZSoSNLQPfIng6Q5zWiavXc?=
 =?iso-8859-1?Q?S6NCCRSNPcNuaWrBwaSX7XR12xq7Haj/06XQLclvYRDcpgCRskL4lPGe2X?=
 =?iso-8859-1?Q?L/CvwpLk0lDFsVAWu6v6xHZtcwixSFoqWi6MPaRSDOpUAH/xQlN/ML2Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR03MB6774.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2798bdbd-5e12-4a52-2875-08dc5a13866e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 10:38:28.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMXjpxu8F0NTd27txlCVpanuxWhar8H9ZDYDS7cLj0TIxryZNUuB4PfDQ7wpWCV1q33MGfZZR0Of3HakQ8LB5+MhYgKJBxcvZ0l7+Vc8mG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7213
X-Proofpoint-GUID: uZOU2GT_W9HYHLB_gd2idwP9yNCVBJ9x
X-Proofpoint-ORIG-GUID: uZOU2GT_W9HYHLB_gd2idwP9yNCVBJ9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110076



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, April 11, 2024 12:33 PM
> To: Trevor Gamblin <tgamblin@baylibre.com>
> Cc: linux-pwm@vger.kernel.org; linux-kernel@vger.kernel.org; Hennerich,
> Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; devicetree@vger.kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; David Lechner
> <dlechner@baylibre.com>; Drew Fustini <dfustini@baylibre.com>; Krzysztof
> Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: Re: [PATCH 1/2 v4] dt-bindings: pwm: Add AXI PWM generator
>=20
>=20
> Hello,
>=20
> On Fri, Mar 01, 2024 at 12:33:41PM -0500, Trevor Gamblin wrote:
> > From: Drew Fustini <dfustini@baylibre.com>
> >
> > Add Analog Devices AXI PWM generator.
> >
> > Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > ---
> > v4 changes: None (rebased, added maintainer's previous Reviewed-by)
> > v3 changes: None (rebased, added maintainer's previous Reviewed-by)
> >
> > v2 changes:
> > * Address feedback for driver and device tree in v1:
> >   * Relocate "unevaluatedProperties" in device tree binding
> >   * Remove redundant "bindings for" in description
> >
> > ---
> >  .../bindings/pwm/adi,axi-pwmgen.yaml          | 48 +++++++++++++++++++
> >  MAINTAINERS                                   |  8 ++++
> >  2 files changed, 56 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> > b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> > new file mode 100644
> > index 000000000000..63461920a362
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AXI PWM generator
> > +
> > +maintainers:
> > +  - Michael Hennerich <Michael.Hennerich@analog.com>
> > +  - Nuno S=E1 <nuno.sa@analog.com>
>=20
> Would be great to get an ack from these two.

Looks good to me.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> Otherwise looks fine to me.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

