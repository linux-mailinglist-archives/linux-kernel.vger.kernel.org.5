Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785C75B9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGTV44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:56:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5622718;
        Thu, 20 Jul 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689890213; x=1721426213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4wtcUQwMTMByTqbgD6jeqUiPxGE4egSNW9xxPUbFfwk=;
  b=niswRr2eWpzc3yhHYFtoAfgcHOCBWVIaR/T0WagMHNE9ChLUba+lryYx
   ZLD2ZVZ9LtsS0VCGFxM6Dc7VVb9xh+LM/0Jo18cRIyabg3bvVxH7zBcJi
   tH/FM8kOZDNDeH1gJamHwtKLu5xXXWjupuDmn8YqripNaNGa439r+Fc3W
   fTdmvtVNQnVJGga1cBducaqq0rJCeWjldNsRMBVFgESWBWb+tPa78jGMj
   vPQY2l71f1kIUvAcsx65jD6AlSh6dokvXNrwUGF5ge0jHAJpv/5JeDFT+
   Cn0ZaUqnF8mqWhVE/p3Hqgyam2Avl4/RjhU11XKL6jIpS/2lv8FJs8MBd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364337475"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="364337475"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 14:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867999410"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2023 14:56:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 14:56:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 14:56:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 14:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0DIpZ8MGol/WWRqiWhciTrhOyderyisW3muRFPirC/G01+s6QUUHoH+mFZnGeKNwhKQlQ1nr93ymeYgwKW+xPBlUtfsG6lBWVYTn7i4aKvWgCrdcg1lQ3kO9fLW7nGrTtdPpgtuZfXqykvu9hmzgvTSMtO5fl6nBLa3H82l42ZN0uQnhj0S+X9edPrzhW2njDzFfEUdHTtx/DElmOEkLAyH7Tfq8p5RxUuMR0SU7J9bs7L4JKNbfSOUITOHCJjRQyYvisWflsWDkslYmg5encVbIx6PSf7CgpCtWbnM80QxGPt0aUzTW+G+wyoZDWf/0F0ruqJcPWk8Dp48RdmFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wtcUQwMTMByTqbgD6jeqUiPxGE4egSNW9xxPUbFfwk=;
 b=YS1DHqbvOtS4431EE788GXhl+XwAAcyxSZ66Rt9D6QKCHEzQdWaGsEsVtxSn7Wth/H93ROnznv3FmIVCuJY33aWGUNJRsneRS6mLUuzkDLinp2It4KW90lNBFZhXSClBqNBBbTmyuCioF+l6VsUnONdfASxVx8WD160cTMnzzHBXHtQnejqyDOQqQJKld6ND8qJDW78fY2vW3etGvUyuJs0cHjFD0GcZddbrkpdhCqBV6f/tHRN+6RGY22HM1PymV5uMiaak0x/h+CovZc/7rDUh1zowrDOU89xuoAmPjYG3SOPdJAQhPFhvaz5NmFQ39WCyVMESU04d12Qn3o/Mrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 21:56:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5%7]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 21:56:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZtaekZVdqWpMt9kG5/7FX5qK7u6/ABOEAgAAzyECAArsLtIAASLAQ
Date:   Thu, 20 Jul 2023 21:56:50 +0000
Message-ID: <SJ1PR11MB6083E1B292969DA2AE1FC67DFC3EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
 <ZLh9y8LQNkR/VhOq@agluck-desk3>
 <95c56b28-414d-b148-055f-b41e7da9401a@intel.com>
In-Reply-To: <95c56b28-414d-b148-055f-b41e7da9401a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ1PR11MB6297:EE_
x-ms-office365-filtering-correlation-id: 0b507c90-a96a-4e92-ace9-08db896c38d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwYUc5gbS89uw9tX7Uy4SxWIwooAjIZMYZWUv+glfRepkWJQmO17/9HptntmUIYWziQX3+YXp8lxm46Sbo88dRCvJjbaV/gqHGCmKhr8YyKl8Vf7Hr1LqsgvejsffG6lokgun7OkstmrX92iOIndZVYeBUWmvvdCuh4GBMRp7SixEGlUdiEqA3EoHMDf/5EtaUEntd2NlNAvmRNGlLOm3izxzQ9p/slw/URegTbjdoLCcjxTJjeJwvevNNajB4oMZFw73v1jPrwg3RUAHnhuu62J6EZpLv61hYTLbCTn11JwXdWcPBvrQB4XfNMoVxEoIJj6tgyCogxIIVADBwXZH+v20A6ss75qP/IXq8/uuNEGSOeH2HnyefvCMvCjrdsjakmJAESdUohIGxD09whw2U1RCNY5e7DkFQo4x+Z7D+AYf2ERhPkbogo/P40yWFoO5OUbQOu7ySyYtHc5RG2zieMgtPMutgihTKPmxwvkICwviqqS/zFMrbJwPYsbHes5vZdf3g5Lr7ezdEDFHV9hPruIdfmENZ90jkBLSQ/9FaGovn3g0b/UFbXLAKpBF0h0qlsi1yhfcqK8O7hiOvpKpPp42cPqk2AlYEFsPbMlsTM2yRGLUFHMMs5rXA6CWH8r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(6636002)(7416002)(86362001)(2906002)(38070700005)(33656002)(66899021)(55016003)(186003)(83380400001)(9686003)(6506007)(26005)(82960400001)(122000001)(7696005)(38100700002)(71200400001)(54906003)(66446008)(64756008)(66476007)(66556008)(76116006)(6862004)(66946007)(316002)(5660300002)(41300700001)(8676002)(8936002)(52536014)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVXd3NzaHh1NVVNUHdaVmRTNGo4Z1FRd0d6R096VHdZVS9pYmI1SExZOGtQ?=
 =?utf-8?B?NzZ6WjdEMnYvYlFQRW5Ld04vc0hDcDViZTl6c3ZnVU9lcjh3NHlTdVdoUVA3?=
 =?utf-8?B?RzBVeDZqbWFnL1RCb1pab0pwTXFyY1hWUHp2YnYrdnRzaDVCVElFREtkeS9Y?=
 =?utf-8?B?RUdMOCtRSzdCR2JXQlhSTmVmNjB6eW5jaWJOV3M1QjM2bnVtRGRDY3FHZUE5?=
 =?utf-8?B?UlFweXo0L29sL1UvbnlyNXdIY0RnRW4rekVnek0xVVJhTHIwMXR4N2s0alc0?=
 =?utf-8?B?YStGMGxaOTYyQW5MT0o2TW9FRm1mWXlwMVl2S05hc1EwelVaTit4WDdsWGsv?=
 =?utf-8?B?cExWamx3M3dQVk10QnJTNkk5ZVBMaVFjNWlBaTVibzBnZFdQck1na1JnZkY5?=
 =?utf-8?B?QXk4ZEZVUnhSVXlPd0ZuWnhrUDFVMGlVbnJsRjNRb2gwRjYrQlFRTFVnSEtD?=
 =?utf-8?B?SFFTVzB5NFFXcjNLaXBLSENsNWhWYjRzYmtMUWF3elJLeUU0Vm1JczJneWZy?=
 =?utf-8?B?UUtBTzl5cDZnS0FUWnJmcS9YRDFOQ3lndVBMeWtwN0FYRXFIeHZSYVc0WENK?=
 =?utf-8?B?VzZtZEtMdDFYeVNhWUhML2hNdk9ZK1NPQ2JXSktGWWQxWE5NVjRQMFhyNFN1?=
 =?utf-8?B?b3BlSGpWMlRGeXZnUkw1cU54bmlNSUZDTUJsN2FLZnBacEFKS1Z2V2d1SHpn?=
 =?utf-8?B?RWVkTEhGcCtrUWNlcW5jSGx6bzkxNEJuUEd3QTFWQWl5Z1hCZnpuYnFQbkx0?=
 =?utf-8?B?RUpDdUNpa0QrL0FBU0JKR09DVkhMUkFGbE1nNVl5UlVmY3Bud3dPN0xycVo5?=
 =?utf-8?B?cURTUFhnbnA0Smtsc2JUamJpS3Q3S0xqWnJ1ODlJTUFjQzBydzljMlRHdlQv?=
 =?utf-8?B?UjFWZlppQURieGlQRmE1TjhyTWloZnZtallMOTF3UnI4ZGtnTzJaay9zTFlL?=
 =?utf-8?B?UlVCY3lTelRZS3ZSMXkxYldMcVRMZ0lNZTdLY3MwelorcWRLZVI3VFlkNFFY?=
 =?utf-8?B?a015dDE5VDFvTDFxcXVGSnc5UHdtNVMrNEZUbStVZW1ZQ3oyZzdicGhBZlda?=
 =?utf-8?B?YW0xWXN1ZHI1R1c0OEY3SVZYeDFmQndDWnlLajd5OHJ4VDRZdGVIOXh2V09E?=
 =?utf-8?B?bG9nMWEvZDRTczlUUUZwZW15ajNZY0FpRjNjdzN0bjMrL1FrVHR3Zkw1WUh3?=
 =?utf-8?B?K3lHdEVPcFNzZ1ByQ29DQ0VjS0c3K3VYUDBIOTY4ODBYVVlGd2pvejloZGpY?=
 =?utf-8?B?dEZSZklwY3dDMGdMRFJlUk1DNXVEbVhlZUJFc1lQNXkyMXlMWThScktCWkNQ?=
 =?utf-8?B?TTJZTXJFRlBGN1RSUHdicmk1Qy9CcWUrSGZkVEltSlZ3UHZINUN4WnFtUjJq?=
 =?utf-8?B?ZlZSNHFvZHF5Ukc1eW9iVnpWWjVsanprcUk1bjZnUFBlSUkvOVl3VVNIcTRU?=
 =?utf-8?B?enFIZWx0VzZQcE9XNm5SUzI3NDBodCtSekJyazFlTzF5YW42ZGJJWXRrNURO?=
 =?utf-8?B?MDlJNWxJODd1elZUL1JSTFdxeWhRaEdOcnhHeWxxSCtkSUhPc2RLR0d2K1BF?=
 =?utf-8?B?ellQKzl5RXNWQS9Ka3paSk5qb1JPaEZuQno3Z1pYSUlPL0ZoMGJyMllrck5Z?=
 =?utf-8?B?dnQrZC9jY3MybFg5bVVaK0ZUdmJSc3pVbTJkWjA3YTZTNXB5cjA1dEJmS242?=
 =?utf-8?B?QkJJNlE0U2R5SGlpSkc1aGo2R2o2V1JBWHJyQUVGRTJ3b1owVUY4NDJsVUhy?=
 =?utf-8?B?WHB2bWpoUG1ydFNqaFBFdU0zcXJUdnBzRGpEODhWbHQyMUhYa0F2cGFPVmRk?=
 =?utf-8?B?RXlPc1Baa2FweTlteFNkNWpjVjdYSjhIeFVOaXlWTWZGWGZJUlYybk1tWUlh?=
 =?utf-8?B?QU51RXcyL0lmM0d6SXZjeTF5SDR4aGh2cFoxN3pZRWlZa1NlMVpwREpuc0Rm?=
 =?utf-8?B?MWhKMmNGcEpLeUMycHc2RmN6Q0MwalNRMXE0VE9IZ3hpZm9Jc1lLM3MzSFZo?=
 =?utf-8?B?cHU2S0Q3dEowQVFjN1RqSWg3TUZLTlUrVkNUaldpVXpIeFJxSmFCRTlPM3I5?=
 =?utf-8?B?ZzZNWktObzAxWE91MW1pM1VYeitzZGRVRDFnd21jN3RscXVEQzVDUCtCTkph?=
 =?utf-8?Q?HQ4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b507c90-a96a-4e92-ace9-08db896c38d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 21:56:50.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MB1g5JOTh5nfpJ/AdQYmBPzA1xZq64DXjqCdr4shIZ/RfU//T8pvf1Gm4+Zsa24qAZaCWqDL+7KLqWfc7zboAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6297
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

PiBUbyBkZWFsIHdpdGggdGhlc2UgY29tcGxleGl0aWVzIEkgd291bGQgbGlrZSB0byBjb25zaWRl
ciBpZiBpdCBtYXkNCj4gbWFrZSB0aGluZ3Mgc2ltcGxlciB0byBhbHdheXMgKGlycmVzcGVjdGl2
ZSBvZiBhbGxvY2F0aW9uIGFuZA0KPiBtb25pdG9yaW5nIHNjb3BlKSBtYWludGFpbiBhbGxvY2F0
aW9uIGFuZCBtb25pdG9yaW5nIGRvbWFpbiBsaXN0cy4NCj4gRWFjaCBsaXN0IG5lZWQgb25seSBj
YXJyeSBkYXRhIGFwcHJvcHJpYXRlIHRvIGl0cyB1c2UgLi4uIHRoZSBhbGxvY2F0aW9uDQo+IGxp
c3Qgb25seSBoYXMgZGF0YSByZWxldmFudCB0byBhbGxvY2F0aW9uLCB0aGUgbW9uaXRvcmluZyBs
aXN0IG9ubHkNCj4gaGFzIGRhdGEgcmVsZXZhbnQgdG8gbW9uaXRvcmluZy4gVGhpcyBpcyB0aGUg
c3RydWN0IHJkdF9kb21haW4gcmVsYXRlZA0KPiBzcGxpdCBJIG1lbnRpb25lZCBwcmV2aW91c2x5
Lg0KPg0KPiBDb2RlIGNvdWxkIGJlY29tZSBzb21ldGhpbmcgbGlrZToNCg0KcmVzY3RybF9vbmxp
bmVfY3B1KCkNCnsNCgkuLi4NCglmb3JfZWFjaF9hbGxvY19jYXBhYmxlX3JkdF9yZXNvdXJjZShy
KQ0KCQlhbGxvY19kb21haW5fYWRkX2NwdSguLi4pDQoJZm9yX2VhY2hfbW9uX2NhcGFibGVfcmR0
X3Jlc291cmNlKHIpDQoJCW1vbl9kb21haW5fYWRkX2NwdSguLi4pDQoJLi4uDQp9DQoNCj4gVGhp
cyB3b3VsZCByZWR1Y2UgY29tcGxpY2F0aW9uIGluIGRvbWFpbl9hZGRfY3B1KCkgc2luY2UgZWFj
aCBkb21haW4gbGlzdA0KPiBvbmx5IG5lZWQgdG8gY29uY2VybiBpdHNlbGYgd2l0aCBtb25pdG9y
aW5nIG9yIGFsbG9jYXRpb24uDQoNClRoaXMgZG9lcyBzZWVtIGEgd29ydGh5IHRhcmdldC4NCg0K
SSBzdGFydGVkIG9uIGEgcGF0Y2ggdG8gc28gdGhpcyAuLi4gYnV0IEknbSBub3Qgc3VyZSBJIGhh
dmUgdGhlIHN0YW1pbmEgb3IgdGhlIHRpbWUNCnRvIHNlZSBpdCB0aHJvdWdoLiANCg0KSSBzcGxp
dCBzdHJ1Y3QgcmR0X2RvbWFpbiBpbnRvIHJkdF9jdHJsX2RvbWFpbiBhbmQgcmR0X21vbl9kb21h
aW4uIEJ1dCB0aGF0DQpsZWQgdG8gYWxzbyBzcGxpdHRpbmcgdGhlIHJkdF9od19kb21haW4gc3Ry
dWN0dXJlIGludG8gdHdvLCBhbmQgdGhlbiBzcGxpdHRpbmcNCnRoZSByZXNjdHJsX3RvX2FyY2hf
ZG9tKCkgZnVuY3Rpb24sIGFuZCB0aGVuIGFub3RoZXIgYW5kIGFub3RoZXIuDQoNClRoYXQgcHJv
Y2VzcyB3aWxsIGV2ZW50dWFsbHkgY29udmVyZ2UgKHRoZXJlIGFyZSBhIGZpbml0ZSBudW1iZXIg
b2YgbGluZXMNCm9mIGNvZGUpIC4uLi4gYnV0IGl0IHdpbGwgYmUgYSBiaWcgcGF0Y2guIEkgZG9u
J3Qgc2VlIGhvdyB0byBzdGFnZSBpdCBhIHBpZWNlDQphdCBhIHRpbWUuDQoNCi1Ub255DQo=
