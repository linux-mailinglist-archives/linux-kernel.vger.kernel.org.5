Return-Path: <linux-kernel+bounces-33718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EF836DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904511C27B91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C7405D5;
	Mon, 22 Jan 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="OV94eY1q";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="OV94eY1q"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2100.outbound.protection.outlook.com [40.107.8.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAB3FE5C;
	Mon, 22 Jan 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.100
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942153; cv=fail; b=Hrb/ZTk8MBZkHnW9g5Lf9GWsgHtZpuB3BW0GXv+6lz2O2KiZnBB3s89bwby4Vc7e/KB+kYMgN7mbX+PFVWI2hkXiHLYQ+pHlQmHe686uMdPCIi4dKm4XpvmhKKOHk5zlo2hcky9xnTS4Kj10Incj1JAyuOIdmuGuj4pqS9RIctA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942153; c=relaxed/simple;
	bh=uKM3IKXuKR8e8eq3B6yU2OT+fFC8FFYwcOMCmfJcWs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBmUWu5hTTNRKFacTc22+mDh8Eq99S1AO+Yfv+zz8idaPUE+Gdydqu//uQNLYP8/zgKzD4xFMjxi6nbsBYwOz2ybMn1TCH8z+XHqf8yEuyW9+efUyjyZuZtRad4EWN0rxAcuVY6TZjafYOcZA3xdKq/YbyDXzyRK19Qa/TZWu3I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=OV94eY1q; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=OV94eY1q; arc=fail smtp.client-ip=40.107.8.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=k/ZfxrlmulxI+8gFGZ4AsnJxTf65H/gthN1cr6EvSHULWviYtbmvQ+NRZ7AVIhjkDupvdYONLVY+cjDRoiqNn+jgNHU/rocFYV8hSFgEZxO/KcdYmgRRfL9fT4orWtmsLAFLa/L13zmihGgQ/0A45fuok5WqJbYomYgEW3odzYff07GRLY4zKX37tY4TjEpLQKDWt3haF4oOGHF3+Tm6tHHhQbHEFmfUAUiH51yS3/9OXin9oDBS4Bvqxrw+Hjsz6LV/uz9zaMEoB89/P0URn6P6h1EnGNIUYE8ldI9SpcVUKYh9vsKe917fhhUJrYdMZQXmDJ1SdrWsDPA02qIhwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKM3IKXuKR8e8eq3B6yU2OT+fFC8FFYwcOMCmfJcWs4=;
 b=h5o+QUievOdTfDr3HpM5qEoZN0FOkJm31OMeVZ9icxAjm6xZyWik4GnnPfKKOPYplHxELRg3yQcYNVmimnvNqa0Zv0chHOSL8OCfh+G5GNnDByBWUGA+hxtfx1UPYrHRO9tfwRmF65Bk7Myzt5lND1JwfcbjopDNCSlJLDjDWq76Y75wCMzw8Zswny2D+sbn919BSLAQUC+dzAeaUH7Y/ZZDAGbdGxO/Kl9nFB1MbC/V3gfmZORGF3je2OD4oaowHZaENT6BuzMMM/noSiHp0x+OE6gQYFnmBIGxaGDH++sG6wGfHNaXaKxOdFOTtE0XacjR2TQQXhq0gedyEtb6gg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=pass
 (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKM3IKXuKR8e8eq3B6yU2OT+fFC8FFYwcOMCmfJcWs4=;
 b=OV94eY1qKsjiDbBnl4rYW326sCuf5E+KWCnwoGrGnLRbMx8bJvQ9S+EBbXjPeDNTu4k2UoMNRnN5xobkgfgyfh0nEBIroPkns2okKdk6Y+LzYFJYbzAP4bzC+OUtO0YqEcjKin1r0KJKpBtSFyq+eQgMf3Z3eKGsspRwZc8OpRrnRoQa1f0lg2EdAQPgeukfE8D0fJQuZghtGbmUiRZnfgcF4+UJSGkm2yvdwvVIWQenR7Ovb+pEz9ISERRdjdrOJc5Oka/9mfM/itU2i5egrqw2lmMAJ7ZY8SoJhS2e36nPJkZg5RAp89Tuk7iVWZ4yW5OOGQvc9C2b6924IXcU0g==
Received: from AM0PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:208::48) by
 PAWPR05MB10477.eurprd05.prod.outlook.com (2603:10a6:102:2f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 22 Jan
 2024 16:49:04 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::97) by AM0PR03CA0071.outlook.office365.com
 (2603:10a6:208::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 16:49:03 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 Jan 2024 16:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esEBjymUZ/doNLQrz0X2lKYl+JbdxIvDq6pDRszK45mWtUsMWijeJX8LUTB9Q7wJgXJ1MPQzZ/fgVfZm1H1FdPS2r7fl1U0ft/W2HGy99B/o4lkN6VuGsC6k3kwEvHv70e8frgPO8WmO0p7KzalO7AKlJb7HlCMeNlex3bHNy/yKJU3XZ8+CIH8ILCpydc5ENptiRbUpyDM+chSISvclhhvSB1lJMwuFWM5Gh7CC3CQliP7cPsub4xL1jf8hoJotxI/3Mm12AeNdUE/MGFw4egudPfpbHgnVschC4FcfVz2ATLVcW3b6CD7DimNwEVSwCryREhBy8bve2KnCmkwQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKM3IKXuKR8e8eq3B6yU2OT+fFC8FFYwcOMCmfJcWs4=;
 b=DR627qtun+xcRhEsDam43cr2WgRPWIbjMZyP8EdToDX6UL8x7++Ve892n3wu4EwrI69FPqO5toWx4gc3KUwJYAVcvJKK9f2AsumCbR9e2fkbe9IwYr6aQmxZ2sUUBynEvj4jVWvId0wfZfye07j1QOSZFbzr6iZBUlZ7Rn1kjX3ExMgsVFQ+lDzc9y4y6SZ4Kk3eqrXRnPAHq1v40jgqz1UGHPC6i0qLrNW9EL2Xi1adcYW0aIlk7kK5geBot7LJtBkFmG4b59Dkws2hdT1q459elh/awioEAW6vnjLwKmHxJ7ZIy1k3F11vu01Uke6ExDUgLCCTVq/ahFFjSi6v2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKM3IKXuKR8e8eq3B6yU2OT+fFC8FFYwcOMCmfJcWs4=;
 b=OV94eY1qKsjiDbBnl4rYW326sCuf5E+KWCnwoGrGnLRbMx8bJvQ9S+EBbXjPeDNTu4k2UoMNRnN5xobkgfgyfh0nEBIroPkns2okKdk6Y+LzYFJYbzAP4bzC+OUtO0YqEcjKin1r0KJKpBtSFyq+eQgMf3Z3eKGsspRwZc8OpRrnRoQa1f0lg2EdAQPgeukfE8D0fJQuZghtGbmUiRZnfgcF4+UJSGkm2yvdwvVIWQenR7Ovb+pEz9ISERRdjdrOJc5Oka/9mfM/itU2i5egrqw2lmMAJ7ZY8SoJhS2e36nPJkZg5RAp89Tuk7iVWZ4yW5OOGQvc9C2b6924IXcU0g==
Received: from AS8PR05MB8087.eurprd05.prod.outlook.com (2603:10a6:20b:31d::24)
 by DU0PR05MB10522.eurprd05.prod.outlook.com (2603:10a6:10:425::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 22 Jan
 2024 16:49:00 +0000
Received: from AS8PR05MB8087.eurprd05.prod.outlook.com
 ([fe80::9efe:506e:46f6:77cd]) by AS8PR05MB8087.eurprd05.prod.outlook.com
 ([fe80::9efe:506e:46f6:77cd%5]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 16:49:00 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, "git@amd.com"
	<git@amd.com>, "michal.simek@amd.com" <michal.simek@amd.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "radhey.shyam.pandey@amd.com" <radhey.shyam.pandey@amd.com>,
	"srinivas.goud@amd.com" <srinivas.goud@amd.com>, "shubhrajyoti.datta@amd.com"
	<shubhrajyoti.datta@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V9 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty
 to facilitate rs485
Thread-Topic: [PATCH V9 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty
 to facilitate rs485
Thread-Index: AQHaSeHaVTPMeAMJ+UKLLUSZksN9erDmEOew
Date: Mon, 22 Jan 2024 16:49:00 +0000
Message-ID: <AS8PR05MB80870461086260FB60236B1D83752@AS8PR05MB8087.eurprd05.prod.outlook.com>
References: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
 <20240118074003.2334348-3-manikanta.guntupalli@amd.com>
In-Reply-To: <20240118074003.2334348-3-manikanta.guntupalli@amd.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB8087:EE_|DU0PR05MB10522:EE_|AM2PEPF0001C716:EE_|PAWPR05MB10477:EE_
X-MS-Office365-Filtering-Correlation-Id: b951a307-034e-49f7-dc14-08dc1b6a0abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 ySEB+dFb2C6ApMhnt7QsC0FKNtXncKOmfBiG5tEEygviOaUDBp7m1klaiJ+mGoTAXqrew9F/z3/QSHV/REVnyWvD6eJaFXw3FT+yi3gX+VBvLHaq02xCQ9ObCBYDoJqYG26047s5b9z1DrAQQEm/qnL+jNJMXA0NbALWjJMEc5Nb4ipjHpxaBXRPpMqbl/9qVf/f3Jpw0/cylYKRCL4ibhtcXDS5oMaao0yhtXl7BZj+YR2EXrRZ3LdV8GUtna2NtxO5SgxvSPdzmvq22fQqYBYXJH91Td/75slk+8vtXYK3NJl2rTipx84F7NvfFNjCgVsrA5AEshVm+AJ8kpNpTTCv71gnnnr8T1TlT/PJZQgqivq+KZ37Xf7SqoFjuUECdVeUYZppEwfXVLe4WmQJwGVJZ40ncPRC/hySs4RsXTsdj3Uqgg3Oj/BjIkb8f/TlFlr05lvF/hm/Uybh1Pak/Kv9cETYzOzDHcJpPNhhJ+SvojWIo56NyFpc1fH2aZL6ost567smUzvqPvG5iZLuUekZATccJtbcZnNHWK0DNjPWNXXhLWYk10T21tTaE/8hjC3Vbi2qlLnMjuS7JKy26u6CMZ7uzv5VnXV6vSHMGk0xar5EeN+hyoWXnCorPjxoyd0m6SQoYfcHvn3AhmNnew==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB8087.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(38070700009)(55016003)(26005)(66476007)(66446008)(2906002)(66556008)(54906003)(66946007)(64756008)(4744005)(76116006)(9686003)(71200400001)(6506007)(110136005)(8936002)(316002)(8676002)(4326008)(478600001)(7416002)(5660300002)(53546011)(52536014)(7696005)(122000001)(38100700002)(83380400001)(33656002)(41300700001)(86362001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10522
X-CodeTwo-MessageID: e11d65d3-31cc-4ef7-b16e-118b7fee77ca.20240122164902@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f0aba70c-99eb-4d0e-cf8f-08dc1b6a088d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azia2l39CIXqMd4JeFf8OB+od7dk8yI7MJMcMoZYjd9Ee9EcYNRXsjAekKpofD7hvSCjOwBSeDHvuJXbVQWhqmJnQqfJXIARzK4r2ZCVQ/TGWHe0RJtoCajJ58NE9dVCdiB4tXIuYwc35Js2xb9YL7ETWGLll4T6CfmL+NwOa4DfUUOceJGd5sgBnMj+XEeZ1IxtUkBwod4b96OxPwfQO14m+/oShdvO9p9GfdeNJS9lv1RrQ2agOWLYNHHwWtgrYmOMw6Xco+7m/jswIgX3ZANFyt2ODm8UXumHuJ/r0QJ+WPjewpoPrG+uDoKJwdxhF8yp32rtgyyQQ6SiCvXftcHz1H697O+LIVG+Fh9NW+sqCYjBB7VkMP0gPUI03NJTChQmc9oudH36HqG/6J0BWtBB+mACJTjRpMYJWUQyl1IA9vl/sBsH6ANyHAXL507rhOH6JVZKI76ZRMSLuQmYP3jAZKtFse02ibaXU8fxklPLeDBFrAMBTDDQFdxnnHvnqIi+tgwvbYlN8bWjY+7V5XIgB2iSxi5mOxxLD/o2+3vDnUUtBQQ9PGgGztubdBeIbzUFymUtVXZfRCTeuV3aOdfRGl6+PvigNGWjrGzWjyNeyqnd1sVFNCQCXcCKjPcJewkN2RL2QBQKtmbsMwAPro+UbsWzijx95K7W6pHquoWUdNGsG+klTlmmjB/IiECEUSNa2D4Aw5fXHkiJ0pbMVP/BTRP3bC+IdL7OEcPDbAk=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(53546011)(7696005)(478600001)(8676002)(8936002)(6506007)(110136005)(70206006)(54906003)(70586007)(316002)(47076005)(82740400003)(36860700001)(26005)(336012)(9686003)(83380400001)(4744005)(41300700001)(52536014)(5660300002)(7416002)(2906002)(4326008)(55016003)(86362001)(40480700001)(921011)(33656002)(7596003)(356005)(7636003);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:49:03.9397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b951a307-034e-49f7-dc14-08dc1b6a0abb
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10477

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pa2FudGEgR3VudHVwYWxs
aSA8bWFuaWthbnRhLmd1bnR1cGFsbGlAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE4IEph
bnVhcnkgMjAyNCAwODo0MA0KPiBTdWJqZWN0OiBbUEFUQ0ggVjkgMi8zXSB0dHk6IHNlcmlhbDog
dWFydHBzOiBSZWxvY2F0ZSBjZG5zX3VhcnRfdHhfZW1wdHkgdG8NCj4gZmFjaWxpdGF0ZSByczQ4
NQ0KPiANCj4gUmVsb2NhdGUgY2Ruc191YXJ0X3R4X2VtcHR5IGZ1bmN0aW9uIHRvIGF2b2lkIHBy
b3RvdHlwZSBzdGF0ZW1lbnQgaW4NCj4gcnM0ODUgY2hhbmdlcy4NCj4gVXBkYXRlIHJldHVybiBj
aGVjayB3aXRoIHVhcnRfdHhfc3RvcHBlZCgpIGluIGNkbnNfdWFydF9oYW5kbGVfdHgoKS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBHdW50dXBhbGxpIDxtYW5pa2FudGEuZ3VudHVw
YWxsaUBhbWQuY29tPg0KPiAtLS0NCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91
YXJ0cHMuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jDQo+IEBA
IC0zMTYsNyArMzMxLDcgQEAgc3RhdGljIHZvaWQgY2Ruc191YXJ0X2hhbmRsZV90eCh2b2lkICpk
ZXZfaWQpDQo+ICAJc3RydWN0IGNpcmNfYnVmICp4bWl0ID0gJnBvcnQtPnN0YXRlLT54bWl0Ow0K
PiAgCXVuc2lnbmVkIGludCBudW1ieXRlczsNCj4gDQo+IC0JaWYgKHVhcnRfY2lyY19lbXB0eSh4
bWl0KSkgew0KPiArCWlmICh1YXJ0X2NpcmNfZW1wdHkoeG1pdCkgfHwgdWFydF90eF9zdG9wcGVk
KHBvcnQpKSB7DQoNCkNhbiB5b3UgcGxlYXNlIGFsc28gaW5zZXJ0IGEgY29tbWVudCBoZXJlPw0K
KyAJCS8qIERpc2FibGUgdGhlIFRYIEVtcHR5IGludGVycnVwdCAqLw0KDQo+ICAJCXdyaXRlbChD
RE5TX1VBUlRfSVhSX1RYRU1QVFksIHBvcnQtPm1lbWJhc2UgKw0KPiBDRE5TX1VBUlRfSURSKTsN
Cj4gIAkJcmV0dXJuOw0KPiAgCX0NCiANCktpbmQgcmVnYXJkcywNCk1hYXJ0ZW4gQnJvY2sNCg0K

