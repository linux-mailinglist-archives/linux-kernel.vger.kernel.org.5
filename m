Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7C780C45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377020AbjHRNI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377011AbjHRNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:08:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F82710;
        Fri, 18 Aug 2023 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692364096; x=1723900096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cCTQAVHcYqMI1mo6vHQN1+igemZZbdQbCvlMZ/ueeEQ=;
  b=KNpyqpjzrYGI0VzHQa/T2oRHvnKIpd+vosys8Ikj/alnOy1C09h7XVrb
   e9Esziael0ePJye4xSt69qGTGCCmPrNdbtLjO8DSsXpbKcmhtlwdM52J2
   bDSzjysGBQRUKZAsKSndExaoy08teiUlbs3egzgyRJfp7zawpoNN5c01u
   ugk6RnC9eRTmwVdlbScPQNlYBPULU1Ydwucb4ajdm5Xi+Vk4aV2s6k0AE
   5DHFf21jMZr025JMIpgC3EpElLDXx1J5czQ2fZlJoIbjchVua0aYgNipu
   086Ioh2nQ2WN1IV3FlxNeO6ldhADamDMb7I9VBx09ApsNJf9uor4X9+rF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373078903"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="373078903"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728601035"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728601035"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 06:07:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 06:07:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 06:07:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 06:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/GglYvx0p+3CAG3zRDq4SKWOJAFesJFzVIFDc7a0PmQtXMXBTnGVVi1bY6/M3pPlLRClhmU80cz5xYyr8u+MbhI8y8F6BJ+tNI6YPIK5KoTKT6Hw6resjPElVLGsl/bFvGgEN/mMJMXCHy9qC5ScMjmiAwgCRwQfFVy8DuUCSR9NeTQohSlFk2bM6599YIbarWC6s53dTGBPCYfy19EIm0Nz8fu6CsSEWd3Qg2di8gb7CDYRNpYOduqLovZ7KI4LNd8HrzhiRpMtlVHX5T+Jl5mEVi7EZmnb7Rg8ERsvPTyKPzxvag1WAIE3/DSB+jRLQZdk2R3BKPArr2ULPMBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCTQAVHcYqMI1mo6vHQN1+igemZZbdQbCvlMZ/ueeEQ=;
 b=mqdBgBZ/D84RTzjdGvJ+0wRn4WOTnUc6j+uh4750v1D+G8GOwVmnLioac3v2L1sszyIAnrv+URxv2PynZLs71nVCbuj7UNmAnodFLMjrWBm0JWFh4KFTuP54C/khTGZYsbOirXIwV3cv1A3A4exnfSVir/+djah+6zOsRTP1T3E4WNSfEizXQg4HWSh/5anomrbDePOiOVK+xsFw5aqaUmS9uDgZWuKqMCxOYrK4Mda0RzfUHKPY7o3DvvN0ctR0KLdf369bdsglVyYdJFXLmkZ9QTCGKvk3ZO+9Ol/Fb0I/nkrJeHwu2DiHkPvj3JgTKMTZhSfgG00UGMqs4tIcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:07:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:07:14 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Thread-Topic: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Thread-Index: AQHZvlArjuImLhHIgU6DlMvo5rqhNK/PlE6AgA8VxgCAEYMYgA==
Date:   Fri, 18 Aug 2023 13:07:14 +0000
Message-ID: <4022cb20af2759d0e71f72a1b4161b3e43181bca.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
         <CUE1R4HRQ599.1BX4CEIPSDWRW@seitikki>
         <a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be>
In-Reply-To: <a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN2PR11MB4758:EE_
x-ms-office365-filtering-correlation-id: 9ca10951-6781-4a48-bacc-08db9fec0ae3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgmKhHsqkdVIREyGrVxt6v7TmgaUiEHW1xfqepM2BlMZBNxnRjTwMoqpl0AzoG2KT6KZ0tJYVJSKLGFhP9TwxHi38YrdtdycV8Wi/9MoeG2I9ESepC2EF41EkGrjQoS8RYBT/L0KgcGliYYoYUNEXaIPF5adWHFZuA5oQ0JnM74pDAsu3yHfJQDcmFXum/sCmICo2fO9sUZNMgibbbJKz4UOnmEmy3fh/JV9JFPtuAzhl7SFKBCCeXWj8/aRVL8nL2TtmhEwSpdxkMf5XjIsTHjd27pFXRiMHL2TmKiL6FrTVd2ztRW3yitLHGQqBQneaPXbmbBo5UQ3w89jQmKMyiA2WtqB13G80uvCUaIocT34VvtNqolIbfa018oq3UcBHr5QZHmkm4ToDDWS6RefJ2fJl/5pKSZ4MaDVYebrmS0jXNQ9yi6HluwCuoIzv8iKNEs54gAWkfP6LY1u1yHo3KF98+3CsyW5Rf9QNQrnDB2HxySUO9jw8+HBap2Cs18dbbVPrMfI+HraDHsQq1i1GCtcdCGHGm3SsThRYcmG8zLj3LIhZDLhJS3yVW/uLM9rQLU9UuxvRLg+TRVPNnvKTFlMQblIDsFsS/ezD66M81A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6486002)(71200400001)(6506007)(38070700005)(38100700002)(6512007)(122000001)(53546011)(82960400001)(86362001)(26005)(83380400001)(36756003)(2616005)(2906002)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(41300700001)(110136005)(91956017)(76116006)(5660300002)(8676002)(4326008)(8936002)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFc2WEIvUzEyRGo3K2FURHV1MUJhenRpZjJtK2hHYzJpK2llYXNFYXdnRDND?=
 =?utf-8?B?WnlRQUFOTUJVQ04wb3l3dXFSaE1iMGVHdGNEbHRJQzFCbzRPbnR0ZCtqQUdO?=
 =?utf-8?B?YTZFbmZaZHQvRU82YWVXZUFVa1lUeVp5WmVWOUZtOGlxaG5XQ1pxVXFUdDVB?=
 =?utf-8?B?WEFZMmN3U3ROTC8vT3MxaXh0UkxGWlh0cW9aNS9vK0h6THpYUW9CTEQ1cXJH?=
 =?utf-8?B?cG9PSUJMcHVWeXZ1aVVvN25OMnNWM1JaamxReXY5N0UydlBUNnR1eVZRVG5u?=
 =?utf-8?B?U0tBU0toK1pwVG1nWlZUM296SlR3bVpoeUxaUTd0VEljRWpEa1RQMG9ENkZp?=
 =?utf-8?B?aGVSUkR4NVpvZWMxSHVWd3lnUDFGVUVZWW5yMFM3TWpvL2RiZEtZdStWVVVJ?=
 =?utf-8?B?SzFrSzhYNzdHZUJlQldsRzN5YXl5ZGc0SndKT2crbVdiWkxiMkFnQ3lZdklE?=
 =?utf-8?B?VEdlTGwxcVFXNExHb2p6K2RJMHFjQTBEY3A5SUhtUWxIL2Z3NkRPdE5MWWR1?=
 =?utf-8?B?MWZEWkpZSkcrU1NmVzE4OHJ4MjEwWEI4SWY1aG9ic2UyQXpxUzMvMkxpK1JF?=
 =?utf-8?B?SGhSZ2NJcCtKRkQ1ZVdQRXI4eXExeG1oSTdUWFBnRmxmMmdBZnB4WkNGT1VP?=
 =?utf-8?B?R3I3L2txelplVzNyRjBsRTNEM3ErR01IVDU0dU5qMkFzVndCY0p0MUVjd0RJ?=
 =?utf-8?B?NEpmL3BEekxYOUdZNXZYZE9wV3RCQjRUb0pjZCtUWU5IRFVDdGRCaEg3MnE2?=
 =?utf-8?B?L0tDYkFIVnVHSExWVzZWa3FSQUdpcE1ySHc0dXFCaEVuY3BEUDg2NUQ4ZGR5?=
 =?utf-8?B?T29wdFNEaFJSa1FHYUF1N3NROXJXbWRqcEh6alBLcGpLM1BmNExxdUwvNUFt?=
 =?utf-8?B?R2E1MFdMYzhJZjVlNW5tSGY4Z2hvMFMzRUVZbXJ6b3RaL0VWOVFqWjVQWkRy?=
 =?utf-8?B?cHBNWkJzN1lFckhyR3l3QVZGNmhGQWxwcllxcVFZaSt5MjUxQVFEdThveENh?=
 =?utf-8?B?TjVYVWEwRGZSbktGRkZLbWs4N3RsSDVVRDhkdzdkblYvOXZ4NVhFbyt5QUhr?=
 =?utf-8?B?N0VMUnh5TU9oSUJXOE00RTFDME5HWGxVYWVUTVBiaEdIekFueVdOeXNDalVG?=
 =?utf-8?B?MjByQ3BuVGM3ZkV4U0F3N3NVaUZYekN1NWpKUzBRb3ZUWUhma1JBdE9POXdO?=
 =?utf-8?B?cXJaTzZ4U2RoMU9FL1QyVjlYamgzZGlhbER2R0lmVmtiYlpiT0ZvQklmZURW?=
 =?utf-8?B?UEdqQncxNHhiMGlnS01pVGhqa25xa2YvbUU5c3MrR0ozc3FpR2NlZVM2QnNH?=
 =?utf-8?B?ak5KdSs4WDBaTzRKSjJnZlV2M2x6QkRwbUQvWDJQMDIzUVNPUVVPMm9XRitW?=
 =?utf-8?B?dEN0N0hLSER1UVo5eG04QmNFRVgxWjlpVVBxNWZqZmJsK3Q5d0EyY1hHM2dp?=
 =?utf-8?B?SEo3bE1BYmxwZW1vVXEzRVFMZ1RLZmJ2Q0dIanNoV0c5VjhWbEJuNlFTZC80?=
 =?utf-8?B?UXM5WFJEZGdocFBiTzQyait0dTVwM2RnU05VeHhZZFE0NVE0NTdxTVU2dW90?=
 =?utf-8?B?ZktlZXp1czhqYnZTMFRYdmMvY2hGbHI2V09YY2liVE1UMDJGUmZnSWVkcUtY?=
 =?utf-8?B?SlF4WlBVYzNwK1BoTzdDR0xDalFwZDVLeFppRStJdnVzZmdNOWRhZVRNYmlj?=
 =?utf-8?B?UnY4cThzanZ0bnhsNE5BNlhsWkNVK2h2SXg2bDlEUHU0SmNja2U4NjljZ3Fx?=
 =?utf-8?B?MTcxVCtaSVN4QTdTT0hrcmJIdWhFWTRaNXBqL3NtenVLM1Njc3BWOVFGdzRC?=
 =?utf-8?B?U1lPVk5MdEFMR2xLRXA4aXJpWGxld3VudHJHTDE1WkpEWGFsTnREYmFSY29n?=
 =?utf-8?B?VzY4RkIzWFArOEF1V3Y0T3d6WVRJTGtMTG91M0FleUxTZFFGeE44NitmdTBU?=
 =?utf-8?B?K09qd0JRcXdaMjhsZlR0eGRPeHZIeEZQRk5PWkZ0ZmYrMG16QnVrU1FvUC84?=
 =?utf-8?B?Qk5DVjkxZzlqVVhudUpITklxMkN6ZndnaGV5NkJSYjlaZTBPY05XdDdmcTBK?=
 =?utf-8?B?RnFTOHNOd2NnekFvRmtPT1VZQi83N2hscnIyU0ZsbG5sUHRyc1B2Zk0vQ2d2?=
 =?utf-8?Q?NgABtnNwV6OQcyWDQhsANYWyI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D349049A0796AE49A9C1453E1E2CB781@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca10951-6781-4a48-bacc-08db9fec0ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:07:14.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CZ2/0GHxFWD/cb/QlcYHRFBJwYdubqMVTQh1M18gItuhPzJfCOoWFdAbz8im7OfN5U2uItZAdoVr+G0Ja0R+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
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

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDExOjQxICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IE9uIDI4LjA3LjIzIDIxOjE5LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gU28sIHdoZW4g
ZXhhY3RseSBpcyBpdCBvcHRpbWl6ZWQgYXdheSBieSB0aGUgY29tcGlsZXI/IFRoaXMgaXMgbWlz
c2luZy4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgZGVjbGFyaW5nIGVuY2xfYnVmIGFzIHN0
YXRpYywgaW1wbGllcyB0aGF0IGl0IHdpbGwgDQo+IG9ubHkgYmUgdXNlZCBpbiB0aGlzIGZpbGUg
YW5kIHRoZSBjb21waWxlciBpcyBhbGxvd2VkIHRvIG9wdGltaXplIGF3YXkgDQo+IGFueSBlbnRy
aWVzIHRoYXQgYXJlIG5ldmVyIHVzZWQgd2l0aGluIHRoaXMgY29tcGlsYXRpb24gdW5pdCAoZS5n
Liwgd2hlbiANCj4gb3B0aW1pemluZyBvdXQgdGhlIG1lbWNweSBjYWxscykuDQo+IA0KPiBJbiBy
ZWFsaXR5LCB0aGUgdGVzdHMgb3V0c2lkZSB0ZXN0X2VuY2wuZWxmIHJlbHkgb24gYm90aCB0aGUg
c2l6ZSBhbmQgDQo+IGV4YWN0IHBsYWNlbWVudCBvZiBlbmNsX2J1ZiBhdCB0aGUgc3RhcnQgb2Yg
LmRhdGEuDQo+IA0KPiBGb3IgZXhhbXBsZSwgY2xhbmcgLU9zIGdlbmVyYXRlcyB0aGUgZm9sbG93
aW5nIChsZWdhbCkgY29kZSB3aGVuIA0KPiBlbmNsX2J1ZyBpcyBkZWNsYXJlZCBhcyBzdGF0aWM6
DQo+IA0KPiAwMDAwMDAwMDAwMDAxMDIwIDxkb19lbmNsX29wX3B1dF90b19idWY+Og0KPiAgICAg
IG1vdiAgICAweDgoJXJkaSksJWFsDQo+ICAgICAgbW92ICAgICVhbCwweDFmZDcoJXJpcCkgICAj
IDMwMDAgPGVuY2xfYnVmZmVyLjA+DQo+ICAgICAgbW92ICAgIDB4OSglcmRpKSwlYWwNCj4gICAg
ICBtb3YgICAgJWFsLDB4OGZjZSglcmlwKSAgICMgYTAwMCA8ZW5jbF9idWZmZXIuMS4wPg0KPiAg
ICAgIG1vdiAgICAweGEoJXJkaSksJWFsDQo+ICAgICAgbW92ICAgICVhbCwweDhmZDUoJXJpcCkg
ICAjIGEwMTAgPGVuY2xfYnVmZmVyLjEuMT4NCj4gICAgICBtb3YgICAgMHhiKCVyZGkpLCVhbA0K
PiAgICAgIG1vdiAgICAlYWwsMHg4ZmNlKCVyaXApICAgIyBhMDEyIDxlbmNsX2J1ZmZlci4xLjI+
DQo+ICAgICAgbW92ICAgIDB4YyglcmRpKSwlYWwNCj4gICAgICBtb3YgICAgJWFsLDB4OGZkMygl
cmlwKSAgICMgYTAyMCA8ZW5jbF9idWZmZXIuMS4zPg0KPiAgICAgIG1vdiAgICAweGQoJXJkaSks
JWFsDQo+ICAgICAgbW92ICAgICVhbCwweDhmY2UoJXJpcCkgICAjIGEwMjQgPGVuY2xfYnVmZmVy
LjEuND4NCj4gICAgICBtb3YgICAgMHhlKCVyZGkpLCVhbA0KPiAgICAgIG1vdiAgICAlYWwsMHg4
ZmQxKCVyaXApICAgIyBhMDMwIDxlbmNsX2J1ZmZlci4xLjU+DQo+ICAgICAgbW92ICAgIDB4Zigl
cmRpKSwlYWwNCj4gICAgICBtb3YgICAgJWFsLDB4OGZjYSglcmlwKSAgICMgYTAzMiA8ZW5jbF9i
dWZmZXIuMS42Pg0KPiAgICAgIHJldA0KPiANCj4gRGlzYXNzZW1ibHkgb2Ygc2VjdGlvbiAuZGF0
YToNCj4gDQo+IDAwMDAwMDAwMDAwMDMwMDAgPGVuY2xfYnVmZmVyLjA+Og0KPiAgICAgIDMwMDA6
ICAgICAgIDAxIDAwDQo+ICAgICAgICAgIC4uLg0KPiAwMDAwMDAwMDAwMDA0MDAwIDxlbmNsX3Nz
YV90Y3MxPjoNCj4gDQo+IFRodXMsIHRoaXMgcHJvcG9zZWQgcGF0Y2ggZml4ZXMgYm90aCB0aGUg
c2l6ZSBhbmQgbG9jYXRpb246DQo+IA0KPiAxLiByZW1vdmluZyB0aGUgc3RhdGljIGtleXdvcmQg
ZnJvbSB0aGUgZW5jbF9idWcgZGVjbGFyYXRpb24gZW5zdXJlcyANCj4gdGhhdCB0aGUgX2VudGly
ZV8gYnVmZmVyIGlzIHByZXNlcnZlZCB3aXRoIGV4cGVjdGVkIHNpemUsIGFzIHRoZSANCj4gY29t
cGlsZXIgY2Fubm90IGFueW1vcmUgYXNzdW1lIGVuY2xfYnVmIGlzIG9ubHkgdXNlZCBpbiB0aGlz
IGZpbGUuDQoNCkNvdWxkIHdlIHVzZSAidXNlZCIgYXR0cmlidXRlPw0KDQpodHRwczovL2djYy5n
bnUub3JnL29ubGluZWRvY3MvZ2NjL0NvbW1vbi1WYXJpYWJsZS1BdHRyaWJ1dGVzLmh0bWwNCg0K
dXNlZCANCg0KCVRoaXMgYXR0cmlidXRlLCBhdHRhY2hlZCB0byBhIHZhcmlhYmxlIHdpdGggc3Rh
dGljIHN0b3JhZ2UsIG1lYW5zIHRoYXTCoA0KCXRoZSB2YXJpYWJsZSBtdXN0IGJlIGVtaXR0ZWQg
ZXZlbiBpZiBpdCBhcHBlYXJzIHRoYXQgdGhlIHZhcmlhYmxlIGlzwqANCglub3TCoHJlZmVyZW5j
ZWQuDQoNCglXaGVuIGFwcGxpZWQgdG8gYSBzdGF0aWMgZGF0YSBtZW1iZXIgb2YgYSBDKysgY2xh
c3MgdGVtcGxhdGUsIHRoZcKgDQoJYXR0cmlidXRlIGFsc28gbWVhbnMgdGhhdCB0aGUgbWVtYmVy
IGlzIGluc3RhbnRpYXRlZCBpZiB0aGUgY2xhc3PCoA0KCWl0c2VsZiBpcyBpbnN0YW50aWF0ZWQu
DQo+IA0KPiAyLiBhZGRpbmcgX2F0dHJpYnV0ZV9fKChzZWN0aW9uKCIuZGF0YS5lbmNsX2J1ZmZl
ciIpKSkgZW5zdXJlcyB0aGF0IHdlIA0KPiBjYW4gY29udHJvbCB0aGUgZXhwZWN0ZWQgbG9jYXRp
b24gYXQgdGhlIHN0YXJ0IG9mIHRoZSAuZGF0YSBzZWN0aW9uLiBJIA0KPiB0aGluayB0aGlzIGlz
IG9wdGlvbmFsLCBhcyBlbmNsX2J1ZiBhbHdheXMgc2VlbXMgdG8gYmUgcGxhY2VkIGF0IHRoZSAN
Cj4gc3RhcnQgb2YgLmRhdGEgaW4gYWxsIG15IHRlc3RzLiBCdXQgYWZhaWsgdGhpcyBpcyBub3Qg
Z3VhcmFudGVlZCBhcyBwZXIgDQo+IHRoZSBDIHN0YW5kYXJkIGFuZCBzdWNoIGNvbnN0cmFpbnRz
IG9uIGV4YWN0IHBsYWNlbWVudCBzaG91bGQgYmV0dGVyIGJlIA0KPiBleHBsaWNpdGx5IGNvbnRy
b2xsZWQgaW4gdGhlIGxpbmtlciBzY3JpcHQoPykNCg0KVGhpcyBsb29rcyBzYW5lLg0K
