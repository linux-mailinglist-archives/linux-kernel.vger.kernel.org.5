Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4703E7ED9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjKPDTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbjKPDTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:19:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07419F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700104775; x=1731640775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PGoegZTOoep9vjVGrKuAB7KHnnOgVOvsM3/9I78Rr8c=;
  b=lyMEWfCvOXuJ2xAUEqH3tuEhpYHuq/QFkEX7QVFdx3vaBrzYWXx6IG19
   NjCDL/4HV+dg+hcaDcb1fPz/ocK+Zezf4d6nfegP+FU3k9QcZ6+srdDha
   hucjiGfEyu9tubfn9whrvX6EzPM4un0rlD3OpGBK9UmcWODtgloUcJCgp
   bRW7QZO1GOIgY/4eGMgD1zKNn0R6IOfd85G9thkxHF+tz1rwJmL2vTfH1
   JUM1XglgToXrYWS8dT7u+CNLFLHeQi1zWXinUJmpZha+nu+opewvAiAr+
   o9p3yJcGYh0QIkl5AZMegOlKMQxsj/yT6Yf8qXInvu4JXQTEhOY7Zrhgb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9647116"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="9647116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831125285"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="831125285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:19:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:19:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:19:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:19:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvIKK+MiDIIF7PmI9CbYH2SJdnwSrkIqvnIt9SIo6nDvp14RQKwoSHNozP8DTuetQAdYArVTjHX4Vq6XQWEqxsmtgxKulZ8XYnte1laLX2bO37iHoIr6LBQa5Ww0F+rolFqAFJMOPMFS6WiCI2Fu5gShb7Eg/Bgzi3TzUWprL/vNnL1TkV7D6xDCwethZzwMLPLFdBheHPRNJZ9r28Bo/mxJrOAvmTEcHvzyg3iKzV6l62tKqlEYrhRz2tsqG5pigleQ+6UfbPAlrcVnb4fhb0GzmzhmuaJ75BERsmN9b5KC88BTApFxuJNLtNSb5mjPa4/Qm8ePqwpXufNAcCE0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGoegZTOoep9vjVGrKuAB7KHnnOgVOvsM3/9I78Rr8c=;
 b=djEjaubGs8GezpNyEGFb/2UrFmzNHIhtFGPMNSbEOIuxl9kGck2Yz4VLHXKsSVVKkK4/aq8OfzX1muSP9RVXpumKnlYEIQBoeOwMFRXxd2sRXxOTy8IdbmUZ8qsRV78LWFGuB3PHc+DwEg4w0z1GElZv99yViKTsz9n2BRPFfOebHI+ri5KBprqnWQRoY6eFJHm2G8vl0fzOngP4gLTaXxX7NadaSWDm6yR4QjAsiu76KGm+TAu+4DlcOpjAWoYxCOraaQe14GEsNI44mHuf9jGzLM78zzFZwAYk0lYZM+nViI/C/FUH8Xmqqv8a8efwqTMjKin7it/1Sk2642ENaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Thu, 16 Nov
 2023 03:19:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:19:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] iommu/vt-d: Remove unused parameter of
 intel_pasid_setup_pass_through()
Thread-Topic: [PATCH 2/4] iommu/vt-d: Remove unused parameter of
 intel_pasid_setup_pass_through()
Thread-Index: AQHaGC/0705WLq6wQ0eQtJljBJt5qbB8RvtQ
Date:   Thu, 16 Nov 2023 03:19:31 +0000
Message-ID: <BN9PR11MB5276B4CD9D095D9EA01380C48CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-3-baolu.lu@linux.intel.com>
In-Reply-To: <20231116015048.29675-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: eb5bfb14-a61e-4654-8b5f-08dbe652d9c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzo4f9q/5F5rfX+VqX33ZkSgRwHxSeECHBM+02zPwB1Vu0EKpi3B7YTBDApNGV2ngjlEYem7Ic2xPXBiWeig0vNA2d4GnbXAoxa0QxKXPHut4XyPEHQZsGKdgOApmfRybD8EF1NmPOZ5/wuo5/RhDRNvjv1UI64wHMVADxzosSU5hUKfbHuHktcORdYiHg8JTTnK9+jx73Zs2Tud6f/+jBY6u34mj58RjHQoYV2RxGavxxowHaQxuUC36iou/+YpUyuLkgfPEON1PL8PdPr0DF7Of+AhiwYg4AzyJIB/WiR8bWVBtoBpcNwFgD57zb1zpUhVTHfaXCwzuj1Z1va9K1dYYxDvTjQx17PeC1vnGzTGtdpOpjF8daZ57z5FfxeXjRxOkL1W9UIuXPr43FdJNPF5nBDnQOkjes4TvyShZI6FWdZG7F6WJ9SwFBIqfKNk4NPmVBxuPteXA0wcuL4WNcG+QH1lZC83Ud21O77LoMCUIxWoO2gWsoBhuSuqSrXvc+MMmDar8Znu4KiAcR53ag9L6kkBqhLvq3M/PFmZidPHr91uFvN5S9qIF0pzVviGThc2b4QE+XwGr4DGScatIeMb4uhH0B3Mwo518asV9VrsL+NARctN2APn33kzJzlc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(122000001)(5660300002)(26005)(9686003)(55016003)(76116006)(38100700002)(7696005)(6506007)(2906002)(86362001)(82960400001)(33656002)(110136005)(558084003)(71200400001)(66476007)(66556008)(8676002)(66946007)(316002)(66446008)(4326008)(64756008)(54906003)(478600001)(83380400001)(52536014)(8936002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2pDGVOQwufkbP14mKtlbL4X4PEpUIawXnx0eu2OJ4BXjXJXzLCBItY4hRsAR?=
 =?us-ascii?Q?jcCCcGPwunBYOEiJLSLPnu/D7Vto/zS34p6yxQc/IQA5baLJdHA23itFecE+?=
 =?us-ascii?Q?6NcDRq9pnUAwnt6IM8wiqMk62sydMry/WB0F6qdL2YyyebxJOBdkeoPUjXi8?=
 =?us-ascii?Q?+GnYezhOgUi+HoGObI99FoVfwYgpWNWq7Pb2NasfycgKFf7Uxf7h06coWw3K?=
 =?us-ascii?Q?5W/jRu2KVea1AgsulnpDDmbki5zoxFKHs+tI8E1qTHt/yfEI+eplc3ZzLXJ9?=
 =?us-ascii?Q?389uqYFLyMv2RtudksRPlqmLc/5FdfPHxtn3/qQsBVgzXRoB3vs2q8Eh/Tz6?=
 =?us-ascii?Q?/6Vvzjs8hOe21tTadSScpk8U1PFhESgY84FZCmFZ5xBMCzK/vVw+xOg+xwxI?=
 =?us-ascii?Q?JVwhWR95m7iw55ZnBiIjKywG0CnNka1LK+pvtIlU8qD6BETCB+Uf1up7smD6?=
 =?us-ascii?Q?pyaLdvIXpc6sITuRkeKWkFksi/5mQPBjae1AA9xt0JUmInT7ftFhBreKAmcP?=
 =?us-ascii?Q?nVnzCrW97rayERZYXPO2VB0YkkRP2NMsL5+M06Jy6y+zV6U+3cQzLdZNX4+p?=
 =?us-ascii?Q?8tLBddE5iyLxD2aeW2819YUe8YzOo+KlBdXh2MYVVqP/IaCmsYY21CPyxLPn?=
 =?us-ascii?Q?IlLSq8lcX+I1XpWZTrBL05RpBAXB33iOG7v7HhFCWf1zU8x0vR9/GQTg9adV?=
 =?us-ascii?Q?VgUk5S+O/EY981mvsxwW6kE8tJLDMsBCQQoiX4wzGmKwlZrq5dbxQpGPzHBW?=
 =?us-ascii?Q?gdXrvBV7Hf3E7k0Bl3FDZ75hkbsCtjgent2HqMlDthzSFxansy17eiZr2RGE?=
 =?us-ascii?Q?kAF31roLyWhF+oPkyp8dqdUwLKMTD69bJ6oExaDLtwanEN+uZWuQAgM2VOKK?=
 =?us-ascii?Q?2eJ1wxguJFpt9S2rGpjMBiAX7gFAKuSZbqwVkKMhP5UGg5SzuUwPsyoPe58D?=
 =?us-ascii?Q?WrcfvZfwrMryT1SIpvOumLrmk6luiZnWyvt8bg30umSgcHQBQTW06GyX+iy5?=
 =?us-ascii?Q?fIAOh+NLfpV8kKfW2AIY4gduKdc5jQ4XHVZ0dFYQUNraTwVsiUQpBytJmVu+?=
 =?us-ascii?Q?q+JNnNMjwAOPNVU6eXiw0j91NJXSuc31WXd2C6Uf6SrO72ltm3uTpBQyLETW?=
 =?us-ascii?Q?3kRY3Uk8nT8SGYbUlTAo6OLJgjQOAna7FvxPjXJ4VK8lMlIKbkNgdF+w+3La?=
 =?us-ascii?Q?OPXQQWE9fh8mV/WXM7JrzZ/EJFgL+4Mruq9b3g5ex4ybqhOoj5NZSIeZh/eR?=
 =?us-ascii?Q?i8mhyi4Rfjcuad/5yeOCeXc9A5WeNcq8SQNqpqMtqs8Eq5f1Kq8d5wmuVJVT?=
 =?us-ascii?Q?KS4UBIgMsrFWRg+OjQUbghzupzeE00ncSOtub2SPaojZVkRbYNpyi7BYGXwi?=
 =?us-ascii?Q?tlSbeu4orZiFWkZryFPhr9M0XxcUiuViQEWktmgJmcjfAfys4CDhvz9uiLMl?=
 =?us-ascii?Q?a+cWoRvAGVYrNJm0OkD2BsuVOCpZrE+6ihUHtxEKQnITvp4xg8hwHzp8HGdy?=
 =?us-ascii?Q?z2SBNOfuR+ZJqYW4KmO6QRkiYCEkosy6NWR1LZsFs36tnbUOU1PubNel0RjG?=
 =?us-ascii?Q?fKZtkuraNdPrUqHRfNTYmNOGRm16HF1dZq6sJR7b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5bfb14-a61e-4654-8b5f-08dbe652d9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:19:31.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89c5bjOxGQ29hHuBdzbUiUINcBuQu6+pJ7Abad1xPYcI1am/SsCK3a1/u6mzcwnTfKsT/cGzSMdaxzgGgJOSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 16, 2023 9:51 AM
>=20
> The domain parameter of this helper is unused and can be deleted to avoid
> dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
