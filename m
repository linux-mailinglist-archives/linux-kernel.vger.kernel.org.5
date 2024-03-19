Return-Path: <linux-kernel+bounces-107293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32187FA99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE19A1C21A72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AA7CF0F;
	Tue, 19 Mar 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MuWY+EbQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MuWY+EbQ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893635380F;
	Tue, 19 Mar 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840036; cv=fail; b=DmgcYhGi8YFM+gTe9wkiWSJMNB7U9EZnlehhiv5IqzWe03kM0ugBzvTQ/Y+C6jm7G8UEawH43riZ1IqxVwgK97oJMWuPagi7ef9NQ1zRUeITSZq2b9LGfqNGKR6EnCvDG92HkzI72WSoSw53IfV09shAlN5OzwUijaYXBTbUWh8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840036; c=relaxed/simple;
	bh=WgVk0LJ3VubOobr0ST+QqNT+kWxvLyR8PdrjTRhIqdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1s0+0IuW2AnYjtdSBvqExxw51mLemCjBLenRIFFSsfF8sKmU1KHWGjjGn8EXZ9iYSuFUlw57hWyftcrulSlftMESs350/p5pMg4M6D1e35CYtwh7QsWB0JpjAIRYN0rQj8K2UwdlmfEJAsTQT7HZ5PWl2NYd3dDuJccLMeeTR0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=MuWY+EbQ; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=MuWY+EbQ; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZFXTmGVwfy+I8IUIkmE3fD1ObcbVkTWHw+4S5+8TpFyGD+hsFdTSISBYtA/c03i69MyBSXXIDfXbejiFB55ErXqOu9p75tIhvkkkt5Ib4L7s61KrE7i9AWK+T+Eo+GmSeB5KFugPyTExpT5Bv6siG/Jiw97ipEigM6Od1AYCnmy7kR2HIeqAmHVSNYIjNjZ0oURZvilTUCQ5cKtYxyqP1uSaIyp1TtvspF9gahx8dpL22Cb0k/bfjHGmRw48so+2d8u2hyOfuj7Qm61qnZmMEhJ313Tz6TBreFGISDhGOZN7SiotumWbCXQF0f2gGTY9wsDW5ga5IOByEjpJWCz43g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFSW4Glye8DH0T5xeT/Amf+TiDLmXk9fyYSnIcF5PJk=;
 b=bp0G4HYMmdJVOK/APEMfREnjUCJRSlECB7CQBe5yAd537epwcdnDh6zNJrBKIU/rq3mSQS5rKUMZ1sMsjmF56/Z2DCXCr08T7znLRjC2+carsoVSqu9SYdW9QCNeTUvERKdbmwcXcfCHrvLHhhM+pVaejuF3SrU31dJGlVx3eQx/ZY6XlmimEFjAxRlLcvnq4H0loA6b49JZ8vAxJSEQgIc82TFl3dvIQkoa0k/XMlx7OMmj2nbsO0FV4I6NJQgEEGIxRAbjjwDwb8mvd8Jg31/qctfno8tH9OYlOsrcUjt0M2HBuOoWmcr01NjxqxVGnQvCD3pVOx9AHcnB9CJ/mg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFSW4Glye8DH0T5xeT/Amf+TiDLmXk9fyYSnIcF5PJk=;
 b=MuWY+EbQecTmAEERxjfFfo1AOqpYMRBJNU9nGfipdl+JEculitXfnB67UapGsunxEAEM6AcKnUbLttNT33chsALAywKftHqA4Y8BNMWBxQexiDidrGs4j16gc0iZjhAU7XCJrNxM5/7MGX1BBiGHs3gYy2d9HLImAovEPkZ0OJc=
Received: from AS4P195CA0054.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::14)
 by GVXPR08MB10666.eurprd08.prod.outlook.com (2603:10a6:150:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 09:20:17 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::3e) by AS4P195CA0054.outlook.office365.com
 (2603:10a6:20b:65a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Tue, 19 Mar 2024 09:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:20:15 +0000
Received: ("Tessian outbound 5ad6c4395be7:v300"); Tue, 19 Mar 2024 09:20:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed3abe0e5051fc6d
X-CR-MTA-TID: 64aa7808
Received: from f63fc514861e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D50A079C-5BFA-440D-BBBE-2F99552E5A7C.1;
	Tue, 19 Mar 2024 09:20:05 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f63fc514861e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 19 Mar 2024 09:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVjmVTJDOeq8yrEjbi+ZfD2EGRulku2P+1XL5NSv44t0Qb/Z7bwdgvA002ShibW7vSWdN/uCqsFHXuBufmA/s2zVDY8r00h4QWXN7JtZaj1iRw1rjxcjM83eErlcpz6TZ84JgNGYchf/18RztyIgok2na0IutwfnWh7FrirNepDZQVBGWvumGhazEzXctLTI21vArZ6pw6051hhieGJVCGvYeD+gSQdxXKciGRoK2KVmNgfk2U4H8kE1wITIZ9hcewinCjoP90HD2kiz2wjZN4mCegwuCkER/G9X57wITPXNTnNCnlTgVYDptdfi+NTqbB2l3T/QEJO+MMCuUANdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFSW4Glye8DH0T5xeT/Amf+TiDLmXk9fyYSnIcF5PJk=;
 b=PKMWFZN/F2Bla9ncyYuEA6YDNlxV1oaiGLGl7YI/i1lMJXbiPY9Vs3OwHmOLGYJJ0CYCwMjCxuZgfxcrGGftbTThh7mWSlfq0MMamrrygcd+WUSEXwtUERehUyDClG/B8KXoV56Sa8tfaQcvVRvAtLjzWOK6AaF8QymIYO1+j8PUEG6m+eEvdKQGldpMifYGGAfWVjmwN/HXtcH3FRGY5mjcEPDaGrTq95GqBuwZRlj0kKTFY4j1seF2AXeBA5cKJPT1a9CX1xQWN6MMxXxDcYCaEjuWbo2Zo3WW49QOzjWz6+H4TyYp8+5ykKjjHxd0VfrKgJClDEjTwLc9HU2K6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFSW4Glye8DH0T5xeT/Amf+TiDLmXk9fyYSnIcF5PJk=;
 b=MuWY+EbQecTmAEERxjfFfo1AOqpYMRBJNU9nGfipdl+JEculitXfnB67UapGsunxEAEM6AcKnUbLttNT33chsALAywKftHqA4Y8BNMWBxQexiDidrGs4j16gc0iZjhAU7XCJrNxM5/7MGX1BBiGHs3gYy2d9HLImAovEPkZ0OJc=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by DB4PR08MB8197.eurprd08.prod.outlook.com (2603:10a6:10:383::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 09:20:01 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:20:00 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri
 Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland
	<Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>, Aaron Lu
	<aaron.lu@intel.com>
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Topic: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Index: AQHacWpg4RzUFZ0isEaP3JURG6Kl97E+2mIU
Date: Tue, 19 Mar 2024 09:20:00 +0000
Message-ID:
 <AM0PR08MB42895432478A020E2C5B6C5FFB2C2@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-traffictypediagnostic:
	AM0PR08MB4289:EE_|DB4PR08MB8197:EE_|AM3PEPF00009B9D:EE_|GVXPR08MB10666:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 W5oDMdZhXdFoFlYxC0bvbV3FYwPSHCLFSWFvHUzJPFMa8ALHLDbNwFtn+LubMrt2DWA+8UuHrl0tp3Rgkvf3AnPYNDL3FqHKlP8+9WZ9HZVwzM6Fr/Yxkdjk02iqO+7vZXciuVVmfsNDhQxBbVOHp5+TaREajLduC6SZn0eC7sQFrNoT8wPL7+O3mE1cjwuY71Tk3mmKRRmwsGGTNxiZ19oUrDbLOZd9mQhSKdzS0h2FhhWSaQYgSK3yuooofcLZJoOq+VMIHQVrrNoK24Y+Nt7hypPh8gkeR38KamM3ERDnoPbI+EXcJWz9o9Pihpac7/tg1oCITubqsbOnhL3UoTM250c/Wbg13OFQ2dvj1oIB3TP7QErF1ZYas1uuDzriQCj1Q11niCsLQ9KKU1V+EHJtaVGFe/j0UTqxsXZkVQ2Eus7OjkNC6rXxaBt7vFfOCW7LKe0tU0B4uGgaxLLLVOOoLRT3GIdA3r+73D8DTL+3V8I7zzqHAer2i1orSY7o5j/xMvXd5WJAYGfzsSJsJ5AxTMn8bkpanSxmwcTQrJZhkiQlObezQbrANaVlxJus3fv5McQHLly4EJEUHLJVqttNctgPYoKIilv7n1Gk980=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8197
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0c5efa-e834-48ab-3706-08dc47f5c9b2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qiWFzlPJAiCMtYhz1lYMej2TpB3mHrcYQeXEVNSduWaj4QMAhcpOJtdycoLpMoEqe2omoCvhxRvB56/tTH/vcQeb/mEekSN5552rMj0Y/mxEgRpKe/1R3ZuEuBDDCtdn4sN3BeaPFacxVcd7e4R7dEiRwTMStkpcSBsLfV9qwhuIA7sh8ql6HeGpEFWBZMjXN7jqZO2pUHQejTo1J42iz2sF3KP7goTjsEVa9L0IeAzBAxr4GjE0CQL5z/ObdhTIYKWmrL8B2/so8OOfFBD9/ARUPSBjVvPOErTUebZ7U80f5Dq58NhIBnxpNpmT64AvhB8eHaEpztGu9A0abT5MXS/QVmEuswAQwk/7wCDPQsEuk/iYt10RKHDKbpvMQHmvN+9SAnFCXZBq/vi/UwZu8vt0UeilfE2npTaCkrfK0y4oyQAoubKDkjF6O/WNkWYWxW8hvUMVPltt0spzSAlfEXx7kJqqPLRJjA/HCkxuhgaGeNtpEHD6H8zFPu2DBjiEZz9SomsQg9+WTGzIp1paJvpTNN1xntKxWvwx50llNyLA69rJ3Qf4Bh5222QVFwLw1wM5DR876ENlZUKtEh63uUlxkGAY1kbOnOwlS4rLx+npxBArISCP0vuIvsY648lrXeHWmnuKUjMCGIF4u/ArMKghehbUXEw9OE2a1ooaAJXW7G4hZgV3T+LZbg50TDnaMGKqolw/K2IEmZXx+D68sA==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:20:15.5446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c5efa-e834-48ab-3706-08dc47f5c9b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10666

Gentle ping.

________________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: 08 March 2024 15:07
To: Ingo Molnar; Peter Zijlstra
Cc: linux-kernel@vger.kernel.org; Mathieu Desnoyers; Yeo Reum Yun; stable@v=
ger.kernel.org; Steven Rostedt; Vincent Guittot; Juri Lelli; Dietmar Eggema=
nn; Ben Segall; Mel Gorman; Daniel Bristot de Oliveira; Valentin Schneider;=
 Catalin Marinas; Mark Rutland; Will Deacon; Aaron Lu
Subject: [PATCH] sched: Add missing memory barrier in switch_mm_cid

Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by =
mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
unset the actively used cid when it fails to observe active task after it
sets lazy_put.

There *is* a memory barrier between storing to rq->curr and _return to
userspace_ (as required by membarrier), but the rseq mm_cid has stricter
requirements: the barrier needs to be issued between store to rq->curr
and switch_mm_cid(), which happens earlier than:

- spin_unlock(),
- switch_to().

So it's fine when the architecture switch_mm happens to have that barrier
already, but less so when the architecture only provides the full barrier
in switch_to() or spin_unlock().

It is a bug in the rseq switch_mm_cid() implementation. All architectures
that don't have memory barriers in switch_mm(), but rather have the full
barrier either in finish_lock_switch() or switch_to() have them too late
for the needs of switch_mm_cid().

Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
generic barrier.h header, and use it in switch_mm_cid() for scheduler
transitions where switch_mm() is expected to provide a memory barrier.

Architectures can override smp_mb__after_switch_mm() if their
switch_mm() implementation provides an implicit memory barrier.
Override it with a no-op on x86 which implicitly provide this memory
barrier by writing to CR3.

Link: https://lore.kernel.org/lkml/20240305145335.2696125-1-yeoreum.yun@arm=
com/
Reported-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_ci=
d")
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: levi.yun <yeoreum.yun@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.=
h
index 35389b2af88e..0d5e54201eb2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,9 @@ do {                                                     =
             \
 #define __smp_mb__before_atomic()      do { } while (0)
 #define __smp_mb__after_atomic()       do { } while (0)

+/* Writing to CR3 provides a full memory barrier in switch_mm(). */
+#define smp_mb__after_switch_mm()      do { } while (0)
+
 #include <asm-generic/barrier.h>

 /*
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 961f4d88f9ef..5a6c94d7a598 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -296,5 +296,13 @@ do {                                                  =
                     \
 #define io_stop_wc() do { } while (0)
 #endif

+/*
+ * Architectures that guarantee an implicit smp_mb() in switch_mm()
+ * can override smp_mb__after_switch_mm.
+ */
+#ifndef smp_mb__after_switch_mm
+#define smp_mb__after_switch_mm()      smp_mb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..044d842c696c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -79,6 +79,8 @@
 # include <asm/paravirt_api_clock.h>
 #endif

+#include <asm/barrier.h>
+
 #include "cpupri.h"
 #include "cpudeadline.h"

@@ -3481,13 +3483,19 @@ static inline void switch_mm_cid(struct rq *rq,
                 * between rq->curr store and load of {prev,next}->mm->pcpu=
_cid[cpu].
                 * Provide it here.
                 */
-               if (!prev->mm)                          // from kernel
+               if (!prev->mm) {                        // from kernel
                        smp_mb();
-               /*
-                * user -> user transition guarantees a memory barrier thro=
ugh
-                * switch_mm() when current->mm changes. If current->mm is
-                * unchanged, no barrier is needed.
-                */
+               } else {                                // from user
+                       /*
+                        * user -> user transition relies on an implicit
+                        * memory barrier in switch_mm() when
+                        * current->mm changes. If the architecture
+                        * switch_mm() does not have an implicit memory
+                        * barrier, it is emitted here.  If current->mm
+                        * is unchanged, no barrier is needed.
+                        */
+                       smp_mb__after_switch_mm();
+               }
        }
        if (prev->mm_cid_active) {
                mm_cid_snapshot_time(rq, prev->mm);
--
2.39.2

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

