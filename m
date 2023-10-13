Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647477C7B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJMBJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMBJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:09:26 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4183
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:09:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso975112a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697159364; x=1697764164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWLxj802pySGayKvyBONznmH/OL/1hLeey6jWWYJ/Co=;
        b=hD6MkJxL+7X5kaed0GuojbaigWaKX6NpylhJHQ4lUJnbVQs3Qvp2bMcxrh/DZGDfl0
         fTjN1stpc8eRZLYAjGIE5AGHhn2GKiiCpLLmy3S3Xy/3ixNkAEZS8rJU94j903c8eLDn
         a53kLjXIacauqVvHmmOC8m99X4uhMhTIzICVTawpRqznrR/ODCkG8DJplbVeGcxwM+pU
         IlpEwi27M2lxvezM+fRIUcl+P5qxKgQdd15kYdJSEDgcc5b3sjC6fX0Q7lJDhKV5ss9/
         t1/L4+PR6F8qhO9C1hP/BA8yS7tF5XSOF9Ic5ZGQgVv8t4C97cuHu08s77AD2EBQO4hW
         w8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697159364; x=1697764164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWLxj802pySGayKvyBONznmH/OL/1hLeey6jWWYJ/Co=;
        b=qBQCWVBqeONjPPG6sYpmVSh6bsVEUWB0miLLD3Ij2/yrmyLt4yzJP9XDRK1ODWCfZ/
         3BmGiFnznVyW5amLHIc7JFR5q/wUnhkLqDcQ1WURf62wjWj8jCFOwBF8qU4FkDes5suu
         ISxuPFf+5w1C6yuhRUuh8zG9L94p05nxyaTH/AZUXqSlugk7jfJ3qM4V+GEgVlAQF780
         HLsyX73MSuFeIeyqoqZG10s/ZeuIWTyaNbhPqgvTqEmhkyTSCKQSSzKLOxaYOYUZI2vo
         8flbCphG4JpvhpgezUF295K75o1kjEg+uy4/VyPLFpEBP8V6hYet5uJ4j18OXmk65eTu
         tiXA==
X-Gm-Message-State: AOJu0YyqhjVObkfFIO0UZ4lqKupm8rAkvRZQKTK6n8aZPfe6ejdXlbIy
        4xC4ULrZF+KyySfrIZ91141Hs9c1ckBfCg==
X-Google-Smtp-Source: AGHT+IGL8VfUA7k+9VvKL+tDnbN7TCQgkt+X+qr4LuZofu18/GseF5geTGB9bHoZofj+59zhxjnL6uqGX1K71w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:3341:0:b0:564:e80e:81c0 with SMTP id
 z62-20020a633341000000b00564e80e81c0mr446348pgz.2.1697159363827; Thu, 12 Oct
 2023 18:09:23 -0700 (PDT)
Date:   Fri, 13 Oct 2023 01:09:21 +0000
In-Reply-To: <7551924f-a9b6-4bb8-bfe9-e3efcf0da438@bytedance.com>
Mime-Version: 1.0
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com> <20230921190156.s4oygohw4hud42tx@google.com>
 <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com> <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
 <20230924072816.6ywgoe7ab2max672@google.com> <7551924f-a9b6-4bb8-bfe9-e3efcf0da438@bytedance.com>
Message-ID: <20231013010921.qa4o6nsqjkndsyb5@google.com>
Subject: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:49:08PM +0800, Abel Wu wrote:
[...]
> > 1. minimum buffer size even under pressure.
> 
> This is required by RFC 7323 (TCP Extensions for High Performance) to
> make features like Window Scale option work as expected, and should be
> succeeded under global pressure by tcp_{r,w}mem's definition. And IMHO
> for same reason, it should also be succeeded under memcg pressure, or
> else workloads might suffer performance drop due to bottleneck on
> network.
> 
> The allocation must not be succeeded either exceed global or memcg's
> hard limit, or else a DoS attack can be taken place by spawning lots
> of sockets that are under minimum buffer size.
> 

Sounds good.

> > 
> > 2. allow allocation for a socket whose usage is below average of the
> > system.
> 
> Since 'average' is within the scope of global accounting, this one
> only makes sense under global memory pressure. Actually this exists
> before cgroup was born, hence doesn't take memcg into consideration.
> 
> While OTOH the intention of throttling under memcg pressure is to
> relief the memcg from heavy reclaim pressure, this heuristic does no
> help. And there also seems to be no reason to succeed the allocation
> when global or memcg's hard limit is exceeded.
> 

Sounds good too.

> > 
> > 3. socket is over its sndbuf.
> 
> TBH I don't get its point..
> 

So, this corresponds to following code in __sk_mem_raise_allocated()

	if (kind == SK_MEM_SEND && sk->sk_type == SOCK_STREAM) {
		sk_stream_moderate_sndbuf(sk);

		/* Fail only if socket is _under_ its sndbuf.
		 * In this case we cannot block, so that we have to fail.
		 */
		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
			/* Force charge with __GFP_NOFAIL */
			if (memcg_charge && !charged) {
				mem_cgroup_charge_skmem(sk->sk_memcg, amt,
					gfp_memcg_charge() | __GFP_NOFAIL);
			}
			return 1;
		}
	}

Here we moderate the sk_sndbuf possibly half of sk_wmem_queued and thus
we always succeed unless user has done SO_SNDBUF on the socket in which
case it interacts with sk_stream_wait_memory() called in sendmsg.

I am not really able to make sense of the interaction between this code
and sk_stream_wait_memory() and will punt to networking experts to shed
some light.

Other than that I think we need to answer if we want to moderate the
sndbuf on memcg charge failure.

> > 
> > Let's discuss which heuristic applies to which accounting infra and
> > under which state (under pressure or over limit).
> 
> I will follow your suggestion to post a patch to explicitly document
> the behaviors once things are cleared.
> 

Let's just post the patch and see what other folks comment as well.

