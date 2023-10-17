Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84B7CBA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJQFou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:44:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A888E;
        Mon, 16 Oct 2023 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697521486; x=1729057486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qjqwdKFObKweFivbmA0yjd0dTFrX6JTfFNkcacYreWE=;
  b=hcy5RjWaLBDPXZti/fh9qojEukdv3Pj5gA92G1IO6lcjrKSG+0rUbDdX
   ynQzlVR2u6S0JCu0ioQY57u1JI0fvbc6tcmjUHQwM7T1reGsYVUMVyUSD
   74tZ3rfKRAVGl4u/6GXgvk6L2hckiPg5yyGg3lkM8ApfQ6/oXlgJA6PCg
   ZvqcsBBJh0/AsVLWxFkwvZB1t6/Ljzkk4QfIm5OHWml59zpW2xnCE7fXv
   n6+C3rok8XpwvAPLxsDmfXS+JitT+/ul98FMpZu3hJhYdutDb9+DT/5vA
   kqWstT3a2W9ZakPVcsABOYfFLP0+uJVYCaAdEDpWmiFFG18H6FIAtkxey
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471922314"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="471922314"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="929639562"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="929639562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 22:44:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 22:44:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 22:44:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 22:44:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 22:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAISai8R9PwzVf/lL7erg2XY/Zr9g8AGfLS5YzPSlpbKvDIr2hKjPqUzpJxFOzvjMptziuJM1Qnn+3afT7AUaFtzr96CS0cO+5jZLZmlpjOtO8kJVfJsCfLDicwfinHXhw7UiGHxlcgmvE8FIiLAugs7KT1pzryAzvTdHDfFJHitWlfezyzGN8dKaCzsnhdk8DlM7pmxDf+um6xRCe26nam5eTGEbjn3ynUATmS9gsZUqor5kRSQl9fvBhtF7xFI9xg6zh6lq6BgZRyxGo812VOWRBBI1qDtCWo5fzATlewiMKzjTjW7DMYewuMIKPJOhKkqzeDN+B3viVqxshCJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjqwdKFObKweFivbmA0yjd0dTFrX6JTfFNkcacYreWE=;
 b=axowZBotdv0qhF3e/TJ3g0l5ot4LFRwgQYpY7iRA96cszQ0vUJyUjyxYvYnkmomMsuBG/dpLX2AaVM1uIRRrnqOJMoCCkZNFm5vIAPe8BdA0kvxB1LIEYArbDe4mXnlzqlojzR6Hn/BI/GCiOnu70pHhDtsgjEE+u5uZw1vxrfypdhtyGPRWscZ2bsf/LuhGiXMCLNMwrfrGW7f50he05Q3/z2OxMjXHGFZemqybV3jEndxtGqVQndBcOPa27O6mX16b/+EQMHuzq/W9i9io05qQ9/QD6WFsVR5Avt8GwETIcwjNjR8BL3uh2oiwYnYMaPfuGIokREu9bvU9KVdQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:44:28 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 05:44:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Topic: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Index: AQHZ97pFlzDFXvvBck2PX4DBerIrvrA7swCAgBF/9QCAAFENsoAABoMA
Date:   Tue, 17 Oct 2023 05:44:27 +0000
Message-ID: <7a29c85bda2543a0f31d575ced3e57eb93063fc3.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
         <651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch>
         <923d65270ad08d47adae0d82ab4b508d01e9cc00.camel@intel.com>
         <87edhtaksf.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edhtaksf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM8PR11MB5624:EE_
x-ms-office365-filtering-correlation-id: bfb94f61-2cbe-41f3-214f-08dbced42063
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPxlRZBGeAEMFyQX+3pWzXpj8y50AURCnrErUieY5MHHRuLDn/tDMmyIji2YQjTJS58XWKwIK/WuHOQ9lZHaCrSyy1TEIAT49LhG8GLF1CwspzMpwiLpYe0AmwyanOZRSsMAjEAygjk+CdTP54YT06RPLtqA9d+mzvpqAPfdsaPgJwZILch8bZOzXknvnajYJ+XBS+BWxC/WZV0MEQsRSQ0Oe7KEkcehn2rl1jEGBgPe4bZDlbnsS/3NxGZPAUy7HGwW8Tq4oGN4IOgRlO9UA4RxsVEgyE2yj8XO6BapwF99BbcaLFcNimlSw1Fa3HcSmP7ncoPJZu8gae5ObgsU+CBvuwOF/xPGij67TsU99Sos/+eS2ycVN3d4q7kP4ioDJddB3Q5220uqZlvw8Jf8qOahvuIP4wJPQce6KrKCE6Yok3+QszUZTDQTVMr/XvEChAvOut4QWkpKqeKgUUXV5saiNImDhvCEpvlizrSi9PMFShH6wq9ZYm67NecA+uqdt2r+2ygrYlPkLR26Lt98L/b1ODO6WmHKPn3/xYNFV9zAay/4/mzk8BkN94jJqtdABtz/wCDds3GaEQDqE8G81b+BISS9gijK50GzE2Mb8CW4m5H66HlvW45gKjygiNAn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(37006003)(6862004)(4326008)(2906002)(36756003)(4001150100001)(5660300002)(41300700001)(86362001)(7416002)(83380400001)(8936002)(38100700002)(76116006)(38070700005)(66946007)(316002)(6636002)(66556008)(66476007)(122000001)(64756008)(66446008)(54906003)(82960400001)(6486002)(8676002)(6512007)(2616005)(6506007)(478600001)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2E1UFMrbm54aS8rRWFRclNwZGdjWEhaeVkxQld6TFJtSjAzSTZ6djBSelJx?=
 =?utf-8?B?S0IwV1NtTlJqaTVpZ3UyR2R0eERROWVucnJCaTMrRlFUQUVKUDRObWl2TWl5?=
 =?utf-8?B?a0RhYUlCMk1LZkh1Mno1MUl1REMrYjQxaFBROWNaV2htTmlkc1pjb05kNGgy?=
 =?utf-8?B?dUl0NHN3NE1vT2lENU1MbnZiamNwamREcUdWaUM3clB2WDR0YnZFSGxUNmpz?=
 =?utf-8?B?RWl1a0RzSjJCbTREZGdXOFpUK1JkSnVjYlpCcVVUV2lCNVR1VnZKaVdzTEZJ?=
 =?utf-8?B?QXEwdVVYVkw1TUlkU3pwUGNRSFFlaVkwbjZ3RTc0elpJTkhNQmdOVW12Z0F2?=
 =?utf-8?B?c01lRWY3T05aQVowUHpzT1NMRW9lUEdmZURhUmY3TUd4UnJEVE5XYWRDS0tl?=
 =?utf-8?B?c2RqTFhTc1kxa0tJSlFtaFFtaXUrZWRHTmRsNkdoZmt3ZzhRR25IZzliMjRJ?=
 =?utf-8?B?enExNGJTVzFycmQ4TEVwb2JZZ1BON1F3NUN3SDFjM09OeW1sVEwvZVRrMm5X?=
 =?utf-8?B?bWhFV0JQRE0rRzcwcGdRc21EWVFmb29xTUc2aUc4Q0NZMWZac2lqN3dVQm5Y?=
 =?utf-8?B?QXpVZ2w4NmJjL09qSzFweXovMTlIaUtHbXY0MnVTSmlGZDlGU2JXZllteGov?=
 =?utf-8?B?VUpueWZSdFdHbjVlN2Iyb3dLUGZhbloyMDhoL3doeW9Wb0luMGxyM3ZmV05L?=
 =?utf-8?B?UnJPRTNjRitxc3dBWVd2ajJ5Wk1kRFF4WktGQXE5TVlSMUZHMWNTLy9vVE5Q?=
 =?utf-8?B?RG9DVnNSTGQ4K2RPTUpEbG9INHZsUlZsOTZKYlhxbk5xVUxVYmN3Tk1HU2dJ?=
 =?utf-8?B?UHVwRVpJV3ExZmVIZ3JJaVR3OU15QlRUclRiN1FlWGtiVEsrOWtEVytVbmFP?=
 =?utf-8?B?NE5GbEE0QWhpcHdwMFJWbFh1aG8zR3ZPREFNaEJqQWVFbGNSUHo1UUhzVFBP?=
 =?utf-8?B?YUt3RmtHSG9qY0FUSlZFUDcrc1pFeGlPWFRFZ05HVXJBZnRneFpZUHpUbHVS?=
 =?utf-8?B?UVFpTWhaVGhDKzVncnduRVpGSTZKaDBqalNXL3ZpZ2xJbTQrSTgxOEtNVUEx?=
 =?utf-8?B?U25NZnFhUmQwOFF0eFBIaTk2SFc1L09ET0dSbnBTL215VFZ6Q1ZnMVlGVm5o?=
 =?utf-8?B?dEpCSG8wSmpHd1RWeEQ2SmloRUxFOE5ESmg0eC9oRTlZaHB6V1ZjQU9Hc3pS?=
 =?utf-8?B?cjFSVWxBNGdCbU4yMWpYNzJWRGlpVUpZS2JkamtlL0VnT2c5S1ZPZ3gzcDVs?=
 =?utf-8?B?SzZGTzZhOHordlR0V0VEY0VGMDdoZnNrTDRNek4xSDNwbDE1cTdrY0x4U2x4?=
 =?utf-8?B?V1kvNmQyQ3RxeGIyUzQrWC9KN0YrQ1RDdC9UdW44U2tqdVY5dFVnZ3hUcGhD?=
 =?utf-8?B?WENRcnIyU3V1Q01YNjU1dVFNWFB6SnRzcW5ocldaT0FwNlYrWGFxazUrd3kx?=
 =?utf-8?B?dUg1Yi9jMWJJNEplbUNOQVdmK0FqeGFxOHBnYWdvekt4Mnl5TVNjSEV6OWx6?=
 =?utf-8?B?V1Z4b3U2a1dWbHYrRW9Pak9kMm9pbmF3eU9XcVN2dXVLREhGN3VpSmtMdE5k?=
 =?utf-8?B?blhqME5yaGs4L2NSb2sya0hGSFNNb1Iwb2EvK0F1cmlVTlE1UC9DeE0wcnZ2?=
 =?utf-8?B?U2xCN1pVRXpUbURSR2txbVhjZXM4aitRaURINGhNNERYZkhSTkZITDJQMGNk?=
 =?utf-8?B?ZG41cGtFZFh2c2RRajdyeW1DQ0FjMFkvYXBxZ3JYUDZZUFp5TVpWZGl4UUxC?=
 =?utf-8?B?Sjh0b2pzSGxqTlcxQ0E1bEM1VDdxdlNIV0lUSWhtSW5Ea1NhWDZLSDk3a1c0?=
 =?utf-8?B?dW1UK0hoQ3dTUSsyNWZOeUhXY2pSVGdaTHJvc0NLWFczK3hrdTZBK3E5ZC9L?=
 =?utf-8?B?aVRnaVhNVUI2eW8zQjZMbk1FamIzMEhsZVBacmJQTjBTTCtYMzJuOFRtQkhJ?=
 =?utf-8?B?YW83d3NldXBoc3ZYUjZOTCsvNzlveFlDQWdvdEp5dDBjQ1k5ZC9NbWxyRnMx?=
 =?utf-8?B?QVBzNkhYREhaUTZtUzMyWUZ2K0ZoM0RWSCtGYklVTXUwZDZIVUp0WlRmdTI0?=
 =?utf-8?B?cWtKNk9abVUyeUVUekIzbHZPb1JoaVVPNktsMVloeXl5OXRPU1Z2K29KOFZo?=
 =?utf-8?B?UGJVbHdMS2tkeU1IVFFpWU9uQ2w4MzBKV3NLcGpZK3N2M0g1bEt3N0hmQTVz?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEF515282506F847851D9585CC835A42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb94f61-2cbe-41f3-214f-08dbced42063
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 05:44:27.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAmFVJPY3zYOh/xddcxDWq6rqIE0VnMYXzuFdSXC9296pIKqWSKS7jUU2H6tbWTSm/2SSz20fddVIW/14OBwWyo+OvRMabp15A6XiiPc2v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
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

T24gVHVlLCAyMDIzLTEwLTE3IGF0IDEzOjE4ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToNCj4g
IlZlcm1hLCBWaXNoYWwgTCIgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPiBPbiBUaHUsIDIwMjMtMTAtMDUgYXQgMTQ6MTYgLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90
ZToNCj4gPiA+IFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPC4uPg0KPiA+IA0K
PiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgcmMgPSBrc3RydG9ib29sKGJ1ZiwgJnZh
bCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHJjKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmM7DQo+ID4gPiANCj4gPiA+IFBlcmhhcHM6DQo+ID4g
PiANCj4gPiA+IGlmIChkZXZfZGF4LT5tZW1tYXBfb25fbWVtb3J5ID09IHZhbCkNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgIHJldHVybiBsZW47DQo+ID4gPiANCj4gPiA+IC4uLmFuZCBza2lwIHRoZSBj
aGVjayBiZWxvdyB3aGVuIGl0IGlzIGdvaW5nIHRvIGJlIGEgbm9wDQo+ID4gPiANCj4gPiA+ID4g
Kw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIGRldmljZV9sb2NrKGRheF9yZWdpb24tPmRldik7DQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFkYXhfcmVnaW9uLT5kZXYtPmRyaXZlcikgew0KPiA+
ID4gDQo+ID4gPiBJcyB0aGUgcG9sYXJpdHkgYmFja3dhcmRzIGhlcmU/IEkuZS4gaWYgdGhlIGRl
dmljZSBpcyBhbHJlYWR5DQo+ID4gPiBhdHRhY2hlZCB0bw0KPiA+ID4gdGhlIGttZW0gZHJpdmVy
IGl0IGlzIHRvbyBsYXRlIHRvIG1vZGlmeSBtZW1tYXBfb25fbWVtb3J5IHBvbGljeS4NCj4gPiAN
Cj4gPiBIbSB0aGlzIHNvdW5kZWQgbG9naWNhbCB1bnRpbCBJIHRyaWVkIGl0LiBBZnRlciBhIHJl
Y29uZmlndXJlLQ0KPiA+IGRldmljZSB0bw0KPiA+IGRldmRheCAoaS5lLiBkZXRhY2gga21lbSks
IEkgZ2V0IHRoZSAtRUJVU1kgaWYgSSBpbnZlcnQgdGhpcyBjaGVjay4NCj4gDQo+IENhbiB5b3Ug
dHJ5IHRvIHVuYmluZCB0aGUgZGV2aWNlIHZpYSBzeXNmcyBieSBoYW5kIGFuZCByZXRyeT8NCj4g
DQpJIHRoaW5rIHdoYXQgaXMgaGFwcGVuaW5nIG1heWJlIGlzIHdoaWxlIGttZW0gZ2V0cyBkZXRh
Y2hlZCwgdGhlIGRldmljZQ0KZ29lcyBiYWNrIHRvIGFub3RoZXIgZGF4IGRyaXZlciAoaG1lbSBp
biBteSB0ZXN0cykuIFNvIGVpdGhlciB3YXksIHRoZQ0KY2hlY2sgZm9yIGlmIChkcml2ZXIpIG9y
IGlmICghZHJpdmVyKSB3b24ndCBkaXN0aW5ndWlzaCBiZXR3ZWVuIGttZW0NCnZzLiBzb21ldGhp
bmcgZWxzZS4NCg0KTWF5YmUgd2UganVzdCByZW1vdmUgdGhpcyBjaGVjaz8gT3IgYWRkIGFuIGV4
cGxpY2l0IGttZW0gY2hlY2sgc29tZWhvdz8NCg==
