Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9597BFB61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjJJM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjJJM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:26:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910CAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696940794; x=1728476794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/n31a3JEp0Y/lDx9qw1C3ugQPYwpbHp8+cI7GrhgDpM=;
  b=ivKdu6+G8X3CMLb9lGo3uW+Ulovox+hBpDO5cYsllZtnoTL3Ck1MNgo2
   N5lwRg6EeNPgCxQTjoPKi1mMK+iVSfU/BeTXmlZ4+6/ov9tTydKLdX9wq
   XGoeI3CMDRJo19raE2Iw3Mr5wQNq0K4oorl5QwNlDVLxqyzLk76a/tZDy
   fyzPR3fqQEkhFLBrXCW7elNFzpO6XzXIet+eFoE/5BN/omn9fv3keRcvF
   8B0nVBFiwAru7Xck+gKnUY2gUk5whcMK0TPoX87aM06BF6nV2WP0Q2V92
   Bo6EKcRGXY+Gf+mEKoULWPTg0IFKYQH1kNY6kEZn7x1XI9hVcc5wlwT6I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369444414"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="369444414"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 05:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="757095408"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="757095408"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 05:26:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 05:26:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 05:26:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 05:26:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 05:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVBk2wK45UCCqdGlh06Jqii/pXUZoA7UutiH4kdMZVfn3i2/0SCuGNQE6ega+bLpfwUXmmGpdkbIudz2oakuaoVL5jLrpMDujl4WDaNIiTlaFFFWgwYh01c/WkmWP1GF0ozN5W4RfYALUwqGu31saOzD+jbaV0lNiMiApvKH7wmOHKac7a+2o9mLdR9jTUbkRUuVBqX6Uqr6AyMObIx4DK3ltEmJpdY/fWVryoyKrcK4e21hR6HaSHqzx3VORp2wl/hEMYlpaWKggj+i+W344FrMv+DUcsQAoL+L974OqJEr0xrdI32owemn5QUEPmK7kkeB80jlU1zbh1E0RMh0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE99yn3eM7CbUJbc7KvtgqbSRGcs7bi15tW4hUqTCsk=;
 b=ClbD33m1sjNwGZh7Dzit6ZDTVyvdGEAovOjpM8LKAW2zEDrh7ChjQPGIyOLPA9rm1kJbqRwI4NQ6NSyC7lGJgZtGyX3JKmtRyPODUwOvhxG1l+qtRXMLX6/1B16gOAtcwu3LItjdg4UPiNdqx1AfOsukuRSORlbNK9rvVt+y54pSu8THAii82ixuGlD5E0g7P/pwlDQrNXIQpTTrWoE3ti6PjrqFFKYrhwCxsxKcpXnySsITI67/wARa0D3Atj+1W9mh2EPH/ha8qisSORDbHhdalvkRtFjPO0xchMFBPkvoAEVOOAo8p06EE4evUyVc0z9OIPnBxZalPutSUKasiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Tue, 10 Oct
 2023 12:26:29 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 12:26:29 +0000
Date:   Tue, 10 Oct 2023 20:26:19 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Olaf Hering <olaf@aepfle.de>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: fs/afs/dir.c:50:1: error: no return statement in function
 returning non-void
Message-ID: <ZSVC64XHKyCdcTx7@rli9-mobl>
References: <202310101901.Q5SauZ72-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202310101901.Q5SauZ72-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ0PR11MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0c441e-8f40-4aeb-0450-08dbc98c2147
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHtqas5TAbEnYaLT1qjx+ITZb+2IsUa+UHaHQrL7BArDrDJnMVc1l2voP7cUCXYEnKYinA+Nfmi0yIp4YO7QO02fTuxn4yCAbzQOzXAC+EPyRo2yP6ovKD9FUmnlcjIuLpgDdyMH3j7VerWgNIm7RPAZFlJM8h6O2vkWYeOMQhU/+N5m2gRj/u/126Ruct9jRLZhMNJjnDqFYsP/ZAtBbfTD5ll3IJiWTHW8Rk4qx7M6BWQKsIvVv2MN4VJQuRf97ZvMf6fPUjf4uMy0w4mR3Fi25grBlmYr4KQ9xZHR/9LNB/vTuzFVF0jndtmxESu4Uwk9Hty25eMeQIbDTzJfoVKWBSCgW9ZqBadbMe8iccc3fESq9iYHN4Y1BnxVnn9vTJaGH2RQ5UrvdLI9RJoYof8QxvAVyMB9m+TGboY9UXwk+Dlyxh5Y+OZv/ppqtxLhFl1CcoDmv+qdTqjJjTub3XF+6djvEzUl2PymaRzodI4Y4xJbaoS4v9wJ+atXhluJUsLdwokyPOImfTZCSeYz6leOvXp+B4Qrb1rKMYRuBHIrC7sSEOrNvSNlQxQdED2s5AVkcvymUHuzbFEBJBuj4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(33716001)(9686003)(6666004)(6512007)(6506007)(26005)(478600001)(83380400001)(316002)(6636002)(966005)(6486002)(54906003)(38100700002)(66946007)(66476007)(66556008)(41300700001)(8936002)(44832011)(8676002)(4326008)(6862004)(5660300002)(4001150100001)(82960400001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QE4TBW3YCBCm9TtmAK8tXSdAc3aY94Q+2cDPiTbNmJX9/qyk0zjNkFC/hnfG?=
 =?us-ascii?Q?kpKJbRAYk+rY6iN3y65my7Sk2jHnuE1dwIvbYoibUyiTJckiQAywem0SgsEy?=
 =?us-ascii?Q?ymv7RtrJv0RFTWJLE5Rf4YBjTSnC6ouo39VQfeBBWD69XWca2cNm55/naJeN?=
 =?us-ascii?Q?wp9b0+QusJSBlQX7lrd1lKwjZSXDgu7/kyyAqj8lAeql7jGtwRtwQdHj3afD?=
 =?us-ascii?Q?nTXoprADvRYynySo4Agq6mQ5MEbl4rLQ55eICwxZuKq0aZEaQeCFkyhZLDuQ?=
 =?us-ascii?Q?aBud2Sc35bIp6VDrp8k87K62Ytw9QH7wt7rutYSLflFayWUT86DgdI5e3M7A?=
 =?us-ascii?Q?Ecw9BE8iblSCPCO87TO4QN3p5Ndt63n52y+G9B79ukJ++FJ5cLQIfysLyAaG?=
 =?us-ascii?Q?Uxc4tR9mquUEZgZbh/TFrEHXHwkJyWiFm4pvQf9LtNKtOMl/80wMpeO8/FPu?=
 =?us-ascii?Q?yPUMVxloCUzgQ0NQKEAMDU1U7kxUGMG75GSvUrIvau1vc/hn0rOBFMTwc+lp?=
 =?us-ascii?Q?IIvc0K6hGHz4UVdSkHpknjzI7q8ahygKMpa5k1BfcBsWh55Qoz3Ux1DNKaht?=
 =?us-ascii?Q?70MeJ2Lqc43KVp9PZhRPZakZiyOsvqVZb1gkGf8qi0mZr3ZMp5n7zwYorjwk?=
 =?us-ascii?Q?ZBlfFBaC4OPdHCtxEMrcfMRwEpKj7LL1xPyfvITk2YQVeixmE/8yFTr/yGhg?=
 =?us-ascii?Q?18OuUFVOEU3tLyD5GIZTjuuha06SClQwxcZt/1DRD1bDPAwa+0+mJdCAC7Y1?=
 =?us-ascii?Q?SNEjE3arBt+SRUPKr8Y0HPk2ZZph2U5PI7ksTl0eOsUfqiImNUztI5l3BjBW?=
 =?us-ascii?Q?E80gu5Hr7+sRpWphvogyppbHvFAv4oCyw+To3MnukTm7IMBzbms7ZfSoK42w?=
 =?us-ascii?Q?MzeWLkANdZNIs4FqU+Cb1fEm0gHojdLd+wLpNi00D4oCBo0ZSjxRK78OdoY4?=
 =?us-ascii?Q?HwiTFTHh02VDN0JNG0QaLClG19mKYCIWbdZ2J1eNJszTzPHHA4TFzjuz/SvG?=
 =?us-ascii?Q?qrO1LvHYQh3iHvosnLeHGWauylLEIRjoGX5YZQzXuKuuR2krkbmMS+IbZQR8?=
 =?us-ascii?Q?tP1K1/QjfuKYLW43ybB/H4oNEFI90R0SKirsIjZaHmjgnXKOHGefNIFSmzNb?=
 =?us-ascii?Q?csMY59zrjJTiQ5SRZoBhNf/nbDmd9tRZa6X9xr2fVNAEjHqdQiTSg1LD+jrZ?=
 =?us-ascii?Q?o4GeV5tDaWcHmtDrx5TK/23KJFVJZU0rqAINzRIu8ORZ+RRa6wB3HrxDDr4Y?=
 =?us-ascii?Q?cl42tJJQldLXBJu7hG6460ieCh8vlei0IPaAKQwQQwRD0Gmo+FsKLIFQ47u8?=
 =?us-ascii?Q?0e6UFofXC2NN/S/Hb/dbRPeMFFXpN/44o/UcXpfu8HzS8FIuqD8CUnS+5yXj?=
 =?us-ascii?Q?ClXgBqwqbiXM/uEYLXVxIp1CBdMHjx2To0aGo50/x9ZjlA3oID1FgLzfnill?=
 =?us-ascii?Q?aW4Gqyg+rZotvlbzDKi3RUA1oQDmNIVfsJOBOIuNPEqhJevwTzrz6sea9ynf?=
 =?us-ascii?Q?0mOQd8ApwwfUNTpctkkW2Og1IgEboFauZDI6amLJ6VIw3W0RgEKQasENjqE7?=
 =?us-ascii?Q?q3JKML/9Qo9o4lymufprLCbRKYnciE9u4p3+mS2n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0c441e-8f40-4aeb-0450-08dbc98c2147
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 12:26:29.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzOz52C/QMm3XBcrNQn/BDs+n1Z2zxfER5VVJH/P2HPNhnzFsL77bRhUKWfCDL8EW1XdMdGGOH8KUojtG8X6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:16:57PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
> commit: 172aad81a882443eefe1bd860c4eddc81b14dd5b kbuild: enforce -Werror=return-type
> date:   3 years ago
> config: s390-randconfig-r033-20230512 (https://download.01.org/0day-ci/archive/20231010/202310101901.Q5SauZ72-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101901.Q5SauZ72-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310101901.Q5SauZ72-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Kindly ignore this false report that bisects to the wrong first bad commit.

> 
>    fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
> >> fs/afs/dir.c:50:1: error: no return statement in function returning non-void [-Werror=return-type]
>       50 | }
>          | ^
>    cc1: some warnings being treated as errors
> 
> 
> vim +50 fs/afs/dir.c
> 
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  19  
> 260a980317dac80 David Howells  2007-04-26  20  static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
> 00cd8dd3bf95f2c Al Viro        2012-06-10  21  				 unsigned int flags);
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  22  static int afs_dir_open(struct inode *inode, struct file *file);
> 1bbae9f81860995 Al Viro        2013-05-22  23  static int afs_readdir(struct file *file, struct dir_context *ctx);
> 0b728e1911cbe6e Al Viro        2012-06-10  24  static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
> fe15ce446beb3a3 Nick Piggin    2011-01-07  25  static int afs_d_delete(const struct dentry *dentry);
> 79ddbfa500b37a9 David Howells  2019-04-25  26  static void afs_d_iput(struct dentry *dentry, struct inode *inode);
> 5cf9dd55a0ec264 David Howells  2018-04-09  27  static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
> 5cf9dd55a0ec264 David Howells  2018-04-09  28  				  loff_t fpos, u64 ino, unsigned dtype);
> ac7576f4b1da8c9 Miklos Szeredi 2014-10-30  29  static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
> afefdbb28a0a2af David Howells  2006-10-03  30  			      loff_t fpos, u64 ino, unsigned dtype);
> 4acdaf27ebe2034 Al Viro        2011-07-26  31  static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> ebfc3b49a7ac259 Al Viro        2012-06-10  32  		      bool excl);
> 18bb1db3e7607e4 Al Viro        2011-07-26  33  static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
> 260a980317dac80 David Howells  2007-04-26  34  static int afs_rmdir(struct inode *dir, struct dentry *dentry);
> 260a980317dac80 David Howells  2007-04-26  35  static int afs_unlink(struct inode *dir, struct dentry *dentry);
> 260a980317dac80 David Howells  2007-04-26  36  static int afs_link(struct dentry *from, struct inode *dir,
> 260a980317dac80 David Howells  2007-04-26  37  		    struct dentry *dentry);
> 260a980317dac80 David Howells  2007-04-26  38  static int afs_symlink(struct inode *dir, struct dentry *dentry,
> 260a980317dac80 David Howells  2007-04-26  39  		       const char *content);
> 260a980317dac80 David Howells  2007-04-26  40  static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
> 1cd66c93ba8cdb8 Miklos Szeredi 2016-09-27  41  		      struct inode *new_dir, struct dentry *new_dentry,
> 1cd66c93ba8cdb8 Miklos Szeredi 2016-09-27  42  		      unsigned int flags);
> f3ddee8dc4e2cff David Howells  2018-04-06  43  static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
> f3ddee8dc4e2cff David Howells  2018-04-06  44  static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
> f3ddee8dc4e2cff David Howells  2018-04-06  45  				   unsigned int length);
> f3ddee8dc4e2cff David Howells  2018-04-06  46  
> f3ddee8dc4e2cff David Howells  2018-04-06  47  static int afs_dir_set_page_dirty(struct page *page)
> f3ddee8dc4e2cff David Howells  2018-04-06  48  {
> f3ddee8dc4e2cff David Howells  2018-04-06  49  	BUG(); /* This should never happen. */
> f3ddee8dc4e2cff David Howells  2018-04-06 @50  }
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  51  
> 
> :::::: The code at line 50 was first introduced by commit
> :::::: f3ddee8dc4e2cff37936afbeed2fdaa95b7fb7c6 afs: Fix directory handling
> 
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
