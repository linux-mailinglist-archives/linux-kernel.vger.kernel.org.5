Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC27FE231
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjK2Vnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2Vnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:43:49 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5F10CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:43:55 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so205338276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701294234; x=1701899034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHvHwF4r0ol/6A89XHXlGqO8DIoBfroEzsFv3QQWhuM=;
        b=W4Pbi6uSQEuQOfFFuF9/mB+5JBIPr4eg3fOgNNJrn3c0nDFXZiSg8OvCj6qRi+c3gw
         gopuIwuty5dCZgzlXY7lJoyoPU1mfi1+xgf0R5jNhVswWRi0gkyW8OF0SyYRQUlSWow8
         wpwzuY8uc21udT+72MsMGaxHW90YwpLJ+6PJgsQ58ZMuu2cNb69F4Pj5Px0J/Lo5RFnc
         NZb0HWRHx4PO2DL518w/KcMaLydL9hqUhzraYNyX1qR+AjcsbJ4c2BtP22Tu99hOs1Mt
         SrW9wXlF5oZ676oBnom+74zso5IaC7K0uNHNu1HlVoSRCUPHOUhbJXsGN11HuuxvklCj
         OrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294234; x=1701899034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHvHwF4r0ol/6A89XHXlGqO8DIoBfroEzsFv3QQWhuM=;
        b=vRwBmDBT7+PWJqlYrWzHVzNbZ4Ckf4gEzbFMNxmgRTSFS7z9owoC9isUR9Hjhfb0Yo
         2tttbSlO92iwF8qZSOefURNejufwar2i8tyEX8WK1Cxx/lrcOyqOHV1c+ECbvqZu618g
         JeffBJgLuZEVvT4Lm2JBF9fa4q0/IMHaE72Nahs1iTqpnjKUy2yyJCjvCtHW9WwWRbGe
         MRE7kiPjf4H/q2SS1ksbSoOAw8mwHDufNBzQ1kQ/Ewgap4D9B7WdVi1x7EjBv8NGPp6I
         64WKz0YqP4w22HO0R8LgHb/8xUFqzRykDCesXyV5922lX8zjpCuYkBDXssM1IAV4ipOg
         xtMA==
X-Gm-Message-State: AOJu0YxEmmuUoZO6ssIJV74HjBrFWM8HLe3t08CiQiYyg/qRBtm9PDyh
        /Zg2cfAjTT/lcO8g4agpOL31Cq4HLvYiWzRxa2rvrLrNO8Q4UeTn
X-Google-Smtp-Source: AGHT+IE6hT3lAdjiLDM2v/jobqD/zOiK/jGYz0PHMZqE8j4h+LgkMHS0A8fLarjbXtR4/nzEpRE9D4seIrBcQcc99Ws=
X-Received: by 2002:a25:820b:0:b0:db0:2161:5950 with SMTP id
 q11-20020a25820b000000b00db021615950mr18519105ybk.63.1701294234500; Wed, 29
 Nov 2023 13:43:54 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb8dwq7OYUFuyjJCv7VN9mH1zEmibcOwgFip0wDv5H1gA@mail.gmail.com>
 <CAHk-=whZj3WZezdj8wq6thUeRfzua2y2QsrnoPG9dqfmk-=rcw@mail.gmail.com>
In-Reply-To: <CAHk-=whZj3WZezdj8wq6thUeRfzua2y2QsrnoPG9dqfmk-=rcw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 22:43:43 +0100
Message-ID: <CACRpkdbSxTDo4dDeJ_jdjVmX1Fwso7rXXGs53bdqa835yprVJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fixes for v6.7 minus one patch
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Maria Yu <quic_aiquny@quicinc.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
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

On Wed, Nov 29, 2023 at 4:48=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 29 Nov 2023 at 07:18, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > Here is an updated tag on a branch where the only change
> > is to drop the locking READ_ONCE() patch until we know
> > more about what is going on here.
>
> Bah. I already pulled the previous one and pushed out before reading
> more emails and noticing you had so quickly re-done it.
>
> So the READ_ONCE() workaround is there now, but I hope there will be a
> future patch that explains (and fixes) whatever made the value change
> from underneath that code.

Fair enough, we'll look closer at it. I just hope I get some help with
that from Maria.

Yours,
Linus Walleij
