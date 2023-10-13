Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54F47C82A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJMJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJMJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:57:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC32FAD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697191053; x=1728727053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5nwy2fdWAa/5dkkVuvCfC+RRDy1JyGSgx6S7/GRm1K0=;
  b=md6hDjcMWXyzCCWwrh6/qSeQ/YosCeew6H8e9RPYH2xVmk0ujySActvH
   yUKeXefmnVl4sjva+J9fEb8GBVYlXPyo1HhYaVv/K+mm0zV+++0JPcxNZ
   GWbeJihq2uU7+W7hqFRXL4NluboLwQZ008YpfCNYcgSeAd6vTvWPz8L8s
   hPgATHCc7e8hs9NhvqA39o9PQ9FJHBDXrCTShMiuyrhem0vUsrdpC0Szb
   C+iBpxRZjFZYeQiQcdjb8LdabQwskASV5aHEsg0t93qDqvObOKHnci+VQ
   L8mWEBqb2Gas2SWl2QXlLfaxbnrb1dNZVVhjnmwiISFluSmFpdPr5VL2f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365408568"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="365408568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 02:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758435561"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="758435561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 02:57:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 02:57:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 02:57:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 02:57:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 02:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL7u3ORqcwNFTtyhacmUKR7MmfKkJpxdbaLaqpsD0KK0quG4w5UJe8GVk9JfCdlD8SLunFOx14SPsawpaiqKg8ptXWdQTs4yiLTggXDljtoWKRSuOdxoXJwRe7JBrDrUP8C20OBk/fUtt6UGBfRdKG4aRsM9AhxhE4d/AwajQ3PskLESlogJRBah+r6JqRBXD1X/zggvTMr3jyqXp/M2hSTwRGAYRZCohhn6RIFMWVhLg/krTBo60YxsvJQrzB2BQJqCgHfHGYJbDpn43Bz6XHec0dIxdQXcVU8hPJ8Xd0li1c7Ji71KOkLG4lWR7VyBNNtoZPinnL1EveIHPMvxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sljIsHih+36+bI6gSH/dbwePrhQHuWroTFn0h1p2KKU=;
 b=F3wV2NhDHjvDC62NCGnk378HczmeVQxAPdegq1P0S3k/lT/E+aU2V5fb8+zSRCtVoocX1+hC26RcP0ERMTtT6jQ0ElVJ+Droi/TXVkeNOSJDOHFDM+Ul1QYlOre5PcvSYzkASFTogbXSxKuu6GxNCrRh3W1BBO0yeIfhfRkCWE4ev8Nb9dMJBT18BtIAUeyBq1JdI6BGNxSO36AR05SX05a6hjJSd5vChAz+uNrbHC02DBzLmCauGm09V6bUs80skXOpv7mRnjuiQo6fzFBTHfu1yUIhII225mMtT9sB/MMmTA+z/MF2fj2nN7Yqw57fAOb3h3hUV2MrsCI75KzrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 09:57:30 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 09:57:30 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHZ/Lhw9B1X1cp/m02MO/EHJI2kHLBGKqIAgAFNwjA=
Date:   Fri, 13 Oct 2023 09:57:30 +0000
Message-ID: <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231012030112.82270-1-tina.zhang@intel.com>
 <20231012030112.82270-5-tina.zhang@intel.com>
 <20231012134310.GI55194@ziepe.ca>
In-Reply-To: <20231012134310.GI55194@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA2PR11MB5114:EE_
x-ms-office365-filtering-correlation-id: 570e4083-973c-4d26-8ba0-08dbcbd2d091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjEsheYUrniJlLdfWARwRi8wvsUfoDyOk2/LkfqhUWrgxV4H1a6zKnCjzaPyoEUVQLBtN/XS2wGVg1WiSPtfuqBYbYy8WU84nnZSYHpx29Kufe5UVXujB8aPHgN1xNenl1058pptELGeXimtdQkh9sGCsU//+9GEBvyd4vCE5UPDwN4pviKVGzZ8OKdCaJ6VFPGnAafw74/pg5TjjfkrAi2YHYRII/QUPrKfXhpOmYIMk6iE+/2DBoxNm8n0SiuFRaxJVHmAPRDyn3PHU88URpEeFrpec7EN/I562Y1armtzxkIjUsDdZDqopdval8zWhy+mHFabZrB8CarR3ExWYpaJa6ZPUpHIgb1joBBqNVDnDhx0GiksZwQDYuDRhmDHzm7InY/OLDEtArO91138ngRo8Z7c4uxwQiTTKK6d9LMdXkHiwy27regOY5Zycuina/oTv1GKgVGK+jYUKrfjMR5fI08mletJ4pZh6MfIxMlQqL1cKzCGqrQ+jwZx+cPrQS7LA55JYhycdidjBpXm5nBWzvBsuYhVjBklHD5Jh9JTSybwYAfOjoo6lwP5wIPJWLzAALJPhDQyfBjRMbcTqITdtW80ZQM78cmBmuDbecUFBWQlAFUegxFRW8kWV5IP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(76116006)(9686003)(478600001)(86362001)(33656002)(7696005)(6506007)(53546011)(71200400001)(8936002)(38100700002)(54906003)(6916009)(66446008)(8676002)(52536014)(4326008)(82960400001)(38070700005)(316002)(66476007)(5660300002)(66556008)(66946007)(2906002)(122000001)(41300700001)(64756008)(55016003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCQD43coYeFD8sIjyJaw/eUUC7FzRVpwQcheVwoOOUQm5s6F82FpPFGK7jVk?=
 =?us-ascii?Q?hG14dKMNEGrsxnVA0k24Zzmw/DdWDUllbpaksYu41PgS36hiWuHE7vp2FFn1?=
 =?us-ascii?Q?xaDcY2FUFSOT+uSlqDxxEKkqBXQns37ov5OSJMlgswr9ynrR44QEqTXWtl2D?=
 =?us-ascii?Q?12Z+kQNr1htoOG/HoB4iJTbv2+Ac04LL6rC1hUaBqwJKndSJMdI8JvWfBBTM?=
 =?us-ascii?Q?xVSSdKRcx39bsXXghjIgfyA9JXABymU8mUIkIDnG7wx5u4hW3WY2w5IxNouF?=
 =?us-ascii?Q?W/XVY+i6sJnKa2eCTn1W6+gI5QhsEQmiIgNBkw9C2vMAm8lS7EcmihATQGug?=
 =?us-ascii?Q?Da4wCIQgFaY7BnZieuWvzCnsWaImeQ6DBMq3+jHjv5DvefPhK0Lz7hKtcR2P?=
 =?us-ascii?Q?8dtZ6eDh3R9A4U6dDLkGu0hlOIzafph23grcExkQwqMEFxLbJtw9iQ6Hd5uQ?=
 =?us-ascii?Q?iCGAudUadZ9zaymY48ZCvnlPZyNLvpljf1NIkFU9CRNK/3f3nUom/pSejD7/?=
 =?us-ascii?Q?HwGEqaR8X4EfISCJh2ZxScESq0UI+SQ24H6UW47yUyr5GqKkuFFLjSZWwKZ6?=
 =?us-ascii?Q?jtFzKY+6Pck8dPnjVRylusdkf0XlnTeUoBCYhmrmOqTaCgplDKwGhypxZ2Ey?=
 =?us-ascii?Q?DD6vCRkxFb1ldZn3Vsm7feKu69EpmS++b0LtZBQhJlyORyW9AfFX9njSJ8Go?=
 =?us-ascii?Q?9tBvcAsJe2lNVHYLjDOR/u2rKxo86/MlkiQNDTlBuskRov00zsSfyWSSqEtd?=
 =?us-ascii?Q?VA/EyTag0m9BDiOYWvXlQYl5CsXjmLFuQvOg7uFu6WrWy9zcKeaNUo+aZ2l4?=
 =?us-ascii?Q?MBYvNZYwu6Ilg4GnLP1JV5L65rS5lPse/3Taq0U/1DTX51l5Q96VWKObYaWl?=
 =?us-ascii?Q?Z7ixygmKw0TFK4P2+ARZIlhkoSk17vB5LuF77m5td152upwGrlOdXG+9V2gm?=
 =?us-ascii?Q?ZlfNq8ROjM0sUE0eLhnLsrwsKwowP876/W3fAL+l5KmczC1xIWxCchwbU6O4?=
 =?us-ascii?Q?6mjhDemY6NMcINS+Q6vHBMWNTesd0I6uT93v5jvbmmcusTISi+756dVu7uw/?=
 =?us-ascii?Q?y5hL5oiceM2AzbSNi3pxQeyJz8BcV2Nfqm5QdbSIBTfSdHPv8og10MrGvU85?=
 =?us-ascii?Q?7jdVg73RVYK/Zc0PLST/QsbyjCGWFYNT1rnC63RPVI/3pR9GAApLM/At4yCR?=
 =?us-ascii?Q?7j2x6ui79R8AmR6ECnbxiWMxYSBz4RI4+YwOkrOXD18w8lQSntefbFJd0b3g?=
 =?us-ascii?Q?g/AMWXxnBW4JXQuD++B80HQpAtMHKym+6+++FJXmZQ4E4xFIlr5+9Cb5nBCd?=
 =?us-ascii?Q?yoT5BTUnkX4YGHVYxKxR4e+xRSA+94CoW1N0CiwqQkqTICi8oqsjpoc49oou?=
 =?us-ascii?Q?xaEUwRRV4xi7bXvKsXW1YI2TFR7pN3Es7e7Kbj1kMwTvS/YZ85td82vo+E8C?=
 =?us-ascii?Q?N91bnml6oFgq1CNUx6l7AAUgM0SIhAT1cIGWxEyBfv7rEht4T15itemMhTw9?=
 =?us-ascii?Q?pHir3dgIyy3suOmohSPcgr5jyiOCBlLFtBl/OvnxBIHTMluEp9HnQOQeJjS6?=
 =?us-ascii?Q?Tq4g8xe3JQOXjIU8+j/6TT2Tuc/I8g5XtEWR8qYa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570e4083-973c-4d26-8ba0-08dbcbd2d091
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:57:30.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gdjPGZv6lu6yC5ZVOQlYV5dfsKlBjEsGVGSyy3iygqd1a3xNw1yr+YI53C+UPG3Y+U1s7qowFfmV0PjmdqU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, October 12, 2023 9:43 PM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Tian, Kevin <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.co=
m>;
> Michael Shavit <mshavit@google.com>; Vasant Hegde
> <vasant.hegde@amd.com>; Nicolin Chen ^C-cc=3Diommu @ lists . linux . dev
> <nicolinc@nvidia.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
>=20
> On Thu, Oct 12, 2023 at 11:01:11AM +0800, Tina Zhang wrote:
>=20
> > @@ -1188,15 +1193,26 @@ static inline bool
> > tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream  #ifdef
> > CONFIG_IOMMU_SVA  static inline void mm_pasid_init(struct mm_struct
> > *mm)  {
> > -	mm->pasid =3D IOMMU_PASID_INVALID;
> > +	/*
> > +	 * During dup_mm(), a new mm will be memcpy'd from an old one
> and that makes
> > +	 * the new mm and the old one point to a same iommu_mm
> instance. When either
> > +	 * one of the two mms gets released, the iommu_mm instance is
> freed, leaving
> > +	 * the other mm running into a use-after-free/double-free problem.
> To avoid
> > +	 * the problem, zeroing the iommu_mm pointer of a new mm is
> needed here.
> > +	 */
> > +	mm->iommu_mm =3D NULL;
> >  }
>=20
> newlines after all the }, between functions doesn't checkpatch complain?
Checked with checkpatch but didn't see any complaining.

>=20
> IMHO this hunk should be moved to the prior patch.
In this patch, we switch to use mm->iommu_mm. That's why the iommu_mm initi=
alization is put in this patch.

I think I met some problem about my mailbox when I was sending this new ver=
sion. It didn't cc iommu@lists.linux.dev. Should I resend this version agai=
n or reply to the patches with iommu@lists.linux.dev cc'd?

Regards,
-Tina
>=20
> But it all looks good to me now
>=20
> Thanks,
> Jason
