Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7A7DBE31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjJ3Qmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjJ3Qmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:42:49 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3A10C;
        Mon, 30 Oct 2023 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5604; q=dns/txt; s=iport;
  t=1698684157; x=1699893757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ff83lpI/B4atr4jjrel8J+Woupc3elDH47etE1uLXw=;
  b=DMmEUe040egEbYG8YGFQXv4dG/9ztyZn6n4phLloBek16v2jBt6jvSbp
   FeMUE/vaEzkfrFR6kdO0J1xTgltbIZULGLF74ziU6zURAXfOYv3MsmmKA
   mQekuf8XZw8XoPQm1J2dKr+gHjJI7u9vzTf/ru4aIHqI16O93jiouoG/W
   U=;
X-CSE-ConnectionGUID: 87bFVbZzSN+Xx5pcbs8gFg==
X-CSE-MsgGUID: uXOk0WGnRFyKakXV7HhVQg==
X-IPAS-Result: =?us-ascii?q?A0BhAQB+3D9llxbLJq1agQmBT4QILhJIjU6IYgOSWYslg?=
 =?us-ascii?q?SUDVg8BAQENAQFEBAEBgXIBgxMChx4nNAkOAQIEAQEBAQMCAwEBAQEBAQECA?=
 =?us-ascii?q?QEFAQEBAgEHBBQBAQEBAQEBATcFEDWFdYZNAQIDOj8QCxguVwYTCIJ2gl8Dq?=
 =?us-ascii?q?A14gTSBAbMngWiBSIgKAYoGQoFJRIQ/PoQbhkkiBIZkKIFdBw4uBzKBCgwJg?=
 =?us-ascii?q?QOCejUpjEJeIkdwGwMHA1grECsHBDAbBwYJFhgVJQZRAgItJAkTEj4EgWWBU?=
 =?us-ascii?q?QqBAz8PDhGCQyICBzY2GUsrgjAJFQw0TXYQKgQUF4ERBGofFR4SJRESFw0DC?=
 =?us-ascii?q?HYdAhEjPAMFAwQ0ChUNCyEFFEMDRAZKCwMCGgUDAwSBNgUNHgIQGgYNJwMDG?=
 =?us-ascii?q?U0CEBQDHh0DAwYDCzEDMIEeDFoDbB82CTwPDB8COQ0pKgI7GgNEHUADeD01F?=
 =?us-ascii?q?BttnlmCEFsGYgIPAjaBAxKBBAoBHcUmhBaTFI4MSQODa4xyhjaSUZg+ow0Ph?=
 =?us-ascii?q?QwCBAYFAhaBYzqBWzMaCBsVgyJSGQ+OLA0Jk1FCMjsCBwsBAQMJiG+CWwEB?=
IronPort-Data: A9a23:FWNQXamz71VXIcGJlxmpltLo5gwFJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMUGvVP/3YZDDyKohzO9y/8E1QuJCBn9MwGVNtqylmEltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5a31GONgWYuaTtMsPrb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvcSe1n/KZ/V/9VTjc06h2B0stbYI29bMiaY1O3
 aRwxDElZx2Zwumx2r/+E69nh98oK4/gO4Z3VnNIlG6CS612B8qbGOOQv7e03x9o7ixKNf/bZ
 sEEbTN0RB/BeBZIfFwQDfrSmc/52iOnKGcEwL6TjbcHxGuL8yN36pb8E9PWSuLVZcVrp0nN8
 woq+EygUk1Fa7Rz0wGt9nOqm/+Kni7hXo8WPKO3++Qsg1CJwGEXThoMWjOTqv6jgEOic9ZAL
 QoS9zZGhbM/7kOmZtn0WxmppjiPuRt0c9NTC+gS7ACL17qR7QGEAGQNUj9GbpohrsBebTgr0
 EKZ2t/uDhRxv7CPD3GQ7LGZqXW1Iyd9BXcCZCsATBMt+MD+qZozgAmJScxsVrO25uAZAhn5z
 irPrTA5nalWi8cXka665lvAxTmro/AlUzLZ+C2HAWiL0AlLdrWDJLy4tEDQ5+0QI6iWGwzpU
 Gc/p+CS6+UHDJeonSOLQfkQELzB2xpjGGCD6bKIN8RxnwlB60JPbqgNumogdRcB3tIsJGWwO
 h67VRZ5vsc7AZe8UUNgS6SVYyjA5YHkENn/W7jvctNCCnSaXFbcpXwGiaK48WTgjk8omKczU
 ap3kPpA715HV8yLLxLvGY/xNIPHIAhlnAs/orihlnyaPUK2PiL9dFv8GALmghoFxK2Fuh7J1
 N1UKtGHzR5SOMWnPHiHr9ZPdwtbdSBibXwTlyCxXrPSSuaBMD95Y8I9PZt6E2CYt/0Pz7yRr
 i3VtrFwkQSh1RUr1jlmmlg6OO+wAv6TXFowPDcnOh6zymM/bIO0hJrzhLNpFYTLANdLlKYuJ
 9FcIp3oKq0WGlz6F8E1MMCVQHpKL0/w22pj/kONPVACQnKXb1WSpIK6LlOxqnJm4+jenZJWn
 oBMHzjzGfIrLzmOxu6PAB5z5ztdZUQgpd8=
IronPort-HdrOrdr: A9a23:p+L1LaGEYUccSKitpLqEx8eALOsnbusQ8zAXPo5KJiC9Vvbo8v
 xG/c5rtyMc5wx6ZJhNo7290ey7MBfhHP1OkOos1NWZPTUO0VHAROpfBMnZowEIcBeRygcy78
 tdWpk7IMHsDFR8kMbx6BS1HpId2tWdmZrY4ts3CxxWPHhXg2YK1XYeNjqm
X-Talos-CUID: 9a23:B82pBm1MdgB68mU+DCnwvbxfSp8vXEPX/mXrBQyIGTtxQ7eOGVC+9/Yx
X-Talos-MUID: 9a23:mB9fBArxGaX9gqJe7r8ezyxSE8Qw3IuoMm4cspwFi/fbFSxOAjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,263,1694736000"; 
   d="scan'208";a="9420324"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 16:42:33 +0000
Received: from localhost (ams3-vpn-dhcp2135.cisco.com [10.61.72.87])
        (authenticated bits=0)
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39UGgWmV010699
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Oct 2023 16:42:33 GMT
Date:   Mon, 30 Oct 2023 18:42:32 +0200
From:   Ariel Miculas <amiculas@cisco.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, serge@hallyn.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: document the squashfs specific
 mount options
Message-ID: <nlpgfo5g4jzbb5hc2wu5a3mlnipgbjki7fqcgwe5jknxjmgbwa@2tpkg35xsuy4>
References: <20231029161924.50648-1-amiculas@cisco.com>
 <bd039dc7-cfe5-c210-b65e-0cba3186ee0b@squashfs.org.uk>
 <qgwx4cjswrhzxqijsosix437xyw3ifglv6uz2d3nq7whkjqueo@c5pzoqtoqtgb>
 <46d308b2-5e59-862d-b429-e6ee418bc61e@squashfs.org.uk>
 <oonydtkv6anpjbugjvqkp4byqlf3aiwkwf4g7y5w5tthivxomh@b4w4jyceaepz>
 <332ff885-f621-883a-696a-e8247fb43ecc@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332ff885-f621-883a-696a-e8247fb43ecc@squashfs.org.uk>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.72.87, ams3-vpn-dhcp2135.cisco.com
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/30 04:28PM, Phillip Lougher wrote:
> On 30/10/2023 16:09, Ariel Miculas wrote:
> > On 23/10/30 03:40PM, Phillip Lougher wrote:
> > > On 30/10/2023 12:57, Ariel Miculas wrote:
> > > > On 23/10/29 08:33PM, Phillip Lougher wrote:
> > > > > On 29/10/2023 16:19, Ariel Miculas wrote:
> > > > > > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, the "threads" mount option
> > > > > > can be used to specify the decompression mode: single-threaded,
> > > > > > multi-threaded, percpu or the number of threads used for decompression.
> > > > > > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set and
> > > > > > SQUASHFS_DECOMP_MULTI is set, the "threads" option can also be used to
> > > > > > specify the number of threads used for decompression. This mount option
> > > > > > is only mentioned in fs/squashfs/Kconfig, which makes it difficult to
> > > > > > find.
> > > > > > 
> > > > > > Another mount option available is "errors", which can be configured to
> > > > > > panic the kernel when squashfs errors are encountered.
> > > > > > 
> > > > > > Add both these options to the squashfs documentation, making them more
> > > > > > noticeable.
> > > > > > 
> > > > > > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> > > > > 
> > > > > Looks good to me.
> > > > > 
> > > > > Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
> > > > 
> > > > Unfortunately, it seems this is not quite correct either:
> > > > There is the config option SQUASHFS_MOUNT_DECOMP_THREADS:
> > > > ```
> > > > 	bool "Add the mount parameter 'threads=' for squashfs"
> > > > 	depends on SQUASHFS
> > > > 	depends on SQUASHFS_DECOMP_MULTI
> > > > 	default n
> > > > 	help
> > > > 	  Use threads= to set the decompression parallel mode and the number of threads.
> > > > 	  If SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
> > > > 	      threads=<single|multi|percpu|1|2|3|...>
> > > > 	  else
> > > > 	      threads=<2|3|...>
> > > > 	  The upper limit is num_online_cpus() * 2.
> > > > ```
> > > > that depends on SQUASHFS_DECOMP_MULTI.
> > > > So I think I should take my v1 patch and specify that the "threads="
> > > > mount option depends on SQUASHFS_MOUNT_DECOMP_THREADS. There's no need
> > > > to specify SQUASHFS_DECOMP_MULTI, because SQUASHFS_MOUNT_DECOMP_THREADS
> > > > already depends on it.
> > > 
> > > Sorry, you have to specify SQUASHFS_DECOMP_MULTI to be able to specify
> > > SQUASHFS_MOUNT_DECOMP_THREADS if SQUASHFS_DECOMP_BY_MOUNT is unselected.
> > Agree.
> > > 
> > > Just try it, do make menuconfig, ensure SQUASHFS_CHOICE_DECOMP_BY_MOUNT
> > > is unselected, select Single threaded decompression and you won't be
> > > able to specify SQUASHFS_MOUNT_DECOMP_THREADS.
> > True.
> > > 
> > > That was the point of my review. What bit don't you understand?
> > But SQUASHFS_DECOMP_MULTI is not enough, you need to specify
> > SQUASHFS_MOUNT_DECOMP_THREADS in order to use the "threads=" mount
> > option.
> > So instead of saying
> > ```
> > If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set and
> > SQUASHFS_DECOMP_MULTI is set:
> > ```
> > wouldn't it be right to actually say:
> > ```
> > If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set and
> > SQUASHFS_MOUNT_DECOMP_THREADS is set:
> > ```?
> > 
> > As you've mentioned, you could only set SQUASHFS_MOUNT_DECOMP_THREADS
> > when SQUASHFS_DECOMP_MULTI is selected. That happens in two cases:
> > * either SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, in which case it also
> >    selects SQUASHFS_MOUNT_DECOMP_THREADS
> > * either SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set,
> >    SQUASHFS_DECOMP_MULTI is set and SQUASHFS_MOUNT_DECOMP_THREADS is also
> >    set
> > 
> > So I wouldn't even mention SQUASHFS_DECOMP_MULTI in the documentation,
> > only SQUASHFS_MOUNT_DECOMP_THREADS, because the latter always depends on
> > the former. And the "threads=" mount option is only available when
> > SQUASHFS_MOUNT_DECOMP_THREADS is set (which is the configuration I've
> > missed in v1 and v2).
> > 
> 
> You seem determined to create an unpleasant argument here by trying to argue
> your first patch was correct, and I, as merely the maintainer, can't tell
> you to change it to how I want it.
I'm not trying to argue that my first patch is correct, I'm sorry if it
seems this way. I'm trying to argue that my v2 patch is also missing the
mention of SQUASHFS_MOUNT_DECOMP_THREADS.
> 
> If, as you pointed out in your first patch, the purpose is to
> document the mount options, then the fact that threads=xxx
> option depends on SQUASHFS_DECOMP_MULTI being selected is
> important, and should be mentioned.
Ok, I understand this. I also think it's important to mention
SQUASHFS_MOUNT_DECOMP_THREADS, which was an oversight from my part.
> 
> I have accepted your V2.  If you want to withdraw it now, please
> do so.  But I will not accept further patches from you, nor
> respond to any more of your emails.
> 
> It is never a good look to argue with the maintainer, when I am
> trying to help you make your patch better. You attitude means this
> has been a waste of my time so far.
I didn't want to argue against your suggestion, I did appreciate it and
I have sent a v2 patch implementing it. I only wanted to point out a
missing configuration option that, in my opinion, should also be part of
the documentation. If you think that's not the case, let me know.

Regards,
Ariel
> 
> Phillip
> 
> > Regards,
> > Ariel
> > > 
> > > Phillip
> > > 
> > > > What do you think?
> > > > 
> > > > Regards,
> > > > Ariel
> > > > 
> > > 
> 
