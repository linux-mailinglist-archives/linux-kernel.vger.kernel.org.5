Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D97AF1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjIZRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIZRTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:19:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F10CE;
        Tue, 26 Sep 2023 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695748738; x=1727284738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iMZ9SM3fsofKM0GuRaHYARFw0scvNbmSyA2VmS4bk3U=;
  b=M09iRajDwHp+k2akaBBEPZskWyqqa0lDUA38m0SB49KS+sXQAZzEei85
   IAAVcbmVUwpex2uLcHLq7EyBeTIaJfDEf+ZCw8UfQQWYB0rDyDre1THlY
   I3L4Vo5rYYsxsJ5nREtGmifleThU/26uyOijCU79vCFmMqI9Ntyf9nc53
   g/eoAQQKlDIuEwSBqyaLbDVh9Gg8FdqzPTwQi7obXlcc887x2RokTnjJg
   ZfAlW69m/LQXbnm1loWFKyoaesTWFcN2txWHJO4zUcSBk3rBFyLRPZl0c
   +oDaXjMzHeDlqOCrHZcDkqb0zFFmdU80aKDNrAUOOFlWUlhBiyZFDzHgx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366683559"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="366683559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="232303"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 10:18:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 10:18:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 10:18:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 10:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTWRBdT6cyb2CmHB+PPBYmxTL15SLeweYXLRqAFTMO8nfDp3d9t9AHbB5UQngt8MGVwahkTgc4GAnXnaYsE1+DrPl5uUDESEf9bkGw+g0VABkWwHAWPSMRqvZhC8f5RQ5nkn9uyTOUz3Bp6ooX87YtJvvAVAa55lTmHyYFaeNq49f4fMY30C2frXIA6aylA0wNzppj0qafjVpbB3AnoNDEAfGxfHXjKQ1Mah4C/fvTw+Tk3sXzPVHk4GHKxAVKXTXPg/h5sTL6KK/9KUPQsN+/cgsFYr3r/EwATS1jb40vRC3yZBKDN1HdR6DR1CtNpx2qKIsX5rN8OMAXJe0YiNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMZ9SM3fsofKM0GuRaHYARFw0scvNbmSyA2VmS4bk3U=;
 b=KCgSjhtaiuEDicUq3OwFcW4cz4Q+bFbaGXkHEEVAjkC/AyhK5uQYS2bUzxmgXsE4GXYgG72jn+wxfOPR56gf0cPb8vvVEgqEwFZ0yGdE7dnu+P3KBH4CLdfBN56KCwXz8F+E5sblMclduDU/34SPiIRnpk1TZ9LN6neoTk2V5PhZEsnpnNGyJvrcrtCGvvGvZ3RkJuB0/mFMS8s7KcYb0r/GejCdA7AR1AIU4KVxa2c7QBxGDBBv++2nVQ67joidQZS5wx3OHbcdhaWgnohEv7tiM29cIuO5fkgeJ1X0JJq8mJiuWqvp+Bex4rq4vFiLb+Nv/p6JhH2jxXuOEo7UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 17:18:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 17:18:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Topic: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Index: AQHZ2tLJaZzqU2XJm0W9Zs4AKdu/JrAteXYAgAAKeVA=
Date:   Tue, 26 Sep 2023 17:18:32 +0000
Message-ID: <SJ1PR11MB6083E6C980B4BD1AD84ABDD7FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
 <e78da512-f8b4-6740-cb40-cac226c008bf@amd.com>
In-Reply-To: <e78da512-f8b4-6740-cb40-cac226c008bf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB8086:EE_
x-ms-office365-filtering-correlation-id: 81bdc703-02c5-4c10-0888-08dbbeb49c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amufPjgEn5icFGMTyZYaLPxGDhhEnoFGIGfNI9ATofi86Rxe86u4ZiovSQn2Gh9MHK68JatIas7L9wQxrPDodpVlLuj7goez5+juZPvBGBJ87jn+w5mBfoHRKitSJaOpqFQaPm04qeALWf2IjyjuxhYpx8W+bLE3X08CJIogB8MDBGgLGw6KQbliSFKD9ziKCjiiuQhS9k5fmBmufjYlbBjfWEBzn0lemQrfvNGmhvhK9jOklnaPWyD0WSBUgE0lolEl0cW8gIaLa04no4EyKrFdh3NyqTkYebhrMqxLlHdDifdqgm3akux+/t8ennINIka5nuuViLz0zGRM4nVch/LtAaPAjtyoMiFkyyyr6s3WLz1UepO9zDfojNMeAUyv9y1RekC7IV5wJEMA5PXKpIvdN/CFcg2YUkhyEcLKg3PGA/VJM+elNi6rWy9ywqOTzy45Fh96A5wAd2Jfe57Tvq5Hjpmk8roZU962c0ejsJDOsoaNvcczBITHo23PP/iHKPMgM7bk3A9pXaY656WZOvP1yXfOMKwGA8zlWBlVyjWwf8IDyKzxIjQNHDg86l5B6nLa38Ihsqc37dA3MrIqgA0GvajSwMAulcKy8aYkdAfN8HsKLcW8Hc9rGh7MVINz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(7696005)(6506007)(9686003)(52536014)(4326008)(82960400001)(71200400001)(8936002)(33656002)(7416002)(64756008)(4744005)(8676002)(2906002)(316002)(5660300002)(122000001)(86362001)(38100700002)(66446008)(478600001)(26005)(110136005)(38070700005)(76116006)(66946007)(55016003)(66476007)(66556008)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCtkcXlOdlRHazZQTXFaRVpTMERwbFh0OU1zQU42eDZaWFdSMVlHSW1PTDBJ?=
 =?utf-8?B?TDUxZi83TCtmV0xlUXV1TWVhbXlsb1pKR1U3SEhZRzVUVmJLT1ZFL3oxYlJV?=
 =?utf-8?B?TDVUWHVCdDhEL09XTjFBTzFXbG04UG91Nko1Ui9ZbGd3VjNFN2NlNDU1bUhz?=
 =?utf-8?B?RG9vMGpKQllsaWhQNEI4c3lnNGgycFprQWFMbFVwOTNta0ZNWWowUUQzVlVL?=
 =?utf-8?B?emVGRXlIaXhHSi92Tld2SEFLOWRCcVM1Ukt2ZTBTSHlSQ040SlpJWEdLdTNz?=
 =?utf-8?B?T0hkRkRiYVFPSFF2dmZWTWlQeVhwbkJuejBaZXB4SGlaYUdnUTg0WjVhZ1Er?=
 =?utf-8?B?T1FHZjBUb1o1SG16TjI3bUpIM1VKQmF3WUIrcUMzZDBrZTlrZURNa2owUE1S?=
 =?utf-8?B?Y2RVTDBvcGVZaG5VQU5vU2IrcklUUHFFQS9yaHJsWVJQNlpBalRwVmN5QjNm?=
 =?utf-8?B?dFZTUThLa1Y3UWVYRXVTRHJULzR0WXk2c254NGN4VjJ6L2xpcHZEdkdjRzN3?=
 =?utf-8?B?SFJBSmw5bitqRVVnRU16Yk9GVWdORDJUOUxncFZXeEg1LytKbkNmcDFIM1hM?=
 =?utf-8?B?L1o3RC9ZcmNtd01Qb0xrK2N0TXpHODNNUStOUkQ0cHJmbERNOXJINExEVi9P?=
 =?utf-8?B?RWsxVUF1T2NxK1gwdWZpS25tbnZydEZXdk51MnYrTWdiQnJQdGhMTXo0VG9q?=
 =?utf-8?B?UWZsVWNzRnNRMlo4UUxYcDJFT2tSTE90Rld3OTE2a0c0K0lyVzZyMVlLejlE?=
 =?utf-8?B?dlc3cTFBdjViY3pVSmJHMVgybjFycVplcUhsRndNbXFsZTN4bXpxTlYzOWd0?=
 =?utf-8?B?cm11MytiUlB0SnNGY2l6bm9YV1NnSjNxTm1lbDF0NE1KQnFmZDkwd3BDNG9N?=
 =?utf-8?B?WTNGdzBHSFFUOVBjSk1XZ1Z1aFcyTDJ2N2t2a1psZlhsZWhJb2h0YXQzRG54?=
 =?utf-8?B?c2s0SWk4czhBbWEzT2ZNUEZ3cU1ieXFqK2hycTRyS1crTXRDZW9aSVAxTVVt?=
 =?utf-8?B?RVFtUDIvZ1BhN2VQRVFVQVk0SnpKSUw3WmMzRlBBUE9kTFlMbGgyZTNIaWpP?=
 =?utf-8?B?c200RzBpZ0VRMkZ1a0tsWUxvUUxzdnJnREdwelV6TE5HWnVGemFDZ2x0R2hE?=
 =?utf-8?B?bjJUdk5FTUtSelZQbklYVHZNSHhwT205UStLZzRzOHlsSWNkUjVmcHEvY1p1?=
 =?utf-8?B?QmtvNkc4Q3FBQURFSURKSmVldTNLemNqRktEeFoyWXhwN2F0UjZFNzJITkJT?=
 =?utf-8?B?OVVZTlYvaVZDUXp2eDJjS09YZVlBd1NIZDVWYURYb05lUGtyeWxSQTZFWlFL?=
 =?utf-8?B?UUFaQmp0ZU92MFpsYzVmV2JWVW1SZ2VIS0JwWnp6WCtZY0ZybUdlSjBCK2JI?=
 =?utf-8?B?QjlGNHVQMytHZTdsZ0pZQnlsamV3QVRubDhIYTNZMk9NWXpUbDBnRVZBQ0hC?=
 =?utf-8?B?SXRJUllud0Q1cnI2aG9ObEE4LzlhNDVOY2N0QktkS3VMWWoxbWNXbm9UbklS?=
 =?utf-8?B?a1MvWXFGaTF1Q3cvN2s3SXlLdDJzQnRyN25VSGVBNUhXa2ZvdUFOS3crSTBP?=
 =?utf-8?B?dVV4d1RFZ2VBQUgxYzVFZjRDMDRsdUpoRFN4a3ljNVBhbXRQNThlcDRvWFk1?=
 =?utf-8?B?NlFzSytQblMydkc0RlYxYVg5QTdPTFhmaWtvU01yVU5OM3pEbXVnczlQa04y?=
 =?utf-8?B?d3d6bE5nTXBHejVmQS9OY0pNWU5RSWdzeURhaVh2aVZTdXcvKzZWYVpMVXA1?=
 =?utf-8?B?SzlWMktmR3hQOUF0L0dSVFA2Rk9VRUU0U2hCcFJKMVRISkt4S290RHNwZUtT?=
 =?utf-8?B?SlRWczcwTnRHcUVXUm9wSkVTNmR2SHhxS0hCRWRLUWJFS05xdFpxRFlhR0Q5?=
 =?utf-8?B?VjZxK3Z2TUxaTkhQZk9oOXpZME9Wa2ZiVWFsU0hDRzFXVWJvcWo3TXhPekw0?=
 =?utf-8?B?TVp6RDZWZDNhc1hZQnNHOExxUGp1eGQyRTUxYWhLSWdaSDAzalVCMVZEdU1I?=
 =?utf-8?B?T3dJdDV5U3VTeGpxdklTOTBUSE9mREpDMmFYWVk1R1ozK1RRb01DL3lFN3o4?=
 =?utf-8?B?bzgrNURhdlFwS0o1Tmg0SzZMUHZSSmdENzRRQUZjOEZQa3ZWYlQweXl0RlV5?=
 =?utf-8?Q?DLCoq4gj4eS5x//JmV0w49t9W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bdc703-02c5-4c10-0888-08dbbeb49c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 17:18:32.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWJBlDZP5XB5q+bhLAcif3N26+6AWrNT3t/LmelIezxx3RtsVqFoh8h/1IdnpT2ZVisB2hLzLV951gj7r1P7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
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

Pj4gK2VudW0gcmVzY3RybF9zY29wZSB7DQo+PiArCVJFU0NUUkxfTDNfQ0FDSEUsDQo+PiArCVJF
U0NUUkxfTDJfQ0FDSEUsDQo+PiArfTsNCj4NCj4gSG93IGFib3V0Pw0KPg0KPiBlbnVtIHJlc2N0
cmxfc2NvcGUgew0KPiAgICAgICBSRVNDVFJMX0wyX0NBQ0hFID0gMiwNCj4gICAgICAgUkVTQ1RS
TF9MM19DQUNIRSwNCj4gfTsNCg0KQmFidS4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpSZWlu
ZXR0ZSBtYWRlIHRoZSBzYW1lIG9ic2VydmF0aW9uLiBJJ20gdXBkYXRpbmcgdGhlDQpwYXRjaCB0
byBkbyB0aGlzLiBXaXRoIHNtYWxsIGV4dHJhIGRlZmVuc2l2ZSBzdGVwIHRvIGV4cGxpY2l0bHkg
ZGVmaW5lDQoNCglSRVNDVFJMX0wzX0NBQ0hFID0gMywNCg0KcmF0aGVyIHRoYW4gcmVseWluZyBv
biB0aGUgY29tcGlsZXIgcGlja2luZyB0aGUgbmV4dCBpbnRlZ2VyIC4uLiBqdXN0IGluDQpjYXNl
IHNvbWVib2R5IGFkZHMgYW5vdGhlciBlbnVtIGJldHdlZW4gdGhlIEwyIGFuZCBMMyBsaW5lcy4N
Cg0KLVRvbnkNCg0K
