Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCD7AC6F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjIXH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:28:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5123100
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 00:28:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c081a44afso83702797b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695540499; x=1696145299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlhytN8p6rzsoNNyF2qTaia7H0UbvnXVgo1f8ue1miw=;
        b=bzemv4DxQIseJIZGlcspLaUqsTJ+pNLlu4GBS30lHDRoXayjlS3aKQVLaaq7mZHHAS
         LF4KFpnYj/oqv+iLOBVj4QTA9s1ROI6Q7qbopwqBNV9M5u7wWCVP8sBZYanb5sH5If6L
         Tpdmw6tnWY/S6+mCF8bIZOZ7l0wUic5/swoKZ5aLOPdDIY7G65ONrJEbrOSt3lfnvd8h
         eHkCE4ys3myKIam9xyfe9tZISOAW7KX4mMYGcq69E5hKCk4cyeOdTPn+DXjnHnYPaw71
         OTKRBQnVvfNRqio22MSKg6jrC3fjHpEkMTGOAbleiXmVLyzRX73USUTEyLbIwlW990dV
         CTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695540499; x=1696145299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlhytN8p6rzsoNNyF2qTaia7H0UbvnXVgo1f8ue1miw=;
        b=FTixiNFSMlTOTY64CEJqJR+wP7/C0Tm3oqSoNuAk764fZBrnrseQdyS2ALoRuvn7xR
         5crR017YyO+scAiKa+XHPv6Me8uMtkyI8r2CZj/LEyDTQAGLIG6BrNTvzElybdEXwsE5
         CSFxhWhn/wmo9GwoxITeehDo2Mrjwuj1JQdRtRrc/qqEYn/cYZkPn9ItK1T87It/rjeM
         BPLL5A3U+bePGIZpPtRIDfzoztRop9M83VNHlroXVn03gfrm6CUP1n5YH2xChO4jnOn/
         7l7uYk5vrvPC+Btznum//UAf/r1VEd4b9FQ5yNmUhuZr/kfKH5kuevMDt703bPEnuLVZ
         D8Ag==
X-Gm-Message-State: AOJu0YxZCbiI8BfLqGCtcFeth827b21vuRbYL7K6y0LqUAT5dlDsfuba
        9tyuarU4sixMDF7fjRYMzPXh241VeD5twQ==
X-Google-Smtp-Source: AGHT+IEhWDis5bOzbmBGOi4zqdXmHXsB5eM3APbeJBFJO8QLORC4+n5ComSE/iuNU8T1xE+g9g77xuCbvAPMMA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:e304:0:b0:59c:b9b:8940 with SMTP id
 q4-20020a81e304000000b0059c0b9b8940mr42160ywl.8.1695540498994; Sun, 24 Sep
 2023 00:28:18 -0700 (PDT)
Date:   Sun, 24 Sep 2023 07:28:16 +0000
In-Reply-To: <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
Mime-Version: 1.0
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com> <20230921190156.s4oygohw4hud42tx@google.com>
 <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com> <71ac08d3-9f36-e0de-870e-3e252abcb66a@bytedance.com>
Message-ID: <20230924072816.6ywgoe7ab2max672@google.com>
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

On Fri, Sep 22, 2023 at 06:10:06PM +0800, Abel Wu wrote:
[...]
> 
> After a second thought, it is still vague to me about the position
> the memcg pressure should be in socket memory allocation. It lacks
> convincing design. I think the above hunk helps, but not much.
> 
> I wonder if we should take option (3) first. Thoughts?
> 

Let's take a step further. Let's decouple the memcg accounting and
global skmem accounting. __sk_mem_raise_allocated is already very hard
to reason. There are couple of heuristics in it which may or may not
apply to both accounting infrastructures.

Let's explicitly document what heurisitics allows to forcefully succeed
the allocations i.e. irrespective of pressure or over limit for both
accounting infras. I think decoupling them would make the flow of the
code very clear.

There are three heuristics:

1. minimum buffer size even under pressure.

2. allow allocation for a socket whose usage is below average of the
system.

3. socket is over its sndbuf.

Let's discuss which heuristic applies to which accounting infra and
under which state (under pressure or over limit).

thanks,
Shakeel
