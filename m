Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346B79B7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjIKWJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbjIKQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:25:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0FCC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694449530; x=1725985530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/IxlbzZiqJO7lq0BKw1ZU9ek4n1tvTc7BQ47PWTTdKk=;
  b=isM6jajrJolWoKL1iVYGl/jiZWX7/K7ZU+sgX2fJ3ENiXeXSfm0zIET1
   JRkuIemUtRctOpoyR5KoN85h+GYZIIKOpirzlAgKMPAZgkSqUANSO+j8q
   Ne4HMcE0eHglvHJeVs2aeOWLdj7dUzdVg//eJftndm8MFcxT8bGYDBVrb
   hBWELJ2dFudBRbxCqkMMzOl+evhrbtCFB2Cdm23cwVBszK/c9WkXwwKqJ
   tu19GYTmf5fRajzWQzMwVtlaInUqceRNDPNT9wPdYpke0qE1k83Qkr5Rn
   7+ZhLKHHkTg6z95GgXnn+Tqjaw0nJp9xYi2Z7aBM81Dr6J5LxOF2PmBJG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464498275"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="464498275"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778455811"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="778455811"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 09:24:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 09:24:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 09:24:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 09:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dReGmopkfbmJb8jebGyJwMzLwAYemHUhGaQ7zGBC1xSrp10llhxjK2UoEtzpmDH9R0cNZBpBF+Y0klvV9jxIALCcc5y51Ict8sEvlUPKW74loCaGl1Q5Q3Udt24kAfKYuIe6jLcR6sSINFvsgb1irPEE/tujtzDLmFLhBpDpwl/Eyqg/AyIHv+7dFO6vNyCDgX8XhVUbmXSVvoUs2r7B+awFUOUpxuyOCMib9ngSjKcCXX6sjdjxhzy29tThTRisR1+Ksd9qhLonv6ulHZ2q1ExDYdc7BUNbkc6Q3xghKbqatZTsxUa3FIJCQHGf6WnygXgdngPPTnQATW0qzFIt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IxlbzZiqJO7lq0BKw1ZU9ek4n1tvTc7BQ47PWTTdKk=;
 b=TG1OjVcEpJ+A2GCvEky4sgux6YCL4Hg+jklYQhSrpPlJfVOogrimbbdDhy7ntjBeCxqOYJGMDG21BPhiZKP5Wx5tKuh3nJaprJlMTtsmJGHTimRotozhigcU0aQgiL5lT3ApZAReTvYFN9oAeEsCFk2ksnd2o3wlb8RIJWPUoNhr9Yxx4ofHrU+TTd10OgTFnWHatz81QLzfccgtzZFAi3emn/plhKFJTqMLGEwKODThs1Sx3HMVdOtwunTJZCI2dJc/07h9C7P7YaV3R/az+PaAyDKOph/yCg6FqwII6BPtk8+Jr/sGDtneLnBDIxib/4OG5EganRy53beMexLu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 16:23:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d477:e13a:d148:b849]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d477:e13a:d148:b849%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 16:23:59 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Topic: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/pLXsAgABYUICAJ16+AIAE2BgAgABOrQA=
Date:   Mon, 11 Sep 2023 16:23:58 +0000
Message-ID: <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <20230814031432.GA574314@ziqianlu-dell>
         <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
         <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
         <20230911114218.GA334545@ziqianlu-dell>
In-Reply-To: <20230911114218.GA334545@ziqianlu-dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB8050:EE_
x-ms-office365-filtering-correlation-id: 486e7662-9109-4959-1a17-08dbb2e380c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6Bvl6C+CCpLkyMKYwxAZtSJRQ2Rpa8st9ZUwXNVHj3XxPBy3hvJOPCowh7E9nh+aohZZOVUvzcWsDZHUSqnkLM5UVjFyGqKjemmLf2JCXsTT6Nm6tbNS7IPQZ9BKJHakwvP33iV2WW79kw3914rMZRYa0PIXoqw4Jv18sBTogOtWHWvOs6EQoXpqQ3tcE/OKiPXE3VkiBp8HPuHNxZYetw9b1vG526zx8ZGaFEzDMZcVKcLxoQRcp49VEuLp0FkJ75mB3eThph6XXThdLXTCPK/ynumYZZudac+132yc+M5474wwdr6VGlIMUFSbc77ALsGJOOnUxEbV6XG+LulTF/JCRWvmReOPZqA2/hgi8PThBS8jNH95B/WX93pI8/lwK9TkAjadwYmscvLRn4usmJz4/Zv2rhmeqRsD5PoNOH4Lh+t9c5go5XRUrw2wkFfcUYecFYsSVH6kRuLO5PwKz5RFTq8UECt2STnxt5dZrx5cpnxOvDTlulbCwDpkaM8SmOZaVSuYV3WjNOAqX3FCqI2L48uhNk3g2POdCA1Ln1h1uOh5BvXkn5OM2qPrzsoqessQoSTBVhigwZLbAco8nbcPr6/5NVHpMggDTtOov0akY8vHKxm7+hIbWq6pg73
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199024)(186009)(1800799009)(53546011)(71200400001)(6506007)(6486002)(41300700001)(122000001)(36756003)(38100700002)(86362001)(82960400001)(38070700005)(107886003)(2906002)(2616005)(6512007)(83380400001)(478600001)(110136005)(91956017)(316002)(5660300002)(4326008)(8936002)(8676002)(26005)(66476007)(64756008)(54906003)(66446008)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djNDYXErcXR3Rlo0cGo3b2p5Y2NxTGwvMVFqWlVTb0srOEZzaVlWaGF6T3FD?=
 =?utf-8?B?L2NURGlYUTNUaHd2RnU2K2UrbndWNUxKMTBwa0d4M0FEYS9zSjQ0NEJEdVZN?=
 =?utf-8?B?eGZnVytUK0VWb01ZSUNqUkxRLzljZTlPbDRWM296UERESXFiek54ZllhaFR2?=
 =?utf-8?B?LzFLSUJHY3VHRkZjb0diMnNaYnRuRWRqVUlHcFlHRTJnOFJaMU14Qml6SkRo?=
 =?utf-8?B?OUMvVk5HblRlUjI3dDEveTNVVTNCbENYY28zQTVORkR5aThtdVEvaEdUWEg1?=
 =?utf-8?B?Q3Bmcmo4cmRtbUhCSXh5U3NoazU3OEFIeVRPczcvdnd0MlpseTNKTlVlb1hx?=
 =?utf-8?B?aFRubjE0cFluNmRVZ1dmZmhUajQxbDMrTjB5UXhkMXVua3NpOHBmTHBtZ3hN?=
 =?utf-8?B?RkE1bXMvRVlzTEpVZjFoekJONHkzSmRCQm91N1RST1pqV3hzT0NxRE5YLzVB?=
 =?utf-8?B?aGFyQm1OTjN2UnpBSHdwZWVaYVBHWnFIS3JEVWhzbTVqd2pWZlBReVpSTjlI?=
 =?utf-8?B?NzhtWDRkeENaekc0cXFuM1l1Q3Q3TjlqK0t0bEVEaEE4c2VtbzF5d3JVN1FZ?=
 =?utf-8?B?cmQ0dmJjb29nd0pXSEV4dWdja3d2Snhpd1QzU1ZQUTRhS0NYZTdnTE1EL01G?=
 =?utf-8?B?eHgzbEc2VEx2aUg0ZURjZVladUpoT3RqSnpSSW9wK3Y3Q0VEdHRDbkdCcnBI?=
 =?utf-8?B?SFpzVk5sSXVNd01tMndRRWdYTGdTUUozbHhvZTYyUEpUaEZmUVdHanlUdXNy?=
 =?utf-8?B?OHh6ZTZxTDUzOCs0TjFIR1FoQUg0VU9WUVhHMVZlLzVSaC90b3hNRnl4OFpk?=
 =?utf-8?B?bjV1ZWFHRWhUV1BMbmdETkJ4eXVJdk9hVlhTV0JQNUVWY2N4Q2h6NFBHS0F0?=
 =?utf-8?B?bXBUcTl5MlJFRmRGbDNDU1lXWFhadDNaUUQwbVNKclZaRjM5N3JGRVRIU2Fw?=
 =?utf-8?B?SWdzM1luaTlaQ0RBdGFDK1ZJSnozVmZlbHRWakVVaExkQlFYeW1Mc216TU9H?=
 =?utf-8?B?SCtVZnpyRUdJTlVOVjIrbFJNRXM4Nm0vV1dnUVVwdXFCZDRJV2pKUGxLaUNX?=
 =?utf-8?B?MVJWdTlHbHR1U1FONktOMGVWNUJXMmZsZkJHVkdoZ2ZkTTNPSGZQVmNkTDZy?=
 =?utf-8?B?N050SmlwL3FZalFpVG1zWHVKVzVhTFNqYmFMcGZrd0pHbE9OVkpheXYxTDlG?=
 =?utf-8?B?L3cxTjFHaFh2NXRHdlFCSFB6NEIvY0h4WEpJYVd6SWlHdm9QNHpHWXArcTNK?=
 =?utf-8?B?ZldGN05EakRLeDJpcktRc2NQNVZCWlVnaVMyS2VDbUI2RnFLYVhCTG1naVVZ?=
 =?utf-8?B?ejlkSDMxQjRhYkhuRmRZR1pRekJlQUVHS0g3N1JBZ0hvVGV3SDlyckdUOFEr?=
 =?utf-8?B?elBUYnRHWVNsRDRaUS9jbjZlNStJbnFvNlh1ZHd0bzVRWlVJV3Jtd2ZrbStp?=
 =?utf-8?B?ZnJMUnNjWDh1WFR2ZlEzQ0RDTm9nMmVNcmp2M0wwTGhkN3hWZDVuNkhpNzlB?=
 =?utf-8?B?RzY5cVlwNm1mMWtPeFB4cGFXMjZHc2VtTFRHYUpISTByemRqOUNwRWRybUx5?=
 =?utf-8?B?ZEVaUXduaGtXNUtyWm90Uy9MVit2Y2sxeGE0VnRPSENTS0VvWENQaE1aaE9I?=
 =?utf-8?B?bTZQOWxWWlR3UG1rcTR6bmpTZE9FQjg1RTRsOVo1Ni9nZzRncUtFVTVTVmp1?=
 =?utf-8?B?ZDNqVWF3NktIZXAraDMybkJNc3FuWWwvUndCSUZ3Z002Ym1Ud3JycWkwZGh5?=
 =?utf-8?B?UzRjbTd1MHA4N09kTzhoWlZWS01UTnNybmIzNnk2OTFqenU5cVdKT2cxOWxu?=
 =?utf-8?B?VmdWUEdFczhiWnR2YzhJTW52a1NlLzhRWkNBdmFob3c3ckhZU0pZcE5vZ2R2?=
 =?utf-8?B?azZvM0xIck1POVlZd1I2Rkk2b3RoaEkwRXBwTmNNTlRCa2U3QzV5SSt4ZDlj?=
 =?utf-8?B?eW84YlBvWmJkQndqZHpJbHEvTi9ZVmd1cW5JMFVUREN6V2g2cnFNc1lYZDdY?=
 =?utf-8?B?dXlTcHJQRWMyVXhROXk3STRuVlo5SFJ0QzRwN0FXMm1tVHl5UmxmN2xuZGxy?=
 =?utf-8?B?WS9aY3FXUXRLNGE0SlNSUGc0UHBqMm1ib0poUktqNEdpSFBFRFl4Y2ZINThx?=
 =?utf-8?B?RGkrd3BsOEhCdldCZjBLdlB5dWIrUjhaWDhrMEZxRDFsK09tNU96a1o0SmN2?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E3972F12CF8E74C8AA731A0172269BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e7662-9109-4959-1a17-08dbb2e380c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 16:23:59.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Hcrs828OwWLy5Q9PPO/kT4X7CmkRvaGo98oy2VYUZVaYRdd2mnQXcJKEJj6Z4cjE4eXOiwj5cBLcuQG19hyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTExIGF0IDE5OjQyICswODAwLCBBYXJvbiBMdSB3cm90ZToNCj4gSGkg
UGllcnJlLA0KPiANCj4gT24gRnJpLCBTZXAgMDgsIDIwMjMgYXQgMTE6NDM6NTBBTSArMDIwMCwg
UGllcnJlIEdvbmRvaXMgd3JvdGU6DQo+ID4gSGVsbG8gUnVpLA0KPiA+IA0KPiA+IE9uIDgvMTQv
MjMgMTA6MzAsIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjMtMDgtMTQgYXQg
MTE6MTQgKzA4MDAsIEFhcm9uIEx1IHdyb3RlOg0KPiA+ID4gPiBIaSBSdWksDQo+ID4gPiA+IA0K
PiA+ID4gPiBPbiBGcmksIEF1ZyAwNCwgMjAyMyBhdCAwNTowODo1OFBNICswODAwLCBaaGFuZyBS
dWkgd3JvdGU6DQo+ID4gPiA+ID4gUHJvYmxlbSBzdGF0ZW1lbnQNCj4gPiA+ID4gPiAtLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+ID4gPiA+IFdoZW4gdXNpbmcgY2dyb3VwIGlzb2xhdGVkIHBhcnRpdGlv
biB0byBpc29sYXRlIGNwdXMNCj4gPiA+ID4gPiBpbmNsdWRpbmcNCj4gPiA+ID4gPiBjcHUwLCBp
dA0KPiA+ID4gPiA+IGlzIG9ic2VydmVkIHRoYXQgY3B1MCBpcyB3b2tlbiB1cCBmcmVxdWVuY3Rs
eSBidXQgZG9pbmcNCj4gPiA+ID4gPiBub3RoaW5nLg0KPiA+ID4gPiA+IFRoaXMgaXMNCj4gPiA+
ID4gPiBub3QgZ29vZCBmb3IgcG93ZXIgZWZmaWNpZW5jeS4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiA8aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjAyOiBocnRpbWVyX2NhbmNlbDoN
Cj4gPiA+ID4gPiBocnRpbWVyPTB4ZmZmZjhlOGZkZjYyM2MxMA0KPiA+ID4gPiA+IDxpZGxlPi0w
wqDCoMKgwqAgWzAwMF3CoMKgIDYxNi40OTE2MDg6IGhydGltZXJfc3RhcnQ6DQo+ID4gPiA+ID4g
aHJ0aW1lcj0weGZmZmY4ZThmZGY2MjNjMTAgZnVuY3Rpb249dGlja19zY2hlZF90aW1lci8weDAN
Cj4gPiA+ID4gPiBleHBpcmVzPTYxNTk5NjAwMDAwMCBzb2Z0ZXhwaXJlcz02MTU5OTYwMDAwMDAN
Cj4gPiA+ID4gPiA8aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjE2OiByY3VfdXRp
bGl6YXRpb246wqDCoMKgwqDCoCBTdGFydA0KPiA+ID4gPiA+IGNvbnRleHQgc3dpdGNoDQo+ID4g
PiA+ID4gPGlkbGU+LTDCoMKgwqDCoCBbMDAwXcKgwqAgNjE2LjQ5MTYxODogcmN1X3V0aWxpemF0
aW9uOsKgwqDCoMKgwqAgRW5kDQo+ID4gPiA+ID4gY29udGV4dA0KPiA+ID4gPiA+IHN3aXRjaA0K
PiA+ID4gPiA+IDxpZGxlPi0wwqDCoMKgwqAgWzAwMF3CoMKgIDYxNi40OTE2Mzc6IHRpY2tfc3Rv
cDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiA+ID4gc3VjY2Vzcz0xDQo+ID4gPiA+ID4g
ZGVwZW5kZW5jeT1OT05FDQo+ID4gPiA+ID4gPGlkbGU+LTDCoMKgwqDCoCBbMDAwXcKgwqAgNjE2
LjQ5MTYzNzogaHJ0aW1lcl9jYW5jZWw6DQo+ID4gPiA+ID4gaHJ0aW1lcj0weGZmZmY4ZThmZGY2
MjNjMTANCj4gPiA+ID4gPiA8aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjM4OiBo
cnRpbWVyX3N0YXJ0Og0KPiA+ID4gPiA+IGhydGltZXI9MHhmZmZmOGU4ZmRmNjIzYzEwIGZ1bmN0
aW9uPXRpY2tfc2NoZWRfdGltZXIvMHgwDQo+ID4gPiA+ID4gZXhwaXJlcz02MTY0MjAwMDAwMDAg
c29mdGV4cGlyZXM9NjE2NDIwMDAwMDAwDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIGFib3Zl
IHBhdHRlcm4gcmVwZWF0cyBldmVyeSBvbmUgb3IgbXVsdGlwbGUgdGlja3MsDQo+ID4gPiA+ID4g
cmVzdWx0cyBpbg0KPiA+ID4gPiA+IHRvdGFsDQo+ID4gPiA+ID4gMjAwMCsgd2FrZXVwcyBvbiBj
cHUwIGluIDYwIHNlY29uZHMsIHdoZW4gcnVubmluZyB3b3JrbG9hZCBvbg0KPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+IGNwdXMgdGhhdCBhcmUgbm90IGluIHRoZSBpc29sYXRlZCBwYXJ0aXRpb24u
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUm9vdGNhdXNlDQo+ID4gPiA+ID4gLS0tLS0tLS0tDQo+
ID4gPiA+ID4gSW4gTk9IWiBtb2RlLCBhbiBhY3RpdmUgY3B1IGVpdGhlciBzZW5kcyBhbiBJUEkg
b3IgdG91Y2hlcw0KPiA+ID4gPiA+IHRoZSBpZGxlDQo+ID4gPiA+ID4gY3B1J3MgcG9sbGluZyBm
bGFnIHRvIHdha2UgaXQgdXAsIHNvIHRoYXQgdGhlIGlkbGUgY3B1IGNhbg0KPiA+ID4gPiA+IHB1
bGwNCj4gPiA+ID4gPiB0YXNrcw0KPiA+ID4gPiA+IGZyb20gdGhlIGJ1c3kgY3B1LiBUaGUgbG9n
aWMgZm9yIHNlbGVjdGluZyB0aGUgdGFyZ2V0IGNwdSBpcw0KPiA+ID4gPiA+IHRvIHVzZQ0KPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGZpcnN0IGlkbGUgY3B1IHRoYXQgcHJlc2VudHMgaW4gYm90
aCBub2h6LmlkbGVfY3B1c19tYXNrIGFuZA0KPiA+ID4gPiA+IGhvdXNla2VlcGluZ19jcHVtYXNr
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIHRoZSBhYm92ZSBzY2VuYXJpbywgd2hlbiBjcHUw
IGlzIGluIHRoZSBjZ3JvdXAgaXNvbGF0ZWQNCj4gPiA+ID4gPiBwYXJ0aXRpb24sDQo+ID4gPiA+
ID4gaXRzIHNjaGVkIGRvbWFpbiBpcyBkZXRlY2hlZCwgYnV0IGl0IGlzIHN0aWxsIGF2YWlsYWJs
ZSBpbg0KPiA+ID4gPiA+IGJvdGggb2YNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBhYm92ZSBj
cHVtYXNrcy4gQXMgYSByZXN1bHQsIGNwdTANCj4gPiA+ID4gDQo+ID4gPiA+IEkgc2F3IGluIG5v
aHpfYmFsYW5jZV9lbnRlcl9pZGxlKCksIGlmIGEgY3B1IGlzIGlzb2xhdGVkLCBpdA0KPiA+ID4g
PiB3aWxsIG5vdA0KPiA+ID4gPiBzZXQgaXRzZWxmIGluIG5vaHouaWRsZV9jcHVzX21hc2sgYW5k
IHRodXMgc2hvdWxkIG5vdCBiZSBjaG9zZW4NCj4gPiA+ID4gYXMNCj4gPiA+ID4gaWxiX2NwdS4g
SSB3b25kZXIgd2hhdCdzIHN0b3BwaW5nIHRoaXMgZnJvbSB3b3JraW5nPw0KPiA+ID4gDQo+ID4g
PiBPbmUgdGhpbmcgSSBmb3Jnb3QgdG8gbWVudGlvbiBpcyB0aGF0IHRoZSBwcm9ibGVtIGlzIGdv
bmUgaWYgd2UNCj4gPiA+IG9mZmxpbmUNCj4gPiA+IGFuZCByZS1vbmxpbmUgdGhvc2UgY3B1cy4g
SW4gdGhhdCBjYXNlLCB0aGUgaXNvbGF0ZWQgY3B1cw0KPiA+ID4gYXJlwqByZW1vdmVkDQo+ID4g
PiBmcm9tIHRoZSBub2h6LmlkbGVfY3B1c19tYXNrIGluIHNjaGVkX2NwdV9kZWFjdGl2YXRlKCkg
YW5kIGFyZQ0KPiA+ID4gbmV2ZXINCj4gPiA+IGFkZGVkIGJhY2suDQo+ID4gPiANCj4gPiA+IEF0
IHJ1bnRpbWUsIHRoZSBjcHVzIGNhbiBiZSByZW1vdmVkIGZyb20gdGhlIG5vaHouaWRsZV9jcHVz
X21hc2sNCj4gPiA+IGluDQo+ID4gPiBiZWxvdyBjYXNlIG9ubHkNCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqB0cmlnZ2VyX2xvYWRfYmFsYW5jZSgpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHVubGlrZWx5KG9uX251bGxfZG9tYWluKHJxKSB8fA0KPiA+ID4gIWNwdV9h
Y3RpdmUoY3B1X29mKHJxKSkpKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbm9oel9iYWxhbmNlcl9raWNrKHJxKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5vaHpfYmFsYW5jZV9leGl0X2lkbGUoKQ0KPiA+
ID4gDQo+ID4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaWYgYSBjcHUgaXMgaW4gbm9oei5p
ZGxlX2NwdXNfbWFzayB3aGVuDQo+ID4gPiBpdCBpcw0KPiA+ID4gaXNvbGF0ZWQsIHRoZXJlIGlz
IG5vIGNoYW5jZSB0byByZW1vdmUgaXQgZnJvbSB0aGF0IG1hc2sgbGF0ZXIsDQo+ID4gPiBzbyB0
aGUNCj4gPiA+IGNoZWNrIGluIG5vaHpfYmFsYW5jZV9lbnRlcl9pZGxlKCkgZG9lcyBub3QgaGVs
cC4NCj4gPiANCj4gPiANCj4gPiBBcyB5b3UgbWVudGlvbmVkLCBvbmNlIGEgQ1BVIGlzIGlzb2xh
dGVkLCBpdHMgcnEtPm5vaHpfdGlja19zdG9wcGVkDQo+ID4gaXMNCj4gPiBuZXZlciB1cGRhdGVk
LiBJbnN0ZWFkIG9mIGF2b2lkaW5nIGlzb2xhdGVkIENQVXMgYXQgZWFjaA0KPiA+IGZpbmRfbmV3
X2lsYigpIGNhbGwNCj4gPiBhcyB0aGlzIHBhdGNoIGRvZXMsIG1heWJlIGl0IHdvdWxkIGJlIGJl
dHRlciB0byBwZXJtYW5lbnRseSByZW1vdmUNCj4gPiB0aGVzZSBDUFVzDQo+ID4gZnJvbSBub2h6
LmlkbGVfY3B1c19tYXNrLiBUaGlzIHdvdWxkIGxvd2VyIHRoZSBudW1iZXIgb2YgY2hlY2tzDQo+
ID4gZG9uZS4NCj4gDQo+IEkgYWdyZWUuDQoNClNvdW5kcyByZWFzb25hYmxlIHRvIG1lLg0KDQo+
IA0KPiA+IFRoaXMgY291bGQgYmUgZG9uZSB3aXRoIHNvbWV0aGluZyBsaWtlOg0KPiA+IEBAIC0x
MTU3Niw2ICsxMTU4NiwyMCBAQCB2b2lkIG5vaHpfYmFsYW5jZV9lbnRlcl9pZGxlKGludCBjcHUp
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBycS0+aGFz
X2Jsb2NrZWRfbG9hZCA9IDE7DQo+ID4gK8KgwqDCoMKgwqDCoCAvKiBJZiB3ZSdyZSBhIGNvbXBs
ZXRlbHkgaXNvbGF0ZWQgQ1BVLCB3ZSBkb24ndCBwbGF5OiAqLw0KPiA+ICvCoMKgwqDCoMKgwqAg
aWYgKG9uX251bGxfZG9tYWluKHJxKSkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChjcHVtYXNrX3Rlc3RfY3B1KHJxLT5jcHUsIG5vaHouaWRsZV9jcHVzX21hc2spKQ0K
PiA+IHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3B1bWFza19jbGVhcl9jcHUocnEtPmNwdSwNCj4gPiBub2h6LmlkbGVfY3B1c19tYXNrKTsNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljX2Rl
Yygmbm9oei5ucl9jcHVzKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+
ID4gKw0KPiANCj4gDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogU2V0IG5vaHpfdGlja19zdG9wcGVkIG9u
IGlzb2xhdGVkIENQVXMgdG8gYXZvaWQNCj4gPiBrZWVwaW5nIHRoZQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB2YWx1ZSB0aGF0IHdhcyBzdG9yZWQgd2hlbg0KPiA+IHJl
YnVpbGRfc2NoZWRfZG9tYWlucygpIHdhcyBjYWxsZWQuDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJxLT5u
b2h6X3RpY2tfc3RvcHBlZCA9IDE7DQo+IA0KPiBJdCdzIG5vdCBpbW1lZGlhdGVseSBjbGVhciB0
byBtZSB3aGF0IHRoZSBhYm92ZSBjb21tZW50IGFuZCBjb2RlDQo+IG1lYW4sDQo+IG1heWJlIHRo
YXQncyBiZWNhdXNlIEkga25vdyB2ZXJ5IGxpdHRsZSBhYm91dCBzY2hlZCBkb21haW4gcmVsYXRl
ZA0KPiBjb2RlLg0KPiBPdGhlciB0aGFuIHRoaXMsIHlvdXIgY2hhbmdlIGxvb2tzIGdvb2QgdG8g
bWUuDQo+IA0KDQpJZiB3ZSBzZXQgcnEtPm5vaHpfdGlja19zdG9wcGVkwqBmb3IgdGhlIGlzb2xh
dGVkIGNwdSwgbmV4dCB0aW1lIHdoZW4gd2UNCmludm9rZSBub2h6X2JhbGFuY2VfZXhpdF9pZGxl
KCksIHdlIGNsZWFyIHJxLT5ub2h6X3RpY2tfc3RvcHBlZCBhbmQNCmRlY3JlYXNlIG5vaHoubnJf
Y3B1cyAoZm9yIHRoZSBzZWNvbmQgdGltZSkuIFRoaXMgc2VlbXMgbGlrZSBhIHByb2JsZW0uDQoN
CkluIHRoZSBjdXJyZW50IGNvZGUswqB3aGVuIHJxLT5ub2h6X3RpY2tfc3RvcHBlZCBpcyBzZXQs
IGl0IG1lYW5zIHRoZQ0KY3B1IGlzIGluIHRoZSBub2h6LmlkbGVfY3B1c19tYXNrLCBhbmQgdGhl
IGNvZGUgYWJvdmUgYnJlYWtzIHRoaXMNCmFzc3VtcHRpb24uDQoNCj4gDQo+ID4gK8KgwqDCoMKg
wqDCoCB9DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBUaGUgdGljayBpcyBzdGlsbCBzdG9wcGVkIGJ1dCBsb2FkIGNvdWxkIGhhdmUgYmVl
bg0KPiA+IGFkZGVkIGluIHRoZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIG1lYW50aW1lLiBX
ZSBzZXQgdGhlIG5vaHouaGFzX2Jsb2NrZWQgZmxhZyB0byB0cmlnIGENCj4gPiBjaGVjayBvZiB0
aGUNCj4gPiBAQCAtMTE1ODUsMTAgKzExNjA5LDYgQEAgdm9pZCBub2h6X2JhbGFuY2VfZW50ZXJf
aWRsZShpbnQgY3B1KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJxLT5ub2h6X3RpY2tfc3Rv
cHBlZCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4g
PiAtwqDCoMKgwqDCoMKgIC8qIElmIHdlJ3JlIGEgY29tcGxldGVseSBpc29sYXRlZCBDUFUsIHdl
IGRvbid0IHBsYXk6ICovDQo+ID4gLcKgwqDCoMKgwqDCoCBpZiAob25fbnVsbF9kb21haW4ocnEp
KQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiAtDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCBycS0+bm9oel90aWNrX3N0b3BwZWQgPSAxOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqAgY3B1bWFza19zZXRfY3B1KGNwdSwgbm9oei5pZGxlX2NwdXNfbWFzayk7DQo+ID4g
DQo+ID4gT3RoZXJ3aXNlIEkgY291bGQgcmVwcm9kdWNlIHRoZSBpc3N1ZSBhbmQgdGhlIHBhdGNo
IHdhcyBzb2x2aW5nIGl0LA0KPiA+IHNvOg0KPiA+IFRlc3RlZC1ieTogUGllcnJlIEdvbmRvaXMg
PHBpZXJyZS5nb25kb2lzQGFybS5jb20+DQoNClRoYW5rcyBmb3IgdGVzdGluZywgcmVhbGx5IGFw
cHJlY2lhdGVkIQ0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IEFsc28sIHlvdXIg
cGF0Y2ggZG9lc24ndCBhaW0gdG8gc29sdmUgdGhhdCwgYnV0IEkgdGhpbmsgdGhlcmUgaXMgYW4N
Cj4gPiBpc3N1ZQ0KPiA+IHdoZW4gdXBkYXRpbmcgY3B1c2V0LmNwdXMgd2hlbiBhbiBpc29sYXRl
ZCBwYXJ0aXRpb24gd2FzIGFscmVhZHkNCj4gPiBjcmVhdGVkOg0KPiA+IA0KPiA+IC8vIENyZWF0
ZSBhbiBpc29sYXRlZCBwYXJ0aXRpb24gY29udGFpbmluZyBDUFUwDQo+ID4gIyBta2RpciBjZ3Jv
dXANCj4gPiAjIG1vdW50IC10IGNncm91cDIgbm9uZSBjZ3JvdXAvDQo+ID4gIyBta2RpciBjZ3Jv
dXAvVGVzdGluZw0KPiA+ICMgZWNobyAiK2NwdXNldCIgPiBjZ3JvdXAvY2dyb3VwLnN1YnRyZWVf
Y29udHJvbA0KPiA+ICMgZWNobyAiK2NwdXNldCIgPiBjZ3JvdXAvVGVzdGluZy9jZ3JvdXAuc3Vi
dHJlZV9jb250cm9sDQo+ID4gIyBlY2hvIDAgPiBjZ3JvdXAvVGVzdGluZy9jcHVzZXQuY3B1cw0K
PiA+ICMgZWNobyBpc29sYXRlZCA+IGNncm91cC9UZXN0aW5nL2NwdXNldC5jcHVzLnBhcnRpdGlv
bg0KPiA+IA0KPiA+IC8vIENQVTAncyBzY2hlZCBkb21haW4gaXMgZGV0YWNoZWQ6DQo+ID4gIyBs
cyAvc3lzL2tlcm5lbC9kZWJ1Zy9zY2hlZC9kb21haW5zL2NwdTAvDQo+ID4gIyBscyAvc3lzL2tl
cm5lbC9kZWJ1Zy9zY2hlZC9kb21haW5zL2NwdTEvDQo+ID4gZG9tYWluMMKgIGRvbWFpbjENCj4g
PiANCj4gPiAvLyBDaGFuZ2UgdGhlIGlzb2xhdGVkIHBhcnRpdGlvbiB0byBiZSBDUFUxDQo+ID4g
IyBlY2hvIDEgPiBjZ3JvdXAvVGVzdGluZy9jcHVzZXQuY3B1cw0KPiA+IA0KPiA+IC8vIENQVVsw
LTFdIHNjaGVkIGRvbWFpbnMgYXJlIG5vdCB1cGRhdGVkOg0KPiA+ICMgbHMgL3N5cy9rZXJuZWwv
ZGVidWcvc2NoZWQvZG9tYWlucy9jcHUwLw0KPiA+ICMgbHMgL3N5cy9rZXJuZWwvZGVidWcvc2No
ZWQvZG9tYWlucy9jcHUxLw0KPiA+IGRvbWFpbjDCoCBkb21haW4xDQo+ID4gDQpJbnRlcmVzdGlu
Zy4gTGV0IG1lIGNoZWNrIGFuZCBnZXQgYmFjayB0byB5b3UgbGF0ZXIgb24gdGhpcy4gOikNCg0K
dGhhbmtzLA0KcnVpDQo=
