Return-Path: <linux-kernel+bounces-132661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0B8997EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90031B2141A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528A15FA90;
	Fri,  5 Apr 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q20t30hH";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cxRrGfA0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7915F321;
	Fri,  5 Apr 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306165; cv=fail; b=VJ8bJX9idwr+sPaCZKFSVWMdZq7h9P/tM+8pMWh1ElI+TE7eA2X171VJ7FLXtN+1cmh+B1b/PMpD6HxKTLQyy0Cl+Ggj65WAZ9IWpHE14RANXZ31sXi0S5ISGFYP+FHMInJb3GpHaWiCtNSFf1FN/qqZZ2rd9rfxTRs3oAfdoiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306165; c=relaxed/simple;
	bh=j3ygQtg9d3ahWGMr5Gz3S3ppaeVlsE+V4Q2t9Hiip/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nzYZpE1YPNcOfqo8BOkYU8BrDBmniJaB1TelXo3ddndNcuCY4evwPuzQyvajwOFRjasVwaXaJheh4vy6nAs2dbaBqor+S2oNZQrkYO+537OkZ0cQ4viJQI+JAhJQXWL74srN8CSg9Po8E7vVS5id6/dqg+B+xy+j5TY9qPhdKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q20t30hH; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cxRrGfA0; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712306162; x=1743842162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j3ygQtg9d3ahWGMr5Gz3S3ppaeVlsE+V4Q2t9Hiip/c=;
  b=q20t30hHnkoip8CCptpHx4g8FgKZOGGOGswova27dJMfhAhQoQDSJCIF
   yPhMmIzhbFlXSTrLIVSslYoK1sGlJu6GjcIBsQUO7HvdcTjOd435+NGsq
   quTLqLm3QbsMsjzJnKmSkZTGSPTCVurgxBIKrfqRLLLbbLpsC+OwZLzg6
   /NnHdk0/EhUlWTa42/Nil4jRWkE6QODt2xFGQvbdVuTXOdOCuw69w+5+5
   5UTAsIVP53P7ppruCgVxOiD825p7sQMN9FOe63swpWG81HceBgwmE4q/9
   rP7VYaKjbetnwE2Rk/1gfkOcSCUgXySugd4n4bq+qZAzfVc9oAp5V++CR
   g==;
X-CSE-ConnectionGUID: VB+k7OebR7i2J84qft7WJg==
X-CSE-MsgGUID: tJUAntLKQMOfAu/lSbwT2g==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="186895384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 01:36:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 01:35:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 01:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPWn52SJ77PUftlFkqFbdiy3W9LWptF/xlCknpgANdbUz0vlSE971uZNgGVSpMhSh4DZKVnZ0dNIShlQkQppfE8UEhkTRLg2bMzHw89dJCyAr1wP672Ix4UyTDWJo/+jwYpKVdEGzJDV9ESapvoFBOner2gSIcT8MDDD/zq7Y6it856zKdslBAi+riulrdK/AZj/vf9jDauDdkmzVDC+W7lWoNRH+07A0EPnP2Lh87cVMOVb728vANQetibOtCKNNhXvGiHNYau1O+BteA12hY3vvr5RYe1+fbI1CP5ctdWfHaunfuZourtEEewLnWwzxa/yCcat6jsw5lgJ+hM76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnL0t9DUGxb/GcvT8qZ+vAD0RH2LSv1OgvEJNjy5JIE=;
 b=QlxssXiA6xRsh71RYtk5gVldHoz7z7QGM3Nc/be3eiY5bJ4iBRTMLGZjSzEdX6pNUNqz9FoKMMeSnBHAJWMXJD+FkJG0D3ZShq6bc8XE2nde5iDaQTFD3/FW9/OUaQjKxsDhAZUQslZr8MhITMRqLKEW5nfgIYnIdyTBMMaTSn4XGzsUb7KD3uyx65hvHWKrxXfDIxZHpnuTc4tc0eruBpF102arDfn0vm5Pqp8UMPAsCfWMIdAwPYQ4hNIEYO31hSOMmDnpuEJ4vqCyYHrNS/jb3bP8oaOZgimkqZ/lGKnhvmoZ3GTxuSgvSqh9sPjwyFCJNnBpofWsWE7vHr8pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnL0t9DUGxb/GcvT8qZ+vAD0RH2LSv1OgvEJNjy5JIE=;
 b=cxRrGfA0RMxVEdFadEyz/djqBmuZZfNna/eLix9KyCT/ypz9IUkmC0jNe3Tv96syvVz9pTWwtI8kq6c12HAYQ6kUmKIjqc//caaityFbraYHVUldrrCphjCkn56u0vpH0g6via0bKQ1Ifh6jjvw+pb/zq8iXzgCZ/KV6VRqEeCHGUtjbu3KyR16mFU8RKeFHmg7EUGCYlTmr34Igux3ktRcAIPbWKsOQJTxXqV1rZW5uQt44z3UBr2dSKR2Ly+Iw1krQ01G1ZrqEbSy0CQc3NLC/b6AIYPo2mecIXW+kTRwDDOublLJWwQhX8juDPrOiVTm8eAlAWzO39iSsfVz3yw==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 5 Apr
 2024 08:35:25 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::b78f:e89c:89a:842f]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::b78f:e89c:89a:842f%6]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 08:35:25 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: RE: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for
 PTP_PF_PEROUT
Thread-Topic: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for
 PTP_PF_PEROUT
Thread-Index: AQHahmbVG65LRxNRpEalQnzb7NUpU7FZWpFA
Date: Fri, 5 Apr 2024 08:35:25 +0000
Message-ID: <CO1PR11MB4771B9B8238242DA6406CBE6E2032@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
 <20240404080115.450929-3-horatiu.vultur@microchip.com>
In-Reply-To: <20240404080115.450929-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DS0PR11MB7879:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFEa5rZ6e/c6isRkvbmoLuabM277TMTjjyLgd0Ii+DeAJjmqfVxr66Astt/nvEGYlOBpGymiQ+4A6hMSWsWwbTcw57l5uaq30f1K9mTEmi/ygWqFbBgBpZlxDtAoMphu7SysrkxVoSF4aZaJQMhOgYwx296T+Tuia3wzt+1HrVpCG06MSxUyUkDHtF2E2NM5c9UJ/TvOAVbjWeArdnSgzd6zEpFYJS6GiCIuJGkyXL7UMDs7EBC80YiqZYkeQNEIBdWqnbeYLWxvTEjsoAv6f+zD9J65SJGTpietxupBJD8FmDhib4PTlRHMPR1UFxms8V2OBCohUrhqYWz6jBlzfRBQ9PvjQETSA61pUJE08Hzg7A3nxFxLLU8jIor6jNidM/bc3A7jrZY9cE+5Q8JK2ME9FvWyncXHfOubPyMWcqFAv1HLqtw0M9lqYX2qU7IZulWDDO+SOU+HWVhC2sq8UzpAxW1nyxnFOSRyV0dYQktyQn+OUvbvLbJ0rjWT40BDFgcKSocU0YbDkjHfLg1AYPuKnADOKRnBVkT4ZjcllnWvOyectU6IXHF9aWpIcEy2x1RPjzI9pDMzrF/8ZRlw7WVmq9sRRWatiV6QnxXOvi8rMvj84dfXriH1yA3ruxn/REEMKc39xtSotZp0LmVFJJ648c6N6nMraEqWQ1ikQQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MhgCZ8ZCxK0UA3Xov5m37GQsfSXW3GmdDpMuOocbQQAfhVH9zsxfrBFy5mn2?=
 =?us-ascii?Q?+o2Rugis69zS6o5gcOqF9pBoq+vT8Fg60jPy2+TgNx4V3FRrtygmoFxdV57X?=
 =?us-ascii?Q?A+k8FNk83slvPmoPlBoRCmsHOmYG8UsRzVRUfH1rK112N+UV0lAI53FjzcVU?=
 =?us-ascii?Q?YgI3brOYbznKvwI/89ct1Ht5tLfrhlZpk+lWMqoaf9i7SV7b1x1PaMFzX4hI?=
 =?us-ascii?Q?J6uLmkieqGyaozjVwgJAhAeacxpzzInwBAtNs/A/gkjOBiNykvEY0ITpFTsF?=
 =?us-ascii?Q?vqkhApnjs5ddN3zj+/YeUlN2oTcI33zInWjHge1Pd456cba9AvpK4TQpEuCW?=
 =?us-ascii?Q?RE/JX4JSbHxIFddVxqroYv+WAWmq98kbDgEgj9xPrqJyx+o4GQYrW4zjuVfe?=
 =?us-ascii?Q?+cOXsGZq9mRyW34T0cmnGs1UfoEcRcRR7niHCFfTsIGnR307JgkFyyr6T+iQ?=
 =?us-ascii?Q?Fn/3tzP8BM6hMRQW2I9YT0drAXpg+EEth4TybAdhwBYryp8YGxWVGnyIrpY2?=
 =?us-ascii?Q?NpNODkSivr26qiXFnNy8w6N8hXaIJDBtUdcoQminPF+0aPXcfCCTgQiLjhVf?=
 =?us-ascii?Q?/wKJjIqn0BJfXnRqNuII6EvV2z1FuTtSM8nVdoAOSflh3NA4n6cMtQki4/Yi?=
 =?us-ascii?Q?3Nd1AeXqb+Q9h0cZkgouvjYKJDo0ei5+tsm0xhT0DWeZ3GDFAx3coa+DINTP?=
 =?us-ascii?Q?NgmDEBFWuTM/QzIwPH90bZgjftzqcfYNvjykS0qTykAA0jX8gglAZFaRsTNF?=
 =?us-ascii?Q?+g4ow4xKimgtSAkXeitawGi0SbZD/AnTZEYPy6FYkie6TG4qbLKzAAaGxzYL?=
 =?us-ascii?Q?hzabMGmhzR9LBD36KP0U7DnPp4p+/brHNLLDG4Jdzjxa6vV44B3n726YzgjW?=
 =?us-ascii?Q?aBl4kiuI21P76okbpVjUiIJiP1ggrDMCzp9lahWkc2OkQKQz40/Fb4c+Dz2H?=
 =?us-ascii?Q?/+nv847+uHMM1nUQpfXpwp/E34/WCCH/eV6lBAP79HqBL+seJOvWY80RuKPf?=
 =?us-ascii?Q?VTCgAJfM6KbO83QRDYwilY0kksTyP7NvyrgjAw+FH/aUCmxbVU352BaJGSNJ?=
 =?us-ascii?Q?krfP/RSodKoqyYKEl0iQH6OJfhgjzruEV128Qd1c0Gszz/2FGLUOH2MuMYp8?=
 =?us-ascii?Q?LBQln6OA72HhVQ5w7uUtY5aFrCPHK/rhwFTtbI/nAdUnvy5TfwVBCdG+lqRp?=
 =?us-ascii?Q?qC4HdUtm3t65iOToknP62RppqSu1dq0rmvsLWE5RNoDuJqmd4NgrD71fIVl7?=
 =?us-ascii?Q?yCS0Ad6qTIUyk73avNrB1a9QFraES8+hldfojz11513ZGvuR3mV4jmtFpbpu?=
 =?us-ascii?Q?ETk4pfSkJo7SPskRdYQ54q/PFksBLAwpsaw357PkGt3m7dxnIU+5Oa7IF95U?=
 =?us-ascii?Q?gsEup4ZnGFxhR//p6lQXj/4lJPKNvALeQ5Ji9hdz911XfY3DwjPlLrn9emO0?=
 =?us-ascii?Q?OXgTmqe5lJoTUQXA7NUg74b821lHPfwDKIPAWPLqTRwBoO2u+cLSIOnvDIss?=
 =?us-ascii?Q?vop2O7TExPQ/pVA3aiVGGOL9ja5+TnE/UxA0Q4y/2HETWqKHGP1Kdy3WuSZN?=
 =?us-ascii?Q?NnVDjWM5pxwJVFTXuugz4E1Eqq4oldkSNc/9LAA7FJ6eOWIHdnT098u4bsML?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c6ba50-99cc-4787-ba7f-08dc554b575d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 08:35:25.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhuQEciigud/PbHlrMc0kXQx7MF9eQgpSKifzXDFs0cVzbAIV6mHoaLAGSPpja/PqPyYVnan3WbiP9QV7PtUvGPsPj4PWOc9Lv1XtgEXguw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879

Hi Horatiu,


> Subject: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for
> PTP_PF_PEROUT
>=20
> Lan8814 has 24 GPIOs but only 2 GPIOs (GPIO 0 and GPIO 1) can be
> configured to generate period signals. And there are 2 events (EVENT_A an=
d
> EVENT_B) but these events are hardcoded to the GPIO 0 and GPIO 1.
> These events are used to generate period signals. It is possible to confi=
gure the
> length, the start time and the period of the signal by configuring the ev=
ent.
>=20
> These events are generated by comparing the target time with the PHC time=
.
> In case the PHC time is changed to a value bigger than the target time + =
reload
> time, then it would generate only 1 event and then it would stop because
> target time + reload time is smaller than PHC time.
> Therefore it is required to change also the target time every time when t=
he PHC
> is changed. The same will apply also when the PHC time is changed to a sm=
aller
> value.
>=20
> This was tested using:
> testptp -i 1 -L 1,2
> testptp -i 1 -p 1000000000 -w 200000000
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 353
> ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 351 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
> 51ca1b2b5d99a..521c6f7ab420c 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -272,6 +272,66 @@
> +static void lan8814_ptp_perout_off(struct phy_device *phydev, int pin)
> +{
> +	u16 val;
> +
> +	/* Disable gpio alternate function,
> +	 * 1: select as gpio,
> +	 * 0: select alt func
> +	 */
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_EN_ADDR(pin));
> +	val |=3D LAN8814_GPIO_EN_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
> val);
> +
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_DIR_ADDR(pin));
> +	val &=3D ~LAN8814_GPIO_DIR_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
> val);
> +
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_BUF_ADDR(pin));
> +	val &=3D ~LAN8814_GPIO_BUF_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
> val); }
> +
> +static void lan8814_ptp_perout_on(struct phy_device *phydev, int pin) {
> +	int val;
> +
> +	/* Set as gpio output */
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_DIR_ADDR(pin));
> +	val |=3D LAN8814_GPIO_DIR_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin),
> val);
> +
> +	/* Enable gpio 0:for alternate function, 1:gpio */
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_EN_ADDR(pin));
> +	val &=3D ~LAN8814_GPIO_EN_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin),
> val);
> +
> +	/* Set buffer type to push pull */
> +	val =3D lanphy_read_page_reg(phydev, 4,
> LAN8814_GPIO_BUF_ADDR(pin));
> +	val |=3D LAN8814_GPIO_BUF_BIT(pin);
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin),
> val); }
> +
> +static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
> +			      struct ptp_clock_request *rq, int on) {
> +	struct lan8814_shared_priv *shared =3D container_of(ptpci, struct
> lan8814_shared_priv,
> +							  ptp_clock_info);
> +	struct phy_device *phydev =3D shared->phydev;
> +	struct timespec64 ts_on, ts_period;
> +	s64 on_nsec, period_nsec;
> +	int pulse_width;
> +	int pin, event;
> +
> +	/* Reject requests with unsupported flags */
> +	if (rq->perout.flags & ~PTP_PEROUT_DUTY_CYCLE)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&shared->shared_lock);
> +	event =3D rq->perout.index;
> +	pin =3D ptp_find_pin(shared->ptp_clock, PTP_PF_PEROUT, event);
> +	if (pin < 0 || pin >=3D LAN8814_PTP_PEROUT_NUM) {
> +		mutex_unlock(&shared->shared_lock);
> +		return -EBUSY;
> +	}
> +
> +	if (!on) {
> +		lan8814_ptp_perout_off(phydev, pin);
> +		lan8814_ptp_disable_event(phydev, event);
> +		mutex_unlock(&shared->shared_lock);
> +		return 0;
> +	}
> +
> +	ts_on.tv_sec =3D rq->perout.on.sec;
> +	ts_on.tv_nsec =3D rq->perout.on.nsec;
> +	on_nsec =3D timespec64_to_ns(&ts_on);
> +
> +	ts_period.tv_sec =3D rq->perout.period.sec;
> +	ts_period.tv_nsec =3D rq->perout.period.nsec;
> +	period_nsec =3D timespec64_to_ns(&ts_period);
> +
> +	if (period_nsec < 200) {
> +		pr_warn_ratelimited("%s: perout period too small, minimum
> is 200 nsec\n",
> +				    phydev_name(phydev));
> +		return -EOPNOTSUPP;
> +	}

Unlock is Missing in above and below conditions.

> +
> +	if (on_nsec >=3D period_nsec) {
> +		pr_warn_ratelimited("%s: pulse width must be smaller than
> period\n",
> +				    phydev_name(phydev));
> +		return -EINVAL;
> +	}
> +
> +	switch (on_nsec) {
> +	case 200000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_200MS;
> +		break;
> +	case 100000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100MS;
> +		break;
> +	case 50000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50MS;
> +		break;
> +	case 10000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10MS;
> +		break;
> +	case 5000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5MS;
> +		break;
> +	case 1000000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1MS;
> +		break;
> +	case 500000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500US;
> +		break;
> +	case 100000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100US;
> +		break;
> +	case 50000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50US;
> +		break;
> +	case 10000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10US;
> +		break;
> +	case 5000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5US;
> +		break;
> +	case 1000:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1US;
> +		break;
> +	case 500:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500NS;
> +		break;
> +	case 100:
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100NS;
> +		break;
> +	default:
> +		pr_warn_ratelimited("%s: Use default duty cycle of 100ns\n",
> +				    phydev_name(phydev));
> +		pulse_width =3D
> LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100NS;
> +		break;
> +	}
> +
> +	/* Configure to pulse every period */
> +	lan8814_ptp_enable_event(phydev, event, pulse_width);
> +	lan8814_ptp_set_target(phydev, event, rq->perout.start.sec,
> +			       rq->perout.start.nsec);
> +	lan8814_ptp_set_reload(phydev, event, rq->perout.period.sec,
> +			       rq->perout.period.nsec);
> +	lan8814_ptp_perout_on(phydev, pin);
> +	mutex_unlock(&shared->shared_lock);
> +
> +	return 0;
> +}
> +
> 2.34.1

Except above comment, everything is good.

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>


