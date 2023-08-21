Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C848782794
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHULKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHULKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:10:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F4C2;
        Mon, 21 Aug 2023 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692616216; x=1724152216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iV/4y5BAxB63K/fdA2f+16y0Q2Rtu3kXJQUOy4NRVnk=;
  b=XQJfW4YNoFoYeL32cXW5RWl33wm6lvwMpGTDDFXjAdMjZMR70MBohNpO
   IIfLsOHxXnVEXVG4OpziVwYar55UOWfYmYebeISAEO3GaWWwcipnkrz7x
   L8AR2nIAfZEV8dtCwAlC2+dsM9o2TtdwKgt1D50fZwruvw2YNQGOc1dF8
   qt0aUig4tAYHkpUFuKS6bXx1jYi4ll9oz+AtXqeubtQkgyN48Ja8I33k1
   nps2b2aso/wf8Kx1Slv7TeULp2imIJ5/5rKXYzTJ9uewVy5rwzbfWdKzE
   lIhzfw5oazKJy4gG8GsAEG8jp+Me7MQGDP0w/ySY4qSvIfHMs0w42OYUR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="439932781"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="439932781"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765329446"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="765329446"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 04:10:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 04:10:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 04:10:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 04:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9ohLMcCfG5s/dcdynU1tfSy4LAmeomOUuek3YybSDBSdJ03FH7eNIQIc5hl19byYTgdH+Zj90YA1gN0n/jAOc72veCU7TsFDLgaIr6IhubRCzztZEFj2gq34UywIETxdzYWgLklEHl5XHqTy3mP01gipsn0VrthTPMIlz7QXK4KA7YNFM7BsKRX2QTBFtzUpOspOV6p3dDBUGBLmsQSk3gW0qPFRtYrlZatR8Iwiwfr5jMRFhpSZB4kh1ULBH0os/feEVriKSXbSS7sfG5Y63yXdzowx0T2QdUqsgXzht4BDPB/samwefozec0/NPbdbR1B8ZggYGVX4D2nJT02Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV/4y5BAxB63K/fdA2f+16y0Q2Rtu3kXJQUOy4NRVnk=;
 b=aZfJDmPmNh1H5kc+6pZtfNhS41GMYmbfinftB5lpQGQhSU7F7RcKw1Sp0BA0FGccQ8eZazCZ0LlIHOocZ7NcvRbGk9OTUL62VF6AffmwB1IGsMk42z8Z6CBTR4jsOsz12EJjC4rjKr9rZpH56nRfGq8toEFY0OxaYV4QsWEgXYCK1WzyOPP8Hp6CiWjxBYo28qiGhP/SpBotUA+kdnHbFcUFvM9Fl1lMn/G+T9SIGg4TqdzU8CvZ2saBUBAiAS1SVYkE2VbiBFzIV96N6KgEqwgUzFif0Vxe6+Lp8WMbLy5VNDW5yXZ+aUjKES1ALziX7OEOpJP641pAZy9qpX91CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:10:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:10:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 6/9] selftests/sgx: Ensure test enclave buffer is
 entirely preserved
Thread-Topic: [PATCH v3 6/9] selftests/sgx: Ensure test enclave buffer is
 entirely preserved
Thread-Index: AQHZ0oHQkIBy2IUJ3kWT3igyI0XjT6/0mxUA
Date:   Mon, 21 Aug 2023 11:10:12 +0000
Message-ID: <555e9e6dff49a460d51de4c25ce8016343cd691a.camel@intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
         <20230819094332.8535-7-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-7-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: 76ed4382-ba0d-4cbc-f65c-08dba23730ba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/U4bGYxrxxg+eZRLyTyF6d4noQDWquQkfdViJXLv6PWvD2bq7H6Z9WumZ4wfW4HwDoQnAiKBkHGUX+pVl24ouvNx9PXTV6Ugps6EjpQyvKtd/KxSKVwSkwLukJZChLRZnVuhEgK6+oCQQZTlSv1IOZn7tZ8c96aUO+1+/2tgb1PIZx66PT2Vljw+61bVTip19PGF6YwOFJQaNHvngQ6MTpr/QXZREdNd1oSOGklCOR2egWopuFRDnOD+RI580sB7ZLfjwli98/cWzQZteyG3KHFC5it04nx8P913QIPkWQyKKoA3mwIhbkPQFQaUaGhEfUOStez/ws02xzJfpdq4xzhRJiIRf3s2RqHv6k3YQt+uDIdm1Ue7e6uQa1sakkNI4EKWQy6/Q/o6VzqWIEGHy9xCkK7Nr0YY3PJcHg5thns15NB6NqgjDDcY2TwBqtWw78xrKiD2itzWZeV8F0abcEdDWWKjCYUB7icu7x81DA4Koa8KGtZ/uTz1GK/M6/lqIT5fw1zJh1pODIKqJw21K5ospzbf8yluTlUm8A3qJScU3Q0ftEAaUtyqZhhCaqOdDsQjM9DMqkYi2DSuiwsmjIfu8zUIzwFJTIK5lPs77w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(451199024)(186009)(66556008)(41300700001)(66446008)(64756008)(66476007)(76116006)(66946007)(110136005)(91956017)(316002)(6486002)(6506007)(82960400001)(38070700005)(122000001)(38100700002)(26005)(8936002)(8676002)(4326008)(5660300002)(2616005)(83380400001)(6512007)(2906002)(86362001)(36756003)(71200400001)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0haMDdxUzhmMFlNdzkwbzkxSDhNbTBWMElBNE9sRk5WaDBuZElmd2lwWHFX?=
 =?utf-8?B?bzh1czI5RUR0dnRPRmdYaVV6WU1iL2hxdXkzK2dmZXNCLzUwNElZREpQVWxZ?=
 =?utf-8?B?aUp6NEVlR2tKYUpWbFdEUzJwamljYUgrOVEwZGNXYUFicTFYZlA1ZFVGOVVV?=
 =?utf-8?B?bXhFRStZKzdpY0trUHo5bnQzSVovTWtmamE5SWkxVWZLSkI3R29rVHFBRjI2?=
 =?utf-8?B?V2pJQTlzV2RESjJtc3drTlptOHhUVkNSdEtVaTRzaEVySWFiSTJuK25CSE93?=
 =?utf-8?B?dDFGWE5KcTErbHpjc3ZXTHpyaEpnYkpmbE5Ocy9kZXo3SEJmWTY0YVI4UC9v?=
 =?utf-8?B?WmlUWkR3L1NkMW00MklQYUJGSzVURmkwTWcwcGs4L2JObTBieG5DemF6clE4?=
 =?utf-8?B?Yk5WMC8yRCtYMUszNEN0SjkybEpyZ1pmZnhoSTg2bHBhK2NVTEZhVmhqazVB?=
 =?utf-8?B?OTNZTzBCU05CZGhqMHVRc05sVENCWXN1WlNDVUp6enBqeVkwTmMrZGp4RXMw?=
 =?utf-8?B?Y2NITzJVc254ajMwbnBxMHFBSHYxVW1hSys4WUVEelVlVHMwOGZKYytoNEZ6?=
 =?utf-8?B?c3MvbnBxTkRjM01JdG9VRUJrcTB6VlI3elEwaUgzNEFBdFIxSTgwZWpFZGd5?=
 =?utf-8?B?a25pZjVFeVhQSVIrU0dPazNMTXk0N3hDQzdkMkxqUnkzcXRqak9Wc00va20w?=
 =?utf-8?B?cmdiZ09KeG5PNHk3VEpMZndCSFcyQVVxeHRIbzJNZzBNTkxXYzF1OXlZMkR6?=
 =?utf-8?B?QzNMMk45UUc3Vm1YSGhvYVhGL3JneXpFcWg4bGZFODNoMmZLS1VodmJOQTM2?=
 =?utf-8?B?SFBjdTNrR2NyZUVQdVpiZHl0L0hOTHR5SDhXUis5dllrd3YzUFE3ZWVVUmQw?=
 =?utf-8?B?Qk9yb1IweDV4ZDdJODNEL0k5a3crWjVpMm0xSmI4RjJhRDB1V2kvN3B4NWJM?=
 =?utf-8?B?aysvL09OM1pxczQ0cDFDTzVLeFlsMXNBajdOY051K2hmbkhVY3VVR2RmZyto?=
 =?utf-8?B?Z0V5UG1IVVp0VHpQdmFsKzNmV3hyUGxkNFN4alJ5dUtkQ3JZWFFReUpNNkhW?=
 =?utf-8?B?TzNVV1NIMEVEeXVKY0JEUS85Tm5PL09VSW50V05mWVVqYzRicFhzK1J1Y295?=
 =?utf-8?B?Z0pseW9HRVpuV1JxcjhCZFhxSjF5YnZsbGl3MmxyT3BTZWhoT01wWHlDbEpq?=
 =?utf-8?B?MXBhTVJUNjJIbnZxQklxd0ZGUUZuazR1di90emR6dHZPc3NjQ2tWMDBuSjF3?=
 =?utf-8?B?aHgxOWxvT3Q5cEpVaC92ZUFrSlcrdEcvR1Jpa3VIUVZZWWRtcTdkN3M5ZTB2?=
 =?utf-8?B?ZUVGN2F2NDJVK1JEMkVwTGVsY25BZlJkUGNNUUkwaTRVNVQ2TUQ0emg5K1Rn?=
 =?utf-8?B?QWlMT2lvd0FsSkltb1Bta3hBaE9YWUlYdGZIYXNuaDV2WlFmZEU1bHNjMUVN?=
 =?utf-8?B?RU9ROHVHb0p0dDdabXhPaW8vNms3UEpEMXZGUmtuYkgwc0MwSFVNMzdCbTNS?=
 =?utf-8?B?dFJQaWhBYkNFa2EvQWlnTFpoWXJ3QlpZb1JHWEJYeWxRNmhVdEJjQ1BPeWhv?=
 =?utf-8?B?akJ1d0NnT0N0MUQvTTZjWG5jWThwaVVFeHExMGZ5OWpOcHpuNFRKNGtDVC9w?=
 =?utf-8?B?eEpidU1XWDk4Vnp2TXhlTHFqNk1sTW5rU3plRUlNSzhoYzVEdDl6S0VHb2R6?=
 =?utf-8?B?dGJTVitPWnViMjh3b0ZER2t2NUhmYmgvZHl3djNxZ1BodFFtU2tULzZHRS9P?=
 =?utf-8?B?VWhVem5yWGdsL2Z1amk1M1Q0Mi9WalpwYWk0eGFxNWdlTS9nN09MNnRzSVlH?=
 =?utf-8?B?M2VYN0xGRFQ1MmlhdC9IOFh0VXViR0FvRys5VFROdCtwYmFuK2RNVEE0UGNw?=
 =?utf-8?B?bi9lMElHWDRweVlLZFlXcHp1WjhJa05jZ0ZSSnZQZmErczBYRktTbHl4c05B?=
 =?utf-8?B?cXV3STF3N3dVQXV1RCtERS9qcExwL0gzaUZ5Y2VqWEl5cjAvdnAyU3BzKzBX?=
 =?utf-8?B?ZnRBMFJ0VFJ1QmNhNHpLL0JqTmlMNStrOFdvdkJGQzgyZ3ZPdXhIVmQzN1Mw?=
 =?utf-8?B?ZnBocnFVZW5MWEJ6ZHZLdG5WUkR1TnhZaHFHbVFhaTh6ZTJVVzcyUG8zdXFC?=
 =?utf-8?Q?7S1EJxlzZPmwS4yb8yO7jnOi4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB28DA39CEE79E46BB94750A3761A978@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ed4382-ba0d-4cbc-f65c-08dba23730ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:10:12.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2XYHF2ek36BPe8e2qyhEvKCvFcqrHDvekk1VHpVUXgodEUCbZ++42pl6qpt6ruoTs30GNUzVokFWxfndrax6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDExOjQzICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEF0dGFjaCB0aGUgInVzZWQiIGF0dHJpYnV0ZSB0byBpbnN0cnVjdCB0aGUgY29tcGlsZXIgdG8g
cHJlc2VydmUgdGhlIHN0YXRpYw0KPiBlbmNsX2J1ZmZlciwgZXZlbiBpZiBpdCBhcHBlYXJzIGl0
IGlzIG5vdCBlbnRpcmVseSByZWZlcmVuY2VkIGluIHRoZSBlbmNsYXZlDQo+IGNvZGUsIGFzIGV4
cGVjdGVkIGJ5IHRoZSBleHRlcm5hbCB0ZXN0cyBtYW5pcHVsYXRpbmcgcGFnZSBwZXJtaXNzaW9u
cy4NCj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hMjczMjkzOC1mM2Ri
LWEwYWYtM2Q2OC1hMTgwNjBmNjZlNzlAY3Mua3VsZXV2ZW4uYmUvDQo+IFNpZ25lZC1vZmYtYnk6
IEpvIFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+IC0tLQ0KPiAgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L2RlZmluZXMuaCAgIHwgMSArDQo+ICB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgfCA5ICsrKysrLS0tLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L2RlZmluZXMuaCBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NneC9kZWZpbmVzLmgNCj4gaW5kZXggZDg1ODdjOTcxLi5iOGY0ODI2NjcgMTAw
NjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9kZWZpbmVzLmgNCj4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L2RlZmluZXMuaA0KPiBAQCAtMTMsNiArMTMs
NyBAQA0KPiAgDQo+ICAjZGVmaW5lIF9fYWxpZ25lZCh4KSBfX2F0dHJpYnV0ZV9fKChfX2FsaWdu
ZWRfXyh4KSkpDQo+ICAjZGVmaW5lIF9fcGFja2VkIF9fYXR0cmlidXRlX18oKHBhY2tlZCkpDQo+
ICsjZGVmaW5lIF9fdXNlZCBfX2F0dHJpYnV0ZV9fKCh1c2VkKSkNCj4gIA0KPiAgI2luY2x1ZGUg
Ii4uLy4uLy4uLy4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NneC5oIg0KPiAgI2luY2x1ZGUgIi4u
Ly4uLy4uLy4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2VuY2x1LmgiDQo+IGRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gaW5kZXggYjA5NTUwY2IzLi5jN2JjYmM4NWIgMTAw
NjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gQEAgLTUsMTEg
KzUsMTIgQEANCj4gICNpbmNsdWRlICJkZWZpbmVzLmgiDQo+ICANCj4gIC8qDQo+IC0gKiBEYXRh
IGJ1ZmZlciBzcGFubmluZyB0d28gcGFnZXMgdGhhdCB3aWxsIGJlIHBsYWNlZCBmaXJzdCBpbiAu
ZGF0YQ0KPiAtICogc2VnbWVudC4gRXZlbiBpZiBub3QgdXNlZCBpbnRlcm5hbGx5IHRoZSBzZWNv
bmQgcGFnZSBpcyBuZWVkZWQgYnkNCj4gLSAqIGV4dGVybmFsIHRlc3QgbWFuaXB1bGF0aW5nIHBh
Z2UgcGVybWlzc2lvbnMuDQo+ICsgKiBEYXRhIGJ1ZmZlciBzcGFubmluZyB0d28gcGFnZXMgdGhh
dCB3aWxsIGJlIHBsYWNlZCBmaXJzdCBpbiB0aGUgLmRhdGENCj4gKyAqIHNlZ21lbnQuIEV2ZW4g
aWYgbm90IHVzZWQgaW50ZXJuYWxseSB0aGUgc2Vjb25kIHBhZ2UgaXMgbmVlZGVkIGJ5IGV4dGVy
bmFsDQo+ICsgKiB0ZXN0IG1hbmlwdWxhdGluZyBwYWdlIHBlcm1pc3Npb25zLCBzbyBtYXJrIGVu
Y2xfYnVmZmVyIGFzICJ1c2VkIiB0byBtYWtlDQo+ICsgKiBzdXJlIGl0IGlzIGVudGlyZWx5IHBy
ZXNlcnZlZCBieSB0aGUgY29tcGlsZXIuDQo+ICAgKi8NCj4gLXN0YXRpYyB1aW50OF90IGVuY2xf
YnVmZmVyWzgxOTJdID0geyAxIH07DQo+ICtzdGF0aWMgdWludDhfdCBfX3VzZWQgZW5jbF9idWZm
ZXJbODE5Ml0gPSB7IDEgfTsNCj4gIA0KPiAgZW51bSBzZ3hfZW5jbHVfZnVuY3Rpb24gew0KPiAg
CUVBQ0NFUFQgPSAweDUsDQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5j
b20+DQo=
