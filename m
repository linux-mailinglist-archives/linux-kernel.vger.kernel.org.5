Return-Path: <linux-kernel+bounces-148001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC448A7C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412A01C218C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF769DEE;
	Wed, 17 Apr 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bReQoZ8K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aBn/ygZm"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39125657C3;
	Wed, 17 Apr 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336009; cv=fail; b=ZFyIlazAt0E9ALBgR1psdoOMUI2zBHUC9Lm3PSnq62QrtzCR6HTdiSlCPlI7MHxCXiL3qdNM3H8rxhfa90UPIWxuJ2WrnWzQMKq7a8/IU4Lfo5JfvEz3sXxVhw5n0AmdbYDZvPB/wjutGtexKC+Hnkrq4olCn6fmeUAYt+JKNuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336009; c=relaxed/simple;
	bh=FU/1uUMVauWd9Krv8n66D4LSauijVxEvbOOToLV7f70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e3JQOgSs/wr9DCz2/q5RrRq+r8BYaSzFWOltRl5t73+I5qtQ3TrZpIRwrYvOx/1vd6+VcBVxu7HET53v3xlH5qXx/Zpd+7fnFOjDoqSj6uUhbPmhpo3aS6y90KKDr8P7UsBWqQm08bK098W6Q+KcS54q1NrAhd/fpteGJ1kkD8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bReQoZ8K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aBn/ygZm; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713336007; x=1744872007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FU/1uUMVauWd9Krv8n66D4LSauijVxEvbOOToLV7f70=;
  b=bReQoZ8Kj7jaAzjJ0a6liUO+yujp51owGa2ailyApm51co1cxol3HUVg
   PL0zgoHoPd92905Vd8SOIwjURSqjycDMsKrcX9MKQ45g6uNnK+uGe0LYF
   an3faJB6QDFai3JvRfT3gfJnxVieHeaRol+bSPz5rxB+HVLWuVURC+IfG
   5xSFIaUox/Ngi/7zakuAnlT2CYGfi+099gnhCML9Dp/zCzlRPfObxjJqW
   89sxr3Sk7YNjD5woVFszCuvkf/9nT2sRjzr8Wiq9FoEMUb9uJq+gJxKOO
   +OXTQUEtMv1iJILD0obpYRaH4P7F5Ko2f8CJce9R8rAb12PI619/rOGXA
   w==;
X-CSE-ConnectionGUID: K+zObKFZSp2WsXr2NTmwVg==
X-CSE-MsgGUID: MIHrc6bxSMGkc/nldzYD5g==
X-IronPort-AV: E=Sophos;i="6.07,208,1708358400"; 
   d="scan'208";a="14896366"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 14:40:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMyfjLWOHxd5TzV8+4/Ukm/vGZ+CqTnd6ykCm5aqffW8fjgvHxJ36K3K02LyPYlwc8lC4d7q4qxgZkZnh05gIylDdb6Ztq3WU/Tidf0KH0dK8Xq+cG1s0L6VNLBzGyf6jSn7GO1QeR4GO8OHNBHotqhn9fQu5zNp0p1CaNMPRYd8xLgQPfqboVOROcUjiosn41qy2llKGoaZe6tm8bxp2nhD/imJU8SPJFAKEXqzMh3B6ydue9Ngp3+yM8eI6YwKbAL6TqEadWsorxYhLH+/57PxaL5H6jA6EgF6/WTsfr8TI0thAqSztiNf0vQiwKB9/zoB1FgS+itmg2x/HAz74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU/1uUMVauWd9Krv8n66D4LSauijVxEvbOOToLV7f70=;
 b=B5fEtlSIgHNaAvWi8k/xo2LOpfGpTYDFImYkFcZtM+4PPRgOGfBtxyxUH8T4HHtbeTO9kOk75w1k6sZb38VJYVFcSVvu+ZnwBJsVKrW74ZjBZdEt6LpTLslv/WtvduW7nc+mWotE9dsrSuZhG77JCiOeg9RYe23tgpMKg4vdceofoBw8jB4HzN7jL1EZ9gobwRnjBSgIvRd1OqYSLMa6n8HbR8++Bwl8goWk4TMTuLwc+0lL+9oMGYPFJYwgAIQKSYy/RbFotuGAYHqsMi1wrMDecp39r7UJLX9/AIrADUmL93SxtoCJ7GOT5WZVsNuuixlWT6u5zy3tzQtG/70p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU/1uUMVauWd9Krv8n66D4LSauijVxEvbOOToLV7f70=;
 b=aBn/ygZmMq7o2EndnAMQtfTN1w+dZlf8ezkUWnuwbHII2FTyWUd7jJXT8g7mEaPagNEUaZUL6VRW+QcHjALDgyJj2iDnp22tAfNnFLGO0qfJUmp1MQR4+AyUPPuzySeapkEo5hZSM0hV1JZsyMNSFEOLm6oDkeV8booBRiqq0YU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6537.namprd04.prod.outlook.com (2603:10b6:610:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 06:39:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:39:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] scsi: ufs: core: Make use of guard(spinlock_irqsave)
Thread-Topic: [PATCH 1/4] scsi: ufs: core: Make use of guard(spinlock_irqsave)
Thread-Index: AQHaj+g2IdteSkMBgEuXLT7bPse87LFrReSAgAC945A=
Date: Wed, 17 Apr 2024 06:39:58 +0000
Message-ID:
 <DM6PR04MB65751C70ACA41329FF0BC378FC0F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240416102348.614-1-avri.altman@wdc.com>
 <20240416102348.614-2-avri.altman@wdc.com>
 <0b031b8f-c07c-42ef-af93-7336439d3c37@acm.org>
In-Reply-To: <0b031b8f-c07c-42ef-af93-7336439d3c37@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6537:EE_
x-ms-office365-filtering-correlation-id: 726e1d64-0a1f-49fa-9c09-08dc5ea9338f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bk1vZ47vj4NT+qMzJ5bBvIAAZlma6SMM4qLdWNuC76PIf/V4V9kR94uJ6duSGU33OoFWu8iHQHV2aGUSl8QOEh4si5OTMgJELVjUPvQaP2q7f30I+3V8SIn3QDWTDitgfzxbB84vQ2I8Ta8pe8CKb8Qn5D3zE3ABoPAi71YbXk82t0s7HUhDZTWiHaWiVNwNP5nseh+scArVSzOI6ieg/jn5m1cqRBNLAEouMiz+faB0wvhAJ7tRtxr9B7DoMGaIekn5Y7U3gfhUorc2im96+jNR0/0UZbrwSN90twEOlN8AHFUB+JkB6VNFSKf9A46t4ZRwD8VMDFrMTpzaSXJMME7J+TywUR6INyM0UIVhl/CMLh6lCL2mo5rzDTFnieFjD2S7EoTkfwr4kYnRaHgX9BeXdOFaL4Sc8spiSetxqL6rsrzHfAZgm10d4rEaOMpY8w/EJgbVk499keGwHjNOv9uDstsE/zDsXSQjCM/0V53hRHbCP0HfUwBlaIce0QytMihChF87/YmwKb0ujo8gd6PyQXsgo8WeBspdxGmRBE1jeTMi6Us3ayLd6xVvikEnRH0OqCqgVKCiJdUuFgfUUyN2J1j7mh1ngXgpq4yIuqy0KxGf/3YElc//ys0iLrqcc84eF9A2pUN/il302PTXdyyJZdJdTHR3G9O5hV6OIID/oqQmZxq3u5F22lCKTTpZUoJr6c6MaVbSqMjd/AO8cjZMDBgsmQnYGx8wJ2HTjHA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eURIazRPbzM1OTZiNXYwc3VyRG01eFhwTExnRDdjdElHdWowbWxIRGh6Zmtm?=
 =?utf-8?B?WjhTYkl4NnU0Qnlib2kwaHlCS0loRDNCa1lZSk9QNjJsL3FSdkNKTkJvVlA0?=
 =?utf-8?B?OEorRXF0NGxOZXhSbU9OWXdqTmUyNUlCU0UwT2J0eHRJcHpYSjduejJBTGRz?=
 =?utf-8?B?N0JyTGNrK1RwbDBZM0o4c0F6WGNLYjNnV2xMUEszcERnYlh4SHY1ZHlhM2wv?=
 =?utf-8?B?d3ZrKzNFYktRRy9ZRTJESFVGTFJKQ05ma3hLQW1uQkEvNTFad1lqS3plVlVm?=
 =?utf-8?B?b3NtaTdFSnljQ0Q1dFAxbVRCTFMvU3ZySjkrQThjRlRXS0swOHlDNkhLSlV0?=
 =?utf-8?B?bUYvdkFHOTZBSFhqamZjQklkeUxxSkp5L3cyWmh4aHMzeUtxTGdybDlhQUd2?=
 =?utf-8?B?VitOeGdGMm5JTXdmanh2TkdxVGQ1NDBHS2hNemdYNHIzenhXcWc4R0lxQUFt?=
 =?utf-8?B?RnZsRVA3Ui93d0VaNEQraUVZYmVhc0xzbzRpa210Y2FVTElnYzJFTTczSGFt?=
 =?utf-8?B?NlRxSDB1bnB4amRpZktHSk82VjNjb1NrZE9HaWIvK05VL3VLQzN0RVVocWpm?=
 =?utf-8?B?SUNBZU1QemgvWHpuN2dFVmdQVW9DWng3MzdVQ0FhRFdFWkxTNmVCR0psdGFI?=
 =?utf-8?B?Vy8yTU9NNjVzSGxhSmFKRU5VZUZyeDh0b25COURBMmt4SHhOeVpHK0s2dXBj?=
 =?utf-8?B?UjErK1Y2M0VneU5lRVhxVVEzVzlpaDdKVUU4MU1kMVcwb29JWkJ3MmRzMkw3?=
 =?utf-8?B?OFNFOFhmNEVSbXk0amovVmZ0V0ZRRTM1YUYycEY3TmlWMTFnKzZvZ0tKMHY3?=
 =?utf-8?B?YWU0VnJPdlpMSU5sdWZ1em4xcUJnM3ozRDdYUkVwZjhlZ29xbEcrY2ovMm9j?=
 =?utf-8?B?SHUrRzJHbVY1aE1raGhmZU80dE41RXp2cUZBa2FyM2ZFcnVic0xvWkVGVU44?=
 =?utf-8?B?VVIydzdKQmJPTjducmxjWE5lL1ZmMkJKUlpYN2Q1TDhQNE9HdC9pc0IvQmkz?=
 =?utf-8?B?ZVVlRlNBWEFsYUhJUnlmblcvVC93K1l4UmdpY09GNnVaZUVXckxZWWJrampV?=
 =?utf-8?B?S0Rya2pTWGhEVmM0bi9qQUJJQzh1SHVDNGN5c0pJdVNzd0k1TlZYb2VUM0JH?=
 =?utf-8?B?Vk5ZSXpIN1l1MzlleDZQK0tBcUZmbHFickVjNU1vb0hhbEhoMTVKZTZFZzl4?=
 =?utf-8?B?bXdIS0NNVHhpOU9vQXlTSHV1UUpGRXFXZjdRZ0ZKcVAzR3BYRkNwSnFVMURt?=
 =?utf-8?B?c2hsd0E3QXZaNUJ4MUhaemZxVWZGaE1KZ3poSXZwbkhJL1RIMFR6NG80WlFT?=
 =?utf-8?B?NzdFWllVempZc3p1V1ppdFRMMlhVaERZaTQ2di9keDVTcmVFVkViWXpiaS9F?=
 =?utf-8?B?bmlPYXhNS09rL1BKN2U5MzZtQmh2Q3R0VUIwNDhFZnFnRjJ3YzNXTHp6SEFK?=
 =?utf-8?B?a0l1NVN1SUhVK0o2ZE1FWDNQamNwbzRCODNLQjJxQUs3bTZjWG9NOU14T3gw?=
 =?utf-8?B?OVZUcFVrNktFOU9YN2hGMm9NSThORW5QbE9YWDJDNU9JcXBxSVBuQVd5RE1S?=
 =?utf-8?B?Yzh2d2RjYnRZYWZwUG91eUdPNkxBQmZIbXNZRjZ4YlFaaWhPNGNyai9jLzZ1?=
 =?utf-8?B?bU1QaVlNMlFZU0dPR20xaVRXLzdTRHJmMldjaHhnazlQN3pqcjdmcGV0Z2Vx?=
 =?utf-8?B?TlV4UHlSUHVHSXFna2t5Mm9SN2JRcEJTQlErMGs1RmdZS3p0eTNVMUU4OHhU?=
 =?utf-8?B?NDlDbzdyWGN2Ky8rNWZPVE11MjFKVy9MR01YTno5WTFjT0M2ZHdRaW1jVHd0?=
 =?utf-8?B?Q0FZdTIzYW16NVpWSVNQeS9Ebk80UDBVelI2dHlMMDAvU0dQNjlPTlhXcHht?=
 =?utf-8?B?cTFFYUtZSURpSFF6MGhnTURmY0h3c3lZTWkvT3Y1UVp3UW5FVlByL0pNNDFw?=
 =?utf-8?B?ZDNvTUJLWjN6dTg5dHdkZ2ZwNlY5YldJcTVWYkNDNk1BUCtzaEQ4U3BlTi91?=
 =?utf-8?B?MkRKOTk0Snl1SmJSazRVYjJaWUtnbi9qNWExajVPcDNJemprSDZOeTc3T05Q?=
 =?utf-8?B?NjVVbnp3T2FrVXNVM253OER3dWdneDVvTG1Jb0JjMEdsRktpdkYwMUdBS0xz?=
 =?utf-8?Q?V+8fZhdI5OruC/M71UxpwL2og?=
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
	IVwvl+Kqns4NeCDSExVXfOdwOUjBZ/yFcXGN+OBOeV/WHbwmFmgBPN8zBVAmPr9JfFdf+dCh/SK9P558Qdo3kk/sI9wWQj5ad90GiOz0P/CX5kqXASogbg7pija+Q1Gs31Zk8C+Zh6uFVMAPbFy8tNUFFMZfzOEV1tlqGPrHPin6YaWLEm6za6fGfATfw0SjEt8V9r2aHnD633tnv2zxH/neEJ2oElWAIujggoi7KJ8nUX+yCvhbpZVG9VQqbNENG6pwxsvl+4vVmpxVx3szu5yi9Exzvc0urplcoC3eYhGny3un54Z7k8WQA4hDxNItEsiaQ5tc7C9dP11WwC8OXOKAyJsiSBbneKEz5CAMkZejHgSXwl09Ydd3Ec435p2UKoPhrZpj41+03E+DqONA2Sg6cjlcZqDZkIYd21MUtO1UwICZcmOH9HcgdVSpO8uEdTfg4bXnC+w1go0m1rLh1UasEPTV7RHHz2ltrtqUpjzm39g/lLQyR0WVvwq59VxJAXrf7IESSZ1W8GIQq7AeTORyJhAOogBiSvk9ba0A7YVa2AlcrnGrgE2eQJb3KSlfdrsH+g305rUDQWviPjf6GVUhEQZshgAGJA26MYsq8xBSAGrqxRmr9HeEFcPdU4Zx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726e1d64-0a1f-49fa-9c09-08dc5ea9338f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:39:58.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCv0dJtGs+psVX5X94OUfp3bFgFLGWnBTvTpROsX4vOmNGgD1asVWHnxrzRJoBCIy82CSOC3bRHYnFWUW83qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6537

PiBTb21ldGhpbmcgSSBoYXZlIGJyb3VnaHQgdXAgYmVmb3JlOiB3aGF0IGRvZXMgdGhlIGhvc3Qg
bG9jayBwcm90ZWN0IGluIHRoZSBVRlMNCj4gZHJpdmVyPyBSYXRoZXIgdGhhbiByZXdvcmtpbmcg
dGhlIGNvZGUgdGhhdCBhY3F1aXJlcyBhbmQgcmVsZWFzZXMgdGhlIGhvc3QgbG9jaywNCj4gYWxs
IHVzZXMgb2YgdGhlIGhvc3QgbG9jayBzaG91bGQgYmUgZWxpbWluYXRlZCBmcm9tIHRoZSBVRlMg
ZHJpdmVyLiBUaGUgaG9zdCBsb2NrDQo+IHNob3VsZCBiZSByZXBsYWNlZCB3aXRoIG5ldyBsb2Nr
cyBvZiB3aGljaCBpdCBpcyBjbGVhcmx5IGRvY3VtZW50ZWQgd2hhdA0KPiBtZW1iZXIgdmFyaWFi
bGVzIHRoZXNlIG5ldyBsb2NrcyBwcm90ZWN0Lg0KVGhlbiBlaXRoZXIgdGhpcyBzZXJpZXMgaXMg
cHJlLW1hdHVyZSBhbmQgbmVlZHMgdG8gYmUgZHJvcHBlZCBmb3Igbm93LA0KT3IgdGhlIGNoYW5n
ZXMgeW91IGFyZSBwbGFubmluZyBjYW4gdGFrZSBwbGFjZSByZWdhcmRsZXNzPw0KDQpUaGFua3Ms
DQpBdnJpDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KDQo=

