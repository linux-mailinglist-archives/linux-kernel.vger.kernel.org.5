Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25480053A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377799AbjLAIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:12:29 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA310FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:12:35 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d3c7ef7b31so10107057b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701418354; x=1702023154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdvsQHdGEAuuclK6zWCzDyAl0EoztStbQelKo58kDz0=;
        b=k5MkWUh/HYplVB1eXHbuR1ugWGogKPBO5ve0En2N63DR5tuaZBdgku+WYxMBn25SOo
         GH7Ng+rokZyOpOPYr0WNp4K5bjPPwjCrAt5neJaEMyY2xHiXdd+tyKGHqzjQwKq2bkaD
         lll04PhM0aTCHATSR93brkbfl08NlEK3boxxAuyagGlZezxTgI/qRZ3jCzhj4YvOorkG
         D7MqJTQtf4xN6o1h/Kl6sR5SWjBFYpr0oyN1651UeCLRf3SzJQmW43VEB7cErMMzFhfP
         ycds+oiFw43uAqt8UN6DsUnKhI+dZ5hiYpFAbEPUMsPEAyedCqZAZrHiqjUMHHQ1pYS8
         vGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418354; x=1702023154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdvsQHdGEAuuclK6zWCzDyAl0EoztStbQelKo58kDz0=;
        b=vAmXbTIB9cPiGQKmrGOXrX0EGEaVBcAJlJ/yXQ5mmURlSFUcgeCLCHKU2i1fFTfEcA
         W2fQw5SU/3CvWw5EwPp9JLStqqaJCpMOE49u4YFv1JLpMlN+fN+YX58EIq65iviwpjbn
         OrwM6j6PkOBBjlDT+4ZlxUdx9tPxrLnEQL3F9HBc6/Y/0YqTgd/F47oKo/3v7Z/nzZvp
         Lh+K4AJwyUHvnpjwCzQY+KXAJ4dB3dZtKc0CHTlA0v6dYdANs/XaSFsJIIoTsqr0oVEE
         DxnME3BHToZZfi+DzqaU77e73O/3930eKOCj4UHdk0Aij3IxoduO8D0M56Gt+ijWpVws
         QfdQ==
X-Gm-Message-State: AOJu0YwnGOTalZa5mOVn/hE1eOuPDckm5IL7AItdB542Oe49ncWmL9lH
        ekb3mRIrddjjbY5Xfs575Oq7p3urJfj/f0ZXPSVI3w==
X-Google-Smtp-Source: AGHT+IGa5T6HzropwLFep5/pv4O5sxFiHTP5u7bGw9MNJTlkd1MDfLy5QHsnEqIFk0oCja7Ap/Pz6/cjf7dQxlf2zsM=
X-Received: by 2002:a81:ac06:0:b0:5d3:b982:57ae with SMTP id
 k6-20020a81ac06000000b005d3b98257aemr2410625ywh.4.1701418354673; Fri, 01 Dec
 2023 00:12:34 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
 <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
 <CACRpkdZRf7bNVmJCgsVD0uheD1VLkLKG13d1oS-kbT8BFyRKQw@mail.gmail.com>
 <e703c87e-32b9-4dce-b232-89c0e909c35e@quicinc.com> <CACRpkdZtCxwLZCY4autrTvonmZ3XcVzH6iXqXanS97VKCZ+ERw@mail.gmail.com>
In-Reply-To: <CACRpkdZtCxwLZCY4autrTvonmZ3XcVzH6iXqXanS97VKCZ+ERw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Dec 2023 09:12:23 +0100
Message-ID: <CACRpkdYcPBSp-XGXr=3a+AGOVVVHQoaciSgAUuJS+=3ScGWcSg@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fixes for v6.7
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
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

On Fri, Dec 1, 2023 at 9:10=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:

> Hi Nathan, Nick,
>
> (just picking some LLVM compiler people I know of... and trust)

Forget that part of the mail, written out-of-context when I was
running different
disassembly of GCC vs LLVM code. I figured it out and concluded that
the compilers
are fine and doing the right thing, it's a none-issue in that regard.

Yours,
Linus Walleij
