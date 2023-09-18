Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5807A45BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjIRJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbjIRJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:18:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD2DD3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:18:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so3066048a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695028729; x=1695633529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vOUwR0XSojYK9VIcC7RqvIxqVzThb1ey2EOADSQHi5U=;
        b=iz1chiLMSLwAvBbEOgLudeydZSGd1tZ5lXfmlGFN/mP4FpKtvsMTnapJh648Q6k057
         E/2USmfLlZZ5XVrSPJTkGzzCOr4qnKYrf8YGe344rrDHgdWNU7whWBwYVv/XERSP11NB
         fiyKB5wVT63LpMWYL+yPA2HwJT1lWLHHc4l56R35KxV3Wx+vhiBDYX35TqFEA8DQLkMk
         JTHTAmSDU7Lv3HjyvedViYRp3AiPoNjNQvVhVGKBe3Pw3Az6epzHAjJXPTb1ydENUsh/
         Y135YOcGjdGCkrNUX9UjatsL6T7YcPwmx5vow0VfuGbCX+UYyED7ejI8+B72hvnDO55Q
         q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028729; x=1695633529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOUwR0XSojYK9VIcC7RqvIxqVzThb1ey2EOADSQHi5U=;
        b=ROkV07sVxP2aAbKjVhpKGkXEYPL8VQjJTR7vYHwjK4NuYpjmGt32Ge2faOS9Kjl08M
         YTHE/SrgeFn+NHN1G5Udn1SUWDfpPabSV9zHrqRbWjTgPyc2mDnKt9F2wWvehId7VpDa
         xx909NySskzONl7hH7lzi9cP+xLRjDXnwpPcndHx5A+0yBMAPC4LmbctiPRBwe+s0MDS
         tG0JVo1qc8Z9e4jymzGYRQmGCwYQFADloYOCEKoTQ+9GTwIEjfu86o50M4t0DyuHX4ol
         Ym6kro+/Sgl3DMM1gJcKDaQHCPb4HjAE+21tnfoWiLGi08rXizMNrJ62pVmvGQO1DVZ2
         BAdA==
X-Gm-Message-State: AOJu0Yx6Y7H4q3z/Xu/rMFF4Aaw+IRtA68u5ngEY8wrICgQW1q02OyoE
        V3lM73xzxWfv8VR6CQoI0+FHsMjYb7lyQjJmSxmfXAmDasY=
X-Google-Smtp-Source: AGHT+IHYmOj1X07KtLp8tNWJ3E/2n0eDcH4uln5QlKVfHuIdh/+Cx+DAZFxUYiqxOabbJer64DGbbreasiAzCf1kwsc=
X-Received: by 2002:a17:90b:3142:b0:274:7b6a:4358 with SMTP id
 ip2-20020a17090b314200b002747b6a4358mr5984127pjb.6.1695028729136; Mon, 18 Sep
 2023 02:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org> <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org> <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
In-Reply-To: <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Mon, 18 Sep 2023 17:18:37 +0800
Message-ID: <CALm+0cUyC-g7NewCWhvK0wR8ZWm_vT0pHnM+GFixJf35=HxXMg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> >
> > On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > > invoked to release wq
> > > in pwq_release_workfn(), this is also asynchronous.
> >
> > But rcu_free_pwq() doesn't access wq or anything. The last access is from
> > the work function.
>
> The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
> but  at this time, the kfree(wq) may have been called in alloc_workqueue().
>

Friendly ping.

Thanks
Zqiang

> Thanks
> Zqiang
>
>
> >
> > Thanks.
> >
> > --
> > tejun
