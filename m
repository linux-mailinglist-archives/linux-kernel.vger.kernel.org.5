Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440577C9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjHOIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjHOIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:47:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0BE65;
        Tue, 15 Aug 2023 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692089278; x=1723625278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L5jhFvdD2qXFG/CG6rGguknB0tBhqGI/oC5dkCxFXuc=;
  b=E9i+ZQYuglmbwF4wwNLbHBhJG2O0bx+/XWfaXJ3M1l7s9nXmgxlzv4Jl
   3CIPHZ0clnib7BTUDTKNoGSfhIXURAA/WkDR6PiPaMR93ba/TwqJrYQh5
   TwBJ6J6gHbarE/pqtNPL1ngyqBcCzd8T6Z4nEB5rHSxoYocjt2EkkC275
   DiUN6Yp1L7G0SaJ2qv0Y8tkjlyFgc798Dkf1+TDxHrZBurH/h99TQ5Q0F
   0Y0o8/pvUb1+dVz7ZTSuaJIY+lX+cStQcTA4DChXLbn7MiXaB279tetQr
   UMeIwv2CwibGaAcLSqDlz9wNhU9zxs6PkymYqgDaaTypvhfBJISIDw+eq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369708096"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="369708096"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 01:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710642247"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="710642247"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2023 01:47:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 01:47:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 01:47:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 01:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa79DGInxgClSegYJg79hoG0OkH3mV23NwyZh77L/yhPYGeYIyipmeuBYlOI9T8k+NioOVTOGWM5nQEaisyZTZxk2xmS43AAYKaj0BT52F62zvsf8QEEVBkFIu/vlMe0NTD9opt1xlofYL4VAZACPFGINKJCpFab6DJ9uT2ULmNaoQzA8rOt2bcEZMBZJKAPwPM+Yw7U7x2UREQ0rSiKixS8wIrya2BuX5dwXcfCn8WvMD3x7mq0jIQc/IwU1fuNX97aYGX2m5vEVuqWvhcFLYF2VVbv6vfVQBAFDrKOYbNzBhiuj+dtL2m+ogxAHOgQu9/itpD7CohJrvMTN6KghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5jhFvdD2qXFG/CG6rGguknB0tBhqGI/oC5dkCxFXuc=;
 b=I3oYpcPvxU2YkoaVKNnbkZv+QCO0iE8L/fE7qchoN4IzifDpFwakptZ6wzzqojEE8JsVWeWtoqQmOzi4HWdtNLzyAKRPAOBASkEnlwNm5GxjEpEP48MIpEzFq/vcGPWbR7ekhQElb+n3SsoNs1A0mimZJDKJkDOJFFqCs/yZ3ex75JSGSRygKg0vT0tyuJxFNBqcP0zSckkDr3uX8cjqZpKJrQGyJtakH6D2ghdkAmIny31tPKsvZ6pu2cviqW8xfdyAbnQckkeTGNAEssLyaJ+wFUGbHpiG2QOO9gBLQkDi65qMK0FWKYHyDw9ge9DtYmje9Nki0c/I+t7+Ugxixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 08:47:54 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 08:47:53 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     lkp <lkp@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Prabhu, Krishnanand" <krishnanand.prabhu@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Thread-Topic: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Thread-Index: AQHZzN4OvQRy+WLkJUixaCvHGuJxFK/rEJ4A
Date:   Tue, 15 Aug 2023 08:47:53 +0000
Message-ID: <0eb672e4c845b90fb3e79be4fa30ba80b13a7ec8.camel@intel.com>
References: <20230812052947.22913-1-rdunlap@infradead.org>
In-Reply-To: <20230812052947.22913-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SN7PR11MB6678:EE_
x-ms-office365-filtering-correlation-id: 8b5e1e36-feab-4803-651b-08db9d6c50a1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q4hBJ0aXQJolSy5siQV0bxVFzxfWV/Neh6fn4FzL2ozlHqe8fPrgaDabqfJlV+274g3Vi0BkllM7Lq+ff5pO/Jn/JJxW2ooKFIggeWYcLbG4WQsHDUmYrY4/iQk7Ekyxf5oocwZJ2eZTamTpphjdoZMAeSHojHE7B05hOhTLXjhGVzeDRrDh5VOxSmE6p0AbUmohOMk5B/d0o1RFCpDGpcmgD+QoY96IxJC3H7Ihk29LwXqFHbGBcWh2ybggN/NAo1uJVKDrAQIa9GhlZSkGUDybx27X3S9BHasCjYFIUvpalnkUPqgNEN60kRiloWDaVtch1BgQjQZTpCMz6ci9l9NUGHFEjgWjImiiC02aWUBGW2dWaAyAu0+m5o2Ml+u+vGBCi3mKRtbzJ34RYK0+6u/AFotEJojoCHIxQczGPfrNjoK18FxjxDk2QJz9FG9crkHE/dA21OsNlgeBVnoYKZnopL277moazr84sG096VauM6Pq6TLZ2MgmNCqOQXTwEy0fdMS4vIuzLwGHjT/iaK94fmpEsTacbTZMGiyRNuj1dFiydGeOOY0UVypLLCJtSDT5OblVvIAddqkoJO8f2s5dMDO84C40Xmt44Dco68=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(38070700005)(91956017)(66946007)(66476007)(54906003)(6512007)(76116006)(64756008)(66556008)(122000001)(316002)(8676002)(66446008)(966005)(110136005)(5660300002)(4326008)(8936002)(82960400001)(38100700002)(2616005)(26005)(6486002)(2906002)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDFMZStxOTFZODFCN0FRRmw2eTZkKzQ5YXVNMTByS0hpak1PLzVlYkgvS3VJ?=
 =?utf-8?B?b0hLSkZZR3BDOVBRSkd3TlJuUGpjZmJ2Sm8wZXRWY25WRGpwQ0JZQkNWMVdp?=
 =?utf-8?B?WGprc0JlZ3Z4QkJJZTlYbmYydDl0SmhEdlpzQzhJWlVhZ0tSVmVxNFdsMEZS?=
 =?utf-8?B?cHpVblRRMTM1TFdicTlUbVR2Z0V5bUhpTXYyOEo5Ni9BUCtPL2dxRjdkeHZn?=
 =?utf-8?B?d3BvWWE5aGRpUTl3NERWL1JTbWExdHROczBJckJQNkRoRzJaVWtYVUFkc0Jy?=
 =?utf-8?B?Qk5ueWJyMDk2RDhhQTNOZSsrSmlXd0VwMGFnRm90YzFtaWQ2NDQwUU5LcXps?=
 =?utf-8?B?ejRKMG41Y3dURVpNMEVQa3Z3anIweTdBS0FPRHhScTZ1N1lZQnVFaGo4eDBZ?=
 =?utf-8?B?WGplOVRrTEFmWXJhU0hzNkExOGtZdGo0SVFGa1U0MjNoK2ZYam92cFpuek5I?=
 =?utf-8?B?aUY1S093Q0V1UjRZdHlacHlOL1Z3ZUcwd3FqVzB4T1B0Ykhac0NkRVl0eXdY?=
 =?utf-8?B?bHFWaVVUSFhlS3FRRkpPTjNSdnJVQTVPM3Y4Yk4zcElZdTdRNkhhOUNhbUtW?=
 =?utf-8?B?WnZsRE4xVlpMRFU2VmdxcFJDOCtDeTlZTk9mSFUwYWJLU1JjTDdPZzZSalAz?=
 =?utf-8?B?WTEwS1NwMGhPY2hGMFpXQXg2T21oVExlUWJrTkl6VWloeFV2Qmw1eFhqK2M3?=
 =?utf-8?B?M1BCdVZQNjFuWkxNV1RIS3pSUjJMUEVrTTE0ZjJoUjhDNGhQQm80WURPRDhY?=
 =?utf-8?B?ZGFMclhqWDRlTkVOT0dFMzNlVjBFaFpyUjNZczFKT0JJK3V1S2U4dUpkR3l2?=
 =?utf-8?B?eUpLcVVrSGVmSXh2RFNiaDdDZWZKTFgxbUtUaUZGb2Z1eFV4S0pSTXJTbDhm?=
 =?utf-8?B?a1ZWZ00yTUxNejB1K3BERlVqZ1QyaFg2RnFwclVSTlpLQlZrRFhWME9DV0t3?=
 =?utf-8?B?K3dHbldwTXB6emtiZ3A4dXNxemppYXd6RktMUkF5S0g3WUdMRVhweDhFb2VC?=
 =?utf-8?B?aFVmay9PTTFlRUo3ZXM1L3pDZG5qaUxpQWhCcWdBVlZSWEQ4TERXaTVQTHFT?=
 =?utf-8?B?MHJGTGZWM3hhMnkrMXMzQ3BNU2R0bkh3SVZ0V202aVl1ZU9IOVArODQxaFFv?=
 =?utf-8?B?NVRLYUFZK3pUcmNuenIvSjFZZzl5QUpyUXg5K0tDN09XeVVLMWVWbWh2WlM0?=
 =?utf-8?B?dU1UQWVhOXRBTW8raFEzQVROaXc2Mm14d2crS2hNRnplSEhuYlgyVXVBUDVM?=
 =?utf-8?B?M1poeHJyN3ZUN3ZJRUhucUVsajA5eS8xRFc0MldjSi90eWRadzJSTU1VeHdl?=
 =?utf-8?B?djRzOXdkM3c2cjdHTGZwME9mdGtORFE5Ym12Q3IvbjU0ZlVSRmduU3NCZDRH?=
 =?utf-8?B?dHpsdnBHMjVQaERpWGY0b0t4SWJ1ZDFXYXQ5ZE9TMEVuUTZFaHdvSW13WFNJ?=
 =?utf-8?B?dXR6UjNWQThEcGZ3cDdXdVd1L3I0a1hMTDJaQzNkU0hVQzRDMnNaRUVJa3Yz?=
 =?utf-8?B?QnU2ZE5GNk5QSkp1VzNwenkwcjNMVVR4VW1YLzY1bkJkS0R4SmMvbGNWMjRi?=
 =?utf-8?B?emJSaHlZRzlpaHdoVW9oajRqbVdMTkpUcHNqTCtpNUpzVkJjUlV5WCtvaGVs?=
 =?utf-8?B?OW55ZkFVMyt5eFBKNVdrMVgvWkNyRzRkQUw1a0R4N0xWZVZrMjZjR0RiRFBL?=
 =?utf-8?B?RnpuRnZidjQ1Zk55MldrNmhBMHpqaTJ1cTNEUTFuVmdiMW5wRTRYTUpPMzl4?=
 =?utf-8?B?OHVVYnducVFKTEM1ekprQmVzMWFBYXBwbzEyUnVmSHY0WVhWUW5XKytyelhu?=
 =?utf-8?B?QkNkaTJHK2RhWjVGN0VvNVNabE81cThnbVVUSXB0cDJ1NzEvYmhLQmFpVG4w?=
 =?utf-8?B?OGtZaGFmV3VQSXRvV3p2YnJoOGQweUJFSWtVZ2VaZEhodEJ2dkJYb3VubjZD?=
 =?utf-8?B?bTN3bzZzUHB4WjkzSVFneG55Yk9pcldvQVoranNrVHVZL3RhTmliK1ZXMVNw?=
 =?utf-8?B?d1RXSER2WktIa2gzYWJwMEtCcUZKemtoTnRFYXJCcHQ2Vi9mTnlqc0xiRGVR?=
 =?utf-8?B?REtmMHBkVGo4SC9Sd3Q0dVpVdnpQRDVDWE1LeDV0R25YY1V2NnNzYTlDY0NK?=
 =?utf-8?B?Sk94NFhhcjgvMHBjOU9Tc2hyaXFxdzhvMXBnNGE1UitOLzJJTU53V245TFVz?=
 =?utf-8?Q?PSJx35q5XaxtXeui1WbuLRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D924409F7D0814F94404EB96844F783@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5e1e36-feab-4803-651b-08db9d6c50a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 08:47:53.7587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVJqg3D81e3Ut4IOOUQX0LWdpGz5v1HcMIolKKTKwr3DZR18lwCo6shEbjsMW2Hx0YDEu0MEoUKt/cg2X+Pxpikzj/GHdAxjI3pHQqAU1Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTExIGF0IDIyOjI5IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IFdoZW4gdGhlIGNvZGUgdG8gdXNlIHRoZSBQVFAgSFcgY2xvY2sgd2FzIGFkZGVkLCBpdCBkaWRu
J3QgdXBkYXRlDQo+IHRoZSBLY29uZmlnIGVudHJ5IGZvciB0aGUgUFRQIGRlcGVuZGVuY3ksIGxl
YWRpbmcgdG8gYnVpbGQgZXJyb3JzLA0KPiBzbyB1cGRhdGUgdGhlIEtjb25maWcgZW50cnkgdG8g
ZGVwZW5kIG9uIFBUUF8xNTg4X0NMT0NLX09QVElPTkFMLg0KPiANCj4gYWFyY2g2NC1saW51eC1s
ZDogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcHRwLm86IGluIGZ1bmN0
aW9uIGBpd2xfbXZtX3B0cF9pbml0JzoNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vcHRwLmM6Mjk0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwdHBfY2xvY2tfcmVn
aXN0ZXInDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jOjI5
NDooLnRleHQrMHhjZTgpOiByZWxvY2F0aW9uIHRydW5jYXRlZCB0byBmaXQ6IFJfQUFSQ0g2NF9D
QUxMMjYgYWdhaW5zdCB1bmRlZmluZWQgc3ltYm9sIGBwdHBfY2xvY2tfcmVnaXN0ZXInDQo+IGFh
cmNoNjQtbGludXgtbGQ6IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0
cC5jOjMwMTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcHRwX2Nsb2NrX2luZGV4Jw0KPiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYzozMDE6KC50ZXh0KzB4ZDE4
KTogcmVsb2NhdGlvbiB0cnVuY2F0ZWQgdG8gZml0OiBSX0FBUkNINjRfQ0FMTDI2IGFnYWluc3Qg
dW5kZWZpbmVkIHN5bWJvbCBgcHRwX2Nsb2NrX2luZGV4Jw0KPiBhYXJjaDY0LWxpbnV4LWxkOiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAubzogaW4gZnVuY3Rpb24g
YGl3bF9tdm1fcHRwX3JlbW92ZSc6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL3B0cC5jOjMxNTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcHRwX2Nsb2NrX2luZGV4
Jw0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYzozMTU6KC50
ZXh0KzB4ZTgwKTogcmVsb2NhdGlvbiB0cnVuY2F0ZWQgdG8gZml0OiBSX0FBUkNINjRfQ0FMTDI2
IGFnYWluc3QgdW5kZWZpbmVkIHN5bWJvbCBgcHRwX2Nsb2NrX2luZGV4Jw0KPiBhYXJjaDY0LWxp
bnV4LWxkOiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYzozMTk6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHB0cF9jbG9ja191bnJlZ2lzdGVyJw0KPiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYzozMTk6KC50ZXh0KzB4ZWFjKTog
cmVsb2NhdGlvbiB0cnVuY2F0ZWQgdG8gZml0OiBSX0FBUkNINjRfQ0FMTDI2IGFnYWluc3QgdW5k
ZWZpbmVkIHN5bWJvbCBgcHRwX2Nsb2NrX3VucmVnaXN0ZXInDQo+IA0KPiBGaXhlczogMTU5NWVj
Y2UxY2YzICgid2lmaTogaXdsd2lmaTogbXZtOiBhZGQgc3VwcG9ydCBmb3IgUFRQIEhXIGNsb2Nr
IChQSEMpIikNCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVh
ZC5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4N
Cj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwODExMDQ0Ny40UVNKSG1G
SC1sa3BAaW50ZWwuY29tLw0KPiBDYzogS3Jpc2huYW5hbmQgUHJhYmh1IDxrcmlzaG5hbmFuZC5w
cmFiaHVAaW50ZWwuY29tPg0KPiBDYzogTHVjYSBDb2VsaG8gPGx1Y2lhbm8uY29lbGhvQGludGVs
LmNvbT4NCj4gQ2M6IEdyZWdvcnkgR3JlZW5tYW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29t
Pg0KPiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+DQo+IENjOiBL
YWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4N
Cj4gQ2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gQ2M6IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhh
dC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiDCoGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvS2NvbmZpZyB8wqDCoMKgIDEgKw0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvS2NvbmZpZyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvS2NvbmZpZw0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9L
Y29uZmlnDQo+IEBAIC02Niw2ICs2Niw3IEBAIGNvbmZpZyBJV0xNVk0NCj4gwqDCoMKgwqDCoMKg
wqDCoHRyaXN0YXRlICJJbnRlbCBXaXJlbGVzcyBXaUZpIE1WTSBGaXJtd2FyZSBzdXBwb3J0Ig0K
PiDCoMKgwqDCoMKgwqDCoMKgc2VsZWN0IFdBTlRfREVWX0NPUkVEVU1QDQo+IMKgwqDCoMKgwqDC
oMKgwqBkZXBlbmRzIG9uIE1BQzgwMjExDQo+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gUFRQ
XzE1ODhfQ0xPQ0tfT1BUSU9OQUwNCj4gwqDCoMKgwqDCoMKgwqDCoGhlbHANCj4gwqDCoMKgwqDC
oMKgwqDCoMKgIFRoaXMgaXMgdGhlIGRyaXZlciB0aGF0IHN1cHBvcnRzIHRoZSBNVk0gZmlybXdh
cmUuIFRoZSBsaXN0DQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBvZiB0aGUgZGV2aWNlcyB0aGF0IHVz
ZSB0aGlzIGZpcm13YXJlIGlzIGF2YWlsYWJsZSBoZXJlOg0KDQpBY2tlZC1ieTogR3JlZ29yeSBH
cmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20+DQoNCg==
