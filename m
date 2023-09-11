Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A140D79A4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjIKHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjIKHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:46:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAEFCEC;
        Mon, 11 Sep 2023 00:46:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c1f7f7151fso27742855ad.1;
        Mon, 11 Sep 2023 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694418300; x=1695023100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTJcbR5B3QbjXBbH3ZJia+QU1wuB4FL3GXZYaYHzg5k=;
        b=bRCdd5zkomGPCWCMk4KrTEiQGHToOVzsYSH0QxF2uqp7lV2gnns+XUCRT58mv8DuF1
         TtXA+4kH2zlsdhcBsRcd5Z9lNKeQ08KV32zVxHsTv8ulyKNoF7HqhjO3q5ayuY3I5nrm
         l7g75Za57HLa7PFahrhwekqGhsUVS+yBxSR0nzrn/NqbElM9+I201u9zqiq8qHXoMTEd
         LRWiFgzowROBjoXnepvvs0Pzo7rOLbSSeYL9UvRxWTbjqDuSCgArahwjurgvh7dqYtBN
         IH0PFALvQhvZghGkEWS2I9oas5RNxz7/k+EdgCldUaunx7TE0x9ETE7GxphV3C5ARkTu
         FTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418300; x=1695023100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTJcbR5B3QbjXBbH3ZJia+QU1wuB4FL3GXZYaYHzg5k=;
        b=Pc9QJGSLoM2MpVg+/r+OnkwKNZjhdzV1jDvG+b84R0vNXqaY30mv8/+V6MU7eEmmcn
         Rxws3Ct0vDa1nuRHIcy8tv2pdjPRaapIenOjw0GPPGztI70e9FAEl+SbIdZcl8dpbHwy
         60VJRMXC1hecRlJTawLDjiuXHTgw1ujTfGgw11ocpBWfYaHI0eMzBCvSfaEo7cqzCKJa
         jhUoCJDw+N+08hgx2a+OojPjOIrSiCX17OxJ7glaMMcEkCNknSfygPazABDjdWOXsUVK
         Rk2PGLJcPPdUBb97D4xihHdeM5qrJK8gnkBl+jdUI1WkQg4al2WNt1QdXeD2qrPoyxA1
         nWVA==
X-Gm-Message-State: AOJu0YyuS/WQJsXkXce75KOwlTP7qsY4cZaz5SM+D48i1xzSJ8Wlg37F
        31gIWk8bVRRBaeEFUQkHyHk=
X-Google-Smtp-Source: AGHT+IEKXBNrec06I/22jtKTgGLTWYDYV0crTY6ivaU0cA7BFIdw6TWg70sJOSm1Uohi/moZx4IKUg==
X-Received: by 2002:a17:903:495:b0:1c3:308b:ecb9 with SMTP id jj21-20020a170903049500b001c3308becb9mr6059122plb.11.1694418299906;
        Mon, 11 Sep 2023 00:44:59 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001b9da8b4eb7sm5749119plb.35.2023.09.11.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:44:58 -0700 (PDT)
Date:   Mon, 11 Sep 2023 15:44:54 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZP7Fdq1wgzzTftnE@Laptop-X1>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziyang,

You patch status is Changes Requested[1]. I think you need to repost this
patch.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20230905081056.3365013-1-william.xuanziyang@huawei.com/

Thanks
Hangbin
On Tue, Sep 05, 2023 at 04:10:56PM +0800, Ziyang Xuan wrote:
> Get a null-ptr-deref bug as follows with reproducer [1].
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000228
> ...
> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x82/0x150
>  ? exc_page_fault+0x69/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>  neigh_connected_output+0xb2/0x100
>  ip6_finish_output2+0x1cb/0x520
>  ? nf_hook_slow+0x43/0xc0
>  ? ip6_mtu+0x46/0x80
>  ip6_finish_output+0x2a/0xb0
>  mld_sendpack+0x18f/0x250
>  mld_ifc_work+0x39/0x160
>  process_one_work+0x1e6/0x3f0
>  worker_thread+0x4d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe5/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
> 
> [1]
> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
> $ ip link add name t-dummy type dummy
> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
> $ ip link add name t-nlmon type nlmon
> $ ip link set t-nlmon master team0
> $ ip link set t-nlmon nomaster
> $ ip link set t-dummy up
> $ ip link set team0 up
> $ ip link set t-dummy.100 down
> $ ip link set t-dummy.100 master team0
> 
> When enslave a vlan device to team device and team device type is changed
> from non-ether to ether, header_ops of team device is changed to
> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
> for vlan->real_dev in vlan_dev_hard_header() because team device is not
> a vlan device.
> 
> Assign eth_header_ops to header_ops of team device when its type is changed
> from non-ether to ether to fix the bug.
> 
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
> v3:
>   - Export eth_header_ops to fix modpost error.
> v2:
>   - Just modify header_ops to eth_header_ops not use ether_setup().
> ---
>  drivers/net/team/team.c | 5 ++++-
>  net/ethernet/eth.c      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..12fb5f4cff06 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops = {
>  static void team_setup_by_port(struct net_device *dev,
>  			       struct net_device *port_dev)
>  {
> -	dev->header_ops	= port_dev->header_ops;
> +	if (port_dev->type == ARPHRD_ETHER)
> +		dev->header_ops	= &eth_header_ops;
> +	else
> +		dev->header_ops	= port_dev->header_ops;
>  	dev->type = port_dev->type;
>  	dev->hard_header_len = port_dev->hard_header_len;
>  	dev->needed_headroom = port_dev->needed_headroom;
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 2edc8b796a4e..157833509adb 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -347,6 +347,7 @@ const struct header_ops eth_header_ops ____cacheline_aligned = {
>  	.cache_update	= eth_header_cache_update,
>  	.parse_protocol	= eth_header_parse_protocol,
>  };
> +EXPORT_SYMBOL(eth_header_ops);
>  
>  /**
>   * ether_setup - setup Ethernet network device
> -- 
> 2.25.1
> 
