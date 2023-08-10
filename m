Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9237771CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjHJHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:45:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8B10F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691653528; x=1723189528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zd3EN5u/JhB3oJdIjnmWrutiMD5GJ0uKeLpiAPky3Gk=;
  b=VQQWlP0Mpl9SxO4d4Oe/KWHJx3Xsy8k8BhZQD/v+mfovGKnHbRJGzJQ5
   ErWGTI505RTqMWwwceSEwDMYTooDYajldeE6eDYcSj+eNr1e6fXtUc5pF
   gNQbRKiTtICyYFW9BDOPPDOeyJcZrU4HvffKynAF83aKrgbNRG8nZaYmT
   4eorPsNhScDSXEEHvt90gmwrfRIztAEtfQBFRDQD25uYA1Ag5RTOigLVi
   mvU360MCyMkTKOyojQYTpfnsQBTivVSA7HHeL0qT2OZDDlsu8bDWhyM2U
   9bYE9YrAYrUsh8skDs9i7HrNW5sBTSLsHSHvNfyzq6OR1H2wgLcZAs6KJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375042361"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="375042361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062789714"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="1062789714"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2023 00:44:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:44:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 00:44:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 00:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZb+RKocmbONT4Myk6waRNzWJaiBfXHMMvbsq9EYDWYwvYGtuU5tFPTJZ5UgXk+aWCAGB8UWMSLp40PxdAKe9x63hHdp7BbHqSwPPV7r37cN+SNiYqiIHA+UDntSIIyhmxTrOgUbRe6asvxKeC27CGNkJFhyqtDqlwHlqYQCYEFi+D5MES2nkw1lqwFSKZdiCqon2c3tGuk26I57AeIMQH9U7QVMBKK4/m+Qoal6xQd6xrcPJlKadbkDaCrOGm0D7PEI4mxM9dLNnqvupDmJBnti7tvLu4mqXxtmOQuozsmpjDazGeBf0A8zi9EGlYhCEnHmpQlg8WQzqqkMf1YshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd3EN5u/JhB3oJdIjnmWrutiMD5GJ0uKeLpiAPky3Gk=;
 b=GbKio1ygGNH0eiS/8uVlKHhCQP3WuU8TWEFfqkhO8gk6XfQ7Li2Yb1g9wq6yTzkGJ/nZYK7iKhH7HkbNUdrJwkIpSxz7VfZZ66BYK21Tl8VRRZa8MXuVQuXO0JDsRKNQ5jw52INwNAHQCtvrN6LvTq5LU2aUGPheJRBoq6GfsWih+A9S55OJUux5iw7q+hEmNDlPPxRs4pNHgbomjShBvsp6AbLZ1TioKbzG1mT3i7Ixac9CV6JLjbH3S+x3CgliXzNhn5pvJuwROeJJtf+ipoKnKvRCK2C/9hRDbc9gfJTJ4wrEBVlFFh8cQF8heTfM4fcvRIJws2/50grqTEf3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:44:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 07:44:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHZyczwIC26PTEzeEyQLUQIHK3R/q/hGmQAgADyeYCAALILgIAAaezw
Date:   Thu, 10 Aug 2023 07:44:46 +0000
Message-ID: <BN9PR11MB52766C9623151362C18ED0C08C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
 <ZNOmsfE3Eheuelv8@ziepe.ca>
 <84ee4ce8-8589-68da-b105-f96c961ade16@linux.intel.com>
In-Reply-To: <84ee4ce8-8589-68da-b105-f96c961ade16@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: adbe3520-a654-47d6-1c98-08db9975ab32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdl7nvcg6S2oSQReEqaA9w6qWLLoKc87rywLKytQwBIg/Bn9aegNa/9hU/s+OKn/WLS/pHgmir80GUqeOqtTRYh6wQPY/sBWDln1gK+ddZqseHHIfCWEazX/ng+SGX4WBT3py0QAa14l9eGHIVcDvFNhQ0bo3WEY4B9CFpSPVL7IuKULCzJTvINHwF5kDHoVAIU4/ALiqbDuP4M0lbssSJZ0qSfvjdbF9QexxsSWg2Eqrqzn32KskZVcUxFBPYpcvPq99DJYAKQgGdXOGm5vKI6NUIHHyveORFbKMuS4kIQNnJ8gFOmWAgRByBW509eHfOjtRt0QGBq9mTavLcU8r1QGjdAJH9lvfvluADV4fj1eMEGXXAhaTRsScuRO3FCyG1g79CcnBRTUE4JYlW5OPC6+TDWAEdo1NLw0S1ElAPy/3iGbs0hSM04rpK2mXCJZlLsDiNxhEthHfsrDXNGA5ca0Kdf55/XNnrb2RoS6+cin+u42booaJ4cb8x/n84jpinQYiQrkpjbYC3SLaj6CJLZ+59AQpB+xSWHoo0H2D5ertgQVx80zfkj6idISGXMXFQUAYhYm7TOxZ/JHjYOe9Xs5BgA/k5eFUELbqX486hc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(186006)(1800799006)(451199021)(38070700005)(7696005)(478600001)(110136005)(71200400001)(54906003)(86362001)(6506007)(53546011)(38100700002)(122000001)(82960400001)(4326008)(66476007)(66556008)(66946007)(64756008)(66446008)(316002)(966005)(76116006)(33656002)(9686003)(26005)(41300700001)(5660300002)(2906002)(8936002)(4744005)(8676002)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUhNTjhReFZEU3hyMXZIZG45czB1S0JSU1F4ODlsbER6aGllS1RYaER5ZFYw?=
 =?utf-8?B?RWlUMWNQYUZiUUZ6VlBVNmdOOG5DdVlqTGNHbDVrL3NJYi9jazRaQWNxMWQv?=
 =?utf-8?B?Y1pNRXhxbVVHOE5DbDM3K2RtMFBNMWxhTnVtY0dlNHJxT0dqTG12blB4cmlp?=
 =?utf-8?B?V3dTYTU1clZ6NldOdm4rSXZnOUdIcUhkVDlKUUR6clROZHdka2s4QmpVOVdQ?=
 =?utf-8?B?R09FWGVXTEdyVURkOVQ1YnFhVzFYdkw0ZWhRTjlLNEZJcmZPNVJNOG1mc1F3?=
 =?utf-8?B?VFRLa0dVTkR0VDFldDFKSzFyK3dPNFdqeUc3ODJ0cDdHeDlmUlhaaU8xbC8v?=
 =?utf-8?B?djlxREVLQjZqazlkVGF3YkhuTy9wQWhOeC9mdUVBdTN2WTBBcmJSWDVaQkF5?=
 =?utf-8?B?QjJlSzBReVNjL1grZXlkWngvNDZPZCtwOHI2elM4RE1HUFkybzEvcFJCbXVC?=
 =?utf-8?B?d3c1VGkzVnJkRDQ1V3ovUDFKQmY3dE9JMVZFRzhwWGRVOHFIOWM4Y3B1RElC?=
 =?utf-8?B?K3F5K0h1dXc0RXpNZUlvMUlNWE9VVHE4RzNpejJLNG1Qajljc0lSdE1lK21E?=
 =?utf-8?B?dXhtSXVYSWY2ZWlndWFYc0RnK2tOZGJ6QTRWRnNRSzgyUXdzeG5GNEdSN2xq?=
 =?utf-8?B?NzhYV1YzcklrSk1HYW1ocDU4bm1NY0wrenZ3VGVOSXRNM25zTnVtV21qTWps?=
 =?utf-8?B?TEE3c0h6ZGdSQTVjZTdVNlNWem1RUXZxdzI0TklnQkNUOVBvS2VZTUtENG5y?=
 =?utf-8?B?TUlTRFRDaUZldGxFZUhwMWV4ZXZPWE91MzRyWkNDMjc5MjF3RnVNMSt6U2Yv?=
 =?utf-8?B?MjcyclR0M21HS1JhRFBxdHFDblZlc1duUE5jejd1V1FWaVRFUWhlaGxZZUFn?=
 =?utf-8?B?TnFQNVBibTY4Zy9WMUQ2NFFEaUQvaUtnVnFVbnYzMjZ6T2FKRmJSV2ZhV2k2?=
 =?utf-8?B?OGU3dXVwbmUvWk8wSTJWYTBzSllqbUErbWswWmI0TWFZNGlUZXNndXNLVmRZ?=
 =?utf-8?B?OVB4UXViaDJTeHRtWG1pNkpqNmZpVU9mNWFvSjVzL282Q1JCZVdoamYvL2Ez?=
 =?utf-8?B?SUxtU1ZZVytpQzJJaUFRK3d3S3ZOVE4yczZNMndmck5ibWlDYVBRN2JobjBj?=
 =?utf-8?B?V3piOWF0eDZKdkphS2gzVVJ6K1MrWm1jM1pMWVN1QXBrTy96S21ZU0dOcE1w?=
 =?utf-8?B?ZGMrRkl0VE5tTUljTml0dUNPd3BVT1JKZXd3TUg1QTA5YzVyNHpVSlYxTTFP?=
 =?utf-8?B?RTZvNng1OHRPVDhTZTF5QnZHUXZQbEpPWXp0L2JMVm1HdjlzNHlwZVd4QnFW?=
 =?utf-8?B?TXpyZWtna0JNRk0vZXVjRFVLd01JMmdRdmVoSnl1ZitNWVpkay91S09GcjFF?=
 =?utf-8?B?REFLRk9ueVE2ekZ5ZTU2c3MzUkFELzI1cDhQa3V4UGwva2ZQRXpsNTNSWUhD?=
 =?utf-8?B?TVVHNDBkTkdzbmFyQUpjNEtZUzg4MS9YUGExUHZoZHpzY0M3RkkwdzltTE13?=
 =?utf-8?B?K3pjS01sam5DY2ZBeDJhQVhtTG5iN1o0RXBTL2FtSklmS0ZSOStsZjJKSksv?=
 =?utf-8?B?SldEYi9pampGb3F1bmN4MnFQV2xicWN0bUpTeFR5QWRpOFBPYlpHeFQ4WXYx?=
 =?utf-8?B?dzA2Qmo1TFdXZFNCcnVUcU9iRm44Y1d1RnBaZTFtWXN4aHl4L1BLd2U0Rko2?=
 =?utf-8?B?cmJ2dkZzRjFHUDVpU0dvdU1HbmZBNFpRUjZ5UXprdDZEbHRJT1NMWTYwWVk5?=
 =?utf-8?B?NGl0UEtRaTdyVWpDb0VPd2UrL0tXZWFzUm9XUGZZRG9pd0FsY3BGQk9PM2RE?=
 =?utf-8?B?UVBudVFiZi8zMGhOQVFCOVBJL29PbkQ1Wm5mUGVvaC9KbmFVQ1Q0YWUwSjVQ?=
 =?utf-8?B?V2NNRXo1S0NobkM4K3p4clRFNzlhV2NiaEJ4WVBtVEdaM0JzekovMXpLeGcv?=
 =?utf-8?B?NUNUYS8rOGw5QWFqdWpLdzg1bDN4Q2hxc3RYYWk4UFpCR0trVkxROW1XNjEv?=
 =?utf-8?B?anBIMXB6UDdKcmw4RCtKVHp2TFMyWlRUdnRTOFNkZzlBSnAzazhYRWxKN01h?=
 =?utf-8?B?ajFhMkRWRkd3bXBBbnJ0T3NYd1lSY3ZOSW50a0JKSVZWam83dlg5U002Vnd6?=
 =?utf-8?Q?Y6Sm+t/CLZ0HhrXsZhD1VRZhH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbe3520-a654-47d6-1c98-08db9975ab32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 07:44:46.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSwBc7xRfE1r+X0PlCK/uW1xtAo4DQ0/en9Pi/e4noCwLbzeOnwMKetHmFf/NNr7q/+e6dtTmUycCx+VKBj1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDEwLCAyMDIzIDk6MjMgQU0NCj4gT24gMjAyMy84LzkgMjI6NDYsIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4gPg0KPiA+IFdlIG1pZ2h0IGRlY2lkZSB0byBmcmVlIGFsbCB0
aGUgZG9tYWlucyBhbmQga2VlcCB0aGUgUEFTSUQgYXJvdW5kIChjYW4NCj4gPiB3ZSBldmVuIHJl
dm9rZSB0aGUgZW5xY21kIHBhc2lkIHdoaWxlIHRoZSBNTSBpcyBhbGl2ZT8pDQo+IA0KPiBXZSBl
dmVyIGRpZCB0aGlzIGFuZCB3YXMgcmVtb3ZlZCB0byBtYWtlIGNvZGUgc2ltcGxlLg0KPiANCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC84N210bzBja3BkLmZmc0B0Z2x4Lw0K
