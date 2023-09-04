Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB8791014
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbjIDCPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:15:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3C9B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793705; x=1725329705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=esBp/XBGjCJ+xvuRKs750xs0az2z/T5Fc1HFAAsDZm4=;
  b=gaTJ+ppHNQaAfHZ/4c4bzL8xO/+If5O62eC0Mb2jA7OgwbyZJeNrrn/D
   FAg4rYpo2Acgm9xxPzsN4TgL2/V4srFoFnbhJp9so/HsCty1V30jkCGNp
   OUh8lweD35mW8hiTZSROsfGwRVtcZtYD0svZfCXtuteHt443Mr50hlXLJ
   0BqzfeCcucc8FFxyy0nzkKLrDvQq9xpigBRD5YGPi8DLOPxpla1Ctr2Bf
   9rYxZBIhZohz8O1LMS5Ul2mJtbFoOkWyC3SX4rQgLRbpAGwUdxd5yjjEB
   JvPpij+QpEuVRSRYUZnGqrfavXa3FBf7Fmhn22k7+YBYy79fJXw4nuBfi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380293008"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380293008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914345695"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="914345695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 19:15:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 19:15:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 19:15:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 19:15:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 19:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEq5iZKdv8ryfLGQL/9Pn8uALNm5aYgD5dRmLquu4YoYhkxh1wAbTUYzGoFvhPi/Ek8TmPZaU3dZHzFys/pKBfL70QYa9YxGGTD9uJSOM8Mn4dpmGsO2moPgRVwi1MvYmfBvpfZiRGZulf4JBh6fbuQkITB3Xg1C8mzCGBZ5GgLDljK2uIlG7xqBPt/WSHc3zu24DLLOBQ26Vr9jNP0LMCuib93SOyLlFatz6ly1JDxRfnkmlye14k9UkT4yVi7tff0khZmQeQGNM+JEh9fRskz7RjFzCjUqgPalBdVodmcQAs8R7LWpdlnCAAG26xYp5seuuXMHbvZdZx9ZflpKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esBp/XBGjCJ+xvuRKs750xs0az2z/T5Fc1HFAAsDZm4=;
 b=BPLEgWhxIiI1R9tV7OJXic06Av6wTD2a0wpAB+jvBSXMs6Y/N5qjR6jrz5zRZPtKjBUKniVibSTHC9NuYIwyp+svHQX7BvYl6OjeiiX0YjMe2DWy1A+iOqAN53rCQFDvrrCYChE5vCYUYR3ZjBwWpA7XaXEJoHVxOK34uMR29zkP8qs+dyPzKBHq3mF6w1JW1RfmjY9RCzCQpl8HBgazq47qRK3T4vzh44y6bwa3FUjkGQnTsNKgBy2eAVVtCoi6fEAZO3upasWYuDjROMlKh8294I6eCkUicZW837j+P6yF/lxa2qZ0DmrFiZrOLHRS+txCMyRFVl+xCf4vPBzX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 02:14:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 02:14:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Thread-Topic: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Thread-Index: AQHZ23juqM3HPepUpkiDz/Fyv97nIbAGGhqAgAAUWICAA8XKgA==
Date:   Mon, 4 Sep 2023 02:14:55 +0000
Message-ID: <4ff19f7c31b13a63756f40de69fbf8a24fe3bb08.camel@intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
         <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
         <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
         <64f2137362305_4c1f3294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <64f2137362305_4c1f3294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7173:EE_
x-ms-office365-filtering-correlation-id: 840c6d06-8342-4d0b-be49-08dbacecbb2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCtQxjuouruInbNl7De1VW/PLvesCIfYEprKQHT7kmOIEMc0f5fMhePeJ2E3+gro0LPQBSVBns5JoSaWUqAsczXCQJkMwF/w7QGue4eJGqL7lyqa5/Z6DNMutl1IlPtzzKaFcz7N23sBFC+Plhya5KrSm/lCTzEtGl5SM18Z9/Fd577DwIo/RVK+u9I4APb9zzwH1yDwvJgkOmFKtBIbWzCuAiF6KilcmvmEQJHq7QK+nG/DfHVKXFvsAS3aWiCnQCEVnC5apnF9Q3fDsiwM1AFJ+c8AWEx+DLv1jYDOj/ou7tWjiSgKBU86XxonmrEqQKosZ5+CqJwZDSVGyh4M3d1AzWZzlHLthUA434cy+m0ihKHn1KJeZ/H4o/n/yay1psARUcA0apHBlYD1U31y3pXNXmG1cwg9+m1cA4eUEw2hMvYsS6R31Lm5NcohgwCwTADxEENcwQuDL9XULZ6IG61p49IMdxSfmNdnVOH/riAS/ZMVPORoiDDBrbdGCYqA5GntADwUiYj+5SY16fZILuW14tkQs8rSClH01KKjZVp/hmxGlqGrHQN6RFR49+V9/WtOMA+KYRxp2KshFYhtX1VN6M2swib3rbekgTjWtlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(186009)(1800799009)(451199024)(478600001)(71200400001)(966005)(91956017)(110136005)(64756008)(54906003)(66556008)(66946007)(76116006)(66446008)(66476007)(26005)(2616005)(6486002)(6506007)(6512007)(2906002)(8676002)(4326008)(8936002)(316002)(41300700001)(7416002)(5660300002)(86362001)(36756003)(122000001)(82960400001)(38070700005)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1dmNjBXWmZza0kwK3RoL3V0SUlTYTBkUjg4c0V6bW9DZDhIWHkwK29UUVhC?=
 =?utf-8?B?aENRdW5qajdtS1kzOTZnMWtZY3pZU21qS3dhaEtkM1NRQWFaVkFXY2NqRDlX?=
 =?utf-8?B?VFRIRXUxa1RyL2d6Z2hEVkNnM2hjN09kWjJrRTUwWDN4RGs4cGtRampSOXFR?=
 =?utf-8?B?K3VzOXNQbHBxYU5YSXJhK3hENDhJYVhLYUtRTnlPczNINFZsYVhqNGc1Y3Rx?=
 =?utf-8?B?SmZqb2NGUzFZRWhOTGx1cUg1M0dEbGFjTG5KOUp1NWhqYVMzNVVjamc1SlVa?=
 =?utf-8?B?T2lIeGRCak9uVUZsK3V1b3YwWkVHMHRsYVhneXd1SGxHUTQvVFA5aWloVUhn?=
 =?utf-8?B?SVVpV2ZyREY2U0Z5QVdreFQ4aks1VVhaOEF6Q3ZPZFBMdUNOUnk3a3hTYkFR?=
 =?utf-8?B?bGFvWWNaQVlveWk4YU40cDl1NE14MHJ2a1ZUall1MmxHU3Y4TExvUkpFRytF?=
 =?utf-8?B?TnFCSmFiWXVDY2tuWjc5TmlHZjNDdEhnRDM5VllQLzA5ODR0eGVTSC9STEdR?=
 =?utf-8?B?bTg5eTdvYnBKckk3YURvU3JZWVpkaTc1TWVybmxySFU4S011UXRXbXp4aU9S?=
 =?utf-8?B?aVlzRmwxa0VoNDVqVVorbUVYeDlRVnNEU2ZKRm5TaU81V1RFMUZkVXhobG81?=
 =?utf-8?B?cWFrQllvcm9aWFRVRS9ZUDdLS2hacjdKVTJQbWxoWU9UaHZNaENRMlUyTGVC?=
 =?utf-8?B?OGYvZ1dtZVgzMEtxbkwzaTgwczdhYnRjaFBHY010M1RSU0lpbE9CU3NmdVpG?=
 =?utf-8?B?MDNoemdpdDg1c2I1UENIOU5yTzdpWElXVlNWTzRTWDlzSzEyT1RjZkkwZ2JI?=
 =?utf-8?B?bk5YZzVvYk1sUjAvM2I3YjRWd1doV21kQWlRaE9ZSGVkeXRNcnY4alYxVk5E?=
 =?utf-8?B?TlFEc1orbHJaVStLcWprWFA2dStUTVV4Y3F2aUFCWUhabkVBQVpkR0VZdVEz?=
 =?utf-8?B?TmpvOG9kRVB5b2p0a2NTSDk5R3E0cFRxb0FvcFkyZ3A3VkdVNTRSb3pKR0VC?=
 =?utf-8?B?RUsyZSt4YkRnMlkvbEdvSlpSNlZqa3pvdlRXY3ZKRVpzZmJMTUREa05QT1Q5?=
 =?utf-8?B?TWVxNEppZ2xEOVBJZnZTajNvUFRsTzhTN2RXQlJGYk8vamhXSHlpMXJUV2RW?=
 =?utf-8?B?dzkwVXRHYVBkcWkreDJ6STRRZWh3V2wrZjc3dGdTQ2NlWnpmK1pCT05qeHJV?=
 =?utf-8?B?RENub2VVMll0d2J2dm1POXNYdGFURDY1UU5GcCtJbEh1ZjlMV24yVkY4UllQ?=
 =?utf-8?B?UERqUThIY2lPZEE1TUVLNWpSeGxabERKYW5FbnM2RUIrcXBObmNlbzd6cGtJ?=
 =?utf-8?B?RFhrS1RZVWNpWVVjMVp3OWdPb0JRLzRreFZjR21zK1ltUTVWUjJoM0dvVVdq?=
 =?utf-8?B?dGgzUlRkOUJZblR5d1o3cWV2SDRSOGd1bHpQUjd4aUV6bVZ0VGdicjA3cHh5?=
 =?utf-8?B?RGVNQ09vVExFTEV6TW5hK0p2VmhRbGJmcWhrbXpQOHJveVBvNW45TVRaVGNv?=
 =?utf-8?B?MlIzTDhlN1ZHZEpSazYydUhhb0lWbXVKRFd2TW5WUmN2b3V3OHJlU25FbENX?=
 =?utf-8?B?aG5NYm5hdkdJZ1FkMlBDTDlwTktnMlZiSmFhWFIyWDMzYzkwaCtlbFg2cDhx?=
 =?utf-8?B?bm9uRW5pZXZRM2M2dkhQR2tYNDdPZ3JsaXRWRFJvMmhUSUo4eUhlc2lLZWYz?=
 =?utf-8?B?bkVsR3BwRFJmaitQL0RocGh2YlVwdEVJSHRJQlhNTWwzT091V3RBTm9xbGVF?=
 =?utf-8?B?TjFpOEVCWlpMT05qbDVmTGJFT3cycTRmOUVscTZTV3gwU0tlLzZsRmlOVy91?=
 =?utf-8?B?N0RwSTYxcTd2am9VNHo4MkRtTVNGVWdWSFFkd2pXNDVDZjVrQ3Q4WENlVmxw?=
 =?utf-8?B?R0NZbk13aGFkRHAxVTBET3hBVndXZWlHWEZtdFpwa3loQVhqc0FtVmlvcStC?=
 =?utf-8?B?d1RqRnpnaWMzVUNhd09vZnVCNyt3azdwTXlBdWZlRnVjc2w0QVBha2VOSFhj?=
 =?utf-8?B?Mzh1SDRQR0xFUGFVaVZWdEV0OTQ4ZFNKSFE0UUdlbCtGNU0zVlc4YkYxcnFp?=
 =?utf-8?B?V2xwMU9WTnlzRUtqSU9Lc2NvWEM0SXlTcjIzSlFvV0ZsM0dDbE9DZzNWLzJx?=
 =?utf-8?Q?r/umdAiEs5m0cAfYfg2qZm3Ma?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DE4CF3C21065D408125D58543224220@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c6d06-8342-4d0b-be49-08dbacecbb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 02:14:55.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq7e+PNHX0qEDHlNC0gLHMVGMrOx9+vT9d3q69NJvVnqjGwuqZayJURACr7rbJr72eG7CU8O4EQ1bDMjETWHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
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

T24gRnJpLCAyMDIzLTA5LTAxIGF0IDA5OjM4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
ID4gVGhlIGV4dGVuZGVkIGd1ZXN0IHJlcXVlc3QgaXMgYW5vdGhlciB0b3BpYywgc2luY2UgdXNl
cnNwYWNlIGhhcyB0byBiZSBhd2FyZSBvZg0KPiA+IHdoZXJlIHRoZSBrZXJuZWwgY2hvc2VzIHRv
IHB1dCB0aGUgZXh0ZW5kZWQgZGF0YSwgYW5kIGZpeHVwIGFsbCB0aGUgb2Zmc2V0cyBpbiB0aGUN
Cj4gPiB0YWJsZSAoc2VjdGlvbiA0LjEuOC4xIGluIFsyXSkuIEl0IHdvdWxkIGJlIGJldHRlciB0
byByZXR1cm4gdGhpcyBkYXRhIHRocm91Z2ggYQ0KPiA+IHNlcGFyYXRlIGZpbGUuDQo+IA0KPiBJ
IG5vdGljZSB0aGF0IHRoZSBURFggcmVwb3J0IGFsc28gaW5jbHVkZXMgYSBjZXJ0aWZpY2F0ZSBi
bG9iLCBzbyBpZg0KPiB0aGF0IGlzIGEgY29tbW9uIGNvbmNlcHQgdGhlbiB5ZXMsIGl0IG1ha2Vz
IHNlbnNlIHRvIGhhdmUgYSBzZXBhcmF0ZQ0KPiBmaWxlIGZvciB0aGF0Lg0KDQorIFNhdGh5IGFu
ZCBJc2FrdS4NCg0KSXQgaXMgYSBjb21tb24gY29uY2VwdCBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBv
ZiAiY29uY2VwdCIsIGJlY2F1c2Ugd2UgbmVlZA0KY2VydGlmaWNhdGVzIHRvIHZlcmlmeSB0aGUg
YXR0ZXN0YXRpb24gYmxvYiBhbnl3YXkuICBCdXQgaW4gaW1wbGVtZW50YXRpb24sDQp1bmxpa2Ug
dG8gU0VWLCBURFggZG9lc24ndCBoYXZlIGEgY29tbWFuZCB0byByZXR1cm4gY2VydGlmaWNhdGVz
IHNlcGFyYXRlbHkgb3INCmluZGVwZW5kZW50bHkgWzFdIC0tIHRoZXkgYXJlIGVtYmVkIHRvIHRo
ZSBRdW90ZSBpdHNlbGYsIG9yIHRoZW9yZXRpY2FsbHkgY2FuIGJlDQpmZXRjaGVkIGZyb20gSW50
ZWwuwqAgDQoNCk1vcmUsIGZvciBURFggKFNHWCBiYXNlZCBhdHRlc3RhdGlvbikgY2VydGlmaWNh
dGVzIGJsb2IgaXRzZWxmIGlzbid0IG1hbmRhdG9yeQ0KdG8gYmUgcGFydCBvZiB0aGUgUXVvdGUu
ICBJbnN0ZWFkLCBURFggUXVvdGUgY2FuIGNob29zZSB0byBpbmNsdWRlIHNvbWUgbW9yZQ0KYmFz
aWMgcGxhdGZvcm0gaWRlbnRpZmljYXRpb24gd2hpY2ggY2FuIGluIHR1cm4gYmUgdXNlZCB0byBn
ZXQgdGhvc2UNCmNlcnRpZmljYXRlcyBmcm9tIEludGVsJ3MgcHJvdmlzaW9uaW5nIGNlcnRpZmlj
YXRlIHNlcnZpY2UgWzJdLg0KDQpbMV0gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHdlIGNhbiBhZGQg
b25lIG9yIGFscmVhZHkgaGF2ZSBvbmUgaW4gdGhlIGxhdGVzdCBURFgNCmRldmVsb3BtZW50LiAg
TWF5YmUgU2F0aHkgb3IgSXNha3UgY2FuIGhlbHAgdG8gY29uZmlybS4NCg0KWzJdOsKgVGFibGUg
OTogUUUgQ2VydGlmaWNhdGlvbiBEYXRhDQpodHRwczovL2Rvd25sb2FkLjAxLm9yZy9pbnRlbC1z
Z3gvZGNhcC0xLjAuMS9kb2NzL0ludGVsX1NHWF9FQ0RTQV9RdW90ZUdlblJlZmVyZW5jZV9EQ0FQ
X0FQSV9MaW51eF8xLjAuMS5wZGYNCg==
