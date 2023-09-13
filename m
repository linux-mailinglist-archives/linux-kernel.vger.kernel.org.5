Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1579E849
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjIMMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjIMMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:48:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000A19B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694609333; x=1726145333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IILCs2z1tkZmDT1kT68v5oFLVSoCv8XBdMrRtzkZ8AQ=;
  b=QCT99TmxDstGA08vmQ1iW9iWWgYsIJ4ADqALF2aAayYayjmegXtXi3Sc
   WoUPPdO2z/auZuB+WNyalw0o/M43c9my9F5p6ObIUR3qTwy/oNTpKvuBX
   wKKaRGdDY+Ldd6uZMn8eVUvhFPMncjfIXwFU6EB8R+w5nnLWKzrXBgkAL
   q19sjQLpL+Bc3L7ZN88Foa6A+wgat8SLM0aJR6LMO2wnRMU/llY7hg0ZV
   5Aqc7cxo8HEe3TClnjbzMNQV49isjAcpt4NkiWjDa9305czOxaMjbDZAf
   agZj/bYKZ/u5DLay3IekICrBDqBLvVtH4C6d5T+ZlAUSPv6mDDp5moKu6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409600789"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="409600789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917808026"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917808026"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 05:48:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 05:48:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 05:48:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 05:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1e4Gl6yPzryle2lQHN978FGz/rmGBlLhHQYYac7ulO9A8p+D3dVvcmpua4bHZo8y+CxnsIbFV6fu8C/lVi8cOqJqKr/QVx6H2VMDTnFRpux7TbPZKrhTZAIzBkrgWVv/kyGeCO3RY764ucNGX9shVj7U3VTySFepjd9J8ZbzyLQBDEYVprKZM6r+yHZIZiqeZSomULtlu+TP8Oiu1Taay+GTD4qhJnDlQpPNZo9ru0yijARtnfdbFPih4hfNGKoKU2ZhPx8lr4P8ac2MXakHQ4Nv6QRRulmiThLTYyftfew7aYrFcW4TLxAg4OT+ztXDAq5t7kMOUWM8MheDx379A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IILCs2z1tkZmDT1kT68v5oFLVSoCv8XBdMrRtzkZ8AQ=;
 b=h9lOBLJ95MnrksnXu7fGH6z4BnYIeDJv/lY2+6GwaQTP/VJnjViU3Suq5F4aezVH6AVYFvW6XgX86CkL6N5VS2WaZ1/jaHZdvcYFzE9WtMI3pT5YWlBfHm7TGCcGn+WshvL1ZLciUJLPiHphCQL5m/JROnWK6go8zi6fsgp2EN3sETDC6HENEy1D9RZvjoKWC9yFYUt2hoV/9uwjH9lXRvZ3UTU2SThrPKkUWrBNNhQUoeG5BZgQ1tQEkGoY3ia31uuRtYgmgzhqNPRHUrmVTJWiNA5YQK9a4bJC/R0LeasoPu1mNxhK0ythTlw2W1tW1MIP4c1r3f3filmw2mGEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 12:48:48 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.020; Wed, 13 Sep 2023
 12:48:48 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/xe/gsc: add gsc device support
Thread-Topic: [PATCH 3/4] drm/xe/gsc: add gsc device support
Thread-Index: AQHZ5XrrNBEzMjyRwUWt1jOQxvm/wrAXSiCAgAFqW+A=
Date:   Wed, 13 Sep 2023 12:48:48 +0000
Message-ID: <CY5PR11MB6366B470B6B6A72F32F2EB18EDF0A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
 <20230912130835.2488728-4-alexander.usyskin@intel.com>
 <5521adaf-724e-4de8-ae56-74dc349b66c8@intel.com>
In-Reply-To: <5521adaf-724e-4de8-ae56-74dc349b66c8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB5863:EE_
x-ms-office365-filtering-correlation-id: 07e87ff3-1a33-4eea-a40d-08dbb457c634
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WL7lj/VGPITHPTtApWTDWhijhndh5I3y4VFWM1smAO2NBIo9b/8bZkF6vb6KafnAAjQH6t+OfWfVgMKt727uguY8bTnUr+h+K/dbwRek8Ut/4rYr8LaqQrIcFVEvIOZ5zLvdUFM0YlvsFvrIrctKdwLtPDW0BnZ3WwmN7jCc6cXf6eHfiRySPa04fjOFGsm0V2NNFIr3ydUyQ962fOVRyj2XNYSzM5DYrDZugYFm5N0XCLfy70cNkeL3jL5jEmK4R8kA+FR/ssqJHVxrI8DktuqJdYXT40MMUEP1zRFFLpokevAcxhFrbtfbIqgAnxhC4Zcz6aDEtoHVpC6lryFWbDofG39Z3rqh7eDGsGA7ZzTx0kXP92kkVpmrm4BCBFRBTEWiJpDyGPVdHWSJ9IjoT69PNGHsTTNkZKvvRiHmFRLxKFx43QIFjcsGUq0l4Co0Pgi1dlSysnMemoG/8AimddDyME9BoJmtbZvMdu+YCVltMxMc6V6K8dROrnUsa5HSzRcCmnYYzbrZiez5goTG4kHCjmdy058cXas79XkHEUYgHvNGkZLlWoWVHNBQX9PHaqhoRjzv+LD45g/XbtJPp8WSCf8Ccr76/MWMkJRUisE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(1800799009)(451199024)(186009)(5660300002)(6636002)(55016003)(66476007)(82960400001)(2906002)(316002)(122000001)(66556008)(66946007)(9686003)(64756008)(76116006)(26005)(71200400001)(52536014)(4326008)(54906003)(110136005)(8936002)(8676002)(478600001)(41300700001)(6506007)(7696005)(66446008)(38100700002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0JOOHZZcmlzL3BSeGR0b3FqRG92dWZab0xxNU8rcUFhUWxXWFg4bmFBMUZ0?=
 =?utf-8?B?V2JFeGdjeEhSbzRxYkNPQnRGZGExdENsWFkxa3BrZXd2Zisrb2dMaE9LSU1H?=
 =?utf-8?B?Wkx0aHZ1bXNUYzNzeEkydWprVlZZMmpQWVRPQkV4dWdETkVkMVArcStpcG94?=
 =?utf-8?B?ZXYrbHdnTitlQ01nNyt2ZUtGQTh6ZUhIRkVEc1phdGRJREYxMjgwQTJSVTBL?=
 =?utf-8?B?dFBaUkJoa21OY1c2cERqWWZHMlFWcitJRGxmUW1LaXNFcHV4cXpxeW9kM0M3?=
 =?utf-8?B?SGRGdnRCblR6aXA5SmIrTWsxd1RKL3o3TWtMUXd5NmU2UVpGL25GSkk0VWY2?=
 =?utf-8?B?SVY1eXVYQnRESFdkRWJBb2U5THJlRnB2MFZIWXMrSWFGTHRlcFRaM3hoNDZs?=
 =?utf-8?B?dTkxSkdHQnJCclVBZVUwTWx2M0NlSFJicThqTVRiQnpMSnB1dFYvRVhLL2lB?=
 =?utf-8?B?Si85eU10QWxnc2pYS3MzY2FQM3ozRTJ6bWwrUUtKS0tQQ3Q2QjVwUEphUkwv?=
 =?utf-8?B?OXdiT2RrWnJBMFVKZERMK21zU280djJPWjB1ZmFSZ0N3eVAxQUdqT3E0R05i?=
 =?utf-8?B?eHV2ZXpmcFRPeklzMFRrNFo2WWpXN05xRnhXTCt4K0NJeTN4WU8ySkVmZCtB?=
 =?utf-8?B?dVF3ZkczZkc0cTRtbWd3QVpGekN6alNXZlBKTjN3VTVQcHBhYThyb2FuSENT?=
 =?utf-8?B?UTdCL3l5TmZ3WHlwRkU1ZU9HZTlRZmk5VktzZmNHb2JaWGdZSzltdVd0eE5p?=
 =?utf-8?B?VWhvR3NHZ2lzM0ZEUklEWHZtRlprTktuUURBR0QzTGdYZURQQnVHTXc2OWxW?=
 =?utf-8?B?KzY1WlpDbUFJQTFRREFLbzVkcjJDTkJPVjBOeS9MaEhhTDAyZGdDQ2FNWE5k?=
 =?utf-8?B?NXNCbnl3ZEZaVWZjRzQ3SzRUQ1djdDdoeUJUZVRPL0QzVkVEbDBlamwvdzlx?=
 =?utf-8?B?TE54cS9mVG1JZFE5czFHZVJlN2ZGeGRkbmxjaWcwbVNOc2t5amxrZlp4V2M5?=
 =?utf-8?B?SmZwSUhlQ0hpUWh2N3Jjd2l2Wm4yRTJlYWRucEcwNXlEWkZHZWVhN0xyYWQ3?=
 =?utf-8?B?ZU1sMU5URVdEUXdpRFpZSFAwV3hMQlVVbUhyNFJyMm9xYUIxSjlkeEVSTy9s?=
 =?utf-8?B?R2lNbXlKc2tUdFc2TnErQW1nbjgwc0dmQVhWaCtwWlFzeVRFRzRwOHZLeDd0?=
 =?utf-8?B?T2w4b3VSNUtRWk5lTjhwcnNOUFhBL2JHR2RNSHcvb2p0RXRKc3BCajJFYTRv?=
 =?utf-8?B?R1ZZTjRRTnVDSVU4US84STlDandoV0dnelBKWVIzWUY3ODFTNDdBWFN2S1Ez?=
 =?utf-8?B?VXdiMmxzRVF2RlRSREkyTTZDMWRJLy8vbmxaOVd5V2F2RTV0UDBNTHcxb2Jt?=
 =?utf-8?B?ZU0zcnFuM0pqSEEydFEyTU5MeGU1dnlSWWZVb1poNEViU2NueUYrYnNWQUVI?=
 =?utf-8?B?SWxWR0tBeWF0Z2VNSWZYK3pITDN3blczSklMYXYwZnQzTW51OThDZlBwVXNZ?=
 =?utf-8?B?Sm9RMkROVEZjR1hnK0NNL0VDLzZuSlA4V3dnSEtJOWhhNkUyRjFVdDhUOHd2?=
 =?utf-8?B?RitRSmhnR0R5UWErQmZyd3Y3N3kwN1VuN0MxbXRnckZtSktOL2wxNCtvMDBx?=
 =?utf-8?B?TUtyYmpqcUozODg3M3oxU2IzWHdRNFppN0ptRCsrN29ad241bi9tZ1dibFVz?=
 =?utf-8?B?S2dWQXBvYzRsMDI1TEM2cGV1M3l3RVBpNXhUU3RBUElndHViL1RBVUlxS0Jj?=
 =?utf-8?B?RkNaQzBkUkpYZ0lhaTVUWmd4NkpObEJaMGFHOWF4UmNCcHVUWHZPM3RvSUxH?=
 =?utf-8?B?SkRkSjBCNnYvMFVHZmdWd3g5TXNEbTRuZTFDZ3RoUlpLdUxYTzdtREFrTVcr?=
 =?utf-8?B?T2hyeGYyZUhXOThlQkdhM3gwVlhoMDZGcXBpRmdRREtqWUp1UTRGRmU1M2ZL?=
 =?utf-8?B?cnRtR2FEM05FZVNKTWJxQmNJTkFpVmY4ODc1dUNFQ083ZjJQV0hFZy9ZUlQz?=
 =?utf-8?B?T3M3NFNXTXpEdzFTbmFXY2g1Z1BRUkpTQldlekhEbGtrbmNJdThSS1FFNjlN?=
 =?utf-8?B?elhaaFhZdzc1UEZMNGdrTmtnd3JDM1BjUnFPRENVbVhHWnZUTDhIQlZBS1lY?=
 =?utf-8?B?NUEvaDYxNnlId0k5aFdETSs4dzlBNXJrd09FeUplaXlMZzl6NEdnK1lsTEll?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e87ff3-1a33-4eea-a40d-08dbb457c634
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 12:48:48.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1mEf5rOqAef4Wn12Czo086UyJCdsmg/U1KQcmZG2uhOd+AJZGf1aK9yFpGQnJt7uOsVm6rTmBQ0IO7+aEgXQ8vuzflfyHndXZfsEevxUcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdHJ1Y3QgeGVfZ3NjIHsNCj4gDQo+IFBsZWFzZSB1c2UgYSBkaWZmZXJlbnQgbmFtZSBm
b3IgdGhpcyBpbnN0ZWFkIG9mIGp1c3QgeGVfZ3NjLiBJbiBYZSB3ZSdyZQ0KPiBsaWtlbHkgbmV2
ZXIgZ29pbmcgdG8gZnVsbHkgdXNlIHRoZSBHU0MgdmlhIEhFQ0ksIG9ubHkgdGhlIEdTQ0ZJL0NT
Qw0KPiBwYXJ0LiBJbiBNVEwgYW5kIG5ld2VyIHdlIGFsc28gaGF2ZSB0aGUgYWN0dWFsIEdTQyBw
YXJ0IGJlaW5nIHNwbGl0IG9mZg0KPiBhbmQgcGxhY2VkIGluc2lkZSBHVCAoYmVoaW5kIHRoZSBH
U0NDUyksIHNvIGlmIHdlIGNhbGwgdGhpcyBqdXN0IHhlX2dzYw0KPiBhcyB3ZWxsIGl0J2xsIGJl
IGNvbmZ1c2luZy4gSSBzdWdnZXN0IGNhbGxpbmcgdGhpcyBzb21ldGhpbmcgbGlrZQ0KPiB4ZV9o
ZWNpX2dzYyzCoHhlX2hlY2lfaW50ZXJmYWNlIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuIEkgaGFk
IGFjdHVhbGx5DQo+IHN1Z2dlc3RlZCB0aGlzIGZvciBpOTE1IGFzIHdlbGwNCj4gKGh0dHBzOi8v
cGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81MDk2NTMvKSBidXQgVG9tYXMgd2FzDQo+
IGNvbmNlcm5lZCBpdCBtaWdodCBtYWtlIGJhY2twb3J0aW5nIGZpeGVzIGRpZmZpY3VsdCwgc28g
SSBkcm9wcGVkIGl0Ow0KPiB0aGlzIGlzIG5vdCBhIGNvbmNlcm4gZm9yIFhlIHJpZ2h0IG5vdy4N
Cj4gDQo+IE5vdGUgdGhhdCB0aGlzIG1lYW5zIHJlbmFtaW5nIGFsbCB0aGUgZXhwb3NlZCBmdW5j
dGlvbnMgYXMgd2VsbC4NCj4gDQo+IERhbmllbGUNCj4gDQoNClN1cmUsIHdpbGwgcmVuYW1lIGl0
IHhlX2hlY2lfZ3NjIGFuZCBtb3ZlIHRvIHhlX2RldmljZS4NCg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0veGUveGVfaXJxLmMgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfaXJxLmMN
Cj4gPiBpbmRleCAxZGVlM2U4MzJlYjUuLjFhZTRjYzlmMTUyMiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0veGUveGVfaXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUv
eGVfaXJxLmMNCj4gPiBAQCAtMTI4LDYgKzEyOCw3IEBAIHZvaWQgeGVfaXJxX2VuYWJsZV9od2Uo
c3RydWN0IHhlX2d0ICpndCkNCj4gPiAgIAlzdHJ1Y3QgeGVfZGV2aWNlICp4ZSA9IGd0X3RvX3hl
KGd0KTsNCj4gPiAgIAl1MzIgY2NzX21hc2ssIGJjc19tYXNrOw0KPiA+ICAgCXUzMiBpcnFzLCBk
bWFzaywgc21hc2s7DQo+ID4gKwl1MzIgZ3NjX21hc2sgPSBHU0NfSVJRX0lOVEYoMSk7DQo+ID4N
Cj4gPiAgIAlpZiAoeGVfZGV2aWNlX2d1Y19zdWJtaXNzaW9uX2VuYWJsZWQoeGUpKSB7DQo+ID4g
ICAJCWlycXMgPSBHVF9SRU5ERVJfVVNFUl9JTlRFUlJVUFQgfA0KPiA+IEBAIC0xODAsNiArMTgx
LDkgQEAgdm9pZCB4ZV9pcnFfZW5hYmxlX2h3ZShzdHJ1Y3QgeGVfZ3QgKmd0KQ0KPiA+ICAgCQlp
ZiAoeGVfaHdfZW5naW5lX21hc2tfcGVyX2NsYXNzKGd0LA0KPiBYRV9FTkdJTkVfQ0xBU1NfT1RI
RVIpKSB7DQo+ID4gICAJCQl4ZV9tbWlvX3dyaXRlMzIoZ3QsIEdVTklUX0dTQ19JTlRSX0VOQUJM
RSwNCj4gaXJxcyk7DQo+ID4gICAJCQl4ZV9tbWlvX3dyaXRlMzIoZ3QsIEdVTklUX0dTQ19JTlRS
X01BU0ssDQo+IH5pcnFzKTsNCj4gPiArCQl9IGVsc2UgaWYgKEhBU19IRUNJX0dTQ0ZJKHhlKSkg
ew0KPiA+ICsJCQl4ZV9tbWlvX3dyaXRlMzIoZ3QsIEdVTklUX0dTQ19JTlRSX0VOQUJMRSwNCj4g
Z3NjX21hc2spOw0KPiA+ICsJCQl4ZV9tbWlvX3dyaXRlMzIoZ3QsIEdVTklUX0dTQ19JTlRSX01B
U0ssDQo+IH5nc2NfbWFzayk7DQoNCkRhbmllbGxlLCBob3cgdGhpcyBlbmFibGVtZW50IHNob3Vs
ZCBsb29rIHdoZW4gZ3NjX2hlY2kgaXMgbm90IGd0IHJlbGF0ZWQ/DQpJJ20gc29tZXdoYXQgY29u
ZnVzZWQgaGVyZS4NCg0KLS0gDQpUaGFua3MsDQpTYXNoYQ0KDQo=
