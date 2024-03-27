Return-Path: <linux-kernel+bounces-120702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730D88DB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF26B21B89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9A524B9;
	Wed, 27 Mar 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U5Xt3EWL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="i+Izekgy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B16125;
	Wed, 27 Mar 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536995; cv=fail; b=ucuueVWAoTmr9XqLVdHSC9A8UyDG8bA7XNzZwiV4EogPvLzhZzTXGmRrIsih/xKHP5boU0UZP5jy/1+7m5yP4M8pM+X1SiEP+7hZvKZiJH7Wycy2AZH/vfXs3P0/er/5CCSPigyoVXlUM0HBZmsc1aAwkTKGpNJO+bhY2GjuLZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536995; c=relaxed/simple;
	bh=5A81b3Jd+pFEugl2QoQFqqCQdDga0JflRTiJjdqFYf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jsjn5rhp8Ik8wx8WR/ewWhhTJmJbEawKzsGwC0QrrGh8GvKWf9rPSAuqZs0MRxWzni7hi6lZabnv+80idDvyPoLf8L080/gk8ZbueRQjQt5FzkvkbTCU0vpqzb4LdrDL7aaQsR0QdQj3oEl/xW24voxVx7fR894BKgzIeJpI7eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U5Xt3EWL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=i+Izekgy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a6899cf6ec2811eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5A81b3Jd+pFEugl2QoQFqqCQdDga0JflRTiJjdqFYf4=;
	b=U5Xt3EWLrmYE1EMSGeDAI6ASU4xvN8KyjSne3bIpEvqjAPfqKuDrpeNYCGl/VOUV+q4zq95XQ9kOAhcJbV3nf2Jnjg0za3TkA14fJ4uEDNPReRmrCAqKopKFym6SagRctWwYKsQqlyse1EQCEgMka01FMlRGjgnNFXI2RBdc7Lc=;
X-CID-CACHE: Type:Local,Time:202403271839+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:40455bf2-458c-4425-867c-a9c0f3b0c57c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:34b56300-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a6899cf6ec2811eeb8927bc1f75efef4-20240327
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1029220452; Wed, 27 Mar 2024 18:56:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 18:56:21 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 18:56:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiR7oOy8ASwYxaZZVpBNcUscNZoVRwyfwywAoOkFrKn4RvmahQ++xQKh7DtolzxVY+d/5fiGOXVul4BSEIW5T6vto+s18kclTvt09rB8oSR1H+kD/TRVBetGYHN70vGsCK5G7H368EsJ4JMcUtV7Ae5i5g+0etI9XVVC+zTI/aHdqeSVOcul0WuVHg5LQMYg6BKqSEpFbznq8c0dopwdwtjND+QN4afx/B+1CRbZDYmepvg9qPDSsk8qAlRVagyGov5KrzSO68vFf8qQiqlY4yDBOzrwMmFxUxazZOnurHs2eEO1P+K3nT98mL02t6JrS6Up+Kjk6fetHL+vWsTXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A81b3Jd+pFEugl2QoQFqqCQdDga0JflRTiJjdqFYf4=;
 b=QWDecinqVD8x1H1iUAbddGHlu2F63+ylU7Xroovs+lXeSXclEVEFLqqn/0RMwAW5MGc/2WW/fshnM47fcW/MCX4TgY6Nk6p4NL2NB2zd7+CCPbSL68H8T4N+eU4LrI33MT02AUXpLM1asW/0Xu/GbXVcOALmsvvN2zM0drXwNIhTWXk23DVTixW2g8ojbce+xEvPeAHDbGUn9SQpR+1DFjSMWU8whp5BrdvRy+ljtQym/45zlJp0saxxhakilhua4rlCvcG/Q39T0cQdRQr8PNNP5aOiFIrGyJ+2ypXLsMrXm4XKLgYXL9ZHD3G2I8jAnAaEmRhEZOuQjHo07vd+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A81b3Jd+pFEugl2QoQFqqCQdDga0JflRTiJjdqFYf4=;
 b=i+IzekgyGtuVMGR7pK/3/YZuwUU4DbfDoDt+3ZW6tNN5ZDgFZgFgwe0QXeh6ZIuNTq//3QSvREvvIQXlMRRO94EYQ5iteUQFQC+XStO1hK/AyO8ie0/cjISjd3oczjtMyLCW5MZwOuQ46m0nRjTcum1L0oK7BsAU6w0l8+iBpHk=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by TYSPR03MB8026.apcprd03.prod.outlook.com (2603:1096:400:47c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 10:56:19 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:56:18 +0000
From: =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	=?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
	<fan.chen@mediatek.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Topic: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAMHwCAAAMVAIAABykAgAALJYCAAAEjgIAAA36A
Date: Wed, 27 Mar 2024 10:56:18 +0000
Message-ID: <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
	 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
	 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
	 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
	 <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
	 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
In-Reply-To: <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|TYSPR03MB8026:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEAtqbvHX8TY4Hpawg4FhPh0PlfjboEjyB8kC4n1fjcUDRqPcti4DPRwVwtCEWGGBobW5F4jkIcuAPXG1Eke2D95oKVCZL16BDevN56clTLyV1QCieViAuT2v5QqLHINc9vE7+P/SnWqy8nCWYIojRD+3E/mi7al6IejUSRsGrB3WtlRvOX8s/GV2Fz83aimGhfIhOa1Bw9WUuS4QFyD2oVHz+3uZviFg9aXD3DTt2JcXT6P4SwUm49SuHeF5DxiQZR7OQhtHi1L37Gv7By0XwVmD6tRPT+af8G4lYZD4BHRk/i50oJdP/bNLMCf9Nsu/vpHlTjW0hfVGqXlEa+gM5pkDl+dZdBrCYzaGdZXskJMFZ7F1qeOzFu204Ntw5yp/RNIPQBIsi8gLvWzkxrOBF+EuBoTSKyIhBLli0fcukyWRbAO5fsW5ntzpOuj4FJ7UF+3tLVZFcaGM4sKlQoEUGGSZAqK/o1JZa7jimiJQIRfD6iGkDtpwIsjc7uy+YXI0DtMwtDAyWNsjB37fJgmKhz4jIIZ+OVC+HlNrkVmJbMUaY+BD3lKcQCiTRptr7IC6y7MoP2LsAptmAk489oBne6t879k1MKxK2tD+sNXB9AbjT0L+QLm2b7eAc/ub7VF9B9MXEYyIQ33erLF9L12Wpt0tlsIwvRGEKhzL1DhHW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVraUhKNkF3L0dZZWF3aWFXZ2ZIUytSeU9WVmNHVDd3bFFUazU0VXdCT3li?=
 =?utf-8?B?VHg5czQzL1BoVi91c3RMMmFwc2h5dlloT21adG1XRjlRVzQ5dXNEa2ZyRkdG?=
 =?utf-8?B?UEtoanJ6c0ptUUY1Z2h5U2RGbUtsajJnbDlmVi83NWhubmdwWjlDWVEvREJY?=
 =?utf-8?B?U0NQUEQ2dldNSEp5eVZCbjBiS0o0WjdlN2VtT3V1ak9mSWlOZjJPRkNQVFp0?=
 =?utf-8?B?QWtkMGlzcTRFeEZybmhFazEzQ2FxZFJ4VUw2dVArUnJBVzNvbU9hQ3pnbHM5?=
 =?utf-8?B?ZDlkd3FVRlgxem5sV1k2eVlEZGpvbmZGYmNRVFFSNkZUbERHdkJ6VUpuc0pU?=
 =?utf-8?B?UHB6RFVxdU9zQU1waENlTTJYNHp2aHZZdWVMby9raTd2VXl5WGVSZ2ZHbXlN?=
 =?utf-8?B?MXo2cWVFSDJ2REFBWlpwbGJmUFIxYkZXdzlGZDVnWjcyNUIwWDdBdGlvUlh0?=
 =?utf-8?B?ZXRZdCtLTjAzaGc0SzFhTDJlSmhWRGFXZzdtMHJWTDhxMmZQanNOcEg2WjJK?=
 =?utf-8?B?dzU3UWVHdExkNDJnNmNBM0IxNkJFbmIrangvc00vVWxkYmxlV0xpT2s3cmRJ?=
 =?utf-8?B?aC9saXVJNWpnZVJHdFM1TDBrdW1xSXRPb2Z4eFkvN2wva3VaZk5GOHBFdnRZ?=
 =?utf-8?B?MnJMRjlCZWJDV2VZN29mamVxNW9kUjZCNmdld0NHMXZQYy9uNUpwNGo2cGFk?=
 =?utf-8?B?WUlHRTc1LzR3VkpaODV3TnpGdzAzc2ZaMlY5NG9Na0pxS2h0QnAvSnk2dWJM?=
 =?utf-8?B?Q1RBRFQzaE5TaC9mUVR3Zm41UEhLakcrZGJDNWpUUmpPZmhpNnh1ZGEzbk1h?=
 =?utf-8?B?MDZLZzFESFFFbVdqZ2w0TUxuVkhpZWZYSjVuUDFWZER1TWlKOWE1QldnY0Vt?=
 =?utf-8?B?Y0dYNk5WVTV6QzVjWWs3NXlGN01odTk0QUcxaEFHaUJKRjVWYWRpK1hsVWxE?=
 =?utf-8?B?OEZtR3BEekw2cEN5MU5SUEU2VUdZQUo3SDB5cTV1T3VxZ2RTekNkc25lM0p5?=
 =?utf-8?B?Q0lqNXlOWlFZVDk4MlJkT254RVR4VktUajM0bjlDQUtmMUNFcmxESm9WVlpP?=
 =?utf-8?B?cElJWlZpdlZQQ3h2czJJUEpOOGEvQ1JZSlcyMXU5UG9vQzM4enZRVkFaanBh?=
 =?utf-8?B?b283QlZwZEJZd3VIbnpIVDZLSHZsQWJZd0VOOHpNWXNzRy9zQU9pbnBkbDdu?=
 =?utf-8?B?Y0JhcnJ6a21ZckFCZXg0aFlJajA3VGdTRzNhMmFNSXB2MUVJS2J5azkxZVJI?=
 =?utf-8?B?d2ZTRU9iNWRUZGxZM0FyaEhJbmhNekN2MVFka2M4cTVmQ2VTUFBYMVpCcTdT?=
 =?utf-8?B?MEdmV1Vkakx6UlB0QlJSLzZSdTVHd2VWNXR2V0JGSGlZWnBaMTcwM0ZaYTdn?=
 =?utf-8?B?cTlDT1dkZEQyNEFMVlA4akdZZ1laVzZndU56Q0o2cTEySWhCakRoc2lXcXdO?=
 =?utf-8?B?VVdUbTVaOHZOUkdKNXdyWlUwZmROOXRsN2d4ekdLN3FxWXNLZEpobU9sdWtq?=
 =?utf-8?B?NUNhVmExUDdiZStLZlYzRmRzTUdhSkhFUGptUFIvcjFVdTludDZwZFZOMUw3?=
 =?utf-8?B?bjMwbmU3R2dLZW0rVkpoamhiTWxQVDlWWVlIWGJ2dEdZOXJLOWtZYTZRZnVZ?=
 =?utf-8?B?VUg0dEYyQ2laOFp6UnlLNUc0c3ZwWS9XQkdFVFlWTHdiUUQ1WWFlRGVrUnZh?=
 =?utf-8?B?aGJ4cld4NFIxVGtQL0VHMmlRcUpzVmpyRU8zZmEzeGdJZEVlbEVpNjhTcFlP?=
 =?utf-8?B?M2FmSGFRTWhnR20vdTd4aGwrbXVkUnUxUnQ0UFUydDNKdjc2ekJ6WUs3dUZX?=
 =?utf-8?B?K3N2UmZaWEFGdFA3MjJyMmxRRCtuREU0Vk5hYytJVVJiSm1CSThERUJKcVRS?=
 =?utf-8?B?Mkd6RDFBUmpOUisxMkJRdGJsNGYwbUdRUjZJUkFWR1c3RWUzMzQ0Uk1rdVBq?=
 =?utf-8?B?SW5ZTklReFgwSU5kS25aM0VzVXluc2g3ZTRpNEcxN2F6NXlaU3J1STBUaXd2?=
 =?utf-8?B?T1lwYzlpQ1pUYncxZ2Y5V0s0SFF2M1lUYWVjMEpWZXU0ZjJ0UkZ1UnNvRFdY?=
 =?utf-8?B?blp2eFVTL1hzdGI5LzRhYkczQTUvWWFyRUdQSnJMa0lVWU1RT0VwTTY4Znpw?=
 =?utf-8?B?WktwTXlUQk5JSzF6RkxkRUlZQXpMcE1ES3VCSncvaDh6K3JNU2FYeUU5c21C?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AF5E712BA6FA74980BAD5B02E8A778C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8f5beb-8f82-43d0-d2aa-08dc4e4c87f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:56:18.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7X/gUo89gmwDbaLv8jobxZeIFkVbIwgnp1vCTFqyDKeHNtZ0pbR8mRsc46J+lJ+nn3EADpkdBKzFyQQJIw110vaPVgzxlaCHPN8iLPcYLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8026
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.041500-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpE4FU2ZdQO4y7TSWcbz49bZph2fCfuod2HtZs6e3ZMHkqO
	2AbVSuPzjDkYgWyJB2QUs2YxOrR9f6Ucyqoets+yrVklnbP5Jtmpiq4KsutXCwj10jtt9j+8l8z
	CaaA8qkzFN3I4W5D8kFi8i1ylBwCRhgXuWXN7TdiVypP66BP0QQxhbwXgdp1y7+NPPxj+R6pSEm
	VZ+AdmU4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.041500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0C740AC6CE56BCCE21B0BE0A8C36445833174652045F0CFFFF6E8AFF416BAEA12000:8

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDExOjQzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzAzLzIwMjQgMTE6MzksIFl1LWNoYW5nIExlZSAo
5p2O56a555KLKSB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gSSB3aWxs
IGRvdWJsZSBjaGVjayB0aGUgZm9ybWF0IG9mIHlhbWwgZm9yIHRoZSBuZXh0IHZlcnNpb24sDQo+
IHNvcnJ5DQo+ID4+IGZvcg0KPiA+Pj4gaW5jb252ZW5pZW5jZS4gQnV0IEkgZGlkIHRlc3QgaXQg
b24gbXQ4MTg4IGNocm9tZWJvb2ssIHRoZSByZWFzb24NCj4gPj4gd2h5DQo+ID4+DQo+ID4+IEhv
dyBkbyB5b3UgdGVzdCBhIGJpbmRpbmcgb24gY2hyb21lYm9vaz8NCj4gPj4NCj4gPj4+IHBvd2Vy
IGRvbWFpbiBuZWVkIGxhcmIgbm9kZSBpcyB0aGF0IHdoZW4gbXRjbW9zIHBvd2VyIG9uLCBzaWdu
YWwNCj4gPj4gZ2xpdGNoDQo+ID4+PiBtYXkgcHJvZHVjZS4gUG93ZXIgZG9tYWluIGRyaXZlciBt
dXN0IHJlc2V0IGxhcmIgd2hlbiB0aGlzIGhhcHBlbg0KPiA+PiB0byANCj4gPj4+IHByZXZlbnQg
ZHVtbXkgdHJhbnNhY3Rpb24gb24gYnVzLiBUaGF0IHdoeSBJIG5lZWQgbGFyYiBub2RlIGluDQo+
IGR0cy4NCj4gPj4NCj4gPj4gTm8gb25lIHRhbGtzIGhlcmUgYWJvdXQgbGFyYiBub2RlLi4uDQo+
ID4gDQo+ID4gU29ycnksIE1heSB5b3UgZWxhYm9yYXRlIG9uIHdoYXQgaW5mb3JtYXRpb24gSSBu
ZWVkIHRvIHByb3ZpZGUgdG8NCj4geW91DQo+ID4gb3IgaXQgaXMganVzdCBhIHN5bnRheCBwcm9i
bGVtIEkgbmVlZCB0byBmaXg/DQo+IA0KPiBQbGVhc2UgZXhwbGFpbiB0aGUgcHVycG9zZSBvZiB0
aGlzIHByb3BlcnR5IChob3cgaXMgaXQgZ29pbmcgdG8gYmUNCj4gdXNlZCBieSBkcml2ZXJzKWFu
ZCB3aGF0IGRvZXMgaXQgcmVwcmVzZW50Lg0KPiANCg0KSXQgcmVwcmVzZW50IFNNSSBMQVJCKExv
Y2FsIEFSQml0cmF0aW9uKS4gSW4gcG93ZXIgZG9tYWluIGRyaXZlciB3aGVuDQpwb3dlciBvbiBw
b3dlciBkb21haW4sIEl0IG5lZWQgdG8gcmVzZXQgTEFSQiB0byBwcmV2ZW50IHBvdGVudGlhbCBw
b3dlcg0KZ2xpdGNoIHdoaWNoIG1heSBjYXVzZSBkdW1teSB0cmFuc2FjdGlvbiBvbiBidXMuIFdp
dGhvdXQgdGFraW5nIGNhcmUgb2YNCnRoaXMgaXNzdWUgaXQgb2Z0ZW4gbGVhZHMgdG8gY2FtZXJh
IGhhbmcgaW4gc3RyZXNzIHRlc3QuDQoNCkJlc3QgUmVnYXJkcywNCll1LWNoYW5nDQo=

