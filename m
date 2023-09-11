Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDE79B874
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjIKWZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjIKKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:01:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86AE68
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426453; x=1725962453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JEXxzat980uRvdBvW2yUI0w2hPvrUKpuS8dRPFLIp+o=;
  b=TXHEnYNCzkdZXoscd34hy4leFWYk3gjWWa56TwjkMujnX08zEAhixHZV
   Cfvral0V9EpJfHi5/mnaM/pjrRpzutJUqUXNYCF5yeTZq5oSViWXshE/l
   kCiD969w2kg5fkD7eLsSoLNw4bOwjBVflITn5o9fLPnJTyczDGKbgunuT
   tCy8O21waJ4R9YhRhTjT3sFqL1fzj2Zjqk2HjmPiTleyEtHCTH5vtOhvi
   hWsYLcoj3lZcPJxxkMHliAcUKnN+MRVF0d+PmfOgVkoq9jhzf9JKVd0Df
   jhSL3kH2CNNecjFSE6wIT3Pc53pCkF4zPFEVnMxOem69w2GzvVuPhvExk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="357482629"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="357482629"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719936984"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719936984"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 03:00:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 03:00:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 03:00:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 03:00:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 03:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L18nsWVWDvYGVBSosQELcuQKv8ySejB155557YBo/RZigK6351CJeDDnhUNJ8SXmODKWSP0fZvicfGoGY5SaY8EFq+N9SDjUZ7MWbsaOR1rnN8S2AZ5gS89xKYa+qitotAZMUMeLkKS52BgjRsOpa5LyCUXyrusGACnvTcDkSwkZAvfPvW9VGifIiFq589+wGl3DtMbB7rR2+lzCMOgBdYMUz9W+FnEtkiV0CIB5E8jCAluPOJYXEC6xtUqUNMNMvFaoDOPk0qGjimZcdr6oRVH1rfj6VwQ5RRq37COGJPlLe30uHauS911SlmDTsuVPRd2VIR3YtFRKpDsgI79F2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEXxzat980uRvdBvW2yUI0w2hPvrUKpuS8dRPFLIp+o=;
 b=nTY+0K7iFJa+27sX+Ix1wUNcX5iw4YJ9hHkXUgKznSpzJqz2C7BPRts9I3TP1t8neZn4p647LivbMzYa9bG8ko9iDqPSKIcCfc3J+HxJLwVusy+3InEq9hk2s+0s6SbpWDiuuzAiO3oY+LUksFTT+6OGyyWk5EtFXC51EIf/zXjS/MWA9nWqBQiC/3vCcxLCWCsTUTbHjUFkoRgScPEdsZy+MU7593Iwp4nw9J8lov4ZVHkvlyQrGDc9EMyfNmVmFFomM408djw4yfcSwqkaJLeqH5b4M4cDWE42Tz2V+3Hk2JH3DqivQiQloCuU7B5mxxR+pc1ko+D9hKrUUQkWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:00:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:00:42 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Thread-Topic: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Thread-Index: AQHZ4Tat9x0/TMaw9keTjiStSWxYFbAQXXIAgADApQCABE0egA==
Date:   Mon, 11 Sep 2023 10:00:42 +0000
Message-ID: <3d02956a10ecab06e634ffdf6820c600f02deb17.camel@intel.com>
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <da4a6c3f4cb9118e10866cb1d624ad5ec5c96d7d.camel@intel.com>
         <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8133:EE_
x-ms-office365-filtering-correlation-id: 39fcaece-2f52-4736-0b28-08dbb2adf5fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ICqX9hQKt2BptDZ7ScH5QiSss670lS3YjngXCQGEuAwi8ttwn9gKCw+/Z0v0CqZe2+nHq0D1WfL+/OOiUoTQYru/XGg+aduimhtPMtlnrOGArEZrW9euo5f+DrvsAomXnuHGiADnYwsn/0Evp4yW0rRKz/y+cHmHfeDn7HzViLokeVx9M37y6KP9syZI/gW1D0yCzbh0vqtiA8x2ELLKzIrBmHctP0yJjtABc8AYmadrtN/cYkt0BYgNWvs+9YNI6oXRwkLvn0m66TIVPjwiUF8ElySYuqDNn01nJM5XsQI9eKQj/kQUoAEUtiTGZszNH4OkH+M+LpzxYpEAFD/5uydmgx0e/+mkiISWfaPKz0eAjS8A4x1iddkEwIukndOgagrJLbgkJol9H8eXKdulXhEkYJD5aYF+XvWQX3sTnJL/dv9iHvb9KfrWgqmp9/qUFph62qxi+lr7y7eU5GpbnUbxq/xDaufZhtO2FxaTnmG87M3HcZLYv7EwYotDZhXEGIpf16GGVr1jdX8MjbPa4C/PNZbd+c7RX5Lzi4wJIiGnjHL1uRl5UBcDFe7RxdH/kAguHRYUcMLWaFygwd6ngXks3+H5ZXedvJmhAp96BhmD9vU6G8mxeCJV6KuU4dB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(1800799009)(186009)(451199024)(76116006)(110136005)(91956017)(26005)(2906002)(86362001)(83380400001)(6486002)(71200400001)(2616005)(6506007)(7416002)(82960400001)(38070700005)(6512007)(122000001)(38100700002)(478600001)(36756003)(5660300002)(8676002)(8936002)(54906003)(66446008)(64756008)(66476007)(66556008)(4326008)(66946007)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K28vU1JSd3dMNy94VW56Y2ZGLzBSc0xlQittSXp1ZmdvUWQ4eVlSTFhpMjBY?=
 =?utf-8?B?NzkrdEhSSXVSQW1DdWFMYlhUR25BTmlYZ1Npa0EzaGhhbVNvcUdteCsyRUM4?=
 =?utf-8?B?bDE0M3lSckdCQW8vdUpzUndlcnd1WDhJYnVEN0xCblIrZmhjdGRFelU0Nkdx?=
 =?utf-8?B?Y09oQWJjLzZERnlmUytjTEYxdU05a2twNzY5UHZXdUtVbkdiS2daUWxsU1dS?=
 =?utf-8?B?R0JhLzQ4Z1BncnNYdWpWV245aXVEVVJzWlhoV1Rwdk1lWStRYlQ1eS8vbkdI?=
 =?utf-8?B?bHdnVFIzR0ZBRjRDSU41bS9tK0Q3R3daUUowU2llK3FiU2lWR2N5S2V2d3RH?=
 =?utf-8?B?ZERxK1AxQ1Q4Nm9iMi80QlVDVXZuek0zVUVOR1IzdlluYStPbVU1RnhBdngv?=
 =?utf-8?B?S3lPaW14a3lGblBMdFM4SHVBamVsQi93RXFoWWlzSTlKcHBYQWJ3K1hVakxT?=
 =?utf-8?B?QytmeGVYWGxTSk4rTWQxOC9nbTltOWREOWUwT0lEVk9Sckk4WGtnanZqcnlU?=
 =?utf-8?B?aWJQdGpoMzloTDcyUnYwLzl5MFlINitjWHpVWmVXTXhKa1FhMVovMnV2dGNq?=
 =?utf-8?B?dkJ2TldMdzFMeE9RbEg1SjVZWE9ndDlMTS9jTVhOS0RHN2FyNVRCdS95cjhr?=
 =?utf-8?B?dzZDekQwenlnWUNoREFjNmx1R3k5QmVabWZkZExHa0RkRm1sTDRrTnFLRFJL?=
 =?utf-8?B?eTBoNmR2MFdkeHF5MjhlMDdTajh4ZVNweEVlUmpiRHcveE9rQ2xUVHdVOVBi?=
 =?utf-8?B?WmpObE1yMEtqR1NianRoL2E0aUk1RlFZSmxGL1M0SHFxcnlLU3ZBMWVCQ2xQ?=
 =?utf-8?B?cmN4OFRRV2hoNEllSVVVc2ZzeE5Zb3VxQTFEeVN5QTdvQmV4dTRkdkVSR3R2?=
 =?utf-8?B?MUd1TUtUeFBuTUh3VFlxaUkvZ3JzZVVYSE5ja0ZXMDRjR00ycjFzeFZWQllj?=
 =?utf-8?B?RnhWUkVoQ1dJbUZ3VG4xSzdJSlI2Tzd3UEFaaEtpdVVRdVpXOXFOT05RQlBh?=
 =?utf-8?B?UWs1THU2ZGdyRFlIalkyMHh3SGM3NEdyTTZHdmlycEhianFocTF5NitXMlZM?=
 =?utf-8?B?bk5ZN2pDWTNSRm1NVzBSb2J5WkwvUWhnQU93OWdiNzBXV0J5aUd3UTZyeFNn?=
 =?utf-8?B?cWlqd3ZHU0Znemx3TWlURGx4NlRFM3B5U2Jmam1RWTArRktJUUlYUmE4N0l1?=
 =?utf-8?B?emZXM2ptN2h0WHovbUhzbW5UcXNObXVVUzZKeU9QRCt4cGthc2FteExMekp2?=
 =?utf-8?B?SzhJb2luc282MFBPbHBGVGtRMkNWMnlacnlVRDZUMHRaZTUrWXBPY2lvT0d5?=
 =?utf-8?B?eEVVbU1RVmRIKzJsc2VrWU5uYUlodnd2VUJsblhadEdsTHdOa21jRzhLc1Y5?=
 =?utf-8?B?d2R5WU9WZDZweFhsOGxCZWxZTFdjVFpLUWdPQW43VkRubHlWeFVXcjJkc1RZ?=
 =?utf-8?B?V2xkejdML0grOXBkcUN5R2RkT05WOWxuNnNFc2NZWEFmRE4rNEJkcXY2YlJQ?=
 =?utf-8?B?UnJ1Y3Z5cFhmSG1Ib1FhaXNSREhTUnZtV2FWRk1FMElMMkZoeHNEb3M0WTM4?=
 =?utf-8?B?NzZpVFk2am9melJIZm02SlBPTWUwWWpGREplSmZ1b1l2b0pCY1NLcWRqdC9Z?=
 =?utf-8?B?bmRFK1FMZ01vWEZTemZSVFJQMXRFSERPdUhucGo5Qm8rQ1pkaGV0Unk2Ym4v?=
 =?utf-8?B?RFNDbHhvSVAwN1hDOWdwYmllQ1BmZTFwbEhiZXRyeHprVm5YZHVkUmFJYVZS?=
 =?utf-8?B?a3lSbVRWSG1icEp1K2p2YnRLckp4V2hvdm5hT1ZrK2VLMWVLREViVDBGeGt6?=
 =?utf-8?B?TzZFK1ZLWHVBUGdkSGphTkQ0Y2VkcTYvd24wY3BSaGZReHdhZ0pySTRTUzd6?=
 =?utf-8?B?NkZITEE0bVIrS083VWduaTJzZGthS3o4UEdtQ3lqbWF2K1JXck9GaUg2VDJV?=
 =?utf-8?B?SWdjUk9LdFY2L3RqU1VaNTlZd3R6ek9zQmMzUXl1Sng5WE81RlNPSHBWQlN0?=
 =?utf-8?B?TytmSW92K3o4dWl3Mkp6eXliRlFXdVN3S1JYQlppclhBNGoxNTg4ellQVGNi?=
 =?utf-8?B?NTNnWWRqbDFjYW12T29Wa1JHajRQcS85a1FGS2NibmFNMXdoRjU1OXU0KzFI?=
 =?utf-8?Q?QE9eIhNEwkjyLlaGk7QVNz/dR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93473395263E0B49807ECC578680E62F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fcaece-2f52-4736-0b28-08dbb2adf5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 10:00:42.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnRCs1ohJuN0NoWVzCpifqvI975js/8tIGanMw06sG/oSBe6xehoWu77cnBz6brYifIDdSZ+QqjYCk4uLcwryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
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

T24gRnJpLCAyMDIzLTA5LTA4IGF0IDA5OjE5IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gDQo+ID4gPiANCj4gPiA+IENoYW5nZXMgc2luY2UgcHJl
dmlvdXMgdmVyc2lvbjoNCj4gPiA+ICogVXNlZCBDb25maWdGUyBpbnRlcmZhY2UgaW5zdGVhZCBv
ZiBJT0NUTCBpbnRlcmZhY2UuDQo+ID4gPiAqIFVzZWQgcG9sbGluZyBtb2RlbCBmb3IgUXVvdGUg
Z2VuZXJhdGlvbiBhbmQgZHJvcHBlZCB0aGUgZXZlbnQgbm90aWZpY2F0aW9uIElSUSBzdXBwb3J0
Lg0KPiA+IA0KPiA+IENhbiB5b3UgZWxhYm9yYXRlIHdoeSB0aGUgbm90aWZpY2F0aW9uIElSUSBp
cyBkcm9wcGVkPw0KPiANCj4gQmVjYXVzZSBpdCB3YXMgYSBwaWxlIG9mIGhhY2tzIGFuZCBub24t
aWRpb21hdGljIGNvbXBsZXhpdHkuIEl0IGNhbiBjb21lDQo+IGJhY2sgd2hlbiAvIGlmIGRyaXZl
ciBjb2RlIGNhbiB0cmVhdCBpdCBsaWtlIGEgdHlwaWNhbCBpbnRlcnJ1cHQuDQoNClRoYW5rcy4g
IEFncmVlZC4NCg0KPiANCj4gWy4uXQ0KPiA+ID4gIA0KPiA+ID4gKy8qDQo+ID4gPiArICogSW50
ZWwncyBTR1ggUUUgaW1wbGVtZW50YXRpb24gZ2VuZXJhbGx5IHVzZXMgUXVvdGUgc2l6ZSBsZXNz
DQo+ID4gPiArICogdGhhbiA4SyAoMksgUXVvdGUgZGF0YSArIH41SyBvZiBjZXJpdGlmaWNhdGUg
YmxvYikuDQo+ID4gPiArICovDQo+ID4gPiArI2RlZmluZSBHRVRfUVVPVEVfQlVGX1NJWkUJCVNa
XzhLDQo+ID4gDQo+ID4gU1pfOEsgaXMgZGVmaW5lZCBpbiA8bGludXgvc2l6ZXMuaD4uICBJdCBz
ZWVtcyBpdCdzIG5vdCBleHBsaWNpdGx5IGluY2x1ZGVkLiANCj4gPiBJdCdzIGJldHRlciB0byBl
eHBsaWNpdGx5IGluY2x1ZGUgaXQuDQo+ID4gDQo+ID4gQnR3LCBhbHRob3VnaCB0aGUgc2l6ZSBv
ZiB0aGUgY2VydGlmaWNhdGUgYmxvYiBzaG91bGRuJ3QgY2hhbmdlIGRyYW1hdGljYWxseSwNCj4g
PiB0aGUgUXVvdGUgY2FuIGFsc28gaW5jbHVkZSB0aGUgIlFFIEF1dGhlbnRpY2F0aW9uIERhdGEi
LCB3aGljaCBjYW4gdmFyeSBhIGxvdA0KPiA+IGRlcGVuZGluZyBvbiBkaWZmZXJlbnQgUUUgaW1w
bGVtZW50YXRpb24gKGUuZy4sIGNvbnRhaW5pbmcgZ2VvZ3JhcGh5DQo+ID4gaW5mb3JtYXRpb24s
IGV0YykuDQo+ID4gDQo+ID4gSSB3aXNoIGV2ZW50dWFsbHkgdGhlcmUncyBzb21lIC9zeXNmcyBl
bnRyeSB0byBjb25maWd1cmUgdGhlIHNpemUgb2YgUXVvdGUNCj4gPiBidWZmZXIsIGJ1dCBJIGd1
ZXNzIGl0IGNhbiBiZSBkb25lIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBIb3cgd291bGQgdXNlcnNw
YWNlIGhhdmUgYW55IGlkZWEgb2YgaG93IGJpZyB0aGUgcXVvdGUgYnVmZmVyIGlzIHRvIGJlDQo+
IGFibGUgdG8gc2V0IGl0PyBUaGUgb3V0cHV0IGZvcm1hdCBhdCBsZWFzdCBuZWVkcyB0byBzdGFu
ZGFyZGl6ZWQgd2l0aGluDQo+IGEgZ2l2ZW4gdmVuZG9yJ3MgaW1wbGVtZW50YXRpb24sIGFuZCBm
dXR1cmUgdmFyaWF0aW9uIHNob3VsZCBiZQ0KPiBkZS1lbXBoYXNpemVkIHJlbGF0aXZlIHRvIGdl
dHRpbmcgdG8gYSBjb21tb24gcmVwb3J0IGZvcm1hdCBhY3Jvc3MNCj4gdmVuZG9ycy4NCg0KVGhl
IFF1b3RpbmcgZW5jbGF2ZSBpbXBsZW1lbnRzIHdoYXQgdG8gYmUgaW5jbHVkZWQgaW50byB0aGUg
UXVvdGUuICBUaGUgYWRtaW4NCndobyBkZXBsb3lzIHRoZSBRdW90aW5nIGVuY2xhdmUga25vd3Mg
dGhlIFF1b3RlIHNpemUuDQoNCj4gDQo+IFsuLl0NCj4gPiA+ICsvKg0KPiA+ID4gKyAqIHdhaXRf
Zm9yX3F1b3RlX2NvbXBsZXRpb24oKSAtIFdhaXQgZm9yIFF1b3RlIHJlcXVlc3QgY29tcGxldGlv
bg0KPiA+ID4gKyAqIEBxdW90ZV9idWY6IEFkZHJlc3Mgb2YgUXVvdGUgYnVmZmVyLg0KPiA+ID4g
KyAqIEB0aW1lb3V0OiBUaW1lb3V0IGluIHNlY29uZHMgdG8gd2FpdCBmb3IgdGhlIFF1b3RlIGdl
bmVyYXRpb24uDQo+ID4gPiArICoNCj4gPiA+ICsgKiBBcyBwZXIgVERYIEdIQ0kgdjEuMCBzcGVj
aWZpY2F0aW9uLCBzZWMgdGl0bGVkICJUREcuVlAuVk1DQUxMPEdldFF1b3RlPiIsDQo+ID4gPiAr
ICogdGhlIHN0YXR1cyBmaWVsZCBpbiB0aGUgUXVvdGUgYnVmZmVyIHdpbGwgYmUgc2V0IHRvIEdF
VF9RVU9URV9JTl9GTElHSFQNCj4gPiA+ICsgKiB3aGlsZSBWTU0gcHJvY2Vzc2VzIHRoZSBHZXRR
dW90ZSByZXF1ZXN0LCBhbmQgd2lsbCBjaGFuZ2UgaXQgdG8gc3VjY2Vzcw0KPiA+ID4gKyAqIG9y
IGVycm9yIGNvZGUgYWZ0ZXIgcHJvY2Vzc2luZyBpcyBjb21wbGV0ZS4gU28gd2FpdCB0aWxsIHRo
ZSBzdGF0dXMNCj4gPiA+ICsgKiBjaGFuZ2VzIGZyb20gR0VUX1FVT1RFX0lOX0ZMSUdIVCBvciB0
aGUgcmVxdWVzdCB0aW1lZG91dC4NCj4gPiA+ICsgKi8NCj4gPiA+ICtzdGF0aWMgaW50IHdhaXRf
Zm9yX3F1b3RlX2NvbXBsZXRpb24oc3RydWN0IHRkeF9xdW90ZV9idWYgKnF1b3RlX2J1ZiwgdTMy
IHRpbWVvdXQpDQo+ID4gPiArew0KPiA+ID4gKwlpbnQgaSA9IDA7DQo+ID4gPiArDQo+ID4gPiAr
CS8qDQo+ID4gPiArCSAqIFF1b3RlIHJlcXVlc3RzIHVzdWFsbHkgdGFrZSBhIGZldyBzZWNvbmRz
IHRvIGNvbXBsZXRlLCBzbyB3YWtpbmcgdXANCj4gPiA+ICsJICogb25jZSBwZXIgc2Vjb25kIHRv
IHJlY2hlY2sgdGhlIHN0YXR1cyBpcyBmaW5lIGZvciB0aGlzIHVzZSBjYXNlLg0KPiA+ID4gKwkg
Ki8NCj4gPiA+ICsJd2hpbGUgKHF1b3RlX2J1Zi0+c3RhdHVzID09IEdFVF9RVU9URV9JTl9GTElH
SFQgJiYgaSsrIDwgdGltZW91dCkNCj4gPiA+ICsJCXNzbGVlcCgxKTsNCj4gPiA+ICsNCj4gPiA+
ICsJcmV0dXJuIChpID09IHRpbWVvdXQpID8gLUVUSU1FRE9VVCA6IDA7DQo+ID4gPiArfQ0KPiA+
IA0KPiA+IFdoeSBjYW4ndCB3ZSB1c2Ugd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCkgcHJv
dmlkZWQgYnkgdGhlIGtlcm5lbD8NCj4gPiANCj4gPiBCdHcsIGNhbiB3ZSB1c2UgX2tpbGxhYmxl
KCkgdmFyaWFudD8gIFN1cHBvcnRpbmcgdGltZW91dCBicmluZ3MgZXh0cmENCj4gPiBjb21wbGlj
YXRpb24sIGFuZCBJIHRoaW5rIHN1cHBvcnRpbmcgdGltZW91dCBpc24ndCBtYW5kYXRvcnkgZm9y
IHRoZSBmaXJzdA0KPiA+IHZlcnNpb24uDQo+IA0KPiBJdCBkZWZpbml0ZWx5IGlzIHJlcXVpcmVk
IGV2ZW4gaWYgaW50ZXJydXB0cyB3ZXJlIHN1cHBvcnRlZC4gVGhlIGtlcm5lbA0KPiBuZWVkcyB0
byBnaXZlIHVwIG9uIHN0YWxsZWQgb3BlcmF0aW9ucyBpbiBhIHJlYXNvbmFibGUgYW1vdW50IG9m
IHRpbWUuDQoNClRoYW5rcyBmb3IgZXhwbGFpbmluZy4NCg0K
