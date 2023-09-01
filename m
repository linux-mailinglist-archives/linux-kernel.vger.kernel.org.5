Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD378F774
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbjIAD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjIAD3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:29:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE6A132
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693538957; x=1725074957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oQzo1KpxGnv2JvgoXlSTkNqhxk1+CXkMOEyswvs6BCM=;
  b=lDRcaZM7D9cbqEuK8GiIZ7YaYXqo8Im4tHarUDPZUIwAJIcsTQzjfYoO
   fVLqoc+H9eFOPnTlyolEQ972IXfrOeAAIH1YFngkCVuJpxqzmZyTTS1au
   zAF30AREHK/uIdK33rU3pSnSkmrrXpYuiYZ0NkDAxoMblNT8va0O8nKJI
   SzUKF5xIctAr6kX0zL4vrmIiDMF9hWKIt9YBTkLtiYrA6Ym1lhoAsaLQk
   WPOLqYz4ZJ3tCcMCvcxna/7oSxbEQ60uBntD5S9yUkAD8yavQExQibZkI
   lkMzXx2nKpgZuXruSY+XpkvlYY41Usn251AdX1PiflQIiM+fT6BYB3WDJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366354728"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="366354728"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854536526"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854536526"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 20:29:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 20:29:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 20:29:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 20:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEAeKjEfDiRElGyAWjpDqU50LhTF0FKK35PKEyJymWzOjfYBb6HYawc3+MDFAMtf+hLR1iMKGp/C9qcAfDfagApYPeWRb6EG0YSolLE5Ht2hMxi4PZsegKbH9uss9kHEN4us2ViVlLlywmAhzogFyW/MkVpCfEdXk/D4biDNLiafQjRrSxvEYEXnQuRgf7y3nxkMy/cw93RwRxDAbNe4qN1+28up0RGJatrtXyIUfnIYqF1ZU1yryDvFdW7b/98u0QNbJYTpz1SkhTKx3lTcRdiyW+q5/7OTQOgKImSPwYFPGvWE1CaCtK9UwNeDOrEGxWkvfk9xhKFQV+PxVi59QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYcAaJMEovENss8Th64Ppfjm55SS6ntz/8+zu+5vD1g=;
 b=TsArwjLvJEDkAolqHEgul8wz+1DmEZ2miQt9MU68FAzU0+qwcn2o8AJN9lhpq/VibpE0mZk5UrEsl7WH9VxXMxP3yaXvECNM363NEM3FMz5xPZWU6TAROauyTM7Hnbi1al1q78dPmvnvZ85nqvIwQaxA5LIDi1RCKEfdUQ/bATcmxfPAAfC+B7O5f7AhKu1HLU+O1KK8bytMLe64pQ8BRoTfyASYg6z74i84FXbtNLYz4Zuilb6UOgZdu4pHXujUsFASGQ8rEV569zoext14YzRwOrUYtc81dinkobNc521YAjVGdan0rh4zObGaQ8a5GK1titGIKFy3JTHwQOa+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 03:29:11 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6699.035; Fri, 1 Sep 2023
 03:29:11 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Thread-Topic: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Thread-Index: AQHZ2MKxkbkQFUVn30uienqBT7EfM7AD4ngAgADF/gCAAK6IsA==
Date:   Fri, 1 Sep 2023 03:29:10 +0000
Message-ID: <MW5PR11MB5881784C1598B32CE8A0D7E489E4A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
 <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>
 <ZPDHwseKQ3IC8dT9@ziepe.ca>
In-Reply-To: <ZPDHwseKQ3IC8dT9@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DM4PR11MB8091:EE_
x-ms-office365-filtering-correlation-id: de6d4f76-420a-4868-88e5-08dbaa9b9b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EW50BMLCH3oTwTbVvyGz/uURNAR9KYv5Xox/5Hl7SdkQ8r9apnj/NWj+jYMaewnN9lQFkOS82ZvpWNNVzrCbjRS/bq75a0+e8zo9e2ZL5ALfQAUD3x/2SBFyCM7Rx+Pd6mmtS5v0vV6tfHTd3a3oWQsemf01t4uvGyig6xGhT306RZCFIPxAidyJCI0ZR7P9qFwnDLBPfNq/QrWzneJTWdjDC0Jodkz6LnfLm9i+2KNFoXgTJ8/JgOpsaHhLv/dPcdj/IYE0hh7bbA8Y1Pw+yhJOb70jTfGBJ+PclK6pwx0QTjDRuOBJCFJ9ErJypbs2BDPJ+qBQ6ZhqnNjCzLnb8Hyw7OVuGyjliUn5NFoSgEboNSEw/JtokYHARGvcP9CguHZTc8HKAxsJoQ4J3hyVEAYVfyhVXo7/1kNt6OenoXdIb5ZDIJgzWyoMZy9hJwyk7mCxR1yYleSaXKAE1P64uiV1z4gWPbG+ammjIeBVoHVA9ILbft+ncH/PRZ4A4JWnAV4LszKDwSbNgrrjQUTZpakLF0wIYExwPkrNuoFu0LqEI2kgovuGNRonLMpMRoSLg/+H5bBYZu5ewE6+DN4NwsmwNaPrvyGdq392yrknUxacuI6yrsOlMKHRLvjvzBQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(122000001)(76116006)(66946007)(53546011)(110136005)(7696005)(64756008)(71200400001)(6506007)(66556008)(66476007)(54906003)(66446008)(478600001)(38100700002)(38070700005)(316002)(41300700001)(82960400001)(9686003)(86362001)(8676002)(26005)(83380400001)(52536014)(55016003)(2906002)(5660300002)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddYNsBuuglbt1JsrcdOU15IOWEuH2Fe70TjtYrkl4tssYfaISMI4cljA+E/h?=
 =?us-ascii?Q?SQzTSd5cCWpN40Q1RMLLIhP6Et9zYeooMjA9X4O/yKtdtjO2JxaP8M84gAS9?=
 =?us-ascii?Q?ZA+Si4rdFVorY3uLjhIo2FpaHRTATVRl1XwnRulXJBNreKRklqKeJ9J+Lu/j?=
 =?us-ascii?Q?OKDWo2fOJtAkNW+7muiWems0JlMqRz0b0U+T3arZPNO0dKKu3i10Jc8RRwHW?=
 =?us-ascii?Q?XE8rRjOBoi0+FHxPsY76OTKFwJbYHwW92MMd0Dmz2ri0ZPRXLuGjfdISw0pT?=
 =?us-ascii?Q?61N4pJpvUQZMRhzN1tUh1KH1dRK2vi0IHw1mSYZ9YNTGpCaqWr2APH78qKIC?=
 =?us-ascii?Q?CZBuw5cShO6pqCaJtfr+3ijFmXojmv+CYvQW4pQVxLhtol7IHSxmh01yCJk1?=
 =?us-ascii?Q?L9O2Be+8FDOmN6rE+iNRmDfwXea8u0+HMHWMJCHM9K8xruPqgna+t2OH4ncQ?=
 =?us-ascii?Q?OzyPHZjuTNoZg5VHwh4UtN/ZNNpFTta55Tl0VQsN7WIIrpmt6dBibANiCw7A?=
 =?us-ascii?Q?AtIdSgFjWVtt2PjZWMAqOQFoO8RDr8F6KeHQ1xnZhcen7WPyfQIEMajEpXd0?=
 =?us-ascii?Q?SypQMoPbY6Ht4ITSESjg8x7DLFAQU/zeqcKtasF13/aPd13q9p/Ymb8zzQmF?=
 =?us-ascii?Q?AZ5g7nm+D0xZDdgwNiK3hWJMxdNCEN6LTxj+3k/ax885hoO0VxQbGDlvbcGI?=
 =?us-ascii?Q?+CZ0SkmBGjixmb2v42mw/xvM3G2HirV4wYfI6qaONW3Tqlb/tVS2lGbWPSdf?=
 =?us-ascii?Q?qrRTPajf4+lH/M7yiwqflBGVtrdntDq4NiZW6PsmSen9ltEKxF9fQK4C1iDL?=
 =?us-ascii?Q?6NE9vnoL4w1z8/BFmfrOTEJnxLSzhIpylgyk+ogESirmxa1TwkeikDsK5MBN?=
 =?us-ascii?Q?BFl0CgHJ5M/JbvNOLNicOw9RXkARldd7kz8CDsxhjdNaWLMg1wqeS2nbXzdD?=
 =?us-ascii?Q?ntIBsL/sMVHQUGE3GyBL3zrmSRtV5StlHcgPrFw1LqRcEJSxCDsWirVVh+q9?=
 =?us-ascii?Q?1hBZ+EPemf1wl7tFRH1K7J2LnFdcqqb1Pu0BC9TJwTbb9JBu4vKewGQ1JV9q?=
 =?us-ascii?Q?60lZ2yySrrG2a5k34/uaqltRTsL1tZoAG+Q4wbKKY7HOpZIrVI38z6Gsx4xQ?=
 =?us-ascii?Q?2SKRDRYM1Y6lkNlXoh9lnEHxfqSUpbSA1JQ2mtfoiHgIEwC8es88Ew6EQI6y?=
 =?us-ascii?Q?0l/0/Yc+SP/II9Ydb/xBb+b10Wp423x4baESr3BBqT36ny6uFzaaPwmg64SQ?=
 =?us-ascii?Q?RnfyL4jD+ZXWH26x1vUGHyKLBToTVOf2jmAVR608lKF3lmtrLpY1mngQ1MFB?=
 =?us-ascii?Q?GT+hZhkUwnrgiI/j6r97xLniqZ1oVCMEyirIhZlwAXqTdUz6fGHVY1xQluYn?=
 =?us-ascii?Q?hRVdA4p7B7u1bBsEQb5IVdkzpYXER6b0TnTg+MvzYt56VpPOVkccXJ5p+JL7?=
 =?us-ascii?Q?7Peg5vZyXr7t+ftBlU0kPWkmxy+QamUmxdu632fS8yG3AZsj7ZJFnAmhAKHo?=
 =?us-ascii?Q?m/3sn54YB1khK2xrsqXJLCuHiU9xSHG63IYFXhdRREsIXCoLvC9UONxvLkju?=
 =?us-ascii?Q?o7/9O4kPQ7XHAFe2d/INLX8m7PgGuO0sJ+OvIn6c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6d4f76-420a-4868-88e5-08dbaa9b9b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 03:29:10.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8YIKkEia52xgK8OEhXoZWGsc9kImhPiMS3N77gHO99/oAtMnFYUnt8Ts7fLWs6pNgT7mWFMeeMm2kEUj1mfqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu and Jason,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, September 1, 2023 1:03 AM
> To: Baolu Lu <baolu.lu@linux.intel.com>
> Cc: Zhang, Tina <tina.zhang@intel.com>; Tian, Kevin <kevin.tian@intel.com=
>;
> Michael Shavit <mshavit@google.com>; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper functi=
on
>=20
> On Thu, Aug 31, 2023 at 01:14:20PM +0800, Baolu Lu wrote:
> > On 2023/8/27 16:43, Tina Zhang wrote:
> > > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > > index e95b339e9cdc0..e6377cff6a935 100644
> > > --- a/drivers/iommu/intel/svm.c
> > > +++ b/drivers/iommu/intel/svm.c
> > > @@ -306,13 +306,13 @@ static int intel_svm_bind_mm(struct intel_iommu
> *iommu, struct device *dev,
> > >   	unsigned long sflags;
> > >   	int ret =3D 0;
> > > -	svm =3D pasid_private_find(mm->pasid);
> > > +	svm =3D pasid_private_find(mm_get_pasid(mm));
> > >   	if (!svm) {
> > >   		svm =3D kzalloc(sizeof(*svm), GFP_KERNEL);
> > >   		if (!svm)
> > >   			return -ENOMEM;
> > > -		svm->pasid =3D mm->pasid;
> > > +		svm->pasid =3D mm_get_pasid(mm);
> > >   		svm->mm =3D mm;
> > >   		INIT_LIST_HEAD_RCU(&svm->devs);
> > > @@ -350,7 +350,7 @@ static int intel_svm_bind_mm(struct intel_iommu
> *iommu, struct device *dev,
> > >   	/* Setup the pasid table: */
> > >   	sflags =3D cpu_feature_enabled(X86_FEATURE_LA57) ?
> PASID_FLAG_FL5LP : 0;
> > > -	ret =3D intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasi=
d,
> > > +	ret =3D intel_pasid_setup_first_level(iommu, dev, mm->pgd,
> > > +mm_get_pasid(mm),
> > >   					    FLPT_DEFAULT_DID, sflags);
> > >   	if (ret)
> > >   		goto free_sdev;
> > > @@ -364,7 +364,7 @@ static int intel_svm_bind_mm(struct intel_iommu
> *iommu, struct device *dev,
> > >   free_svm:
> > >   	if (list_empty(&svm->devs)) {
> > >   		mmu_notifier_unregister(&svm->notifier, mm);
> > > -		pasid_private_remove(mm->pasid);
> > > +		pasid_private_remove(mm_get_pasid(mm));
> > >   		kfree(svm);
> > >   	}
> >
> > There is no need to use mm_get_pasid(mm) in the set_dev_pasid path.
> > The pasid has already passed as a parameter. Perhaps, pass domain and
> > pasid to intel_svm_bind_mm(), or simply merge intel_svm_bind_mm() to
> > intel_svm_set_dev_pasid()?
> >
> > Something like below?
>=20
> Yes please! As a prep patch 'remove mm->pasid references from vt-d'

Reasonable, as we believe that eventually vt-d driver only needs mm->pgd, n=
othing else for mm.

Thanks,
-Tina
>=20
> Jason

