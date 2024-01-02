Return-Path: <linux-kernel+bounces-14136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07927821840
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2657A1C2160A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C0469F;
	Tue,  2 Jan 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="wH9ddo2O";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="wH9ddo2O";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="wH9ddo2O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2124.outbound.protection.outlook.com [40.107.23.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02469441F;
	Tue,  2 Jan 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=V6y84C5f37CJ/HZw7H/T7Q7593kQd3fzwzBPR78uNsZWCRNO8Bx1s8gY2JikijhakBGbRj6uZOFLhd6fxyFHFtK13Yip7ACTLmldh4K7+6ypQR6nO4GxqXtQAxXBphZDMY4z5uv9T/pwkpybwTYlwKECrlNg7V+y+78B9q+TROa3ioEscsj9cQrZIZ2sq9W0Gs+10LF3JmgPS2p9NmFWe7w3GWlkJIzpZCQnIaw6J1gYCbNVQNHzqRgNHMjE7FDpEGBN5h83hJMK+LFr4ma7lcLdo/Yu0JfXLFgVkFVoxT4G9YQP6Br8zXgDPT5YFbDCoddtMOULLcXXZIipNhPK+Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=BuLujoyRzdz6fTPzy/sx+eIh59s8G23MkazIwo6iI8wAM1YIcFJRokL1XkDq4BTBPgbU6iL0SujdLbu4dtYqq+U+N3kD1n3z3XwxpyuqWNBSIqciVbyQrFsrCmxn+GL91KmT3sXY4HGUboapB3Di9UoEUjAGkeLNNtxKp/n0HNuejJWl8AMQD7DBet0T67AsnE/ytBqdUOnNdqtWgc3Gezd4K2yttZ1gtW24V70DfPy3ZANZVE9AJCvTiC/5mu5X0b8iPZm4aePt7ZYjAIo/5hk4c5Eu9gLYHk4qpvRAfLijt6LJ36XQLzo3gxtou0MkM9z19PG2dPfNKfcFOKLyEw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=wH9ddo2OUeEvllUOtDgN9R2AFJ26WpOAq5lQtBGI8okesVvITcXqLicGqzYPfKNfQMH7UDzNK2JDv4ffcb54H+A0zg54yDzsFe2YfhHShBBJl5k7XSLxFhaCJgMQRIrU4CiSTbeJyOF+K96mS6keMHMauCESdjGx/S5q/in0CWk=
Received: from DU6P191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::24)
 by GV0P278MB1078.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:18 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::b6) by DU6P191CA0044.outlook.office365.com
 (2603:10a6:10:53f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:17 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T45Nh6D0bzxpF;
	Tue,  2 Jan 2024 09:19:16 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 09:19:16 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Y2/zatUaS8w6wBbfDOJZbLEwSBRpT3/Bciq2NtOqLW8wSDlLaPr1Gu6BqQdgKnh5Z/BAJDV8pkX4AKzh4ZmWoazr1YOxNQ7J+VAmqjmndWY9nwffKeSMluFG9LrG0at0s6Ojp25gVIs2pNQvfUzdNv6tl4h1ASWD+ETtvEhxLuFSeK6HVWofju46+zmavRMrhhimkrA+tqNIPlaBiBmCsoD3WGqC2fcDd0TpXbpgiwjLJwNwVbm6GAPIAxoqav+JJJnW+OsQay8o4Lnx0YZRdLWVS8D0CE/JU6wJmf3k83WpytXD+h5kHa+9GgL1F1WW/OVZ2cJhYxc0szbIHT7rDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=Z7zXhH8dlxz08W2rrPU8U2KcX5GiUVuRIECUKyc3uEs9+86JDMYq6+Usf80r7+kNjGoL9rD1+2K2YLPdx7fagVRMoz2/Ozi+TqcXs0CE2nlTtvFUIwS9pfN7zuIL1ukFqzr2YsErpsv58kK76KHkRevrl2C7zYGMdijy/5tuOaCjqtdvpR5igj9zj85Ye0JqMnyIbL/XRSo5pa3Q1hRsaPXWKKMs3Nijg0plhAjsmwgyYqjbE3Cr/oG7t6qzA44QsL+LL2R9qitItbSxxhfDL75c2TPKMkuJbpVsE25x46aXMLLq3560PrZi6RjsYABqrNStZRvbgqF6S+3EQ/FvJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=wH9ddo2OUeEvllUOtDgN9R2AFJ26WpOAq5lQtBGI8okesVvITcXqLicGqzYPfKNfQMH7UDzNK2JDv4ffcb54H+A0zg54yDzsFe2YfhHShBBJl5k7XSLxFhaCJgMQRIrU4CiSTbeJyOF+K96mS6keMHMauCESdjGx/S5q/in0CWk=
Received: from AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22) by
 GV0P278MB1032.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.25; Tue, 2 Jan 2024 08:19:14 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::63) by AM0PR03CA0045.outlook.office365.com
 (2603:10a6:208::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:13 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jan 2024 08:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBFJYMTE6JQt/ik7iBp1oItvHOgunU9TFdZV8lyHkp76cO5kpx7DW/6TyjSDD/9NyhaDR9qL/IpbrLWkaQYikvGEdn6kRDQTvGYxHL2D9DuB4+XFCHeOrgNo8k2UgdhXzatHIMjLGR47YhdKIOuveR6UAuw9Q28ctXtjEAKX42fyL0UJygGbLbRaeGBiwIXzWxM8M2E4cc6XofsNqtrg3rVTZdbUyYNeqqXJMX2ToeO2ZAIFmS6ONPkr5m3UewCelC4FyC13l7aKe1jVPow48e+onysuoCy8Gol0C54nKuSKZp0/pgckPL6qr1QLAX+y3tQ/He/sGqOtoc4O+NstRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=MXGWGJgF+Z/KD+gdIloHLuQzqc8qLQdt7CFztML2yW1lXYWF5XBEyWHEVQn2m2AZkvWT12h40LcHQ+h3fgsjaqaf6az7CxD/zCdtGDJNxiQkZN9XnOnNOzdZpSpY59sNV2QdY0i6d9wDNzS2a+0j0gmjYNTHs3yaSfUu2vc/HNncClMGf5XENwFp/0huaKUxN4OVgPTpwvAYdkpwpw9wOgGVgBCLAbFO/gtvCr/42KyKUeDRUyYcc4dqSqS291iW6Xx/FxTpGJqWSCwsP9q7l1IJZy1e3HSCaXr84ABX9LZt5XcutF0VFMe7i+fmZdAXXIkhKRKtXy1yrGw13d7mYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG8Q8ockAta2wvfwitoH+Wn9ZPqeDkMctk26hRB223c=;
 b=wH9ddo2OUeEvllUOtDgN9R2AFJ26WpOAq5lQtBGI8okesVvITcXqLicGqzYPfKNfQMH7UDzNK2JDv4ffcb54H+A0zg54yDzsFe2YfhHShBBJl5k7XSLxFhaCJgMQRIrU4CiSTbeJyOF+K96mS6keMHMauCESdjGx/S5q/in0CWk=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:06 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:19:06 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH 0/3] net: ethernet: ti: am65-cpsw: Allow for MTU values
Thread-Topic: [PATCH 0/3] net: ethernet: ti: am65-cpsw: Allow for MTU values
Thread-Index: AQHaPVRZqj+KTd9jMEip8pNlXUYOqA==
Date: Tue, 2 Jan 2024 08:19:05 +0000
Message-ID: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GV0P278MB1093:EE_|AM3PEPF0000A790:EE_|GV0P278MB1032:EE_|DB5PEPF00014B8B:EE_|GV0P278MB1078:EE_
X-MS-Office365-Filtering-Correlation-Id: 457f0c84-23db-420f-f38b-08dc0b6b8388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 9G6g1TPrwMitwDq+ZrxotPOVoypeIJ5tWdmX7cRrV7eMgNobMwjKxu5L3EsYpPRyb3SVf62o28Y0KXPsnO8M9annxr3DZ5p6qMeZhbeiqfleT0yVs8EykG9R13bkXQDUrgPm2P9TKQHa+XFRx90Vn7eroIGrXYVYcypq9lflT8E3M0mirFbqghIdzyE4m50C2V26aEtfETQqBXsT6kS0SnTKVLKG1P4D8Srm4li/GZnER4YEnJqyzKSQ8Dim5ODcLW4cRKCtmdj8hiFpo+0ico2hcrkY3VcNaFlovtQVI45L8/JRdyNSpyNZ0TA3goQZWBeyIBixIo51TFCOZA3RMALcozcHHo+NgfolKrRvu17rAWeMx4opCt8QcplsE6mOC1eoEWs8AeQpo+M9+SmSSleu4DBy5P4s8895etqO+2hfVeivByQ01fBoBrMguoyhi0Bqlbxtz4h2CYZwbR+G+rzewbe76fqFZpT4lI14lVK1AppzSmdwIVQgVlLQ+e9ZqWhTyVyUDcxpaHj5BgImFj0OhVXJr4PY6EWM8oYvypNWR2TjcfWYcFh/XauflCw3gYM+Kzy8fSDv6tZ9yNGpA93nHkl86WUxlslo7YURx3Ut1HSuBrRvWrYTGrkaf12y
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66899024)(2616005)(83380400001)(107886003)(26005)(1076003)(38100700002)(122000001)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(478600001)(71200400001)(6506007)(6512007)(66446008)(76116006)(66556008)(66946007)(64756008)(91956017)(6486002)(66476007)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1093
X-CodeTwo-MessageID: 53b26e8b-600a-4bcc-a88c-74d222fe5878.20240102081907@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 1dc2651c-b9a7-41b6-c422-08dc0b6b7c7f
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 CpaYO2Ekt9x0uiyoBHlo3BuDp1Sa84ySHs2bERuYbciCZCDw88EZNtpEDYgaKGOOnJ0oXoVUM7XJxyFoxUgptla2Z1KzN/W+Qnq+erRdPtO27vG/3I+W0NGhddxB3qEmjvZfr4vvL5FJ2UJPAhaBWdOd7nlOrfK+zszaQp0Bm31BirB4AKfcKhKPt/9C2aGw5gvyyifztZdZsgDreQrrcu/dnoySMCi/M4LQSbdkTC300OAJzU0kc39LIdcC9QrpXsD3W/XwmVQz5CMG8G+sFoHKnnzccG83OEo/R26PDexIcJcAGa9mAuHE6kAy7yE2HE02IW78vFYtNp4T7iJjRSgjoq21qWjctT7E7er19nrjLntEIHVMiTCmQu2ovFGa7eIS+qeP4OFEKFHuemtzPzQ+iGOWggVapizY2cNrkNjRPnVZOkIgYwyaOboYmCgRxSnxYNTNqR6w/bOhKyHHdXAfIEDpDxtKxUFOxif/rcEWZqWnbcVSq1xudFKLq6jr2pu4Pu8Mv3D5gEdzDJcmIwvAvGVj3fPktLlIBcliMOQCcHOnyHGEe3Odl4/2p7f6Wrx7MJV+6ITvVDOudICdUQIFqJmmnhptWO9L4EvNTewJPrDH/JANd3zegFnyNzYUj73jbzO6lQbNNqKjS5mVCJGA/JCWmueXP3k6IYwopToQeK8YzVqLwtPPoEMrzrWZLwAbTT08KIEKUGuzIRYlYw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(66899024)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(7636003)(336012)(356005)(7596003)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1032
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	271b4999-df29-4ece-b12a-08dc0b6b812a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MtXVkmJJ85tpUS1wWbZ+uCFO7rTAA1pQe1VpS9BSDyZUpj2nF5aehgr9EYPhEsfqYUXW6clrga/0Y6o+hi4E5cYz/qcY7OBmOhNLRJ7yFF3EVk8Zb/Ylc2z0xhHHVg1vQvritD0xKFwXslrjL9ufE62jzokRDi7q0bUGZKZHyI595ra7/ZxpWL7BjjPUqds/e9Mkp/oiddOSiCr+j8SGPb+3PXAX/ZtB0tx8UvpW2lA3NcFJKrTZaYk6fGZnH+7D6XeMKpkL11Zr68fLGrbMlVyDjx9933w6JIRhiC6zXkQ5bSdfzmn8YtxvyhiSeWBGBdHfPxITAWFQRt/H/vlNT2N5Wpd4ygNXvpTsfp+yD3d4YyMgAoa9XbHQMxAUHhoGA7nzI8JRnWbEqL9ayPsfAguEzYQ0z0dLlBIkBI6jXo2z2FhGXunRk0jcn0KdhARHFYyxw9d4ryhlRhyzt3Q3h5luVj5bAaMAQ5SHZVC0WEZrzYM2MNtJ96TSuZsxK7WKY/RSyF+FxTQ1k696DkTzupBOzOrco35gFnQQwH8XiznVjLTCah21CR7smVQ5tFA5zlzCF90lSYwmqa5doSFXyxQ5WyGiVr6q0FOTdm4ZLy8lxZ1e8yEvCTKDfnJL55E1A2u0IYfPph4d802qKaLTfkVNGhCgRDxDIJhGq11JDMRsN1j38QSlt8Fkf4yXla7elPtjcOD1JiuJ7ILaha0ZIAY4n3Y6s3wwyru54XgOQVe8HRg0wAsM3GizqBxRcGGC
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(66899024)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(336012)(81166007)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:19:17.3152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457f0c84-23db-420f-f38b-08dc0b6b8388
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1078

The am65-cpsw-nuss driver has a fixed definition for the maximum ethernet
frame length of 1522 bytes (AM65_CPSW_MAX_PACKET_SIZE). This limits the swi=
tch
ports to only operate at a maximum MTU of 1500 bytes. When combining this C=
PSW
switch with a DSA switch connected to one of its ports this limitation show=
s up.
The extra 8 bytes the DSA subsystem adds internally to the ethernet frame
create resulting frames bigger than 1522 bytes (1518 for non VLAN + 8 for D=
SA
stuff) so they get dropped by the switch.

One of the issues with the the am65-cpsw-nuss driver is that the network de=
vice
max_mtu was being set to the same fixed value defined for the max total fra=
me
length (1522 bytes). This makes the DSA subsystem believe that the MTU of t=
he
interface can be set to 1508 bytes to make room for the extra 8 bytes of th=
e DSA
headers. However, all packages created assuming the 1500 bytes payload get
dropped by the switch as oversized.

This series offers a solution to this problem. First, the max_mtu advertise=
d on
the network device and the actual max frame size configured on the switch
registers are made consistent by letting the extra room needed for the ethe=
rnet
headers and the frame checksum (22 bytes including VLAN). Also, make the ma=
x
frame length configurable via a devicetree property to allow for MTU values
greater than 1500 bytes.

Jorge Sanjuan Garcia (3):
  net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames
  net: ethernet: ti: am65-cpsw: Introduce rx_packet_max member
  net: ethernet: ti: am65-cpsw: Add device tree property to set max MTU

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 26 ++++++++++++++++++------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  3 +++
 2 files changed, 23 insertions(+), 6 deletions(-)

--=20
2.34.1

