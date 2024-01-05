Return-Path: <linux-kernel+bounces-17625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B882504F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFC1C223D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADF22EFE;
	Fri,  5 Jan 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="EUZl/IGp";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="EUZl/IGp";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="EUZl/IGp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2107.outbound.protection.outlook.com [40.107.23.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0722EE7;
	Fri,  5 Jan 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=boYHquok9GWIWE1+rPbNN8adj29oc0FOzGChphBhjgt8iAL97kl6vFzINwDNZp5VBzQN2icVeNi+Y7twCYij6KiNUUWHur1zNVlVgk6ElZm8su54Vl1ZpXU82Dq0wZktt2xq6CYk6hm/bHE2X5kBVMTgJKbDSPMG23tFMmY9hrUqUFfmAJIH3qMN7wosjqU71d1BCVp/7/YICayr9iKmceRwp9IiR9dzNJFdX5uPHaSI8A5B6xyiGF+s2JYt7kqb+Y0tbJPdA52GOHLs9I3zBy1IfMZqDDmHSimE1acYDH9zyTd/6cxRYuHtCAFt2tU59siV/hA6UDDo3+aRyZ2jDA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=lHsZxb5P3M+4uoVJebRPxZKrvmZu3C0Xm/uU/erurZgex/gkiOqVpmeCHl/QKCdsMy6zCzcDNPnD9Hy8ZTeai1cw1rvXkcZoN1kE3762zkjSEO0YRXMSkBW8hLvz1dXkghGiA7xzfgMbVxYpTMzGHN85r2Lqp5eRznoOiFLiaRYM0UJHpOnO+lXUIC/tNOER4uwjZ8LmQ2RZX5dkgd3C6Uxj5M0SXoAwMqkn26b7h7Kg4sX2ICNSNcABy2RLzHdhaVlWRU8TfQnksZRRWmkImGJr/hS45LPw19rvu+8fQi7XdtVzlgc86asGQy81prNhENvm1qx6XXBsD5+vEdGr4w==
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
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=EUZl/IGpj1mLrAg+tWIMei1yAZVDowmfraxITs+p8zQYx8hRloi6a4okoRQ/CmDZ00K+K/fOmobBPHwlfTyK3x+BSBz24G9nFHSYM9O1yO+lN+TjkXETVuE+DvzJkHklffh7pf55y5Lwmn5wAiDtoKd+jgtxPhTl/NBuhpAOrqo=
Received: from DUZP191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::22)
 by GVAP278MB0118.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:50 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::1a) by DUZP191CA0038.outlook.office365.com
 (2603:10a6:10:4f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 08:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 08:55:49 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T5y3T1tKjzxpF;
	Fri,  5 Jan 2024 09:55:49 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Fri,  5 Jan 2024 09:55:48 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ARo8lXWv2oAhiKX4EYvRxPeusv+/CaihcgfDjA7AvWY8CxCPY32ND8bpo7eVzNAFqmvDcCpVhI1C9XLL7lUh4V5oZ0iQDT4FpSv/RDKgnuErhOxQM2Y9FzdVGowK07XQhuhK6i+C77WMylvMyDwFZ+wqt8FRpDKlHYDxo0lt5M1gXT49fmh7Rf1mFhACrx+gCjkA+6nSU816ZVCT88NBiwbEjXtauHXz3EWP1qtqd4q/RQ2clopAHVAGEKZNElAfierwoXQoMjpD2O5+vlvcmaLR0N+GYNWHX5oKGcLEdM5eF/vqrRHI20ZZCl+YYneXsGCXwL6icHKZS5zxo+I/yA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=aTrJi9I1iXBvGO9NOAWM4qq6pJit9grlohG6VYz956WgifJrtwnbFxrtxSU1OveWrM3znmhzkPn0Thcmypjc9tiF3qALi4KKPkWWNZpyQznvMDr5QsstYd/IwTwDCdi2A4drphgKzoqd1pyl6Dc73raYwHJLAkxlgfPWAYoq90cRrlU8L+biMck9jXmbsUdGXrd9dSWipLjdW01V229YrjdcZwlTwux7ijMB9TuwCDYeJ+LPcW4PMXJ2nTomjiUd5JRwhULLsRifcqOapaw+v0qzBna4St1waGhaqjxOQ5l2lS3fu3MIRo/N18Nc01xrPdl07dIsA39L7ws8Ran5Rg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=lunn.ch smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=pass
 (signature was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=EUZl/IGpj1mLrAg+tWIMei1yAZVDowmfraxITs+p8zQYx8hRloi6a4okoRQ/CmDZ00K+K/fOmobBPHwlfTyK3x+BSBz24G9nFHSYM9O1yO+lN+TjkXETVuE+DvzJkHklffh7pf55y5Lwmn5wAiDtoKd+jgtxPhTl/NBuhpAOrqo=
Received: from AM6PR0502CA0039.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::16) by GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:24::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:46 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::84) by AM6PR0502CA0039.outlook.office365.com
 (2603:10a6:20b:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Fri, 5 Jan 2024 08:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 08:55:45 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 05 Jan 2024 08:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoN2XXRGVFgx5Enctab0GTJD8ClZd8vZOyMPcK9tiIhZj9E2BIplsaOL8Yqx3Sj80J0tSd5JCexrt74rPn8bTbLGYZhAtAnX21kHMYQ+AsMieZW7Ojh6T/V7KWfhOZsyBC1P19fnKSeACn1HkBQaMXRB45tq2YAclSvMvQvC97ji/9s5jX8CqadtnbEDfd9YzmC3JDfWC6hrkjHZzxozhtG66bCm5N+iEUQeQk9kQDbebSzzSQBWK4IMFZgFYjPSDl82I9FHNV9GFNuwI7qFnclzeliHq1MApBhLj1ek/KtVg/e4KCTvr/qF2mN6ReQ5ty62++iG6pvsS4OHITUyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=dXEuCQbQZxnMTYnolyM3uVpDAkBCZHReW14e21yGagsgvGdv9XuDxumCrht52r1p16fF2zHxiUfFoOAzxCFWWnR25BYEt+8NNzxdp78dDo8lxsykjo6cPfQDx7jxiMa57cGYXKeaPgmSZov6tTLAbum0pwK79lEMVnQUmtusyEJC2eIEZqu+f/bkAYFZPQ3koZoxG7vcV9H/M0/IcHHJi3stEkKSr/qWuERMkGec4+jPonmW8KceqOWWCds01tuFL3w2sm4Mzd9gLlxo1XCkgNGxNWc+UTl5ATpX5QMs0g/yECrJD3qw+HKWJz4xxB8u7u0IA71RtapgwRfzlYP8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb4caQUNvt6yVf/sF04ghSR2NwxDYSJCyrUeKlreWmM=;
 b=EUZl/IGpj1mLrAg+tWIMei1yAZVDowmfraxITs+p8zQYx8hRloi6a4okoRQ/CmDZ00K+K/fOmobBPHwlfTyK3x+BSBz24G9nFHSYM9O1yO+lN+TjkXETVuE+DvzJkHklffh7pf55y5Lwmn5wAiDtoKd+jgtxPhTl/NBuhpAOrqo=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0764.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:55:39 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 08:55:39 +0000
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
Subject: [PATCH net v2 0/1] net: ethernet: ti: am65-cpsw: Allow for MTU values
Thread-Topic: [PATCH net v2 0/1] net: ethernet: ti: am65-cpsw: Allow for MTU
 values
Thread-Index: AQHaP7T0fi4egi9ldE6vGFwYnBU0hQ==
Date: Fri, 5 Jan 2024 08:55:39 +0000
Message-ID: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GVAP278MB0764:EE_|AMS0EPF00000194:EE_|GVAP278MB0087:EE_|DB5PEPF00014B95:EE_|GVAP278MB0118:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1724db-dceb-499a-e0ed-08dc0dcc1d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 0iEiJ+TpVVgCPxD/yGUL5YKhrvIFJGUjUZOwXU8xj23gM3pTfByNYwipM51TnB43P4k8Z+44WUgeJxWGCIrRXjGHTMkWOBXSByW7fxuzRLLqsO0+qgPibhMqPlXvwDt5BmvBcwpmftc4ZwFa6gomQGl83udG2mcj+ZA8Jt00PfdNCmc+0xWdSu/ms5qkvkXOwTmyqSkYGHnf/yPX1N+qrk+ksLrp5BVX5Z/YCBIvPJP6dpLFotZPi4fJJsK/9SPMB59hpCnOB0w3RsxQFQJPwXKT+24cCjGbBIJ/G8CKYZHm83GabTjozT6Y6XZHB4bxNCf86U30qgZ+1H3R7KO+o/1RL8Jx8T9Monwj1rm4I02txlOS5dAKzq5LV9wP9fYdUdA1Go4qGAIhD8E4AMDm2M7b1xV60qzmWRujUjnpeVEhOOoLbyAbu4dUCVqGZG+mDJaEeRyZmz5Yqs30R2D32Ax5S1Xn871gs/EJw9bHBY1NoCnnIjGyC0pxqwEBXupCj3uvzD69aKZGWwIoW4126ANiG/Epv5HFwQRf8+LWwcR6tkUVqhAFInCpLDtKPPvIalx02wrg+2MYolL5IF3H0NZMhNAITCiriucw/q3MHxKEbr7MaBIW3iDR1rayaHgI
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(396003)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(83380400001)(6506007)(38070700009)(38100700002)(478600001)(122000001)(71200400001)(1076003)(26005)(6486002)(2616005)(107886003)(54906003)(110136005)(36756003)(2906002)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(91956017)(8936002)(8676002)(316002)(5660300002)(4326008)(86362001)(41300700001)(66899024);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0764
X-CodeTwo-MessageID: 83bf2e7f-d7ea-4c81-8a4d-5ca6d975c34f.20240105085541@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 0ce0da79-ae71-494c-4908-08dc0dcc1718
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 WR154OI43Mmgn7xckC+PlAo4VWj+BtYo9k97feRo3JWc66UwdUc8wxseXJ6MfS9Y0f3karE3VaUlEIt2nJ0bK7dFIjIxbqGMguJ3jBD256aV1XrGMYPW/N3wTyUViUigCIo2QHMmvwXlEb9u983yFcsuyCEXbXtnH2Vo4S4Q0P7ei9cdEQOZmSDJTqv2W32MnKZn7J1m+LOwWsyjwktH7fJXKlH5MUIyI4ZOW+he7sjiP0MPe1QZW/QigqnzhRlKwPY64h20LLChOPUBnLYgQSVgvXdyJKpJ07EVYzYyuB/EiDSYTMmYXUDE2DYZW3FCMROsR6/nVyTzM1rUQq7HPj6b2458u1BUhhwKTW3ZPoICxfByEGKKD18Pnmo6aniPOX+Y5nWqAT+F1pRYRkFB32h67t12t+f0nKMcMHoTkZL/yRsr4mH7InkIwL0ecXtE8dQUrQaD9omBAOQKukuhyWQrKP4IkTN/uA9Uo8DyCr8WHKmmmBmNS+Q9StERHVlqG0ilPih4MWF55z25NZFpkn5mf94jD+BlRDlVI3llrXgRmBBSaiZiBLzfxw+qEPvvsDz/p3fDHuZAu2m8/ZZZyh+c4WglogQh4SYibw+/dc6mWTP0gGr0lniBnTX3Un9oPVNhGdTCS8eNgfpNvNjb/vMaw0muKP49Q5CAGh80Y3TtXeBg98MVxAe/A2hwQCjZehCXNvcC95mw8gjPBqGjVg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39850400004)(136003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(36840700001)(82740400003)(70586007)(70206006)(36860700001)(356005)(7636003)(7596003)(47076005)(6512007)(6506007)(86362001)(2616005)(107886003)(26005)(1076003)(336012)(5660300002)(36756003)(2906002)(478600001)(6486002)(110136005)(83380400001)(54906003)(316002)(8936002)(4326008)(8676002)(40480700001)(41300700001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0087
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	359e95d7-3ed0-44f4-2e5a-08dc0dcc1b44
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+g8lBXbu28iQcBgqKWO8rNVfl+uKr+exxzJhouUcWolmvgjgbb/Hq/4W8Qu6QvcRUtFF487qWHQPzeaQwJ3/Qagxpky43yGNoGdFjnPJcHQ/4TYbhDuImeMo64kKfV+So2c84hgSNTD0IMq6Ul1TsUwaa+HnSISePKe5ICXE0sCTRhszpk4Y6bIpqjjvObM5RmgQcPOdWvj4Bop32/l6ehVD6DGRAoPulHrg9vfoTyxQVKUMpMGjdd9XXOS8jDCG1eo/0+9139DO3W8vQpgbyj67zV9C0maJSNKNpLSw/pve7QWXssBcQhuAR5/x4ye0AUupasDbmlgy9A5ZaIDZUdZPtM5vjMO93SJClvpHGdwsqh/+Jr/fZgRIl1+2ECuivAgVT8wTLoHrjmdsfMw21sKYGINn+ouWZK2HHigI3uCzAnGv7bMUbUQuKI/Sm9gm5nYlwCHCv2MFtSrcZj/YT0slxX8oZ6ep3Ep2MmW/lrsy/Cyq7Fwkq5alHzmMqbQjPNQCfqcfMyUNdvK7Gblhmws2PrSCmJfkZqjDJSaFncBBTSioYMN2IoBr6u/QOD6CgwBHz5S+1Q7d4BGM4R5NSQRKqvJlHCWJZOAFYUWLhVW1CHZ1a1FTe8criD9v5OpeP57wj83Mn4WZe4DXf+ZTD0PSLuRmA8QMX6c6eLgmldzW7EKQr2TRcR05nvv8g1Pzc5Ex/MAZJ/PtmgQ5iYhBVSC9MnQFKzVaeYHa/qWto7Rgr4YVYzus2YQjGb7dixvw
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40480700001)(66899024)(26005)(2616005)(36860700001)(1076003)(47076005)(83380400001)(5660300002)(86362001)(336012)(107886003)(6506007)(82740400003)(478600001)(6486002)(6512007)(41300700001)(36756003)(110136005)(54906003)(2906002)(81166007)(4326008)(8936002)(8676002)(316002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 08:55:49.6011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1724db-dceb-499a-e0ed-08dc0dcc1d7c
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0118

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

This series offers a solution to this problem. The max_mtu advertised on th=
e
network device and the actual max frame size configured on the switch regis=
ters
are made consistent by letting the extra room needed for the ethernet heade=
rs
and the frame checksum (22 bytes including VLAN).

Changes in v2:
 - Just set the max_mtu to a fixed value and calculate the overheads.
 - Define the max packet size as part of the only commit of this series.

Jorge Sanjuan Garcia (1):
  net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--=20
2.34.1

