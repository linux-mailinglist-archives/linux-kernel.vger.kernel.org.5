Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB7760DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGYIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjGYIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:52:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABA2107
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690275094; x=1721811094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ss4Zlqk+z63IVAkFQfbjsh6SSkCJidAh5yj/n571Kfk=;
  b=D5xpRBlJDDrZ85ByZg5W1u/Wy8dCEHeFB/TWfrntsk6A524B2c9BiQn7
   hKBN89ca27AJZIiygvFEinqeIaBIAZ2hVKQCWyorwEsjB5b7bRMDciKbq
   t+ZD2qmP4hZwlpk3T4AiQEIIwn92UvTBiJTuRJP4YxUxHUxfdqXPIT7MS
   5Y6fHI6bupXgpYEWxX9MhECO+CPArc+UQLIqHGL7jmnfOUehSZC++xWuS
   TEwOKoMf5AyXIYC+oT4bq8IKCFWeEdTbTgDeiH+7ZICjxyDxvPt3KHogy
   MtuMMDfD5/EI/B1ACILiIhNebRZIiW0Rs6BAi4c0F1rWQTd+WNJQ9BmFn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370329261"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="370329261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="726029830"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="726029830"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2023 01:51:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 01:51:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 01:51:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 01:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aagEOwcpPhUOK1a8nBZ5POnAuDYHemuJ59hgelcebyCmpJ22C9GM97nxws5boalP0m2Dm6BByNCylltLqQ2XkK8MsbIUkmsd5r6BbG2MnRRrpoQVwLm/2VTcA10qc4j3mMAQlktngaxRnnWzMmQpNRSjrXNRyBSxRX4MN53nS2VM6Uu+RRFLdL7tDl32cqA9WcbJujvyLzLUIJotkQAIGDMBMAkCaRHifmzpHS16uxW7BTPv56XlemVEzOGNhaKEpoLOVWMTkhLOyry2haRal5OtbSu4PKAAeBSc47FtXu8Ntoq6h/ENUiqx3eE4h9HsAA3bl8NycSIRTF0sgtfcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss4Zlqk+z63IVAkFQfbjsh6SSkCJidAh5yj/n571Kfk=;
 b=cWradmBTGYzU2fEx1UB6OzzhN7sDLfo/KkbyqYwFgbVUIRzA2nPoJgeP3iKdCy9IJZUUzv+ATgPn1q2CIq48HFLe88G8LWhDw0Unt+Tdo5ODYzO0qQ4IaQqjUbmK8RO+S+x28LRyq/kL4Nb43O8rYWHGYB7ctNimeucJBDfM1ESsfax0nVRLnkOsZpwoJkxJDqje+HCLcEqE+in84tEwbqIKG0PdeGbnWCqP0urC+E0/KT6pHDAp+E4AFs2Yhmi/JmjE39z4DdH6fC1RpX3Jt4NWZ+dRNzBVfin1frM2+zhVhCPz0IXwVHr2mGcIHrcHwD/g6D0lCkp3o4jPeRabOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:51:29 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:51:29 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bacrau, Radu" <radu.bacrau@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>
Subject: RE: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
Thread-Topic: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
Thread-Index: AQHZuFE64Sg6wNtFyECl2C38OIxlC6/DhukQgAWB5ACAAS6pcA==
Date:   Tue, 25 Jul 2023 08:51:29 +0000
Message-ID: <PH0PR11MB5673CF14F1D6838829D00AF0CB03A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <cover.1689524302.git.kah.jing.lee@intel.com>
 <e640da0517b1d0de79013fdf4964ea34475f2238.1689524302.git.kah.jing.lee@intel.com>
 <PH0PR11MB56738D1373C7B2FEA7D947A9CB3FA@PH0PR11MB5673.namprd11.prod.outlook.com>
 <4faac72e-3ab8-6a07-dad0-7be8840da7c4@kernel.org>
In-Reply-To: <4faac72e-3ab8-6a07-dad0-7be8840da7c4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|CO1PR11MB4769:EE_
x-ms-office365-filtering-correlation-id: 75a920a5-4fd9-44c1-e819-08db8cec5670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EdAAv43BXQ3JDGCed5fkAT9z68+RfkzqNgpQ5cB5NY2ziEGJN5agmo4gDEjiNiG3dOFzSMU5mKXFBwr/iin3aYUVJY0NsKCooBY0MxXUw0R1UWUF2uY74yy6HVf2dfjlRBarcqSG2fHEaulEqyb2xwCsJPXyy8dQXNt/FzC7mFcchE1AUAKzoTgYA+YfZmeImUQ0dIk8PL30JjUn+7qs/EnSTsG5SCJVdmPwu46NZjcDH9OCBiw27Sf54DO13KTR9402aA68CjhXTOPUZ+/JBtKaJTaDwYOjN+CCQLo/XZ1WiS86Hpp03P4bedyxRqGZpNzKrZYDjasPmUZGEFI29aQXZNsOknK4dKXKS4Q069alhl2WTWVeqP1Jg17Ki9mbHYvIWEEgQSjE4DhH68pQoBvgIDJSx/x0yAgqB14jFo4czYQNeRijNLno5l6z3MmgzcLctJ7nb/NbjHo8O4HKNbQ/MKbNNIsmorU5nGxNgWLmuyxrFaqtJAtn9QB6Tt0wXqMg4hPnSAftGF6NyALLBCfT2vX6jZJNZM/hs2vFyDeBRmjbnF74H/LP61e7HtijKr33RxtjXLUqYwHL3dLosb2n4TP2TLJlkU1lq0J9J9DNEH/wnlkzixEHS4pXx5R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(71200400001)(26005)(186003)(2906002)(55016003)(38070700005)(54906003)(82960400001)(8676002)(33656002)(8936002)(478600001)(9686003)(66476007)(7696005)(64756008)(107886003)(122000001)(6506007)(38100700002)(6916009)(41300700001)(5660300002)(66556008)(4326008)(316002)(66446008)(76116006)(66946007)(52536014)(83380400001)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEZtN1JuakN1VCtXT3JKczVCY29NMW40dENwNjNtTzNrV2FNQmVnY2VaOTJt?=
 =?utf-8?B?L0YyaFd1NFRab3BRSCtIeHdtWW8rTnlBdm85ZG0vODVlZXg0NXdjQ3FIU0ND?=
 =?utf-8?B?blBGcE5IZzFMQlhEL2RHcmwzL0Zsd2Y3UElHa3JzVkxkaG40SGxkaUZ2b3Zu?=
 =?utf-8?B?czJ1dzhSblNrc0x0bk1IK0pLQkJhNGZaZUtpaTc5TEluSzVBRXFIWmJxRDEr?=
 =?utf-8?B?dGxKUENSYkdJQ0RxdEhPMHlhc3dtOEs5QTRWWnJTSjdTZjVUelJ5dkZjeWlK?=
 =?utf-8?B?WXhzZ3N3amxDNXJSdlA0KzhNNFVLRkxKdGQxcXB6djJacHN1Ulg0bFhDZHRZ?=
 =?utf-8?B?eVVvYnNFZWVuVy9hM0VkRkh2SkRmSXdFOXZCYWVsYUtrSmZyVmZqd3JQdHJW?=
 =?utf-8?B?OW9zNndXMnBiU3dWaG1TYmdUU1NmTUltRS9wS0d3Zjc0WWl5L3NjVFh6Z2JK?=
 =?utf-8?B?SllNVkUzNTFPdnZaZnA0YnZEUDgwWjdYTk43NXJGYUV0OHU2dnBYOFZmd1VL?=
 =?utf-8?B?V2xlYXg5REh0R1FxVm9pc2lJLzUzaHlOZlRoYXFiVEtjTldrRU1vZG1BY2hT?=
 =?utf-8?B?NlNXR1JyOWE1TDFlYnBOdUc0czlLUlN6WUlJak5DckZvOGFubWRPSFJJNVFN?=
 =?utf-8?B?cHlKYUFWRXFEOWJiQm9lSHdTVFU3czJ1QWFwMFJuNmhsakxyVENUUEZPc1Nr?=
 =?utf-8?B?eTA5K3ljSE9sYlUzTSsxdkRwbFdjRHJKMi9UMDJFM0Q1UEt0T3YydVVOM1Yr?=
 =?utf-8?B?QUMxNWpxOFlpUUQ2bHl6NElROTVXM1hVTnNBYVRoTFJXRytMRU04dTdKdXUx?=
 =?utf-8?B?bk1BYTB3bWNiY3VXY0traS95a2wycFB0QzkrZG5hVXVrblI4Um5oK21OUU9B?=
 =?utf-8?B?b0ZmS09JaGdDM0w4Q3BFdlpWNmgvM1VDU2VCbnJMWTJFdFJkUTI3RXNaRFdu?=
 =?utf-8?B?akR6ZWRvYzNVZnA0R0pmV3Z2c2pVSE41aFpwVzdXdTJMMGU3UitOdWVrTEpD?=
 =?utf-8?B?TmVvczhubWtXdGY5SHBTV041Y3VYNGQ0WWEyRWVZYW9IYWZGaVd4UWVUTDJv?=
 =?utf-8?B?ZTZubk5pNWpNYUlubFg3R3hJdkFITGxBL1lxWFdDZnhRZUZDaUU0d3g4djlt?=
 =?utf-8?B?S1BYcGFRZ0h4TUZheDRzT0txS200cjB2VHV6bkZJYzVuNHZObWpOV3Vwc1hn?=
 =?utf-8?B?cEN5d2dUdVNCazJiM0hycnNuRWxubnZSUURjSXZFOHB0ZGhqaTRGUU0wektk?=
 =?utf-8?B?cmRMcFU4UllNY2dqRlVQeGVnL1JDZkF0V0tSS0x6a2tMRVpzMDdSME4xQnY3?=
 =?utf-8?B?RXpJY3kxRzhuOVVrczlqKzJkR3QrL0JUaHRyWVZyY0NOdVJFRUprZElaZXlU?=
 =?utf-8?B?Si8raEtCbmcvTjRsM2N2eW0wYmZRZ0JqdGFiYXRrMUpObEpXRzRxRjJLRUh4?=
 =?utf-8?B?eTVXdGJoNHFIQmRwcnA0K09wRkYzUEoxenlkMmttcXRFamk5QTgybHpnREEy?=
 =?utf-8?B?WC9DdG05elRoc2hPcDFJcEwzd0xkUnBxcDlvN0lxN1dxcDdlNTRxYllKOVUw?=
 =?utf-8?B?WWhiaXRxNDZjYVFRMnZFV1pIN25zVWFQdHdkMG1SWFdOQXRiS21aYUFWVXBs?=
 =?utf-8?B?UG1LRHUwcllJZ0FTWmpEWklONHk0ZzBaSHpmckhmNkV1YytYanFPUVhRSmQ2?=
 =?utf-8?B?RG01bmUxR2VzeUtncnVjVHRqZVpzaDRsN2J6K2tDRzR0NzRMb0dNT1dZZnNZ?=
 =?utf-8?B?aWhWQndWelZKUnBLZzVIdDlkbWpGdzIvQUdqalJGbExRWVY2S3kwSXNkUFJn?=
 =?utf-8?B?NXA1bkM5enF1Wkt2OGdvU0Y5VFFHcnNENVdVTmVNNnRhWktUSzI3YldJaGhY?=
 =?utf-8?B?bkROYU90T1M1SGZZN0hSSEx2WC9pOGtxVUU2WkVvajg5WS9iQldwenNYS1Y0?=
 =?utf-8?B?V0o0UlhOSEhJdllwdktmemllK05Md3FLNUxSQzFDUXF4VCtxR2xEeEdwamNY?=
 =?utf-8?B?R2tZcCtnam11YzBZY2ZsSENsV3hoTzJqMlExMGx2SzZSWnkzYy9KbVRPN3Fj?=
 =?utf-8?B?ZDV3MjlXcXovYmlna09icE4wdy9GMzk3L1hFUy8yN0JsNit3dVpBZm9HeG1G?=
 =?utf-8?Q?4RXPvY52I4x0EqdCaOXnIEUjw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a920a5-4fd9-44c1-e819-08db8cec5670
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 08:51:29.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FZXLDraPcK9ddFmHPw6y3ZLpmfOZ1/6myWNyMfIe56vm3fhwkiGB7GnPDgQdFKrUGlGJdjvymQEDJZYlR/WtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA3LzIwLzIzIDIxOjM0LCBMZWUsIEthaCBKaW5nIHdyb3RlOg0KPiA+IEhpIERpbmgsDQo+
ID4NCj4gPiBBbnkgZmVlZGJhY2sgb24gdGhpcyBwYXRjaCA/DQo+ID4NCj4gDQo+IFBsZWFzZSBm
aXggdGhlc2UgY2hlY2twYXRjaCB3YXJuaW5nczoNCj4gDQo+IENIRUNLOiBBbGlnbm1lbnQgc2hv
dWxkIG1hdGNoIG9wZW4gcGFyZW50aGVzaXMNCkxldCBtZSBmaXggZm9yIHRob3NlIGFsaWdubWVu
dCBpc3N1ZXMgYW5kIHNlbmQgZm9yIHY0LiANCg0KPiAjNjQ6IEZJTEU6IGRyaXZlcnMvZmlybXdh
cmUvc3RyYXRpeDEwLXJzdS5jOjI3NToNCj4gK3N0YXRpYyB2b2lkIHJzdV9nZXRfc3B0X2NhbGxi
YWNrKHN0cnVjdCBzdHJhdGl4MTBfc3ZjX2NsaWVudCAqY2xpZW50LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHN0cmF0aXgxMF9zdmNfY2JfZGF0YSAqZGF0
YSkNCj4gDQo+IENIRUNLOiBVbm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBhcm91bmQgJ2RhdGEtPnN0
YXR1cyAhPQ0KPiBCSVQoU1ZDX1NUQVRVU19PSyknDQo+ICM3MDogRklMRTogZHJpdmVycy9maXJt
d2FyZS9zdHJhdGl4MTAtcnN1LmM6MjgxOg0KPiArICAgICAgIGlmICgoZGF0YS0+c3RhdHVzICE9
IEJJVChTVkNfU1RBVFVTX09LKSkgfHwgKCptYm94X2VycikgfHwNCj4gKyAgICAgICAgICAgKCpy
ZXNwX2xlbiAhPSBSU1VfR0VUX1NQVF9SRVNQX0xFTikpDQo+IA0KPiBDSEVDSzogQWxpZ25tZW50
IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzDQo+ICMxMTY6IEZJTEU6IGRyaXZlcnMvZmly
bXdhcmUvc3RyYXRpeDEwLXJzdS5jOjYyNjoNCj4gK3N0YXRpYyBzc2l6ZV90IHNwdDBfYWRkcmVz
c19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+IA0KPiBD
SEVDSzogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzDQo+ICMxMzA6IEZJ
TEU6IGRyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXJzdS5jOjY0MDoNCj4gK3N0YXRpYyBzc2l6
ZV90IHNwdDFfYWRkcmVzc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFy
ICpidWYpDQo+IA0KPiBDSEVDSzogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhl
c2lzDQo+ICMxOTA6IEZJTEU6IGRyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXJzdS5jOjc4NzoN
Cj4gKyAgICAgICAgICAgICAgIHJldCA9IHJzdV9zZW5kX21zZyhwcml2LCBDT01NQU5EX01CT1hf
U0VORF9DTUQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUlNVX0dFVF9TUFRf
Q01ELCByc3VfZ2V0X3NwdF9jYWxsYmFjayk7DQoNClRoYW5rcy4gDQoNClJlZ2FyZHMsIA0KTGVl
LCBLYWggSmluZw0K
