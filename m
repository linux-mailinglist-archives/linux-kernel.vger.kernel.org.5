Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37341804956
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjLEFaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjLEFaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:30:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D470109;
        Mon,  4 Dec 2023 21:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701754217; x=1733290217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BK+CpiVRnqDAMIsDKFTOIxC6kFpLRsSPE0sixz2ESUg=;
  b=PjX3z1PTwrOMZHBsYX2jGqMoU4EbC9t2d0djEmjvoEF7p2+I/sTBS9eR
   1PTQqiJreIeq0RGlqZKwlCbgCqxnkUgImxT7e7sqt+kkxaEgemh8989jJ
   Xk4c4vlzcQ7TX1GcXLUXa3ucfVBBomB5S7s1/f26HPokQrsz15MNtaE2t
   oKDIaUMi9v6hXGgHyXLP4MPq6w0GibfJ83t0PpmVOHouMNeA7VewZ9xzV
   lMvW7uAxpt8hqYtPViapTG77rJHkqHREgrEuh0bpIIiNccqHcOdjoxj4g
   vzWBjf76uuBetpjoEn5WDad5BSXK3w42oqRoZY0QRJs4rRUzA4YD2CpS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="374030097"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="374030097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="18838029"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 21:30:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 21:30:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 21:30:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 21:30:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkljAEbUbPgbfSWvvR09A3CMU+cEyeI3/JVxjvHrDrmajmiOj331WQoqc2Ri4GwO3k37pHz0A6SrypFpXOPjibd3wUD67mPCE4yTz5P2dAPgytoeIkPk4eEBqGIAO9vWc6n/W5AMG283uG3J8W0m2Gw+2trtoAk29UXhpYkrGhGsF0a7XH/uW6zlUF4IcAkwHZ3W+511REIg26lG584SHMoGcGQwekjfOpO236AM19gw2tRiAyHaW0geyixHhqLWJXp5In7BxgLS8T3nPyTzylxfxcqSSBV7EXOIdH5uSAK+dEHvDmLJClg0YXKLi4snVND4L5qmkyTtRR8lnIfdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK+CpiVRnqDAMIsDKFTOIxC6kFpLRsSPE0sixz2ESUg=;
 b=YuSP73q1U7AZCVVr2TaevJST0/F2iXIVwLjsRWwXNO8wFPDtfkgP33SZlhyE0bGhAPl+6HAkcIHvRvos6R0SISWweI0T7NYzYq0WjGqPLWC2BtJkQ8yRYQokqn7/AvDZW3eVNxVyhkG7+VkiVyA1P4e1jqT8RkCAF01XpZQkVayQIkYIpYzEukuZujxwQSdVWVbZ3sbDE1/rN5SvAGLds5wkMGYXLx7ggERXjxcRH/9TAF6hHVldIoo7lPxVd0CwDai/MH8G0+ZE6l8wM4MUMTq4M174zO5wQGPWfqKFE0wyIAqHEIj9N+lYv1fdBzxIqykQ88OewaQsnWxIJ0efVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 05:30:13 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc%4]) with mapi id 15.20.7046.023; Tue, 5 Dec 2023
 05:30:12 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Su Hui <suhui@nfschina.com>, Greg KH <gregkh@linuxfoundation.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>
CC:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Rix, Tom" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v3] misc: mei: client.c: fix problem of return
 '-EOVERFLOW' in mei_cl_write
Thread-Topic: [PATCH v3] misc: mei: client.c: fix problem of return
 '-EOVERFLOW' in mei_cl_write
Thread-Index: AQHaIZy1SmBT3EqNE0KEVNeH7tugS7CYzLoAgABW2ICAAAHNAIAA3WUAgAAv50A=
Date:   Tue, 5 Dec 2023 05:30:11 +0000
Message-ID: <CY5PR11MB6366792D6D72FBC8D4F7DC06ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <2023120425-broaden-image-fdc9@gregkh>
 <098b1c0f-f303-3708-939a-28ecaf2185c3@nfschina.com>
In-Reply-To: <098b1c0f-f303-3708-939a-28ecaf2185c3@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB7429:EE_
x-ms-office365-filtering-correlation-id: 6ef60b37-c4d8-49aa-0fc4-08dbf55340b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZY3ks1lz7K+HyK0zVBpoin91DgFRl0lIRCxcNSY/EuPdarYE1DtVN2es5VkOe91tYeTGTkxk67eYW2WtaToKORVbrUbkbtxPCnK/OqwPg7bcELdVHOda8ljsUcfIj0bfY9Xe0WJTg1ucshP6bGztFRkLTRTTr0bz2W0kR6m5YNI86aPsY86Al1jRWg0f8Bmy0pl0agbRcwjArVgSsmPauuhycJBJbOdnO/0opUQJJyw2yvX1WaLX2Yg4kQoNY/DHPXFuyT0FIy9TQ2NIBeQe7INWmb7jelOmBRRZ0jFyNidpRLJ+BpNS5lB46tYVgf1LP6RHgz/E7g4QEtjTdb4d6BFFLGnhqE5IPwuAIlxgthqWvmNHJg7LKCGYSznWvGk6WQpx6jjzK/UFNbQlfpoBHqoUPWifhTfzo7efquIjPVD+oIiOLcWE/+iQ6Sr7jT58bwoAPT7xprCn4r954oJEIyd2RxdfwpgAkfakUGFRVTdkwkSqBKskfQGqVCdake3kVFeGgeEqLUzWtYb74fUd3BRVaqNKAQfnFu2CCsr4HQ5xUFlJpfHC9bFMRuwIke1lRV6hcS/6YeejNR3OTbqvfAtLIsBTCtCjNbolM/UqxxkrHwI2EAmRbtXFJflfMkGtTQxy7k8mwo1+R6huI0kmcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(55016003)(71200400001)(86362001)(7416002)(5660300002)(2906002)(122000001)(52536014)(38070700009)(316002)(4326008)(966005)(64756008)(8936002)(8676002)(33656002)(54906003)(66446008)(76116006)(66556008)(110136005)(66946007)(45080400002)(478600001)(6506007)(7696005)(9686003)(26005)(66476007)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UitQR1RUS0M1b3RtTmRncjhIZmdCMzljWTJEbEdoVTUvY0lZc2RNaXRmcGVy?=
 =?utf-8?B?eDFHak0ranBlNmQ0T2xvS0psV3dCSndLSWZFdlhqa0t4UHhPSVNqWUFlSGU2?=
 =?utf-8?B?bDZDdjVxTjZJaUFEOGZuTXdVeW40WXozd2tEc0ZmeGtyMzRvRmdSUjdpL3lG?=
 =?utf-8?B?WUdFT0RvNUI2QTNFVGs1QlI4S2tiTkQyNTlHRi9wMWN0bDY5TnArMHh0dGRr?=
 =?utf-8?B?VThGOGdoSmxHWFJoOEx3L1B3cmROeWFYc2ZyOUEzdHEyY05peHB6RFZxbW9o?=
 =?utf-8?B?TkltYmpNZDJ2TExOVnZYUVJhRFo1K25qUzByZkYzUXpvYS9yY0R3cWhMSkFu?=
 =?utf-8?B?dUltOGpxeEVFdFVZZFdBbzd2cTRQYzVYeTU2L2h6dWRMbk45aG55T1JiOGRj?=
 =?utf-8?B?STY0WldXUHdtV25talpaQ2ZoRWdEWGo4VzY2eWZVcCsyZHJXK2tjNEpxT1VR?=
 =?utf-8?B?ZS9zUTBndTJ6d2crZ2V5eVd3dnY1QkpVcU5iS3FKeGZvY2dxL1RqSXl5YW9U?=
 =?utf-8?B?Zk10UVRPbzR5cm1DN0dCNFNNc0NhVXV2Y3dpb0U2aHlZbXpsSE1NQkFteDVQ?=
 =?utf-8?B?eXBKUFhIUWRtQ2duN2dCajAvQzlZSmMrRll6Y3lPOEJvT2hjWVBpalZYdTgv?=
 =?utf-8?B?UFBCMi91a1VsVXZ4L3NlTUl2TmxxRDV2eGYrL2hHNVNxOERzQVVsNjRLZVJM?=
 =?utf-8?B?WHJUNTZod2E4aUdmeXphajRreTc1T1VxREdkL3ZjWTl4aUdQc2hxb0hGVjZ1?=
 =?utf-8?B?dnkyZFhVeklNVkxlOWowLzRkV0s1QzcyTGRVOU54UlFUZi9rVGNEcDJUNW1T?=
 =?utf-8?B?Q2dWYmlaeWk5d2Y4V3BOVW1tdDBqUnFUYWJQeS9xZDgxZk1sSGJsSzlYMDB1?=
 =?utf-8?B?c1lRcHpsYUJEa0FKMTFIcTM2QzIyMURtODByeEZtdGxlNmRyODU3Y1A2R1hT?=
 =?utf-8?B?OXJxNU5TL0VOZlFPcFZDTkJLWitRdzJuV2lOWnQwRWZOcVMwbGZGK2hKcDRU?=
 =?utf-8?B?dVZUQ0RMaTFGMmpJdi9kb3lBbllPNm1tUFVXZlY2N2pzYW1WZkNXRExXdDZo?=
 =?utf-8?B?TDM4cG9LUUhBZ3VURWVzNzFuRCtkLzVFQ3AzTVk5NXd2ZzhGeG1mdVN1aVBV?=
 =?utf-8?B?d21FK0gxUk5BQ1lWMDFDSCtCYURHTjQ3enVVbitWNUd0djJPZk9BVEZhazF0?=
 =?utf-8?B?Z3plSy8ya3k5QnQwTHppT0kya1VtYkdseUFubXhxSWhNWUF6L1FMZkFXbXdi?=
 =?utf-8?B?a2prSVo3VFBVejh6d0cvM2xaNkNsV1J4RGtaUUdrQlRObDFzRm9McjV6a29j?=
 =?utf-8?B?QnJXMmZRK3hlRzZvV0s5VmE3cTk1Q1FXRGlOcDU2UDBGTEEwRUNQZ09hVzg0?=
 =?utf-8?B?K1VmSjFkSXlMNXB4ekJ3bHVkMTk5NGIyQWpvUUpnT0FtUTNJVDAzWGlWQjFK?=
 =?utf-8?B?ZFJDM3FOOXJIams5ZkMyUE4xamVXZzJENjJNNVZzMGY5VnpFS1QxaFZqUzQ2?=
 =?utf-8?B?RnRuL1c5MlhjeVUySHFDMno3NXE3UHU3SFQ4Ujk5aCtFTzI5a1NUVVRPcUNl?=
 =?utf-8?B?YWd1Q0NYbzJSZXNPR2V6alB3NzBSbm1IV3paUEJwOStkMzhrQjRuQlg2NFps?=
 =?utf-8?B?ajRMTDVYdG1EU0pHTStaNnZHSDRZZksvekNBZjJpOEZSRFc0RHVYQjR6YUNT?=
 =?utf-8?B?clJETWRtb0Qra09RSThJNTZzVEpaOHgwSmxlRjU0SG1Ld050SmhIN3VCbjNR?=
 =?utf-8?B?R0xNbm9WTUIwS3dpTC9SMklFdzdDbFdraUcwMUlWSlVOK2pPNkN0b0pOdHZV?=
 =?utf-8?B?MXVZdEprU0hyZCs4YW90ZHN1SCtUcGpvQk9vMXE0SW95L0FISjR6bUNBWDBR?=
 =?utf-8?B?TmFYRTVhYjBxOTN3Q0s4cDFweEhHVHhGVWp2N2lFdW15V3hTOWRZaEUxc0xp?=
 =?utf-8?B?dXpPZnRaQmVLWFlaeU5zZStmNmcxMHB2dy9jUlVCOVdab3dVaFA2OUFnMm45?=
 =?utf-8?B?TFJHY3Q5ang3Rm92dzNtM1dkbFFxL01BVHdPUlR2eUVlc3dYZkdYdWlJL0Zu?=
 =?utf-8?B?RnRQYlpxWHJiVWFUUVNVSUE1K213YmJSVWV4SHNBaGF0RkZodnRNNmFmYnE0?=
 =?utf-8?B?eWc1UE0rZDJxWXVoMi9aN0JiYWdUd2NpcFBsMzhTNmJXUU5Za3FzM2M5bUo2?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef60b37-c4d8-49aa-0fc4-08dbf55340b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 05:30:11.9403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYk0yKQ4cVhsTwJsr3xWJbCq7CKJz+GY3G1m63hj2LJEGpFZdw6R9SsMZHuZLoTAgx7b7IRcRb1bfzOTksj7cGpIRlyIvSytvzE+L4xw39E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jIGIvZHJpdmVycy9t
aXNjL21laS9jbGllbnQuYw0KPiA+Pj4+IGluZGV4IDdlYTgwNzc5YTBlMi4uMDQ4OWJlYzRmZGVk
IDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvY2xpZW50LmMNCj4gPj4+PiAr
KysgYi9kcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jDQo+ID4+Pj4gQEAgLTIwMzMsNyArMjAzMyw3
IEBAIHNzaXplX3QgbWVpX2NsX3dyaXRlKHN0cnVjdCBtZWlfY2wgKmNsLCBzdHJ1Y3QNCj4gbWVp
X2NsX2NiICpjYiwgdW5zaWduZWQgbG9uZyB0aW1lDQo+ID4+Pj4gICAJaGJ1Zl9zbG90cyA9IG1l
aV9oYnVmX2VtcHR5X3Nsb3RzKGRldik7DQo+ID4+Pj4gICAJaWYgKGhidWZfc2xvdHMgPCAwKSB7
DQo+ID4+Pj4gICAJCXJldHMgPSAtRU9WRVJGTE9XOw0KPiA+Pj4+IC0JCWdvdG8gb3V0Ow0KPiA+
Pj4+ICsJCWdvdG8gZXJyOw0KPiA+Pj4gUGxlYXNlIHByb3ZlIHRoYXQgdGhpcyBpcyBjb3JyZWN0
LCBhcyBiYXNlZCBvbiB0aGUgY29kZSBsb2dpYywgaXQgc2VlbXMNCj4gPj4+IHZlcnkgd3Jvbmcu
ICBJIGNhbid0IHRha2UgdGhpcyB1bmxlc3MgdGhlIGNvZGUgaXMgdGVzdGVkIHByb3Blcmx5Lg0K
PiA+PiBIaSBHcmVnLA0KPiA+Pg0KPiA+PiBXaGVuIFN1IEh1aSBzZW50IHRoZSB2MiBwYXRjaCB5
b3Ugc2VudCBhbiBhdXRvIHJlc3BvbnNlIGFib3V0IGFkZGluZw0KPiA+PiBzdGFibGUgdG8gdGhl
IENDIGxpc3QuDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTEyMDQyLW5h
cHBlZC1zbm9yaW5nLWI3NjZAZ3JlZ2toLw0KPiA+Pg0KPiA+PiBIb3dldmVyLCBpdCBhcHBlYXJz
IHRoYXQgeW91IHN0aWxsIGFwcGxpZWQgdGhlIHYyIHBhdGNoLiAgSXQncyBpbg0KPiA+PiBsaW51
eC1uZXh0IGFzIGNvbW1pdCBlZTYyMzYwMjcyMTggKCJtaXNjOiBtZWk6IGNsaWVudC5jOiBmaXgg
cHJvYmxlbSBvZg0KPiA+PiByZXR1cm4gJy1FT1ZFUkZMT1cnIGluIG1laV9jbF93cml0ZSIpLg0K
PiA+Pg0KPiA+PiBXaGVuIEkgdXNlIGBnaXQgYW1gIHRvIGFwcGx5IHRoaXMgcGF0Y2gsIHRoZW4g
aXQgZG9lc24ndCBhcHBseS4gIEhvd2V2ZXIsDQo+ID4+IHdoZW4gSSB1c2UgY2F0IGVtYWlsLnR4
dCB8IHBhdGNoIC1wMSB0aGVuIGl0IHRyaWVzIHRvIHJldmVyc2UgdGhlIHBhdGNoDQo+ID4+IGFu
ZCBhcHBseSBpdCB0byBhIGRpZmZlcmVudCBmdW5jdGlvbi4NCj4gPiBPZGQsIEkgbWlzc2VkIHRo
YXQgSSBoYWQgYWxyZWFkeSBhcHBsaWVkIHRoZSBmaXJzdCBvbmUsIG5ldmVybWluZCwgdGhhdA0K
PiA+IG9uZSBpcyBjb3JyZWN0LCB0aGlzIG9uZSB3YXMgd3JvbmcgOikNCj4gDQo+IEhpLA0KPiAN
Cj4gT2gsIHNvcnJ5Li4uDQo+IEknbSBub3QgZmFtaWxpYXIgd2l0aCBtZWkgZGV2aWNlLCBJIHNl
bmQgdGhpcyB2MyBwYXRjaCBiZWNhdXNlIG9mIFNhc2hhJw0KPiBzIHN1Z2dlc3Rpb24uWzFdDQo+
IENvdWxkIFNhc2hhIGdpdmUgc29tZSBhZHZpY2UgYWJvdXQgdGhpcyA/DQo+IFRoYW5rcyBhIGxv
dCA6KQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NZNVBSMTFNQjYzNjY4RjQ2
NEEyODFBMjM5RkExMkI2QUVEQkRBQEMNCj4gWTVQUjExTUI2MzY2Lm5hbXByZDExLnByb2Qub3V0
bG9vay5jb20vDQo+IA0KDQpXaGVuIHdlIGhhdmUgb3ZlcmZsb3cgZnJvbSB0aGUgaGJ1ZiAtIHRo
YXQgbWVhbnMgdGhlIEhXIGJvb2trZWVwaW5nDQppcyBpbiBtZXNzICh3cml0ZSBwb2ludGVyIGlz
IGJlZm9yZSByZWFkIHBvaW50ZXIpLg0KVGhlcmUgaXMgbm8gcG9pbnQgaW4gY29udGludWluZyBp
biB0aGUgd3JpdGUgZmxvdywgd2Ugc2hvdWxkIGV4aXQgd2l0aCBlcnJvciBhbmQNCmxldCBkcml2
ZXIgdG8gcmUtaW5pdGlhbGl6ZSBIVy4NCkkndmUgbmV2ZXIgc2VlbiB0aGlzIGVycm9yIGluIHRo
ZSB3aWxkLCBzbyBpdCBpcyB2ZXJ5IGhhcmQgdG8gdGVzdCBpdC4NCg0KLS0gDQpUaGFua3MsDQpT
YXNoYQ0KDQoNCg==
