Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CF75BB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGUAcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGUAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:32:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63807E0;
        Thu, 20 Jul 2023 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689899549; x=1721435549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U5ubeNq+7GSkHBTzuLAFS9GHW1S+bKKg8NakWmW5yiU=;
  b=G/pWVc9U6P/ge+U4PkBgRXOOSSPTiZzc3qiuKxRHzanCEwXXSUDkWk1p
   ZhIRqhakeeOIR04FgE5bao/iz4NI0x8x1hCdYM7fXGYziRtOsg14c8ZWz
   Md8gzbV5Blp1JbDaSrzt46rlBSBQb7+b4PDsFY3yeM3tOruREZsxR22Aq
   KkxO5TLiuuvS53yCAUk0BZEqwTy4q66D5eO2fNWyDHhX1rw0djMOKQYsa
   LLPEQ84GBdnPG68Lu63Bywl6EIWtdQqDvvvQjbqlOJiI88WDBjaDqmWkP
   yj+vPv7AejHrdn3KaFDozYA1KOnjwkcqut24pBQE5H3F5xtLwwydV4s7f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346493451"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346493451"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898530130"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898530130"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 17:32:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:32:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:32:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 17:32:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 17:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crmIiIJOfx3wi/Jvf5kwJbZne0Wv4+VRE2LxeIu3fGB6WZl2vzGJh9jlogZ++QCkcfSnR/jKBkM1Y2o7+ZX+i8mI3EbiR5o/7enTndr5/7QczOcXpZOLBuujq/ZNABGU9oYZBkV29DbUPgYHBzaOptg8v+hVtFdcr3hwnHuqv4Mtqsw0NalSYsELlqxCdYTyLfnOl99W5F6Yk8/iN3IjNnYyo/TypPpCXP5THbZzsKvsiUHcI/fv9Z0+NvUGU8laKZXkqn4lBJozmEhIROGNIUr5Yyb2PAJ0+AqgbNGmBzXx4BUfaJMpit6KUcG1TiiJficq9BoZQVAm7Q0zrhF58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5ubeNq+7GSkHBTzuLAFS9GHW1S+bKKg8NakWmW5yiU=;
 b=bbWL5R/rZaVfmgdV3y/rbuAWRucp3J3Ne8F019qgLRgyPatN4y07oiWuIG0iDlYfA+nJemvsqVUPsA7jwskaS6UQsE9H7HVk+PIGqPa0UWj9I0w/3DoRtRQuuBMFmcNs1PgX0DBMzEdL5UtNDN1N3UZt0UnWlUm5tlAfTN554W233W1uR1BAdrnxaIDntsB2zmUUTHLZdtgmsC9MNtgpVZt9tii7U8xCo7/+HFo4sVFXGQK0Nv8h1zqtgc20QcAXXRduu+n2dXtWD/54IHbI62uwnrlDBp/JgmNyiMuNh5Em8JPaQ8PmcC8r85jd1Cup7aaMnZbZjRnvMbMcw9T+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 00:32:23 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4345:8c8a:ed91:57c5]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4345:8c8a:ed91:57c5%6]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 00:32:23 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Thread-Topic: [PATCH] x86/sgx: fix a NULL pointer
Thread-Index: AQHZuNr+gc+uEEAR2keHYngpqSvf+a++Tj+AgAAAPwCAABqcAIABLT6AgAA+hgCAAAvJgIAAG3mAgAAGzYCAAAdZgIAAA/OAgAAFqACAACZlgIAAAg4AgADitgCAAkTeAA==
Date:   Fri, 21 Jul 2023 00:32:22 +0000
Message-ID: <e42435bd3949de94840fa3fae88be5f3bcc6373e.camel@intel.com>
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
         <20230717202938.94989-1-haitao.huang@linux.intel.com>
         <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
         <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
         <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
         <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
         <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <520111c9ccdd7356f9eaf20013e3e3c75b06398e.camel@intel.com>
         <d718cdda-2d5b-9b4b-d90d-55449ec1ac75@intel.com>
         <op.18b0u6evwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.18b0u6evwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|DM4PR11MB8090:EE_
x-ms-office365-filtering-correlation-id: 2f23bd99-4aab-49eb-2a96-08db8981f345
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tF5dWyOM77wRz7cF15edIaX1RW/gIiccHLfJDQdV6dYdV+Aq5A7/GgmnvS1LOfHoe//v4TFDMMjf/rTPMxc9zI8zkvnvbbRfHvqGDK1nLh1ATvyO496+tAqNCzMwKCRwbyN7aT97gNNyvzTyE2ZG+QwAd1xyT0Hp5h+HqXPl62xQw2SyfxKu6fcWGlyqaVH3CoJR8r5TceXG2PF2gU3guJtLXmgqlWL8Z7iXrQxSKzhO7ySilADX2osPECoppv7j6SAuzWuO/TrkPGqQtmsS+txwUs6FqOPAlqm86oYnvIhRyZOZOZiS+PZrn5oxiyOmpD4eNBNcD8RV4/zD5qjQdh58bnt+lCYhMrwKsgJgIuBuBY4xmfLQBk4XU840yri/pO6SbvUzJyCCRNb6h3jl0zM0y5XodBhL3hQpMP89Lr7qFjbG9wDekvI+W98mXW5F70VnBA0d8wZsmEXaPqe9vqmZjNGqLjROQHfQdC7CdhcHsNjLMk5IKb29RdchHD/bMQ59EYHTOPbIf015hRZnHqZnnadb3IeXrmJgJHJyJL9cA7Xm3BViBhOmnAm2Rd30zHSochVzesZX00pQ4vjMg00vHkon72zhnZKReFQfIFkSGxC+kBwJirK9LoYRM+QsfDRGTSvWUl6S0NwSn9R3Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(54906003)(478600001)(110136005)(6486002)(6512007)(86362001)(38070700005)(36756003)(2906002)(66446008)(66556008)(66476007)(64756008)(2616005)(71200400001)(26005)(186003)(53546011)(6506007)(82960400001)(38100700002)(122000001)(921005)(91956017)(76116006)(4326008)(316002)(66946007)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdSL3dCdFAzVmc1R0NMSmRrWUh1My9RSlNnMGZteXFGL2JaK2NacVZSR3N1?=
 =?utf-8?B?OEVQZUk2SENhVENpb2t6cll2QnQ5WDB5MzZJMG5ScS9pdUFybXVNdUhLcWk3?=
 =?utf-8?B?MGJva2VYVkhwUFpyZU1VaTUvSjZuQ0liRVpzK3VyQUpDZHlCQnBuRVlTcTJO?=
 =?utf-8?B?cHd2bkNjcmd1WnQzK1VtMEVLcDI0MzM3dGMzSm1xZExCN3l5M2dqR1hDLzcx?=
 =?utf-8?B?clRGTUZWU1BOTEpSNUlMT1AwV0lrTUw3MURPbVlXb0RHZytxSTZKMGQyamdy?=
 =?utf-8?B?VGl0dEdaUmpjMGhrS1VHS2VYZG0yYUR1ZTlmK2U3SnV4cEZza3N1YnRpam90?=
 =?utf-8?B?VUp5SnpPU29ZZHRqcW1aVFlGdWl3aUZtbUFRZXJNcUZldHFmQ3dVaC9VcWN2?=
 =?utf-8?B?dkdtaVlhdHlRWGVMZHdNTlI2V1ZWUFJtd2t0YVdxclpOWWRUNnhzaHFGajFj?=
 =?utf-8?B?VDU2czc2eHRiejJVc1k2ZmtKeEF3VE5oQ0ZaOWdlQldVbkRudEZPb09MRUJG?=
 =?utf-8?B?ZHBzNCs4aG9VVXJhYVdzQjNQUnZaekNPWnF6bEZ1KzNYR3d0aWN6M1VsZUlL?=
 =?utf-8?B?cGpKc1Fmay8xNlRRSysycC9sTnFPVVcwMjA0ZDdXclpXTWtzRjlPdFN1VlhN?=
 =?utf-8?B?ZmJTTEV5VmUxdE14ZmY0THpKVmttNC9PZFB1ejEvL0xkL0dkMm1xSXdKRUxu?=
 =?utf-8?B?Y2Y0ZFFlb3ZVa0wxR0lDbFY4di9lVUZmQXIrUHhMOGVZSGRLa1JPbmpXd0Q1?=
 =?utf-8?B?TEhvRlJKa2dUSzVLUUxDdzhYbkpCQkZUbHp5eEhCY1pORVdNL2dlMkoxVTlV?=
 =?utf-8?B?Y1BoRDgxVS9ySEtCaTU0Ni82b3lRSGwvTVJWWERCcTdTWFJsMXVaMFVuTlFW?=
 =?utf-8?B?VDgwTloxY3JLMFNuMWpQMEszRFZKNUVMYW55TVlkTzV1L0l5Q1BUaTdNbWxt?=
 =?utf-8?B?Q2xjemJ2YkxLeWpQb2gvZWVYZWdRQTFvLzFkb1hJZHBBN1pudTNOZTE3UFpx?=
 =?utf-8?B?Ylkxazh2SVdSSjVoK2dQRDdJTmc1WXlsNWpMT0VXbE9jdXJOTDk0Q2RaQVA4?=
 =?utf-8?B?TTVJRnZPMHcyY1JVeXRLRCtPZk9DbmU1aEluQXRSYnFpV01lTVFkdFZZRWpR?=
 =?utf-8?B?QWdPMWlEa2hYQXpIckVKSkUrN2NGMmswbDBQdVJ3SUNsOEpXTnBJQWU1QVlK?=
 =?utf-8?B?Y0s5YzNjNmhoelVSYi9JZ2UyUk00NTRJK2Q2eTVjN284VzBraGUvRVlmM1FT?=
 =?utf-8?B?U3JEcjBwMWhucUE4bTgyem5uL3ZCK0xlNHNZSmZyNGRkTkpMZVBNM3FqaHMz?=
 =?utf-8?B?OStHZDc3OWZHc2g2Tmx0ZTg5Z3dpYnpVc0lkU012eVc4dXQ3NUpFU1BJdURR?=
 =?utf-8?B?V0ZuSFlKNmlKT1M1NkU4L3pLMWl1K3JROE1BYVVKVHJ2QmtRUHpJM0tHOFhO?=
 =?utf-8?B?a3p3dzdkMWFqNmgzblBIdjA5dSt6Z0VIN3ErYjNFSWNXNGlxNmd0ZEluNEhY?=
 =?utf-8?B?M2piMkMxRnhXMmx5eDJpa3JlcE9leUhqYitKOFN1SjRoSjBqK0FPTlZpUWg5?=
 =?utf-8?B?ckY1VGFCTStqOGlYZTFRTUw4a3ZDUXlBOXVrd0JFMzB1UmloWE9rVjlZenBJ?=
 =?utf-8?B?VmU1TExHcjZOYUIxa0YwV3lBRjVMZFdGSk1Ga0txRkZnOVVaSEQ5dTJWWWZn?=
 =?utf-8?B?WXlwQm5SazM4L2RlQWx6OERTM2kveE9iTy9ZK2RhbkI5ZjhkR09PSGlrVzJD?=
 =?utf-8?B?enROeGhZQWJhaHIxMHpvR0tkSGh0VzZPbnVRd3U3dTdzMXBjNGUyTUdFN2VR?=
 =?utf-8?B?UU1PcTdzOGkra3VQYURtVS9rK2c5MW1La1Zia0ZGTHVtOXhKNXZXYUt6N0hZ?=
 =?utf-8?B?akJKcFhzM2lJamlXZ2FzTWxLWE0xM21icURvVTFhbStnaGJSWU9qclQ5R1Fn?=
 =?utf-8?B?NEE5a0FFTUdERWt2ODFKN0Qzb21mUEF6c1hGaUpxSjVjUnQrejZqWUpZMWJL?=
 =?utf-8?B?QmpRZTJJRlcyaTRzQ0h3VVI3eHFKbmU1L2hibUY2d2hHenQ4QVpaZ3FCcGVl?=
 =?utf-8?B?NmRKWTdFWXZBc3I1b0F6WTJ3S1RuL1J5WUprYmY2VWVTWWFDcWxYV0FqOXJr?=
 =?utf-8?Q?RD37T2pZqo8aq1cAkfqoItWWK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EA57F1BC96EF840B4B6797137D9130E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f23bd99-4aab-49eb-2a96-08db8981f345
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 00:32:22.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOCTbDkc45+QZMLSAMzixrpTV4VR+ssX5Hm6n7g4yQ4iHboR+cQyANdO/+GVXr07c+daG6MoRrmzGGs5LNV7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDA4OjUzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEhpIERhdmUgYW5kIEthaQ0KPiBPbiBUdWUsIDE4IEp1bCAyMDIzIDE5OjIxOjU0IC0wNTAwLCBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiAgDQo+IHdyb3RlOg0KPiANCj4gPiBP
biA3LzE4LzIzIDE3OjE0LCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gQWxzbyBwZXJoYXBzIHRo
ZSBwYXRjaCB0aXRsZSBpcyB0b28gdmFndWUuICBBZGRpbmcgbW9yZSBpbmZvcm1hdGlvbiAgDQo+
ID4gPiBkb2Vzbid0IGh1cnQNCj4gPiA+IEkgdGhpbmssIGUuZy4sIG1lbnRpb25pbmcgaXQgaXMg
YSBmaXggZm9yIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiAgDQo+ID4gPiB0aGUgRUFVRw0K
PiA+ID4gZmxvdy4NCj4gPiANCj4gPiBZZWFoLCBsZXQncyBzYXkgc29tZXRoaW5nIGxpa2U6DQo+
ID4gDQo+ID4gCXg4Ni9zZ3g6IFJlc29sdmUgU0VDUyByZWNsYWltIHZzLiBwYWdlIGZhdWx0IHJh
Y2UNCj4gPiANCj4gVGhlIHBhdGNoIGlzIG5vdCB0byByZXNvbHZlIFNFQ1MgdnMgI1BGIHJhY2Ug
dGhvdWdoIHRoZSByYWNlIGlzIGEgIA0KPiBuZWNlc3NhcnkgY29uZGl0aW9uIHRvIGNhdXNlIHRo
ZSBOVUxMIHBvaW50ZXIuIFRoZSBzYW1lIGNvbmRpdGlvbiBkb2VzIG5vdCAgDQo+IGNhdXNlIE5V
TEwgcG9pbnRlciBpbiB0aGUgRUxEVSBwYXRoIG9mICNQRiwgb25seSBpbiBFQVVHIHBhdGggb2Yg
I1BGLg0KPiANCj4gQW5kIHRoZSBpc3N1ZSByZWFsbHkgaXMgdGhlIE5VTEwgcG9pbnRlciBub3Qg
Y2hlY2tlZCBhbmQgZml4IHdhcyB0byByZXVzZSAgDQo+IHRoZSBzYW1lIGNvZGUgdG8gcmVsb2Fk
IFNFQ1MgaW4gRUxEVSBjb2RlIHBhdGggZm9yIEVBVUcgY29kZSBwYXRoDQo+IA0KPiANCj4gSG93
IGFib3V0IHRoaXM6DQo+IA0KPiB4ODYvc2d4OiAgUmVsb2FkIHJlY2xhaW1lZCBTRUNTIGZvciBF
QVVHIG9uICNQRg0KPiANCj4gb3INCj4gDQo+IHg4Ni9zZ3g6IEZpeCBhIE5VTEwgcG9pbnRlciB0
byBTRUNTIHVzZWQgZm9yIEVBVUcgb24gI1BGDQo+IA0KDQpQZXJoYXBzIHlvdSBjYW4gYWRkICJF
QVVHIiBwYXJ0IHRvIHdoYXQgRGF2ZSBzdWdnZXN0ZWQ/DQoNCgl4ODYvc2d4OiBSZXNvbHZlcyBT
RUNTIHJlY2xhaW0gdnMuIHBhZ2UgZmF1bHQgcmFjZSBvbiBFQVVHDQoNCihhc3N1bWluZyBEYXZl
IGlzIGZpbmUgd2l0aCB0aGlzIDotKSkNCg==
