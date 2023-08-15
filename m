Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08B77CF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjHOPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjHOPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:48:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83510C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114517; x=1723650517;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gA10sW9SM4It5k2s9VhbS9vSGrf3QDa6ma65/N9cHOQ=;
  b=AXWKUmpsIsiUWexBX6q+tGSVWzw6AQwC+Erc/PFnGAz4ljmCTV4wHb/e
   B9srvx+fv0HGSl4ZqUyLkfkWvgmlGPFtQiHbt7PXuKQdJTZlnuWjYTGgc
   OkOU5gN7yjPPGbnFOLSxLgFkAehSaBpe9utcM8fjjNigif6Lhtrd3vXdq
   uSq238ZJMwMQcQGIJadO96AzXlzwbkB+wltCFO85wpltw7VzALdclJDx4
   h5l450iJbPzwyd28ho8IqkU8t+14TDznDf0lMF2WVjO0c/kEgtmsuGI/T
   bVuW5kj/4iZWLv0JXPrUU/UJdtQaRg3ZgtI8nw7QEpHN2nfDnwdvcr0N7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362460122"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362460122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733884339"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733884339"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 08:48:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:48:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:48:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It1S1YVjnJ2Ksn3JWm8jNzU1FzooeOib7eWSur9qBbIlM7K77YTlpYd4UvG7Cmf4hKAPI4FW43FF7nt33ucwUNkygqm4slcCSf2tzRfYmq+xn/y+g9+fGMfbKvHnxIZjL2O1PUFvkNNxQrBIjG9czIl9Uh66GoxyrXq0dJbKk0Rg+W9/6RscJlbWLRb0AlBYxzEDx49xjXXKnhiINOjf3aqPBbehOY0YPY6SEWMvgoTI+N+QH+8AKmxenkOsMaTlGHxgzXn4fqMeST5wMaF8/zq7H4ZVHQ0wGv0mayV19c1v0jClHPs0yEcqfWkxY5sx+pOOVKQgklX6V3JMi3vPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKtJ9cBvLjS0mQ//fv+fiFiAJXO5Hdeg5POreB/O7XY=;
 b=PnSMvQHAtdmAHkkX0Il1MXVZRUz09xZ4WeLdQ7JVZbykAjX1dr/1arrM/Re3InYxUYS9kaFCHgyc2131NihZZ4yCRlyTNvwjrQguW7QS2abchbVckYWG4XYnZbbYhY3e3+pizpiGcLcKmurUC+EF8RosXCWhwmG/OcjiJ7Gx6WEi4tJIaO+SxCcnnL5ufSwcDJBFOE9NULlL9DBpb4PY4l9OWDZGkb6szBC6/swBHsWAWYicuqbL8uZ0SQtR0RrvMvde24ZbUiLTyYztdYJWzYrKJaX0j0Eu+5jTepsdD8AcDq0+ukrrB8MZRMHdpaSU019YFOZwlLGsoi66QlAINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:48:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 15:48:28 +0000
Date:   Tue, 15 Aug 2023 08:48:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Valentin Sinitsyn <valesini@yandex-team.ru>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: implement custom llseek method to fix userspace
 regression
Message-ID: <64db9e495b729_5ea6e29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230814190850.948032-1-valesini@yandex-team.ru>
 <64da880166403_5ea6e29449@dwillia2-xfh.jf.intel.com.notmuch>
 <2d3960a6-34fc-1951-b39b-ce41674bb4d0@yandex-team.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d3960a6-34fc-1951-b39b-ce41674bb4d0@yandex-team.ru>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: ab913d02-21de-4362-117f-08db9da7119b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TTAj5GDWK4AiOIewfkcT13MqPE8PxXR1WQrDK4iUWrUuZ145o+PUa2A541cFYaurdyyAlWgyKb1ZmLxofGF4Aof69HkzQ+aasEUHysR+4Fh2C0dGXhwaEQuewIm8wBVAmYFouA9knHjcmWOejITqTKABD6tmaLl1k7R+n5ryRtB9M/yyZjcLg4b2cNRqs8hxs/ndqvVv5e9MkH+18NBooYskM9ySH+qB9ayJRdNRy4njH09GSnJ4sXAc5tGiWRjaH8tRYNiAffEfGzhCyUAkM3ZcbeZTKYla1PDVp31MBQ7zRZK6nKh9FcyoIdsfxL+PX1SFiqJKuTsNn2PiehHCZILN1OT/usgfu6RlzutWX+zWctImNcRGkvKMlgIbdIOB7+2vF+a+IAZbgXexe0ENjrlj7yLsf1scoAOa7LY/7oScpBL3q0YiAwqAimwChFnWKjxAYLDy6LrBgFPZ/wabnBWyS3gRh7hSX4JBfPAOzKdKjqujgY3+0ipO9dfgh5R/KDao/ZfEGMNuyJFhrJkGqODDxd4mX+VeZfs1vn6aJLlDP5Wb2sfKsCTErp8+5BE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(478600001)(6666004)(86362001)(110136005)(66476007)(316002)(66556008)(66946007)(4326008)(41300700001)(8676002)(38100700002)(26005)(6512007)(9686003)(8936002)(6486002)(2906002)(82960400001)(6506007)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLfEj0mQKluIHUSi3vIhmiZnHl+vfqZg257FXBo2aUVneWOgaZCJmkfQSz6y?=
 =?us-ascii?Q?CQd8pb1BUUmYbFTpi7rUAfE9Oc4IM3h0v3jflCK9s3egItgcAvmUB9glkVPi?=
 =?us-ascii?Q?erHHQZ+Rybrz8Sl1/dnZat7GLAQmBW81iO2CpW/gzIZGsW2S4RC4ssk4PgT/?=
 =?us-ascii?Q?VYe2bE4g46aaKESpFcQJSVylASFVDSHywZs/zcbmTdEOu/Hg8/oUTc5rVKqX?=
 =?us-ascii?Q?7U1rahhg3vRpf0B+kVpHrJBN7K5bScCoSgeO7i4bTaGLjKk6IaQH4+M5UzSQ?=
 =?us-ascii?Q?fhXdiDBrjsIDQEp5vBd+wTW5tt0ZyRFdvHlamXWCSg3q2gE/9ki9UuO3M5bL?=
 =?us-ascii?Q?4rOICcCnKU/zHGhOv562CITpHw3zykUjlYj7/NWrj7/wPCfYKa2vZJFpWMdM?=
 =?us-ascii?Q?fw4yRk7meVOl+1Rn2MaamhFzgsF6q1C+vSSvAlRKACC+LCJxidof7ffK+MUz?=
 =?us-ascii?Q?4l2jv0qQiFO3Vq/VD2u+flbbWwP+YCTs+Pl3Zhk+zZY50Xx3qUvIu5LDAqRM?=
 =?us-ascii?Q?pkFRU5jt1YqdMc1JvFP3zZRs2WakEvuhDGf3TU49fx0nnG2Sdd68Ock8+qeG?=
 =?us-ascii?Q?CZGawS0nIFT1RHOAAdXba2QZDbSiXphsrSQV8kWso8Lrb3LekG/ucqwruTpZ?=
 =?us-ascii?Q?GWWK3Pg/3isrkog9n9TNUT7lq7Q2uy4dJrxLhLft0wMqgVlQGRIlnlhorKBW?=
 =?us-ascii?Q?QBXsDapGfxm059doufthq50C/itSX4r0twrmoDznjhcGXhXunSXTNo62bV8s?=
 =?us-ascii?Q?mn8/rUfN/29HvVncZiamMs9iAL4VjDVEIKsiQwUhQgKO83vaveC4+oyrvfda?=
 =?us-ascii?Q?LO9q/RcR/FeydAgA405691rq8AjuxnWz4VJRkrn8Hz5R5M/sLB4dXZN1Wp9L?=
 =?us-ascii?Q?3tUCZhldCtOfjofsAsFWuLEfd04CEnMJvdCyM3cwobAasz6rmjUuv1AiGr4U?=
 =?us-ascii?Q?NSgE6voPFBZWbnHg+waMIjybWt49jhOGNEWlOSx8317nsWAZ6Tk8zlhV95k9?=
 =?us-ascii?Q?hu08WNgtr9TblDT/yI4y535HRkd+jbqBCOnlWyi048GWSfmLxGsSOV7l5BsD?=
 =?us-ascii?Q?A1lic/05Ll9dexi/JKIVUwwBMjuxmfgaX1Or2d3zd4kgvqEEAVMPJCYuYNbN?=
 =?us-ascii?Q?C1EimiuvBujpJVhKlDAuNQc5Llbaia2zo0AHOA7pHRB8nam3HUcZ+fuOQOfQ?=
 =?us-ascii?Q?uCg0WxyzSQQZzjs+A1buKx/3ahSIfLusAiVPj8ZxFO3HFuNyHVP4fCCyWeCm?=
 =?us-ascii?Q?8o6R+KRKwQG0gQlobY3IKlIE1ULPUbjgl2L16Zy0kMwkaBt2r7ofQnner2KI?=
 =?us-ascii?Q?LSWj4H6/+q61lyhRRkj0XGXBQrtaumn+se/WepCz+Ty+7jH2IBXNv+0AlCWu?=
 =?us-ascii?Q?rSHKLQ9+DZQENWzIFLEHmuLNnu5Tzru3WkPj2sR12zEJqfSWg9sMyHCKHYAJ?=
 =?us-ascii?Q?ex4WG5GmkHRIAKYOP8IjmmXCpvDI5jrnbR3GAi0+Z2y0YRgnhsDSmErUJijN?=
 =?us-ascii?Q?dg/IxUF8comYyXyGm6R8htTA0oEZunvv8ApHId2CXF0m4ztZ2J7zZ09ePf4k?=
 =?us-ascii?Q?g9NxX4aXs3bC2RgCoyF5yBJ0UgzEVcRCSUZO3L5m292MLOtry+B79j9YJ7zF?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab913d02-21de-4362-117f-08db9da7119b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:48:28.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Tf6zDur87dSXp8tkai+9MqmSy8aVkqXNM97dFH/XrI7ogMqsoyF1AImbwFKO0CBQDaFsrzM6e75bt4YQzLfjRP616ABCDn/t/m/9mFlw1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Sinitsyn wrote:
[..]
> > My only concern is whether there are any scenarios where this is not
> > appropriate. I.e. do a bit more work to define a kernfs_ops instance
> > specifically for overriding lseek() in this scenario.
> 
> Not sure I'm getting you here: do you mean something like this?
> 
> struct inode *inode = is_f_mapping_redefined(file) ? file_inode(file) : 
> file->f_mapping->host;

I meant something like the patch below (incomplete, but shows the idea).

> My understanding is file->f_inode should always be non-NULL and point to 
> the inode corresponding the path of the opened file, so it should be 
> safe to call regardless what f_mapping->host is. Do I miss anything?

That matches my understanding and I do not think you missed anything. At
the same time a comment about "PCI resources" is out of place in
fs/kernfs/file.c.

On the rare chance that someone down the line cares about the
difference, a more localized change like this lets this override be done
in generic terms (f_mapping override) without reference to PCI resource
specifics:

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..748804cd889f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -167,6 +167,23 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 	return battr->mmap(of->file, kobj, battr, vma);
 }
 
+static loff_t sysfs_kf_bin_llseek(struct kernfs_open_file *of, loff_t offset,
+				  int whence)
+{
+	struct bin_attribute *battr = of->kn->priv;
+	struct kobject *kobj = of->kn->parent->priv;
+
+	/* when mapping is overridden do not use it to lookup the inode */
+	if (battr->f_mapping) {
+		struct inode *file_inode(of->file);
+
+		return generic_file_llseek_size(of->file, offset, whence,
+						inode->i_sb->s_maxbytes,
+						i_size_read(inode));
+	}
+	return generic_file_llseek(of->file, offset, whence);
+}
+
 static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 {
 	struct bin_attribute *battr = of->kn->priv;
@@ -249,6 +266,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.write		= sysfs_kf_bin_write,
 	.mmap		= sysfs_kf_bin_mmap,
 	.open		= sysfs_kf_bin_open,
+	.llseek		= sysfs_kf_bin_llseek,
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def8..9ed535930259 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -316,6 +316,7 @@ struct kernfs_ops {
 			 struct poll_table_struct *pt);
 
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
+	loff_t (*llseek)(struct kernfs_open_file *of, loff_t offset, int whence);
 };
 
 /*
