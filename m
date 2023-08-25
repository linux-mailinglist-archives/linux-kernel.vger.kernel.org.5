Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45853788F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHYTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjHYTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:44:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1552684
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692992687; x=1724528687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oM++WzW4kAxEuijXUe3nrLrmptzE1W/FyZVKMPMcHVQ=;
  b=dZn/WtZHJ6X1JssKPEkjCBDtjMyMIjBzvy1gByhj9u1YrDLJARJnwVrH
   G8YjBKc/vX2pcUvIjR7NPCMmV2BiOmPIBOp+y8t/61BEf0l3BD/a7gAhx
   sI1LJLOS7eMX+zBW0N+jkY4K8L1680lENX09wyehnwjC8GoufUQPEvGZp
   jgbsXTeL1o0FNFvB9RDr/6E5cRNsmdrdMLMz/kh7Nz/X8xl5jtTsszR81
   FKVYp3cIkhEGmTQsuSbRjKghozXjnspBReR0WwDjAyCyDCvUQ70kE/NJo
   rYjjlm2UC8FVwVW4qbmQmW+mzppIuf3qp3/plFdJu+fFN9e3iWr2EH4iK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359786610"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="359786610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 12:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="714451253"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="714451253"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2023 12:44:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 12:44:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 12:44:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 12:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAO2yBShnLkCxtrodtVSrCCxvTMLAE6MtruV4fM49ZcsPHorH1bHw1Q9PeIsJYQDUmdNagkIzVY+ekkJI9GlXqxWMj6MsS4IQUtL1/23SYlH2q6xdIlOLWlHuSjJ7tdQq9Irr5Uqg38ZiEBuBp2giQ9ozUDZ+uvLjZnIY9IalMXl7LwAkhGAIuAuvRE3EFiK7RvMMaEVmdTwpJC4fd/XQpCuxgMb0CwdEGhyc2oOTRHafeoXXO1dqTyDghOrV9OaqpOivXG/EPY2LT1zLeWM3ohNkaUvRoKsC0IdjtD5WHBw4vfrgnahhFzRa1KNyALI9jQGLXXIlvMcmPLz9WLqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM++WzW4kAxEuijXUe3nrLrmptzE1W/FyZVKMPMcHVQ=;
 b=bC2lf7I0QcD9WVCWu2afhNk0HB/Tod4WHd2JzAlycCplUv2UZckbJnrMPTaP+PbfuxwoSHH8gCsQUtUiviOHMvhDnjg2orSKnVnE/+LmG/nMaYUIaRAkZry+1LEKPVtx+C2vVkVUV7YRktiX+gZaXDu8GCXrynhtnMv0YZrjr1ayggZ7QTIF/DLKWv4tQ/ETaMESTiBBK+D3w6L4A5m3HOrqU8onJAewDlbgbFzYHmqgQDn2nlBqO0FOc8NxbtLgsdli+nSK4WIiE+Ki5nEygV2+Fz+eIsYTM55j/7dHZoc+hBopUDjkLxM7GwHM5m9Y7QvmyLqoVwB69455vkyq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 19:44:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 19:44:42 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: resctrl2 - status
Thread-Topic: resctrl2 - status
Thread-Index: AdnWr6S/HyyETPT3Q2GfFYcuexQ3cgAzIiMAAACLZdAAAe7MAAAAiPEQ
Date:   Fri, 25 Aug 2023 19:44:42 +0000
Message-ID: <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
In-Reply-To: <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6671:EE_
x-ms-office365-filtering-correlation-id: ab1cf271-2689-4f53-cb74-08dba5a3ba40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zj6dX9NP5oINKKgwSKR3+bHidbYJfg5FyDSQY3ItzzaP7gHQPt9l8AGgz7WZvFjQEY+3pPV4ZpIoAOX0bnBXBl6QNxaylPggmAlGCCm93AAKPA8fz7OU8XajJ7yAPFtZ4E8XYbo3yPI+2+aFhZJnk9P5hSj6qQFU3SwBYGUQZxsHl1gvMovhOPCjq1nIDl/hf8PZ5sxsPEpr5wDgCCZ1rkoL8W4Lw1f/+Ys1spDLlYDcK99JxTA5D2JHJR3YTj0FulnzzUkLIto7eGHDmyf+4cAsRZ+Kt1l0kcoO2YRnWvOIWpy0+tGb2VVFGEStdU3FNLkPssV+b+zeyzZ6VOVUi1G02NaxNpH6T3idB++0zRkQIWbDdic548rC4U7NQBwQ6oFJu7NM9QYdF512DBUmnSzg+0RBlRze3SAHnnkwrCa0PMHW2VIl74GMOraup3907eVcOPISzEh/gNxgbTy82PxgeRO3PDzOHWij5m9bEqDB73jZP1Srv+wOqb8c2VeTqCWVASZnqyw80G4HiiD6prrdUYF81n3ebbhdnKu9P9JUAMXprBicntZ1sIMqrzusnVOxyW0F9N0nAjajXE/fX8Yf52AWV43cF1uDu222dean2lkHExIeMQH5FrZt/1Nl9BhEID9JkjYUtqZTnw70jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199024)(186009)(1800799009)(5660300002)(8936002)(2906002)(54906003)(64756008)(110136005)(316002)(33656002)(66556008)(66446008)(66946007)(76116006)(66476007)(8676002)(4326008)(52536014)(7696005)(26005)(9686003)(41300700001)(55016003)(921005)(38070700005)(122000001)(71200400001)(38100700002)(82960400001)(83380400001)(86362001)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTlhdmQ4RlhjcTdLZ21XWjh3cTVsR3h5R1UvaFhkREZnSHM2amdabmJXdExw?=
 =?utf-8?B?bm00ZDhSOWY3UWd6eEVCTGx3UldKUWNiMzh3ZVh5WWtoMWw0RW80dEUwdWll?=
 =?utf-8?B?a3JxNzJVUmNrNlprNkE2ZUhNUkFrSUdRK1JpUGFyMXdGSDZLcVI4a0Z3STQ4?=
 =?utf-8?B?dXBRNDRvMUJtRzZyMWpYSFlIR3RibEx4T2l5RkZEMFlPQ2p4V2I5NzdDOEs3?=
 =?utf-8?B?S1J3R3ZrUHNIbE1hSFd4TE5aT3BPdjRib0tSWVF1RzdEMCtHWWY2bXhsQ0Rt?=
 =?utf-8?B?ZlhvbnZ4UDlFV3JPR1RLQjlmOUNGQmNLKzFWenhoeXM5WlltRXZLQlFUWVpL?=
 =?utf-8?B?L1hDL1k2eEI4ZHMzMmRNYTZlbGphUXhJeDVlakhhRUdqeXBBUStSNFd4NWo2?=
 =?utf-8?B?aWtzT0pEejdnQkxWNXNrWXJZR2dKNzdMUWduL245OVZVbUlIT2M5cVE5MVh1?=
 =?utf-8?B?cEhmQ1BaZUFLZTVweTN2MEZZZitmTTNHYkhtTlFwbDdtZk9zWlBIcGZvUUsv?=
 =?utf-8?B?U0RxSnhacHY1bXJvVDhTOHhoN09WYzB3NW1yK0xXbnY0L2ZZVTZSSW5LUmxW?=
 =?utf-8?B?Y2hvMklaQkJGenkwTWJYWWFFdUtSQnJwR1NKd2RuU3pWbWFEc2VvcGpScFlP?=
 =?utf-8?B?QlgvcFFIVUdETWZhSDdyaHJlWCtEZExmaU9JQUUxVmRYMnB3Rkphc1dSTlNT?=
 =?utf-8?B?Rk9BTGlndmdmU01vUFA2YVR1NkxEakxwc1ZUNTJnb0NDalpSUWJoSWxwQWZB?=
 =?utf-8?B?UENXNHB0SUp1SytOSjE4dFBlK2w5NCthQUYyL2ljVmJwbXVGb3N0dXVxMzVD?=
 =?utf-8?B?SHZjS0QrTWV3dnZJNEtOYzRJL1hneEJsVGpuWFh0OXJJUnRsUlJWSHYraXR1?=
 =?utf-8?B?MFA2ajQ4anBZRmZ0RWNSSlNMTWpBR1B6enJlRlVvRXUwZ0RWalFzbWNlVlgx?=
 =?utf-8?B?enAvQ0daakszNnFNaEZRUmF2em5VYWsyUStrWU9meUQ2ZmlqSDlPNU5FRHBW?=
 =?utf-8?B?UTI1R2p1Yit0UjdqellCZDNiVXRkYnJHV3hvMjIremJROTBSVnk5TERuMUpP?=
 =?utf-8?B?ZmNTNi9yOWFNU0pCT1RrbjNmY2JmY2ZZdkRrRkh3bk5wM0ZpU281Um91S2Zl?=
 =?utf-8?B?UzlIc2M4Mi85NUtReXVqMnVmbmRkYVpaWC9meC9BWkpuM05MUVRDcTFFODlH?=
 =?utf-8?B?RkNjNlBraGl5SisxUndvRjE0cjVCUW1IK0M1SGFPMUQvaWdqZ29GV2Z2VmFZ?=
 =?utf-8?B?VXVQMmZLanlrYnNVak82dmZTaXJralhOZmQvTGljNXlKTjV4dktBZERnRWVu?=
 =?utf-8?B?VTBmK01ucm1Tc3lZL242bmo2bW1ZR3FjNVY0UzR1dnNSQTdyYUR2VHh3UFpt?=
 =?utf-8?B?djJNN1J3eVJVVDJ2clZzb3RGRm9oRVArODY5bmc5djQ0eWxENU95dEw5aWQy?=
 =?utf-8?B?TFZJaEkxcUlOTGp0WDhoWHN4VlB3N0tqWTZ0ZFpldUFqWGo0K3kzWDcxUWd1?=
 =?utf-8?B?TjBzeWY5Z3JNN2JiOFk0QjA0cm10ZS9XcDgrM0FhTytra29EWU5EOUVzeGxY?=
 =?utf-8?B?cmtNd0ZaMTlKVjNocUNuSVdkRnJYeUl6djN4c0JlYUhmS0EvdVpOQTNBWWhm?=
 =?utf-8?B?QTRlQWpPakRiYmQxRDgwNk1tM2k4SVZLTTdDQjZQOElIUW01RWlkQkp2eHZy?=
 =?utf-8?B?QWlMclVOYzgrS1JaR3lyOTFBTHBMbzNGWkRhcm1vSTl4VndYWElRekEraUx4?=
 =?utf-8?B?Q0RYcjgzK0k2clpNbFQzTllMZjNuZHlIMHE1amY0Z2EydUVVdzF1N0lnS2tz?=
 =?utf-8?B?R1Z3azRxckVsRmQ1c01YS21pdm11ZkpnZ0lZTUV3cjdpT01MOUFVcS8wUk9h?=
 =?utf-8?B?b1UrazByQnAyZ1dpdWRsMElJbDNBMEFXQTAvb1JIU1JjQ2RYY01BUWptVUtM?=
 =?utf-8?B?ckxpOHNmSmtucGtiL05Sb1hXUTluM1o3U05XcEY1TjJUdERkMHVHWDdSd1RL?=
 =?utf-8?B?a2V1TXJXTnRYK0FFRVNQNGFIdmtLOWJvdFNIeHJITUZtT2lRM2xVakpVSjRM?=
 =?utf-8?B?eExpNzkxNk12MXR5YWd5WU5IL1RqMDRmZXoxbEt6ZUlBQTVVZmVvYVlOQ3pI?=
 =?utf-8?Q?AQ/Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1cf271-2689-4f53-cb74-08dba5a3ba40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 19:44:42.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/pF83utt08xavSqUAkyRz+RDOBO1L/UL9CEHWki1WpXP6CyfKnu6JAmUsP3zY8fQyM+npKXAG7v+wbRJLJxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBBbHRlcm5hdGl2ZWx5LCBjYW4gdXNlciBzcGFjZSBqdXN0IHRha2UgYSAibG9hZCBhbGwg
cmVzY3RybCBtb2R1bGVzDQo+ID4+IGFuZCBzZWUgd2hhdCBzdGlja3MiIChldmVuIG1vZHVsZXMg
b2YgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMgc2luY2UNCj4gPj4gYSB1c2VyIHNwYWNlIG1heSB3
YW50IHRvIGJlIGdlbmVyaWMpIGFwcHJvYWNoPw0KPiA+DQo+ID4gVGhpcyBtb3N0bHkgd29ya3Mu
IEV4Y2VwdCBmb3IgdGhlIGNhc2VzIHdoZXJlIGRpZmZlcmVudCBtb2R1bGVzIGFjY2Vzcw0KPiA+
IHRoZSBzYW1lIHVuZGVybHlpbmcgaGFyZHdhcmUsIHNvIGNhbid0IGJlIGxvYWRlZCB0b2dldGhl
ci4NCj4gPg0KPiA+IEV4YW1wbGVzOg0KPiA+DQo+ID4gcmR0X2wzX2NhdCB2cy4gcmR0X2wzX2Nk
cCAtIHVzZXIgbmVlZHMgdG8gZGVjaWRlIHdoZXRoZXIgdGhleSB3YW50IENEUCBvciBub3QuDQo+
ID4gQnV0IHRoaXMgaXMgYWxyZWFkeSB0cnVlIC4uLiB0aGV5IGhhdmUgdG8gZGVjaWRlIHdoZXRo
ZXIgdG8gcGFzcyB0aGUgIi1vIGNkcCIgb3B0aW9uDQo+ID4gdG8gbW91bnQuDQo+ID4NCj4gPiBy
ZHRfbDNfbWJhIHZzLiByZHRfbDNfbWJhX01CcHMgLSBkb2VzIHRoZSB1c2VyIHdhbnQgdG8gY29u
dHJvbCBtZW1vcnkgYmFuZHdpZHRoDQo+ID4gd2l0aCBwZXJjZW50YWdlcywgb3Igd2l0aCBNQi9z
ZWMgdmFsdWVzLiBBZ2FpbiB0aGUgdXNlciBhbHJlYWR5IGhhcyB0byBtYWtlIHRoaXMNCj4gPiBk
ZWNpc2lvbiB3aGVuIGNob29zaW5nIG1vdW50IG9wdGlvbnMuDQo+ID4NCj4gPg0KPiA+IE1heWJl
IHRoZSAiV2hhdCByZXNjdHJsIG9wdGlvbnMgZG9lcyB0aGlzIG1hY2hpbmUgc3VwcG9ydD8iIHF1
ZXN0aW9uIHdvdWxkIGJlDQo+ID4gYmVzdCBhbnN3ZXJlZCB3aXRoIGEgc21hbGwgdXRpbGl0eT8N
Cj4NCj4gQSB1c2VyIHNwYWNlIHV0aWxpdHkgb3IgYSBrZXJuZWwgcHJvdmlkZWQgdXRpbGl0eT8g
SWYgaXQgaXMgYSB1c2VyIHNwYWNlIHV0aWxpdHkNCj4gSSB0aGluayBpdCB3b3VsZCBlbmQgdXAg
bmVlZGluZyB0byBkdXBsaWNhdGUgd2hhdCB0aGUga2VybmVsIGlzIHJlcXVpcmVkIHRvIGRvDQo+
IHRvIGtub3cgaWYgYSBwYXJ0aWN1bGFyIGZlYXR1cmUgaXMgc3VwcG9ydGVkLiBJdCBzZWVtcyBh
cHByb3ByaWF0ZSB0aGF0IHRoaXMNCj4gY291bGQgYmUgYSBrZXJuZWwgdXRpbGl0eSB0aGF0IGNh
biBzaGFyZSB0aGlzIGV4aXN0aW5nIGluZm9ybWF0aW9uIHdpdGggdXNlcg0KPiBzcGFjZS4gcmVz
Y3RybCBhbHJlYWR5IHN1cHBvcnRzIHRoZSBpbnRlcmZhY2UgZm9yIHRoaXMgdmlhIC9zeXMvZnMv
cmVzY3RybC9pbmZvLg0KDQpJIHdhcyBpbWFnaW5pbmcgYSB1c2VyIHNwYWNlIHV0aWxpdHkuIEV2
ZW4gdGhvdWdoIC9wcm9jL2NwdWluZm8gZG9lc24ndCBzaG93DQphbGwgZmVhdHVyZXMsIGEgdXRp
bGl0eSBoYXMgYWNjZXNzIHRvIGFsbCB0aGUgQ1BVSUQgbGVhdmVzIHRoYXQgY29udGFpbiB0aGUN
CmRldGFpbHMgb2YgZWFjaCBmZWF0dXJlIGVudW1lcmF0aW9uLg0KDQo+IGZ5aSAuLi4gYXMgd2l0
aCBwcmV2aW91cyBhdHRlbXB0cyB0byBkaXNjdXNzIHRoaXMgd29yayBJIGZpbmQgaXQgZGlmZmlj
dWx0DQo+IHRvIGRpc2N1c3MgdGhpcyB3b3JrIHdoZW4geW91IGFyZSBzZWxlY3RpdmUgYWJvdXQg
d2hhdCB5b3Ugd2FudCB0byBkaXNjdXNzL2Fuc3dlcg0KPiBhbmQganVzdCB3aXBlIHRoZSByZXN0
LiBUaHJvdWdoIHRoaXMgSSB1bmRlcnN0YW5kIHRoYXQgSSBhbSBub3QgeW91ciB0YXJnZXQNCj4g
YXVkaWVuY2UuDQoNCk5vdCBteSBpbnRlbnQuIEkgdmFsdWUgeW91ciBpbnB1dCBoaWdobHkuIEkn
bSBtYXliZSB0b28gYXZpZCBhIGZvbGxvd2VyIG9mIHRoZQ0KInRyaW0geW91ciByZXBsaWVzIiBz
Y2hvb2wgb2YgZS1tYWlsIGV0aXF1ZXR0ZS4gSSB0aG91Z2h0IEknZCBjb3ZlcmVkIHRoZSBnaXN0
DQpvZiB5b3VyIG1lc3NhZ2UuDQoNCkknbGwgdHJ5IHRvIGJlIG1vcmUgdGhvcm91Z2ggaW4gcmVz
cG9uZGluZyBpbiB0aGUgZnV0dXJlLg0KDQotVG9ueQ0KDQoNCg==
