Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2740C7D4D71
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjJXKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJXKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:14:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7182DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698142496; x=1729678496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cAl8aoe0vV1c2OLvBJLEZhAefzUjpzU8rrrn9Ejr0IU=;
  b=gd9tDgfzR3l7CUYChe0khlvibRRQPYbNQr80oTQHEedH16Qb1Lt3Fiu8
   daoqK9f5Yp5SnT1bqUEoXmjtmUWTshNw/CiOlrCSsUyVAcCA7SY/0dyvC
   MLPk04vTGhSJOH1GB9entQcLKJoYMrtSBU/LS8jN7rdvJZXjpQ3X5NSLl
   R07EhGMij52MBIHSEF5klYzZjjP96xnTHezGZrcaX4OMQidyPptspseLz
   HZG9vr5ANK0BxCn8+Hhi0FMtc0e3w70+EJsjBRU6LPShhKU/t11AcBp6n
   ulKB91nHbf+y0hNMc7PV5VNxgCeco5oeW/BlJLXImIR6h6KTFM2Auzb20
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384226351"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384226351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708234764"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708234764"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 03:14:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 03:14:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 03:14:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 03:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0iimm2Nh9qNlggyVeM0rMz8bwXI5pOZu41hGAf1Kv+DNuv4OtpdPUlGoUPiXXpmlZjOZY/Iv347bcyaXs7vKuFSu/70NUTAoN6s3N864OOi5yB3rn5G2IPdyEOtLXQyd6Fa1RkIhmPH+E5/Wv6gL8oiPjjgEAFthzGT9bS9/k7rOAwbP9tx9wRzDkauONOL374E4e6pw2zWek3pGL5jS6V4E/SvIjaydqn3rJSNk3dupWL4jpH90wy7xHgwaovflccubWFz/LUrJXE2mAGF7kSZw0DbRuxhhN3siruZZJVF7W3G0HTHDx5cq7lhzqEKsH/MjV6ZrnVcrWcOrmZ4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAl8aoe0vV1c2OLvBJLEZhAefzUjpzU8rrrn9Ejr0IU=;
 b=De0/ctAgZfSEu5dYjlIMcRvrFbWbwD4fmNJBRbbz0cJIBCcLPH+eYzHFuLVIger1XAyKS6Szem94ISq/UkoYA/CkfoaZEaMCrRA9Wd9tQtY0s5X0JKEj6TT0bDMfR1ejJ/UtFrdBxsvBMWEX1hGsoMcCABDU8uKFZTwdm82MJYifCk1CZu/p9l/7V2k0ukJTToECYeIz0DTmsxVQZcs9qx5FLtw1yNre1zwKEJdTag7Q2+ZQN1jZiVPeusS1F6YFVTToass+gXAbD1k0XzhXad4ZJcylAbSr+dyckEggbmWkgcys+894YZXD3w5hjHvjb7OiSY6UdxmjM/zD/DaKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 10:14:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 10:14:51 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 11/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Thread-Topic: [PATCHv2 11/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Thread-Index: AQHaA2fu+z257kmj20GUiA96QjpnfrBYvwYA
Date:   Tue, 24 Oct 2023 10:14:51 +0000
Message-ID: <1185a15a1b4238092813a8134d86c93d73d84403.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
         <20231020151242.1814-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231020151242.1814-12-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5641:EE_
x-ms-office365-filtering-correlation-id: 81466f38-ffe3-4c56-623a-08dbd47a0f84
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XK0C8F4ya0mEkhA63eEHsLITQJB0hCbC5yvBB8zwnCavoQV8YGJYryG31uhMTxZlZk4cKeG+CcNBhs62dwErRUtFSrbLQqXDvnvqt+FaJFenT3VwwkhWHhfEa/C/pDg9odTLVMBXwiL0oTJcP0hz+bk44d4wl+hZYxQvO/1QtCkYh10SU45Kywao+zMea+rHo/F51D7FFe0U8zGjOwLh4LxA6YLWT3Hxy1uj67IWtEoewMVplCAofhAE57rPbJebaxlVBgnbZSzDcPpYGMvIr4h/UPi3VhA3o4S7rMHQ2lQkRkYtBsQ/yEAeQW8TF1t51K8gVpB90R/3L7fXDMwfuzk2A/shk7i0dvzeBJEXfF5Yk8GKdp8Ywfv+ewPXs4dWb++Gx+D6gmGdtuBDWflFVKPcW3FPkDYfGZMwlvEbB/j3s/HlvHYlI5qEn8Xkp4UR1uHXTRXb05iQgDiej8WDE8T+9Q1z7eL8b6gMroafV+z539RHBI7PYAPGB8C++R7+NwsZChSVJ6XnRTpGCrkZYb8G3RQHwbjrcfCIjsrXjFHwjVL1GFxjNRWaIehZlOHjNmAOl8Wk1ZnnwKfko3quOfYOMgJgZSYeCqT69Dxf3ZJ3gIwsIQgXp/C2vd/9Qc65
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(7416002)(8936002)(4326008)(8676002)(41300700001)(38070700009)(2906002)(4001150100001)(4744005)(5660300002)(110136005)(71200400001)(122000001)(6512007)(82960400001)(6506007)(36756003)(2616005)(83380400001)(86362001)(91956017)(76116006)(38100700002)(66946007)(26005)(66556008)(54906003)(66446008)(6486002)(66476007)(64756008)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTl3bHAycUNUTkh3ZXpjbHg5b0MzNURqTFlFanVmWkY0bFJXd2dpZmxnMmFx?=
 =?utf-8?B?ZWZXNm94cnhjYXFDWHBSbUdyaFJUSzkrOEM2K3lqSnBXYjc5NDJOK3h1bncr?=
 =?utf-8?B?UnJoTFQ0eFJMcTVCM3h5MjVBVHcwRGNoTUJmQWRUTUNpUC9XRURGQUxqajBC?=
 =?utf-8?B?UkNySDVHREF0UE11MEtpNnFSK1IvVUdCeXNoaElmTjRXTnJYbllBbW1ZZ3dr?=
 =?utf-8?B?UldaT3doSGpDc1lUK2pIcERBbVNSOVluMDZHSDZRK1V1bGY1dTFBNHJZYlNS?=
 =?utf-8?B?M2xhcExlL1FNL2gwcUI0VlpHQmhMNzJ5WjhGVDFrTU9uVk4xdkRrN1FmMkVt?=
 =?utf-8?B?UDdXck5QaXZYdCt2amo4NGdlRGJKb2JUUy92ZnR0cjN6THJGSHNRem0ramJn?=
 =?utf-8?B?cFBNNW9zaWRSWmdmVlRMT2VPRmRkejk5blZHOWJvL1J4YXRJUnR5VVpURStK?=
 =?utf-8?B?T0dmR3ZYRUZ3OGRxdjgyTXZrMzBZWG5NYUgrZ2F0QWlGekg1aXlYLysvZ0hv?=
 =?utf-8?B?c010amF6T3NlVFgwWW5oYmJ4RU5SN3RNZTFlT3ZQNTJWOXN2ZVVyVjcyckNx?=
 =?utf-8?B?c1kyNnVZYjVWN1owSTh4SkkwZnZUWFpiWDJ3Ym5zOU91ZkExendPUmxiVWM4?=
 =?utf-8?B?VXNGdHBKTmF2QnYxYUkyZ3J0MThtbnl2R283ZUJKUFV3dmtHMmxySnpnKy81?=
 =?utf-8?B?V0p3eEhpOE80cHFqb2gvNWtkYTFTQzlrVkl1Y1h5aUd5TEtQZXViME4xNklH?=
 =?utf-8?B?ZklJYlNkbEpqaXBxdy9wOHZEeVEvL3FuQU8vakpLWkZ4eVdSWWxoTlFrUWVo?=
 =?utf-8?B?TnN0Y2xFZ1FiUzR3Q3REd3NscDYyYW9EZ2djaXhhU3B5eGVJcFlXSmtzYm5m?=
 =?utf-8?B?ZmpzcFZqdkpSeWFmR2hHamZ6Z1NhdHJpa3htdFJPOEg3Ny9wM3VJTzdrRjFO?=
 =?utf-8?B?NHJweDdXZmZjS1JlekoyUUZCUmt1R0VIWEU1WEcxd2JaeUs3V0NnSWl0alVN?=
 =?utf-8?B?dWUzcnRGSjFSMU9QQ1NwNkE1Tk9mdEJLZHVWSDFtOHR2b25GTys5N1lMNjhS?=
 =?utf-8?B?QkVqemRRbFhnWTRiZk9HRWYzandtVERpY3JBeGNNNDZQbmZKTzZWOGNDclZt?=
 =?utf-8?B?ZDE5ZFpFVWc3YkZJQWFyZDFtRVNYRFlqYnJ1bC9JTlJFa1NveEJUYnE2T21v?=
 =?utf-8?B?UzNFbk1uUktLY0x2ZWZYUWpSQmJrTDVubE5oaER6WmFiUVE1bmtaa2plVGEv?=
 =?utf-8?B?blcyRmRXYjE2ZUU2UjRpMm1pWUY2citUK0NQdzBpSTYyWU5jZm1xbkQ5MHZj?=
 =?utf-8?B?S3RnNFNYTVRKb1JpK2IvaTRqWm9LaEcrcnY0VWwwNy9PUU1iVXBqY2c3N1Ur?=
 =?utf-8?B?THdYeW1yaEorZnRwODd2ckY3dUFwZy9RaGcyZTNyN0oyZC9iNmVBcU93V3Rl?=
 =?utf-8?B?OC9hVGRCUTZVYXFvek5KVWg4aDlhYlVXZDFyelE4WUVXekRqc0dsQW9MTFRo?=
 =?utf-8?B?YklVZ0k1elZQVFU1SDNKZXpZTXI0QlhqWDZpcFhXY3RmeWVMTFNaeHpabnU1?=
 =?utf-8?B?TVhqWDdseVI4eWRtblVUSTRpbGk1b0ZlRTY5aVZqZU1lOFdvL3hZYkJ1Q1Fs?=
 =?utf-8?B?eENEWEZPY21XSmFvNXJQR1BhNVpNOVoxTG5acG5hR3hsQTNDMXprRUJKUDFN?=
 =?utf-8?B?Z0RXSTU3b2xIOWh0Y1pmSEt3TkpTR3RhMTd4b1IzSmE3T3FMS1lQOGtDQ3gy?=
 =?utf-8?B?U2RqMVRZV1Zhc3RFeGVHa2FoYWxJNXFqc0lZMkYyMlNiYjVHVHI1WVh0c1Nw?=
 =?utf-8?B?ZFk5YzBFSEZYRlpVSUNUOXRTTVBYa1M1Z0VSS1VFVDAvS3ZxYW9YZHU0L0tn?=
 =?utf-8?B?U1ZSU2t4RlhyOWlLU1lyaFF2VkY4V05zbDArSy9kMGxwTzVqbklRV1Ntd1F5?=
 =?utf-8?B?enBDbGNtdHZ0YXpxaDJsZWljUHhMSkh3QW92U3dvWE1KblBNNE4rZUdlTGV3?=
 =?utf-8?B?aW1zVkYrZUFBZUV5aXVkVHFuS3Q1ZjhaeHRVR1ExME1zL0xxUE9DNlpFSDZN?=
 =?utf-8?B?eXRxU0RZUnZzQ014d0pRbWJGM1AzcVB5ejcxT1hmdzZkMXdRd1FSTkpyblAz?=
 =?utf-8?B?Ri9vcGxlbkdSSHcyV1AyVXV5K0xrM0w0cVdaV3U0WUY3OHJzUFR4OGhrTUtZ?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F19D3E921FD43C4080CCC119C7E4E69E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81466f38-ffe3-4c56-623a-08dbd47a0f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:14:51.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0bSCfkDsXKmq2hgNwXUFSb0vy9GcXzXA2RQ049DCJDU7Ghu8wk75OLj67y7Y/y7ob83N+omR+3xrPUDP6ZasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
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

T24gRnJpLCAyMDIzLTEwLTIwIGF0IDE4OjEyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFDUEkgTUFEVCBkb2Vzbid0IGFsbG93IHRvIG9mZmxpbmUgQ1BVIGFmdGVyIGl0IGdv
dCB3b2tlIHVwLiBJdCBsaW1pdHMNCj4ga2V4ZWM6IHRoZSBzZWNvbmQga2VybmVsIHdvbid0IGJl
IGFibGUgdG8gdXNlIG1vcmUgdGhhbiBvbmUgQ1BVLg0KPiANCj4gTm93IGFjcGlfbXBfd2FrZV9t
YWlsYm94X3BhZGRyIGFscmVhZHkgaGFzIHRoZSBtYWlsYm94IGFkZHJlc3MuDQo+IFRoZSBhY3Bp
X3dha2V1cF9jcHUoKSB3aWxsIHVzZSBpdCB0byBicmluZyB1cCBzZWNvbmRhcnkgY3B1cy4NCj4g
DQo+IFplcm8gb3V0IG1haWxib3ggYWRkcmVzcyBpbiB0aGUgQUNQSSBNQURUIHdha2V1cCBzdHJ1
Y3R1cmUgdG8gaW5kaWNhdGUNCj4gdGhhdCB0aGUgbWFpbGJveCBpcyBub3QgdXNhYmxlLiAgVGhp
cyBwcmV2ZW50cyB0aGUga2V4ZWMoKS1lZCBrZXJuZWwNCj4gZnJvbSByZWFkaW5nIGEgdmFpbGQg
bWFpbGJveCwgd2hpY2ggaW4gdHVybiBtYWtlcyB0aGUga2V4ZWMoKS1lZCBrZXJuZWwNCj4gb25s
eSBiZSBhYmxlIHRvIHVzZSB0aGUgYm9vdCBDUFUuDQo+IA0KPiBUaGlzIGlzIExpbnV4LXNwZWNp
ZmljIHByb3RvY29sIGFuZCBub3QgcmVmbGVjdGVkIGluIEFDUEkgc3BlYy4NCj4gDQo+IEJvb3Rp
bmcgdGhlIHNlY29uZCBrZXJuZWwgd2l0aCBzaWdubGUgQ1BVIGlzIGVub3VnaCB0byBjb3ZlciB0
aGUgbW9zdA0KPiBjb21tb24gY2FzZSBmb3Iga2V4ZWMgLS0ga2R1bXAuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCg==
