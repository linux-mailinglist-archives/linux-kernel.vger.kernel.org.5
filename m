Return-Path: <linux-kernel+bounces-93426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B950872F97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501CC1C21E97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB85C908;
	Wed,  6 Mar 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZYjaIEii";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PRKuXxnm"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010A199DC;
	Wed,  6 Mar 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710136; cv=fail; b=JQ1bEUBXNxV0xjXiIe32rJiMZd1oORa8C5C0hLgPe2O7hgsaa2eCwJm3XRit92xt816ZXEk31iN0DzHwtK0mzEZr3NXui7Ao63e4AX7E4JBEPwtcvGckY8ywQK/qYWDAOnuz7zSVh+u67Rvq/DZeb/M/ePQDcD69meWIcUEYybg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710136; c=relaxed/simple;
	bh=0gOjR13HTZJbKfaQqWKUyJol6XLdQkjcglpws6MfyI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NfGHvzcYwwi5uUpqtF1hcSiQWG5goeAzRw8Jny7Eip4a2w9CvJzA3Qb2mg8nWq7x1kEw7mgINvQs3mKIZS30zBLeZ1/bzHAWacSCBtujCmMjMoBrMmVza7+CAVj8Au1l5GRUuYWf/Mt8gR1I5NlXjvTr0sMyND9/vMPVgeHYZns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZYjaIEii; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PRKuXxnm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 28f805b4db8b11eeb8927bc1f75efef4-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0gOjR13HTZJbKfaQqWKUyJol6XLdQkjcglpws6MfyI4=;
	b=ZYjaIEii7ofSubTxcvJ6O8Oos7mhj1mH8m/cpqedAidqkeC1ULU1kQafHSdMrLAp0a1kARlecdbWmwgKFwPT6Eh6U35YqTjYf37kA5OqqUGz/qdTA8BoV6CDsGvH0+3L6R6VoteSRj5D/ki9o1ajA8I98XhnQG1X/Ldsuml8Z4A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:bc9fa168-9508-40bb-b893-404bf03acad2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:798b91ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 28f805b4db8b11eeb8927bc1f75efef4-20240306
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 970098366; Wed, 06 Mar 2024 15:28:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 15:28:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 15:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3sNzIRmddeEIaUu672CaCryhWzaANuWciHNEAT05S5fmuYU0a0OOd4xzzvMKDXb9CJU0326nbrrprgT8nfT2Phzm53GkpQD35TPzFEiGdsoVdqXa8RiNSrxNi147g0KDyRZmF/UlSPVSPr164QE13dstd4QpQZw49oKvzK4c46t4JcwghBOcBq9NPREFJxp6lY4ZWKWMJ1ucoULCg6wK29ovUxlW4pCH98F7HKLKQ2cxAYM9Ekv98N1iGRC54aznpBCfscImJmd9LZ0mny39j5lgd0EpsNRH2kzsPwlh03+Y7rQAnPaKLyWRBDmqwoCm2l4RP/pBoQZKN4DPx1GbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gOjR13HTZJbKfaQqWKUyJol6XLdQkjcglpws6MfyI4=;
 b=ONBfjN144KQgaGWq3AVWNxhJjW/rx9u3Lu3Pgg8rOcKE8RBJl5uUz4OUeoo2xFfVy38+nqq3sIRr+R+GDhuD2F07IG6voCs4xsszQVV3AKFccQ33HwH0fcUk9tm3MTitSTWoUAjnD58C3CSLB4pAQ9NKJ8vL7Z8KiWTdJLxzTecAJtswSf19Yb0sJnjXFP1jBhTVPeJyWyxVyeDvdPIWh4iaeRM+V4v6uxXbKEeADGAWeVq0JMrdojmO/NHhxHmUCldur86GVZW3hg4TFr5zccEzFEISzLdWAbtj4GHTk3xk2AEGlp3kx0tWLKFfmBXCiOLQkVjPggPMQLBa7zm15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gOjR13HTZJbKfaQqWKUyJol6XLdQkjcglpws6MfyI4=;
 b=PRKuXxnmoMi8UGp9jrG2ALXB2jcOL3WyUFsl2BPA9Qg3Io6dAuRPvfcMkxVFsXrEQ4WjVP7OdNBoWTWybnyoyYaI4M+qBxj48dxmQAKfkSESaWM+Stdf6XS3PQFlHYX8f9Qrz71lddxpL98d46Qg8LnRC2/QEzyn+8SpbJqa/28=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEYPR03MB8377.apcprd03.prod.outlook.com (2603:1096:101:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 07:28:39 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 07:28:39 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Topic: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Index: AQHaa+ZOlmtrqOmtQEu54Vg0yp9zebEomAOAgACG1wCAACtegIABCf+A
Date: Wed, 6 Mar 2024 07:28:39 +0000
Message-ID: <b642c63273f0dd25dbde3a48aa61903f74ac6b92.camel@mediatek.com>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
	 <20240304204511.2026a56b@kernel.org>
	 <d0621b969918ef41412b26d7e9a4918aaf4023d4.camel@mediatek.com>
	 <20240305152301.GN2357@kernel.org>
In-Reply-To: <20240305152301.GN2357@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEYPR03MB8377:EE_
x-ms-office365-filtering-correlation-id: 9f81ce8b-61a8-41b9-fe98-08dc3daf0b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utbzDqM+H7SMZjOk5kBqjCG53E/9ZSvb9GEdoG+qqU5Z2WfE+5PhCmhA2EhqjEEWglxhAfv57l+iNuBhBOp5DYyAu91pd8fZwW9wkhYBExdeUXDa05byFNDVEVwvAu6SnKlC0Q/jQUFJhiGP4WILLCYpIjatpq0wOLfNx5cV7oNvCl9zeG/J652aoreaUpMupzZfiV68IwiEcvJncfU0/INzeK9i1GzTX8oKW6AC9gPMSdgmSbSJVXQNnvWMSj1mrYGt5VA8/R43xcCB6mcUwvZ6FviTM4NJnTwPM1akn750DMkKop0jesIQ1HQ2NUnLFHHR65e40Vi9yh8xcHA78TFCi3IKU6hk06uoOhjadh+A/DylV3+Hx2DBSUurUlv2fMbshQw98jTbb8mG3vAOOOfAN14DtvcXJ0obHswgwUUq3ml2HsheZi2riwLBv/YiUWscp/Gu8aHyi61/Uhv1U6Qea/ng/9cfzChcX6Qnc+g6p/5VdixkIb2torhFdZBK0ap7WgaeB/vep+LSXMQe2QVbl4RpQrXa2M3RVtzkjyD7RyDmp749eNJjbaZ/NM1n17G+GJEUJgMlK9mg73KgeQvROtCOcZlY2rhgPbW9b1vEpuRuHmlTYxeEumnb9BwUag8+wTNddsXtj0oXYbdLwRIS0yfawdwa6QdYD1sJWp5gWrUTxp/X0u4L37yMVDOUE2sBECqV6OLf1RSxK5a52KlqzJsMRGWlqLngBODAhH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBVczJ0SmZFMnY4ZzNvWWZJZXZ2UnVhbWFxd1ZkVTdzOGw2bEpFMWQ4OUNv?=
 =?utf-8?B?UC9INTdwNmhGSWk2OXJGMDhwRmQ3ZDlRUHM3Z3Nid3c5OVgyZndrVVVTdThM?=
 =?utf-8?B?YldJWWZ6cEdheWNXUi9Ucmg4S3NzWWJvRmFheURVZlhKVmx5cEcxMTBjN3E1?=
 =?utf-8?B?NHJyY0hPZ203MS9qVEQwbXE4U3pZRldIQWxyeHpRb2wxaWNwWlhlUE5tZGRn?=
 =?utf-8?B?ZlRxRGpCWnZ0ekdja1U5WnFEVTBEd1NWU0Q1U2lYQmhUUTNrSU5CZUhwNngz?=
 =?utf-8?B?T2xDcHU2V3ZQZmJQRk1nZ0dHRFF3WnJGOVVoWnZhWHFxMk50YUlmS1J2NUNX?=
 =?utf-8?B?dmdGT2ROS1h3NG14ZnZMZFhGTnRvYWl4TFVaaG4yUjhpQ1dWbGtUUWRtaUZR?=
 =?utf-8?B?M3BvMXlhakk4ZHVxK0xmMzI0T1RjQXFjMCtXajZOdDhjT2Q1Tkg0dWFwUDdn?=
 =?utf-8?B?ZWJjc0N0bTNubXZ5OTZNYUhqRHdDT2U3YjUwdE5YKzFJdUNYKytQUm83STFE?=
 =?utf-8?B?K3M5Rm1KUXEyS1lFYWREOVR6TEVRZWU3K1pHa1FoeWMxVm42a25uem9jMG5s?=
 =?utf-8?B?V0VmMEZjcVV0a2ZvVzVVQ0VKREx5RVp2M3JXQ043cHR6Q1lrOHh4T1NDQ2tJ?=
 =?utf-8?B?NmNSalZOZFF1TzdVTnJZRG5mQ2hQOEdyZUJQcHpmQ3h6RWVkUGZpUndmcFkv?=
 =?utf-8?B?UTdHYnpzc3QyVk9LOHppbzdxUHI2SHpUaHIxbnN3RTB2Q0tORXgyUmJjbWJR?=
 =?utf-8?B?R1JROWNseVRXVE9SWUtkU2YwTHlGNEh5TGNHeWRiTEpvV2U5YTBSNExtK1I5?=
 =?utf-8?B?MDJWN2grbUFNWVAxY3F2eFpBa0JLeWJ5RWJMRGdjbngvU0dxMkowNWgzVVJJ?=
 =?utf-8?B?c3E0RDlHdGhXeXFraGhqU3ptTkgvK0lPbG5rVHBOZGRremp3RlQ0QnNsQW90?=
 =?utf-8?B?M1JremJaQmFYaTJlVWRaQWJ3eDFKWnFFdHZkemczVUJLVG1RMVZHNEhpK0Np?=
 =?utf-8?B?SEJ0eXBPQWVVaE02dERHRWpvS0h5UytMNHgzczJGaUlzWDMrQmVueHNZMWsy?=
 =?utf-8?B?RUo2VTBYQ1RZK3VhTFkwQUwwUkdGUkdBOWVXZUJmSXlNbklSakRPNXlNYmRB?=
 =?utf-8?B?bElwRU5zTk90Ujc2MmpSWEZSajBpTEUrNEhGbFU3T3h5ZVdxcG5aUkxuS0Yv?=
 =?utf-8?B?bDlud2g0aEZ5cGh0RXpkaFh6bkFrSU52VHJKSHFZb1pzRjdCVFRzZEQrNzUv?=
 =?utf-8?B?TFpiclRSbDdQTkZES3luNWVvOTZkaFp3czhzcy93Q3l2bUY2YWl4NDRDTTVG?=
 =?utf-8?B?MkJzNGJ0Q1hEbkU0TDNoOXRPVndNblIxOVg2NmQ5cWlFNXFlMzdSaWdUUWdY?=
 =?utf-8?B?dy8rR0pDMG5vdFF4ZC9TS0NmNkt4MDNxcXRoWVNCMEpJdUhFUkFMUXFkYWln?=
 =?utf-8?B?b1ZOSVZaY2ltcmtxZGFwRThmZy9tMUZrelUwdWZTK2wzakxkSTBIa0xXclpy?=
 =?utf-8?B?NmlFdCs2VkdvOEVwSnJYWldOaEViVzlXK3EwVWl3RUd6SXhOUlZQaUJaNGhJ?=
 =?utf-8?B?Z0sxMXB1UFk1VUJvRnBqOW1UNWgzcURCM3lMd0dHOEw5UXZVYmFKQVVKVkFY?=
 =?utf-8?B?OEIyN0VpVkJ5K3A3UjVRRmVFOXNCVXBMUnZLd0pkNmNON0lEajdPVGtvTzVY?=
 =?utf-8?B?ZWJjVjk0YTNsVmxGdURvQnRhbnhrOUNFbXdLc1l4QzJDUFJSdzJVV3M3V2xw?=
 =?utf-8?B?L2IwaHFoM0FaZzdteE4yTWdhWWY2U3oxTHY0amFWMWZQWlFZeTdFb09wUGNZ?=
 =?utf-8?B?b3lQT3dpeVhHVUs2aERLZXJSOFVNNklzazFUbDAycXZxNVhTZ2hxaTlMSU1R?=
 =?utf-8?B?YUZLckxwOXZMbENYM093cDZTN0Y1V014czhiYU9WS04vSmMzU0MwQlMvSmd4?=
 =?utf-8?B?WVkwTzB0YSsweTBBNmVMajQwUG9lQXc2dkJnR0l4aVhRQkorWkdaNXJ4WnBN?=
 =?utf-8?B?VWxnMXhFM0dLaGxiV1BaZmNPN1dUSmkxU3EvSExhaEIvUWZCL2hSYlZrdHd1?=
 =?utf-8?B?K2wwUzh6YXNtR3FvSnJaTlloY2VQVzR0Q1BRUW5MNkZ0dHdGUjFtTVYvWjgv?=
 =?utf-8?B?WVZLM1VJanVtUXhsaGJubG9rWm45L3ZDTE5SbHhsdG0zU3A5OTlrSzhBWnhY?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27AF117592619D4AA06F739B41C44668@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f81ce8b-61a8-41b9-fe98-08dc3daf0b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 07:28:39.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/7j575gVeK2y/on+BFmL4JIGgDRZc+1R8HbNURmlO550vH20kQZ3E7a6zdutRVWcb1v0EW555bfh1dUnxwUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8377
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.834700-8.000000
X-TMASE-MatchedRID: VfovoVrt/oYOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0ozSrdqV6z6kcELLYkjA+xd3tJaKJZJX/UdD7MjKedDjtKyif3uAutMj0T
	9QlDgJSbFxyTvgA3mNlgFjOMX/hGMumhS4mc4rHOm/Bn0aZ3AM1AI6wCVrE3vDYbe/PyX8gR25K
	XQ4QIGJrHQw+VXHbtiEbmwOiAcENnwOTPseUY5HKZSuCk/sJbMcmsHQK7cMOffc2Xd6VJ+yj1Mt
	FcxUaFWJZ5+dQl9ac+Rk6XtYogiatLvsKjhs0ldur1QVFMnSQrEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.834700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D8B051529F1CF8C590E6EDAFDB7948204072E44B8E08EB11DC34EF3D4196BD4D2000:8

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDE1OjIzICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVHVlLCBNYXIgMDUsIDIwMjQgYXQgMDE6MDE6MjRQTSArMDAwMCwg
TGVuYSBXYW5nICjnjovlqJwpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wMy0wNCBhdCAyMDo0
NSAtMDgwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+ID4gPiAgIA0KPiA+ID4gRXh0ZXJuYWwg
ZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4g
dW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+ID4gPiAgT24gRnJpLCAxIE1hciAyMDI0IDE0OjM5OjQ2ICswMDAwIExlbmEgV2FuZyAo546L
5aicKSB3cm90ZToNCj4gPiA+ID4gRnJvbTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0Bt
ZWRpYXRlay5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVuIHJ1bGUgcG9saWN5IGlzIGNoYW5n
ZWQsIGlwdjYgc29ja2V0IGNhY2hlIGlzIG5vdA0KPiByZWZyZXNoZWQuDQo+ID4gPiA+IFRoZSBz
b2NrJ3Mgc2tiIHN0aWxsIHVzZXMgYSBvdXRkYXRlZCByb3V0ZSBjYWNoZSBhbmQgd2FzIHNlbnQN
Cj4gdG8NCj4gPiA+ID4gYSB3cm9uZyBpbnRlcmZhY2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBUbyBh
dm9pZCB0aGlzIGVycm9yIHdlIHNob3VsZCB1cGRhdGUgZmliIG5vZGUncyB2ZXJzaW9uIHdoZW4N
Cj4gPiA+ID4gcnVsZSBpcyBjaGFuZ2VkLiBUaGVuIHNrYidzIHJvdXRlIHdpbGwgYmUgcmVyb3V0
ZSBjaGVja2VkIGFzDQo+ID4gPiA+IHJvdXRlIGNhY2hlIHZlcnNpb24gaXMgYWxyZWFkeSBkaWZm
ZXJlbnQgd2l0aCBmaWIgbm9kZSB2ZXJzaW9uLg0KPiA+ID4gPiBUaGUgcm91dGUgY2FjaGUgaXMg
cmVmcmVzaGVkIHRvIG1hdGNoIHRoZSBsYXRlc3QgcnVsZS4NCj4gPiA+IA0KPiA+ID4gRG9lc24n
dCBhcHBseSwgcGxlYXNlIHJlYmFzZSBvbiB0b3Agb2YgbGF0ZXN0IG5ldC9tYWluLg0KPiA+IEhp
IEpha3ViLA0KPiA+IEkgdXNlIG1hc3RlciBicmFuY2ggdG8gbWFrZSB0aGlzIHBhdGNoLiBBbmQg
aXQgc2VlbXMgc2FtZSB3aXRoDQo+ID4gbWFpbiBicmFuY2ggb2Yga2VybmVsL2dpdC9uZXRkZXYv
bmV0LmdpdC4NCj4gPiANCj4gPiBDb3VsZCB5b3UgdGVsbCBtZSB3aGljaCBicmFuY2ggc2hvdWxk
IGJlIHVzZWQ/DQo+ID4gDQo+ID4gVGhhbmtzDQo+ID4gTGVuYQ0KPiANCj4gSGkgTGVuYSwNCj4g
DQo+IFRoZSBwcmltYXJ5IGJyYW5jaCBpcyBtYWluIHRoZXNlIGRheXMuDQo+IElmIHlvdSBhcmUg
dXNpbmcgbWFzdGVyIHRoYW4gaXQgbWF5IHdlbGwgYmUgc3RhbGUuDQo+IA0KPiBGb3IgcmVmZXJl
bmNlLCB0aGUgY3VycmVudCBIRUFEIGNvbW1pdCBpcy4NCj4gDQo+IDRkYWE4NzMxMzNkMyAoIk1l
cmdlIHRhZyAnbWx4NS1maXhlcy0yMDI0LTAzLTAxJyBvZg0KPiBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2FlZWQvbGludXgiKQ0KDQpIaSBTaW1vbiwNCkkg
Y2xvbmUgYSBsYXRlc3QgbmV0ZGV2IG1haW4gYnJhbmNoIChvbiB0aGUgNGRhYTg3MzEzM2QzKSBh
bmQgbWFrZSBhDQpuZXcgcGF0Y2ggZGlmZi4gSG93ZXZlciBpdCBpcyB0b3RhbGx5IHNhbWUgd2l0
aCBQQVRDSCB2NC4NCg0KQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIGNoZWNrIHdoZXJlIHRoZSBz
dGFsZSBjb2RlIGlzPyANCg0KDQpUaGFua3MNCkxlbmENCg0K

