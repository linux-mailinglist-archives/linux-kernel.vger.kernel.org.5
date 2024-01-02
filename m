Return-Path: <linux-kernel+bounces-14138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4D821845
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565F81F21D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07450D26A;
	Tue,  2 Jan 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Ig1Mumdq";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Ig1Mumdq";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Ig1Mumdq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2119.outbound.protection.outlook.com [40.107.23.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EA6AD9;
	Tue,  2 Jan 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=BsFr+sDBetaaC9lcNyVjfxgyO7bBdRXH3Xcw7y/hzv2Uco+/kn1Jdn3ftYcXVO+MD4jX32QVSzYRwLxEx0XwXpitRFoXNdBUXPe5KmrHoEivLXdnEWZwicR7CQflKb24LSO5F9Ngccmsjuinohilyt+ZKjDuh4iBc/R/ZjqwcuehrcmqwY8adnA4+k612eWsj+z7DYAoiUCstsom8zc8Z/PU0Qn+fRKZ9mT+po7ywjd325bnJnkB8PxtA3DYkpdXfuaivbxDEsj/s4abx+Z8HH5UZ0VhCtI8Mdrc/6I7EgyoXEeHEpjQ5ivcyPbVcZA6B0JqQQDpYF9eDHbpfc5b2A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=eJIjktevNHxm5kVAF+X+nO2hj41f+BXNdBX8jlCNwJKJTdIvWa888qQF7//XQSVbjrrGA49UDxUsVFcrtVTon5LwBq6jU058zhTOtQE+YJkedlAc3eVD6YGWyJdAyrGtpgkFIQTYoM3NSxwMT8QMVkPGFdpGjl5v9Y/Jtv1NVyuDd12ekYsE7BomRSeAvLrkPDxIGDaSQfftcQ8gPzZwidHWfFFq53uhiQj9hlotmPSLZvtii5eggSGivBs5OWYxI2Y7qYYw1dfprJDodIBy/MrZw1Ze3IaJP/RgKbmtFlCZR3dWUqTSwrjYGoguJL3QCGmMFfWQ+/9t+5kZvEY2GA==
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
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=Ig1Mumdqg5EPQAdB5V/ire2qhhBP4PFWx8rr1qA7tJ54RePM0EfPKFmiYxWy9F7aTgCbIeAxXH1yO0BsEisXV9ukwcK156oTUeARl1vwuU34wcnSw3wjd6kBjBNK1KOmSs4seNaTpFDr0XgNNKPmogRYZhJCPFQNf/q7BIRBBqc=
Received: from DB9PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:10:1d9::34)
 by GV0P278MB0097.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:25 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::b3) by DB9PR02CA0029.outlook.office365.com
 (2603:10a6:10:1d9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:24 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T45Nr0VP6zxpD;
	Tue,  2 Jan 2024 09:19:24 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 09:19:23 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CXy2h3+zviz0WH7pwCArVgnx3AWp+1siCVgcKNBZYtW/pszLpz4JitXxP3YHE/CRFGdpMTx7YO8ems41UGqgB0bP4kvtCrnZygAUkB7PoAgoUgs7zdNTmXJPn/Ezp7CGWghpPHyYUfY8hh7vfZxME7k7dCNGCbT9f50o/HamDzvNxclJ4/OrSxGqZ3SSE8ZJCMr3Xpm0ZGxlYbMrRqckVk13A2/jkeMSOBZ3hvqa6eBQOdRiWvPr72GyRoYa6SOEZf4Sbp5kSQALpS1V9xsE7CDKlU1PXtxZU2xgFJZvGoPdjtb9sOO7eAM0XDc3RPQzJrULkaba69yY8L5bPqdwIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=UgUjQx7oF7daJ1LqRykw6T3MpI3khAlKPdL3h73a3KN3OtN7JqeGmZFSvh4NIRRbg+jr/5hCrgUhNj/VDQBDxSOxkSTad6CUtH9O3Poj3mlPWS/L0WeIFTd+ZFPbZGIUjRvVT4TgD868zCnHlOtXoGnEyVyJ6TabGtliSZvu9Evr8jMWD83YIXMdLapU/e8msClzht0jAnvlHFVdxTyfGWA1gPctkAsMNIeYf+x33uQ8w9UpiEbTumBGWBPpegQqKg28EWMkAnVdvnA1ZhIQu9VdEbP9L8M+zNZKSbiBOY9fYdkLxYP9mMAvvdEClqCB51wRGaBNuXVuDc3U2T2Svg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=Ig1Mumdqg5EPQAdB5V/ire2qhhBP4PFWx8rr1qA7tJ54RePM0EfPKFmiYxWy9F7aTgCbIeAxXH1yO0BsEisXV9ukwcK156oTUeARl1vwuU34wcnSw3wjd6kBjBNK1KOmSs4seNaTpFDr0XgNNKPmogRYZhJCPFQNf/q7BIRBBqc=
Received: from DU2PR04CA0085.eurprd04.prod.outlook.com (2603:10a6:10:232::30)
 by ZRAP278MB0898.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:20 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::e8) by DU2PR04CA0085.outlook.office365.com
 (2603:10a6:10:232::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:19 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jan 2024 08:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCamOJACuNZKffC/lQNmIPhAB9YiiYL9taCpKkgwrR/PiIEGlI1dtE3bv8IT5coJYAv0g4fdHEVNnTpCSwJ7X2B6tyA0GkC0zZm5eDga42mVaLnpNdioJu2PSc4tWC/4r2BUw97Buv7BloE4fTjFJywTIdPn9Maq+XjTOQfuwwmAamUkF17kfxy3lyrHGm01LblBXngE6ruLLbFysNBv0hEoQ3AmYrdBC6R7OzKcC0Tajki4FTPq5MSisumC5DsXznvKgO/EkerVnTxWOKf8DpL4SeGC0Z1t5cirKxeZzmZ5XNXs0JOseyzmp8+PjKsCYtSvwKPEztAXJhfvNHj0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=YIBPPhZTrtk+Gxg9htTcSttx7pR+GgcxXU4m6IyL8vmHpW4PIEijmGNwaPA7BNA8gA/jXFbQSCM6ovvuVqs8KmLw4KVNPZ+lZqPcOMKPUKR1eYGfJVO+o/mZlhnfxS7BIRmmumnEJ3QE38N20OjQvGEng5tzlhFRvi5g2pl/9byEoDjaxbPNOSmUG+uHFbkzuWGiWqFffukElf4As3vU6azYlIK/AojoGUabiEjAovhEJ4VFQ0OLyaVBMj8zZgEDKjUQFzeVrDsixl3W16iUz+FssVE3Z+EkdGy9/TGCN7sANlasGX4ifvl1RX2+fCvQw0mwvd4gKNmgatlOKp0u+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP4dHIWdOEmE5evqKrJM8FYFy1LVkR2ZXXkPK3uM7w0=;
 b=Ig1Mumdqg5EPQAdB5V/ire2qhhBP4PFWx8rr1qA7tJ54RePM0EfPKFmiYxWy9F7aTgCbIeAxXH1yO0BsEisXV9ukwcK156oTUeARl1vwuU34wcnSw3wjd6kBjBNK1KOmSs4seNaTpFDr0XgNNKPmogRYZhJCPFQNf/q7BIRBBqc=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:15 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:19:15 +0000
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
Subject: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree property to
 set max MTU
Thread-Topic: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Thread-Index: AQHaPVRfDFA6sE4cakC8kOOs98f50Q==
Date: Tue, 2 Jan 2024 08:19:15 +0000
Message-ID: <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GV0P278MB1093:EE_|DB1PEPF00039232:EE_|ZRAP278MB0898:EE_|DB5PEPF00014B8D:EE_|GV0P278MB0097:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bfb0d2-4e06-4a7d-e77f-08dc0b6b87cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 nyZgIbOFpvSVFcMGSTpWJZ+H9NrudwzI+KWZuxnTQeQi1sZqgKIIISkXiPESb0SS7S7aXoOtw15Wk7tXqjY3JK4VLwuwOHkrf3yZSrXwDhgBq/5HjabNgnnBwrE7REnle1WGkcpvJI99YN7b5LkWaoEmDL8Zc9aThWD4aMCCacAiAHiTCACxIDnXkTP3FAtjU1mZjfFzk0ATp4+Lzuyb+p7ssWLd/bZoA3hGLO8M99YK6e5Ca2bRL/i76I5ZwR6SjcN6eMqH47l3UypVe5USa46D8OEjb6Es9Xltic9warjXOU4yHL+GMu8LgU9G6oAj0I74ntWug9+7RJ8UBha/e9P/kpIxYhfnc0oX8pHjvX5j3fUhBpT9P1/jE/oJMl+J0U8K3Z7qwaM4tnxze/EH2gV5TtIkSpXL0LUHbiFDQwSxeCagd0DNL1V9Qtyn1+S5qWyzQJIu7RnK76rnGZZojdAOtI2yxT+xSTGHPEQb8SbhwyapftAXw6i0MET2ydWbws3IAy1LmHqqGtTkJcpAHlNukdKKlsU1AYFb5PUbxG6tgh81DHSNmQPbX9SvNVGv/DapqeJMIgz71yjfHBumPTfUS7N19jcm37ep9WbBRSOClIky0rQGXMAA3Vz/op82
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(83380400001)(107886003)(26005)(1076003)(38100700002)(122000001)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(478600001)(71200400001)(6506007)(6512007)(66446008)(76116006)(66556008)(66946007)(64756008)(91956017)(6486002)(66476007)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1093
X-CodeTwo-MessageID: 5bbcd7bd-05a3-4071-9796-27d1bf5247d1.20240102081916@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 e4ad888a-992a-4210-5f68-08dc0b6b8259
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 4FkMc066gMlzJzGQQeW3+1L7R+FsVHODGcgrboYM805mbNYd9V3KsWqVd2wJF1MFUHfSzH0Mj3PjSYzq+/1ABe5Ye2V4pB6+ka0gmaVuXP+p8tum6kaUKZX9BmVfqr/sYj2rf7SqW/sbkn2jBSmYNf4uLjvjBMShTdzB8isODBQfA/ji6Xd3tXB600YdcRf3gpYccLdoNKE24tWG5lUwcRyu/J8+w56LFJ3icITtDlpnJwlvJGs64/F+yaf3x35gD0kHxcGVIUUTHjfih5dvN66Wv/9IYvWvvKq+SaK3cUSqrjmoa/lTUzjAYWqLp03MYPVovSStJ/qdFDcDwfnJDAhQ7oZFBaeVkEl1rLWNGc6lyZftJ2YuLTQQ8o41w8fz8f42z6Es4Bi8hiB626sng0ZCqnDMDdvaCLJTZlGwIPPm4nNzY+MkLvwLPzC2niLJqDPM8VjBwLV5SZU+30NGnF8P7qaLZ2zwKwmiRCZaBk0JrQSVSJIFCCUXXGVi9RFwSkKpV2smoN0NMnzxWZLHem0kQ0eLPS2mNQ8xvQuAGfrpfxNiNOR8HGr4ybFy7W+GHBq4Q6XKFuNw5xfCk9kikAqqgx3AqZSgWqnWRUgI+R+anslaYf9fKNCi5ZjDIdSZ0E5pvCo9ttZ4f9DpZfVdQ3OjSYMgOKY24x25Kzvd5J7x0rc7iY3+jL593+fViYktOKQv0VZLN9UlqN3SAp/DVw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(1076003)(83380400001)(2616005)(336012)(26005)(107886003)(6506007)(6512007)(36860700001)(47076005)(5660300002)(70586007)(4326008)(41300700001)(478600001)(6486002)(2906002)(70206006)(316002)(8676002)(8936002)(54906003)(110136005)(86362001)(36756003)(7636003)(356005)(7596003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0898
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	961a7f14-9fab-4b56-86d0-08dc0b6b8507
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4BWjoYhGFntC0SZSBc1Cj0PvhXKxi9fhLZlH8PSsGjmVmjnDa/GG9V94pgZWI9MVulYqhQXgcJQQQabrmVgZMQAEtzMGamFtg6fh8PisQbhqkU5ujgWswDMt2k0BIagPt13Xq5k+uOBaNuY6mGiXZ0tiikDpn9NQxxw8s8ImMF8XiSvm8eA12TZ11WX1u61K4K7TzW3rEhjEEUh5NAC7c6s5XNzDzLt3CtDMtmkN7y7938mRPLbgN95DL1ImvCGThzYssPLcJ70uI3wtiBspBS2TuvXIuD98RUy5d2sn8dZ1G0rMF4nDljVhm6sjuq+E1ykWEe/5eUx1HjUWtZMr9OXyXbesXShnD2/jNCCkVSUQlw0Kq83RNHxs/nnZsG48a32zPmsBFrg2Q3PXJzcak0U/O5UtiV+Eljp0MkCgqV3ImT7d1AnJ4jOrXiAEMCBeFZBIsPmngN80XgoN17E/Dbi5A459XT6MeCxLgAFI9rpSS3az6yOfC+bZWVq2v4IU1UM8FK2DrHfk3bW4NM4NPHK/MENQ7vN+3ENAT3XnzZ7wOg6KFsEvvTkL8vzhGePvMHdnpaw+H08i65A2MR5S0LoctscK59vW3jnfVox8bO87170JCSVixNEHWSK4Wahbz/BBwIYm+t7I1gs1JKWauEe5mZ9KigQyw3nzmbG3cbJcIrFOHpkFTpumLV4qjV7EXs0QlEwdh4x/E4o2daKNA7AKpOz0e3kAGkmY8mWppiSDkx9dG0w7Crt2OxNZdms1
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(336012)(81166007)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:19:24.4492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bfb0d2-4e06-4a7d-e77f-08dc0b6b87cb
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0097

The switch supports ethernet frame sizes between 64 and 2024 bytes
(including VLAN) as stated in the technical reference manual.

This patch adds a new devicetree property so the switch ports can
be configured with an MTU higher than the standar 1500 bytes, making
the max frame length configured on the registers and the max_mtu
advertised on the network device consistent.

Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index a920146d7a60..6a5c8b6e03f4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -56,7 +56,7 @@
 #define AM65_CPSW_MAX_PORTS	8
=20
 #define AM65_CPSW_MIN_PACKET_SIZE	VLAN_ETH_ZLEN
-#define AM65_CPSW_MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
+#define AM65_CPSW_MAX_PACKET_SIZE	2024
=20
 #define AM65_CPSW_REG_CTL		0x004
 #define AM65_CPSW_REG_STAT_PORT_EN	0x014
@@ -2198,8 +2198,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common=
 *common, u32 port_idx)
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
=20
 	port->ndev->min_mtu =3D AM65_CPSW_MIN_PACKET_SIZE;
-	port->ndev->max_mtu =3D common->rx_packet_max -
-			      (VLAN_ETH_HLEN + ETH_FCS_LEN);
+	port->ndev->max_mtu =3D common->max_mtu;
 	port->ndev->hw_features =3D NETIF_F_SG |
 				  NETIF_F_RXCSUM |
 				  NETIF_F_HW_CSUM |
@@ -2927,8 +2926,19 @@ static int am65_cpsw_nuss_probe(struct platform_devi=
ce *pdev)
 	if (common->port_num < 1 || common->port_num > AM65_CPSW_MAX_PORTS)
 		return -ENOENT;
=20
+	common->max_mtu =3D VLAN_ETH_DATA_LEN;
+	of_property_read_u32(dev->of_node, "max-frame-size", &common->max_mtu);
+
+	common->rx_packet_max =3D common->max_mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+	if (common->rx_packet_max > AM65_CPSW_MAX_PACKET_SIZE) {
+		common->rx_packet_max =3D AM65_CPSW_MAX_PACKET_SIZE;
+		common->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE -
+				  (VLAN_ETH_HLEN + ETH_FCS_LEN);
+	}
+
+	dev_info(common->dev, "Max RX packet size set to %d\n", common->rx_packet=
_max);
+
 	common->rx_flow_id_base =3D -1;
-	common->rx_packet_max =3D AM65_CPSW_MAX_PACKET_SIZE;
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num =3D AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin =3D false;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.h
index 141160223d73..3bb0ff94a46a 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -130,6 +130,7 @@ struct am65_cpsw_common {
 	u32			tx_ch_rate_msk;
 	u32			rx_flow_id_base;
=20
+	int			max_mtu;
 	int			rx_packet_max;
=20
 	struct am65_cpsw_tx_chn	tx_chns[AM65_CPSW_MAX_TX_QUEUES];
--=20
2.34.1

