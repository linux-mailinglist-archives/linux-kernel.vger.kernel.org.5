Return-Path: <linux-kernel+bounces-23154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73582A86C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C74B24845
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C6DDB5;
	Thu, 11 Jan 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K/1VD8Yb";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x9HTGglH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5853DDA7;
	Thu, 11 Jan 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704958484; x=1736494484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cvdye0neDHg40H4pfwUxyn+lRJMOJrYDfwYHYdzfUbI=;
  b=K/1VD8YbGBZvE00h9TLLoTnm1SMMlzIrf3zWUEuvzh1s5OxgWYa9Z77i
   2Avu7XNUJwVVc9ILrWw63iFJAcv2OKEyR9uWGRi8LKnTtiZWa86k4L11m
   1ChQegIBCcojU2fw8aJKcslEOlRr8ohh0pAs+cFzTWIiaWcj18QifeSAV
   8bYC7vFI872Cm+h0mIlb1wDm/EYpsNFfU7qCSh8Q1Xm8uYHzTRkDe2EhH
   5vhU5d0kBBVwX7kGbO2gnxhQrNDWVq532AU9w64/GNgAZuFj027cp9a6W
   7TEtJRedQAvXeg9JqWPShPYdSliFUMFlvvCcVpk4ZVULbqBTjAc93LbpI
   w==;
X-CSE-ConnectionGUID: pa5ss2L9TiW9Ouq+NIBJKg==
X-CSE-MsgGUID: 3hAWU8UOSciucp8ath9CCg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="15735285"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2024 00:34:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 00:34:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 00:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dML9rlktAzJQIaEtIxOxEXXhO8xdODFug29e6kk0QiZBL0ruRWCdHRb8eV5GiN49U4newjaln1ncgLaAgP6mhJ0H7CuYy/pUxwZr4m1Tv40SOP1ESN12LtYWSmCEazpe6ydQWqBq5C45u5rxKMcNsHOLqSXjrm0ai1h8FVxLas01X18qj+IiX27estPyWMoWa/iGDj7nvMAwFnk4rwiUthTNYXIvAkE0jcuycMy9fLMblxGgFVpGjZDRY6hDVzyVpgY14jUbCSzCUkaQklgSdY3tW+XfznAQMCUO7dmVuc9Zpx/nM4PZBS1s/URq2hmhgf5tT6R359iIZXPJih12Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvdye0neDHg40H4pfwUxyn+lRJMOJrYDfwYHYdzfUbI=;
 b=GMyDWZPSMq7EK8h6V1RMjZoj6dCjlIolx1RWjmEpbMNafFkS0cK77+O8CH+Lh7WApQZPAAmV7uJ3vUHBGdbmGOS4e2GJaGFscC68ZKnbjlJtlMi2s77mQAqYx1daJeS6GTErHu5Ytku7d54CLNBBctj6QnGWTOOYCpefxl9HPxqvLW5Jd5+OQMv4+ili7ggNUT12EA0PG34KDaexB3vZXyeyc8u3F7aJwY3YrKIqa8dsZPIwI9BGNR3kJBtVR8W9o/r7hGs4hBu/OlN5GKwNLXQyzUK/Sy4IoSKxTuBQCWMGCAfV8u7sd13kAqa5/iU1GBgWczkGOHYWeJpyuYnuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvdye0neDHg40H4pfwUxyn+lRJMOJrYDfwYHYdzfUbI=;
 b=x9HTGglHqix4lG2GCJbXcJTeh8QCzQ+cewoJTT2jUjwaq2SmeACQcHot0vK3g9aKPrSoiBQE/Hlbk+A+FR1Czsq5IsIJSNkJcpITj2FzgnLXggQdhnWmbvQ7LfRpjO2abZa/i2vEiIWgF6lRPR6poW3hjt08UAPCE5DbGcyCeimSVwAv/fWH08D9lE2E3KhffkTtPNNag7+6Oe6CHyym11mEH5E/vvxvbNe1UDDbIANl3Knno/N08Pt4KuLrzKYYfPRAFREVqNJCaM1ybqrHGEyvieMYCtH1raeLmRks/Sad3vne7S095ZnYEGXicH/r6/h9RUJh26JuCZPJ4FAU2A==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 07:34:13 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::fded:842d:73a2:91f3]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::fded:842d:73a2:91f3%3]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 07:34:13 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net] net: micrel: Fix PTP frame parsing for lan8841
Thread-Topic: [PATCH net] net: micrel: Fix PTP frame parsing for lan8841
Thread-Index: AQHaQ7lr7XsJTsE18ky3EEuIO2JlJbDUOPTA
Date: Thu, 11 Jan 2024 07:34:13 +0000
Message-ID: <CO1PR11MB4771C419286A41F67958967AE2682@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SJ0PR11MB4910:EE_
x-ms-office365-filtering-correlation-id: 8f9108f3-a70f-44ab-b41f-08dc1277b598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/QbIZrOE+5VrcOuGOE/DojznIA7EaFbE70HC9o56sv44UvGLZF6pEfq3qmht4wPMi3EVMMoxPzA+gpbRDKPbQI22AuKFTLIGCeWTfPzNIuqHKQVC1Kg8XbOWV9u2Vb8NZAVCO0cj7n1cxFI8NJocB+mLYlVV6yMheyg4CDZ8Cakw5O/5ekXg6EtZsW0skUAIk3h+jOIFBLOWuKIpgg5k0NynbIBgINqTiKbWvYx0cLBmOU6BWvxwIByG1m6Tiw++9DuElWdZLKSCWruSeDvL90ZSDvX2gtBEpHegSZk/FyqtMZ/gtdDLYiFUVruhA3nJI4RQ8fnOcQ+H/d2P95WqvtBJPHIt0JugidP2Z8B7OWoapa9YTiAFP02/RSbl6BJSD7f/Te/AFtAiiFdVXkTOWrS1hJXye3CuAuHlI9NufsaA/8dbrXBMPFWlAYgZnSiNhDoXQoQmSX8C3TvCTAIOMLkUOPdjXITdBDp3U31cXpXz6GMcAWL1cFNO//OtrF13s/MHsOjyVLiD1wpOkc0TkECJQP6eqHJK+zSNvO+Mriajm3o8OtN8ZuAWlMHK/ym51t1dzyrIqBpU+vG4zX756/9m8fuBet63a8SgC1L4eQbOgo2pJnGeW6XU9Y3Q8Oo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4744005)(2906002)(7416002)(5660300002)(38070700009)(41300700001)(71200400001)(4326008)(107886003)(478600001)(38100700002)(83380400001)(122000001)(26005)(6506007)(9686003)(86362001)(7696005)(33656002)(64756008)(52536014)(55016003)(8676002)(8936002)(66476007)(66556008)(66446008)(66946007)(76116006)(110136005)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v/0Aa52UjEaMcJ5IvZ8LyG+r7K7g3sHO8HI/19uM27Pdyo58kbHXT0OWmV8n?=
 =?us-ascii?Q?3su1liryWiH3wu7aGzc7tdPPXEaSptTUq3+LAvubL4Wu0lJkH4oS4WGgG4uh?=
 =?us-ascii?Q?CWD3WUFaxVIDYPols1AxNx2v58KiiOtlDl2VB1d4L26bDsgkypOEjigVz+0N?=
 =?us-ascii?Q?ZQHLLufmsayfYz561iGU9qpwvw2aecV/vQNnP95WL8/Gn9AEUu3TVxe4irT2?=
 =?us-ascii?Q?54yHFKvN89eoPrwyLVDIup+D7bPXgb/oI8B0ZA4Cm105fp6cZm4XRMYDh4p0?=
 =?us-ascii?Q?gUSTqebVsSId1DffjRQ7Le6rFW2wQ/OGou/YqLjKb5n4VPNVJw/HjjnrrmE3?=
 =?us-ascii?Q?iKT2LOMPAh6lt0eSByZrvS9ZLDFMTIOOtVSZsCZT3BKB2hhCdvn1ynfYbyNo?=
 =?us-ascii?Q?Y9AhELRufsDj2dxCEDJuiElZDi09WshGv9u+R4WxioxALzzVyJ50e/2qSbqe?=
 =?us-ascii?Q?+nqpO79FiNXMBaa9tKF5oHMCoLyVgsT17zPjnfulv0KjzY4cvSniwqkLZHZD?=
 =?us-ascii?Q?36/I1y7Jzol0CpcvuBEOoWP3TrmaNWe4xSTF9AoV5XvfJJkahHjbH+OygUBO?=
 =?us-ascii?Q?G5glYJ5+LTnWNRrbH0TKALZx5K6fut0HLC7GiqLLp/LP5r6dnTiA7okxvOJx?=
 =?us-ascii?Q?b+/bziQta//7+Xxr7j7UIRsN16LM6osHJFveG0d68Jmw80SMEJy1wV9fJJ2s?=
 =?us-ascii?Q?35f4EXsh+rlnn28e1cFhNAq9ee7vc6L7/v7x7odF+t7R6pzxKj5ZYnFQl3Gv?=
 =?us-ascii?Q?NQZj0MguuAMLfdo1HZW2Hd55Ql/8nWfi5mn9ClT6YiwEJ0lfsloWLgy9hm4V?=
 =?us-ascii?Q?lEPcJxAyG24XMG7vDe+BBd8Y4y6C+BQ6F+QtGp4VDr0N6GPlItn7WuNWM3bb?=
 =?us-ascii?Q?x1izLhPf0b19BV8neQto9TwJ39x73LQ93mnoT3CTv08Ud0OS03MpHYLgfSBZ?=
 =?us-ascii?Q?Uv3Pq9BnXAwS+3Dg+2kGlprKlGaJx/k9sRPU2ALmB6vn8Ws2LKPA42n4AU7Q?=
 =?us-ascii?Q?Ym1c2SzfysQ2wPGgjg6/nJgdIrcKPtrh78LNDzRcN9If18yz6u74qntKWll3?=
 =?us-ascii?Q?9cDQUiLEI+8BskrIjkddHH9TIuS/2XNgnTyul44NXYff32va1uvR3ProlTij?=
 =?us-ascii?Q?cfKIcedRlZqkASLStg9zoBXyJDBP5Lq9ZO2h2kcCHC3fnrujfp8TZmFEz7Rd?=
 =?us-ascii?Q?vStQGZRRsr/Rk6vclDDMrg03k197A/5B3xpZd6tEUx2UizD5LNgmPqNdprk1?=
 =?us-ascii?Q?Q/NVSj18LGmXjiKN+QHE5QNRJXdCxEOzM9INM6WfkINJ0RJTaXpFMOWhfNnr?=
 =?us-ascii?Q?iv8g9gEoToNRH5jjxFHtp8CSc+G9tdSrvB4nuLDiypcQiIHOWF/J4iy+oIEh?=
 =?us-ascii?Q?GZSSEg7Vo9zfepNGqK+mfJPwaFbRLe4jesB84zxV57BS6WRmDztVv8s9TGFF?=
 =?us-ascii?Q?jNGzOpw6j04N8kwauHYdHiIaGyU05bjIk3Lq05bl+vH2zyMqjZOXBA1KvQS6?=
 =?us-ascii?Q?vkEeNAvtblvaMi51xesrx7Ud8EwdnNGtdUg+RC4+GvXje6S0jEn5vd9JwbH6?=
 =?us-ascii?Q?ygiwSj9JJxbPElp9v9O/UD+d+ZzTBf8TzM8OiAkJBm6jXn9m9kXLafP1cl9a?=
 =?us-ascii?Q?Zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9108f3-a70f-44ab-b41f-08dc1277b598
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 07:34:13.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWLWjmTpB+0T1dvft7VxaLN/+Fdr3Eb9oa9Xa444aZw6IT89/xIBl6w5Utjz4/lqkdgqNhWM4mAO3VrHse30P13/u0TklorKvFfV6FDp8f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910

> The HW has the capability to check each frame if it is a PTP frame, which
> domain it is, which ptp frame type it is, different ip address in the fra=
me. And if
> one of these checks fail then the frame is not timestamp. Most of these c=
hecks
> were disabled except checking the field minorVersionPTP inside the PTP
> header. Meaning that once a partner sends a frame compliant to 8021AS
> which has minorVersionPTP set to 1, then the frame was not timestamp
> because the HW expected by default a value of 0 in minorVersionPTP.
> Fix this issue by removing this check so the userspace can decide on this=
.
>=20
> Fixes: cafc3662ee3f ("net: micrel: Add PHC support for lan8841")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

