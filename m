Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F717DE525
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbjKARO7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbjKARO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:14:57 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AEBD;
        Wed,  1 Nov 2023 10:14:55 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-587310758ccso3306eaf.0;
        Wed, 01 Nov 2023 10:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858895; x=1699463695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6irXt2HPa6/qTlgvmtKNDDj+Spoz+b92gnZoTUz0Dc=;
        b=C8kj3wvpkABxRKRY6qyBvSt71gqJLnUxNXzYGtjhxkF54HdAjn3V6ZgSc9hRCt451L
         ml29MntiGYHWnGvR5rMzkBVkNkXRqVNbOUqjl4xe0R/xn8G6qFuHv949dGG/F3iDs8l3
         p7Nq8yOu44w/u8HwgmtSUWrxQk5SIXBGK0tyFS0275Pt3gS611n7lOTrLVNc/FHcaPcS
         IY5PKwiyZpq7lFAHzhSIjlC+f3sPjghUoybHjo6l/7g7VeKjswTBpyb3T5AAAH6H+KbS
         UU5n7+t/m10Zy/pS9aOMPjuAwXC3oOLIuOBw0E7si5YMaFOd0I9s70FiPmf/MarhFN9+
         WKkQ==
X-Gm-Message-State: AOJu0YxeI/bHkuFhxo30Wz3h1Qw1wnM6t/azpuTqRbKkJe6UQVUmY/R4
        ++Yj0C+LQ2qlmgP2sdpmQTR8h822J0b6EU9afZH83niH
X-Google-Smtp-Source: AGHT+IF87ZQfQerqkIZ1542x4dQRiTH0vDbQllcAactL/pZJaB1xoaLqSrKy6OZ0c3sAX45oR0ct/g1s06o2I+lNeJU=
X-Received: by 2002:a4a:dbd8:0:b0:583:ec88:e0 with SMTP id t24-20020a4adbd8000000b00583ec8800e0mr17347583oou.0.1698858895016;
 Wed, 01 Nov 2023 10:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
 <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Nov 2023 18:14:43 +0100
Message-ID: <CAJZ5v0iBpbsifm01HMa_CQW6Wdtjwh1yJXOhOw9qYc-cDmDKJw@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 4:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 27 Oct 2023 at 03:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Please pull from the tag
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  pm-6.7-rc1
> >
> > with top-most commit bf224871c27a7c7e2146d667176977ffe3752750
>
> Not sure why this didn't get the pr-tracker-bot attention, but it's
> merged, so here's the manual version,

Thank you!
