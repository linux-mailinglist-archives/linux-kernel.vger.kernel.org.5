Return-Path: <linux-kernel+bounces-146981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8594C8A6DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64301C2135B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830912FB3A;
	Tue, 16 Apr 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wpMTyjvn"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180812F5B1;
	Tue, 16 Apr 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277026; cv=fail; b=K8bmDoy8wrG0HcJeNEujqSreJbhecl/qYl4RK/7eb4EGdXwpXBZjwkJbv70PVBFOQWr5YJ32pxN3iEHdcWmdcuQnIuUa3xoHwSu84S2x2ULeyc6LCGrZCb9r3uidUQVMpZSlPpDaIX7Dm8o/SmPpDg8KiWm4aek16yb1k5Kt9Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277026; c=relaxed/simple;
	bh=D6WyznDFffnAsIf0BRY50okOg8EJxzhgKqWHiM5ZnVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ft31I6cY2Aye2J5atx3XKvPpDn9rEG/ji/YdMbM//QDGLZzfcimhoUX5xUDhvZzpWsYroL+rlXYF/Dh/caPyNlG+MRDkzP9WvtiiEZXRT3FHKYoH6INraERJIe5LnMgbs4PiIuQBv88OJezBeQ6zxBq0SlxDNP9XyIJVlwMfFnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wpMTyjvn; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G9x5WZ026688;
	Tue, 16 Apr 2024 10:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=llg/miOQwUrk+EEIrCfWkZUM5YxyRxB2pK8Irl6/tCA=; b=wpMTyjvnyaFU
	3nQg9xYMWb4h73Ol7Ecu28AQNt2tTqz7FpK6Vt9WQEdW8JeH44ZZGg5zLdpZiqHG
	jgYNobi33rLNLMIMyWLw07FAWR6kRn1ZC3ADYCWOrXdZQ9JXzD+M77TwRpyXTf1K
	3cQCpYkhPqRP/bwQ+FAnUw6NHbFBsqy2UnCnnYq1VEfZTFnXcJWXQxknvHKwe37U
	EI1vrB+Fi2+SDHX6i881wgGMXlMMAB2UEL6d9yQWsBHn3wZooW1LlzTKLbwGonO9
	H0R3AWVoYYPTv+DhEVg6/weiny0CmTuyVnhh+a1pUUUCzv/8EzNfpGylBz3tt/st
	DGHYeczQNQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xfpy3bv5g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:16:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOo2ohhzwQFHeU0cGEz7JcAmlODOW0L7eHL0rcAhpb+exHE7RvCt1OnVovzcIgFupKc4uYU5hFBy9Smu8cRM7gbHacImUVQrEA8Pik7IlZwgQ8lBjm/yoq5mb+f9AjKxTb2JpgCrtRLIN5a96YsTZT43p1suNkQqM9DHZeUHTKE/gor0fPAFuUmGx9XaeH0LE7KqzyJ87d6wxUQzwPX8gR7bv6sB/vecMrXZNaA9SO5Cw8Vq7xP2QZ/2LTxVmVnIEcSZ29LHly8TjvudP9GaorrZzuELRFBVyu3ahauB/hynzR1ksxQw/bgXBuZBwXHgubC0I42xirJWQdgVRpUEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llg/miOQwUrk+EEIrCfWkZUM5YxyRxB2pK8Irl6/tCA=;
 b=NHYA8kW8pWkvpIsR1cnrUWODxESAcLyZF9g9nZ8I9irFADKOvMbzCXSIc1ESpQ6lkpqUbrC1GUC4RssOTuH3uJuhvMWPxcJd0VgO7VtJpHx0vQZlDHB6JUijaDhlnCFfrfWMq5KMll4aLlsbHGJQXhxSwXQWb6rVy80/BIJLEQi+O00A22FrKPVnFa5BffqoLCVwCmZfHNv9vH0vAUdiYA9sPyplJ8ujlSQv+oCHehP3x7zu+RwTREZARI+1EXEhNI2PCZ8k1aOvCsTHLg/haUxOgrdZRzo21qqNrYQhOLynkitJcG1V0P4mKwEZI907n77oqKDFujpv0SVW09yJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DS7PR03MB5544.namprd03.prod.outlook.com (2603:10b6:5:2d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:16:22 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:16:22 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHajJ1RT0X5TsusMUGJfQChAmxz3bFmS9iAgASOVLA=
Date: Tue, 16 Apr 2024 14:16:22 +0000
Message-ID: 
 <PH0PR03MB7141B31F8D0D061ED2875FE8F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<34de2d9b-c62e-4f18-806c-560ba4474237@linaro.org>
 <20240413155451.65bd32ad@jic23-huawei>
In-Reply-To: <20240413155451.65bd32ad@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lMzY0OTk0NS1mYmZiLTExZWUtYWFlNC1mOGU0?=
 =?us-ascii?Q?M2IzM2Q2NmVcYW1lLXRlc3RcZTM2NDk5NDctZmJmYi0xMWVlLWFhZTQtZjhl?=
 =?us-ascii?Q?NDNiMzNkNjZlYm9keS50eHQiIHN6PSI4Njc4IiB0PSIxMzM1Nzc1MDU3ODQ5?=
 =?us-ascii?Q?Njc3MTMiIGg9IlhRQUE4YUx4dktLd2p6R1QxUDU1cnhubVR1UT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QWhza3VtQ0pEYUFaMGFmVlBSSUhwOG5ScDlVOUVnZW53REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBdnNHSmtRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DS7PR03MB5544:EE_
x-ms-office365-filtering-correlation-id: 27cfb55d-effe-4920-a81d-08dc5e1fcadd
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DrIA2uVFOu5xISLsWsnGxPSg8FenRVFwJo9QR2ha1iMsflWIZvr57N94JSQ3r1ELJYzMp29VSnz2+Z7TDnW9iryD6ctYegJslutKsyLVzcoaKlSUAOV14cqieHf2hjDQpSAHEItnX9LP/Wt+M/bTVdG/FcVTTWouZXZzqLOOG0q8RYz/FX4IDWMD3AU56cKsuR7MQxZYWUGmelu4ja4NGvaKi42P2/yS2HGpKLi02RVx26g7/6Pzk2g72RupTPAPm+3ogJNm6aFqcyKhB8YI23R2peHy75UbchPXCpwSSkyZaArcRRxAbEmwTJ7rWZLSsixSRTUVS42R1ua9Y8y6iJ637Ok9+npSgMBHc+oYEt9i6OhIIVjZOd4JnFjQqUG0NCnqrVlLDf0N/42nxnrCIbALZjIW62dnN7JHtENUYSst5sGR+LZdiBMr4aNgmFgiyeE42lkIRObQFb3b1CRaWDAy0b4OTcZiY74TnFr5pwdj6RFym2+DNaegsUi83Ksu/q8i6Kb98JCJPp5fvNP2y5yIPvzyZeCFKCmKvCAKczfEDHXJHNrgAZT1pNT0GVTQIMRNRM6R32AF8Tg4cuYIV9UN+OQi8/ZTxlmbTyZxqSytIS79HhjgKpSSA0Bzv5bKlYb8cXv0s6MM9HkTTIOyeDqeNGscJCtG3BKWVQ2EABbLDfEuzDt/D0RgjswWM4wn
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ovM0JySipETypggDKKJ1qz3ClIph60K/ndjxmykHATow38L4kW5xwulCeVBF?=
 =?us-ascii?Q?OGdOracVMF/E2sq7ZNaXUhl/2BEK72yJEVzj+oEmDIwcOIKxn9k7+70gQNPf?=
 =?us-ascii?Q?NoYIyyDQxOgALpO90Mk1VdR1jGe4lKMaWYU/6tEs/wT/eHcOLs5hlWco2iys?=
 =?us-ascii?Q?Y1i9q/uzbO2aOQabwtYsnAt94H79PhM8rAZgkmeOXmd17hVsnXyCgkCrdOBk?=
 =?us-ascii?Q?ETz1x9+kKOGcPV3eGWx9IklTK8IWB4FbfWLUnLPlzPOkTiQPLsB06f+DjRPk?=
 =?us-ascii?Q?jYCgY/OU9PRgrNe8R13dh9BOyVO9KEZu+CU9LNTXMmLxHINZ2LuEYInZFza9?=
 =?us-ascii?Q?92oVX2h0BhVmJWLsxQxEbZUTjzPUyMWpaimRGdxZxzyi2R5su3Sk3IPBIm/p?=
 =?us-ascii?Q?2k8N/wxTagjrPDBEOYw/XEz21fUme9EL0XG9CyUwT3qj2ioad1dMYzrnByBm?=
 =?us-ascii?Q?L4A3olYKKmSLDZwnqZZM+73/8Qc6mbaScrKfYxsDI+ZMuYMyXIDw+gVcRgaT?=
 =?us-ascii?Q?2MVOPkMMuGqyNBney5bNDsHwGevnKXHRsBN3EoxtLOVfeOeHKPzQZri38CUx?=
 =?us-ascii?Q?3U6XtRGq3PXnp1/d7HND01xtJLcve/4Etbd0yGY3KChh4PEku/TRj0NPiCxd?=
 =?us-ascii?Q?GFHaxKMotqSfcLpfj3ozlLuLpj22V3+F+/YN0o+fa66qoe44XK2q1Efoy3m6?=
 =?us-ascii?Q?EU153HELkEJ6BwlQ1On966rZzp7cALbjwQIrhL4+LcMe8BkRanqC2tGL+WNP?=
 =?us-ascii?Q?rZ32PHFsWsg5cXuXv2zt7PJpdKEZN1Bk8CTSirAiwtL4B12sqN3rn+f0g1tj?=
 =?us-ascii?Q?LGFJxXzKdGsk6rl1rEbuyhTckSZK2iq0x+IqOzHadVj9m34zwGMlkyd5oMGt?=
 =?us-ascii?Q?OltVgmvAnGyyJaZjtolbMBcD19eCdTbocSsLThpj7PD3VW2MHf/w54kt1sj3?=
 =?us-ascii?Q?bL13YdaDyQv90mpcfWAQPaXKcCUSujxG7uCT1sN8p05nhdg8QmvOV75EDHuu?=
 =?us-ascii?Q?ccsqhDdV2RHfaXqoGHylia/QkuerPQ1Zc4Jo9A2sQ2DmzCr2C92XqR/s7jff?=
 =?us-ascii?Q?txgbO/xhkI/eRXS/+Ph7GBai1X152TbJh7e5rzxo6aW/93t8zthF7//gWHji?=
 =?us-ascii?Q?rlaVCY4WcTAMGYZuFxfV2YJQTHLZgXoLa1VPWNMjyMmxiwvK7lYv4fAWVumF?=
 =?us-ascii?Q?OJ4a8NNVK/iNLLRChEr0Nmc0BzRUHPu3r9f8WoSJPDNUugbIM9QDMCeen8WL?=
 =?us-ascii?Q?evWBfVWOrXdcBoR6uF7uo1KdRLsK37WCIuz/KFyCXMlvXu+0XZtfnqQBSjIQ?=
 =?us-ascii?Q?XXryIQxJ+3GLDaopuEajiJO7+oUYmSDIg74eYS+0zXh/R7snYPsxpYYdH8yM?=
 =?us-ascii?Q?/wGVDNOQo8EHM6YY6GEG2jmW3v1USvkFx/g4RqGe7Awr3UfZxAAgmO7F65qC?=
 =?us-ascii?Q?sRkovMU6+X8V2vuvKlY98f1BGhcB8xsd+y8MGgmwN1hCe/4CLYOJDFSlVBmQ?=
 =?us-ascii?Q?ofPPfnN09zQ6KHm82KdDdYiJZyPWR9sRmvTv5JVY45jbMkVFoAbxOuttCQsc?=
 =?us-ascii?Q?WdJDG7wuoRgSv4mzCexIgwVeb0pnkLt7iieTqDWs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cfb55d-effe-4920-a81d-08dc5e1fcadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:16:22.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FvkqnoweL/Z+o8RTE0CtvVCO0JJR1+7aBmWukgCLupbKuzVGI8a+weChKUzVO/s+0BKaJhao1ZO0ITonwjLlHYhEcG1WrWm4N9LlfnG78w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5544
X-Proofpoint-ORIG-GUID: 3e7a4e0rm78wgwxYi586WzFezm4paauf
X-Proofpoint-GUID: 3e7a4e0rm78wgwxYi586WzFezm4paauf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404160086

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, April 13, 2024 10:55 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-iio@vger.kernel.o=
rg;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter Clau=
sen
> <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
>=20
> [External]
>=20
> On Fri, 12 Apr 2024 07:50:17 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 12/04/2024 05:20, Kim Seer Paller wrote:
> > > Add documentation for ltc2664 and ltc2672.
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > >  .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   8 +
> > >  2 files changed, 238 insertions(+)
> > >  create mode 100644
> Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.ya=
ml
> b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > > new file mode 100644
> > > index 000000000..2f581a9e5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > > @@ -0,0 +1,230 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/adi,ltc=
266
> 4.yaml*__;Iw!!A3Ni8CS0y2Y!8SuDinm690wjc8X5Et94jlV57PAZ79hvsp-
> HRohSvdY5z62lyNXyu4M3R3-BB2PFIqkKsHeFoEJPZzJTgQ$
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!8SuDinm690wjc8X5Et94jlV57PAZ79h
> vsp-HRohSvdY5z62lyNXyu4M3R3-BB2PFIqkKsHeFoEIk1jpsTw$
> > > +
> > > +title: Analog Devices LTC2664 and LTC2672 DAC
> > > +
> > > +maintainers:
> > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
> > > +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> > > +  https://www.analog.com/media/en/technical-documentation/data-
> sheets/ltc2664.pdf
> > > +  https://www.analog.com/media/en/technical-documentation/data-
> sheets/ltc2672.pdf
> > > +
> > > +$defs:
> > > +  toggle-operation:
> > > +    type: object
> > > +    description: Toggle mode channel setting.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: Channel number.
> > > +        minimum: 0
> > > +        maximum: 4
> > > +
> > > +      adi,toggle-mode:
> > > +        description:
> > > +          Set the channel as a toggle enabled channel. Toggle operat=
ion
> enables
> > > +          fast switching of a DAC output between two different DAC c=
odes
> without
> > > +          any SPI transaction.
> > > +        type: boolean
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-4]$":
> > > +    type: object
> >
> > patternProps go after properties.  You miss additionalProperties: false
> > and actual properties defined in top-level part of the binding.
> >
> > I wouldn't call your schema easiest to read. You have two quite
> > different devices.
>=20
> I agree entirely. I think it might be simpler to have 2 bindings.
> If you haven't already tried that give it a go.
>=20
> Note that we can have 2 bindings that in Linux are handled by one
> driver (examples already exist max1363 and max1238 IIRC) as well as
> the other way around where we have one binding and 2 drivers.

Having 2 separate bindings would simplify the implementation. I will procee=
d
with trying out this approach

Thanks,
Kim

