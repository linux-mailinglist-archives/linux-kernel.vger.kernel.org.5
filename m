Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7A793272
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbjIEXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjIEXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:21:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DCCDC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693956100; x=1725492100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VF1wUVX3ZvL4ACnQV70PMdhhGokTpEaQf2TOA5AmWRg=;
  b=Wc50Dg9hkSngdiFV9yGqwGXqZok9ft6Dl30/pCMBkNv3Ckip5/dg/fmA
   RcjcPju7pELhcpo+DIUQzyo0SGkp4KlGjGfloy6icdvXz5KUr3RRlpGIu
   IeN+CR/VhS9RxdMcmIpXUpbgOayf3iphd8GoEB20NI/0vWkOYTCzWExzb
   AeVzJEIvUjftGM8vLX4wGvlidCW62f/StL2Krc2Ee/tz9OZvGjPA3Dp7s
   eqAIlH3uksfqkQTApq3tHXmBbO3euG4OPigl1bvEActTXBs8YGEms/v27
   mmTjbuY0LIucaRMu6jOzaNPHbatANeSx+ZdaQ7Zo8B6SmDe5Xs7NtroWV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374317603"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="374317603"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864933592"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="864933592"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 16:21:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:21:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:21:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 16:21:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 16:21:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4n0kqRnY0iUAULu2JTlvpbm3EiBrXeBgPnT1bHMm1iHOj1JX1bsF9eVvmmBw4pG/dxaBk6W+SrHj65kU4xsYinmkGPn051jbigbmwvQjgVLByU7taOUKvw763bsTqedS17pZS8CHS5Qh07n9ImnKY+NenuxBCI23WHpuv5v4rGtoo3eN6jPsG+M7yPf/CtvvTe189KF8q3Ln6USN7icio3wd+Z9yR3XEZUPkwV09apSxY+FGQ6qWqumjgUf7sGBq2jHjmbAsgge7INbFyqFzsWPiH1SxV12wPicjyhjWCxdAnhuqbuBx0Jaw8v2zpqw+UdM8S5GxZE9w65QGY2xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF1wUVX3ZvL4ACnQV70PMdhhGokTpEaQf2TOA5AmWRg=;
 b=jBelMB1ng1f0EzWQWljlzrEHtQpRB8AnvwQahpg9ncsQutbrN9CgyBqzLCSrZzBJkRE7E7POWIW6PbbkhBtqns6WQFlgvvKNHFVtmNfK8kMHDO60FvpY02cTpSkB1j9gS2ccd9rEvOW+MCBVfAOw9mxYI/bVGql8+mMr0ck9B4rgb3g12quXdgL4fg+GFG8EoDxV3JfbwefGAN8SZHeUp+bcvoqpZfgNEFgZqOMrPI34ffjEv8QD6t58P1kW/GOe52NMmK9zTfn7WbuVVaxgnM5TWzUQyUf2XsNaSxo6zJLC3JFkFtsDKw+DuV5keHjUrzr+2TllbJdRb5Yx0uISuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 23:21:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 23:21:28 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Thread-Topic: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Thread-Index: AQHZ23juqM3HPepUpkiDz/Fyv97nIbAGGhqAgAAUWICAA8XKgIAADAIAgALoMIA=
Date:   Tue, 5 Sep 2023 23:21:28 +0000
Message-ID: <c3c17f12b30eb05d76fbea533b22324c9e536781.camel@intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
         <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
         <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
         <64f2137362305_4c1f3294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
         <4ff19f7c31b13a63756f40de69fbf8a24fe3bb08.camel@intel.com>
         <f859d123-6c85-4bc4-8ac9-8761f1f3f602@linux.intel.com>
In-Reply-To: <f859d123-6c85-4bc4-8ac9-8761f1f3f602@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: 0897f2e5-2f5e-48a1-6660-08dbae66d4d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvZqpkpknmliarKuhdPP03NHIJWcpfEuoFbioFXynDuh5oPGsKttAlS9rlCEF9dBb7IKgFhKHVh+aGpift4DsMb5AqS4OH9SD8Jm6thRKjL+w7qoxA+DIr8LujNNFk/N/ywUsUiITqfTuH19LKXcvNzmAvzGIZvDWCcSE1gVD6UcYdtcMLc8sicb9xePZMkCEd+0S9LLAthxqHgaF/jdHXs4kWI4DjJShGY0HngRyr/lQSuMrmNrMizOY6EKQ/DsXEjtCZHBDQtOraUvPA+zcauW/oSMHT0hWTQl3b086mvFgZwZL8oU7UCN7OnA24xP6gIXJvFlKV1arqaLQ09VH9CiBPvv+LRe9gaVmNn10zn9RbSWBQ9bW0E3WAhyTYBQVV4VpWSJlTP4GoWLqKQx4UkazwFsCg4DlV0kdQrDAGOS/+k9OZ/dphqt7J/iWzKIfC9DXfRZpdhgk8vjECMlN6ToIqvc8/1KC/oC41pNJKEYVUhljC5CFFtq9hiayzipkQ/K9KLeIaSGlj+YYQEVVA6gnREWCD54Fa3WUnyo0feQG7dnPv+HwB+sptE4dBsVwOdwaT9vOacs1LcGuIi0WDqN4/6BNK54V97zeAT7COc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(38070700005)(82960400001)(38100700002)(36756003)(86362001)(122000001)(6506007)(6512007)(41300700001)(53546011)(316002)(66446008)(54906003)(6486002)(64756008)(66476007)(110136005)(66556008)(91956017)(66946007)(76116006)(2616005)(4326008)(8676002)(8936002)(966005)(478600001)(71200400001)(7416002)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2ZweVdUS0dKVjB5QUw3UkRNcytmMTdJVURYbjQ5Q0pqbWNYaGg3dmd3c0VE?=
 =?utf-8?B?K3JKUjU5VlJaSDJMUzEzSVFxckJLMmRBNlRQSHhEck1XcGRKelhDMDJmb1RY?=
 =?utf-8?B?NTVGaGN2eEsySTIrdHdmZVVtRFgvSkx0TUVIbmNiaE1icEJyZE5ubUZacTRx?=
 =?utf-8?B?cjQ1aDRyQzlRZ3ZvODlEdDJjSEcydjRlOXF3Z0xvYmF3QnZIc1BtZ2xYZ21U?=
 =?utf-8?B?ZjFuMlFLNTFzNTRXbEZhYzRRZFBmbjN6anhxSHJuNkxlNjVkbWU4bnEybVJX?=
 =?utf-8?B?SkcrYTFDRkpqUklWYW1Jbm5kQnR4ekYraDlOaHRlUzRHdGozZFVrWTVHUmlT?=
 =?utf-8?B?TkVkdkZNR29OZ216OXF0L0JoNHNqL29WazNhcjd4VDArbUZ5dm4xLzE2U0hv?=
 =?utf-8?B?NXNuM0pGVnJyNDMrR09CcTR5emduWVBTNnlVWXdZSHo3dTI0M25qUzRiN2Zh?=
 =?utf-8?B?d3JlZHBDUFNXZzdpOTR3N0Vyb24xNHpVYVRhVXVyZGY2a1hnU1NIOVBlV0Ni?=
 =?utf-8?B?bHdZQ2RRWUlZZUdzaXdoM3B1YXYwek5LSUprOHVhRW5lMDlTV1J1a2YxajZN?=
 =?utf-8?B?bFlBVGRReU5IS3ZJQ25mRU4xWEhVdENmOW9TY0VGWEw2SHVEZFdlZ3gxUFVl?=
 =?utf-8?B?K0JMbXNBdEtpaGxtRHVQcUJKVE81TUlkTGt6L1d2ckpJZExPZ1BTM1R1dXJQ?=
 =?utf-8?B?d01HNXBsczR5NFcwU3gwTWNEL1N6MjNUakxYRmpHMk1sUURXUTh6dmZCMnhM?=
 =?utf-8?B?NFhSNndVNG5ZdFE2SGpWODNSN3BLaWNYdDcwWlIwdDdPU2VVM3F3eVlPZE14?=
 =?utf-8?B?MTBES1Mzc3JDVUcvZjZSRzNnTGFEV2ZxdDB1ZlBGUC93bXdsTE1BN0I1eXp0?=
 =?utf-8?B?WUhjYVljZWhDOXlMdDdrNFV3UW9HUHZmRmY2OVJaSmVzNlZpYzh0VHpXUEdi?=
 =?utf-8?B?UFZIMFhiYTUwRHlObkxyYUhQQloxK1M0ME5ta2VLME9oSlpRcndYaHJNZFlL?=
 =?utf-8?B?YlNsVE9GTkdIZjZYRTg4NGNBMUhZR0c1RTNucDF5NVdFR2NvdUFKLzBkYmp2?=
 =?utf-8?B?bmxub0JyQUxtM0lJQzFvRmhURllZcythWGZZZCtJWmxwZGhxUXZ4Z0dLWHpR?=
 =?utf-8?B?amN2SFYvNGNXU2s0TTBhajcvZFlqVHoyd3ZPcUVuSE04THdGSmtMb25GcHJm?=
 =?utf-8?B?QkpCNi9MdXQ1eFgrakd2ekNvNUVWWXZFRGt2TUxod2RaMXU5cE1TYmcwM3pD?=
 =?utf-8?B?a3YyS2F5Wm14YVhCM2JBaG41ajNJZnhCOC9FSFN0bzdPK2ZBelhubTZQKzU0?=
 =?utf-8?B?eGw4ZmdnQWFBQUJnN2lBR2owb0EvQXJRaFBOZUZHdk5seEdhc0xPcUdJdmNm?=
 =?utf-8?B?SWRySHdhZHozMzVXN3lPbjZkN0FKSHVjRUZoRGphUVN1OWZLbWQ5U29NWUVH?=
 =?utf-8?B?cnpWUEhtUUk5SDQxSnNUcDBINEdWRHRFc090dm5JUFpab1FpTTNDemx4TjRw?=
 =?utf-8?B?cWpzQkJKbW9ZdE9YSXlrbjg3OGZjc2hSNzJHYXEzdU9ETGJHdmo3Q3FmNUk2?=
 =?utf-8?B?aEpzZnZ6Q2tuTmc4NnhYQzNGMFcxWjNzelpoSVVxZUlhVStqcjlYeEE3dlhF?=
 =?utf-8?B?ZmlNMmsrSHhKays3Q0tOQlFBQzRUbmVYU1pXai85NHRkN2lyc0Zpb0RIRWVG?=
 =?utf-8?B?U25DZUlSRDRvSW1lMWlCMWhEOTFCV2Rvdk4rMktCakwva2NDeEhZcjFFQ3dW?=
 =?utf-8?B?TVZ5VVBTTEkwK0VpMTFvY3U4OVgxcHMydnlpRjh0T3N0aFR3dUZINlFTQjBK?=
 =?utf-8?B?cnAvZjM5aDZIaGhsVUdUTG5HSHQ5V1ZHZ2JLVTNBQzdwN1NhVkNNS0Q3bFlU?=
 =?utf-8?B?TjVrODlnSlJaeTJ3VUdDOVRweXBHSFBRMVUwMFBManRJMzVLdG5QaGhDMHZt?=
 =?utf-8?B?V20zNjN1QlNiL0RCdkg2NnRNK05JOEtCZkoxRjRaOXJnR3BrRnQvVVJpTFdZ?=
 =?utf-8?B?ejgvZmhUdzE4R0ZSSEdLbm9XZHZZcEk4d3dCbHZuTjM2TmtTZVZiSEhIRTFz?=
 =?utf-8?B?WWk3OThxclBHb2dodHNKS0hCMjRaTldLT3l2cC90emZGVjNHd1BwWVlrSGUw?=
 =?utf-8?Q?7PYtxW7Av81BsXeup+R65Im5s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D80058FB725644FA7A40DCD9FBC74B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897f2e5-2f5e-48a1-6660-08dbae66d4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 23:21:28.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fK7L858k23TswtW6veSaACkgNtZ6fXrEgYunVBKySr6VBY6cnudOOgCvFdx4/fxvd/ZLh9n+YNA1bRaaq6v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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

T24gU3VuLCAyMDIzLTA5LTAzIGF0IDE5OjU3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gDQo+IE9uIDkvMy8yMDIzIDc6MTQgUE0sIEh1YW5nLCBLYWkgd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDIzLTA5LTAxIGF0IDA5OjM4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3Jv
dGU6DQo+ID4gPiA+IFRoZSBleHRlbmRlZCBndWVzdCByZXF1ZXN0IGlzIGFub3RoZXIgdG9waWMs
IHNpbmNlIHVzZXJzcGFjZSBoYXMgdG8gYmUgYXdhcmUgb2YNCj4gPiA+ID4gd2hlcmUgdGhlIGtl
cm5lbCBjaG9zZXMgdG8gcHV0IHRoZSBleHRlbmRlZCBkYXRhLCBhbmQgZml4dXAgYWxsIHRoZSBv
ZmZzZXRzIGluIHRoZQ0KPiA+ID4gPiB0YWJsZSAoc2VjdGlvbiA0LjEuOC4xIGluIFsyXSkuIEl0
IHdvdWxkIGJlIGJldHRlciB0byByZXR1cm4gdGhpcyBkYXRhIHRocm91Z2ggYQ0KPiA+ID4gPiBz
ZXBhcmF0ZSBmaWxlLg0KPiA+ID4gDQo+ID4gPiBJIG5vdGljZSB0aGF0IHRoZSBURFggcmVwb3J0
IGFsc28gaW5jbHVkZXMgYSBjZXJ0aWZpY2F0ZSBibG9iLCBzbyBpZg0KPiA+ID4gdGhhdCBpcyBh
IGNvbW1vbiBjb25jZXB0IHRoZW4geWVzLCBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIGEgc2VwYXJh
dGUNCj4gPiA+IGZpbGUgZm9yIHRoYXQuDQo+ID4gDQo+ID4gKyBTYXRoeSBhbmQgSXNha3UuDQo+
ID4gDQo+ID4gSXQgaXMgYSBjb21tb24gY29uY2VwdCBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiAi
Y29uY2VwdCIsIGJlY2F1c2Ugd2UgbmVlZA0KPiA+IGNlcnRpZmljYXRlcyB0byB2ZXJpZnkgdGhl
IGF0dGVzdGF0aW9uIGJsb2IgYW55d2F5LiAgQnV0IGluIGltcGxlbWVudGF0aW9uLA0KPiA+IHVu
bGlrZSB0byBTRVYsIFREWCBkb2Vzbid0IGhhdmUgYSBjb21tYW5kIHRvIHJldHVybiBjZXJ0aWZp
Y2F0ZXMgc2VwYXJhdGVseSBvcg0KPiA+IGluZGVwZW5kZW50bHkgWzFdIC0tIHRoZXkgYXJlIGVt
YmVkIHRvIHRoZSBRdW90ZSBpdHNlbGYsIG9yIHRoZW9yZXRpY2FsbHkgY2FuIGJlDQo+ID4gZmV0
Y2hlZCBmcm9tIEludGVsLsKgIA0KPiA+IA0KPiA+IE1vcmUsIGZvciBURFggKFNHWCBiYXNlZCBh
dHRlc3RhdGlvbikgY2VydGlmaWNhdGVzIGJsb2IgaXRzZWxmIGlzbid0IG1hbmRhdG9yeQ0KPiA+
IHRvIGJlIHBhcnQgb2YgdGhlIFF1b3RlLiAgSW5zdGVhZCwgVERYIFF1b3RlIGNhbiBjaG9vc2Ug
dG8gaW5jbHVkZSBzb21lIG1vcmUNCj4gPiBiYXNpYyBwbGF0Zm9ybSBpZGVudGlmaWNhdGlvbiB3
aGljaCBjYW4gaW4gdHVybiBiZSB1c2VkIHRvIGdldCB0aG9zZQ0KPiA+IGNlcnRpZmljYXRlcyBm
cm9tIEludGVsJ3MgcHJvdmlzaW9uaW5nIGNlcnRpZmljYXRlIHNlcnZpY2UgWzJdLg0KPiA+IA0K
PiA+IFsxXSBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgd2UgY2FuIGFkZCBvbmUgb3IgYWxyZWFkeSBo
YXZlIG9uZSBpbiB0aGUgbGF0ZXN0IFREWA0KPiA+IGRldmVsb3BtZW50LiAgTWF5YmUgU2F0aHkg
b3IgSXNha3UgY2FuIGhlbHAgdG8gY29uZmlybS4NCj4gPiANCj4gPiBbMl06wqBUYWJsZSA5OiBR
RSBDZXJ0aWZpY2F0aW9uIERhdGENCj4gPiBodHRwczovL2Rvd25sb2FkLjAxLm9yZy9pbnRlbC1z
Z3gvZGNhcC0xLjAuMS9kb2NzL0ludGVsX1NHWF9FQ0RTQV9RdW90ZUdlblJlZmVyZW5jZV9EQ0FQ
X0FQSV9MaW51eF8xLjAuMS5wZGYNCj4gDQo+IFllcy4gVERYIGRvZXMgbm90IGhhdmUgYW55IHNw
ZWNpYWwgY29tbWFuZCB0byBmZXRjaCB0aGUgY2VydGlmaWNhdGUgYmxvYg0KPiBzZXBhcmF0ZWx5
LiBDdXJyZW50bHksIGl0IGlzIGZldGNoZWQgYXMgcGFydCBvZiBRdW90ZSBkYXRhLiBCdXQsIHNp
bmNlIHRoZQ0KPiBjZXJ0aWZpY2F0ZSBibG9iIGlzIGZpeGVkIHBlciBib290ICh1bmxpa2UgUXVv
dGUgZGF0YSksIEkgdGhpbmsgaXQgbWFrZXMNCj4gc2Vuc2UgdG8gYWRkIGEgc2VwYXJhdGUgY29t
bWFuZCBmb3IgaXQuDQo+IA0KDQpJIHRob3VnaHQgYWJvdXQgdGhpcyBmb3IgYSB3aGlsZSwgYnV0
IEkgdGhpbmsgd2UgcHJvYmFibHkgZG9uJ3QgaGF2ZSBlbm91Z2gNCmp1c3RpZmljYXRpb24gdG8g
ZG8gc28uICBJbnRlbCBhdHRlc3RhdGlvbiB1c2Vyc3BhY2Ugc3RhY2sgaGFzIGFscmVhZHkgZnVs
bHkNCmFkb3B0ZWQgcGFyc2luZyBRdW90ZSB3aXRoIHRoZSBjZXJ0aWZpY2F0ZXMgYmxvYiwgc28g
SSBndWVzcyB0aGV5IGp1c3QgZG9uJ3QNCmhhdmUgbW90aXZhdGlvbiB0byB1c2UgdGhlIG5ldyBp
bnRlcmZhY2UuDQoNCkhvd2V2ZXIgcGVyaGFwcyB0aGlzIHNob3VsZG4ndCBiZSBhIHN0cm9uZyBm
YWN0b3IgdG8gaW1wYWN0IHdoZXRoZXIga2VybmVsDQpzaG91bGQgcHJvdmlkZSBhIHNlcGFyYXRl
IGZpbGUgZm9yIGNlcnRpZmljYXRlcyBibG9iIChvciBleHRlbmRlZCBkYXRhIGluDQpnZW5lcmFs
KS4gSWYgc29tZSB2ZW5kb3IgZG9lc24ndCBzdXBwb3J0IHN1Y2ggb3BlcmF0aW9uLCBJIHN1cHBv
c2Ugd2UgY2FuIGp1c3QNCnJldHVybiBlcnJvciB3aGVuIHVzZXJzcGFjZSBhY2Nlc3NlcyB0aGF0
IGZpbGUuDQo=
