Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670680E0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbjLLBFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbjLLBFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:05:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D04C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702343148; x=1733879148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JMdVWuAsAgPs8PnIQ2LhINinx9znBKH9To1fRSIFnFM=;
  b=ONYkfsRSfWxIuUlEcSNuzmlEn1oDcEKHcBDhW58xa8EyzAd9/D4WGOGX
   WOnhZ6Zu163w6bnRrCnFjRNb9kZAxC3WFUWhZ4pm90Q56weP53dsYCrR9
   5e6LnzVNx33Z6scUlKAR/CBdXFK6VGaWiQM3JQ5G7F3/lrXGMvag4IOW5
   zyBvbTE5EmrKKpYW/xiV5UYl2BnHQzIIJWQJFD00sE3HqVetrGZAwafWN
   czoixiy02RlQVr6BhmsYKA6aDbNx6rhojkO6q68vLs2JKQ2ZqhdctwDvy
   V0kxumGDEb7j1RjioWNK7jl6+YOhcMPBAJCh+TMhzxc+rhN+HJ+A1gRG3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="459047622"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="459047622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843715020"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="843715020"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 17:05:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:05:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:05:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 17:05:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 17:05:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnBBSBTrDXCVLdSdc2mzpppWaXIrORMyo9xTr+4305QKM1I4N4rC5eKg6sLi9qD7BszUCbr3AjoavMfh+0zpbuesecnKTOO2UIJVF0tyRihmvjrfmDpk6ne+Y/LXwY9Qn5s5lpIhsmLle6PvVrq8qvpNE7KNOeqaM6TVRC0TsJYQaiQpr/B3w9eJJdGlKamX5r2NNdE99eXtrckuPB1+W70Ei2uWdnpVx0KNApFI3dDuoLddK38noS+/CPleeQPbY0Jj4LK8276xeL1LCWrSWaSwyHTEOA9MMm5UhhVJDM7sr6odWBAO480kNnvCbwsV4pIvJZSMyjXAfWqybs8ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMdVWuAsAgPs8PnIQ2LhINinx9znBKH9To1fRSIFnFM=;
 b=nf8dk+zH2IzF431t4SznE27yXx7PGgRwlpE9bdNy/rrp65NG4o8+rfCfgTaS6GqqdKNRfk48D077/U5R/FoGaOvmJNSc4ygBIu2rl2Z02sdYP+2EeQ2WILI13SDNb6W8eeSWfjwtvASaMWM7fdvZ9B9YvbfRj8CmjaaKlI4+ZRHlvB0y3imyXfvNyAc+z2d1f+/9MACHGJj47kkhXxCOsGVx5x4iKS7VySM9xF800TfcvbEihdGZOVOKbPwDQliCRXVE81DA/frRuS4CdIacBKfYIBXySUCJJJd5B0I/JnVirqHzwIsT6QfbyxduFJFVKl6urNAzYqL0lsXy5lKAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 01:05:23 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::64e:c72b:e390:6248]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::64e:c72b:e390:6248%7]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 01:05:23 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abaci@linux.alibaba.com" <abaci@linux.alibaba.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH -next] x86/virt/tdx: Remove duplicated include in tdx.c
Thread-Topic: [PATCH -next] x86/virt/tdx: Remove duplicated include in tdx.c
Thread-Index: AQHaLJORcvH6AQ8RFE+nBSh1oPx5trCk1WYA
Date:   Tue, 12 Dec 2023 01:05:23 +0000
Message-ID: <9ad5777c3cc885194f3fd634c1bc139124062256.camel@intel.com>
References: <20231212003825.70297-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231212003825.70297-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|SN7PR11MB7090:EE_
x-ms-office365-filtering-correlation-id: 49e327e8-9457-4514-6ff6-08dbfaae6b62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkvmEfLQ/dCrbuQUNDVSMu9o7DEg1Wolx7CzM9NS5RXVHoD07XCVDK2SIIiwF4bLhNU/t+41ljGK0p2jzl9/mVNApG8U4Db1oNYcQ7mIGn77cP/otgrK0MtDUMzZI6iBh9gXzuR3L1ItYDIffZxQaMSzZotiUL4ocvSAMrB2hjhY9H6g6+XZcpf+Q73oALRD9mAlPQI8oLsowq+ZbOVxVXjYFUC+YGnW+dzSsOi3DQHJrDFri1dXgviO6PLf9bUCAAbM5IC4YNjx72iQqOpuQUUTIrFubnVyPHSpESploZegfQIL1Ht9MGrli/ef4r2thdAjGud1TGUDHTEUiV6Z156Q8BcgYsGSNTilm5UZkrKFf9YlArPtzKHGvgPeIVjeTnjpzul/YCTs27v7Un2kGmhPOuFvey1jOItDu4hffNIVsvC9mP9zLzEOXPWhFDkJTZKc7t7fWGWwGFyFuQKBRBScZY6NQGDOkjrHM8HY5XdC3I8A3yusf028DQxcMwJSZV/MNoeG9Vq4K8uY7Kh2WsHXdxxr8ytwZOUY4aihoqbkmNGPqyNHhHVf7KrXE+xJxIrMOcKTeGlhQNO7KxDHtXFb+WRLc0YFa8R8TqWMvUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(26005)(71200400001)(6506007)(478600001)(6512007)(66476007)(83380400001)(6486002)(7416002)(4744005)(76116006)(2906002)(41300700001)(5660300002)(66946007)(110136005)(4001150100001)(91956017)(66446008)(8676002)(4326008)(316002)(54906003)(64756008)(8936002)(966005)(66556008)(122000001)(38100700002)(82960400001)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJpNWU4OWN4MjJLZlIvN1I2dXNSZTl5dXJLd0o5dmRuV1h1K2R3NllHOTNV?=
 =?utf-8?B?YTk3RWdSbVU5Ris2aGJRN09JQlZUL2Jnd2prU3doTjZqVFdqSzF4MEdYcHJW?=
 =?utf-8?B?OWlBaFR5VjFod3VBSnkyMGpYZHduUWhlK3BUZVYvYVFWVi9FNlJRWUkzUWhD?=
 =?utf-8?B?OTEzZWVpd0ZqbGFVaUNmZVlFdWFtUUVtcUp5TE50ZWpGc2o4UHprU3BNaFNM?=
 =?utf-8?B?UEMzYnZSNWRPcTcrSzNIQ3pqQ3M1Wk9YMXZpY3U3elRxSWRRTEIxb205bWxI?=
 =?utf-8?B?aUJzclh2R0drS1MzaVM2bXB1dTNyQlM4YnFMb0pTUjc5QWpWd2ZhbHdEc01K?=
 =?utf-8?B?cXNpQWRSRk9NK2F4TkZvbldaZzNNZlV6MS82SS9CSnM4MzJiWHk2MXFIQnVo?=
 =?utf-8?B?dVBRSmFVSm04bGx6QndrWjNES1l2eGpSSGc3dkoyWFR2SUZDVHREMVVTeS9k?=
 =?utf-8?B?QjYvdkd6QmVtSVZ1eks1dFFNM0xwaHB1ZnNidTc0THBIWG1seEZrZ01aM2Zl?=
 =?utf-8?B?enN6UmJTQitzMWRVVUc0WDVTS240QThhUG1kOVpJZll4amwzTEdYaUZGMG5a?=
 =?utf-8?B?KzA4UkhBZ3lLUlFQYWI3c2RGZmhOSUxHMXNodzlrZzVGdHdYWVNsNVBoM0Ey?=
 =?utf-8?B?MlNNYXN1dk9YM2xYR2hIY3NUQ1o1L2J2REFYL3YvOFZRRGYzcHY0YnN5Nk1M?=
 =?utf-8?B?S1FRS3dPbFNTNEk2czI2TmY4YjdHRC8vbndyeGpMci9BajNiWmFrZWczYk53?=
 =?utf-8?B?VGx6SVdrdFFsM3FhTTRHbXhHZ1V1cFNsVjRudllqYVVlQkJUWmJaS0dyeXBv?=
 =?utf-8?B?Sm9EYWhGTnBUdXVuVXNhdEhnUUlicmZoWDZHVks0dUh5OWhyWGxoeUpiV05a?=
 =?utf-8?B?VEtGRXV5LytIRW9nNGY2WjErVXA2QVhHazFqdUZGcEtEbmVzZDdDSTlOZXN6?=
 =?utf-8?B?MG5oV1ZRNWt6UWxMdStrR05WcktUNUVSR1JicUdzeGczU1RNZU5yT29oWSty?=
 =?utf-8?B?czF1eThPM3o2RERSSlhxM2pQSE5YYll0a29qcDBxUGE0MkZRRjgzSFdINlFU?=
 =?utf-8?B?VUFaa3JUb0Jtenc3ZFQ5QXRIZlRCek9TUVFDSXcvN2dRRnduRjh0Y1NPaDRn?=
 =?utf-8?B?eFZacmNvcDdDU3pSRGtWRmRobWhpOFJtRWx6SmJMc1ppdmgzMHd5R2FQR2ow?=
 =?utf-8?B?WllZS1NuekVMaHhmOEtuMVdRQlRqbWxIVnVaN3ArR0hHRnMzb20raDlrMkJP?=
 =?utf-8?B?elNSMk9pUlU4U3VYV21tdlNxSCtDelVYalloWlRTT1dHRFRjVHo1aGxLQ1V3?=
 =?utf-8?B?NmhvTUhUK2RzMmV3UXpnemJBcDIvaFUwb1ljQ0R1ZTBQTnNsMzQ5Y3lQZnZv?=
 =?utf-8?B?Qm4rUllHUDNvYXB5KzZ4d2JlOGE5Rm9XY2p2R2Q5eG1ZR0kxL1ZFdERXTlhs?=
 =?utf-8?B?NWhtQ3BNSFpTb1NmUk9qQ0pGK3RGUW9ubEVMay9pOE40dVVqYmtLLzBQUi9J?=
 =?utf-8?B?eXc0MHBDeUVSbHIzSkloUko1czFDNjF5SURuRkQwbXdVMnA2U1lsdC9pd0E2?=
 =?utf-8?B?V216V3JSV0ZTRnJoQ000blNWRnVTRXAyRU1rdGdFdFdZZTZPWmZPa0piVXFJ?=
 =?utf-8?B?UVdORE92OERodEVRSElydUFJdjh0SzFhT25TZWIxd1Y2TXhnNjhTWGQrblQ0?=
 =?utf-8?B?ek9yV1RURzNMNlYvcm5jcVBEYnBOeGp3RzJkUEVBWlhxZ3NmWndiWGRKSk9t?=
 =?utf-8?B?aGJuL0xJaUY0MzBBVEZzQkR2cVliUFVEMy9LYUR1c0pYZ083d2JZbFJsWHd0?=
 =?utf-8?B?OTEzUjh2OXBGa0JWWlNTSkRmdlRta3hzQzBZRkpNSXRGR1EvOG5ac3I3Nm1V?=
 =?utf-8?B?cWk2UmNRa3VMYW9kbVJoM2J0cVRUdnFuc1ljYi81cnFicEdsN3IxVkhGcFVT?=
 =?utf-8?B?emgyK05mTGN5MllhL2Nua0FFd1pWT3c5bkpQcmloQ3hJT2NjZ09QejVERk42?=
 =?utf-8?B?bHcydGdtTmY3R3dzZVVlSXZnY1RIRHIxclQ3Q2wxUk5JV0w2c09zdEpEQU40?=
 =?utf-8?B?R2E0NGZCUTYwZG5JaU40WUpwd0w4a2dDOUpNRXpINDVTTzJlODNWUXNvRmc5?=
 =?utf-8?B?U0tuV1pWNXZiZXg3aW1veDY2SXRHdCtVUVJQbCtKaEhsQURnRFd2SVV4ZnRP?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C75C8327E410C441B4ACFDF6638E0C79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e327e8-9457-4514-6ff6-08dbfaae6b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 01:05:23.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jb19u7ywABjtidd2W6o5mFbm56/5q6ln1oHQleIvt2B+L1KrLIIyH2ZfdJewzWRSx59/mfS9OnTpluKTMl3zWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEyLTEyIGF0IDA4OjM4ICswODAwLCBZYW5nIExpIHdyb3RlOg0KPiBUaGUg
aGVhZGVyIGZpbGVzIGxpbnV4L2FjcGkuaCBhbmQgYXNtL2NwdWZlYXR1cmUuaCBhcmUgYm90aA0K
PiBpbmNsdWRlZCB0d2ljZSBpbiBDLCBzbyBvbmUgaW5jbHVzaW9uIG9mIGVhY2ggY2FuIGJlIHJl
bW92ZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJh
YmEuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEub3BlbmFub2xpcy5jbi9zaG93X2J1
Zy5jZ2k/aWQ9NzcxMw0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIExpIDx5YW5nLmxlZUBsaW51eC5h
bGliYWJhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNv
bT4NCg0KPiAtLS0NCj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDIgLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBpbmRl
eCAxM2RmNjhlZjQwYjUuLjQ5YTFjNjg5MGI1NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBA
QCAtMjcsMTQgKzI3LDEyIEBADQo+ICAjaW5jbHVkZSA8bGludXgvbG9nMi5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+DQo+IC0jaW5j
bHVkZSA8bGludXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQo+ICAjaW5jbHVk
ZSA8YXNtL3NwZWNpYWxfaW5zbnMuaD4NCj4gICNpbmNsdWRlIDxhc20vbXNyLWluZGV4Lmg+DQo+
ICAjaW5jbHVkZSA8YXNtL21zci5oPg0KPiAgI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+
ICAjaW5jbHVkZSA8YXNtL3RkeC5oPg0KPiAtI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+
ICAjaW5jbHVkZSA8YXNtL2ludGVsLWZhbWlseS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9wcm9jZXNz
b3IuaD4NCj4gICNpbmNsdWRlIDxhc20vbWNlLmg+DQo=
