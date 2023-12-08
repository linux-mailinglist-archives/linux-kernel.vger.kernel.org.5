Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B82809EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573374AbjLHIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjLHIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:53:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C61737
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:54:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso2619529a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20230601.gappssmtp.com; s=20230601; t=1702025639; x=1702630439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZznzSpsp3ftowq6O5Q/Cg5o9GO0Eay4RAUCcfPR/vuE=;
        b=AVhC9k83gKxJJxcAdzBoWahkcE4gAJu5o35ldYSxUWTwhNWFeCORdCVNbPnQNKiMtS
         L5j1HgpPnOg0r5fxmWG1MEoXLxY4rFiGt5r0pHhkpSOWxav1ejVsu33AJmAIrNPP2Rw/
         NHcgqu6DXS8t5POAF6AtsGzoryUyItMEQ76kMibCHr/0zNSPaTRQsA598b65RaC6pJne
         JgOh33vJIZEjA7yD5+QeD2AeQwfK3YAGwVlKYvRzAx0x7BJ/Iu+2rvd+6yJtNLJI86za
         KDk7Xgt2NLPxGh4bd2Q+UL8KjFquxxuqhgK8XsdohDnhWEPXITQ/1f7bV4wIor8mQ5Ud
         eJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702025639; x=1702630439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZznzSpsp3ftowq6O5Q/Cg5o9GO0Eay4RAUCcfPR/vuE=;
        b=WQY9fXsgDCBcqJRY0vj2r8QJq/OlZZhL0Mi2tgU8cNux+3Hl3pZFsAiIi6+7qFHopd
         AsldCPhCF3aeMWrO8e8s0coNTvbq+sDlFd+hvGfylX4ymi4yfkLtX5SLy/fhavRwBSnX
         SfRWWMMxeHS4EkiQOhe9moDvXvMbMV3ROtBPI/cl+LD1+HRNYnZgeVsStn7/vgzG79/C
         6ciS2eF86GrjklnSPplhzTzBZRLV7k88jYUIfD2+cu0wIpYwj86U0M8x2p1Xyq470pQu
         xJQ+P5qRKURTALpirKCadJw5gFANT8t+gPsXGPFtZwIgAYGt3JzsSnkyq03GtgCNVOJh
         +yxQ==
X-Gm-Message-State: AOJu0YxvoKXTquhIG3KUKqpEMVPJFSLGaUp2wL3U6SSyGop97SESl5+B
        W7/qIk0ATtmrYCNK/T6Qz36lyqGW/XwkkpPHyCOFGA==
X-Google-Smtp-Source: AGHT+IG6wWYNBrrrHbbpkx0reOlvqmH2SLrfVA+FsX8/gXSUGmBCwnqS4MaSnlIwYSWUKYoWn9oTxFidRIiBD1QBaxM=
X-Received: by 2002:a50:a6d6:0:b0:54c:4837:9a9f with SMTP id
 f22-20020a50a6d6000000b0054c48379a9fmr2315391edc.70.1702025638968; Fri, 08
 Dec 2023 00:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20231207082200.16388-1-jensenhuang@friendlyarm.com>
 <ebf6cf8ec3b5befd673d295061fa2738@manjaro.org> <CAMpZ1qHUnTDQ78gdrQF9Sx_-XfLM-B+H-0bL1-+twKsno+JOvg@mail.gmail.com>
 <5e11553952c02ad20591992be4284bbd@manjaro.org> <95cc7716-ba01-e239-e7c0-eba0b7da7955@collabora.com>
In-Reply-To: <95cc7716-ba01-e239-e7c0-eba0b7da7955@collabora.com>
From:   Jensen Huang <jensenhuang@friendlyarm.com>
Date:   Fri, 8 Dec 2023 16:53:47 +0800
Message-ID: <CAMpZ1qENxWsDnvke4jMvK9tYpta3dThHUHxjDWO-u2JV+8dZdQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix potential spinlock recursion on poll
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Dragan Simic <dsimic@manjaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>,
        Benjamin Bara <bbara93@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 12:00=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/7/23 17:10, Dragan Simic wrote:
> > On 2023-12-07 10:25, Jensen Huang wrote:
> >> On Thu, Dec 7, 2023 at 4:37=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g> wrote:
> >>>
> >>> On 2023-12-07 09:21, Jensen Huang wrote:
> >>> > Possible deadlock scenario (on reboot):
> >>> > rk3x_i2c_xfer_common(polling)
> >>> >     -> rk3x_i2c_wait_xfer_poll()
> >>> >         -> rk3x_i2c_irq(0, i2c);
> >>> >             --> spin_lock(&i2c->lock);
> >>> >             ...
> >>> >         <rk3x i2c interrupt>
> >>> >         -> rk3x_i2c_irq(0, i2c);
> >>> >             --> spin_lock(&i2c->lock); (deadlock here)
> >>> >
> >>> > Store the IRQ number and disable/enable it around the polling
> >>> transfer.
> >>> > This patch has been tested on NanoPC-T4.
> >>>
> >>> In case you haven't already seen the related discussion linked below,
> >>> please have a look.  I also added more people to the list of recipien=
ts,
> >>> in an attempt to make everyone aware of the different approaches to
> >>> solving this issue.
> >>>
> >>> https://lore.kernel.org/all/655177f4.050a0220.d85c9.3ba0@mx.google.co=
m/T/#m6fc9c214452fec6681843e7f455978c35c6f6c8b
> >>
> >> Thank you for providing the information. I hadn't seen this link befor=
e.
> >> After carefully looking into the related discussion, it appears that
> >> Dmitry Osipenko is already working on a suitable patch. To avoid
> >> duplication
> >> or conflicts, my patch can be discarded.
> >
> > Thank you for responding so quickly.  Perhaps it would be best to hear
> > from Dmitry as well, before discarding anything.  It's been a while
> > since Dmitry wrote about working on the patch, so he might have
> > abandoned it.
>
> This patch is okay. In general, will be better to have IRQ disabled by
> default like I did in my variant, it should allow to remove the spinlock
> entirely. Of course this also can be done later on in a follow up
> patches. Jensen, feel free to use my variant of the patch, add my
> s-o-b+co-developed tags to the commit msg if you'll do. Otherwise I'll
> be able to send my patch next week.

Thank you for the suggestion. I've updated the patch to your variant, and
as confirmed by others, reboots are functioning correctly. I measured the
overhead of enable_irq/disable_irq() by calculating ktime in the
updated version,
and on rk3399, the minimum delta I observed was 291/875 ns. This extra
cost may impact most interrupt-based transfers. Therefore, I personally lea=
n
towards the current v2 patch and handle the spinlock and irqsave/restore in
a follow up patch. I'd like to hear everyone's thoughts on this.

--
Best regards,
Jensen
