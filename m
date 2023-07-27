Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54476462A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjG0FtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjG0FtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:49:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC73A80
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690436911; x=1721972911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzwMc9YOoxT9rQQwbnYWtNC5qzZcPTWpw1ayYuizKF4=;
  b=n89sOIrCNmkhM4D308wHmSFhWEjDskRdYH+BbWCCmo3Qet2/YobfwRkk
   Jsi05S86+6FjyZkbqg8gU15NEUADPxJUWoosScva50wBcRpMojDZdpJFf
   WKZfrw+xlsdIw34E30r073kBBv4XMBtiHbeDhHjUdMVgFG4D1t2/s2XNB
   +MMQAk0WHsGSGz2D7iC30Y8tLgx86XLpWBnvnwopUdKPV74MDdrrPs+gL
   I+Qiysj3v8C+YSTiqDV5n/SeBLc9DubfpYpbEqd59wZk/PWLt2UikHxb/
   66foJHV3sH77ObU7jXC5ScH77NdQlmED91JxkYUcG2r5DvSeNUaI1LSUS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="353113409"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="353113409"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="730133859"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="730133859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2023 22:48:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:48:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehwOmjUbhOhEN2ebA3dPzGsX+v5gG2+lC8rQrbKLtNFNzPA4bBjASY+Rr2z9QwLxuyq/jeXYInPe/Simz8C0QPWATAKraampMcAtWBIIFVJeDcLuD9Rhaq+JgRz/tlTErUTkJehHedTHV2M9VnnzMElhuEE9ZCjKeaSo0t8zoKA0SCTGR0zGP4J0bNCxawRfiPtPU3O/fJmgz6bkwc6HT9By2ZqFvUx5RztxuHcEAagyUxmM9LJ4YYPm3UZ/pLTlwZsSp9yzrph/dDzIp2bMr7PtlwChO3GUq+XvK+sNorG2N6D/sQXrkuGphqwgym+4s4yfjbjzIrTik6Lx6EHjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzwMc9YOoxT9rQQwbnYWtNC5qzZcPTWpw1ayYuizKF4=;
 b=fbCjqTTOJxkvYJKz7OGzKOqowgyxVLdqepFwRbNV6XTAHb2r6kHd3wJ9QSyG24XbQowjtg1uL2mEMDKNzOgie6VsC0/JlFyKiOyWtL59F/uYH5WpbuqV8EdA0sAP1wWuNWrFEPhHY+aFua3dBA/hr/aj0ws6Dg1dOsaW+Q9uNpiBW/bYx0AqNuQmeHlXhP7GuTuHwJgLWKNmc2xNLkVHVpemhttqhC9Ljen853qLJ38QYVC/Fx6gg4lN+Mn/iRA5+sh/vtDVX6/GRorQJp0sTbaHseZBpj1GwhzXN35K0QGT/F9r1VL0Y2+AmsHdBs5tXqc4qzTd45Nfq94UkfuHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:48:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:48:10 +0000
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
Subject: RE: [PATCH v11 5/8] iommu/vt-d: Make prq draining code generic
Thread-Topic: [PATCH v11 5/8] iommu/vt-d: Make prq draining code generic
Thread-Index: AQHZvn0gzk8w0vbUmUSUbGnE2DZywq/NHrkw
Date:   Thu, 27 Jul 2023 05:48:09 +0000
Message-ID: <BN9PR11MB52764491E27DE4E8AB2F32CD8C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
 <20230724222538.3902553-6-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230724222538.3902553-6-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7056:EE_
x-ms-office365-filtering-correlation-id: 18d8b3ef-a2b8-45dc-cc0a-08db8e650f1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2piNsj9Xb335muclKL9VWxwWWc/sHSfFLtpMJ6/lx4dAXjth0bL9scrK1iXt363QIUpDzJD3xm1vF5AVfwVRul8s2egYzcmTiWgsD9EwKJOuHAIRgkMaBi1hMgr0FrINPb+oh9Du9hFM/cUJXG/GUXGS2cFPkw4uVfQba8jXks6kiTMEP/QJrQmo80JmpDdYKOKjJB/xvyO4OT15c3LiGoWDuU8fTrQrXJCZyZOLL67rFuYTvomzuij4j+g3Io8If4I57qwMndS+R9+EQmmgYZCUJh5H5saB13flZjFcrTZI37Q4bD+tcqeLq4V4wRfxiabzOQjP/raAxoOUIkZTThXAoWRJ0iF3PXsGKJw+4O56HEQLz0PPg0FknzLPSlFS8KItuJ9/2RkANu7DM25JL7Qpv1WPoK+g7DMBatD6xJgchRQJGZ3o/Rr4Z8BWGYlDYgEpQeXJanw9qS2KQ4dyNa/I1uONbSiM7C8p4t8VgTMBE5m1sFi7o6NY0agbPzOLyAMPT0Levh6jqmAQdlsGzo4An7WOcZhc8bc+HrGquoD4FiSi/DkW79UnFpPiKkD+OARL2RY3dale+xUeKGbKIDDEL7kbpFe3iuLScc442kJ2YW3GdYHCwVbyTm14B1iZEJvuZHtaKc2gxwGSRRIXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(38070700005)(2906002)(83380400001)(7696005)(71200400001)(4744005)(38100700002)(186003)(52536014)(5660300002)(86362001)(55016003)(33656002)(316002)(26005)(6506007)(8936002)(8676002)(41300700001)(4326008)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(9686003)(478600001)(82960400001)(54906003)(110136005)(122000001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9YOKPbSXZ2GuSl6wCwDAK/8P6yy1dlc9t7Y3Dkw4ZJ+5yDvJF9sunx4dqjss?=
 =?us-ascii?Q?SGgh0+QfcG473h8KohU6vjkc2JfuZ2btqfwL6wuXbIycBMp5712Yy2vHDm8g?=
 =?us-ascii?Q?1JRQO06NJKZn+skhKv2vJi50Hgrpd2UfVA581aUyc2Mx7atmudgCCJ6pOlc3?=
 =?us-ascii?Q?9Sdio9SYWM8AItgU5G6UnEaFiKb8N+7FtdE8SBUoc6N6s1XEnz2dEnN3pbzt?=
 =?us-ascii?Q?eh4Q0hOrz7QT9fG0EcoDQe3WXZOpJBXPPtJipBrl7+8N9BP81zWDa7HuQ7mB?=
 =?us-ascii?Q?y3GLULQZptkOAc2PdN9CLYP+u3pVQ0r3T3fZK3TeLARxBEHBz+Qp+XAko6Fg?=
 =?us-ascii?Q?mc/qrGh4z/JKjXpdBQFV9rl6F5d+ABGi+lKeIcklaNCZ53P10D9ZqmacmiqW?=
 =?us-ascii?Q?6tRZa3UwfUPItU1pZ6MEyW5JPMX/OjbXl2mJG3xUhJ+kPY8e/GX6Zlxi0QzR?=
 =?us-ascii?Q?JBINDVQ+S822nrv+MTSHzQJbSdQjtHOv7OniazVraHhn2P4jLGKfIAGu4q7K?=
 =?us-ascii?Q?GpOY7mIHne3YcWxOXW9mNCegcEscXt5shmV8UWJ5RdG9qfagNPRlsWZwUiyb?=
 =?us-ascii?Q?0iJ33lDVkNuzIvrwcg5M0OTr/le8Q8mVkGu5Itn1+++IIT06TLfnkNTYv6av?=
 =?us-ascii?Q?QxcoiSXFnCyRp09TekCc97MkNHRGyZV/a0ddIknwdy5U2m7bJrrSZbncuU0L?=
 =?us-ascii?Q?TlsX47YsrwwSNJHIPgdRfhdcE7E7DIQY/TMWq+YS64FStIQ6pQIRsjBvYnWc?=
 =?us-ascii?Q?h5AfMnwKedkLEJHmEYySX80KC3NGL5dUdehnCXoh5hcT9YWrw0B7EAR3l5il?=
 =?us-ascii?Q?XvVx+Qo88Nzd/mPtSHyYa7yw3VWnlHD8tgvtJSXSXaEEuhccEDqJZABBGqKF?=
 =?us-ascii?Q?z+dtF1ZHfkvDXh6dT/3/elbpuNu7JIPrA1Qltrmd1z2vricmztDHvyB6fLBm?=
 =?us-ascii?Q?BWFxM9EZG+CNRol/XVIYf8eJsA9KM6sLU6uV9hup5/rWT3F6doKrKRggjz1i?=
 =?us-ascii?Q?E9F7TF636wLTtgKzdmReBl3RgvkBsCUsd0B1I7ikuOnPtK12101DGSSxAi/j?=
 =?us-ascii?Q?dcgjSrFoaSjz58FHdOkD3ca0SjpwP0XTBupw25/03oR7xYRfsw3YsNHeYAeV?=
 =?us-ascii?Q?IrBfjwvEqDpNFn7h/8O0m1CcfQyYxs9LrWf3IWc0MrpUkCUeO33woHDNJult?=
 =?us-ascii?Q?T+otkjh59p9jtfYHrdWf3mDmC3118zDEfatdSv6ripvDOZmwb7K5/A6Ky/Wt?=
 =?us-ascii?Q?Pp4YBDofKWgg4AaSR1vfgJ929zh6WNbrRi+lZ5e5UmP6IxNDgLfsAcX9f13V?=
 =?us-ascii?Q?WI21GXp+CVRToR8gLyCMqQPFV9Zgx6pcEay9JubONDRZ8ro5/czvNNMkUTOQ?=
 =?us-ascii?Q?Y4tlvWCjL2hzgjSvcOU9crg9U4i1GBqpNO4LBhpsRuHQGL2cjvf+B5/hl8HG?=
 =?us-ascii?Q?zaR0oMlt7j2IHM7smlh3Nw3h6JrdvtvMWxYNafjXn5TZ6sNcSqrUhwrrOZFZ?=
 =?us-ascii?Q?RB/J1WUqgTLexNPXCn2nffyhVwmXmqDH6DrX3rFHPmj4DEWNT7QXRisFzN4i?=
 =?us-ascii?Q?EuxX2ZOu9r3pIhjNBrXqyV/IzTQtOPAWLBsP1T6X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d8b3ef-a2b8-45dc-cc0a-08db8e650f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:48:09.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb7uZGD5d94pzb/hNTVU44G1C1Ssoi4i7xyeg4xzT8xRkqB/TAqlAcbh/es7ctdYDOeJI1AwyF+khXxO85IZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, July 25, 2023 6:26 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Currently draining page requests and responses for a pasid is part of SVA
> implementation. This is because the driver only supports attaching an SVA
> domain to a device pasid. As we are about to support attaching other type=
s
> of domains to a device pasid, the prq draining code becomes generic.
>=20
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
