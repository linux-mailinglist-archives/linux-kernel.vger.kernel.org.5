Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF997DBA30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjJ3M5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3M5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:57:07 -0400
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5EA6;
        Mon, 30 Oct 2023 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1832; q=dns/txt; s=iport;
  t=1698670624; x=1699880224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zPtDsmCSY9ADBIfJbSTE3Dig8/XOZBzisQSxFvjQIw=;
  b=Kq2T2tLYRsXPn2L7HNznjoRvcxkO6bKTJGqX3E0zzvKDLDNkNc7VG8gg
   N60JQY2gt9mBrPOS8ChNYhdUIj4b0UFQsSmiKNTYwmnGlFGw59LQd8cdE
   BFHKlpExPs9Fs24hvsqwFtvU4M4iBc0fJ5HeeptOZthujXBxaA6lcrdW+
   U=;
X-CSE-ConnectionGUID: 3v9MgFfjTfmbMDJpeD1m9g==
X-CSE-MsgGUID: ZtzR6g/rQk2oGbtqdJmkng==
X-IPAS-Result: =?us-ascii?q?A0CNAQAapz9llxbLJq1aHgEBCxIMQIFEC4QILhJIjU6IZ?=
 =?us-ascii?q?ZJZiyWBJQNWDwEBAQ0BAUQEAQGBcgGDEwKHHCc0CQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQIBAQUBAQECAQcEFAEBAQEBAQEBNwUQNYV1hk0BAgM6PxALGC5XBhMIg?=
 =?us-ascii?q?naCXwOnOXiBNIEBsyeBaIFIiAoBigZCgUlEhD8+hBuGSSIEhmQogV0VLgcyg?=
 =?us-ascii?q?QoMCYEDgy8pjD5eIkdwGwMHA1grECsHBDAbBwYJFhgVJQZRAgItJAkTEj4Eg?=
 =?us-ascii?q?WWBUQqBAz8PDhGCQyICBzY2GUsrgjAJFQw0TXYQKgQUF4ERBGofFR4SJRESF?=
 =?us-ascii?q?w0DCHYdAhEjPAMFAwQ0ChUNCyEFFEMDRAZKCwMCGgUDAwSBNgUNHgIQGgYNJ?=
 =?us-ascii?q?wMDGU0CEBQDHh0DAwYDCzEDMIEeDFoDbB82CTwPDB8COQ0pKgJPA0QdQAN4P?=
 =?us-ascii?q?TUUG22eV4NTAg84gRWBD8VDhBahIEkDlxOSUZg+qCgCBAYFAhaBYzqBWzMaC?=
 =?us-ascii?q?BsVgyJSGQ+OOZNaQjI7AgcLAQEDCYhvglsBAQ?=
IronPort-Data: A9a23:zyoycaKRhXcLaZuoFE+RVpUlxSXFcZb7ZxGr2PjKsXjdYENSgzZWx
 jRNCGyGbPqDMDbwKowjO4yw/B8OupDTyYI1QAYd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2Usajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFfZYqZrID3a9jcKWxWjqUWPh76xrXU5jaOX0+s4vaY1P3
 fUVMnUGaQqOwrvshrm6UeJrwM8kKaEHPqtG5SomlmGfV659B8qZK0nJzYcwMDMYj8VPFuvab
 tExYjt0ZxOGaBpKUrsSIMtmxb/42CGmG9FegGCJt5Bp7C/J9Q8r15fnLMPZWNmJQ8oAyy50o
 UqfrzimXXn2Lue3zTuD72LpheLVmy7/cJwdGaf+9fNwhlCXgGsJB3U+Xlyhq/SlokqhXZRZJ
 lB80jEjt6c/3EyiSt3sWVuzp3vslhcfQ994F+w89RHIxK3J5QqQGmkDSHhGctNOnMs3QyE6k
 1OOlPv3CjF19r6YU3SQ8vGTtzzaETAVLGsGZDcsVhIY6sLjrpp1iQjACMtgeJNZlfX8FCu1w
 iiNtjR7gbwPy8UKzK68u1vAhlpAu6QlUCZu+FTyUUyr7D93YYSAS66w5HSC6KdPedPxoka6g
 FAInM2X7eYrBJ6LlTCQTOhlIF1Pz6vaWNE7qQM/d6TN5whB6Fb+J9sOsWEWyFNBb5xdI26Bj
 Fr741s52XNFAJe9RYlTC25bI+0uyKX6GJzeSvnYBjalSsEqLVLvEM1GS0qdwWfpmU4g+ZzT2
 Kt3k+7xUx726ow+klJaotvxN5dwn0jSIkuJHPjGI+yPi+b2WZJsYe5t3KGyRu449riYhw7e7
 sxSMcCHoz0GDryuPHGLq9VCdQhTRZTeOXwQg5EGHgJkClQ+cFzN99eKqV/cU9U/xv8MxrugE
 o+VAxEGmDITekEr2S3TOiw8N9sDrL50rGkwOmQ3LE201n04CbtDH49BH6bbiYIPrbQ5pdYtF
 qFtU5zZUpxypsHvpm11gW/V99c5KnxGRGumYkKYXdTIV8c6GFaVooC+L2MCNkAmV0KKiCf3m
 JX4viuzfHbJb10K4Br+AB53826MgA==
IronPort-HdrOrdr: A9a23:sOASPaO7b/1mGcBcTrWjsMiBIKoaSvp037BF7StMoHBuH/Bw6f
 rFoB1z73adtN97Yh4dcL67VJW9fQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A/ODYyGmZppo3n0H9DwscoG1TqBDXOSbDnVLfDUG?=
 =?us-ascii?q?6NWhsQpi5a0ed1PphwsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQ50t3A+5BxE65WBUVmyfM+iQf/V08Z7wBwcXqJZ?=
 =?us-ascii?q?cvOaOKTV8GTKeijviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,263,1694736000"; 
   d="scan'208";a="10108601"
Received: from aer-iport-nat.cisco.com (HELO aer-core-12.cisco.com) ([173.38.203.22])
  by aer-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:57:02 +0000
Received: from localhost (ams3-vpn-dhcp2135.cisco.com [10.61.72.87])
        (authenticated bits=0)
        by aer-core-12.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39UCv137126740
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Oct 2023 12:57:02 GMT
Date:   Mon, 30 Oct 2023 14:57:00 +0200
From:   Ariel Miculas <amiculas@cisco.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, serge@hallyn.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: document the squashfs specific
 mount options
Message-ID: <qgwx4cjswrhzxqijsosix437xyw3ifglv6uz2d3nq7whkjqueo@c5pzoqtoqtgb>
References: <20231029161924.50648-1-amiculas@cisco.com>
 <bd039dc7-cfe5-c210-b65e-0cba3186ee0b@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd039dc7-cfe5-c210-b65e-0cba3186ee0b@squashfs.org.uk>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.72.87, ams3-vpn-dhcp2135.cisco.com
X-Outbound-Node: aer-core-12.cisco.com
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/29 08:33PM, Phillip Lougher wrote:
> On 29/10/2023 16:19, Ariel Miculas wrote:
> > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, the "threads" mount option
> > can be used to specify the decompression mode: single-threaded,
> > multi-threaded, percpu or the number of threads used for decompression.
> > When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set and
> > SQUASHFS_DECOMP_MULTI is set, the "threads" option can also be used to
> > specify the number of threads used for decompression. This mount option
> > is only mentioned in fs/squashfs/Kconfig, which makes it difficult to
> > find.
> > 
> > Another mount option available is "errors", which can be configured to
> > panic the kernel when squashfs errors are encountered.
> > 
> > Add both these options to the squashfs documentation, making them more
> > noticeable.
> > 
> > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> 
> Looks good to me.
> 
> Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

Unfortunately, it seems this is not quite correct either:
There is the config option SQUASHFS_MOUNT_DECOMP_THREADS:
```
	bool "Add the mount parameter 'threads=' for squashfs"
	depends on SQUASHFS
	depends on SQUASHFS_DECOMP_MULTI
	default n
	help
	  Use threads= to set the decompression parallel mode and the number of threads.
	  If SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
	      threads=<single|multi|percpu|1|2|3|...>
	  else
	      threads=<2|3|...>
	  The upper limit is num_online_cpus() * 2.
```
that depends on SQUASHFS_DECOMP_MULTI.
So I think I should take my v1 patch and specify that the "threads="
mount option depends on SQUASHFS_MOUNT_DECOMP_THREADS. There's no need
to specify SQUASHFS_DECOMP_MULTI, because SQUASHFS_MOUNT_DECOMP_THREADS
already depends on it.
What do you think?

Regards,
Ariel

