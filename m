Return-Path: <linux-kernel+bounces-152200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8A8ABAA3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A62281769
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068A29425;
	Sat, 20 Apr 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qupnZd6Q"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ACB171A2;
	Sat, 20 Apr 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604264; cv=fail; b=N6PMrgdVQ4d/8cdJF1CHjNsZ0yeTIJ61Pi25m6qOjzqQVzha7Wb+CkONpg34eEAmxBZpTRVA3D6Lns74VIrGuqNeUFdyrgpe8SPIszqHp+NJh+Ed37cvnI367lEGdDA1ugk9+wFA560Tztiy5Mtg/WkHozGxSBfI6zkPDEI/bbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604264; c=relaxed/simple;
	bh=941Myx0C+BHTDYO2HZs+YDgOCcB9fjEpwriDhfSjVQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pTh8UuDjT1EKlqH07DgwC0Bmo5u+clYqf1t4etgmWFl8t0WROOObPBCOu8sLJL9Hys9YUza5DmZK2eO4o+aFIuR8GOTLNvsGi27YH/Wdvu17NxwbTcpzowugsxv2Oi/FG3eCzyZLbea5q8tzSMf3k6NJP73VKTCWMZh+BJgoehc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qupnZd6Q; arc=fail smtp.client-ip=40.107.8.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKl1/mBjePTix7u5kzUFvniGpnFqRAeXUaiTgX5gnLL1JSTNlkaGRDyz7PMWZgHtMlEfUqImDrACgV1JBSdkBNOLxwwjciCEJj2XouPm9wgcDLVRTT1juPDWCaE5H7PxSheA0C/W3J3F0489fr8TjvQDIFWTBNJ77Y8fJvBXYm9zndJcWcJShxUyRoyBJ5ajBu51FPe1wA5bRd6Xoo+BEwVOyr+3BZmcB9v1pQ2cFL9HgWXdZVmZLPfNeQn6sbsmnbpcADetiHUPzF1dkw+lFXwpN64dNHUxG3GsKt4hQefaLYveKJv9VS7TVAHGzhy90DRxEhqwYLuR4t0P1EiMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=941Myx0C+BHTDYO2HZs+YDgOCcB9fjEpwriDhfSjVQw=;
 b=cBdFDnuugxxLoe6GKFRZb8bUJbDWuJ36AwZu+RnsEe8rlkaKwZ8qyNyVuCgmoqy8bi7uBjrLPjZG3KaLWcbjXP2PO9RqZIY6+l/f1BYzQZI8Fl3BvxmEdTvClEJ9xFmfbQ2GYnti/yminMrBrDrsaqk1eT8wFHxKFmlWOFUFzixjIEFLM9ZM4EU+CFm60ToEBk/6SmhWkC/dRIaDdgrVW91+lNhxBweJFV0DNZ+AEkt2S6kp6zv/qBPu2elcFvy2YtkP9HNq0psEFSeTyQVInkqok9OGgCnDfI5K+Vb/SBn4q0WzZPFf4S7YxViUsMLgw6nE59a7T9gRfaDB8yIzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=941Myx0C+BHTDYO2HZs+YDgOCcB9fjEpwriDhfSjVQw=;
 b=qupnZd6QS6wISJq1wFNk4Y1Ch/51WLWeSZuOkbWM4hLG+C8ymzuyXaTF+eSThpCbxvQufp9lgDLKCx5EO/2H4DqXvdVt6YkmkbBJ17Jt+lEdF35G3V1CCpCksKa0BFVY9ij2xcVlJ50A2yIYN6gZuFwTJxJSq23JrQAL+GX6UiU=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7620.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 09:10:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 09:10:57 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Michael Hennerich <michael.hennerich@analog.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alexandru Tachici
	<alexandru.tachici@analog.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: adin: add support for setting
 led-, link-status-pin polarity
Thread-Topic: [PATCH net-next 2/2] net: phy: adin: add support for setting
 led-, link-status-pin polarity
Thread-Index: AQHakm8zKD8AIeH2kkinJ+YkV5wRNbFvvMgAgAEjqIA=
Date: Sat, 20 Apr 2024 09:10:57 +0000
Message-ID: <fb13743f-a1f6-44b7-9659-882976f0bc7d@solid-run.com>
References: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
 <20240419-adin-pin-polarity-v1-2-eaae8708db8d@solid-run.com>
 <65411c68-c76a-499d-88c7-e80ca59a3027@lunn.ch>
In-Reply-To: <65411c68-c76a-499d-88c7-e80ca59a3027@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB7620:EE_
x-ms-office365-filtering-correlation-id: a2512d1a-da0e-4b7b-84f0-08dc6119ca53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHpWUk5CVUVaQllFR0FuZGMraE90OE5BbzAyTVN4cDJLblg1N3NrRU1SWi90?=
 =?utf-8?B?WUVJZUZubko5ckorVjdqWUo0bXJDNE1RSGpXOC9vMGFYQmppbDBlMndWMlVS?=
 =?utf-8?B?aGtMckI3Q0d6dGl3eHdQRTY4WkhrbFZkMVZ3UmpNODdlSDZTYWVncTI4aWRB?=
 =?utf-8?B?amcydzdndW9PblIvT1Z2TEtlU3R0Z2Q4TFZCSWFPMXBGcytjK1VKS0ZRWVM5?=
 =?utf-8?B?UXJsYVprUkF6L3A5OVlNU0NlRzNyT0FiTDBSNFlCa1dZcWtzVE9PR2RwWTRu?=
 =?utf-8?B?T1NGbHZBNGF5dWVBNGx5ZTY0RE9DUlJHdFdGUzcxZk9iK090TUJoQTNyVVd5?=
 =?utf-8?B?UEhiQ21oSklnbTA0UVN1QVRzbXYxcmxObWdxaFpVNXZsM3g3THZYeFJJUWpO?=
 =?utf-8?B?NGoxUW80YjRmK1I4VjU3NzQ5Q3orYnQrZnhwdVdUK0sxbFFVN2lhMlFlOVJY?=
 =?utf-8?B?cmx6RFdZc2ZRdWdIRWVrRDhJekIrcFFkNWhiei9Iay9XZk9PdFdtYS9MZThY?=
 =?utf-8?B?WnJ6MXhmdW1kSWtFTTdZcEVZMUN0U1J1MzYvOElIWHM5ZVJObmo3eXJtd200?=
 =?utf-8?B?SUJzYlczZkc3SjJFYkd0WkRiOTNrUVNmckhhWVlXb0hFOGhsOWZBNWhQUGgr?=
 =?utf-8?B?TWtCemFNMWxpNHRwRlJEVm9Yak0zYmpFazVtajRoQ3BlYnRkeXdLYlpVTXpZ?=
 =?utf-8?B?VDRrdFpPNDBSVVJ2ZFF1MDY5WlFFMlM2MGNDcG14VGZRWnc2SFlmdkZQTm9v?=
 =?utf-8?B?cE8yNzR3ZmZRTHJrUVY5bThNRU9ZV05JSkZRbUxLTHozOTA3am0zVm40SXc3?=
 =?utf-8?B?dnJlUENwbGdGZXNNTWNSTlArdHQ1MlJBaFFvMlMwb1BSMndrSGxoaWFveGJo?=
 =?utf-8?B?L1BmUGhZbmRCS00vK0RObU9PSE1US3QyUkZEK2RTOFpDQW53bVBzS2p0K1BG?=
 =?utf-8?B?aDJwUmNCQStLTHN2RHBoaGNLaW5YdXVyNWdOZE5NNy9Wdm81T1NYODZWc09Y?=
 =?utf-8?B?OFJia3BBajM3WW1yNmpiZ0UzNktreGlTSzN5L01mTENBbGZ0anZWVTYrSWQz?=
 =?utf-8?B?RkJHdEhGOGtQdW5oT3NBWW9zZi8ySkxGRDFORXdoOVlzbHowaitTUWNmaHA1?=
 =?utf-8?B?dkgvRm5sTHFTQVhUYW1sU1JkOEFmWEZoRjEzZmx6SXZSbS8yQjJpajBLT3Nr?=
 =?utf-8?B?TEUzYmVHY1dXSUthaGtvMnRSVk02dGh5V2t3KzdmS0lUMmo2cmhtaWdyWlh1?=
 =?utf-8?B?VkpPNDhHQWg2TGk4R3hpa0pjRWR3NytuSEJ2RVcrU21rQmlCV3dLdlg0YUNX?=
 =?utf-8?B?dWxZTnZiUmxrZk81KzRkUW9JVWRwVmZ1SEtuaGtZR2JER3JzSkNuSkNJektq?=
 =?utf-8?B?anhTN1cyR05DWUZtcEl0UElYZGxKdS9EdHJ0aTljSjlnUjVrQ3BBRlEvVUVY?=
 =?utf-8?B?bVE1THlEaDU5RkZQOEZyaGZOTUplL0QvbFcvdnNWQkNwL2VjWWZYbW5pVHFN?=
 =?utf-8?B?QlFPZk0vNU0yQUE1cWdPbjJVd1IrVEJMZThiN2NEdkxUWUJ0L0Vtd3Fwck9q?=
 =?utf-8?B?UmE2T1NadnNnRlNQdUd2a2RMbkJWL0ovNVV2ZjUvMFNoYnV1ek9DUmtLMUJU?=
 =?utf-8?B?MDFyWllPME5vMEFNejBKdGh5RGU3SjM2emFhcmpwWEEyMFRSVys4Wm5wdThs?=
 =?utf-8?B?aUkyZ1FSK2h3Ym0vM1Bua1pyOVAvQXdIVml2VnpvRUR6Yjd5REpPV3oxbHRy?=
 =?utf-8?B?V2ZxZVB1MndWNkFROFlPM1ZmcG9QVG5GZ1kvVGhiQlgyeWxMWi9Sa2xKUFR1?=
 =?utf-8?B?TWVLcWUvVy9SMjY0ZVFodz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTZNRXVvOG45am9vN0YySWhsYTJZb2I1VCtYc1Y2VEwxRVo4M0M3Z3BKbE1L?=
 =?utf-8?B?MEJLdEN1U0hodnluMXlLbDZpWmRvQ3laRVQrYWZkckh1dlBmVTgwV0ZGMlBr?=
 =?utf-8?B?bjBBVjFDVkhJbDB5bzMrSGdyYzRNcTFxcURkMG9CY05EQXZNSlZteDJtUm5O?=
 =?utf-8?B?SmVPNmdZVjlKZTNGUTRSTWtsb3pWcVZDMCtFVWZSOXBqU1d1OFlTRk4rUEto?=
 =?utf-8?B?cDFMNGFLbzZNekdzOGxVOVJSdnRoNUhKWW9JcHhKckxwbXZNUnRpUnFUTG1r?=
 =?utf-8?B?eldYKzdLaGdyMVFWUHlHcWV2Q3lhbGlMbkU4ZnZ3cGNTN2d1MVFaV1BmV1hz?=
 =?utf-8?B?cUZJckRwcWU1MFdBMS9JR0JZUjRFd1hLU0xzbkJrWkpoclBhWTk4YUU2MkQy?=
 =?utf-8?B?aExpbEJHclNXVlV0am9CYU5CcmkwYnB5UmdYRG54TTh3YnVoV1pJMFRyVE44?=
 =?utf-8?B?ZzhVWjBjOE1RUFVCeGJzcSsvRWN4ZzM5cy8wcWc5NjAzM3Awd0lzTW51UGhx?=
 =?utf-8?B?YzY3SmozQXV2ZGxUL1p3OFg2WDJWemhZZEhTc3VNYWVUSDQzc2VITFQ1Ly9K?=
 =?utf-8?B?ZkJkNEhlRFoyRXZOY2lIZUluZE1tTEpIV0xSMUgwQXlVaERBZFBRZ20zUXAz?=
 =?utf-8?B?YVkxQnhxYnBqVktrQlRkdzRZNVRDQytMMkF1VU1UNWtkYjJhWk1JZzVQSzIw?=
 =?utf-8?B?TWNNSGREcDhBOWY2NnhSY1QyZ1FVdldwOXYzelZHeFlLenZ5MWNRdnNJMkd0?=
 =?utf-8?B?bXBGZTNrT2RNODUvdzY2WS9FalVxakZDMDFpTEhYQnFuZ0Vjb0Jia3NnUU1h?=
 =?utf-8?B?eG1IR1JneE5iNWt2R3dyLzgwR2IwVi8yZlNYZGJBa0loNlh3MlZUYnhEOERz?=
 =?utf-8?B?Yi9mbm8wTlBrSnQyV1RkMjc0U3IxZEFibUs2ZS9oY1VtSE1GME11R0FqSGJj?=
 =?utf-8?B?aUg4ejFOZlRLb0pZdlBiWTVrUUF1ajVhS0lGdFlxYUtyNFNTbDBHOTZnQkQz?=
 =?utf-8?B?b3Z4RTJtaW9Ob1JaVnd2QzB0T2JmbURSQWJWWFlGUEVXM3RiSUpnVHVZOUxH?=
 =?utf-8?B?SmFNSHpPNk5pMEt4QnkyUzVRTmNnZDhMUEpXcm9ORkdGZTljWkNoYll5WFpW?=
 =?utf-8?B?ZGlwSzFJYnU2cTJWbmhOL1ZHNCsvM29CZEFJc0xXOTd0dzY3Zi9xcEphclIx?=
 =?utf-8?B?NGJRM1hSU0puSEFkVStUUlBNWTBlMEFnRVNRV2FHNTB0d0FZU0dmM1dwbXBw?=
 =?utf-8?B?bGpBdmcwYmdCVmlaSEY4Rm56WEFqNlZrYkJUVGlUUUVIUmkzalExMzBGcjEw?=
 =?utf-8?B?MEtIRHRjQnhXVGhXT1NvY2h0YmlvZ2xydEQyVGx2NTAxTE9zc05ha1dab0kv?=
 =?utf-8?B?dUhGb0JJOFRId3h1SUIvSXBHdDFBVy9xbmRyVG9xKzBjQXFrNkE5ZUVreTF6?=
 =?utf-8?B?SGJBQk5HcE1kVlZrWmJkVlArbzA0cTdJOXM0bTVzZWU5SlorNnRTVlNhUUFM?=
 =?utf-8?B?K0dlZytrVW4wWlY0eDRUY2pGcEJWK0xreDRmZlhOeCt3MEN0UlZDd1lZQkNK?=
 =?utf-8?B?NHBmVW9qbDQwOEtGVDhIbWg5T1ZMTWZMVFI4N0N2UlpxelRwd211cWFJSVdP?=
 =?utf-8?B?V2FUMTBwZy9abFI1ejQ0VUZnQm5ZTTM1MWVkZFpGaE9JRnpTUnc3TW14SFcr?=
 =?utf-8?B?OGRKdVpWN0JwSGQwc0FIVll5NFNHUDJNTHlFUkZqSERzUEhnbk5FU3NMSkN2?=
 =?utf-8?B?SjZlWTRrQURGU2QrRFJ4d2FmVjlnUzBFTUNrQ29rZGZ2T3doMkc0Qmo2c2x5?=
 =?utf-8?B?MmwvNloyczZBYVo1VnBVOVNFNTk0WGd1RFJDWUZyd2haWGdBQkRXeWVkV0NF?=
 =?utf-8?B?bTZ6NWpqRnZuUTFtbWxROHVQZW4yL2dmYWtacU96ckdWYXRMeFQ4OVBzeHg1?=
 =?utf-8?B?cTkzZTVKUzFaaTMrbGlPem5Kb3VjUHVSOVdUQUJyOVlabHI1THljTGJBWDZq?=
 =?utf-8?B?MUpRRm9PN3ZQcDl5OE1rNEwzYUJIU3dJZGgwZm8vd2lxMDlIa1Jlbis3Z2ph?=
 =?utf-8?B?cnpnc2QvcGFEbkRaU1lXZVF4eW5MdUpFTGdvZVI5UWhtR3dqdVdkMkVDR3li?=
 =?utf-8?Q?8u+Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC0C4B2C092F645A06BA270A84BA6A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2512d1a-da0e-4b7b-84f0-08dc6119ca53
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2024 09:10:57.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPkioyzKQLf7ZkmIEvHzfOS4+nrfDqc7DbpgFKFwTRQE8OU7ODo1IrgfJFb61k8Hy581ZvF6qN/ZLrQYzeGw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7620

QW0gMTkuMDQuMjQgdW0gMTc6NDcgc2NocmllYiBBbmRyZXcgTHVubjoNCj4gT24gRnJpLCBBcHIg
MTksIDIwMjQgYXQgMDU6MzU6MThQTSArMDIwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBBRElO
MTMwMCBzdXBwb3J0cyBzb2Z0d2FyZSBjb250cm9sIG92ZXIgcGluIHBvbGFyaXR5IGZvciBib3Ro
IExFRF8wIGFuZA0KPj4gTElOS19TVCBwaW5zLg0KPj4NCj4+IENvbmZpZ3VyZSB0aGUgcG9sYXJp
dHkgZHVyaW5nIHByb2JlIGJhc2VkIG9uIGRldmljZS10cmVlIHByb3BlcnRpZXMuDQo+Pg0KPj4g
TGVkIHBvbGFyaXR5IGlzIG9ubHkgc2V0IGlmIHNwZWNpZmllZCBpbiBkZXZpY2UtdHJlZSwgb3Ro
ZXJ3aXNlIHRoZSBwaHkNCj4+IGNhbiBjaG9vc2UgZWl0aGVyIGFjdGl2ZS1sb3cgb3IgYWN0aXZl
LWhpZ2ggYmFzZWQgb24gZXh0ZXJuYWwgbGluZQ0KPj4gdm9sdGFnZS4gTGluay1zdGF0dXMgcG9s
YXJpdHkgaXMgc2V0IHRvIGFjdGl2ZS1oaWdoIGFzIGRlZmF1bHQgaWYgbm90DQo+PiBzcGVjaWZp
ZWQsIHdoaWNoIGlzIGFsd2F5cyB0aGUgcmVzZXQtZGVmYXVsdC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gSGkgSm9zdWENCj4NCj4g
UGxlYXNlIHRha2UgYSBsb29rIGF0Og0KPg0KPiBjb21taXQgNDQ3YjgwYTkzMzBlZjJkOWE5NGZj
NWE5YmYzNWI2ZWFjMDYxZjM4Yg0KPiBBdXRob3I6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVy
LnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4gRGF0ZTogICBXZWQgSmFuIDMxIDA4OjUwOjQ4IDIw
MjQgKzAxMDANCj4NCj4gICAgIG5ldDogcGh5OiBkcDgzODY3OiBBZGQgc3VwcG9ydCBmb3IgYWN0
aXZlLWxvdyBMRURzDQo+ICAgICANCj4gICAgIEFkZCB0aGUgbGVkX3BvbGFyaXR5X3NldCBjYWxs
YmFjayBmb3Igc2V0dGluZyBMRUQgcG9sYXJpdHkuDQo+ICAgICANCj4gICAgIFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4g
ICAgIFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+ICAgICBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+DQo+DQo+
ICAgICBBbmRyZXcNCj4NCj4gLS0tDQoNCkhpIEFuZHJldywNCg0KVGhhdCBsb29rcyB2ZXJ5IG11
Y2ggcmVsYXRlZCENCg0KSSB3YXMgYWxyZWFkeSBwbGFubmluZyB0byBpbnZlc3RpZ2F0ZSBhZGRp
bmcgbGVkIHN1cHBvcnQgLi4uIC4NCg0KMS4gZm9yIHRoZcKgIExJTktfU1QgcGluIEkgYmVsaWV2
ZSB3ZSBzdGlsbCBuZWVkIGEgbm9uLWxlZC1mcmFtZXdvcmsNCmRldmljZSBwcm9wZXJ0eSBmb3Ig
c2V0dGluZyBwb2xhcml0eSwgYXMgaXQgaXMgYSBmaXhlZCBmdW5jdGlvbiBzaWduYWwNCnRoYXQg
d2UgY2FuJ3QgZXZlbiB0dXJuIG9uIG9yIG9mZiBmcm9tIHNvZnR3YXJlLg0KDQoyLiBMRURfMCBj
b250cm9sIG5vdCBjdXJyZW50bHkgc3VwcG9ydGVkIGJ5IGFkaW4gZHJpdmVyLg0KVGhlIHBoeSBz
dXBwb3J0cyB3aGF0IGRhdGEtc2hlZXQgY2FsbHMgZXh0ZW5kZWQgY29uZmlndXJhdGlvbg0KKGRp
c2FibGVkIGJ5IGRlZmF1bHQpIGZvciBjb250cm9sbGluZyBsZWQgc3RhdGUgKG9uLCBvZmYsIHBh
dHRlcm5zKS4NCg0KU2luY2UgaXQgaXMgbm90IGRlZmF1bHQsIEkgc2VlIHRoZSBwb2xhcml0eSBz
ZXR0aW5nIHNlcGFyYXRlIGZyb20gbGVkcy4NCkhvd2V2ZXIgSSBkbyBiZWxpZXZlIHRoZSBsZWRf
cG9sYXJpdHlfc2V0IGNhbGxiYWNrIGlzIGFuIGFjY2VwdGFibGUNCnNvbHV0aW9uLg0KDQpJIG1p
Z2h0IHByZXBhcmUgYSByZWR1Y2VkIHYyIGZvciBvbmx5IHRoZSBmaXhlZC1mdW5jdGlvbiBsaW5r
LXN0YXR1cyBwaW4uDQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXINCg0K

