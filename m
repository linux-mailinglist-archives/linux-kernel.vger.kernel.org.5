Return-Path: <linux-kernel+bounces-151285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D58AAC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8054C1C21D23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8FE7C08E;
	Fri, 19 Apr 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="SEO3c1ya";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="SEO3c1ya"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2090.outbound.protection.outlook.com [40.107.8.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C842AAF;
	Fri, 19 Apr 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.90
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521129; cv=fail; b=LRXTcWbPujhpBMWepWGHk/a80vDB2MfTXUSq4OG1yXZCB76DSTUdHJ75mlLOeXmcSK3Ld9vM/BWfnQ3yOMYgju71YThTDgxtMHNM4zqn4Tqtyg6c95d75BB6VOoRF8uC+gztU7diDbz4Ek9yT5OrwaEp/05qKT6W+c4NA4ukoCQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521129; c=relaxed/simple;
	bh=p+5HODFulkHIiIr6ob4R5TvUJGZrRY2ZsGLD8x0DsN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScUj5hVbGknVZ+z4hdzQK47L5a2UviXEd94vHRfG3PqE6I/tNO/o8CMKxSEiyOXOYbQ1eBcJ2F4fl2I3h1pcjbI0o2Npn7N/2IMGzxS51cGi2PAv0kT2Zo0xLz45UtUGY0v2oLygiwfvBY0WXi7Cf9E4ZuKzBvvJvcywmu0kM2o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=SEO3c1ya; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=SEO3c1ya; arc=fail smtp.client-ip=40.107.8.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NYyNbY9ZYHCyyYzV7uqMVxuGmlGGNP8jSfjaXaQAsgG0biuGZJjxN/hODCEDsmm/JtRunVYfZyzPzsqaS2sImPbEOeXmNUyhl6MEuYzCgrFVH1cj60GMKviU9GqNEF+OU5OyvtqbaUCWLH2XDqvzgCvC+k6u3fPN2EV5voArexbo/Zx+2gliLOu8KOSUFfIPwD2rjfJrD2XSgltaW26xDbrTsyeu6HBW6wrJCa5NlUNQxRdtaRPsgST1MybUCvMo61hKajDjuXoEtzetcRuiwoWjA08yUSIsYHUlFXBiQkVJ3lw2OLEdaCiLN4gvDiAsqbUNcfcViU1gi/a7Kkb+qg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+5HODFulkHIiIr6ob4R5TvUJGZrRY2ZsGLD8x0DsN0=;
 b=LvBuS/EQgRe+TfC2q64RSX6JlM7w82iMiaFXa+ria1knKpYIMlKYiKlZsE1Ir66Cy6UnPkz8lYp9jBwYw8TbXint3r7n5PYIbig4w8tvk3ph68P4qPcB1SlncoeggDGDkire894ZX4NliIlP1pDjvBw16xOWGoX1Fnf6RgvwVyJaq6JMgeYzKIfZ89gLNBHbZlzrBQP8zQStxRsX+vMwzSbAKhvByZa+itdeeIOvVfHxyL0wIJLIA7sFFksc3nsMd71MTDPQPn/ihoXs+j2KEjs5XnCHO126KhUAE3BsNWRTlDbQWXHLvE31mczZrZCYLrBrU6aWLxw/+mPWoSerIA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=ya.ru smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=pass
 (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+5HODFulkHIiIr6ob4R5TvUJGZrRY2ZsGLD8x0DsN0=;
 b=SEO3c1yaWVA4qQMEzKJxouukdfsqy6XGOyv4rbi9JDQ+QwnGGPEQ+0Z3bDAIPRxzDSXShLyeZ3XQyAirMaRHRL4LL+Jy8/pFOt1yVHjoWM10JJZx37Yr65a56QWpocrasnT/i+ukk5gZe8RWSFuiRAMoBkoiwFPe3XoI6bOOLB1yQDjPJhBjKaYdYannpGtuMwDhT/TgNKoB1to/Od9hFoHDJBNXMdfL8c4CpS7rrK9ZYA8B9hV65h9fotGDZRMqQzq7NFKR/QrnA48iBN1UKpw70UYWh75SucWiEG+l+/bj1hMKA49L5TkvGTsW8wuuuUOtJMGwrfpu3sA+JCoTdA==
Received: from DBBPR09CA0022.eurprd09.prod.outlook.com (2603:10a6:10:c0::34)
 by AM8PR05MB7521.eurprd05.prod.outlook.com (2603:10a6:20b:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 10:05:22 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::a1) by DBBPR09CA0022.outlook.office365.com
 (2603:10a6:10:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Fri, 19 Apr 2024 10:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 10:05:21 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 19 Apr 2024 10:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXAthprXQYggVdr5oJKemnXqLh8XUBIWcgMfZwTk7Eh/ftwwzMXzmIwbGbTjcUQhkjWSv1wTfjUvEgO2odI+3LNMa8nvy0lTXpG38PrIiWfJBiXL0iWiilCCDYFyyr9BnMYFjZ5wFCvyixCVSkj/+Hs8tEJAXUo+IHCCvsL+3U+J+PPmSYSsncsWvPrraWlH1bUlLXkTK2O9Icdu0FEqaMDdVHOff3w+aNdA11EIQBcQCp5dtU543Fdwj7JdpGnpRXSEK4EUm4uNMFpW1HI/pwrCaBR39vcTMDWgreX2ibDYWRau8SB41L8566Uhgo/E2u/xw1SLgg+LuaJyq7mJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+5HODFulkHIiIr6ob4R5TvUJGZrRY2ZsGLD8x0DsN0=;
 b=a+dUIxfsZeHDhc5+T6X8BDc2SlZRGW41Dj6Gwn+XvFOVqaja9DvQMEg3ZcwVlXUWKh0ThBE49WbxdjiYy7DOlCmrKDrOUaIJu43ugOk4xEi5MS5Ri/WCVJ9Yh5Lt8wEb8VxyWecai7vg5iFHp4e31wSwB6AKz5CthCpDeWbV9JOQlw8cngHLTOGAz83m8iQUfQo13k5uKGs/Tn6SNxRiVAbSTAmEGP9LLwLxlFdpp4r+fFdYbtG19TIaSq60pO1iVlGMx47EVuiQ3U+/aO0DeP5RQcLfbSYvvabb5VDsF2tIkUUbzksDku3gGVeOhfkTTKWzSj2R6Mbel8/scvGvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+5HODFulkHIiIr6ob4R5TvUJGZrRY2ZsGLD8x0DsN0=;
 b=SEO3c1yaWVA4qQMEzKJxouukdfsqy6XGOyv4rbi9JDQ+QwnGGPEQ+0Z3bDAIPRxzDSXShLyeZ3XQyAirMaRHRL4LL+Jy8/pFOt1yVHjoWM10JJZx37Yr65a56QWpocrasnT/i+ukk5gZe8RWSFuiRAMoBkoiwFPe3XoI6bOOLB1yQDjPJhBjKaYdYannpGtuMwDhT/TgNKoB1to/Od9hFoHDJBNXMdfL8c4CpS7rrK9ZYA8B9hV65h9fotGDZRMqQzq7NFKR/QrnA48iBN1UKpw70UYWh75SucWiEG+l+/bj1hMKA49L5TkvGTsW8wuuuUOtJMGwrfpu3sA+JCoTdA==
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by DB9PR05MB9549.eurprd05.prod.outlook.com (2603:10a6:10:301::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 10:05:15 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::b777:79ea:2f7f:8765]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::b777:79ea:2f7f:8765%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 10:05:15 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Konstantin Pugin <rilian.la.te@ya.ru>
CC: Konstantin Pugin <ria.freelander@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Lech Perczak
	<lech.perczak@camlingroup.com>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] add support for EXAR XR20M1172 UART
Thread-Topic: [PATCH v3 0/3] add support for EXAR XR20M1172 UART
Thread-Index: AQHakbLQAxqe1zqBxk+zfKNZu562+rFvW8gA
Date: Fri, 19 Apr 2024 10:05:15 +0000
Message-ID: <AS8PR05MB9810C02BC1C3F3E301B8A590830D2@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
In-Reply-To: <20240418170610.759838-1-rilian.la.te@ya.ru>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|DB9PR05MB9549:EE_|DU6PEPF0000B61E:EE_|AM8PR05MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: db357ad1-a04e-4ded-5af7-08dc6058392a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 JFRCZSXBYyJ0Il6tRyCXDAX7ll/HT7i+e7QtJ2zk3qhGi6lohTuIJxRKZIMQ92DUtw+apR1dsWQLN+9kiksCMnKdot3cuQCxkpQ6jay2jmN17TbdHdS4Z/jLkv8u6sJ2wCBzV2VUnBT7dqJBkk0T+Mi020FGh/RPsoNV63PfqDpcWreLSQZPI1W2mGOO9ZOlt//LRDfiIKioJqPHwFii9eFwmJ2dVIOXnPrLukuL2nZisSAsygYXw+KCTM8w2Q+SJIzG84AW3V9aHQZi2NzYXLiWOTOz2KoMb4iOGVBfdBkLSLHPDLMGX1OAmzpd9iGOPxkkM/pBpZGaaIMgSBBAugWW/h8XUFgcmbB/VOr3iSyh30nn0JoBE27813fVhAlGEh4UkUkw2Jt2dSLJLIQL0SDocQOao/Lx0EocWz2nXSg+ONP7P+kX9hu0Q58CrE+5lCxM5v7IiiTbNwmKTNoKSQRNNIta9x7S7vi+CA1j8REQQKJ7FXe4WREK+RBgh1TLOd4yjCg7LXjhpmnalE5QwcTy4FOBQVLiygwUKc7BnOxUrBFyMsTJgX8XJeSLH29VdT3jv1I7b7aoTTglvHNReUbP4Ah5asNwh4Eta4BHLARLDA8Kyo+/jYxLpwJe4pjGVkAW3aLQRpcPHrU584lxY0eCTjxWMDHWJH9kcXVh2CDm8a7RkDN/cxypRUV2bPR0uUGXM0AV6MMXLKsZQ5I2Uv6pyOhcZAqfi+Bs7wH7RVI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9549
X-CodeTwo-MessageID: 47c95888-8eef-4092-a5c0-96505046aaf8.20240419100519@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2aa4f35b-2636-4773-013d-08dc6058359c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4t11eTIi0yLPEU9q5X98NLXKnN4+y1gjyCtWfUHgBUU/GNAbBZho2IN4/gc/gPPvs0EyOlEGTcJEO7Jk5txTnm9irqX2YrLhrJVOMrAnpcGimw1bpMcE+suxp9Kfh3lhRAWleebXixXDJIIAShv+f734pZTPJPuvy8Oq1omiqR7XlnGEhl8hTPRtsVVLJJyg2EwIkWDmbUysDGkENhOYGeGuJ/YS2egDVDoN1XMQiLe8TEna8j0ZP+cT+8hJblBfTQM5zi7H/SVFw9Wz405nqWNmq0WQyZWu4cZJUK7oJciJSZQzHkIW2c6tKtkzaT7Gaw3ghRTHFOYdsCw81JWwQemr7v7UEbUteHWaoZDxFIS7ihg7i8mwojkicSkE4CcygXZ8oSe3Rby1RjdPYmDtJAqVi3W22QLZWlEiPtAAiy0kr15LAWsWL/l/mQtg7bmNvryVnuDKQKq3k22Fuim9i2gLoV0sokd6QavV3FvzGxgaEeoXzkf8+acIacWea/ToUpF4cVDjkVFuoL8wcR9yEsOl9HQNmkCGyv1QDbM+PYr5YIno1to5r1JuNSZkpW9pCiip/Zmb8tAAqYXP8WMLZUA0FqAkr8R4+maP7oveCg3vzYSL9nyVh6pWsg8ovUWYjBL5YJ2j3JrV9tKHpdJ/JxNqVw+oU0f8k6ulm/tLtrIk/djTI3CkOcWMLPXW4oGCJ3YWCLa6LNYokDbB5pJntvoUcjary/plxAw2iIUO0ZtrMRnlzyJHzNFBu8HcLSnR
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:05:21.2077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db357ad1-a04e-4ded-5af7-08dc6058392a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7521

PiBGcm9tOiBLb25zdGFudGluIFB1Z2luIDxyaWxpYW4ubGEudGVAeWEucnU+DQo+IFN1YmplY3Q6
IFtQQVRDSCB2MyAwLzNdIGFkZCBzdXBwb3J0IGZvciBFWEFSIFhSMjBNMTE3MiBVQVJUDQoNCldo
YXQgaXMgdGhlIHBvbGljeSBpbiB0aGUga2VybmVsIHNvdXJjZXMgZm9yIHRoZSBuYW1lIG9mIHRo
ZSBtYW51ZmFjdHVyZXI/DQpUaGlzIGRyaXZlciBuZXZlciBoYWQgc3BlY2lhbCBzdXBwb3J0IGZv
ciB0aGUgRVhBUiBjaGlwcyB3aGVuIGl0IHdhcyBzdGlsbCBFWEFSLg0KU2luY2UgMjAxNyBpdCBp
cyBub3cgcGFydCBvZiBNYXhMaW5lYXIuIFNob3VsZCB0aGUgZHJpdmVyIHVzZSB0aGUgbmFtZSBv
ZiB0aGUNCm9yaWdpbmFsIG1hbnVmYWN0dXJlciBvciB0aGUgbmFtZSBvZiB0aGUgbWFudWZhY3R1
cmVyIGF0IHRoZSB0aW1lIG9mIGFkZGl0aW9uDQp0byB0aGUgc291cmNlcz8NCg0KS2luZCByZWdh
cmRzLA0KTWFhcnRlbg0KDQo=

