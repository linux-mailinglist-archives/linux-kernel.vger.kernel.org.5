Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8C7DBE65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJ3Q6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3Q6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:58:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C3DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698685121; x=1730221121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qJ9D3Eb9UrXYsBYY5iH8GYeDlf9ZvwyJLMf/TKuC6X0=;
  b=b/ZyHey7xpXtEZamT48XQeybl0kanB0iPbr0o+EH+JWpJOlfmDimW+UL
   iLPmVAiHWRoiDvuWGha99V1y1pj/sXj8+2W+uG6K2dj+ALYgP1pumvfIe
   7+RsCepPX4IFPqGbtOU+PCnEe6Ssz07MvgmOVdojChWQVORzPHAh3RPkB
   f1jsqYCBUjyHHJ7zQyJEjD90t+IFjf+LNvsjIRFgT70CCfYqi0c1SHUWE
   Tul8sADwK5v7wet8/KaDkMrq1DLSvjzCdBO5a8DaOCbBontagV094btAY
   QukcaZ4nr3r/I2ZiqXXRVClTCVt/1jL2qcKXVbINMl0JpK0MQm2+HZ/sX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="390982358"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="390982358"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="763966039"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="763966039"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 09:58:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 09:58:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 09:58:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 09:58:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 09:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWO/O99t8Ha5PX5BIwoKEBh84trPw7rPRLWBAWpiLE+4ZK7wXOG0vst2R11Xw4Fe0R4rRVuKAmArCKRitQs/e/FiTK0wDdeG7q8QkZ7Lg1M2rbSiP6PHy4t17uNiEDQSHlhe4XTHvjMablDvlBt60JcO0KRT0hxXqkKEFvXluNjlYKRseKuu7YWq0sseoHpaJ+ff6QXwA66orhsij2nbZDS6i5aPKN43kJgzdAhtUpLoP7KfEMsm+oEIOLoou0RG3KbCtYQ2uvmcoHgjHpnlhc22pkc8MJQIdMDP90LoS7ng0IhFHC9iNhFTEhvlFObC0UXOiQXsiHWXjmGf0xeXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ9D3Eb9UrXYsBYY5iH8GYeDlf9ZvwyJLMf/TKuC6X0=;
 b=OThIFb3F5BrR6iV72Y+TAl98DMXl1DmFeCFCYA85+BgRcdIQWkmsWAdWlrGUqkO3e5nwMviHSTI9CQcVYJhq05rcHyMY1J8g6IXGVcvsCPubZk6bC2bKM8tcdyCwp6J4Hq3iSJWZLzfEWTazNXCrwzASzbMyBToJUN2U9NNIF40jBVz+5CqXIZGxcHDNDgTbqxsY8YhYFA2WP+/J4U1CYMi3jKVeDefa7k0TXLqqsfNNAmdLQK0mPg+wqq7Dqj9UnTh0SvNnWfiPoMBGFXVdKWKcFHJG/Dv5vSrgpAbUcs6DkN6XORDTK13xlMYmKWsaa0F/qDY1DYTTOi3fDWW8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7434.namprd11.prod.outlook.com (2603:10b6:806:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 16:58:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 16:58:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaCR9CmUnE0ixBgUKTFgfG39i7jrBiA4YAgACO4AA=
Date:   Mon, 30 Oct 2023 16:58:37 +0000
Message-ID: <f4232326b949f96aa88bd40309389d4b99288fa1.camel@intel.com>
References: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
         <20231030082714.pbma2bg2p354cuft@box.shutemov.name>
In-Reply-To: <20231030082714.pbma2bg2p354cuft@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7434:EE_
x-ms-office365-filtering-correlation-id: f374b252-4352-413e-d705-08dbd96975f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBpS6X3qJkZWe7qUFQTSmUL1W+4WaueTp7pEnodZeAgpJgG1ao7RtRbK/gJtDfgMm7LlSQR29v1Jv/t63OaClNpicd7rthUjbPNB4pjNaHNKMysMD38RqFUMk07AzahIDjMEycPmlbtFRpRXyaUS8TTV+rW0vo3+lEKdL3GwBelJ4xhYe7Yg8YitO13ZmkXQmKyobO/Bc7Oz83vzZWXdO2AQ8ygcdAZq7g4VrsvB76a4LyXuzu3tv8MPV6GyNTs80xBrV8O5s6DT3qrRcZ3lKrmXHcib21hv5j3iQKdDwdJ2+4yNvE8Dx1S4lGx5PzxGS3wSiJXBaNZGPCXF654WnLHfzepGgS8avtIqX5/a6X88STfcqSl0jzQU+Du4oSIuWRzh8a/oNlZUKpaWq6UJAhPn7pGQ1CXXBXr168XUB3UrMCsB16o83c2AlkLvYydde9MhlwljZFPKZG7+J8SfpoQEuYYsjf2WZ7upvRmmmDjD45gKAevZOX3zLry/0cV8TTtjDuUo1zyP+tmB8qJH7Zj/qHosTwz8HEXVPQ2FHG0cZB8+JJX0UnHZdhrdgRe9+Q7VfQjitb5lK+rbtJ2dTAkE3/AITMWGkZG6j/EQZUufn825PT9zquUDhSL35mEo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(71200400001)(83380400001)(6486002)(478600001)(6506007)(64756008)(36756003)(86362001)(38100700002)(82960400001)(122000001)(7416002)(5660300002)(66476007)(66446008)(6916009)(66556008)(54906003)(41300700001)(66946007)(26005)(4744005)(2906002)(2616005)(4001150100001)(91956017)(76116006)(8676002)(38070700009)(316002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGNibjQzUTkwU3NkNkMvdSsyY0ZTRHZMeTlRT21XTFBaeFpJQmY5dVFKRWN2?=
 =?utf-8?B?cWJNYld3ZnljZFdLK3h4VHRFL3BpM2xiTGthTVI5dEtTT0psb3pVdVN5ckFk?=
 =?utf-8?B?YmFGOEsxTFVrckVzT05UdHpvQUpYSS9xQktKSm4ycVFWZjVKcFJMUWdhMU9n?=
 =?utf-8?B?dWtBVVl1RXR6OThhNllkY0ZkcXpvZFQ2dU0yNmRLb3NWQmpUM1pFcVJUZmNj?=
 =?utf-8?B?ZU9GcHpRVHpLck1yNGZwYks2NzBVdTExdTZNVTZ1VDFwN2o5b3libTBnV00w?=
 =?utf-8?B?WGZkSnRpay9iWHNVeE5qY0tEUjk1a1prdndlc3JLdnhDMkJySHgrUGZLUURi?=
 =?utf-8?B?K0p4VFA2djZuSjE3TCs2YzZlR2Z5WDhSZTcwREhjQ080UURlT0UyWEFqcWJT?=
 =?utf-8?B?cjhIVEQ2S2ZzLzVzQWhTSXd0TDY5Mk4vTkY5dFUyZUVrVEVoWk5jblExVDFx?=
 =?utf-8?B?ZG9HbEpnWGIyU1JTbjJFSEZ2UlNwOWlmVzZhVVhBV2VaV3M1aURyRXpoQ2FQ?=
 =?utf-8?B?eDkrdS9PTG5rQndlN1ZteWhLL0hSb0YxbVZ4R2J6bkRVMStFWi93NmlXUzlw?=
 =?utf-8?B?YnVROFN3VHpPQ2s4RXBGZ2pldnRVaHZCYUFTVVZUdTkvN2syU0huUzN3ZW1s?=
 =?utf-8?B?cS9sM1VLTS8rU3l3Q09td0c4WEhJaDYxekhSTEpodG5iVG5FeW9VdUFTNDV5?=
 =?utf-8?B?U2pjeHk2UFRkaURoOUd3TlBKNDZqRW9jWE9KcWljcVkrQzZlOGxkanc5bENs?=
 =?utf-8?B?ZGF1VkVxZ0d1cjRZbkNqblIrZG5UdmhpakJRdjFrb3IxVW5jdHlURjN6L1Zt?=
 =?utf-8?B?cXQ1ZlVOWjRjQ1ZhSXYvb0xKVmlJSzJjY08zYWw0QjhxcVVHZlUxZzh0blk3?=
 =?utf-8?B?SGpQaHIvSzFGNFBGd0poQVBuK0xmUHZsRERXelFqd25VL0ZhS0ozVEZVU0JG?=
 =?utf-8?B?T3VYelphVW95UFF0b0R3d1JhN0ptY3FqK2FFd3MrdHNXS0lmUUtQZG9SYkRQ?=
 =?utf-8?B?QkFvNVd2Uk1RK0NxbFYwcmJrOWpXVzRXUGtnSXoydDZJYU9FNDUrS1ZoSXlX?=
 =?utf-8?B?Q2ttNE4wbzZoSm0xUHU1Unk3c1NsUm5jaW5hVFhGUW1KUE5ab2xvMlJ2RjFK?=
 =?utf-8?B?WDR4VHpUVlpkVjU4MzIvMlVCS3BSQnpYd0hGUFpRM1p0dm5jcUF0Y2c3eHBJ?=
 =?utf-8?B?dFZPRGJsekRtNVNtU2p6cWkxZkpJU0Y1L2NubFp4eVIrMFA0T2tKd3ZueG1h?=
 =?utf-8?B?SDJLTlc5bXJWS2Q1bE1iQlMwMU9rQVlnK2txSW02VCtybzhQWjVlQmZlNEhs?=
 =?utf-8?B?K3dHa21FckJ0UEkxeDdaaXhKeWJZQ2FSKzBvVlpLdE5BWGttWXUxZFN1N1FL?=
 =?utf-8?B?cDRMcUlnblpLMHZlVGt1b0ZHRHg0c3VDR3E0Q1ZIVE41ejVQZU91UFlLREUw?=
 =?utf-8?B?a2RaZU5pT1l6ckFySnVvWURJU3p6WUtRT0lvWlhOeUV4NnRicVc4bzYya2g2?=
 =?utf-8?B?LzJWQVBTOWhMZmNUc2VTSHRLOCtUa0JnYy9QMHVSTmR6SmEzTlNRcEdLNVFC?=
 =?utf-8?B?dllsaTNCL1JrbHFUdXhTdmh3VC9UMTdRVW9DUlBEZUdwc3JyblZVWm4rQU5u?=
 =?utf-8?B?UHFINFhVOEY1RC9NTENMUFRoTlYwV0RwNDROaEZUaEpRaVluQU9IUnoxN2Fh?=
 =?utf-8?B?cUFhektEeHo5K1ZwVjNYVnNpZEVGcFhRS3hJeTdsQnJWRUxobSsyenBaREJX?=
 =?utf-8?B?SUxrYWdkMGFsVHNoL3FHeTRDWEFOS2haanZNQS9xMFc4UlFmMUtpQ1FrblpX?=
 =?utf-8?B?NStzeGFjVk0yNVpsNUdwZkRHVVl3Qk05TGZCTGRBdi9ieFNwYUlCc05USXlZ?=
 =?utf-8?B?UjFjQ2xMT1lqUjZGdmYyc2QrK1dvZXBad092c29scDdQREs2dHdIM2pVbnFM?=
 =?utf-8?B?R1ZIQjdWWFp2eGtoaWprekFqeFlrdjFjT3dSVkNWMDhDUDBpaCtQbVVlaEp4?=
 =?utf-8?B?RmQ5RUpQVGVLU3QycG9GR2dnUlpBbUIxdWNka0hKaVQyV2U5VEtpQVprODN4?=
 =?utf-8?B?bW5rRk00Y0Z2amlUZHIxRllJK2Y2T0VxRkllWnZ3NmlNSUNEeG02VzNtV1Ro?=
 =?utf-8?B?aWE3RjZlTlhNMzlkeG9XUVhtUG5kaU1teUtUdjdCNkQybWcrZ3pSWmJjSU95?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D887BB90B5EDA44B27076B1ED1FC423@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f374b252-4352-413e-d705-08dbd96975f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 16:58:37.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ntZfaZMPSyrQy0Xenu1P5HdfiMSmC8Qj9EA6IR2XK2pKUnob9bqpOykLvHuggGOo3pTHNkYXryr1VTDJRkl2nWFEkUfn9N3i7qnTOjDIXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7434
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDExOjI3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tDQp3cm90ZToNCj4gVGhhIHBhdGNoIGxvb2tzIGdvb2Q6DQo+IA0KPiBSZXZpZXdl
ZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29t
Pg0KPiANClRoYW5rcyENCg0KPiBJdCBpbnRlbmRlZCB0byBnZXQgdXBzdHJlYW0gYWxvbmdzaWRl
IHdpdGggdGhlIGNhbGxlciBmaXhlcyB0byBsZWFrDQo+IG1lbW9yeQ0KPiBvbiBmYWlsdXJlLCBy
aWdodD8gTWF5YmUgZ2V0IGl0IGludG8gb25lIHBhdGNoc2V0Pw0KDQpXaHkgZG8geW91IHRoaW5r
PyBTaW5jZSB0aGUgY2FsbGVycyBhcmUgc21hdHRlcmVkIGFjcm9zcyB2YXJpb3VzDQpkcml2ZXJz
LCBhbmQgdGhvc2UgY2hhbmdlcyBhcmUgbm93IGRpc2Nvbm5lY3RlZCBmcm9tIHRoZSBjaGFuZ2Vz
IHRvDQpDUEEsIEkgdGhvdWdodCB0byBqdXN0IGZvbGxvdyB1cCBlYWNoIGFyZWEgc2VwYXJhdGVs
eS4gRm9yIGV4YW1wbGUgSQ0Kd2FzIGdvaW5nIHRvIHB1dCBhbGwgdGhlIGh5cGVyLXYgcmVsYXRl
ZCBjaGFuZ2VzIHRvZ2V0aGVyLCBidXQgdGhhdA0KcGFydCBpcyBSRkMgZHVlIHRvIHRoZSBmYWN0
IHRoYXQgSSBjYW4ndCByZWFsbHkgdGVzdCBpdC4gVGhlIE1TIGZvbGtzDQpzYWlkIHRoZXkgY291
bGQgaGVscCBvdXQgdGhlcmUuIFNvIHRoZSBkaWZmZXJlbnQgYXJlYXMgd2VyZSBmZWVsaW5nDQps
aWtlIHNlcGFyYXRlIHNlcmllcy4NCg==
