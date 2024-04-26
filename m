Return-Path: <linux-kernel+bounces-159456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170938B2ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481E01C21A48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA56757F8;
	Fri, 26 Apr 2024 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LW+MS2LF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D9EBE;
	Fri, 26 Apr 2024 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714100701; cv=fail; b=qumNT3oxMm6+fi+pm668oL1W0EK+C1zqUO3Yt58cTW1REmK3Hc+qwdTYQh6CHBqZ+HmQot2/P4M6yI0a7s0Ptcfhi8HoPAQV6T8MhBOy/M43NPvrK/TM8QLRH5eLW0cuGOGfpKoORRDmyOLcaTAo3854hjRX2wZo8O2k3tjBKzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714100701; c=relaxed/simple;
	bh=dqDp19YMgqfW1gTRtuYyAoC6nHVhSqa+ICgb3e7CpS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cieMhmglcVLJcWUWo11emN0pWhRIgCLJwzIrCuDMaNpX7yjHqMBhNXFYZVhr1Am7jdq2C9GNRyoIgQo5XPnsqFEkTSJLeMHU5tpmesI/CJIi9AzKJ0d511oGvGJPIGN6Dbo+qfz0djGILkwu3YxIN6sHBuMiJBQPEMocYrvOIEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LW+MS2LF; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4yN7+dW/NWbbSG+zwGjgqL1HrGJYo9GThwf0V82VL5EcuIeRLXw2trN1mqXdf1LzbW353WASZOOHvpaORffOMGC0F95UUnRYmEcUOt56hN+VykzDQa9yPE7UaPoKnJRl0CC4pr1kblC26Rs8G1m9uFbahe02wsRDwW1Az4SxiPdyLs1WjcyXNciPVyt7ZDJyFUdo//nK9tUKzqq3v8Jz7H0TxKDgTPS3mlOaEwXmJNcgy5VfZpmgKxz1WCWvuMTFW3q6P/Ng6kR9J0qaHIQHLbnzDR+Q/niKHuFC3IG8jGGEohVne3SOy5wRSakkfVUBhS9RhSA/yoxCGBcO2D03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqDp19YMgqfW1gTRtuYyAoC6nHVhSqa+ICgb3e7CpS0=;
 b=DGzZFRmU315T2x4REIRasebMpoUXWqrdPPwow2OIJwPSJR5Tvr2tKik7WQse4XaSScj0d23jNdYD5TyagNTLAWnaHAi8t58yh4wWZRkiqIX9SNVwooI/JXM7+S/uvvOgERN2k5vmAYewpRE5Yo48nYnhFcLbPOgN/ClE+LaleVrXZAu4xFUCSXChR+bEsk36xgNsQVloLvTt6hhPJXkwsJUhfLmxEJvRncSTQkrg47y7G0hPvHID+AwDMs4MAuj/3u4br9nGrNu8xFFrAIWlJcK4IN1wvPPT9oMX+pebLaXQNTykVjLmyf3nvJTp+DZn+z6y7RCKvFg8W+b4cbclLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqDp19YMgqfW1gTRtuYyAoC6nHVhSqa+ICgb3e7CpS0=;
 b=LW+MS2LFYux8IzJSUCJhw84w3cA/SaQMCzNCbkiWWK3lX4p7xXQ9y4Ghm8mFKYBLRlpZtp5IXxOA3QDNNhWmAe2q1JBRHb/U3kdy6vhaycA8QoNYgQ29IuuE6HbiGjBZudGGV+q8C1egv2iJbYNscTzcfY7tV0SyJiAaz9yM1Ww=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 03:04:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 03:04:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIABL2MAgAShB4CAACKgQA==
Date: Fri, 26 Apr 2024 03:04:56 +0000
Message-ID:
 <PA4PR04MB9638228A6867C1844AEDB740D1162@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
In-Reply-To:
 <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8783:EE_
x-ms-office365-filtering-correlation-id: ba34cb8f-3f5f-4406-6802-08dc659da70f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1Q0Qy95eXpxMlE5b3RZYUl4YlIxVDYxWXM2OUtDSjJtd3N4dVJjOG9nS3VZ?=
 =?utf-8?B?bmNNRE5HQmxQVkdzN0JDLzJEOHBUbStuQWplcENlZzhkaUN0OHdOWHhCWnVi?=
 =?utf-8?B?djRRZ0g4K1h1a3lUUzMxRHF3Z1l1N0tRZk9NYmRRTWdOT1BFMW13VmpCRnh5?=
 =?utf-8?B?amlPVXF1TnhibkxQMHg1Z2phem5XZVJOOGpzcllDUVR0bWJUUnR6MkhpREc5?=
 =?utf-8?B?RkEzMHE0dEpnd0g1cmFCQUdiTytwU2pxUW1HcFFuemt0eUc3anR2d093elA4?=
 =?utf-8?B?aXo1VDZSODFkUm9KMU8ycHRFQUV5bTZnZ0hSa25KbXFuS2NjQUxpQkRVM0R0?=
 =?utf-8?B?anpLUlpiK0l2bG9QanpBZHNLeWNJU1hIUzI0S0dweUdUcHBYRTZrOHFjODZy?=
 =?utf-8?B?MXFzUFY2aUp4bll4TkM1ZTg0NFl5dThHNGVVdFRXVG8xRE1MZlhsNUZTbXlH?=
 =?utf-8?B?ODhoUkpkUVRMN05ITU94aVBQWmdkR1dCcW94bVplb1o3dUJ2dG5LWGJJSnJ6?=
 =?utf-8?B?ZXJsVk1XMjJyNDlObGFobFVMMDF2eWhzSlFQaFErVzN4Q2F6ZXAwWGk2UzNo?=
 =?utf-8?B?QWVUSnYxbjdTT0xNT2F3aTJsZUxOSGxzQXZIaXB6cGFuTVUyRytKVGRoY2pI?=
 =?utf-8?B?eHFUR0pvNFQyeGk1RzhEUUdpaHB1Z3pwMDdtdmJUUHo5eFoxQXVRZXBodGpW?=
 =?utf-8?B?OWZuU050TjZoTlNIS3VYQVRTZFdBMzQ0bDN4TGs2ZEh1a3hMaTFQSGoydlpy?=
 =?utf-8?B?RjI1Vjd2S0d2TjZFcFNnSGdjUCtZdTJjejZxdEd6OGNxZGt4eVgvSjlHMkhV?=
 =?utf-8?B?aG5wLzY3UHhaMDJmTnE2TWhBSkZ0R2RDYXh3OXdBZHNiay8rZXIvY3lGQkhV?=
 =?utf-8?B?WVFBZDdVdUxIdnVsRnMzTUZlMDRkVy9IZWE4cFhHajdNQkV1YVdWKzcyOE9O?=
 =?utf-8?B?N0Y3b2hhelJZeWIxK2RaK0RUMGZMalBLMVU4cENkYXNmWktRcjlxek85anZu?=
 =?utf-8?B?d3QrVnc1ZDh3akxzK2ZGcThYRWl4WTJCRFBnbDVRcTlSSGV1aktwdm03MWRT?=
 =?utf-8?B?b3ZLZXN4dGxhVm9tOW5RNjlBYkJmWjVycEJhSjJIRVB2K2NlQUN4V21EdWxN?=
 =?utf-8?B?OWdWcWtFa3JVRmNBSnlRczBsSHZpalMrVkRpaFIwdmdnalp5eXFQWWIrL2lF?=
 =?utf-8?B?VWtSWXRzT1Fwb3U5dmxaYWdBNkgvejRHUWRnMHRBTmRqSEtMYUd3eHBsWVc1?=
 =?utf-8?B?amJ6dndLWEZ2c3lIb2JTWGh6bS9OTWdmckNvN2ZKeE5TOXh3U3M5d2Z5TWdB?=
 =?utf-8?B?WFBaYmN6N3YwWVRnYmg0ZnFuRjhUeGxHSkpUMHExT3dXVXYydTRqUHJFRkRk?=
 =?utf-8?B?ZlZpV29qWnI3WFFxQkMzWnViNW1XNUZFYkhCaVdMcittRDhFWTVsK1NqSFdY?=
 =?utf-8?B?bDlYNFlNTi8vek1FdXhVMGFYNytIVTdVTUtucUdXSElPSzBWOHBBc1F3cTgz?=
 =?utf-8?B?WCtNOWVZV1U5RUxnK0hhT1VkRy8vdHpUb1AxVWNrRExWU3FWUmE4NnRRRE5C?=
 =?utf-8?B?TmJzNUkyVzFDdWhtR0t3Sk1FWlBvWFlQaHZTRHAzMDVNU2RCbHBWcXBJc1Zq?=
 =?utf-8?B?L0VmcnRoeEpyeG14YkZUZUl4cjdYZ3g1MU5Lb1dhNXI0SWJpTlV0NktvenJP?=
 =?utf-8?B?MW16ZktoVUJMUlZXZElkMGtsS0c5bHEyNWl2cEd2RXZCSnlBYjFZNGFGVktB?=
 =?utf-8?B?RHpZdko2S3NrSmtQNFhvRHJpaXJSWENLRnZxaFFTb285VW5tNHM5eitmc09u?=
 =?utf-8?B?OUtJQ25lZWF1OVBOM0VXQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QStzTXE3Z0RmcWZNa0lzUmtrVnBwVUdFRmF4dERKVTdXV2htNVNXQWRrTTdX?=
 =?utf-8?B?bGRuSlV0NTVONEdUR08veGphTG8wNm9odnUwU3pqNTdYSVlWbE9TMEdLVHp3?=
 =?utf-8?B?RTFUZGdsLzk2SVJidlNGY3RpNUpWWDNYRkd0Yjl1SGI4eFVqMkQ5VVlpMEhL?=
 =?utf-8?B?dzN0cncwdE0yZCsrVms5b0Myb1RIWVJwN3JLWlltNmRBWllNWkl4aU1tV2Rt?=
 =?utf-8?B?c0lxT0VSRlZKK04vc24rNkVEaFF4c1BTNWNaYjdIcDhtd3c0bkdsQVlZaDgz?=
 =?utf-8?B?a2laUEFQS1krWS9ZL3hCZTFYMTFLRGpQVStBQ29sNHgrNVB3c1JWUy9lMXhK?=
 =?utf-8?B?MWxoajdjdmxkY1hwSEhhdzFRVVdTMnA3VGIrOUFZeXhmTjdJYXkxK01aNlVQ?=
 =?utf-8?B?R3FaVE9EL3lwTmc1eExBaUl5UkszZDZHeEgwTUZqSGJyeGJiOGhnQitsZ09T?=
 =?utf-8?B?OTV5Yjl1STVSbUp5RWlCYk9xOGtTVnIxcEc3d2VHZXEyUHRoamU2MmxBbVcw?=
 =?utf-8?B?MXdHL0hzUGttR1g4dzdBZFRoWDNsMTJOZlU5TUZSVE9WSnZUTm14b0t6SG5y?=
 =?utf-8?B?SmpzZy94dmt2M2F4RlRBc0U4cWl0V2oxM3RsRXY2eGhkcGU3ajhLNnZHQUpr?=
 =?utf-8?B?ejlLd1drTzlwajhUNGZIMlloamZacjFWU2ovblA1RXdiRndtQmlUSDFnUWhV?=
 =?utf-8?B?cmgzOHR4enFlWTB4ekFsNXM2U1lNMDFLUnFlNGlLOWpkWjh4bC9PL0ZTcWVW?=
 =?utf-8?B?by82dVNDcGsrUzZNT1hHQk5WOU9GTTNQQVJQS1JJcDk2SHdRbVpwMUtkZTVv?=
 =?utf-8?B?eTZhdmZVN2dmZXQ0MU94ZzB4K3gzeGg5MVkzcDNSM0RkaWd0Y3FLOWNGTzlB?=
 =?utf-8?B?ZGE4cFliM0FTbW4xeXRqY1IzQ3lVVXprUUowdjJpUCtOVVJDQUV5cEs4dVh5?=
 =?utf-8?B?UVNRQW43S2htU1pVclNmQjFvcXhtSlhWMWdrZVBmY1VEbE1KMElWTFFQNG1u?=
 =?utf-8?B?aEdMZmZTL0xuQkJaN3JGVXBaUjNPTWtXb2dVL1doUzd3UUNnNDdtVlZZRS9w?=
 =?utf-8?B?SFhXRGEwTG5PRnl6cXhrQThNdHlaNHZVcWc1RG5NbnNlc0txajdFdmFUMFBZ?=
 =?utf-8?B?U1VzSi9WTmNEN0hWNWduRk1peURvNHZhNTFqaGlkU0pyakp4SmRTZEQrc2Nw?=
 =?utf-8?B?Wmc0Nm5pNGM1MEhzQnRNV0ZJZ3c5a2t3eVBuNGNycVFDMkt5ODRPNk9Rb3RH?=
 =?utf-8?B?bGRsQ0dOajIzcjdFWGFacHJVZ1J1ZUdzM29VZjZlYktrVll1RkxlcVppdi9h?=
 =?utf-8?B?a3V3R3dmcXM0K1BhS0liTEhvaGFLbDNLQU9FSlo4UzJVSldLZkxBNHJLVU5h?=
 =?utf-8?B?TDFyd29od3ovdXVzTmVQRVY3ZC83VTBmV0JFOXdXRWp5QVovenMwK1VRRncv?=
 =?utf-8?B?NXQ0QzVVYkhQREhNeGF3RnoyZHZlUC9MZzdjQjJheFc5MzVrUllaMHMvaEZT?=
 =?utf-8?B?UURldnBETlI4T1VpTDN4RVgwMnFoc2ZLR0tZNCt3eDE2eWtzS21YUVM1ck1J?=
 =?utf-8?B?N1BkRzdQdVhpdXRNcjQxQlA0RDQ4aG52SW5nRjB1dDkwMTRhTmtzM3p5QXJr?=
 =?utf-8?B?SEtucXNYdmQvWTlMMVM5OXRhMFhYT2dJMmt2b0RNMjd6Q0VnS09nMklrcFpr?=
 =?utf-8?B?cU9oS251TFhKUHZBNC9KZ1V1b2ZqSUQzSGJFaGsyVkxialFzVXRRdldkdlBx?=
 =?utf-8?B?VXlvV1h0YUtGN0NMbFZocmxEUFNqaVh1Mkp5ZnhaK3kvSG0vdDZDaHI0ZlBZ?=
 =?utf-8?B?T29STm9BMUEwWTlNUFZ1QVZkYW82VGZSN3hvdjd6Y25qUUcvZ3psaEtkSFB4?=
 =?utf-8?B?OW0wMjdTdEdMNGg4ajFOYit1aGRlVTVOUk81MWRrRmc5TzM2SDB5QzdGaVJq?=
 =?utf-8?B?bHRjdUl4V2QvNUdWTHVhVTl5OXMra1Jja1NIcnR0RUxrZldnUnpBaWU3ZGtN?=
 =?utf-8?B?RGJSWVd3MldJUVdBcVhscWhaeG9TOWh5WlF4TjhyQTU1ZnRtZHliVk04a2pY?=
 =?utf-8?B?bzJYV0R0Q0d1V3NOdlQ2bW1tQkhMU1hpVDNwaXpaUmdCYjI2clRXdlJrQVNk?=
 =?utf-8?Q?tAdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba34cb8f-3f5f-4406-6802-08dc659da70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 03:04:56.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybwIA3FKmrs7jY/6B6WYivs/3RMn6yX5XBjkoonVq6n/i4r/zf1Ih0pL2pf7tpsN6adpu0hFs4ng+FGmXqjiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBBcHJpbCAyNiwgMjAyNCA5OjAwIEFNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsNCj4gTEtNTCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+Ow0KPiBmcmFuY2Vz
Y29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaCA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47IHJh
ZmFlbC5iZWltcw0KPiA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsgRnJhbmNlc2NvIERvbGNp
bmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gW1BBVENIIHYxMCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1cHBvcnQgaG9z
dA0KPiBtbG1lDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50
cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+
IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IEhpIERhdmlkLA0KPiANCj4gT24gTW9uLCBB
cHIgMjIsIDIwMjQgYXQgNzoyOeKAr1BNIERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPiB3
cm90ZToNCj4gPiAgICAgICAgIEkgd29uZGVyIGNhbiBwYXRjaCB2MTAgYmUgYWNjZXB0ZWQgYnkg
eW91Pw0KPiANCj4gSSB0b29rIGFub3RoZXIgc3RlcCBiYWNrIHRvIHNlZSB3aGF0IE1hcmNlbCBo
YWQgdG8gc2F5IGFib3V0IGV4dGVybmFsX2F1dGgsIGFzDQo+IEkgd2FzIG5vdCBmYW1pbGlhciB3
aXRoIGl0LCBhbmQgaXQgZGlkbid0IGNvbWUgdXAgaW4gZGlzY3Vzc2lvbiB3aXRoIEpvaGFubmVz
DQo+IGVhcmxpZXIuIElmIHdlIGhhdmUgYWdyZWVtZW50IGV4dGVybmFsX2F1dGggaXMgaW5hcHBy
b3ByaWF0ZSwgdGhlbiBJJ2xsIHJldmlzaXQNCj4gdjEwLiBUaGF0IG1heSB0YWtlIHNvbWUgdGlt
ZSB0aG91Z2gsIGFzIEknbGwgYmUgcHJlb2NjdXBpZWQgbmV4dCB3ZWVrLg0KPiANCj4gQnJpYW4N
Cg0KVGhhbmtzIGFuZCB0YWtlIHlvdXIgdGltZS4NCg0KRGF2aWQNCg==

