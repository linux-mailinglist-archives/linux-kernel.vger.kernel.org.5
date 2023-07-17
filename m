Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364FD756EED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGQVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:25:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017CAE7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689629157; x=1721165157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R1Ta1KPpWdzLlaDW4FHEN8bO+ZNLZ1DhzPlNwP350W4=;
  b=KP94dXIbvv/fuHRvX5GU3XRVPu8xYoSSepv73O+Z+SWBNMb2Cswvs1W1
   ++ZfiMfTaa7t/3PxBClTuCJ0LZfTTrUjNir4sylR/jj0GUOyZG5oe7bsZ
   Y5tLldYaxAFxcoca/IWpA5/dZCWVRYRYRcaiO1abjkU54ehu8pbxVMwsJ
   8Hq6uvYaUxmujrx1HDKN1d0PN2EWHK2FWx7rA1NVgQBL91gxlrjZ/PImI
   J3qMJT62F4Jwe8vAwUOFFMSZQzsib1r4YsOKBOYG8uYL+HMVtTa2qvGju
   3qBi4nWhbmLLLcpU7WJA6oNFEzT+tKt6NCwXSRvWZm8b9UA1+Nd6jtUqx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355980024"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355980024"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 14:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726695018"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726695018"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 14:25:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 14:25:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 14:25:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 14:25:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 14:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJDFBgTnaTAYjfI6bYaU2L4tClSzLgIabiksCw3Y5cIvjPcwTI6tsFf5bKulTLAwCjsn+BqFT8UQeae5rYyqLyyYJiigzrxD8MSlcUySZZBqldUCx/aMaocTdLNf0WWV+owf/6MkT+uNfycU/GotYiHBA1CXhzFPTUtFL3W2MiiK+WJVca363GrEtScL+FDBM8T+SQO0T/sAgobrwJNoR6jT+FtKP7aj+2H+rKpXOXMRhDF6Sfd1C1Nu/6gLS3dEXoTt94VAwRGEz8MNqrH2t8sxufjTXtzForoYTY2VKK0Ca9cbuuQp0TK1X4Mi16HQovVk5DZJnu87x0QmMmLFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1Ta1KPpWdzLlaDW4FHEN8bO+ZNLZ1DhzPlNwP350W4=;
 b=bYP4rTVhma2/bgxeVHbTrL4IsTQDDVPzfSKTrVsTviCUTCmfvuiwQ8TAxwSk+nVlIERjyuJ3R6qnjJWnCeqm5BOmggUYoQ9Nd+yNahwxMD+Dk95Tc68TJpFjqDCokk2TpcvlmyqJWzsiIxL2N8sOPbvhVaW03YrJtrnAtyBhVeNQ6f6H0N5FgUGSDGfXVSDAMSFyvNsCVrtugKUWp71EdN3gNRv1T5MQsLB4t9XZn5mFHJTL4idiB07KPKLLs35L9C9LhdZKpAA33KGELRRSe1evYD9dyQWpVJvACKO3ST35pNYNaYcMGlfoU7br32RdMDMlmGviT0eoEEr3wf+ZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 21:25:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 21:25:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "janusz.krzysztofik@linux.intel.com" 
        <janusz.krzysztofik@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Marczykowski, Marek" <marmarek@invisiblethingslab.com>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page
 protection modify mask
Thread-Topic: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page
 protection modify mask
Thread-Index: AQHZswGMYdZ4juw/r0GrWBRLTXdpN6+zSiUAgAp2woCAAMOcAA==
Date:   Mon, 17 Jul 2023 21:25:52 +0000
Message-ID: <379e34f0065552384a2dea12d1726c6727763b8a.camel@intel.com>
References: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
         <9c14a3597d658a065e853b6e5f64ff21b4b7b575.camel@intel.com>
         <7545651.EvYhyI6sBW@jkrzyszt-mobl2.ger.corp.intel.com>
In-Reply-To: <7545651.EvYhyI6sBW@jkrzyszt-mobl2.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7504:EE_
x-ms-office365-filtering-correlation-id: 8c2e74aa-4a2e-4bcd-18cc-08db870c6643
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1ns2KWyMxwbjdAID57biA4s06X1GdHWctyRZwretDMRO2xX6nJeyrGKA4ZnPPqZATfzIw/VYWfK4k37lc099L0rNvnpKP/QEsYA6TDP3IGeqkuMdiXwjHd3DHPaAT1JWG4Hfr+SFk+Dm4+4ZNLdqA/CGDZd/kxNuA9YhNFWXOiRtQcOFdjrNn/LU2QNNngCj6Y/fF65+EnPd1oMs82WV+CG5lFE9j2XVd1OKdtup97CbauAbaYrKbw+SlPYEhvlWAyLVXLH4XSHN4cT/RpJJE07mIB/C4ySuqiUS9qGv7hgBrF93KntkcDCS+S7Mtpsx3rSwPN7c4Z+oBxS96OSZWNCABYWSoMpKkAROaGtF/478peIvUiHRJWNpirq7CVrRfkBcr1PVDYssZcR25w3w2d0QyF1aEmLDCpmffIE7qYraD5paL5crPSBYc9Ws/gWHEuHb3PoLb/icVAXS2EGzj9LZiOUhLUYb7rgZHTMR4LzzoB5fof5AbUuQQeXjsdBieNtcH4CGBn/TtNHWK1wUMUYCI00vJiezhsnX3kffuzqZYY7liCRGlUvXBxY2qT1zI60pMUQP+QAWI2C6o8UWS6JcPaJgffR0/nHjPDaKk9OaDBioyRjFdbmugyPPzpQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(2906002)(54906003)(110136005)(478600001)(6486002)(71200400001)(8936002)(36756003)(4744005)(8676002)(7416002)(66556008)(66476007)(41300700001)(91956017)(316002)(4326008)(76116006)(66946007)(64756008)(66446008)(82960400001)(86362001)(38100700002)(122000001)(6512007)(5660300002)(2616005)(186003)(26005)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjBHNXZkY3VRZm1vQ1dZTXZ4NlhzLzhBY25OSHlBMXN6eGplSUs1WU1OUlJE?=
 =?utf-8?B?Y2diNUJ4TWxmWXdYQy83cjhnR0d4dXBTaC84STd3SU5GeUFNMzFFNnR4SWxs?=
 =?utf-8?B?L1NObUd3UXhjQjhKaDk0N204QnQvNzlNWnRpM3F2RE9mUjl5eDlTWkZmOTdM?=
 =?utf-8?B?YWRMYTZLbzREaWRvamJja21HR2JwREc5bUZMcGlHbTB1UHg0SFUyV3ZCNjBl?=
 =?utf-8?B?bU9VNUpzMloxVHZ3ZkFFRmNkTFpYSDY2b05JT0hvZGRnYlovdXhac3dkYy9y?=
 =?utf-8?B?SVRxMDA2bmdRMW8yRFlqQlpLZDBlVEVwL05qUk9keUwvUzg2bTJSQ0ZlOFJt?=
 =?utf-8?B?UzlyVlMwclhkSml6djNsalFlKzFnc0pXdGhlQVF5N0ZNaFNJVkdVSS9aKzk3?=
 =?utf-8?B?OEVZSlczdWxDUWVySFl3dmgxTm9pdUFIUFA3RWFCd2FLYkpaQ3ppRTJlS0dG?=
 =?utf-8?B?SnN2eXVKK3dOdUV2N0Q2WHh5aFNPVXV5NWFsTDNzaEVjRy9qTHBBOFFySkdv?=
 =?utf-8?B?TGp3SXZCVXR0Z3RXTnFFdEF0SlpqQ1lpSHprWC9GN2w5aHVBSTFJc0JjSEVW?=
 =?utf-8?B?QXhwVVNUWE9mQzFzWE0vLzQzM1JYa2dPWExJd2VTWFNzd2RxNjl1eEJaNnFh?=
 =?utf-8?B?NnY5eURqOHpLY3l0U3pvUVJOc3ZpbzBBaXFIc0UxRG93bnNWOG1TZHkxRnZs?=
 =?utf-8?B?Y2pCd1h5R0tFRmdXNjNudHRJUWpjSUUxNmVIZFh1alhBNkNEbnNSLzNrazl1?=
 =?utf-8?B?R2NLQTZSSkdzR21VSWkzSjl6SVlrUFpnTlQ5bnR4bFZDa3RvcjNwQ09uWWNp?=
 =?utf-8?B?elpuWFNYWVljVzFyWlR2bG5NZFgxbkUrSWw0Nmt4V1h4anY4ZkMvU2I4bW5F?=
 =?utf-8?B?ZlBJRHpMa2ZWUTc1cUt0dldSbW1jOVcvUW9hU0F4RE9Zem4vLzJHSE5OaFo5?=
 =?utf-8?B?dXFFQnJ1VXJpeTFzSWkzRjFGVVFUd0ZSeUNOcFdUZy9CSXdqVFhCak1Cd3Qx?=
 =?utf-8?B?N1k0RXJJcDdDUVRodFJZTDEra2UyZUh4aWRoZk03dkVvMTY5eUtTTUlZblh6?=
 =?utf-8?B?UUhTQmZMNHZ4V01kelQwbUFJTDFYTTZrNlRYeDYzak96aGdMZVBmcnd4VFlO?=
 =?utf-8?B?eE03a1Z2a0IzM0t5Y01HaFQxRnZ6djdjNzMxUXRONEkxbmVaQURReGRMUC9a?=
 =?utf-8?B?Q0szMDlQVktRbVdNajd3a0ZUZG5uUWdiUWhXRFU3bFRLWGhDcEQwZk5tMU9Y?=
 =?utf-8?B?L0ljQzdQZERQeXZEUE03N0d1aEVFVDNrTkhhYjVmV3FwVC8ycElXUStPeXlD?=
 =?utf-8?B?Ym9qWVRtQXFpcktCSWpjOWJlTzR6M2pLN2ovc2xBYkZ6YnZyUWo0bEdzRU45?=
 =?utf-8?B?NjBwSHd0YVJrQXgyaC84ZURvdzRRTmlSS0tBOHRQeEhqa2R5bzNxdlNESnNZ?=
 =?utf-8?B?bDUxelNDSm1XaHp1d0dxYzM1Z1VZSzBlbmFaOXFnSjFZTTk4Y1V6aGZ1YjhE?=
 =?utf-8?B?bzR3eGlZOXl0Z2s4Sm9ia29wTHY5YW9qdWpGN1hWaTFTQWtQbEtLcXNGYkpM?=
 =?utf-8?B?b3dtNnRTUmhBUnZUa0xyR05WdzUrRVU0eVpZUnpWWGtDaXpZdkYwYmgrYkxM?=
 =?utf-8?B?WlY5ZjBBNVVJT1doTHFtR011ZXMxTWVjNTZyOHZYVVl6aUpVOHBpbXFBVm9F?=
 =?utf-8?B?QU5ES29PRnJWYnBpdG9ob3JHSXRyWjh1VTNGRXptM0RYL0NDaEZ0SEVwbnBk?=
 =?utf-8?B?bWJjUEQ5Qmw0ZG1sdHdDMVRCV0FXKzk3ODJUN3JjaEVmalFXbndaNTlGT09z?=
 =?utf-8?B?S3o2Wk4xZjEvQ3ZFZHpFL1FzbWtBQnMwY0dRb1M0MGpFQ2lXaUJzNHlJdjQ1?=
 =?utf-8?B?V05kOHJTZ3RwSXRzR09SdWVsZ0FoajJVN0xLQ0kzdFBLYWFQY3M5TGhGNC9p?=
 =?utf-8?B?U2RmUUhTcmExL3Nobk80dERSU1hKVHFUcmFwTERiT2dsbHdZeXR2Tm9tRFRv?=
 =?utf-8?B?czA2QTBNY3FzSEdXU2Y4SmIvdHRmV2ovbTFzSmxqdURza1BzeGtUbysxc2VX?=
 =?utf-8?B?T1VGdmFoSXVKR25BdEpYd0tkZ0xCck5tMll6UW91UUsrNU9JWSt2SWxjTldZ?=
 =?utf-8?B?WVlkcHE2VE9WSElvZUpCeUt5ZFJmaE1JZkhvY2hiNXdQUlVvNURVWTJUZjZE?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25399BAF6CB8EF48BFD57A56686E85BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2e74aa-4a2e-4bcd-18cc-08db870c6643
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 21:25:52.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d3bjTkkS+VZb3PfMZL3xbYcDD84ZCE71UDaB16/hqAyI2hIsVDWFiy2ST1+z2hJgjVNwXDI9kIsQdl40FAKMDlcPkC6GJ3uUTe9mmngHJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDExOjQ1ICswMjAwLCBKYW51c3ogS3J6eXN6dG9maWsgd3Jv
dGU6DQo+IEkgY291bGQgYWRkIHlvdXIgY29tbWVudCBhbmQgcmVzdWJtaXQsIGJ1dCBteSBleHBl
cmllbmNlIGZyb20NCj4gY29tbXVuaWNhdGlvbiANCj4gd2l0aCBhdWRpZW5jZSBvZiB0aGlzIHBh
dGNoIHRlbGxzIG1lIHRoYXQgc2lsZW5jZSBtZWFucyByYXRoZXIgbm8NCj4gYWNjZXB0YW5jZS4N
Cg0KSSBkb24ndCB0aGluayBhZGRpbmcgYSBjb21tZW50IHRvIGV4cGxhaW4gdHJpY2t5IGhpZGRl
biBkZXRhaWxzIHdvdWxkDQp0eXBpY2FsbHkgYmUgY29udHJvdmVyc2lhbC4gSSdkIHNheSB0byBj
b21tZW50IGJvdGggaWYgdGhlcmUgYXJlIG1vcmUuDQpCdXQgSSdsbCBsZWF2ZSB5b3UgdG8gaXQu
DQo=
