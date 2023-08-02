Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893976C15F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHBAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHBAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:10:09 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E21BFD;
        Tue,  1 Aug 2023 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690935007; x=1722471007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tP44qRxeZFQejm9ywb9UT273GuLaznj5hVXvAilYFe4=;
  b=lrLfBg4VmJGJAZEYOjxZ5GxGcV4M+ntx1Qo8+IFo22ATXDMyucGAlK9k
   9q888Pz0jywykBt5bUZBbunWyG8lknYCAQlVHs5k0eexB1hjPheVIWHr2
   /YDEZmsbcxChUQs3rpJed9eGuks7/z/qGBewFCtm74p0EohF6fopv8p8w
   XQEERre24v16K3ovhdPe4Cwz5KpjNpYUdKQONus/JLYRZ7aV4AGXSYH/v
   CBjMIXmt9c50FOTGhozbX9+fMgvJYlB1kuRRqMVS5w2uGS5jVMTDELcC+
   CZPh+mqLaMe41DIzxZm5tOHqXeN7wC5+1DsEICIvkWUt4Xv16AbJYCZed
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455809395"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="455809395"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975476956"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="975476956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 17:10:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 17:10:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 17:10:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 17:10:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 17:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPPgrqxnO4gWf9S/IzPMf2j7XRnQ693wsmTUo5vPri5wgegB1LNqbbvU8Tnv6B91qpmsraoDpyl2b2j2e56kHwE0VAxQ2nZ/qEzJcVWVKukIbsWOXxBuxarDSZJoyxU8bI9al0+czHe5vET2GsB8Dca0HhmjkcfnZ8Qhget29lwrjs2z0Z1iLFsOhRum4/TBx/Me2lbAuzuT59na0MnnercRdUEUKTpPO4TVkecEjGs37mZt46pDIHXSddc6kYEzgGVIFqj/ispKaPy9NThnV6sYgbVh1iAyX0jEBNOssv8C5PYInZpwvOk4ZYsRFKgiBGZ6OGRvU9yD+pgTMsJmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP44qRxeZFQejm9ywb9UT273GuLaznj5hVXvAilYFe4=;
 b=CSWj0UixCV9vVu0/BZHIhzQU20MkOd3cIXnrwBOuoFvbAJhXtqiDGgWZaPqInpooYZAfkiEDcnPA4oopkfXcujlJgsyai+hwSBGoywMyZODpa7IN0b/s3QnTfrXiBEpPy1tPZH6P/7blfKb00tfTNrdGZP1Mo796ef8lnz6sUN99F79rER8ZTtAYziNxZaqOwG1VDYFdnhbzpV0rFgWSjHZl9e+0j8CBHlAOHK+KAAhXGWJHdpRQJewY0Xs4gbi9qo2uKhJzgiXyZHgRY/7OqzZt5ucwa2sGiAD1xruu17x5jh6AYK76WFYZb3zxm+SOFOvZv++GZEzUNUHNA3G53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 00:10:04 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::1969:941b:6bab:8efa]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::1969:941b:6bab:8efa%7]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 00:10:04 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/RDr0AgACyhACAAIcTgIADD9cAgAAFNICAAAdvgIAAw3mA
Date:   Wed, 2 Aug 2023 00:10:03 +0000
Message-ID: <070e2386c99137b59bea114032d22664dd7272f8.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
         <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
         <ebedf39723d465923413b0ab2b50fe6c78aab64b.camel@HansenPartnership.com>
In-Reply-To: <ebedf39723d465923413b0ab2b50fe6c78aab64b.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|PH7PR11MB5863:EE_
x-ms-office365-filtering-correlation-id: 4e9a5a36-c183-4f58-5c16-08db92ecd22f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjjMPTgAmAObnJXLgyaVcJJSafKGMZRTvxXw9qENfdqew5KKEicuupkgM+fhSlb2/1RJK/9dQnyRJnOxVjZNJo8fKh/MRrwQq0tKUexgH1Ziy9WNpGEnP/6fzlvzn7zEWxk9qKBWWywF9CqQWDJuCJ69IyitL/9rxFKuL2YHDr58C3LogB3kENvj8yY79DEWBMGArWQBXgcDRkSGreYQ1u4ECzbxWu2kclX6uf/wPL6y0Lrs1wTEg/SoCCI1De6c75BbqA1C1Zllzj0q8FsnmyTQevN5uXbKYsvFZbDS06ctSoyDVh/kkzgnAdsQVror5/qs0XF+n0UTsZSXcScv83nzw/NBSsc2k02kPNp1aCxBHR14lJTZIng9QRdR8GThJSJIdd7RqtEPorTACN7Wym2ixyWUaKXG2bD6nH6drpKZFNWDKZa0tDoV7DVyqYM5CjP1jIY7qqSzaeualG49l+SWlpEGBFkQIKof1KyRKYdspr/asQPCnuFnQHfwev9skv8RyNpsypmZy+fKwE8xnmYKjzcpkLinaAHd7t4Z11Yg0MTXG+cDzFR6gBrqjEAdBTsCiuqFEVIFyeLJdGgdMe+mdY4CnYGIqAOQqs3+Synp9C0rEzO9o+Mx1Y8QIi88
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(38070700005)(4326008)(2616005)(83380400001)(2906002)(186003)(316002)(7416002)(38100700002)(478600001)(41300700001)(86362001)(6512007)(122000001)(110136005)(54906003)(82960400001)(5660300002)(64756008)(66556008)(66476007)(66946007)(66446008)(76116006)(91956017)(71200400001)(26005)(6506007)(8676002)(8936002)(6486002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTU0MFI0NkkzYmJ5dTgyckxWMmE2NFhtSHpRcTRnQ0NqYlVuc2ZldmtEalJG?=
 =?utf-8?B?SFQ3OHBvaWtsMkk0QzRhdGdqS3RNMnJCSlFKRWRKUFZMNy9WL3htN0NNOVRk?=
 =?utf-8?B?aW8xdTdqbzF1QlFrSmdiaTZqcmlTQnpRVXkyVmYwMisyaGN5dDNmV3pPK3lm?=
 =?utf-8?B?SFhDSGpYN0tWQXQzeVRVYTE4dkpSSUxrV2dzbE1SVU5RK2tTaCtFaEJHQngv?=
 =?utf-8?B?S1dLNEFMbUFmeHhjWWtjZExacEhWakVqMUFyTlp5THBHUERFZTd6SmkwRXhZ?=
 =?utf-8?B?cWNVbGtrYXN4bHlHUVBYMHVVMGE3OE1FODluR0gwWGUxbWdjMllnekFCRmRr?=
 =?utf-8?B?LzRBTWxtbXlUSzJVQkdnUUxBa0ltY05aU2Q1VUpmVmJtTVVmQ1k1WEU2T3dx?=
 =?utf-8?B?UmYwaU1ibDN4TjU1SlRscjJ0SHljZ0wxOVVWVGRHQi9nbittQXVDQXRTZGlz?=
 =?utf-8?B?bHZYRC84WDAxRWpmTm5GMDhyZjNZbkJ5Z2NpSEF4anlCOHNnQ0ttbDlPaGNy?=
 =?utf-8?B?Tlp0c2pJTlhxdjRIR0pseEdEdDdUQTJPcTh3c3hzd3hORGhqbWI0Yk9pOEhq?=
 =?utf-8?B?RkdrdHkxaWp0TnZ5cnhjS21HMUtJTXVic2lYZXJHM2t2aWJ3VFhDSC9EWWhC?=
 =?utf-8?B?SzBnQzkzSjBKWXZNM1pIS09KWm5uUjY3Wmx2NFRqakRqUEF3ZnYwdjRyWW56?=
 =?utf-8?B?c2JuTjF3KzlnY0xMc0gvOGdjQVQ0eDZITEJDOVRnM2NiYWs4VUFwbWpvR2dk?=
 =?utf-8?B?cGp6U3NzSWFlQ0w4T2tud0VQUTI4TXFTUTdBYUd5MWF5Mm5yd0I3UGN4Y0JE?=
 =?utf-8?B?NTEzNHRYWWdnU3RlNTZmaXVtTExkVVBuSVZUNDlCQTliK1FsVWxSN1dDRWJj?=
 =?utf-8?B?R0h5REE3TDRDcGhtUG9CUGtIT1JER01OZ09iVngzaHZmdzRJMTQ0dUZSZ3U0?=
 =?utf-8?B?STMrWTVVc3o0V3pPcFQybzJ5eEdzbS9reERmYkJVTkkxcVNFZVlyYk5yYngz?=
 =?utf-8?B?cHRLdGJOOHBrZHI3RStoclBSbytWLzZqOTFBSWxoTXZiUlZ1OUM1dFEwTi9P?=
 =?utf-8?B?MzZKZHlGeTRrN3dvcWFOUzQwVFJmY0Vnd1hNOUgwN0l5d1pYbEtxSnRIam8w?=
 =?utf-8?B?dU9ldnY0d2UycUxtOWJsdzc0ZjFvbWQvR1FyaXlaMlNsalExMCt2RFZObkRp?=
 =?utf-8?B?OXgrVEZWeCt5aVFycnFoNDU3ZkpEZUhQckxlNUZCWTdtN3h2OEV0RERqN1BM?=
 =?utf-8?B?bmkzaFFMSVE3STVoaDVocEpWOUkycXdYdUozc3QvcGRLcE1UNGhMeU5Oa0h5?=
 =?utf-8?B?UzBMczg0dGpMdy9iUjlKRzZhVmswU3ROUWpRRjR4SUJrdUt3U1VrdWVCb0VR?=
 =?utf-8?B?RDdqRVZEWEthdExmdndrWWZ5TlFpMlFOWDFqeUtsUko5dGprcmtmcGZBR3lF?=
 =?utf-8?B?ckhiOWhwYlJFL3piRDlpOGIvczdYOXN1cGdTQXhhRkp0MHpjTjdpMG9xWGw3?=
 =?utf-8?B?MW56Tll3cXJhcnZpSkVxbElya2FxdFp5Q2I5UG9vTlozUDl3N0svQjhaR1dy?=
 =?utf-8?B?aVkzNW5RUVhPbjJBZnZ5cEE5clVpNVRNbTRMQ00vWHVpSDV4RDVXUStRdUF4?=
 =?utf-8?B?US9Rem1ENlpWd2dmQ1J4OXovdENDWHdCMVorT3d1Q0hKZXBtOFZkWkRUeEcv?=
 =?utf-8?B?bXByQTA3ZWZEVmJqZzFsRk9rczNkOHdUU3d0M1lvL3U1TlBYSVhtOUhidGsx?=
 =?utf-8?B?MWFNMlVSNFpCUHF5eFNPN21SRzhBN3MzL2ZSRk9FWUIxb3k1MlZGZDlydFJO?=
 =?utf-8?B?aThFVWtEK1IvV21JcFZURDBaTFpRWDRjbjRLZEtEQWdUUGRER2oxcG5MbElG?=
 =?utf-8?B?eVU0WHd1c2IvQ0VzelhzNllpak42ZlhIdmRycW12SWk3bndUdkZWN1cza2t4?=
 =?utf-8?B?NFBnLyt1U0V4eEVHRElQS2tpY2dDOWgzZzFHU2crc0ttMkpOWWVNLzNGTVds?=
 =?utf-8?B?a0JIbG5TUUd2c3NPc25Sa3J1Z2l5RkJJR2FDb3ZEOXk5ck50UTNWY2wvWU9T?=
 =?utf-8?B?MU9mY2ozV3RXYS9aZUtCTkdIUUYydjZTazBSTSs5Yy9KVEdQbmtVL1pRZmd4?=
 =?utf-8?Q?8wmgRPge28F5ZZqKsoYVUALHX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <213D12926E7AAD46BC804586A9C5446A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a5a36-c183-4f58-5c16-08db92ecd22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 00:10:03.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdUUAEI2i4/1fOd6y9YxwIoE6mPF3I32nDx26PqsbCL81FMSHIYFpVM+5ziNk8dNQICcihWlAywM6yBmqI8qIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDA4OjMwIC0wNDAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAwODowMyAtMDQwMCwgSmFtZXMgQm90dG9tbGV5IHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAxMTo0NSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gPiBbLi4uXQ0KPiA+ID4gDQo+ID4gPiBTb3JyeSBwZXJoYXBzIGEgZHVtYiBxdWVz
dGlvbiB0byBhc2s6DQo+ID4gPiANCj4gPiA+IEFzIGl0IGhhcyBiZWVuIGFkZXF1YXRlbHkgcHV0
LCB0aGUgcmVtb3RlIHZlcmlmaWFibGUgcmVwb3J0DQo+ID4gPiBub3JtYWxseSBjb250YWlucyBh
IG5vbmNlLsKgIEZvciBpbnN0YW5jZSwgaXQgY2FuIGJlIGEgcGVyLXNlc3Npb24NCj4gPiA+IG9y
IHBlci1yZXF1ZXN0IG5vbmNlIGZyb20gdGhlIHJlbW90ZSB2ZXJpZmljYXRpb24gc2VydmljZSB0
byB0aGUNCj4gPiA+IGNvbmZpZGVudGlhbCBWTS4gwqANCj4gPiA+IA0KPiA+ID4gSUlVQywgZXhw
b3NpbmcgYXR0ZXN0YXRpb24gcmVwb3J0IHZpYSAvc3lzZnMgbWVhbnMgbWFueSBwcm9jZXNzZXMN
Cj4gPiA+IChpbiB0aGUgY29uZmlkZW50aWFsIFZNKSBjYW4gcG90ZW50aWFsbHkgc2VlIHRoZSBy
ZXBvcnQgYW5kIHRoZQ0KPiA+ID4gbm9uY2UuwqBNeSBxdWVzdGlvbiBpcyB3aGV0aGVyIHN1Y2gg
bm9uY2Ugc2hvdWxkIGJlIGNvbnNpZGVyZWQgYXMgYQ0KPiA+ID4gc2VjcmV0IHRodXMgc2hvdWxk
IGJlIG9ubHkgdmlzaWJsZSB0byB0aGUgcHJvY2VzcyB3aGljaCBpcw0KPiA+ID4gcmVzcG9uc2li
bGUgZm9yIHRhbGtpbmcgdG8gdGhlIHJlbW90ZSB2ZXJpZmljYXRpb24gc2VydmljZT/CoCBVc2lu
Zw0KPiA+ID4gSU9DVEwgc2VlbXMgY2FuIGF2b2lkIHN1Y2ggZXhwb3N1cmUuDQo+ID4gDQo+ID4g
T0ssIHNvIHRoZSBub25jZSBzZWVtcyB0byBiZSBhIGNvbnNpZGVyYWJseSBtaXN1bmRlcnN0b29k
IHBpZWNlIG9mDQo+ID4gdGhpcyAoYW5kIG5vdCBqdXN0IGJ5IHlvdSksIHNvIEknbGwgdHJ5IHRv
IGdvIG92ZXIgY2FyZWZ1bGx5IHdoYXQgaXQNCj4gPiBpcyBhbmQgd2h5LsKgIFRoZSBwcm9ibGVt
IHdlIGhhdmUgaW4gcHJldHR5IG11Y2ggYW55IHNpZ25hdHVyZSBiYXNlZA0KPiA+IGF0dGVzdGF0
aW9uIGV2aWRlbmNlIHNjaGVtZSBpcyB3aGVuIEksIHRoZSBhdHRlc3RpbmcgcGFydHksIHByZXNl
bnQNCj4gPiB0aGUgc2lnbmVkIGV2aWRlbmNlIHRvIHlvdSwgdGhlIHJlbHlpbmcgcGFydCwgaG93
IGRvIHlvdSBrbm93IEkgZ290DQo+ID4gaXQgdG9kYXkgZnJvbSB0aGUgc3lzdGVtIGluIHF1ZXN0
aW9uIG5vdCBmaXZlIGRheXMgYWdvIHdoZW4gSSBoYXBwZW4NCj4gPiB0byBoYXZlIGVuZ2luZWVy
ZWQgdGhlIGNvcnJlY3QgY29uZGl0aW9ucz/CoCBUaGUgc29sdXRpb24gdG8gdGhpcw0KPiA+IGN1
cnJlbmN5IHByb2JsZW0gaXMgdG8gaW5jb3Jwb3JhdGUgYSBjaGFsbGVuZ2Ugc3VwcGxpZWQgYnkg
dGhlDQo+ID4gcmVseWluZyBwYXJ0eSAoY2FsbGVkIGEgbm9uY2UpIGludG8gdGhlIHNpZ25hdHVy
ZS7CoCBUaGUgbm9uY2UgbXVzdCBiZQ0KPiA+IHVucHJlZGljdGFibGUgZW5vdWdoIHRoYXQgdGhl
IGF0dGVzdGluZyBwYXJ0eSBjYW4ndCBndWVzcyBpdA0KPiA+IGJlZm9yZWhhbmQgYW5kIGl0IG11
c3QgYmUgdW5pcXVlIHNvIHRoYXQgdGhlIGF0dGVzdGluZyBwYXJ0eSBjYW4ndCBnbw0KPiA+IHRo
cm91Z2ggaXRzIHJlY29yZHMgYW5kIGZpbmQgYW4gYXR0ZXN0YXRpb24gc2lnbmF0dXJlIHdpdGgg
dGhlIHNhbWUNCj4gPiBub25jZSBhbmQgc3VwcGx5IHRoYXQgaW5zdGVhZC4NCj4gPiANCj4gPiBU
aGlzIHByb3BlcnR5IG9mIHVucHJlZGljdGFiaWxpdHkgYW5kIHVuaXF1ZW5lc3MgaXMgdXN1YWxs
eSBzYXRpc2ZpZWQNCj4gPiBzaW1wbHkgYnkgc2VuZGluZyBhIHJhbmRvbSBudW1iZXIuwqAgSG93
ZXZlciwgYXMgeW91IGNhbiBhbHNvIHNlZSwNCj4gPiBzaW5jZSB0aGUgbm9uY2UgaXMgc3VwcGxp
ZWQgYnkgdGhlIHJlbHlpbmcgcGFydHkgdG8gdGhlIGF0dGVzdGluZw0KPiA+IHBhcnR5LCBpdCBl
dmVudHVhbGx5IGdldHMga25vd24gdG8gYm90aCwgc28gY2FuJ3QgYmUgYSBzZWNyZXQgdG8gb25l
DQo+ID4gb3IgdGhlIG90aGVyLsKgIEJlY2F1c2Ugb2YgdGhlIHVucHJlZGljdGFiaWxpdHkgcmVx
dWlyZW1lbnQsIGl0J3MNCj4gPiBnZW5lcmFsbHkgZnJvd25lZCBvbiB0byBoYXZlIG5vbmNlcyBi
YXNlZCBvbiBhbnl0aGluZyBvdGhlciB0aGFuDQo+ID4gcmFuZG9tIG51bWJlcnMsIGJlY2F1c2Ug
dGhhdCBtaWdodCBsZWFkIHRvIHByZWRpY3RhYmlsaXR5Lg0KDQpUaGFua3MgZm9yIGV4cGxhaW5p
bmchDQoNClNvIGluIG90aGVyIHdvcmRzLCBpbiBnZW5lcmFsIG5vbmNlIHNob3VsZG4ndCBiZSBh
IHNlY3JldCBkdWUgdG8gaXQncw0KdW5wcmVkaWN0YWJpbGl0eSwgdGh1cyB1c2luZyAvc3lzZnMg
dG8gZXhwb3NlIGF0dGVzdGF0aW9uIHJlcG9ydCBzaG91bGQgYmUgT0s/DQoNCj4gDQo+IEkgc3Vw
cG9zZSB0aGVyZSBpcyBhIHNpdHVhdGlvbiB3aGVyZSB5b3UgdXNlIHRoZSBub25jZSB0byBiaW5k
IG90aGVyDQo+IGRldGFpbHMgb2YgdGhlIGF0dGVzdGluZyBwYXJ0eS4gIEZvciBpbnN0YW5jZSwg
aW4gY29uZmlkZW50aWFsDQo+IGNvbXB1dGluZywgdGhlIHBhcnRpZXMgb2Z0ZW4gZXhjaGFuZ2Ug
c2VjcmV0cyBhZnRlciBzdWNjZXNzZnVsDQo+IGF0dGVzdGF0aW9uLiAgVG8gZG8gdGhpcywgdGhl
IGF0dGVzdGluZyBwYXJ0eSBnZW5lcmF0ZXMgYW4gZXBoZW1lcmFsDQo+IHB1YmxpYyBrZXkuICBJ
dCB0aGVuIGNvbW11bmljYXRlcyB0aGUga2V5IGJpbmRpbmcgYnkgY29uc3RydWN0aW5nIGEgbmV3
DQo+IG5vbmNlIGFzDQo+IA0KPiA8bmV3IG5vbmNlPiA9IGhhc2goIDxyZWx5aW5nIHBhcnR5IG5v
bmNlPiB8fCA8cHVibGljIGtleT4gKQ0KPiANCj4gYW5kIHVzaW5nIHRoYXQgbmV3IG5vbmNlIGlu
IHRoZSBhdHRlc3RhdGlvbiByZXBvcnQgc2lnbmF0dXJlLg0KDQpUaGlzIGxvb2tzIGxpa2UgdGFr
aW5nIGFkdmFudGFnZSBvZiB0aGUgYXR0ZXN0YXRpb24gZmxvdyB0byBjYXJyeSBhZGRpdGlvbmFs
DQppbmZvIHRoYXQgY2FuIGJlIGNvbW11bmljYXRlZCBfYWZ0ZXJfIGF0dGVzdGF0aW9uIGlzIGRv
bmUuICBOb3Qgc3VyZSB0aGUNCmJlbmVmaXQ/ICBGb3IgaW5zdGFuY2UsIHNob3VsZG4ndCB3ZSBu
b3JtYWxseSB1c2Ugc3ltbWV0cmljIGtleSBmb3IgZXhjaGFuZ2luZw0Kc2VjcmV0cyBhZnRlciBh
dHRlc3RhdGlvbj8NCg0KPiANCj4gU28gdGhlIHJlbHlpbmcgcGFydHkgY2FuIGFsc28gcmVjb25z
dHJ1Y3QgdGhlIG5ldyBub25jZSAoaWYgaXQga25vd3MNCj4gdGhlIGtleSkgYW5kIHZlcmlmeSB0
aGF0IGl0IGhhcyBhIGN1cnJlbnQgYXR0ZXN0YXRpb24gcmVwb3J0ICphbmQqIHRoYXQNCj4gdGhl
IGF0dGVzdGluZyBwYXJ0eSB3YW50cyBzZWNyZXRzIGVuY3J5cHRlZCB0byA8cHVibGljIGtleT4u
ICBUaGlzDQo+IHNjaGVtZSBkb2VzIHJlbHkgb24gdGhlIGZhY3QgdGhhdCB0aGUgdGhpbmcgZ2Vu
ZXJhdGluZyB0aGUgYXR0ZXN0YXRpb24NCj4gc2lnbmF0dXJlIG11c3Qgb25seSBzZW5kIHJlcG9y
dHMgdG8gdGhlIG93bmVyIG9mIHRoZSBlbmNsYXZlLCBzbyB0aGF0DQo+IHVudHJ1c3RlZCB0aGly
ZCBwYXJ0aWVzLCBsaWtlIHRoZSBob3N0IG93bmVyLCBjYW4ndCBnZW5lcmF0ZSBhIHJlcG9ydA0K
PiB3aXRoIHRoZWlyIG93biBub25jZSBhbmQgdGh1cyBmYWtlIG91dCB0aGUga2V5IGV4Y2hhbmdl
Lg0KDQpTb3JyeSBJIGFtIG5vdCBzdXJlIEkgYW0gZm9sbG93aW5nIHRoaXMuICBGb3IgVERYIG9u
bHkgdGhlIGNvbmZpZGVudGlhbCBWTSBjYW4NCnB1dCB0aGUgbm9uY2UgdG8gdGhlIHJlcG9ydCAo
YmVjYXVzZSB0aGUgc3BlY2lmaWMgaW5zdHJ1Y3Rpb24gdG8gZ2V0IHRoZSBsb2NhbC0NCnZlcmlm
aWFibGUgcmVwb3J0IG91dCBmcm9tIGZpcm13YXJlIGNhbiBvbmx5IGJlIG1hZGUgZnJvbSB0aGUg
Y29uZmlkZW50aWFsIFZNKS4NCk5vdCBzdXJlIG90aGVyIHZlbmRvcnMnIGltcGxlbWVudGF0aW9u
cyB0aG91Z2guDQoNCg==
