Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3EA77C134
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjHNUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjHNUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:01:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1A171A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692043276; x=1723579276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jks+wdnPM8RRWTUMo5Dbk2GN7sd1YYFcOhrFSQQaekU=;
  b=cePMR/1jSXNulf733s81vqLYAfXeiBsTBemLBe9dRDZXY5j73kvuSsmL
   47Z6XdnSJlw8egrLNFxFC3zmpJ/X+Wd8Vb5J7H8rkvn/V9makK3+uaxfp
   ROsqLOuvQzNwmFXzrGlr1us6S71BdIRabNn10J+JjdAPWw393OfwLALmr
   FmM4LXzqPNZDS2Cp5LeIcciauk7DGG0IwKhPsHQMikcMs/ilAvC/k0sVj
   0JfhNJzfqZGkRQ9qQGtF0Ue2V9pjrfBFV6KNOvBKnV6QWLQXygoVEFtep
   L+JrfqI46lS/jkqcneoHAVwqB7bLnmhw7PynAxnqMEceFkomrAOSs12/P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372122430"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="372122430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 13:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803567817"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803567817"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 13:01:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:01:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:01:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 13:01:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 13:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZUotrvBWvhH1sIS+XiKIUW0VHUFHl2RS1jYLcHrji50Uoc+lP0SPQ9jYq3e7iC1hUf5gOKJy/TfIJ1w/AhhMc5B2+z43n9cK40nmUT2OIWLO9oxhH9zgzXLaCC5TXblCLrh27T2m3SpnttSoaG+42G3I+Gzv+BCEsnlqC+6rB206j3sayktzWRO9wclhYYmss/R79NZdsNXQH956fIlwDLJ1YZGbLAbIqHzqoiZBh6HJvAg8/o86oNsstUsQakWX7D1aFZkm48/SRl0UFuR9SdrACd50sht2AWXMvAN5n2yBz6gBQfbP/cUGnbMhsSt4XK+p4lK2MqS7MsA+aM7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7sd+gwmkP6d0CiNjYWEElMrKw/KQZH+LK8XClAH9kU=;
 b=lZlsp15IQzsDeUc2D7XpusLwHDbUK7qqoncz22ueLSx0L5r5BSEuZgD62wOlYMLZs83ghE2fOlBqeRmpWqgctyqn+rJUDX11t/PrXURi9pyc1shqhYqUjdi7T+ki5zqGaotGCT197PlisX+8ysL472I6ZxyDl/1r4bcsIIJAppGGbdCG3CJMPupBXhrRL27BQ0bDIB/C40ySj6SlKAh/BYznIoH4DhNoENDggGXeMGkvz3NNKlO3RyLZ+lDB4/1Fr7NuOHfFFONV+Gi1V1Cs+1JvmhgZ1Vheci71xpRPDCr4VFztZG4bkqOV924B3wxw810eI7m7BPIlNxtBzq2sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 20:01:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 20:01:08 +0000
Date:   Mon, 14 Aug 2023 13:01:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernfs: implement custom llseek method to fix userspace
 regression
Message-ID: <64da880166403_5ea6e29449@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230814190850.948032-1-valesini@yandex-team.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814190850.948032-1-valesini@yandex-team.ru>
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e4b857-fd59-4675-a22b-08db9d01330b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjsaB6embgbfWEfR+0bSKyqNbglQi13dD7j5fdH7b8SROsGtL9hJfUlUwVnFhW4SN7n7S8XmLJ759QgvDQwYjAdMH/Usd2Fu9RW+PyUzhh3PXIG6NoanoLf/LobbvAYjZbFjd/ntoS8Vs2pt36Ktjb1pB8yKitTNe9HruHfPMaKBbZCMd/4CF+eVrEfAZcKCivdLwFPCvdJKey5Fyyt584nH7h2IkJS3zWUON9u76nxxat/CqkAkc8Hpas6u9oFExhw3xpd/FUy35TiyCQdtk+xq8MwPmzZ6YJNmOoDD4DQWJMSYBQzTKCrCri8L2o4rcZlfX6GiXl7YlRfZNra7x4ZZUtC6+d+WQFrqF468Qe9WWTcmGdUyD/MZber877amDvQdXHbC2Npm9Ql1qhxs5rzGhya+i4Ckjtk3sIuutfEuPxaFj349RqtHMj1TDn1t4BC5fwFxG7Zs9Ruyd6wXS0GhDc8k9NX7/idpe9d/y5Gz1jy4MCTjKqXJ6Rt+LG3HDce18Z+fnM+j26xwaIS9mNDxG2ZM0g99tRfmk8Ha/jJlZYZ9CFMj4RnJYJCRr/At
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(1800799006)(451199021)(186006)(82960400001)(38100700002)(478600001)(86362001)(26005)(2906002)(83380400001)(6506007)(6486002)(110136005)(41300700001)(66556008)(66946007)(54906003)(66476007)(316002)(8936002)(8676002)(5660300002)(4326008)(6666004)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3nPJL7qKUOoIq7m7TwBc5SAHB7nnXu/qxqOUC+sKlFG3G5OcqArF3y2aYa9?=
 =?us-ascii?Q?YCW44eaxeb5jSjbf8P1kmfTRBAdQ8sBTCdQKQH4YHIxHisJ356vrdWT4Wj+N?=
 =?us-ascii?Q?doOnXflPLutpryHieUTqOHju4XKMjDf9RUajo0W+JPUJ6LmjUhqavgDJ1DHL?=
 =?us-ascii?Q?Wm7+ighWTbDw2mxEF+TW6r4s3WvMfwCezxrlOlXpX0hI9ZSYiQ10e9rRxDhG?=
 =?us-ascii?Q?aSVwBVp+IWjn+DtwXp0hA+3ziFDdfyemIHFvZfC7OhgpTRLAPrhvawYekxkm?=
 =?us-ascii?Q?HRqIOv9byaeIRoXLSzYSqPgt3y/rcwMBXRRh8V22+l2vrKyaKThUCLszxQ+W?=
 =?us-ascii?Q?er9vySvRwydIFF/M+jhEyVRICYkGsSP6JAf/BQ+Nou/llN2Ny/Rrhd3OdBdS?=
 =?us-ascii?Q?mdRWNwu+gQh/a6W41FttTACAqYMryOqCd+206zYmMdldTFCgcp4oZqfu5qfb?=
 =?us-ascii?Q?qhsWpdYA3jdWJcX4v7QTjkTlcUq6oGk/xftHiPifr0rQqQIMDDwL1xoI77nU?=
 =?us-ascii?Q?mlNGnPuEP7y94fC3GcS0r7v3QmO9gIHBj5WHfdJLG2vWu4cPUv0Y4hjXPyWJ?=
 =?us-ascii?Q?MKJS/uaVVts3dBvdEuSSfZKV04OtmgDjt3IIg3kTYm810ndLwe/x4IuXKjta?=
 =?us-ascii?Q?qnlPryxxZNGhxwIlMrhbYO1J7oOQIWRs79B54pojSGkRjOu9Yv5aJh70eFiN?=
 =?us-ascii?Q?utUEzhjgHqy+zArhH3SW2vmKZ639k7jHL3rmhzjJZjGfkmewxCGEaFPZ9TGh?=
 =?us-ascii?Q?7kSKF2fSTxQzON1lJqdBbJW8pWxI8pvK8GzWOnEy6I6WDO5zWCKCdZ0SymjL?=
 =?us-ascii?Q?UDku7r65rj6w0sLj6e/5xfL8fjb56chLIKgm9X23VVOKTLj3vp+k6Nhf3tEG?=
 =?us-ascii?Q?MjH4v0tdBLbxkiiEklZrbi/Hjx7/htqJdj45qj7MKXveMT/P+uFSnynJ8Ppn?=
 =?us-ascii?Q?pvyQ5vBV3Vf1qOmNm5/TFYmXRnI0H1STtM1oMw96TZHBRQMdEoSrDKQvYZGc?=
 =?us-ascii?Q?/OlpFpqPk9i2uYB4iUWrVmnh3+JWtrm2PDGKJYhSQcE3gaQxwi3oF3Ljf8ab?=
 =?us-ascii?Q?1nJGCiamtm4irQF3Cv74d8oN/cFTULJcsXuBnhruxj3fF9w9NGmemalmMS91?=
 =?us-ascii?Q?LGdi4da4vT0GYhHPfaRKCey8O1SNFeIYmIT0VtW1Nov2cbC2OIdr92IpSMdW?=
 =?us-ascii?Q?BBQkv9Vm0xwQGUJt64nasPq8xGinOVDdvOw7rhOw0LF3xxkXuk8fKBluDf/B?=
 =?us-ascii?Q?Ey89uiHj6XQSxXK9PQTgJlgjKhXMCf3ZiJtIIoSNRFwFE7Wi3HvrxML4fhGX?=
 =?us-ascii?Q?v5YaKx3J2iJ/1VP4a/hDjAQhohVXGP4Xvxj3JttnAUOpzrAacT59xIxRfLZ9?=
 =?us-ascii?Q?zWacYje79adAvswda62kHEndELvbdg7POy9/l6BGTvtBrYE31gbaoovGpJ3W?=
 =?us-ascii?Q?FlRLT6ZxiffO/8qnH3kHdVhFZqFWp1vohx++UnUeK/AR0/MJU/YqqIqW/LZh?=
 =?us-ascii?Q?PUpvxows0t/p9BDmKUK5e4Kt5kSkYLpwkN3ieeKEO+55C9MkmP/MFFsq0cYm?=
 =?us-ascii?Q?uKNsCzRImNbdVPmLPjUS+onsbDwn/VOwLdoAEA4fQYRiu71c9fBfUli+mvm4?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e4b857-fd59-4675-a22b-08db9d01330b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 20:01:08.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPfs3PGBhEU8YJbBvw69osTtlonPbtDgygqlv4/wzmkJm0nFxxsNEMiWo6L6p+KQNlZ2zsv9WnDDQsA7MDFfiBLQFJt9cRsQ1NgAxcDLDNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentine Sinitsyn wrote:
> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"),
> mmapable sysfs binary attributes have started receiving their
> f_mapping from the iomem pseudo filesystem, so that
> CONFIG_IO_STRICT_DEVMEM is honored in sysfs (and procfs) as well
> as in /dev/[k]mem.
> 
> This resulted in a userspace-visible regression: lseek(fd, 0, SEEK_END)
> now returns zero regardless the real sysfs attribute size which stat()
> reports. The reason is that kernfs files use generic_file_llseek()
> implementation, which relies on f_mapping->host inode to get the file
> size. As f_mapping is now redefined, f_mapping->host points to an
> anonymous zero-sized iomem inode which has nothing to do with sysfs
> attribute or kernfs file representing it. This being said, f_inode
> remains valid, so stat() which uses it works correctly.

Can you say a bit more about what userspace scenario regressed so that
others doing backports can make a judgement call on the severity?

> 
> Fixes the regression by implementing a custom llseek fop for kernfs,
> which uses an attribute's file inode to get the file size,
> just as stat() does.
> 
> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
> ---
>  fs/kernfs/file.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 180906c36f51..6d81e0c981f3 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -903,6 +903,21 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>  	return ret;
>  }
>  
> +static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	/*
> +	 * This is almost identical to generic_file_llseek() except it uses
> +	 * cached inode value instead of f_mapping->host.
> +	 * The reason is that, for PCI resources in sysfs the latter points to
> +	 * iomem_inode whose size has nothing to do with the attribute's size.
> +	 */
> +	struct inode *inode = file_inode(file);

My only concern is whether there are any scenarios where this is not
appropriate. I.e. do a bit more work to define a kernfs_ops instance
specifically for overriding lseek() in this scenario.

> +
> +	return generic_file_llseek_size(file, offset, whence,
> +					inode->i_sb->s_maxbytes,
> +					i_size_read(inode));
> +}
> +
>  static void kernfs_notify_workfn(struct work_struct *work)
>  {
>  	struct kernfs_node *kn;
> @@ -1005,7 +1020,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
>  const struct file_operations kernfs_file_fops = {
>  	.read_iter	= kernfs_fop_read_iter,
>  	.write_iter	= kernfs_fop_write_iter,
> -	.llseek		= generic_file_llseek,
> +	.llseek		= kernfs_fop_llseek,
>  	.mmap		= kernfs_fop_mmap,
>  	.open		= kernfs_fop_open,
>  	.release	= kernfs_fop_release,
> -- 
> 2.34.1
> 


