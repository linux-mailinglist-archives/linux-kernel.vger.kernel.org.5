Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4877628C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjHIOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHIOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:32:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BC10F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691591562; x=1723127562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G7fCIuKnR+RnPaeKcqZ7vbE2KrWNMUUs8dzRzzkuXU0=;
  b=abY1np3yRpIXqz8nhbYWOdv5KECo3Obo80L2VT1k8bmAVGzvSsXLpLsW
   gIyRq3R4Ve6UgWQFF59tvsCoC7GXJuHVlYbKcdEX4e80tpiOYNokQZq2o
   xbXQCOmED4zlJ+i9KuGUCsdGZTGaeOsjY9mkuty0iaZ7bH36sbcXMTDho
   C1gVVq2I7EOnGDS5xswI50lI10Oy4trG1cd4xlBrPzKBQhtxUCKzwebdc
   1zkpZLPi9JGqQTWCk5VYNF36LlknYhwRvP4dK6BaG0rWwX7EsQ9qhZA0L
   WQQn2DPwZ6W3nW0chFag0WPPUKo908NQYky/kKTXUxkF6eLCusSFRNC2i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="437499712"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="437499712"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="766852805"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="766852805"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2023 07:32:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 07:32:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 07:32:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 07:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH1Q73qNWrXejzhr8TVO8dks2eozLryHlsUbV1jG6EC2JqhFe1kVyO1MMDFUAd/wwOy69y+umfbQqXSNCfrksoKvY9yJ6j+YJQ7hUvak9L1jnZnXR9FiZdLWs8j3JJ42WETO4V3x6kH+bo3WDulZHQzxb9t6HtDa9b3ymLE5/ISKToj1i4ZWrT9nFbb4SE4guPbnFSyfSL6XxttBKJgacVJtV97ErW4MHspfBS7JxLBXZ21ZUx8/otxl/OOM9F3V6upbPn5gVLigkEEQXjzQMq/vA3py3ACEpEwQ8cSufTbVZoJQ2wrILE5mMo98nx3i7hYZXAjTURLLpNl7ZIFoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7fCIuKnR+RnPaeKcqZ7vbE2KrWNMUUs8dzRzzkuXU0=;
 b=EpzwiXutvPKtspD9OJt5JxaVby1S+YEvCdopzyKksLpq+nIBfxu9wSCp+Hgl0l4xBcWkQFcNycYbtnVepDABHPjw3/apZ7WLqh05pEDvqgF2PvDqKuHzwivFm+YD9vVYgySO5GMIRvbO6slfOb7HgJAzSPI2lAIVKrpwdCNk5RUvRNaZBGhARToSG1BEPgTUkD2Wn6gNS8Q9piN/AWaEdsO5sgHYMm8MOeodgFkUba5fSm3P+19dLcAmns7y9ugfSifMI0HmDY0JjyXSX148zdfdd/zMF9dGFcJb/72goKc0wHQ56p5Gps4870mAPxKFuYWIVTM4vj/7WtoKF0Qhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 14:32:21 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:32:21 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 05/40] x86/cpu: Move cpu_die_id into topology info
Thread-Topic: [patch V3 05/40] x86/cpu: Move cpu_die_id into topology info
Thread-Index: AQHZxSsiEn0KBLxk30q91Edmo9ZZPK/iEkUA
Date:   Wed, 9 Aug 2023 14:32:21 +0000
Message-ID: <94b826a0d260a4edcf0242b4c4d706bce5e6d0eb.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101932.991285236@linutronix.de>
In-Reply-To: <20230802101932.991285236@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5007:EE_
x-ms-office365-filtering-correlation-id: b9ffe65b-7e38-4802-1191-08db98e57125
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lk4ziyjqGM/SzXyPj0VE8Qjhf2sUQGKOCoKCbce8FWeItYa8cLIs+anAKFFtCXj37mZ0VKp9iqlqljtspg/RZdZY1ap38CX6yH2Tv6EdzzaMBw8YMq/+2omCQ9OvajI9II/GldoRR8yZ1+4OjV1yhmxGytnNKH2iq2YWrmFOnYePG8GzEQYV3D+y7bs8NPcrnofADk1m7O7TZhT+7ulN6e3wP8jHMvSH5Xb19yU25HA77gfwYvHQyqKOZVInOJYHQtGsq/WrAqB+wzdyMH+P4MAddegvc8NKn0Vzg2i2vtyQr5Kpx6y2utcFfv0btkQVHWBEVoXRpHV9EiSnYozVS5bf2G27JpoW10d0KjFhXm50MhJqWc+OiJiXNJYzAfgVQVgQ97FbEJccjvB9gHL/UeT2VY/b9bEaKzMQd1yRSJaUm4THtTFe3yAFb0DrMjtO65lPfqqVhgDrDnf2EdIc6e52In9YAbyKuWir/KdEYl/z9fulWrHyzWqVDZnNofLss59KxMSW1hpZM2aYbH34NWkIFPxIH3mZFPdBmqyRszfyeG80CPWy4tOBXz35BSz10qvov1kR+UyjSsCHb3cqxkn+SIFX9I+0u++BJuLLQ/gMe1ka63OInPXhPWP2bex6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(1800799006)(186006)(451199021)(2616005)(26005)(36756003)(6506007)(6512007)(6486002)(71200400001)(478600001)(122000001)(38100700002)(110136005)(82960400001)(54906003)(66446008)(66476007)(76116006)(66556008)(64756008)(66946007)(91956017)(4326008)(41300700001)(316002)(8936002)(8676002)(38070700005)(5660300002)(7416002)(4744005)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UC9vVklnWU8wOEgrMzc5YVRvWHlwZUdRcXFyelZXN2xTb3IyNE0yM3FBczhX?=
 =?utf-8?B?ckhTL2lESFhFZDNENXJ6QlAzdEJISFN1VnRuVkY1aktvaHJGeWdUMWlHTTU2?=
 =?utf-8?B?aFpOemJvSEU4Qm85L0NwREpBbXQ5Y2JER0Q5QldnZG5BZDV1TzR3K1dYOWth?=
 =?utf-8?B?clVQTUpUR3FSem1xTzdtajNEcVFIQmg1RGduQUZuRW5TNmJMcHlReXZLb1Vq?=
 =?utf-8?B?QzJsaHYwMmdhdVYzWThPZUcySUpTRUk1bWVleFpnc1NSWHRwd1lUSUZGWno1?=
 =?utf-8?B?STNmbTJGSWorZlhwZS8rOUZNZk5YNWg1dmd2RHppOGtKU2VETkZjcCswMTV3?=
 =?utf-8?B?bG1VcWJkUXBFNUZ3dTQySjlZcUkxM0FLME1oQjJIMmQyLzVLZXJFOHh4VFhK?=
 =?utf-8?B?ejZCV0gwaHJLVjFoc3lnSWd2M21WUUlwaThKUnR1cndCUm4xSWNuM1JhQnI0?=
 =?utf-8?B?bmczZHM5T25xaEowVnhib2JQT3JCbjJTU0syVm91a2laa2tTUU5xZ3RZeXFQ?=
 =?utf-8?B?SWNLNHpxVnRSaEdBY00wR2xkaDJ0ay8xdi9xdmY2c3RtSGtGZjVRUlU0elho?=
 =?utf-8?B?TndRdWl1TXZhcUQxR1pUaW0zaUZSVFozUUNPVnlwaGhyRjF6RzAwaUhBbFEx?=
 =?utf-8?B?L0xmMFBoMG5PMUZBbTdPUVVKTEkyNjU5dHJkVndxRC9EQzFwdklhZkVKamcr?=
 =?utf-8?B?cWppWC9ENzBWTjZhMDFzME5BbEg5VmxUYmtXa1lRNHlOTE10MEh0Sm1Ud0lt?=
 =?utf-8?B?MEdTZkJZVnZ4dmtDM0tsY0FLa2RjVUxqamlCb3MwQkNmU3BSY0VsMDZORm82?=
 =?utf-8?B?NmowaThvV2p1YXVKRVM4ZWNaajhOTkJFcThQU0RUTytjL0pPdTRLQXpvZ0dY?=
 =?utf-8?B?anRrMUdCeHFtUllBY25aMG5KeG5lR09hSXlLUmdibmFmYmdSYmtyYTFtM3dP?=
 =?utf-8?B?cHBMSktHaFh1NGhvWWJ4RENvV3Q2UXJzWks4Vis0Q3ZzWExBUVVaV1JWU1ds?=
 =?utf-8?B?SEdUUVAzc3lEdlRyT2xtdjY4YXVYVWMxY0d2YXJ6bmFxc3I3VTZhRWVvdzc2?=
 =?utf-8?B?Sys0Nm5pMUJ0azFsTEdpTmlqcXlJRS9jWFBhSHRUcUZVNGViTjNVNW9jSnVB?=
 =?utf-8?B?K05MMDZ1YVp0TTJFSGVxazJXbVptdGhxMlcxVjNyTG5iNHV5NVNjVVh4cW1E?=
 =?utf-8?B?anFBMWVLSWRoM0RyMUdFTHdKT0lkWEYrQXJNMUJRbW9MMUxGTzZuUk9lbFJD?=
 =?utf-8?B?OHQ2elNIOWtTYktiTkhTc0Y2ckFoVWxaRlQ0NUhTclNwOHRqYllnblIwekND?=
 =?utf-8?B?MGp6aHp4SWdWZGtBbmxTVEJwY1RzU3FuVzl1NVFqa0hRNUpDRCttUytNRjJM?=
 =?utf-8?B?cGQ4T3VtenRlSEhrekpXZW5lYzBqNTNHU0ROanhreGY5alN6WFVTZlpjcjFx?=
 =?utf-8?B?V21jd3Y0UkxxdWR5VS9vekt0S3BPbGpLZ2ZIVE5rbElEYUhFejl4S2g2OGhF?=
 =?utf-8?B?OWJZSldSWkxEUmc2QjdKUVg0OXJ1V2x5Y0czODNhbEZKQng5UG1aR29RbTEz?=
 =?utf-8?B?QnpML2lza0lDWFJYMlFsdUJJMWFMeE0rcERLZG1hYkt4ZHkwc0F5Q05SQ0lX?=
 =?utf-8?B?SFBYQzRuNmtNYkhBdEJsZ3Z5YzNKM0tzWE5XOXdhdXBaUWpQTDRxN2xCYmg0?=
 =?utf-8?B?NWhLSmxBWmhvYnpRSWpHWGZBMHdFbFFIc1RWdkFUcUllc1ZPMHJ3YWVyaW5Z?=
 =?utf-8?B?MHZVRkdZNEtManhXcGJUSHZ0aVF6QlFTbkwycFV1UjRnTGxBZlBwbmgra0FS?=
 =?utf-8?B?emdiK3Jldmx2NFIvcThTZGp0NEZrUGpPMHFQMTc1RDNsRENJR2NRUjZvdVdq?=
 =?utf-8?B?eFh4dkhnYXZhMVFBaEliekhjY1ZWY0krRXBsbUdoZmR0UTJqYUFydjN4Q3U2?=
 =?utf-8?B?L1VtYzhLTHRzdzNpeEJ2U3M5Rk9GU1E0YWszOGNvbG9sNmR3REMyYVBjWTh3?=
 =?utf-8?B?WU5sSEdNNXJVaHc0dDdQbFlmczdYZ0NLdVNUZEloNy8ram5OYjltNGIzS25D?=
 =?utf-8?B?MHlwODFsUGtUWk52YktybHZnK3ppRjM3REh2RUo3c1o5MGdLUWpESGNraTlB?=
 =?utf-8?Q?+ims45sSQAD7/h0GYiQli7aRA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38907389A32D1F44AD7B5B5D4915D7A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ffe65b-7e38-4802-1191-08db98e57125
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 14:32:21.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OECIipxQZRoZ6nK/dqvW8lV2MLvokNr/+Qw+22I4cK5D3SFiX8FoPXXLAyEausVYC0ELhtpOKamZIO29CD+dVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
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

SGksIFRob21hcywNCg0KT24gV2VkLCAyMDIzLTA4LTAyIGF0IDEyOjIxICswMjAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IE1vdmUgdGhlIG5leHQgbWVtYmVyLg0KPiANCj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NCj4gLS0tDQo+IMKgRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni90b3BvbG9n
eS5yc3QgfMKgwqDCoCA0ICsrLS0NCj4gwqBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3Iu
aMKgwqDCoCB8wqDCoMKgIDQgKysrLQ0KPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5
LmjCoMKgwqDCoCB8wqDCoMKgIDIgKy0NCj4gwqBhcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA4ICsrKystLS0tDQo+IMKgYXJjaC94ODYva2VybmVs
L2NwdS9jYWNoZWluZm8uY8KgwqDCoMKgIHzCoMKgwqAgMiArLQ0KPiDCoGFyY2gveDg2L2tlcm5l
bC9jcHUvY29tbW9uLmPCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDIgKy0NCj4gwqBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L2h5Z29uLmPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgOCArKysrLS0tLQ0KPiDC
oGFyY2gveDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3kuY8KgwqDCoMKgwqAgfMKgwqDCoCAyICstDQo+
IMKgYXJjaC94ODYva2VybmVsL3NtcGJvb3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEw
ICsrKysrLS0tLS0NCj4gwqA5IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIwIGRl
bGV0aW9ucygtKQ0KPiANCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni90b3BvbG9neS5y
c3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni90b3BvbG9neS5yc3QNCj4gQEAgLTU1
LDcgKzU1LDcgQEAgQU1EIG5vbWVuY2xhdHVyZSBmb3IgcGFja2FnZSBpcyAnTm9kZScuDQo+IMKg
DQo+IMKgwqDCoMKgIFRoZSBudW1iZXIgb2YgZGllcyBpbiBhIHBhY2thZ2UuIFRoaXMgaW5mb3Jt
YXRpb24gaXMgcmV0cmlldmVkDQo+IHZpYSBDUFVJRC4NCj4gwqANCj4gLcKgIC0gY3B1aW5mb194
ODYuY3B1X2RpZV9pZDoNCj4gK8KgIC0gY3B1aW5mb194ODYudG9wb19kaWVfaWQ6DQoNCnMvdG9w
b19kaWVfaWQvdG9wby5kaWVfaWQNCg0KdGhhbmtzLA0KcnVpDQoNCg==
