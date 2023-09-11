Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFA79C27C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjILCO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjILCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:14:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E19AF7A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694471955; x=1726007955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=czppBiHg8YQm6Znsz5cIv2pFO8AjWq+mzgG2xojWtuQ=;
  b=Kc2MHTXYRNEd4vESFWALH5k5xxnK+XMDF9KsjX2Hu7ZBNJbTjS6JTpoC
   HWGd3NDH1P8ytR6MZya+Bwq7b3lkRfexyi03lL7J/UydGN2Tc0Gg9fIqn
   aAku/qk0+tJ02FZx0UC1oXlKVFXrXGHZ0793uC95wWZlfKRL/+d9ofQag
   WRxiYkeX6b4jg58AgXDT1sVx3DJI/tXM+CXEjojvldebCF3mnJhiDGO13
   Zztr+T2cHCDFRsj7xfUGMtSNH6EV0o6aslWElr2fELRTg4Fm+1UW7b0Xq
   e0jA+1H8oPL4CJW5tFdNDOyu23vwN83mUVORT2kyRWW9mLlDEDOsMoiPx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409181310"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409181310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917190912"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917190912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 15:30:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 15:30:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 15:30:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 15:30:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VejnjTj0QhqkrPaf7Al1sb2V9eV/67gWv207007hyt+HUMmzqdoNLK4dWpp6DDv8bPcK52bukOjyPpGjX4DiGHBr8a6wXWe8d0rPagCunr7bb1tklambbXI7HTEittXxbNegRKJvgD7onlonJ7lxMy/0sCtlfAraIrjWay5jQK+gk8KMMTmYffGvTaiv0I3GNyMEGtWZJr3RRzwgz250MVYv4rkekYY/JU72bmSIL9VNseI1LR6G8KCYdU/hdoIOrxWuK3ajdYG0H7fhDx3Kc/1e7zNPFyr2uNofQvYonYydbyyOsc0v0OToAeg5qWU7Zsh+7EtVw/H5pJesjWgKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czppBiHg8YQm6Znsz5cIv2pFO8AjWq+mzgG2xojWtuQ=;
 b=B6KMXpvvdL7y4Efn7FrIZFTCDmMWsPMXQexuvnTFDglc39Wvn+dw8B4BJ4krMXuQash+WAlGG3AZmJxoChwqUSvi+5nIPpn3VTAZZgHBmifoqTHC5IrW9ukIyD8TMga/WGOOG/o8spUxClyozn+qrMPrRU8e6mI6Ltscspz0qpTn5Q7dlDPD0xNe3WojyPgks7Ok02+pmGV+Z/dI08T1lBvdqJ9pEvoq2I7DCduomkfO6obeGfQBjBLFNpCKjJNhIGVbZdS43ro4PeACv2ZDPkEWtn0PmnhEvLX8G9X+QTNg8GQTRN1pMttV44z+DoVHA7alKUtHs4Vs8NKHz3A2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 11 Sep
 2023 22:29:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:29:59 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZz2d2h64fZccrFk6GvcmTUnLRhLAWBmaAgABZxgA=
Date:   Mon, 11 Sep 2023 22:29:59 +0000
Message-ID: <f94aa81502421f169806c1349efb28c74878ea46.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
In-Reply-To: <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: f0ad6d6c-7ca4-4fe0-2c45-08dbb316a24e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXFX8EwG1aSYaZIP+1NLHIjTwuARPTUh5WWeiHrJO7+phMqD6iW51ibNl1vRy7LNUNRLOctIobq4DPBulsngHnQQRRIGjCZEkfWeCHo7NmoyI2C1M+x44z67juh3je0OhC+8RoU4f8UXG+TFhN0UeNmzGj8CZewc5fOKblFI0b9kQFMXWm1LreNV07Cnv6QwxSu5BbWznNQxYMQwgY17p2ZuJoLwWbR+FzvqHzHmqxaRRJBnXrxUkPbkyPvyUGQpN5s+1bIgtjGVpGKsYE75smZ+wkcAqSJNNAmXowmYtiRowrsXTHOWXFs1eaX2BvHsjs29+b9q+S6g0j+lmeUssxccwvq7Hh5G1ThMtYxVa3daOhdSE+jY5y306v6nKPYbrzPbKzV8YrVpydYxFptO0ASm3zcIzLEtQ7KzIVlhcGtXwTMKL32d4ouajdj+FrQwC1W2qK+AdCZfFhyn2frH4bkZZYL3WtJSt6HhRRBihM3Mwn/2ElnBAWI0oq3im2ooFcMmm+3yHLEVqEeQXmM2DlCVlI4g4N8YIwZ7bVsVxfXg3BAn1QKbKXcLcqKIrDN4/Tf2pHqRcj7sqIyrAbj2wr9AzMrlzQ0A400GWUNMpi2ytxzwtytO7WbprV2gU4BX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(1800799009)(451199024)(186009)(91956017)(66476007)(110136005)(66946007)(2906002)(54906003)(316002)(64756008)(66446008)(66556008)(7416002)(76116006)(82960400001)(38070700005)(122000001)(71200400001)(478600001)(4326008)(5660300002)(83380400001)(8676002)(2616005)(6506007)(53546011)(6512007)(6486002)(41300700001)(86362001)(8936002)(26005)(36756003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRGZGNaK0Q3RHVPWkNTeVlvOUNSSUlPdXpGSWNLWnpyUVU3R1pTUU9RMURk?=
 =?utf-8?B?NHBPck5hamZMaHRBdWFKUTNoL1hHU0xDNXRvSDRINmdLcWNjVWo4a01sTDg5?=
 =?utf-8?B?U0JJUUFYWXlCS1VoZ2g4aG03ZzcvUUkvc0t6QkZPM01DcHVzeHkvY1JjOWVJ?=
 =?utf-8?B?a2RxSVE5SE9yR0Y2d2ZOT1lmQUJhMHlrMkJ2QjZBVUthRGxmUGhLUVNGaHVk?=
 =?utf-8?B?TlR5MzNGeEp6TFF2MWxPcGNvYzFXbUhWWHBwRHNnYlNiUVQxZjBtZk5HR2FT?=
 =?utf-8?B?UmVuOTF5a0VPQ05MOU93Q2Z6T1locHdidU1lSzZWSVREWmw4dEUzeVlYY0dy?=
 =?utf-8?B?Zk83b2tDdGRFNEEzTkdxd0lWQTc1b2V3czN3SWMzc3l3YitlMHhmRHl3SDhu?=
 =?utf-8?B?ZzJRYUIrcGhvN3R0VENVdVAwZ1FqeUxsTStzcjhCaGJlbW9icUpNeGJkcUdr?=
 =?utf-8?B?RzdiTzZ2TXlzcXdIRWk4RjVoaDZVUlVuR3lMY0t3Slp6NEFneGkyR2t6eFFL?=
 =?utf-8?B?d3hWTjRNU0x6RzVwQzl0ZUhUeTJtWGFrN1FQR25EU1I0MjFqSldBeSsvdUtz?=
 =?utf-8?B?SFVrMXVFZm1xclRuWkZLNkVCM1NKemZMajVtcFU0YVBiMk9PaEF6N3p3UWE3?=
 =?utf-8?B?aDV5TXdnbWVUQlowRkxZbXpBbGNSRi8vTC90SXZoQ2FReENqSjcxbERpQW1Q?=
 =?utf-8?B?Tmg2bXJYQXlDczU4Q1RYWlAwUHZaR0dmNXBnb1RsUms1SHNBUENRVTdnMGNS?=
 =?utf-8?B?eXFsTVhBWHB1Y1ZCSThNVStOcDYxcWZ6UDkyZW9RUmNJVTJTTnp3ajRtMS9H?=
 =?utf-8?B?cWNSUDNzeENZVUVHK0Y1ZHQ2MlBrQW9Na1ZSUHh0VGNoU2tjUEFhRTNWT2l4?=
 =?utf-8?B?RlFUMlBuR0tnWWg3L1QyVUJMTy9QVVF2MXRaZXprL2hwRnlPSHNzNm8vRnFp?=
 =?utf-8?B?eHk0RWgzblQwdm5SR2N5Y1FIbnRqWk9wS1pwN0N3aVBXZHVHQ016Uk16d1VE?=
 =?utf-8?B?Yk5aRlh0WVdIR3UwN3JIVkhQZkY3QXRpWmk3VUZFYXkrR1RNZkhjbEhpOTJk?=
 =?utf-8?B?SzMvVDVNM0RlV3ZCbzVSbzRJZko3ME9UMmNQQ3g5dkNyUTBmTm1qTzYvOVVq?=
 =?utf-8?B?RU9ZUzJwYU9EMnVCdEVMMHJhNzIwelZ5Q2FEOExMZ29EL1B0NEFwOVpxRzd0?=
 =?utf-8?B?Qk12TXgrZlBRUHVYSTNEL3VjWkVtRU85bUpJWGZ2WlR0aWhDVjVXOWpoV0h3?=
 =?utf-8?B?dndVMGN6eGJvMU9UazhOZzNLTmFpdUxSWkYvWHc1SzZIMzcxRFQ1L0VMU1Bp?=
 =?utf-8?B?VWdYTWFCVTFSMy9pd0RBK2NJVFE4aTFyVEJkQkdUSmZJS3J5SGVNMkNqejJ1?=
 =?utf-8?B?UVN1L3VMSDNZeFArelQ5YTFxd3B0bm1JMGxNNnowb01wMmJIMTNjWGxYQVFJ?=
 =?utf-8?B?UFJhVklPQ2dsWGdUMkJUSDNEbWJsZlB5Y1l0MGtGdWVvcFZVbWg2WVFrWE0v?=
 =?utf-8?B?ajFKS1MzVkRNMmZ4MnZrZi9hS3FtQ3M3aW9kL0ZqaEZncjNRQkFHU2dualM3?=
 =?utf-8?B?cE1pS3g0em1kMGZweDNhTDhTZnRSUlp4cDR3MVRoMVNVUVNlZ3FidlM2Z0Ez?=
 =?utf-8?B?aFRqK00zNXhuSkhTWDlWQVJ0WEczRml6ODhTN1BsWU5xZDZoZDN3QlFLSFJz?=
 =?utf-8?B?dGN6Y3VkWmhlaUt4cmovOHdZZ1A0akxYUTFLNUxiZ2FxNkZENnZsQ2gwV250?=
 =?utf-8?B?cGUwcEMzN0k3dGpjRHQ3dG9pd1VyNTgxNjNoay9YWm85YTdNQVNkU3EzYlFo?=
 =?utf-8?B?a0w5UFZRY2dBRkYzbXNaOHc4MFdYcCtFK1V5dGwwSDFlM0ZGODZmTjh1Rktz?=
 =?utf-8?B?RHZ5anJmUnVzcVRuSjQxbm9ueElsSkJuNmhjYkFXdzZ6YzBPV1ZFTHc3dXBM?=
 =?utf-8?B?K3hEMTVvMmg3K0I5amQyaHB6Tkh5WU1lY3FyRVZQbUpNTExMK0VVWW9nKzZ2?=
 =?utf-8?B?TFpxZGhON2xvUkorTVc1T3NhS2pNczNMQzRCalZQU2hjSXZJVk5sVy9YMzhq?=
 =?utf-8?B?dmZsaTRNRGhxYXVsclkrTk9QMlkxcVU2ZDNpTUN5VjZSc2ZGcDNTQkpDRjRt?=
 =?utf-8?Q?9jcRXx08JMVZ+rlN/UoWlpojl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FC88724F54BFA44B9BB56FD117F7FEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ad6d6c-7ca4-4fe0-2c45-08dbb316a24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 22:29:59.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p94zzTTABdU8u5WtENX1tDBnILMnilUKnDA4SDK/TDk08MAEGXPXlNcz1mUeqAXCdUXIHsz2zJeus5kPFDruEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
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

T24gTW9uLCAyMDIzLTA5LTExIGF0IDE5OjA4ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiA4LzE1LzIzIDEzOjAxLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gSGkgUGV0ZXIsIEtpcmls
bCwNCj4gPiANCj4gPiBUaGlzIHNlcmllcyB1bmlmaWVzIHRoZSBhc3NlbWJseSBjb2RlIGZvciBU
RENBTEwvU0VBTUNBTEwgYW5kIFREVk1DQUxMLg0KPiA+IE5vdyBhbGwgb2YgdGhlbSB1c2Ugb25l
IHNpbmdlIFREWF9NT0RVTEVfQ0FMTCBhc20gbWFjcm8uICBNb3JlDQo+ID4gaW5mb3JtYXRpb24g
cGxlYXNlIHNlZSBjb3ZlciBsZXR0ZXIgb2YgdjIgKHNlZSBsaW5rIGJlbG93KS4NCj4gPiANCj4g
PiBUZXN0ZWQgYnkgYm9vdGluZyBURFggZ3Vlc3QsIGluaXRpYWxpemluZyBURFggbW9kdWxlLCBh
bmQgcnVubmluZyBURFgNCj4gPiBndWVzdCBzdWNjZXNzZnVsbHksIGFsbCB3aXRoIHRoaXMgc2Vy
aWVzIGFwcGxpZWQuDQo+IA0KPiBOb3Qgc3VyZSBpdCBpZidzIG5ldyBpbiB0aGlzIHZlcnNpb24g
YnV0IEknbSBzZWVpbmcNCj4gDQo+ICAgICAgV0FSTklORzogbW9kcG9zdDogRVhQT1JUIHN5bWJv
bCAiX19zZWFtY2FsbF9yZXQiIFt2bWxpbnV4XSB2ZXJzaW9uIC4uLg0KPiAgICAgIElzICJfX3Nl
YW1jYWxsX3JldCIgcHJvdG90eXBlZCBpbiA8YXNtL2FzbS1wcm90b3R5cGVzLmg+Pw0KPiAgICAg
IFdBUk5JTkc6IG1vZHBvc3Q6IEVYUE9SVCBzeW1ib2wgIl9fc2VhbWNhbGwiIFt2bWxpbnV4XSB2
ZXJzaW9uIC4uLg0KPiAgICAgIElzICJfX3NlYW1jYWxsIiBwcm90b3R5cGVkIGluIDxhc20vYXNt
LXByb3RvdHlwZXMuaD4/DQo+ICAgICAgV0FSTklORzogbW9kcG9zdDogRVhQT1JUIHN5bWJvbCAi
X19zZWFtY2FsbF9zYXZlZF9yZXQiIFt2bWxpbnV4XSB2ZXJzaW9uIC4uLg0KPiAgICAgIElzICJf
X3NlYW1jYWxsX3NhdmVkX3JldCIgcHJvdG90eXBlZCBpbiA8YXNtL2FzbS1wcm90b3R5cGVzLmg+
Pw0KPiANCj4gd2hpY2ggaXMgZml4ZWQgYnkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLXBy
b3RvdHlwZXMuaA0KPiBpbmRleCA4ZjgwZGU2MjdjNjAuLmVmZjUyNTJlOWM4NiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLXByb3RvdHlwZXMuaA0KPiArKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAg
ICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiAgICNpbmNsdWRlIDxhc20vY2hlY2tzdW0uaD4NCj4g
ICAjaW5jbHVkZSA8YXNtL21jZS5oPg0KPiArI2luY2x1ZGUgPGFzbS90ZHguaD4NCj4gICANCj4g
ICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYXNtLXByb3RvdHlwZXMuaD4NCj4gICANCg0KVGhhbmtz
IFBhb2xvIQ0KDQpJIG5ldmVyIG1ldCB0aGlzIGlzc3VlLCBub3QgZXZlbiBmcm9tIExLUC4gIERv
IHlvdSBoYXBwZW4gdG8ga25vdyB3aGljaCBLY29uZmlnDQpvcHRpb24gY2FuIHRyaWdnZXIgdGhp
cz8gIE9yIHdvdWxkIHlvdSBtaW5kIHNoYXJpbmcgeW91ciAuY29uZmlnPw0K
