Return-Path: <linux-kernel+bounces-8005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459F81B07A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8AD1F23799
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AD17733;
	Thu, 21 Dec 2023 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBxLg6mN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A390171A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvZMK9m+0JFCrHfLn8tWPsvYza7cHcqHXQSwjx8wQNndCHQKSqHfBCIVDj4AMJGDeKVya+2e2tiii/1IH+NxntxrZULWNK1yyOPtZ8wS7AjGwOohovi+az/0Mv3khulE2bD76rFYZmJEizerVEq4qxQbZk/oA3eLCzobDdAj5GXXyCnGC2RF4HDCT+wCn/SQA9cC2ztmjV4CEhDKH958sqr1AU6SQGNmlrUncXxCd8ZzQ8xDOmhbTFf2DpuNXW2Ndhyfy2h3ektaG5xsQVjZEbDAF0VAXP0RJx8MhOaUOof8ifGNXnkwYg6XPYauyp0G6AzBJ4/HsoReFv1qYhN66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmEJwnRV2N6KAHC0fzzuGsrRIVYZZT22mLGAhcAW7kQ=;
 b=lCyTIIW6D50gYqLLan3VHE/aIMRxjYJ2CQDX5hd7uPZM3XetQnVJA+AN8+yX+RtL8k/1F5GOmETPP2MGczLmifSCOm4PrqBtp80trFlptg96zEOkdAoB2cZnMZDiORxbFSUMiZyG5x7aGOmQjWgajOttCsA6WEggEIk8K5KEozoaRfqvwb8ksI2s0XHv/QzCDUhwSNLHMqkyOWoGDm6Z3pBZqYmW8iWO3F1rSwIJLxYMUiaXTpa8HEHlm+y+aWi2mzeUh9EBZ6v6gtnaZYH1omeu5QgSsDX4Qp4qQiY5oCGfpijoU/hEM8pmYJQCO/wnYcrcdLxC36tAyOmrK2QaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmEJwnRV2N6KAHC0fzzuGsrRIVYZZT22mLGAhcAW7kQ=;
 b=KBxLg6mNmZ6GaM/FC0S/NCspD8K/pEJ/GvyEpGM0IOoUAh1u3TxvoMTtKOP2zWUQUfXm47jJMiS3B1CYHsNjfNnmAYzl7Sn8fmIfYQRttyMy6YwvMPQWhMO3M8hU2X/S2WVBNEuNgvbbD1XTT6Wswi2nSEsvDG3wQEOocYZMVfE=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 08:40:05 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 08:40:05 +0000
From: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal, Nikhil"
	<nikhil.agarwal@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Topic: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Index: AQHaKSriAFfJDi7320ewod6YhdEEWrCqj8OAgAAAYwCACM3N8IAAGTKAgAAIHeA=
Date: Thu, 21 Dec 2023 08:40:05 +0000
Message-ID:
 <DM4PR12MB7765D853EAAB6788AA06699C8F95A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20231207163128.2707993-1-robh@kernel.org>
 <2023121551-uncommon-negation-fdda@gregkh>
 <2023121509-snuggle-lagged-1365@gregkh>
 <DM4PR12MB77656006A8A6EB5DE6A468038F95A@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023122142-huff-closure-d5d4@gregkh>
In-Reply-To: <2023122142-huff-closure-d5d4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=7dce3bdd-23c7-4057-96f6-7b4c0a22a287;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-21T08:36:39Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CY8PR12MB8298:EE_
x-ms-office365-filtering-correlation-id: 6ce915ad-b938-407d-f129-08dc02006e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RmvkF1d200TlCuL2Ki9+DDUcv9N8NeP2ykRrR2idmmWnT1v+wmarH5pcSG0oAKC+EXOy4nAzW4O0sMa3UnbKT/FbdC17IsETTisUJSND45RIkmIpegjnZUTXeNOGvD8iSg3p15yDV80SVEoLrfR4oAablbQqccS7pzPETRA9fN+/Mk3qexf+XYt+4XmnwE1mCC0Jp2myOjSm33hGFo18VBX7krzaD1R93f8Ue+0/zMp5PUuJlGRg28NlNa86FND0NkFuwUX2chmT7hdUZ0rHHNsB8n2NM7qSmtczp7zArnjLX7MahwRMBs603jl9dzO1cZOOnACLUz9EEkkpJahWC6zEoKD9SdWMbzkPMvjKTJHzP/QvByu+EbBe1f35+xJ6onAv3vs4bigj6/GzPow+vFdsgqyXU605yvMJnb+cmRK7WN3IGrledqjILDFiE19a+naMVLTEWsyGmRuEKOWuE3OFCOZzRIiAm/gU3mWzRKrXzYmHk7xGi9qBvyTmA9CIzOu5X665aXQYdFIgYwqv3YF9+6W+Ro1kJ3ktOPtxAGZIRQXasw3IMlamgXLc5MyMs/r5gyZ/pHYSQAZdP61Bu0LpPtjjvcXYpIr1Kk3XdrYdqX7FJ/c3s4KP+xAMF252
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6916009)(64756008)(66946007)(316002)(76116006)(66556008)(66476007)(66446008)(38100700002)(7696005)(71200400001)(38070700009)(54906003)(86362001)(41300700001)(9686003)(6506007)(33656002)(5660300002)(4326008)(83380400001)(122000001)(8936002)(8676002)(2906002)(52536014)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GEx8M/oEZHz5OOFDvcxTf2ZntHQCOYzyHtcjVH9KDJCZEB1vanJl/kJtvq/4?=
 =?us-ascii?Q?KSCFfMbzOgc3SQRceSYwhY2taK1bGY1lD1YC4i/6wTL4NMkBczIxawbX5vUD?=
 =?us-ascii?Q?XaSf2PSuGH5o0zmyydaCzhcfoM9/C75Wg0IKBeMbhslpDtRTNBbOymLMwZla?=
 =?us-ascii?Q?W2GSGocRSkzxln9lCOxOv4UPN78JXzTiXZXDzsTEqtJmrvh/m8fqJ5k7Pmn1?=
 =?us-ascii?Q?AFP/REuV5wrl9jwMd6I0c45S9PNfq8++TIfyWYLiZiXm3pV9ZAHZwk80vGjf?=
 =?us-ascii?Q?GX2ZJxrP8bsKAMcaicilFy0MVCRckMzibMvcseIe0cO2SEvi0BzFXREnQjQR?=
 =?us-ascii?Q?89uXLsuEq8M1lsz6GH73AgKEWDd6bZLEWQLKKBL91IXJk7JjluFWR4608TWv?=
 =?us-ascii?Q?HiPY8/GaLly8BT+UjWWH8vfpfeQS/bBWQbK+HMpg9YfUz7NhfxEGnA5G6x+9?=
 =?us-ascii?Q?CYsFYeGez7fTIkdbnHcKYTpgmHeHUMtwcwIEr7Orpow+lQnNLYy/QD4wLzjF?=
 =?us-ascii?Q?LmkgpKrTaiEgy4JSIDlPxPJIwTyr4KPVulWF4zR3VcdJdeH0qKyktuCFIt42?=
 =?us-ascii?Q?TTYMXjwmWq308RLqOTap/BW3BWBNPF1YXnnY2pV3zWu6Jtq4IvhISEBnd/9I?=
 =?us-ascii?Q?0jv8ZngJih/KxiZG2k7u6znjUIi1Gj9FfWauyxiGXq4isekebc//MS3wF9ft?=
 =?us-ascii?Q?cI4iaqW3MM1xcw8C/1hmZJDzvL81VySYahP1Xzc1+FLCPzoTp6UuJe57Ks98?=
 =?us-ascii?Q?7NZn53TERaspDJUNma6QV1dR4DaiLwF23LZnZMBoZ9g6V7H51AL/dLVNKWj9?=
 =?us-ascii?Q?YrvFQPMKtEyIz5ugmfOeGz36DsqXgCqW3YStDdq/NOBUANhvaHSKGnRWpfJB?=
 =?us-ascii?Q?Lv27RGkpwH40aWjl5YtP7Vk0aYsz8NnETSP25bygxdxLzyqTFUVHArUhYoTT?=
 =?us-ascii?Q?v2r+s9l+zZnWXHKasY8jNrNZGW0NGJtqX3lQ8jdSDM0kXZ4MViTUhkWNp0/M?=
 =?us-ascii?Q?MlQrB/YOlrq5005DgnjblsfCEYaBWLtcYrCTjGS/fmt9IjoXPfFi4MBzNqR/?=
 =?us-ascii?Q?tt4o7Dao1/OLRC/stakNE2LH9D3cC1kgbpjrnnerx5qTSIx1NqPRHcWUmsJj?=
 =?us-ascii?Q?LSSydNQoto9iFSZGWauXpl96O5/+RuLKiNYxa6qmqmoErU30eKtJRVN86Xog?=
 =?us-ascii?Q?ksPTnPsWfi3v+WVriXd7ouwC+q1nlLZSMI68nJP6KuZuVEEPSRYU59b2Aznr?=
 =?us-ascii?Q?dEBtAX0tyHUAokfmdWIxZGdwM+SzVY2gU6L4exiIh2dHGioQPVBufxDBuMoG?=
 =?us-ascii?Q?ifa9MYet4D1kziBhnZHp7TsAizyV+baH4GQQQZeE8A0/7aEbH2kYna7oMmj9?=
 =?us-ascii?Q?vAxdSO44+5SaGVO79Fs6sHlSFlrJbKOgwqS7t+YAZYfzCN38V7ZK6npKV6zf?=
 =?us-ascii?Q?i7hjUqKVt23HZEAJdVMddxHjRCHSUOHamgmBeiQcv2IuKYqrwVS2Tl25DOrh?=
 =?us-ascii?Q?wsP6eP4TU5YJGu5S2/5L0scqkBlxhu4TbZYBh8z+B5UC0GGuMPD9c+glp633?=
 =?us-ascii?Q?j1eqSUvpwjUP0I9Yz5/zFjoJ/zAcUjGW7HmHL6ETj7GlbGtZNybKm9Bwgo8Q?=
 =?us-ascii?Q?+hH8mIgrMXwpqjBEBSp1424=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce915ad-b938-407d-f129-08dc02006e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:40:05.6086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bjj+0lmP7iiI8vs94ew3fr0W/+aA1B5u0W902THHVdHDpzOXUe2tpPrSzIjP23EJCN5ZdbldZBLbVXZHTFG3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

> > > > On Thu, Dec 07, 2023 at 10:31:26AM -0600, Rob Herring wrote:
> > > > > There is no reason CDX needs to depend on ARM64 other than limiti=
ng
> > > > > visibility. So let's also enable building with COMPILE_TEST.
> > > > >
> > > > > The CONFIG_OF dependency is redundant as ARM64 always enables it
> and
> > > all
> > > > > the DT functions have empty stubs.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  drivers/cdx/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > > > > index a08958485e31..7cdb7c414453 100644
> > > > > --- a/drivers/cdx/Kconfig
> > > > > +++ b/drivers/cdx/Kconfig
> > > > > @@ -7,7 +7,7 @@
> > > > >
> > > > >  config CDX_BUS
> > > > >  	bool "CDX Bus driver"
> > > > > -	depends on OF && ARM64
> > > > > +	depends on ARM64 || COMPILE_TEST
> > > >
> > > > Ok, good start, now we need to turn this into a module, what's keep=
ing
> > > > it from being able to be built as a tristate?
> > >
> > > To answer my own question, the following errors:
> > >
> > > ERROR: modpost: missing MODULE_LICENSE() in drivers/cdx/cdx.o
> > > ERROR: modpost: "iommu_device_unuse_default_domain"
> > > [drivers/cdx/cdx.ko] undefined!
> > > ERROR: modpost: "iommu_device_use_default_domain"
> [drivers/cdx/cdx.ko]
> > > undefined!
> > >
> > > Would be great for someone to fix this up...
> >
> > I did look at this code. There are 2 issues here for it to be a module.
> > 1. There are many symbols in iommu, msi and other module which are not
> exported.
> > Most of other busses like amba, fslmc, pci are bool only.
>=20
> I only see 2 symbols here, what other ones do you see?

There are ~5 symbols from cdx msi patch

Thanks,
Abhijit

