Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3380AECF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574769AbjLHVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:24:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB4A9;
        Fri,  8 Dec 2023 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702070672; x=1733606672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZaR1/E7FVR9OreuyJ9EIZu12kv65dF6ZEe4xWkbjrs0=;
  b=gxCc0ALFoJKBkuypbcL2FO4y00pkxgdfBUO1lRdLeubLnb+H6vtivqyH
   MfmY6rirdzUnVgPBSCPSyjUOkhEuoc0l7QS1QsBUNeWBtGvEjzZ+ZEqpg
   //7vpMzaBFoh1qmn6b1ayrq6BQpWb3ZSIL8oTMj0xeVvW3y5oOjrDtQ7M
   Idv/3gnJptY6TxYbapzOLKioq5mTfI1bK9ss9IZDGnjIDjIn4PWPrZUzW
   MJ755I891K05ebw+DF/9y19I+8tVObj+ADlftHblfbsKAa6KRu45JCPkf
   HM6imBSJZE/+lZ8pYTcTjlawg3S3TD4Tc1NoL4K4si1F92bv3EHhAwVNp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="7822529"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="7822529"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838261011"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838261011"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 13:24:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:24:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:24:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 13:24:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 13:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVLAkCQYRFyTu2e8pYzDqCZLSQ4mMsZSpjdDu6bgZleSE6nCQegMMGVMZHm6QiCqiQ5e7HMUQvmQTrG+LGKDr7bUfZHyZu99mD1KFmtzMtDWazhmrBiBg8SMh6nQaFhnIfA4oILf9NG2847Jx8n9Ta1VVclBg2jNpg21V0QjesxrS+jL26yW0oyVRsPpaIotVUMfUdzdBFS4+3U+JZ9JjO2yAImK1ebQJp2/kS4uYcBX0ZuZ6nlaELsrzToTopk9onjEx6YgnVv+AQVs9hd+dFm4M3/JZy2Kis8H1LFKPhY6Nlg62K4fjD32FyfqXmla/KSlS93G1s4XZd2XIV7i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaR1/E7FVR9OreuyJ9EIZu12kv65dF6ZEe4xWkbjrs0=;
 b=LDpag376xYN80aLiSuiDU2Hz/qIYjh778NGLKukRydrId+eyK9qyeKfv54Xjg7+BC4w2uKiVd8K/8UYveWIFcfOFrz9ZCJEZchkDXcxYf447oPVscjSNEgzvs4m7uHd64hQ73NzJpEDnBrHlQl37kifghmWM4lTE4x5FoRXmXFPv6FTDfFaie5OlkrU8oeUtjNo2tDQs1cc9WcDuWbEXoHRHwHWlJNadqHP7kedjs/NQwYQ4oLzZxLG8EWUUDD2fn8w84o1gMQ2izGWj62JQA5WKXcPVAm/3X4NTeO5XAyZXSSzy98RGuzYD1CeZ5uoLvZpt3LlHnScCv5nGHML+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 21:24:24 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Fri, 8 Dec 2023
 21:24:24 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMbu7P34L+weQECt+BHOvhNpUbCdfY8AgAC3MoCAAOlFgIAAyj+A
Date:   Fri, 8 Dec 2023 21:24:24 +0000
Message-ID: <ee14082752fd634d7b619b7dd438170fdc0bbe1a.camel@intel.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
         <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
         <4b1a415e-6a56-455a-a843-277cc08d05a9@fujitsu.com>
         <96a55ffddd8f6a00ff00e6a67e50d30129ae2456.camel@intel.com>
         <ad95e550-cdb3-448f-beb1-fc4899053639@fujitsu.com>
In-Reply-To: <ad95e550-cdb3-448f-beb1-fc4899053639@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: e5399596-f0cb-4c21-1267-08dbf8340d26
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzC+NxsxRVrUUgdzdSlMyl1kts4+3qSMmIdLbuxZFbeS2Gk6pdtITW9kdcYNU+Rum48+PnuY1hq/Kbm+CXL5WCwWjqlT9EKAj209PzzVrGtHcx2AhhctDaZJRVHE11VXg6eCnB2+kSVzDlMPcicGzxPREVzFTrsn2/ZDaUVWHD8RSl7qsQK7n207wyMKcec7XFNhBybPD3KzxKdPr+71U0C7bwKGtZs2UxvDYVX2THPpv1BbwMHgGkL5BL4mlAx0gSBqxWq5MtnrIYi1cy6kjChT/46I1WcGOJxZA0E1xzlIjzeYxhzSuCwWsraaeZomjHflvhukBNa7OR7BI/ODzERIQWDwvjsNaBgae1tZhZKRYdXcEu12z2cZbN4u7b32pLVr/ZvSgB561tlW9EDZjIlDDsvd2uHHTyBBZLJZbQoxHCElixADQHxPXnuirt59fKDMlgr7aw3oQWGsr42QtMAdzRglk22LQYEH3DZUEfw4AGFFgFLt6xz/GGhbLBOkrtbv2+yXCRsvUmlzMf6HOmtILJLX2/e9ZhmqRTMnLtMuBCatO/inVTyOcznf4D4EOj73g7lhUixvEEMuFOt7qWa93haLLmnguLBMnLDO88vH9Zj2TEZGSYoM/GTGSw5N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66476007)(66946007)(66556008)(316002)(110136005)(6636002)(66446008)(64756008)(54906003)(76116006)(122000001)(38100700002)(36756003)(2906002)(86362001)(41300700001)(4326008)(5660300002)(38070700009)(82960400001)(8676002)(8936002)(26005)(6506007)(53546011)(71200400001)(2616005)(478600001)(6512007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnI0WERkKzVBd3JDN1hSRTVUQjgrMUU3dmlvTUh1RjBIbHkwZElQUXhvWk9U?=
 =?utf-8?B?OUxYdyt5dVVMTlZWZnV4bHNzZGF3bGF3MitBbHk0T09CbW9XQy9YeENPM2dR?=
 =?utf-8?B?Nnp4VE9xUnZaYllmcllGZFI1MGtJbzN1ZzZuVU5pNFhCMXgxTnZQNVlIZnZh?=
 =?utf-8?B?U2w3d2k3amtxb1dJSFBvOEswRldUMGJDa2w0OTBrZDZHa0lwQ1JrYUpkM2pP?=
 =?utf-8?B?RC9kb3l5bVVScFBsR3ZzKzRsNmJWZUF5bmFmZWN0eDVKUnZ4L0RseGxlV1BP?=
 =?utf-8?B?dkprcjFOWFAxS3ZzYjRBeXF4VE9Ya0xLSkxXTXlDQkVYMGtGRkpiZi9mMERj?=
 =?utf-8?B?Rm1YcHBpb2ZxV3hyS3A2TUF3aU9FQmFmUk9mMkZ1NWZDOGVGQm4xdGJkaU9p?=
 =?utf-8?B?djF3L0l3ZjRiRnFyM09UU1QxOEQwcEY5djFoTlRDcy9MNDFmSmlRWHdJcU01?=
 =?utf-8?B?eGlJSld1Sk5zS1RBa2xvZ3c2RkFZVlJSNm9rUXE4QkVwSnA2OGpsTkg3UkZI?=
 =?utf-8?B?dFIwSjVLRHFwVVNEZ2s0bGloazE5UFZ5L0YvTG1JaS9VQmxOVG45cStyMDdl?=
 =?utf-8?B?UUFDeHhmZUNlMktHVy9KbkxVWXlDYWZPbDdaMXNKWnZPNXBsdTBsUkxKSFhz?=
 =?utf-8?B?aXRQSGhXTC9VTmV3cWVqQmRVcFpUZklpTjJKRUwwVEt0NzA4N08yTXlMNW5C?=
 =?utf-8?B?L05tK2ZPT2hrd0U2NGR6ZkVGSSt4Y2hLRmV0Sys0ZFM1T1NUVDhmMXhoTGN0?=
 =?utf-8?B?bmtXamRic3dscTBtakQ0YTB3c0EvNU11YTM5dzRhVWFOUmFwV2N0TG5tenF4?=
 =?utf-8?B?QmN5RXRWSjVNcWhDTmJ1R1g0ZTFmdUhZOENpVzNHeHdXSlZuZldxcVRaSFZ4?=
 =?utf-8?B?Z2pPcjNEeW05ZUVtazV1RXNjMDlkUVJuM2lBYkZ1WFhVVDN0Q3V1MzFaZzJw?=
 =?utf-8?B?eFd2YVNDSVJyblRENFRNUk0yd0RCdkJrcUNnVUZKMVpZSjh1UDNadHJOd0dC?=
 =?utf-8?B?U0tQbVloVUJmNjF0T1Z2SE1jNC9DVllZMFBmQ2d6bHE1OU1GVytGbkZwK1lV?=
 =?utf-8?B?OVZqZTlZWEhlRElNeitWYU0wY25pQU5qYWNrOVJKZm9Sd01pUHZwYzBWVVVl?=
 =?utf-8?B?dGJLdnlXcFZzYXBGa2c0TWRuQk9EWVJjdnRDU0dCRUNhSjBDcVE1M0FaMnA4?=
 =?utf-8?B?azEvU2NkaW51YjUydTdtc2s4cHVCKzMzejNQMnB5M3I5ZWZKa3VIeE9JRDE1?=
 =?utf-8?B?eGV2R3J5YlM5UWVlcFF5MXl0Nm9DQmh1WmVmOFlwRlJtOFZVa0N6L0pzemlI?=
 =?utf-8?B?NExvQ1lXWHQxTFdSQWFCc0lPaTA5U1dDWG5vWWFlRU96N0N1dlg3a09lclY3?=
 =?utf-8?B?cDE2cFVPaHFmWmRmVU9VUW5DdFpWYms3Qm95NGNBcFhiTW5rbFRvaDlKZHl3?=
 =?utf-8?B?NTFIR3craEI0dEJ4QXlwTllaRTFKN2tFQjU1VkgrSzF3a290QmZ5UVBQY1NH?=
 =?utf-8?B?YXBtSmc3L3dqUjFnTC90UkVEbTNjZDVMN2I1a1NOd1ZUZVpVZVJERnlsS0cv?=
 =?utf-8?B?OWZzQWJ4S1pGeHVvQ2VDK3F3cjY3enFMSUV6aHUxVE10N05kaWQxTzJmdUh1?=
 =?utf-8?B?TVpvaTBRYUQxKzRzdTh6TWgwMTI2LzJCMDM1S0NCVmdTcmRmMlZVaXlvVTZH?=
 =?utf-8?B?Q3BqSFpjS3ppTlpRRHFtblBaZW4rTjBTOVE5RU9pZitoTmNWenZjSjNjUkNP?=
 =?utf-8?B?TE1WdzdZSDlOUEpkdzhQRFhhZXBiTjVybnBjeFYxRHJDN0pORlFsWFNKLzA1?=
 =?utf-8?B?VS9oeWkwcVQvUXZYanlZbzQ5V1JJY085cUc1aDJtZXMvbVZoV3djTGI4SWxk?=
 =?utf-8?B?b0wrS1crcFFYd0FQSHZmWk1DM1VmZ3g3N05DaTdCS2JNbEtnUytXU0Mzazdw?=
 =?utf-8?B?RWNSNnY5Q0l3STBIR09xY3ExYkNCem5tOTRkYVB4Y29Da3VrKzZSb0duUlha?=
 =?utf-8?B?MmMxb0dPQnlSL2hmNGxoVFhtRkRRVUhjT1VHZmYzUUZZb283SjdWYVNlZEw3?=
 =?utf-8?B?TDlEanZIcnZVZFcxZ05zUVdLTFFjS0gxYjI4YUliN2JwSVo5bFZ4M29XNjBM?=
 =?utf-8?B?R0o0YThjakcrc1dSRVlmclpMNDJjQ0FCWlUyTmZDNG1hdUg4a1paYTZJWmlu?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D02A276C22607469603AC98F92C83BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5399596-f0cb-4c21-1267-08dbf8340d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 21:24:24.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIXD+l7inA37zFDqKK0unaKhr+veFC2x8+8L4VoLyZmqg+x0qz6m3tDXkv6D/JLXhkcqL9PGdTKNs0xQ9iP9MSCEmo0rEtHawoAeHQdG1BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
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

T24gRnJpLCAyMDIzLTEyLTA4IGF0IDA5OjIwICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3
cm90ZToNCj4gDQo+IA0KPiBPbiAwOC8xMi8yMDIzIDAzOjI1LCBWZXJtYSwgVmlzaGFsIEwgd3Jv
dGU6DQo+ID4gT24gVGh1LCAyMDIzLTEyLTA3IGF0IDA4OjI5ICswMDAwLCBaaGlqaWFuIExpIChG
dWppdHN1KSB3cm90ZToNCj4gPiA+IEhpIFZpc2hhbCwNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBP
biAwNy8xMi8yMDIzIDEyOjM2LCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+ID4gPiA+ICsNCj4gPiA+
ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9kYXgvZGV2aWNlcy9kYXhYLlkv
bWVtbWFwX29uX21lbW9yeQ0KPiA+ID4gPiArRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE9jdG9i
ZXIsIDIwMjMNCj4gPiA+ID4gK0tlcm5lbFZlcnNpb246wqB2Ni44DQo+ID4gPiA+ICtDb250YWN0
OsKgwqDCoMKgwqDCoMKgbnZkaW1tQGxpc3RzLmxpbnV4LmRldg0KPiA+ID4gPiArRGVzY3JpcHRp
b246DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUlcpIENvbnRyb2wg
dGhlIG1lbW1hcF9vbl9tZW1vcnkgc2V0dGluZyBpZiB0aGUgZGF4IGRldmljZQ0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2VyZSB0byBiZSBob3RwbHVnZ2VkIGFzIHN5
c3RlbSBtZW1vcnkuIFRoaXMgZGV0ZXJtaW5lcyB3aGV0aGVyDQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB0aGUgJ2FsdG1hcCcgZm9yIHRoZSBob3RwbHVnZ2VkIG1lbW9y
eSB3aWxsIGJlIHBsYWNlZCBvbiB0aGUNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRldmljZSBiZWluZyBob3RwbHVnZ2VkIChtZW1tYXBfb24rbWVtb3J5PTEpIG9yIGlm
IGl0IHdpbGwgYmUNCj4gPiA+IA0KPiA+ID4gcy9tZW1tYXBfb24rbWVtb3J5PTEvbWVtbWFwX29u
X21lbW9yeT0xDQo+ID4gDQo+ID4gVGhhbmtzLCB3aWxsIGZpeC4NCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBJIGhhdmUgYSBxdWVzdGlvbiBoZXJlDQo+ID4gPiANCj4gPiA+IFdoYXQgcmVsYXRpb25z
aGlwIGFib3V0IG1lbW1hcF9vbl9tZW1vcnkgYW5kICduZGN0bC1jcmVhdGUtbmFtZXNwYWNlDQo+
ID4gPiAtTScgb3B0aW9uIHdoaWNoDQo+ID4gPiBzcGVjaWZpZXMgd2hlcmUgaXMgdGhlIHZtZW1t
YXAgYmFja2VkIG1lbW9yeS4NCj4gPiA+IEknbSBjb25mdXNlZCB0aGF0IG1lbW1hcF9vbl9tZW1v
cnk9MSBhbmQgJy1NIGRldicgYXJlIHRoZSBzYW1lIGZvcg0KPiA+ID4gbnZkaW1tIGRldmRheCBt
b2RlID8NCj4gPiA+IA0KPiA+IFRoZSBtYWluIGRpZmZlcmVuY2UgaXMgdGhhdCBtZW1vcnkgdGhh
dCBjb21lcyBmcm9tIG5vbi1udmRpbW0gc291cmNlcywNCj4gPiBzdWNoIGFzIGhtZW0sIG9yIGN4
bCwgZG9lc24ndCBoYXZlIGEgY2hhbmNlIHRvIHNldCB1cCB0aGUgYWx0bWFwcyBhcw0KPiA+IHBt
ZW0gY2FuIHdpdGggJy1NIGRldicuIEZvciB0aGVzZSwgbWVtbWFwX29uX21lbW9yeSBkb2VzIHRo
aXMgYXMgcGFydA0KPiA+IG9mIHRoZSBtZW1vcnkgaG90cGx1Zy4NCj4gDQo+IFRoYW5rcyBmb3Ig
eW91ciBleHBsYW5hdGlvbi4NCj4gKEkgd3JvbmdseSB0aG91Z2h0IG52ZGltbS5rbWVtIHdhcyBh
bHNvIGNvbnRyb2xsZWQgYnkgJy1NIGRldicgYmVmb3JlKQ0KPiANCj4gZmVlbCBmcmVlIGFkZDoN
Cj4gVGVzdGVkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNClRoYW5r
IHlvdSBaaGlqaWFuIQ0KDQo=
