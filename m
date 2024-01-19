Return-Path: <linux-kernel+bounces-30655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99F8322A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0351C22A27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483FA23;
	Fri, 19 Jan 2024 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="6eLo6hVR"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EE4A02;
	Fri, 19 Jan 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705624243; cv=fail; b=mbb8DbIQCWhaAvpdF7HjfjbVqwfVybzdUDz05Dl/2gLverM/b6+lD0fGzZPJ66orHVt0aVgTKHErd8pRAzHFZmBxJn2zgk2hl025v32Opa334YjQNFS5XedBHP4hjxD5spp57lWDBKUJNBpH7kqfPGtB8cXJJ9mPPDO7Yw6OR1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705624243; c=relaxed/simple;
	bh=NTprG18zteXaXhg3r0C2RriGE5tbgSPLsPxxT4lFop4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lM+wCMKkulA2pjx3Nbx99ZH9zJuB/w6IYaRQVbvYOkKJlyNQ0h0prnS2djzi67OQOtzy7U+FOWoJtOXN5lcqqsrpEh9z8sfbBNLuanPrrptwkaY4imqqfFSWNMsDCsy2AK4MligWgTZIP2u4IE7YlbIIRoAfMltHGRHzaojn1kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=6eLo6hVR; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IIrZpa003418;
	Thu, 18 Jan 2024 19:30:12 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vkr17pnr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 19:30:12 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuXbc/ZVA30165MxLJCtHZ6RHhJhgcpbwl5msGV5VjRzQN8pspTcaINScxStzZSxJJH7UjftG0EjIG0jS8mbCDkC7ltBhnW1FJLWiZIpr0i+yxC+sUjy+UUBDgi2HDsn+VkMUXa7dd8uQQWrrT5ZFd1+4H42Y3HQyPfQnAI5w69QyQztNTOHGC61B7WLXmSAp2HZYc/MtQaIHjQNj7vdOX7PVecSXw4bU92WcKcBcIYn2YCz9d9hPK2GUURbDcJv3SwSHwbi9543ruVENa43ImYFqldtLiozMmtpDI0IIZjt3jWrhI2OkwGCj7ljq/wkejub10q/Hx1asPJ8Tp1jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L1M33DrvP02YBLEvkyxF9sNJtACkZOhbOIsBRZUAz4=;
 b=fNLbdabZosMlHG15gLPgfyUktGHCCeBmVzfgLImmGkU5+u0eNQK4V7d+Ar9RV++NeTjSHk7r6tmru2fRIT/ohHAmlBMoxlIh2DHo+hvEF8o23W4ozh/EJvDxN6DyQtq4VkLobGQW0FErZ+0X4+ThXlnUF9KdaAJk0jcfgwWt9xOosxJ948H3jIMH81IqT7r06FDCTmzloI5VNMaRWllarKo1zX6mMsI9e2XX0XULIFgg+Sq2q95tr4PFLjukuogMAf0LgmPeCLl7VkTvWgPUPoCo/Q2tF2AGAlLofJ08TIxPZ/vYWW7vQ8PmMQOAroXGu0on6yexbXwYeyaI1Wzv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L1M33DrvP02YBLEvkyxF9sNJtACkZOhbOIsBRZUAz4=;
 b=6eLo6hVRjdjHGRW5pg1WtDmiB0C5I8/hwFKFOEz+yPy/HLueTwlcXxkWBZNVKPvgDrPWeSG+0dvWFRXKvFho34H8ddtGGSAav6DLIb+lBY6w/lMMR6VfYNCV80JajUC+8HS1sdzPYWH0+Rm+fdZ1eatsHvdsVpZJ/fMRInOcELU=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SA1PR03MB6434.namprd03.prod.outlook.com (2603:10b6:806:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 00:30:09 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 00:30:09 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan
 Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: RE: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Topic: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Index: AQHaSeyhcow0swT57keZetZEWhgOabDfvaqAgACHJ3A=
Date: Fri, 19 Jan 2024 00:30:09 +0000
Message-ID: 
 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
 <20240118085856.70758-2-kimseer.paller@analog.com>
 <20240118-steadily-coauthor-de8275118901@spud>
In-Reply-To: <20240118-steadily-coauthor-de8275118901@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lNTJkY2U4My1iNjYxLTExZWUtYWFjZC0xNDc1?=
 =?us-ascii?Q?NWIzNWRkYzhcYW1lLXRlc3RcZTUyZGNlODUtYjY2MS0xMWVlLWFhY2QtMTQ3?=
 =?us-ascii?Q?NTViMzVkZGM4Ym9keS50eHQiIHN6PSI4ODg0IiB0PSIxMzM1MDA5NzgwNzg2?=
 =?us-ascii?Q?Mjg3MDMiIGg9ImVjei9KZTJ6NTlCRG01bnRZblU3UUZqR1NDVT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QmZPNHVuYmtyYUFaa2VFSWozOWYzMm1SNFFpUGYxL2ZZREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SA1PR03MB6434:EE_
x-ms-office365-filtering-correlation-id: d2acf857-12d7-4476-1d4b-08dc1885cb11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IAAILzuOyBB23zbcEaMEVQpdfh6GFE8QE4ejiIrsvuWzr36SKC74tHc9h+iArFJVg+vyMW9FwVT1JoeEhhCUTHVPjnX2C7+DTNORSpoDKKyxw0kzl8OYuWuYUvYSnoeCyH6RP8w5glTPEDQOXJjl5fDKTqtPn365LlWK9S6sSRI3Hy2VnPg/Vmyd5jrbSnE/6pyw8JX+pC1areocBgGDA4pLPfpn8t+CXBOdUAYpcRMCy9ePr/q7WbuRwrT8ocGbi9H96wwbJxtP15svoI5CQk4dX4aTvSGsELV6zWm6fHjSvlu65P6xq6s4O0+HCNMj7qm28fHNu1o5yt///CNSUsxeMj98I1yZIZ+2IGG6Zak7uBYSWBu8VjsqsJOGTWdhokim7KN/ecP739/G2N8Vnnwn2Fm2nrvZU33Q6pO9m8qgyJaGKbJCnamtGNMy4y9qdNEnZu0s/ltQ0BBc/VGNOwZJsDAIVhRkOd91rWxFR2l+WnRDLwoZJnwjO1M2djsZTQ6TyoLKzH5jZqzlyUmZnlMeSXTTBrl4tE1swPMf7tiNGqysGqteAhHfZB/aNPbhscs3xMWcAtoKvcQpX0DbSkyF+AaWTA1532NQ8l855EwU9thW4n50D+igqdV7TKTDV2x5+jOJ474gmx44ZgT41Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(122000001)(66946007)(66476007)(66446008)(8676002)(76116006)(4326008)(8936002)(54906003)(66556008)(64756008)(966005)(478600001)(38100700002)(26005)(6506007)(71200400001)(7696005)(9686003)(55016003)(52536014)(316002)(6916009)(86362001)(53546011)(83380400001)(33656002)(38070700009)(7416002)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+7j8FAqLfnxmAiI0zq83y8L9xMnyyfepHZyfQnhfkB2Pf347m7nXKIxeezcu?=
 =?us-ascii?Q?mYkvk9InxXWfWkblKEQk5EI6tCRhwMJqBG4BkFsWxRT9WYpH/NtIUn9vle5H?=
 =?us-ascii?Q?kK3Wlev0+zIN5/S269nuAil7VCnYG4LIhGOH8FPo5hneEtYRblY88AfW2DI9?=
 =?us-ascii?Q?CRWsEtJA4poRi4ML6xTiJWeohhVbOZ2T5GCw8lyFmbfdG8aS0vm26WC+l183?=
 =?us-ascii?Q?EmqjLBrCfeFWyQ6EoXepC0Lnw5M9TPQez4sZspnVg/+rd6psciML23zZmiGm?=
 =?us-ascii?Q?/fI/V+LzqeFMtLwnJqFuNK1io+KcOZdqvEadjMFUxw1YdrDxEFIp5SgJccGd?=
 =?us-ascii?Q?AGBXE9eH2K3Nui1o3qt7r7kMUxHu+42B2PPuePlAAbqtJLYNn6q6xI8WrI3l?=
 =?us-ascii?Q?vP8Buy+Sv/RsfsdJ6mj0AG+Eoqy/+MuPTRh9SYAc60sy8NXT0kwkUv2e9BSO?=
 =?us-ascii?Q?GNdXijN9U872u73k4HPkwTFRFzgAP7phxjan+iDo9LUcWrmfrs5LOQ8pN37h?=
 =?us-ascii?Q?KG9pLRsyTfPPULmkCypxV35WDLvKaRABjcaQCLD3PKx/Sy702FNnf7JDPyYc?=
 =?us-ascii?Q?eHwOCMVSwq+zkZCq5NC3tuFA8VUdtrw0HG1UHC6tOyiv0a98/1a/Vfz7MfgN?=
 =?us-ascii?Q?lIANelvp+vCxdxJ/y3VECZSu/XRFyIdOZW7JiDscIa+gfwxpqFc2z15QU2wE?=
 =?us-ascii?Q?UpqZ3aIc7notzsc+VCNCvPH1KTcSqxrWL0frxCK4lRqB7hVmiT6IZVUZslqV?=
 =?us-ascii?Q?TjUi/EOI5HqkqRBhL/JMKEnoHK1/yGuMrPVuidEvJweXLxwWmKfKYjK2EykY?=
 =?us-ascii?Q?emDkKA0Msubj6fyPL6e4osmJcX+sESw2S6w5FiRuOK7mgGmz1IeVhAQxom40?=
 =?us-ascii?Q?3Vzp88MItYBZ9sUbMW9kR3ObhrdWI20zRzEbf6Zvry9ozp0sNq5FZxRNFNyy?=
 =?us-ascii?Q?dDAQonRXWKJqO9K7sGcyONb//XJ62hYlNsok4hTDn1VzdqCXUDL3/m7jyMxZ?=
 =?us-ascii?Q?H1uBAzqEwK8HwHYSx2QQcEeF8OjLeGC3mb210W5ai0Y9SczqvCsErgk5RA4g?=
 =?us-ascii?Q?+piDG6CF5i2VGMUOOiMsym8YDFnKuShQ+3bw6b+CL9MzCzSwv/aPOhNTJ6j+?=
 =?us-ascii?Q?6j1YYdKQda0yhbNOxuwY14iP8uvN3IPyjTg9Kyi2ApL0S6P9H4Ih6rMb0RCY?=
 =?us-ascii?Q?0iAx4P4wHz9pjqkSBxkrS/0euk2JCTPeyz/k5T5UPg9dB5JEz4Y17XaocIrp?=
 =?us-ascii?Q?NfEyKzluxT8YOFV+3ds53UXloxUyWzwpXfI6FAKOspoNFZuOIDNKU9XTZ+JY?=
 =?us-ascii?Q?Tv3X2v56OnWbKfET6kHBTiLFZ9KXR35IMFXhBxFaU2ZQoLJlHrRzd+UtOjbJ?=
 =?us-ascii?Q?jgYULTyVrpo1DtvGrvggVHwu2vncUsStPhhtBGpTNWPLQjhqPxbOKViRhx1s?=
 =?us-ascii?Q?yo84s+cVUTjmYEGczs7qF6BiAheUtFK2whZsEEh1jVu3D6XtumqCXKLZy4Mc?=
 =?us-ascii?Q?XTDAy5GAHCrXrSxnJzXVQosirW76f9IwTWvfdA5fgtxF5bA40YC3XFLYl3L1?=
 =?us-ascii?Q?CdWqOTtpEQliY5/ps/eGZX0m78SLsbHskpdPpkYDDamv9sLMPY19dp33aUeU?=
 =?us-ascii?Q?fA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2acf857-12d7-4476-1d4b-08dc1885cb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 00:30:09.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Db0OV0k5D9mXrnVVW7WpMPjQpwteBhaCOlkySVukeZazli8bncj+lWxPrGVBhx9WDa+dTVqlAaob/UtWJ/wqAlQKye55xt2P6xFyXfovNsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6434
X-Proofpoint-GUID: LuEio_kkwe7yShR-_nd9QVBHrM5oW1cZ
X-Proofpoint-ORIG-GUID: LuEio_kkwe7yShR-_nd9QVBHrM5oW1cZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_11,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190001

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, January 19, 2024 12:10 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Lars-Peter
> Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Crt Mori <cmo@melexis.com>; Linus Walleij
> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
>=20
> [External]
>=20
> Hey,
>=20
> On Thu, Jan 18, 2024 at 04:58:55PM +0800, Kim Seer Paller wrote:
> > Dual microwave down converter module with input RF and LO frequency
> > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > for each down conversion path.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> > V5 -> V6: Moved array of switch and attenuation GPIOs to the channel no=
de.
> >           Changed pin coords with friendly names. Removed Reviewed-by t=
ag.
> > V4 -> V5: Added Reviewed-by tag.
> > V3 -> V4: Updated the description of the properties with multiple entri=
es and
> >           defined the order.
> > V2 -> V3: Adjusted indentation to resolve wrong indentation warning.
> >           Changed node name to converter. Updated the descriptions to c=
larify
> >           the properties.
> > V1 -> V2: Removed '|' after description. Specified the pins connected t=
o
> >           the GPIOs. Added additionalProperties: false. Changed node na=
me to
> gpio.
> >           Aligned < syntax with the previous syntax in the examples.
> >
> >  .../bindings/iio/frequency/adi,admfm2000.yaml | 129 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 136 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> >
> > diff --git
> a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > new file mode 100644
> > index 000000000000..6f2c91c38666
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADMFM2000 Dual Microwave Down Converter
> > +
> > +maintainers:
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +
> > +description:
> > +  Dual microwave down converter module with input RF and LO frequency
> ranges
> > +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GH=
z.
> > +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for ea=
ch down
> > +  conversion path.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,admfm2000
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@[0-1]$":
> > +    type: object
> > +    description: Represents a channel of the device.
> > +
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The channel number.
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +      adi,mode:
> > +        description:
> > +          RF path selected for the channel.
> > +            0 - Direct IF mode
> > +            1 - Mixer mode
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1]
>=20
> How come this is an enum, rather than a boolean property such as
> "adi,mixer-mode"?

I used an enum, perhaps because it was easier to implement. However, this
could be changed if a boolean property might be more suitable in this case.
Is that the preferred option?

Best regards,
Kim Seer Paller



