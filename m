Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F617C9779
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJOAzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 20:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 20:55:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D50CC;
        Sat, 14 Oct 2023 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=buvwUM+XiSCd2oFM3rzPwIQXJWev79VEmd/6ZAGstBE=; b=oHB5GN3AQhXonpj3gZeVdTS9S9
        t5hxo04NmbJrxNy9T67Lj3Wgfz0T4z/NrPI3dDwiqF8kbUOS8Yr2Cd5dl6x0bUTYu9mHkhkAC1x4H
        y6cyZhzBZb4qcerrORHd9E9PHtapx6noke3iX+miXAeVhTaeFf8K4o6Y7KLIjX0MSbxQMtbHwQWL4
        ZbAAMtvPhyfdhSMZifVT9dht6K3YYN6RG4aVxoIMtI46iARRmzFapYAepOZBExQo1G9ohd/0j+UeK
        P7bfLmiUe+gCiwCvUXYVekIqHoxAY/7ytUZhOhd0SEKLdd09EXs+JErrRAOa8VNRwzBfFu9ggarlG
        KhZVcKVw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrpPp-001KfZ-1t;
        Sun, 15 Oct 2023 00:55:33 +0000
Date:   Sat, 14 Oct 2023 17:55:30 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] Documentation: netconsole: add support
 for cmdline targets
Message-ID: <ZSs4gvm8fx+BpfcQ@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20231012111401.333798-1-leitao@debian.org>
 <20231012111401.333798-5-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012111401.333798-5-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 04:14:01AM -0700, Breno Leitao wrote:
> With the previous patches, there is no more limitation at modifying the
> targets created at boot time (or module load time).
> 
> Document the way on how to create the configfs directories to be able to
> modify these netconsole targets.
> 
> The design discussion about this topic could be found at:
> https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  Documentation/networking/netconsole.rst | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index 7a9de0568e84..390730a74332 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -99,9 +99,6 @@ Dynamic reconfiguration:
>  Dynamic reconfigurability is a useful addition to netconsole that enables
>  remote logging targets to be dynamically added, removed, or have their
>  parameters reconfigured at runtime from a configfs-based userspace interface.
> -[ Note that the parameters of netconsole targets that were specified/created
> -from the boot/module option are not exposed via this interface, and hence
> -cannot be modified dynamically. ]
>  
>  To include this feature, select CONFIG_NETCONSOLE_DYNAMIC when building the
>  netconsole module (or kernel, if netconsole is built-in).
> @@ -155,6 +152,25 @@ You can also update the local interface dynamically. This is especially
>  useful if you want to use interfaces that have newly come up (and may not
>  have existed when netconsole was loaded / initialized).
>  
> +Netconsole targets defined at boot time (or module load time) with the
> +`netconsole=` param are assigned the name `cmdline<index>`.  For example, the
> +first target in the parameter is named `cmdline0`.  You can control and modify
> +these targets by creating configfs directories with the matching name.
> +
> +Let's suppose you have two netconsole targets defined at boot time::
> +
> + netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc;4444@10.0.0.1/eth1,9353@10.0.0.3/12:34:56:78:9a:bc
> +
> +You can modify these targets in runtime by creating the following targets::
> +
> + mkdir cmdline0
> + cat cmdline0/remote_ip
> + 10.0.0.2
> +
> + mkdir cmdline1
> + cat cmdline1/remote_ip
> + 10.0.0.3
> +
>  Extended console:
>  =================
>  
> -- 
> 2.34.1
> 

-- 

	f/8 and be there.

			http://www.jlbec.org/
			jlbec@evilplan.org
