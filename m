Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62B6804103
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjLDVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:34:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25370B6;
        Mon,  4 Dec 2023 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701725670; x=1733261670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=17Nid/v4Ti6r9je3Ks43jvbGsbN/iIoGvnFx6eTtibQ=;
  b=gJ5Brswb8X0GXBkzeZc2WRqTgIrq2oQZ5FZDXc5P1Lf/SmTMmY8jlXQ5
   C/4e1xura5mgWFaBG0V8qRn7s1Qx8CLzBW7ciT0ggUVzISasGCIuRzAWO
   gb8BpCmtjUrBxGysMDcgea+Nii5bDE/5kfd4/AoCKXYjydWVY+ZvtN4D1
   bcLOYOmzJXhbgGRWQv80agJ2+z34rphD0z/yWcDOEvUda8ywZzEsZZfFs
   8w9Tj4rl0N7mlnUYJsifaVDDKq0ykGPivUVhq30iB/bA/S3k+Vjv9kmXC
   QyrbRDCsxkjXvqPyqyyCwRmrU0UOYRrLKisn3Qf9RrGR/NMzghFTD5+rP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392671242"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="392671242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720455509"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="720455509"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 13:33:21 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 13:33:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 13:33:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 13:33:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwtYF7Ghl5ycFiwWtbfaJb1XRhMHylvUa37UGQXtfw0uEnm2gT22juTfeBIgTda5IcehimatyH8GKjbgn1jmr/iPvQdbzVLNKACb966yio5MeFchX3TRpfBRK3BgVwQz7EFvpj54wxCHjmxuEIPeS9nr0DpgGsg+vYb18ulv0evUQH3muW6b5duG+e8rGbU1j7q9+/ZZTLS2a5qiMe6XahqyHq57gD2oo2x88B3fy+4PI0FwKDI2GVYnCYY0nPCtOu5M/aT2Hvrc9lZZgX3WFXeWN+UY0XH8Kn9XA0GNuyErrdhA9bWd6uCvWZJ6XqqydAI+xesT5REv1AZILFwcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Nid/v4Ti6r9je3Ks43jvbGsbN/iIoGvnFx6eTtibQ=;
 b=nrCGVKPS7UUhVkRyKcGEpfvNtP7SmBEhB+LB5UUIJ4NeG+fHYRHuyPdpzR2Y4WLpyUaApgkzC8jaTKORvfzrdIAkOhNiihLbYlnht4vySwwqI19N0fYuCSKEqcRl02zAkb61tiZ3q84GfZOiv9mWg80w1eCBryEsTie5YUi+PwPgyac15Z71nWy5CWD1GBpqCrdU3I3VNlkOW5Mg04qKi6y72f9jQ1gdAFGZpVKUq6wWQplyxO7Cb0t1rVMe87Rv+KvK5bq2UvSdfuDqzBHlpihJQZEpPEha8Z4/HmcXbKS+ChvPvRF7aDP3WxZsqB8cDn4AZ2g3YDLayl3FzjdKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5512.namprd11.prod.outlook.com (2603:10b6:208:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:33:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 21:33:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v13 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v13 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHaJuNIvVsGG2Nm60WrN6rPQzBF4bCZoZUAgAACsyA=
Date:   Mon, 4 Dec 2023 21:33:19 +0000
Message-ID: <SJ1PR11MB60839F792A1CE897B2724814FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <8c762203-db0f-d5f4-fc81-9cc548ee92af@amd.com>
In-Reply-To: <8c762203-db0f-d5f4-fc81-9cc548ee92af@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5512:EE_
x-ms-office365-filtering-correlation-id: b200ada4-78ec-41be-22d8-08dbf510a225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yq0GEs9gatJjWji2qUnASLunjKxAVLk6krq7WNEYppsFBEytgGDypKt67Bl/GSf1q9aYcn4u9WraT/s/Nfomjif/1kyL88lcwzT4Xo5Xs2YKCFJNJb0YEaR77w9QIbnTOOaEhq91TFsDHP0ei3G9C3MtCLABlzeR4QWic/jGxBCLbicNTSChlbv2BNJqBo8wuGdQf954L/BM7ir2bJYQj7YdnMeYu265uK0HjfcVe3A5KX4lVJPeOdib7fpl9AZo7kU3XXkWr9IK2F2ca7tmeUZHuus+gjEDXE/OZmxxk/8vtAnVLZwOp3m0c8IpPwI4px5K4ymOQiisW6WgbsTk7ojCKT2kPrVxTXWaOsMZHc+Znx6zFlQb06eKxRYelNfc8zx4f6Y/h/s6rmcQ5wYsHZkgRnrAruNb1bwG193teKoxbvV6W7271/qWesq27sscj9vYRk3+Od/qZUbC7YaHhJLeVwmApgMzb/v4qqeonuOPjeQl8v9K/mxY4nSI2hDs81mIlgVbk/GGq3/6MpDvurNbUgPYZ1X0esLFrki6yyQDfxd7YhPaAQzT0wq9sc/oTQWbLt8BXt2tji5eVIDX8JUvLdawDDrzz19bPt7PgC0wiy1qm9os2RwmuTUQb6jN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(558084003)(5660300002)(52536014)(86362001)(4326008)(8676002)(8936002)(2906002)(7416002)(38070700009)(41300700001)(33656002)(71200400001)(9686003)(6506007)(82960400001)(478600001)(26005)(7696005)(38100700002)(55016003)(122000001)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZ0VVR3WmZpRHZDOXhydVZkTC9OV1VzT29GNThWUDhYa1BnTElyTUZSN1FF?=
 =?utf-8?B?bXRac3Z0MHU4MHRFU1VabzJEMHdsakd0bVZWdW9ZYmRTb1F6Zzlqc3JISHJV?=
 =?utf-8?B?TGRiV0NSTFFRcGp1Z1JiaHdHWFZzUzZBeG1MbmpGREN0TDhNMTlubTRKSFlq?=
 =?utf-8?B?RGtYeDBqOEN1NitMai8reUlqRW9rbmhQMUlQZXFYcllmRXFIOXJCc1NBNU12?=
 =?utf-8?B?ZmJpbmdUNHZuKzlZV01jUUdIU0s0cTczdGtzTWZZNUY2ZTJNTjJnUW04ejlN?=
 =?utf-8?B?Rjc2aXEyNEdvR0NSbGJOc210bnZlYk14WFlPSWlOeTJVTXo0Lys1Ymd5SzRP?=
 =?utf-8?B?bk5nUm5KeG5HYld4THIxRm1PeDFRaVpPVERETWdaQTYzY3dKU0pXTFBLUUl3?=
 =?utf-8?B?dk1yd0JKYVVXUTVnQU9yRDJrbEx0S0d0MWxCYU5oTzJHZCt5K1pvQU95bXFE?=
 =?utf-8?B?TW8wNjluRzYrQnFFdFVLLzZTcXZwSHZ0aDVSMXlVaTZCZ2VVWWhtZGt5R3Vs?=
 =?utf-8?B?UWQ3Wm9hTUVPRGFiZ0JoRWttVkhzL2RCcmVqWFg2T1V6RTgyQ0ppWFdxVnRa?=
 =?utf-8?B?TGtCbm1kTFRpbkRScS9KQnlnYjJnTHpUZXlZNmFDby9JZkM0QUREWnpscmdK?=
 =?utf-8?B?Y0lwNUJ4Nzc4c0t6VWJUWk13eTE3MzFIcnNkcGJ0eXZFbGY4SUtwaTZ6bUhQ?=
 =?utf-8?B?VFFjdllGU1R5ZDcvalFLUmNUTGtBVllmakl5ODdFS1FEZDFRUDBSbWlTdm1n?=
 =?utf-8?B?S1IrUlA2Y3J1VDNDOW9EL0Zyajl6SktsajBvdG9KTjFGOWE1WVpsZ0s4dlg0?=
 =?utf-8?B?TE1CU0c0Y3F3WmVRVjFGNFRRTXZGeGtmbGJ0b0dCZk1rc041UzlDd0tIcyti?=
 =?utf-8?B?emNYVnkxb1NOS1ZDSG0zbWUvTGV5R25CTGtZK1ZWdnFXL3REUmZxOHViajZk?=
 =?utf-8?B?MVJ5ZzQzR3EzWnlrSXIvOTBWREs4eEtCU0w4UThNK3JKOG51RXR0RGFpdTVD?=
 =?utf-8?B?OHJtcXJzOHJBN3BGWG44NlByRGdycXlyZEwrWFFXbjFuL1lmNFhaNXBaVndC?=
 =?utf-8?B?TkQ2UUNrTG11UDNWNlZ4aUF1eXFkZHlzaE1CMDR2bWEzRitoRnI5WTBtUG14?=
 =?utf-8?B?Z0grZzlldTgwMFFPYzBFNUk0M0VrWW1iU1NpMVlzKzRRb29hMlBTTlFMVzNN?=
 =?utf-8?B?bTkyMVJSVDJyb2pFVXVCcXp4a2wrS25lN05IRUxPM2I5aFkzQXdnbCtYTlVD?=
 =?utf-8?B?SzdwdThJR09TZVRjNmhydW9BUlFtVFVBMmptL2xkd3Y2eHhmbzIxWG93UUVX?=
 =?utf-8?B?aE9hL2N3alpsbXJEbEwyeDV4bmd3dDFjaVNNQ3J6cDl5ZXpTOTRqODFIbjZ5?=
 =?utf-8?B?dHhtT3VDZW8vYmtUQTIwek02U09zbEZpRk9pYTNlRFFLMEJYREZzM3NFT3BS?=
 =?utf-8?B?MkNFT0U0ZlMzSDVNVjJJTlNmaWtKamZEbmZNd2hKT21YYllaU05lYmo4dzlm?=
 =?utf-8?B?V052blJNQWtNV2xTa2lvNWNkRTVKQ0FMVUg3V0dDd2VKLzNsWlJjenVLNzVs?=
 =?utf-8?B?NDNOMEl3T1BMcEV3Ym14Nk9GWENJZTJiL0lVaWw5Syt1NFRqRDdqVHdnRy9U?=
 =?utf-8?B?dTBMd0NlbG9zYW1vTWNTanpMdEo2QjJIeXV0eVNSZUJpMkxVWnBVNytSOHc2?=
 =?utf-8?B?RjdzUG1FZHlBbTJNV3RoM213YWR4SDh3bDNtWDVrdEVPV3d2aFVSYXRCL1JJ?=
 =?utf-8?B?ZThYTnR6cUFSVGdva1R6eTN0bXVsZDlQYUtEc0JXR3oyTTVUdzIvK0czMjdL?=
 =?utf-8?B?Z3pqNHhSSXVWT2Y1Wlp3TmFiNnJxU1ZmVGVhY21STzZXRDBmeEp0aW5INkhF?=
 =?utf-8?B?M0xaaTh4RDJCWU13RHVDZDR1TXpIVHJWcWxjdXQybHdLZ3E4eXFBTEtNYkgx?=
 =?utf-8?B?ZXV3MTNrZ0VoTnp6UWJ6emNEZTNMS1RyZUpEdElnN1ZNSlp2cnNzNm1mS2NE?=
 =?utf-8?B?WnZUS0RjQWMwZ1dmL0w4WGx1RkF0c1gySHQyR25IWkhVSURuOVlsaTQveG02?=
 =?utf-8?B?dzNjNnJkZXY1YWFUOGtDNVhUOUlFVGxzNzZHeVE0c3F3YXB0b2ZzS1VkOVhn?=
 =?utf-8?Q?5LSMAlpAKoTRwzcgg0tvMuVAY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b200ada4-78ec-41be-22d8-08dbf510a225
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 21:33:19.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p54VJiTmpevJJoJy3Ab9fH6wXtbr3URK35byTU5n0tGmx4tfy0utl/Bj9c+BPv1PqqXTU9ulYhrjH2hEox80JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5512
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

PiBUZXN0ZWQgdGhlIHNlcmllcyBvbiBBTUQgc3lzdGVtLiBKdXN0IHJhbiBmZXcgYmFzaWMgdGVz
dHMuIEV2ZXJ5dGhpbmcgDQo+IGxvb2tpbmcgZ29vZC4NCg0KQmFidSwNCg0KVGhhbmtzIGZvciB0
ZXN0aW5nLiBJJ2xsIGFkZCB5b3VyIFRlc3RlZC1ieSB0YWcgaWZbMV0gSSBtYWtlIGEgdjE0Lg0K
DQotVG9ueQ0KDQpbMV0gcmVhbGlzdGljYWxseSBub3QgaWYsIGJ1dCB3aGVuIDotKCANCg==
