Return-Path: <linux-kernel+bounces-16246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C611823B96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB0C1C24C25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC21864C;
	Thu,  4 Jan 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LStWGe7i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8115485;
	Thu,  4 Jan 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4rOdDepmXXzTh6bVPOQVGUYR7VMtzU484oH6ZXdMzwoMfQgF2lIb9d/6wAcBssPLaX72actKNVz+FUca4LbmhknBy0fA157eyohyvbOmmL1N7D6Y2qrVUDuAayeuzzMqZruj/sQAqIKnOIGuPChRTOdhcCh9+nfy3GOmULK2b9ArdZxmnlEiIC0x/63NBY9mORiViRwsykH1c2UQsFkPXMSCOMuQd6G/z5D4YVka0y4g3zcOD9HZZfNBOBX4D+WpFvTo6HJY1/fSEwIMfxKZyRHA59aSzLbFH7raMeQ9qZCIKkPTH9Ihs0Ly7HfXkmQRU4CDUkjSdXZgPCa0lepjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pqB1YrR1pUmofr1Nur8tPilzqJVBFMJcQfKdTDzqtc=;
 b=nGnNqnYERocT0l9xG1jeCRl6Y+uzYPlr7qtr6H+Q0VpVzfVaW/thhIftCmQw5irYeKgEXw+j7zX/X45+H0GpXCGsZxSBB281IMv90g61zWN6oYLpxAlwE5pny1PnPa0stJaMCnLVjGKjgdNv3xeIES9ZGP2uYN6m6VoqJo46nZbL2HI4cDpxY9DoknGjxtz1POMGeRfJYZJiMmhWJHdla5RwoPG5AjdXlipImCuSd4tD/JAIqXa/6xF2DzRNT1bkludYR1Tlxs2yMvkgjtp62FelET/1lkpCvPG2NpqnN2gheS0mHewNVWZ+wZkacYEabHbwmZaKqQQvqlJu1iRNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pqB1YrR1pUmofr1Nur8tPilzqJVBFMJcQfKdTDzqtc=;
 b=LStWGe7iiZQ/edzflvzjQzCy+HCr8noE4jz4Rn3iwpcPVEsXOfUgMcXRJqJuWTiUnKjaxA+5+8G5i8ACcwxTRcZvPbduLGuY0H8OojAfiJEOj39trTo/bhjCcxXy1MI1YlvG23tCtJTidwzRIY/7TIrcPPPkqhF5DuTuNcIqhwI=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 04:52:15 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::b46:e1e6:ac2a:4386]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::b46:e1e6:ac2a:4386%7]) with mapi id 15.20.7113.027; Thu, 4 Jan 2024
 04:52:15 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>, "trix@redhat.com"
	<trix@redhat.com>, "peter.colberg@intel.com" <peter.colberg@intel.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"v.georgiev@metrotek.ru" <v.georgiev@metrotek.ru>, "Simek, Michal"
	<michal.simek@amd.com>, Marco Pagani <marpagan@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: [RFC] FPGA Subsystem User Space Interface Proposal
Thread-Topic: [RFC] FPGA Subsystem User Space Interface Proposal
Thread-Index: Ado+yABjPiRB0KySRY6DC56HOLfe9A==
Date: Thu, 4 Jan 2024 04:52:15 +0000
Message-ID:
 <DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|MN6PR12MB8541:EE_
x-ms-office365-filtering-correlation-id: 5470966f-9c40-4d86-8900-08dc0ce0ebfa
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L8k6wkfZ5BWoNy/7AhJ9kLeQQAMEyvOhqaRaTreEcDETMhqLCHDPhdhQihTKa/EljgcmVuz0yBLj5Qq+b/7+zTVCU+SUyoCsMgMXOOK96K3Ls2YoP2j9cnRP+QEhnklYwqqFH1Kxzif+U/rA0lL2ktkrmo0/xENAQJSAyQdRFKVxldOdQqDUaTe/kygyeWoUDYtov73yUBQL+VkS8cN/GHgNiIhoyuIQvtDJg1DzGNknDmnf6m76+XnibUJOWA04JVfADvMvxhN9thKpv4D4NuL9QBRc0Dld9dNKMmgktaphkSAQfeiNVD8WMTPv2xgdex4o0GO8fTLa0VMgVlNezNMe+ZdIzpuzJMbwXk+czAdAI+6b2xem8+CVZE8Tv2V04SN1wsACIkZKDxoagQNqIVyjJmI1y3bmcybJnu4pmbilSOxrGquDA+LZdj34a4Fvn1Sht2DJcMuk8YBUCZN25AXWSihbgSIZJ93riX3ILQFpayhBLDkDYoG0ZjtEVjykrF0h1jzwUZGwjsj0C5VJqaLbOdNUyIDh9JJAq9tROOd+bbJ5yv/V3OGDXZr7GbHJQJEtHaCI1YDeFX+sYqi1ssheZVDrlDd6kaJHEEpMtAWniwIjHOCpEGjpeIaDMfDusDiTyGZdT36LGCJ3AyQyiA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(71200400001)(122000001)(3613699003)(921011)(66556008)(83380400001)(38100700002)(110136005)(66946007)(76116006)(966005)(64756008)(66476007)(316002)(66446008)(6636002)(478600001)(86362001)(5660300002)(52536014)(7416002)(2906002)(8936002)(8676002)(33656002)(55016003)(38070700009)(9686003)(7696005)(6506007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LOx4hEK2VSusPKYj8wkk2cgA4AcBJRkWhKaTrI1yyiRJX4WsN8adkU4u61Uo?=
 =?us-ascii?Q?LNd2tlbi7h6hJ/LpMgstzeRGpmptO+u/kNAqA+xSqYrSxE+lNguhYpJtjEa+?=
 =?us-ascii?Q?oHXLK9QMN5DxzjLHLvszAzFFTm+K1aD2/axdrdjYxo2zBuNQXGN0fkRf+vFg?=
 =?us-ascii?Q?B8FcMMUQFTonRU15T9PwxqeePAl/oSPpYB+bWlT5sEUp9qMKMIC8QpOA/SeK?=
 =?us-ascii?Q?QXaXHbIWgc0UWS9X1ltNCjXrdfYK3EvsHvBPx9ikKieaA2G1GK9hhAm90Qf0?=
 =?us-ascii?Q?NZxGtAlMTuycehJFTCGcgOtIHkDALG2h7DBlX9C2LEWomgxFtxPGdccTiUz4?=
 =?us-ascii?Q?sLWnMEd2355QHoRLaQ7aqn2NI+OecSMARvfoK2Qzx3/vqC0krfM5JyyG5Tb/?=
 =?us-ascii?Q?quuhoNuRjM7fBKGXn105auLWjav6fEq9N0rE3g28PSX6VnutkAAtaMio35jg?=
 =?us-ascii?Q?zNL2opqBAk0cKhq18jkMlf6Xhr7Co7sP74AWM3oDAbJheeyH9WxyF3VCCE4p?=
 =?us-ascii?Q?Gbwfs10mc0BoAX/RC0HhikZBpEjNfiD+wBs5V9rS9dx/JFyvoLvblgBmHmA2?=
 =?us-ascii?Q?NRd6GjY9rlbGp+jC4nXPo3/XfIyqIrB1q2EbVaNtXl5VfwF0oH6sKwlGPq1V?=
 =?us-ascii?Q?48lGS8WyXUO0sVhp2kKwbhnoGX7Yiq1dioVucMi5MMvcKBb0W5/PViP0d2zG?=
 =?us-ascii?Q?7sZmbzwoAt+EnHm/ZkxAhQMfbZYzH5RY9vtC4DFvQDzD3TRZYtcg4quxWXWc?=
 =?us-ascii?Q?aCXbuWw0hLVKK8/bAxtlmyuwU2zXuuCuWQ1ynTk7cTVA/TEYdFZWu6LILb30?=
 =?us-ascii?Q?ZpW6EhqjpEA869DRNfvaOgd9XlTQqSybjXDAbDAL5QKSMglNCBVsaaoM1xfm?=
 =?us-ascii?Q?5LYRN+dRYhfwqdJvdSGCxbR3LKtdai91k6MYH1ZvfeU9GXfGBXFHg2e46QVC?=
 =?us-ascii?Q?AIdRzUmBvc204F7Xez2Kw35Mg6FKC8gp5MZofLe9QTW+aaS7zvgB6i5nMxVQ?=
 =?us-ascii?Q?GdPLgcVMclrjckyeetytYu00eoEtAn6Z3PoG6z2rvcubU66cG0eFR7vw0LOd?=
 =?us-ascii?Q?HUTkVlozlt8VPR/XS8PrLty+EUfpGjtjub4YvtLfFpX5jGfiI8tn6Sj+tTo5?=
 =?us-ascii?Q?83VhUdc8XWZgkZeO+5SGso4oZNsBTruJPrsbI68YnePitGWXExyXu49dArZV?=
 =?us-ascii?Q?GAS8xxgXQRALQHyNYhnLlyv7CtxJFfGwh7nuQOtyP7gzKgWnGT/fuyTkN6UE?=
 =?us-ascii?Q?f5lerxUMPDR1AEILwebyln+HYmXgsfwQ9Y9k7nC63rCd4n+++cp8Nqf8/rP8?=
 =?us-ascii?Q?vwgs2ouF494OSWD9S9pjU9bxSiSjJ3UtN3tiV9Xqx8/gEWsFqKgHFTQoJ5O1?=
 =?us-ascii?Q?tryH601cqipi5mqm3BEuQWuwGwodjPLylGZTLWpQhNNV0NEIKu8tDdNBroL8?=
 =?us-ascii?Q?bhf9NpmPlvfm3lnOOXGhHCzHf9PX0k2+yW0jzHEEtqEQIiyanoVmVRffr/Wl?=
 =?us-ascii?Q?nbwocQ698etzVxA9QHEoxnWt5M9pQo3Y8p+egUwK4/B96lTgFDb+4lH0LrJi?=
 =?us-ascii?Q?byxX7HzGdlIl8PQS4+I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5470966f-9c40-4d86-8900-08dc0ce0ebfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 04:52:15.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOMBqcR7DAuoOsXxjjtm1AST+fLf61SgEE8YA0pJEE/QeKSa9wS49Qt8fqwC9S82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| Introduction                                                        |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This document provides a detailed overview of the proposed Kernel feature f=
or FPGA Manager subsystem user interface.
It describes the problem statement behind the proposal, the problem to be s=
olved, a top-level solution design.

Table of Contents:
------------------
A. Problem Statement and Background
B. Scope and Out of scope of the proposal
     B.1 Scope
     B.2 Out of scope
C. Proposed Solution
D. Proposed User Interface Details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| A. Problem Statement and Background                                      =
  |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The existing FPGA manager subsystem didn't have any user space interface (o=
ther than the status/state in sysfs) in Kernel.=20
Basically, FPGAs are semiconductor devices that can be reprogrammed for des=
ired hardware functionality.
FPGAs can be reprogrammed at runtime with different types of logic and IPs =
as per user need and hence there is a need to use device tree overlays for =
removing/updating/adding the devices at runtime for the IPs/controllers tha=
t are present in FPGA.=20
But we don't have any user interface in kernel for updating the device tree=
 at runtime.

Sometime back there was a series sent by Pantelis Antoniou (https://lore.ke=
rnel.org/lkml/1414528565-10907-4-git-send-email-pantelis.antoniou@konsulko.=
com/).
This patch introduced a user interface configfs for Device Tree overlays, a=
 method of dynamically altering the kernel's live Device Tree. However,  th=
is patch series was not accepted in mainline due to various concerns.
For more details refer to this link: https://elinux.org/Frank%27s_Evolving_=
Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive=
_list

One of the major valid concerns that were raised with this configfs interfa=
ce was security as it opens up the interface to users for modifying the liv=
e device tree.

So, in order to configure/program the FPGA devices, All the major vendors o=
f FPGA are using this configfs series as out-of-tree patch for configuring =
the FPGAs
and there was never an attempt to introduce a generic interface to configur=
e/program the FPGA in upstream and hence upstream kernel ended up in not ha=
ving proper support for FPGAs.

The proposal below tries to address this gap of FPGA programmability by pro=
viding an interface to the user.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| B. Proposed Solution                                                |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The proposed interface adds a new sysfs interface (of-fpga-region.c) as par=
t of the fpga subsystem and it is responsible for supporting the below func=
tionalities.
--> Provide the user interface for the FPGA subsystem to handle the below F=
PGA relevant stuff.
         - Bridges.
         - FPGA Configuration.
         - Driver - Probe/Remove
                               =20
--> The new sysfs interface uses Device Tree overlay (DTO) files to configu=
re/ reprogram an FPGA while an operating system is running.
                - Restrict the overlay's subsystem usage only to FPGA regio=
ns in order to mitigate the major security concern with configfs.
                - Do validation checks on the user provided DTO files.
                                - If the user provided DTO doesn't target a=
n FPGA Region which is already part of the running kernel, then return -INV=
ALID error.
                                - If the DTO file contains multiple targets=
, then return -INVALID error.
                                - It will allow only Child nodes which are =
part of targeted FPGA Region.
                - It avoids Overlay notification calls . So that it will no=
t interrupt the other subsystem's(Like; GPIO, I2C.....etc) exists in the ke=
rnel.
               =20
-->This proposed solution will not change the existing sequence When a=20
-->DT overlay that targets an FPGA Region is applied
                - The FPGA Region will do the following:
                - 1. Disable appropriate FPGA bridges.
                - 2. Program the FPGA using the FPGA manager.
                - 3. Enable the FPGA bridges.
                - 4. The Device Tree overlay is accepted into the live tree=
.
                - 5. Child devices are populated.
                - When the overlay is removed, the child nodes will be remo=
ved, and the FPGA Region will disable the bridges.
      =20
                                                                    . -----=
---------------------------------.                       .-----------------=
------------------------.                       =20
                                                                   |       =
                                             |                     |       =
                                                 |
                                                                   |       =
                    .------------------|                     |-------------=
--------.                           |
                                                                   |       =
                    | sysfs_load() |<=3D=3D=3D=3D=3D=3D=3D> |Overaly_apply(=
)|                          |=20
.---------------------------------.                     |                  =
         '------------------|                     |---------------------'  =
                         |
|                                          |                     |         =
                                           |                     |         =
                                               |
|    New Sysfs interface   |        =3D=3D=3D=3D>   |       of-fpga-region =
.c               |                     |            DT Overlay.c           =
           |
|       load/unload             |                      |                   =
                                |                     |                    =
                                    |
'--------------------------------'                      |                  =
    .---------------------|                     |-------------------------.=
                     |
                                                                    |      =
               | sysfs_unload() |<=3D=3D=3D=3D=3D=3D=3D> | Overlay_remove()=
 |                    |
                                                                    |      =
                '-------------------- |                     |--------------=
-----------'                     |
                                                                    |      =
                                             |                     |       =
                                                |
                                                                     '-----=
------------------------------ --'                       '-----------------=
-------------------------'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| D. Proposed User Interface Details                                       =
        |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
How to use the fpga sysfs interface.

To load Image:
	 - echo "DTBO file" > /sys/class/of-fpga_region/<region>/load

To unload Image:
	 - /sys/class/of-fpga_region/<region>/unload

To get the image status (Load/Unload):
	 - cat /sys/class/of-fpga_region/<region>/status

Base Image
               - Also called the "static image"
               - An FPGA image that is designed to do full reconfiguration =
of the FPGA.
               - A base image may set up a set of partial reconfiguration r=
egions that may later be reprogrammed.

     .-----------------------.                       .---------------------=
-----------------------.
    | Host CPU              |                   |             FPGA         =
                             |
    |                                |                   |                 =
                                           |
    |                           -- -|                   |                  =
-----------             ---------  |
    |                         | H |                   |       |=3D=3D>| Bri=
dge0 |<=3D=3D>| PRR0 | |
    |                         | W|                   |       |         ----=
-------             --------    |
    |                         |     |                   |       |          =
                                         |
    |                         | B |<=3D=3D=3D=3D=3D>    |<=3D=3D |         =
-----------             --------   |
    |                         | R |                   |        |=3D=3D>| Br=
idge1 |<=3D=3D>| PRR1| |
    |                         |  I |                   |        |        --=
---------              --------   |
    |                         | D |                  |        |            =
                                       |
    |                         | G |                  |        |         ---=
--------               -------   |
    |                         | E |                   |        |=3D=3D>| Br=
idge2 |<=3D=3D>| PRR2 ||
    |                          ----|                  |                   -=
----------               --------  |
    |                               |                  |                   =
                                           |
     '-----------------------'                     '-----------------------=
----------------------'

In the above diagram a typical FPGA is setup with a base image that created=
 three regions.
Each region (PRR0 - 2) gets its own split of the busses that is independent=
ly gated by a soft logic bridge (Bridge0 - 2) in the FPGA.
The contents of each PRR can be reprogrammed independently while the rest o=
f the system continues to function.

Form the above tropology the sysfs interface looks like as follows.

For Base/static region:
To load Image:
                - echo "DTBO file" > /sys/class/of-fpga_region/FPGA/load

To unload Image:
                - /sys/class/of-fpga_region/FPGA/unload

To get the image status (Load/Unload):
                - cat /sys/class/of-fpga_region/FPGA/status

For PRR0:
To load Image:
                - echo "DTBO file" >   /sys/class/of-fpga_region/PRR0/load

To unload Image:
                - /sys/class/of-fpga_region/PRR0/unload

To get the image status (Load/Unload):
                - cat /sys/class/of-fpga_region/PRR0/status

For PRR1:
To load Image:
                - echo "DTBO file" >   /sys/class/of-fpga_region/PRR1/load

To unload Image:
                - /sys/class/of-fpga_region/PRR1/unload

To get the image status (Load/Unload):
                - cat /sys/class/of-fpga_region/PRR1/status

For PRR1:
To load Image:
                - echo "DTBO file" >   /sys/class/of-fpga_region/PRR1/load

To unload Image:
                - /sys/class/of-fpga_region/PRR1/unload

To get the image status (Load/Unload):
                - cat /sys/class/of-fpga_region/PRR1/status

