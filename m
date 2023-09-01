Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8578F654
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbjIAAQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIAAQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:16:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B190DE67;
        Thu, 31 Aug 2023 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693527378; x=1725063378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d8cEpFu8AiKmCMUw4GnT76Dwnk9mQE3uIUGc+hWI5v8=;
  b=h62CNg7G7CwOypx8lc8ID2/rMZUshopsVd172NRxmw6c7ALDjsUTofr5
   djxNSAv8cK0izAqqIShnlAGjTdRRuxP3NWyMGSNV+iGfdQvXcahum0kNL
   wFOZPN9o5CPA/oJn7bBmwsYsCmejyZlAT8Dm9VR3okjhKykaUI9vGQLOZ
   x06BfkV0O01qjU8xi+iOR7krr0Ed8pUbpENZO0DyntwiZ9O6c+DZMeHCC
   yxWAgvS/QEf4+5+eeLJpncWte6LZLB8Qko9XW+t/0mEsFUXJXh7chmZE4
   mHzvHwI7nyzOx8Ebz/+qrlbZEiyoUF478yUqJpD0BCadfFjVLDDUCsFj3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356414029"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="356414029"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 17:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="774795754"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="774795754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 17:16:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 17:16:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 17:16:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 17:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkKiNe7My+z4R+ayax6xx5XqitMewbE1cCc7E8u+7W7BNV5vyemr0R9kGSZwZefxcK9ZCa3q1+kjE3gP537YfxaDAI66X7/E5bLj2St7ZTnfQQUtlopDrnsYn2JeEyjGSSlLXxyAp49+fwbhMNWFquWyOD3sfffxX6zkwd3Mi8dwXaGLppRwORiT6d9AzTo/eAK8ZYqhc1OY1oi1AMwrVhsgbiQag5JcSDnDYD+JvVBkehFjGKEhrPmO0srmbD9lwWnIUIHRel7w0EGrosKn4148h63Pg+OM9CI04swUxR8vNd0X8Nu0sg4nQaJGCoQtQ3Rh/Fr/YvpAQKXbH08bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8cEpFu8AiKmCMUw4GnT76Dwnk9mQE3uIUGc+hWI5v8=;
 b=j55IAgg0fIP8WKWDGIBCKNir4s8LKhEf7xNF4XAPg3wNrMNP6NQs5GwQh83GekN/C2LOEgNRl1aXhdfYVw10wBviwxY8pSCkFYOBi7Hq77f6KRKqamqGrXgz4eDlQ1nsX9MzgLjN78GCBl/Gb5+2UTwiUSAstsayJMl7oAL+I2FDo5kdbjUu22KZBa4ttLpmo/hdnhpPo+XomMIppznrQgFLkcFeP4djBGSv62c40g4odC298mWJo+aSQPg0MgDl11sTmYJM/SmyE4JQGSW6C52PtP5y0gsfi5P1cPFlV8I4TAYIceY0PN2SSEGGKkKG+x5iuC7l1sYIFdU1lhs1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 00:16:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.022; Fri, 1 Sep 2023
 00:16:04 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 08/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Topic: [PATCH v5 08/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Index: AQHZ3BD+2VzxzHuvHk+Rb9VXHpJD97AFCVsAgAADjACAAA3zgA==
Date:   Fri, 1 Sep 2023 00:16:04 +0000
Message-ID: <78a775310efdd4c0f3505d6b18788408b3a2ea4f.camel@intel.com>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
         <20230831134144.22686-9-jo.vanbulck@cs.kuleuven.be>
         <c68971b3b9d4962d30fed845e8796ad028a65a74.camel@intel.com>
         <55ef3859-774e-1bd3-0e2a-5105cbf0d33a@cs.kuleuven.be>
In-Reply-To: <55ef3859-774e-1bd3-0e2a-5105cbf0d33a@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB6564:EE_
x-ms-office365-filtering-correlation-id: e6ffb93c-ab89-4799-5b45-08dbaa80a16a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k80ZsyaChOzaVoVtiTTMmnxiG3210Nb1u9Zzwjk+wqEx/DjU4PWIBM94rfjlt3HWkPmXMnBYo4EvqUTteuA4QViwBzglfX3PFjR9GYST2fWuh9js1yh882PqjiTk3PnJ9SGAnxGAoKi/7yJknqO3MXP/0207TiHD81l3sKZjMuTx2cYQJkJr30/H0aUgO/5/UbC5fKO4w2rPDvRt9WfrdZ8WSXHDr3qxukHNROp1A1ywbz19D00rZ2Uq3O2A/csahWVlK9j/2ll7/BR6QgL0R+yL5Aat6MOXh8UVP3dHPh/JOeeQeqClXgCgmpoUZqkQ6NuNUG3O5lqn571ZN12herF33VBrIb/ri7HcR8SJpMo0t1Wc97uS+bsQRH6ehKhF4j/rZ2CYrHiyU9/PPFvL3Hvramn2Rp0LZTWQlJg0qpMCbQ960gu5/q9wriUsg7QWfw0sk7IwITDtYtmmsoCRfxNhswV5eqLZNO1QlKwLsh1CgaQcX7BLPARxZQu4tXHFZwaLLlb6aJFGUJdzxPdUw2+hToHjWD0CqT3xOt/d+r/QwYURnH9MsHkBnKNXRtmqaxUW2jiU/BZIvfU4Hoo+E8DJO/G96H9K4vVhkATHvzu1rvsTPS6w97JLvrqP9Ow
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(478600001)(110136005)(53546011)(76116006)(91956017)(122000001)(66946007)(66556008)(6506007)(64756008)(6486002)(71200400001)(66476007)(66446008)(38070700005)(316002)(38100700002)(41300700001)(82960400001)(6512007)(4744005)(26005)(83380400001)(5660300002)(36756003)(2616005)(2906002)(86362001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFZzK2ZtZlVuckpYc0x5VVZ0a0NleWRxbzA3dG5OTHVJODlRTThMTEdWSSs5?=
 =?utf-8?B?TDdsbG15S050NTFYeG42ZlNzdXhSVEFLWnp2M1haVzdxVXViaFB3UUU4Mk1X?=
 =?utf-8?B?d2Vud0p2MDBJR3RtOGJwZnZUM0xMa0ZVbG1XbHhaWnM4aVlKeHFtbzFvT3ZG?=
 =?utf-8?B?dDlydnZNT1l6UytrNnFtYVNHeThMd1EvTFg5Mnpzcm84ckxmK3NHRFplNjJG?=
 =?utf-8?B?WFh1eExTMkZnMFVDTWpwelpTbmpsaUl2MWZYay9LTmdQbFVtQ2Zja3czd3BT?=
 =?utf-8?B?VWZpcjN0MHA2QUNiWWFZUEkrUlVmRTlyczhaQytrR0R6WDFKU3E0NEM3UUJR?=
 =?utf-8?B?aG9FZm1BTXF1MFgyZG53aE9RZm9PVGZ6REIrbkJ2b05jemZOaWRWNjU2T3lv?=
 =?utf-8?B?Q3I5NFlvYWVIY1pxMy94WXd4cURaRnNhQXBRblArb1hNbjdUWG9pV2JmaVRL?=
 =?utf-8?B?cEg3RmFrTzVjYyt3N2Z2bUtrWVR0ckJ3dW1ZcDllYVViSWk1R1NXaEdlb3I5?=
 =?utf-8?B?ZmpNanowUmFBQ0FOU1pYNVE1N2J6aHpTTFJjY0xOMmNQc0JIdXh4Q2EzVjd5?=
 =?utf-8?B?empnQnRVcGNRL2VmOW9kVit5OU9MT2ZoYlFXajNjU3MyZEFFcE5nV0lFRlhu?=
 =?utf-8?B?bkg4VmdYTXdVd2NkVnB0Tk5oWndxTmVrLzZ2WVVrY3VVbFUwNlRvcDVIL05j?=
 =?utf-8?B?U2M0ZjR0WnEwQ2c0bkxTczVFREpLVTZ0L1JqWGttVmcwVG1TcmtZM01FM0lV?=
 =?utf-8?B?Y0FzYjNBSHQ4SUd0TzRiVWM1bEVYaExZSWdmUGEwRnU0bmJGdFFzajdla0hH?=
 =?utf-8?B?L3ptekU4Q2R1dVI4TEd6Y1VZZ0s4R2JkUjZlNnhZdU9KVExUK1pwcGFIdHg0?=
 =?utf-8?B?YmFib2M2elIwbHhleiswTWI4US9hUzYrK0Vrb1JKZjRmdUhFTHBFZk80T3dD?=
 =?utf-8?B?UmFtNnJTZWR1ejVaOHdqeXowSnk0ejVRMk1VQVRUY0ZIZUpOdTh0blNuSXdN?=
 =?utf-8?B?NWNSanphbDc1eDYzNzR5QVMyWHY4Wmp4cy9XM1NDZFFkbFRRZ1ZYcVlTN1k1?=
 =?utf-8?B?c21VR3RvREhXOHBoVkdUaVhZTVpQQjRDb000RFZ2ai9TOVFoYlhSOWxtcmRS?=
 =?utf-8?B?dSttazVqNnc2OUNrTzU1SDByMCt5TGdkbXlZTlZzSTQ5U1M2bGtKeVkxMTcx?=
 =?utf-8?B?VHkwU002S1FQQkYreU9QM1NmY1VUVjUyZ3lVYS96MFZoWm16Wm5XU25VRUw2?=
 =?utf-8?B?UWJZNFN1Qk9MWXgrRk1wWXJKMytUM0Rib20xQmZNUHpYS1ZPL3ByaVB3WkYr?=
 =?utf-8?B?ZDlLK2tOSmdsU0V1bDVROElERm9QR0lJbTNGU2FBRGJCd0pjencvU0VqNldK?=
 =?utf-8?B?VGhxMmxmUzNaVUlLZXdsZkNuQ1ZUTU5iOXU3ZXFZWXNjeGpXTFRTRFZMUm9p?=
 =?utf-8?B?OU1yejQxU0pmOTExR042UWY3bmh3NzVzRXRKcDdTM0ZlRERGcmR4MFR0RDlK?=
 =?utf-8?B?VklHZnY3dGpOYVpkZUlQK3luR05lamNkTjZPVWd2aUplNFNLQW9HUUZYdEFL?=
 =?utf-8?B?Vi9wTHJCVWIyVFhIWTJzZ1EvYVNkTk8zcEhyc2VOR3ltemUyM09vSlh3d2hv?=
 =?utf-8?B?STUydFJMaXFMU21xRW44ODgrL01XZ0VLUlQzNkVNZ2dacXBvczVuRy95cmlJ?=
 =?utf-8?B?czFsc3VheTVwTmJqaCtvaFVydXRKVDhXZDRpMEtjNjZGTURySjFTT3Q2aDZo?=
 =?utf-8?B?MEh0Vm5CWjdoamJIYktvS2RPeUQrMFpjajBReFNMenhWZ3cybkgxQ2hvYTdj?=
 =?utf-8?B?YXhjTFNLN2JRc0tRUmYwNUptK2JONVJMQ1QvSUVMaWt3V2lHK0U2U3U4eHhl?=
 =?utf-8?B?NXNIbW80b1VrbkdTL1c5OWEwMUIwazkxTmkvYWRXVmloc2pIc0JiTDQ0T2lF?=
 =?utf-8?B?LzRsV3p4YVJ2VEVFaGFBVEJOZXlqMTBpR29lMzYwOEZlTi9xeDExYmFPcFRl?=
 =?utf-8?B?ZGwzTmh2aW9VU0lvaEFBdmhlQlVPTnJmMlhMSEN5VTgzdnZ0ZjVTeWNYMkNa?=
 =?utf-8?B?RjZCdm9RVnFBOG1oY1hCd2libE9KUm13eGpJaGF1TDBvOUl0MkRGTE52ZlZl?=
 =?utf-8?Q?viO39qJd1wY1/0VtWJh4B8G5q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DA8595E7F4D0F43B5792F512EDC1C1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ffb93c-ab89-4799-5b45-08dbaa80a16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 00:16:04.3445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz6/oEnxqcy7J4HrYK4+gfdYu6YwEWaVJX3E6CXK0nHpKFAt4v0qN/li9P5ZkvargZFTViy4l6gzIcdvAuUUPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
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

T24gRnJpLCAyMDIzLTA5LTAxIGF0IDAxOjI2ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IE9uIDAxLjA5LjIzIDAxOjEzLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gZW5jbF9ib2R5Og0K
PiA+ID4gICAgICAvKiBzbmlwcGVkICovDQo+ID4gPiAgICAgIGxlYSAgICBlbmNsX29wX2FycmF5
KCVyaXApLCAlcmN4DQo+ID4gPiAgICAgIGxlYSAgICBfX2VuY2xfYmFzZSglcmlwKSwgJXJheA0K
PiA+ID4gICAgICBhZGQgICAgKCVyY3gsJXJkeCw4KSwlcmF4DQo+ID4gPiAgICAgIGptcCAgICAq
JXJheA0KPiA+IA0KPiA+IGNhbGwgKiVyYXgNCj4gPiANCj4gPiA/DQo+ID4gDQo+ID4gPiAgICAg
IHJldA0KPiANCj4gR29vZCBjYXRjaCwgYnV0IHRoaXMgaXMgaW5kZWVkIHRoZSBjb2RlIGFzIGdl
bmVyYXRlZCB3aXRoIGdjYyAtT3MgKGZvciANCj4gcmVhZGFiaWxpdHkpLiBJdCBzZWVtcyB0aGUg
Y29tcGlsZXIgY2hvb3NlIGEgSk1QIG92ZXIgYSBDQUxMIChhcyB0aGUgDQo+IHN0YWNrIGlzIHVu
dG91Y2hlZCBhbmQgdGhlIGNhbGxlZSBjYW4gaW1tZWRpYXRlbHkgcmV0dXJuIHRvIHRoZSBjYWxs
ZXIpLg0KDQpBaCwgT0suDQoNCkkgdGhvdWdodCBpdCdzIGEgdHlwbywgYnV0IG9idmlvdXNseSB0
aGUgY29tcGlsZXIgaXMgc21hcnRlci4gOi0pDQoNCj4gDQo+IFNvbWVob3csIHRoZSBjb21waWxl
ciBzdGlsbCBlbWl0cyBhIFJFVCBhZnRlciB0aGUgSk1QICh3aGljaCBpcyBub3QgDQo+IHN1cHBv
c2VkIHRvIHJldHVybiBoZXJlKSB0aG91Z2guIEkgYWdyZWUgdGhpcyBpcyB1bm5lY2Vzc2FyaWx5
IGNvbmZ1c2luZyANCj4gYW5kIGNhbiBzaW1wbHkgcmVtb3ZlIHRoZSBSRVQgZnJvbSB0aGUgY29t
bWl0IG1lc3NhZ2UuDQoNClRoZSBSRVQgaXMgZm9yIGVuY2xfYm9keSBpdHNlbGYgSSBzdXBwb3Nl
Lg0KDQo+IA0KPiBCZXN0LA0KPiBKbw0KDQo=
