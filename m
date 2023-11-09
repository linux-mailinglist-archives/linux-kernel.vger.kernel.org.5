Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8C7E630A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjKIFIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKIFIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:08:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116E2683;
        Wed,  8 Nov 2023 21:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699506512; x=1731042512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYziC9OV0CoYzTtQYnYOxWglKYNSGFP0iZsUI6hjSeg=;
  b=oD9EIG24hnryjy300HGQZE2DicP+oJM5ixlkMoG5Pb9w+xCl7NeR/9YF
   uY/f0uUY9KGengKgKSdSyhqSHSfqO1H1VUkC6Iy8xJpI32Ta0F6UJNqpO
   7zDWGR8i/qGW8zsEBxkETxg8O3Gz/5vHyPucuYJMin/XaPDYbx5d9RE1J
   fQ01sYjknFWhkfg0etoBZheJ65v8Wf4A9zDSwrW87UuR7tRYZ7ucqVYKM
   m9R2OFGIxIWcRUEMGGKWWF7x62S9tJW1yRZzdS/2LWhh+6DsCEhVdFe4W
   EEyyhs5NeVh0yyZpX6CYxPUjPYYBbJ1CWkPkPx6gg+/+GCeqtnsnGX5Ay
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="374957405"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="374957405"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739738491"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="739738491"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 21:08:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 21:08:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 21:08:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 21:08:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efS0fH/zCFnBotTZvMDnv00bClfc4JjBOPCvaCx1uJGvD8kWoHHtMTIdS4DrbpKT7feM8wDUz318IwHFzRymznMyTmxxO1AG56hgi2oyRt2U4xlkeHQc7BLJCuk1XBQsX8gxjzAy9C5e7K8VIQTI22pb+hTrA0hKMa4BBhy9FF7c3FbWuKW9LyC69QW5lfqxeHJsO6bpRAIlJBvI4vTyGmxU9F0ieNDqOI4sqfPmp5YWQup6gTfC/Ovzw79oXTI9bbUEhEhIIBtRArxvXn86LqE2wRqhdRrUKQpXBeqOOGkQ62/aGI/6VtbQl79VuUxv9mYaWmsHQSKoBinozniyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKB9TTTM5RT8VNQcKXIFvyXIvPLIdp4cISJU6qZBlTo=;
 b=JI6pOUsm9D29J8sdOHxyDF6T2TokWNcWGaDpftx2oJCxS0IaFBrTd3qMQDqDHScymUrVMR4aEMRWYUzrfP3Bbftqb93St8dqp2SZwAl/i2f+ESyihrusOYyloZve//mkOXyaN7iti/A5jMtq902+aYIQ30tdGIrc/Jiv2e88PT16F5S3KBdcQLOoBx1p5FHTYJ2x2JoEGbzgoBsYzLj0/NdP5yaPctrSUmKj9H1uMINx7hM7qcoRl1r1OHpZgbVXwmXHZftJlFFm9OFge814noXUJFWi3Z3pYqyL0m4PU47s3YblGROOvSH6D9kq0XGSaCkKMMRxpdJIUwZG60jy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 SA1PR11MB8522.namprd11.prod.outlook.com (2603:10b6:806:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 05:08:30 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::4245:c7d1:e22a:d879]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::4245:c7d1:e22a:d879%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 05:08:29 +0000
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Looi, Hong Aun" <hong.aun.looi@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
Subject: RE: [PATCH net-next v2 1/1] net: stmmac: check CBS input values
 before configuration
Thread-Topic: [PATCH net-next v2 1/1] net: stmmac: check CBS input values
 before configuration
Thread-Index: AQHaDIvZ4rD8CSZwXkif+5bCBd+iWbBlZtuAgAwU6fA=
Date:   Thu, 9 Nov 2023 05:08:29 +0000
Message-ID: <DM6PR11MB3306336C961366FF79799959B9AFA@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <20231101061920.401582-1-yi.fang.gan@intel.com>
 <58132260-81d0-4f0c-90b6-0c97c7a6a2f5@lunn.ch>
In-Reply-To: <58132260-81d0-4f0c-90b6-0c97c7a6a2f5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3306:EE_|SA1PR11MB8522:EE_
x-ms-office365-filtering-correlation-id: c77eb180-78f3-4ec6-86f9-08dbe0e1e9d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trFqQbsATDe0bmvLvp3qQATW03UxDNwq0R42YASAn2DoKI54YyCVgEeosjbxAVK5tOVPo8wZd7N8MMF+LuvaH4Y6NBJ/dGj515cbc2rGgA+K+LYT3ek5wsu4VLCEh9IarqsNt55qFTJf9VQ/2QiPQ0m5HJvu+PuCyG9QA0l/H1mRsUKxWhstZr6YI2ZTLPOj98845QLM0YN29iP6hUAF09bFKq6pwCHZKKg8I+AXZqoNzOkLWIGrXCkwfL5W8j+pefMw7pXhVZeiBifJhzooFE9FKjarf+EWT7YJPg6SUhfVjOe+Mji9oY6mjLmo+oaFQ+qMotuwzLjz+TNpURoqCIEmDsKso/3idKmC6uqJ6jAcSZDOWoueHYsU5gC/TJbWQsdir+iGI6YwN+Pk5q82M4npcI0H4/j3qH9ZTbfROzoEAxhMmtvMMl54Xne4n9zd3ut+QVi2gbJ79W/88Xg9/kTvz8w7d3oQopVWP+lTgvatqSrDMAZajmQFQl2t9aR8gY4XVR0Xh87Kkunz/RIcIW9JUPzpjWj90naFmF9137ckVE19Hgdlnz/LS2+ur3uBH2RmfRCSd+JDH2B/1a7DT/j9UpawlHLzH51RH7LEZDYJv4ltqU9aWJw23GS4MdxW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(478600001)(6506007)(7696005)(9686003)(71200400001)(53546011)(83380400001)(26005)(107886003)(2906002)(41300700001)(7416002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(54906003)(52536014)(6916009)(8936002)(4326008)(38070700009)(8676002)(316002)(33656002)(38100700002)(122000001)(82960400001)(86362001)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r9JC16dVneUCKkZq0zdgFUt5d36a3vdl0Jp9DnCRksjbBvVcOq2GE+IYYnbm?=
 =?us-ascii?Q?pr5pdOTT+lb9dpcswRGEXTZyNDQC+pN0J8gNz2xoGUQAUZEPn7ZyA5KOOkLI?=
 =?us-ascii?Q?n+rfX9G11iCVu9RB85+vmsayXPQuw8uGwzh8aKCOOYoPCN4SSdXF67hKZT0k?=
 =?us-ascii?Q?aGm8qWfkEItsRVWyUz2njX30bPcJl5jfVmeizNm8pAadyISwjgd3o147Lf85?=
 =?us-ascii?Q?inUoCLmjpQi3x5DqwQxkXPzi8wJG6byN0KChpuUwhbDNMqquN8+z86JvO3FL?=
 =?us-ascii?Q?/Fs1S/XZlrPdj6IvVLqTPgbIJfZZ9AiXGbjS1oopJ4zYMZY/uyohSZTR7wsH?=
 =?us-ascii?Q?xwidUwBCUUXPbK7j+dHmirtxuA9WwFwaBldtmOy0+WhXneBltwQPHzARHRNI?=
 =?us-ascii?Q?oUrmdYUMmzBAlQVChXC+D0ej6DbsPkkwmjHvjpCwdf46r3lbhbt3/acZqog3?=
 =?us-ascii?Q?ZBCeGuHzLOzwTdBQzNtn9+1FL+qXUeprz68SZQqogGKY9kbO4f5YiUb4HFjG?=
 =?us-ascii?Q?nWM6WemLX/j/niDYyw4XxBLgA2HwdC4uoRONlyizHDnak/8+3Fh27TXEgmt/?=
 =?us-ascii?Q?bWTAsDMK8HyabBjS3m39DC/HE9z7/Vtocpab7fin08nOq2Y/xt8ww3s1tvNB?=
 =?us-ascii?Q?jmBIjklOmM7jfBYVLAIJac4ei5ii7GVxlvAu55MbqrX22CxnD00EY+3aNn6a?=
 =?us-ascii?Q?YM+TGO4n2Q9htdDZacHfssdXOkAV+oR+/zwwHRvk2VdqOk+r/2cJMIfqdHL2?=
 =?us-ascii?Q?XdmJVy+skWXw2LgF9c5negTsd26GvS7G4pcYHh5orwfBUe5NPtTOb3I9FdIx?=
 =?us-ascii?Q?8Au4LVttOV+nXbznMallpzOAOz82CpKRLkv2S5aJBDD7U7McF8rU3w7Y/WST?=
 =?us-ascii?Q?hynp4WsDwx75iPp+ejL5L3OAm6eRIiA2bNpQyE+8NwzxDRNb4aFiYw7pKGcl?=
 =?us-ascii?Q?nz27RX3b6ypGVd5Y93vmtzgKdYTUED6fJ2fuAzrbgzuDrDuckDuiQwK31pNg?=
 =?us-ascii?Q?tu944/4cmmD2LpUlfAIf8h/xdsPsU5LCyLLKSOyPoV4UItLS9YCV8hIgQhLz?=
 =?us-ascii?Q?6OW4JOvZohCV7wCCQA0k6mbsr2chisVGgxPQZaEq5+tRqwixbiJid91qPlU7?=
 =?us-ascii?Q?QEQIXSudzeKgWCE8tgl/mD0apBL60eVNXaBhP8itgzzmg/hBTUtAv7aLXyHO?=
 =?us-ascii?Q?DptpyUhcMd+SdJqHc4S9wh02UgJnRrdB9lXAScD2sVEeg5w6KG+47vcdNTBS?=
 =?us-ascii?Q?J3n+NcZKVU7tj6qp6/b6lIUgDoWllMGbV9c3/mrMuu72E+gAKaGeFrJvwrlV?=
 =?us-ascii?Q?u0iO4f4stTAVI+joBofFwAnUYTODOMKBRFm8ccmQD22/qROHxilR6AL4hsW6?=
 =?us-ascii?Q?y4jxW10CiyAR71n3fDjjewke2e73VHERD2r4FxMEooSpOmAtfDGWJamKRIie?=
 =?us-ascii?Q?y79gEl+1aBh1YKNvAFXF1Xfyqq0r0sQqS/B3n9vmyawSSeXH9c6Z3ebWTIkG?=
 =?us-ascii?Q?7a4h2LmfKE9R0rTlJoRoxYUs+vPRyi8AqzE92lMXW5THxvQE2WJejD03ENuV?=
 =?us-ascii?Q?bNu8Hn0lhdNPWyr2PseKVqDh0mPwptRFQYuF4H17?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77eb180-78f3-4ec6-86f9-08dbe0e1e9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 05:08:29.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnam9TFr7/p53ya1JufrCDiYEnW3MijjhgIy6u6c2Ts8IqcTZ8LdKje0NtKIxs45G6ZefWLC6x3TDyxQALsvng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8522
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The values are not specific to stmmac driver.
It is more making sense to implement the checking at higher level.
Let's close the review for this patch.


Best Regards,
Fang

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, November 1, 2023 8:36 PM
> To: Gan, Yi Fang <yi.fang.gan@intel.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Looi, Hong Aun <hong.aun.looi@intel.com>; Voon,
> Weifeng <weifeng.voon@intel.com>; Song, Yoong Siang
> <yoong.siang.song@intel.com>; Sit, Michael Wei Hong
> <michael.wei.hong.sit@intel.com>
> Subject: Re: [PATCH net-next v2 1/1] net: stmmac: check CBS input values
> before configuration
>=20
> On Wed, Nov 01, 2023 at 02:19:20PM +0800, Gan Yi Fang wrote:
> > From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> >
> > Add check for below conditions before proceeding to configuration.
> > A message will be prompted if the input value is invalid.
> >
> > Idleslope minus sendslope should equal speed_div.
> > Idleslope is always a positive value including zero.
> > Sendslope is always a negative value including zero.
> > Hicredit is always a positive value including zero.
> > Locredit is always a negative value including zero.
>=20
> Which of these conditional are specific to stmmac, and which are generic =
to
> CBS? Anything which is generic to CBS i would expect to be checked at a h=
igher
> level, rather than in every driver implementing CBS.
>=20
> 	Andrew
