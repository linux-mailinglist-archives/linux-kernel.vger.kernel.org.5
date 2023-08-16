Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2C77E08D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHPLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjHPLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC39E7C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692185824; x=1723721824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bXVFy3jc4GBpU9vm7jR1CK2qUzyRDWZhxeP0r7gdyjY=;
  b=GlUk9g6sE/q7gK8DCZzYXioQe9aFjggYi0PAJTSjfxPrYJ9yFF5vTfc5
   D+L/2GIXEmbG4O72fxZ2TbCq5XkHIgnRzwOrWo0y8CRgGnqvbBaklz5Jr
   KRNVmY6IRilxzeHL1Ln7zUImpYm4XomIcVNsiDJyoSMu4AxibzzdABOA3
   aUmhhzRri8d+/pgBBM3upGeavzTEhqYaK+sT38k+KubDrkICb0CbOCtoa
   99vNjNWUvsgUbmI1Uci2x6d1SIWyPKaZYcIgtbIBaXGOckadsgdtFdMSM
   kl6fr6IpYSXLEWD6DBhi0/H44rNwbmcZv6ZhAHW+3pDzVm1yQbNi7wg6g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362658819"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="362658819"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064804431"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="1064804431"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 04:37:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 04:37:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 04:37:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 04:37:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 04:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCjTzjGCXHwmKq0To87G7NtATi4HNQg/VzzgCJwa9LxMBrqP2V26pM6pd3mi8HSlfiUDpnv/Vbm3ZPRdTdQ7DP8dkLeLyW42h1gXhriGAkvzdSsXuqpZe8ysdQLxDRu/oy08bBDX2pxvjhOjalXAmq2BB3Jy2TxEAOgzsjKva9JNN53My05bK4RgAmedtcZb0kkmj8dFEdNPGl95Xw+r6OjqenubN5F7x0US5eI6xCwpjr+KxwDwrh98NOCiC6rtG4pv3KyCpZ475UcIL+COValYTI4NU5IZKA0Oi5R8Tdk71j0bcMsoVjnPiM7mKQIUCWpd4WeMER/rTkM2zqSNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXVFy3jc4GBpU9vm7jR1CK2qUzyRDWZhxeP0r7gdyjY=;
 b=Sv/ijRj8ccbKeK1RK4PB5oXPYJtzQzvBHXiKRtWIZoEa+lhe9OUnjOvJ8TfYqZKGUdYb8ts4aHEnjwovDZfBirtLN3NGJKTV4f3+ugcWtioHAXOZapC4DMZD3RAsnEAV4GJdfvdppBl7QlgS5KYcO4rgTmB68W7nAUESz+iSpkQN/MX8GjY1COvbyq7TBvRYAtVGJHADc8IeITfBUedUHIEy0LQZPOxbXg60XtLTXnDAfhX7nIzgJIgTkhkdjbwno5qiRhFllPDUD0CwkYWCY0Ei9DrJUAnzCnBM0qOTqGufKT4rX92gTbTADnnPHY7N6k57cWTcl6P2ljRu55v7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 11:36:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 11:36:59 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "puwen@hygon.cn" <puwen@hygon.cn>
Subject: Re: [patch V4 00/41] x86/cpu: Rework the topology evaluation
Thread-Topic: [patch V4 00/41] x86/cpu: Rework the topology evaluation
Thread-Index: AQHZzozqD/s3aV9d3kuE8IoFl6dtg6/sztQA
Date:   Wed, 16 Aug 2023 11:36:59 +0000
Message-ID: <d4a86d0c4a89a132f09a38e9b2b215f72ab3e7fc.camel@intel.com>
References: <20230814085006.593997112@linutronix.de>
In-Reply-To: <20230814085006.593997112@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB8316:EE_
x-ms-office365-filtering-correlation-id: 53c81a46-e88a-48cb-ab13-08db9e4d1a8e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Y0mkK4Hywih773CQEBdK8fTcGHbpFBv++zKCEH/0pxCf75LzN76R9B/3qd0HlP/RgzvMTwphipLiNAglxRDmDe6uBYYKZ/lAXrX9jAbQTmHPh79rnLsNDALkQBWooIODoEs8Ued6xGEctJbYBSsGUpVJtmK3X3HVPRh0PnyscLNleA4FKGWP2Vn7BpGMMhIwycgUMTDI4V/RTviUjxPj5h41y1UvutDSyubOEyKY5s1qGNdp6YIijlbFF7qpfM/+elBVSa9cmUarcGm0x7zE67hWOEP8/NEWfW2ZR/csl9cDNHVF2hopUUg/r2C8fd3qVz6kzcz7w1vjglNUu09sG8Y6aqehgqCcJro2+YBzDcj/6pVeaM6Dn+SYjeNjEaBU+zc9zNVfM12cF6CQAkgbjUElkzHVwyY4n3Ffo8QAEw85II4WDhi9XLMBwDVEDrv+wt+GULMF9PWAFS57rWAqC5gIsvy8Cr2PwnjIiMnIr+c9P2Vpvm4ynGZJHzbMIdrNkV0xhc5/ZSoXU96oOeiXF9XhPRfM9Z842Ib03+kdvxoVfKMMIjj99yiM+85O9ZzJPxcjaL1hBTJxb7DHbDZ/x9orLv3X7wIMA14r1cGKA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(91956017)(110136005)(64756008)(66446008)(66476007)(66556008)(122000001)(966005)(41300700001)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(26005)(478600001)(7416002)(86362001)(6512007)(6506007)(36756003)(71200400001)(2616005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZRUERBUlZNMzBhelZ6QVNLaDZHQkFXOVg2cFRLNzY4WFQrbkphMUpVYmdJ?=
 =?utf-8?B?eHNCRWt6czNpajlrUFFkSHNCTkpNc1ovSlcvbFEvaUswQmpDMi9RUEFCcDRq?=
 =?utf-8?B?QmZjSSswdVJ2M2hGbEFIMWsrL1JoaFZGSWdFUk5ZQ3M4YUNIcy9iYSsvSTVO?=
 =?utf-8?B?QndJd2d2czg5bzhLYS9HTVJmeDhZUlZVaFpEeXdZVDIxaVU3bFJqN2ZmZ00v?=
 =?utf-8?B?YUdFYU10RnJkWGVuTzVzamNaYU9PLy9KY0JmZkRjRmdUQjNTUHo4ZVF6SVFs?=
 =?utf-8?B?TGxoeTNXc2E5SHBoKzduUzAyVHFucHRCZ29SaFpKcEJqME5tWGlKanQ3WVlh?=
 =?utf-8?B?Z1BDM2RiVy91REtmM2U2NVRxZWlaUWx4UW1SNm1ncTV5RGdnQVZoVllKdXlF?=
 =?utf-8?B?N0ZKVFpRRzZ1b05odGZFVXNqKzdFd3JqR3ViQkVNVjNyaGtZMTVyTXlGekll?=
 =?utf-8?B?d0NoL2pjeGlFNzQrc0VjOG1WcWpYS2dHMWJqVXhmMmx2OFRsbzZXRHZ2ZlZM?=
 =?utf-8?B?UnBkZi9CZ04wZWE3OWJHOENYclppZGRoZ0owL0lVYzhhUk9IemdZVXE1R3Vj?=
 =?utf-8?B?ZUhjRDBocjV0MzlGOXVXSXBDdnF4Y1lSWkdPcWgxNUZ0bERFNjNSQXN1NnFo?=
 =?utf-8?B?d3J3M3kreWRwSUM1M2hxTUZydGJkSUl0UUZqUjNDN2dOeGtDVTE0dE4vUkcv?=
 =?utf-8?B?VUFRUWtFSWpQZUcvTUVBSXBudkd5czVWc041L1FQZzZRTlZVbGJtZFFmcEdG?=
 =?utf-8?B?anFoSWgzbXRhbXY1UDArVEEzZ2V3dVRDa3E5RFBHVStIR3V1Y3hhMzBuZjNY?=
 =?utf-8?B?Z1dQMG14UFlndjZabHE1Wlh6RXBja0FIbVc2UEVXc2pyOVAxUC9CaWFyNUNz?=
 =?utf-8?B?elQyU1podFd3eElMVFhrajNMV1JmSXhoTm12QVVvWGFmV3kvUE1wOEJuTHp0?=
 =?utf-8?B?TzlQRHdESHhaUW0weXhzNHpHYVBKWXBjS3hzd3A4bnlpbm90VnFCL0wrUzdH?=
 =?utf-8?B?dFFnd1czRTRERlRJQzhvazQxVE1odkdyVy9TU2tLMlp0U3RraFFGNldnQ29i?=
 =?utf-8?B?V0xxQlN1am12UTV3Y2NCRGd6enpzd2gweGdsYXExc0dmQ2M3dGI2eTBXc0Ey?=
 =?utf-8?B?bU1zM1pDUlBvYW1jS2pHNmMwcG5ld2MyZ3FPK0RMK3BKT1hqOUo4dFJoTXlt?=
 =?utf-8?B?eDNnenhRQjRVR1Y4aitHSlRnQktrT2NVWk13dk81UTFqT29tZGYwNUVWeStS?=
 =?utf-8?B?RGpvQU52cXp6R0ljRThWNnVua2ZCQmNkeFdiMXBCRkRKQmhjS1N3cUtPWXg4?=
 =?utf-8?B?L3RjZHcrR2Mzd0xoa1h5NjE1RS9ZUmVRNjBmTk5BNWdpRWpsZ0l5U2hRZE9x?=
 =?utf-8?B?WG5USStycXloZWNTeEQ0NWJWM2plTWVsQ1lkT3BEblExZnNjcGtUVXVkLzY1?=
 =?utf-8?B?Sm9CNTNNQUdzeGNPWjArS05SbzdvN3hmTDZLSitnYUhwU1NhZE1xUUhlUUFn?=
 =?utf-8?B?OERYWmwxTWRHNGZiZ0ZoMjJyemM4REJPQk9wQ0d3Y1I3WFkvWE9aS2U3SlVM?=
 =?utf-8?B?Q3RaVlEzcXBxVENkdmZNeG8xRnhqREFDMXJqQXE4SzhQMXJxeFd6QTVzTi96?=
 =?utf-8?B?VUU0bHRpUXY5RmxjQ3phMlNuS3ZLSjhoczBVS1RleEwxVnIvSE5XT2JORTdJ?=
 =?utf-8?B?aklOM1lGRTRCamVQdmZ5djJUdlJOUnQzaUZ4R2pVUm1ZMUdHSUlKL1pFMC9E?=
 =?utf-8?B?TlFhLzdhY2s2cDZqOGE4amFJWWlhRXg4L1Q1TDNRVitMdUEyZUVkVDJPRGw4?=
 =?utf-8?B?Ny9VdEVSQUNsVXJMNWlUMTh3UmI0NzZOZ2QvdTlNRENwTDFOQVJYY2p0Umxr?=
 =?utf-8?B?MHIvc3ZVREZsUGVSV3l1NDQ2Q2NmOHo1ZDVrQWZlQ2ovdHdrWVBHc3d4YlEw?=
 =?utf-8?B?a3A5L0JNZG5GL28vOEg1RjNuSlhsTUtLRE1VRTRWRVJlZDlmUHJOLzA1Vmoz?=
 =?utf-8?B?WFhHeUdQeWFNREFLUExOUXJaTmV0dHBWSklNZG5nRUI5QkxiYVJ1OW02S2Rm?=
 =?utf-8?B?eEtwUzVwM1BmNkRDUGRnNVQrZGxRbTFUWlNkOFhjc1RqdXROWVErQzJrSHkv?=
 =?utf-8?Q?KAZ5AVhiylPyxpopVqTvU2e0S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BBFA49A8F5C1143A420E08702D9C510@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c81a46-e88a-48cb-ab13-08db9e4d1a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 11:36:59.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9orqCRGhZJaec1aIgIOP+bpH32HTwafgNy2wjTBTme9EYEer3inaf7B/19yJcgDycO6WXhWiDcPP/WoQi/Lqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
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

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDEwOjUzICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEhpIQ0KPiANCj4gVGhpcyBpcyB0aGUgZm9sbG93IHVwIHRvIFYzOg0KPiANCj4gwqAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDgwMjEwMTYzNS40NTkxMDg4MDVAbGludXRy
b25peC5kZQ0KPiANCj4gd2hpY2ggYWRkcmVzc2VzIHRoZSByZXZpZXcgZmVlZGJhY2suDQo+IA0K
PiBUTERSOg0KPiANCj4gVGhpcyByZXdvcmtzIHRoZSB3YXkgaG93IHRvcG9sb2d5IGluZm9ybWF0
aW9uIGlzIGV2YWx1YXRlZCB2aWEgQ1BVSUQNCj4gaW4gcHJlcGFyYXRpb24gZm9yIGEgbGFyZ2Vy
IHRvcG9sb2d5IG1hbmFnZW1lbnQgb3ZlcmhhdWwgdG8gYWRkcmVzcw0KPiBzaG9ydGNvbWluZ3Mg
b2YgdGhlIGN1cnJlbnQgY29kZSB2cy4gaHlicmlkIHN5c3RlbXMgYW5kIHN5c3RlbXMgd2hpY2gN
Cj4gbWFrZQ0KPiB1c2Ugb2YgdGhlIGV4dGVuZGVkIHRvcG9sb2d5IGRvbWFpbnMgaW4gbGVhZiAw
eDFmLiBBc2lkZSBvZiB0aGF0IGl0J3MNCj4gYW4NCj4gb3ZlcmR1ZSBzcHJpbmcgY2xlYW5pbmcg
dG8gZ2V0IHJpZCBvZiBhY2N1bXVsYXRlZCBsYXllcnMgb2YgZHVjdCB0YXBlDQo+IGFuZA0KPiBo
YXl3aXJlLg0KPiANCj4gV2hhdCBjaGFuZ2VkIHZzLiBWMzoNCj4gDQo+IMKgIC0gQWRkZWQgdGhl
IEh5Z29uIGZpeCBmcm9tIFB1IFdlbiBhbmQgYWRqdXN0ZWQgdGhlIG5ldyBjb2RlDQo+IGFjY29y
ZGluZ2x5DQo+IA0KPiDCoCAtIEZpeGVkIHRoZSBvZmYgYnkgb25lIGluIHRoZSBBTUQgcGFyc2Vy
IGZvciByZWFsIC0gTWljaGFlbA0KPiANCj4gwqAgLSBSZXdvcmtlZCB0aGUgdW5rbm93biBkb21h
aW4gdHlwZSBoYW5kbGluZyBpbiB0aGUgMHhiLzAxZiBwYXJzZXIgLQ0KPiBSdWkNCj4gDQo+IMKg
IC0gTWFkZSBjb3JlIElEIHBhY2thZ2UgcmVsYXRpdmUgLSBSdWkNCj4gDQo+IMKgIC0gRm9sZGVk
IHRoZSBtaXNzaW5nIHUzMiBjb252ZXJzaW9ucyAtIFFpdXh1DQo+IA0KPiDCoCAtIEZvbGRlZCB0
aGUgZmFrZV90b3BvbG9neSgpIGZpeHVwIGZyb20gdGhlIGZ1bGwgdG9wb2xvZ3kgc2VyaWVzDQo+
IA0KPiDCoCAtIFNtYWxsIGNsZWFudXBzIGFuZCBlbmhhbmNlbWVudHMNCj4gDQo+IMKgIC0gUGlj
a2VkIHVwIFRlc3RlZC1ieSB0YWdzDQo+IA0KPiBUaGUgc2VyaWVzIGlzIGJhc2VkIG9uIHRoZSB0
aGUgQVBJQyBjbGVhbnVwIHNlcmllcyBpbiB0aXA6DQo+IA0KPiDCoCBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgeDg2L2FwaWMNCj4gDQo+
IGFuZCBhbHNvIGF2YWlsYWJsZSBvbiB0b3Agb2YgdGhhdCBmcm9tIGdpdDoNCj4gDQo+IMKgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0
IHRvcG8tDQo+IGNwdWlkLXY0DQo+IA0KPiANCkFsdGhvdWdoIHRoZXJlIGlzIHN0aWxsIGRpc2N1
c3Npb24gb25nb2luZywgSSB0ZXN0ZWQgdGhpcyBwYXRjaCBzZXJpZXMNCm9uIHR3byBkaWZmZXJl
bnQgcGxhdGZvcm1zIHdpdGggTW9kdWxlIFR5cGUgZW51bWVyYXRlZCwgYW5kIHRoZSBsc2NwdQ0K
b3V0cHV0IGFzIHdlbGwgYXMgdGhlIHRvcG9sb2d5IHN5c2ZzIGxvb2sgZ29vZCwgc28NCg0KVGVz
dGVkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCnRoYW5rcywNCnJ1aQ0K
DQo=
