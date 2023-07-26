Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C260762985
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGZDyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGZDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:53:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF82697
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690343635; x=1721879635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z1i2C1UNcf+a5nuf5p+kRsrdKw+QOEzegO2Ytmdc0e4=;
  b=dB9vkzhk5dsZxQL9/7RvD/qeXadpHUAbCodO3qjCZVSTYE3RCGdSAWeI
   CXl3dtkaxAu8u32Xjlf8EWFRt/f77aDTQDB/puzXPeW7WBIc486o92VXk
   QlXISF4RORsMSdwXQZt8fcEmRwtL9XoT7RZn1AXrSKxYrLpa7UAGi1xid
   nft/gTModc9jSd1Vn6majWRaCVmdrsSQB1BHnipVvnW3uOpiq3AMpDjD7
   RHzEIUXlFd6id45CXiUoQxVZ071FJBU3ao0YPs0YOltQ1E4XR8lxYZ1kB
   w/kz/EghZV9QJuh8iminj7Rt2IdCVsgVWb3+9+vjzq9AuKL2q9/si2qif
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367930893"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="367930893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676487166"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676487166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 20:53:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 20:53:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 20:53:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 20:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTs9T5dMCKMOdSpt7Wzy5f1V8bPQiGARWX63/axz1pCiT+b3TG6NPsqASHiYlyTJQt8Ar/UexD4P95v93rOuxVQZvBrg9rx1mkEdI80mA/q3KHKgLjmvoV/cUJ0Lc60IM+5mtwOmZHt1YmZxVOONEDMVVgb7vgYNpnLn5BIsAYMl599+Z38eBRb4c4ZFkbTNl2zWjqp4Ow1qCuko5ZsmLC5R5Zsq9okoOSL71ASjzWQ11P7bvVtVo0xGY3vvxhR5KojlJk9sI7RThxKx5v9vCfIlH4j6VvkorgHoUtEHWRiZqh99RFg0C0pTtbIQPbm1tdlrotx+Pdf8jS5j1fYvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIzkCqG1amu3rz6J0Uk2TfR6OuAVBomcLhvQyziqQow=;
 b=S2NeOLuzAwVLkgGiheq05nNVBDCBycC2Mj4KKFTDLt8VHEcRIzXfyzECHQoUw10VdefyUPwjxKjJK7su6ENFBxd/9qpPPLwgV9ohNbV2R5KWtA8pdpvXbzORMh7n/mHFiaePHAdCU2w6yGtE8yOhY4Atv7zr2YVXoNHeEUniYtzPRGNN6WnctKy6+lV0MR2LQPtIaV5RZaLVxYLJSzGiHL4jiiyZMAK+ktnSddpD6y5fKV6PAyCDqMFfNKr0xM7RexnmxvsVkl72JBNxutezV60QAb1NONMWmu9Sz7W375D7uMPU1E21jGVdAL51NFU33bvmJSvrScHgydqVjchDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 03:53:51 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:53:51 +0000
From:   "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "Yedireswarapu, SaiX Nandan" <saix.nandan.yedireswarapu@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: RE: Regression in linux-next
Thread-Topic: Regression in linux-next
Thread-Index: AQHZvsM91PW1SDpunUS9z3A/B3yYEa/Kdp+AgAD1KLA=
Date:   Wed, 26 Jul 2023 03:53:50 +0000
Message-ID: <SJ1PR11MB6129F7EBFA84D6CBB6D78E8DB900A@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129592BDF5D06949F99816CB95B9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129A7F5C08E2C47748F2BA5B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <87o7k0xh9u.fsf@nvdebian.thelocal>
In-Reply-To: <87o7k0xh9u.fsf@nvdebian.thelocal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH8PR11MB6949:EE_
x-ms-office365-filtering-correlation-id: 36d51dc5-e0c3-4954-9b36-08db8d8bec76
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQMUMp28IMWwSkdDknZrNVnEaxo3ecHLEM/ZoD2nmGG/bQacfdsEOwF5r4m4BVkPqZAgmiH0NORFT8LuF8ki9dbfMKXW549+IVNDLMmQ8g9r3TXic05CLQ/0HVvqtrQQBIEu0/vMYNLz/Q1DjU4QSl/+FIk6inTASik6u5rjxVaSfFt5/osvTW15sajRb5gidHODtX8aF2k6a5JpoRC5wpJiQzEZOiTuff+VoMtdREZF+valytBjOd8jayKqJDWxh0qLwFAoRkAeBTkGxvXDc5Udl/HFQ0SGB4PJaIxxBtcbg0f0sB7hKLhTXg4ZUEQNXpasSr3dpbi1EUuaDxrDwcamG7MiAvJpt6Kwiy2sJni+ctXHEWlsZCwTIV4jcVud1ZcToWHLrqUarIRUShzSQtc7P8//mcfrD1sslFThSUBlGlhBLTrW44dpwNU7QPORbM3Z5rs1QKWSXdU8bPwZlgIsYHBoi0eMtBGsZ6kGEEtuU5cpNX1DZY6sEPsaIRr8by7FnJeKnBJwmLs0a8dwX/nKWx5b9mgr2wTJXH6ruzdGC3/R3eQd9YDUKidyhhtRum5XfNJOue2BxNZSxDyPILnKWZLGIKQRf2dWrbfNbbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(55016003)(6506007)(186003)(26005)(71200400001)(53546011)(3480700007)(66556008)(6916009)(83380400001)(76116006)(66946007)(4326008)(64756008)(66476007)(316002)(66446008)(52536014)(41300700001)(8676002)(9686003)(966005)(8936002)(5660300002)(7696005)(2906002)(478600001)(54906003)(38100700002)(122000001)(38070700005)(33656002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LaZLINpF817OVqf+h7h8p5YFJH7vzXxPviaCbCq6q4PZLrVvTZ8AVqYAA4/6?=
 =?us-ascii?Q?fUjdJovYRwR4w149eFVBydpuCJ0kiKGkGbiFs1Z4iQltSaeJVTJh5MeIz4wk?=
 =?us-ascii?Q?Ertj9i5Fa1PBiuWhfn8Ybv6UkWYLmgSFwoxN7vm1G32pyYMPnTVBzFMCtn9T?=
 =?us-ascii?Q?6l6KwlxJgYwxxayD+di2V9PcLJqgxZzDYKbEqzLyVILs8Q812IfxpYWQIRqf?=
 =?us-ascii?Q?1hvlkllQalIlIabuCNJZoHQ4I6M0cQxBZLefPyLIWF5rw5R+CZY2RFd2Zlzu?=
 =?us-ascii?Q?uNOahQWoG6jB7BLlr1N5NXlGpVeRlC8BzeQaIF6CWTpNxs0cgdJ/QnGM4Wcu?=
 =?us-ascii?Q?VMWYPxSpYJzgVwV7yDxIGnIqAJtm/vKr0ZjdLiaH5OQSlPqbHxLbgdQA4jvV?=
 =?us-ascii?Q?YBd+VNuLV4eBcogE00qA/Fm+WdWf+PHcDrHWwTpQ+kIj0yfTxpUTQuZTWQC2?=
 =?us-ascii?Q?JqfeMEHzpMK4DY9RCgsIwRIqk9+ImgdFthOqrXBr69PlKEHBUuCo2b8TYbIJ?=
 =?us-ascii?Q?8MSleU0tV2dj/gObBABh4prvdkbuts2f2G7XN09ido6jpvsVEKXSWFMjcY3M?=
 =?us-ascii?Q?c6RR8Zf6mHugOPvxHsrJUrEd/7P4Dn8803RoHnAj/YDLkp/Jmw7/xfrJMixr?=
 =?us-ascii?Q?es1qJrzOv8eUa71hZll1TLdzDOzgl8rei7D9Xxb5gcKKycQo7WlGG12TalUq?=
 =?us-ascii?Q?XoM3HANmx1D5vGhk5wvgjYAfQcqbr/beK28DSPT9/cqDeUZsovVlnTdXFbz0?=
 =?us-ascii?Q?VXIdMy1Trt2js0jOuERnT+BA265XVq/ZLlP5qDirZq9O4FSvdfM1YELB49ye?=
 =?us-ascii?Q?rvYBsqZYBW0vI8Li2ouSVv9mNkjk5KDqSxaHJf710TazVv5ny9+8uI0luFbE?=
 =?us-ascii?Q?Z1t0AXJJI+rbmdc1/WkiVZPli5OBmgTPhR+Ln3/fog0C3wVswtWZ4RP0agS2?=
 =?us-ascii?Q?onVZ4sOjhjMLI6mVq9/Soc0R/FcdyHs+TlPV36SgCX0rzSia7YVAs8WQqnrp?=
 =?us-ascii?Q?+JLRuCz5+RjH4tO+AdGQAI37YZEV7WkYEBojTwMe4JAo0UbCOPIubPG1TGu5?=
 =?us-ascii?Q?zymaekd5h8X1KogdDnBFpwNblXgHkbkgazTmu7fuGbkjLDckya2GKUmojxlu?=
 =?us-ascii?Q?XueuiPT/qcHqqd9wCItuz3uBflvRVNYWqmgfqpfvswgR7KnsfgeqMe5K9xVZ?=
 =?us-ascii?Q?47YQCieVmYRD2cAJaSk1qps45OnQckjdpe0JYH0RCRw+iHn2B99reT+X11TZ?=
 =?us-ascii?Q?lG3vHNm/covt2Pd44dKpEYbNzyHs5OH7snuyWmyZy+rwtC3MP/cTAt58zFo0?=
 =?us-ascii?Q?WZe3HLoOf8Y7c7stJlR0L38g8zSWjofgWJHGc1LHsV3x9qCMIIIXrpJHhdWW?=
 =?us-ascii?Q?0lAO8guLndKGb9cabTlvUzSRpn9xvoHGn5THK0CDlu6jl9sSZqlpY14bmwH+?=
 =?us-ascii?Q?uvJ/OiLQivdNLK8mhyZEDlukX0Zz05gNKaP0IxZbuvwj23B7r88zv9Ij2fK8?=
 =?us-ascii?Q?SyQ2l0gTY7UPqksAQ/GRu76o2sHsSyRgvGsldw37DpD0/+0knehYtET1I0PG?=
 =?us-ascii?Q?iVIlg5dOSEd1cmzctaGM6M1GL7BdiixtRt6tKP2DPyINeRT1jvvrxugp2V+u?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d51dc5-e0c3-4954-9b36-08db8d8bec76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:53:50.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FS+shvxWbiqYvww9ZiZRyQt+FpSCgGogW2SWZWtozJ3lzTB6jkgIkk0XNDJxqPg2sjKxatol3p5iSFSNK1Oom4zyVWEPKMk+pk2wahnCBFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alistair,

Thank you for the quick fix.

Regards

Chaitanya

> -----Original Message-----
> From: Alistair Popple <apopple@nvidia.com>
> Sent: Tuesday, July 25, 2023 6:45 PM
> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Cc: Yedireswarapu, SaiX Nandan <saix.nandan.yedireswarapu@intel.com>;
> Saarinen, Jani <jani.saarinen@intel.com>; Kurmi, Suresh Kumar
> <suresh.kumar.kurmi@intel.com>; Nikula, Jani <jani.nikula@intel.com>; int=
el-
> gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; dan.carpenter@linaro.org
> Subject: Re: Regression in linux-next
>=20
>=20
> Thanks Chaitanya for the detailed report. Dan Carpenter also reported a
> Smatch warning for this:
>=20
> https://lore.kernel.org/linux-mm/38ed0627-1283-4da2-827a-
> e90484d7bd7d@moroto.mountain/
>=20
> The below should fix the problem, will respin the series to include the f=
ix.
>=20
> ---
>=20
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c index
> 63c8eb740af7..ec3b068cbbe6 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -621,9 +621,10 @@ int __mmu_notifier_register(struct mmu_notifier
> *subscription,
>  	 * Subsystems should only register for invalidate_secondary_tlbs() or
>  	 * invalidate_range_start()/end() callbacks, not both.
>  	 */
> -	if (WARN_ON_ONCE(subscription->ops-
> >arch_invalidate_secondary_tlbs &&
> -				(subscription->ops->invalidate_range_start ||
> -				subscription->ops->invalidate_range_end)))
> +	if (WARN_ON_ONCE(subscription &&
> +			 (subscription->ops->arch_invalidate_secondary_tlbs
> &&
> +			 (subscription->ops->invalidate_range_start ||
> +			  subscription->ops->invalidate_range_end))))
>  		return -EINVAL;
>=20
>  	if (!mm->notifier_subscriptions) {
>=20
>=20
> "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> writes:
>=20
> > Hello Alistair,
> >
> > Hope you are doing well. I am Chaitanya from the linux graphics team in
> Intel.
> >
> > This mail is regarding a regression we are seeing in our CI runs[1] on
> > linux-next repository.
> >
> > On next-20230720 [2], we are seeing the following error
> >
> > <4>[   76.189375] Hardware name: Intel Corporation Meteor Lake Client
> Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS
> MTLPFWI1.R00.3271.D81.2307101805 07/10/2023
> > <4>[   76.202534] RIP: 0010:__mmu_notifier_register+0x40/0x210
> > <4>[ 76.207804] Code: 1a 71 5a 01 85 c0 0f 85 ec 00 00 00 48 8b 85 30
> > 01 00 00 48 85 c0 0f 84 04 01 00 00 8b 85 cc 00 00 00 85 c0 0f 8e bb
> > 01 00 00 <49> 8b 44 24 10 48 83 78 38 00 74 1a 48 83 78 28 00 74 0c 0f
> > 0b b8
> > <4>[   76.226368] RSP: 0018:ffffc900019d7ca8 EFLAGS: 00010202
> > <4>[   76.231549] RAX: 0000000000000001 RBX: 0000000000001000 RCX:
> 0000000000000001
> > <4>[   76.238613] RDX: 0000000000000000 RSI: ffffffff823ceb7b RDI:
> ffffffff823ee12d
> > <4>[   76.245680] RBP: ffff888102ec9b40 R08: 00000000ffffffff R09:
> 0000000000000001
> > <4>[   76.252747] R10: 0000000000000001 R11: ffff8881157cd2c0 R12:
> 0000000000000000
> > <4>[   76.259811] R13: ffff888102ec9c70 R14: ffffffffa07de500 R15:
> ffff888102ec9ce0
> > <4>[   76.266875] FS:  00007fbcabe11c00(0000) GS:ffff88846ec00000(0000)
> knlGS:0000000000000000
> > <4>[   76.274884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[   76.280578] CR2: 0000000000000010 CR3: 000000010d4c2005 CR4:
> 0000000000f70ee0
> > <4>[   76.287643] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > <4>[   76.294711] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> > <4>[   76.301775] PKRU: 55555554
> > <4>[   76.304463] Call Trace:
> > <4>[   76.306893]  <TASK>
> > <4>[   76.308983]  ? __die_body+0x1a/0x60
> > <4>[   76.312444]  ? page_fault_oops+0x156/0x450
> > <4>[   76.316510]  ? do_user_addr_fault+0x65/0x980
> > <4>[   76.320747]  ? exc_page_fault+0x68/0x1a0
> > <4>[   76.324643]  ? asm_exc_page_fault+0x26/0x30
> > <4>[   76.328796]  ? __mmu_notifier_register+0x40/0x210
> > <4>[   76.333460]  ? __mmu_notifier_register+0x11c/0x210
> > <4>[   76.338206]  ? preempt_count_add+0x4c/0xa0
> > <4>[   76.342273]  mmu_notifier_register+0x30/0xe0
> > <4>[   76.346509]  mmu_interval_notifier_insert+0x74/0xb0
> > <4>[   76.351344]  i915_gem_userptr_ioctl+0x21a/0x320 [i915]
> > <4>[   76.356565]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> > <4>[   76.362271]  drm_ioctl_kernel+0xb4/0x150
> > <4>[   76.366159]  drm_ioctl+0x21d/0x420
> > <4>[   76.369537]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> > <4>[   76.375242]  ? find_held_lock+0x2b/0x80
> > <4>[   76.379046]  __x64_sys_ioctl+0x79/0xb0
> > <4>[   76.382766]  do_syscall_64+0x3c/0x90
> > <4>[   76.386312]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > <4>[   76.391317] RIP: 0033:0x7fbcae63f3ab
> >
> > Details log can be found in [3].
> >
> > After bisecting the tree, the following patch seems to be causing the
> > regression.
> >
> > commit 828fe4085cae77acb3abf7dd3d25b3ed6c560edf
> > Author: Alistair Popple apopple@nvidia.com
> > Date:   Wed Jul 19 22:18:46 2023 +1000
> >
> >     mmu_notifiers: rename invalidate_range notifier
> >
> >     There are two main use cases for mmu notifiers.  One is by KVM whic=
h
> uses
> >     mmu_notifier_invalidate_range_start()/end() to manage a software TL=
B.
> >
> >     The other is to manage hardware TLBs which need to use the
> >     invalidate_range() callback because HW can establish new TLB entrie=
s at
> >     any time.  Hence using start/end() can lead to memory corruption as=
 these
> >     callbacks happen too soon/late during page unmap.
> >
> >     mmu notifier users should therefore either use the start()/end() ca=
llbacks
> >     or the invalidate_range() callbacks.  To make this usage clearer re=
name
> >     the invalidate_range() callback to arch_invalidate_secondary_tlbs()=
 and
> >     update documention.
> >
> >     Link:
> >
> https://lkml.kernel.org/r/9a02dde2f8ddaad2db31e54706a80c12d1817aaf.16
> 8
> > 9768831.git-series.apopple@nvidia.com
> >
> >
> > We also verified by reverting the patch in the tree.
> >
> > Could you please check why this patch causes the regression and if we
> > can find a solution for it soon?
> >
> > [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co
> > mmit/?h=3Dnext-20230720 [3]
> > https://intel-gfx-ci.01.org/tree/linux-next/next-20230720/bat-mtlp-6/d
> > mesg0.txt

