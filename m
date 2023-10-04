Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF857B7D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJDKcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJDKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:32:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFBA1;
        Wed,  4 Oct 2023 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696415533; x=1727951533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZjdADBscZtX5ATkZzlCywPxHi3qOGSH1d01AKCy2F0Q=;
  b=Mo1L1yoDeGnRqQUiifXvS18qmJKELAt8oGdWVmN2Yz451uQH1JGDHR2p
   naWM2i674hCrHEm42rhdZUxyL0Vc35FFJN43isyD1u7rtBbf1T2ekvJlB
   qFFLU4XnQuHJkanvrpLXdqlIfU+Fm+1L8b3H+qTwuho4+RU0CuiGR9TdZ
   bnkJvjnq3BN5UpGTg5110M7xWY4qNG39ny/Obr3h2T0mTxibB+NWOlxWx
   zsDvc/m25pjeB5th9Mm4akDkPPs2xtiw7FfHQ0CbuD1nd5C0IjEnGC4/F
   owVOa+9trUKcevRGpu45qoay6hyidp48L4HMQTmiqeOKbtTRFbKpDO/gI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="362480002"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="362480002"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 03:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727948990"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="727948990"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 03:32:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 03:32:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 03:32:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 03:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOsyMUTsTMtEwkyvIgBWUlGpDccbgWSU/jFV5V5jU201cOli6pvb+etyRgfmsEu9lBOJUtwF0uTZY3Apr3RPiNq7rbfGkAe12g1dQVm6FXJk9rkyzkCCb/O9AL5+/pWFIw5Bj5SlaWyckRUnIHWZUdFk27oHaxD+ObnwMZHtdiZonLnrEjotudzVnRxco8pS8GRH/IKUkKRY+asvquKex4KKUpwYg69FIKXmmVstaKnbvBSjwZC2PPisyRMHSjrrZBfVfK9HxVQz7AkAi/yaXDJJaBwW6Koh1rkPj4eYE/68R2P0Y7UZnkc2V+sTeTW4nnwkZ22l+WqwxMB/jR859w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjdADBscZtX5ATkZzlCywPxHi3qOGSH1d01AKCy2F0Q=;
 b=bn8fgM/8k6I/3Ee1sgJC4vFgQpxnHtKS7ihtamOqkQPbK/qvTAvcQqeILRqHx8CnUsnifi0KjyhJq0aGPQDXBqrJy7ae4GIjzpz2+k+1LtDciTHMppNOf4f6BopfJFxwSRYsnjg3Qn+CLg8ZWDQ9seMP48XE9/zi5/bfJIoVUWxfTWNNixg8DYUyKlkqPwJSZDpj86ZvAs2vEzm6xYLEQPhuefzKtnQwapLeoHVf8vXUMKunREn2Xtt6nPlCtMHOxgQlKIGk9p2xcChD5cqM17+6IoC1pCM7qmctE/585kTAgjIQVRBmOO5P3Aj4cI1PpCRtf0LpLR93DEyyeJOdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 10:32:08 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a%4]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 10:32:08 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Thread-Topic: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Thread-Index: AQHZ9nBN5Rkn+0eu50eU6zME9puPJLA5L9oAgAA3l4A=
Date:   Wed, 4 Oct 2023 10:32:08 +0000
Message-ID: <BL3PR11MB6532D84A9844761292995EDFA2CBA@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
 <43b158b2-6958-4a2f-8b2d-c6f7d3b39dfb@linaro.org>
In-Reply-To: <43b158b2-6958-4a2f-8b2d-c6f7d3b39dfb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|MN2PR11MB4693:EE_
x-ms-office365-filtering-correlation-id: d77131dc-f4e5-464b-b064-08dbc4c5291d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGP4HSwneaEMj27YoNNLkQly5tT6xXZjdzdIY+9aRowAaIIoWeE5M8jCCZ2k7byJ0FcB7aHzvpPa8ZmbXx/f4bquRMpAKs4/AAWii+qkg6v756Yt6KP7AARpOZlpKmCpcE9qEGK2X4muDUI4AXFk8BKZthZlAE4KjeDPQZxJlNI9InOQggmvCmwlUfR3PuN0MpYVsOqqRNUY3C8W+EgAhvVH/qj/yBq/b19CJFRVoAmIIlWDFp/YAxyWANyIvf/baAHqgQvTJOjRfozEYZ6G37vh0zUwE0BT0jGQ63sn4yaAl2r3QiNFgQeAfgG3qAxXjzpHwLfgK4zeB8rdz3vpVA2/nG78y6ct4/AuXn/6ZSAYdfyqkmZ7V/+QwVjeXP0zQYi5zKnkX/gBbh4IBbiCSliM7A0FvUwtqEL8NXO1kWAfLqquiao8mCs85LI7NGjMcptcj16KbACFM0195hiuT3SMTyxuV6+K8RmzVkX1xZkJC7ppVOWFuhIEpofR05cA04qlGGwQiiAVa91T8nl1lS0AL0fbi2WJO0aS73KbJl+GZCvUeuB3hCx4W+qVgm8KCsZ9ZmhTvvd0eHAfLZbTsmEcFgAx/m5BN3T1Eczxnzec8gmmvrUDwpeOHR9I2AwnA/+Fae+kEUen2q1noh1X5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(122000001)(38070700005)(38100700002)(71200400001)(19627235002)(53546011)(478600001)(9686003)(6506007)(7696005)(82960400001)(86362001)(26005)(76116006)(966005)(66556008)(54906003)(66946007)(66446008)(66476007)(316002)(64756008)(52536014)(4326008)(5660300002)(33656002)(2906002)(8676002)(55016003)(8936002)(110136005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVRMT3lVSnVLVnVlSzc1b21YMVIzZ0lZNFpKNi9ydTBnU2gyclIxN2tUbHI3?=
 =?utf-8?B?Z3pNNFAzRGNhamZyZERueUZTUUV1QzR4My9JNGZaTStvOEJnWE9YemZqMU1K?=
 =?utf-8?B?NU15VGJJb3E1WmFub01oK0E4b2hXTWxnT1lvK2ppOTUyRGhsNXNVYmora0w0?=
 =?utf-8?B?bXllbTRRWGU0WlZiZU5tMEJNV0ZDTjhIRTV2VkE2YnhLNmZONFFqa0VLWjJv?=
 =?utf-8?B?MUZKbzdaRVRkNVB1V0M0TFdGNGhBbHhZeHduWDl2YVJHeGNBaytuQkh6TldR?=
 =?utf-8?B?YlQzaS9kZEtVMWFLMFI1S2E4QW9hcXJPcG1PWWRtL3NhSEhUOXNaR0ltcXJO?=
 =?utf-8?B?K1RNeHVKU2pVNFZqTmdWRDhNUE1LVlFSdGxITTFEZ1lBSmFabmNQRWtneVhn?=
 =?utf-8?B?bTVYdWU3L2ZNRm5VVVA2alZMRUVRa01mdm5HVjliTTZhR1RmdVkxNUJMMlpQ?=
 =?utf-8?B?MU5SSUswTU9Jbk0yS0RlM0RSd3hhaDdVa0pJU0piK2lRLzh3NzRlUjNHVUpY?=
 =?utf-8?B?VklpZUs0M3UxcHJNZkUwbjV3S1loV2pubW5uNDhvWFd0eEtuR0tlTkVsVnMv?=
 =?utf-8?B?cytpY1FicUhuK1ZwMlZ0Q0dFd3pQRjFmU0Q5SGxiZWF1RDVuSzU0cVErRTVB?=
 =?utf-8?B?MWFGM0NZYXkrZCtBbFFML1pmc1lDWHEvdFBFMSt6alZGUXJ4ZVZGWjQ3U2pO?=
 =?utf-8?B?MGhLM0lIV2x1bk1KMXcwYTZsQWZ6T01ieG5LYk9IaXFCcCtYc2RFSlNEcjk1?=
 =?utf-8?B?ZXdRMDdVNW9tVHdVOUNmdkVmc2IvTitFRHZETWF4VFJDdzVma2thZHVTS2Ft?=
 =?utf-8?B?QWhvY1BNZjFZSjRKK2pDeTZnZ1VXVzhWU1d1SGVnRzVFSHlDM3RBTGFrZFZs?=
 =?utf-8?B?Mi8xS0doM2FuL3Y4bCtRS3U4K1gyY2lZa1VPYmRBd3Y0d1FnU3BzWkQ0SnMw?=
 =?utf-8?B?RVdkOGNrMFpaR3REN1UrZnA5Ukc5NHB2Q2tXcmdSNVUzUHlUbEREb2dKSGE0?=
 =?utf-8?B?NG9waG56dHhzRzhGcmJucUhGU1NmRnl3azB6Qlc1UFlWT2kzS3l0VlpBVWZE?=
 =?utf-8?B?anorZkN2ZWt5NWV5OE1Xdjh5ckZPUmt4Q1ZoMG9iOXU2OCszaW1Pdm1EY2VS?=
 =?utf-8?B?aTdWaTlPRkE1VGt4Nm9FeGt0OXQxQTByN2lxUThYZm5jdmxIVlFxekZnT3lS?=
 =?utf-8?B?ZlB5dWFmM29yZ1FiQmpwdHhmUEFmaVBESDU3TzAzQWVjeG9JcllkeW9WY1Ix?=
 =?utf-8?B?c0VOWTIzL0ZXekJySlhPTm9iZE1nQ3NXQWNjbFoxeUE0eVFwaFlOV0tOblBZ?=
 =?utf-8?B?WEhvUGhzNGUxRVBlTzgzSGlPbmloK2ttdUdsRXN5VHU3cjZJbEdsa0NEelZS?=
 =?utf-8?B?KzNWaUxoTlRkNWdhRSswVDZiZHVBMndWWFRibVNnRjhBNXU0c1VTZGQrem9w?=
 =?utf-8?B?bzV3dys1SkZJcnVWdGRmL25raDFmN3ZuWVc5ZnpzLzF0aWJNZ2hVV1JWVEFI?=
 =?utf-8?B?cm0wMVJMck9IYnVwYk1seFJvMFluWURqYnJsUThjOGNQRXV4YmlEWFdiQUIw?=
 =?utf-8?B?ZmlrSFNjNEplQUxwR3I4dEpRRFhqdmIwc2p4QmdEQnpLRHN0emxnN2h3WnFR?=
 =?utf-8?B?dzR2RzlYSzZKWG4xOTJFVEFiWU5PQ3N0cFdCaGJKQm5MV1VnK29pVTNoZm5z?=
 =?utf-8?B?Nm1JemlCc0RZOFp1NWpUdjRBL04vWTE4VUNYMWlTNmtOZThuS0tYQVBkTUV5?=
 =?utf-8?B?VStwamF3clRzUnpWbzFFekFMcDVaWlJkYnNQYW1ITXJob25aazl3OFFZcWxU?=
 =?utf-8?B?MGRXQU95M0pqKzV0RFI5R1hnNktOWnRRcUNHT25uMjV6aURhZXRHaTBPK1Ju?=
 =?utf-8?B?SmlHbkJ2NDdZRlpTR0JFamNvdVFXbzV6Ykc5WHdCY25KUUo5eVZqNHZCSFVr?=
 =?utf-8?B?aFF4OWs0b3VhclJpSWlSRTFRaWd5VFdNRVlETTVNVjJlTFp4bFNKUHJPaWlh?=
 =?utf-8?B?M1pKTVVmRUtMNlVXK2ZSL3I0STV5OC9QbmR3dzBpNmhMUU85ZzhDZDFjaXBM?=
 =?utf-8?B?VGxGN1RLS3VqL3cvSGhlWHY1cklIb3c4YWhuOUNhU29BSDltWmUvRk4zRnNH?=
 =?utf-8?B?L1ZuRFBXZCtWM0lNSDl5cVZJTzdlOE1GdWpJc3M2eWxkcnA2WDkrU29rOUZw?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77131dc-f4e5-464b-b064-08dbc4c5291d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 10:32:08.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq8PyGOgGXpg96+0+OpMFnCPfg963EUCN0C0u7hfuccFjCrjN+shzezfg8/hJkXL//0i63a5NlJhkrdWrSfDOJX3v+elBOBlu8D4WJ4yaeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgNCwgMjAyMyAyOjQ2IFBNDQo+IFRvOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmly
YXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnPjsNCj4gQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRGluaCBOZ3V5
ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
dC1iaW5kaW5nczogYXJtOiBhbHRlcmE6IGNvbnZlcnQgc29jZnBnYS1zeXN0ZW0udHh0IHRvIHlh
bWwNCj4gDQo+IE9uIDA0LzEwLzIwMjMgMDU6MDcsIG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwu
Y29tIHdyb3RlOg0KPiA+IEZyb206IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5pcmF2a3VtYXIubC5y
YWJhcmFAaW50ZWwuY29tPg0KPiA+DQo+ID4gQ29udmVydCBzb2NmcGdhLXN5c3RlbS50eHQgdG8g
YWx0cixzeXMtbWdyLnlhbWwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaXJhdmt1bWFyIEwg
UmFiYXJhIDxuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4u
L2JpbmRpbmdzL2FybS9hbHRlcmEvYWx0cixzeXMtbWdyLnlhbWwgICAgIHwgNTAgKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAuLi4vYmluZGluZ3MvYXJtL2FsdGVyYS9zb2NmcGdhLXN5c3RlbS50
eHQgICAgfCAyNSAtLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9u
cygrKSwgMjUgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FsdGVyYS9hbHRyLHN5cy1tZ3IueWFtbA0KPiAN
Cj4gYXJtIGlzIG9ubHkgZm9yIHRvcC1sZXZlbC4gV2hhdCBpcyB0aGlzIHRoaXMgZGV2aWNlIGFi
b3V0PyBGUEdBPyBTb0M/DQoNClRoaXMgaXMgZm9yIEFsdGVyYSBTb0NGUEdBIFN5c3RlbSBNYW5h
Z2VyIHJlZ2lzdGVycywgY29tbW9uIGJpbmRpbmcgZmlsZQ0KZm9yIEFSTSBhbmQgQVJNNjQgcGxh
dGZvcm1zLiANClNob3VsZCBJIHVzZSAgImFsdHIsc29jZnBnYS1zeXMtbWdyLnlhbWwiIGFzIHBl
ciB0aGUgbmFtaW5nIGNvbnZlbnRpb25zPyANCg0KRG8geW91IGFsc28gc3VnZ2VzdCB0byBtb3Zl
IHRoaXMgeWFtbCB0byBkaWZmZXJlbnQgZm9sZGVyIGluc3RlYWQgb2YgDQoiIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWx0ZXJhIGFybS9hbHRlcmEvIiA/DQoNCj4gDQo+
IA0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2FsdGVyYS9zb2NmcGdhLXN5c3RlbS50eHQNCj4gPg0KPiA+IGRpZmYgLS1n
aXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWx0ZXJhL2Fs
dHIsc3lzLW1nci55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2FsdGVyYS9hbHRyLHN5cy1tZ3IueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZGViNzBhZWY2NjQNCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hbHRlcmEvYWx0
cixzeXMtbWdyLnlhbWwNCj4gPiBAQCAtMCwwICsxLDUwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4g
PiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL2FsdGVy
YS9hbHRyLHN5cy1tZ3IueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQWx0ZXJhIFNPQ0ZQ
R0EgU3lzdGVtIE1hbmFnZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRGlu
aCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBkZXNjcmlw
dGlvbjogQ3ljbG9uZTUvQXJyaWE1L0FycmlhMTANCj4gPiArICAgICAgICBjb25zdDogYWx0cixz
eXMtbWdyDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFN0cmF0aXgxMCBTb0MNCj4gPiArICAg
ICAgICBpdGVtczoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGFsdHIsc3lzLW1nci1zMTANCj4g
PiArICAgICAgICAgIC0gY29uc3Q6IGFsdHIsc3lzLW1ncg0KPiANCj4gVGhhdCdzIG5vdCB3aGF0
IG9sZCBiaW5kaW5nIHdhcyBzYXlpbmcuIFBsZWFzZSBkZXNjcmliZSBpbiB0aGUgY29tbWl0IG1z
Zw0KPiBkaWZmZXJlbmNlcyBmcm9tIHB1cmUgY29udmVyc2lvbi4NCj4gDQoNCk5vdGVkLiBXaWxs
IHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBiZWxvdyBpbmZvcm1hdGlvbi4NCg0KQWRk
IHBsYXRmb3JtIG5hbWVzIGluIGRlc2NyaXB0aW9uIGZvciBjbGFyaXR5LiBBUk0oMzItYml0KSBw
bGF0Zm9ybXMgQ3ljbG9uZTUsDQpBcnJpYTUgYW5kIEFycmlhMTAgaXMgdXNpbmcgImFsdHIsc3lz
LW1nciIgY29tcGF0aWJsZSwgd2hpbGUgQVJNNjQgaXMgdXNpbmcNCiJhbHRyLHN5cy1tZ3ItczEw
IiBjb21wYXRpYmxlLiAgDQoNClJlbW92ZWQgImNwdTEtc3RhcnQtYWRkciIgZm9yIEFSTTY0IGFz
IGl0IGlzIG5vdCByZXF1aXJlZC4NCg0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsNCj4gPiArICBjcHUxLXN0YXJ0LWFkZHI6DQo+ID4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0
aW9uOiBDUFUxIHN0YXJ0IGFkZHJlc3MgaW4gaGV4DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4g
PiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsNCj4gPiAraWY6DQo+IA0KPiBQ
bGVhc2Uga2VlcCBpdCBoZXJlIHVuZGVyICJhbGxPZjoiLiBXaWxsIHNhdmUgeW91IG9uZSByZS1p
bmRlbnRhdGlvbiBvbiBhbnkgbmV3DQo+IHZhcmlhbnQuDQoNClN1cmUgSSB3aWxsIHVwZGF0ZSBp
biB2MiBwYXRjaC4gDQoNCj4gDQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgIGNvbnN0OiBhbHRyLHN5cy1t
Z3ItczEwDQo+ID4gK3RoZW46DQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNwdTEtc3Rh
cnQtYWRkcjogZmFsc2UNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
PiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzeXNtZ3JAZmZkMDgw
MDAgew0KPiA+ICsgICAgICBjb21wYXRpYmxlID0gImFsdHIsc3lzLW1nciI7DQo+ID4gKyAgICAg
IHJlZyA9IDwweGZmZDA4MDAwIDB4MTAwMD47DQo+ID4gKyAgICAgIGNwdTEtc3RhcnQtYWRkciA9
IDwweGZmZDA4MGM0PjsNCj4gPiArICAgIH07DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNClRoYW5rcywNCk5pcmF2DQo=
