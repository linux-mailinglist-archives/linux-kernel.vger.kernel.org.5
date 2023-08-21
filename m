Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3655B782786
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHULE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHULEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:04:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3FE2;
        Mon, 21 Aug 2023 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692615863; x=1724151863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GELwE2KirDP1ku6hD674cxXWW0yrWDNdpjgACzqhoS8=;
  b=LsF6oFeN9YB+q+CjX0i4X5wcUhfO7lcVQh4kcSoQU3SIzTD3E1bU2pGw
   p20b/1qnmHWBF8pwowwSP+x9ZjsJUAhePQAPxJwe7qwK2QU5TU8u4E5ml
   uqJGJcPwroYZlBNUvEkSGqBllyG4jIqM689Anmv/nB0z9EGAcGO3PJMDV
   ki6Hf7Weo7qpdEAv49wJuX8l4/ANW/jvCCx94Sgnr7vbFGoYCNP8SQF9U
   3b+4fLna796wz8km4mtnILNxFBJrLuR84FdsICybjOI0yM4CjYkyk9Yxk
   Jt8Em73cNgwVrQVH1pDKQWT5Ch4ZU0r/yh6UBhziuujv+kXfLFb8DeYjt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="363720477"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="363720477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738858079"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="738858079"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 04:04:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 04:04:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 04:04:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 04:04:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 04:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIe4RNzfW71FQnhwP02KZJQ34tHLf314PQR4n08vZLwdOqejZsJJXG795KABg/jVPh2wBXl6kxVvuKzDGToteobZISgyPBCfh4jzk+qtHf7HgH+XgaDmrGzTQKgxczirwMflxFeYHkNh7PoJnAw6rVVfKD/zWAy3U2gqhVYDzwYttTCPg1GRrqD37GWshaFSc1kawckOSgckIRkOgWjWdT31siGK4Zk3xUqX7Qt2qDQCFp9Jjqt8Vfyr7jApuS8vF6R/I/qYfDiJfUJHRq4ryQpzds0GskoI6O5hJ3HLXS3sxot6xIkGAiVv5k88MXdmKuOwJIhU0JBfa4PGAKKlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GELwE2KirDP1ku6hD674cxXWW0yrWDNdpjgACzqhoS8=;
 b=P7oAgl8wgbLwlyQ/RoKcxs4gis5+h2cPfcS0hmmXHB0E5oD6ta73BFa0iAzj89gU0qAkyCBy3VcSo3Xz5/Xva9DUGVfek2lVmBkI2lzm4fdD+gI6LbVecyNlOscznjQN5XY7SDsM69IWQ7x1JZx8ouY7o05djL6YkfXEXyrBmgZMtrBJWc9Zd5V3nX7yLzXyFe7E4zX5y4dSWwl8fmPFj3F19AoHWI+EFtUzb4KMtl3JDI8x0IY/oZT8U0OggMZ04tYRwgud3gCWHPZA4ksZVgrX6xD8gH40gh0+H54GpmOkgRiDFp/o7lTfcO6U1upLoRWGpx6nYlagFmsLsWa4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:04:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:04:18 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
Thread-Topic: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
Thread-Index: AQHZvlAqEIBAuQlfhEOT34Pp/w7z0q/YANMAgAZ/8ACAEajHgIAA5AUAgAO0QoA=
Date:   Mon, 21 Aug 2023 11:04:18 +0000
Message-ID: <9ecbbf06fdc992720a2da1f14b7863e9493cdcc9.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
         <8266f771d0d34317f1e9b10a3ac6a6e2e8c156d4.camel@intel.com>
         <f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be>
         <4c3005de1d6ed93df3dc57e2e285d4a6f42473bd.camel@intel.com>
         <150d8ca8-2c66-60d1-f9fc-8e6279824e94@cs.kuleuven.be>
In-Reply-To: <150d8ca8-2c66-60d1-f9fc-8e6279824e94@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: e1311ba8-7b8f-485f-481c-08dba2365d57
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Bo9jIqBReMioaVb7BqSrKs0JXd8AehLduChOpZQ8Dtov7WRtrDLi38Y2LuNPbr+RHWu1paGDrYq1Hvi1wHOR5Zg4T7B+X/ofUVvXjrC1crAmZwCKizWr01fPmNAD6xp2nUSsQnZASJYN1g4WEj15q0nTmqigIuZEhD0UJI/S13f8ucwvWg5Mk8sAP7eqjpg777byAyBUpviOaIe049fkATbvfiStGdfi9/h2uwZuVyughpbn98tl2P/PILFUD/O5yFbVIUqmYL5YNj1o8FH/NBLkJO6ypgDWh3bWL3EEPjU8TrSV0gl//MK/Ye0RBvyCSlIgLZ2DpqegoTLqDFkYt4JvN7BL7VsztYsVHlM+rSgnI2Y3jrAdRvxFffY5uIHbX5JKL1nWe1UXrMQngJcZifBBf6KjXNRE3E/gwCuBF11r1C1Tb75H8obXRPa9BNIsym38lpKkOkQd8HbdFMzuZMhscUc6nUhWWD7sACP4dROjDRVKE3lBw2iTkqscYPBtzN9iXiClUqXL3RpWbsTca5aLALhJeh5AY1KpTPJuGOHC+0yF4g/O7L6EYSZkdFeEbbBwFHA71IdOCmlCAiiiGg2UjUmO9ItgLDgbZAzcm9Nov3SYfeAq+2q+7BuzNxc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(451199024)(186009)(66899024)(66556008)(41300700001)(66446008)(64756008)(66476007)(76116006)(66946007)(110136005)(91956017)(316002)(6486002)(6506007)(53546011)(82960400001)(38070700005)(122000001)(38100700002)(26005)(8936002)(8676002)(4326008)(5660300002)(2616005)(83380400001)(6512007)(2906002)(86362001)(36756003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUMwWmFZVDdYbmVjWlhOOUIwTncrdmErTEgvRGZDZHl3RmNrWW4zVXBSUndx?=
 =?utf-8?B?UVl0Q1RlR2M3YWNVdnc3TFlkQXcvV0RMcS9vMFRJcGJyTlRvMm14aGJ0ZkNJ?=
 =?utf-8?B?RHNIZFprRC8vZGFROVNpVUtCY3dXYWxDM29wM0x0S1VNVitIVjBDUSsyMHVH?=
 =?utf-8?B?YjNySzZpc2wxYi9mTmtrSXB6b2MvR296MFFDS1krRnJxSHhGc2xJeG5nQlBO?=
 =?utf-8?B?Z0V2bTBjYkNlaUY5V296dEtybURLV1BNR2FNcFI1Mk5sVG1KSjlURkZreXdB?=
 =?utf-8?B?ZE1MK3c4aXRpazkvNEdNL3cxZi9sRjE4MnpUa0FpS3dSWEZSZHBSY01QbTRt?=
 =?utf-8?B?YllIL0UvOWdpTE12aWwxbDRFYVlvQlFwL09OMkZKQXVrZEVNbVlMM0hBYmZv?=
 =?utf-8?B?c24yNy9qTUZneFQrTmdDQlk1eG01SStVN0F3VHdhVDFZcmE2YzU4TjNaNkdH?=
 =?utf-8?B?VzBnSmxhTUNJUnk2c2g0dTlENDQxaTJCYWw0ZHRyclNZdDBOZUZ6TURVeXkv?=
 =?utf-8?B?YVRRcTZiWXIydDMzb0Y4a3NDK2dJdnp1OTFWNTRSZmhuYjU4bDhqSVN5aCtF?=
 =?utf-8?B?eTV5NUVrN3NxbSs0QUVDN0FuV29JRXB1enVjUGRLTUNWMUV0S20wRGRVYVRz?=
 =?utf-8?B?MlJCY05TcE9zbkx2dEVQU0s3dGsxSkdHeXRIU1RtejhweXpITldrSVdlZXZP?=
 =?utf-8?B?b0Q3eFN2VGdiKzE2ekNBajk2QUl2UGh0VlR4bVFHTE9MZW41Zmo3Z0k1N1dX?=
 =?utf-8?B?RGxyc0Mvc0R3N3ZDeEUrQWc4SkhhdTBQbTdldzBxek5LTm9OWkozYStmMEdW?=
 =?utf-8?B?N0ZINUhrdmNiSEVGMVFzeHdUdGk5Sjl5ejhra3dBdHlLSThFa3NVOWh3WFpr?=
 =?utf-8?B?Z2M2akJPZEU4MzJ5aFlJR1QzTzV6elhYUTEyUHNEbm05UjNnMUVhNDR5cUY0?=
 =?utf-8?B?MWZRQ3VORlM0TmhxUFJBek84dlJsVHI4UVRUZEo5VzFBOXJyKzQ4S3daQm1i?=
 =?utf-8?B?d0tjUzh1em1Ia3BVVDVaK2YzaGVRb3JPVnlxeTNUQnZER3hhWXFleHJESkg4?=
 =?utf-8?B?Rm0wTkpYZ1N0RVpGWnc3VkFuTTAzMWF4NElmeHpwUFNJMXh2Z0dpdE9MWTJi?=
 =?utf-8?B?TWV6VlJFdkk4bEV4V2orcm5MVzNZa0dlY3RuN3hjRkxhM1JMQk5td25iSGJL?=
 =?utf-8?B?cWFEaUthRmU3eUZ3bTd0Rk03QVlwaVdBcThGSlpXZTY2emgya3paMTQzUmFL?=
 =?utf-8?B?TWdCK1lrM3AxS2xIb0lDeWoyOGJaSTduNFJBTjdZU04yM0REZzI0aHhYajQx?=
 =?utf-8?B?aFl2VmNSQmdpYmpGcS92M3U3NXhnL0FJWXF0Vkk4c3A4L3phRmMxZnNqVVpr?=
 =?utf-8?B?emt4bGhxNVhrQ3BaTjdOUFloUWtiNVBndjN5dEZQUUFNckN0N0laamRQUXFJ?=
 =?utf-8?B?ZjFhVTZrcjZnd3h5WUZTckl0TEtMa1lDK3lQcUtydlY0MlNTZEtaSjhmazN4?=
 =?utf-8?B?R1lEaDFtdVFTaWdQcldnL1VOVWpzSjBicWFmazFXaS8yNm1FNGYvWnNOVGdP?=
 =?utf-8?B?alprTldka241dmRxTWxLSGFjaFdDeGlWRTJDTmZDNzI4dVJ0Z1NlK0tZd2RE?=
 =?utf-8?B?L0dRTkNkRG5CYURnbmtxc1pxQ0hiYzNNYWUzSVNXODdKblN0a0U4YjRtUHpQ?=
 =?utf-8?B?ZDNwazhXem96cUR2STg1bG5ReXNiVlpINWplcklnR2dLQ3VtRmoyK09rWHZG?=
 =?utf-8?B?bU00VHA0Y3hFcElpRTg5Q2NHNmp0U1BQdTVDQ3RZbjVHaGpudnZPU1A5b2Z1?=
 =?utf-8?B?WXJPNUhORmZ2bjNBbkZqR1FPeUc1a0xJTHJsNDMza2RQTmhGNDU4ZU5YR1JE?=
 =?utf-8?B?cGJkRnk4Nk10Q2UyTkpveTJ0WXprT3o2N3krSkRmKzg3eG1BVUdWQmdOZUlR?=
 =?utf-8?B?UW8vTFV0ZWxlQXdweWlHa0JVWStVZmpFbVN1c3pwNWREcWJWMDdlN0Rmdktx?=
 =?utf-8?B?N1NBTVViYnBwVW9JN2VpYzEzNzlBMERiSDcxYzVSeGxWL3hUajI2VEJUR0Nj?=
 =?utf-8?B?SVpyd20zenpOMWc1TDFPV0h4Q2d0MENMUEhmRnNmTlc4OElQVUdZdHo1WEJD?=
 =?utf-8?Q?9dGO0L37y/ZyRpYeywBydjYe+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77B79905B86D7045AA3EEB08CF27BF7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1311ba8-7b8f-485f-481c-08dba2365d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:04:18.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HidVFBTBLD5HcH2V7t7HpJSGfRqOVcnj0z/qIx5Cc11VSsQxHATN0lvlDKfWv1Nr3c1ncrDXxDadKrW2ZhkzxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTE4IGF0IDE5OjMwIC0wNzAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IE9uIDE4LjA4LjIzIDA1OjU0LCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IEhvdyBpcyB0aGUgInBy
ZXBhcmVkIGNvcHkiIHByZXBhcmVkLCBleGFjdGx5PyAgQ291bGQgeW91IHBhc3RlIHRoZSByZWxl
dmFudCBjb2RlDQo+ID4gaGVyZSB0b28/ICBJTUhPIHcvbyBpdCBpdCdzIGhhcmQgdG8gdGVsbCB3
aGV0aGVyIHRoZSBjb2RlIGNvdWxkIGJlIHdyb25nIG9yIG5vdA0KPiA+IGFmdGVyIHJlbG9jYXRp
bmcuDQo+IA0KPiBUaGUgInByZXBhcmVkIGNvcHkiIHJlc2lkZXMgaW4gLmRhdGEgYW5kIHNpbXBs
eSBjb250YWlucyB0aGUgYWJzb2x1dGUgDQo+IGFkZHJlc3NlcyBvZiB0aGUgZnVuY3Rpb25zIChp
LmUuLCBhcyB0aGV5IGFwcGVhciBpbiBvYmpkdW1wIHdpdGggLnRleHQgDQo+IHN0YXJ0aW5nIGF0
IDB4MjAwMCkuDQo+IA0KPiBDb21waWxlZCB3aXRoIGdjYyAtc3RhdGljIC1mUElDIC1PcywgdGhp
cyBsb29rcyBhcyBmb2xsb3dzICh0aGUgDQo+ICJwcmVwYXJlZCBjb3B5IiBzdGFydHMgYXQgMHg1
MDAwLCBpbW1lZGlhdGVseSBmb2xsb3dpbmcgZW5jbF9idWZmZXIgYXQgDQo+IHRoZSBzdGFydCBv
ZiAuZGF0YSk6DQo+IA0KPiByZWFkZWxmIC14IC5kYXRhIHRlc3RfZW5jbC5lbGYNCj4gICAgMHgw
MDAwNTAwMCA2NDIwMDAwMCAwMDAwMDAwMCA3YTIwMDAwMCAwMDAwMDAwMCBkIC4uLi4uLnogLi4u
Li4uDQo+ICAgIDB4MDAwMDUwMTAgOTAyMDAwMDAgMDAwMDAwMDAgYTMyMDAwMDAgMDAwMDAwMDAg
LiAuLi4uLi4uIC4uLi4uLg0KPiAgICAweDAwMDA1MDIwIGI2MjAwMDAwIDAwMDAwMDAwIDI0MjAw
MDAwIDAwMDAwMDAwIC4gLi4uLi4uJCAuLi4uLi4NCj4gICAgMHgwMDAwNTAzMCAwMDIwMDAwMCAw
MDAwMDAwMCBiYjIwMDAwMCAwMDAwMDAwMCAuIC4uLi4uLi4gLi4uLi4uDQo+IA0KPiBvYmpkdW1w
IC1EIHRlc3RfZW5jbC5lbGYgfCBncmVwIGRvX2VuY2xfDQo+ICAgIDAwMDAwMDAwMDAwMDIwMDAg
PGRvX2VuY2xfZW1vZHBlPjoNCj4gICAgMDAwMDAwMDAwMDAwMjAyNCA8ZG9fZW5jbF9lYWNjZXB0
PjoNCj4gICAgMDAwMDAwMDAwMDAwMjA2NCA8ZG9fZW5jbF9vcF9wdXRfdG9fYnVmPjoNCj4gICAg
MDAwMDAwMDAwMDAwMjA3YSA8ZG9fZW5jbF9vcF9nZXRfZnJvbV9idWY+Og0KPiAgICAwMDAwMDAw
MDAwMDAyMDkwIDxkb19lbmNsX29wX3B1dF90b19hZGRyPjoNCj4gICAgMDAwMDAwMDAwMDAwMjBh
MyA8ZG9fZW5jbF9vcF9nZXRfZnJvbV9hZGRyPjoNCj4gICAgMDAwMDAwMDAwMDAwMjBiNiA8ZG9f
ZW5jbF9vcF9ub3A+Og0KPiAgICAwMDAwMDAwMDAwMDAyMGJiIDxkb19lbmNsX2luaXRfdGNzX3Bh
Z2U+Og0KPiANCj4gRm9yIHJlZmVyZW5jZSwgdGhlIGZ1bGwgZW5jbF9ib2R5IGNvZGU6DQo+IA0K
PiAwMDAwMDAwMDAwMDAyMTc1IDxlbmNsX2JvZHk+Og0KPiAgICAgIDIxNzU6ICAgICAgIGYzIDBm
IDFlIGZhICAgICAgICAgICAgIGVuZGJyNjQNCj4gICAgICAyMTc5OiAgICAgICA0OSA4OSBmOCAg
ICAgICAgICAgICAgICBtb3YgICAgJXJkaSwlcjgNCj4gICAgICAyMTdjOiAgICAgICA0OCA4ZCAz
NSA3ZCAyZSAwMCAwMCAgICBsZWEgICAgMHgyZTdkKCVyaXApLCVyc2kgDQo+ICMgNTAwMCA8ZW5j
bF9idWZmZXIrMHgyMDAwPg0KPiAgICAgIDIxODM6ICAgICAgIDQ4IDhkIDdjIDI0IGI4ICAgICAg
ICAgIGxlYSAgICAtMHg0OCglcnNwKSwlcmRpDQo+ICAgICAgMjE4ODogICAgICAgYjkgMTAgMDAg
MDAgMDAgICAgICAgICAgbW92ICAgICQweDEwLCVlY3gNCj4gICAgICAyMThkOiAgICAgICBmMyBh
NSAgICAgICAgICAgICAgICAgICByZXAgbW92c2wgJWRzOiglcnNpKSwlZXM6KCVyZGkpDQo+ICAg
ICAgMjE4ZjogICAgICAgNDkgOGIgMDAgICAgICAgICAgICAgICAgbW92ICAgICglcjgpLCVyYXgN
Cj4gICAgICAyMTkyOiAgICAgICA0OCA4MyBmOCAwNyAgICAgICAgICAgICBjbXAgICAgJDB4Nywl
cmF4DQo+ICAgICAgMjE5NjogICAgICAgNzcgMGEgICAgICAgICAgICAgICAgICAgamEgICAgIDIx
YTIgPGVuY2xfYm9keSsweDJkPg0KPiAgICAgIDIxOTg6ICAgICAgIDQ4IDhiIDQ0IGM0IGI4ICAg
ICAgICAgIG1vdiAgICAtMHg0OCglcnNwLCVyYXgsOCksJXJheA0KPiAgICAgIDIxOWQ6ICAgICAg
IDRjIDg5IGM3ICAgICAgICAgICAgICAgIG1vdiAgICAlcjgsJXJkaQ0KPiAgICAgIDIxYTA6ICAg
ICAgIGZmIGUwICAgICAgICAgICAgICAgICAgIGptcCAgICAqJXJheA0KPiAgICAgIDIxYTI6ICAg
ICAgIGMzICAgICAgICAgICAgICAgICAgICAgIHJldA0KPiANCj4gVGh1cywgdGhlICJwcmVwYXJl
ZCBjb3B5IiB3aXRoIF9hYnNvbHV0ZV8gZnVuY3Rpb24gcG9pbnRlcnMgaXMgbG9hZGVkIA0KPiBm
cm9tIC5kYXRhIGFuZCBjb3BpZWQgb250byB0aGUgc3RhY2suIFRoZSBjb2RlIHRoZW4ganVtcHMg
dG8gdGhlIA0KPiBfYWJzb2x1dGVfIGZ1bmN0aW9uIGFkZHJlc3MgbG9hZGVkIGZyb20gdGhlIGxv
Y2FsIGNvcHksIGkuZS4sIF93aXRob3V0XyANCj4gZmlyc3QgcHJvcGVybHkgcmVsb2NhdGluZyB0
aGUgbG9hZGVkIGFkZHJlc3MuDQoNClRoYW5rcy4gIFlvdSBtZW50aW9uZWQgdGhpcyB3YXMgZ2Vu
ZXJhdGVkIGJ5ICItc3RhdGljIC1mUElDIC1PcyIgYnV0IEkgdGhpbmsNCnVzaW5nICItc3RhdGlj
LXBpZSAtZlBJRSAtT3MiIHdvdWxkIHByb2JhYmx5IGdlbmVyYXRlIHRoZSBzYW1lLg0KDQo+IA0K
PiA+IEkgYW0gbm90IHN1cmUgd2hldGhlciBhbGwgdGhvc2UgJ3JlbGEuZHluJyBtYXR0ZXJzIGR1
ZSB0byB0aGUgcmVhc29uIHlvdQ0KPiA+IG1lbnRpb25lZCBiZWxvdyAuLi4NCj4gPiANCj4gPiA+
IFNpbmNlIHRoZSBlbmNsYXZlIGxvYWRpbmcgcHJvY2VzcyBpcw0KPiA+ID4gZGlmZmVyZW50IGFu
ZCBnbGliYyBpcyBub3QgaW5jbHVkZWQsIHdlIGNhbm5vdCByZWx5IG9uIHRoZXNlIHJlbG9jYXRp
b25zDQo+ID4gPiB0byBiZSBwZXJmb3JtZWQgYW5kIHdlIG5lZWQgdG8gZG8gdGhlbSBtYW51YWxs
eS4NCj4gPiA+IA0KPiA+IA0KPiA+IC4uLiBoZXJlLg0KPiA+IA0KPiA+IFRob3NlIHJlbG9jYXRp
b24gdGFibGUgYXJlIG5vdCB1c2VkIGJ5IGVuY2xhdmUgYnVpbGRlciBhbnl3YXkuICBPbmx5ICIu
dHNjIg0KPiA+ICIudGV4dCIgYW5kICIuZGF0YSIgKyBzb21lIGhlYXAgYXJlIGJ1aWx0IGFzIGVu
Y2xhdmUuDQo+IA0KPiBZZXMsIHRoZSByZWxvY2F0aW9uIHRhYmxlIGlzIG5vdCB1c2VkIGJ5IHRo
ZSAodW50cnVzdGVkKSBlbmNsYXZlIA0KPiBidWlsZGVyLCBuZWl0aGVyIGJ5IGEgKHRydXN0ZWQp
IGluaXRpYWxpemF0aW9uIHN0dWIgaW5zaWRlIHRoZSBlbmNsYXZlLiANCj4gSGVuY2UsIHRoaXMg
Y29tbWl0IHRyaWVzIHRvIGFkZHJlc3MgdGhpcyBieSBfbWFudWFsbHlfIHJlbG9jYXRpbmcgdGhl
IA0KPiAob25seSkgbmVlZGVkIHJlbG9jYXRpb25zLg0KPiANCj4gPiA+IE5vdGU6IHRoZSBmaXJz
dCA0DQo+ID4gPiBzeW1ib2xzIGluIHRoZSByZWxvY2F0aW9uIHRhYmxlIGFib3ZlIGFyZSBmcm9t
IHRoZSBUQ1MgaW5pdGlhbGl6YXRpb24gaW4NCj4gPiA+IHRlc3RfZW5jbF9ib290c3RyYXAuUyBh
bmQgc2hvdWxkICpub3QqIGJlIHJlbG9jYXRlZCAoYXMgdGhlc2UgYXJlDQo+ID4gPiByZWxhdGl2
ZSB0byBlbmNsYXZlIGJhc2UgYXMgcGVyIFNHWCBzcGVjKS4NCj4gPiANCj4gPiBJIGRvbid0IHF1
aXRlIGZvbGxvdyBoZXJlLiAgUGVyIG15IHVuZGVyc3RhbmRpbmcgVENTIHBhZ2VzIGNhbiBiZSBh
bnkgcGFnZQ0KPiA+IHdpdGhpbiB0aGUgZW5jbGF2ZS4gIEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFu
ZCB3aGF0IGRvZXMgInJlbG9jYXRlZCIgbWVhbiBoZXJlLg0KPiANCj4gWWVzLCB0aGUgVENTIGNh
biBiZSBhbnkgcGFnZSBpbiB0aGUgZW5jbGF2ZSwgYXMgdGhlIGFyY2hpdGVjdHVyYWwgDQo+IGRl
ZmluaXRpb25zIGFyZSBleHBsaWNpdGx5IHBvc2l0aW9uLWluZGVwZW5kZW50OiBPU1NBIGFuZCBP
RU5UUlkgYXJlIA0KPiBzcGVjaWZpZWQgYXMgYSByZWxhdGl2ZSBfb2Zmc2V0XyB0byB0aGUgZW5j
bGF2ZSBiYXNlIHJ1bnRpbWUgbG9hZCBhZGRyZXNzLg0KPiANCj4gVGhlIHRoaW5nIGlzLCB0aGVz
ZSBmaWVsZHMgYXJlIGluaXRpYWxpemVkIGluIHRlc3RfZW5jbF9ib290c3RyYXAuUyBhcyANCj4g
c3ltYm9scyB0byBmaWxsZWQgaW4gYnkgdGhlIGxpbmtlcjoNCj4gDQo+ICAgICAgICAgIC5zZWN0
aW9uICIudGNzIiwgImF3Ig0KPiAgICAgICAgICAuYmFsaWduIDQwOTYNCj4gDQo+ICAgICAgICAg
IC5maWxsICAgMSwgOCwgMCAgICAgICAgICAgICAgICAgIyBTVEFURSAoc2V0IGJ5IENQVSkNCj4g
ICAgICAgICAgLmZpbGwgICAxLCA4LCAwICAgICAgICAgICAgICAgICAjIEZMQUdTDQo+ICAgICAg
ICAgIC5xdWFkICAgZW5jbF9zc2FfdGNzMSAgICAgICAgICAgIyBPU1NBDQo+ICAgICAgICAgIC5m
aWxsICAgMSwgNCwgMCAgICAgICAgICAgICAgICAgIyBDU1NBIChzZXQgYnkgQ1BVKQ0KPiAgICAg
ICAgICAuZmlsbCAgIDEsIDQsIDEgICAgICAgICAgICAgICAgICMgTlNTQQ0KPiAgICAgICAgICAu
cXVhZCAgIGVuY2xfZW50cnkgICAgICAgICAgICAgICMgT0VOVFJZDQo+IAkvKiBzbmlwcGVkICov
DQo+IA0KPiBUaHVzLCB3aGVuIGNvbXBpbGluZy9saW5raW5nIHdpdGggIi1zdGF0aWMtcGllIiwg
dGhlIGxpbmtlciAob2J2aW91c2x5IA0KPiBub3QgYXdhcmUgb2YgU0dYIFRDUyBzZW1hbnRpY3Mp
IHdpbGwgdHJlYXQgdGhlc2Ugc3ltYm9scyBhcyAibm9ybWFsIiBhbmQgDQo+IHJlY29nbml6ZSB0
aGF0IHRoZXkgbmVlZCB0byBiZSByZWxvY2F0ZWQgYXMgdGhleSBhcmUgYWJzb2x1dGUgKG5vbi1S
SVAgDQo+IHJlbGF0aXZlKSByZWZlcmVuY2VzIGFuZCBwbGFjZXMgdGhlbSBpbiAiLnJlbGEuZHlu
IjoNCg0KUmlnaHQuICBFdmVuIGZvciAiLXN0YXRpYy1waWUiIGl0J3Mgc3RpbGwgcG9zc2libGUg
dG8gZ2VuZXJhdGUgInJlbGEuZHluIiBmb3INCnRob3NlIGhhdmUgdG8gdXNlIGFic29sdXRlIGFk
ZHJlc3NpbmcuDQoNCj4gDQo+IFJlbG9jYXRpb24gc2VjdGlvbiAnLnJlbGEuZHluJyBhdCBvZmZz
ZXQgMHg0MDAwIGNvbnRhaW5zIDEyIGVudHJpZXM6DQo+ICAgICBPZmZzZXQgICAgICAgICAgSW5m
byAgICAgICAgICAgVHlwZSAgICAgICAgICAgU3ltLiBWYWx1ZSAgICBTeW0uIE5hbWUNCj4gKyBB
ZGRlbmQNCj4gIyB0Y3MxLm9zc2ENCj4gMDAwMDAwMDAwMDEwICAwMDAwMDAwMDAwMDggUl9YODZf
NjRfUkVMQVRJVkUgICAgICAgICAgICAgICAgICAgIDcwMDANCj4gIyB0Y3MxLm9lbnRyeQ0KPiAw
MDAwMDAwMDAwMjAgIDAwMDAwMDAwMDAwOCBSX1g4Nl82NF9SRUxBVElWRSAgICAgICAgICAgICAg
ICAgICAgMjFlMw0KPiANCj4gVGh1cywgbXkgZWFybGllciBjb21tZW50IHNheXMgdGhhdCB3ZSBj
YW4gc2FmZWx5IGlnbm9yZSB0aGVzZSANCj4gYXBwYXJlbnQvZmFsc2UgVENTICJyZWxvY2F0aW9u
cyIuDQoNClllYWguICBJIGd1ZXNzIHRoYXQncyB3aHkgdGhlIHRlc3RfZW5jbC5lbGYgbXVzdCBi
ZSBidWlsdCBzdGFydGluZyBmcm9tIGFkZHJlc3MNCjAuDQoNCj4gDQo+ID4gSSB0aGluayB3ZSBh
cmUga2luZGEgbWl4aW5nIHR3byB0aGluZ3MgdG9nZXRoZXI6IDEpIHRoZSAicmVsb2NhdGlvbiIg
c3VwcG9ydGVkDQo+ID4gYnkgdGhlICJub24tZW5jbGF2ZSIgbm9ybWFsIGNhc2UsIHdoZXJlIHRo
ZSBjb21waWxlci9saW5rZXIgZ2VuZXJhdGVzIHRoZSBQSUMNCj4gPiBjb2RlLCBhbmQgdGhlIGxv
YWRlciBkb2VzIHRoZSAicnVudGltZSIgZml4dXAgZm9yIHRob3NlIGluIHRoZSAicmVsYS5keW4i
OyAyKQ0KPiA+IHRoZSAicmVsb2NhdGlvbiIgZm9yIHRoZSBlbmNsYXZlIGNhc2UsIHdoZXJlIHRo
ZSBjb21waWxlci9saW5rZXIgc3RpbGwgZ2VuZXJhdGVzDQo+ID4gdGhlIFBJQyBjb2RlLCBidXQg
dGhlICJlbmNsYXZlIGxvYWRlciIgbG9hZHMgdGhlIGVuY2xhdmUgaW50byBhIHJhbmRvbSB2aXJ0
dWFsDQo+ID4gYWRkcmVzcyBvZiB0aGUgcHJvY2Vzcy4NCj4gPiANCj4gPiBPYnZpb3VzbHkgdGhl
ICJlbmNsYXZlIGxvYWRlciIgKGltcGxlbWVudGVkIGluIHRoaXMgc2VsZnRlc3RzL3NneC8uLi4p
IGlzbid0IGFzDQo+ID4gcG93ZXJmdWwgYXMgdGhlICJyZWFsIGxvYWRlciIgaW4gdGhlIG5vcm1h
bCBjYXNlLiAgSW4gZmFjdCwgcmVhZGluZyB0aGUgY29kZSwNCj4gPiBJSVVDLCBpdCBzaW1wbHkg
Z2F0aGVycyAiLnRzYyIvIi50ZXh0Ii8iLmRhdGEiIHNlY3Rpb25zIGZyb20gdGhlIEVMRiBmaWxl
IChhbmQNCj4gPiBwbHVzIHNvbWUgaGVhcCkgYW5kIGxvYWQgdGhlbSBpbnRvIHRoZSBlbmNsYXZl
Lg0KPiANCj4gQWdyZWVkLCB0aGUgImVuY2xhdmUgbG9hZGVyIiBzaG91bGQgc2ltcGx5IGNvcHkg
dGhlIHNlY3Rpb25zIGludG8gRVBDIA0KPiBtZW1vcnkgd2l0aG91dCBiZWluZyBhICJyZWFsIGxv
YWRlciIuIFBhcnRpY3VsYXJseSwgaXQgc2hvdWxkICpub3QqIGRvIA0KPiBhbnkgcmVsb2NhdGlv
bnMgYXMgdGhhdCB3b3VsZCBjaGFuZ2UgdGhlIGNvZGUgYW5kLCBoZW5jZSwgdGhlIE1SRU5DTEFW
RSANCj4gc2lnbmF0dXJlLg0KDQpZZWFoLg0KDQo+IA0KPiA+IA0KPiA+IE5vdyB0aGUgaW1wb3J0
YW50IHRoaW5nIGlzOiB0aG9zZSBzZWN0aW9ucyBhcmUgImNvbnRpZ3VvdXMiIGluIHRoZSBlbmNs
YXZlLg0KPiA+IFRoYXQgbWVhbnMgdGhlIGtlcm5lbCBuZWVkcyB0byBidWlsZCB0aGUgZW5jbGF2
ZSBFTEYgZmlsZSB3aXRoIHRob3NlIHNlY3Rpb25zDQo+ID4gImNvbnRpZ3VvdXNseSIgaW4gdGhl
IHNhbWUgb3JkZXIgdG9vIGFzIGEgc2luZ2xlIHBpZWNlLCBhbmQgdGhpcyBzaW5nbGUgcGllY2UN
Cj4gPiBjYW4gd29yayBhdCBhbnkgcmFuZG9tIGFkZHJlc3MgdGhhdCB0aGUgImVuY2xhdmUgbG9h
ZGVyIiBsb2FkcyB0aGUgZW5jbGF2ZS4gIEFueQ0KPiA+IGFkZHJlc3MgZml4aW5nIHVwIGR1ZSB0
byBkaWZmZXJlbnQgbG9jYXRpb24gb2YgIi5kYXRhIi8iLnRzYyIgc2VjdGlvbiBhdCBsb2FkaW5n
DQo+ID4gdGltZSBjYW5ub3QgYmUgZ2VuZXJhdGVkLg0KPiA+IA0KPiA+IFRoaXMgc2hvdWxkIGJl
IHRoZSB0aGluZyB0aGF0IHdlIG5lZWQgdG8gZm9jdXMgb24uDQo+ID4gDQo+IA0KPiBBZ3JlZWQu
IFRoYXQncyB3aHkgYW55IF9uZWNlc3NhcnlfIHJlbG9jYXRpb25zIG5lZWQgdG8gaGFwcGVuICpp
bnNpZGUqIA0KPiB0aGUgZW5jbGF2ZSwgYnkgdGhlIGFwcGxpY2F0aW9uIG9yIGEgc21hbGwgaW5p
dGlhbGl6YXRpb24gc3R1Yiwgc3VjaCANCj4gdGhhdCB0aGUgZW5jbGF2ZSBNUkVOQ0xBVkUgaWRl
bnRpdHkgaXMgaW5kZXBlbmRlbnQgb2YgaXRzIGxvYWQgYWRkcmVzcy4NCj4gDQo+ID4gVGhhdCBi
ZWluZyBzYWlkLCBJIHRoaW5rIGlkZWFsbHkgdGhlcmUgc2hvdWxkbid0IGJlIF9BTllfICJyZWxh
LmR5biIgaW4gdGhlDQo+ID4gZW5jbGF2ZSBFTEYgZmlsZS4NCj4gDQo+IEFncmVlZCwgdGhpcyB3
b3VsZCBiZSAiaWRlYWwiLiBIb3dldmVyLCBJIGRvbid0IHNlZSBhIHdheSB0byBnZW5lcmF0ZSAN
Cj4gdGhlIGZ1bmN0aW9uLXBvaW50ZXIgdGFibGUgd2l0aG91dCBuZWVkaW5nIGEgcnVudGltZSBy
ZWxvY2F0aW9uLiBGb3IgYWxsIA0KPiBvdGhlciBjb2RlLCB3ZSBkb24ndCBoYXZlIHRvIGNhcmUg
YWJvdXQgdGhpcyBhbmQgd2UgY2FuIHNpbXBseSByZWx5IG9uIA0KPiAtc3RhdGljLXBpZSBhbmQg
LWZQSUUgdG8gZW1pdCBSSVAtcmVsYXRpdmUgY29kZSB3aXRob3V0IG5lZWRpbmcgDQo+IHJlbG9j
YXRpb25zLiBBZmFpcywgd2hlbiBzdG9yaW5nIGFuIGFkZHJlc3MgaW4gYSB2YXJpYWJsZSwgYSBy
ZWxvY2F0aW9uIA0KPiBpcyBuZWVkZWQuDQoNClllYWguICBUaGFua3MuDQoNCj4gDQo+IEkgYWdy
ZWUgdGhvdWdoIHRoYXQgd2UgZG8gKm5vdCogbmVlZCBhIGZ1bGwgLnJlbGEuZHluIHBhcnNlciBo
ZXJlIGFuZCANCj4gY2FuIHNpbXBseSBtYW51YWxseSByZWxvY2F0ZSB0aGUgb25seSByZWxldmFu
dCBjYXNlIGhlcmUsIGllIGVuY2xfb3BfYXJyYXkuDQo+IA0KPiA+IEkgYWdyZWUgd2Ugc2hvdWxk
IHVzZSAiLXN0YXRpYy1waWUiICsgIi1mUElFIiAob3IgIi1mUElDIiBpcyBhbHNvIE9LPz8pLg0K
PiANCj4gTm90IHN1cmUgb24gdGhlIGV4YWN0IGRpZmZlcmVuY2UgYmV0d2VlbiAtZlBJRSBhbmQg
LWZQSUMuIEkgY2hhbmdlZCB0byANCj4gLWZQSUUgYmVjYXVzZSBnY2MgbWVudGlvbnMgaW4gdGhl
IGRvY3VtZW50YXRpb24gZm9yICItc3RhdGljLXBpZSIgdGhhdDoNCj4gDQo+IEZvciBwcmVkaWN0
YWJsZSByZXN1bHRzLCB5b3UgbXVzdCBhbHNvIHNwZWNpZnkgdGhlIHNhbWUgc2V0IG9mIG9wdGlv
bnMgDQo+IHVzZWQgZm9yIGNvbXBpbGF0aW9uICgtZnBpZSwgLWZQSUUsIG9yIG1vZGVsIHN1Ym9w
dGlvbnMpIHdoZW4geW91IA0KPiBzcGVjaWZ5IHRoaXMgbGlua2VyIG9wdGlvbi4NCg0KWWVhaCBJ
IGd1ZXNzIHdlIHNob3VsZCBqdXN0IHVzZSAiLWZQSUUiLg0KDQpbLi4uXQ0KDQo=
