Return-Path: <linux-kernel+bounces-59321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BDC84F554
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CF1281667
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81724374EA;
	Fri,  9 Feb 2024 12:42:01 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2099.outbound.protection.outlook.com [40.107.239.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598632E847;
	Fri,  9 Feb 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482521; cv=fail; b=kGS810MAw57dMl5sPgREzD9FA3Kos1T/wxtfpcEVWWgABkYW3ynEu869j0CJTD8GqLK4omTJ0Pny0jtg9TF8PKDUv/vZjPDKzMRIMaZtKuVml0Nto/EiJ0Uoxddlg8elrrTxzYAxeNIrincguOWr+9DxIPb7Jt/e4krZGKH/9bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482521; c=relaxed/simple;
	bh=bmHiOXakmX8aFhnp2RqV4JTstKmsfWW5sShPvgSwFec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jww05qGtiA5M1cTbtcHy346bStei62k7HsCCfG0lwc0uIGk3WDp0zdxUyyoD5wSz7BH1c2dtLCO9rGEpQMs1Z2d8BKfZcO9THxjm77+2o5L/bMsJT5o2fvGB8QyBiQ4o7vFSUqmwd1p1xvMRTHALbondMQYPZ9A5Wk81/hB7LD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTbW+iGScD5LXhk9y6hkKH2zQfZHrswXiOxkTl+2ju3gkDlXKFGnh9OFKINpcIsMDydIy4/uFxT8VnSWDc5n2JI8G2vsgrUedfKL5IkKJHuK4GoIN4iT32mswbY1fDweUSqc5Oa/UO7nYpfw2FAhgWv+Bp0yULI2kjW8eQCI8DKNn1hsrwpy27Pqp7Gzsj8mEUtAfTkjur1Cy/TMrsYr9Z78yyZPIKOSlbPU9Pd+J3fHEixbm4wGpVky16JJhi3ZDLu8OH+2qtH9/t5CA2ACHqCV/plQPhLLAnmD3lF6KQENaxswb7ioFf+8o//YS5yz0ElaQqlm2LReubkSJtT5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmHiOXakmX8aFhnp2RqV4JTstKmsfWW5sShPvgSwFec=;
 b=ElqSKgi8xB/0nN6j/1ILmHw5LuLyXi2Fp3hStcIY/KyVMOOFcj3IPzlSh1/fICgIST2nkb7/atbR88E2flRWlTaRvV3kxZoygP54yxRLpmMp3KiABsWPQ1118KgjB5dw+sLHwyIGJJOA5Bqs1e6D92Z8QT8jlI6xfocG/Gzy9HRCbS8YscogJjgP19srmQdFMENKMZZWnIB+V8HaE18hEkqtbPzDgb8gp8/McBudgTpEq9jluUTCUfoAZnM4JhMjeYP8F11S+89WyAP4xZ0FuIYocpxODiwJkr4/PRlBTO3GTX9m/swph2IB26ZguoBesWBMoS+V8mjvTKo4fTZ9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN2PR01MB9746.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 12:41:55 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.037; Fri, 9 Feb 2024
 12:41:55 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: "sre@kernel.org" <sre@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Topic: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Index: AQHaV/IXnFbpZ+c/F0qcNLK93OyLCbEB+aEZ
Date: Fri, 9 Feb 2024 12:41:55 +0000
Message-ID:
 <MAZPR01MB69579A5F5DB7BAEDA31E03E2F24B2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|PN2PR01MB9746:EE_
x-ms-office365-filtering-correlation-id: 9d245599-c05e-42e9-a9c3-08dc296c7f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7ZyI/5wM9rc7gBcEVqyhZRvLNGNQpi/6ukTKJ8f6AZmvmtaixSmLazA95HKzeIdGkoERywCAEiEd6qM0xsRumySA778dnGAnTBQHgiZUq43kjNXfnCN2f+23Ocv0b0Ji4W2zeqKgM07xGQGN7jxhxqf2tAeZAgFYxg4YWKFbvYlkSJ2hfY9qC8g52SQTlkJPsoWDfTi1Vt4YH43nqmP0+0FKXO1vs7o4tzvaQlGLWZO1/j6NJ5Gj5Yp9Ss4ghVyfT7utp8NmPCiVuzK5BAmm7BXXcugDKyXveogdSn4gwJKbD1YgwocfmHEPfftZkfLa3fH1040Z8deceI9I5d/YwwVsF23fCk2r0Zj/gzy5JIodGEftB+7QoInqDEUb/pNatQeCXQ0MwE9iQOQCK3zkazgWl1Pn+nX231o9KG4zoyrK3wZ/p7wPhCQH7eYvUGGjOJp/zOdaAIbhhugXWWFhUr2pxF7LUnZ31Bkmhw8IALzz/7yb1RjLmoji9v57UjeoZtBfxlu64gZ0Q7R/uzFFPITR4H6goTR4KUfjlSQyV4QPgTckBPx7F9fJe4BTAv1XEoIgg8ytkGHpPZTk6kTikwjTkU9BfHeejTwVMLBuYAKyukTajTXOnUkwUz14Ev2E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39830400003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(44832011)(5660300002)(52536014)(55016003)(41300700001)(122000001)(38100700002)(26005)(86362001)(66476007)(6506007)(316002)(64756008)(478600001)(71200400001)(54906003)(9686003)(76116006)(33656002)(110136005)(7696005)(66556008)(66446008)(91956017)(66946007)(8936002)(558084003)(38070700009)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?U7C+DBhnc3pdDGcHXPjW0IJfX9DrIAxOyEClKvNqKArYp27yFbuGAsQOAp?=
 =?iso-8859-1?Q?15YM0v2fdLuPiTt/ftvCDT9szZRrwo1fXHGoxktADSxPTQZkAJVZkUL5mq?=
 =?iso-8859-1?Q?ORW8oixZizeBBy2gSli1w28sMZT05gPkbcX5PR++z76/68CYxph61fzn4z?=
 =?iso-8859-1?Q?TO05RDen1AEem46DH7/KC9u0t9sma5hsnfZ9G8qqmEyffsmLeaprPEoRm8?=
 =?iso-8859-1?Q?BWvbJ7faoF+5mLRa43TEXO9AMhzVKW2n8+PyubpY/6Qn/eelWsnusfxs+/?=
 =?iso-8859-1?Q?jdLY9mlG2Bn/ENu5sS263LSVOxODmM5DKqScQdUzwnksDdwMxh6J/NtFw4?=
 =?iso-8859-1?Q?TobTxhovimqcGcbc8cw6ilhZKX88COEdhcAYinOyVZq0n7VxG1UCyByJaj?=
 =?iso-8859-1?Q?JjwTiYMuzNZ/b3QWHAr5u1u6xVX7UpEYuRtStAzyAO4ISgYV6C8RvMSKrT?=
 =?iso-8859-1?Q?ra6/hWP5rVtvJLpzuoFe5baGsIe7pQ5ukmzI7SlYSjX7Wfy/sh+8Ov1ZGM?=
 =?iso-8859-1?Q?0CT6SMFdmRWvNlTRHiSPBmrtxms+9TJRxlTnNv6q+Ld7+q2IJ03/vWDFE+?=
 =?iso-8859-1?Q?HOL8J7vaHUXuJnlXcWax2gv7BKt6sddVYVx58qlMx8nXREwfL2qXrSwUsJ?=
 =?iso-8859-1?Q?PGJu6P2+yqyVdbQFj5nPRMekCsIg//1x2GpgfRqMKIHx0MWr0drOzbeIM4?=
 =?iso-8859-1?Q?ELgEnP0YywBbHKXEOLoTSst1WC4Vlnfh6ne/df+gZblu4cUahl0T65VQRp?=
 =?iso-8859-1?Q?4wD3v6+BKN1zv7cJEq6vb3QxZOP7TmJg9sNC+q3lm8fgDVwEpS0chu6Lsg?=
 =?iso-8859-1?Q?mJcnPVbDPu5ZsaMlmdSGtKmij2E31gDnHThMtSbMuw5KrQ19UGuwKdoG8Z?=
 =?iso-8859-1?Q?MzJZ01C8NAY69KUofkbOkGcQaiD/OyqwfTj/YV/jUV3Li270HauyxhUWtY?=
 =?iso-8859-1?Q?zWaK3K98f+LSIzgpT8JSWFdwx9Gyz+SnV9jP64DojvJLh10alLFoYyaJdB?=
 =?iso-8859-1?Q?ZzISmLfSdiiSWWcVywFEwSsp/RFpJpnmZ+aywzqqMLRnkcpV+i1IHy/+WD?=
 =?iso-8859-1?Q?mEJb9vkMCnQr8twjiKADLAzBxFzygI/0lG6YXUcT3lALWKj3fOSRgSJ6Zo?=
 =?iso-8859-1?Q?90G0dnDUzETTugPGPtHRmP/T4/diwAsX2MimQUGnTNaYa2HCHYo/JjBvjj?=
 =?iso-8859-1?Q?RVIuHNWJin41/IRp5O9Ax+wya3HkmhGCf/Q835Yex2KfopBxFCBlmeCqYv?=
 =?iso-8859-1?Q?rJZ9j3oKVijzP1QOfi9a3aPO5JGvGlpRU3tbthpOIQKXwV5M4l/VaoPOJj?=
 =?iso-8859-1?Q?vY9aJSk7UtgxTqIIIP6bGOC74F7D/JXgpJfFo9ldiptN53NZA0WTJ1VK/w?=
 =?iso-8859-1?Q?fF2/LHmIaJ4VfISWeGr6EkCRgm0/v9C9iOzCFtyPaLTEt2n7df4SF7PN+k?=
 =?iso-8859-1?Q?LOy4vOnyedG+AAwahxVxHKBDGW9myz8XSHmT0/V+XoY8t0EUUZDUceM+7e?=
 =?iso-8859-1?Q?kDN71pNHuXdeA4RUOW/aSYt52BRgyoie7eHI5OZjwgenP2pXbKrTxJxmoW?=
 =?iso-8859-1?Q?1YohLqtfw1b8zcwYnRYkBu3J9PNS0Ukt1xaTLcJ4eXnLWSqMqZbRaR21Ek?=
 =?iso-8859-1?Q?2EWnzw3RGqdfj38JfNx+VKv3FQgSA7yTxsZIhKsN+04gyFRs8/3Zt56A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d245599-c05e-42e9-a9c3-08dc296c7f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 12:41:55.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ELmvzIhMy1LtctNIT901TwEDg4fcXXBuCyybcbwcZxQCQzkUQo5WNnZHLXEx3AvlVs4EgSeLj+WuLlpsiGzXjN0eX7Fm4lnSPNip3Illdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9746

Hi,=0A=
=0A=
I have received comments for documentation patch of this driver and I am wo=
rking on it. =0A=
=0A=
Any comments or suggestions here?=0A=
=0A=
=0A=
Regards,=0A=
Bhavin Sharma=0A=

