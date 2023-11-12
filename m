Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471F7E9190
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjKLPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKLPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:51:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3422D46
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:51:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f613275so29550085e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1699804278; x=1700409078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06FGZWGUBCJOABY8OhfcQeWfBbAdPr3WTfWSMv9j+Xs=;
        b=NZpnxj4b6aIC1LnVCsaASKH7F1nP+3ZdxuMOi+D2bNoDw0l/xeEpDUNIF2vr9nqSdP
         0mAwTf9SGEbIKqcHa9WndYfBFpiP2M9fHBHQK3BuFChUlda3CEgZOaqJeSoW864UKu1k
         BsxDmYLPJmH0GIntELpyZIkcJzQ7G673tqLsGP6fHV+ALk0xzGpMOk/f9kuls/mtbEFr
         AH7FBkEkvhvRe0qxLo/E2SLx37k1nUaBCZyNpWbrRnCYD71eJie+QtcNEo1jXm7c7/ce
         Pl736F0R59W2zcPtXl1OEDC3uZfFYbGLtXeZBuHD2ct8m+TeDk+fXyfKmldSm7JnpDMe
         M+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699804278; x=1700409078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06FGZWGUBCJOABY8OhfcQeWfBbAdPr3WTfWSMv9j+Xs=;
        b=vGsJGkGNIcIcdG9lowB4O7e/+CtOuM44o5qD8wMYQubZoZNVl0fkaTEorsR8NF35sq
         JywgTcCtKr/ZCWPVSaiLEIuxoJRae24+f7tlbZl0sC1b4CSLwawsQpGkL+8lQvydwcFQ
         Epdx2lMfLgRsV2JxaQWgYNx1keAQzNeD4/yn2Is6C4LgBwXLXbgf+vyCi6HeTt2VlyMp
         4l932oxLtdpvS4a6gMjK5AGpn5wYVpb3t8ypkHjmzMqCEXvo5MwYBQeVAMJ5Ox2Ffryx
         7rdRAiGLsZXYCObv0VgaNogoeOMWkUF6vAsV8mJuId6FMb8SpfAh5dm63iSgHH0Ac0QO
         wf2Q==
X-Gm-Message-State: AOJu0YwfmJonrVnhDhux8gYqsk6VaceV1m0MQ/SLO7KpmtF5QcZYK5LK
        WQx3prXo2RihDHzUuORreYzjXV+SRi4EvCAIumCyww==
X-Google-Smtp-Source: AGHT+IH655xfKIRArLgTo/emHQxkrBk5h0lVZ/QPaWgFBoXCKhuqJWeFEgT+w8xdiOqxPnWZcCILNf27KInac22sjaM=
X-Received: by 2002:a05:600c:35c2:b0:408:80bb:ae80 with SMTP id
 r2-20020a05600c35c200b0040880bbae80mr3996599wmq.7.1699804278030; Sun, 12 Nov
 2023 07:51:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
 <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com> <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
In-Reply-To: <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 12 Nov 2023 07:51:08 -0800
Message-ID: <CAAYoRsXvKwhrw3gRQJ-STO48_7yxEiqwt5tgzDbkzA--N_XX6A@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7 (with signed tag)
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
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

On Fri, Nov 10, 2023 at 7:39=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
...
>
> (Same code as previous pull request, with addition of a signed tag.
>  Hopefully it verifies okay at your end.)
>
> Turbostat features are now table-driven (Rui Zhang)
> Add support for some new platforms (Sumeet Pawnikar, Rui Zhang)
> Gracefully run in configs when CPUs are limited (Rui Zhang, Srinivas Pand=
ruvada)
> misc minor fixes.

Hi Len,
What about the patches that have been submitted since your last turbostat u=
pdate
release of 2023.03.17? I submitted one on 2023.04.03. I haven't sent "RESEN=
D"s,
because I know you only do update releases every 1/2 year or so, and in the=
 past
you have always dealt with the interim patches then.

Reference:
https://patchwork.kernel.org/project/linux-pm/list/?series=3D&submitter=3D&=
state=3D&q=3D&archive=3D&delegate=3D107

... Doug

>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
... [deleted]...
