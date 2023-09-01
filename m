Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496B79023B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350646AbjIASrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjIASrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:47:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC11BF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693594056; x=1725130056;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XTcuvcF+FMwSv3DCYZBkgys6Rp+I+HQRvl3PUqGZrUA=;
  b=O/aDx7bgWeKlUl5xiN5EcMwPycSWid8yY0t7tmLbkycvHzNddQym5fbA
   Jbcxx7zQKGFBhuwPqTfo8H5Lz+tI5qs7HWud0I6e189PjaN57pndIkUiq
   KOhKD88oZCAzDyRwe1GCcy9ayTs5G4N2d3oWGevxqMHQgOPnS0IZr7vWU
   Y6uyjr4ify1wgN3BwaaM9Jdhnkd/ddx6+HVra8+y9HToj8HMh30EkR8l1
   MWVq+uTWtT9R/i+FwU5XVVjG/na4ARCQfCy+vj6/irCPlyvPofZ10HEpU
   ZwIBIQ/3DA36yGa7vq/+w4lU7+i0y5wV3WzmzLZJ78ZbNE9Nv7F6Wsx+s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373679608"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="373679608"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 11:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689852369"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="689852369"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 11:47:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 11:47:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 11:47:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 11:47:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 11:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6CzV/aPW7SHGK2UX/QtWplB+HqFpSaZM1IIvGY/I0RiJgbTffAzSIOeU1iA5poNg757u93+vUbh7mYaC4Cx7hmoCCfnDz9uCF/9Dj8ReGohspkU3I9234+KURtD1gyzReU99BME9Lz7lFiFQROYnusawSE3bGGp2kY837lJCX3JtP+gp44tk/FmL1JwDP9ZwLXe91/iwlb76aZBHGYttitKdzqyTYGy8D+yGb5qinIeDAzg3U46jUQ7yKl90LIFDaOIqFGQw9SOIsN2Ci+xi1n2RJypZt58lwhbX6uEpnn7yYhnnoWWWj5Zf5OLciRJd300LNRyCn5MIl36XqxBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8C3CzPVbKPPWimtyVVMKSmNCRxBITSlAfuzeJkAJAg=;
 b=WXLqC4Bob7ufErPawuXjw5iIYd4HXEJxuuwzWzlgsArBZ9uG1D5SvZgAKzKyGVJRzVXZ16ewBcRrKUnwjSNC3CySYZlL8icbKDg/QA3BJ+cpOKz2NeY6rviht2X7RJCGcGURo5QQxn3k4Cai3uxumRWPR2P7AB6LI/TerXF6RKnD58GRk2AOmHdg7G3tiXBAcCghd6B+0v0XenetQKYWQgSWxeyXkXNmyUVNnehDcZiCGcpHESqmXXx9g5zdE5imfz1EeEMLcMEur9OM0rQq7/UC4IrqJQtMDJn5p4HRgPYf3lDje+HCEt09gSy6Muh76MircGMl8NGKxxumykCQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6254.namprd11.prod.outlook.com (2603:10b6:208:3c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:47:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 18:47:23 +0000
Date:   Fri, 1 Sep 2023 11:47:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
CC:     <linux-coco@lists.linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <64f231b8ddde2_4c1f32941f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHYNhiewBZ8Z_yF2F+ogkv_1UV8=Gu0KVDdTJN4iQKyNMg@mail.gmail.com>
 <64f11081985e_31c2db29440@dwillia2-xfh.jf.intel.com.notmuch>
 <87cyz14vko.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cyz14vko.ffs@tglx>
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf788ab-63aa-4d2f-9eb0-08dbab1be15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP69U0Z9fJTo+/00cNd6U8H90Tu0k/tgH8uT1KChLHhGf/D2j+HpB0WEpKWkD1jOyCkzr9FKvcciQE+ysHbE5ngAYxvYZBve5dIZM9lEk6Rex9Ee6tbw3wj5jjX+C6VSEpFHx663e5abgPV6x0KsX64GFa4l30RhwoxWgEX9WYXl8eeT9BQtnnBISXI/hYyE+aTD0+xjiX/njL0ZooLSusNXpQ5vcrn5TS99B0+NiBT2rN515dGk0d+BStLqTvr9uiEJKAWsApmSs5FY/hE0eybJT3V8+QSGQ7gGDvsJwJwmTtJlXRrEhxntDjp33nTA4YjNVF1LmYPX/GCuXP/+fDGvxThyieqcfQlOrTa3PkFjYpnldoUREFqlMptk01sfJhJn+XPxFLjLC3q7CJaXJ+hERdAm0Jjlngr011xj2NUfxb6vf6XamfyLYZqg+ToX+NI5yobMyMhFS2nyn9RZhjWvQYekCzU7Rnw/EEPfQDisgLUVlaZ10kEV/BFeXsuOWCTDwrfePAIAaRC0X9d2tKYLe9eG+5ew87mXjdJKCQ52BkxGAVv4wJKfz3FqaknR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(1800799009)(186009)(451199024)(66946007)(6512007)(6506007)(9686003)(6486002)(82960400001)(38100700002)(86362001)(2906002)(26005)(83380400001)(478600001)(110136005)(54906003)(8936002)(66556008)(66476007)(8676002)(4326008)(5660300002)(7416002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mghCu+z/ECAjerG51rkif64leFEyfTbSE/z+LBP1i6OCpwVnXoitlccYB4a9?=
 =?us-ascii?Q?ts5k+aDhdsGf0d0kFzBb7of/kK4y0M3MG+fcbdSGpoNqbsELwz7aOpwAGxzr?=
 =?us-ascii?Q?WOVsBJC5/LEQ7tBahH7WBmOK0SYTegY/AS2xLMdEtE2Ao55USHtuyhqEqNeN?=
 =?us-ascii?Q?yHFBY+wUK966qsfDIdRlfjyT1vNZ0pw6Y+Phfj55b49rhhxZ/3Gpg/AZoFHr?=
 =?us-ascii?Q?eOhNTWAonK1ojSPntZeGe1K2jR6Vtt5p2/FjF2LbGSAM/acI1uHX2HjVfXDw?=
 =?us-ascii?Q?moNyobwnFZr/Hug+mY29QVIobSiwdUJOInSx1INnBMoITIGkuLKs/DGchxJQ?=
 =?us-ascii?Q?TqUj71tkhtuovox9bXN7cWsHb72SozS/0IH6lK0L503VCKPYgV+JaR+9PdkS?=
 =?us-ascii?Q?9PcdqZG9bR68ejnQO81Wc8o+o25Ib7n7A1Dql5pwLpD401cBnUKjzq/k5+Wa?=
 =?us-ascii?Q?0eb/bc8d5YQiXZJQmYECJqWh60vVGSWLiN8+YwbYNhUJoSTs5iisq1GRg5Ae?=
 =?us-ascii?Q?fQfRCEHz3gQtu/H9tARQM9hgzDzHuXofwqKWCDXpuo4LUNMaifSdgRtoALej?=
 =?us-ascii?Q?256jxYt1zxolIhBh/JDem+fEJos2mrjuf2SooWCj6BVLnJPU57wvwUjxB4eN?=
 =?us-ascii?Q?TFN+O02nFFl0nNHDdVPnidPS5mxdf/1S2aOjOkecOEKll70CG+2cx8gV7qYP?=
 =?us-ascii?Q?hYUu50yZVJ7pidDu8KrI/AIXju6//RjOwwbbpfOejsEgniqLwARLkT9JHHDt?=
 =?us-ascii?Q?ffHUVns6Aca+UD668LOM4B4mGwZ0KqYXb5LfsB5QvlyuXCqW6g1OMfTnwZ/g?=
 =?us-ascii?Q?L3Y70l8HK5t+vYbU1WI948vHrVcdQVBS+ndYd/1hVcyvzlxvpSSv+iht5Uiq?=
 =?us-ascii?Q?zRBl5802inWwuqwAalh+lNrCr8PaQiJIBggN1zpkAAR/CPZ1rx4oMl4Qo3Pu?=
 =?us-ascii?Q?ewPuAyHjWaV8LzsKEe9I0/fufBNup5P+MPpZgPuGeXjQ816bhFGKVZ1NwwZg?=
 =?us-ascii?Q?/79VsEICgLqmbcnulbN0MVXfJ3rmgnlOj9QDu71lmQ2tGRZFeM4ITXUPdiSY?=
 =?us-ascii?Q?Td9zSTKzLH+08PNUAtgR7hbIe5LZEX1x8/5G4ujq9BB1pliwtI3y3vydRleB?=
 =?us-ascii?Q?LeFowr4VvLVeDlAmLYS2hGWtNISkWHUgyIW5/CaPwa3gDj4FLxU7AfdktjHo?=
 =?us-ascii?Q?q6mKrYj4wX/RX9R/nr1c77JXOZeE1bxGH3gMqrtUKI9Hpt3B9jzfWljuBemI?=
 =?us-ascii?Q?zycYuRiOkQUc0/cj6t5I+CAmilEJ1gAaQZRlOLi/fcNoLlQx4rS47ZKyxnam?=
 =?us-ascii?Q?gZQPAJg3jDUN9lOBS9jRyBXv0UZPDBicbVRjYN8L8t4o40yg7NyMFWA+Iszz?=
 =?us-ascii?Q?4hRiqRqhdOX9ztrl+kEQqep6Bld8phMSSeEbeVklZMkp6wbi8qcZ4Q/IBSqn?=
 =?us-ascii?Q?q3utgTRROfY6lfS2Phy0rlQD3KvRBBN5ddV9eFYPS9F1UFbF7rVlN2+LOCl9?=
 =?us-ascii?Q?ptZIDatVCO+kjGdwif3KS4mXfay/IMvZeVoQLulfyKsGkE0zLPzclmafxijl?=
 =?us-ascii?Q?S6e7yE3+bXdcaoM6SAsPMuj+itPmcsDoGz3zewzCG3sR0QXRsQzNQ00/U4Ls?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf788ab-63aa-4d2f-9eb0-08dbab1be15c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:47:23.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAZceBOeurZ0tYG8/Ni83aBIsdZxiFC/zPzPgrfaqlGD5S5jHI5nT2hI1WfH+0u3CZTTfu8PEc76PEPN95GoHkxpLA6aCwC6T/B3dXdl4Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6254
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

Thomas Gleixner wrote:
> On Thu, Aug 31 2023 at 15:13, Dan Williams wrote:
> > Dionna Amalie Glaze wrote:
> >> This is clean and approachable. Thanks for your implementation.
> >> 
> >> > +static int try_advance_write_generation(struct tsm_report *report)
> >> > +{
> >> > +       lockdep_assert_held_write(&tsm_rwsem);
> >> > +
> >> > +       /*
> >> > +        * malicious or broken userspace is attempting to wrap read_generation,
> >> > +        * stop accepting updates until current report configuration is read.
> >> > +        */
> >> > +       if (report->write_generation == report->read_generation - 1)
> >> > +               return -EBUSY;
> >> > +       report->write_generation++;
> >> > +       return 0;
> >> > +}
> >> > +
> >> 
> >> This took me a while to wrap my head around.
> >> The property we want is that when we read outblob, it is the result of
> >> the attribute changes since the last read. If we write to an attribute
> >> 2^64 times, we could get write_generation to wrap around to equal
> >> read_generation without actually reading outblob. So we could end up
> >> given a badly cached result when we read outblob? Is that what this is
> >> preventing?
> >
> > Correct. The criticism of kernfs based interfaces like sysfs and
> > configfs is that there is no facility to atomically modify a set of
> > attributes at once. The expectated mitigation is simply that userspace
> > is well behaved. For example, 2 invocations of fdisk can confuse each
> > other, so userspace is expected to run them serially and the kernel
> > otherwise lets userspace do silly things.
> >
> > If a tool has any concern that it has exclusive ownership of the
> > interface this 'generation' attribute allows for a flow like:
> >
> > gen=$(cat $report/generation)
> > dd if=userdata > $report/inblob
> > cat $report/outblob > report
> > gen2=$(cat $report/generation)
> >
> > ...and if $gen2 is not $((gen + 1)) then tooling can detect that the
> > "userspace is well behaved" expectation was violated.
> >
> > Now configs is slightly better in this regard because objects can be
> > atomically created. So if 2 threads happen to pick the same name for the
> > report object then 'mkdir' will only succeed for one while the other
> > gets an EEXIST error. So for containers each can get their own
> > submission interface without worrying about other containers.
> >
> >> I think I would word this to say,
> >> 
> >> "Malicious or broken userspace has written enough times for
> >> read_generation == write_generation by modular arithmetic without an
> >> interim read. Stop accepting updates until the current report
> >> configuration is read."
> >
> > That works for me.
> 
> That's a pretty theoretical problem. Under the assumption that one
> syscall takes 50ns the wraparound on a 64bit variable will take ~29247
> years to complete.
> 
> I think the important point is that the generation check there ensures
> that the expected sequence takes place and can't be overwritten by
> accident or malice, no?

Exactly. The "attack" / "bug" is hard to carry out, so this is more for
theoretical completeness than practical protection.
