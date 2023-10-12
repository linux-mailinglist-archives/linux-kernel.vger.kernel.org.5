Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1587C75E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441821AbjJLSeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347356AbjJLSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:34:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E1C0;
        Thu, 12 Oct 2023 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697135645; x=1728671645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bLH26Cc693hacHSFBeql0VC3pFg0drdfby174FIdn8=;
  b=WMKvvAQnMfgjEssssaS/LCQE0ud3jOtP5eRkFv5p/XMcWzMFUzRtff5H
   frrVPRgw5dagF5bHKWametkqFE0Kvyb7Zap6PEJN1xk76t4f4IHmMsAHy
   aEQfDqGQGOZpqB+HO83HTRGNfufyJxIe1+ISXSY+DEdujA6rSWgNwwXud
   d6886MvoBIWvhbIyNy401HXPtXykiqw5hXKADFxkR1+rUZg+6eDdK5rcR
   p3gqu6JkrD7rDqAGv6PoxkYkPVR0J1W84Qa9LvlLeMmlONhbcnJmUSI6e
   Yw7vRM6z1cy11UNGHUMkjUV8V4TfT07lQmyaXXi4WApC8WXaegkg5pok1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387861104"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387861104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845101966"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845101966"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 11:34:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 11:34:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 11:34:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 11:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJtg4dtU4JgLMGzvr0Wr0LjKqVnc/Ohmr4Hx+MTuyFpyRd8jK/VFCPPyZs85byW6xAJ26Ot3aJSsZ/yWvPhnoUG1oNqFddhSEiXWtKYwjfIr9QA4DqaZCJC9rGdQ8A8iaiyrGK7CWBidkZH/ZR1BoAfRryV1WbU21NuN0Brzrh/01KJsvQDu2cwOei/O2cePuUVe89GcQxoHX41UBE/K4FS5irV6k1xmwqKgrEzhfSr8yKEU1u8nQSHiQX1R9seAsgTaUKJilYHl3+hKU6Xee57adnFXRbPFJnKomaF839ECUo0DjG8a3jeYBQY/gOFbrQC3ZU4D9CYk3v/+G0Q1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bLH26Cc693hacHSFBeql0VC3pFg0drdfby174FIdn8=;
 b=m9cG2qU+EuF+lCU1had6HjUXTtKE/ttmIzw7jYeSlw3NlAz6E5SP8k7TajXwuCAP35NCCK/SVjujP6qoCVLk6oki2p1XRwS48Y0tBlGW2WMF6yXwQM3wU6bk3fufmCsZLWjUWnAVl8gbkPbulMO5RCdkxn/Bz43seeiiIwgh22KUvmzcfydHBhxW5RFCn91PhxvcZK8MeOPEAKlPhYT5mYDW50QGiGd7thCpn/PS3tSn/cKSTr/1xQOPuHYoFvxoZxbWGzvvSWFBg9a7p05YpPHDXXOKPXoTrIVFClrYLuAYkAAzMPYhumHsJSuL4z72aaYFfzyOFwt9tPGPsdvikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 18:34:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:34:00 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
CC:     "Michalik, Michal" <michal.michalik@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Thread-Index: AQHZ6+2zvL5dTK0KXEmSDZ4XN62JhbAkO2eA//+1xoCAAI2EgIAh8C4AgAAr6EA=
Date:   Thu, 12 Oct 2023 18:34:00 +0000
Message-ID: <CO1PR11MB508965D49B6144B0CC7E5221D6D3A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
 <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
 <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
 <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
In-Reply-To: <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 4ea109bb-4d01-44ff-1bd2-08dbcb51cda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hEu5Br3hk2Bkef9PaARIy6fiY+Rgl8U1vl2WOsFzZcV5rNseU3mKRgDYHR2TFgxb1MmyCZVIG/NkSIFVqEces2h2kA+qtPY1NcsJpIymGSqHnHoL2TSlnzwQsQVOPBBHTYdQSgkqOOdHTgyaFk2mkigF7qWuQQYNMzA2FdgKk4IeICwydkriz+x48j8/qsWZ87NJPsIYke2yfMn0ZICK5z7GJf0s8BvWAKEYoePz4JyY33d3Bo3bUXIP93ijqGGn0a+o/xwbMH70whVRP8qmgzuNNufybcgqoUaKJ7FRKTjWBtzFKl8wbx5vbFwX/dC6skkpPL71vjOmAQt4a3GIYyWgZtz7K0whC7sx8JowihS1G6FSCVmEbPqJCYmx74q5wUfTbrP/7NCAVFi2v0/BSUkFxryP/JFNFBQUm4O0wQoikqEo7/McW6LBbK1y9Whlx6UyPfz4Ipl3i3o56diQ5YtPlmYPhSE42SVIBwG51vTktWmsEhVS7QhG19g5MT5eUo8o+JLme+EnFH4hGRLrBc4+Q5jAIQFnFpnEOd4mxoPwLYT+TdMfPLMQi08j2BBvEtEzVZUUcCbXtvdB1CSQxTSOnvt6MygLpokWtb280tGcNq33EIE1sCfgKfA/QjhJLsbbRS4N/50oYAEZ+N10w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(107886003)(83380400001)(26005)(55016003)(9686003)(82960400001)(5660300002)(66476007)(316002)(54906003)(64756008)(66556008)(8936002)(71200400001)(66446008)(122000001)(4326008)(8676002)(38070700005)(52536014)(38100700002)(66946007)(110136005)(76116006)(2906002)(41300700001)(478600001)(53546011)(7696005)(6506007)(33656002)(86362001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXAxMHdiNHdmbkE5ZStNM2VveHVDcU5jMWZtb3ZpVEpiRHhiSG90Q3J4OHhl?=
 =?utf-8?B?REdzS3JINEZaZ0RUZUFmVmoxbWoyRmkwQXpzbjVYR0ZpREJmdFdaOWdSVVV5?=
 =?utf-8?B?eVRiOWIyRFFySkRvanFyM3E0WHpseVRUdEhCQXVmNUJDVFVxRXZJaWtXUXUy?=
 =?utf-8?B?N3JHSi8rbk5BMnRYTnQ0amk2ZFNxOUJjWUJCMTllSmdyMWU5ZCtPUkRoV3FV?=
 =?utf-8?B?SmNCS2c0OXhNZ2pYb3JRSkdzQktpaUpCZWdPZ1hJTXdDRU13MG5RcmNLZzAx?=
 =?utf-8?B?RDZmSzBzQiswa2JXSFR1am1GNk5GZ2VSNjJEdjJFLzJOV2Z4dDN1RE5MQzYz?=
 =?utf-8?B?dGZkT3REYUV5VG4veEw0WkVpLzJDaytSV0ZkRE9uNG1jVDJ3c2ZtTURnWG1Y?=
 =?utf-8?B?cUc2aVFJNFhzK2V0WEZPWWtJaWJMVUwyZTJiejlsM1ZiNng0aHhzclhaanF2?=
 =?utf-8?B?UVA5MSt2M3I0cXJWQnowRmVvUmFwOS9HcW5VK0dRblBkRWJoM21zNjRxSG02?=
 =?utf-8?B?TnVhWk9POXNrc3UwM3FMc0doaXpOcWtSRit6T1poSUI0TmtnUWRKRHZjYXNp?=
 =?utf-8?B?dkxEYkpEd0c0U0I3Rk1wWW5na1Q1UVlRZExQVTJuWnF3MEVkbmduM2lwRkIy?=
 =?utf-8?B?OG90TWtja3JRVjRPbUxyZ2c3Zlp3R1o1Y0tPSGZUamxYM0hpTG5DR3ZYelhw?=
 =?utf-8?B?RjdEeEUzWkd4SGhySGZCdUZqMEVZcGNuOUlsaVV5cm1NS3NPSWtDaE9LeW41?=
 =?utf-8?B?VnEwNUV5b05PcmE1S3c3b200R3NHTWw5NnF5aWFid2lrK0hxWldMNjBVRjR1?=
 =?utf-8?B?VXM2TmJNMVliZFoxQWRDUklQd2VUVjNha0F2SDdGb0w0eUZQN0VFQnh0bXhp?=
 =?utf-8?B?SzN2NHZST0dweEdRSnhRa2Fsb1dHN0l3czY2OVF4TzF5d2NVb2tTU0hFV2lz?=
 =?utf-8?B?UmdQMWtCWkNJZUdibnF2VXhEdVNLOHg2OFdqWnJFM0xKbzBQR0E3c3M0RTRn?=
 =?utf-8?B?QWRBSDNMZkQrMDRhMUhXQm1EV3h4QUFxQVFnUlZocUg4UjJyWkt4MHZlYzBy?=
 =?utf-8?B?aHJpOGRicGdOVVVZc1I0ckl1UkMrOVBBU2FWd1B6ZUNEd0lwZ1g2S3ZpelVi?=
 =?utf-8?B?V05SazJxUUwrbnM0VUJNSnBYNitibGtnakd4K283V3QrbTNuU1dXV2wrOC9W?=
 =?utf-8?B?Mzh3VUhYZ3kzVFcyanhKQzBmdC9tTTBEWld0MGw3dmUrRHZRRno3Yy80MTFE?=
 =?utf-8?B?STYwRUxTQUNZaDlNRmovbjlhQUZyTDNsMGVaZmVVMmF4bXkyVk9YbXkyMzlU?=
 =?utf-8?B?emZoRW1GRWJsYnEzanN4aU5lUW50bEtXc2xaRStGRFN6V3F3OUo3MXhQUCsz?=
 =?utf-8?B?ckkrTUhXTXk1aGI1anF5aDM2VzZ2TW5HUUtZemlQUDRBZmwrY2FmMVhNVXIr?=
 =?utf-8?B?RXVwbU1FRTRUNllRUS9WMUdITlg3aFZ0a0d0UEhMQWEyNDJySElVYmxqWmFt?=
 =?utf-8?B?SjJWd1l6Z3czNjRnZGRyV2h5NkMyZVg1SVdXQU5qQms2N3VRQXhyZi9yTjNq?=
 =?utf-8?B?Y092cGdxOEpOcUh2UzJxa0w2a2tYSk1PckYxV3Z2ZFppZnc5SzNCQW5HLzJU?=
 =?utf-8?B?NlhNUjkwMHd2a3Q2ditRR3VQNU9BaTh2d1hDenlyd0pyMTlNeThoVXdNSTRq?=
 =?utf-8?B?ME0waU5FL0hBTndDLzY1U3ZXQW5VbDA5RFZCRE9scnNoN2tXeElMOExxRTRY?=
 =?utf-8?B?eGpzejEvZEhwWDJMNEF1Y2RINWsrU1V4MzNaWnhncVJXdTVDc1hxankyeExX?=
 =?utf-8?B?Z3YvdDQxZ1p6OEM2SmRHajE2RFNWTCszU1lsbGllTDdFcHBJMTliOGpPUFZz?=
 =?utf-8?B?VU5hTUl5a3lXZm5TaGZFYkRlVm0rYTRBUVBjTE9haW5zemR4bStkaWlHbGlu?=
 =?utf-8?B?bTdSWHdyS0VaL1kwR1JlRFVQeFk4TWJsZncrZmRzTjBqb1JzY3BBMThEMWlT?=
 =?utf-8?B?R005dFpiLzRJdERTVFVGWm9qUEdHeGlDTjh2VGFWMmxxYXM4VXJ5dmdYekhT?=
 =?utf-8?B?ek1td2J1dEJzUEUwTFQ1V3g4Z3dRUlBIcjVzQlhsOWZvenRxRUtoWXU4VzZD?=
 =?utf-8?B?Q3JmY1M0WFZuVzErRUZwcVVaOXA2VHJYNXp2UmR1aVdoQUI3MnhXOXVMRDdj?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea109bb-4d01-44ff-1bd2-08dbcb51cda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 18:34:00.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +m0hE+jLBYy254D7dZWfK6bJhaex37rurr3Y9SWefX9OP4y8lCzb9XafIo+opUC4AoprnWsDZwF0Vw/4fODtZb10W9jvHJxVMH2L3U2m/pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDEyLCAyMDIz
IDg6NDcgQU0NCj4gVG86IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
PjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47
IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQ
YW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IENjOiBNaWNoYWxpaywgTWljaGFs
IDxtaWNoYWwubWljaGFsaWtAaW50ZWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
UmljaGFyZCBDb2NocmFuIDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBLdWJhbGV3c2tpLCBBcmthZGl1c3ogPGFya2FkaXVzei5rdWJh
bGV3c2tpQGludGVsLmNvbT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZzsg
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgT2xlY2gsDQo+
IE1pbGVuYSA8bWlsZW5hLm9sZWNoQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCBuZXQtbmV4dCAzLzNdIGlkcGY6IGZpeCB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvDQo+IHRjcF9ncm9fY29tcGxldGUoKSB3aGVuICFDT05GSUdfSU5FVA0KPiANCj4gSGks
DQo+IA0KPiBPbiA5LzIwLzIzIDE4OjMwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4NCj4gPg0K
PiA+IE9uIDkvMjAvMjMgMTc6MDQsIEphY29iIEtlbGxlciB3cm90ZToNCj4gPj4NCj4gPj4NCj4g
Pj4gT24gOS8yMC8yMDIzIDI6MzAgUE0sIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gPj4+DQo+ID4+
Pg0KPiA+Pj4gT24gOS8yMC8yMyAxMTowNywgQWxleGFuZGVyIExvYmFraW4gd3JvdGU6DQo+ID4+
Pj4gV2hlbiBDT05GSUdfSU5FVCBpcyBub3Qgc2V0LCB0Y3BfZ3JvX2NvbXBsZXRlIGlzIG5vdCBj
b21waWxlZCwgYWx0aG91Z2gNCj4gPj4+PiB0aGUgZHJpdmVycyB1c2luZyBpdCBtYXkgc3RpbGwg
YmUgY29tcGlsZWQgKHNwb3R0ZWQgYnkgUmFuZHkpOg0KPiA+Pj4+DQo+ID4+Pj4gYWFyY2g2NC1s
aW51eC1sZDogZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cngubzoNCj4g
Pj4+PiBpbiBmdW5jdGlvbiBgaWRwZl9yeF9yc2MuaXNyYS4wJzoNCj4gPj4+PiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jOjI5MDk6KC50ZXh0KzB4NDBjYyk6DQo+
ID4+Pj4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdGNwX2dyb19jb21wbGV0ZScNCj4gPj4+Pg0K
PiA+Pj4+IFRoZSBkcml2ZXJzIG5lZWQgdG8gZ3VhcmQgdGhlIGNhbGxzIHRvIGl0IG1hbnVhbGx5
Lg0KPiA+Pj4+IFJldHVybiBlYXJseSBmcm9tIHRoZSBSU0MgY29tcGxldGlvbiBmdW5jdGlvbiBp
ZiAhQ09ORklHX0lORVQsIGl0IHdvbid0DQo+ID4+Pj4gd29yayBwcm9wZXJseSBlaXRoZXIgd2F5
LiBUaGlzIGVmZmVjdGl2ZWx5IG1ha2VzIGl0IGJlIGNvbXBpbGVkLW91dA0KPiA+Pj4+IGFsbW9z
dCBlbnRpcmVseSBvbiBzdWNoIGJ1aWxkcy4NCj4gPj4+Pg0KPiA+Pj4+IEZpeGVzOiAzYTg4NDVh
ZjY2ZWQgKCJpZHBmOiBhZGQgUlggc3BsaXRxIG5hcGkgcG9sbCBzdXBwb3J0IikNCj4gPj4+PiBS
ZXBvcnRlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4+Pj4g
Q2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZXh0LzRjODRlYjdiLTNkZWMt
NDY3Yi05MzRiLQ0KPiA4YTAyNDBmN2ZiMTJAaW5mcmFkZWFkLm9yZw0KPiA+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0K
PiA+Pj4NCj4gPj4+IFRoYXQgYnVpbGRzIGZvciBtZS4gIFRoYW5rcy4NCj4gPj4+DQo+ID4+PiBU
ZXN0ZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+Pj4NCj4g
Pj4+IEkgaG9wZSB0aGF0IHRoZXNlIHBhdGNoZXMgY2FuIGJlIG1lcmdlZCBpbnRvIHRoZSB2Ni42
IGluc3RlYWQgb2YNCj4gPj4+IHY2Ljcga2VybmVsIGF0IHNvbWUgcG9pbnQgKGkuZS4sIFtQQVRD
SCBuZXRdIGluc3RlYWQgb2YgbmV0LW5leHQpLg0KPiA+Pj4NCj4gPj4NCj4gPj4gRGlkIGFueSBv
ZiB0aGUgb2ZmZW5kaW5nIGNvZGUgbWFrZSBpdCBpbnRvIDYuNj8gSSB0aG91Z2h0IGFsbCBvZiB0
aGlzDQo+ID4+IHdhcyBmcm9tIHJlY2VudCBtZXJnZXMgYWZ0ZXIgNi42IGNsb3NlZC4NCj4gPj4N
Cj4gPj4gVGhhbmtzLA0KPiA+PiBKYWtlDQo+ID4NCj4gPiBPaCwgSSB0aGluayB0aGF0IHlvdSBh
cmUgY29ycmVjdC4gU29ycnkgYWJvdXQgbXkgY29tbWVudC4NCj4gPiBUaGFua3MuDQo+ID4NCj4g
DQo+IEV2ZW4gaWYgdGhpcyBpcyBqdXN0ID4gdjYuNiBrZXJuZWxzIChpLmUuLCBsaW51eC1uZXh0
KSwNCj4gaXQgd291bGQgYmUgdmVyeSBnb29kIHRvIGdldCBhIGZpeCBtZXJnZWQgZm9yIHRoZXNl
IGJ1aWxkIGVycm9ycy4NCj4gSSBrZWVwIGdldHRpbmcgYnVpbGQgZXJyb3JzIGluIGxpbnV4LW5l
eHQuLi4uDQo+IA0KDQpBIHN0YW5kYWxvbmUgdmVyc2lvbiBmb3IgdGhlIGlkcGYgZHJpdmVyIGZp
eCB3YXMgcG9zdGVkIGF0IFsxXSwgYW5kIGFub3RoZXIgYWx0ZXJuYXRpdmUgZml4IHdhcyBwb3N0
ZWQgYXQgWzJdDQoNCkZpeGVzIGZvciB0aGUgaWNlIGRyaXZlciBoYXZlIGFscmVhZHkgbWVyZ2Vk
Lg0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMDkyMTEyNTkzNi4x
NjIxMTkxLTEtYWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbS8NClsyXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjMwOTI1MTU1ODU4LjY1MTQyNS0xLWFybmRAa2VybmVsLm9y
Zy8NCg0KVGhlIGZpeCBmcm9tIEFybmQgZ290IGFwcHJvdmFsIGZyb20gT2xlaywgYnV0IGl0IHNl
ZW1zIGxpa2UgaXQgc3RhbGxlZCBvdXQgYWZ0ZXIgYXNraW5nIGFib3V0IHN0dWJzLiBJJ20gZmlu
ZSB3aXRoIGVpdGhlciBhcHByb2FjaCBidXQgd291bGQgIGFsc28gbGlrZSB0byBzZWUgYSBmaXgg
bWVyZ2Ugc29vbi4NCg0KVGhhbmtzLA0KSmFrZQ0K
