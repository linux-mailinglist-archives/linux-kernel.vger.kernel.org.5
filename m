Return-Path: <linux-kernel+bounces-33606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA9836C30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D27E284D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9047768;
	Mon, 22 Jan 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="mv8k+1sV";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="mv8k+1sV"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2104.outbound.protection.outlook.com [40.107.8.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B23FE4F;
	Mon, 22 Jan 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937551; cv=fail; b=BfI4YxqvZbTB3a1/yIPEJHIZoFVW+6F1bSr9vsx71GcGDiRPTbm4fwCsh7g+PAx8wRD/fwKnJ8zAZ4MlKFmJC5zyVTR9VtC3TY1edR5ec9L9poijLKQe7yUcHHSWCPw9P0sKULDfX50euKUWjavuk9G/XQevDAl0dJPKp5zRLcw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937551; c=relaxed/simple;
	bh=DTblkNfyn08IC8pC2llc7ImbYrULbiKzpMmfSEi6BY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sgZBghJEnFE9tT4ykus3I3nBQzCh+/bJzNhpgkBqa/En+QgtmsDQhe38ypBLNMHV312tmR0UGkD/qzw8yVizToIpuiB77u9HEKBAYzLCuET43K1JwdsIUdhkHJNA6CWUXwu6cqxei1BAI6SH6kDhgHJIuW7PV2KqM7olNccAdCw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=mv8k+1sV; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=mv8k+1sV; arc=fail smtp.client-ip=40.107.8.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=aS1OAXLAUBiG2EVHpBOkb8Zj7MRrkpNqYokI6PPBgX0Hi3P8HUVHq5AgYxOGCuu1YcqKl4tA4ebTVnLAiDfkoaWbgzbiOo32i/hvypncDjC9OmrqQGIFSthnXQuhs3SGOTGK59/Ll/eoLyweo4cE009lIg5GuqmAjU1TCaA/iujIP8cvBYJATbEsm/eIJghJFoOEC11TB+G824ahlt/6VoV9sehupDJKA1PvRY3/J2hCcjEBiyMI3hhWK69P0ptx5GYwBBo4Aw5OETxIZHTrTSVXDs+0REbjyMNUbOE4SQEdSQdu9D1AyiRdfC9rfxARxql4XTlMVTm3cczRrpdqPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTblkNfyn08IC8pC2llc7ImbYrULbiKzpMmfSEi6BY0=;
 b=l1/D9PtbCoumY/MLluE+bV9nRRoeS9yzvtHqTH++FF1dkRY0DMIsk7ZhrIX10vOmHHxXc3TGy0T+P8u/EB8PXi603X9FZRl928t3ztUA6q0GI0QID75E5EWN8bQhFvC/a7t3pvqbFrbsHkfXFE+ZRIsxOOwMAXzflQ5/1kPpFEqEoMntJs50Mj2CCKHCBntHk1fA0+J8vDTjHxl0nbsqJmOVN9TbREbmp5ryYwvAtNPhePfq6HdflWNC5AwDqdWdZ6MVXo8PZHA5eCLV8UXod7rg+YRJtz276fWUHxQKkDEpBvDVOnfpHmbcHjrhgl8Cc5OxmrwxGUEyp+ZEISojQw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=pass
 (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTblkNfyn08IC8pC2llc7ImbYrULbiKzpMmfSEi6BY0=;
 b=mv8k+1sVBOigwEeo+kJYST3kanXkf51dB29Wbl5rm/aZBI965Bsd/EdEpgMLp60XC2w5dmd0nPwLhl/U1QsZaorqvjMf4hUQtSQdEGOU2F2ZaeYUKZoXl5hlVWMzcyUXHpzeU+az4k0QcSj4nJ2Z5rTiTV6gENEPNyQjK9+iYLclSwGbjCpheH0Y23YyFm99+nozpj22BhN3z3sS43/7P0tAzGxt9bMx4efT6OCrnxkAFa0VB6eNRNQvLeeWL4Ykv/uwdHlQ5xQG67xKhhgZXAbBQ49efncgtA2IloUkf4Qhoysx5nvHsfRVbpiruu7H5rq2aRyPAnUc2RyQdKuJNw==
Received: from AS4P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::12)
 by DB3PR05MB10018.eurprd05.prod.outlook.com (2603:10a6:10:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 15:32:17 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::b9) by AS4P191CA0029.outlook.office365.com
 (2603:10a6:20b:5d9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 15:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 15:32:16 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.105) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 Jan 2024 15:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boiG2xQrAFLEKyIZ2lLsMXK0HbvREuelkaXZBFjYPp2xrpOr9l5cU3gvDvYOFb/hY5SUAcnU0Cbz5cPsGnB84c1/d+Cb4dcn5lEenshgT/zvs35TtA1EbqBMf8UHqi84DvVbjMAzJPkL4/jm+eM2l6LIDu4fZC4HRavRPH8QuvuhkuhsHnxgj2qUdJHhzqm158XMbsjLk+n8HKVtgR5Sn0rRHQwLzWtDjhvq/Vfd1/AbG0yRPEEWDUnMw4gQVVJABPh2iZajHflmuZEu6/7dVLoh0mQfpPXp16+IR0mQy1DuyXJW9ODlIcyf/Tik7rzYVCKFztgpINw5mmi5swnONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTblkNfyn08IC8pC2llc7ImbYrULbiKzpMmfSEi6BY0=;
 b=N0as3gFnSEs66EkxqQI+LdLLPFK7afcWkvY/Y7OIMLBMY2QGyC17ki6osS++eSFVDrhgy3Y6mSjmavU1A3TGKt2Hxj5FJ3J43+OIMyWPYJqLJ/WI1/g1ZvlJS6nuvsRqfQdXmnRIj6gwwAH6A0elZPR2tWOf6eaCXPuEmbDnVRqRgbYe+zwhTVYM51pIs2ELpczEizBt0AozmHmaAYg4yKLGYfeFHQwRIS1XWusNm7G0sOBSIf6gb1a3yfFXrgGt82HCUZqAzT04VApgXgZIcd4t1ECDfmdO/b+1YUYXBpUYmIBW/fMzeaPwfuG/fNQ0FzqEDZSp47CtsRbST1zsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTblkNfyn08IC8pC2llc7ImbYrULbiKzpMmfSEi6BY0=;
 b=mv8k+1sVBOigwEeo+kJYST3kanXkf51dB29Wbl5rm/aZBI965Bsd/EdEpgMLp60XC2w5dmd0nPwLhl/U1QsZaorqvjMf4hUQtSQdEGOU2F2ZaeYUKZoXl5hlVWMzcyUXHpzeU+az4k0QcSj4nJ2Z5rTiTV6gENEPNyQjK9+iYLclSwGbjCpheH0Y23YyFm99+nozpj22BhN3z3sS43/7P0tAzGxt9bMx4efT6OCrnxkAFa0VB6eNRNQvLeeWL4Ykv/uwdHlQ5xQG67xKhhgZXAbBQ49efncgtA2IloUkf4Qhoysx5nvHsfRVbpiruu7H5rq2aRyPAnUc2RyQdKuJNw==
Received: from AS8PR05MB8087.eurprd05.prod.outlook.com (2603:10a6:20b:31d::24)
 by AS2PR05MB9909.eurprd05.prod.outlook.com (2603:10a6:20b:5e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Mon, 22 Jan
 2024 15:32:13 +0000
Received: from AS8PR05MB8087.eurprd05.prod.outlook.com
 ([fe80::9efe:506e:46f6:77cd]) by AS8PR05MB8087.eurprd05.prod.outlook.com
 ([fe80::9efe:506e:46f6:77cd%5]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:32:13 +0000
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
Thread-Index: AQHaSeHaVTPMeAMJ+UKLLUSZksN9erDl+dqQ
Date: Mon, 22 Jan 2024 15:32:12 +0000
Message-ID: <AS8PR05MB8087C1D7D0158D54E15C6E9683752@AS8PR05MB8087.eurprd05.prod.outlook.com>
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
	AS8PR05MB8087:EE_|AS2PR05MB9909:EE_|AM2PEPF0001C713:EE_|DB3PR05MB10018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9ff29f-c001-4b60-e158-08dc1b5f508b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 oBdQtngJheYbL4bF1q4mGlY/UQNXCUaA3/Ic+ys6KdmZErOmrugQvhzQQdLlZj6+Bf4Vq8F3gAvpw2TDYvZPKN0PIlUumUoanub21bYw/Ef9KQV7/KpmHqbPUW2ybHr4PlNMkOZmMI0fHeyTCyAwohva3r/RmRSCiX7wzRVsH17d/xRn1UYGPVAam7m033LkPbsr0CWvFnLSBEoC36vTGYQsuJ33p/hTk8iidPxG32HLuOYUZD6omVTP69UXDcy4A9762P9lNXJhHCnSq/MocOqxgyANd9myEuFkhiTOcjL0yP2n4XHTAAajxDdhyUV+K+YH51ElEKJEbx5bzS/t8SV2kHVMCXhky4J4MEUVqQodHCHNi2wpsq+M1V1eiaWoXdtVZRbibhU/Q+E6OPpqScG9S7NwEU/WMKiXbck31QDZDpcS9LiroKbXkS4Nf+DUQsPbL9RP2Kq1yimrCCLZLyJABGCico+/+JYBRGp+xD2Cjnb60ne96DRlSZjVQaVqSTRe8TUV6CAbaPtlVVYIfTo2TpVG5OLWprQg744pDZaDcEIsKnzmCWlK9Tz9LUS99EGI7HMWduV5C0F4txFhJpOXHUuT/sOKkb/Qt5aTzI96+tRcZH/KOWqaggLULZCIgbGjaGhIKzjsCwSGv5+gNg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB8087.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(54906003)(83380400001)(38070700009)(6506007)(66556008)(9686003)(66446008)(86362001)(64756008)(66946007)(41300700001)(8936002)(316002)(53546011)(71200400001)(7696005)(8676002)(478600001)(2906002)(921011)(76116006)(52536014)(7416002)(4326008)(66476007)(26005)(110136005)(5660300002)(33656002)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB9909
X-CodeTwo-MessageID: f81d11fb-0d77-4e02-a40a-25c6ead2f4e0.20240122153214@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f7e0eea2-7856-4d68-9bf5-08dc1b5f4e55
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9HrNdidyFanvAf/7qo91NwZsm0FkB2/9dksYrayHyTiVooQmu8p9LBwgwmbugN7PDjCsY7UhLwsZgtzkBGeMt9/urb5sZEa9jfrCcrJyfDguFVvKZeV+hZ3T73ovgrH8XPA0E1aDFGHcNbUyxLGNGiUcXvkVGWYLo/lGWtEf7kJD2fJsyRc/5z3QJ27YJLl8AcC6fBGOzIzUGFJTzWMzWYA6MYgONUZN1xyr+/KojM+/kqosBgtQUa5OW3x/tX6gXPrLe3nAQimIfGnWGRp2mO3t+Byj5rNpt8G310Ez/GAUiAQyyIv9P9xlioSFQ1Fuu+FFQlybVtu5A/QKq0NmIxcOb4ZFwkwA+HYuHN7cTCOBWf9g7Ozviuc5v7teaAS4bf0PvO1pH9i3DcF9H2fEAdKq2xmkYWYN2nI3iuVWDVIb2spepeTB4ewJHhRqivR8WflCoHmKpQlnNuQ2Z/D92DioNSpue0HYs4LXNxrsJvtPToGHsfq01NRyMaJdMP4zZj1BUacMDOBVXRN50Du3XKGi2e55s+8HGtrBW9i08tCO1MEOj7WBJoHODbXx2KX8eqWXOIq1eHOzf0mhKJdnJ0BQMu+161E5JFI/Zbn/A6SdkHmHbPoZksDCcXRUnOYhozTBdE797xBkhhHla1BtVEMfqjgMV6Y90IXApD9rQK1Xswq8IrDL/kTf2gFYFlhkpJq+NEMa1FefsnlmGmEdyYWrGOoW/Sg+fkOLJPxAxkc=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39840400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(41300700001)(336012)(921011)(55016003)(40480700001)(26005)(47076005)(36860700001)(7696005)(478600001)(53546011)(9686003)(6506007)(83380400001)(7636003)(7596003)(356005)(70206006)(110136005)(70586007)(54906003)(316002)(2906002)(33656002)(8936002)(86362001)(5660300002)(7416002)(52536014)(4326008)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:32:16.6017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9ff29f-c001-4b60-e158-08dc1b5f508b
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB10018

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pa2FudGEgR3VudHVwYWxs
aSA8bWFuaWthbnRhLmd1bnR1cGFsbGlAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE4IEph
bnVhcnkgMjAyNCAwODo0MA0KPiBTdWJqZWN0OiBbUEFUQ0ggVjkgMi8zXSB0dHk6IHNlcmlhbDog
dWFydHBzOiBSZWxvY2F0ZSBjZG5zX3VhcnRfdHhfZW1wdHkgdG8NCj4gZmFjaWxpdGF0ZSByczQ4
NQ0KPiANCj4gUmVsb2NhdGUgY2Ruc191YXJ0X3R4X2VtcHR5IGZ1bmN0aW9uIHRvIGF2b2lkIHBy
b3RvdHlwZSBzdGF0ZW1lbnQgaW4NCj4gcnM0ODUgY2hhbmdlcy4NCj4gVXBkYXRlIHJldHVybiBj
aGVjayB3aXRoIHVhcnRfdHhfc3RvcHBlZCgpIGluIGNkbnNfdWFydF9oYW5kbGVfdHgoKS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBHdW50dXBhbGxpIDxtYW5pa2FudGEuZ3VudHVw
YWxsaUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgVjk6DQo+IFVwZGF0ZSByZXR1cm4g
Y2hlY2sgd2l0aCB1YXJ0X3R4X3N0b3BwZWQoKSBpbiBjZG5zX3VhcnRfaGFuZGxlX3R4KCkuDQo+
IFVwZGF0ZSBkZXNjcmlwdGlvbiBvZiBjZG5zX3VhcnRfaGFuZGxlX3R4KCkgYW5kIGFkZCBjbGVh
ciBUWCBFbXB0eSBpbnRlcnJ1cHQNCj4gY29tbWVudCBjZG5zX3VhcnRfc3RhcnRfdHgoKS4NCj4g
LS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jIHwgMzUgKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L3hpbGlueF91YXJ0cHMuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMNCj4g
aW5kZXggOTIwNzYyZDdiNGE0Li43ODdjN2NiYzY2MDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3hp
bGlueF91YXJ0cHMuYw0KPiBAQCAtMzE2LDcgKzMzMSw3IEBAIHN0YXRpYyB2b2lkIGNkbnNfdWFy
dF9oYW5kbGVfdHgodm9pZCAqZGV2X2lkKQ0KPiAgCXN0cnVjdCBjaXJjX2J1ZiAqeG1pdCA9ICZw
b3J0LT5zdGF0ZS0+eG1pdDsNCj4gIAl1bnNpZ25lZCBpbnQgbnVtYnl0ZXM7DQo+IA0KPiAtCWlm
ICh1YXJ0X2NpcmNfZW1wdHkoeG1pdCkpIHsNCj4gKwlpZiAodWFydF9jaXJjX2VtcHR5KHhtaXQp
IHx8IHVhcnRfdHhfc3RvcHBlZChwb3J0KSkgew0KDQpDYW4geW91IHBsZWFzZSBhbHNvIGluc2Vy
dCBhIGNvbW1lbnQgaGVyZT8NCisJCS8qIERpc2FibGUgdGhlIFRYIEVtcHR5IGludGVycnVwdCAq
Lw0KDQo+ICAJCXdyaXRlbChDRE5TX1VBUlRfSVhSX1RYRU1QVFksIHBvcnQtPm1lbWJhc2UgKyBD
RE5TX1VBUlRfSURSKTsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCg0KS2luZCByZWdhcmRzLA0KTWFh
cnRlbiBCcm9jaw0KDQo=

