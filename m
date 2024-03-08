Return-Path: <linux-kernel+bounces-97487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96640876AF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003F4281FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AA58132;
	Fri,  8 Mar 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DhIxn+UE";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3QjxS+a/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772040865;
	Fri,  8 Mar 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924220; cv=fail; b=gjz5xiCDEgqaqjiqyrVq52wiImrDRD59N6cLIjs2COh6ebJ9KbpXxogQcFfQDnbd9NqcBSiwnjZgbRJAeYKhWRknfH0RY9rL4jli9KLqlXWgqzqoiKeRIQ4Z2cWeLI/11+uEnoIMzKx9ae9NXJQcir1GoxbQ21x8diVrc8SdfMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924220; c=relaxed/simple;
	bh=36M8OtiXv5x1ZlrrZwHkXSarknCiLNVF/63/mCIgfns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IxpKCHQiJqCrH8GfMicA+uIDg1Zk9BBAEETEVItN3Xq9u4Dmt5dTlGRuy9FTOMii5qBggjLCRGaG7wZ15pUe1NnH/m8UaqIPCws8UITkwplsCHnQm275MzmMS+VKSkaX+GbW6r4MdrzPa0l0Rh4qCnsikSIx/CuZAuNIfLKpXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DhIxn+UE; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3QjxS+a/; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709924218; x=1741460218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=36M8OtiXv5x1ZlrrZwHkXSarknCiLNVF/63/mCIgfns=;
  b=DhIxn+UEnHTxI0STmYOUb91lIeZ1Xzh6m9uWOQc0crsU0oHhNHX9pJwo
   40DMm2x9rMFU3aXq4QJoLmOjrJEm4eeHec6onp9PxdqtNSaQUJCUmxlSK
   5AbyVhxopkFUwGpnV7RIhz1ObOUNITr77sTdQqhXvAO3pwamf48JWQGir
   PlkzPWZYiqizElrHmXcsEt5wbqPUEXo5058M8RSZTnib7WTmIYQEWN6y7
   nh5L53IIVWyEiEJ92Z8Rh7G7RfcQRiwYg+EGg8XLEcYhDz7mXbc5jw/hC
   QswtICe0CtMYK1IduRw8YZs1tkNQ0lMdGlcBK112E3Kik5kwF4ZyguDhR
   A==;
X-CSE-ConnectionGUID: sS5AqeNrTWy8AXHLRFkCbQ==
X-CSE-MsgGUID: zST8KQzrROWCldncQb86kw==
X-IronPort-AV: E=Sophos;i="6.07,110,1708412400"; 
   d="scan'208";a="184687784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 11:56:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 11:56:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 11:56:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAtdU1d84KJ4WE6hw9BtvWFdhxdluPHhy7PKlyJ+L4x0gavcZ04es9cGQANNnZQkV97uIS6F022ZfcDElw7cLeg+yFNtihLtUTzhX9SqggYAYt8CAUVNDzqt0YGvlTnKB+htftS9q1K96Nq+jZF4mSXduHxO5oEgh+oKX+pGQ9xU55gPWPkAIrUEbewCA7p90IinE6G+lzIWvyInZeBd2iYe4ZaidNxNYuhUqXPqYlkYMcSQ35qvTeJFeJ5yL400pT6LqDDDIFE8MDQzGgPRyd6a6bSnIA6Pejq2MCwX6Gpka60zs4sVUIOap1XDVoIq63IXCsT6dlum7XRyBi3neQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7PaJ5nxYaLJI8sxcggwOSNAMI6twTF5fdbNNq0LRWo=;
 b=brQs5akkWWGG46aKJUYBYRT7hBBiI9s8OWMEgFJGuAddKBAZXArSCJmPfvbojqP22Comrgy2kTzpUJ8UirfKx00PpUVypVlIne3ZnlcQGAE/Q9N0hnQ1XZMDJMbUe5ycHJcais/nVRF/zqUicOKaBH/tGGEObwrVRV0Ku3n870GjC61n3itqKpezBIi+Ggfcc4melV+0U78V0LlLpiPXUH2bGNRJehjJGmn40SoZEsfHOLHL4vKqrEJ6+Q8/+CzS8TUrVOfPMnGXCtlUR48loLmjjrmCI0sIC4Df6Osm9QfmuyIGlBofTzXiswc3WfY4HiCyjIie2GjT0V7Dswbmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7PaJ5nxYaLJI8sxcggwOSNAMI6twTF5fdbNNq0LRWo=;
 b=3QjxS+a/0c12NnVzWNeGBSAppo+uyyzdnED9rwWNox7WaiO/lpxNivHqV8E8sijn4hfOyJ5fGMogBrD8k/BsNqaGUEpryiSDyZd+o1vO2tRL6NnJSOOeoefwZOQ22KXiboNfonymTcYUvGrVkXJdbPtlQzRdqzydMaKlJ+Bbo36ieeOJd/UHVict6Q4MGm0A7mqtamyPLBWW+BdAxUM6al1g6OtrCDNoMUR2eSoduIGR+c6Bix6LoN2zExxMxnCSVZNtgfsYrPQztY/xdTJbV1nLuvmtkW4K1t9O7Rbmd1LlXN5yGYwICy2E0jOgGt8qxiq0KnSDPaIbvjPLusvh8Q==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 18:56:39 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 18:56:39 +0000
From: <Ronnie.Kunin@microchip.com>
To: <Raju.Lakkaraju@microchip.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Topic: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Index: AQHaaIt9/9VvJ3PDJ0OgsYtGoeCEQLErcdiAgAIgIYCAAJu7MA==
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Fri, 8 Mar 2024 18:56:39 +0000
Message-ID: <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
In-Reply-To: <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|MW6PR11MB8392:EE_
x-ms-office365-filtering-correlation-id: 57a8af67-8e4c-44e0-7845-08dc3fa17ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVT683025I+glF4ME0RVrzZnMcPspiR3gET3iWIvs+wBmucLEEJOjxOxwIeFNtdOgxkoA4CwkE0kEkDCxrSVEHGLdcXf4nGwuWwARAQo1hKUF4mz09MaBHHRQjSLFM6d6sOEbiB8PilKz61thD4FgI6k1Bwm2FAyi69xSO93UlaPm0ea4dCkuVvdL+wr9EnW8dP0Vli235nz/RPxdmkSld6xYwhG8h8lASZuVfLdLkO12qAJO85vBt72J4itKPJX3lYzBAldQAkznK8CPZS7ZhFIA5+LBZyTC3nUUCGr/m2yGsiakOtd9OXOLlKaa66ty133HKOHNHPnweF07wy9vmbfH8tTByqiBiHk2R9IZgCZk5+whp6k3PzMJbAR9sHdXg5c7ZrQju+hUmw/qVIg9/0CX5rQUMSYLb1K+4EbpLQHnroSRijv+rD8COQXBGeNqdf6Cy9jbeZVQIOmzK4csRQUTVwkUNFVzwRuUpbQ1jYin2Xc2+R20Wja1rGf05YYaszXwpTzjtdLBrvcRu/HZDd0h7B0HxoUQtsnUGPwmOXzcF88ZdYCOE7xvakZUNTA3bWIfF+56kDfJ60ZVIHnzZWX5TM4SZvM/y19N7ir55lKYhe6/ExuBv/yBCf+ptOCxLcd90kgIc2OY6m3PVAdIAjlloysq3RnzijhwXKGezJq6cywHNCXcajY0md+qicf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wesaNpZlIHMygpH/3zEl4d/h3J4whXYHlVtw6qeOA/kh9FDQiUBvT6p1A9kS?=
 =?us-ascii?Q?dPg8MCgKlkhBnGfhfFRUzAzVPwzcP5oG3CC9HqAjU/fZH4UOGLcD/sxtURXJ?=
 =?us-ascii?Q?O16H4Iy/fsKYeNNjb9aV9jMTE2drrqKHshjR3QKcrJmKYdOiea7LFsfDxrfI?=
 =?us-ascii?Q?bLyi0uqHk8XGURJjC3haEquU5ngiuP2pMrq6GxwLh+NqHx7sl6avxQ6zb4pi?=
 =?us-ascii?Q?XHtd5eRLE4+11cubEExQ3MVmthgS1aw4+l+d3dMNu04hXXeZYW91ZbyN8Ooq?=
 =?us-ascii?Q?K4MX+8TbBp7fVGcsWp1cdrH2zibI8olUIP3D0z/UTZVr8TMEC9NewDeEfKKQ?=
 =?us-ascii?Q?fH3FcWNm4HjZlkRffYsb/yGhYcanG/eIqyB5Ht3PMfllAss2ZEbNt2qbMMME?=
 =?us-ascii?Q?lk2ptWUfIT4LBuiRme7bd+kuhqV/EcgimkVXHdUNixuOCowkmWFdFU9K2Y4A?=
 =?us-ascii?Q?3twFt8pEkLwI8lcwT9+AfJgVrj4UrB+AeasoyhhvvjaKyr4ELSfXHJTJ7F52?=
 =?us-ascii?Q?XUPlvGwqv7eodUG/YEpQC2LxXlllUc3m/fU/jiOvGxBYOJnya5svb3tvQjBp?=
 =?us-ascii?Q?zokS+BVhc+ge1zBXEew6BY6DZ+UlDDBMMT6iV5rWxVuIKxJ+QzxyTtTl8cR7?=
 =?us-ascii?Q?NcsiLQftToaimqU1zajKJJV8MBTyk8AEanww9Be6/Of/IY1iSsX9WB9QECqe?=
 =?us-ascii?Q?uecpPrpYlwyEFmsRr71IdpdYGX6AV/f63kK2unMj+VJjeZ1EdRyqpgAkgYux?=
 =?us-ascii?Q?nefMqxFQwxXicWsCVg50s9oKi0qCdUh4AW69EepT+lAAWY1A4dgc50RYOmT8?=
 =?us-ascii?Q?aDRmB9+K5pP1FtbLDqvDa27qZIXewkxy90E9LtgpQl0fdNlzLMrGV/PICZD8?=
 =?us-ascii?Q?7zfU2xhCdxRWYS9yYnBpYLCDoDWIFXju9ETMBJ8qbJTWu3goeF0AMKGrKDxe?=
 =?us-ascii?Q?7A1qe7Y9p5oxBH2fQndL7qCV/X6yg7+yNycTjDC0CvdODAhkA1sLaCclbwgO?=
 =?us-ascii?Q?jg8GiNHOcbj1NxqrJyxUpvxTcybaLI6pZ4655itpzAv9yaBLdCozGpqlwxhF?=
 =?us-ascii?Q?PgXG74aQ+8DMPH7J7/jdCmmx6VCxRMx0+2ZQmGpMAGv/2TjWc6wZpzxU+vnA?=
 =?us-ascii?Q?TSYKJjmEfK5cCa1lWnl8eU3zpTKnk76rft3trww++zUyQRgoyg3TbIaeppnV?=
 =?us-ascii?Q?PYgW/I+aeWaKjpTrK3mLRLpBYtwC+5ASyKwdkQOli9JtKoZOqztKAaIyZGOk?=
 =?us-ascii?Q?gKwXz6zWF1EasJJB9xzl1hPGJrLIAyEKzcqwVayRsZsvllROA1483w7hE76F?=
 =?us-ascii?Q?o7Ztx6MSERXu/Dj0Qvd0Pz/tPL5Mnf/S9lgjTjuHOAVrb2/78kQPimNu0jkB?=
 =?us-ascii?Q?cX6wneOuSW2+RQcWeQ1oak1ig6iSnq8CXAgGOnZEQ33cIXk1h0oIrvkQ68Ha?=
 =?us-ascii?Q?p8e3L8q6kANZnDZKcrD1OP2GSfPRTMipHogMyS80cJ5oUUuBuPxBdMWliaZJ?=
 =?us-ascii?Q?cInX7jKzj3cbNzUWD8lE+g3T7XY9oAeYdbZh3mAu7YoZgvIJFA+BtJqqfyVK?=
 =?us-ascii?Q?3h0EVxU5sZWVzVUeKE0oWK5p+t60vj9P+0zv6R03?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a8af67-8e4c-44e0-7845-08dc3fa17ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 18:56:39.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VebfRYD5qhegGmDJgK/JXm1wwczf0c0jv9Johai7DMfXwWzpZLtQSZ/ru95iimQz+ofFFG9pIQ3e0Jgd83vV5YXTlt9J8gz1y3XFLraWDFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392

Hi Andrew

> -----Original Message-----
> From: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Sent: Friday, March 8, 2024 3:21 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; linux-k=
ernel@vger.kernel.org;
> Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>; richardcochran@=
gmail.com;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: RE: [PATCH net 3/3] net: lan743x: Address problems with wake opt=
ion flags configuration
> sequences
>=20
> Hi Andrew,
>=20
> Thank you for valuable information.
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, March 7, 2024 5:23 AM
> > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> > linux- kernel@vger.kernel.org; Bryan Whitehead - C21958
> > <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com;
> > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake
> > option flags configuration sequences
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > On Mon, Feb 26, 2024 at 01:39:34PM +0530, Raju Lakkaraju wrote:
> > > Wake options handling has been reworked as follows:
> > > a. We only enable secure on magic packet when both secure and magic w=
ol
> > >    options are requested together.
> >
> > So it appears unclear what should happen here.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/bcm-phy
> > -
> > lib.c#L909
> >
> > WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> > And even i you did request both WAKE_MAGIC and WAKE_MAGICSECURE, the
> > WAKE_MAGIC would be ignored.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/dp83822
> > .c#L153
> >
> > WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> > However, unlike the broadcom device, you can have both WAKE_MAGIC and
> > WAKE_MAGICSECURE at the same time. They are not mutually exclusive.
> >
> > This also looks to be true for other dp8**** devices.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/mscc/ms
> > cc_mai
> > n.c#L318
> >
> > WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> > Also, you can have both WAKE_MAGIC and WAKE_MAGICSECURE at the same
> > time. They are not mutually exclusive.
> >
> > So i think your point a. above is questionable. Can the hardware
> > support both magic and secure magic at the same time? If so, follow the=
 TI way of doing it.

I guess the question here is what "support both magic and secure magic at t=
he same time" means ...

The original (i.e. not secure) Magic packet specification says it is a fram=
e like this:
DESTINATION, SOURCE, MISC_PRE, 6 x FF, 16 x MAC_ADDR, MISC_POST, FCS
So a "magic packet pattern" consists of six 'FF' bytes (synchronization pat=
tern) immediately followed by 16 consecutive repetitions of the mac address=
 of the device and this can be anywhere within the frame.
(a) Note that if magic packet wake is enabled in a device and an incoming f=
rame includes a "magic packet pattern", whatever is before (MISC_PRE) and a=
fter (MISC_POST) the "magic packet pattern" does not matter, the device wil=
l generate a wake up event.

The "Secure-on" magic packet, adds a 6 byte password immediately after the =
16 repetitions of the mac address of the device to the pattern that has to =
be matched, so the frames looks like this:
DESTINATION, SOURCE, MISC_PRE, 6 x FF, 16 x MAC_ADDR, 6-BYTE_PWD, MISC_POST=
, FCS
(b) Note that If secure-on magic packet wake is enabled in a device an inco=
ming frame will only cause a wake event if the whole pattern *including the=
 password* matches.

 (a) and (b) are mutually exclusive behaviors for frames that do not carry =
passwords (i.e. they have the FCS right after the 16th repletion of the Mac=
 address) or have a non-matching password, so you cannot really enable both=
 simultaneously (at least not in the sense that you would be able to comply=
 with both standards for all possible frames simultaneously).

>=20
> Yes. I will do.
>=20

I understand that the TI devices give the *impression* of supporting both, =
but based on what I explained above, even if you accept WAKE_MAGIC and WAKE=
_MAGICSEGURE on a set and report them both back as enabled on a get; whatev=
er behavior your hardware does will not be fully compliant to both specs si=
multaneously anyway. I discussed this with Raju and what we decided to do f=
or our driver/device is that if you pass both WAKE_MAGIC and WAKE_MAGICSEGU=
RE flags to us we will report them back as both being enabled in a subseque=
nt get as you suggested, but the behavior of our driver/hardware will be as=
 if you had only enabled WAKE_MAGIC.

> > If you cannot do both at the same time, and that is requested, you
> > should probably return -EOPNOTSUPP. That is probably better than what
> > the broadcom driver does, silently ignore WAKE_MAGIC.
> >
> > > b. If secure-on magic packet had been previously enabled, and a
> > subsequent
> > >    command does not include it, we add it. This was done to workaroun=
d a
> > >    problem with the 'pm-suspend' application which is unaware of secu=
re-on
> > >    magic packet being enabled and can unintentionally disable it prio=
r to
> > >    putting the system into suspend.
> >
>=20
> Ok. I will try to fix in 'pm-suspend' application
>=20
> > The kernel should not be working around broken userspace. But i also
> > suspect this is to do with it being unclear if WOL options are
> > incremental or not. Since it seems that they are not incremental, it
> > does not matter if "If secure-on magic packet had been previously
> > enable". pm-suspend is setting Wol how it wants it, which you say is
> > plain magic. So magic is what the PHY driver should do. Feel free to
> > submit patches to pm-suspend to make it understand secure magic, or
> > not touch WoL at all with the assumption it has already been setup by s=
omething else.
> >
> >           Andrew
>=20
> Thanks,
> Raju

