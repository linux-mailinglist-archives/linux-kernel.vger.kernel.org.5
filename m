Return-Path: <linux-kernel+bounces-154556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BFC8ADD98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8150CB21CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A1249F7;
	Tue, 23 Apr 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LTQ3ai1c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ouOId1n3"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9A17BB7;
	Tue, 23 Apr 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854539; cv=fail; b=QnqJdQmO8YavPsmjngZ7hT2B2N6cel9rCBT0pY0BNFlac7vVoWUl9Y1dkwXytlhLCbzC8s0gBjgKuYefUxe35kQCIIk8g4rW7HdYJMe9RhkfNKhM4NPwz72HBCqdHd40A9eAq3vEjlnan9Gb9LaqF+xAfDconh/jFfUEuliLKAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854539; c=relaxed/simple;
	bh=fnyCkFeTQq5fKUAAe2Y6IXuXvbM09srdFzreoput9Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEpwf5Vv+PLiWJ0F4VMK+g7VIa9M2usBJMRuw6d3addB9FkcZRyiAIno8Q/J5uTQo47sjQABRTOF/mvmKsratnd6MiDNVBHIbsNHJijhrTJgxHp/tk0LU2+en2IJmJ/V1qIEoIdJ4TD8HEE92ADdTQVVCqtR8qi0CBsAvSOBT/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LTQ3ai1c; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ouOId1n3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713854537; x=1745390537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fnyCkFeTQq5fKUAAe2Y6IXuXvbM09srdFzreoput9Xg=;
  b=LTQ3ai1cY9XrUpTHjzzdfURGod/x/zphcUSkAsyJ0mkOT5+yz6MW8dYZ
   Cua3takTIXL4kdsp0Z3FaFkhurtihl8n3CK4yfuy0FCP5CwuWC3t3uVQm
   LM6lLZOOovKnr/GOOoYv7nnvmZTAi+dbuJD6xzYRJ4dM9aQVa8951peVb
   4hhJEdi29CEUVSvfNXpZb1VLRJtsCGUzu4fLhUWSScbf52vnZ472AFA2s
   Ay3aN7H7aitw98KKkqbRqOaJUtPssipCWRD4JwOqPHVFFwS5tgsCDlGJx
   B2+soHiW8H1VN6xEceyyzi3eXV9uRMigFiRXZ9paMgi6//UMlcVpVEctp
   w==;
X-CSE-ConnectionGUID: xHf1IS7BQcm1WsJU9X0wmA==
X-CSE-MsgGUID: zGI4LqQFTt21t7m0+gnqxw==
X-IronPort-AV: E=Sophos;i="6.07,222,1708358400"; 
   d="scan'208";a="14628545"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2024 14:42:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6cQ5YGnd2SFvcilmeaa59Z6MPg3tJfegQBBYa9a2ror0o5HnQCsxwt1LVMEMJ6A7QAvoLKGKK7VEb4TVUPd/QEUfOTp9fQ3IqlH1PKNmMwME6ZLeAB2gCAnN7Bj7Ni/HYQGVLc172KCqgjO3LD90py+vnq2Zvkx+jkvscmE8rkKY1iTj6gBwXWWMMWv4GAWgGA9Z+mGA58W2o/CVSLZJQLbMW6aXfPl4M0KK2RqRLoJxohCMf9tO4wPg6zLL/cNt85Hibh4J/SadGjRcEb/AHHw6SMmN2mJKxCxGiA9U+ZPtqn7MNT88z+kGM5QW4X5z+F46MG4ATKOUypluhv69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnyCkFeTQq5fKUAAe2Y6IXuXvbM09srdFzreoput9Xg=;
 b=CsTTcvUDD8Jg2m6LB+b72ApQ7xdUHOs6a86cdnn/kHBM1v2is0Ul3xDjHXysq94Rsj9g4g8gKcNX3b8iUn4YOqBdvqu/8OiBeCb+hXXD4jk2i2QlY4ADzupsrwzjtVwUxjYGR3SOKBEKt5+qNsF3f2IBzhVj4Hl4bSgM2hJxTJ3wFRzxFW8sR9ug591qk/RDgCsc0QxUghC/jApVraxDYK82oZtpehpdShU+tA/jp+q2QPWqUZ+qPmdvEIvVVHqFSbvPPGT9ApiGMxVGEvPz4uIxdOhe7Sfx5bILAtfVSkc4ttrg9z4uOZasoBSu6OBCtRxFmP9aJ+iXW+nM2CWppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnyCkFeTQq5fKUAAe2Y6IXuXvbM09srdFzreoput9Xg=;
 b=ouOId1n3q5BuzLHrY0RNW1jKRqKs/U/ZLR9oyaUKv08iLy59tahMMKFydYT/89/ellqB8592QCA32nXRKCnii9e1jIeGe4b5S1y/l1LDuCVqJANbpfIOVwNR1GsebpcX9NCGgA1MzPQhnO4dTN9W0h/CyP9o+xpOqi15tT1Cq8s=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7886.namprd04.prod.outlook.com (2603:10b6:a03:300::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 06:42:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:42:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
CC: Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Thread-Topic: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Thread-Index: AQHalJY+lZ6WHfQ3U0uUl8CgTGkiY7F1Z+Kg
Date: Tue, 23 Apr 2024 06:42:05 +0000
Message-ID:
 <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
In-Reply-To: <20240422091936.3714381-1-jens.wiklander@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7886:EE_
x-ms-office365-filtering-correlation-id: 8391c16d-a0a4-409d-2eeb-08dc63607d85
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rm4xU01UbUIvK3ZHS0llNVo4Z2pOME0xdXd4VHVvUTNYMXVWZ2lzeHZWVEpT?=
 =?utf-8?B?OU02c0h4SDNVekMwYVhvckFOdnpNWURaUHd5WnFLYTZwVUhkTWRzK3BXY3Fs?=
 =?utf-8?B?UkZ5SnZCcEhzakVEWHRIR3FPUmtidWFpaXBFckJWT2FFZ3ZkdEpHY2xhSGR5?=
 =?utf-8?B?b2Z0eHJxL09wMUswdWU1eHE3THhXbE1Dc1o0T0p2VkVSVnVKN05rQXo2ZFpW?=
 =?utf-8?B?SDUwQ25HTlNMaHNQR0Yrc0tDQWRNOElSa3RVVjdhaHAxQjNWZCthdkgzTktk?=
 =?utf-8?B?b01XeGY3MGV3NXdzeUdUNm9XMGNXaGhLb3NhR2lJNWo5YzVsakRrcXhvN1Nr?=
 =?utf-8?B?My8zaWlnUy9hOVhLbmdJOE9UejFlbjdYWUN2b2Y3cEExNVhtZHVOa2g0MDQr?=
 =?utf-8?B?RjkvbjA4V2YyOEJyL3NaWWZPQXA4ODMrb3NjOElBMlZ6TE1wRGErem1hS1Bi?=
 =?utf-8?B?NnNPUVZrRytWMis2V0ExNko2eEptbldCS05HUkZFa080M3gzRXYvWXkwOHVK?=
 =?utf-8?B?OGJaUWpULys2em1vNS92OVBjVzhTcHc3aGJSVXgzLy83UUxTdE4xWUErYUU2?=
 =?utf-8?B?bHV0M0ZQOXExZ282THhCVHZab3VmTzUvQ0JGSVM0aUpJT21wT0tESDltSTkz?=
 =?utf-8?B?MTl1NGFDdHUxSk1wT08vNHhXSzB5Y0ZCTTQzbGljcjJrTUdKeXV0VzNpYzFM?=
 =?utf-8?B?Q3E2SVBNSzZxRWJKKzdnMENiTG54R0prb0lYamNsRzVucVVzblkzL0VKZHhR?=
 =?utf-8?B?VHJEbTJaYmF2cm9SU0hnblRZbEpjTFRrRitIVG5aSTBzcitrVStZVGFpakpt?=
 =?utf-8?B?aG5BYkg2bVRSVTkrQ3JrOUIvWGtUVFlHUG9WVytzZ3QxZ0FnR3NVeHpydzdN?=
 =?utf-8?B?Y1gwbGpqUWp6bVVReVkyZmdybWozWEYyOHBhak5wV25ZcE1XK1FLdTR0cEt4?=
 =?utf-8?B?OFp1VHV3UW0ya3VUazFFN2F6elN6S1BKODZOUDdZOG9QSnAzckdJb0QraDY5?=
 =?utf-8?B?c2RGWG5vUXIyQ3J5eTV0QjhlMmhLUlh5N3FVcVM0MUxoRG9obTdNNGlwY3VQ?=
 =?utf-8?B?YWxwWEt2Z3d1QjFkLzkvbVJpeVRWMzhWeFFnUGw0SDU5YmJpbnlyTVYrRVRH?=
 =?utf-8?B?ZU9tL215TzFCS25odHZteUVoeTFLRGJzcEZuYWt4QU5TNE11UG1jY3JUWDF6?=
 =?utf-8?B?alZQZ1ZPYktVWWdXZG5EdWNoRll1RmZoenh0blVrMXhjaUpiVGE1MFpodHZJ?=
 =?utf-8?B?L2ZsOGV2UE0vamw4MGhpcW4rRzZPbTVDbTRvWSs1cm5Ld3l6S1Q4MWJ4d2hK?=
 =?utf-8?B?UmF2U2ZRdmtUTWhsRGpaQ3REeVV2NkQ4N29XT25mMEZ4MmVES1NTd3lINTI1?=
 =?utf-8?B?UFZnbytIK3lMK1ZTVUkraGNxZ0xrdWM1NE5zQ1pMbVJaRE0vNStlVkRpNG5s?=
 =?utf-8?B?OHFIRWJybzl6bzhSZHFKbmNFSk8zaFhVSmp4Q0RHUS9vNGN4WUZ3NlNIblcr?=
 =?utf-8?B?ZXRWRXMvRW12QmRHOEk3SkZaOFRZNzlpandXTTQrZHhMYWt3Umc1ZHhKeFBU?=
 =?utf-8?B?S0ZkQ3llUDlIVkpNbzU1dXR0UC80NlYvd05acWdiemdiYk9oTldqbWRmUHN3?=
 =?utf-8?B?Qk83bXhvWmhoYmRneTZCaE1rSU5zZmhOUDdYSjBNZmZsMDlrNW9Da2QrSnhH?=
 =?utf-8?B?a2JGN3hVMWpOc0I5UXJFVVRkcWRrM0tsdjBDeDl4UDk5QVZZMzE4dTByK2Nm?=
 =?utf-8?B?QitacmtLRmZhMEttbjI5a1BrTnV3R0lHT3RnVFZraUg3aER2Q0JibGNhTVRn?=
 =?utf-8?B?Z2dHOEFkWmtFK2xkZWV1QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFBwSFJkdVdXcmlpb2Y5bk16THhwVmxtY05iZm00NW5tbllJVnJMN1Mzb3po?=
 =?utf-8?B?ZlpIWkpsR05NSUo5TFk4ZThyOW9hN1ZOaXZOd21vNU9IOXFtTjZPeW8rQW5l?=
 =?utf-8?B?Uml6dGNwZENUME5JMnN0NXU3QVkzaTFxVUd0UEpyQmFndW5TeEp3MzdhS0RJ?=
 =?utf-8?B?SXJmUVVHdFhiT1dwSkNOY0F1Yy8zS0RhT3pnNXhseFc3aEN4ZU16Kzd3L09H?=
 =?utf-8?B?KzJQdzZkWEpXTGVsbXpiT3BZb0p5SWpIemJGeUZleFAxZXdER2c5UmNnR0ti?=
 =?utf-8?B?alZhZVAzOEI5TUR0Q2p4QUZ4KzF1K2hyTzB6YUxVcXhZMWpEd3RWRGtWQ3J4?=
 =?utf-8?B?R0NjaE9Mbm9PWmZpSFNTbWJSUnhveWZSbGxZdmhYQ3R5WC9MeWxSaGh4N3JZ?=
 =?utf-8?B?UjN6ekVLQlNTUVkrUWo4ajJZS0FqaldwNHdjNjZNcmo1OWFYK2J5YTFFdUtJ?=
 =?utf-8?B?Wm1nbHlSMjJPRWZnUmFnbUFtdGdjU2FsTTJKL2F5SkdNUkE4SE85S0dpMGlI?=
 =?utf-8?B?cGs1VU1hOGNqT2tWbFhvMHBuZnBKNHpqNFZiMEhDbEcrblBJTm9GeTkzU01q?=
 =?utf-8?B?eFl5a1I4NEVvbjhhNTNqaytudHNPdHQzRkJLMmFQdWNpQW5LMkd3dUNVMDNz?=
 =?utf-8?B?cHYyZENMRmU2ZUllcGNEd2w5R3ZpZWptWnlFN2JYcXZPTWU4d243TzZiL0w5?=
 =?utf-8?B?L3lodmZLdlZNT3N3UnJuL3d5N3RnSis1cXdXbzlPK3QzRktwT0FmUXBWOHpB?=
 =?utf-8?B?dE1Pb0V2QXFlVm10UW5LMHFOU1JOU3dtMWtxQ3U1a0VPa3hRV1VPcGRRNnBy?=
 =?utf-8?B?SkxTYTF4SmRvTWNvbXZQemVHYXJoK3VCWG5iNmZFT1pERGxCa3YwTmJDa1V5?=
 =?utf-8?B?Ly9nZXhPUkc2M2NOcko1NFhweXhSOGhqZXhualFRb2xVT3phcFNhVnU1RVlX?=
 =?utf-8?B?SGZodUFHRFFQckt5SWVzQ2I5SkpjK3NmRHlUZUkrL0RhMHArKzZwNzZwaXcv?=
 =?utf-8?B?QUIwUThBL2RnbnVZSzhrK0IrSFN0Vnl1dVk2clp5Z2RsNDZTMUFmdXpQNXJj?=
 =?utf-8?B?YUp3WENEUFp1M1JBVEM4dndJdjZqQUk0RDlNSFRYUmRoV0NLNGd4d05FVW91?=
 =?utf-8?B?YmhqS0IwaTkxY24vaEQzUnhFdWNJUWk3dkdydnlDQkxML1NTQWdFMzh0dUs4?=
 =?utf-8?B?VlJGdGlyazZ2MGpLLzE2OUpVRlVHQXM0dmZOZWFKRnJ2bDM5cXBEZmZQclk2?=
 =?utf-8?B?S0piZlpqKzZWK0RpYUJWTE0vZUVNS05zRDcvVFR1czRYeW1EcjBBRnJhUy9Q?=
 =?utf-8?B?ZlllVGIvMXdQNXJUbVpMQ1dwK2NoKzBHaGsxVlhyYTA2YkdZSGlyVHJwK0JE?=
 =?utf-8?B?djBHTkFXckU1bGlGL3c2djdTUlNubUdRVWNJbE92Sm5leFA1TWdiL0F5Zy9t?=
 =?utf-8?B?OEpJVUV4Rm9BL1RHZjB3MXJSbXE0OEVBZGJRV3lHVlZaMW9qTC9SampRQTA0?=
 =?utf-8?B?YlpsSGQ3QlZnQUlmVGdiUGxXMU9IL080RzdFMXh0MEJ1WlcybDJqMlM4WU9C?=
 =?utf-8?B?bVRHWU5xeklPN3h0cjNGOGxOQU96TjYvbDFaQ1lRVFZIc2ZHcUsvazV2MDdy?=
 =?utf-8?B?ZnJ6bmVuVTF5VmJrVTB3RldXZnYrNDcvSHJxSHJjMjAwNENxYWpoeDdzWEEw?=
 =?utf-8?B?OFA4ajFSS252NFRiOXMwbTB2ME5JUk81Wm5QdjNHRVB5QXRDMTFXbkF6QXdC?=
 =?utf-8?B?Tjl6QXBhQ2dyUzJ1TVJiSEpTd1VuS2JPemNFWVBMMlRrVjJjRHJMYnJTMmhT?=
 =?utf-8?B?VDAvYjVDcjN0Sy9pcjU4V2tZUnloVktVdmZqaFQyR044UXlXR2RVemtEWkZJ?=
 =?utf-8?B?ejdONklxRzZ0S1NWbU5meGM2QndldWxFWlBteFcrTVFOM2hpd2UzWFRDNFF0?=
 =?utf-8?B?b2VCVW1LL3RpeWpSSlBySVJkd3RESXREK3pPQ1NWb2RhVS9kSTJ2ejBQVnVj?=
 =?utf-8?B?YW1nRmh5Y1RJN3A2Y0dXelhVWGthQUdjUSt5L1EwaVpHL3Z4R2k0WjRzZFBJ?=
 =?utf-8?B?cTFvTXJVekZCb3pBVGFCaXlwYlF5ZWlQaFRSUzVRcW81bVZuUnhMVWJaZFVS?=
 =?utf-8?Q?oLFneg5cXiaQ+sq5LD2aAF49a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KVAvW0xUerXDZ9zMH4kAHZ5D/soy5YdfRVu/K6o1uLLEyoC7NYxEHb8r1BfdQNjc1XRR1SbVbNIstC6CCbcxUWXGs7mdF2XUUxx/WSFDhcs+w/CQIVrDSWR6SwJNPi4ZDavRFSvOwk8woMpE7Isre/9Ltd+nncbADJ5F2htFS6uVqEXzTTsk6KvvmAFJLavsu3M+YRSRSxlqNkeg7DP3uiEalz2rX0cgjpHHv1VT6X8l+WDDOIuJsoSVv06LnEokKKMGBh6w+tNDToTZc1bAjEhGlwE1yamMWskDbZp/h+7zaGWWVJ+dc819/BSOobk4jU5SJ/RoP1DjqgWQbhnGKshn8qY1/37C6DHl+46diU+dc2tKHgIkszeoF1/LUZ3j7etKvxBhd1DNl87HlJVr4yFlEkm5nW51LhY3SNoALRC+YwQ+5BauYsURKDK6Ce9IEsXUAcsoJKv4SXoP/wp6cOtBvV/d/2Yx6MXDHBDnezLo9RnG4vyGZRfVmujz+ft55BGDSMQ5q6cSrnUflV4M6SYBhemdT+/g/YlLN5uYB24h1Q2f6hdE8epn3Aw/IEIbafvCvGq/WLBTyaw78kX2954xpZWNoJl5ETKPUO9QfXKD/Y1Ehnc/8t3um6Y1JJlW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8391c16d-a0a4-409d-2eeb-08dc63607d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 06:42:05.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCbS6MMadiEW4MrNqsGL29xQ+f22KUrYy6UumqVqeKjqfrw76AiY7HeySF4zbVZ0a1kke0KFjbmsNro7/hdBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7886

PiBUaGUgT1AtVEVFIGRyaXZlciBmaW5kcyB0aGUgY29ycmVjdCBSUE1CIGRldmljZSB0byBpbnRl
cmFjdCB3aXRoIGJ5DQo+IGl0ZXJhdGluZyBvdmVyIGF2YWlsYWJsZSBkZXZpY2VzIHVudGlsIG9u
ZSBpcyBmb3VuZCB3aXRoIGEgcHJvZ3JhbW1lZA0KPiBhdXRoZW50aWNhdGlvbiBtYXRjaGluZyB0
aGUgb25lIE9QLVRFRSBpcyB1c2luZy4gVGhpcyBlbmFibGVzIGNvZXhpc3RpbmcNCj4gdXNlcnMg
b2Ygb3RoZXIgUlBNQnMgc2luY2UgdGhlIG93bmVyIGNhbiBiZSBkZXRlcm1pbmVkIGJ5IHdobyBr
bm93cyB0aGUNCj4gYXV0aGVudGljYXRpb24ga2V5Lg0KRGV2aWNlcyBpbiBwbHVyYWw/DQpJIGFt
IHVuYXdhcmUgb2YgYW55IGJvYXJkIHdpdGggbXVsdGkgZU1NQyBkZXZpY2VzIHNvbGRlcmVkLg0K
Q2FuIHlvdSByZWZlciBtZSB0byBzdWNoIGEgcGxhdGZvcm0/DQoNClRoYW5rcywNCkF2cmkNCg==

