Return-Path: <linux-kernel+bounces-168472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B68BB8F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CB01C22A8C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE8219E8;
	Sat,  4 May 2024 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VcxhoruC"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B3224CE;
	Sat,  4 May 2024 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783338; cv=fail; b=jm0zfA3R4zbi/p2sZTiGbxXIqL2BYTonN5elDgDLe+PNP8ORQ892tsMd9KkgUqsVvy4NGmAVd/vu5WzdxGvMkRqSq17bCtd0JNFhTrTcocT5Y83Gre2I9EVcN3hv4sI5rtl5edmt5UdxIuXD50s/TyPex2SeHaZJ9HjIHr9Cc7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783338; c=relaxed/simple;
	bh=PgxRlbUcS/uvOvhLhmHPrOfoWAYvLqu1YwJpsaINx8E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iCF4TMgAigYvPoclC+oZ2JNOJgMokeBT5Ja4QF6NACCgFo813KTSnaN1BnBaEvWNck4XMxadVJB7Vqpw5M4boHO6plIJiROCiwJJ4vMLExAT4vci4NNRyjhcMIK83uaTaTRgEFZbMTXNeWKjOvCM35CMt/SWuieuy7BZ7TVuYh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VcxhoruC; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1Ks3ECTjYMTnzweWWRlaikmoYghMLWIEf+N8MD46xcAR/APlxGhm2FUQelgCHLaKQ3Z0ipA90IpWYz4KVBGEu1zQEkJW1bZ0iiL47ztqQPPm0ceDK38CyNO/lR4Q7Ut4MLd4Qf1/LKrVoG/FO2Py7S4+Ur0VAbJNdk+omFupeDOoehAxi5ZqvFbvfSNxJtEbn0ljO23CZdH96lf7XJL6qtqWyTp4NTc3kuD4ucreiXhyEhku5UrfdnRf0C1qzb/UC2NUsA3frv5rs6a+b5p2z8a7QPDLM1W831ACiX46bWkJLwsBjq0IBuN9rHCFvQ+gc/KC5iSS7moHIcKK32Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZfg5qL7SHsnC+/O7PQKVa9Y6S4TDdYFXWK5DCJ1IFc=;
 b=eOKWbH9UGt+R19m4L2Oyujfo4GS1tHMXMEZB55jxHtqatvsKAGLTrEHfgLvBdsjN//g7k//WZCvJf7qLGFZt57KoHKGm/QsfbpP+3Deg3E1k5g9vo0HP6gVnLpZ5D7Fe10rLAciMtSEAdUeevognrEHeM6GdNAUxYNCVZJLdpj49Mo66ht2J8N4XIH7rSRZ/f5Oh9yVZAkKkt4onq8R3iTSmus0amkSa+3yX22s/rGlwTo2F7UXdb+KGaHKUWA+bXsLyIXjJZvH8V+Sf3uuediEAvFJ/VyKgMtQc9oVnTYdSVQBrZO3ziVUo/MjdXZtDtTlAoBVLwCl6Lvu79u16DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZfg5qL7SHsnC+/O7PQKVa9Y6S4TDdYFXWK5DCJ1IFc=;
 b=VcxhoruCLxg/jYQmTHr61OIeVwt6cobcozo/eIYbWraG31E/bMqmhEuWGwpuVuLdM/3OFUlW4RI4y+x+dvSvNF6hLx3Pb/tXIsMXqlr1ssVxdHOb+enfaiUXi0FvoNuQIUoZJYtWNr+OAZETy+GQgxrQwLQxtEyhC4hrq1aTzdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:06 +0800
Subject: [PATCH 13/18] clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock
 to non-critical one
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-13-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1404;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5nMT2IffGwQHQ4in9ZnMD+FiKPbKEz5YS4WgB7bC2HQ=;
 b=CYyctJuM/mW4+h45gNib7mfqtjltQsTMyUWJ11qBIJkXIytrSsraqPu72haAiZ0HqfcvS65tG
 HKAcO6y0C0dDQNRfDNCvaEROUOAvp4t6ZsiR1R9TU1GEG1U5wainfLy
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 73011272-92ff-4272-6c7d-08dc6bd30a5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGUyWEN4Ymkzemk1YVJNS0lkT2F3SGRGOW40aEJaS01Xb0lzYVVZYjBFSDFr?=
 =?utf-8?B?REx4YjRybWZtTzQ1d0xsNDNwRTUyUU9yRzBoUzVZaU5HSFI5aFBFelVteE9o?=
 =?utf-8?B?MkJxWjJ0WFErN2FJdGNFYmVXbWwyR2MvdjBwZjFzSklqanBEYmlKQ1FOUFU3?=
 =?utf-8?B?OUVpcERCTi9wbzJHQlAxWkRnK09TaHNOTUNOTkZxY3FrOWFiUTlERWc3SU9r?=
 =?utf-8?B?T3YvUkxkSDNlYUdpYU5hK1lQKythNjh4VjZCajNOTFpLcEJxS21lcTc0OVZo?=
 =?utf-8?B?OHBaSDNqaWZNdVFTUFRBendJek82b0ZyM1BsVkJSTGIvUVZrL0VqUUtYSUkv?=
 =?utf-8?B?WEptWjZvUkgvMmNxT2RzTVZZaW9lSWtmVEZ4YVB1L09jd1dSUkhXUDNZbUFV?=
 =?utf-8?B?Y1RSSnk2MjJSSFB3UkM4ZWdDRzdGQW1HSGl4Zm1BcncvSU9ka1dWNzM3QkNC?=
 =?utf-8?B?aUxRTTZSaUtPK3lVVmZQbFpJd0FkOXlKaGZmVEJHc1piR2VTa09QMHlDSnFi?=
 =?utf-8?B?NU1YTi91MlJjdzlMY1JOenhaczRNRUtZbzBnMzI1U1JQQ1kxOW5YR2hYZHNI?=
 =?utf-8?B?SFFQaTVGY3VYMFpzS1NkZWJuSXNRY2hkNVZmZzl2N2JzOWlqSUdobWUzcitm?=
 =?utf-8?B?UWhnQmh6WUhYdG9TelZCR1p5dlRRbEJ6TFZNbGdwYngrak9wQmhabFhRbzdw?=
 =?utf-8?B?d1pOem50TFNpaFZDUHpKUzBjWFBYK0tmalFVSVo4RWFkYU1sYktVNGFTaExl?=
 =?utf-8?B?YjEyN1h5b3o0STJYYVJxNy9PTnVlSEtLMkJwekhoWVZQY3NnTzRSRDVncDhF?=
 =?utf-8?B?UkdyZWcwU0NrdHJEclo4ZGF5TGxNeEIwbXI4TkhCS0cwMTdyNmM5cTV1anp1?=
 =?utf-8?B?R2ZwOHFmb3FQRG53Y3M4VGhCVnVockNxVkVSRGkydTdPZnV4cGd1ZDZRS0Y5?=
 =?utf-8?B?dU9ySlNnc3RPQlZaQTBwRnRmTXFZRzAyUnVHamROTHErbUlwRnhjMW5yZ2hl?=
 =?utf-8?B?cnp6cFFONG5ybVJWM1FRZCtLMHRPdGZVYkFSS3o5a25YT1pqMklTTVU1ZVVu?=
 =?utf-8?B?K1hhNk9abVBsblYyMzBVam1HL1pMZWFDNjBIQ1NGZlAzT3VmdWFrU2lneXdX?=
 =?utf-8?B?ZXZzdXR1VUNpQURycHhXV0gzWmQwS0M2Vm5NSFVib2RVblBkSlRXZ21pdmVq?=
 =?utf-8?B?d1J3MVhaNmNXZzl5REUwR0hwamwyYi85cG9LNVNzZ1lRSWM4WXplOElHNDhn?=
 =?utf-8?B?TzVUb255ZmhOWVRXbFNBem5GdVFINDF2Z2Jsek0wRVMvYVJsWVgxU1UyVE9o?=
 =?utf-8?B?S1BzbncxTFBWdUpoUmFmWWRZZHI0eUxveStGWkFCOTB3bVhjNC9JSDhGTk5G?=
 =?utf-8?B?clRjdUl1NHdJaEYyRDd2MFBOa055SzMyaFpOQmpSQ2t3ZUEvU05STXRLU2ly?=
 =?utf-8?B?R3I3azFKV0dmWG5lMUxlajBqK2N4RUpWcWpubjlTRU9FMDBRQ2FxSGFueG1G?=
 =?utf-8?B?V2tERlFhV091ZXhBemdpVWNsZnVoSkxlOE90OU1wY3YvZjJ0cklPRWlyVHhz?=
 =?utf-8?B?ajRnbUhYeUxiZ3ZrSU9SbHQ4aXVkeE11dGhTWjdndmlkZkZSN3F2TC95aGsy?=
 =?utf-8?B?d1pid1Y1ZGVDQlhnWTdTaEV6V0xWbm5LUlNJNGNHZmxqRmxwMHZTcmM3MExa?=
 =?utf-8?B?YXZXeFdUQ3NEV0hTVzhEY2JOcmwvVEs2cmFVbnNYOHlaQ3pyY0owSzhxN2VF?=
 =?utf-8?B?WnE1SmI3U1JBSGlrQm1wWnJqTFcralRBVmlmVE9Za1NLSlk0R0R6NitydVBk?=
 =?utf-8?Q?wYYXn6v+IMM3BNCdq/7QjTlVd9dynYbUo6gmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEpWa2JXUDNPTzdZYU9DajZ5Y1dIdFdEWWE0aU1YTW5wMlVnMXR2VmEyNjdj?=
 =?utf-8?B?ODhlS1B5MnhNVzVqbSsreWFpQk1jRG9HTk9Pd09rbzFmUkdMTUd6OHRRQk1E?=
 =?utf-8?B?K05lVkVORHBzY0JqYXhjTFFmMHVXdlM5d2MwSVZHcUZkQXhLQThqWGcvMkh1?=
 =?utf-8?B?NjdnelU4emtMd0ZDKzVsT2d4ZzlCRWFpREliamQ3SkRCWEVaRTVOcmlIck9R?=
 =?utf-8?B?SEhHNHVIWVJ2WWUrQjI4ZUZ5OS9lekFuTkg4alZldStXTzAxWk1MbUFqSHZH?=
 =?utf-8?B?MXJjUUxZd21HRTJwVUt5UW9LbVEyU2xmSUxUaFJQMXdUMUFERmw4VzU3SFlU?=
 =?utf-8?B?UkU1SUNFd2xxRGdoWTNJWmN2dzdPdlBwQllneldFTWhqYkpOa0lQQk42SmZl?=
 =?utf-8?B?MEN5SnZET0VhQ0ZJRSswb25UU3NqZ1ZHTVY2N3luMzVZemQ0WVZFTDBhYlVj?=
 =?utf-8?B?YlhUMGdXcW5ubi93N1dHNS9HakZJb3FzeHFuU3FBZzdtZkgxNk44MzZMQmNK?=
 =?utf-8?B?eldWMFIyQUx1VVJNQjQwRThyeUFYRkRkZmNJQktHNlJPRXNUTDNwYU1TcTN3?=
 =?utf-8?B?c2dWMURsb09KYzM1WEZ0eGZnMUEvMDZ5RjhBNXg1UGxrR2ZYaStlTldJUG90?=
 =?utf-8?B?dlM0Z3FyUlc3cTlxSXl5VEc2VG11WjVFa09NZ3huTkIwWkY0Ukk0N1ZselpD?=
 =?utf-8?B?dFBmaUdubk9yeEtaQndDNlZsb2hHbzF6Qk9HODJZd2ROUHdEU2tGdjlHclB1?=
 =?utf-8?B?WjBXK1FEalNuK1ZCZjk0TzlNSzJtelJ2aVJXQUQxajhMeDNQMXM3QlJMalgv?=
 =?utf-8?B?eUJvY0xPOW9nNzF5VWJabDBBZ05ycE9QTnFyai9lNEhIcGFSYXpaU21OdVpo?=
 =?utf-8?B?cU1nZ0llOVVzOFVlTmQzKy91VmtxOXdWK0l2OFJrNjh2V05uQW03SFpua3pa?=
 =?utf-8?B?Y1hqMnBvQVcrQTdqV0p6bGRKa1NmS1RtWUlvT2pTaklSbkJvWWFFeVNYb0lH?=
 =?utf-8?B?RGV0UlF0NTZTTUplajBsaDNQbjFmWVBETXdYSDZ5Q2JGem5rUE9QVjJWUStn?=
 =?utf-8?B?dW16NTE5OVhvbGRkUjZ6QUdpcVJOWEhXN0F3UGQxazgySUMxWXFWK2dsbGRD?=
 =?utf-8?B?Y2RSaGhGY2JoSlk3K3FWeld3NCtLZDdxbFlDSXV2Y09LNURuQk1sRHp3OGd5?=
 =?utf-8?B?UUI5aVpFa1MvR0NiS1pNbXFMemR0Zk5rSnNwZFYrOWU4enNuOFRvajlnRHlk?=
 =?utf-8?B?WDRUK1lPckpXMTNrcTdkZXEyUG9HNnR0MUN1YTB5cFRtQWxGeUVqNDI5Y3FH?=
 =?utf-8?B?R3FML05IbDdoQlI1UGlkWWhPUTY3Z3hWWUpSTjJ4MWo2Zm5seXNSOTYyWTRy?=
 =?utf-8?B?bVMxUHZ4aTBBYVBlOWNRbkJ0WmtTRW5yK3UyT2lwbjZWeS9zQmZXRXlxNzZ6?=
 =?utf-8?B?WHBOQVpLV3R2bnIwV1RpQ1JQM3VaMklmNWV2cmpTczU3TUFBNTh3anZiS2kw?=
 =?utf-8?B?Nit5OGhnUSs1ZVpQUnUvZ1hsYVdUblFOVFBodnYydjR3R2pldzBESk5aNXBj?=
 =?utf-8?B?YjNCVzBCQU44WmcwOEFmYUQwL2dJbkNhcVJTQVFmM0kwUHpDR0EzRDRrYnI3?=
 =?utf-8?B?MENtKzBQQmZJdjdQWURzSHRkUi9iMW5UZFlZT09QQkx2Z2FWN0gvR1VaUGFD?=
 =?utf-8?B?WitPT1BBeUpWSlZEVHE2TUUzY1NvV2NYOVR3SEEyZGVPNjQ2aDFIU1hnTkF3?=
 =?utf-8?B?ZDR6ZVluRldaT0krS2tpcG93dzRaMXlaOUNlOEZWdFZ6VXg2Qm5ET3VYbE84?=
 =?utf-8?B?QnpURzduZUZwRVJjdGRxRG5CamduZWxHdWZMOXlKbGgwMExBL0VxQ1I1UmNM?=
 =?utf-8?B?VnI2TVorOWlZWHY5cnBoai9rWW5HeUx0TkdkMS9jL3dHejFodllncFIxZkpw?=
 =?utf-8?B?ZmorbUtNdXNmRDBZWE9pSXJXS1Z2eXJQMDlYTUZ1NkdZY2l6TUxZNEJFb3p3?=
 =?utf-8?B?N2M5MUZQOWR0eEwvUk8zWTBtWWU1S1dwQ2prNlhJWmI2SDQwN0tBcVdhSGpa?=
 =?utf-8?B?SlJjeTdxaGp6WU5vazZxa1R1QlZLd1dyN3FSQkorTEl5VnM2a2o1dWRMTHBP?=
 =?utf-8?Q?yX3gw3rb1FuhQ87g+v5odOgBb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73011272-92ff-4272-6c7d-08dc6bd30a5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:13.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZqyPXUdNH0jIDPjzv86YEEHwWo3o2xyZtvNcK3mQ3ECjV1YbJfLMGEUiuIWtWlDMK2cKfHsGqVbx6v3ZBN98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Jacky Bai <ping.bai@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 075f643e3f35..342049b847b9 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -432,7 +432,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
-	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MM_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mm_vpu_bus_sels, base + 0x8980);
 	hws[IMX8MM_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mm_disp_axi_sels, base + 0x8a00);
 	hws[IMX8MM_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mm_disp_apb_sels, base + 0x8a80);

-- 
2.37.1


