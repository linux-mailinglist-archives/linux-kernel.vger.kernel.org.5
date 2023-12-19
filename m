Return-Path: <linux-kernel+bounces-4752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BC818195
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6535281E35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30A38495;
	Tue, 19 Dec 2023 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qaVMu0fp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38275C12A;
	Tue, 19 Dec 2023 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhUcybGOl90uoKfGsBsA9W3QziG6jVKM0Gk635eq21H+VMJkqwUNvtKPNoDIQ32zQS/kiCpcW7qL+AxiP9A5VN2okdEIg0eomUDkkwds9GsXBRm5oFqQ7a1wo8jy5s8yoObpAzaZeTGm7f8l0C3NLx3SdHdxKutdVHYo4EcVQCVc9l1gDVctCP0FMHOTnTbSUFiRgwAI/a5enAV8oUvtRHeClu9vP7alemFVel10TM81xI3irq1H+wZ3GHsrvZnha06QkY7PyK2l5zIpv2B+zhWu7uqBO3moJ56FIKBkTHWrIfJA7ZUja9ovkBTU71y8RiEHk7d4WgLA1lXYbiGmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtPq5Xen3dt84hCMDrKog9mgI8LDsBXHzr4A4DzOH0M=;
 b=LDdKkBxHh+T7rKzFzPWdXsxyWlIN8DTAZqPC8UQ/zLgnBwSs4AY6/OoQd2Y7usRF6g5CcTP9M3LFTvITiN6Re+fsWcVpXNBVeeR8utKDYt5BHso9MjLRqVE0tzqnsFrNopj4KzJaZnrxh1XwPoTSya8/Nq36N1mCJi3/AMhH+jPv+HN6xj/5lCG8ciHfdIPbnWsfxh04+OIfqHfpEEOe4FdFJY2x/9l6nMGk212TMCyLXoE6qM09PqJsv1nbViBn7tquyvPHuFNCSDFrVKr8TR/PGUMXQ5slGz6WNtkvkjy5TucNrTjhMt/5XDxnEeK4mUQWlheyDJjN6gVTNkQw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtPq5Xen3dt84hCMDrKog9mgI8LDsBXHzr4A4DzOH0M=;
 b=qaVMu0fpPGg/9v1rvzRQ6ky1IxuHbH2DaQqSUqoloIa51oLMdOWw51njiP8M/3V3S5CxvWkeqmHXDd0tWC0CloZfWFhaDNMjYblxSoSKFeDuHTb2tzkh9+/hTTl6Co/NuQ+qZvrLwx0idSNFoj/sUQlB/u4lNGAr6XuFc84sKQM=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 06:34:12 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::9246:c3f6:f25f:4841]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::9246:c3f6:f25f:4841%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:34:12 +0000
From: "Goud, Srinivas" <srinivas.goud@amd.com>
To: "Goud, Srinivas" <srinivas.goud@amd.com>, "wg@grandegger.com"
	<wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "git (AMD-Xilinx)" <git@amd.com>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "appana.durga.rao@xilinx.com"
	<appana.durga.rao@xilinx.com>
Subject: RE: [PATCH v7 0/3] can: xilinx_can: Add ECC feature support
Thread-Topic: [PATCH v7 0/3] can: xilinx_can: Add ECC feature support
Thread-Index: AQHaIRyEKdnFZ9Wp3kC/SK97OWIkBbCwMtQw
Date: Tue, 19 Dec 2023 06:34:11 +0000
Message-ID:
 <PH8PR12MB6675D8145EA3B95315186C72E197A@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
In-Reply-To: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|DS0PR12MB8248:EE_
x-ms-office365-filtering-correlation-id: 707b0afe-8be8-4be2-e7ce-08dc005c8333
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qc/QHSwgG5NXV+kWCaGc490L+Ie2ngyY934rDqeWf+ny96/sbrn/sBHYxULgbUwahN90uxmlIvxNiC04VJfOoLXBqnUtX22Fv90EtHrg8WHzEiZFCkL0RwRU3G1EKcZZh7/ItgeWT99DgRka3ZuNa8PLg3UZg7G21IYGtRKGq9vAieqLX9ucDXig5Bs5rw8hbHL0+9AOMcjBObO2H8wKKKg7eA+1dlCWJHW0lgoozTH954t3iewwRpEqvl411qOQNDmMi5qWXOvHHFkaXUJYoXA/o4YpJDa5YrgFygGTmmY7ra6x8lloxiPQ+ffkHgOvYec0Zul39MYQpieuALDkQQJ9SvpR9g08uk33CBBfewtJNqbT3dMWx9Dyumq78/xpR4HPtR4FQGY8PnOhhNR/Bb2FPOVvYvIm5XttVLI5E9JHeIkoRsYV4KxLKjZI3HLh4ZKDKluWBfFuEveah9UZkSyibuMrAcYY2reCLkyl8tRvq1zsmFRgjjvDI5tDl4nLXVAE6Ss8qGZFXqMWkYAb/Vuq/ch8uDFEHpFn0Y1UCgkGOPk08u2CUizRqDy/qV9IJ4f/R+RVtbZ7Spbf56vzDqztfoJsFjpwo3kn3rTvXUxOyuwnKm7h7YCXkvkrYVRDEvrqIOJbZahNyj5wKC//XL1tohtx4plHktqvlW57o7Cw9yKgzB9dAuEkNDLu8sHA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(55016003)(38070700009)(921008)(76116006)(110136005)(86362001)(33656002)(38100700002)(122000001)(26005)(83380400001)(71200400001)(8676002)(9686003)(478600001)(66476007)(54906003)(66446008)(316002)(64756008)(7696005)(66556008)(6506007)(2906002)(8936002)(66946007)(41300700001)(5660300002)(4326008)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IGwbtjIKs9+zdMTh+2rbjdwWvdDo2WJt4+JKTxLu0N2wehS95jQ2dl4b9fun?=
 =?us-ascii?Q?3cxsWR9fBTeapsQxeUoietTLd5LS/lyqkQJcp3Hpu28PtRqFqdQMjke1lOsR?=
 =?us-ascii?Q?y+QduhSsOVGvs7v2oM7nXpfQ5Js9KjOYf4TgWvIq455lKvlElMfd73dwswzE?=
 =?us-ascii?Q?1uqDH7uOwlJDULYoRMalRvZjJYYJZycBJ7yyi19SS199bCyKh5Pc9G+KA+xf?=
 =?us-ascii?Q?7oz8D+5spJWIik8nYFaoUDI9K0t4vWFFuZOpK/l3td7A237J72TVQJ3/y7su?=
 =?us-ascii?Q?0flKC++kVrXMQA0OVZfQzikHljJ7VqcEJl4LsrUvy868YwdiGrYByE1AbiBt?=
 =?us-ascii?Q?nYV73tV7jIECL75SqFu/rRoYzALuPqagLYyjx4bjDIEfh5N6CtFWnIYHG7DK?=
 =?us-ascii?Q?iWD1+Gc1kKgSwCdE5YaA/OdA+iJ4Q66AYjBr9Q5E/1uXOYfKV2pkgsaR+apt?=
 =?us-ascii?Q?IzLrxBIlxGvyu1/8OXUNVEhLxfPwUYOSnyeWpvibhDCW2hCagQJioXtjQGn5?=
 =?us-ascii?Q?o9XuKTOY7CIBJpXJVj9H3gN8wHO0c3iQCRvNUSLgtq9BOViXasEtNjRNP+t0?=
 =?us-ascii?Q?ThxgkMUlqijFSC7P5wT7O9dBQFBxbKks6OH3CPEk5miwe/oZNeqc/yPKr4Dc?=
 =?us-ascii?Q?7jVB9aiZsWn2wKcDeoblSzsQcN1MPjuwBigXuKl1UjwY9XOudjgqcHQ3YSBT?=
 =?us-ascii?Q?S8mRKMe0JLXGpEIZg2syKX+kpIU/sEyoObv0apDkuuEISwHmkxkVSOkXDwH1?=
 =?us-ascii?Q?MO3TrcZ6Q3Ssg/qD4P2PU7dB6D2NTaIMdiZbJ/h0t9mR7jfqpUG5dTxIpnTM?=
 =?us-ascii?Q?YOsPSVAU69N/uiBidDEDJfqOsEPK50+/S91TS32LzQDmCGBxi/Fz/6SKBkvZ?=
 =?us-ascii?Q?NahinWuF+fd0s1eKWDMCQCQYALa4b4SAML147duFwELYbp0d3bnINMGWA7p0?=
 =?us-ascii?Q?yUqWefuWSZVhRY7FKYrtLHnp7EdBZ/hjZKgab9I4hDu5j6AQshoGt0VqD47/?=
 =?us-ascii?Q?4nVR3bowV/3hFgFwxk/J763r1TeUyU4JVkpUDjjvOUdLHiI5BGn02IFQNSe5?=
 =?us-ascii?Q?Uf4NmhZmm2Vp7qHdciRFlhd5Kdtvy1hXfbkTeKL2xMLrp6aOXQZnL+5igkjx?=
 =?us-ascii?Q?HJ/yC04IsbKrkhkpUHvvvDGX30aZ6mONp6VDu9QTHNTbOxn749Mhe6x1LrU1?=
 =?us-ascii?Q?lP9GhnrFopfMOLdyfm9I5GieTVxWO/8a+BtMgAfIpBZ1kelVTqxY2eLo0LUg?=
 =?us-ascii?Q?r6lpz2mHfDpHBbCF90rKhy9DReHpAyzaMrIZc17W7MYw0f5TGvm6GfEqsrJg?=
 =?us-ascii?Q?/0ZQ4KV0m6Awryi7VgXjhtQBbyHaUSc/3XTfatF0SDvN9JxEzJ8+XCfSgEOz?=
 =?us-ascii?Q?HCORcDH1Ruq/zq8umeH6urFU7J+NNER1Z6SA8fXKEDYggCrc+JDtXQNPceKg?=
 =?us-ascii?Q?W+iKPoqK4WBbSuMN9W462+xuE7/Ppk6AvTGr7hJIl1JcSzY1gWZsGW0C32DE?=
 =?us-ascii?Q?CEIx/GUQykV4CV7+N2HVrtBcPfhFDCzM4KDd87Qpus5DDXU5arkqZaDt5SVu?=
 =?us-ascii?Q?XUIedNCrsgDEnfRc7oM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707b0afe-8be8-4be2-e7ce-08dc005c8333
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 06:34:11.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8t1iPb6G+h5YiRJx7qXxcUiU1q65CerkgHYqCQmh5ChxpjdsFU17l6gQWxci20G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

Ping!

>-----Original Message-----
>From: Srinivas Goud <srinivas.goud@amd.com>
>Sent: Monday, November 27, 2023 3:58 PM
>To: wg@grandegger.com; mkl@pengutronix.de; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org=
;
>p.zabel@pengutronix.de
>Cc: git (AMD-Xilinx) <git@amd.com>; michal.simek@xilinx.com; linux-
>can@vger.kernel.org; netdev@vger.kernel.org; devicetree@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>appana.durga.rao@xilinx.com; Goud, Srinivas <srinivas.goud@amd.com>
>Subject: [PATCH v7 0/3] can: xilinx_can: Add ECC feature support
>
>Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
>ECC is an IP configuration option where counter registers are added in IP =
for
>1bit/2bit ECC errors count and reset.
>Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error inte=
rrupts.
>
>Add xlnx,has-ecc optional property for Xilinx AXI CAN controller to suppor=
t ECC
>if the ECC block is enabled in the HW.
>
>Add ethtool stats interface for getting all the ECC errors information.
>
>There is no public documentation for it available.
>
>---
>BRANCH: linux-can-next/master
>
>Changes in v7:
>Update with spinlock only for stats counters
>
>Changes in v6:
>Update commit description
>
>Changes in v5:
>Fix review comments
>Change the sequence of updates the stats Add get_strings and get_sset_coun=
t
>stats interface Use u64 stats helper function
>
>Changes in v4:
>Fix DT binding check warning
>Update xlnx,has-ecc property description
>
>Changes in v3:
>Update mailing list
>Update commit description
>
>Changes in v2:
>Address review comments
>Add ethtool stats interface
>Update commit description
>
>
>Srinivas Goud (3):
>  dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
>  can: xilinx_can: Add ECC support
>  can: xilinx_can: Add ethtool stats interface for ECC errors
>
> .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
> drivers/net/can/xilinx_can.c                       | 159 ++++++++++++++++=
++++-
> 2 files changed, 160 insertions(+), 4 deletions(-)
>
>--
>2.1.1


