Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C47900CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbjIAQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjIAQiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:38:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754810EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693586301; x=1725122301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=02xKn3rDPAuwcIuZh/zz8MUF8I7DQTtaf8ynNc9E93o=;
  b=gXI09b4+YII01UFpURLr/skbgS0YOL+h2llUjQMb90X4iw9EGAZE/i/Z
   9S+rvfaKNovrRhG5b1qezY2Kw2D3E5JEsocGfbFmC75Qw9BQ+fNBz1hCe
   GGnLBY6j8GM0nFmmgTnPn0PtU3Hiy8M+am98GqaZW7LHH7DYrXMCCKyyi
   PtWT4z5QrRA8WpO6z3XsaMXuxwizfaJ8PyqhF/3zHj1CN00uJaVQnWHyK
   jPlgI/OZHAjn/xsl0CWMQU8Xri+otr+nEN08apad/xtrFOD54BQGVgmuq
   dD+taPyQFBnYwkANnoS0KL4nGcQR5qa0tXbjc7peQc2Jwk9VrLpjMckDj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380044233"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="380044233"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070802995"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="1070802995"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 09:38:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 09:38:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 09:38:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 09:38:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 09:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPCzpNbrQWE4pb4llQMrNbLZHYngH0wB5ReaJooyqvquDzcxcHPGD+FgKLNkqYv833e+Z/Xtmj6RpMVHQbivSeQfGMcSyiRizVemnDngQ5laHa3Il+eNy45A/aWYbwVLoAiTVX80GRKB2jPl+4BIrHJiih2tX4cUSLyqitMBCEMkS3Lv48cz9Gix7v0VxOsdeZ3LLOhi4EiygBwcaEHwCVeqzOimp1L+RD9rpQmL9jU61dvHvvezIqyoAz1PwqhTEUtdaPcqChi8Tyv13izD0NLnDplHhlHtZgvqJG7NVTUMz/6PvJCSy8VPDd9oKyzpw+GftqpAqbyU634PZa0Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEM5OOUKE3fvf6YgJbV+aDP9AQIG8VTeofk8DHuheVE=;
 b=D7mZ8/EUQb3Fh2toC9qYDB+IyoV/+NB8nRXd/W0QwvL/zZ38Cyz6Zlywj8koRU2OHusSc3S1KdkBegxE2A3nqJ+DuaeLcDudkCib1D65q36cDzDIxs89pOJB1V5qILI80j1b8pnRYgBpNpYIEueM2rWLxpJOJ31x+l8m6gdq6QKo+aMz63NxjDOIfpbIqg/D8zdVQDqnhKbT58rmz518Ne6M4uWLf5ZLQwz2isBfBXDVB3zo42YAIaqEk5VQDIYKKkKWc+StGdtjAGK5k/fWy067UNm8xPlxyFm4zxD/10JqFj/K0JqLjAuVc3eNC98FumeUkAIwPyvrEt6wA8CSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 16:38:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 16:38:14 +0000
Date:   Fri, 1 Sep 2023 09:38:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
Subject: Re: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <64f2137362305_4c1f3294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
 <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: c33352de-fb6d-4f20-abc7-08dbab09d67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8XQmd9yM1efdSFXAkoKsE6i9i86Au7WIUfy5XXM0GYeE2/IEOWstP+vWT+J5VnWFA/3QrCTc0mCOLxBR1tu2Ui9c8f3rwbkb5coc1W9qI7DjboBjTRoh4eZOeSDnhtbYRSyyGgKxuIM3m/DdE1fC4KQmls4YLbtIEo1YDqkxFGvRwE8+Y42rkvtACYhPFeKRb0h3FNAlbbpd2idYPhHM30ujn5QlE72DJYt4ZqQFFx6KOmNyrVyNCa4/tb2ez+G5bmHYj36ZzPDKPBX4M+s2sBCAxfKrDThnIUJw4/EJdmGlZye/nOMSL8Go1JZ0ncCbCe6EXSFPaIuPnqGIfbNr+S+8P+zIosVSZ17GRiJfPsXTQ3w7A5mewn0vxBYr+lsBDGlOroI4h/96BHeSvCy4zyUYwB30A9ztx4sCSshL46/j6QUjB+CZ3sFFmqroo40wy2xyskOYwYdwGLEh6deo0sky/glCOE938wzIU7MoqHxm9IBwIups/dngZ44EXobzkSAJqKpB8ugMm4pRzV2Nu+xZZum9LvhNLGNGTnBpazsJA65uKHD/7PL7h0ZyQQr3psFQ9F9iUGQZNPTtZXso8Y4MQOg38i2mbDegSVD6k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(26005)(38100700002)(966005)(66556008)(83380400001)(110136005)(66476007)(54906003)(66946007)(316002)(82960400001)(5660300002)(478600001)(6666004)(2906002)(53546011)(86362001)(6512007)(9686003)(8936002)(8676002)(6506007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nxZNdWlf0ueFdYNRogbuSXNRWcxvOUIBZ6X0zzBxmghVR4ogtOSr/na44kiz?=
 =?us-ascii?Q?PcFZdUVUBUaybBN5ovzHMooYzIC/SFn6pSA0g+p2cN16yNJVGbR5e/dBcq2p?=
 =?us-ascii?Q?3NnxvtSuXvPwe5oKgQWFjkdliMoy2NWsQr12B/UVOhwgt+MFdY/giApHFKDQ?=
 =?us-ascii?Q?vTdCb6g2KqJbEqJUeQlbfCjloGnbQaOK/mAUChM6UC3XOoegREBPm7O6eVJJ?=
 =?us-ascii?Q?RNF7MwIzzty5J3rekMZvuSqkyoR69QEIbyyvQgG4OOhCpy46YMnZSY0zSbXo?=
 =?us-ascii?Q?6ZlvngDUMLYvZJZV9wSfYUAvU7/2WfHOCP2IuBQHfxAC/OesUGs5dLbbG3c6?=
 =?us-ascii?Q?6wmn6MvWDzjH4b9ulV/sFuD96CWXN1PRPXtiuRje7UgvEpfjJlWAY6cfpKxb?=
 =?us-ascii?Q?3RGddZYFT3QlcWX3igoYCxO2jI7HiDGqmRd6seRLPNXkYUf2uKjWdDzKTLjD?=
 =?us-ascii?Q?/uBiYCyvawcHJhbKLURLQaqr4TSatzc9WlTsqQoW5sf/5nO3GIW1pKmpxv+K?=
 =?us-ascii?Q?PhIQPcs6NK74VSqd9vC8e4cuSd5xklc4v3hs34m2yT/dmFlo2WhZ172QX9js?=
 =?us-ascii?Q?mJ5vSjTDyMOAGIWuO/svPZjbFFnRDIzl2rzbdgnGvsn0ce98BmcnpsxVnWGV?=
 =?us-ascii?Q?CIajr+hRc8e/IPFxxPkENQZnoDCd7xRyWfqjILMkpyH/9ajuKoozawKr44Fb?=
 =?us-ascii?Q?FhwItkWC3CynBnohDWv/r8Jk5Sqb2sEbA3waUafL/lfFuPTzCM82u27mByYm?=
 =?us-ascii?Q?VKtyNOe3UIDsc7OmXv8Rc4VJr9gLfgQORwII0hLuez4tyrfH+qLaBw8Ncgny?=
 =?us-ascii?Q?pNNLLq6m24vDNTPDSfwvAZD/jtkBeY5520Dt2Zq4OwBOxcTCn/HBrCXV1fB6?=
 =?us-ascii?Q?DaykOS8F9lUWK6/2mEeSekR1RgOE9qtdXsCJ1dYoEDrEe2Kd7FohFbHKNkX4?=
 =?us-ascii?Q?RLB2kko8EEdyoZ83VEzscL+cTYzuIf1H7AMrd2p0NRGkzd5cogms0iVBRNSx?=
 =?us-ascii?Q?SfgLj/L6cHbBhTmf0RK7nWF8VcrO4hnhNBCjYiypI5BWeXlJ0oK+FG/InkyU?=
 =?us-ascii?Q?37fKo15Tjf5hzDe+iStf1+QZu7uKqe4IrMjL7DYzQQhsbhYIU019pHlkCPZA?=
 =?us-ascii?Q?qTSLTSAQuwLEjh3k+GOjyyXf63MBWQQ0OySEZpanIuvb8Hgun2MixKDaFYYI?=
 =?us-ascii?Q?bKFaJtswpEBl8saahvk5Wydb3uHNp59JaeF7oUf7VHMRrciiB63w0GgrwDPC?=
 =?us-ascii?Q?n93Xjnw0EicXwghW8ej8QT4SaHzhEbAC0mIzKv2XF6wAkit/Q5VuoFEFuwUK?=
 =?us-ascii?Q?uCtAB5LAjVY02wH7w/hsDesh7h/t5CLrUFt1IL1gMPZiZKRjH7+62ltP6flo?=
 =?us-ascii?Q?pU3RNcliI3lMS/jh3qD0A8VCjOZVx1ZZzqf26KIJfuaw41lIQZEuQTrmhAp4?=
 =?us-ascii?Q?ObtLDcNvTIlq41XYrmbSQLFw1LR1uPT+aEc59j9xpnFi7WacoCOuoOJZFx74?=
 =?us-ascii?Q?XcxpalDe2rUOWOPSdz1xqwZGODNmRMQ486efOPHt4Swjsaq8nqML6MmvNxYq?=
 =?us-ascii?Q?lnwO+nNu4qNF/vvJcox+IBnKImx7zT/PKOvsm0PmOKKXytDterkRdKKroIjj?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c33352de-fb6d-4f20-abc7-08dbab09d67a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:38:14.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXzj2HpsS/C1hCOnidgMGD7d6IfSIdMDKaPXQCUlk1FGNbxXRn5Pe4fd9iUKmmX0b5vqh/bVXOIvqgo46T9Hiz4sYgqC9bf7T8rati4kkkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremi Piotrowski wrote:
> On 8/30/2023 9:33 PM, Dan Williams wrote:
> > The sevguest driver was a first mover in the confidential computing
> > space. As a first mover that afforded some leeway to build the driver
> > without concern for common infrastructure.
> > 
> > Now that sevguest is no longer a singleton [1] the common operation of
> > building and transmitting attestation report blobs can / should be made
> > common. In this model the so called "TSM-provider" implementations can
> > share a common envelope ABI even if the contents of that envelope remain
> > vendor-specific. When / if the industry agrees on an attestation record
> > format, that definition can also fit in the same ABI. In the meantime
> > the kernel's maintenance burden is reduced and collaboration on the
> > commons is increased.
> > 
> > Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the blobs that
> > the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow follows for
> > retrieving the SNP_GET_REPORT blob via the TSM interface utility,
> > assuming no nonce and VMPL==2:
> > 
> >     report=/sys/kernel/config/tsm/report/report0
> >     mkdir $report
> >     echo 2 > $report/privlevel
> >     dd if=/dev/urandom bs=64 count=1 > $report/inblob
> >     hexdump -C $report/outblob
> >     rmdir $report
> > 
> > ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> > format to "extended":
> > 
> >     report=/sys/kernel/config/tsm/report/report1
> >     mkdir $report
> >     echo extended > $report/format
> >     dd if=/dev/urandom bs=64 count=1 > $report/inblob
> >     hexdump -C $report/outblob
> >     rmdir $report
> > 
> > The old ioctls can be lazily deprecated, the main motivation of this
> > effort is to stop the proliferation of new ioctls, and to increase
> > cross-vendor collaboration.
> > 
> > Note, only compile-tested.
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/virt/coco/sev-guest/Kconfig     |    1 
> >  drivers/virt/coco/sev-guest/sev-guest.c |   83 +++++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> > 
> > diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> > index da2d7ca531f0..1cffc72c41cb 100644
> > --- a/drivers/virt/coco/sev-guest/Kconfig
> > +++ b/drivers/virt/coco/sev-guest/Kconfig
> > @@ -5,6 +5,7 @@ config SEV_GUEST
> >  	select CRYPTO
> >  	select CRYPTO_AEAD2
> >  	select CRYPTO_GCM
> > +	select TSM_REPORTS
> >  	help
> >  	  SEV-SNP firmware provides the guest a mechanism to communicate with
> >  	  the PSP without risk from a malicious hypervisor who wishes to read,
> > diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> > index c3c9e9ea691f..c7bbb8f372a3 100644
> > --- a/drivers/virt/coco/sev-guest/sev-guest.c
> > +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> > @@ -16,10 +16,12 @@
> >  #include <linux/miscdevice.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/fs.h>
> > +#include <linux/tsm.h>
> >  #include <crypto/aead.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/psp-sev.h>
> >  #include <linux/sockptr.h>
> > +#include <linux/cleanup.h>
> >  #include <uapi/linux/sev-guest.h>
> >  #include <uapi/linux/psp-sev.h>
> >  
> > @@ -759,6 +761,79 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
> >  	return key;
> >  }
> >  
> > +static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> > +{
> > +	struct snp_guest_dev *snp_dev = data;
> > +	const int report_size = SZ_4K;
> > +	const int ext_size = SZ_16K;
> > +	int ret, size;
> > +
> > +	if (desc->inblob_len != 64)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (desc->outblob_format == TSM_FORMAT_EXTENDED)
> > +		size = report_size + ext_size;
> > +	else
> > +		size = report_size;
> > +
> > +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> > +
> > +	guard(mutex)(&snp_cmd_mutex);
> > +	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
> > +		struct snp_ext_report_req ext_req = {
> > +			.data = { .vmpl = desc->privlevel },
> > +			.certs_address = (__u64)buf + report_size,
> > +			.certs_len = ext_size,
> > +		};
> > +		memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
> > +
> > +		struct snp_guest_request_ioctl input = {
> > +			.msg_version = 1,
> > +			.req_data = (__u64)&ext_req,
> > +			.resp_data = (__u64)buf,
> > +		};
> > +		struct snp_req_resp io = {
> > +			.req_data = KERNEL_SOCKPTR(&ext_req),
> > +			.resp_data = KERNEL_SOCKPTR(buf),
> > +		};
> > +
> > +		ret = get_ext_report(snp_dev, &input, &io);
> > +	} else {
> > +		struct snp_report_req req = {
> > +			.vmpl = desc->privlevel,
> > +		};
> > +		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
> > +
> > +		struct snp_guest_request_ioctl input = {
> > +			.msg_version = 1,
> > +			.req_data = (__u64)&req,
> > +			.resp_data = (__u64)buf,
> > +		};
> > +		struct snp_req_resp io = {
> > +			.req_data = KERNEL_SOCKPTR(&req),
> > +			.resp_data = KERNEL_SOCKPTR(buf),
> > +		};
> > +
> > +		ret = get_report(snp_dev, &input, &io);
> > +	}
> > +
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	*outblob_len = size;
> > +	return_ptr(buf);
> > +}
> > +
> > +static const struct tsm_ops sev_tsm_ops = {
> > +	.name = KBUILD_MODNAME,
> > +	.report_new = sev_report_new,
> > +};
> > +
> > +static void unregister_sev_tsm(void *data)
> > +{
> > +	unregister_tsm(&sev_tsm_ops);
> > +}
> > +
> >  static int __init sev_guest_probe(struct platform_device *pdev)
> >  {
> >  	struct snp_secrets_page_layout *layout;
> > @@ -832,6 +907,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
> >  	snp_dev->input.resp_gpa = __pa(snp_dev->response);
> >  	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
> >  
> > +	ret = register_tsm(&sev_tsm_ops, snp_dev, &tsm_report_ext_type);
> > +	if (ret)
> > +		goto e_free_cert_data;
> > +
> > +	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
> > +	if (ret)
> > +		goto e_free_cert_data;
> > +
> >  	ret =  misc_register(misc);
> >  	if (ret)
> >  		goto e_free_cert_data;
> > 
> 
> I tried this with the non-extended request

Thanks for testing!

> ...and realized it's a bit awkward from
> a uapi point of view. The returned outblob has a header prepended (table 23 in [1])
> and is arbitrarily sized at 4096. It would be more natural to only return the report
> field and the count bytes that the report actually has. I've attached a rough patch
> below to give you an idea of what I mean.

It makes sense, especially if that is what the legacy ioctl output
buffer is emitting.

> The extended guest request is another topic, since userspace has to be aware of
> where the kernel choses to put the extended data, and fixup all the offsets in the
> table (section 4.1.8.1 in [2]). It would be better to return this data through a
> separate file.

I notice that the TDX report also includes a certificate blob, so if
that is a common concept then yes, it makes sense to have a separate
file for that.
