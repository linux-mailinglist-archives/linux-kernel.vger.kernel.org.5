Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC4C7FFBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376581AbjK3UGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3UGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:06:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21010D1;
        Thu, 30 Nov 2023 12:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701374807; x=1732910807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yGVlivjdIQ9ZmY8l3s4d6eHPbjBvx+MTRBO5CX+MUdA=;
  b=nFzue8W8sniW4OA2qDA/spRZrLrghJa/CtR/gOqyZztrqpkdLj9i07rc
   vTdQgn9UmydJs1yNULUyd9AoA1AodFqLDOJHKD4uhD3OpiGnsmJm7eCvF
   NFYz5+PYRjZ65yl0NY/vJ7XUYmmgEWnQA7NsCSs5WWW8pcINTBPoWE80s
   Itc8sIpdN3LLzWpxPv7RtKdtrNGOeE+1b0JFKStO4t6dcxaYfynlOuptv
   jcuTv4fb1fXnbqbK/1mKskW9DA14F96+cgYU450TU2xn71ZTVWaFc/PmR
   5D3SEasMh2+DHlErR9xr7TraRuXVWDM9PLi9EdQv7Rgrqgk5FpPAFH02N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="270021"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="270021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 12:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798431594"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="798431594"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 12:06:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 12:06:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 12:04:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 12:04:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 12:03:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvxbbNiECbS2Etx+qFmrTCF/F2uJtcMnAKi9AP8S4rWLbVXQ9LMztXLOUHXegaSCLPCtY2u+O+69IIkes7e7Al8WtL14QJwzUtFcaZV0s+E/YR2vQhBau0J4uMu4f7JWQ0f0MR+KbevJxR2IRRvHrNpztUGWquPawIfA/w3i71JWarM0RalJArJFjlNuBmmC5ErZNhdX+WTw/yOaQFz+sGoDPnMT6iuG4hgBwLk2qbcPRv7IFIQTTcKVHsYeStW+nSTQxCXjaXdFNd0mtMuLE8PV8khraa1tT3emNgX3sFfgz5N8znZZw0lfmBO4wTrglZ6B8SYMehG7l9P3PzidNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGVlivjdIQ9ZmY8l3s4d6eHPbjBvx+MTRBO5CX+MUdA=;
 b=NocDBJKeqj8DS3LSIjbJwT53NVLeWe6IQIyWsR/9fKVSDCJEtjSzR1wp+N+bxhcGGlcIgRrPp9Xp/B5ES3J672RuZfRhLz54dty5shbxD2+Py+E1Ro3lxvfVBUrqZGOKIFH4YJT7OMYmJQaFm4s/ZHcl1XOeUtUEzaBk3tL7JxJBLGkgXh9a/BPFja5JF9QajAooMVSTgRP1g7RcjLXjSc1UPoYFk+auRamN3u7V6dQP3muCv+M4oesuEODIObxDGyOQtNpOGACly6XGZxDxF9HF3Egm2C6DTsZ2AcPzXXigylkAsPaZuolCNpqPSmggYqAnhLsiXOwB+sat49vbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 20:03:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 20:03:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Avadhut Naik <avadnaik@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>
Subject: RE: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Thread-Topic: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Thread-Index: AQHaEO3NFJz87tXJiECUva1Bzfb8M7CRwg8AgAGLX/yAAB6kcA==
Date:   Thu, 30 Nov 2023 20:03:32 +0000
Message-ID: <SJ1PR11MB60839D04A329087D11933B6CFC82A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
 <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
 <ZWeId332wmrdLycH@agluck-desk3>
 <fbfe27c0-1635-434f-a1ab-71a10c9d6f38@amd.com>
In-Reply-To: <fbfe27c0-1635-434f-a1ab-71a10c9d6f38@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8315:EE_
x-ms-office365-filtering-correlation-id: c157276a-3961-4f94-7d01-08dbf1df6dac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPf2+XnGLA69aWdFgpk3ELxbvB4p7igXfIt14TEmSZ7QruQZ+/IOiaAE6+iIpkk4wg0m3A1X4ScOdeGcpfUp44n2CSifcS2G8KkpzpkT79LTzS3Gt676A4AuQvVJPh9VMUHunJ3GPjYhgkJ0yuAN+sjNy0gx5a2AniUdsNkVVIauAuuMHaT89jT3mSIwEMGHDuYjJhCXjX0aiklybxZYDG1W2g4BTAFd5lIgkNh9lGA80Bh8OLBCys+y8FBp+F2IZU1a/xVtXH4ST/Hs5Qpv9m7Vn5HuD5Hf32DP5qU+7WkBl2NtHxdQectso5035vcWBOg18rZ2ril6ljJpBpLIXgQDx4wblXI7hmwE+vBzYqEAbFCNBj4fdpI8exr4g/lyt+uG4kRWQnqW8LNo1CcKnCOyoGj/jtjJDNJbDbRY/SiYi5vcA7IP73s4GKTyudDmUyzjYOTiw03djEPVb2cAt451oOgLt2mWuUsKpSTgbNglgfMKOSGe9TC3M9uB5oLohDiyhQpJbTiP+qetsEuEETV9FsBQw4DUHGUwLmd42OwAn5ISE7807uk5a/0XaL+u/v0bv/jGGK2+pw8cFcQX7HycnFghhXJf48xC6GT6By4OGFybrBPKXoQ7gxmiieJP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(86362001)(66946007)(76116006)(66476007)(54906003)(66446008)(6916009)(71200400001)(64756008)(82960400001)(33656002)(38100700002)(122000001)(83380400001)(26005)(6506007)(9686003)(7696005)(2906002)(316002)(66556008)(8676002)(5660300002)(478600001)(4326008)(52536014)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2MzZ3ptcWNhbHF4TUl6VVJpUnc4OUwrUy9LN3J6cGM4eDZyUHQ2cWt5NEd0?=
 =?utf-8?B?TWFkTmhjdGpoblByUGRFbXZ1NVQzaklucmdRL3hHZDlGN25TVVpqQmo5MXNq?=
 =?utf-8?B?MG5wM25vaFNuWmNVYXlWVW1HcHVVRDRLc0RtSkJNUE9DSlZVcWVISko4dklP?=
 =?utf-8?B?WWJ5aEZ0L1ZyQUpaMzYrcVRsRlNmRUlnUk1wVnM5UlVrTkErRmZYRHZqMmVQ?=
 =?utf-8?B?dENDNVlPN0RLb3ZDd0ZaaWdOdmZ1UXl4bW1PQ2NBMzlUdlFVWE9sbHUxUDJQ?=
 =?utf-8?B?alhvQXNES3pDRzJ5MjhOOUpza0pMQ3ZPa2ZhTWhQRy9Rd3hGNWFBSk5PWlhK?=
 =?utf-8?B?SkpNQlYwdHlpMjB6THhsbEhsSy83ZWZVTjR1eW9PRUhMakc3Mjlta25jWCtU?=
 =?utf-8?B?YTMzRjZ5YXNPbEpGejlEd2s3eFRsRU1BMk1UdEhRQllKcFhyZ0hQUkRGWkZF?=
 =?utf-8?B?dFFJZ0FCam13MFBNUjExOXFXR3lIeWVVd0ZDTlR6REhEbEdNL1paQkxTV05j?=
 =?utf-8?B?SVZpU0tHa2t6UXRtTHFBUHU4VFJHQmVMbHVqblArRjRuSGt1Y0pyeldNZi9T?=
 =?utf-8?B?L2hQNmJUMFNUY293VS9xcnFOZ1I3dkVNM2RXSEY0VkVoZ3lsQ1o0MlBOdk50?=
 =?utf-8?B?MWZDdXhTUTNMVkdHMDlDZnRZSXl6UTJlV1RXSTFLbHNITWlkTURqc21hYi9N?=
 =?utf-8?B?RHFLNy9UaVRubjZuTk43NGY3UU9RLzJPZ0hNSkpHM2g5Q25IRDVkZWNJNDJZ?=
 =?utf-8?B?Sm1jQzR1eExLWFF5MG83K2VKOCtDN0pkMms2YXNSNWtmZGp4UTh6YThFek5i?=
 =?utf-8?B?SmZlUkNpZkdnU09UN09iUFVpWlRsMUNlU29YUGNpM2JXTkFsSkhqZGUvS3k3?=
 =?utf-8?B?bE1ZVUJ4ZlpvMUVzeDFoUUZXWUlmckV4eHJ2K3RjR0I0Y1pVWXpLYjRkWnZO?=
 =?utf-8?B?d01zRDhRRUJwVHZPSTNhQ09yUzZkbU5xcTJuQ2h3d1M2b0pSUkFqRDdhVUgy?=
 =?utf-8?B?R0tWKzgyWXVObzJ4MnpoSXdOc0xQVXZveEFKNDFtK281QmY4Z0lEVTkrKyt0?=
 =?utf-8?B?ZHV2ZFJMY3JSZGFKSXdWMHpNeEV2VU9pU3Y5Q2J2c2RqN0dJWHFrMDlOQ3hs?=
 =?utf-8?B?T3NsN0dZMWUrU0p6QnliTzFPZkVCaTQ4cFQzajdMTzQrQTBRZ2plRDg4TDcr?=
 =?utf-8?B?b0syNE5KdEtKczU5MklJZG5ZdG81NkRjSHVOc1hsSWY1M0lYQmdEV3RaU1Bi?=
 =?utf-8?B?aUpuWU1QSlZBZnFyajZpY3ZzNnRIUFFUeEhXSWNiSit5VkorOXFveGJYMitN?=
 =?utf-8?B?WlliZUJJN0h1VmNud0U5MEswZm5rdHZic3M1NUJzMlFZUkVFVXRFak0vNURq?=
 =?utf-8?B?dHdxaEhJcVBGcTVVN1RZd1kyWkVtZFVZZHdxRkVWSkNLMVB2ZzJOblZuZ3F6?=
 =?utf-8?B?eHVHYmJSNS8yMUl1WVJybG9DaDdndFM3VWJTVC96amNiSkhhSDhkaC9aeTBZ?=
 =?utf-8?B?ejhvS1RUY05EWWFRd0lobWVZKzNRU29XS1I4aTRadlZPdFZzSnJES0tZd0lk?=
 =?utf-8?B?cVpqODVHT1dCUVlEd1JzSVVyTURoSS9FdUlyUWVmTmZXTkJhb2szS0pVd3Rx?=
 =?utf-8?B?L0thYzh4MldCNzJKeGxMcTZUYkMyZU1lZzdzSVd1QStCQ1NhM0FhVFhMcWEx?=
 =?utf-8?B?VlBjd1p4dzhNa2xPU0wxSng5bVBtMktrSU84N2RhNUdkNWNtM25HWnhGeWpw?=
 =?utf-8?B?V2Y5a1c5WDRoQ3lnZStQVjJnODlKWk84U1lIeWtSdWVHRWoyeUZ6eVV4TzEw?=
 =?utf-8?B?UnQvb0pSTFdSMFV3WlBjY1JQcnZ3U2NDYy9OVFErbWVQdUtmWkFWQ2sxZHZP?=
 =?utf-8?B?U0tCbVVZUGRTbFcwaUZaV0NFd1lFOEVYdEZBbGMrU0FEOTNPaG5meVMyTENr?=
 =?utf-8?B?cmM4WWlpY2ZiVTE4a0VmcWpoODNXdk9xdnkwL2I4b0VFc0tEUmR2VWxzMWJC?=
 =?utf-8?B?Z25aM2cvSTNXbEg3NG5JMWZGb2F1R0xLdFlxQ2F1QmdNUDBJTW05QVk3L3Zh?=
 =?utf-8?B?U0daOVc3ejQ1Vno3Z3VSeHhqbUVwTW1GWGJuSVFZcDlMVkp6Z2FnMG8yb3Fa?=
 =?utf-8?Q?FB1nBLb3f4XXKspElWWHoLdiF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c157276a-3961-4f94-7d01-08dbf1df6dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 20:03:32.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28yqKaQxYs1ZI08zvvzKWHrw4qoJS0Z9Bvt17btoTXbeU6UwiUKp116d5QbJN+tostFXMp60ABxyhQyhGtuw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
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

PiBBY3R1YWxseSwgY2FjaGluZyBvZiB2YWx1ZXMgZnJvbSBhbiBlYXJsaWVyIHN0cnVjdHVyZSB0
byBiZSBjb21wYXJlZCBhZ2FpbnN0IHZhbHVlcw0KPiBpbiBhIGxhdGVyIHN0cnVjdHVyZSBpcyB3
aGF0IHdlIGludGVuZCB0byBkbyBoZXJlIGkuZS4gY29tcGFyaW5nIGNhY2hlZCBzb3VyY2VfaWQN
Cj4gZnJvbSBhbiBlYXJsaWVyIHN0cnVjdHVyZSB3aXRoIHJlbGF0ZWRfc291cmNlX2lkIGluIGEg
bGF0ZXIgc3RydWN0dXJlLiBUbyBoaW50DQo+IHRvd2FyZHMgdGhlIHNhbWUsIEkgaGFkIGFkZGVk
IHRoZSBiZWxvdyBjb21tZW50IG9uIHRvcCBvZiB0aGUgc3RhdGljIHN0cnVjdHVyZSdzDQo+IGRl
Y2xhcmF0aW9uOg0KPg0KPiA+Pj4gKyAqIFNpbmNlIEdIRVNfQVNTSVNUIGlzIG5vdCBzdXBwb3J0
ZWQsIHNraXAgaW5pdGlhbGl6YXRpb24NCj4gPj4+ICsgKiBvZiBHSEVTX0FTU0lTVCBzdHJ1Y3R1
cmVzIGZvciBNQ0EuDQo+ID4+PiArICogRHVyaW5nIEhFU1QgcGFyc2luZywgZGV0ZWN0ZWQgTUNB
IGVycm9yIHNvdXJjZXMgYXJlIGNhY2hlZC4NCj4gPj4+ICsgKiBGbGFncyBhbmQgU291cmNlIElk
IGZpZWxkcyBmcm9tIHRoZXNlIGNhY2hlZCB2YWx1ZXMgYXJlDQo+ID4+PiArICogdGhlbiByZWZl
cnJlZCB0byBkZXRlcm1pbmUgaWYgdGhlIGVuY291bnRlcmVkIEdIRVNfQVNTSVNUDQo+ID4+PiAr
ICogc3RydWN0dXJlIHNob3VsZCBiZSBpbml0aWFsaXplZC4NCj4gPj4+ICsgKi8NCj4NCj4gSXMg
dGhpcyBub3QgZ29vZCBlbm91Z2g/IFNob3VsZCBJIG1ha2UgaXQgbW9yZSBleHBsaWNpdD8NCg0K
SSB1bmRlcnN0YW5kIG5vdywgYnV0IG1pc3NlZCB0aGF0IHRoZSBjYWNoaW5nIGFuZCB1c2UgYXJl
IGFjcm9zcw0KZGlmZmVyZW50IGVudHJpZXMgaW4gdGhlIEhFU1QgdGFibGUuDQoNCk1heWJlIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQoNCiAqIFNpbmNlIEdIRVNfQVNTSVNUIGlzIG5vdCBzdXBwb3J0
ZWQsIHNraXAgaW5pdGlhbGl6YXRpb24gb2YgR0hFU19BU1NJU1QNCiAqIHN0cnVjdHVyZXMgZm9y
IE1DQS4gIER1cmluZyBIRVNUIHBhcnNpbmcsIGRldGVjdGVkIE1DQSBlcnJvciBzb3VyY2VzDQog
KiBhcmUgY2FjaGVkIGZyb20gZWFybHkgdGFibGUgZW50cmllcyBzbyB0aGF0IEZsYWdzIGFuZCBT
b3VyY2UgSWQNCiAqIGZpZWxkcyBmcm9tIHRoZXNlIGNhY2hlZCB2YWx1ZXMgYXJlIHRoZW4gcmVm
ZXJyZWQgdG8gaW4gbGF0ZXIgdGFibGUNCiAqIGVudHJpZXMgdG8gZGV0ZXJtaW5lIGlmIHRoZSBl
bmNvdW50ZXJlZCBHSEVTX0FTU0lTVCBzdHJ1Y3R1cmUgc2hvdWxkDQogKiBiZSBpbml0aWFsaXpl
ZC4NCg0KLVRvbnkNCg==
