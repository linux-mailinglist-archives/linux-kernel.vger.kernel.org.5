Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE0779E13
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjHLIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:01:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE01FE6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691827263; x=1723363263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zm832AuhGix/QDi4mte28Gjz69xVewYyW7cIG+npK70=;
  b=cz9KOWbKO7zxG49rSn2EnAH6cs4p0UJ7E4oW3ezqUNdbvLeYdLXy5lSN
   93iqSizxZKyZg3LdeRXKFv4+x+5LI8FnRGTT7PrHIJ9Qb/9/ot7M80wfA
   szvms0CayKCnoCoNvXSNIgWv74pM0p74joAKAbeCQ5iYcXjkj3GMSA9Qx
   WrraZVbmTcj+Vnx5za5LD9HpH3kWWFZUMcJvUFORg5zItsnxn/GopbRud
   BFomWms7QFEgkXlnPXkp73UcZGaqBYfuGoJ7Y8AKGuWdkMHIYFSk2rRqe
   CDDHR1xztrHFI23SVbS2U080fCFip+kWuZoHwGSnQ3hLMy3C9vVsHkEYJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375521911"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="375521911"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 01:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682767422"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="682767422"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2023 01:01:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 01:01:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 12 Aug 2023 01:01:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 12 Aug 2023 01:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9tP4/gTdWZig2jRmeUwMilEhZrfm5TGjr+8/zP8vnNMdzXUFKFSzxAxH0OVAQDc7VWM+RmeYaCBTmcSV3RFqGdrkTZN7x07urv+uUlK/gQ+EuH1h+NUSXn2sfibKdWW8nI2Gg19J8TrsauqA+8P002AUUoO/Ai0RfjTHJUmIzO9bFcPgMjaWWk59ehW6qaxQK/l5rJsmbPFJCcyGjpFM815YcxiROUPdf0Mlw1WMQX2LQ/pQpS8XivP8WHDY7LT60a6fTUar6ouk4bS1kgjjP/jGxmO1fswSmnCUoRTBrrIOSQNG8m2lLUcKWGgJ2rD3r3I5nQlXsuVQAUvgbC1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm832AuhGix/QDi4mte28Gjz69xVewYyW7cIG+npK70=;
 b=Qz9CqrSI4PPasdS//drN5yt3lsjgOpRAPT6dlrnk8tetQ0xYJo3olNMQAPiB0TyXiqcR56Ci7Wd6DZKlgBESNHmO2QaKHpCphjN2UNposGUhOGJrIMu0OrF7r11eKpfWaC3Y2op/StvnVJ296h/CaTkq/LnZaxQlDaxF8HeFOvZsqnS/vSC7Nhu2nQ4HCXFQq2RR75obTnh/t17bVyEPTzBSff+CeEwchVQR2o2YjtD+FSQyN7eMeogezO+m5lSBWO0v0bBT5RFIFIbLbDQkjF9eOuLbdr3h49qRi8Bp/jnjlRn6gIilF4l2Clttfo2rSwgnpl8Ys9CGI4DLE0nyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB5552.namprd11.prod.outlook.com (2603:10b6:5:399::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 08:00:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Sat, 12 Aug 2023
 08:00:59 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZxStsBtGoY60ZQkekYudRfTtGjK/mROWAgAAXBIA=
Date:   Sat, 12 Aug 2023 08:00:58 +0000
Message-ID: <0331cd3b00ef6afc5f039f0343f010227ed18fa8.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.026097251@linutronix.de>
         <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
In-Reply-To: <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB5552:EE_
x-ms-office365-filtering-correlation-id: 8aa96ad7-4136-476e-0199-08db9b0a4397
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuMaF9LGvBezV6csGyfjql0XBNoOS/ubAG8s9s4SmDbO4bk9VGj3MCcHv7gLE8XEydqUKISGMlmDxOBFP4+coua+DsvZtUCkE6N+4L/HbbeYYMuUVNtrLsrp4q71PKYlYxnFOI+3JHhMydEihfN0tyXmlk7sgsKoMjnNTUksNxY5ANyIOYhHVFUwHckKjyZpQzrmx6MTStTUn08veLF+MD789DUq4lnqNkljNpf9wzVAZZcE3sLDAfWTKP50qwQ1zEV0CKglaMUQUafzc5WPh5IjNZg1BtWNwvFvCTVDotRFaXV2NkwAQKJclLcYkMHabM1w8rXyIeBjPYlXNngwrfA7z0wT5SRDSQhHJIiCwPL8Lp+D7MdM6YefVGaH0vCJ7/gP7fnpsBglgpT2qhewiQO1KWAyor3T+sTkICv9K/SFfjDp0yXHZy2yROF8r3jqamJzOer/HXhpVfm4J7cfUdUap0zcWsEHj+OBAFA9WNscL5JSxjLzOTSNYYpJ1V0NlJ0BDMHJLU0XWxwrImYhQPuCWE/ZvwUwzD9Gsix2sMBwZBnD6b4CjHivxrPkmh3QVtNYq6TkfEOy301pIwcZq4G3E/FtZzHvfI2tWs7dIu4rvTlomZBMPfALqKm5A+FR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(186006)(1800799006)(6486002)(6506007)(71200400001)(6512007)(478600001)(2616005)(26005)(2906002)(7416002)(316002)(54906003)(64756008)(41300700001)(66446008)(66556008)(110136005)(66946007)(76116006)(91956017)(66476007)(5660300002)(4326008)(8676002)(8936002)(86362001)(38100700002)(38070700005)(36756003)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9UcEFmYldVZUp3OXoyekhSUW5EVXExQkx6S0grejdFWWdsTmNNQUprNkNH?=
 =?utf-8?B?RE9SQytLWDB4SHlPOWxBUHQxMWRwSDhhaUo3NnVQUEpTYkZrQlNTdndpbGhI?=
 =?utf-8?B?NHVYbzlGRHcwUTlSbDVQczJPbngwdkJUYjQ5NTB0cnJWYmUwSFY4U0lZUGNx?=
 =?utf-8?B?RDZWbks0b0M2b2hickhWYThZakQ2d1dDcDZ5RUF3c2d5cXNWTHJyRll6dzUw?=
 =?utf-8?B?aVZGOXp5czRRNm9YeThvcksrR0xiL1dGODI0VVRCSlR2VDIzcVZ6SHBTZUdO?=
 =?utf-8?B?a3VxcDRodWt1c0kxUnVLbEpUUW5STHcwMWlqdWcwOENKUVdwa3Q4SVBsTnAz?=
 =?utf-8?B?OXhqOXl4THkxQjlEN3c0cDhWazNSZURmWG83Z2UrbG5sM1lGWWNPN1g2dm9s?=
 =?utf-8?B?bUE2c1IwZUpCb2tuSjNjempCbVp3ZHJMNUZ1c044cnN3SHRpVjJrSTNUVngx?=
 =?utf-8?B?N3lDY3RxeGlKcGpxK3BvbThzd240c3JqeUxUb080c1B1U3c0WWFmUkFkZUZH?=
 =?utf-8?B?SlRpMzlxZ3lBNFFnZHVtVC9icnRmajRwcjBSd2lxRzhkWFAvZUFpSTZ5aEtP?=
 =?utf-8?B?d21EWDBhNFkwR21ZTlI4aWxRKzRIUzd3TkJhWW1KSFZtcyttQVRFMjFOYi8v?=
 =?utf-8?B?Yy9adEx0TXcySHExcUJ4QnFhaXpVdTVVbFd2RTN5UXhsdGx0VDdoMGtRcGtl?=
 =?utf-8?B?RW40QWErcXViUjdNMlEra1U2UndJcG96QUZwQlVLZnVvbE5zZGltdjgwcDFV?=
 =?utf-8?B?bzh1bmJ6QWRjK1NIMERMMHVoSHRONkNwYS9pbkgybHBBZ0ViVWczdzFLTFlo?=
 =?utf-8?B?aUt6bDBrcnVINXVmbDBwZy9SM0pGN2NZRzNtK3JXbVNSYnkwR29XeGxOYWo5?=
 =?utf-8?B?QkRkUm81OEFuOFhWZWxmWHgrOUVVOTBBUC8ydHJ2UG1weUFUb0lxVTBnNUlD?=
 =?utf-8?B?ZzN2eFJPWVFRanVjdm5xbmpubm4rSDJucG9VdUxERkkyUUFhN2xVdWErSkxY?=
 =?utf-8?B?KzV0b3UrQVpqSkFlQ1h5VHV5VFovaUlqcUNLZUp3M2FwTmI5N0ZBQndOQVJF?=
 =?utf-8?B?UFA3TmRWTjEvRFByQW12NEVVS1JBTitiRDlTS3l0R0g5aWhmWnVzZ2NmVDdu?=
 =?utf-8?B?UGkyNlZkWk9SRHEwc2NudS9vVmZ0ajFHeE41alBGeVVkbjZNSDIwVzExQzdo?=
 =?utf-8?B?RGhEc3hKU21vZzVNNjZiMEIrc0VhNS9vVjBpZTF0eU1DZjhjZ2IxRzFlckFY?=
 =?utf-8?B?TzNyUlI4MmZTUnNKYzRkd3BVR2Zhd0dtNWk4MFNrS0NGRVBkM0Z1ZkErRGdv?=
 =?utf-8?B?NW1XeHlxcHAwMEc4T2JRUFpydnBnVHZqZDFWdG5YMjFtRUJXVkF6Y3JyQXFR?=
 =?utf-8?B?ZjExMHZlaWIydExRcHR3TWxJVWxDM0FKWTB5NTFKbjR6TWVhUlM1bnRKUjJH?=
 =?utf-8?B?aURxSTcyY0l6L3BDYnRScE9MRWhQS0thYzJISGFwYTZzRGVvSXJxL2VlNmMy?=
 =?utf-8?B?dDhIaFphaFp6N3hjRmN0UmJYNTdIa1lkeVRkV1g5dXRKNFNsUzBlK3pRQ2pr?=
 =?utf-8?B?OU9GV0xHMU41WE9RTUNqc2FmWjUyclk1cFhCa3ltVFZyN1puMU9YT2tPenp4?=
 =?utf-8?B?YlFiL29maENqU1d6NXJiYmREMkF3dmg4ZlJOY2p1TTF6bWJOVFJaSWVRa2Fz?=
 =?utf-8?B?TldLMFM0ZHl5NFovbERyUTJ1Q0M3Wk9HR0lGdkJodE41ckk0cVlxMjFmQ1lT?=
 =?utf-8?B?Ni9hTnE2OVNyZHhIYlBETEdTRm9xbWxITk9xWitSWDMyTXlUUVk5OHZVb3BN?=
 =?utf-8?B?ZTJHNWU0ZlYrSmNlWUcySGlmZWZrZzNEYitFTi84VDd0NTN2bVgyK3FTWDJ5?=
 =?utf-8?B?V1F5bGVDNEhFWVJ5UndDZjVGOURKMWRDYVZmMnNuVlUwckVOVTM4cmplTjBv?=
 =?utf-8?B?SXZ5ZmE2Z3R1aWdaLzBpaGovMmEranQ3K0JmVjl2Tjc5QzVZQWRkakRuV2RL?=
 =?utf-8?B?TVdaL2NMdGVpMDNpbGRqdWVRbk5iUFdqWS9LT1VrU1Nxc3JCZ05DYUZHck5t?=
 =?utf-8?B?ZC9rVTVpblhVSzRzdVZxQVozYmJmL2lMQzl2cE5vMko1QUpsbkliM2t1SFFk?=
 =?utf-8?B?cmI3emhZem10Qmd0bFRUSUlRN05EcVg0MUlKZGVmZHkyRUZtYlJSdVFDeHJ3?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE065AD2F874B3439D764DBC03E1B19C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa96ad7-4136-476e-0199-08db9b0a4397
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 08:00:58.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6NQrUmBHXR5sZfqrsbBug/zYk5qWaavBJnqDx+31E3GGGVJsGCubTmqPxlH5RMymV1nxUVpf8O+ysV5pkedww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5552
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

T24gU2F0LCAyMDIzLTA4LTEyIGF0IDE0OjM4ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW5saW5lIHUzMiB0b3BvX3JlbGF0aXZlX2RvbWFpbl9pZCh1MzIgYXBp
Y2lkLCBlbnVtDQo+ID4geDg2X3RvcG9sb2d5X2RvbWFpbnMgZG9tKQ0KPiA+ICt7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKGRvbSAhPSBUT1BPX1NNVF9ET01BSU4pDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGFwaWNpZCA+Pj0geDg2X3RvcG9fc3lzdGVtLmRvbV9zaGlmdHNb
ZG9tIC0gMV07DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGFwaWNpZCAmICh4ODZfdG9wb19z
eXN0ZW0uZG9tX3NpemVbZG9tXSAtIDEpOw0KPiA+ICt9DQo+IA0KPiByZWxhdGl2ZV9kb21haW5f
aWQoKSBpcyB1c2VkIHRvIGdldCBhIHVuaXF1ZSBpZCB2YWx1ZSB3aXRoaW4gaXRzIG5leHQNCj4g
aGlnaGVyIGxldmVsLg0KPiANCj4gPiArc3RhdGljIHZvaWQgdG9wb19zZXRfaWRzKHN0cnVjdCB0
b3BvX3NjYW4gKnRzY2FuKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGNwdWlu
Zm9feDg2ICpjID0gdHNjYW4tPmM7DQo+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIGFwaWNpZCA9IGMt
PnRvcG8uYXBpY2lkOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBjLT50b3BvLnBrZ19pZCA9
IHRvcG9fc2hpZnRfYXBpY2lkKGFwaWNpZCwNCj4gPiBUT1BPX1BLR19ET01BSU4pOw0KPiA+ICvC
oMKgwqDCoMKgwqDCoGMtPnRvcG8uZGllX2lkID0gdG9wb19zaGlmdF9hcGljaWQoYXBpY2lkLA0K
PiA+IFRPUE9fRElFX0RPTUFJTik7DQoNCkFuZCBkaWVfaWQgaXMgYWxzbyBwYWNrYWdlIHNjb3Bl
IHVuaXF1ZSBiZWZvcmUgdGhpcyBwYXRjaCBzZXJpZXMuDQoNCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqDCoMKgLyogUmVsYXRpdmUgY29yZSBJRCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoGMtPnRvcG8u
Y29yZV9pZCA9IHRvcG9fcmVsYXRpdmVfZG9tYWluX2lkKGFwaWNpZCwNCj4gPiBUT1BPX0NPUkVf
RE9NQUlOKTsNCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCwgdG8gZW5zdXJlIGEgcGFj
a2FnZSBzY29wZSB1bmlxdWUgY29yZV9pZCwNCj4gcmF0aGVyIHRoYW4gTW9kdWxlL1RpbGUgc2Nv
cGUgdW5pcXVlLCB3aGF0IGlzIHJlYWxseSBuZWVkZWQgaGVyZSBpcw0KPiBzb21ldGhpbmcgbGlr
ZSwNCj4gwqDCoMKgwqDCoMKgwqDCoGFwaWNpZCA+Pj0geDg2X3RvcG9fc3lzdGVtLmRvbV9zaGlm
dHNbU01UXTsNCj4gwqDCoMKgwqDCoMKgwqDCoGMtPnRvcG8uY29yZV9pZCA9IGFwaWNpZCAmICh4
ODZfdG9wb19zeXN0ZW0uZG9tX3NpemVbUEFDS0FHRV0NCj4gLSAxKTsNCj4gDQpCVFcsIGNhbiB3
ZSBjb25zaWRlciB1c2luZyBzeXN0ZW0gd2lkZSB1bmlxdWUgY29yZV9pZCBpbnN0ZWFkPw0KDQpU
aGVyZSBhcmUgYSBjb3VwbGUgb2YgYWR2YW50YWdlcyBieSB1c2luZyB0aGlzLg0KQ0MgTGVuLCB3
aG8gY2FuIHByb3ZpZGUgZGV0YWlsZWQganVzdGlmaWNhdGlvbnMgZm9yIHRoaXMuDQoNCnRoYW5r
cywNCnJ1aQ0K
