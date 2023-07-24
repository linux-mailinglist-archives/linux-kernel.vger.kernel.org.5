Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD443760145
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGXVg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGXVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:36:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F3126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:36:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so70385691fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690234611; x=1690839411;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl41eJ1WC6ILldSjNqzW1R/MpU0yZbIUTyos3W/vR0o=;
        b=J4CUcw3+5oLla8TJKoKYSVEPfeoBbb8HGbt1EaSjZ5ZYN0cwUeijDPUg754M8TWgKq
         i9EBAjICG+W2jNI6eXpwG/Co/CfB4nPkXtHKfV4vAXs8zs1d+e47Twh+4/O1k8ZQGPKb
         i0GyJMUdcXrSAuHZLaWZ2UC9hk2OSsDLE84BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234611; x=1690839411;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl41eJ1WC6ILldSjNqzW1R/MpU0yZbIUTyos3W/vR0o=;
        b=A/YhTUWP2/rzqueuVQaETTU0EQbBJhLS9y6H+ANz6rZt139QWSdoQVcu45tc5QcxeU
         eu5xPIRMhN3fd0GeN3UmRVui8QtxTu1Tp6Psa8km9deoJecjzzzTNqyHC/cG68PgEQJV
         o9feyJm3csltKUfBmMaKzJqIlFPhQAMgopO6E8KHAjwq/J+tlTWU/1+vnpW11F8c2IUl
         Sh+NWxaup5yTSHop2KlX6/JgEppTJAgZNZupkGxkqYTsnxIGBBnrgo+MOTX1eeNsP7yX
         w4jctN/PRDqi7FlzcKZ9CG+Z5ktjhvyb8soIei6bhO3/2fg/ZpmRdpt/cCbJp7kZbSOL
         pAlw==
X-Gm-Message-State: ABy/qLZ1kcQJGxBtnsjEdpHbJUFYPqT2/FdpEZSg5L9uHmw5AaMzS/LG
        UnH2ymjv+jgvbZtEe67NWsbbSQ==
X-Google-Smtp-Source: APBJJlEIBhBaRS5nkCMsUEUORF8/eFhcX7G26UgE+SkpTlX6AirHvLESoYGQK4lOK9BQqV+Y87oGoQ==
X-Received: by 2002:a2e:80cd:0:b0:2b6:d790:d1a3 with SMTP id r13-20020a2e80cd000000b002b6d790d1a3mr6457024ljg.11.1690234611479;
        Mon, 24 Jul 2023 14:36:51 -0700 (PDT)
Received: from fastly.com ([188.225.251.141])
        by smtp.gmail.com with ESMTPSA id hn32-20020a05600ca3a000b003f9bd9e3226sm11447112wmb.7.2023.07.24.14.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jul 2023 14:36:51 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:36:48 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230724213647.GA48335@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
 <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:27:43PM +0100, Edward Cree wrote:
> On 23/07/2023 16:06, Joe Damato wrote:
> > Greetings:
> > 
> > While attempting to get the RX flow hash key for a custom RSS context on
> > my mlx5 NIC, I got an error:
> > 
> > $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> > Cannot get RX network flow hashing options: Invalid argument
> > 
> > I dug into this a bit and noticed two things:
> > 
> > 1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
> > not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
> > that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
> > is patch 1/2.
> 
> As I see it, this is a new feature, not a fix, so belongs on net-next.
> (No existing driver accepts FLOW_RSS in ETHTOOL_SRXFH's cmd->flow_type,
>  which is just as well as if they did this would be a uABI break.)
> 
> Going forward, ETHTOOL_SRXFH will hopefully be integrated into the new
>  RSS context kAPI I'm working on[1], so that we can have a new netlink
>  uAPI for RSS configuration that's all in one place instead of the
>  piecemeal-grown ethtool API with its backwards-compatible hacks.
> But that will take a while, so I think this should go in even though
>  it's technically an extension to legacy ethtool; it was part of the
>  documented uAPI and userland implements it, it just never got
>  implemented on the kernel side (because the initial driver with
>  context support, sfc, didn't support SRXFH).
> 
> > 2. mlx5 defaulted to RSS context 0 for both ETHTOOL_{G,S}RXFH paths. I
> > have modified the driver to support custom contexts for both paths. It
> > is now possible to get and set the flow hash key for custom RSS contexts
> > with mlx5. This is patch 2/2.
> 
> My feeling would be that this isn't a Fix either, but not my place to say.

Thanks for the context above; I'll let the Mellanox folks weigh in on what
they think about the code in the second patch before I proceed.

I suspect that you are probably right and that net-next might be a more
appropriate place for this. If the code is ack'd by Mellanox (and they
agree re: net-next), I can re-send this series to net-next with the Fixes
removed and the Ack's added.
