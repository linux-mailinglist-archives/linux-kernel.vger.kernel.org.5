Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F5803EA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjLDTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjLDTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:45:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4B3C1;
        Mon,  4 Dec 2023 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701719161; x=1733255161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzSeYbFRYC81Y7kSTb5Gz2GmJbG2D8XDu5YFQw9DStM=;
  b=anjnF5pTABhAFLxSr4l26A49MlNXK70lcUbF3wOCq+FjRPnc2K7J+HTl
   x06Eb8KimXlk9tSBOIuLxU8nkh47SoFbRSK6Qwm2Gdtb7Kmj96zhWvlQ1
   SvSxy5xQm0h2rHt2ryt+jrHJcggYFCF0k+HmYp5iHQB1Zvc3a1URTfuVq
   mQKF/zPkwO0A6cVfjcIqSYL1WQyDp92IYdchuKkPIZyc454gdGLwdXdR1
   bCSgwRu13MSagmjVpk6hr8qOK0AiiOBlkx4+GDuJ5nHY51FS422pxKp+i
   RfHg2A/0xahHTlMWAmwtIs1HLDmAcDvnSStPpcIxSVZ90kmIGjeT+eDaz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="683027"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="683027"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:45:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836701208"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836701208"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 11:45:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 11:45:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 11:45:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 11:45:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX+nHLoN8p9kmFOYPh/16EG+mgziHNeW3lNBEWHxLw/hxXsKzfMatuLAzS+8oX05PZnZYxJfPBKI2erjcTPZ6f8zAJ86Ut8PM+7Pi5sw7ILGlP6/I7r+qOl8LVn/g2nAb5RrYznd+K8mURg9tzR/n5EbJe9SbQJBdbWS3cMzacqNKZ91GTO9yM4WozN3wowfllU07VdakH3IcxjIMik6hSf/vo9D++RbVpfoNdUJNR4gqR4MUMAJjx0kfZ1yBScZU/mIj5fxAaNaLEV7oRfZCsjPHSHdS2B0XgZLk/6HAdbncC4rFxGLrqlcPxBnmJgZ8/F315P/krb0vUZWqD+jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzSeYbFRYC81Y7kSTb5Gz2GmJbG2D8XDu5YFQw9DStM=;
 b=nDoxZVqGkyGqWd5xLXbv2yLC9sWaeK2eGjLQZJ5q3fdoiXH9vYngyptCriULuewGpO0HvmNNhDEy4rMekARyJJATEOkGYFVS3QtFPhomMXt6ZzqrXxHVnWil6qOELi0YjBxA2T8LU0jMgwk790CFNbKNcSHOKM6Ctnr3W9O132u42dnAqx/vUIEtwmLrW96i0iCuZIWl11c6ifks+Hi7broxN2IjUhRUhYxmwlZuzNSzb2sYzoNO+weL1HN0PnRzJWhOUoyMrLyKg4Yu6CY5qHi6QzL55NuU7D/vHBxkzi8NkvoFR8i1kMiwkvudEsTrxjM1k/u8Oh46gl0keiN4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Mon, 4 Dec
 2023 19:45:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 19:45:40 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Thread-Topic: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Thread-Index: AQHaJKAJWFt7eRiqzU2Y/c3I17To0bCZU5gAgAAsxNOAAAgVkA==
Date:   Mon, 4 Dec 2023 19:45:40 +0000
Message-ID: <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
 <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
In-Reply-To: <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6378:EE_
x-ms-office365-filtering-correlation-id: c5adfeb9-c65a-4d4c-0410-08dbf50198a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4243GeSRyk1EISThhSFYKzVf7lwyGfkCf+N8LNlUyc+pPpTET9u+wGVjrpHzdVzlju8Q9a+dm16XGDuag9L/WisJKIPgw3USXoGXnTz1o0ktkVOIo9FpS/4seqjtNXywz8fpCW73mnoaC+jz0NbHvpxA+bcwPlWkYEW1ZLB7IJmkZLxD0LXhemNVfwldG8yo94Tyy/BOCo0ZM7iU7ptSGWZjCNycl/AB5yOfJnLeD5P/37279LR3DxaWDFhJOP6hR4rN12z4gZKRziX0++mqeCMEzDIkjvxeabQXxZrQXPHyJq8B1HMvQORfSXqSHumDMW99DKO3cBhgGCs4U6AwLv9TJ68mebOt0wSH/PaPVHAsO3M0dP84QqsM30qoa3IVNH7sLDuDqxMFMfjuBeFCX5k+hZ6KJdGo+BdUnNYb2j2DsZk6AOgboIpTYa6WjfLhi53jorXiEQEoAhG9mAzSek3Vj0vj+fgExBnAvLOBJcztNsxyhjgYmeoTUG6VWVHrbagj7qbuHOKVrC7zv5mydFJEGXzPqjWf+vaPUw1RkCwO01hDZRJf7D8MM1tRnYDUh6kZdCH+couM/1mIxVy69O5i9ksZXoASszAENxqBHN4n8CSyblVIrN75S2tIpt2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(55016003)(122000001)(38100700002)(66446008)(64756008)(8936002)(2906002)(5660300002)(86362001)(4326008)(7696005)(52536014)(7416002)(66476007)(66946007)(66556008)(316002)(54906003)(76116006)(71200400001)(478600001)(6506007)(9686003)(41300700001)(8676002)(6916009)(33656002)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTBadXRZN0tWQXVocG83a1NrbE9ud251VWRpK3E2Q1lYSW52NGpMaGI5RUda?=
 =?utf-8?B?Q1RteE1qQVYxQlBHbElsUHNVdC84Mk5RdkJQSDZBMlZqUGV0TGJmcm5HcVRF?=
 =?utf-8?B?ME1RRXN1S1p3VGVJTHV1R1lycjJ4b1RhbG1NQTcvOVplNW9WQm1XQ2pMR1JW?=
 =?utf-8?B?NWR5cDJCM0ZONkpIRFlsdFhKUGNDOER6Yk04L0Q4a3E1WWVpMkhlVDF2SC8z?=
 =?utf-8?B?eXNKVm42YWE4NWtLSHdHa21JTmwxaEFiaVlwK3JNUXpOZVNSUnFVcENsZFJZ?=
 =?utf-8?B?V0lVNldNeWVvNGJ1UnF6YkxwcE9HWW45REQxS1BXZXptbGJwRHZ0NmxzZk92?=
 =?utf-8?B?Tk9jaHdCazRrUzQzRXU4SzlZZFhRM1NId01IWml0NnVLSTlma1lISGNycTVy?=
 =?utf-8?B?YmVKQnRGcS9iZ05CNTRqamFDMnhTc2tpYXNTZWwzTGhCL0xyamRLRlZaVDdP?=
 =?utf-8?B?dUlWVE1DejdXTGRGVDFhSG1kYXF0eWZMVWJYQXhZVWw4b09xSm5DRTNHVGpo?=
 =?utf-8?B?QXpySHNVU25LeHd4Wk5jYk5FN0Vtcm9RbnRUUkFwMzFoMWR3WXBqOXlWdCtq?=
 =?utf-8?B?K2JpUnhwK1ljWkwvRVhXYUdteFZ4VFYzOU1IRUswK0JoME1pMHFPU1Ardmgw?=
 =?utf-8?B?NStWRm5vZ21nSjhZTnpnNlRaNjlISGVsT2tLWXRjTkR3WWNrckhNVjdnT2tU?=
 =?utf-8?B?dW1TU3ZHdW55OWtSMmE1a3hSZDRGbmpFbmhSZ1dwZnlWYkc1ekdUR3FFSkg4?=
 =?utf-8?B?czIrZEMyai9nR3hYWHBYOXBRVFBvcXAvM2JHWmlLSEdQdXJPSytLa0ZsQzQ1?=
 =?utf-8?B?c3RaM0taWkZlbGRoVUZTRW5FN3NzNFU3SVlOQTJYc1ZCWDExa2hYVFF2Yytr?=
 =?utf-8?B?Ry9IeG5JaFJoUXF2RFdmMmdwWnV4UUd4YmFDR3V1Ty9iaktGQ25FNzJTZG1N?=
 =?utf-8?B?K2dNeGZsWC84VVRNTmh0THdRZFZmbndiS2JBWGZ2anNOaWxuOUg1ek1UblpE?=
 =?utf-8?B?K1dPbXJhSndpTEVORklleUJFNG8xdlM3Tk9tWHc0Y2hyeFhyaG5ieDN1NGRV?=
 =?utf-8?B?Mlh5aXl0dFdxNmN4dHZEZjY3V2hmQUpmL0dUSkw4RVpiRy84d2pHUmJrQWwz?=
 =?utf-8?B?TCtzdmk4NXpUcWVjNWJWcTJsQ0ZyVWh1aGN0aXU2NDArMmRaS001SklUK2dx?=
 =?utf-8?B?ek1CdTBxR0g2aDc3NnZDRkl6RmVnMVlSZ0JMVEZtcEtEQys3OHNxVVlMdXor?=
 =?utf-8?B?SVhhdTk0djBDQzMxa0VEdWVReFR6a0l3UEdtYURQZndFNE1ZQ0lWYS9TS2tP?=
 =?utf-8?B?eC93K0s3NlJCUUNJS29yRmlwc3lNTlZybzJjTTZraDFIb0hLTkI5WVVKd1VC?=
 =?utf-8?B?VG01M1FZTm5yc29RbzY3d3JsV3c5S3hIR1hyWnV4b1lqRWhnZnJDVlNtL2dj?=
 =?utf-8?B?QXMrNXJSd3ZDMnF0WXRMblVsNzF2SUNmcVdGVmp6K3hzUTF2d2dPL3lZckUw?=
 =?utf-8?B?L1NMalJlamwxQk5XcE9KeDNKdWN5WHBLTDVCOFE0dFZGeUU1QTJFQXVYcnhG?=
 =?utf-8?B?WVVJK3ZWcEYranF2cEt5WkllcTQrMWZpL2ZVaVRJditEbHdOR2VHUi9Za2t2?=
 =?utf-8?B?MUtXLy9Bb2hZMDdkalUwVVQ0bWFkSE9zTWpsdGh5ekFvNEZQSFpNNVVmbDFU?=
 =?utf-8?B?elBmUzBOOWMxV0NzQ294QkRrS1VqOGp4ZnYyMnY2dGJocDdrd2R3TzR1Qk9t?=
 =?utf-8?B?azQ5SXJqTklEaVgzL3d0V2xvMVZLSTdBWElKYmVISWRhNXRKNzVlTUh6M0t0?=
 =?utf-8?B?Wk42L3NVZU95bGVma1luNURYZTNHS2F2NG1sRU1MeW9OQlVFdFdwbG8zMUs0?=
 =?utf-8?B?ODdYakZCQXRrVzZSbUIxYVpFY1hNUG9QUVFVay9MWUV2Nms4Nm9WN3BzNUdu?=
 =?utf-8?B?UVJ2VEo2RnZoYmtRT1B0TDl6UHlweXJiMUozQ0twTmVUZWtCWDF0UmFPbGlm?=
 =?utf-8?B?Umd1aTNheUdBWk5nTkc0U1FrQUZyOGdwWFVtMUtZMGxNMEpwVkRvOGkrTkRO?=
 =?utf-8?B?TGJtYTB2SjB6Y3ZkY2FYcWZsWVNUbkU4UTFuK1BFNkNRNkhUNGYrRkw2eWlj?=
 =?utf-8?Q?7oF1KhUeuKy6vlKDcqnDfOzhv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5adfeb9-c65a-4d4c-0410-08dbf50198a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 19:45:40.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/zEr7eysjmEKVW3KDKdHQC3ze3WVzHAMsTnQD95NMNDWFQFKN09CJiFtQ2NlKkHzvroeZ5l9/9J0UfHN7bCdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZXMuIEkgc2F3IHRoZSB0aHJlYWQuIEV2ZW4gdGhlbiBJIGZlZWwgaGF2aW5nIHR3byBzaW1p
bGFyIG9wdGlvbnMgY2FuDQo+IGNhdXNlIGNvbmZ1c2lvbi4gSSBmZWVsIGl0IGlzIGVub3VnaCBq
dXN0IHRvIHNvbHZlIHRoZSBvcmlnaW5hbCBwcm9ibGVtLg0KPiBHaXZpbmcgbW9yZSBvcHRpb25z
IHRvIGEgY29ybmVyIGNhc2VzIGlzIGEgb3ZlcmtpbGwgaW4gbXkgb3Bpbmlvbi4NCg0KVGhlICJv
cmlnaW5hbCIgcHJvYmxlbSB3YXMgc3lzdGVtcyB3aXRob3V0ICJsb2NhbCIgYmFuZHdpZHRoIGV2
ZW50LiBJDQp3YW50ZWQgdG8gZ2l2ZSBhIHdheSBmb3IgdXNlcnMgb2YgbWJhX01CcHMgdG8gc3Rp
bGwgaGF2ZSBzb21lIHdheSB0bw0KdXNlIGl0IChhc3N1bWluZyB0aGF0ICJ0b3RhbCIgYmFuZHdp
ZHRoIGV2ZW50IHdhcyBwcmVzZW50KS4NCg0KUmVpbmV0dGUgc3VnZ2VzdGVkIHRoYXQgc29tZSBw
ZW9wbGUgbWlnaHQgd2FudCB0byB1c2UgInRvdGFsIiwgZXZlbg0Kb24gc3lzdGVtcyB0aGF0IHN1
cHBvcnQgImxvY2FsIi4gSSBmaXJtbHkgYWdyZWUgd2l0aCB0aGF0LiAgSXQgaXMgZWFzeSB0bw0K
Y29uc3RydWN0IHNjZW5hcmlvcyB3aGVyZSBtb3N0IGJhbmR3aWR0aCBpcyB0byBhIHJlbW90ZSBu
b2RlLiB1c2luZw0KImxvY2FsIiBldmVudCB3aWxsIGRvIG5vdGhpbmcgdG8gdGhyb3R0bGUgaW4g
dGhlc2UgY2FzZS4gSSdtIG5vdCBhdCBhbGwgc3VyZQ0Kd2h5ICJsb2NhbCIgZXZlbnQgd2FzIHBp
Y2tlZC4gVGhlcmUncyBub3RoaW5nIGluIHRoZSBMS01MIHRocmVhZHMgdG8NCmdpdmUgY2x1ZXMu
DQoNCkkgcHJvcG9zZWQgYSBtb3VudCBvcHRpb24gInRvdGFsIiBhcyBhIG1vZGlmaWVyIHRvIGJl
IHVzZWQgaW4gY29uanVuY3Rpb24NCndpdGggIm1iYV9NQnBzIi4gUmVpbmV0dGUgc2FpZCBpdCB3
YXMgdG9vIGdlbmVyaWMuIEhlciBzdWdnZXN0aW9uIHdhcw0KdG8gYWRkICJtYmFfTUJwc190b3Rh
bCIgdG8gYmUgdXNlZCBpbnN0ZWFkIG9mICJtYmFfTUJwcyIuDQoNCklzIHRoYXQgd2hlcmUgSSBz
aG91bGQgaGF2ZSBnb25lLCBpbnN0ZWFkIG9mICJtYmFfTUJwcz17bG9jYWx8dG90YWx9Ij8NCg0K
LVRvbnkNCg==
