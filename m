Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896127AF374
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjIZS71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjIZS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:59:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26508197
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695754758; x=1727290758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VayYcQQ7E2GwVDPugmijtmZTYKU7WmOpPGmMr1zqTKU=;
  b=iKMICBnfs4n+ChyYamq8hGPlJgYi08xWV9t/Bwxghv9gvR6G+IsflPBG
   CC0CCq8v1aFxQT39a8TsdBC7Wc8TMFqI9UHrSA9QVnHIBFznYpOHoccp3
   r+0P3gmsJTaM6SPO5IJOmy+yfBkYcY3VytXHLf7qlD9GO1A6Y6Ws3lmSV
   NJDMnflF4T1mRA33I+YOQ/aqg2SW5dnHraA/eRkiIRbynlgo3rtkEpzyk
   12eZF2L7fQhSiIAFE76S8eN6Ivj5w9CCwz17YpOYJhnwrZsw+hH161WY8
   DTUU4quuZNLZuTuDwy81WuVwiBiOt5z6eI0WSQ7APfz3wykmVLvusRvkj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384425394"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384425394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872606865"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="872606865"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 11:59:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:59:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:59:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 11:59:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 11:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dokgAah7gBSKBJeC2MThAUuAkwupuo5ZzF/8rK0XiyDFXtzhUnGtG8kCYSZ8ic93LMlcu/mhffKCscm6jqWONGe7S4pwrYFoUwCiwTU0AvSHUN4Hnpoj2ouHlJh4AXlH7oFVQKOZHROu+fCoQv39eLfPa1Q0TCi39jGOmAV0ixcvDnnwPBFLkW77pHz7RzIf43jiil4z/GBx01hAZkiYsgP+UpLmaf8sfYdUvI8ZEjyaZu3yGtVlQojhBfscomQXCE9+jhiejIqa1XQOR49p+TljGS+/uFVxPs1CL2+M0aNJJQM0mpwN7/KvGPEJeAWqilK9gsl2rZsy595C5p3Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDT+UzWY57csaz8lqP5GmR11P6SxflY/RFu5TyWYQ5g=;
 b=aaMxLzJ5DjkQICtE4jdoK0HAMr6W3JgX+4a6GxoHJg2NvBnFJeUT12+wzBF7+mT+6ubogGgPtI4DGs4OvdZMZ4Wv6WZEd+h7wtkK7KILfDbpTrVs8VnNcr+G4qr832b0pE4HM+u9BmZX9ap+8HK5bJLyOc2iecSts5QUdrfULwcMxiCSqnwA2saqCyYbzdkS15cF7NG9o58CF/6iNSb3YdDwuMd+7hmhJ4kIRkGeqDva/cXGaQKaUBxyIV36CzYG91Vim2+Rfb49UMXZnV4SzZpO5DiCPIZC6G6btptUidlwXvERuBUTjffwwFx9kw8bobPLFKDF03Xzr4FqA6O5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 26 Sep
 2023 18:59:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 18:59:13 +0000
Date:   Tue, 26 Sep 2023 11:59:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <651329fed4947_124e929464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6f3a7a-c9b7-40bc-72b1-08dbbec2acd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6LXDAa6lf/nVXt7yoTi7EwKJ1djR9pDcVOuqYzH6fHFF2usAPPVJDS8qB9y0dd32PygmzNM0VRh6ZMCnZQLEAvN4HBVqwHMDtHLi78w71F1TTIbie35W8vdnjqK5ODytPY+3k7H0bOeG0PKC36aeI0is32DezyvZ1IgS/bBiZSnflLhdNgoqYM69IMXfe4iQ/z7SGI7/87KLnYB1Yd+d8FNctSVOyof44lyVqWz8dYTAnq/Y9xRZQFObJaAmW7d58rJu3JCd1ktdkpMltNZi4gLDJmKM/D6VUjyV0yfk/PHCvtQSEZENq0kk1Kewf3pQV+pN4npVNhs5QkDVqPxv3lni7ZG912id+F3XVehodoIUoPph/KjUmnCcs3/F8UVnclc2KWL9BGqtLlxX9WXuhtvNDKaeks/lKUZzOaSm6GgzL7us1T5okI3HvcydWaUl795WQgLkYmR/DcOsJclxRwBN9Of+BsTor1gzAlQ4QvQJkz/FFHm7jeOGHNdEqaZ9lrmCktqJwQpxpW2hRnCcGy7kj31rLHpEZaGgsvT6kFkGRMa4Iv29eJq+Lolytu1xIEijGWWPrcD1UCfDChL7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(26005)(53546011)(6512007)(6486002)(9686003)(86362001)(82960400001)(38100700002)(83380400001)(110136005)(66476007)(66556008)(66946007)(2906002)(7416002)(54906003)(8936002)(5660300002)(8676002)(4326008)(316002)(41300700001)(6506007)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FL/ABtczYGABz5bCKTrQmrc8QdfvqWL3ntpLcOBd1CnStm1bylT7+MwduMO?=
 =?us-ascii?Q?70ABLlHKIoisfTubxS6Yg32C7NedWgFMlSnpj6qWGdvryvvcb6XE08WJa9LE?=
 =?us-ascii?Q?dyXtY8xnzqf3J3h+v8qkfdRob4ABNODuYMR+kje1uO6ESX6gD+f4vOXrXUPQ?=
 =?us-ascii?Q?Ce0dS0BpatGUT2nkxdHyoJskACdA1si8oa4VJ3woBi04M+SuwZVJekExnFAW?=
 =?us-ascii?Q?WNU2fqqWEfQbzmAsmlpCj91BZuLmjaHOGml3dUEXxCOwMkpaxfWvPqP5nUZ7?=
 =?us-ascii?Q?5VRLTrgKeS+lfq98VMbGKywehsiwNBc+TvdjMqW8D4tFia848317ZZY5Jhc/?=
 =?us-ascii?Q?LpR1UZDAJqBhDycz7tURURB+SX+i1zuI9eIAN0nHONRLbe9yYGSqytB/XWsM?=
 =?us-ascii?Q?o4u9k6KWJ789ON+IrzidlsCJIeWTQfagDJvbDabB5k2PbGhUswZ245whNvNH?=
 =?us-ascii?Q?BUqSQFnrXAYgF1ZBIV4JqQm3/i7NISqowqnuzyeE44jTOCyDdZ3WU+4wTRDO?=
 =?us-ascii?Q?Mf6FUIZQQStM9CDZc89+ikyQfd+wUG6gmyfBEiRU3Si0wHZsoWPB5cjrVYRh?=
 =?us-ascii?Q?L557x6P2GUoXtgqayJasLCaki7eOlje6g1XIt5YQg7cvA2+4M4YCLMQc+ZWC?=
 =?us-ascii?Q?tdzqdBoTIPIJhJibONblVNBfdZRnPYpoqrAgnmwuQ70a8d+//jqmK0ziWPbf?=
 =?us-ascii?Q?zvLNQjkYqRQI76RUJZQUWalnda6339N4vJ7RbMYZZUYHco6gqc29MXkC8sYW?=
 =?us-ascii?Q?xAywkq4s3MpLav53QbxWvm2AeD7oLkvU2tvinx8cVzxyfO947eT/EzALOOXg?=
 =?us-ascii?Q?bEoAVznk7k8olT3zp41rWxIY7UTmtVIS2XpHxC9yRMSmkq4qXkemx8aByQsd?=
 =?us-ascii?Q?gMsHMy/dlk8xhqc6OZi1gD20kijrTiZYz8s4bWxWWUlUHC2aSuoqRV/3czt8?=
 =?us-ascii?Q?LcaaXiBeHTWAHSo7lSvmlzLAN4FhglgPH0irgGvLKTLg1gW7THIV9sQAhGmE?=
 =?us-ascii?Q?j1my+WoXJLLoz8GmXAkBH5hmjgOrJ8XLTZQgZswOwtz7338ca/m4l95j7uvb?=
 =?us-ascii?Q?aP3gzaPGK7HYMXtsmy25pgPzJTkWZnnPb2cqrm3FSvN8NFjhAn8qwFjX1Y4N?=
 =?us-ascii?Q?Y7qxVhp0p3q8HAJNqbr7oHQv9gXwOSK9xm4KhHkz9gF3lCgsdj3YGr3qRtDD?=
 =?us-ascii?Q?ASo3xhtA4xCb8WYZooeXNTObffSMLwIPdwdK2OsoeflZllWtmfqRPKCaneXc?=
 =?us-ascii?Q?bZ4gSa1lh3Tw4TEGpxhseOY4L2MvYsQKa7SUKy5I+jFSZINVjcMu1nGIIypR?=
 =?us-ascii?Q?4Y+uV5Rr62LyhwOdNABvKNRpm+5cZseZcyibmHLi8xN0+BlwKhCp6pIh3RCF?=
 =?us-ascii?Q?FgvirAjkJ4EF693E3vuQBuqsaaGyPoAeSdIz6duwjv4NSW5j5BFfYrONnjWR?=
 =?us-ascii?Q?ahNT5h7wtqriz/2RHrMM1Z9j7Hds1WfefSCOPZHg/iGA38A3iZMh8clGZeDK?=
 =?us-ascii?Q?Wur1lfwIyDVUFj/m0jw9sgGDTAVEPLwQlR9A9dpc9lOSSX3LAIdg6sVFAGKq?=
 =?us-ascii?Q?iM7njYep0IckvX8V1GZq+wE9O1YIVK4sQATMSd4WF2Y0aPnw0qerGTH1V6zC?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6f3a7a-c9b7-40bc-72b1-08dbbec2acd0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:59:13.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2godKSc0CvgPVHsP38Gy+3YcFW3cJRgbGXN5Vsy7VaTX3c8kWpiqp6TnPMIaG/gdkpIBhLdIN0+lMmQF2kVlTQ4xoRQChXZ2VshUCcBUQSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuppuswamy Sathyanarayanan wrote:
> Hi Dan,
> 
> On 9/25/2023 9:17 PM, Dan Williams wrote:
> > One of the common operations of a TSM (Trusted Security Module) is to
> > provide a way for a TVM (confidential computing guest execution
> > environment) to take a measurement of its launch state, sign it and
> > submit it to a verifying party. Upon successful attestation that
> > verifies the integrity of the TVM additional secrets may be deployed.
> > The concept is common across TSMs, but the implementations are
> > unfortunately vendor specific. While the industry grapples with a common
> > definition of this attestation format [1], Linux need not make this
> > problem worse by defining a new ABI per TSM that wants to perform a
> > similar operation. The current momentum has been to invent new ioctl-ABI
> > per TSM per function which at best is an abdication of the kernel's
> > responsibility to make common infrastructure concepts share common ABI.
> > 
> > The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
> > not more, is to define a configfs interface to retrieve the TSM-specific
> > blob.
> > 
> >     report=/sys/kernel/config/tsm/report/report0
> >     mkdir $report
> >     dd if=binary_userdata_plus_nonce > $report/inblob
> >     hexdump $report/outblob
> > 
> > This approach later allows for the standardization of the attestation
> > blob format without needing to invent a new ABI. Once standardization
> > happens the standard format can be emitted by $report/outblob and
> > indicated by $report/provider, or a new attribute like
> > "$report/tcg_coco_report" can emit the standard format alongside the
> > vendor format.
> > 
> > Review of previous iterations of this interface identified that there is
> > a need to scale report generation for multiple container environments
> > [2]. Configfs enables a model where each container can bind mount one or
> > more report generation item instances. Still, within a container only a
> > single thread can be manipulating a given configuration instance at a
> > time. A 'generation' count is provided to detect conflicts between
> > multiple threads racing to configure a report instance.
> > 
> > The SEV-SNP concepts of "extended reports" and "privilege levels" are
> > optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
> > time. The expectation is that those concepts are generic enough that
> > they may be adopted by other TSM implementations. In other words,
> > configfs-tsm aims to address a superset of TSM specific functionality
> > with a common ABI where attributes may appear, or not appear, based on the set
> > of concepts the implementation supports.
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > +static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
> > +			     enum tsm_data_select select)
> > +{
> > +	loff_t offset = 0;
> > +	u8 *out, len;
> > +
> > +	if (select == TSM_REPORT) {
> > +		out = report->outblob;
> > +		len = report->outblob_len;
> > +	} else {
> > +		out = report->certs;
> > +		len = report->certs_len;
> > +	}
> > +
> 
> Since we get out and len from arch_ops, I think we can check for null condition before
> attempting the memory_read_from_buffer()
> 
> > +	if (!buf)
> > +		return len;
> 
> buf cannot be NULL, right? Do you want this check? If you want to leave it,
> in NULL condition it should return 0 bytes, right?

No, and this might deserve a comment for folks that are not familiar
with how configfs works, but configfs calls an attribute's ->read()
helper with @buf == NULL to say "please tell me how many bytes are
available, and I will call you back again to fill in the buffer at that
size".

> 
> > +	return memory_read_from_buffer(buf, count, &offset, out, len);
> > +}
> > +
> > +static ssize_t read_cached_report(struct tsm_report *report, void *buf,
> > +				  size_t count, enum tsm_data_select select)
> > +{
> > +	struct tsm_report_state *state = to_state(report);
> > +
> > +	guard(rwsem_read)(&tsm_rwsem);
> > +	if (!report->desc.inblob_len)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * A given TSM backend always fills in ->outblob regardless of
> > +	 * whether the report includes certs or not.
> > +	 */
> > +	if (!report->outblob ||
> > +	    state->read_generation != state->write_generation)
> > +		return -EWOULDBLOCK;
> > +
> > +	return __read_report(report, buf, count, select);
> > +}
> > +
> > +static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
> > +			       size_t count, enum tsm_data_select select)
> > +{
> > +	struct tsm_report_state *state = to_state(report);
> > +	const struct tsm_ops *ops;
> > +	ssize_t rc;
> > +
> > +	/* try to read from the existing report if present and valid... */
> > +	rc = read_cached_report(report, buf, count, select);
> > +	if (rc >= 0 || rc != -EWOULDBLOCK)
> > +		return rc;
> > +
> > +	/* slow path, report may need to be regenerated... */
> > +	guard(rwsem_write)(&tsm_rwsem);
> > +	ops = provider.ops;
> > +	if (!report->desc.inblob_len)
> > +		return -EINVAL;
> > +
> > +	/* did another thread already generate this report? */
> > +	if (report->outblob &&
> > +	    state->read_generation == state->write_generation)
> > +		goto out;
> > +
> > +	kvfree(report->outblob);
> > +	kvfree(report->certs);
> > +	report->outblob = NULL;
> > +	report->certs = NULL;
> 
> Since you are clearing outblob and certs, do you want to reset the outblob_len and certs_len?

Not strictly necessary, nothing in the code is checking _len for whether
the report is ready or not.

[..]
> > +/**
> > + * struct tsm_desc - option descriptor for generating tsm report blobs
> > + * @privlevel: optional privilege level to associate with @outblob
> > + * @inblob_len: sizeof @inblob
> > + * @inblob: arbitrary input data
> > + */
> > +struct tsm_desc {
> > +	unsigned int privlevel;
> > +	size_t inblob_len;
> > +	u8 inblob[TSM_INBLOB_MAX];
> > +};
> > +
> > +/**
> > + * struct tsm_report - track state of report generation relative to options
> > + * @desc: report generation options / cached report state
> > + * @outblob: generated evidence to provider to the attestation agent
> > + * @outblob_len: sizeof(outblob)
> 
> I think following is incorrect. You might want to add info about certs_len
> and certs.

Yeah, missed updating this with certs addition. The outblob_len
definition is correct, or do you mean the kdoc is out of order with
respect to the struct?

> 
> > + * @write_generation: conflict detection, and report regeneration tracking
> > + * @read_generation: cached report invalidation tracking
> > + * @cfg: configfs interface
> > + */
> > +struct tsm_report {
> > +	struct tsm_desc desc;
> > +	size_t outblob_len;
> > +	u8 *outblob;
> > +	size_t certs_len;
> > +	u8 *certs;
> > +};
> > +
> > +/*
> > + * arch specific ops, only one is expected to be registered at a time
> > + * i.e. only one of SEV, TDX, COVE, etc.
> > + */
> 
> Since it is ARCH specific ops, I think adding some info about its members
> will be helpful. Like what is report_new callback and its acceptable
> return values.

Sure.

Will wait for positive test feedback about the sev-guest changes before
spinning this series again.
