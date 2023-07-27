Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650BE76462D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjG0Ft7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjG0Ftd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:49:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA812681
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690436951; x=1721972951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=obP0XrdGiiQ5JcuaRRAD/E0rjoM4ZSgaINGx9veDZx4=;
  b=EIW6+hOrNiqKDdnv0grVtoB6vl3k/IgYzVE3/mKlXEV6WqpMzfiBpLTg
   wfhNiZIJzGWUGTS7UT0rNoUKHNpf081nN1hUECJyxiS5yc/uy9/KaCstP
   xNWWMsfu6mtLolnqva4CWDfIBhViKu3cIZdTZzExfzKXfOz/sLSAcoVpm
   sb0BFeB4KPwaGPC45qNnSJljumPAjqt+y9YIW9XdcbY9rcLaVDTopuAJr
   ShYRFPoGpBMzY5UYDzQPaEG8CX9i41mQavQ6R7OjsqhBZrd+N5ChZAQx0
   +hPdnkSfFDL8ujpZua8IHCmMFrUXhXU3M0tdorC1/y9YyUH8uVgLbYV3C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152127"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152127"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840584932"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840584932"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:48:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:48:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itJo0YmES2RSeLuWTZCADUnQvP3o10yF29UkUgqLrqEFh7BlHvRh9ph/S94gaG/X8Y/ZkHWodBgJC7hgh3sWJ+HcexUEJv5vla1PXIN2Pp1GocxMiRpb0KYTnhvpGUId6Lb7SuwnFI/bYfUQ0V4N38jtqKFTSvTpYdxUW/LhJn0VYNkIJF9OB9m7Sc5PHpqiadISf9/de8+AR9GPb0TZyfsYulRcPCx3eiMthaKu/D56zQAIDEgGqL1+8U5BgqZoNd4+ZMCK92zQdEkO/1TnxvzCTSLSVQ9cOW14+AVbfkShHQAyA1rKl37KRxgSo56dGfIKcmJlW6PmgVQ1nCuxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obP0XrdGiiQ5JcuaRRAD/E0rjoM4ZSgaINGx9veDZx4=;
 b=jxc+Aa5iTkCOWJWyWQlcuijjZ8pEEunsAIbuKUX1gYDx1Ns2FBTUzPI219hO2Stj5p9O9ZUyJVAYzCRYxeZF4hP+FLtTkrgdgtlKZ/ViC7rGVwKcUO5A1AvO2jPAAeSXgJQQzXqyni7HsMoll/9OK4EFV/3oOEQnx4qHSV3RFGz3MeNQ2KmbTLC9MRE2pLbFuUWm7zcPJjOZ13tg5Pk+TyN9m7fyYoY28cBQZ8qdKx1HDW2q3KGen88D1xyQtXV4Yv9fLa2cTWz5NMw+0oTDEXt/9BG/MdkYu5EusYcKc8BI6l0gfA1t8T3IBHuLMSoKWmeOQsbIh+j64/HOyURBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:48:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:48:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v11 7/8] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v11 7/8] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZvn0g09GN3yQSeUW8ZE7sTjfOPK/NHvBQ
Date:   Thu, 27 Jul 2023 05:48:35 +0000
Message-ID: <BN9PR11MB52761E88986259521CA00F668C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
 <20230724222538.3902553-8-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230724222538.3902553-8-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7056:EE_
x-ms-office365-filtering-correlation-id: e45b7ea9-c052-4e88-6d74-08db8e651e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXshXGI021RBF8cXs71si9KhwbcOIAjmuN98KYThnwpm6SYPgOSuFtBNy1BDMdTKWXWK4u8yfoPxYYMl8PqNKQvpj95+IHM56Uw0HnCYUd4B7JmjpfG3Tsh4tHc6+fsapEUm0VQElEzdvMyudYjT3K5KZnzrMQxuPn3+QM+et/XGa0DCCV7697VNnEWjDQ43d9Tr/WAYwzghkbfNkgL8/pWBN8EA8hQnw+9yM5FCo76x0chHu3PxsmKkG6n/ZaSGpYas1CApNPnxLbu+bvTr4w/50aLI971x1OXUMJR+KxGv++f8okHI0DZRKkmLcL4x9Us73l+qM99FNtpfefjTOa5ArXnnARm/NZSfqlct2ijAKo7QhwMm/KnOKXVn5weueFMb34MKcCJ18EEm2znLQeyoe6A5fbNDU8vKSCQQM3zqSroy5Yl2gRIbsefknUeTO5byUAmPnKYuzLKmI+b6JWlXoqFSbmAsu3XTSYECvgDNt5/A4tlJo5LoWXYztdJ1j2realGuD1YePFemkFmysqWXH0FYKB0dxVDk5IZgE/4Yo8fRoGN9H39WLyPKZOH+Hu3KppnP2IaDbv0RDeBSBKDPj6Uz/MCKZhE9kg8HLaC0W5gjyeeJjbFhDP/69wHY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(38070700005)(2906002)(7696005)(71200400001)(4744005)(38100700002)(186003)(52536014)(5660300002)(86362001)(55016003)(33656002)(316002)(26005)(6506007)(8936002)(8676002)(41300700001)(4326008)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(9686003)(478600001)(82960400001)(54906003)(110136005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbbMhxSQBxah1qDQ+QiH+DPLgIbU+cYG9iEAK+5bmaDvqXiztDKKRGoUd2eW?=
 =?us-ascii?Q?B3H1NGq2y/OzHkqbleU2OnAMfqA/P0FAbYC785eFkVKUIf1BN7kk3GFCkpcA?=
 =?us-ascii?Q?tjPy0kQXHjaMrIJ0bio4OShbKA93uJ28M0IIISSV08SIOy9MaZZBwvtSxWbu?=
 =?us-ascii?Q?37jZ42nT+q82pOPV5slDAQoyIODOfZM1zbNIeR1NeF9AqxrXuTx1dvLCEO5l?=
 =?us-ascii?Q?KjFOO2TzDl+3h/SNULHH6wBbP0b/GXzdZTGC8oSf110KkKAb4RUIhh+kRL5O?=
 =?us-ascii?Q?6oV8uGE+/HjwS+V6Bc22qLfyH1VQyfdSzaqKuB5aeBYTHT4mSmOD8IyELPRC?=
 =?us-ascii?Q?ves0aoRyfR2935MoacL1JpdRAvVktwRNq7QJH6jwLfuRiGbP0AOFnTcdrk7+?=
 =?us-ascii?Q?20JP46okuUVKEHhHJfp8bhZCqn6UgDIYZXuPlNPCGQS9BwOjiNeF69Wavnhw?=
 =?us-ascii?Q?5rSBWAhcz/Orlri+G8sz9OcXO5CDvLQWHqI8zM02G26cCzwoO7BTmjxz7UsW?=
 =?us-ascii?Q?zQuMbIbGvZzDJBNiD7lGNY1Uar4jdCdcDTayai1XW3epFWJdiUa/Rf5nEHJW?=
 =?us-ascii?Q?Zckp0eNC4Q+Pm1/H60LgIBt9qV1nnFTZg3NV9BgL8kubgujs2sAnVvXmszJR?=
 =?us-ascii?Q?e0uIDouJfyBbDMZgVJzOzQ2XEdyCGXqVM4To3VtIVyg9saWFGpaFujUJWCuC?=
 =?us-ascii?Q?KCnsjGbT4eNAH+2ooQBDKrPSTCJ6MI5dagdaGRDw8BRPlr/S6zwygpkkMHZW?=
 =?us-ascii?Q?KsR8T+FpZWFhLdmUqgNI1kWYJcmnhX2HPIwH4d8kNJsNApRRiSmtOJG3cjA5?=
 =?us-ascii?Q?7Xk/nMwLG1/kyeISt3ZOUT00aVqJO2GHO/xKss70RkqxJ+/kyJsZ+louWrQY?=
 =?us-ascii?Q?4sAva6RU5JUWxNsRB84jZ36KjCe/yhc5esLMGz1Jgb7CzjA/kU9SV7mAalZ4?=
 =?us-ascii?Q?pszsqLeuGuRP7Tz4MMdCPz9soNC18LDYMjjXvmSKUZVA9wI6J71pGcGgmpER?=
 =?us-ascii?Q?110d4d8CRsL+l6FBchTxuNbsUnoYJ6SYng8g4PjQmrbIcv1evBCIw7hJO0ne?=
 =?us-ascii?Q?SekIwiCUTAPCazBiokkbC+06g6eg702tS0T96hXtjOKvf2wmmtz8RqUu9n2K?=
 =?us-ascii?Q?ft1QBg+cpLV40/vAxIX4h6QzSVY/od3dovgC/LywbZYJmLGNqH002lD7w749?=
 =?us-ascii?Q?rEEyVNR0ANbrurxy0ZrYzdmj0cXZYWBYMTNKKL/HiA3WlGKyCXeTzJdLmBn+?=
 =?us-ascii?Q?pEKyJeNPUH8ie/My9YH+8i5aPlRSiVUj/h01dgZ2LLhc/w7AHthH0EaHUbKA?=
 =?us-ascii?Q?6J9fxH6zNpHh9Edirs+NKsW3oS/ippnjpyH5dHvr2dQ7n4LSMhw7ia0g5q/C?=
 =?us-ascii?Q?60O50jXd9LQz2suxXI6QxFyzUqp737cknURYcuK6T6+axIopY82sH2z+Iefz?=
 =?us-ascii?Q?O0OjYZtM6jx/fC7edVxH6zh3XMLFkU59ZVYT0gfeAdn/lj4dzagHLMIIAiOa?=
 =?us-ascii?Q?CJakjRb7+EAjs7VCmg8BtYq5YsycuoWsliBFNb1hxnAClEZ9JWntYoCWxNwK?=
 =?us-ascii?Q?t3MQX1Ep/Mmo+gNSZBe6M7mJrJAA4/T2v30XO6Fx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45b7ea9-c052-4e88-6d74-08db8e651e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:48:35.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4gwb3Tali6tgsl0wLsgZaePAE5r7Q8uo/mckicsr/edSrZX1f3oQ5cyxv3y9cBoOXtm4rutcX+ft3CElqfJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, July 25, 2023 6:26 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This allows the upper layers to set a domain to a PASID of a device
> if the PASID feature is supported by the IOMMU hardware. The typical
> use cases are, for example, kernel DMA with PASID and hardware
> assisted mediated device drivers.
>=20
> The attaching device and pasid information is tracked in a per-domain
> list and is used for IOTLB and devTLB invalidation.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
