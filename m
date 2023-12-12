Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2880E05E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjLLAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjLLAlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:41:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70FA7;
        Mon, 11 Dec 2023 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702341672; x=1733877672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AgKvqbRUm/Rj41G3VKagzhDyDgo0dnK+ToJDA9suJno=;
  b=XzVRtZj6P2GElJ5KO6TpOgtQ0epWzYIGFQxLxNotUV7pMdcf2DLkg2GY
   QhORjtETAw+8VPsy8s14PAG7ZADsiQu54fgh9iDWkUwNOP7M+PzTAbvq9
   shlJqzHLFIE4CMw8/GVsuQvv3X7rJM4ClEB5148Q5VTVEDXeIGsWBHCEA
   Gb952mHUzE4rJnsLTDspsSaEH+96+ICeq8tBk5xQpss1FQj6YeRDrnMaU
   wUkFndahPSJavNkUZwreSYiDeo717IuASS6e1mrg+vml3Y4XcJ4aTOShY
   zbgrbK1oWhUkaklokbIjBs1A+ehF7RJqajhzKtcaHPcRogbBWdEXSl+5+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1808153"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1808153"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 16:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766597676"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="766597676"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 16:41:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:41:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:41:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 16:41:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 16:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTiJGn3wD1Mk/l+3eimLmEoihlgWhcjimveQok3roaFibIC/v1ifzFRwpeK42WEcrcc/bo0IjA3RkyTOqwxA6UybPo6H/PWOkegIQybUbGDtJaBZGXY7VD4hJ2JooSaOuYyRSGtXupmHOOIHpiH0vomXzBYUas5eN6YzNMbs7HDRdgT5JZ2IJoGw8kM2MNUViNLHXUKoxo6f7TA7awCx5MyvPpjcZQFN12h+w0ZSwnZ2e6XeTEiO7DSD9LOvZI/eOTaq5brY6wIBHbsFQ3MjeSnaeLeM8eC8UPps15C7yADi3BVE4lNamc6tYZ4gvj4YbpqX+FEygnD4vVtDkEN/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgKvqbRUm/Rj41G3VKagzhDyDgo0dnK+ToJDA9suJno=;
 b=EDQBqQga9VltYbZERVuGWuhEtACSQygs5ZSxR4L9a0eY1zRVgRW5JfoHtfLo+z+3EIgKDoRwctocYNgkdz7ZQJiNckGjWrzCRLKhDUyD8RCsGRuzSETvfZ9rd2FQoO0ZbaCO/rEKlGBwsHVFVHPQTvrz0QMOrlz3YSOOYq7R+PKQgH2B79HyCtpbLXTQEdSJT9J6DkAuZZjoXkcLAod62pVhR9olhgNRU2HPqI5bNS5Wr0cKsBwWtVDGwnPn0QcaOdrCpTek21CG5A+xzcW0GhXZqgYpp4fPmwMO9o4HozGdF05DS0IGhQ4RB7wuWb0P8sCwKkch+5ReMGDjmVe5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 00:40:57 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 00:40:57 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaLIS7j/mMkSc9X0yJtHKbaRMzBLCkzGJ9gAACUAA=
Date:   Tue, 12 Dec 2023 00:40:57 +0000
Message-ID: <aac91f0ae8774c521469d518585a499da52912a8.camel@intel.com>
References: <20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com>
         <20231211-vv-dax_abi-v3-2-acf6cc1bde9f@intel.com>
         <87msugxnx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msugxnx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA3PR11MB8119:EE_
x-ms-office365-filtering-correlation-id: 83ba53f5-0e43-4251-2259-08dbfaab0191
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLr+LU/T0NJWn5zZxVmyxjKY6nVtnE0dqxNLIL6MExyHhClF7qQSROU5IbPeBssdZKC7O0FF2rekxXAJx1EQbfg4JAtt1jtHUJ+xh7lWehIGCwhqRM0UasQvvyNLAMnhcbDf78sV3z0XOrWSioSitEeZdiRQm33Mv9CuvAlTb2ajvbMCJykIYeygShCZH3rNsv8CEX1xqTNzp9ibdfwRxUMx/JIdknvK6HpmVI91JAb7pLg4EvBZw6JodYYRIwxlpzzvZgfBCo0VqEFLH8fmZ6bhd8/jgkLS9cge8AH37X+7L1tHBHYtT7DUDDoh7uvAUdjRV8u7AEcJGAIe03BEUmzGKJKlq/2mtWs40aVcskN4c6eoIvfj1fiMtmRqmcrzWoQnCZ9c7X63xBdBUpXAdq18pKuvGPrXfCaRSSavHcCTUXWJbagbY8yoHyFZPci2+JZQQD/FWYtZLEVpO25Y85uPjD7PWZHQ+gcm/oLubQTTLtgPvrs5mqXzF6R8kslq9TTlyg5cEzBCDHZkRHd2/57GTgytwR2GayJ4WZhGkgSC/E71iX4+sjDWF0iiBAds0ahh1VDEaXXv3B6L3XOleVTibnJt8fx918NmKnFrMeXll11UXstMj3gLEaOigq8Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(5660300002)(26005)(2616005)(36756003)(38070700009)(4001150100001)(64756008)(6486002)(66946007)(66476007)(66446008)(66556008)(6636002)(76116006)(54906003)(2906002)(83380400001)(82960400001)(86362001)(41300700001)(478600001)(6862004)(8936002)(4326008)(8676002)(122000001)(316002)(38100700002)(37006003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxEMnB2VzlrRVJEcGZ3ZkdpYmhuQ3hqeHBRRy9lK21jZ1RMOC9SZTNvN1V4?=
 =?utf-8?B?Z3huS05VbkRrMCtIZjBnOEJWR3c4Ukhsei91TXJrbktMcUpQUm95c2hpS2Y5?=
 =?utf-8?B?dmNqS1hvWWI5TDVoQnNpcGhkRkJxT1dqYVZ0bkZJUXUvOTNZY3oxTVgyRlpz?=
 =?utf-8?B?eDJnUUxKcWhzQnVFTXE0ZDJ3SURNN3E2OHMraTQ4NTlBRVBWS0xWQmRtdUN2?=
 =?utf-8?B?a3UrVWhjZnBObCtKMWhjOTk1ZVBZTHFFUWJRQnNhN1MzK2hlY2dScjcvNUVU?=
 =?utf-8?B?bUpFdjEwSzBkQWJVa1QwU0pINWNKajdoai9XV29hSUxoUVZTa0hkMEdNVElD?=
 =?utf-8?B?cUJwc0xQTWRoTHJFeGJVNUN0RjNFYW5NMzVGQUpjZnN0MlFobWllaXdUK2FQ?=
 =?utf-8?B?REJyTWZqOVB2VnZSVkVndmJzaVFDYytXSU5oYjBZODBPOU9ob0I1dkQ2TWIr?=
 =?utf-8?B?NmRaZGdSeUxvZDFRNndVeFdDcldQM2hXQXpKT3hBemprVmkvQy9peG1RQ0Fw?=
 =?utf-8?B?b1BCZ1FRNEdCZWZzc1hSS2cvLzd6UDVrTHZSaEFxaHF2cHdwdnNzWDhvalpF?=
 =?utf-8?B?WVlFemtHYTdtakNEaER4TzAwRXRwdmdmT3F5QjNKcmxWd1A0YitUb1o1S3pB?=
 =?utf-8?B?N3RVa0N4OWlpYkNzc0tndC9MMzBLNXhaY0hVRmFmNVN5bEY4VDAxd2R3VUQ5?=
 =?utf-8?B?Q3llNkVSVTlVOXhaY2p1bTEyb0YrSWlZSjg2ZDErWGNFVGpRRmRCQmIvYUFr?=
 =?utf-8?B?ckR2RTZRRWltQzhkWlV6SS9RR3NqMUlyRjRDVzRoRDNYRUg1T2hZQXhTWGFh?=
 =?utf-8?B?MzJSZk84MkhHSVlBajh5blhsQ0crSGxTTkorWDdHdC95U1ZVc3BsdUNVTkFV?=
 =?utf-8?B?MFp0YzU4VTk5QXFtNi9IZG1NZXcwOEQzM0JmRldIZUg1cDdNWEtGVXdBeFo3?=
 =?utf-8?B?S2RPYVVxaTBROWJ0WFZPUXZ1bjIvbEVlRityaGxjQnlBdXJ3WnA2SVBvWmk1?=
 =?utf-8?B?cGVSUUZmWTJLYkNxL2w1Yks3ampjNlU4S3oyb2xOaWpMS1pYc2VrRm1mcXVh?=
 =?utf-8?B?MHpWaXpGWVphNVpScEttcjFUVVVpdkpRZVQ5WGQvTXp6S1M5RHQ2U21QQkVo?=
 =?utf-8?B?WVZHUXpORlFQaU95OEZ6RUNYbHFnbVllbExaZXFxRnBGd2VxZ2lnS3RxSUdp?=
 =?utf-8?B?QTY0VVlvRS96amZzemFZUGVobmN2aExTMzNGQmMzNXNpaUMyVDNjOEpmNFhj?=
 =?utf-8?B?UzN4Nmcyei9xb0ZXVktzKzkweW5QcHlJZWhJajJScjM3dXNld3ZRbDIyWDNO?=
 =?utf-8?B?aTJSbzF1NWszcFZUR2VGZVlxVkVaUmR2c0ZjZ0RDcG81Wm1QckJFN3JFbEZw?=
 =?utf-8?B?c2w4SGoyWVQwMjZoMkhEK3BrT1JGM1VkUHQveVBXWEp2VkZaTG1DTW05cXFj?=
 =?utf-8?B?Yy9GUE5TVHJDUjhuTGQ1TzV1aDdsRjFHbVB1V08vODFRZWxrV2FkS1crNVkv?=
 =?utf-8?B?VlVNMDBqZ0FHZmxDcDF2N2pOS2VZS3NrbU1JR29OK3BIcVRMcTNyYTRzWVBi?=
 =?utf-8?B?U3FyUjNBN21wVjE4alV3KzFVcmJNQUt0d21KbTQwLzNUMG9CRldtdkthOXpm?=
 =?utf-8?B?RnVITlh4eGsvMDhzYU5oL3RrMTVFWWlqbmtMZTg3ZWZlTk9kY0UwWmtYb2xD?=
 =?utf-8?B?L3Z6Qm5qdTBabU00Qkl3S29NdU15aVM1K1JqN0FXZlpYYm1zQVdkVEc0UlBS?=
 =?utf-8?B?Qm9SdDMyd3YrbDhTdGg1bjhkU3RnSHZMUW5jTHIrQW53My9aRGNKTTRKMTFt?=
 =?utf-8?B?NHdvcmJYN0xWZXk2a2NuejlKcFNBQUMwWnVPMklYTVZyYWZsd1YvbFBkTk1r?=
 =?utf-8?B?YzM4WUVWNHAzeEJ1VUhHMjliV3BHV0c4M2dNMTIwOUNrdGdiZnhSQzhOemdy?=
 =?utf-8?B?TW5mUk1QZlNCdWJEcVM0eTZtZUVBaFdEL3I0ejdsZWM1NElJT05vdG54RGc0?=
 =?utf-8?B?dDdxeExGSC9Ddnd0aW9LNG5MaHFrclR0NnVzVnFOU1QvS0xFaU1hNmR2c2VL?=
 =?utf-8?B?cjcxa0tXUSt1RkxQam1GTzc5c2RhQjBMZ3ozRDc4QnN6T2FtOUM1M0gxVVZv?=
 =?utf-8?B?KytwU3hrYi9NZWZYSGFJNTVhZEVzNFArMzVBSDArejdvMWJlUGxVL2tNZ1Az?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03F0CAFF465F142AC7F2446CAC9182D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ba53f5-0e43-4251-2259-08dbfaab0191
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 00:40:57.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VntpZPkE3t6IcIkC1hPrpcex7v98u1Fo1iaiaRLh56QOex2n/3X77+xr3NQ35MvsI7IpqIHq7teb7xhSIaQ6W74s74tZUG6VTBLniJ62WjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEyLTEyIGF0IDA4OjMwICswODAwLCBIdWFuZywgWWluZyB3cm90ZToNCj4g
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+ID4g
QWRkIGEgc3lzZnMga25vYiBmb3IgZGF4IGRldmljZXMgdG8gY29udHJvbCB0aGUgbWVtbWFwX29u
X21lbW9yeSBzZXR0aW5nDQo+ID4gaWYgdGhlIGRheCBkZXZpY2Ugd2VyZSB0byBiZSBob3RwbHVn
Z2VkIGFzIHN5c3RlbSBtZW1vcnkuDQo+ID4gDQo+ID4gVGhlIGRlZmF1bHQgbWVtbWFwX29uX21l
bW9yeSBzZXR0aW5nIGZvciBkYXggZGV2aWNlcyBvcmlnaW5hdGluZyB2aWENCj4gPiBwbWVtIG9y
IGhtZW0gaXMgc2V0IHRvICdmYWxzZScgLSBpLmUuIG5vIG1lbW1hcF9vbl9tZW1vcnkgc2VtYW50
aWNzLCB0bw0KPiA+IHByZXNlcnZlIGxlZ2FjeSBiZWhhdmlvci4gRm9yIGRheCBkZXZpY2VzIHZp
YSBDWEwsIHRoZSBkZWZhdWx0IGlzIG9uLg0KPiA+IFRoZSBzeXNmcyBjb250cm9sIGFsbG93cyB0
aGUgYWRtaW5pc3RyYXRvciB0byBvdmVycmlkZSB0aGUgYWJvdmUNCj4gPiBkZWZhdWx0cyBpZiBu
ZWVkZWQuDQo+ID4gDQo+ID4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29t
Pg0KPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gPiBD
YzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+ID4gQ2M6IERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IEh1YW5nIFlpbmcgPHlpbmcu
aHVhbmdAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5D
YW1lcm9uQGh1YXdlaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9kYXgvYnVzLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9z
eXNmcy1idXMtZGF4IHwgMTcgKysrKysrKysrKysrDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDY0
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvYnVzLmMg
Yi9kcml2ZXJzL2RheC9idXMuYw0KPiA+IGluZGV4IDFmZjFhYjVmYTEwNS4uMjg3MWU1MTg4ZjBk
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZGF4L2J1cy5jDQo+ID4gKysrIGIvZHJpdmVycy9k
YXgvYnVzLmMNCj4gPiBAQCAtMTI3MCw2ICsxMjcwLDUyIEBAIHN0YXRpYyBzc2l6ZV90IG51bWFf
bm9kZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiDCoH0NCj4gPiDCoHN0YXRpYyBERVZJ
Q0VfQVRUUl9STyhudW1hX25vZGUpOw0KPiA+IMKgDQo+ID4gK3N0YXRpYyBzc2l6ZV90IG1lbW1h
cF9vbl9tZW1vcnlfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiArew0KPiA+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4ID0gdG9fZGV2X2RheChkZXYpOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGV2
X2RheC0+bWVtbWFwX29uX21lbW9yeSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6
ZV90IG1lbW1hcF9vbl9tZW1vcnlfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBsZW4pDQo+ID4gK3sNCj4gPiArwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2ID0gZGV2LT5kcml2ZXI7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgc3RydWN0IGRldl9kYXggKmRldl9kYXggPSB0b19kZXZfZGF4KGRldik7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGRheF9yZWdpb24gKmRheF9yZWdpb24gPSBkZXZfZGF4
LT5yZWdpb247DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGRheF9kZXZpY2VfZHJpdmVyICpk
YXhfZHJ2ID0gdG9fZGF4X2RydihkcnYpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHNzaXplX3QgcmM7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgYm9vbCB2YWw7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDC
oHJjID0ga3N0cnRvYm9vbChidWYsICZ2YWwpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAoZGV2X2RheC0+bWVtbWFwX29uX21lbW9yeSA9PSB2YWwpDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBsZW47DQo+ID4gKw0KPiA+
ICvCoMKgwqDCoMKgwqDCoGRldmljZV9sb2NrKGRheF9yZWdpb24tPmRldik7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKCFkYXhfcmVnaW9uLT5kZXYtPmRyaXZlcikgew0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfdW5sb2NrKGRheF9yZWdpb24tPmRldik7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5YSU87DQo+ID4gK8KgwqDC
oMKgwqDCoMKgfQ0KPiANCj4gSSB0aGluayB0aGF0IGl0IHNob3VsZCBiZSBPSyB0byB3cml0ZSB0
byAibWVtbWFwX29uX21lbW9yeSIgaWYgbm8gZHJpdmVyDQo+IGlzIGJvdW5kIHRvIHRoZSBkZXZp
Y2UuwqAgV2UganVzdCBuZWVkIHRvIGF2b2lkIHRvIHdyaXRlIHRvIGl0IHdoZW4ga21lbQ0KPiBk
cml2ZXIgaXMgYm91bmQuDQoNCk9oIHRoaXMgaXMganVzdCBhIGNoZWNrIG9uIHRoZSByZWdpb24g
ZHJpdmVyLCBub3QgZm9yIGEgZGF4IGRyaXZlcg0KYmVpbmcgYm91bmQgdG8gdGhlIGRldmljZS4g
SXQncyB0aGUgc2FtZSBhcyB3aGF0IHRoaW5ncyBsaWtlDQphbGlnbl9zdG9yZSgpLCBzaXplX3N0
b3JlKCkgZXRjLiBkbyBmb3IgZGF4IGRldmljZSByZWNvbmZpZ3VyYXRpb24uDQoNClRoYXQgc2Fp
ZCwgaXQgbWlnaHQgYmUgb2theSB0byByZW1vdmUgdGhpcyBjaGVjaywgYXMgdGhpcyBvcGVyYXRp
b24NCmRvZXNuJ3QgY2hhbmdlIGFueSBhdHRyaWJ1dGVzIG9mIHRoZSBkYXggcmVnaW9uICh0aGUg
b3RoZXIgaW50ZXJmYWNlcyBJDQptZW50aW9uZWQgYWJvdmUgY2FuIGFmZmVjdCByZWdpb25zLCBz
byB3ZSB3YW50IHRvIGxvY2sgdGhlIHJlZ2lvbg0KZGV2aWNlKS4gSWYgcmVtb3ZpbmcgdGhlIGNo
ZWNrLCB3ZSdkIGRyb3AgdGhlIHJlZ2lvbiBsb2NrIGFjcXVpc2l0aW9uDQphcyB3ZWxsLg0KDQpE
YW4sIGFueSB0aG91Z2h0cyBvbiB0aGlzPw0KDQoNCg==
