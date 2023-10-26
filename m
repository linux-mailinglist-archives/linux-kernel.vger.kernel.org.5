Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C57D867F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbjJZQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:10:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14A1AA;
        Thu, 26 Oct 2023 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698336619; x=1729872619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qY4AJMdgbhuorSZsacxr0oqVzc96ladjXlQ3hnQ5VF0=;
  b=jAW32RreLKwAY2SNe7C0h6QwFPLdHG/FOoFStc5S8TO/Dewih/S+C/JX
   fCIuCzQKZ9laeNV1g4+e+l7LvNHwMEXHX3ct2mezFq7iwj2M+G7jOfOz+
   v3oZAMlagoACvb7j/u0fmXtn0BZASc5yrvWjHIJK0o2p8c+IlSB1nFh+C
   suM8fY+LeaN+lCRyvwHtYfwaGBuza828FJG9Zq95fW+Dn7JKbtwoOHpv/
   3V9itkD8sMOJbf+aX9H4N2dYNm+vS5R0fCTkcWPhRpb6w3GqAbscwI0pn
   gh8VOL7jFre7FqIJZf1RpAf+iddJlmCziqD0131m9Gy9hTRau79eOmhrJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="391463013"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391463013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 09:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825051858"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="825051858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 09:09:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 09:09:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 09:09:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 09:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVas0JatK1V3lbo3By4DGjiUIxq6LLkxyneevmUEPXnqW0o22y+omRdb1jRGPBKrjhwfUC5MXPDW0pB7ZQppWZDdlIvYQxxMJtpziUQ/XmUHBrlqtzlBcEL/Kw1z2GcU5b58Hh6gyPX6niwxxU8Lf2wPsUXDYZASr9Kqpd9Ua7UL+8FR1joVjNOoFpNzmmETxplUNCD228VOZgzt9nR4EnnJ+yrDPhrCPVxkeyUGuzPfZfRDyCBsoi4ZGlNHBZua/Kl7J0dKAtY2zg9Lok4AVbttUpwruRx49I69BBRUf19qJBa7/hN08hB4sXRAOeiMSBl+C4jCFAxerGB5kmq+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY4AJMdgbhuorSZsacxr0oqVzc96ladjXlQ3hnQ5VF0=;
 b=H2w0iFBYGF3u+Lb707GGTa0MDKKvRPc1CnutcuFZEKMMH7QSeqUoRFEDecmVSIH6CaQvJst9Zzfq/a/kQruc34/zoFTuCw9PhrPrxadhTtzQtl8fiJmq7+iR8T08iZ8yC5vwUkiPqCu+LVOAt3ljnn0TYjUnO/WrQ2IY6IdFXnIcf6gef8SQRluAbROEDjtzBUCn7jfqRA4Umdsn9iGlGPlqnTR+4aCFD9b6IfeW4wUAzGtHM4/VsoHx/+LEGVxQJEQpnIcV1XZ3/tGdKoKxhYNQRIeUUv1vjtKAnhUL/YFCvQCuCBPHj42Y1x1J1pLd8JlujfPbRAK192KHMjSS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 16:09:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 16:09:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Index: AQHaBqYtRjw2ybQBRkugDlcC/RU7LLBadVyAgACLrIOAARnRgIAAIpoQ
Date:   Thu, 26 Oct 2023 16:09:19 +0000
Message-ID: <SJ1PR11MB60837D379853EFB14A6A20BBFCDDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <CALPaoCj72V=o60tqsFMRzaeUw-1+rN7pyhsdCyVEV=0tN_CZ7A@mail.gmail.com>
 <95fc35a2-2f19-4ba5-ad3a-7d7ae578289c@amd.com>
In-Reply-To: <95fc35a2-2f19-4ba5-ad3a-7d7ae578289c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB6349:EE_
x-ms-office365-filtering-correlation-id: c9f4d970-23ac-45de-8fe2-08dbd63de8e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6oFhuQTourvCLcdSaZgA5qk+/xO32AzLZnKK45pDxJ2vWDNAfcYnAPFFuH/Qg4TIZizZ+n0nvebCuatIdO9szmInTIDGYsPH2fqvHziZ6DsniyEv4gPPBiMm5UkQ+rC4sXpP/KM+Lyfb6jMhRN8PejV1ICpU9ZrghaXmi/P+mAD4ggtaZ13TzT44TNuRraY6un/xx5N9t3tYd9iLUzRAarcNMCimYuhXCwLvFBKqxeASaNpnALb6/sUUB5vC9Xrdao9NsPIqALtwoohtWEE8Shmi0WBSLojrNUmC/3/dxoBUq41FaV2csKeICXeKX/wsJan1wdjq5x1Ir+wWg15kSmPd2BPsXne5oYVRApDWBl6NcbQIpz4ipKBqQ5YJ16M/lA2ruPpKG0ceafcM4PFZ8o5I5iJcUZ7YLI/O752RamoJFjKv8gEjYfOnRuxjNm250l8Bgck9UtYw7SZXuiz4uYi3B0SkOaSDwmwvCd6iJsCs8KTGej8g2XHhQL3VtyeKIh4s5DAfaMQXw7u+B+LVxPi7m3d6l760qbyql9HQw+fhm1pFzqcl3Ny4xMzifkmwh0LzKmpzSaG4d3sWknI5ltDTnybqMheQhu+AE3TGrpOV+FTHJwhMs3eqzcNqyE2z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38070700009)(2906002)(7416002)(8676002)(41300700001)(52536014)(5660300002)(4326008)(316002)(8936002)(33656002)(71200400001)(6506007)(76116006)(82960400001)(7696005)(110136005)(122000001)(64756008)(54906003)(66476007)(38100700002)(66446008)(66946007)(478600001)(86362001)(83380400001)(66556008)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjgzR0x1Z0N2NW9EQWVqek5sYnJGcmhKUi83UFRxWnR5VHJoUzdUMTJSMnlw?=
 =?utf-8?B?OVJKTGVqeDRRdVhhbWJhL2Rxc1VRRWtYS2MrbE9YRldTZDVDbDhGajBVTGtL?=
 =?utf-8?B?SmhYT1RUL0c4ZDdjR0xZTVJvbEUxSHBZUmNlQU1KYm9kd241c2JldGVRdXlY?=
 =?utf-8?B?ZWJLT09DcWJBbVVXZ1FmR2l5QUZIbUl6enVydit0QnNTbENSNnBHRGJzdzB4?=
 =?utf-8?B?OUxjR0tSbVF5SHc0UjNMQ2MyWXVVUkVNcTBrQ0dNRmJEWmVNWDFMTVZiUThj?=
 =?utf-8?B?bGp5bTY2Z3FkeTQ3bk9JK1VSdzdLVWNwTVdEMzNBdDNYTmluSC92Ny80U2Ew?=
 =?utf-8?B?a21XZE1KMU9xZmlsMXBSb08wZEVHdmJFVGZxZ3VxOVpBNlBjRmlUVXRDdGEy?=
 =?utf-8?B?bS9WMVBPbWNJRDErWWxFMEdvaFFGb1dRcGdBU3UrWXZSNmQvUUpUVEd3OC9W?=
 =?utf-8?B?M2FGWDdwcG1ReWY4bTcrRnowSndRdWdGaTlWQy93T01TcmM5SlhVWXFQN21S?=
 =?utf-8?B?R2YxSmx5ejZmQjNVN0ZxWjJJMzZPS2d3SCsvM3ZxK2tEaVY3TzdybmdZUE9C?=
 =?utf-8?B?UitUUnlzVG9WYVF2K1hIMzBHVHkzOGpRR3IxcThsUHgwWXE3bkFYc3l6dWlK?=
 =?utf-8?B?WEs5cVpVV0s4QnVxZ1dCS3FZMWZnUEloVGdyaUlRdkpqdC9iei9wNWRRaVVx?=
 =?utf-8?B?R0gzVU05TlE4a1hYc0pjU0tGalZURVpsYjVrQWhON2taZWl0RGowTllKN2lx?=
 =?utf-8?B?aUtyOUtQdkpOUUlLY1JyV25tRXZLWGlveXpEUmtUS2RyR0VRZXpkOTg5aVEy?=
 =?utf-8?B?Q1ROa000WlhOQlBUalo1d0V2OCt1YkxqamZGbnk0RVN5a01ldnQ5OFVEQWJM?=
 =?utf-8?B?ZU9FMldESGV4OTE5QkEwYysyaDNzOTZWU3BvcXRMNkpPQ0lmSWNPckcydEpV?=
 =?utf-8?B?RmR2eDFQR05BM01kSWJDaEdHY3lacWpxMFpFbXQ0eFQwNGVFMTMxbzk0VEdx?=
 =?utf-8?B?cDZpQUlla2FEWDVUTlFqenhZK3VveGZFRGd2OSsvSC82Q1hTdU04RUhRRS9Y?=
 =?utf-8?B?R25XWW5nNjF0SGlpb0toVnQ0eTI0SU01ZkFHemMrdFJsZFR2TlRldDJnRFlF?=
 =?utf-8?B?QUNNNG41blRTZFB1UUZXRlJkeVZHYnl0TmlqU3o5cGFmYVZ0Y0VGTGJnVVZn?=
 =?utf-8?B?d3YrV0xKdnlGVzdDaTZzdXNKUGVxVElCQUtKUlZtVmFyWGg1WC8xdUplZkYr?=
 =?utf-8?B?SWZlVHQwUFdWb1pURngyc2pFOWRRNnhaNWI5VG8vL0U3V0NtU3Y3Y3FHREJp?=
 =?utf-8?B?cXpxUmpCL1BKNU0xMGZQb3NZM3dXWjdlcFdyQTN5QlBGdVNXUm01T2Zzd1NI?=
 =?utf-8?B?d1NKUERyb3VMclVoWmVwV1JsTkRlSXFZZi9scEl4UkxQM2k2MGZkRUVwV3Nr?=
 =?utf-8?B?N1NXd29vNmNGNjMyRURRM0w4VWNPYVByWjNZZUlDQWpPSURNQU0rdm10dDB5?=
 =?utf-8?B?YXJydFFwSS9hTUpDK2JRUy92Y0E5WjFOM0FmbnNvT2o5Mm1uSkIxNEtsVXNa?=
 =?utf-8?B?WWVkd24yK0xLU2srcHhJRmVTSk5INDZwSjRScWI5WHpqZHVvRGVHNVIzWUo1?=
 =?utf-8?B?cE9lSUFDRDd5TVFnZHlJdWluMmk0QmZURjBuMHphcXQxaXc2WWVvcVAreTFE?=
 =?utf-8?B?MkYxN21wQ3BEc1FMSU9RSFhQRTFPR3dWVERSbXY2TVNYWmxHTkwrdlV0Y1Rx?=
 =?utf-8?B?am1HOXhvbGt4eDBpSVI1U1dxcm5VK0ZNT2NLeXVSUzd2QXdwMmpuQWpmZFV6?=
 =?utf-8?B?dTZ1VUlPSHMxOWpCR3o3WFpwUVlyUXE4TUpjcGtLVS9VR3JLSVFXY2FpL3Zs?=
 =?utf-8?B?UjJkazhLMXRwYnJiZUhhNGN6RGxEZ3ROOC92dWhaWUZUVFhLTWhQcjNGQUQ1?=
 =?utf-8?B?TS81L2pFRm1hbDZtRXovd2MzK1FEWjNsOTFUOUpROHkrV0luZlk5ZllIRSs0?=
 =?utf-8?B?QXgxaW5QSXlmSmVmTEVLY1U3N1BaNU8zdk9mdDVHYzJCY2UyMWdkanJsSnRV?=
 =?utf-8?B?MWNhcTQ5QlpETndEOGt4QzVscXhIL1ZJRFdDdUZYRFF4OXVKMjhmdUMvTSs4?=
 =?utf-8?Q?mwr523tb/tGO6a9O4czY7S2or?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f4d970-23ac-45de-8fe2-08dbd63de8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 16:09:19.1352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lwyp0EzQ3OAbocAGwpbpo7gw1RcosgdhPvd2crxSqAMGQA8wGFSyog3ZVIkMez5brhs9pZW+LOQALrUd7NnQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFdoYXQgSSBtZWFudCB3YXMgSSB0aGluayBpdCB3b3VsZCBiZSBlbm91Z2ggdG8ganVzdCBn
aXZlIHRoZSBmdW5jdGlvbg0KPiA+IHlvdSBhZGRlZCBhIG5hbWUgdGhhdCdzIG1vcmUgc3BlY2lm
aWMgdG8gdGhlIE1icHMgY29udHJvbGxlciB1c2UgY2FzZS4NCj4gPiBGb3IgZXhhbXBsZSwgZ2V0
X21iYV9zY19tYm1fc3RhdGUoKS4NCj4NCj4gSSBhY3R1YWxseSBsaWtlZCB0aGlzIGlkZWEuIEFk
ZCBhIG5ldyBmdW5jdGlvbiBnZXRfbWJhX3NjX21ibV9zdGF0ZS4gVGhhdA0KPiB3YXkgd2UgZXhh
Y3RseSBrbm93IHdoeSB0aGlzIGZ1bmN0aW9uIGlzIHVzZWQuIEkgc2VlIHlvdSBhbHJlYWR5IHNl
bnQgYSB2Mg0KPiBtYWtpbmcgdGhlIGV2ZW50IGdsb2JhbC4gTWFraW5nIGl0IGdsb2JhbCBtYXkg
bm90IGJlIGdvb2QgaWRlYS4gQ2FuIHlvdQ0KPiBwbGVhc2UgdXBkYXRlIHRoZSBwYXRjaCBhbmQg
cmVzZW5kLiBBbHNvIHBsZWFzZSBhZGQgdGhlIGNvbW1lbnQgYWJvdXQgd2h5DQo+IHlvdSBhcmUg
YWRkaW5nIHRoYXQgZnVuY3Rpb24uDQoNCkNhbiB5b3UgZXhwbGFpbiB3aHkgeW91IGRvbid0IGxp
a2UgdGhlIGdsb2JhbD8gSWYgdGhlcmUgaXMgYSBiZXR0ZXIgbmFtZSBmb3IgaXQsDQpvciBhIGJl
dHRlciBjb21tZW50IGZvciB3aGF0IGl0IGRvZXMsIG9yIHlvdSB0aGluayB0aGUgY29kZSB0aGF0
IHNldHMgdGhlIHZhbHVlDQpjb3VsZCBiZSBjbGVhcmVyLCB0aGVuIEknbSBoYXBweSB0byBtYWtl
IGNoYW5nZXMgdGhlcmUuDQoNCldoaWNoIGV2ZW50cyBhcmUgc3VwcG9ydGVkIGJ5IGEgc3lzdGVt
IGlzIGEgc3RhdGljIHByb3BlcnR5LiBGaWd1cmluZyBvdXQgb25jZQ0KYXQgImluaXQiIHRpbWUg
d2hpY2ggZXZlbnQgdG8gdXNlIGZvciBtYmFfTUJwcyBzZWVtcyBhIGJldHRlciBjaG9pY2UgdGhh
bg0KcmUtY2hlY2tpbmcgZm9yIGVhY2ggb2YgcG9zc2libHkgaHVuZHJlZHMgb2YgUk1JRHMgZXZl
cnkgc2Vjb25kLiBFdmVuIHRob3VnaA0KdGhlIGNoZWNrIGlzIGNoZWFwLCBpdCBpcyB1dHRlcmx5
IHBvaW50bGVzcy4NCg0KLVRvbnkNCg==
