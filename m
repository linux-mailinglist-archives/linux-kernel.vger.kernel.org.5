Return-Path: <linux-kernel+bounces-79423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F398621E8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DABB22503
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936B4A07;
	Sat, 24 Feb 2024 01:27:28 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556423BF;
	Sat, 24 Feb 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708738047; cv=fail; b=Am42JiQoM8XmUSheSKh9bsAmA2peIP9PyJgMRqJqSMTGIlDEOXE/LPHeD8WLCI9DOuylzrUnKUIcIZyVPidoFec3t5Aq4SRajTe6v1tpIvvFo9xDwFEUgVVk/CDOBlQOM6d/GsRb0qFEDnl/mtPbZwOGEsTXVRTIYxghrWqh1mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708738047; c=relaxed/simple;
	bh=RqJhYt/J/Nn4wlLnPTCiGbw3kJ+bjvYVg0GfXqkUu+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VISH+2Z8C5xx9HmDDMXQfAJ9kkyxaE4oBjIv40K1KPLwyrqNxqxBw4iozvyxnK+wF4N2TC+8nFc7S1dycejwpTRxTT4MGF1XA6sMKv0QarhSr25VH5Fk5BHbWY4hORF0BFSDLP3wScQsRZFDfTePUjk3VwiSWto4ZHp5Ow+/40Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+x5hlQyu4JHNkt1Budt5OR8g01AkcgFyaGd3q+1xJ45iYIS72wgxl9VMC1Z5S0UIHocLTcHZAYyRF72bp9Wj+hw/fsnvYeFKwIfxTGIw+h1Or8x9ZsmNne3jYp1XiPL9KdIl+IqLzsSB67ftkkV15FVunN4ymI6CUcwcfkIxnEjTTxQFIoyQwB0q4a4E6Ee3DkLcTGjcX4jOX2Y0tbpEZiimHw5Z+C5rvp1dNBhMvLmP/uddVW9GhDObW3VYCMzQMSzG2jghQ/5oMsjgJxridjAITX2P+12xD+ScrF97adQbEVgIPBCU5Li12G9wp9MB4e/T0WeAibvBDa26QQdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5I+lJH1jfBJqp6R5/H7srzSXpFosvkZ7ZEWTS1HEjE=;
 b=nsPh5wdW52UmqAoZVD85zZ12rYYIVcdCqYC9gK+Qqq6Y4E7Q8Sb0XXGVN/vXMcqiqu/rzwa0u5ZNnQ31oqYFP/Wt5gzZM95GOJBWg/P4afm4qHlUnHjWGwYTbsuE0xU8uate2fuaX24fWlwS7NJ//YsOdiwhOSpp+1D0/fFBoipWItOy1E0mp2nEwT/vn+b7iiu7YomEmiAdmtkrbbjPoIOxAr2ZF2ykum/UhgppHz92nWCQH5AFBGxPqruapYw3J8GRxa5ykcE12j7hW2y9MxgoxKykIhUIZ5/sd49aVT3dPrYFsQdBlFx71eH2nXh6BN2EhVJ06JxdQHug8YypKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Sat, 24 Feb
 2024 01:12:39 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0fb:daf7:3f8b:868c]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::d0fb:daf7:3f8b:868c%3])
 with mapi id 15.20.7270.047; Sat, 24 Feb 2024 01:12:39 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Will Deacon <will@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 1/4] perf: starfive: Add StarLink PMU support
Thread-Topic: [PATCH v6 1/4] perf: starfive: Add StarLink PMU support
Thread-Index: AQHaUpjbN2JwsHfCRUyjP497yEf9PrEX8R2AgADfk2A=
Date: Sat, 24 Feb 2024 01:12:39 +0000
Message-ID:
 <ZQ0PR01MB1160A9376461CAE829BEA13AEB54A@ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
 <20240129095141.3262366-2-jisheng.teoh@starfivetech.com>
 <20240223112633.GA10403@willie-the-truck>
In-Reply-To: <20240223112633.GA10403@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1301:EE_
x-ms-office365-filtering-correlation-id: 04a494b2-f439-499e-070f-08dc34d5b1d1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u4wHggxmq2e5I9NYayPTs6LIcv7zPc/h2w+imQrfZj5vabAbujxQ+vDDLM5y9wdv5isY/nWuxKVaqCnJswXLZLAkjlnFvygzt941FZ/yWcMWw4qoI/zYZVC0SZT7GeY8godc471bfmjBKbQEDe3tfvPgDqg0sLcw8UEUwLSarO5dHpXuluMcofHyxh3kQiXwN8ZiW9DvFJj0wfbBBsSEl5yQ9xphWgZuL8rVcvPjtoSuIL7CnHOopLXJAYRuUticwzxzs10hBREKv5zS43+LjSI/tiKUlF+2PpZKuk0c2Ex5Q22WlASt8UzeHpdkco3d8FBZRYnXidaTw4OsoLC/F7lt+vmjprXy2klwXyR5SUd1k0yM1UIoMlSivq6U91iKDrAL4TqDrqJS4wdISH3YyVqP/PXQ0JtmlFLtu0zdO12hv3V2DFW0RVQBtz7Ya9Av5329cZ8ArRcSmGXh5Re4Sg+DLbvK7UHzek3fXFnyKgBWNCH1TKD6d1dRRS+PU/U8g/WqpcsoxkN+gFe89WejUfo3sbkR6MnACNjo4+RmCqiTRla7vgfcfCEyVYf78Qx+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6v3Z/VWNIwEs474CDbCxZVvayVL7kq8njMwJs3QyS49bpIOQ3ng3aRI2WXRB?=
 =?us-ascii?Q?xaIBpu+YmPNrn4TTg41GMHZCPKoHBlbqkOkyD8SI16TjzrRUT08rdsp6hBmp?=
 =?us-ascii?Q?a2T0YemL1D313Z2lQE2CmVozYwBMZeU70EPtUqHl0CVvK2b/Gl8pC2vF4kmL?=
 =?us-ascii?Q?Kr1oOoifJFYMXGYEsKKOsDhr6D+P2fhh3fs3swBCBlfYySXPMTx45shgwyd3?=
 =?us-ascii?Q?62n4YOMLkZr7XuaR4dhf2SLhHIrfTuaaqb8JHyelpKbaYNh35/Pzd1qf3v77?=
 =?us-ascii?Q?Cam5AkfRv5a2+YkPiDohA6PVrWsGjdonjtydmFHmpW2zlMY4SjO4BZlcHrBV?=
 =?us-ascii?Q?xX213V06kt+1g9/PLqpscvlT4uH+/hSoMNMHp6Sx3XnnyMFhWMCTHCFQXxQt?=
 =?us-ascii?Q?458M6UMvfggWSeEPhMZy2+F8Vpf/ndvumINzPztPM5kiLtde4pfCjajEHRlW?=
 =?us-ascii?Q?czzzkknqXMlgeoonWi/tUofgQQoBCkyihMx/B8XNCCk2ncUFZ9+YIdsG/sd2?=
 =?us-ascii?Q?mcSz5oJv6hOGEfU2FN5F2eIwmgiezoJhCbSacnLJfNIXTebtjn5PKKu3HNeV?=
 =?us-ascii?Q?76U0wy0gkELHIKSlv25Z5FlBzgAh0HB6uJbTiTWI+MknrNY3mQFN4RlgOzPA?=
 =?us-ascii?Q?0zSeCS148zsparkfHU2UHclEbMIy1uH3ZUPlmENgjyKBsqww9PwWEYIPzIiO?=
 =?us-ascii?Q?pGXcJiL/Cl8VEtcpc0ECRZukOGfv9vX/fNHD7CxTLRl1yHcyVIbqQusKyBRi?=
 =?us-ascii?Q?b0i4jriqoADPetBd37kt6YvXmtayzrJlT9+Cvn5/8SF5hRWHXtn6l4phmxg8?=
 =?us-ascii?Q?mZcZomW+FBMEsbnnJU0CM+STTjFWPXCQG/5LfWi0MQUu3R5fWNXJsvQVrSCI?=
 =?us-ascii?Q?4EXqUPlkyYEyeju/dS537m5ylaWepatbf5Gp9ExJK7G7MaBvipJ/f8ad05xB?=
 =?us-ascii?Q?7uMw5HGZVsYQgwx+5ootdongjzyDeY9lB7GjYVo4zK+u2pcWfcWghU1IovWC?=
 =?us-ascii?Q?PCMuW26WMciadc8udlKtP5/8dRFFHLPkPZU87kGNpO9zp4JJes1gDsflPBAy?=
 =?us-ascii?Q?2rQcNk+G6IxKbzxq/ZX16+2B5lTUVyBenw95Bch53nvpnv9VZXkJ28ibAUx3?=
 =?us-ascii?Q?8O2zICyDu26gqizwt/tnrUxH2SyorkRq2a42E5jm2yfkw5DaBVUzBKhv1rrR?=
 =?us-ascii?Q?iyF2Chm2AqLoUIuoZTc8YPEFu8W2Rgr/WiOZ8DyqVBS/Ks5c0s3Z9s3DD3n2?=
 =?us-ascii?Q?GlM/CR3ej/0a+m9j3NbY6F8zO0D4SnMypbMNRAlAYX8z0kDYU9A43UobADVO?=
 =?us-ascii?Q?0U3U6CcRL3MHP7dgAxPCyhRBO0lqrveAeJWNTw6FgtLbdtp2Or6kHRfXSMjK?=
 =?us-ascii?Q?9rLhVEef3XjKYHR5Ve0B1aW17JH3osDSfHFCeMiSyYdd/ywUbpgmHCeOXF9P?=
 =?us-ascii?Q?74xGZ8Byb5uz+gjUURtelCsmkhZZVrQqqV8YYRfhfFWD0UcnlZrYSV6iA2Ba?=
 =?us-ascii?Q?gUn37r3WhG9iViqDsf9uFu7PTc/+DeGuKyhGpwq8xsorFKv0trDE83jrBlcM?=
 =?us-ascii?Q?FaqV/L578Ga+bS56Q6qLTFAJj2NGmtk75jUlQxaNIYy5/3ZbfrKFi3AFgXgk?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a494b2-f439-499e-070f-08dc34d5b1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 01:12:39.5679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBeY1yoU8o11yubo2pbUSw5GHuGFk7mTRvbFOuHOROKYhI2+AH9moKpNM84VLgcxgYNWY083g2rBC2bHnPH46ZZtaxEYo60ymimEOWIkHoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

> On Mon, Jan 29, 2024 at 05:51:38PM +0800, Ji Sheng Teoh wrote:
> > This patch adds support for StarFive's StarLink PMU (Performance
> > Monitor Unit). StarLink PMU integrates one or more CPU cores with a
> > shared L3 memory system. The PMU supports overflow interrupt, up to 16
> > programmable 64bit event counters, and an independent 64bit cycle
> > counter. StarLink PMU is accessed via MMIO.
>=20
> Since Palmer acked this (thanks!), I queued it locally but then ran into =
a few small issues with my build testing. Comments below.
>=20
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
> > 273d67ecf6d2..41278742ef88 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -86,6 +86,15 @@ config RISCV_PMU_SBI
> >  	  full perf feature support i.e. counter overflow, privilege mode
> >  	  filtering, counter configuration.
> >
> > +config STARFIVE_STARLINK_PMU
> > +	depends on ARCH_STARFIVE
>=20
> Please can you add "|| COMPILE_TEST" to this dependency so that you get b=
uild coverage from other architectures?
>=20
Sure, will add it in the next revision.

> > +	bool "StarFive StarLink PMU"
> > +	help
> > +	   Provide support for StarLink Performance Monitor Unit.
> > +	   StarLink Performance Monitor Unit integrates one or more cores wit=
h
> > +	   an L3 memory system. The L3 cache events are added into perf event
> > +	   subsystem, allowing monitoring of various L3 cache perf events.
> > +
> >  config ARM_PMU_ACPI
> >  	depends on ARM_PMU && ACPI
> >  	def_bool y
>=20
> [...]
>=20
> > diff --git a/drivers/perf/starfive_starlink_pmu.c
> > b/drivers/perf/starfive_starlink_pmu.c
> > new file mode 100644
> > index 000000000000..2447ca09a471
> > --- /dev/null
> > +++ b/drivers/perf/starfive_starlink_pmu.c
> > @@ -0,0 +1,643 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * StarFive's StarLink PMU driver
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + *
> > + * Author: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > + *
> > + */
>=20
> [...]
>=20
> > +static void starlink_pmu_counter_start(struct perf_event *event,
> > +				       struct starlink_pmu *starlink_pmu) {
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +	int idx =3D event->hw.idx;
> > +	u64 val;
> > +
> > +	/*
> > +	 * Enable counter overflow interrupt[63:0],
> > +	 * which is mapped as follow:
> > +	 *
> > +	 * event counter 0	- Bit [0]
> > +	 * event counter 1	- Bit [1]
> > +	 * ...
> > +	 * cycle counter	- Bit [63]
> > +	 */
> > +	val =3D readq(starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE)=
;
> > +
> > +	if (hwc->config =3D=3D STARLINK_CYCLES) {
> > +		/*
> > +		 * Cycle count has its dedicated register, and it starts
> > +		 * counting as soon as STARLINK_PMU_GLOBAL_ENABLE is set.
> > +		 */
> > +		val |=3D STARLINK_PMU_CYCLE_OVERFLOW_MASK;
> > +	} else {
> > +		writeq(event->hw.config, starlink_pmu->pmu_base +
> > +		       STARLINK_PMU_EVENT_SELECT + idx * sizeof(u64));
> > +
> > +		val |=3D (1 << idx);
> > +	}
>=20
> I think this needs to be a u64 on the right hand side, or just use the
> BIT_ULL() macro.
>=20
Ahh ok, will just append it with BIT_ULL() macro.

> > +
> > +	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
> > +
> > +	writeq(STARLINK_PMU_GLOBAL_ENABLE, starlink_pmu->pmu_base +
> > +	       STARLINK_PMU_CONTROL);
> > +}
>=20
> [...]
>=20
> > +static irqreturn_t starlink_pmu_handle_irq(int irq_num, void *data) {
> > +	struct starlink_pmu *starlink_pmu =3D data;
> > +	struct starlink_hw_events *hw_events =3D
> > +			this_cpu_ptr(starlink_pmu->hw_events);
> > +	bool handled =3D false;
> > +	int idx;
> > +	u64 overflow_status;
> > +
> > +	for (idx =3D 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
> > +		struct perf_event *event =3D hw_events->events[idx];
> > +
> > +		if (!event)
> > +			continue;
> > +
> > +		overflow_status =3D readq(starlink_pmu->pmu_base +
> > +					STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
> > +		if (!(overflow_status & BIT(idx)))
> > +			continue;
> > +
> > +		writeq(1 << idx, starlink_pmu->pmu_base +
> > +		       STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
>=20
> Same shifting problem here.
>=20
Got it.

> > +static int starlink_pmu_probe(struct platform_device *pdev) {
> > +	struct starlink_pmu *starlink_pmu;
> > +	struct starlink_hw_events *hw_events;
> > +	struct resource *res;
> > +	int cpuid, i, ret;
> > +
> > +	starlink_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*starlink_pmu), GFP_=
KERNEL);
> > +	if (!starlink_pmu)
> > +		return -ENOMEM;
> > +
> > +	starlink_pmu->pmu_base =3D
> > +			devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +	if (IS_ERR(starlink_pmu->pmu_base))
> > +		return PTR_ERR(starlink_pmu->pmu_base);
> > +
> > +	starlink_pmu->hw_events =3D alloc_percpu_gfp(struct starlink_hw_event=
s,
> > +						   GFP_KERNEL);
> > +	if (!starlink_pmu->hw_events) {
> > +		dev_err(&pdev->dev, "Failed to allocate per-cpu PMU data\n");
> > +		kfree(starlink_pmu);
>=20
> You shouldn't call kfree() on a device-managed object (i.e. allocated wit=
h devm_kzalloc()).
>=20
You are right, I will drop it.

Thanks for the review Will.

JiSheng

