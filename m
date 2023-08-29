Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134C878C2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjH2LBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjH2LA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:00:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC5CCA;
        Tue, 29 Aug 2023 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693306841; x=1724842841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YsZasTyM0zF/KNObZar5dflDPf/5r++Eu15ytndGekM=;
  b=kbpIIpKOR18upBR0uW3LZi5WR0kuZOgNbOCpvl21FwQVrvT24ifj5Fd7
   wqdVwWSgmfCifjpf32fQ3nTGs2J4/SjnkW9/U6t1yh9CsESepT+L1eSAV
   MSd639q6Sf4BJPLJz2yr6uO0Keeb6Dq4lNv3QuCcPvd8Mar8XXl5ewQ/+
   hTWGDQZVs6XmeXOmc7aK00KrUadLHh10PEMsYTdqs6X45iqC3w5tPQuiU
   yNUW0sIjSg+HaQZjn6OA5z9y4j+th7KJUDpjt+gCRB3V1KoiZGUVNGY3k
   Q7vJfi2+IPeZ+orjC2xHbbplyDrWa6IMnY1BSVNtRIQKofAbVClB4E8R1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="378058381"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378058381"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 04:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738655821"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738655821"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 04:00:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 04:00:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 04:00:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 04:00:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 04:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0Nq3JMgWYy/E6DxPuvXXABvUe7aM/roLBBrBxIj/M5JHZj6FjQGHexjAimnWlin/OLsClYYIYide+IzEZEeiBvayIGavOUDTZn+m4EVDsF/FVKmZ6wheDHIlGotJbX476O30UXe6WbHXaUQ9SkPwiEHy7vt1edNpu5qSxD9EGuKXYbQ3OTP2RokvgmPGk1LFIN3qfk54zLZKR2FPd/QYhSAMDh7L/Qsc2Yi7d9qop1d4cuVPuxGDOGf/A13Qrz33b9wsqqLBlmY5nb3SuKGyK/4eerOHC3sAWWSabhSaiD2H8lvdpELhTA4oVMfF9sp3e1nmZjjmMbTa9MRJZe0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsZasTyM0zF/KNObZar5dflDPf/5r++Eu15ytndGekM=;
 b=ZN82g1dGPV7j2R/eNdN2xHhvgq+NQ8oesiW5yyvfmlxc1XgFIC/wvM+vGxy09BH/1oYESor+WHYUE7exkHIjXCbKr4gw3MnkfXClnrAH0xvU6QnsYjv+G19LS90pphI47loClgarW6NKYtc73BOSVw1mYHz/ImT77vuXBCRN+p/1DNG9L+VmyhW7nonbq+syQ1ba5wyTtSa0BpNMO1UPcpNJ6RpgR8aHZ2P+BTMYT16Brl/kUwHURTDLLaEOmawL8mGKrRjT1lWePxu1veaaErbgeQWKNNxlqFRr5ZCZr/La7+bLplqtsx4PxCWmwJwqcfp1KiawKxK50fa+/FAgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 11:00:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 11:00:35 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 12/13] selftests/sgx: Remove redundant enclave base
 address save/restore
Thread-Topic: [PATCH v4 12/13] selftests/sgx: Remove redundant enclave base
 address save/restore
Thread-Index: AQHZ11jfeQ6sKNLqo06QTJL4ln8X9rABIV6A
Date:   Tue, 29 Aug 2023 11:00:35 +0000
Message-ID: <54cc090bad89351862fa67c97d681e411336e2be.camel@intel.com>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
         <20230825133252.9056-13-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-13-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6464:EE_
x-ms-office365-filtering-correlation-id: 7419a58d-dd8a-4934-b05f-08dba87f2bfc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wokyBAC7MKSonOrGyPy8tf/ZtGTXLjePHC230safcwBC/Qy1MtouHW/qcnVbSxThDcVBu3QwmIASUkNnOKV9ECFv5+Ax75Qs4aSk6BlyRf4VBuT8Eefp7he2D2XViODG3X2jlY7/bcfphN6NEGaDzhDMoYyXfgOzOVjlu4X5RFWepyD4i3ALODJH4d953tu+Gf1bd/c07IThF1CoTaPnfzjzWq4hMV58ASgzNXuwvm+1E2QZBYzkyMuLZV2Ulhw9qP48CIIghsnOLaGyr3tVfASUHr7n7q3NgunICNn6B6wXV+J9vR8O03iEQiHNMNKwViahyBp2jMaUr/xVJxvhymBCde1PUM6KW+/Js/8W2iL3SmeebZcqZ9BFMVazKXT9uVhUwwVHXe10xIa4eeVJeWTgEK+DCg63UjooUozHWC2BObTCwUQngkH//KUoMA0X00iYt3IplSmHLObwSKaiyTKMnODbjiTCoLQ7j33B6XlTF6RUtqih/mdf5SkcqH4fx8m4335JAfszNCZ9xqqN4wG44sJX+2zE14B9XnN2CDpwZ3SIVEUqEOZ3O4ZbTDi5wImPa/UljY+7XR88EgPCfsGr+fxzMERZxeoq7E+oD4H/xaNcpU/bqXvJqw5Q4LmY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(6512007)(71200400001)(6506007)(6486002)(36756003)(86362001)(82960400001)(38100700002)(38070700005)(122000001)(76116006)(83380400001)(2906002)(26005)(478600001)(110136005)(91956017)(41300700001)(66556008)(66476007)(8936002)(66946007)(8676002)(4326008)(5660300002)(2616005)(66446008)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHVaWHIxQWxCZFFQOWI1Qlh4OW43YnpUUEVRV1Blb0RabzR2SWZHS3c3UStZ?=
 =?utf-8?B?cWI1Nk82WjFHV3RmcFkwUXlCYU90V0hPYk10ejB1UVlCUHk5cFY0SXprZkFo?=
 =?utf-8?B?d3dETzdCcTFTb3g4V3NWZERibVJxOGdyQU05VFZDUUVGVkY5QXFFUkNxbjVX?=
 =?utf-8?B?dXJTdnVJYUdSL1gxTlhTbFllQlhsN3d3RkxKZlZGcldzcGRJTG5ZWjBMTEtQ?=
 =?utf-8?B?cW9vOVE0eFFlWDVPWlBKMzgwREhqbGltNG1zUjJ3b0dSVzl6ZmczY2pFeUx2?=
 =?utf-8?B?RGxLbjBoTm5HTVpxM3FLc1ZsSWU2WXJMV3VVcXN6a214cHJOTjBKeDVWY3NR?=
 =?utf-8?B?bWhhdkp5eEJScks2YXUzL3dpQnVIajM3SGF6UWpnRmJLSitxN2RSak5iY2dT?=
 =?utf-8?B?TkpPdWQ0cDhGM1UzbiswN1QwZHkrNFB2ZXYxVFhRanpDQ2pUNG4wLzR3dVFW?=
 =?utf-8?B?TWk0eGRkZUZESEFWV0lDOHBySlk3TXJoU3p2Y1JmVXg5bVZZT255MXBVWllr?=
 =?utf-8?B?R0d2QWpSVlVqOE84am5CWGhoTDAvWVhkdXdud3pQUjBhRXlNdEJFSW1MR1Zu?=
 =?utf-8?B?YzRHRUpLZlkwUm55eE1mYWZzNThFVzVkYXlhRkdBRDB6NlA2MlJxTWx4dk5M?=
 =?utf-8?B?Y2Fkb1JKLzY0UTR1VFY0akVINEVxVGVJTHNzNVh2aXZxZ3dxRmgzWE9KSU5U?=
 =?utf-8?B?NklwMjdUL1FsZ3R2clZnOHRmaCtQWS9qdUJWOTRCVjlFZEZrNWltcDVadUxI?=
 =?utf-8?B?OXowVmJPN1NpVk4rcllqVEUvVzJKNkZrZWZUOENNckxvYWw4emg3U3hUMyth?=
 =?utf-8?B?cjk0NTlwR3VOYnR5RG1nS0xmQjE1a3NhcDJDbjBiQWQxRWNmSE1kVk16R0ov?=
 =?utf-8?B?OWwwSTZrbXRzR01nRldId1BUa1kwNTFIZ0xDcjcwdXAzRGx6S1BMWmh2SkJt?=
 =?utf-8?B?T3lBbHdoYjlSaWN5YlJrbzgrd1g4S3lFRVVxNXpJMmRZS0FkWUx4SnVmWUc1?=
 =?utf-8?B?YnpaVVBGdDYwVWo2WWVoS1VCU1dKUkJhNVVacHBSa3dBUTNMbU5wTTQ2dmdM?=
 =?utf-8?B?bThxMk9mUXhGa05DT0ZrU1lOZXI0NDBuTmxVcGR3UDl2WFZ4bDMvVk5QdjZ1?=
 =?utf-8?B?Qnh0UFJWMkI4bXUrdjk5Nmt3YU5uV29FbUc3c0Rjb0I4eGNBQS8vMlhYMWZ3?=
 =?utf-8?B?T2hBTG5IQThJdWlvQTZFYUtmaTRjTm14NHlQaG5lc29raWtkVjRxZ0VISzNV?=
 =?utf-8?B?VGRZSFVQNWQrTWp6d0lkWm1LdFVTZXI1TVNENXNkSW1aNWxub0REcHBSSm9Y?=
 =?utf-8?B?Q1ptRGFocXlrOHFDTVh3ZGVxbXc3cS9tOXliME1ySUdJQ3RUN1cwMmlEWnBV?=
 =?utf-8?B?SWJsZkMzamt6dmJGTStOWDBSZy90U2NFZDA5OWZ0cUdzNFNIQUtLR0w1YTRP?=
 =?utf-8?B?cjErNkZNODlGZzI4ZFJGSGpsYTZpU3R3cUZhb3dWUGJEazVrYU5SU1ErYnl0?=
 =?utf-8?B?YjJ2U3A2SE5mekdrUVk2andOMkdiVXRBa25qb1N4dDdoajJoaExEZ2dKVXk5?=
 =?utf-8?B?TTdBR2xkbTRMVHpQTDFvVHJvcXRCTFFhblgrSmdYUjgyeVpFMWZyR3dYY2tm?=
 =?utf-8?B?bGszZThaRURFRitwTnBJK3pJdjhXd3RxS1BzSFFXNXRxcTdQQUVNZWw4NURt?=
 =?utf-8?B?OVYvNHRYR2hPOGpDZGw0d3E2OExkbzJ5eHR4WisxcUVuU2ZzSGw3dGlENWtU?=
 =?utf-8?B?STNOQk5yV1pEN0Z4RnhqMmhTQy9DbWt1VXV1TjRoQ3VGTFFMc2dGQ09tUkN1?=
 =?utf-8?B?SXI5aTlYbC9DOHp6YWU5R1BNdy92WFIzOVhFWXV2c0N2TURKYUp0NmVOMTJW?=
 =?utf-8?B?UnZwOWRqQVRmbHAyS3hUeTNRNTVtSnh4TktsY1J5VnFXU3ZoeUNuWEcrMGpv?=
 =?utf-8?B?SHA1YktnVDlyZm5OZndpb3pxOElPaStKUzJFSkVlTEIvS1ExUFpBcUdqRXJZ?=
 =?utf-8?B?QjEvZWVySjIyTHp3YVN6ZjE2cWxPa3Jid1plZEQ1QWc3TUM2dE4xcUFiSnRn?=
 =?utf-8?B?OXA0VHJkV2x0Q0dLT0xmN0RnblVhUnlIY2hsTXNGWG9wbzE3Rzd4RENCeTk4?=
 =?utf-8?Q?rx/VTnvsi4Py1eApN+QoQuTCg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C8DE238B33D34686543C7C041C7FCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7419a58d-dd8a-4934-b05f-08dba87f2bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 11:00:35.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N0YUGGX4t1C8Xi7DJROZH1CPmkeHn2aBNi32nt4LYWOwU9C8HO3WlysV1pY7qEbzjNdHoYYsQsGgDv2SI0DLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
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

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDE1OjMyICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFJlbW92ZSByZWR1bmRhbnQgcHVzaC9wb3AgcGFpciB0aGF0IHN0b3JlcyBhbmQgcmVzdG9yZXMg
dGhlIGVuY2xhdmUgYmFzZQ0KPiBhZGRyZXNzIGluIHRoZSB0ZXN0IGVuY2xhdmUsIGFzIGl0IGlz
IG5ldmVyIHVzZWQgYWZ0ZXIgdGhlIHBvcCBhbmQgY2FuDQo+IGFueXdheSBiZSBlYXNpbHkgcmV0
cmlldmVkIHZpYSB0aGUgX19lbmNsX2Jhc2Ugc3ltYm9sLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Sm8gVmFuIEJ1bGNrIDxqby52YW5idWxja0Bjcy5rdWxldXZlbi5iZT4NCg0KQWNrZWQtYnk6IEth
aSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KTml0IGJlbG93Li4uDQoNCj4gLS0tDQo+
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TIHwgMyAt
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2xfYm9vdHN0cmFwLlMgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TDQo+IGluZGV4IDRl
NTVkOTE1NjZjNC4uMjhmZTVkMmFjMGFmIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NneC90ZXN0X2VuY2xfYm9vdHN0cmFwLlMNCj4gQEAgLTU4LDEyICs1OCw5IEBA
IGVuY2xfZW50cnlfY29yZToNCj4gIAlwdXNoCSVyYXgNCj4gIA0KPiAgCXB1c2gJJXJjeCAjIHB1
c2ggdGhlIGFkZHJlc3MgYWZ0ZXIgRUVOVEVSDQo+IC0JcHVzaAklcmJ4ICMgcHVzaCB0aGUgZW5j
bGF2ZSBiYXNlIGFkZHJlc3MNCj4gIA0KPiAgCWNhbGwJZW5jbF9ib2R5DQo+ICANCj4gLQlwb3AJ
JXJieCAjIHBvcCB0aGUgZW5jbGF2ZSBiYXNlIGFkZHJlc3MNCj4gLQ0KPiAgCS8qIENsZWFyIHZv
bGF0aWxlIEdQUnMsIGV4Y2VwdCBSQVggKEVFWElUIGZ1bmN0aW9uKS4gKi8NCj4gIAl4b3IgICAg
ICVyY3gsICVyY3gNCj4gIAl4b3IgICAgICVyZHgsICVyZHgNCg0KLi4uIHBsZWFzZSBtb3ZlIHRo
aXMgcGF0Y2ggYmVmb3JlIHBhdGNoIDI/DQoNCk90aGVyd2lzZSwgc3RyaWN0bHkgc3BlYWtpbmcg
cGF0Y2ggMiBpc24ndCBjb21wbGV0ZSwgYmVjYXVzZSBhZnRlciB5b3UgYXBwbHkNCnBhdGNoIDIg
eW91IHN0aWxsIGhhdmUgdGhpcyBjb2RlIHdoaWNoIGlzIG9idmlvdXNseSB3cm9uZyAtLSAlcmJ4
IGlzIG5vIGxvbmdlcg0KZW5jbGF2ZSBiYXNlIGFkZHJlc3MgKGFsdGhvdWdoIGl0IG5ldmVyIHdh
cyBldmVuIGluIHRoZSBjdXJyZW50IHVwc3RyZWFtIGNvZGUpLg0K
