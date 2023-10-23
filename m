Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A07D28BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjJWCzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjJWCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B7119
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698029749; x=1729565749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TVk4AXEFhtCCR8y/7vn9dl5QUZJNwNc+J50R6kNUTPs=;
  b=iDQBlX2gvjKKPycurFCraCYXwZ3oB7DbdJVKeG2dGwmLvT9tfEV1nGWn
   hC9V3KS841hRFVTYp6Q/VzVrAUHJ6qYHTq6LMbqg7Orrf9OaRaIol1Xrx
   S8j3D3GbK9GOjDYYmNmrfLUzXSvqYGoN2zFTBV7JVuYXIJdBTHzRWhwI3
   9h5hUYgRMSBYqByOkOfiEfI2exdcsLyLdkiOHZhHsPUkuQE+8TlEMrdmQ
   8+bzzzKZTlBWB1Qs3YmJFuHPQASGFZjG6Qq8ZYmDrJJqg0mKZMb2oKakF
   iNrtkj59S/Iv92pjYOe8vTBzgAUPsg64E3HBujSvgBXKqvTCCV+ecfFVO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="366981911"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366981911"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005165872"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005165872"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 19:55:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 19:55:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 19:55:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 19:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo8BHcPk1BedsStYsiYLxgKKtsMVQ9x8O4HiZttKFu8Zw+GZrfuCa2jfUcWPQ9muoIIKXzrmcAFhP1PX0BWu2EpR0g8xb9Q37HtUJZfrWICshPBoTDCKeBICkft85kGfDJCuYsApP3s8jQ3sj2c2DevaN1Q4bMaKaexxhgVQY7deG8o6YODf/wWIF9R9qw380EZ5txRILo8D2S2o4oDktC8fq5+CFsF3l0WIU/xPnSzSof+qdYb0+qVpF25Y/rXzcH31wV2x+v3Efv6eV+OH1gMnRSPOM6wcmZ/WOnNBvhENI0vArR2W7mlyAn3jdBesnbIqCvfylBuxwr7lzRjW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVk4AXEFhtCCR8y/7vn9dl5QUZJNwNc+J50R6kNUTPs=;
 b=grzY6IfwUU51rs9Ht19rX/zgTsiYyX+xUVzvjQUOIlC7rPn8ATLywJGztFn6qd9itJ0rjia2+0PgZC9yUG83pzVYTIQxf2GwJnYbAl+SjpqZlkRNDigbh/1Ln77dVSPBYOeeS86lVgyPH4nArkSk1ihdLbX+D876hV6hm1S6iXM86tqtr203/e7IDB1Pwcw4XqsWU1x7azodSBLdlNQRVMSI72dhiEIZDj1b0lORMC7Vp3kQ9/YChFNWWE7kZqSaproE3E5ahBDi/67aHN8hCivs3So98ryqYg1IMvzseEUAL25B6tQB/vJOPWv76mGq/1e2+0e0/bYTBw0KlgcvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 02:55:42 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3bbd:f86a:80ea:eb8a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3bbd:f86a:80ea:eb8a%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 02:55:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 0/2] iommufd: Only enforce_cache_coherency when allocating
 hwpt
Thread-Topic: [PATCH 0/2] iommufd: Only enforce_cache_coherency when
 allocating hwpt
Thread-Index: AQHaA7bRh+WFYfRUVkm8nzq+NWyx/LBTdX4AgAM7WmA=
Date:   Mon, 23 Oct 2023 02:55:42 +0000
Message-ID: <BL1PR11MB5271F7BEA6187ACBD6BA88568CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
In-Reply-To: <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MN0PR11MB6086:EE_
x-ms-office365-filtering-correlation-id: 57a201b9-4b6b-4274-620f-08dbd3738bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wf6O9kvRylteR9R+2p0GM1RTb9uPh2YZeK/Oz4VpjtctQq3dA+hOHJJzvUh+WjCcnrzZtJH06RcG+YgJG5y4sk5ujLa+8yDyYCrGn80W0jA0MtnuQYVH+q+79u2ctNdSWiFHyy846ory1xlAkfcDankshTB6tRD757hfAYivlfcCvzGFCTpLL6ofAthccsnx9sKgjrirkYajsdFmgHE4pUT5bRR0MD2BK9i5XwEG8J+/a3KAuJPn3Dpn8pfHPs49I0GDo4UDQ0ZC3HxF0Xz0gUcEIzjGtuNxh9pbf1B5+GFBrQoYBau+1xRUqm14IYeW/x1uLCOqOuIeMwtzXKX/OWdpjoQpgE7lMDAU9bTXxeZq7QgAZYjxgJWlHceyxwkuD6vZSOGiRRUrLmyEADsltfl5krUA0MPQIciM0C94Z4dCVKQoe3QZ+r3SUVl+uOMilvnYzg99MZk7d0OyYrlvjhGDZe7efFTXcMdiPQvlmVJXwpNfhtX++DQMM+OPFPt5KnHER5CDg7T0HrrrcZfa7cGSov3yhOlMaTKXZxvpdVRYJTEeKjNX0IRGraqfU2SqQimCOAQeDwfcFNHpEBJYeNvmBeAJ1yVseQGEls/OM54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(71200400001)(9686003)(6506007)(122000001)(82960400001)(7696005)(66556008)(33656002)(26005)(66476007)(66446008)(64756008)(54906003)(316002)(478600001)(55016003)(966005)(38100700002)(83380400001)(110136005)(86362001)(66946007)(76116006)(52536014)(41300700001)(8936002)(8676002)(4326008)(38070700009)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHY4QnJ0R0d6RGNoNnNkellxbVNMeVNhUHRoZTMwWElTZlZWNWNsR0dPeCtY?=
 =?utf-8?B?UENqZ20vNWJjemN6cGdubUtmWi91N2U4Nkh6WnhZU3BPUmxXNTIrNHV4V21j?=
 =?utf-8?B?MlBob3AyeUdzV3hhaVNLL2I2Zjc2MjhuMFVoVTBtajR1dUFQd01wWEdOeDBm?=
 =?utf-8?B?SWFsbU5vMi9FeGtHZkxLUDZpa29yR0hydlI4eFh6cjQ4U1I4dktaYmFHTk40?=
 =?utf-8?B?K0xvTEt1NWtCT1NHMXQwdnlVWmJYTlRUOHZRUGhDR3QzNVpialN1TWZvL0VV?=
 =?utf-8?B?WFRGVDNtZm5aazFCZEkxZnJud1ZXWjR0UFcwS1AyTFhjRytCdGQ5OHlqUzd1?=
 =?utf-8?B?eEVONWt4bldqSjZ4K0E0NEtpSSt5U0d4Yk1NdGtCcEZwdTkxTTdpZEZJeFFL?=
 =?utf-8?B?bHF0QlYyV3ByRWl6aUU4c1ZObHZZZXhBcUQzODlzK0NDQ0FwU3dDOE03RWhn?=
 =?utf-8?B?Z3FZeWFDWHM3R0pCRXdiZEF6amNtTXVJYkJ6SEJCamNTZkVOaUFBa3pZeUhN?=
 =?utf-8?B?OHUzWVNvbTZBSDBVVFhGK01FZGo3SSs2ZVpoSXgxL0taS1RpcGtIbDZCcHUv?=
 =?utf-8?B?WnN0ZmxrV1pCUkdYc2trczh0QWxqZWhYR1U1YnF4b29DenlvL0tFelRSTWk1?=
 =?utf-8?B?NG9FcjNENGRObGhQOVE2L3ZtazNhcHRoVUxianlwUVZlQ1dOZjdoL3V4WUF4?=
 =?utf-8?B?bGdtWk00L3o0UElDaEtvUWtrNlAyU3ZvYU5oZW93K2I3c0NpUDFvcnNycGVJ?=
 =?utf-8?B?M3Z4UHkwL2RETXVLamlZbkI4VW1keVFJdE9WT0wyd0hRYzgycHBGSHVoSHlB?=
 =?utf-8?B?bkx3VDhxT2VGcVc4akxhRlV4MXc5WU9vdzNBQ2tSVEcxU05ESnBXNzNIcTJT?=
 =?utf-8?B?U2tyZWRvSkpIK2FlUnA3VGdUZlUrK2svMHNPQVdnbTRmYVpmZ3phQUgwL0VI?=
 =?utf-8?B?bGtNL3luMHNCQzhrLzRPOENNeDdGOGVROE5yOFlHTVRoQ1NBWHV3Z2c3bGc1?=
 =?utf-8?B?dUJ0bk5RQ3EwcnhCYkZuRjBEMWl0ajBuQ01lWnF0M1kyTDVUZTBZVTEybm5Z?=
 =?utf-8?B?d00wU0ZlTVVnSjMvWWN1TjZZNlk2SHlqODlHdFJYZWt2elh1VGFQNDlvQjJw?=
 =?utf-8?B?NzdTNnFnN3NHMXZ3MDVXcnUvcGl3Wmw0MGRDeGVRdnJCeDE2bFdKeFhZaTlL?=
 =?utf-8?B?YmpCV05xY3ZSRlhseTlVcGdIS3JESXBUTmpHS0pZVzcxcEZiVUZFQmJQNWFM?=
 =?utf-8?B?dm84ZDhSQS9aeUdRaTUwbmEvYjArMHd3Nk94ek05WVdUa1J6TjhlaVJYWHNw?=
 =?utf-8?B?N3h1TFNZWENpWjdSQlpROHk0N290aVh1N2J6TVlpZmtJNzhhK2kvZG5wWk94?=
 =?utf-8?B?TXRPSzJtZitiZnRUNVRhTWNQOVZzR2Vha2NmK1dtQ3ExZzlaWGo2TjZKYSs1?=
 =?utf-8?B?bDVtdUxzYXlUaHNhYXhBSWREdHEzVFhTM0diM2FUZkdWUUtyY1JDbXBPN3J4?=
 =?utf-8?B?OVh5U0NSYXE0YldXMEpCZENDWU1RcjdNUE50MDRjcmFpUkt6ZHYzbUxpZEZJ?=
 =?utf-8?B?MjhDV0FBRTF2Zlc3S3dXVlpyMUdGSEx0TDJkUXJHdHY4MU5RZ1llYXFuMjhI?=
 =?utf-8?B?TEh3OHppd0VDV2haa1lMZko1ZVJjOFhYN1o0eklKK3dKVVlWMmdRNDBZS1JH?=
 =?utf-8?B?ZlM5T05pQTFwMkUvblVIRktPVXpXdE0wMGtlb2I4Z3BISHpwSjg2L3F0Qkxm?=
 =?utf-8?B?YjVacEtBY2h1VFEyazROOG12U2VTMy9KV3BsS0FLN2JXS3lzSzVTdUE3N09I?=
 =?utf-8?B?TVpOWTFRTWNYemhyTlR6dUMrZE9RUTQwTEg4UmwyaGw2YWZwTEplYVVyb1NX?=
 =?utf-8?B?SGxCVEVac3pNUjc3MFpNZ0tOZlB5V2FFd0N6eXhrMjlMT1poMmdIcWtZMW01?=
 =?utf-8?B?cEt6L0xubThRcU5YQVZnQitrYkVqeXhTeE9OL0JwK0Jyd0xNSjBydllQVkFm?=
 =?utf-8?B?WGdlTVcvbTVVVTArOS9YSDJwQ1lSWFhOcU54Qm9ldmZQY043MEZqWE9aOEpu?=
 =?utf-8?B?RW9kcm5mYW04WUVaZDdVdmdFdUZZdzdaNFk2dHMrNzZrUHAzcSs3SHJLeUVa?=
 =?utf-8?Q?4uOibXzx2jwdDRZUdkX8EImci?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a201b9-4b6b-4274-620f-08dbd3738bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:55:42.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mgrFWvWQZkDwR0dGFxfPKM6815IVg8vQ4N/uWiwsxJFaoipP4mN5JJreD1iHxNWkaQdemYIAmNan4etfJta3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgT2N0b2JlciAyMSwgMjAyMyA5OjMzIEFNDQo+IA0KPiBPbiAyMDIzLzEwLzIxIDg6Mzcs
IE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0N
Cj4gaW9tbXUvMjAyMzEwMjAxMzU1MDEuR0czOTUyQG52aWRpYS5jb20vDQo+ID4gVGhlIGNvbnZl
cnNhdGlvbiBhYm92ZSBjb25jbHVkZWQgdGhhdCBhIGh3cHQgc2hvdWxkIG9ubHkgZW5mb3JjZSBj
YWNoZQ0KPiA+IGNvaGVyZW5jeSBwZXIgZGV2aWNlIGF0IHRoZSBzdGFnZSBvZiBpdHMgYWxsb2Nh
dGlvbiwgYW5kIGl0IHNob3VsZCBub3QNCj4gPiBiZSBjaGFuZ2VkIG9yIHVwZGF0ZWQgaW4gdGhl
IGF0dGFjaC9yZXBsYWNlIHJvdXRpbmVzLg0KPiA+DQo+ID4gQWRkIHR3byBwYXRjaGVzIGRyb3Bw
aW5nIHRoZSBlbmZvcmNlX2NhY2hlX2NvaGVyZW5jeSBjYWxscyBmcm9tIGF0dGFjaA0KPiA+IGFu
ZCByZXBsY2Ugcm91dGluZXMgcmVzcGVjdGl2ZWx5LCBzaW5jZSB0aGV5IHdlcmUgaW50cm9kdWNl
ZCB3aXRoIHR3bw0KPiA+IGRpZmZlcmVudCBjb21taXRzLg0KPiA+DQo+ID4gTmljb2xpbiBDaGVu
ICgyKToNCj4gPiAgICBpb21tdWZkL2RldmljZTogRHJvcCBlbmZvcmNlX2NhY2hlX2NvaGVyZW5j
eSBpbg0KPiA+ICAgICAgaW9tbXVmZF9kZXZpY2VfZG9fcmVwbGFjZQ0KPiA+ICAgIGlvbW11ZmQv
ZGV2aWNlOiBEcm9wIGVuZm9yY2VfY2FjaGVfY29oZXJlbmN5IGluDQo+ID4gICAgICBpb21tdWZk
X2h3X3BhZ2V0YWJsZV9hdHRhY2gNCj4gPg0KPiA+ICAgZHJpdmVycy9pb21tdS9pb21tdWZkL2Rl
dmljZS5jICAgICAgICAgIHwgMTkgKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgZHJpdmVycy9p
b21tdS9pb21tdWZkL2h3X3BhZ2V0YWJsZS5jICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvaW9t
bXUvaW9tbXVmZC9pb21tdWZkX3ByaXZhdGUuaCB8ICAxIC0NCj4gPiAgIDMgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IEhpIEtldmluIGFuZCBK
YXNvbiwNCj4gDQo+IFdpdGggdGhlc2UgdHdvIGZpeGVzLCB0aGVyZSdzIG5vIGlzc3VlIGluIHRo
ZSBpbnRlbCBkcml2ZXIgYW55IG1vcmUuIERvDQo+IEkgdW5kZXJzdGFuZCBpdCByaWdodD8NCj4g
DQoNCkJ1dCBjb2RlLXdpc2UgaXQncyBzdGlsbCBnb29kIHRvIGV4cGxpY2l0bHkgZGlzYWxsb3cg
ZW5mb3JjZS1jYyBvbiBhDQpub24tZW1wdHkgZG9tYWluIGlmIHRoZXJlIGlzIG5vIHBsYW4gdG8g
c3VwcG9ydCBpdC4gSnVzdCBubyBGaXggdG8NCnN0YWJsZS4NCg==
