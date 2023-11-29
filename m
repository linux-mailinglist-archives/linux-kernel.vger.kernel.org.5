Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A827FDAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjK2PIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjK2PIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:08:49 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB610E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:08:53 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cc66213a34so70567557b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701270532; x=1701875332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXic/+6itk3TGberNCqdj0WRwhs080Vma5guEUi6jGo=;
        b=IZde46VmHNIIbuY24qvFOn6esBY00ngqFYFsgR5gyuXiSn+C7CdX3JnHzPrGYiKKy7
         kP91XdBiN0VomlmBvuH7KV9uTSN4ccA6P6m5rLkzqqZE9tbh/B3CcZV8wBZjHXuko/Ug
         a5Apw8ej9NkUx4opLrBqwKbbjo8BjIEmCCxbVDJ8np1Hzoe3OVPhZ53Tzhu7M7Ylvdpq
         5jqTd7+NUjTU2CmTPcQkgFxUPr7dq/JuaJIBlueDsjSf1YRsjfNKG5M2DTSJzxOd3NDm
         prwzGCSfuPDq417l/mkD563bVamc/yb5UgaixLOtiAg4H38anUPSta64Uh/e2cQ3NROC
         nUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270532; x=1701875332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXic/+6itk3TGberNCqdj0WRwhs080Vma5guEUi6jGo=;
        b=puMMPWfj0/5yGehN5/HI71rkccAnkyz0kYlJ/QuD0NdZQmL0R+PH2Y8dScuVcWcNwJ
         rLRgAwb2h5ZhASr1mwrUsmjqKrnqVHAQxLBSfZXohGqzK8QkvRRbubicMBCah+iu1/zs
         6Mv54lKjOP7tzl8Dl+KsRhaeBxGhvdKp47bCLA3nKfa+h2FGsLej1aYMc4f5tzwPagVh
         3IEaxn1BvCNmInPva/vOrHhCA78iFVRkNAg7RyfBXzoQiX/bhIpddiEUHig7Wjxy94vY
         Segyv9tWWFRk9wGUe0cFnQsS1+5DaXVsCDv8tGw0ntdFbUenf7v46FSP2mRzD1RB58FI
         NNCA==
X-Gm-Message-State: AOJu0YwiCHgHwW/YSMQOokYTv4u2W/pyPFgnGTlPHeRj0b28PsB7trj4
        sA3yRK0h4Yjt9eltpdzL23//AUrOfU7yZjF5+CI65w==
X-Google-Smtp-Source: AGHT+IH7uajT5yd4kNXCf/d1PhdaI1T+d+TSGNjzi5KTm1ObFm3BiIfA7yF+l/iNCuCXiIGfOOeUrxX1jG13TlH8GPI=
X-Received: by 2002:a81:5c05:0:b0:5ce:4dfb:bce8 with SMTP id
 q5-20020a815c05000000b005ce4dfbbce8mr20114025ywb.7.1701270532587; Wed, 29 Nov
 2023 07:08:52 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
 <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
In-Reply-To: <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 16:08:40 +0100
Message-ID: <CACRpkdZRf7bNVmJCgsVD0uheD1VLkLKG13d1oS-kbT8BFyRKQw@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fixes for v6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 3:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 29 Nov 2023 at 04:09, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > The most interesting patch is the list iterator fix in the core by Mari=
a
> > Yu, it took a while for me to realize what was going on there.
>
> That commit message still doesn't explain what the problem was.
>
> Why is p->state volatile there? It seems to be a serious locking bug
> if p->state can randomly change there, and the READ_ONCE() looks like
> a "this hides the problem" rather than an actual real fix.

Thanks for looking into it Linus, Maria can you look closer at this and
try to pinpoint exactly what happens?

Is the bug never manifesting with GCC for example?

In the meantime I'll cook a fixes branch without this one commit.

Yours,
Linus Walleij
