Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4077D551
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjHOVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbjHOVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:40:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26471FC8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692135587; x=1723671587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pW4l3qe77bEQ3o5ie1VPtfU4OPPsp9ep/8h5ajbCaKw=;
  b=e2JESNsBsNlPexVrihaf8xfl5twPFWs6kpQgsESbKAGaxxtQPICjpupp
   Et4heHVX6uSccqzclST37t7Xhex0obgYJLCL39eNqrjd+OTwuzX+brLBf
   moVNjPJxxv5e1JSGu2B+f9ta0v5IMQ13odGNMHR7b8niNZAHjkFjanE1K
   igzOkpmqk/WTRPJT+3gay4KOQeM7QMQjhrmFtpTuKTknWYQ1VDfqvUDpc
   m2vDPFpAnHwr+ruRL+uJULh2K2w/+PJALU1L4qHv/B5E0QyHPZserNIf4
   Mj7CxcIVWJRYWobdVGI1/t7p28J3rAk+7QY5A948/qmayQn9NVsgQR6n+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376115827"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="376115827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823987167"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="823987167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 14:37:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:37:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 14:37:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 14:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHo7PzUK3CQAxh0VTerq7YzHFulpzi+qvOOsV7ogvyfjaLFGKF5zTf4T8zWP8XN3rEapEmnmuLwQ4pTd5Bt9oqlZHSUK/qVM1HutxaFH2sdi/9IPoH4uertMtt9MqBpfeDAOvynsnbLNVj6DBrxfkWXl3qV6JcF5A4BL4b8plIUZcFB1eYBMm9+GkKGe8j/uyeSxm7tl2be1W9+mjQ4NFDgw37DqOVFV1/d4LEtbzv7mEhEGztUCnCCiCCO11bbnoj+lIdSurtCG1CwFLLLu5zQsSLdaN+xLFNZ/ZOqeoDaAxPwUk6TcWCZBIUl3iWL6a9j5qea/HYeiH+RwISDsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=267W2r79i2AOkCts5kyQ073yxsd3e0TqzjecJ4z7QIg=;
 b=AyK5vV8dfbESte7HOpOPyX+laX/kx8CiX74TVPKRbBEupoxjFQdO2jL+NGx8DPKk/K86wzjIHJMiSs0xOpoUAIc2dmAoURpFsG25VRwa/rJNR8hQlh9xf7XLnuSAxRLex9hE321UHak8j0UbdGRIFrzdc8R0OelxNJd4FcI67rReKJbLzaF3d+bcIOgheUrj/+PKevEH5Z+947Xk0yoiyi51XbH8xtoGk8WABHKtZQqQZmQipitMG9uRhm6ItdyWWf4PwdI8ikzpsWdzE/x+HylkaRLFw+SMoFh1cGWVQYW42eB9eimjL7tb5PaLBzRoWAXb4sfC4bZ/8OEmRPwVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:37:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 21:37:05 +0000
Date:   Tue, 15 Aug 2023 14:37:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Message-ID: <64dbeffcf243a_47b5729487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
 <ab871b36-203c-6b40-f5e4-2dfc4b15b41d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab871b36-203c-6b40-f5e4-2dfc4b15b41d@amd.com>
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: c6167d1a-fd86-4a8c-f85c-08db9dd7c4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XecapEC6TyPQFlfTEucXQuv2przi/UAgFAlk3KLBIz6esN/k3DJipLT2cnnoTvEN3h7b7Apmy1Fxa/2+AjClB8Zw5QwI9EBA/dcZIBg7piHpWGZ8E7RQFBFvh/klOCH6201Owav0sK/EQoiMAj4g3XhBRbbt334K4Bw34g4phCrnHRdsXxOMRoCr0XT1UGVkWcOkp3XCQ5zW25br+SRH36hl8SKJZXu8sRteUkmL2cMME7vWiSXJX2Kh3ByOvUJ2ttA/Ls8u8CYlwocgo/Drr/zjXM+CU5xgSIltRPQIddQrso9dmblL7l+BypBYIZ5Dq6RZnRjCyamRK2XCLpiZn6odxiAfSW5bzoE0NAzKNRv1/E4m7Pw+qb3efD1yoY3jbpRG1IJv4aEeTlTbVnosi7yOSoFEi0lUQqNZDmZbzFMAbnp7gKb+VkxujeI0eSdW+YpTfnHXg62/pPC28zIhZgl19zySQHccAKPtOEAuh94hQUK5S6Ax7LqDBYjbcjZI+0oII0H6Sl3jWGKagCnK7zMerHdr8FxxeJIzcPu1d4o5N7dpSYX50Q3kpYeeS474
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(1800799009)(186009)(451199024)(38100700002)(4326008)(316002)(8936002)(2906002)(8676002)(83380400001)(6666004)(9686003)(82960400001)(86362001)(5660300002)(6486002)(41300700001)(6512007)(66556008)(66476007)(66946007)(53546011)(26005)(54906003)(6506007)(110136005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcEeA5Gfq1QfCyPoOt34tvL4xxjoiJFMHJGVlK2itMraPa+dP7S9OsC6pjUS?=
 =?us-ascii?Q?fQCX8Qgn9AhiTTlOiiL5J6V2TD4lyF1L7m8Lzm8Rd/gGDa4+bf4K2xU+7I0n?=
 =?us-ascii?Q?sKtfB/eiP38HV0mJKjx5sPT2I80TTZzoYzpeye7RS0Wvladlx6LAJcukfJmK?=
 =?us-ascii?Q?O/Bjw89CC7tofTxgUJ7cnmDIzWxnR2ScEYjqNlrcLkuRsfthFX0Xcu0Kxz7v?=
 =?us-ascii?Q?jdsx2PYIxtB4HR4CnQLSdHr17D4J8QBqU+EfqEkDnVlVo/POrazSJbdRA2eI?=
 =?us-ascii?Q?8+IqCCy8A3+6OECPd2MDvkAa3Iem2puyqZO00e1Ou78yCwbxo5UKOZJHTnSn?=
 =?us-ascii?Q?xOlMsMd1ZCCqIzzrccLuBlbhJsWJogJhHG12Pn3MiPJS677xE+1LjObofHL6?=
 =?us-ascii?Q?7GmpseS3bzg9Fo19Arv9UUjOvLthqHTYiZDrENbX7wcDXjgukWaxRyqVNS/X?=
 =?us-ascii?Q?OrzbwwY7u/JrBDef/klR6oQowREQQAoYP6Tr1uFN91gqs/0UDdbHu80dD/sS?=
 =?us-ascii?Q?A9lNMlLpJcg8N4HyxDaXg0CW8alHKvwxrty7nsUQZSO86nuYw5Vsb12RXw8j?=
 =?us-ascii?Q?MVzDIQpfnVh6XAbrYHwOd5zeWV1u3yqBWoTpxbl7fGabMnFfEl9Kizu8AW9e?=
 =?us-ascii?Q?YMj+kD4YnKNGANmc2XUfbun/ueliIA/1saZhpnUWja+uaqh3y2nW6dbshqmj?=
 =?us-ascii?Q?vbsmADVLMGz+S6htvYYZKtfQfbhhaiGpURgKU1W35dHHf2Y3M74AKh8v4Y8U?=
 =?us-ascii?Q?4NSg7LkmdtOQlrQjScfn4fp+gZ7hEXy7WA62AGLD0nmkp08nbpZKNAGF6RY3?=
 =?us-ascii?Q?aMcA5QWt/8eMTcEkS3cCjyJehbWM+IRz+3Gqlp+wSt5AYjPu5yj6oGRYJg0N?=
 =?us-ascii?Q?gVekEggsUdcegb7rjoOtQWXTU36rsztWfzfzHeQRvzoFapZHFHXqDI1I6DmN?=
 =?us-ascii?Q?JXZUpH53Re6I7Hc+o+B7f22xi0i4b3g5Zp429sqKZ6cSAwA/pPASx6fj0mkN?=
 =?us-ascii?Q?PBpPkf1JCcS4TKk4q7qU4DT8Ide9/boZ+QhQcAl1GCXXRJ86qXEAuIJaNOLE?=
 =?us-ascii?Q?L83mZtbha3rTCPhCTaQlIAy50coYCvuODABIIi53+oTy+V8GWxgJQY1f1ZM4?=
 =?us-ascii?Q?R2aZmxwZs4sj7TXMf3He4EZg9ZqrXFGu270Giio9P4U9cC5ezVy4kBTDHQfr?=
 =?us-ascii?Q?Euq4w2nYT8aPIKiZxNznY5/vkEZFVDYAvggmXn3Ehccuykpg8QTfpnq+zN1b?=
 =?us-ascii?Q?4r5bRQY8zshX6keXcyUtdqkmig7Np/6xN7MlGlxncKpRPLyKMNEhlnbJTOD2?=
 =?us-ascii?Q?5nGzV/OQ1881rcR6GyGwZ7UQ6l6VwjQbRvj8IpZP53Kuc8E83WQ2NghhCOH3?=
 =?us-ascii?Q?ImHu58kdf+7nFXFTwxrkV7DkCGaD5tWBePbQDiBIivqjoPHXzH7kpngPNHIP?=
 =?us-ascii?Q?kvD1F3yfxzZeF7n13URa0E1PRkV8kSLTHK27AphjEavkvUg+KXFMvwVNXwbr?=
 =?us-ascii?Q?+uMp2HE4vG6q3OYPFEq0qZdO0dzaaZb3dk7hWxbleFxqCQRDmK4AXOOtBeBk?=
 =?us-ascii?Q?Y3yoCdMAAs7AVqZUDpWsqd8XCPiqwk0zfbKPxTDTMtyHG+bkR0vt5hXnIdoP?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6167d1a-fd86-4a8c-f85c-08db9dd7c4ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:37:05.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EPe/pNz5kEP38tYTieTHp4NMo9JGXiXvxewTmUetmI09ZxHjY27nmNdz/z7pijZaYg7hd20SzsLpWygautwpTUPQpQC2LSk8V0ixzOjiJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Lendacky wrote:
> On 8/14/23 02:43, Dan Williams wrote:
> > In preparation for using the TSM key facility to convey attestation blobs
> > to userspace, add an argument to flag whether @arg is a user buffer or a
> > kernel buffer.
> > 
> > While TSM keys is meant to replace existing confidenital computing
> 
> s/confidenital/confidential/
> 
> > ioctl() implementations for attestation report retrieval the old ioctl()
> > path needs to stick around for a deprecation period.
> > 
> > No behavior change intended, just introduce the copy wrappers and @type
> > argument.
> > 
> > Note that these wrappers are similar to copy_{to,from}_sockptr(). If
> > this approach moves forward that concept is something that can be
> > generalized into a helper with a generic name.
> > 
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/virt/coco/sev-guest/sev-guest.c |   48 ++++++++++++++++++++++++-------
> >   1 file changed, 37 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> > index 97dbe715e96a..f48c4764a7a2 100644
> > --- a/drivers/virt/coco/sev-guest/sev-guest.c
> > +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> > @@ -470,7 +470,32 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
> >   	return 0;
> >   }
> >   
> > -static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> > +enum snp_arg_type {
> > +	SNP_UARG,
> > +	SNP_KARG,
> > +};
> > +
> > +static unsigned long copy_from(void *to, unsigned long from, unsigned long n,
> > +			       enum snp_arg_type type)
> > +{
> > +	if (type == SNP_UARG)
> > +		return copy_from_user(to, (void __user *)from, n);
> 
> I'm a fan of blank lines to make reading functions easier. A blank line 
> here and below after the memcpy() would be nice.
> 
> Ditto in the copy_to() function.
> 
> > +	memcpy(to, (void *)from, n);
> > +	return 0;
> > +}
> > +
> > +static unsigned long copy_to(unsigned long to, const void *from,
> > +			     unsigned long n, enum snp_arg_type type)
> > +{
> > +	if (type == SNP_UARG)
> > +		return copy_to_user((void __user *)to, from, n);
> > +	memcpy((void *)to, from, n);
> > +	return 0;
> > +}
> > +
> > +static int get_report(struct snp_guest_dev *snp_dev,
> > +		      struct snp_guest_request_ioctl *arg,
> > +		      enum snp_arg_type type)
> 
> You can go out to 100 characters now, so you can put "struct .. *arg" on 
> the top line and just put the enum on a new line.
> 
> >   {
> >   	struct snp_guest_crypto *crypto = snp_dev->crypto;
> >   	struct snp_report_resp *resp;
> > @@ -482,7 +507,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
> >   	if (!arg->req_data || !arg->resp_data)
> >   		return -EINVAL;
> >   
> > -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> > +	if (copy_from(&req, arg->req_data, sizeof(req), type))
> >   		return -EFAULT;
> >   
> >   	/*
> > @@ -501,7 +526,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
> >   	if (rc)
> >   		goto e_free;
> >   
> > -	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> > +	if (copy_to(arg->resp_data, resp, sizeof(*resp), type))
> >   		rc = -EFAULT;
> >   
> >   e_free:
> > @@ -550,7 +575,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
> >   	return rc;
> >   }
> >   
> > -static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> > +static int get_ext_report(struct snp_guest_dev *snp_dev,
> > +			  struct snp_guest_request_ioctl *arg,
> > +			  enum snp_arg_type type)
> 
> Ditto here on the 100 characters.
> 
> >   {
> >   	struct snp_guest_crypto *crypto = snp_dev->crypto;
> >   	struct snp_ext_report_req req;
> > @@ -562,7 +589,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
> >   	if (!arg->req_data || !arg->resp_data)
> >   		return -EINVAL;
> >   
> > -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> > +	if (copy_from(&req, arg->req_data, sizeof(req), type))
> >   		return -EFAULT;
> >   
> >   	/* userspace does not want certificate data */
> > @@ -611,14 +638,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
> >   	if (ret)
> >   		goto e_free;
> >   
> > -	if (npages &&
> > -	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> > -			 req.certs_len)) {
> > +	if (npages && copy_to(req.certs_address, snp_dev->certs_data,
> > +			      req.certs_len, type)) {
> 
> This can also be a single line now.

So the kernel's .clang-format template still enforces the 80 column
limit. I am ok to bump that to 100 temporarily for my edits to this
file, but in general I tend to just let clang-format do its thing. One
less thing to worry about.
