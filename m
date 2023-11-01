Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58E7DE917
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbjKAXnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbjKAXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:43:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55537C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698882195; x=1730418195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Yh4fXap/BCqnaP4PO3UufdIs+YQkLkZQY+Zlk44Fys=;
  b=fNGUR05d3SlMlorIU/IukZ3iQB3Zn4Ol4Kn30odI/dVphhSKGNGQ9Teb
   9YYw+c9yXMht0YqlWWJ0x0AJSWfvNzCW3kCZLrc4lD9cPZihCtFiPKrYV
   QoghxudFXy1q4c2D8fyQFQZtPSGJKz8TRAHEM5kjWYJLpidhpzutFBVAT
   IknZqPkfaZo7cVDMQNze1qiVZ8mUgTqTymETm4Mcr+WaTvGTYvnHseFI2
   30cg0OBeDPGNscHccY/XfHMo/MZhutsqsGKi73Yhxj0UglgLCVR2fKXKH
   gURTC8VhjjebWaGa/2P9XaDmafvUOW+U4U6gsXBIuLq2TsI6YHVha8Cui
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373645673"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="373645673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="710956086"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="710956086"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 16:43:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 16:43:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 16:43:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 16:43:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 16:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwyU85pRKEAyVLRIgIv1+Du/UorJLvcR6MW/mz5MksB8egKe3A5n0/pKBgr1EwXUHvlFVK4GLdozZ8l7V0YMlZmG7jZqEizaSauVtVduPC5DFBn8f1JVj2MiSh5TQqbRwQlnL3X7ATr8kMOJntxdnXLSDXhy2l16Rx3t9fAfhTSTdU5Iz59AbD8L/tsE8xuhyDxfcYPHtbxBccB+8gUsnsf4ZMXWwTz09BlQ/TLpdhmZ4/rSOJpOfxjLp88zmGmLcAz2u5nk19wgmYMEMwCnJnwsxTMHgRh6GpxMzFU9Rw/WuBARCdMHWmMMBmEk0EFIw8v5n+HHLxBTlUJbN9T1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yh4fXap/BCqnaP4PO3UufdIs+YQkLkZQY+Zlk44Fys=;
 b=h6dpDuzObH/4Z24FqDwBQN/8J/NYwZbtouG4jFgcEnMg79F9BbH0dIKwP+gQ4Iu6rW30je+4N/GUGYSrwmGfOSeNZiRjC6xNrCNRpKsq1NO44zTkjuaLFXYA4X6bDGvMDfd7Z3QLlbdIFeTUiUNx7F2zN+1PletTD+F1VwDb6flnsA25T6ppJkpbwAGnzvbLNQcalsB6RjsgJcosEmy0SJtTXp2S99jvnuf6s46NOalhOWljRP4utkFDNUjtvURGaztGiBDmA0Oqs1/gvBmFx1JJjJQ8cAPgRYoc4Qw00iKDidEX94rGU+O5IiTse2A/GgnsiMoml0fHot6QlMIF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB7278.namprd11.prod.outlook.com (2603:10b6:8:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:43:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 23:43:06 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Intel TDX entry
Thread-Topic: [PATCH] MAINTAINERS: Add Intel TDX entry
Thread-Index: AQHaDRvXyuM9KCBFrk2g/qSHEC80K7BmIBgA
Date:   Wed, 1 Nov 2023 23:43:06 +0000
Message-ID: <9cfd38b33bcb234b6d3c84d24716fe1b7bef6e95.camel@intel.com>
References: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB7278:EE_
x-ms-office365-filtering-correlation-id: 6d60863b-5afc-4c28-113f-08dbdb344c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdJUAl2xg8dgNxZ5n4HIRLy/o/aHc8msx55FVkLgrw88jb++pRl/6I4aY6NlWCnbRfHL8Px0+acKHynm52UUhOJq1joqOrWJTJ/Rb6JNo6bByrCHMh+hTfteB/z6MOYF3/dRRKyAbV6Pv4+9yp7VdbXyiI0TZY62haJRvm3N3QvSQiKh2S8gIrCN/DOzxQ7cyQrNgEj80qibC9KeQHHcYI99EGYhVAjpV+9gXsJsyfv/fJE9UO4EpP9MKAlW6YaNKLQu5frng2kekh/toioqZJLixweBUDHEZ47AEDS6NbNUUiz/V35h9QF/6RHDDcMo+cjAjlHoLbHbyc11FkQr5mPynLiS9plumgztylZFb4JC0FALNN5SIXI6Jqq8C2zDtLJe0Us9p4ALjfTOKeRRwmYEoT5eLODBQtaeQZYehEGJDwpGT2/ZFpkNlaJm2f3ZWWR+Ppk8xDPXAFsBZTzjOaTJDQHdGZub+ccUK3lhXRsUwJTWHtiec10FZi0PuptXAih/kC6KDsBXKd8/Knrh9UNIp+/g4HiRG1scFHhi2tWAnrqLF/YE2o/GH/fPCJFfH2tC1peI3Vs+ty6Oau7yT3TJ31GmgmIIwyLFf9stfd95pBukcns/Ff5yULz0I20B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(5660300002)(8936002)(8676002)(4326008)(2906002)(6486002)(64756008)(66446008)(66556008)(66476007)(316002)(66946007)(76116006)(36756003)(26005)(86362001)(478600001)(38070700009)(2616005)(71200400001)(110136005)(91956017)(6506007)(6512007)(122000001)(82960400001)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3ZENnM0M0VOL0IrVjR6UURQcmh0VGFQUE1GMXhJV3E0YVlEQmNkSDN0bmkr?=
 =?utf-8?B?K2NXQkRJckdOVGtGMnAxNUZpbXNTYStmcmRCTU53YkpBQzczQXJVWXhISGN2?=
 =?utf-8?B?dHFkSDJmQWFWdnVjNENjQnlGdnFzZGEyYytVNzBQU1dpTFRUbStTT1UrZS9a?=
 =?utf-8?B?VUxjR0g5aE0zUEJ4eUdUKzgwKzgyTDRmUWFzN25MZm1xZk8zQnJHdzIyUnFU?=
 =?utf-8?B?azZXa3FLN0xQaWtmZDk5eS9KL2pvK3lndmcxODRSVUlRMFNtWnE2ZmFHdmhh?=
 =?utf-8?B?VXIvaXFnNVp1M3RHTXFSS2RNeStrQjlUc2NYWGttbGcrM1RDVStUWnNKaTZL?=
 =?utf-8?B?RlRWaFh0bnpsNXFraUFTb2hsUzlZTDBzeDRQR1BCS3VScHc5bEY0SFZSOW10?=
 =?utf-8?B?aWtuZXBKSnBBV0hTb1hxZkxObncvUDFmdWt1RC9qZDcwTWlqcjVUclYzOHo0?=
 =?utf-8?B?ZFRsSDYrVFZTSE1SeXhJMWZnZElFZkhFeFFyWTN2TG5tZnFjZlBLRTdVUXFo?=
 =?utf-8?B?ZUJIYjhyRVorUjI4RkU4NkUvQnFGeVNmTW1CR2xYY0lKenF0RWpaakpjeHdG?=
 =?utf-8?B?UURKNjdCRUI2NXUyVlRsb2tiNm5vZ3ZucW1QYXA2UzV2dGZjcGs1RlZDRVNY?=
 =?utf-8?B?NDQybXBZWVRhU0xULzBmL0VrcUtQaEN1cmt1VkZuYnNPaDhkcW80NzlEWjNz?=
 =?utf-8?B?K2kyWGVMRnlkOFMvSitSK3prditDWVRVSnBObHNCQ3ZqYlBiSThsTU5qQVgw?=
 =?utf-8?B?cmlBcnZuR2RrdHpRb01ubWhTNkMrbjVKb2x1R1dFQlAvNXFPOXVadDlnOGhN?=
 =?utf-8?B?SHpteFBvL2ZtOU9vSnIxR2I4Z0xWZ1VCc2ZIRkFUS2d1RlZ6WGtpdHdEVXNW?=
 =?utf-8?B?ck5FMWhaWERYWFFxNm81YWZaT1QwNXdKUi9ucDA2M3FjM0c1NnJzeXNuL3Ri?=
 =?utf-8?B?MExENnRQZ1RDQXd1Smt6OVdmOWdIVDVFTjlpMy9BVm1QNyt4enpEOG5MRzBt?=
 =?utf-8?B?R2RXcEdWQU5uYjV4VFZtWU5UUnVDU1NZaUo3QXlFak9YRm4yMkZoSmRjWWdT?=
 =?utf-8?B?VzFSajFZNUpvcmZub3owZHNwTlAwWXJ4L2t0UWt4c1BudkdvUzZUVEFOUW1X?=
 =?utf-8?B?RGtQcjRlRmVVMkJDTm5EVDBtb0lsUUE2Q3JJTndKVEVaN3N0UFJkSnJDcmN3?=
 =?utf-8?B?Z2pSakdpZnBNazVIZk1RNUxneXRHUjJCMlp1UVdOeUZObjlvSHkrMUJKRXg4?=
 =?utf-8?B?RUlEb1ZYekpicmp4ZDRKY1FIWitXdW1OeWk0NlFBVHB6TVpKNlc2SXZwanZO?=
 =?utf-8?B?L3VxcVpIeTNGMFJzYlFOS2o4WjFpbUs4VnkyempMTTg1eVZlZUZQS2hIV1li?=
 =?utf-8?B?a2FWdGY4UGxhOFl4TzJwNXkzQ1dLL2ppY1VxTHg0MmtCaUNPS0xTRmhnLzZS?=
 =?utf-8?B?QklocG1FRXoyanBkTTJ0VFRyQmhsLzlDNmVEMU1wTVRzRjFaL0JMNWlMZm05?=
 =?utf-8?B?a25kaDZzdzY5MVZZVXBaaGVyeDZZN0J1R3pTTHFaOUN5bnZWdnFKZnlTY3I3?=
 =?utf-8?B?RzNEaXVuOEM3ZHlBR0Y3V1ZVRUtURHhWOEhxWmIvWVlMeTJkTC9jZDZVbjNj?=
 =?utf-8?B?a25JWlprR0FCeGdGTC9iYTlmTlJJZUpaOC8wZCtCKzBZWXl2NytQOEdjeklN?=
 =?utf-8?B?NWtacyt4Q0tHWlFscUc3TUFlUXdVS3RMdkJ1cktmTFRmQm81d1pDWjhjaHAz?=
 =?utf-8?B?K0k4Tm9zQjVFN2lJWkZhYmlOcHRxanByeFZpK3V5WHFoOEJ2Y0Q3ZDZUcXhL?=
 =?utf-8?B?blRWQnhvbDlGVmlhS2pRT1BaZnBtdHhGdkp4RmwwUUtQZ3dpS0lTNEtZbk1B?=
 =?utf-8?B?RG1sN1Q2S0J6elZMWmM5Y2k5MVZnRXhiZVR6czlqM1hJTmVheHRGWW53cjFN?=
 =?utf-8?B?MGNXT1pvTEVnU0daK3kwdklCK3NzRWtpOVhUbTVSdTJnSVlmU1hsL3pQc3lM?=
 =?utf-8?B?NGovRjdtMGZOcGkyaGRhb1VqWElkY2JFSVpoZDVLUmY0bW5GUHl5eStPSUxS?=
 =?utf-8?B?RisxNTQyUTY4ZE9HdmxYa05XT1p2Q1hkNVI4b1lnOHlIZlAxZVJHT2k0UCtF?=
 =?utf-8?B?ZkxNTHVQenBjWk1jeVVQR0ptOTF0QnB2RUZORDJja0dKTFNORk12M1dSYStj?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B12020E3D3A196429BB3C56D7D0CC61E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d60863b-5afc-4c28-113f-08dbdb344c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 23:43:06.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJcint5qZqmISUNNPn5ed4dBKI0Um/CMIMk+w+xhw6kQX3IUKYyIaD8Q6WQ82CZhb0f+uYiSV8bLGAKup4nCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7278
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDAyOjMzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFkZCBteXNlbGYgYXMgSW50ZWwgVERYIG1haW50YWluZXIuDQo+IA0KPiBJIGRyb3Zl
IHVwc3RyZWFtaW5nIG1vc3Qgb2YgVERYIGNvZGUgc28gZmFyIGFuZCBJIHdpbGwgY29udGludWUN
Cj4gd29ya2luZyBvbiBURFggZm9yIGZvcmVzZWVhYmxlIGZ1dHVyZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNv
bT4NCj4gU3VnZ2VzdGVkLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMTIgKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJT
IGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNzYwOGI3MTQ2NTNmLi4xY2JlYzZiMjM1ZjkgMTAwNjQ0
DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0yMzQ2Niw2
ICsyMzQ2NiwxOCBAQCBGOglhcmNoL3g4Ni9rZXJuZWwvZHVtcHN0YWNrLmMNCj4gIEY6CWFyY2gv
eDg2L2tlcm5lbC9zdGFja3RyYWNlLmMNCj4gIEY6CWFyY2gveDg2L2tlcm5lbC91bndpbmRfKi5j
DQo+ICANCj4gK1g4NiBUUlVTVCBET01BSU4gRVhURU5TSU9OUyAoVERYKQ0KPiArTToJS2lyaWxs
IEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiArTDoJeDg2
QGtlcm5lbC5vcmcNCj4gK0w6CWxpbnV4LWNvY29AbGlzdHMubGludXguZGV2DQo+ICtTOglNYWlu
dGFpbmVkDQo+ICtUOglnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni90ZHgNCj4gK0Y6CWFyY2gveDg2L2Jvb3QvY29tcHJlc3Nl
ZC90ZHgqDQo+ICtGOglhcmNoL3g4Ni9jb2NvL3RkeC8NCj4gK0Y6CWFyY2gveDg2L2luY2x1ZGUv
YXNtL3NoYXJlZC90ZHguaA0KPiArRjoJYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gK0Y6
CWFyY2gveDg2L3ZpcnQvdm14L3RkeC8NCj4gKw0KPiAgWDg2IFZEU08NCj4gIE06CUFuZHkgTHV0
b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPiAgTDoJbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
