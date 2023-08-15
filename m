Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4777C652
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHODRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjHODPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:15:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3DAE52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692069321; x=1723605321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PzK14FzMnpcTGlmWdkSB/fJY1hheqrqmonUeooIebaU=;
  b=UtVT0o8NUNyOgNJRkCsgArJ8Rz/9FvBHfBcGmP9y19g5jkiHJBqpyKY5
   d5fw8ucknRJoNsqpD5JN/OWPs7FVSdXlDQ2AJ1ygw/QAyeed6zfZLvTHZ
   1fKzyYcY3cDdH2Wjx7WMMHAe+d/9FzPoNgwayNBzFYCD+Kl0wis9SY92q
   hEujOwODsT+MwIhvwyao5JDTThlVxpIYxN8jmq4fdAAYeOc6DjGOfYRrb
   KjtHsrDkhy8waJ3E4CUxN9gLvFALuNUXXosuvm6Q0FVCU0Su5OfxVl6lJ
   UVmo/TVIsOjA3i3SmIrHEW8whMZ6Kyd9djzByoetPFiB1ipSE3TvVdmSl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403171449"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="403171449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 20:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710573685"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="710573685"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 20:15:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 20:15:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 20:15:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 20:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFKO9IXW2a20itcHRCzN8sUaGsWRHfu/HHlZAERz6CKyEag0ImH7vkckAqvvN1OgC0yM9lyFKJfiNqd+EzBSqK4guDka20Rzfhbvkk5BNQfqOV8t0WcEXES50BEMmOU6/KhbXMfmiD4HjZJXduep++pKvACt7ogYw+nMmr1Ct9arYjWUwEk8dBChQob1a1B+9CBrWLb9fof81Oi0MEYgf6YP11krhJrYY7KxCvqNY/RlFF7v4+Hlf54l7cNY+Gvgv4C498VgcnJqRAe2tkfaA0j4ff9IwDBWComWV0vEOTWMHfj/ykL3/WyDLWxeXZi9A39Wud9JXPKyWw/IW0YBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzK14FzMnpcTGlmWdkSB/fJY1hheqrqmonUeooIebaU=;
 b=BQXaR2bX56/0EiGiLCcLlKnGtCNRU/N7GcOUdZYfE0DesbqExovaIp3/PnTZ66VNQRP52PuthljFjvGiHOveLCURpaVz2hoz6mlWLVSvo5h0a2eTlCocYrs3JeQzO7eTYh5z/94iSGNeMeHcKixvxLBXEC9SIsjfkdg3CpRx4E5fgr7EFvMr7coJW9SQS+AkbwmvOIDlSYn7lcYipjW4wmXMR3t7J1Y1V1uwjyR6cMaxWT6Wo5UadFf3wU/6rFFP3gQrwVWvS9Cg7yz4e6ExwB2S2X7xcUf/vpiZVctzJvpKwwVLxjwlOW50n/Mi7ESSawi+9n4AEZCm4lnlsJll6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4797.namprd11.prod.outlook.com (2603:10b6:a03:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 03:15:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 03:15:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jie Ji <jijie.ji@linux.alibaba.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
        "kaijieguo@linux.alibaba.com" <kaijieguo@linux.alibaba.com>,
        "daishengdong@yeah.net" <daishengdong@yeah.net>
Subject: RE: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Thread-Topic: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Thread-Index: AQHZzqiOto4tPD4iOUyuKbSpwIowhK/qnL4AgAAQEMA=
Date:   Tue, 15 Aug 2023 03:15:15 +0000
Message-ID: <BN9PR11MB5276CB1BFF85D1569B1D863F8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
 <4b356a28-5637-d492-9540-d7f5e6c617ec@linux.intel.com>
In-Reply-To: <4b356a28-5637-d492-9540-d7f5e6c617ec@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4797:EE_
x-ms-office365-filtering-correlation-id: ff8f034d-c705-43ba-27a0-08db9d3dd87c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFxHBqKL41JZZnSohq8xwg/PczLyVyXFEHc4eLdFL0MPijyvPME1YigtVJkMB7D7xBD1B0GRjMxpMsQ9dA3ZcbyARyDbJejPphTrCc63EYe9clqV352amAPHWDBCBhK9PEQVCoBVFVy3OjgnbDCJMqii6H5oo8vngZnYcEEdsbqIWu0qQCjergctsCaGNw86mO25zaWIHd3UWbJXAZgnnQWH0v5VQrx3VbaI5lp6d7WSGLcLdurNCXC50Nh8pLLYCBvTsN7WTaA03GNIXJRJy+i9obrXl0nBjR9zb34cKs+K7foaPGTOs0j+eX5xaIqTc87inqdlKR8ZUx8xAMobBRdenli2xpjE61RmK0/F1WiT25sw9Z9urfSiv6nOKJlBQaU6TjTOWDKhA+rxH6PGsgXw1POBQJ2H5kJWdIHA0fX7zOlzdb7HrYOTq/BeMBoyoxfcz8B7FrBM1Hm/Kj/s78omBBg3n/94hiAocNhjuSA6PpzG98i31Xo/BUTl8jZnEvQH2z2pWt8tannJ5JuSzVpqs972IsTgjOvCLD/Q+HS/R6C9xY//iM0usyyiEFs4VjO1w8AReu4wC/1uk8QpA5QLxbJN5ejRalJd9mLC/2GG+mdaShHGpqDbx/1aJ2Xs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(53546011)(7696005)(9686003)(83380400001)(71200400001)(52536014)(5660300002)(7416002)(8676002)(8936002)(2906002)(110136005)(54906003)(478600001)(316002)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25mYmY1NWNpSXVjQkI3MXF2cWoyTDFVd3NtTUR6YkhLWm1oT2xoUE5wSHo1?=
 =?utf-8?B?dkM1dTVUQWJIUDFWMmlQSXgzbU8rQ3YyY1NhRjM4SVgyL3BSUXIwclBaUDVj?=
 =?utf-8?B?MytDamovaDBtd051SE5vdE5weWhmOGZzWFNVV2dlSzU3SUx0UGE3VXZOUnJu?=
 =?utf-8?B?Wmdoelp3RStsU0xQK0V2SVp1T1JDR2VoTjljUHVEc2FkbmpaTjJvREZlcWtt?=
 =?utf-8?B?OFJzeFVHdjNvTjZDTEJEODRQYTNWbkZYcERkTXNwMUMyU1J6TFpLYzE4aXNk?=
 =?utf-8?B?b2g3YnRDNVdFTWNvRWNxd1RMV0sycEtTTVREWE00eXVocmE3QmswQUkyQVdW?=
 =?utf-8?B?L2dZZWxrZEhGN2xDbmtQNFV3SlJwa1E0VGtXZ1p2a3NOckxLVFpUMEVVL05B?=
 =?utf-8?B?a2JoT2NkR2tvSVhOdTVOVzZqbXlmMGpFeDlsbDZuaDZ4NERBeExwQWJuMjEy?=
 =?utf-8?B?dmhpcUxyV2JjejlFM0JyMFpxZ2YzOEoyOFp3aDVpWmVXZnc4UGxwSGhFdGNt?=
 =?utf-8?B?eCtMZjBDMUhSalRaOERlbHRqenJWbjdzaWVBTUxIQU5vZVUzaktMQVQwMHps?=
 =?utf-8?B?SS8rN3JoYmZtbWw4SWVkV3VLUGVOeDFrRmlHVS94ZlVvVzYwMXRwZXlFRG90?=
 =?utf-8?B?K3hPQThIUVhVTXB2U2gzcG0xcEpGck1KdllWVjRZVUd5d0lndXoram9wSDRh?=
 =?utf-8?B?OXF4Q2R3eE84RGh6b2dtRDJjdk9TcGlxcHQxbHF1Z05VRS9HQm1JcFBYZGRH?=
 =?utf-8?B?MWhveXpHRVBiMERjTmZhdU9TdWF4TnFqa0Q3cmw0RWxnTUZwQ0NybThXYmhM?=
 =?utf-8?B?c0lwYnU4VHRxM1V6N01sWFZ4WmxObHc1Z2VDVTlkbE1yb3NZak5tNE4rL2FQ?=
 =?utf-8?B?TEN4SE9nOW41WHFKOHhEY2N2WTNUL3VxekVhNlIyZVdMSzJBY1U4cDZ3SFRw?=
 =?utf-8?B?ckRUVUM4dGFzdzNXYkhiYVhFQUtzRjBTRWh4T29pbnBtZmVRUC9wN3VNMkRk?=
 =?utf-8?B?Wmpjb24zckNBZnhpaXVJeGRXVW9VQnFFcEtBN2xHVFlLbmNkMWNVbTc4V0NO?=
 =?utf-8?B?cXE4Z3RCdlRLQk11UFN4MkRYZ2xKU0N6VUlaVk5lNWNTZGpwNEpKQXdwYzRH?=
 =?utf-8?B?ZFp1Y2dSRFErd3QzYm84WE9tSFJxL2Q5cmUwRUlQQktIazAvY0xZUTFucm1P?=
 =?utf-8?B?SXg0WEFhdjh0Yzh3Y3ZKWHZxaEw0VzFyNFQ2TFdVZ2xOU3NScDN3T0NabTRD?=
 =?utf-8?B?S2w5c0pxS2N4UWtTd1FHdkFsVVphZDVIdUZHeWVBUnlaUTdLZFpsTkY2eXFj?=
 =?utf-8?B?eFdFQlRBTUh4WjR2VUpGVlVWaEUwYU8vRytXK3BaaDQ2dEcrUG5aemkydjlI?=
 =?utf-8?B?M095ZUo3RFlGbTN3YjYyVUI0OXJlSHZ0T0MzUWQzRW9LQVlQVFVFa1hOc0ly?=
 =?utf-8?B?amVySGFuRmlaOVRLN1RKTUM5OGhkWGZtTzVhMHlpaDlIdWJmcWxEL0MzRDQ3?=
 =?utf-8?B?dUNqUlBUWWVseGd0NWV0RUtCTzQva1B2bVJSMXlPTEdUTU9RUVlqN3RkWWRL?=
 =?utf-8?B?NzJSQjVHWFlMWFBjNEgxdU50TndHM2FkZVQ4ZDlrcUEyQUFxQjRBUk5Ma0Mw?=
 =?utf-8?B?c0xyNXI3M0JEazhxQlpxYmV6V2lzUlBaWE12KzJPRnBIdEhlSXEyT210eGll?=
 =?utf-8?B?VHoxY3BYT3M2dmJEMkE0eXVRakZZTzRjTUJNbW5XRHBKcCs5cEtEZnVLaXlY?=
 =?utf-8?B?SWRUazFVL3d4UnRMT1dwdFNSWXpuMThMMmp3aWhjMllBNWxSN2Z0bnczVzc0?=
 =?utf-8?B?VUZIazZkd0tYQkZ3bkJyQ0RNZlBieStoT3crdnpRbGtkUHNSQlRZbFZkVC9u?=
 =?utf-8?B?UGlod2VwYzJSc0FGemdkMkdyd2srOENVVmFGTnhpemZSeG4wL1FzYWlLQjhs?=
 =?utf-8?B?L0MvSU03a3NhV2trUDg3cUZGV2RRVVpHRC9SejZjWFpXUzloaTVURFkzN3hX?=
 =?utf-8?B?M21jRjZuckFVYlZEaDRIcExXS0R6czB0bExienBUMTFEUjk5U1hOZWYrR0l4?=
 =?utf-8?B?RCtHbXF3RmpyUUlxMEVjTFB2R3ZLTi9kRUh5YjY4TVlJcHRuZ0Jvb1MvdjNO?=
 =?utf-8?Q?iRUfVI4Cphsof/iewUg2AOx1U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8f034d-c705-43ba-27a0-08db9d3dd87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 03:15:15.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBHRUgfxT0t4532WdwNdVxUVCYs8ATuqHZqiDoVsyF7mVSQvXV5ZQGLMC505SJ8FsgHqrxBZlpJgoSaIn92ksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4797
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgMTUsIDIwMjMgMTA6MDYgQU0NCj4gDQo+IFtQbGVhc2UgYWxsb3cgbWUgdG8g
aW5jbHVkZSBLZXZpbiBhbmQgQWxleCBpbiB0aGlzIHRocmVhZC5dDQo+IA0KPiBPbiAyMDIzLzgv
MTQgMjA6MTAsIEppZSBKaSB3cm90ZToNCj4gPiBXaXRoIHRoZSBhZGRpdGlvbiBvZiBJT01NVSBz
dXBwb3J0IGZvciBJTyBwYWdlIGZhdWx0LCBpdCdzIG5vdyBwb3NzaWJsZQ0KPiA+IHRvIHVucGlu
IHRoZSBtZW1vcnkgd2hpY2ggRE1BIHJlbWFwcGluZy4gSG93ZXZlciwgdGhlIGxhY2sgb2Ygc3Vw
cG9ydA0KPiA+IGZvciB1bm1hcHBpbmcgYSBzdWJyYW5nZSBvZiB0aGUgSS9PIHBhZ2UgdGFibGUg
KElPUFQpIGluIElPTU1VIGNhbiBsZWFkDQo+ID4gdG8gc29tZSBpc3N1ZXMuDQo+IA0KPiBJcyB0
aGlzIHRoZSByaWdodCBjb250cmFjdCBhYm91dCBob3cgaW9tbXVfbWFwL3VubWFwKCkgc2hvdWxk
IGJlIHVzZWQ/DQo+IElmIEkgcmVtZW1iZXIgaXQgY29ycmVjdGx5LCBJT1ZBIHJhbmdlcyBzaG91
bGQgYmUgbWFwcGVkIGluIHBhaXJzLiBUaGF0DQo+IG1lYW5zLCBpZiBhIHJhbmdlIGlzIG1hcHBl
ZCBieSBpb21tdV9tYXAoKSwgdGhlIHNhbWUgcmFuZ2Ugc2hvdWxkIGJlDQo+IHVubWFwcGVkIHdp
dGggaW9tbXVfdW5tYXAoKS4NCj4gDQo+IEFueSBtaXN1bmRlcnN0YW5kaW5nIG9yIGFueXRoaW5n
IGNoYW5nZWQ/DQo+IA0KPiA+DQo+ID4gRm9yIGluc3RhbmNlLCBhIHZpcnR1YWwgbWFjaGluZSBj
YW4gZXN0YWJsaXNoIElPUFQgb2YgMk0vMUcgZm9yIGJldHRlcg0KPiA+IHBlcmZvcm1hbmNlLCB3
aGlsZSB0aGUgaG9zdCBzeXN0ZW0gZW5hYmxlIHN3YXAgYW5kIGF0dGVtcHRzIHRvIHN3YXAgb3V0
DQo+ID4gc29tZSA0SyBwYWdlcy4gVW5mb3J0dW5hdGVseSwgdW5tYXAgc3VicmFuZ2Ugb2YgdGhl
IGxhcmdlLXBhZ2UgbWFwcGluZw0KPiA+IHdpbGwgbWFrZSBJT01NVSBwYWdlIHdhbGsgdG8gZXJy
b3IgbGV2ZWwsIGFuZCBmaW5hbGx5IGNhdXNlIGtlcm5lbCBjcmFzaC4NCj4gDQo+IFNvcnJ5IHRo
YXQgSSBjYW4ndCBmdWxseSB1bmRlcnN0YW5kIHRoaXMgdXNlIGNhc2UuIEFyZSB5b3UgdGFsa2lu
ZyBhYm91dA0KPiB0aGUgbmVzdGVkIHRyYW5zbGF0aW9uIHdoZXJlIHVzZXIgc3BhY2VzIG1hbmFn
ZSB0aGVpciBvd24gSU8gcGFnZQ0KPiB0YWJsZXM/IEJ1dCBob3cgY2FuIHRob3NlIHBhZ2VzIGJl
ZW4gc3dhcHBlZCBvdXQ/DQo+IA0KDQpJdCdzIG5vdCByZWxhdGVkIHRvIG5lc3RlZC4gSSB0aGlu
ayB0aGV5IGFyZSBpbnRlcmVzdGVkIGluIEkvTyBwYWdlIGZhdWx0IGluDQpzdGFnZS0yIHNvIHRo
ZXJlIGlzIG5vIG5lZWQgdG8gcGluIHRoZSBndWVzdCBtZW1vcnkuDQoNCkJ1dCBJIGRvbid0IHRo
aW5rIHRoaXMgcGF0Y2ggYWxvbmcgbWFrZXMgYW55IHNlbnNlLiBJdCBzaG91bGQgYmUgcGFydCBv
Zg0KYSBiaWcgc2VyaWVzIHdoaWNoIGVuYWJsZXMgaW9tbXVmZCB0byBzdXBwb3J0IHN0YWdlLTIg
cGFnZSBmYXVsdCwgZS5nLg0KaW9tbXVmZCB3aWxsIHJlZ2lzdGVyIGEgZmF1bHQgaGFuZGxlciBv
biBzdGFnZS0yIGh3cHQgd2hpY2ggZmlyc3QgY2FsbHMNCmhhbmRsZV9tbV9mYXVsdCgpIHRvIGZp
eCBjcHUgcGFnZSB0YWJsZSB0aGVuIGNhbGxzIGlvbW11X21hcCgpIHRvDQpzZXR1cCB0aGUgaW92
YSBtYXBwaW5nLiBUaGVuIHVwb24gbW11IG5vdGlmaWVyIG9uIGFueSBob3N0IG1hcHBpbmcNCmNo
YW5nZXMgZnJvbSBtbSwgaW9tbXVmZCBjYWxscyBpb21tdV91bm1hcCgpIG9yIG90aGVyIGhlbHBl
cnMgdG8NCmFkanVzdCB0aGUgaW92YSBtYXBwaW5nIGFjY29yZGluZ2x5Lg0KDQp0aGUgaW9fcGFn
ZXRhYmxlIG1ldGFkYXRhIHdoaWNoIHRyYWNrcyB1c2VyIHJlcXVlc3QgaXMgdW5jaGFuZ2VkDQpp
biB0aGF0IHByb2Nlc3MuDQoNCnZmaW8gZHJpdmVyIG5lZWRzIHJlcG9ydCB0byBpb21tdWZkIHdo
ZXRoZXIgYSBib3VuZCBkZXZpY2UgY2FuIGZ1bGx5DQpzdXBwb3J0IEkvTyBwYWdlIGZhdWx0IGZv
ciBhbGwgRE1BIHJlcXVlc3RzIChiZXlvbmQgd2hhdCBQQ0kgUFJJIGFsbG93cykuDQoNClRoZXJl
IGFyZSBhIGxvdCB0byBkbyBiZWZvcmUgd2UgbmVlZCB0YWtlIHRpbWUgdG8gcmV2aWV3IHRoaXMg
aW9tbXUNCmRyaXZlciBzcGVjaWZpYyBjaGFuZ2UuDQo=
