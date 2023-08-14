Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50F77B1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjHNGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHNGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:42:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B837E5C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691995331; x=1723531331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gNIlKVtDuYbYws8tt/b5sE1pXZ7P3rlL7y0Bta60XLI=;
  b=jQumNUaGGdqUFEV7M/oYN/0Iu467YHntv2sCUoCT9/IkaMoXYN+BddgW
   ThCZitonwHxsM7orYBdYGDYRLrMK/OX6ASQFVCnAAaswYpqVlk5UcUBFq
   gfpxnF71qdKpeqbTI5XllrLg83I2xl4Z82o2ZFrAR3P2KExDAXQRulfII
   JEvPLGjeQwIyxNQ5YFcqZpdCQMuGMs+ZkY+5TCNMJGcgRNzU0kFpe6OqE
   DBE9HNy7+d+hUxR9E0qsCsHR/Mj5wNYr7/EWZA91g5jRSoFhQXCzxPHHW
   9n4vgjMNIImw28aodOre0sSNVZEgjCcGI/GfCgGwzRYgk1mhBGQmY+Mi3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="369444927"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="369444927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="683196196"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="683196196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2023 23:42:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 23:42:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 23:42:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 23:42:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 23:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQge6yd/2fuHwPuC8LnsI88QqsuduMLJZgVAdJflI8mZPH7Zu7REcOSC6V1nEMWf3JCKz/hxhVXJrWF3HuUlMdOKXEA/+5ERHHIL0BaeZkgzvSni+ZkyRSgTyMleHTwtTIErhAotX+3aSfdGAKTqK57pcuxEbKgsric1servuqvNjcQcK6aX+EXgd5Y+eY6cIBsCGOX4aRMBRresteuZ+AbgIefUL78fZFDLHkhHGF/ak3lylZ7R9YUAiTAv2QRJu/krCVAfcbLOepbZ4L40utA58LfaeiSsGvvcC9gwuD3MgHPzTiOq8hoqXbNF4WGKtuT55ldOv198Y8Up3yO4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNIlKVtDuYbYws8tt/b5sE1pXZ7P3rlL7y0Bta60XLI=;
 b=OPC47kC8/shEeY/l4Q21eG8aZoXrBbKvb+fy9yPQzr7VO2u/JyXIR+XMfeWW6dz1g2qRE6mrTgXCzlE88qj4yZmhUyu54rRgwUzUzdHnxvSY6u/gRZCxT4+hkQnOXYiOUTLNf8EkQ3OY2Gioj2O/OcFqzcMDEF9aeX/YfSCnqlzUdWB8WHAWpv1j8hmuGW9zgIPGhlnOQD6vDoS9PeCHLzzfDksDS37KcZjFf/TpoYiKqJ1pyQ0XwLvDdEr0ixZ0NelLeldW72bWwq33wJFV8i8FdKmsSIrSA8ApfZ9vUGYgzUMV3RZ1zdweP8XM9jm3l9yH8oN5As8DCEncRGTHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:42:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:42:06 +0000
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
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZxStsBtGoY60ZQkekYudRfTtGjK/mROWAgAIFU4CAABKfAIABB7OAgAAF/4A=
Date:   Mon, 14 Aug 2023 06:42:06 +0000
Message-ID: <b8da66c19ca98db6f836bd82e3e0ffa541f4dd90.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.026097251@linutronix.de>
         <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
         <33b628a02f190481c42a2dfd31b5ed1b2b50b37f.camel@intel.com>
         <87wmxzf1q7.ffs@tglx> <87r0o6f8lm.ffs@tglx>
In-Reply-To: <87r0o6f8lm.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY5PR11MB6439:EE_
x-ms-office365-filtering-correlation-id: 2cc1bb46-c6ad-49ea-c654-08db9c9193e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrzAbLphAZMgV2Vo66wgs4i0F0gKDsJ4kYyeGtnfLHVLlcLl66R/Vu3wPl0Nk4ZWGFV/PzaswwuQ+HlvJGe+ZEpReUPk3getNjFqtWWY4QZ1zhatW0YldF6WR4VI3IyJZ1VuCvpYNeLtqf/vfIB3/i4OOkLJBkkWKu6liBGK3g7vwXvsdvt0DdJIyBJoSSo5NrsIMzOehKxmBIDqDyetUxlSTx9RUJr54l7vUKOqECrdIKJ0NVP4aBqzflfM6t6kBjeFBviHW/hxDQRYIHtLI+Cu9znseSjxV/RCQnCVVd4VtVyG+FlZNHK1MP/gvpgitW76l8HCwYTXca0xXhCYsw7zSsgXSenFr2mApPrhlvzuVkor9327sE5n1a47SskuKX+lT6TFgSr/PnKd/75dzFTN4Eqe4Q+mSj3LsSfelED/nQxUac+MRgLaUOyfnQidijxNsvsHegjlt0LTCznT6Ewf+Cx7woq4WTjdf0r9jOsecdaMANHJfUjmgY3UcJqaEBU3ssIrlI/oYgxt9KDm6dshIg9nVu+RpG+5nZ/m6djvLvo9eurUxNOGM6bDjG+dWlQREzCddoZyp92+9xUlR86Iqp8s0JnhpohsR6a6mv+B0HhhjcGLVpHFTTHJ/GHO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(186006)(1800799006)(451199021)(6486002)(6512007)(71200400001)(86362001)(36756003)(38100700002)(38070700005)(122000001)(82960400001)(26005)(6506007)(4744005)(2906002)(478600001)(54906003)(110136005)(2616005)(41300700001)(7416002)(8676002)(66946007)(66556008)(5660300002)(8936002)(66446008)(66476007)(64756008)(76116006)(91956017)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N29tSzNyZ0xjSXpzUnhHcUVNNkpISkRZZC9NbDJSREp6NmgwdFV0YzFFcFlz?=
 =?utf-8?B?M0pjcE1nNGIzZzNGL1FDbUxBcm1JTHVQMS94NUplYUFxRGVCcjZzS1REMjVG?=
 =?utf-8?B?RURBeTZoTlUyVDZyU0xFYlFEMDZSeG1QVnBxL0JEelUvUW1pTjJ4TENuV1FN?=
 =?utf-8?B?UGFPTFJHckhDRXlBTGZKdmVEQ3Y1SG1DRlVMV1dFZWhGV3lBRDZ1Q0U3MFZ2?=
 =?utf-8?B?ZThNN2pWelI2ZGV6bjl1ZFRNMEVuWEZHOTZnZ25yOEUwQXNRWUkzYzh0SW54?=
 =?utf-8?B?djZkTU9qOE1uUi8wMWdaeUNrTHM5aTQrTHpKeXhFbHRRNWROcGsvN2ZlTUFL?=
 =?utf-8?B?cnczcXNBZmNyZjFnOWJkSk9ONStERkVxSE44TVlhNWkzRmVwcWFDckdIZ3lF?=
 =?utf-8?B?VDljbHNoK3lxMFJLaDg2Y0U2bkpqM0UwT1k5aUxKVU9abGFmOEpueThoSHhu?=
 =?utf-8?B?NytZYmc4TTNMMTNMcEZKdVZ6VFhBOTlneWxTeHBlTHZqR0hzZ3kwakFSTHhi?=
 =?utf-8?B?TENxZ1UxZGJZa0J4OHJRaFZ4bFZ6M2F5SUwwWFFlZlYyUnNyTXJsRkpCOEJW?=
 =?utf-8?B?WUsvNkdUV3BrZDlPQmg1WlVwK1F3Z2I4KzdsdWtSS0JCTUJEeXRJTzF3UnAr?=
 =?utf-8?B?WndRb1FFT25XVzZ3Q3BiVUJsNGF0ckVaV0FZV3lScWFpUm5TUWxvZDRpeXNy?=
 =?utf-8?B?OXdteW90TWF4Uy9FZnFTdngvYUtVVUd0QnQyMDVRSWRiS0VEUy8vUHJTRnFy?=
 =?utf-8?B?a1hOcThFei9KRFdzY2J2c0pXS2w4OW5uby9MWDlsR2RZckVKejlCMTVqd1Zv?=
 =?utf-8?B?Z2cxbVpmczR2bWRNRU1rbENwMXgwQzI0cEg5a2s1TEk3NUd0WTlhR0hWeXRL?=
 =?utf-8?B?VnNPN1RucGlpRStjc1JhZ2xlK2JSSHRwc3RJQ3VVczV0SDB5c0RoOVE1aU5m?=
 =?utf-8?B?d2k2Rk54WDV3RjVCcVR0SHNTS1MybEJucVVnS2U1d1VreFJ3dDRBcUpNWEp3?=
 =?utf-8?B?NWpOYUNVUXBDYmpyNUtKR1VhbDdFc1ZORlFtczBRQmdlYVFPcUZzd2taOGtW?=
 =?utf-8?B?L3BUN0pJVjhjMzcvWlZoVVpGbjJqbnlsWTBwaVYxYjNqSDdiKzEvdHZzWUQ4?=
 =?utf-8?B?a1N2Y0VTOHBtUDl6V3diUzNHRjhoQ25Ed3d5OUU3QTlWeEdwd1BNeHEzSGlE?=
 =?utf-8?B?bE5wTHAvUzI3eTI2QmZpdExUcHcvS1gwS2xHNkxLMmFJa3F1SkdoZzNzcGVN?=
 =?utf-8?B?WXUyeisrNmRiK2prY1BVVlg1R2NHV2YyYWJTdkxtZDgrYjRPSGFQYU5NZUlJ?=
 =?utf-8?B?K0JQQlNoYXM2Q0czdCtDakRzTDZuYWU5ZlYycFlFUTdIWXdpUFcvNjN6WllE?=
 =?utf-8?B?TG53T2s0ZUZVdTNqcFNaSGV5YThmSjl3QnFseHBtK1lFR2V6dUg3YXE2cDFF?=
 =?utf-8?B?cXRISEM2UFUxVG52c0NnNU5vSDVKM1BxRnlhMzR3eGVWNUpLS1JUT09aWnRy?=
 =?utf-8?B?RW1JOURUTUovNktCcEtLaHdTTDFCWFQrdjd3T1NadnAzOGtYbTl1QnpPNUla?=
 =?utf-8?B?a084MWtJeEZHQ2RzQTM5Rks3UHlUeW44QlIyYkttM1A2VHRkTkwzNE9NZHNR?=
 =?utf-8?B?K01tSnBaYktmSm1WaS9CZVdYUVJkeWdoOVQ1UmsrdkdjZ0VKT2wyZDhUSHpL?=
 =?utf-8?B?Y0tZaDJ0Z29xMkhXRVhlNTl5RXBsUGVjTllEak8vY2FudDlIWndiS3lGaWZL?=
 =?utf-8?B?ajEzREJ1VGVlM3lCNitqTld2YVRDekt6MlNjVzZBRTN2QnYvSTYrTGZZTUM5?=
 =?utf-8?B?VmJCb25OYTZrdWlWWXF4VW9FWG80VkNEM2MzUGFCQk1vL0JXK3NkcVZNQXU2?=
 =?utf-8?B?V2djSnFlRHp5eWVZTkJsbjFNcE9EUFg2eUJYNWVhVGV2SWd1VnUxMkYyL2NF?=
 =?utf-8?B?MGdxSzkvWmI2ODRxZ09ZMndnSU5CaGtZaUhCUVJnNkxaanJuZ01EendSSXpQ?=
 =?utf-8?B?aGR5VmpKSVBWdUpuRklkY3dnNnZQcDZyb2NpQWpabDl0NmFuWGI2RW1pVHcw?=
 =?utf-8?B?QzZYYmFrWmp5YVI0TFRyUlBWZWRpbks5VytSSnlta3VQbnVrbEs2WHhkN0t0?=
 =?utf-8?Q?6Ef5Om80zY/ykINKhjq9px1HZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34605C642A06EB4E8DA63429AE0A7C06@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc1bb46-c6ad-49ea-c654-08db9c9193e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:42:06.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WLsLCHcZuXzEmQ6uHpdLqdpwfMvgjmENg9ENsd6Yrkp15Rqhu09N1izpFuWsikgeVPHtidgvnFUU8v2l3lphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
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

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDA4OjIwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFN1biwgQXVnIDEzIDIwMjMgYXQgMTY6MzYsIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4gPiBPbiBTdW4sIEF1ZyAxMyAyMDIzIGF0IDEzOjMwLCBSdWkgWmhhbmcgd3JvdGU6DQo+ID4g
PiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCwgdG8gZW5zdXJlIGEgcGFja2FnZSBzY29wZSB1
bmlxdWUNCj4gPiA+ID4gY29yZV9pZCwNCj4gPiA+ID4gcmF0aGVyIHRoYW4gTW9kdWxlL1RpbGUg
c2NvcGUgdW5pcXVlLCB3aGF0IGlzIHJlYWxseSBuZWVkZWQNCj4gPiA+ID4gaGVyZSBpcw0KPiA+
ID4gPiBzb21ldGhpbmcgbGlrZSwNCj4gPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oGFwaWNpZCA+Pj0geDg2X3RvcG9fc3lzdGVtLmRvbV9zaGlmdHNbU01UXTsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGMtPnRvcG8uY29yZV9pZCA9IGFwaWNpZCAmDQo+ID4gPiA+ICh4ODZfdG9w
b19zeXN0ZW0uZG9tX3NpemVbUEFDS0FHRV0NCj4gPiA+ID4gLSAxKTsNCj4gDQo+IEFjdHVhbGx5
IGl0IG5lZWRzIHRvIGJlOg0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoCBhcGljaWQgJj0gKDFVIDw8
DQo+IHg4Nl90b3BvX3N5c3RlbS5kb21fc2hpZnRzW1RPUE9fUEtHX0RPTUFJTl0pIC0gMTsNCj4g
wqDCoMKgwqDCoMKgwqDCoCBjLT50b3BvLmNvcmVfaWQgPSBhcGljaWQgPj4NCj4geDg2X3RvcG9f
c3lzdGVtLmRvbV9zaGlmdHNbVE9QT19TTVRfRE9NQUlOXTsNCj4gDQo+IGJlY2F1c2Ugb3RoZXJ3
aXNlIHlvdSBzaGlmdCB0aGUgbG93ZXN0IHBhY2thZ2UgSUQgYml0IGludG8gdGhlDQo+IHJlc3Vs
dC4NCg0KQWdyZWVkLg0KDQp0aGFua3MsDQpydWkNCg0K
