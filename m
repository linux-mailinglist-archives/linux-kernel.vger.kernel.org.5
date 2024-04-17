Return-Path: <linux-kernel+bounces-149080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC18A8B90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB90B2882DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF338F82;
	Wed, 17 Apr 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="evivoweW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tcyJjr4A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2918C1F;
	Wed, 17 Apr 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379742; cv=fail; b=BTYjVynLvHUzbP5VHIvuunnDMSE4ueACllkl/M242V0KDEuUxZ4InZtbeEJdFHxiY8RNesiNRKOqTsukIiP6ibIYM0FALEnmJiVZjDqzux8w/dAEAoO89ZDZBzwBjqI89+BpoeZ4yIT0nc/cYTAxjkVkHCIc9rxovZv6cyAXSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379742; c=relaxed/simple;
	bh=JnbzzCRK3NVgx13t/ZLahmPzOhFjlrMsWJR9qMuPDvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMHX9v4LEV/MacfGtgRZN68xhBKq/uwoP4MlpK91zomVplE9MNWrEtFcrhoABXnmS7IHtzlWB+Y+PiApfhQnLKBwLjN8gYpGeF14u0IHwiySly93xO51GgpJ3jPPsk2f/07TwdVzmUf+zJz2Jn73BT2T08+8vsZ8xSifAwosUX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=evivoweW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tcyJjr4A; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713379740; x=1744915740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JnbzzCRK3NVgx13t/ZLahmPzOhFjlrMsWJR9qMuPDvY=;
  b=evivoweWBLRgYnC4cN9v8Rx+oMRM6yMUUynPVWTFC7LYLrUhIpnKhL5Q
   BxPd4lnhcdZh7Z9fN2613bD1nELcHcCKVmr45BypUURYklMlYQZDkeT7i
   8kEDY8SJbk8j5MXeaQclxWtb82/Y+/DusZPm5MHrDw1CafsFviifTJXwN
   DdlhV59+9sm3WGKKpETnWh3fw4mseXoIP+v5ufNhIsRHGhKFiGLZafKVr
   gZiN5zXy9WWGUcSXKPeRXuHG9JP7u3xcV6PWekbTWDYaHS0da3/+W7wZV
   q69UxkGBGMEwKrfl1ZdqZDbuniNs0fCG+aB4G6iDdydDIdhE0EktJHYxU
   A==;
X-CSE-ConnectionGUID: KreCp7MmTv+CpTJUxO088g==
X-CSE-MsgGUID: whbF3NLrTIiMQcY0w1vCMw==
X-IronPort-AV: E=Sophos;i="6.07,209,1708412400"; 
   d="scan'208";a="252292688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2024 11:48:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:48:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 11:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFeMgj5QT7U6JzFfuu43Kalwe0V+EYXSb9ycvrRT2/YwsY7CMb5d2aZrFLYxU5Y0GJRskEnpxxI08JCeJL0b0zudVUMJyoZ9YPIRDDkHVGu0aJsQE8cUEdRhyPJ4KwywxNlm1BPd6Bs9YIdaaX+z/ZaOUwjXYGKrjuhg3nD0+aPSzfwVUmdKVPgYEBa0IIdl1YGH4CzffKhx6tcxv5pPvsaj0wC5XmZLsbTAmDAZPiq+6BpoxEOwYuw9L7FOE/vfhkpX6OPeqFbpphddW6vKAEEzUHI0LKoaZm2RwSWi2AnGwe0jlXB+BsQBZPF+OjLkmG53bffV6IOCj2nt4Pg0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKdT4Upb3P3ihQ8ND1llXIuIsdBqmcFAG68mSY4fm9U=;
 b=HVslgd3pH+i7K+9ugVl565+ibwlVSN30ItlxG1+P8K79XDrUsW7T4uQJjivGEk7+eaOBv34Riu5S1ThWI0igqnsRQWh+rinNZaJl6m/84OGbIM7RBN78EnatTn+sUAUS7mFp2K0uPq2JaWvASFm0rHkhcnTEpBpYOOQTn4nRGtAikKXT+5eOdolF83r0VckT44Bb7HsIO5Gefoc81HEmSJQ8BSBFco+M2fNCMSf4yxLJ7dBqmARosxRVMuRCNNqWX5bSXXjcMkI6KBDvVfrhITXlnWSl2iEvujk6RFl1YAR1oDpSjes8jQp1GVdzbkXTen+O9ShKk42YpbR8kA1sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKdT4Upb3P3ihQ8ND1llXIuIsdBqmcFAG68mSY4fm9U=;
 b=tcyJjr4A8h+Mcc7DvZv4cFT7UbztRDJYYweAVTNR/a3QpPQ20yWKzCIJI5r63aqhzHFNSIZ2CdKVetnGC1EVXPj4K67rNv33z2mwTiq+BXJ209l++2mRxg9YKrwH0eIY8hmaBmHxk06U4Wet/6QeH2HcD9Z65vhrouOnAnXTJQJIDxL1drq2iF1i61Uhew2NZAL/0G0jRkIwes+/Ot0yXuQJaPuyEZg76+ElL7OZwu2BJVoUPFqb+OCiRbx9uzREfeutbjVswpWGeR9B4mMztn21KMMf+vnc7btYcQcStveTVUwLweb6BFlZ7bcIG+aSYSZTyaU+Cu8msWMljFAUag==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Wed, 17 Apr
 2024 18:48:37 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 18:48:37 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <davem@davemloft.net>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
	<Arun.Ramadoss@microchip.com>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH net-next v1 1/4] net: phy: Add TimeSync delay query
 support to PHYlib API
Thread-Topic: [PATCH net-next v1 1/4] net: phy: Add TimeSync delay query
 support to PHYlib API
Thread-Index: AQHakOZ/fzt9Dn9Rq0KDo2lZUBVTB7FszMaA
Date: Wed, 17 Apr 2024 18:48:37 +0000
Message-ID: <BL0PR11MB2913839BD93ACB61B06C30F4E70F2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-2-o.rempel@pengutronix.de>
In-Reply-To: <20240417164316.1755299-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|MW3PR11MB4668:EE_
x-ms-office365-filtering-correlation-id: 000d264e-8171-401b-7ece-08dc5f0efdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6E3CJG84AB1NYOSX3f483WeNmnHQHXV3D/uiIk6ZiVipnJKfI/XB8D9u+2TnTu0P+kccBD1SJsbmN+7hDfEYkTZ5StS7xGn/MI2i/ATA6LLQG+VUnCvfPZi5HD6L4EvlyX2RXdRp3OXjcbR7SZ2qvwc/SG/rsCT4+7BT3BZ0sdpkx6Cv+NloBtlTwGs53cQJ/kZoqzxg/EfVBnk1PIkdxJgMpYm+5FZhAVXGjnvZtkVhjY4Iw5HRr/G/fpoEtpyaJMOqyhQ5jn4McPaYFxyWAzL7KQb46WKeTq9x0UFmjMIZGU6nM59a/7MZ7WHjh1AYSkWT4VSfP2J8eHB9vwdd10vmxLDimYAaxJFPFtDT1dRqEDO9ZPVmaINifIkxZNKqcp+2QkDmRTUnO3n1yziQcuQVu4QhGvfJDVkco5iM/7X6oDg8X9mznGCulR+rizqEfPtUzaEblD4MPgs1p/LGbxi1Ijahh1VcAii/JzJEd+llBm29QP5nzObBS6aCAmJXGrGWy+kq8OV9YGCivuqfYm/0K8a5Ej3e8dOoePKx6Ske7xrVZ5LN+lo7kA957e/PNeLC1sVWZr/CH8HVDDrtoiFnUhbLvkFrGy0waPgwAiPGpmaCNwasTa6i99TR1lcuVuoUgwLExfnpLDSmOgPm94sRlxWeU3sRiCwxCbksWp096gSrUmn4FRI/NLIuNJDmjLRjryPZkLp8LCaMSKMneknwABW7eg+Bn/lOYAXcj4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUfbsqbBP6hVsBAgs6rXnjTuNQVK4nlXyqXi/QaV/CuIELQHY7+AlbfM/RxL?=
 =?us-ascii?Q?K55l8FP9sBnNgm/uXPWgLtVewBcDJC1Fhs4Dmr1NgawvKcQRvr1W9r9/5p+/?=
 =?us-ascii?Q?pf17O61OqNQDU5JHof85fihQ9GlSmGnrocHj3EMiLZ5b9xJRxnWcMNBOZv5H?=
 =?us-ascii?Q?2fznWpGl2lVJ6W0VmsUzAAriUcBn59+ZIYPEnVdo2kRTTPrr2LGQPLTwyodK?=
 =?us-ascii?Q?fQaKaS9vk6h5W1Zfzdugr4JtCHrzLwXp1J9A3wIGKizoRMG7hOn+JdWgdOCv?=
 =?us-ascii?Q?iT8lN7TRolRBeNxt3gqVpoSkWYfFBY8qioNtNWEeG4lNmR92IQ8b9sw5Sdif?=
 =?us-ascii?Q?BC+5Rix82+90aOIBPakCxt3iEEfgW7veH1sKM3qgbqqsY53761juQ4usaoAO?=
 =?us-ascii?Q?qhdufqz4QPO/EQY0OSmayTq5ijJUNiE6+rVhRV5YIq2XlzH54IMXgQ63CXZ2?=
 =?us-ascii?Q?ZMDMJrh9rQYcqndIL4SxoKSFY7r3+/BVdyFe0Ax2+5TI5IjlW6utY4j3yBCe?=
 =?us-ascii?Q?KlTi9jmFQNvgMOMY5/mx8mjxKPPuZigvYSJuUsbTPQlwO6U5kxrAr2WzuJYz?=
 =?us-ascii?Q?pmIIEjZbBUTDWaAcBYERSaA86R5iwSTi0Z77lYk1Tm4mibU+OuCqXijRYOhr?=
 =?us-ascii?Q?KS6Z1D6QNImvOUrSm+2/WX6zdFNZK5fVGBlGc2mVEVKpRNH2vG/2+xmlEDPS?=
 =?us-ascii?Q?wmfuyyJ8z2eaZQdyv7USu5jxfPUPPECWUHbGiskxhxq/5KdfU2h5+LxuFyDQ?=
 =?us-ascii?Q?vSBDQHEDZODob2wCG7ACO1huNnvXOaDlU3H5rVZzSox/nt1zneL3lctSRUAB?=
 =?us-ascii?Q?CADEtSR0EHoC8/QdBcUk/Z+ITQ+HelU2SzYuin/P2bq3oCgRLUN+nLbkKyeJ?=
 =?us-ascii?Q?lzrpodgWS5vfe98kPy012FBqKHLbRY4mxk1jREFLckohZhcgcKUB59e71jhA?=
 =?us-ascii?Q?1/qncpOkLXsC0TBnYd2oLISUBuIeFKigDIHBYHFvgCdRbZQ0xohg41/3fXUz?=
 =?us-ascii?Q?9Y3kS7AAbyu5w45idAlQBSky8KJC6AakJzcWxJmNfUgkJlBQWLKeWT/xomAt?=
 =?us-ascii?Q?TmlBURNbY0krHFubXhQyQC0GZocX6PnIWEFjOE/zmSyLtHfDa/xYqp7JzbS2?=
 =?us-ascii?Q?uXALUHEygc7nYdLtj7N8bolK4fXRBSs7WXV9YcYcpAH2M9Wn1Nj+c7ZwXieQ?=
 =?us-ascii?Q?1GpAjJduFLVBWI4Lpa11zGHWcM3yNsh4SqMtBh7KsFfzo/hlrkbQ2apyE46W?=
 =?us-ascii?Q?4pKkdZxmSwKaioy6UI18zjyDc2nX7kxnx8Ra714LI80POl3D1zyp926YEeCL?=
 =?us-ascii?Q?LO4koflUWqDT8MWz2EhyJdaUk95UKT8Zt0TRFsqwGSCO6ONZDVMPXahz/0wd?=
 =?us-ascii?Q?LMYFAVxWwZCWnggYMU6rYswyC6e6bTG6wlEqKwv2vA7avITwCJe4tj0UNneH?=
 =?us-ascii?Q?VMl9EBU/2ja6WQflQP8pmThAnqyuMp/gIukKNVcVukni9g3GDBW3vecUfUIW?=
 =?us-ascii?Q?DvcbirxwbhRh1T3lZ1ri2icnAHONuqhDmBjHtMFY0z1lvPmHV5Ho7eqy3800?=
 =?us-ascii?Q?RQYo4RuIFnOBf8Nq9mUfuiAPAgkgaXaClMp08QOF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000d264e-8171-401b-7ece-08dc5f0efdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:48:37.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNO19DNRGT+ON526tr4DnE+QL7scYzsbhtGRGBiqZUwlNN0sNHMT7XLEMMCrSs4RO3CiE33YA+9e0GR8NR41PlT5GuN86M55bu657HPaekg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668

Hi

> +/**
> + * phy_get_timesync_data_path_delays - get the TimeSync data path
> ingress/egress
> + *                                     delays
> + * @phydev: phy_device struct
> + * @tx_delay_ns: pointer to the transmit delay in nanoseconds
> + * @rx_delay_ns: pointer to the receive delay in nanoseconds
> + *
> + * This function is used to get the TimeSync data path ingress/egress
> delays
> + * as described in IEEE 802.3-2022 sections:
> + * 30.13.1.3 aTimeSyncDelayTXmax, 30.13.1.4 aTimeSyncDelayTXmin,
> + * 30.13.1.5 aTimeSyncDelayRXmax and 30.13.1.6 aTimeSyncDelayRXmin.
> + *
> + * The delays are returned in nanoseconds and can be used to compensate
> time
> + * added by the PHY to the PTP packets.
> + *
> + * Returns 0 on success, negative value on failure.
> + */
> +int phy_get_timesync_data_path_delays(struct phy_device *phydev,
> +                                     u64 *tx_delay_ns, u64 *rx_delay_ns)
> +{
> +       struct phy_timesync_delay tsd =3D { 0 };
> +       int err;
> +
> +       if (!phydev->drv->get_timesync_data_path_delays)
> +               return -EOPNOTSUPP;
> +
> +       if (!tx_delay_ns || !rx_delay_ns)
> +               return -EINVAL;
> +
> +       err =3D phydev->drv->get_timesync_data_path_delays(phydev, &tsd);
> +       if (err)
> +               return err;
> +
> +       if ((!tsd.tx_max_delay_ns && !tsd.tx_min_delay_ns) ||
> +           (!tsd.rx_max_delay_ns && !tsd.rx_min_delay_ns)) {
> +               phydev_err(phydev, "Invalid TimeSync data path delays\n")=
;
> +               return -EINVAL;
> +       }

Because all 4 variables are u64, it can be zero technically.
I think the condition of "max >=3D min" could be better option for validati=
on
because actual *_delay_ns is average of min and max value.

> +
> +       if (tsd.tx_max_delay_ns && tsd.tx_min_delay_ns)
> +               *tx_delay_ns =3D (tsd.tx_max_delay_ns + tsd.tx_min_delay_=
ns) /
> 2;
> +       else if (tsd.tx_max_delay_ns)
> +               *tx_delay_ns =3D tsd.tx_max_delay_ns;
> +       else
> +               *tx_delay_ns =3D tsd.tx_min_delay_ns;
> +
> +       if (tsd.rx_max_delay_ns && tsd.rx_min_delay_ns)
> +               *rx_delay_ns =3D (tsd.rx_max_delay_ns + tsd.rx_min_delay_=
ns) /
> 2;
> +       else if (tsd.rx_max_delay_ns)
> +               *rx_delay_ns =3D tsd.rx_max_delay_ns;
> +       else
> +               *rx_delay_ns =3D tsd.rx_min_delay_ns;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(phy_get_timesync_data_path_delays);
> +

Thanks.
Woojung

