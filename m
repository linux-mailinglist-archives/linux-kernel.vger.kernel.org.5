Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2217479F0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjIMSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:00:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5919AF;
        Wed, 13 Sep 2023 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628003; x=1726164003;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VSu8qer4+Zfa1377Vtg0ju7FDckidDT3XqYYs+8/6ZA=;
  b=hP5lOvxDDWtdLLDd/Rjsaxgf0vyBtIMzQ3ZzbVlRQ+pebXGo1cPkNGp2
   mgxPdzIFPCbsjJKDzp9cR1eDsdc5bTDaAbaKBjk13HJ88TZj+iO0w3v6g
   038XWLjmubeCBFmatvZJIiGtkVMaeBDRBFj+9wKFAmg6f3dVDiq5Nw3Cn
   oj/4X5ilkha41ZK2BA8Q4i5idKd9a261MiY1H88FGNM8LkmrT9OAR3uO6
   1iERqJZkVHJyjc+uyt+rZvAxNCbx1xQ5OK31igWnmfqbIDaSHIhtSfvD/
   Z5rQUde91Cn+rbXntCQbfTLaOakT8GCme2A5QcYdBcsEMUJok/k7KkFri
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378656462"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378656462"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="834408963"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="834408963"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 11:00:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:00:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 11:00:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 11:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXFkbmhW7Q7iFUb9sfwtCos1LdahhahU+nFipyWYmkxGvnLUZxyvHjmnEMw8N9mBjab2/IEaNRZ13Sjw8v39m6STPKWl8sEXHOnlqXS2jjJXuISj2tve9EdeRtfQWAvwYUTFJZvA6ZjpE+bsrkXsFVwDV+eWCsym7aXpR/KODwU4TfftMauACCHdiGCGNr3YeOwnIfTNT9L6Ww02s3vI6S66Z/24iAlRhF56p6Rg+q51uGWN+1uaiMxDd8CGahu2Mj8oZlAEy3nGd6wf7iGTm+DatkugewEaDWFQHBxKzyVfzDmmegjcEpPHQoHxZQtb3w5dS+Uj0mODTUo2Y0dY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykRI8V2iEV85fL/Hq1MPPiEIuOycnxMSFB9y/7D1Rpc=;
 b=CpKpKsMr1maCgRuV5B0PUYcjALQTK3Nms4rPC9oyimD8Z2h5ZoLlpDp6Gy/ccmJhrXUYhT2fJhszwDEFhlY/j6RRfMSAEeIngysDJMz1gYBb8SCI5L+JpNjn8Zu35/NOEH70hOudSbrTWNmHjpzwLjz2OxCoU5UZwmJWwviIWEZMPNFbWJkpiU4v6Z5oyEmm0kzWZm47TFACBf1cvfaVYoHBmwdiF0mN1eRB7GGyewtABJvo3qU9g4jha2NWFE+r6Q48mROKt7raV0LyW0qMOAXq8+rpzQbXnutiqEhejyC/QdrrKD+1Jym5hceJXX8OTD60iGAdowV+1P2DudG1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 17:59:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 17:59:59 +0000
Date:   Wed, 13 Sep 2023 10:59:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <6501f89c9ef86_12747294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
 <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
 <20230912174904.00005fed@Huawei.com>
 <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
 <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
 <6501f1c29a2c4_31df46294ec@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6501f1c29a2c4_31df46294ec@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a54103-ef73-46c9-1d31-08dbb4833f12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IP/7PC44sak3JAuphR55eKUCTyOzOlsRo9z2LIsMr86acGTLYaYD7qYVbBJRX+f711dAVHf2I5VhP4ogkNRJJBW6MCrUrk2hFysjmft0QFqOwd4RBfWdqzkz7Ya3mVoZDXdtho+fqdzAv8+6eHM+NFyFHUHZi21kSDqPwKiyGVNiLD3gjBsHdjBgFijeBLGz98KReV/S4ICqH46gut9fCxBHzqaDsiQ8vzlc9I2BKYsr8LY52/5c7J5TLYQc/90JhWIB9SCPnI16C7O9f9ZB62vDic25an0k73y8nuSuLVB8obd4VhONxfv9i4YzJ9OaljXBU8e0uBeHukLmrQ9og25dTTc0ghtTdjTYYrTPzeD2xYFWqYU+F0S0GLcUIqZ2xTPpl5HvAkSaWCQt38w2bBndLLdYmtp7TgYCB3paJz+e8g2fVZheFo4ZvorpTHmJUTOTJm5V1l2zos+gaK1Ejlo92mDhL3vQchsc5lOZpo5QtsTgr60DN+iBv+e9VhaPgTr6Yzt8Btqsr/bvbfbOvrOEMYkTTCfE65O9mw3o+Gp4PlSGEfX+j6XEBvn9Nwk5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(8936002)(8676002)(26005)(4326008)(5660300002)(83380400001)(9686003)(6512007)(6486002)(41300700001)(6506007)(66946007)(54906003)(66556008)(110136005)(6666004)(82960400001)(38100700002)(316002)(66476007)(86362001)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvRIxWVff4yx0x2sf5uqRpb2HkgV8T4TUBnlUm3Vemv5JEsrKUglCvIVuP7n?=
 =?us-ascii?Q?xxDjwjEWAqugELATI1oUj8eXxyt2sT3Yw9hYzfMXJRMWf9YLs7Sk8ck/wRew?=
 =?us-ascii?Q?ZtV/XDWL1ok+OQFnwyfMPawX0iKOrIMRRmteKVhCceEqap9AK9AIMkPxVNcA?=
 =?us-ascii?Q?yDhWdMtBMh3ajW72zBvk4Y6CeeDbJ3hcehbHiq49zr+ysKemK1dVkSt4nxVS?=
 =?us-ascii?Q?wfCE5pEE+lr53yddMn3FglPvM/J9MQ9BOCeCoHR1uPP1l20Di0b7jUE58gkj?=
 =?us-ascii?Q?xxWw8r7C0YgRpMcqGkgy6E0l3kK6Q20YFgVjevIOCpM1Xik7VUQXai/NM+Wn?=
 =?us-ascii?Q?/rVf/KjfAu3g5q7YtPzRh4UFqUtmM0Tkwng83ggb/DBL/vtoyKl516Chogg/?=
 =?us-ascii?Q?29VV5gP8z3mEx+6yVQN9XDB50sr3t31hkXrDgcWu0Qp3FRKw/+L7Sm7ztxC8?=
 =?us-ascii?Q?42q9ClA4YH6iMAunr49hhkZuBa6EFhrLWhIqLmZuZMUXmGGCx+vC5zQB6eNe?=
 =?us-ascii?Q?uS0ZssiKPPUi8YRLxQJkUVsD/3lQHn4LU6TnEpWvmZRkAE2Srthm3STrYTnE?=
 =?us-ascii?Q?QNEkcALh9TefSYSPfhk+m4JIGww1LqYBA3RAgQxOab8fvvKDqM/pmB8o7K+l?=
 =?us-ascii?Q?UhVLRDd4cV6b06LFBXHuch51xv1J/RnC1ixV87sJS+dheoNO92L5gaHhT/Ty?=
 =?us-ascii?Q?9tF0XPq19yU1yT7Y5AXOAPG5Z9G1r5OFb+VoRP/mr1+EuC/xDqf6iHGaIpKh?=
 =?us-ascii?Q?IZ33cR3TMIuAup/Y79Y3I/QQUPq1dOS0kvwgzmK5GSzC0N576lfZ04E9o6d6?=
 =?us-ascii?Q?LZnmEgf016+Afql7a6VBNzMdpe9dC+HmAQwKrY06ucABzGI/4O/yJACKrSiI?=
 =?us-ascii?Q?0F9aUD3fNhQHF5FZb6lMdYSxMki87vSwqsbJKb2o5OOi53BJLWnDkyyu7H+u?=
 =?us-ascii?Q?iFNdQ/AnXPVBXNcmcoYprW27MwcI9JsLN9KiOQsBIhYPA1pWyBKUQnu5/1nS?=
 =?us-ascii?Q?1W/f/WfMTuODNL0jy9ilcCzxcCrqp7vIyXeXlmHBCYoLHIvIWmOjnUFASoST?=
 =?us-ascii?Q?Y2xAxG5zcb3/EuJCuWg6QNOywjpvHgw7ed2bMXngYbeV8Eq0MOS71hjAhb9t?=
 =?us-ascii?Q?NNyjc2Xgjhoa+Xtm8gyVjB41E6c577yVA13FSUdIRhJo+5f4rkCduqIy8iCK?=
 =?us-ascii?Q?tGripTCXGjPbShH89lcLXjD+i4brPJPQaFDmYRRWLp8RgauXaB788ynv693S?=
 =?us-ascii?Q?Py/O5NqUf3OZ6YJbCLjh5fRlVJXDBGny3hkructubKHTsCjWmoxXMsrY3qM2?=
 =?us-ascii?Q?PB88enaH+SJ8trUOWtHoEZebWR3Kp+sex1f6QDkqnIC163DmY8nm1M96JtCP?=
 =?us-ascii?Q?4Gw7/M0ymPP9RyyYIlFxoPFeN//obYTOgNY63FaE3XJ6+ZNwcdidFefSeyq7?=
 =?us-ascii?Q?6xjaGxMhfm2reAzCqTrFZW+ig/mDhmjfO27TELr+zgziUWflaffmiaJysH2F?=
 =?us-ascii?Q?4JQ8TmgI0J5BUGY7LY99zz94lx7CVuZlUHtAOM3x5xtzAhui0WraWLOpLg7k?=
 =?us-ascii?Q?opwcEykekXUM93Hkjqo+bbGkEusOyuNiGMQClA7rZJmO3hSGREDDuSQHjnCN?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a54103-ef73-46c9-1d31-08dbb4833f12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:59:59.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyOxmPndobwyegES2VjdC5McSfEo7naVYFzJLiYs6FOLx7hTH2RG3qeY9190Xi0hrNb6JgU/KPdL03o35jJjTbZCPlbYIMT/mlFo9cerDPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
[..]
> > 
> > Given that one of the expected DCD use cases is to provide just in time
> > memory for specific jobs the "first-available" search for free capacity
> > in a Sparse DAX Region collides with the need to keep allocations
> > bounded by tag.
> 
> How does it collide?
> 
> My attempt here is to leave dax devices 'unlabeled'.  As such they will use
> space on a 'first-available' search regardless of extent labels.
> 
> Effectively I have defined 'no label' as being 'any label'.  I apologize
> for this detail being implicit and not explicit.
> 
> My envisioned path would be that older daxctl would continue to work like
> this because the kernel would not restrict unlabeled dax device creation.
> 
> Newer daxctl could use dax device labels to control the extents used.  But
> only when dax device labeling is introduced in a future kernel.  Use of a
> newer daxctl on an older DCD kernel could continue to work sans label.
> 
> In this way I envisioned a path where the policy is completely dictated by
> user space restricted only by the software available.

Tags are a core concept in DCD. "Allocate by tag" does not feel like
something that can come later at least in terms of when the DCD ABI is
ready for upstream. So, yes, it can remain out of this patchset, but the
upstream merge of all of DCD would be gated on that facility arriving.

> > I agree with Jonathan that unless and until the allocation scheme is
> > updated to be tag aware then there is no reason for allocate by tag to
> > exist in the interface.
> 
> I will agree that it was perhaps premature to introduce labels on the
> extents.  However, I did so to give tags a space to be informationally
> surfaced.
> 
> IMO we must have a plan forward or wait until that plan is fully formed
> and implemented.  The size of this set is rather large.  Therefore, I was
> hoping that a plan would be enough to move forward.

Leave it out for now to focus on the core mechanisms and then we can
circle back to it.

> > That said, the next question, "is DCD enabling considered a toy until
> > the ability to allocate by tag is present?" I think yes, to the point
> > where old daxctl binaries should be made fail to create device instances
> > by forcing a tag to be selected at allocation time for Sparse DAX
> > Regions.
> 
> Interesting.  I was not considering allocate by label to be a requirement
> but rather an enhancement.  Labels IMO are a further refinement of the
> memory space allocation.  I can see a very valid use case (not toy use
> case) where all the DCD memory allocated to a node is dedicated to a
> singular job and is done without tags or even ignoring tags.  Many HPC
> sites run with singular jobs per host.

Is HPC going to use DCD? My impression is that HPC is statically
provisioned per node and that DCD is more targeted at Cloud use cases
where dynamic provisioning is common.

> > The last question is whether *writable* tags are needed to allow for
> > repurposing memory allocated to a host without needing to round trip it
> > through the FM to get it re-tagged. While that is something the host and
> > orchestrator can figure out on their own, it looks like a nice to have
> > until the above questions are answered.
> 
> Needed?  No.  Of course not.  As you said the orchestrator software can
> keep iterating with the FM until it gets what it wants.  It was you who
> had the idea of a writable labels and I agreed.

Yeah, it was an idea for how to solve the problem of repurposing tag
without needing to round trip with the FM.

> "Seemed like a good idea at the time..."  ;-)
> 
> As I have reviewed and rewritten this message I worry that writable labels
> are a bad idea.  Interleaving will most likely depend on grouping extent
> tags into the CXL/DAX extent.  With this in mind adjusting extents is
> potentially going to require an FM interaction to get things set up
> anyway.
> 
> 	[Again re-reading my message I thought of another issue.  What
> 	happens if the user decides to change the label on an extent after
> 	some dax device with the old label?  That seems like an additional
> 	complication which is best left out by not allowing extent labels
> 	to be writable.]

At least for this point extents can not be relabeled while allocated to
an instance.

[..]
> My current view is:
> 	1) No.  Current dax devices can be defined as 'no label'
> 	2) I'm not sure.  I can see both ways having benefits.
> 	3) No I think the ROI is not worth it.
> 	4) The use of 'any extent label' in #2 means that available size
> 	   retains it's meaning for no label dax devices.  Labeled dax
> 	   devices would require a future enhancement to size information.

If the ABI is going to change in the future I don't want every debug
session to start with "which version of daxctl were you using", or "do
your scripts comprehend Sparse DAX Regions?". This stance is motivated
by having seen the problems that the current ABI causes for people that want
to do things like mitigate the "noisy neighbor" phenomenon in memory
side caches. The allocation ABI is too simple and DCD seems to need
more.

The kernel enforced requirement for Sparse DAX Region aware tooling just
makes it easier on us to maintain. If it means waiting until we ahve
agreement on the allocation ABI I think that's a simple release valve.

The fundamental mechanisms can be reviewed in the meantime.
