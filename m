Return-Path: <linux-kernel+bounces-17626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B09825052
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F12CB2300F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FB23770;
	Fri,  5 Jan 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="XzWaT93h";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="XzWaT93h";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="XzWaT93h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2101.outbound.protection.outlook.com [40.107.24.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2722EE9;
	Fri,  5 Jan 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=YyfynJkQEa7gmN1U+c3/wskkqOWViaGMcaHdeayIM0LbapVjJioZWMTsHvRmabH3rWF1JGyEUR5q2vvtG0SEMW0qfv/E1K9xskGSBjYR2eY476YjDfBvy6jGHZjkohT5Q2/1BIkWIHS61u+PwrNziIgMdbNknFuDnGdZB+VfF3wP5NUL4lT0ymqWWDEA4Dx+zhAxqv75MWhJ34D0w85HUgZXInBj0kbFi0eDzgpfME+WmdXpr5VkIcdUnHOANwnxYSPceU0cvRbV5HnkSd7u64ofFDKo8MTvKys7ZANljFNLbbqGGMSBDzDfg8Dkp107EBnwQe/8NA4RLN7q3iCpiw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=Z8PVYtLx/OKspEbL2NfwRCWNwmjDAotkpo4hD49dKlCa4692ybLpllzX5iFpZyAqQrCT5/ehmeDo2E85VLU5PLXd3Thq4OTw2fi2oy0oujvYnU53QBYgfNPTZD5fMzobS6HlXiVr9zOgDoAtD8SQvtY33ro1t8ag0bC/YlpYGnGWVH/Dcj2sypkuFQPtawrg03fVfMDnRXileYT37nzIY2KYuEuEfZcXPPn1nQDcUNNda6HsiJc1wARGccCOBZk7xAlmMFKpxeEUGeVD6n++512QkAskVHEoh130yKpdZ5Jsok0soGXW3SNWgEjXwekfRo/mW4OPuyMsN3HplURJTQ==
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
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=XzWaT93hKM7oQJbEcNOGNU7SRSun+m+5gevYfijEK2DHp8fdSMza4KL8mAepI/h216mGAU3dNq1Les5gN0OplfVG4UZsVk39pbbAjzfWeGs8Dh2M99WW+J3LwIpWC4XedO+1ZlrhMM2Y491R8tsi67F4q0YER9CB671/5Q8dfg8=
Received: from DB6PR0301CA0086.eurprd03.prod.outlook.com (2603:10a6:6:30::33)
 by ZR0P278MB0920.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:53 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::23) by DB6PR0301CA0086.outlook.office365.com
 (2603:10a6:6:30::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 08:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 08:55:53 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T5y3X3r9czxpG;
	Fri,  5 Jan 2024 09:55:52 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Fri,  5 Jan 2024 09:55:52 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=D2Fq+hc9+OdP4kd6y8tDk11kGIqxoiECuwzctxoYhUCQgWWHdXIgJFJdf1EO4RjJ7t91ed43m8hWAqN6LCGqHFA3bIN3nPy+nt4JsdcevqLY8Q6TRbkZJJo33A9JarfEX+Srft8MXLdMIeXBPUKHx3kpH0wNhX45/LXGypRd0WfpLOyBaXd/PnuHiMGEBrPpFThJsYpZuaWZsiq6uWqc70lrEx7gulwmLYnnko7V8AxO/797CCk4Bf8HAmjbAsoH9FU9BvWOKmtF0Se5oVu8r0RXpuXSbb9q58XFYJHUtg90m8Le8fSHE2o6GNE7FG1X0g0H2uwkQwVA5NXbaM6qkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=LuaEIC4AbQl1ie+YP0U/rUtGDAQF8KtByCopftp79KH7+4MBiESYH1nKh7YWmd4ksefcdKOmZPrc0RSVIGVQhbONOAyfwi70xfN/UFvfwYcV/09zM0a/wWnKqAruxHL0+kyLsHWXHhmj9kPsUW8J4V8y0pSIOlKrhz/lTGXeXiUEmdGh+7YyX0G4sDF8yMY3M7JpNae95MUow1zqSfrw3aVbUF7rYqB+WsnWKUX3oQgxyonSRq4ahtJrKyRn04+r7VG5w5QNFKWh1lLwOn7xVZW4iMjsQd46UN9s5PqpWWcy1YbnsNiUycehY4t4+zLp6dJDHjPwFZkmghHZlmNRSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=lunn.ch smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=pass
 (signature was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=XzWaT93hKM7oQJbEcNOGNU7SRSun+m+5gevYfijEK2DHp8fdSMza4KL8mAepI/h216mGAU3dNq1Les5gN0OplfVG4UZsVk39pbbAjzfWeGs8Dh2M99WW+J3LwIpWC4XedO+1ZlrhMM2Y491R8tsi67F4q0YER9CB671/5Q8dfg8=
Received: from AS9PR06CA0170.eurprd06.prod.outlook.com (2603:10a6:20b:45c::30)
 by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:50 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::96) by AS9PR06CA0170.outlook.office365.com
 (2603:10a6:20b:45c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 08:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 08:55:48 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 05 Jan 2024 08:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWxONe7E+s84pe7hlpI4tTDV8Y26BSJHO9gTbEhPytXEygDnY1PXZ+4UZml0cvVADU6OTVGV3ayXd54JOAOEZr9OBl3v8bTlyaPduPHlx7NYexfumnzwtW5q+jHLDBVuZvAMF7qM9wnPhwicH4UQVRRuMh5dDoiHd1zEbYlr+2IzADDf0iy1yinFxtN+Zxts1Yq+07D7s/qWiAL3wBi2Ua4rF2z0WWz3ISsG0x1N9aVeB3pn3A7LxQ7BpxqS5kL+aFZiYwK347EBCkobhfSHokgbkv+CkMDLMM19X5/t532KIjjEG/BD8klZs3j4XC/u29H4ORQttWwUc4SIYirmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=Coj0FXooI7ID9uU4UdZrbEwpdGkcTYn9TxGIEnWsFxCOo7SaM5jot20Be+nhpANQ2F/6DVFeMkLsTfv38tar85xvdNh7e+gQm4tGV4uWlip+LWV9Hbaq4GQtPBQYkgql/yOPtuJ8mAZNQyxPoc1C+ywrpT9fLaQiMDXBK1/nzL1aEgajaRoEIaXEbPH4pghzey3xkSEEKsgWRo86tE8YrnA/tkYMsEmxO900rP/XINWCB+owGAJxl0epDW4NbB1jZURH9yRPg47BU2Vl67xdZJi+QBUw+HZK/ekPHSPNaJ3E8owzOcjEew9fcmns3tK1Ss9AwqpG9VlMjSSUvBApvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hknnw8UHF+KI++3W+R2NR6sLHHHM3CQiijilVpJ6mPI=;
 b=XzWaT93hKM7oQJbEcNOGNU7SRSun+m+5gevYfijEK2DHp8fdSMza4KL8mAepI/h216mGAU3dNq1Les5gN0OplfVG4UZsVk39pbbAjzfWeGs8Dh2M99WW+J3LwIpWC4XedO+1ZlrhMM2Y491R8tsi67F4q0YER9CB671/5Q8dfg8=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0764.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:44 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 08:55:44 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH net v2 1/1] net: ethernet: ti: am65-cpsw: Fix max mtu to fit
 ethernet frames
Thread-Topic: [PATCH net v2 1/1] net: ethernet: ti: am65-cpsw: Fix max mtu to
 fit ethernet frames
Thread-Index: AQHaP7T36zHr73PW9Um4XleF7+KVnw==
Date: Fri, 5 Jan 2024 08:55:43 +0000
Message-ID: <20240105085530.14070-2-jorge.sanjuangarcia@duagon.com>
References: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GVAP278MB0764:EE_|AMS0EPF000001A1:EE_|ZR2P278MB1164:EE_|DU6PEPF0000B61F:EE_|ZR0P278MB0920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a303355-5434-47fb-c93d-08dc0dcc1f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 NbtponacqX7nJ9kgscBppnr7W6EOhDeAIXc8IH7/tpGRNSir2/WsEnup726IOjLEkO+eMQY2KcpIYtQJK+//sSiTloqnjgJjKT0J4Xy1CgOtSwiM4mEwtKIxa6nOWjgwWxNgLh2NidooVmXKU8aSpGh60DFp/cQE82Z+yI/GbIC0tEZOZgxH6e2IyzpM0Advfu4Yjgc0hl5f6vtTNGsR5NYIBZOktBOQA7G+E6FV6r73XRL0G7T3sDUJryzqK0TfFNEUz8674h2XqfBNWLSEg5o4u6FM8C5nzqk4N9vEVJoLoLRyQ720A4Nv3i/y1KnVqsxPht6FYUcehDezYKWpm2BMITK252cMH614/kW7nmGrjwC0t7c8J8MNiV6FQ4uBQzA6x+mBfgTkIDiy4m2DOoTUTRLUUjj1TW35demy4rp+nVfVbJXbm1ZyCyG/BY5GTVJRzu+Ea07D2qDIyzP9yAM9f//gB1QruH7adLBq+4acBMLLufdRBBTWhm9Cod9X6dX8IlvhAlRra6Onu/QkZu2nK7/+xOrfNbBgzqy+mIVvyi32+lgZtVmFjI95lcHwWzF62ANLsU5iWhQ3NzTAR/5kHPYkvCuq5mAiUQH1uEX/X5iqJawNxmhXKpdz4KNM
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(396003)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(83380400001)(6506007)(38070700009)(38100700002)(478600001)(122000001)(71200400001)(1076003)(26005)(6486002)(2616005)(107886003)(54906003)(110136005)(36756003)(2906002)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(91956017)(8936002)(8676002)(316002)(5660300002)(4326008)(86362001)(41300700001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0764
X-CodeTwo-MessageID: 0efd203e-408a-4404-a4ce-a4e7934695cd.20240105085545@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 4625a9d0-87bf-4002-9d5a-08dc0dcc19f6
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 V0kmJxmam/mXa+Z6Y5kso2U5YtvcybOz9vJ4p11u8WMO5PBXUTcfkKdS85h+JkNP/9T8VGQt/5IzM52wLBCHA8c+9ezWlFGPHSwQ2I5c8AsKOhXe49llGMTXel/1P6s29cUSXGoLUa9QJCzzZM1fE1q4fNgDFH89iHsKf18Q+Ja5Jh7mA7pptMV+Dwh7oo18tvlZQh+A6145CjXmgllGxhHRhg48oiOxjKIfxx9GPx08ea2LDc1sQqhzoSRu0FSdVq8WN1CNS935fS0k9GkhffRqYHigL8wG9Q4flIW9Aed3IOZqvqgtmnBPRKuw0n0i//ydQDt6THdQosxogzyNiIq52XJ0zC8c+IAKkoCbMBUcz8S4+PQb59XszFiQDDOKBnDYsWkcXQagDBWx56RyYcqGHjisD9/9tpg/D9N0mUuVbPdH0MgNvS/ZsYLPHWgP2GZ3GwfYqUDmHR7cysFOTeoqIaKoUd+MzuHO+OnKkzW2Iz00GdR9igqT994x5Mc9BHemaMYU02zfs/+itAdLsfDnSFnV4XVabVmYMJFW9kDQ6wxhFeWKgc1LMp24HDvk+zpJljFaZXAbbgh9VlJ7+R8P7H5IAjMPkm9qJZQ9532SB6GlSl+Ei6KYWOjoBSZ5cSEdkcugA63BHsr3tlJLXnsWUWaC37lPVaNvl4LKcIuNHps0Z/ZBAhJOaR3IbJFDFoZBDy1cYE6UWbEKdsrapg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(39850400004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(36840700001)(46966006)(40480700001)(107886003)(36860700001)(47076005)(26005)(83380400001)(2616005)(1076003)(86362001)(5660300002)(6506007)(82740400003)(6486002)(478600001)(6512007)(336012)(7596003)(36756003)(41300700001)(7636003)(54906003)(110136005)(356005)(2906002)(4326008)(8676002)(8936002)(316002)(70586007)(70206006);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1164
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	75e97bb0-1e64-4203-c3ca-08dc0dcc1cef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	waPCJlWQ6RZxJjhfHowvVAEfg1/XcDdj+n3CXKO5o/a1fRvs9e0lklFUEkv0XX7uMlpIezHmfb4ppIZtG4Hus9xDiB7hB6Llq3FPRptzbWGp2GhrovGCIZorZnz00fnD2IoOy1Xj/opVQWFa/2XYoJEKHq7jIJgCVXjgDwhTX2cep6DsCXAYzqZ49kwtZ3Pbv/Vlw7lTBEolvVuVDGPINgscO6yaszmTkNa+dWFO7v8dAcSAJ0OlQZMqbZqaow4y7W/felA/IBApGmZayS46NGQ3lDagXpFFPJ7khxCszF3Ju4BiOMAhJqJl4fKlmzE5c9TtgQB5C/XMAu1lbedf2cs9AWgEHRMLcJ257p+IrbRAygwBKaXXJzK5scdKI12mExNHOr+Q4z5hggTibqcqbaBEhhJjl5ruLL1bIJ713kethUvTx1kjczwmsbw3KLXViS400PGO0ZkRWFHyVhGJZJNpfP+K+TDTUZ6aLmgpEZaiDG+wUtTQraQUfI3yI0h9AdssL6eZuOQ1FSaLlfXqhNulv1cUXIDhQhXS3mWqQM+pG/fAosPTiL2iCa9VkLXvrr9cP7n8kqAB7jt33ZSIIlTHkqTkp+RqzQceiVft/mlja+J5LnguD64GmNDEm/IyHgm9pxvIHs7h+cYoIIWQ/PRkZvy+xCE7L3q1VdqQQ89CkBaKERwKX5he95YpXvJKF8hMlHgrQfCvAtI1NJpYKoTo31Mz41410yKlnht2jAsnOKS1i2lkzoxqsBxzXBYc
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(70586007)(70206006)(36756003)(2906002)(316002)(8936002)(8676002)(81166007)(110136005)(54906003)(41300700001)(86362001)(4326008)(5660300002)(6512007)(40480700001)(6506007)(83380400001)(26005)(36860700001)(1076003)(47076005)(2616005)(107886003)(336012)(6486002)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 08:55:53.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a303355-5434-47fb-c93d-08dc0dcc1f8d
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0920

The value of AM65_CPSW_MAX_PACKET_SIZE represents the maximum length
of a received frame. This value is written to the register
AM65_CPSW_PORT_REG_RX_MAXLEN.

The maximum MTU configured on the network device should then leave
some room for the ethernet headers and frame check. Otherwise, if
the network interface is configured to its maximum mtu possible,
the frames will be larger than AM65_CPSW_MAX_PACKET_SIZE and will
get dropped as oversized.

The switch supports ethernet frame sizes between 64 and 2024 bytes
(including VLAN) as stated in the technical reference manual, so
define AM65_CPSW_MAX_PACKET_SIZE with that maximum size.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth =
subsystem driver")
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index 7651f90f51f2..3c7854537cb5 100644
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
@@ -2196,7 +2196,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common=
 *common, u32 port_idx)
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
=20
 	port->ndev->min_mtu =3D AM65_CPSW_MIN_PACKET_SIZE;
-	port->ndev->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE;
+	port->ndev->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE -
+			      (VLAN_ETH_HLEN + ETH_FCS_LEN);
 	port->ndev->hw_features =3D NETIF_F_SG |
 				  NETIF_F_RXCSUM |
 				  NETIF_F_HW_CSUM |
--=20
2.34.1

