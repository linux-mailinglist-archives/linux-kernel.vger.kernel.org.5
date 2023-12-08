Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3F809ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjLHJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLHJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:09:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF2C3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702026548; x=1733562548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k0w591Bl8MsALRI9AwD5lqa82y2lU8XpLDRNu6GsgGk=;
  b=Nt4ylzcvW4ahy33oNmsgPdCt9Wnap9AwLn9OFx8z52fYAsettaTPcyEE
   r0ktjyqjU7b9HRuJWLBwuqrEvCkuIWBTTA5SyLCnMoA4sKq3NL4ZZKyRh
   tuqXiRbIdInOv6zJXjAI7Xz5BVTFDIQtNv3EL//v2EkEkDORBeLV6I6lQ
   5Yf9WfwlS4mWaR0shwKASxp87NvJRV6zEWLX2xfOY7qDcmGsjNgfXvRB4
   PQMJAIhtGZSfGCSx7BP2RrvWTfHil0Tm8Vt8BW1qzohCkPah0i7tT5pGL
   4fcSfKAbgn8zhnVkh5vMgmnFBkW+OzIprWUTTQhwGnRCjwn8OR8xfN4l/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7704773"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="7704773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 01:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="801047258"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="801047258"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 01:09:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 01:09:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 01:09:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 01:09:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGlADZiOWmz6U4iFTkkfRLc17fn5Q4ipymBLCmBY6RU3G24tLtwsf+ssg2XyputEncxJCoLcIlnVRCD8cHISxV4bSyX6tWEpgqdiXY+JF67gl6sSXEqDUWOrx9WDqPfHHVg/UfCmpkeuxRdHjnxI4ABJznRDZrEk5fWIbu7XFKF3KKXfY2VJ9rXLhXkfTjomYt+G+k8MDL8CsKjluoXOid4VRbrc6ZoB8zo7HStLqrPhqJgoZqJQGb16zUsXw98GHjTy9TRX4IVnq6VCOhskazYtyt2KSd11UVyYnlY0uAxLBSKJCBvsvrsUkz8NxMAP3ui5rMtDnt/sEd59Rhdu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s8tZVBuiliA2vhwTsWVdqXVneULnRoYNZpbYYKuxhA=;
 b=hXwcMB+2hgTOG/bpcM/emOgV4ocfCAWwY77+blEqxd5ONfttP1XNx4MI0YJCFjs0EQ578ziE+236CHVSJk+UVcoa+MQj6RH77LxcvSE0SoQNRbz+MDk87uL9j6c6uiI1JUNMzk+VmJrNyz0JgovO4FjPnLQKCM0UZVrsfqoq82jKjQIu4CPuGSsxnFVNwU5XXwdomamEL5YOUL5ql1bnfRdfYaln9n1VPu9ntB7qQDtvUFOH6gZQyPxSUH4HrdaFQ9McfHBDWZ1HGfUosMl70ltsMZXNAUCUSss2DepUoJoLwK1RUZz7NEWlGNsoe1iocRgfRoopiWSB+LLGYD9zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:09:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 09:09:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Topic: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Index: AQHaJxojfGMimdGl20KFwsu2wXzMo7CfGuwg
Date:   Fri, 8 Dec 2023 09:09:04 +0000
Message-ID: <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
In-Reply-To: <20231205012203.244584-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7444:EE_
x-ms-office365-filtering-correlation-id: ddeeb12f-31bc-45ad-5e07-08dbf7cd538f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oncXk09HzvcUPBC0cvwpkHfQY/JRNZQcwpjtPxpXMhOo4YbajS753ov2pk1Q7461P5O0/MnncfSvDG9ISYJQmpJ4muOD5W9fGThZrvNeYR8pSajEfRyNZRApQ6x29u2ZI+2wsfEldg1ZWgQK8YlX6wvQuz9uEpw/mi4jbiYpX21PycEGkJUVdtJXzVH54fm3YPisoBi4oi4xpw3YL7p2RvmKopZfRdXOSWB/GUA+4QL/viVkpjtlL9vpYgd16edi60mA/4Mf4WL1BmhsKmQIaUl3ofJwa/04/xmmG01y0IY/Dno4jmfVFq9M184iIBNexV19I0bYkeaPTQvUIxCRZaN3HKgVwwgLqWpfHZSt+ud1GoPyQzpma12TImvWmRQsGsdbZHULbO2+ndNID8s0Tg9Qpz7E8d0qaUAFrgQqtTwoJKBqLN+j9FLzJaA1ohG/6V6CgM7elKrTqcDLiBWY/FawGP8ujge9FKGFH6jaJ5GC2q7qOo1nzqUb4xHQXmtuWv0NLsis5cg3wAe3cwKNEX4QTSYdsDhoZDLBMhQQAXCWYxYyzN4daTvxJWciZRiLNakJYW6Fxtzsu/zJIhu5h0NtuE/M+eqk9/gj7/n+YGzmBCf5EGZkzBsnpTP7leU5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(83380400001)(9686003)(26005)(55016003)(478600001)(7696005)(6506007)(71200400001)(8676002)(4326008)(52536014)(110136005)(76116006)(64756008)(54906003)(66556008)(66476007)(66446008)(66946007)(8936002)(316002)(86362001)(122000001)(38100700002)(5660300002)(33656002)(41300700001)(38070700009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7wVIQzR/52KOO/q3eVd/7Kk405+A3yyxHTlwDqJWDX4xvnoOXyQkyuhLFdT?=
 =?us-ascii?Q?6J+S6rxlwQm/U1lMiHC0HSdkzSrFSXMp98reyTlxP5ACsjjESGIyRbSHhoGx?=
 =?us-ascii?Q?rfC09GUainW9oh96Hrz/qKGsu7RYUu3Derxu3TgJsR/JP+L8FIiFq4Bz3rVL?=
 =?us-ascii?Q?mVt0FsDiJMeAX3XlXAWcOamBiDQUAOAZLfYDmXeATcso2Ep9ZnzHtHUTJl9D?=
 =?us-ascii?Q?J1b/DXh6GElgmXMNuzmTvOsf3EYgZZ+izWT6YuNeAlZRuZgt1iJnYPqgdPqt?=
 =?us-ascii?Q?nNKWwKSX98F71QyItk/J4qqCf0SRJiN47SN830nCmG74OWwdGB2rPU1bIcnt?=
 =?us-ascii?Q?sCyKxLwoJhps0BJnx8aLFgTp30NaJDeoMsXrO6P5f9PSDCwEzwlQxGDftW9c?=
 =?us-ascii?Q?0csH2wsPwgMMYW5pzVCXz+n6cBM9Ovr8+fTsOMc4gfZ3eoZbAu5U9WS+CT1a?=
 =?us-ascii?Q?E6XSsqPckmgfLbmhnB7pK7cDvcNrDlRDgl6r91zo+kTsAxyO3SlHZzxRlx3g?=
 =?us-ascii?Q?obwJidjihuMp5bcBINc9YZWjTmRPQ/EZN0SgA3e5r6e33uK36jzr/srUIHfx?=
 =?us-ascii?Q?yMC7eWU9POBpbs15vQ8t5Xct6/+d5wSMB0CrIKWlyuQdOCIGqPj+Byh9Y6Pv?=
 =?us-ascii?Q?kADddqYsLhadav5f6net6caG0xeM1avWaCiwALaVtpxbOj3L7Gmyy95Z7wjH?=
 =?us-ascii?Q?ZQvuiblHe2chgXerbeNBX8Nb9tlssVg7zIOHVOm2K+UyCu1Nh4S1a03zAjst?=
 =?us-ascii?Q?4Qeq/9LviNQNgvxOY4oSx7KpLZF3y2oE2RNkF8+ffEzbcBNWdKlpCnnWGNdK?=
 =?us-ascii?Q?5eqyryZa90imMjMJrwJp3opb4OQtd9eRAlj8iiNV9ETjsFZLIBxjYD1so1sX?=
 =?us-ascii?Q?Rh2cpwM9Vv7S9/55MSLD5L6vWiJqMxOlYr7InIGA8se7kVLfZli2uTmG7XEQ?=
 =?us-ascii?Q?vvBKRASzY/sDzEI1GlFSoJkukyOliUg9zEE525KKQiAyw7+U8hcVgIozzhHz?=
 =?us-ascii?Q?FhnNghp3yDEZHFuZuD8+pU8MbXoqEQ+jX7AE6Tyg2K1URgmEs47ugiaHXi0c?=
 =?us-ascii?Q?sGQmKqq/Yj0OpuGu1MFZ6awVhA5FrSseK2QTZMHzEyW/8XBZw+36IGIvBmMN?=
 =?us-ascii?Q?I1cZ/AFHiRK7cZVBDpIlsqA8MrQG0xm+dhUuEC304cxTZ9OqQbIODWPSCENz?=
 =?us-ascii?Q?CvSzdQ4xZniYQsTpDAshDtkLhvDyR4rpgU0jiIEx7HRgiBY3a+kUkSsm2/Ls?=
 =?us-ascii?Q?zWwUkEQ0RU+RleLX3H0uJIS7MK3HyFo0+mPmhgFiaaK0P3jQEjQQRrvt5vZG?=
 =?us-ascii?Q?1BDkW4xKGsQgbVPCetnMyyYf7bqywAUaPYapjL9U42AfrR596lMigt4YZTec?=
 =?us-ascii?Q?5o6IKvIvOVO6gLlZHTGCC1fRo4PfHUAqDDTBTkYxU1+G8zvCn4TMO+SSal5m?=
 =?us-ascii?Q?XKBYmQ/6EHGj8pyh9w0ouZ4hnmt19k5Ud5nTT4I8WHdZlVdWtwuJBrcOH7xL?=
 =?us-ascii?Q?UrzA4Gb2AnFq46YWigCZ6VdFohf1/vlFJpRbwpRATfgktvA00iELSSlzpBtS?=
 =?us-ascii?Q?gwJ1nXRxSO1rRNm3BC+0zghCiG7k8Ps1wfg25naL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeeb12f-31bc-45ad-5e07-08dbf7cd538f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 09:09:04.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIz8Fp+DKNElzOz/R9L/IeFW+bRUaUBvz2cp2YSjV+udAD1EiRJJzmUCL9mbml0nIrJk2vTcpXQYOEYJnF6v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, December 5, 2023 9:22 AM
>=20
> Older VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a DMA domain with all
> physical memory addresses identically mapped to the same IOVA to
> simulate pass-through translation.
>=20
> This workaround is no longer necessary due to the evolution of iommu
> core. The core has introduced def_domain_type op, allowing the iommu
> driver to specify its capabilities. Additionally, the identity domain
> has become a static system domain with "never fail" attach semantics.

I'm not sure above explains the reason for removing the identity support
on older hardware. Looks the reason is simply that continuing to maintain
that debt prevents intel-iommu driver from catching up  with iommu core
evolution so we decide to remove it.

>=20
> Eliminate support for the 1:1 mapping domain on older hardware and
> removes the unused code that created the 1:1 page table. This paves a
> way for the implementation of a global static identity domain.

Do you know how old such hardware is?

> @@ -2311,6 +2257,13 @@ static int device_def_domain_type(struct device
> *dev)
>  			return IOMMU_DOMAIN_IDENTITY;
>  	}
>=20
> +	/*
> +	 * Hardware does not support the passthrough translation mode.
> +	 * Always use a dynamaic mapping domain.
> +	 */
> +	if (!ecap_pass_through(iommu->ecap))
> +		return IOMMU_DOMAIN_DMA;
> +
>  	return 0;

there are two cases above which mandates IDENTITY. Have you confirmed
that those platforms support hardware passthrough? otherwise this change
is broken.
