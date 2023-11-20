Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25FB7F193F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjKTRCM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 12:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjKTRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:02:07 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC5126;
        Mon, 20 Nov 2023 09:02:03 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c1b6fc5426so225830a12.1;
        Mon, 20 Nov 2023 09:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499723; x=1701104523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wap2qAg0DBdSf4l2p1ebSWPpLwllDzPa5k8hAng2Ze4=;
        b=q9nMv4i3nS7JnUSxPtm/VzfUjQQtavghabWXt68pZdZKLn9YpOXnifhyrW0/ZeBGqA
         LWphlCjMGRHVnXjkC59zQmVoahjuQdYAfG2/bO3YEox3Sab6vKGh4KUdhr9rNYGJob8p
         xm5ae2d0xUJaFy7qJtsxIZoTvwPc3UfWfo/3MObK3RZIFLzQr6AJGkJ6SufYGiFqtBNR
         HDuHmJA/WMq9PvBaTu9vZoZhIPxQklz83drYa4IdnENGBNkftgRc6EL2lUWzN7NbbuZU
         Ao+Qlobbbszem1s5ihX0Rgnzgs3KZhjax7BX6HpV0Ge3khFueM1/WU5x1/gj/zuaLP/g
         cjrQ==
X-Gm-Message-State: AOJu0YyWCsyfFvD/eDPWILTOJWkA57eLVGceKp9jjzWazMr+y4Z/qfcM
        QmnW/JK8TwEgckHfkp+V2kaDgRVNQlvQHJP/040=
X-Google-Smtp-Source: AGHT+IFiimo5DD8z14v7WB+HHlNduQJxInb/KP+ClEWuDUo4V9Po4DbcA9/bm7pqIq2wlMgtzBGDB5oFY9pef5JkKzU=
X-Received: by 2002:a05:6a20:3d87:b0:14e:2c56:7b02 with SMTP id
 s7-20020a056a203d8700b0014e2c567b02mr11059145pzi.0.1700499722921; Mon, 20 Nov
 2023 09:02:02 -0800 (PST)
MIME-Version: 1.0
References: <a5f86bcf03b2ed809245d57f5971ae42a8b85128.camel@infradead.org> <ZVT+Fq1yVZ9G8pqx@shikoro>
In-Reply-To: <ZVT+Fq1yVZ9G8pqx@shikoro>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 18:01:51 +0100
Message-ID: <CAJZ5v0j=b_k1gnHfPSNGkNm4nTW8Erou=B3KYW5+6Mqy-iTfyQ@mail.gmail.com>
Subject: Re: [PATCH] PM: tools: Fix sleepgraph syntax error
To:     Wolfram Sang <wsa@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Xueqin Luo <luoxueqin@kylinos.cn>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 6:21 PM Wolfram Sang <wsa@kernel.org> wrote:
>
> On Wed, Nov 15, 2023 at 11:47:51AM -0500, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > The sleepgraph tool currently fails:
> >
> >   File "/usr/bin/sleepgraph", line 4155
> >     or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
> >                                                          ^
> > SyntaxError: unmatched ')'
> >
> > Fixes: 34ea427e01ea ("PM: tools: sleepgraph: Recognize "CPU killed" messages")
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Had the same issue:
>
> Reviewed-by: Wolfram Sang <wsa@kernel.org>

Applied as 6.7-rc material, thanks!
