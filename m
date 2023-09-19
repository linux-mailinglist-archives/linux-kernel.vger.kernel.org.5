Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFD7A5749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjISCPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjISCPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:15:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF9610E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:15:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso3967912a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695089703; x=1695694503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Qrr9nRQADHQsZ3OsEHTe652qqYXAsbmlLNRv+gr00=;
        b=gQ08xovsPjzn7PSYF+799wsqokMKUMl9tYmd4tkiBLVpXquWp8E92uP08PVILQaaPj
         Wdxqux66DHV8POCNL8s1WKDTltWhqqgKuVt0WZtOU4mlFcsumKBoYZ2qJEr1vBZ+rgZq
         fuXjtvBCUyTNeWCh1wptwCWyfi7AMAb4hRwLIUjau6sEyXQUTodnmXfMYC3p+bJqrpY+
         qrbz5v0kenyZQyDdTAgVT905r7z/coGb3PUsWKHNw3IhGwNXxrnSL8znNwkNx9Ima+XV
         oElcQ6P72b26IvdzyBRCUr8YVwax4T0Y/+wxDSuMl3DTyqNefB5cTx6il0GAaBwmYxHt
         cHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695089703; x=1695694503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+Qrr9nRQADHQsZ3OsEHTe652qqYXAsbmlLNRv+gr00=;
        b=o0XtXRNCqCqGsxmp26UrjxyTIq9idaVg/kQBhBIU/lkBa7lQsWCcJUxIUqhhXiBkbN
         9J2Z4Mrza2oqI+Jj74OCYvwJnZVMkXYI8kAf1ktngdjkxuh6EDlMhDgTlUhwuVizyehN
         xsZ1eoVYtkHipy9H/kEqOQQQ/p/+X4A/hEodO9kNjmasCDVidJvYjO42Gt7K2LXKKaaw
         q+/u6ULqzscEs8dkn+p1rB6qtfnefsKuB9Mwo4uIsbF5cxp0jRgncTfCsDOA4qiWLTE4
         Vzi5TRcni9CszdacTJ6VD6xRCTIU1M3WJZ9/Kb3xoT7UA4tkDTKQL27EKebDqe3kzeYJ
         qyYQ==
X-Gm-Message-State: AOJu0YwT0vzJYDdikjnFM/KgQJtCMeDoiPdWNpAcVZ5DxyISHWkmr4Et
        i+zIJqW2auI1Wrxdwee7qMgsCeJl67YJgx4knqZHftE/4Yg=
X-Google-Smtp-Source: AGHT+IF8O2Q02W5yRvGACiSq2YgO0uitH8QGKGXaO0/87fapwwdTL+4KJOGLGSHOmWjOs9R0kPe1E8Kw1rhsTjRSEcQ=
X-Received: by 2002:a17:90a:9485:b0:263:9e9b:5586 with SMTP id
 s5-20020a17090a948500b002639e9b5586mr8193125pjo.44.1695089702947; Mon, 18 Sep
 2023 19:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org> <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org> <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
 <ZQiRncEYCK3RYXA7@slm.duckdns.org>
In-Reply-To: <ZQiRncEYCK3RYXA7@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 19 Sep 2023 10:14:51 +0800
Message-ID: <CALm+0cU9W2P46cKnijeQRQFKzpqUyZUykQ-UFt28f4b4ueyAZg@mail.gmail.com>
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
> On Thu, Sep 07, 2023 at 10:13:23AM +0800, Z qiang wrote:
> > >
> > > On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > > > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > > > invoked to release wq
> > > > in pwq_release_workfn(), this is also asynchronous.
> > >
> > > But rcu_free_pwq() doesn't access wq or anything. The last access is from
> > > the work function.
> >
> > The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
> > but  at this time, the kfree(wq) may have been called in alloc_workqueue().
>
> I'm not following. The only way alloc_and_link fails is if
> apply_wqattrs_prepare() fails and if prepare fails, none of the pwq's are
> installed and pwq_unbound_release_workfn() won't try to free the wq as the
> pwq's don't have any reference on it. So, if you flush the pwq release work
> items, there can be no rcu_free_wq() in flight. Can you please try to see
> whether the problem is reproducible with flushing?
>

you are right .  sorry,  I ignore if apply_wqattrs_prepare() fails,
none of the pwq is installed,
the install_unbound_pwq() is not invoked. I will resend v2 and test.

Thanks
Zqiang

>
> Thanks.
>
> --
> tejun
