Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D77790812
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjIBNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIBNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:22:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909C10D2;
        Sat,  2 Sep 2023 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693660949; x=1725196949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=irUNFa51oowUeWPrGbM5yurTcBONOCL9uwPggBCTOMs=;
  b=C4u3vsPCHJIQNA4B83MrSUm0omOjAWsPSHiFiE1wbLfVShAP3+BQpF3K
   1apo4lK7VB5yl+tz5dd5twEEuyhxKS63hhMO+JtVXw9/+fVfpY23DhOcx
   jHKOarAMAKiwD/OQM+QRkErd7cDwdVJAMU6Lx51cm1e7GfcF8ad3Ogwrn
   dJs+TIZPnmHM5Lj2T11VI8juz+DvfJjxaCnXB/dLAYzUx+3yrBAnqiGcO
   xPusdWpoR5gvKFG+EV9/S6fXDopo7KoiJbdqRvnfwhOJbba9cCC8xdA3r
   BvyGzRpPi9EK/IRjGXfJPjNC5kz/5nneF7MsPPYynW6cMuesokz+zjK4L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="407370931"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="407370931"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 06:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="717068394"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="717068394"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2023 06:22:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 2 Sep 2023 06:22:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 2 Sep 2023 06:22:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 2 Sep 2023 06:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5Byovnka/b/vnIYzSrDUW5l8ZqNTCMWvgxdQ0yLM2oqvd3ERt3JDNORHeid4QYUNuMVzvaMoQEXYP8RVbHOT927CnMfumRysm9bmGmkRdDE9n4MwLrVA2gzvQ0WvS8BqaDtWDCTllkaclI5lTpJlEu2tMSpR++JFnrD9CyfEnL0NsDZiSn+tbi/nPZlHxj//TFBX1XDDaRoB2aXxJrKPBLcAI2UyEXteRQH5DjLVb1XZkhK52EUn0WBnV1+dKBEwFBU8ERsE2Z8At9EFARJLkzEIo6qv5P6VLgO76VKbM/KDBAs4f1oRCxQfQL4P7ABTsBzMAxRcJg34ejdqWoOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irUNFa51oowUeWPrGbM5yurTcBONOCL9uwPggBCTOMs=;
 b=VyfW1htTIsYxqB8UGzLDrek1FVLW/eD1LFb5tW6EVwBO1Mae1o+Y/OEch/JSEzNZzCkI+/mVYUFtf5Ze6Q+pjRbP6n1hz/HnTgGFT84LRI6Czg5Kv0LRn2ZLdXgw3rPhdZssBJme5erdEi71hpgw9oB8dM14sEMv0aRSlYgrRaJPdKCKWTezoLwouQZPReyeW043owuVRwF7f2LTWiqdT7ym991erH9PFpB4cUnK8ulahkd0jzgQjmYUp3CtrIguv6GXCKduFaDLIvDGkB4WXJ3jIBTwjl8Mp87LhG2ZEQwY+yPIl2tAwAFpEz3mJ4hfxitGLxJzIoRBdkTO5vORGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3055.namprd11.prod.outlook.com (2603:10b6:805:dc::18)
 by BL1PR11MB5400.namprd11.prod.outlook.com (2603:10b6:208:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Sat, 2 Sep
 2023 13:22:26 +0000
Received: from SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::c89:bde5:8a9a:6eb2]) by SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::c89:bde5:8a9a:6eb2%2]) with mapi id 15.20.6745.022; Sat, 2 Sep 2023
 13:22:25 +0000
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shravan.chippa@microchip.com" <shravan.chippa@microchip.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2] media: i2c: imx334: add support for test pattern
 generator
Thread-Topic: [PATCH v2] media: i2c: imx334: add support for test pattern
 generator
Thread-Index: AQHZxuaNWsSlLbeEOk2PV8kSn2Bpz7AHszUA
Date:   Sat, 2 Sep 2023 13:22:24 +0000
Message-ID: <8104a9b8f238231a10e7ea4f7079363d88d665b5.camel@intel.com>
References: <20230804151541.3162667-1-shravan.chippa@microchip.com>
In-Reply-To: <20230804151541.3162667-1-shravan.chippa@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3055:EE_|BL1PR11MB5400:EE_
x-ms-office365-filtering-correlation-id: 413c7912-d505-4965-4f15-08dbabb7a5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXWJvpXYTvTPka2pK6mipNkkBXzeqqGzXG6HlXzW1Zh02voq3/lRwl7O4CEsQaHhEczEMjdMGgJHD3Bdf4nj6qbNjLV37vXUoEbSiF+ibtQjvwtEKvi6G4CDd6wbE+WYHiAmy0cbCipArJ/PR+tG9DXbuwAyn8TS4T4WKAVec78bSWNQLFKUoXFIhNu+o2TnZrtLJ2lty/U+AJ2NRsWAn62BukCUBvqCT0dHKFBKzhMn+efRAOcVxUdOXbD7R8cCkhDKzSBIJuYqkgUPDToqiq22oThVXcs4sMMxK8pdewoKvvpjNA81t8ljgHGxpOuV9pv20VIT3SyaeDoAWIK0iPfmG0txVnXGAoF16/VAW9QzlX7TKsEMkeUQrGRs+2swW7nMXAVrJZyne2R7c/pbqyGOOZLJYXLz8Ba2nwcCM0+CyE3kSKiqqkJoBFlAfI6Azz4JCBbKndxsWE3Ez6wIIPp6c8TJTbDouhmr39Soc8UPiwaEPGEdl4HDkyIdfNL1M5Yl/hD9FRj8bvvn/Dt9U9kOlbI0XW0xkngoGVZ0iLOatrqGjkM0rNcekOnE9OADgz0/Lpo12olycjYaD60W5H4Mk31s/cXsmzNIzsUttasQO5AkcvD4sXf7ViNiekNi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3055.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(71200400001)(6506007)(6486002)(478600001)(122000001)(82960400001)(38070700005)(38100700002)(83380400001)(2616005)(6512007)(91956017)(76116006)(110136005)(66946007)(36756003)(2906002)(66556008)(316002)(66476007)(66446008)(64756008)(54906003)(86362001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXl3dWxMNGgvL3VBUExjTHEzM0JtY2VJZjVMUG8xODlvc3NLa2w5RXdZdDZW?=
 =?utf-8?B?T3dFL0hwb0gwNWFlUW5ueFR6aXBhSlBzcjdITGNFRytvQkJkRTQvRnlKaTEx?=
 =?utf-8?B?N09uZkhYLzVNSlhqQ0w5RVBGYS9zMllVUkdDcW5PYXhBdlNMZk55RmdweEhP?=
 =?utf-8?B?cDhoUGtqVGRnbGxEM0JnRmJRS2V5eXh6YTVxRXJQZ3o4cFljY3Q3ekFXbmg2?=
 =?utf-8?B?dmM4UE1DNHlVWVZQbjdKK3ZLdzkwVlIvdkJuS08vTGhlMFNoKzJSc3A0V0NE?=
 =?utf-8?B?YVFnL0ZoNmMzSGVieDk4Z1VnQVNoSTk1MnNHeGRUaW9nallnc281b3I3bGRP?=
 =?utf-8?B?NjJJMTg3NzFTMW9odDJiWGo2UE5QOVdncnRVN0FjejFLREh5NlVyTUhQRG9N?=
 =?utf-8?B?QXVQd3pSSGFFQm4veVJSZ1JpbjhUamRXbUllYTFveU5vcU14dmFsSHluQmV0?=
 =?utf-8?B?Z1BiL1crTjdjZ0crSnZmS1Y3M2hmZk9rVGRHejl5ejJwWnJZMlVMMVZRMW12?=
 =?utf-8?B?M1JMVTVzbWg0U2lzOUNtbDVhMUdGUm40UWtxQVNoNC94bUhZQjlWT1hhUUU4?=
 =?utf-8?B?NnZCckU2V083cGpGZksvRjdaNTFyWmN6THBHV3NUbHJGZElKK2xKRDlXdU9I?=
 =?utf-8?B?SzY2RmRIczE2b0E3eS9jNFpDQVovejhsODFiY1ZEcllRbHJuRXJWZTNhZUlN?=
 =?utf-8?B?TlB3ZU1QUFVlQUxEYTNRZENXYzVLQ0M5amJsMllEcUlOdVYvRDI4S3l6Y3Z5?=
 =?utf-8?B?M3hSWUZoZVhVVjBpbFoxdWI4QTBMS2owUDF3QVlkWnVRb0ZlQzhBa0ltRlNQ?=
 =?utf-8?B?c0g2V0J2Ni92WGZON2tYS2N2NnpBVzdxTU5nS0RzK1RsTGNTSklra1QyeVJO?=
 =?utf-8?B?Slhud3J0eS9uQWxLcGJvVm5rN0pvYmZDY1RkTFJTcjUxVlBpTjlEOTFVdzRR?=
 =?utf-8?B?a3pMaXVVVElPWTBxZHhLMndQVE0zaGFNaGx5bW1VdlhaenZjZDhFaTgzY3hn?=
 =?utf-8?B?NHFTUWRqdEpWcytRSTlITkdOWlkyRkJDT2xuN1FqejNGTFFFelliM2tRRWwv?=
 =?utf-8?B?bkY3RE1RZ1QvTU5tYUIrS3N3UUtpbWVSNUdqMUVESGE2VkNxSHdNRllzQ2M5?=
 =?utf-8?B?ZUxpckpTYUlCMkp5REV3UWhCNE4vS3hLcVFkTGY5ZTlHbFRNWCs3WGk4NUw0?=
 =?utf-8?B?VVBVZExhdzlZQjFZR2lHMDU5VDFkSkEwTUVLYVBwTTg4TXZreDBJVEIyVm5h?=
 =?utf-8?B?MEJ2TER5SFVNTEdpbzYrMDBOZURkbG1CM1A3VG5nSFlCZjd3Y3pIdnpjKzZT?=
 =?utf-8?B?Vng1VzdnSDVQZWVjQUg3NEExMVY4QXMxdDlSQWpTeUE4dmxPbHhLS0dsTkNK?=
 =?utf-8?B?MTNLV1Fhem9DdVpKY05nWlViV0x5eEpqRWY1QytRTDlHeG04Yng5L3J6Ly94?=
 =?utf-8?B?blp3VFFFbll1QTR1UmdYcTVHNkFyMGdyTGVkdlJ6MmYxNlVyVXY4cklHTkl3?=
 =?utf-8?B?U25ucVAxVUJsWnczSERtanBsWVhyeTBtNUR3QUh6RUMwSEdIVGRHcnZna2I2?=
 =?utf-8?B?OXNhM2lUYndsbXU3d3VoOUZRNnkveFc5bDBaaG5Bb2k4emp0SmUvcklscnBL?=
 =?utf-8?B?NHBMVFFkVlRSeHdMWWYzR2Zsb2tLdno3TlZXZExBV2dKOUZjWWdrUUJDTUpZ?=
 =?utf-8?B?TFN2K1RBSzlxVGtXTnlRRkdJUW5jQkEyRmhud2VvQU9DSWU0UDdYMm91UmFh?=
 =?utf-8?B?YjJzeDJPVU5vSEVwaEgzcldlTDhNTDJJRmY3Y1U2WWF1OG5vaW1pU2tndTdS?=
 =?utf-8?B?MEIrdzB4RTMvZ3lOYk9QRFg1MGwxeDQyWC9MT1Y2QjhrV0ZDTGhPYUZnd3JO?=
 =?utf-8?B?eVBSR0RBQXFtcy8yNHBmekZub3lyVitSWTBnK1RoRFVHd3NKMGkycXQ2T09D?=
 =?utf-8?B?V1J4OExZUEZJN0wveFhlVkY4SUpKeWRtK2NQSEw4UTVWVGdzRHZTZ0o2ZjVB?=
 =?utf-8?B?R1k1RDY1SmZ1aGRUZE5TdDFjUlRHelFIdjF4ME5IYzRWSUJnL1VoZUw0TmlO?=
 =?utf-8?B?RDFLYUdmL3B3RTF0RllSdzRQZHVZdGlSem1EdDkvVUNTSWNnS3hpNk5RMExj?=
 =?utf-8?B?SHR6Q25sSEZUN2dRb1MwT25CUnJrekFXNEswWHEwenBlSzJLbW55N01qOGRj?=
 =?utf-8?B?ZDBRRm9PTVFNMjZkZnJkYU9yK05JamNLbDhFSUdmOTZla0JMVElQNHZHNEJ4?=
 =?utf-8?Q?dcuL5llZmhrvK4GmQqCz+0uRSZ2KwKsLdSiVkCDLFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE2AAB4BD0413469216C3B337F8543E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3055.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413c7912-d505-4965-4f15-08dbabb7a5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2023 13:22:24.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im3+YN3uZVyumLO6D5a+xxaBGkVKzC4bAtjCol0Gtsj1TTcx5oGeoaU3mKTlnzGWuaDPrpJzLVJs7ozc6WhIXeiF3vo5crAPym9wUI2sK5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5400
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

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDIwOjQ1ICswNTMwLCBzaHJhdmFuIGt1bWFyIHdyb3RlOgo+
IEZyb206IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPgo+IAo+
IEFkZCBzdXBwb3J0IGZvciB0aGUgaW14MzM0J3MgdGVzdCBwYXR0ZXJuIGdlbmVyYXRvci4KPiBC
eSBkZWZhdWx0IHRoZSB0ZXN0IHBhdHRlcm4gZ2VuZXJhdG9yIGlzIGRpc2FibGVkLCBzbyBhZGQg
c3VwcG9ydCBmb3IKPiBlbmFibGluZyBhbmQgZGlzYWJsaW5nIGhvcml6b250YWwgYW5kIHZlcnRp
Y2FsIGNvbG91ciBiYXJzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNocmF2YW4gQ2hpcHBhIDxzaHJh
dmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9tZWRpYS9pMmMvaW14
MzM0LmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkFja2VkLWJ5OiBE
YW5pZWxlIEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+Cgo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYyBiL2RyaXZlcnMvbWVk
aWEvaTJjL2lteDMzNC5jCj4gaW5kZXggZDcyMmM5YjdjZDMxLi45MWM3OWFmNzA3MzQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9pMmMvaW14MzM0LmMKPiArKysgYi9kcml2ZXJzL21lZGlh
L2kyYy9pbXgzMzQuYwo+IEBAIC01Niw2ICs1NiwyNCBAQAo+IMKgI2RlZmluZSBJTVgzMzRfUkVH
X01JTsKgwqDCoMKgwqDCoMKgwqDCoDB4MDAKPiDCoCNkZWZpbmUgSU1YMzM0X1JFR19NQVjCoMKg
wqDCoMKgwqDCoMKgwqAweGZmZmZmCj4gwqAKPiArLyogVGVzdCBQYXR0ZXJuIENvbnRyb2wgKi8K
PiArI2RlZmluZSBJTVgzMzRfUkVHX1RQwqDCoMKgwqDCoMKgwqDCoMKgwqAweDMyOWUKPiArI2Rl
ZmluZSBJTVgzMzRfVFBfQ09MT1JfSEJBUlPCoMKgMHhBCj4gKyNkZWZpbmUgSU1YMzM0X1RQX0NP
TE9SX1ZCQVJTwqDCoDB4Qgo+ICsKPiArI2RlZmluZSBJTVgzMzRfVFBHX0VOX0RPVVTCoMKgwqDC
oMKgMHgzMjljCj4gKyNkZWZpbmUgSU1YMzM0X1RQX0VOQUJMRcKgwqDCoMKgwqDCoMKgMHgxCj4g
KyNkZWZpbmUgSU1YMzM0X1RQX0RJU0FCTEXCoMKgwqDCoMKgwqAweDAKPiArCj4gKyNkZWZpbmUg
SU1YMzM0X1RQR19DT0xPUlfCoMKgwqDCoMKgwqAweDMyYTAKPiArI2RlZmluZSBJTVgzMzRfVFBH
X0NPTE9SV18xMjBQwqAweDEzCj4gKwo+ICsjZGVmaW5lIElNWDMzNF9UUF9DTEtfRU7CoMKgwqDC
oMKgwqDCoDB4MzE0OAo+ICsjZGVmaW5lIElNWDMzNF9UUF9DTEtfRU5fVkFMwqDCoMKgMHgxMAo+
ICsjZGVmaW5lIElNWDMzNF9UUF9DTEtfRElTX1ZBTMKgwqAweDAKPiArCj4gKyNkZWZpbmUgSU1Y
MzM0X0RJR19DTFBfTU9ERcKgwqDCoMKgMHgzMjgwCj4gKwo+IMKgLyoqCj4gwqAgKiBzdHJ1Y3Qg
aW14MzM0X3JlZyAtIGlteDMzNCBzZW5zb3IgcmVnaXN0ZXIKPiDCoCAqIEBhZGRyZXNzOiBSZWdp
c3RlciBhZGRyZXNzCj4gQEAgLTQzMCw2ICs0NDgsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
bXgzMzRfcmVnIG1vZGVfMzg0MHgyMTYwX3JlZ3NbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgezB4
M2EyOSwgMHgwMH0sCj4gwqB9Owo+IMKgCj4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14
MzM0X3Rlc3RfcGF0dGVybl9tZW51W10gPSB7Cj4gK8KgwqDCoMKgwqDCoMKgIkRpc2FibGVkIiwK
PiArwqDCoMKgwqDCoMKgwqAiVmVydGljYWwgQ29sb3IgQmFycyIsCj4gK8KgwqDCoMKgwqDCoMKg
Ikhvcml6b250YWwgQ29sb3IgQmFycyIsCj4gK307Cj4gKwo+ICtzdGF0aWMgY29uc3QgaW50IGlt
eDMzNF90ZXN0X3BhdHRlcm5fdmFsW10gPSB7Cj4gK8KgwqDCoMKgwqDCoMKgSU1YMzM0X1RQX0RJ
U0FCTEUsCj4gK8KgwqDCoMKgwqDCoMKgSU1YMzM0X1RQX0NPTE9SX0hCQVJTLAo+ICvCoMKgwqDC
oMKgwqDCoElNWDMzNF9UUF9DT0xPUl9WQkFSUywKPiArfTsKPiArCj4gwqBzdGF0aWMgY29uc3Qg
c3RydWN0IGlteDMzNF9yZWcgcmF3MTBfZnJhbWVmbXRfcmVnc1tdID0gewo+IMKgwqDCoMKgwqDC
oMKgwqB7MHgzMDUwLCAweDAwfSwKPiDCoMKgwqDCoMKgwqDCoMKgezB4MzE5ZCwgMHgwMH0sCj4g
QEAgLTcxNiw2ICs3NDYsMjYgQEAgc3RhdGljIGludCBpbXgzMzRfc2V0X2N0cmwoc3RydWN0IHY0
bDJfY3RybCAqY3RybCkKPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBWNEwyX0NJRF9IQkxBTks6Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAwOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBWNEwyX0NJRF9U
RVNUX1BBVFRFUk46Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjdHJsLT52
YWwpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlt
eDMzNF93cml0ZV9yZWcoaW14MzM0LCBJTVgzMzRfVFBfQ0xLX0VOLCAxLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSU1YMzM0X1RQX0NMS19FTl9WQUwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW14MzM0X3dyaXRlX3JlZyhpbXgzMzQsIElNWDMz
NF9ESUdfQ0xQX01PREUsIDEsIDB4MCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpbXgzMzRfd3JpdGVfcmVnKGlteDMzNCwgSU1YMzM0X1RQR19DT0xP
UlcsIDEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTVgzMzRfVFBHX0NPTE9SV18xMjBQKTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlteDMzNF93
cml0ZV9yZWcoaW14MzM0LCBJTVgzMzRfUkVHX1RQLCAxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW14MzM0X3Rlc3RfcGF0dGVybl92YWxbY3RybC0+dmFsXSk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbXgzMzRfd3JpdGVfcmVnKGlteDMzNCwg
SU1YMzM0X1RQR19FTl9ET1VULCAxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU1YMzM0X1RQ
X0VOQUJMRSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbXgzMzRfd3JpdGVf
cmVnKGlteDMzNCwgSU1YMzM0X0RJR19DTFBfTU9ERSwgMSwgMHgxKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlteDMzNF93cml0ZV9yZWcoaW14MzM0
LCBJTVgzMzRfVFBfQ0xLX0VOLCAxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU1YMzM0X1RQ
X0NMS19ESVNfVkFMKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlteDMzNF93cml0ZV9yZWcoaW14MzM0LCBJTVgzMzRfVFBHX0VOX0RPVVQsIDEsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTVgzMzRfVFBfRElTQUJMRSk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDC
oMKgwqDCoGRlZmF1bHQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJy
KGlteDMzNC0+ZGV2LCAiSW52YWxpZCBjb250cm9sICVkIiwgY3RybC0+aWQpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gLUVJTlZBTDsKPiBAQCAtMTIyMiw3ICsxMjcy
LDcgQEAgc3RhdGljIGludCBpbXgzMzRfaW5pdF9jb250cm9scyhzdHJ1Y3QgaW14MzM0ICppbXgz
MzQpCj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBscGZyOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0
Owo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0ID0gdjRsMl9jdHJsX2hhbmRsZXJfaW5pdChjdHJs
X2hkbHIsIDYpOwo+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHY0bDJfY3RybF9oYW5kbGVyX2luaXQo
Y3RybF9oZGxyLCA3KTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqAKPiBAQCAtMTI4Miw2ICsxMzMyLDEx
IEBAIHN0YXRpYyBpbnQgaW14MzM0X2luaXRfY29udHJvbHMoc3RydWN0IGlteDMzNCAqaW14MzM0
KQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaW14MzM0LT5oYmxhbmtfY3RybCkKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlteDMzNC0+aGJsYW5rX2N0cmwtPmZsYWdzIHw9IFY0TDJf
Q1RSTF9GTEFHX1JFQURfT05MWTsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoHY0bDJfY3RybF9uZXdf
c3RkX21lbnVfaXRlbXMoY3RybF9oZGxyLCAmaW14MzM0X2N0cmxfb3BzLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFY0TDJfQ0lEX1RFU1RfUEFUVEVSTiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUlJBWV9TSVpFKGlt
eDMzNF90ZXN0X3BhdHRlcm5fbWVudSkgLSAxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIDAsIGlteDMz
NF90ZXN0X3BhdHRlcm5fbWVudSk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoY3RybF9oZGxy
LT5lcnJvcikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihpbXgz
MzQtPmRldiwgImNvbnRyb2wgaW5pdCBmYWlsZWQ6ICVkIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdHJsX2hkbHItPmVycm9yKTsKCg==
