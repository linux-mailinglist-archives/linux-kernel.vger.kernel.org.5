Return-Path: <linux-kernel+bounces-14139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31A821846
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9730282568
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E80D27F;
	Tue,  2 Jan 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="SOoubBbm";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="SOoubBbm";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="SOoubBbm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2112.outbound.protection.outlook.com [40.107.24.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D55677;
	Tue,  2 Jan 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=U0RWHERTJ1TtSVKIwSb5Nkm04eXGzpVBkuUiWaRuzjoa+OQhhtY3r1rH6HjWNVFox+AeYNNvEUamlhiY4kys7bZCRzcqtZsZ0w37SV93OCTmRc7cXFiHZRGG/JDTXv2IhWLN6TMzk+hTsFK7/pBg56OGD2Ctf2FQ8A3Z/o40YIjXJ+5uQL/dJeNULwfSrr93vtZ6P0dLeUOh34eDuE4iGtVV+Xs34Csv6amzeAgpPVXC5sK9/pS2KWAXj0kFYeacyLDO9ronw8agFMcCUIL0AYh4a09oONxsBBBR3FbtGF3GqNUCcMzgvznKks2HsfAVMmNCU+IwRsD5Dukl03ZT0g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=cNgC5My9kpXOa1XjKarLgyhHERKDmu9Be9wV63YgYm2IVIFdaacj1aGSsi1sY82tA4fqtZfU2PmlX2JwaU4pSiRrrSL89eMZxYTt2ATD54pSHIACW9IKdSSo/CaCJMdi8dM1LlQPAh71o0vhk/dfk5I6kw6wKOg3H65z5xNECA52Xv5kGqJRvNeCgr/tRnjV5KKU7nz/uqBkKKG09IOFFknUXvm9GImANN80cTpNRpmkNLxGBUAIrjMMzzAyC9pko482RiIXBZOYKMnhOCJikbqv8/wm4DInI85fxdi1cKdrhMg0O005HeL5Z7gud1iRTfhnPcfmZokuVdFEKUNsjw==
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
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=SOoubBbm/bdgiJAuPvSqXDZqQ3VUn1PgtShAmwLWwzxhGvDg8uivRiFfhQWDQm7K+tm3JZzIR1XQBVW7pcwUnnZ7/eppmtED0tO5ZtPkYrLU9GUTurFAtHqTycEomLDRReB1pmGcj2VgV4tq6/exIrRIJJFWQZJqUmFdUCrZKKY=
Received: from DUZP191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::22)
 by GV0P278MB1079.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:23 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::37) by DUZP191CA0038.outlook.office365.com
 (2603:10a6:10:4f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:22 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T45Nn6q1NzxpF;
	Tue,  2 Jan 2024 09:19:21 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 09:19:21 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=L1Fa5ehnNrbTgf8RTsqUKnMrC9e6mrdnDU9+NZ5FvuQIR3qnq81F/Q3yA8PSuG7tPQj4H4HYgqf1SZKw3U09P1NJgGHxN86fw5/PxXEwvD8lO+3whFmQbytz6PvQ7IQM3c1tyMVoZpkI6R8OD9H8hM0U4B5RPI+0L6f4fXdAS9bLTSVjWTU8EddQP6pE26GK3S7CwcqMmK0uW1dTqTtAT+uVb6mEidKRxv9x81sbQbw99WXj19q9/uXw0YPxmtBJY+e7EC3cPUbRXg8Mo+h0CyhgPYvnmUL+Wo0EPyD4qiFD9tzUqze+K/SRf0aiUvCbfztE1iuhRc5rX5iYy+fEvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=CHFe1ycT7gwulG+KiVY2wtRuuIOTq4yn6kmrzpZcqg26Hzn4vSgFS3cYk2gPWcOPuRNdHRyvkwADOouwhsYsdlq2WI1o/bMD1IsViGYkvZoTqupbTNWcV9frXfHdPhcdLK9S0mtKGSeVq3/0Pat8hcESpsYL9KaMJu5M9oexnPd0uZoPjSmVtb2hLJgJcLpoZ+cv8sERj7bQ8U3ep9KDiKrkZ1MmVjp26I8Yr4jm937nmrcD1tc5U/2qCfS0zT1JMoT4BubyLHc9Sm3NbW3lPfc78e/DLV5V0WLTyGQ2fHmANYFjVPrYwZcI48dFOFRDvzn1Wbwhto4csBULloPZCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=SOoubBbm/bdgiJAuPvSqXDZqQ3VUn1PgtShAmwLWwzxhGvDg8uivRiFfhQWDQm7K+tm3JZzIR1XQBVW7pcwUnnZ7/eppmtED0tO5ZtPkYrLU9GUTurFAtHqTycEomLDRReB1pmGcj2VgV4tq6/exIrRIJJFWQZJqUmFdUCrZKKY=
Received: from AS9PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:20b:499::25)
 by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:18 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:499:cafe::1b) by AS9PR05CA0081.outlook.office365.com
 (2603:10a6:20b:499::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:18 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jan 2024 08:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo6yey+HYQIW9xMFKH2EAhFdVrEC3l8JG4xvtGEktYrAXm8EMETH4pdrheZBi29lx6FRV+0Q32b7YbFOvPB4oA3L+8YQOrA/dvxHgKK04haloVKZAKxpATET1OVXrW1hxVS75QotMmZTLJETj8qpIQf7hq06DSMNqZrT6F3nbIVAMHHZxeJMebubMTjf6bU6Nn6/MKRkLDavawOMiVpxvmVIJlOkp9g//CIRQGJ28brD8SlDZmx3v3xUeV49c13yaNmZLfiZusBEWrUK0dvSlgFWr9xkH1ZzmKz3xFd6wp8iQtpkUk21EXwpr0qXlpG6v784KRi9IJTHEB/sRUEpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=JWtPn7o36+ILdUbYAMr4WVjEI/I+w0lOa+IBwkq8Gin4ThF0cnjj/68wUxdNPl1bksmI3XljP0vX6pPnt9NQmT+aUHIj4+fLdu6CwZvN1wdSd7uBqXyXfmtkAyhQp7Tyn6Ml8zXwa+Uqe210czmhXpW5sEc3HNY9YBXuEv+DN4wyQi0I3kTcozmRbCMDODOmi4gukjMeR1iVhKl4g6nLls3xkaSvemm+k1I4u50Td1gpoeqRQYdcQBfRdmp8F4Ai8Cr9+ST2kntDcAUET9iRW60tGRPdnaX6TXBUgKtNrvjuKGU/N8f7GBMU15Q21q6TjywEVc0bKOcc8H6PK2CXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuTr/C/PIKKxoJpNifpOXDJfjanQlJPpng87SNsxyaY=;
 b=SOoubBbm/bdgiJAuPvSqXDZqQ3VUn1PgtShAmwLWwzxhGvDg8uivRiFfhQWDQm7K+tm3JZzIR1XQBVW7pcwUnnZ7/eppmtED0tO5ZtPkYrLU9GUTurFAtHqTycEomLDRReB1pmGcj2VgV4tq6/exIrRIJJFWQZJqUmFdUCrZKKY=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:13 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:19:13 +0000
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
Subject: [PATCH 2/3] net: ethernet: ti: am65-cpsw: Introduce rx_packet_max
 member
Thread-Topic: [PATCH 2/3] net: ethernet: ti: am65-cpsw: Introduce
 rx_packet_max member
Thread-Index: AQHaPVRezQpIKVye7U+GjsdCUkAhwg==
Date: Tue, 2 Jan 2024 08:19:13 +0000
Message-ID: <20240102081825.14635-3-jorge.sanjuangarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GV0P278MB1093:EE_|AM3PEPF0000A799:EE_|GVAP278MB0929:EE_|DB5PEPF00014B94:EE_|GV0P278MB1079:EE_
X-MS-Office365-Filtering-Correlation-Id: b40c304d-b95d-4f60-4a2e-08dc0b6b8687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 dO7HS72PaMdyzbXfar/5MetSb5mIVhF0UG8f/2v6FIiJpTRGYg2SBdvPrp0cbCRgGwFGjZ/qaJm8OL3cKKaYMekKnrkFDUXYoMc0cHHoSkfNAuTuOMoqQ7Whfo3i3WtO3GLxgg7EzKpOgO6WE8NBPWucsCPSQaRLNwLi+ESqSlGbeWkXHLx8AwwAEC4WULMHubpsuOOmWUC4X0L3jUNVO/ALVvvvaP+3Ymlmd48uPUmVzbMoakVpDvQzUhX2m7weNOv/F3OOrjGApn6b8zXPNtfmbS+oACMF5PhSnoDftkzZ0jarNk+NPmtfwOhmJqlRszaoQb/g5hX5J4+IRE1pja/IsmE27WyDwgplFFVubUiX2tpvmMqKukzfzu2LB5rEl9403qNb2dJn/c9H/LvvRdgmLW/jP0X9EsD+pMMI2Sy2DZ1vvhGX4AUfCoe5Grq6+NlIu82DV3ofl7SgLHdXl9fMJC8XDixhmnJH8stdUfHbGp6WHubh22sGAz18eCO4N41/okCoCcKnVGl/08N8EaQaQIKMfztXXQ0NsAbxPP0HpHQ+c7MAhTYkkglGXDuuSQR1Vhovg+8iu9ZB34qwULVLotUauXqbNAL4x7OVQ0zuvoL2yK6NjpUYw0Ymp5VD
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
X-CodeTwo-MessageID: 8e86f872-9f70-45e6-854b-6db11b03c2f2.20240102081914@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 47f68cd4-8fb7-4d82-ced4-08dc0b6b8114
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 0tHJg6Hf4aBCUrO9ONYP19bteb2gn8+xLFAYocGi8Iwx0Yf+gbSjb3hloND/+djuWl4DKo+KU1Mq3MsL1mKT8Fv2vBNAKztRnTDyqcCc8YvY+nncCztgX52eT6LmHxCxVMPQQvynV+906gE7tHd3wmot5qh4oBGEQDEDLahT4vAgXnjG8+YKwv/BrnmsR8e71nM+YWxzFXBdgLxxOLzt8kAZo0gL908DrR7F5I7FuFiuJD1RdnI6Qvf/JTcWp4LvNPgDVHZ0iwM9NqY3aQEXHEyLy2k7umHL1BHkWcjiQ8e1Q7Y1A+qAa7j5DT8NDJ6I3nu68DfEcvBZGYI0yVdD8RsRuTfT5SQQp5TiCExFIfeRqXa2jaoBJBEq5hPraNyWzhsIeM3bIZiBbPpYhaEju5CYigkgqV103J4dTXVIkeWgW3eAeFRalbF1+WtLOqxJ22GgRImoD9kalwcm3bJ0f56WHrlgmpH6Bnavsx6nPeSj+Y4+hkYWbHC2HxF6l+iK9uFkwKhjH7OMy1kUoqsSiW+7iKFbHaEV6tTDmb2YaHQMw9TGPdN55nepspwEUjLwfgruFPCkebQw+XkTkYfzX5DPbiO6CTgLDzywY089EIPb/puizfnvi2+ElEjYNABiSdjuZAUUav9C2LGCh/WFBZMllikOSqLEnykBfEjxCcdr7vVad6JPzWl35U2wHxf3SQj+gGT4PLrzWEwd6nHQVw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(7636003)(336012)(356005)(7596003)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0929
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	72c3c2d7-187b-426a-4968-08dc0b6b83f4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p4UFARnDckCNj1lmp6poOjXTgpOTbYMKaAyTBb6/6yWcliloXhTRvM95PhTl9eO7abwEsfDfv4VNM/XGH4Bn4BraVvvDShj6FsK1DjKHPUuBH/xqyKxuS/VWUV09l2zlWTEJmQQ9sWAAJmT/JMMZNm/IYrWnp6U4NMCvdXKQA2+aArgDw1MWSZmCxwLxzn77qnlSG9YRH+4MVygJVACIQ1yRihTR1wqLuGNP6Vq0BaGHPxDYiVWv8jfSrapLuJaTh6KJx3L5KRAm+F/UANQzzc+4JvbO8jmdNbj0kbpK+dTnWB5dVKgiNI0dgThbBcA1Ul9ww1AIJUCKb7ZCg+hfwOEi1gZ+bph3/Hai6yRMHMZgFLq9sHtboS0vgoTDdDjzKQeUiNWJvg863YGT5obRta8mXsnlRXgYB8Cn07ftrmpa3T7Ymj5fm8VqbEIzUtD0ReMVab5JuKKmPaGE6KDvu7JZkMJ4Rts04x6d73IErPx1z02KXdylU1MBOU8dRAdZIBLFzJyICgRMNErCSKAQKsAsfjEuCPayz39stMwX14sRAUp+tfljvxtk5LE5YoeGQiMJfcR60U5FsgdghgCAa0MmDkp87q+Of9Wx6cbgcU19LAmyuRjP7z9E2vTeq22+5xVTNY9gMppY2rm+DB/PX3x/LzsiraLpOUDJiKJGcQNfHruB8Joc68cnGh5lHn4VQYT8BDtUHkcOt6AixuwK5nShC/d8NKclqJ9e6GXludVliDcjJQZ2kTitSpqpLzpf
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(336012)(81166007)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:19:22.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c304d-b95d-4f60-4a2e-08dc0b6b8687
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1079

The value written to the register AM65_CPSW_PORT_REG_RX_MAXLEN
is currently fixed to what AM65_CPSW_MAX_PACKET_SIZE defines. This
patch prepares the driver so that the maximum received frame length
can be configured in future updates.

Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 13 ++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index 378d69b8cb14..a920146d7a60 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -151,9 +151,11 @@ static void am65_cpsw_port_set_sl_mac(struct am65_cpsw=
_port *slave,
=20
 static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
 {
+	struct am65_cpsw_common *common =3D port->common;
+
 	cpsw_sl_reset(port->slave.mac_sl, 100);
 	/* Max length register has to be restored after MAC SL reset */
-	writel(AM65_CPSW_MAX_PACKET_SIZE,
+	writel(common->rx_packet_max,
 	       port->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
 }
=20
@@ -455,7 +457,7 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_=
common *common)
 	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
 	       common->cpsw_base + AM65_CPSW_REG_CTL);
 	/* Max length register */
-	writel(AM65_CPSW_MAX_PACKET_SIZE,
+	writel(common->rx_packet_max,
 	       host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
 	/* set base flow_id */
 	writel(common->rx_flow_id_base,
@@ -507,7 +509,7 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_=
common *common)
=20
 	for (i =3D 0; i < common->rx_chns.descs_num; i++) {
 		skb =3D __netdev_alloc_skb_ip_align(NULL,
-						  AM65_CPSW_MAX_PACKET_SIZE,
+						  common->rx_packet_max,
 						  GFP_KERNEL);
 		if (!skb) {
 			ret =3D -ENOMEM;
@@ -848,7 +850,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_c=
ommon *common,
=20
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
=20
-	new_skb =3D netdev_alloc_skb_ip_align(ndev, AM65_CPSW_MAX_PACKET_SIZE);
+	new_skb =3D netdev_alloc_skb_ip_align(ndev, common->rx_packet_max);
 	if (new_skb) {
 		ndev_priv =3D netdev_priv(ndev);
 		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
@@ -2196,7 +2198,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common=
 *common, u32 port_idx)
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
=20
 	port->ndev->min_mtu =3D AM65_CPSW_MIN_PACKET_SIZE;
-	port->ndev->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE -
+	port->ndev->max_mtu =3D common->rx_packet_max -
 			      (VLAN_ETH_HLEN + ETH_FCS_LEN);
 	port->ndev->hw_features =3D NETIF_F_SG |
 				  NETIF_F_RXCSUM |
@@ -2926,6 +2928,7 @@ static int am65_cpsw_nuss_probe(struct platform_devic=
e *pdev)
 		return -ENOENT;
=20
 	common->rx_flow_id_base =3D -1;
+	common->rx_packet_max =3D AM65_CPSW_MAX_PACKET_SIZE;
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num =3D AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin =3D false;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.h
index f3dad2ab9828..141160223d73 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -130,6 +130,8 @@ struct am65_cpsw_common {
 	u32			tx_ch_rate_msk;
 	u32			rx_flow_id_base;
=20
+	int			rx_packet_max;
+
 	struct am65_cpsw_tx_chn	tx_chns[AM65_CPSW_MAX_TX_QUEUES];
 	struct completion	tdown_complete;
 	atomic_t		tdown_cnt;
--=20
2.34.1

