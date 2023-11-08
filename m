Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8733B7E5EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKHUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:10:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EB211C;
        Wed,  8 Nov 2023 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699474213; x=1731010213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdzC2LaP/ojm8w5P3pBxfJNgwQADdBKvnBBfY6vleOY=;
  b=ll9RtV73ckq19KidWGHKN27ChFLJSovALnawnE8eYlXk6ennoDSRjwy2
   JtBmeMXr+jzeRL9hPmhavBybkamgAo4ZnyU6W3wsthE+mi+THmDHcSfba
   qCJgSlOzLTxBZMk+Q0jXZhCy4kOqZ5b97YnDzTcLujpFm0MTarwhsseMy
   Izlc1Y3ROJV3FdpgLEgg0ZCYqKv/0nxqIor+5rt0RWMsTvCtbOBd8qdyA
   ZKa6Wwe7qAP0iZvw12yfgRj3an8E+Bfft3OlWfOe0+3+4dr3goKdCkJb0
   gYbwj0pJZsyFIX9R7WCXh/NAQTLl++67bJwShpw3HZ1OKpMszlyNGhz0A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="393759492"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="393759492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 12:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756651233"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="756651233"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 12:10:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 12:10:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 12:10:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 12:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2v24ynlkQjcnF5hO28knnmgLyz8z4FnW0P+TLHoXNDmjWSkxFqZVWHvtXs4igwUgdsx9TnaijftCi6GuuHQaBRCvAo3k9jOjj/Vkjx4IHftMQRO2qKQEdEl4DaYk/e/JF4/PiqiCcMrwGZvuJ1EZj9ZmssMcWFnyhlSmEB0lZY+3zhVqqXxJQ5WvjUxv07UQMQ0nrB+Gdk//z9bf5MGzmilLkd+sVSxfmiZekD/TzlzZfZTcQbG+cnbOEbIQrLNTUMna4XWIyMMT0exfgZXVswQuXRPEQbmzAUbiAa3ZcJqtbA2vIZ7IsrEJZPiY+gItqEEMiR9vmPlpH1fSiUj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdzC2LaP/ojm8w5P3pBxfJNgwQADdBKvnBBfY6vleOY=;
 b=RB7UP13cq0SlVp3pR7jYMrwAR1dPyab1DaMA+H5t/voQnK4EQZL/5Et30ZK1yaJW9lPU66LAkXs61fatylBJaNT3MoDmHZorhhdt2M7118Jp6pPRSdv2iHxugiwrgqV6S9zD/iKClXRgYpFcOIQKy3f4PmnzoQe+yFHPfURVdLu8GtD/vR4LRs/J0wYYqKCDuyY4je0BmDQAXl52wVjmEQOV955Xpi1pkESCbrqYQyDMoBXhRfnDbsGMkv8dG+XjcW0J4I/6BHV2+YRbk1uKb+sGoabfn4TppGhBUx4fNk2AosJIsHxsIX38q/W5jg9qmuLxjCLzYlabtenVfTui9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:10:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 20:10:08 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v10 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Thread-Topic: [PATCH v10 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Thread-Index: AQHaDD+l6n5EvJSJfUKNmiD8F7KtWbBuC2cAgALT4oiAAAZC8A==
Date:   Wed, 8 Nov 2023 20:10:08 +0000
Message-ID: <SJ1PR11MB6083C78697406D9B7AA35EC0FCA8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-5-tony.luck@intel.com>
 <51332bf8-d641-4a89-bcec-60b849fc6a34@intel.com>
 <ZUvfSbnOY+niAr+e@agluck-desk3>
 <3c2ff898-97a6-451d-97e5-095c499b7c22@intel.com>
In-Reply-To: <3c2ff898-97a6-451d-97e5-095c499b7c22@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB5777:EE_
x-ms-office365-filtering-correlation-id: 03c02d3d-8402-4406-a92d-08dbe096b4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoN0sPcaMmg9e/HBn2hcDiO6GlJIu5qPcAZ0w/IWa1cQTya5D+y3uYPBHaRigea2ui46zkAKJ0hMzd8uYcecpFR+mhFix3sjyxga+k3HJUlSWs4a+c6/HiZQkcoUL2nGNs5uNenqd9FngRvH4YCidSchoGFi8O88ZzEx+snPRhBOp4RZ0neI8h/nhjAE3dYIIb9VUIa4qXMcBs6SVSjYM5rH+6oNb3oL6V/LDF9UuM/hrPpbxGKs+K8pgCkZPKznTvHLzavj+UWPutsjzfU8gRlPfnB5eHuE/S6lFARwe2it3rDSq3vcZaYPgK7uFXZ1sLH5SYKVvPzQ6ORGSlCi3jyZ5nDitRG1TEYJq0dh7bU4iqXxUpywuiviuN6KHo8yIYdxAXkzdc8SNcHdiw8HBCyway1jqI4od530Utn4nEUpNEzeKY3ikQUgeOIrIFVxwIWessETb7Z1lPA285DDCFszFJOn1TSctrfy1Cx2oW1ABuagosOvNzpLJWZINfk/C9v39w0a7dxPicXgrkA9/9KhIvDja/GRSirPufbDBg59rJDCB44d3BgAtfz1CrfABpvsDIweEjHjyopLvvfxlpjNy35CcRar6m4aX+o1Pba8Tfp77wWwBaa5HT7HcVId
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(54906003)(66476007)(66556008)(66446008)(64756008)(316002)(76116006)(6636002)(71200400001)(6506007)(7696005)(9686003)(26005)(38070700009)(38100700002)(33656002)(82960400001)(122000001)(86362001)(478600001)(6862004)(4326008)(2906002)(8676002)(8936002)(52536014)(4744005)(5660300002)(7416002)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWNJQWEvWFhrTDE5M2R5ZndLVnB0azlFV1ZYaXNtdXNBeStzZjJobGZLaHpp?=
 =?utf-8?B?bHR1SkZNUndNV3ZTTzVSU3BudHBiUFB0NzZqaTQ2Q080aU1MSkVCU1NOU29X?=
 =?utf-8?B?V0thczN3Q0RNOUtwWU0yTEJDclMvckFwN3BLVHdUUFBUY2tTbXBXM3NreTcx?=
 =?utf-8?B?L0xQVWJYVjkxTU5JZjkrTHZVQXVvcXNRWXV5TzExb2pzRTBpYmRnbHRzQ1VH?=
 =?utf-8?B?WE1sYk5RS3RUcFpaYUZlZU5uOTkwQTJ2cThQekJSSG8wMnZPR04wdDJyMnRm?=
 =?utf-8?B?bmpFWVllUGFhMjZ1UUgwYnB3cXRGQUFBQjVQRVFsdHIybVVwWXhwbXo3VTJ4?=
 =?utf-8?B?N0ZiZ2ZBVUFudlk1RTJQcHVrYWxOb1ZvNXdYcEwrZ095cXFkZlRvdHNHSEFC?=
 =?utf-8?B?azVqTUJCU2VvcHlJMmVNV1hyM2k4S0l2Q05LbVF5WUZFdFBFZExWUVVEVk5a?=
 =?utf-8?B?RHJxTExHdlhVcjZqb0JPUE1JL0tlSm8xMXhxdDA3UFBYN2U3Rm5qMTI3eEpC?=
 =?utf-8?B?Uk5DSCt5Nklqc0hOR3NzVjQ0clB6ZWI0eU0vb3ZFR2Y3Z0dXS3R2dTliMTln?=
 =?utf-8?B?cFQwQS9VRXEzUkJQU2RpUDh2eHRhUHpham5ZZTJzVGEyajZSNHl6amI5Zmd0?=
 =?utf-8?B?dzRQWjJ0Tm5nQVA3Q0czU0w3RGlXdHpKdW9JR3lNZ2F5emNKTjlWQmQ5ZTYx?=
 =?utf-8?B?VnBSZ3piVG5kYXNqUEhUeFhVQmxXMFU5M0s0RWRzZmlMbFNyaGI2d0YwTk5p?=
 =?utf-8?B?NnJsM1lwOXdaS3dQdEZlMjJzRGt6UUtMV3N6ZHlNcWJuZTl2VlVNNnlJb0lI?=
 =?utf-8?B?SUNEU0NsdlA5N1RKQkZUSkhLYlEwdWJOOXFkeDZSNFNHZzhaekhvdGRJMEpT?=
 =?utf-8?B?WnRPUUlxMnhZZWlwREppcnh0K1d5RnFMYTFEaGRBcFVqWkhHTmxTTXhuSGpF?=
 =?utf-8?B?VTVUbEd0RWtvU3JoVWIvNHI0anVrbUVGY2RMOUhOWCtJZVlxTUhXU3Zhem81?=
 =?utf-8?B?dGRZSWN5Q2d2b1BoWjlHeDJxVDhPUG9uZzYvWmloeU13dVNPNG1mTE1wYTBi?=
 =?utf-8?B?clFZdFBFSWJXQUhVSkR4OEZXTHV3KzBsK2JIVDlQTENHc2V3YXhwTEFmN0Ri?=
 =?utf-8?B?bTFDVXRGRjFDZUVlR1grMGFWS2ZNdGVxazdaZld4Uzk0bjk2WThzV0FEbnJ5?=
 =?utf-8?B?dEhGcUlRSWxIUjlQbVVPL3V4L0pGWGhqS0ZZaFE1WVlaOW5Ecno3U0gvRGxp?=
 =?utf-8?B?alBkbmJIM243Q0FTcElDKzRNei8rQzlXeWVZQjVmQWpTQTc5VFFuaTdPWXNz?=
 =?utf-8?B?REdxT1Z6bzlCaFE0SzFyVGt6c2FINFpuaTlOTWtHSVpiZmRFTDNUMEMveWtK?=
 =?utf-8?B?bk1BUTFlbGhKb2ZUdzFEcjJmYU9IS2o0STg1R1ZwdmdnTTJQeE5pQU41alZ4?=
 =?utf-8?B?Uk5mZ21QeWFILzQva2Njd09CRHR6Z2pNMEhPN2lPSTBJZzZiTC9Sb1RFaHhh?=
 =?utf-8?B?VUVVZlgyS2U0cFoveXljOTNMZUluM3pWMUdzQXZjT3RYREwycVY2Tm1nSEhC?=
 =?utf-8?B?S3dTSjZ0NEs2VC8xTWVUYk9XYUxhS1JpT1RYVEVUd0N0QmFTcEJkMTNZTTEz?=
 =?utf-8?B?U3pheGFuRTRvZXNuR1JXclhaS3MzaitudjZEYjlWNEJzVW82dEdsbDNITUtw?=
 =?utf-8?B?NHJjZlVpbm5ja1FzYUlORmtiazdLMXJXR0x6Q2ljcXM1QTZ3cGl2OVVua2Fm?=
 =?utf-8?B?aG1SMm1IbGt1aWNUMHFJdTJacHgvV0t1bWZRVFZyUUlDaG1zQXU3NUVHY2Mv?=
 =?utf-8?B?L3NFRTQxV2dpbmhieXBraEVWNmFvcWRxUWM0NjJUU2s3RDFmOXNJdElOQ2VV?=
 =?utf-8?B?KzZYd3VIdHRDeWRUaVU4VThYMWpRdk9LY1NBM05aNHNKcWQ3bFZJbkpkNkJ5?=
 =?utf-8?B?RDNJTVJhZVBIU1R2Uk5iNS9PckhjSkhYR2cxaW83MGJCaG9EOSt5b3JJdjNP?=
 =?utf-8?B?MGxXRE85d3hoclNRQnQ3bk03alNxdjNjeDJjWFFnYnFtaEZxS1M1UlZRS0Y1?=
 =?utf-8?B?Yms5TERvZ0hCZm80RDJ6SmFJYmZHeWJyNHdndEs5UmNMWkhzYnJmUUlQbm9p?=
 =?utf-8?Q?ETHcDdAOHXVL8iWs4A0L1N97E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c02d3d-8402-4406-a92d-08dbe096b4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 20:10:08.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiehUHOxKMGVP79IxbnLf84XXCpv7aeCnoTqq1vXqHkjHMSPMy+EBSWT/JMYRO10fGEo363B0IAP25CJsrRQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAgICAgICBzdHJ1Y3QgcmR0X2N0cmxfZG9tYWluIHsNCj4gICAgICAgICAgICAgICBzdHJ1Y3Qg
cmR0X2RvbWFpbl9oZHIgICAgICAgICAgIGhkcjsNCj4gICAgICAgICAgICAgICBzdHJ1Y3QgY3B1
bWFzayAgICAgICAgICAgICAgICAgIGNwdV9tYXNrOw0KPiAgICAgICAgICAgICAgIC4uLg0KPiAg
ICAgICB9DQo+DQo+IENvbnNpZGVyaW5nIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgY2hhbmdlcyB0
byBleHBlY3QgaW4gdGhpcyB2ZXJzaW9uIEkNCj4gZGlkIG5vdCBleHBlY3QgdG8gc2VlIGEgY3B1
X21hc2sgbWVtYmVyIGluIHN0cnVjdCByZHRfY3RybF9kb21haW4gc2luY2UNCj4gaXQgaGFzIG5v
dyBiZWVuIG1vdmVkIHRvIHN0cnVjdCByZHRfZG9tYWluX2hkci4gV2hhdCBhbSBJIG1pc3Npbmc/
DQoNClJlaW5ldHRlLA0KDQpZZXMuIGNwdV9tYXNrIHdhcyBtb3ZlZCBpbnRvICJzdHJ1Y3QgcmR0
X2RvbWFpbl9oZHIiIGluIHBhdGNoIDIgb2YgdGhlDQpzZXJpZXMuIEknbSBub3Qgc3VyZSBob3cg
aXQgbWFuYWdlZCB0byByZWFwcGVhciBoZXJlLiBEZWZpbml0ZWx5IGEgem9tYmllLg0KSSd2ZSBy
ZW1vdmVkIGl0IG5vdy4gDQoNCi1Ub255DQoNCg0KDQo=
