Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C75792AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbjIEQnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354132AbjIEJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:49:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383761AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693907370; x=1725443370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U1M5qPhXNB2QPYjjlHOQJGXfCCgib+yGMJtjnaee/lQ=;
  b=frhN50EDymnjE2QE3laEfkQlg9ElbLs5nt1TeV9Gx0amPTrto9QguEqw
   uZ9oogEDxauZHRHrjMUO4TnKnVV0RKQiWoAXAy76fx+aTUvx6xesi0e4W
   +UIBLJ8K/1Fm5XFWGt4HLMBMqAwgSSmbaDPRqnZ4ib51PnE9IyndRENjk
   OnCEJIxvHuVq25+zvtLNalNR0lopnEo4E68K4rGlSoZRgBxDcRfuBFFz4
   hw5MG60A+QqeFT+4rHcrbDe/44X8HJG5ZDr5OcqdIaG56QrQcYoSDPUcS
   BcfUJVoqN4nbQTBMctnaPqoiECBYi9bDrHcbOdYQ4i7bhVs2Y2rUZ7CT0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379473703"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379473703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 02:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="770279898"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="770279898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 02:49:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 02:49:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 02:49:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 02:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmhsRGYf35KP52zVcccA2pY7uW5JMzX0RrXuQYO0Ore0qr4ZpeGLzAmO61SBLyQDfDoz56MPBEm0fZ/2eRjgCTfIur47Uc8MCftpUPSJzz/SbUko83qPEcqnIeMHs7ipDLQfKCKy6OVycFWSNfx4BC6tW9ieyMQf5VcaObKLAgXHcsF3beq5/zWwTupL5I14Mw5/MLZbm9bzm+Tc+kp8Zz34BlgUrmkANyd4/wJmiwZp/JDjUsbF+1putuPWtgqmmazEXzw6KzTT1297pU1D+/Rux+lZ1q0H7YSVUd6Rz2GHgMapdRezN4tcqBhm+/kTAj+Yjv2PKwH0OUNQpXpIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1M5qPhXNB2QPYjjlHOQJGXfCCgib+yGMJtjnaee/lQ=;
 b=VJFGnZq9Gm86AIkyNznfkHhMGIj2K9X9prkR87RBcNplhrNqOS7Vll74x0qMSgkbXouboxJrX7/JosDs0+PWnIn+hvMaGWpM5lBBjmrNFeso5snjZD19c3essUJmPD3iZFKBv6E5gENdQ+qMXscT+iYPGsL94jffOWhRSvV6Q065DzRVhhcht9q57PLCxwUjRJ8CPsv9tdDC7advVRZ8Y1W4pKDk7g0VvfSN8ZwqiGWq17ozHPpMebVsMAQATVfd6xfAZJIPUNVdtsj3ReSq5m3ED82fyQnO32XzQaKF+FogSIlK7uw2+zv4U5snp0tEgMAfkOaJFdJ/3jYvBX5sVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Tue, 5 Sep 2023 09:49:27 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 09:49:27 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: alternative: remove alternative boundary symbols
 in vdso
Thread-Topic: [PATCH] riscv: alternative: remove alternative boundary symbols
 in vdso
Thread-Index: AQHZ3UN/Mb2FJmOivUiZGhwvCU4HhLAKv4yAgAFBurA=
Date:   Tue, 5 Sep 2023 09:49:26 +0000
Message-ID: <DM8PR11MB575193E774FA8A49C88BED86B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230902022510.818602-1-xiao.w.wang@intel.com>
 <ZPXrKz1jhqz5g3nF@xhacker>
In-Reply-To: <ZPXrKz1jhqz5g3nF@xhacker>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: 7dbd4690-b25b-4413-c0c7-08dbadf5649e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPZ8RKN6TM3hjT5MFNiMWbNk2zrHppT+HgHOjMT+F3b8R1TDlE8oKI54gbA7R7bRm0DB187oEzRTgTa/vkVkBqnp8vbITwz6TsgNOsC2h567QmA29Ju3AT8bolpitJWV62QhR6u5wejp+SUo8tAxMphVHaVukZDfFF2venvmBcxyZgqkzWJfeG9dqgIEOj1CtPEScW3QTBTvvdu54nCymHM7m2yDdhEbf0nt7vYc+0jvQVhzziRGB5knHe6JwaNInkodh1x8Mx2Oxh7g77bC7GStq54NhN+a5pJpuxyRmsJDnrKYw0evokpXp+yRJVYzGrR7rgEvNxU3wfarUKwYMPOjz5wAgWzBuI5qRyL6fZzN4Ff5FE0x04fa2TsIjNgx9ojE4KpECqZDyOYbFx/IDo9iw1eHlR3kHJxvr/l4OFOKSwfHIt7mSTXNC/Y0Zea2KASywNgu3WqiyJUJuUUt4+TaAtvShvZbdMDZaLOJE/GWEJ5E2yQAiEVRPpzcPpcCJPtDs0WVn224pQBoeABlMyXCli0n0VkOzKoDZBdLSuwoRTsuN/X4hcX/Pb628jlmwD3dGMkwXje/icczgXtNcBKHubS/C+Cyt3WKFEV57SY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6916009)(33656002)(8676002)(71200400001)(4326008)(8936002)(86362001)(6506007)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(54906003)(966005)(7696005)(9686003)(478600001)(53546011)(41300700001)(83380400001)(55016003)(316002)(38070700005)(38100700002)(5660300002)(52536014)(122000001)(2906002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3k3ZzhQOVpMcldlRWpaQzdROGViZVd1enBPR2FPU0Q4anJ0U2VXRklCRC9S?=
 =?utf-8?B?dkk4T0VrcFcrSDdUWFRLUGs1aDFDa0diZWJYZjZ1SFNtOFdQWGxlUXUzTlZL?=
 =?utf-8?B?bVB2NlYvcVI4L0hQb3oybkIvdHI4bU1VcXY0dk9BMFZla3BjdVNERTRpVGhN?=
 =?utf-8?B?OW15Qjg4Mk9SZGxybGNOY2E3N2FhNURJelJPclpxRk5hMGF3aE9VN1c1bXJ4?=
 =?utf-8?B?REc2ZDNabXcvZXErYzlQK3BvYzUySERUc0cwWk1rNm40azNWLzQrV3pqczdF?=
 =?utf-8?B?bUNtVmFzdWR2U2c5dGZ5M0oxK1Q4RCtia2N4TTVDWTdCNTV6Zi84N1MzNDJP?=
 =?utf-8?B?dWV5bE1Ta0FNdnFiNFE3UnN1SzRYVEpFMHkvWkNwV0M2U1IvYzV4Q0JQV2RF?=
 =?utf-8?B?MEdVVzRtMDd0MmJhWWRzdWFoQnQyNzFKOE5uUnNEckh3ZUk3ZjNNeCs1ZWtp?=
 =?utf-8?B?TlFzMHF0VVAyZWptWnR3Z2xvcTRqWDZPNGxtbFVPTkRlUXFjVlE3SGUwUDYy?=
 =?utf-8?B?NXY1SWdVTUMrNjB1akNlZk0wSlg3OTdhazBuZFNMa1VBeFVpRXg4YjdsdExL?=
 =?utf-8?B?OUM5a2Y2M1RKZFhZdFJyNmhYZyt2U2hoTHFweE5CYXZ4MWY2OXNMVndPUEtC?=
 =?utf-8?B?elZWcGFhVnRPaXdWdTVWT0FIRWlRQitMTkVrMjRjeWJSYTJzVDZ2d3N0czlP?=
 =?utf-8?B?RWpZeWJWZU5DaGk1dlJuTFN1TDFyOTlHZGI0eVZjNXBGUVpQU2dORFhGaU5T?=
 =?utf-8?B?WU95NUdBNWROMGlzRFhVeC90ektuQ04rVE0weUY0WG1TMGZBL05yQXhsWGM4?=
 =?utf-8?B?Wm1CcTc5SjhiQzF3NGpNTWE3VXlGZWFaTG5ka2tVT0I1VFZ3VVdQbmRxSS9s?=
 =?utf-8?B?ZUpVSjllTWtPYkduK3E3NGdnSlJaVTI0V3BYNGdBeitjT2gzWkpSRXhUdnNN?=
 =?utf-8?B?ZFFWNTJDM3NhVndUVHVYR1F0YTEvQXdqd3lxc0xMMVRFa0xpalcycFY5NEFL?=
 =?utf-8?B?SGd6d3U5ZzkrZXp3a0g0ZjZ4OXgzRXlkSGdqYUxQNTJGL2Vwb2NlQlpkVnlm?=
 =?utf-8?B?VlNpNTVhb0VPYmVJTGZaUlRrYWNwdEIvOHhrcGFJUTYrMGp0N0dWYUp0VFJi?=
 =?utf-8?B?N0IyVmVFUE1kajkxTzJVRTZFR3JDTS9VMnQvVjgwTWYzSEpsRFk5WUdSUHp3?=
 =?utf-8?B?Q3V6ODZxWW5Qc2pJcnZuNHBUY2M3cHQrbE9PVWdmZHI0NFZWMHlJMGlYWkY3?=
 =?utf-8?B?UHYwN2pOVHFEUGtCbXIvNTRmUU16NHJkUk9nOVJiWHZENEZnQUZEbWdkOEky?=
 =?utf-8?B?ZDRtbjBRNkp6eVowWDBITmQyYVF1a25xbUxVaDhlenlZQlVMZXRrUmlwMG9p?=
 =?utf-8?B?M21YMnhOeVNoQ05LVTUwQVU4NFU4Yk5Jc2VFSnRNU2RKTFNWemVWdFFacW5z?=
 =?utf-8?B?QkNSTS9nTG12QW9yVlZwTFVYZGpNdis2eUIwYnFKZWZLeURXY1lrTzBwVFFt?=
 =?utf-8?B?R0tLZTNZUUVRZkJUeFlpVVZhU1FTLzJJalZ6aUdTTXoyRjlUc0NzbHBtd2w5?=
 =?utf-8?B?Kzg2VnJYV2twVmVmRkcwOVEwMzBhRE4xZHVkNjRDUTR0d24rM0JkbW1rc0J1?=
 =?utf-8?B?c3VqMng0bURuWEFmaU1CWHlYczJJSXZoQTB5SHBIRUdMY2l5MkFnVURFdmVn?=
 =?utf-8?B?MWhQUXA1UWRMcnhtMWxpM29wYzlLMSs5d0o4cWhxUHJTQW44TVhzMmJkWEhu?=
 =?utf-8?B?WXVOUlNLQlZrVXJTZGFiSnVLSlg0SVYxbytpbXlBVHpBSmYwVC9FLzZSN1VD?=
 =?utf-8?B?R29FWXlvZjZabE82c0JiRzkrWks2VU5xc2NnSmcrR21rTzhGWm12UFpPa2k1?=
 =?utf-8?B?dWdVaUhTT1ZFYWVOQ1BwT0RHUTFzZks1clZ6MVhvbW9kVW9MWGFYOGVFWENJ?=
 =?utf-8?B?Q3dvZ01zRTJDNlpzT08xazZzM3M0eWxPbWJGNWR6T3BEaVlZTzVSbzJYY1p0?=
 =?utf-8?B?MC9OV0U3VUR1V2F3QWFIY3k0OXVKbmk2cjV2T01yajNvUEZNZW9iZWVWc1F6?=
 =?utf-8?B?Tzh5aWFGclZIWnVwUFVzMkNmS0xTM2JIQlhqQW9uRjZhVHBudTd6MHhYdlNX?=
 =?utf-8?Q?Ov3g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbd4690-b25b-4413-c0c7-08dbadf5649e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 09:49:26.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hh4HXSIVR2XPaYPGlbR8RLWnJ+ykhrM6OSjNfvzj/Qf+NWjf0AlNyG9CDSaCXpu5ZCsytE4YNTmnC2Tatlg03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlzaGVuZyBaaGFuZyA8
anN6aGFuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA0LCAyMDIzIDEw
OjM1IFBNDQo+IFRvOiBXYW5nLCBYaWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gQ2M6
IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBhb3VAZWVj
cy5iZXJrZWxleS5lZHU7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJpc2N2OiBh
bHRlcm5hdGl2ZTogcmVtb3ZlIGFsdGVybmF0aXZlIGJvdW5kYXJ5IHN5bWJvbHMNCj4gaW4gdmRz
bw0KPiANCj4gT24gU2F0LCBTZXAgMDIsIDIwMjMgYXQgMTA6MjU6MTBBTSArMDgwMCwgWGlhbyBX
YW5nIHdyb3RlOg0KPiA+IEluc3RydWN0aW9uIHBhdGNoaW5nIGZvciB2ZHNvIGlzIGJhc2VkIG9u
IGVsZiBoZWFkZXIgcGFyc2luZyB0byBnZXQgdGhlDQo+ID4gYmVnaW5uaW5nIGFuZCBlbmRpbmcg
b2YgLmFsdGVybmF0aXZlIHNlY3Rpb24sIHRoZSBfX2FsdF9zdGFydCBhbmQgX19hbHRfZW5kDQo+
ID4gc3ltYm9scyBkZWZpbmVkIGluIHZkc28gbGlua2VyIHNjcmlwdCBhcmUgbm90IHVzZWQsIHNv
IHRoaXMgcGF0Y2ggcmVtb3Zlcw0KPiA+IHRoZW0uDQo+IA0KPiBUaGUgc2FtZSBwYXRjaCBoYXMg
YmVlbiBpbiBtYWlsaXN0IHNpbmNlIEp1bHk6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1yaXNjdi8yMDIzMDcyNjE3MzAyNC4zNjg0LTItDQo+IGpzemhhbmdAa2VybmVsLm9y
Zy8NCj4gDQo+IFRoYW5rcw0KDQpPSywgdGhlbiBwbGVhc2UgZ28gYWhlYWQgd2l0aCB0aGF0IHBh
dGNoIHJldmlldyBhbmQgaWdub3JlIHRoaXMgb25lLg0KDQpCUnMsDQpYaWFvDQoNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC92ZHNvL3Zkc28ubGRzLlMgfCAyIC0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3Yva2VybmVsL3Zkc28vdmRzby5sZHMuUw0KPiBiL2FyY2gvcmlzY3Yva2VybmVsL3Zkc28v
dmRzby5sZHMuUw0KPiA+IGluZGV4IDgyY2U2NDkwMGYzZC4uZDQzZmQ3YzdkZDExIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3Zkc28vdmRzby5sZHMuUw0KPiA+ICsrKyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL3Zkc28vdmRzby5sZHMuUw0KPiA+IEBAIC00Miw5ICs0Miw3IEBAIFNF
Q1RJT05TDQo+ID4NCj4gPiAgCS4gPSBBTElHTig0KTsNCj4gPiAgCS5hbHRlcm5hdGl2ZSA6IHsN
Cj4gPiAtCQlfX2FsdF9zdGFydCA9IC47DQo+ID4gIAkJKiguYWx0ZXJuYXRpdmUpDQo+ID4gLQkJ
X19hbHRfZW5kID0gLjsNCj4gPiAgCX0NCj4gPg0KPiA+ICAJLmRhdGEJCTogew0KPiA+IC0tDQo+
ID4gMi4yNS4xDQo+ID4NCg==
