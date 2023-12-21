Return-Path: <linux-kernel+bounces-7899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11F81AEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A7B1C22BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CCBE62;
	Thu, 21 Dec 2023 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5BKieJx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1215BA38
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjOcazlc5CQGWQulD8y8Ma/eG+wtiZygKj8rFzOvFrq/o9omINga2a8tksv6p8kViA9/IVc+U/dtfGFdzj5Yjh8IDGhgdEeW4rqT8d7IsVrkvSZPUK3s8u6caGYE7dcMCM+OgDfPw1vX/kdZTnSBNvRLoErVIDbkhlq43j+cKcKWPxzfRQMw7fpxm1WuVGjyCx9zPKx0auPHWleITcICRPJ9yHK85x8XIDDmSQLuUjMroWtp3zKFfDFdM9Fj1eAyH36iztCfDVIgfHFi7BfUb8QlHPMRTsilNd8qe/c4+DcbctDUb/v8LMaC62dy+fsAAknCZymEpFVnoohcpFU26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/C6MVkpYd+9xeR1vLjq9cUyepwpHBPomgiirEU8vig=;
 b=nMHkJJRu5RLTklWESTAMRIxgqM0yDyWD9uOO56xB52xgU08bShiH+fiWkf6FApVKKWW4dPRjbjaa7tlPfJtYwqfgypTjJc3FhZftQXPaaGQJABYQs8SD0LFuasJUdsW7Zv4+L0p2mSZ/ckMS8Tz1z/DuC1dPHCXclBs+7/LLcWiTrmCY5Tmp6bFHaQTx8SNZRc2j8JCSg0VM1s/Pt8VKhdxfmNUJyrUZIxAf9vNu7oKy/1M25PLGygsxyUzb4W6qe+j8hVQpd9WKmIpv2EDhQ2VzgjVfWw3zwBNNH5BYX4A0ubC3UdXfvporEJnYtF/ZGtWhHezjlyO1X7FnTwk7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/C6MVkpYd+9xeR1vLjq9cUyepwpHBPomgiirEU8vig=;
 b=X5BKieJxBULGHAhiX9w074lwvdZlK6S2DB7qsSKD4hwxqrymNNllMqOGDTenI31K+a5xgMUanVFZMPRXyFVfmmav4H2wZBGkw9arKJQWkE/Nfa6ECve5onnWDHrfZrUOHwt20xNeic7555kNfuYEdX8bI/fftiegtJRusfzoq3s=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 06:42:30 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 06:42:30 +0000
From: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal, Nikhil"
	<nikhil.agarwal@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Topic: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Index: AQHaKSriAFfJDi7320ewod6YhdEEWrCqj8OAgAAAYwCACM3N8A==
Date: Thu, 21 Dec 2023 06:42:29 +0000
Message-ID:
 <DM4PR12MB77656006A8A6EB5DE6A468038F95A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20231207163128.2707993-1-robh@kernel.org>
 <2023121551-uncommon-negation-fdda@gregkh>
 <2023121509-snuggle-lagged-1365@gregkh>
In-Reply-To: <2023121509-snuggle-lagged-1365@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=6813435c-6295-479b-bffa-4c93ec05a67e;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-21T06:37:32Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|SJ2PR12MB7868:EE_
x-ms-office365-filtering-correlation-id: 2201e747-e00c-41b9-7376-08dc01f000fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qXCLxkGT6wi+f6qQZxyEgrjvNDPd4MandESp5r9XNbwC6H028KtDl5/R5o+L7qrwQA/j0hn7H4Gy1ZBoopOIiPgcQlP6IazKB0hL7ptrgbiJMKXdKMaPMOb7ZudPTdWU1pXnLOSBwCAweBbWL12fhrCKNyovfXLTYaacVgU5Zx3hJ7p1/qc0YHB0/w1BOIbiaFBa3mIQtJ/j2wEzI9M6tz9WWnpbQK1uNNKPWpWCJKUJIBEpyAkyDOwQyrnic0h5yVRWdOOg5/vA2ySc8AYkEoJmB7lTkST+6vkeSwtptdYr6ySyLc3LQTvJRLAxyPo35b/WuophC+ZiLx7xRs9/VaFzhMqejAxQ/T10dUMm5gblTDDwbijmByPhF6zCrTTXV+PMshBik8n5zlsY3khdBW8mEpev7qJ+4RVbqbHe7nkKUkjRz5y/680zVYdzGGkLRLcA9W+7xK9lb+U+PSNEKnUtbIB3Zw2xaMJQZ5f5+vG+ozg/NLfuPMT/aH8DorhQ2Zo+NX/z58YUyRe8qnZATkCJQ/lxgUqO1w3jvIVX7ZnkTHs+Zat0OtBsIgC913QM6aHiSMfqJPUpvKRVnMzmV5yUdIYEsKA9zY3bbtR+rqewa0ps9t6C4nISv8Q8tAh516rabtEvLz7qRIcmRsf+rs6E07Llqo1BxzxJ/U7yUbM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(7696005)(122000001)(9686003)(71200400001)(6506007)(83380400001)(38070700009)(38100700002)(33656002)(2906002)(86362001)(41300700001)(8936002)(8676002)(5660300002)(66556008)(4326008)(478600001)(6916009)(52536014)(66476007)(66946007)(54906003)(64756008)(76116006)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NnQfz1grmUpduT+kdo95jqylSVbuD9hA37KjMhxCo91YE7n0EIt/7QQ/R6g5?=
 =?us-ascii?Q?UkYMS7gEd0d4pzuELv42mVWPcbiu6fbK46fIJ0kWu4Y+AdGCGg1w5R+5vIWo?=
 =?us-ascii?Q?rRcN6leW2bFh1JbVpnmz4YvMCsjmO+NqsGtx5eDbeDBkiMPAxrkYY1gxbLul?=
 =?us-ascii?Q?HwcYI8fqX1SAGQxpeMAryqor2elMfq65f99khWb1RrGcOLOnkSfDZiz11e0o?=
 =?us-ascii?Q?3EEFW2GzfDtL0U8jQADd9FjmexQX8Sk4dkeJmBrriNCnYG4LLJOn1yLI5yOa?=
 =?us-ascii?Q?L0npljoqJVfDQQgC6/o5nY2U29HDYW2ReQmeB/zum9iXW3q/xb4RolJjH2Qm?=
 =?us-ascii?Q?gLy8+fksevaJVTqGzcKojNWhKr6LKV1kMS79lChdf4q4Qaf0enjrh7iAlK+L?=
 =?us-ascii?Q?lOmJj2xxzotcr0EpaKfHW0FyWilj6qBXkJkqGsf/HWDN6SJM64Dv/OWzHwUu?=
 =?us-ascii?Q?Y3BFGLSC6TVVEzlFfY9JsgWK7s9fUsAYnm7gWMn67hku1UPDIUrbVme30a8c?=
 =?us-ascii?Q?iF+Nl/pfEVAxpTS3VmcMO9vpQ8AS8YebrBaVRw+KBOH3z1q3Tl+WfBuYoGIz?=
 =?us-ascii?Q?wIuCB5Drz5J6ttKmhj3f4PRYpGuXMvl/lRiX41YNvxVIRXCflD0DIN81x7WH?=
 =?us-ascii?Q?QrdQTUNG0J24qKCq96GsBAtxhem+lQvWLYOdgv0Z+zutI5axh5NfEY/iXq6Z?=
 =?us-ascii?Q?jNvSSN+ZTdCiQAwizaTLfbEtqfUerijc46FZTPKc/cGSxaQHNQYUiOdf5qkC?=
 =?us-ascii?Q?VjceqHhi7K8vb83I+NItseevgCILZqj59I0HOv4GoX72OctQ02sdyvJv1c5a?=
 =?us-ascii?Q?gw1YFb9bqb58gSL5m9QS9VVSM+pdWbBgsxFmCUlPV5qCog55m2bqor9aZxv9?=
 =?us-ascii?Q?2LxQaPeSGGoychCo2KXSKN69d8Vp5iw2HVRtF66eCKKJAocdVMlk0XaF4jT+?=
 =?us-ascii?Q?o1bCDSEBueuMWr2BNgxO2ARSR1kSV7Nl/CA4cmb8OSvEY1P8gSPgCD3R1j3k?=
 =?us-ascii?Q?Ggxsr+y0nLAeLVAxjzX2S1SRYq+5IS/44mi0mkJTRq+cInSOwTdQD+UZNgDk?=
 =?us-ascii?Q?5QLFl1TwzeUS2evmOt4EaGjaeR5keHsi2zeBWa2M8iRq4g/f4+CkY+HBfixY?=
 =?us-ascii?Q?tyZvin6SvRtEWbGc5PRXtFX/0jAiCJKR6mS6L1hHrWOoMZl0pg0p9BmZEC1U?=
 =?us-ascii?Q?ItEJ9hqO/9gRYJ8FHukbdlMy8oaqpzZ3M9v+D5jt1ZKUxFWeBWwGNMzLgxPr?=
 =?us-ascii?Q?9JyM2sO1kS580Q0R1KwuLEU3MwIJ0keS+BbZNQD9o9lcI1es1dIkt6dl7qg1?=
 =?us-ascii?Q?EUE6r3ab2K6FaIQOegnhCW04VUwp0EZhoJs72IHEEID2Zpe1OKv6zbMrioat?=
 =?us-ascii?Q?01N3JV+Vn3qDD6fut7Y4MTKSp++eXk8IXVEyZioIRoSfKHVM6ZMbapj/mVS/?=
 =?us-ascii?Q?zxmXaUGaIQVLRKGjLZkfjcQu8Iagd8pyl9k60UgXh5B8okdFBVUtlvWg8Cbt?=
 =?us-ascii?Q?qMFQ++MyKDkxSwJAqA4e1hm6vcqXIuoUPfjEp7zI19v2Tpp/C5q51Zjo7DV5?=
 =?us-ascii?Q?V/Dbb/d+/wB/OOiMt2ePwZEzUv9qTWk3cfh6VCgz65DWvznqC5HFhON5YjCm?=
 =?us-ascii?Q?qikcAzJjLRs8CDXNBROvW7I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2201e747-e00c-41b9-7376-08dc01f000fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 06:42:30.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RERf/Qdbbi84qoLm3NpmSDo0L7g0VtxsYAH7Z9OprH9XKRfPCicw1lB/CXVEmQ7LngqXqOQfpTpLJfwafAF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

> > On Thu, Dec 07, 2023 at 10:31:26AM -0600, Rob Herring wrote:
> > > There is no reason CDX needs to depend on ARM64 other than limiting
> > > visibility. So let's also enable building with COMPILE_TEST.
> > >
> > > The CONFIG_OF dependency is redundant as ARM64 always enables it and
> all
> > > the DT functions have empty stubs.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/cdx/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > > index a08958485e31..7cdb7c414453 100644
> > > --- a/drivers/cdx/Kconfig
> > > +++ b/drivers/cdx/Kconfig
> > > @@ -7,7 +7,7 @@
> > >
> > >  config CDX_BUS
> > >  	bool "CDX Bus driver"
> > > -	depends on OF && ARM64
> > > +	depends on ARM64 || COMPILE_TEST
> >
> > Ok, good start, now we need to turn this into a module, what's keeping
> > it from being able to be built as a tristate?
>=20
> To answer my own question, the following errors:
>=20
> ERROR: modpost: missing MODULE_LICENSE() in drivers/cdx/cdx.o
> ERROR: modpost: "iommu_device_unuse_default_domain"
> [drivers/cdx/cdx.ko] undefined!
> ERROR: modpost: "iommu_device_use_default_domain" [drivers/cdx/cdx.ko]
> undefined!
>=20
> Would be great for someone to fix this up...

I did look at this code. There are 2 issues here for it to be a module.
1. There are many symbols in iommu, msi and other module which are not expo=
rted.
Most of other busses like amba, fslmc, pci are bool only.
2. As of now, iommu has static list on bus types (static struct bus_type * =
const iommu_buses[])
 which is initializes the notifier at init time. So, if we change cdx bus t=
o be a module
cdx devices would miss these mappings.

Thanks,
Abhijit

