Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C777569D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjHIJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHIJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:44:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9705ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691574255; x=1723110255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lwdAvYM6M0iKdMXPYKficsfvketYxU8sM1G5iUi/3Fg=;
  b=C9o5gflfgp2frk9Nna6gAkjX0B+nl/1brauzy7/RCR8JxV1x2HHRGs33
   mPROECY4r6xYxIPpTkP4N5W3lVFCQxAUZe5yuRtJwrk1nn3vD2D8kIaKW
   cnwtL1xoKzRXt9R29j2esuy3GfHCkVJ+ms8K+lJXRe5rxcqw+ODgNiT5d
   DHtnvpRsl9NvAIj2mZgri2fR5hjcl3b40RHM1wXfZIpEHQwiz/JRBv69Y
   cnSXfdDt63HwyXUt90W5XTsBLshkyvDsjB+6hcdszwVf/4xWP4LGp3bSc
   QCH/kJoet3/Mv+c2JWY2wCSr6ptZQIrBQO2Oafc3MWyy1lgCbyajNIK8U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350662497"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="350662497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725306375"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="725306375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2023 02:44:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:44:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:44:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:44:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmTA+vfe6mS1NJ3LnoJbZlG6DTVrjV0IswDIjC0L/d7XA+k+oCdWt4OmZu42/AKPUe1JChsRBW2YRidtKeaEJQ8Y7MIfr4Ea2u5gsCrdCCyN5uLiCDqP+zNhjg99kjtVixhlHOCFQJcsCiU4eye6WjjJe9m/01m11iYvs0ET0B8wD9Xw7CHJhYHRwvkno4OhVXuMXbP+QhNaSZS7GxbDp82SezTvu8Y9h8rQw5CifXqG7P24SMrFUyIJF4jj1RQZD6XdXaOIMPCo0AMWHoj9OyiQq2jaHZy+CqkUVemo36OpMKjW0xAxgsvmUYRBhmb+1cb0Q47XZiYtze+FXYnBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwdAvYM6M0iKdMXPYKficsfvketYxU8sM1G5iUi/3Fg=;
 b=H/ogsEZJhgS6eKr/EzGS9Hs3UhRKxEVDBCobQf4khEB78f5n2f++bUvrVqsJ+RLQOS/LKyurExWC8MYVf5tO4D5Wq7czQEZiWNS/q3l0STjam4gRMMLYemK+0QhkQpN1uMBlZIPAXmJyy97djD5fFpF7JQUO6tFU+V4kcMQROnPkj2nyWpDc07NJ+9+NIyF5PJoeFB3lfW7qPwRxHCGER7C1XDX3jBZgCjfby7k8PL/Q0OOI+pTbHFpUAo4NmESVUtB8AARWq9gmxpoq97DqnwWf1SLWVTVJ+Ur2KGah33TF2Z6Fer4QczRfvjrOJWAo6TO99guMTgTMTnIcoUxRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:44:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:44:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHZyczwIC26PTEzeEyQLUQIHK3R/q/hGmQAgACdUTA=
Date:   Wed, 9 Aug 2023 09:44:11 +0000
Message-ID: <BN9PR11MB52766D5CF4F959D58E60C9238C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
In-Reply-To: <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6379:EE_
x-ms-office365-filtering-correlation-id: c6b8f469-eb57-408d-13c5-08db98bd2fc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWwUbN5B7foJlDn0ueb8OxMtwGJyirMpKNkiqahNeheLKFxSgUdbppRpHRHGs5babM3406hc+z4wsT7zu8uXceYK7A+9YWTJLav3WO80/fmiqzVeWpDOk1frGH44ho9qmNuQecxgYTjv5fmuzv7qU+uzKmDPVBMiGt5+y4owe1Ac1pcZ9SDByD0tSapm2l311vLzLfFzAvGkh5pCBmfq0Lc9An6lLexsf6NpEnXZd7H1QUj3xPy5tmO3Y13C/GwEYAZ5YOrnTJ2ip34WnrXGq1OBO27omAzN0U0TXmR2qIZ2OwKtehZtEvtDirCih66yiSa/BlxcB3jEB6kWfQvJ5kRU5d48J/oQpM08LgaMRsVLBLJtqJZBL2EFDaFj7CIDLd5UFagDfic7q2P86NiHGqMovTxdPjObH8VcEFcSTGF8VQ9NsDIpe7eBw8F2MPsankevz8/jZVWecs7B5XuJ9HrP4ijR+U2z4+MUOseeulJ1EnrBepeuoq336fFplYNJxCT/xNOkr12Q0vriqIDG6kvvr7J0H9Y2UsEiwCxhiu/dM61Nj3Un9P4i587z0hFuqS97p/9AvL0k7td8PzUsK5hJf2BgyrtVxsoQPmZGyXEZ0Es08T340hBZAaH22+4U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(76116006)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(2906002)(33656002)(52536014)(71200400001)(54906003)(110136005)(316002)(478600001)(8936002)(8676002)(82960400001)(55016003)(5660300002)(7696005)(9686003)(41300700001)(86362001)(53546011)(38070700005)(26005)(6506007)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZlZDBNU2ZRa0tBMXdsRXhidEtDL1FtL2h6Zm4yNUg1K1RYNENwcjI5bG1p?=
 =?utf-8?B?ZEg2aGdFcDVSVEIwRHMvSHFnRFQ4a290UWdzV0xMbytJa0VibjdXNm42T1k1?=
 =?utf-8?B?RlRMTnUzZTdDbjVITm9URnBXdTRJejZhWWVZRXhGRXdwMHdyMjM4N0gweFV5?=
 =?utf-8?B?WGdCNFA5WGwrTTl0dEZLazBlZ3ZmQktCZHp3NVBmTzN6THo1S3k1ZU5KaG9z?=
 =?utf-8?B?QytUTXMxRkpDSFB3bFVBRlNtM0x3Zm54ZERwTnFFbmhYMnEvTkhzWkgzSXds?=
 =?utf-8?B?MlhUSEM3N01NSUMzcmtOdDZmWTN6ZGhZWlEram9WV3dlTG1LdnZ6ODJKQjRB?=
 =?utf-8?B?dkN5bGJDK005NHk1blg4L2FiOEh3R0lCN2xiL3RYaVNkRHBJV1RSaWVyZE9n?=
 =?utf-8?B?M1J3UGF0ZlQvWTlxbDZ0aG01SU0wSlBrWE8zK2M3dTJVcndqWlFnVWlMZklM?=
 =?utf-8?B?cVhwRGtlbDROSzhXQ0NNbE9pZUtkU2psQkZLb01yeVRxa1pJZ3NheVI1Z050?=
 =?utf-8?B?RUNKeUFTVzBJMjRPVk5jMmlGUjAyaDIwSE16SHRmM05ma2FORUJtbWQxRUV2?=
 =?utf-8?B?d2hMMEhyRDNYU291QXc5WHdWbzN2WTZCM2ZrYUNZcWlwY3hLc0RGejZhUmR5?=
 =?utf-8?B?WWlJUlJST0owRmdvZ0dzVUJzMVlncHg3K0VVUEZ5MlNaUjRkWnR6YzhEalpr?=
 =?utf-8?B?ejB5WlZKbWdDM0FxdVM0aDBQczVTZ3VZaXZ0R0JIZlAvVy96Mnhsb1VrVlhr?=
 =?utf-8?B?cThYTHBjbGlSRkQrNDJsU0s3eDVqbnQyVkJzUXdnd1VLa054OTNHY3VmNUFN?=
 =?utf-8?B?SkRhM3IwM29DcnpkcHh0NFpKUUJqSlpMWUtkRGVOalFlSHpCVXlXaHM2RlBB?=
 =?utf-8?B?NWJKV25zY2ViNjhaY1kwTEFlTGwyWERXdkxZcTY1Z1hXbmtmcmx0NThNaEFU?=
 =?utf-8?B?WW1BcWl6M2FFSy8xeXlEaUI2WUtHM0tkaWZkSTFhSkE1N015UzNkbkxlZlhs?=
 =?utf-8?B?cVo0Y2Mrb3F2cE43ajdhN3dKbEZmSHhtS0ZXMzVXN2dFbmJhZENrYzJYMnp6?=
 =?utf-8?B?Y0FDdVBXTFR5L3Z4VHVkR2hSUU1mQm9hNHppUkw1ckV6QXpwa005K1lMOWNt?=
 =?utf-8?B?YVNOTFh1YVZCdFY4NEdWNWJLVTRBUDJSblltMHlSclNPa3BDaVE3MjhzeVFI?=
 =?utf-8?B?M2lISWl0WHFOM1ZKMHhkNGF6NXJCU09yWnd6K3E2eFdGMTBQUEI5VktGSTBy?=
 =?utf-8?B?R1dyMHAvQkVkbmEwWmFIcnA4QyszcWlXdFZOclVDMjFyWmMzY2lrZ1VudUl6?=
 =?utf-8?B?SW9yS3UxWEhrWGdUc2tOMDgwVzdMZzI3R2VpWVZRTU8zcEgwQWFxb3FzNmJH?=
 =?utf-8?B?WDhMZHk3Y1liTWVZZEtkZmJtMm0zNFBBc25YcWQzYmxnclJVUmZOUklyZkpK?=
 =?utf-8?B?ckV3ZytZaHRqeDdCcFRrOE9NWE03NUpwbUNFTkg2MEZ4QmswNTZydGxLSlRw?=
 =?utf-8?B?YXZVK085SUVQcUo2QlVWL2NNeHlGWS9NblRYL21WVmo1WEI1K1p0Y0twVWh2?=
 =?utf-8?B?ZDIzNVNZMXU3WTRSYkFCWFMvUk0ydDBqdENYSzVpNlpWdTB5dlpMak4rMzhL?=
 =?utf-8?B?QWYvdHlMaGxxUzR3TC9Ob0N3YWhLRE8rWEhSdjk1RUhYSCtvU2lPd0NuR1ky?=
 =?utf-8?B?ZWIwVTM0Zk9mWWRFeDR2TUhtL3VDUzdRWm5rYitBZjhxclBQYWJWSU4rWGtT?=
 =?utf-8?B?N2dqL1U2QkMrT1dOWE5TUDYwako1QzkwKzVkaTVuVDAwT3Z5ay9YbkJHSGY2?=
 =?utf-8?B?N3QzRmp0OFE3TjFMekM3aWNRUSt3cmQ0WmFqZTBLTnlBT2dtSTRRa1plZHN5?=
 =?utf-8?B?a0FZMEtzU0hWdVU3cjlidm5DN0FoU1FZakJjd2hFWGNRQk1pTjlGczhMbkpt?=
 =?utf-8?B?ZGdjVDJUY2lOd3ZiZ2NyZ0pnM1loSE1rM2pVVnJxTUZDL2lESm51M2dvaWU0?=
 =?utf-8?B?MkNLMURNQm1JaElCbFFWNG44ejd3dnRFWDFabjJ2NTl3NHVVTk5tQzFqbVFD?=
 =?utf-8?B?aFdFTGZmTnBOVDZjSDNmbUc5MHN6U2xXcVdxZG8yQitqejRCeWR5cTBscDFW?=
 =?utf-8?Q?oQmiI1norpwHUeEsgTfIYu6OJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b8f469-eb57-408d-13c5-08db98bd2fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:44:12.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vL8RDqnktozy35dvpPlHcsq2quSt3ZHPMEq3nt3hzXj9Nif5h0syo8dIhGHyyCyXDV/tTaeS7xScXLiB+I45uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEF1Z3VzdCA5LCAyMDIzIDg6MTggQU0NCj4gDQo+IE9uIDIwMjMvOC84IDE1OjQ5LCBU
aW5hIFpoYW5nIHdyb3RlOg0KPiA+IEEgc3ZhIGRvbWFpbidzIGxpZmV0aW1lIGJlZ2lucyB3aXRo
IGJpbmRpbmcgYSBkZXZpY2UgdG8gYSBtbSBhbmQgZW5kcw0KPiA+IGJ5IHJlbGVhc2luZyBhbGwg
dGhlIGJvdW5kIGRldmljZXMgZnJvbSB0aGF0IHN2YSBkb21haW4uIFRlY2huaWNhbGx5LA0KPiA+
IHRoZXJlIGNvdWxkIGJlIG1vcmUgdGhhbiBvbmUgc3ZhIGRvbWFpbiBpZGVudGlmaWVkIGJ5IHRo
ZSBtbSBQQVNJRCBmb3INCj4gPiB0aGUgdXNlIG9mIGJvdW5kIGRldmljZXMgaXNzdWluZyBETUEg
dHJhbnNhY3Rpb25zLg0KPiA+DQo+ID4gVG8gc3VwcG9ydCBtbSBQQVNJRCAxOm4gd2l0aCBzdmEg
ZG9tYWlucywgZWFjaCBtbSBuZWVkcyB0byBrZWVwIGJvdGgNCj4gYQ0KPiA+IHJlZmVyZW5jZSBs
aXN0IG9mIGFsbG9jYXRlZCBzdmEgZG9tYWlucyBhbmQgdGhlIGNvcnJlc3BvbmRpbmcgUEFTSUQu
DQo+ID4gSG93ZXZlciwgY3VycmVudGx5LCBtbSBzdHJ1Y3Qgb25seSBoYXMgb25lIHBhc2lkIGZp
ZWxkIGZvciBzdmEgdXNhZ2UsDQo+ID4gd2hpY2ggaXMgdXNlZCB0byBrZWVwIHRoZSBpbmZvIG9m
IGFuIGFzc2lnbmVkIFBBU0lELiBUaGF0IHBhc2lkIGZpZWxkDQo+ID4gY2Fubm90IHByb3ZpZGUg
c3VmZmljaWVudCBpbmZvIHRvIGJ1aWxkIHVwIHRoZSAxOm4gbWFwcGluZyBiZXR3ZWVuIFBBU0lE
DQo+ID4gYW5kIHN2YSBkb21haW5zLg0KPiANCj4gSXMgaXQgbW9yZSBhcHByb3ByaWF0ZSB0byBo
YXZlIHRoZSBzYW1lIGxpZmUgY3ljbGUgZm9yIHN2YSBkb21haW4gYW5kIG1tDQo+IHBhc2lkPyBJ
IGZlZWwgdGhhdCB0aGV5IHJlcHJlc2VudCB0aGUgc2FtZSB0aGluZywgdGhhdCBpcywgdGhlIGFk
ZHJlc3MNCj4gc3BhY2Ugc2hhcmVkIGJ5IG1tIHRvIGEgZGV2aWNlLg0KPiANCg0KaWlyYyBpdCdz
IGEgc2ltcGxpZmljYXRpb24gdG8gZnJlZSBtbSBwYXNpZCBhdCBfX21tZHJvcCgpIG90aGVyd2lz
ZSB0aGUNCmltcGxlbWVudGF0aW9uIGlzIHRyaWNreSwgYnV0IEkgZG9uJ3QgcmVtZW1iZXIgYWxs
IHRoZSBkZXRhaWwuLi4NCg==
