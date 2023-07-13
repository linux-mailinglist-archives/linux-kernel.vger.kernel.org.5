Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DF751A35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGMHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGMHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:46:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906C2108
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234376; x=1720770376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R697OsvFWDVdPENsEzZAwE3kYrItTmsJIsseqtzC7hs=;
  b=eU/yMdJcvvlhpLMzNSELqpQbB82b/u8KFdTPffQTcJdndCiPenB5W1Is
   QdZGUDJ55VzIdCe6Se6QZd9Qk6WP2YNnOel7h9CITF1davB6P+tUXa/qC
   L7VnwUdcbiS2LUL7bWbyw2OohuyFbzZERF9SwpUJ4kRE3JLv5xLC7c2wc
   Q1bpB7Vhxf2sMdwGh+hiQHO09M8VyATIzkO0Kre8Mn6p+HzoWNRmhPevL
   v3jorJX/BUZgb/QkDKrQaxf5nKXJ6Mj5FujOX2TTeWWO3rqNbm69Dxcn5
   GO90UGHVL3Dd44mxCdGonn1MoBW/XeT7PKHKzcGD1Q7C7gAxIhXQHYKwf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428867362"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="428867362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="721827643"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="721827643"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2023 00:46:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:46:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:46:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:46:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqZeEv5imE3WkkCGgyMDgjA6PMsyalBzmsEXxX+5arh+/zzDTZcgqVQ9fVZTKbp1DJMhPU34UMaZYleojlHY9t2k+u44DMSvikXAuedrIc3RtdUFHtPDvuWoZzCoU4Wsjf8iSVyEL16W+RNOHMGBs/21Fp/zOil7oyWR4MI5QcTSB/jDSyr3c9LQUXOdY1LKdygZR0Ue6RaC5k7/GchIuXI4aFGTjrYCtXcjWkAxutkumLWS5fcc8qUYVE0vXsz0562Z58TRAof357RVEHuhFtY/V4fhhH6T+Q5qDFowiVFvBZvRjnWmC2EnISpWT9eEj2CahqRQFwPDIWlypvDugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R697OsvFWDVdPENsEzZAwE3kYrItTmsJIsseqtzC7hs=;
 b=Ijusk9due3xixjhUtC/8KrPydESPpqSJ/rS2whDP0Bjh1JOk5z5aL3yh/g19Zpls+7KWN2YLU/hYXEzcuDMJeJeyKpBs5/aofArMomrcJCiJfCeTIpnH1helFiOPgCNmMIq0+TO1wQTiRr2dn+vSFu1Hla6YSudhpcAyRts1RbU4DAxxXDW4XyPCREBwy8TqlAl7sd3s4Cri6GnQzHxTB/J7ULAsiSEYZGCNSCCWkd57XsnQPrliTp9PQefs85ErZkS5GChQFOMnbSiRXhj3hVh0kTRq7pdbE5I6IGhewcmTl0KxGl5jlUzp34kZ+iNpIJzNyxbXgHMai6bsiNpYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 13 Jul
 2023 07:46:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:46:10 +0000
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
Subject: RE: [PATCH v10 4/7] iommu/vt-d: Remove pasid_mutex
Thread-Topic: [PATCH v10 4/7] iommu/vt-d: Remove pasid_mutex
Thread-Index: AQHZtN37eD/DhDZg50+DfqtWuhdn/a+3UljQ
Date:   Thu, 13 Jul 2023 07:46:10 +0000
Message-ID: <BN9PR11MB5276E12725C1F30BD5FC81938C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230712163355.3177511-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: f74eb370-f5c9-4699-caa7-08db83753981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GajrQafX6orbT0VATQNIjtfNqqX1Sf0OYm6APuptcuVn07FVyuX/dKOjPW0p6n2xwDd7A5fFATIzhxWj/xM3vt2G0HBJWoeAwhXI+XEtyBVLHpg6c8/2pxB8qzHWfoIgagpj901kYect1V9S4HbQ36g3sxxDt36MmyOhBU+rG/ub0kmExJAG4OCmiY7MlgjLKfA6QAktwJ87JoVLj0ryCm6wt4aBMnGqn4Km9ET/fM/zMwnf46qi6PF2+TelqIR53QHg0xFqFf7HTixSAw86jqEPtozXYxr0kzTPPPGHCyaNcDyTp4dwW1GetAD9P0q2G6zp0Yu30nBv6Us+g2hjv29tqnsBHIoaE2HAs107OJpGiLExzKcBAoZut7+LJrFfODfyATheqqmGa4njzoSEN9Xo2nS7kGFSrfSz+lTom7uIKY2fd0+d+ZNRV7Af/gG16RaL/ytG7Q80MvX+kF6JuP32oqkQemqmbFSouDhnYsn3ZDaJ0oQD6y8YJGiFYd3Z/aiRt6YaFG/35Rj1ZLqaDBrPORwEN7+pkzUsKILrihxm94g8vsYZbmXGxqILrTXKVsEgTUpJPFyTSXwGmhaXaZ9KdPJetOxKA43cpe7wyOkxA6zpxCcgOi7ek3FbN3c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(76116006)(4326008)(82960400001)(316002)(66556008)(86362001)(9686003)(66946007)(66476007)(66446008)(64756008)(186003)(6506007)(26005)(83380400001)(122000001)(4744005)(2906002)(7696005)(41300700001)(38100700002)(71200400001)(33656002)(5660300002)(38070700005)(52536014)(478600001)(110136005)(8936002)(54906003)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g9kWPzHkcUrdFI8jLeni/AaKbHCvI3kXrFDxJQJd86rlL535R+mhPMDHnpeu?=
 =?us-ascii?Q?ML6FxItWFdo75zyCC7iSUdMK3oVchzc19DSTFuug37KRhPfPNa11tA2QgQEd?=
 =?us-ascii?Q?o5hV2NCt5Q89VT73/Taixv+QgSA0DH7skm9c3zS0NHSt6/xKQlfqpZ8lQbnm?=
 =?us-ascii?Q?k9zI04tUbcXn/X5GINCnoJQY9TniwC4lol0nqBP59G6We1+bvkUWKNmv/jti?=
 =?us-ascii?Q?eIRGCiGnuiqweMtzFXuaZTtuKxoaMmgerSeP8UjW51rzYUNUVapLWIw6YP9M?=
 =?us-ascii?Q?8/NqEYl595Nf6zmiG4O6r3FyyrXrSKZgqKvXUkE2bWFAvHOEZgaoCD1i5Ea/?=
 =?us-ascii?Q?IpJqnqic7yCR74aMDErJ337KV+eqK4oeCuDqCjmFF0UMljJ1zzD1t8guFeyj?=
 =?us-ascii?Q?89v7+hW0rlL4XdcERsS2rHgNNgBV44d6Etm9NJ7x30nsokLBE/6Ro3QSj5Sr?=
 =?us-ascii?Q?OA3g2miGNXXjVgu0cvAEjrn+w/AxDEDZppvYyrTcGD6nYltl+to3GBSL5Sy3?=
 =?us-ascii?Q?XJZUI3nPPNL7eaic4FkStXbEpTAvEm5uVSTIN5HcT1nG+GUuj/Hf/gWL53po?=
 =?us-ascii?Q?zLHGL3MVviyRNHC1Q9Ef6Wx6PKLiY36H3g8Nqxsy0E2LjOLfD83mSvcgUKh3?=
 =?us-ascii?Q?FpfF9eiRXczLWASUw8iymGo9zmRfKVuNASTrXzW4lQpEFZ1C7MqgHyWn3CuL?=
 =?us-ascii?Q?Um6oDUDaQmkPoEiv8I8UEmeu9Ks4ZHW2HKsMNz42f8ubs99iHxEnm8GKut82?=
 =?us-ascii?Q?OKkbGL9Z/pZupO3IVharhfkWktxwxqIKnM5MVFx6OEdgQobN7YV0Puz8eYVy?=
 =?us-ascii?Q?cjujjOBdWD7mP4hlHqHZsQUpO4Zj0DE/xZ4ELHyx2cSPCJmtoki0o7bRBkqc?=
 =?us-ascii?Q?Ar+rto3XaCLVsE3kRJaHSPe/QdVFUwYZKxuy4vaCc871gvq9S5AInc+yRJTv?=
 =?us-ascii?Q?GgfMJsIgCN5l22irqw0NY6CxsjXPjy5RjgDkxb969x8tYiTuI+T1upPkUJvU?=
 =?us-ascii?Q?/lfXLwsYdhm5aadW6C5wKmsFWjisotZPj9nwB87RX6234HVKNKk84tZgTehO?=
 =?us-ascii?Q?HoGgCu+SJMjD1fvfq4lhPEn/GfFOdRpcg9b2LLKmnqHkM2YtETLPjlKz9A/0?=
 =?us-ascii?Q?SITHPrcF6WM7e7rdeLkWf42DNIPOrjB/ylkHO+mHw7kHpCmgn2ZSOl2nD1Fe?=
 =?us-ascii?Q?cdt9J1q7kCrtLjhyhOkZSoYrBuVHdjoIpm3r/j5Le2ZAfEYRinZkNCe1u2RL?=
 =?us-ascii?Q?uu1UfvTZBM515rJBVTm0gP74vXDxsqi3NjwrZU4UezBI3905kDWez8XDy4mk?=
 =?us-ascii?Q?aBLZ5jt51NZ9kB4uROaFnwSW5eKyMc9N3B1T91jkjqAB+kYk9odQlSqRy0c4?=
 =?us-ascii?Q?w4f2wvBu5iaj5zyFx+6D3jxwemGtVSjVAAPFFSfO5W5fo+D+/jkf2XQbBRK3?=
 =?us-ascii?Q?0yZpew99RjoR+2eaFZ/NxAQOq099CF9CQNgKlD3TluNktcSw4XKMAzhrB3jp?=
 =?us-ascii?Q?L4l+QUQdWz/GGl2bIHZEhOQOZhaA0rAgy8tu/CmITVUkrg90ZZpxY+oESOjB?=
 =?us-ascii?Q?l+aCvge5UaY8IzEqZVufNcz2yFVRTivzb0GQE/jp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74eb370-f5c9-4699-caa7-08db83753981
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:46:10.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TX3FCH7iYaxyVANGz8NhfHE7jaWMBSooqFGf4htYgMkrb6+dBZh0JyDxPewdmgPrrlleiR35pcmdMeW8JdD/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:34 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
> It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.
>=20
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
