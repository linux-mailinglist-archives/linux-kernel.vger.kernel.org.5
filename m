Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6F87AB244
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjIVMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVMjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:39:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8F8F;
        Fri, 22 Sep 2023 05:39:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226b8de467so1264057f8f.3;
        Fri, 22 Sep 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695386357; x=1695991157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b6BtxNQ135MklppADA7lSErOJTbc2ar7TfLev75acd8=;
        b=RDpAAcJDOARkDKCz68b0oGFUrqvJsU4T1VzWkKMHzPtFFDaoDM+L8vz9XoVshw3jT+
         4gzqnhp1enl1U/Q3h6b7MEX0bJXhquMCWGGVu3I9+uZKyjeFMu2p2gma0VzMG0OA7Vay
         sbP1c9XS9NytO0GbUjqg2bpJwyEsx4qzcYJz4PBI+ARD4pnNtkRJoNmWlYqI+EK5iQE/
         RcHFabCdIwIpIcHGuP6hPxXZXfAzK3WdzjxYv5988W5COkp9XwtUUHFZN5rmxw0+WcCe
         OsADi4mtOFSWiUheca7v73E7I1uYCOwJ48kUdHaeHp1YVQGPoe0VqvaEUxg6JMcc71E1
         3flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386357; x=1695991157;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6BtxNQ135MklppADA7lSErOJTbc2ar7TfLev75acd8=;
        b=iUcmj4x8C+bS1ufiAN4hGC/xVPQdbFqllKJh5U7NM/1TnjxaGox+uZA9ksBMuOJ5ed
         pH+qEWX3RBYGQKhjcZhBTgBHR+z2L5Xf5by+VGSaN/bKkuh+085FWKPisjKxUha6GEyi
         L034hMeg3Yfu5PWiJecpuDofyq4fjW8NNIktJ2A5uzcmQUXo4MoxMNJsz1TtD2aDbjXk
         uuGootzeBe83aUIB7RKBZnxPdH9OSyZ3b0GLcyBI0mkg3XdjPubB2EVnqiauBio7LF7D
         nu/GZhcqwjKfWcJlGumQZzb8KFSx88QDLX5g3Zt7aDNtlqDhFC2DPXa1qAlxCu+murpk
         CczQ==
X-Gm-Message-State: AOJu0Yz98Dk4j+9xPGaejb5bB22zbDJOSAaEskFIN233/SnaAJUGV7QK
        sL2FiOR30IHGrYHUMrP1zQM=
X-Google-Smtp-Source: AGHT+IGjgWaSR9uKGwFDbdBclTHJnKhiju4EMdgbX0VLMi2rEzBZwykMPgJj/mMOcTKBM7OAMgcEmg==
X-Received: by 2002:a05:6000:148:b0:31f:e1b4:5846 with SMTP id r8-20020a056000014800b0031fe1b45846mr8123988wrx.53.1695386357117;
        Fri, 22 Sep 2023 05:39:17 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031773a8e5c4sm4375252wrw.37.2023.09.22.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:39:16 -0700 (PDT)
Message-ID: <650d8af4.5d0a0220.5ce38.2c5e@mx.google.com>
X-Google-Original-Message-ID: <ZQ2K8ZRF+Kyq7pmD@Ansuel-xps.>
Date:   Fri, 22 Sep 2023 14:39:13 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: stmmac: increase TX coalesce timer to
 5ms
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <20230922111247.497-3-ansuelsmth@gmail.com>
 <13bc074d-30c2-4bbf-8b4c-82f561c844b0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13bc074d-30c2-4bbf-8b4c-82f561c844b0@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:28:06PM +0200, Andrew Lunn wrote:
> On Fri, Sep 22, 2023 at 01:12:47PM +0200, Christian Marangi wrote:
> > Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
> > multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.
> > 
> > This caused some performance regression on some target (regression was
> > reported at least on ipq806x) in the order of 600mbps dropping from
> > gigabit handling to only 200mbps.
> > 
> > The problem was identified in the TX timer getting armed too much time.
> > While this was fixed and improved in another commit, performance can be
> > improved even further by increasing the timer delay a bit moving from
> > 1ms to 5ms.
> > 
> > The value is a good balance between battery saving by prevending too
> > much interrupt to be generated and permitting good performance for
> > internet oriented devices.
> 
> ethtool has a settings you can use for this:
> 
>       ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
>               [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
>               [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
>               [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
>               [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
>               [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
>               [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
>               [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-bytes N]
>               [tx-aggr-max-frames N] [tx-aggr-time-usecs N]
> 
> If this is not implemented, i suggest you add support for it.
> 
> Changing the default might cause regressions. Say there is a VoIP
> application which wants this low latency? It would be safer to allow
> user space to configure it as wanted.
>

Yep stmmac already support it. Idea here was to not fallback to use
ethtool and find a good value.

Just for reference before one commit, the value was set to 40ms and
nobody ever pointed out regression about VoIP application. Wtih some
testing I found 5ms a small increase that restore original perf and
should not cause any regression.

(for reference keeping this to 1ms cause a lost of about 100-200mbps)
(also the tx timer implementation was created before any napi poll logic
and before dma interrupt handling was a thing, with the later change I
expect this timer to be very little used in VoIP scenario or similar
with continuous traffic as napi will take care of handling packet)

Aside from these reason I totally get the concern and totally ok with
this not getting applied, was just an idea to push for a common value.

Just preferred to handle this here instead of script+userspace :(
(the important part is the previous patch)

-- 
	Ansuel
