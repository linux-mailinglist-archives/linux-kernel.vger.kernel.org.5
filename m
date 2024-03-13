Return-Path: <linux-kernel+bounces-102495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891E87B2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27E2286E79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868B4D108;
	Wed, 13 Mar 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kl6Lxvk+";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UnX6Bruf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C32399;
	Wed, 13 Mar 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362059; cv=fail; b=UdNHJWml5ydRvK12Gz+87Wividyr5STFG4IxTcy+4434+ZFHoLGRphYvWXZxn+puk3beJnAEKnH6E65TEr6g58yW3wRU2h+TXT06cgR/moQZmWd7lCWMujWWly96ddiwWY9CHbctO3W9bSGSfgnB8Yejfa4wnlQeotBxlA16F8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362059; c=relaxed/simple;
	bh=zk+QLtrd06eBNKlag90amzHVoh1pk5obs1UdCtmkBnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQrGaIXjO22n5Sl7AQpoAc+a/Y1HyWqqNfV0s9iX23kYg980jqMXOiZ82jGhOyogXPVjQhgIVN/zq2CP8IqkqRO7EB6jezYWi57izDccEvdG5JG2Xkkb4Vhv1Sgjjcuy4hWOLTjlMAcW9Ex/VO9Y3lJ3uKKhBnHhIpnjdp+kjVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kl6Lxvk+; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UnX6Bruf; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710362056; x=1741898056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zk+QLtrd06eBNKlag90amzHVoh1pk5obs1UdCtmkBnQ=;
  b=Kl6Lxvk+aMsWbAO6dIiP9b/DhERHhE9CvZ6/wAAx+eY4nCG8MXOMUM9f
   g1AlHVXeJCbjCx5kagjaSpqOvO/QGHouVJKJqNGUfz2vn3fEOU+XNcJN0
   aIDzXc9gETksdiEWgGeef/nMBxftdsZ6wf/1llWjpcProkMEwhIE1ijPP
   KY5fPJL7MLG2H8lo22PjiNuwnTAjwX5xUGVcnbk0sGKNFJo7MaieoX+aU
   qrGrY04bIy7Dc79otvl6Zc2hhkAdcXgRqkWvR5wSjXhPT2ZkL2P9udmVJ
   6bZFR+kQwnhoUdEdXdTcHqWUOfId+WQtGtUXSfh5PULwxi3mPNlTnxv/1
   g==;
X-CSE-ConnectionGUID: RVEPGzSaRqCAq20cNvGjAw==
X-CSE-MsgGUID: Pu6XscwASDiNRUbMC/L69w==
X-IronPort-AV: E=Sophos;i="6.07,123,1708412400"; 
   d="scan'208";a="19334849"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2024 13:34:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 13:34:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 13:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdtKy9vvrEXQydBACZPBGpRrYXRJEznPPkNYis3tPHef6i+OOTPhR8YRUFmA0VuR0XiXFx7nItguDnDDwMcB6DlW//1qg5LOO3jUeD45mLnIoUu/4VJ/BOKw8xstWW+sJX/NmLb4ct4rg09LmSMpRNF39o3BQLil0cd0wyWcCYRJTAOJjXyx9IWK4BShHRMwUFjc8aIIxYKDTkgPLeQImOfmJxdrKujD6OJVlZba097NE/HBq1PfrEahkerX2SBCjJVeZqLA2H8UOrWSuuz/WKlBX4S/886UE9Bu7H0UH+Z8v5jOvf8KFmJBO/EshHFcEN+tr5xjfBULDDZ4bOy1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvkvRzWA5Y1pocfnGuoMwMRWTveLUWBGEO3PDEsSrvY=;
 b=l/eUuv6PJQlb4oVI4BRBI0lZXAYt2jIffpga4FRLCjhgcYBhBTIR4dTYIO4WMyOsSQZCjLvZMQ+KYrpBqN2lsa45WW5VF+4G+6crzg/+XaoHoTwZvvX8xWzw0GkjrBC/s6deWTqof0Hzj/aEoB+Q3Z8HPYwR+AxN79vvdj9SJBSDnYIyJrlBU9c4kLrz5PSgDv+afC/jCkMegCKmJJaEag9PD+mLEVe+05os6oBQhgmqs33UwS/ikFlJ8l21i/wl9ErPMDItDcJWjA0NcEFQbvxnHN3f5p5LO5W7RUu+l007qT3eZ2l8EL1a40NxVuvUWWLjd/+9OIp9EvGizCD6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvkvRzWA5Y1pocfnGuoMwMRWTveLUWBGEO3PDEsSrvY=;
 b=UnX6BrufdUjsTbdqtSEn6rv04FzGby4HMluL3g9BbaFht0/7ogTnKbgGYI2McDnLiGkILpyQQtf+eM7YQfeOmcQ22IHgYA7Hkjzw88RQfdokGOpAfWFaZXuZgxhNsDN3zHA4aKkDfYJ1s7MNvr9G0H7QtgdTd9maIUFquAZ09SRcUI9KtcEzS7gq2Grkbfn+N1d2BnPEa9ilZNuwmeTorlpN0pRUziyhIFmuUQklYkSdcSLCK45yZwT8lL0HWpnPQdY1TcHIkCBAvkzlWgAnwkjsxjKdZmb2zcIO/iREKozKERAsPv6N2MmRqsD6y9lpVS3JTeb9Uj5yDptKFZBMSw==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 20:34:11 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 20:34:10 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Topic: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Index: AQHaaIt9/9VvJ3PDJ0OgsYtGoeCEQLErcdiAgAIgIYCAAJu7MIAGjQ6AgAAJaUCAACyOAIABPjUAgAAJNRA=
Date: Wed, 13 Mar 2024 20:34:10 +0000
Message-ID: <PH8PR11MB79651B5E3C949D95043AA446952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
 <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
 <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
 <3e84e1c9-f680-47fa-aa59-615ce57b65da@gmail.com>
 <725e8182-50de-4469-9f87-fa58179f8922@lunn.ch>
In-Reply-To: <725e8182-50de-4469-9f87-fa58179f8922@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DS0PR11MB6349:EE_
x-ms-office365-filtering-correlation-id: abc9293c-0b6d-40b7-03c4-08dc439cf00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhUdZZ9NbG9MhP8epOhz4+2xVy4Ngg+lZRARuYOz2biVcFY8agcOAdFHYqVg09abJy4cNueIimlwquQbnc12sKDtevIAT1lXQQFtcRI4nNH1mmxTofXJt9cvLsh0KGYYlOgzVAAsir9H/7T/h2TWObo1G2lsaun8ymFTYvZe9/HZ7qgU2dGGR+8gp/rUoSxYlprtWtPOHpctsXNLAgKBGRPtnWfmruZwvuqh1n38/yiEe3fnCF5jcPFLalCi0SZ0KHHVXJsyyj0xPMPc46xnLcPYIY1vYXWQTjo2rCQygk1eKMCBQ7ADLkIPDpDVvIgL0jJ8ocn5DVEj13ceqb5pN6/Ai7Lri7U7hzykEC3mbtj7HtdOn9k1ZS2KPVaALAUqVE48Jhf9ZgDLMNrwGu6W0w4cHQxvBZ+VtChZC1QP1ESEYpFlofx7SMfffHQ0siiGmHczo2bseBeklX83hRnWxCOMfO4P6O3lxtK9up37M2EikX7ZaiSFsLQ9puruiK8ZBzQ6Q97o8WFXPKO2dM5DuHg6xJQ7VFBwTNVJtXUVO2SV3ZVuX/uv43dXBINM/Y3wN3LVHdVdh8sc25bzIGtmNGVv7LZ2OgwDz6Wg6oEdWsIPJYkEWt6+z1hHar55SnB2o5iLgw9lAv/THz8m4nsOoJsccQh9Ny59IJOCZ+JEPHahpDclNhYCUkHNhbKLHLCkw7hSTRD5Pqxnro5xXhBczBvvjw9a+EfURgoD4fRyUgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ihF/Z0g17FdZa1mHltnL3SdzW9AdfyaNK14E96rngB37zLOWjDgbRijmezGE?=
 =?us-ascii?Q?P4wm2M0LpeJWI2LW6wDIHJXIQIRNpw1vdPvylJ8b2JTDAD2XZAgIHRa3hZQH?=
 =?us-ascii?Q?EJPeVQhM4JHyIDfL0ddZezImLS74B+HQlkZkxUyP1sxyloeGj0Jj4Jp61sJ7?=
 =?us-ascii?Q?Tnu4FwbZcpyEv9E6UOp9IV6tchsDupmJEIZya6Idot+mdS0f4j0au+RAYAwf?=
 =?us-ascii?Q?TDhg8hSKeVJXAQwJtk+x5K7i1fqgbF65nZhgmfBl4ySeXKpsxR6AR8fhTe+s?=
 =?us-ascii?Q?hNNZT27URVHJqpTSaWEV9DJQdQgJyxj1+5V/m0vlZrYh9pW9+6PMHrD4w6wk?=
 =?us-ascii?Q?zGJz8aPy2zz1AjPevGs7XzEB61tH12Q3MsicBJsxdbYlFz0DK+mv7IevNfsR?=
 =?us-ascii?Q?5nvHZFHFV2kpN+ZWbowY+Un+e2L+l20AD3yIxcKjJCXLAxr+/R1K2vKUmVEp?=
 =?us-ascii?Q?TaYn1+DaSfKeGPYDUnFxltShXmMypimcUpOLWAWBa52LldvipYjqYiGzGdvn?=
 =?us-ascii?Q?21Ir4Gu4TpzU7gqRVm+//2MDnANKtPsGt7OWAsriZ+kdC/IEoD0+amJsikXf?=
 =?us-ascii?Q?nHotpZGHt8TFNPl0cRTVdsieBccOA/w5bJNhwTbGIat8OeGzDPgJzTgmHaNH?=
 =?us-ascii?Q?Nl4Fv/rJ+1ZdFQgHVmoXSSFt8MYa0LFii9EQvTTqcxvKl2PJqL2r1e3TXWE+?=
 =?us-ascii?Q?sFnxw0xAM71X+CUaHcsJgOS/hAEZuLP/1Ij9wrLxKx0DWvrUCGutcXxu8c7Y?=
 =?us-ascii?Q?eEtWkjMnz6S3dkzHrg8wJCMUSwsbdyU8dhgIBJzLuOdV2y8Wr2vMB8CakO77?=
 =?us-ascii?Q?w0L+vYArrKqy7D1HOEAye3b6RjwHMJRQi2IUf7U0KkwY4eDTC1rvNfxcAlgF?=
 =?us-ascii?Q?Q4TNFD0AxZDo2PMsSUbvjxSUDuIEdaQo6ftrOzz4sP2T48o7IbOmHUEGuc5B?=
 =?us-ascii?Q?/ZZjojX0qw0m2QiM7vVIOGv2Oi7Wzq9ddp236RBpWwBOjQOwGe/vsiH244WV?=
 =?us-ascii?Q?Qcq5tjKTqNCDD3cBWoM21FW7OvLaYnSB1mNFo2/x6YGG27M7wKuaoNyNKiix?=
 =?us-ascii?Q?3MQ5gfBITGCMhuSEPsvcU6Scd3XbvkPqh3/HdRaauLwz7dcthquWx1BROCXu?=
 =?us-ascii?Q?iiTN1Dz19G3n76RRb3nFAzkXQ6s4XZJs+tQ6/Wxv+vmPdpthM6q+pAQqfKy/?=
 =?us-ascii?Q?OrCm/099h24/8kHx0fLN3EqV4GchxGsSLqnzNS7MWUoEatotTKFO/724pK6r?=
 =?us-ascii?Q?nf0csEl5tJ9+UONS5lYR56N/+Y19oxX1MLjaDJtr3mDyVCHddxbPaqHswnwt?=
 =?us-ascii?Q?H2c/yxYWXh4/tnnlPXLFApJFLx0dZYICmSqh/7ayQKp2sv+WIWG+dOdLZD3F?=
 =?us-ascii?Q?wHTfm1+qgsPv9raF+WMDzBRkO66sUlzwRNaXq/5uzTgqD+qm4Yi6CCJBk/yB?=
 =?us-ascii?Q?NY6YBOBVIF1pGaaKZfK1IXXrI6jotYgLDulgJJzVUX5C7JxniWm30Hw1/khj?=
 =?us-ascii?Q?0O3zAl5oCc1XiG0Y9jaw7h8qQa0EyVn+vuWplQickE+PpdRqLSwZiYMlGZ6E?=
 =?us-ascii?Q?P6jhGRFyPTqomnwHAJI9vceC8DeXDc32ICzDcaXw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abc9293c-0b6d-40b7-03c4-08dc439cf00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 20:34:10.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHEts4ntc7H9ND2vQrKTrTlx9+KRinBW4RfnaD3E3kZJHTO2xJ7nkAfZUdQ9qQ7g1igQBJu4Rh8LJnAINjdxL0hve2ppRe0FKlQ1Z9YDA3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 13, 2024 3:53 PM
> To: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>; Raju Lakkaraju - =
I30499
> <Raju.Lakkaraju@microchip.com>; netdev@vger.kernel.org; davem@davemloft.n=
et; kuba@kernel.org;
> linux-kernel@vger.kernel.org; Bryan Whitehead - C21958 <Bryan.Whitehead@m=
icrochip.com>;
> richardcochran@gmail.com; UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake opt=
ion flags configuration
> sequences
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> So i think we need to agree on best practices for new drivers and documen=
t what that is, probably in
> both the ethtool man page and include/uapi/linux/ethtool.h
>=20
> * WAKE_MAGIC on its own is O.K.
> * WAKE_MAGICSECURE without WAKE_MAGIC is invalid. -EINVAL
> * WAKE_MAGIC + WAKE_MAGICSECURE means only secure magic WoL.
> * Each driver needs to enforce this, due to backwards compatibility.
>   Some may decide not to.
>=20
> Can we agree on this?

Sounds good to me.
Raju (and other MCHP folks) are out this week due to a company shutdown, bu=
t he should be able to submit a new patch for lan743x as described above wh=
en back next week.

>=20
>     Andrew


