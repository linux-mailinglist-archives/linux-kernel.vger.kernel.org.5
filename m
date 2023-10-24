Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4119D7D48A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjJXHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:35:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5210D7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:35:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso133195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698132930; x=1698737730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyep+u71crtfaR4lFjOq7pR39SPnIQZqdddTx57In1c=;
        b=dI75M02Xv850RuqhbVJbDxjzdjdwvsqVcGYZ1YDOt55aFXeIVlhQkBrYXIAB/7iZfs
         cmR/PLwc/0xrJYA+0GzUBXAGDvscWxjF6IMht0n8kROeqyR5xXJFKrxotDtDdqLSrqbS
         cMAIxLmYsup62Hhzt+x66ADpdbII6nROUEzjXI3fR4BCUyfrxBFfdDGdmY0wNeockcq9
         PHG/EbEHbJamz+7NYPRjUSG60E07jIEPKTHA28uJBZDwzTFAOt6v1YGONOFSRLCS8++z
         7tp+NE7Ivpk+vJ2jYpKMsjZCzAeQov1X81bdn2S9ej880RkWGzpPu+eDqBOM2PSxddAz
         VNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132930; x=1698737730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyep+u71crtfaR4lFjOq7pR39SPnIQZqdddTx57In1c=;
        b=niQQK9TRUWJ9cL+xO7QSZA4zG3/LyAhrQaPO+rU2yS/ypiIxYQ3rwphotW+OaTp9a3
         L0YHtuuYetCElK/3HswPN0B2N4RcwQGd5DOQdZMzpVIyAHCxUvNdS9gtyGHMuVA7G6xa
         IqnLix3I+2ecASICHevbpF8daCeNTunPtg2L/Piyxyqm+Xv/2hIVcMcQV71rBceroB2m
         3hZ5y6LQSfT4ZJFc1vr9e25oAxJ5sAP2vjy/muZE4/yFePoRfRw6eBuOa7hXyuTh90lJ
         Cuxq6ZL3TyBFXQgkt7aUz5+50eJ2Oays/TyKu3hux21NrqI6n/8phmrDHXCxhFmOWHij
         uMjA==
X-Gm-Message-State: AOJu0Yw0IECKpMvn01Nle0Y+CcSGEPxWl5kHDwb0hoVWIT2hk9GAsSJ8
        Nhg0sir/DzZFIfVIIbZ+BfH7y/v6b43s1eDtjR1wjGCdAMgKCw6LXJU=
X-Google-Smtp-Source: AGHT+IH2U2wjlJhZU4maQKEC7MX9MJ2lmSSUVHJxpBXDZMYoB9uPHOCxx3ZtCWo3ROSpAdvF7groh0U0QmI4cUm1ZYc=
X-Received: by 2002:a17:902:d586:b0:1c9:e48c:726d with SMTP id
 k6-20020a170902d58600b001c9e48c726dmr184955plh.4.1698132929698; Tue, 24 Oct
 2023 00:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com> <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
In-Reply-To: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 24 Oct 2023 00:35:18 -0700
Message-ID: <CALvZod5EMJcxZgmvUXun29R-PrT-v=18DHpd40QLNweXz71vFw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
> > Before sockets became aware of net-memcg's memory pressure since
> > commit e1aab161e013 ("socket: initial cgroup code."), the memory
> > usage would be granted to raise if below average even when under
> > protocol's pressure. This provides fairness among the sockets of
> > same protocol.
> >
> > That commit changes this because the heuristic will also be
> > effective when only memcg is under pressure which makes no sense.
> > So revert that behavior.
> >
> > After reverting, __sk_mem_raise_allocated() no longer considers
> > memcg's pressure. As memcgs are isolated from each other w.r.t.
> > memory accounting, consuming one's budget won't affect others.
> > So except the places where buffer sizes are needed to be tuned,
> > allow workloads to use the memory they are provisioned.
> >
> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> It's totally not clear to me why you changed the target tree from net-
> next to net ?!? This is net-next material, I asked to strip the fixes
> tag exactly for that reason.
>
> Since there is agreement on this series and we are late in the cycle, I
> would avoid a re-post (we can apply the series to net-next anyway) but
> any clarification on the target tree change will be appreciated,
> thanks!
>

I didn't even notice the change in the target tree. I would say let's
keep this for net-next as there are no urgent fixes here.
