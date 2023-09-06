Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26187933FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjIFDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIFDOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:14:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4C199;
        Tue,  5 Sep 2023 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693970049; x=1725506049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sLoh/CbXARoHd0nwHonOB7+6MT33ITGmmYTWIMuEh1Y=;
  b=YiPsta/H3TbTtFsNBZtzvYgA9p5/Wvf7iK8ZZjW/AzoKOVPHa3/JtoDv
   Tbz0+ffyy3b8pu0XMvtdDW8X8pHK1+1IUPneVchjx/3xAX6gjGpN52vsN
   8zOXlIOq19Jz3Ovyuq1j2ydNYAJyCL/bHHtug2EoL/+CWKjboUqkKIkpx
   glfYIb2XxGONUSLuNpNSyQNfZb00LrjxHFhiP7zKFyhJvACmilmFJxNnT
   eJlLsHOk152yYscIuH083WlDiDUj8Bm6EVumxyFHfpZCPgYSeYEd1mSWi
   QX8b/I3+2qe5BrfDVrRfrGaviIdndHRUFgVfKwsg4da/muKZhdN/JbcYW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443351140"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443351140"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 20:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691149032"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="691149032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 20:14:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:14:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:14:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 20:14:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 20:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4GI8j0BERUj8zBqwH1zifTsQkEKZXYt1NdK69XBgJf9KVVoejXboLsSoyCtOw2blSDieqLl2dcTd9Q98AJ2jPDzf1YQ7U5GF6n3HWgYDuoNzU62rb94k0/v1PdYXnVfzhWypKAVZPFDaLot4Y4NtmFq3LI4qFz2qUEK/10d6eHirAF4FlGPTTFhuecf4tmQ0XOoXjeFcz+Nm4e+Bot5ObC1E+JYOFzz+pA06W0ybMHiLyLgAMv/Hz2t5jWVYqpWmX1z/Qbp0QikZVos1EBUgqP0o/Ilbpn5Krw8roIqrAjbCb9Bk2IuE5idIYQ6eMbsMFNpbKMf0XUzELbfA0GnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLoh/CbXARoHd0nwHonOB7+6MT33ITGmmYTWIMuEh1Y=;
 b=i6IfHUsHv/Sr/hyvr9DaL6zZKZC73KPdlOtGISCcrl0L0cC+/p184wkP+P9up2XPUdl+Wt6Hte+jn4gDVCKGNguGAE4jdhgGX3R9U7QTZpD/NRUXwrHVYtdzM84drKobXPL2DmByH6FcIC/47qj4DA8eP63fZjVBcw8Aa+DDddED/tzOh5pav+8m7dKp81c5vx+DuWHzA+YFM9UQ1dWI7d1aQ2y+04eAToQaup5MLFqvRGbw0BuByVZZk006kn257tpA4xdLf6UbrK3DgeuNIMYVzqnknogjrrDLFhL1kTyZsLOzzHH1a9huzb8R3gS+iFOBb8zB9e5jVYSRdCFH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 03:14:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::b077:468b:fc83:6489]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::b077:468b:fc83:6489%5]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 03:14:06 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2 09/15] powercap/intel_rapl: Cleanup Power Limits
 support
Thread-Topic: [PATCH v2 09/15] powercap/intel_rapl: Cleanup Power Limits
 support
Thread-Index: AQHZcmkRGiMQBvUl20ugv9kSVUDzmrAMnbiAgAFd1wA=
Date:   Wed, 6 Sep 2023 03:14:06 +0000
Message-ID: <ae58059aed29f2c9e1e99ad67046881e43942eaf.camel@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
         <20230419024419.324436-10-rui.zhang@intel.com> <ZPbJBanVmoMuOhMR@intel.com>
In-Reply-To: <ZPbJBanVmoMuOhMR@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO1PR11MB5009:EE_
x-ms-office365-filtering-correlation-id: 68d78a81-0291-4134-26ea-08dbae875495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NoMoGq/fjUTJq5c7+h8uOjQwYnBZvALd/I1h/VWX8gsvM5qBSF1MXYJwRzu6JYWXMAOLS7Poe1bix92jOx4GnQrGoC2oSmt4iS+vqPF0Acjqd7BdkIbeq9sWZ97dSFJPY6uLOkrUbfIGzn9xfjdn8HfDH0OHRHptIPtziXMP01Sc136bITUI4x2l1+ribsSGEpBAqhwgtjQO0E19Mnnz5729WRXtGltCUKldBpriMK1ME3S1BIweeY11wbR4RKzGS69PBZ51vtQ9fkbHJqOKH7NQ0MAqX1KIXlmjYoll/mXRnNR5dS16Yfn9a6do346RN4Y4uoKYQaGnkoJofk+3/gUNaoDZHhRYaFsDc7rePbK0InT+PWtBGqIiOZh9HS0rxUbnR+Rs/n8/a/1+dokuDpawQWpVRFTsZ8Ni7TgwU5lvJZv4vheYlqNlHWBH7gPrhupiBeLM+WwhNcqbfktnIPmIgh2TtmpYIJXPULxfp0D6VqZ5JSpS4ksGffugDZ0Z5d/heg5Onomymg3yPEQ8Qlx30heVIAEEcSTCpeSlUkQ7JNm1CLEe8YKCW6FEspqeGzVALBws2VCeu/QtFWuw60ZKQUm+V5EXXMx3mSTcVtZ5RDgwC/xtsPw4WwvtmhLS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(186009)(1800799009)(451199024)(82960400001)(122000001)(6512007)(478600001)(38070700005)(8936002)(64756008)(91956017)(76116006)(316002)(54906003)(6916009)(66556008)(66476007)(66574015)(66446008)(41300700001)(38100700002)(4326008)(66946007)(8676002)(86362001)(71200400001)(6506007)(6486002)(36756003)(26005)(5660300002)(2906002)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmtOWklwL3NQcVhVdDdTWnIrUmJEWTlVdGM5bUlaY0dybDhvUlNqZkZNS3Ny?=
 =?utf-8?B?RU02SE1VQ3paNlFIWVJadFEyNjYxR0FaWFJCRnQzcEw5b3BLdFZ1TGlxWU90?=
 =?utf-8?B?dGl0ckw3QjRqeldia2lwRXhBbzZBS0l3L0dVaGFqdjNxYUxmVUw5aDRXWnBW?=
 =?utf-8?B?L0lzYWhHZ0pxdHdMSW51WjV0Yk8wOGxENDRUbkQwQkhhajJQZU1PMmNhOGls?=
 =?utf-8?B?ZjkvZkNHRXBjRXJ5RzExNkM1bDdjYWlremhBTUY1TTNSdlgyQ2J3cTA5RFN0?=
 =?utf-8?B?cExMZThFK2JYNU1hb3ZwNEpZazkvSFBPbFpFSDJxeGhuVlp0UHk3NTNRbTFx?=
 =?utf-8?B?bjJhWTVJUk5ENlRINm9VRmJXWWJ4K0VFb2UwNjVCQTFWbkowcVh2blZXcStY?=
 =?utf-8?B?amVWRnJVSmpoL3JmR1o5allxdW9RL3lUbWpjTWlWZmlEWUJBckpjaHRaMWZF?=
 =?utf-8?B?Tm9BeW5qK2c4SVZOR2VHMVlCWXJTeGg1RFZRczc1bW1GdWhYcXpiekdkZVdn?=
 =?utf-8?B?QWFrN1dkdU9ZSkt3WHR3Yzd1dnNKMVZmNXdjRHN1ZjZSeHNLV05BaEZxK2tU?=
 =?utf-8?B?RS9JdFJoOVVhU0E1bm04ZHgveUxnMy9jL0pVMC9lOTd5MzJIbXltZUJQaUlP?=
 =?utf-8?B?eFEwKzdPT0xkSDhhS21CZ0R0MGd6K0lmUE9IMEQybUtZeWVsbklOOTlTdXFK?=
 =?utf-8?B?amc5T3N6SmVPV2ZnOG10NmJEWEpKSGVvOEVaT3ZqNUNaRnd5U1BXOGxGUk1Q?=
 =?utf-8?B?OWNsbitHZTAxQjlUaU9VUHU4Tk41eE9XSkJOekpXRWdVaHhFT3JQMVZwZmV2?=
 =?utf-8?B?T1FSVkN2a3dJY3ZyTHJLaCtFSmxiNE9MV3IzaGlNbzZKTUFJV3dUQ29uSHBY?=
 =?utf-8?B?blYvMVVjRi80M1BxVlpwK0tkbmpSQ0M5STh2VE4ycjFzNTZJeFJLZC82cGln?=
 =?utf-8?B?STliNVVYMGtPcFRLTFpDMStBNytxYm5ma3hKQlh6V09XUTMyQmN0Y3k3Z0pt?=
 =?utf-8?B?L25jODhGdGkyYnlrT0ZGU01IREhiYkNSSWZRL2JVMk5xK1BYd29CVkI0dnRS?=
 =?utf-8?B?U2RCc1kxd2pyK2FORFVqUGpnTVZOQzNnMmFnMmEyUHFNWlJKa1kwNDhQOStw?=
 =?utf-8?B?bjNlaHZDZ3lBMW1Fdk0yeUE2dEpmL3V2cVNvQ0hVV3lVb3RGSmdGdUxGelJW?=
 =?utf-8?B?d2tKdEV5RjZSR3hKTDVrRTFjdmZHRjdDUFRBQnJEOHl2QlBQNHJsRWZYeDNF?=
 =?utf-8?B?OHhiUVFhVDdSWjJ5QmRnVHB2QXRaRUpwTXd4L0lsNkQ4UVNrQ1lWbUduUVFn?=
 =?utf-8?B?dUVESnZXbGdnMmxLVmJldmoveGdLNWFsTlhsK3FtY0l6SUZpK2srb1hMVEtK?=
 =?utf-8?B?b25BQzRuaEVBZGU1VzJvTmtLdlViVllMZkd3bUtpZmZYN3dBRHR6T2J4MUdr?=
 =?utf-8?B?SXpkT0ZlWUh1cEkweklxMHU2VFcwd1dWZkZJTStBckUxTktjdzN6SXU3UlJy?=
 =?utf-8?B?WjhDR2M5TUhHOUw2WnRoK3Q3bGJXVVJMSWE0cVlHMFZ6cnZvYld6S0pPUkN6?=
 =?utf-8?B?ckZzamt5UlVNemhBRjBVNWhPTXlmTkJVZXR6V3NQYXNtVkpDeTNDVytXR3VO?=
 =?utf-8?B?bmk4RDNRL09uYnBPUG9mZHJlTnBZeEhXOEw0VlFSNExOWktDcGRYU1BPa1BC?=
 =?utf-8?B?dTVYT0xLbmo5MnVQVlBwM1ZLM29vd1BSNVRuNkdybWZrajdYUEUxMUhVWUY4?=
 =?utf-8?B?N1IwZjgweGV0SHV1SndDalhjT0xRV0xJbDgvRXBETUVlMHFrczVIZlM0M3Bz?=
 =?utf-8?B?VzVBNjlSajQvSkNqOUNIbzkyV1hpY1U1enhZM0V1RWFGWm8vTm5kNmZINGVs?=
 =?utf-8?B?U0VEWStBQ1pscnFGYlZXanptbW5GOW91eWhRbDhGL0JxMFJ0S3paRFFGMW5S?=
 =?utf-8?B?Y0VGWHRtcVJwZmdwbitmTU9GcHFjMCtpek9EeWdYekR6TGl5cUFFZkMvN00z?=
 =?utf-8?B?VWF4R04zMjZYc1dPYXBiTjIzYjhzazBGL254L2Y3bHVsRUhiVjZpdlJIbHc3?=
 =?utf-8?B?MzBHcjBaYnFUWWl4SFBMSFl6ODVyTXd1RFowcmh2Y1YzdXNJdDhJMTRsUkVF?=
 =?utf-8?Q?DU6WDH3Ay5YWYpCLH2S+h4Cpb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5C3B9EDF597F048B7FFEFBFCCB3C187@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d78a81-0291-4134-26ea-08dbae875495
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 03:14:06.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QoLvZDG0XIxFYO/c1ZtnRQhKBCzYPL0dB32K6MXsV3IHo8RwEBv4DhXtgv2dlPuY68LVqOp8S5i4dieYfsWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5009
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

SGksIFZpbGxlLA0KDQpPbiBUdWUsIDIwMjMtMDktMDUgYXQgMDk6MjEgKzAzMDAsIFZpbGxlIFN5
cmrDpGzDpCB3cm90ZToNCj4gT24gV2VkLCBBcHIgMTksIDIwMjMgYXQgMTA6NDQ6MTNBTSArMDgw
MCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+IFRoZSBzYW1lIHNldCBvZiBvcGVyYXRpb25zIGFyZSBz
aGFyZWQgYnkgZGlmZmVyZW50IFBvd2VydCBMaW1pdHMsDQo+ID4gaW5jbHVkaW5nIFBvd2VyIExp
bWl0IGdldC9zZXQsIFBvd2VyIExpbWl0IGVuYWJsZS9kaXNhYmxlLCBjbGFtcGluZw0KPiA+IGVu
YWJsZS9kaXNhYmxlLCB0aW1lIHdpbmRvdyBnZXQvc2V0LCBhbmQgbWF4IHBvd2VyIGdldC9zZXQs
IGV0Yy4NCj4gPiANCj4gPiBCdXQgdGhlIHNhbWUgb3BlcmF0aW9uIGZvciBkaWZmZXJlbnQgUG93
ZXIgTGltaXQgaGFzIGRpZmZlcmVudA0KPiA+IHByaW1pdGl2ZXMgYmVjYXVzZSB0aGV5IHVzZSBk
aWZmZXJlbnQgcmVnaXN0ZXJzL3JlZ2lzdGVyIGJpdHMuDQo+ID4gDQo+ID4gQSBsb3Qgb2YgZGly
dHkvZHVwbGljYXRlIGNvZGUgd2FzIGludHJvZHVjZWQgdG8gaGFuZGxlIHRoaXMNCj4gPiBkaWZm
ZXJlbmNlLg0KPiA+IA0KPiA+IEludHJvZHVjZSBhIHVuaXZlcnNhbCB3YXkgdG8gaXNzdWUgUG93
ZXIgTGltaXQgb3BlcmF0aW9ucy4NCj4gPiBJbnN0ZWFkIG9mIHVzaW5nIGhhcmRjb2RlZCBwcmlt
aXRpdmUgbmFtZSBkaXJlY3RseSwgdXNlIFBvd2VyIExpbWl0DQo+ID4gaWQNCj4gPiArIG9wZXJh
dGlvbiB0eXBlLCBhbmQgaGlkZSBhbGwgdGhlIFBvd2VyIExpbWl0IGRpZmZlcmVuY2UgZGV0YWls
cw0KPiA+IGluIGENCj4gPiBjZW50cmFsIHBsYWNlLCBnZXRfcGxfcHJpbSgpLiBUd28gaGVscGVy
cywgcmFwbF9yZWFkX3BsX2RhdGEoKSBhbmQNCj4gPiByYXBsX3dyaXRlX3BsX2RhdGEoKSwgYXJl
IGludHJvZHVjZWQgYXQgdGhlIHNhbWUgdGltZSB0byBzaW1wbGlmeQ0KPiA+IHRoZQ0KPiA+IGNv
ZGUgZm9yIGlzc3VpbmcgUG93ZXIgTGltaXQgb3BlcmF0aW9ucy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBX
YW5nIFdlbmR5IDx3ZW5keS53YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMv
cG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDM0MyArKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiA+IC0tLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvaW50ZWxfcmFwbC5owqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMSAtDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25z
KCspLCAxOTggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93
ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+IGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9y
YXBsX2NvbW1vbi5jDQo+ID4gaW5kZXggOGU3N2RmNDIyNTdhLi43ZjgwYzM1ZTVjODYgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IDxzbmlwPg0KPiA+IEBA
IC04MTgsNiArNzc4LDMzIEBAIHN0YXRpYyBpbnQgcmFwbF93cml0ZV9kYXRhX3JhdyhzdHJ1Y3QN
Cj4gPiByYXBsX2RvbWFpbiAqcmQsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+
ID4gwqB9DQo+ID4gwqANCj4gPiArc3RhdGljIGludCByYXBsX3JlYWRfcGxfZGF0YShzdHJ1Y3Qg
cmFwbF9kb21haW4gKnJkLCBpbnQgcGwsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gcGxfcHJpbXMgcGxfcHJpbSwgYm9v
bCB4bGF0ZSwNCj4gPiB1NjQgKmRhdGEpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBlbnVt
IHJhcGxfcHJpbWl0aXZlcyBwcmltID0gZ2V0X3BsX3ByaW0ocGwsIHBsX3ByaW0pOw0KPiA+ICsN
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWlzX3BsX3ZhbGlkKHJkLCBwbCkpDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmFwbF9yZWFkX2RhdGFfcmF3KHJkLCBwcmltLCB4bGF0ZSwgZGF0
YSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcmFwbF93cml0ZV9wbF9kYXRhKHN0
cnVjdCByYXBsX2RvbWFpbiAqcmQsIGludCBwbCwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIHBsX3ByaW1zIHBsX3By
aW0sDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBsb25nIHZhbHVlKQ0KPiA+ICt7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgZW51bSByYXBsX3ByaW1pdGl2ZXMgcHJpbSA9IGdldF9wbF9wcmltKHBsLCBwbF9w
cmltKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFpc19wbF92YWxpZChyZCwgcGwp
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4g
PiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJkLT5zdGF0ZSAmIERPTUFJTl9TVEFURV9CSU9T
X0xPQ0tFRCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCIl
czolczolcyBsb2NrZWQgYnkgQklPU1xuIiwgcmQtPnJwLT5uYW1lLA0KPiA+IHJkLT5uYW1lLCBw
bF9uYW1lc1twbF0pOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
LUVBQ0NFUzsNCj4gDQo+IFRoaXMgc2VlbXMgdG8gYmUgY2F1c2luZyBhIGxvdCBvZiBXQVJOIGxl
dmVsIGRtZXNnIHNwYW0gWzFdIGR1cmluZw0KPiBzdXNwZW5kL3Jlc3VtZSBvbiBzZXZlcmFsIG1h
Y2hpbmVzLiBJIHN1cHBvc2UgcHJldmlvdXNseSB0aGUNCj4gd2FybmluZyB3YXMgb25seSBwcmlu
dGVkIHdoZW4gdHJ5aW5nIHRvIGNoYW5nZSB0aGUgbGltaXRzIGV4cGxpY2l0bHksDQoNCkJlZm9y
ZSB0aGlzIHBhdGNoLCB3aGVuIGVuYWJsaW5nIGEgcG93ZXIgbGltaXQsIGl0IGRvZXNuJ3QgZ2l2
ZSBhDQp3YXJuaW5nIGJ1dCByZXR1cm5zIC1FQUNDRVMgZGlyZWN0bHkuDQoNCkFmdGVyIHRoaXMg
cGF0Y2gsIGl0IGdpdmVzIGEgd2FybmluZyB3aGVuIGFueSBjaGFuZ2UgaXMgbWFkZSB0byBhDQps
b2NrZWQgcG93ZXIgbGltaXQsIGFuZCB0aGlzIGluY2x1ZGVzIGVuYWJsaW5nL3NldHRpbmcgdGhl
IHBvd2VyIGxpbWl0LA0KY2hhbmdpbmcgdGhlIHRpbWUgd2luZG93LCBldGMuDQoNClNvIEkgdGhp
bmsgaW4geW91ciBjYXNlLCB0aGUgUkFQTCBQYWNrYWdlIGRvbWFpbiBpcyBlbmFibGVkIHVwb24g
cmVzdW1lDQpmb3Igc29tZSByZWFzb24sIG1heWJlIHJlcXVlc3RlZCBieSB0aGVybWFsZCwgYW5k
IHRoYXQncyB3aHkgd2Ugc2VlDQp0aGlzIG5ldyB3YXJuaW5nLg0KDQpUaGUgYmVsb3cgY2hhbmdl
IGtlZXBzIHRoZSBwcmV2aW91cyBsb2dpYywgY2FuIHlvdSBjb25maXJtIHRoaXM/DQoNCklNTywg
dGhlIG5ldyBsb2dpYyBpcyByaWdodCBiZWNhdXNlIG1ha2luZyBhbnkgY2hhbmdlIHRvIGEgDQps
b2NrZWQgcG93ZXIgbGltaXQgaXMgbWVhbmluZ2xlc3MuDQoNClNyaW5pdmFzLA0KDQpEbyB3ZSBj
aGVjayBpZiBhIGRvbWFpbi9wb3dlcl9saW1pdCBpcyBsb2NrZWQgYmVmb3JlIHdlIGVuYWJsaW5n
IGl0IGluDQp0aGVybWFsZD8NCg0KdGhhbmtzLA0KcnVpDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCmIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9y
YXBsX2NvbW1vbi5jDQppbmRleCA1YzJlNmQ1ZWVhMmEuLmY2ODE2YTkxZDAyNyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KKysrIGIvZHJpdmVycy9w
b3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQpAQCAtODkzLDcgKzg5Myw3IEBAIHN0YXRpYyBp
bnQgcmFwbF93cml0ZV9wbF9kYXRhKHN0cnVjdCByYXBsX2RvbWFpbg0KKnJkLCBpbnQgcGwsDQog
CWlmICghaXNfcGxfdmFsaWQocmQsIHBsKSkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KLQlpZiAo
cmQtPnJwbFtwbF0ubG9ja2VkKSB7DQorCWlmIChyZC0+cnBsW3BsXS5sb2NrZWQgJiYgcGxfcHJp
bSA9PSBQTF9MSU1JVCkgew0KIAkJcHJfd2FybigiJXM6JXM6JXMgbG9ja2VkIGJ5IEJJT1NcbiIs
IHJkLT5ycC0+bmFtZSwgcmQtDQo+bmFtZSwgcGxfbmFtZXNbcGxdKTsNCiAJCXJldHVybiAtRUFD
Q0VTOw0KIAl9DQoNCg0KDQoNCg0K
