Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738847EDC17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjKPHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbjKPHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:39:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40821120;
        Wed, 15 Nov 2023 23:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700120360; x=1731656360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OBk0KZlzXuOkiAZ7r31JPXLw9i70RjK16HgLNag9mO8=;
  b=QnW5tbAL7AclQPY8mDb08aEg4Yd1LYc4apEVoyFRnZgymdo6zNl3id7g
   fxKyfGAgkSpXIASF0yqbdLvPlK/FCRs+gT0cE1MtJmv8ZnwL2+AWqwQeL
   4a0isocmmq5QqWoWyFcdSnBR78XgGL1A4QHL1A1h60lBX634+uMmk1jcG
   iMvtTCBwfc3RPFKuvYrg7dJxj4r2D0H/Tb2boQxLDliULZ1ex24M0STEq
   Zv+MZnfM3MHqnzTIqGT+MXSMojfHh7tpwWAig+kTqYgz43JadipYZGicX
   gQRemweY/qxRlZOd2GxDbietffN5HyOMWBzY+mkfl7bwu5sIBuMvoO4Ts
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394951542"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="394951542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909027928"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="909027928"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 23:39:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:39:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:39:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:39:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB4Hz7Tju7WXKOd1SN82DQ3kvb5QPe5rLtDMSfl4EGfxHz57nEP8C1feHxVNaHHVQsTAAnpooblsptVftzFJhs88AvNGfgENn7oooSX3g3U0KNp5vqbCSDVUyjT/CCph9hqhBJHNOht3D80broQZZnK1OiL+rWKoP0XOeZUVpHJ9WMfCiWB80s88FtGTGPB/GtQa72ry7N1qGRBzZ7t7uY/YkN1R04XqESbBGtGdUWX/UOwzDmj1eMheOKogvUwW322AWpq5KEMbvQQLshObMm/n04b+xTbLbXfdCxGkm8jHMl4DvQen1Va67quCgucI4aw+G+cJkQaes8WXxvtDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBk0KZlzXuOkiAZ7r31JPXLw9i70RjK16HgLNag9mO8=;
 b=JQw+ruXEqY6IRFh/RW5djV+XcfsRlfdSIyrAq/32AaNt7093T2Viz/Ey7qMRfk4rq21iGdJm82G4njkz0f97JH3xFa7WoZVaLGULvdjh0xiYpD5UCtFMnrWrthj5Hqvky3wD1pov8K1tNU9ub4uxrjMZUdufpecmDreXB8OLt11tkBXzOWoskqbgBCQHTzq1avXAHuVn/3nqpRJb4SAgRjtBJVhsnrNG/SeCK6cnTk4hG89mX4usH5OgUAAGGljNthRS0Z8AtRvdPG9lTMWj+LBhixLYzv1dvVqD/mFHIgTV4JhsHEqDjDgza+jZ//It6vWqFQLIlRRPdDvozbixUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20; Thu, 16 Nov 2023 07:39:10 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::ef0d:a32:5079:f61b]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::ef0d:a32:5079:f61b%4]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 07:39:10 +0000
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Looi, Hong Aun" <hong.aun.looi@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: RE: [PATCH net 1/1] net: stmmac: fix MAC and phylink mismatch issue
 after resume with STMMAC_FLAG_USE_PHY_WOL enabled
Thread-Topic: [PATCH net 1/1] net: stmmac: fix MAC and phylink mismatch issue
 after resume with STMMAC_FLAG_USE_PHY_WOL enabled
Thread-Index: AQHaEsouSAsqsnYj7kW/bSLJZaiaMbBxtQQAgAAx0oCACrBWAA==
Date:   Thu, 16 Nov 2023 07:39:10 +0000
Message-ID: <DM6PR11MB330673F1441CFE89A8092D66B9B0A@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <20231109050027.2545000-1-yi.fang.gan@intel.com>
         <ZUyjOEQHHnnbzwrV@shell.armlinux.org.uk>
 <01aa11e0c8b0aebb1340b5702a42b20c7a7aabd9.camel@redhat.com>
In-Reply-To: <01aa11e0c8b0aebb1340b5702a42b20c7a7aabd9.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3306:EE_|DM6PR11MB4738:EE_
x-ms-office365-filtering-correlation-id: edc41564-010e-4644-beab-08dbe6771f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LoP1Cqrc3IkxVUTwxtmfSpCHsvsK/xB4MB2nCVJaARh/jLwX93CHnzQtLXHSrDOUo5DSDv6bnLFrtL9E1u0OFGzAHbgzJ1dmTAF9tIkfTiaNZTm9TJRP7me98awKWRskKHXclhGPSDpcZa9llgbtLHSfiQRVCFMaD1ErPasN4JLe910Hq2sm8szP4XW/NLdplrAkOXiEHnDuYC4QIgdSJE6ymiHmFnPZmGVpbHWqM7O44Mp7BZ3kKAa9PKt/706X5DlK1RlJSk4oxkpL17rc+aQU5zsHU7KzktEVs/Ljb0WrZXiRwJNKpQGDU8J7T+toEvB+yEddTkbWT/FwMiKlvGsKG0A5uJrbc49isen081+PjwaohPEz+bOwmCb7JFIGUbZLN3Dm8wMJevEXDJ0jiq+rRTL89s1PWu4Bk3LtSELpsCTpqla7hxUFG3BEet9LU1VvpHUnmDUlo0XbKc533wO8i8S3x4ylT3NWsyxV37CnJa5oFUq7uFkUYJY8FY5wnGsmedw37ZyZ6F25YxQD70LvM36NbwVGw82Y3MNrtML5TdFXd1yNG0m1YSFaZWdvp3RcnYKjwO4q1xIpwMho5ZByLldIbh5bhiC8ksYV+IRMmmi8LWtihlsSJIO95jup
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(2906002)(6506007)(9686003)(53546011)(7696005)(52536014)(33656002)(5660300002)(86362001)(71200400001)(7416002)(316002)(64756008)(54906003)(110136005)(66946007)(66476007)(66556008)(66446008)(76116006)(4326008)(8676002)(8936002)(38100700002)(38070700009)(83380400001)(41300700001)(55016003)(26005)(82960400001)(107886003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aCtOcFcxbFJTK01Ud3BjUHd0a1RXWWU4b09ScFMwcEpCSXkrbXVnbU02R1NU?=
 =?utf-8?B?Q2xHdXR1cTIycnpQZ0xPVlRSYVJTYWpFNUJFdTZWNlZEaEVrTm1HakRUNG95?=
 =?utf-8?B?NlBVeDJmdmlEQjNZQVRBejVTR0dxUW9BeENZeTJ0d09OTE02NGFjUnY2bmdG?=
 =?utf-8?B?Z29oaEdBQkFiajg2RForQmFtMnNGL1JUVEdZVnk4ckRGV0lySlpkUlA4NWY2?=
 =?utf-8?B?OFpjUFVtSTVXWTBvdWs2RUc3MzhWSnQwY2VXR1NyZUZqOTdRTlBSMnZZMjIr?=
 =?utf-8?B?ekVaSkgrYlRWZjdGYkRZRit2RjZPQWM2RUdFQUJiM2RXYjR0ckhpWFBnT0wv?=
 =?utf-8?B?d3c1dEo0QnkzZ0hGVVBnTXVDWEFNLzV0cERUbkhwYzR1RHJjcjNsVElmNkdr?=
 =?utf-8?B?RVphVE5lcWNzY2pWOWNMajlNS2lPR1huVjFLMklUMHhsZE81SFBzckZvMDM0?=
 =?utf-8?B?UVhTNFpTTDNYd05XS2UrVWZLRC83ampUTWErUzdDTXFtTDg3YUNNWE5rU2Jh?=
 =?utf-8?B?M0N1bnBQcGVMcVYvczVKSEtjaHlUTGlobllFZjNMRGVSU3pFR3gwb0FVUkwz?=
 =?utf-8?B?NDl0djExa3FTSXJHekdwTkZzTGN3aW5CSjhKT0ZLbXB0eHJhdUtITkU0NWtG?=
 =?utf-8?B?ZTBnK3FhN3VpSUNOTG9TSUUwcHg5akc5Yi9XN0RBWUtpU3dQY1NpWFNNMmpz?=
 =?utf-8?B?VXhHNlVwdHZJSSttdm9DYjBmRUl2Vm1SVWljT01USG5ESDlXdEpmRUI4ZDRC?=
 =?utf-8?B?bThzUzJuSUNoNm9LM3lrR3hseWUvWU51eU43RVNUd0Rab3g3YUJqZGxDdlA0?=
 =?utf-8?B?SU12Z2Q4K3l3ajRWSEpoS0JPc1l1a2MxZGRNSUFpZVNLdytkdFI2Vnhod20v?=
 =?utf-8?B?VzFxcHVBSDU1dWlQUjdBQzFkd1JDeVB4dDZLZkFiQVBOZEVHK0RtbDNVcmdJ?=
 =?utf-8?B?VFp1VUpLWlRZN0lXQVdmUUJDcExDQlZ2Mkp4aytZWkNwc0VmTjlqSzFYR09m?=
 =?utf-8?B?cFNncXVaNTRDYkszemp6dEtCV1d2aHNsWVZMd3JNYnlHT0xLaFlJWEFwWE01?=
 =?utf-8?B?TElOcXJGcytybyttZUVwUkhHRGtjczhVTEdnb3pzOWpsWFBWVEM0a0FkZTk2?=
 =?utf-8?B?d0poNm9vdmFueDhqTng0amtrc0NDOW1PQW5JT1M3UGdrcDc0cHJHa0o1T1d4?=
 =?utf-8?B?clNSTm9sTG1kS3Npc3RiSExIRUdmZ2pRa1Jzdld6Z0dXZG40QXBHS2o0VWl6?=
 =?utf-8?B?QXExSXZrVHY4cHhtdVJDQUpTdk12WDlSODBpTUc5cGFqNTZZYlJIOGZJaTll?=
 =?utf-8?B?TDF4ajQzZVZscHpHblhtUW1MRHNpd0hHMzJlcW9ic2wwaHNkN1piUTVmcUxL?=
 =?utf-8?B?Q0pBU2E5Sk5vSEpKQ1E5WllRQ3JPQWRmbGhTdVE4TDE1RlJjNG9TUTFucS8w?=
 =?utf-8?B?bXljdWV2Z1JtRkdEVXRmOHIvUC9MZDJ5Mzgvam83SDJaZG5aZnVyY1dHN3hq?=
 =?utf-8?B?T3JOMFBQZWFGbzh0QzhoL0MvWVdEOStweHdxdnZSMllpT3pMcVBJaVIzNnFD?=
 =?utf-8?B?TkhMY3VUYU8ydUc3QTgxeFdhS3EvN1d0Nm1DdmJCc1IwU2QrdGhHMHl3Nzg5?=
 =?utf-8?B?NHQzNWwwU1RZazROTElURVcwQ3JhUjBSZ3NEQjRhdTRuY2VMdk1abXd5bDRk?=
 =?utf-8?B?QVEySStLM0xuQmRPdE5NREYwczljS1lzOG9SaWVyQWtMZXZBeWg5K0txZVpI?=
 =?utf-8?B?Y0RCSEdmV1gzeWN1NzRUbE9rRnp3Q2RtNTdZaWxQUlNCcVJtTDBJSk1BbkdG?=
 =?utf-8?B?NmFLUW96a2x0VUJRQWNhaDB0NXFNRGZvZkdPbEREaG0vL3dudDNVclBORTVO?=
 =?utf-8?B?RnpVbVdVQVVKM3JoMXMwME1TT1NHTkEwVnZ0bzZCODZ4bnRiYUdoVEQyYTUr?=
 =?utf-8?B?T0lLZ01hMDR0VmdoaDlJdGFub1RPcXFOMk9aaU9sSnBDVFpGdlM3ajFxdUlj?=
 =?utf-8?B?d09XUkZyRk5SbVl5MXZ2aFdSeVNScmZaQjhrd3FMYXlRa2hGU2Q2OUttOGV6?=
 =?utf-8?B?R3JHUFpzRG5vUlBpWVRZUHlXZC9JRWlpMTJMWDVMb0V6QW5nbk5LQjJtUjY1?=
 =?utf-8?Q?bxKNq2N0YeU+1TKpoEHI+Catj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc41564-010e-4644-beab-08dbe6771f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:39:10.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcYFW8eXKMZ1TSziK8pzVry1dHjceA+HBpomplFnDg/SNmrHijDqwfPeWt9qLDdn7Mci+0DCujyrPpD9QVGrXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFvbG8gYW5kIFJ1c3NlbGwgS2luZywNCg0KQWZ0ZXIgc3R1ZHkgdGhlIGluZm9ybWF0aW9u
IHByb3ZpZGVkLCBpdCBzZWVtcyBiZXR0ZXIgdG8gZmluZCBhbm90aGVyIHdheSB0bw0KcmVzb2x2
ZSB0aGUgaXNzdWUuIEFwcHJlY2lhdGUgZm9yIHRoZSBkZXRhaWxzIGdpdmVuLiBXaWxsIHRyeSB0
byBmaWd1cmUgb3V0IGFub3RoZXINCnNvbHV0aW9uLg0KDQoNCkJlc3QgUmVnYXJkcywNCkdhbiBZ
aSBGYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJl
bmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgOSwgMjAy
MyA4OjE0IFBNDQo+IFRvOiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az47IEdhbiwgWWkgRmFuZw0KPiA8eWkuZmFuZy5nYW5AaW50ZWwuY29tPg0KPiBDYzogQWxl
eGFuZHJlIFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpvc2UgQWJyZXUN
Cj4gPGpvYWJyZXVAc3lub3BzeXMuY29tPjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Ow0KPiBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5z
dG0zMkBnbWFpbC5jb20+OyBKb2FraW0gWmhhbmcNCj4gPHFpYW5ncWluZy56aGFuZ0BueHAuY29t
PjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtDQo+IG1haWxtYW4u
c3Rvcm1yZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExvb2ksIEhvbmcgQXVuIDxob25nLmF1bi5s
b29pQGludGVsLmNvbT47IFZvb24sDQo+IFdlaWZlbmcgPHdlaWZlbmcudm9vbkBpbnRlbC5jb20+
OyBTb25nLCBZb29uZyBTaWFuZw0KPiA8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDEvMV0gbmV0OiBzdG1tYWM6IGZpeCBNQUMgYW5kIHBoeWxp
bmsgbWlzbWF0Y2ggaXNzdWUNCj4gYWZ0ZXIgcmVzdW1lIHdpdGggU1RNTUFDX0ZMQUdfVVNFX1BI
WV9XT0wgZW5hYmxlZA0KPiANCj4gT24gVGh1LCAyMDIzLTExLTA5IGF0IDA5OjE1ICswMDAwLCBS
dXNzZWxsIEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+ID4gT24gVGh1LCBOb3YgMDksIDIwMjMgYXQg
MDE6MDA6MjdQTSArMDgwMCwgR2FuIFlpIEZhbmcgd3JvdGU6DQo+ID4gPiBGcm9tOiAiR2FuLCBZ
aSBGYW5nIiA8eWkuZmFuZy5nYW5AaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IFRoZSBpc3N1ZSBo
YXBwZW5lZCB3aGVuIGZsYWcgU1RNTUFDX0ZMQUdfVVNFX1BIWV9XT0wgaXMgZW5hYmxlZC4NCj4g
PiA+IEl0IGNhbiBiZSByZXByb2R1Y2VkIHdpdGggc3RlcHMgYmVsb3c6DQo+ID4gPiAxLiBBZHZl
cnRpc2Ugb25seSBvbmUgc3BlZWQgb24gdGhlIGhvc3QgMi4gRW5hYmxlIHRoZSBXb0wgb24gdGhl
DQo+ID4gPiBob3N0IDMuIFN1c3BlbmQgdGhlIGhvc3QgNC4gV2FrZSB1cCB0aGUgaG9zdA0KPiA+
ID4NCj4gPiA+IFdoZW4gdGhlIFdvTCBpcyBkaXNhYmxlZCwgYm90aCB0aGUgUEhZIGFuZCBNQUMg
d2lsbCBzdXNwZW5kIGFuZCB3YWtlDQo+ID4gPiB1cCB3aXRoIGV2ZXJ5dGhpbmcgY29uZmlndXJl
ZCB3ZWxsLiBXaGVuIFdvTCBpcyBlbmFibGVkLCB0aGUgUEhZDQo+ID4gPiBuZWVkcyB0byBiZSBz
dGF5IGF3YWtlIHRvIHJlY2VpdmUgdGhlIHNpZ25hbCBmcm9tIHJlbW90ZSBjbGllbnQgYnV0DQo+
ID4gPiBNQUMgd2lsbCBlbnRlciBzdXNwZW5kIG1vZGUuDQo+ID4gPg0KPiA+ID4gV2hlbiB0aGUg
TUFDIHJlc3VtZXMgZnJvbSBzdXNwZW5kLCBwaHlsaW5rX3Jlc3VtZSgpIHdpbGwgY2FsbA0KPiA+
ID4gcGh5bGlua19zdGFydCgpIHRvIHN0YXJ0IHRoZSBwaHlsaW5rIGluc3RhbmNlIHdoaWNoIHdp
bGwgdHJpZ2dlciB0aGUNCj4gPiA+IHBoeWxpbmsgbWFjaGluZSB0byBpbnZva2UgdGhlIG1hY19s
aW5rX3VwIGNhbGxiYWNrIGZ1bmN0aW9uLiBUaGUNCj4gPiA+IHN0bW1hY19tYWNfbGlua191cCgp
IHdpbGwgY29uZmlndXJlIHRoZSBNQUNfQ1RSTF9SRUcgYmFzZWQgb24gdGhlDQo+ID4gPiBjdXJy
ZW50IGxpbmsgc3RhdGUuIFRoZW4gdGhlIHN0bW1hY19od19zZXR1cCgpIHdpbGwgYmUgY2FsbGVk
IHRvIGNvbmZpZ3VyZQ0KPiB0aGUgTUFDLg0KPiA+ID4NCj4gPiA+IFRoaXMgc2VxdWVuY2UgbWln
aHQgY2F1c2UgbWlzbWF0Y2ggb2YgdGhlIGxpbmsgc3RhdGUgYmV0d2VlbiBNQUMgYW5kDQo+ID4g
PiBwaHlsaW5rLiBUaGlzIHBhdGNoIG1vdmVzIHRoZSBwaHlsaW5rX3Jlc3VtZSgpIGFmdGVyDQo+
ID4gPiBzdG1hbWNfaHdfc2V0dXAoKSB0byBlbnN1cmUgdGhlIE1BQyBpcyBpbml0aWFsaXplZCBi
ZWZvcmUgcGh5bGluayBpcyBiZWluZw0KPiBjb25maWd1cmVkLg0KPiA+DQo+ID4gSXNuJ3QgdGhp
cyBnb2luZyB0byBjYXVzZSBwcm9ibGVtcz8NCj4gPg0KPiA+IHN0bWFtY19od19zZXR1cCgpIGNh
bGxzIHN0bW1hY19pbml0X2RtYV9lbmdpbmUoKSwgd2hpY2ggdGhlbiBjYWxscw0KPiA+IHN0bW1h
Y19yZXNldCgpIC0gYW5kIHN0bW1hY19yZXNldCgpIGNhbiBmYWlsIGlmIHRoZSBQSFkgY2xvY2sg
aXNuJ3QNCj4gPiBydW5uaW5nLCB3aGljaCBpcyB3aHkgcGh5bGlua19yZXN1bWUoKSBnZXRzIGNh
bGxlZCBiZWZvcmUgdGhpcy4NCj4gDQo+IEBHYW4gWWkgRmFuZzogYXQgdmVyeSBsZWFzdCB3ZSBu
ZWVkIGEgc29saWQgZXhwbGFuYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+IHdoeSB0aGlz
IGNoYW5nZSBkb24ndCBjYXVzZSB0aGUgYWJvdmUgcHJvYmxlbXMuDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBQYW9sbw0KPiANCg0K
