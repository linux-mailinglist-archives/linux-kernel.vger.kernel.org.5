Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA67AE4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjIZFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:03:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA21D9;
        Mon, 25 Sep 2023 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695704591; x=1727240591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X1O8Oxmhuc7QRIk4TPaBfsNxykhPoP/W/i+gkeV8AAg=;
  b=UrTv7S2JBlq5eQ5kYQKb+L9wkxR8rRXuEDeU/KWlNktswzTfx5G3zxN0
   Zm6eVFvn+2PXlsQ2JKvTJzz74elxzmMWJ8zAaxOS/Go6KRNO1lRQN1+ha
   VEW+6h1hlqPmmPQTtyaa9glzmcfy68R7wK1f8dAk9tsYHa4D9kj1L9k2J
   LS4w5gmcTSBhfI4/b6TvTNjFN0QNhozWW2sPnxgFmA4/nIgc5V5Tp4qvw
   piLlIXDg4gcVkFMB92/YNPixkF3s0VKCqFs/VefdS8QGWDR3Ff7sLYp/q
   aRB/NfJUTTpZNjZ3SLUTrMRGzdzQ87OZVudcE4mzXnL1ranBMPK9I0vhX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366544238"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="366544238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818909344"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="818909344"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:03:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:03:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:03:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIqcvATG3z6gwlCu9aFwVk/Cra+HWm404XdKyVeOd1h4fKrLQRcZT9hyrAJZjjp7dx2NfJE6aODmi89gzmr5QYf2VhNOIz2ZvJHwdBHIw/XmwVxwiVW+CHnXIEWCMmNG7jcegsqKMWDQPTdtcFGqjQtye1aj7XxvpqDM2qmuINKnvS1Kruv5AJZ8FOcP8X/zXOKl+XtmlEEzgbMM+c3h+04LOqSSC4yUzrVLokDXYHOv2gSZ+HovTu4mhOCwvjlKMIAEjtlBzYis4J9FMx/R1B/MJaC+4qnlMYM+Gn3Zkoh1N2rKfyKEnxkVeghq27lwnD6GlfH/9OjgZUvW1XNvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1O8Oxmhuc7QRIk4TPaBfsNxykhPoP/W/i+gkeV8AAg=;
 b=QWcvRJWWds3nNrmUM27OWNWEL8X0dOM/2XN4x+ATyhftC+Kwa9uV5gRUP77Q4W+8driDf/S6HFKcycGCiKSdKNvwr0MOw2kaYr7Y3QpeY6m8emukyKw4ixYM6WzcmHyJePYFh0yS20n4MQElKg1/FoJ3rVO0tRLdRa6YUMS4BpfqGInrOg1XdUL44odfic51qAvLMnBq6EpL8WhALYNsPUcdm2cr+neW+UT1cyl30H+FwBAUzmuqS6LrUcDRHlsabqdwwjkqRNSNBN00XzblmrAP8nJMs0NpEyL41eXtzC5YkM0J1qs58g7vFM6XTX1TZJUdOEB22Hik6P4pJRMfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 05:03:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::c869:bfc3:8472:8049]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::c869:bfc3:8472:8049%4]) with mapi id 15.20.6792.024; Tue, 26 Sep 2023
 05:03:06 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ACPI: FPDT: break out of the loop if record length is
 zero
Thread-Topic: [PATCH] ACPI: FPDT: break out of the loop if record length is
 zero
Thread-Index: AQHZ7/kRXGUZEtisO0WLI+aoskhtoLAsjW+A
Date:   Tue, 26 Sep 2023 05:02:47 +0000
Message-ID: <b0786bf5571050397b5075bac7c1e9023bfa5aec.camel@intel.com>
References: <20230925214046.1051350-1-anarsoul@gmail.com>
In-Reply-To: <20230925214046.1051350-1-anarsoul@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 91dde1c8-d749-4eca-8b6b-08dbbe4dd3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdozDVR/+mm9FF1U8UiS2lbwBXmpkcqwAphJWL3lKDgyeNVu8sF2DqWhk6ruIjArJ/iDbeaGQRiafvZ4SqAk1oAQEP29IhPy2Tc9ch7iUb0KiLg1ri1b24tbVENlkDL+2HFqJ60SncoBHwTJx+1TKatrK41bW8ee7A1g+XXPYJXeswIqzbgiezE7AZY+DMMpywoOoUZed4irx5cZi2Df9us969HbTvnVvOtYZk0VeMk/LXK0CarmqIfTE2NosfY1OvVfNO4/aGTOYZvlq+fDAMKEwrdoNF0u2ic185sAKnfmb3GkKFoGhg4rKRayzxFAaWYIEkUQMW7nAL8jGHxCCefjZCyYb2x3cIMb18YebhX9LnswDjeur4cH+NumY/nOSsk5rjaV8aevbinDucVFwd8p0YT01vPNZYwK45VPvP7K35KxZk7XOUGFRaCCuzlRTVOwvCQRzMVSxzo2l+0hZ4BnxvcpckipsJKp7S7lqreF25UocetjSIXMfTethKz9hDfhFZzuQHWD7nJaMuwtAoOfSc4G892+3iBvzzyEo1hHgjT4onWNZLo33Vvu44wRRs4lCWNPv2oMpC4IGQA83r54gHjiiURXmmd9zvqwhmlNwC+0FLw59SN7mb0DpYei
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(66446008)(66946007)(82960400001)(64756008)(110136005)(91956017)(66476007)(66556008)(6666004)(478600001)(122000001)(316002)(76116006)(36756003)(38070700005)(2906002)(38100700002)(86362001)(4326008)(5660300002)(8936002)(26005)(83380400001)(2616005)(8676002)(41300700001)(71200400001)(6512007)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJkVnZXMVdGOEVnZlZLM1N0ZTdJM1RZSVpJOENmNFZZbU5Ndks5ZlFFbjVJ?=
 =?utf-8?B?UXRUaTQwQ1FINnZnckRYcklhQmdBWlpwWmVldmJTb2NOMU9xVTlKRDlzb0JE?=
 =?utf-8?B?Q0N4ekFocEVMbkJjdVREYmorWHBZUzBSK3ZId2h6NmZxVEFBL25MMDR3RXpX?=
 =?utf-8?B?NElZRWp1Y2NKUm9nMUx0T0MzSURnU1J2YkdGMVZqZEdJQlRkcXJtVXA0aERu?=
 =?utf-8?B?MVhoTjhpWWZUeUE2RzNlZ3VhZEMrMDJtVkZXNktHU0hnTDZDK2x3OXUwdTc4?=
 =?utf-8?B?aHY4OElCNHVEbnJSUS9kYVlzYTkwcDBQalVEY2YxcGlQSEFJazQybG0zcmRI?=
 =?utf-8?B?a3RjQmEyUnA3WlFnR2tCMm15dnlwTzA5UlpvOE0xdC9ZMkFiSHh0R0tQZmJq?=
 =?utf-8?B?WXNUdVFVajlQR1ptZTlOUEQ3ZWdHVnQvandubnVZM0RneGZKT2NGUkFtOVFX?=
 =?utf-8?B?SnoxSmZWenYyK1JLVnk4RW5FR1lVT2tVK3h5bjJIY1Zjb2NnZVhkU1J0VmN0?=
 =?utf-8?B?SUFMUS8xYUZVVlVmSDFOZmlITHpBR0pqcTJOL0FQQUJoUlM2WXd6aE40NGhO?=
 =?utf-8?B?aUpyWmk0cHpGNzF5NVFsZUpXbTB6N1BHZC95bysxV0tNcFNRTEpWanBGMEhz?=
 =?utf-8?B?U0R0ejFJMW9ES0FnaldjYmY0YnJwWTA0dFZsS3llak1ObGdrckFjTVFJTWJB?=
 =?utf-8?B?WkphZlh3b3FEenJERTlLSGFESjBWYXprUUw4ZENaOSt5blJtUlBwMWRTa25a?=
 =?utf-8?B?OTVPaVE0azE5MThQVTBLSU55OXpUbktXa1NrbW1DZWxBVkRPVXpQd0NuZW10?=
 =?utf-8?B?OHpmOXFOSXc3ZEVUcytKanM3Qk9VSFR4UGQ5cklXbHczMDBtRXZZaUc3UXRk?=
 =?utf-8?B?MWJUWDBqWnplUnFyOWZQK0x3akk0alF1VEcxZFN1T3grUGFES2txM0liaVRp?=
 =?utf-8?B?cFk3bnZUdXJCN0hwTkJEbFcrcW5HUzhWVU9FbktZK1dZWFRhbThwa2hGbkZh?=
 =?utf-8?B?ZFBUTmNjU0duR2c0RGFKbHlrdy9aVDhtWlFuQ2lXb2pncFpaelp5ZHN1clV0?=
 =?utf-8?B?VlZoclFBamxWbGNySHFWblBvZ2V0SVFlUDVvSTNzdFRJeGZTTzRUaStQUzgr?=
 =?utf-8?B?R2lRSW5KdHRRT01meWVTY2lzZktTLzVIMVFyVUxDOXNuKzlJa2EwTWRNdTFw?=
 =?utf-8?B?UGJJUC9QcXZoM1l4Mm5XK1NYSmJqTTdPOUVwZWt2bGNwbFJRcUxzb01VazNY?=
 =?utf-8?B?bEFzL2I0Rm54YXREbHZwNjFTblJGTVlid0JpUy9KMmJLK09uSjJybXRkcHJB?=
 =?utf-8?B?SXRyZWliK29IbHVWd2JOcVArQ1IyMzZWK2E1V0dYVkNFNDQwdFYvQndHUWl3?=
 =?utf-8?B?ZCs4TTlqem1yNXcxc3ZrVlhwQzR1YnVpYUFGU3NpWTRGSm1VbU9LZFp2YUFU?=
 =?utf-8?B?VnkxNStDdU01azJMdEUvUHd4M2FJbEFseGwzZkp0cm9DRTZ3alloUEhZNVU3?=
 =?utf-8?B?eHh6UjI3bXV5eXJSczBYV1dSNnBySTBiUU85K0taT0c2bnpxVkFhaUJlS24v?=
 =?utf-8?B?RnZ0Qzltd3c1NlU4dkpqZDNBemc3cFpsTGFMQ2ZxbXFFaWU4TkF0M1RuVStv?=
 =?utf-8?B?SVBaTlZBZmxobXRKYTkrd3c4TGxIYnVzL2JNcDB0Q0lqSVlHNzZNYkQ5WlRZ?=
 =?utf-8?B?elNnVXZnRWEvbXlQZnRUd0hJWFRmczBnRmUyNE5jbU0wWDVhbjFBcmV5VUp5?=
 =?utf-8?B?QTQwT1dYVVpTVTBxbis0N2U1S2E5MGV1TUJEYllvOW5oWG9HR3lEdnJFNkQ0?=
 =?utf-8?B?anlNaG0yQ3ZoNXpqb1Z0ais3cWxjNFdBakQ5azVQMU1QYmN5QXFHK0VURmFS?=
 =?utf-8?B?ZHlYcmNZek5uYm9TRmxBYWdWekIrRHdBOWFIaHYxNTUwazNHaU90MzJnNWpu?=
 =?utf-8?B?MUdRbkgwRU5vNmNYUHl4VEJTZmRpWXVmSXhVZlkrakFkSkN4NE5VQzUyeFpi?=
 =?utf-8?B?NTdvYjcwOEpVMzh5a25HemJNUzJYWWRLa2xqeUtmb0RBb1FZOTlRUVlDUllx?=
 =?utf-8?B?NmZGWlpOMjB0dUl2ejBYRXFXNW4wRTViUXY2RTNWdHcyQXJ5eERJTEh4Mkl6?=
 =?utf-8?B?YkRDK01iRk13dXFKMzYvUTUvY2hlTk5KTmVoVHhsS2FRVnZTR3B2VmZzb2Uy?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A5ECF8E8131864DA2E760224E2D7E4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dde1c8-d749-4eca-8b6b-08dbbe4dd3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:02:47.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDvcId7RYRNdk0WbLdAw6BSNi3Vj3dBvECp6iDsJv+hqgB2kjmplHH1FE8GIx5P0PBEMTiKUkALVM248yzWo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
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

T24gTW9uLCAyMDIzLTA5LTI1IGF0IDE0OjQwIC0wNzAwLCBWYXNpbHkgS2hvcnV6aGljayB3cm90
ZToKPiBCdWdneSBCSU9TZXMgbWF5IGhhdmUgemVyby1sZW5ndGggcmVjb3JkcyBpbiBGUERULCB0
YWJsZSwgYXMgYSByZXN1bHQKcy9GUERULCB0YWJsZS9GUERUIHRhYmxlCgoKPiBmcGR0X3Byb2Nl
c3Nfc3VidGFibGUoKSBzcGlucyBpbiBldGVybmFsIGxvb3AuCj4gCj4gQnJlYWsgb3V0IG9mIHRo
ZSBsb29wIGlmIHJlY29yZCBsZW5ndGggaXMgemVyby4KPiAKPiAKPiBGaXhlczogZDFlYjg2ZTU5
YmUwICgiQUNQSTogdGFibGVzOiBpbnRyb2R1Y2Ugc3VwcG9ydCBmb3IgRlBEVAo+IHRhYmxlIikK
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IAo+IFNpZ25lZC1vZmYtYnk6IFZhc2lseSBL
aG9ydXpoaWNrIDxhbmFyc291bEBnbWFpbC5jb20+CgpJcyB0aGVyZSBhIGJ1Z3ppbGxhIG9yIHNv
bWV0aGluZyB3aGVyZSBzdWNoIGEgYnVnZ3kgQklPUyBpcyByZXBvcnRlZD8KCj4gLS0tCj4gwqBk
cml2ZXJzL2FjcGkvYWNwaV9mcGR0LmMgfCA1ICsrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYyBi
L2RyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYwo+IGluZGV4IGEyMDU2YzRjOGNiNy4uNTNkOGY5NjAx
YTU1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYwo+ICsrKyBiL2RyaXZl
cnMvYWNwaS9hY3BpX2ZwZHQuYwo+IEBAIC0xOTQsNiArMTk0LDExIEBAIHN0YXRpYyBpbnQgZnBk
dF9wcm9jZXNzX3N1YnRhYmxlKHU2NCBhZGRyZXNzLAo+IHUzMiBzdWJ0YWJsZV90eXBlKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVjb3JkX2hlYWRlciA9ICh2b2lkICopc3Vi
dGFibGVfaGVhZGVyICsgb2Zmc2V0Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
b2Zmc2V0ICs9IHJlY29yZF9oZWFkZXItPmxlbmd0aDsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoIXJlY29yZF9oZWFkZXItPmxlbmd0aCkgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfaW5mbyhGV19CVUcgIlplcm8t
bGVuZ3RoIHJlY29yZAo+IGZvdW5kLlxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKCkZvciBjYXNlcyBsaWtlIHRoaXMsIGl0IGltcGxp
ZXMgdGhlIEZQRFQgdGFibGUgaXMgZmFyIGZyb20gdXNhYmxlIGFuZAp3ZSBzaG91bGQgc3RvcCBw
cm9jZXNzaW5nIG9uIHN1Y2ggcGxhdGZvcm1zLgoKU28sIElNTywgaXQgaXMgYmV0dGVyIHRvCjEu
IHJldHVybiBhbiBlcnJvciBoZXJlIHJhdGhlciB0aGFuIGJyZWFrIGFuZCByZXR1cm4gMC4KMi4g
YWRkIHRoZSBlcnJvciBoYW5kbGluZyBmb3IgZnBkdF9wcm9jZXNzX3N1YnRhYmxlKCkgZmFpbHVy
ZXMuCgp3aGF0IGRvIHlvdSB0aGluaz8KCnRoYW5rcywKcnVpCgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3dp
dGNoIChyZWNvcmRfaGVhZGVyLT50eXBlKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjYXNlIFJFQ09SRF9TM19SRVNVTUU6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHN1YnRhYmxlX3R5cGUgIT0gU1VCVEFCTEVfUzNQVCkg
ewoK
