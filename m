Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820487CE1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbjJRPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJRPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF59F;
        Wed, 18 Oct 2023 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697644399; x=1729180399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UUjBPsfi+J0TqwmbyZclGbOudcOhWDROxp325aCSpO8=;
  b=BRNDPE5fTP0ePwSEd+JoKaLrZeF+QxWT22QdglTGsthpq5IDfKtY+fid
   jyHTzEqr63xQSFf4i5iAIPxqfsME49j8QtqzbEfjKQLgYLont3NVCpAF7
   JMVlzlQgWytLEfFZ4YDFlLPcdclWk/aZpwnqnbe/9FE7MVaYQpielPRnM
   oPwgDualtDrnruzlkLB01F4p4QicMTAE5pf4TXYgf6EziVh7gBWDMvgvq
   gbZT1hDtkoZLcwzKAKby30v3+4MOO3Ai3wStvPRxtL2fKYBWN6gl5Vtlq
   c2IRxnD1vXPfiBoUfKNw9xlk7cmdna+TEDmj+Y8Rh7sbWsvAN7DpcU+hG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7593764"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="7593764"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791666302"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="791666302"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 08:53:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 08:53:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 08:53:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 08:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVAY3Kh9ktTVf/UIJXlMmVhBmwyvjpSiqmqqvIn0jL4nPWjiJDuYOTAjo8TQ2CT9c8Ru9hiSQ4GQ/ewuN2tvPRiov/htU2D8yZ/H7XIZioXQ871mX+nam0MHYdEO1cU5H4pWpMVAyoRptnEmm62MQgRdm9qBdNFJoP2uKeAhpoOzTjDQNP2NBZLk7e+T91zPD3W+CXPPn2Aag2QroopHyUMaEWZu6iB5EyfE4uhrzC6QHDQVpISrzVJ7TG0CQ6dxIT7cTVHEfhKhS2uoWlLMQGhgcvOnaaQo6xPbK45vRn8ubIcupm8vumj1T8VIIdp5k0PuSrehyJay2y4idFAd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUjBPsfi+J0TqwmbyZclGbOudcOhWDROxp325aCSpO8=;
 b=BT+cPTGn++sPFB0EVTW1ZYBXngQcPcFmW4Q8yRtjk86W9tQxOzYydnJ69AY9bkpDRMaCr2OP5thqphM7BQ1f3ABm4G7n7fLOiBlE/6uEQXfKn19D+BFfDegq4iPrVdvUGNIw+ZxA8MAC8fwpB3guqzDNsuYaHoXIiypc7hYyI6AKQ4s+gqZ2Ui92ALDXlwreGRnLGpXCmb+lerYhMaqzFH9hEG5cIv0tkML/PQZEgfKpfFjChSiZ28O+ilym7jeubmLIUqu9ysN/g1FKWN4iRACc6jovrhMtjj7cXgBTnzutecH+Bh1sm1oxsmGVPawCrWEi3a4G/qJC+kuK8aQzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 15:53:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 15:53:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 02/10] x86/mm/cpa: Reject incorrect encryption change
 requests
Thread-Topic: [PATCH 02/10] x86/mm/cpa: Reject incorrect encryption change
 requests
Thread-Index: AQHaATgUZdj+GW7SeE69yzlwMw2z5rBPPEeAgAB3r4A=
Date:   Wed, 18 Oct 2023 15:53:14 +0000
Message-ID: <6612974c1101874faedb5c0b5bb6555199ed7321.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-3-rick.p.edgecombe@intel.com>
         <ZS+bA2l/yh0zZLmd@gmail.com>
In-Reply-To: <ZS+bA2l/yh0zZLmd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: 2c2f3398-5516-456f-7346-08dbcff2568a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mM5BqWqyykMhF79uVGpQXgXeahsuzdUV8DmBOqHQPhD1HxDhFa1Mft0kstWmuw832Yv49ec5ep1zjYBNKOR8F2RLwNR6P5nY5MuGfjKzj8W12UMdZqclh8cB/B5lLUfysUQNBa6milHKlBmmeh+HdFb43FSUAEu3DcT+0nyDVG1my/90MEqZ/QZJxujbFkKmSwh7X7hI93Y6idz4eY4nW5TcgXILgVDBcBQ2w1LLS2NEsmdeOD5eBHGwtwMhAbZSyFc2QHvNS6Xb/W19+hM8ZJLvJU7A1GUhwfBKQ9nr73bnc4l4GMXPFEAO2DsG9K9fFnVKTfd27U8TDCRFLUImqBaxHJEvuCNvcmDzTlORuD+FLDaW0hXDYyCz6fB/DE3sKFdqF7CTeUbKlddlTHP46/CskAaWN5u63nYvfSnaGgveDzhGIAvtwNQIKQbuaSW94YqYLGBeI9b4azaos2M9D7wI8bhZNovMNLG8E98SnqZXjaNAOG0znVh2mvYCxZHLdngEIlpf3aFv/O7ZWPcpjYt0zFh6nm+nNvMz7FrAb019pwgSxH103I7nbp4jE8OcrK2wqhmpzZGwXO6P2kLXyztZRmHOkvJqQGkC6TtJ4vvrNjyPz50Vs8VoslypaVxn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(91956017)(82960400001)(26005)(2616005)(122000001)(38100700002)(38070700005)(83380400001)(71200400001)(66946007)(54906003)(76116006)(66476007)(66446008)(64756008)(66556008)(6512007)(6506007)(6486002)(478600001)(6916009)(4326008)(316002)(8936002)(41300700001)(5660300002)(86362001)(8676002)(2906002)(4001150100001)(4744005)(7416002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjJzRENyY29ramNuVGZxaDZRcFJjQVphKzg0SUJXTWVGRmJYdkNCZms1NExn?=
 =?utf-8?B?c25qSHpoT1ZjYzJjK25JQklyU0hXUVY0UEU2TW1FaHRxN3hFTzhORSt2dDhn?=
 =?utf-8?B?MndtWGRuN0ozY2lWVjFXTXl3elAzTjVaYmtpczM1R200VzZvbU1vZmJCQXl1?=
 =?utf-8?B?RWdwblhGVWF3RE05YWRiTnJsZ0ZRTWJEZnZkNW5ScDljaXBJbFh0V0RuNkZr?=
 =?utf-8?B?amZrcXNtbTJPZkxmdGZUUDU5MytyUVpCUFBKM0IvUy9razJURmJ0MmhMR05H?=
 =?utf-8?B?alo1K3VRNXQ1L1dSYWZ2MjAxaWs2aDlZaEJSOTBJa1JyNFpPci80ejc1Q0tE?=
 =?utf-8?B?Ly9sSUJoOGFYTmVkd0tqUXJkNHZ0ZXVEOSt2ZGVDbUNwZE5MWHlRK1cyaTdv?=
 =?utf-8?B?WS9FUGVIT2lObFo2dUM0anBmNlBHcFJzMTBLdXhPdVlzcGVRSGhVSnJCc3VV?=
 =?utf-8?B?b3luYmg5MGpDY0pXM1B6VElhUUVVRThvUXI5SW92TlphZGxRZFQwMmNDSlFv?=
 =?utf-8?B?RWZHY0ZNN3pYcEs1SjMxSkR3WVlRZHJWYzNDNnRaM0NTTUF5Qjk0ZUNuN3ZS?=
 =?utf-8?B?SEN3M2ZUTnA0TnFMRlVIRHN5dkRKYkQvYm9UTE9MbCszKy9EVWJvWlhLM0Ev?=
 =?utf-8?B?RTdwekFTNVEzK3N3aXZPeFRpaWlDUkRidWJNQzVWZkRJREVOREZKWmoxeTF1?=
 =?utf-8?B?dmI0MGx6WTNUNTJDTzhWQ25BbWlhWXAzcDdMa3EyVThMNmc2TDhUaVJGaVhT?=
 =?utf-8?B?L3czdElTd09RcjVPbVJrQVRkY2xpS3VteFZpazZiRFd0ajFIWmV6R24ydTJF?=
 =?utf-8?B?aVJGQ2NYT3d1V3MzNlN1Z0I2T3NRTFRYRGJ4UkExL0l1M2I5QXRRaWlwOGd4?=
 =?utf-8?B?cmJYaHZ4MlRCdjZtUHIwRXRZTlBkVmQyY016bU5BNUhoMEdoK2dsL1RVMzNh?=
 =?utf-8?B?ZmgxZmsvQnBKWURCSHpTWHVIcE8yOWtHWUd6YXZYQ1lHVGZnR2RhaU1qMmF5?=
 =?utf-8?B?bVBJWU8wZThUeTNCS2NvVFMvemVtNnpQcGE4TVZpSzd1WW9EYU1yakp0OE51?=
 =?utf-8?B?SjZVcjZxUFFpbEN2Q0hvRkpEenlFNWg2SU9iZVM1OSs2cjlJUmdSOVVaSzlB?=
 =?utf-8?B?c3hrVUhDdnJPdVZYVjgzMnlreThLWDNMazhZYStRUUhCZ0hsTnR6S1g1bExh?=
 =?utf-8?B?VmkvWDhOZTBwajZSWnpHWnY4Ym1Odi9HMGJ4empLVjlnci83ZXVUaEZIRWI3?=
 =?utf-8?B?N3hHaTAxZmRjTW04NFEzeHFVbjlDOTNSY1hYRE9ON3V1ZlExTXcrL3cyZEN2?=
 =?utf-8?B?MTRHTGhNdjJ5eGE3Y1lCdjVmZm03Zi90TlZkZFIrT2o3T2Z1QUw3anBCSkEr?=
 =?utf-8?B?L2Q2Q29OdG1ycFl6THJrV2dSUHV3SnpOMjFFeVVGNnRQbXdDd1VaYU92OGwv?=
 =?utf-8?B?eFlQZ0F2THl1MFg1ZWlZTUdtNWIxNG50aXdRV3VlS0o2b2F3OVpWQUMyT3pi?=
 =?utf-8?B?R2JQRlkvNWwwb0tIS2VMdFczWVNGcnlVM2VPN2I3d1BUd0ErRExLMGNsRzRG?=
 =?utf-8?B?SGdNUmMyd3UrVFFVditrUmVhUXlMdXVHQUYxMjhBTWlleGo1Q1pGaXU4WXll?=
 =?utf-8?B?Mk5JVnduK05JRElUWjdzYm5xOXB2Z1lDcUlXQWRyL0pUSWp4T2JLaGw4VDhS?=
 =?utf-8?B?bCtIK01YNENKVGFNbmNDeWJRQXZNa1VsMWlBcGROSU44bERmdkVBQUh3NXNt?=
 =?utf-8?B?WWtISndhUGhzbW9QMVBIc0V6WkVEVTB4MitaSDlGTExJUktFYlZpb1RlV0Fs?=
 =?utf-8?B?Lys1dWJBVldrSkwyMFNFTEgrbGVmcWZRZkpNb01qcEM4aWVvZU4zeHVGM3lO?=
 =?utf-8?B?NnB5Z1FUY1NwSE1YYTIyRHJOd2MraW5kV01jRTZKTThrd3BuaGYwN2JCK0o5?=
 =?utf-8?B?d1ZpaTBNOE1wdFlzL29ZMFo4Zk5sY050Yi9xRHcrbmN6SGhHL1dVRFphVW9o?=
 =?utf-8?B?YUZUUGFsWkx0eEg5eXljNk5kckIxTHJzNnRuMjlnelVIbnAxaXpzdnBuVDRL?=
 =?utf-8?B?MHYxQmczbnVjZ1hKTTJaWlZtU3NGbXJBUDdUT0IvaGFaOHR4dXFqcDlBY0NX?=
 =?utf-8?B?YVlGdWlrSU1mQUpENTl1Q0k3VktENWxzejBrS28zN3JWaWZ4RmRodncwemVY?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33A164CF65F1F84A970FAD9BF4F7492C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2f3398-5516-456f-7346-08dbcff2568a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 15:53:14.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TswLRMiiZ5Kr5XQ5gAJodo6sxT1zuVxaUNmCS+F10ewlxAWZLvU8GfwmzcAr3xwzjeV2ZalFda6dIwdhjgHKzY+qk4723+Xn4YBJx5gVZGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
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

T24gV2VkLCAyMDIzLTEwLTE4IGF0IDEwOjQ0ICswMjAwLCBJbmdvIE1vbG5hciB3cm90ZToKPiA+
ICvCoMKgwqDCoMKgwqDCoC8qCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBJZiBhbnkgcGFnZSBpcyBh
bHJlYWR5IGluIHRoZSByaWdodCBzdGF0ZSwgYmFpbCB3aXRoIGFuCj4gPiBlcnJvcgo+ID4gK8Kg
wqDCoMKgwqDCoMKgICogYmVjYXVzZSB0aGUgY29kZSBkb2Vzbid0IGhhbmRsZWQgaXQuIFRoaXMg
aXMgbGlrZWx5Cj4gPiBiZWNhdXNlCj4gCj4gR3JhbW1hciBtaXN0YWtlIGhlcmUuCj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKiBzb21ldGhpbmcgaGFzIGdvbmUgd3JvbmcgYW5kIGlzbid0IHdvcnRo
IG9wdGltaXppbmcgZm9yLgo+ID4gK8KgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDC
oCAqIElmIGFsbCB0aGUgbWVtb3J5IHBhZ2VzIGFyZSBhbHJlYWR5IGluIHRoZSBkZXNpcmVkIHN0
YXRlCj4gPiByZXR1cm4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHN1Y2Nlc3MuCj4gCj4gTWlzc2lu
ZyBjb21tYS4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBr
ZXJuZWxfdmFkZHJfZW5jcnlwZWQoKSBkb2VzIG5vdCBzeW5jaHJvbml6ZSBhZ2FpbnN0Cj4gPiBo
dWdlIHBhZ2UKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHNwbGl0cyBzbyB0YWtlIHBnZF9sb2NrLiBB
IGNhbGxlciBkb2luZyBzdHJhbmdlIHRoaW5ncwo+ID4gY291bGQKPiAKPiBNaXNzaW5nIGNvbW1h
LgoKT2gsIHllcC4gVGhhbmtzLgo=
