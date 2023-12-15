Return-Path: <linux-kernel+bounces-656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D4814420
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974011C2287B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC318639;
	Fri, 15 Dec 2023 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wm/BDbJO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fV0czXkT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAD18028;
	Fri, 15 Dec 2023 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702631206; x=1734167206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJCidyrGBwyTReEGsZ1+OafNtWAkdqHQgARJOlkmi5E=;
  b=Wm/BDbJOIszdNK9D50Y+8sP/P2lPY1kBbMUiuIdObOnbC4BUcfCisGFk
   fkxUwWdrLUSVIQq9HwsYpIY9yx8vXl2hcRb/EfuiV+4BThW9YyiRlp0Gi
   CCz2hqPXFpMYS9xWKZvNz9YDpu83P7F8IZ3/RLG9YmyAYqcKHq0Xyydub
   x0YB6C81qdHUgzfJRlkOXCups9G551MAZ/qLm17qAjNCaLGqEsmCfsEc4
   zRgpALsIeoLR0aDvHDCiqlS6Em2/+MWkcYNgpqx+x7nvb3RhBqseg5kqe
   n+dBUp2gG8Q0G/Oq3cmUzS5RMuPi3XWwm7A1+3jgG85K0mx3pQDpgMjUi
   A==;
X-CSE-ConnectionGUID: dBibdntLQgCLQdybQi85oA==
X-CSE-MsgGUID: CFqJd89iSdeGvS9JsuRuYw==
X-IronPort-AV: E=Sophos;i="6.04,278,1695657600"; 
   d="scan'208";a="4733691"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 17:05:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6BBpLyIYhL48dyVdkblWIYZwEGJjcIZGXwoyuFXlEySHQ7TlriIeypDwjFekpVx5ozSzUXp34vnPYtYE7eBlhlLR0ruKqb9e60VBp5XOJOnErmvLiYleGryD6fADwcb5MY51fh1BVTPlug/c4YvJpvwvzNMO1ytup3V1vYbxg7Ftw+qkZ2EK//EavddknYYF5bl0uZJRWYnaWUnbkkQwbClbqW53Z5sfFr/N6Beb6XG/ZKzPfcUz/Sn3N8GLy2e50n63dhC5Ca7z+9mn/3yCZjGi9etryAWYDRHBjcMxb4E7pJt4iAD9QKu/94M+pOcbxsbucskZpk5s4519XXr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJCidyrGBwyTReEGsZ1+OafNtWAkdqHQgARJOlkmi5E=;
 b=GqDB0oPqcm7YDj9qQb8gA6xeP4qa8fZ5otBZqbIoCOEbVrnzqVy5HuTU54HzQoatJdYEM5XsYhc1WAl02+1/9+I62CnPv2M3lTstcq3hbAicEWIhaTYPRBohWnujHucmqnTe3NpC44CZ+IS7OLQBFCUBjGM9g3Cb4FahESWNDG59ndeJYkNl22WQTX1cpvParWprEes1cM49hYUSgE65Lhu8YYDaZJBxkz7UU15qtK92IkauxgfmVCB/q0PLz8nm34reVJnkRXeRDEWK7NV1wNq7uZYetpaO227qnkS/4X8gItfyJQQjdDBvy03jZMW7nl6jul17p1pxPBUhY4dK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJCidyrGBwyTReEGsZ1+OafNtWAkdqHQgARJOlkmi5E=;
 b=fV0czXkTNXbvjGcuMMgZGrl44QVK0O/Rpd6eoUb1HUigHlZkmBw5nw1SC7rzyonyjZZtc/01jF2JqUkgWMuC9I2bApPwPXOvytfV7pZXDTP4GQ1QYOt1rpx3NHHTfaGdYxr9SnnhSsFArHb8YH/GXGiOc7zoeAdslRwQ9aRmW3g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY1PR04MB8776.namprd04.prod.outlook.com (2603:10b6:a03:535::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 09:05:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 09:05:33 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Maramaina Naresh <quic_mnaresh@quicinc.com>, "James E.J. Bottomley"
	<jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Peter Wang <peter.wang@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche
	<bvanassche@acm.org>, Stanley Jhu <chu.stanley@gmail.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>, "quic_nguyenb@quicinc.com"
	<quic_nguyenb@quicinc.com>
Subject: RE: [PATCH V5 0/2] Add CPU latency QoS support for ufs driver
Thread-Topic: [PATCH V5 0/2] Add CPU latency QoS support for ufs driver
Thread-Index: AQHaLcIskTdHTr6o2USoTPC7IsybC7CqD4Xg
Date: Fri, 15 Dec 2023 09:05:33 +0000
Message-ID:
 <DM6PR04MB657594F8BFE75A8F68855A2EFC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
In-Reply-To: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY1PR04MB8776:EE_
x-ms-office365-filtering-correlation-id: a85dd349-bf40-4956-6f2e-08dbfd4cfea6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S5Q9wBVUWX5B/tJELTDqko0twBEVbjEqulBCeOW+3B14Fy8yMklKGUf4XX0rQjnkNr8ytgBwuaYxfKnrNDWjWc8Lh8OKERI1yQr9LaEsS3XP6deCwT+uKy5IcIJazXtfwwqKK0MflVfvpZOqVFL3dTrSuQW+bnDQejigv9lw7bo4zrHXlcZTpUa9ZleijTozWEdeHjZd/Kem4zm9iZzsO475Mz4Ret9ThEGGJbkuwNQmnlRw00aj5NlYrTUsmkZBFqIFGjHihOKOz37TsAj/rJa+z9t12h8+Zraj87Zyb8CKmvj5Lh/pE+5LbTkf62Rzl/XFEewsEKPA9hUymYEKiYf/BUK6EqHtBSEgJ+HqKn62CrFa0o2051VriKZ53Y/h/nwBmu+RAmhHuiSNso6X9Gz4sDt32lURp3BEeKnn6+eQrqILH27Y6uGZAwMMtLYpcs1M7XkqLsfzwUkMicUZVQHdZZk6+RCr8su4tn44mZXlgAAsamIvMzxei+TXwFkXj6eTANgunQQS0k+CAGmDs2tphN9WMo6ETjHgex+EziN1YDosWV8uj8TOQBDHV43XNS0zkKZivRBdaLVvna55CLM9mCQuPKst3avaeJuMNqbof/lUoBJrid9v6/Yg63ex
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(6506007)(7696005)(71200400001)(9686003)(5660300002)(7416002)(52536014)(4326008)(41300700001)(2906002)(4744005)(478600001)(8676002)(8936002)(76116006)(110136005)(66946007)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(82960400001)(33656002)(86362001)(122000001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2f1w8GLoCWhdhtJWwCXFtCN1cpvMWJR1Cmbeh1PMPsRdYSrVP/RqDNh4Sszc?=
 =?us-ascii?Q?40wedReXpt4i7NBZWL9gXi3ez2XF5FXJRHOix+iN/7HN48SF/t+xqmUtbgV4?=
 =?us-ascii?Q?Vs8VSvQ1VRQQ4nxYUQJymzuqGloD6Z0rkLC1YkbznO7QoqjPrSpPgiP/PXWY?=
 =?us-ascii?Q?E25qivOH+JaTLJoNk1jQHWWGOzeuX0zJXJyALJi6rQk2lEt4BijSifolSY1a?=
 =?us-ascii?Q?Qt3LWeaAH+HXS4cglC+uA1VUXyZ68d47Tz3KkFFVqs1CAVOlfYw/l3ecsmar?=
 =?us-ascii?Q?EAXHUXBS3L3VT4dO5DtZIqj+Kez3qUAbcOB9Q8EaNPA0qBChIj5MNGWpRjki?=
 =?us-ascii?Q?5/o8gPbZpLvvZR0I/3IPZ9wzW9vciSkG7sraaKk2452ipIixkSgCgc/Ryjrd?=
 =?us-ascii?Q?XNH9dSovpVkHfjCAAS47r5pF8f+hgF3mb171CL/OMwTONDh4y1LpereOBWnE?=
 =?us-ascii?Q?+I0zKc6xqp3fsCMuRWPfyTAYMDAxraEFDKHQ7Y/hSM3owuBmfUTzQga1ZyJC?=
 =?us-ascii?Q?PeJykhwGeUUu0EE9qDJhMoL72kqaXC4zLJoRLcg9eeQyyOzKhzY1MOjpj8A1?=
 =?us-ascii?Q?1Soh3H8KEaO8ewkn6iamADH6lb7V/35CewYqocOoOqnoBuFs/26D2fSyChVl?=
 =?us-ascii?Q?v8ugLuPW77e1CRtiYohRJOjJI5n4utzLhnNmI3rpZ1HjJvo+itzhYmNcNopr?=
 =?us-ascii?Q?FikfXGK85i3zCI+Vp3RzHFX31HVAdqyQM2eiVFFoZliVnrBtZDRiu66dW3kD?=
 =?us-ascii?Q?mmcOaexta4SXMNo33AGMsYjEcfEi2Cpo1BT7iCnV9NgltnfU6ZIE/D+7z+Pn?=
 =?us-ascii?Q?Znks2b/bimI2TEIxtsAmIk1PxBZzlOduLiyUfT2me0SaQRXmEYVtCx8KgzL8?=
 =?us-ascii?Q?IvYAOfkMsHQuXOTYEqaVQCqcNYR8eknWOIIeSoGarEqt8Az2pvM9h45b7BT0?=
 =?us-ascii?Q?6Lo0tsUlMPDdc/I5I5Mv3JGYKo0v+eGBluJbaJmMNsJBVyC0YFWmZBKo60KO?=
 =?us-ascii?Q?umunKT7nGyN8UtS+0BAnta/47DztSCeNN0bcfUnp2OcM9UENWOG5FY3qcDDB?=
 =?us-ascii?Q?WObPszmuFm+6K3FGnbLgC9WeI6jqlKYQ8Hcqi7+IDh9nesjVXDQCIHP/GPOH?=
 =?us-ascii?Q?do/L//55dwIalgpbENbF8KAYrNxNSpWFYGnTONwpk9k6Jev9KpiX9lwAV9O/?=
 =?us-ascii?Q?/jLLAIs8s7/wlwYaR6UKZ2kIq+B4S/8kvKZKTqX/Ra4VAjxTD0B56BnZBZHk?=
 =?us-ascii?Q?pstXdHCglZoyNA8ib1aKYEK3GfJ10ooB9AgjeV7TicJgTLc3zJxPXpZehN/m?=
 =?us-ascii?Q?W8X3gNjZDjdxJu+Es2zqMgWvx9btabyNvLzBef2AN4D3SrrqMLF/O+Z4xwKE?=
 =?us-ascii?Q?Mzs6qIJIFCWAw7N9PNYra605uJX2QHP+19WrXGDiY0wSLLTjRZptZzh+c/4D?=
 =?us-ascii?Q?k6Kbe60oD/M1hCEVrHE2MHQukgx1H7YMeYP4IyHs9ZqxufTQ/Y/S6cV9H4xM?=
 =?us-ascii?Q?aLV9rg5zGOkGjZJ9cBEwm/B5sjvZhcCSUhFcxzt9rZrl98/aN/dfOZaRySjm?=
 =?us-ascii?Q?sYnpmL8+W6ISkX7XgTNYFRphVmTQohSdKZHbAjko?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DQLL+Z0zhLUV44GJLlG9jarELAEWQ7rCj64sU6rfHkMKmeT6cxHB5+QIj97SPqtLOSCpJHsWDTnZ9KA4T7HIN507ruGyN8zh59tjRMATJUGsmF2AEjz2kiBdpYwbxsNw7HuYfMEr0PXOHqLJU2qo32aN84yNU90YWd3St5vDnEh3M24WscJH4HMebFIFSgKMF1s5VOQ74ysoKKe8LQSjMECU0uqlyYGLfUgpMpT2QqNSr12x0/vY9o0lhmtMaZgy8lbuK3gZrUwDh1uBxo6kslx8ZgAB9ObqiLMkqq/H61p1LJHIicwYQttb+xXDhKt+eO7Ch3czIzG3g19xgsrMeT5WW1m+f1V4tAP9ofVXgArvHu+MV44RAyalY2WKTn7dObmYmlS804klbsSV48v2LHObZ5dk13esD3Rwi4IuhyokwLbyTcCfX422WVyuMRskhfSNmw5UcIt6osiBsqJB85n9ZXG3QsUmlgKantHQTg5q2DcU1Tjj72hE9uoFCRBrDI1MF+glxgTVN2Lt5l6oX1dEoor6p4IilahtCzCt2t/LIv5YlL5pbfTa5kxc8D7I0HmIOiOqK9AS4aBhRK/+HERp33KLeV6vTPb0LQel1icqdPLL99i+bR1E/FRkl3FL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85dd349-bf40-4956-6f2e-08dbfd4cfea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 09:05:33.4196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DGRMlW6jk0IhshUS3CT3P2FxTbP+H8mxvfiL09nBxKDagmehbrcHLeOiju0zwXKTQBnEeV3IvGkmYCkUOz1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8776

> Add CPU latency QoS support for ufs driver. This improves random io
> performance by 15% for ufs.
>=20
> tiotest benchmark tool io performance results on sm8550 platform:
Will it possible to provide test results for non-ufs4.0 platforms?
e.g. for SM8250, just to know if it would make sense to backport this to ea=
rlier releases.

Thanks,
Avri

