Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0A76182E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjGYMYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjGYMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:24:30 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D44A7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:24:29 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55e04a83465so3372255eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690287869; x=1690892669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kve4jx7ReQhde16/FoVsZesS8+jqJSZYCG0fCxTXQe4=;
        b=BUdASDm4L7I/nH/6P2GFYDldc2V0L+IaPrx6emzWG24NRr/q9OznBLL35DpATeow6L
         KEdMaM2LBeLnVEiQlePKzhiI1ytvaE0fKbbYO62ajQXlGsgh6Z2C3J3dONoC5SXBByNN
         APW1HMTjKoYv/Yi5UCuVoxz1rtw7l6rmdlnj+d+FhfzjKiDeWllN8LlGIFcPYmwjw4Gi
         bC4KlmXRqgGWERrWVXMQknfyW/y8+YaBsR7oEJuanfa4S+g9UkWmN/CriluOY1A5Ej+A
         KsO92xZhbl1NmyVTO2GmUjMec+KcoE9p6P8PNOKOuSqgrrc1e9ZpyRb1+kO/L/MJzrA0
         nCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287869; x=1690892669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kve4jx7ReQhde16/FoVsZesS8+jqJSZYCG0fCxTXQe4=;
        b=aefoJYwo3AzQ+sukFxyj83ir4BzAgWl3psCZYFhjOgon+n4AsrKtzBb0Y56/jPWnMC
         S/HXI8AfIx53LAxKNhZ2/nwtrUmWBVlwiSwkzoqXF8++Brd3ZaNqa2XAQFFk57NETB/l
         ED1Ah6WlazZ8hiBDL1l2VyjAi5CYRANXXor73lVfy4fNyqnQZRP5rlq6tDyZCbQyKTIQ
         Zknn0WmSTP6xspRrWAJDuphfIKmP2W3QMaLWGAR2fVCpacHVhnIZy/sQMou5RgjcxH3E
         J2SR3wsEZYZAyjp6p4Z5cYaAJW6qI928JVMpqvovjAebk8nluP0FYNlb9krRWvPZqGRl
         1RzA==
X-Gm-Message-State: ABy/qLZYG3K7nwnT5ORYn0YTQyEsteSaBfOHcC8Kti7KRgXxGBV+LN5Y
        ZAj4kI51xwA8+jhB09spBABg7KWdmqkODGMN02k=
X-Google-Smtp-Source: APBJJlG3A+jKNwnMLaIZg8XIsbVbDClcZ+SMnUBZMBXtHKypLM9zYROjU/6cE8bwVSEDNErCj/cXYWZbNfgOAlDTArI=
X-Received: by 2002:a4a:760b:0:b0:566:f0ee:1d9e with SMTP id
 t11-20020a4a760b000000b00566f0ee1d9emr10345927ooc.5.1690287869256; Tue, 25
 Jul 2023 05:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230713071713.5762-1-xuewen.yan@unisoc.com> <20230725-hemmschwelle-braten-481527898001@brauner>
In-Reply-To: <20230725-hemmschwelle-braten-481527898001@brauner>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 25 Jul 2023 20:24:18 +0800
Message-ID: <CAB8ipk9CXWmUg13gEHDECXf3DDUvbYyA0y2yFXUuGsAjMSXv8w@mail.gmail.com>
Subject: Re: [PATCH] pid: Add the judgment of whether ns is NULL in the find_pid_ns
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
        keescook@chromium.org, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 4:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jul 13, 2023 at 03:17:13PM +0800, Xuewen Yan wrote:
> > There is no the judgment of whether namspace is NULL in find_pid_ns.
> > But there is a corner case when ns is null, for example: if user
> > call find_get_pid when current is in exiting, the following stack would
> > set thread_id be null:
> > release_task
> >     __exit_signal(p);
> >         __unhash_process(tsk, group_dead);
> >               detach_pid(p, PIDTYPE_PID);
> >                   __change_pid(task, type, NULL);
> >
> > If user call find_get_pid at now, in find_vpid function, the
>
> I fail to see how this can happen. The code you're referencing is in
> release_task(). If current has gone through that then current obviously
> can't call find_vpid() on itself anymore or anything else for that
> matter.

This happened when user calls  find_vpid() in irq.

[72117.635162] Call trace:
[72117.635595]  idr_find+0xc/0x24
[72117.636103]  find_get_pid+0x40/0x68
[72117.636812]  send_event+0x88/0x180 [demux]
[72117.637593]  vbvop_copy_data+0x150/0x344 [demux]
[72117.638434]  dmisr_video_parsing_mpeg12+0x29c/0x42c [demux]
[72117.639393]  dmisr_video_parsing_switch+0x68/0xec [demux]
[72117.640332]  dmisr_handle_video_pes+0x10c/0x26c [demux]
[72117.641108]  tasklet_action_common+0x130/0x224
[72117.641784]  tasklet_action+0x28/0x34
[72117.642366]  __do_softirq+0x128/0x4dc
[72117.642944]  irq_exit+0xf8/0xfc
[72117.643459]  __handle_domain_irq+0xb0/0x108
[72117.644102]  gic_handle_irq+0x6c/0x124
[72117.644691]  el1_irq+0x108/0x200
[72117.645217]  _raw_write_unlock_irq+0x2c/0x5c
[72117.645870]  release_task+0x144/0x1ac   <<<<<<
[72117.646447]  do_exit+0x524/0x94c
[72117.646970]  __do_sys_exit_group+0x0/0x14
[72117.647591]  do_group_exit+0x0/0xa0
[72117.648146]  __se_sys_exit+0x0/0x20
[72117.648704]  el0_svc_common+0xcc/0x1bc
[72117.649292]  el0_svc_handler+0x2c/0x3c
[72117.649881]  el0_svc+0x8/0xc

In release_task, write_unlock_irq(&tasklist_lock) will open irq, at
this time, if user calls find_get_pid() in irq, because
current->thread_id is NULL,
it will handle the NULL pointer.

BR
---
xuewen
