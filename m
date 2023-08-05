Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE14770D51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHEChu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 22:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHECht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 22:37:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB013E;
        Fri,  4 Aug 2023 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691203066; x=1722739066;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r3zm5MvkehnwItITK7C4uBWv9An9/eVLCvG/1DaqZFg=;
  b=IdaddIMdylvuAkfCbOditsmJlvy869AEMXrUPVITQZ3bVhAgmCjrPAjT
   6GBD1XETBfAavqxJzaIm80mNNkqa3ZSSeWUe1QQmbSqr5QgYCiMK9d3fg
   ZfbKtVQzRgY/lRazxW+N/nspq6XSBfpraZt+H0/GS7ERn+0YbMQQrAoeA
   bvS5cCO22JNPpAxJOVyqAhb6jlksMi0Et0I+Cuh8KtmkGEfORwvuFibAK
   JOvlckS6suiOZU4svvhGc7rEBh+jJaavWyDA8R8QWx3kJGzHIkIH2s3FH
   Qto2HZALgE/qu9Uw93ijXm0X5Fp0ca/gKiyeuJFytqkG/RH3a2hGC39qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370272818"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="370272818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 19:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795659350"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="795659350"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 19:37:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:37:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:37:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 19:37:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 19:37:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV26DfVu2orgjkg3eenP9zproKBNOfA5HIqiLWIRbQ/F61IckFA3Z5MkcbXyBNL3asAFCgFf9UhvpcVK1Wk6DFxRJ76MMYePLOrES1r1qEAG3Xy0hqGLm6ww56qmg2ygVPd71APbl2ddutbozHRouxWFMrp95Tf+00WGsN3dsgvt06mGPDCNVocv/O1C9p8IT5u5Lqhm9s06uCZ6HYDWMB746DRv0RPsFKz7u1B3RiITF63783kj8x2FpamLTj4qs/5RyJ2CYMcTXBgSTPeZoNKgHw0Jdrr8AjTQOBoosHSK/hOqPdQbKTIs/ztLyc0IrMwUkQCgDzAXXRYA/I5fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIt9QJB/gYhNsYFgN9g5mXVsOmQUAKylLf6AiecREfg=;
 b=TM1BMt0IQmMf/Rc4x7fLlBGnR8LpnmhCa5wdkGCSNy5Hckc/orqr5ax2m/L6YcNlNLBDNUbEMkfz77L045dvH7BfWWlwksQyFdBnMBlQkWEJXnTHfiBwJ7mUsQhzi69ZgG8vPupSWOGeyYnSUfNsfJEoKuLfX7473B7w+ElpRVvFZbaP0XxpvriPiPxLxYSqBeBkhxAxmIuprKWtj4hbkxyYxvuDUnkBGUGB85mzStrUI2PezbrOX9tFq1n0458BDOS6/pCSlZHQhg4/F+MVYYhiLjAqYwGBfRbKi9Q3arKDQf5XiRRsh1klKCffc/WmTrjsDoLmvM5wLPqJGaGhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8175.namprd11.prod.outlook.com (2603:10b6:208:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Sat, 5 Aug
 2023 02:37:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 02:37:41 +0000
Date:   Fri, 4 Aug 2023 19:37:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: e735fd8f-1e22-4043-d75b-08db955cf0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCSV+vnKPw+BZ07D9H35d/DmWvnTDYAH9FoieojaZT0qgo6RvfRVlOAIZ8yMTEq3LO7ouvcFW64GpL/6AVQv/4uY5TPw+A+gVn9sUJCB3z92nEroU7Rkail6wNwqY+Hl1mlG+f7E08rRxslpyuPZmmtYbFqmvYqkXWfb6q/gQsOTiszLlqzzE4iB6VvLx+EjkMqyUwBAhxAkU7cFJJo1EEPX3ayox+5CsZF6DWSCNBMBmeLNW3rqJ2wcQFEtRLU3iY9KXtwF2n3wH5Pfvzyr1Y+g8cnzxN+LlF4tkKo90gRDu+TPSH582wkO/9DYREDdJcP1qafYFjudVJmh2ulPbT5ZjJVY8zjTrJkrBRNOmytVWuTXw/3YYb1tY5jdfpaKJmDKriqPUfuI6XYIsecwFdqvjU3qtPyTFhWsdYeLJx2vNMImWQkH57TBk80lU+0rm3Yfag7oRkCAxldgDuc4IV4vvELpu2azIAMQmu/ZuxnzbfKA4bV0KcnU7LsvLO2TGcIydyZi1N3/lGp682A1qNcvKjBT0wAKDk2yYvMqbXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(66556008)(41300700001)(2906002)(66946007)(316002)(66476007)(4326008)(8936002)(8676002)(5660300002)(82960400001)(26005)(6506007)(86362001)(83380400001)(38100700002)(6512007)(6666004)(9686003)(6486002)(110136005)(54906003)(966005)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jv4tgNm2cl6+KKzzwsIJ1WSf1/KQAOvZuiE3D5923LdIjoe940maublEeKLq?=
 =?us-ascii?Q?nVf4p/HZnEL4QLUeyJTlCKI+/5l4u8Fke+MM5vr+8U6FwzRuIBmWNrzWYBXO?=
 =?us-ascii?Q?xMOF22mFzzmRlXTkL+HXI9uDupitPl1STPL8KFhTlPhRkYpd+t+eEK71c0rJ?=
 =?us-ascii?Q?4wGTgFQzrmYDZrTnVnIFjrOa/z5gqkOy/3tShGZ22fdRr27GyqiXahDrHaFs?=
 =?us-ascii?Q?RmH2BaoUs/aEX9mcXpfgngAWsRDKVHH4WikMNe1zj4j5ctvbE1OOoCHs0ygR?=
 =?us-ascii?Q?0C0kdI2EDxhtiGBiLJegVPf2KRTirDmhnqewfydsQuuUAFxJWzGoe+T7Qt5A?=
 =?us-ascii?Q?RzeRP40DV6VWw60InNLMK4SUK3RSzpQYN0UQwIX5P6bNG0KvYiYuW3ISGcDs?=
 =?us-ascii?Q?Fm5AZBfB9lp8xq/89A6xPMhMuAPe1/pw6fOAcuFechhmeDrYTJLNUvnyUNBy?=
 =?us-ascii?Q?MsjjqOLQWE3GSLPa6AXaaph51LjC5c6PoaVxLP+wfB2ERaMewwq2El1fgMGU?=
 =?us-ascii?Q?ig5W0iYVXYplf315rIbUnRbNbFDkzlUyRbDoPG8b3Ls4+HmDGGM0xSc+FYq2?=
 =?us-ascii?Q?clhvhYK7/uIStrITEX9/73TPTOKVdNChAvduFA1h2NHMSDEtkaKJ4MzkqwPG?=
 =?us-ascii?Q?c5VBfZ8K7uA72xHAoMKgqUWFym2tzbVA2UgRRjr/eQ91ZDwEq4FBhrTueG99?=
 =?us-ascii?Q?nncqxpHlZrBx/t2RqfePIdU2RCvZ596PF0azDhKU51yTS0CHN0+sMQ7MrM76?=
 =?us-ascii?Q?IRvVe5atmKaSxwCvCl3iyWADEwVDg0c3ZdHRzofrrfyxihfZfC1QZ55qgSbt?=
 =?us-ascii?Q?stA2f7VhFBNN3XD5zkZNoOiFq0cKqb2dxrt3B8HdXVDKyzIEnmV+fdDxpSsc?=
 =?us-ascii?Q?Ihw/NYNr0o7E4pbU0MO4Q1FFyDei6EgL7hqWMbjd5FhbTTBuY0bVEHGM8PGQ?=
 =?us-ascii?Q?ezZfiG9LMydz5CdBsEdemtBSnHNXiuTdYh3KPY7Umo4Vn3EkOLrK6NIjFyeb?=
 =?us-ascii?Q?siUk1+SDCwUz/jaStZe9fHfDbyq4fxtDHr6u1VJk66hM+ZyObt2fQlEQcmzk?=
 =?us-ascii?Q?9N5cXkbQJcdDMnLLIALhk+zD4Kcev6bI4DQ6ayEliikqYD91SsjtDAQsDnhV?=
 =?us-ascii?Q?iYVAinQbRsVJsCngt0WaimI8Qsmcs9ZF2Fqvls7P1HXJmhTK4fUSVBCTwb9d?=
 =?us-ascii?Q?1NJnHojsDklo06DNTSW/cEqZfUOgy9cqF4tAvVM9RotMP+5xR8agV5btxC5G?=
 =?us-ascii?Q?ggVNywPekpExMN+JTv3E6i+9m+Iy5ILXckqeGjFd1dlK9bcEWt+ZaMczHvu1?=
 =?us-ascii?Q?k8xu8lDI4mRr51ed6VhiQIIFR3sep8WsZzsGyq1jRg3MWXfOG37d2IUyfU86?=
 =?us-ascii?Q?UXqi6k3MQ+VTPJVDgL65sGeb5HtSskPVnRGlQtDAusr/ocqjyOZaHsxaJDgn?=
 =?us-ascii?Q?gvOIXNfGV91AdXQDLeE0sSnX+9Kc0eeE6RoI6OkwyiA5NGKfZpE6oH2qOFaR?=
 =?us-ascii?Q?2r/RxcqwSjZ7FcN8+2nuR8Bo1QkBCgKLAcPGz7EnE7dUw1IyIr6v2HM05QsB?=
 =?us-ascii?Q?hbN761d349uUfdkvnpjM02S++eJwd152mdhVCEpDxSTFIJ/5HYMKJcQ0NrPJ?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e735fd8f-1e22-4043-d75b-08db955cf0dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 02:37:41.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x+HCizOv3sh621kf9S2sawtUu0mJkKsVRjTM0rLLU0tUlT3MwM+RdTJ692Nz3t/ajWvE0HzP0NP1wx67cyrTHBP9LwaAzqrvZODmqBwPqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
[..]
> > This report interface on the other hand just needs a single ABI to
> > retrieve all these vendor formats (until industry standardization
> > steps in) and it needs to be flexible (within reason) for all the
> > TSM-specific options to be conveyed. I do not trust my ioctl ABI
> > minefield avoidance skills to get that right. Key blob instantiation
> > feels up to the task.
> 
> To repeat: there's nothing keylike about it.

From that perspective there's nothing keylike about user-keys either.
Those are just blobs that userspace gets to define how they are used and
the keyring is just a transport. I also think that this interface *is*
key-like in that it is used in the flow of requesting other key
material. The ability to set policy on who can request and instantiate
these pre-requisite reports can be controlled by request-key policy.

If there was vendor standardization I would be open to /dev/tsmX
interface, but I do not think this deserves brand new ABI from scratch.

> If you think that the keyctl mechanism for transporting information
> across the kernel boundary should be generalised and presented as an
> alternative to our fashion of the year interface for this, then that's
> what you should do (and, I'm afraid to add, cc all the other
> opinionated people who've also produced the flavour of the year
> interfaces). 

So I am coming back to this after seeing the thrash that the sysfs
proposal is already causing [1]. sysfs is simply not the right interface
for a transactional interface. My assumption that this interface would
be something that happens once is contraindicated by Peter and Dionna.
So sysfs would require a userspace agent to arbitrate multiple
requesters reconfiguring this all the time.

[1]: http://lore.kernel.org/r/ZM0lEvYJ+5IgybLT@redhat.com 

> Sneaking it in as a one-off is the wrong way to proceed
> on something like this.

Where is the sneaking in cc'ing all the relevant maintainers of the
keyring subsystem and their mailing list? Yes, please add others to the
cc. 

The question for me at this point is whether a new:

	/dev/tsmX

...ABI is worth inventing, or if a key-type is sufficient. To Peter's
concern, this key-type imposes no restrictions over what sevguest
already allows. New options are easy to add to the key instantiation
interface and I expect different vendors are likely to develop workalike
functionality to keep option proliferation to a minimum. Unlike ioctl()
there does not need to be as careful planning about the binary format of
the input payload for per vendor options. Just add more tokens to the
instantiation command-line.

The keyring is also sysfs-like in that it is amenable to manipulation
with command line tools that all systems have available, or by
libkeyctl. 

To the concern about where do we draw the line for other use cases that
want to use this as a precedent is to point out that this usage is
demonstrably part of a key material provisioning flow.
