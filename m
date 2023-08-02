Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EF76DB53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHBXOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHBXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:14:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADB1BFA;
        Wed,  2 Aug 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691018064; x=1722554064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YJd7n9YHUDCqtn1q7OUMZB0p5d0BDYyA0xz815PJiN0=;
  b=BRfKOZpSjB7AJ2+3+5eAm8/AnTZKxxpv1FIhSsHP5mlQoFFEhlZj9/dN
   9LQDmxaA+Rvm8pJ939JXQbGHgJNsAQYqScaReRKHxtFd5ze0OHjhnwsB9
   kYJ+bNrq3Zwldjx6x4KPEaE0tT7tYl3megNkIFSfoY/0/Fp/wHVm066QU
   BiiM1vh0LOWqjd+sWWWDEqXxuVP9QcrOtqNoPZaO8cSMNVIs7WKT7V8Cd
   8eiKUnv+pVmRKQ3xtCc/sUmENbZEQvaFVpbzfdTxv7BLtqHQfMpp1u2zT
   6WmkU3ndc7E4wWd+wdqrW3/8a+BsFK2h2yke2PFrsdeeBgcY7yo8y/CxB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368622332"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="368622332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 16:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764386761"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="764386761"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 16:14:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 16:14:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 16:14:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 16:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRbpXDgcNvS92Yq71hTougVO2wn4jlQHxrZrJ8KyyazSXv0SiCbCkipByZM9J8vRaDO3BrHkCXnk7KFKknZDYWvRdIXw54kNYCaTt2QiHE9/RDPc6dpJgrZllkGqcTHIH2x6WHMG/zpH1rNNyFrvjwyxOFifntYjZs1eSAl8tJ0uWDR7XKnImOeER0XDFbk3BWDfA+WyeZTCGmPQMiAx58hZIDAchgb9Bhi4otxEaw7TlQkGkkhRLMzlerGSyKljVt0ZH8Qsanta2Yy0fVFHO7780kDgw5EkZcvTFgNZFnoEXZJK2QfDkNBeQhUB6HuKVynd5fMVxHdEA2Rr75/mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJd7n9YHUDCqtn1q7OUMZB0p5d0BDYyA0xz815PJiN0=;
 b=FCnw+ekXe+0TZ2ysiZgbDIfDGdTuYHbu9phJHleGMotsdYhtZgNFS0BmMnhedXmYxt9QAtsJOvxlzZxcrYVPL0l24qOUvQEBlvL7OKXXC32wFHWxjF+hYGCvqVHL3r897m+t4IYOoIMmQ8RWwFeMVeiWMc52i0MV1Dyl0EJO3BAKBw0n0Dp+RR9TNIunzs5zhE9JSmNj18zDjNvKJ2zss5YJM3Evp0Lt0NIqzvnjwzoyAKdhyFDPJbkSGRzJbogPetN9eQxILGPtO+nGPV0XeF4IuvZlJMsdU/rJmFWeEJE2+xcgJ2NqdZ3MIQNiInuJ1h9dcVthuM42pSD+Ww26wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 23:13:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:13:58 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Topic: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/RDr0AgACyhACAAIcTgIADD9cAgAAFNICAAAdvgIAAw3mAgADSC4CAALCcAA==
Date:   Wed, 2 Aug 2023 23:13:58 +0000
Message-ID: <bc184f0cb9821964c65a1e3b7ae56116d4e22405.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
         <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
         <ebedf39723d465923413b0ab2b50fe6c78aab64b.camel@HansenPartnership.com>
         <070e2386c99137b59bea114032d22664dd7272f8.camel@intel.com>
         <5a76c56a10f6512d0613577a412d2644945dbe77.camel@HansenPartnership.com>
In-Reply-To: <5a76c56a10f6512d0613577a412d2644945dbe77.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BY1PR11MB8008:EE_
x-ms-office365-filtering-correlation-id: 646f2e5d-541e-48e3-31ef-08db93ae2695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9rk1bHRoNxfiDFB6E79nf6aPh++87TNV4EeN4KJcqZ0hoXlEzZDWy7IeR3cPG3WPgPJChL6R1Fi05AxVjxHgRb4vuaF6i9P7TqxSh4jxeMrSeqVfTspFDK4/VEFlBCkXrIPzm1DrzqqEgrZ9l4qS+yGVeiwqvuVG326ICnyXjWF0gkYGchBe/ZrQRFcbRdXCzWGhu01+xjZGxlBtTqc7FapC0ZZr1PcLiQhj1uZLI5AIm+9zZTqkNbzVjoNaNTH96dSyiBu5sP9nkJEtcJwbhL5+vAlwj+r8O2vBXdUzziHhnldAmZUYjvU7YgWVjStxY0l9OBLzvHVQzOVsdR8M0bEn2LK6nBdNEgabV9lzCrlDrUc5d28Df+h6ypDO3gL3v/0vKTPT9dzUCAZR79Lfb9H+9ncioxDs58jnvaFij3SKPGm1Cy2W/7ZhgHC/HXzKe/Wu3P8QcB1T8m97nGAo9Q2O1ECU1fNpdtSXbUIAJstcakeX1TrhFzVIkCTL5i/3/82e2JF7Y1Rm5QDb2WR6wrAwV8lhAAckVPY3FP0iRVW0x4Ijg8uSiTviEmsHeTciknJm98O53mwNql1ghK8PM60m6RqpIsyMJ0QgEAEtK0TMyN0UI9CrwTWFTs8QrtX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(6506007)(83380400001)(26005)(186003)(316002)(76116006)(2906002)(91956017)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(6486002)(71200400001)(6512007)(478600001)(110136005)(54906003)(38100700002)(82960400001)(122000001)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnV6U2lON1c5cFg0Um5lZkdvcjZSM2FsQmJHVXRVeUQwNHlLUjZQMmNaV1ZD?=
 =?utf-8?B?YzI3RDBIT1FUQ0dxeldLUmRMUjRYSmZDVFZ3UkFnSHZYOVpiLzQwaGJDZXBE?=
 =?utf-8?B?MlpVblQ0NXNIeXBtdW5sTEUyTTJnaExjVUIwQnpYekpqenBVR1JQeHhFdmlV?=
 =?utf-8?B?ejZrR1BQWm5WamIwMmJqYVFucGNJUWNtbHVlWXlyMGMxNk1Ga1RUR2JiZElD?=
 =?utf-8?B?QUdNOGdLQ2lpcEgxNUVHbEI2ZXVaR0syYi9lc3psdWxzZFAzOWRFN2IySytG?=
 =?utf-8?B?Y3FtU0E2dENiZWk2NHF3Q1lEZlprcGhtbHkyRDFVdExWNjBnUlYzcEZOMW1z?=
 =?utf-8?B?dzRXQmc3NVRGNHloNVJGRnNrR0lNRW12WjQ1OXRXT2lwa09vU2tLN0lLRzVW?=
 =?utf-8?B?WkEyNzdjeDVkNTY0dHB6ZjUydzJ1L2l4b1dpY3BOVWFVeGxwb2E4RVB0ajhP?=
 =?utf-8?B?WnlMYW5LZnFSL2xJczR3bXM2SmN2aElPT0cxVkpGYkQyU2ZjZEorbld4c203?=
 =?utf-8?B?SGlPazMzNjFLSnhneHRodGlxdU9MdDkyQWpORFNldTVWclpwWmpzTysyUnhy?=
 =?utf-8?B?NVpYQTJQUGl6QmU1c05ZM2taam40SkszVWIvckV2dzRvcU5heEdvREVmcnh5?=
 =?utf-8?B?RHQrWmxod2xsTkNZaEtIcXZhR2hWblM2aUIxVWZmK0NWcllXK2dZNWZtUUNM?=
 =?utf-8?B?eTZwL3ZzV3pleUEwUmxzbXBBYm16WGVJNXNCVzlpa1VDMnVoeXZzK3JsakR4?=
 =?utf-8?B?K2EweWw2MHphKzc4eDBnN1VLcnJIa3ZGN29kTWN1TzdpQlBaV204aXhaNTlB?=
 =?utf-8?B?RklTZXY5T2hhUFpGbmFSWGd2QkFJYVMvSUZ1NUpOdWJ2YmJhM0I5N3V3YmFo?=
 =?utf-8?B?TTZjTTNjNVJnV3grUkVVYlBaQkxpNnBoSFpTZnBmK1FTWGdyNjg3aEwxaG5C?=
 =?utf-8?B?N3ZiMVBHNU9jVmwyQk5mRk5ETGpXR3VzUGduMHZrWVBCOENlRTZPV0lxU2JI?=
 =?utf-8?B?YWJTdlFlVlBJTXFwdFJXVUg2L3dGRXMyakZsOWhteGpHdlJ1S0tIbTB1KytM?=
 =?utf-8?B?VlJJbUpnTlNyNU5VK1Y3NktMa1A4ek1tNWV3V2RvSEdhb1pGSVNHRDRFall1?=
 =?utf-8?B?RktwTXUydkJQWUJpdlNwK0RDcWp0NlFONWdBdCtyWHZNNHRiNkdINEdQUnJz?=
 =?utf-8?B?d1hITWhrMmo2MldoV2xsRFdXekRSWXlNYTNXeTUvSzZIM0NxRGxHeEJsNVdK?=
 =?utf-8?B?bS9wOVlIUWljbEVsbzdSRTRweDNEN3ZKZTZiS3QrQW9xd3Exd3BCK2JFZXps?=
 =?utf-8?B?RFBqZTJwajJSQVc5MFVMTTcyYUl4MVFaeitBUGFDSlZZdTFDc3YrbEhDR1Ru?=
 =?utf-8?B?WE1kRzh4YmpySGFTSnNYeUJrMDVmYVRYNE91cjRHR09uY0lFV01Hd3pEdm1m?=
 =?utf-8?B?dFQ4N3g2K2VhcUhrOXVCN2JGWHJnYmRnNFhYQkxkVE53NSt0bHh4eCsrT0t1?=
 =?utf-8?B?YUhnR1d3TUdsdG1GTTNSTC9qcndEVWNiN0RUNmRkdEtwcWJZUDB6WEV5Z3pi?=
 =?utf-8?B?MktraURjOEExSENScURlR0t6MlVIQmVleUdnckpiOE9LU1BROUR2VXQ1NHlI?=
 =?utf-8?B?MGxxZnBLYklZbFpwS3Z4cy8waEJEU3ZwUkxKUG1sMG44ZWxPME5jQXpxSnAw?=
 =?utf-8?B?bGF3QzE0V2xETjlnOTdObndadzBlMjhVYUtJQzBhSVk4SjE2ODl5K1M5Y3dx?=
 =?utf-8?B?QWdXenJ0eFcxclh0cmdSZWlUb0dhdnhuOTV1Q0xVNWdBdXNWcEladDZFS2lW?=
 =?utf-8?B?QVIvNVFVV3FSTmpWVUg3Ukx0UGIxZ2g0cHZzZjlvNlR2M3FXRzJCRWdmZHIw?=
 =?utf-8?B?Um16eWtwUEFvbkxCcmdYbzZ6Uy9WRisvWHVuVllnZWlacXJiQlNNYkNnc09T?=
 =?utf-8?B?MjJES2tFbDJIMVRhNGNaS2JPUVNBRWFqdndOK2pJVHo3bU1YZzNDUmZ0dXJB?=
 =?utf-8?B?T0IyTkxEeXo3VDBtS2tKcnN6Z2NGVVNPejVXcUN1U2NPNHV6ZWlGWHl1M05R?=
 =?utf-8?B?SW03U1dBb0UrZ055eE91V2tRZ3ROancrY1Fzd3RXMjEvbUQwWk5yT2FLV0p6?=
 =?utf-8?Q?RnAX4K75VOM1HmS2P1UBq94VU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <832AD325CF856145AB328471ACC31107@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f2e5d-541e-48e3-31ef-08db93ae2695
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 23:13:58.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf+p1eL+M34s1DLNzQbHSQvxWnUylPpfnphXBVLn1sO5eLbWUxn1ls+XYrfhoqDSfX7VeKkE9F5SUpm3roOrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTAyIGF0IDA4OjQxIC0wNDAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMy0wOC0wMiBhdCAwMDoxMCArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiBPbiBUdWUsIDIwMjMtMDgtMDEgYXQgMDg6MzAgLTA0MDAsIEphbWVzIEJvdHRvbWxleSB3
cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAwODowMyAtMDQwMCwgSmFtZXMgQm90
dG9tbGV5IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjMtMDgtMDEgYXQgMTE6NDUgKzAwMDAs
IEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
U29ycnkgcGVyaGFwcyBhIGR1bWIgcXVlc3Rpb24gdG8gYXNrOg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEFzIGl0IGhhcyBiZWVuIGFkZXF1YXRlbHkgcHV0LCB0aGUgcmVtb3RlIHZlcmlmaWFibGUg
cmVwb3J0DQo+ID4gPiA+ID4gbm9ybWFsbHkgY29udGFpbnMgYSBub25jZS7CoCBGb3IgaW5zdGFu
Y2UsIGl0IGNhbiBiZSBhIHBlci0NCj4gPiA+ID4gPiBzZXNzaW9uIG9yIHBlci1yZXF1ZXN0IG5v
bmNlIGZyb20gdGhlIHJlbW90ZSB2ZXJpZmljYXRpb24NCj4gPiA+ID4gPiBzZXJ2aWNlIHRvIHRo
ZSBjb25maWRlbnRpYWwgVk0uIMKgDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSUlVQywgZXhwb3Np
bmcgYXR0ZXN0YXRpb24gcmVwb3J0IHZpYSAvc3lzZnMgbWVhbnMgbWFueQ0KPiA+ID4gPiA+IHBy
b2Nlc3NlcyAoaW4gdGhlIGNvbmZpZGVudGlhbCBWTSkgY2FuIHBvdGVudGlhbGx5IHNlZSB0aGUN
Cj4gPiA+ID4gPiByZXBvcnQgYW5kIHRoZSBub25jZS7CoE15IHF1ZXN0aW9uIGlzIHdoZXRoZXIg
c3VjaCBub25jZSBzaG91bGQNCj4gPiA+ID4gPiBiZSBjb25zaWRlcmVkIGFzIGEgc2VjcmV0IHRo
dXMgc2hvdWxkIGJlIG9ubHkgdmlzaWJsZSB0byB0aGUNCj4gPiA+ID4gPiBwcm9jZXNzIHdoaWNo
IGlzIHJlc3BvbnNpYmxlIGZvciB0YWxraW5nIHRvIHRoZSByZW1vdGUNCj4gPiA+ID4gPiB2ZXJp
ZmljYXRpb24gc2VydmljZT/CoA0KPiA+ID4gPiA+IFVzaW5nIElPQ1RMIHNlZW1zIGNhbiBhdm9p
ZCBzdWNoIGV4cG9zdXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gT0ssIHNvIHRoZSBub25jZSBzZWVt
cyB0byBiZSBhIGNvbnNpZGVyYWJseSBtaXN1bmRlcnN0b29kIHBpZWNlDQo+ID4gPiA+IG9mIHRo
aXMgKGFuZCBub3QganVzdCBieSB5b3UpLCBzbyBJJ2xsIHRyeSB0byBnbyBvdmVyIGNhcmVmdWxs
eQ0KPiA+ID4gPiB3aGF0IGl0IGlzIGFuZCB3aHkuwqAgVGhlIHByb2JsZW0gd2UgaGF2ZSBpbiBw
cmV0dHkgbXVjaCBhbnkNCj4gPiA+ID4gc2lnbmF0dXJlIGJhc2VkIGF0dGVzdGF0aW9uIGV2aWRl
bmNlIHNjaGVtZSBpcyB3aGVuIEksIHRoZQ0KPiA+ID4gPiBhdHRlc3RpbmcgcGFydHksIHByZXNl
bnQgdGhlIHNpZ25lZCBldmlkZW5jZSB0byB5b3UsIHRoZSByZWx5aW5nDQo+ID4gPiA+IHBhcnQs
IGhvdyBkbyB5b3Uga25vdyBJIGdvdCBpdCB0b2RheSBmcm9tIHRoZSBzeXN0ZW0gaW4gcXVlc3Rp
b24NCj4gPiA+ID4gbm90IGZpdmUgZGF5cyBhZ28gd2hlbiBJIGhhcHBlbiB0byBoYXZlIGVuZ2lu
ZWVyZWQgdGhlIGNvcnJlY3QNCj4gPiA+ID4gY29uZGl0aW9ucz/CoCBUaGUgc29sdXRpb24gdG8g
dGhpcyBjdXJyZW5jeSBwcm9ibGVtIGlzIHRvDQo+ID4gPiA+IGluY29ycG9yYXRlIGEgY2hhbGxl
bmdlIHN1cHBsaWVkIGJ5IHRoZSByZWx5aW5nIHBhcnR5IChjYWxsZWQgYQ0KPiA+ID4gPiBub25j
ZSkgaW50byB0aGUgc2lnbmF0dXJlLsKgIFRoZSBub25jZSBtdXN0IGJlIHVucHJlZGljdGFibGUN
Cj4gPiA+ID4gZW5vdWdoIHRoYXQgdGhlIGF0dGVzdGluZyBwYXJ0eSBjYW4ndCBndWVzcyBpdCBi
ZWZvcmVoYW5kIGFuZCBpdA0KPiA+ID4gPiBtdXN0IGJlIHVuaXF1ZSBzbyB0aGF0IHRoZSBhdHRl
c3RpbmcgcGFydHkgY2FuJ3QgZ28gdGhyb3VnaCBpdHMNCj4gPiA+ID4gcmVjb3JkcyBhbmQgZmlu
ZCBhbiBhdHRlc3RhdGlvbiBzaWduYXR1cmUgd2l0aCB0aGUgc2FtZQ0KPiA+ID4gPiBub25jZSBh
bmQgc3VwcGx5IHRoYXQgaW5zdGVhZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcHJvcGVydHkg
b2YgdW5wcmVkaWN0YWJpbGl0eSBhbmQgdW5pcXVlbmVzcyBpcyB1c3VhbGx5DQo+ID4gPiA+IHNh
dGlzZmllZCBzaW1wbHkgYnkgc2VuZGluZyBhIHJhbmRvbSBudW1iZXIuwqAgSG93ZXZlciwgYXMg
eW91IGNhbg0KPiA+ID4gPiBhbHNvIHNlZSwgc2luY2UgdGhlIG5vbmNlIGlzIHN1cHBsaWVkIGJ5
IHRoZSByZWx5aW5nIHBhcnR5IHRvIHRoZQ0KPiA+ID4gPiBhdHRlc3RpbmcgcGFydHksIGl0IGV2
ZW50dWFsbHkgZ2V0cyBrbm93biB0byBib3RoLCBzbyBjYW4ndCBiZSBhDQo+ID4gPiA+IHNlY3Jl
dCB0byBvbmUgb3IgdGhlIG90aGVyLsKgIEJlY2F1c2Ugb2YgdGhlIHVucHJlZGljdGFiaWxpdHkN
Cj4gPiA+ID4gcmVxdWlyZW1lbnQsIGl0J3MgZ2VuZXJhbGx5IGZyb3duZWQgb24gdG8gaGF2ZSBu
b25jZXMgYmFzZWQgb24NCj4gPiA+ID4gYW55dGhpbmcgb3RoZXIgdGhhbiByYW5kb20gbnVtYmVy
cywgYmVjYXVzZSB0aGF0IG1pZ2h0IGxlYWQgdG8NCj4gPiA+ID4gcHJlZGljdGFiaWxpdHkuDQo+
ID4gDQo+ID4gVGhhbmtzIGZvciBleHBsYWluaW5nIQ0KPiA+IA0KPiA+IFNvIGluIG90aGVyIHdv
cmRzLCBpbiBnZW5lcmFsIG5vbmNlIHNob3VsZG4ndCBiZSBhIHNlY3JldCBkdWUgdG8gaXQncw0K
PiA+IHVucHJlZGljdGFiaWxpdHksIHRodXMgdXNpbmcgL3N5c2ZzIHRvIGV4cG9zZSBhdHRlc3Rh
dGlvbiByZXBvcnQNCj4gPiBzaG91bGQgYmUgT0s/DQo+IA0KPiBUaGVyZSdzIG5vIHJlYXNvbiBJ
IGNhbiB0aGluayBvZiBpdCBzaG91bGQgYmUgc2VjcmV0ICh3ZWxsLCBleGNlcHQNCj4gc2VjdXJp
dHkgdGhyb3VnaCBvYnNjdXJpdHkgaW4gY2FzZSBzb21lb25lIGlzIG1vbml0b3JpbmcgZm9yIGEg
cmVwbGF5KS4NCg0KVGhhbmtzLg0KDQo+IA0KPiA+ID4gSSBzdXBwb3NlIHRoZXJlIGlzIGEgc2l0
dWF0aW9uIHdoZXJlIHlvdSB1c2UgdGhlIG5vbmNlIHRvIGJpbmQNCj4gPiA+IG90aGVyIGRldGFp
bHMgb2YgdGhlIGF0dGVzdGluZyBwYXJ0eS7CoCBGb3IgaW5zdGFuY2UsIGluDQo+ID4gPiBjb25m
aWRlbnRpYWwgY29tcHV0aW5nLCB0aGUgcGFydGllcyBvZnRlbiBleGNoYW5nZSBzZWNyZXRzIGFm
dGVyDQo+ID4gPiBzdWNjZXNzZnVsIGF0dGVzdGF0aW9uLsKgIFRvIGRvIHRoaXMsIHRoZSBhdHRl
c3RpbmcgcGFydHkgZ2VuZXJhdGVzDQo+ID4gPiBhbiBlcGhlbWVyYWwgcHVibGljIGtleS7CoCBJ
dCB0aGVuIGNvbW11bmljYXRlcyB0aGUga2V5IGJpbmRpbmcgYnkNCj4gPiA+IGNvbnN0cnVjdGlu
ZyBhIG5ldyBub25jZSBhcw0KPiA+ID4gDQo+ID4gPiA8bmV3IG5vbmNlPiA9IGhhc2goIDxyZWx5
aW5nIHBhcnR5IG5vbmNlPiB8fCA8cHVibGljIGtleT4gKQ0KPiA+ID4gDQo+ID4gPiBhbmQgdXNp
bmcgdGhhdCBuZXcgbm9uY2UgaW4gdGhlIGF0dGVzdGF0aW9uIHJlcG9ydCBzaWduYXR1cmUuDQo+
ID4gDQo+ID4gVGhpcyBsb29rcyBsaWtlIHRha2luZyBhZHZhbnRhZ2Ugb2YgdGhlIGF0dGVzdGF0
aW9uIGZsb3cgdG8gY2FycnkNCj4gPiBhZGRpdGlvbmFsIGluZm8gdGhhdCBjYW4gYmUgY29tbXVu
aWNhdGVkIF9hZnRlcl8gYXR0ZXN0YXRpb24gaXMgZG9uZS4NCj4gDQo+IFdlbGwsIG5vLCB0aGUg
PG5ldyBub25jZT4gbXVzdCBiZSBwYXJ0IG9mIHRoZSBhdHRlc3RhdGlvbiByZXBvcnQuDQo+IA0K
PiA+IMKgIE5vdCBzdXJlIHRoZSBiZW5lZml0P8KgIEZvciBpbnN0YW5jZSwgc2hvdWxkbid0IHdl
IG5vcm1hbGx5IHVzZQ0KPiA+IHN5bW1ldHJpYyBrZXkgZm9yIGV4Y2hhbmdpbmcgc2VjcmV0cyBh
ZnRlciBhdHRlc3RhdGlvbj8NCj4gDQo+IFllcywgYnV0IGhvdyBkbyB5b3UgZ2V0IHRoZSBzeW1t
ZXRyaWMga2V5PyAgQSBwcmUtY2hvc2VuIHN5bW1ldHJpYyBrZXkNCj4gd291bGQgaGF2ZSB0byBi
ZSBpbiB0aGUgZW5jbGF2ZSBhcyBhbiBleGlzdGluZyBzZWNyZXQsIHdoaWNoIGNhbid0IGJlDQo+
IGRvbmUgaWYgeW91IGhhdmUgdG8gcHJvdmlzaW9uIHNlY3JldHMuICBUaGUgd2F5IGFyb3VuZCB0
aGlzIGlzIHRvIHVzZSBhDQo+IGtleSBhZ3JlZW1lbnQgdG8gZ2VuZXJhdGUgYSBzeW1tZXRyaWMg
a2V5IG9uIHRoZSBmbHkuICBUaGUgcHJvYmxlbSwNCj4gd2hlbiB5b3UgYXJlIGRvaW5nIHRoaW5n
cyBsaWtlIERpZmZpZSBIZWxsbWFuIEVwaGVtZXJhbCAoREhFKSB0byBnaXZlDQo+IHlvdSB0aGlz
IHRyYW5zcG9ydCBlbmNyeXB0aW9uIGtleSBpcyB0aGF0IG9mIGVuZHBvaW50IHZlcmlmaWNhdGlv
bi4gDQo+IFlvdSBjYW4gcHJvdmlzaW9uIGEgcHVibGljIGNlcnRpZmljYXRlIGluIHRoZSBlbmNs
YXZlIHRvIHZlcmlmeSB0aGUNCj4gcmVtb3RlIChzbyBhIG1hbGljaW91cyByZW1vdGUgY2FuJ3Qg
aW5qZWN0IGZhbHNlIHNlY3JldHMpLCBidXQgdGhlDQo+IHJlbW90ZSBuZWVkcyBzb21lIGFzc3Vy
YW5jZSB0aGF0IGl0IGhhcyBlc3RhYmxpc2hlZCBjb21tdW5pY2F0aW9uIHdpdGgNCj4gdGhlIGNv
cnJlY3QgbG9jYWwgKG90aGVyd2lzZSBpdCB3b3VsZCBnaXZlIHVwIGl0cyBzZWNyZXRzIHRvIGFu
eW9uZSkuIA0KPiBBIGJpbmRpbmcgb2YgdGhlIGxvY2FsIHB1YmxpYyBESEUga2V5IHRvIHRoZSBh
dHRlc3RhdGlvbiByZXBvcnQgY2FuIGRvDQo+IHRoaXMuIA0KPiANCg0KQmFzZWQgb24gbXkgbGlt
aXQgY3J5cHRvZ3JhcGh5IGtub3dsZWRnZSBJIGd1ZXNzIHlvdSBtZWFuIHVzaW5nIGF0dGVzdGF0
aW9uIGZsb3cNCmZvciBtdXR1YWwgYXV0aGVudGljYXRpb24/ICBJIHdhcyB0aGlua2luZyB3ZSBh
bHJlYWR5IGhhdmUgYSBUTFMgY29ubmVjdGlvbg0KZXN0YWJsaXNoZWQgYW5kIGF0dGVzdGF0aW9u
IGlzIHRvIG1ha2Ugc3VyZSB0aGUgYXR0ZXN0aW5nIHBhcnR5IGlzIHRydWx5IHRoZSBvbmUNCmJ1
dCBub3Qgc29tZW9uZSB3aG8gaXMgY29tcHJvbWlzZWQuICBBbnl3YXkgdGhhbmtzIGEgbG90IGZv
ciBleHBsYWluaW5nIQ0KDQo+ID4gDQo=
