Return-Path: <linux-kernel+bounces-9371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A481C4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E0E1F21BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D086132;
	Fri, 22 Dec 2023 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGJCRIoX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402E53A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw0Ecrjc6JsIC6wp8HYWiw8Q5x0rTyqyizMU7i20I9SxKYp7X/h1uvZYfjQihIDaPLH7bmBgw4/hTl6iIaOOL+AAHPTIMr926+ODZ7dqYFtp1g/EzVmi5kivCqYGFA4ySP/BJ6z4Zwed/Fe8sDPsKanr0sErAiakhok0TLx7Pa4EnbIFbZM2Xg9t/GYLjOydcXwqIaZlI8Z19z/EZaHnYkzDPloro1GcuYYPM9eDKtsNZ1AjUyb9UH71PdIh2PJxaYLSZg758+TgX4Ltq3E+SxMy7PBLJQ5AV74NjYnXl+rDlTtPFE/jtnJfKHci+tpWwNHFqPb1zgxFQu98wyQtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDdjWI1RSYYY6o+kqDvmEwZ4taoJPdPMKeli8WczTOg=;
 b=fR6AxLnCMuosJOVC9PznG6ExoNeO0zdyUCV+4VVLLP9tZHg39os6y394yPyMEB9wjMIo24N4OoOa0+rayd8SgW5cbQwNl+I7fvMfGTOp05b8uB7JSj2UqHHEAySREm59YNUadNIPdk7h65zfLB6pOQQZRdvyEA/aj69N6I2N9tIIMlHNlRZtuUd0Ue3VGQnm5vesBHv2inOC3FDlFkqjwX1ZiEStiuAA+c1WcodvJvpOtQ1+ePm2Y4Fcn8USfaK2yuMVitTNmil3ZmcBmcH3ZiEBiNcFJwtdn5TWPrWlvyUsmXJCJGwwjsV/J9lzmqs3OiLSE/Ha9ZzhxJDS9n2DUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDdjWI1RSYYY6o+kqDvmEwZ4taoJPdPMKeli8WczTOg=;
 b=JGJCRIoXLX5DQCmubd1JNWsU/SScjv631WvD5ZMm/UUswybg1zWocbLZUhmlTtUF/QBR9rC4wlljnqyZpha6Pay6SXxjHvGap7J002syMKz5P59EpNNt56X4bhOJt74e8fxLOi+s1TqsbAdcEOdGwqi2+NeIZbzYqOfDr2txjBM=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Fri, 22 Dec 2023 05:35:44 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5%6]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 05:35:44 +0000
From: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gupta, Nipun"
	<Nipun.Gupta@amd.com>
CC: "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>, "Agarwal, Nikhil"
	<nikhil.agarwal@amd.com>, "Simek, Michal" <michal.simek@amd.com>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 1/2] cdx: create sysfs bin files for cdx resources
Thread-Topic: [PATCH v2 1/2] cdx: create sysfs bin files for cdx resources
Thread-Index: AQHaHccU0leWePNqRkWP6jgwu1H5KbC09Utg
Date: Fri, 22 Dec 2023 05:35:44 +0000
Message-ID:
 <DM4PR12MB776536C75B88E06507A976B08F94A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20231123043907.4134256-1-abhijit.gangurde@amd.com>
In-Reply-To: <20231123043907.4134256-1-abhijit.gangurde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=dd05e2a8-731b-4392-920a-b86b4ee06428;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-22T05:33:51Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: bcd99a44-aafd-49cb-b007-08dc02afd7a8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gQXHYRInz2B7quJrbvvzXQ3jxAM+9dkRSYJOFIA6R2zPDLWAof0ZyXPFAbIbfdNAniQKQQclWwUHSDVzlSfb7nJ9dD3/YBmR2CL2FGhDPrgpNfx/1t6sM8+VRs9WHLt3fnGw3R7YCzHVEFoXIXAe2hJuWvyxFYeLpXqHS5ITfTs/Dv6GYfCFop5Vu6SBWKT/nopz5dE7KM6T28H3pfpx1wtnKI6gitz+OhsP5tLn7nCNUiCXm9rPVjZbEmMwqYFHj+/JDLdhMebSx+eWkwgM49nBcB9Hs3ll5hTM6k/p5sEw6eKEDNc3+jdPUrSo5BEK+9VVo2D9qwYCr2zH1YK2o/B/UlDu65pWzjnSv2mSYCsiab2mobGZ35nr5HY9D9HRUlups+W8R+nHLpEZzpOeaQiPEvMGcE4yQPp11/a/84TCZO4vkBVvzHr1Gc1spHo33zVhv9uIga7Y/6ZYCMV4CgUwAeIFtoC7BYkVKEE64uTigDIkgHXniYaR6BkqH0M0Gio3tYgMPkqwEulevO19jcD/JlO/27RgvvwBHMrUouE0I4J2CSOmhcXNdWjXtRbdQx+3dTCEPyqRmfTaUrH/4jOCUHHL2TlDlSNDRbM4h1Q7RfP00Xartkadg5MEppJu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(8936002)(64756008)(5660300002)(76116006)(66946007)(66556008)(66446008)(6636002)(66476007)(110136005)(54906003)(316002)(7696005)(55016003)(52536014)(122000001)(38100700002)(4326008)(478600001)(41300700001)(33656002)(86362001)(4744005)(38070700009)(2906002)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a22aUP4IJI5PzMYz2uCBbgmeWTDGdl9168x0zYw9/Eh4jsE+eyTxaYYJYsPW?=
 =?us-ascii?Q?u+4691vC2Zoj1oGKDrh42Wrl5ec0YnMHQ+LAZFss5vwuHjqYBC+xtQnmMRmY?=
 =?us-ascii?Q?y+emDycef7tEjCo5aF9E8bt2jjjUu/0W1GUDlOyd2oj88gn0P2yoJEDAMCK9?=
 =?us-ascii?Q?NKvfwjE/vjr2gVEhc+HWYcPKkzo1QXiIMoPPidIJMZYg1Ckct96PeLQ6PAoD?=
 =?us-ascii?Q?hL6dHNOP8zQWXhxPE1i95ZL70L68M6gmbvRS6lUI9CFZphvi8rm2fAjJ6xJ3?=
 =?us-ascii?Q?YlP/xomOO4+VpcSXD+OHHT//vquDRaWrxCdUtpQZDgrsJRliN84ibb03ev4Q?=
 =?us-ascii?Q?kZ1dA1Qg0O6V5B+Tx+X8+Fi2Z3nUksjCEL4ndwWoeYHh9Z4qBOC+aqrKdyqx?=
 =?us-ascii?Q?ygjd+/BQQvRqRmjKjPqik8Nj/MufmMK4eYP7eWuxNwpcwMKYDLwVek85c5Bb?=
 =?us-ascii?Q?RWDF0y2LrTwgTIrQvKRjXpEOkYia7JkC5BIAObv3s6y225UR+mBWpQIY01+e?=
 =?us-ascii?Q?Mj2zJyvakMIRnX3YHkjfnBcvFCPkUB9CdIXqHe4sK20S6vx3MB//lj1LcFKw?=
 =?us-ascii?Q?X0bYRSyy2vZENjs7yEb1ZhXi8hTa1szLigkTAleXef/eDpniQ2EWKH9SSIPV?=
 =?us-ascii?Q?gZAQNU1YqaSbbmvvccZEKiqtVz8MyWd5RtUclSBFvyZ+JLFNAqkwj+nZ7Ghn?=
 =?us-ascii?Q?42iYhuuR9DER+rHVvFeVGeJi8UAUNk7MoONQJsBWeHgDr1sPID8sb9rg9gV7?=
 =?us-ascii?Q?ibWccTBk1C1mHM13V5vOOGpa6vSHdz5bNHMHEbQijf+cyrqhW2SJuTI+3DC7?=
 =?us-ascii?Q?dRfqznhUVGmSt9a7FnjVOZ9N7JrsoEHQATqgEGWJs9Ah5c1dkMs5Wx2gdC4j?=
 =?us-ascii?Q?ba/gzS0QSe0EBW2jHGKh//WtBLEjJ82RFsRVhWJV2JIV01yd6aw3IxMh4Dq+?=
 =?us-ascii?Q?UGjmf/Lek2QOFqsGitss7tALuaOnIXsWDgNivV4PkPkZjm97vtEucY2PkADm?=
 =?us-ascii?Q?hDvA8pMpeWLHpN7zAiTtwOle92XBz0IEWrptpH6M3G194csftJKgrXNkDuzO?=
 =?us-ascii?Q?6mvsl5JNQiCEd6cHDIAQzRhb3fhUpi5G5ZJq4DbZsaxEpwIr1BDp3Gcis0QH?=
 =?us-ascii?Q?gEY2puqxanzvAnuJ+zZ7m06llyBeoI4sTYG1ai9HgJX8RZ1HdqLuXkggbAJ0?=
 =?us-ascii?Q?ygotuQYEEfu47Vgtq4ntzJClFCzhDjIcozjhO+2ZINl5REUe2RxGVT7TZlpK?=
 =?us-ascii?Q?hoSoIMDJ0y6yyEnyveFvAA0N/EkSyMMG7i1nycl/nd7PA1kWurt/NI7WoBzX?=
 =?us-ascii?Q?QiPuVUHMX7UKQui6LLtyvFBkR7iWjvmpexXLwiXRUraUX11m7Nt6N/3m0fgv?=
 =?us-ascii?Q?M84FtSu+ZxNt+4JgGgkeukmilUg2nc/La+FfMB+T+tJT369BosTopzCLpjV1?=
 =?us-ascii?Q?N0uTLhjEYEv3XBxBk365wnCe5WQgEw20+TcEZCiJGPYmQkpIq14Lp88PfxUn?=
 =?us-ascii?Q?GkjHGRHBpuN0eV05DyWR5GY4DqYXWTSbtvza5xLApPL3wNvApvDuxy0hy81J?=
 =?us-ascii?Q?vGI3s38MtOH/B2pByy5Co7rdC16jJzPu+8XIbh5J2zK7EJ6vlGQFQV1i3qxh?=
 =?us-ascii?Q?g81oorO2I0e8/qejfuOHryo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd99a44-aafd-49cb-b007-08dc02afd7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 05:35:44.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPBTlgqE9eztPoGiofFuJi9hsa16Rh7aVjSE8KW6Rwu4dUKS/c68SKlulWHspCPhRHm5Y3bNSOhAR/aAb8jnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

> Subject: [PATCH v2 1/2] cdx: create sysfs bin files for cdx resources
>=20
> Resource binary file contains the content of the memory regions.
> These resources<x> devices can be used to mmap the MMIO regions in
> the user-space.
>=20
> Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---

Hi Greg,
Could you please review this patch series?

Thanks,
Abhijit

