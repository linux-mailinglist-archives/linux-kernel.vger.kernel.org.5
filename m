Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FF753027
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjGNDuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGNDuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:50:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8E26B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689306611; x=1720842611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9SZnHTxd3JMQOYKu5prbOPR3O2iZf/gwQRzI00f+Az8=;
  b=il8qfHRQjoBEIuQ6iPaLAVJpOyCXEysW8IymSdGZvADnDO6mE1gIRBbX
   YbRvGkbsSioFjDkBG+2RsxKfukowp6yM7oHXgQ4/V4X4wsgDyd2X6H3zr
   U0s2aEI2WeXZ9PNtFQwrlI13S0UmdH4cPqe0xdb6me4pgwFqhFmWYG2Z+
   HTg/odWm81kiumCaKDPANcxdeyLbRHHN54LuOvVtoE6dc/HL8Pbhd+G7/
   psiQ8ThujwL70kaVkWuLbabMwVTDohtBySATiQxPnQzUtIZ19jXNgUknd
   E0GXgFQ/ydl7bg7xHi1xCx+bPMfEfwEMYdRJ5t6LtWTIV0GiA324pgTYN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362847671"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362847671"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716183705"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716183705"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 20:50:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:50:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 20:50:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 20:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy9elCesoUyNbmNC4FlwzTvYwfButgW7Mmiv/agz0hkEO5j9+Mxu/SOecB2w9pMCDCtXbnucWtY9UfhEkwiBt9badzKp6E1BrMgQXrhurG8L72juHBGh7cWE//totEgGvbP2oMl8F7RER2eqWI0dNgkK48buPR4Wtc381vmEKxm8kjZrg7m6oNFMRDFYEmDHGnm2p8LNU/ZT+xyx7Kg8lfn4tKPxhCJrbPg3lEz8l9O1t6bU3CiQP0OaY7TSCHAeVV9EGFrMXEbMjK0sKueDKPkbL15HYnQzlcWco3etAOGn1ELwd6sOp+7pwQ3LQ2as/qHxJszD3Sm9j8P15T+bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SZnHTxd3JMQOYKu5prbOPR3O2iZf/gwQRzI00f+Az8=;
 b=LuQqDJKZ6vBGmxjhTdUxsQ6nAJ8Lf6p1zfflDt81Defnv0WDpK7gtev1huF8a80ptBmnLWQ9EILsAJiBcQIfhSkPH8vb4WG0qU3eCNbmWTuwMNaD55iz5WdPDtvalWGOTeJpyLoOnRHQN+FHyZweNOl5j/JekB+zwYa18lLF7Gldyp1FcQ1jaLai4DLIVnOSh1rfCkEOxz8xJmZZGqbpRTT8Wbid8IUccjtH56G7y3SR0fUKGps+epCCZkCP2bsX1zxTk66Pj82pCiseWTIfv4xHt8yYMfD9ETukU+OY5mvZl1krHIVWw1XJcBZr4ymvVAbROpYjZWlwao4n0B4tWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:50:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 03:50:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZtN38PCDm3MU1mUGnhonJfEjVea+3VKSQgAFJrgCAAAQ0oA==
Date:   Fri, 14 Jul 2023 03:50:07 +0000
Message-ID: <BN9PR11MB5276E0C6F1063E581F29BB978C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
In-Reply-To: <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: 10dff236-49dd-4d46-46dc-08db841d6a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ntAjEWM0BqmMJwSDW6eOQCC2SH3Sk14/6zb9dDN5y+fgaMKoUoaYwhv0LWSCodhzMX1pD1W5/OT/uKQs7dP6+R1fi+5/0vO8AkExpqibRZ65thz8NCmPmEUrnYiRFq21sJdHeOQHmR75Kg838avtEeTzeA0ltYTa7swI319ge1OCOD6uMArqplRvbcckShADmTJyuijU9AP74Gqy2mLbClEhHAnyfyp1mVZ8oyZu+o4I3Ss+0WlKItKGmnxrzdXlm5uX+avXT+HodTCgRd9oRUFWVw3sqOhoh0qXFcnzp1DUu0J3DYiM4WamtaFXaCFpTdMJceVjtMPB7VyunWqcS2gj8IFlZb5HgBhX8tSlD4vvDFtiGbPr1mPUiZcs+4Sru2igg/gylP6OP569/l79ALQz+e2tTvuPyc0lNFyz1lB16JHZwuBy37f/jFt8oWTKauiSC7ohJUtdcuIyI1uQ0KoPn23vfSGT/CyT9JlG5RxjHk5jDGR0FwPtBwXvQWmLr7jicVpmgdlx4qYFVuaVtZPL0uMwlwZLEDkt0CMHiFmDJWKHIul4/iK3EGi2fC2OOwN1HiLa58aSIFfENB0lKtkJI99Wvb6Z4d+JokcI4t9VzmIqiWbkjK2Gvi7tJG9X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(82960400001)(83380400001)(186003)(26005)(86362001)(53546011)(6506007)(33656002)(52536014)(5660300002)(38070700005)(8676002)(8936002)(4744005)(478600001)(41300700001)(110136005)(54906003)(7696005)(71200400001)(66556008)(66946007)(76116006)(4326008)(66446008)(66476007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ZFOGl4M3VsdnlHd2ppcHF0M3pvNG91TjliL3czNFVjbktRU2FOeUIxUmNZ?=
 =?utf-8?B?SlBxRmxNRnZqZkhvc3pnQis1anl0TjYwVC9rSmxKM1FzYzRFYndybWU1cE5W?=
 =?utf-8?B?STNMSHVZZVhpaDN5UDZqdWR5NXFOR3UrckNVNnl3WDVVOVcrUDRGLzNEdG1a?=
 =?utf-8?B?dGdVQXByWXRyNmd1YWdwS1V0UlJhVWZ0L3ljUW41YUVkeHZqb1I5QVM1UThV?=
 =?utf-8?B?Y1l5RWZINnovUVNqbkkreDlGTy9RQjNkdWExTlJWNit4alo4Z0ROM29ORW5N?=
 =?utf-8?B?NmdzQ0RVTVVDZmUrekJ6Qjc3MW9mYUlSU283TmZVL3RUZTFSbFBBclo5dFU2?=
 =?utf-8?B?eEdHQ0pEUHFaZVpReTZzelIvRVB2OEFkV3JHOWNjcC9CRkJLMkRyWU8vTlJs?=
 =?utf-8?B?MHBHUlY3OU04Z2lMQ2FyYzRqbUQ5WWg4WWlTOWxrU0thaXd1eXVtaUQxb1o3?=
 =?utf-8?B?aGpRMklkN2hmYXEwWWZ4UkkvTFl0Qk5rSWRCSEVtcmRoL0NIUVAwUGEwMEFo?=
 =?utf-8?B?ZFBDSTRFRlhTeGJ2a2czM3ZjWnhEWHZpeVR6VWxBY285bW4yNFI0V3JmeDV5?=
 =?utf-8?B?VFRpMTlqeTBYY1llcnZTZGZtcjk1ckdaemhGK3VtNTRDVGVXbUdPU1pWS3lI?=
 =?utf-8?B?aUptczdRUlVpejBOdWp3anpwdy84M2hwNUZJYkJNSDh2TlRjWG9uV3k1N1JH?=
 =?utf-8?B?UXVCcVB4TEFYdlQvOTF4MEEvNTZ3VFZLUHk5SHBkSzRrbHN1cXVHNVI4NnNT?=
 =?utf-8?B?WmMvQUorY2FUK2tUSWpiSzRWM1cwajVONEYwSGdpR3g3Ni95RFNBZnpzeHVD?=
 =?utf-8?B?NE5KWmozaUNUZnppQjk2NHJ0bEgza0JnNzlISFF6OFA5dE53Qk9pK1NRKzFi?=
 =?utf-8?B?ZTFNV2NkUTltSFQrazlYOHQxNXN3VTc1aG9MTTlCVzBVckFQMThNdlNucHkz?=
 =?utf-8?B?UGFSZUZrQ0RRZlROd2pZZkZuRTd2UW5LaXlEd0Fab0tjdmpWL2VnS0Y1WUlt?=
 =?utf-8?B?bXZ2UXJZWTFLUFBkSERmSVhjYTBTdlhaSW51Q2FLNElyOGU0OWJFblRRdHZI?=
 =?utf-8?B?VmlmSDVOdkk2d1c5eTNRMVp3a1ZIa0tSajRhQVZyZFBobFIrVVpZc3FUNVBo?=
 =?utf-8?B?aVlyeXhjQ1FjMmI4YlJrZndic2JZbkFJeWkxTktDaldSaUdMeTR0cUhpWXo4?=
 =?utf-8?B?elF2Rm11czBPM2o2emdzSzllNVl3T280R1NRdzM1ai9rU1M1eEJtdWliNDZO?=
 =?utf-8?B?bDBibVgrVzBQZnlzWTV0bk4vS1pHRk9mQThLdCtNQ2tZbE5NN0ZFQWF5eDht?=
 =?utf-8?B?Tjl4VVE4UlVnbHEybmRuQXZSMmkyMnRVZnB3ZTBWOFMyTENKRDRneS9lcW43?=
 =?utf-8?B?TWhhc2RGQVBPMExBbnU4dDBIOVVUSDJvTVFtUFB5aDFRR01uZFJaT29ZamMx?=
 =?utf-8?B?Zmk5NC9IcXJ3VjZnb2hlL3lnNHpFaWdJUlFnc3ExZUtoRVgvSWVPZXZLQ0Fj?=
 =?utf-8?B?ZHdvNXNvVXRHQkxpRE5WRUYvVXJKWjk5T0c2MVNhWk9mY0lvbGh1cTJXajEr?=
 =?utf-8?B?YzNrSjdHdVZVbzVVMVMzbWVwVStWcStLd2JHOUpWTkJsbmczc3FEeGxVMytH?=
 =?utf-8?B?THgybURheUlTQ3ZKL0JHMWx4UzNjbmtCeVp1ZlIwc2U3eWVUMWNXRU9kSmNl?=
 =?utf-8?B?THVlWVAwTWNDVGx6VmlsVFRoWG9hQTVoTVlNWUlrQWl3TVc1Tk1rMjZaeGo1?=
 =?utf-8?B?em9BUnUxWmJrVGhpWGpsOVFveWYrRUE0UnQ2ajJqcC9BQkxjL2tsS2Q1Z3Iz?=
 =?utf-8?B?cFJ1S2FBRjdMNkRmMkFEajFTTXQwK1FVcGNUeGJ6SUhNVDdqWVgwWHhtZkx2?=
 =?utf-8?B?T055SFpzWUpqWWJrdEFlZWdHSDZ4Y3Q5VjJWQkVTdXZqOXVGdWtxSTdFd1U3?=
 =?utf-8?B?VmxXME9PMkNpc3F6MmhkS05pM0VvRkthUjU4V25oZW1BNUhKY0lBOXd5bm0x?=
 =?utf-8?B?c002dXVxaVdidWtrZFRCYjJjb2xHUE04Y3FrY2VCZU91NEoxNVBNbjl2d3JN?=
 =?utf-8?B?QXBrdkJJQmY3d05XZWZYdnNlMTIxUkZ1bkJWT1dVdG1FUTRta3I5NktUTTRY?=
 =?utf-8?Q?/ocKSPDZClkhcBhDWZ2UoWiPn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dff236-49dd-4d46-46dc-08db841d6a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:50:07.6097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCXI/4o9fImee4lpgo6pSqFH5FO0JTeaGFern9tLNMWRHJ0fLrdNsVXCUFaAhSptXHGYCWFlBspRxPHesvNhvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTQsIDIwMjMgMTE6MzQgQU0NCj4gDQo+IE9uIDIwMjMvNy8xMyAxNTo1NiwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDEzLCAyMDIzIDEyOjM0IEFN
DQo+ID4+DQo+ID4+DQo+ID4+IC0JLyoNCj4gPj4gLQkgKiBTaG91bGQgbmV2ZXIgcmVhY2ggaGVy
ZSB1bnRpbCB3ZSBhZGQgc3VwcG9ydCBmb3IgYXR0YWNoaW5nDQo+ID4+IC0JICogbm9uLVNWQSBk
b21haW4gdG8gYSBwYXNpZC4NCj4gPj4gLQkgKi8NCj4gPj4gLQlXQVJOX09OKDEpOw0KPiA+PiAr
CWRtYXJfZG9tYWluID0gdG9fZG1hcl9kb21haW4oZG9tYWluKTsNCj4gPj4gKwlzcGluX2xvY2tf
aXJxc2F2ZSgmZG1hcl9kb21haW4tPmxvY2ssIGZsYWdzKTsNCj4gPj4gKwlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGN1cnIsICZkbWFyX2RvbWFpbi0+ZGV2X3Bhc2lkcywgbGlua19kb21haW4pDQo+ID4+
IHsNCj4gPj4gKwkJaWYgKGN1cnItPmRldiA9PSBkZXYgJiYgY3Vyci0+cGFzaWQgPT0gcGFzaWQp
IHsNCj4gPj4gKwkJCWxpc3RfZGVsKCZjdXJyLT5saW5rX2RvbWFpbik7DQo+ID4+ICsJCQlkZXZf
cGFzaWQgPSBjdXJyOw0KPiA+PiArCQkJYnJlYWs7DQo+ID4+ICsJCX0NCj4gPj4gKwl9DQo+ID4+
ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZG1hcl9kb21haW4tPmxvY2ssIGZsYWdzKTsNCj4g
Pj4NCj4gPg0KPiA+IHdoYXQgYWJvdXQgbm8gbWF0Y2hpbmcgZGV2X3Bhc2lkIGlzIGZpbmQ/DQo+
IA0KPiBrZnJlZSgpIGNhbiBoYW5kbGUgdGhpcyBncmFjZWZ1bGx5Lg0KDQpidXQgd2hhdCBhYm91
dCBkb21haW5fZGV0YWNoX2lvbW11KCk/IElzIGl0IGNvcnJlY3QgdG8gYWRqdXN0DQp0aGUgcmVm
Y250aW5nIHdoZW4gdGhlcmUgaXMgbm8gbWF0Y2hpbmcgZGV2X3Bhc2lkPw0KDQo=
