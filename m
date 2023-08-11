Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B4778F97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjHKMck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:32:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC104E60
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691757158; x=1723293158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fkySCDv25aHBHwFYWNaD9mNR1WK6QshYtI0/4bDuKlc=;
  b=OjnLfx1r/AK3if0+cB3QLesIniyrsHWHZ4ZCbpjoeU+X30tW7Ta63RUu
   Vjm5IdGagz8B31/Q8BmO3A57GZnKIodGMTpwdsZY32f20jTlzc5dQkFBN
   m7OT7xpX7ccmbh8O01iMRRxVr+t08DAyNrRfdQAKKtfmpPzTUN3ivW0mc
   mL/0X8ishNU82JRcVpE/r/5cJTItugkh8MXGNeeNlks/mkPFAiedE8L6B
   JPv2UkEFv4erY1cm2mRIUlEHHIS1VptqDeA8hH/hugbNe6F2FhCZFNR6g
   P1kYrU7Ub03d9CC9A0RylM6VedXQACQmvhYhspETBRzcRbjP6IWu+6OdO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361805978"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361805978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 05:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735777364"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="735777364"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 05:32:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 05:32:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 05:32:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 05:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtYxS7O3lIGMr79A/d3w8BYtOV7FoZjdvz4Pav6HBAynJxPbZRwyo6Xiy+cHqH2ir7BVZyMiP+q0BaRN3iPqgpxTaXjdoH5KCBdYi5tuCpo3RcqvvQAsCuQH9OPlnVIj0F6FicKsyZjmmCKSYUyLpmRjRyhKzPt6MGwq0WqDyVGpdA2lvEscS94j6CsCOzKxB1oLyye9LtZfgfEEowwQelDUvYj3AI/d2zF1SB3NktNpFLTBya1fToMaXQz5QVh1fR1ae4Pi5vULfNzU55SoDyP3CIqH2ec5ARdExfedwMBXcgR21QSmqSPB93rVuLICKqfVNbEonXfmwacwctDmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkySCDv25aHBHwFYWNaD9mNR1WK6QshYtI0/4bDuKlc=;
 b=Z0VpIDOWIkh8Y4PFGfWoRl+m74SjUb+thGo61Yp9guKoseChTUEaAVemnp/ycsyFwVgLHWWdXqlzGTZ5S0gvenFxG5sE6PcVoeuAoHr8kjje0/e2LXiLfSAwmA+6pQgrcliSvwrcu/kQ7q5qOw92j60uh6DfEjdCunWZZ5x4LP8BiagzA+wEVIHckuRTuwYk5SGQb/phMkeGDiK09iFUvkVij22t7bu0ZG6lS04+lzI5UiItR64oiPqdJr/gm1BFytsqkZDladV1LCGnKZ0z8IAJj675aLGuup8UyTNsn6o0wRLYspMj4vyuxrUll2bD77VEEeB0LXcdwAQoMv0I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 12:32:31 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 12:32:31 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [patch 24/53] x86/cpu/topology: Provide separate APIC
 registration functions
Thread-Topic: [patch 24/53] x86/cpu/topology: Provide separate APIC
 registration functions
Thread-Index: AQHZyTaPQfdIlnpfUUmPm8SS9R7pLK/lDVuA
Date:   Fri, 11 Aug 2023 12:32:31 +0000
Message-ID: <d70db131cd4fa847159ad300c2b8be3434a889aa.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
         <20230807135027.692922999@linutronix.de>
In-Reply-To: <20230807135027.692922999@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: c998e1b9-b61b-434b-1186-08db9a67086a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apFRmqae7wU9L/9l9twstIKZ5VhWs3wWLd+Uix9f6hj5wh+iPpCp7kTWIk8IMDmt1wl/nZqLWLXNlUv9A9dO0dd/kGGSZOwtU1wfyUM36aH9vELUMtnHmVXAhlf706E1+BondLEZHOWfW9j5M/06OZ4nGNyMHq33r6x/M1XjKUFkSeT6q8dWlNS4M7r9SwI5DcU4stA1IxCJ30Umn924K/jdcUw8YV+sz4wPm8X6QmvwON393fvRI3/ka9lzJHSZUwDojiRAWYMEoAx2GAFyEE76q/lGI3qAgo6CrKD4/Wue9Xz0awSinPKSTIDlHomWUR23OWVxA5w0r5jRMRDFxOXD7fZw/2yCg+ZpKYPzQ9MxcnUPm8AwWtZacRsTVNXKBffuKShHYkG/7oZPjZYCsfWkIpbco/xWUIyR+WxTtfG6f3TWKFPaJN+sEpw4VaqWn7gOY/IoBA/IVdHI1l8tAe2bFeLdljd/DnXrGAV3R04aEnK/ZnjwgPMKSv3L9WHUmGytuvKfBUEp/wYqwTZGyhHp1kM+n9f6TV6jHNDfJMxiW8yZ03U1CJ64l7dFwRzJfADUf3iEHceyXLwNu+uhAIBFwlZcibJ5UVdEugBAiaWNV4PAxrFCWsqwlELeU3WH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(1800799006)(186006)(38070700005)(6486002)(6512007)(86362001)(71200400001)(26005)(6506007)(83380400001)(36756003)(2616005)(122000001)(38100700002)(82960400001)(91956017)(66556008)(316002)(5660300002)(41300700001)(8936002)(8676002)(2906002)(66476007)(64756008)(4326008)(76116006)(66946007)(7416002)(478600001)(66446008)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmNuOXNZWjh1d2tuNTlPdmN4SXpleDN4MEpOaXdxbUVBcWM3UFc4dmkwcWVp?=
 =?utf-8?B?TUZnVDREbWV3UGRFOHpOd0M5WWhQdlZudHdVMTBoT1Qxc0xpZmtpcGllWEFV?=
 =?utf-8?B?UDBlUUF1cE1UVFQraDJoN09ISG5tVHpGQ2IrempodXpVdjk0TFB6eGtTcnd2?=
 =?utf-8?B?VmExSktWSlVORWZwNjNjbmk0d2RONUtrZmVxemtSYlFPSTA4dlNIaCsvMXVM?=
 =?utf-8?B?ckxTUVhVS0FMSGtKNEorNk9xSnluSUFuK1IrV29yYThSZjhYd1BpaDVreFh0?=
 =?utf-8?B?eDE1SXlVMEMxZGtuR0tmbjVOUHM0akY1L0hITEswOHJFeXNzU3FEKzdKejg5?=
 =?utf-8?B?UG5IeFIwdndoVkFQUDA1VVNGdUhTQ2Zpblg4SUluU2xsTUhKNk1Vb3A4N0Nl?=
 =?utf-8?B?djNNNHFiTWt6NXdDM1g0TDZiVHNMY3k0WEx3UENoZEU5RUJrK3FqS09GbEFU?=
 =?utf-8?B?Yk9VaVQ5U2p5cTR1N1BkbmRUa3BpSDFDalZNU2JnQ0htQWFQakdWUXVJU1RN?=
 =?utf-8?B?T1loTVN6QVZKSENKYVFKUlVhQzhQQ252WldJUk1ScFlobXNCd1I0dXRDY05V?=
 =?utf-8?B?RTB3Z0RxZjRiaW1RYUpnOFg2T3c4VEUyTUdKdGZ0SDJOQTVRYjU0UTVpT1lw?=
 =?utf-8?B?T25DVjRzVmtpdFlJK1JXRXNQZyt6MEFMblBFU216aXV4RHdiSW9EeXNwQi9u?=
 =?utf-8?B?SHBhSklVeElkendTOTc5bkNwdmlrbEZ3R3RLaHJrQlVXM1pHT3o4alYzby9a?=
 =?utf-8?B?OVJBaWw2TjBEaGs0d2haUXR5TEtDQ0piWUJLaXFqald1VUVsR3pnbGgvUXVu?=
 =?utf-8?B?dlpZOFRsZjBqR1ZBdmgwb01kb3hoZFg3dUdSMWp1S3NRUUVReEM5YWRNZDBJ?=
 =?utf-8?B?czE5SEsrMGdiNGp0YVRzRWwreDFPZUkrcnl1QW1NbWRkV1dyTkRYSmZQUTB2?=
 =?utf-8?B?b0tGTGdjdXg2cWUvNXpBZStuU1VWWjlvZGFxVUJjaFpDa1RXZExxL2pneDVq?=
 =?utf-8?B?RzQ2enFYMjMwSGw3MGRXdDNwV1N5V2RuVUZQc3Y0Z0dPUVRlY0RRYUFSTTdv?=
 =?utf-8?B?TFNaUlVnVVF2em9NUy9SU2xrQ0NtL3NIR2NmeTdEaW1KVjNpdUIvMzRWSEhW?=
 =?utf-8?B?OS9nejJ3OTNkbVNQU1R4eCsxZDJ0WmZBSUpLTVc3MlZYSGVBcU5SUWE4Wit0?=
 =?utf-8?B?eU5pcGtlbUpTaXVwOHlpUUhJanV0ZFhKNGVHZXhMNWlWZEV5V1d5bCthbGZz?=
 =?utf-8?B?K2pHUGtjQ0ZMY0s1eXQ2UHZiQkg2ZnVRb21mNnQwMDB1dUthWHNQRVJoQWZR?=
 =?utf-8?B?NVZnbWorWjR0N1VBUEhVSGRlQ0JiTkpaY2ROUnpuY1F2V1BEKy83VURGeGdo?=
 =?utf-8?B?aG1xSDZrdDNsRUJiUHc3ZEhrSGE5N3RTSTNoNXA5NnBuSlh0YkFadGJMSVJt?=
 =?utf-8?B?ZmNMUlZsR081NCt0cTRoUXRKUkRlSDU4Q2lTeEVnTGhvb2paQXh4ZXowMzc1?=
 =?utf-8?B?a2JFWmYzcUx3Umhhd0hTREhnYlk3T3ppejcrWjNsU24ycWFBRUlPSm9JMy8z?=
 =?utf-8?B?U1BwMFlINGEyY3lTL2dLZ01LNXhkeW1ubmhhNzdmZGtBSUJLNEpjeHEweE5C?=
 =?utf-8?B?RFNGU3FlY3RIYnN2RjY1dFZ6UjZNcEpGc09GSjdSd09DSEhLd1FGckxaUXBN?=
 =?utf-8?B?c21XSmhGMHNxY1hDOGFBUlFPMHlIT20rMEZqRFZHd1pwRWpaT2JjYzRoOWJS?=
 =?utf-8?B?M1VJNXVUWkRPa0QwdnVTbkVvNnFWTEYxSkVhMGpyVnVxT3hzSUxISmFkS1I2?=
 =?utf-8?B?Vy9WekM2SjVTRThRcTIwWXEwSytDaU5GMTZTUXFnQVZxM3lRWTVSTSs3S2NI?=
 =?utf-8?B?aVU4US9wcTMxU0hleCtvV3ZDZWw5cjRrdGcwcTFjTVY5QnZ2ZWpjSGZqcURk?=
 =?utf-8?B?b0sxbWJtUFc5cGpRbTZmUUVnejFuQnBkd3Vhc0NUSWVBWE9vTExUQSt0a3FD?=
 =?utf-8?B?T0dOVmdGVCtFQ0xUdWUwUUNuSFh0TXR0RUF1UWV3ZkJuWGdmMmhlSStnYzJx?=
 =?utf-8?B?NWs0a2lWdmIwYWJRUkZYTUljaHU5cFA2WFhJRjJHODYvU2NiMWxJQzhlQzND?=
 =?utf-8?Q?yr9GcSEciPov8SlWdhZvZnmcw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EAEE7D75F9B0244AA2142E056823F5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c998e1b9-b61b-434b-1186-08db9a67086a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 12:32:31.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Joa1k23epUYGSYKv59dHDw2d39NpZlq7aIqhJR4pvByjNrkqmpI2etmwjkrc+5OzDsAd0iawKnY7YqI258T/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDE1OjUzICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
Cj4gZ2VuZXJpY19wcm9jZXNzb3JfaW5mbygpIGFzaWRlIG9mIGJlaW5nIGEgY29tcGxldGUgbWlz
bm9tZXIgaXMgdXNlZAo+IGZvcgo+IGJvdGggZWFybHkgYm9vdCByZWdpc3RyYXRpb24gYW5kIEFD
UEkgQ1BVIGhvdHBsdWcuCj4gCj4gV2hpbGUgaXQncyBhcmd1YWJsZSB0aGF0IHRoaXMgY2FuIHNo
YXJlIHNvbWUgY29kZSwgaXQgcmVzdWx0cyBpbiBjb2RlCj4gd2hpY2gKPiBpcyBoYXJkIHRvIHVu
ZGVyc3RhbmQgYW5kIGtlcHQgYXJvdW5kIHBvc3QgaW5pdCBmb3Igbm8gcmVhbCByZWFzb24uCj4g
Cj4gQWxzbyB0aGUgY2FsbCBzaXRlcyBkbyBsb3RzIG9mIG1hbnVhbCBmaWRkbGluZyBpbiB0b3Bv
bG9neSByZWxhdGVkCj4gdmFyaWFibGVzIGluc3RlYWQgb2YgaGF2aW5nIHByb3BlciBpbnRlcmZh
Y2VzIGZvciB0aGUgcHVycG9zZSB3aGljaAo+IGhhbmRsZQo+IHRoZSB0b3BvbG9neSBpbnRlcm5h
bHMgY29ycmVjdGx5Lgo+IAo+IFByb3ZpZGUgdG9wb2xvZ3lfcmVnaXN0ZXJfYXBpYygpLCB0b3Bv
bG9neV9ob3RwbHVnX2FwaWMoKSBhbmQKPiB0b3BvbG9neV9ob3RfdW5wbHVnX2FwaWMoKQoKcy90
b3BvbG9neV9ob3RfdW5wbHVnX2FwaWMvdG9wb2xvZ3lfaG90dW5wbHVnX2FwaWMKCnRoYW5rcywK
cnVpCgo+ICB3aGljaCBoYXZlIHRoZSBleHRyYSBtYWdpYyBvZiB0aGUgY2FsbCBzaXRlcwo+IGlu
Y29ycG9yYXRlZCBhbmQgZm9yIG5vdyBhcmUgd3JhcHBlcnMgYXJvdW5kCj4gZ2VuZXJpY19wcm9j
ZXNzb3JfaW5mbygpLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPgo+IC0tLQo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5owqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgIDMgCj4gwqBhcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMg
fMKgIDExMwo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiAKPiAtLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9hcGljLmgKPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9h
cGljLmgKPiBAQCAtMTcxLDcgKzE3MSwxMCBAQCBleHRlcm4gYm9vbCBhcGljX25lZWRzX3BpdCh2
b2lkKTsKPiDCoAo+IMKgZXh0ZXJuIHZvaWQgYXBpY19zZW5kX0lQSV9hbGxidXRzZWxmKHVuc2ln
bmVkIGludCB2ZWN0b3IpOwo+IMKgCj4gK2V4dGVybiB2b2lkIHRvcG9sb2d5X3JlZ2lzdGVyX2Fw
aWModTMyIGFwaWNfaWQsIHUzMiBhY3BpX2lkLCBib29sCj4gcHJlc2VudCk7Cj4gwqBleHRlcm4g
dm9pZCB0b3BvbG9neV9yZWdpc3Rlcl9ib290X2FwaWModTMyIGFwaWNfaWQpOwo+ICtleHRlcm4g
aW50IHRvcG9sb2d5X2hvdHBsdWdfYXBpYyh1MzIgYXBpY19pZCwgdTMyIGFjcGlfaWQpOwo+ICtl
eHRlcm4gdm9pZCB0b3BvbG9neV9ob3R1bnBsdWdfYXBpYyh1bnNpZ25lZCBpbnQgY3B1KTsKPiDC
oAo+IMKgI2Vsc2UgLyogIUNPTkZJR19YODZfTE9DQUxfQVBJQyAqLwo+IMKgc3RhdGljIGlubGlu
ZSB2b2lkIGxhcGljX3NodXRkb3duKHZvaWQpIHsgfQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvdG9wb2xvZ3kuYwo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3kuYwo+IEBA
IC03OSwzMiArNzksMzggQEAgZWFybHlfaW5pdGNhbGwoc21wX2luaXRfcHJpbWFyeV90aHJlYWRf
bQo+IMKgc3RhdGljIGlubGluZSB2b2lkIGNwdV9tYXJrX3ByaW1hcnlfdGhyZWFkKHVuc2lnbmVk
IGludCBjcHUsCj4gdW5zaWduZWQgaW50IGFwaWNpZCkgeyB9Cj4gwqAjZW5kaWYKPiDCoAo+IC0v
Kgo+IC0gKiBTaG91bGQgdXNlIHRoaXMgQVBJIHRvIGFsbG9jYXRlIGxvZ2ljYWwgQ1BVIElEcyB0
byBrZWVwCj4gbnJfbG9naWNhbF9jcHVpZHMKPiAtICogYW5kIGNwdWlkX3RvX2FwaWNpZFtdIHN5
bmNocm9uaXplZC4KPiAtICovCj4gLXN0YXRpYyBpbnQgYWxsb2NhdGVfbG9naWNhbF9jcHVpZChp
bnQgYXBpY2lkKQo+ICtzdGF0aWMgaW50IHRvcG9fbG9va3VwX2NwdWlkKHUzMiBhcGljX2lkKQo+
IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgaTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC8qCj4g
LcKgwqDCoMKgwqDCoMKgICogY3B1aWQgPC0+IGFwaWNpZCBtYXBwaW5nIGlzIHBlcnNpc3RlbnQs
IHNvIHdoZW4gYSBjcHUgaXMKPiB1cCwKPiAtwqDCoMKgwqDCoMKgwqAgKiBjaGVjayBpZiB0aGUg
a2VybmVsIGhhcyBhbGxvY2F0ZWQgYSBjcHVpZCBmb3IgaXQuCj4gLcKgwqDCoMKgwqDCoMKgICov
Cj4gK8KgwqDCoMKgwqDCoMKgLyogQ1BVIyB0byBBUElDSUQgbWFwcGluZyBpcyBwZXJzaXN0ZW50
IG9uY2UgaXQgaXMKPiBlc3RhYmxpc2hlZCAqLwo+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAw
OyBpIDwgbnJfbG9naWNhbF9jcHVpZHM7IGkrKykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoY3B1aWRfdG9fYXBpY2lkW2ldID09IGFwaWNpZCkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNwdWlkX3RvX2FwaWNpZFtpXSA9PSBhcGljX2lkKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBpOwo+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7Cj4gK30K
PiArCj4gKy8qCj4gKyAqIFNob3VsZCB1c2UgdGhpcyBBUEkgdG8gYWxsb2NhdGUgbG9naWNhbCBD
UFUgSURzIHRvIGtlZXAKPiBucl9sb2dpY2FsX2NwdWlkcwo+ICsgKiBhbmQgY3B1aWRfdG9fYXBp
Y2lkW10gc3luY2hyb25pemVkLgo+ICsgKi8KPiArc3RhdGljIGludCBhbGxvY2F0ZV9sb2dpY2Fs
X2NwdWlkKHUzMiBhcGljX2lkKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGNwdSA9IHRvcG9f
bG9va3VwX2NwdWlkKGFwaWNfaWQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoY3B1ID49IDAp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBjcHU7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgLyogQWxsb2NhdGUgYSBuZXcgY3B1aWQuICovCj4gwqDCoMKgwqDCoMKgwqDC
oGlmIChucl9sb2dpY2FsX2NwdWlkcyA+PSBucl9jcHVfaWRzKSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBXQVJOX09OQ0UoMSwgIkFQSUM6IE5SX0NQVVMvcG9zc2libGVfY3B1
cyBsaW1pdCBvZiAldQo+IHJlYWNoZWQuICIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUHJvY2Vzc29yICVkLzB4JXggYW5kIHRoZSBy
ZXN0IGFyZQo+IGlnbm9yZWQuXG4iLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnJfY3B1X2lkcywgbnJfbG9naWNhbF9jcHVpZHMsIGFw
aWNpZCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBucl9jcHVfaWRzLCBucl9sb2dpY2FsX2NwdWlkcywgYXBpY19pZCk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoMKgwqDCoMKgwqDC
oMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgY3B1aWRfdG9fYXBpY2lkW25yX2xvZ2ljYWxfY3B1
aWRzXSA9IGFwaWNpZDsKPiArwqDCoMKgwqDCoMKgwqBjcHVpZF90b19hcGljaWRbbnJfbG9naWNh
bF9jcHVpZHNdID0gYXBpY19pZDsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIG5yX2xvZ2ljYWxf
Y3B1aWRzKys7Cj4gwqB9Cj4gwqAKPiBAQCAtMTIyLDEyICsxMjgsNiBAQCBzdGF0aWMgdm9pZCBj
cHVfdXBkYXRlX2FwaWMoaW50IGNwdSwgdTMyCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjcHVfbWFya19wcmltYXJ5X3RocmVhZChjcHUsIGFwaWNpZCk7Cj4gwqB9Cj4gwqAKPiAt
dm9pZCBfX2luaXQgdG9wb2xvZ3lfcmVnaXN0ZXJfYm9vdF9hcGljKHUzMiBhcGljX2lkKQo+IC17
Cj4gLcKgwqDCoMKgwqDCoMKgY3B1aWRfdG9fYXBpY2lkWzBdID0gYXBpY19pZDsKPiAtwqDCoMKg
wqDCoMKgwqBjcHVfdXBkYXRlX2FwaWMoMCwgYXBpY19pZCk7Cj4gLX0KPiAtCj4gwqBpbnQgZ2Vu
ZXJpY19wcm9jZXNzb3JfaW5mbyhpbnQgYXBpY2lkKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgY3B1LCBtYXggPSBucl9jcHVfaWRzOwo+IEBAIC0xNjksNiArMTY5LDgzIEBAIGludCBnZW5l
cmljX3Byb2Nlc3Nvcl9pbmZvKGludCBhcGljaWQpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBj
cHU7Cj4gwqB9Cj4gwqAKPiArLyoqCj4gKyAqIHRvcG9sb2d5X3JlZ2lzdGVyX2FwaWMgLSBSZWdp
c3RlciBhbiBBUElDIGluIGVhcmx5IHRvcG9sb2d5IG1hcHMKPiArICogQGFwaWNfaWQ6wqDCoMKg
VGhlIEFQSUMgSUQgdG8gc2V0IHVwCj4gKyAqIEBhY3BpX2lkOsKgwqDCoFRoZSBBQ1BJIElEIGFz
c29jaWF0ZWQgdG8gdGhlIEFQSUMKPiArICogQHByZXNlbnQ6wqDCoMKgVHJ1ZSBpZiB0aGUgY29y
cmVzcG9uZGluZyBDUFUgaXMgcHJlc2VudAo+ICsgKi8KPiArdm9pZCBfX2luaXQgdG9wb2xvZ3lf
cmVnaXN0ZXJfYXBpYyh1MzIgYXBpY19pZCwgdTMyIGFjcGlfaWQsIGJvb2wKPiBwcmVzZW50KQo+
ICt7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGNwdTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGFw
aWNfaWQgPj0gTUFYX0xPQ0FMX0FQSUMpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJfZXJyX29uY2UoIkFQSUMgSUQgJXggZXhjZWVkcyBrZXJuZWwgbGltaXQgb2Y6Cj4gJXhc
biIsIGFwaWNfaWQsIE1BWF9MT0NBTF9BUElDIC0gMSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybjsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oGlmICghcHJlc2VudCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkaXNhYmxl
ZF9jcHVzKys7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiArwqDC
oMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGNwdSA9IGdlbmVyaWNfcHJvY2Vzc29y
X2luZm8oYXBpY19pZCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNwdSA+PSAwKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlYXJseV9wZXJfY3B1KHg4Nl9jcHVfdG9fYWNwaWlkLCBj
cHUpID0gYWNwaV9pZDsKPiArfQo+ICsKPiArLyoqCj4gKyAqIHRvcG9sb2d5X3JlZ2lzdGVyX2Jv
b3RfYXBpYyAtIFJlZ2lzdGVyIHRoZSBib290IENQVSBBUElDCj4gKyAqIEBhcGljX2lkOsKgwqDC
oFRoZSBBUElDIElEIHRvIHNldCB1cAo+ICsgKgo+ICsgKiBTZXBhcmF0ZSBzbyBDUFUgIzAgY2Fu
IGJlIGFzc2lnbmVkCj4gKyAqLwo+ICt2b2lkIF9faW5pdCB0b3BvbG9neV9yZWdpc3Rlcl9ib290
X2FwaWModTMyIGFwaWNfaWQpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBjcHVpZF90b19hcGljaWRb
MF0gPSBhcGljX2lkOwo+ICvCoMKgwqDCoMKgwqDCoGNwdV91cGRhdGVfYXBpYygwLCBhcGljX2lk
KTsKPiArfQo+ICsKPiArI2lmZGVmIENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVCj4gKy8qKgo+ICsg
KiB0b3BvbG9neV9ob3RwbHVnX2FwaWMgLSBIYW5kbGUgYSBwaHlzaWNhbCBob3RwbHVnZ2VkIEFQ
SUMgYWZ0ZXIKPiBib290Cj4gKyAqIEBhcGljX2lkOsKgwqDCoFRoZSBBUElDIElEIHRvIHNldCB1
cAo+ICsgKiBAYWNwaV9pZDrCoMKgwqBUaGUgQUNQSSBJRCBhc3NvY2lhdGVkIHRvIHRoZSBBUElD
Cj4gKyAqLwo+ICtpbnQgdG9wb2xvZ3lfaG90cGx1Z19hcGljKHUzMiBhcGljX2lkLCB1MzIgYWNw
aV9pZCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGludCBjcHU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oGlmIChhcGljX2lkID49IE1BWF9MT0NBTF9BUElDKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgY3B1ID0gdG9wb19s
b29rdXBfY3B1aWQoYXBpY19pZCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNwdSA8IDApIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3B1ID0gZ2VuZXJpY19wcm9jZXNzb3JfaW5m
byhhcGljX2lkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNwdSA+PSAw
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGVyX2Nw
dSh4ODZfY3B1X3RvX2FjcGlpZCwgY3B1KSA9IGFjcGlfaWQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+
ICvCoMKgwqDCoMKgwqDCoHJldHVybiBjcHU7Cj4gK30KPiArCj4gKy8qKgo+ICsgKiB0b3BvbG9n
eV9ob3R1bnBsdWdfYXBpYyAtIFJlbW92ZSBhIHBoeXNpY2FsIGhvdHBsdWdnZWQgQVBJQyBhZnRl
cgo+IGJvb3QKPiArICogQGNwdTrCoMKgwqDCoMKgwqDCoFRoZSBDUFUgbnVtYmVyIGZvciB3aGlj
aCB0aGUgQVBJQyBJRCBpcyByZW1vdmVkCj4gKyAqLwo+ICt2b2lkIHRvcG9sb2d5X2hvdHVucGx1
Z19hcGljKHVuc2lnbmVkIGludCBjcHUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1MzIgYXBpY19p
ZCA9IGNwdWlkX3RvX2FwaWNpZFtjcHVdOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoYXBpY19p
ZCA9PSBCQURfQVBJQ0lEKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHBlcl9jcHUoeDg2X2NwdV90b19hcGljaWQsIGNwdSkgPSBC
QURfQVBJQ0lEOwo+ICvCoMKgwqDCoMKgwqDCoGNsZWFyX2JpdChhcGljX2lkLCBwaHlzX2NwdV9w
cmVzZW50X21hcCk7Cj4gK8KgwqDCoMKgwqDCoMKgc2V0X2NwdV9wcmVzZW50KGNwdSwgZmFsc2Up
Owo+ICvCoMKgwqDCoMKgwqDCoG51bV9wcm9jZXNzb3JzLS07Cj4gK30KPiArI2VuZGlmCj4gKwo+
IMKgc3RhdGljIGludCBfX2luaXQgYXBpY19zZXRfZGlzYWJsZWRfY3B1X2FwaWNpZChjaGFyICph
cmcpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghYXJnIHx8ICFnZXRfb3B0aW9uKCZhcmcs
ICZkaXNhYmxlZF9jcHVfYXBpY2lkKSkKPiAKCg==
