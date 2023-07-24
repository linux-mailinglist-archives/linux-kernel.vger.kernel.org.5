Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB675FFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGXT1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGXT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:27:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAF10E4;
        Mon, 24 Jul 2023 12:27:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b74209fb60so68344551fa.0;
        Mon, 24 Jul 2023 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690226865; x=1690831665;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP6uapY58+owO3zXpIyqoIEA464+0UGYLjjK0+g0hVI=;
        b=KVoqsNkD9pPtqu0gDsOeYD6u1B6n+mw56rFIS/cTeGCxqQ35TnpKO/6aUbQIhjj460
         v8+KyM+jZTre4DHvIn0YQbNJS7o3uNSPzpl1SAA27Xnvhx+GiP9gxs4Mt49mreeffIXB
         NKS6gfCpYYsc47Tdgizooc6/2a0hSCAdapIIg9qdpMT/q1dMr7Mt4mB4e6ZGR/07H1zU
         DvH9YBX/TJfwbuVGYOPF5b5mItvrBMErGvlAWLHMwJWQSTnvMcGwtwXKZhRNhuaQkt0N
         Yg1xr+04OsQpRpI8YlmUdd3G2LGAVfJ7+goDJkdRu860dfPUbM4qmvn6auGclEdW6xUu
         Br2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690226865; x=1690831665;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP6uapY58+owO3zXpIyqoIEA464+0UGYLjjK0+g0hVI=;
        b=PmsBfknILRT5HjaysZw5u9vflbUliPf2uNABJSPX9/LgjBYmDlnh5J3QSwGTWgmvk8
         S8rBHgkYQUz+7mwJnHDI1pjEd+aArTY7994YxglmUqp3g5TMx/I6HfUQ6eAPpEQvcoa8
         FpZt0uJ/tOC1J67KCI56q7ygIhrNyPnUVhtljZ7RZOqehUDvmz+X1YCWW/gkzQEuxN+b
         16k/0xe1ALhKYRO2intXcH7F+H7H3wCTzbBl4Ogt7QK6k1bs1w3dPkqOc1gdGFkY8OwU
         1B7A5CwSxB6HoCIsK28cYkBiNfIaMYiJNYM1cJLZSxnCtqLfGFMFY3wk13Sq+kMS4k+v
         7iJw==
X-Gm-Message-State: ABy/qLaNpzM7VA/GANFSa3kws9ZxjDnkZS35O8wmsXzNzLVM0K46erPO
        nT9jw0B0+wx4zbUuUQlNzJANotCK5UI=
X-Google-Smtp-Source: APBJJlGhrCNAMYuFCP0Z65Af/IAlcihiKhv0LS79VPeXYse0mmqg2Ht3M2NE8kIruU8PQNqMhgEWOQ==
X-Received: by 2002:a05:651c:22d:b0:2b9:4841:9652 with SMTP id z13-20020a05651c022d00b002b948419652mr6367663ljn.25.1690226865198;
        Mon, 24 Jul 2023 12:27:45 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm13743216wmj.24.2023.07.24.12.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:27:44 -0700 (PDT)
Subject: Re: [net 0/2] rxfh with custom RSS fixes
To:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        leon@kernel.org, pabeni@redhat.com, bhutchings@solarflare.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org
References: <20230723150658.241597-1-jdamato@fastly.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
Date:   Mon, 24 Jul 2023 20:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230723150658.241597-1-jdamato@fastly.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 16:06, Joe Damato wrote:
> Greetings:
> 
> While attempting to get the RX flow hash key for a custom RSS context on
> my mlx5 NIC, I got an error:
> 
> $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> Cannot get RX network flow hashing options: Invalid argument
> 
> I dug into this a bit and noticed two things:
> 
> 1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
> not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
> that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
> is patch 1/2.

As I see it, this is a new feature, not a fix, so belongs on net-next.
(No existing driver accepts FLOW_RSS in ETHTOOL_SRXFH's cmd->flow_type,
 which is just as well as if they did this would be a uABI break.)

Going forward, ETHTOOL_SRXFH will hopefully be integrated into the new
 RSS context kAPI I'm working on[1], so that we can have a new netlink
 uAPI for RSS configuration that's all in one place instead of the
 piecemeal-grown ethtool API with its backwards-compatible hacks.
But that will take a while, so I think this should go in even though
 it's technically an extension to legacy ethtool; it was part of the
 documented uAPI and userland implements it, it just never got
 implemented on the kernel side (because the initial driver with
 context support, sfc, didn't support SRXFH).

> 2. mlx5 defaulted to RSS context 0 for both ETHTOOL_{G,S}RXFH paths. I
> have modified the driver to support custom contexts for both paths. It
> is now possible to get and set the flow hash key for custom RSS contexts
> with mlx5. This is patch 2/2.

My feeling would be that this isn't a Fix either, but not my place to say.

-ed

[1]: https://lore.kernel.org/netdev/ecaae93a-d41d-4c3d-8e52-2800baa7080d@lunn.ch/T/
