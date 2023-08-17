Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10D77EFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbjHQEPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjHQEPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:15:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AAF272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:15:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso111732121fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692245707; x=1692850507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJwuOsTK3sByAveo854/H3uTjZu90bP3iS3tjZpJLO4=;
        b=Nx1xwcyxQysILJtRYD8MLYDFaFCrC30qP5U8HPCYmBcrctvJQCkAXq75gDcyVsl7Mt
         UIsLwAa4nxpzPJp1AW6Lw4unJvnmndg1B+vdUntZvl1f85BS9oaZrx0mcg47BViDsDaB
         EvB1DxBx+8KlmiBG/p7E0viHi/uLJ4LsngZYz8RgxJTBAlXGJaNqBXKCS2WgWa1/AVx3
         t/GlPHB8qCJKkso4dQORN6uFeqCTA69MbayfOYyrQDeyKof4Zl0OvBarx27ghYaVtj6d
         G5vYpKi3By5nmdK7t1W/fouL9UwbdaP7D90OMpNxjEVe7U0Gl0vIWirM1NagDYB2wJRh
         V+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245707; x=1692850507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJwuOsTK3sByAveo854/H3uTjZu90bP3iS3tjZpJLO4=;
        b=ab8OkSeatO50sQXzqWdbFrc/6hfmc9NeCqYSOS2Cjltlo5V0J4VfEOUm+i3PogVt4P
         d6gmerCENsK7aO5hAhQa5DaavJm9/rESquiGYSuETr27NtlV1hrrD/PGFuXWGsDFC6El
         Tl3kdZSps3pqaCmwrLkMhw/FH5hFoz9cswB4inZE+uqQkf8yHIB2Vq/YAoL0/UDmM5h2
         QrLnMOCbW3YtG97imK4mju3FQFUdAs3Zjtrb/5bXp01pq8GsmQyBwi0Ai9pY5C5vogQd
         vbfB6RdKLhqjlF+2TGKKWQpq3VsWtWHJzpSt304Wjm1Xz0BRVXFSzJqFlJAs8JFrsWoV
         I5GQ==
X-Gm-Message-State: AOJu0Yx8nTQ8o2EcjEgnWheK/oIrIYKk0UIoH2hlJya2n+sUo1G6dFfS
        KgRVAn4A21SMuG52RwAmOn2LEKDCEEH4Lz+Hmzo=
X-Google-Smtp-Source: AGHT+IGJm3uKR6Ak9ukkxrm1VoJSNr94nLN7RzAjaiUe40omr7HQZWealVv+do/pal+Z1iI8CmHcSwI2IsSo3jjPULc=
X-Received: by 2002:a2e:854f:0:b0:2bb:a6b0:cf66 with SMTP id
 u15-20020a2e854f000000b002bba6b0cf66mr324290ljj.2.1692245707051; Wed, 16 Aug
 2023 21:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
 <ZNuDxFGoXPCwECyt@alley> <CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com>
 <ZNyXdDlruiQAQeMl@alley>
In-Reply-To: <ZNyXdDlruiQAQeMl@alley>
From:   Enlin Mu <enlinmu@gmail.com>
Date:   Thu, 17 Aug 2023 12:14:40 +0800
Message-ID: <CAAfh-jPyt3GJ4UcxDge-K8dwaKxy2KUUYyrX1mJ_diJhCoWxtA@mail.gmail.com>
Subject: Re: [PATCH] printk: export symbols for debug modules
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        yunlong.xing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8816=E6=97=A5=
=E5=91=A8=E4=B8=89 17:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed 2023-08-16 09:24:29, Enlin Mu wrote:
> > Petr Mladek <pmladek@suse.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C 21:55=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue 2023-08-15 10:07:11, Yunlong Xing wrote:
> > > > From: Enlin Mu <enlin.mu@unisoc.com>
> > > >
> > > > the module is out-of-tree, it saves kernel logs when panic
> > > >
> > > > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > >
> > > I am fine with it. After all, this API seems to here for
> > > similar purposes.
> > Thanks.
> > >
> > > Acked-by: Petr Mladek <pmladek@suse.com>
> > >
> > > Of course, it would be better to maintain the module in upstream.
> > > Is there any chance to get it upstream? It seems that it
> > > is GPL-compatible so...
> > Yes, currently under development. Once the code debugging is stable,
> > it will be pushed to the community.
>
> Great.
>
> One more thing which came to my mind.
>
> The log buffer contains the plain text and "id" of the related
> metadata. Namely, there is always an "unsigned long" before
> each message, see struct prb_data_block.
>
> You might consider using the kmsg_dump API. It has been added
> for this purpose. It allows to read and store the messages
> one by one. And the messages are formatted the same way
> as on console or by dmesg.
>
> The registered dumpers are automatically called in panic().
> See kmsg_dump(KMSG_DUMP_PANIC) in panic().
Yes, I have use this API in panic.

But there is a special case where when the system hangs and all cores
are unable to execute panic processes, this API  cannot be used
anymore.

When this module starts, it obtains the virtual address of the log,
converts it into a physical one, and saves it to the specified
address. When uboot starts, obtain the above information, extract the
kernel log, and debug the cause of the exception.

>
> There are few users of this API. Look for kmsg_dump_register()
> to get some inspiration.
>
> Best Regards,
> Petr

Best Regards,
Enlin
