Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69CB8041CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjLDWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:43:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EEFBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701729838; x=1733265838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x7wd6x65mV5DJQQbZ6JunbUaHvgWfLr8cH+8GuKaS94=;
  b=UxcGrJZ6kT8Tfj1X4/3fzQB5COfTgCfQZIG3J9TJ+Z94hxZtF5iLoKT6
   hNHvqHdicMxGcYhii7FoDw3cl+iz5uQaiUqKA4GMjpvCihaYwfmUJDI6J
   wgLG5SjckUHzMrgLQruOEShp+ghIafEHlY0HiRfDU1LAC9A8wepHaICNK
   I9kUjObQ0f8j3ZPIMgrr1N5w6IcEFHCsNMx1fJGHj7GrpTTWXWR1P3NSz
   B/s2/ElKTPGHz5xtj04PCoZjHkTqr6F2LvMnqvKNRNLlgyOTDrGLLZhIw
   F8cstpkYuayI7mCAoFcPa/VUlw1YcKaysBN8f9pDqW19Nxa/bnw+SR38I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460301377"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460301377"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944036711"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="944036711"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 14:43:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 14:43:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 14:43:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 14:43:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 14:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn1/DY94Zc1YLP8k/L0nyr7GEQKSt5iKK5eoX4Di4rx6B+TNQ0TqdDST85MTPL6cL0zxszl2groI8Oe+qCNM3X2b54n1f1GLvGUwK6g2PIy/jXU56qSY2PAdj30PQVXBdCbWuHOKA42AdWFWpTiPohGi1HUSeTFGydZB1YxFIx6ZaIrLNNlD06rmBb0iBBntudu9uYF68GhrOkVZ22TKZDb17X8ybFshLSthlEh+kNuyRj0Qfvta83UTjX9r7Dtbi8lwH1sNmkrhtVTmrG85ekpuvuftpmcbX2T5/in8c2pAoApgIJJ2CUU0AmDDYaFhW3JOa9tEpne1sLRg3HRJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7wd6x65mV5DJQQbZ6JunbUaHvgWfLr8cH+8GuKaS94=;
 b=JCG3Ui0Z4GUe8wKYeucWtB1Ui8jm4K7vUwrhC5TeIRvkO0HI64uMg6PNKqBxJxhTn9FO3rudgfU30YndmeUc5FwYbvz8Hz31S/ZmjGO3d17oVs/hedW7euGOAne+6akRGmOxKHbwh+Ac0d9V7HpeQWm/058Su39aKgBN4VDDoTiUyIJMH8QhUO6p6nT2gdOJmgPbUzIyocxQyIKIfCLEPLk6gvyTlCk4i/OmjEm5oXN2sw82Q8rqMWmJpf0mRLjaddR7FpfKz0yE5/H27jO+8uS1g4V49mu8Et6+T6kKwFSxlSKSPGx47jCh23sVSWtZAeCeuZutEK7VF0YKHS+MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:43:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:43:45 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaF7uAoLPWjNmQzEmSsNIC3961FrCHshEAgAz8r4CABShugA==
Date:   Mon, 4 Dec 2023 22:43:45 +0000
Message-ID: <5642b6cb66d4a1ecad87155d7635ab6b1fab60d2.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-15-kirill.shutemov@linux.intel.com>
         <7012ba92206efaa6f0a0a2e1a28355d67d55265a.camel@intel.com>
         <20231201155739.rxo6l5om6mdw54rs@box.shutemov.name>
In-Reply-To: <20231201155739.rxo6l5om6mdw54rs@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: 60e1c2e8-a60f-418a-d9ae-08dbf51a78f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEA6+CFUvQdKhTS9IvVcjLAk2jZqEMuRL2OdgPc0WJfAMNepSTI2cn90U4+lPaA+P4gM3X1I+5i2WiQsRa/TM/1DCVOVgKgU3Jc0r10eu2KxRU+SkmxYTRuV52ke6rqSAUEcCMBwgZ1uL/z4xf22mCF1a16fkl7lPmywvQS8owbAmtVssstogKkW3+0+ym9SxN3y4i/cfT09b0c0+vglm2nvQ+b8VbaqmmkDSOUCjqF78zX8YszxyM96sBF2oi0Vs3X0jFZO7HpVp9gHaNg7+QjS2EkPew33KF7oHG29oCA76nLdalhLl1FX2YE1Qha0OlYcY6C+51Z5neXoM2QC9cSo9x6sbTSvwueVGKtgGxWltcecwx1pJhv+v357nRQ7P4mcwq1OhdLO++6F/ubF2/RNE56KXbSszELoeDsSCAP2h15ZanbFrb1AnHoDKCds/LlFFyRRuIxMDbJoI/lVrqii/bR0eon8xdNnREJgR3O+Wb06oAuUlS198kcACU7/e+Evkk515FXeKQp5T2Ma/VyJXyjna82sK8EKcBvPtzMepuaKH6oGRnUhv+Kjc3kb3Je9i5V0Oyn9/D+mZY0bE8ORg9r3UmIzNrLgmD/KzZGznr1afUZZwn5JGeCvXigC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(26005)(2616005)(38100700002)(6506007)(6512007)(122000001)(71200400001)(478600001)(6486002)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(54906003)(6916009)(91956017)(316002)(8936002)(8676002)(4326008)(2906002)(38070700009)(41300700001)(36756003)(86362001)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVE5UjkxQXgveTRMeEtON3plT2dZMHhteW9KQzMwdGs2cXhLNUVyaFlBMExF?=
 =?utf-8?B?K3NzOENYemsvTFpoVlpkMGRZWXZxVHJ3QnM2V3FjdlFBdzhJRTd3RlBJc1M1?=
 =?utf-8?B?NTRrR05zUXhsbUNUaGZNYnpIa1BKaWczQ2NlYzBvMkRWMm9VakpmSzhwRWkw?=
 =?utf-8?B?K1FrMjNwMmlrRXp5R2JHTElDSW9zdTJKSG10ZkMzN2J5UmEzOS9GNmhlM3d4?=
 =?utf-8?B?Y2NkbDhQLzVkK1oyTHRnK1REM2RMWVovS1NyZVgxTmF6dHNPVDVZNitpMnBD?=
 =?utf-8?B?SHorbjJzNWxPT1drdzJHd05qRW1RRzhxRFFwYy9VeDdOS21aM2E2a1B1R015?=
 =?utf-8?B?V2xJaGNHMzR4TmhOaGw2MkZYR3haeVdxaTEzRDNsY1FZa2wvblhhQ0VaV3ZU?=
 =?utf-8?B?Y1dta0RFYU1pelVjanNLQ204cklMTVRGVGZWZWxQNVJucXltcjdFM282K3RR?=
 =?utf-8?B?d3cxYmdjRmVjb0pPV3FJMWJScXJkaHROSVNQNzE2ajE4eitYRzFBV2tZb1VE?=
 =?utf-8?B?dWdqRFg0NkxWR3hYclF1MUNKVHpnL1R6ZndIRnlrUW1MNDQ2WmdoNU5Sa1dQ?=
 =?utf-8?B?aDZmbDZJaWJKM0NxTElXY1IwdVVvT1RKRTFkL1YvK0lHdGNmazFTSEJIcVNw?=
 =?utf-8?B?MkFJeTlTelNhVW9vMHVXenZ0ZFlsRXNFWk1XUkt2TGpxWVhtaEsrYXNNS2hO?=
 =?utf-8?B?c2k0azFCclZob05MY1RmY0JTdmpLT1Ziam1UNUFyeDhOSjhUdE9qbElJcnVN?=
 =?utf-8?B?ZGxvTU1ONm9KRFlhZHFscWFSTS9mSEVZdDlKb2lWdmRZRVBrSTV1SUt6c3R0?=
 =?utf-8?B?aHFHTFE3ZXN3QTB5VVFnNm5OZ0ZtbzM3bW5pclFuUzZ6S2Z0b21paXVXV0Yr?=
 =?utf-8?B?LzRIRStYOG1IeUEzTS81cHFEZmtnZkRwS0JBdTlUK2ZEc2c0OWF3WWZXbFFM?=
 =?utf-8?B?Q0xnR3dlZ21oejUrY3ROVlhPU09sa0hVVGxzbGZYYWg1bTdTdnhPOWIzS3dW?=
 =?utf-8?B?N2h6ZHJKMFRzTEVINHdtWFFUTERMakcvV2FxRG8vZlpKVEFLOVY5QXg4SXdK?=
 =?utf-8?B?US9ya1lpclVIemtxZ0gwM3FMZ3NEcG90ekF6SllJVE5uUVR3OGF2dDFmRm94?=
 =?utf-8?B?OWw1OFpOSTd0SGh4WlArMy9OSit0MXIzaWFxNm9zeUhFTTVRbTdjRjVORXZE?=
 =?utf-8?B?dVdKSGsvNnZFV2FHVkl3OHcvYkoybS85b2l2aTVxQXA0Vko3bXRIa3BiSWNn?=
 =?utf-8?B?cWtuRzlBT0ljVHJmemxvMXk5WjhNWmExV1YxbHVaYTgzUUcrWndTeWlheWVT?=
 =?utf-8?B?cXB1V3hkU0lIbGNXOUhYWVNtWFdqTVVtV2RJVndKaDNVYUlxQ1huSDNwekdr?=
 =?utf-8?B?eTFGS0ltUE1LTTNKaGp3dldPT2NTeEI4Ny9qR2VWb041WWFiaFlVL2FBRkdl?=
 =?utf-8?B?dUdPM1JTZWQxTDcyTWRyaTFNSnZ0NDcxK3k3ZTVRaVVUYmh3bUlkWHFEem1a?=
 =?utf-8?B?NHVlTXdRUU10SjFxWDJyaG1UNjJIYUlVellPZ1djZDNtNUltQ2ZTM2FQTmtX?=
 =?utf-8?B?ZytrNjlmY0RqMWFaeEJSSjdKTGt4ZVlCLzUzekN6YVhjcnZQZWQwWDdudmFz?=
 =?utf-8?B?TFVFZndtcEptbWRFV3FENVlXNHVHVVpoQjluaFVGajBZcUlWNkYvMExRM01q?=
 =?utf-8?B?OUgzVEVveDExbHFKazVmM0lOaDFOY3FDWmJtYkI4alRxY1RFV2hnRUhYbFdR?=
 =?utf-8?B?YnY3dmNBQ1djMzVSZklKbmNmQnAzaEZBSnZRbW53SExzUWROY0twU3dFNXVm?=
 =?utf-8?B?SXJnOGNlYUwrdUxaYjlLRHQyaXgrZHNudkl2NVNVNmpUaUFMc0U5SGZnWkoz?=
 =?utf-8?B?VE1uK0ZxdnFnTEUydlMwZmwrUk9VbFJ5b1hWdE9uanZVR3hVa3BldXNZVFly?=
 =?utf-8?B?NWt1dUtQUHJLQ1VwTlBRaXFNWVFuTTM2R2JXYlo3RERTaWw2aDZNT1ZnY3ZM?=
 =?utf-8?B?UkJncUlUYXprQnlsVDEwMlRRVzZHRzJjb3g0Z1E4cDVXcGdva1dzdlBBSi9y?=
 =?utf-8?B?bnc4UnV0VWlNMDRuc2pYc1VPYTNwRWtXOERGeStDVnN5YXZ5MURMdHVrTVFD?=
 =?utf-8?B?TmFFekM1eXowV1RrUEU0MFdVVGNoRDBqLy9FN3R4cy9qbmZEUUhXdk9ZaWNY?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77C0F8492DC6D04DB24842D08C96735D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1c2e8-a60f-418a-d9ae-08dbf51a78f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 22:43:45.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZLdW+T7ZliMjD+L+5OoJ/a4ai4DTwev30yFykgvl7YdsHcqCiqjUD+QVZ4XNWYxVAmErJAK8//MILSzjMlVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
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

PiANCj4gPiA+ICsNCj4gPiA+ICBpbnQgX19pbml0IGFjcGlfcGFyc2VfbXBfd2FrZSh1bmlvbiBh
Y3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhlYWRlciwNCj4gPiA+ICAJCQkgICAgICBjb25zdCB1bnNp
Z25lZCBsb25nIGVuZCkNCj4gPiA+ICB7DQo+ID4gPiAgCXN0cnVjdCBhY3BpX21hZHRfbXVsdGlw
cm9jX3dha2V1cCAqbXBfd2FrZTsNCj4gPiA+ICANCj4gPiA+ICAJbXBfd2FrZSA9IChzdHJ1Y3Qg
YWNwaV9tYWR0X211bHRpcHJvY193YWtldXAgKiloZWFkZXI7DQo+ID4gPiAtCWlmIChCQURfTUFE
VF9FTlRSWShtcF93YWtlLCBlbmQpKQ0KPiA+ID4gKwlpZiAoIW1wX3dha2UpDQo+ID4gPiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiANCj4gPiBJIHRoaW5rIHlvdSBjYW4ga2VlcCB0aGUgQkFEX01B
RFRfRU5UUlkoKSBjaGVjayBhcyBhIHN0YW5kYXJkIGNoZWNrLCBhbmQgLi4uDQo+IA0KPiBOby4g
QkFEX01BRFRfRU5UUlkoKSB3aWxsIGZhaWwgaWYgdGhlIHN0cnVjdCB2ZXJzaW9uIGlzIFYwIGJl
Y2F1c2UgdGhlDQo+IHNpemUgd2lsbCBiZSBzbWFsbGVyIHRoYW4gc2l6ZW9mKHN0cnVjdCBhY3Bp
X21hZHRfbXVsdGlwcm9jX3dha2V1cCkuDQoNCkFoIE9LLiAgTWF5YmUgd29ydGggYSBjb21tZW50
IGxpa2UgYmVsb3c/DQoNCg0KCS8qDQoJICogQ2Fubm90IHVzZSB0aGUgc3RhbmRhcmQgQkFEX01B
RFRfRU5UUlkoKSB0byBzYW5pdHkgY2hlY2sgdGhlDQpAbXBfd2FrZQ0KCSAqIGVudHJ5LiAgJ3Np
emVvZiAoc3RydWN0IGFjcGlfbWFkdF9tdWx0aXByb2Nfd2FrZXVwKScgY2FuIGJlIGxhcmdlcg0K
CSAqIHRoYW4gdGhlIGFjdHVhbCBzaXplIG9mIHRoZSBNUCB3YWtldXAgZW50cnkgaW4gQUNQSSB0
YWJsZSBiZWNhdXNlDQp0aGUNCgkgKiAncmVzZXRfdmVjdG9yJyBpcyBvbmx5IGF2YWlsYWJsZSBp
biB0aGUgVjIgTVAgd2FrZXVwIHN0cnVjdHVyZS4NCgkgKi8NCg0KDQpbLi4uXQ0KDQo+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcmVib290
LmMNCj4gQEAgLTg3OCwxMCArODc4LDE0IEBAIHN0YXRpYyBpbnQgY3Jhc2hfbm1pX2NhbGxiYWNr
KHVuc2lnbmVkIGludCB2YWwsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiAgCWNwdV9lbWVyZ2Vu
Y3lfZGlzYWJsZV92aXJ0dWFsaXphdGlvbigpOw0KPiAgDQo+ICAJYXRvbWljX2RlYygmd2FpdGlu
Z19mb3JfY3Jhc2hfaXBpKTsNCj4gLQkvKiBBc3N1bWUgaGx0IHdvcmtzICovDQo+IC0JaGFsdCgp
Ow0KPiAtCWZvciAoOzspDQo+IC0JCWNwdV9yZWxheCgpOw0KPiArDQo+ICsJaWYgKHNtcF9vcHMu
Y3Jhc2hfcGxheV9kZWFkKSB7DQo+ICsJICAgIHNtcF9vcHMuY3Jhc2hfcGxheV9kZWFkKCk7DQo+
ICsJfSBlbHNlIHsNCj4gKwkJaGFsdCgpOw0KPiArCQlmb3IgKDs7KQ0KPiArCQkJY3B1X3JlbGF4
KCk7DQo+ICsJfQ0KPiAgDQoNCkFncmVlIHRoaXMgaXMgYmV0dGVyIHRoYW4gZXhwbGljaXRseSBj
aGVja2luZyBURFggZ3Vlc3QuIDotKQ0K
