Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDB756FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGQWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:42:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710A97;
        Mon, 17 Jul 2023 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689633734; x=1721169734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t0T9FDcmibo2gKLhHGl1aXbFu08H98wllR3AqMRIsV8=;
  b=Zv1jbSG26IPWyN+Qi38UpcJyXpHKrMQvp+cqeDtb6dBIR7bCyxUGh71R
   Z9IY99PfdYQoOworvbk1BoI2QtRFUcmumIT8SJwxImbNPBzzdI86FtEV/
   ekUakr0SUyoVxipav6JGR5oCNht9Xfwi8IibMRAuSn54+7o18NGvwpmUG
   0J0KyBPHJbtVN0yPUC96HLh2NEtWNiQLMeHrBnUHwkaJLOWMGJfwkcBYv
   zFj1ScGMDSyDFFiwC/bcssBtqf+QHqNXIk7vNIEkvYsYUP2gcrSrx7+08
   wzKkcph97zxEgS7AySTPKR6TwBXxd7QmcYVqo5VyIewErsVBLnBSvDBH7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432232203"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432232203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 15:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="753077377"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="753077377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 15:42:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 15:42:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 15:42:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 15:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sas9DLRR+7+keVw5z8Api8vHrGmrUE3+JeXZrho2c/XT1fODrQLUQHpnE+WW4QroAMIT8SQlalyMG3pwE1LggI7RP7jT8C5e5GZz1UlHG9saRb/vsZKijnOXWiA+ugAYIaVTUU9RSFIvDMMynsqKQ7qKn0aBrxIcX+OyVbkKH2U71jK0Qkw2Ykg0Uqg66i6zGCHc3NVQX7Si/+rfRx6/giU0sfa6C+uRUBQ6TYKgVRyMm3oyrrOs1bWU5svKsJc1K4t3AddIRMS+zXoQ8fIy5ZinttAZmSmdz39/2UlrS2yx7ZzYiYocNPHbWkwEsv7/Kw5h+4tzOh+Rba0yAI7WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0T9FDcmibo2gKLhHGl1aXbFu08H98wllR3AqMRIsV8=;
 b=k0nrvrAk7gR6AB/8+twi6wVNxbMrSJrFhETauqi5GMLXZDZJ67vr/2MhXlLTLtNNZHiGnqrugqoF2XkgkZPrh8JCddXT+ntYaF9CKSpkPFGhY9mohXQlKXVqcyxiji4/lwVPkQD95NpWZV9q0Qgfe3pPuFS28C9iEwiBR6wqlv0YMbDsbCoc2YRfddaltNXaNTwX/gQfyx4H1iI//s2zXctdC7cdeCwqK2UJ0NSTOJh/nHDmTztvJ+ZPmhcbfNhpiVAzweuxlzUkai+xPGo4bgNYAG+tBgReow05AkRwLJfjGvnP2g4bLbim0vX2i0w9CfZ5m5zu96GHiSKNJricbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5432.namprd11.prod.outlook.com (2603:10b6:208:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 22:42:09 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 22:42:09 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Thread-Topic: [PATCH] x86/sgx: fix a NULL pointer
Thread-Index: AQHZuNr+gc+uEEAR2keHYngpqSvf+a++Tj+AgAAAPwCAABqcAIAAJQSA
Date:   Mon, 17 Jul 2023 22:42:09 +0000
Message-ID: <38deca3161bd4c5f1698fd7b6c43aa3c7b94d3da.camel@intel.com>
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
         <20230717202938.94989-1-haitao.huang@linux.intel.com>
In-Reply-To: <20230717202938.94989-1-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5432:EE_
x-ms-office365-filtering-correlation-id: 3ec898bb-b8f8-43a5-624a-08db87170e38
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZX9QdgTBWWEw/gkNihqOt3eHAvBIntG5ZOkyns+EXtwuDkCGGrEWveLlp2HVVMCH+5OMIiGXGIYDoAhlC4dlwyKl18pgoU5/k8t7amtjP7UAELJKazSeabc/bcbrhuhdnpUY9mznUCr1HGBS8fBVuDF4P+Sxx32dtTgFsGaIkElwtnfUpd8RD9C1Quxu32eyBS4tBFcsLV4gRPbw8DpiSFBsi3d119DqZ4+xQs+TvnMBGlQtZvc0FfBH4KpJQbggYbnPSqemf6oBJsCxc3YyzANm7DqAjPan443SyunHxagEbVHNk38qhpXyISuSj1EhJJAwszCGOrE6v4dd/rZyG5J5aaASPdJRiRaUsApmFctG0/W6zYE66YBfEK3CrMAyhUE/572J8UW0ljFGa0MM6sjnPGzsUR1+1Bs2KNPtP/jgBoZ9f8WRqJtzpEsp7HrMRq1fBlFWKv8QNjbfXRWTVBRz1SWb0dAmdgMrSq511igVwmzvAtqyNRrtFaYpOyWx0sw0OMrRvUEKCUFXbWQJnlC1r61bhDDV8tUHhdbC79UDXsKUvwJjCy8pizgZpicFXkym+E+yr7VngbM6XLyoUA0qK2zKWe6sTODIylpDntoZjqOIZQFKBdznFzrua+Ukrhj1V1zqgdKLlMby+FLVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(8676002)(7416002)(41300700001)(82960400001)(86362001)(5660300002)(8936002)(38100700002)(316002)(4326008)(83380400001)(2616005)(122000001)(66556008)(66476007)(66446008)(64756008)(921005)(91956017)(66946007)(76116006)(2906002)(38070700005)(36756003)(110136005)(478600001)(54906003)(6486002)(6512007)(186003)(26005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckwvY1VWa09BVVhDN3llcng4S2xoNmlZTkpsbHdvS3BGU2dNc3NkNSsrZnZv?=
 =?utf-8?B?ZjJCamZzUlBuUm5uN216ei9KQ2NwSzAvOU9ZeHpiUFZDRWljSFAybWFZV0U0?=
 =?utf-8?B?TENBYWg3K2J0K2F4dkpSb1ovak9yTXZkMlRUVlhKYzFnU0hUL0MwU3RHaFQr?=
 =?utf-8?B?d2tSVHdSaGJLVHRKTThQdDRRK3NKNmNjbGJ0Q3k0c2RZVVlJYzJEN1h1MXRI?=
 =?utf-8?B?dUNLTVh4MWZweEtmK2VlR3JIaWJvTVJaQWIzbGtpVFFEUXRsQmJVMlpMQzh5?=
 =?utf-8?B?T0FGMy8vSnl1b2xnQWMyNHhZQ0RTRWQ1S2FEZ1ZtT1B6ZDQ0TkdkVHhGSmNO?=
 =?utf-8?B?RUJKUHd4TlVxVm5ueUp1TlZoc2RvUENNLzB3UllTZzJ2emMrVHlReEF6clRE?=
 =?utf-8?B?VWt4a09JRG9tTW81QWR1am05Z0NkQVdlRlVCYWZ3WE4rTlFVSC9rUFphMkxF?=
 =?utf-8?B?Qm45aWlvaUVnWVJUa1h5ZkpIVnZ2UzVDQWZaYlJCSUpyZXJrU1JVQy9TeHA0?=
 =?utf-8?B?Qnc0WTB2ZFNGeExYS0o5VTJlWVQ5OEEvakZpcmhvelJlNXR1UUFBS1hqWTY2?=
 =?utf-8?B?MG1CcGNWMUZGZXVPaHdONHB3ZFRlL08wdSt0MDdEYlB0UFdlTmJ4dHBFUGtw?=
 =?utf-8?B?QnZPZzNMMG5GS0cwdG83STRGWW96UjF6d3MrZzNtdi8wZEM2RXBVcitwb04z?=
 =?utf-8?B?RlJaRjVUb3FtVkFmS29Na2hVSjJIT1JqcEhaM2hDQ1p0bHFXMHlNVEdFUlI5?=
 =?utf-8?B?SHpia2gvQ1QxSDdRak1kM3BiSmJQVVZSSGVKTTZtWjdBYWpzSDYyZEw3V3Y0?=
 =?utf-8?B?WFl4Q2EyWE54ZlpJVHNIY2toWm1VTERiSXRzZFNXaFgxWFl5Wkp4UUZkZ3FY?=
 =?utf-8?B?UThGNXNEdWt5UWhDdWxWQ1E4YlpnQjJCcE9HM0Q2ZnlRMndaemdvT2FGU09V?=
 =?utf-8?B?VDEySTJmYzBOOE1vbjdwSWw1V1NqbEdMc2g0UGJtZHJINDBuazV2QnFXRDJl?=
 =?utf-8?B?QzNSQTRBREtqenZ1K3BCRW5Bcmw4NEM0S3d1UTRkVTN4aUVNeVBLUXEwSjFV?=
 =?utf-8?B?bmdUbFZCSEpRZkdQelVZcDNlY3hYUm1xZVZVdUNnYS8zRUZxTWc2OXRxd3hm?=
 =?utf-8?B?K3UvTS9XTGVaL2JTY3dNcldmRG9RK3VmVnZqdG0yakJydXJGSWFEMXN4OHhu?=
 =?utf-8?B?Y2wwcWZzQUFmamQyVHREbU45ZE1CZityUGJpQ3NrVnpRQklTTUlFcW1aZTl5?=
 =?utf-8?B?bzdHazZnMm8vbVRqbHBrbVIwb3ZnNXV4ZkpmbGxRUzBpOU9yaXZwNVBxTGZV?=
 =?utf-8?B?enBBVUZoMWEzUU0wNmhIYm5kcHpncGFsV2dWY1l5bkdDYzN3Q1dSNEIxbTJM?=
 =?utf-8?B?MmhUR2lHV2NLcnRRQ0hVOVhOZ2s5Qmdna2VNMFRCUFVJcERXRm14VDVmcjZH?=
 =?utf-8?B?bmNUNFB0SFFqTEl0TXUraCt4M21MTjhESjBxNG1ubVNtL2VNSy9rTXk2UFgw?=
 =?utf-8?B?WnUydFlYeklTWklZQ3p0VlZyZ1F5SW1pRE05bks2dzhVMnFQQVZ6YkRrdFg2?=
 =?utf-8?B?TlAzVWJ5V3dPLzczdmNaeDhobVlLUmI0c3ZBcjA1Z3haWWQ3UWZHdmZYcWQ4?=
 =?utf-8?B?RkcyNlVNQ2NCa0JyRWlTcE5qM2psQ3p1RFdhNUt6bWN3VzFmV3Nla0lyNFpM?=
 =?utf-8?B?NW5IRHZUQzF1a2RxaVBQbWNla04zOFpiSmw1N3dJeHJMT2xMOU92VGJGd09B?=
 =?utf-8?B?K0JTb2ptM2pKZm1LRlVXMFZmMEVrYzQ0T3kwNEgvd3lTRlUvWEJtSEEwOTdY?=
 =?utf-8?B?YW1pYnM2U21jbzJKZzJwR1IzaWQwdnVRVXdpdzQ1VGtXMWh6ZlE2bmJ4WnhW?=
 =?utf-8?B?YmcwN0tUa0xXU0Y1S0NyM08rYTdQcStXa2M1OHVSMms5YTNSYVVxWXhLYTQv?=
 =?utf-8?B?SjF6elVMeXBvaFVRU2h1SGFUNG54N2E3WUFZL2lmNGl2Q3JWYmJoN3V2bHZR?=
 =?utf-8?B?M2Nqc0kzZldvbGZrdGtQNVhXQTJSUmhmcXNlSTdkaENaQTBuS2lFbTB5Z1Ri?=
 =?utf-8?B?VFpVZmZOMGRkbFhtbzBaaHpnaU9ZQkROcUNWTjgzTzRhUW5JMWFBRXMyT0hC?=
 =?utf-8?Q?LI3+Z/yWyHUvrlsJSKOcOI94j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C1C2B63AE69A24D8DFF0DDF1DFE7984@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec898bb-b8f8-43a5-624a-08db87170e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 22:42:09.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V/t9ETyBovULKuX1nM+SRiYiH0IkVfTU1ntHTszIpDT7yjtJRuncBV6AFPwisB8oR6SwLzOD1luy9gMTuUXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDEzOjI5IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFVuZGVyIGhlYXZ5IGxvYWQsIHRoZSBTR1ggRVBDIHJlY2xhaW1lcnMgKGN1cnJlbnQga3NneGQg
b3IgZnV0dXJlIEVQQw0KPiBjZ3JvdXAgd29ya2VyKSBtYXkgcmVjbGFpbSB0aGUgU0VDUyBFUEMg
cGFnZSBmb3IgYW4gZW5jbGF2ZSBhbmQgc2V0DQo+IGVuY2wtPnNlY3MuZXBjX3BhZ2UgdG8gTlVM
TC7CoA0KPiANCg0KQXMgYSBidWcgZml4LCBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIG1lbnRp
b24gImZ1dHVyZSBFUEMgY2dyb3VwIHdvcmtlciIuDQoNCj4gQnV0IHRoZSBTRUNTIEVQQyBwYWdl
IGlzIHVzZWQgZm9yIEVBVUcgaW4NCj4gdGhlIFNHWCAjUEYgaGFuZGxlciB3aXRob3V0IGNoZWNr
aW5nIGZvciBOVUxMIGFuZCByZWxvYWRpbmcuDQo+IA0KPiBGaXggdGhpcyBieSBjaGVja2luZyBp
ZiBTRUNTIGlzIGxvYWRlZCBiZWZvcmUgRUFVRyBhbmQgbG9hZCBpdCBpZiBpdCB3YXMNCgkJCQkJ
CQkgXg0KCQkJCQkJCSBsb2FkaW5nDQo+IHJlY2xhaW1lZC4NCj4gDQo+IEZpeGVzOiA1YTkwZDJj
M2Y1ZWY4ICgieDg2L3NneDogU3VwcG9ydCBhZGRpbmcgb2YgcGFnZXMgdG8gYW4gaW5pdGlhbGl6
ZWQgZW5jbGF2ZSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+
ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lbmNsLmMgfCAyNSArKysrKysrKysrKysrKysrKysr
Ky0tLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgfCAgNCArKysrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbC5jIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9zZ3gvZW5jbC5jDQo+IGluZGV4IDJhMGU5MGZlMmFiYy4uMmFiNTQ0ZGExNjY0IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lbmNsLmMNCj4gKysrIGIvYXJj
aC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbC5jDQo+IEBAIC0yMzUsNiArMjM1LDE2IEBAIHN0YXRp
YyBzdHJ1Y3Qgc2d4X2VwY19wYWdlICpzZ3hfZW5jbF9lbGR1KHN0cnVjdCBzZ3hfZW5jbF9wYWdl
ICplbmNsX3BhZ2UsDQo+ICAJcmV0dXJuIGVwY19wYWdlOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMg
c3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2VuY2xfbG9hZF9zZWNzKHN0cnVjdCBzZ3hfZW5jbCAq
ZW5jbCkNCj4gK3sNCj4gKwlzdHJ1Y3Qgc2d4X2VwY19wYWdlICplcGNfcGFnZSA9IGVuY2wtPnNl
Y3MuZXBjX3BhZ2U7DQo+ICsNCj4gKwlpZiAoIWVwY19wYWdlKQ0KPiArCQllcGNfcGFnZSA9IHNn
eF9lbmNsX2VsZHUoJmVuY2wtPnNlY3MsIE5VTEwpOw0KPiArDQo+ICsJcmV0dXJuIGVwY19wYWdl
Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHNneF9lbmNsX3BhZ2UgKl9fc2d4X2VuY2xf
bG9hZF9wYWdlKHN0cnVjdCBzZ3hfZW5jbCAqZW5jbCwNCj4gIAkJCQkJCSAgc3RydWN0IHNneF9l
bmNsX3BhZ2UgKmVudHJ5KQ0KPiAgew0KPiBAQCAtMjQ4LDExICsyNTgsOSBAQCBzdGF0aWMgc3Ry
dWN0IHNneF9lbmNsX3BhZ2UgKl9fc2d4X2VuY2xfbG9hZF9wYWdlKHN0cnVjdCBzZ3hfZW5jbCAq
ZW5jbCwNCj4gIAkJcmV0dXJuIGVudHJ5Ow0KPiAgCX0NCj4gIA0KPiAtCWlmICghKGVuY2wtPnNl
Y3MuZXBjX3BhZ2UpKSB7DQo+IC0JCWVwY19wYWdlID0gc2d4X2VuY2xfZWxkdSgmZW5jbC0+c2Vj
cywgTlVMTCk7DQo+IC0JCWlmIChJU19FUlIoZXBjX3BhZ2UpKQ0KPiAtCQkJcmV0dXJuIEVSUl9D
QVNUKGVwY19wYWdlKTsNCj4gLQl9DQo+ICsJZXBjX3BhZ2UgPSBzZ3hfZW5jbF9sb2FkX3NlY3Mo
ZW5jbCk7DQo+ICsJaWYgKElTX0VSUihlcGNfcGFnZSkpDQo+ICsJCXJldHVybiBFUlJfQ0FTVChl
cGNfcGFnZSk7DQo+ICANCj4gIAllcGNfcGFnZSA9IHNneF9lbmNsX2VsZHUoZW50cnksIGVuY2wt
PnNlY3MuZXBjX3BhZ2UpOw0KPiAgCWlmIChJU19FUlIoZXBjX3BhZ2UpKQ0KPiBAQCAtMzM5LDYg
KzM0NywxMyBAQCBzdGF0aWMgdm1fZmF1bHRfdCBzZ3hfZW5jbF9lYXVnX3BhZ2Uoc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEsDQo+ICANCj4gIAltdXRleF9sb2NrKCZlbmNsLT5sb2NrKTsNCj4g
IA0KPiArCWVwY19wYWdlID0gc2d4X2VuY2xfbG9hZF9zZWNzKGVuY2wpOw0KPiArCWlmIChJU19F
UlIoZXBjX3BhZ2UpKSB7DQo+ICsJCWlmIChQVFJfRVJSKGVwY19wYWdlKSA9PSAtRUJVU1kpDQo+
ICsJCQl2bXJldCA9ICBWTV9GQVVMVF9OT1BBR0U7DQo+ICsJCWdvdG8gZXJyX291dF91bmxvY2s7
DQo+ICsJfQ0KPiArDQo+ICAJZXBjX3BhZ2UgPSBzZ3hfYWxsb2NfZXBjX3BhZ2UoZW5jbF9wYWdl
LCBmYWxzZSk7DQo+ICAJaWYgKElTX0VSUihlcGNfcGFnZSkpIHsNCj4gIAkJaWYgKFBUUl9FUlIo
ZXBjX3BhZ2UpID09IC1FQlVTWSkNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L21haW4uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBpbmRleCAxNjY2
OTJmMmQ1MDEuLjQ2NjJhMzY0Y2U2MiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9zZ3gvbWFpbi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBA
QCAtMjU3LDYgKzI1NywxMCBAQCBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbWVyX3dyaXRlKHN0cnVj
dCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdlLA0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmZW5jbC0+bG9j
ayk7DQo+ICANCj4gKwkvKiBTaG91bGQgbm90IGJlIHBvc3NpYmxlICovDQo+ICsJaWYgKFdBUk5f
T04oIShlbmNsLT5zZWNzLmVwY19wYWdlKSkpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQoNClRoaXMg
c2hvdWxkbid0IGJlIGEgbWFuZGF0b3J5IHBhcnQgb2YgdGhpcyBmaXgsIG5vPw0KDQpJZiB0aGVy
ZSdzIGdvb2QgcmVhc29uIHRvIGRvLCB0aGVuIHByb2JhYmx5IHlvdSBzaG91bGQgZGVzY3JpYmUg
dGhlIHJlYXNvbiBpbg0KdGhlIGNoYW5nZWxvZy4NCg0KDQo+ICAJc2d4X2VuY2xfZXdiKGVwY19w
YWdlLCBiYWNraW5nKTsNCj4gIAllbmNsX3BhZ2UtPmVwY19wYWdlID0gTlVMTDsNCj4gIAllbmNs
LT5zZWNzX2NoaWxkX2NudC0tOw0KDQo=
