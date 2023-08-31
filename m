Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3E78F54C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbjHaWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:13:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9425E5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693520009; x=1725056009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LKb4EGY8TJZ9lo7f3EZ8zVixKQodjWW0Esvwxk8QUYY=;
  b=EvYqpclg66HlKHH6ThZlXU9G6dEsMaOJnQsAJkL7lRhGLbg8tfRhFtN/
   FsdQrJnDU+whmnpla5K5s/sos99dT1Lk5BJZSUrwUh/QEP9AUCYE+A6Tm
   OUMP2ShKC7ZyF9HtM1b3NQ3DW3squLVl6JTgBiCvb/HrKowYATDDtrzD2
   LOyQO6cxliHPtYMyr1Zfe1as0nD+WfvicMmG+wGynqrgH4xjgHhUq8wGd
   4YxEh68SlVM9WjUzOeS7Zq6OTQFBIWIazazFX+hZM2M3vSDvaUhwdlIuX
   DhBsDNA7sPIEIzDQjIr3CuUoaAKAw4gSr7D9SRFSZBhbOaNwURWzN4NNX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361101073"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="361101073"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829883289"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="829883289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 15:13:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 15:13:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 15:13:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 15:13:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 15:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhXztd8G8NlLtmeTH2ACn20wZ7GIVo0mPj4GR5sOQdgsV2PLDvoBKLHcO+aRJF5uaHcZhN+OkIn0U8qRECX9O+X2miBHseMnyd05ZpuPFtob6yMz/Ma1OWiL8FpXwP2GThUPHi4VDnbgL35ee1riVeh1WbpOI1iiLT6Xau5H3Eh7YLyQeCPfhmkv5JXB2L2eZlahidaPAElWYJpZOcZ0Ie9ktNHxBjNfazz87AtYD8fvjkdxiKgWGFIuUv1h6ACYnxUNM+di3r8AzSZkvSzY763D3Em9/F20vunjYSTYY2437o+ZfX7RTy4m2yNFNSoUgug+t9HLZbHijdXo7CdwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcq3XkZmjLybJzXrrwLNslzkbp8RjwDvko6mlYcXcr4=;
 b=Nlk9lGpbtA4WoMwoKtD4mqmKfKArWJpA77eL7h7PhMPFOxAfiiJfFD81MGqUX9P3TKK2J6t6OsoGbdg+ujTtwazyuljJHxjnF0tSSKpYn6ESEfSQ9oX9J+cvqv2VwqrymnUD0zXaeyQ8KFVj9AnjQTpxCVLFjljvlG/w1j+GNkjE8ZxqP2I0kAoiJwbfNFfEsNXRJLATlsrLz92gE+1ugKsikodvsYh/xMmtX7jtPYxvjH7Hm2RAS1F4FGjTCYWteH+OK2tAU2mXSHa+N2cRZtas7ezU67hnY5+DwtPYl1oEYAeCgGALjBizllrkIx5+Khx6zSg2NqQ7Vb1C6eCZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 22:13:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 22:13:24 +0000
Date:   Thu, 31 Aug 2023 15:13:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <64f11081985e_31c2db29440@dwillia2-xfh.jf.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHYNhiewBZ8Z_yF2F+ogkv_1UV8=Gu0KVDdTJN4iQKyNMg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHYNhiewBZ8Z_yF2F+ogkv_1UV8=Gu0KVDdTJN4iQKyNMg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: e48a490b-8a0d-4cb1-e8df-08dbaa6f7e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBatX6PKqRU0irZjqv6mexv+DEoJyFiV5QiO/t8PEMPSg5RkgcCy949XFBJI54kSMot90ArkbKsMiMWpJwcWpo5/+vFBeEgmfVwntDFOLg8uty5FgETc2AzpW99j+GnPL0bpIK1gZhSNu97ZctlbRzIhCSRhTc+JTHe8yKQfkjItj1tAbvW824gGlNfCNJBxvMV1rimnq4daS9/ftZvJJ09XTFeqXYjWsynHGcJTWpRIjhWplNVlwyOHLZiIkR01fPMlz1XoVFyPn3WtK9LmkBZsKFS8yyAoKa8o0DZKMQS5INwpJoMCU20paORLyiHN6ZxDogiNqweARStpCy1sXjJD9BYIoK1tcO9WEM0W+ORsNntMktDAdWlRCTnAG/2uPROCzWspRPJ1xsNIKV44EnYPaS6mgQeD2EkRJf7gppryKF5meVQG+7Uy+5EtZFEa4Dci4mRehy8dUw/Xe/fG1PeMWWTd/UwrjKL4IqL7f0uetxdpA1fXhBNhKkHZO/isSfKSePEAi8uL0sQfluDNVUN6rKa54hlgyLv0qCLfSvDvwu4YiOrpZQYjF86yUXal
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(478600001)(38100700002)(26005)(66946007)(110136005)(41300700001)(6666004)(83380400001)(9686003)(6512007)(66476007)(66556008)(54906003)(82960400001)(6506007)(6486002)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ML6dXmnWVlnzOsFVm4iDRbtcwD4wI6+Rzg398QtuBFpVM2BvD5ysMVxqSkGR?=
 =?us-ascii?Q?E1ln9yqmDzsXftUlcaxkDXoC7qPXUh6Q675/DUzIPc6kWCu0knK8lcc++1FZ?=
 =?us-ascii?Q?ZWjcjtT6ITHYgNxjDRZmIWrAXWpl6QTGw2yC1piUvlq9zABV4LSHLrTRyAAa?=
 =?us-ascii?Q?wr8qv5SBE8cglqip1PacZNlgD0tGFX15A5/dq6C9B/8KiGU20tGrmlv2MKaV?=
 =?us-ascii?Q?vG7EqrDOk0yBsvAVR7ra/27YPwI5EwZvMCMmfPHCPycOlDcn+2+wy0cr4om+?=
 =?us-ascii?Q?Gxh6EuWyDDiRG7/Uf+AwaoYaX3xqCAg5IbYOPktJYfbHF9Vg+swQZclPnyZu?=
 =?us-ascii?Q?nqnAlGQj+6AeYH6wfQDDc41mxPF6aCZyqdqHt+uiyVuqyar19t0jwAIs0AJr?=
 =?us-ascii?Q?yx29unEUBXmzynIgdeQT2WFzopmK5xs7Vd0tgBK9KQFvL1purIS947lXmJfV?=
 =?us-ascii?Q?tkplfPgb6euCcoG1q8bU6WnVXZou3WKlcnwiFSYe4JfVTodPusM+lerKqqPN?=
 =?us-ascii?Q?tOU6btw2wOIugs5qunQt/FcW5Fu6bdSjz/PCYmJEAYtKbpoctPLmPsUL6lV+?=
 =?us-ascii?Q?NlEAJ4rxhSFXQ7NX83i4F1IpRGucHWV9LVEqTROquy07RV6yaEowrqJN/6oy?=
 =?us-ascii?Q?7A+xCGHkryIMaKmKBSlc0UCg99nmUY/YpjrswHkYL+C2wv0ppXGGqYxaVAT5?=
 =?us-ascii?Q?NaUNO/eHgRuBy3iy0Fa5goTO9kat99+HqCN23AK91SRbyr5sQhWDLvE5RPm2?=
 =?us-ascii?Q?9ERpw5lHfBMW8sF0M1ddhM74yZIzy5bEiugeig2WIvP3zuaGjzG/ktI4JOQd?=
 =?us-ascii?Q?pME2SUK7zhSnGZOwAvTi59Gt+xeNJbLDdLL7JoV+wmhE9JCqqP99tHPJHabM?=
 =?us-ascii?Q?io6vMiOV8eCzf7K/ys/kuO/sKl748DPQ5jClXtk4D/ZQZsbZPyl1ZTYJERtB?=
 =?us-ascii?Q?c9dJwgUDzKAmglQCb1a4mVMz1MV+srTIPGtq9R2DNsaDfdkgTvzegOXz12bW?=
 =?us-ascii?Q?OCflpkOvWAKy6j/+fow9NYTwNKr8ezf8TJlyRILFT95kaljuzskmZurLA0Bs?=
 =?us-ascii?Q?V7egM7sqJJpnxQEfSZ8sd+fSdQei0xuMxldUVYaONbPpPojMsQChLXmZFf8k?=
 =?us-ascii?Q?HBJnK/sdU7UNUper6aGXiQecSLz2UDaLkDvtl7dNJdmMXEFnsVdCh3vajdSq?=
 =?us-ascii?Q?HSZop4ndXAsNRPLIenF8qZiH/xrDMVOHvCAJ2H6Q7pmGZE4s1ZIeSJxbhRjX?=
 =?us-ascii?Q?vvuJjHw47sdM5/0O4OsPURKOugXkSWQ6Q4j1BtvQXDRfsw5e4O0TviC+rCdX?=
 =?us-ascii?Q?i2FBy6psPse9JFjEYj7z3Qsdh+atEeu1Fdf4Bnh8pHLtq+SI2CTGkQsQ3NYv?=
 =?us-ascii?Q?jbPi4sEm2Qnyn1aauXmryfeKPp1ICd+PyprOfZjPD7WdxSzMWyo8C3dNh3U7?=
 =?us-ascii?Q?lm1xjCR6lgQT5NUIPGzTNIR0sef2spzH/Jxpe2kbCovvhIKiDnIciCDNc3o3?=
 =?us-ascii?Q?iebfKPS+mp1MKNDOgw+cmDctgwiFfDcA5ZL+IfO1sLBbMeMLN9l346fsxIFP?=
 =?us-ascii?Q?8iDmGd0eRwxP2I1orw3oYvv62HZ90Mbao9Th386qxxmn9wHuw+XQQwrMhiS6?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e48a490b-8a0d-4cb1-e8df-08dbaa6f7e96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 22:13:24.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVGuecMJwyDU7mkH+5KXdris5bAZ4Imzs55nrcRXo7rrYV2ubG2/2dh2puussiPMsViT+5AsG9NNnvr9Dxoo2hqUycYWFj4CronzzbkHzYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dionna Amalie Glaze wrote:
> This is clean and approachable. Thanks for your implementation.
> 
> > +static int try_advance_write_generation(struct tsm_report *report)
> > +{
> > +       lockdep_assert_held_write(&tsm_rwsem);
> > +
> > +       /*
> > +        * malicious or broken userspace is attempting to wrap read_generation,
> > +        * stop accepting updates until current report configuration is read.
> > +        */
> > +       if (report->write_generation == report->read_generation - 1)
> > +               return -EBUSY;
> > +       report->write_generation++;
> > +       return 0;
> > +}
> > +
> 
> This took me a while to wrap my head around.
> The property we want is that when we read outblob, it is the result of
> the attribute changes since the last read. If we write to an attribute
> 2^64 times, we could get write_generation to wrap around to equal
> read_generation without actually reading outblob. So we could end up
> given a badly cached result when we read outblob? Is that what this is
> preventing?

Correct. The criticism of kernfs based interfaces like sysfs and
configfs is that there is no facility to atomically modify a set of
attributes at once. The expectated mitigation is simply that userspace
is well behaved. For example, 2 invocations of fdisk can confuse each
other, so userspace is expected to run them serially and the kernel
otherwise lets userspace do silly things.

If a tool has any concern that it has exclusive ownership of the
interface this 'generation' attribute allows for a flow like:

gen=$(cat $report/generation)
dd if=userdata > $report/inblob
cat $report/outblob > report
gen2=$(cat $report/generation)

...and if $gen2 is not $((gen + 1)) then tooling can detect that the
"userspace is well behaved" expectation was violated.

Now configs is slightly better in this regard because objects can be
atomically created. So if 2 threads happen to pick the same name for the
report object then 'mkdir' will only succeed for one while the other
gets an EEXIST error. So for containers each can get their own
submission interface without worrying about other containers.

> I think I would word this to say,
> 
> "Malicious or broken userspace has written enough times for
> read_generation == write_generation by modular arithmetic without an
> interim read. Stop accepting updates until the current report
> configuration is read."

That works for me.

> I think that at least in the SEV-SNP case, we can double-check from
> userspace that the report has values that we expected to configure the
> get_report with, so this isn't really an issue. I'm not sure what the
> use is of configuration that doesn't lead to observable (and
> checkable) differences, but I suppose this check doesn't hurt.

Right, the tool can also just double check that all the
parameters are the expected value in the output report, but if you want
to trust the kernel output without necessarily trusting other tools to
not stomp on your config item instance then 'generation' helps.
