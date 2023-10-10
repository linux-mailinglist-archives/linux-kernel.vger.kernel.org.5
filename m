Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A37BFD31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjJJNVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:21:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3991;
        Tue, 10 Oct 2023 06:20:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2799b7280d1so3570046a91.1;
        Tue, 10 Oct 2023 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696944058; x=1697548858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zby/4uZ4iToEHOr+VEOppCbzLD2G246ojA6jq62b6h4=;
        b=g6lpBclrO+f/cwaFwYg+MVVCCjUp2AgW/I20Ju7dTMgU4PN5UoQgqQTqTmsh+0ppzh
         XC6Xqu3zNdA5BVImLrw3ZdcW8I8qnjLQVNymAkGhT9Y387zhfoJ4hyGuz5edIpyFUlZk
         9R4XMmpnok/UUUelGBaMR+Q7ACOK+nfJwK7kkCt9y4SSjm3T98zmUFQzzu49mUfPb5pQ
         RxZbFSUOrT8dSsJWWI7StRo79jKhS5PNE/YYzvSz29AG1nmWJ/0ZB4FoSiQ+Vpt52DOP
         bcCBj8YkAFCCGCWStdxNkkdK8rIHPbi+bIfQ2E1iJOpsJ87hY1qxOC2x08o7gnZPHfKU
         8Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944058; x=1697548858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zby/4uZ4iToEHOr+VEOppCbzLD2G246ojA6jq62b6h4=;
        b=CPc4swUV4mKk9ISx2iYLYW2NFS0G2S3AQx0cZUMcf67wBqzwNSW0hCtenHTuFXvxAW
         YKA3350gr7j/jZEV0BX6aSm1TdMgh21aIP/0GHvCfYZAOyACIaY22c9WL7u0kHeMKWsR
         85uojpLjet9nmemcfnwHceK5pInnfOCub4GOMTsOw2znzIJ8E4PN6JjfA3hJsklcV0UE
         hhEWI7zb6qWy/zAKHo7+G92+cRHFjbn4juVD32IzihUfnmB8l3kg9NRvYu4fktWu39Zw
         aP5a9tFy0iqhf9KmHbnApaKqhGi68bgXHASHkNqtD6F5wf8OUP4oNGAffZpZfh9B4bBk
         cpvQ==
X-Gm-Message-State: AOJu0YxKPYRjwWkVpvoEvRKLSICj6E6xR2VnqIVZVf59ZmKcEhX9Sx1s
        +7Dttgk0fvnv/TKJaBRHr+ZPaAxkoQ5zimfCP5krMeZ1yu1BXtT3
X-Google-Smtp-Source: AGHT+IEnAxtcOezHyL8o3NDV+w8PdRT+OmDj7+RidTHyk9CgHtjixqmD8bvNNK5yp1ArkXweqya/3d0utB6LLrRmTJw=
X-Received: by 2002:a17:90b:e11:b0:27c:f1f8:261f with SMTP id
 ge17-20020a17090b0e1100b0027cf1f8261fmr1017670pjb.20.1696944058235; Tue, 10
 Oct 2023 06:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231003232903.7109-1-frederic@kernel.org> <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <ZR0vjdp+BNiFm46+@lothringen> <CANZk6aQG4Lqyk8JkT_my3dwub4jGpn31wYRoCwW4oSH1x=sJ1A@mail.gmail.com>
 <ZSU1NeV/Z65ph/RC@lothringen>
In-Reply-To: <ZSU1NeV/Z65ph/RC@lothringen>
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Tue, 10 Oct 2023 21:20:46 +0800
Message-ID: <CANZk6aTCfNQFX5jCdyEi-yUmTOtKPb0TYOPUs+1LSjF+5=HSNA@mail.gmail.com>
Subject: Re: [PATCH 0/5] srcu fixes
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:27=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Sat, Oct 07, 2023 at 06:24:53PM +0800, zhuangel570 wrote:
> > On Wed, Oct 4, 2023 at 5:25=E2=80=AFPM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > There is currently no way to reproduce this problem in our environment.
> > The problem has appeared on 2 machines, and each time it occurred, the
> > test had been running for more than a month.
> >
> > BTW, I will run tests with these patches in our environment.
>
> Ok, let us know if it ever triggers after this series.

Sure, I have ported the patch set to our test environment, now 2 machines
already run test for 3 days, everything looks fine.

The patch set is very elegant and completely eliminates the possibility of
unexpected accelerations in our analysis. I am very confident in fixing our
problem.

>
> Since I added you in the Co-developed-by: tags, I will need to
> also add your Signed-off-by: tag.
>
> Is that ok for you?

Sure. Big thanks!
If possible, would you please change my "Signed-off-by" into:

Signed-off-by: Yong He <alexyonghe@tencent.com>

>
> Thanks.
