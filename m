Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A677AF43D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIZTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIZTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:40:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F8180;
        Tue, 26 Sep 2023 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695757215; x=1727293215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=piE6fSp5troNNCIcBKaiX2QgS7VsYNtQQvisUga3TYU=;
  b=VSkLP2gcstwkgK9iMuqpD5Qx9QVqIse0vMxovGqzBAvq0jj8CiPobcdA
   aVBn8wjaozTl/BUwd0e/UfqQDX+x3FtmPogpfhW+oT/AFT4XJusBgCH2x
   yF3R+lCrRkYPgHnfIzN8jW5CoR0DoKt4E2eoUcCEHkBpTWclb52RI26vp
   Bf4XbWZq2ZWa+GJn7eS2ZTvCstHUciEXbedr6x42+KAKpShJSeWEEKgaF
   Lbo2w+Z9vOhkoLMqSsoPCiaOYGGFPujWwgptQ+HQ1hbBA7CgFlEL6t2G3
   KwzA0Gl3JXYjVemTRSnmlPtmeHar99fABk7hcx0EVfs2uvx0fSDctKPUE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381552868"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381552868"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922547089"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="922547089"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 12:40:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:40:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 12:40:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 12:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfhN8gchrDxDN7V7JIhDeIPoiTMeFCbrIRqwLupVidK/gr8hL/WfZ7Z97DtmmD7qjGEBI3QCJ4tMaK3XYkt46NFTE5+/DZv50GlAb5ku2mlluzh0D+HWVUKm9QiaPJHC2m76Rm9/dEcrI0so9++82zQLAySjY/Ce5lFOiIdbG7IUD8az+ZjZmu5iScAeF5mQXs+8OGAK7z5eO6xmdBnCqyo4oMq2O4OTPohDjgufVGwsxZOJTtA/+vy6ERB81xz/yBfbHp2ucx/wETmii7fXv+z/60YymUdMpi78bZ3C37tlB0eALUSP92f5mpFxhmjUuaemdxnF+YfKoy0QQzLxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piE6fSp5troNNCIcBKaiX2QgS7VsYNtQQvisUga3TYU=;
 b=kL++3dshWvgWW8hH3poHy3rsCNlSiXWAvvl0+vlKbwGfmiZCMiqsgOXb6BNN9u+E4umOC2QIs10pv83OkmFJ4N9vq7HphCF/Gi+5Mv5Yx4E4Gzpow2xshN4wnDufVhxQOzQK/3yVL1gmCKyJCP0typ2+sxxnQJk+5C4jJ6oAqeXeknccWI+fBPmCDdYovEh20SSWaFG7cC6mjKDekmI17jAdj59UKUCp0a6PdlzJ1JDdDAHvxW61RpC0MncDpZ6HMx+/wIVdCrZY6EJZB47Ca+Tl53NpQ+RyDDv4wKOizTb0x2GUhWd9hjD0LfIfBLu5MUdOFZXbqjxbpPcGKCkVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 19:40:09 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 19:40:09 +0000
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
Subject: RE: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Thread-Topic: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Thread-Index: AQHZ2tLOJWAT87qOwU+0c8WAv0aGYrAtpjsAgAAEVzA=
Date:   Tue, 26 Sep 2023 19:40:08 +0000
Message-ID: <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
In-Reply-To: <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5440:EE_
x-ms-office365-filtering-correlation-id: 53bb6ccb-9a01-4e2e-f0e9-08dbbec86464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDBL7USDlkwYsCfRMhnlpeOTCO7bsMpKMWJuFvSV/LoDOGzz9aZiYg2MkqbZwwdP6+IeYCnlWeqwirLUVOqt6XoIdO/ZX6bLUo6EBSPxOtDXgvrPmRuFTcP2/Goti1Gr4hz/vsvmbwvEk7S4GQSgHVU/DINChB6//PtmeNU4l+FeiKTFIiREtUZNhM4YQFsATNq2CB1xZzNBr36GfyTVt9YhhVu+jOahR/OpKFFlE3BLh0Kcc1uBuTef0Eg+kjJZGSLXvBlZc2dGnngwhY9m9M+SuFNb9wG8kQy6PVm2QA0GF/5wMp+hK46JOWbOYFY9lUVLevBod0XgihnMZ4A1PBgM1Sc0f45tulDu+4J8DScyJu1Xi2gz44RPrt1Ll1j+plS+UuO4GBh8UfhVn+wwbiDsKsMY6C9CqRn62oR87fByxxCJ75FEk2A6zaymCMMSPu43zRyeXRaYQrPy0aiQzjHNwUcD5Jo/QmK8kS0OdC+w9idWfPwV7B+bNMua/0n2tceSDQGj4nwkbY4utm8gLr35arvLoCfu8T/FAr/aqTf/R8FxTZ6FLf3eIEH3eKnVffct3KVYnc4th9HfpBCc1WJ5nWViI390QuZ2Gl9EWDtfQ49QcFoWzrm6VQNba9hp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(4744005)(2906002)(7416002)(5660300002)(8936002)(8676002)(4326008)(110136005)(52536014)(41300700001)(66946007)(76116006)(478600001)(71200400001)(9686003)(6506007)(7696005)(26005)(66476007)(66446008)(316002)(64756008)(54906003)(66556008)(122000001)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWxtZXZZVDAyaWxNcjNrbm5PZUlCREl6UGQrNVBvUU5PdDE4WVAxMjk5SlhI?=
 =?utf-8?B?SWtYcUg5bDVjTUlqaUpsbGRPaVVMaUJvS1ZXSStDdUpTMkxmOTJmc3I2OW82?=
 =?utf-8?B?ZHNPUlM3LzUwdU1PMmx3SnRqZVFhdDBuaTljZ0xoc2FqeGp1TXF4M3VYNFhv?=
 =?utf-8?B?MVUxVFJESFFuellvb2YvT2p6eGNLNDh0cFpwQXBtSWlZTUJPQUltWmZOa2hP?=
 =?utf-8?B?QVFUZ2paODkzTXlyUFBxSFVRZHE5MkdhaXNoempMQzJlaU4ram8rZHdDUC91?=
 =?utf-8?B?dFdJUzJSMTBoSFVtSVBUaHprOE4zd2lNM1hYdituRGR0eGpkMnBaRjdDb2JU?=
 =?utf-8?B?NE92QUtiR1B2ZnQ0NE9oL2Q4VDBWcHVXdVUzNnBxcUtVLzIyODd4bTNFOXBu?=
 =?utf-8?B?MFlIbmlrZzZqZENoNjFSSGk0M2pTSm1LWkxvWW9Zb0JzZG1mbm5DVDNmZU5S?=
 =?utf-8?B?dzNVL3ZFTlZKdEhNQllreXhkQ1JLeXlodXJ4Z3BNaXo1WCszQW1mbWprSGky?=
 =?utf-8?B?Y2pYNWFwUkg3WW5MYXZNZ1V1MzNWRy9DZGhtRHdkeW9xM0pCR05zd1o2Rmg2?=
 =?utf-8?B?TS9Temp4SmhWb1J3Rnp6UkFXSENtQkV4aUUxTGg2cTFYRlZrTlJaaGJzaVNy?=
 =?utf-8?B?SEpiQi9KY0QyVEpxVXdyL0VXS0gvSmIzWHZLVnlYTmhOeUUvU0luVEFyS09p?=
 =?utf-8?B?WHRDQ1NjNmVyZlBEanhaeXFXVkxXUnF0ZExDMmgySkhtTjJNWTRFa2Z0RkJM?=
 =?utf-8?B?WVFSSkNlTytBdFlxZXN0bDdyMndLazlRTTVSOVdPRTM4Y00xRitJckR5VmpJ?=
 =?utf-8?B?TUw2Uk5tVkdEK1JWbkV4a0ZXL3VNckdpa1RGd3FlL0dIYVNyVG95ZjNSTU1q?=
 =?utf-8?B?Mm9BNHdQQ052aWNUbHFQaXc1WEdGOGQ1d0U1YUw2YVNkV044ZDREY2FKbVhV?=
 =?utf-8?B?T2g4aEloRDRFc0pCdHdHRWtKN3pqRmluc3JjcnI4MXVwTjhTL2Q1N1FVU2w5?=
 =?utf-8?B?cjNSTS9vZzdNSU11MFUraW1ScThGR1ZZT1pZR1dqUVYxUmFEd2JHNExPTnBn?=
 =?utf-8?B?TEpqb2ZROHZXd3M0NnJpb1NMakZrSEd6alB5bnE0RTlyckFuK2FXaDFsbTRQ?=
 =?utf-8?B?WWZINGJqM0NvQkFNczdYblEvR3RZU2RTUmk4akJlYzZPRFBuVlUvZ3Z4VWYy?=
 =?utf-8?B?Q0ZTdHlRM1pTb2FaTlBzN1hlY1EvZHRYWmhhc2RlUEhNdG8zNTZoL3dQQStS?=
 =?utf-8?B?SWJDbHEwOSszYWs1SlhlVzhxWXpPRkFCM3ZIQUZ5N1ZiV1ZVR0k1cVEvVFhC?=
 =?utf-8?B?MFlKdGxEOStLVGJuRWgrcy94MTNTMVhaU2RXeGpIbVVPT3g3RXpvYThWaFB5?=
 =?utf-8?B?Q1Fzem0vSWcrLzI5dGZldmkzejFyZzBsdzgwUkVhU2VrcWhGeDJ3Y2FKMGhj?=
 =?utf-8?B?RFpDZ2M4Q2FVTjRDTm56Rkp3OW9ndUdscnNxRlNnVFppeldFL2pxOG1pVi9Z?=
 =?utf-8?B?WFZYNGZ4TVJFSjQ4SVBNR2JpV2thSm4vTnZ2UkExWUdNU2kwQm5pZ0lYOHZ4?=
 =?utf-8?B?S01HNkpGVCtKY3Y3TlI1RWk4aHZMV1ZSSnZPSVZYLzFoc0orZzlCMldvUFpM?=
 =?utf-8?B?aXNTTEdnOEZPdWZPQnpORHZ2Y1ZrWXFneTJMcEozbTUwS21aZzlnbFIraVhr?=
 =?utf-8?B?RWt6SXZUVmJJRHFucUMwK1V4bXIwbkdFb2dvMWFhekRwQnB2SjRDV2dmN0VP?=
 =?utf-8?B?cVk2UWlwNUhPYVV4QWtyTmNpd1VOaVZPdjAxdGh6SjJEL1c3S0dmaFRPZXR0?=
 =?utf-8?B?VHYzUW1wT1BxQUIvaHkrMWpFNk05akdSNkFqTjl0bEFkNHRzSnVXaElMKzNl?=
 =?utf-8?B?S0RFSXY1OHQ4Q2lycjduOGNVdUpCek1WM0oxZjdoMGpWK0FEay9kalhsNVR4?=
 =?utf-8?B?NGtJOG11N2NyeHUrREh0YzM5b0FpcjYrdW4vYU9QYlBaemdTYmlXSlRNamF6?=
 =?utf-8?B?RXJ2UU1CZUEwOEpxYU5qN0dOQWdVWDA0V2hiVTU0bUIycC9mVjFoSlV6a0gr?=
 =?utf-8?B?YjdmeEY5YXZVMXVRdWJPK1AwSkt4WWowaXZFY3FBdDdNVGpXMmRqbEhoTmtT?=
 =?utf-8?Q?60hGi+qGR99eNxLXQDSSavv4s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bb6ccb-9a01-4e2e-f0e9-08dbbec86464
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 19:40:08.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAHGDAc5/RN+iRmLVngl5wyFxvKua6xuY1SBGSvmd970LaPEOvpLQFjEsk9QfO188epHMy/8EdN6+pAsGMmSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4NCj4gSSBkaWRuJ3Qgc2Vl
IHRoZSBuZWVkIGZvciB0aGlzIGluY2x1ZGUuDQoNCnN0cnVjdCB4ODZfY3B1X2lkIGlzIGRlZmlu
ZWQgaW4gdGhpcyAjaW5jbHVkZSBmaWxlLg0KDQo+PiArc3RhdGljIHZvaWQgc25jX3JlbWFwX3Jt
aWRzKGludCBjcHUpDQo+DQo+IFdoaWxlIGFkZGluZyB0aGUgbmV3IGZ1bmN0aW9ucywgaSBzZWUg
dGhhdCBuZXcgZnVuY3Rpb24gbmFtZXMgc3RhcnQgd2l0aA0KPiByZXNjdHJsXyBwcmVmaXguICBI
b3dldmVyLCB3ZSBhcmUgYWxsIG5vdCB2ZXJ5IGNvbnNpc3RlbnQuIENhbiB5cHUgcmVuYW1lDQo+
IHRoaXMgZnVuY3Rpb24gdG8gcmVzY3RybF9zbmNfcmVtYXBfcm1pZHM/DQoNCkkgdHJ5IHRvIHB1
dCBhIHN1YnN5c3RlbSBwcmVmaXggb24gYW55IGdsb2JhbCBzeW1ib2xzIHRvIGF2b2lkIHJhbmRv
bQ0KY29uZmxpY3RzIGluIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwuIEJ1dCBJJ20gbGVzcyBz
dXJlIG9mIHRoZSB2YWx1ZSBmb3INCnN0YXRpYyBmdW5jdGlvbnMgYW5kIHZhcmlhYmxlcyB0aGF0
IGFyZSBvbmx5IHZpc2libGUgaW5zaWRlIGEgc2luZ2xlICIuYyINCmZpbGUuDQoNCklmIGl0IG11
c3QgaGF2ZSBhIHByZWZpeCwgc2hvdWxkIGl0IGJlICJpbnRlbF8iIHJhdGhlciB0aGFuICJyZXNj
dHJsXyIgdG8NCmluZGljYXRlIHRoYXQgaXQgaXMgYW4gSW50ZWwgc3BlY2lmaWMgZnVuY3Rpb24/
DQoNCg0KPj4gK3N0YXRpYyBfX2luaXQgaW50IGdldF9zbmNfY29uZmlnKHZvaWQpDQo+DQo+IFNh
bWUgY29tbWVudCBhcyBhYm92ZS4NCg0KU2FtZSBhbnN3ZXIuDQoNCg0KUmVpbmV0dGU6IEFueSBv
cGluaW9ucyBvbiB0aGVzZT8NCg0KLVRvbnkNCg==
