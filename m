Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4397623E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGYUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGYUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:47:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27BE193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:47:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-316feb137a7so5478454f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690318043; x=1690922843;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmHZQ9ca3QHt8MEuJo/iyae9grobgo7Zqpkp40Wn1M0=;
        b=lgfMQw3veIdghW9Yl7OpwneqlZXLUat4NwHjoq63ji8EGZunt7c6/VdjtwpPKMA+/b
         xe3A7RvGIoTqBuxT7xQl9Pq0VPoKqNOCYWkjGsD4SCsH3u8RFfHfXLJwJlA4poAcoE4m
         7aPhekuT84/g6XcaNhGQRLnZzR9t25LFqOBko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318043; x=1690922843;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmHZQ9ca3QHt8MEuJo/iyae9grobgo7Zqpkp40Wn1M0=;
        b=VY60DxrZnTWyaLnNJZPZ9Q+V4DaKPtBRHP6hLD74OAZCxowKIcxyzLmnzt+n2VPgIA
         6B/jVSwxuY71ce66K2lS8WB2nUt95QxH5fROZ44JXADwtWhz/tW9zrDwujW/ZEW8UFmc
         ryCOcMXpw+GMYOcJP2PN3hoCxXYFM6EkngP5xWIoCkNNfs/RuqRVXHUnpiASb5mQvuyO
         9E6Eg8xC22krOZ+FYQEHjNJ+/wFvxsp4AHI1RHEfgknak+nx/4QjwGAjOjbko4RGkvrE
         VfloiR8oOIT6JeV+tsnLz0CeqL/cIOcRk8+LI5i7+ybu/brbTGHdNHZ7QQLjmT56DMSg
         9tmg==
X-Gm-Message-State: ABy/qLYBktXeBjqkp4xSr2gpJ2q9WH3kpStbkjZusnSeTKjSJ1FiuiFs
        3M3Tn1eESI/oM3sTWOMBLzk68A==
X-Google-Smtp-Source: APBJJlE8gXbu6RiaQ/1LDuMOPzlFlEC/EuPXYPSa37TMXkYaU+8syIDUyGVqt4v4FCa9ajG3U+1qqA==
X-Received: by 2002:a5d:4523:0:b0:314:36c5:e4c0 with SMTP id j3-20020a5d4523000000b0031436c5e4c0mr11566204wra.11.1690318043126;
        Tue, 25 Jul 2023 13:47:23 -0700 (PDT)
Received: from fastly.com ([188.225.251.141])
        by smtp.gmail.com with ESMTPSA id k11-20020adfd84b000000b0031773e3cf46sm471947wrl.61.2023.07.25.13.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:47:22 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:47:19 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, bhutchings@solarflare.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230725204719.GA1789@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
 <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
 <20230724150815.494ae294@kernel.org>
 <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:40:24AM +0100, Edward Cree wrote:
> On 24/07/2023 23:08, Jakub Kicinski wrote:
> > It'd be great to push the uAPI extensions back and make them
> > netlink-only, but we can't make Joe wait if it takes a long time
> > to finish up the basic conversion :(
> 
> Yeah as I said upthread I don't think we should make Joe wait, if
>  he's got a use case that actually needs it (have you, Joe?  Or
>  is it only GRXFH you need and the investigation just led you to
>  notice SRXFH was broken?)

In short, yes: I'd like to be able to get and set the flow hash keys for
custom RSS contexts on mlx5 which is why I included the patch to mlx5 in
this series... but to be fair I am just one user :) I think it's really
up to you all on the direction you want to go.

Longer story: I am working on building a system which relies on custom RSS
contexts, flow rules to associate flows with RSS contexts (and thus
specific sets of queues), and epoll based busy poll. It's a long story ;)

I had considered changing the flow hash key to see if I could alter the
behavior of the system I am working on, but I ran into both issues
immediately (GRXFH and FLOW_RSS was not supported by mlx5, and SRXFH
was broken) which led me down the path of attempting to fix both so that I
could get and set the flow hash keys. I thought the code might be useful,
so I submit it upstream -- I was not aware of the netlink work (but it
looks really useful!).

It seems that the Mellanox folks are OK with the proposed driver change,
so I am going to send a v2 rebased on net-next with their requested changes.
