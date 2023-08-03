Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5818876E77C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjHCL4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjHCL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:56:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE8273E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063809; x=1722599809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=00ftVPYxuEJluqGD+ApN/BXRUSA2Wx2/hiCK9gRgCqM=;
  b=G7KYrjxTbmDS7MI/nho4LXHPTl0lknrjVL83LY2AZSe+Gql9NjUunnh7
   8kZ+utV2ldyLCnDUwLJsvjZ8dIR+ICLFCnwOQaHZrbF/9pyeMrHlCvYek
   VB3Hj5SmR3LQ7wOj1fiUskJPIXyKl4GO6nDQP1bGDdOljFCeBz5JGm5Rm
   a0wCdMTjybq7Eg/tFK33CE7d7jTH0xg1s0cSczWt1N7E7S9REsnJmYZ+J
   wSnJeO53Z5ZKiFHehBoXkePjP/etzrKzVHAk+KyiPEDs5sC4Vlu86rbLW
   ni56J9oel1lcNhOoWBAxcLiB6DZ+g/SxeArLm8y9ZABmjT5kca83nD7UG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368750121"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368750121"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976039793"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976039793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 04:56:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 04:56:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 04:56:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 04:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/PCh/RVdLPlRQAaOPBiCY1UVMc4X8146+l560t/MyOPVsgf5lr8pDuCvpbkhJJyyPN6+P7TmM65XAKcLnrzOWDWzSCPyNTxZqrny33Vq6IYDfAS3yKYU16uoWxGovo9N4wmm0D0RT7a4xqb6lccYHbD42PDqAAbdVBcGi/+UPIoZ/1F+9UaSQP7xUrAITsQrcK4ieRZXvf+/cTJKSg8HhqbAlJU1Kxrf34kaIpY+JzerJOLKYzQGDrE9kP9RjOv++ih0qpofHmogv4vayZwcUyTZnfXhCRwaNUdsXhPQS+I6odiCPy5ngcUIWphaMmUYj/fvDAmWI3xoKEA/RaPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00ftVPYxuEJluqGD+ApN/BXRUSA2Wx2/hiCK9gRgCqM=;
 b=cygl9mh4cukuxGINmZFhIxph45vzWCcvJI4rF5DaHiPaF1G5JvrabuWQZlZWwVFb7fyHF6XtORIyS/V5iNMcO+TFj0AfxHxRC/VeQclt5Z1gdj/eANCx9YLf2n9gtIOTFJ9GyzNASt4+FYy9UFkJCke1/3rWzH3OpVr9GeiebfQGcTRoRzKPq83mJYZlQK0zNBhfZ/TcnSgSGyAXr7p8f6G3GTIrUtR5Kxy9B41sp5+MLf1l0T1T7LEP7ieMDW7nEUD5Ov46sJhMkrP3CCXYCGlzxRiAGExBe5LFoSC2ewgCE6EtIXEWrp6ydf3gXO5Bj/nvtwMfRMxIPHNQFZ6DEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 11:56:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 11:56:40 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZv7Ew9wXfCjaIFkeFM7YTTvK7Ya/N2wEAgABjTACACkJlAIAAAwkA
Date:   Thu, 3 Aug 2023 11:56:40 +0000
Message-ID: <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
         <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
         <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
         <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
In-Reply-To: <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB8454:EE_
x-ms-office365-filtering-correlation-id: cb34cdc1-0bcd-4a52-6e47-08db9418b2fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGbf2Dn+Z76pcTeS4e2qlrWKAiZVFO5DyPvQ7lypEXB2DIPaqzGEq7nVVvoCEmFvPzXW6+NjGY6lUW/aX4LzCz940JUP+NK3BwWv6oAEydvwlevTm/KpHYLYN95Zj/U8LuPteAa1j3vZ/UWepwdH8PE7xYtk3Xjs/80G5uVtGwNegCQzdfT4Nal4ALv6NN2KAbLhuP0W9LVYY6aEzkO+IjUR4xavyiaRhk7qtxpSVmfPPVdySCxS3aRtSqW2TXxzQIGLmh3O3z1rlHGNbkaBTIp0Y611Nu/pZ2tOwNJGDsUWfZ5h0e4ItavZUvDZ2xk5cwbyGnrQ3Kvt29i46L11tHHhTTBSfi18YhGRrohV5zD2vceFGD/SwfrQ2ps7LDVd4BaqnztuL/EUcOoCzRAkcEB/+oPNZc9TPNwTIkgrgjHR74g/cpFDUG/jbDb9mWEO+iotY154CWbYvAM5PhPmIcIBpcDPAX/HZTKcyG16Ac0IkNU0+lGXkhbOFr37CK9uhVEHN1jsp+NV9HKXON2EYScQX95aJGghHMR9t0T480WIi0NIrVJghHIs92MZep8bokIJktHXANevp4hhOhrKBoNcBhekOxCcTCdemk4mZhlTLO+Mq+RrAytSVj1KO3cz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(2616005)(6506007)(83380400001)(26005)(186003)(316002)(76116006)(2906002)(91956017)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(6916009)(7416002)(41300700001)(8676002)(8936002)(6486002)(71200400001)(6512007)(54906003)(478600001)(38100700002)(122000001)(82960400001)(86362001)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODg2dEdOT0pOR2JBdE1EVmtaZHpqM0wwS25VZ0NMcWdsNll0WGRGUDl5TXEv?=
 =?utf-8?B?cUgyYTJnZU42cXNHWjZIWWplUGttQ0RXWm8ydk1SY1lTZUlkRzNxR3d3WEJU?=
 =?utf-8?B?ZTk4VjFDd2tUdmpWOUZjLytuUGlpaHVmSmJnd0lIclJENS9QTkk2ZGV2Ri81?=
 =?utf-8?B?dkJKSi9BY1Q1TUVQYi9YbkNXU29oRzNFL01EVHIxU2E4UTZqMkhzeG1rOWoy?=
 =?utf-8?B?UTJmTWpvUTZUQjFuK0hBYlEvbUQ2YjM0c1EwbjBndUhaR0s4dkt0MklRbnFQ?=
 =?utf-8?B?dGtxWm05aU9uUUNPZUpvTzlHSkJrd1NJdEVwNERVOEhjd1E0dUUvUTk4aG5m?=
 =?utf-8?B?ek44N2Z4bmZHaEQrM0VDdUdPdXk4NG1CRVdWck90aWgwdVhjZkNsdE8zSUxv?=
 =?utf-8?B?b1BPSkpQRGhzdkhsVHVoQ0thck5qS2ZDZlRvOTQ0d0J6MzBPQ0RrT1pnUDZk?=
 =?utf-8?B?RmtrZ3Jvd21rdVk1SHplMkoyTlg4cXZDUUI5RTdvUzVPVmc0K2NOVjA0Ullx?=
 =?utf-8?B?UUpUMDY2cjNuN0FVaTRIK2ZGa3YvQXNiems2bkVhOGpJdWFwYmZoTVd3ZU1k?=
 =?utf-8?B?enhsOVBNM3pYV2lvekcyd2N5ZTl2NS9iVXpYVStHS1JML1phQTh2V3FKc3hP?=
 =?utf-8?B?Y3hZUzVsYm9hYlhQRDJzUVRSZWUyVWpNY0pjODF3VENWT0dYQTN1NlpUdVRt?=
 =?utf-8?B?YkU5b3BCS0NLSFlnY3hYT2MrTlhHeHNiYlo4blNOYlVNZzQ3ZTZScVJBOFRv?=
 =?utf-8?B?M2RIbzJVVlp4VzJjd3ZKTnBRQ1lOUkx2Wmdad0ZXRjhsZkgrRWs2My9qRHpR?=
 =?utf-8?B?dGFBU1JCS2ZOcnpyNDBTeEY0Q040RUhKa2NiNmZRTHZWNG9UYm81TXlaSVdS?=
 =?utf-8?B?Qk9hMlZJV1ZMTUxMbzByRTA0Ni92WUVXNlhiK3RjWDlnVkhybkZhOFRDbjlD?=
 =?utf-8?B?Qm5vMXJ0TmFHanh3ay9xOVFFVWg3R01LenhLemJjRGpxQTJQSGN6ZnQrNnpJ?=
 =?utf-8?B?SWtvTDZVbFNsTXFEck1UaC81TkJzaUw2emlKOUN1dW5Md0NVcjhnZDdjOXZR?=
 =?utf-8?B?NWE4RERoQnB4Z2ZwTlRObkM3dHA5eUd5eE5aTXJIK1RrOVJWUDc3bjkrK3RB?=
 =?utf-8?B?dlRaTkYzV2VIdHQyYnZJdGZuazNLTy82YXdhOVZ1bWVoVXJFVnRDb0tSbW8w?=
 =?utf-8?B?blIxTVJlcFVza2tmQW8vd1lGTTltenliMU5RMkVvRCt5ZHZZeGlSWDJaTERl?=
 =?utf-8?B?aFlPdnRpak9CZ2xnMmdkREhzdFBWWm5RQTFNOUgyNkhuU0pLaS9BSVgwSmNr?=
 =?utf-8?B?SlFyYU1jOGpkZDRwb2VMZWhCc2VHTk9hRisveGwwRjlRZzdLNndxMnQ1Ry9K?=
 =?utf-8?B?ZWpsTnZVWjBZRm9WdnNWa1pRNi9LT1dPME9DN0FFN29POGcwTlJ5RGJjNUM1?=
 =?utf-8?B?cm1YNk1ZN0x2UC9SeUlLaGtNSkNIVTRaM1ZVMVpuUmNBV2ZOQTQwWTc4cG5O?=
 =?utf-8?B?cXJxSTFVbDJ1d3lOWFBETHVsR000aEpLUFd5ZkJURXEreXNNSVF5a3JTOUhI?=
 =?utf-8?B?c2xMeGxxV0FWVGIyTUJHMDJXWWo0VkNrWVdTY2kxYS9mVVlBS3VTZkJSTTQ5?=
 =?utf-8?B?SkpvaWdGckpyaHpNdmxwcGIwK0JVZ2ttZ1BNQ1psRVdqZDM2aXduUERXWmhU?=
 =?utf-8?B?OVZxaDQ1b01pL0UxY1c2elFaUDlQTlhHQmtrOGhwd0J6OTdIMTlYQnZvTWhW?=
 =?utf-8?B?MVI0eFgxZXI3NEpqOWc0b09yVWdZNE9YalBWMEVlZWU5R0w2TUNxU0V3YUtq?=
 =?utf-8?B?eTJqVDJoUW5tb0VWMHNPRzlGYWxvNzUweXRHbnJscnBLaE15M29VeE5YbE5x?=
 =?utf-8?B?R1ZGK1Z1NW9YMmxjcUJ5TkYzNyt1U0pRdit6eTFzKzkwQjRETlRHOWxDT1ZC?=
 =?utf-8?B?eUZxTFJkMkZsVHhWbXNTZEJqc3NGZHZqU3FTbnZBNEl2VzZJZHhkdGxYMjFt?=
 =?utf-8?B?bkthV1F1dkhsaFd0Q2FFMmdIMDdtenFWOFBMd0N4RzR4RDJKU0FYK0dBWFp5?=
 =?utf-8?B?NE1rc1pxMlRrVUF0aVAxc0cvd2xsbHVUc1U4MUp6V2o3VUFOVXc3cks4SEpF?=
 =?utf-8?Q?OaD+qTzLZFHaCAUq+eLmsBqDc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C213DFA175B34F97D6C187D8735234@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb34cdc1-0bcd-4a52-6e47-08db9418b2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:56:40.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUcgstpdph6V9UDmSvsOfPacBUJ2UbEQK+eP2uq7fiEPWGMjw0nYFfonOBUCp6DnYY2ebGsMYDk2iaS9fCkI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDE0OjQ1ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAxMTowNTozNVBNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wNy0yNyBhdCAyMDoxMCAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+IE9uIFdl
ZCwgSnVsIDI2LCAyMDIzIGF0IDExOjI1OjA5UE0gKzEyMDAsIEthaSBIdWFuZyB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IFJlbW92ZSB0aGUgX190ZHhfaHlwZXJjYWxsX3JldCgpIGFzIF9fdGR4
X2h5cGVyY2FsbCgpIGFscmVhZHkgZG9lcyBzby4NCj4gPiA+IA0KPiA+ID4gSG0uIFNvIHdlIG5v
dyB1cGRhdGUgc3RydWN0IG9uIGFsbCBWTUNBTExzLiBJcyBpdCBhIGdvb2QgaWRlYT/CoA0KPiA+
ID4gDQo+ID4gDQo+ID4gRG8geW91IG1lYW4gd2UgInVuY29uZGl0aW9uYWxseSBzYXZlIG91dHB1
dCByZWdpc3RlcnMgdG8gIHRoZSBzdHJ1Y3R1cmUiLCByaWdodD8NCj4gPiANCj4gPiA+IFdlIGdp
dmUNCj4gPiA+IG1vcmUgY29udHJvbCB0byBWTU0gd2hlcmUgaXQgaXMgbm90IG5lZWRlZC7CoA0K
PiA+ID4gDQo+ID4gDQo+ID4gSSBkb24ndCBxdWl0ZSBmb2xsb3cgdGhpcy4gIENhbiB5b3UgZWxh
Ym9yYXRlPw0KPiA+IA0KPiA+IERvIHlvdSB3b3JyeSBhYm91dCBWTU0gYmVpbmcgbWFsaWNpb3Vz
IGFuZCBwdXR0aW5nIG1hbGljaW91cyB2YWx1ZXMgdG8gdGhlDQo+ID4gcmVnaXN0ZXJzPw0KPiAN
Cj4gWWVzLiBDYWxsZXIgb2YgdGhlIGh5cGVyY2FsbCBtYXkgZXhwZWN0IHRoYXQgdGhlIHJlZ2lz
dGVyIGlzIGluLW9ubHkgYW5kDQo+IHJlLXVzZSB0aGUgZmllbGQgZm9yIG90aGVyIHN0dWZmLiBB
bmQgaXQgd291bGQgd29yayB1bnRpbCBWTU0gZGVjaWRlDQo+IG90aGVyd2lzZS4NCg0KSSB3b3Vs
ZCBhcmd1ZSBmcm9tIHRoaXMgd2F5OiBpbiBURFhfSFlQRVJDQUxMIHRoZSBndWVzdCBoYXMgc2hh
cmVkIGFsbCByZWdpc3RlcnMNCnRvIHRoZSBWTU0sIHRodXMgdGhlIGNhbGxlciBvZiBoeXBlcmNh
bGwgY2Fubm90IGFzc3VtZSB0aG9zZSByZWdpc3RlcnMgaXMgaW4tDQpvbmx5Lg0KDQo+IA0KPiA+
ID4gSSB3b3VsZCByYXRoZXIga2VlcCB0aGUgc3RydWN0DQo+ID4gPiByZWFkLW9ubHkgd2hlcmUg
cG9zc2libGUuDQo+ID4gPiANCj4gPiANCj4gPiBXZSBjYW4gYWNoaWV2ZSB0aGlzIGlmIHRoZXJl
J3MgYSBjbGVhbiB3YXkgdG8gZG8sIGJ1dCBJIGRvbid0IHNlZSB0aGF0Lg0KPiANCj4gS2VlcCBf
cmV0KCkgYW5kIG5vbi1fcmV0KCkgdmVyc2lvbnM/DQoNClRoZSBwcm9ibGVtIGlzIHRoZSBhc3Nl
bWJseSBuZWVkcyB0byBhbHdheXMgdHVybiBvbiB0aGUgIlxyZXQiIHNvIHRoYXQgdGhlIFIxMA0K
KHVzZWQgYXMgVlAuVk1DQUxMIGxlYWYgcmV0dXJuIGNvZGUpIGNhbiBiZSBzYXZlZCB0byB0aGUg
c3RydWN0dXJlLiAgT3RoZXJ3aXNlDQp3ZSBhcmUgbm90IGFibGUgdG8gcmV0dXJuIFZQLlZNQ0FM
TCBsZWFmIHJldHVybiBjb2RlLg0KDQpDYW4geW91IGVsYWJvcmF0ZSBob3cgdG8gZG8/DQoNCg0K
