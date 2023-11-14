Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A5B7EA904
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjKNDQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjKNDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:16:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18AD51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699931791; x=1731467791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8K1qWpnYtNxgdab2OWVrlpmrKsoIuV4g2FtbIMLl3OA=;
  b=FGqMfV9LRCiJixyaArShnvARzsDODxCrHfQm/hs66ilKaV45KTFOfWqn
   4TRgIHvILvP5CUO91cS5S5Veifqz5RPGPul9f3dUvX7CVKjt50Se+TzTI
   dvw3RjRbQMAFsDJVhxtVFCK6lbTnQf4urwbh0AE7RasM5UJJ9W9zC82PX
   8x/WWnuya0HWp7ziqzcmdD5qvFpEf2gXxbd3swCuN99e+dngs563BfpXp
   MFSDEDHiTxj07Ijo232fQmA8vpm9kPmVHgR79Adi/OIvE7LRnm5hOo3J5
   8imjM9QePF9pyvNx6ri9YdtH0UmBHQoxC6C3iD8mogfoDLL1ZRuDja1yS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421664362"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421664362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937900275"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937900275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 19:16:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:16:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:16:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 19:16:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 19:16:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cREyL7vguiy1uNh+MF1ZTiRlV9mqsolEex1c010MgUxt63XqC+7Ymfi5tCHJVrptpKbiKZ3grlfouEn5SWBb62/kQQ20I820rNTeSdNL+1YAX7SAxPk3PuBdN2helV3776MHUMLSL04P0N7ZFa+67entrybBJCRHKsXNNI9RTlJ4gQFDmF2dNHQjgW0ltU7P3bvzQwrN2ob52Jl2c2WO3Y64hgV2vwOikeJpnSAtWnTDpNNIJL31/c9+JBNMHlS1da/zbPRjgIoeQ8EpEqFmnZXw8DJhcjJaGf+kgEqL3CNR5DDRwXLUX5/3hGR+TH4ZQkpSIdWuxYMpf3lWtcZNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K1qWpnYtNxgdab2OWVrlpmrKsoIuV4g2FtbIMLl3OA=;
 b=X05sEHRLetPdOUNmy5nw09453kxbjUbrv1rOWdIc3WuuqdkLCeVknj67dkvtOFy/CwPF/JQq7KQ6xw97l50156f2q9YWJMoOer+AuW7cKT892dyxdegL9wQieklhRJ6zXUgUmurvhIDX5cXtk/Sr1SnsgSTJKrF2MMq34v1FA8BRfi3Up5MMqqtTghuJLBfaXSw/E9F/97DAxrrgWkuZ/f6HffN6QG8Xepgbmj4pmnYhv/QohBHQT39/K5Sl5ed/Qfk2gW+KbdDn397vG9JpQi2bxt26Qn7rtrO8YSxNfuGUpM77fsQNApAyOc+4quGvkFHr2qBal8NWtWTZCllXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 14 Nov
 2023 03:16:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:16:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Thread-Topic: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Thread-Index: AQHaFpgCc3b3GFc/mk+k8fNZw0wMn7B5JIKA
Date:   Tue, 14 Nov 2023 03:16:27 +0000
Message-ID: <BN9PR11MB5276F067638DD25327DF3D628CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
In-Reply-To: <20231114011036.70142-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: aa687a96-f66a-4e98-b820-08dbe4c0172c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RC/SNiUOAyy93icz2rwXZ+m6RyvUwDVhAkrx+y4BjVtcUUNMjAt0grOMNChHGAt8GVEOIyzV+FKluTB6vJs7XXg0i0njM0cyzokRoBKixh8kHK+er4FPMtqVxbnvXyypHN2v514ZqJ9o/A50z3/u0hoWZX9Tc7YvOZnZRxtPwSsazp4oZtnVxDiFIGqT4HgzlUY4wlXhlCwAjbP6PZhQl2MQ7ByW/Lce6vLT6BxgXcOGo4oLedbeKqRhzlIcu9tLhK3o/9QdNhtwW0dqeU5fZEwd1vvMFIfCgtB5AYEvSVuoXsYW35/sc5Hh9jip+aFa3yu0dRVu8xqOSB1GjL3RF5y96lWbM0dT8g2yMSbkxddh2OhrBU8oRlnZ0ynuFEZL29vE3lOPYxO6bdFSeONg4huGlRp9xNe+K2GwqHShpvM2Bbkv4FOSy6WUFZA0FKMtDfJHR3QfMplFT0bpyGJ6Rt+IipIasWx9+/n2b1rDgcZ6NCPqyPnySTo+wunvf6iMvVu3cXblBrVZJeACUKQlMbxbKeS2GlY19sNTlSnaojOEgUi+Q0k92zOnR0gNewqE7YHWfQqM1M3ADEWS9V/VScA0LlmM2b7h4fmyokvVzV9eVR48uEhEiZim53lr1BsH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(55016003)(86362001)(38070700009)(33656002)(26005)(122000001)(82960400001)(7696005)(478600001)(8676002)(52536014)(71200400001)(6506007)(4326008)(66556008)(41300700001)(8936002)(9686003)(38100700002)(66476007)(64756008)(110136005)(316002)(66946007)(54906003)(76116006)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZWFXqu5TxIqsJ5ILpRQy2QgFCc5z06UFEAaksD5E9LRs0BSjruO3hz1063jF?=
 =?us-ascii?Q?5ytpKXU8KttaSFza3jwZcxmn1FJkga68wUoRne+VvuQnuYBgit2TM7DO9LGl?=
 =?us-ascii?Q?JBRJBZhKqq/5B9h7MWeu2LkTxnak9R44LOU1bSqz8+8VFzCpgHsYp8nN5678?=
 =?us-ascii?Q?LBxV25/d2M0XMbU7rker6sXu5YphU5rggSpFxLIx5snHgjmm3MjQooc9fiBy?=
 =?us-ascii?Q?Po44infeGsj6R5U7X1X3JgmRs0mLpd619dOCM82q2CYDXCYnX8IpSVUDu2Ay?=
 =?us-ascii?Q?y1/3u2wHw7PPERpTaZIc+Y6GOVYavffmoGCg8rcu3yzOGdcXA+1b6ZlzO1Fw?=
 =?us-ascii?Q?9SmzRhFu8iBxk40N4UblRmaAclZLOSjHtLOJxHoh0TdCHsFw/ILgrXyDjBTS?=
 =?us-ascii?Q?0+uOmXB5Foy7qXQO66UHnYZduJoqP1VgkTB079rndm6jRjT3mHIAo3odSBOH?=
 =?us-ascii?Q?HUd6RLcRzptd/Nts54Ir/pcrJoIvUuU7whyOkRPD25ZuRhEwmHatbwOjvnJe?=
 =?us-ascii?Q?EUYbAMzNtCipY5OEg7eQpgR72NA8TqZS06kGp4mlO7kgey6ztvKO9OQmd5jX?=
 =?us-ascii?Q?o7DQDCZ6/ZWfA6a2kUmTTYbg2nGP72GY+Ueco+VXO5dbUsmY37fKh1RJRe9u?=
 =?us-ascii?Q?2SC8bD07MV7WequClu59tNKfRRY2zyPn6eTE4imIf+0Uynj17n4grClrabBt?=
 =?us-ascii?Q?GY1Impy70JriXGIDaDSQyvi1/+hAaJ6/+C6SErbJ9kSlzHfpvoRxA8qUefBX?=
 =?us-ascii?Q?5eA33P+qHXZH9D+AvTXurggg/kH17pEpltcpnuX5EkeGrwyiy0BYTBYTDxDq?=
 =?us-ascii?Q?h56NoAodZ+6OVq3CSKHn92fqUQfqRIwbEov9cB9qepeMKrD38csPnI9WSlFE?=
 =?us-ascii?Q?E4dp8GGFJE0sBHoanD6OOccwIDRZMcZVJYXwOPsChT8gwBESI5mqfzShRuAb?=
 =?us-ascii?Q?vQQiDeWvq2J2NYDV+QITXRV5DpgaoNt3Bp98CyKLRARu2S5/RR/6ZbpjqImM?=
 =?us-ascii?Q?mrXhcmKSaRlATZp8QKexns9dDm6iiH2Z4kpNYC0zQmhmLtPu2+r4Oj7xFkDl?=
 =?us-ascii?Q?81bL4RVuyqp3E/ak4kE6aysD5HQKSyqh+L3RfZJxi9VNDUZeX1d5sOpc6ULp?=
 =?us-ascii?Q?IH5nFRj1MjPkb86CJAsaajtxhpSJKHCLA/RYFR8PuE55j/IZ1X5Ofq1zAVSq?=
 =?us-ascii?Q?D5OxZSESMlxBAtx/OlRVNDk5qp0E6WaF1Q8S5dE7lkuCKPLzhmPVOEj03gBw?=
 =?us-ascii?Q?0L8yjzCj7Ugc+/zIkQGHDxVxXYCwdIkNIi2RHkuFBtZtEmhd7HCfvRE/qFOC?=
 =?us-ascii?Q?GvRqPZZn59KqT5IZe80yoYoYf2k5VplYv0P5RS9RfaRs8YZ37AcPyjmdPcof?=
 =?us-ascii?Q?f21Fm/YNswWZ7xt0fPjI5H41Yv2RzyaZHVoh1qVjtyrt5nB/8LxvqKCoC/D/?=
 =?us-ascii?Q?AzlauUrHlckiy88+aoW9WiU2YLe10Hnk0vQL+dpv//+2CBotFgRMCVyzgcDn?=
 =?us-ascii?Q?P4zDbZvW9DgAVXKnhWB+0nc0UYIL0J+E+xjUfHex18cekmp4fda5iUgJhtP8?=
 =?us-ascii?Q?dLsWU2XE781F8yBgSXdtUPPEYRdfMJpRexShOBt0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa687a96-f66a-4e98-b820-08dbe4c0172c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:16:27.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+46dUZ0K8BPs+1AcSEBBJDIYIn00Wk1B1tcaiZ5FThCDy+8la7vXIB1jDWRL0hWenp6pdCre+0CBa+tbXAnGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, November 14, 2023 9:11 AM
>=20
> The enforce_cache_coherency callback ensures DMA cache coherency for
> devices attached to the domain.
>=20
> Intel IOMMU supports enforced DMA cache coherency when the Snoop
> Control bit in the IOMMU's extended capability register is set.
> Supporting it differs between legacy and scalable modes.
>=20
> In legacy mode, it's supported page-level by setting the SNP field
> in second-stage page-table entries. In scalable mode, it's supported
> in PASID-table granularity by setting the PGSNP field in PASID-table
> entries.
>=20
> In legacy mode, mappings before attaching to a device have SNP
> fields cleared, while mappings after the callback have them set.
> This means partial DMAs are cache coherent while others are not.
>=20
> One possible fix is replaying mappings and flipping SNP bits when
> attaching a domain to a device. But this seems to be over-engineered,
> given that all real use cases just attach an empty domain to a device.
>=20
> To meet practical needs while reducing mode differences, only support
> enforce_cache_coherency on a domain without mappings if SNP field is
> used.
>=20
> Fixes: fc0051cb9590 ("iommu/vt-d: Check domain force_snooping against
> attached devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
