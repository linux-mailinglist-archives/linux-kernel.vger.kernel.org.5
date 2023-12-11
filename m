Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2180DFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjLKXwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:52:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15587AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:52:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db7d198e791so3901315276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702338749; x=1702943549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EezfayxPVdnkBmNk51Ez5R2PdL+kdCDVvz15XJXKgwY=;
        b=LpM0g9jrOPS99d+qtZ0kJd1fdSbGp3Qv4WJunPknjSJe9iUv52OZ74/yQMQckhB+Bn
         TydXcL75FolFZ7OB63VBOjm84X5raBKYDefTQceLJuQfJKofm7fzbRxfTwz0FlAlezxU
         alLTcoStDvM8CjDgR84134n2d/Khn25BvLQ43tGZswulRhzJjyrd76EdsxOLK3k5MTxf
         UhAfyQmayeNVkATEr2h7nCobDoqrMdl4JlwMEsB0C/of3PBeXb6bnEATDohaFWs1c2Im
         PPDFv5BU9YNyPn+gSjwVDlpmw4TOoxHn4SOxzcZhHfPIdrzOLRk0sAt2m7El5xhBCVp5
         MCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338749; x=1702943549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EezfayxPVdnkBmNk51Ez5R2PdL+kdCDVvz15XJXKgwY=;
        b=BEZVBM4To/KY+VtDdNFJyZS8rfsLSV6xK/QK/wl4d1ttMeBD9Z4owbnPfRQTLHHlCg
         JUBw/QdCJJ7Dp9DBkbbuhjjSh27qocUz92MS8wJ40X55N4JOTm7CSTA9Sk3RPO581r2i
         9K8Vwrij1m8XKd/n3bBpHiXVRHuNF2yPUcq89crmua0Hn2Fb537JNi1eyjhWbtXIsnrl
         EimtFf/PgDvrzepPadp+BM57DJuNC5VUUzI/QB9xGt7yeV43Oaim9zbAhPKuo23oOtRD
         Z+Ol7ykmyv6zWHWouYd5h0FzUZElVXdS7ijE1w4p0bDVMob2V7SB77eg2clP54iwDhP5
         KbRw==
X-Gm-Message-State: AOJu0YyUssAI9DROEZAlqNBiN2sc6Rkww1WAJAgjPGoaUdPzExvkWDPR
        XSZKVetdk9GsNu+N1RyETOqAy8zzbMYM2kwAQ2sgfg==
X-Google-Smtp-Source: AGHT+IH1CDUarDXRp3aMi3vniVcE8qqH32XfLEnXSNA1rKOWNZne2iyAqgpSyvDCPJ8dl98G3eLqNOeOR9tUxminvjw=
X-Received: by 2002:a0d:cfc2:0:b0:5d7:1940:8df4 with SMTP id
 r185-20020a0dcfc2000000b005d719408df4mr2571795ywd.91.1702338749289; Mon, 11
 Dec 2023 15:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20231030175854.12675-1-rwahl@gmx.de> <CACRpkdZ2CXiNsnh_VxAy0OK+s_=cDqP8k0PVmNiL4QJ+mMZ+GQ@mail.gmail.com>
 <06e77692-4942-4657-9694-725d6de3e883@raritan.com>
In-Reply-To: <06e77692-4942-4657-9694-725d6de3e883@raritan.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Dec 2023 00:52:18 +0100
Message-ID: <CACRpkdaswYLf1bhbqhc+zvY+ak867BxpQeh=GMUoBtWR+s_Azg@mail.gmail.com>
Subject: Re: [PATCH] stacktrace: check whether task has a stack before saving it
To:     Ronald Wahl <ronald.wahl@raritan.com>
Cc:     Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 2:31=E2=80=AFPM Ronald Wahl <ronald.wahl@raritan.co=
m> wrote:

> On 01.11.23 22:59, Linus Walleij wrote:
> > [You don't often get email from linus.walleij@linaro.org. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Mon, Oct 30, 2023 at 6:59=E2=80=AFPM Ronald Wahl <rwahl@gmx.de> wrot=
e:
> >
> >> I encountered a crash on ARM32 when trying to dump the stack of some
> >> zombie process. This is caused by a missing check whether the task
> >> actually has a valid stack. This commit adds this check.
> >>
> >> Commit 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> >> introduced this check for platforms that define CONFIG_ARCH_STACKWALK
> >> but ARM32 is not one of them.
> >>
> >> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> >
> > Looks correct to me:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Unfortunately it causes a memory leak because I forgot to call
> put_task_stack(task) now. Should I post v2 or a separate patch?

Post a v2 I didn't see that anyone applied it?

Yours,
Linus Walleij
