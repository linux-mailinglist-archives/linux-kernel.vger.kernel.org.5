Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8618775BBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGUAwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGUAwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:52:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44746271E;
        Thu, 20 Jul 2023 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689900749; x=1721436749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E7n7LM6x2RLVGFtnLd6ob/y56C/KktlCOz4lF/6Ornk=;
  b=Tkq0SXdD0lT4a0Wf5OWXEZUmlYwXGrGlqNOKr+C4ntrZQV6XXQ7jVN7a
   wT1BH7pkhTan8wwjl1ulvkiWPSuDpPvR+xdQOcUplDlSK2peXJM53B7+a
   3iM+DhSUf+vCdI3wyH+AXo3F7VgUkY7UN4A3YiAUcHbeeqbM46fTDPOdf
   BJMO+2NagZhaoZWVmtWDzl7SMwzrNv2Ho6cCq1g6pXwsGexeFfg93RNY9
   S2dXOz0l6Weawn/FTeJFXFTSzsRYdvqwgHX8DwF5orGe+qFr5snu93OJY
   TT/IZ98kzO+PgfpQNljBUrUdkHfcd1ezIgFuqFckapv8w5edCFrLxFd7Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366938161"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="366938161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="790017791"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="790017791"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2023 17:52:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:52:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:52:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 17:52:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 17:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2JdGDcGU7MPWQYecKbdjr9X3cKK5RvJ541/fcgyCdIxSM/KDJF1pRO0RwDLivk8zDoJSI8qdzV6HgutHuiQk3VYiEPsnfj3iXWBB5wU6PYxIiKkiZgWocPQIvSL+KjBbByCG31Qf+SrtN7I5vWvdWTezMtxH6/+nrxwcEgmYN0ktjVe5wrUngfiLZU+tRGNO3UquWKNdORdjQD/Xo5rssJeWTf8+07XVxF7qX+jT8X4bBiS/wLCDIfeZDxRzwFR9M7ij0J1O/pD5sJS+soS4QE8uzazK+isnWUOzR0qDvIPQILcezsYoIOpc0v/bqXUphvoJseId4HP/+OBuWUBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7n7LM6x2RLVGFtnLd6ob/y56C/KktlCOz4lF/6Ornk=;
 b=FfouKUbcXJMWCkcHg5wkmo5FPLlYxFZRoIPt9tKxteJx/QqLdagcOOiJPOZI4aectT7luLUr1A8U1eJR1DPc8psiJnMEKFyzN/d/tTOK2XxH1gVU5TUutlZuL/lf07qV7g1EKQgR7B0tDNmhzVDV7Qw0YGNAAn4fyUa2BYQXIW9cTXOiZgmRJZWXM6XoVdDQc3UwDZQ1b9VYJjc58XXKbGapbgSODb1t2Tm6/lNygr83oPnwa70PNka+mVLii/miF1LIlkii06+eIRPtkPUSuo4y7hZOLDnIECoH+E2xegozGZI3myGYTuoBEAv+DzEuHOfEjsRfv5gD55VJkuQmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 00:52:23 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4345:8c8a:ed91:57c5]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4345:8c8a:ed91:57c5%6]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 00:52:23 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Thread-Index: AQHZuNr+gc+uEEAR2keHYngpqSvf+a++Tj+AgAAAPwCAABqcAIABLT6AgAA+hgCAAAvJgIAAG3mAgAAGzYCAAAdZgIAAA/OAgAAFqACAACZlgIAAAg4AgADitgCAAkTeAIAABZYA
Date:   Fri, 21 Jul 2023 00:52:22 +0000
Message-ID: <df3ee23c71e9c653db43a38e1b3fddf31e0bce37.camel@intel.com>
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
         <e42435bd3949de94840fa3fae88be5f3bcc6373e.camel@intel.com>
In-Reply-To: <e42435bd3949de94840fa3fae88be5f3bcc6373e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|PH0PR11MB5032:EE_
x-ms-office365-filtering-correlation-id: 731d009e-2e01-4474-31e7-08db8984be5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuoO6QPMg4+2guDCPGglTXFTn9vArQz1a5OjSnwTvU5GoVeCq3PYFyOuFjFw48z6uv24NXQhOfvSK6QkrXD5w03vkc7Lr/drqlZ/726R0MQpDuzkMf7ZUbyoVqaPseKBR0oJB7aSv6V7V9UR1KtYGLuzuNYZoGfdYOGUo3Y0aHjAMpsD+1kTlwrBln3uqHtPcbiBjeShxF1vrIikaxkWeT+jS1fCshBzIZr+HJ1Qop9QE9P2kLfzyOAhUnsK7wEAuEOxNkmxImC7V0KPz/2axsxnnHmiJAV4jNcl5Esb4aCpdzDVytu854QubG55z8f/avp0cJARfg0TyGeH7uXb3+07s1AeS2xFBHvVCVLiCRa1tnWI/28erppOYwWwuRuPNoNAe1RJHp3HuNP1fDSr6dB3JnNi/ySONZqa8MQxHAVXVGUo4FvyeUb28wHHZaHu+pt/nkmudC02Hc0lDV5Y4SskeD/lohabztCcLPMvu+5lzNxhNbv0bqWVDAXFZkI7kEbhTI2VSqG4Pf73AgliESGfYETq+H1Q/zLOqLW5YjJ8jDop09p/I59AzPD9VMuMPMHFuH/BaMzvL1Wq3nvBan93GVj+6xxDnRP/2QqTzqn9zIkJ6dsQSr2lHJC88Ti2LMDZ/WFb+NXvDFVlDNRTkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(7416002)(8936002)(8676002)(41300700001)(83380400001)(122000001)(4326008)(316002)(921005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(2616005)(5660300002)(91956017)(38100700002)(110136005)(82960400001)(2906002)(54906003)(6486002)(6512007)(478600001)(26005)(186003)(6506007)(53546011)(86362001)(38070700005)(36756003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDNZT0xOeHh3d3ZJeHh1OCtNM01rZFlsODJmYks4VHEvSVBlcG9HM0ZkWTNM?=
 =?utf-8?B?OUtFQXRSNlpXUm4zYTcvajlHTUtjQUtXUHlhMHQ0TVBrUXROakVCUXNyN0hw?=
 =?utf-8?B?UXlKVlVycm03WCtsMVU5KzUwTW54TGZCRmZsZXBOczhZM2JqT294aFRweXcy?=
 =?utf-8?B?SXM4R05lUnVMaFhUd3Jka09mNmlnWlZnemVRd1ZudWRuczRaMXdTSk9iK3ov?=
 =?utf-8?B?WDdlWFpKajUzcGFnNXlkZmlsMzZJOFk4VmxQa2dZTlpUeGZKbThBMUsyMmtj?=
 =?utf-8?B?WkI5Wm1nSXEvZk56cFozZDFPZll1eFdjNkNmM1R2KzVBR1hPaHB2Q3k2RVJU?=
 =?utf-8?B?eGE1TXJXbUhJaHBIZUVLVlpQTUVvSUtqanl5TnhrYmRNRTZraUZjMkdkWHRP?=
 =?utf-8?B?Z2tzcmxOS1l6dTdnbm5sdUdmcTd4RTdjbXJYWHZBbzM5SGl5M0Y3RnFMZTkr?=
 =?utf-8?B?K1VuZk80RzBaZDFyWkROSUF2dzJKanUxUHRZcTM2S1RVS2F0andMcjNkN00x?=
 =?utf-8?B?alhkaGJtUStiS3l6MXRUQUU5Q0xleWpTelo0WU9kcUhVelh4VTBhay9OZ01M?=
 =?utf-8?B?RnFnYUlPLzg3L1VxaDlWMTFLRHJaeXErbWY2NS9DRmJMWXNHUFhZbkhVS3li?=
 =?utf-8?B?cVM0YlF4YUx5ZkdWbVZBVkxQSW1ETnZibW1RUks5L2d1NWdyT0VjVDFyMWxh?=
 =?utf-8?B?bGdTcTB1dmxkUlJkLzMrNHp0TXEwQlp6NENyaituV2RCRHBGTGpSQXA0cTBs?=
 =?utf-8?B?VXp6YkNwYVVBaWtZS3lQRjBlUDFkSzIxNm45VmI4b1JSSm84aVdZVmUyd0pS?=
 =?utf-8?B?S0ZJZ05NY2hKalFFbVNmYXNOMmp3NkY5UkNQUnByVDcyL1VtKzFwaDNtTkx0?=
 =?utf-8?B?S0NYNTVKSUtGaEZpZ1NTTEliVm0vK2UxbXBuMTBmazRGWDVVWUFRcFp5ZHFn?=
 =?utf-8?B?cXc0YmZWbVJVbDVZZXpISGFOU0pxV0gyejVFbDBBS1BReUhJQ2Q3ejFqYTM1?=
 =?utf-8?B?WkdWNGI1d3VuVEJOKzJBYlJUeU5Tcmk2bndiSnFHSFpKbWFUeGtBV2pjZ1Vh?=
 =?utf-8?B?WWF6K0FqendWbmFCTHdRc3hwYjU5OStHODVFUEt5N0NPL3QxKzlaTGsxMUsz?=
 =?utf-8?B?ZVQreENRSzZzWjBXdjhzelQvL1daSUFidHVlb2JIKzZ6WlBRZmc4ZUgxbzBP?=
 =?utf-8?B?aWJPR1cwaHZ2dFdJakRrRkNzNTd3S1VSOEZSSjhzZExlSm1wTjNxYW9vUWhm?=
 =?utf-8?B?bXZGQndnYVBJcnNvRHl1SDZqSkpxc1hDMUQrNlVBbkJsT3JOdFM5MzFLOE1t?=
 =?utf-8?B?em1oZnJwZlVCZEh5YklrYWJaUUpTVWlHVkxCdHhZTEVLVXZnSVNkMTV3VTBY?=
 =?utf-8?B?TlBzWEtiSFI0eXVBdmdkRjdqY0NpZSs4Z24ycytBcDJXalZqazNaUzc4TSs1?=
 =?utf-8?B?RTk1cHNuMHBYT3Bla1ZtU1FaSi9ka1JZMldDREV6VERXUFRIamNRbUpCSHdi?=
 =?utf-8?B?cWNSSUpHdVpoSDMrNUJJM1dEanpQWncwTU1EdElQWGtkRnI1OTNwZGkxWUp3?=
 =?utf-8?B?NWNrcXZVNE4yTThvTHBPeTYrQXoyeHRFQWVJYUt2YkRQTzJNUG8zaElBd2dn?=
 =?utf-8?B?STRnSG80Y2JVR2x3bzhJM0h0Y0dMVjJ6Z1FNM1ppdEsrSHZYdkc3T3Z0RjB0?=
 =?utf-8?B?MU5abDk4VHVYZ2puNGE4V0NIdXNDZDc2bGVqVHhUMnorVjVUQ2E0bWduUm8z?=
 =?utf-8?B?cHJGd1lIQkl4T0pGU0g5QkZpWGp4d3dGSU44d29FYmRKaXlGZkNCbXJPa3lY?=
 =?utf-8?B?V1dWc3RuUURSNng4QiswTWtuYllKazFlVGkwV3RmL3liRXcvUnBSMXZ3aCtj?=
 =?utf-8?B?d1djNXNmUURUZm1nczExQ3pWbFpSUEdmNXVmYTA5Qm1yUkNLd2Ivd3A0T0pv?=
 =?utf-8?B?cU5uM3ZzOTV0LzhxZUk0YTlTd0UwVXlFS1BxUEd6ZXF0elU4VjhjaCtNUUJm?=
 =?utf-8?B?Nzc5Y0hId2VxdVFORkw3Q2tpak9IYUIvMlpFRzZ3cTRnWjFKSXc0WDMwVWd6?=
 =?utf-8?B?TURDS21hUHZJZU9mNytpNnNMVmVGQ1grdHFYSzBLSHNVK3JQTjZrNzlvUy84?=
 =?utf-8?Q?5Mqn117Io8lRFCckGT4IKPQfQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <277A0463EC0E4742AACD49F83A8A61B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731d009e-2e01-4474-31e7-08db8984be5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 00:52:22.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHlQzb05a0nqFpb4Aqb6dptM6xKkWGAWsIdkMSsaX+BSX9SRpq5SnCf4GGN5SRBuBzIn6JHMt7jpb5NXPOxQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDAwOjMyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjMtMDctMTkgYXQgMDg6NTMgLTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4g
PiBIaSBEYXZlIGFuZCBLYWkNCj4gPiBPbiBUdWUsIDE4IEp1bCAyMDIzIDE5OjIxOjU0IC0wNTAw
LCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiAgDQo+ID4gd3JvdGU6DQo+ID4g
DQo+ID4gPiBPbiA3LzE4LzIzIDE3OjE0LCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiBBbHNv
IHBlcmhhcHMgdGhlIHBhdGNoIHRpdGxlIGlzIHRvbyB2YWd1ZS4gIEFkZGluZyBtb3JlIGluZm9y
bWF0aW9uICANCj4gPiA+ID4gZG9lc24ndCBodXJ0DQo+ID4gPiA+IEkgdGhpbmssIGUuZy4sIG1l
bnRpb25pbmcgaXQgaXMgYSBmaXggZm9yIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiAgDQo+
ID4gPiA+IHRoZSBFQVVHDQo+ID4gPiA+IGZsb3cuDQo+ID4gPiANCj4gPiA+IFllYWgsIGxldCdz
IHNheSBzb21ldGhpbmcgbGlrZToNCj4gPiA+IA0KPiA+ID4gCXg4Ni9zZ3g6IFJlc29sdmUgU0VD
UyByZWNsYWltIHZzLiBwYWdlIGZhdWx0IHJhY2UNCj4gPiA+IA0KPiA+IFRoZSBwYXRjaCBpcyBu
b3QgdG8gcmVzb2x2ZSBTRUNTIHZzICNQRiByYWNlIHRob3VnaCB0aGUgcmFjZSBpcyBhICANCj4g
PiBuZWNlc3NhcnkgY29uZGl0aW9uIHRvIGNhdXNlIHRoZSBOVUxMIHBvaW50ZXIuIFRoZSBzYW1l
IGNvbmRpdGlvbiBkb2VzIG5vdCAgDQo+ID4gY2F1c2UgTlVMTCBwb2ludGVyIGluIHRoZSBFTERV
IHBhdGggb2YgI1BGLCBvbmx5IGluIEVBVUcgcGF0aCBvZiAjUEYuDQo+ID4gDQo+ID4gQW5kIHRo
ZSBpc3N1ZSByZWFsbHkgaXMgdGhlIE5VTEwgcG9pbnRlciBub3QgY2hlY2tlZCBhbmQgZml4IHdh
cyB0byByZXVzZSAgDQo+ID4gdGhlIHNhbWUgY29kZSB0byByZWxvYWQgU0VDUyBpbiBFTERVIGNv
ZGUgcGF0aCBmb3IgRUFVRyBjb2RlIHBhdGgNCj4gPiANCj4gPiANCj4gPiBIb3cgYWJvdXQgdGhp
czoNCj4gPiANCj4gPiB4ODYvc2d4OiAgUmVsb2FkIHJlY2xhaW1lZCBTRUNTIGZvciBFQVVHIG9u
ICNQRg0KPiA+IA0KPiA+IG9yDQo+ID4gDQo+ID4geDg2L3NneDogRml4IGEgTlVMTCBwb2ludGVy
IHRvIFNFQ1MgdXNlZCBmb3IgRUFVRyBvbiAjUEYNCj4gPiANCj4gDQo+IFBlcmhhcHMgeW91IGNh
biBhZGQgIkVBVUciIHBhcnQgdG8gd2hhdCBEYXZlIHN1Z2dlc3RlZD8NCj4gDQo+IAl4ODYvc2d4
OiBSZXNvbHZlcyBTRUNTIHJlY2xhaW0gdnMuIHBhZ2UgZmF1bHQgcmFjZSBvbiBFQVVHDQo+IA0K
PiAoYXNzdW1pbmcgRGF2ZSBpcyBmaW5lIHdpdGggdGhpcyA6LSkpDQoNCkJ0dywgZG8geW91IGhh
dmUgYSByZWFsIGNhbGwgdHJhY2U/ICBJZiB5b3UgaGF2ZSwgSSB0aGluayB5b3UgY2FuIGFkZCB0
aGF0IHRvDQp0aGUgY2hhbmdlbG9nIHRvbyBiZWNhdXNlIHRoYXQgY2F0Y2hlcyBwZW9wbGUncyBl
eWUgaW1tZWRpYXRlbHkuDQo=
