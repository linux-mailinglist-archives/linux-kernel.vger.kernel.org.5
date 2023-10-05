Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B397BAC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjJEV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJEV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:28:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0CE4;
        Thu,  5 Oct 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696541338; x=1728077338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vDUUAkElYYu8M44t3OkVqttfCG0D8qw9gFlhSlSiaUQ=;
  b=Rq3/uZ8T9wkYjfe2VYQv9D+PDdi2q2s+3D+xIjgLh8gNKFoeG+XRG4vV
   uRUv/Ob3rA2y/1t1+TK7BVq1BFXgYGQQPgjXlmwjh7sLD5/PiS2Nc4R3T
   9Bi2pH0JXKYgsfl5NYMfD1IwhHs6FF2q/dHB8Jfr1sLYxxcFC4UY3Vcfa
   dik1CbG0h/1gcPGyZjS4F0bKe0JwxEutsFY5rn9g1iWqzpRc7RjX/DVzU
   9ratIvaUK6j3elGsTN4gyr531KEBveOl74bj3rjGh36o8ZCDFOSEt0AZC
   Z1CxNx9wj/qwRA3ZyrPVuFrfCjn0GTSS5YcFTYG6Rehslk1B01mAgjVr6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380900334"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380900334"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925727017"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925727017"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 14:25:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 14:25:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 14:25:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 14:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJRKGkNAX57FT+VL7XlCs0KUL+Y9TjAlrL9FaRgYXGNQOHFAEmIQwBmFJkA2riLOxnQ0O6VPRlkd8a7acKO12BX5+QD6X53hP2tS6D0iqXK3f67QQphzvOo2GSYaw9lnPbiErUftPsw9GCrE2Q0n6dzdsDJccKI77sUfZUSTUFDTNwe20tgKxG9Ln45G2nP6dYjddyfwU5KkFKKnnYlg3aVMATcUGtX3OE4ybHzZMBG44eWt2B89+kJ+VaFvXTF5X3oUNa1KLzbhTwKj8PdIpOu1yP4yi0FDtXWH66AZ8YtuScg0T+3NiwEMp73HAFg2sET2AiRPD3OmEVtIUZjYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDUUAkElYYu8M44t3OkVqttfCG0D8qw9gFlhSlSiaUQ=;
 b=MF7B2/mklNi+hqz8sPrLQ59u2lRew9mEj6Bx/HvLWT824zPNIOvNN5NjLxyNh3wkjYWmD+MG10lOI5UhEFIC1wwoijaraFfQ5/Cf72bGxCsQLSXrUqPvDchZaP8SuT61HuwNe6+9S3WETGULywiiCht2Q5VuWQekU1j0RAZkeqcJsyqZuphVVyaewX2OuZNaIuclEiOS22TlcRQbVI+IPK5+7mkeKqjeINQ+Z8mbdQXTHg4cEnff5xdWBGhvZEMMk1O5ogZzb5hu7XX8Lu/QoTUJyYVVCFX0vH224h9pobtjobWFaxDOmi70GViwc7yoGXP7Uq2vCfLD6IxxAuO7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB8141.namprd11.prod.outlook.com (2603:10b6:610:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 21:25:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:25:51 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Thread-Topic: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Thread-Index: AQHZ96IxAw+LYla5DUa3SWczdKDOP7A7tcCA
Date:   Thu, 5 Oct 2023 21:25:51 +0000
Message-ID: <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB8141:EE_
x-ms-office365-filtering-correlation-id: 257af1f6-d469-4aa5-b1f8-08dbc5e9a6a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: laU/SJlVVCmzKNkX73xcoZ+36dSvTEvAKkO/eyP+BJhcqKCmkFkH4wINmr7QECncQjGnoamHK+OoIK7PHQNWeHSW4A/zxJcOieDvq+TiwkXhs3t2EjI7UX1mwcq2zA2QcJ7zmgthiabK7+PeOjAqdie8R5S/nHKAhWPrW7EXSwgRWaH0a0lcH9Ely1mI+u32Zhuq87bem38iMFcD6QG7q4C94WAsWch3pq9Nvo8DxOcdqADaq3ddYPyefvvFCpU1ZlDBpNwkexpiLgE9t+AqAc+vVKWVHiSWNOfOIGBIdetGzu4T5LkJ3SQPxwhn+yME8ayJpK1PtbfqvZ8ECkudwzZMhSC9xF1y8aNojLq2ZfLmn5MEc2YoslyQQ5e2xoZbs5lfHjuJcQIuqhAKK9pFz6zgoeyfyCz9H8Y2Bc72F6hA0JKxS9mXdeFH5GtYhkg7HNmsYKR6Dusp2mXc6h+EJDE2VMC8e9O+R1LSMa8EpFiPH+JkGZJvE2HyAhNC2nClaDIrHiJTr6azbJRvE3nLpIrAKZmUq4xg2o7SMUKB2x9bq6ooJNdrsX8y3TJftLkJFjGqaHjG6aXRrB7lBFVzcb0KV7sSoBDBZA7EGj9md+dRAp7paK2LcDmnZpHt4JDi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(36756003)(26005)(2616005)(6506007)(82960400001)(83380400001)(6486002)(2906002)(6512007)(122000001)(91956017)(8936002)(4326008)(38070700005)(8676002)(66556008)(41300700001)(71200400001)(64756008)(76116006)(110136005)(66476007)(66946007)(66446008)(316002)(38100700002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NhTTZ6RHVTeTNMa3VLOEV1ckxqamRDRXlhKzd6eGJxMjZTdnZKbTFhc0cx?=
 =?utf-8?B?bGhoMlVYbWROSXhIMUdRa2ZkcmhNU3JzZjlFalJQQTNPV0ZsOCtITGlpMTFI?=
 =?utf-8?B?ZE9jdTlkTXJlMnZIVTU5TE5MNlIvcVkrUmNnZ050YjBLK2tPTExaNU9ESmgy?=
 =?utf-8?B?MWZDYUJ0TkZxQjlHRVROV3pwVDBQZjh6amNkbkF4Mk9IR1hLV0FxMUc3VDU5?=
 =?utf-8?B?NU9OWU4ydmg1aHdOc0VwaUh2dEVNZG5VNE1QVks0amxpemZVK3BNdTRrVzQ4?=
 =?utf-8?B?bXZ1Z3EySkNjaDJ1ZlFiUWxGUnlNTGQvSGNGY2pkUmlaUUFneW9lVEJDVlFi?=
 =?utf-8?B?ZlQ1bE9PK1doRWhyaGlPNkJaUTBQUDNCOFphWi9OTFZDVk5vdW1rVjNQK3Ev?=
 =?utf-8?B?TzFpMklBNjVrUm5WRVUrUjJKcW9IT0V0dGhxSTdkRWtIb3B5U1hCZmtJcmNJ?=
 =?utf-8?B?T0FYYW1ZZURUSHZpVndNSXZmQk1TM21HaUhtVDJ4ZDFvaTA3bUFkdzNjSHJy?=
 =?utf-8?B?cEVhSTZrRVhrK3Q3VFdZcDhPNll1TzBNK2p5L01pem42dVlzM2ViOXVDSE1I?=
 =?utf-8?B?N0o1RFZkZENaRGVCZkpaSDV6dlhma0dEbU1BcWNsRlJoTVBGNzAzdnFNZG9i?=
 =?utf-8?B?VVg4emxBUEUwSllQWGVkUVJwSnBTT0wwZVJBYVM4dVZBcVpvNFlTU2U3Q0pF?=
 =?utf-8?B?K2IvTmpZa0JaMENiZzcvVkRKWmNJZmowdGdPK1hjWWo1eWdFb29Lcld6WHMv?=
 =?utf-8?B?cVo2K2lXRnovUEh5RURGVW1xUkNZMVRGTHV2N1lONVFiWHNQOEFTckxYSEsr?=
 =?utf-8?B?eHBzdHAwVTgzaUVmS3ZGNFQwZ3BZQW5OUDh6VnFRU3gvVm5XbXdXay8vR1pi?=
 =?utf-8?B?bUtuYkhGekx6ZU1SSVk5ZHNjZGc1STJacC9kbVQ1TDNqTG53Z283QVEvMGtJ?=
 =?utf-8?B?aFlOK1JIVlBtNEJKc2hlWE5yNHdBWjhxWEtMUmpiQ1hETDA0UlRpNmdzaE5J?=
 =?utf-8?B?bXk3L3J0emlpRExtZUFlVlRZeEprMTZHdnBmeUM5d2VnZkdpTFlqNW9Pckoy?=
 =?utf-8?B?cG9iZE9veWtqTHB6U3dDUURURVUyMXVFdmxaeTk3YzdLQXU3UytjK3Z5MVlu?=
 =?utf-8?B?U2hwSnlub2lUdFpOMDFzbC9BblIrNzZLSFlGdTFiVHg2QzBGdlh1aUFTQnVV?=
 =?utf-8?B?K1V0TnVwR1JSUUpnS0tJWEtSdVFwS0hlaUhNYW5vM1AzSXJJQWw1WVMrbE9s?=
 =?utf-8?B?dk1nWHE4ZHlObEZaejh5N21jNUFEQVg5ZE5TdEVqS1htRGp5cDNnWDg2bTdP?=
 =?utf-8?B?RW9UdWxSK3VJUUVVWTFVZFM0QVhPOEpYbUVEVldTZUNXVmJBWDQ0NFZkMmRD?=
 =?utf-8?B?bnlJWnJMY0crdGFQUmxEVWo2cm9KM01MS2RYQnNiaUw5cENVV1NITFNXaDRk?=
 =?utf-8?B?ZHhSelJDSWcvYWZYTVlWQ0xlVlJ6SWwwZ0x5ZVhTQ1BnU0tLQzNJM28yUS8r?=
 =?utf-8?B?YlJSZURlMS9NSEUwRVN3ZFR0RU02M0Y2TXBMcFBVUmlNMHFmbnVjWXJjU0FR?=
 =?utf-8?B?bHJld3JDTmtXK0p4S0hUU003UDNEYloyVmlDaWtzU1VmYUQ5bnpNRmxjZi9K?=
 =?utf-8?B?VlpucGtVUmlqa05iQ2t3b1NZdVpvcitVNFJNenVYdkVsajdpK0RscFpsL0dK?=
 =?utf-8?B?SjdxZUxDTEhrY0tGVGc3V01hT3JScWNhcnFyYjFicDJUSFBZZlJDUXNrTVgv?=
 =?utf-8?B?K2V1ZlZoVDB6MURyRzFRRytDS3JtQktFTktqTzYzZER2RGVTb21HZGF0K3pN?=
 =?utf-8?B?S2hET0o0V2YzTjRyUWhtRUFwcnBpQjZXUnhGTlEyNHc1U2hKcjhSdnAwMmdh?=
 =?utf-8?B?VFQrNGtDV2pQVldLU1dXTlpDaldyS2M2Tk02Wk15L1dVb3U2NG9ueDFvS2VD?=
 =?utf-8?B?cGxYaFF0T2liUllBSllsSkNlakY3Qm01MDNkYmJ5NTUxQXVxdUxYWlEzRVVv?=
 =?utf-8?B?OGg3a3R2NXVKcFJ4ak4zbjFaSXArcE85TytiV2ZJczM5cUFlK1hZMDZwNElB?=
 =?utf-8?B?bHRtZmNiVkdta1AwT2dXZ054OUdNc1hSOURzeStxMEY1blJ1b1NRaCtNY08y?=
 =?utf-8?B?VlpSeXRLVk1wbFB4YWZHQkxRS29QUG1mb0dhMEJRRXdnVVREdGJxcmZTbjhl?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59DAEEF98E0D2644B249EE8C5588CEF1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257af1f6-d469-4aa5-b1f8-08dbc5e9a6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 21:25:51.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfdEsyrG4kXDUzei1Rp9avz/7PTKZ8XA/h01DiXdSwcc7IxuWY75AuM66qDYOxbB4GtNbFl0bCi7CnrHylGBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8141
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm8sDQoNCkp1c3QgRllJIEkgd29uJ3QgcmV2aWV3IHRoZSByZXN0IHBhdGNoZXMgaW4gdGhp
cyBzZXJpZXMuICBPbmUgb2YgdGhlIHJlYXNvbnMgaXMNCkkgYW0gbm90IHRoYXQgZmFtaWxpYXIg
d2l0aCB0aGUgcmVzdC4gIEphcmtrbyBoYXMgcmV2aWV3ZWQgYW55d2F5IDotKS4NCg0KT24gVGh1
LCAyMDIzLTEwLTA1IGF0IDE3OjM4ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+IEhpLA0K
PiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgZW5zdXJlcyB0aGF0IGFsbCBTR1ggc2VsZnRlc3RzIHN1
Y2NlZWQgd2hlbiBjb21waWxpbmcgd2l0aA0KPiBvcHRpbWl6YXRpb25zIChhcyB0ZXN0ZWQgd2l0
aCAtT3swLDEsMiwzLHN9IGZvciBib3RoIGdjYyAxMS4zLjAgYW5kIGNsYW5nDQo+IDE0LjAuMCku
IFRoZSBhaW0gb2YgdGhlIHBhdGNoZXMgaXMgdG8gYXZvaWQgcmVsaWFuY2Ugb24gdW5kZWZpbmVk
LA0KPiBjb21waWxlci1zcGVjaWZpYyBiZWhhdmlvciB0aGF0IGNhbiBtYWtlIHRoZSB0ZXN0IHJl
c3VsdHMgZnJhZ2lsZS4NCj4gDQo+IEFzIGZhciBhcyBJIHNlZSwgYWxsIGNvbW1pdHMgaW4gdGhp
cyBzZXJpZXMgbm93IGhhdmUgYW4gZXhwbGljaXQgcmV2aWV3ZWQtYnkNCj4gdGFnLCBzbyBob3Bl
ZnVsbHkgdGhpcyBjYW4gZ2V0IG1lcmdlZCB1cHN0cmVhbT8gUGxlYXNlIGxldCBtZSBrbm93IGlm
IGFueQ0KPiBjb25jZXJucyByZW1haW4gYW5kIEknZCBoYXBwaWx5IGFkZHJlc3MgdGhlbS4NCj4g
DQo+IFJlZmVyZW5jZSBvdXRwdXQgYmVsb3c6DQo+IA0KPiAuLiBUZXN0aW5nICAgZ2NjICAgLU8w
ICAgIFtPS10NCj4gLi4gVGVzdGluZyAgIGdjYyAgIC1PMSAgICBbT0tdDQo+IC4uIFRlc3Rpbmcg
ICBnY2MgICAtTzIgICAgW09LXQ0KPiAuLiBUZXN0aW5nICAgZ2NjICAgLU8zICAgIFtPS10NCj4g
Li4gVGVzdGluZyAgIGdjYyAgIC1PcyAgICBbT0tdDQo+IC4uIFRlc3RpbmcgICBnY2MgICAtT2Zh
c3QgW09LXQ0KPiAuLiBUZXN0aW5nICAgZ2NjICAgLU9nICAgIFtPS10NCj4gLi4gVGVzdGluZyAg
IGNsYW5nIC1PMCAgICBbT0tdDQo+IC4uIFRlc3RpbmcgICBjbGFuZyAtTzEgICAgW09LXQ0KPiAu
LiBUZXN0aW5nICAgY2xhbmcgLU8yICAgIFtPS10NCj4gLi4gVGVzdGluZyAgIGNsYW5nIC1PMyAg
ICBbT0tdDQo+IC4uIFRlc3RpbmcgICBjbGFuZyAtT3MgICAgW09LXQ0KPiAuLiBUZXN0aW5nICAg
Y2xhbmcgLU9mYXN0IFtPS10NCj4gLi4gVGVzdGluZyAgIGNsYW5nIC1PZyAgICBbT0tdDQo+IA0K
PiBDaGFuZ2Vsb2cNCj4gLS0tLS0tLS0tDQo+IA0KPiB2Nw0KPiAgIC0gQWRkIHJldmlld2VkLWJ5
IHRhZyAoSmFya2tvKQ0KPiANCj4gdjYNCj4gICAtIENvbGxlY3QgZmluYWwgYWNrL3Jldmlld2Vk
LWJ5IHRhZ3MgKEphcmtrbywgS2FpKQ0KPiANCj4gdjUNCj4gICAtIFJlb3JkZXIgcGF0Y2hlcyAo
SmFya2tvLCBLYWkpDQo+ICAgLSBJbmNsdWRlIGZpeGVzIHRhZyBmb3IgaW5saW5lIGFzbSBtZW1v
cnkgY2xvYmJlciBwYXRjaCAoS2FpKQ0KPiAgIC0gSW5jbHVkZSBsaW5rZXIgZXJyb3IgaW4gc3Rh
dGljLXBpZSBjb21taXQgbWVzc2FnZSAoS2FpKQ0KPiAgIC0gSW5jbHVkZSBnZW5lcmF0ZWQgYXNz
ZW1ibHkgaW4gcmVsb2NhdGlvbnMgY29tbWl0IChLYWkpDQo+IA0KPiB2NA0KPiAgIC0gUmVtb3Zl
IHJlZHVuZGFudCAtbm9zdGFydGZpbGVzIGNvbXBpbGVyIGZsYWcgKEphcmtrbykNCj4gICAtIFNw
bGl0IGR5bmFtaWMgc3ltYm9sIHRhYmxlIHJlbW92YWwgaW4gc2VwYXJhdGUgY29tbWl0IChLYWkp
DQo+ICAgLSBTcGxpdCByZWR1bmRhbnQgcHVzaC9wb3AgZWxpbWluYXRpb24gaW4gc2VwYXJhdGUg
Y29tbWl0IChLYWkpDQo+ICAgLSBSZW1vdmUgKGluY29tcGxldGUpIHJlZ2lzdGVyIGNsZWFuc2lu
ZyBvbiBlbmNsYXZlIGV4aXQNCj4gICAtIEZpeCBwb3NzaWJseSB1bmluaXRpYWxpemVkIHBvaW50
ZXIgZGVyZWZlcmVuY2VzIGluIGxvYWQuYw0KPiANCj4gdjMNCj4gICAtIFJlZmFjdG9yIGVuY2xf
b3BfYXJyYXkgZGVjbGFyYXRpb24gYW5kIGluZGV4aW5nIChKYXJra28pDQo+ICAgLSBBbm5vdGF0
ZSBlbmNsX2J1ZmZlciB3aXRoICJ1c2VkIiBhdHRyaWJ1dGUgKEthaSkNCj4gICAtIFNwbGl0IGVu
Y2xfYnVmZmVyIHNpemUgYW5kIHBsYWNlbWVudCBjb21taXRzIChLYWkpDQo+IA0KPiB2Mg0KPiAg
IC0gQWRkIGFkZGl0aW9uYWwgY2hlY2sgZm9yIE5VTEwgcG9pbnRlciAoS2FpKQ0KPiAgIC0gUmVm
aW5lIHRvIHByb2R1Y2UgcHJvcGVyIHN0YXRpYy1waWUgZXhlY3V0YWJsZQ0KPiAgIC0gRml4IGxp
bmtlciBzY3JpcHQgYXNzZXJ0aW9ucw0KPiAgIC0gU3BlY2lmeSBtZW1vcnkgY2xvYmJlciBmb3Ig
aW5saW5lIGFzbSBpbnN0ZWFkIG9mIHZvbGF0aWxlIChLYWkpDQo+ICAgLSBDbGFyaWZ5IHdoeSBl
bmNsX2J1ZmZlciBub24tc3RhdGljIChKYXJra28sIEthaSkNCj4gICAtIENsYXJpZnkgLWZmcmVl
c3RhbmRpbmcgKEphcmtrbykNCj4gDQo+IEJlc3QsDQo+IEpvDQo+IA0KPiBKbyBWYW4gQnVsY2sg
KDEzKToNCj4gICBzZWxmdGVzdHMvc2d4OiBGaXggdW5pbml0aWFsaXplZCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGluIGVycm9yIHBhdGgNCj4gICBzZWxmdGVzdHMvc2d4OiBGaXggdW5pbml0aWFsaXpl
ZCBwb2ludGVyIGRlcmVmZXJlbmNlcyBpbg0KPiAgICAgZW5jbF9nZXRfZW50cnkNCj4gICBzZWxm
dGVzdHMvc2d4OiBJbmNsdWRlIG1lbW9yeSBjbG9iYmVyIGZvciBpbmxpbmUgYXNtIGluIHRlc3Qg
ZW5jbGF2ZQ0KPiAgIHNlbGZ0ZXN0cy9zZ3g6IFNlcGFyYXRlIGxpbmtlciBvcHRpb25zDQo+ICAg
c2VsZnRlc3RzL3NneDogU3BlY2lmeSBmcmVlc3RhbmRpbmcgZW52aXJvbm1lbnQgZm9yIGVuY2xh
dmUNCj4gICAgIGNvbXBpbGF0aW9uDQo+ICAgc2VsZnRlc3RzL3NneDogUmVtb3ZlIHJlZHVuZGFu
dCBlbmNsYXZlIGJhc2UgYWRkcmVzcyBzYXZlL3Jlc3RvcmUNCj4gICBzZWxmdGVzdHMvc2d4OiBQ
cm9kdWNlIHN0YXRpYy1waWUgZXhlY3V0YWJsZSBmb3IgdGVzdCBlbmNsYXZlDQo+ICAgc2VsZnRl
c3RzL3NneDogSGFuZGxlIHJlbG9jYXRpb25zIGluIHRlc3QgZW5jbGF2ZQ0KPiAgIHNlbGZ0ZXN0
cy9zZ3g6IEZpeCBsaW5rZXIgc2NyaXB0IGFzc2VydHMNCj4gICBzZWxmdGVzdHMvc2d4OiBFbnN1
cmUgdGVzdCBlbmNsYXZlIGJ1ZmZlciBpcyBlbnRpcmVseSBwcmVzZXJ2ZWQNCj4gICBzZWxmdGVz
dHMvc2d4OiBFbnN1cmUgZXhwZWN0ZWQgbG9jYXRpb24gb2YgdGVzdCBlbmNsYXZlIGJ1ZmZlcg0K
PiAgIHNlbGZ0ZXN0cy9zZ3g6IERpc2NhcmQgdW5zdXBwb3J0ZWQgRUxGIHNlY3Rpb25zDQo+ICAg
c2VsZnRlc3RzL3NneDogUmVtb3ZlIGluY29tcGxldGUgQUJJIHNhbml0aXphdGlvbiBjb2RlIGlu
IHRlc3QgZW5jbGF2ZQ0KPiANCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmls
ZSAgICAgICAgICB8IDEyICsrLS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9kZWZp
bmVzLmggICAgICAgICB8ICAyICsNCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9sb2Fk
LmMgICAgICAgICAgICB8ICA5ICsrLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Np
Z3N0cnVjdC5jICAgICAgIHwgIDUgKy0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90
ZXN0X2VuY2wuYyAgICAgICB8IDY3ICsrKysrKysrKysrKystLS0tLS0NCj4gIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzICAgICB8IDEwICstLQ0KPiAgLi4uL3NlbGZ0
ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TICAgICAgIHwgMjggKysrLS0tLS0NCj4gIDcg
ZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNTYgZGVsZXRpb25zKC0pDQo+IA0KDQo=
