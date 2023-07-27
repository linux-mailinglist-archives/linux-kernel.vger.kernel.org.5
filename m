Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B8766034
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjG0XVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG0XVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:21:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78862E73;
        Thu, 27 Jul 2023 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690500102; x=1722036102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SmUFKNKWck7BoI0Yj6GvMC07PTTLvYNSMueNaExfEV4=;
  b=gUDefZbfiviBvLZqLsmwqUYKiIRgIDR61lxSbN4MSgvcwr537DwrCMtd
   vXzUCY+wL6oHhPcTfIOD+yoWuzOI2KakB7GeyrnKzjHs5WBy17N2SmthM
   pPz+S4U7HCM7Tcd2gYkOv49gZyTYZXMSJb1yxNF96F701GTx9XYwg7FFR
   igEN11yjZcGllvPj5vKhp2yhQYqh0Dl/EJ+zzD1az85LZ19l2wkqp/fd2
   Qj2+sWvpBSQb3illpB6C+4BhYFwQ4YKpSNAd3UU4ve9Fkb3cW6KOpGhKZ
   JL2G77DPy1ODtGMSgkaAl5LlSchmKGlPPNPpfTLbjrYFiAvjHPRyjH78u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="365913500"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="365913500"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 16:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762373657"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="762373657"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2023 16:21:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:21:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 16:21:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 16:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjOrP9QXhSGZp/qr2MY+KNeEqUmc3G/12DoIrdAgWdr3kymaOCjlc3ApnTGM38MFHoJw5r5zH0ceZMGNM85Bha6GZYus6dq4j9Y+7p3rqL9ggERRNkQYDmDyi/uWZrzg98h8VabhwYfG7BEvf/jCzwFGJNCs6OV+g8Bx8wjn4xh4tqmBcpaDPoR33/AaGtO8lGbdWL6CJgul7DDyNYBltS7zlurIxNcbjohFI+iYX6yvatTOyWpf0PlavDbOeApqI9zCCyvod7kGY51YO18T16ydfNKTmbZtSTLfLKJryXu9eOaXi0tg/Mv456JlDF90T5imZqsMh0BmNJ4gIMTmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmUFKNKWck7BoI0Yj6GvMC07PTTLvYNSMueNaExfEV4=;
 b=Vkl7WakzWr4rZGclPzYVmnk2VQqnHsIrocQM9NIz6rHGqIpcRz+p7iIgL+6xP4gW/NhXjTJ5E95SM1no1XmIysyfaE0S0j/PWi7wmGORpUhZutRf7z2o4xAXO0iMXmAn3+ne/rd+JNrN2bqE+xCDHrOnRvsXuZrctxboOoq4zQxQGM73ph+dUG1MawKRfm7K5FrmIGUmHB6l7ZG2zGW58twgYB+hr5swT7T430h5goGqrKLFFZva1V0wq494oYlej82c04jXHGYKYy0kXR37lNMvJXPXZqEwCX/MzfuyC8m4G5nRRaSNviGAkQWgrA6vTyblFL7yybnsHHbgoLZWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 23:21:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 23:21:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Thread-Topic: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for
 EAUG race
Thread-Index: AQHZwCYBmjwKzMBZUUGqRDKoJ6bjba/M6cUAgAC/sgCAAJhagA==
Date:   Thu, 27 Jul 2023 23:21:26 +0000
Message-ID: <6ccb705bc4345420e6c730245f871ba1d9413203.camel@intel.com>
References: <20230727010212.26406-1-haitao.huang@linux.intel.com>
         <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
         <op.18qu84gewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.18qu84gewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN0PR11MB6230:EE_
x-ms-office365-filtering-correlation-id: 8de3265f-8d37-4bb7-d6de-08db8ef83312
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2G8UGGuB6exBPr0fYzoUaIkllIP2cj0IokZgwudFlBVc6tdmoTLo6LXwhnUJQYw9OfThPMVriQJNcLOxUHndltqxIjDCiIqCwW8e+JIZWWpfQTn93I/hf43QA9KoccRKG5mVLxr8XwKKv3JrMTt5/HYoct4beilSVAv5PbtHlIp9ejEi2bHZnm/MAUT4EMdxTM8cmQuG4pIr9nUcOmg3LxQJwZykdErGZfRu32GTUXGslNB7qIDfJ61QxBxSdO3gnIdmLEKVKZubbjwJNHkOwd9pIG9Ns9cJ1+70SKZiJmmzPJmi/33CSIx+alWEfp7GDN1VPzxj1vx7pMVsfBmgx3cij5jeRTBGk+DChuW6yWy2QZ1JhTKVjUXVV3n2jW0YAtsM/GB5o/8STtmGl6MA6rSOnguGS20INcFbrleGFUMe26PZHYzC2SltM56+jCH/OacXFcM9pY+ywITH99JfBPZi0rd3mDHfz8XJLplmIQgqSXSWaOwN2GNDFnvRyYXpFpgwMsh/QO5y6f9BBgqU/SMtXSskbU3U+mdxfR798+M3tAntQzJtSoNREt6gCb5JBclwL8cpZEgInYs1ZUHiAMiMrd4EL6QvoXFY1XSfFYAf2QgCZ4T87hzvYLyqNM/w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(316002)(26005)(41300700001)(8936002)(4326008)(8676002)(6506007)(66899021)(54906003)(110136005)(122000001)(82960400001)(921005)(66476007)(66946007)(966005)(66446008)(478600001)(6512007)(76116006)(91956017)(64756008)(66556008)(6486002)(71200400001)(36756003)(38100700002)(2616005)(38070700005)(2906002)(83380400001)(86362001)(186003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUd4ejRRb0ZmN1ZUZVRMRGFlR3pJc0VQdU5jQnlDQ29WUDY1Q2ptZ0loU1Jx?=
 =?utf-8?B?ZUlvMStxVFFCbk56NlVvVS9WTGNMd241cThMOTV1WGoyYVI0UUtHSjJrTjhz?=
 =?utf-8?B?M3A1aFBtczkxMGx0ZXpkOUZSQkFjUkpJalZDdDNkMFhoLyszSnVvckUzR0RD?=
 =?utf-8?B?TUNYbGVHSmhDemRQMFhBckVTeUl2SlRlbjAvam1TK3FqcE4xTDJQbzZkNGYw?=
 =?utf-8?B?S2lhK1lDMnpUa1V3aGFFZTdUZ0VtVnYzMGR1OU02L0VkU0todHJUNFVmNG50?=
 =?utf-8?B?T1VMYXF0Z0JsaTJkRVVWZXcvRTl0ajBJQ09Yc1RQOGllZE1Wb3k5WHdjQnhS?=
 =?utf-8?B?OUpjRmNmMGN6YTluUjQzNFg3RjgydSsvdHA0Qk03WmwzSk9Rb3Z1Z0wyMUVp?=
 =?utf-8?B?amZleXl4RzExcXowOHY1UzlnaEVTWnJ2bXNSTE03blNrRXJTRXhmckg0bWE3?=
 =?utf-8?B?Y3pXQTBmSks1UU90TVUxbjY5VUxOeHZKVW5QWE00eHNjRWFQOHpNK210K3pr?=
 =?utf-8?B?SklDM3dVUWV5MGcxM0hNeWNrV0toLzk4QjlnaFRQUWtVOXlIYzZ0WUlhU0hV?=
 =?utf-8?B?YUMrUHh3dW5ldVN3WDk2KzExdjVzemhBdTVLUGJCemlmQnFTdm1KcWdDRmpZ?=
 =?utf-8?B?V1laUkM0K0ZCL204NVBtWXUwM1IxdVZsOTlJQXQ0M3RnNTFleElHRnc0dDZ4?=
 =?utf-8?B?Z3JjQzZuSjJ1OWtYNWpxZmlsdG05SCtoei9uSXRHeFc5VEF6VlFlV1FPVnBx?=
 =?utf-8?B?ZmtYWFB4Vm1uTDYyNFA2ZnlxZUVSZ3R1eFBOVGhuSkxDWkVSMU5rVUErZ1Vj?=
 =?utf-8?B?b3YzdG1mNytJMDlBNWh3emFpOCtHeW1WUlBiQmY4MDBRckpHOC9SUW4ycWps?=
 =?utf-8?B?eEoxejRyNUNINzAzeUdpUmdnb25YUFRZWUZyZDN3cUwydTNxNVh4TE1PVXF5?=
 =?utf-8?B?SXdQbVVhOTRkVFdTbmJGbDlKTkJNcmgrWlozR0ZobnlXbHZ5LzlhcWs5U1pO?=
 =?utf-8?B?YjMzbzRNeEJQTGUrVXUxZmU3VEw0czNkOHdRb1pSNlF2WVdoeVBPempBMExR?=
 =?utf-8?B?ZDk1ejhXOVgyL2NMVXdjNFlkbktUSXVBVGRVVFNMTitDc3kzenAxUWJCWHIr?=
 =?utf-8?B?anRmSEFBN2wvTDNyaGNVRDBjZ2xEemZxSjIwRUt3a1MvU21QbFJlem1oNnNC?=
 =?utf-8?B?c0NGeWN3bTdjM0xjb2VhQUlCeUxpdHlEajV0V2FhTXZvYTdOMVhteXpZaFhm?=
 =?utf-8?B?WkFCNkdjeU5Md280NWtvQVM4RlNtcWhESlFoaWNSNnNyQWlRaWthVXVwZzNw?=
 =?utf-8?B?YjFETndkcGlxK1FsZE5oQ1E0YU1NWVU3SFBYMEpYODlmQnQ5eXhoZm4zUVkr?=
 =?utf-8?B?Q0VZVlpsTWVwWmZSRTcyYklxanMzMlRhRzd2cVV1Nm5jVi95d2xOclZ2THdN?=
 =?utf-8?B?ZVFWRmIxMlg4N0V3bEhDc1dzczY3UmxlWERyMDdpWGtEdTY2ZW1oNkp6Qk41?=
 =?utf-8?B?bDJqWktVaFlLTXIzOXBSQUp1eThXZWxTYWF4ZEg3K2pTYjJ2cXlVeGxFZVJT?=
 =?utf-8?B?VlQxOEtmZzhpWS94czZaczBsTTY4a1AzZytCaTB3U2tIT29xeFAxT3UzR3lq?=
 =?utf-8?B?Q2VSZkdOUyszMjhYWVJ6NzBJTjZOait0ZTM0STBuV3pYbzR4WGVZSS80cnIw?=
 =?utf-8?B?YkQ1RW54Y05wYklTZ2NrdWlhdzIySmN5VGFPQkpMTm96WUp2bTVxdy94SUNn?=
 =?utf-8?B?S1dDbFB3WEREblo4OGhrNG50UTJCQmVxMXMxWnhQRXlQUkYvNWRRUzNlTWtH?=
 =?utf-8?B?NWJacGNHc2Jab2NCMEVIZ1h2MmJlcUN3Tld4eE9DTHUxc3ZHSzdlOG9hVFNr?=
 =?utf-8?B?QlA4TTRidlRyRi9uLzBEa3haaXhTYlN5TlkwOXRvKys3TFF4VXcyZHBmalV6?=
 =?utf-8?B?T1VlYWlSeWJaVy9XSFdzRGdDVlh6TGl4NDg4bDJHMTFYN0lKY28ySmgvb2h6?=
 =?utf-8?B?dUg0RUk2bDhMNkJwRTRwWUxTUXQrLzVNdW9Za3hmcEc0S1d0dEthNmlKemJm?=
 =?utf-8?B?cHlWandJWWp1WUtvbkZXUlhjYlhYRTRBV3U2NHBIVXdpKzFha3JIVUFoZDBy?=
 =?utf-8?Q?CK9/i9KkQJ6GUd5VhnxcAl6tE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2FF5B0BB847FC4DA8847D51C3653374@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de3265f-8d37-4bb7-d6de-08db8ef83312
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 23:21:26.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caQvC2ZrZRZW3zFc8mdRdGyxQcf3bolt/+lJx0vJm6q+/3TVNhUdOA/g+ZB7SNMJ+lPZHreI7eqS0ZDni/MhMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDA5OjE2IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFdlZCwgMjYgSnVsIDIwMjMgMjE6NTA6MDIgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBXZWQsIDIwMjMtMDctMjYgYXQgMTg6MDIg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IFVuZGVyIGhlYXZ5IGxvYWQsIHRoZSBT
R1ggRVBDIHJlY2xhaW1lciAoa3NneGQpIG1heSByZWNsYWltIHRoZSBTRUNTIEVQQw0KPiA+IA0K
PiA+IElmIEkgcmVhZCBjb3JyZWN0bHksIERhdmUgc3VnZ2VzdGVkIHRvIG5vdCB1c2UgImhpZ2gi
IChoZWF2eSBpbiB0aGlzICANCj4gPiBzZW50ZW5jZSkNCj4gPiBvciAibG93IiBwcmVzc3VyZToN
Cj4gPiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL29wLjE3OWE0eHMwd2p2am1p
QGhodWFuMjYtbW9ibC5hbXIuY29ycC5pbnRlbC5jb20vVC8jbTkxMjBlYWM2YTRhOTRkYWE3Yzlm
Y2M0NzcwOWYyNDFjZDE4MWU1ZGMNCj4gPiANCj4gPiBBbmQgSSBhZ3JlZS4gIEZvciBpbnN0YW5j
ZSwgY29uc2lkZXIgdGhpcyBoYXBwZW5zIHRvIG9uZSBleHRyZW1lbHkgIA0KPiA+ICJzbWFsbCIN
Cj4gPiBlbmNsYXZlLCB3aGlsZSB0aGVyZSdzIGEgbmV3ICJiaWciIGVuY2xhdmUgc3RhcnRzIHRv
IHJ1bi4gIEkgZG9uJ3QgdGhpbmsgIA0KPiA+IHdlDQo+ID4gc2hvdWxkIHNheSB0aGlzIGlzICJ1
bmRlciBoZWF2eSBsb2FkIi4gIEp1c3Qgc3RpY2sgdG8gdGhlIGZhY3QgdGhhdCB0aGUNCj4gPiBy
ZWNsYWltZXIgbWF5IHJlY2xhaW0gdGhlIFNFQ1MgcGFnZS4NCj4gPiANCj4gTXliZSBJIGhhdmUg
c29tZSBjb25mdXNpb24gaGVyZSBidXQgSSBkaWQgbm90IHRoaW5rIERhdmUgaGFkIGlzc3VlcyB3
aXRoICANCj4gJ2hlYXZ5IGxvYWQnLiBXaGVuIHRoaXMgaGFwcGVucywgdGhlIGxhc3QgcGFnZSBj
YXVzaW5nICNQRiAocGFnZSBBIGJlbG93KSAgDQo+IHNob3VsZCBiZSB0aGUgdGhlICJ5b3VuZ2Vz
dCIgaW4gUFRFIGFuZCBpdCBnb3QgcGFnZWQgb3V0IHRvZ2V0aGVyIHdpdGggdGhlICANCj4gU0VD
UyBiZWZvcmUgdGhlICNQRiBpcyBldmVuIGhhbmRsZWQuIEJhc2VkIG9uIHRoYXQgdGhlIGtzZ3hk
IG1vdmVzICd5b3VuZycgIA0KPiBwYWdlcyB0byB0aGUgYmFjayBvZiB0aGUgcXVldWUgZm9yIHJl
Y2xhaW1pbmcsIGZvciB0aGF0IHRvIGhhcHBlbiwgYWxtb3N0ICANCj4gYWxsIEVQQyBwYWdlcyBt
dXN0IGJlIHBhZ2VkIG91dCBmb3IgYWxsIGVuY2xhdmVzIGF0IHRoYXQgdGltZSwgc28gaXQgbWVh
bnMgIA0KPiBoZWF2eSBsb2FkIHRvIG1lLiAgQW5kIHRoYXQncyBhbHNvIGNvbnNpc3RlbnQgd2l0
aCBteSB0ZXN0cy4NCg0KSSBhbHJlYWR5IHByb3ZpZGVkIGFuIGV4YW1wbGU6IHN3YXBwaW5nIG91
dCBhbiAiZXh0cmVtZSBzbWFsbCIgZW5jbGF2ZS4NCg0KQW55d2F5LCBubyBiaWcgZGVhbCB0byBt
ZS4NCg0KPiANCj4gPiA+IHBhZ2UgZm9yIGFuIGVuY2xhdmUgYW5kIHNldCBlbmNsLT5zZWNzLmVw
Y19wYWdlIHRvIE5VTEwuIEJ1dCB0aGUgU0VDUw0KPiA+ID4gRVBDIHBhZ2UgaXMgdXNlZCBmb3Ig
RUFVRyBpbiB0aGUgU0dYIHBhZ2UgZmF1bHQgaGFuZGxlciB3aXRob3V0IGNoZWNraW5nDQo+ID4g
PiBmb3IgTlVMTCBhbmQgcmVsb2FkaW5nLg0KPiA+ID4gDQo+ID4gPiBGaXggdGhpcyBieSBjaGVj
a2luZyBpZiBTRUNTIGlzIGxvYWRlZCBiZWZvcmUgRUFVRyBhbmQgbG9hZGluZyBpdCBpZiBpdA0K
PiA+ID4gd2FzIHJlY2xhaW1lZC4NCj4gPiA+IA0KPiA+ID4gVGhlIFNFQ1MgcGFnZSBob2xkcyBn
bG9iYWwgZW5jbGF2ZSBtZXRhZGF0YS4gSXQgY2FuIG9ubHkgYmUgcmVjbGFpbWVkDQo+ID4gPiB3
aGVuIHRoZXJlIGFyZSBubyBvdGhlciBlbmNsYXZlIHBhZ2VzIHJlbWFpbmluZy4gQXQgdGhhdCBw
b2ludCwNCj4gPiA+IHZpcnR1YWxseSBub3RoaW5nIGNhbiBiZSBkb25lIHdpdGggdGhlIGVuY2xh
dmUgdW50aWwgdGhlIFNFQ1MgcGFnZSBpcw0KPiA+ID4gcGFnZWQgYmFjayBpbi4NCj4gLi4uDQo+
ID4gPiBCdXQgaXQgaXMgc3RpbGwgcG9zc2libGUgZm9yIGEgI1BGIGZvciBhIG5vbi1TRUNTIHBh
Z2UgdG8gcmFjZQ0KPiA+ID4gd2l0aCBwYWdpbmcgb3V0IHRoZSBTRUNTIHBhZ2U6IHdoZW4gdGhl
IGxhc3QgcmVzaWRlbnQgbm9uLVNFQ1MgcGFnZSBBDQo+ID4gPiB0cmlnZ2VycyBhICNQRiBpbiBh
IG5vbi1yZXNpZGVudCBwYWdlIEIsIGFuZCB0aGVuIHBhZ2UgQSBhbmQgdGhlIFNFQ1MNCj4gPiA+
IGJvdGggYXJlIHBhZ2VkIG91dCBiZWZvcmUgdGhlICNQRiBvbiBCIGlzIGhhbmRsZWQuDQo+ID4g
PiANCj4gPiA+IEhpdHRpbmcgdGhpcyBidWcgcmVxdWlyZXMgdGhhdCByYWNlIHRyaWdnZXJlZCB3
aXRoIGEgI1BGIGZvciBFQVVHLg0KPiA+IA0KPiA+IFRoZSBhYm92ZSByYWNlIGNhbiBoYXBwZW4g
Zm9yIHRoZSBub3JtYWwgRUxEVSBwYXRoIHRvbywgdGh1cyBJIHN1cHBvc2UgIA0KPiA+IGl0IHdp
bGwNCj4gPiBiZSBiZXR0ZXIgdG8gbWVudGlvbiB3aHkgdGhlIG5vcm1hbCBFTERVIHBhdGggZG9l
c24ndCBoYXZlIHRoaXMgaXNzdWU6IGl0DQo+ID4gYWxyZWFkeSBkb2VzIHdoYXQgdGhpcyBmaXgg
ZG9lcy4NCj4gPiANCj4gU2hvdWxkIHdlIGZvY3VzIG9uIHRoZSBidWcgYW5kIGZpeCBpdHNlbGYg
aW5zdGVhZCBvZiBleHBsYWluaW5nIGEgbm9uLWJ1ZyAgDQo+IGNhc2U/DQo+IEFuZCB0aGUgc2lt
cGxlIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBjbGVhcmx5IHNob3cgdGhhdCB0b28gaWYgcGVvcGxl
IGxvb2sgIA0KPiBmb3IgdGhhdC4NCg0KU28geW91IHNwZW50IGEgbG90IG9mIHRleHQgZXhwbGFp
bmluZyB0aGUgcmFjZSBjb25kaXRpb24sIGJ1dCBzdWNoIHJhY2UNCmNvbmRpdGlvbiBhcHBsaWVz
IHRvIGJvdGggRUxEVSBhbmQgRUFVRy4gIEkgcGVyc29uYWxseSB3ZW50IHRvIHNlZSB0aGUgY29k
ZQ0Kd2hldGhlciBFTERVIGhhcyBzdWNoIGlzc3VlIHRvbywgYW5kIGl0IHR1cm5lZCBvdXQgb25s
eSBFQVVHIGhhcyBpc3N1ZS4gIElmIHlvdQ0KbWVudGlvbiB0aGlzIGluIHRoZSBjaGFuZ2Vsb2cg
cGVyaGFwcyBJIHdvdWxkbid0IG5lZWQgdG8gZ28gdG8gcmVhZCB0aGUgY29kZS4NCg0KQW55d2F5
LCBqdXN0IG15IDJjZW50cy4NCg0KQW5kIEkgZG9uJ3Qgd2FudCB0byBsZXQgdGhvc2UgYmxvY2sg
dGhpcyBwYXRjaCwgc28gZmVlbCBmcmVlIHRvIGFkZCBteSB0YWc6DQoNClJldmlld2VkLWJ5OiBL
YWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
