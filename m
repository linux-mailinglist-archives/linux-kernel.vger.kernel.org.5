Return-Path: <linux-kernel+bounces-55139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17684B874
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA41B2E976
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57120132C0C;
	Tue,  6 Feb 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Ev01IAnr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Y+2HLMYF"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2090.outbound.protection.outlook.com [40.107.241.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70EA59;
	Tue,  6 Feb 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.90
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230876; cv=fail; b=n6eEXzKDKPIjxhPedztavWwipPgGrfULxerjZzkSr8KsSP3jthASV4vMoW6zMbA+82+QA21UC+LvlfLAA1zswcuaLPxgV6y5qFCP9yPgBkWko9qYLPWDy3q1UWTRUwCWMa5WEcQoZIsEGucWuIw/6owEycewnx6iw1yHdn1wBqQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230876; c=relaxed/simple;
	bh=OuDSbNhq+qxZxqfz5OY+Wj87FFAixpImwou/TP33C4I=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HlOLSPqQWvrq+qG1GAPNc81gn4gsavNyTnajxt08lY3f6N52KksUulzBARoJpS8GVmwlGKNcYDlpNfA9pPkQ4UPB4s1L+FluxOUd51UZqI9OTkU+7f1bF7/7p4VdBI8Jjl8PkK8wjBbV+IxcKKu248E9pG04cBDLSDXFRh6En5k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Ev01IAnr; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Y+2HLMYF reason="signature verification failed"; arc=fail smtp.client-ip=40.107.241.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=YO+nFuA2YnWe/+Foh0kf1YQMX28qfKs1iyJ471clvxnF9Enc2Q8g+18csTGtFhadz2AlPG6tZKyubujbAukALuuhpeKoXfoSttaWcob+O0f8s5KwU4ATVhWKI7zM40mH0QzgGa7uNz4EwifLhoTDanpzL6SGDlD1d6ytQxNLZMsYGpmhJsrMDxKjKOB7pzKt7yvPVWUnlj0Dk/QdrAs3rLCnmq9LYxAqQurbrybEveFLrqLm8UzJZ92JD+GrlPA/d6VrsKzKvXUIi7IrU34zTrkcFqYG0wWoyuzct48dfhoPl2ry9vFB0sRMsIbhrTv0AaKvmhw5UKWuDEuQKEA4tg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuDSbNhq+qxZxqfz5OY+Wj87FFAixpImwou/TP33C4I=;
 b=QReCAHjKNK11M9lialEQnxtivV92t1MToMNXpny4TJCcTGTSJWgn2z8Bn+6gfJRfchf+FlwFVaRd+cJ4dGLx+SSSrRhY82k3V2Qi8HpUwd9wJJXi/mnFXQPGUfgfV0GdyNUkYEIRpxav5B8YcaHAF4QdyEV12brq9Ib1q4LxrKQn39yqvHpXktGRof3dH3vlUi0JINzhoeOfVobpWgd0DgRmjFJV/ZRsXsPPK6DDWeJxhiffXjqO9H7h8uRaD6eABmZ4TWDiPKFnWp5XlmZ8ENpi8xbw2d0kO+YkFHOPkAPmoVQedyw1YXVH4wmBdGETWJvMxVytfTAgSVgGXkrexQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuDSbNhq+qxZxqfz5OY+Wj87FFAixpImwou/TP33C4I=;
 b=Ev01IAnraoNfX/CwTIiNrOygcZd7ew1qBO31d0Lnx+hLU04+MlMW6huEBLQ+fLMJgoJieGjWggV7rh6Q1c7VWH25Ub8Fe0AB99Z5i+LqSCyB9OUTpjqjmj5vPON6gbSvugebTnVb1jgRoeekLSFxDKSMA6aGixy252yslhQrYEyaNqyIblhnPSscG6htJRQRD+X1/zFjMi8PhKHH8kzdEV5wu0vxTqbhOT+960ISzRdZFqcM7FXRocLcfn6ecBUpNhEdpfCm9mxspHbA5vNBSWLfH9ZnjDkb7JAVUOYbZVrvjMWNCFWSMky+wteIxFrLPNS8hiJXWzHQIvY18WgoEA==
Received: from AS8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:20b:310::32)
 by AS4PR04MB9242.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:47:49 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::d2) by AS8PR04CA0027.outlook.office365.com
 (2603:10a6:20b:310::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 14:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 14:47:48 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 14:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8/+Qf75wSH+fOxIVwhrsh5Yc9FG8BA7RX5mYNx+CRzgqbOse3g0RvKbYRRTyk5QLc58LvdgFn03pqgD52OE3rA1d9dmGh7NGEOE5Oe5ir9vARpNvooznGEbNY+wGhEdwS5ugnF4cfXbHcMsPm4FbKbiXN0g8dzoc6QHoZZgJcBCzPbtKBerP3l1Y2J13CXq/Umh2qqEdv3yEzblTbD2sNz32oZFGDYAbqkOKFAWvrGO1mMOQwMbQcpQNSiYl12+MTiNjSBsy0Xdh3B5+aRcedZoIxDyHC+v8zctybW9Nso9ueP2rZNMhPDvjPkg942vqfW9gANYRSkiYCBJJ7J9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvt6n6WZjh2S1uTOFCmWiLfIyHb3L+jP1f8q88KQEAM=;
 b=iv9iyKPW2G7XCDRNPOaB2Yd/Y0PR4P1o0Caaxa0qD+XYLuxzGJx0zb0KFpNbivRK2RnUlsCKX0I8TuuNDc/zBGUuMxmP7yhKJ0aWQsXCNC7uOod/UW1o/z2rYHjUb2vKP7LCFjWi0Hd+V7NhdjY8Y6j66dYapQefzQ1IhML7kWaVv91HcndvZLjoRXIQ+TFUwe8m0pfxvEMuvYMD3IPxZ/BOJNxnL6cNWfUkK5esKoUuyChqv77UFPKIbzE0XdIODwmt2/al8U9NPiOFH1knEA/tRbk/OrANqlnrcDHy0pbIgAZ+85zg6MfhZQvIevqUVrVBCUZbG6OY5DKhj82v3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvt6n6WZjh2S1uTOFCmWiLfIyHb3L+jP1f8q88KQEAM=;
 b=Y+2HLMYFc93EnEE7w17NBgZvY5m321P3KgvrcnuxS798cUWuJ7zIfP1yhWluUlgZU5+CFXnszONjFncGKNNMpvr8PxoI8KD2ZMTPTnCfSSD3xjC6+/IsG6gyY//w7oMrOQjQG1nhi5ZSS5BMAwrHfiQqWkIlOv/WNuTSQCcA7TuBl0dOmQMC6rt+ZgCgplCCnm1QUfHiFWLH5cBijiQHNt6KPDoSpzGbpfpdfCYM66Yk4gl9wvPpblcKJyrwpnIr7uURv5Kf75fpAsNNV9AzdkHt2ugo5IRWI+eBekHN/xSBddSE5sBTTBKGRD+Yl93GXUueM0NsVQsz8bgk/Z6MWQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:47:46 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:47:45 +0000
Message-ID: <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
Date: Tue, 6 Feb 2024 15:47:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Content-Language: en-US, nl
From: Mike Looijmans <mike.looijmans@topic.nl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
Organization: Topic
In-Reply-To: <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::25) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DBBPR04MB8042:EE_|AMS1EPF00000043:EE_|AS4PR04MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: b7676410-8be5-42a1-7f4c-08dc2722967a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 VEV74wWtZ7f2nlGiBDfPkKthcJk3BXxBVh+B8LF8OgOo+A7j06uTAYW4FpOAzFso+l7+22TWs1OgmBhLPZYITBy+Mg2HeNLqS7GP8Jvz4P5s1SJNettEbN87ASzyrspaUXgo+A4A0wGMAiFKtUW7PIsoW1RREggotUFCo2fPop4YRAZBI3FhtDAgrlr0gRLsqTpqTz2hF1UfnxdGFoI0NRo5WKZ3F/jF7UK1K7jvpBfwNV0Jkid/P5o+q8VANEIcDbo/3YuB0+gkzXt283d60Th+ec/qtXo9IuJFzOMbmxE8H7mAqTEt17BDPlDmLsOTM4vHm/i94Hz28xz6HoUrek5ScD7NTR3O/C0hkGSIys4LRuVwingVnnYz0dRuQ9S170p6ZQwdBN3OiOlHavTTLfStyqbY3bI3ZfprMY8sOMiJK5gnEeNCF+GtZIX/MueQOKwrohk5n2mqPC3FotEf4VttCkzAcKTOkClqM2Ck0JPlWuBsjw+bVak1dgAqc3V7X4/d8KZJMjRUlKBLjP94LnG46bml3ZxAvDRluGfdKBxYzMmd/ZPCxNNmLBEiGhX/0HmbkD6ct9L9MbD/UgLA27CCE+Du6liuItCaQz77FNWxvLNOcf8gure7FoOrsNLYzSlSt5XtM2NkNL4pev+VpD4rReHVOaKfffaU5bPhyPg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(15974865002)(26005)(31696002)(86362001)(41300700001)(7416002)(6486002)(5660300002)(2906002)(478600001)(38350700005)(66946007)(316002)(6916009)(54906003)(66476007)(66556008)(8936002)(4326008)(36756003)(8676002)(44832011)(6512007)(6506007)(52116002)(36916002)(53546011)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
X-CodeTwo-MessageID: fd3ff533-9e35-4d36-9bb3-4da0437cee86.20240206144747@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	03739bbe-39dd-42af-d76f-08dc27229490
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L7o6sMBNhOxrC6BL/08mk2B2b6BeyDYw64zpVwZuaxMHdpKfw7sF8yKND0mWI53xEYAUfXDUI57T6NaoQE2xvyK+nmTdoPrGNsG4nt6pn98yGz5Rol+tce4zHwhwofqDPi/BKyO4NN1sjNAPQALiZm2O1sGWNtAXocbVbBUKI49M0EQovRZ6E8XLP/xxOS2uOp/pXHScSVq/TWJAQH+1ruYdyMedHSw2AofvtnSYsgPLIUv571RvJHhcqgBgNPSY9zExoq9bu1g9R7ExrNU4f6Id3MSRUcavhyRaeC/DA4EeQRwHlbSe7Zl+rmnln5WlOsTfYKFRbCyWSjmcwBUU7E3d7hfZI7F4TOxx7M07vX+OBJnsDKZ3CPDNcZKzz+0M0jnM9j2+gCNl6pnA/1kWOY7c0fAqxxAf32wbrCpLfknpdD2B748i4b/HyVug+zltQnRUAgcTpzP6tPx0HOi/qVCy3F2MMl/B9TD2/bOjk4mky6IgvhrcdPeI1s7qKvy2t0YKP8jjyM5mV26J64UbTsX1bBMgcM1nP6RtU0ol04YDwWEJBBFO4eCFLfDK9X0RbxmLPOFT/dh/97B1Bn0+VB7m6tIZQNY/CO3yBFq83W4S5lGM9Lny1sOY9HxJeKowTJsulD12UkFiIKjOXaVcjYLaN6DoNuvhxjr0tyB819IXBB/oxwR/hTedzohFs1ObTTbxm7XALa6XkIturAyRwoQR4zAFKqyLw1Zfb9r8IKgdIjKV3OlHUm93x09OyTapitgawGf9DRlsRzBjk+41XQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39840400004)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(7636003)(31686004)(7596003)(356005)(36860700001)(2906002)(83380400001)(40480700001)(41300700001)(47076005)(316002)(26005)(6916009)(54906003)(70206006)(70586007)(31696002)(44832011)(336012)(7416002)(86362001)(4326008)(8676002)(8936002)(53546011)(36916002)(2616005)(6512007)(6506007)(5660300002)(36756003)(6486002)(478600001)(15974865002)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:47:48.6124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7676410-8be5-42a1-7f4c-08dc2722967a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9242

On 06-02-2024 15:25, Mike Looijmans wrote:
> On 06-02-2024 14:50, Andy Shevchenko wrote:
>> On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
>>> On 06-02-2024 13:57, Andy Shevchenko wrote:
>>>> On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:
>>
>> ...
>>
>>>>> +=C2=A0=C2=A0=C2=A0 wasbusy =3D --priv->rdata_xfer_busy;
>>>> Why preincrement? How would it be different from postincrement?
>>> Maybe better write this as:
>>>
>>> --priv->rdata_xfer_busy;
>>>
>>> wasbusy =3D priv->rdata_xfer_busy;
>>>
>>> I want the value after decrementing it.
>> Yes, looks more obvious.
>
> Having done that, and looking at it again, it's better to just=20
> eliminate the local "wasbusy" altogether. More concise.


This removes the decrement operator, so the method now looks like this:


static void ads1298_rdata_release_busy_or_restart(struct ads1298_private=20
*priv)
{
 =C2=A0=C2=A0 =C2=A0guard(spinlock_irqsave)(&priv->irq_busy_lock);

 =C2=A0=C2=A0 =C2=A0if (priv->rdata_xfer_busy > 1) {
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /*
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* DRDY interrupt occurred befo=
re SPI completion. Start a new
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* SPI transaction now to retri=
eve the data that wasn't latched
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* into the ADS1298 chip's tran=
sfer buffer yet.
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 spi_async(priv->spi, &priv->rdata_ms=
g);
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /*
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* If more than one DRDY took p=
lace, there was an overrun. Since
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* the sample is already lost, =
reset the counter to 1 so that
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* we will wait for a DRDY inte=
rrupt after this SPI transaction.
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 priv->rdata_xfer_busy =3D 1;
 =C2=A0=C2=A0 =C2=A0} else {
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /* No pending data, wait for DRDY */
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 priv->rdata_xfer_busy =3D 0;
 =C2=A0=C2=A0 =C2=A0}
}


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




