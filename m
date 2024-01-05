Return-Path: <linux-kernel+bounces-17825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE382533D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF501F237A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F382D04A;
	Fri,  5 Jan 2024 12:13:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2078.outbound.protection.partner.outlook.cn [139.219.17.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1532D029
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTPBDOiiUVtI5F+YwMfuaZQC5ZqdpTtoJvCellRVFqQBrqDcQPmkAk5cugNAsdx9E1kYt+LWyhWB1QrKERyATl+ezqddCvQTtd9eQy/bMeSQizlG8x2tjg0F4cqpnZncPN59CFh/OludwS6A48C7heuBPWaJhs7oUWEKT5RsPjEpyrUESMKeAnz0ZA8ojAVmcyoZH/ycnZw8RXBLKPrXcyYm/sQiNbnctcsicLLxRYP++wI+cFIstJvUfCaNeDtxIVGn6xIvpmyUTdMkhSbZfJwI+8bWkbWxry3wEtxS2BvSrfnBftFeqL2RYqhsZZXHJ6U5gnqsZhx6F1BOPdjQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Foburjrm9/l5DRv5NP/MZENYnTqg/rlDLB8vNsIhq8=;
 b=XLZmSrZywxR67ts3Wyp5I3sAizXf8MBo+Ef55ajzy1a94uHAg6OfutOpxMUlIG+waqJVXJAln2WVYD5Y0BLMS8u1i0y8+FR0SC2WVGOoOYlcQjpAortsbUGF+CEboIE9xNLLQf/haTRCn57CIxzkSzbA52KoFC2Qz4YhZ7/dkAnjP5pvrBfTkd5euC2VnofdivIVmUJLoXW3TLvT7QQ5Sluv8/W7k+w7PY4reFGpuVQw5kMEnjppyPsLiF7cY0EIJjN9xKyEH+RzEUGn3LbMPwQDNg6tE7SuzuQm1Tr8IBPo0M4SSoFvf9lJkehpsOy7uIsiUxnBNKrdgTMgtE9yAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0833.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.30; Fri, 5 Jan
 2024 12:12:59 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.028; Fri, 5 Jan 2024 12:12:59 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [RFC v1 1/1] RISC-V: ACPI: Enable SPCR table for console output
 on RISC-V
Thread-Topic: [RFC v1 1/1] RISC-V: ACPI: Enable SPCR table for console output
 on RISC-V
Thread-Index: AQHaPZHX3SCOSrSGlkOKKmkRThwdmLDLJCOA
Date: Fri, 5 Jan 2024 12:12:58 +0000
Message-ID:
 <BJSPR01MB05614B36B984F5CEDFD25F399C66A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20231229065405.235625-1-jeeheng.sia@starfivetech.com>
 <20231229065405.235625-2-jeeheng.sia@starfivetech.com>
 <20240102-1ddc9ec273fded1548ee586d@orel>
In-Reply-To: <20240102-1ddc9ec273fded1548ee586d@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0833:EE_
x-ms-office365-filtering-correlation-id: 348b8604-4f6a-49a0-c66a-08dc0de7a833
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6LoKldL3enZom4seXjBPUWlUBe1nMQ4B/Qc+gCaJdGhBrSmX0rDKRj9dV3LZsj+J/gzx7MfhJkxYNOC7QcLXd9qOHog9O96bvBflzvjXItO+foQdYtvFn37V3HvR8RSV7jKKinDRDnz7iYrNjscZUul2WvvEpkaZhXW47D6QScU3aZ2eTZ17YI68qI+R8qQAXHiPpgeOnIKAZNHdaTM4nPaMu4eIxkfhqrvPRdZ6N8/n86S24yF4uaL6C3dcL6mABFouiFdZy+5qlrpQAFV9cmh0OGAaiWidZkpMNB7Qwezjqo5chr4jCnWf8bGzzNjbIM2fMT5FeHVMOCWDhUenJTY5NbEsOpYPo9pO/gMe6xI7YEcLmjOSwB8+J/TEiwbVqwKRg4RvdS7lyaSudsvlDk0YbOLEondU0zqmg59OViPpNZla+Rmap008N7A44yrYdu1eDyxwNw05pW1FD4Ozq1QCMKl9Eja7qotyjrKme2s8wcMKwW302TPQEpF1xO09iNEknDQBKSGv3Y/xpN9194mygI3PbaAa/kH2+BXfq9rYHOT+P0NKA1AeqARmlxb4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(40160700002)(64756008)(76116006)(6916009)(66946007)(66556008)(54906003)(38100700002)(122000001)(66476007)(53546011)(9686003)(7696005)(86362001)(5660300002)(2906002)(66446008)(71200400001)(38070700009)(33656002)(55016003)(83380400001)(8676002)(8936002)(40180700001)(4326008)(41300700001)(508600001)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UOyEn7OsCjMWcIWmkqutvomT3swudNppYMCbIlCi4Htkw33+nVYk8JOYK1hx?=
 =?us-ascii?Q?nbPOF8D1msXhjZ5NQCt+uUBGDfiO65bKlBd1VEYoZz+15R93Nh1hJXyjDRrY?=
 =?us-ascii?Q?mXBF6nxUgldN9jbE4s8WOlAcbMdrHBqfYamk3IxmA33oD5asrUN1C7F4dBwl?=
 =?us-ascii?Q?fQH9aJdg+K1DjaFZVzPMLTyx32DgcrqMC0hidiGPFC/XH/UQOo7EZRxm0HD8?=
 =?us-ascii?Q?n27CynfloJAb2CmC/BK5RAwHPRAavgi4FUJ9VR0+NZS0VVSuZWYjWSwWcy1T?=
 =?us-ascii?Q?AqF6xxnpupUJH1q30YUWLMYIAQ0LkpkIrQNF7j0C2qc4hN2w+VkS+gXfVOm6?=
 =?us-ascii?Q?sUAKIY/d+NMPxRsIQJKWUGCUJEMffRDJMhOyC8V+fwgVNg+8V0/qN2SdzuHP?=
 =?us-ascii?Q?JfSUTvc0bymGOPS0qvGts9osQMz9fWDHlt4aCgGFHxLfox6vgZYI4yImuWeo?=
 =?us-ascii?Q?SKdixGfLJ4xKfVE4LwhQlRciTQ0p2cXSOtma61RS0F2oqyZrp1B4Bw8RG9uZ?=
 =?us-ascii?Q?rnWsBx5fL08mdb5IX8hKLV8OSFAksYl+1ptSCHD64B0zY8KXYX3S0/FFD3zZ?=
 =?us-ascii?Q?VrxEaccYu/6gcHBCNwSSEtPG9df13kuZZjel4ON70INb9xqF1YWXWio7i8Y6?=
 =?us-ascii?Q?B26/yCBnBsC6NjZLFWvVvv9Xi7xTLOKHzA3hPtcUYzPLcY0UhPDiMtdGCx+E?=
 =?us-ascii?Q?StfVTcO+yGOVVwQa3Y/KZgPxEi/xoaCRe/zDtFiFN0DQQ00vN2QFVJ8pnJ6R?=
 =?us-ascii?Q?7gH9THhAO6tjlysZbPR/ydbNpSsi1EUKATM2nzd+ZqpvgkEHk5rwfMq8bNYp?=
 =?us-ascii?Q?9ueXO8XOSe6beNIgWrqxeO5KF2LGXmqMMCLstdDKcO7z+AfL7eRKNd4+VuOf?=
 =?us-ascii?Q?Gc9UJabgbWpj+pZPexEpZSV2b7oLqRxq1KjG1+oB2hMlRtGyytb+sUsxc4q2?=
 =?us-ascii?Q?nwmYh8edlU0XfEIOpO2YuAGkJKa4J7QElfPmrxqqAuf4R+b3aFG8rNXVbwrD?=
 =?us-ascii?Q?vNkohc2nuz0AF5QEXk2Pj4KOzVIy2Afc8/0wEfvUrSED7vmQH7nBIEJEtLLE?=
 =?us-ascii?Q?J+Bhs1lA4b8muct9jayHLCMD85eOxLkNwcRSd1fXiXMsumNOLkaTrg8Nc2tH?=
 =?us-ascii?Q?bL7vtBzVCR/UC4e9EdBOhPIL4NdgAGbQhAeo+LceaBxAzc5fJiueh5HE5J8O?=
 =?us-ascii?Q?gn4NSQ3JIOqkCiVq6yo0+Vc5o9avcCixOF21xoc1FtseaVeoSXrvB6XDvvyA?=
 =?us-ascii?Q?NiwacrlR2/hRFagix0hb3vHsonDQXs2urftfmScnQQ7IH+nhEH3O1whs3hNX?=
 =?us-ascii?Q?o30Uu/G+D6pJvFWnD1GyAFG4KFtBR21aIf2wu2b1JOjEs/6+5SQ0ESyp8ndL?=
 =?us-ascii?Q?XLq+f3pG25DicnFxfGiJmZDYrvWreHLZa0IJNdW9VtZ+zmL2nrEzggVBTmpF?=
 =?us-ascii?Q?oNeazajgFq3k/pIkHEfzzZ71SwMoDBEhk4FwoXh8IzBl8azNscOGX0CnOBrF?=
 =?us-ascii?Q?iz99PxAvWSOcHhfMyvhUbt6vvKuFb8meyjWnsneaPXQe5QH8H/R9BAKczL1M?=
 =?us-ascii?Q?8nusfOq4j1CAKHqQmaKthvKto4mo9lBSf6z776baW6lXREKJ05L96/jiQuvo?=
 =?us-ascii?Q?O2t2wRZWeD9bkNQZlGEYlPmA0SC5eAnVJPpaFjZr1UyX0jIH/URlMIgDtoN0?=
 =?us-ascii?Q?OX3vFA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 348b8604-4f6a-49a0-c66a-08dc0de7a833
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 12:12:58.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZveYyH7m/JOX7U1FY0Z282U/DkEMyal7qxbjt9BsWLkAbdq1r1oQh8RYog/hUyXTTRBrcLghz8lQkZrhtOTJr3LYb+araq79GaWlBYSkGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0833



> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, January 2, 2024 11:39 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org; rafael=
.j.wysocki@intel.com; conor.dooley@microchip.com;
> sunilvl@ventanamicro.com; aou@eecs.berkeley.edu; palmer@dabbelt.com; paul=
.walmsley@sifive.com
> Subject: Re: [RFC v1 1/1] RISC-V: ACPI: Enable SPCR table for console out=
put on RISC-V
>=20
> On Fri, Dec 29, 2023 at 02:54:05PM +0800, Sia Jee Heng wrote:
> > The ACPI SPCR code has been used to enable console output for ARM64 and
> > X86. The same code can be reused for RISC-V.
> >
> > Vendor will enable/disable the SPCR table in the firmware based on the
> > platform design. However, in cases where the SPCR table is not usable,
> > a kernel parameter could be used to specify the preferred console.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >  arch/riscv/kernel/acpi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index e619edc8b0cc..5ec2fdf9e09f 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/io.h>
> >  #include <linux/memblock.h>
> >  #include <linux/pci.h>
> > +#include <linux/serial_core.h>
> >
> >  int acpi_noirq =3D 1;		/* skip ACPI IRQ initialization */
> >  int acpi_disabled =3D 1;
> > @@ -151,6 +152,9 @@ void __init acpi_boot_table_init(void)
> >  		if (!param_acpi_force)
> >  			disable_acpi();
> >  	}
> > +
> > +	if (!acpi_disabled)
> > +		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
>=20
> Both arm64 and loongarch call early_init_dt_scan_chosen_stdout() when
> acpi_disabled and earlycon_acpi_spcr_enable are both true. Is that
> not necessary for RISC-V?
It is needed for device tree support. However, since this patch targets
ACPI, that's why I didn't include a DT solution in this patch. I can
submit a separate patch targeting DT-based earlycon if needed. Please let
me know if you think otherwise.
>=20
> Thanks,
> drew
>=20
> >  }
> >
> >  static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, =
const unsigned long end)
> > --
> > 2.34.1
> >

