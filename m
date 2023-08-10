Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC04776D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHJBeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHJBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:33:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E61BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691631238; x=1723167238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1SSweZ3L59VWMAen46cDLa+lMhUhsm3Nfyyxd+MtXbQ=;
  b=RFQcixJ2rvhf+GIETxKLx+zMNwk9kSVVICP7iIeazWycLM+KMeHIsgqT
   YItKdDqsPJSOGgp9xb2Zgn1xoXmc0gCGaElixjCp3SvYwdXMeXdin7lSr
   bi523cHEcva5A3tq0adwelZHZCF+JdFil7fRMe3luki/PfkIrpS2Ll8TR
   hYcsxaKVyqk4gjcNbHOKOMVZg5/uByzneXZlJb/0MU6qI4zCbFA+HoN1V
   Vxwfb/htzbJLPstzOFcKE54Oif2Irsgu6JL27zjx0jsaBVp4IaWlAKf6k
   KdSBFxgL+IkpMtFd6nZ+QEbMIvk8WN+HBTeFdZNMLJ0CsKXJe/dcnIE+p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351574945"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351574945"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062709574"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="1062709574"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 18:33:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:33:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:33:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 18:33:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 18:33:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1+MMZT3SwbMfS+BQP0vIFXQ1sVlop4H99J6zy5KMXOHMATA1A60NSGwqFDIbgeidEsTpCH46JyndOIta7UvjookoYrdZfDV00fWUg9bnJhf0Z4RkUe1Rnaf1BQvTRI97Y8idT4eUx4ToWMpjR601Zo3siyWjNnBf1qg/dLKanxX/zr9FsXUniD6Db5xld4bHgbQ0IHcTJuGXgiaE6kwcTeVKfG+zSL52ITQNfdymIIU3SlaobYNoV6FS1UWiIp6tQ2xjC71dCKTE7vxDCv63aw7CHNK0EAyG1QaZkAX3U0zJT9Aq6lm4ZnQwunUOA1IzsEcluhEWHigPekYrA1yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SSweZ3L59VWMAen46cDLa+lMhUhsm3Nfyyxd+MtXbQ=;
 b=L/8N0456sURh4AiryI6yAJl/7kujDU8WapX5zDl5ccyxjm1pj5unuFk2f5dxAaH9OjcEXx07rGyBsGmsWsMXVymsW7OiSFaJeNycONQhF5ZucRQN1TqD9h2z+m/A3MMZZlxSVwaV20LS3mWNMTdoanr+ONL8l2DjisGe8cahetUQ61wSUCFw0PSNKBKgp/CgjYrJwKpUz3bKTZt0vvZCSpDCxOkuaWsjb2urZr9XwdUWutBgFyqUQMlr3xn9Q+tJ0XkcwYGxmhvfmlse6k+Ktiycm17u5u9r+drJYMysdTCIjKUy8xlzDaD+/tFTjz2jjp3HQvUYcvfSQHGoEk/ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 01:33:54 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::afe6:1e86:52cc:f71d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::afe6:1e86:52cc:f71d%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 01:33:54 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [patch 00/53] x86/topology: The final installment
Thread-Topic: [patch 00/53] x86/topology: The final installment
Thread-Index: AQHZyuGnzYL5HcYUGkiQwCEY4uo+2q/iNrQAgACH5WA=
Date:   Thu, 10 Aug 2023 01:33:54 +0000
Message-ID: <CY8PR11MB7134E7CFB25F18985B1BA04F8913A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
 <20230809165019.85611-1-qiuxu.zhuo@intel.com>
 <7dbcad27-8454-751b-cdbe-4b755e2533a0@intel.com>
In-Reply-To: <7dbcad27-8454-751b-cdbe-4b755e2533a0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ1PR11MB6180:EE_
x-ms-office365-filtering-correlation-id: 960114f2-5118-4b98-ce0c-08db9941dbc9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxzSlmAYq3Ldb/hT4IyCQd7DBL3Uw2//9+x42LZ+agdT2eYnsG4aEEk+8wUUhE1EPTX1fHt1F3htC0AY6q6YQXYCXX7vF+VcoxwtDRJbzx8YC2DlGzAfwjlBoEFwJZLQmq9X9pae9k/fJ3XWvyWEqDEfv/8RRR95GWfWEWPoWseFyyqRvx9Ks8ajKiCNA/DxPMyBt0nmtW+agyc3ZVm8U63/qRSAR+J5mLebwFOV7uuaHUadmFbt17ssrpSYVN7qhysdo2i1VbFDXjcmaVHBQJcgUvVk1PB3R57yZIL5I0QL61k4T1YOpxZdvogNMdVQJYiUS3PixQ5WH/pBwB9HdFVAXv18YNfoXP+5Cr/9qo2m9fEpqBzdAZcLnzoe5niC8MmC8+GpLhQFvs+CeBNdDxx38nawRphjpg84XPWEwWcvzTauFQsXZN9DgOsKxpZZhUUzrCHV2G5sBndl6WrPA4fyYyTZfs4SlVAnZBy3qIZQYwBP+VCOKOhvkE265BeSJ0oP00mmQgQQvjX6z1qLBwNzjWplr7smqhh+AgjEwBDPUZyPm74wRnS0iDmUOou9fFsTA6HABtLMeFT3tNgjSNKfUZbZR+xY9zjqMLykFGiXxKdvxLV21rStdH9TTZG3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(186006)(451199021)(1800799006)(86362001)(5660300002)(54906003)(38100700002)(6636002)(4326008)(66556008)(66476007)(66946007)(66446008)(76116006)(7416002)(64756008)(52536014)(6862004)(8676002)(41300700001)(8936002)(478600001)(38070700005)(316002)(2906002)(71200400001)(55016003)(82960400001)(122000001)(7696005)(33656002)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTgySEZPcDFGTVZ0dHdPVnFhZHgvUGNMamNEWVVxdUh2dkJjcGVkd0VPdzI3?=
 =?utf-8?B?N3hOL21TVlhQS0ZJczhlT3Vac2R6UFpJeEFWNVVza1dOTmFIR3JnYlNQQVc2?=
 =?utf-8?B?NnpVbmcwT0U0aEZXZ2xydklMR3liS00xMFN4ZFdPNEpGWkNMRlRuK2FLVlZy?=
 =?utf-8?B?NUhrQVVjV0ZEdlRDL3B4djRPWC9Qd2Fudk5hWXRZK1ErSlUycEJmcFBmems1?=
 =?utf-8?B?dHFGWURydHpIQnErRGlrcnJzNG85bUpCZ3NZYkFqZkdmSzNHUHN2M3J2Vjk3?=
 =?utf-8?B?azluOU5UMGhxSTd6bzd4ZCtmcExSUHU0RHVEbFBuTy9HN2xhaUM2VUZvMDlH?=
 =?utf-8?B?WlJwM0JkblN1OU9jMHBwR3VtVW9EL29vYWthS3htVFA2VFMwbWhyU2RoUUtS?=
 =?utf-8?B?SE9XMkNyZkNvbWV4dmpjdGNDQnFNM3MrNTloZHZGcnkvZXU4Nm5GemN2OUp4?=
 =?utf-8?B?OWszNEN2RXlhb1R1cDdXeEpSQmE4YTl6UXZZVGZQK05hUU9sRk95dG5WZjZC?=
 =?utf-8?B?TXRyRFpZY091YnVNSzZLU3QxSEFMcFZtM3B0cHE5UTdvRFQrWDhJaW5CYURU?=
 =?utf-8?B?NFRjaHBiYWhmai9pSHBNVnBiL3lqaDFIZVhudHZxdVNIb1FPanRPZWVQMFo5?=
 =?utf-8?B?ODlXanFodms4QzdnNjR6aVZ2aGRlYllqZDJCQmwzV2IzNWxjSk03enVRMEZv?=
 =?utf-8?B?YzA0QWQ5NzdleTEycUtvUEM0bVkzV3JiVi96dEtkN0xTVnpKa0JJTXk0Sit6?=
 =?utf-8?B?SEQwQWgybWlwekl6L2QyY3kzNzE3RWxRUkQwZnZ6VncwWWFkRXc5S1lGZ3ly?=
 =?utf-8?B?S0hhNHd1TEYxMFQvNHlaTVQ0Z3VsWFBqOGoxbW9VVEd6cWQ4RS9odGdhS2Rn?=
 =?utf-8?B?emxTekZrQmZCOGRCa1BGS3lINEZyTHZnYWN2eEdtVHFONm5idWs1OWpvMjJO?=
 =?utf-8?B?UGR3cnhUcEtobmxYcndwTHNsZkJuYlhKTGhwZ3JTa0VCVG1LTmt0ZlorMEF2?=
 =?utf-8?B?VHI3VmZJMjhYR2pGUzRPaE15OUt6ZXhXSEdjSzlBMkpLOEpnZTJHVFNkNXBu?=
 =?utf-8?B?VDkwb2MxRWd0aitJbU55TGdXUmZxM1U1UXd1S0JxUFF5Y3c3eTd5UHVhT2tZ?=
 =?utf-8?B?c1ZwK1l2bnZwb1hoZVZ5dDFWZHNJZFoyeGVTSVNlR1JvbjlMdndKb2NqOUJk?=
 =?utf-8?B?dEl2Zm5ubDhsY29PaXgydDBSUFpBZmVvODh2d2R2TEhqVU94My93NStPTisv?=
 =?utf-8?B?eSs4SEFXMU1wdmdLb1ZGb29paUJ1RDJsVUh6a2NkeVE1QSs5dDN6dkV5WFRv?=
 =?utf-8?B?QmR1MWlNUndsVHArVVkxSjFCUllHMWYwYjUvZ0k0MVNwR0xMSTZZWDZ4aDBj?=
 =?utf-8?B?NVgrOWt1M3JqRExkMmd6RTJ5ZnZUUEtWVWU0QzRjN0NOQ1U4NmhsaDV1cTRp?=
 =?utf-8?B?b1NHNWRqVG8xMnpXOGVuUXB4KytnRitTMmk4dWN0Ym5sV0NWeEVuV1o4dCtX?=
 =?utf-8?B?UlhxbVdoVDBmYmIxTGhZcXJ2TmFocW12VmxtbmZGSnNjVjhScnh0WjNHam5Y?=
 =?utf-8?B?RDI2V2FoSmFnY043QTJscFN3bzcrL3BEbUtQdFBoQ0Y5anVrRDhlUjNQeEE4?=
 =?utf-8?B?NnBuUitrcUV5QlN1YXBQbkQzWG9Ta0xkY3dheGFBdWdlYWhHeG9SRXA0OVpo?=
 =?utf-8?B?K01Tb1V6ejQzbVM4N3ZJN3c3SVZVMUtINmRaQkpYS1REb3VzVzB4bVdQc1lN?=
 =?utf-8?B?cHExZ2V2NmVQaVpycDZidjhlN0xibEZJaU5xUkdTODZTT0NGSDBWT2pEaTVZ?=
 =?utf-8?B?aFNMOUVCaWRES0xhcnpIUWIxQ3JBai8vTktJL04xRWxXalc4b2lodlZlU0ds?=
 =?utf-8?B?Yk5GeTdWc2N6c0FNTWNOeVBreVBDV2NML3ZjRXhuQUJmNmdSQ1BKVUpCMTFk?=
 =?utf-8?B?R0pDSDJraTI2SEdocms2UWU0SkRjM09Ra1FsdzFVSlh4SWpET3RaL1RRcWYw?=
 =?utf-8?B?Q1ZLbkFwSU1jQThieWhHUVNBcmdyVlpHcFpRYzlnQ0I3U2VNaFN1WXNKK1U0?=
 =?utf-8?B?cG1XVU50K3dCOVJ5c3BQbHZZTHp2QVpFQXpNc0lsai9ndVlyb2UrZ1c2bURR?=
 =?utf-8?Q?HZJW9PTca95YLOOIcZV4J88j7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960114f2-5118-4b98-ce0c-08db9941dbc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 01:33:54.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZtbkPrjZQN/I03Ll+KBTCsTtS7No/e6Xgofjknto1PvTLaB0pwDKTNo+52/OwdmP95Yj8osreGv/JbbMimRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4uLi4NCj5JIGRp
ZG4ndCBjb252ZXJ0IHRoZSBvdXRwdXQgZm9ybWF0cy4gVGhhdCBpcyBwdXJlbHkgY29pbmNpZGVu
dGFsIG9yIHNvbWUNCj50cmljayBieSBmaXJtd2FyZSBkZXZlbG9wZXJzIHRvIGF2b2lkIGFscGhh
YmV0cyBpbiB0aGUgaGV4YWRlY2ltYWwgQVBJQyBJRHMuDQoNCkZyb20geW91ciBuZXcgbG9nIGJl
bG93LCBsb29rcyBsaWtlIHRoaXMgaXMgaW5kZWVkIHRoZSBjYXNlLg0KDQo+SSBoYXZlIG5vdyBt
b2RpZmllZCB0aGUgcHJpbnQgYXMgc2hvd24gYmVsb3cgd2hpY2ggZ2VuZXJhdGVzIHRoZQ0KPmZv
bGxvd2luZyBvdXRwdXQ6DQo+DQo+PiBwcl9pbmZvKCJSZWdpc3RlciAweCUwM3ggYXMgQ1BVICVk
IGlzX3ByZXNlbnQgJWRcbiIsIGFwaWNfaWQsIGNwdSwgcHJlc2VudCk7DQo+DQo+DQo+Q1BVIHRv
cG86IFJlZ2lzdGVyIDB4MDAwIGFzIENQVSAwIGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdp
c3RlciAweDAwMiBhcyBDUFUgMSBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgw
MDQgYXMgQ1BVIDIgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDA2IGFzIENQ
VSAzIGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAwOCBhcyBDUFUgNCBpc19w
cmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMTAgYXMgQ1BVIDUgaXNfcHJlc2VudCAx
DQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDEyIGFzIENQVSA2IGlzX3ByZXNlbnQgMQ0KPkNQVSB0
b3BvOiBSZWdpc3RlciAweDAxNCBhcyBDUFUgNyBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVn
aXN0ZXIgMHgwMTYgYXMgQ1BVIDggaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4
MDE4IGFzIENQVSA5IGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAyMCBhcyBD
UFUgMTAgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDIyIGFzIENQVSAxMSBp
c19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMjQgYXMgQ1BVIDEyIGlzX3ByZXNl
bnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAyNiBhcyBDUFUgMTMgaXNfcHJlc2VudCAxDQo+
Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDI4IGFzIENQVSAxNCBpc19wcmVzZW50IDENCj5DUFUgdG9w
bzogUmVnaXN0ZXIgMHgwMzAgYXMgQ1BVIDE1IGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdp
c3RlciAweDAzMiBhcyBDUFUgMTYgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4
MDM0IGFzIENQVSAxNyBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMzYgYXMg
Q1BVIDE4IGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAzOCBhcyBDUFUgMTkg
aXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDAxIGFzIENQVSAyMCBpc19wcmVz
ZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMDMgYXMgQ1BVIDIxIGlzX3ByZXNlbnQgMQ0K
PkNQVSB0b3BvOiBSZWdpc3RlciAweDAwNSBhcyBDUFUgMjIgaXNfcHJlc2VudCAxDQo+Q1BVIHRv
cG86IFJlZ2lzdGVyIDB4MDA3IGFzIENQVSAyMyBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVn
aXN0ZXIgMHgwMDkgYXMgQ1BVIDI0IGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAw
eDAxMSBhcyBDUFUgMjUgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDEzIGFz
IENQVSAyNiBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMTUgYXMgQ1BVIDI3
IGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAxNyBhcyBDUFUgMjggaXNfcHJl
c2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDE5IGFzIENQVSAyOSBpc19wcmVzZW50IDEN
Cj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMjEgYXMgQ1BVIDMwIGlzX3ByZXNlbnQgMQ0KPkNQVSB0
b3BvOiBSZWdpc3RlciAweDAyMyBhcyBDUFUgMzEgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJl
Z2lzdGVyIDB4MDI1IGFzIENQVSAzMiBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIg
MHgwMjcgYXMgQ1BVIDMzIGlzX3ByZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAyOSBh
cyBDUFUgMzQgaXNfcHJlc2VudCAxDQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDMxIGFzIENQVSAz
NSBpc19wcmVzZW50IDENCj5DUFUgdG9wbzogUmVnaXN0ZXIgMHgwMzMgYXMgQ1BVIDM2IGlzX3By
ZXNlbnQgMQ0KPkNQVSB0b3BvOiBSZWdpc3RlciAweDAzNSBhcyBDUFUgMzcgaXNfcHJlc2VudCAx
DQo+Q1BVIHRvcG86IFJlZ2lzdGVyIDB4MDM3IGFzIENQVSAzOCBpc19wcmVzZW50IDENCj5DUFUg
dG9wbzogUmVnaXN0ZXIgMHgwMzkgYXMgQ1BVIDM5IGlzX3ByZXNlbnQgMQ0KDQpUaGFuayB5b3Ug
Zm9yIHNoYXJpbmcgdGhlIG91dHB1dCBmcm9tIHlvdXIgbWFjaGluZS4NCkludGVyZXN0aW5nIDot
KS4NCg0KLVFpdXh1DQo=
