Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A677B43A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjHNIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjHNIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:34:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51ED9C;
        Mon, 14 Aug 2023 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692002037; x=1723538037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jR6bbPEGl2NbBbmeNLwPdhCCbgjJaUntEK/UFcR2PJs=;
  b=XjmMOw2lf2pFPmjJpzIyv7juIlsQyzz07q0hyV5YXQNM70KHZIhSPMRH
   Gvlfa8tRkQGyp7uMsgM6GCMdy6KzqmaE+kdEAjEylCaB8pqzJOpW9wqfJ
   tolrFxYF8XzIH7vqBUKRPVcQ3VIWQWSWipG2jjRqQ+z1fLeEBggRmszQe
   qpts6WUOT+4F3hX1qpfSEppqnSeJ+085xi+rkHwNzVVD6tYiBw0SBvElj
   FB+FQmkG/KRRSLQjcjubRT/1ywMMqR+OaOykIt8e0Pyzbyph/Clkga+6V
   hiU/0jdD0HikvDZi4OesJDrT5J9CXOZVijdyz8vVWvyPxOt7xgeS5OVZ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="435884181"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="435884181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 01:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="733383441"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="733383441"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2023 01:33:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:33:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:33:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 01:33:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 01:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRbstSm19ygRoK7oNhZICP5hKEeVedvnCQT+eR5mq6JTNicpvKfxdKid3Q9BBiFyhCIUVF3tYk+JvbhSu9zJD//hXpMnIa3q2V7D6cm9LGTO+MZAe1aoRccT2ZYXXSyV2FZMOk6N7Y8/366+Remb2PH+vBRPHJkMzbAvrgbycTrwxvWtkFiUz+ARjTw7LQKEVexReEDeE9mN5kGb6g+VMI4Zv/lAf+pDOnXbzR9t2cWpSyhuMzbKr6ijVbRNyoE+v00Qc0FYU32w6Ywo5n0u+beoSWxE6tcTCNUazLjHpNNNJwhY218ZE/L6XCMMgiiQ3pzs/Fw6gHTZOEMOOcK4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR6bbPEGl2NbBbmeNLwPdhCCbgjJaUntEK/UFcR2PJs=;
 b=b7ZLfdOcwerRNyAhqfjcELHgltrJfxEn9COFyl+2x44wnBh7kTzX8iNLikPTqyIL88R0tx95H4TFvHNelOeSfZWvyK+m1HkiOxBojYsviQw3agqSDnr8ladLnDqysvob6T28yaDlZDIuXJYrbPwcOaVejy0HfmAYvx1ouhzMRRxAIv1J+ZVnz0arLLeqDKVe8E2b8OoB3eRzrDm0bLzLlDKrXtV6nb/QzZ2vWv2NDre2TfroPgDP2aUhFEZYSHCnlzYmEAoSIPA/ymdz0KLOY+ZMqU9PoWsc6nLmmgwLjqC/ilj9g4xuzYwVkiVF2t/OP0phy01JAi8RwqnptjqoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) by
 DM8PR11MB5576.namprd11.prod.outlook.com (2603:10b6:8:37::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 08:33:48 +0000
Received: from DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9]) by DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:33:48 +0000
From:   "G Thomas, Rohan" <rohan.g.thomas@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose Abreu" <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Thread-Topic: [PATCH net-next v2 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Thread-Index: AQHZzIYsUZSHUVRVXUONNo9tf9I9ya/paZsAgAAOuGA=
Date:   Mon, 14 Aug 2023 08:33:47 +0000
Message-ID: <DM3PR11MB871470EB2A752BFAA57A05EFDE17A@DM3PR11MB8714.namprd11.prod.outlook.com>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-2-rohan.g.thomas@intel.com>
 <e3939093-b9f3-d722-d6db-84cd739f9c0c@kernel.org>
In-Reply-To: <e3939093-b9f3-d722-d6db-84cd739f9c0c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8714:EE_|DM8PR11MB5576:EE_
x-ms-office365-filtering-correlation-id: 9a2f6937-a8bd-4f5d-4c6e-08db9ca12dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETnnB7hA7ULekSBnI2F9GQGhNyHLA4yxdjpL03qtxiy6/Fsc0sAbvWTWjAXi08Jw2gRQOUkKPOSrbTFS/wT1SyMyvNWRA1Zl+G3it2r3hNhzagDwXf3+hL8Zx6kgEGgc3ZOYDuYceqO6CPDLrBDppOIYVAf15VFMhIMFr+8SLRsYux8BuyI41TJKxb1dcr/8BXGdSvBnK7ycX126qvIFMW4r/kUdEcAT/QByoOzdBjdPEDiodQ2bGo1Eju1RBCO6Gp8FdLpcJJDgHX9FXS1bapk7SFwtX/cs4YJ8Kp8pO/ObzFowDSCgxvHpASAeLCh4RG4dJbncegAUIYhIKgHZcwPRo9Pr7YDmad4yiCQus5kSopljee57wlqkIr8E70IRJnxgZKP/gmWSJyC1eh17/3SOSWk7jxS8ZHeiYOtFD0aeM8HY/0cZuYup6lxlffLQ6yrh3V2gWeoFqNbtpCTg+s7z+KH3eR/TXDx9NBADddW/K9U0R1FBbwp1qdC8bKymmL3MsWJg0CVRRC5pwAxMpUSsnpQn1vRT/y60e1uEhbIYWeM7t9MI5uZpVd6+qERXFOWWwwUTUq5RHcegumHtiNI9wOTa3B83y0JAo0D6YpdqZESDNZuO0NRebs+GdmxqEI5R7XGqOjVXfwlCcdezXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(1800799006)(186006)(451199021)(53546011)(26005)(6506007)(41300700001)(8936002)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(316002)(8676002)(9686003)(83380400001)(71200400001)(7696005)(122000001)(478600001)(110136005)(55016003)(38100700002)(54906003)(33656002)(86362001)(4326008)(82960400001)(921005)(5660300002)(2906002)(52536014)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhaWStPNDQ2bFVnbzdBSW14aFArSzBUeHpiZlIwVHBuenVqdVlzY2xsRkVk?=
 =?utf-8?B?bkt1WmZHVXU4ZE5XTlFKQ3FkY1VOL3RJNXZmMndWM1hzWmlVTlFaQnBhYk40?=
 =?utf-8?B?TEJldU8zYVFneW1XbnJ4VjBQODRrSXBPNncxVVE2YnhxUkM0RUZJb0lqUUNN?=
 =?utf-8?B?UEMreXBrSnFPV3AxWlN6S3BHelVZL3VFV0JjZ0tvdmwzdzJhL0xya2NHMkdJ?=
 =?utf-8?B?UUJlby9TVHpmbnB0b2g5VXlpSEZoK3RWUU9TR3pneEZxT2YxQTJuVldIajRj?=
 =?utf-8?B?bUo2bHFrOXdwYTB1Q3kzTmlvSjgvelNueG9RMWpnL3FpV3E2aGZ4cnRpcXRY?=
 =?utf-8?B?bkVpRXVzbTJXa25kZW01Q0dncDZnVFcyNkJFZnU2Q0tad0dLK0dQZXQ1QUN3?=
 =?utf-8?B?aW42MUwvU0dsb2U1R0lBcnhvMno2TjY5OGx6SjJIa21kdjFpb2hEay84dk9S?=
 =?utf-8?B?OThSTXhxcWtBc0xCU3NFeERYaDl2RFNoSmlKR1RXdkw3a3hoK2QrWWxOeHd6?=
 =?utf-8?B?T3FaazdnMlptbEovMnJ1RFUvRUZGQWpmMkNpN1FoNmJBN3pXVFI5U2FORHhQ?=
 =?utf-8?B?bWhOUE5ucEV3VW4wNHZhd2l2bk11UnZ6eHNSSnQ1SnFwZFkxUTlVQnhqNkRa?=
 =?utf-8?B?WDkyRnRYZWx0OUdNTldmbDVtTnRFd0EyKzB5T0lvYWlwMXR0Z3pLYzJvYjll?=
 =?utf-8?B?cm1ZYlFNQnFuMEVvUXN4UUtQdjVjd2VqUVB4ZnVuK0N5MHBJOEQ2MU1uNFVa?=
 =?utf-8?B?bk1ZQ0d2T1JibXl5M0JncmJsclVqYU1TdEd3SXdMWFFyaUJmUnJXTksyRWlL?=
 =?utf-8?B?WHg3V00xMnhCTVZlV2RRTnRhWkJQaExuVm90cGswNFZsNUFSY1lPUFcvL25w?=
 =?utf-8?B?Y3N5UENqUlpqckhsWGRaVXg5ZHh2UGNuNm9QRzkvRXY4eXFDZlkyOFRHMTJH?=
 =?utf-8?B?cEx4ZjNPOElrZ2lYQTUyNTY2L0d2SlQ0S2FEMVRPQXIyZU10Q3R4YmVxZElR?=
 =?utf-8?B?M28rYjlnV1ZIYkRiTXFsamhMR2lUbHlvUlBxWEdIeVVobkNvWU9mM1FPZGo5?=
 =?utf-8?B?emRERzFvT3FmS0lLYXEzVEN4NExuNTA5VmM3cTMrSEM3NjNsMXk3S2hKNFRz?=
 =?utf-8?B?TC9YaTNIMExla3NOcFFNWXhNb2h0bmMyWVV5RTVacVRpYStwVisxOEM2VzJ2?=
 =?utf-8?B?ZXVVV2I4NEFMWlBIdFJQWXVQZWszRElyZG43TTVEdXAraHZoSDBxM04xZzFJ?=
 =?utf-8?B?ancwelF4c2lEenR0RE1pNGZJalhHMVF1SUllUjFzdWJreFlIcmFtVXZuMnRu?=
 =?utf-8?B?dFpWQW82L3dxaUtsaFJ6UTFhSWo2Y29SUlVUVVBnb2s1UytISWk5SEdmNEd1?=
 =?utf-8?B?c2JuNUlmQkdMOEJEY1BjbEhDeEdqdW50VG9FczZJRStXOU1LSnY2VW83Z0du?=
 =?utf-8?B?UEYwcUhwWm04a2lZZU54T25Kem5OMDk0ZUJoSEovQmtLS2laK3ZacjluSktt?=
 =?utf-8?B?VDY0ZSs1Tlo4SEdjV1NPTVNMaUFGd2F2RmwrUzZtSEVqVXlsSDVNS09VbGo5?=
 =?utf-8?B?MmYvL2dmaTJmMk5RbW41c2NxMWQxRkNhbTdmVTc4dW05eWg0YWhwQUVIVG1l?=
 =?utf-8?B?ekpOMStsWm9jV2ZKZWVCQ1VFVmFOVjFhTG5oTERQbnErZnJNelY1Yk9sSDNP?=
 =?utf-8?B?MFZ0U1czeGx1RVl4amY5ZCtaMUJtNlhaV0h5OHQvVWs3QWVzbkxsTEI1Sjh3?=
 =?utf-8?B?MHJQRndlZnQ4MFFuenpqVTc0OGR4bDQ0ZUxseFU1UmYvbFZoY2c0T0pOUXhr?=
 =?utf-8?B?bXpuaVhJT2J0NkgyTHRGZjRjVUxPcTlpa1h2QURtTGxkVm1tS3RRbDdOZ0Ix?=
 =?utf-8?B?WEFadGxWSWlSdXp0NDEzZ2FIeHVFU0Z1d0MvTG9JT3JLRXlQdnZxaTgyNGxO?=
 =?utf-8?B?dHNxY1psbStKeGo5TCthLzFISExSb0VtVzI5WFFleFNndVRJM01hNFJoRUc3?=
 =?utf-8?B?b08vSWllTGd2OWYrS1NRT3hTY0NDS1RvM3c0Z043NDZRUXpEVzhQQ2d5UGt1?=
 =?utf-8?B?OXA1Mmc0SWE5REZ4L1lPOWVEay84V3JmVnU1TElIQVBRWXF3YUhoeXlBMU5l?=
 =?utf-8?Q?nCnsGwLe7gl2r+3/BAsUe8Jzx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2f6937-a8bd-4f5d-4c6e-08db9ca12dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:33:47.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1mvDbTU7aor5+aoZOM/DubGgwgj3iznydanmzynX8h1DR8D7A6jp8uX4t7YQQwdjMXVgRPMxEgktdx46wKEiUL7E7clogZQdtn+5d5y00E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5576
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

T24gMTEvMDgvMjAyMyAyMTowMCwgUm9oYW4gRyBUaG9tYXMgd3JvdGU6DQo+ID4gQWRkIGR0LWJp
bmRpbmdzIGZvciB0aGUgbnVtYmVyIG9mIHR4IHF1ZXVlcyB3aXRoIGNvZSBzdXBwb3J0LiBTb21l
DQo+ID4gZHdtYWMgSVBzIHN1cHBvcnQgdHggcXVldWVzIG9ubHkgZm9yIGEgZmV3IGluaXRpYWwg
dHggcXVldWVzLCBzdGFydGluZw0KPiA+IGZyb20gdHggcXVldWUgMC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJvaGFuIEcgVGhvbWFzIDxyb2hhbi5nLnRob21hc0BpbnRlbC5jb20+DQo+IA0K
PiAxLiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qg
b2YgbmVjZXNzYXJ5IHBlb3BsZSBhbmQNCj4gbGlzdHMgdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwg
dGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwNCj4gZ2l2ZXMgeW91IG91
dGRhdGVkIGVudHJpZXMuIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBh
dGNoZXMNCj4gb24gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVh
c3QgRFQgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUgdGVzdGVkIGJ5DQo+IGF1
dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0
IGJlIGEgd2FzdGUgb2YNCj4gdGltZSwgdGh1cyBJIHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVudGly
ZWx5IHRpbGwgeW91IGZvbGxvdyB0aGUgcHJvY2VzcyBhbGxvd2luZyB0aGUNCj4gcGF0Y2ggdG8g
YmUgdGVzdGVkLg0KPiANCj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5l
Y2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KDQpPb3BzLCBtaXNzZWQgcnVubmluZyB0aGUgc2NyaXB0
IGFuZCB0byBnZXQgdGhlIGxhdGVzdCBtYWludGFpbmVycyBsaXN0IGJlZm9yZSANCnNlbmRpbmcg
djIuIFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEknbGwgcmVzZW5kIHRoZSBwYXRjaHNl
dC4NCg0KPiAyLiBEbyBub3QgYXR0YWNoICh0aHJlYWQpIHlvdXIgcGF0Y2hzZXRzIHRvIHNvbWUg
b3RoZXIgdGhyZWFkcyAodW5yZWxhdGVkIG9yDQo+IG9sZGVyIHZlcnNpb25zKS4gVGhpcyBidXJp
ZXMgdGhlbSBkZWVwIGluIHRoZSBtYWlsYm94IGFuZCBtaWdodCBpbnRlcmZlcmUNCj4gd2l0aCBh
cHBseWluZyBlbnRpcmUgc2V0cy4NCg0KU3VyZS4gTm90ZWQuDQpUaGFua3MuDQoNCkJSLA0KUm9o
YW4NCg0K
