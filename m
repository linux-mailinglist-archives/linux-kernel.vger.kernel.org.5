Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1857DBD7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjJ3QJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjJ3QJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:09:53 -0400
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CDE4;
        Mon, 30 Oct 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3699; q=dns/txt; s=iport;
  t=1698682190; x=1699891790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNnoMQ4I7acQaTIEyjdpFkNmCGqvwkumfmLfUlT8veM=;
  b=a/wY+Z2rZJqafXwQC6lcdsaqwRWKQNGnGajtzM79g1c/CYVjk4pfU3Dr
   wrbLj0Cnc/wpXrZeKsXmp+J6xGXvRmL+0xexqowRKLWv8RW80MJGSKg6z
   YOKdUBtqCJJRQj+WR3RqD4ph4UgXMXHtRrd3EVYKvpz2tp+QFBmpBjd7T
   0=;
X-CSE-ConnectionGUID: W+MC8d5QRbySLYisNsXQ0A==
X-CSE-MsgGUID: YO8MyPrtRzmES2iiCX6qSg==
X-IPAS-Result: =?us-ascii?q?A0BhAQCd1D9llxbLJq1aHgEBCxIMQIFEC4QILhJIjU6IY?=
 =?us-ascii?q?gOSWYslgSUDVg8BAQENAQFEBAEBgXIBgxMChx0nNAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQECAQEFAQEBAgEHBBQBAQEBAQEBATcFEDWFdYZMAQEBAQIBOj8FCwsYL?=
 =?us-ascii?q?lcGEwiCdoI8IwOoCHiBNIEBsyeBaIFIiAoBigZCgUlEhD8+hBuGSSIEhmQog?=
 =?us-ascii?q?V0HDi4HMoEKDAmBA4J6NSmMQF4iR3AbAwcDWCsQKwcEMBsHBgkWGBUlBlECA?=
 =?us-ascii?q?i0kCRMSPgSBZYFRCoEDPw8OEYJDIgIHNjYZSyuCMAkVDDRNdhAqBBQXgREEa?=
 =?us-ascii?q?h8VHhIlERIXDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNEBkoLAwIaBQMDBIE2B?=
 =?us-ascii?q?Q0eAhAaBg0nAwMZTQIQFAMeHQMDBgMLMQMwgR4MWgNsHzYJPA8MHwI5DSkqA?=
 =?us-ascii?q?jsWA0QdQAN4PTUUG22eV4IQW2gCDwI2gQMSgQ4BHcUmhBahIEkDlxOSUZg+q?=
 =?us-ascii?q?CgCBAYFAhaBYzqBWzMaCBsVgyJSGQ+OOZNaQjI7AgcLAQEDCYhvglsBAQ?=
IronPort-Data: A9a23:8HCCpaueenIyrvkl59WCIYjOM+fnVNFeMUV32f8akzHdYApBsoF/q
 tZmKW6CO/+LM2v3ft5/OY2z8hsB75HcmoJkTVc/r3s3Qi1HgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHYzdJ5xYuajhPsvrY8Es21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlCA8um4n0GbSkHm0s5KPUAtG5Yow75eVDQmG
 fwwcFjhbziKivjzy7WhR6wywM8iN8LseogYvxmMzxmAUq1gGsCFGf2Ro4UCtNszrpgm8fL2b
 s8YYidrZQ/oaBxUMVBRA5U79AutriCnKmQA8gvPzUYxy1n0nClg6KLxCsjQV+fQRMR+rhiBn
 W2TqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRgUmkUd9DA
 0gL/GwooLRa3FemVNbwdx2xpHqVuFgXXN84O+Q58ASlzqvS/hbcCG8ZSDJIdN0hsokxXzNC/
 luImc75QDBou5WLRn+HsLSZtzW/PW4SN2BqTTcETA8B4sHLu5guhwnPQM0lF7S6yMD2cQwc2
 BiDoTJ7hq0Ul9JO0aynu1vGmDmr4JPOS2bZ+zk7QEqarSZSNIL4Xrai+GP/3PdbCp2pdwGo6
 S1sd9el0MgCCpSElSqoSeoLHa206/vtDNE6qQMwd3XG32n9k0NPbby88xkjfhw3Y5ZslSvBP
 RWK41I5CIp7ZiPCUENhX26mI+IOpUQKPf3hU/3OY5J1fpF9HONs1Hg1PBP4M4zFvkwhj6Y7M
 JGXGftA7Er264w6klJapM9Ej9fHIxzSI0uIHPgXKDz9iNKjiIa9E+ttDbd3RrlRAFm4iAvU6
 c1DEMCB1g9SVubzCgGOr99DcwhWdyNqXcivwyCySgJlClc3cI3GI6GJqY7Nh6Q+90iovr6Sp
 yrkChMwJKTX3COZeW1mlUyPmJu2Dcog8hrXzAQnPE2j3DA4cJ2z4aIEH6bbjpF5nNGPOcVcF
 qFfE+3ZW6wnYm2eq1wggWzV8dUKmOKD3lnVYUJIoVEXIvZdeuA+0oa/IFaxpHFQUHHfWAlXi
 +TI6z43iKErH2xKZPs6otr2p79tlRDxQN5PYnY=
IronPort-HdrOrdr: A9a23:k2JGs68EPoC4SKKXMdFuk+D3I+orL9Y04lQ7vn2ZhyY7TiW9rb
 HKoB17726XtN9/YhsdcLy7VZVoBEmskaKdgrNhXotKPjOGhILAFugLhrcKgQeBJ8SUzIBgPM
 lbH5RWOZnZEUV6gcHm4AOxDtoshOWc/LvAv5a485+oJjsaEp2JKGxCe2CmLnE=
X-Talos-CUID: 9a23:9J8qTm78pVasIq/H5tssyw0xMZApL0TnxmbrB365EkByeITNYArF
X-Talos-MUID: =?us-ascii?q?9a23=3Akd9TgQ0VcDwxSmcw6v+5g72qBTUj0oP+LVE1i4k?=
 =?us-ascii?q?8qcypDnZxOhyt0i2MTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,263,1694736000"; 
   d="scan'208";a="10110212"
Received: from aer-iport-nat.cisco.com (HELO aer-core-6.cisco.com) ([173.38.203.22])
  by aer-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 16:09:46 +0000
Received: from localhost (ams3-vpn-dhcp2135.cisco.com [10.61.72.87])
        (authenticated bits=0)
        by aer-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39UG9jo8022939
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Oct 2023 16:09:46 GMT
Date:   Mon, 30 Oct 2023 18:09:45 +0200
From:   Ariel Miculas <amiculas@cisco.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, serge@hallyn.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: document the squashfs specific
 mount options
Message-ID: <oonydtkv6anpjbugjvqkp4byqlf3aiwkwf4g7y5w5tthivxomh@b4w4jyceaepz>
References: <20231029161924.50648-1-amiculas@cisco.com>
 <bd039dc7-cfe5-c210-b65e-0cba3186ee0b@squashfs.org.uk>
 <qgwx4cjswrhzxqijsosix437xyw3ifglv6uz2d3nq7whkjqueo@c5pzoqtoqtgb>
 <46d308b2-5e59-862d-b429-e6ee418bc61e@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d308b2-5e59-862d-b429-e6ee418bc61e@squashfs.org.uk>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.72.87, ams3-vpn-dhcp2135.cisco.com
X-Outbound-Node: aer-core-6.cisco.com
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/30 03:40PM, Phillip Lougher wrote:
> On 30/10/2023 12:57, Ariel Miculas wrote:
> > On 23/10/29 08:33PM, Phillip Lougher wrote:
> > > On 29/10/2023 16:19, Ariel Miculas wrote:
> > > > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, the "threads" mount option
> > > > can be used to specify the decompression mode: single-threaded,
> > > > multi-threaded, percpu or the number of threads used for decompression.
> > > > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set and
> > > > SQUASHFS_DECOMP_MULTI is set, the "threads" option can also be used to
> > > > specify the number of threads used for decompression. This mount option
> > > > is only mentioned in fs/squashfs/Kconfig, which makes it difficult to
> > > > find.
> > > > 
> > > > Another mount option available is "errors", which can be configured to
> > > > panic the kernel when squashfs errors are encountered.
> > > > 
> > > > Add both these options to the squashfs documentation, making them more
> > > > noticeable.
> > > > 
> > > > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> > > 
> > > Looks good to me.
> > > 
> > > Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
> > 
> > Unfortunately, it seems this is not quite correct either:
> > There is the config option SQUASHFS_MOUNT_DECOMP_THREADS:
> > ```
> > 	bool "Add the mount parameter 'threads=' for squashfs"
> > 	depends on SQUASHFS
> > 	depends on SQUASHFS_DECOMP_MULTI
> > 	default n
> > 	help
> > 	  Use threads= to set the decompression parallel mode and the number of threads.
> > 	  If SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
> > 	      threads=<single|multi|percpu|1|2|3|...>
> > 	  else
> > 	      threads=<2|3|...>
> > 	  The upper limit is num_online_cpus() * 2.
> > ```
> > that depends on SQUASHFS_DECOMP_MULTI.
> > So I think I should take my v1 patch and specify that the "threads="
> > mount option depends on SQUASHFS_MOUNT_DECOMP_THREADS. There's no need
> > to specify SQUASHFS_DECOMP_MULTI, because SQUASHFS_MOUNT_DECOMP_THREADS
> > already depends on it.
> 
> Sorry, you have to specify SQUASHFS_DECOMP_MULTI to be able to specify
> SQUASHFS_MOUNT_DECOMP_THREADS if SQUASHFS_DECOMP_BY_MOUNT is unselected.
Agree.
> 
> Just try it, do make menuconfig, ensure SQUASHFS_CHOICE_DECOMP_BY_MOUNT
> is unselected, select Single threaded decompression and you won't be
> able to specify SQUASHFS_MOUNT_DECOMP_THREADS.
True.
> 
> That was the point of my review. What bit don't you understand?
But SQUASHFS_DECOMP_MULTI is not enough, you need to specify
SQUASHFS_MOUNT_DECOMP_THREADS in order to use the "threads=" mount
option.
So instead of saying
```
If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set and
SQUASHFS_DECOMP_MULTI is set:
```
wouldn't it be right to actually say:
```
If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set and
SQUASHFS_MOUNT_DECOMP_THREADS is set:
```?

As you've mentioned, you could only set SQUASHFS_MOUNT_DECOMP_THREADS
when SQUASHFS_DECOMP_MULTI is selected. That happens in two cases:
* either SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, in which case it also
  selects SQUASHFS_MOUNT_DECOMP_THREADS
* either SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set,
  SQUASHFS_DECOMP_MULTI is set and SQUASHFS_MOUNT_DECOMP_THREADS is also
  set

So I wouldn't even mention SQUASHFS_DECOMP_MULTI in the documentation,
only SQUASHFS_MOUNT_DECOMP_THREADS, because the latter always depends on
the former. And the "threads=" mount option is only available when
SQUASHFS_MOUNT_DECOMP_THREADS is set (which is the configuration I've
missed in v1 and v2).

Regards,
Ariel
> 
> Phillip
> 
> > What do you think?
> > 
> > Regards,
> > Ariel
> > 
> 
