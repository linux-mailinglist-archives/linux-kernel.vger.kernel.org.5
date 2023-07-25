Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D59760A75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGYGnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjGYGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:43:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC108116
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690267381; x=1721803381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cfQ5OWzJnB2kWh8vg6u08L3oh11oPxumhpwMaFb8AYM=;
  b=F5XHA5WXydQK3GzKJ95NFDSbjKHfk5zVvYD4d8fAcFUBbXutBmPhHlLZ
   1qf/LCp8C/3clA3Ht3DyvZ51QQqYzLeLq+D6uA4nmU6XtBfsK0CKINTfF
   jJWGr1jvrcL4gPnqzp0LZZ5HVwhQx+ClAUKYm+zjHnVggrUIu9naGf/Xr
   xDPd6HX+yZaV+Dsus4MB1zmItKGnQKRDekcTs0uB8JNHrLA5TF3mjLoYQ
   AG2Fb+O/do5gSUTLY4+XMv+WdRLgGAmLRuHYqui2Y0/IWgyjUbLIP/Mj+
   7TistK0J7XXpdrjMdD5AdSBylvxmiMV8Jg5jcEsANfVxTqndesf6kJ6Vo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398546138"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="398546138"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="676104833"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="676104833"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2023 23:42:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 23:42:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 23:42:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 23:42:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 23:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/4Az4iTMF4K8CqfVUOxwdVH6J4m5XTv0Rqy0dVh8MIJPlcmJFQPOhwcfB1C6yyV/WGeVA0jKPF+lB+oobx1VnLdIF2DkLXgv3jsg1Go3y9BdPirQhZvZc2eB7Zy/vuohJMWz2ZQTLbmxQmi4MKe4A7br2NiiLG/pWS4XsiMqUlCfzgJ3HUgMz3GUrLfCoQsbArNvs8K3fV4NEnjRbWUAvk+fi4vgSE9Iyvw/u84vofc+Qmv2DPUa7+FGanl0vAlLsbghskutf+S3dEswaSAjv8vx9KzE1sTC+TTEeL08vlguXPLeL9prpx+7NXESfTVGpQftIr2vRKSPu89pYz3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNvhEIHN/QkjCnn6PtDfBdOHgrIHGRoakBL6i4V9yiM=;
 b=gzdxrkHmTMkEM5s/X2e4kn94epct1h4/AkiJm8LStf0No6TdlWwy0Pf6nckghONB0QZg0eQT/sq92+QOy2Pt/Vdmgv85frTwWbrzrllIlr+kzGqwIrAJVnnX3Gp8leb6031bKOFnES69zKWw4syv7sSATbtflL4PXeKPL2oWTwIGXEHe6ysufDIWGWCDSU8I7f8Dt9NPAHb4srj073ReEGH7TvLUVYmqAKjPitezZgqGV1G1+VxHYfvcLjyrTtC5pxtwPZ/6RTlJvC5XDIO+jc0hZryAeHPut59NettY6jqJjPnFa3yyBke9IdfuUvmciw7Y39XixkdY/CTtFFNEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by CO6PR11MB5620.namprd11.prod.outlook.com (2603:10b6:303:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 06:42:54 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 06:42:54 +0000
From:   "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To:     "apopple@nvidia.com" <apopple@nvidia.com>
CC:     "Yedireswarapu, SaiX Nandan" <saix.nandan.yedireswarapu@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Regression in linux-next
Thread-Topic: Regression in linux-next
Thread-Index: AQHZvsM91PW1SDpunUS9z3A/B3yYEQ==
Date:   Tue, 25 Jul 2023 06:42:54 +0000
Message-ID: <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129592BDF5D06949F99816CB95B9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129A7F5C08E2C47748F2BA5B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|CO6PR11MB5620:EE_
x-ms-office365-filtering-correlation-id: d4b6d51c-ff1a-4861-66b7-08db8cda601e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uywpJ5/eRTehGXZB4uIBhZt4vF32kXLL+CKzMDlr8gUN/zjmbqo4bslpXZw8pziYSLH7gmy9VY4hOIoslKiTjYLLqbLHI5BEd96Z3knthnNpLL8XxrOfOzM+SBWKvnT3xmy2/xoDL9d04SObivk1Vl5lAwc9tSzdb8rNx3SVa6HCFn4jmfXbDhPXI/funA7HjK25oW20wOHLFOJHm5Hb6bPFcSaBYFrJDTm8OlUHdcFJZJV99Xn6/gHZ5pZVYLXPfYN8MtWqSPWR3jZou+Tzeui/eKEdo6lpBFAw2rha8WiY6WB/OtD3Mfv7HIaIOWu6RnIMBbqbMrtuPHSuxrIpHRnLndUWJL4Ji3rPf42Et+TNkFcoGx6BpgXyJhd+ihHhzi0/QQy1vds3/zfwd+NDyxrohMaVLC8M62fJ8tQH9cwk1PssgNQfUlEczifVSe+im2ccMlnxhw8a2J9Xa9T6aRedExI16TiiuaiZpXp+1zMYoKn2jaoc/nouMO1cL3uSLhuAMO3LNKbTtDVzpWanLwGeVRhdPGF0PxhC68e8HHm7zeiHxIj+zU/kC1IyFMejEr2XV9zt5VxPARc6Cb/ydjhCKNuvBAdneJ3NrIJ42nU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(55016003)(26005)(186003)(71200400001)(6506007)(3480700007)(83380400001)(4326008)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(316002)(52536014)(8676002)(41300700001)(7696005)(5660300002)(966005)(9686003)(2906002)(478600001)(54906003)(38100700002)(82960400001)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llmNEzf3RxwS1mIyYh+jkc7NwKfT7c06WTzXojIKrESYeus4rWZVG3xiM5Hf?=
 =?us-ascii?Q?oXvq/OjTE2SBVU/5KDWzIF3aJoVrOSaSHB4gpd4hXndZn5eyBv+pZazmi///?=
 =?us-ascii?Q?R3AZTtYZ7P+p190a2XzzUovD6hAlrhfYySlsF/wWQHiAjcK6RLIz0CpwO5tM?=
 =?us-ascii?Q?b43KD2KIJQ/FczhEhopnms5ENRbtxCmo309eDt/npGRBtZPbwUqQeCxNCrNk?=
 =?us-ascii?Q?nIzsdvSAEIhCcic7/aLFsrHaopDG4FBSgNvXlTbv/tjMM95JuyEv4nv8S41f?=
 =?us-ascii?Q?xfAcfZKucIJcYu21xcx6/biLJZAKVcNrtYtOI3XxEFaR917dRj+ne/7de8oX?=
 =?us-ascii?Q?/3fonvv6RL8uh/5+pubz9slJlF8HtcCtla5/1JuktIdz0D2NY9muUS1zGCj4?=
 =?us-ascii?Q?bYkOv1ZnXMPoyIdMJno9OUnFMTIqTWOsgfINE6+OIaDdor3HzfiDjV82HJgx?=
 =?us-ascii?Q?vqSc7y8pcb+akXQDHrpldz2ISPlH2ZID7+RQcahScncx0USUlOtW1q6Pw/v4?=
 =?us-ascii?Q?VovsTrzykqGlJo8ooTIHCIdEFjt6Al1J7+OHQOcjaCiGQMj3c/a3ZeTsG7t9?=
 =?us-ascii?Q?kW+3CYjVEl1seh2re18t6HPpfjg2Krg19bVqCgmEhP5F8sgw5UGugXJawcIz?=
 =?us-ascii?Q?g9nUl+ZERGTnY++lsIiknC7TMULMZIH8tUlKF+P3Rr/c8CoIj/J8RkMUam34?=
 =?us-ascii?Q?Aa+eYB6xqq+LEDn6aV4o9whyIgEiyXupwKFJhi6AemsuHUeonsXveBcy2eMC?=
 =?us-ascii?Q?ILs4SkwVIWuXOWRC3YWWaw/omvQumZoxHSSpKXUoG2chIqWfZDsBdwUnmO3j?=
 =?us-ascii?Q?wMcNeJl2Dque00f1cTQ0ynCkNGu1qWRGWebp0fhPQbBY9/cUIL8HoqOh2GaO?=
 =?us-ascii?Q?KRRgs+/DjbdxCruIAqz/7mwCwEPQ1ToGMcjRVwDo56zQ73h2HkoR1+6nl/kq?=
 =?us-ascii?Q?i57jMrOv++8G3EaJwFHBzVP62E9DKaArY7zIB3m9nZBcRZBaHsPjZaxE0WwR?=
 =?us-ascii?Q?fM/2hAPhQBJ9VdX4zSH5ZbzsorjHtC1RXVbblpSncbtKMqcNF6eXZw1usEs0?=
 =?us-ascii?Q?cgIj0rFnsBytqQ3UmMJg4ynTezAApIQXn4I3j2aU3/qPjnL1lq1jIISH0xJz?=
 =?us-ascii?Q?7JnyQTX3Kj0o8oFabi1YU7Lfk1kKnVfniw7OXcLnmvwzQ6bWsnRziZjtvkYX?=
 =?us-ascii?Q?G+MPQpGujBSDena7hADAaz3RYCQwrY+NAxtLwBToKsHGvZQ1EExIj2PLnggJ?=
 =?us-ascii?Q?+eB2Oj8YT+c/Csl3JM4C+2Sv+t/1iTljPaY/x2Ti3yH8sSE5vJ+II8jp7qYC?=
 =?us-ascii?Q?pjZ3ZQyiyKZFfqHsiF7WCVVy6iWO5X3K5VhZ6835/FP5M5u/7MHhh4qQRP3H?=
 =?us-ascii?Q?y+A3Ii0A+vEGqVm6HnSxbrqtuhy2G9bUWnu/NbS3a7DQw8e2miZnOxHO4QmZ?=
 =?us-ascii?Q?su6xYTrAqTAdfDOBd+b0Oc/hoRiFTsVcz2CyLL0HBgdsqsdoGd2DzAzY7rBI?=
 =?us-ascii?Q?oICUxUuMzz6PsUbx6rxgZ+kFSZl/Fx8PyjwixZTNYDLRXqqS46BsxnvQkMgS?=
 =?us-ascii?Q?huY2nKJLjnsRV29YPJ9EBh9nyOt4NAaUyzrionIjWq0KZn3R5SuSqSGEh5Xh?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6d51c-ff1a-4861-66b7-08db8cda601e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 06:42:54.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP1iFkwAwe/cZZRI+J4Wvk9kYGsIT/wKWkeYPoxmTadLVdQ/tHts8i9WVhbLLJJRywTEdesL3LO2qY9dv+yQy3tUaLHNiqBrLUDFd/seiwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alistair,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.
=20
This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next
repository.
=20
On next-20230720 [2], we are seeing the following error

<4>[   76.189375] Hardware name: Intel Corporation Meteor Lake Client Platf=
orm/MTL-P DDR5 SODIMM SBS RVP, BIOS MTLPFWI1.R00.3271.D81.2307101805 07/10/=
2023
<4>[   76.202534] RIP: 0010:__mmu_notifier_register+0x40/0x210
<4>[   76.207804] Code: 1a 71 5a 01 85 c0 0f 85 ec 00 00 00 48 8b 85 30 01 =
00 00 48 85 c0 0f 84 04 01 00 00 8b 85 cc 00 00 00 85 c0 0f 8e bb 01 00 00 =
<49> 8b 44 24 10 48 83 78 38 00 74 1a 48 83 78 28 00 74 0c 0f 0b b8
<4>[   76.226368] RSP: 0018:ffffc900019d7ca8 EFLAGS: 00010202
<4>[   76.231549] RAX: 0000000000000001 RBX: 0000000000001000 RCX: 00000000=
00000001
<4>[   76.238613] RDX: 0000000000000000 RSI: ffffffff823ceb7b RDI: ffffffff=
823ee12d
<4>[   76.245680] RBP: ffff888102ec9b40 R08: 00000000ffffffff R09: 00000000=
00000001
<4>[   76.252747] R10: 0000000000000001 R11: ffff8881157cd2c0 R12: 00000000=
00000000
<4>[   76.259811] R13: ffff888102ec9c70 R14: ffffffffa07de500 R15: ffff8881=
02ec9ce0
<4>[   76.266875] FS:  00007fbcabe11c00(0000) GS:ffff88846ec00000(0000) knl=
GS:0000000000000000
<4>[   76.274884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   76.280578] CR2: 0000000000000010 CR3: 000000010d4c2005 CR4: 00000000=
00f70ee0
<4>[   76.287643] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
<4>[   76.294711] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00000000=
00000400
<4>[   76.301775] PKRU: 55555554
<4>[   76.304463] Call Trace:
<4>[   76.306893]  <TASK>
<4>[   76.308983]  ? __die_body+0x1a/0x60
<4>[   76.312444]  ? page_fault_oops+0x156/0x450
<4>[   76.316510]  ? do_user_addr_fault+0x65/0x980
<4>[   76.320747]  ? exc_page_fault+0x68/0x1a0
<4>[   76.324643]  ? asm_exc_page_fault+0x26/0x30
<4>[   76.328796]  ? __mmu_notifier_register+0x40/0x210
<4>[   76.333460]  ? __mmu_notifier_register+0x11c/0x210
<4>[   76.338206]  ? preempt_count_add+0x4c/0xa0
<4>[   76.342273]  mmu_notifier_register+0x30/0xe0
<4>[   76.346509]  mmu_interval_notifier_insert+0x74/0xb0
<4>[   76.351344]  i915_gem_userptr_ioctl+0x21a/0x320 [i915]
<4>[   76.356565]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
<4>[   76.362271]  drm_ioctl_kernel+0xb4/0x150
<4>[   76.366159]  drm_ioctl+0x21d/0x420
<4>[   76.369537]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
<4>[   76.375242]  ? find_held_lock+0x2b/0x80
<4>[   76.379046]  __x64_sys_ioctl+0x79/0xb0
<4>[   76.382766]  do_syscall_64+0x3c/0x90
<4>[   76.386312]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
<4>[   76.391317] RIP: 0033:0x7fbcae63f3ab

Details log can be found in [3].

After bisecting the tree, the following patch seems to be causing the
regression.

commit 828fe4085cae77acb3abf7dd3d25b3ed6c560edf
Author: Alistair Popple apopple@nvidia.com
Date:   Wed Jul 19 22:18:46 2023 +1000

    mmu_notifiers: rename invalidate_range notifier

    There are two main use cases for mmu notifiers.  One is by KVM which us=
es
    mmu_notifier_invalidate_range_start()/end() to manage a software TLB.

    The other is to manage hardware TLBs which need to use the
    invalidate_range() callback because HW can establish new TLB entries at
    any time.  Hence using start/end() can lead to memory corruption as the=
se
    callbacks happen too soon/late during page unmap.

    mmu notifier users should therefore either use the start()/end() callba=
cks
    or the invalidate_range() callbacks.  To make this usage clearer rename
    the invalidate_range() callback to arch_invalidate_secondary_tlbs() and
    update documention.

    Link: https://lkml.kernel.org/r/9a02dde2f8ddaad2db31e54706a80c12d1817aa=
f.1689768831.git-series.apopple@nvidia.com


We also verified by reverting the patch in the tree.

Could you please check why this patch causes the regression and if we can f=
ind
a solution for it soon?

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20230720=20
[3] https://intel-gfx-ci.01.org/tree/linux-next/next-20230720/bat-mtlp-6/dm=
esg0.txt
