Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5067B1216
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjI1F2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1F2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:28:42 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957BA98
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695878921; x=1727414921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQFT3wU3MSsuauTF8ON/QucMcx0LNNhVf1nPDoZIJpg=;
  b=Wpq8KIG2LZzr6xnpxpu8ku0n4hQ89ltR/c14Vqx3NeVkZEMMChKokNGT
   X1SXviifVUQHEoNQhjRscO/lxT49t0Bha3rOOrU2SzXazWMS3ERCu+AYL
   e202hxakL7x4/1dgx8k0LGxf5bsbVDj9pOwpfIvdzPFCGA2QiwyZ5Eedy
   1kefBo26ba8a5NLR8WyGLbW0cWnhWGzB2byW2XINnjjodV6jkmd90niup
   in/iNmDioNOrDQlTrXhttZU5FjaAUj5Atez1MiqDbQ7hz9BcTOAJumDS4
   oSCMztsUxnTgMWXlcZnyQn7+EvIw7S4WC0jBhx50+CAjPHyna54SZ9AyK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="96851055"
X-IronPort-AV: E=Sophos;i="6.03,183,1694703600"; 
   d="scan'208";a="96851055"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:28:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDW3d9ZFWy1tctCqbeu7jUpNM6i/DbZzsVgCnpz2CsKxhcJr5ZMai2TufNXlm6Flij6OmZFoHuc0VUyipgCOTWj9UWl/Ivfs5Zsw3dWOxeOzcfXfpPJ9mrl5Do05Fhl+6n4Q4XN3k6Ppgrhv6xs7gh00Qkcuo2f7tL0ftaPqjKsUNpYNKfUVC2IQ+JkARoPti+XlGp9QSL8ybvbcyYudT54LT7NBHPY+uSyHgsD9Rt2lbsG/JbqncBCt+BFld8z0/W2elxIV0EjHILLYEtLlKdjUChVxeVe5NBNaPXGwarJl0kufLlZ0hU3szpA25rZzNT7jOIdV0RbYHYnCLTGjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQFT3wU3MSsuauTF8ON/QucMcx0LNNhVf1nPDoZIJpg=;
 b=JklFjlAaZ5S+pXmbROiQysS1fmDiyS+DYd5cIakxMKtPgPe4sNEvwRSHmPveL6xCuKrYrdyZqBYWeNBKFdzSRdSE1xpeDfv/Zb+nEzUdA1TV7Rws9OVwLi+e/RR/RWgfAkFwouyTAu07YQCvCIceW9GjBDntMuRXtNe8mdZZpNrpsDSpPKqurlAuTeciqVHy2SyZ4+W0d4Wid9RooTH44lldXOftzX0YaPtPTGv5HFc0MUZJiNn8uhCC0Q32j928taL23LLdTkV1bDdEJf+gi5/HDmRF0y4htQsQ47L72toO0s5EzJVcrup7VhXG8dfZyXzsuoFefveoVhcLhDlrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB5575.jpnprd01.prod.outlook.com (2603:1096:604:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 05:28:27 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6838.023; Thu, 28 Sep 2023
 05:28:27 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Babu Moger' <babu.moger@amd.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
CC:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'babu.moger@amd.com'" <babu.moger@amd.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
Subject: RE: [PATCH v10 00/10] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v10 00/10] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZ8cuI67a5EyKeVEey7X+ZHh+qrbAvtLmg
Date:   Thu, 28 Sep 2023 05:28:27 +0000
Message-ID: <TYAPR01MB633074E7E850F680927780F68BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
In-Reply-To: <20230915224227.1336967-1-babu.moger@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZGNkNmMzZTctYzU5YS00ZGIzLWE3M2ItYTRk?=
 =?iso-2022-jp?B?NzA5NmZlZDdmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDktMjhUMDU6MjU6MTNaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 1fe734080c1a454f9771c19a406d9d10
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB5575:EE_
x-ms-office365-filtering-correlation-id: df6758df-0f8b-4668-98fc-08dbbfe3be1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkyx1tk+cxN8Ba/bgxUcnlWVMFh2gxnoIKx5ezNqzIEoci9wWuqYtQl4JpM5M36JqpgPKXyhcKL/8r2aCqkfm5rIfEi/THQH/A2+Al/UHmzyqaMQK+4iuxIwn2gYK0RAjAXF/OaNBid55qE/fcdrkT18SFKzcNEX/IRK4O+2hv8s/kvF9pIgG0hoK6Y/RnTdwNiJ61Hn5zgNUHMg5eKWtX4jNfxMhNd+sKvZrz+LrraUSuYYIL6kMoYJYkBWf5Rbjyvnuz6EuUlpLCBDRtQ0a2lVFBoobOwDyp/WhPT9RIL7kEKT+HEhoK2XY3ugG0RQdakw3wz2LL6W9njGdYFphaKrMXlaSoQmDezMxIsbCcCxWw11ajUT+0YlcGgKgDRcrWevz2KifOy1OYoy2ilRBbg8ygl3E4AFWX0tAHvCajxNMqJhJoBEHq1Fib5Nj/sR4BHEo2LWV1gI7XlRfe/FKLPGkWUraEBVIlhodhqzhjtZATjUimNLVXBZu+Vdem8lIHzicYA1ADywvGVjPVe8FzXMCkaKqcbZ3Y604WJA2g2+4qZ+2bwaRb4PydMWmzneGaMm0MBj0iQ/3cn29FttKxzLE/RJWCnFzi1ZyPYUPBDzHeyu0apdyhcmEUzjeVtYjiLymC/TT3jq6P+wB2T5Zet47PAKZZcOz4XrJBnyM4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(1590799021)(186009)(1580799018)(478600001)(9686003)(85182001)(26005)(7696005)(6506007)(38070700005)(38100700002)(122000001)(82960400001)(86362001)(558084003)(33656002)(55016003)(71200400001)(7406005)(7416002)(4326008)(8676002)(8936002)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(110136005)(41300700001)(316002)(2906002)(52536014)(5660300002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UFNpRTYrRnN0TjVKMFFha3pubDB3ZTRJVEVxNzRlbG04MHNScjBKQVFC?=
 =?iso-2022-jp?B?M1gvSjBlMkxqSGhCUjhvdm1BaWM2ZmgwZnlCN0tLamRDMVBhZS9ycE56?=
 =?iso-2022-jp?B?bVE0UnpHMTh6ajkzdXpKS3B0V0ExN0RmbENEMExyTXM3S0VmVVZHb24w?=
 =?iso-2022-jp?B?dFlSdHlJemxxOHh3YUl0bk5OZ0E2V0FldVFzTUZHWlYyejhHamFrbEwy?=
 =?iso-2022-jp?B?WjBKdDhsSy9MeHhkV1pHaFdIWEVEMnNrUWFIUndwa0h6UE8vWHBpK01D?=
 =?iso-2022-jp?B?TUJkZVJvMkFoWXQwVWpScjJEQUp6bXRncCtma2tiZEtZUFJRS3czK0F2?=
 =?iso-2022-jp?B?S2pFaG5QMGVQSTBZa0d6cHMrRXJ5STM0VGhySnFiaUIrM0xUbi82SVN1?=
 =?iso-2022-jp?B?ejRtZVJMVDlOa280ZXd1TENTSS8wU0NRRUpjY1B0ZHpwVWFzVWgzWGVV?=
 =?iso-2022-jp?B?akJJbzNsNVdWbzBoejlTYmJhYXJ4R0FYZlJQcEVucENRdk4vNmVNMG5M?=
 =?iso-2022-jp?B?YVVUdmNDckpZb21lRWFNY3dEdFh0eVFjWnYrWHRCdHpQNTE5MkpQN3Rl?=
 =?iso-2022-jp?B?aVFldTcrR3FHekpONlYyaXFadDI4WVhaQ3h2Z1ZsSEthenVLdlZiL2k4?=
 =?iso-2022-jp?B?ZGF3dmZmT1E1enFVZS82TWM0d3hCa3luZVdMUTNwdGx4Rjh4QkNpOXIw?=
 =?iso-2022-jp?B?ZTlYaTU3U3ArODR1YU85L2R2ajNHNGpYWG5tL3VQbWh0RGJoeUVXOGRR?=
 =?iso-2022-jp?B?cS9sS3djeDdWeS95eThqN0VyMitNRUg1bzFFbkpVaythSXNMOVhpUHNm?=
 =?iso-2022-jp?B?VmdYbzVQblRLVGl3UFA3NFFWbUlWVUR6SVQ5bjh4MHFTQUpJYjRyS1Uy?=
 =?iso-2022-jp?B?dWYvK0F0bUhNb1dsMWhEQUcwVDJRcWJZRlp3aHl1NzEvb0tiYkd1V2N1?=
 =?iso-2022-jp?B?dzJjbHlsZUNITG5Fdi9UUkM3RDhCNElaVzJlSjhrMkJKRVg5Wm44Skpr?=
 =?iso-2022-jp?B?UGdoU0l5UUNsSkxHdmdxM2xYQkg0VUgyWnRtMTk2RTJHaGtrL3p4L1VF?=
 =?iso-2022-jp?B?TDRTSGswTDdVaU91RlJtb0tlTG44QS9TT3pYUG14b3d3UUhjamp6ZVhj?=
 =?iso-2022-jp?B?YVJDWWhveHdQWkRkU1VJMmRhbHJRc2RaTFR4M1c4QXNpa2ZhNUJTSXdI?=
 =?iso-2022-jp?B?SGVqdDRzNVM3Y2hUVjNveVkrWHFQMEptb09vaGhoRFBpVmM4UVp3eXQy?=
 =?iso-2022-jp?B?NFV5dkc4NFNTQVN3U2YzaVlHQzdJL0NKRm9IdlI0MmIwMmtjZ29QVnl4?=
 =?iso-2022-jp?B?akZFbklBT1NOUUNpMWd6WFRPazZLY0xSalE5M285c2NEeWJoUUhzNjNs?=
 =?iso-2022-jp?B?SFhLamVPT0xUU28wQzFrNmFaeDlMeWxMeTlkSHJiZ0dOamYycTVZYXB0?=
 =?iso-2022-jp?B?eFZZbmhBTG9rRTJBcThNbkIwcmtWSEdBRktEZi9wV09YVUZ5RjZvZ3hE?=
 =?iso-2022-jp?B?K256eXRDNXphdXFHODhpV24zbWlXSHJrcUl4aFNUMU9NeG9vOE82blNR?=
 =?iso-2022-jp?B?QTBIdFc4RzlEUUxFYjN3OTgzS3RIQ2JFNi9kVHp0MlNIVGhKZGtsK0p2?=
 =?iso-2022-jp?B?U2NOWENaK0pIb0ltc0FiNmxISlFkL21wSEpUcjM4NFZSUmNMNFgxSkRV?=
 =?iso-2022-jp?B?aWxwQ1crVkxTNnpvVE9aVkI0Q0xKUjRsQlZwR0xQRFd2U1BleTdMV2xX?=
 =?iso-2022-jp?B?dkd3QUN4YmVPeDJVeG5RQkpPL1BRcmpvbEFBbk50ZDQzK0xXeGliZnNX?=
 =?iso-2022-jp?B?YVlvTTNXVWYvcWQ3MENQYjFqanIxU1lTaGZERTZnOVhjTjBzMldTUE5v?=
 =?iso-2022-jp?B?OUVFOEZqM1hHaDZid2wxeGM5LzVnMG1Vd2R1NmVyYXBJam9DNVdjdjNw?=
 =?iso-2022-jp?B?blhuTlRNam1FRENYd3pKUnhzNXdZUkZtZXNLOG5QeUN0d3dwY0pxWkt0?=
 =?iso-2022-jp?B?cS9mSUNWNlJXOXc0enhKZk9xQ1kwY3grVFozMHI1Rlp0Z0RJeVZKL1hN?=
 =?iso-2022-jp?B?U2QxRDZaN29qa0pydTFsa0xxNFpPcXhCV09RVWtMYXpicy9OaGdWSStx?=
 =?iso-2022-jp?B?NVRTWUhJdzN4dXU5OGwrWU9RbXhidVk2M2tDa040U29UYlE3bmxsazJ5?=
 =?iso-2022-jp?B?K3lLNkdPQjh6aThrem50ejFkN2JyZmErWmtQcFQ1SlY0NThRa3lEMGJ2?=
 =?iso-2022-jp?B?enM2QnBXUGpsZFJhRVhkTUEra1h4R2VPd2FtT2NycjlhY2pYUldHVUR4?=
 =?iso-2022-jp?B?OFpmZVFKa2ZIR2hLZEk1K3NSZ1hvY0ZoUnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?TzRYL0FidlFEZHh4Z0VCanVLNjhzSjEzWTgrUE1ickJBVW1aNjI1Vk9U?=
 =?iso-2022-jp?B?V1lzbTBhQklpVm4rMDB0RjNYODN6QjJvR0tEZkZqcDRzUDN5dEVhRGdo?=
 =?iso-2022-jp?B?a2tObjZlckxXSzg1ZGE5ZkpXSk1kSzlobGh4QTdhaHdFR3dMRFBSNG1t?=
 =?iso-2022-jp?B?L1hPRVFFWnN3RE9Jd3l0azRFdHpXVi9jN0VLWTlINVRSWXBabTlLZWp0?=
 =?iso-2022-jp?B?Wnc3cENUL21LZjFzTnlvT1hRUzFjb0RoSEFqa2VuSWg3bE0vUmRsR3ho?=
 =?iso-2022-jp?B?ak5NZ0lQT0FmVzhQem9sa2J3OTltWVR3K2psMDNVUWtsdVA3c0N6Vm4z?=
 =?iso-2022-jp?B?d0l5VEpaS1lsVk9oVXFseS95N21jOHc0bFhsdXh0UUFLL2J1a21TSWlm?=
 =?iso-2022-jp?B?eDZkU0ZMZjZ4MmVyUnNvVzFNSXEwaUFOVUdQZWtGTUtsaTBXWC8xVHhE?=
 =?iso-2022-jp?B?K2c3OXFFdHlPTm5KcDlaL1VNbVhKNFh6RzlKcHEwdy8ybnd0dnJWSkhF?=
 =?iso-2022-jp?B?cXlVSTdjbjROem1zaDlYSXNqMUk2N1EvTkJZc3NwWWdLdno2ZWFtUjhF?=
 =?iso-2022-jp?B?ajA3UVo4WVdmNUNJd0pvUDdJcDJ6MlNLZUNqbWJ0L2gzRGZUVnFIMHox?=
 =?iso-2022-jp?B?cCt6akROMG1Zc2RaNy9rbFlrTEk0a3pZN3FqTFFCNmNqZmFsMkk5dXZ2?=
 =?iso-2022-jp?B?RHNacFZEbGQvT2Q1NldTZEw1bkJ1cUxNaHFhU0JXUUQ2N1lzTTJRUTY3?=
 =?iso-2022-jp?B?SjlYMkcwRFM1bXQwOC8yTTZ1NWw3bDc4Zmovd3pFNHlzY2NXZUdneGxt?=
 =?iso-2022-jp?B?Vjl4Z3EvQzB1T1NHM0lmUjZYWlgwNk5SUHpvcU1pSGZ0TUwyM1YyZlU3?=
 =?iso-2022-jp?B?a256WFVaYWVzRUpmY0FXZHh1RlZ2aVlSWWRCTGZlQ1dqakpENllTY2ww?=
 =?iso-2022-jp?B?WFMxUUhXOXRkRFNWSmJzVitQUTIwTS94ZlpybGpZOHNYNTcrQWh1bExm?=
 =?iso-2022-jp?B?M1NKNXdnVE4vYlpmejJqSVVzVkpkV1lMT0ZpQWY0OWppcXkrcS83UnNp?=
 =?iso-2022-jp?B?Qm1LM3l2eU5oN2ljUjNlUU4rN0x6N2hkOFl4VHduSHQ5ZUJ3b3YxQTVY?=
 =?iso-2022-jp?B?LzVRNEhYaTNiM0txQkszUWIvNm9UOEpucThHODFmYkhhSWhSQ1VwczFR?=
 =?iso-2022-jp?B?RFM2eVlGYWFRaHV2NGMyekdJdTJYUGhZNEZxWmxKcXpzRUNacjJnM3Jy?=
 =?iso-2022-jp?B?SXlsYzBiekt3V0FvZkt0U3dsbmVLaHNPZDF6WXNTczY5SFNXT3VWTlJ0?=
 =?iso-2022-jp?B?SHY4UWthM0R5cGRscHAxQ3lHQlBRdFBZeURnbkNXVTFQVWEzZ0ZHY1pE?=
 =?iso-2022-jp?B?KzMwaHpPZUIxWlgzc0I2R2hRenEwcTEyMDg0YnB6cmxwWVB4bjZpb2N5?=
 =?iso-2022-jp?B?M1Q1eUw5UzdOQkFCOUlBK1g5VTZKUXVQbnVVcmJFblNjbzlnR0c3Vkt1?=
 =?iso-2022-jp?B?ZEcwU1ViTFhuRWdEZDk3QmZaZTZJUi9vNEwvOEpWU2NUUSthUzZVZ0hC?=
 =?iso-2022-jp?B?MnZwNTNEVytFMlAwcTRXUUhnUm4vZnBoNVRHaE5iM1J5S1gzSHVHeUR3?=
 =?iso-2022-jp?B?TFRtdWpoMzYwMS9pM0dPaDNjZEduODRxZVE4VWd4V01aVnBXTElIWXh2?=
 =?iso-2022-jp?B?ZktKaSt3anVpVDZmTkZOdjI4OHBXVENKKzBwaG1JbXFnYTRBUHY3ZmxJ?=
 =?iso-2022-jp?B?T29YWjFWMTJndjQ4QStUYTd2ckpUMlVXUmlWK2dyRVcvY2VGM3I1Nm45?=
 =?iso-2022-jp?B?ME5heCtnZnVtaDlNTk45MDR0Um5zdjl3TGpQU01tSGlCcnBJcXFtM1lr?=
 =?iso-2022-jp?B?V0x6c2RkRy9MOXArQUFKb1RrOXJHanMvZFVZSHJoaVVKQjBsT2txVXlv?=
 =?iso-2022-jp?B?QTB0M1pBYktmcVdPbkhlc2d2Z0Jydz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6758df-0f8b-4668-98fc-08dbbfe3be1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 05:28:27.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIUI7tVFz72WhRN/z6jNKx4/3lQnxVslwtTVIOAPFbj6E+2lDKI5up+5yS9/sRO6gDRHBRgBNySleqBpPF1pKNwMIdLvX1b9UcduWZKYknE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5575
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

I tested these features and ran the selftests/resctrl test set on Intel(R) =
Xeon(R) Gold 6254 CPU, there is no problem.

<Reviewed-by:tan.shaopeng@jp.fujitsu.com>
<Tested-by:tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN
