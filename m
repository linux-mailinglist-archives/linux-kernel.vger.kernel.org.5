Return-Path: <linux-kernel+bounces-16461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA8823EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64037286634
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F066208D7;
	Thu,  4 Jan 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vhqtvol8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB881208C5;
	Thu,  4 Jan 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704361556; x=1735897556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BfXHnaMwOUYrqJzfjNxlEr3HU3n8ySQVOnGcyQjUSnA=;
  b=Vhqtvol8v5wW3nIMqQUk/IKPrawkORm2G1DKvFUTmhpy7OoPAiOTKFyh
   TulyFPoNPWQOGYdLaROiZGc31IfFYYepZAOC65Z5dmeLEo1cBYYE58Ib9
   NXh2hI14ekn9b71PY5snoSKt1gkK6Of/AjuNIVGNRDd8P9TYC01Mu3Jp9
   i+ocKLUip9saFxMX+cG4KdwiZvvEZRGhIiKVhsbzHJKHBmw7iSlvo+0qv
   3xnhw8FNpb73XSbLr4mvQAzS3T78wdaMi0lJnRS0MFy/aUaOaodePQK+x
   QmJLCH79KKDl4nhqOQXIYBBaYB5YktY+hqg35ruyb4W1UZL1FbK+Qpm6Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="428346520"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="428346520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 01:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="756542587"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="756542587"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 01:45:55 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 01:45:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 01:45:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 01:45:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyRPY4CTO6I+/ob3bBdVPsF7YusNmCWAQ6LyFXcDm5HMZSGiTSFhBQ6A4Ll8GFBT1tZ7hdMX9oSHlNkRHw8BUvtmCxXOBfGqMrgKNeIRKJ3c7WUvknfl7TVFHNPJ6BogjJRThx9Bq+3QmLQ4C5r3gRksbvEP1v9quoQSgWbgc4e9rMPghTwQue0CAijczM8eTyZ5bAQ+rMMoohoy2+ZWZQNm+UEYQnrau6FqgSFMQg/BlYrpyiBcWscPdmKKtpW6wXgskX39UeckXT3f0h5P8WCEqDivGrGX3DkYVc4YXHRSpAHSmULUm1LEB87PcppYJsA6APFWKECLTGvdmQBgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOccuFaXChl58YFxR3HAx1cCZrAERPxk5NIjdJ5G0jY=;
 b=hkGueI3ObbdOcFHelKIWNZiToiLz0qzwre3YtXfVBMjT043csJMeoi3aT+HG2UqcmCRu4nwhMoAL06MkUjBVl3wEzjc2p+KwnxoUpGqHMjFbicpBeCSQv5FFVAWz6WAVLlReYzDNtrejlZbX6mZQNuWA1M7aCxbX1xAujMIl5vTBrk8BFEQu0uj7OA9ex6CO+LZVkaLKT73qpU/7bGsL3RgjwNQ/gjBuQKZHN4gI/Zj2ni2JYl8KuG3u5NSHorkUJV4/vmUM5nzkM8ru+T9oGovKcwliidWM6XvnAKa6v0ScXaW9ktuczRVGvqUvpKSc+5mbQogp9BoByz9V58siSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16)
 by PH8PR11MB7046.namprd11.prod.outlook.com (2603:10b6:510:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 09:45:47 +0000
Received: from MW6PR11MB8310.namprd11.prod.outlook.com
 ([fe80::a40d:5f37:ee14:6e21]) by MW6PR11MB8310.namprd11.prod.outlook.com
 ([fe80::a40d:5f37:ee14:6e21%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 09:45:47 +0000
From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Halaney
	<ahalaney@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, "John
 Stultz" <jstultz@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, Russell King <linux@armlinux.org.uk>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, =?iso-8859-1?Q?Marek_Beh=FAn?=
	<kabel@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Voon, Weifeng" <weifeng.voon@intel.com>, "Song, Yoong Siang"
	<yoong.siang.song@intel.com>, "Lai, Peter Jun Ann"
	<peter.jun.ann.lai@intel.com>, "Choong, Yong Liang"
	<yong.liang.choong@intel.com>
Subject: RE: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
Thread-Topic: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
Thread-Index: AQHaM+tcmnrQCuQ6Q0WT+EJT7YP9o7CzdqWAgBYFSWA=
Date: Thu, 4 Jan 2024 09:45:47 +0000
Message-ID: <MW6PR11MB8310E51E5EEDA8EE98BC37D4B967A@MW6PR11MB8310.namprd11.prod.outlook.com>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
 <20231221085109.2830794-3-yi.fang.gan@intel.com>
 <0f85171e-cb9c-47dd-bb7d-f58537e24a54@lunn.ch>
In-Reply-To: <0f85171e-cb9c-47dd-bb7d-f58537e24a54@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8310:EE_|PH8PR11MB7046:EE_
x-ms-office365-filtering-correlation-id: 4dc470d5-b3cb-4e35-e715-08dc0d09edfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmZCYw5nokmRvoyY6DGGJ/SPrWf4HsbGMbz/FK8Gn4aJQIVZZbGq0bOg03/nPaJ7mxFLv7QFWY09EaBIKs0C+tAOAjT7fTNMfDSL+Tgk07nhFCjAJZyCTVg+k05COXrgF1/NP5djOKBGAMAhn0uDHcfgSCpkBkxQqRPtYVRRXewylLv7QT44L6wIrRxdxOEV3hk50xwon6bDoBdXJp3s6KrvdP+6tNGVlvDCq6qjY7/LkrpzLHxW4l26yb7K+JUvxVxwcPulMbgQXv80wmU65LNppKaQ2L2hgwHbFRqhYM2cC1WnR4jF90pI2Fi5renwHv6gSPbyx4ZJRADcokGc4yuLn0ZgexPRncycl4d0gbg4oUfdc5LIy3R7+BI1K7N2Cims9lbZ/14gsr6ZqPxr4jfNSdaKzCibDaHR/t8sEiq5hV0IUrtRreICQ6ofG1CFaBaJsYnEomdJCYAuYYeCOrwK9frYxq2N4GBniNUAlg6EhqflEOJCW3qOxvjftZrFqixjm7XwqhgIElbaA2AFlsVmdfPXJbF6J7wZr6sRzpmbC2VCAS+6e7G8y3orbjQwXYd62iNgNh54mP3+cJ8frJCvIBhsdG5XY5z64V9LwBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR11MB8310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(71200400001)(53546011)(26005)(7696005)(6506007)(478600001)(966005)(9686003)(38100700002)(122000001)(86362001)(33656002)(82960400001)(2906002)(5660300002)(41300700001)(7416002)(83380400001)(66574015)(107886003)(38070700009)(6916009)(66476007)(66446008)(64756008)(54906003)(316002)(66946007)(66556008)(76116006)(4326008)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BsohoVKKaiw/cQ/JLqtyM0Z/Ld+iN/LrFPrJm45iuLSz3oZvuHPRznUOaE?=
 =?iso-8859-1?Q?cUwca20gWJKjajPDpo2Ph6lGrlOgG1ENy1KPBuSL3gZwuyDqe69xExU10L?=
 =?iso-8859-1?Q?jki8ikN3293psSJcIw7ZGtAklXUv9rxfptPBzRr8cAclvdi2PHmzK4YB/k?=
 =?iso-8859-1?Q?ciaDe7s/1nt/IYGo7RtIWfYMMuWrIWq5J9EeciMHyZHZoVt7ifjvBLiMRU?=
 =?iso-8859-1?Q?o1eMCXSPhIw5+ufIdvoU+OpE9fVyb6v64H+rUj9WL6LVP07Ol6wpAHjqE5?=
 =?iso-8859-1?Q?O6qQnHyau4xSNG7dOKiOO2SNOwi81WNyNZ/CBT7/Y3zWepjz9aVkI05idr?=
 =?iso-8859-1?Q?EKWUyhkVbWjTDFgoB+1qXwFSyKcxDstvqJxB984g4Dk0/9n3Kohl6ppltA?=
 =?iso-8859-1?Q?qSFPdq+Bb74xre4xLDOFxae7H1aAKcUdNxBgH6HF7kciWOZITjZy/mduEe?=
 =?iso-8859-1?Q?Soq6s2vH2WNDdfX38lPhaNVhAf0jo2SYaOOtgTL794bfO5Y3tLQi63rE69?=
 =?iso-8859-1?Q?MU1OUfrawh6Oy3GVU31m2zOlK1bxjIybKytrQwWjvNcScAaTHxu9PbV5eI?=
 =?iso-8859-1?Q?reCDzg+551dEw0PLS53yS2KNuuvFcvExkj435PNonTm4ERKevnYTn/LFbG?=
 =?iso-8859-1?Q?iBmwUjjkjwqxEbhKnJn9YHOoAdbaxoP9HQM1JYEKcaGlmg1nGHUywhlycC?=
 =?iso-8859-1?Q?smHdUNlJ6YTDp2SAH6vsf+EWOSurocggxBr+Jt5IUZw7n2yyyTut7bsGor?=
 =?iso-8859-1?Q?ZpzbHOtgx9eJp7txkpLMT6dHRtOZb9oORYPdR0Bgb4DbuOD5wfDb2KAc/Y?=
 =?iso-8859-1?Q?jZLqv+5z+wGjw6O7y04jdFplHG+nsu5Ob/W3KnHmc4Cb6GteFyQe4nmFcT?=
 =?iso-8859-1?Q?+Dx/H0Z6LXqZ9eUlQ4K1OBaICNQa1J4c8Q76W02BSn0hgCJZnRPfMjPjWo?=
 =?iso-8859-1?Q?V9qMamk3JlE3XCqV9KhrtIaulAsZi2xdLRpCdbiTg1bcQPCfUWvSo5YWPI?=
 =?iso-8859-1?Q?pKSz8OxDDSq/sXo8tVTPBaTyBVnKeRQUvilKd93W1DYg/aBjUcgokRyE26?=
 =?iso-8859-1?Q?wiBvScBWgqFKIjC2Xkr8yZMptvgCaCv8d1HABJshTB9BnQZEEXXRUtxSQY?=
 =?iso-8859-1?Q?RkbdLiP7Iaw5YhXqnAtABfCtWGzReO/z9lB2HYuHV8kiedYKbKUrCfH/L5?=
 =?iso-8859-1?Q?sZQrIcjyT5MI/dVXMK9/1UHfcDucRzpU42QWb3S8dkfinGPF2ee5Lw4wHT?=
 =?iso-8859-1?Q?9To0+e9/IcoG5izulVVi7tNLfwRnDmU18xTiWa+NvYpWTHUEcy4d5jICW6?=
 =?iso-8859-1?Q?0+2p6Y3MzoO/i58zaGdngnZV8hJAihUWHZUnlpbevxtcQMfmnk15KBrI/C?=
 =?iso-8859-1?Q?h1cxiF1ZNOcj3s2od/+rJ8nGIcLoqd9FDG26h1FdZQVDkQV/K92ezsL77Z?=
 =?iso-8859-1?Q?CsY5KvwnmrchxR8HJ8quBEt1Cp40OGu666xry7F9ervzr6icbBAVCx+BNA?=
 =?iso-8859-1?Q?wpQNTpw55mWGNyZX6EYjs5rGHjcoCXEMLsl/KiJZG/e8lt9NgsoFCZw2XR?=
 =?iso-8859-1?Q?b6jJp55+vrrJBkBhTkhGI/ocRP7zJKSG0JrcQWhYzC5iZz+H0ajgLxzQqX?=
 =?iso-8859-1?Q?tdYDqnVemmmMLYe51jpp4tWLtYFbjPU61D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8310.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc470d5-b3cb-4e35-e715-08dc0d09edfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 09:45:47.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPKRna2Rvah6Ym2yPUa48WcdA9vxBG0OzUnneBnhfLJvRXOPXB0SY8MElaw4eWeFjPqXE6ZmOQ6vjWShFA/qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7046
X-OriginatorOrg: intel.com

Hi Andrew,

The function phylink_init() is introduced by others.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-6.6.y&id=3Deca68a3c7d05b38b4e728cead0c49718f2bc1d5a=20
The module_exit() is added by referring to
https://elixir.bootlin.com/linux/latest/source/kernel/module/main.c#L738.
Since the macro function is rejected, I will send a V3.
Let's see if Rusell King has any comment. Thanks.


Best Regards,
Gan Yi Fang

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, December 21, 2023 5:23 PM
> To: Gan, Yi Fang <yi.fang.gan@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Andrew Halaney
> <ahalaney@redhat.com>; Javier Martinez Canillas <javierm@redhat.com>; Joh=
n
> Stultz <jstultz@google.com>; Rafael J . Wysocki <rafael@kernel.org>; Jens=
 Axboe
> <axboe@kernel.dk>; Russell King <linux@armlinux.org.uk>; Heiner Kallweit
> <hkallweit1@gmail.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Marek Beh=FAn <kabel@kernel.org>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Looi, Hong =
Aun
> <hong.aun.looi@intel.com>; Voon, Weifeng <weifeng.voon@intel.com>; Song,
> Yoong Siang <yoong.siang.song@intel.com>; Lai, Peter Jun Ann
> <peter.jun.ann.lai@intel.com>; Choong, Yong Liang
> <yong.liang.choong@intel.com>
> Subject: Re: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
>=20
> On Thu, Dec 21, 2023 at 04:51:09PM +0800, Gan, Yi Fang wrote:
> > In delete_module(), if mod->init callback is defined but mod->exit
> > callback is not defined, it will assume the module cannot be removed
> > and return EBUSY. The module_exit() is missing from current phylink
> > module drive causing failure while unloading it.
>=20
> You are missing justification it is actually safe to remove phylink. Mayb=
e Russell
> King deliberately did not implement
> module_exit() because it can explode in interesting ways if it was?
>=20
> 	Andrew

