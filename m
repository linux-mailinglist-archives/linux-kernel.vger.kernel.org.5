Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383267DFCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377512AbjKBWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:50:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D30133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698965409; x=1730501409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dfkbUSXQ/S46gRUKEAakOidNAeESGuJZRg0hrTi3Nbw=;
  b=JIrydZ8S0+xt2DiEsKoMHMcu605MuBe6l4rMWUQwI5T8zt9c9HVvinDn
   1VRE8QvYk9xE8w6Qu2s40UcBWUx+KNqx43XxInAFSiHa9B1rMkemv3i4c
   /AJSZqAmlUusRcDtmS1+uQ9HZyG8GASBvDslJthE6+2VUZyEBe+5Ol8Tw
   yzqNdiRiWpNSwUJaH0vSRtt/xOS9Pg6ZyOF29tl53qQTiaiBeEcL+eRqo
   Abfj/i/i3RirkiBzJw/CkmQw49MUDZRBrXLdnLEAZEgmumF9leEiMQ8AE
   eRHyC2za5BZkeeD7QhTomBB+u18VBVknw19otvxpUvqsg4vJHcEE3plJi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387725126"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387725126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878419407"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878419407"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 15:50:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:50:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:50:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 15:50:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 15:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYnL/waxcvPgUxQeQpN0QDepCYQ3wNEA/I29lDvsG7ZCF6wsZVB3UHw6FigObFOQmXoL1iSigWOgOQMUSG3JoaoIyj5QA0AljlQefpNET6cMpxx+dMDIbSwhgI7fDw7FDjAr7TMI0FAdDzx2jHHPF+VM7IYJqxsklB3UL0vqlIOINVpF0laaShipLLjHc2729ROQ5LLwFfLAzW1AdNXOJ0ABi7ANuBQ6LZz2AI24WR4H427Q8fdINH7gV0Dg9iQ5BwhjgvZbtMRx2DMtzauFRnEzChKgrtrCBAmSBwywZKOvG1/H2hvdxi2kFT9PTlCFWsh09TW98ZU2wOHXpNmWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfkbUSXQ/S46gRUKEAakOidNAeESGuJZRg0hrTi3Nbw=;
 b=Cs15hNsLBaTIND7ujk7gUl85HLaNXaoRCj026Ep5GVMB+m3hxKLMKhEZQ5f2idw28ol+z2407UlG0SMk2G/bw7S1zIftMBO7XYMNkMArPyLKt8Lsxhwo1z4c/RvkR3gbWfiniavhbP2Or4aNwZLR7p61W+x+pkl8+4c1LqBLR39orAXzNFJRVbBDEN1WqouxKrXkcfyzarvT0Ak2+uchORklzsQWibS/U1YGJI/YijXF+qHRTyimzhSe+Uqvt2MpRqNHD/FttXV/uejdH9yw4VWt8oKX5LTu3zdPSakygdTR42ldzbvmn46PtpHe3ioWMrdFlEkDuqZ0ChLZ5TF0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 22:50:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 22:50:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Moger, Babu" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Topic: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Index: AQHaDdRZXJsCafg/QU20afPRuiTx9LBnlGsggAAGUoCAAAMi0A==
Date:   Thu, 2 Nov 2023 22:50:00 +0000
Message-ID: <SJ1PR11MB6083E6ABE4D467D5D275A309FCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
 <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
 <SJ1PR11MB6083D8F1467F094A5F1993EAFCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0f8bd2b0-025b-424e-823e-03e51e99cfcd@intel.com>
In-Reply-To: <0f8bd2b0-025b-424e-823e-03e51e99cfcd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8123:EE_
x-ms-office365-filtering-correlation-id: 2111f210-2dc4-4ff9-16a7-08dbdbf60b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NzEsjBpfPsLNYYIye10r7DLFynAosl23Wo04HKZfHH0fXLFN3vhoc8profjIalPZ3KtstMMJ2xfFa0YQO1qdz1LgJ5BzG7CJnCYYmyb/lFFbUV7Ezd8fNMFO2LAnMX5M4Kzb1omhaQYmirMPyA9QTxisVztCZFvwukVngDe/flJnTKdIgeJHgtKgaNgnBaIKqFC7LAlZBJUqastYux0n5Oe++ZTA8/Rr3h46ZzvaTCYmkfRzPfmKAzjEBy6cnDiW2IMyvaA8hFiJkjV0vG+2LUNZN3b4sfKla5ReRWKw377dN4doAxMML8ZwOXLVmiriURibTKxSNXPewqGEZ45mrq5gtIgDdqmzZoLZ1eM0gvG6IIbMUow69MD6MkWsGb5gROMLqiZtzmxOKPHQeKWQqcDlfS0EOR725GwIQehVYc+PiZV/EisRwaKEL3rvG0JggyPtdnIEdje2pM2XaXvRZkpz1uzGrFVZNn1/O2fOplMriL4LQwc4yOCT/ckm5EEUKVMjmsjJvyUHV3Cf8ERg81/p+MyCQvcaWyXLljCQ/zSUBhBNQCGOI/0Mo7ta4DDyPnQAzvP9gbFbQZdPPlKYUfkAetyCTaHCpdmjZLK6o/gIE9jAiD77Ql6Jh4EoOPyeU8q5knwo/NyodtTsDSgkGZSM9LnbziJWpmVxmZVegs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(8676002)(52536014)(4326008)(76116006)(66556008)(110136005)(66946007)(66476007)(64756008)(54906003)(66446008)(2906002)(478600001)(83380400001)(316002)(41300700001)(71200400001)(55016003)(6506007)(7696005)(26005)(86362001)(5660300002)(33656002)(9686003)(122000001)(38070700009)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NStYTkFETzBibzc4b2pHUUpMSlJCZXNYUW5MbDJNbjdNRENEN0tzT0d6dHpq?=
 =?utf-8?B?L0NtYjR4a3ZLRnJJWHJhNFVuMW9kUEE1QnRBa1lMdWlKaEttbjl6d1JJc21v?=
 =?utf-8?B?MXJVZ1Q4Q1FYV25LNHdvK3RGc0gwWnBLM1RRN3ZxUlBWR3pCUUJQM2FHMG40?=
 =?utf-8?B?eGptY0NSaUgvbk9NNDBSZC9XZmFORHR5akl2VWowNGYraWJ5eWZub3NDTWpm?=
 =?utf-8?B?R0hJZTR0bUZJdDlqLzZTd1dNdUtTUE5xMWdRN1FqT2xKWmc0UWlMdDdQamxY?=
 =?utf-8?B?ZmlYbllkb1FkY3lDNE5QQ3plakFDLzRUdFBOOTJycHpRb2VKbmovemRFWEZ0?=
 =?utf-8?B?b3JFUFd3Q3M5ZE5LblkzeitMckFXQ2xDT2k2SkZCY2dROG9hc3hkZTZLZjdv?=
 =?utf-8?B?SHgrSTFMaUgzSXMzNmJHem5VamhFNTc0T0p3THhRb0dXYkFJQ05Pa0RKNTNy?=
 =?utf-8?B?VkN4QzlWQXRhbnhxT2l4Zi90a1lOa3NZTVJ0aTVTbVZTeFVwRTBpbWJqWTJs?=
 =?utf-8?B?TG00K1U2VHZQZ3BKWk1JSUJBWm1yNGdjL2NndUdHVEZweEoxRXBEb3lYd0hR?=
 =?utf-8?B?ckVsWUI0M2U0eFVVZDkyL3EzMlo1dnhtZWdudERXQ0d5TTY1S29odmlrdk1Y?=
 =?utf-8?B?c2VhNloxS1cvdTdqVzJucWtGdWVtc2I5eCtEeWtQWTF0WW1lQkpnZ3pLbE5j?=
 =?utf-8?B?QzhIc2VCZ3JzNkYzL0NPdFhValJZb3VWK3QvMTdSc1NzY0thUmRyWVl3ZmVB?=
 =?utf-8?B?czgvelExMjg2U0dJcFZpdFoyeG0yZHY3VEUxZVA0NU9Qaldwc2Vkb2R0aHRR?=
 =?utf-8?B?OHBEYmtZTHdRc0crQUIrd2hOaTJQcGRlUG9CTHplMjFXVjFtK3JJNU9ESUJO?=
 =?utf-8?B?aWQzbGsxVEpZUlVvcDJtTmphNjVrWlJCbzJwd3lZc2gxUm5Rd29qZ2pHaVRx?=
 =?utf-8?B?U3pMay9JNi81b0VNYWVLTkVET2RybmxrUWNpRWk1cHZKaFNMbVZjeG9VNkdU?=
 =?utf-8?B?bWNQYlZndUFxZGxzbHMrOUw0M0JMbzEwS1BlQTkzN2FmM1FpcE95QzRKSlRS?=
 =?utf-8?B?SEtyUlhYUmZqMFlqMTY4WWJHZENmQ283dGNkZ0I3KzYrSFk1OElXUExEMEtP?=
 =?utf-8?B?Z1R3dVpWZjdYQlVoOXlaSCtvVWNJRjd1YTg1aUJiRW5IRkluWTdUQVczaTM4?=
 =?utf-8?B?cnpOVEw4WjlBWHpaSXk4Nkp4NUJJcSswWTIzMkxBWFdweE1IL1FpZzh0OFhV?=
 =?utf-8?B?UEVGalk2V3dRdkVrQnF1R29VdFBaNkJIbEJ2dlNLTktxT0JtZk5UZDVCamRQ?=
 =?utf-8?B?a3ZHZkZUT0ZuMkkxTTVTcUpsdTYvVTk0RHRLeEF6blFYV0pTcGhEemY1RXc3?=
 =?utf-8?B?ZW5oYWZWbzBKRlBZMjdqQUFuRUpGRVdFZC85OEdmYjYxUEc2ME1NWE5kRUVB?=
 =?utf-8?B?MWNFbEtzMDMvV3lsblRoaWtNYjk0TGV0M1JYa3RCN1M5WTFCalVFOE5aWnNW?=
 =?utf-8?B?ZEFvSmcyak5OWVJpY1F5WjRGZUVrQkV4dGs5T0ZtWTBOaFAyajMvNUZGTnp6?=
 =?utf-8?B?ZW9mMzI5ZElyN1dqSVBNRlFZQ25uVG9GOHp3ZUQ4cFpidFE3VW9SK0g5L21S?=
 =?utf-8?B?L0dhNzNOakVvc2FhR0c5YUZVaWs1Yzl0U0F0VUgxY3dlM0lKZVl0dDllc3dM?=
 =?utf-8?B?TUZSc2xKNmNZVUQ1VVBmN2hoREkybThSNzJCRDZ5UVNXT20xVTE1djE5Qi81?=
 =?utf-8?B?VWlIODE3KzI5OVlkUGsyUzE4dUtKa2xUUjVXNnRyaTBCMnlEQ3UxSmdXM1l4?=
 =?utf-8?B?TDNneTd1andBa1ZQc0MxNW1rQjF1MnVGb3EvNzBEdXJhRzJ5cDFaQk0rU3ht?=
 =?utf-8?B?V2hLb1FtZ0dFWkVDdDJxREI2ankzZnF3RVI1eFJ3QTJCR1I3L1Q0WTRLaWRI?=
 =?utf-8?B?aTQ5dmxVMnJZNFZINmU4WkZIQkJaRUlmSURCVlgwMW8xS3NRMmozMTlESkt3?=
 =?utf-8?B?WVhvVWJXdFkrNFFacXpIbFBZUTJBS1JxOEpZT0E3RWhadlBvNHpmb1I1M0g1?=
 =?utf-8?B?M3ZjTm5QZ3doY0tJdlFndEgrazE0bTdQM1lmYlluTXd6WG4wejQ0SDJFQm83?=
 =?utf-8?Q?3yPlyfj+GjZUFBg8RUJAtIpMI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2111f210-2dc4-4ff9-16a7-08dbdbf60b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 22:50:00.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLHRSnltPZb9BLa2GoupbpeaQSwUunuLZdrbD8dgADGZZcUevIbGLVPF2lz6eCJclbIi/0CneZu8qceGqDNfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGRvZXMgc2VlbSBhIHZhbGlkIGlzc3VlIGFuZCBteSBBY2sgcmVtYWlucy4gSSdtIGp1
c3QgcHV6emxlZCB3aHkgSSBkbyBub3QNCj4gZW5jb3VudGVyIHRoZSBzYW1lIHdhcm5pbmcuDQoN
ClJlaW5ldHRlLA0KDQpTb21lIG90aGVyIENPTkZJRyBvcHRpb24gY2hhbmdpbmcgQ0ZMQUdTPw0K
DQpIZXJlJ3Mgd2hhdCBJIGhhdmUgZm9yIGEgIm1ha2UgVj0xIFc9MSIgZm9yIGNvcmUubw0KDQoj
IENDICAgICAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUubw0KICBnY2MgLVdwLC1N
TUQsYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsLy5jb3JlLm8uZCAtbm9zdGRpbmMgLUkuL2Fy
Y2gveDg2L2luY2x1ZGUgLUkuL2FyY2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVkICAtSS4vaW5jbHVk
ZSAtSS4vYXJjaC94ODYvaW5jbHVkZS91YXBpIC1JLi9hcmNoL3g4Ni9pbmNsdWRlL2dlbmVyYXRl
ZC91YXBpIC1JLi9pbmNsdWRlL3VhcGkgLUkuL2luY2x1ZGUvZ2VuZXJhdGVkL3VhcGkgLWluY2x1
ZGUgLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLXZlcnNpb24uaCAtaW5jbHVkZSAuL2luY2x1ZGUv
bGludXgva2NvbmZpZy5oIC1pbmNsdWRlIC4vaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5o
IC1EX19LRVJORUxfXyAtZm1hY3JvLXByZWZpeC1tYXA9Li89IC1XdW5kZWYgLURLQlVJTERfRVhU
UkFfV0FSTjEgLXN0ZD1nbnUxMSAtZnNob3J0LXdjaGFyIC1mdW5zaWduZWQtY2hhciAtZm5vLWNv
bW1vbiAtZm5vLVBJRSAtZm5vLXN0cmljdC1hbGlhc2luZyAtbW5vLXNzZSAtbW5vLW1teCAtbW5v
LXNzZTIgLW1uby0zZG5vdyAtbW5vLWF2eCAtZmNmLXByb3RlY3Rpb249bm9uZSAtbTY0IC1mYWxp
Z24tanVtcHM9MSAtZmFsaWduLWxvb3BzPTEgLW1uby04MDM4NyAtbW5vLWZwLXJldC1pbi0zODcg
LW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9MyAtbXNraXAtcmF4LXNldHVwIC1tdHVuZT1nZW5l
cmljIC1tbm8tcmVkLXpvbmUgLW1jbW9kZWw9a2VybmVsIC1Xbm8tc2lnbi1jb21wYXJlIC1mbm8t
YXN5bmNocm9ub3VzLXVud2luZC10YWJsZXMgLW1pbmRpcmVjdC1icmFuY2g9dGh1bmstZXh0ZXJu
IC1taW5kaXJlY3QtYnJhbmNoLXJlZ2lzdGVyIC1taW5kaXJlY3QtYnJhbmNoLWNzLXByZWZpeCAt
bWZ1bmN0aW9uLXJldHVybj10aHVuay1leHRlcm4gLWZuby1qdW1wLXRhYmxlcyAtbWhhcmRlbi1z
bHM9YWxsIC1mcGF0Y2hhYmxlLWZ1bmN0aW9uLWVudHJ5PTE2LDE2IC1mbm8tZGVsZXRlLW51bGwt
cG9pbnRlci1jaGVja3MgLU8yIC1mbm8tYWxsb3ctc3RvcmUtZGF0YS1yYWNlcyAtZnN0YWNrLXBy
b3RlY3Rvci1zdHJvbmcgLWZ0cml2aWFsLWF1dG8tdmFyLWluaXQ9emVybyAtZm5vLXN0YWNrLWNs
YXNoLXByb3RlY3Rpb24gLXBnIC1tcmVjb3JkLW1jb3VudCAtbWZlbnRyeSAtRENDX1VTSU5HX0ZF
TlRSWSAtZmFsaWduLWZ1bmN0aW9ucz0xNiAtZnN0cmljdC1mbGV4LWFycmF5cz0zIC1mbm8tc3Ry
aWN0LW92ZXJmbG93IC1mbm8tc3RhY2stY2hlY2sgLWZjb25zZXJ2ZS1zdGFjayAtV2FsbCAtV3Vu
ZGVmIC1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb24gLVdlcnJvcj1pbXBsaWNp
dC1pbnQgLVdlcnJvcj1yZXR1cm4tdHlwZSAtV2Vycm9yPXN0cmljdC1wcm90b3R5cGVzIC1Xbm8t
Zm9ybWF0LXNlY3VyaXR5IC1Xbm8tdHJpZ3JhcGhzIC1Xbm8tZnJhbWUtYWRkcmVzcyAtV25vLWFk
ZHJlc3Mtb2YtcGFja2VkLW1lbWJlciAtV2ZyYW1lLWxhcmdlci10aGFuPTIwNDggLVduby1tYWlu
IC1Xbm8tdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgLVduby11bnVzZWQtY29uc3QtdmFyaWFibGUg
LVduby1kYW5nbGluZy1wb2ludGVyIC1XdmxhIC1Xbm8tcG9pbnRlci1zaWduIC1XY2FzdC1mdW5j
dGlvbi10eXBlIC1Xbm8tYXJyYXktYm91bmRzIC1Xbm8tYWxsb2Mtc2l6ZS1sYXJnZXItdGhhbiAt
V2ltcGxpY2l0LWZhbGx0aHJvdWdoPTUgLVdlcnJvcj1kYXRlLXRpbWUgLVdlcnJvcj1pbmNvbXBh
dGlibGUtcG9pbnRlci10eXBlcyAtV2Vycm9yPWRlc2lnbmF0ZWQtaW5pdCAtV2VudW0tY29udmVy
c2lvbiAtV2V4dHJhIC1XdW51c2VkIC1Xbm8tdW51c2VkLXBhcmFtZXRlciAtV21pc3NpbmctZGVj
bGFyYXRpb25zIC1XcmVzdHJpY3QgLVdtaXNzaW5nLWZvcm1hdC1hdHRyaWJ1dGUgLVdtaXNzaW5n
LXByb3RvdHlwZXMgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtV21pc3NpbmctaW5jbHVkZS1kaXJz
IC1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgLVd1bnVzZWQtY29uc3QtdmFyaWFibGUgLVdwYWNr
ZWQtbm90LWFsaWduZWQgLVdmb3JtYXQtb3ZlcmZsb3cgLVdmb3JtYXQtdHJ1bmNhdGlvbiAtV3N0
cmluZ29wLW92ZXJmbG93IC1Xc3RyaW5nb3AtdHJ1bmNhdGlvbiAtV25vLW1pc3NpbmctZmllbGQt
aW5pdGlhbGl6ZXJzIC1Xbm8tdHlwZS1saW1pdHMgLVduby1zaGlmdC1uZWdhdGl2ZS12YWx1ZSAt
V25vLW1heWJlLXVuaW5pdGlhbGl6ZWQgLVduby1zaWduLWNvbXBhcmUgLWcgICAgLURLQlVJTERf
TU9ERklMRT0nImFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlIicgLURLQlVJTERfQkFT
RU5BTUU9JyJjb3JlIicgLURLQlVJTERfTU9ETkFNRT0nImNvcmUiJyAtRF9fS0JVSUxEX01PRE5B
TUU9a21vZF9jb3JlIC1jIC1vIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLm8gYXJj
aC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYyAgIDsgLi90b29scy9vYmp0b29sL29ianRv
b2wgLS1oYWNrcz1qdW1wX2xhYmVsIC0taGFja3M9bm9pbnN0ciAtLWhhY2tzPXNreWxha2UgLS1v
cmMgLS1yZXRwb2xpbmUgLS1yZXRodW5rIC0tc2xzIC0tc3RhdGljLWNhbGwgLS11YWNjZXNzIC0t
cHJlZml4PTE2ICAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUubw0KYXJjaC94ODYv
a2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYzogSW4gZnVuY3Rpb24g4oCYY2FjaGVfYWxsb2NfaHN3
X3Byb2Jl4oCZOg0KYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYzoxMzk6MTY6IHdh
cm5pbmc6IHZhcmlhYmxlIOKAmGjigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0NCiAgMTM5IHwgICAgICAgICB1MzIgbCwgaCwgbWF4X2NibSA9IEJJVF9NQVNL
KDIwKSAtIDE7DQogICAgICB8ICAgICAgICAgICAgICAgIF4NCg0KRHJvcHBpbmcganVzdCB0aGUg
Ii1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUiIGZyb20gdGhhdCBiaWcgbWVzcyBkb2VzIG1ha2Ug
dGhlIHdhcm5pbmcgZGlzYXBwZWFyIGZvciBtZS4NCg0KQnV0IG1heWJlIHNvbWUgb3B0aW9uIGNh
biByZXN1bHQgaW4gdGhlIGFyZ3VtZW50IGxpc3QgYmVpbmcgYnVpbHQgaW4gYSBkaWZmZXJlbnQg
b3JkZXI/IEkgc2VlIHRoZXJlIGlzIGFuIGVhcmxpZXIgIiAtV25vLXVudXNlZC1idXQtc2V0LXZh
cmlhYmxlIg0KDQotVG9ueQ0K
