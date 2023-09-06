Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC27794399
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjIFTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbjIFTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:10:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9886B185;
        Wed,  6 Sep 2023 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694027433; x=1725563433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E29hsPInXf929E+mvzbpVmZpW9YXktGSOKr8SJNwh38=;
  b=OHoMWhQS0Z7AMz2hq5FpZrpjMZXP+VqkqAup5cVkwxO9p7AM+cWj2uFs
   0jnNoixmUl4tRTIGo27FU4MSoHIURB32U0C8YTHSEv1HxbQQsXhMW6h+7
   Rf4R+qEayQDenZDoFq4WZqWfkaAsIIEf7GhC8b9qzMfYnn28PvNX6Gb2k
   0MoTXccRbmft8ZzZHI1gLDEUVo9ciDEBgkB9+BZQTyvZLWOA4mNTb1p6K
   VVZVHUKbvSXoLzn5JJXiy3ruuiFoYPCCMK1E8ATI6VXrpLdbgqEghdlbp
   FIYe6GCLBpHhSNRRE33gNamrmKZCqW5KNEgxzd0o0Ax+wsRBr49Kjv8pS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441142593"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441142593"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="744796938"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="744796938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 12:08:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 12:08:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 12:08:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 12:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Ff97Gu+lLNahgr+ReeZFYp3+R50h4HzR7WTFnJFMaB9I0F5YDWMAW5pLa3xzoUiwDOjJMUUCoxLuV+FQIMK1QQbgY3ZiM7WWKG4HwGZFJsmj71gaGbNsuL5oxeFWtGBm53uyM7fHwOTzrR+eRusNWVE8hotSqArfpaC5wX9bkzyTYKpKB9W3B3noGZ0QEs2bk6mzT9oGSr25umnHeECokMH+WVoi5TVb6gGuFCvv4vlI0lxctUUfaB2fRj1XO+8+8obH2qjINNMIaQzDPNvOHGUZzNKEXRJix7opNeRJp4Y/eyfg3yqdCUOPVxaC8f43rX+e25jx1XmATmcP0B5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E29hsPInXf929E+mvzbpVmZpW9YXktGSOKr8SJNwh38=;
 b=a81lRujkRgEg4i3pVH3kv20BJpieCcfeGoWrvTY1OUXFKk3qzc3dEBx5J6A8ggHEjIAo3S38T0/dMv7GZzW9wvAHZlmsN+kj/GREPqVkfMtzSGbUlVGfvitCynN36rL1lbWWaNBpgqhdpbA4Ig170jKp9j577986r2s3AZ416jiXCA/W6qegLbSTPsCpZ3DRAMK6ROVKgSi4BKSR9snKbxisedrYBk4hVrb7jgD9v6EDiZqekpo2U04P6t6DoDRJJHe6awsJ+i0niR2WVN9sfzDZrnCSQRTm5k2AIEz87LhtDwwIA0vWXQ7ABk2HTW/EG0ifRFCuyZhb7696krHWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Wed, 6 Sep 2023 19:07:56 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::8e63:702f:2ec9:1150]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::8e63:702f:2ec9:1150%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 19:07:56 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
Thread-Topic: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
Thread-Index: AQHZ4FYIrNzCRClfPEaVBeM5dT+61rANEMIAgADNhgCAAEq30A==
Date:   Wed, 6 Sep 2023 19:07:56 +0000
Message-ID: <IA1PR11MB767796138882E4BCF15FEA20BBEFA@IA1PR11MB7677.namprd11.prod.outlook.com>
References: <20230906000640.2919607-1-srinivas.pandruvada@linux.intel.com>
         <8fc7d9236bfa968b5f202d458e99e2e729fed343.camel@intel.com>
 <b7ec9c4cc181f3fac2d51dff6708913043acc4cb.camel@linux.intel.com>
In-Reply-To: <b7ec9c4cc181f3fac2d51dff6708913043acc4cb.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: 37e04a08-3264-4f65-f169-08dbaf0c9427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mIS0y2vyrW1/gsq2r/iPLyzPshG3LLgnlfCX1m7SrgG2Q7pmQ26uo0maABFN2boksJ7WpKM/oPWDYv4oeaWA6XX2v/O42Ux5BSK5G8q4jMBjqKsDCixEXP+gIDcEWQLBqViM83FXe9m1U7Cc7DiZgYVkDLq7cJ1xjUgty+kN5YgFNPmSM/1GZ39Gg19CAcZIX9Z0fR61Ror5FFBaYSPP02MXh3DdiSqvZAaMHMoHawU+J1t5H0m0Ptzgn3bYtV9ti0zKCBISRLM9zmK91yTxLsVWMy9a/zP5RfRbqDSLB2CLh9ixJylxpt5Q93JexhlgdxUGye5W2bRbaeoFxhQsWEM3B0StHtTNBOsPr23b6mQwM/Y35ZpYOePgSrHLnfXhNQBe2Sd0wpBlqZ0yGOOy2Nb+fKGk1VEvManGtR7A8s+0ev1jnmbsUr4t5D32z5/w27nNq75rVV25ZCYJLyfbzA9js8KNE9eyZNzJMxTIXpQCk5j0TWO1XnH34N3DkdMQJtV6eAuWUSbGCO40GRO3SfQhKEXs5KtXWi4ThxxgD2KjyPoXjmNM0UqeU6I6222gOXp5ocBTrkwjrcjJtWfcfQPOT2Z2GnRWmVRZkKXYSb1D/+n0UQirC2KK7pGJNre
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(8936002)(478600001)(66476007)(8676002)(4326008)(66446008)(110136005)(66556008)(66946007)(76116006)(5660300002)(55016003)(83380400001)(2906002)(71200400001)(41300700001)(316002)(33656002)(52536014)(86362001)(54906003)(64756008)(7696005)(53546011)(6506007)(9686003)(82960400001)(122000001)(38070700005)(38100700002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEU3eVlsYkpkQ2pCTzVLcTB1NXBhcVVjT3Q1UW1sUVBmZmlSK3dMeVZBWmpi?=
 =?utf-8?B?alg4UllFSkh5OFZuY2FMYjRuRmFDT3FzandUQmJBZ3lHYzBhZGNTa1J5ZG9K?=
 =?utf-8?B?eEVmQXpJRDhzclRyYkpsaW4zL1Y2d2ZTOUY4bVpsMWxmTmREalVleSt0U3M2?=
 =?utf-8?B?cXdDTElxcFhqaVRkWHo5emJZRDIyZHYveHlrR3ltZFhtYlBDa2daOWw1TGd4?=
 =?utf-8?B?Y3g0QVlPS012WFBWQ3lKdlFNM0RFMFJlb0cvWmsrK1hHVzN5NW5rMlk1U3hz?=
 =?utf-8?B?c3JNNHJrakY3NmpTMUdNQlVrY2lyeVpNMEdlb094T1VtZFNJWWg4aWxEcEY1?=
 =?utf-8?B?WG5JenNwKzdzUnM0T2ZOMlBPcmhHMTUxZjQvNno0aFR0STRSTTJlZFpFMTNM?=
 =?utf-8?B?VnpIcHlkUGhxNTZlL1hjTHErSko4ZXRDNHFVOEtDMmgycTZZbEZhb21DUW1H?=
 =?utf-8?B?djcwVklYbWdXSGtFTVkrNWFvVUhqekxyQlFUTk14V09TaDRnbW5kNXBoRURl?=
 =?utf-8?B?Z3I2VFE4YlRDODNub2tnSXRRcG94dDRHM0dwSEZRZ0N1T3F4UWVpTkhXRlJi?=
 =?utf-8?B?d2h5cmVIcmdIRXhEUjIrRXc1ZVIyQ2FSd2FnaTRVNkRVaUVuZm9NbUI0TEhS?=
 =?utf-8?B?cnd6cVRHRDFNT0xVdkxOOC8xdFVhUWMvQlpFSFc0MndJQksvRGRDR2w5OFRv?=
 =?utf-8?B?SlZRUmRUVS9yMitVVDVUakUrbDBGSVQyRDJyZ2xuTFdMVWcxWkxsN1MwaGRo?=
 =?utf-8?B?ODdZRDVjRFJWcTkwelRIb20vRDVleXpZUnVkQmh2MDFjODhINWpvU0gzdG54?=
 =?utf-8?B?aWRER0VXMGdXblhnVkdIYVA4UWZFdVNLL0lNU3hRZXhXUVlIVnBueElxaWxL?=
 =?utf-8?B?em5oTzA3RDdnZUNKM3V1cW1JWkluN0JIZnRiRXF6REdmdGlVc0ZlaUJpbHYy?=
 =?utf-8?B?UlA1YkhXbjZxTXl6elNuKy9QcDZzbmJQZEZYdkh0RlRLYXNzWlJUcmlOeWlu?=
 =?utf-8?B?WXB3YlF0bU4xRUVCL3NveVFQZFlGSnkwWExTMm1OK0ZuTVNqemNmcVRXbjFV?=
 =?utf-8?B?amU0VUIyZ2Y2NnlNOVltRE1mREF1cmZuN01MVlluS0Zob1YrQ1VMNzdKZ2Fy?=
 =?utf-8?B?RjNsU2oySGRHVGEyTXJWK1lHME9yNzlXZHZIMlBTaU9zTC9WY21rR0lLdnpO?=
 =?utf-8?B?VmUvOWdla3E3azZFNzVCMHd3a1ArRG0vdWFvaHdLRXFvekFKNHlIM0Q4UWI0?=
 =?utf-8?B?WXhNQWgwRWFFVzRqakVqbHZGTm1sNmk2aDIvQjhsV0ZlTnpqQkFOcGxQMDEw?=
 =?utf-8?B?ZnJXWEZvREovenYvcnU0Vi9jUkNMU2hOSDJ1N3RKeFFvVjFJb2ZZSE5FMGQ4?=
 =?utf-8?B?b1RqSXRHcXcwZnRWVG9OcDZmbHR0UlJZSTBjR3kyTkxZR1BPTElkaDlLdUZK?=
 =?utf-8?B?bCsxY0NFYVJRSXNDbEw0OGc2RVBjbHU3bFgzRlptTkhIWTV5UGdGRDY1ZGUz?=
 =?utf-8?B?NVVnT0FsYktmQVdESHkrS1N4OU1laGREcUwxMFV6M2NTSEVQR0pyZy9wZDUr?=
 =?utf-8?B?N3MyS3F2Qi9xanBVeUVYSE1hQi9oUW41VWlkNFh5V2VOUmJvQVRLQTFPZnln?=
 =?utf-8?B?T3NrL1JpTU5HS1dFZlMwZlhUakc5anVud0ZOMUpZeHdDZkkwM2VleHpkNUN1?=
 =?utf-8?B?dlhjV0dkUlBVZkZ4azVPRWRjTW93empjRW5EZU1VMG5sbjRJOXZiSkc5cnFk?=
 =?utf-8?B?cGNEOUVyeVR5T1FZanp3V09SQUYxclVjNDAvOXUrSUhnZmUwMWdqYW9FRkVs?=
 =?utf-8?B?YUwrbURnaWZpRUt5VnJyTjBpc1F5SkF5RDYycVBHWnQ1b3dSVFQxNWtldHdU?=
 =?utf-8?B?OVpqck9wNkRBdG15SXgzNXJTN2t1NEs4eFVvRlZXOEw1bU03LzUwdGJtZlVP?=
 =?utf-8?B?Q2wydnYwOUVTbzVEdVdjYTJpTUw2bVp5MTdsbGJmdUY0YWNtdzFFc2hiZ3Mw?=
 =?utf-8?B?b2NsUW9GTEpWbnpneUJTbWJZUGJOMVhza29CVUxmMDJPWEk5VGhlRUk2TnE4?=
 =?utf-8?B?UTc4YkZ4OVZYa3RFQW1ueXZsRmpyWHk2azJ1RlJ6RWNaZkhnK2Z3c2VZT3RK?=
 =?utf-8?B?Q2FReVFLb2ZpODREdENrUWkzVllIeFhYZmJFT3JRbFFNRzB0ZXRQK0xoVlFu?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e04a08-3264-4f65-f169-08dbaf0c9427
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 19:07:56.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unIOz8QwON2DyHHWB+Hfj6Qj035qOLsByVzj6Af5QjLcIVrlAcwR5lL9J9gNaDbLtkcpnV8oI+fh4Qq1P58hTD+OUOkdffySqog7HtJ1AVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc3Jpbml2YXMgcGFuZHJ1
dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgU2VwdGVtYmVyIDYsIDIwMjMgODowNiBQTQ0KPiBUbzogWmhhbmcsIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT47IHJhZmFlbEBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IFBhd25pa2FyLCBTdW1lZXQgUg0KPiA8c3VtZWV0LnIucGF3bmlrYXJAaW50ZWwu
Y29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcmNhcDogaW50ZWxfcmFwbDogRml4IHNl
dHRpbmcgb2YgUG93ZXIgTGltaXQgNCB0byAwDQo+IA0KPiBIaSBSdWksDQo+IA0KPiBPbiBXZWQs
IDIwMjMtMDktMDYgYXQgMDI6MjAgKzAwMDAsIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gSGksIFNy
aW5pdmFzLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPiBPbiBUdWUs
IDIwMjMtMDktMDUgYXQgMTc6MDYgLTA3MDAsIFNyaW5pdmFzIFBhbmRydXZhZGEgd3JvdGU6DQo+
ID4gPiBTeXN0ZW0gcnVucyBhdCBtaW5pbXVtIHBlcmZvcm1hbmNlLCBvbmNlIHBvd2VyY2FwIFJB
UEwgcGFja2FnZQ0KPiA+ID4gZG9tYWluICJlbmFibGVkIiBmbGFnIGlzIHRvZ2dsZWQuDQo+ID4g
Pg0KPiA+ID4gU2V0dGluZyBSQVBMIHBhY2thZ2UgZG9tYWluIGVuYWJsZWQgZmxhZyB0byAwLCBy
ZXN1bHRzIGluIHNldHRpbmcgb2YNCj4gPiA+IHBvd2VyIGxpbWl0IDQgKFBMNCkgTVNSIDB4NjAx
IHRvIDAuDQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBidWcuIFNldHRpbmcgZW5hYmxlZCBmbGFnIHNo
b3VsZCBvbmx5IGFmZmVjdCB0aGUgRW5hYmxlDQo+ID4gYml0IGJ1dCBub3QgdGhlIG90aGVyIGJp
dHMuDQo+ID4NCj4gPiA+IMKgVGhpcyBpbXBsaWVzIGRpc2FibGluZyBQTDQgbGltaXQuDQo+ID4g
PiBUaGUgUEw0IGxpbWl0IGNvbnRyb2xzIHRoZSBwZWFrIHBvd2VyLiBUaGlzIGNhbiBzaWduaWZp
Y2FudGx5IGNoYW5nZQ0KPiA+ID4gdGhlIHBlcmZvcm1hbmNlLiBFdmVuIHdvcnNlLCB3aGVuIHRo
ZSBlbmFibGVkIGZsYWcgaXMgc2V0IHRvIDENCj4gPiA+IGFnYWluLg0KPiA+ID4gVGhpcyB3aWxs
IHNldCBQTDQgTVNSIHZhbHVlIHRvIDB4MDEsIHdoaWNoIG1lYW5zIHJlZHVjZSBwZWFrIHBvd2Vy
DQo+ID4gPiB0byAwLjEyNVcuIFRoaXMgd2lsbCBmb3JjZSB0aGUgc3lzdGVtIHRvIHJ1biBhdCB0
aGUgbG93ZXN0IHBvc3NpYmxlDQo+ID4gPiBwZXJmb3JtYW5jZS4NCj4gPiA+DQo+ID4gPiBUaGlz
IGlzIGNhdXNlZCBieSBhIGNoYW5nZSB3aGljaCBhc3N1bWVzIHRoYXQgdGhlcmUgaXMgYW4gZW5h
YmxlIGJpdA0KPiA+ID4gaW4gdGhlIFBMNCBNU1IgbGlrZSBvdGhlciBwb3dlciBsaW1pdHMuDQo+
ID4NCj4gPiBNU1IgUkFQTCBkb2Vzbid0IGhhdmUgUEw0IGVuYWJsZSBiaXQsIGJ1dCBUUE1JIFJB
UEwgZG9lcyBoYXZlIHBlcg0KPiA+IHBvd2VyIGxpbWl0IGVuYWJsZSBiaXQuDQo+IFRoYXQgaXMg
Y29ycmVjdCwgYnV0IG5vdCBzdXJlIHRoYXQgaW4gcHJhY3RpY2UgdXNlZCBvciBub3QuDQo+IA0K
PiA+DQo+ID4gPg0KPiA+ID4gSW4gZnVuY3Rpb25zIHNldF9mbG9vcl9mcmVxX2RlZmF1bHQoKSBh
bmQgcmFwbF9yZW1vdmVfcGFja2FnZSgpLA0KPiA+ID4gY2FsbA0KPiA+ID4gcmFwbF93cml0ZV9w
bF9kYXRhIHdpdGggUExfRU5BQkxFIGFuZCBQTF9DTEFNUCBmb3Igb25seSBwb3dlciBsaW1pdA0K
PiA+ID4gMQ0KPiA+ID4gYW5kIDIuIFNpbWlsYXJseSBkb24ndCByZWFkIFBMX0VOQUJMRSBmb3Ig
UEw0IHRvIGNoZWNrIHRoZSBwcmVzZW5jZQ0KPiA+ID4gb2YNCj4gPiA+IHBvd2VyIGxpbWl0IDQu
DQo+ID4NCj4gPiBJTU8sIHRoZSByb290Y2F1c2UgaXMgdGhhdCB3ZSBleHBvc2UgYW4gbm9uLWV4
aXRzIFBMNF9FTkFCTEUNCj4gPiBwcmltaXRpdmUNCj4gPiBmb3IgTVNSIEludGVyZmFjZSwgYW5k
IGV2ZW4gd29yc2Ugd2UgZXhwb3NlIGl0IHdyb25nbHkgdGhhdCB0aGUNCj4gPiBwcmltaXRpdmUg
dXNlcyB0aGUgcG93ZXIgbGltaXQgYml0cy4NCj4gPg0KPiA+IENvbW1pdCA5MDUwYTljZDVlNGMg
KCJwb3dlcmNhcDogaW50ZWxfcmFwbDogQ2xlYW51cCBQb3dlciBMaW1pdHMNCj4gPiBzdXBwb3J0
IikgcG9rZXMgdGhlIE1TUiBpbnRlcmZhY2UgUEw0X0VOQUJMRSBwcmltaXRpdmUgYW5kIGV4cG9z
ZXMNCj4gPiB0aGlzDQo+ID4gYnVnLg0KPiA+DQo+ID4gU3VtZWV0IGlzIHRlc3RpbmcgdGhlIGJl
bG93IGZpeCByaWdodCBub3csIGFuZCBJIHN1cHBvc2UgaGUgd2lsbCBnaXZlDQo+ID4gc29tZSB1
cGRhdGUgc29vbi4NCj4gPiANCg0KVGVzdGluZyBzdGlsbCBnb2luZyBvbi4gDQoNCj4gPiB0aGFu
a3MsDQo+ID4gcnVpDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRl
bF9yYXBsX2NvbW1vbi5jDQo+ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9u
LmMNCj4gPiBpbmRleCA4ZmFjNTdiMjhmOGEuLmQ0MDdmOTE4ODc2ZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJz
L3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiBAQCAtNjU4LDggKzY1OCw2IEBAIHN0
YXRpYyBzdHJ1Y3QgcmFwbF9wcmltaXRpdmVfaW5mbw0KPiA+IHJwaV9tc3JbTlJfUkFQTF9QUklN
SVRJVkVTXSA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgUkFQTF9ET01BSU5fUkVHX0xJTUlULCBBUkJJVFJBUllfVU5JVCwNCj4g
PiAwKSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgW1BMMl9DTEFNUF0gPSBQUklNSVRJVkVfSU5GT19J
TklUKFBMMl9DTEFNUCwNCj4gPiBQT1dFUl9MSU1JVDJfQ0xBTVAsIDQ4LA0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSQVBMX0RPTUFJ
Tl9SRUdfTElNSVQsIEFSQklUUkFSWV9VTklULA0KPiA+IDApLA0KPiA+IC3CoMKgwqDCoMKgwqDC
oFtQTDRfRU5BQkxFXSA9IFBSSU1JVElWRV9JTkZPX0lOSVQoUEw0X0VOQUJMRSwNCj4gPiBQT1dF
Ul9MSU1JVDRfTUFTSywgMCwNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBSQVBMX0RPTUFJTl9SRUdfUEw0LCBBUkJJVFJB
UllfVU5JVCwNCj4gPiAwKSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgW1RJTUVfV0lORE9XMV0gPSBQ
UklNSVRJVkVfSU5GT19JTklUKFRJTUVfV0lORE9XMSwNCj4gPiBUSU1FX1dJTkRPVzFfTUFTSywg
MTcsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFJBUExfRE9NQUlOX1JFR19MSU1JVCwgVElNRV9VTklULCAwKSwNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgW1RJTUVfV0lORE9XMl0gPSBQUklNSVRJVkVfSU5GT19JTklUKFRJTUVfV0lORE9X
MiwNCj4gPiBUSU1FX1dJTkRPVzJfTUFTSywgNDksDQo+ID4NCj4gPg0KPiBMZXQgbWUgdHJ5IHRo
aXMsIGJ1dCB0aGlzIGlzIG5vdCBlbm91Z2guIFRoZSBlbmFibGUvZGlzYWJsZSBpcyBhbHNvDQo+
IGdldHMgY2hlY2tlZCBmb3IgcHJlc2VuY2Ugb2YgUEw0Lg0KPiANCg0KWWVzLCB3ZSBuZWVkIHRo
ZSBjaGVjayBhcyB3ZWxsLg0KDQpUaGFua3MsDQpTdW1lZXQuIA0KDQo+IFRoYW5rcywNCj4gU3Jp
bml2YXMNCj4gDQo+ID4NCg0K
