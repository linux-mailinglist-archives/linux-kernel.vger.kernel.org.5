Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8677679B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbjIKVs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjIKKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:01:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B4AE69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426499; x=1725962499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=moAD8ETIrzJt++zuRKA+nwunHQzH6hhO6GbQC1kba0k=;
  b=NYmdivh9q490HmJXNOZgiDE12NBBs/1pvMpvWq4L0pMEHCRXBcdpWiyR
   C4tfxZrwaZiBGzgXCwZpAOqThlHZScUJd7ulyrh36zXujIyDIp98nD1+3
   FiYknY4dOkHm4UvBwBuCdf1nM5bcdHPRVrGjflXLo+jK1u3RONRzZmAaO
   qWvUOIAexJQBTM3+uq6ruDqove3SPYRtpM2MCHZbJXd0l5gBGI0uKVebZ
   poiu29WM+VSIai5ub+e6NkoqURHj7mgLzjD6gGBd7J+lwyyLFrOjo4SNC
   4wBFQUUeHJxzNema/fp8yQiCqYhBv3LnL1j5LVYbSal3c5Zcdu/yS863J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376955564"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376955564"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916963501"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916963501"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 03:01:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 03:01:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 03:01:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 03:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl9CcKBSicYAXU84WROGKxDoSWiHTi29v0cHVxhlQd4IpEeczQMCN2SRrcimsji0rhkXcHWhWVkeOFlm3LlIeBOqqh2E50MH4D8y96aO8+AdAJGDqXdBD2INO0lHJURnHTSJuS0NmplKUhNrVDNzxpngbgN9yn+iNp5+VICKGbgyQO45RnQLaXIi4jk7pq0rahKn9PjDEL6rtEI9tpMjoswuMaRk7P6eAoCFQuK5sPMNgZCcUXQmhrnYdKsLWOx+InX0jClhzfbo2XmmYuTqBAs8JCbRStvj4v/gfyubAoqClxYtLGjCnZAMfg+yfoD8b2BgGjt+QrNyKCOECKyV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moAD8ETIrzJt++zuRKA+nwunHQzH6hhO6GbQC1kba0k=;
 b=fb2k/cS97qeoau6FNgJNYhA6B5hzqGSUlAJAimFvTnEkeQynjjKOjHd68Agb0qslkoeNtlINVtt3VqUMTRNgD8iLgXgnPHXuP632R2Q+h4q6k1bovtHw+ClCqp4Q1JdxB5D6jcrjrQ9OpjfVnzRCOoTyB6vyU8EsD01xcmoh9QsxurIZVz3WYt7bA23UnAwc8j4Lqkbsewwy+x21JUDDMH2ntJvdtN0ujN/bXGIOVaSbV81cRp9BQMSvz0zTGBroLs5seOzjEHkafZ2OTpuKdlgJ/BlpEOzprsuBoeWB7HL6N/oP8xYFkPqB6peXN0BFheH9/KJvY0Uf7M+X6cX1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 10:01:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:01:25 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Thread-Topic: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Thread-Index: AQHZ4Tat9x0/TMaw9keTjiStSWxYFbAQXXIAgADApQCAA6gjAIAApS4A
Date:   Mon, 11 Sep 2023 10:01:25 +0000
Message-ID: <0ea15aadac56856fceca19205d077a9b97f55437.camel@intel.com>
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <da4a6c3f4cb9118e10866cb1d624ad5ec5c96d7d.camel@intel.com>
         <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
         <2371c186-ccd4-48c7-b302-e289adb30dec@linux.intel.com>
In-Reply-To: <2371c186-ccd4-48c7-b302-e289adb30dec@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5111:EE_
x-ms-office365-filtering-correlation-id: 3245d6e4-4c82-4584-72fb-08dbb2ae0f2c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncf+U9871MtrKjikeAMeFSJscghrZXFiecaYDnUzn0r8kvvNM4yuU1pHL47ZaAEXM87YraNoM1uM2EmZeG6wT7tqJiIUqw2tRq0RLL+5/OF2jYXhf5+2cLpCrIcWvhTuX4xo3SuOndomMBXkDVx/F43xq1ivqrk37/jsMQE8k2SPrF0ND3RnR+krTtzR0UA85o+Tuj13uCD0ymFcVMjt8QRwbHVpVIWprMoULWoZAn74N+L/H2yG/EraixIAFe3DZ9NAO1vnzlLefdo0l8J+MhDtuiCG3czQSk6ji4CtLYpwOd7e+IVcWThnNVGyMxR4R0LSwJDJ+vr7Jjq2QE8XFlYuIJv7l0SDSuote6k8UzQJR+vzVb6lcSon1U4sHy2y7G9uKykO22jdLf9jYxoviOoOLWjYgKjJ5GUSMh1RxpQIdMrL9AtairAZ/DFgZDHIol2gyxgzfpiGIZEKJPwvKP5HFYdy1QgSpnLUX/2kWRV7jRBuAhZdkDFRXpSSesr/dl8MDNahH5Vdb45JeAorwDXrHR6mLmnoAtqz8At6RvYOVimL/ff7JcNc2kwF9UTFGJNuYKSNfviK5bJBdD7dNu2HE3trVXnFdI1MIoauewPbIsSfXWq7gY9zLsPPo7Y4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(8676002)(316002)(54906003)(66556008)(66946007)(66476007)(64756008)(66446008)(91956017)(110136005)(76116006)(26005)(71200400001)(2616005)(36756003)(83380400001)(122000001)(53546011)(6486002)(6512007)(6506007)(38100700002)(38070700005)(86362001)(82960400001)(478600001)(7416002)(2906002)(5660300002)(41300700001)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmJ6SkRrZWNtMHlRTURaT0g3SVU0S0c5Y0liUWNjWFVZMHRrU056a1Bna24w?=
 =?utf-8?B?ZStuaEoyQTdwRzlzZlVUbG5KdlE4SmJ2WWhRYUhVcjZkZk9ZTXdBS0dsTUhH?=
 =?utf-8?B?MEFZRlQvVWhXdHNOeldhVVVDYUF0b093K243QmFUaTQ0TCtMeXpBRDlmL0JJ?=
 =?utf-8?B?V1J3Mmp3Q21BSlRlVkdKZkd4ZERob2xWaGlZeEJqbzkrSCt0RURTUnI1SVBF?=
 =?utf-8?B?N1puUWRaSlN6b3RLTmwwbFNEbm5GT08xbGNjbWJvRmpJdHNNNTJrTU0xZWZV?=
 =?utf-8?B?TGVJaEsyZkwxUEFlTi9FdVFjK1V2QktHL25EWDR2c21NdHl2bE1wNStrZjZo?=
 =?utf-8?B?OE9zYldSOWg4OWlQQ3kzUW8xQkI1azBVK0k1cWlUcTdjRzRIVnNEZzI3Vzlv?=
 =?utf-8?B?bHFtYXpXenBrYmtCZ2dleGZOZk0wQ3ErVmxmbWNmYWV6N2Joek15ZW5mTWln?=
 =?utf-8?B?Z0lIenZNeWZNV21FOG90akNzYk5IVTJ0Q2FCU1Zya1dMc1pSU085RHd4ZGdO?=
 =?utf-8?B?S1Z0bFVwejB1R3BnOGozWm9rQTJlaU9JWXU1cDlWRDZuSExMVFZzd0lFS2Vi?=
 =?utf-8?B?WmJ0ZXROL21TSDRGY004alJHbkFBVHJJTDhJOVVXWnJMYW9wZ2VKQ0I5Qytl?=
 =?utf-8?B?Q2MzRFpPaXlQeEl2V0pPTTlFeFhZajhGTG1IN0lGVDFPdlJvTmxHaDkzcUdS?=
 =?utf-8?B?YTROQlJwS3F4TG5Ld3FwZG1LZUVJTXpRUkJEMWUxZG4vNTRTa1VyTitGaTBO?=
 =?utf-8?B?U2tZeHZCUDBtNnVWdnI1R3IyaHJmMWtDbkUyT2p6dGNTWGs0bnpUbjF5UW4v?=
 =?utf-8?B?SkpuVzZCd1NZeFVTek9ob1UyZUs3ZjJ1Sm80cGE4RjFCOUtqOHVSWHNvanhW?=
 =?utf-8?B?VmJNclQwTnNJYUdrcDJpcTdoVUpnaFZoUjFUWUxOdkRPMjNzYzUxbFdhWnhN?=
 =?utf-8?B?bG5teUhrYXhhQzdWcEY5cFF2cG9hT1lqS2NvcHY4b0tPSURiZHVpRldDYklC?=
 =?utf-8?B?WjlXdDZSYkJIWkVTN0wvNFBSTTZBOVpMWHNzY0FwTU9WQ3Z1ZnNPdVJ4NlM5?=
 =?utf-8?B?cUdCMnRnZGZBRDQ0VUxEZGdVRmZ1QThuN09VMzR1Y09UcHlGQ3BEclphYVg0?=
 =?utf-8?B?YjB1N3pSZ1dDd3NlcHN1aUlBeDJqQzBZT0ZEaVUxN0dwNFdiM09DYS9RNlVD?=
 =?utf-8?B?SFc2NmZ4cThFZU4ybnlUNDlhMFUxQ09KaW0xZ04wMVFIUEhGUkhkUG1HNlBJ?=
 =?utf-8?B?bmJxYXZVWk83cG5rdXQyVmY5enVJZVVCdS9sUGlvc3N1S2JEdlpvd1F1VVNj?=
 =?utf-8?B?NXdtOVdkNFZQTnZDYUsvbkY0TGh3ZEpNdEIxMENrZzRYUmU4YjZhT0NPcEdX?=
 =?utf-8?B?WWQra1VCRDR1Z0hGYk1qMUFvaG9IOHpIbjBHVUwreHZHdzNuSmloa0tIcDZM?=
 =?utf-8?B?Y2VPeUtodmxDTCt5WitoNTFUK01Md1Izb2lwUnhMZTZXMmxpRjlIbWZXMzUr?=
 =?utf-8?B?ay9YQ3hXcVFINGFqTFNudklqTHZxdWxKU1UvRHBBL2lLWmVwT213UmJLNTQ3?=
 =?utf-8?B?UUZydVhkZk1GQnI4RkRnVzlhTzR5OGR3cEFiVDRuNEljUFJWTm1VbVpDRTdn?=
 =?utf-8?B?TjUvWU9nSjRXRXdRWGx1clowNUxHc0ZxQ2o5L2tEbzc3NW95ckF0aXVlNkVY?=
 =?utf-8?B?UkQxZWROQzk0blZUYVlVMm9tV2hEN1lUR1dBRmxnL0Z5NENxRUN0Z0xPYXFS?=
 =?utf-8?B?M3ljZkt1WmxqUWp1bDNmdHowQlQvQUU0THFUNDZlU2dzUDVrNi8yYmxqTHhm?=
 =?utf-8?B?b3k0QitLMHcyNS9ZZEZUdnpsTG91V01CcHRyNVNoRGJHZUxQNmVPcTZQb2hn?=
 =?utf-8?B?QWFWb3hOVW1PWE1sa0svS0g3eWdhOEtjRmc0RGtnaEZIN3p0MDNRVVo1TGNr?=
 =?utf-8?B?Tnk3aDBzeXJHRHRuNWRhdDN0M0ZsUmhuKzkwdWZ6d2QvbGdPazBxbTVlSzhx?=
 =?utf-8?B?V3ZSV2xmclNHd0pqKzdITlIwbUU4TWhrSzVuN0lpRldpUUtIdFkzbFRPbEVY?=
 =?utf-8?B?eDJuN1poTTRKWjArSVlwb3kyb2thQ1UzZ3F2b29EWkVYcysxZ1BIdGhzMjVq?=
 =?utf-8?Q?eb8v3GmZImljLnMgl9pM4dbV5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FEEB8C6712FC478304B3E99D0FBE73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3245d6e4-4c82-4584-72fb-08dbb2ae0f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 10:01:25.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC65fzFhIzUnrTWejRNOBbAfhpfa4pwWp8+wqdnat4L8IQoQaGLBhHx9NRXXiG4w6oi2RfG0VM6+z1MlOciMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
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

T24gU3VuLCAyMDIzLTA5LTEwIGF0IDE3OjEwIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gDQo+IE9uIDkvOC8yMDIzIDk6MTkgQU0sIERhbiBXaWxsaWFtcyB3cm90
ZToNCj4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBwcmV2aW91cyB2ZXJzaW9uOg0KPiA+ID4gPiAqIFVz
ZWQgQ29uZmlnRlMgaW50ZXJmYWNlIGluc3RlYWQgb2YgSU9DVEwgaW50ZXJmYWNlLg0KPiA+ID4g
PiAqIFVzZWQgcG9sbGluZyBtb2RlbCBmb3IgUXVvdGUgZ2VuZXJhdGlvbiBhbmQgZHJvcHBlZCB0
aGUgZXZlbnQgbm90aWZpY2F0aW9uIElSUSBzdXBwb3J0Lg0KPiA+ID4gQ2FuIHlvdSBlbGFib3Jh
dGUgd2h5IHRoZSBub3RpZmljYXRpb24gSVJRIGlzIGRyb3BwZWQ/DQo+ID4gQmVjYXVzZSBpdCB3
YXMgYSBwaWxlIG9mIGhhY2tzIGFuZCBub24taWRpb21hdGljIGNvbXBsZXhpdHkuIEl0IGNhbiBj
b21lDQo+ID4gYmFjayB3aGVuIC8gaWYgZHJpdmVyIGNvZGUgY2FuIHRyZWF0IGl0IGxpa2UgYSB0
eXBpY2FsIGludGVycnVwdC4NCj4gDQo+IEN1cnJlbnRseSwgdGhlIFZNTSBhc3N1bWVzIHRoYXQg
dGhlIHZDUFUgdGhhdCBleGVjdXRlcyB0aGUgVERHLlZQLlZNQ0FMTA0KPiA8U2V0dXBFdmVudE5v
dGlmeUludGVycnVwdD4gaHlwZXJjYWxsIGFzIHRoZSB0YXJnZXQgdkNQVSBmb3IgZXZlbnQNCj4g
bm90aWZpY2F0aW9uIElSUS4gVG8gc2F0aXNmeSB0aGlzIGFzc3VtcHRpb24sIHRoZSBndWVzdCBk
cml2ZXIgdGhhdCB1c2VzDQo+IHRoaXMgaHlwZXJjYWxsL0lSUSBoYWQgdG8gaW5jbHVkZSBDUFUv
SVJRIGFmZmluaXR5IHJlbGF0ZWQgY29kZSBjaGFuZ2VzLiBUaGlzDQo+IGFkZHMgdW5uZWNlc3Nh
cnkgY29tcGxpY2F0aW9uIHRvIHRoZSBndWVzdCBkcml2ZXIgY29kZSB3aXRob3V0IGFueSByZWFs
DQo+IEFSQ0ggbmVlZCBvciBiZW5lZml0LiBTbyB3ZSB3YW50IHRvIG1vZGlmeSB0aGUgR0hDSSBB
QkkgdG8gbGV0IFREIGd1ZXN0IHBhc3MNCj4gdGhlIHRhcmdldCBDUFUgYXMgYW4gYXJndW1lbnQu
IFdpdGggdGhpcyBjaGFuZ2UsIHdlIGNhbiBoaWRlIHRoZSBJUlEgcmVsYXRlZA0KPiBjb25maWd1
cmF0aW9uIGluIHRoZSBJUlEgY2hpcCBjb2RlIGFuZCBsZXQgdGhlIGd1ZXN0IGRyaXZlciB0cmVh
dCB0aGUNCj4gZXZlbnQgbm90aWZpY2F0aW9uIElSUSBhcyBhIHJlZ3VsYXIgaW50ZXJydXB0Lg0K
PiANCg0KU29ycnkgSSBtaXNzZWQgc29tZSBpbnRlcm5hbCBkaXNjdXNzaW9uLiAgUGxlYXNlIGZl
ZWwgZnJlZSB0byBpZ25vcmUgbXkNCmNvbW1lbnRzLiANCg==
