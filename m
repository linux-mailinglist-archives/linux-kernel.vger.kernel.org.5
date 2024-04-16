Return-Path: <linux-kernel+bounces-147013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3368A6E34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBE51C207BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C712EBD2;
	Tue, 16 Apr 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cslYRWP8"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BC1339A5;
	Tue, 16 Apr 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277550; cv=fail; b=HeUbaXoBRoImqbO+cypbX2HHEeDeuE6XlTi5U9qQ0Pr46+Oex6phHKL1Xn8ID9P6DQEw6t62tXZFbIJqhQEszVgC92QGcch0ZOvR9pVGQR1Qk6Z9teTr2mI9uSDetSA3TJv/M+ZF2nLHI/dqQLjKLqDScLDANSz1/86QmAQQ2ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277550; c=relaxed/simple;
	bh=EOuh5pion7J0bGNZaS/TCXuDZ4hTkGa1D2tZgbWqs5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6vqG20KG7aui0rAxFlu4q8VzBP2fUhGPUvDayS/iCQKxpLbJpQqrLHUMjnD96sdAfzCDwx9/ZoaojBGak+Kql5sRTT8uW4vex+MOfv1WIp9UCq1JuY5zKGd9Co07DjVfUDRXcP/+VmEluoAy7Q93pV0VncNajOVAFZ2fYZcWVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cslYRWP8; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GC84nh020354;
	Tue, 16 Apr 2024 10:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=JAsa2soCFImgg5fhcGSujK2WjO6gmcagciPC5j5FhuE=; b=cslYRWP8z7fk
	ZweYPFMgvn3pQzYinmY618YpEz3xGuB9hVy/1vtjxKtX52BPqtt6MGfkM+n94GHI
	Nz3+eiwgKDW7hRMh5jiiaskw7LNbTwWmPI/KSZinD4iYamdKixCHjHg5MbjUPdPe
	I/4vq9yd4XC8PSDt2x80c/GYmkZUqcpMve3bGNA3GUItpizB32gk2NppUlnRUX25
	cCs0Hp9vhGdOw2F+eK18S228A/cvAqqJBx0JuRFjTkHa8SugLL1B0AjcW7eaaStb
	W/QpRGb8AL4JmkNBIDYZFV5DjUDMDLiu+n2WcCVaujprvhBJQitzBpdtOKqTSxtb
	rkF+XYovPA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xhs2r8et7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:18:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX594AH3ROsTPNV1WwOZV5FQeUHM4G26q1oGZIZp4azIbD67lsE0yuKPvPXJlFVAi0yK0o44Wlm0j+xnZY/1cZTptl+wAqHEyUmhp4SdIjmF1PdzqH99ZIojiui7EsgLD/pHsk8+TMU+OSs1506b9Gss3NZCpMnUzTrX0FNBeXh3u6naYo2SuZF0SyhZFUvcAq/bnaco5z6zdBvDUgBRudxpkkxhYyD0gAtqFeD8J5G0jJoHDQBbdc2EoqYwMNWApgumDBg0AWSwyq4mYRH2ijcWCi7xe9n9zfPNWhji3bSva8F2/6VX7fzRivXgsbHi5IsWuR0liUXDPlcgMc5p8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAsa2soCFImgg5fhcGSujK2WjO6gmcagciPC5j5FhuE=;
 b=Wb+ZHPjio2PTV7AvaPn+0UWRzi5eXMdyBeMLNBaqt58ZeA6dTY3yfDqyvkMgd8DKq3sAF2uiTfyeJ2pJ0Nc1YPr2e+meRFIp4uMSWhjbdk/ha7P8oKaTBJZucDYJ0WkJNSTHBfX48g+kTh34ufloMZHXGSi1r+BLfYY4jE6MWYEKcPUNs9vLD2ko8udKbqSnj2Un+cQKywurFXMrFPOPv+wOij4QrquhK1QAwOZJFit+pnRpZmUhe80YzE9M7dEuHCLsXghA9+Y5NeLTDEq8v9l/kTBbrybofT+ZvLsZPN4gIW/h5Pr6zskECD3ugNOGMmiMfGWHir9Fy/NVpxKIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DS7PR03MB5544.namprd03.prod.outlook.com (2603:10b6:5:2d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:18:23 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:18:23 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
Thread-Topic: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
Thread-Index: AQHajbcKs5B1Nn+D30OGOqPbvuOG+7Fq8qXA
Date: Tue, 16 Apr 2024 14:18:23 +0000
Message-ID: 
 <PH0PR03MB7141B4F4DBF3D77F7384B555F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-4-kimseer.paller@analog.com>
 <20240413162640.77c6fc56@jic23-huawei>
In-Reply-To: <20240413162640.77c6fc56@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0yYzkyZmNiYy1mYmZjLTExZWUtYWFlNC1mOGU0?=
 =?us-ascii?Q?M2IzM2Q2NmVcYW1lLXRlc3RcMmM5MmZjYmUtZmJmYy0xMWVlLWFhZTQtZjhl?=
 =?us-ascii?Q?NDNiMzNkNjZlYm9keS50eHQiIHN6PSI0Mzk0IiB0PSIxMzM1Nzc1MDcwMDk0?=
 =?us-ascii?Q?NzI5ODUiIGg9IjJodEcrS2c3UFM5enp3emMrVXZ6UitYY2ZjRT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RFpLVWp2Q0pEYUFUa2JoaGxmYURFa09SdUdHVjlvTVNRREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBdnNHSmtRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DS7PR03MB5544:EE_
x-ms-office365-filtering-correlation-id: 8bc1723a-3da1-4d09-2a9a-08dc5e201355
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MYlBxN7ssKx/AICysPghrR5EkCj7K/n1M+kGos9agRG/B2JQq337g7kHiSWOIZxCHHMr/9ufvNLhDsnhmWAH2s0l0iMgfWQqJHa/cSDsPryv4ZWknT52YB7WDgg7t0/sSxCPJnAUbLSPttIXieCvCCaPCNIE3Cc7rv1lcBdUKM2Q3+DEaS5a95ONDsnB5lSJ3uGp9lIe0r/ocFDPraaESrgvDBj3psKITG+v6xyAgbpQG7HZfunGy84EPcd7iMi4NQrqpzzhRue8c+FoFc/v4JXENNee/jMk//6kSipglHZt7RJnxPtYXlBe+K8Oa9eFkEVYOUc6IMNKhzgG4oxhxb3xxEnLHiDGkZglP/b5O7+mk0Y+zFzDm96yoBHam49OORE0mruuCf8kHXCOhl5c5ejjIWOEpn3VH1T5MqLGKP8Q/dmQB3gcZExunn8p0CuAhq+D97QUmDAmLP2GpyNf97fPxXcgIS1UNXvwzm4ZLDWoo840WAtlkuvkQNWJRfIdlCB2nuUmWZyHJHxNzVLkLYoScWw3BkZT4IDGnk6Y7yJ9gMeY2gunvMVJXZqmNRXqHJY6fbPdkHnYc4A0U/OagLd7mGAxUJpGMccS4bX2nINtUqpGfAeL8ysdrO8ftd95nlX7qBK4ZD3QndQ//WREmbwb3BOzhHPsm1pfDUNhvHA2oleDgDYUfEwqchP7EGZasmi+z4kWQJQI1pBviXBGkw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BGscGLpfcgoCIKtVXa14swgj/L5SjT4HSmwrJu2LTSqzUQMlmaAACdhYUlNZ?=
 =?us-ascii?Q?Wqbf1iDPGkc0Yn/5SHREErqhRTjvEJKg6nI7bR6gr9YH0l3QE1hYBCCYWiQJ?=
 =?us-ascii?Q?Ireqe2Zgs8QQO5inbIFN2oR1G24NnN020M8JtC8znjjQ0jG/sGayJDp0phGq?=
 =?us-ascii?Q?Ibpg1CqqI+vxpknmDvHn3a96nZeXlHv/BMN19xsxCoPfmTrXjVFOfsrzlSS6?=
 =?us-ascii?Q?RJV+J6zKvwfrl+MYu1Jzhf7WcXtkWoRJyC/3ciT7Sqmrjmov/Qk+z7hWiY7C?=
 =?us-ascii?Q?/bYO8JqJx1Zlo7FEpDE6/+XwRGlYCdHpxWWyL6uRSN5y3rwa4/u9UncHObyy?=
 =?us-ascii?Q?Nb3O0uSFdINgHpBYe/hXAjqIrgjla6UyKI0gKXJhwFSkCarD3LwUjInWKA8S?=
 =?us-ascii?Q?AG+USPBQBTCpeuKPZFxTUhKdRybGX3qmDHB+FuHdqck8QEc2xBStOwWkDzcj?=
 =?us-ascii?Q?qwD5qx7KOHbUl+L0ILyGFH/lOO0pubI3D2ldjXfSkF1sirUXXsecjyBnctpI?=
 =?us-ascii?Q?l+egB5HUm48ZLkaXOLU8yQ11vUkl1EEX5AfQd8/rTh6I50B3/TtGf/skLV4P?=
 =?us-ascii?Q?7208Usu/JwMAntdAU7hguElFL5NB7GAaDDN5YQ2u3mYJ52T/v1OsIhkjuQ00?=
 =?us-ascii?Q?e2sajPT6rDuRWPpLaPLGDk5f0aIvLfF2DYMYGxh4gomAbfRnG24jJMdAv6oU?=
 =?us-ascii?Q?PjRxokxt5FgqTnoFFWUtPFiDAxmmRyDiCXTKXMvRlGLkiCDm7CSUeO7TvyJZ?=
 =?us-ascii?Q?Fj9GU3pniZJ/WzXBfWrvI0qGJVrB3vujXLDeuB2TO0xZgVShUtClRUMiQOi1?=
 =?us-ascii?Q?dTe96t+4cK0HpszV/0+8YnlYayoR589RLoWz4UX8BGZ//reimSuXWioXMEm8?=
 =?us-ascii?Q?93/3T18fF8KTB45EhQBzDAdJJuCPXK8r0NET5ItqgrOLNAcFZD0rDswPCOLC?=
 =?us-ascii?Q?2ARTDUSJGVyrfm3MbF6A0QYURqBeTHO5U4ddJqbrhTnCtp4FVRJhgBt5RwAX?=
 =?us-ascii?Q?2yoU3mISeJw1B5invmJX5zblMxrIFJ1tWr2dB7FDosPkzTxMQvzU3HFt6bGU?=
 =?us-ascii?Q?5WenHeDuxzTQrVkfDh0Xb6AzvO/JYV91QNleyohtOx5aV4/81lSX0TW2+lJh?=
 =?us-ascii?Q?6dT1XKwoLyOsVlb0KfJHeiTCIP5JqZhiWKK7Oqnpe7a+LTdFcBOtZojE9fDC?=
 =?us-ascii?Q?Sx1SRW2K47hKM1smrXyNEdNce1hjhqG5vBInhYiX/aCGbdtLVRI0ZB3evtvT?=
 =?us-ascii?Q?pJn5Eoc6eKBw/kquQPTaB2HkpWKNPk7mugPZ9X8BvnChpIbXaceE9LF+mR1J?=
 =?us-ascii?Q?Ag5xCFYLXIUpVu0IKefuSZ3ALoEZKL5v5ZVBFv4nUwkd+0Mk/E41vAYudLrm?=
 =?us-ascii?Q?/ugxaVkTtszu1mPj7HkpYx2alYLTh7XXBQD2kdNDxs/kz2fwuoWWX308SOGs?=
 =?us-ascii?Q?RKw2NgM+GReTwt8KlPpJRq6V3DaU347Krj9wcqlSdgEWo9+hanwq2lf6Ah9F?=
 =?us-ascii?Q?jTTq2yp/eql7c0YjS/kDN+1jt5mmAj7Q88nIloVOQzRzxnhPJ9N1pij1Lh7D?=
 =?us-ascii?Q?uIdFlUpeyTSaOWGlqDA8m/1/icIMtAzVRW5fqZye?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc1723a-3da1-4d09-2a9a-08dc5e201355
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:18:23.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flk5FfstUr1hDmJf+AtaquJFRLTh4pcGJVx3/K8HIX23OS3Mnd9hCpmNgFiaU5PxqrwiAatOsXRTumYh/Cv18td0Ny16lKZ8RvOZhwwexWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5544
X-Proofpoint-ORIG-GUID: LX_zAEL1TVEI0nBe2WL2-TsrCT7r2gzH
X-Proofpoint-GUID: LX_zAEL1TVEI0nBe2WL2-TsrCT7r2gzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160086

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, April 13, 2024 11:27 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org=
>;
> Conor Dooley <conor+dt@kernel.org>; Liam Girdwood
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: Re: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
>=20
> [External]
>=20
> On Fri, 12 Apr 2024 11:21:01 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
>=20
> > Define the sysfs interface for toggle capable channels.
> >
> > Toggle enabled channels will have:
> >
> >  * out_currentY_toggle_en
> >  * out_currentY_raw0
> >  * out_currentY_raw1
> >  * out_currentY_symbol
> >
> > The common interface present in all channels is:
> >
> >  * out_currentY_raw (not present in toggle enabled channels)
> >  * out_currentY_raw_available
> >  * out_currentY_powerdown
> >  * out_currentY_scale
> >  * out_currentY_offset
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-dac-ltc2672     | 30 +++++++++++++++++++
>=20
> You can only have per device ABI defined if that is the only user
> of the ABI.  That may actually be true here but given I've asked you to
> generalize
> the voltage equivalent, I think we've shown this is general enough that t=
he
> current
> version should also be raised to sysfs-bus-iio-dac

I'm still getting familiar with ABI documentation. If I understand correctl=
y,
generalizing the documentation to cover both parts would also mean we remov=
e
the overlapping sections from the ltc2688 ABI. Is that the correct approach=
?



