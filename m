Return-Path: <linux-kernel+bounces-86127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0086C008
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98B8B2458D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5C39FD4;
	Thu, 29 Feb 2024 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tTAGz0oA";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NGYGfSyF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24138DED;
	Thu, 29 Feb 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182643; cv=fail; b=WwVd7O2l2jz7xIjRtD2KV5/Mrt/uR/8jwiayEsRhrVhFItR5PFhD+z0BX8e9DRxXFaour29ZdnsMQWwQlJjuiQjaJG4xoOWRl0gflAQbM7EVIgbyIek8ZpMA9CnDR29wwWeTfNslq7n0Un1qiFqiEFdbKOstMuO0/1uk4PDJe5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182643; c=relaxed/simple;
	bh=DJSxogogmskvIHJoeTepQ9k1MK8RPZigdOk+zwjmxdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=duDiNzkkK6VxoLv0qirxbpgnrCDCwn129anbvz1aJ+evcIvQT7mis5glOdnch6wkpdQX7RIuFJtOSBYZPkLJDAWd+ycv2SdT4uFXGCEq4XaB942cAjWnV7igCUxEE3tg5pf3W+0XqqfDS1IIEVRBctQdf5BTsUGwOsr9h7x4nLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tTAGz0oA; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NGYGfSyF; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709182642; x=1740718642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJSxogogmskvIHJoeTepQ9k1MK8RPZigdOk+zwjmxdA=;
  b=tTAGz0oAkIa4qB0EHWtSeZQz46JyC64S1uMOFFDI4VRn1zxtPKfwe9Hb
   /Yc8pHaZzw4ZXIxqr8YAlc5oHOwaTcbU3UK2obwOLOxhNxyqZ9ZQTj7+Z
   lh8IFpb0QBAqjEqT6zp68ktKY+D4VNsjC1K+3nE3GjWY8wd8gbJU+vJuK
   NztLbyMDOQYOWi7Yl0HYOJVNfNs+Z8NXORR+p5TkFCanYiTyZZR4Jj0Xp
   CTsWurv98SB5VyKBEaSGXe96CSFxR0IzdGGV1PLx5/9NvLyfFPB/ool9A
   CG/nXNUcy+i/AZKws4I+oHf0bCkgodgTX2X+ljRYjdfwVSX0CK6SlhEsn
   g==;
X-CSE-ConnectionGUID: KmAZlqJxRBWfEL8GLGBcOQ==
X-CSE-MsgGUID: sD245cZPQNKBjCm+mk+L7g==
X-IronPort-AV: E=Sophos;i="6.06,192,1705388400"; 
   d="scan'208";a="247743891"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 21:57:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 21:57:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 21:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXYJ0+jLpUJAKZsGkMciEVtLksPj0t7ZC5+ZTPjh85cTd/K7N/DHwK1sIVNF1udv/OmALCaw2Q7s/CbXy+GguzwbNOS82xPc1KVLR2wDFFp4lnqeo/cKmWj54SGx6fp2Loh6yp119V15ybDl9uhJLfZhNyCAJnoIje2piDYTR0Yp2e9mW4yNO6sUfaCtrK8DDfdzz+aGUW/lqUwMhXbLELuF5qPubdy6/a2cf5cfA4JKi3+OdL43rL9hL/trxnyx1itktFaMWlwP9tGVSlOLIaKIvRSLS3k+kgQLiOPN8ZYTjbOvW8plpGqlq+Hmq5N8lyTyRRHaeLNRqrx+jX9XeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m94QqFp/dmrcbZfaaX9kcG5dIhy01oWNSRvEp0IaKEE=;
 b=CleqqAEsiBeDUaOiPaf2FBRyyVv9G2AjWtCEnzhMM4Yf6xkeEAQtSXLpQw/70EZF0pKXcDSBiEPAuMzXKRxDSTfmb3PGKqTVwe+mt/PMgVe4nUxecPHRBlR0qzGty4x9O0JePQtUTZCF2werhSzHIR158klug0kOKVbGuK5zLZcGhBEYWOd5IXKu1Y2G3slubl+tyAKPTWFJO0Z9wWOz1Vyh8eVws0A92Z/eTVbyplcLiQglHJIY1048CYMG8GZezYa/IvLbOpwfBmqIkSdgPCJCQ7CiKcB3S13OUqj4ToJob4l3pY4nK1v9L/tjOP9oxokcFZODkoxQF1ZMyo4OFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m94QqFp/dmrcbZfaaX9kcG5dIhy01oWNSRvEp0IaKEE=;
 b=NGYGfSyFe50oca2rSzOlJb1E067Tel+Q7KaiJ7Z4eCd92KgRNLKVtADUuWLxIlwRcxZnk9Q1NFFm7hnrSeHlLJnlFAHYItwueOogs0nq+YYgqb5gazRZ6YxYrfkiL3P7I8pHgSOCRh24J8he2I3Jcn7yJg2adMm2rB3uRHwgyfAmnkB3SFnTtO8WWObpzr7hbYtfva5790nLvKwfNJlHjCiHM0SzlYTJN6QNXzZCfOjOFX+UrMgPlWQd4h1CXcq/zdrHwfBPeF+HeMLv5jrMdjbAMsbZCAgqU1UG761R1T6HXu4Or7D64QAGq2WNHtOzmpLOoyDhvIGgcYl//eVKOg==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Thu, 29 Feb
 2024 04:57:05 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7339.009; Thu, 29 Feb 2024
 04:57:05 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Thread-Topic: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Thread-Index: AQHaaIt4JiSb9wlTL0mxkmItOFoCmbEdakoAgANaEGA=
Date: Thu, 29 Feb 2024 04:57:05 +0000
Message-ID: <LV8PR11MB8700B74600C2FEC3687D2B379F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>
 <ff0cea8c-5aed-431c-a525-210fd8c10c31@lunn.ch>
In-Reply-To: <ff0cea8c-5aed-431c-a525-210fd8c10c31@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|SA1PR11MB5873:EE_
x-ms-office365-filtering-correlation-id: ad2edc08-59cf-41a5-ffb4-08dc38e2e051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9IFN8BvJ89vwXvqN3ater/IypnmSBdyBuSsKt2ZkLFXxdufcdNZ5auIOYmQA7l1Fvas6qE+VtJ51JyPKLcpBIqHG6YfnThT2xE4mJUW7UnBVD27htyLt6Z82Dh4NAXbgBWefKNmY+xTdtsQKOHWsb6XJdmp670Eutf86JBL23hOkekRYVNLFGm9fceBiaK9/zCwnyka1sFaW6QN9RIs1ahIVIy3Vnlq6dH7fHitVWHwEztcTHexyEiO0/8QB3aiZiRTGtfIcGhnWjUPJQQrj7TIAPEjuWNrlPz3pYtECmA897/QVR25fzGFlFxAnCO373Le8lIoWbx33QOw4/w5u8+TnSnHCLezZ0jl+IRJ83q1lijSxu062kINRf+QZTuxGQFwGAon7eMPySLyCJfPTbCJ7VYrziv+MET9oPtoeEVCLpNWtK6nMSnFvlsPuK9uxBDnI0PRg8nLoixk0TZQirHGEuVT5S2Egg/TsAETdJfuBo6TTnMHP+I2+neafX+agx4LAmpatz0VXjmdH8kXkx81QERqZz6oX7oG2IwyTbFrUluhBP/LyRUr/K7GET9nwstKCrw1dHw3qG+a9lgG0c23LsZDaYnQ5KX7Vrou+0K10MnFCOJF780JIktm7tF0ek9YjW8Z6mGJY21XuFmKJ9jT2K0LVDWTtAXC5IczeY3xr5lpkeKa+poDNlmqTrPwtF+kxC88rcKrzA5W681M2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FKREsHzOG7f/tBCcwxamKEXmgBjlnSmWG69EvovHHEf5MpdP/ndnPQwsRXBz?=
 =?us-ascii?Q?LXaFbNqphxUM5ub9cX6TsBuxTRPrxWE/Zm0SR/Ustm560c3gKvlDaBCwXhgp?=
 =?us-ascii?Q?ULAEIXkduZKrVMApu6ms5PUO3tXz+ojWwPs3KkYO/rYBuh2oFdPaX3Si9VNC?=
 =?us-ascii?Q?N/Jrd92sUz9XgxSBbBgU6d5JVvxC05f+n6F+W3f5lm53cPjO0aObZyx5S/AZ?=
 =?us-ascii?Q?qvOMCQQSwHQD32vXz/+WeNMadj7GB29Ah1+aggPRc6EGUHEbx3CCJ9piMvOx?=
 =?us-ascii?Q?JPF+sVo0m9zw/Petgra3sepxoUSJM1aYUGNk+OMKi1TFuY5/G7hSh7kRIhzk?=
 =?us-ascii?Q?isQ8rQD3rZ+6d0LxJpq65heQhLTXtiNepe4rHTUFPyHugCm+JPliz/5XOL2T?=
 =?us-ascii?Q?Ludz9pK3lWbJ9ESKd2MbkrLsIaTd1zpSPAN9TxTbwzSky9W7ux47YXg0gT86?=
 =?us-ascii?Q?Q9NJzEG6fsRRZ9i0p+Fr2e4NHYNHiPVg6W1BOqI3cUpC8OziNHTfCWO97MnZ?=
 =?us-ascii?Q?YyDnlgEMuvZvLJpIWAJaNNCgIqaY0CuM1EwEi2L8QyfIfDbnSoEYkSLZ2yaS?=
 =?us-ascii?Q?pclzw0o9v0jVXrDZ3JbwQF8OUXDlUVnaY0c97NJNYpX0Batj4XJBgPpo3cdI?=
 =?us-ascii?Q?Rz9u43vlJ23Y5pdZr9daWDTYKdACqpLVb9G2AejVITCh91haOG3z/R1E/xW4?=
 =?us-ascii?Q?mtr9m89E3XGHwG+OMIYq7n+XHZGpeFvzGR35S5Y1RykXct8WigENbjaLYYGr?=
 =?us-ascii?Q?wU3QGhzTu3LEgxdT3H2sSp/GJuWtCn/cqEkjEcLWaziHBA1LN2/0ksuvE2qq?=
 =?us-ascii?Q?0K+hFwG7Zy7cVBdviRySeRPfw4jJoJhzwQwxPD3PmAhbZ90TTyq+QMIPjrNs?=
 =?us-ascii?Q?fWSyZGBswi6z62TZPbmgIF1G+9/XApxwDTqbzKAirijk4kXcEqpG/50GNVmT?=
 =?us-ascii?Q?WEiCZtWcv7p/KjPoeC9uwZUaIirOqlzkwHtYiTvGUSH3lf0Zdvl9imaS3fPc?=
 =?us-ascii?Q?p2aVyTYE64VizuMgmCTwqiwBA0GKztuMTJvjJbedJuVYvmZzOBmtOimLk9eY?=
 =?us-ascii?Q?Zi9EviBdv84T/zBl2gwBUo1S9+5BvEg4yusTBZbbyet71c57gO2W3HaxqZcF?=
 =?us-ascii?Q?YixTq2N6SyBN72Uc/+0Ki7LkJbzHyWpjwpYf7WLVCJgsRC1/0wqYma1WVqJf?=
 =?us-ascii?Q?4/dCXZIjm3gZnpYmo4vGStt/LYa695Hhh43yw3TGBztyI6PMvReJGjIA1fV5?=
 =?us-ascii?Q?L6X60A0oV7+5IQ14a+165kOmW0+HTqTtOF7N0+FW2FmBoeqLpLrhMBbHZNHH?=
 =?us-ascii?Q?yTu+2cSb6gpn1gszzltZ1OxIsaN76TV83BjsMEalbZKEcEe37IjhAQiSgnTY?=
 =?us-ascii?Q?OLTEuiHwSPFIdsuVsmLu32pbKOMtSdglmZ43eZ6KfJ/5WK9CzgIwKoUJ2SvW?=
 =?us-ascii?Q?/wQGnAp/vi4FW+hFr+gBLpJJtzs/qRCVUAIXfVowMACgWUj9x0BsRk8IH85w?=
 =?us-ascii?Q?yUF6XMLq262kvVPVyWYPD02itt9rJNV95AVJRIoS27w/UfGA0lMwjbqsPtgP?=
 =?us-ascii?Q?FkyLOsYR+jN005jWSJO3jnikjyTPNLfubX11/+dvlZttq1pz3/0qxckrcaPU?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2edc08-59cf-41a5-ffb4-08dc38e2e051
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 04:57:05.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sg93+32K9YRZgPcJrNa+QCq7urDSPkh0MQQ32krjPPGheWGTRDiY8w6UTcGI11wsEbZCXGSggtr77xUauGfsmucP3B8Ctw4882abqBEPKIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873

Hi Andrew,

Thank you for review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, February 27, 2024 7:09 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; linux-
> kernel@vger.kernel.org; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net 1/3] net: lan743x: disable WOL upon resume to
> restore full data path operation
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, Feb 26, 2024 at 01:39:32PM +0530, Raju Lakkaraju wrote:
> > In order for datapath to be restored to normal functionality after
> > resume we disable all wakeup events. Additionally we clear all W1C
> > status bits by writing 1's to them.
>=20
> Just to make sure i'm understanding this correctly, you are just clearing=
 that
> there was been a WoL wakeup. The WoL configuration is not cleared, so i
> could suspend the device again and wake it up with WoL. There is no need =
for
> me to use ethtool, the WoL configuration is preserved.

Yes. Your understanding is correct.
WoL configuration is not cleared.=20
This clean-up helps us when resume from sleep due to system events.
There is no need to use ethtool's configure WOL again.

>=20
>         Andrew

Thanks,
Raju

